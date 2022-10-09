package vek

import (
	"github.com/viterin/vek/internal/functions"
	"golang.org/x/exp/constraints"
	"golang.org/x/exp/slices"
	"golang.org/x/sys/cpu"
	"math"
	"unsafe"
)

// Arithmetic

// Add returns the result of adding two slices element-wise.
func Add(x, y []float64) []float64 {
	x = slices.Clone(x)
	Add_Inplace(x, y)
	return x
}

// Add_Inplace adds a slice element-wise to the first slice, inplace.
func Add_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Add_AVX2_F64(x, y)
	} else {
		functions.Add_Go(x, y)
	}
}

// Add_Into adds two slices element-wise and stores the result in the destination slice.
func Add_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Add_Inplace(dst, y)
	return dst
}

// Sub returns the result of subtracting two slices element-wise.
func Sub(x, y []float64) []float64 {
	x = slices.Clone(x)
	Sub_Inplace(x, y)
	return x
}

// Sub_Inplace subtracts a slice element-wise from the first slice, inplace.
func Sub_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Sub_AVX2_F64(x, y)
	} else {
		functions.Sub_Go(x, y)
	}
}

// Sub_Into subtracts two slices element-wise and stores the result in the destination slice.
func Sub_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Sub_Inplace(dst, y)
	return dst
}

// Mul returns the result of multiplying two slices element-wise.
func Mul(x, y []float64) []float64 {
	x = slices.Clone(x)
	Mul_Inplace(x, y)
	return x
}

// Mul_Inplace multiplies the first slice element-wise by the second, inplace.
func Mul_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Mul_AVX2_F64(x, y)
	} else {
		functions.Mul_Go(x, y)
	}
}

// Mul_Into multiplies two slices element-wise and stores the result in the destination slice.
func Mul_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Mul_Inplace(dst, y)
	return dst
}

// Div returns the result of dividing two slices element-wise.
func Div(x, y []float64) []float64 {
	x = slices.Clone(x)
	Div_Inplace(x, y)
	return x
}

// Div_Inplace divides the first slice element-wise by the second, inplace.
func Div_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Div_AVX2_F64(x, y)
	} else {
		functions.Div_Go(x, y)
	}
}

// Div_Into divides two slices element-wise and stores the result in the destination slice.
func Div_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Div_Inplace(dst, y)
	return dst
}

// Mod returns the element-wise, Euclidean modulus of two slices. This differs from the % operator
// for negative numbers, for example Mod(-2, 3) == 1. No SIMD acceleration yet, use ModNumber if
// possible.
func Mod(x, y []float64) []float64 {
	x = slices.Clone(x)
	Mod_Inplace(x, y)
	return x
}

// Mod_Inplace computes the element-wise, Euclidean modulus of two slices, inplace. This differs
// from the % operator for negative numbers, for example Mod(-2, 3) == 1. No SIMD acceleration yet,
// use ModNumber if possible.
func Mod_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		// no vectorized version yet
		functions.Mod_Go_F64(x, y)
	} else {
		functions.Mod_Go_F64(x, y)
	}
}

// Mod_Into computes the element-wise, Euclidean modulus of two slices and stores the result in the
// destination slice. This differs from the % operator for negative numbers, for example Mod(-2, 3) == 1.
// No SIMD acceleration yet, use ModNumber if possible.
func Mod_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Mod_Inplace(dst, y)
	return dst
}

// AddNumber returns the result of adding a number to each slice element.
func AddNumber(x []float64, a float64) []float64 {
	x = slices.Clone(x)
	AddNumber_Inplace(x, a)
	return x
}

// AddNumber_Inplace adds a number to each slice element, inplace.
func AddNumber_Inplace(x []float64, a float64) {
	if functions.UseAVX2 {
		functions.AddNumber_AVX2_F64(x, a)
	} else {
		functions.AddNumber_Go(x, a)
	}
}

// AddNumber_Into adds a number to each slice element and stores the result in the
// destination slice.
func AddNumber_Into(dst, x []float64, a float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	AddNumber_Inplace(dst, a)
	return dst
}

// SubNumber returns the result of subtracting a number from each slice element.
func SubNumber(x []float64, a float64) []float64 {
	x = slices.Clone(x)
	SubNumber_Inplace(x, a)
	return x
}

// SubNumber_Inplace subtracts a number from each slice element, inplace.
func SubNumber_Inplace(x []float64, a float64) {
	if functions.UseAVX2 {
		functions.SubNumber_AVX2_F64(x, a)
	} else {
		functions.SubNumber_Go(x, a)
	}
}

// SubNumber_Into subtracts a number from each slice element and stores the result in the
// destination slice.
func SubNumber_Into(dst, x []float64, a float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	SubNumber_Inplace(dst, a)
	return dst
}

// MulNumber returns the result of multiplying each slice element by a number.
func MulNumber(x []float64, a float64) []float64 {
	x = slices.Clone(x)
	MulNumber_Inplace(x, a)
	return x
}

// MulNumber_Inplace multiplies each slice element by a number, inplace.
func MulNumber_Inplace(x []float64, a float64) {
	if functions.UseAVX2 {
		functions.MulNumber_AVX2_F64(x, a)
	} else {
		functions.MulNumber_Go(x, a)
	}
}

