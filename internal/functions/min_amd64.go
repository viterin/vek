package functions

func ArgMin_AVX2_F64(x []float64) int {
	min := Min_AVX2_F64(x)
	idx := Find_AVX2_F64(x, min)
	if idx == len(x) {
		return -1
	}
	return idx
}

func ArgMin_AVX2_F32(x []float32) int {
	min := Min_AVX2_F32(x)
	idx := Find_AVX2_F32(x, min)
	if idx == len(x) {
		return -1
	}
	return idx
}
