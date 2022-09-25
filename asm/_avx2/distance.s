Dot_F64_D(double*, double*, unsigned long):                      # @Dot_F64_D(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB0_1
        cmpq    $16, %rdx
        jae     .LBB0_4
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB0_7
.LBB0_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB0_4:
        movq    %rdx, %rax
        andq    $-16, %rax
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
        vxorpd  %xmm1, %xmm1, %xmm1
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rsi,%rcx,8), %ymm4
        vmovupd 32(%rsi,%rcx,8), %ymm5
        vmovupd 64(%rsi,%rcx,8), %ymm6
        vmovupd 96(%rsi,%rcx,8), %ymm7
        vfmadd231pd     (%rdi,%rcx,8), %ymm4, %ymm0 # ymm0 = (ymm4 * mem) + ymm0
        vfmadd231pd     32(%rdi,%rcx,8), %ymm5, %ymm1 # ymm1 = (ymm5 * mem) + ymm1
        vfmadd231pd     64(%rdi,%rcx,8), %ymm6, %ymm2 # ymm2 = (ymm6 * mem) + ymm2
        vfmadd231pd     96(%rdi,%rcx,8), %ymm7, %ymm3 # ymm3 = (ymm7 * mem) + ymm3
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB0_5
        vaddpd  %ymm0, %ymm1, %ymm0
        vaddpd  %ymm0, %ymm2, %ymm0
        vaddpd  %ymm0, %ymm3, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        cmpq    %rdx, %rax
        je      .LBB0_8
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        vfmadd231sd     (%rdi,%rax,8), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB0_7
.LBB0_8:
        vzeroupper
        retq
Dot_F32_F(float*, float*, unsigned long):                      # @Dot_F32_F(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB1_1
        cmpq    $32, %rdx
        jae     .LBB1_4
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB1_7
.LBB1_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB1_4:
        movq    %rdx, %rax
        andq    $-32, %rax
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
        vxorps  %xmm1, %xmm1, %xmm1
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx,4), %ymm4
        vmovups 32(%rsi,%rcx,4), %ymm5
        vmovups 64(%rsi,%rcx,4), %ymm6
        vmovups 96(%rsi,%rcx,4), %ymm7
        vfmadd231ps     (%rdi,%rcx,4), %ymm4, %ymm0 # ymm0 = (ymm4 * mem) + ymm0
        vfmadd231ps     32(%rdi,%rcx,4), %ymm5, %ymm1 # ymm1 = (ymm5 * mem) + ymm1
        vfmadd231ps     64(%rdi,%rcx,4), %ymm6, %ymm2 # ymm2 = (ymm6 * mem) + ymm2
        vfmadd231ps     96(%rdi,%rcx,4), %ymm7, %ymm3 # ymm3 = (ymm7 * mem) + ymm3
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB1_5
        vaddps  %ymm0, %ymm1, %ymm0
        vaddps  %ymm0, %ymm2, %ymm0
        vaddps  %ymm0, %ymm3, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vaddss  %xmm1, %xmm0, %xmm0
        cmpq    %rdx, %rax
        je      .LBB1_8
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vfmadd231ss     (%rdi,%rax,4), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB1_7
.LBB1_8:
        vzeroupper
        retq
CosineSimilarity_F64_D(double*, double*, unsigned long):        # @CosineSimilarity_F64_D(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB2_1
        cmpq    $8, %rdx
        jae     .LBB2_5
        vxorpd  %xmm1, %xmm1, %xmm1
        xorl    %eax, %eax
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm0, %xmm0, %xmm0
        jmp     .LBB2_4
.LBB2_1:
        vxorpd  %xmm0, %xmm0, %xmm0
        vxorpd  %xmm1, %xmm1, %xmm1
        vsqrtsd %xmm1, %xmm1, %xmm1
        vdivsd  %xmm1, %xmm0, %xmm0
        retq
