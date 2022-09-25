package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genNot() {
	data := GLOBL("dataNot", RODATA|NOPTR)
	DATA(0, U8(1))
	DATA(1, U8(1))
	DATA(2, U8(1))
	DATA(3, U8(1))
	DATA(4, U8(1))
	DATA(5, U8(1))
	DATA(6, U8(1))
	DATA(7, U8(1))
	DATA(8, U8(1))
	DATA(9, U8(1))
	DATA(10, U8(1))
	DATA(11, U8(1))
	DATA(12, U8(1))
	DATA(13, U8(1))
	DATA(14, U8(1))
	DATA(15, U8(1))
	DATA(16, U8(1))
	DATA(17, U8(1))
	DATA(18, U8(1))
	DATA(19, U8(1))
	DATA(20, U8(1))
	DATA(21, U8(1))
	DATA(22, U8(1))
	DATA(23, U8(1))
	DATA(24, U8(1))
	DATA(25, U8(1))
	DATA(26, U8(1))
	DATA(27, U8(1))
	DATA(28, U8(1))
	DATA(29, U8(1))
	DATA(30, U8(1))
	DATA(31, U8(1))

	TEXT("Not_AVX2", NOSPLIT, "func(x []bool)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB0_17"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB0_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB0_16"))

	Label("LBB0_3")
	{
		CMPQ(RSI, Imm(128))
		JAE(LabelRef("LBB0_5"))
		XORL(EAX, EAX)
		JMP(LabelRef("LBB0_13"))
	}

	Label("LBB0_5")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-128), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-128), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(7), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB0_6"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
		VMOVUPS(data.Offset(0), Y0)
	}

	Label("LBB0_8")
	{
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(32), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(64), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(96), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 1))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 1).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 1).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 1).Offset(96))
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(128), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(160), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(192), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(224), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 1).Offset(128))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 1).Offset(160))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 1).Offset(192))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 1).Offset(224))
		ADDQ(I32(256), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB0_8"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB0_11"))
	}

	Label("LBB0_10")
	{
		VMOVUPS(data.Offset(0), Y0)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(32), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(64), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(96), Y0, Y0)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 1))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 1).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 1).Offset(64))
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 1).Offset(96))
	}

	Label("LBB0_11")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB0_17"))
		TESTB(Imm(112), SIB)
		JE(LabelRef("LBB0_16"))
	}

	Label("LBB0_13")
	{
		MOVQ(RAX, RCX)
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VMOVUPS(data.Offset(0), X0)
	}

	Label("LBB0_14")
	{
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1), X0, X1)
		VMOVUPS(X1, Mem{Base: RDI}.Idx(RCX, 1))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB0_14"))
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB0_17"))
	}

	Label("LBB0_16")
	{
		XORB(Imm(1), Mem{Base: RDI}.Idx(RAX, 1))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB0_16"))
	}

	Label("LBB0_17")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB0_6")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB0_10"))
		JMP(LabelRef("LBB0_11"))
	}
}

func genAnd() {

	TEXT("And_AVX2", NOSPLIT, "func(x, y []bool)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB1_13"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB1_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB1_12"))

	Label("LBB1_3")
	{
		CMPQ(RDX, Imm(128))
		JAE(LabelRef("LBB1_5"))
		XORL(EAX, EAX)
		JMP(LabelRef("LBB1_9"))
	}

	Label("LBB1_5")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-128), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB1_6")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1), Y0)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(32), Y1)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(64), Y2)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(96), Y3)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 1), Y0, Y0)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(32), Y1, Y1)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(64), Y2, Y2)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(96), Y3, Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 1))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 1).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 1).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 1).Offset(96))
		SUBQ(I32(-128), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB1_6"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB1_13"))
		TESTB(Imm(112), DL)
		JE(LabelRef("LBB1_12"))
	}

	Label("LBB1_9")
	{
		MOVQ(RAX, RCX)
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
	}

	Label("LBB1_10")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1), X0)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 1), X0, X0)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(RCX, 1))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB1_10"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB1_13"))
	}

	Label("LBB1_12")
	{
		MOVBLZX(Mem{Base: RSI}.Idx(RAX, 1), ECX)
		ANDB(CL, Mem{Base: RDI}.Idx(RAX, 1))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB1_12"))
	}

	Label("LBB1_13")
	{
		VZEROUPPER()
		RET()
	}
}

