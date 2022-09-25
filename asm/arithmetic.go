package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genAdd_F64() {

	TEXT("Add_AVX2_F64", NOSPLIT, "func(x, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB0_7"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB0_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB0_6"))

	Label("LBB0_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB0_4")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y0)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y3)
		VADDPD(Mem{Base: RSI}.Idx(RCX, 8), Y0, Y0)
		VADDPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y1, Y1)
		VADDPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y2, Y2)
		VADDPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y3, Y3)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB0_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB0_7"))
	}

	Label("LBB0_6")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		VADDSD(Mem{Base: RSI}.Idx(RAX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB0_6"))
	}

	Label("LBB0_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genAdd_F32() {

	TEXT("Add_AVX2_F32", NOSPLIT, "func(x, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB1_7"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB1_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB1_6"))

	Label("LBB1_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB1_4")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y0)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y3)
		VADDPS(Mem{Base: RSI}.Idx(RCX, 4), Y0, Y0)
		VADDPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1, Y1)
		VADDPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2, Y2)
		VADDPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3, Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB1_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB1_7"))
	}

	Label("LBB1_6")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		VADDSS(Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB1_6"))
	}

	Label("LBB1_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genAddNumber_F64() {

	TEXT("AddNumber_AVX2_F64", NOSPLIT, "func(x []float64, a float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB2_11"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB2_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB2_10"))

	Label("LBB2_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB2_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB2_6")
	{
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8), Y1, Y2)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1, Y3)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y1, Y4)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y1, Y5)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(128), Y1, Y2)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(160), Y1, Y3)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(192), Y1, Y4)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(224), Y1, Y5)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPD(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB2_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB2_9"))
	}

	Label("LBB2_8")
	{
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8), Y1, Y2)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1, Y3)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y1, Y4)
		VADDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y1, Y1)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB2_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB2_11"))
	}

	Label("LBB2_10")
	{
		VADDSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X1)
		VMOVSD(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB2_10"))
	}

	Label("LBB2_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB2_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB2_8"))
		JMP(LabelRef("LBB2_9"))
	}
}

func genAddNumber_F32() {

	TEXT("AddNumber_AVX2_F32", NOSPLIT, "func(x []float32, a float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB3_11"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB3_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB3_10"))

	Label("LBB3_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB3_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB3_6")
	{
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4), Y1, Y2)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1, Y3)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y1, Y4)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y1, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(128), Y1, Y2)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(160), Y1, Y3)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(192), Y1, Y4)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(224), Y1, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB3_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB3_9"))
	}

	Label("LBB3_8")
	{
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4), Y1, Y2)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1, Y3)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y1, Y4)
		VADDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y1, Y1)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB3_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB3_11"))
	}

	Label("LBB3_10")
	{
		VADDSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB3_10"))
	}

	Label("LBB3_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB3_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB3_8"))
		JMP(LabelRef("LBB3_9"))
	}
}

func genSub_F64() {

	TEXT("Sub_AVX2_F64", NOSPLIT, "func(x, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB4_7"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB4_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB4_6"))

	Label("LBB4_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB4_4")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y0)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y3)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8), Y0, Y0)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y1, Y1)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y2, Y2)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y3, Y3)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB4_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB4_7"))
	}

	Label("LBB4_6")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		VSUBSD(Mem{Base: RSI}.Idx(RAX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB4_6"))
	}

	Label("LBB4_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genSub_F32() {

	TEXT("Sub_AVX2_F32", NOSPLIT, "func(x, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB5_7"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB5_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB5_6"))

	Label("LBB5_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB5_4")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y0)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y3)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4), Y0, Y0)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1, Y1)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2, Y2)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3, Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB5_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB5_7"))
	}

	Label("LBB5_6")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		VSUBSS(Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB5_6"))
	}

	Label("LBB5_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genSubNumber_F64() {

	TEXT("SubNumber_AVX2_F64", NOSPLIT, "func(x []float64, a float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB6_11"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB6_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB6_10"))

	Label("LBB6_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB6_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB6_6")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y3)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y4)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y5)
		VSUBPD(Y1, Y2, Y2)
		VSUBPD(Y1, Y3, Y3)
		VSUBPD(Y1, Y4, Y4)
		VSUBPD(Y1, Y5, Y5)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(128), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(160), Y3)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(192), Y4)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(224), Y5)
		VSUBPD(Y1, Y2, Y2)
		VSUBPD(Y1, Y3, Y3)
		VSUBPD(Y1, Y4, Y4)
		VSUBPD(Y1, Y5, Y5)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPD(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB6_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB6_9"))
	}

	Label("LBB6_8")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y3)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y4)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y5)
		VSUBPD(Y1, Y2, Y2)
		VSUBPD(Y1, Y3, Y3)
		VSUBPD(Y1, Y4, Y4)
		VSUBPD(Y1, Y5, Y1)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB6_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB6_11"))
	}

	Label("LBB6_10")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X1)
		VSUBSD(X0, X1, X1)
		VMOVSD(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB6_10"))
	}

	Label("LBB6_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB6_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB6_8"))
		JMP(LabelRef("LBB6_9"))
	}
}

