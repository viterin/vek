package functions

import "golang.org/x/exp/constraints"

func Not_Go(x []bool) {
	for i := 0; i < len(x); i++ {
		x[i] = !x[i]
	}
}

func And_Go(x, y []bool) {
	for i := 0; i < len(x); i++ {
		x[i] = x[i] && y[i]
	}
}

func Or_Go(x, y []bool) {
	for i := 0; i < len(x); i++ {
		x[i] = x[i] || y[i]
	}
}

func Xor_Go(x, y []bool) {
	for i := 0; i < len(x); i++ {
		x[i] = x[i] != y[i]
	}
}

func Select_Go[T constraints.Float](dst, x []T, y []bool) []T {
	dst = dst[:0]
	for i := 0; i < len(y); i++ {
		if y[i] {
			dst = append(dst, x[i])
		}
	}
	return dst
}

func All_Go(x []bool) bool {
	for i := 0; i < len(x); i++ {
		if !x[i] {
			return false
		}
	}
	return true
}

func Any_Go(x []bool) bool {
	for i := 0; i < len(x); i++ {
		if x[i] {
			return true
		}
	}
	return false
}

func None_Go(x []bool) bool {
	for i := 0; i < len(x); i++ {
		if x[i] {
			return false
		}
	}
	return true
}

func Count_Go(x []bool) int {
	cnt := 0
	for i := 0; i < len(x); i++ {
		if x[i] {
			cnt += 1
		}
	}
	return cnt
}