.LBB2_5:
        movq    %rdx, %rax
        andq    $-8, %rax
        vxorpd  %xmm1, %xmm1, %xmm1
        xorl    %ecx, %ecx
        vxorpd  %xmm3, %xmm3, %xmm3
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm4, %xmm4, %xmm4
        vxorpd  %xmm0, %xmm0, %xmm0
        vxorpd  %xmm5, %xmm5, %xmm5
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm6
        vmovupd 32(%rdi,%rcx,8), %ymm7
        vmovupd (%rsi,%rcx,8), %ymm8
        vmovupd 32(%rsi,%rcx,8), %ymm9
        vfmadd231pd     %ymm6, %ymm8, %ymm0     # ymm0 = (ymm8 * ymm6) + ymm0
        vfmadd231pd     %ymm7, %ymm9, %ymm5     # ymm5 = (ymm9 * ymm7) + ymm5
        vfmadd231pd     %ymm6, %ymm6, %ymm2     # ymm2 = (ymm6 * ymm6) + ymm2
        vfmadd231pd     %ymm7, %ymm7, %ymm4     # ymm4 = (ymm7 * ymm7) + ymm4
        vfmadd231pd     %ymm8, %ymm8, %ymm1     # ymm1 = (ymm8 * ymm8) + ymm1
        vfmadd231pd     %ymm9, %ymm9, %ymm3     # ymm3 = (ymm9 * ymm9) + ymm3
        addq    $8, %rcx
        cmpq    %rcx, %rax
        jne     .LBB2_6
        vaddpd  %ymm0, %ymm5, %ymm0
        vextractf128    $1, %ymm0, %xmm5
        vaddpd  %xmm5, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm5        # xmm5 = xmm0[1,0]
        vaddsd  %xmm5, %xmm0, %xmm0
        vaddpd  %ymm2, %ymm4, %ymm2
        vextractf128    $1, %ymm2, %xmm4
        vaddpd  %xmm4, %xmm2, %xmm2
        vpermilpd       $1, %xmm2, %xmm4        # xmm4 = xmm2[1,0]
        vaddsd  %xmm4, %xmm2, %xmm2
        vaddpd  %ymm1, %ymm3, %ymm1
        vextractf128    $1, %ymm1, %xmm3
        vaddpd  %xmm3, %xmm1, %xmm1
        vpermilpd       $1, %xmm1, %xmm3        # xmm3 = xmm1[1,0]
        vaddsd  %xmm3, %xmm1, %xmm1
        cmpq    %rdx, %rax
        je      .LBB2_8
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm3            # xmm3 = mem[0],zero
        vmovsd  (%rsi,%rax,8), %xmm4            # xmm4 = mem[0],zero
        vfmadd231sd     %xmm3, %xmm4, %xmm0     # xmm0 = (xmm4 * xmm3) + xmm0
        vfmadd231sd     %xmm3, %xmm3, %xmm2     # xmm2 = (xmm3 * xmm3) + xmm2
        vfmadd231sd     %xmm4, %xmm4, %xmm1     # xmm1 = (xmm4 * xmm4) + xmm1
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB2_4
.LBB2_8:
        vmulsd  %xmm2, %xmm1, %xmm1
        vsqrtsd %xmm1, %xmm1, %xmm1
        vdivsd  %xmm1, %xmm0, %xmm0
        vzeroupper
        retq
.LCPI3_0:
        .long   0xc0400000                      # float -3
.LCPI3_1:
        .long   0xbf000000                      # float -0.5
CosineSimilarity_F32_F(float*, float*, unsigned long):        # @CosineSimilarity_F32_F(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB3_1
        cmpq    $16, %rdx
        jae     .LBB3_5
        vxorps  %xmm1, %xmm1, %xmm1
        xorl    %eax, %eax
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm0, %xmm0, %xmm0
        jmp     .LBB3_4
.LBB3_1:
        vxorps  %xmm0, %xmm0, %xmm0
        vxorps  %xmm1, %xmm1, %xmm1
        jmp     .LBB3_9
