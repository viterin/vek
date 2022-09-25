#include <cstddef>
#include <limits>

template<typename T>
T Min(T* x, size_t n) {
    T min = std::numeric_limits<T>::max();
    for (size_t i = 0; i < n; i++) {
        if (x[i] < min) {
            min = x[i];
        }
    }
    return min;
}

template<typename T>
void Minimum(T* __restrict x, T* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (y[i] < x[i]) {
            x[i] = y[i];
        }
    }
}

template<typename T>
void MinimumNumber(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (a < x[i]) {
            x[i] = a;
        }
    }
}

double min_F64_D(double* x, size_t n) {
    return Min(x, n);
}

float min_F32_F(float* x, size_t n) {
    return Min(x, n);
}

void minimum_F64_V(double* __restrict x, double* __restrict y, size_t n) {
    Minimum(x, y, n);
}

void minimum_F32_V(float* __restrict x, float* __restrict y, size_t n) {
    Minimum(x, y, n);
}

void minimumNumber_F64_V(double* __restrict x, double a, size_t n) {
    MinimumNumber(x, a, n);
}

void minimumNumber_F32_V(float* __restrict x, float a, size_t n) {
    MinimumNumber(x, a, n);
}