func genOr() {

	TEXT("Or_AVX2", NOSPLIT, "func(x, y []bool)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB2_13"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB2_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB2_12"))

	Label("LBB2_3")
	{
		CMPQ(RDX, Imm(128))
		JAE(LabelRef("LBB2_5"))
		XORL(EAX, EAX)
		JMP(LabelRef("LBB2_9"))
	}

	Label("LBB2_5")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-128), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB2_6")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1), Y0)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(32), Y1)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(64), Y2)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(96), Y3)
		VORPS(Mem{Base: RDI}.Idx(RCX, 1), Y0, Y0)
		VORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(32), Y1, Y1)
		VORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(64), Y2, Y2)
		VORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(96), Y3, Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 1))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 1).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 1).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 1).Offset(96))
		SUBQ(I32(-128), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB2_6"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB2_13"))
		TESTB(Imm(112), DL)
		JE(LabelRef("LBB2_12"))
	}

	Label("LBB2_9")
	{
		MOVQ(RAX, RCX)
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
	}

	Label("LBB2_10")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1), X0)
		VORPS(Mem{Base: RDI}.Idx(RCX, 1), X0, X0)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(RCX, 1))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB2_10"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB2_13"))
	}

	Label("LBB2_12")
	{
		MOVBLZX(Mem{Base: RSI}.Idx(RAX, 1), ECX)
		ORB(CL, Mem{Base: RDI}.Idx(RAX, 1))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB2_12"))
	}

	Label("LBB2_13")
	{
		VZEROUPPER()
		RET()
	}
}

func genXor() {

	TEXT("Xor_AVX2", NOSPLIT, "func(x, y []bool)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB3_13"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB3_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB3_12"))

	Label("LBB3_3")
	{
		CMPQ(RDX, Imm(128))
		JAE(LabelRef("LBB3_5"))
		XORL(EAX, EAX)
		JMP(LabelRef("LBB3_9"))
	}

	Label("LBB3_5")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-128), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB3_6")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1), Y0)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(32), Y1)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(64), Y2)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1).Offset(96), Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1), Y0, Y0)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(32), Y1, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(64), Y2, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1).Offset(96), Y3, Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 1))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 1).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 1).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 1).Offset(96))
		SUBQ(I32(-128), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB3_6"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB3_13"))
		TESTB(Imm(112), DL)
		JE(LabelRef("LBB3_12"))
	}

	Label("LBB3_9")
	{
		MOVQ(RAX, RCX)
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
	}

	Label("LBB3_10")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 1), X0)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 1), X0, X0)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(RCX, 1))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB3_10"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB3_13"))
	}

	Label("LBB3_12")
	{
		MOVBLZX(Mem{Base: RSI}.Idx(RAX, 1), ECX)
		XORB(CL, Mem{Base: RDI}.Idx(RAX, 1))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB3_12"))
	}

	Label("LBB3_13")
	{
		VZEROUPPER()
		RET()
	}
}

