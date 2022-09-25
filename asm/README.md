# Converting C++ to Assembly

All SIMD functions are generated from C++. Most of it is portable, auto-vectorized code. To add a new function:

1. Compile the C++ source code to AT&T assembly with Clang, flags `-Ofast -mfma -mavx2 -funroll-loops -fomit-frame-pointer`
2. Convert the output to [avo](https://github.com/mmcloughlin/avo) instructions with `python asm/asm2avo.py --suffix AVX2 input.s --out output.go`
3. Fix potential issues with the output. Data sections need to be added manually and moves changed to unaligned access
4. Add the avo section to `asm/gen.go` and generate Go assembly and stubs with `go generate asm/gen.go`

The C++ code was mostly compiled and analyzed with [godbolt](https://godbolt.org/). Other assembly output may need additional cleanup.
