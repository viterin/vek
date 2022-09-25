package functions

import (
	"golang.org/x/exp/constraints"
)

func Max_Go[T constraints.Float](x []T) T {
	max := x[0]
	for _, v := range x[1:] {
		if v > max {
			max = v
		}
	}
	return max
}

func ArgMax_Go[T constraints.Float](x []T) int {
	max := x[0]
	idx := 0
	for i, v := range x[1:] {
		if v > max {
			max = v
			idx = 1 + i
		}
	}
	return idx
}

func Maximum_Go[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		if y[i] > x[i] {
			x[i] = y[i]
		}
	}
}

func MaximumNumber_Go[T constraints.Float](x []T, a T) {
	for i := 0; i < len(x); i++ {
		if a > x[i] {
			x[i] = a
		}
	}
}