.LBB3_5:
        movq    %rdx, %rax
        andq    $-16, %rax
        vxorps  %xmm1, %xmm1, %xmm1
        xorl    %ecx, %ecx
        vxorps  %xmm3, %xmm3, %xmm3
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm4, %xmm4, %xmm4
        vxorps  %xmm0, %xmm0, %xmm0
        vxorps  %xmm5, %xmm5, %xmm5
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm6
        vmovups 32(%rdi,%rcx,4), %ymm7
        vmovups (%rsi,%rcx,4), %ymm8
        vmovups 32(%rsi,%rcx,4), %ymm9
        vfmadd231ps     %ymm6, %ymm8, %ymm0     # ymm0 = (ymm8 * ymm6) + ymm0
        vfmadd231ps     %ymm7, %ymm9, %ymm5     # ymm5 = (ymm9 * ymm7) + ymm5
        vfmadd231ps     %ymm6, %ymm6, %ymm2     # ymm2 = (ymm6 * ymm6) + ymm2
        vfmadd231ps     %ymm7, %ymm7, %ymm4     # ymm4 = (ymm7 * ymm7) + ymm4
        vfmadd231ps     %ymm8, %ymm8, %ymm1     # ymm1 = (ymm8 * ymm8) + ymm1
        vfmadd231ps     %ymm9, %ymm9, %ymm3     # ymm3 = (ymm9 * ymm9) + ymm3
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB3_6
        vaddps  %ymm0, %ymm5, %ymm0
        vextractf128    $1, %ymm0, %xmm5
        vaddps  %xmm5, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm5        # xmm5 = xmm0[1,0]
        vaddps  %xmm5, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm5            # xmm5 = xmm0[1,1,3,3]
        vaddss  %xmm5, %xmm0, %xmm0
        vaddps  %ymm2, %ymm4, %ymm2
        vextractf128    $1, %ymm2, %xmm4
        vaddps  %xmm4, %xmm2, %xmm2
        vpermilpd       $1, %xmm2, %xmm4        # xmm4 = xmm2[1,0]
        vaddps  %xmm4, %xmm2, %xmm2
        vmovshdup       %xmm2, %xmm4            # xmm4 = xmm2[1,1,3,3]
        vaddss  %xmm4, %xmm2, %xmm2
        vaddps  %ymm1, %ymm3, %ymm1
        vextractf128    $1, %ymm1, %xmm3
        vaddps  %xmm3, %xmm1, %xmm1
        vpermilpd       $1, %xmm1, %xmm3        # xmm3 = xmm1[1,0]
        vaddps  %xmm3, %xmm1, %xmm1
        vmovshdup       %xmm1, %xmm3            # xmm3 = xmm1[1,1,3,3]
        vaddss  %xmm3, %xmm1, %xmm1
        cmpq    %rdx, %rax
        je      .LBB3_8
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
        vmovss  (%rsi,%rax,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
        vfmadd231ss     %xmm3, %xmm4, %xmm0     # xmm0 = (xmm4 * xmm3) + xmm0
        vfmadd231ss     %xmm3, %xmm3, %xmm2     # xmm2 = (xmm3 * xmm3) + xmm2
        vfmadd231ss     %xmm4, %xmm4, %xmm1     # xmm1 = (xmm4 * xmm4) + xmm1
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB3_4
.LBB3_8:
        vmulss  %xmm2, %xmm1, %xmm1
.LBB3_9:
        vrsqrtss        %xmm1, %xmm1, %xmm2
        vmulss  %xmm2, %xmm1, %xmm1
        vfmadd213ss     .LCPI3_0(%rip), %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + mem
        vmulss  .LCPI3_1(%rip), %xmm2, %xmm2
        vmulss  %xmm0, %xmm2, %xmm0
        vmulss  %xmm0, %xmm1, %xmm0
        vzeroupper
        retq
Norm_F64_D(double*, unsigned long):             # @Norm_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB4_1
        cmpq    $16, %rsi
        jae     .LBB4_4
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB4_11
.LBB4_1:
        vxorpd  %xmm0, %xmm0, %xmm0
        vsqrtsd %xmm0, %xmm0, %xmm0
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
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorpd  %xmm1, %xmm1, %xmm1
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
.LBB4_7:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rdx,8), %ymm4
        vmovupd 32(%rdi,%rdx,8), %ymm5
        vmovupd 64(%rdi,%rdx,8), %ymm6
        vmovupd 96(%rdi,%rdx,8), %ymm7
        vfmadd213pd     %ymm0, %ymm4, %ymm4     # ymm4 = (ymm4 * ymm4) + ymm0
        vfmadd213pd     %ymm1, %ymm5, %ymm5     # ymm5 = (ymm5 * ymm5) + ymm1
        vfmadd213pd     %ymm2, %ymm6, %ymm6     # ymm6 = (ymm6 * ymm6) + ymm2
        vfmadd213pd     %ymm3, %ymm7, %ymm7     # ymm7 = (ymm7 * ymm7) + ymm3
        vmovupd 128(%rdi,%rdx,8), %ymm0
        vmovupd 160(%rdi,%rdx,8), %ymm1
        vmovupd 192(%rdi,%rdx,8), %ymm2
        vmovupd 224(%rdi,%rdx,8), %ymm3
        vfmadd213pd     %ymm4, %ymm0, %ymm0     # ymm0 = (ymm0 * ymm0) + ymm4
        vfmadd213pd     %ymm5, %ymm1, %ymm1     # ymm1 = (ymm1 * ymm1) + ymm5
        vfmadd213pd     %ymm6, %ymm2, %ymm2     # ymm2 = (ymm2 * ymm2) + ymm6
        vfmadd213pd     %ymm7, %ymm3, %ymm3     # ymm3 = (ymm3 * ymm3) + ymm7
        addq    $32, %rdx
        addq    $-2, %rcx
        jne     .LBB4_7
        testb   $1, %r8b
        je      .LBB4_10
