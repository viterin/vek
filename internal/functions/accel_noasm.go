//go:build !amd64

package functions

var UseAVX2 bool = false

// Arithmetic

func Add_AVX2_F64(x, y []float64) {
	panic("not implemented")
}
func AddNumber_AVX2_F64(x []float64, a float64) {
	panic("not implemented")
}
func Sub_AVX2_F64(x, y []float64) []float64 {
	panic("not implemented")
}
func SubNumber_AVX2_F64(x []float64, a float64) {
	panic("not implemented")
}
func Mul_AVX2_F64(x, y []float64) {
	panic("not implemented")
}
func MulNumber_AVX2_F64(x []float64, a float64) {
	panic("not implemented")
}
func Div_AVX2_F64(x, y []float64) {
	panic("not implemented")
}
func DivNumber_AVX2_F64(x []float64, a float64) {
	panic("not implemented")
}

func Abs_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Neg_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Inv_AVX2_F64(x []float64) {
	panic("not implemented")
}

// Aggregates

func Sum_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func CumSum_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Prod_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func CumProd_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Mean_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func Median_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func Quantile_AVX2_F64(x []float64, q float64) float64 {
	panic("not implemented")
}

// Distance

func Dot_AVX2_F64(x, y []float64) float64 {
	panic("not implemented")
}
func Norm_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func Distance_AVX2_F64(x, y []float64) float64 {
	panic("not implemented")
}
func ManhattanNorm_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func ManhattanDistance_AVX2_F64(x, y []float64) float64 {
	panic("not implemented")
}
func CosineSimilarity_AVX2_F64(x, y []float64) float64 {
	panic("not implemented")
}

// Matrices

func MatMul_Parallel_AVX2_F64(x, y, z []float64, m, n, p int) {
	panic("not implemented")
}
func MatMul_AVX2_F64(x []float64, y []float64, z []float64, a int, b int, c int) {
	panic("not implemented")
}
func MatMulVec_AVX2_F64(x []float64, y []float64, z []float64, a int, b int) {
	panic("not implemented")
}
func MatMulTiled_AVX2_F64(x []float64, y []float64, z []float64, a int, b int, c int) {
	panic("not implemented")
}
func Mat4Mul_AVX2_F64(x, y, z []float64) {
	panic("not implemented")
}

// Special

func Sqrt_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Round_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Floor_AVX2_F64(x []float64) {
	panic("not implemented")
}
func Ceil_AVX2_F64(x []float64) {
	panic("not implemented")
}

// Comparison

func Min_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func ArgMin_AVX2_F64(x []float64) int {
	panic("not implemented")
}
func Minimum_AVX2_F64(x, y []float64) {
	panic("not implemented")
}
func MinimumNumber_AVX2_F64(x []float64, a float64) {
	panic("not implemented")
}
func Max_AVX2_F64(x []float64) float64 {
	panic("not implemented")
}
func ArgMax_AVX2_F64(x []float64) int {
	panic("not implemented")
}
func Maximum_AVX2_F64(x, y []float64) {
	panic("not implemented")
}
func MaximumNumber_AVX2_F64(x []float64, a float64) {
	panic("not implemented")
}
func Find_AVX2_F64(x []float64, a float64) int {
	panic("not implemented")
}

func Lt_AVX2_F64(dst []bool, x, y []float64) {
	panic("not implemented")
}
func LtNumber_AVX2_F64(dst []bool, x []float64, a float64) {
	panic("not implemented")
}
func Lte_AVX2_F64(dst []bool, x, y []float64) {
	panic("not implemented")
}
func LteNumber_AVX2_F64(dst []bool, x []float64, a float64) {
	panic("not implemented")
}
func Gt_AVX2_F64(dst []bool, x, y []float64) {
	panic("not implemented")
}
func GtNumber_AVX2_F64(dst []bool, x []float64, a float64) {
	panic("not implemented")
}
func Gte_AVX2_F64(dst []bool, x, y []float64) {
	panic("not implemented")
}
func GteNumber_AVX2_F64(dst []bool, x []float64, a float64) {
	panic("not implemented")
}
func Eq_AVX2_F64(dst []bool, x, y []float64) {
	panic("not implemented")
}
func EqNumber_AVX2_F64(dst []bool, x []float64, a float64) {
	panic("not implemented")
}
func Neq_AVX2_F64(dst []bool, x, y []float64) {
	panic("not implemented")
}
func NeqNumber_AVX2_F64(dst []bool, x []float64, a float64) {
	panic("not implemented")
}