// MulNumber_Into multiplies each slice element by a number and stores the result in the
// destination slice.
func MulNumber_Into(dst, x []float64, a float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	MulNumber_Inplace(dst, a)
	return dst
}

// DivNumber returns the result of dividing each slice element by a number.
func DivNumber(x []float64, a float64) []float64 {
	x = slices.Clone(x)
	DivNumber_Inplace(x, a)
	return x
}

// DivNumber_Inplace divides each slice element by a number, inplace.
func DivNumber_Inplace(x []float64, a float64) {
	if functions.UseAVX2 {
		functions.DivNumber_AVX2_F64(x, a)
	} else {
		functions.DivNumber_Go(x, a)
	}
}

// DivNumber_Into divides each slice element by a number and stores the result in the
// destination slice.
func DivNumber_Into(dst, x []float64, a float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	DivNumber_Inplace(dst, a)
	return dst
}

// ModNumber computes the Euclidean modulus of each element and a number. This differs from the
// % operator for negative numbers, for example Mod(-2, 3) == 1.
func ModNumber(x []float64, y float64) []float64 {
	x = slices.Clone(x)
	ModNumber_Inplace(x, y)
	return x
}

// ModNumber_Inplace computes the Euclidean modulus of each element and a number, inplace. This
// differs from the % operator for negative numbers, for example Mod(-2, 3) == 1.
func ModNumber_Inplace(x []float64, y float64) {
	if functions.UseAVX2 {
		functions.ModNumber_AVX2_F64(x, y)
	} else {
		functions.ModNumber_Go_F64(x, y)
	}
}

// ModNumber_Into computes the Euclidean modulus of each element and a number and stores the result in
// the destination slice. This differs from the % operator for negative numbers, for example Mod(-2, 3) == 1.
func ModNumber_Into(dst, x []float64, y float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	ModNumber_Inplace(dst, y)
	return dst
}

// Abs returns the absolute value of each slice element.
func Abs(x []float64) []float64 {
	x = slices.Clone(x)
	Abs_Inplace(x)
	return x
}

// Abs_Inplace computes the absolute value of each slice element, inplace.
func Abs_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Abs_AVX2_F64(x)
	} else {
		functions.Abs_Go_F64(x)
	}
}

// Abs_Into computes the absolute value of each slice element and stores the result in the
// destination slice.
func Abs_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Abs_Inplace(dst)
	return dst
}

// Neg returns the additive inverse of each slice element.
func Neg(x []float64) []float64 {
	x = slices.Clone(x)
	Neg_Inplace(x)
	return x
}

// Neg_Inplace computes the additive inverse of each slice element, inplace.
func Neg_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Neg_AVX2_F64(x)
	} else {
		functions.Neg_Go(x)
	}
}

// Neg_Into computes the additive inverse of each slice element and stores the result in the
// destination slice.
func Neg_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Neg_Inplace(dst)
	return dst
}

// Inv returns the multiplicative inverse of each slice element.
func Inv(x []float64) []float64 {
	x = slices.Clone(x)
	Inv_Inplace(x)
	return x
}

// Inv_Inplace computes the multiplicative inverse of each slice element, inplace.
func Inv_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Inv_AVX2_F64(x)
	} else {
		functions.Inv_Go(x)
	}
}

// Inv_Into computes the multiplicative inverse of each slice element and stores the result
// in the destination slice.
func Inv_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Inv_Inplace(dst)
	return dst
}

// Aggregates

// Sum returns the sum of all elements in a slice.
func Sum(x []float64) float64 {
	if functions.UseAVX2 {
		return functions.Sum_AVX2_F64(x)
	} else {
		return functions.Sum_Go(x)
	}
}

// CumSum returns the cumulative sum of a slice. The element at index i equals the sum of x[:i+1].
func CumSum(x []float64) []float64 {
	x = slices.Clone(x)
	CumSum_Inplace(x)
	return x
}

// CumSum_Inplace computes the cumulative sum of a slice, inplace. The new element at index i
// equals the sum of x[:i+1].
func CumSum_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.CumSum_AVX2_F64(x)
	} else {
		functions.CumSum_Go(x)
	}
}

// CumSum_Into computes the cumulative sum of a slice and stores the result in the destination
// slice. The element at index i equals the sum of x[:i+1].
func CumSum_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	CumSum_Inplace(dst)
	return dst
}

// Prod returns the product of all elements in a slice.
func Prod(x []float64) float64 {
	if functions.UseAVX2 {
		return functions.Prod_AVX2_F64(x)
	} else {
		return functions.Prod_Go(x)
	}
}

// CumProd returns the cumulative product of a slice. The element at index i equals the product
// of x[:i+1].
func CumProd(x []float64) []float64 {
	x = slices.Clone(x)
	CumProd_Inplace(x)
	return x
}

// CumProd_Inplace computes the cumulative product of a slice, inplace. The new element at index i
// equals the product of x[:i+1].
func CumProd_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.CumProd_AVX2_F64(x)
	} else {
		functions.CumProd_Go(x)
	}
}

// CumProd_Into computes the cumulative product of a slice and stores the result in the destination
// slice. The element at index i equals the product of x[:i+1].
func CumProd_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	CumProd_Inplace(dst)
	return dst
}

// Mean returns the arithmetic average of the slice elements.
func Mean(x []float64) float64 {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.Mean_AVX2_F64(x)
	} else {
		return functions.Mean_Go(x)
	}
}