func genSelect_F64() {

	TEXT("Select_AVX2_F64", NOSPLIT, "func(x, y []float64, z []bool) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("z").Base(), RDX)
	Load(Param("z").Len(), RCX)

	TESTQ(RCX, RCX)
	JE(LabelRef("LBB4_1"))
	CMPQ(RCX, Imm(1))
	JNE(LabelRef("LBB4_4"))
	XORL(R8L, R8L)
	XORL(EAX, EAX)

	Label("LBB4_10")
	{
		TESTB(Imm(1), CL)
		JE(LabelRef("LBB4_13"))
		CMPB(Mem{Base: RDX}.Idx(R8, 1), Imm(0))
		JE(LabelRef("LBB4_13"))
		VMOVSD(Mem{Base: RSI}.Idx(R8, 8), X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
	}

	Label("LBB4_13")
	{
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB4_1")
	{
		XORL(EAX, EAX)
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB4_4")
	{
		MOVQ(RCX, R9)
		ANDQ(I32(-2), R9)
		XORL(R8L, R8L)
		XORL(EAX, EAX)
		JMP(LabelRef("LBB4_5"))
	}

	Label("LBB4_9")
	{
		ADDQ(Imm(2), R8)
		CMPQ(R9, R8)
		JE(LabelRef("LBB4_10"))
	}

	Label("LBB4_5")
	{
		CMPB(Mem{Base: RDX}.Idx(R8, 1), Imm(0))
		JE(LabelRef("LBB4_7"))
		VMOVSD(Mem{Base: RSI}.Idx(R8, 8), X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
	}

	Label("LBB4_7")
	{
		CMPB(Mem{Base: RDX}.Idx(R8, 1).Offset(1), Imm(0))
		JE(LabelRef("LBB4_9"))
		VMOVSD(Mem{Base: RSI}.Idx(R8, 8).Offset(8), X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		JMP(LabelRef("LBB4_9"))
	}
}

func genSelect_F32() {

	TEXT("Select_AVX2_F32", NOSPLIT, "func(x, y []float32, z []bool) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("z").Base(), RDX)
	Load(Param("z").Len(), RCX)

	TESTQ(RCX, RCX)
	JE(LabelRef("LBB5_1"))
	CMPQ(RCX, Imm(1))
	JNE(LabelRef("LBB5_4"))
	XORL(R8L, R8L)
	XORL(EAX, EAX)

	Label("LBB5_10")
	{
		TESTB(Imm(1), CL)
		JE(LabelRef("LBB5_13"))
		CMPB(Mem{Base: RDX}.Idx(R8, 1), Imm(0))
		JE(LabelRef("LBB5_13"))
		VMOVSS(Mem{Base: RSI}.Idx(R8, 4), X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
	}

	Label("LBB5_13")
	{
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB5_1")
	{
		XORL(EAX, EAX)
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB5_4")
	{
		MOVQ(RCX, R9)
		ANDQ(I32(-2), R9)
		XORL(R8L, R8L)
		XORL(EAX, EAX)
		JMP(LabelRef("LBB5_5"))
	}

	Label("LBB5_9")
	{
		ADDQ(Imm(2), R8)
		CMPQ(R9, R8)
		JE(LabelRef("LBB5_10"))
	}

	Label("LBB5_5")
	{
		CMPB(Mem{Base: RDX}.Idx(R8, 1), Imm(0))
		JE(LabelRef("LBB5_7"))
		VMOVSS(Mem{Base: RSI}.Idx(R8, 4), X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
	}

	Label("LBB5_7")
	{
		CMPB(Mem{Base: RDX}.Idx(R8, 1).Offset(1), Imm(0))
		JE(LabelRef("LBB5_9"))
		VMOVSS(Mem{Base: RSI}.Idx(R8, 4).Offset(4), X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		JMP(LabelRef("LBB5_9"))
	}
}

func genAll() {

	TEXT("All_AVX2", NOSPLIT, "func(x []bool) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	MOVQ(RSI, RAX)
	XORL(ECX, ECX)
	ANDQ(I32(-32), RAX)
	JE(LabelRef("LBB0_1"))
	VPXOR(X0, X0, X0)

	Label("LBB0_8")
	{
		VPCMPEQB(Mem{Base: RDI}.Idx(RCX, 1), Y0, Y1)
		VPTEST(Y1, Y1)
		JNE(LabelRef("LBB0_9"))
		ADDQ(Imm(32), RCX)
		CMPQ(RCX, RAX)
		JB(LabelRef("LBB0_8"))
	}

	Label("LBB0_1")
	{
		MOVB(Imm(1), AL)
		CMPQ(RCX, RSI)
		JAE(LabelRef("LBB0_6"))
		ADDQ(I32(-1), RSI)
	}

	Label("LBB0_3")
	{
		MOVBLZX(Mem{Base: RDI}.Idx(RCX, 1), EAX)
		TESTB(AL, AL)
		JE(LabelRef("LBB0_5"))
		LEAQ(Mem{Base: RCX}.Offset(1), RDX)
		CMPQ(RSI, RCX)
		MOVQ(RDX, RCX)
		JNE(LabelRef("LBB0_3"))
	}

	Label("LBB0_5")
	{
		TESTB(AL, AL)
		SETNE(AL)
	}

	Label("LBB0_6")
	{
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB0_9")
	{
		XORL(EAX, EAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}
}

func genAny() {

	TEXT("Any_AVX2", NOSPLIT, "func(x []bool) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	MOVQ(RSI, RCX)
	XORL(EAX, EAX)
	ANDQ(I32(-32), RCX)
	JE(LabelRef("LBB1_1"))

	Label("LBB1_4")
	{
		VMOVDQU(Mem{Base: RDI}.Idx(RAX, 1), Y0)
		VPTEST(Y0, Y0)
		JNE(LabelRef("LBB1_5"))
		ADDQ(Imm(32), RAX)
		CMPQ(RAX, RCX)
		JB(LabelRef("LBB1_4"))
	}

	Label("LBB1_1")
	{
		CMPQ(RAX, RSI)
		JAE(LabelRef("LBB1_2"))
		ADDQ(I32(-1), RSI)
	}

	Label("LBB1_7")
	{
		MOVBLZX(Mem{Base: RDI}.Idx(RAX, 1), ECX)
		TESTB(CL, CL)
		JNE(LabelRef("LBB1_9"))
		LEAQ(Mem{Base: RAX}.Offset(1), RDX)
		CMPQ(RSI, RAX)
		MOVQ(RDX, RAX)
		JNE(LabelRef("LBB1_7"))
	}

	Label("LBB1_9")
	{
		TESTB(CL, CL)
		SETNE(AL)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB1_5")
	{
		MOVB(Imm(1), AL)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB1_2")
	{
		XORL(EAX, EAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}
}

func genNone() {

	TEXT("None_AVX2", NOSPLIT, "func(x []bool) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	MOVQ(RSI, RAX)
	XORL(ECX, ECX)
	ANDQ(I32(-32), RAX)
	JE(LabelRef("LBB2_1"))

	Label("LBB2_7")
	{
		VMOVDQU(Mem{Base: RDI}.Idx(RCX, 1), Y0)
		VPTEST(Y0, Y0)
		JNE(LabelRef("LBB2_8"))
		ADDQ(Imm(32), RCX)
		CMPQ(RCX, RAX)
		JB(LabelRef("LBB2_7"))
	}

	Label("LBB2_1")
	{
		MOVB(Imm(1), AL)
		CMPQ(RCX, RSI)
		JAE(LabelRef("LBB2_5"))
		ADDQ(I32(-1), RSI)
	}

	Label("LBB2_3")
	{
		CMPB(Mem{Base: RDI}.Idx(RCX, 1), Imm(0))
		SETEQ(AL)
		JNE(LabelRef("LBB2_5"))
		LEAQ(Mem{Base: RCX}.Offset(1), RDX)
		CMPQ(RSI, RCX)
		MOVQ(RDX, RCX)
		JNE(LabelRef("LBB2_3"))
	}

	Label("LBB2_5")
	{
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB2_8")
	{
		XORL(EAX, EAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}
}

func genCount() {

	TEXT("Count_AVX2", NOSPLIT, "func(x []bool) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB9_1"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB9_4"))
	XORL(ECX, ECX)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB9_11"))

	Label("LBB9_1")
	{
		XORL(EAX, EAX)
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB9_4")
	{
		MOVQ(RSI, RCX)
		ANDQ(I32(-16), RCX)
		LEAQ(Mem{Base: RCX}.Offset(-16), RAX)
		MOVQ(RAX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RAX, RAX)
		JE(LabelRef("LBB9_5"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		VPXOR(X0, X0, X0)
		XORL(EAX, EAX)
		VPXOR(X1, X1, X1)
		VPXOR(X2, X2, X2)
		VPXOR(X3, X3, X3)
	}

	Label("LBB9_7")
	{
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1), Y4)
		VPADDQ(Y4, Y0, Y0)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(4), Y4)
		VPADDQ(Y4, Y1, Y1)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(8), Y4)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(12), Y5)
		VPADDQ(Y4, Y2, Y2)
		VPADDQ(Y5, Y3, Y3)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(16), Y4)
		VPADDQ(Y4, Y0, Y0)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(20), Y4)
		VPADDQ(Y4, Y1, Y1)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(24), Y4)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(28), Y5)
		VPADDQ(Y4, Y2, Y2)
		VPADDQ(Y5, Y3, Y3)
		ADDQ(Imm(32), RAX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB9_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB9_10"))
	}

	Label("LBB9_9")
	{
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1), Y4)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(4), Y5)
		VPADDQ(Y4, Y0, Y0)
		VPADDQ(Y5, Y1, Y1)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(8), Y4)
		VPADDQ(Y4, Y2, Y2)
		VPMOVZXBQ(Mem{Base: RDI}.Idx(RAX, 1).Offset(12), Y4)
		VPADDQ(Y4, Y3, Y3)
	}

	Label("LBB9_10")
	{
		VPADDQ(Y3, Y1, Y1)
		VPADDQ(Y2, Y0, Y0)
		VPADDQ(Y1, Y0, Y0)
		VEXTRACTI128(Imm(1), Y0, X1)
		VPADDQ(X1, X0, X0)
		VPSHUFD(Imm(238), X0, X1)
		VPADDQ(X1, X0, X0)
		VMOVQ(X0, RAX)
		CMPQ(RCX, RSI)
		JE(LabelRef("LBB9_12"))
	}

	Label("LBB9_11")
	{
		MOVBLZX(Mem{Base: RDI}.Idx(RCX, 1), EDX)
		ADDQ(RDX, RAX)
		ADDQ(Imm(1), RCX)
		CMPQ(RSI, RCX)
		JNE(LabelRef("LBB9_11"))
	}

	Label("LBB9_12")
	{
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("LBB9_5")
	{
		VPXOR(X0, X0, X0)
		XORL(EAX, EAX)
		VPXOR(X1, X1, X1)
		VPXOR(X2, X2, X2)
		VPXOR(X3, X3, X3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB9_9"))
		JMP(LabelRef("LBB9_10"))
	}
}
