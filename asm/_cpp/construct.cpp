#include <cstddef>
#include <cstdint>

template<typename T>
void Repeat(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = a;
    }
}

template<typename T>
void Range(T* __restrict x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = a;
        a += 1;
    }
}

template<typename T>
void Gather(T* __restrict dst, T* x, size_t* idx, size_t n) {
    for (size_t i = 0; i < n; i++) {
        dst[i] = x[idx[i]];
    }
}

template<typename T>
void Scatter(T* __restrict dst, T* x, size_t* idx, size_t n) {
    for (size_t i = 0; i < n; i++) {
        dst[idx[i]] = x[i];
    }
}

template<typename T, typename F>
void Convert(T* __restrict x, F* __restrict y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = T(y[i]);
    }
}

void Repeat_F64_V(double* x, double a, size_t n) {
    Repeat(x, a, n);
}

void Repeat_F32_V(float* x, float a, size_t n) {
    Repeat(x, a, n);
}

void Range_F64_V(double* x, double a, size_t n) {
    Range(x, a, n);
}

void Range_F32_V(float* x, float a, size_t n) {
    Range(x, a, n);
}

//void Gather_F64_V(double* dst, double* x, size_t* idx, size_t n) {
//    Gather(dst, x, idx, n);
//}
//
//void Gather_F32_V(float* dst, float* x, size_t* idx, size_t n) {
//    Gather(dst, x, idx, n);
//}
//
//void Scatter_F64_V(double* dst, double* x, size_t* idx, size_t n) {
//    Scatter(dst, x, idx, n);
//}
//
//void Scatter_F32_V(float* dst, float* x, size_t* idx, size_t n) {
//    Scatter(dst, x, idx, n);
//}

void FromBool_F64_V(double* x, bool* y, size_t n) {
    Convert(x, y, n);
}

void FromBool_F32_V(float* x, bool* y, size_t n) {
    Convert(x, y, n);
}

void FromFloat32_F64_V(double* x, float* y, size_t n) {
    Convert(x, y, n);
}

void FromFloat64_F32_V(float* x, double* y, size_t n) {
    Convert(x, y, n);
}

void FromInt64_F64_V(double* x, int64_t* y, size_t n) {
    Convert(x, y, n);
}

void FromInt64_F32_V(float* x, int64_t* y, size_t n) {
    Convert(x, y, n);
}

void FromInt32_F64_V(double* x, int32_t* y, size_t n) {
    Convert(x, y, n);
}

void FromInt32_F32_V(float* x, int32_t* y, size_t n) {
    Convert(x, y, n);
}

void ToBool_F64_V(bool* x, double* y, size_t n) {
    Convert(x, y, n);
}

void ToBool_F32_V(bool* x, float* y, size_t n) {
    Convert(x, y, n);
}

void ToInt64_F64_V(int64_t* x, double* y, size_t n) {
    Convert(x, y, n);
}

void ToInt64_F32_V(int64_t* x, float* y, size_t n) {
    Convert(x, y, n);
}

void ToInt32_F64_V(int32_t* x, double* y, size_t n) {
    Convert(x, y, n);
}

void ToInt32_F32_V(int32_t* x, float* y, size_t n) {
    Convert(x, y, n);
}