func genSubNumber_F32() {

	TEXT("SubNumber_AVX2_F32", NOSPLIT, "func(x []float32, a float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB7_11"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB7_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB7_10"))

	Label("LBB7_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB7_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB7_6")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y3)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y5)
		VSUBPS(Y1, Y2, Y2)
		VSUBPS(Y1, Y3, Y3)
		VSUBPS(Y1, Y4, Y4)
		VSUBPS(Y1, Y5, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(128), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(160), Y3)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(192), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(224), Y5)
		VSUBPS(Y1, Y2, Y2)
		VSUBPS(Y1, Y3, Y3)
		VSUBPS(Y1, Y4, Y4)
		VSUBPS(Y1, Y5, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB7_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB7_9"))
	}

	Label("LBB7_8")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y3)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y5)
		VSUBPS(Y1, Y2, Y2)
		VSUBPS(Y1, Y3, Y3)
		VSUBPS(Y1, Y4, Y4)
		VSUBPS(Y1, Y5, Y1)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB7_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB7_11"))
	}

	Label("LBB7_10")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X1)
		VSUBSS(X0, X1, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB7_10"))
	}

	Label("LBB7_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB7_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB7_8"))
		JMP(LabelRef("LBB7_9"))
	}
}

func genMul_F64() {

	TEXT("Mul_AVX2_F64", NOSPLIT, "func(x, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB8_7"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB8_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB8_6"))

	Label("LBB8_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB8_4")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y0)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y3)
		VMULPD(Mem{Base: RSI}.Idx(RCX, 8), Y0, Y0)
		VMULPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y1, Y1)
		VMULPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y2, Y2)
		VMULPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y3, Y3)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB8_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB8_7"))
	}

	Label("LBB8_6")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		VMULSD(Mem{Base: RSI}.Idx(RAX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB8_6"))
	}

	Label("LBB8_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genMul_F32() {

	TEXT("Mul_AVX2_F32", NOSPLIT, "func(x, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB9_7"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB9_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB9_6"))

	Label("LBB9_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB9_4")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y0)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y3)
		VMULPS(Mem{Base: RSI}.Idx(RCX, 4), Y0, Y0)
		VMULPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1, Y1)
		VMULPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2, Y2)
		VMULPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3, Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB9_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB9_7"))
	}

	Label("LBB9_6")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		VMULSS(Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB9_6"))
	}

	Label("LBB9_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genMulNumber_F64() {

	TEXT("MulNumber_AVX2_F64", NOSPLIT, "func(x []float64, a float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB10_11"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB10_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB10_10"))

	Label("LBB10_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB10_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB10_6")
	{
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8), Y1, Y2)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1, Y3)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y1, Y4)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y1, Y5)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(128), Y1, Y2)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(160), Y1, Y3)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(192), Y1, Y4)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(224), Y1, Y5)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPD(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB10_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB10_9"))
	}

	Label("LBB10_8")
	{
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8), Y1, Y2)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1, Y3)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y1, Y4)
		VMULPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y1, Y1)
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB10_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB10_11"))
	}

	Label("LBB10_10")
	{
		VMULSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X1)
		VMOVSD(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB10_10"))
	}

	Label("LBB10_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB10_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB10_8"))
		JMP(LabelRef("LBB10_9"))
	}
}

