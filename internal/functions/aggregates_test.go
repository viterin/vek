package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"testing"
)

var sizes = []int{
	10, 100, 1_000, 10_000, 100_000,
}

func TestSumProd(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)

			r1 := Sum_Go(x)
			r2 := Sum_AVX2_F64(x)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)

			r1 := Prod_Go(x)
			r2 := Prod_AVX2_F32(x)
			require.InDelta(t, r1, r2, 0.001)
		}
	}
}

func TestQuantile(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			a := rand.Float64()
			x := Random[float64](size)

			r1 := Quantile_Go(x, a)
			r2 := Quantile_AVX2_F64(x, a)
			require.InDelta(t, r1, r2, 0.001)
		}
	}
}

func BenchmarkSumProd(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_sum_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Sum_Go(x)
			}
		})
		b.Run(fmt.Sprintf("go_sum_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Sum_Go(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_sum_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Sum_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_sum_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Sum_AVX2_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("go_cumsum_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CumSum_Go(x)
			}
		})
		b.Run(fmt.Sprintf("go_cumsum_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CumSum_Go(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_cumsum_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CumSum_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_cumsum_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CumSum_AVX2_F32(x32)
			}
		})
	}
}

func BenchmarkQuantile(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Quantile_Go(x, 0.421)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Quantile_Go(x32, 0.421)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Quantile_AVX2_F64(x, 0.421)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Quantile_AVX2_F32(x32, 0.421)
			}
		})
	}
}
