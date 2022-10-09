Sqrt_F64_V(double*, unsigned long):                      # @Sqrt_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB0_7
        cmpq    $4, %rsi
        jae     .LBB0_3
        xorl    %eax, %eax
        jmp     .LBB0_6
.LBB0_3:
        movq    %rsi, %rax
        andq    $-4, %rax
        xorl    %ecx, %ecx
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
        vsqrtpd (%rdi,%rcx,8), %ymm0
        vmovupd %ymm0, (%rdi,%rcx,8)
        addq    $4, %rcx
        cmpq    %rcx, %rax
        jne     .LBB0_4
        cmpq    %rsi, %rax
        je      .LBB0_7
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vsqrtsd %xmm0, %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB0_6
.LBB0_7:
        vzeroupper
        retq
.LCPI1_0:
        .long   0xc0400000                      # float -3
.LCPI1_1:
        .long   0xbf000000                      # float -0.5
Sqrt_F32_V(float*, unsigned long):                      # @Sqrt_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB1_7
        cmpq    $32, %rsi
        jae     .LBB1_3
        xorl    %eax, %eax
        jmp     .LBB1_6
.LBB1_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI1_0(%rip), %ymm0   # ymm0 = [-3.0E+0,-3.0E+0,-3.0E+0,-3.0E+0,-3.0E+0,-3.0E+0,-3.0E+0,-3.0E+0]
        vbroadcastss    .LCPI1_1(%rip), %ymm1   # ymm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vxorps  %xmm2, %xmm2, %xmm2
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm3
        vmovups 32(%rdi,%rcx,4), %ymm4
        vmovups 64(%rdi,%rcx,4), %ymm5
        vrsqrtps        %ymm3, %ymm6
        vmovups 96(%rdi,%rcx,4), %ymm7
        vmulps  %ymm6, %ymm3, %ymm8
        vfmadd213ps     %ymm0, %ymm8, %ymm6     # ymm6 = (ymm8 * ymm6) + ymm0
        vmulps  %ymm1, %ymm8, %ymm8
        vmulps  %ymm6, %ymm8, %ymm6
        vrsqrtps        %ymm4, %ymm8
        vcmpneqps       %ymm2, %ymm3, %ymm3
        vandps  %ymm6, %ymm3, %ymm3
        vmulps  %ymm4, %ymm8, %ymm6
        vfmadd213ps     %ymm0, %ymm6, %ymm8     # ymm8 = (ymm6 * ymm8) + ymm0
        vmulps  %ymm1, %ymm6, %ymm6
        vmulps  %ymm6, %ymm8, %ymm6
        vcmpneqps       %ymm2, %ymm4, %ymm4
        vandps  %ymm6, %ymm4, %ymm4
        vrsqrtps        %ymm5, %ymm6
        vmulps  %ymm6, %ymm5, %ymm8
        vfmadd213ps     %ymm0, %ymm8, %ymm6     # ymm6 = (ymm8 * ymm6) + ymm0
        vmulps  %ymm1, %ymm8, %ymm8
        vmulps  %ymm6, %ymm8, %ymm6
        vcmpneqps       %ymm2, %ymm5, %ymm5
        vandps  %ymm6, %ymm5, %ymm5
        vrsqrtps        %ymm7, %ymm6
        vmulps  %ymm6, %ymm7, %ymm8
        vfmadd213ps     %ymm0, %ymm8, %ymm6     # ymm6 = (ymm8 * ymm6) + ymm0
        vmulps  %ymm1, %ymm8, %ymm8
        vmulps  %ymm6, %ymm8, %ymm6
        vcmpneqps       %ymm2, %ymm7, %ymm7
        vandps  %ymm6, %ymm7, %ymm6
        vmovups %ymm3, (%rdi,%rcx,4)
        vmovups %ymm4, 32(%rdi,%rcx,4)
        vmovups %ymm5, 64(%rdi,%rcx,4)
        vmovups %ymm6, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB1_4
        cmpq    %rsi, %rax
        je      .LBB1_7
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vsqrtss %xmm0, %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB1_6
.LBB1_7:
        vzeroupper
        retq
.LCPI2_0:
        .quad   0x8000000000000000              # double -0
.LCPI2_1:
        .quad   0x3fdfffffffffffff              # double 0.49999999999999994
.LCPI2_2:
        .quad   0x8000000000000000              # double -0
        .quad   0x8000000000000000              # double -0
Round_F64_V(double*, unsigned long):                     # @Round_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB2_8
        cmpq    $16, %rsi
        jae     .LBB2_3
        xorl    %eax, %eax
        jmp     .LBB2_6
.LBB2_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
        vbroadcastsd    .LCPI2_0(%rip), %ymm0   # ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
        vbroadcastsd    .LCPI2_1(%rip), %ymm1   # ymm1 = [4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1]
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm2
        vmovupd 32(%rdi,%rcx,8), %ymm3
        vmovupd 64(%rdi,%rcx,8), %ymm4
        vmovupd 96(%rdi,%rcx,8), %ymm5
        vandpd  %ymm0, %ymm2, %ymm6
        vorpd   %ymm1, %ymm6, %ymm6
        vaddpd  %ymm6, %ymm2, %ymm2
        vroundpd        $11, %ymm2, %ymm2
        vandpd  %ymm0, %ymm3, %ymm6
        vorpd   %ymm1, %ymm6, %ymm6
        vaddpd  %ymm6, %ymm3, %ymm3
        vroundpd        $11, %ymm3, %ymm3
        vandpd  %ymm0, %ymm4, %ymm6
        vorpd   %ymm1, %ymm6, %ymm6
        vaddpd  %ymm6, %ymm4, %ymm4
        vroundpd        $11, %ymm4, %ymm4
        vandpd  %ymm0, %ymm5, %ymm6
        vorpd   %ymm1, %ymm6, %ymm6
        vaddpd  %ymm6, %ymm5, %ymm5
        vroundpd        $11, %ymm5, %ymm5
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm5, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB2_4
        cmpq    %rsi, %rax
        je      .LBB2_8
.LBB2_6:
        vmovapd .LCPI2_2(%rip), %xmm0           # xmm0 = [-0.0E+0,-0.0E+0]
        vmovddup        .LCPI2_1(%rip), %xmm1           # xmm1 = [4.9999999999999994E-1,4.9999999999999994E-1]
.LBB2_7:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm2            # xmm2 = mem[0],zero
        vandpd  %xmm0, %xmm2, %xmm3
        vorpd   %xmm1, %xmm3, %xmm3
        vaddsd  %xmm3, %xmm2, %xmm2
        vroundsd        $11, %xmm2, %xmm2, %xmm2
        vmovsd  %xmm2, (%rdi,%rax,8)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB2_7
.LBB2_8:
        vzeroupper
        retq
.LCPI3_0:
        .long   0x80000000                      # float -0
.LCPI3_1:
        .long   0x3effffff                      # float 0.49999997
Round_F32_V(float*, unsigned long):                     # @Round_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB3_8
        cmpq    $32, %rsi
        jae     .LBB3_3
        xorl    %eax, %eax
        jmp     .LBB3_6
.LBB3_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI3_0(%rip), %ymm0   # ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
        vbroadcastss    .LCPI3_1(%rip), %ymm1   # ymm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm2
        vmovups 32(%rdi,%rcx,4), %ymm3
        vmovups 64(%rdi,%rcx,4), %ymm4
        vmovups 96(%rdi,%rcx,4), %ymm5
        vandps  %ymm0, %ymm2, %ymm6
        vorps   %ymm1, %ymm6, %ymm6
        vaddps  %ymm6, %ymm2, %ymm2
        vroundps        $11, %ymm2, %ymm2
        vandps  %ymm0, %ymm3, %ymm6
        vorps   %ymm1, %ymm6, %ymm6
        vaddps  %ymm6, %ymm3, %ymm3
        vroundps        $11, %ymm3, %ymm3
        vandps  %ymm0, %ymm4, %ymm6
        vorps   %ymm1, %ymm6, %ymm6
        vaddps  %ymm6, %ymm4, %ymm4
        vroundps        $11, %ymm4, %ymm4
        vandps  %ymm0, %ymm5, %ymm6
        vorps   %ymm1, %ymm6, %ymm6
        vaddps  %ymm6, %ymm5, %ymm5
        vroundps        $11, %ymm5, %ymm5
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm5, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB3_4
        cmpq    %rsi, %rax
        je      .LBB3_8
.LBB3_6:
        vbroadcastss    .LCPI3_0(%rip), %xmm0   # xmm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
        vbroadcastss    .LCPI3_1(%rip), %xmm1   # xmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
.LBB3_7:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
        vandps  %xmm0, %xmm2, %xmm3
        vorps   %xmm1, %xmm3, %xmm3
        vaddss  %xmm3, %xmm2, %xmm2
        vroundss        $11, %xmm2, %xmm2, %xmm2
        vmovss  %xmm2, (%rdi,%rax,4)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB3_7
.LBB3_8:
        vzeroupper
        retq
Floor_F64_V(double*, unsigned long):                     # @Floor_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB4_7
        cmpq    $16, %rsi
        jae     .LBB4_3
        xorl    %eax, %eax
        jmp     .LBB4_6
