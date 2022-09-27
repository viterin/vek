package vek

import (
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/slices"
	"math"
	"testing"
)

// Edge cases. See internal/functions for random float tests.

const d = 0.001

var empty []float64 = []float64{}
var one []float64 = []float64{1}
var two []float64 = []float64{1, 2}
var three []float64 = []float64{1, 2, 3}
var four []float64 = []float64{1, 2, 3, 4} // AVX register
var five []float64 = []float64{1, 2, 3, 4, 5}
var negOne []float64 = []float64{-1}
var negTwo []float64 = []float64{-1, -2}
var negThree []float64 = []float64{-1, -2, -3}
var negFour []float64 = []float64{-1, -2, -3, -4} // AVX register
var negFive []float64 = []float64{-1, -2, -3, -4, -5}
var accel []bool = []bool{false, Info().Acceleration}

func TestArithmetic(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float64, 4)

		require.Panics(t, func() { Add(one, two) })
		require.Empty(t, Add(nil, nil))
		require.Empty(t, Add(empty, nil))
		require.Empty(t, Add(empty, empty))
		require.Equal(t, []float64{2}, Add(one, one))
		require.Equal(t, []float64{2, 4, 6, 8}, Add(four, four))
		require.Equal(t, []float64{2, 4, 6, 8, 10}, Add(five, five))
		dst = Add_Into(dst, three, three)
		require.Equal(t, []float64{2, 4, 6}, dst)
		require.Panics(t, func() { Add_Into(dst, five, five) })
		require.Panics(t, func() { Add_Inplace(five, five) })

		require.Empty(t, AddNumber(nil, 2))
		require.Empty(t, AddNumber(empty, 2))
		require.Empty(t, AddNumber(empty, 2))
		require.Equal(t, []float64{3}, AddNumber(one, 2))
		require.Equal(t, []float64{3, 4, 5, 6}, AddNumber(four, 2))
		require.Equal(t, []float64{3, 4, 5, 6, 7}, AddNumber(five, 2))
		dst = AddNumber_Into(dst, three, 2)
		require.Equal(t, []float64{3, 4, 5}, dst)
		require.Panics(t, func() { AddNumber_Into(dst, five, 2) })

		require.Panics(t, func() { Sub(one, two) })
		require.Empty(t, Sub(nil, nil))
		require.Empty(t, Sub(empty, nil))
		require.Empty(t, Sub(empty, empty))
		require.Equal(t, []float64{0}, Sub(one, one))
		require.Equal(t, []float64{0, 0, 0, 0}, Sub(four, four))
		require.Equal(t, []float64{0, 0, 0, 0, 0}, Sub(five, five))
		dst = Sub_Into(dst, three, three)
		require.Equal(t, []float64{0, 0, 0}, dst)
		require.Panics(t, func() { Sub_Into(dst, five, five) })

		require.Empty(t, SubNumber(nil, 2))
		require.Empty(t, SubNumber(empty, 2))
		require.Empty(t, SubNumber(empty, 2))
		require.Equal(t, []float64{-1}, SubNumber(one, 2))
		require.Equal(t, []float64{-1, 0, 1, 2}, SubNumber(four, 2))
		require.Equal(t, []float64{-1, 0, 1, 2, 3}, SubNumber(five, 2))
		dst = SubNumber_Into(dst, three, 2)
		require.Equal(t, []float64{-1, 0, 1}, dst)
		require.Panics(t, func() { SubNumber_Into(dst, five, 2) })

		require.Panics(t, func() { Mul(one, two) })
		require.Empty(t, Mul(nil, nil))
		require.Empty(t, Mul(empty, nil))
		require.Empty(t, Mul(empty, empty))
		require.Equal(t, []float64{1}, Mul(one, one))
		require.Equal(t, []float64{1, 4, 9, 16}, Mul(four, four))
		require.Equal(t, []float64{1, 4, 9, 16, 25}, Mul(five, five))
		dst = Mul_Into(dst, three, three)
		require.Equal(t, []float64{1, 4, 9}, dst)
		require.Panics(t, func() { Mul_Into(dst, five, five) })

		require.Empty(t, MulNumber(nil, 2))
		require.Empty(t, MulNumber(empty, 2))
		require.Empty(t, MulNumber(empty, 2))
		require.Equal(t, []float64{2}, MulNumber(one, 2))
		require.Equal(t, []float64{2, 4, 6, 8}, MulNumber(four, 2))
		require.Equal(t, []float64{2, 4, 6, 8, 10}, MulNumber(five, 2))
		dst = MulNumber_Into(dst, three, 2)
		require.Equal(t, []float64{2, 4, 6}, dst)
		require.Panics(t, func() { MulNumber_Into(dst, five, 2) })

		require.Panics(t, func() { Div(one, two) })
		require.Empty(t, Div(nil, nil))
		require.Empty(t, Div(empty, nil))
		require.Empty(t, Div(empty, empty))
		require.Equal(t, []float64{1}, Div(one, one))
		require.Equal(t, []float64{1, 1, 1, 1}, Div(four, four))
		require.Equal(t, []float64{1, 1, 1, 1, 1}, Div(five, five))
		dst = Div_Into(dst, three, three)
		require.Equal(t, []float64{1, 1, 1}, dst)
		require.Panics(t, func() { Div_Into(dst, five, five) })

		require.Empty(t, DivNumber(nil, 2))
		require.Empty(t, DivNumber(empty, 2))
		require.Empty(t, DivNumber(empty, 2))
		require.InDeltaSlice(t, []float64{1. / 2}, DivNumber(one, 2), d)
		require.InDeltaSlice(t, []float64{1. / 2, 2. / 2, 3. / 2, 4. / 2}, DivNumber(four, 2), d)
		require.InDeltaSlice(t, []float64{1. / 2, 2. / 2, 3. / 2, 4. / 2, 5. / 2}, DivNumber(five, 2), d)
		dst = DivNumber_Into(dst, three, 2)
		require.InDeltaSlice(t, []float64{1. / 2, 2. / 2, 3. / 2}, dst, d)
		require.Panics(t, func() { DivNumber_Into(dst, five, 2) })

		require.Empty(t, Abs(empty))
		require.Empty(t, Abs(nil))
		require.Equal(t, one, Abs(negOne))
		require.Equal(t, four, Abs(negFour))
		require.Equal(t, five, Abs(negFive))
		dst = Abs_Into(dst, negThree)
		require.Equal(t, three, dst)
		require.Panics(t, func() { Abs_Into(dst, five) })

		require.Empty(t, Neg(empty))
		require.Empty(t, Neg(nil))
		require.Equal(t, negOne, Neg(one))
		require.Equal(t, negFour, Neg(four))
		require.Equal(t, negFive, Neg(five))
		dst = Neg_Into(dst, three)
		require.Equal(t, negThree, dst)
		require.Panics(t, func() { Neg_Into(dst, five) })

		require.Empty(t, Inv(empty))
		require.Empty(t, Inv(nil))
		require.Equal(t, one, Inv(one))
		require.InDeltaSlice(t, []float64{1, 1. / 2, 1. / 3, 1. / 4}, Inv(four), d)
		require.InDeltaSlice(t, []float64{1, 1. / 2, 1. / 3, 1. / 4, 1. / 5}, Inv(five), d)
		dst = Inv_Into(dst, three)
		require.InDeltaSlice(t, []float64{1, 1. / 2, 1. / 3}, dst, d)
		require.Panics(t, func() { Inv_Into(dst, five) })
	}
}

