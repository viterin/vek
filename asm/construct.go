package main

import (
	. "github.com/mmcloughlin/avo/build"
	. "github.com/mmcloughlin/avo/operand"
	. "github.com/mmcloughlin/avo/reg"
)

func genRepeat_F64() {

	TEXT("Repeat_AVX2_F64", NOSPLIT, "func(x []float64, a float64, n int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("n"), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB0_12"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB0_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB0_11"))

	Label("LBB0_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, RDX)
		SHRQ(Imm(4), RDX)
		ADDQ(Imm(1), RDX)
		MOVL(EDX, R8L)
		ANDL(Imm(3), R8L)
		CMPQ(RCX, Imm(48))
		JAE(LabelRef("LBB0_5"))
		XORL(ECX, ECX)
		JMP(LabelRef("LBB0_7"))
	}

	Label("LBB0_5")
	{
		ANDQ(I32(-4), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB0_6")
	{
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(256))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(288))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(320))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(352))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(384))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(416))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(448))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(480))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-4), RDX)
		JNE(LabelRef("LBB0_6"))
	}

	Label("LBB0_7")
	{
		TESTQ(R8, R8)
		JE(LabelRef("LBB0_10"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 8), RCX)
		ADDQ(Imm(96), RCX)
		SHLQ(Imm(7), R8)
		XORL(EDX, EDX)
	}

	Label("LBB0_9")
	{
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1).Offset(-96))
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1).Offset(-64))
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1).Offset(-32))
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1))
		SUBQ(I32(-128), RDX)
		CMPQ(R8, RDX)
		JNE(LabelRef("LBB0_9"))
	}

	Label("LBB0_10")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB0_12"))
	}

	Label("LBB0_11")
	{
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB0_11"))
	}

	Label("LBB0_12")
	{
		VZEROUPPER()
		RET()
	}
}

func genRepeat_F32() {

	TEXT("Repeat_AVX2_F32", NOSPLIT, "func(x []float32, a float32, n int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("n"), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB1_12"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB1_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB1_11"))

	Label("LBB1_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, RDX)
		SHRQ(Imm(5), RDX)
		ADDQ(Imm(1), RDX)
		MOVL(EDX, R8L)
		ANDL(Imm(3), R8L)
		CMPQ(RCX, Imm(96))
		JAE(LabelRef("LBB1_5"))
		XORL(ECX, ECX)
		JMP(LabelRef("LBB1_7"))
	}

	Label("LBB1_5")
	{
		ANDQ(I32(-4), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB1_6")
	{
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(256))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(288))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(320))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(352))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(384))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(416))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(448))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(480))
		SUBQ(I32(-128), RCX)
		ADDQ(I32(-4), RDX)
		JNE(LabelRef("LBB1_6"))
	}

	Label("LBB1_7")
	{
		TESTQ(R8, R8)
		JE(LabelRef("LBB1_10"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 4), RCX)
		ADDQ(Imm(96), RCX)
		SHLQ(Imm(7), R8)
		XORL(EDX, EDX)
	}

	Label("LBB1_9")
	{
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1).Offset(-96))
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1).Offset(-64))
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1).Offset(-32))
		VMOVUPS(Y1, Mem{Base: RCX}.Idx(RDX, 1))
		SUBQ(I32(-128), RDX)
		CMPQ(R8, RDX)
		JNE(LabelRef("LBB1_9"))
	}

	Label("LBB1_10")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB1_12"))
	}

	Label("LBB1_11")
	{
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB1_11"))
	}

	Label("LBB1_12")
	{
		VZEROUPPER()
		RET()
	}
}

