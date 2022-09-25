package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genFind_F64() {
	TEXT("Find_AVX2_F64", NOSPLIT, "func(x []float64, a float64) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	MOVQ(RSI, RCX)
	ANDQ(I32(-8), RCX)
	JE(LabelRef("tail"))
	VPBROADCASTQ(X0, Y1)
	XORL(EAX, EAX)

	Label("loop")
	{
		VPCMPEQQ(Mem{Base: RDI}.Idx(RAX, 8), Y1, Y2)
		VPCMPEQQ(Mem{Base: RDI}.Idx(RAX, 8).Offset(32), Y1, Y3)
		VPOR(Y2, Y3, Y4)
		VPTEST(Y4, Y4)
		JNE(LabelRef("mask"))
		ADDQ(Imm(8), RAX)
		CMPQ(RAX, RCX)
		JB(LabelRef("loop"))
		CMPQ(RAX, RSI)
		JB(LabelRef("tailbody"))
	}

	Label("return")
	{
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("tail")
	{
		XORL(EAX, EAX)
		CMPQ(RAX, RSI)
		JAE(LabelRef("return"))
	}

	Label("tailbody")
	{
		VUCOMISD(Mem{Base: RDI}.Idx(RAX, 8), X0)
		JE(LabelRef("return"))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("tailbody"))
		MOVQ(RSI, RAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("mask")
	{
		VMOVMSKPD(Y3, ECX)
		SHLL(Imm(4), ECX)
		VMOVMSKPD(Y2, EDX)
		ORL(ECX, EDX)
		BSFL(EDX, ECX)
		ADDQ(RCX, RAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}
}

func genFind_F32() {
	TEXT("Find_AVX2_F32", NOSPLIT, "func(x []float32, a float32) int")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("x").Len(), RSI)

	MOVQ(RSI, RCX)
	ANDQ(I32(-16), RCX)
	JE(LabelRef("tail"))
	VPBROADCASTD(X0, Y1)
	XORL(EAX, EAX)

	Label("loop")
	{
		VPCMPEQD(Mem{Base: RDI}.Idx(RAX, 4), Y1, Y2)
		VPCMPEQD(Mem{Base: RDI}.Idx(RAX, 4).Offset(32), Y1, Y3)
		VPOR(Y2, Y3, Y4)
		VPTEST(Y4, Y4)
		JNE(LabelRef("mask"))
		ADDQ(Imm(16), RAX)
		CMPQ(RAX, RCX)
		JB(LabelRef("loop"))
		CMPQ(RAX, RSI)
		JB(LabelRef("tailbody"))
	}

	Label("return")
	{
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("tail")
	{
		XORL(EAX, EAX)
		CMPQ(RAX, RSI)
		JAE(LabelRef("return"))
	}

	Label("tailbody")
	{
		VUCOMISS(Mem{Base: RDI}.Idx(RAX, 4), X0)
		JE(LabelRef("return"))
		ADDQ(I32(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("tailbody"))
		MOVQ(RSI, RAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}

	Label("mask")
	{
		VMOVMSKPS(Y3, ECX)
		SHLL(Imm(8), ECX)
		VMOVMSKPS(Y2, EDX)
		ORL(ECX, EDX)
		BSFL(EDX, ECX)
		ADDQ(RCX, RAX)
		VZEROUPPER()
		Store(RAX, ReturnIndex(0))
		RET()
	}
}
