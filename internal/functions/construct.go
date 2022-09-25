package functions

import "golang.org/x/exp/constraints"

type Number interface {
	constraints.Float | constraints.Integer
}

func Zeros_Go[T constraints.Float](x []T, n int) {
	Repeat_Go(x, 0, n)
}

func Ones_Go[T constraints.Float](x []T, n int) {
	Repeat_Go(x, 1, n)
}

func Repeat_Go[T constraints.Float](x []T, a T, n int) {
	for i := 0; i < n; i++ {
		x[i] = a
	}
}

func Range_Go[T constraints.Float](x []T, a T, n int) {
	for i := 0; i < n; i++ {
		x[i] = a
		a += 1
	}
}

func Gather_Go[T constraints.Float](dst, x []T, idx []int) {
	for i := 0; i < len(idx); i++ {
		dst[i] = x[idx[i]]
	}
}

func Scatter_Go[T constraints.Float](dst, x []T, idx []int) {
	for i := 0; i < len(idx); i++ {
		dst[idx[i]] = x[i]
	}
}

func Clone_Go[T constraints.Float](x, y []T) {
	copy(x, y)
}

func Clone_Go_Loop[T constraints.Float](x, y []T) {
	for i := 0; i < len(x); i++ {
		x[i] = y[i]
	}
}

func FromNumber_Go[T constraints.Float, F Number](x []T, y []F) {
	for i := 0; i < len(y); i++ {
		x[i] = T(y[i])
	}
}

func ToNumber_Go[T Number, F constraints.Float](x []T, y []F) {
	for i := 0; i < len(y); i++ {
		x[i] = T(y[i])
	}
}

func FromBool_Go[T constraints.Float](x []T, y []bool) {
	for i := 0; i < len(y); i++ {
		if y[i] {
			x[i] = 1
		} else {
			x[i] = 0
		}
	}
}

func ToBool_Go[F constraints.Float](x []bool, y []F) {
	for i := 0; i < len(y); i++ {
		if y[i] != 0 {
			x[i] = true
		} else {
			x[i] = false
		}
	}
}