func genMulNumber_F32() {

	TEXT("MulNumber_AVX2_F32", NOSPLIT, "func(x []float32, a float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB11_11"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB11_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB11_10"))

	Label("LBB11_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB11_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB11_6")
	{
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4), Y1, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1, Y3)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y1, Y4)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y1, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(128), Y1, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(160), Y1, Y3)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(192), Y1, Y4)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(224), Y1, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB11_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB11_9"))
	}

	Label("LBB11_8")
	{
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4), Y1, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1, Y3)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y1, Y4)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y1, Y1)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB11_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB11_11"))
	}

	Label("LBB11_10")
	{
		VMULSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB11_10"))
	}

	Label("LBB11_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB11_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB11_8"))
		JMP(LabelRef("LBB11_9"))
	}
}

func genDiv_F64() {

	TEXT("Div_AVX2_F64", NOSPLIT, "func(x, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB12_11"))
	CMPQ(RDX, Imm(4))
	JAE(LabelRef("LBB12_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB12_10"))

	Label("LBB12_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-4), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-4), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(2), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB12_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB12_6")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y0)
		VDIVPD(Mem{Base: RSI}.Idx(RCX, 8), Y0, Y0)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VDIVPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y1, Y0)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		ADDQ(Imm(8), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB12_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB12_9"))
	}

	Label("LBB12_8")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y0)
		VDIVPD(Mem{Base: RSI}.Idx(RCX, 8), Y0, Y0)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8))
	}

	Label("LBB12_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB12_11"))
	}

	Label("LBB12_10")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		VDIVSD(Mem{Base: RSI}.Idx(RAX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB12_10"))
	}

	Label("LBB12_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB12_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB12_8"))
		JMP(LabelRef("LBB12_9"))
	}
}

func genDiv_F32() {

	TEXT("Div_AVX2_F32", NOSPLIT, "func(x, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB13_7"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB13_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB13_6"))

	Label("LBB13_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
	}

	Label("LBB13_4")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VRCPPS(Y0, Y3)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y5)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y6)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y7)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y8)
		VMULPS(Y3, Y5, Y9)
		VFMSUB213PS(Y5, Y9, Y0)
		VFNMADD213PS(Y9, Y3, Y0)
		VRCPPS(Y1, Y3)
		VMULPS(Y3, Y6, Y5)
		VFMSUB213PS(Y6, Y5, Y1)
		VRCPPS(Y2, Y6)
		VFNMADD213PS(Y5, Y3, Y1)
		VMULPS(Y6, Y7, Y3)
		VFMSUB213PS(Y7, Y3, Y2)
		VFNMADD213PS(Y3, Y6, Y2)
		VRCPPS(Y4, Y3)
		VMULPS(Y3, Y8, Y5)
		VFMSUB213PS(Y8, Y5, Y4)
		VFNMADD213PS(Y5, Y3, Y4)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB13_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB13_7"))
	}

	Label("LBB13_6")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		VDIVSS(Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB13_6"))
	}

	Label("LBB13_7")
	{
		VZEROUPPER()
		RET()
	}
}

func genDivNumber_F64() {

	data := GLOBL("dataDivNumberF64", RODATA|NOPTR)
	DATA(0, U64(0x3ff0000000000000))

	TEXT("DivNumber_AVX2_F64", NOSPLIT, "func(x []float64, a float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB14_12"))
	CMPQ(RSI, Imm(4))
	JAE(LabelRef("LBB14_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB14_10"))

	Label("LBB14_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-4), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-4), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(2), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB14_4"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSD(data.Offset(0), Y2)
		VDIVPD(Y1, Y2, Y2)
		XORL(EDX, EDX)
	}

	Label("LBB14_6")
	{
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8), Y2, Y3)
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RDX, 8))
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y2, Y3)
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RDX, 8).Offset(32))
		ADDQ(Imm(8), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB14_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB14_9"))
	}

	Label("LBB14_8")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8), Y2)
		VDIVPD(Y1, Y2, Y1)
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RDX, 8))
	}

	Label("LBB14_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB14_12"))
	}

	Label("LBB14_10")
	{
		VMOVSD(data.Offset(0), X1)
		VDIVSD(X0, X1, X0)
	}

	Label("LBB14_11")
	{
		VMULSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X1)
		VMOVSD(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB14_11"))
	}

	Label("LBB14_12")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB14_4")
	{
		XORL(EDX, EDX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB14_8"))
		JMP(LabelRef("LBB14_9"))
	}
}