func genRange_F64() {

	data := GLOBL("dataRangeF64", RODATA|NOPTR)
	DATA(0, U64(0x0000000000000000))
	DATA(8, U64(0x3ff0000000000000))
	DATA(16, U64(0x4000000000000000))
	DATA(24, U64(0x4008000000000000))
	DATA(32, U64(0x4010000000000000))
	DATA(40, U64(0x4020000000000000))
	DATA(48, U64(0x4028000000000000))
	DATA(56, U64(0x4030000000000000))
	DATA(64, U64(0x4034000000000000))
	DATA(72, U64(0x4038000000000000))
	DATA(80, U64(0x403c000000000000))
	DATA(88, U64(0x4040000000000000))
	DATA(96, U64(0x3ff0000000000000))

	TEXT("Range_AVX2_F64", NOSPLIT, "func(x []float64, a float64, n int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("n"), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB2_13"))
	CMPQ(RSI, Imm(16))
	JAE(LabelRef("LBB2_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB2_11"))

	Label("LBB2_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-16), RAX)
		VBROADCASTSD(X0, Y1)
		VADDPD(data.Offset(0), Y1, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB2_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
		VBROADCASTSD(data.Offset(32), Y2)
		VBROADCASTSD(data.Offset(40), Y3)
		VBROADCASTSD(data.Offset(48), Y4)
		VBROADCASTSD(data.Offset(56), Y5)
		VBROADCASTSD(data.Offset(64), Y6)
		VBROADCASTSD(data.Offset(72), Y7)
		VBROADCASTSD(data.Offset(80), Y8)
		VBROADCASTSD(data.Offset(88), Y9)
	}

	Label("LBB2_6")
	{
		VADDPD(Y2, Y1, Y10)
		VADDPD(Y3, Y1, Y11)
		VADDPD(Y4, Y1, Y12)
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y10, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y11, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y12, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VADDPD(Y5, Y1, Y10)
		VADDPD(Y6, Y1, Y11)
		VADDPD(Y7, Y1, Y12)
		VADDPD(Y1, Y8, Y13)
		VMOVUPD(Y10, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPD(Y11, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPD(Y12, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPD(Y13, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		VADDPD(Y1, Y9, Y1)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB2_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB2_9"))
	}

	Label("LBB2_8")
	{
		VBROADCASTSD(data.Offset(32), Y2)
		VADDPD(Y2, Y1, Y2)
		VBROADCASTSD(data.Offset(40), Y3)
		VADDPD(Y3, Y1, Y3)
		VBROADCASTSD(data.Offset(48), Y4)
		VADDPD(Y4, Y1, Y4)
		VMOVUPD(Y1, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB2_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB2_13"))
		VCVTSI2SDQ(RAX, X14, X1)
		VADDSD(X0, X1, X0)
	}

	Label("LBB2_11")
	{
		VMOVSD(data.Offset(96), X1)
	}

	Label("LBB2_12")
	{
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		VADDSD(X1, X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB2_12"))
	}

	Label("LBB2_13")
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

func genRange_F32() {

	data := GLOBL("dataRangeF32", RODATA|NOPTR)
	DATA(0, U32(0x00000000))
	DATA(4, U32(0x3f800000))
	DATA(8, U32(0x40000000))
	DATA(12, U32(0x40400000))
	DATA(16, U32(0x40800000))
	DATA(20, U32(0x40a00000))
	DATA(24, U32(0x40c00000))
	DATA(28, U32(0x40e00000))

	DATA(32, U32(0x41000000))
	DATA(36, U32(0x41800000))
	DATA(40, U32(0x41c00000))
	DATA(44, U32(0x42000000))
	DATA(48, U32(0x42200000))
	DATA(52, U32(0x42400000))
	DATA(56, U32(0x42600000))
	DATA(60, U32(0x42800000))
	DATA(64, U32(0x3f800000))

	TEXT("Range_AVX2_F32", NOSPLIT, "func(x []float32, a float32, n int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("a"), X0)
	Load(Param("n"), RSI)

	TESTQ(RSI, RSI)
	JE(LabelRef("LBB3_13"))
	CMPQ(RSI, Imm(32))
	JAE(LabelRef("LBB3_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB3_11"))

	Label("LBB3_3")
	{
		MOVQ(RSI, RAX)
		ANDQ(I32(-32), RAX)
		VBROADCASTSS(X0, Y1)
		VADDPS(data.Offset(0), Y1, Y1)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB3_4"))
		MOVQ(R8, RDX)
		ANDQ(I32(-2), RDX)
		XORL(ECX, ECX)
		VBROADCASTSS(data.Offset(32), Y2)
		VBROADCASTSS(data.Offset(36), Y3)
		VBROADCASTSS(data.Offset(40), Y4)
		VBROADCASTSS(data.Offset(44), Y5)
		VBROADCASTSS(data.Offset(48), Y6)
		VBROADCASTSS(data.Offset(52), Y7)
		VBROADCASTSS(data.Offset(56), Y8)
		VBROADCASTSS(data.Offset(60), Y9)
	}

	Label("LBB3_6")
	{
		VADDPS(Y2, Y1, Y10)
		VADDPS(Y3, Y1, Y11)
		VADDPS(Y4, Y1, Y12)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y10, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y11, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y12, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VADDPS(Y5, Y1, Y10)
		VADDPS(Y6, Y1, Y11)
		VADDPS(Y7, Y1, Y12)
		VADDPS(Y1, Y8, Y13)
		VMOVUPS(Y10, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y11, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y12, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y13, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		VADDPS(Y1, Y9, Y1)
		ADDQ(I32(-2), RDX)
		JNE(LabelRef("LBB3_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB3_9"))
	}

	Label("LBB3_8")
	{
		VBROADCASTSS(data.Offset(32), Y2)
		VADDPS(Y2, Y1, Y2)
		VBROADCASTSS(data.Offset(36), Y3)
		VADDPS(Y3, Y1, Y3)
		VBROADCASTSS(data.Offset(40), Y4)
		VADDPS(Y4, Y1, Y4)
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB3_9")
	{
		CMPQ(RAX, RSI)
		JE(LabelRef("LBB3_13"))
		VCVTSI2SSQ(RAX, X14, X1)
		VADDSS(X0, X1, X0)
	}

	Label("LBB3_11")
	{
		VMOVSS(data.Offset(64), X1)
	}

	Label("LBB3_12")
	{
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		VADDSS(X1, X0, X0)
		ADDQ(Imm(1), RAX)
		CMPQ(RSI, RAX)
		JNE(LabelRef("LBB3_12"))
	}

	Label("LBB3_13")
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

func genGather_F64() {

	TEXT("Gather_AVX2_F64", NOSPLIT, "func(x, y []float64, z []int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("z").Base(), RDX)
	Load(Param("z").Len(), RCX)

	TESTQ(RCX, RCX)
	JE(LabelRef("LBB4_7"))
	CMPQ(RCX, Imm(16))
	JAE(LabelRef("LBB4_3"))
	XORL(R8L, R8L)
	JMP(LabelRef("LBB4_6"))

	Label("LBB4_3")
	{
		MOVQ(RCX, R8)
		ANDQ(I32(-16), R8)
		XORL(R9L, R9L)
	}

	Label("LBB4_4")
	{
		MOVQ(Mem{Base: RDX}.Idx(R9, 8), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(8), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X0, X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(16), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X1)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(24), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X1, X1)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(32), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X2)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(40), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X2, X2)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(48), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X3)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(56), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X3, X3)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(64), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X4)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(72), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X4, X4)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(80), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X5)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(88), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X5, X5)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(96), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X6)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(104), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X6, X6)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(112), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X7)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(120), RAX)
		VMOVHPS(Mem{Base: RSI}.Idx(RAX, 8), X7, X7)
		VMOVUPS(X1, Mem{Base: RDI}.Idx(R9, 8).Offset(16))
		VMOVUPS(X0, Mem{Base: RDI}.Idx(R9, 8))
		VMOVUPS(X3, Mem{Base: RDI}.Idx(R9, 8).Offset(48))
		VMOVUPS(X2, Mem{Base: RDI}.Idx(R9, 8).Offset(32))
		VMOVUPS(X5, Mem{Base: RDI}.Idx(R9, 8).Offset(80))
		VMOVUPS(X4, Mem{Base: RDI}.Idx(R9, 8).Offset(64))
		VMOVUPS(X7, Mem{Base: RDI}.Idx(R9, 8).Offset(112))
		VMOVUPS(X6, Mem{Base: RDI}.Idx(R9, 8).Offset(96))
		ADDQ(Imm(16), R9)
		CMPQ(R8, R9)
		JNE(LabelRef("LBB4_4"))
		CMPQ(R8, RCX)
		JE(LabelRef("LBB4_7"))
	}

	Label("LBB4_6")
	{
		MOVQ(Mem{Base: RDX}.Idx(R8, 8), RAX)
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(R8, 8))
		ADDQ(Imm(1), R8)
		CMPQ(RCX, R8)
		JNE(LabelRef("LBB4_6"))
	}

	Label("LBB4_7")
	{
		RET()
	}
}

func genGather_F32() {

	TEXT("Gather_AVX2_F32", NOSPLIT, "func(x, y []float32, z []int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("z").Base(), RDX)
	Load(Param("z").Len(), RCX)

	TESTQ(RCX, RCX)
	JE(LabelRef("LBB5_7"))
	CMPQ(RCX, Imm(16))
	JAE(LabelRef("LBB5_3"))
	XORL(R8L, R8L)
	JMP(LabelRef("LBB5_6"))

	Label("LBB5_3")
	{
		MOVQ(RCX, R8)
		ANDQ(I32(-16), R8)
		XORL(R9L, R9L)
	}

	Label("LBB5_4")
	{
		MOVQ(Mem{Base: RDX}.Idx(R9, 8), RAX)
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(8), RAX)
		VINSERTPS(Imm(16), Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(16), RAX)
		VINSERTPS(Imm(32), Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(24), RAX)
		VINSERTPS(Imm(48), Mem{Base: RSI}.Idx(RAX, 4), X0, X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(32), RAX)
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X1)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(40), RAX)
		VINSERTPS(Imm(16), Mem{Base: RSI}.Idx(RAX, 4), X1, X1)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(48), RAX)
		VINSERTPS(Imm(32), Mem{Base: RSI}.Idx(RAX, 4), X1, X1)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(56), RAX)
		VINSERTPS(Imm(48), Mem{Base: RSI}.Idx(RAX, 4), X1, X1)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(64), RAX)
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X2)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(72), RAX)
		VINSERTPS(Imm(16), Mem{Base: RSI}.Idx(RAX, 4), X2, X2)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(80), RAX)
		VINSERTPS(Imm(32), Mem{Base: RSI}.Idx(RAX, 4), X2, X2)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(88), RAX)
		VINSERTPS(Imm(48), Mem{Base: RSI}.Idx(RAX, 4), X2, X2)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(96), RAX)
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X3)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(104), RAX)
		VINSERTPS(Imm(16), Mem{Base: RSI}.Idx(RAX, 4), X3, X3)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(112), RAX)
		VINSERTPS(Imm(32), Mem{Base: RSI}.Idx(RAX, 4), X3, X3)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(120), RAX)
		VINSERTPS(Imm(48), Mem{Base: RSI}.Idx(RAX, 4), X3, X3)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(R9, 4))
		VMOVUPS(X1, Mem{Base: RDI}.Idx(R9, 4).Offset(16))
		VMOVUPS(X2, Mem{Base: RDI}.Idx(R9, 4).Offset(32))
		VMOVUPS(X3, Mem{Base: RDI}.Idx(R9, 4).Offset(48))
		ADDQ(Imm(16), R9)
		CMPQ(R8, R9)
		JNE(LabelRef("LBB5_4"))
		CMPQ(R8, RCX)
		JE(LabelRef("LBB5_7"))
	}

	Label("LBB5_6")
	{
		MOVQ(Mem{Base: RDX}.Idx(R8, 8), RAX)
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(R8, 4))
		ADDQ(Imm(1), R8)
		CMPQ(RCX, R8)
		JNE(LabelRef("LBB5_6"))
	}

	Label("LBB5_7")
	{
		RET()
	}
}

