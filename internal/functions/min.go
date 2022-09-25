package functions

import (
	"golang.org/x/exp/constraints"
)

func Min_Go[T constraints.Float](x []T) T {
	min := x[0]
	for _, v := range x[1:] {
		if v < min {
			min = v
		}
	}
	return min
}

func ArgMin_Go[T constraints.Float](x []T) int {
	min := x[0]
	idx := 0
	for i, v := range x[1:] {
		if v < min {
			min = v
			idx = 1 + i
		}
	}
	return idx
}

func Minimum_Go[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		if y[i] < x[i] {
			x[i] = y[i]
		}
	}
}

func MinimumNumber_Go[T constraints.Float](x []T, a T) {
	for i := 0; i < len(x); i++ {
		if a < x[i] {
			x[i] = a
		}
	}
}
