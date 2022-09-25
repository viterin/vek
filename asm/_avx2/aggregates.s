Sum_F64_D(double*, unsigned long):                        # @Sum_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB0_1
        cmpq    $16, %rsi
        jae     .LBB0_4
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB0_11
.LBB0_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB0_4:
        movq    %rsi, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB0_5
        movq    %r8, %rcx
        andq    $-2, %rcx
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorpd  %xmm1, %xmm1, %xmm1
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
        vaddpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vaddpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vaddpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vaddpd  96(%rdi,%rdx,8), %ymm3, %ymm3
        vaddpd  128(%rdi,%rdx,8), %ymm0, %ymm0
        vaddpd  160(%rdi,%rdx,8), %ymm1, %ymm1
        vaddpd  192(%rdi,%rdx,8), %ymm2, %ymm2
        vaddpd  224(%rdi,%rdx,8), %ymm3, %ymm3
        addq    $32, %rdx
        addq    $-2, %rcx
        jne     .LBB0_7
        testb   $1, %r8b
        je      .LBB0_10
.LBB0_9:
        vaddpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vaddpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vaddpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vaddpd  96(%rdi,%rdx,8), %ymm3, %ymm3
.LBB0_10:
        vaddpd  %ymm3, %ymm1, %ymm1
        vaddpd  %ymm2, %ymm0, %ymm0
        vaddpd  %ymm1, %ymm0, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB0_12
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
        vaddsd  (%rdi,%rax,8), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_11
.LBB0_12:
        vzeroupper
        retq
.LBB0_5:
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorpd  %xmm1, %xmm1, %xmm1
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
        testb   $1, %r8b
        jne     .LBB0_9
        jmp     .LBB0_10
Sum_F32_F(float*, unsigned long):                        # @Sum_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB1_1
        cmpq    $32, %rsi
        jae     .LBB1_4
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB1_11
.LBB1_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB1_4:
        movq    %rsi, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB1_5
        movq    %r8, %rcx
        andq    $-2, %rcx
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorps  %xmm1, %xmm1, %xmm1
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        vaddps  (%rdi,%rdx,4), %ymm0, %ymm0
        vaddps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vaddps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vaddps  96(%rdi,%rdx,4), %ymm3, %ymm3
        vaddps  128(%rdi,%rdx,4), %ymm0, %ymm0
        vaddps  160(%rdi,%rdx,4), %ymm1, %ymm1
        vaddps  192(%rdi,%rdx,4), %ymm2, %ymm2
        vaddps  224(%rdi,%rdx,4), %ymm3, %ymm3
        addq    $64, %rdx
        addq    $-2, %rcx
        jne     .LBB1_7
        testb   $1, %r8b
        je      .LBB1_10
.LBB1_9:
        vaddps  (%rdi,%rdx,4), %ymm0, %ymm0
        vaddps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vaddps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vaddps  96(%rdi,%rdx,4), %ymm3, %ymm3
.LBB1_10:
        vaddps  %ymm3, %ymm1, %ymm1
        vaddps  %ymm2, %ymm0, %ymm0
        vaddps  %ymm1, %ymm0, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vaddss  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB1_12
.LBB1_11:                               # =>This Inner Loop Header: Depth=1
        vaddss  (%rdi,%rax,4), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB1_11
.LBB1_12:
        vzeroupper
        retq
.LBB1_5:
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorps  %xmm1, %xmm1, %xmm1
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
        testb   $1, %r8b
        jne     .LBB1_9
        jmp     .LBB1_10
CumSum_F64_V(double*, unsigned long):                    # @CumSum_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB2_8
        leaq    -1(%rsi), %rcx
        movl    %esi, %eax
        andl    $3, %eax
        cmpq    $3, %rcx
        jae     .LBB2_3
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
        jmp     .LBB2_5
