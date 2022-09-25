package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genMin_F64() {

	data := GLOBL("dataMinF64", RODATA|NOPTR)
	DATA(0, U64(0x7fefffffffffffff))

	TEXT("Min_AVX2_F64", NOSPLIT, "func(x []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB0_1"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB0_4"))
	VMOVSD(data, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB0_11"))

	Label("LBB0_1")
	{
		VMOVSD(data, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB0_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB0_5"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSD(data, Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
	}

	Label("LBB0_7")
	{
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(128), Y0, Y0)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(160), Y1, Y1)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(192), Y2, Y2)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(224), Y3, Y3)
		ADDQ(Imm(32), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB0_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB0_10"))
	}

	Label("LBB0_9")
	{
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VMINPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
	}

	Label("LBB0_10")
	{
		VMINPD(Y3, Y0, Y0)
		VMINPD(Y2, Y1, Y1)
		VMINPD(Y0, Y1, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VMINPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VMINSD(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB0_12"))
	}

	Label("LBB0_11")
	{
		VMINSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB0_11"))
	}

	Label("LBB0_12")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB0_5")
	{
		VBROADCASTSD(data, Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB0_9"))
		JMP(LabelRef("LBB0_10"))
	}
}

func genMin_F32() {

	data := GLOBL("dataMinF32", RODATA|NOPTR)
	DATA(0, U32(0x7f7fffff))

	TEXT("Min_AVX2_F32", NOSPLIT, "func(x []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB1_1"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB1_4"))
	VMOVSS(data, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB1_11"))

	Label("LBB1_1")
	{
		VMOVSS(data, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB1_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB1_5"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSS(data, Y0)
		XORL(EDX, EDX)
		VMOVAPS(Y0, Y1)
		VMOVAPS(Y0, Y2)
		VMOVAPS(Y0, Y3)
	}

	Label("LBB1_7")
	{
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(128), Y0, Y0)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(160), Y1, Y1)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(192), Y2, Y2)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(224), Y3, Y3)
		ADDQ(Imm(64), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB1_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB1_10"))
	}

	Label("LBB1_9")
	{
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VMINPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
	}

	Label("LBB1_10")
	{
		VMINPS(Y3, Y0, Y0)
		VMINPS(Y2, Y1, Y1)
		VMINPS(Y0, Y1, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VMINPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VMINPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VMINSS(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB1_12"))
	}

	Label("LBB1_11")
	{
		VMINSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB1_11"))
	}

	Label("LBB1_12")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB1_5")
	{
		VBROADCASTSS(data, Y0)
		XORL(EDX, EDX)
		VMOVAPS(Y0, Y1)
		VMOVAPS(Y0, Y2)
		VMOVAPS(Y0, Y3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB1_9"))
		JMP(LabelRef("LBB1_10"))
	}
}

func genMinimum_F64() {

	TEXT("Minimum_AVX2_F64", NOSPLIT, "func(x, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB2_9"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB2_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB2_6"))

	Label("LBB2_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RDI}.Offset(96), R8)
		XORL(ECX, ECX)
	}

	Label("LBB2_4")
	{
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8), Y0)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y1)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y2)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y3)
		VCMPPD(Imm(1), Mem{Base: R8}.Idx(RCX, 8).Offset(-96), Y0, Y4)
		VCMPPD(Imm(1), Mem{Base: R8}.Idx(RCX, 8).Offset(-64), Y1, Y5)
		VCMPPD(Imm(1), Mem{Base: R8}.Idx(RCX, 8).Offset(-32), Y2, Y6)
		VCMPPD(Imm(1), Mem{Base: R8}.Idx(RCX, 8), Y3, Y7)
		VMASKMOVPD(Y0, Y4, Mem{Base: R8}.Idx(RCX, 8).Offset(-96))
		VMASKMOVPD(Y1, Y5, Mem{Base: R8}.Idx(RCX, 8).Offset(-64))
		VMASKMOVPD(Y2, Y6, Mem{Base: R8}.Idx(RCX, 8).Offset(-32))
		VMASKMOVPD(Y3, Y7, Mem{Base: R8}.Idx(RCX, 8))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB2_4"))
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB2_6"))
	}

	Label("LBB2_9")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB2_8")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JE(LabelRef("LBB2_9"))
	}

	Label("LBB2_6")
	{
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X0)
		VUCOMISD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		JAE(LabelRef("LBB2_8"))
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		JMP(LabelRef("LBB2_8"))
	}
}

