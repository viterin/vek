package functions

import (
	"github.com/chewxy/math32"
	"math"
)

func Sqrt_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Sqrt(x[i])
	}
}

func Sqrt_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Sqrt(x[i])
	}
}

func Round_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Round(x[i])
	}
}

func Round_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Round(x[i])
	}
}

func Floor_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Floor(x[i])
	}
}

func Floor_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Floor(x[i])
	}
}

func Ceil_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Ceil(x[i])
	}
}

func Ceil_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Ceil(x[i])
	}
}

func Pow_Go_F64(x, y []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Pow(x[i], y[i])
	}
}

func Pow_Go_F32(x, y []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Pow(x[i], y[i])
	}
}

func Sin_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Sin(x[i])
	}
}

func Sin_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Sin(x[i])
	}
}

func Cos_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Cos(x[i])
	}
}

func Cos_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Cos(x[i])
	}
}

func SinCos_Go_F64(dstSin, dstCos, x []float64) {
	for i := 0; i < len(x); i++ {
		dstSin[i] = math.Sin(x[i])
		dstCos[i] = math.Cos(x[i])
	}
}

func SinCos_Go_F32(dstSin, dstCos, x []float32) {
	for i := 0; i < len(x); i++ {
		dstSin[i] = math32.Sin(x[i])
		dstCos[i] = math32.Cos(x[i])
	}
}

func Exp_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Exp(x[i])
	}
}

func Exp_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Exp(x[i])
	}
}

func Log_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Log(x[i])
	}
}

func Log_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Log(x[i])
	}
}

func Log2_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Log2(x[i])
	}
}

func Log2_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Log2(x[i])
	}
}

func Log10_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Log10(x[i])
	}
}

func Log10_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Log10(x[i])
	}
}
