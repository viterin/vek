package functions

import (
	"github.com/chewxy/math32"
	"math"
)

func ModNumber_AVX2_F64(x []float64, y float64) {
	nSimd := len(x) & (-4)
	ModNumber_4x_AVX2_F64(x[:nSimd], y)
	for i := nSimd; i < len(x); i++ {
		x[i] = math.Mod(math.Mod(x[i], y)+y, y)
	}
}

func ModNumber_AVX2_F32(x []float32, y float32) {
	nSimd := len(x) & (-8)
	ModNumber_8x_AVX2_F32(x[:nSimd], y)
	for i := nSimd; i < len(x); i++ {
		x[i] = math32.Mod(math32.Mod(x[i], y)+y, y)
	}
}
