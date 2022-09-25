package functions

//go:noescape
func Add_AVX2_F64(x []float64, y []float64)

//go:noescape
func Add_AVX2_F32(x []float32, y []float32)

//go:noescape
func AddNumber_AVX2_F64(x []float64, a float64)

//go:noescape
func AddNumber_AVX2_F32(x []float32, a float32)

//go:noescape
func Sub_AVX2_F64(x []float64, y []float64)

//go:noescape
func Sub_AVX2_F32(x []float32, y []float32)

//go:noescape
func SubNumber_AVX2_F64(x []float64, a float64)

//go:noescape
func SubNumber_AVX2_F32(x []float32, a float32)

//go:noescape
func Mul_AVX2_F64(x []float64, y []float64)

//go:noescape
func Mul_AVX2_F32(x []float32, y []float32)

//go:noescape
func MulNumber_AVX2_F64(x []float64, a float64)

//go:noescape
func MulNumber_AVX2_F32(x []float32, a float32)

//go:noescape
func Div_AVX2_F64(x []float64, y []float64)

//go:noescape
func Div_AVX2_F32(x []float32, y []float32)

//go:noescape
func DivNumber_AVX2_F64(x []float64, a float64)

//go:noescape
func DivNumber_AVX2_F32(x []float32, a float32)

//go:noescape
func Abs_AVX2_F64(x []float64)

//go:noescape
func Abs_AVX2_F32(x []float32)

//go:noescape
func Neg_AVX2_F64(x []float64)

//go:noescape
func Neg_AVX2_F32(x []float32)

//go:noescape
func Inv_AVX2_F64(x []float64)

//go:noescape
func Inv_AVX2_F32(x []float32)

//go:noescape
func Sum_AVX2_F64(x []float64) float64

//go:noescape
func Sum_AVX2_F32(x []float32) float32

//go:noescape
func CumSum_AVX2_F64(x []float64)

//go:noescape
func CumSum_AVX2_F32(x []float32)

//go:noescape
func Prod_AVX2_F64(x []float64) float64

//go:noescape
func Prod_AVX2_F32(x []float32) float32

//go:noescape
func CumProd_AVX2_F64(x []float64)

//go:noescape
func CumProd_AVX2_F32(x []float32)

//go:noescape
func Dot_AVX2_F64(x []float64, y []float64) float64

//go:noescape
func Dot_AVX2_F32(x []float32, y []float32) float32

//go:noescape
func Norm_AVX2_F64(x []float64) float64

//go:noescape
func Norm_AVX2_F32(x []float32) float32

//go:noescape
func Distance_AVX2_F64(x []float64, y []float64) float64

//go:noescape
func Distance_AVX2_F32(x []float32, y []float32) float32

//go:noescape
func ManhattanNorm_AVX2_F64(x []float64) float64

//go:noescape
func ManhattanNorm_AVX2_F32(x []float32) float32

//go:noescape
func ManhattanDistance_AVX2_F64(x []float64, y []float64) float64

//go:noescape
func ManhattanDistance_AVX2_F32(x []float32, y []float32) float32

//go:noescape
func CosineSimilarity_AVX2_F64(x []float64, y []float64) float64

//go:noescape
func CosineSimilarity_AVX2_F32(x []float32, y []float32) float32

//go:noescape
func Mat4Mul_AVX2_F64(x []float64, y []float64, z []float64)

//go:noescape
func Mat4Mul_AVX2_F32(x []float32, y []float32, z []float32)

//go:noescape
func MatMul_AVX2_F64(x []float64, y []float64, z []float64, a int, b int, c int)

//go:noescape
func MatMul_AVX2_F32(x []float32, y []float32, z []float32, a int, b int, c int)

//go:noescape
func MatMulVec_AVX2_F64(x []float64, y []float64, z []float64, a int, b int)

//go:noescape
func MatMulVec_AVX2_F32(x []float32, y []float32, z []float32, a int, b int)

//go:noescape
func MatMulTiled_AVX2_F64(x []float64, y []float64, z []float64, a int, b int, c int)

//go:noescape
func MatMulTiled_AVX2_F32(x []float32, y []float32, z []float32, a int, b int, c int)

//go:noescape
func Sqrt_AVX2_F64(x []float64) float64

//go:noescape
func Sqrt_AVX2_F32(x []float32) float32

//go:noescape
func Round_AVX2_F64(x []float64) float64

//go:noescape
func Round_AVX2_F32(x []float32) float32

//go:noescape
func Floor_AVX2_F64(x []float64) float64

//go:noescape
func Floor_AVX2_F32(x []float32) float32

//go:noescape
func Ceil_AVX2_F64(x []float64) float64

//go:noescape
func Ceil_AVX2_F32(x []float32) float32

//go:noescape
func Sin_AVX2_F32(x []float32)

//go:noescape
func Cos_AVX2_F32(x []float32)

//go:noescape
func SinCos_AVX2_F32(x []float32, y []float32, z []float32)

//go:noescape
func Exp_Len8x_AVX2_F32(x []float32)

//go:noescape
func Log_Len8x_AVX2_F32(x []float32)

//go:noescape
func Log2_Len8x_AVX2_F32(x []float32)

//go:noescape
func Log10_Len8x_AVX2_F32(x []float32)

//go:noescape
func Min_AVX2_F64(x []float64) float64

//go:noescape
func Min_AVX2_F32(x []float32) float32

//go:noescape
func Minimum_AVX2_F64(x []float64, y []float64)