// Median returns the median value of the slice elements.
func Median(x []float64) float64 {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.Median_AVX2_F64(x)
	} else {
		return functions.Median_Go(x)
	}
}

// Quantile returns the q-th quantile of the slice elements. The value of q should be between
// 0 and 1 (inclusive).
func Quantile(x []float64, q float64) float64 {
	if q < 0 || q > 1 {
		panic("value of q should be between 0 and 1")
	}
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.Quantile_AVX2_F64(x, q)
	} else {
		return functions.Quantile_Go(x, q)
	}
}

// Distance

// Dot returns the dot product of two vectors.
func Dot(x, y []float64) float64 {
	checkNotEmpty(x)
	checkEqualLength(x, y)
	if functions.UseAVX2 {
		return functions.Dot_AVX2_F64(x, y)
	} else {
		return functions.Dot_Go(x, y)
	}
}

// Norm returns the Euclidean norm of a vector, i.e. its length.
func Norm(x []float64) float64 {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.Norm_AVX2_F64(x)
	} else {
		return functions.Norm_Go_F64(x)
	}
}

// Distance returns the Euclidean distance between two vectors.
func Distance(x, y []float64) float64 {
	checkNotEmpty(x)
	checkEqualLength(x, y)
	if functions.UseAVX2 {
		return functions.Distance_AVX2_F64(x, y)
	} else {
		return functions.Distance_Go_F64(x, y)
	}
}

// ManhattanNorm returns the sum of absolute values of the slice elements.
func ManhattanNorm(x []float64) float64 {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.ManhattanNorm_AVX2_F64(x)
	} else {
		return functions.ManhattanNorm_Go_F64(x)
	}
}

// ManhattanDistance returns the sum of element-wise absolute differences between two slices.
func ManhattanDistance(x, y []float64) float64 {
	checkNotEmpty(x)
	checkEqualLength(x, y)
	if functions.UseAVX2 {
		return functions.ManhattanDistance_AVX2_F64(x, y)
	} else {
		return functions.ManhattanDistance_Go_F64(x, y)
	}
}

// CosineSimilarity returns the cosine similarity of two vectors.
func CosineSimilarity(x, y []float64) float64 {
	checkNotEmpty(x)
	checkEqualLength(x, y)
	if functions.UseAVX2 {
		return functions.CosineSimilarity_AVX2_F64(x, y)
	} else {
		return functions.CosineSimilarity_Go_F64(x, y)
	}
}

// Matrices

func checkDimensions[T constraints.Float](x, y []T, n int) (int, int) {
	if n < 1 || len(x) == 0 || len(y) == 0 {
		panic("slices must be non-empty with positive n")
	}
	m := len(x) / n
	p := len(y) / n
	if m*n < len(x) || n*p < len(y) {
		panic("slice lengths must be multiple of n")
	}
	return m, p
}

// MatMul multiplies an m-by-n and n-by-p matrix and returns the resulting m-by-p matrix.
// The matrices should be in row-major order. To multiply a matrix and a vector pass an
// n-by-1 matrix.
func MatMul(x, y []float64, n int) []float64 {
	m, p := checkDimensions(x, y, n)
	dst := make([]float64, m*p)
	if functions.UseAVX2 {
		functions.MatMul_Parallel_AVX2_F64(dst, x, y, m, n, p)
	} else {
		functions.MatMul_Parallel_Go(dst, x, y, m, n, p)
	}
	return dst
}

// MatMul_Into multiplies an m-by-n and n-by-p matrix and stores the resulting m-by-p matrix
// in the destination slice. The matrices should be in row-major order. To multiply a matrix
// and a vector pass an n-by-1 matrix.
func MatMul_Into(dst, x, y []float64, n int) []float64 {
	m, p := checkDimensions(x, y, n)
	if cap(dst) < m*p {
		panic("destination slice not large enough to hold result")
	}
	Zeros_Into(dst, m*p)
	if functions.UseAVX2 {
		functions.MatMul_Parallel_AVX2_F64(dst, x, y, m, n, p)
	} else {
		functions.MatMul_Parallel_Go(dst, x, y, m, n, p)
	}
	return dst[:m*p]
}

// Mat4Mul multiplies two 4-by-4 matrices and returns the resulting 4-by-4 matrix. The matrices
// should be in row-major order. To multiply a matrix and a vector batch them into groups of 4.
func Mat4Mul(x, y []float64) []float64 {
	var dst [16]float64
	return Mat4Mul_Into(dst[:], x, y)
}

// Mat4Mul_Into multiplies two 4-by-4 matrices and stores the resulting 4-by-4 matrix in the
// destination slice. The matrices should be in row-major order. To multiply a matrix and a vector
// batch them into groups of 4.
func Mat4Mul_Into(dst, x, y []float64) []float64 {
	// Note: skipping overlap check due to overhead
	if cap(dst) < 16 || len(x) != 16 || len(y) != 16 {
		panic("slices must be length 16 (4 by 4)")
	}
	if functions.UseAVX2 {
		functions.Mat4Mul_AVX2_F64(dst, x, y)
	} else {
		functions.Mat4Mul_Go(dst, x, y)
	}
	return dst[:16]
}

// Special

// Sqrt returns the square root of each slice element.
func Sqrt(x []float64) []float64 {
	x = slices.Clone(x)
	Sqrt_Inplace(x)
	return x
}

