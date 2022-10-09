package functions

import (
	"github.com/chewxy/math32"
	"golang.org/x/exp/constraints"
	"math"
)

func Add_Go[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		x[i] += y[i]
	}
}

func AddNumber_Go[T constraints.Float](x []T, y T) {
	for i := 0; i < len(x); i++ {
		x[i] += y
	}
}

func Sub_Go[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		x[i] -= y[i]
	}
}

func SubNumber_Go[T constraints.Float](x []T, y T) {
	for i := 0; i < len(x); i++ {
		x[i] -= y
	}
}

func Mul_Go[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		x[i] *= y[i]
	}
}

func MulNumber_Go[T constraints.Float](x []T, y T) {
	for i := 0; i < len(x); i++ {
		x[i] *= y
	}
}

func Div_Go[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		x[i] /= y[i]
	}
}

func DivNumber_Go[T constraints.Float](x []T, y T) {
	for i := 0; i < len(x); i++ {
		x[i] /= y
	}
}

func Mod_Go_F64(x, y []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Mod(math.Mod(x[i], y[i])+y[i], y[i])
	}
}

func Mod_Go_F32(x, y []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Mod(math32.Mod(x[i], y[i])+y[i], y[i])
	}
}

func ModNumber_Go_F64(x []float64, y float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Mod(math.Mod(x[i], y)+y, y)
	}
}

func ModNumber_Go_F32(x []float32, y float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math32.Mod(math32.Mod(x[i], y)+y, y)
	}
}

func Abs_Go_F64(x []float64) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Abs(x[i])
	}
}

func Abs_Go_F32(x []float32) {
	for i := 0; i < len(x); i++ {
		x[i] = math.Float32frombits(math.Float32bits(x[i]) &^ (1 << 31))
	}
}

func Neg_Go[T constraints.Float](x []T) {
	for i := 0; i < len(x); i++ {
		x[i] = -x[i]
	}
}

func Inv_Go[T constraints.Float](x []T) {
	for i := 0; i < len(x); i++ {
		x[i] = 1 / x[i]
	}
}