func genScatter_F64() {

	TEXT("Scatter_AVX2_F64", NOSPLIT, "func(x, y []float64, z []int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("z").Base(), RDX)
	Load(Param("z").Len(), RCX)

	TESTQ(RCX, RCX)
	JE(LabelRef("LBB6_8"))
	LEAQ(Mem{Base: RCX}.Offset(-1), RAX)
	MOVL(ECX, R8L)
	ANDL(Imm(3), R8L)
	CMPQ(RAX, Imm(3))
	JAE(LabelRef("LBB6_3"))
	XORL(R9L, R9L)
	JMP(LabelRef("LBB6_5"))

	Label("LBB6_3")
	{
		ANDQ(I32(-4), RCX)
		XORL(R9L, R9L)
	}

	Label("LBB6_4")
	{
		VMOVSD(Mem{Base: RSI}.Idx(R9, 8), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8), RAX)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		VMOVSD(Mem{Base: RSI}.Idx(R9, 8).Offset(8), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(8), RAX)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		VMOVSD(Mem{Base: RSI}.Idx(R9, 8).Offset(16), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(16), RAX)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		VMOVSD(Mem{Base: RSI}.Idx(R9, 8).Offset(24), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(24), RAX)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(4), R9)
		CMPQ(RCX, R9)
		JNE(LabelRef("LBB6_4"))
	}

	Label("LBB6_5")
	{
		TESTQ(R8, R8)
		JE(LabelRef("LBB6_8"))
		LEAQ(Mem{Base: RDX}.Idx(R9, 8), RCX)
		LEAQ(Mem{Base: RSI}.Idx(R9, 8), RAX)
		XORL(EDX, EDX)
	}

	Label("LBB6_7")
	{
		VMOVSD(Mem{Base: RAX}.Idx(RDX, 8), X0)
		MOVQ(Mem{Base: RCX}.Idx(RDX, 8), RSI)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RSI, 8))
		ADDQ(Imm(1), RDX)
		CMPQ(R8, RDX)
		JNE(LabelRef("LBB6_7"))
	}

	Label("LBB6_8")
	{
		RET()
	}
}

func genScatter_F32() {

	TEXT("Scatter_AVX2_F32", NOSPLIT, "func(x, y []float32, z []int)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("z").Base(), RDX)
	Load(Param("z").Len(), RCX)

	TESTQ(RCX, RCX)
	JE(LabelRef("LBB7_8"))
	LEAQ(Mem{Base: RCX}.Offset(-1), RAX)
	MOVL(ECX, R8L)
	ANDL(Imm(3), R8L)
	CMPQ(RAX, Imm(3))
	JAE(LabelRef("LBB7_3"))
	XORL(R9L, R9L)
	JMP(LabelRef("LBB7_5"))

	Label("LBB7_3")
	{
		ANDQ(I32(-4), RCX)
		XORL(R9L, R9L)
	}

	Label("LBB7_4")
	{
		VMOVSS(Mem{Base: RSI}.Idx(R9, 4), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8), RAX)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		VMOVSS(Mem{Base: RSI}.Idx(R9, 4).Offset(4), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(8), RAX)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		VMOVSS(Mem{Base: RSI}.Idx(R9, 4).Offset(8), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(16), RAX)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		VMOVSS(Mem{Base: RSI}.Idx(R9, 4).Offset(12), X0)
		MOVQ(Mem{Base: RDX}.Idx(R9, 8).Offset(24), RAX)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(4), R9)
		CMPQ(RCX, R9)
		JNE(LabelRef("LBB7_4"))
	}

	Label("LBB7_5")
	{
		TESTQ(R8, R8)
		JE(LabelRef("LBB7_8"))
		LEAQ(Mem{Base: RDX}.Idx(R9, 8), RCX)
		LEAQ(Mem{Base: RSI}.Idx(R9, 4), RAX)
		XORL(EDX, EDX)
	}

	Label("LBB7_7")
	{
		VMOVSS(Mem{Base: RAX}.Idx(RDX, 4), X0)
		MOVQ(Mem{Base: RCX}.Idx(RDX, 8), RSI)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RSI, 4))
		ADDQ(Imm(1), RDX)
		CMPQ(R8, RDX)
		JNE(LabelRef("LBB7_7"))
	}

	Label("LBB7_8")
	{
		RET()
	}
}

