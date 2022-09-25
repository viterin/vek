package functions

import (
	"github.com/chewxy/math32"
	"golang.org/x/exp/constraints"
	"math"
)

func Dot_Go[T constraints.Float](x, y []T) T {
	res := T(0)
	for i := 0; i < len(x); i++ {
		res += x[i] * y[i]
	}
	return res
}

func Norm_Go_F64(x []float64) float64 {
	res := float64(0)
	for i := 0; i < len(x); i++ {
		res += x[i] * x[i]
	}
	return math.Sqrt(res)
}

func Norm_Go_F32(x []float32) float32 {
	res := float32(0)
	for i := 0; i < len(x); i++ {
		res += x[i] * x[i]
	}
	return math32.Sqrt(res)
}

func Distance_Go_F64(x, y []float64) float64 {
	res := float64(0)
	for i := 0; i < len(x); i++ {
		res += (x[i] - y[i]) * (x[i] - y[i])
	}
	return math.Sqrt(res)
}

func Distance_Go_F32(x, y []float32) float32 {
	res := float32(0)
	for i := 0; i < len(x); i++ {
		res += (x[i] - y[i]) * (x[i] - y[i])
	}
	return math32.Sqrt(res)
}

func ManhattanNorm_Go_F64(x []float64) float64 {
	res := float64(0)
	for i := 0; i < len(x); i++ {
		res += math.Abs(x[i])
	}
	return res
}

func ManhattanNorm_Go_F32(x []float32) float32 {
	res := float32(0)
	for i := 0; i < len(x); i++ {
		res += math32.Abs(x[i])
	}
	return res
}

func ManhattanDistance_Go_F64(x, y []float64) float64 {
	res := float64(0)
	for i := 0; i < len(x); i++ {
		res += math.Abs(x[i] - y[i])
	}
	return res
}

func ManhattanDistance_Go_F32(x, y []float32) float32 {
	res := float32(0)
	for i := 0; i < len(x); i++ {
		res += math32.Abs(x[i] - y[i])
	}
	return res
}

func CosineSimilarity_Go_F64(x, y []float64) float64 {
	dp := float64(0)
	xdp := float64(0)
	ydp := float64(0)
	for i := 0; i < len(x); i++ {
		dp += x[i] * y[i]
		xdp += x[i] * x[i]
		ydp += y[i] * y[i]
	}
	return dp / math.Sqrt(xdp*ydp)
}

func CosineSimilarity_Go_F32(x, y []float32) float32 {
	dp := float32(0)
	xdp := float32(0)
	ydp := float32(0)
	for i := 0; i < len(x); i++ {
		dp += x[i] * y[i]
		xdp += x[i] * x[i]
		ydp += y[i] * y[i]
	}
	return dp / math32.Sqrt(xdp*ydp)
}
