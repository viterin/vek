package functions

func MatMul_Parallel_AVX2_F64(dst, x, y []float64, m, n, p int) {
	matMulParallel(dst, x, y, m, n, p, MatMulVec_AVX2_F64, MatMul_AVX2_F64)
}

func MatMul_Parallel_AVX2_F32(dst, x, y []float32, m, n, p int) {
	matMulParallel(dst, x, y, m, n, p, MatMulVec_AVX2_F32, MatMul_AVX2_F32)
}