.LBB4_9:
        vmovupd (%rdi,%rdx,8), %ymm4
        vmovupd 32(%rdi,%rdx,8), %ymm5
        vmovupd 64(%rdi,%rdx,8), %ymm6
        vmovupd 96(%rdi,%rdx,8), %ymm7
        vfmadd231pd     %ymm4, %ymm4, %ymm0     # ymm0 = (ymm4 * ymm4) + ymm0
        vfmadd231pd     %ymm5, %ymm5, %ymm1     # ymm1 = (ymm5 * ymm5) + ymm1
        vfmadd231pd     %ymm6, %ymm6, %ymm2     # ymm2 = (ymm6 * ymm6) + ymm2
        vfmadd231pd     %ymm7, %ymm7, %ymm3     # ymm3 = (ymm7 * ymm7) + ymm3
.LBB4_10:
        vaddpd  %ymm3, %ymm1, %ymm1
        vaddpd  %ymm2, %ymm0, %ymm0
        vaddpd  %ymm1, %ymm0, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB4_12
.LBB4_11:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        vfmadd231sd     %xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB4_11
.LBB4_12:
        vsqrtsd %xmm0, %xmm0, %xmm0
        vzeroupper
        retq
.LBB4_5:
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorpd  %xmm1, %xmm1, %xmm1
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
        testb   $1, %r8b
        jne     .LBB4_9
        jmp     .LBB4_10
.LCPI5_0:
        .long   0xc0400000                      # float -3
.LCPI5_1:
        .long   0xbf000000                      # float -0.5
.LCPI5_2:
        .long   0x7fffffff                      # float NaN
.LCPI5_3:
        .long   0x00800000                      # float 1.17549435E-38
Norm_F32_F(float*, unsigned long):             # @Norm_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB5_1
        cmpq    $32, %rsi
        jae     .LBB5_4
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB5_11
.LBB5_1:
        vxorps  %xmm0, %xmm0, %xmm0
        jmp     .LBB5_12
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
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorps  %xmm1, %xmm1, %xmm1
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
.LBB5_7:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rdx,4), %ymm4
        vmovups 32(%rdi,%rdx,4), %ymm5
        vmovups 64(%rdi,%rdx,4), %ymm6
        vmovups 96(%rdi,%rdx,4), %ymm7
        vfmadd213ps     %ymm0, %ymm4, %ymm4     # ymm4 = (ymm4 * ymm4) + ymm0
        vfmadd213ps     %ymm1, %ymm5, %ymm5     # ymm5 = (ymm5 * ymm5) + ymm1
        vfmadd213ps     %ymm2, %ymm6, %ymm6     # ymm6 = (ymm6 * ymm6) + ymm2
        vfmadd213ps     %ymm3, %ymm7, %ymm7     # ymm7 = (ymm7 * ymm7) + ymm3
        vmovups 128(%rdi,%rdx,4), %ymm0
        vmovups 160(%rdi,%rdx,4), %ymm1
        vmovups 192(%rdi,%rdx,4), %ymm2
        vmovups 224(%rdi,%rdx,4), %ymm3
        vfmadd213ps     %ymm4, %ymm0, %ymm0     # ymm0 = (ymm0 * ymm0) + ymm4
        vfmadd213ps     %ymm5, %ymm1, %ymm1     # ymm1 = (ymm1 * ymm1) + ymm5
        vfmadd213ps     %ymm6, %ymm2, %ymm2     # ymm2 = (ymm2 * ymm2) + ymm6
        vfmadd213ps     %ymm7, %ymm3, %ymm3     # ymm3 = (ymm3 * ymm3) + ymm7
        addq    $64, %rdx
        addq    $-2, %rcx
        jne     .LBB5_7
        testb   $1, %r8b
        je      .LBB5_10