func TestAggregates(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := slices.Clone(four)
		_ = dst

		require.Equal(t, 0., Sum(empty))
		require.Equal(t, 0., Sum(nil))
		require.Equal(t, 1., Sum(one))
		require.Equal(t, 1.+2+3+4, Sum(four))
		require.Equal(t, 1.+2+3+4+5, Sum(five))

		require.Empty(t, CumSum(nil))
		require.Empty(t, CumSum(empty))
		require.Equal(t, []float64{1}, CumSum(one))
		require.Equal(t, []float64{1, 3, 6, 10}, CumSum(four))
		require.Equal(t, []float64{1, 3, 6, 10, 15}, CumSum(five))
		dst = CumSum_Into(dst, three)
		require.Equal(t, []float64{1, 3, 6}, dst)
		require.Panics(t, func() { CumSum_Into(dst, five) })

		require.Equal(t, 1., Prod(empty))
		require.Equal(t, 1., Prod(nil))
		require.Equal(t, 1., Prod(one))
		require.Equal(t, 1.*2*3*4, Prod(four))
		require.Equal(t, 1.*2*3*4*5, Prod(five))

		require.Empty(t, CumProd(nil))
		require.Empty(t, CumProd(empty))
		require.Equal(t, []float64{1}, CumProd(one))
		require.Equal(t, []float64{1, 2, 6, 24}, CumProd(four))
		require.Equal(t, []float64{1, 2, 6, 24, 120}, CumProd(five))
		dst = CumProd_Into(dst, three)
		require.Equal(t, []float64{1, 2, 6}, dst)
		require.Panics(t, func() { CumProd_Into(dst, five) })

		require.Panics(t, func() { Mean(nil) })
		require.Panics(t, func() { Mean(empty) })
		require.InDelta(t, 1., Mean(one), d)
		require.InDelta(t, (1.+2+3+4)/4, Mean(four), d)
		require.InDelta(t, (1.+2+3+4+5)/5, Mean(five), d)

		require.Panics(t, func() { Median(nil) })
		require.Panics(t, func() { Median(empty) })
		require.InDelta(t, 1., Median(one), d)
		require.InDelta(t, 2.5, Median(four), d)
		require.InDelta(t, 3., Median(five), d)

		require.Panics(t, func() { Quantile(nil, 0.3) })
		require.Panics(t, func() { Quantile(empty, 0.3) })
		require.InDelta(t, 1., Quantile(one, 0.), d)
		require.InDelta(t, 1., Quantile(one, 0.4), d)
		require.InDelta(t, 1., Quantile(one, 1.), d)
		require.InDelta(t, 1., Quantile(four, 0.), d)
		require.InDelta(t, 2.2, Quantile(four, 0.4), d)
		require.InDelta(t, 4., Quantile(four, 1.), d)
		require.InDelta(t, 2.6, Quantile(five, 0.4), d)
	}
}

