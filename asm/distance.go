package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genDot_F64() {

	TEXT("Dot_AVX2_F64", NOSPLIT, "func(x, y []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB0_1"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB0_4"))
	VXORPD(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB0_7"))

	Label("LBB0_1")
	{
		VXORPS(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB0_4")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		VXORPD(X0, X0, X0)
		XORL(ECX, ECX)
		VXORPD(X1, X1, X1)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
	}

	Label("LBB0_5")
	{
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8), Y4)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y5)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y6)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y7)
		VFMADD231PD(Mem{Base: RDI}.Idx(RCX, 8), Y4, Y0)
		VFMADD231PD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y5, Y1)
		VFMADD231PD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y6, Y2)
		VFMADD231PD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y7, Y3)
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB0_5"))
		VADDPD(Y0, Y1, Y0)
		VADDPD(Y0, Y2, Y0)
		VADDPD(Y0, Y3, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDSD(X1, X0, X0)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB0_8"))
	}

	Label("LBB0_7")
	{
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X1)
		VFMADD231SD(Mem{Base: RDI}.Idx(RAX, 8), X1, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB0_7"))
	}

	Label("LBB0_8")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genDot_F32() {

	TEXT("Dot_AVX2_F32", NOSPLIT, "func(x, y []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB1_1"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB1_4"))
	VXORPS(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB1_7"))

	Label("LBB1_1")
	{
		VXORPS(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB1_4")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		VXORPS(X0, X0, X0)
		XORL(ECX, ECX)
		VXORPS(X1, X1, X1)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
	}

	Label("LBB1_5")
	{
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4), Y4)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y5)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y6)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y7)
		VFMADD231PS(Mem{Base: RDI}.Idx(RCX, 4), Y4, Y0)
		VFMADD231PS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y5, Y1)
		VFMADD231PS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y6, Y2)
		VFMADD231PS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y7, Y3)
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB1_5"))
		VADDPS(Y0, Y1, Y0)
		VADDPS(Y0, Y2, Y0)
		VADDPS(Y0, Y3, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VADDSS(X1, X0, X0)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB1_8"))
	}

	Label("LBB1_7")
	{
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X1)
		VFMADD231SS(Mem{Base: RDI}.Idx(RAX, 4), X1, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB1_7"))
	}

	Label("LBB1_8")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genNorm_F64() {

	TEXT("Norm_AVX2_F64", NOSPLIT, "func(x []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB2_1"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB2_4"))
	VXORPD(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB2_11"))

	Label("LBB2_1")
	{
		VXORPD(X0, X0, X0)
		VSQRTSD(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB2_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB2_5"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VXORPD(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPD(X1, X1, X1)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
	}

	Label("LBB2_7")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8), Y4)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y5)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y6)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y7)
		VFMADD213PD(Y0, Y4, Y4)
		VFMADD213PD(Y1, Y5, Y5)
		VFMADD213PD(Y2, Y6, Y6)
		VFMADD213PD(Y3, Y7, Y7)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(128), Y0)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(160), Y1)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(192), Y2)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(224), Y3)
		VFMADD213PD(Y4, Y0, Y0)
		VFMADD213PD(Y5, Y1, Y1)
		VFMADD213PD(Y6, Y2, Y2)
		VFMADD213PD(Y7, Y3, Y3)
		ADDQ(Imm(32), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB2_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB2_10"))
	}

	Label("LBB2_9")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8), Y4)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(32), Y5)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(64), Y6)
		VMOVUPD(Mem{Base: RDI}.Idx(RDX, 8).Offset(96), Y7)
		VFMADD231PD(Y4, Y4, Y0)
		VFMADD231PD(Y5, Y5, Y1)
		VFMADD231PD(Y6, Y6, Y2)
		VFMADD231PD(Y7, Y7, Y3)
	}

	Label("LBB2_10")
	{
		VADDPD(Y3, Y1, Y1)
		VADDPD(Y2, Y0, Y0)
		VADDPD(Y1, Y0, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDSD(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB2_12"))
	}

	Label("LBB2_11")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X1)
		VFMADD231SD(X1, X1, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB2_11"))
	}

	Label("LBB2_12")
	{
		VSQRTSD(X0, X0, X0)
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB2_5")
	{
		VXORPD(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPD(X1, X1, X1)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB2_9"))
		JMP(LabelRef("LBB2_10"))
	}
}

func genNorm_F32() {

	data := GLOBL("dataNormF32", RODATA|NOPTR)
	DATA(0, U32(0xc0400000))
	DATA(4, U32(0xbf000000))
	DATA(8, U32(0x7fffffff))
	DATA(12, U32(0x00800000))

	TEXT("Norm_AVX2_F32", NOSPLIT, "func(x []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB3_1"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB3_4"))
	VXORPS(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB3_11"))

	Label("LBB3_1")
	{
		VXORPS(X0, X0, X0)
		JMP(LabelRef("LBB3_12"))
	}

	Label("LBB3_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB3_5"))
		MOVQ(R8, RCX)
		ANDQ(I32(-2), RCX)
		VXORPS(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPS(X1, X1, X1)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
	}

	Label("LBB3_7")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y5)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y6)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y7)
		VFMADD213PS(Y0, Y4, Y4)
		VFMADD213PS(Y1, Y5, Y5)
		VFMADD213PS(Y2, Y6, Y6)
		VFMADD213PS(Y3, Y7, Y7)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(128), Y0)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(160), Y1)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(192), Y2)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(224), Y3)
		VFMADD213PS(Y4, Y0, Y0)
		VFMADD213PS(Y5, Y1, Y1)
		VFMADD213PS(Y6, Y2, Y2)
		VFMADD213PS(Y7, Y3, Y3)
		ADDQ(Imm(64), RDX)
		ADDQ(I32(-2), RCX)
		JNE(LabelRef("LBB3_7"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB3_10"))
	}

	Label("LBB3_9")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(32), Y5)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(64), Y6)
		VMOVUPS(Mem{Base: RDI}.Idx(RDX, 4).Offset(96), Y7)
		VFMADD231PS(Y4, Y4, Y0)
		VFMADD231PS(Y5, Y5, Y1)
		VFMADD231PS(Y6, Y6, Y2)
		VFMADD231PS(Y7, Y7, Y3)
	}

	Label("LBB3_10")
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
		JE(LabelRef("LBB3_12"))
	}

	Label("LBB3_11")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X1)
		VFMADD231SS(X1, X1, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB3_11"))
	}

	Label("LBB3_12")
	{
		VRSQRTSS(X0, X0, X1)
		VMULSS(X1, X0, X2)
		VFMADD213SS(data.Offset(0), X2, X1)
		VMULSS(data.Offset(4), X2, X2)
		VMULSS(X1, X2, X1)
		VBROADCASTSS(data.Offset(8), X2)
		VANDPS(X2, X0, X0)
		VCMPSS(Imm(1), data.Offset(12), X0, X0)
		VANDNPS(X1, X0, X0)
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB3_5")
	{
		VXORPS(X0, X0, X0)
		XORL(EDX, EDX)
		VXORPS(X1, X1, X1)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB3_9"))
		JMP(LabelRef("LBB3_10"))
	}
}

