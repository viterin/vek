#include <cstddef>
#include <cmath>

template<typename T>
T Dot(T* x, T* y, size_t n) {
    T res = 0;
    for (size_t i = 0; i < n; i++) {
        res += x[i] * y[i];
    }
    return res;
}

template<typename T>
T CosineSimilarity(T* x, T* y, size_t n) {
    T dp = 0;
    T xdp = 0;
    T ydp = 0;
    for (size_t i = 0; i < n; i++) {
        dp += x[i] * y[i];
        xdp += x[i] * x[i];
        ydp += y[i] * y[i];
    }
    return dp / std::sqrt(xdp*ydp);
}

template<typename T>
T EuclideanNorm(T* x, size_t n) {
    T res = 0;
    for (size_t i = 0; i < n; i++) {
        res += x[i] * x[i];
    }
    return std::sqrt(res);
}

template<typename T>
T EuclideanDistance(T* x, T* y, size_t n) {
    T res = 0;
    for (size_t i = 0; i < n; i++) {
        res += (x[i] - y[i])*(x[i] - y[i]);
    }
    return std::sqrt(res);
}

template<typename T>
T ManhattanNorm(T* x, size_t n) {
    T res = 0;
    for (size_t i = 0; i < n; i++) {
        res += std::abs(x[i]);
    }
    return res;
}

template<typename T>
T ManhattanDistance(T* x, T* y, size_t n) {
    T res = 0;
    for (size_t i = 0; i < n; i++) {
        res += std::abs(x[i] - y[i]);
    }
    return res;
}

double Dot_F64_D(double* x, double* y, size_t n) {
    return Dot(x, y, n);
}

float Dot_F32_F(float* x, float* y, size_t n) {
    return Dot(x, y, n);
}

double CosineSimilarity_F64_D(double* x, double* y, size_t n) {
    return CosineSimilarity(x, y, n);
}

float CosineSimilarity_F32_F(float* x, float* y, size_t n) {
    return CosineSimilarity(x, y, n);
}

double Norm_F64_D(double* x, size_t n) {
    return EuclideanNorm(x, n);
}

float Norm_F32_F(float* x, size_t n) {
    return EuclideanNorm(x, n);
}

double Distance_F64_D(double* x, double* y, size_t n) {
    return EuclideanDistance(x, y, n);
}

float Distance_F32_F(float* x, float* y, size_t n) {
    return EuclideanDistance(x, y, n);
}

double ManhattanNorm_F64_D(double* x, size_t n) {
    return ManhattanNorm(x, n);
}

float ManhattanNorm_F32_F(float* x, size_t n) {
    return ManhattanNorm(x, n);
}

double ManhattanDistance_F64_D(double* x, double* y, size_t n) {
    return ManhattanDistance(x, y, n);
}

float ManhattanDistance_F32_F(float* x, float* y, size_t n) {
    return ManhattanDistance(x, y, n);
}