func genDivNumber_F32() {

	data := GLOBL("dataDivNumberF32", RODATA|NOPTR)
	DATA(0, U32(0x3f800000))

	TEXT("DivNumber_AVX2_F32", NOSPLIT, "func(x []float32, a float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB15_8"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB15_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB15_6"))

	Label("LBB15_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VMOVSS(data.Offset(0), X1)
		VDIVSS(X0, X1, X1)
		VBROADCASTSS(X1, Y1)
		XORL(ECX, ECX)
	}

	Label("LBB15_4")
	{
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4), Y1, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1, Y3)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y1, Y4)
		VMULPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y1, Y5)
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB15_4"))
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB15_8"))
	}

	Label("LBB15_6")
	{
		VMOVSS(data.Offset(0), X1)
		VDIVSS(X0, X1, X0)
	}

	Label("LBB15_7")
	{
		VMULSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB15_7"))
	}

	Label("LBB15_8")
	{
		VZEROUPPER()
		RET()
	}
}

func genAbs_F64() {

	data := GLOBL("dataAbsF64", RODATA|NOPTR)
	DATA(0, U64(0x7fffffffffffffff))
	DATA(8, U64(0x7fffffffffffffff))
	DATA(16, U64(0x7fffffffffffffff))

	TEXT("Abs_AVX2_F64", NOSPLIT, "func(x []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB16_8"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB16_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB16_6"))

	Label("LBB16_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		XORL(ECX, ECX)
		VBROADCASTSD(data.Offset(0), Y0)
	}

	Label("LBB16_4")
	{
		VANDPS(Mem{Base: RDI}.Idx(RCX, 8), Y0, Y1)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y0, Y2)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y0, Y3)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB16_4"))
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB16_8"))
	}

	Label("LBB16_6")
	{
		VMOVUPS(data.Offset(8), X0)
	}

	Label("LBB16_7")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X1)
		VANDPS(X0, X1, X1)
		VMOVLPS(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB16_7"))
	}

	Label("LBB16_8")
	{
		VZEROUPPER()
		RET()
	}
}

func genAbs_F32() {

	data := GLOBL("dataAbsF32", RODATA|NOPTR)
	DATA(0, U32(0x7fffffff))

	TEXT("Abs_AVX2_F32", NOSPLIT, "func(x []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB17_8"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB17_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB17_6"))

	Label("LBB17_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
		VBROADCASTSS(data.Offset(0), Y0)
	}

	Label("LBB17_4")
	{
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4), Y0, Y1)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y0, Y2)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y0, Y3)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB17_4"))
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB17_8"))
	}

	Label("LBB17_6")
	{
		VBROADCASTSS(data.Offset(0), X0)
	}

	Label("LBB17_7")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X1)
		VANDPS(X0, X1, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB17_7"))
	}

	Label("LBB17_8")
	{
		VZEROUPPER()
		RET()
	}
}

func genNeg_F64() {

	data := GLOBL("dataNegF64", RODATA|NOPTR)
	DATA(0, U64(0x8000000000000000))
	DATA(8, U64(0x8000000000000000))
	DATA(16, U64(0x8000000000000000))

	TEXT("Neg_AVX2_F64", NOSPLIT, "func(x []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB18_12"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB18_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB18_10"))

	Label("LBB18_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB18_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
		VBROADCASTSD(data.Offset(0), Y0)
	}

	Label("LBB18_6")
	{
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(128), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(160), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(192), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(224), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB18_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB18_9"))
	}

	Label("LBB18_8")
	{
		VBROADCASTSD(data.Offset(0), Y0)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y0, Y0)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB18_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB18_12"))
	}

	Label("LBB18_10")
	{
		VMOVUPS(data.Offset(8), X0)
	}

	Label("LBB18_11")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X1)
		VXORPS(X0, X1, X1)
		VMOVLPS(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB18_11"))
	}

	Label("LBB18_12")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB18_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB18_8"))
		JMP(LabelRef("LBB18_9"))
	}
}

