package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"golang.org/x/exp/slices"
	"testing"
)

func TestCompare(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			y := Random[float64](size)
			x[size/2] = y[size/2]
			r1 := make([]bool, size)
			r2 := make([]bool, size)

			Lt_Go(r1, x, y)
			Lt_AVX2_F64(r2, x, y)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float32](size)
			y := Random[float32](size)
			x[size/2] = y[size/2]
			r1 := make([]bool, size)
			r2 := make([]bool, size)

			Lte_Go(r1, x, y)
			Lte_AVX2_F32(r2, x, y)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float64](size)
			y := Random[float64](size)
			x[size/2] = y[size/2]
			r1 := make([]bool, size)
			r2 := make([]bool, size)

			Gte_Go(r1, x, y)
			Gte_AVX2_F64(r2, x, y)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float64](size)
			y := Random[float64](size)
			x[size/2] = y[size/2]
			r1 := make([]bool, size)
			r2 := make([]bool, size)

			Eq_Go(r1, x, y)
			Eq_AVX2_F64(r2, x, y)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float64](size)
			y := Random[float64](size)
			x[size/2] = y[size/2]
			r1 := make([]bool, size)
			r2 := make([]bool, size)

			Neq_Go(r1, x, y)
			Neq_AVX2_F64(r2, x, y)
			require.Equal(t, r1, r2)
		}
	}
}

func BenchmarkLt(b *testing.B) {
	for _, size := range sizes[3:] {
		x := Random[float64](size)
		y := Random[float64](size)
		x32 := Random[float32](size)
		y32 := Random[float32](size)
		dst := make([]bool, size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				dst := slices.Clone(dst)
				b.StartTimer()
				Lt_Go(dst, x, y)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				dst := slices.Clone(dst)
				b.StartTimer()
				Lt_Go(dst, x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				dst := slices.Clone(dst)
				b.StartTimer()
				Lt_AVX2_F64(dst, x, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				dst := slices.Clone(dst)
				b.StartTimer()
				Lt_AVX2_F32(dst, x32, y32)
			}
		})
	}
}
