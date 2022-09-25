package functions

import (
	"bytes"
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"math"
	"testing"
)

func TestRepeat(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			a := rand.NormFloat64()
			r1 := make([]float64, size)
			r2 := make([]float64, size)
			Repeat_AVX2_F64(r1, a, size)
			Repeat_Go(r2, a, size)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			a := float32(rand.NormFloat64())
			r1 := make([]float32, size)
			r2 := make([]float32, size)
			Repeat_AVX2_F32(r1, a, size)
			Repeat_Go(r2, a, size)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestRange(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			a := math.Round(rand.NormFloat64() * 100)
			r1 := make([]float64, size)
			r2 := make([]float64, size)
			Range_AVX2_F64(r1, a, size)
			Range_Go(r2, a, size)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			a := float32(math.Round(rand.NormFloat64() * 100))
			r1 := make([]float32, size)
			r2 := make([]float32, size)
			Range_AVX2_F32(r1, a, size)
			Range_Go(r2, a, size)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestFrom(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := RandomBool(size, 0.5)
			r1 := make([]float64, size)
			r2 := make([]float64, size)
			FromBool_AVX2_F64(r1, x)
			FromBool_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := RandomBool(size, 0.5)
			r1 := make([]float32, size)
			r2 := make([]float32, size)
			FromBool_AVX2_F32(r1, x)
			FromBool_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[int64](size)
			r1 := make([]float64, size)
			r2 := make([]float64, size)
			FromInt64_AVX2_F64(r1, x)
			FromNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[int64](size)
			r1 := make([]float32, size)
			r2 := make([]float32, size)
			FromInt64_AVX2_F32(r1, x)
			FromNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[int32](size)
			r1 := make([]float64, size)
			r2 := make([]float64, size)
			FromInt32_AVX2_F64(r1, x)
			FromNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[int32](size)
			r1 := make([]float32, size)
			r2 := make([]float32, size)
			FromInt32_AVX2_F32(r1, x)
			FromNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func TestTo(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			r1 := make([]bool, size)
			r2 := make([]bool, size)
			ToBool_AVX2_F64(r1, x)
			ToBool_Go(r2, x)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float32](size)
			r1 := make([]bool, size)
			r2 := make([]bool, size)
			ToBool_AVX2_F32(r1, x)
			ToBool_Go(r2, x)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float64](size)
			r1 := make([]int64, size)
			r2 := make([]int64, size)
			ToInt64_AVX2_F64(r1, x)
			ToNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)
			r1 := make([]int64, size)
			r2 := make([]int64, size)
			ToInt64_AVX2_F32(r1, x)
			ToNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[float64](size)
			r1 := make([]int32, size)
			r2 := make([]int32, size)
			ToInt32_AVX2_F64(r1, x)
			ToNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)
			r1 := make([]int32, size)
			r2 := make([]int32, size)
			ToInt32_AVX2_F32(r1, x)
			ToNumber_Go(r2, x)
			require.InDeltaSlice(t, r1, r2, 0.001)
		}
	}
}

func BenchmarkRepeat(b *testing.B) {
	for _, size := range sizes {
		x := make([]float64, size)
		a := rand.NormFloat64()
		x32 := make([]float32, size)
		a32 := float32(rand.NormFloat64())

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Repeat_Go(x, a, size)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Repeat_Go(x32, a32, size)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Repeat_AVX2_F64(x, a, size)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Repeat_AVX2_F32(x32, a32, size)
			}
		})
	}
}

func BenchmarkRange(b *testing.B) {
	for _, size := range sizes {
		x := make([]float64, size)
		a := rand.Float64() * 1e6
		x32 := make([]float32, size)
		a32 := rand.Float32() * 1e6

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Range_Go(x, a, size)
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Range_Go(x32, a32, size)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Range_AVX2_F64(x, a, size)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Range_AVX2_F32(x32, a32, size)
			}
		})
	}
}

func BenchmarkFrom(b *testing.B) {
	for _, size := range sizes {
		x := make([]float64, size)
		x32 := make([]float32, size)
		y := Random[int64](size)
		y32 := Random[int32](size)
		_ = y

		b.Run(fmt.Sprintf("go_f64_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				FromNumber_Go(x, y32)
			}
		})
		b.Run(fmt.Sprintf("go_f32_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				FromNumber_Go(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				FromInt32_AVX2_F64(x, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				FromInt32_AVX2_F32(x32, y32)
			}
		})
	}
}

func BenchmarkTo(b *testing.B) {
	for _, size := range sizes {
		x := Random[int64](size)
		x32 := Random[int32](size)
		y := make([]float64, size)
		y32 := make([]float32, size)
		_ = x

		b.Run(fmt.Sprintf("go_f64_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ToNumber_Go(x32, y)
			}
		})
		b.Run(fmt.Sprintf("go_f32_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ToNumber_Go(x32, y32)
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ToInt32_AVX2_F64(x32, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_int32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				ToInt32_AVX2_F32(x32, y32)
			}
		})
	}
}

var zeros [512]float64

func BenchmarkZeros(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Zeros_Go(x, size)
			}
		})
		b.Run(fmt.Sprintf("go_f64_repeat_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				bytes.Repeat([]byte{0}, size)
			}
		})
		b.Run(fmt.Sprintf("go_f64_copy_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				j := 0
				for ; j < size&int(-512); j += 512 {
					copy(x[j:j+512], zeros[:])
				}
				copy(x[j:], zeros[:len(x)-j])
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Repeat_AVX2_F64(x, 0, size)
			}
		})
	}
}