func genNeg_F32() {

	data := GLOBL("dataNegF32", RODATA|NOPTR)
	DATA(0, U32(0x80000000))

	TEXT("Neg_AVX2_F32", NOSPLIT, "func(x []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB19_12"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB19_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB19_10"))

	Label("LBB19_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB19_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
		VBROADCASTSS(data.Offset(0), Y0)
	}

	Label("LBB19_6")
	{
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(128), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(160), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(192), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(224), Y0, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB19_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB19_9"))
	}

	Label("LBB19_8")
	{
		VBROADCASTSS(data.Offset(0), Y0)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4), Y0, Y1)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y0, Y2)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y0, Y3)
		VXORPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y0, Y0)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB19_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB19_12"))
	}

	Label("LBB19_10")
	{
		VBROADCASTSS(data.Offset(0), X0)
	}

	Label("LBB19_11")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X1)
		VXORPS(X0, X1, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB19_11"))
	}

	Label("LBB19_12")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB19_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB19_8"))
		JMP(LabelRef("LBB19_9"))
	}
}

func genInv_F64() {

	data := GLOBL("dataInvF64", RODATA|NOPTR)
	DATA(0, U64(0x3ff0000000000000))

	TEXT("Inv_AVX2_F64", NOSPLIT, "func(x []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB20_12"))
	CMPQ(RSI, Imm(4))
	JAE(LabelRef("LBB20_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB20_10"))

	Label("LBB20_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-4), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-4), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(2), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB20_4"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		XORL(EDX, EDX)
		VBROADCASTSD(data.Offset(0), Y0)
	}

	Label("LBB20_6")
	{
		VDIVPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y1)
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RDX, 8))
		VDIVPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y0, Y1)
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RDX, 8).Offset(32))
		ADDQ(Imm(8), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB20_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB20_9"))
	}

	Label("LBB20_8")
	{
		VBROADCASTSD(data.Offset(0), Y0)
		VDIVPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RDX, 8))
	}

	Label("LBB20_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB20_12"))
	}

	Label("LBB20_10")
	{
		VMOVSD(data.Offset(0), X0)
	}

	Label("LBB20_11")
	{
		VDIVSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X1)
		VMOVSD(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB20_11"))
	}

	Label("LBB20_12")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB20_4")
	{
		XORL(EDX, EDX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB20_8"))
		JMP(LabelRef("LBB20_9"))
	}
}

func genInv_F32() {

	data := GLOBL("dataInvF32", RODATA|NOPTR)
	DATA(0, U32(0x3f800000))

	TEXT("Inv_AVX2_F32", NOSPLIT, "func(x []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB21_8"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB21_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB21_6"))

	Label("LBB21_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
		VBROADCASTSS(data.Offset(0), Y0)
	}

	Label("LBB21_4")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y1)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y3)
		VRCPPS(Y1, Y4)
		VFMSUB213PS(Y0, Y4, Y1)
		VRCPPS(Y2, Y5)
		VFNMADD132PS(Y4, Y4, Y1)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y4)
		VFMSUB213PS(Y0, Y5, Y2)
		VFNMADD132PS(Y5, Y5, Y2)
		VRCPPS(Y3, Y5)
		VFMSUB213PS(Y0, Y5, Y3)
		VFNMADD132PS(Y5, Y5, Y3)
		VRCPPS(Y4, Y5)
		VFMSUB213PS(Y0, Y5, Y4)
		VFNMADD132PS(Y5, Y5, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB21_4"))
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB21_8"))
	}

	Label("LBB21_6")
	{
		VMOVSS(data.Offset(0), X0)
	}

	Label("LBB21_7")
	{
		VDIVSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X1)
		VMOVSS(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB21_7"))
	}

	Label("LBB21_8")
	{
		VZEROUPPER()
		RET()
	}
}
