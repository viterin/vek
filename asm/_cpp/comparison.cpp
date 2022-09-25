#include <cstddef>

template<typename T>
void Lt(bool* __restrict dst, T* x, T* y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] < y[i]) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void LtNumber(bool* __restrict dst, T* x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] < a) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void Lte(bool* __restrict dst, T* x, T* y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] <= y[i]) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void LteNumber(bool* __restrict dst, T* x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] <= a) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void Gt(bool* __restrict dst, T* x, T* y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] > y[i]) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void GtNumber(bool* __restrict dst, T* x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] > a) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void Gte(bool* __restrict dst, T* x, T* y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] >= y[i]) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void GteNumber(bool* __restrict dst, T* x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] >= a) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void Eq(bool* __restrict dst, T* x, T* y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] == y[i]) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void EqNumber(bool* __restrict dst, T* x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] == a) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void Neq(bool* __restrict dst, T* x, T* y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] != y[i]) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

template<typename T>
void NeqNumber(bool* __restrict dst, T* x, T a, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (x[i] != a) {
            dst[i] = true;
        } else {
            dst[i] = false;
        }
    }
}

void Lt_F64_V(bool* __restrict dst, double* x, double* y, size_t n) {
    Lt(dst, x, y, n);
}

void Lt_F32_V(bool* __restrict dst, float* x, float* y, size_t n) {
    Lt(dst, x, y, n);
}

void Lte_F64_V(bool* __restrict dst, double* x, double* y, size_t n) {
    Lte(dst, x, y, n);
}

void Lte_F32_V(bool* __restrict dst, float* x, float* y, size_t n) {
    Lte(dst, x, y, n);
}

void Gt_F64_V(bool* __restrict dst, double* x, double* y, size_t n) {
    Gt(dst, x, y, n);
}

void Gt_F32_V(bool* __restrict dst, float* x, float* y, size_t n) {
    Gt(dst, x, y, n);
}

void Gte_F64_V(bool* __restrict dst, double* x, double* y, size_t n) {
    Gte(dst, x, y, n);
}

void Gte_F32_V(bool* __restrict dst, float* x, float* y, size_t n) {
    Gte(dst, x, y, n);
}

void Eq_F64_V(bool* __restrict dst, double* x, double* y, size_t n) {
    Eq(dst, x, y, n);
}

void Eq_F32_V(bool* __restrict dst, float* x, float* y, size_t n) {
    Eq(dst, x, y, n);
}

void Neq_F64_V(bool* __restrict dst, double* x, double* y, size_t n) {
    Neq(dst, x, y, n);
}

void Neq_F32_V(bool* __restrict dst, float* x, float* y, size_t n) {
    Neq(dst, x, y, n);
}

void LtNumber_F64_V(bool* __restrict dst, double* x, double a, size_t n) {
    LtNumber(dst, x, a, n);
}

void LtNumber_F32_V(bool* __restrict dst, float* x, float a, size_t n) {
    LtNumber(dst, x, a, n);
}

void LteNumber_F64_V(bool* __restrict dst, double* x, double a, size_t n) {
    LteNumber(dst, x, a, n);
}

void LteNumber_F32_V(bool* __restrict dst, float* x, float a, size_t n) {
    LteNumber(dst, x, a, n);
}

void GtNumber_F64_V(bool* __restrict dst, double* x, double a, size_t n) {
    GtNumber(dst, x, a, n);
}

void GtNumber_F32_V(bool* __restrict dst, float* x, float a, size_t n) {
    GtNumber(dst, x, a, n);
}

void GteNumber_F64_V(bool* __restrict dst, double* x, double a, size_t n) {
    GteNumber(dst, x, a, n);
}

void GteNumber_F32_V(bool* __restrict dst, float* x, float a, size_t n) {
    GteNumber(dst, x, a, n);
}

void EqNumber_F64_V(bool* __restrict dst, double* x, double a, size_t n) {
    EqNumber(dst, x, a, n);
}

void EqNumber_F32_V(bool* __restrict dst, float* x, float a, size_t n) {
    EqNumber(dst, x, a, n);
}

void NeqNumber_F64_V(bool* __restrict dst, double* x, double a, size_t n) {
    NeqNumber(dst, x, a, n);
}

void NeqNumber_F32_V(bool* __restrict dst, float* x, float a, size_t n) {
    NeqNumber(dst, x, a, n);
}
