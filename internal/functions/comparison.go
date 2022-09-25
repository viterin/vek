package functions

import (
	"golang.org/x/exp/constraints"
)

func Lt_Go[T constraints.Float](dst []bool, x, y []T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] < y[i]
	}
}

func Lte_Go[T constraints.Float](dst []bool, x, y []T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] <= y[i]
	}
}

func Gt_Go[T constraints.Float](dst []bool, x, y []T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] > y[i]
	}
}

func Gte_Go[T constraints.Float](dst []bool, x, y []T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] >= y[i]
	}
}
func Eq_Go[T constraints.Float](dst []bool, x, y []T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] == y[i]
	}
}

func Neq_Go[T constraints.Float](dst []bool, x, y []T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] != y[i]
	}
}

func LtNumber_Go[T constraints.Float](dst []bool, x []T, a T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] < a
	}
}

func LteNumber_Go[T constraints.Float](dst []bool, x []T, a T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] <= a
	}
}

func GtNumber_Go[T constraints.Float](dst []bool, x []T, a T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] > a
	}
}

func GteNumber_Go[T constraints.Float](dst []bool, x []T, a T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] >= a
	}
}

func EqNumber_Go[T constraints.Float](dst []bool, x []T, a T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] == a
	}
}

func NeqNumber_Go[T constraints.Float](dst []bool, x []T, a T) {
	for i := 0; i < len(x); i++ {
		dst[i] = x[i] != a
	}
}
