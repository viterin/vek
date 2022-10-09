#include <cmath>
#include <cstddef>
#include <x86intrin.h>

#define MAX_VECTOR_SIZE 256
#include "vectorclass.h"
#include "vectormath_exp.h"

const size_t vsize_float = 8;
const size_t vsize_double = 4;

template<typename T>
void Sqrt(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = std::sqrt(x[i]);
    }
}

template<typename T>
void Round(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = std::round(x[i]);
    }
}

template<typename T>
void Floor(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = std::floor(x[i]);
    }
}

template<typename T>
void Ceil(T* __restrict x, size_t n) {
    for (size_t i = 0; i < n; i++) {
        x[i] = std::ceil(x[i]);
    }
}

void Sqrt_F64_V(double* x, size_t n) {
    Sqrt(x, n);
}

void Sqrt_F32_V(float* x, size_t n) {
    Sqrt(x, n);
}

void Round_F64_V(double* x, size_t n) {
    Round(x, n);
}

void Round_F32_V(float* x, size_t n) {
    Round(x, n);
}

void Floor_F64_V(double* x, size_t n) {
    Floor(x, n);
}

void Floor_F32_V(float* x, size_t n) {
    Floor(x, n);
}

void Ceil_F64_V(double* x, size_t n) {
    Ceil(x, n);
}

void Ceil_F32_V(float* x, size_t n) {
    Ceil(x, n);
}

// Note: Tail is computed in Go. Using store_partial would generate a memcpy call and
// operator[] an indirect jump. Neither can be translated to avo.

void Pow_4x_F64_V(double* __restrict x, double* __restrict y, size_t n) {
    size_t nsimd = n & size_t(-vsize_double);

    Vec4d vx, vy;
    for (size_t i = 0; i < nsimd; i += vsize_double) {
        vx.load(x + i);
        vy.load(y + i);
        [[clang::always_inline]] vx = pow(vx, vy);
        vx.store(x + i);
    }
}

void Pow_8x_F32_V(float* __restrict x, float* __restrict y, size_t n) {
    size_t nsimd = n & size_t(-vsize_float);

    Vec8f vx, vy;
    for (size_t i = 0; i < nsimd; i += vsize_float) {
        vx.load(x + i);
        vy.load(y + i);
        [[clang::always_inline]] vx = pow(vx, vy);
        vx.store(x + i);
    }
}

void PowNumber_4x_F64_V(double* __restrict x, double y, size_t n) {
    size_t nsimd = n & size_t(-vsize_double);

    Vec4d vx, vy(y);
    for (size_t i = 0; i < nsimd; i += vsize_double) {
        vx.load(x + i);
        [[clang::always_inline]] vx = pow(vx, vy);
        vx.store(x + i);
    }
}

void PowNumber_8x_F32_V(float* __restrict x, float y, size_t n) {
    size_t nsimd = n & size_t(-vsize_float);

    Vec8f vx, vy(y);
    for (size_t i = 0; i < nsimd; i += vsize_float) {
        vx.load(x + i);
        [[clang::always_inline]] vx = pow(vx, vy);
        vx.store(x + i);
    }
}

/*
 * Adapted from https://github.com/JishinMaster/simd_utils
 *
 * Version : 0.2.2
 * Author  : JishinMaster
 * Licence : BSD-2
 */

/* yes I know, the top of this file is quite ugly */
# define ALIGN32_BEG
# define ALIGN32_END __attribute__((aligned(32)))

/* __m128 is ugly to write */
typedef __m256  v8sf; // vector of 8 float (avx)
typedef __m256i v8si; // vector of 8 int   (avx)
typedef __m128i v4si; // vector of 8 int   (avx)

#define ALIGN16_BEG
#define ALIGN16_END __attribute__((aligned(16)))
#define ALIGN32_BEG
#define ALIGN32_END __attribute__((aligned(32)))
#define ALIGN64_BEG
#define ALIGN64_END __attribute__((aligned(64)))

