# vek - SIMD Vector Functions

[![Build Status](https://github.com/viterin/vek/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/viterin/vek/actions/workflows/test.yml)
[![Go Report Card](https://goreportcard.com/badge/github.com/viterin/vek)](https://goreportcard.com/report/github.com/viterin/vek)
[![Go Reference](https://pkg.go.dev/badge/github.com/viterin/vek.svg)](https://pkg.go.dev/github.com/viterin/vek)

`vek` is a collection of SIMD accelerated vector functions for Go.

Most modern CPUs have special SIMD instructions (Single Instruction, Multiple Data) to
process data in parallel, but there is currently no way to use them in a pure Go program. 
`vek` implements a large number of common vector operations in SIMD accelerated assembly 
code and wraps them in a simple Go API. `vek` supports most modern x86 CPUs and falls 
back to a pure Go implementation on unsupported platforms.

## Features

- Fast, average speedups of 10x for `float32` vectors
- Fallback to pure Go on unsupported platforms
- Support for `float64`, `float32` and `bool` vectors
- Zero allocation variations of each function

## Installation

```bash
go get -u github.com/viterin/vek
```

## Getting Started

### Simple Arithmetic Example

Vectors are represented as plain old floating point slices, there are no special data
types in `vek`. All operations on `float64` vectors reside in the `vek` package. It contains
all the basic arithmetic operations:

```go
package main

import (
	"fmt"
	"github.com/viterin/vek"
)

func main() {
	x := []float64{0, 1, 2, 3, 4}

	// Multiply a vector by itself element-wise
	y := vek.Mul(x, x)
	fmt.Println(x, y) // [0 1 2 3 4] [0 1 4 9 16]

	// Multiply each element by a number
	y = vek.MulNumber(x, 2)
	fmt.Println(x, y) // [0 1 2 3 4] [0 2 4 6 8]
}
```

### Working With 32-Bit Vectors

The `vek32` package contains `float32` versions of each operation:

```go
package main

import (
	"fmt"
	"github.com/viterin/vek/vek32"
)

func main() {
	// Add a float32 number to each element
	x := []float32{0, 1, 2, 3, 4}
	y := vek32.AddNumber(x, 2)

	fmt.Println(x, y) // [0 1 2 3 4] [2 3 4 5 6]
}
```

### Comparisons and Selections

Floating point vectors can be compared to other vectors or numbers. The result is a `bool` vector 
indicating where the comparison holds true. `bool` vectors can be used to select matching elements, 
count matches and more:

```go
package main

import (
	"fmt"
	"github.com/viterin/vek"
)

func main() {
	x := []float64{0, 1, 2, 3, 4, 5}
	y := []float64{5, 4, 3, 2, 1, 0}

	// []bool indicating where x < y (less than)
	m := vek.Lt(x, y)
	fmt.Println(m)            // [true true true false false false]
	fmt.Println(vek.Count(m)) // 3

	// []bool indicating where x >= 2 (greater than or equal)
	m = vek.GteNumber(x, 2)
	fmt.Println(m)          // [false false true true true true]
	fmt.Println(vek.Any(m)) // true

	// Selection of non-zero elements less than y
	z := vek.Select(x,
		vek.And(
			vek.Lt(x, y),
			vek.NeqNumber(x, 0),
		),
	)
	fmt.Println(z) // [1 2]
}
```

### Creating and Converting Vectors

`vek` has a number of functions to construct new vectors and convert between vector types efficiently:

```go
package main

import (
	"fmt"
	"github.com/viterin/vek"
	"github.com/viterin/vek/vek32"
)

func main() {
	// Vector with number repeated n times
	x := vek.Repeat(2, 5)
	fmt.Println(x) // [2 2 2 2 2]

	// Vector ranging from a to b (excl.) in steps of 1
	x = vek.Range(-2, 3)
	fmt.Println(x) // [-2 -1 0 1 2]

	// Conversion from float64 to int32
	xi32 := vek.ToInt32(x)
	fmt.Println(xi32) // [-2 -1 0 1 2]

	// Conversion from int32 to float32
	x32 := vek32.FromInt32(xi32)
	fmt.Println(x32) // [-2 -1 0 1 2]
}
```

### Avoiding Allocations

By default, functions allocate a new array to store the result. Append `_Inplace`
to a function to do the operation inplace, overriding the data of the first
argument slice with the result. Append `_Into` to write the result into a target 
slice.

```go
package main

import (
	"fmt"
	"github.com/viterin/vek"
)

func main() {
	x := []float64{0, 1, 2, 3, 4}
	vek.AddNumber_Inplace(x, 2)

	y := make([]float64, len(x))
	vek.AddNumber_Into(y, x, 2)

	fmt.Println(x, y) // [2 3 4 5 6] [4 5 6 7 8]
}
```

### SIMD Acceleration

SIMD Acceleration is enabled by default on supported platforms, which is any x86/amd64 CPU with
the AVX2 and FMA extensions. Use `vek.Info()` to see if hardware acceleration is enabled. Turn
it off or on with `vek.SetAcceleration()`. *Acceleration is currently disabled by default on
mac as I have no machine to test it on*.

```go
package main

import (
	"fmt"
	"github.com/viterin/vek"
)

func main() {
	fmt.Printf("%+v", vek.Info())
	// {CPUArchitecture:amd64 CPUFeatures:[AVX2 FMA ..] Acceleration:true}
}
```

## API

|                                 |                               **description** |
|:--------------------------------|----------------------------------------------:|
| **Arithmetic**                  |                                               |
| vek.Add(x, y)                   |                         element-wise addition |
| vek.AddNumber(x, a)             |                    add number to each element |
| vek.Sub(x, y)                   |                      element-wise subtraction |
| vek.SubNumber(x, a)             |             subtract number from each element |
| vek.Mul(x, y)                   |                   element-wise multiplication |
| vek.MulNumber(x, a)             |               multiply each element by number |
| vek.Div(x, y)                   |                         element-wise division |
| vek.DivNumber(x, a)             |                 divide each element by number |
| vek.Mod(x, y)                   |                          element-wise modulus |
| vek.ModNumber(x, a)             |            modulus of each element and number |
| vek.Abs(x)                      |                               absolute values |
| vek.Neg(x)                      |                             additive inverses |
| vek.Inv(x)                      |                       multiplicative inverses |
| **Aggregates**                  |                                               |
| vek.Sum(x)                      |                               sum of elements |
| vek.CumSum(x)                   |                                cumulative sum |
| vek.Prod(x)                     |                           product of elements |
| vek.CumProd(x)                  |                            cumulative product |
| vek.Mean(x)                     |                                          mean |
| vek.Median(x)                   |                                        median |
| vek.Quantile(x, q)              |                    q-th quantile, 0 <= q <= 1 |
| **Distance**                    |                                               |
| vek.Dot(x, y)                   |                                   dot product |
| vek.Norm(x)                     |                       euclidean norm (length) |
| vek.Distance(x, y)              |                            euclidean distance |
| vek.ManhattanNorm(x)            |                        sum of absolute values |
| vek.ManhattanDistance(x, y)     |                   sum of absolute differences |
| vek.CosineSimilarity(x, y)      |                             cosine similarity |
| **Matrices**                    |                                               |
| vek.MatMul(x, y, n)             | multiply m-by-n and n-by-p matrix (row-major) |
| vek.Mat4Mul(x, y)               |            specialization for 4 by 4 matrices |
| **Special**                     |                                               |
| vek.Sqrt(x)                     |                   square root of each element |
| vek.Pow(x, y)                   |                            element-wise power |
| vek.Round(x), Floor(x), Ceil(x) |   round to nearest, lesser or greater integer |
| **Special (32-bit only)**       |                                               |
| vek32.Sin(x)                    |                          sine of each element |
| vek32.Cos(x)                    |                        cosine of each element |
| vek32.Exp(x)                    |                          exponential function |
| vek32.Log(x), Log2(x), Log10(x) |        natural, base 2 and base 10 logarithms |
| **Comparison**                  |                                               |
| vek.Min(x)                      |                                 minimum value |
| vek.ArgMin(x)                   |              first index of the minimum value |
| vek.Minimum(x, y)               |                   element-wise minimum values |
| vek.MinimumNumber(x, a)         |            minimum of each element and number |
| vek.Max(x)                      |                                 maximum value |
| vek.ArgMax(x)                   |              first index of the maximum value |
| vek.Maximum(x, y)               |                   element-wise maximum values |
| vek.MaximumNumber(x, a)         |            maximum of each element and number |
| vek.Find(x, a)                  |        first index of number, -1 if not found |
| vek.Lt(x, y)                    |                        element-wise less than |
| vek.LtNumber(x, a)              |                              less than number |
| vek.Lte(x, y)                   |               element-wise less than or equal |
| vek.LteNumber(x, a)             |                  less than or equal to number |
| vek.Gt(x, y)                    |                     element-wise greater than |
| vek.GtNumber(x, a)              |                           greater than number |
| vek.Gte(x, y)                   |            element-wise greater than or equal |
| vek.GteNumber(x, a)             |               greater than or equal to number |
| vek.Eq(x, y)                    |                         element-wise equality |
| vek.EqNumber(x, a)              |                               equal to number |
| vek.Neq(x, y)                   |                     element-wise non-equality |
| vek.NeqNumber(x, a)             |                           not equal to number |
| **Boolean**                     |                                               |
| vek.Not(x)                      |                              element-wise not |
| vek.And(x, y)                   |                              element-wise and |
| vek.Or(x, y)                    |                               element-wise or |
| vek.Xor(x, y)                   |                     element-wise exclusive or |
| vek.Select(x, y)                |          select elements using boolean vector |
| vek.All(x)                      |                            all bools are true |
| vek.Any(x)                      |                     at least one bool is true |
| vek.None(x)                     |                    none of the bools are true |
| vek.Count(x)                    |                          number of true bools |
| **Construction**                |                                               |
| vek.Zeros(n)                    |                               vector of zeros |
| vek.Ones(n)                     |                                vector of ones |
| vek.Repeat(a, n)                |                   vector with number repeated |
| vek.Range(a, b)                 |      vector from a to b (excl.) in steps of 1 |
| vek.Gather(x, idx)              |              select elements at given indices |
| vek.Scatter(x, idx, size)       |      create vector with indices set to values |
| vek.FromBool(x), FromInt64, ..  |                       convert slice to floats |
| vek.ToBool(x), ToInt64, ..      |                  convert floats to other type |

### API Variations

**vek32.xxx( .. )**

The `vek32` package contains identical functions for `float32` vectors, e.g. `vek32.Add(x, y)`.

**vek.xxx_Inplace( .. )**

Append `_Inplace` to the function name to mutate the argument vector inplace, e.g.
`vek.Add_Inplace(x, y)`. The first argument is the destination. It should not overlap 
other argument slices.

**vek.xxx_Into( dst, .. )**

Append `_Into` to the function name to write the result into a target slice, e.g.
`vek.Add_Into(dst, x, y)`. The destination should have sufficient
capacity to hold the result, its length can be anything. It should
not overlap other argument slices. The return value is the destination slice resized
to the length of the result.

## Benchmarks

Comparison of SIMD accelerated functions to the pure Go fallback version for different size slices.
Times are in nanoseconds. Functions are inplace.

`go test -benchmem -timeout 0 -run=^# -bench=. ./internal/...`

|                     | **1k, Go** | **1k, SIMD** | **100k, Go** | **100k, SIMD** | **speedup** |
|---------------------|-----------:|-------------:|-------------:|---------------:|------------:|
| **vek.Add**         |        484 |          192 |       57,544 |         26,431 |          2x |
| **vek32.Add**       |        610 |          116 |       84,870 |         13,164 |          6x |
| **vek.Mul**         |        499 |          186 |       58,154 |         26,955 |          2x |
| **vek32.Mul**       |        607 |          126 |       83,486 |         13,056 |          6x |
| **vek.Abs**         |        794 |          123 |      120,018 |         19,680 |          6x |
| **vek32.Abs**       |        736 |           82 |      113,446 |          7,990 |         14x |
| **vek.Sum**         |        633 |           39 |       64,824 |          6,859 |          9x |
| **vek32.Sum**       |        631 |           20 |       65,007 |          3,191 |         20x |
| **vek.Quantile**    |      3,375 |        3,075 |      860,382 |        816,831 |          1x |
| **vek32.Quantile**  |      3,367 |        3,040 |      751,790 |        698,111 |          1x |
| **vek.Round**       |      1,485 |          161 |      250,316 |         21,622 |         11x |
| **vek32.Round**     |      1,812 |          102 |      250,035 |          9,722 |         25x |
| **vek.Sqrt**        |      1,900 |          614 |      326,998 |         85,986 |          4x |
| **vek32.Sqrt**      |      1,704 |          148 |      247,944 |         15,571 |         15x |
| **vek.Pow**         |     39,833 |        6,137 |    4,155,465 |        776,556 |          5x |
| **vek32.Pow**       |     30,386 |        2,091 |    4,070,793 |        292,980 |         14x |
| **vek32.Exp**       |      7,177 |          375 |    1,120,300 |         49,694 |         22x |
| **vek32.Log**       |      4,663 |          453 |    1,017,240 |         65,042 |         16x |
| **vek.Max**         |        734 |           62 |       43,412 |          7,568 |          6x |
| **vek32.Max**       |        731 |           27 |       44,349 |          3,484 |         13x |
| **vek.Maximum**     |      1,000 |          517 |      542,944 |         66,423 |          8x |
| **vek32.Maximum**   |        873 |          499 |      556,103 |         66,786 |          8x |
| **vek.Find**        |        294 |           77 |       21,989 |          7,256 |          3x |
| **vek32.Find**      |        223 |           35 |       21,813 |          3,010 |          7x |
| **vek.Lt**          |        543 |          195 |       64,136 |         23,548 |          3x |
| **vek32.Lt**        |        539 |          130 |       62,449 |         13,188 |          5x |
| **vek.And**         |      1,172 |           60 |      373,077 |          2,683 |        139x |
| **vek.All**         |        237 |           11 |       21,696 |            738 |         29x |
| **vek.Range**       |        647 |           59 |       65,403 |          7,889 |          8x |
| **vek32.Range**     |        633 |           32 |       65,155 |          3,252 |         20x |
| **vek.FromInt32**   |        335 |           56 |       33,410 |         11,428 |          3x |
| **vek32.FromInt32** |        439 |           29 |       44,372 |          7,423 |          6x |

|                   | **m=1k,n=1k,p=1, Go** | **m=1k,n=1k,p=1, SIMD** | **p=1k, Go** | **p=1k, SIMD** | **speedup** |
|-------------------|----------------------:|------------------------:|-------------:|---------------:|------------:|
| **vek.MatMul**    |               258,418 |                  38,835 |  152,726,512 |     20,823,962 |          7x |
| **vek32.MatMul**  |               256,453 |                  28,403 |  147,474,083 |     10,479,834 |         14x |
|                   |   **m=4,n=4,p=4, Go** |   **m=4,n=4,p=4, SIMD** |              |                |             |
| **vek.Mat4Mul**   |                    26 |                       5 |              |                |          5x |
| **vek32.Mat4Mul** |                    26 |                       5 |              |                |          5x |