// Boolean

func Not_AVX2(x []bool) {
	panic("not implemented")
}
func And_AVX2(x, y []bool) {
	panic("not implemented")
}
func Or_AVX2(x, y []bool) {
	panic("not implemented")
}
func Xor_AVX2(x, y []bool) {
	panic("not implemented")
}
func Select_AVX2_F64(x, y []float64, z []bool) {
	panic("not implemented")
}

func All_AVX2(x []bool) int {
	panic("not implemented")
}
func Any_AVX2(x []bool) int {
	panic("not implemented")
}
func None_AVX2(x []bool) int {
	panic("not implemented")
}
func Count_AVX2(x []bool) int {
	panic("not implemented")
}

// Construction

func Zeros_AVX2_F64(dst []float64, n int) {
	panic("not implemented")
}
func Ones_AVX2_F64(dst []float64, n int) {
	panic("not implemented")
}
func Repeat_AVX2_F64(dst []float64, a float64, n int) {
	panic("not implemented")
}
func Range_AVX2_F64(dst []float64, a float64, n int) {
	panic("not implemented")
}

func Gather_AVX2_F64(x, y []float64, idx []int) {
	panic("not implemented")
}
func Scatter_AVX2_F64(x []float64, idx []int, size int) {
	panic("not implemented")
}

func FromFloat64_AVX2_F32(x []float32, y []float64) {
	panic("not implemented")
}
func FromFloat32_AVX2_F64(x []float64, y []float32) {
	panic("not implemented")
}
func FromInt64_AVX2_F64(x []float64, y []int64) {
	panic("not implemented")
}
func FromInt32_AVX2_F64(x []float64, y []int32) {
	panic("not implemented")
}
func FromBool_AVX2_F64(x []float64, y []bool) {
	panic("not implemented")
}

func ToInt64_AVX2_F64(x []int64, y []float64) {
	panic("not implemented")
}
func ToInt32_AVX2_F64(x []int32, y []float64) {
	panic("not implemented")
}
func ToBool_AVX2_F64(x []bool, y []float64) {
	panic("not implemented")
}

// float32

func Add_AVX2_F32(x []float32, y []float32) {
	panic("not implemented")
}

func AddNumber_AVX2_F32(x []float32, a float32) {
	panic("not implemented")
}

func Sub_AVX2_F32(x []float32, y []float32) {
	panic("not implemented")
}

func SubNumber_AVX2_F32(x []float32, a float32) {
	panic("not implemented")
}

func Mul_AVX2_F32(x []float32, y []float32) {
	panic("not implemented")
}

func MulNumber_AVX2_F32(x []float32, a float32) {
	panic("not implemented")
}

func Div_AVX2_F32(x []float32, y []float32) {
	panic("not implemented")
}

func DivNumber_AVX2_F32(x []float32, a float32) {
	panic("not implemented")
}

func Abs_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Neg_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Inv_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Sum_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func CumSum_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Prod_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func CumProd_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Mean_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Median_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Quantile_AVX2_F32(x []float32, q float32) float32 {
	panic("not implemented")
}

func Dot_AVX2_F32(x []float32, y []float32) float32 {
	panic("not implemented")
}

func Norm_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Distance_AVX2_F32(x []float32, y []float32) float32 {
	panic("not implemented")
}

func ManhattanNorm_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func ManhattanDistance_AVX2_F32(x []float32, y []float32) float32 {
	panic("not implemented")
}

func CosineSimilarity_AVX2_F32(x []float32, y []float32) float32 {
	panic("not implemented")
}

func MatMul_Parallel_AVX2_F32(x, y, z []float32, m, n, p int) {
	panic("not implemented")
}

