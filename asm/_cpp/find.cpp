#include <cstddef>
#include <x86intrin.h>

size_t Find_F64(double* x, double a, size_t n) {
    __m256d va = _mm256_set1_pd(a);

    size_t i = 0;
    for (; i < (n & size_t(-8)); i += 8) {
        __m256d y1 = _mm256_loadu_pd(&x[i]);
        __m256d y2 = _mm256_loadu_pd(&x[i + 4]);
        __m256i m1 = _mm256_cmpeq_epi64(va, y1);
        __m256i m2 = _mm256_cmpeq_epi64(va, y2);
        __m256i m = _mm256_or_si256(m1, m2);
        if (!_mm256_testz_si256(m, m)) {
            int mask = (_mm256_movemask_pd((__m256)m2) << 4) + _mm256_movemask_pd((__m256)m1);
            return i + __builtin_ctz(mask);
        }
    }
    for (; i < n; i++) {
        if (x[i] == a) {
            return i;
        }
    }

    return i;
}

size_t Find_F32(float* x, float a, size_t n) {
    __m256 va = _mm256_set1_ps(a);

    size_t i = 0;
    for (; i < (n & size_t(-16)); i += 16) {
        __m256 y1 = _mm256_loadu_ps(&x[i]);
        __m256 y2 = _mm256_loadu_ps(&x[i + 8]);
        __m256i m1 = _mm256_cmpeq_epi32(va, y1);
        __m256i m2 = _mm256_cmpeq_epi32(va, y2);
        __m256i m = _mm256_or_si256(m1, m2);
        if (!_mm256_testz_si256(m, m)) {
            int mask = (_mm256_movemask_ps((__m256)m2) << 8) + _mm256_movemask_ps((__m256)m1);
            return i + __builtin_ctz(mask);
        }
    }
    for (; i < n; i++) {
        if (x[i] == a) {
            return i;
        }
    }

    return i;
}