#define AVX_LEN_BYTES 32  // Size of AVX lane
#define AVX_LEN_INT16 16  // number of int16 with an AVX lane
#define AVX_LEN_INT32 8   // number of int32 with an AVX lane
#define AVX_LEN_FLOAT 8   // number of float with an AVX lane
#define AVX_LEN_DOUBLE 4  // number of double with an AVX lane

#define _PI32AVX_CONST(Name, Val)                                            \
  static const ALIGN32_BEG int _pi32avx_##Name[4] ALIGN32_END = { Val, Val, Val, Val }

_PI32AVX_CONST(1, 1);
_PI32AVX_CONST(inv1, ~1);
_PI32AVX_CONST(2, 2);
_PI32AVX_CONST(4, 4);

/* declare some AVX constants -- why can't I figure a better way to do that? */
#define _PS256_CONST(Name, Val)                                            \
  static const ALIGN32_BEG float _ps256_##Name[8] ALIGN32_END = { Val, Val, Val, Val, Val, Val, Val, Val }
#define _PI32_CONST256(Name, Val)                                            \
  static const ALIGN32_BEG int _pi32_256_##Name[8] ALIGN32_END = { Val, Val, Val, Val, Val, Val, Val, Val }
#define _PS256_CONST_TYPE(Name, Type, Val)                                 \
  static const ALIGN32_BEG Type _ps256_##Name[8] ALIGN32_END = { Val, Val, Val, Val, Val, Val, Val, Val }

#define c_cephes_L102A 3.0078125E-1f
#define c_cephes_L102B 2.48745663981195213739E-4f
#define c_cephes_L10EA 4.3359375E-1f
#define c_cephes_L10EB 7.00731903251827651129E-4f

#define INVLN10 0.4342944819032518f  // 0.4342944819f
#define INVLN2 1.4426950408889634f   // 1.44269504089f
#define LN2 0.6931471805599453094172321214581765680755001343602552541206800094f
#define LN2_DIV_LN10 0.3010299956639811952137388947244930267681898814621085413104274611f

/* For log */
_PS256_CONST(cephes_L102A, 3.0078125E-1f);
_PS256_CONST(cephes_L102B, 2.48745663981195213739E-4f);
_PS256_CONST(cephes_L10EA, 4.3359375E-1f);
_PS256_CONST(cephes_L10EB, 7.00731903251827651129E-4f);

_PS256_CONST(cephes_LOG2EA, 0.44269504088896340735992f);

_PS256_CONST(MAXLOGF, 88.72283905206835f);
_PS256_CONST(MAXLOGFDIV2, 44.361419526034176f);
_PS256_CONST(MINLOGF, -103.278929903431851103f);
_PS256_CONST(cephes_exp_minC1, -0.693359375f);
_PS256_CONST(cephes_exp_minC2, 2.12194440e-4f);
_PS256_CONST(0p625, 0.625f);

_PS256_CONST(MAXNUMF, 3.4028234663852885981170418348451692544e38f);

_PS256_CONST(1  , 1.0f);
_PS256_CONST(0p5, 0.5f);
/* the smallest non denormalized float number */
_PS256_CONST_TYPE(min_norm_pos, int, 0x00800000);
_PS256_CONST_TYPE(mant_mask, int, 0x7f800000);
_PS256_CONST_TYPE(inv_mant_mask, int, ~0x7f800000);

_PS256_CONST_TYPE(sign_mask, int, (int)0x80000000);
_PS256_CONST_TYPE(inv_sign_mask, int, ~0x80000000);

_PI32_CONST256(0, 0);
_PI32_CONST256(1, 1);
_PI32_CONST256(inv1, ~1);
_PI32_CONST256(2, 2);
_PI32_CONST256(4, 4);
_PI32_CONST256(0x7f, 0x7f);

