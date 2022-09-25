package functions

import (
	"fmt"
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"testing"
)

func TestFind(t *testing.T) {
	rand.Seed(2)
	for i := 1; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			a := x[rand.Intn(len(x))]
			r1 := Find_Go(x, a)
			r2 := Find_AVX2_F64(x, a)
			require.Equalf(t, r1, r2, "x: %v, a: %v", x, a)
		}
		{
			x := Random[float32](size)
			a := x[rand.Intn(len(x))]
			r1 := Find_Go(x, a)
			r2 := Find_AVX2_F32(x, a)
			require.Equalf(t, r1, r2, "x: %v, a: %v", x, a)
		}
	}
}

func BenchmarkFind(b *testing.B) {
	for _, size := range sizes {
		x := Random[float64](size)
		x32 := Random[float32](size)

		b.Run(fmt.Sprintf("go_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Find_Go(x, x[len(x)-1])
			}
		})
		b.Run(fmt.Sprintf("go_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Find_Go(x32, x32[len(x32)-1])
			}
		})
		b.Run(fmt.Sprintf("avx2_f64_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Find_AVX2_F64(x, x[len(x)-1])
			}
		})
		b.Run(fmt.Sprintf("avx2_f32_%d", size), func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				Find_AVX2_F32(x32, x32[len(x32)-1])
			}
		})
	}
}
