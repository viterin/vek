package vek32

import (
	"github.com/chewxy/math32"
	"github.com/stretchr/testify/require"
	"testing"
)

const d = 0.001

var empty []float32 = []float32{}
var one []float32 = []float32{1}
var two []float32 = []float32{1, 2}
var eight []float32 = []float32{1, 2, 3, 4, 5, 6, 7, 8} // AVX register
var nine []float32 = []float32{1, 2, 3, 4, 5, 6, 7, 8, 9}
var accel []bool = []bool{false, Info().Acceleration}

func TestSpecial(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float32, 4)

		require.Empty(t, Sin(empty))
		require.InDeltaSlice(t, []float32{0.8415}, Sin(one), d)
		require.InDeltaSlice(t, []float32{0.8415, 0.9093, 0.1411, -0.7568, -0.9589, -0.2794, 0.6570, 0.9894}, Sin(eight), d)
		require.InDeltaSlice(t, []float32{0.8415, 0.9093, 0.1411, -0.7568, -0.9589, -0.2794, 0.6570, 0.9894, 0.4121}, Sin(nine), d)
		require.Panics(t, func() { Sin_Into(dst, nine) })

		require.Empty(t, Cos(empty))
		require.InDeltaSlice(t, Sin(AddNumber(one, math32.Pi/2)), Cos(one), d)
		require.InDeltaSlice(t, Sin(AddNumber(eight, math32.Pi/2)), Cos(eight), d)
		require.InDeltaSlice(t, Sin(AddNumber(nine, math32.Pi/2)), Cos(nine), d)
		require.Panics(t, func() { Cos_Into(dst, nine) })

		const e = 0.001

		require.Empty(t, Exp(empty))
		require.InEpsilonSlice(t, []float32{2.7183}, Exp(one), e)
		require.InEpsilonSlice(t, []float32{2.7183, 7.3891, 20.0855, 54.5982, 148.4132, 403.4288, 1096.6332, 2980.9580}, Exp(eight), e)
		require.InEpsilonSlice(t, []float32{2.7183, 7.3891, 20.0855, 54.5982, 148.4132, 403.4288, 1096.6332, 2980.9580, 8103.0839}, Exp(nine), e)
		require.Panics(t, func() { Exp_Into(dst, nine) })

		require.Empty(t, Log(empty))
		require.True(t, math32.IsNaN(Log([]float32{-1})[0]))
		require.InDeltaSlice(t, one, Log(Exp(one)), d)
		require.InDeltaSlice(t, eight, Log(Exp(eight)), d)
		require.InDeltaSlice(t, nine, Log(Exp(nine)), d)
		require.Panics(t, func() { Log_Into(dst, nine) })

		invln2 := float32(1.4426950408889634)
		invln10 := float32(0.4342944819032518)

		require.Empty(t, Log2(empty))
		require.True(t, math32.IsNaN(Log2([]float32{-1})[0]))
		require.InDeltaSlice(t, MulNumber(Log(one), invln2), Log2(one), d)
		require.InDeltaSlice(t, MulNumber(Log(eight), invln2), Log2(eight), d)
		require.InDeltaSlice(t, MulNumber(Log(nine), invln2), Log2(nine), d)
		require.Panics(t, func() { Log2_Into(dst, nine) })

		require.Empty(t, Log10(empty))
		require.True(t, math32.IsNaN(Log10([]float32{-1})[0]))
		require.InDeltaSlice(t, MulNumber(Log(one), invln10), Log10(one), d)
		require.InDeltaSlice(t, MulNumber(Log(eight), invln10), Log10(eight), d)
		require.InDeltaSlice(t, MulNumber(Log(nine), invln10), Log10(nine), d)
		require.Panics(t, func() { Log10_Into(dst, nine) })
	}
}

func TestConstruction(t *testing.T) {
	for _, accel := range accel {
		SetAcceleration(accel)

		dst := make([]float32, 4)

		require.Equal(t, empty, FromFloat64([]float64{}))
		require.Equal(t, []float32{5}, FromFloat64([]float64{5}))
		require.Equal(t, []float32{5, -5}, FromFloat64([]float64{5, -5}))
		require.Equal(t, []float32{5, -5, 5, 1}, FromFloat64([]float64{5, -5, 5, 1}))
		require.Equal(t, []float32{5, -5, 5, 1, 0}, FromFloat64([]float64{5, -5, 5, 1, 0}))
		require.Panics(t, func() { FromFloat64_Into(dst, []float64{1, 2, 3, 4, 5}) })
	}
}