func TestDistance(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		require.Panics(t, func() { Dot(nil, empty) })
		require.Panics(t, func() { Dot(one, two) })
		require.Equal(t, 1., Dot(one, one))
		require.Equal(t, 1.*1+2*2+3*3+4*4, Dot(four, four))
		require.Equal(t, 1.*1+2*2+3*3+4*4+5*5, Dot(five, five))

		require.Panics(t, func() { Norm(nil) })
		require.InDelta(t, 1., Norm(one), d)
		require.InDelta(t, math.Sqrt(Dot(four, four)), Norm(four), d)
		require.InDelta(t, math.Sqrt(Dot(five, five)), Norm(five), d)

		require.Panics(t, func() { Distance(nil, nil) })
		require.Panics(t, func() { Distance(one, two) })
		require.InDelta(t, 0., Distance(one, one), d)
		require.InDelta(t, Norm(Sub(one, negOne)), Distance(one, negOne), d)
		require.InDelta(t, 0., Distance(four, four), d)
		require.InDelta(t, Norm(Sub(four, negFour)), Distance(four, negFour), d)
		require.InDelta(t, 0., Distance(five, five), d)
		require.InDelta(t, Norm(Sub(five, negFive)), Distance(five, negFive), d)

		require.Panics(t, func() { ManhattanNorm(nil) })
		require.InDelta(t, 1., ManhattanNorm(one), d)
		require.InDelta(t, Sum(Abs(four)), ManhattanNorm(four), d)
		require.InDelta(t, Sum(Abs(five)), ManhattanNorm(five), d)

		require.Panics(t, func() { ManhattanDistance(nil, nil) })
		require.Panics(t, func() { ManhattanDistance(one, two) })
		require.InDelta(t, 0., ManhattanDistance(one, one), d)
		require.InDelta(t, Sum(Abs(Sub(one, negOne))), ManhattanDistance(one, negOne), d)
		require.InDelta(t, 0., ManhattanDistance(four, four), d)
		require.InDelta(t, Sum(Abs(Sub(four, negFour))), ManhattanDistance(four, negFour), d)
		require.InDelta(t, 0., ManhattanDistance(five, five), d)
		require.InDelta(t, Sum(Abs(Sub(five, negFive))), ManhattanDistance(five, negFive), d)

		require.Panics(t, func() { CosineSimilarity(nil, nil) })
		require.Panics(t, func() { CosineSimilarity(one, two) })
		require.InDelta(t, 1., CosineSimilarity(one, one), d)
		require.InDelta(t, -1., CosineSimilarity(one, negOne), d)
		require.InDelta(t, 1., CosineSimilarity(four, four), d)
		require.InDelta(t, -1., CosineSimilarity(four, negFour), d)
		require.InDelta(t, 0.6666, CosineSimilarity(four, []float64{4, 3, 2, 1}), d)
		require.InDelta(t, 0.6363, CosineSimilarity(five, []float64{5, 4, 3, 2, 1}), d)
	}
}

