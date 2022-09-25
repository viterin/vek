Sqrt_F64_D(double*, unsigned long):                      # @Sqrt_F64_D(double*, unsigned long)
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
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_6
.LBB0_7:
        vzeroupper
        retq
.LCPI1_0:
        .long   0xc0400000                      # float -3
.LCPI1_1:
        .long   0xbf000000                      # float -0.5
.LCPI1_2:
        .long   0x7fffffff                      # float NaN
.LCPI1_3:
        .long   0x00800000                      # float 1.17549435E-38
Sqrt_F32_F(float*, unsigned long):                      # @Sqrt_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB1_8
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
        vbroadcastss    .LCPI1_2(%rip), %ymm2   # ymm2 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
        vbroadcastss    .LCPI1_3(%rip), %ymm3   # ymm3 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm4
        vmovups 32(%rdi,%rcx,4), %ymm5
        vmovups 64(%rdi,%rcx,4), %ymm6
        vrsqrtps        %ymm4, %ymm7
        vmovups 96(%rdi,%rcx,4), %ymm8
        vmulps  %ymm7, %ymm4, %ymm9
        vfmadd213ps     %ymm0, %ymm9, %ymm7     # ymm7 = (ymm9 * ymm7) + ymm0
        vmulps  %ymm1, %ymm9, %ymm9
        vmulps  %ymm7, %ymm9, %ymm7
        vandps  %ymm2, %ymm4, %ymm4
        vcmpleps        %ymm4, %ymm3, %ymm4
        vandps  %ymm7, %ymm4, %ymm4
        vrsqrtps        %ymm5, %ymm7
        vmulps  %ymm7, %ymm5, %ymm9
        vfmadd213ps     %ymm0, %ymm9, %ymm7     # ymm7 = (ymm9 * ymm7) + ymm0
        vmulps  %ymm1, %ymm9, %ymm9
        vmulps  %ymm7, %ymm9, %ymm7
        vandps  %ymm2, %ymm5, %ymm5
        vcmpleps        %ymm5, %ymm3, %ymm5
        vrsqrtps        %ymm6, %ymm9
        vandps  %ymm7, %ymm5, %ymm5
        vmulps  %ymm6, %ymm9, %ymm7
        vfmadd213ps     %ymm0, %ymm7, %ymm9     # ymm9 = (ymm7 * ymm9) + ymm0
        vmulps  %ymm1, %ymm7, %ymm7
        vmulps  %ymm7, %ymm9, %ymm7
        vandps  %ymm2, %ymm6, %ymm6
        vcmpleps        %ymm6, %ymm3, %ymm6
        vandps  %ymm7, %ymm6, %ymm6
        vrsqrtps        %ymm8, %ymm7
        vmulps  %ymm7, %ymm8, %ymm9
        vfmadd213ps     %ymm0, %ymm9, %ymm7     # ymm7 = (ymm9 * ymm7) + ymm0
        vmulps  %ymm1, %ymm9, %ymm9
        vmulps  %ymm7, %ymm9, %ymm7
        vandps  %ymm2, %ymm8, %ymm8
        vcmpleps        %ymm8, %ymm3, %ymm8
        vandps  %ymm7, %ymm8, %ymm7
        vmovups %ymm4, (%rdi,%rcx,4)
        vmovups %ymm5, 32(%rdi,%rcx,4)
        vmovups %ymm6, 64(%rdi,%rcx,4)
        vmovups %ymm7, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB1_4
        cmpq    %rsi, %rax
        je      .LBB1_8