.LBB5_9:
        vmovups (%rdi,%rdx,4), %ymm4
        vmovups 32(%rdi,%rdx,4), %ymm5
        vmovups 64(%rdi,%rdx,4), %ymm6
        vmovups 96(%rdi,%rdx,4), %ymm7
        vfmadd231ps     %ymm4, %ymm4, %ymm0     # ymm0 = (ymm4 * ymm4) + ymm0
        vfmadd231ps     %ymm5, %ymm5, %ymm1     # ymm1 = (ymm5 * ymm5) + ymm1
        vfmadd231ps     %ymm6, %ymm6, %ymm2     # ymm2 = (ymm6 * ymm6) + ymm2
        vfmadd231ps     %ymm7, %ymm7, %ymm3     # ymm3 = (ymm7 * ymm7) + ymm3
.LBB5_10:
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
        je      .LBB5_12
.LBB5_11:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vfmadd231ss     %xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB5_11
.LBB5_12:
        vrsqrtss        %xmm0, %xmm0, %xmm1
        vmulss  %xmm1, %xmm0, %xmm2
        vfmadd213ss     .LCPI5_0(%rip), %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + mem
        vmulss  .LCPI5_1(%rip), %xmm2, %xmm2
        vmulss  %xmm1, %xmm2, %xmm1
        vbroadcastss    .LCPI5_2(%rip), %xmm2   # xmm2 = [NaN,NaN,NaN,NaN]
        vandps  %xmm2, %xmm0, %xmm0
        vcmpltss        .LCPI5_3(%rip), %xmm0, %xmm0
        vandnps %xmm1, %xmm0, %xmm0
        vzeroupper
        retq
.LBB5_5:
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %edx, %edx
        vxorps  %xmm1, %xmm1, %xmm1
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
        testb   $1, %r8b
        jne     .LBB5_9
        jmp     .LBB5_10
Distance_F64_D(double*, double*, unsigned long):       # @Distance_F64_D(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB6_1
        cmpq    $16, %rdx
        jae     .LBB6_4
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB6_7
.LBB6_1:
        vxorpd  %xmm0, %xmm0, %xmm0
        vsqrtsd %xmm0, %xmm0, %xmm0
        retq
.LBB6_4:
        movq    %rdx, %rax
        andq    $-16, %rax
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
        vxorpd  %xmm1, %xmm1, %xmm1
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
.LBB6_5:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm4
        vmovupd 32(%rdi,%rcx,8), %ymm5
        vmovupd 64(%rdi,%rcx,8), %ymm6
        vmovupd 96(%rdi,%rcx,8), %ymm7
        vsubpd  (%rsi,%rcx,8), %ymm4, %ymm4
        vsubpd  32(%rsi,%rcx,8), %ymm5, %ymm5
        vsubpd  64(%rsi,%rcx,8), %ymm6, %ymm6
        vsubpd  96(%rsi,%rcx,8), %ymm7, %ymm7
        vfmadd231pd     %ymm4, %ymm4, %ymm0     # ymm0 = (ymm4 * ymm4) + ymm0
        vfmadd231pd     %ymm5, %ymm5, %ymm1     # ymm1 = (ymm5 * ymm5) + ymm1
        vfmadd231pd     %ymm6, %ymm6, %ymm2     # ymm2 = (ymm6 * ymm6) + ymm2
        vfmadd231pd     %ymm7, %ymm7, %ymm3     # ymm3 = (ymm7 * ymm7) + ymm3
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB6_5
        vaddpd  %ymm0, %ymm1, %ymm0
        vaddpd  %ymm0, %ymm2, %ymm0
        vaddpd  %ymm0, %ymm3, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        cmpq    %rdx, %rax
        je      .LBB6_8
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        vsubsd  (%rsi,%rax,8), %xmm1, %xmm1
        vfmadd231sd     %xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB6_7