// Sqrt_Inplace computes the square root of each slice element, inplace.
func Sqrt_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Sqrt_AVX2_F64(x)
	} else {
		functions.Sqrt_Go_F64(x)
	}
}

// Sqrt_Into computes the square root of each slice element and stores the result in the
// destination slice.
func Sqrt_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Sqrt_Inplace(dst)
	return dst
}

// Round returns the result of rounding each slice element to the nearest integer value.
func Round(x []float64) []float64 {
	x = slices.Clone(x)
	Round_Inplace(x)
	return x
}

// Round_Inplace rounds each slice element to the nearest integer value, inplace.
func Round_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Round_AVX2_F64(x)
	} else {
		functions.Round_Go_F64(x)
	}
}

// Round_Into rounds each slice element to the nearest integer value and stores the result
// in the destination slice.
func Round_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Round_Inplace(dst)
	return dst
}

// Floor returns the result of rounding each slice element to the nearest lesser integer value.
func Floor(x []float64) []float64 {
	x = slices.Clone(x)
	Floor_Inplace(x)
	return x
}

// Floor_Inplace rounds each slice element to the nearest lesser integer value, inplace.
func Floor_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Floor_AVX2_F64(x)
	} else {
		functions.Floor_Go_F64(x)
	}
}

// Floor_Into rounds each slice element to the nearest lesser integer value and stores the result
// in the destination slice.
func Floor_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Floor_Inplace(dst)
	return dst
}

// Ceil returns the result of rounding each slice element to the nearest greater integer value.
func Ceil(x []float64) []float64 {
	x = slices.Clone(x)
	Ceil_Inplace(x)
	return x
}

// Ceil_Inplace rounds each slice element to the nearest greater integer value, inplace.
func Ceil_Inplace(x []float64) {
	if functions.UseAVX2 {
		functions.Ceil_AVX2_F64(x)
	} else {
		functions.Ceil_Go_F64(x)
	}
}

// Ceil_Into rounds each slice element to the nearest greater integer value and stores the result
// in the destination slice.
func Ceil_Into(dst, x []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Ceil_Inplace(dst)
	return dst
}

// Pow returns the elements in the first slice raised to the power in the second.
func Pow(x, y []float64) []float64 {
	x = slices.Clone(x)
	Pow_Inplace(x, y)
	return x
}

// Pow_Inplace raises the elements in the first slice to the power in the second, inplace.
func Pow_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Pow_AVX2_F64(x, y)
	} else {
		functions.Pow_Go_F64(x, y)
	}
}

// Pow_Into raises the elements in the first slice to the power in the second and stores the
// result in the destination slice.
func Pow_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Pow_Inplace(dst, y)
	return dst
}

// Comparison

// Min returns the minimum value of a slice.
func Min(x []float64) float64 {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.Min_AVX2_F64(x)
	} else {
		return functions.Min_Go(x)
	}
}

// ArgMin returns the (first) index of the minimum value of a slice.
func ArgMin(x []float64) int {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.ArgMin_AVX2_F64(x)
	} else {
		return functions.ArgMin_Go(x)
	}
}

// Minimum returns the element-wise minimum values between two slices.
func Minimum(x, y []float64) []float64 {
	x = slices.Clone(x)
	Minimum_Inplace(x, y)
	return x
}

// Minimum_Inplace compares two slices element-wise and replaces the values in the first slice
// with the minimum value.
func Minimum_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Minimum_AVX2_F64(x, y)
	} else {
		functions.Minimum_Go(x, y)
	}
}

// Minimum_Into compares two slices element-wise and stores the minimum values in the destination
// slice.
func Minimum_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Minimum_Inplace(dst, y)
	return dst
}

// MinimumNumber returns the minimum of a number and each slice element.
func MinimumNumber(x []float64, a float64) []float64 {
	x = slices.Clone(x)
	MinimumNumber_Inplace(x, a)
	return x
}

// MinimumNumber_Inplace compares a number to each slice element and replaces the values in the
// slice with the minimum value.
func MinimumNumber_Inplace(x []float64, a float64) {
	if functions.UseAVX2 {
		functions.MinimumNumber_AVX2_F64(x, a)
	} else {
		functions.MinimumNumber_Go(x, a)
	}
}

// MinimumNumber_Into compares a number to each slice element and stores the minimum values in
// the destination slice.
func MinimumNumber_Into(dst, x []float64, a float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	MinimumNumber_Inplace(dst, a)
	return dst
}

// Max returns the maximum value of a slice.
func Max(x []float64) float64 {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.Max_AVX2_F64(x)
	} else {
		return functions.Max_Go(x)
	}
}

// ArgMax returns the (first) index of the maximum value of a slice.
func ArgMax(x []float64) int {
	checkNotEmpty(x)
	if functions.UseAVX2 {
		return functions.ArgMax_AVX2_F64(x)
	} else {
		return functions.ArgMax_Go(x)
	}
}

// Maximum returns the element-wise maximum values between two slices.
func Maximum(x, y []float64) []float64 {
	x = slices.Clone(x)
	Maximum_Inplace(x, y)
	return x
}

// Maximum_Inplace compares two slices element-wise and replaces the values in the first slice
// with the maximum value.
func Maximum_Inplace(x, y []float64) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Maximum_AVX2_F64(x, y)
	} else {
		functions.Maximum_Go(x, y)
	}
}