func genFromBool_F64() {
	data := GLOBL("dataFromBoolF64", RODATA|NOPTR)
	DATA(0, I32(1))
	DATA(4, U64(0x3ff0000000000000))

	TEXT("FromBool_AVX2_F64", NOSPLIT, "func(x []float64, y []bool)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB4_10"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB4_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB4_6"))

	Label("LBB4_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		XORL(ECX, ECX)
		VPXOR(X0, X0, X0)
		VPCMPEQD(X1, X1, X1)
		VPBROADCASTD(data.Offset(0), X2)
	}

	Label("LBB4_4")
	{
		VMOVD(Mem{Base: RSI}.Idx(RCX, 1), X3)
		VMOVD(Mem{Base: RSI}.Idx(RCX, 1).Offset(4), X4)
		VMOVD(Mem{Base: RSI}.Idx(RCX, 1).Offset(8), X5)
		VMOVD(Mem{Base: RSI}.Idx(RCX, 1).Offset(12), X6)
		VPCMPEQB(X0, X3, X3)
		VPXOR(X1, X3, X3)
		VPMOVZXBD(X3, X3)
		VPAND(X2, X3, X3)
		VCVTDQ2PD(X3, Y3)
		VPCMPEQB(X0, X4, X4)
		VPXOR(X1, X4, X4)
		VPMOVZXBD(X4, X4)
		VPAND(X2, X4, X4)
		VCVTDQ2PD(X4, Y4)
		VPCMPEQB(X0, X5, X5)
		VPXOR(X1, X5, X5)
		VPMOVZXBD(X5, X5)
		VPAND(X2, X5, X5)
		VCVTDQ2PD(X5, Y5)
		VPCMPEQB(X0, X6, X6)
		VPXOR(X1, X6, X6)
		VPMOVZXBD(X6, X6)
		VPAND(X2, X6, X6)
		VCVTDQ2PD(X6, Y6)
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y6, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB4_4"))
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB4_6"))
	}

	Label("LBB4_10")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB4_6")
	{
		VMOVQ(data.Offset(4), X0)
		JMP(LabelRef("LBB4_7"))
	}

	Label("LBB4_9")
	{
		VMOVQ(X1, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JE(LabelRef("LBB4_10"))
	}

	Label("LBB4_7")
	{
		CMPB(Mem{Base: RSI}.Idx(RAX, 1), Imm(0))
		VMOVDQA(X0, X1)
		JNE(LabelRef("LBB4_9"))
		VPXOR(X1, X1, X1)
		JMP(LabelRef("LBB4_9"))
	}
}

func genFromBool_F32() {

	data := GLOBL("dataFromBoolF32", RODATA|NOPTR)
	DATA(0, I32(1))
	DATA(4, I32(0x3f800000))

	TEXT("FromBool_AVX2_F32", NOSPLIT, "func(x []float32, y []bool)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB5_10"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB5_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB5_6"))

	Label("LBB5_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
		VPXOR(X0, X0, X0)
		VPCMPEQD(X1, X1, X1)
		VPBROADCASTD(data.Offset(0), Y2)
	}

	Label("LBB5_4")
	{
		VMOVQ(Mem{Base: RSI}.Idx(RCX, 1), X3)
		VMOVQ(Mem{Base: RSI}.Idx(RCX, 1).Offset(8), X4)
		VMOVQ(Mem{Base: RSI}.Idx(RCX, 1).Offset(16), X5)
		VMOVQ(Mem{Base: RSI}.Idx(RCX, 1).Offset(24), X6)
		VPCMPEQB(X0, X3, X3)
		VPXOR(X1, X3, X3)
		VPMOVZXBD(X3, Y3)
		VPAND(Y2, Y3, Y3)
		VCVTDQ2PS(Y3, Y3)
		VPCMPEQB(X0, X4, X4)
		VPXOR(X1, X4, X4)
		VPMOVZXBD(X4, Y4)
		VPAND(Y2, Y4, Y4)
		VCVTDQ2PS(Y4, Y4)
		VPCMPEQB(X0, X5, X5)
		VPXOR(X1, X5, X5)
		VPMOVZXBD(X5, Y5)
		VPAND(Y2, Y5, Y5)
		VCVTDQ2PS(Y5, Y5)
		VPCMPEQB(X0, X6, X6)
		VPXOR(X1, X6, X6)
		VPMOVZXBD(X6, Y6)
		VPAND(Y2, Y6, Y6)
		VCVTDQ2PS(Y6, Y6)
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y4, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y5, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y6, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB5_4"))
		CMPQ(RAX, RDX)
		JNE(LabelRef("LBB5_6"))
	}

	Label("LBB5_10")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB5_6")
	{
		VMOVD(data.Offset(4), X0)
		JMP(LabelRef("LBB5_7"))
	}

	Label("LBB5_9")
	{
		VMOVD(X1, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JE(LabelRef("LBB5_10"))
	}

	Label("LBB5_7")
	{
		CMPB(Mem{Base: RSI}.Idx(RAX, 1), Imm(0))
		VMOVDQA(X0, X1)
		JNE(LabelRef("LBB5_9"))
		VPXOR(X1, X1, X1)
		JMP(LabelRef("LBB5_9"))
	}
}

func genFromFloat32_F64() {

	TEXT("FromFloat32_AVX2_F64", NOSPLIT, "func(x []float64, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB6_11"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB6_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB6_10"))

	Label("LBB6_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB6_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB6_6")
	{
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(16), Y1)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y2)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(48), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y0)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(80), Y1)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y2)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(112), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB6_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB6_9"))
	}

	Label("LBB6_8")
	{
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(16), Y1)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y2)
		VCVTPS2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(48), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB6_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB6_11"))
	}

	Label("LBB6_10")
	{
		VMOVSS(Mem{Base: RSI}.Idx(RAX, 4), X0)
		VCVTSS2SD(X0, X0, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
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

func genFromFloat64_F32() {

	TEXT("FromFloat64_AVX2_F32", NOSPLIT, "func(x []float32, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB7_11"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB7_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB7_10"))

	Label("LBB7_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB7_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB7_6")
	{
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X1)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X2)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X3)
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(16))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(48))
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(128), X0)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(160), X1)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(192), X2)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(224), X3)
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(80))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(112))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB7_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB7_9"))
	}

	Label("LBB7_8")
	{
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X1)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X2)
		VCVTPD2PSY(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X3)
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(16))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(48))
	}

	Label("LBB7_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB7_11"))
	}

	Label("LBB7_10")
	{
		VMOVSD(Mem{Base: RSI}.Idx(RAX, 8), X0)
		VCVTSD2SS(X0, X0, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB7_10"))
	}

	Label("LBB7_11")
	{
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

func genFromInt64_F64() {

	TEXT("FromInt64_AVX2_F64", NOSPLIT, "func(x []float64, y []int64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB8_11"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB8_3"))
	XORL(R10L, R10L)
	JMP(LabelRef("LBB8_10"))

	Label("LBB8_3")
	{
		MOVQ(RDX, R10)
		ANDQ(I32(-16), R10)
		LEAQ(Mem{Base: R10}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB8_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB8_6")
	{
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(16), X1)
		VPEXTRQ(Imm(1), X0, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X3)
		VMOVQ(X0, RAX)
		VCVTSI2SDQ(RAX, X11, X0)
		VPEXTRQ(Imm(1), X1, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(48), X5)
		VMOVQ(X1, RAX)
		VCVTSI2SDQ(RAX, X11, X1)
		VPEXTRQ(Imm(1), X5, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VUNPCKLPD(X2, X0, X8)
		VMOVQ(X5, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VPEXTRQ(Imm(1), X3, RAX)
		VCVTSI2SDQ(RAX, X11, X5)
		VUNPCKLPD(X4, X1, X10)
		VMOVQ(X3, RAX)
		VCVTSI2SDQ(RAX, X11, X3)
		VUNPCKLPD(X6, X2, X9)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(80), X4)
		VPEXTRQ(Imm(1), X4, RAX)
		VUNPCKLPD(X5, X3, X3)
		VCVTSI2SDQ(RAX, X11, X5)
		VMOVQ(X4, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VUNPCKLPD(X5, X4, X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X5)
		VPEXTRQ(Imm(1), X5, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VMOVQ(X5, RAX)
		VCVTSI2SDQ(RAX, X11, X5)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(112), X7)
		VPEXTRQ(Imm(1), X7, RAX)
		VCVTSI2SDQ(RAX, X11, X0)
		VMOVQ(X7, RAX)
		VCVTSI2SDQ(RAX, X11, X7)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X2)
		VPEXTRQ(Imm(1), X2, RAX)
		VCVTSI2SDQ(RAX, X11, X1)
		VUNPCKLPD(X6, X5, X5)
		VMOVQ(X2, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VUNPCKLPD(X0, X7, X0)
		VUNPCKLPD(X1, X2, X1)
		VMOVUPD(X10, Mem{Base: RDI}.Idx(RCX, 8).Offset(16))
		VMOVUPD(X8, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(X9, Mem{Base: RDI}.Idx(RCX, 8).Offset(48))
		VMOVUPD(X5, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(X4, Mem{Base: RDI}.Idx(RCX, 8).Offset(80))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(112))
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(128), X0)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(144), X1)
		VPEXTRQ(Imm(1), X0, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(160), X3)
		VMOVQ(X0, RAX)
		VCVTSI2SDQ(RAX, X11, X0)
		VPEXTRQ(Imm(1), X1, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(176), X5)
		VMOVQ(X1, RAX)
		VCVTSI2SDQ(RAX, X11, X1)
		VPEXTRQ(Imm(1), X5, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VUNPCKLPD(X2, X0, X8)
		VMOVQ(X5, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VPEXTRQ(Imm(1), X3, RAX)
		VCVTSI2SDQ(RAX, X11, X5)
		VUNPCKLPD(X4, X1, X10)
		VMOVQ(X3, RAX)
		VCVTSI2SDQ(RAX, X11, X3)
		VUNPCKLPD(X6, X2, X9)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(208), X4)
		VPEXTRQ(Imm(1), X4, RAX)
		VUNPCKLPD(X5, X3, X3)
		VCVTSI2SDQ(RAX, X11, X5)
		VMOVQ(X4, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VUNPCKLPD(X5, X4, X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(192), X5)
		VPEXTRQ(Imm(1), X5, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VMOVQ(X5, RAX)
		VCVTSI2SDQ(RAX, X11, X5)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(240), X7)
		VPEXTRQ(Imm(1), X7, RAX)
		VCVTSI2SDQ(RAX, X11, X0)
		VMOVQ(X7, RAX)
		VCVTSI2SDQ(RAX, X11, X7)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(224), X2)
		VPEXTRQ(Imm(1), X2, RAX)
		VCVTSI2SDQ(RAX, X11, X1)
		VUNPCKLPD(X6, X5, X5)
		VMOVQ(X2, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VUNPCKLPD(X0, X7, X0)
		VUNPCKLPD(X1, X2, X1)
		VMOVUPD(X10, Mem{Base: RDI}.Idx(RCX, 8).Offset(144))
		VMOVUPD(X8, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPD(X9, Mem{Base: RDI}.Idx(RCX, 8).Offset(176))
		VMOVUPD(X5, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPD(X4, Mem{Base: RDI}.Idx(RCX, 8).Offset(208))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(240))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB8_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB8_9"))
	}

	Label("LBB8_8")
	{
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(16), X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X3)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(48), X2)
		VPEXTRQ(Imm(1), X0, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVQ(X0, RAX)
		VCVTSI2SDQ(RAX, X11, X0)
		VUNPCKLPD(X4, X0, X8)
		VPEXTRQ(Imm(1), X1, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVQ(X1, RAX)
		VCVTSI2SDQ(RAX, X11, X1)
		VUNPCKLPD(X4, X1, X1)
		VPEXTRQ(Imm(1), X2, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVQ(X2, RAX)
		VCVTSI2SDQ(RAX, X11, X2)
		VUNPCKLPD(X4, X2, X2)
		VPEXTRQ(Imm(1), X3, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVQ(X3, RAX)
		VCVTSI2SDQ(RAX, X11, X3)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(80), X5)
		VPEXTRQ(Imm(1), X5, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VMOVQ(X5, RAX)
		VCVTSI2SDQ(RAX, X11, X5)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X7)
		VPEXTRQ(Imm(1), X7, RAX)
		VCVTSI2SDQ(RAX, X11, X0)
		VUNPCKLPD(X4, X3, X3)
		VMOVQ(X7, RAX)
		VCVTSI2SDQ(RAX, X11, X4)
		VUNPCKLPD(X6, X5, X5)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(112), X6)
		VPEXTRQ(Imm(1), X6, RAX)
		VUNPCKLPD(X0, X4, X0)
		VCVTSI2SDQ(RAX, X11, X4)
		VMOVQ(X6, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VUNPCKLPD(X4, X6, X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X6)
		VPEXTRQ(Imm(1), X6, RAX)
		VCVTSI2SDQ(RAX, X11, X7)
		VMOVQ(X6, RAX)
		VCVTSI2SDQ(RAX, X11, X6)
		VUNPCKLPD(X7, X6, X6)
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 8).Offset(16))
		VMOVUPD(X8, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 8).Offset(48))
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPD(X5, Mem{Base: RDI}.Idx(RCX, 8).Offset(80))
		VMOVUPD(X6, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VMOVUPD(X4, Mem{Base: RDI}.Idx(RCX, 8).Offset(112))
	}

	Label("LBB8_9")
	{
		CMPQ(R10, RDX)
		JE(LabelRef("LBB8_11"))
	}

	Label("LBB8_10")
	{
		VCVTSI2SDQ(Mem{Base: RSI}.Idx(R10, 8), X11, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(R10, 8))
		ADDQ(Imm(1), R10)
		CMPQ(RDX, R10)
		JNE(LabelRef("LBB8_10"))
	}

	Label("LBB8_11")
	{
		RET()
	}

	Label("LBB8_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB8_8"))
		JMP(LabelRef("LBB8_9"))
	}
}

func genFromInt64_F32() {

	TEXT("FromInt64_AVX2_F32", NOSPLIT, "func(x []float32, y []int64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB9_11"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB9_3"))
	XORL(R11L, R11L)
	JMP(LabelRef("LBB9_10"))

	Label("LBB9_3")
	{
		MOVQ(RDX, R11)
		ANDQ(I32(-16), R11)
		LEAQ(Mem{Base: R11}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB9_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB9_6")
	{
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VPEXTRQ(Imm(1), X0, R10)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(16), X1)
		VCVTSI2SSQ(R10, X8, X2)
		VMOVQ(X0, RAX)
		VCVTSI2SSQ(RAX, X8, X0)
		VMOVQ(X1, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VPEXTRQ(Imm(1), X1, RAX)
		VCVTSI2SSQ(RAX, X8, X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X4)
		VPEXTRQ(Imm(1), X4, RAX)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(48), X5)
		VCVTSI2SSQ(RAX, X8, X6)
		VMOVQ(X4, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVQ(X5, RAX)
		VCVTSI2SSQ(RAX, X8, X7)
		VINSERTPS(Imm(16), X2, X0, X0)
		VINSERTPS(Imm(32), X3, X0, X0)
		VPEXTRQ(Imm(1), X5, RAX)
		VINSERTPS(Imm(48), X1, X0, X0)
		VCVTSI2SSQ(RAX, X8, X1)
		VINSERTPS(Imm(16), X6, X4, X2)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X3)
		VPEXTRQ(Imm(1), X3, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVQ(X3, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(80), X5)
		VMOVQ(X5, RAX)
		VCVTSI2SSQ(RAX, X8, X6)
		VINSERTPS(Imm(32), X7, X2, X2)
		VINSERTPS(Imm(48), X1, X2, X1)
		VPEXTRQ(Imm(1), X5, RAX)
		VINSERTPS(Imm(16), X4, X3, X2)
		VCVTSI2SSQ(RAX, X8, X3)
		VINSERTPS(Imm(32), X6, X2, X2)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X4)
		VPEXTRQ(Imm(1), X4, RAX)
		VCVTSI2SSQ(RAX, X8, X5)
		VMOVQ(X4, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(112), X6)
		VMOVQ(X6, RAX)
		VCVTSI2SSQ(RAX, X8, X7)
		VINSERTPS(Imm(48), X3, X2, X2)
		VINSERTPS(Imm(16), X5, X4, X3)
		VPEXTRQ(Imm(1), X6, RAX)
		VINSERTPS(Imm(32), X7, X3, X3)
		VCVTSI2SSQ(RAX, X8, X4)
		VINSERTPS(Imm(48), X4, X3, X3)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(16))
		VMOVUPS(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(48))
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(128), X0)
		VPEXTRQ(Imm(1), X0, RAX)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(144), X1)
		VCVTSI2SSQ(RAX, X8, X2)
		VMOVQ(X0, RAX)
		VCVTSI2SSQ(RAX, X8, X0)
		VMOVQ(X1, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VPEXTRQ(Imm(1), X1, RAX)
		VCVTSI2SSQ(RAX, X8, X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(160), X4)
		VPEXTRQ(Imm(1), X4, RAX)
		VCVTSI2SSQ(RAX, X8, X5)
		VMOVQ(X4, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VINSERTPS(Imm(16), X2, X0, X0)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(176), X2)
		VPEXTRQ(Imm(1), X2, R10)
		VMOVQ(X2, RAX)
		VCVTSI2SSQ(RAX, X8, X2)
		VINSERTPS(Imm(32), X3, X0, X0)
		VCVTSI2SSQ(R10, X8, X3)
		VINSERTPS(Imm(48), X1, X0, X0)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(192), X1)
		VPEXTRQ(Imm(1), X1, RAX)
		VINSERTPS(Imm(16), X5, X4, X4)
		VCVTSI2SSQ(RAX, X8, X5)
		VMOVQ(X1, RAX)
		VCVTSI2SSQ(RAX, X8, X1)
		VINSERTPS(Imm(32), X2, X4, X2)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(208), X4)
		VPEXTRQ(Imm(1), X4, R10)
		VMOVQ(X4, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VINSERTPS(Imm(48), X3, X2, X2)
		VCVTSI2SSQ(R10, X8, X3)
		VINSERTPS(Imm(16), X5, X1, X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(224), X5)
		VPEXTRQ(Imm(1), X5, RAX)
		VINSERTPS(Imm(32), X4, X1, X1)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVQ(X5, RAX)
		VCVTSI2SSQ(RAX, X8, X5)
		VINSERTPS(Imm(48), X3, X1, X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(240), X3)
		VPEXTRQ(Imm(1), X3, R10)
		VMOVQ(X3, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VINSERTPS(Imm(16), X4, X5, X4)
		VCVTSI2SSQ(R10, X8, X5)
		VINSERTPS(Imm(32), X3, X4, X3)
		VINSERTPS(Imm(48), X5, X3, X3)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(80))
		VMOVUPS(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VMOVUPS(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(112))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB9_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB9_9"))
	}

	Label("LBB9_8")
	{
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VPEXTRQ(Imm(1), X0, RAX)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(16), X1)
		VCVTSI2SSQ(RAX, X8, X2)
		VMOVQ(X0, RAX)
		VCVTSI2SSQ(RAX, X8, X0)
		VMOVQ(X1, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VPEXTRQ(Imm(1), X1, RAX)
		VCVTSI2SSQ(RAX, X8, X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X4)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(48), X5)
		VPEXTRQ(Imm(1), X4, RAX)
		VINSERTPS(Imm(16), X2, X0, X0)
		VCVTSI2SSQ(RAX, X8, X2)
		VMOVQ(X4, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVQ(X5, RAX)
		VCVTSI2SSQ(RAX, X8, X6)
		VINSERTPS(Imm(32), X3, X0, X0)
		VINSERTPS(Imm(48), X1, X0, X0)
		VPEXTRQ(Imm(1), X5, RAX)
		VINSERTPS(Imm(16), X2, X4, X1)
		VCVTSI2SSQ(RAX, X8, X2)
		VINSERTPS(Imm(32), X6, X1, X1)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X3)
		VPEXTRQ(Imm(1), X3, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVQ(X3, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(80), X5)
		VMOVQ(X5, RAX)
		VCVTSI2SSQ(RAX, X8, X6)
		VINSERTPS(Imm(48), X2, X1, X1)
		VINSERTPS(Imm(16), X4, X3, X2)
		VPEXTRQ(Imm(1), X5, RAX)
		VINSERTPS(Imm(32), X6, X2, X2)
		VCVTSI2SSQ(RAX, X8, X3)
		VINSERTPS(Imm(48), X3, X2, X2)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X3)
		VPEXTRQ(Imm(1), X3, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VMOVQ(X3, RAX)
		VCVTSI2SSQ(RAX, X8, X3)
		VMOVDQU(Mem{Base: RSI}.Idx(RCX, 8).Offset(112), X5)
		VMOVQ(X5, RAX)
		VCVTSI2SSQ(RAX, X8, X6)
		VINSERTPS(Imm(16), X4, X3, X3)
		VINSERTPS(Imm(32), X6, X3, X3)
		VPEXTRQ(Imm(1), X5, RAX)
		VCVTSI2SSQ(RAX, X8, X4)
		VINSERTPS(Imm(48), X4, X3, X3)
		VMOVUPS(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(16))
		VMOVUPS(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(48))
	}

	Label("LBB9_9")
	{
		CMPQ(R11, RDX)
		JE(LabelRef("LBB9_11"))
	}

	Label("LBB9_10")
	{
		VCVTSI2SSQ(Mem{Base: RSI}.Idx(R11, 8), X8, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(R11, 4))
		ADDQ(Imm(1), R11)
		CMPQ(RDX, R11)
		JNE(LabelRef("LBB9_10"))
	}

	Label("LBB9_11")
	{
		RET()
	}

	Label("LBB9_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB9_8"))
		JMP(LabelRef("LBB9_9"))
	}
}

func genFromInt32_F64() {

	TEXT("FromInt32_AVX2_F64", NOSPLIT, "func(x []float64, y []int32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB10_11"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB10_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB10_10"))

	Label("LBB10_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB10_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB10_6")
	{
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(16), Y1)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y2)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(48), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y0)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(80), Y1)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y2)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(112), Y3)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8).Offset(128))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(160))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(192))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(224))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB10_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB10_9"))
	}

	Label("LBB10_8")
	{
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(16), Y1)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y2)
		VCVTDQ2PD(Mem{Base: RSI}.Idx(RCX, 4).Offset(48), Y3)
		VMOVUPD(Y0, Mem{Base: RDI}.Idx(RCX, 8))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 8).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 8).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 8).Offset(96))
	}

	Label("LBB10_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB10_11"))
	}

	Label("LBB10_10")
	{
		VCVTSI2SDL(Mem{Base: RSI}.Idx(RAX, 4), X4, X0)
		VMOVSD(X0, Mem{Base: RDI}.Idx(RAX, 8))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
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

func genFromInt32_F32() {

	TEXT("FromInt32_AVX2_F32", NOSPLIT, "func(x []float32, y []int32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB11_11"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB11_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB11_10"))

	Label("LBB11_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB11_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB11_6")
	{
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(128), Y0)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(160), Y1)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(192), Y2)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(224), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB11_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB11_9"))
	}

	Label("LBB11_8")
	{
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VCVTDQ2PS(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB11_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB11_11"))
	}

	Label("LBB11_10")
	{
		VCVTSI2SSL(Mem{Base: RSI}.Idx(RAX, 4), X4, X0)
		VMOVSS(X0, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
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

func genToBool_F64() {

	data := GLOBL("dataToBoolF64", RODATA|NOPTR)
	DATA(0, I8(1))
	DATA(1, I8(1))
	DATA(2, I8(1))
	DATA(3, I8(1))
	DATA(4, I8(0))
	DATA(5, I8(0))
	DATA(6, I8(0))
	DATA(7, I8(0))
	DATA(8, I8(0))
	DATA(9, I8(0))
	DATA(10, I8(0))
	DATA(11, I8(0))
	DATA(12, I8(0))
	DATA(13, I8(0))
	DATA(14, I8(0))
	DATA(15, I8(0))

	TEXT("ToBool_AVX2_F64", NOSPLIT, "func(x []bool, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB12_8"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB12_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB12_6"))

	Label("LBB12_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		XORL(ECX, ECX)
		VXORPD(X0, X0, X0)
		VMOVDQU(data.Offset(0), X1)
	}

	Label("LBB12_4")
	{
		VCMPPD(Imm(4), Mem{Base: RSI}.Idx(RCX, 8), Y0, Y2)
		VEXTRACTF128(Imm(1), Y2, X3)
		VPACKSSDW(X3, X2, X2)
		VPACKSSDW(X2, X2, X2)
		VPACKSSWB(X2, X2, X2)
		VCMPPD(Imm(4), Mem{Base: RSI}.Idx(RCX, 8).Offset(32), Y0, Y3)
		VPAND(X1, X2, X2)
		VEXTRACTF128(Imm(1), Y3, X4)
		VPACKSSDW(X4, X3, X3)
		VPACKSSDW(X3, X3, X3)
		VPACKSSWB(X3, X3, X3)
		VPAND(X1, X3, X3)
		VCMPPD(Imm(4), Mem{Base: RSI}.Idx(RCX, 8).Offset(64), Y0, Y4)
		VPUNPCKLDQ(X3, X2, X2)
		VEXTRACTF128(Imm(1), Y4, X3)
		VPACKSSDW(X3, X4, X3)
		VPACKSSDW(X3, X3, X3)
		VPACKSSWB(X3, X3, X3)
		VPAND(X1, X3, X3)
		VCMPPD(Imm(4), Mem{Base: RSI}.Idx(RCX, 8).Offset(96), Y0, Y4)
		VEXTRACTF128(Imm(1), Y4, X5)
		VPACKSSDW(X5, X4, X4)
		VPACKSSDW(X4, X4, X4)
		VPACKSSWB(X4, X4, X4)
		VPAND(X1, X4, X4)
		VPBROADCASTD(X4, X4)
		VPBROADCASTD(X3, X3)
		VPUNPCKLDQ(X4, X3, X3)
		VPBLENDD(Imm(12), X3, X2, X2)
		VMOVDQU(X2, Mem{Base: RDI}.Idx(RCX, 1))
		ADDQ(Imm(16), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB12_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB12_8"))
	}

	Label("LBB12_6")
	{
		VXORPD(X0, X0, X0)
	}

	Label("LBB12_7")
	{
		VUCOMISD(Mem{Base: RSI}.Idx(RAX, 8), X0)
		SETNE(Mem{Base: RDI}.Idx(RAX, 1))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB12_7"))
	}

	Label("LBB12_8")
	{
		VZEROUPPER()
		RET()
	}
}

func genToBool_F32() {

	data := GLOBL("dataToBoolF32", RODATA|NOPTR)
	DATA(0, I8(1))
	DATA(1, I8(1))
	DATA(2, I8(1))
	DATA(3, I8(1))
	DATA(4, I8(1))
	DATA(5, I8(1))
	DATA(6, I8(1))
	DATA(7, I8(1))
	DATA(8, I8(0))
	DATA(9, I8(0))
	DATA(10, I8(0))
	DATA(11, I8(0))
	DATA(12, I8(0))
	DATA(13, I8(0))
	DATA(14, I8(0))
	DATA(15, I8(0))

	TEXT("ToBool_AVX2_F32", NOSPLIT, "func(x []bool, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB13_8"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB13_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB13_6"))

	Label("LBB13_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		XORL(ECX, ECX)
		VXORPS(X0, X0, X0)
		VMOVDQU(data.Offset(0), X1)
	}

	Label("LBB13_4")
	{
		VCMPPS(Imm(4), Mem{Base: RSI}.Idx(RCX, 4), Y0, Y2)
		VEXTRACTF128(Imm(1), Y2, X3)
		VPACKSSDW(X3, X2, X2)
		VPACKSSWB(X2, X2, X2)
		VCMPPS(Imm(4), Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y0, Y3)
		VPAND(X1, X2, X2)
		VEXTRACTF128(Imm(1), Y3, X4)
		VPACKSSDW(X4, X3, X3)
		VPACKSSWB(X3, X3, X3)
		VPAND(X1, X3, X3)
		VCMPPS(Imm(4), Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y0, Y4)
		VEXTRACTF128(Imm(1), Y4, X5)
		VPACKSSDW(X5, X4, X4)
		VPACKSSWB(X4, X4, X4)
		VCMPPS(Imm(4), Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y0, Y5)
		VPAND(X1, X4, X4)
		VEXTRACTF128(Imm(1), Y5, X6)
		VPACKSSDW(X6, X5, X5)
		VPACKSSWB(X5, X5, X5)
		VPAND(X1, X5, X5)
		VINSERTI128(Imm(1), X5, Y4, Y4)
		VINSERTI128(Imm(1), X3, Y2, Y2)
		VPUNPCKLQDQ(Y4, Y2, Y2)
		VPERMQ(Imm(216), Y2, Y2)
		VMOVDQU(Y2, Mem{Base: RDI}.Idx(RCX, 1))
		ADDQ(Imm(32), RCX)
		CMPQ(RAX, RCX)
		JNE(LabelRef("LBB13_4"))
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB13_8"))
	}

	Label("LBB13_6")
	{
		VXORPS(X0, X0, X0)
	}

	Label("LBB13_7")
	{
		VUCOMISS(Mem{Base: RSI}.Idx(RAX, 4), X0)
		SETNE(Mem{Base: RDI}.Idx(RAX, 1))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB13_7"))
	}

	Label("LBB13_8")
	{
		VZEROUPPER()
		RET()
	}
}

func genToInt64_F64() {

	TEXT("ToInt64_AVX2_F64", NOSPLIT, "func(x []int64, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB14_8"))
	LEAQ(Mem{Base: RDX}.Offset(-1), RCX)
	MOVL(EDX, R8L)
	ANDL(Imm(3), R8L)
	CMPQ(RCX, Imm(3))
	JAE(LabelRef("LBB14_3"))
	XORL(ECX, ECX)
	JMP(LabelRef("LBB14_5"))

	Label("LBB14_3")
	{
		ANDQ(I32(-4), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB14_4")
	{
		VCVTTSD2SIQ(Mem{Base: RSI}.Idx(RCX, 8), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8))
		VCVTTSD2SIQ(Mem{Base: RSI}.Idx(RCX, 8).Offset(8), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8).Offset(8))
		VCVTTSD2SIQ(Mem{Base: RSI}.Idx(RCX, 8).Offset(16), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8).Offset(16))
		VCVTTSD2SIQ(Mem{Base: RSI}.Idx(RCX, 8).Offset(24), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8).Offset(24))
		ADDQ(Imm(4), RCX)
		CMPQ(RDX, RCX)
		JNE(LabelRef("LBB14_4"))
	}

	Label("LBB14_5")
	{
		TESTQ(R8, R8)
		JE(LabelRef("LBB14_8"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 8), RDX)
		LEAQ(Mem{Base: RSI}.Idx(RCX, 8), RCX)
		XORL(ESI, ESI)
	}

	Label("LBB14_7")
	{
		VCVTTSD2SIQ(Mem{Base: RCX}.Idx(RSI, 8), RAX)
		MOVQ(RAX, Mem{Base: RDX}.Idx(RSI, 8))
		ADDQ(Imm(1), RSI)
		CMPQ(R8, RSI)
		JNE(LabelRef("LBB14_7"))
	}

	Label("LBB14_8")
	{
		RET()
	}
}

func genToInt64_F32() {

	TEXT("ToInt64_AVX2_F32", NOSPLIT, "func(x []int64, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB15_8"))
	LEAQ(Mem{Base: RDX}.Offset(-1), RCX)
	MOVL(EDX, R8L)
	ANDL(Imm(3), R8L)
	CMPQ(RCX, Imm(3))
	JAE(LabelRef("LBB15_3"))
	XORL(ECX, ECX)
	JMP(LabelRef("LBB15_5"))

	Label("LBB15_3")
	{
		ANDQ(I32(-4), RDX)
		XORL(ECX, ECX)
	}

	Label("LBB15_4")
	{
		VCVTTSS2SIQ(Mem{Base: RSI}.Idx(RCX, 4), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8))
		VCVTTSS2SIQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(4), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8).Offset(8))
		VCVTTSS2SIQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(8), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8).Offset(16))
		VCVTTSS2SIQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(12), RAX)
		MOVQ(RAX, Mem{Base: RDI}.Idx(RCX, 8).Offset(24))
		ADDQ(Imm(4), RCX)
		CMPQ(RDX, RCX)
		JNE(LabelRef("LBB15_4"))
	}

	Label("LBB15_5")
	{
		TESTQ(R8, R8)
		JE(LabelRef("LBB15_8"))
		LEAQ(Mem{Base: RDI}.Idx(RCX, 8), RDX)
		LEAQ(Mem{Base: RSI}.Idx(RCX, 4), RCX)
		XORL(ESI, ESI)
	}

	Label("LBB15_7")
	{
		VCVTTSS2SIQ(Mem{Base: RCX}.Idx(RSI, 4), RAX)
		MOVQ(RAX, Mem{Base: RDX}.Idx(RSI, 8))
		ADDQ(Imm(1), RSI)
		CMPQ(R8, RSI)
		JNE(LabelRef("LBB15_7"))
	}

	Label("LBB15_8")
	{
		RET()
	}
}

