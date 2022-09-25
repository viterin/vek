package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genMax_F64() {
	data := GLOBL("dataMaxF64", RODATA|NOPTR)
	DATA(0, U64(0xffefffffffffffff))

	TEXT("Max_AVX2_F64", NOSPLIT, "func(x []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("empty"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("loop"))
	VMOVSD(data, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("collect"))

	Label("empty")
	{
		VMOVSD(data, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("loop")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("setmin"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSD(data, Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
	}

	Label("body")
	{
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(128), Y0, Y0)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(160), Y1, Y1)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(192), Y2, Y2)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(224), Y3, Y3)
		ADDQ(I32(32), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("body"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("combinevectors"))
	}

	Label("tail")
	{
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y1, Y1)
		VMAXPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y1, Y1)
	}

	Label("combinevectors")
	{
		VMAXPD(Y3, Y0, Y0)
		VMAXPD(Y2, Y1, Y1)
		VMAXPD(Y0, Y1, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VMAXPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VMAXSD(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("return"))
	}

	Label("collect")
	{
		VMAXSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("collect"))
	}

	Label("return")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("setmin")
	{
		VBROADCASTSD(data, Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("tail"))
		JMP(LabelRef("combinevectors"))
	}
}

func genMax_F32() {
	data := GLOBL("dataMaxF32", RODATA|NOPTR)
	DATA(0, U32(0xff7fffff))

	TEXT("Max_AVX2_F32", NOSPLIT, "func(x []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("empty"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("loop"))
	VMOVSS(data, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("collect"))

	Label("empty")
	{
		VMOVSS(data, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("loop")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("setmin"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSS(data, Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
	}

	Label("body")
	{
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(128), Y0, Y0)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(160), Y1, Y1)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(192), Y2, Y2)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(224), Y3, Y3)
		ADDQ(I32(64), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("body"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("combinevectors"))
	}

	Label("tail")
	{
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y1, Y1)
		VMAXPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y1, Y1)
	}

	Label("combinevectors")
	{
		VMAXPS(Y3, Y0, Y0)
		VMAXPS(Y2, Y1, Y1)
		VMAXPS(Y0, Y1, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VMAXPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VMAXPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VMAXSS(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("return"))
	}

	Label("collect")
	{
		VMAXSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("collect"))
	}

	Label("return")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("setmin")
	{
		VBROADCASTSS(data, Y0)
		XORL(EDX, EDX)
		VMOVAPS(Y0, Y1)
		VMOVAPS(Y0, Y2)
		VMOVAPS(Y0, Y3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("tail"))
		JMP(LabelRef("combinevectors"))
	}
}

func genMaximum_F64() {
	TEXT("Maximum_AVX2_F64", NOSPLIT, "func(x, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("return"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("loop"))
	XORL(EAX, EAX)
	JMP(LabelRef("tailbody"))

	Label("loop")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RDI}.Offset(96), R8)
		XORL(ECX, ECX)
	}

	Label("body")
	{
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8), Y0)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y1)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y2)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y3)
		VMOVUPD(Mem{Base: R8}.Idx(RCX, 8).Offset(-96), Y4)
		VMOVUPD(Mem{Base: R8}.Idx(RCX, 8).Offset(-64), Y5)
		VMOVUPD(Mem{Base: R8}.Idx(RCX, 8).Offset(-32), Y6)
		VMOVUPD(Mem{Base: R8}.Idx(RCX, 8), Y7)
		VCMPPD(Imm(1), Y0, Y4, Y4)
		VMASKMOVPD(Y0, Y4, Mem{Base: R8}.Idx(RCX, 8).Offset(-96))
		VCMPPD(Imm(1), Y1, Y5, Y0)
		VMASKMOVPD(Y1, Y0, Mem{Base: R8}.Idx(RCX, 8).Offset(-64))
		VCMPPD(Imm(1), Y2, Y6, Y0)
		VMASKMOVPD(Y2, Y0, Mem{Base: R8}.Idx(RCX, 8).Offset(-32))
		VCMPPD(Imm(1), Y3, Y7, Y0)
		VMASKMOVPD(Y3, Y0, Mem{Base: R8}.Idx(RCX, 8))
		ADDQ(Imm(16), RCX)
		CMPQ(RCX, RAX)
		JNE(LabelRef("body"))
		CMPQ(RDX, RAX)
		JNE(LabelRef("tailbody"))
	}

	Label("return")
	{
		VZEROUPPER()
		RET()
	}

	Label("tail")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RAX, RDX)
		JE(LabelRef("return"))
	}

	Label("tailbody")
	{
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X0)
		VUCOMISD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		JBE(LabelRef("tail"))
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		JMP(LabelRef("tail"))
	}
}

