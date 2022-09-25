package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genSum_F64() {

	TEXT("Sum_AVX2_F64", NOSPLIT, "func(x []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB0_1"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB0_4"))
	VXORPD(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB0_11"))

	Label("LBB0_1")
	{
		VXORPS(X0, X0, X0)
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
		VXORPD(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPD(X1, X1, X1)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
	}

	Label("LBB0_7")
	{
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(128), Y0, Y0)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(160), Y1, Y1)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(192), Y2, Y2)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(224), Y3, Y3)
		ADDQ(Imm(32), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB0_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB0_10"))
	}

	Label("LBB0_9")
	{
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VADDPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
	}

	Label("LBB0_10")
	{
		VADDPD(Y3, Y1, Y1)
		VADDPD(Y2, Y0, Y0)
		VADDPD(Y1, Y0, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDSD(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB0_12"))
	}

	Label("LBB0_11")
	{
		VADDSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X0)
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
		VXORPD(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPD(X1, X1, X1)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB0_9"))
		JMP(LabelRef("LBB0_10"))
	}
}

func genSum_F32() {

	TEXT("Sum_AVX2_F32", NOSPLIT, "func(x []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB1_1"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB1_4"))
	VXORPS(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB1_11"))

	Label("LBB1_1")
	{
		VXORPS(X0, X0, X0)
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
		VXORPS(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPS(X1, X1, X1)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
	}

	Label("LBB1_7")
	{
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(128), Y0, Y0)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(160), Y1, Y1)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(192), Y2, Y2)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(224), Y3, Y3)
		ADDQ(Imm(64), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB1_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB1_10"))
	}

	Label("LBB1_9")
	{
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VADDPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
	}

	Label("LBB1_10")
	{
		VADDPS(Y3, Y1, Y1)
		VADDPS(Y2, Y0, Y0)
		VADDPS(Y1, Y0, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VADDSS(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB1_12"))
	}

	Label("LBB1_11")
	{
		VADDSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X0)
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
		VXORPS(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPS(X1, X1, X1)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB1_9"))
		JMP(LabelRef("LBB1_10"))
	}
}

func genCumSum_F64() {

	TEXT("CumSum_AVX2_F64", NOSPLIT, "func(x []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB2_8"))
	LEAQ(Mem{Base: RSI}.Offset(-1), RCX)
	MOVL(ESI, EAX)
	ANDL(Imm(3), EAX)
	CMPQ(RCX, Imm(3))
	JAE(LabelRef("LBB2_3"))
	VXORPD(X0, X0, X0)
	XORL(ECX, ECX)
	JMP(LabelRef("LBB2_5"))

	Label("LBB2_3")
	{
		ANDQ(I32(-4), RSI)
		VXORPD(X0, X0, X0)
		XORL(ECX, ECX)
	}

	Label("LBB2_4")
	{
		VADDSD(Mem{Base: RDI}.Idx(RCX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8))
		VADDSD(Mem{Base: RDI}.Idx(RCX, 8).Offset(8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(8))
		VADDSD(Mem{Base: RDI}.Idx(RCX, 8).Offset(16), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(16))
		VADDSD(Mem{Base: RDI}.Idx(RCX, 8).Offset(24), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(24))
		ADDQ(Imm(4), RCX)
		CMPQ(RSI, RCX)
		JNE(LabelRef("LBB2_4"))
	}

	Label("LBB2_5")
	{
		TESTQ(RAX, RAX)
		JE(LabelRef("LBB2_8"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 8), RCX)
		XORL(EDX, EDX)
	}

	Label("LBB2_7")
	{
		VADDSD(Mem{Base: RCX}.Idx(RDX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RCX}.Idx(RDX, 8))
		ADDQ(Imm(1), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB2_7"))
	}

	Label("LBB2_8")
	{
		RET()
	}
}

func genCumSum_F32() {

	TEXT("CumSum_AVX2_F32", NOSPLIT, "func(x []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB3_8"))
	LEAQ(Mem{Base: RSI}.Offset(-1), RCX)
	MOVL(ESI, EAX)
	ANDL(Imm(3), EAX)
	CMPQ(RCX, Imm(3))
	JAE(LabelRef("LBB3_3"))
	VXORPS(X0, X0, X0)
	XORL(ECX, ECX)
	JMP(LabelRef("LBB3_5"))

	Label("LBB3_3")
	{
		ANDQ(I32(-4), RSI)
		VXORPS(X0, X0, X0)
		XORL(ECX, ECX)
	}

	Label("LBB3_4")
	{
		VADDSS(Mem{Base: RDI}.Idx(RCX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VADDSS(Mem{Base: RDI}.Idx(RCX, 4).Offset(4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(4))
		VADDSS(Mem{Base: RDI}.Idx(RCX, 4).Offset(8), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(8))
		VADDSS(Mem{Base: RDI}.Idx(RCX, 4).Offset(12), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(12))
		ADDQ(Imm(4), RCX)
		CMPQ(RSI, RCX)
		JNE(LabelRef("LBB3_4"))
	}

	Label("LBB3_5")
	{
		TESTQ(RAX, RAX)
		JE(LabelRef("LBB3_8"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 4), RCX)
		XORL(EDX, EDX)
	}

	Label("LBB3_7")
	{
		VADDSS(Mem{Base: RCX}.Idx(RDX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RCX}.Idx(RDX, 4))
		ADDQ(Imm(1), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB3_7"))
	}

	Label("LBB3_8")
	{
		RET()
	}
}

func genProd_F64() {

	data := GLOBL("dataProdF64", RODATA|NOPTR)
	DATA(0, U64(0x3ff0000000000000))

	TEXT("Prod_AVX2_F64", NOSPLIT, "func(x []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB4_1"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB4_4"))
	VMOVSD(data.Offset(0), X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB4_11"))

	Label("LBB4_1")
	{
		VMOVSD(data.Offset(0), X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB4_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB4_5"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSD(data.Offset(0), Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
	}

	Label("LBB4_7")
	{
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(128), Y0, Y0)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(160), Y1, Y1)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(192), Y2, Y2)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(224), Y3, Y3)
		ADDQ(Imm(32), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB4_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB4_10"))
	}

	Label("LBB4_9")
	{
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8), Y0, Y0)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y1, Y1)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y2, Y2)
		VMULPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y3, Y3)
	}

	Label("LBB4_10")
	{
		VMULPD(Y3, Y1, Y1)
		VMULPD(Y2, Y0, Y0)
		VMULPD(Y1, Y0, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VMULPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VMULSD(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB4_12"))
	}

	Label("LBB4_11")
	{
		VMULSD(Mem{Base: RDI}.Idx(RAX, 8), X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB4_11"))
	}

	Label("LBB4_12")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB4_5")
	{
		VBROADCASTSD(data.Offset(0), Y0)
		XORL(EDX, EDX)
		VMOVAPD(Y0, Y1)
		VMOVAPD(Y0, Y2)
		VMOVAPD(Y0, Y3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB4_9"))
		JMP(LabelRef("LBB4_10"))
	}
}

func genProd_F32() {

	data := GLOBL("dataProdF32", RODATA|NOPTR)
	DATA(0, U32(0x3f800000))

	TEXT("Prod_AVX2_F32", NOSPLIT, "func(x []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB5_1"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB5_4"))
	VMOVSS(data.Offset(0), X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB5_11"))

	Label("LBB5_1")
	{
		VMOVSS(data.Offset(0), X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB5_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB5_5"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VBROADCASTSS(data.Offset(0), Y0)
		XORL(EDX, EDX)
		VMOVAPS(Y0, Y1)
		VMOVAPS(Y0, Y2)
		VMOVAPS(Y0, Y3)
	}

	Label("LBB5_7")
	{
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(128), Y0, Y0)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(160), Y1, Y1)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(192), Y2, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(224), Y3, Y3)
		ADDQ(Imm(64), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB5_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB5_10"))
	}

	Label("LBB5_9")
	{
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4), Y0, Y0)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y1, Y1)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y2, Y2)
		VMULPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y3, Y3)
	}

	Label("LBB5_10")
	{
		VMULPS(Y3, Y1, Y1)
		VMULPS(Y2, Y0, Y0)
		VMULPS(Y1, Y0, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VMULPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VMULPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VMULSS(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB5_12"))
	}

	Label("LBB5_11")
	{
		VMULSS(Mem{Base: RDI}.Idx(RAX, 4), X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB5_11"))
	}

	Label("LBB5_12")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB5_5")
	{
		VBROADCASTSS(data.Offset(0), Y0)
		XORL(EDX, EDX)
		VMOVAPS(Y0, Y1)
		VMOVAPS(Y0, Y2)
		VMOVAPS(Y0, Y3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB5_9"))
		JMP(LabelRef("LBB5_10"))
	}
}

func genCumProd_F64() {

	data := GLOBL("dataCumProdF64", RODATA|NOPTR)
	DATA(0, U64(0x3ff0000000000000))

	TEXT("CumProd_AVX2_F64", NOSPLIT, "func(x []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB6_8"))
	LEAQ(Mem{Base: RSI}.Offset(-1), RCX)
	MOVL(ESI, EAX)
	ANDL(Imm(3), EAX)
	CMPQ(RCX, Imm(3))
	JAE(LabelRef("LBB6_3"))
	VMOVSD(data.Offset(0), X0)
	XORL(ECX, ECX)
	JMP(LabelRef("LBB6_5"))

	Label("LBB6_3")
	{
		ANDQ(I32(-4), RSI)
		VMOVSD(data.Offset(0), X0)
		XORL(ECX, ECX)
	}

	Label("LBB6_4")
	{
		VMULSD(Mem{Base: RDI}.Idx(RCX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8))
		VMULSD(Mem{Base: RDI}.Idx(RCX, 8).Offset(8), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(8))
		VMULSD(Mem{Base: RDI}.Idx(RCX, 8).Offset(16), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(16))
		VMULSD(Mem{Base: RDI}.Idx(RCX, 8).Offset(24), X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(24))
		ADDQ(Imm(4), RCX)
		CMPQ(RSI, RCX)
		JNE(LabelRef("LBB6_4"))
	}

	Label("LBB6_5")
	{
		TESTQ(RAX, RAX)
		JE(LabelRef("LBB6_8"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 8), RCX)
		XORL(EDX, EDX)
	}

	Label("LBB6_7")
	{
		VMULSD(Mem{Base: RCX}.Idx(RDX, 8), X0, X0)
		VMOVSD(X0, Mem{Base: RCX}.Idx(RDX, 8))
		ADDQ(Imm(1), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB6_7"))
	}

	Label("LBB6_8")
	{
		RET()
	}
}

func genCumProd_F32() {
	data := GLOBL("dataCumProdF32", RODATA|NOPTR)
	DATA(0, U32(0x3f800000))

	TEXT("CumProd_AVX2_F32", NOSPLIT, "func(x []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB7_8"))
	LEAQ(Mem{Base: RSI}.Offset(-1), RCX)
	MOVL(ESI, EAX)
	ANDL(Imm(3), EAX)
	CMPQ(RCX, Imm(3))
	JAE(LabelRef("LBB7_3"))
	VMOVSS(data.Offset(0), X0)
	XORL(ECX, ECX)
	JMP(LabelRef("LBB7_5"))

	Label("LBB7_3")
	{
		ANDQ(I32(-4), RSI)
		VMOVSS(data.Offset(0), X0)
		XORL(ECX, ECX)
	}

	Label("LBB7_4")
	{
		VMULSS(Mem{Base: RDI}.Idx(RCX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMULSS(Mem{Base: RDI}.Idx(RCX, 4).Offset(4), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(4))
		VMULSS(Mem{Base: RDI}.Idx(RCX, 4).Offset(8), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(8))
		VMULSS(Mem{Base: RDI}.Idx(RCX, 4).Offset(12), X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(12))
		ADDQ(Imm(4), RCX)
		CMPQ(RSI, RCX)
		JNE(LabelRef("LBB7_4"))
	}

	Label("LBB7_5")
	{
		TESTQ(RAX, RAX)
		JE(LabelRef("LBB7_8"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 4), RCX)
		XORL(EDX, EDX)
	}

	Label("LBB7_7")
	{
		VMULSS(Mem{Base: RCX}.Idx(RDX, 4), X0, X0)
		VMOVSS(X0, Mem{Base: RCX}.Idx(RDX, 4))
		ADDQ(Imm(1), RDX)
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB7_7"))
	}

	Label("LBB7_8")
	{
		RET()
	}
}
