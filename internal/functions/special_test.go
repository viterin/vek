package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"golang.org/x/exp/slices"
	"testing"
)

func TestSqrt(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := Random[float64](size)
			r2 := slices.Clone(r1)
			Sqrt_Go_F64(r1)
			Sqrt_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Sqrt_Go_F32(r1)
			Sqrt_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestRound(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := Random[float64](size)
			r2 := slices.Clone(r1)
			Round_Go_F64(r1)
			Round_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Round_Go_F32(r1)
			Round_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float64](size)
			r2 := slices.Clone(r1)
			Floor_Go_F64(r1)
			Floor_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Floor_Go_F32(r1)
			Floor_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float64](size)
			r2 := slices.Clone(r1)
			Ceil_Go_F64(r1)
			Ceil_AVX2_F64(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Ceil_Go_F32(r1)
			Ceil_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestPow(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			y := RandomRange[float64](-10, 10, size)
			x1 := slices.Clone(x)
			Pow_Go_F64(x, y)
			Pow_AVX2_F64(x1, y)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float32](size)
			y := RandomRange[float32](-10, 10, size)
			x1 := slices.Clone(x)
			Pow_Go_F32(x, y)
			Pow_AVX2_F32(x1, y)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
	}
}

func TestSinCos(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Sin_Go_F32(r1)
			Sin_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Cos_Go_F32(r1)
			Cos_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)
			r1Sin := make([]float32, size)
			r1Cos := make([]float32, size)
			r2Sin := make([]float32, size)
			r2Cos := make([]float32, size)
			SinCos_Go_F32(r1Sin, r1Cos, x)
			SinCos_AVX2_F32(r2Sin, r2Cos, x)
			require.InDeltaSlice(t, r1Sin, r2Sin, 0.001)
			require.InDeltaSlice(t, r1Cos, r2Cos, 0.001)
		}
	}
}

func TestExpLog(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := make([]float32, size)
			for j := 0; j < size; j++ {
				r1[j] = float32(rand.Float64()*20 - 10)
			}
			r2 := slices.Clone(r1)
			Exp_Go_F32(r1)
			Exp_AVX2_F32(r2)
			require.InEpsilonSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Log_Go_F32(r1)
			Log_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Log2_Go_F32(r1)
			Log2_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			r1 := Random[float32](size)
			r2 := slices.Clone(r1)
			Log10_Go_F32(r1)
			Log10_AVX2_F32(r2)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func BenchmarkPow(b *testing.B) {
	for _, size := range sizes[3:] {
		x := Random[float64](size)
		y := RandomRange[float64](-10, 10, size)
		x32 := Random[float32](size)
		y32 := RandomRange[float32](-10, 10, size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Pow_Go_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Pow_Go_F32(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Pow_AVX2_F64(x, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Pow_AVX2_F32(x32, y32)
			}
		})
	}
}

func BenchmarkSqrt(b *testing.B) {
	for _, size := range sizes[3:] {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Sqrt_Go_F64(x)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Sqrt_Go_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Sqrt_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Sqrt_AVX2_F32(x32)
			}
		})
	}
}

func BenchmarkRound(b *testing.B) {
	for _, size := range sizes[3:] {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Round_Go_F64(x)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Round_Go_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Round_AVX2_F64(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Round_AVX2_F32(x32)
			}
		})
	}
}

func BenchmarkSinCos(b *testing.B) {
	for _, size := range sizes[3:] {
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Sin_Go_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Sin_AVX2_F32(x32)
			}
		})
	}
}

func BenchmarkExpLog(b *testing.B) {
	for _, size := range sizes[3:] {
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_exp_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Exp_Go_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_exp_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Exp_AVX2_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("go_log_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Log_Go_F32(x32)
			}
		})
		b.Run(fmt.Sprintf("avx2_log_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x32 := slices.Clone(x32)
				b.StartTimer()
				Log_AVX2_F32(x32)
			}
		})
	}
}