func genMaximum_F32() {
	TEXT("Maximum_AVX2_F32", NOSPLIT, "func(x, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("return"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("loop"))
	XORL(EAX, EAX)
	JMP(LabelRef("tailbody"))

	Label("loop")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RDI}.Offset(96), R8)
		XORL(ECX, ECX)
	}

	Label("body")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3)
		VMOVUPS(Mem{Base: R8}.Idx(RCX, 4).Offset(-96), Y4)
		VMOVUPS(Mem{Base: R8}.Idx(RCX, 4).Offset(-64), Y5)
		VMOVUPS(Mem{Base: R8}.Idx(RCX, 4).Offset(-32), Y6)
		VMOVUPS(Mem{Base: R8}.Idx(RCX, 4), Y7)
		VCMPPS(Imm(1), Y0, Y4, Y4)
		VMASKMOVPS(Y0, Y4, Mem{Base: R8}.Idx(RCX, 4).Offset(-96))
		VCMPPS(Imm(1), Y1, Y5, Y0)
		VMASKMOVPS(Y1, Y0, Mem{Base: R8}.Idx(RCX, 4).Offset(-64))
		VCMPPS(Imm(1), Y2, Y6, Y0)
		VMASKMOVPS(Y2, Y0, Mem{Base: R8}.Idx(RCX, 4).Offset(-32))
		VCMPPS(Imm(1), Y3, Y7, Y0)
		VMASKMOVPS(Y3, Y0, Mem{Base: R8}.Idx(RCX, 4))
		ADDQ(Imm(32), RCX)
		CMPQ(RCX, RAX)
		JNE(LabelRef("body"))
		CMPQ(RDX, RAX)
		JNE(LabelRef("tailbody"))
	}

	Label("return")
	{
		VZEROUPPER()
		RET()
	}

	Label("tail")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RAX, RDX)
		JE(LabelRef("return"))
	}

	Label("tailbody")
	{
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X0)
		VUCOMISS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		JBE(LabelRef("tail"))
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		JMP(LabelRef("tail"))
	}
}

func genMaximumNumber_F64() {
	TEXT("MaximumNumber_AVX2_F64", NOSPLIT, "func(x []float64, a float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("return"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("loop"))
	XORL(EAX, EAX)
	JMP(LabelRef("tailbody"))

	Label("loop")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RDI}.Offset(96), RCX)
		XORL(EDX, EDX)
	}

	Label("body")
	{
		VMOVUPD(Mem{Base: RCX}.Idx(RDX, 8).Offset(-96), Y2)
		VMOVUPD(Mem{Base: RCX}.Idx(RDX, 8).Offset(-64), Y3)
		VMOVUPD(Mem{Base: RCX}.Idx(RDX, 8).Offset(-32), Y4)
		VMOVUPD(Mem{Base: RCX}.Idx(RDX, 8), Y5)
		VCMPPD(Imm(1), Y1, Y2, Y2)
		VMASKMOVPD(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 8).Offset(-96))
		VCMPPD(Imm(1), Y1, Y3, Y2)
		VMASKMOVPD(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 8).Offset(-64))
		VCMPPD(Imm(1), Y1, Y4, Y2)
		VMASKMOVPD(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 8).Offset(-32))
		VCMPPD(Imm(1), Y1, Y5, Y2)
		VMASKMOVPD(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 8))
		ADDQ(Imm(16), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("body"))
		CMPQ(RAX, RSI)
		JNE(LabelRef("tailbody"))
	}

	Label("return")
	{
		VZEROUPPER()
		RET()
	}

	Label("tail")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JE(LabelRef("return"))
	}

	Label("tailbody")
	{
		VUCOMISD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		JBE(LabelRef("tail"))
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		JMP(LabelRef("tail"))
	}
}

func genMaximumNumber_F32() {
	TEXT("MaximumNumber_AVX2_F32", NOSPLIT, "func(x []float32, a float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("return"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("loop"))
	XORL(EAX, EAX)
	JMP(LabelRef("tailbody"))

	Label("loop")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		LEAQ(Mem{Base: RDI}.Offset(96), RCX)
		XORL(EDX, EDX)
	}

	Label("body")
	{
		VMOVUPS(Mem{Base: RCX}.Idx(RDX, 4).Offset(-96), Y2)
		VMOVUPS(Mem{Base: RCX}.Idx(RDX, 4).Offset(-64), Y3)
		VMOVUPS(Mem{Base: RCX}.Idx(RDX, 4).Offset(-32), Y4)
		VMOVUPS(Mem{Base: RCX}.Idx(RDX, 4), Y5)
		VCMPPS(Imm(1), Y1, Y2, Y2)
		VMASKMOVPS(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 4).Offset(-96))
		VCMPPS(Imm(1), Y1, Y3, Y2)
		VMASKMOVPS(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 4).Offset(-64))
		VCMPPS(Imm(1), Y1, Y4, Y2)
		VMASKMOVPS(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 4).Offset(-32))
		VCMPPS(Imm(1), Y1, Y5, Y2)
		VMASKMOVPS(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 4))
		ADDQ(Imm(32), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("body"))
		CMPQ(RAX, RSI)
		JNE(LabelRef("tailbody"))
	}

	Label("return")
	{
		VZEROUPPER()
		RET()
	}

	Label("tail")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JE(LabelRef("return"))
	}

	Label("tailbody")
	{
		VUCOMISS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		JBE(LabelRef("tail"))
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		JMP(LabelRef("tail"))
	}
}