func genToInt32_F64() {

	TEXT("ToInt32_AVX2_F64", NOSPLIT, "func(x []int32, y []float64)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB16_11"))
	CMPQ(RDX, Imm(16))
	JAE(LabelRef("LBB16_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB16_10"))

	Label("LBB16_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-16), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-16), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(4), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB16_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB16_6")
	{
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X1)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X2)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X3)
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(16))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(48))
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(128), X0)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(160), X1)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(192), X2)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(224), X3)
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(80))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(112))
		ADDQ(Imm(32), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB16_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB16_9"))
	}

	Label("LBB16_8")
	{
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8), X0)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(32), X1)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(64), X2)
		VCVTTPD2DQY(Mem{Base: RSI}.Idx(RCX, 8).Offset(96), X3)
		VMOVUPD(X0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPD(X1, Mem{Base: RDI}.Idx(RCX, 4).Offset(16))
		VMOVUPD(X2, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPD(X3, Mem{Base: RDI}.Idx(RCX, 4).Offset(48))
	}

	Label("LBB16_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB16_11"))
	}

	Label("LBB16_10")
	{
		VCVTTSD2SI(Mem{Base: RSI}.Idx(RAX, 8), ECX)
		MOVL(ECX, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB16_10"))
	}

	Label("LBB16_11")
	{
		RET()
	}

	Label("LBB16_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB16_8"))
		JMP(LabelRef("LBB16_9"))
	}
}

