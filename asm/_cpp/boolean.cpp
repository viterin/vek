#include <cstddef>
#include <x86intrin.h>

void Not_V(bool* x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = !x[i];
    }
}

void And_V(bool* __restrict x, bool* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = x[i] & y[i];
    }
}

void Or_V(bool* __restrict x, bool* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = x[i] | y[i];
    }
}

void Xor_V(bool* __restrict x, bool* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = x[i] != y[i];
    }
}

template<typename T>
size_t Select(T* __restrict dst, T* __restrict x, bool* __restrict y, size_t n) { // not vectorized
    size_t cnt = 0;
    for (size_t i = 0; i < n; i++) {
        if (y[i]) {
            dst[cnt++] = x[i];
        }
    }
    return cnt;
}

size_t Select_F64_I(double* dst, double* x, bool* y, size_t n) {
    return Select(dst, x, y, n);
}

size_t Select_F32_I(float* dst, float* x, bool* y, size_t n) {
    return Select(dst, x, y, n);
}

bool All_I(bool* __restrict x, size_t n) {
    __m256i zeros = _mm256_setzero_si256();

    size_t i = 0;
    for (; i < (n & size_t(-32)); i += 32) {
        __m256i y = _mm256_loadu_si256((__m256i_u*)&x[i]);
        __m256i m = _mm256_cmpeq_epi8(y, zeros);
        if (!_mm256_testz_si256(m, m)) {
            return false;
        }
    }
    for (; i < n; i++) {
        if (!x[i]) {
            return false;
        }
    }

    return true;
}


bool Any_I(bool* __restrict x, size_t n) {
    size_t i = 0;
    for (; i < (n & size_t(-32)); i += 32) {
        __m256i y = _mm256_loadu_si256((__m256i_u*)&x[i]);
        if (!_mm256_testz_si256(y, y)) {
            return true;
        }
    }
    for (; i < n; i++) {
        if (x[i]) {
            return true;
        }
    }

    return false;
}

bool None_I(bool* __restrict x, size_t n) {
    size_t i = 0;
    for (; i < (n & size_t(-32)); i += 32) {
        __m256i y = _mm256_loadu_si256((__m256i_u*)&x[i]);
        if (!_mm256_testz_si256(y, y)) {
            return false;
        }
    }
    for (; i < n; i++) {
        if (x[i]) {
            return false;
        }
    }

    return true;
}

size_t Count_I(bool* x, size_t n) {
    size_t cnt = 0;
    for (size_t i = 0; i < n; i++) {
        cnt += x[i];
    }
    return cnt;
}