.LBB1_6:
        vmovss  .LCPI1_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        vmovss  .LCPI1_1(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
        vbroadcastss    .LCPI1_2(%rip), %xmm2   # xmm2 = [NaN,NaN,NaN,NaN]
        vmovss  .LCPI1_3(%rip), %xmm3           # xmm3 = mem[0],zero,zero,zero
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
        vrsqrtss        %xmm4, %xmm4, %xmm5
        vmulss  %xmm5, %xmm4, %xmm6
        vfmadd213ss     %xmm0, %xmm6, %xmm5     # xmm5 = (xmm6 * xmm5) + xmm0
        vmulss  %xmm1, %xmm6, %xmm6
        vmulss  %xmm5, %xmm6, %xmm5
        vandps  %xmm2, %xmm4, %xmm4
        vcmpltss        %xmm3, %xmm4, %xmm4
        vandnps %xmm5, %xmm4, %xmm4
        vmovss  %xmm4, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB1_7
.LBB1_8:
        vzeroupper
        retq
.LCPI2_0:
        .quad   0x8000000000000000              # double -0
.LCPI2_1:
        .quad   0x3fdfffffffffffff              # double 0.49999999999999994
.LCPI2_2:
        .quad   0x8000000000000000              # double -0
        .quad   0x8000000000000000              # double -0
Round_F64_D(double*, unsigned long):                     # @Round_F64_D(double*, unsigned long)
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
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB2_7
.LBB2_8:
        vzeroupper
        retq
.LCPI3_0:
        .long   0x80000000                      # float -0
.LCPI3_1:
        .long   0x3effffff                      # float 0.49999997
Round_F32_F(float*, unsigned long):                     # @Round_F32_F(float*, unsigned long)
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
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB3_7
.LBB3_8:
        vzeroupper
        retq
Floor_F64_D(double*, unsigned long):                     # @Floor_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB4_11
        cmpq    $16, %rsi
        jae     .LBB4_3
        xorl    %eax, %eax
        jmp     .LBB4_10
.LBB4_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB4_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
        vroundpd        $9, (%rdi,%rcx,8), %ymm0
        vroundpd        $9, 32(%rdi,%rcx,8), %ymm1
        vroundpd        $9, 64(%rdi,%rcx,8), %ymm2
        vroundpd        $9, 96(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        vroundpd        $9, 128(%rdi,%rcx,8), %ymm0
        vroundpd        $9, 160(%rdi,%rcx,8), %ymm1
        vroundpd        $9, 192(%rdi,%rcx,8), %ymm2
        vroundpd        $9, 224(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, 128(%rdi,%rcx,8)
        vmovupd %ymm1, 160(%rdi,%rcx,8)
        vmovupd %ymm2, 192(%rdi,%rcx,8)
        vmovupd %ymm3, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %rdx
        jne     .LBB4_6
        testb   $1, %r8b
        je      .LBB4_9
.LBB4_8:
        vroundpd        $9, (%rdi,%rcx,8), %ymm0
        vroundpd        $9, 32(%rdi,%rcx,8), %ymm1
        vroundpd        $9, 64(%rdi,%rcx,8), %ymm2
        vroundpd        $9, 96(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
.LBB4_9:
        cmpq    %rsi, %rax
        je      .LBB4_11
.LBB4_10:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vroundsd        $9, %xmm0, %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB4_10
.LBB4_11:
        vzeroupper
        retq
.LBB4_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB4_8
        jmp     .LBB4_9
Floor_F32_F(float*, unsigned long):                     # @Floor_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB5_11
        cmpq    $32, %rsi
        jae     .LBB5_3
        xorl    %eax, %eax
        jmp     .LBB5_10
.LBB5_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB5_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB5_6:                                # =>This Inner Loop Header: Depth=1
        vroundps        $9, (%rdi,%rcx,4), %ymm0
        vroundps        $9, 32(%rdi,%rcx,4), %ymm1
        vroundps        $9, 64(%rdi,%rcx,4), %ymm2
        vroundps        $9, 96(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        vroundps        $9, 128(%rdi,%rcx,4), %ymm0
        vroundps        $9, 160(%rdi,%rcx,4), %ymm1
        vroundps        $9, 192(%rdi,%rcx,4), %ymm2
        vroundps        $9, 224(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, 128(%rdi,%rcx,4)
        vmovups %ymm1, 160(%rdi,%rcx,4)
        vmovups %ymm2, 192(%rdi,%rcx,4)
        vmovups %ymm3, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %rdx
        jne     .LBB5_6
        testb   $1, %r8b
        je      .LBB5_9
.LBB5_8:
        vroundps        $9, (%rdi,%rcx,4), %ymm0
        vroundps        $9, 32(%rdi,%rcx,4), %ymm1
        vroundps        $9, 64(%rdi,%rcx,4), %ymm2
        vroundps        $9, 96(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
.LBB5_9:
        cmpq    %rsi, %rax
        je      .LBB5_11
.LBB5_10:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vroundss        $9, %xmm0, %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB5_10
.LBB5_11:
        vzeroupper
        retq
.LBB5_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB5_8
        jmp     .LBB5_9
Ceil_F64_D(double*, unsigned long):                      # @Ceil_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB6_11
        cmpq    $16, %rsi
        jae     .LBB6_3
        xorl    %eax, %eax
        jmp     .LBB6_10
.LBB6_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB6_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB6_6:                                # =>This Inner Loop Header: Depth=1
        vroundpd        $10, (%rdi,%rcx,8), %ymm0
        vroundpd        $10, 32(%rdi,%rcx,8), %ymm1
        vroundpd        $10, 64(%rdi,%rcx,8), %ymm2
        vroundpd        $10, 96(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        vroundpd        $10, 128(%rdi,%rcx,8), %ymm0
        vroundpd        $10, 160(%rdi,%rcx,8), %ymm1
        vroundpd        $10, 192(%rdi,%rcx,8), %ymm2
        vroundpd        $10, 224(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, 128(%rdi,%rcx,8)
        vmovupd %ymm1, 160(%rdi,%rcx,8)
        vmovupd %ymm2, 192(%rdi,%rcx,8)
        vmovupd %ymm3, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %rdx
        jne     .LBB6_6
        testb   $1, %r8b
        je      .LBB6_9
.LBB6_8:
        vroundpd        $10, (%rdi,%rcx,8), %ymm0
        vroundpd        $10, 32(%rdi,%rcx,8), %ymm1
        vroundpd        $10, 64(%rdi,%rcx,8), %ymm2
        vroundpd        $10, 96(%rdi,%rcx,8), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
.LBB6_9:
        cmpq    %rsi, %rax
        je      .LBB6_11
.LBB6_10:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vroundsd        $10, %xmm0, %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB6_10
.LBB6_11:
        vzeroupper
        retq
.LBB6_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB6_8
        jmp     .LBB6_9
Ceil_F32_F(float*, unsigned long):                      # @Ceil_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB7_11
        cmpq    $32, %rsi
        jae     .LBB7_3
        xorl    %eax, %eax
        jmp     .LBB7_10
.LBB7_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB7_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB7_6:                                # =>This Inner Loop Header: Depth=1
        vroundps        $10, (%rdi,%rcx,4), %ymm0
        vroundps        $10, 32(%rdi,%rcx,4), %ymm1
        vroundps        $10, 64(%rdi,%rcx,4), %ymm2
        vroundps        $10, 96(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        vroundps        $10, 128(%rdi,%rcx,4), %ymm0
        vroundps        $10, 160(%rdi,%rcx,4), %ymm1
        vroundps        $10, 192(%rdi,%rcx,4), %ymm2
        vroundps        $10, 224(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, 128(%rdi,%rcx,4)
        vmovups %ymm1, 160(%rdi,%rcx,4)
        vmovups %ymm2, 192(%rdi,%rcx,4)
        vmovups %ymm3, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %rdx
        jne     .LBB7_6
        testb   $1, %r8b
        je      .LBB7_9
.LBB7_8:
        vroundps        $10, (%rdi,%rcx,4), %ymm0
        vroundps        $10, 32(%rdi,%rcx,4), %ymm1
        vroundps        $10, 64(%rdi,%rcx,4), %ymm2
        vroundps        $10, 96(%rdi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
.LBB7_9:
        cmpq    %rsi, %rax
        je      .LBB7_11
.LBB7_10:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vroundss        $10, %xmm0, %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB7_10
.LBB7_11:
        vzeroupper
        retq
.LBB7_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB7_8
        jmp     .LBB7_9
.LCPI8_0:
        .long   0x00800000                      # float 1.17549435E-38
.LCPI8_1:
        .long   2155872255                      # 0x807fffff
.LCPI8_2:
        .long   1056964608                      # 0x3f000000
.LCPI8_3:
        .long   4294967169                      # 0xffffff81
.LCPI8_4:
        .long   0x3f800000                      # float 1
.LCPI8_5:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI8_6:
        .long   0xbf800000                      # float -1
.LCPI8_7:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI8_8:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI8_9:
        .long   0x3def251a                      # float 0.116769984
.LCPI8_10:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI8_11:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI8_12:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI8_13:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI8_14:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI8_15:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI8_16:
        .long   0x3f317218                      # float 0.693147182
.LCPI8_17:
        .long   0xbf000000                      # float -0.5
.LCPI8_18:
        .long   0x3ede5bd9                      # float 0.434294492
.LCPI8_19:
        .zero   32
Log10_Len8x_F32_V(float*, unsigned long):               # @Log10_Len8x_F32_V(float*, unsigned long)
        subq    $136, %rsp
        testq   %rsi, %rsi
        je      .LBB8_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI8_1(%rip), %ymm0   # ymm0 = [2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255]
        vmovups %ymm0, 96(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI8_2(%rip), %ymm0   # ymm0 = [1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI8_3(%rip), %ymm0   # ymm0 = [4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI8_0(%rip), %ymm0   # ymm0 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI8_4(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI8_5(%rip), %ymm0   # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI8_6(%rip), %ymm0   # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI8_7(%rip), %ymm0   # ymm0 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI8_8(%rip), %ymm9   # ymm9 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vbroadcastss    .LCPI8_9(%rip), %ymm10  # ymm10 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vbroadcastss    .LCPI8_10(%rip), %ymm11 # ymm11 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vbroadcastss    .LCPI8_11(%rip), %ymm12 # ymm12 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vbroadcastss    .LCPI8_12(%rip), %ymm13 # ymm13 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vbroadcastss    .LCPI8_13(%rip), %ymm14 # ymm14 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vbroadcastss    .LCPI8_14(%rip), %ymm15 # ymm15 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vbroadcastss    .LCPI8_15(%rip), %ymm0  # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vbroadcastss    .LCPI8_16(%rip), %ymm1  # ymm1 = [6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1]
        vbroadcastss    .LCPI8_17(%rip), %ymm2  # ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI8_18(%rip), %ymm3  # ymm3 = [4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1,4.34294492E-1]
.LBB8_2:                                # =>This Inner Loop Header: Depth=1
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
        vcmpleps        .LCPI8_19(%rip), %ymm4, %ymm4
        vmulps  %ymm3, %ymm6, %ymm5
        vorps   %ymm5, %ymm4, %ymm4
        vmovups %ymm4, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB8_2
.LBB8_3:
        addq    $136, %rsp
        vzeroupper
        retq
.LCPI9_0:
        .long   0x00800000                      # float 1.17549435E-38
.LCPI9_1:
        .long   2155872255                      # 0x807fffff
.LCPI9_2:
        .long   1056964608                      # 0x3f000000
.LCPI9_3:
        .long   4294967169                      # 0xffffff81
.LCPI9_4:
        .long   0x3f800000                      # float 1
.LCPI9_5:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI9_6:
        .long   0xbf800000                      # float -1
.LCPI9_7:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI9_8:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI9_9:
        .long   0x3def251a                      # float 0.116769984
.LCPI9_10:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI9_11:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI9_12:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI9_13:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI9_14:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI9_15:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI9_16:
        .long   0x3f317218                      # float 0.693147182
.LCPI9_17:
        .long   0xbf000000                      # float -0.5
.LCPI9_18:
        .long   0x3fb8aa3b                      # float 1.44269502
.LCPI9_19:
        .zero   32
Log2_Len8x_F32_V(float*, unsigned long):                # @Log2_Len8x_F32_V(float*, unsigned long)
        subq    $136, %rsp
        testq   %rsi, %rsi
        je      .LBB9_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI9_1(%rip), %ymm0   # ymm0 = [2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255]
        vmovups %ymm0, 96(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI9_2(%rip), %ymm0   # ymm0 = [1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI9_3(%rip), %ymm0   # ymm0 = [4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI9_0(%rip), %ymm0   # ymm0 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI9_4(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_5(%rip), %ymm0   # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_6(%rip), %ymm0   # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI9_7(%rip), %ymm0   # ymm0 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI9_8(%rip), %ymm9   # ymm9 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vbroadcastss    .LCPI9_9(%rip), %ymm10  # ymm10 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vbroadcastss    .LCPI9_10(%rip), %ymm11 # ymm11 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vbroadcastss    .LCPI9_11(%rip), %ymm12 # ymm12 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vbroadcastss    .LCPI9_12(%rip), %ymm13 # ymm13 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vbroadcastss    .LCPI9_13(%rip), %ymm14 # ymm14 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vbroadcastss    .LCPI9_14(%rip), %ymm15 # ymm15 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vbroadcastss    .LCPI9_15(%rip), %ymm0  # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vbroadcastss    .LCPI9_16(%rip), %ymm1  # ymm1 = [6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1]
        vbroadcastss    .LCPI9_17(%rip), %ymm2  # ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI9_18(%rip), %ymm3  # ymm3 = [1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0]
.LBB9_2:                                # =>This Inner Loop Header: Depth=1
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
        vcmpleps        .LCPI9_19(%rip), %ymm4, %ymm4
        vmulps  %ymm3, %ymm6, %ymm5
        vorps   %ymm5, %ymm4, %ymm4
        vmovups %ymm4, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB9_2
.LBB9_3:
        addq    $136, %rsp
        vzeroupper
        retq
.LCPI10_0:
        .long   0x00800000                      # float 1.17549435E-38
.LCPI10_1:
        .long   2155872255                      # 0x807fffff
.LCPI10_2:
        .long   1056964608                      # 0x3f000000
.LCPI10_3:
        .long   4294967169                      # 0xffffff81
.LCPI10_4:
        .long   0x3f800000                      # float 1
.LCPI10_5:
        .long   0x3f3504f3                      # float 0.707106769
.LCPI10_6:
        .long   0xbf800000                      # float -1
.LCPI10_7:
        .long   0x3d9021bb                      # float 0.0703768358
.LCPI10_8:
        .long   0xbdebd1b8                      # float -0.115146101
.LCPI10_9:
        .long   0x3def251a                      # float 0.116769984
.LCPI10_10:
        .long   0xbdfe5d4f                      # float -0.12420141
.LCPI10_11:
        .long   0x3e11e9bf                      # float 0.142493233
.LCPI10_12:
        .long   0xbe2aae50                      # float -0.166680574
.LCPI10_13:
        .long   0x3e4cceac                      # float 0.200007141
.LCPI10_14:
        .long   0xbe7ffffc                      # float -0.24999994
.LCPI10_15:
        .long   0x3eaaaaaa                      # float 0.333333313
.LCPI10_16:
        .long   0x3f317218                      # float 0.693147182
.LCPI10_17:
        .long   0xbf000000                      # float -0.5
.LCPI10_18:
        .zero   32
Log_Len8x_F32_V(float*, unsigned long):                 # @Log_Len8x_F32_V(float*, unsigned long)
        subq    $104, %rsp
        testq   %rsi, %rsi
        je      .LBB10_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI10_0(%rip), %ymm0  # ymm0 = [1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38,1.17549435E-38]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI10_1(%rip), %ymm0  # ymm0 = [2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255,2155872255]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI10_2(%rip), %ymm0  # ymm0 = [1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608,1056964608]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI10_3(%rip), %ymm0  # ymm0 = [4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169,4294967169]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI10_4(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI10_5(%rip), %ymm0  # ymm0 = [7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1,7.07106769E-1]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI10_6(%rip), %ymm0  # ymm0 = [-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0,-1.0E+0]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI10_7(%rip), %ymm8  # ymm8 = [7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2,7.03768358E-2]
        vbroadcastss    .LCPI10_8(%rip), %ymm9  # ymm9 = [-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1,-1.15146101E-1]
        vbroadcastss    .LCPI10_9(%rip), %ymm10 # ymm10 = [1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1,1.16769984E-1]
        vbroadcastss    .LCPI10_10(%rip), %ymm11 # ymm11 = [-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1,-1.2420141E-1]
        vbroadcastss    .LCPI10_11(%rip), %ymm12 # ymm12 = [1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1,1.42493233E-1]
        vbroadcastss    .LCPI10_12(%rip), %ymm13 # ymm13 = [-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1,-1.66680574E-1]
        vbroadcastss    .LCPI10_13(%rip), %ymm14 # ymm14 = [2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1,2.00007141E-1]
        vbroadcastss    .LCPI10_14(%rip), %ymm15 # ymm15 = [-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1,-2.4999994E-1]
        vbroadcastss    .LCPI10_15(%rip), %ymm0 # ymm0 = [3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1,3.33333313E-1]
        vbroadcastss    .LCPI10_16(%rip), %ymm1 # ymm1 = [6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1,6.93147182E-1]
        vbroadcastss    .LCPI10_17(%rip), %ymm2 # ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
.LBB10_2:                               # =>This Inner Loop Header: Depth=1
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
        vcmpleps        .LCPI10_18(%rip), %ymm3, %ymm3
        vorps   %ymm5, %ymm3, %ymm3
        vmovups %ymm3, (%rdi,%rax,4)
        addq    $8, %rax
        cmpq    %rsi, %rax
        jb      .LBB10_2
.LBB10_3:
        addq    $104, %rsp
        vzeroupper
        retq
.LCPI11_0:
        .long   0x42b17218                      # float 88.7228394
.LCPI11_1:
        .long   0xc2ce8ed0                      # float -103.278931
.LCPI11_2:
        .long   0x3f000000                      # float 0.5
.LCPI11_3:
        .long   0x3fb8aa3b                      # float 1.44269502
.LCPI11_4:
        .long   0xbf318000                      # float -0.693359375
.LCPI11_5:
        .long   0x395e8083                      # float 2.12194442E-4
.LCPI11_6:
        .long   1065353216                      # 0x3f800000
.LCPI11_7:
        .long   0x3ab743ce                      # float 0.00139819994
.LCPI11_8:
        .long   0x39506967                      # float 1.98756912E-4
.LCPI11_9:
        .long   0x3c088908                      # float 0.00833345205
.LCPI11_10:
        .long   0x3d2aa9c1                      # float 0.0416657962
.LCPI11_11:
        .long   0x3e2aaaaa                      # float 0.166666657
.LCPI11_12:
        .long   0x7f7fffff                      # float 3.40282347E+38
Exp_Len8x_F32_V(float*, unsigned long):                 # @Exp_Len8x_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB11_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI11_0(%rip), %ymm0  # ymm0 = [8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1,8.87228394E+1]
        vmovups %ymm0, -40(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_1(%rip), %ymm0  # ymm0 = [-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2,-1.03278931E+2]
        vmovups %ymm0, -72(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI11_2(%rip), %ymm2  # ymm2 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1,5.0E-1]
        vbroadcastss    .LCPI11_3(%rip), %ymm3  # ymm3 = [1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0,1.44269502E+0]
        vbroadcastss    .LCPI11_4(%rip), %ymm4  # ymm4 = [-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1,-6.93359375E-1]
        vbroadcastss    .LCPI11_5(%rip), %ymm5  # ymm5 = [2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4,2.12194442E-4]
        vpbroadcastd    .LCPI11_6(%rip), %ymm6  # ymm6 = [1065353216,1065353216,1065353216,1065353216,1065353216,1065353216,1065353216,1065353216]
        vbroadcastss    .LCPI11_7(%rip), %ymm7  # ymm7 = [1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3,1.39819994E-3]
        vbroadcastss    .LCPI11_8(%rip), %ymm1  # ymm1 = [1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4,1.98756912E-4]
        vbroadcastss    .LCPI11_9(%rip), %ymm9  # ymm9 = [8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3,8.33345205E-3]
        vbroadcastss    .LCPI11_10(%rip), %ymm10 # ymm10 = [4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2,4.16657962E-2]
        vbroadcastss    .LCPI11_11(%rip), %ymm11 # ymm11 = [1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1,1.66666657E-1]
        vbroadcastss    .LCPI11_12(%rip), %ymm12 # ymm12 = [3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38]
.LBB11_2:                               # =>This Inner Loop Header: Depth=1
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
        jb      .LBB11_2
.LBB11_3:
        vzeroupper
        retq
.LCPI12_0:
        .long   2147483647                      # 0x7fffffff
.LCPI12_1:
        .long   0x3fa2f983                      # float 1.27323949
.LCPI12_2:
        .long   4294967294                      # 0xfffffffe
.LCPI12_3:
        .long   2                               # 0x2
.LCPI12_4:
        .long   0xbf490fdb                      # float -0.785398185
.LCPI12_5:
        .long   2147483648                      # 0x80000000
.LCPI12_6:
        .long   0x37ccf5ce                      # float 2.44331568E-5
.LCPI12_7:
        .long   0xbab6061a                      # float -0.00138873165
.LCPI12_8:
        .long   0x3d2aaaa5                      # float 0.0416666456
.LCPI12_9:
        .long   0xbf000000                      # float -0.5
.LCPI12_10:
        .long   0x3f800000                      # float 1
.LCPI12_11:
        .long   0xb94ca1f9                      # float -1.95152956E-4
.LCPI12_12:
        .long   0x3c08839e                      # float 0.00833216123
.LCPI12_13:
        .long   0xbe2aaaa3                      # float -0.166666552
.LCPI12_14:
        .long   0x4b7fffff                      # float 16777215
.LCPI12_15:
        .zero   32,255
.LCPI12_16:
        .zero   32
Sin_F32_V(float*, unsigned long):                        # @Sin_F32_V(float*, unsigned long)
        pushq   %rax
        movq    %rsi, %rax
        andq    $-8, %rax
        je      .LBB12_3
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI12_0(%rip), %ymm0  # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI12_1(%rip), %ymm0  # ymm0 = [1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI12_2(%rip), %ymm0  # ymm0 = [4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI12_3(%rip), %ymm4  # ymm4 = [2,2,2,2,2,2,2,2]
        vpbroadcastd    .LCPI12_4(%rip), %ymm0  # ymm0 = [-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1]
        vmovdqu %ymm0, -128(%rsp)               # 32-byte Spill
        vpbroadcastd    .LCPI12_5(%rip), %ymm7  # ymm7 = [2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648]
        vbroadcastss    .LCPI12_6(%rip), %ymm8  # ymm8 = [2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5]
        vbroadcastss    .LCPI12_7(%rip), %ymm9  # ymm9 = [-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3]
        vbroadcastss    .LCPI12_8(%rip), %ymm10 # ymm10 = [4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2]
        vbroadcastss    .LCPI12_9(%rip), %ymm11 # ymm11 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI12_10(%rip), %ymm12 # ymm12 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI12_11(%rip), %ymm3 # ymm3 = [-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4]
        vbroadcastss    .LCPI12_12(%rip), %ymm14 # ymm14 = [8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3]
        vbroadcastss    .LCPI12_13(%rip), %ymm15 # ymm15 = [-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1]
.LBB12_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm2
        vandps  -32(%rsp), %ymm2, %ymm5         # 32-byte Folded Reload
        vmulps  -64(%rsp), %ymm5, %ymm0         # 32-byte Folded Reload
        vcvttps2dq      %ymm0, %ymm0
        vpsubd  .LCPI12_15(%rip), %ymm0, %ymm0
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
        vpcmpeqd        .LCPI12_16(%rip), %ymm0, %ymm0
        vandps  %ymm0, %ymm6, %ymm0
        vaddps  %ymm2, %ymm0, %ymm0
        vpand   %ymm7, %ymm1, %ymm1
        vpxor   %ymm0, %ymm1, %ymm0
        vmovdqu %ymm0, (%rdi,%rcx,4)
        addq    $8, %rcx
        cmpq    %rax, %rcx
        jb      .LBB12_2
.LBB12_3:
        cmpq    %rsi, %rax
        jae     .LBB12_14
        vbroadcastss    .LCPI12_5(%rip), %xmm0  # xmm0 = [2147483648,2147483648,2147483648,2147483648]
        vpxor   %xmm1, %xmm1, %xmm1
        vmovss  .LCPI12_14(%rip), %xmm2         # xmm2 = mem[0],zero,zero,zero
        vmovss  .LCPI12_10(%rip), %xmm9         # xmm9 = mem[0],zero,zero,zero
        vmovss  .LCPI12_4(%rip), %xmm10         # xmm10 = mem[0],zero,zero,zero
        vmovss  .LCPI12_6(%rip), %xmm12         # xmm12 = mem[0],zero,zero,zero
        vmovss  .LCPI12_7(%rip), %xmm11         # xmm11 = mem[0],zero,zero,zero
        vmovss  .LCPI12_8(%rip), %xmm13         # xmm13 = mem[0],zero,zero,zero
        vmovss  .LCPI12_9(%rip), %xmm14         # xmm14 = mem[0],zero,zero,zero
        vmovss  .LCPI12_11(%rip), %xmm8         # xmm8 = mem[0],zero,zero,zero
        vmovss  .LCPI12_12(%rip), %xmm15        # xmm15 = mem[0],zero,zero,zero
        vmovss  .LCPI12_13(%rip), %xmm6         # xmm6 = mem[0],zero,zero,zero
        jmp     .LBB12_5
.LBB12_13:                              #   in Loop: Header=BB12_5 Depth=1
        addq    $1, %rax
        cmpq    %rsi, %rax
        jae     .LBB12_14
.LBB12_5:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm4, %xmm3
        vcmpltss        %xmm1, %xmm4, %xmm5
        vblendvps       %xmm5, %xmm3, %xmm4, %xmm3
        vucomiss        %xmm2, %xmm3
        ja      .LBB12_13
        vucomiss        %xmm1, %xmm4
        setb    %r8b
        vmulss  .LCPI12_1(%rip), %xmm3, %xmm4
        vcvttss2si      %xmm4, %edx
        vroundss        $11, %xmm4, %xmm4, %xmm4
        movl    %edx, %ecx
        andl    $1, %ecx
        je      .LBB12_8
        vaddss  %xmm4, %xmm9, %xmm4
.LBB12_8:                               #   in Loop: Header=BB12_5 Depth=1
        addl    %edx, %ecx
        andl    $7, %ecx
        leal    -4(%rcx), %edx
        cmpl    $4, %ecx
        setae   %r9b
        cmovbl  %ecx, %edx
        vfmadd231ss     %xmm10, %xmm4, %xmm3    # xmm3 = (xmm4 * xmm10) + xmm3
        vmulss  %xmm3, %xmm3, %xmm4
        vmovaps %xmm12, %xmm7
        vfmadd213ss     %xmm11, %xmm4, %xmm7    # xmm7 = (xmm4 * xmm7) + xmm11
        vfmadd213ss     %xmm13, %xmm4, %xmm7    # xmm7 = (xmm4 * xmm7) + xmm13
        vfmadd213ss     %xmm14, %xmm4, %xmm7    # xmm7 = (xmm4 * xmm7) + xmm14
        vmovaps %xmm8, %xmm5
        vfmadd213ss     %xmm15, %xmm4, %xmm5    # xmm5 = (xmm4 * xmm5) + xmm15
        vfmadd213ss     %xmm6, %xmm4, %xmm5     # xmm5 = (xmm4 * xmm5) + xmm6
        addl    $-1, %edx
        cmpl    $2, %edx
        jb      .LBB12_9
        vmulss  %xmm3, %xmm4, %xmm4
        vfmadd213ss     %xmm3, %xmm4, %xmm5     # xmm5 = (xmm4 * xmm5) + xmm3
        vmovaps %xmm5, %xmm4
        vmovss  %xmm4, (%rdi,%rax,4)
        cmpb    %r9b, %r8b
        je      .LBB12_13
        jmp     .LBB12_12
.LBB12_9:                               #   in Loop: Header=BB12_5 Depth=1
        vfmadd213ss     %xmm9, %xmm7, %xmm4     # xmm4 = (xmm7 * xmm4) + xmm9
        vmovss  %xmm4, (%rdi,%rax,4)
        cmpb    %r9b, %r8b
        je      .LBB12_13
.LBB12_12:                              #   in Loop: Header=BB12_5 Depth=1
        vxorps  %xmm0, %xmm4, %xmm3
        vmovss  %xmm3, (%rdi,%rax,4)
        jmp     .LBB12_13
.LBB12_14:
        popq    %rax
        vzeroupper
        retq
.LCPI13_0:
        .long   2147483647                      # 0x7fffffff
.LCPI13_1:
        .long   0x3fa2f983                      # float 1.27323949
.LCPI13_2:
        .long   4294967294                      # 0xfffffffe
.LCPI13_3:
        .long   2                               # 0x2
.LCPI13_4:
        .long   0xbf490fdb                      # float -0.785398185
.LCPI13_5:
        .long   3221225472                      # 0xc0000000
.LCPI13_6:
        .long   0x37ccf5ce                      # float 2.44331568E-5
.LCPI13_7:
        .long   0xbab6061a                      # float -0.00138873165
.LCPI13_8:
        .long   0x3d2aaaa5                      # float 0.0416666456
.LCPI13_9:
        .long   0xbf000000                      # float -0.5
.LCPI13_10:
        .long   0x3f800000                      # float 1
.LCPI13_11:
        .long   0xb94ca1f9                      # float -1.95152956E-4
.LCPI13_12:
        .long   0x3c08839e                      # float 0.00833216123
.LCPI13_13:
        .long   0xbe2aaaa3                      # float -0.166666552
.LCPI13_14:
        .long   2147483648                      # 0x80000000
.LCPI13_15:
        .long   0x4b7fffff                      # float 16777215
.LCPI13_16:
        .zero   32,255
.LCPI13_17:
        .zero   32
Cos_F32_V(float*, unsigned long):                        # @Cos_F32_V(float*, unsigned long)
        subq    $72, %rsp
        movq    %rsi, %rax
        andq    $-8, %rax
        je      .LBB13_3
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI13_0(%rip), %ymm0  # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI13_1(%rip), %ymm0  # ymm0 = [1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vbroadcastss    .LCPI13_2(%rip), %ymm0  # ymm0 = [4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI13_3(%rip), %ymm4  # ymm4 = [2,2,2,2,2,2,2,2]
        vbroadcastss    .LCPI13_4(%rip), %ymm0  # ymm0 = [-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI13_5(%rip), %ymm0  # ymm0 = [3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI13_6(%rip), %ymm0  # ymm0 = [2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI13_7(%rip), %ymm9  # ymm9 = [-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3]
        vbroadcastss    .LCPI13_8(%rip), %ymm10 # ymm10 = [4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2]
        vbroadcastss    .LCPI13_9(%rip), %ymm6  # ymm6 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI13_10(%rip), %ymm12 # ymm12 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI13_11(%rip), %ymm13 # ymm13 = [-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4]
        vbroadcastss    .LCPI13_12(%rip), %ymm14 # ymm14 = [8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3]
        vbroadcastss    .LCPI13_13(%rip), %ymm15 # ymm15 = [-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1]
        vpbroadcastd    .LCPI13_14(%rip), %ymm2 # ymm2 = [2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648]
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
        vmovups 32(%rsp), %ymm0                 # 32-byte Reload
        vandps  (%rdi,%rcx,4), %ymm0, %ymm5
        vmulps  (%rsp), %ymm5, %ymm0            # 32-byte Folded Reload
        vcvttps2dq      %ymm0, %ymm0
        vpsubd  .LCPI13_16(%rip), %ymm0, %ymm0
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
        vpcmpeqd        .LCPI13_17(%rip), %ymm0, %ymm0
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
        jb      .LBB13_2
.LBB13_3:
        cmpq    %rsi, %rax
        jae     .LBB13_14
        vbroadcastss    .LCPI13_14(%rip), %xmm0 # xmm0 = [2147483648,2147483648,2147483648,2147483648]
        vxorps  %xmm1, %xmm1, %xmm1
        vmovss  .LCPI13_15(%rip), %xmm2         # xmm2 = mem[0],zero,zero,zero
        vmovss  .LCPI13_10(%rip), %xmm9         # xmm9 = mem[0],zero,zero,zero
        vmovss  .LCPI13_4(%rip), %xmm10         # xmm10 = mem[0],zero,zero,zero
        vmovss  .LCPI13_6(%rip), %xmm8          # xmm8 = mem[0],zero,zero,zero
        vmovss  .LCPI13_7(%rip), %xmm11         # xmm11 = mem[0],zero,zero,zero
        vmovss  .LCPI13_8(%rip), %xmm13         # xmm13 = mem[0],zero,zero,zero
        vmovss  .LCPI13_9(%rip), %xmm14         # xmm14 = mem[0],zero,zero,zero
        vmovss  .LCPI13_11(%rip), %xmm7         # xmm7 = mem[0],zero,zero,zero
        vmovss  .LCPI13_12(%rip), %xmm15        # xmm15 = mem[0],zero,zero,zero
        vmovss  .LCPI13_13(%rip), %xmm6         # xmm6 = mem[0],zero,zero,zero
        jmp     .LBB13_5
.LBB13_13:                              #   in Loop: Header=BB13_5 Depth=1
        addq    $1, %rax
        cmpq    %rsi, %rax
        jae     .LBB13_14
.LBB13_5:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm3, %xmm4
        vcmpltss        %xmm1, %xmm3, %xmm5
        vblendvps       %xmm5, %xmm4, %xmm3, %xmm3
        vucomiss        %xmm2, %xmm3
        ja      .LBB13_13
        vmulss  .LCPI13_1(%rip), %xmm3, %xmm4
        vcvttss2si      %xmm4, %edx
        vroundss        $11, %xmm4, %xmm4, %xmm4
        movl    %edx, %ecx
        andl    $1, %ecx
        je      .LBB13_8
        vaddss  %xmm4, %xmm9, %xmm4
.LBB13_8:                               #   in Loop: Header=BB13_5 Depth=1
        addl    %edx, %ecx
        andl    $7, %ecx
        leal    -4(%rcx), %edx
        cmpl    $4, %ecx
        cmovbl  %ecx, %edx
        setae   %r8b
        cmpl    $2, %edx
        setae   %cl
        vfmadd231ss     %xmm10, %xmm4, %xmm3    # xmm3 = (xmm4 * xmm10) + xmm3
        vmulss  %xmm3, %xmm3, %xmm4
        vmovaps %xmm8, %xmm12
        vfmadd213ss     %xmm11, %xmm4, %xmm12   # xmm12 = (xmm4 * xmm12) + xmm11
        vfmadd213ss     %xmm13, %xmm4, %xmm12   # xmm12 = (xmm4 * xmm12) + xmm13
        vfmadd213ss     %xmm14, %xmm4, %xmm12   # xmm12 = (xmm4 * xmm12) + xmm14
        vmovaps %xmm7, %xmm5
        vfmadd213ss     %xmm15, %xmm4, %xmm5    # xmm5 = (xmm4 * xmm5) + xmm15
        vfmadd213ss     %xmm6, %xmm4, %xmm5     # xmm5 = (xmm4 * xmm5) + xmm6
        addl    $-1, %edx
        cmpl    $2, %edx
        jb      .LBB13_9
        vfmadd213ss     %xmm9, %xmm12, %xmm4    # xmm4 = (xmm12 * xmm4) + xmm9
        vmovaps %xmm4, %xmm5
        vmovss  %xmm5, (%rdi,%rax,4)
        cmpb    %cl, %r8b
        je      .LBB13_13
        jmp     .LBB13_12
.LBB13_9:                               #   in Loop: Header=BB13_5 Depth=1
        vmulss  %xmm3, %xmm4, %xmm4
        vfmadd213ss     %xmm3, %xmm4, %xmm5     # xmm5 = (xmm4 * xmm5) + xmm3
        vmovss  %xmm5, (%rdi,%rax,4)
        cmpb    %cl, %r8b
        je      .LBB13_13
.LBB13_12:                              #   in Loop: Header=BB13_5 Depth=1
        vxorps  %xmm0, %xmm5, %xmm3
        vmovss  %xmm3, (%rdi,%rax,4)
        jmp     .LBB13_13
.LBB13_14:
        addq    $72, %rsp
        vzeroupper
        retq
.LCPI14_0:
        .long   2147483647                      # 0x7fffffff
.LCPI14_1:
        .long   0x3fa2f983                      # float 1.27323949
.LCPI14_2:
        .long   4294967294                      # 0xfffffffe
.LCPI14_3:
        .long   2                               # 0x2
.LCPI14_4:
        .long   0xbf490fdb                      # float -0.785398185
.LCPI14_5:
        .long   3221225472                      # 0xc0000000
.LCPI14_6:
        .long   2147483648                      # 0x80000000
.LCPI14_7:
        .long   0x37ccf5ce                      # float 2.44331568E-5
.LCPI14_8:
        .long   0xbab6061a                      # float -0.00138873165
.LCPI14_9:
        .long   0x3d2aaaa5                      # float 0.0416666456
.LCPI14_10:
        .long   0xbf000000                      # float -0.5
.LCPI14_11:
        .long   0x3f800000                      # float 1
.LCPI14_12:
        .long   0xb94ca1f9                      # float -1.95152956E-4
.LCPI14_13:
        .long   0x3c08839e                      # float 0.00833216123
.LCPI14_14:
        .long   0xbe2aaaa3                      # float -0.166666552
.LCPI14_15:
        .long   0x4b7fffff                      # float 16777215
.LCPI14_16:
        .zero   32,255
.LCPI14_17:
        .zero   32
SinCos_F32_V(float*, float*, float*, unsigned long):                # @SinCos_F32_V(float*, float*, float*, unsigned long)
        pushq   %rbx
        subq    $96, %rsp
        movq    %rcx, %r8
        andq    $-8, %r8
        je      .LBB14_3
        xorl    %eax, %eax
        vbroadcastss    .LCPI14_0(%rip), %ymm0  # ymm0 = [2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647]
        vmovups %ymm0, 64(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI14_1(%rip), %ymm0  # ymm0 = [1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0,1.27323949E+0]
        vmovups %ymm0, 32(%rsp)                 # 32-byte Spill
        vbroadcastss    .LCPI14_2(%rip), %ymm0  # ymm0 = [4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294,4294967294]
        vmovups %ymm0, (%rsp)                   # 32-byte Spill
        vpbroadcastd    .LCPI14_3(%rip), %ymm4  # ymm4 = [2,2,2,2,2,2,2,2]
        vbroadcastss    .LCPI14_4(%rip), %ymm0  # ymm0 = [-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1,-7.85398185E-1]
        vmovups %ymm0, -32(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI14_5(%rip), %ymm0  # ymm0 = [3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472,3221225472]
        vmovups %ymm0, -64(%rsp)                # 32-byte Spill
        vpbroadcastd    .LCPI14_6(%rip), %ymm8  # ymm8 = [2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648,2147483648]
        vbroadcastss    .LCPI14_7(%rip), %ymm0  # ymm0 = [2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5,2.44331568E-5]
        vmovups %ymm0, -96(%rsp)                # 32-byte Spill
        vbroadcastss    .LCPI14_8(%rip), %ymm0  # ymm0 = [-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3,-1.38873165E-3]
        vmovups %ymm0, -128(%rsp)               # 32-byte Spill
        vbroadcastss    .LCPI14_9(%rip), %ymm11 # ymm11 = [4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2,4.16666456E-2]
        vbroadcastss    .LCPI14_10(%rip), %ymm10 # ymm10 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
        vbroadcastss    .LCPI14_11(%rip), %ymm13 # ymm13 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vbroadcastss    .LCPI14_12(%rip), %ymm14 # ymm14 = [-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4,-1.95152956E-4]
        vbroadcastss    .LCPI14_13(%rip), %ymm15 # ymm15 = [8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3,8.33216123E-3]
        vbroadcastss    .LCPI14_14(%rip), %ymm2 # ymm2 = [-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1,-1.66666552E-1]
.LBB14_2:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdx,%rax,4), %ymm5
        vandps  64(%rsp), %ymm5, %ymm1          # 32-byte Folded Reload
        vmulps  32(%rsp), %ymm1, %ymm0          # 32-byte Folded Reload
        vcvttps2dq      %ymm0, %ymm0
        vpsubd  .LCPI14_16(%rip), %ymm0, %ymm3
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
        vpcmpeqd        .LCPI14_17(%rip), %ymm3, %ymm3
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
        jb      .LBB14_2
.LBB14_3:
        cmpq    %rcx, %r8
        jae     .LBB14_16
        vbroadcastss    .LCPI14_6(%rip), %xmm0  # xmm0 = [2147483648,2147483648,2147483648,2147483648]
        vxorps  %xmm1, %xmm1, %xmm1
        vmovss  .LCPI14_15(%rip), %xmm2         # xmm2 = mem[0],zero,zero,zero
        vmovss  .LCPI14_11(%rip), %xmm6         # xmm6 = mem[0],zero,zero,zero
        vmovss  .LCPI14_7(%rip), %xmm8          # xmm8 = mem[0],zero,zero,zero
        vmovss  .LCPI14_9(%rip), %xmm12         # xmm12 = mem[0],zero,zero,zero
        vmovss  .LCPI14_10(%rip), %xmm13        # xmm13 = mem[0],zero,zero,zero
        vmovss  .LCPI14_12(%rip), %xmm15        # xmm15 = mem[0],zero,zero,zero
        vmovss  .LCPI14_13(%rip), %xmm14        # xmm14 = mem[0],zero,zero,zero
        vmovss  .LCPI14_14(%rip), %xmm10        # xmm10 = mem[0],zero,zero,zero
        jmp     .LBB14_5
.LBB14_15:                              #   in Loop: Header=BB14_5 Depth=1
        addq    $1, %r8
        cmpq    %rcx, %r8
        jae     .LBB14_16
.LBB14_5:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdx,%r8,4), %xmm4             # xmm4 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm4, %xmm5
        vcmpltss        %xmm1, %xmm4, %xmm7
        vblendvps       %xmm7, %xmm5, %xmm4, %xmm5
        vucomiss        %xmm2, %xmm5
        ja      .LBB14_15
        vucomiss        %xmm1, %xmm4
        setb    %r9b
        vmulss  .LCPI14_1(%rip), %xmm5, %xmm4
        vcvttss2si      %xmm4, %r10d
        vroundss        $11, %xmm4, %xmm4, %xmm4
        movl    %r10d, %eax
        andl    $1, %eax
        je      .LBB14_8
        vaddss  %xmm6, %xmm4, %xmm4
.LBB14_8:                               #   in Loop: Header=BB14_5 Depth=1
        addl    %r10d, %eax
        andl    $7, %eax
        leal    -4(%rax), %r10d
        cmpl    $4, %eax
        setae   %r11b
        cmovbl  %eax, %r10d
        vfmadd231ss     .LCPI14_4(%rip), %xmm4, %xmm5 # xmm5 = (xmm4 * mem) + xmm5
        vmulss  %xmm5, %xmm5, %xmm7
        vmovaps %xmm8, %xmm11
        vfmadd213ss     .LCPI14_8(%rip), %xmm7, %xmm11 # xmm11 = (xmm7 * xmm11) + mem
        vfmadd213ss     %xmm12, %xmm7, %xmm11   # xmm11 = (xmm7 * xmm11) + xmm12
        vmulss  %xmm7, %xmm7, %xmm9
        vmovaps %xmm6, %xmm4
        vfmadd231ss     %xmm13, %xmm7, %xmm4    # xmm4 = (xmm7 * xmm13) + xmm4
        vfmadd231ss     %xmm9, %xmm11, %xmm4    # xmm4 = (xmm11 * xmm9) + xmm4
        vmovaps %xmm15, %xmm3
        vfmadd213ss     %xmm14, %xmm7, %xmm3    # xmm3 = (xmm7 * xmm3) + xmm14
        vfmadd213ss     %xmm10, %xmm7, %xmm3    # xmm3 = (xmm7 * xmm3) + xmm10
        vmulss  %xmm5, %xmm7, %xmm7
        vfmadd213ss     %xmm5, %xmm3, %xmm7     # xmm7 = (xmm3 * xmm7) + xmm5
        leal    -1(%r10), %ebx
        cmpl    $2, %ebx
        jb      .LBB14_9
        vmovaps %xmm7, %xmm5
        vmovss  %xmm5, (%rdi,%r8,4)
        vmovss  %xmm4, (%rsi,%r8,4)
        cmpb    %r11b, %r9b
        jne     .LBB14_12
        jmp     .LBB14_13
.LBB14_9:                               #   in Loop: Header=BB14_5 Depth=1
        vmovaps %xmm4, %xmm5
        vmovaps %xmm7, %xmm4
        vmovss  %xmm5, (%rdi,%r8,4)
        vmovss  %xmm4, (%rsi,%r8,4)
        cmpb    %r11b, %r9b
        je      .LBB14_13
.LBB14_12:                              #   in Loop: Header=BB14_5 Depth=1
        vmovss  (%rdi,%r8,4), %xmm3             # xmm3 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm3, %xmm3
        vmovss  %xmm3, (%rdi,%r8,4)
.LBB14_13:                              #   in Loop: Header=BB14_5 Depth=1
        cmpl    $2, %r10d
        setae   %bl
        cmpl    $4, %eax
        setae   %al
        cmpb    %bl, %al
        je      .LBB14_15
        vmovss  (%rsi,%r8,4), %xmm3             # xmm3 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm3, %xmm3
        vmovss  %xmm3, (%rsi,%r8,4)
        jmp     .LBB14_15
.LBB14_16:
        addq    $96, %rsp
        popq    %rbx
        vzeroupper
        retq