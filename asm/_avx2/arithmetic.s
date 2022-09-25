Add_F64_V(double*, double*, unsigned long):                      # @Add_F64_V(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB0_7
        cmpq    $16, %rdx
        jae     .LBB0_3
        xorl    %eax, %eax
        jmp     .LBB0_6
.LBB0_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm0
        vmovupd 32(%rdi,%rcx,8), %ymm1
        vmovupd 64(%rdi,%rcx,8), %ymm2
        vmovupd 96(%rdi,%rcx,8), %ymm3
        vaddpd  (%rsi,%rcx,8), %ymm0, %ymm0
        vaddpd  32(%rsi,%rcx,8), %ymm1, %ymm1
        vaddpd  64(%rsi,%rcx,8), %ymm2, %ymm2
        vaddpd  96(%rsi,%rcx,8), %ymm3, %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB0_4
        cmpq    %rdx, %rax
        je      .LBB0_7
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vaddsd  (%rsi,%rax,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB0_6
.LBB0_7:
        vzeroupper
        retq
Add_F32_V(float*, float*, unsigned long):                      # @Add_F32_V(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB1_7
        cmpq    $32, %rdx
        jae     .LBB1_3
        xorl    %eax, %eax
        jmp     .LBB1_6
.LBB1_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm0
        vmovups 32(%rdi,%rcx,4), %ymm1
        vmovups 64(%rdi,%rcx,4), %ymm2
        vmovups 96(%rdi,%rcx,4), %ymm3
        vaddps  (%rsi,%rcx,4), %ymm0, %ymm0
        vaddps  32(%rsi,%rcx,4), %ymm1, %ymm1
        vaddps  64(%rsi,%rcx,4), %ymm2, %ymm2
        vaddps  96(%rsi,%rcx,4), %ymm3, %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB1_4
        cmpq    %rdx, %rax
        je      .LBB1_7
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vaddss  (%rsi,%rax,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB1_6
.LBB1_7:
        vzeroupper
        retq
AddNumber_F64_V(double*, double, unsigned long):                # @AddNumber_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB2_11
        cmpq    $16, %rsi
        jae     .LBB2_3
        xorl    %eax, %eax
        jmp     .LBB2_10
.LBB2_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB2_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
        vaddpd  (%rdi,%rcx,8), %ymm1, %ymm2
        vaddpd  32(%rdi,%rcx,8), %ymm1, %ymm3
        vaddpd  64(%rdi,%rcx,8), %ymm1, %ymm4
        vaddpd  96(%rdi,%rcx,8), %ymm1, %ymm5
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm5, 96(%rdi,%rcx,8)
        vaddpd  128(%rdi,%rcx,8), %ymm1, %ymm2
        vaddpd  160(%rdi,%rcx,8), %ymm1, %ymm3
        vaddpd  192(%rdi,%rcx,8), %ymm1, %ymm4
        vaddpd  224(%rdi,%rcx,8), %ymm1, %ymm5
        vmovupd %ymm2, 128(%rdi,%rcx,8)
        vmovupd %ymm3, 160(%rdi,%rcx,8)
        vmovupd %ymm4, 192(%rdi,%rcx,8)
        vmovupd %ymm5, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %rdx
        jne     .LBB2_6
        testb   $1, %r8b
        je      .LBB2_9
.LBB2_8:
        vaddpd  (%rdi,%rcx,8), %ymm1, %ymm2
        vaddpd  32(%rdi,%rcx,8), %ymm1, %ymm3
        vaddpd  64(%rdi,%rcx,8), %ymm1, %ymm4
        vaddpd  96(%rdi,%rcx,8), %ymm1, %ymm1
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm1, 96(%rdi,%rcx,8)
.LBB2_9:
        cmpq    %rsi, %rax
        je      .LBB2_11
.LBB2_10:                               # =>This Inner Loop Header: Depth=1
        vaddsd  (%rdi,%rax,8), %xmm0, %xmm1
        vmovsd  %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB2_10
.LBB2_11:
        vzeroupper
        retq
.LBB2_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB2_8
        jmp     .LBB2_9
AddNumber_F32_V(float*, float, unsigned long):                # @AddNumber_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB3_11
        cmpq    $32, %rsi
        jae     .LBB3_3
        xorl    %eax, %eax
        jmp     .LBB3_10
.LBB3_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB3_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
        vaddps  (%rdi,%rcx,4), %ymm1, %ymm2
        vaddps  32(%rdi,%rcx,4), %ymm1, %ymm3
        vaddps  64(%rdi,%rcx,4), %ymm1, %ymm4
        vaddps  96(%rdi,%rcx,4), %ymm1, %ymm5
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm5, 96(%rdi,%rcx,4)
        vaddps  128(%rdi,%rcx,4), %ymm1, %ymm2
        vaddps  160(%rdi,%rcx,4), %ymm1, %ymm3
        vaddps  192(%rdi,%rcx,4), %ymm1, %ymm4
        vaddps  224(%rdi,%rcx,4), %ymm1, %ymm5
        vmovups %ymm2, 128(%rdi,%rcx,4)
        vmovups %ymm3, 160(%rdi,%rcx,4)
        vmovups %ymm4, 192(%rdi,%rcx,4)
        vmovups %ymm5, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %rdx
        jne     .LBB3_6
        testb   $1, %r8b
        je      .LBB3_9
.LBB3_8:
        vaddps  (%rdi,%rcx,4), %ymm1, %ymm2
        vaddps  32(%rdi,%rcx,4), %ymm1, %ymm3
        vaddps  64(%rdi,%rcx,4), %ymm1, %ymm4
        vaddps  96(%rdi,%rcx,4), %ymm1, %ymm1
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm1, 96(%rdi,%rcx,4)
.LBB3_9:
        cmpq    %rsi, %rax
        je      .LBB3_11
.LBB3_10:                               # =>This Inner Loop Header: Depth=1
        vaddss  (%rdi,%rax,4), %xmm0, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB3_10
.LBB3_11:
        vzeroupper
        retq
.LBB3_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB3_8
        jmp     .LBB3_9
Sub_F64_V(double*, double*, unsigned long):                      # @Sub_F64_V(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB4_7
        cmpq    $16, %rdx
        jae     .LBB4_3
        xorl    %eax, %eax
        jmp     .LBB4_6
.LBB4_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm0
        vmovupd 32(%rdi,%rcx,8), %ymm1
        vmovupd 64(%rdi,%rcx,8), %ymm2
        vmovupd 96(%rdi,%rcx,8), %ymm3
        vsubpd  (%rsi,%rcx,8), %ymm0, %ymm0
        vsubpd  32(%rsi,%rcx,8), %ymm1, %ymm1
        vsubpd  64(%rsi,%rcx,8), %ymm2, %ymm2
        vsubpd  96(%rsi,%rcx,8), %ymm3, %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB4_4
        cmpq    %rdx, %rax
        je      .LBB4_7
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vsubsd  (%rsi,%rax,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB4_6
.LBB4_7:
        vzeroupper
        retq
Sub_F32_V(float*, float*, unsigned long):                      # @Sub_F32_V(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB5_7
        cmpq    $32, %rdx
        jae     .LBB5_3
        xorl    %eax, %eax
        jmp     .LBB5_6
.LBB5_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
.LBB5_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm0
        vmovups 32(%rdi,%rcx,4), %ymm1
        vmovups 64(%rdi,%rcx,4), %ymm2
        vmovups 96(%rdi,%rcx,4), %ymm3
        vsubps  (%rsi,%rcx,4), %ymm0, %ymm0
        vsubps  32(%rsi,%rcx,4), %ymm1, %ymm1
        vsubps  64(%rsi,%rcx,4), %ymm2, %ymm2
        vsubps  96(%rsi,%rcx,4), %ymm3, %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB5_4
        cmpq    %rdx, %rax
        je      .LBB5_7
.LBB5_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vsubss  (%rsi,%rax,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB5_6
.LBB5_7:
        vzeroupper
        retq
SubNumber_F64_V(double*, double, unsigned long):                # @SubNumber_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB6_11
        cmpq    $16, %rsi
        jae     .LBB6_3
        xorl    %eax, %eax
        jmp     .LBB6_10
.LBB6_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
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
        vmovupd (%rdi,%rcx,8), %ymm2
        vmovupd 32(%rdi,%rcx,8), %ymm3
        vmovupd 64(%rdi,%rcx,8), %ymm4
        vmovupd 96(%rdi,%rcx,8), %ymm5
        vsubpd  %ymm1, %ymm2, %ymm2
        vsubpd  %ymm1, %ymm3, %ymm3
        vsubpd  %ymm1, %ymm4, %ymm4
        vsubpd  %ymm1, %ymm5, %ymm5
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm5, 96(%rdi,%rcx,8)
        vmovupd 128(%rdi,%rcx,8), %ymm2
        vmovupd 160(%rdi,%rcx,8), %ymm3
        vmovupd 192(%rdi,%rcx,8), %ymm4
        vmovupd 224(%rdi,%rcx,8), %ymm5
        vsubpd  %ymm1, %ymm2, %ymm2
        vsubpd  %ymm1, %ymm3, %ymm3
        vsubpd  %ymm1, %ymm4, %ymm4
        vsubpd  %ymm1, %ymm5, %ymm5
        vmovupd %ymm2, 128(%rdi,%rcx,8)
        vmovupd %ymm3, 160(%rdi,%rcx,8)
        vmovupd %ymm4, 192(%rdi,%rcx,8)
        vmovupd %ymm5, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %rdx
        jne     .LBB6_6
        testb   $1, %r8b
        je      .LBB6_9
.LBB6_8:
        vmovupd (%rdi,%rcx,8), %ymm2
        vmovupd 32(%rdi,%rcx,8), %ymm3
        vmovupd 64(%rdi,%rcx,8), %ymm4
        vmovupd 96(%rdi,%rcx,8), %ymm5
        vsubpd  %ymm1, %ymm2, %ymm2
        vsubpd  %ymm1, %ymm3, %ymm3
        vsubpd  %ymm1, %ymm4, %ymm4
        vsubpd  %ymm1, %ymm5, %ymm1
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm1, 96(%rdi,%rcx,8)
.LBB6_9:
        cmpq    %rsi, %rax
        je      .LBB6_11
.LBB6_10:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        vsubsd  %xmm0, %xmm1, %xmm1
        vmovsd  %xmm1, (%rdi,%rax,8)
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
SubNumber_F32_V(float*, float, unsigned long):                # @SubNumber_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB7_11
        cmpq    $32, %rsi
        jae     .LBB7_3
        xorl    %eax, %eax
        jmp     .LBB7_10
.LBB7_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
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
        vmovups (%rdi,%rcx,4), %ymm2
        vmovups 32(%rdi,%rcx,4), %ymm3
        vmovups 64(%rdi,%rcx,4), %ymm4
        vmovups 96(%rdi,%rcx,4), %ymm5
        vsubps  %ymm1, %ymm2, %ymm2
        vsubps  %ymm1, %ymm3, %ymm3
        vsubps  %ymm1, %ymm4, %ymm4
        vsubps  %ymm1, %ymm5, %ymm5
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm5, 96(%rdi,%rcx,4)
        vmovups 128(%rdi,%rcx,4), %ymm2
        vmovups 160(%rdi,%rcx,4), %ymm3
        vmovups 192(%rdi,%rcx,4), %ymm4
        vmovups 224(%rdi,%rcx,4), %ymm5
        vsubps  %ymm1, %ymm2, %ymm2
        vsubps  %ymm1, %ymm3, %ymm3
        vsubps  %ymm1, %ymm4, %ymm4
        vsubps  %ymm1, %ymm5, %ymm5
        vmovups %ymm2, 128(%rdi,%rcx,4)
        vmovups %ymm3, 160(%rdi,%rcx,4)
        vmovups %ymm4, 192(%rdi,%rcx,4)
        vmovups %ymm5, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %rdx
        jne     .LBB7_6
        testb   $1, %r8b
        je      .LBB7_9
.LBB7_8:
        vmovups (%rdi,%rcx,4), %ymm2
        vmovups 32(%rdi,%rcx,4), %ymm3
        vmovups 64(%rdi,%rcx,4), %ymm4
        vmovups 96(%rdi,%rcx,4), %ymm5
        vsubps  %ymm1, %ymm2, %ymm2
        vsubps  %ymm1, %ymm3, %ymm3
        vsubps  %ymm1, %ymm4, %ymm4
        vsubps  %ymm1, %ymm5, %ymm1
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm1, 96(%rdi,%rcx,4)
.LBB7_9:
        cmpq    %rsi, %rax
        je      .LBB7_11
.LBB7_10:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vsubss  %xmm0, %xmm1, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
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
Mul_F64_V(double*, double*, unsigned long):                      # @Mul_F64_V(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB8_7
        cmpq    $16, %rdx
        jae     .LBB8_3
        xorl    %eax, %eax
        jmp     .LBB8_6
.LBB8_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
.LBB8_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm0
        vmovupd 32(%rdi,%rcx,8), %ymm1
        vmovupd 64(%rdi,%rcx,8), %ymm2
        vmovupd 96(%rdi,%rcx,8), %ymm3
        vmulpd  (%rsi,%rcx,8), %ymm0, %ymm0
        vmulpd  32(%rsi,%rcx,8), %ymm1, %ymm1
        vmulpd  64(%rsi,%rcx,8), %ymm2, %ymm2
        vmulpd  96(%rsi,%rcx,8), %ymm3, %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovupd %ymm1, 32(%rdi,%rcx,8)
        vmovupd %ymm2, 64(%rdi,%rcx,8)
        vmovupd %ymm3, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB8_4
        cmpq    %rdx, %rax
        je      .LBB8_7
.LBB8_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vmulsd  (%rsi,%rax,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB8_6
.LBB8_7:
        vzeroupper
        retq
Mul_F32_V(float*, float*, unsigned long):                      # @Mul_F32_V(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB9_7
        cmpq    $32, %rdx
        jae     .LBB9_3
        xorl    %eax, %eax
        jmp     .LBB9_6
.LBB9_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
.LBB9_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm0
        vmovups 32(%rdi,%rcx,4), %ymm1
        vmovups 64(%rdi,%rcx,4), %ymm2
        vmovups 96(%rdi,%rcx,4), %ymm3
        vmulps  (%rsi,%rcx,4), %ymm0, %ymm0
        vmulps  32(%rsi,%rcx,4), %ymm1, %ymm1
        vmulps  64(%rsi,%rcx,4), %ymm2, %ymm2
        vmulps  96(%rsi,%rcx,4), %ymm3, %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB9_4
        cmpq    %rdx, %rax
        je      .LBB9_7
.LBB9_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vmulss  (%rsi,%rax,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB9_6
.LBB9_7:
        vzeroupper
        retq
MulNumber_F64_V(double*, double, unsigned long):                # @MulNumber_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB10_11
        cmpq    $16, %rsi
        jae     .LBB10_3
        xorl    %eax, %eax
        jmp     .LBB10_10
.LBB10_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB10_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB10_6:                               # =>This Inner Loop Header: Depth=1
        vmulpd  (%rdi,%rcx,8), %ymm1, %ymm2
        vmulpd  32(%rdi,%rcx,8), %ymm1, %ymm3
        vmulpd  64(%rdi,%rcx,8), %ymm1, %ymm4
        vmulpd  96(%rdi,%rcx,8), %ymm1, %ymm5
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm5, 96(%rdi,%rcx,8)
        vmulpd  128(%rdi,%rcx,8), %ymm1, %ymm2
        vmulpd  160(%rdi,%rcx,8), %ymm1, %ymm3
        vmulpd  192(%rdi,%rcx,8), %ymm1, %ymm4
        vmulpd  224(%rdi,%rcx,8), %ymm1, %ymm5
        vmovupd %ymm2, 128(%rdi,%rcx,8)
        vmovupd %ymm3, 160(%rdi,%rcx,8)
        vmovupd %ymm4, 192(%rdi,%rcx,8)
        vmovupd %ymm5, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %rdx
        jne     .LBB10_6
        testb   $1, %r8b
        je      .LBB10_9
.LBB10_8:
        vmulpd  (%rdi,%rcx,8), %ymm1, %ymm2
        vmulpd  32(%rdi,%rcx,8), %ymm1, %ymm3
        vmulpd  64(%rdi,%rcx,8), %ymm1, %ymm4
        vmulpd  96(%rdi,%rcx,8), %ymm1, %ymm1
        vmovupd %ymm2, (%rdi,%rcx,8)
        vmovupd %ymm3, 32(%rdi,%rcx,8)
        vmovupd %ymm4, 64(%rdi,%rcx,8)
        vmovupd %ymm1, 96(%rdi,%rcx,8)
.LBB10_9:
        cmpq    %rsi, %rax
        je      .LBB10_11
.LBB10_10:                              # =>This Inner Loop Header: Depth=1
        vmulsd  (%rdi,%rax,8), %xmm0, %xmm1
        vmovsd  %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB10_10
.LBB10_11:
        vzeroupper
        retq
.LBB10_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB10_8
        jmp     .LBB10_9
MulNumber_F32_V(float*, float, unsigned long):                # @MulNumber_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB11_11
        cmpq    $32, %rsi
        jae     .LBB11_3
        xorl    %eax, %eax
        jmp     .LBB11_10
.LBB11_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB11_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
.LBB11_6:                               # =>This Inner Loop Header: Depth=1
        vmulps  (%rdi,%rcx,4), %ymm1, %ymm2
        vmulps  32(%rdi,%rcx,4), %ymm1, %ymm3
        vmulps  64(%rdi,%rcx,4), %ymm1, %ymm4
        vmulps  96(%rdi,%rcx,4), %ymm1, %ymm5
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm5, 96(%rdi,%rcx,4)
        vmulps  128(%rdi,%rcx,4), %ymm1, %ymm2
        vmulps  160(%rdi,%rcx,4), %ymm1, %ymm3
        vmulps  192(%rdi,%rcx,4), %ymm1, %ymm4
        vmulps  224(%rdi,%rcx,4), %ymm1, %ymm5
        vmovups %ymm2, 128(%rdi,%rcx,4)
        vmovups %ymm3, 160(%rdi,%rcx,4)
        vmovups %ymm4, 192(%rdi,%rcx,4)
        vmovups %ymm5, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %rdx
        jne     .LBB11_6
        testb   $1, %r8b
        je      .LBB11_9
.LBB11_8:
        vmulps  (%rdi,%rcx,4), %ymm1, %ymm2
        vmulps  32(%rdi,%rcx,4), %ymm1, %ymm3
        vmulps  64(%rdi,%rcx,4), %ymm1, %ymm4
        vmulps  96(%rdi,%rcx,4), %ymm1, %ymm1
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm1, 96(%rdi,%rcx,4)
.LBB11_9:
        cmpq    %rsi, %rax
        je      .LBB11_11
.LBB11_10:                              # =>This Inner Loop Header: Depth=1
        vmulss  (%rdi,%rax,4), %xmm0, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB11_10
.LBB11_11:
        vzeroupper
        retq
.LBB11_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB11_8
        jmp     .LBB11_9
Div_F64_V(double*, double*, unsigned long):                      # @Div_F64_V(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB12_11
        cmpq    $4, %rdx
        jae     .LBB12_3
        xorl    %eax, %eax
        jmp     .LBB12_10
.LBB12_3:
        movq    %rdx, %rax
        andq    $-4, %rax
        leaq    -4(%rax), %rcx
        movq    %rcx, %r8
        shrq    $2, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB12_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB12_6:                               # =>This Inner Loop Header: Depth=1
        vmovupd (%rdi,%rcx,8), %ymm0
        vdivpd  (%rsi,%rcx,8), %ymm0, %ymm0
        vmovupd 32(%rdi,%rcx,8), %ymm1
        vmovupd %ymm0, (%rdi,%rcx,8)
        vdivpd  32(%rsi,%rcx,8), %ymm1, %ymm0
        vmovupd %ymm0, 32(%rdi,%rcx,8)
        addq    $8, %rcx
        addq    $-2, %r9
        jne     .LBB12_6
        testb   $1, %r8b
        je      .LBB12_9
.LBB12_8:
        vmovupd (%rdi,%rcx,8), %ymm0
        vdivpd  (%rsi,%rcx,8), %ymm0, %ymm0
        vmovupd %ymm0, (%rdi,%rcx,8)
.LBB12_9:
        cmpq    %rdx, %rax
        je      .LBB12_11
.LBB12_10:                              # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vdivsd  (%rsi,%rax,8), %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB12_10
.LBB12_11:
        vzeroupper
        retq
.LBB12_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB12_8
        jmp     .LBB12_9
Div_F32_V(float*, float*, unsigned long):                      # @Div_F32_V(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB13_7
        cmpq    $32, %rdx
        jae     .LBB13_3
        xorl    %eax, %eax
        jmp     .LBB13_6
.LBB13_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
.LBB13_4:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx,4), %ymm0
        vmovups 32(%rsi,%rcx,4), %ymm1
        vmovups 64(%rsi,%rcx,4), %ymm2
        vrcpps  %ymm0, %ymm3
        vmovups 96(%rsi,%rcx,4), %ymm4
        vmovups (%rdi,%rcx,4), %ymm5
        vmovups 32(%rdi,%rcx,4), %ymm6
        vmovups 64(%rdi,%rcx,4), %ymm7
        vmovups 96(%rdi,%rcx,4), %ymm8
        vmulps  %ymm3, %ymm5, %ymm9
        vfmsub213ps     %ymm5, %ymm9, %ymm0     # ymm0 = (ymm9 * ymm0) - ymm5
        vfnmadd213ps    %ymm9, %ymm3, %ymm0     # ymm0 = -(ymm3 * ymm0) + ymm9
        vrcpps  %ymm1, %ymm3
        vmulps  %ymm3, %ymm6, %ymm5
        vfmsub213ps     %ymm6, %ymm5, %ymm1     # ymm1 = (ymm5 * ymm1) - ymm6
        vrcpps  %ymm2, %ymm6
        vfnmadd213ps    %ymm5, %ymm3, %ymm1     # ymm1 = -(ymm3 * ymm1) + ymm5
        vmulps  %ymm6, %ymm7, %ymm3
        vfmsub213ps     %ymm7, %ymm3, %ymm2     # ymm2 = (ymm3 * ymm2) - ymm7
        vfnmadd213ps    %ymm3, %ymm6, %ymm2     # ymm2 = -(ymm6 * ymm2) + ymm3
        vrcpps  %ymm4, %ymm3
        vmulps  %ymm3, %ymm8, %ymm5
        vfmsub213ps     %ymm8, %ymm5, %ymm4     # ymm4 = (ymm5 * ymm4) - ymm8
        vfnmadd213ps    %ymm5, %ymm3, %ymm4     # ymm4 = -(ymm3 * ymm4) + ymm5
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm4, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB13_4
        cmpq    %rdx, %rax
        je      .LBB13_7
.LBB13_6:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vdivss  (%rsi,%rax,4), %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB13_6
.LBB13_7:
        vzeroupper
        retq
.LCPI14_0:
        .quad   0x3ff0000000000000              # double 1
DivNumber_F64_V(double*, double, unsigned long):                # @DivNumber_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB14_12
        cmpq    $4, %rsi
        jae     .LBB14_3
        xorl    %eax, %eax
        jmp     .LBB14_10
.LBB14_3:
        movq    %rsi, %rax
        andq    $-4, %rax
        vbroadcastsd    %xmm0, %ymm1
        leaq    -4(%rax), %rcx
        movq    %rcx, %r8
        shrq    $2, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB14_4
        movq    %r8, %rcx
        andq    $-2, %rcx
        vbroadcastsd    .LCPI14_0(%rip), %ymm2  # ymm2 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vdivpd  %ymm1, %ymm2, %ymm2
        xorl    %edx, %edx
.LBB14_6:                               # =>This Inner Loop Header: Depth=1
        vmulpd  (%rdi,%rdx,8), %ymm2, %ymm3
        vmovupd %ymm3, (%rdi,%rdx,8)
        vmulpd  32(%rdi,%rdx,8), %ymm2, %ymm3
        vmovupd %ymm3, 32(%rdi,%rdx,8)
        addq    $8, %rdx
        addq    $-2, %rcx
        jne     .LBB14_6
        testb   $1, %r8b
        je      .LBB14_9
.LBB14_8:
        vmovupd (%rdi,%rdx,8), %ymm2
        vdivpd  %ymm1, %ymm2, %ymm1
        vmovupd %ymm1, (%rdi,%rdx,8)
.LBB14_9:
        cmpq    %rsi, %rax
        je      .LBB14_12
.LBB14_10:
        vmovsd  .LCPI14_0(%rip), %xmm1          # xmm1 = mem[0],zero
        vdivsd  %xmm0, %xmm1, %xmm0
.LBB14_11:                              # =>This Inner Loop Header: Depth=1
        vmulsd  (%rdi,%rax,8), %xmm0, %xmm1
        vmovsd  %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB14_11
.LBB14_12:
        vzeroupper
        retq
.LBB14_4:
        xorl    %edx, %edx
        testb   $1, %r8b
        jne     .LBB14_8
        jmp     .LBB14_9
.LCPI15_0:
        .long   0x3f800000                      # float 1
DivNumber_F32_V(float*, float, unsigned long):                # @DivNumber_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB15_8
        cmpq    $32, %rsi
        jae     .LBB15_3
        xorl    %eax, %eax
        jmp     .LBB15_6
.LBB15_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vmovss  .LCPI15_0(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
        vdivss  %xmm0, %xmm1, %xmm1
        vbroadcastss    %xmm1, %ymm1
        xorl    %ecx, %ecx
.LBB15_4:                               # =>This Inner Loop Header: Depth=1
        vmulps  (%rdi,%rcx,4), %ymm1, %ymm2
        vmulps  32(%rdi,%rcx,4), %ymm1, %ymm3
        vmulps  64(%rdi,%rcx,4), %ymm1, %ymm4
        vmulps  96(%rdi,%rcx,4), %ymm1, %ymm5
        vmovups %ymm2, (%rdi,%rcx,4)
        vmovups %ymm3, 32(%rdi,%rcx,4)
        vmovups %ymm4, 64(%rdi,%rcx,4)
        vmovups %ymm5, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB15_4
        cmpq    %rsi, %rax
        je      .LBB15_8
.LBB15_6:
        vmovss  .LCPI15_0(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
        vdivss  %xmm0, %xmm1, %xmm0
.LBB15_7:                               # =>This Inner Loop Header: Depth=1
        vmulss  (%rdi,%rax,4), %xmm0, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB15_7
.LBB15_8:
        vzeroupper
        retq
.LCPI16_0:
        .quad   0x7fffffffffffffff              # double NaN
.LCPI16_1:
        .quad   0x7fffffffffffffff              # double NaN
        .quad   0x7fffffffffffffff              # double NaN
Abs_F64_V(double*, unsigned long):                        # @Abs_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB16_8
        cmpq    $16, %rsi
        jae     .LBB16_3
        xorl    %eax, %eax
        jmp     .LBB16_6
.LBB16_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
        vbroadcastsd    .LCPI16_0(%rip), %ymm0  # ymm0 = [NaN,NaN,NaN,NaN]
.LBB16_4:                               # =>This Inner Loop Header: Depth=1
        vandps  (%rdi,%rcx,8), %ymm0, %ymm1
        vandps  32(%rdi,%rcx,8), %ymm0, %ymm2
        vandps  64(%rdi,%rcx,8), %ymm0, %ymm3
        vandps  96(%rdi,%rcx,8), %ymm0, %ymm4
        vmovups %ymm1, (%rdi,%rcx,8)
        vmovups %ymm2, 32(%rdi,%rcx,8)
        vmovups %ymm3, 64(%rdi,%rcx,8)
        vmovups %ymm4, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB16_4
        cmpq    %rsi, %rax
        je      .LBB16_8
.LBB16_6:
        vmovaps .LCPI16_1(%rip), %xmm0          # xmm0 = [NaN,NaN]
.LBB16_7:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        vandps  %xmm0, %xmm1, %xmm1
        vmovlps %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB16_7
.LBB16_8:
        vzeroupper
        retq
.LCPI17_0:
        .long   0x7fffffff                      # float NaN
Abs_F32_V(float*, unsigned long):                        # @Abs_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB17_8
        cmpq    $32, %rsi
        jae     .LBB17_3
        xorl    %eax, %eax
        jmp     .LBB17_6
.LBB17_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI17_0(%rip), %ymm0  # ymm0 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
.LBB17_4:                               # =>This Inner Loop Header: Depth=1
        vandps  (%rdi,%rcx,4), %ymm0, %ymm1
        vandps  32(%rdi,%rcx,4), %ymm0, %ymm2
        vandps  64(%rdi,%rcx,4), %ymm0, %ymm3
        vandps  96(%rdi,%rcx,4), %ymm0, %ymm4
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm2, 32(%rdi,%rcx,4)
        vmovups %ymm3, 64(%rdi,%rcx,4)
        vmovups %ymm4, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB17_4
        cmpq    %rsi, %rax
        je      .LBB17_8
.LBB17_6:
        vbroadcastss    .LCPI17_0(%rip), %xmm0  # xmm0 = [NaN,NaN,NaN,NaN]
.LBB17_7:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vandps  %xmm0, %xmm1, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB17_7
.LBB17_8:
        vzeroupper
        retq
.LCPI18_0:
        .quad   0x8000000000000000              # double -0
.LCPI18_1:
        .quad   0x8000000000000000              # double -0
        .quad   0x8000000000000000              # double -0
Neg_F64_V(double*, unsigned long):                        # @Neg_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB18_12
        cmpq    $16, %rsi
        jae     .LBB18_3
        xorl    %eax, %eax
        jmp     .LBB18_10
.LBB18_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB18_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
        vbroadcastsd    .LCPI18_0(%rip), %ymm0  # ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
.LBB18_6:                               # =>This Inner Loop Header: Depth=1
        vxorps  (%rdi,%rcx,8), %ymm0, %ymm1
        vxorps  32(%rdi,%rcx,8), %ymm0, %ymm2
        vxorps  64(%rdi,%rcx,8), %ymm0, %ymm3
        vxorps  96(%rdi,%rcx,8), %ymm0, %ymm4
        vmovups %ymm1, (%rdi,%rcx,8)
        vmovups %ymm2, 32(%rdi,%rcx,8)
        vmovups %ymm3, 64(%rdi,%rcx,8)
        vmovups %ymm4, 96(%rdi,%rcx,8)
        vxorps  128(%rdi,%rcx,8), %ymm0, %ymm1
        vxorps  160(%rdi,%rcx,8), %ymm0, %ymm2
        vxorps  192(%rdi,%rcx,8), %ymm0, %ymm3
        vxorps  224(%rdi,%rcx,8), %ymm0, %ymm4
        vmovups %ymm1, 128(%rdi,%rcx,8)
        vmovups %ymm2, 160(%rdi,%rcx,8)
        vmovups %ymm3, 192(%rdi,%rcx,8)
        vmovups %ymm4, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %rdx
        jne     .LBB18_6
        testb   $1, %r8b
        je      .LBB18_9
.LBB18_8:
        vbroadcastsd    .LCPI18_0(%rip), %ymm0  # ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
        vxorps  (%rdi,%rcx,8), %ymm0, %ymm1
        vxorps  32(%rdi,%rcx,8), %ymm0, %ymm2
        vxorps  64(%rdi,%rcx,8), %ymm0, %ymm3
        vxorps  96(%rdi,%rcx,8), %ymm0, %ymm0
        vmovups %ymm1, (%rdi,%rcx,8)
        vmovups %ymm2, 32(%rdi,%rcx,8)
        vmovups %ymm3, 64(%rdi,%rcx,8)
        vmovups %ymm0, 96(%rdi,%rcx,8)
.LBB18_9:
        cmpq    %rsi, %rax
        je      .LBB18_12
.LBB18_10:
        vmovaps .LCPI18_1(%rip), %xmm0          # xmm0 = [-0.0E+0,-0.0E+0]
.LBB18_11:                              # =>This Inner Loop Header: Depth=1
        vmovsd  (%rdi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        vxorps  %xmm0, %xmm1, %xmm1
        vmovlps %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB18_11
.LBB18_12:
        vzeroupper
        retq
.LBB18_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB18_8
        jmp     .LBB18_9
.LCPI19_0:
        .long   0x80000000                      # float -0
Neg_F32_V(float*, unsigned long):                        # @Neg_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB19_12
        cmpq    $32, %rsi
        jae     .LBB19_3
        xorl    %eax, %eax
        jmp     .LBB19_10
.LBB19_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB19_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI19_0(%rip), %ymm0  # ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
.LBB19_6:                               # =>This Inner Loop Header: Depth=1
        vxorps  (%rdi,%rcx,4), %ymm0, %ymm1
        vxorps  32(%rdi,%rcx,4), %ymm0, %ymm2
        vxorps  64(%rdi,%rcx,4), %ymm0, %ymm3
        vxorps  96(%rdi,%rcx,4), %ymm0, %ymm4
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm2, 32(%rdi,%rcx,4)
        vmovups %ymm3, 64(%rdi,%rcx,4)
        vmovups %ymm4, 96(%rdi,%rcx,4)
        vxorps  128(%rdi,%rcx,4), %ymm0, %ymm1
        vxorps  160(%rdi,%rcx,4), %ymm0, %ymm2
        vxorps  192(%rdi,%rcx,4), %ymm0, %ymm3
        vxorps  224(%rdi,%rcx,4), %ymm0, %ymm4
        vmovups %ymm1, 128(%rdi,%rcx,4)
        vmovups %ymm2, 160(%rdi,%rcx,4)
        vmovups %ymm3, 192(%rdi,%rcx,4)
        vmovups %ymm4, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %rdx
        jne     .LBB19_6
        testb   $1, %r8b
        je      .LBB19_9
.LBB19_8:
        vbroadcastss    .LCPI19_0(%rip), %ymm0  # ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
        vxorps  (%rdi,%rcx,4), %ymm0, %ymm1
        vxorps  32(%rdi,%rcx,4), %ymm0, %ymm2
        vxorps  64(%rdi,%rcx,4), %ymm0, %ymm3
        vxorps  96(%rdi,%rcx,4), %ymm0, %ymm0
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm2, 32(%rdi,%rcx,4)
        vmovups %ymm3, 64(%rdi,%rcx,4)
        vmovups %ymm0, 96(%rdi,%rcx,4)
.LBB19_9:
        cmpq    %rsi, %rax
        je      .LBB19_12
.LBB19_10:
        vbroadcastss    .LCPI19_0(%rip), %xmm0  # xmm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
.LBB19_11:                              # =>This Inner Loop Header: Depth=1
        vmovss  (%rdi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vxorps  %xmm0, %xmm1, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB19_11
.LBB19_12:
        vzeroupper
        retq
.LBB19_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB19_8
        jmp     .LBB19_9
.LCPI20_0:
        .quad   0x3ff0000000000000              # double 1
Inv_F64_V(double*, unsigned long):                        # @Inv_F64_V(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB20_12
        cmpq    $4, %rsi
        jae     .LBB20_3
        xorl    %eax, %eax
        jmp     .LBB20_10
.LBB20_3:
        movq    %rsi, %rax
        andq    $-4, %rax
        leaq    -4(%rax), %rcx
        movq    %rcx, %r8
        shrq    $2, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB20_4
        movq    %r8, %rcx
        andq    $-2, %rcx
        xorl    %edx, %edx
        vbroadcastsd    .LCPI20_0(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
.LBB20_6:                               # =>This Inner Loop Header: Depth=1
        vdivpd  (%rdi,%rdx,8), %ymm0, %ymm1
        vmovupd %ymm1, (%rdi,%rdx,8)
        vdivpd  32(%rdi,%rdx,8), %ymm0, %ymm1
        vmovupd %ymm1, 32(%rdi,%rdx,8)
        addq    $8, %rdx
        addq    $-2, %rcx
        jne     .LBB20_6
        testb   $1, %r8b
        je      .LBB20_9
.LBB20_8:
        vbroadcastsd    .LCPI20_0(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
        vdivpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vmovupd %ymm0, (%rdi,%rdx,8)
.LBB20_9:
        cmpq    %rsi, %rax
        je      .LBB20_12
.LBB20_10:
        vmovsd  .LCPI20_0(%rip), %xmm0          # xmm0 = mem[0],zero
.LBB20_11:                              # =>This Inner Loop Header: Depth=1
        vdivsd  (%rdi,%rax,8), %xmm0, %xmm1
        vmovsd  %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB20_11
.LBB20_12:
        vzeroupper
        retq
.LBB20_4:
        xorl    %edx, %edx
        testb   $1, %r8b
        jne     .LBB20_8
        jmp     .LBB20_9
.LCPI21_0:
        .long   0x3f800000                      # float 1
Inv_F32_V(float*, unsigned long):                        # @Inv_F32_V(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB21_8
        cmpq    $32, %rsi
        jae     .LBB21_3
        xorl    %eax, %eax
        jmp     .LBB21_6
.LBB21_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI21_0(%rip), %ymm0  # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
.LBB21_4:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdi,%rcx,4), %ymm1
        vmovups 32(%rdi,%rcx,4), %ymm2
        vmovups 64(%rdi,%rcx,4), %ymm3
        vrcpps  %ymm1, %ymm4
        vfmsub213ps     %ymm0, %ymm4, %ymm1     # ymm1 = (ymm4 * ymm1) - ymm0
        vrcpps  %ymm2, %ymm5
        vfnmadd132ps    %ymm4, %ymm4, %ymm1     # ymm1 = -(ymm1 * ymm4) + ymm4
        vmovups 96(%rdi,%rcx,4), %ymm4
        vfmsub213ps     %ymm0, %ymm5, %ymm2     # ymm2 = (ymm5 * ymm2) - ymm0
        vfnmadd132ps    %ymm5, %ymm5, %ymm2     # ymm2 = -(ymm2 * ymm5) + ymm5
        vrcpps  %ymm3, %ymm5
        vfmsub213ps     %ymm0, %ymm5, %ymm3     # ymm3 = (ymm5 * ymm3) - ymm0
        vfnmadd132ps    %ymm5, %ymm5, %ymm3     # ymm3 = -(ymm3 * ymm5) + ymm5
        vrcpps  %ymm4, %ymm5
        vfmsub213ps     %ymm0, %ymm5, %ymm4     # ymm4 = (ymm5 * ymm4) - ymm0
        vfnmadd132ps    %ymm5, %ymm5, %ymm4     # ymm4 = -(ymm4 * ymm5) + ymm5
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm2, 32(%rdi,%rcx,4)
        vmovups %ymm3, 64(%rdi,%rcx,4)
        vmovups %ymm4, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB21_4
        cmpq    %rsi, %rax
        je      .LBB21_8
.LBB21_6:
        vmovss  .LCPI21_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
.LBB21_7:                               # =>This Inner Loop Header: Depth=1
        vdivss  (%rdi,%rax,4), %xmm0, %xmm1
        vmovss  %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB21_7
.LBB21_8:
        vzeroupper
        retq