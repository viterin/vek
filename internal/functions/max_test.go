package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"golang.org/x/exp/slices"
	"testing"
)

func TestMax(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			r1 := Max_AVX2_F64(x)
			r2 := Max_Go(x)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)
			r1 := Max_AVX2_F32(x)
			r2 := Max_Go(x)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float64](size)
			r1 := ArgMax_AVX2_F64(x)
			r2 := ArgMax_Go(x)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float32](size)
			r1 := ArgMax_AVX2_F32(x)
			r2 := ArgMax_Go(x)
			require.Equal(t, r1, r2)
		}
	}
}

func TestMaximum(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			y := Random[float64](size)
			x1 := slices.Clone(x)
			Maximum_AVX2_F64(x, y)
			Maximum_Go(x1, y)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float32](size)
			y := Random[float32](size)
			x1 := slices.Clone(x)
			Maximum_AVX2_F32(x, y)
			Maximum_Go(x1, y)
			require.InDeltaSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float64](size)
			a := rand.Float64()
			x1 := slices.Clone(x)
			MaximumNumber_AVX2_F64(x, a)
			MaximumNumber_Go(x1, a)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float32](size)
			a := rand.Float32()
			x1 := slices.Clone(x)
			MaximumNumber_AVX2_F32(x, a)
			MaximumNumber_Go(x1, a)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
	}
}

func BenchmarkMax(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Max_Go(x)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Max_Go(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Max_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Max_AVX2_F32(x32)
			}
		})
	}
}

func BenchmarkMaximum(b *testing.B) {
	for _, size := range sizes[3:] {
		x := Random[float64](size)
		y := Random[float64](size)
		x32 := Random[float32](size)
		y32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Maximum_Go(x, y)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Maximum_Go(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Maximum_AVX2_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Maximum_AVX2_F32(x32, y32)
			}
		})
	}
}

func BenchmarkArgMax(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ArgMax_Go(x)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ArgMax_Go(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ArgMax_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ArgMax_AVX2_F32(x32)
			}
		})
	}
}