func genDistance_F64() {

	TEXT("Distance_AVX2_F64", NOSPLIT, "func(x, y []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB4_1"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB4_4"))
	VXORPD(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB4_7"))

	Label("LBB4_1")
	{
		VXORPD(X0, X0, X0)
		VSQRTSD(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB4_4")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		VXORPD(X0, X0, X0)
		XORL(ECX, ECX)
		VXORPD(X1, X1, X1)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
	}

	Label("LBB4_5")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y4)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y5)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y6)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y7)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8), Y4, Y4)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y5, Y5)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y6, Y6)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y7, Y7)
		VFMADD231PD(Y4, Y4, Y0)
		VFMADD231PD(Y5, Y5, Y1)
		VFMADD231PD(Y6, Y6, Y2)
		VFMADD231PD(Y7, Y7, Y3)
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB4_5"))
		VADDPD(Y0, Y1, Y0)
		VADDPD(Y0, Y2, Y0)
		VADDPD(Y0, Y3, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDSD(X1, X0, X0)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB4_8"))
	}

	Label("LBB4_7")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X1)
		VSUBSD(Mem{Base: RSI}.Idx(RAX, 8), X1, X1)
		VFMADD231SD(X1, X1, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB4_7"))
	}

	Label("LBB4_8")
	{
		VSQRTSD(X0, X0, X0)
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genDistance_F32() {
	data := GLOBL("dataDistanceF32", RODATA|NOPTR)
	DATA(0, U32(0xc0400000))
	DATA(4, U32(0xbf000000))
	DATA(8, U32(0x7fffffff))
	DATA(12, U32(0x00800000))

	TEXT("Distance_AVX2_F32", NOSPLIT, "func(x, y []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB5_1"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB5_4"))
	VXORPS(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB5_7"))

	Label("LBB5_1")
	{
		VXORPS(X0, X0, X0)
		JMP(LabelRef("LBB5_8"))
	}

	Label("LBB5_4")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		VXORPS(X0, X0, X0)
		XORL(ECX, ECX)
		VXORPS(X1, X1, X1)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
	}

	Label("LBB5_5")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y4)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y5)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y6)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y7)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4), Y4, Y4)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y5, Y5)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y6, Y6)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y7, Y7)
		VFMADD231PS(Y4, Y4, Y0)
		VFMADD231PS(Y5, Y5, Y1)
		VFMADD231PS(Y6, Y6, Y2)
		VFMADD231PS(Y7, Y7, Y3)
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB5_5"))
		VADDPS(Y0, Y1, Y0)
		VADDPS(Y0, Y2, Y0)
		VADDPS(Y0, Y3, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VADDSS(X1, X0, X0)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB5_8"))
	}

	Label("LBB5_7")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X1)
		VSUBSS(Mem{Base: RSI}.Idx(RAX, 4), X1, X1)
		VFMADD231SS(X1, X1, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB5_7"))
	}

	Label("LBB5_8")
	{
		VRSQRTSS(X0, X0, X1)
		VMULSS(X1, X0, X2)
		VFMADD213SS(data.Offset(0), X2, X1)
		VMULSS(data.Offset(4), X2, X2)
		VMULSS(X1, X2, X1)
		VBROADCASTSS(data.Offset(8), X2)
		VANDPS(X2, X0, X0)
		VCMPSS(Imm(1), data.Offset(12), X0, X0)
		VANDNPS(X1, X0, X0)
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genManhattanNorm_F64() {

	data := GLOBL("dataManhattanNormF64", RODATA|NOPTR)
	DATA(0, U64(0x7fffffffffffffff))
	DATA(8, U64(0x7fffffffffffffff))
	DATA(16, U64(0x7fffffffffffffff))

	TEXT("ManhattanNorm_AVX2_F64", NOSPLIT, "func(x []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB6_1"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB6_4"))
	VXORPD(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB6_7"))

	Label("LBB6_1")
	{
		VXORPS(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB6_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VXORPD(X0, X0, X0)
		VBROADCASTSD(data.Offset(0), Y1)
		XORL(ECX, ECX)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
		VXORPD(X4, X4, X4)
	}

	Label("LBB6_5")
	{
		VANDPD(Mem{Base: RDI}.Idx(RCX, 8), Y1, Y5)
		VADDPD(Y0, Y5, Y0)
		VANDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y1, Y5)
		VADDPD(Y2, Y5, Y2)
		VANDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y1, Y5)
		VANDPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y1, Y6)
		VADDPD(Y3, Y5, Y3)
		VADDPD(Y4, Y6, Y4)
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB6_5"))
		VADDPD(Y0, Y2, Y0)
		VADDPD(Y0, Y3, Y0)
		VADDPD(Y0, Y4, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDSD(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB6_9"))
	}

	Label("LBB6_7")
	{
		VMOVUPD(data.Offset(8), X1)
	}

	Label("LBB6_8")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X2)
		VANDPD(X1, X2, X2)
		VADDSD(X0, X2, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB6_8"))
	}

	Label("LBB6_9")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genManhattanNorm_F32() {
	data := GLOBL("dataManhattanNormF32", RODATA|NOPTR)
	DATA(0, U32(0x7fffffff))

	TEXT("ManhattanNorm_AVX2_F32", NOSPLIT, "func(x []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("x").Len(), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB7_1"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB7_4"))
	VXORPS(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB7_7"))

	Label("LBB7_1")
	{
		VXORPS(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB7_4")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VXORPS(X0, X0, X0)
		VBROADCASTSS(data.Offset(0), Y1)
		XORL(ECX, ECX)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
		VXORPS(X4, X4, X4)
	}

	Label("LBB7_5")
	{
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4), Y1, Y5)
		VADDPS(Y0, Y5, Y0)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y1, Y5)
		VADDPS(Y2, Y5, Y2)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y1, Y5)
		VANDPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y1, Y6)
		VADDPS(Y3, Y5, Y3)
		VADDPS(Y4, Y6, Y4)
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB7_5"))
		VADDPS(Y0, Y2, Y0)
		VADDPS(Y0, Y3, Y0)
		VADDPS(Y0, Y4, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VADDSS(X1, X0, X0)
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB7_9"))
	}

	Label("LBB7_7")
	{
		VBROADCASTSS(data.Offset(0), X1)
	}

	Label("LBB7_8")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X2)
		VANDPS(X1, X2, X2)
		VADDSS(X0, X2, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB7_8"))
	}

	Label("LBB7_9")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genManhattanDistance_F64() {
	data := GLOBL("dataManhattanDistanceF64", RODATA|NOPTR)
	DATA(0, U64(0x7fffffffffffffff))
	DATA(8, U64(0x7fffffffffffffff))
	DATA(16, U64(0x7fffffffffffffff))

	TEXT("ManhattanDistance_AVX2_F64", NOSPLIT, "func(x, y []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB8_1"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB8_4"))
	VXORPD(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB8_7"))

	Label("LBB8_1")
	{
		VXORPS(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB8_4")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		VXORPD(X0, X0, X0)
		VBROADCASTSD(data.Offset(0), Y1)
		XORL(ECX, ECX)
		VXORPD(X2, X2, X2)
		VXORPD(X3, X3, X3)
		VXORPD(X4, X4, X4)
	}

	Label("LBB8_5")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y5)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y6)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(64), Y7)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(96), Y8)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8), Y5, Y5)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y6, Y6)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y7, Y7)
		VSUBPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y8, Y8)
		VANDPD(Y1, Y5, Y5)
		VADDPD(Y0, Y5, Y0)
		VANDPD(Y1, Y6, Y5)
		VADDPD(Y2, Y5, Y2)
		VANDPD(Y1, Y7, Y5)
		VADDPD(Y3, Y5, Y3)
		VANDPD(Y1, Y8, Y5)
		VADDPD(Y4, Y5, Y4)
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB8_5"))
		VADDPD(Y0, Y2, Y0)
		VADDPD(Y0, Y3, Y0)
		VADDPD(Y0, Y4, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPD(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDSD(X1, X0, X0)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB8_9"))
	}

	Label("LBB8_7")
	{
		VMOVUPD(data.Offset(8), X1)
	}

	Label("LBB8_8")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X2)
		VSUBSD(Mem{Base: RSI}.Idx(RAX, 8), X2, X2)
		VANDPD(X1, X2, X2)
		VADDSD(X0, X2, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB8_8"))
	}

	Label("LBB8_9")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genManhattanDistance_F32() {
	data := GLOBL("dataManhattanDistanceF32", RODATA|NOPTR)
	DATA(0, U32(0x7fffffff))

	TEXT("ManhattanDistance_AVX2_F32", NOSPLIT, "func(x, y []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB9_1"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB9_4"))
	VXORPS(X0, X0, X0)
	XORL(EAX, EAX)
	JMP(LabelRef("LBB9_7"))

	Label("LBB9_1")
	{
		VXORPS(X0, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB9_4")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		VXORPS(X0, X0, X0)
		VBROADCASTSS(data.Offset(0), Y1)
		XORL(ECX, ECX)
		VXORPS(X2, X2, X2)
		VXORPS(X3, X3, X3)
		VXORPS(X4, X4, X4)
	}

	Label("LBB9_5")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y5)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y6)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(64), Y7)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(96), Y8)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4), Y5, Y5)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y6, Y6)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y7, Y7)
		VSUBPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y8, Y8)
		VANDPS(Y1, Y5, Y5)
		VADDPS(Y0, Y5, Y0)
		VANDPS(Y1, Y6, Y5)
		VADDPS(Y2, Y5, Y2)
		VANDPS(Y1, Y7, Y5)
		VADDPS(Y3, Y5, Y3)
		VANDPS(Y1, Y8, Y5)
		VADDPS(Y4, Y5, Y4)
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB9_5"))
		VADDPS(Y0, Y2, Y0)
		VADDPS(Y0, Y3, Y0)
		VADDPS(Y0, Y4, Y0)
		VEXTRACTF128(Imm(1), Y0, X1)
		VADDPS(X1, X0, X0)
		VPERMILPD(Imm(1), X0, X1)
		VADDPS(X1, X0, X0)
		VMOVSHDUP(X0, X1)
		VADDSS(X1, X0, X0)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB9_9"))
	}

	Label("LBB9_7")
	{
		VBROADCASTSS(data.Offset(0), X1)
	}

	Label("LBB9_8")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X2)
		VSUBSS(Mem{Base: RSI}.Idx(RAX, 4), X2, X2)
		VANDPS(X1, X2, X2)
		VADDSS(X0, X2, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB9_8"))
	}

	Label("LBB9_9")
	{
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genCosineSimilarity_F64() {

	TEXT("CosineSimilarity_AVX2_F64", NOSPLIT, "func(x, y []float64) float64")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB2_1"))
	CMPQ(RDX, Imm(8))
	JAE(LabelRef("LBB2_5"))
	VXORPD(X1, X1, X1)
	XORL(EAX, EAX)
	VXORPD(X2, X2, X2)
	VXORPD(X0, X0, X0)
	JMP(LabelRef("LBB2_4"))

	Label("LBB2_1")
	{
		VXORPD(X0, X0, X0)
		VXORPD(X1, X1, X1)
		VSQRTSD(X1, X1, X1)
		VDIVSD(X1, X0, X0)
		Store(X0, ReturnIndex(0))
		RET()
	}

	Label("LBB2_5")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-8), RAX)
		VXORPD(X1, X1, X1)
		XORL(ECX, ECX)
		VXORPD(X3, X3, X3)
		VXORPD(X2, X2, X2)
		VXORPD(X4, X4, X4)
		VXORPD(X0, X0, X0)
		VXORPD(X5, X5, X5)
	}

	Label("LBB2_6")
	{
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8), Y6)
		VMOVUPD(Mem{Base: RDI}.Idx(RCX, 8).Offset(32), Y7)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8), Y8)
		VMOVUPD(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y9)
		VFMADD231PD(Y6, Y8, Y0)
		VFMADD231PD(Y7, Y9, Y5)
		VFMADD231PD(Y6, Y6, Y2)
		VFMADD231PD(Y7, Y7, Y4)
		VFMADD231PD(Y8, Y8, Y1)
		VFMADD231PD(Y9, Y9, Y3)
		ADDQ(Imm(8), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB2_6"))
		VADDPD(Y0, Y5, Y0)
		VEXTRACTF128(Imm(1), Y0, X5)
		VADDPD(X5, X0, X0)
		VPERMILPD(Imm(1), X0, X5)
		VADDSD(X5, X0, X0)
		VADDPD(Y2, Y4, Y2)
		VEXTRACTF128(Imm(1), Y2, X4)
		VADDPD(X4, X2, X2)
		VPERMILPD(Imm(1), X2, X4)
		VADDSD(X4, X2, X2)
		VADDPD(Y1, Y3, Y1)
		VEXTRACTF128(Imm(1), Y1, X3)
		VADDPD(X3, X1, X1)
		VPERMILPD(Imm(1), X1, X3)
		VADDSD(X3, X1, X1)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB2_8"))
	}

	Label("LBB2_4")
	{
		VMOVSD(Mem{Base: RDI}.Idx(RAX, 8), X3)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X4)
		VFMADD231SD(X3, X4, X0)
		VFMADD231SD(X3, X3, X2)
		VFMADD231SD(X4, X4, X1)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB2_4"))
	}

	Label("LBB2_8")
	{
		VMULSD(X2, X1, X1)
		VSQRTSD(X1, X1, X1)
		VDIVSD(X1, X0, X0)
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}