func TestMatrices(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float64, 4)

		require.Panics(t, func() { MatMul(empty, empty, 1) })
		require.Panics(t, func() { MatMul(one, one, 0) })
		require.Panics(t, func() { MatMul(two, four, 3) })
		require.InDeltaSlice(t, []float64{1}, MatMul(one, one, 1), d)
		require.InDeltaSlice(t, []float64{7, 10}, MatMul(two, four, 2), d)
		require.InDeltaSlice(t, []float64{1, 2, 2, 4}, MatMul(two, two, 1), d)
		require.InDeltaSlice(t, []float64{30}, MatMul(four, four, 4), d)
		require.InDeltaSlice(t, []float64{55}, MatMul(five, five, 5), d)
		dst = MatMul_Into(dst, two, two, 1)
		require.InDeltaSlice(t, []float64{1, 2, 2, 4}, dst, d)
		require.Panics(t, func() { MatMul_Into(dst, five, five, 1) })

		dst = make([]float64, 16)
		sixteen := Range(1, 17)
		expected := []float64{90, 100, 110, 120, 202, 228, 254, 280, 314, 356, 398, 440, 426, 484, 542, 600}

		require.Panics(t, func() { Mat4Mul(empty, empty) })
		require.Panics(t, func() { Mat4Mul(one, one) })
		require.Panics(t, func() { Mat4Mul(two, four) })
		require.InDeltaSlice(t, expected, Mat4Mul(sixteen, sixteen), d)
		dst = Mat4Mul_Into(dst, sixteen, sixteen)
		require.InDeltaSlice(t, expected, dst, d)
		require.Panics(t, func() { Mat4Mul_Into(dst[:4:4], sixteen, sixteen) })
	}
}

func TestSpecial(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float64, 4)

		require.Empty(t, Sqrt(empty))
		require.InDeltaSlice(t, one, Sqrt(one), d)
		require.InDeltaSlice(t, []float64{1., 1.4142, 1.7321, 2.}, Sqrt(four), d)
		require.InDeltaSlice(t, []float64{1., 1.4142, 1.7321, 2., 2.2361}, Sqrt(five), d)
		require.Panics(t, func() { Sqrt_Into(dst, five) })

		require.Empty(t, Round(empty))
		require.InDeltaSlice(t, one, Round(one), d)
		require.InDeltaSlice(t, four, Round(AddNumber(four, 0.2)), d)
		require.InDeltaSlice(t, AddNumber(four, 1), Round(AddNumber(four, 0.5)), d)
		require.InDeltaSlice(t, AddNumber(four, 1), Round(AddNumber(four, 0.8)), d)
		require.InDeltaSlice(t, five, Round(AddNumber(five, 0.2)), d)
		require.InDeltaSlice(t, AddNumber(five, 1), Round(AddNumber(five, 0.5)), d)
		require.InDeltaSlice(t, AddNumber(five, 1), Round(AddNumber(five, 0.8)), d)
		dst = Round_Into(dst, four)
		require.InDeltaSlice(t, four, dst, d)
		require.Panics(t, func() { Round_Into(dst, five) })

		require.Empty(t, Floor(empty))
		require.InDeltaSlice(t, one, Floor(one), d)
		require.InDeltaSlice(t, four, Floor(AddNumber(four, 0.2)), d)
		require.InDeltaSlice(t, four, Floor(AddNumber(four, 0.5)), d)
		require.InDeltaSlice(t, four, Floor(AddNumber(four, 0.8)), d)
		require.InDeltaSlice(t, five, Floor(AddNumber(five, 0.2)), d)
		require.InDeltaSlice(t, five, Floor(AddNumber(five, 0.5)), d)
		require.InDeltaSlice(t, five, Floor(AddNumber(five, 0.8)), d)
		dst = Floor_Into(dst, four)
		require.InDeltaSlice(t, four, dst, d)
		require.Panics(t, func() { Floor_Into(dst, five) })

		require.Empty(t, Ceil(empty))
		require.InDeltaSlice(t, one, Ceil(one), d)
		require.InDeltaSlice(t, AddNumber(four, 1), Ceil(AddNumber(four, 0.2)), d)
		require.InDeltaSlice(t, AddNumber(four, 1), Ceil(AddNumber(four, 0.5)), d)
		require.InDeltaSlice(t, AddNumber(four, 1), Ceil(AddNumber(four, 0.8)), d)
		require.InDeltaSlice(t, AddNumber(five, 1), Ceil(AddNumber(five, 0.2)), d)
		require.InDeltaSlice(t, AddNumber(five, 1), Ceil(AddNumber(five, 0.5)), d)
		require.InDeltaSlice(t, AddNumber(five, 1), Ceil(AddNumber(five, 0.8)), d)
		dst = Ceil_Into(dst, four)
		require.InDeltaSlice(t, four, dst, d)
		require.Panics(t, func() { Ceil_Into(dst, five) })
	}
}