_PS256_CONST(cephes_SQRTHF, 0.707106781186547524);
_PS256_CONST(cephes_log_p0, 7.0376836292E-2);
_PS256_CONST(cephes_log_p1, - 1.1514610310E-1);
_PS256_CONST(cephes_log_p2, 1.1676998740E-1);
_PS256_CONST(cephes_log_p3, - 1.2420140846E-1);
_PS256_CONST(cephes_log_p4, + 1.4249322787E-1);
_PS256_CONST(cephes_log_p5, - 1.6668057665E-1);
_PS256_CONST(cephes_log_p6, + 2.0000714765E-1);
_PS256_CONST(cephes_log_p7, - 2.4999993993E-1);
_PS256_CONST(cephes_log_p8, + 3.3333331174E-1);
_PS256_CONST(cephes_log_q1, -2.12194440e-4);
_PS256_CONST(cephes_log_q2, 0.693359375);

/* natural logarithm computed for 8 simultaneous float
   return NaN for x <= 0
*/
inline v8sf log256_ps(v8sf x) {
  v8si imm0;
  v8sf one = *(v8sf*)_ps256_1;

  //v8sf invalid_mask = _mm256_cmple_ps(x, _mm256_setzero_ps());
  v8sf invalid_mask = _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_LE_OS);

  x = _mm256_max_ps(x, *(v8sf*)_ps256_min_norm_pos);  /* cut off denormalized stuff */

  // can be done with AVX2
  imm0 = _mm256_srli_epi32(_mm256_castps_si256(x), 23);

  /* keep only the fractional part */
  x = _mm256_and_ps(x, *(v8sf*)_ps256_inv_mant_mask);
  x = _mm256_or_ps(x, *(v8sf*)_ps256_0p5);

  // this is again another AVX2 instruction
  imm0 = _mm256_sub_epi32(imm0, *(v8si*)_pi32_256_0x7f);
  v8sf e = _mm256_cvtepi32_ps(imm0);

  e = _mm256_add_ps(e, one);

  /* part2:
     if( x < SQRTHF ) {
       e -= 1;
       x = x + x - 1.0;
     } else { x = x - 1.0; }
  */
  //v8sf mask = _mm256_cmplt_ps(x, *(v8sf*)_ps256_cephes_SQRTHF);
  v8sf mask = _mm256_cmp_ps(x, *(v8sf*)_ps256_cephes_SQRTHF, _CMP_LT_OS);
  v8sf tmp = _mm256_and_ps(x, mask);
  x = _mm256_sub_ps(x, one);
  e = _mm256_sub_ps(e, _mm256_and_ps(one, mask));
  x = _mm256_add_ps(x, tmp);

  v8sf z = _mm256_mul_ps(x,x);

  v8sf y = *(v8sf*)_ps256_cephes_log_p0;
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p1);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p2);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p3);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p4);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p5);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p6);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p7);
  y = _mm256_mul_ps(y, x);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_cephes_log_p8);
  y = _mm256_mul_ps(y, x);

  y = _mm256_mul_ps(y, z);

  tmp = _mm256_mul_ps(e, *(v8sf*)_ps256_cephes_log_q1);
  y = _mm256_add_ps(y, tmp);


  tmp = _mm256_mul_ps(z, *(v8sf*)_ps256_0p5);
  y = _mm256_sub_ps(y, tmp);

  tmp = _mm256_mul_ps(e, *(v8sf*)_ps256_cephes_log_q2);
  x = _mm256_add_ps(x, y);
  x = _mm256_add_ps(x, tmp);
  x = _mm256_or_ps(x, invalid_mask); // negative arg will be NAN
  return x;
}

_PS256_CONST(exp_hi,	88.3762626647949f);
_PS256_CONST(exp_lo,	-88.3762626647949f);

_PS256_CONST(cephes_LOG2EF, 1.44269504088896341);
_PS256_CONST(cephes_exp_C1, 0.693359375);
_PS256_CONST(cephes_exp_C2, -2.12194440e-4);

