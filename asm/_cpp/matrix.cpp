#include <cstddef>
#include <algorithm>

template<typename T>
struct Mat4 {
    T m[4][4];
};

template<typename T>
void Mat4Mul(Mat4<T>* __restrict dst, Mat4<T>* __restrict x, Mat4<T>* __restrict y) {
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            dst->m[i][j] = x->m[i][0] * y->m[0][j] + x->m[i][1] * y->m[1][j] +
                           x->m[i][2] * y->m[2][j] + x->m[i][3] * y->m[3][j];
        }
    }
}

template <typename T>
void MatMul(T* __restrict dst, T* __restrict x, T* __restrict y, size_t m, size_t n, size_t p) {
    for (size_t i = 0; i < m; i++) {
        for (size_t k = 0; k < n; k++) {
            for (size_t j = 0; j < p; j++) {  // note: dst is not set to zero
                dst[i*p + j] += x[i*n + k] * y[k*p + j];
            }
        }
    }
}

template <typename T>
void MatMulVec(T* __restrict dst, T* __restrict x, T* __restrict y, size_t m, size_t n) {
    for (size_t i = 0; i < m; i++) {
        for (size_t k = 0; k < n; k++) {  // note: dst is not set to zero
            dst[i] += x[i*n + k] * y[k];
        }
    }
}

template <typename T>
void MatMulTiled(T* __restrict dst, T* __restrict x, T* __restrict y, size_t m, size_t n, size_t p) {
    size_t TI = 8;
    size_t TJ = 256;
    size_t TK = 256;
    for (size_t I = 0; I < m + TI - 1; I += TI) {
        for (size_t J = 0; J < p + TJ - 1; J += TJ) {
            for (size_t K = 0; K < n + TK - 1; K += TK) {
                const int maxI = std::min(I + TI, m);
                const int maxK = std::min(K + TK, n);
                const int maxJ = std::min(J + TJ, p);
                for (size_t i = I; i < maxI; i++) {
                    for (int k = K; k < maxK; k++) {
                        for (int j = J; j < maxJ; j++) {
                            dst[i*p + j] += x[i*n + k] * y[k*p + j];
                        }
                    }
                }
            }
        }
    }
}

void Mat4Mul_F64_V(double* dst, double* x, double* y) {
    Mat4Mul((Mat4<double>*)dst, (Mat4<double>*)x, (Mat4<double>*)y);
}

void Mat4Mul_F32_V(float* dst, float* x, float* y) {
    Mat4Mul((Mat4<float>*)dst, (Mat4<float>*)x, (Mat4<float>*)y);
}

void MatMul_F64_V(double* dst, double* x, double* y, size_t m, size_t n, size_t p) {
    MatMul(dst, x, y, m, n, p);
}

void MatMul_F32_V(float* dst, float* x, float* y, size_t m, size_t n, size_t p) {
    MatMul(dst, x, y, m, n, p);
}

void MatMulVec_F64_V(double* dst, double* x, double* y, size_t m, size_t n) {
    MatMulVec(dst, x, y, m, n);
}

void MatMulVec_F32_V(float* dst, float* x, float* y, size_t m, size_t n) {
    MatMulVec(dst, x, y, m, n);
}

void MatMulTiled_F64_V(double* dst, double* x, double* y, size_t m, size_t n, size_t p) {
    MatMulTiled(dst, x, y, m, n, p);
}

void MatMulTiled_F32_V(float* dst, float* x, float* y, size_t m, size_t n, size_t p) {
    MatMulTiled(dst, x, y, m, n, p);
}
