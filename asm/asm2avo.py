"""
Hacky, incomplete script for translating clang AT&T assembly into Avo instructions.
python asm2avo.py --help

- Function names can't be mangled and must end with return type:
    _I: int, _B: bool, _F: float32, _D: float64, _V: void
- Data segments not supported, add manually & make loads unaligned
- Last argument is used to pass length of first slice
- Mostly tested on clang 15 output from godbolt
"""
import re
import sys
from copy import deepcopy
from dataclasses import dataclass
from typing import List, Union, Optional

from parsimonious.grammar import Grammar
from parsimonious.nodes import NodeVisitor

grammar = Grammar(
    r"""
    program     = (signature / label / instruction / skip)*
    signature   = identifier "(" (type ("," nbws type)*)? "):" skip
    label       = identifier ":" skip
    instruction = identifier nbws (arg ("," nbws arg)*)? skip

    arg         = imm / reg / hex / string / mem / labelref
    imm         = "$" (integer / hex)
    reg         = "%" identifier
    hex         = ~"0x[0-9a-f]+"
    string      = ~"\"[^\"]*\""
    mem         = (integer / labelref)? "(" reg ("," nbws reg ("," nbws integer)?)? ")"
    labelref    = identifier ""

    integer     = ~"-?[0-9]+"
    identifier  = ~"[a-zA-Z0-9_.]+"
    type        = ("double" / "float" / "bool" / "char" / "int" / "unsigned int" / "long" / "unsigned long" / "void") (nbws "*")?
    ws          = ~"\s*" 
    nbws        = ~"[^\S\r\n]*"
    comment     = ~"#[^\r\n]*"
    skip        = (ws comment?)*
    """
)

# fmt: off

@dataclass
class CType:
    name: str
    pointer: bool

@dataclass
class Imm:
    value: str

@dataclass
class Hex:
    value: str

@dataclass
class String:
    value: str

@dataclass
class Identifier:
    value: str

@dataclass
class Reg:
    value: str

@dataclass
class LabelRef:
    value: str

@dataclass
class Mem:
    base: Reg
    index: Optional[Reg]
    scale: Optional[int]
    offset: Optional[Union[LabelRef, int]]

@dataclass
class Signature:
    fn_name: str
    ret_type: CType
    arg_types: List[CType]

@dataclass
class Label:
    name: str

@dataclass
class Instruction:
    op: str
    args: List[Union[Imm, Hex, String, Reg, Mem, LabelRef]]

@dataclass
class Program:
    statements: List[Union[Signature, Label, Instruction]]

# fmt: on