// Maximum_Into compares two slices element-wise and stores the maximum values in the destination
// slice.
func Maximum_Into(dst, x, y []float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Maximum_Inplace(dst, y)
	return dst
}

// MaximumNumber returns the maximum of a number and each slice element.
func MaximumNumber(x []float64, a float64) []float64 {
	x = slices.Clone(x)
	MaximumNumber_Inplace(x, a)
	return x
}

// MaximumNumber_Inplace compares a number to each slice element and replaces the values in the
// slice with the maximum value.
func MaximumNumber_Inplace(x []float64, a float64) {
	if functions.UseAVX2 {
		functions.MaximumNumber_AVX2_F64(x, a)
	} else {
		functions.MaximumNumber_Go(x, a)
	}
}

// MaximumNumber_Into compares a number to each slice element and stores the maximum values in
// the destination slice.
func MaximumNumber_Into(dst, x []float64, a float64) []float64 {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	MaximumNumber_Inplace(dst, a)
	return dst
}

// Find returns the index of the first slice element equal to the given value, or -1 if not found.
func Find(x []float64, a float64) int {
	if functions.UseAVX2 {
		idx := functions.Find_AVX2_F64(x, a)
		if idx == len(x) {
			return -1
		}
		return idx
	} else {
		return functions.Find_Go(x, a)
	}
}

// Lt returns an element-wise "less than" comparison between two slices.
func Lt(x, y []float64) []bool {
	dst := make([]bool, len(x))
	return Lt_Into(dst, x, y)
}

// Lt_Into stores an element-wise "less than" comparison between two slices in the destination
// slice.
func Lt_Into(dst []bool, x, y []float64) []bool {
	checkEqualLength(x, y)
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.Lt_AVX2_F64(dst, x, y)
	} else {
		functions.Lt_Go(dst, x, y)
	}
	return dst
}

// LtNumber returns an element-wise "less than" comparison between each slice element and
// a number.
func LtNumber(x []float64, a float64) []bool {
	dst := make([]bool, len(x))
	return LtNumber_Into(dst, x, a)
}

// LtNumber_Into stores an element-wise "less than" comparison between each slice element
// and a number in the destination slice.
func LtNumber_Into(dst []bool, x []float64, a float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.LtNumber_AVX2_F64(dst, x, a)
	} else {
		functions.LtNumber_Go(dst, x, a)
	}
	return dst
}

// Lte returns an element-wise "less than or equal" comparison between two slices.
func Lte(x, y []float64) []bool {
	dst := make([]bool, len(x))
	return Lte_Into(dst, x, y)
}

// Lte_Into stores an element-wise "less than or equal" comparison between two slices in the
// destination slice.
func Lte_Into(dst []bool, x, y []float64) []bool {
	checkEqualLength(x, y)
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.Lte_AVX2_F64(dst, x, y)
	} else {
		functions.Lte_Go(dst, x, y)
	}
	return dst
}

// LteNumber returns an element-wise "less than or equal" comparison between each slice element
// and a number.
func LteNumber(x []float64, a float64) []bool {
	dst := make([]bool, len(x))
	return LteNumber_Into(dst, x, a)
}

// LteNumber_Into stores an element-wise "less than or equal" comparison between each slice
// element and a number in the destination slice.
func LteNumber_Into(dst []bool, x []float64, a float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.LteNumber_AVX2_F64(dst, x, a)
	} else {
		functions.LteNumber_Go(dst, x, a)
	}
	return dst
}

// Gt returns an element-wise "greater than" comparison between two slices.
func Gt(x, y []float64) []bool {
	dst := make([]bool, len(x))
	return Gt_Into(dst, x, y)
}

// Gt_Into stores an element-wise "greater than" comparison between two slices in the destination
// slice.
func Gt_Into(dst []bool, x, y []float64) []bool {
	checkEqualLength(x, y)
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.Gt_AVX2_F64(dst, x, y)
	} else {
		functions.Gt_Go(dst, x, y)
	}
	return dst
}

// GtNumber returns an element-wise "greater than" comparison between each slice element and
// a number.
func GtNumber(x []float64, a float64) []bool {
	dst := make([]bool, len(x))
	return GtNumber_Into(dst, x, a)
}

// GtNumber_Into stores an element-wise "greater than" comparison between each slice element and
// a number in the destination slice.
func GtNumber_Into(dst []bool, x []float64, a float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.GtNumber_AVX2_F64(dst, x, a)
	} else {
		functions.GtNumber_Go(dst, x, a)
	}
	return dst
}

// Gte returns an element-wise "greater than or equal" comparison between two slices.
func Gte(x, y []float64) []bool {
	dst := make([]bool, len(x))
	return Gte_Into(dst, x, y)
}

// Gte_Into stores an element-wise "greater than or equal" comparison between two slices in the
// destination slice.
func Gte_Into(dst []bool, x, y []float64) []bool {
	checkEqualLength(x, y)
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.Gte_AVX2_F64(dst, x, y)
	} else {
		functions.Gte_Go(dst, x, y)
	}
	return dst
}

// GteNumber returns an element-wise "greater than or equal" comparison between each slice element
// and a number.
func GteNumber(x []float64, a float64) []bool {
	dst := make([]bool, len(x))
	return GteNumber_Into(dst, x, a)
}