_PS256_CONST(cephes_exp_p0, 1.9875691500E-4);
_PS256_CONST(cephes_exp_p1, 1.3981999507E-3);
_PS256_CONST(cephes_exp_p2, 8.3334519073E-3);
_PS256_CONST(cephes_exp_p3, 4.1665795894E-2);
_PS256_CONST(cephes_exp_p4, 1.6666665459E-1);
_PS256_CONST(cephes_exp_p5, 5.0000001201E-1);

// rewritten alternate version which properly returns MAXNUMF or 0.0 outside of boundaries
inline v8sf exp256_ps_alternate(v8sf x)
{
    v8sf z_tmp, z, fx;
    v8si n;
    v8sf xsupmaxlogf, xinfminglogf;

    xsupmaxlogf = _mm256_cmp_ps(x, *(v8sf *) _ps256_MAXLOGF, _CMP_GT_OS);
    xinfminglogf = _mm256_cmp_ps(x, *(v8sf *) _ps256_MINLOGF, _CMP_LT_OS);

    /* Express e**x = e**g 2**n
     *   = e**g e**( n loge(2) )
     *   = e**( g + n loge(2) )
     */
    fx = _mm256_fmadd_ps(*(v8sf *) _ps256_cephes_LOG2EF, x, *(v8sf *) _ps256_0p5);
    z = _mm256_round_ps(fx, _MM_FROUND_FLOOR);

    x = _mm256_fmadd_ps(z, *(v8sf *) _ps256_cephes_exp_minC1, x);
    x = _mm256_fmadd_ps(z, *(v8sf *) _ps256_cephes_exp_minC2, x);

    n = _mm256_cvttps_epi32(z);
    n = _mm256_add_epi32(n, *(v8si *) _pi32_256_0x7f);
    n = _mm256_slli_epi32(n, 23);
    v8sf pow2n = _mm256_castsi256_ps(n);

    z = _mm256_mul_ps(x, x);

    z_tmp = _mm256_fmadd_ps(*(v8sf *) _ps256_cephes_exp_p0, x, *(v8sf *) _ps256_cephes_exp_p1);
    z_tmp = _mm256_fmadd_ps(z_tmp, x, *(v8sf *) _ps256_cephes_exp_p2);
    z_tmp = _mm256_fmadd_ps(z_tmp, x, *(v8sf *) _ps256_cephes_exp_p3);
    z_tmp = _mm256_fmadd_ps(z_tmp, x, *(v8sf *) _ps256_cephes_exp_p4);
    z_tmp = _mm256_fmadd_ps(z_tmp, x, *(v8sf *) _ps256_cephes_exp_p5);
    z_tmp = _mm256_fmadd_ps(z_tmp, z, x);
    z_tmp = _mm256_add_ps(z_tmp, *(v8sf *) _ps256_1);

    /* build 2^n */
    z_tmp = _mm256_mul_ps(z_tmp, pow2n);

    z = _mm256_blendv_ps(z_tmp, *(v8sf *) _ps256_MAXNUMF, xsupmaxlogf);
    z = _mm256_blendv_ps(z, _mm256_setzero_ps(), xinfminglogf);

    return z;
}

_PS256_CONST(minus_cephes_DP1, -0.78515625);
_PS256_CONST(minus_cephes_DP2, -2.4187564849853515625e-4);
_PS256_CONST(minus_cephes_DP3, -3.77489497744594108e-8);
_PS256_CONST(sincof_p0, -1.9515295891E-4);
_PS256_CONST(sincof_p1,  8.3321608736E-3);
_PS256_CONST(sincof_p2, -1.6666654611E-1);
_PS256_CONST(coscof_p0,  2.443315711809948E-005);
_PS256_CONST(coscof_p1, -1.388731625493765E-003);
_PS256_CONST(coscof_p2,  4.166664568298827E-002);
_PS256_CONST(cephes_FOPI, 1.27323954473516); // 4 / M_PI

