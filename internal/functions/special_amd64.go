package functions

import (
	"github.com/chewxy/math32"
)

func Exp_AVX2_F32(x []float32) {
	nSimd := (len(x) / 8) * 8
	Exp_Len8x_AVX2_F32(x[:nSimd])
	for i := nSimd; i < len(x); i++ {
		x[i] = math32.Exp(x[i])
	}
}

func Log_AVX2_F32(x []float32) {
	nSimd := (len(x) / 8) * 8
	Log_Len8x_AVX2_F32(x[:nSimd])
	for i := nSimd; i < len(x); i++ {
		x[i] = math32.Log(x[i])
	}
}

func Log2_AVX2_F32(x []float32) {
	nSimd := (len(x) / 8) * 8
	Log2_Len8x_AVX2_F32(x[:nSimd])
	for i := nSimd; i < len(x); i++ {
		x[i] = math32.Log2(x[i])
	}
}

func Log10_AVX2_F32(x []float32) {
	nSimd := (len(x) / 8) * 8
	Log10_Len8x_AVX2_F32(x[:nSimd])
	for i := nSimd; i < len(x); i++ {
		x[i] = math32.Log10(x[i])
	}
}
