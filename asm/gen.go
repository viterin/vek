//go:generate go run . -out ../internal/functions/accel_avx2_amd64.s -stubs ../internal/functions/accel_avx2_amd64.go -pkg functions

package main

import (
	. "github.com/mmcloughlin/avo/build"
)

func main() {

	// Arithmetic

	genAdd_F64()
	genAdd_F32()
	genAddNumber_F64()
	genAddNumber_F32()
	genSub_F64()
	genSub_F32()
	genSubNumber_F64()
	genSubNumber_F32()
	genMul_F64()
	genMul_F32()
	genMulNumber_F64()
	genMulNumber_F32()
	genDiv_F64()
	genDiv_F32()
	genDivNumber_F64()
	genDivNumber_F32()

	genAbs_F64()
	genAbs_F32()
	genNeg_F64()
	genNeg_F32()
	genInv_F64()
	genInv_F32()

	// Aggregates

	genSum_F64()
	genSum_F32()
	genCumSum_F64()
	genCumSum_F32()
	genProd_F64()
	genProd_F32()
	genCumProd_F64()
	genCumProd_F32()

	// Distance

	genDot_F64()
	genDot_F32()
	genNorm_F64()
	genNorm_F32()
	genDistance_F64()
	genDistance_F32()
	genManhattanNorm_F64()
	genManhattanNorm_F32()
	genManhattanDistance_F64()
	genManhattanDistance_F32()
	genCosineSimilarity_F64()
	genCosineSimilarity_F32()

	// Matrices

	genMat4Mul_F64()
	genMat4Mul_F32()
	genMatMul_F64()
	genMatMul_F32()
	genMatMulVec_F64()
	genMatMulVec_F32()
	genMatMulTiled_F64()
	genMatMulTiled_F32()

	// Special

	genSqrt_F64()
	genSqrt_F32()
	genRound_F64()
	genRound_F32()
	genFloor_F64()
	genFloor_F32()
	genCeil_F64()
	genCeil_F32()
	genPow_4x_F64()
	genPow_8x_F32()
	genSin_F32()
	genCos_F32()
	genSinCos_F32()
	genExp_Len8x_F32()
	genLog_Len8x_F32()
	genLog2_Len8x_F32()
	genLog10_Len8x_F32()

	// Comparison

	genMin_F64()
	genMin_F32()
	genMinimum_F64()
	genMinimum_F32()
	genMinimumNumber_F64()
	genMinimumNumber_F32()

	genMax_F64()
	genMax_F32()
	genMaximum_F64()
	genMaximum_F32()
	genMaximumNumber_F64()
	genMaximumNumber_F32()

	genFind_F64()
	genFind_F32()

	genLt_F64()
	genLt_F32()
	genLte_F64()
	genLte_F32()
	genGt_F64()
	genGt_F32()
	genGte_F64()
	genGte_F32()
	genEq_F64()
	genEq_F32()
	genNeq_F64()
	genNeq_F32()

	genLtNumber_F64()
	genLtNumber_F32()
	genLteNumber_F64()
	genLteNumber_F32()
	genGtNumber_F64()
	genGtNumber_F32()
	genGteNumber_F64()
	genGteNumber_F32()
	genEqNumber_F64()
	genEqNumber_F32()
	genNeqNumber_F64()
	genNeqNumber_F32()

	// Boolean

	genNot()
	genAnd()
	genOr()
	genXor()

	genAll()
	genAny()
	genNone()

	genCount()

	// Construction

	genRepeat_F64()
	genRepeat_F32()
	genRange_F64()
	genRange_F32()
	//genGather_F64()
	//genGather_F32()
	//genScatter_F64()
	//genScatter_F32()

	genFromBool_F64()
	genFromBool_F32()
	genFromInt32_F64()
	genFromInt32_F32()
	genFromInt64_F64()
	genFromInt64_F32()
	genFromFloat32_F64()
	genFromFloat64_F32()
	genToBool_F64()
	genToBool_F32()
	genToInt32_F64()
	genToInt32_F32()
	genToInt64_F64()
	genToInt64_F32()

	// Output

	Generate()
}