//go:noescape
func Minimum_AVX2_F32(x []float32, y []float32)

//go:noescape
func MinimumNumber_AVX2_F64(x []float64, a float64)

//go:noescape
func MinimumNumber_AVX2_F32(x []float32, a float32)

//go:noescape
func Max_AVX2_F64(x []float64) float64

//go:noescape
func Max_AVX2_F32(x []float32) float32

//go:noescape
func Maximum_AVX2_F64(x []float64, y []float64)

//go:noescape
func Maximum_AVX2_F32(x []float32, y []float32)

//go:noescape
func MaximumNumber_AVX2_F64(x []float64, a float64)

//go:noescape
func MaximumNumber_AVX2_F32(x []float32, a float32)

//go:noescape
func Find_AVX2_F64(x []float64, a float64) int

//go:noescape
func Find_AVX2_F32(x []float32, a float32) int

//go:noescape
func Lt_AVX2_F64(x []bool, y []float64, z []float64)

//go:noescape
func Lt_AVX2_F32(x []bool, y []float32, z []float32)

//go:noescape
func Lte_AVX2_F64(x []bool, y []float64, z []float64)

//go:noescape
func Lte_AVX2_F32(x []bool, y []float32, z []float32)

//go:noescape
func Gt_AVX2_F64(x []bool, y []float64, z []float64)

//go:noescape
func Gt_AVX2_F32(x []bool, y []float32, z []float32)

//go:noescape
func Gte_AVX2_F64(x []bool, y []float64, z []float64)

//go:noescape
func Gte_AVX2_F32(x []bool, y []float32, z []float32)

//go:noescape
func Eq_AVX2_F64(x []bool, y []float64, z []float64)

//go:noescape
func Eq_AVX2_F32(x []bool, y []float32, z []float32)

//go:noescape
func Neq_AVX2_F64(x []bool, y []float64, z []float64)

//go:noescape
func Neq_AVX2_F32(x []bool, y []float32, z []float32)

//go:noescape
func LtNumber_AVX2_F64(x []bool, y []float64, a float64)

//go:noescape
func LtNumber_AVX2_F32(x []bool, y []float32, a float32)

//go:noescape
func LteNumber_AVX2_F64(x []bool, y []float64, a float64)

//go:noescape
func LteNumber_AVX2_F32(x []bool, y []float32, a float32)

//go:noescape
func GtNumber_AVX2_F64(x []bool, y []float64, a float64)

//go:noescape
func GtNumber_AVX2_F32(x []bool, y []float32, a float32)

//go:noescape
func GteNumber_AVX2_F64(x []bool, y []float64, a float64)

//go:noescape
func GteNumber_AVX2_F32(x []bool, y []float32, a float32)

//go:noescape
func EqNumber_AVX2_F64(x []bool, y []float64, a float64)

//go:noescape
func EqNumber_AVX2_F32(x []bool, y []float32, a float32)

//go:noescape
func NeqNumber_AVX2_F64(x []bool, y []float64, a float64)

//go:noescape
func NeqNumber_AVX2_F32(x []bool, y []float32, a float32)

//go:noescape
func Not_AVX2(x []bool)

//go:noescape
func And_AVX2(x []bool, y []bool)

//go:noescape
func Or_AVX2(x []bool, y []bool)

//go:noescape
func Xor_AVX2(x []bool, y []bool)

//go:noescape
func All_AVX2(x []bool) int

//go:noescape
func Any_AVX2(x []bool) int

//go:noescape
func None_AVX2(x []bool) int

//go:noescape
func Count_AVX2(x []bool) int

//go:noescape
func Repeat_AVX2_F64(x []float64, a float64, n int)

//go:noescape
func Repeat_AVX2_F32(x []float32, a float32, n int)

//go:noescape
func Range_AVX2_F64(x []float64, a float64, n int)

//go:noescape
func Range_AVX2_F32(x []float32, a float32, n int)

//go:noescape
//func Gather_AVX2_F64(x []float64, y []float64, z []int)

//go:noescape
//func Gather_AVX2_F32(x []float32, y []float32, z []int)

//go:noescape
//func Scatter_AVX2_F64(x []float64, y []float64, z []int)

//go:noescape
//func Scatter_AVX2_F32(x []float32, y []float32, z []int)

//go:noescape
func FromBool_AVX2_F64(x []float64, y []bool)

//go:noescape
func FromBool_AVX2_F32(x []float32, y []bool)

//go:noescape
func FromInt32_AVX2_F64(x []float64, y []int32)

//go:noescape
func FromInt32_AVX2_F32(x []float32, y []int32)

//go:noescape
func FromInt64_AVX2_F64(x []float64, y []int64)

//go:noescape
func FromInt64_AVX2_F32(x []float32, y []int64)

//go:noescape
func FromFloat32_AVX2_F64(x []float64, y []float32)

//go:noescape
func FromFloat64_AVX2_F32(x []float32, y []float64)

//go:noescape
func ToBool_AVX2_F64(x []bool, y []float64)

//go:noescape
func ToBool_AVX2_F32(x []bool, y []float32)

//go:noescape
func ToInt32_AVX2_F64(x []int32, y []float64)

//go:noescape
func ToInt32_AVX2_F32(x []int32, y []float32)

//go:noescape
func ToInt64_AVX2_F64(x []int64, y []float64)

//go:noescape
func ToInt64_AVX2_F32(x []int64, y []float32)
