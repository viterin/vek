package functions

import (
	"github.com/chewxy/math32"
	"math"
)

func Pow_AVX2_F64(x, y []float64) {
	nSimd := len(x) & (-4)
	Pow_4x_AVX2_F64(x[:nSimd], y[:nSimd])
	for i := nSimd; i < len(x); i++ {
		x[i] = math.Pow(x[i], y[i])
	}
}

func Pow_AVX2_F32(x, y []float32) {
	nSimd := len(x) & (-8)
	Pow_8x_AVX2_F32(x[:nSimd], y[:nSimd])
	for i := nSimd; i < len(x); i++ {
		x[i] = math32.Pow(x[i], y[i])
	}
}

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