.LBB6_8:
        vsqrtsd %xmm0, %xmm0, %xmm0
        vzeroupper
        retq
.LCPI7_0:
        .long   0xc0400000                      # float -3
.LCPI7_1:
        .long   0xbf000000                      # float -0.5
.LCPI7_2:
        .long   0x7fffffff                      # float NaN
.LCPI7_3:
        .long   0x00800000                      # float 1.17549435E-38
Distance_F32_F(float*, float*, unsigned long):        # @Distance_F32_F(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB7_1
        cmpq    $32, %rdx
        jae     .LBB7_4
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB7_7
.LBB7_1:
        vxorps  %xmm0, %xmm0, %xmm0
        jmp     .LBB7_8
.LBB7_4:
        movq    %rdx, %rax
        andq    $-32, %rax
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %ecx, %ecx
        vxorps  %xmm1, %xmm1, %xmm1
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
.LBB7_5:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm4
        vmovups 32(%rdi,%rcx,4), %ymm5
        vmovups 64(%rdi,%rcx,4), %ymm6
        vmovups 96(%rdi,%rcx,4), %ymm7
        vsubps  (%rsi,%rcx,4), %ymm4, %ymm4
        vsubps  32(%rsi,%rcx,4), %ymm5, %ymm5
        vsubps  64(%rsi,%rcx,4), %ymm6, %ymm6
        vsubps  96(%rsi,%rcx,4), %ymm7, %ymm7
        vfmadd231ps     %ymm4, %ymm4, %ymm0     # ymm0 = (ymm4 * ymm4) + ymm0
        vfmadd231ps     %ymm5, %ymm5, %ymm1     # ymm1 = (ymm5 * ymm5) + ymm1
        vfmadd231ps     %ymm6, %ymm6, %ymm2     # ymm2 = (ymm6 * ymm6) + ymm2
        vfmadd231ps     %ymm7, %ymm7, %ymm3     # ymm3 = (ymm7 * ymm7) + ymm3
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB7_5
        vaddps  %ymm0, %ymm1, %ymm0
        vaddps  %ymm0, %ymm2, %ymm0
        vaddps  %ymm0, %ymm3, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vaddss  %xmm1, %xmm0, %xmm0
        cmpq    %rdx, %rax
        je      .LBB7_8
.LBB7_7:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vsubss  (%rsi,%rax,4), %xmm1, %xmm1
        vfmadd231ss     %xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB7_7
.LBB7_8:
        vrsqrtss        %xmm0, %xmm0, %xmm1
        vmulss  %xmm1, %xmm0, %xmm2
        vfmadd213ss     .LCPI7_0(%rip), %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + mem
        vmulss  .LCPI7_1(%rip), %xmm2, %xmm2
        vmulss  %xmm1, %xmm2, %xmm1
        vbroadcastss    .LCPI7_2(%rip), %xmm2   # xmm2 = [NaN,NaN,NaN,NaN]
        vandps  %xmm2, %xmm0, %xmm0
        vcmpltss        .LCPI7_3(%rip), %xmm0, %xmm0
        vandnps %xmm1, %xmm0, %xmm0
        vzeroupper
        retq
.LCPI8_0:
        .quad   0x7fffffffffffffff              # double NaN
.LCPI8_1:
        .quad   0x7fffffffffffffff              # double NaN
        .quad   0x7fffffffffffffff              # double NaN
ManhattanNorm_F64_D(double*, unsigned long):             # @ManhattanNorm_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB8_1
        cmpq    $16, %rsi
        jae     .LBB8_4
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB8_7
.LBB8_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB8_4:
        movq    %rsi, %rax
        andq    $-16, %rax
        vxorpd  %xmm0, %xmm0, %xmm0
        vbroadcastsd    .LCPI8_0(%rip), %ymm1   # ymm1 = [NaN,NaN,NaN,NaN]
        xorl    %ecx, %ecx
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
        vxorpd  %xmm4, %xmm4, %xmm4