class AstBuilder(NodeVisitor):

    # top level statements

    def visit_program(self, node, visited_children):
        return Program(statements=[s[0] for s in visited_children if s[0] is not None])

    def visit_signature(self, node, visited_children):
        fn_name = visited_children[0].value
        if fn_name[-2:] not in ["_I", "_B", "_F", "_D", "_V"]:
            sys.exit("Function name must end in _I, _B, _F, _D or _V return type")
        ret_type = {
            "_I": CType("long", False),
            "_B": CType("bool", False),
            "_F": CType("float", False),
            "_D": CType("double", False),
            "_V": CType("void", False),
        }[fn_name[-2:]]
        arg_types = AstBuilder.collect_types(visited_children, [CType])
        return Signature(fn_name=fn_name[:-2], ret_type=ret_type, arg_types=arg_types)

    def visit_label(self, node, visited_children):
        return Label(name=visited_children[0].value)

    def visit_instruction(self, node, visited_children):
        valid_args = (Imm, Hex, String, Reg, Mem, LabelRef)
        op = visited_children[0].value.upper()
        args = AstBuilder.collect_types(visited_children, valid_args)
        return Instruction(op=op, args=args)

    def visit_skip(self, node, visited_children):
        return None

    # instruction args

    def visit_arg(self, node, visited_children):
        return visited_children[0]

    def visit_imm(self, node, visited_children):
        return Imm(value=node.text[1:])

    def visit_reg(self, node, visited_children):
        return Reg(value=node.text[1:].upper())

    def visit_hex(self, node, visited_children):
        return Hex(value=node.text)

    def visit_string(self, node, visited_children):
        return String(value=node.text[1:-1])

    def visit_mem(self, node, visited_children):
        args = AstBuilder.collect_types(visited_children, [int, LabelRef, Reg])
        if isinstance(args[0], Reg):
            args.insert(0, None)
        return Mem(
            offset=args[0],
            base=args[1],
            index=args[2] if len(args) > 2 else None,
            scale=args[3] if len(args) > 3 else 1 if len(args) > 2 else None,
        )

    def visit_labelref(self, node, visited_children):
        return LabelRef(value=node.text)

    # leaves

    def visit_integer(self, node, visited_children):
        return int(node.text)

    def visit_identifier(self, node, visited_children):
        return Identifier(value=node.text)

    def visit_type(self, node, visited_children):
        return CType(
            name=visited_children[0][0],
            pointer=node.text[-1] == "*",
        )

    def generic_visit(self, node, visited_children):
        return visited_children or node.text

    @staticmethod
    def collect_types(lst, types):
        ret = []
        if isinstance(lst, tuple(types)):
            ret.append(lst)
        elif isinstance(lst, list):
            for e in lst:
                ret += AstBuilder.collect_types(e, types)
        return ret


class Generator:
    def __init__(self, out=sys.stdout):
        self.indent = 0
        self.out = out

    def generate(self, ast):
        method_name = "generate_" + type(ast).__name__.lower()
        getattr(self, method_name, self.default)(ast)

    def default(self, ast):
        self.writeln(f"// FIXME (unhandled): {ast}")

    def write(self, s, indent=None):
        self.out.write(
            "{}{}".format("\t" * (self.indent if indent is None else indent), s)
        )

    def writeln(self, s, indent=None):
        self.write(s + "\n", indent=indent)