func TestComparison(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float64, 4)

		require.Panics(t, func() { Min(empty) })
		require.Equal(t, 1., Min(one))
		require.Equal(t, 1., Min(four))
		require.Equal(t, 1., Min(five))

		require.Panics(t, func() { ArgMin(empty) })
		require.Equal(t, 0, ArgMin(one))
		require.Equal(t, 0, ArgMin(four))
		require.Equal(t, 0, ArgMin(five))

		require.Panics(t, func() { Minimum(one, two) })
		require.Equal(t, empty, Minimum(empty, nil))
		require.Equal(t, one, Minimum(one, one))
		require.Equal(t, four, Minimum(four, four))
		require.Equal(t, negFour, Minimum(four, negFour))
		require.Equal(t, five, Minimum(five, five))
		require.Equal(t, negFive, Minimum(five, negFive))
		require.Panics(t, func() { Minimum_Into(dst, five, five) })

		require.Equal(t, empty, MinimumNumber(empty, 2.5))
		require.Equal(t, one, MinimumNumber(one, 2.5))
		require.Equal(t, []float64{1, 2, 2.5, 2.5}, MinimumNumber(four, 2.5))
		require.Equal(t, []float64{1, 2, 2.5, 2.5, 2.5}, MinimumNumber(five, 2.5))
		require.Panics(t, func() { MinimumNumber_Into(dst, five, 2.5) })

		require.Panics(t, func() { Max(empty) })
		require.Equal(t, 1., Max(one))
		require.Equal(t, 4., Max(four))
		require.Equal(t, 5., Max(five))

		require.Panics(t, func() { ArgMax(empty) })
		require.Equal(t, 0, ArgMax(one))
		require.Equal(t, 3, ArgMax(four))
		require.Equal(t, 4, ArgMax(five))

		require.Panics(t, func() { Maximum(one, two) })
		require.Equal(t, empty, Maximum(empty, nil))
		require.Equal(t, one, Maximum(one, one))
		require.Equal(t, four, Maximum(four, four))
		require.Equal(t, four, Maximum(four, negFour))
		require.Equal(t, five, Maximum(five, five))
		require.Equal(t, five, Maximum(five, negFive))
		require.Panics(t, func() { Maximum_Into(dst, five, five) })

		require.Equal(t, empty, MaximumNumber(empty, 2.5))
		require.Equal(t, []float64{2.5}, MaximumNumber(one, 2.5))
		require.Equal(t, []float64{2.5, 2.5, 3, 4}, MaximumNumber(four, 2.5))
		require.Equal(t, []float64{2.5, 2.5, 3, 4, 5}, MaximumNumber(five, 2.5))
		require.Panics(t, func() { MaximumNumber_Into(dst, five, 2.5) })

		require.Equal(t, -1, Find(empty, 1))
		require.Equal(t, 0, Find(one, 1))
		require.Equal(t, -1, Find(one, 2))
		require.Equal(t, 3, Find(four, 4))
		require.Equal(t, 4, Find(AddNumber(five, 0.5), 5.5))

		dstBool := make([]bool, 4)

		require.Equal(t, []bool{}, Lt(empty, empty))
		require.Equal(t, []bool{false}, Lt(one, one))
		require.Equal(t, []bool{true}, Lt(negOne, one))
		require.Equal(t, []bool{false, false, false, false}, Lt(four, four))
		require.Equal(t, []bool{true, true, true, true}, Lt(negFour, four))
		require.Equal(t, []bool{false, false, false, false, false}, Lt(five, five))
		require.Equal(t, []bool{true, true, true, true, true}, Lt(negFive, five))
		dstBool = Lt_Into(dstBool, negFour, four)
		require.Equal(t, []bool{true, true, true, true}, dstBool)
		require.Panics(t, func() { Lt_Into(dstBool, five, five) })

		require.Equal(t, []bool{}, LtNumber(empty, 2.5))
		require.Equal(t, []bool{true}, LtNumber(one, 2.5))
		require.Equal(t, []bool{true, true, false, false}, LtNumber(four, 2.5))
		require.Equal(t, []bool{true, true, false, false, false}, LtNumber(five, 2.5))
		require.Panics(t, func() { LtNumber_Into(dstBool, five, 2.5) })

		require.Equal(t, []bool{}, Lte(empty, empty))
		require.Equal(t, []bool{true}, Lte(one, one))
		require.Equal(t, []bool{false}, Lte(AddNumber(one, 1), one))
		require.Equal(t, []bool{true, true, true, true}, Lte(four, four))
		require.Equal(t, []bool{false, false, false, false}, Lte(AddNumber(four, 1), four))
		require.Equal(t, []bool{true, true, true, true, true}, Lte(five, five))
		require.Equal(t, []bool{false, false, false, false, false}, Lte(AddNumber(five, 1), five))
		require.Panics(t, func() { Lte_Into(dstBool, five, five) })

		require.Equal(t, []bool{}, LteNumber(empty, 2.5))
		require.Equal(t, []bool{true}, LteNumber(one, 2.5))
		require.Equal(t, []bool{true, true, true, false}, LteNumber(four, 3.0))
		require.Equal(t, []bool{true, true, true, false, false}, LteNumber(five, 3.0))
		require.Panics(t, func() { LteNumber_Into(dstBool, five, 2.5) })

		require.Equal(t, []bool{}, Gt(empty, empty))
		require.Equal(t, []bool{false}, Gt(one, one))
		require.Equal(t, []bool{true}, Gt(one, negOne))
		require.Equal(t, []bool{false, false, false, false}, Gt(four, four))
		require.Equal(t, []bool{true, true, true, true}, Gt(four, negFour))
		require.Equal(t, []bool{false, false, false, false, false}, Gt(five, five))
		require.Equal(t, []bool{true, true, true, true, true}, Gt(five, negFive))
		require.Panics(t, func() { Gt_Into(dstBool, five, five) })

		require.Equal(t, []bool{}, GtNumber(empty, 2.5))
		require.Equal(t, []bool{false}, GtNumber(one, 2.5))
		require.Equal(t, []bool{false, false, true, true}, GtNumber(four, 2.5))
		require.Equal(t, []bool{false, false, true, true, true}, GtNumber(five, 2.5))
		require.Panics(t, func() { GtNumber_Into(dstBool, five, 2.5) })

		require.Equal(t, []bool{}, Gte(empty, empty))
		require.Equal(t, []bool{true}, Gte(one, one))
		require.Equal(t, []bool{false}, Gte(one, AddNumber(one, 1)))
		require.Equal(t, []bool{true, true, true, true}, Gte(four, four))
		require.Equal(t, []bool{false, false, false, false}, Gte(four, AddNumber(four, 1)))
		require.Equal(t, []bool{true, true, true, true, true}, Gte(five, five))
		require.Equal(t, []bool{false, false, false, false, false}, Gte(five, AddNumber(five, 1)))
		require.Panics(t, func() { Gte_Into(dstBool, five, five) })

		require.Equal(t, []bool{}, GteNumber(empty, 2.5))
		require.Equal(t, []bool{true}, GteNumber(one, 1.0))
		require.Equal(t, []bool{false}, GteNumber(one, 2.5))
		require.Equal(t, []bool{false, false, true, true}, GteNumber(four, 3.0))
		require.Equal(t, []bool{false, false, true, true, true}, GteNumber(five, 3.0))
		require.Panics(t, func() { GteNumber_Into(dstBool, five, 2.5) })

		require.Equal(t, []bool{}, Eq(empty, empty))
		require.Equal(t, []bool{true}, Eq(one, one))
		require.Equal(t, []bool{false}, Eq(negOne, one))
		require.Equal(t, []bool{true, true, true, true}, Eq(four, four))
		require.Equal(t, []bool{false, false, false, false}, Eq(negFour, four))
		require.Equal(t, []bool{true, true, true, true, true}, Eq(five, five))
		require.Equal(t, []bool{false, false, false, false, false}, Eq(negFive, five))
		require.Panics(t, func() { Eq_Into(dstBool, five, five) })

		require.Equal(t, []bool{}, EqNumber(empty, 2.5))
		require.Equal(t, []bool{true}, EqNumber(one, 1.0))
		require.Equal(t, []bool{false}, EqNumber(one, 2.5))
		require.Equal(t, []bool{false, false, true, false}, EqNumber(four, 3.0))
		require.Equal(t, []bool{false, false, true, false, false}, EqNumber(five, 3.0))
		require.Panics(t, func() { EqNumber_Into(dstBool, five, 2.5) })

		require.Equal(t, []bool{}, Neq(empty, empty))
		require.Equal(t, []bool{false}, Neq(one, one))
		require.Equal(t, []bool{true}, Neq(negOne, one))
		require.Equal(t, []bool{false, false, false, false}, Neq(four, four))
		require.Equal(t, []bool{true, true, true, true}, Neq(negFour, four))
		require.Equal(t, []bool{false, false, false, false, false}, Neq(five, five))
		require.Equal(t, []bool{true, true, true, true, true}, Neq(negFive, five))
		require.Panics(t, func() { Neq_Into(dstBool, five, five) })

		require.Equal(t, []bool{}, NeqNumber(empty, 2.5))
		require.Equal(t, []bool{true}, NeqNumber(one, 2.5))
		require.Equal(t, []bool{false}, NeqNumber(one, 1.0))
		require.Equal(t, []bool{true, true, false, true}, NeqNumber(four, 3.0))
		require.Equal(t, []bool{true, true, false, true, true}, NeqNumber(five, 3.0))
		require.Panics(t, func() { NeqNumber_Into(dstBool, five, 2.5) })
	}
}