// GteNumber_Into stores an element-wise "greater than or equal" comparison between each slice
// element and a number in the destination slice.
func GteNumber_Into(dst []bool, x []float64, a float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.GteNumber_AVX2_F64(dst, x, a)
	} else {
		functions.GteNumber_Go(dst, x, a)
	}
	return dst
}

// Eq returns an element-wise equality comparison between two slices.
func Eq(x, y []float64) []bool {
	dst := make([]bool, len(x))
	return Eq_Into(dst, x, y)
}

// Eq_Into stores an element-wise equality comparison between two slices in the destination
// slice.
func Eq_Into(dst []bool, x, y []float64) []bool {
	checkEqualLength(x, y)
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.Eq_AVX2_F64(dst, x, y)
	} else {
		functions.Eq_Go(dst, x, y)
	}
	return dst
}

// EqNumber returns an element-wise equality comparison between each slice element and a number.
func EqNumber(x []float64, a float64) []bool {
	dst := make([]bool, len(x))
	return EqNumber_Into(dst, x, a)
}

// EqNumber_Into stores an element-wise equality comparison between each slice element and a
// number in the destination slice.
func EqNumber_Into(dst []bool, x []float64, a float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.EqNumber_AVX2_F64(dst, x, a)
	} else {
		functions.EqNumber_Go(dst, x, a)
	}
	return dst
}

// Neq returns an element-wise "not equal" comparison between two slices.
func Neq(x, y []float64) []bool {
	dst := make([]bool, len(x))
	return Neq_Into(dst, x, y)
}

// Neq_Into stores an element-wise "not equal" comparison between two slices in the destination
// slice.
func Neq_Into(dst []bool, x, y []float64) []bool {
	checkEqualLength(x, y)
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.Neq_AVX2_F64(dst, x, y)
	} else {
		functions.Neq_Go(dst, x, y)
	}
	return dst
}

// NeqNumber returns an element-wise "not equal" comparison between each slice element and a number.
func NeqNumber(x []float64, a float64) []bool {
	dst := make([]bool, len(x))
	return NeqNumber_Into(dst, x, a)
}

// NeqNumber_Into stores an element-wise "not equal" comparison between each slice element and a
// number in the destination slice.
func NeqNumber_Into(dst []bool, x []float64, a float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.NeqNumber_AVX2_F64(dst, x, a)
	} else {
		functions.NeqNumber_Go(dst, x, a)
	}
	return dst
}

// Boolean

// Not returns the logical negation of each slice element.
func Not(x []bool) []bool {
	x = slices.Clone(x)
	Not_Inplace(x)
	return x
}

// Not_Inplace computes the logical negation of each slice element, inplace.
func Not_Inplace(x []bool) {
	if functions.UseAVX2 {
		functions.Not_AVX2(x)
	} else {
		functions.Not_Go(x)
	}
}

// Not_Into stores the logical negation of each slice element in the destination slice.
func Not_Into(dst, x []bool) []bool {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Not_Inplace(dst)
	return dst
}

// And returns the element-wise logical "and" operation between two slices.
func And(x, y []bool) []bool {
	x = slices.Clone(x)
	And_Inplace(x, y)
	return x
}

// And_Inplace computes the element-wise logical "and" operation between two slices, inplace.
func And_Inplace(x, y []bool) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.And_AVX2(x, y)
	} else {
		functions.And_Go(x, y)
	}
}

// And_Into stores the element-wise logical "and" operation between two slices in the destination
// slice.
func And_Into(dst, x, y []bool) []bool {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	And_Inplace(dst, y)
	return dst
}

// Or returns the element-wise logical "or" operation between two slices.
func Or(x, y []bool) []bool {
	x = slices.Clone(x)
	Or_Inplace(x, y)
	return x
}

// Or_Inplace computes the element-wise logical "or" operation between two slices, inplace.
func Or_Inplace(x, y []bool) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Or_AVX2(x, y)
	} else {
		functions.Or_Go(x, y)
	}
}

// Or_Into stores the element-wise logical "or" operation between two slices in the destination
// slice.
func Or_Into(dst, x, y []bool) []bool {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Or_Inplace(dst, y)
	return dst
}

// Xor returns the element-wise "exclusive or" operation between two slices.
func Xor(x, y []bool) []bool {
	x = slices.Clone(x)
	Xor_Inplace(x, y)
	return x
}

// Xor_Inplace computes the element-wise "exclusive or" operation between two slices, inplace.
func Xor_Inplace(x, y []bool) {
	checkEqualLength(x, y)
	checkOverlap(x, y)
	if functions.UseAVX2 {
		functions.Xor_AVX2(x, y)
	} else {
		functions.Xor_Go(x, y)
	}
}

// Xor_Into stores the element-wise "exclusive or" operation between two slices in the destination
// slice.
func Xor_Into(dst, x, y []bool) []bool {
	dst = checkCapacity(dst, x)
	checkOverlap(dst, x)
	copy(dst, x)
	Xor_Inplace(dst, y)
	return dst
}

// Select returns the slice elements for which the corresponding boolean values are true.
func Select(x []float64, y []bool) []float64 {
	dst := make([]float64, 0)
	return Select_Into(dst, x, y)
}