.LBB4_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
        vroundpd        $9, (%rdi,%rcx,8), %ymm0
        vroundpd        $9, 32(%rdi,%rcx,8), %ymm1
        vroundpd        $9, 64(%rdi,%rcx,8), %ymm2
        vroundpd        $9, 96(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB4_4
        cmpq    %rsi, %rax
        je      .LBB4_7
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vroundsd        $9, %xmm0, %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB4_6
.LBB4_7:
        vzeroupper
        retq
Floor_F32_V(float*, unsigned long):                     # @Floor_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB5_7
        cmpq    $32, %rsi
        jae     .LBB5_3
        xorl    %eax, %eax
        jmp     .LBB5_6
.LBB5_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
.LBB5_4:                                # =>This Inner Loop Header: Depth=1
        vroundps        $9, (%rdi,%rcx,4), %ymm0
        vroundps        $9, 32(%rdi,%rcx,4), %ymm1
        vroundps        $9, 64(%rdi,%rcx,4), %ymm2
        vroundps        $9, 96(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB5_4
        cmpq    %rsi, %rax
        je      .LBB5_7
.LBB5_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vroundss        $9, %xmm0, %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB5_6
.LBB5_7:
        vzeroupper
        retq
Ceil_F64_V(double*, unsigned long):                      # @Ceil_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB6_7
        cmpq    $16, %rsi
        jae     .LBB6_3
        xorl    %eax, %eax
        jmp     .LBB6_6
.LBB6_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
        vroundpd        $10, (%rdi,%rcx,8), %ymm0
        vroundpd        $10, 32(%rdi,%rcx,8), %ymm1
        vroundpd        $10, 64(%rdi,%rcx,8), %ymm2
        vroundpd        $10, 96(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB6_4
        cmpq    %rsi, %rax
        je      .LBB6_7
.LBB6_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vroundsd        $10, %xmm0, %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB6_6
.LBB6_7:
        vzeroupper
        retq
Ceil_F32_V(float*, unsigned long):                      # @Ceil_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB7_7
        cmpq    $32, %rsi
        jae     .LBB7_3
        xorl    %eax, %eax
        jmp     .LBB7_6
.LBB7_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
        vroundps        $10, (%rdi,%rcx,4), %ymm0
        vroundps        $10, 32(%rdi,%rcx,4), %ymm1
        vroundps        $10, 64(%rdi,%rcx,4), %ymm2
        vroundps        $10, 96(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB7_4
        cmpq    %rsi, %rax
        je      .LBB7_7
.LBB7_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vroundss        $10, %xmm0, %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        incq    %rax
        cmpq    %rax, %rsi
        jne     .LBB7_6
.LBB7_7:
        vzeroupper
        retq
.LCPI8_0:
        .quad   9223372036854775807             # 0x7fffffffffffffff
.LCPI8_3:
        .quad   0x3fe6a09e667f3bcd              # double 0.70710678118654757
.LCPI8_4:
        .quad   0xbff0000000000000              # double -1
.LCPI8_5:
        .quad   0x401a509f46f4fa53              # double 6.5787325942061043
.LCPI8_6:
        .quad   0x3fdfe818a0fe1a83              # double 0.49854102823193375
.LCPI8_7:
        .quad   0x3f07bc0962b395ca              # double 4.5270000862445198E-5
.LCPI8_8:
        .quad   0x404e798eb86c3351              # double 60.94966798098779
.LCPI8_9:
        .quad   0x403de9738b8cb9c9              # double 29.911919328553072
.LCPI8_10:
        .quad   0x40340a202d99830a              # double 20.039553499201283
.LCPI8_11:
        .quad   0x404c8e7597479a10              # double 57.112963590585537
.LCPI8_12:
        .quad   0x4054c30b52213498              # double 83.047565967967216
.LCPI8_13:
        .quad   0x402e20359e903e37              # double 15.062909083469192
.LCPI8_14:
        .quad   0x407351945dc908a5              # double 309.09872225312057
.LCPI8_15:
        .quad   0x406bb86590fcfb56              # double 221.76239823732857
.LCPI8_16:
        .quad   0x404e0f304466448e              # double 60.118660497603841
.LCPI8_17:
        .quad   0x406b0db13e48e066              # double 216.42788614495947
.LCPI8_18:
        .quad   4841369599423283200             # 0x4330000000000000
.LCPI8_19:
        .quad   0xc3300000000003ff              # double -4503599627371519
.LCPI8_20:
        .quad   0x3ff0000000000000              # double 1
.LCPI8_21:
        .quad   0xbfe0000000000000              # double -0.5
.LCPI8_22:
        .quad   0x3fe0000000000000              # double 0.5
.LCPI8_23:
        .quad   0x3ff71547652b82fe              # double 1.4426950408889634
.LCPI8_24:
        .quad   0xbfe62e4000000000              # double -0.693145751953125
.LCPI8_25:
        .quad   0x3eb7f7d1cf79abca              # double 1.4286068203094173E-6
.LCPI8_26:
        .quad   0x3fe62e42fefa39ef              # double 0.69314718055994529
.LCPI8_27:
        .quad   0x3e21eed8eff8d898              # double 2.08767569878681E-9
.LCPI8_28:
        .quad   0x3de6124613a86d09              # double 1.6059043836821613E-10
.LCPI8_29:
        .quad   0x3e927e4fb7789f5c              # double 2.7557319223985888E-7
.LCPI8_30:
        .quad   0x3e5ae64567f544e4              # double 2.505210838544172E-8
.LCPI8_31:
        .quad   0x3efa01a01a01a01a              # double 2.4801587301587302E-5
.LCPI8_32:
        .quad   0x3ec71de3a556c734              # double 2.7557319223985893E-6
.LCPI8_33:
        .quad   0x3f56c16c16c16c17              # double 0.0013888888888888889
.LCPI8_34:
        .quad   0x3f2a01a01a01a01a              # double 1.9841269841269841E-4
.LCPI8_35:
        .quad   0x3fa5555555555555              # double 0.041666666666666664
.LCPI8_36:
        .quad   0x3f81111111111111              # double 0.0083333333333333332
.LCPI8_37:
        .quad   0x3fc5555555555555              # double 0.16666666666666666
.LCPI8_38:
        .quad   2046                            # 0x7fe
.LCPI8_39:
        .quad   0x40a7700000000000              # double 3000
.LCPI8_40:
        .quad   1                               # 0x1
.LCPI8_41:
        .quad   0xc0a7700000000000              # double -3000
.LCPI8_42:
        .quad   9218868437227405312             # 0x7ff0000000000000
.LCPI8_43:
        .quad   0x7ff8002040000000              # double NaN
.LCPI8_1:
        .quad   4503599627370495                # 0xfffffffffffff
        .quad   4503599627370495                # 0xfffffffffffff
.LCPI8_2:
        .quad   4602678819172646912             # 0x3fe0000000000000
        .quad   4602678819172646912             # 0x3fe0000000000000
Pow_4x_F64_V(double*, double*, unsigned long):                  # @Pow_4x_F64_V(double*, double*, unsigned long)
        subq    $1192, %rsp                     # imm = 0x4A8
        andq    $-4, %rdx
        je      .LBB8_11
        xorl    %r8d, %r8d
        vbroadcastsd    .LCPI8_0(%rip), %ymm0   # ymm0 = [9223372036854775807,9223372036854775807,9223372036854775807,9223372036854775807]
        vmovups %ymm0, 512(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_3(%rip), %ymm0   # ymm0 = [7.0710678118654757E-1,7.0710678118654757E-1,7.0710678118654757E-1,7.0710678118654757E-1]
        vmovups %ymm0, 1120(%rsp)               # 32-byte Spill
        vpxor   %xmm6, %xmm6, %xmm6
        vbroadcastsd    .LCPI8_4(%rip), %ymm0   # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, 1088(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI8_5(%rip), %ymm0   # ymm0 = [6.5787325942061043E+0,6.5787325942061043E+0,6.5787325942061043E+0,6.5787325942061043E+0]
        vmovups %ymm0, 1056(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI8_6(%rip), %ymm0   # ymm0 = [4.9854102823193375E-1,4.9854102823193375E-1,4.9854102823193375E-1,4.9854102823193375E-1]
        vmovups %ymm0, 1024(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI8_7(%rip), %ymm0   # ymm0 = [4.5270000862445198E-5,4.5270000862445198E-5,4.5270000862445198E-5,4.5270000862445198E-5]
        vmovups %ymm0, 992(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_8(%rip), %ymm0   # ymm0 = [6.094966798098779E+1,6.094966798098779E+1,6.094966798098779E+1,6.094966798098779E+1]
        vmovups %ymm0, 960(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_9(%rip), %ymm0   # ymm0 = [2.9911919328553072E+1,2.9911919328553072E+1,2.9911919328553072E+1,2.9911919328553072E+1]
        vmovups %ymm0, 928(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_10(%rip), %ymm0  # ymm0 = [2.0039553499201283E+1,2.0039553499201283E+1,2.0039553499201283E+1,2.0039553499201283E+1]
        vmovups %ymm0, 896(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_11(%rip), %ymm0  # ymm0 = [5.7112963590585537E+1,5.7112963590585537E+1,5.7112963590585537E+1,5.7112963590585537E+1]
        vmovups %ymm0, 864(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_12(%rip), %ymm0  # ymm0 = [8.3047565967967216E+1,8.3047565967967216E+1,8.3047565967967216E+1,8.3047565967967216E+1]
        vmovups %ymm0, 832(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_13(%rip), %ymm0  # ymm0 = [1.5062909083469192E+1,1.5062909083469192E+1,1.5062909083469192E+1,1.5062909083469192E+1]
        vmovups %ymm0, 800(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_14(%rip), %ymm0  # ymm0 = [3.0909872225312057E+2,3.0909872225312057E+2,3.0909872225312057E+2,3.0909872225312057E+2]
        vmovups %ymm0, 768(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_15(%rip), %ymm0  # ymm0 = [2.2176239823732857E+2,2.2176239823732857E+2,2.2176239823732857E+2,2.2176239823732857E+2]
        vmovups %ymm0, 736(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_16(%rip), %ymm0  # ymm0 = [6.0118660497603841E+1,6.0118660497603841E+1,6.0118660497603841E+1,6.0118660497603841E+1]
        vmovups %ymm0, 704(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_17(%rip), %ymm0  # ymm0 = [2.1642788614495947E+2,2.1642788614495947E+2,2.1642788614495947E+2,2.1642788614495947E+2]
        vmovups %ymm0, 672(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_18(%rip), %ymm0  # ymm0 = [4841369599423283200,4841369599423283200,4841369599423283200,4841369599423283200]
        vmovups %ymm0, 640(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_19(%rip), %ymm0  # ymm0 = [-4.503599627371519E+15,-4.503599627371519E+15,-4.503599627371519E+15,-4.503599627371519E+15]
        vmovups %ymm0, 608(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_20(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI8_21(%rip), %ymm0  # ymm0 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vmovups %ymm0, 576(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_22(%rip), %ymm0  # ymm0 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
        vmovups %ymm0, 544(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_23(%rip), %ymm0  # ymm0 = [1.4426950408889634E+0,1.4426950408889634E+0,1.4426950408889634E+0,1.4426950408889634E+0]
        vmovups %ymm0, 480(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_24(%rip), %ymm0  # ymm0 = [-6.93145751953125E-1,-6.93145751953125E-1,-6.93145751953125E-1,-6.93145751953125E-1]
        vmovups %ymm0, 448(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_25(%rip), %ymm0  # ymm0 = [1.4286068203094173E-6,1.4286068203094173E-6,1.4286068203094173E-6,1.4286068203094173E-6]
        vmovups %ymm0, 416(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_26(%rip), %ymm0  # ymm0 = [6.9314718055994529E-1,6.9314718055994529E-1,6.9314718055994529E-1,6.9314718055994529E-1]
        vmovups %ymm0, 384(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_27(%rip), %ymm0  # ymm0 = [2.08767569878681E-9,2.08767569878681E-9,2.08767569878681E-9,2.08767569878681E-9]
        vmovups %ymm0, 352(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_28(%rip), %ymm0  # ymm0 = [1.6059043836821613E-10,1.6059043836821613E-10,1.6059043836821613E-10,1.6059043836821613E-10]
        vmovups %ymm0, 320(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_29(%rip), %ymm0  # ymm0 = [2.7557319223985888E-7,2.7557319223985888E-7,2.7557319223985888E-7,2.7557319223985888E-7]
        vmovups %ymm0, 288(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_30(%rip), %ymm0  # ymm0 = [2.505210838544172E-8,2.505210838544172E-8,2.505210838544172E-8,2.505210838544172E-8]
        vmovups %ymm0, 256(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_31(%rip), %ymm0  # ymm0 = [2.4801587301587302E-5,2.4801587301587302E-5,2.4801587301587302E-5,2.4801587301587302E-5]
        vmovups %ymm0, 224(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_32(%rip), %ymm0  # ymm0 = [2.7557319223985893E-6,2.7557319223985893E-6,2.7557319223985893E-6,2.7557319223985893E-6]
        vmovups %ymm0, 192(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_33(%rip), %ymm0  # ymm0 = [1.3888888888888889E-3,1.3888888888888889E-3,1.3888888888888889E-3,1.3888888888888889E-3]
        vmovups %ymm0, 160(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_34(%rip), %ymm0  # ymm0 = [1.9841269841269841E-4,1.9841269841269841E-4,1.9841269841269841E-4,1.9841269841269841E-4]
        vmovups %ymm0, 128(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_35(%rip), %ymm0  # ymm0 = [4.1666666666666664E-2,4.1666666666666664E-2,4.1666666666666664E-2,4.1666666666666664E-2]
        vmovups %ymm0, 96(%rsp)                 # 32-byte Spill
        vbroadcastsd    .LCPI8_36(%rip), %ymm0  # ymm0 = [8.3333333333333332E-3,8.3333333333333332E-3,8.3333333333333332E-3,8.3333333333333332E-3]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastsd    .LCPI8_37(%rip), %ymm0  # ymm0 = [1.6666666666666666E-1,1.6666666666666666E-1,1.6666666666666666E-1,1.6666666666666666E-1]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastsd    .LCPI8_38(%rip), %ymm0  # ymm0 = [2046,2046,2046,2046]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastsd    .LCPI8_39(%rip), %ymm0  # ymm0 = [3.0E+3,3.0E+3,3.0E+3,3.0E+3]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_40(%rip), %ymm0  # ymm0 = [1,1,1,1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI8_41(%rip), %ymm0  # ymm0 = [-3.0E+3,-3.0E+3,-3.0E+3,-3.0E+3]
        vmovupd %ymm0, -96(%rsp)                # 32-byte Spill
        vpbroadcastq    .LCPI8_42(%rip), %ymm5  # ymm5 = [9218868437227405312,9218868437227405312,9218868437227405312,9218868437227405312]
        vbroadcastsd    .LCPI8_42(%rip), %ymm10 # ymm10 = [9218868437227405312,9218868437227405312,9218868437227405312,9218868437227405312]
        jmp     .LBB8_2
.LBB8_10:                               #   in Loop: Header=BB8_2 Depth=1
        vmovupd %ymm2, (%rdi,%r8,8)
        addq    $4, %r8
        cmpq    %rdx, %r8
        jae     .LBB8_11
.LBB8_2:                                # =>This Inner Loop Header: Depth=1
        vmovapd %ymm10, %ymm9
        vmovdqu (%rdi,%r8,8), %ymm13
        vmovupd (%rsi,%r8,8), %ymm12
        vpand   512(%rsp), %ymm13, %ymm10       # 32-byte Folded Reload
        vmovapd .LCPI8_1(%rip), %xmm1           # xmm1 = [4503599627370495,4503599627370495]
        vandpd  (%rdi,%r8,8), %xmm1, %xmm2
        vmovapd .LCPI8_2(%rip), %xmm0           # xmm0 = [4602678819172646912,4602678819172646912]
        vorpd   %xmm0, %xmm2, %xmm2
        vandpd  16(%rdi,%r8,8), %xmm1, %xmm3
        vorpd   %xmm0, %xmm3, %xmm3
        vinsertf128     $1, %xmm3, %ymm2, %ymm3
        vmovupd 1120(%rsp), %ymm0               # 32-byte Reload
        vcmpltpd        %ymm3, %ymm0, %ymm2
        vandnpd %ymm3, %ymm2, %ymm4
        vaddpd  1088(%rsp), %ymm3, %ymm3        # 32-byte Folded Reload
        vaddpd  %ymm4, %ymm3, %ymm4
        vmulpd  %ymm4, %ymm4, %ymm3
        vmulpd  %ymm3, %ymm3, %ymm7
        vmovupd 1024(%rsp), %ymm8               # 32-byte Reload
        vfmadd213pd     1056(%rsp), %ymm4, %ymm8 # 32-byte Folded Reload
        vfmadd231pd     992(%rsp), %ymm3, %ymm8 # 32-byte Folded Reload
        vmovupd 928(%rsp), %ymm11               # 32-byte Reload
        vfmadd213pd     960(%rsp), %ymm4, %ymm11 # 32-byte Folded Reload
        vmovupd 864(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     896(%rsp), %ymm4, %ymm14 # 32-byte Folded Reload
        vfmadd231pd     %ymm11, %ymm3, %ymm14   # ymm14 = (ymm3 * ymm11) + ymm14
        vfmadd231pd     %ymm8, %ymm7, %ymm14    # ymm14 = (ymm7 * ymm8) + ymm14
        vmulpd  %ymm4, %ymm3, %ymm8
        vmulpd  %ymm14, %ymm8, %ymm8
        vaddpd  832(%rsp), %ymm3, %ymm11        # 32-byte Folded Reload
        vfmadd231pd     800(%rsp), %ymm4, %ymm11 # 32-byte Folded Reload
        vmovupd 736(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     768(%rsp), %ymm4, %ymm14 # 32-byte Folded Reload
        vmovupd 672(%rsp), %ymm15               # 32-byte Reload
        vfmadd213pd     704(%rsp), %ymm4, %ymm15 # 32-byte Folded Reload
        vfmadd231pd     %ymm14, %ymm3, %ymm15   # ymm15 = (ymm3 * ymm14) + ymm15
        vfmadd231pd     %ymm11, %ymm7, %ymm15   # ymm15 = (ymm7 * ymm11) + ymm15
        vdivpd  %ymm15, %ymm8, %ymm7
        vmovdqu %ymm10, 1152(%rsp)              # 32-byte Spill
        vpsrlq  $52, %ymm10, %ymm8
        vpor    640(%rsp), %ymm8, %ymm8         # 32-byte Folded Reload
        vaddpd  608(%rsp), %ymm8, %ymm8         # 32-byte Folded Reload
        vmovupd -128(%rsp), %ymm0               # 32-byte Reload
        vandpd  %ymm0, %ymm2, %ymm2
        vaddpd  %ymm2, %ymm8, %ymm8
        vmulpd  %ymm12, %ymm8, %ymm2
        vroundpd        $8, %ymm2, %ymm2
        vfnmadd213pd    %ymm2, %ymm12, %ymm8    # ymm8 = -(ymm12 * ymm8) + ymm2
        vmovupd 576(%rsp), %ymm1                # 32-byte Reload
        vmovapd %ymm1, %ymm11
        vfmadd213pd     %ymm4, %ymm3, %ymm11    # ymm11 = (ymm3 * ymm11) + ymm4
        vaddpd  %ymm7, %ymm11, %ymm11
        vmovupd 544(%rsp), %ymm10               # 32-byte Reload
        vmulpd  %ymm4, %ymm10, %ymm14
        vmulpd  %ymm1, %ymm3, %ymm15
        vfmadd231pd     %ymm14, %ymm4, %ymm15   # ymm15 = (ymm4 * ymm14) + ymm15
        vsubpd  %ymm4, %ymm11, %ymm4
        vfmadd231pd     %ymm3, %ymm10, %ymm4    # ymm4 = (ymm10 * ymm3) + ymm4
        vmovupd 480(%rsp), %ymm1                # 32-byte Reload
        vmulpd  %ymm1, %ymm12, %ymm3
        vmulpd  %ymm3, %ymm11, %ymm3
        vroundpd        $8, %ymm3, %ymm3
        vmulpd  448(%rsp), %ymm3, %ymm14        # 32-byte Folded Reload
        vfmadd231pd     %ymm11, %ymm12, %ymm14  # ymm14 = (ymm12 * ymm11) + ymm14
        vfmsub231pd     416(%rsp), %ymm3, %ymm14 # 32-byte Folded Reload
        vmovupd 384(%rsp), %ymm11               # 32-byte Reload
        vfmadd231pd     %ymm8, %ymm11, %ymm14   # ymm14 = (ymm11 * ymm8) + ymm14
        vsubpd  %ymm7, %ymm15, %ymm7
        vaddpd  %ymm4, %ymm7, %ymm4
        vfnmsub213pd    %ymm14, %ymm12, %ymm4   # ymm4 = -(ymm12 * ymm4) - ymm14
        vmulpd  %ymm1, %ymm4, %ymm7
        vroundpd        $8, %ymm7, %ymm7
        vfnmadd231pd    %ymm11, %ymm7, %ymm4    # ymm4 = -(ymm7 * ymm11) + ymm4
        vmulpd  %ymm4, %ymm4, %ymm8
        vmovupd 320(%rsp), %ymm11               # 32-byte Reload
        vfmadd213pd     352(%rsp), %ymm4, %ymm11 # 32-byte Folded Reload
        vmovupd 256(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     288(%rsp), %ymm4, %ymm14 # 32-byte Folded Reload
        vmovupd 192(%rsp), %ymm15               # 32-byte Reload
        vfmadd213pd     224(%rsp), %ymm4, %ymm15 # 32-byte Folded Reload
        vfmadd231pd     %ymm14, %ymm8, %ymm15   # ymm15 = (ymm8 * ymm14) + ymm15
        vmovupd 128(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     160(%rsp), %ymm4, %ymm14 # 32-byte Folded Reload
        vmovupd 64(%rsp), %ymm1                 # 32-byte Reload
        vfmadd213pd     96(%rsp), %ymm4, %ymm1  # 32-byte Folded Reload
        vfmadd231pd     %ymm14, %ymm8, %ymm1    # ymm1 = (ymm8 * ymm14) + ymm1
        vmovupd 32(%rsp), %ymm14                # 32-byte Reload
        vfmadd213pd     %ymm10, %ymm4, %ymm14   # ymm14 = (ymm4 * ymm14) + ymm10
        vfmadd213pd     %ymm4, %ymm8, %ymm14    # ymm14 = (ymm8 * ymm14) + ymm4
        vmulpd  %ymm8, %ymm8, %ymm4
        vfmadd231pd     %ymm11, %ymm4, %ymm15   # ymm15 = (ymm4 * ymm11) + ymm15
        vfmadd231pd     %ymm1, %ymm4, %ymm14    # ymm14 = (ymm4 * ymm1) + ymm14
        vmulpd  %ymm4, %ymm4, %ymm1
        vfmadd231pd     %ymm15, %ymm1, %ymm14   # ymm14 = (ymm1 * ymm15) + ymm14
        vaddpd  %ymm0, %ymm14, %ymm1
        vaddpd  %ymm2, %ymm3, %ymm2
        vaddpd  %ymm7, %ymm2, %ymm15
        vroundpd        $8, %ymm15, %ymm2
        vcvttsd2si      %xmm2, %r9
        vpermilpd       $1, %xmm2, %xmm3        # xmm3 = xmm2[1,0]
        vcvttsd2si      %xmm3, %rax
        vextractf128    $1, %ymm2, %xmm2
        vcvttsd2si      %xmm2, %rcx
        vmovq   %rcx, %xmm3
        vpermilpd       $1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
        vcvttsd2si      %xmm2, %rcx
        vmovq   %rcx, %xmm2
        vpunpcklqdq     %xmm2, %xmm3, %xmm2     # xmm2 = xmm3[0],xmm2[0]
        vmovq   %r9, %xmm3
        vmovq   %rax, %xmm4
        vpunpcklqdq     %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0]
        vinserti128     $1, %xmm2, %ymm3, %ymm2
        vpsrad  $31, %ymm1, %ymm3
        vpsrad  $20, %ymm1, %ymm4
        vpsrlq  $32, %ymm4, %ymm4
        vpblendd        $170, %ymm3, %ymm4, %ymm3       # ymm3 = ymm4[0],ymm3[1],ymm4[2],ymm3[3],ymm4[4],ymm3[5],ymm4[6],ymm3[7]
        vpaddq  %ymm3, %ymm2, %ymm4
        vpcmpgtq        (%rsp), %ymm4, %ymm3            # 32-byte Folded Reload
        vmovupd -32(%rsp), %ymm0                # 32-byte Reload
        vcmpltpd        %ymm15, %ymm0, %ymm7
        vpor    %ymm7, %ymm3, %ymm3
        vmovdqu -64(%rsp), %ymm0                # 32-byte Reload
        vpcmpgtq        %ymm4, %ymm0, %ymm4
        vcmpltpd        -96(%rsp), %ymm15, %ymm7        # 32-byte Folded Reload
        vpor    %ymm7, %ymm4, %ymm4
        vpsllq  $52, %ymm2, %ymm2
        vpaddq  %ymm1, %ymm2, %ymm2
        vpor    %ymm3, %ymm4, %ymm1
        vptest  %ymm1, %ymm1
        jne     .LBB8_3
        vmovapd %ymm9, %ymm10
        jmp     .LBB8_5
.LBB8_3:                                #   in Loop: Header=BB8_2 Depth=1
        vpandn  %ymm2, %ymm4, %ymm1
        vmovapd %ymm9, %ymm10
        vblendvpd       %ymm3, %ymm9, %ymm1, %ymm2
.LBB8_5:                                #   in Loop: Header=BB8_2 Depth=1
        vpand   %ymm5, %ymm13, %ymm11
        vpcmpeqq        %ymm6, %ymm11, %ymm4
        vpsrad  $31, %ymm13, %ymm1
        vpshufd $245, %ymm1, %ymm7              # ymm7 = ymm1[1,1,3,3,5,5,7,7]
        vcmpltpd        %ymm6, %ymm12, %ymm14
        vcmpeqpd        %ymm6, %ymm12, %ymm3
        vandpd  -128(%rsp), %ymm3, %ymm1        # 32-byte Folded Reload
        vblendvpd       %ymm14, %ymm10, %ymm1, %ymm1
        vblendvpd       %ymm4, %ymm1, %ymm2, %ymm2
        vptest  %ymm7, %ymm7
        jne     .LBB8_7
        vpxor   %xmm7, %xmm7, %xmm7
        jmp     .LBB8_8
.LBB8_7:                                #   in Loop: Header=BB8_2 Depth=1
        vroundpd        $8, %ymm12, %ymm1
        vcmpeqpd        %ymm1, %ymm12, %ymm8
        vcvttsd2si      %xmm1, %r9
        vpermilpd       $1, %xmm1, %xmm10       # xmm10 = xmm1[1,0]
        vcvttsd2si      %xmm10, %rcx
        vextractf128    $1, %ymm1, %xmm1
        vcvttsd2si      %xmm1, %rax
        vxorpd  %xmm10, %xmm10, %xmm10
        vmovq   %rax, %xmm6
        vpermilpd       $1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
        vcvttsd2si      %xmm1, %rax
        vmovq   %rax, %xmm1
        vpunpcklqdq     %xmm1, %xmm6, %xmm1     # xmm1 = xmm6[0],xmm1[0]
        vmovq   %r9, %xmm6
        vmovq   %rcx, %xmm0
        vpunpcklqdq     %xmm0, %xmm6, %xmm0     # xmm0 = xmm6[0],xmm0[0]
        vinserti128     $1, %xmm1, %ymm0, %ymm0
        vpsllq  $63, %ymm0, %ymm0
        vpor    %ymm2, %ymm0, %ymm1
        vcmpeqpd        %ymm10, %ymm13, %ymm6
        vbroadcastsd    .LCPI8_43(%rip), %ymm10 # ymm10 = [NaN,NaN,NaN,NaN]
        vblendvpd       %ymm6, %ymm2, %ymm10, %ymm6
        vmovapd %ymm9, %ymm10
        vblendvpd       %ymm8, %ymm1, %ymm6, %ymm1
        vxorpd  %xmm6, %xmm6, %xmm6
        vblendvpd       %ymm7, %ymm1, %ymm2, %ymm2
        vandpd  %ymm0, %ymm8, %ymm7
.LBB8_8:                                #   in Loop: Header=BB8_2 Depth=1
        vpcmpeqd        %ymm9, %ymm9, %ymm9
        vandpd  %ymm5, %ymm12, %ymm0
        vandpd  %ymm5, %ymm15, %ymm1
        vpcmpeqq        %ymm5, %ymm1, %ymm15
        vpxor   %ymm9, %ymm15, %ymm1
        vpcmpeqq        %ymm5, %ymm0, %ymm8
        vpcmpeqq        %ymm5, %ymm11, %ymm11
        vpxor   %ymm9, %ymm11, %ymm0
        vpandn  %ymm0, %ymm8, %ymm0
        vpor    %ymm4, %ymm1, %ymm1
        vpand   %ymm0, %ymm1, %ymm0
        vptest  %ymm9, %ymm0
        jb      .LBB8_10
        vpxor   %ymm9, %ymm8, %ymm0
        vpandn  %ymm0, %ymm15, %ymm0
        vmovupd -128(%rsp), %ymm8               # 32-byte Reload
        vmovupd 1152(%rsp), %ymm9               # 32-byte Reload
        vcmpeqpd        %ymm8, %ymm9, %ymm1
        vcmpltpd        %ymm9, %ymm8, %ymm4
        vpsrad  $31, %ymm12, %ymm6
        vpxor   %ymm4, %ymm6, %ymm4
        vpxor   %xmm6, %xmm6, %xmm6
        vblendvpd       %ymm4, %ymm10, %ymm6, %ymm4
        vblendvpd       %ymm1, %ymm8, %ymm4, %ymm1
        vblendvpd       %ymm0, %ymm2, %ymm1, %ymm0
        vandpd  %ymm2, %ymm7, %ymm1
        vandpd  %ymm7, %ymm13, %ymm2
        vorpd   %ymm2, %ymm9, %ymm2
        vblendvpd       %ymm14, %ymm1, %ymm2, %ymm1
        vblendvpd       %ymm3, %ymm8, %ymm1, %ymm1
        vblendvpd       %ymm11, %ymm1, %ymm0, %ymm0
        vcmpunordpd     %ymm13, %ymm13, %ymm1
        vcmpunordpd     %ymm12, %ymm12, %ymm2
        vorpd   %ymm1, %ymm2, %ymm1
        vaddpd  %ymm13, %ymm12, %ymm2
        vblendvpd       %ymm1, %ymm2, %ymm0, %ymm2
        jmp     .LBB8_10
.LBB8_11:
        addq    $1192, %rsp                     # imm = 0x4A8
        vzeroupper
        retq
.LCPI9_0:
        .long   2147483647                      # 0x7fffffff
.LCPI9_3:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI9_4:
        .long   0xbf800000                      # float -1
.LCPI9_5:
        .long   0x3def251a                      # float 0.116769984
.LCPI9_6:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI9_7:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI9_8:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI9_9:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI9_10:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI9_11:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI9_12:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI9_13:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI9_15:
        .long   0xcb00007f                      # float -8388735
.LCPI9_16:
        .long   0x3f800000                      # float 1
.LCPI9_17:
        .long   0xbf000000                      # float -0.5
.LCPI9_18:
        .long   0x3f000000                      # float 0.5
.LCPI9_19:
        .long   0x3fb8aa3b                      # float 1.44269502
.LCPI9_20:
        .long   0xbf318000                      # float -0.693359375
.LCPI9_21:
        .long   0xb95e8083                      # float -2.12194442E-4
.LCPI9_22:
        .long   0xbf317218                      # float -0.693147182
.LCPI9_23:
        .long   0x3d2aaaab                      # float 0.0416666679
.LCPI9_24:
        .long   0x3c088889                      # float 0.00833333377
.LCPI9_25:
        .long   0x3ab60b61                      # float 0.00138888892
.LCPI9_26:
        .long   0x39500d01                      # float 1.98412701E-4
.LCPI9_27:
        .long   0x3e2aaaab                      # float 0.166666672
.LCPI9_29:
        .long   254                             # 0xfe
.LCPI9_30:
        .long   0x43960000                      # float 300
.LCPI9_31:
        .long   1                               # 0x1
.LCPI9_32:
        .long   0xc3960000                      # float -300
.LCPI9_33:
        .long   2139095040                      # 0x7f800000
.LCPI9_34:
        .long   0x7fc00102                      # float NaN
.LCPI9_1:
        .quad   36028792732385279               # 0x7fffff007fffff
        .quad   36028792732385279               # 0x7fffff007fffff
.LCPI9_2:
        .quad   4539628425446424576             # 0x3f0000003f000000
        .quad   4539628425446424576             # 0x3f0000003f000000
.LCPI9_14:
        .quad   5404319554102886400             # 0x4b0000004b000000
.LCPI9_28:
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
Pow_8x_F32_V(float*, float*, unsigned long):                  # @Pow_8x_F32_V(float*, float*, unsigned long)
        subq    $872, %rsp                      # imm = 0x368
        andq    $-8, %rdx
        je      .LBB9_12
        xorl    %eax, %eax
        vbroadcastss    .LCPI9_0(%rip), %ymm0   # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, 320(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_3(%rip), %ymm0   # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, 800(%rsp)                # 32-byte Spill
        vpxor   %xmm7, %xmm7, %xmm7
        vbroadcastss    .LCPI9_4(%rip), %ymm0   # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, 768(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_5(%rip), %ymm0   # ymm0 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vmovups %ymm0, 736(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_6(%rip), %ymm0   # ymm0 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vmovups %ymm0, 704(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_7(%rip), %ymm0   # ymm0 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vmovups %ymm0, 672(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_8(%rip), %ymm0   # ymm0 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vmovups %ymm0, 640(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_9(%rip), %ymm0   # ymm0 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vmovups %ymm0, 608(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_10(%rip), %ymm0  # ymm0 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vmovups %ymm0, 576(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_11(%rip), %ymm0  # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vmovups %ymm0, 544(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_12(%rip), %ymm0  # ymm0 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vmovups %ymm0, 512(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_13(%rip), %ymm0  # ymm0 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vmovups %ymm0, 480(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI9_14(%rip), %ymm0  # ymm0 = [5404319554102886400,5404319554102886400,5404319554102886400,5404319554102886400]
        vmovups %ymm0, 448(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_15(%rip), %ymm0  # ymm0 = [-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6]
        vmovups %ymm0, 416(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_16(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI9_17(%rip), %ymm0  # ymm0 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vmovups %ymm0, 384(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_18(%rip), %ymm0  # ymm0 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1]
        vmovups %ymm0, 352(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_19(%rip), %ymm0  # ymm0 = [1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0]
        vmovups %ymm0, 288(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_20(%rip), %ymm0  # ymm0 = [-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1]
        vmovups %ymm0, 256(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_21(%rip), %ymm0  # ymm0 = [-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4]
        vmovups %ymm0, 224(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_22(%rip), %ymm0  # ymm0 = [-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1]
        vmovups %ymm0, 192(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_23(%rip), %ymm0  # ymm0 = [4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2]
        vmovups %ymm0, 160(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_24(%rip), %ymm0  # ymm0 = [8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3]
        vmovups %ymm0, 128(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_25(%rip), %ymm0  # ymm0 = [1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3]
        vmovups %ymm0, 96(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI9_26(%rip), %ymm0  # ymm0 = [1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI9_27(%rip), %ymm0  # ymm0 = [1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI9_29(%rip), %ymm0  # ymm0 = [254,254,254,254,254,254,254,254]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI9_30(%rip), %ymm0  # ymm0 = [3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_31(%rip), %ymm0  # ymm0 = [1,1,1,1,1,1,1,1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI9_32(%rip), %ymm0  # ymm0 = [-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2]
        vmovdqu %ymm0, -96(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI9_33(%rip), %ymm8  # ymm8 = [2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040]
        vbroadcastss    .LCPI9_33(%rip), %ymm12 # ymm12 = [2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040]
        jmp     .LBB9_2
.LBB9_10:                               #   in Loop: Header=BB9_2 Depth=1
        vpxor   %ymm0, %ymm15, %ymm0
        vpandn  %ymm0, %ymm14, %ymm0
        vmovups -128(%rsp), %ymm14              # 32-byte Reload
        vmovups 832(%rsp), %ymm2                # 32-byte Reload
        vcmpeqps        %ymm2, %ymm14, %ymm3
        vcmpltps        %ymm2, %ymm14, %ymm4
        vxorps  %ymm4, %ymm11, %ymm4
        vpxor   %xmm7, %xmm7, %xmm7
        vblendvps       %ymm4, %ymm12, %ymm7, %ymm4
        vblendvps       %ymm3, %ymm14, %ymm4, %ymm3
        vblendvps       %ymm0, %ymm6, %ymm3, %ymm0
        vandps  %ymm6, %ymm10, %ymm3
        vandps  %ymm9, %ymm10, %ymm4
        vorps   %ymm2, %ymm4, %ymm4
        vblendvps       %ymm13, %ymm3, %ymm4, %ymm3
        vblendvps       %ymm1, %ymm14, %ymm3, %ymm1
        vblendvps       %ymm5, %ymm0, %ymm1, %ymm0
        vcmpunordps     %ymm9, %ymm9, %ymm1
        vcmpunordps     %ymm11, %ymm11, %ymm3
        vorps   %ymm1, %ymm3, %ymm1
        vaddps  %ymm9, %ymm11, %ymm3
        vblendvps       %ymm1, %ymm3, %ymm0, %ymm6
        vmovups %ymm6, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rdx, %rax
        jae     .LBB9_12
.LBB9_2:                                # =>This Inner Loop Header: Depth=1
        vmovaps %ymm12, %ymm2
        vmovdqu (%rdi,%rax,4), %ymm9
        vmovups (%rsi,%rax,4), %ymm11
        vpand   320(%rsp), %ymm9, %ymm12        # 32-byte Folded Reload
        vmovaps .LCPI9_1(%rip), %xmm1           # xmm1 = [36028792732385279,36028792732385279]
        vandps  (%rdi,%rax,4), %xmm1, %xmm0
        vmovaps .LCPI9_2(%rip), %xmm3           # xmm3 = [4539628425446424576,4539628425446424576]
        vorps   %xmm3, %xmm0, %xmm0
        vandps  16(%rdi,%rax,4), %xmm1, %xmm1
        vorps   %xmm3, %xmm1, %xmm1
        vinsertf128     $1, %xmm1, %ymm0, %ymm0
        vmovups 800(%rsp), %ymm1                # 32-byte Reload
        vcmpltps        %ymm0, %ymm1, %ymm1
        vandnps %ymm0, %ymm1, %ymm4
        vaddps  768(%rsp), %ymm0, %ymm0         # 32-byte Folded Reload
        vaddps  %ymm4, %ymm0, %ymm4
        vmulps  %ymm4, %ymm4, %ymm6
        vmulps  %ymm6, %ymm6, %ymm0
        vmovups 704(%rsp), %ymm5                # 32-byte Reload
        vfmadd213ps     736(%rsp), %ymm4, %ymm5 # 32-byte Folded Reload
        vmovups 640(%rsp), %ymm10               # 32-byte Reload
        vfmadd213ps     672(%rsp), %ymm4, %ymm10 # 32-byte Folded Reload
        vfmadd231ps     %ymm5, %ymm6, %ymm10    # ymm10 = (ymm6 * ymm5) + ymm10
        vmovups 576(%rsp), %ymm5                # 32-byte Reload
        vfmadd213ps     608(%rsp), %ymm4, %ymm5 # 32-byte Folded Reload
        vmovups 512(%rsp), %ymm13               # 32-byte Reload
        vfmadd213ps     544(%rsp), %ymm4, %ymm13 # 32-byte Folded Reload
        vmulps  %ymm0, %ymm0, %ymm14
        vfmadd132ps     480(%rsp), %ymm13, %ymm14 # 32-byte Folded Reload
        vfmadd231ps     %ymm5, %ymm6, %ymm14    # ymm14 = (ymm6 * ymm5) + ymm14
        vfmadd231ps     %ymm10, %ymm0, %ymm14   # ymm14 = (ymm0 * ymm10) + ymm14
        vmulps  %ymm4, %ymm6, %ymm0
        vmulps  %ymm0, %ymm14, %ymm0
        vmovdqu %ymm12, 832(%rsp)               # 32-byte Spill
        vpsrld  $23, %ymm12, %ymm5
        vpor    448(%rsp), %ymm5, %ymm5         # 32-byte Folded Reload
        vaddps  416(%rsp), %ymm5, %ymm5         # 32-byte Folded Reload
        vmovups -128(%rsp), %ymm3               # 32-byte Reload
        vandps  %ymm3, %ymm1, %ymm1
        vaddps  %ymm1, %ymm5, %ymm5
        vmulps  %ymm5, %ymm11, %ymm1
        vroundps        $8, %ymm1, %ymm1
        vfnmadd213ps    %ymm1, %ymm11, %ymm5    # ymm5 = -(ymm11 * ymm5) + ymm1
        vmovups 384(%rsp), %ymm14               # 32-byte Reload
        vmovaps %ymm14, %ymm10
        vfmadd213ps     %ymm4, %ymm6, %ymm10    # ymm10 = (ymm6 * ymm10) + ymm4
        vaddps  %ymm0, %ymm10, %ymm10
        vmovups 352(%rsp), %ymm12               # 32-byte Reload
        vmulps  %ymm4, %ymm12, %ymm13
        vmulps  %ymm6, %ymm14, %ymm14
        vfmadd231ps     %ymm13, %ymm4, %ymm14   # ymm14 = (ymm4 * ymm13) + ymm14
        vsubps  %ymm4, %ymm10, %ymm4
        vfmadd231ps     %ymm6, %ymm12, %ymm4    # ymm4 = (ymm12 * ymm6) + ymm4
        vmovups 288(%rsp), %ymm15               # 32-byte Reload
        vmulps  %ymm15, %ymm11, %ymm6
        vmulps  %ymm6, %ymm10, %ymm6
        vroundps        $8, %ymm6, %ymm6
        vmulps  256(%rsp), %ymm6, %ymm13        # 32-byte Folded Reload
        vfmadd231ps     %ymm10, %ymm11, %ymm13  # ymm13 = (ymm11 * ymm10) + ymm13
        vfnmadd231ps    224(%rsp), %ymm6, %ymm13 # 32-byte Folded Reload
        vsubps  %ymm0, %ymm14, %ymm0
        vaddps  %ymm4, %ymm0, %ymm0
        vmovups 192(%rsp), %ymm10               # 32-byte Reload
        vmulps  %ymm5, %ymm10, %ymm4
        vfnmadd231ps    %ymm0, %ymm11, %ymm4    # ymm4 = -(ymm11 * ymm0) + ymm4
        vaddps  %ymm4, %ymm13, %ymm0
        vmulps  %ymm0, %ymm15, %ymm4
        vroundps        $8, %ymm4, %ymm4
        vfmadd231ps     %ymm10, %ymm4, %ymm0    # ymm0 = (ymm4 * ymm10) + ymm0
        vmulps  %ymm0, %ymm0, %ymm5
        vmulps  %ymm5, %ymm5, %ymm10
        vmovups 64(%rsp), %ymm13                # 32-byte Reload
        vfmadd213ps     96(%rsp), %ymm0, %ymm13 # 32-byte Folded Reload
        vmovups 32(%rsp), %ymm14                # 32-byte Reload
        vfmadd213ps     %ymm12, %ymm0, %ymm14   # ymm14 = (ymm0 * ymm14) + ymm12
        vfmadd231ps     %ymm13, %ymm10, %ymm14  # ymm14 = (ymm10 * ymm13) + ymm14
        vmovups 128(%rsp), %ymm10               # 32-byte Reload
        vfmadd213ps     160(%rsp), %ymm0, %ymm10 # 32-byte Folded Reload
        vfmadd231ps     %ymm10, %ymm5, %ymm14   # ymm14 = (ymm5 * ymm10) + ymm14
        vaddps  %ymm3, %ymm0, %ymm10
        vfmadd231ps     %ymm14, %ymm5, %ymm10   # ymm10 = (ymm5 * ymm14) + ymm10
        vaddps  %ymm1, %ymm6, %ymm0
        vaddps  %ymm4, %ymm0, %ymm14
        vcvtps2dq       %ymm14, %ymm4
        vpsrld  $23, %ymm10, %ymm0
        vpand   .LCPI9_28(%rip), %ymm0, %ymm0
        vpaddd  %ymm4, %ymm0, %ymm0
        vpcmpgtd        (%rsp), %ymm0, %ymm1            # 32-byte Folded Reload
        vmovups -32(%rsp), %ymm3                # 32-byte Reload
        vcmpltps        %ymm14, %ymm3, %ymm5
        vpor    %ymm5, %ymm1, %ymm1
        vmovdqu -64(%rsp), %ymm3                # 32-byte Reload
        vpcmpgtd        %ymm0, %ymm3, %ymm0
        vcmpltps        -96(%rsp), %ymm14, %ymm5        # 32-byte Folded Reload
        vpor    %ymm5, %ymm0, %ymm0
        vpslld  $23, %ymm4, %ymm4
        vpaddd  %ymm4, %ymm10, %ymm6
        vpor    %ymm1, %ymm0, %ymm4
        vtestps %ymm4, %ymm4
        jne     .LBB9_3
        vpcmpeqd        %ymm15, %ymm15, %ymm15
        vmovaps %ymm2, %ymm12
        jmp     .LBB9_5
.LBB9_3:                                #   in Loop: Header=BB9_2 Depth=1
        vpandn  %ymm6, %ymm0, %ymm0
        vmovaps %ymm2, %ymm12
        vblendvps       %ymm1, %ymm2, %ymm0, %ymm6
        vpcmpeqd        %ymm15, %ymm15, %ymm15
.LBB9_5:                                #   in Loop: Header=BB9_2 Depth=1
        vpand   %ymm8, %ymm9, %ymm5
        vpcmpeqd        %ymm7, %ymm5, %ymm4
        vcmpltps        %ymm7, %ymm11, %ymm13
        vcmpeqps        %ymm7, %ymm11, %ymm1
        vandps  -128(%rsp), %ymm1, %ymm0        # 32-byte Folded Reload
        vblendvps       %ymm13, %ymm12, %ymm0, %ymm0
        vblendvps       %ymm4, %ymm0, %ymm6, %ymm6
        vmovmskps       %ymm9, %ecx
        testl   %ecx, %ecx
        jne     .LBB9_7
        vxorps  %xmm10, %xmm10, %xmm10
        jmp     .LBB9_8
.LBB9_7:                                #   in Loop: Header=BB9_2 Depth=1
        vroundps        $8, %ymm11, %ymm0
        vcmpeqps        %ymm0, %ymm11, %ymm0
        vcvtps2dq       %ymm11, %ymm10
        vpslld  $31, %ymm10, %ymm10
        vpor    %ymm6, %ymm10, %ymm12
        vpxor   %xmm3, %xmm3, %xmm3
        vcmpeqps        %ymm3, %ymm9, %ymm7
        vbroadcastss    .LCPI9_34(%rip), %ymm3  # ymm3 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
        vblendvps       %ymm7, %ymm6, %ymm3, %ymm3
        vblendvps       %ymm0, %ymm12, %ymm3, %ymm3
        vmovaps %ymm2, %ymm12
        vpsrad  $31, %ymm9, %ymm7
        vblendvps       %ymm7, %ymm3, %ymm6, %ymm6
        vandps  %ymm0, %ymm10, %ymm10
.LBB9_8:                                #   in Loop: Header=BB9_2 Depth=1
        vpcmpeqd        %ymm5, %ymm8, %ymm0
        vpxor   %ymm0, %ymm15, %ymm5
        vandps  %ymm8, %ymm11, %ymm0
        vandps  %ymm8, %ymm14, %ymm3
        vpcmpeqd        %ymm3, %ymm8, %ymm14
        vpxor   %ymm15, %ymm14, %ymm3
        vpcmpeqd        %ymm0, %ymm8, %ymm0
        vpandn  %ymm5, %ymm0, %ymm7
        vpor    %ymm4, %ymm3, %ymm3
        vpand   %ymm7, %ymm3, %ymm3
        vtestps %ymm15, %ymm3
        jae     .LBB9_10
        vpxor   %xmm7, %xmm7, %xmm7
        vmovups %ymm6, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rdx, %rax
        jb      .LBB9_2
.LBB9_12:
        addq    $872, %rsp                      # imm = 0x368
        vzeroupper
        retq
.LCPI10_0:
        .quad   0x3ff71547652b82fe              # double 1.4426950408889634
.LCPI10_1:
        .quad   9218868437227405312             # 0x7ff0000000000000
.LCPI10_2:
        .quad   0x3ff0000000000000              # double 1
.LCPI10_3:
        .quad   9223372036854775807             # 0x7fffffffffffffff
.LCPI10_6:
        .quad   0x3fe6a09e667f3bcd              # double 0.70710678118654757
.LCPI10_7:
        .quad   0xbff0000000000000              # double -1
.LCPI10_8:
        .quad   0x401a509f46f4fa53              # double 6.5787325942061043
.LCPI10_9:
        .quad   0x3fdfe818a0fe1a83              # double 0.49854102823193375
.LCPI10_10:
        .quad   0x3f07bc0962b395ca              # double 4.5270000862445198E-5
.LCPI10_11:
        .quad   0x404e798eb86c3351              # double 60.94966798098779
.LCPI10_12:
        .quad   0x403de9738b8cb9c9              # double 29.911919328553072
.LCPI10_13:
        .quad   0x40340a202d99830a              # double 20.039553499201283
.LCPI10_14:
        .quad   0x404c8e7597479a10              # double 57.112963590585537
.LCPI10_15:
        .quad   0x4054c30b52213498              # double 83.047565967967216
.LCPI10_16:
        .quad   0x402e20359e903e37              # double 15.062909083469192
.LCPI10_17:
        .quad   0x407351945dc908a5              # double 309.09872225312057
.LCPI10_18:
        .quad   0x406bb86590fcfb56              # double 221.76239823732857
.LCPI10_19:
        .quad   0x404e0f304466448e              # double 60.118660497603841
.LCPI10_20:
        .quad   0x406b0db13e48e066              # double 216.42788614495947
.LCPI10_21:
        .quad   4841369599423283200             # 0x4330000000000000
.LCPI10_22:
        .quad   0xc3300000000003ff              # double -4503599627371519
.LCPI10_23:
        .quad   0xbfe0000000000000              # double -0.5
.LCPI10_24:
        .quad   0x3fe0000000000000              # double 0.5
.LCPI10_25:
        .quad   0xbfe62e4000000000              # double -0.693145751953125
.LCPI10_26:
        .quad   0x3eb7f7d1cf79abca              # double 1.4286068203094173E-6
.LCPI10_27:
        .quad   0x3fe62e42fefa39ef              # double 0.69314718055994529
.LCPI10_28:
        .quad   0x3e21eed8eff8d898              # double 2.08767569878681E-9
.LCPI10_29:
        .quad   0x3de6124613a86d09              # double 1.6059043836821613E-10
.LCPI10_30:
        .quad   0x3e927e4fb7789f5c              # double 2.7557319223985888E-7
.LCPI10_31:
        .quad   0x3e5ae64567f544e4              # double 2.505210838544172E-8
.LCPI10_32:
        .quad   0x3efa01a01a01a01a              # double 2.4801587301587302E-5
.LCPI10_33:
        .quad   0x3ec71de3a556c734              # double 2.7557319223985893E-6
.LCPI10_34:
        .quad   0x3f56c16c16c16c17              # double 0.0013888888888888889
.LCPI10_35:
        .quad   0x3f2a01a01a01a01a              # double 1.9841269841269841E-4
.LCPI10_36:
        .quad   0x3fa5555555555555              # double 0.041666666666666664
.LCPI10_37:
        .quad   0x3f81111111111111              # double 0.0083333333333333332
.LCPI10_38:
        .quad   0x3fc5555555555555              # double 0.16666666666666666
.LCPI10_39:
        .quad   2046                            # 0x7fe
.LCPI10_40:
        .quad   0x40a7700000000000              # double 3000
.LCPI10_41:
        .quad   1                               # 0x1
.LCPI10_42:
        .quad   0xc0a7700000000000              # double -3000
.LCPI10_43:
        .quad   0x7ff8002040000000              # double NaN
.LCPI10_4:
        .quad   4503599627370495                # 0xfffffffffffff
        .quad   4503599627370495                # 0xfffffffffffff
.LCPI10_5:
        .quad   4602678819172646912             # 0x3fe0000000000000
        .quad   4602678819172646912             # 0x3fe0000000000000
PowNumber_4x_F64_V(double*, double, unsigned long):             # @PowNumber_4x_F64_V(double*, double, unsigned long)
        subq    $1352, %rsp                     # imm = 0x548
        andq    $-4, %rsi
        je      .LBB10_10
        vbroadcastsd    %xmm0, %ymm0
        vbroadcastsd    .LCPI10_0(%rip), %ymm1  # ymm1 = [1.4426950408889634E+0,1.4426950408889634E+0,1.4426950408889634E+0,1.4426950408889634E+0]
        vbroadcastsd    .LCPI10_1(%rip), %ymm2  # ymm2 = [9218868437227405312,9218868437227405312,9218868437227405312,9218868437227405312]
        vmovupd %ymm1, 1312(%rsp)               # 32-byte Spill
        vmulpd  %ymm1, %ymm0, %ymm1
        vmovupd %ymm1, 1280(%rsp)               # 32-byte Spill
        vandpd  %ymm2, %ymm0, %ymm1
        vmovupd %ymm1, 1248(%rsp)               # 32-byte Spill
        vxorpd  %xmm1, %xmm1, %xmm1
        vcmpltpd        %ymm1, %ymm0, %ymm3
        vcmpeqpd        %ymm1, %ymm0, %ymm4
        vbroadcastsd    .LCPI10_2(%rip), %ymm1  # ymm1 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovupd %ymm4, -64(%rsp)                # 32-byte Spill
        vandpd  %ymm1, %ymm4, %ymm1
        vbroadcastsd    .LCPI10_1(%rip), %ymm4  # ymm4 = [9218868437227405312,9218868437227405312,9218868437227405312,9218868437227405312]
        vmovupd %ymm3, -32(%rsp)                # 32-byte Spill
        vmovupd %ymm4, -128(%rsp)               # 32-byte Spill
        vblendvpd       %ymm3, %ymm4, %ymm1, %ymm1
        vmovupd %ymm1, 1216(%rsp)               # 32-byte Spill
        vpsrad  $31, %ymm0, %ymm1
        vpshufd $245, %ymm1, %ymm1              # ymm1 = ymm1[1,1,3,3,5,5,7,7]
        vmovdqu %ymm1, -96(%rsp)                # 32-byte Spill
        xorl    %r8d, %r8d
        vbroadcastsd    .LCPI10_3(%rip), %ymm1  # ymm1 = [9223372036854775807,9223372036854775807,9223372036854775807,9223372036854775807]
        vmovups %ymm1, 1184(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI10_6(%rip), %ymm1  # ymm1 = [7.0710678118654757E-1,7.0710678118654757E-1,7.0710678118654757E-1,7.0710678118654757E-1]
        vmovups %ymm1, 1152(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI10_7(%rip), %ymm1  # ymm1 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm1, 1120(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI10_8(%rip), %ymm1  # ymm1 = [6.5787325942061043E+0,6.5787325942061043E+0,6.5787325942061043E+0,6.5787325942061043E+0]
        vmovups %ymm1, 1088(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI10_9(%rip), %ymm1  # ymm1 = [4.9854102823193375E-1,4.9854102823193375E-1,4.9854102823193375E-1,4.9854102823193375E-1]
        vmovups %ymm1, 1056(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI10_10(%rip), %ymm1 # ymm1 = [4.5270000862445198E-5,4.5270000862445198E-5,4.5270000862445198E-5,4.5270000862445198E-5]
        vmovups %ymm1, 1024(%rsp)               # 32-byte Spill
        vbroadcastsd    .LCPI10_11(%rip), %ymm1 # ymm1 = [6.094966798098779E+1,6.094966798098779E+1,6.094966798098779E+1,6.094966798098779E+1]
        vmovups %ymm1, 992(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_12(%rip), %ymm1 # ymm1 = [2.9911919328553072E+1,2.9911919328553072E+1,2.9911919328553072E+1,2.9911919328553072E+1]
        vmovups %ymm1, 960(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_13(%rip), %ymm1 # ymm1 = [2.0039553499201283E+1,2.0039553499201283E+1,2.0039553499201283E+1,2.0039553499201283E+1]
        vmovups %ymm1, 928(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_14(%rip), %ymm1 # ymm1 = [5.7112963590585537E+1,5.7112963590585537E+1,5.7112963590585537E+1,5.7112963590585537E+1]
        vmovups %ymm1, 896(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_15(%rip), %ymm1 # ymm1 = [8.3047565967967216E+1,8.3047565967967216E+1,8.3047565967967216E+1,8.3047565967967216E+1]
        vmovups %ymm1, 864(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_16(%rip), %ymm1 # ymm1 = [1.5062909083469192E+1,1.5062909083469192E+1,1.5062909083469192E+1,1.5062909083469192E+1]
        vmovups %ymm1, 832(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_17(%rip), %ymm1 # ymm1 = [3.0909872225312057E+2,3.0909872225312057E+2,3.0909872225312057E+2,3.0909872225312057E+2]
        vmovups %ymm1, 800(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_18(%rip), %ymm1 # ymm1 = [2.2176239823732857E+2,2.2176239823732857E+2,2.2176239823732857E+2,2.2176239823732857E+2]
        vmovups %ymm1, 768(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_19(%rip), %ymm1 # ymm1 = [6.0118660497603841E+1,6.0118660497603841E+1,6.0118660497603841E+1,6.0118660497603841E+1]
        vmovups %ymm1, 736(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_20(%rip), %ymm1 # ymm1 = [2.1642788614495947E+2,2.1642788614495947E+2,2.1642788614495947E+2,2.1642788614495947E+2]
        vmovups %ymm1, 704(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_21(%rip), %ymm1 # ymm1 = [4841369599423283200,4841369599423283200,4841369599423283200,4841369599423283200]
        vmovups %ymm1, 672(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_22(%rip), %ymm1 # ymm1 = [-4.503599627371519E+15,-4.503599627371519E+15,-4.503599627371519E+15,-4.503599627371519E+15]
        vmovups %ymm1, 640(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_2(%rip), %ymm13 # ymm13 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastsd    .LCPI10_23(%rip), %ymm1 # ymm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vmovups %ymm1, 608(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_24(%rip), %ymm1 # ymm1 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
        vmovups %ymm1, 576(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_25(%rip), %ymm1 # ymm1 = [-6.93145751953125E-1,-6.93145751953125E-1,-6.93145751953125E-1,-6.93145751953125E-1]
        vmovups %ymm1, 544(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_26(%rip), %ymm1 # ymm1 = [1.4286068203094173E-6,1.4286068203094173E-6,1.4286068203094173E-6,1.4286068203094173E-6]
        vmovups %ymm1, 512(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_27(%rip), %ymm1 # ymm1 = [6.9314718055994529E-1,6.9314718055994529E-1,6.9314718055994529E-1,6.9314718055994529E-1]
        vmovups %ymm1, 480(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_28(%rip), %ymm1 # ymm1 = [2.08767569878681E-9,2.08767569878681E-9,2.08767569878681E-9,2.08767569878681E-9]
        vmovups %ymm1, 448(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_29(%rip), %ymm1 # ymm1 = [1.6059043836821613E-10,1.6059043836821613E-10,1.6059043836821613E-10,1.6059043836821613E-10]
        vmovups %ymm1, 416(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_30(%rip), %ymm1 # ymm1 = [2.7557319223985888E-7,2.7557319223985888E-7,2.7557319223985888E-7,2.7557319223985888E-7]
        vmovups %ymm1, 384(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_31(%rip), %ymm1 # ymm1 = [2.505210838544172E-8,2.505210838544172E-8,2.505210838544172E-8,2.505210838544172E-8]
        vmovups %ymm1, 352(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_32(%rip), %ymm1 # ymm1 = [2.4801587301587302E-5,2.4801587301587302E-5,2.4801587301587302E-5,2.4801587301587302E-5]
        vmovups %ymm1, 320(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_33(%rip), %ymm1 # ymm1 = [2.7557319223985893E-6,2.7557319223985893E-6,2.7557319223985893E-6,2.7557319223985893E-6]
        vmovups %ymm1, 288(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_34(%rip), %ymm1 # ymm1 = [1.3888888888888889E-3,1.3888888888888889E-3,1.3888888888888889E-3,1.3888888888888889E-3]
        vmovups %ymm1, 256(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_35(%rip), %ymm1 # ymm1 = [1.9841269841269841E-4,1.9841269841269841E-4,1.9841269841269841E-4,1.9841269841269841E-4]
        vmovups %ymm1, 224(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_36(%rip), %ymm1 # ymm1 = [4.1666666666666664E-2,4.1666666666666664E-2,4.1666666666666664E-2,4.1666666666666664E-2]
        vmovups %ymm1, 192(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_37(%rip), %ymm1 # ymm1 = [8.3333333333333332E-3,8.3333333333333332E-3,8.3333333333333332E-3,8.3333333333333332E-3]
        vmovups %ymm1, 160(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_38(%rip), %ymm1 # ymm1 = [1.6666666666666666E-1,1.6666666666666666E-1,1.6666666666666666E-1,1.6666666666666666E-1]
        vmovups %ymm1, 128(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI10_39(%rip), %ymm1 # ymm1 = [2046,2046,2046,2046]
        vmovups %ymm1, 96(%rsp)                 # 32-byte Spill
        vbroadcastsd    .LCPI10_40(%rip), %ymm1 # ymm1 = [3.0E+3,3.0E+3,3.0E+3,3.0E+3]
        vmovups %ymm1, 64(%rsp)                 # 32-byte Spill
        vbroadcastsd    .LCPI10_41(%rip), %ymm1 # ymm1 = [1,1,1,1]
        vmovups %ymm1, 32(%rsp)                 # 32-byte Spill
        vbroadcastsd    .LCPI10_42(%rip), %ymm1 # ymm1 = [-3.0E+3,-3.0E+3,-3.0E+3,-3.0E+3]
        vmovupd %ymm1, (%rsp)                   # 32-byte Spill
        jmp     .LBB10_2
.LBB10_9:                               #   in Loop: Header=BB10_2 Depth=1
        vmovupd %ymm6, (%rdi,%r8,8)
        addq    $4, %r8
        cmpq    %rsi, %r8
        jae     .LBB10_10
.LBB10_2:                               # =>This Inner Loop Header: Depth=1
        vmovdqu (%rdi,%r8,8), %ymm15
        vmovapd .LCPI10_4(%rip), %xmm1          # xmm1 = [4503599627370495,4503599627370495]
        vandpd  (%rdi,%r8,8), %xmm1, %xmm3
        vmovapd .LCPI10_5(%rip), %xmm5          # xmm5 = [4602678819172646912,4602678819172646912]
        vorpd   %xmm5, %xmm3, %xmm3
        vandpd  16(%rdi,%r8,8), %xmm1, %xmm4
        vorpd   %xmm5, %xmm4, %xmm4
        vinsertf128     $1, %xmm4, %ymm3, %ymm3
        vmovupd 1152(%rsp), %ymm1               # 32-byte Reload
        vcmpltpd        %ymm3, %ymm1, %ymm6
        vandnpd %ymm3, %ymm6, %ymm4
        vaddpd  1120(%rsp), %ymm3, %ymm3        # 32-byte Folded Reload
        vaddpd  %ymm4, %ymm3, %ymm8
        vmulpd  %ymm8, %ymm8, %ymm4
        vmulpd  %ymm4, %ymm4, %ymm3
        vmovupd 1056(%rsp), %ymm7               # 32-byte Reload
        vfmadd213pd     1088(%rsp), %ymm8, %ymm7 # 32-byte Folded Reload
        vfmadd231pd     1024(%rsp), %ymm4, %ymm7 # 32-byte Folded Reload
        vmovupd 960(%rsp), %ymm9                # 32-byte Reload
        vfmadd213pd     992(%rsp), %ymm8, %ymm9 # 32-byte Folded Reload
        vmovupd 896(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     928(%rsp), %ymm8, %ymm14 # 32-byte Folded Reload
        vfmadd231pd     %ymm9, %ymm4, %ymm14    # ymm14 = (ymm4 * ymm9) + ymm14
        vfmadd231pd     %ymm7, %ymm3, %ymm14    # ymm14 = (ymm3 * ymm7) + ymm14
        vmulpd  %ymm4, %ymm8, %ymm7
        vmulpd  %ymm7, %ymm14, %ymm7
        vaddpd  864(%rsp), %ymm4, %ymm9         # 32-byte Folded Reload
        vfmadd231pd     832(%rsp), %ymm8, %ymm9 # 32-byte Folded Reload
        vmovupd 768(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     800(%rsp), %ymm8, %ymm14 # 32-byte Folded Reload
        vmovupd 704(%rsp), %ymm11               # 32-byte Reload
        vfmadd213pd     736(%rsp), %ymm8, %ymm11 # 32-byte Folded Reload
        vfmadd231pd     %ymm14, %ymm4, %ymm11   # ymm11 = (ymm4 * ymm14) + ymm11
        vfmadd231pd     %ymm9, %ymm3, %ymm11    # ymm11 = (ymm3 * ymm9) + ymm11
        vdivpd  %ymm11, %ymm7, %ymm7
        vpand   1184(%rsp), %ymm15, %ymm12      # 32-byte Folded Reload
        vpsrlq  $52, %ymm12, %ymm9
        vpor    672(%rsp), %ymm9, %ymm9         # 32-byte Folded Reload
        vaddpd  640(%rsp), %ymm9, %ymm9         # 32-byte Folded Reload
        vandpd  %ymm6, %ymm13, %ymm6
        vaddpd  %ymm6, %ymm9, %ymm9
        vmulpd  %ymm0, %ymm9, %ymm6
        vroundpd        $8, %ymm6, %ymm6
        vfnmadd213pd    %ymm6, %ymm0, %ymm9     # ymm9 = -(ymm0 * ymm9) + ymm6
        vmovupd 608(%rsp), %ymm1                # 32-byte Reload
        vmovapd %ymm1, %ymm11
        vfmadd213pd     %ymm8, %ymm4, %ymm11    # ymm11 = (ymm4 * ymm11) + ymm8
        vaddpd  %ymm7, %ymm11, %ymm11
        vmovupd 576(%rsp), %ymm3                # 32-byte Reload
        vmulpd  %ymm3, %ymm8, %ymm14
        vmulpd  %ymm1, %ymm4, %ymm10
        vfmadd231pd     %ymm14, %ymm8, %ymm10   # ymm10 = (ymm8 * ymm14) + ymm10
        vsubpd  %ymm8, %ymm11, %ymm8
        vfmadd231pd     %ymm4, %ymm3, %ymm8     # ymm8 = (ymm3 * ymm4) + ymm8
        vmulpd  1280(%rsp), %ymm11, %ymm4       # 32-byte Folded Reload
        vroundpd        $8, %ymm4, %ymm4
        vmulpd  544(%rsp), %ymm4, %ymm14        # 32-byte Folded Reload
        vfmadd231pd     %ymm11, %ymm0, %ymm14   # ymm14 = (ymm0 * ymm11) + ymm14
        vfmsub231pd     512(%rsp), %ymm4, %ymm14 # 32-byte Folded Reload
        vmovupd 480(%rsp), %ymm1                # 32-byte Reload
        vfmadd231pd     %ymm9, %ymm1, %ymm14    # ymm14 = (ymm1 * ymm9) + ymm14
        vsubpd  %ymm7, %ymm10, %ymm7
        vaddpd  %ymm7, %ymm8, %ymm7
        vfnmsub213pd    %ymm14, %ymm0, %ymm7    # ymm7 = -(ymm0 * ymm7) - ymm14
        vmulpd  1312(%rsp), %ymm7, %ymm8        # 32-byte Folded Reload
        vroundpd        $8, %ymm8, %ymm8
        vfnmadd231pd    %ymm1, %ymm8, %ymm7     # ymm7 = -(ymm8 * ymm1) + ymm7
        vmulpd  %ymm7, %ymm7, %ymm9
        vmovupd 416(%rsp), %ymm10               # 32-byte Reload
        vfmadd213pd     448(%rsp), %ymm7, %ymm10 # 32-byte Folded Reload
        vmovupd 352(%rsp), %ymm11               # 32-byte Reload
        vfmadd213pd     384(%rsp), %ymm7, %ymm11 # 32-byte Folded Reload
        vmovupd 288(%rsp), %ymm14               # 32-byte Reload
        vfmadd213pd     320(%rsp), %ymm7, %ymm14 # 32-byte Folded Reload
        vfmadd231pd     %ymm11, %ymm9, %ymm14   # ymm14 = (ymm9 * ymm11) + ymm14
        vmovupd 224(%rsp), %ymm11               # 32-byte Reload
        vfmadd213pd     256(%rsp), %ymm7, %ymm11 # 32-byte Folded Reload
        vmovupd 160(%rsp), %ymm5                # 32-byte Reload
        vfmadd213pd     192(%rsp), %ymm7, %ymm5 # 32-byte Folded Reload
        vfmadd231pd     %ymm11, %ymm9, %ymm5    # ymm5 = (ymm9 * ymm11) + ymm5
        vmovupd 128(%rsp), %ymm11               # 32-byte Reload
        vfmadd213pd     %ymm3, %ymm7, %ymm11    # ymm11 = (ymm7 * ymm11) + ymm3
        vfmadd213pd     %ymm7, %ymm9, %ymm11    # ymm11 = (ymm9 * ymm11) + ymm7
        vmulpd  %ymm9, %ymm9, %ymm7
        vfmadd231pd     %ymm10, %ymm7, %ymm14   # ymm14 = (ymm7 * ymm10) + ymm14
        vfmadd231pd     %ymm5, %ymm7, %ymm11    # ymm11 = (ymm7 * ymm5) + ymm11
        vmulpd  %ymm7, %ymm7, %ymm5
        vfmadd231pd     %ymm14, %ymm5, %ymm11   # ymm11 = (ymm5 * ymm14) + ymm11
        vaddpd  %ymm13, %ymm11, %ymm5
        vaddpd  %ymm6, %ymm4, %ymm4
        vaddpd  %ymm4, %ymm8, %ymm14
        vroundpd        $8, %ymm14, %ymm4
        vcvttsd2si      %xmm4, %rcx
        vpermilpd       $1, %xmm4, %xmm6        # xmm6 = xmm4[1,0]
        vcvttsd2si      %xmm6, %rdx
        vextractf128    $1, %ymm4, %xmm4
        vcvttsd2si      %xmm4, %rax
        vmovq   %rax, %xmm6
        vpermilpd       $1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
        vcvttsd2si      %xmm4, %rax
        vmovq   %rax, %xmm4
        vpunpcklqdq     %xmm4, %xmm6, %xmm4     # xmm4 = xmm6[0],xmm4[0]
        vmovq   %rcx, %xmm6
        vmovq   %rdx, %xmm7
        vpunpcklqdq     %xmm7, %xmm6, %xmm6     # xmm6 = xmm6[0],xmm7[0]
        vinserti128     $1, %xmm4, %ymm6, %ymm6
        vpsrad  $31, %ymm5, %ymm4
        vpsrad  $20, %ymm5, %ymm7
        vpsrlq  $32, %ymm7, %ymm7
        vpblendd        $170, %ymm4, %ymm7, %ymm4       # ymm4 = ymm7[0],ymm4[1],ymm7[2],ymm4[3],ymm7[4],ymm4[5],ymm7[6],ymm4[7]
        vpaddq  %ymm4, %ymm6, %ymm7
        vpcmpgtq        96(%rsp), %ymm7, %ymm4          # 32-byte Folded Reload
        vmovupd 64(%rsp), %ymm1                 # 32-byte Reload
        vcmpltpd        %ymm14, %ymm1, %ymm8
        vpor    %ymm4, %ymm8, %ymm4
        vmovdqu 32(%rsp), %ymm1                 # 32-byte Reload
        vpcmpgtq        %ymm7, %ymm1, %ymm7
        vcmpltpd        (%rsp), %ymm14, %ymm8           # 32-byte Folded Reload
        vpor    %ymm7, %ymm8, %ymm7
        vpsllq  $52, %ymm6, %ymm6
        vpaddq  %ymm5, %ymm6, %ymm6
        vpor    %ymm4, %ymm7, %ymm5
        vptest  %ymm5, %ymm5
        je      .LBB10_4
        vpandn  %ymm6, %ymm7, %ymm5
        vblendvpd       %ymm4, -128(%rsp), %ymm5, %ymm6 # 32-byte Folded Reload
.LBB10_4:                               #   in Loop: Header=BB10_2 Depth=1
        vxorpd  %xmm11, %xmm11, %xmm11
        vpand   %ymm2, %ymm15, %ymm4
        vpcmpeqq        %ymm11, %ymm4, %ymm8
        vpsrad  $31, %ymm15, %ymm5
        vpshufd $245, %ymm5, %ymm9              # ymm9 = ymm5[1,1,3,3,5,5,7,7]
        vblendvpd       %ymm8, 1216(%rsp), %ymm6, %ymm6 # 32-byte Folded Reload
        vptest  %ymm9, %ymm9
        jne     .LBB10_6
        vpxor   %xmm9, %xmm9, %xmm9
        jmp     .LBB10_7
.LBB10_6:                               #   in Loop: Header=BB10_2 Depth=1
        vroundpd        $8, %ymm0, %ymm5
        vcmpeqpd        %ymm0, %ymm5, %ymm7
        vcvttsd2si      %xmm5, %rax
        vpermilpd       $1, %xmm5, %xmm1        # xmm1 = xmm5[1,0]
        vcvttsd2si      %xmm1, %rcx
        vextractf128    $1, %ymm5, %xmm1
        vcvttsd2si      %xmm1, %rdx
        vmovq   %rdx, %xmm5
        vpermilpd       $1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
        vcvttsd2si      %xmm1, %rdx
        vmovq   %rdx, %xmm1
        vpunpcklqdq     %xmm1, %xmm5, %xmm1     # xmm1 = xmm5[0],xmm1[0]
        vmovq   %rax, %xmm5
        vmovq   %rcx, %xmm3
        vpunpcklqdq     %xmm3, %xmm5, %xmm3     # xmm3 = xmm5[0],xmm3[0]
        vinserti128     $1, %xmm1, %ymm3, %ymm1
        vpsllq  $63, %ymm1, %ymm1
        vpor    %ymm6, %ymm1, %ymm3
        vcmpeqpd        %ymm11, %ymm15, %ymm5
        vbroadcastsd    .LCPI10_43(%rip), %ymm10 # ymm10 = [NaN,NaN,NaN,NaN]
        vblendvpd       %ymm5, %ymm6, %ymm10, %ymm5
        vblendvpd       %ymm7, %ymm3, %ymm5, %ymm3
        vblendvpd       %ymm9, %ymm3, %ymm6, %ymm6
        vandpd  %ymm1, %ymm7, %ymm9
.LBB10_7:                               #   in Loop: Header=BB10_2 Depth=1
        vandpd  %ymm2, %ymm14, %ymm1
        vpcmpeqq        %ymm2, %ymm1, %ymm14
        vpcmpeqd        %ymm5, %ymm5, %ymm5
        vpxor   %ymm5, %ymm14, %ymm1
        vpcmpeqq        %ymm2, %ymm4, %ymm4
        vpcmpeqq        1248(%rsp), %ymm2, %ymm3        # 32-byte Folded Reload
        vpxor   %ymm5, %ymm3, %ymm7
        vpandn  %ymm7, %ymm4, %ymm3
        vpor    %ymm1, %ymm8, %ymm1
        vpand   %ymm3, %ymm1, %ymm1
        vptest  %ymm5, %ymm1
        jb      .LBB10_9
        vpandn  %ymm7, %ymm14, %ymm1
        vcmpeqpd        %ymm13, %ymm12, %ymm3
        vcmpltpd        %ymm12, %ymm13, %ymm5
        vxorpd  -96(%rsp), %ymm5, %ymm5         # 32-byte Folded Reload
        vblendvpd       %ymm5, -128(%rsp), %ymm11, %ymm5 # 32-byte Folded Reload
        vblendvpd       %ymm3, %ymm13, %ymm5, %ymm3
        vblendvpd       %ymm1, %ymm6, %ymm3, %ymm1
        vandpd  %ymm6, %ymm9, %ymm3
        vandpd  %ymm15, %ymm9, %ymm5
        vorpd   %ymm5, %ymm12, %ymm5
        vmovupd -32(%rsp), %ymm6                # 32-byte Reload
        vblendvpd       %ymm6, %ymm3, %ymm5, %ymm3
        vmovupd -64(%rsp), %ymm5                # 32-byte Reload
        vblendvpd       %ymm5, %ymm13, %ymm3, %ymm3
        vblendvpd       %ymm4, %ymm3, %ymm1, %ymm1
        vcmpunordpd     %ymm15, %ymm15, %ymm3
        vcmpunordpd     %ymm0, %ymm0, %ymm4
        vorpd   %ymm3, %ymm4, %ymm3
        vaddpd  %ymm0, %ymm15, %ymm4
        vblendvpd       %ymm3, %ymm4, %ymm1, %ymm6
        jmp     .LBB10_9
.LBB10_10:
        addq    $1352, %rsp                     # imm = 0x548
        vzeroupper
        retq
.LCPI11_0:
        .long   0x3fb8aa3b                      # float 1.44269502
.LCPI11_1:
        .long   2139095040                      # 0x7f800000
.LCPI11_2:
        .long   0x3f800000                      # float 1
.LCPI11_3:
        .long   2147483647                      # 0x7fffffff
.LCPI11_6:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI11_7:
        .long   0xbf800000                      # float -1
.LCPI11_8:
        .long   0x3def251a                      # float 0.116769984
.LCPI11_9:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI11_10:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI11_11:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI11_12:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI11_13:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI11_14:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI11_15:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI11_16:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI11_18:
        .long   0xcb00007f                      # float -8388735
.LCPI11_19:
        .long   0xbf000000                      # float -0.5
.LCPI11_20:
        .long   0x3f000000                      # float 0.5
.LCPI11_21:
        .long   0xbf318000                      # float -0.693359375
.LCPI11_22:
        .long   0xb95e8083                      # float -2.12194442E-4
.LCPI11_23:
        .long   0xbf317218                      # float -0.693147182
.LCPI11_24:
        .long   0x3d2aaaab                      # float 0.0416666679
.LCPI11_25:
        .long   0x3c088889                      # float 0.00833333377
.LCPI11_26:
        .long   0x3ab60b61                      # float 0.00138888892
.LCPI11_27:
        .long   0x39500d01                      # float 1.98412701E-4
.LCPI11_28:
        .long   0x3e2aaaab                      # float 0.166666672
.LCPI11_30:
        .long   254                             # 0xfe
.LCPI11_31:
        .long   0x43960000                      # float 300
.LCPI11_32:
        .long   1                               # 0x1
.LCPI11_33:
        .long   0xc3960000                      # float -300
.LCPI11_34:
        .long   0x7fc00102                      # float NaN
.LCPI11_4:
        .quad   36028792732385279               # 0x7fffff007fffff
        .quad   36028792732385279               # 0x7fffff007fffff
.LCPI11_5:
        .quad   4539628425446424576             # 0x3f0000003f000000
        .quad   4539628425446424576             # 0x3f0000003f000000
.LCPI11_17:
        .quad   5404319554102886400             # 0x4b0000004b000000
.LCPI11_29:
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   255                             # 0xff
        .byte   0                               # 0x0
        .byte   0                               # 0x0
        .byte   0                               # 0x0
PowNumber_8x_F32_V(float*, float, unsigned long):             # @PowNumber_8x_F32_V(float*, float, unsigned long)
        subq    $1000, %rsp                     # imm = 0x3E8
        andq    $-8, %rsi
        je      .LBB11_11
        vbroadcastss    %xmm0, %ymm0
        vbroadcastss    .LCPI11_0(%rip), %ymm14 # ymm14 = [1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0]
        vmulps  %ymm0, %ymm14, %ymm1
        vmovups %ymm1, 384(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_1(%rip), %ymm3  # ymm3 = [2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040]
        vxorps  %xmm15, %xmm15, %xmm15
        vcmpltps        %ymm15, %ymm0, %ymm2
        vcmpeqps        %ymm0, %ymm15, %ymm4
        vbroadcastss    .LCPI11_2(%rip), %ymm1  # ymm1 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm4, -64(%rsp)                # 32-byte Spill
        vandps  %ymm1, %ymm4, %ymm1
        vbroadcastss    .LCPI11_1(%rip), %ymm4  # ymm4 = [2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040,2139095040]
        vmovups %ymm2, -32(%rsp)                # 32-byte Spill
        vmovups %ymm4, -128(%rsp)               # 32-byte Spill
        vblendvps       %ymm2, %ymm4, %ymm1, %ymm1
        vmovups %ymm1, 960(%rsp)                # 32-byte Spill
        vandps  %ymm3, %ymm0, %ymm1
        vmovups %ymm1, 928(%rsp)                # 32-byte Spill
        vpsrad  $31, %ymm0, %ymm1
        vmovdqu %ymm1, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_3(%rip), %ymm1  # ymm1 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm1, 896(%rsp)                # 32-byte Spill
        xorl    %eax, %eax
        vbroadcastss    .LCPI11_6(%rip), %ymm1  # ymm1 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm1, 864(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_7(%rip), %ymm1  # ymm1 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm1, 832(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_8(%rip), %ymm1  # ymm1 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vmovups %ymm1, 800(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_9(%rip), %ymm1  # ymm1 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vmovups %ymm1, 768(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_10(%rip), %ymm1 # ymm1 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vmovups %ymm1, 736(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_11(%rip), %ymm1 # ymm1 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vmovups %ymm1, 704(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_12(%rip), %ymm1 # ymm1 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vmovups %ymm1, 672(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_13(%rip), %ymm1 # ymm1 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vmovups %ymm1, 640(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_14(%rip), %ymm1 # ymm1 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vmovups %ymm1, 608(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_15(%rip), %ymm1 # ymm1 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vmovups %ymm1, 576(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_16(%rip), %ymm1 # ymm1 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vmovups %ymm1, 544(%rsp)                # 32-byte Spill
        vbroadcastsd    .LCPI11_17(%rip), %ymm1 # ymm1 = [5404319554102886400,5404319554102886400,5404319554102886400,5404319554102886400]
        vmovups %ymm1, 512(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_18(%rip), %ymm1 # ymm1 = [-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6,-8.388735E+6]
        vmovups %ymm1, 480(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_2(%rip), %ymm11 # ymm11 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI11_19(%rip), %ymm1 # ymm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vmovups %ymm1, 448(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_20(%rip), %ymm1 # ymm1 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1]
        vmovups %ymm1, 416(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_21(%rip), %ymm1 # ymm1 = [-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1]
        vmovups %ymm1, 352(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_22(%rip), %ymm1 # ymm1 = [-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4,-2.12194442E-4]
        vmovups %ymm1, 320(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_23(%rip), %ymm1 # ymm1 = [-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1,-6.93147182E-1]
        vmovups %ymm1, 288(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_24(%rip), %ymm1 # ymm1 = [4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2,4.16666679E-2]
        vmovups %ymm1, 256(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_25(%rip), %ymm1 # ymm1 = [8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3,8.33333377E-3]
        vmovups %ymm1, 224(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_26(%rip), %ymm1 # ymm1 = [1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3,1.38888892E-3]
        vmovups %ymm1, 192(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_27(%rip), %ymm1 # ymm1 = [1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4,1.98412701E-4]
        vmovups %ymm1, 160(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_28(%rip), %ymm1 # ymm1 = [1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1,1.66666672E-1]
        vmovups %ymm1, 128(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_30(%rip), %ymm1 # ymm1 = [254,254,254,254,254,254,254,254]
        vmovups %ymm1, 96(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI11_31(%rip), %ymm1 # ymm1 = [3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2,3.0E+2]
        vmovups %ymm1, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI11_32(%rip), %ymm1 # ymm1 = [1,1,1,1,1,1,1,1]
        vmovups %ymm1, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI11_33(%rip), %ymm1 # ymm1 = [-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2,-3.0E+2]
        vmovups %ymm1, (%rsp)                   # 32-byte Spill
        jmp     .LBB11_2
.LBB11_9:                               #   in Loop: Header=BB11_2 Depth=1
        vpxor   %ymm6, %ymm12, %ymm5
        vpandn  %ymm5, %ymm4, %ymm4
        vcmpeqps        %ymm1, %ymm11, %ymm5
        vcmpltps        %ymm1, %ymm11, %ymm6
        vxorps  -96(%rsp), %ymm6, %ymm6         # 32-byte Folded Reload
        vxorps  %xmm15, %xmm15, %xmm15
        vblendvps       %ymm6, -128(%rsp), %ymm15, %ymm6 # 32-byte Folded Reload
        vblendvps       %ymm5, %ymm11, %ymm6, %ymm5
        vblendvps       %ymm4, %ymm2, %ymm5, %ymm4
        vandps  %ymm2, %ymm9, %ymm2
        vandps  %ymm7, %ymm9, %ymm5
        vorps   %ymm1, %ymm5, %ymm1
        vmovups -32(%rsp), %ymm5                # 32-byte Reload
        vblendvps       %ymm5, %ymm2, %ymm1, %ymm1
        vmovups -64(%rsp), %ymm2                # 32-byte Reload
        vblendvps       %ymm2, %ymm11, %ymm1, %ymm1
        vblendvps       %ymm8, %ymm4, %ymm1, %ymm1
        vcmpunordps     %ymm7, %ymm7, %ymm2
        vcmpunordps     %ymm0, %ymm0, %ymm4
        vorps   %ymm2, %ymm4, %ymm2
        vaddps  %ymm0, %ymm7, %ymm4
        vblendvps       %ymm2, %ymm4, %ymm1, %ymm2
        vmovups %ymm2, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jae     .LBB11_11
.LBB11_2:                               # =>This Inner Loop Header: Depth=1
        vmovdqu (%rdi,%rax,4), %ymm7
        vmovaps .LCPI11_4(%rip), %xmm4          # xmm4 = [36028792732385279,36028792732385279]
        vandps  (%rdi,%rax,4), %xmm4, %xmm2
        vpand   896(%rsp), %ymm7, %ymm1         # 32-byte Folded Reload
        vmovaps .LCPI11_5(%rip), %xmm5          # xmm5 = [4539628425446424576,4539628425446424576]
        vorps   %xmm5, %xmm2, %xmm2
        vandps  16(%rdi,%rax,4), %xmm4, %xmm4
        vorps   %xmm5, %xmm4, %xmm4
        vinsertf128     $1, %xmm4, %ymm2, %ymm2
        vmovups 864(%rsp), %ymm4                # 32-byte Reload
        vcmpltps        %ymm2, %ymm4, %ymm6
        vandnps %ymm2, %ymm6, %ymm4
        vaddps  832(%rsp), %ymm2, %ymm2         # 32-byte Folded Reload
        vaddps  %ymm4, %ymm2, %ymm5
        vmulps  %ymm5, %ymm5, %ymm4
        vmulps  %ymm4, %ymm4, %ymm2
        vmovups 768(%rsp), %ymm8                # 32-byte Reload
        vfmadd213ps     800(%rsp), %ymm5, %ymm8 # 32-byte Folded Reload
        vmovups 704(%rsp), %ymm9                # 32-byte Reload
        vfmadd213ps     736(%rsp), %ymm5, %ymm9 # 32-byte Folded Reload
        vfmadd231ps     %ymm8, %ymm4, %ymm9     # ymm9 = (ymm4 * ymm8) + ymm9
        vmovups 640(%rsp), %ymm8                # 32-byte Reload
        vfmadd213ps     672(%rsp), %ymm5, %ymm8 # 32-byte Folded Reload
        vmovups 576(%rsp), %ymm10               # 32-byte Reload
        vfmadd213ps     608(%rsp), %ymm5, %ymm10 # 32-byte Folded Reload
        vmulps  %ymm2, %ymm2, %ymm13
        vfmadd132ps     544(%rsp), %ymm10, %ymm13 # 32-byte Folded Reload
        vfmadd231ps     %ymm8, %ymm4, %ymm13    # ymm13 = (ymm4 * ymm8) + ymm13
        vfmadd231ps     %ymm9, %ymm2, %ymm13    # ymm13 = (ymm2 * ymm9) + ymm13
        vmulps  %ymm5, %ymm4, %ymm2
        vmulps  %ymm2, %ymm13, %ymm8
        vpsrld  $23, %ymm1, %ymm2
        vpor    512(%rsp), %ymm2, %ymm2         # 32-byte Folded Reload
        vaddps  480(%rsp), %ymm2, %ymm2         # 32-byte Folded Reload
        vandps  %ymm6, %ymm11, %ymm6
        vaddps  %ymm6, %ymm2, %ymm6
        vmulps  %ymm0, %ymm6, %ymm2
        vroundps        $8, %ymm2, %ymm2
        vfnmadd213ps    %ymm2, %ymm0, %ymm6     # ymm6 = -(ymm0 * ymm6) + ymm2
        vmovups 448(%rsp), %ymm13               # 32-byte Reload
        vmovaps %ymm13, %ymm9
        vfmadd213ps     %ymm5, %ymm4, %ymm9     # ymm9 = (ymm4 * ymm9) + ymm5
        vaddps  %ymm9, %ymm8, %ymm9
        vmovups 416(%rsp), %ymm12               # 32-byte Reload
        vmulps  %ymm5, %ymm12, %ymm10
        vmulps  %ymm4, %ymm13, %ymm13
        vfmadd231ps     %ymm10, %ymm5, %ymm13   # ymm13 = (ymm5 * ymm10) + ymm13
        vsubps  %ymm5, %ymm9, %ymm5
        vfmadd231ps     %ymm4, %ymm12, %ymm5    # ymm5 = (ymm12 * ymm4) + ymm5
        vmulps  384(%rsp), %ymm9, %ymm4         # 32-byte Folded Reload
        vroundps        $8, %ymm4, %ymm4
        vmulps  352(%rsp), %ymm4, %ymm10        # 32-byte Folded Reload
        vfmadd231ps     %ymm9, %ymm0, %ymm10    # ymm10 = (ymm0 * ymm9) + ymm10
        vfnmadd231ps    320(%rsp), %ymm4, %ymm10 # 32-byte Folded Reload
        vsubps  %ymm8, %ymm13, %ymm8
        vaddps  %ymm5, %ymm8, %ymm5
        vmovups 288(%rsp), %ymm8                # 32-byte Reload
        vmulps  %ymm6, %ymm8, %ymm6
        vfnmadd231ps    %ymm5, %ymm0, %ymm6     # ymm6 = -(ymm0 * ymm5) + ymm6
        vaddps  %ymm6, %ymm10, %ymm5
        vmulps  %ymm5, %ymm14, %ymm6
        vroundps        $8, %ymm6, %ymm6
        vfmadd231ps     %ymm8, %ymm6, %ymm5     # ymm5 = (ymm6 * ymm8) + ymm5
        vmulps  %ymm5, %ymm5, %ymm8
        vmulps  %ymm8, %ymm8, %ymm9
        vmovups 160(%rsp), %ymm10               # 32-byte Reload
        vfmadd213ps     192(%rsp), %ymm5, %ymm10 # 32-byte Folded Reload
        vmovups 128(%rsp), %ymm13               # 32-byte Reload
        vfmadd213ps     %ymm12, %ymm5, %ymm13   # ymm13 = (ymm5 * ymm13) + ymm12
        vfmadd231ps     %ymm10, %ymm9, %ymm13   # ymm13 = (ymm9 * ymm10) + ymm13
        vmovups 224(%rsp), %ymm9                # 32-byte Reload
        vfmadd213ps     256(%rsp), %ymm5, %ymm9 # 32-byte Folded Reload
        vfmadd231ps     %ymm9, %ymm8, %ymm13    # ymm13 = (ymm8 * ymm9) + ymm13
        vaddps  %ymm5, %ymm11, %ymm9
        vfmadd231ps     %ymm13, %ymm8, %ymm9    # ymm9 = (ymm8 * ymm13) + ymm9
        vaddps  %ymm2, %ymm4, %ymm2
        vaddps  %ymm6, %ymm2, %ymm4
        vcvtps2dq       %ymm4, %ymm2
        vpsrld  $23, %ymm9, %ymm5
        vpand   .LCPI11_29(%rip), %ymm5, %ymm5
        vpaddd  %ymm2, %ymm5, %ymm6
        vpcmpgtd        96(%rsp), %ymm6, %ymm5          # 32-byte Folded Reload
        vmovups 64(%rsp), %ymm8                 # 32-byte Reload
        vcmpltps        %ymm4, %ymm8, %ymm8
        vpor    %ymm5, %ymm8, %ymm5
        vmovdqu 32(%rsp), %ymm8                 # 32-byte Reload
        vpcmpgtd        %ymm6, %ymm8, %ymm6
        vcmpltps        (%rsp), %ymm4, %ymm8            # 32-byte Folded Reload
        vpor    %ymm6, %ymm8, %ymm6
        vpslld  $23, %ymm2, %ymm2
        vpaddd  %ymm2, %ymm9, %ymm2
        vpor    %ymm5, %ymm6, %ymm8
        vtestps %ymm8, %ymm8
        je      .LBB11_4
        vpandn  %ymm2, %ymm6, %ymm2
        vblendvps       %ymm5, -128(%rsp), %ymm2, %ymm2 # 32-byte Folded Reload
.LBB11_4:                               #   in Loop: Header=BB11_2 Depth=1
        vpand   %ymm3, %ymm7, %ymm8
        vpcmpeqd        %ymm15, %ymm8, %ymm5
        vblendvps       %ymm5, 960(%rsp), %ymm2, %ymm2 # 32-byte Folded Reload
        vmovmskps       %ymm7, %ecx
        testl   %ecx, %ecx
        jne     .LBB11_6
        vxorps  %xmm9, %xmm9, %xmm9
        jmp     .LBB11_7
.LBB11_6:                               #   in Loop: Header=BB11_2 Depth=1
        vroundps        $8, %ymm0, %ymm6
        vcmpeqps        %ymm0, %ymm6, %ymm6
        vcvtps2dq       %ymm0, %ymm9
        vpslld  $31, %ymm9, %ymm9
        vpor    %ymm2, %ymm9, %ymm10
        vcmpeqps        %ymm7, %ymm15, %ymm13
        vmovaps %ymm14, %ymm12
        vbroadcastss    .LCPI11_34(%rip), %ymm14 # ymm14 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
        vblendvps       %ymm13, %ymm2, %ymm14, %ymm13
        vmovaps %ymm12, %ymm14
        vblendvps       %ymm6, %ymm10, %ymm13, %ymm10
        vpsrad  $31, %ymm7, %ymm13
        vblendvps       %ymm13, %ymm10, %ymm2, %ymm2
        vandps  %ymm6, %ymm9, %ymm9
.LBB11_7:                               #   in Loop: Header=BB11_2 Depth=1
        vpcmpeqd        %ymm12, %ymm12, %ymm12
        vpcmpeqd        %ymm3, %ymm8, %ymm6
        vpxor   %ymm6, %ymm12, %ymm8
        vandps  %ymm3, %ymm4, %ymm4
        vpcmpeqd        %ymm3, %ymm4, %ymm4
        vpxor   %ymm4, %ymm12, %ymm10
        vpcmpeqd        928(%rsp), %ymm3, %ymm6         # 32-byte Folded Reload
        vpandn  %ymm8, %ymm6, %ymm13
        vpor    %ymm5, %ymm10, %ymm5
        vpand   %ymm5, %ymm13, %ymm5
        vtestps %ymm12, %ymm5
        jae     .LBB11_9
        vxorps  %xmm15, %xmm15, %xmm15
        vmovups %ymm2, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB11_2
.LBB11_11:
        addq    $1000, %rsp                     # imm = 0x3E8
        vzeroupper
        retq
.LCPI12_0:
        .long   0x00800000                      # float 1.17549435E-38
.LCPI12_1:
        .long   2155872255                      # 0x807fffff
.LCPI12_2:
        .long   1056964608                      # 0x3f000000
.LCPI12_3:
        .long   4294967169                      # 0xffffff81
.LCPI12_4:
        .long   0x3f800000                      # float 1
.LCPI12_5:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI12_6:
        .long   0xbf800000                      # float -1
.LCPI12_7:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI12_8:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI12_9:
        .long   0x3def251a                      # float 0.116769984
.LCPI12_10:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI12_11:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI12_12:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI12_13:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI12_14:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI12_15:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI12_16:
        .long   0x3f317218                      # float 0.693147182
.LCPI12_17:
        .long   0xbf000000                      # float -0.5
.LCPI12_18:
        .long   0x3ede5bd9                      # float 0.434294492
.LCPI12_19:
        .zero   32
Log10_Len8x_F32_V(float*, unsigned long):               # @Log10_Len8x_F32_V(float*, unsigned long)
        subq    $136, %rsp
        testq   %rsi, %rsi
        je      .LBB12_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI12_1(%rip), %ymm0  # ymm0 = [2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255]
        vmovups %ymm0, 96(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI12_2(%rip), %ymm0  # ymm0 = [1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI12_3(%rip), %ymm0  # ymm0 = [4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI12_0(%rip), %ymm0  # ymm0 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI12_4(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI12_5(%rip), %ymm0  # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI12_6(%rip), %ymm0  # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI12_7(%rip), %ymm0  # ymm0 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI12_8(%rip), %ymm9  # ymm9 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vbroadcastss    .LCPI12_9(%rip), %ymm10 # ymm10 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vbroadcastss    .LCPI12_10(%rip), %ymm11 # ymm11 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vbroadcastss    .LCPI12_11(%rip), %ymm12 # ymm12 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vbroadcastss    .LCPI12_12(%rip), %ymm13 # ymm13 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vbroadcastss    .LCPI12_13(%rip), %ymm14 # ymm14 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vbroadcastss    .LCPI12_14(%rip), %ymm15 # ymm15 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vbroadcastss    .LCPI12_15(%rip), %ymm0 # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vbroadcastss    .LCPI12_16(%rip), %ymm1 # ymm1 = [6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1]
        vbroadcastss    .LCPI12_17(%rip), %ymm2 # ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI12_18(%rip), %ymm3 # ymm3 = [4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1]
.LBB12_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rax,4), %ymm4
        vmaxps  (%rsp), %ymm4, %ymm5            # 32-byte Folded Reload
        vpsrld  $23, %ymm5, %ymm6
        vpaddd  32(%rsp), %ymm6, %ymm6          # 32-byte Folded Reload
        vandps  96(%rsp), %ymm5, %ymm5          # 32-byte Folded Reload
        vorps   64(%rsp), %ymm5, %ymm5          # 32-byte Folded Reload
        vcvtdq2ps       %ymm6, %ymm6
        vaddps  -32(%rsp), %ymm6, %ymm7         # 32-byte Folded Reload
        vcmpltps        -64(%rsp), %ymm5, %ymm8         # 32-byte Folded Reload
        vblendvps       %ymm8, %ymm6, %ymm7, %ymm6
        vandps  %ymm5, %ymm8, %ymm7
        vaddps  -96(%rsp), %ymm5, %ymm5         # 32-byte Folded Reload
        vaddps  %ymm7, %ymm5, %ymm5
        vmovups -128(%rsp), %ymm7               # 32-byte Reload
        vfmadd213ps     %ymm9, %ymm5, %ymm7     # ymm7 = (ymm5 * ymm7) + ymm9
        vfmadd213ps     %ymm10, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm10
        vfmadd213ps     %ymm11, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm11
        vfmadd213ps     %ymm12, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm12
        vfmadd213ps     %ymm13, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm13
        vfmadd213ps     %ymm14, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm14
        vfmadd213ps     %ymm15, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm15
        vfmadd213ps     %ymm0, %ymm5, %ymm7     # ymm7 = (ymm5 * ymm7) + ymm0
        vfmadd213ps     %ymm2, %ymm5, %ymm7     # ymm7 = (ymm5 * ymm7) + ymm2
        vfmadd213ps     %ymm5, %ymm1, %ymm6     # ymm6 = (ymm1 * ymm6) + ymm5
        vmulps  %ymm5, %ymm5, %ymm5
        vfmadd231ps     %ymm7, %ymm5, %ymm6     # ymm6 = (ymm5 * ymm7) + ymm6
        vcmpleps        .LCPI12_19(%rip), %ymm4, %ymm4
        vmulps  %ymm3, %ymm6, %ymm5
        vorps   %ymm5, %ymm4, %ymm4
        vmovups %ymm4, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB12_2
.LBB12_3:
        addq    $136, %rsp
        vzeroupper
        retq
.LCPI13_0:
        .long   0x00800000                      # float 1.17549435E-38
.LCPI13_1:
        .long   2155872255                      # 0x807fffff
.LCPI13_2:
        .long   1056964608                      # 0x3f000000
.LCPI13_3:
        .long   4294967169                      # 0xffffff81
.LCPI13_4:
        .long   0x3f800000                      # float 1
.LCPI13_5:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI13_6:
        .long   0xbf800000                      # float -1
.LCPI13_7:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI13_8:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI13_9:
        .long   0x3def251a                      # float 0.116769984
.LCPI13_10:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI13_11:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI13_12:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI13_13:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI13_14:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI13_15:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI13_16:
        .long   0x3f317218                      # float 0.693147182
.LCPI13_17:
        .long   0xbf000000                      # float -0.5
.LCPI13_18:
        .long   0x3fb8aa3b                      # float 1.44269502
.LCPI13_19:
        .zero   32
Log2_Len8x_F32_V(float*, unsigned long):                # @Log2_Len8x_F32_V(float*, unsigned long)
        subq    $136, %rsp
        testq   %rsi, %rsi
        je      .LBB13_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI13_1(%rip), %ymm0  # ymm0 = [2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255]
        vmovups %ymm0, 96(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI13_2(%rip), %ymm0  # ymm0 = [1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI13_3(%rip), %ymm0  # ymm0 = [4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI13_0(%rip), %ymm0  # ymm0 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI13_4(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI13_5(%rip), %ymm0  # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI13_6(%rip), %ymm0  # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI13_7(%rip), %ymm0  # ymm0 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI13_8(%rip), %ymm9  # ymm9 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vbroadcastss    .LCPI13_9(%rip), %ymm10 # ymm10 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vbroadcastss    .LCPI13_10(%rip), %ymm11 # ymm11 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vbroadcastss    .LCPI13_11(%rip), %ymm12 # ymm12 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vbroadcastss    .LCPI13_12(%rip), %ymm13 # ymm13 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vbroadcastss    .LCPI13_13(%rip), %ymm14 # ymm14 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vbroadcastss    .LCPI13_14(%rip), %ymm15 # ymm15 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vbroadcastss    .LCPI13_15(%rip), %ymm0 # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vbroadcastss    .LCPI13_16(%rip), %ymm1 # ymm1 = [6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1]
        vbroadcastss    .LCPI13_17(%rip), %ymm2 # ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI13_18(%rip), %ymm3 # ymm3 = [1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0]
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rax,4), %ymm4
        vmaxps  (%rsp), %ymm4, %ymm5            # 32-byte Folded Reload
        vpsrld  $23, %ymm5, %ymm6
        vpaddd  32(%rsp), %ymm6, %ymm6          # 32-byte Folded Reload
        vandps  96(%rsp), %ymm5, %ymm5          # 32-byte Folded Reload
        vorps   64(%rsp), %ymm5, %ymm5          # 32-byte Folded Reload
        vcvtdq2ps       %ymm6, %ymm6
        vaddps  -32(%rsp), %ymm6, %ymm7         # 32-byte Folded Reload
        vcmpltps        -64(%rsp), %ymm5, %ymm8         # 32-byte Folded Reload
        vblendvps       %ymm8, %ymm6, %ymm7, %ymm6
        vandps  %ymm5, %ymm8, %ymm7
        vaddps  -96(%rsp), %ymm5, %ymm5         # 32-byte Folded Reload
        vaddps  %ymm7, %ymm5, %ymm5
        vmovups -128(%rsp), %ymm7               # 32-byte Reload
        vfmadd213ps     %ymm9, %ymm5, %ymm7     # ymm7 = (ymm5 * ymm7) + ymm9
        vfmadd213ps     %ymm10, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm10
        vfmadd213ps     %ymm11, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm11
        vfmadd213ps     %ymm12, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm12
        vfmadd213ps     %ymm13, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm13
        vfmadd213ps     %ymm14, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm14
        vfmadd213ps     %ymm15, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm15
        vfmadd213ps     %ymm0, %ymm5, %ymm7     # ymm7 = (ymm5 * ymm7) + ymm0
        vfmadd213ps     %ymm2, %ymm5, %ymm7     # ymm7 = (ymm5 * ymm7) + ymm2
        vfmadd213ps     %ymm5, %ymm1, %ymm6     # ymm6 = (ymm1 * ymm6) + ymm5
        vmulps  %ymm5, %ymm5, %ymm5
        vfmadd231ps     %ymm7, %ymm5, %ymm6     # ymm6 = (ymm5 * ymm7) + ymm6
        vcmpleps        .LCPI13_19(%rip), %ymm4, %ymm4
        vmulps  %ymm3, %ymm6, %ymm5
        vorps   %ymm5, %ymm4, %ymm4
        vmovups %ymm4, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB13_2
.LBB13_3:
        addq    $136, %rsp
        vzeroupper
        retq
.LCPI14_0:
        .long   0x00800000                      # float 1.17549435E-38
.LCPI14_1:
        .long   2155872255                      # 0x807fffff
.LCPI14_2:
        .long   1056964608                      # 0x3f000000
.LCPI14_3:
        .long   4294967169                      # 0xffffff81
.LCPI14_4:
        .long   0x3f800000                      # float 1
.LCPI14_5:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI14_6:
        .long   0xbf800000                      # float -1
.LCPI14_7:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI14_8:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI14_9:
        .long   0x3def251a                      # float 0.116769984
.LCPI14_10:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI14_11:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI14_12:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI14_13:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI14_14:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI14_15:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI14_16:
        .long   0x3f317218                      # float 0.693147182
.LCPI14_17:
        .long   0xbf000000                      # float -0.5
.LCPI14_18:
        .zero   32
Log_Len8x_F32_V(float*, unsigned long):                 # @Log_Len8x_F32_V(float*, unsigned long)
        subq    $104, %rsp
        testq   %rsi, %rsi
        je      .LBB14_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI14_0(%rip), %ymm0  # ymm0 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI14_1(%rip), %ymm0  # ymm0 = [2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI14_2(%rip), %ymm0  # ymm0 = [1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI14_3(%rip), %ymm0  # ymm0 = [4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI14_4(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI14_5(%rip), %ymm0  # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI14_6(%rip), %ymm0  # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI14_7(%rip), %ymm8  # ymm8 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vbroadcastss    .LCPI14_8(%rip), %ymm9  # ymm9 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vbroadcastss    .LCPI14_9(%rip), %ymm10 # ymm10 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vbroadcastss    .LCPI14_10(%rip), %ymm11 # ymm11 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vbroadcastss    .LCPI14_11(%rip), %ymm12 # ymm12 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vbroadcastss    .LCPI14_12(%rip), %ymm13 # ymm13 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vbroadcastss    .LCPI14_13(%rip), %ymm14 # ymm14 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vbroadcastss    .LCPI14_14(%rip), %ymm15 # ymm15 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vbroadcastss    .LCPI14_15(%rip), %ymm0 # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vbroadcastss    .LCPI14_16(%rip), %ymm1 # ymm1 = [6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1]
        vbroadcastss    .LCPI14_17(%rip), %ymm2 # ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
.LBB14_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rax,4), %ymm3
        vmaxps  64(%rsp), %ymm3, %ymm4          # 32-byte Folded Reload
        vpsrld  $23, %ymm4, %ymm5
        vpaddd  -32(%rsp), %ymm5, %ymm5         # 32-byte Folded Reload
        vandps  32(%rsp), %ymm4, %ymm4          # 32-byte Folded Reload
        vorps   (%rsp), %ymm4, %ymm4            # 32-byte Folded Reload
        vcvtdq2ps       %ymm5, %ymm5
        vaddps  -64(%rsp), %ymm5, %ymm6         # 32-byte Folded Reload
        vcmpltps        -96(%rsp), %ymm4, %ymm7         # 32-byte Folded Reload
        vblendvps       %ymm7, %ymm5, %ymm6, %ymm5
        vandps  %ymm4, %ymm7, %ymm6
        vaddps  -128(%rsp), %ymm4, %ymm4        # 32-byte Folded Reload
        vaddps  %ymm6, %ymm4, %ymm4
        vmovaps %ymm8, %ymm6
        vfmadd213ps     %ymm9, %ymm4, %ymm6     # ymm6 = (ymm4 * ymm6) + ymm9
        vfmadd213ps     %ymm10, %ymm4, %ymm6    # ymm6 = (ymm4 * ymm6) + ymm10
        vfmadd213ps     %ymm11, %ymm4, %ymm6    # ymm6 = (ymm4 * ymm6) + ymm11
        vfmadd213ps     %ymm12, %ymm4, %ymm6    # ymm6 = (ymm4 * ymm6) + ymm12
        vfmadd213ps     %ymm13, %ymm4, %ymm6    # ymm6 = (ymm4 * ymm6) + ymm13
        vfmadd213ps     %ymm14, %ymm4, %ymm6    # ymm6 = (ymm4 * ymm6) + ymm14
        vfmadd213ps     %ymm15, %ymm4, %ymm6    # ymm6 = (ymm4 * ymm6) + ymm15
        vfmadd213ps     %ymm0, %ymm4, %ymm6     # ymm6 = (ymm4 * ymm6) + ymm0
        vfmadd213ps     %ymm2, %ymm4, %ymm6     # ymm6 = (ymm4 * ymm6) + ymm2
        vfmadd213ps     %ymm4, %ymm1, %ymm5     # ymm5 = (ymm1 * ymm5) + ymm4
        vmulps  %ymm4, %ymm4, %ymm4
        vfmadd231ps     %ymm6, %ymm4, %ymm5     # ymm5 = (ymm4 * ymm6) + ymm5
        vcmpleps        .LCPI14_18(%rip), %ymm3, %ymm3
        vorps   %ymm5, %ymm3, %ymm3
        vmovups %ymm3, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB14_2
.LBB14_3:
        addq    $104, %rsp
        vzeroupper
        retq
.LCPI15_0:
        .long   0x42b17218                      # float 88.7228394
.LCPI15_1:
        .long   0xc2ce8ed0                      # float -103.278931
.LCPI15_2:
        .long   0x3f000000                      # float 0.5
.LCPI15_3:
        .long   0x3fb8aa3b                      # float 1.44269502
.LCPI15_4:
        .long   0xbf318000                      # float -0.693359375
.LCPI15_5:
        .long   0x395e8083                      # float 2.12194442E-4
.LCPI15_6:
        .long   1065353216                      # 0x3f800000
.LCPI15_7:
        .long   0x3ab743ce                      # float 0.00139819994
.LCPI15_8:
        .long   0x39506967                      # float 1.98756912E-4
.LCPI15_9:
        .long   0x3c088908                      # float 0.00833345205
.LCPI15_10:
        .long   0x3d2aa9c1                      # float 0.0416657962
.LCPI15_11:
        .long   0x3e2aaaaa                      # float 0.166666657
.LCPI15_12:
        .long   0x7f7fffff                      # float 3.40282347E+38
Exp_Len8x_F32_V(float*, unsigned long):                 # @Exp_Len8x_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB15_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI15_0(%rip), %ymm0  # ymm0 = [8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1]
        vmovups %ymm0, -40(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI15_1(%rip), %ymm0  # ymm0 = [-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2]
        vmovups %ymm0, -72(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI15_2(%rip), %ymm2  # ymm2 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1]
        vbroadcastss    .LCPI15_3(%rip), %ymm3  # ymm3 = [1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0]
        vbroadcastss    .LCPI15_4(%rip), %ymm4  # ymm4 = [-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1]
        vbroadcastss    .LCPI15_5(%rip), %ymm5  # ymm5 = [2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4]
        vpbroadcastd    .LCPI15_6(%rip), %ymm6  # ymm6 = [1065353216,1065353216,1065353216,1065353216,1065353216,1065353216,1065353216,1065353216]
        vbroadcastss    .LCPI15_7(%rip), %ymm7  # ymm7 = [1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3]
        vbroadcastss    .LCPI15_8(%rip), %ymm1  # ymm1 = [1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4]
        vbroadcastss    .LCPI15_9(%rip), %ymm9  # ymm9 = [8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3]
        vbroadcastss    .LCPI15_10(%rip), %ymm10 # ymm10 = [4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2]
        vbroadcastss    .LCPI15_11(%rip), %ymm11 # ymm11 = [1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1]
        vbroadcastss    .LCPI15_12(%rip), %ymm12 # ymm12 = [3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38]
.LBB15_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rax,4), %ymm13
        vmovaps %ymm3, %ymm14
        vfmadd213ps     %ymm2, %ymm13, %ymm14   # ymm14 = (ymm13 * ymm14) + ymm2
        vroundps        $1, %ymm14, %ymm14
        vmovaps %ymm4, %ymm15
        vfmadd213ps     %ymm13, %ymm14, %ymm15  # ymm15 = (ymm14 * ymm15) + ymm13
        vfmadd231ps     %ymm5, %ymm14, %ymm15   # ymm15 = (ymm14 * ymm5) + ymm15
        vmulps  %ymm15, %ymm15, %ymm0
        vmovaps %ymm1, %ymm8
        vfmadd213ps     %ymm7, %ymm15, %ymm8    # ymm8 = (ymm15 * ymm8) + ymm7
        vfmadd213ps     %ymm9, %ymm15, %ymm8    # ymm8 = (ymm15 * ymm8) + ymm9
        vfmadd213ps     %ymm10, %ymm15, %ymm8   # ymm8 = (ymm15 * ymm8) + ymm10
        vfmadd213ps     %ymm11, %ymm15, %ymm8   # ymm8 = (ymm15 * ymm8) + ymm11
        vfmadd213ps     %ymm2, %ymm15, %ymm8    # ymm8 = (ymm15 * ymm8) + ymm2
        vfmadd213ps     %ymm15, %ymm0, %ymm8    # ymm8 = (ymm0 * ymm8) + ymm15
        vcvttps2dq      %ymm14, %ymm0
        vpslld  $23, %ymm0, %ymm0
        vpaddd  %ymm6, %ymm0, %ymm0
        vfmadd213ps     %ymm0, %ymm0, %ymm8     # ymm8 = (ymm0 * ymm8) + ymm0
        vmovups -40(%rsp), %ymm0                # 32-byte Reload
        vcmpltps        %ymm13, %ymm0, %ymm0
        vblendvps       %ymm0, %ymm12, %ymm8, %ymm0
        vmovups -72(%rsp), %ymm8                # 32-byte Reload
        vcmpleps        %ymm13, %ymm8, %ymm8
        vandps  %ymm0, %ymm8, %ymm0
        vmovups %ymm0, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB15_2
.LBB15_3:
        vzeroupper
        retq
.LCPI16_0:
        .long   2147483647                      # 0x7fffffff
.LCPI16_1:
        .long   0x3fa2f983                      # float 1.27323949
.LCPI16_2:
        .long   4294967294                      # 0xfffffffe
.LCPI16_3:
        .long   2                               # 0x2
.LCPI16_4:
        .long   0xbf490fdb                      # float -0.785398185
.LCPI16_5:
        .long   2147483648                      # 0x80000000
.LCPI16_6:
        .long   0x37ccf5ce                      # float 2.44331568E-5
.LCPI16_7:
        .long   0xbab6061a                      # float -0.00138873165
.LCPI16_8:
        .long   0x3d2aaaa5                      # float 0.0416666456
.LCPI16_9:
        .long   0xbf000000                      # float -0.5
.LCPI16_10:
        .long   0x3f800000                      # float 1
.LCPI16_11:
        .long   0xb94ca1f9                      # float -1.95152956E-4
.LCPI16_12:
        .long   0x3c08839e                      # float 0.00833216123
.LCPI16_13:
        .long   0xbe2aaaa3                      # float -0.166666552
.LCPI16_14:
        .long   0x4b7fffff                      # float 16777215
.LCPI16_15:
        .long   0x00000000                      # float 0
.LCPI16_16:
        .zero   32,255
.LCPI16_17:
        .zero   32
Sin_F32_V(float*, unsigned long):                        # @Sin_F32_V(float*, unsigned long)
        pushq   %rax
        movq    %rsi, %rax
        andq    $-8, %rax
        je      .LBB16_3
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI16_0(%rip), %ymm0  # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI16_1(%rip), %ymm0  # ymm0 = [1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI16_2(%rip), %ymm0  # ymm0 = [4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI16_3(%rip), %ymm4  # ymm4 = [2,2,2,2,2,2,2,2]
        vpbroadcastd    .LCPI16_4(%rip), %ymm0  # ymm0 = [-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1]
        vmovdqu %ymm0, -128(%rsp)               # 32-byte Spill
        vpbroadcastd    .LCPI16_5(%rip), %ymm7  # ymm7 = [2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648]
        vbroadcastss    .LCPI16_6(%rip), %ymm8  # ymm8 = [2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5]
        vbroadcastss    .LCPI16_7(%rip), %ymm9  # ymm9 = [-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3]
        vbroadcastss    .LCPI16_8(%rip), %ymm10 # ymm10 = [4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2]
        vbroadcastss    .LCPI16_9(%rip), %ymm11 # ymm11 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI16_10(%rip), %ymm12 # ymm12 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI16_11(%rip), %ymm3 # ymm3 = [-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4]
        vbroadcastss    .LCPI16_12(%rip), %ymm14 # ymm14 = [8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3]
        vbroadcastss    .LCPI16_13(%rip), %ymm15 # ymm15 = [-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1]
.LBB16_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm2
        vandps  -32(%rsp), %ymm2, %ymm5         # 32-byte Folded Reload
        vmulps  -64(%rsp), %ymm5, %ymm0         # 32-byte Folded Reload
        vcvttps2dq      %ymm0, %ymm0
        vpsubd  .LCPI16_16(%rip), %ymm0, %ymm0
        vpand   -96(%rsp), %ymm0, %ymm1         # 32-byte Folded Reload
        vcvtdq2ps       %ymm1, %ymm1
        vfmadd132ps     -128(%rsp), %ymm5, %ymm1 # 32-byte Folded Reload
        vmulps  %ymm1, %ymm1, %ymm5
        vmovaps %ymm3, %ymm13
        vfmadd213ps     %ymm14, %ymm5, %ymm13   # ymm13 = (ymm5 * ymm13) + ymm14
        vfmadd213ps     %ymm15, %ymm5, %ymm13   # ymm13 = (ymm5 * ymm13) + ymm15
        vmulps  %ymm1, %ymm5, %ymm6
        vfmadd213ps     %ymm1, %ymm13, %ymm6    # ymm6 = (ymm13 * ymm6) + ymm1
        vpslld  $29, %ymm0, %ymm1
        vpand   %ymm4, %ymm0, %ymm0
        vpxor   %ymm2, %ymm1, %ymm1
        vmovaps %ymm8, %ymm2
        vfmadd213ps     %ymm9, %ymm5, %ymm2     # ymm2 = (ymm5 * ymm2) + ymm9
        vfmadd213ps     %ymm10, %ymm5, %ymm2    # ymm2 = (ymm5 * ymm2) + ymm10
        vfmadd213ps     %ymm11, %ymm5, %ymm2    # ymm2 = (ymm5 * ymm2) + ymm11
        vfmadd213ps     %ymm12, %ymm5, %ymm2    # ymm2 = (ymm5 * ymm2) + ymm12
        vpcmpeqd        %ymm4, %ymm0, %ymm5
        vandps  %ymm5, %ymm2, %ymm2
        vpcmpeqd        .LCPI16_17(%rip), %ymm0, %ymm0
        vandps  %ymm0, %ymm6, %ymm0
        vaddps  %ymm2, %ymm0, %ymm0
        vpand   %ymm7, %ymm1, %ymm1
        vpxor   %ymm0, %ymm1, %ymm0
        vmovdqu %ymm0, (%rdi,%rcx,4)
        addq    $8, %rcx
        cmpq    %rax, %rcx
        jb      .LBB16_2
.LBB16_3:
        cmpq    %rsi, %rax
        jae     .LBB16_14
        vbroadcastss    .LCPI16_5(%rip), %xmm0  # xmm0 = [2147483648,2147483648,2147483648,2147483648]
        vmovss  .LCPI16_14(%rip), %xmm1         # xmm1 = mem[0],zero,zero,zero
        vmovss  .LCPI16_1(%rip), %xmm9          # xmm9 = mem[0],zero,zero,zero
        vmovss  .LCPI16_10(%rip), %xmm10        # xmm10 = mem[0],zero,zero,zero
        vmovss  .LCPI16_4(%rip), %xmm11         # xmm11 = mem[0],zero,zero,zero
        vmovss  .LCPI16_6(%rip), %xmm13         # xmm13 = mem[0],zero,zero,zero
        vmovss  .LCPI16_7(%rip), %xmm12         # xmm12 = mem[0],zero,zero,zero
        vmovss  .LCPI16_8(%rip), %xmm14         # xmm14 = mem[0],zero,zero,zero
        vmovss  .LCPI16_9(%rip), %xmm15         # xmm15 = mem[0],zero,zero,zero
        vmovss  .LCPI16_11(%rip), %xmm8         # xmm8 = mem[0],zero,zero,zero
        vmovss  .LCPI16_12(%rip), %xmm5         # xmm5 = mem[0],zero,zero,zero
        vmovss  .LCPI16_13(%rip), %xmm7         # xmm7 = mem[0],zero,zero,zero
        jmp     .LBB16_5
.LBB16_13:                              #   in Loop: Header=BB16_5 Depth=1
        incq    %rax
        cmpq    %rsi, %rax
        jae     .LBB16_14
.LBB16_5:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm2, %xmm3
        vmaxss  %xmm2, %xmm3, %xmm6
        vucomiss        %xmm1, %xmm6
        ja      .LBB16_13
        vucomiss        .LCPI16_15(%rip), %xmm2
        vmulss  %xmm6, %xmm9, %xmm2
        vcvttss2si      %xmm2, %ecx
        setb    %r8b
        vroundss        $11, %xmm2, %xmm2, %xmm2
        movl    %ecx, %edx
        andl    $1, %edx
        je      .LBB16_8
        vaddss  %xmm2, %xmm10, %xmm2
.LBB16_8:                               #   in Loop: Header=BB16_5 Depth=1
        addl    %ecx, %edx
        andl    $7, %edx
        leal    -4(%rdx), %ecx
        cmpl    $4, %edx
        cmovbl  %edx, %ecx
        setae   %dl
        vfmadd231ss     %xmm11, %xmm2, %xmm6    # xmm6 = (xmm2 * xmm11) + xmm6
        vmulss  %xmm6, %xmm6, %xmm2
        vmovaps %xmm13, %xmm3
        vfmadd213ss     %xmm12, %xmm2, %xmm3    # xmm3 = (xmm2 * xmm3) + xmm12
        vfmadd213ss     %xmm14, %xmm2, %xmm3    # xmm3 = (xmm2 * xmm3) + xmm14
        vfmadd213ss     %xmm15, %xmm2, %xmm3    # xmm3 = (xmm2 * xmm3) + xmm15
        vmovaps %xmm8, %xmm4
        vfmadd213ss     %xmm5, %xmm2, %xmm4     # xmm4 = (xmm2 * xmm4) + xmm5
        vfmadd213ss     %xmm7, %xmm2, %xmm4     # xmm4 = (xmm2 * xmm4) + xmm7
        decl    %ecx
        cmpl    $2, %ecx
        jb      .LBB16_9
        vmulss  %xmm6, %xmm2, %xmm2
        vfmadd213ss     %xmm6, %xmm2, %xmm4     # xmm4 = (xmm2 * xmm4) + xmm6
        vmovaps %xmm4, %xmm2
        vmovss  %xmm2, (%rdi,%rax,4)
        cmpb    %dl, %r8b
        je      .LBB16_13
        jmp     .LBB16_12
.LBB16_9:                               #   in Loop: Header=BB16_5 Depth=1
        vfmadd213ss     %xmm10, %xmm3, %xmm2    # xmm2 = (xmm3 * xmm2) + xmm10
        vmovss  %xmm2, (%rdi,%rax,4)
        cmpb    %dl, %r8b
        je      .LBB16_13
.LBB16_12:                              #   in Loop: Header=BB16_5 Depth=1
        vxorps  %xmm0, %xmm2, %xmm2
        vmovss  %xmm2, (%rdi,%rax,4)
        jmp     .LBB16_13
.LBB16_14:
        popq    %rax
        vzeroupper
        retq
.LCPI17_0:
        .long   2147483647                      # 0x7fffffff
.LCPI17_1:
        .long   0x3fa2f983                      # float 1.27323949
.LCPI17_2:
        .long   4294967294                      # 0xfffffffe
.LCPI17_3:
        .long   2                               # 0x2
.LCPI17_4:
        .long   0xbf490fdb                      # float -0.785398185
.LCPI17_5:
        .long   3221225472                      # 0xc0000000
.LCPI17_6:
        .long   0x37ccf5ce                      # float 2.44331568E-5
.LCPI17_7:
        .long   0xbab6061a                      # float -0.00138873165
.LCPI17_8:
        .long   0x3d2aaaa5                      # float 0.0416666456
.LCPI17_9:
        .long   0xbf000000                      # float -0.5
.LCPI17_10:
        .long   0x3f800000                      # float 1
.LCPI17_11:
        .long   0xb94ca1f9                      # float -1.95152956E-4
.LCPI17_12:
        .long   0x3c08839e                      # float 0.00833216123
.LCPI17_13:
        .long   0xbe2aaaa3                      # float -0.166666552
.LCPI17_14:
        .long   2147483648                      # 0x80000000
.LCPI17_15:
        .long   0x4b7fffff                      # float 16777215
.LCPI17_16:
        .zero   32,255
.LCPI17_17:
        .zero   32
Cos_F32_V(float*, unsigned long):                        # @Cos_F32_V(float*, unsigned long)
        subq    $72, %rsp
        movq    %rsi, %rax
        andq    $-8, %rax
        je      .LBB17_3
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI17_0(%rip), %ymm0  # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI17_1(%rip), %ymm0  # ymm0 = [1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI17_2(%rip), %ymm0  # ymm0 = [4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI17_3(%rip), %ymm4  # ymm4 = [2,2,2,2,2,2,2,2]
        vbroadcastss    .LCPI17_4(%rip), %ymm0  # ymm0 = [-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI17_5(%rip), %ymm0  # ymm0 = [3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI17_6(%rip), %ymm0  # ymm0 = [2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI17_7(%rip), %ymm9  # ymm9 = [-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3]
        vbroadcastss    .LCPI17_8(%rip), %ymm10 # ymm10 = [4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2]
        vbroadcastss    .LCPI17_9(%rip), %ymm6  # ymm6 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI17_10(%rip), %ymm12 # ymm12 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI17_11(%rip), %ymm13 # ymm13 = [-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4]
        vbroadcastss    .LCPI17_12(%rip), %ymm14 # ymm14 = [8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3]
        vbroadcastss    .LCPI17_13(%rip), %ymm15 # ymm15 = [-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1]
        vpbroadcastd    .LCPI17_14(%rip), %ymm2 # ymm2 = [2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648]
.LBB17_2:                               # =>This Inner Loop Header: Depth=1
        vmovups 32(%rsp), %ymm0                 # 32-byte Reload
        vandps  (%rdi,%rcx,4), %ymm0, %ymm5
        vmulps  (%rsp), %ymm5, %ymm0            # 32-byte Folded Reload
        vcvttps2dq      %ymm0, %ymm0
        vpsubd  .LCPI17_16(%rip), %ymm0, %ymm0
        vpand   -32(%rsp), %ymm0, %ymm1         # 32-byte Folded Reload
        vcvtdq2ps       %ymm1, %ymm3
        vfmadd132ps     -64(%rsp), %ymm5, %ymm3 # 32-byte Folded Reload
        vmulps  %ymm3, %ymm3, %ymm5
        vmovups -128(%rsp), %ymm8               # 32-byte Reload
        vfmadd213ps     %ymm9, %ymm5, %ymm8     # ymm8 = (ymm5 * ymm8) + ymm9
        vfmadd213ps     %ymm10, %ymm5, %ymm8    # ymm8 = (ymm5 * ymm8) + ymm10
        vmulps  %ymm5, %ymm5, %ymm7
        vmovaps %ymm6, %ymm11
        vfmadd213ps     %ymm12, %ymm5, %ymm11   # ymm11 = (ymm5 * ymm11) + ymm12
        vfmadd231ps     %ymm7, %ymm8, %ymm11    # ymm11 = (ymm8 * ymm7) + ymm11
        vmovaps %ymm13, %ymm7
        vfmadd213ps     %ymm14, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm14
        vfmadd213ps     %ymm15, %ymm5, %ymm7    # ymm7 = (ymm5 * ymm7) + ymm15
        vmulps  %ymm3, %ymm5, %ymm5
        vfmadd213ps     %ymm3, %ymm7, %ymm5     # ymm5 = (ymm7 * ymm5) + ymm3
        vpand   %ymm4, %ymm0, %ymm0
        vpcmpeqd        %ymm4, %ymm0, %ymm3
        vpcmpeqd        .LCPI17_17(%rip), %ymm0, %ymm0
        vandps  %ymm0, %ymm5, %ymm0
        vandps  %ymm3, %ymm11, %ymm3
        vaddps  %ymm3, %ymm0, %ymm0
        vaddps  %ymm5, %ymm11, %ymm3
        vsubps  %ymm0, %ymm3, %ymm0
        vpslld  $29, %ymm1, %ymm1
        vpaddd  -96(%rsp), %ymm1, %ymm1         # 32-byte Folded Reload
        vpand   %ymm2, %ymm1, %ymm1
        vpxor   %ymm2, %ymm1, %ymm1
        vxorps  %ymm1, %ymm0, %ymm0
        vmovups %ymm0, (%rdi,%rcx,4)
        addq    $8, %rcx
        cmpq    %rax, %rcx
        jb      .LBB17_2
.LBB17_3:
        cmpq    %rsi, %rax
        jae     .LBB17_14
        vbroadcastss    .LCPI17_14(%rip), %xmm0 # xmm0 = [2147483648,2147483648,2147483648,2147483648]
        vmovss  .LCPI17_15(%rip), %xmm1         # xmm1 = mem[0],zero,zero,zero
        vmovss  .LCPI17_1(%rip), %xmm8          # xmm8 = mem[0],zero,zero,zero
        vmovss  .LCPI17_10(%rip), %xmm9         # xmm9 = mem[0],zero,zero,zero
        vmovss  .LCPI17_4(%rip), %xmm10         # xmm10 = mem[0],zero,zero,zero
        vmovss  .LCPI17_6(%rip), %xmm12         # xmm12 = mem[0],zero,zero,zero
        vmovss  .LCPI17_7(%rip), %xmm11         # xmm11 = mem[0],zero,zero,zero
        vmovss  .LCPI17_8(%rip), %xmm13         # xmm13 = mem[0],zero,zero,zero
        vmovss  .LCPI17_9(%rip), %xmm14         # xmm14 = mem[0],zero,zero,zero
        vmovss  .LCPI17_11(%rip), %xmm2         # xmm2 = mem[0],zero,zero,zero
        vmovss  .LCPI17_12(%rip), %xmm15        # xmm15 = mem[0],zero,zero,zero
        vmovss  .LCPI17_13(%rip), %xmm6         # xmm6 = mem[0],zero,zero,zero
        jmp     .LBB17_5
.LBB17_13:                              #   in Loop: Header=BB17_5 Depth=1
        incq    %rax
        cmpq    %rsi, %rax
        jae     .LBB17_14
.LBB17_5:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm3, %xmm4
        vmaxss  %xmm3, %xmm4, %xmm5
        vucomiss        %xmm1, %xmm5
        ja      .LBB17_13
        vmulss  %xmm5, %xmm8, %xmm3
        vcvttss2si      %xmm3, %ecx
        vroundss        $11, %xmm3, %xmm3, %xmm7
        movl    %ecx, %edx
        andl    $1, %edx
        je      .LBB17_8
        vaddss  %xmm7, %xmm9, %xmm7
.LBB17_8:                               #   in Loop: Header=BB17_5 Depth=1
        addl    %ecx, %edx
        andl    $7, %edx
        leal    -4(%rdx), %ecx
        cmpl    $4, %edx
        setae   %r8b
        cmovbl  %edx, %ecx
        cmpl    $2, %ecx
        setae   %dl
        vfmadd231ss     %xmm10, %xmm7, %xmm5    # xmm5 = (xmm7 * xmm10) + xmm5
        vmulss  %xmm5, %xmm5, %xmm7
        vmovaps %xmm12, %xmm4
        vfmadd213ss     %xmm11, %xmm7, %xmm4    # xmm4 = (xmm7 * xmm4) + xmm11
        vfmadd213ss     %xmm13, %xmm7, %xmm4    # xmm4 = (xmm7 * xmm4) + xmm13
        vfmadd213ss     %xmm14, %xmm7, %xmm4    # xmm4 = (xmm7 * xmm4) + xmm14
        vmovaps %xmm2, %xmm3
        vfmadd213ss     %xmm15, %xmm7, %xmm3    # xmm3 = (xmm7 * xmm3) + xmm15
        vfmadd213ss     %xmm6, %xmm7, %xmm3     # xmm3 = (xmm7 * xmm3) + xmm6
        decl    %ecx
        cmpl    $2, %ecx
        jb      .LBB17_9
        vfmadd213ss     %xmm9, %xmm4, %xmm7     # xmm7 = (xmm4 * xmm7) + xmm9
        vmovaps %xmm7, %xmm3
        vmovss  %xmm3, (%rdi,%rax,4)
        cmpb    %dl, %r8b
        je      .LBB17_13
        jmp     .LBB17_12
.LBB17_9:                               #   in Loop: Header=BB17_5 Depth=1
        vmulss  %xmm5, %xmm7, %xmm4
        vfmadd213ss     %xmm5, %xmm4, %xmm3     # xmm3 = (xmm4 * xmm3) + xmm5
        vmovss  %xmm3, (%rdi,%rax,4)
        cmpb    %dl, %r8b
        je      .LBB17_13
.LBB17_12:                              #   in Loop: Header=BB17_5 Depth=1
        vxorps  %xmm0, %xmm3, %xmm3
        vmovss  %xmm3, (%rdi,%rax,4)
        jmp     .LBB17_13
.LBB17_14:
        addq    $72, %rsp
        vzeroupper
        retq
.LCPI18_0:
        .long   2147483647                      # 0x7fffffff
.LCPI18_1:
        .long   0x3fa2f983                      # float 1.27323949
.LCPI18_2:
        .long   4294967294                      # 0xfffffffe
.LCPI18_3:
        .long   2                               # 0x2
.LCPI18_4:
        .long   0xbf490fdb                      # float -0.785398185
.LCPI18_5:
        .long   3221225472                      # 0xc0000000
.LCPI18_6:
        .long   2147483648                      # 0x80000000
.LCPI18_7:
        .long   0x37ccf5ce                      # float 2.44331568E-5
.LCPI18_8:
        .long   0xbab6061a                      # float -0.00138873165
.LCPI18_9:
        .long   0x3d2aaaa5                      # float 0.0416666456
.LCPI18_10:
        .long   0xbf000000                      # float -0.5
.LCPI18_11:
        .long   0x3f800000                      # float 1
.LCPI18_12:
        .long   0xb94ca1f9                      # float -1.95152956E-4
.LCPI18_13:
        .long   0x3c08839e                      # float 0.00833216123
.LCPI18_14:
        .long   0xbe2aaaa3                      # float -0.166666552
.LCPI18_15:
        .long   0x4b7fffff                      # float 16777215
.LCPI18_16:
        .long   0x00000000                      # float 0
.LCPI18_17:
        .zero   32,255
.LCPI18_18:
        .zero   32
SinCos_F32_V(float*, float*, float*, unsigned long):                # @SinCos_F32_V(float*, float*, float*, unsigned long)
        pushq   %rbx
        subq    $96, %rsp
        movq    %rcx, %r8
        andq    $-8, %r8
        je      .LBB18_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI18_0(%rip), %ymm0  # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI18_1(%rip), %ymm0  # ymm0 = [1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI18_2(%rip), %ymm0  # ymm0 = [4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vpbroadcastd    .LCPI18_3(%rip), %ymm4  # ymm4 = [2,2,2,2,2,2,2,2]
        vbroadcastss    .LCPI18_4(%rip), %ymm0  # ymm0 = [-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI18_5(%rip), %ymm0  # ymm0 = [3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI18_6(%rip), %ymm8  # ymm8 = [2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648]
        vbroadcastss    .LCPI18_7(%rip), %ymm0  # ymm0 = [2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI18_8(%rip), %ymm0  # ymm0 = [-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI18_9(%rip), %ymm11 # ymm11 = [4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2]
        vbroadcastss    .LCPI18_10(%rip), %ymm10 # ymm10 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI18_11(%rip), %ymm13 # ymm13 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI18_12(%rip), %ymm14 # ymm14 = [-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4]
        vbroadcastss    .LCPI18_13(%rip), %ymm15 # ymm15 = [8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3]
        vbroadcastss    .LCPI18_14(%rip), %ymm2 # ymm2 = [-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1]
.LBB18_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdx,%rax,4), %ymm5
        vandps  64(%rsp), %ymm5, %ymm1          # 32-byte Folded Reload
        vmulps  32(%rsp), %ymm1, %ymm0          # 32-byte Folded Reload
        vcvttps2dq      %ymm0, %ymm0
        vpsubd  .LCPI18_17(%rip), %ymm0, %ymm3
        vpand   (%rsp), %ymm3, %ymm0            # 32-byte Folded Reload
        vcvtdq2ps       %ymm0, %ymm6
        vfmadd132ps     -32(%rsp), %ymm1, %ymm6 # 32-byte Folded Reload
        vmulps  %ymm6, %ymm6, %ymm1
        vmovups -96(%rsp), %ymm9                # 32-byte Reload
        vfmadd213ps     -128(%rsp), %ymm1, %ymm9 # 32-byte Folded Reload
        vfmadd213ps     %ymm11, %ymm1, %ymm9    # ymm9 = (ymm1 * ymm9) + ymm11
        vmulps  %ymm1, %ymm1, %ymm7
        vmovaps %ymm10, %ymm12
        vfmadd213ps     %ymm13, %ymm1, %ymm12   # ymm12 = (ymm1 * ymm12) + ymm13
        vfmadd231ps     %ymm7, %ymm9, %ymm12    # ymm12 = (ymm9 * ymm7) + ymm12
        vmovaps %ymm14, %ymm7
        vfmadd213ps     %ymm15, %ymm1, %ymm7    # ymm7 = (ymm1 * ymm7) + ymm15
        vfmadd213ps     %ymm2, %ymm1, %ymm7     # ymm7 = (ymm1 * ymm7) + ymm2
        vmulps  %ymm6, %ymm1, %ymm1
        vfmadd213ps     %ymm6, %ymm7, %ymm1     # ymm1 = (ymm7 * ymm1) + ymm6
        vpslld  $29, %ymm3, %ymm6
        vpand   %ymm4, %ymm3, %ymm3
        vpxor   %ymm5, %ymm6, %ymm5
        vpcmpeqd        %ymm4, %ymm3, %ymm6
        vpcmpeqd        .LCPI18_18(%rip), %ymm3, %ymm3
        vandps  %ymm3, %ymm1, %ymm3
        vandps  %ymm6, %ymm12, %ymm6
        vaddps  %ymm3, %ymm6, %ymm3
        vaddps  %ymm1, %ymm12, %ymm1
        vpand   %ymm5, %ymm8, %ymm5
        vsubps  %ymm3, %ymm1, %ymm1
        vpxor   %ymm3, %ymm5, %ymm3
        vpslld  $29, %ymm0, %ymm0
        vpaddd  -64(%rsp), %ymm0, %ymm0         # 32-byte Folded Reload
        vpand   %ymm0, %ymm8, %ymm0
        vpxor   %ymm0, %ymm8, %ymm0
        vxorps  %ymm0, %ymm1, %ymm0
        vmovdqu %ymm3, (%rdi,%rax,4)
        vmovups %ymm0, (%rsi,%rax,4)
        addq    $8, %rax
        cmpq    %r8, %rax
        jb      .LBB18_2
.LBB18_3:
        cmpq    %rcx, %r8
        jae     .LBB18_16
        vbroadcastss    .LCPI18_6(%rip), %xmm0  # xmm0 = [2147483648,2147483648,2147483648,2147483648]
        vmovss  .LCPI18_15(%rip), %xmm1         # xmm1 = mem[0],zero,zero,zero
        vmovss  .LCPI18_11(%rip), %xmm3         # xmm3 = mem[0],zero,zero,zero
        vmovss  .LCPI18_7(%rip), %xmm8          # xmm8 = mem[0],zero,zero,zero
        vmovss  .LCPI18_8(%rip), %xmm11         # xmm11 = mem[0],zero,zero,zero
        vmovss  .LCPI18_9(%rip), %xmm13         # xmm13 = mem[0],zero,zero,zero
        vmovss  .LCPI18_10(%rip), %xmm14        # xmm14 = mem[0],zero,zero,zero
        vmovss  .LCPI18_12(%rip), %xmm10        # xmm10 = mem[0],zero,zero,zero
        vmovss  .LCPI18_13(%rip), %xmm15        # xmm15 = mem[0],zero,zero,zero
        vmovss  .LCPI18_14(%rip), %xmm6         # xmm6 = mem[0],zero,zero,zero
        jmp     .LBB18_5
.LBB18_15:                              #   in Loop: Header=BB18_5 Depth=1
        incq    %r8
        cmpq    %rcx, %r8
        jae     .LBB18_16
.LBB18_5:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdx,%r8,4), %xmm4             # xmm4 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm4, %xmm2
        vmaxss  %xmm4, %xmm2, %xmm2
        vucomiss        %xmm1, %xmm2
        ja      .LBB18_15
        vucomiss        .LCPI18_16(%rip), %xmm4
        vmulss  .LCPI18_1(%rip), %xmm2, %xmm4
        vcvttss2si      %xmm4, %r10d
        setb    %r9b
        vroundss        $11, %xmm4, %xmm4, %xmm4
        movl    %r10d, %eax
        andl    $1, %eax
        je      .LBB18_8
        vaddss  %xmm3, %xmm4, %xmm4
.LBB18_8:                               #   in Loop: Header=BB18_5 Depth=1
        addl    %r10d, %eax
        andl    $7, %eax
        leal    -4(%rax), %r10d
        cmpl    $4, %eax
        setae   %r11b
        cmovbl  %eax, %r10d
        vfmadd231ss     .LCPI18_4(%rip), %xmm4, %xmm2 # xmm2 = (xmm4 * mem) + xmm2
        vmulss  %xmm2, %xmm2, %xmm7
        vmovaps %xmm8, %xmm12
        vfmadd213ss     %xmm11, %xmm7, %xmm12   # xmm12 = (xmm7 * xmm12) + xmm11
        vfmadd213ss     %xmm13, %xmm7, %xmm12   # xmm12 = (xmm7 * xmm12) + xmm13
        vmulss  %xmm7, %xmm7, %xmm9
        vmovaps %xmm3, %xmm4
        vfmadd231ss     %xmm14, %xmm7, %xmm4    # xmm4 = (xmm7 * xmm14) + xmm4
        vfmadd231ss     %xmm9, %xmm12, %xmm4    # xmm4 = (xmm12 * xmm9) + xmm4
        vmovaps %xmm10, %xmm5
        vfmadd213ss     %xmm15, %xmm7, %xmm5    # xmm5 = (xmm7 * xmm5) + xmm15
        vfmadd213ss     %xmm6, %xmm7, %xmm5     # xmm5 = (xmm7 * xmm5) + xmm6
        vmulss  %xmm2, %xmm7, %xmm7
        vfmadd213ss     %xmm2, %xmm5, %xmm7     # xmm7 = (xmm5 * xmm7) + xmm2
        leal    -1(%r10), %ebx
        cmpl    $2, %ebx
        jb      .LBB18_9
        vmovaps %xmm7, %xmm2
        vmovss  %xmm2, (%rdi,%r8,4)
        vmovss  %xmm4, (%rsi,%r8,4)
        cmpb    %r11b, %r9b
        jne     .LBB18_12
        jmp     .LBB18_13
.LBB18_9:                               #   in Loop: Header=BB18_5 Depth=1
        vmovaps %xmm4, %xmm2
        vmovaps %xmm7, %xmm4
        vmovss  %xmm2, (%rdi,%r8,4)
        vmovss  %xmm4, (%rsi,%r8,4)
        cmpb    %r11b, %r9b
        je      .LBB18_13
.LBB18_12:                              #   in Loop: Header=BB18_5 Depth=1
        vmovss  (%rdi,%r8,4), %xmm2             # xmm2 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm2, %xmm2
        vmovss  %xmm2, (%rdi,%r8,4)
.LBB18_13:                              #   in Loop: Header=BB18_5 Depth=1
        cmpl    $2, %r10d
        setae   %bl
        cmpl    $4, %eax
        setae   %al
        cmpb    %bl, %al
        je      .LBB18_15
        vmovss  (%rsi,%r8,4), %xmm2             # xmm2 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm2, %xmm2
        vmovss  %xmm2, (%rsi,%r8,4)
        jmp     .LBB18_15
.LBB18_16:
        addq    $96, %rsp
        popq    %rbx
        vzeroupper
        retq