func TestBool(t *testing.T) {
	var emptyBool []bool = []bool{}
	var oneBool []bool = []bool{true}
	var twoBool []bool = []bool{true, false}
	var thirtyTwoBool []bool = append(ToBool(Ones(16)), ToBool(Zeros(16))...) // AVX register
	var negThirtyTwoBool []bool = append(ToBool(Zeros(16)), ToBool(Ones(16))...)
	var thirtyThreeBool []bool = append(ToBool(Ones(16)), ToBool(Zeros(17))...)
	var negThirtyThreeBool []bool = append(ToBool(Zeros(16)), ToBool(Ones(17))...)

	dstBool := make([]bool, 4)

	for _, accel := range accel {
		SetAcceleration(accel)

		require.Equal(t, []bool{}, Not(emptyBool))
		require.Equal(t, []bool{false}, Not(oneBool))
		require.Equal(t, []bool{false, true}, Not(twoBool))
		require.Equal(t, negThirtyTwoBool, Not(thirtyTwoBool))
		require.Equal(t, negThirtyThreeBool, Not(thirtyThreeBool))
		require.Panics(t, func() { Not_Into(dstBool, thirtyTwoBool) })

		require.Panics(t, func() { And(oneBool, twoBool) })
		require.Equal(t, []bool{}, And(emptyBool, nil))
		require.Equal(t, []bool{true}, And(oneBool, oneBool))
		require.Equal(t, []bool{true, false}, And(twoBool, twoBool))
		require.Equal(t, thirtyTwoBool, And(thirtyTwoBool, thirtyTwoBool))
		require.Equal(t, ToBool(Zeros(32)), And(thirtyTwoBool, negThirtyTwoBool))
		require.Equal(t, thirtyThreeBool, And(thirtyThreeBool, thirtyThreeBool))
		require.Equal(t, ToBool(Zeros(33)), And(thirtyThreeBool, negThirtyThreeBool))
		require.Panics(t, func() { And_Into(dstBool, thirtyTwoBool, thirtyTwoBool) })

		require.Panics(t, func() { Or(oneBool, twoBool) })
		require.Equal(t, []bool{}, Or(emptyBool, nil))
		require.Equal(t, []bool{true}, Or(oneBool, oneBool))
		require.Equal(t, []bool{true, false}, Or(twoBool, twoBool))
		require.Equal(t, thirtyTwoBool, Or(thirtyTwoBool, thirtyTwoBool))
		require.Equal(t, ToBool(Ones(32)), Or(thirtyTwoBool, negThirtyTwoBool))
		require.Equal(t, thirtyThreeBool, Or(thirtyThreeBool, thirtyThreeBool))
		require.Equal(t, ToBool(Ones(33)), Or(thirtyThreeBool, negThirtyThreeBool))
		require.Panics(t, func() { Or_Into(dstBool, thirtyTwoBool, thirtyTwoBool) })

		require.Panics(t, func() { Xor(oneBool, twoBool) })
		require.Equal(t, []bool{}, Xor(emptyBool, nil))
		require.Equal(t, []bool{false}, Xor(oneBool, oneBool))
		require.Equal(t, []bool{false, false}, Xor(twoBool, twoBool))
		require.Equal(t, ToBool(Zeros(32)), Xor(thirtyTwoBool, thirtyTwoBool))
		require.Equal(t, ToBool(Ones(32)), Xor(thirtyTwoBool, negThirtyTwoBool))
		require.Equal(t, ToBool(Zeros(33)), Xor(thirtyThreeBool, thirtyThreeBool))
		require.Equal(t, ToBool(Ones(33)), Xor(thirtyThreeBool, negThirtyThreeBool))
		require.Panics(t, func() { Xor_Into(dstBool, thirtyTwoBool, thirtyTwoBool) })

		dst := make([]float64, 4)

		require.Panics(t, func() { Select(one, twoBool) })
		require.Equal(t, empty, Select(empty, emptyBool))
		require.Equal(t, one, Select(one, []bool{true}))
		require.Equal(t, empty, Select(one, []bool{false}))
		require.Equal(t, Range(1, 17), Select(Range(1, 33), thirtyTwoBool))
		require.Equal(t, Range(17, 34), Select(Range(1, 34), negThirtyThreeBool))
		dst = Select_Into(dst, Range(1, 34), negThirtyThreeBool) // no capacity check as result size is unknown
		require.Equal(t, Range(17, 34), dst)

		require.Equal(t, true, All(emptyBool))
		require.Equal(t, true, All(oneBool))
		require.Equal(t, false, All(thirtyTwoBool))
		require.Equal(t, true, All(ToBool(Ones(32))))
		require.Equal(t, false, All(thirtyThreeBool))
		require.Equal(t, true, All(ToBool(Ones(33))))

		require.Equal(t, false, Any(emptyBool))
		require.Equal(t, true, Any(oneBool))
		require.Equal(t, true, Any(thirtyTwoBool))
		require.Equal(t, false, Any(ToBool(Zeros(32))))
		require.Equal(t, true, Any(thirtyThreeBool))
		require.Equal(t, false, Any(ToBool(Zeros(33))))

		require.Equal(t, true, None(emptyBool))
		require.Equal(t, false, None(oneBool))
		require.Equal(t, false, None(thirtyTwoBool))
		require.Equal(t, true, None(ToBool(Zeros(32))))
		require.Equal(t, false, None(thirtyThreeBool))
		require.Equal(t, true, None(ToBool(Zeros(33))))

		require.Equal(t, 0, Count(emptyBool))
		require.Equal(t, 1, Count(oneBool))
		require.Equal(t, 16, Count(thirtyTwoBool))
		require.Equal(t, 0, Count(ToBool(Zeros(32))))
		require.Equal(t, 32, Count(ToBool(Ones(32))))
		require.Equal(t, 16, Count(thirtyThreeBool))
		require.Equal(t, 0, Count(ToBool(Zeros(33))))
		require.Equal(t, 33, Count(ToBool(Ones(33))))
	}
}