.LBB8_5:                                # =>This Inner Loop Header: Depth=1
        vandpd  (%rdi,%rcx,8), %ymm1, %ymm5
        vaddpd  %ymm0, %ymm5, %ymm0
        vandpd  32(%rdi,%rcx,8), %ymm1, %ymm5
        vaddpd  %ymm2, %ymm5, %ymm2
        vandpd  64(%rdi,%rcx,8), %ymm1, %ymm5
        vandpd  96(%rdi,%rcx,8), %ymm1, %ymm6
        vaddpd  %ymm3, %ymm5, %ymm3
        vaddpd  %ymm4, %ymm6, %ymm4
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB8_5
        vaddpd  %ymm0, %ymm2, %ymm0
        vaddpd  %ymm0, %ymm3, %ymm0
        vaddpd  %ymm0, %ymm4, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB8_9
.LBB8_7:
        vmovapd .LCPI8_1(%rip), %xmm1           # xmm1 = [NaN,NaN]
.LBB8_8:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm2            # xmm2 = mem[0],zero
        vandpd  %xmm1, %xmm2, %xmm2
        vaddsd  %xmm0, %xmm2, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB8_8
.LBB8_9:
        vzeroupper
        retq
.LCPI9_0:
        .long   0x7fffffff                      # float NaN
ManhattanNorm_F32_F(float*, unsigned long):             # @ManhattanNorm_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB9_1
        cmpq    $32, %rsi
        jae     .LBB9_4
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB9_7
.LBB9_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB9_4:
        movq    %rsi, %rax
        andq    $-32, %rax
        vxorps  %xmm0, %xmm0, %xmm0
        vbroadcastss    .LCPI9_0(%rip), %ymm1   # ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
        xorl    %ecx, %ecx
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
        vxorps  %xmm4, %xmm4, %xmm4
.LBB9_5:                                # =>This Inner Loop Header: Depth=1
        vandps  (%rdi,%rcx,4), %ymm1, %ymm5
        vaddps  %ymm0, %ymm5, %ymm0
        vandps  32(%rdi,%rcx,4), %ymm1, %ymm5
        vaddps  %ymm2, %ymm5, %ymm2
        vandps  64(%rdi,%rcx,4), %ymm1, %ymm5
        vandps  96(%rdi,%rcx,4), %ymm1, %ymm6
        vaddps  %ymm3, %ymm5, %ymm3
        vaddps  %ymm4, %ymm6, %ymm4
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB9_5
        vaddps  %ymm0, %ymm2, %ymm0
        vaddps  %ymm0, %ymm3, %ymm0
        vaddps  %ymm0, %ymm4, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vaddss  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB9_9
.LBB9_7:
        vbroadcastss    .LCPI9_0(%rip), %xmm1   # xmm1 = [NaN,NaN,NaN,NaN]
.LBB9_8:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
        vandps  %xmm1, %xmm2, %xmm2
        vaddss  %xmm0, %xmm2, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB9_8
.LBB9_9:
        vzeroupper
        retq
.LCPI10_0:
        .quad   0x7fffffffffffffff              # double NaN
.LCPI10_1:
        .quad   0x7fffffffffffffff              # double NaN
        .quad   0x7fffffffffffffff              # double NaN
ManhattanDistance_F64_D(double*, double*, unsigned long):       # @ManhattanDistance_F64_D(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB10_1
        cmpq    $16, %rdx
        jae     .LBB10_4
        vxorpd  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB10_7
.LBB10_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB10_4:
        movq    %rdx, %rax
        andq    $-16, %rax
        vxorpd  %xmm0, %xmm0, %xmm0
        vbroadcastsd    .LCPI10_0(%rip), %ymm1  # ymm1 = [NaN,NaN,NaN,NaN]
        xorl    %ecx, %ecx
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
        vxorpd  %xmm4, %xmm4, %xmm4