inline void sincos256_ps(v8sf x, v8sf *s, v8sf *c) {

  v8sf xmm1, xmm2, xmm3 = _mm256_setzero_ps(), sign_bit_sin, y;
  v8si imm0, imm2, imm4;

  sign_bit_sin = x;
  /* take the absolute value */
  x = _mm256_and_ps(x, *(v8sf*)_ps256_inv_sign_mask);
  /* extract the sign bit (upper one) */
  sign_bit_sin = _mm256_and_ps(sign_bit_sin, *(v8sf*)_ps256_sign_mask);

  /* scale by 4/Pi */
  y = _mm256_mul_ps(x, *(v8sf*)_ps256_cephes_FOPI);

  /* store the integer part of y in imm2 */
  imm2 = _mm256_cvttps_epi32(y);

  /* j=(j+1) & (~1) (see the cephes sources) */
  imm2 = _mm256_add_epi32(imm2, *(v8si*)_pi32_256_1);
  imm2 = _mm256_and_si256(imm2, *(v8si*)_pi32_256_inv1);

  y = _mm256_cvtepi32_ps(imm2);
  imm4 = imm2;

  /* get the swap sign flag for the sine */
  imm0 = _mm256_and_si256(imm2, *(v8si*)_pi32_256_4);
  imm0 = _mm256_slli_epi32(imm0, 29);
  //v8sf swap_sign_bit_sin = _mm256_castsi256_ps(imm0);

  /* get the polynom selection mask for the sine*/
  imm2 = _mm256_and_si256(imm2, *(v8si*)_pi32_256_2);
  imm2 = _mm256_cmpeq_epi32(imm2, *(v8si*)_pi32_256_0);

  //v8sf poly_mask = _mm256_castsi256_ps(imm2);
  v8sf swap_sign_bit_sin = _mm256_castsi256_ps(imm0);
  v8sf poly_mask = _mm256_castsi256_ps(imm2);

  /* The magic pass: "Extended precision modular arithmetic"
     x = ((x - y * DP1) - y * DP2) - y * DP3; */
  xmm1 = *(v8sf*)_ps256_minus_cephes_DP1;
  xmm2 = *(v8sf*)_ps256_minus_cephes_DP2;
  xmm3 = *(v8sf*)_ps256_minus_cephes_DP3;
  xmm1 = _mm256_mul_ps(y, xmm1);
  xmm2 = _mm256_mul_ps(y, xmm2);
  xmm3 = _mm256_mul_ps(y, xmm3);
  x = _mm256_add_ps(x, xmm1);
  x = _mm256_add_ps(x, xmm2);
  x = _mm256_add_ps(x, xmm3);

  imm4 = _mm256_sub_epi32(imm4, *(v8si*)_pi32_256_2);
  imm4 = _mm256_andnot_si256(imm4, *(v8si*)_pi32_256_4);
  imm4 = _mm256_slli_epi32(imm4, 29);

  v8sf sign_bit_cos = _mm256_castsi256_ps(imm4);

  sign_bit_sin = _mm256_xor_ps(sign_bit_sin, swap_sign_bit_sin);

  /* Evaluate the first polynom  (0 <= x <= Pi/4) */
  v8sf z = _mm256_mul_ps(x,x);
  y = *(v8sf*)_ps256_coscof_p0;

  y = _mm256_mul_ps(y, z);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_coscof_p1);
  y = _mm256_mul_ps(y, z);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_coscof_p2);
  y = _mm256_mul_ps(y, z);
  y = _mm256_mul_ps(y, z);
  v8sf tmp = _mm256_mul_ps(z, *(v8sf*)_ps256_0p5);
  y = _mm256_sub_ps(y, tmp);
  y = _mm256_add_ps(y, *(v8sf*)_ps256_1);

  /* Evaluate the second polynom  (Pi/4 <= x <= 0) */

  v8sf y2 = *(v8sf*)_ps256_sincof_p0;
  y2 = _mm256_mul_ps(y2, z);
  y2 = _mm256_add_ps(y2, *(v8sf*)_ps256_sincof_p1);
  y2 = _mm256_mul_ps(y2, z);
  y2 = _mm256_add_ps(y2, *(v8sf*)_ps256_sincof_p2);
  y2 = _mm256_mul_ps(y2, z);
  y2 = _mm256_mul_ps(y2, x);
  y2 = _mm256_add_ps(y2, x);

  /* select the correct result from the two polynoms */
  xmm3 = poly_mask;
  v8sf ysin2 = _mm256_and_ps(xmm3, y2);
  v8sf ysin1 = _mm256_andnot_ps(xmm3, y);
  y2 = _mm256_sub_ps(y2,ysin2);
  y = _mm256_sub_ps(y, ysin1);

  xmm1 = _mm256_add_ps(ysin1,ysin2);
  xmm2 = _mm256_add_ps(y,y2);

  /* update the sign */
  *s = _mm256_xor_ps(xmm1, sign_bit_sin);
  *c = _mm256_xor_ps(xmm2, sign_bit_cos);
}