.LBB2_3:
        andq    $-4, %rsi
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
        vaddsd  (%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rcx,8)
        vaddsd  8(%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, 8(%rdi,%rcx,8)
        vaddsd  16(%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, 16(%rdi,%rcx,8)
        vaddsd  24(%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, 24(%rdi,%rcx,8)
        addq    $4, %rcx
        cmpq    %rcx, %rsi
        jne     .LBB2_4
.LBB2_5:
        testq   %rax, %rax
        je      .LBB2_8
        leaq    (%rdi,%rcx,8), %rcx
        xorl    %edx, %edx
.LBB2_7:                                # =>This Inner Loop Header: Depth=1
        vaddsd  (%rcx,%rdx,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rcx,%rdx,8)
        addq    $1, %rdx
        cmpq    %rdx, %rax
        jne     .LBB2_7
.LBB2_8:
        retq
CumSum_F32_V(float*, unsigned long):                    # @CumSum_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB3_8
        leaq    -1(%rsi), %rcx
        movl    %esi, %eax
        andl    $3, %eax
        cmpq    $3, %rcx
        jae     .LBB3_3
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
        jmp     .LBB3_5
.LBB3_3:
        andq    $-4, %rsi
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
        vaddss  (%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rcx,4)
        vaddss  4(%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, 4(%rdi,%rcx,4)
        vaddss  8(%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, 8(%rdi,%rcx,4)
        vaddss  12(%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, 12(%rdi,%rcx,4)
        addq    $4, %rcx
        cmpq    %rcx, %rsi
        jne     .LBB3_4
.LBB3_5:
        testq   %rax, %rax
        je      .LBB3_8
        leaq    (%rdi,%rcx,4), %rcx
        xorl    %edx, %edx
.LBB3_7:                                # =>This Inner Loop Header: Depth=1
        vaddss  (%rcx,%rdx,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rcx,%rdx,4)
        addq    $1, %rdx
        cmpq    %rdx, %rax
        jne     .LBB3_7
.LBB3_8:
        retq
.LCPI4_0:
        .quad   0x3ff0000000000000              # double 1
Prod_F64_D(double*, unsigned long):                      # @Prod_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB4_1
        cmpq    $16, %rsi
        jae     .LBB4_4
        vmovsd  .LCPI4_0(%rip), %xmm0           # xmm0 = mem[0],zero
        xorl    %eax, %eax
        jmp     .LBB4_11
.LBB4_1:
        vmovsd  .LCPI4_0(%rip), %xmm0           # xmm0 = mem[0],zero
        retq
.LBB4_4:
        movq    %rsi, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB4_5
        movq    %r8, %rcx
        andq    $-2, %rcx
        vbroadcastsd    .LCPI4_0(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        xorl    %edx, %edx
        vmovapd %ymm0, %ymm1
        vmovapd %ymm0, %ymm2
        vmovapd %ymm0, %ymm3
.LBB4_7:                                # =>This Inner Loop Header: Depth=1
        vmulpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vmulpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vmulpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vmulpd  96(%rdi,%rdx,8), %ymm3, %ymm3
        vmulpd  128(%rdi,%rdx,8), %ymm0, %ymm0
        vmulpd  160(%rdi,%rdx,8), %ymm1, %ymm1
        vmulpd  192(%rdi,%rdx,8), %ymm2, %ymm2
        vmulpd  224(%rdi,%rdx,8), %ymm3, %ymm3
        addq    $32, %rdx
        addq    $-2, %rcx
        jne     .LBB4_7
        testb   $1, %r8b
        je      .LBB4_10
.LBB4_9:
        vmulpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vmulpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vmulpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vmulpd  96(%rdi,%rdx,8), %ymm3, %ymm3
.LBB4_10:
        vmulpd  %ymm3, %ymm1, %ymm1
        vmulpd  %ymm2, %ymm0, %ymm0
        vmulpd  %ymm1, %ymm0, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vmulpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vmulsd  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB4_12
.LBB4_11:                               # =>This Inner Loop Header: Depth=1
        vmulsd  (%rdi,%rax,8), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB4_11
.LBB4_12:
        vzeroupper
        retq
.LBB4_5:
        vbroadcastsd    .LCPI4_0(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        xorl    %edx, %edx
        vmovapd %ymm0, %ymm1
        vmovapd %ymm0, %ymm2
        vmovapd %ymm0, %ymm3
        testb   $1, %r8b
        jne     .LBB4_9
        jmp     .LBB4_10
.LCPI5_0:
        .long   0x3f800000                      # float 1
Prod_F32_F(float*, unsigned long):                      # @Prod_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB5_1
        cmpq    $32, %rsi
        jae     .LBB5_4
        vmovss  .LCPI5_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        xorl    %eax, %eax
        jmp     .LBB5_11
.LBB5_1:
        vmovss  .LCPI5_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        retq
.LBB5_4:
        movq    %rsi, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB5_5
        movq    %r8, %rcx
        andq    $-2, %rcx
        vbroadcastss    .LCPI5_0(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        xorl    %edx, %edx
        vmovaps %ymm0, %ymm1
        vmovaps %ymm0, %ymm2
        vmovaps %ymm0, %ymm3
.LBB5_7:                                # =>This Inner Loop Header: Depth=1
        vmulps  (%rdi,%rdx,4), %ymm0, %ymm0
        vmulps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vmulps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vmulps  96(%rdi,%rdx,4), %ymm3, %ymm3
        vmulps  128(%rdi,%rdx,4), %ymm0, %ymm0
        vmulps  160(%rdi,%rdx,4), %ymm1, %ymm1
        vmulps  192(%rdi,%rdx,4), %ymm2, %ymm2
        vmulps  224(%rdi,%rdx,4), %ymm3, %ymm3
        addq    $64, %rdx
        addq    $-2, %rcx
        jne     .LBB5_7
        testb   $1, %r8b
        je      .LBB5_10
.LBB5_9:
        vmulps  (%rdi,%rdx,4), %ymm0, %ymm0
        vmulps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vmulps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vmulps  96(%rdi,%rdx,4), %ymm3, %ymm3
.LBB5_10:
        vmulps  %ymm3, %ymm1, %ymm1
        vmulps  %ymm2, %ymm0, %ymm0
        vmulps  %ymm1, %ymm0, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vmulps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vmulps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vmulss  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB5_12
.LBB5_11:                               # =>This Inner Loop Header: Depth=1
        vmulss  (%rdi,%rax,4), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB5_11
.LBB5_12:
        vzeroupper
        retq
.LBB5_5:
        vbroadcastss    .LCPI5_0(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        xorl    %edx, %edx
        vmovaps %ymm0, %ymm1
        vmovaps %ymm0, %ymm2
        vmovaps %ymm0, %ymm3
        testb   $1, %r8b
        jne     .LBB5_9
        jmp     .LBB5_10
.LCPI6_0:
        .quad   0x3ff0000000000000              # double 1
CumProd_F64_V(double*, unsigned long):                   # @CumProd_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB6_8
        leaq    -1(%rsi), %rcx
        movl    %esi, %eax
        andl    $3, %eax
        cmpq    $3, %rcx
        jae     .LBB6_3
        vmovsd  .LCPI6_0(%rip), %xmm0           # xmm0 = mem[0],zero
        xorl    %ecx, %ecx
        jmp     .LBB6_5
.LBB6_3:
        andq    $-4, %rsi
        vmovsd  .LCPI6_0(%rip), %xmm0           # xmm0 = mem[0],zero
        xorl    %ecx, %ecx
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
        vmulsd  (%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rcx,8)
        vmulsd  8(%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, 8(%rdi,%rcx,8)
        vmulsd  16(%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, 16(%rdi,%rcx,8)
        vmulsd  24(%rdi,%rcx,8), %xmm0, %xmm0
        vmovsd  %xmm0, 24(%rdi,%rcx,8)
        addq    $4, %rcx
        cmpq    %rcx, %rsi
        jne     .LBB6_4
.LBB6_5:
        testq   %rax, %rax
        je      .LBB6_8
        leaq    (%rdi,%rcx,8), %rcx
        xorl    %edx, %edx
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
        vmulsd  (%rcx,%rdx,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rcx,%rdx,8)
        addq    $1, %rdx
        cmpq    %rdx, %rax
        jne     .LBB6_7
.LBB6_8:
        retq
.LCPI7_0:
        .long   0x3f800000                      # float 1
CumProd_F32_V(float*, unsigned long):                   # @CumProd_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB7_8
        leaq    -1(%rsi), %rcx
        movl    %esi, %eax
        andl    $3, %eax
        cmpq    $3, %rcx
        jae     .LBB7_3
        vmovss  .LCPI7_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        xorl    %ecx, %ecx
        jmp     .LBB7_5
.LBB7_3:
        andq    $-4, %rsi
        vmovss  .LCPI7_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        xorl    %ecx, %ecx
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
        vmulss  (%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rcx,4)
        vmulss  4(%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, 4(%rdi,%rcx,4)
        vmulss  8(%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, 8(%rdi,%rcx,4)
        vmulss  12(%rdi,%rcx,4), %xmm0, %xmm0
        vmovss  %xmm0, 12(%rdi,%rcx,4)
        addq    $4, %rcx
        cmpq    %rcx, %rsi
        jne     .LBB7_4
.LBB7_5:
        testq   %rax, %rax
        je      .LBB7_8
        leaq    (%rdi,%rcx,4), %rcx
        xorl    %edx, %edx
.LBB7_7:                                # =>This Inner Loop Header: Depth=1
        vmulss  (%rcx,%rdx,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rcx,%rdx,4)
        addq    $1, %rdx
        cmpq    %rdx, %rax
        jne     .LBB7_7
.LBB7_8:
        retq