func Mat4Mul_AVX2_F32(x []float32, y []float32, z []float32) {
	panic("not implemented")
}

func MatMul_AVX2_F32(x []float32, y []float32, z []float32, a int, b int, c int) {
	panic("not implemented")
}

func MatMulVec_AVX2_F32(x []float32, y []float32, z []float32, a int, b int) {
	panic("not implemented")
}

func MatMulTiled_AVX2_F32(x []float32, y []float32, z []float32, a int, b int, c int) {
	panic("not implemented")
}

func Sqrt_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Round_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Floor_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Ceil_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func Sin_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Cos_AVX2_F32(x []float32) {
	panic("not implemented")
}

func SinCos_AVX2_F32(x []float32, y []float32, z []float32) {
	panic("not implemented")
}

func Exp_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Log_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Log2_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Log10_AVX2_F32(x []float32) {
	panic("not implemented")
}

func Min_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func ArgMin_AVX2_F32(x []float32) int {
	panic("not implemented")
}

func Minimum_AVX2_F32(x []float32, y []float32) {
	panic("not implemented")
}

func MinimumNumber_AVX2_F32(x []float32, a float32) {
	panic("not implemented")
}

func Max_AVX2_F32(x []float32) float32 {
	panic("not implemented")
}

func ArgMax_AVX2_F32(x []float32) int {
	panic("not implemented")
}

func Maximum_AVX2_F32(x []float32, y []float32) {
	panic("not implemented")
}

func MaximumNumber_AVX2_F32(x []float32, a float32) {
	panic("not implemented")
}

func Find_AVX2_F32(x []float32, a float32) int {
	panic("not implemented")
}

func Lt_AVX2_F32(x []bool, y []float32, z []float32) {
	panic("not implemented")
}

func Lte_AVX2_F32(x []bool, y []float32, z []float32) {
	panic("not implemented")
}

func Gt_AVX2_F32(x []bool, y []float32, z []float32) {
	panic("not implemented")
}

func Gte_AVX2_F32(x []bool, y []float32, z []float32) {
	panic("not implemented")
}

func Eq_AVX2_F32(x []bool, y []float32, z []float32) {
	panic("not implemented")
}

func Neq_AVX2_F32(x []bool, y []float32, z []float32) {
	panic("not implemented")
}

func LtNumber_AVX2_F32(x []bool, y []float32, a float32) {
	panic("not implemented")
}

func LteNumber_AVX2_F32(x []bool, y []float32, a float32) {
	panic("not implemented")
}

func GtNumber_AVX2_F32(x []bool, y []float32, a float32) {
	panic("not implemented")
}

func GteNumber_AVX2_F32(x []bool, y []float32, a float32) {
	panic("not implemented")
}

func EqNumber_AVX2_F32(x []bool, y []float32, a float32) {
	panic("not implemented")
}

func NeqNumber_AVX2_F32(x []bool, y []float32, a float32) {
	panic("not implemented")
}

func Repeat_AVX2_F32(x []float32, a float32, n int) {
	panic("not implemented")
}

func Range_AVX2_F32(x []float32, a float32, n int) {
	panic("not implemented")
}

func Gather_AVX2_F32(x []float32, y []float32, z []int) {
	panic("not implemented")
}

func Scatter_AVX2_F32(x []float32, y []float32, z []int) {
	panic("not implemented")
}

func FromBool_AVX2_F32(x []float32, y []bool) {
	panic("not implemented")
}

func FromInt32_AVX2_F32(x []float32, y []int32) {
	panic("not implemented")
}

func FromInt64_AVX2_F32(x []float32, y []int64) {
	panic("not implemented")
}

func ToBool_AVX2_F32(x []bool, y []float32) {
	panic("not implemented")
}

func ToInt32_AVX2_F32(x []int32, y []float32) {
	panic("not implemented")
}

func ToInt64_AVX2_F32(x []int64, y []float32) {
	panic("not implemented")
}

// extras
func Pow_AVX2_F32(x, y []float32) {
	panic("not implemented")
}

func Pow_AVX2_F64(x, y []float64) {
	panic("not implemented")
}