.LBB10_5:                               # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm5
        vmovupd 32(%rdi,%rcx,8), %ymm6
        vmovupd 64(%rdi,%rcx,8), %ymm7
        vmovupd 96(%rdi,%rcx,8), %ymm8
        vsubpd  (%rsi,%rcx,8), %ymm5, %ymm5
        vsubpd  32(%rsi,%rcx,8), %ymm6, %ymm6
        vsubpd  64(%rsi,%rcx,8), %ymm7, %ymm7
        vsubpd  96(%rsi,%rcx,8), %ymm8, %ymm8
        vandpd  %ymm1, %ymm5, %ymm5
        vaddpd  %ymm0, %ymm5, %ymm0
        vandpd  %ymm1, %ymm6, %ymm5
        vaddpd  %ymm2, %ymm5, %ymm2
        vandpd  %ymm1, %ymm7, %ymm5
        vaddpd  %ymm3, %ymm5, %ymm3
        vandpd  %ymm1, %ymm8, %ymm5
        vaddpd  %ymm4, %ymm5, %ymm4
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB10_5
        vaddpd  %ymm0, %ymm2, %ymm0
        vaddpd  %ymm0, %ymm3, %ymm0
        vaddpd  %ymm0, %ymm4, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        cmpq    %rdx, %rax
        je      .LBB10_9
.LBB10_7:
        vmovapd .LCPI10_1(%rip), %xmm1          # xmm1 = [NaN,NaN]
.LBB10_8:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm2            # xmm2 = mem[0],zero
        vsubsd  (%rsi,%rax,8), %xmm2, %xmm2
        vandpd  %xmm1, %xmm2, %xmm2
        vaddsd  %xmm0, %xmm2, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB10_8
.LBB10_9:
        vzeroupper
        retq
.LCPI11_0:
        .long   0x7fffffff                      # float NaN
ManhattanDistance_F32_F(float*, float*, unsigned long):       # @ManhattanDistance_F32_F(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB11_1
        cmpq    $32, %rdx
        jae     .LBB11_4
        vxorps  %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        jmp     .LBB11_7
.LBB11_1:
        vxorps  %xmm0, %xmm0, %xmm0
        retq
.LBB11_4:
        movq    %rdx, %rax
        andq    $-32, %rax
        vxorps  %xmm0, %xmm0, %xmm0
        vbroadcastss    .LCPI11_0(%rip), %ymm1  # ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
        xorl    %ecx, %ecx
        vxorps  %xmm2, %xmm2, %xmm2
        vxorps  %xmm3, %xmm3, %xmm3
        vxorps  %xmm4, %xmm4, %xmm4
.LBB11_5:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm5
        vmovups 32(%rdi,%rcx,4), %ymm6
        vmovups 64(%rdi,%rcx,4), %ymm7
        vmovups 96(%rdi,%rcx,4), %ymm8
        vsubps  (%rsi,%rcx,4), %ymm5, %ymm5
        vsubps  32(%rsi,%rcx,4), %ymm6, %ymm6
        vsubps  64(%rsi,%rcx,4), %ymm7, %ymm7
        vsubps  96(%rsi,%rcx,4), %ymm8, %ymm8
        vandps  %ymm1, %ymm5, %ymm5
        vaddps  %ymm0, %ymm5, %ymm0
        vandps  %ymm1, %ymm6, %ymm5
        vaddps  %ymm2, %ymm5, %ymm2
        vandps  %ymm1, %ymm7, %ymm5
        vaddps  %ymm3, %ymm5, %ymm3
        vandps  %ymm1, %ymm8, %ymm5
        vaddps  %ymm4, %ymm5, %ymm4
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB11_5
        vaddps  %ymm0, %ymm2, %ymm0
        vaddps  %ymm0, %ymm3, %ymm0
        vaddps  %ymm0, %ymm4, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vaddss  %xmm1, %xmm0, %xmm0
        cmpq    %rdx, %rax
        je      .LBB11_9
.LBB11_7:
        vbroadcastss    .LCPI11_0(%rip), %xmm1  # xmm1 = [NaN,NaN,NaN,NaN]
.LBB11_8:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
        vsubss  (%rsi,%rax,4), %xmm2, %xmm2
        vandps  %xmm1, %xmm2, %xmm2
        vaddss  %xmm0, %xmm2, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB11_8
.LBB11_9:
        vzeroupper
        retq