class AvoGenerator(Generator):
    def __init__(self, *args, suffix=None, **kwargs):
        super().__init__(*args, **kwargs)
        self.suffix = suffix
        self.current_fn = None
        self.current_label = None
        self.ret_register = None

    def generate_program(self, ast: Program):
        for stmt in ast.statements:
            self.generate(stmt)
        self.close_label()
        self.close_fn()

    def generate_signature(self, ast: Signature):
        self.close_label()
        self.close_fn()
        self.open_fn(ast.fn_name)

        def go_type_name(ctype: CType):
            slice = "[]" if ctype.pointer else ""
            if ctype.name in ["int", "unsigned int", "long", "unsigned long"]:
                return slice + "int"
            if ctype.name in ["char", "unsigned char"]:
                return slice + "byte"
            if ctype.name in ["bool"]:
                return slice + "bool"
            if ctype.name == "double":
                return slice + "float64"
            if ctype.name == "float":
                return slice + "float32"
            if ctype.name == "void":
                return "uintptr" if ctype.pointer else "void"
            sys.exit(f"Unexpected type {ctype}")

        go_ret_type = go_type_name(ast.ret_type)
        if ast.ret_type.pointer or go_ret_type in ["bool", "byte", "int", "uintptr"]:
            self.ret_register = "RAX"
        elif go_ret_type in ["float32", "float64"]:
            self.ret_register = "X0"
        else:
            self.ret_register = None

        go_types = [go_type_name(t) for t in ast.arg_types]
        has_len_param = "[]" in "".join(go_types) and go_types[-1:] == ["int"]
        if has_len_param:
            go_types = go_types[:-1]

        ip_regs = ["R9", "R8", "RCX", "RDX", "RSI", "RDI"]
        fd_regs = ["X5", "X4", "X3", "X2", "X1", "X0"]
        scalars = ["f", "e", "d", "c", "b", "a"]
        vectors = ["w", "v", "u", "z", "y", "x"]
        params = []  # [('name', 'type', 'reg')..]
        for t in go_types:
            name = vectors.pop() if ("[]" in t) else scalars.pop()
            reg = fd_regs.pop() if ("float" in t and "[]" not in t) else ip_regs.pop()
            params.append((name, t, reg))

        self.write(f'TEXT("{self.add_suffix(ast.fn_name)}", NOSPLIT, "func(')
        prev_type = None
        for i, (name, t, reg) in enumerate(params):
            if i != 0:
                if prev_type != t:
                    self.write(" " + prev_type + ", ", indent=0)
                else:
                    self.write(", ", indent=0)
            self.write(name, indent=0)
            prev_type = t
        if prev_type is not None:
            self.write(" " + prev_type, indent=0)
        self.write(
            f"){(' '+go_ret_type) if go_ret_type != 'void' else ''}\")\n", indent=0
        )
        self.writeln('Pragma("noescape")')

        for (name, t, reg) in params:
            base = ".Base()" if "[]" in t else ""
            self.writeln(f'Load(Param("{name}"){base}, {reg})')
        if has_len_param:
            name = next(p[0] for p in params if "[]" in p[1])
            self.writeln(f'Load(Param("{name}").Len(), {ip_regs.pop()})')
        self.writeln("")

    def generate_label(self, ast: Label):
        self.close_label()
        self.open_label(ast.name.replace(".", ""))

    def generate_instruction(self, ast: Instruction):
        ast = self.replace_instruction(ast)
        if ast.op.startswith("."):
            self.writeln(f"// FIXME (unsupported): {ast}")
            return
        if ast.op.startswith("RET") and self.ret_register is not None:
            self.writeln(f"Store({self.ret_register}, ReturnIndex(0))")
        self.write(f"{ast.op}(")
        for i, arg in enumerate(ast.args):
            if isinstance(arg, (Hex, String)):
                self.write(arg.value, indent=0)
            elif isinstance(arg, Imm):
                if arg.value.startswith("0x") or int(arg.value) >= 0:
                    self.write(f"Imm({arg.value})", indent=0)
                else:
                    self.write(f"I32({arg.value})", indent=0)
            else:
                self.generate(arg)
            if i != len(ast.args) - 1:
                self.write(", ", indent=0)
        self.writeln(")", indent=0)

    def generate_reg(self, ast: Reg):
        reg = ast.value
        if re.match(r"[XYZ]MM", reg):
            reg = reg[0] + reg[3:]
        if re.match(r"R\d+D$", reg):
            reg = reg[:-1] + "L"
        self.write(f"{reg}", indent=0)

    def generate_labelref(self, ast: LabelRef):
        self.write(f'LabelRef("{ast.value.replace(".", "")}")', indent=0)

    def generate_mem(self, ast: Mem):
        self.write(f"Mem{{Base: {ast.base.value}}}", indent=0)
        if ast.index is not None:
            self.write(f".Idx({ast.index.value}, {ast.scale})", indent=0)
        if ast.offset is not None:
            self.write(f".Offset({ast.offset})", indent=0)

    def open_fn(self, name):
        self.current_fn = name
        self.writeln("")
        self.writeln("func gen" + name + "() {\n")
        self.indent += 1

    def close_fn(self):
        if self.current_fn is not None:
            self.indent -= 1
            self.writeln("}")
            self.current_fn = None

    def open_label(self, name):
        self.current_label = name
        self.writeln("")
        self.writeln(f'Label("{name}")')
        self.writeln("{")
        self.indent += 1

    def close_label(self):
        if self.current_label is not None:
            self.indent -= 1
            self.writeln("}")
            self.current_label = None

    def add_suffix(self, name):
        m = re.match(r"(.*)_(F..)$", name)
        return (
            m.group(1) + "_" + self.suffix + "_" + m.group(2)
            if m and self.suffix
            else name
        )

    def replace_instruction(self, ast: Instruction):
        if ast.op.startswith("RET"):
            return Instruction(op="RET", args=[])
        if re.match(r"CMP[QBL]$", ast.op):
            return Instruction(op=ast.op, args=[ast.args[1], ast.args[0]])
        if re.match(r"VCVTTSD2SI$", ast.op) and ast.args[-1].value[0] == "R":
            return Instruction(op=ast.op + "Q", args=ast.args)
        if re.match(r"VCVTPD2PS$", ast.op) and ast.args[0].value[0] == "Y":
            return Instruction(op=ast.op + "Y", args=ast.args)
        if re.match(r"CLTQ$", ast.op):
            return Instruction(op="CDQE", args=ast.args)
        if re.match(r"MOVSLQ$", ast.op):
            return Instruction(op="MOVLQSX", args=ast.args)
        m = re.match(r"(VCVTSI2S[SD])(\w*)$", ast.op)
        if m and not m.group(2)[:1] in ["Q", "L"]:
            op = m.group(1) + "Q" + m.group(2)
            return Instruction(op=op, args=ast.args)
        m = re.match(r"CMOV([AB])([QL])$", ast.op)
        if m:
            cmp = {  # https://docs.oracle.com/cd/E19120-01/open.solaris/817-5477/6mkuavhs7/index.html
                "A": "GT",
                "B": "LT",
            }[
                m.group(1)
            ]
            return Instruction(op="CMOV" + m.group(2) + cmp, args=ast.args)
        m = re.match(r"VCMP(\w+?)(PD|PS|SD|SS)$", ast.op)
        if m:
            cmp = m.group(1)
            op = "VCMP" + m.group(2)
            imm = {  # https://www.felixcloutier.com/x86/cmppd.html
                "EQ": 0,
                "LT": 1,
                "LE": 2,
                "UNORD": 3,
                "NEQ": 4,
                "NLT": 5,
                "NLE": 6,
                "ORD": 7,
                "EQ_UQ": 8,
                "NGE": 9,
                "NGT": 10,
                "FALSE": 11,
                "NEQ_OQ": 12,
                "GE": 13,
                "GT": 14,
                "TRUE": 15,
                "EQ_OS": 16,
                "LT_OQ": 17,
                "LE_OQ": 18,
                "UNORD_S": 19,
                "NEQ_US": 20,
                "NLT_UQ": 21,
                "NLE_UQ": 22,
                "ORD_S": 23,
                "EQ_US": 24,
                "NGE_UQ": 25,
                "NGT_UQ": 26,
                "FALSE_OS": 27,
                "NEQ_OS": 28,
                "GE_OQ": 29,
                "GT_OQ": 30,
                "TRUE_US": 31,
            }[cmp]
            return Instruction(op=op, args=[Imm(value=str(imm))] + ast.args)
        return ast


def main():
    import argparse
    import pprint

    parser = argparse.ArgumentParser()
    parser.add_argument("file", help="input file, omit for stdin", nargs="?")
    parser.add_argument("--out", help="output to file", required=False)
    parser.add_argument("--suffix", help="add suffix to function names", required=False)
    parser.add_argument("--cst", help="print concrete syntax tree", action="store_true")
    parser.add_argument("--ast", help="print abstract syntax tree", action="store_true")
    parsed = parser.parse_args()

    inp = open(parsed.file, "r").read() if parsed.file else sys.stdin.read()
    cst = grammar.parse(inp)
    if parsed.cst:
        print(cst, "\n")
    ast = AstBuilder().visit(cst)
    if parsed.ast:
        pprint.pprint(ast, width=100)
    out = open(parsed.out, "w") if parsed.out else sys.stdout
    gen = AvoGenerator(out=out, suffix=parsed.suffix)
    gen.generate(ast)


if __name__ == "__main__":
    main()
