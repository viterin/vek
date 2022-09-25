package functions

import (
	"golang.org/x/exp/constraints"
	"golang.org/x/exp/rand"
)

func Random[T constraints.Integer | constraints.Float](size int) []T {
	x := make([]T, size)
	for i := 0; i < size; i++ {
		x[i] = T(rand.NormFloat64() * 100)
	}
	return x
}

func RandomBool(size int, pctTrue float64) []bool {
	res := make([]bool, size)
	for i := 0; i < size; i++ {
		res[i] = rand.Float64() < pctTrue
	}
	return res
}

func RandomRange[T constraints.Integer | constraints.Float](a, b T, size int) []T {
	x := make([]T, size)
	r := b - a
	for i := 0; i < size; i++ {
		x[i] = T(rand.Float64()*float64(r) + float64(a))
	}
	return x
}