func genToInt32_F32() {

	TEXT("ToInt32_AVX2_F32", NOSPLIT, "func(x []int32, y []float32)")
	Pragma("noescape")
	Load(Param("x").Base(), RDI)
	Load(Param("y").Base(), RSI)
	Load(Param("x").Len(), RDX)

	TESTQ(RDX, RDX)
	JE(LabelRef("LBB17_11"))
	CMPQ(RDX, Imm(32))
	JAE(LabelRef("LBB17_3"))
	XORL(EAX, EAX)
	JMP(LabelRef("LBB17_10"))

	Label("LBB17_3")
	{
		MOVQ(RDX, RAX)
		ANDQ(I32(-32), RAX)
		LEAQ(Mem{Base: RAX}.Offset(-32), RCX)
		MOVQ(RCX, R8)
		SHRQ(Imm(5), R8)
		ADDQ(Imm(1), R8)
		TESTQ(RCX, RCX)
		JE(LabelRef("LBB17_4"))
		MOVQ(R8, R9)
		ANDQ(I32(-2), R9)
		XORL(ECX, ECX)
	}

	Label("LBB17_6")
	{
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(128), Y0)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(160), Y1)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(192), Y2)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(224), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4).Offset(128))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(160))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(192))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(224))
		ADDQ(Imm(64), RCX)
		ADDQ(I32(-2), R9)
		JNE(LabelRef("LBB17_6"))
		TESTB(Imm(1), R8B)
		JE(LabelRef("LBB17_9"))
	}

	Label("LBB17_8")
	{
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4), Y0)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(32), Y1)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(64), Y2)
		VCVTTPS2DQ(Mem{Base: RSI}.Idx(RCX, 4).Offset(96), Y3)
		VMOVUPS(Y0, Mem{Base: RDI}.Idx(RCX, 4))
		VMOVUPS(Y1, Mem{Base: RDI}.Idx(RCX, 4).Offset(32))
		VMOVUPS(Y2, Mem{Base: RDI}.Idx(RCX, 4).Offset(64))
		VMOVUPS(Y3, Mem{Base: RDI}.Idx(RCX, 4).Offset(96))
	}

	Label("LBB17_9")
	{
		CMPQ(RAX, RDX)
		JE(LabelRef("LBB17_11"))
	}

	Label("LBB17_10")
	{
		VCVTTSS2SI(Mem{Base: RSI}.Idx(RAX, 4), ECX)
		MOVL(ECX, Mem{Base: RDI}.Idx(RAX, 4))
		ADDQ(Imm(1), RAX)
		CMPQ(RDX, RAX)
		JNE(LabelRef("LBB17_10"))
	}

	Label("LBB17_11")
	{
		VZEROUPPER()
		RET()
	}

	Label("LBB17_4")
	{
		XORL(ECX, ECX)
		TESTB(Imm(1), R8B)
		JNE(LabelRef("LBB17_8"))
		JMP(LabelRef("LBB17_9"))
	}
}