func genCosineSimilarity_F32() {
	data := GLOBL("dataCosineSimilarityF32", RODATA|NOPTR)
	DATA(0, U32(0xc0400000))
	DATA(4, U32(0xbf000000))

	TEXT("CosineSimilarity_AVX2_F32", NOSPLIT, "func(x, y []float32) float32")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB3_1"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB3_5"))
	VXORPS(X1, X1, X1)
	XORL(EAX, EAX)
	VXORPS(X2, X2, X2)
	VXORPS(X0, X0, X0)
	JMP(LabelRef("LBB3_4"))

	Label("LBB3_1")
	{
		VXORPS(X0, X0, X0)
		VXORPS(X1, X1, X1)
		JMP(LabelRef("LBB3_9"))
	}

	Label("LBB3_5")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		VXORPS(X1, X1, X1)
		XORL(ECX, ECX)
		VXORPS(X3, X3, X3)
		VXORPS(X2, X2, X2)
		VXORPS(X4, X4, X4)
		VXORPS(X0, X0, X0)
		VXORPS(X5, X5, X5)
	}

	Label("LBB3_6")
	{
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4), Y6)
		VMOVUPS(Mem{Base: RDI}.Idx(RCX, 4).Offset(32), Y7)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4), Y8)
		VMOVUPS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y9)
		VFMADD231PS(Y6, Y8, Y0)
		VFMADD231PS(Y7, Y9, Y5)
		VFMADD231PS(Y6, Y6, Y2)
		VFMADD231PS(Y7, Y7, Y4)
		VFMADD231PS(Y8, Y8, Y1)
		VFMADD231PS(Y9, Y9, Y3)
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB3_6"))
		VADDPS(Y0, Y5, Y0)
		VEXTRACTF128(Imm(1), Y0, X5)
		VADDPS(X5, X0, X0)
		VPERMILPD(Imm(1), X0, X5)
		VADDPS(X5, X0, X0)
		VMOVSHDUP(X0, X5)
		VADDSS(X5, X0, X0)
		VADDPS(Y2, Y4, Y2)
		VEXTRACTF128(Imm(1), Y2, X4)
		VADDPS(X4, X2, X2)
		VPERMILPD(Imm(1), X2, X4)
		VADDPS(X4, X2, X2)
		VMOVSHDUP(X2, X4)
		VADDSS(X4, X2, X2)
		VADDPS(Y1, Y3, Y1)
		VEXTRACTF128(Imm(1), Y1, X3)
		VADDPS(X3, X1, X1)
		VPERMILPD(Imm(1), X1, X3)
		VADDPS(X3, X1, X1)
		VMOVSHDUP(X1, X3)
		VADDSS(X3, X1, X1)
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB3_8"))
	}

	Label("LBB3_4")
	{
		VMOVSS(Mem{Base: RDI}.Idx(RAX, 4), X3)
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X4)
		VFMADD231SS(X3, X4, X0)
		VFMADD231SS(X3, X3, X2)
		VFMADD231SS(X4, X4, X1)
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB3_4"))
	}

	Label("LBB3_8")
	{
		VMULSS(X2, X1, X1)
	}

	Label("LBB3_9")
	{
		VRSQRTSS(X1, X1, X2)
		VMULSS(X2, X1, X1)
		VFMADD213SS(data.Offset(0), X2, X1)
		VMULSS(data.Offset(4), X2, X2)
		VMULSS(X0, X2, X0)
		VMULSS(X0, X1, X0)
		VZEROUPPER()
		Store(X0, ReturnIndex(0))
		RET()
	}
}
