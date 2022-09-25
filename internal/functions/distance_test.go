package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"testing"
)

func TestCosineSimilarity(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			y := Random[float64](size)
			r1 := Dot_Go(x, y)
			r2 := Dot_AVX2_F64(x, y)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float64](size)
			y := Random[float64](size)
			r1 := CosineSimilarity_AVX2_F64(x, y)
			r2 := CosineSimilarity_Go_F64(x, y)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)
			y := Random[float32](size)
			r1 := CosineSimilarity_Go_F32(x, y)
			r2 := CosineSimilarity_AVX2_F32(x, y)
			require.InDelta(t, r1, r2, 0.001)
		}
	}
}

func BenchmarkCosineSimilarity(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)
		y := Random[float64](size)
		x32 := Random[float32](size)
		y32 := Random[float32](size)

		b.Run(fmt.Sprintf("dot_go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Dot_Go(x, y)
			}
		})
		b.Run(fmt.Sprintf("dot_go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Dot_Go(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("dot_avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Dot_AVX2_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("dot_avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Dot_AVX2_F32(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("cosim_go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CosineSimilarity_Go_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("cosim_go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CosineSimilarity_Go_F32(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("cosim_avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CosineSimilarity_AVX2_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("cosim_avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				CosineSimilarity_AVX2_F32(x32, y32)
			}
		})
	}
}
