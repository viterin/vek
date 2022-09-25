#include <cstddef>

template<typename T>
T Sum(T* __restrict x, size_t n) {
    T sum = 0;
    for (size_t i = 0; i < n; i++) {
        sum += x[i];
    }
    return sum;
}

template<typename T>
void CumSum(T* __restrict x, size_t n) { // not vectorized
    T sum = 0;
    for (size_t i = 0; i < n; i++) {
        sum += x[i];
        x[i] = sum;
    }
}

template<typename T>
T Prod(T* __restrict x, size_t n) {
    T prod = 1;
    for (size_t i = 0; i < n; i++) {
        prod *= x[i];
    }
    return prod;
}

template<typename T>
void CumProd(T* __restrict x, size_t n) { // not vectorized
    T prod = 1;
    for (size_t i = 0; i < n; i++) {
        prod *= x[i];
        x[i] = prod;
    }
}

double Sum_F64_D(double* x, size_t n) {
    return Sum(x, n);
}

float Sum_F32_F(float* x, size_t n) {
    return Sum(x, n);
}

void CumSum_F64_V(double* x, size_t n) {
    return CumSum(x, n);
}

void CumSum_F32_V(float* x, size_t n) {
    return CumSum(x, n);
}

double Prod_F64_D(double* x, size_t n) {
    return Prod(x, n);
}

float Prod_F32_F(float* x, size_t n) {
    return Prod(x, n);
}

void CumProd_F64_V(double* x, size_t n) {
    return CumProd(x, n);
}

void CumProd_F32_V(float* x, size_t n) {
    return CumProd(x, n);
}
