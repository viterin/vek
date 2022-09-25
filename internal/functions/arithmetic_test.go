package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"golang.org/x/exp/slices"
	"testing"
)

func TestAdd(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			a := rand.NormFloat64() * 100
			y := Random[float64](size)
			r1 := make([]float64, size)
			r2 := make([]float64, size)

			Add_Go(r1, y)
			Add_AVX2_F64(r2, y)
			require.InDeltaSlice(t, r1, r2, 0.001)

			AddNumber_Go(r1, a)
			AddNumber_AVX2_F64(r2, a)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			a := float32(rand.NormFloat64() * 100)
			y := Random[float32](size)
			r1 := make([]float32, size)
			r2 := make([]float32, size)

			Add_Go(r1, y)
			Add_AVX2_F32(r2, y)
			require.InDeltaSlice(t, r1, r2, 0.001)

			AddNumber_Go(r1, a)
			AddNumber_AVX2_F32(r2, a)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestAbsNegInv(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := Random[float64](size)
			r2 := slices.Clone(r1)

			Neg_Go(r1)
			Neg_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)

			Inv_Go(r1)
			Inv_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)

			Abs_Go_F64(r1)
			Abs_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)

			Neg_Go(r1)
			Neg_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.01)

			r1 = Random[float32](size)
			r2 = slices.Clone(r1)

			Inv_Go(r1)
			Inv_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.01)

			r1 = Random[float32](size)
			r2 = slices.Clone(r1)

			Abs_Go_F32(r1)
			Abs_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.01)
		}
	}
}

func BenchmarkAdd(b *testing.B) {
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
				Add_Go(x, y)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Add_Go(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Add_AVX2_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Add_AVX2_F32(x32, y32)
			}
		})
	}
}

func BenchmarkMul(b *testing.B) {
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
				Mul_Go(x, y)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Mul_Go(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Mul_AVX2_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Mul_AVX2_F32(x32, y32)
			}
		})
	}
}

func BenchmarkAbs(b *testing.B) {
	for _, size := range sizes[3:] {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Abs_Go_F64(x)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Abs_Go_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Abs_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Abs_AVX2_F32(x32)
			}
		})
	}
}
