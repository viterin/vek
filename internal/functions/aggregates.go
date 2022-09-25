package functions

import (
	"github.com/viterin/partial"
	"golang.org/x/exp/constraints"
	"golang.org/x/exp/slices"
	"math"
)

func Sum_Go[T constraints.Float](x []T) T {
	sum := T(0)
	for i := 0; i < len(x); i++ {
		sum += x[i]
	}
	return sum
}

func CumSum_Go[T constraints.Float](x []T) {
	sum := T(0)
	for i := 0; i < len(x); i++ {
		sum += x[i]
		x[i] = sum
	}
}

func Prod_Go[T constraints.Float](x []T) T {
	prod := T(1)
	for i := 0; i < len(x); i++ {
		prod *= x[i]
	}
	return prod
}

func CumProd_Go[T constraints.Float](x []T) {
	prod := T(1)
	for i := 0; i < len(x); i++ {
		prod *= x[i]
		x[i] = prod
	}
}

func Mean_Go[T constraints.Float](x []T) T {
	return Sum_Go(x) / T(len(x))
}

func Median_Go[T constraints.Float](x []T) T {
	if len(x)%2 == 1 {
		x = slices.Clone(x)
		i := len(x) / 2
		partial.TopK(x, i+1)
		return x[i]
	}
	return Quantile_Go(x, T(0.5))
}

func Quantile_Go[T constraints.Float](x []T, q T) T {
	if len(x) == 1 {
		return x[0]
	}
	if q == T(0) {
		return Min_Go(x)
	}
	if q == T(1) {
		return Max_Go(x)
	}
	x = slices.Clone(x)
	f := T(len(x)-1) * q
	i := int(math.Floor(float64(f)))
	if q < 0.5 {
		partial.TopK(x, i+2)
		a := Max_Go(x[:i+1])
		b := x[i+1]
		return a + (b-a)*(f-T(i))
	} else {
		partial.TopK(x, i+1)
		a := x[i]
		b := Min_Go(x[i+1:])
		return a + (b-a)*(f-T(i))
	}
}