/* These are for a 24-bit significand: */
static const float minus_cephes_DP1 = -0.78515625f;
static const float minus_cephes_DP2 = -2.4187564849853515625e-4f;
static const float minus_cephes_DP3 = -3.77489497744594108e-8f;
static float lossth = 8192.;

static const float T24M1 = 16777215.f;
static const float FOPI = 1.27323954473516f;
static const float PIO4F = 0.7853981633974483096f;

static const float sincof[] = {-1.9515295891E-4f, 8.3321608736E-3f, -1.6666654611E-1f};
static const float coscof[] = {2.443315711809948E-5f, -1.388731625493765E-3f,
                               4.166664568298827E-2f};

inline int mysincosf(float xx, float *s, float *c)
{
    float x, y, y1, y2, z;
    int j, sign_sin, sign_cos;

    sign_sin = 1;
    sign_cos = 1;

    x = xx;
    if (xx < 0) {
        sign_sin = -1;
        x = -xx;
    }
    if (x > T24M1) {
        return (0.0f);
    }
    j = FOPI * x; /* integer part of x/(PI/4) */
    y = j;
    /* map zeros to origin */
    if (j & 1) {
        j += 1;
        y += 1.0f;
    }
    j &= 7; /* octant modulo 360 degrees */
    /* reflect in x axis */
    if (j > 3) {
        sign_sin = -sign_sin;
        sign_cos = -sign_cos;
        j -= 4;
    }

    if (j > 1)
        sign_cos = -sign_cos;

    if (x > lossth) {
        x = x - y * PIO4F;
    } else {
        /* Extended precision modular arithmetic */
        x = ((x + y * minus_cephes_DP1) + y * minus_cephes_DP2) + y * minus_cephes_DP3;
    }
    /*einits();*/
    z = x * x;

    /* measured relative error in +/- pi/4 is 7.8e-8 */
    y1 = ((coscof[0] * z + coscof[1]) * z + coscof[2]) * z * z;
    y1 -= 0.5f * z;
    y1 += 1.0f;

    /* Theoretical relative error = 3.8e-9 in [-pi/4, +pi/4] */
    y2 = ((sincof[0] * z + sincof[1]) * z + sincof[2]) * z * x;
    y2 += x;

    if ((j == 1) || (j == 2)) {
        *s = y1;
        *c = y2;
    } else {
        *s = y2;
        *c = y1;
    }
    // COS

    /*einitd();*/
    if (sign_sin < 0) {
        *s = -(*s);
    }
    if (sign_cos < 0) {
        *c = -(*c);
    }

    return 0;
}