// Select_Into stores the slice elements for which the corresponding boolean values are true in
// the destination slice. This function grows the destination slice if the selection yields more
// values than it has capacity for.
func Select_Into(dst, x []float64, y []bool) []float64 {
	checkEqualLength(x, y)
	//checkOverlap(dst[:cap(dst)], x)
	return functions.Select_Go(dst, x, y)
}

// All returns whether all boolean values in the slice are true.
func All(x []bool) bool {
	if functions.UseAVX2 {
		return functions.All_AVX2(x) != 0
	} else {
		return functions.All_Go(x)
	}
}

// Any returns whether at least one boolean value in the slice is true.
func Any(x []bool) bool {
	if functions.UseAVX2 {
		return functions.Any_AVX2(x) != 0
	} else {
		return functions.Any_Go(x)
	}
}

// None returns whether none of the boolean values in the slice are true.
func None(x []bool) bool {
	if functions.UseAVX2 {
		return functions.None_AVX2(x) != 0
	} else {
		return functions.None_Go(x)
	}
}

// Count returns the number of boolean values that are true.
func Count(x []bool) int {
	if functions.UseAVX2 {
		return functions.Count_AVX2(x)
	} else {
		return functions.Count_Go(x)
	}
}

// Construction

// Zeros returns a new slice of length n filled with zeros.
func Zeros(n int) []float64 {
	if n < 0 {
		panic("n must be positive")
	}
	dst := make([]float64, n)
	return Repeat_Into(dst, 0, n)
}

// Zeros_Into sets the first n elements in the destination slice to zero.
func Zeros_Into(dst []float64, n int) []float64 {
	return Repeat_Into(dst, 0, n)
}

// Ones returns a new slice of length n filled with ones.
func Ones(n int) []float64 {
	if n < 0 {
		panic("n must be positive")
	}
	dst := make([]float64, n)
	return Repeat_Into(dst, 1, n)
}

// Ones_Into sets the first n elements in the destination slice to one.
func Ones_Into(dst []float64, n int) []float64 {
	return Repeat_Into(dst, 1, n)
}

// Repeat returns a new slice of length n filled with the given value.
func Repeat(a float64, n int) []float64 {
	if n < 0 {
		panic("n must be positive")
	}
	dst := make([]float64, n)
	return Repeat_Into(dst, a, n)
}

// Repeat_Into sets the first n elements in the destination slice to the given value.
func Repeat_Into(dst []float64, a float64, n int) []float64 {
	if n < 0 {
		panic("n must be positive")
	}
	if cap(dst) < n {
		panic("destination slice not large enough to hold result")
	}
	if functions.UseAVX2 {
		functions.Repeat_AVX2_F64(dst, a, n)
	} else {
		functions.Repeat_Go(dst, a, n)
	}
	return dst[:n]
}

// Range returns a new slice with values incrementing from a to b (excl.) in steps of 1.
func Range(a, b float64) []float64 {
	dst := make([]float64, int(math.Max(0, math.Ceil(b-a))))
	return Range_Into(dst, a, b)
}

// Range_Into writes values incrementing from a to b (excl.) in steps of 1 to the destination slice.
func Range_Into(dst []float64, a, b float64) []float64 {
	n := int(math.Max(0, math.Ceil(b-a)))
	if cap(dst) < n {
		panic("destination slice not large enough to hold result")
	}
	if functions.UseAVX2 {
		functions.Range_AVX2_F64(dst, a, n)
	} else {
		functions.Range_Go(dst, a, n)
	}
	return dst[:n]
}

// Gather returns a new slice containing just the elements at the given indices.
func Gather(x []float64, idx []int) []float64 {
	dst := make([]float64, len(idx))
	return Gather_Into(dst, x, idx)
}

// Gather_Into stores the slice elements at the given indices in the destination slice.
func Gather_Into(dst, x []float64, idx []int) []float64 {
	dst = checkCapacity(dst, idx)
	checkOverlap(dst, x)
	functions.Gather_Go(dst, x, idx)
	return dst
}

// Scatter returns a slice of size elements where position idx[i] is set to x[i], for all
// i < len(x) = len(idx). The other elements are set to zero.
func Scatter(x []float64, idx []int, size int) []float64 {
	dst := make([]float64, size)
	return Scatter_Into(dst, x, idx)
}

// Scatter_Into sets positions idx[i] to x[i] in the destination slice, for all
// i < len(x) = len(idx). The other elements are not modified.
func Scatter_Into(dst, x []float64, idx []int) []float64 {
	checkEqualLength(x, idx)
	checkOverlap(dst, x)
	functions.Scatter_Go(dst, x, idx)
	return dst
}

// FromBool creates a slice of floats from a slice of bools by converting all false values to 0
// and all true values to 1.
func FromBool(x []bool) []float64 {
	dst := make([]float64, len(x))
	return FromBool_Into(dst, x)
}

// FromBool_Into creates a slice of floats from a slice of bools by converting all false values
// to 0 and all true values to 1. The result is stored in the destination slice.
func FromBool_Into(dst []float64, x []bool) []float64 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.FromBool_AVX2_F64(dst, x)
	} else {
		functions.FromBool_Go(dst, x)
	}
	return dst
}

// FromInt64 creates a slice of floats from a slice of 64-bit ints. Standard conversion rules
// apply.
func FromInt64(x []int64) []float64 {
	dst := make([]float64, len(x))
	return FromInt64_Into(dst, x)
}