func TestConstruction(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float64, 4)

		require.Equal(t, empty, Zeros(0))
		require.Equal(t, []float64{0}, Zeros(1))
		require.Equal(t, []float64{0, 0, 0, 0}, Zeros(4))
		require.Equal(t, []float64{0, 0, 0, 0, 0}, Zeros(5))
		require.Panics(t, func() { Zeros_Into(dst, 5) })

		require.Equal(t, empty, Ones(0))
		require.Equal(t, []float64{1}, Ones(1))
		require.Equal(t, []float64{1, 1, 1, 1}, Ones(4))
		require.Equal(t, []float64{1, 1, 1, 1, 1}, Ones(5))
		require.Panics(t, func() { Ones_Into(dst, 5) })

		require.Panics(t, func() { Repeat(3, -1) })
		require.Equal(t, empty, Repeat(3, 0))
		require.Equal(t, []float64{3}, Repeat(3, 1))
		require.Equal(t, []float64{3, 3, 3, 3}, Repeat(3, 4))
		require.Equal(t, []float64{3, 3, 3, 3, 3}, Repeat(3, 5))
		require.Panics(t, func() { Repeat_Into(dst, 3, 5) })

		require.Equal(t, empty, Range(0, 0))
		require.Equal(t, empty, Range(1, 0))
		require.Equal(t, []float64{0}, Range(0, 0.1))
		require.Equal(t, []float64{0}, Range(0, 1))
		require.Equal(t, []float64{-0.3, 0.7, 1.7}, Range(-0.3, 1.8))
		require.Equal(t, []float64{0, 1, 2, 3}, Range(0, 4))
		require.Equal(t, []float64{0, 1, 2, 3, 4}, Range(0, 5))
		require.Panics(t, func() { Range_Into(dst, 0, 5) })

		require.Panics(t, func() { Gather(one, []int{-1}) })
		require.Equal(t, empty, Gather(empty, []int{}))
		require.Equal(t, []float64{1}, Gather(one, []int{0}))
		require.Equal(t, []float64{1, 1}, Gather(one, []int{0, 0}))
		require.Equal(t, []float64{4, 2}, Gather(four, []int{3, 1}))
		require.Equal(t, []float64{5, 2, 5}, Gather(five, []int{4, 1, 4}))
		require.Panics(t, func() { Gather_Into(dst, five, []int{0, 0, 0, 0, 0}) })

		require.Panics(t, func() { Scatter(one, []int{}, -1) })
		require.Panics(t, func() { Scatter(one, []int{0, 0}, 1) })
		require.Equal(t, empty, Scatter(empty, []int{}, 0))
		require.Equal(t, []float64{0}, Scatter(empty, []int{}, 1))
		require.Equal(t, []float64{1}, Scatter(one, []int{0}, 1))
		require.Equal(t, []float64{2, 0, 1}, Scatter(two, []int{2, 0}, 3))
		require.Equal(t, []float64{3, 4}, Scatter(four, []int{1, 0, 0, 1}, 2))
		require.Equal(t, []float64{5, 4, 3, 2, 1, 0}, Scatter(five, []int{4, 3, 2, 1, 0}, 6))
	}
}
