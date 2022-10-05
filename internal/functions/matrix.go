package functions

import (
	"golang.org/x/exp/constraints"
	"runtime"
	"sync"
)

var numCPU int = runtime.NumCPU()

// matMulParallel runs matrix multiply in parallel by dividing the input rows
func matMulParallel[T constraints.Float](
	dst, x, y []T, m, n, p int,
	vecMul func(dst, x, y []T, m, n int),
	matMul func(dst, x, y []T, m, n, p int),
) {
	if m < 4 || m*p*n < 100_000 {
		if p == 1 {
			vecMul(dst, x, y, m, n)
		} else {
			matMul(dst, x, y, m, n, p)
		}
		return
	}

	rowsPerCPU, rem := m/numCPU, m%numCPU
	i := 0
	var wg sync.WaitGroup
	for c := 0; c < numCPU && i < m; c++ {
		numRows := rowsPerCPU
		if c < rem {
			numRows += 1
		}
		dstStart := i * p
		dstEnd := (i + numRows) * p
		xStart := i * n
		xEnd := (i + numRows) * n

		wg.Add(1)
		go func() {
			if p == 1 {
				vecMul(dst[dstStart:dstEnd], x[xStart:xEnd], y, numRows, n)
			} else {
				matMul(dst[dstStart:dstEnd], x[xStart:xEnd], y, numRows, n, p)
			}
			wg.Done()
		}()

		i += numRows
	}
	wg.Wait()
}

func MatMul_Go[T constraints.Float](dst, x, y []T, m, n, p int) {
	for i := 0; i < m; i++ {
		for k := 0; k < n; k++ {
			for j := 0; j < p; j++ { // dst not set to zero
				dst[i*p+j] += x[i*n+k] * y[k*p+j]
			}
		}
	}
}

func MatMulVec_Go[T constraints.Float](dst, x, y []T, m, n int) {
	for i := 0; i < m; i++ {
		for k := 0; k < n; k++ { // note: dst is not set to zero
			dst[i] += x[i*n+k] * y[k]
		}
	}
}

func Mat4Mul_Go[T constraints.Float](dst, x, y []T) {
	for i := 0; i < 4; i++ {
		for j := 0; j < 4; j++ {
			dst[i*4+j] = x[i*4]*y[j] + x[i*4+1]*y[1*4+j] +
				x[i*4+2]*y[2*4+j] + x[i*4+3]*y[3*4+j]
		}
	}
}

func MatMul_Parallel_Go[T constraints.Float](dst, x, y []T, m, n, p int) {
	matMulParallel(dst, x, y, m, n, p, MatMulVec_Go[T], MatMul_Go[T])
}
