#include <cstddef>
#include <cmath>

template<typename T>
void Add(T* __restrict x, T* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] += y[i];
    }
}

template<typename T>
void AddNumber(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] += a;
    }
}

template<typename T>
void Sub(T* __restrict x, T* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] -= y[i];
    }
}

template<typename T>
void SubNumber(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] -= a;
    }
}

template<typename T>
void Mul(T* __restrict x, T* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] *= y[i];
    }
}

template<typename T>
void MulNumber(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] *= a;
    }
}

template<typename T>
void Div(T* __restrict x, T* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] /= y[i];
    }
}

template<typename T>
void DivNumber(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] /= a;
    }
}

template<typename T>
void Abs(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = std::abs(x[i]);
    }
}

template<typename T>
void Neg(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = -x[i];
    }
}

template<typename T>
void Inv(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = 1 / x[i];
    }
}

void Add_F64_V(double* x, double* y, size_t n) {
    Add(x, y, n);
}

void Add_F32_V(float* x, float* y, size_t n) {
    Add(x, y, n);
}

void AddNumber_F64_V(double* x, double a, size_t n) {
    AddNumber(x, a, n);
}

void AddNumber_F32_V(float* x, float a, size_t n) {
    AddNumber(x, a, n);
}

void Sub_F64_V(double* x, double* y, size_t n) {
    Sub(x, y, n);
}

void Sub_F32_V(float* x, float* y, size_t n) {
    Sub(x, y, n);
}

void SubNumber_F64_V(double* x, double a, size_t n) {
    SubNumber(x, a, n);
}

void SubNumber_F32_V(float* x, float a, size_t n) {
    SubNumber(x, a, n);
}

void Mul_F64_V(double* x, double* y, size_t n) {
    Mul(x, y, n);
}

void Mul_F32_V(float* x, float* y, size_t n) {
    Mul(x, y, n);
}

void MulNumber_F64_V(double* x, double a, size_t n) {
    MulNumber(x, a, n);
}

void MulNumber_F32_V(float* x, float a, size_t n) {
    MulNumber(x, a, n);
}

void Div_F64_V(double* x, double* y, size_t n) {
    Div(x, y, n);
}

void Div_F32_V(float* x, float* y, size_t n) {
    Div(x, y, n);
}

void DivNumber_F64_V(double* x, double a, size_t n) {
    DivNumber(x, a, n);
}

void DivNumber_F32_V(float* x, float a, size_t n) {
    DivNumber(x, a, n);
}

void Abs_F64_V(double* x, size_t n) {
    Abs(x, n);
}

void Abs_F32_V(float* x, size_t n) {
    Abs(x, n);
}

void Neg_F64_V(double* x, size_t n) {
    Neg(x, n);
}

void Neg_F32_V(float* x, size_t n) {
    Neg(x, n);
}

void Inv_F64_V(double* x, size_t n) {
    Inv(x, n);
}

void Inv_F32_V(float* x, size_t n) {
    Inv(x, n);
}
