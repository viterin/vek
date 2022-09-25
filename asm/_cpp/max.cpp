#include <cstddef>
#include <limits>

template<typename T>
T Max(T* x, size_t n) {
    T max = std::numeric_limits<T>::lowest();
    for (size_t i = 0; i < n; i++) {
        if (x[i] > max) {
            max = x[i];
        }
    }
    return max;
}

template<typename T>
void Maximum(T* __restrict x, T* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (y[i] > x[i]) {
            x[i] = y[i];
        }
    }
}

template<typename T>
void MaximumNumber(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (a > x[i]) {
            x[i] = a;
        }
    }
}

double Max_F64_D(double* x, size_t n) {
    return Max(x, n);
}

float Max_F32_F(float* x, size_t n) {
    return Max(x, n);
}

void Maximum_F64_V(double* __restrict x, double* __restrict y, size_t n) {
    Maximum(x, y, n);
}

void Maximum_F32_V(float* __restrict x, float* __restrict y, size_t n) {
    Maximum(x, y, n);
}

void MaximumNumber_F64_V(double* __restrict x, double a, size_t n) {
    MaximumNumber(x, a, n);
}

void MaximumNumber_F32_V(float* __restrict x, float a, size_t n) {
    MaximumNumber(x, a, n);
}
