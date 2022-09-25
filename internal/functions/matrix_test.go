package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"testing"
)

func TestMat4Mul(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 100; i++ {
		{
			x := Random[float64](16)
			y := Random[float64](16)
			r1 := make([]float64, 16)
			r2 := make([]float64, 16)

			Mat4Mul_Go(r1, x, y)
			Mat4Mul_AVX2_F64(r2, x, y)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestMatMul(t *testing.T) {
	rand.Seed(2)
	for _, m := range []int{1, 10, 100} {
		for _, n := range []int{1, 10, 100} {
			for _, p := range []int{1, 10, 100} {
				for i := 0; i < 10; i++ {
					{
						x := Random[float64](m * n)
						y := Random[float64](n * p)
						r1 := make([]float64, m*p)
						r2 := make([]float64, m*p)

						MatMul_Go(r1, x, y, m, n, p)
						MatMul_AVX2_F64(r2, x, y, m, n, p)
						require.InDeltaSlice(t, r1, r2, 0.001)

						r1 = make([]float64, m*p)
						r2 = make([]float64, m*p)

						MatMul_Go(r1, x, y, m, n, p)
						MatMul_AVX2_F64(r2, x, y, m, n, p)
						require.InDeltaSlice(t, r1, r2, 0.001)

						r1 = make([]float64, m*p)
						r2 = make([]float64, m*p)

						MatMul_Parallel_Go(r1, x, y, m, n, p)
						MatMul_Parallel_AVX2_F64(r2, x, y, m, n, p)
						require.InDeltaSlice(t, r1, r2, 0.001)
					}
				}
			}
		}
	}
}

func BenchmarkMat4Mul(b *testing.B) {
	x := Random[float64](16)
	y := Random[float64](16)
	x32 := Random[float32](16)
	y32 := Random[float32](16)

	dst := make([]float64, 16)
	dst32 := make([]float32, 16)

	b.Run(fmt.Sprintf("go_f64"), func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			Mat4Mul_Go(dst, x, y)
		}
	})
	b.Run(fmt.Sprintf("go_f32"), func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			Mat4Mul_Go(dst32, x32, y32)
		}
	})
	b.Run(fmt.Sprintf("avx2_f64"), func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			Mat4Mul_AVX2_F64(dst, x, y)
		}
	})
	b.Run(fmt.Sprintf("avx2_f32"), func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			Mat4Mul_AVX2_F32(dst32, x32, y32)
		}
	})
}

func BenchmarkMatMul(b *testing.B) {
	for _, m := range []int{100, 1000} {
		for _, n := range []int{100, 1000} {
			for _, p := range []int{100, 1000} {
				x := Random[float64](m * n)
				y := Random[float64](n * p)
				x32 := Random[float32](m * n)
				y32 := Random[float32](n * p)

				b.Run(fmt.Sprintf("go_f64_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst := make([]float64, m*p)
						b.StartTimer()
						MatMul_Go(dst, x, y, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("go_f32_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst32 := make([]float32, m*p)
						b.StartTimer()
						MatMul_Go(dst32, x32, y32, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("go_parallel_f64_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst := make([]float64, m*p)
						b.StartTimer()
						MatMul_Parallel_Go(dst, x, y, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("go_parallel_f32_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst32 := make([]float32, m*p)
						b.StartTimer()
						MatMul_Parallel_Go(dst32, x32, y32, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("avx2_f64_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst := make([]float64, m*p)
						b.StartTimer()
						MatMul_AVX2_F64(dst, x, y, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("avx2_f32_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst32 := make([]float32, m*p)
						b.StartTimer()
						MatMul_AVX2_F32(dst32, x32, y32, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("avx2_parallel_f64_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst := make([]float64, m*p)
						b.StartTimer()
						MatMul_Parallel_AVX2_F64(dst, x, y, m, n, p)
					}
				})
				b.Run(fmt.Sprintf("avx2_parallel_f32_%d_%d_%d", m, n, p), func(b *testing.B) {
					for i := 0; i < b.N; i++ {
						b.StopTimer()
						dst := make([]float32, m*p)
						b.StartTimer()
						MatMul_Parallel_AVX2_F32(dst, x32, y32, m, n, p)
					}
				})
			}
		}
	}
}
