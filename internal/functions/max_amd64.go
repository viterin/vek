package functions

func ArgMax_AVX2_F64(x []float64) int {
	max := Max_AVX2_F64(x)
	idx := Find_AVX2_F64(x, max)
	if idx == len(x) {
		return -1
	}
	return idx
}

func ArgMax_AVX2_F32(x []float32) int {
	max := Max_AVX2_F32(x)
	idx := Find_AVX2_F32(x, max)
	if idx == len(x) {
		return -1
	}
	return idx
}
