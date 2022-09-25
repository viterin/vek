package functions

import (
	"github.com/stretchr/testify/require"
	"golang.org/x/exp/rand"
	"golang.org/x/exp/slices"
	"testing"
)

func TestMin(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			r1 := Min_AVX2_F64(x)
			r2 := Min_Go(x)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float32](size)
			r1 := Min_AVX2_F32(x)
			r2 := Min_Go(x)
			require.InDelta(t, r1, r2, 0.001)
		}
		{
			x := Random[float64](size)
			r1 := ArgMin_AVX2_F64(x)
			r2 := ArgMin_Go(x)
			require.Equal(t, r1, r2)
		}
		{
			x := Random[float32](size)
			r1 := ArgMin_AVX2_F32(x)
			r2 := ArgMin_Go(x)
			require.Equal(t, r1, r2)
		}
	}
}

func TestMinimum(t *testing.T) {
	rand.Seed(2)
	for i := 0; i < 1000; i++ {
		size := 1 + (i / 5)
		{
			x := Random[float64](size)
			y := Random[float64](size)
			x1 := slices.Clone(x)
			Minimum_AVX2_F64(x, y)
			Minimum_Go(x1, y)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float32](size)
			y := Random[float32](size)
			x1 := slices.Clone(x)
			Minimum_AVX2_F32(x, y)
			Minimum_Go(x1, y)
			require.InDeltaSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float64](size)
			a := rand.Float64()
			x1 := slices.Clone(x)
			MinimumNumber_AVX2_F64(x, a)
			MinimumNumber_Go(x1, a)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
		{
			x := Random[float32](size)
			a := rand.Float32()
			x1 := slices.Clone(x)
			MinimumNumber_AVX2_F32(x, a)
			MinimumNumber_Go(x1, a)
			require.InEpsilonSlice(t, x, x1, 0.001)
		}
	}
}