void Log10_Len8x_F32_V(float* x, size_t n)
{
    const v8sf invln10f = _mm256_set1_ps((float) INVLN10);  //_mm256_broadcast_ss(&invln10f_mask);

    for (size_t i = 0; i < n; i += AVX_LEN_FLOAT) {
        v8sf src_tmp = log256_ps(_mm256_loadu_ps(x + i));
        _mm256_storeu_ps(x + i, _mm256_mul_ps(src_tmp, invln10f));
    }
}

void Log2_Len8x_F32_V(float* x, size_t n)
{
    const v8sf invln2f = _mm256_set1_ps((float) INVLN2);  //_mm256_broadcast_ss(&invln10f_mask);

    for (size_t i = 0; i < n; i += AVX_LEN_FLOAT) {
        v8sf src_tmp = log256_ps(_mm256_loadu_ps(x + i));
        _mm256_storeu_ps(x + i, _mm256_mul_ps(src_tmp, invln2f));
    }
}

void Log_Len8x_F32_V(float* x, size_t n)
{
    for (size_t i = 0; i < n; i += AVX_LEN_FLOAT) {
        _mm256_storeu_ps(x + i, log256_ps(_mm256_loadu_ps(x + i)));
    }
}

void Exp_Len8x_F32_V(float* x, size_t n)
{
    for (size_t i = 0; i < n; i += AVX_LEN_FLOAT) {
        _mm256_storeu_ps(x + i, exp256_ps_alternate(_mm256_loadu_ps(x + i)));
    }
}

void Sin_F32_V(float* x, size_t n) {
    size_t stop_len = n / AVX_LEN_FLOAT;
    stop_len *= AVX_LEN_FLOAT;

    for (size_t i = 0; i < stop_len; i += AVX_LEN_FLOAT) {
        v8sf src_tmp = _mm256_loadu_ps(x + i);
        v8sf dst_sin_tmp;
        v8sf dst_cos_tmp;
        sincos256_ps(src_tmp, &dst_sin_tmp, &dst_cos_tmp);
        _mm256_storeu_ps(x + i, dst_sin_tmp);
    }
    for (size_t i = stop_len; i < n; i++) {
        float dst_cos_tmp;
        mysincosf(x[i], x + i, &dst_cos_tmp);
    }
}

void Cos_F32_V(float* x, size_t n) {
    size_t stop_len = n / AVX_LEN_FLOAT;
    stop_len *= AVX_LEN_FLOAT;

    for (size_t i = 0; i < stop_len; i += AVX_LEN_FLOAT) {
        v8sf src_tmp = _mm256_loadu_ps(x + i);
        v8sf dst_sin_tmp;
        v8sf dst_cos_tmp;
        sincos256_ps(src_tmp, &dst_sin_tmp, &dst_cos_tmp);
        _mm256_storeu_ps(x + i, dst_cos_tmp);
    }
    for (size_t i = stop_len; i < n; i++) {
        float dst_sin_tmp;
        mysincosf(x[i], &dst_sin_tmp, x + i);
    }
}

void SinCos_F32_V(float* dst_sin, float* dst_cos, float* x, size_t n) {
    size_t stop_len = n / AVX_LEN_FLOAT;
    stop_len *= AVX_LEN_FLOAT;

    for (size_t i = 0; i < stop_len; i += AVX_LEN_FLOAT) {
        v8sf src_tmp = _mm256_loadu_ps(x + i);
        v8sf dst_sin_tmp;
        v8sf dst_cos_tmp;
        sincos256_ps(src_tmp, &dst_sin_tmp, &dst_cos_tmp);
        _mm256_storeu_ps(dst_sin + i, dst_sin_tmp);
        _mm256_storeu_ps(dst_cos + i, dst_cos_tmp);
    }
    for (size_t i = stop_len; i < n; i++) {
        mysincosf(x[i], dst_sin + i, dst_cos + i);
    }
}