// FromInt64_Into creates a slice of floats from a slice of 64-bit ints. Standard conversion
// rules apply. The result is stored in the destination slice.
func FromInt64_Into(dst []float64, x []int64) []float64 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.FromInt64_AVX2_F64(dst, x)
	} else {
		functions.FromNumber_Go(dst, x)
	}
	return dst
}

// FromInt32 creates a slice of floats from a slice of 32-bit ints. Standard conversion rules
// apply.
func FromInt32(x []int32) []float64 {
	dst := make([]float64, len(x))
	return FromInt32_Into(dst, x)
}

// FromInt32_Into creates a slice of floats from a slice of 32-bit ints. Standard conversion
// rules apply. The result is stored in the destination slice.
func FromInt32_Into(dst []float64, x []int32) []float64 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.FromInt32_AVX2_F64(dst, x)
	} else {
		functions.FromNumber_Go(dst, x)
	}
	return dst
}

// FromFloat32 creates a slice of floats from a slice of 32-bit floats. Standard conversion
// rules apply.
func FromFloat32(x []float32) []float64 {
	dst := make([]float64, len(x))
	return FromFloat32_Into(dst, x)
}

// FromFloat32_Into creates a slice of floats from a slice of 32-bit floats. Standard conversion
// rules apply. The result is stored in the destination slice.
func FromFloat32_Into(dst []float64, x []float32) []float64 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.FromFloat32_AVX2_F64(dst, x)
	} else {
		functions.FromNumber_Go(dst, x)
	}
	return dst
}

// ToBool converts a slice of floats to a slice of bools by setting all zero values to true and
// all non-zero values to false.
func ToBool(x []float64) []bool {
	dst := make([]bool, len(x))
	return ToBool_Into(dst, x)
}

// ToBool_Into converts a slice of floats to a slice of bools by setting all zero values to true
// and all non-zero values to false. The result is stored in the destination slice.
func ToBool_Into(dst []bool, x []float64) []bool {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.ToBool_AVX2_F64(dst, x)
	} else {
		functions.ToBool_Go(dst, x)
	}
	return dst
}

// ToInt64 converts a slice of floats to a slice of 64-bit ints. Standard conversion rules apply.
func ToInt64(x []float64) []int64 {
	dst := make([]int64, len(x))
	return ToInt64_Into(dst, x)
}

// ToInt64_Into converts a slice of floats to a slice of 64-bit ints. Standard conversion rules
// apply. The result is stored in the destination slice.
func ToInt64_Into(dst []int64, x []float64) []int64 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.ToInt64_AVX2_F64(dst, x)
	} else {
		functions.ToNumber_Go(dst, x)
	}
	return dst
}

// ToInt32 converts a slice of floats to a slice of 32-bit ints. Standard conversion rules apply.
func ToInt32(x []float64) []int32 {
	dst := make([]int32, len(x))
	return ToInt32_Into(dst, x)
}

// ToInt32_Into converts a slice of floats to a slice of 32-bit ints. Standard conversion rules
// apply. The result is stored in the destination slice.
func ToInt32_Into(dst []int32, x []float64) []int32 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.ToInt32_AVX2_F64(dst, x)
	} else {
		functions.ToNumber_Go(dst, x)
	}
	return dst
}

// ToFloat32 converts a slice of floats to a slice of 32-bit floats. Standard conversion rules
// apply.
func ToFloat32(x []float64) []float32 {
	dst := make([]float32, len(x))
	return ToFloat32_Into(dst, x)
}

// ToFloat32_Into converts a slice of floats to a slice of 32-bit floats. Standard conversion
// rules apply. The result is stored in the destination slice.
func ToFloat32_Into(dst []float32, x []float64) []float32 {
	dst = checkCapacity(dst, x)
	if functions.UseAVX2 {
		functions.FromFloat64_AVX2_F32(dst, x)
	} else {
		functions.ToNumber_Go(dst, x)
	}
	return dst
}

// Misc

// SetAcceleration toggles simd acceleration. Not thread safe.
func SetAcceleration(enabled bool) {
	if enabled && !(cpu.X86.HasAVX2 && cpu.X86.HasFMA) {
		panic("acceleration not supported on this platform")
	}
	functions.UseAVX2 = enabled
}

// Validation

func slicesOverlap[T, F any](x []T, y []F) bool {
	if len(x) == 0 || len(y) == 0 {
		return false
	}
	xStart := uintptr(unsafe.Pointer(&x[0]))
	xEnd := uintptr(unsafe.Pointer(&x[len(x)-1]))
	yStart := uintptr(unsafe.Pointer(&y[0]))
	yEnd := uintptr(unsafe.Pointer(&y[len(y)-1]))
	return xStart <= yEnd && yStart <= xEnd
}

func checkCapacity[T, F any](dst []T, x []F) []T {
	if cap(dst) < len(x) {
		panic("destination slice not large enough to hold result")
	}
	return dst[:len(x)]
}

func checkEqualLength[T, F any](x []T, y []F) {
	if len(x) != len(y) {
		panic("slices must be of equal length")
	}
}

func checkNotEmpty[T any](x []T) {
	if len(x) == 0 {
		panic("slice must not be empty")
	}
}

func checkOverlap[T, F any](x []T, y []F) {
	if slicesOverlap(x, y) {
		panic("destination slice must not overlap input slice")
	}
}