func genMinimum_F32() {

	TEXT("Minimum_AVX2_F32", NOSPLIT, "func(x, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB3_9"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB3_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB3_6"))

	Label("LBB3_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RDI}.Offset(96), R8)
		XORL(ECX, ECX)
	}

	Label("LBB3_4")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3)
		VCMPPS(Imm(1), Mem{Base: R8}.Idx(RCX, 4).Offset(-96), Y0, Y4)
		VCMPPS(Imm(1), Mem{Base: R8}.Idx(RCX, 4).Offset(-64), Y1, Y5)
		VCMPPS(Imm(1), Mem{Base: R8}.Idx(RCX, 4).Offset(-32), Y2, Y6)
		VCMPPS(Imm(1), Mem{Base: R8}.Idx(RCX, 4), Y3, Y7)
		VMASKMOVPS(Y0, Y4, Mem{Base: R8}.Idx(RCX, 4).Offset(-96))
		VMASKMOVPS(Y1, Y5, Mem{Base: R8}.Idx(RCX, 4).Offset(-64))
		VMASKMOVPS(Y2, Y6, Mem{Base: R8}.Idx(RCX, 4).Offset(-32))
		VMASKMOVPS(Y3, Y7, Mem{Base: R8}.Idx(RCX, 4))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB3_4"))
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB3_6"))
	}

	Label("LBB3_9")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB3_8")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JE(LabelRef("LBB3_9"))
	}

	Label("LBB3_6")
	{
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X0)
		VUCOMISS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		JAE(LabelRef("LBB3_8"))
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		JMP(LabelRef("LBB3_8"))
	}
}

func genMinimumNumber_F64() {

	TEXT("MinimumNumber_AVX2_F64", NOSPLIT, "func(x []float64, a float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB4_9"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB4_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB4_6"))

	Label("LBB4_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RDI}.Offset(96), RCX)
		XORL(EDX, EDX)
	}

	Label("LBB4_4")
	{
		VCMPPD(Imm(1), Mem{Base: RCX}.Idx(RDX, 8).Offset(-96), Y1, Y2)
		VCMPPD(Imm(1), Mem{Base: RCX}.Idx(RDX, 8).Offset(-64), Y1, Y3)
		VCMPPD(Imm(1), Mem{Base: RCX}.Idx(RDX, 8).Offset(-32), Y1, Y4)
		VCMPPD(Imm(1), Mem{Base: RCX}.Idx(RDX, 8), Y1, Y5)
		VMASKMOVPD(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 8).Offset(-96))
		VMASKMOVPD(Y1, Y3, Mem{Base: RCX}.Idx(RDX, 8).Offset(-64))
		VMASKMOVPD(Y1, Y4, Mem{Base: RCX}.Idx(RDX, 8).Offset(-32))
		VMASKMOVPD(Y1, Y5, Mem{Base: RCX}.Idx(RDX, 8))
		ADDQ(Imm(16), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB4_4"))
		CMPQ(RAX, RSI)
		JNE(LabelRef("LBB4_6"))
	}

	Label("LBB4_9")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB4_8")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JE(LabelRef("LBB4_9"))
	}

	Label("LBB4_6")
	{
		VUCOMISD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		JAE(LabelRef("LBB4_8"))
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		JMP(LabelRef("LBB4_8"))
	}
}

func genMinimumNumber_F32() {

	TEXT("MinimumNumber_AVX2_F32", NOSPLIT, "func(x []float32, a float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB5_9"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB5_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB5_6"))

	Label("LBB5_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		LEAQ(Mem{Base: RDI}.Offset(96), RCX)
		XORL(EDX, EDX)
	}

	Label("LBB5_4")
	{
		VCMPPS(Imm(1), Mem{Base: RCX}.Idx(RDX, 4).Offset(-96), Y1, Y2)
		VCMPPS(Imm(1), Mem{Base: RCX}.Idx(RDX, 4).Offset(-64), Y1, Y3)
		VCMPPS(Imm(1), Mem{Base: RCX}.Idx(RDX, 4).Offset(-32), Y1, Y4)
		VCMPPS(Imm(1), Mem{Base: RCX}.Idx(RDX, 4), Y1, Y5)
		VMASKMOVPS(Y1, Y2, Mem{Base: RCX}.Idx(RDX, 4).Offset(-96))
		VMASKMOVPS(Y1, Y3, Mem{Base: RCX}.Idx(RDX, 4).Offset(-64))
		VMASKMOVPS(Y1, Y4, Mem{Base: RCX}.Idx(RDX, 4).Offset(-32))
		VMASKMOVPS(Y1, Y5, Mem{Base: RCX}.Idx(RDX, 4))
		ADDQ(Imm(32), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB5_4"))
		CMPQ(RAX, RSI)
		JNE(LabelRef("LBB5_6"))
	}

	Label("LBB5_9")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB5_8")
	{
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JE(LabelRef("LBB5_9"))
	}

	Label("LBB5_6")
	{
		VUCOMISS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		JAE(LabelRef("LBB5_8"))
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		JMP(LabelRef("LBB5_8"))
	}
}
