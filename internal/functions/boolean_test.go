package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"golang.org/x/exp/slices"
	"testing"
)

func TestLogic(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := RandomBool(size, 0.5)
			r2 := slices.Clone(r1)

			Not_Go(r1)
			Not_AVX2(r2)
			require.Equal(t, r1, r2)
		}
		{
			y := RandomBool(size, 0.5)
			r1 := RandomBool(size, 0.5)
			r2 := slices.Clone(r1)

			And_Go(r1, y)
			And_AVX2(r2, y)
			require.Equal(t, r1, r2)
		}
		{
			y := RandomBool(size, 0.5)
			r1 := RandomBool(size, 0.5)
			r2 := slices.Clone(r1)

			Or_Go(r1, y)
			Or_AVX2(r2, y)
			require.Equal(t, r1, r2)
		}
		{
			y := RandomBool(size, 0.5)
			r1 := RandomBool(size, 0.5)
			r2 := slices.Clone(r1)

			Xor_Go(r1, y)
			Xor_AVX2(r2, y)
			require.Equal(t, r1, r2)
		}
	}
}

func TestAllAnyNone(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := RandomBool(size, 0)
			require.Equal(t, All_Go(x), All_AVX2(x) != 0)

			x = RandomBool(size, 0.5)
			require.Equal(t, All_Go(x), All_AVX2(x) != 0)

			x = RandomBool(size, 1)
			require.Equal(t, All_Go(x), All_AVX2(x) != 0)
		}
		{
			x := RandomBool(size, 0)
			require.Equal(t, Any_Go(x), Any_AVX2(x) != 0)

			x = RandomBool(size, 0.5)
			require.Equal(t, Any_Go(x), Any_AVX2(x) != 0)

			x = RandomBool(size, 1)
			require.Equal(t, Any_Go(x), Any_AVX2(x) != 0)
		}
		{
			x := RandomBool(size, 0)
			require.Equal(t, None_Go(x), None_AVX2(x) != 0)

			x = RandomBool(size, 0.5)
			require.Equal(t, None_Go(x), None_AVX2(x) != 0)

			x = RandomBool(size, 1)
			require.Equal(t, None_Go(x), None_AVX2(x) != 0)
		}
	}
}

func TestCount(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			r1 := RandomBool(size, 0.5)
			r2 := slices.Clone(r1)

			Count_Go(r1)
			Count_AVX2(r2)
			require.Equal(t, r1, r2)
		}
	}
}

func BenchmarkLogic(b *testing.B) {
	for _, size := range sizes[3:] {
		x := RandomBool(size, 0.5)
		y := RandomBool(size, 0.5)

		b.Run(fmt.Sprintf("go_not_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Not_Go(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_not_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				Not_AVX2(x)
			}
		})
		b.Run(fmt.Sprintf("go_and_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				And_Go(x, y)
			}
		})
		b.Run(fmt.Sprintf("avx2_and_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				b.StopTimer()
				x := slices.Clone(x)
				b.StartTimer()
				And_AVX2(x, y)
			}
		})
	}
}

func BenchmarkAllAnyNone(b *testing.B) {
	for _, size := range sizes {
		x := RandomBool(size, 1)
		y := RandomBool(size, 0)
		x[size/2] = false
		y[size/2] = true

		b.Run(fmt.Sprintf("go_all_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				All_Go(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_all_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				All_AVX2(x)
			}
		})
		b.Run(fmt.Sprintf("go_any_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Any_Go(y)
			}
		})
		b.Run(fmt.Sprintf("avx2_any_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Any_AVX2(y)
			}
		})
		b.Run(fmt.Sprintf("go_none_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				None_Go(y)
			}
		})
		b.Run(fmt.Sprintf("avx2_none_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				None_AVX2(y)
			}
		})
	}
}

func BenchmarkCount(b *testing.B) {
	for _, size := range sizes {
		x := RandomBool(size, 0.5)

		b.Run(fmt.Sprintf("go_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Count_Go(x)
			}
		})
		b.Run(fmt.Sprintf("avx2_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Count_AVX2(x)
			}
		})
	}
}
