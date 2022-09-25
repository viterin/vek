Mat4Mul_F64_V(double*, double*, double*):                # @Mat4Mul_F64_V(double*, double*, double*)
        vbroadcastsd    (%rsi), %ymm0
        vmovupd (%rdx), %ymm1
        vmovupd 32(%rdx), %ymm2
        vmovupd 64(%rdx), %ymm3
        vmovupd 96(%rdx), %ymm4
        vmulpd  %ymm0, %ymm1, %ymm0
        vbroadcastsd    8(%rsi), %ymm5
        vfmadd213pd     %ymm0, %ymm2, %ymm5     # ymm5 = (ymm2 * ymm5) + ymm0
        vbroadcastsd    16(%rsi), %ymm0
        vfmadd213pd     %ymm5, %ymm3, %ymm0     # ymm0 = (ymm3 * ymm0) + ymm5
        vbroadcastsd    24(%rsi), %ymm5
        vfmadd213pd     %ymm0, %ymm4, %ymm5     # ymm5 = (ymm4 * ymm5) + ymm0
        vmovupd %ymm5, (%rdi)
        vbroadcastsd    32(%rsi), %ymm0
        vmulpd  %ymm0, %ymm1, %ymm0
        vbroadcastsd    40(%rsi), %ymm1
        vfmadd213pd     %ymm0, %ymm2, %ymm1     # ymm1 = (ymm2 * ymm1) + ymm0
        vbroadcastsd    48(%rsi), %ymm0
        vfmadd213pd     %ymm1, %ymm3, %ymm0     # ymm0 = (ymm3 * ymm0) + ymm1
        vbroadcastsd    56(%rsi), %ymm1
        vfmadd213pd     %ymm0, %ymm4, %ymm1     # ymm1 = (ymm4 * ymm1) + ymm0
        vmovupd %ymm1, 32(%rdi)
        vbroadcastsd    64(%rsi), %ymm0
        vmovupd (%rdx), %ymm1
        vmovupd 32(%rdx), %ymm2
        vmovupd 64(%rdx), %ymm3
        vmovupd 96(%rdx), %ymm4
        vmulpd  %ymm0, %ymm1, %ymm0
        vbroadcastsd    72(%rsi), %ymm5
        vfmadd213pd     %ymm0, %ymm2, %ymm5     # ymm5 = (ymm2 * ymm5) + ymm0
        vbroadcastsd    80(%rsi), %ymm0
        vfmadd213pd     %ymm5, %ymm3, %ymm0     # ymm0 = (ymm3 * ymm0) + ymm5
        vbroadcastsd    88(%rsi), %ymm5
        vfmadd213pd     %ymm0, %ymm4, %ymm5     # ymm5 = (ymm4 * ymm5) + ymm0
        vmovupd %ymm5, 64(%rdi)
        vbroadcastsd    96(%rsi), %ymm0
        vmulpd  %ymm0, %ymm1, %ymm0
        vbroadcastsd    104(%rsi), %ymm1
        vfmadd213pd     %ymm0, %ymm2, %ymm1     # ymm1 = (ymm2 * ymm1) + ymm0
        vbroadcastsd    112(%rsi), %ymm0
        vfmadd213pd     %ymm1, %ymm3, %ymm0     # ymm0 = (ymm3 * ymm0) + ymm1
        vbroadcastsd    120(%rsi), %ymm1
        vfmadd213pd     %ymm0, %ymm4, %ymm1     # ymm1 = (ymm4 * ymm1) + ymm0
        vmovupd %ymm1, 96(%rdi)
        vzeroupper
        retq
Mat4Mul_F32_V(float*, float*, float*):                # @Mat4Mul_F32_V(float*, float*, float*)
        vbroadcastf128  (%rdx), %ymm0           # ymm0 = mem[0,1,0,1]
        vbroadcastf128  16(%rdx), %ymm1         # ymm1 = mem[0,1,0,1]
        vbroadcastf128  32(%rdx), %ymm2         # ymm2 = mem[0,1,0,1]
        vbroadcastf128  48(%rdx), %ymm3         # ymm3 = mem[0,1,0,1]
        vmovss  16(%rsi), %xmm4                 # xmm4 = mem[0],zero,zero,zero
        vmovss  (%rsi), %xmm5                   # xmm5 = mem[0],zero,zero,zero
        vshufps $0, %xmm4, %xmm5, %xmm4         # xmm4 = xmm5[0,0],xmm4[0,0]
        vmovss  4(%rsi), %xmm5                  # xmm5 = mem[0],zero,zero,zero
        vmovss  8(%rsi), %xmm6                  # xmm6 = mem[0],zero,zero,zero
        vmovss  12(%rsi), %xmm7                 # xmm7 = mem[0],zero,zero,zero
        vpermpd $80, %ymm4, %ymm4               # ymm4 = ymm4[0,0,1,1]
        vmulps  %ymm4, %ymm0, %ymm0
        vmovss  20(%rsi), %xmm4                 # xmm4 = mem[0],zero,zero,zero
        vshufps $0, %xmm4, %xmm5, %xmm4         # xmm4 = xmm5[0,0],xmm4[0,0]
        vpermpd $80, %ymm4, %ymm4               # ymm4 = ymm4[0,0,1,1]
        vfmadd213ps     %ymm0, %ymm1, %ymm4     # ymm4 = (ymm1 * ymm4) + ymm0
        vmovss  24(%rsi), %xmm0                 # xmm0 = mem[0],zero,zero,zero
        vshufps $0, %xmm0, %xmm6, %xmm0         # xmm0 = xmm6[0,0],xmm0[0,0]
        vpermpd $80, %ymm0, %ymm0               # ymm0 = ymm0[0,0,1,1]
        vfmadd213ps     %ymm4, %ymm2, %ymm0     # ymm0 = (ymm2 * ymm0) + ymm4
        vmovss  28(%rsi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
        vshufps $0, %xmm1, %xmm7, %xmm1         # xmm1 = xmm7[0,0],xmm1[0,0]
        vpermpd $80, %ymm1, %ymm1               # ymm1 = ymm1[0,0,1,1]
        vfmadd213ps     %ymm0, %ymm3, %ymm1     # ymm1 = (ymm3 * ymm1) + ymm0
        vbroadcastf128  (%rdx), %ymm0           # ymm0 = mem[0,1,0,1]
        vbroadcastf128  16(%rdx), %ymm2         # ymm2 = mem[0,1,0,1]
        vbroadcastf128  32(%rdx), %ymm3         # ymm3 = mem[0,1,0,1]
        vmovups %ymm1, (%rdi)
        vbroadcastf128  48(%rdx), %ymm1         # ymm1 = mem[0,1,0,1]
        vmovss  48(%rsi), %xmm4                 # xmm4 = mem[0],zero,zero,zero
        vmovss  32(%rsi), %xmm5                 # xmm5 = mem[0],zero,zero,zero
        vshufps $0, %xmm4, %xmm5, %xmm4         # xmm4 = xmm5[0,0],xmm4[0,0]
        vmovss  36(%rsi), %xmm5                 # xmm5 = mem[0],zero,zero,zero
        vmovss  40(%rsi), %xmm6                 # xmm6 = mem[0],zero,zero,zero
        vmovss  44(%rsi), %xmm7                 # xmm7 = mem[0],zero,zero,zero
        vpermpd $80, %ymm4, %ymm4               # ymm4 = ymm4[0,0,1,1]
        vmulps  %ymm4, %ymm0, %ymm0
        vmovss  52(%rsi), %xmm4                 # xmm4 = mem[0],zero,zero,zero
        vshufps $0, %xmm4, %xmm5, %xmm4         # xmm4 = xmm5[0,0],xmm4[0,0]
        vpermpd $80, %ymm4, %ymm4               # ymm4 = ymm4[0,0,1,1]
        vfmadd213ps     %ymm0, %ymm2, %ymm4     # ymm4 = (ymm2 * ymm4) + ymm0
        vmovss  56(%rsi), %xmm0                 # xmm0 = mem[0],zero,zero,zero
        vshufps $0, %xmm0, %xmm6, %xmm0         # xmm0 = xmm6[0,0],xmm0[0,0]
        vpermpd $80, %ymm0, %ymm0               # ymm0 = ymm0[0,0,1,1]
        vfmadd213ps     %ymm4, %ymm3, %ymm0     # ymm0 = (ymm3 * ymm0) + ymm4
        vmovss  60(%rsi), %xmm2                 # xmm2 = mem[0],zero,zero,zero
        vshufps $0, %xmm2, %xmm7, %xmm2         # xmm2 = xmm7[0,0],xmm2[0,0]
        vpermpd $80, %ymm2, %ymm2               # ymm2 = ymm2[0,0,1,1]
        vfmadd213ps     %ymm0, %ymm1, %ymm2     # ymm2 = (ymm1 * ymm2) + ymm0
        vmovups %ymm2, 32(%rdi)
        vzeroupper
        retq
MatMul_F64_V(double*, double*, double*, unsigned long, unsigned long, unsigned long):              # @MatMul_F64_V(double*, double*, double*, unsigned long, unsigned long, unsigned long)
        pushq   %rbp
        pushq   %r15
        pushq   %r14
        pushq   %r13
        pushq   %r12
        pushq   %rbx
        movq    %rdx, -16(%rsp)                 # 8-byte Spill
        movq    %rcx, -8(%rsp)                  # 8-byte Spill
        testq   %rcx, %rcx
        je      .LBB4_13
        testq   %r8, %r8
        je      .LBB4_13
        testq   %r9, %r9
        je      .LBB4_13
        movq    %r9, %r12
        andq    $-16, %r12
        movq    -16(%rsp), %rax                 # 8-byte Reload
        leaq    96(%rax), %rcx
        leaq    (%r16,%r9,8), %r11
        leaq    96(%rdi), %rbx
        xorl    %r14d, %r14d
        jmp     .LBB4_4
.LBB4_12:                               #   in Loop: Header=BB4_4 Depth=1
        addq    $1, %r14
        addq    %r11, %rbx
        addq    %r11, %rdi
        cmpq    -8(%rsp), %r14                  # 8-byte Folded Reload
        je      .LBB4_13
.LBB4_4:                                # =>This Loop Header: Depth=1
        movq    %r14, %r15
        imulq   %r8, %r15
        movq    -16(%rsp), %r13                 # 8-byte Reload
        movq    %rcx, %rax
        xorl    %ebp, %ebp
        jmp     .LBB4_5
.LBB4_11:                               #   in Loop: Header=BB4_5 Depth=2
        addq    $1, %rbp
        addq    %r11, %rax
        addq    %r11, %r13
        cmpq    %r8, %rbp
        je      .LBB4_12
.LBB4_5:                                #   Parent Loop BB4_4 Depth=1
        leaq    (%r15,%rbp), %rdx
        vmovsd  (%rsi,%rdx,8), %xmm0            # xmm0 = mem[0],zero
        cmpq    $16, %r9
        jae     .LBB4_7
        xorl    %edx, %edx
        jmp     .LBB4_10
.LBB4_7:                                #   in Loop: Header=BB4_5 Depth=2
        vbroadcastsd    %xmm0, %ymm1
        xorl    %r10d, %r10d
.LBB4_8:                                #   Parent Loop BB4_4 Depth=1
        vmovupd -96(%rax,%r10,8), %ymm2
        vmovupd -64(%rax,%r10,8), %ymm3
        vmovupd -32(%rax,%r10,8), %ymm4
        vmovupd (%rax,%r10,8), %ymm5
        vfmadd213pd     -96(%rbx,%r10,8), %ymm1, %ymm2 # ymm2 = (ymm1 * ymm2) + mem
        vfmadd213pd     -64(%rbx,%r10,8), %ymm1, %ymm3 # ymm3 = (ymm1 * ymm3) + mem
        vfmadd213pd     -32(%rbx,%r10,8), %ymm1, %ymm4 # ymm4 = (ymm1 * ymm4) + mem
        vfmadd213pd     (%rbx,%r10,8), %ymm1, %ymm5 # ymm5 = (ymm1 * ymm5) + mem
        vmovupd %ymm2, -96(%rbx,%r10,8)
        vmovupd %ymm3, -64(%rbx,%r10,8)
        vmovupd %ymm4, -32(%rbx,%r10,8)
        vmovupd %ymm5, (%rbx,%r10,8)
        addq    $16, %r10
        cmpq    %r10, %r12
        jne     .LBB4_8
        movq    %r12, %rdx
        cmpq    %r9, %r12
        je      .LBB4_11
.LBB4_10:                               #   Parent Loop BB4_4 Depth=1
        vmovsd  (%r13,%rdx,8), %xmm1            # xmm1 = mem[0],zero
        vfmadd213sd     (%rdi,%rdx,8), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
        vmovsd  %xmm1, (%rdi,%rdx,8)
        addq    $1, %rdx
        cmpq    %rdx, %r9
        jne     .LBB4_10
        jmp     .LBB4_11
.LBB4_13:
        popq    %rbx
        popq    %r12
        popq    %r13
        popq    %r14
        popq    %r15
        popq    %rbp
        vzeroupper
        retq
MatMul_F32_V(float*, float*, float*, unsigned long, unsigned long, unsigned long):              # @MatMul_F32_V(float*, float*, float*, unsigned long, unsigned long, unsigned long)
        pushq   %rbp
        pushq   %r15
        pushq   %r14
        pushq   %r13
        pushq   %r12
        pushq   %rbx
        movq    %rdx, -16(%rsp)                 # 8-byte Spill
        movq    %rcx, -8(%rsp)                  # 8-byte Spill
        testq   %rcx, %rcx
        je      .LBB5_13
        testq   %r8, %r8
        je      .LBB5_13
        testq   %r9, %r9
        je      .LBB5_13
        movq    %r9, %r12
        andq    $-32, %r12
        movq    -16(%rsp), %rax                 # 8-byte Reload
        leaq    96(%rax), %rcx
        leaq    (%r16,%r9,4), %r11
        leaq    96(%rdi), %rbx
        xorl    %r14d, %r14d
        jmp     .LBB5_4
.LBB5_12:                               #   in Loop: Header=BB5_4 Depth=1
        addq    $1, %r14
        addq    %r11, %rbx
        addq    %r11, %rdi
        cmpq    -8(%rsp), %r14                  # 8-byte Folded Reload
        je      .LBB5_13
.LBB5_4:                                # =>This Loop Header: Depth=1
        movq    %r14, %r15
        imulq   %r8, %r15
        movq    -16(%rsp), %r13                 # 8-byte Reload
        movq    %rcx, %rax
        xorl    %ebp, %ebp
        jmp     .LBB5_5
.LBB5_11:                               #   in Loop: Header=BB5_5 Depth=2
        addq    $1, %rbp
        addq    %r11, %rax
        addq    %r11, %r13
        cmpq    %r8, %rbp
        je      .LBB5_12
.LBB5_5:                                #   Parent Loop BB5_4 Depth=1
        leaq    (%r15,%rbp), %rdx
        vmovss  (%rsi,%rdx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        cmpq    $32, %r9
        jae     .LBB5_7
        xorl    %edx, %edx
        jmp     .LBB5_10
.LBB5_7:                                #   in Loop: Header=BB5_5 Depth=2
        vbroadcastss    %xmm0, %ymm1
        xorl    %r10d, %r10d
.LBB5_8:                                #   Parent Loop BB5_4 Depth=1
        vmovups -96(%rax,%r10,4), %ymm2
        vmovups -64(%rax,%r10,4), %ymm3
        vmovups -32(%rax,%r10,4), %ymm4
        vmovups (%rax,%r10,4), %ymm5
        vfmadd213ps     -96(%rbx,%r10,4), %ymm1, %ymm2 # ymm2 = (ymm1 * ymm2) + mem
        vfmadd213ps     -64(%rbx,%r10,4), %ymm1, %ymm3 # ymm3 = (ymm1 * ymm3) + mem
        vfmadd213ps     -32(%rbx,%r10,4), %ymm1, %ymm4 # ymm4 = (ymm1 * ymm4) + mem
        vfmadd213ps     (%rbx,%r10,4), %ymm1, %ymm5 # ymm5 = (ymm1 * ymm5) + mem
        vmovups %ymm2, -96(%rbx,%r10,4)
        vmovups %ymm3, -64(%rbx,%r10,4)
        vmovups %ymm4, -32(%rbx,%r10,4)
        vmovups %ymm5, (%rbx,%r10,4)
        addq    $32, %r10
        cmpq    %r10, %r12
        jne     .LBB5_8
        movq    %r12, %rdx
        cmpq    %r9, %r12
        je      .LBB5_11
.LBB5_10:                               #   Parent Loop BB5_4 Depth=1
        vmovss  (%r13,%rdx,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vfmadd213ss     (%rdi,%rdx,4), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
        vmovss  %xmm1, (%rdi,%rdx,4)
        addq    $1, %rdx
        cmpq    %rdx, %r9
        jne     .LBB5_10
        jmp     .LBB5_11
.LBB5_13:
        popq    %rbx
        popq    %r12
        popq    %r13
        popq    %r14
        popq    %r15
        popq    %rbp
        vzeroupper
        retq
MatMulVec_F64_V(double*, double*, double*, unsigned long, unsigned long):            # @MatMulVec_F64_V(double*, double*, double*, unsigned long, unsigned long)
        pushq   %rbx
        testq   %rcx, %rcx
        je      .LBB6_10
        testq   %r8, %r8
        je      .LBB6_10
        movq    %r8, %r9
        andq    $-16, %r9
        leaq    96(%rsi), %rax
        leaq    (%r16,%r8,8), %r10
        xorl    %r11d, %r11d
        jmp     .LBB6_3
.LBB6_9:                                #   in Loop: Header=BB6_3 Depth=1
        vmovsd  %xmm0, (%rdi,%r11,8)
        addq    $1, %r11
        addq    %r10, %rax
        addq    %r10, %rsi
        cmpq    %rcx, %r11
        je      .LBB6_10
.LBB6_3:                                # =>This Loop Header: Depth=1
        vmovq   (%rdi,%r11,8), %xmm0            # xmm0 = mem[0],zero
        cmpq    $16, %r8
        jae     .LBB6_5
        xorl    %ebx, %ebx
        jmp     .LBB6_8
.LBB6_5:                                #   in Loop: Header=BB6_3 Depth=1
        vmovq   %xmm0, %xmm0                    # xmm0 = xmm0[0],zero
        vxorpd  %xmm1, %xmm1, %xmm1
        xorl    %ebx, %ebx
        vxorpd  %xmm2, %xmm2, %xmm2
        vxorpd  %xmm3, %xmm3, %xmm3
.LBB6_6:                                #   Parent Loop BB6_3 Depth=1
        vmovupd (%rdx,%rbx,8), %ymm4
        vmovupd 32(%rdx,%rbx,8), %ymm5
        vmovupd 64(%rdx,%rbx,8), %ymm6
        vmovupd 96(%rdx,%rbx,8), %ymm7
        vfmadd231pd     -96(%rax,%rbx,8), %ymm4, %ymm0 # ymm0 = (ymm4 * mem) + ymm0
        vfmadd231pd     -64(%rax,%rbx,8), %ymm5, %ymm1 # ymm1 = (ymm5 * mem) + ymm1
        vfmadd231pd     -32(%rax,%rbx,8), %ymm6, %ymm2 # ymm2 = (ymm6 * mem) + ymm2
        vfmadd231pd     (%rax,%rbx,8), %ymm7, %ymm3 # ymm3 = (ymm7 * mem) + ymm3
        addq    $16, %rbx
        cmpq    %rbx, %r9
        jne     .LBB6_6
        vaddpd  %ymm0, %ymm1, %ymm0
        vaddpd  %ymm0, %ymm2, %ymm0
        vaddpd  %ymm0, %ymm3, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vaddpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vaddsd  %xmm1, %xmm0, %xmm0
        movq    %r9, %rbx
        cmpq    %r8, %r9
        je      .LBB6_9
.LBB6_8:                                #   Parent Loop BB6_3 Depth=1
        vmovsd  (%rdx,%rbx,8), %xmm1            # xmm1 = mem[0],zero
        vfmadd231sd     (%rsi,%rbx,8), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
        addq    $1, %rbx
        cmpq    %rbx, %r8
        jne     .LBB6_8
        jmp     .LBB6_9
.LBB6_10:
        popq    %rbx
        vzeroupper
        retq
MatMulVec_F32_V(float*, float*, float*, unsigned long, unsigned long):            # @MatMulVec_F32_V(float*, float*, float*, unsigned long, unsigned long)
        pushq   %rbx
        testq   %rcx, %rcx
        je      .LBB7_10
        testq   %r8, %r8
        je      .LBB7_10
        movq    %r8, %r9
        andq    $-32, %r9
        leaq    96(%rsi), %rax
        leaq    (%r16,%r8,4), %r10
        xorl    %r11d, %r11d
        vxorps  %xmm0, %xmm0, %xmm0
        jmp     .LBB7_3
.LBB7_9:                                #   in Loop: Header=BB7_3 Depth=1
        vmovss  %xmm1, (%rdi,%r11,4)
        addq    $1, %r11
        addq    %r10, %rax
        addq    %r10, %rsi
        cmpq    %rcx, %r11
        je      .LBB7_10
.LBB7_3:                                # =>This Loop Header: Depth=1
        vmovss  (%rdi,%r11,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        cmpq    $32, %r8
        jae     .LBB7_5
        xorl    %ebx, %ebx
        jmp     .LBB7_8
.LBB7_5:                                #   in Loop: Header=BB7_3 Depth=1
        vblendps        $1, %xmm1, %xmm0, %xmm1         # xmm1 = xmm1[0],xmm0[1,2,3]
        vxorps  %xmm2, %xmm2, %xmm2
        xorl    %ebx, %ebx
        vxorps  %xmm3, %xmm3, %xmm3
        vxorps  %xmm4, %xmm4, %xmm4
.LBB7_6:                                #   Parent Loop BB7_3 Depth=1
        vmovups (%rdx,%rbx,4), %ymm5
        vmovups 32(%rdx,%rbx,4), %ymm6
        vmovups 64(%rdx,%rbx,4), %ymm7
        vmovups 96(%rdx,%rbx,4), %ymm8
        vfmadd231ps     -96(%rax,%rbx,4), %ymm5, %ymm1 # ymm1 = (ymm5 * mem) + ymm1
        vfmadd231ps     -64(%rax,%rbx,4), %ymm6, %ymm2 # ymm2 = (ymm6 * mem) + ymm2
        vfmadd231ps     -32(%rax,%rbx,4), %ymm7, %ymm3 # ymm3 = (ymm7 * mem) + ymm3
        vfmadd231ps     (%rax,%rbx,4), %ymm8, %ymm4 # ymm4 = (ymm8 * mem) + ymm4
        addq    $32, %rbx
        cmpq    %rbx, %r9
        jne     .LBB7_6
        vaddps  %ymm1, %ymm2, %ymm1
        vaddps  %ymm1, %ymm3, %ymm1
        vaddps  %ymm1, %ymm4, %ymm1
        vextractf128    $1, %ymm1, %xmm2
        vaddps  %xmm2, %xmm1, %xmm1
        vpermilpd       $1, %xmm1, %xmm2        # xmm2 = xmm1[1,0]
        vaddps  %xmm2, %xmm1, %xmm1
        vmovshdup       %xmm1, %xmm2            # xmm2 = xmm1[1,1,3,3]
        vaddss  %xmm2, %xmm1, %xmm1
        movq    %r9, %rbx
        cmpq    %r8, %r9
        je      .LBB7_9
.LBB7_8:                                #   Parent Loop BB7_3 Depth=1
        vmovss  (%rdx,%rbx,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
        vfmadd231ss     (%rsi,%rbx,4), %xmm2, %xmm1 # xmm1 = (xmm2 * mem) + xmm1
        addq    $1, %rbx
        cmpq    %rbx, %r8
        jne     .LBB7_8
        jmp     .LBB7_9
.LBB7_10:
        popq    %rbx
        vzeroupper
        retq
MatMulTiled_F64_V(double*, double*, double*, unsigned long, unsigned long, unsigned long):         # @MatMulTiled_F64_V(double*, double*, double*, unsigned long, unsigned long, unsigned long)
        pushq   %rbp
        pushq   %r15
        pushq   %r14
        pushq   %r13
        pushq   %r12
        pushq   %rbx
        subq    $72, %rsp
        movq    %r9, -128(%rsp)                 # 8-byte Spill
        movq    %r8, -104(%rsp)                 # 8-byte Spill
        movq    %rdx, -88(%rsp)                 # 8-byte Spill
        movq    %rdi, -112(%rsp)                # 8-byte Spill
        movq    %rcx, -64(%rsp)                 # 8-byte Spill
        addq    $7, %rcx
        movq    %rcx, -72(%rsp)                 # 8-byte Spill
        je      .LBB8_21
        movq    -104(%rsp), %rax                # 8-byte Reload
        addq    $255, %rax
        movq    %rax, 8(%rsp)                   # 8-byte Spill
        je      .LBB8_21
        movq    -128(%rsp), %rax                # 8-byte Reload
        addq    $255, %rax
        movq    %rax, -40(%rsp)                 # 8-byte Spill
        je      .LBB8_21
        movq    -88(%rsp), %rax                 # 8-byte Reload
        addq    $96, %rax
        movq    %rax, -48(%rsp)                 # 8-byte Spill
        movq    -128(%rsp), %rax                # 8-byte Reload
        leaq    (%r16,%rax,8), %rbx
        movq    -112(%rsp), %rcx                # 8-byte Reload
        addq    $96, %rcx
        movq    %rcx, -96(%rsp)                 # 8-byte Spill
        shlq    $6, %rax
        movq    %rax, -80(%rsp)                 # 8-byte Spill
        xorl    %edx, %edx
        jmp     .LBB8_4
.LBB8_20:                               #   in Loop: Header=BB8_4 Depth=1
        movq    -80(%rsp), %rax                 # 8-byte Reload
        addq    %rax, -96(%rsp)                 # 8-byte Folded Spill
        addq    %rax, -112(%rsp)                # 8-byte Folded Spill
        movq    -56(%rsp), %rax                 # 8-byte Reload
        movq    %rax, %rdx
        cmpq    -72(%rsp), %rax                 # 8-byte Folded Reload
        jae     .LBB8_21
.LBB8_4:                                # =>This Loop Header: Depth=1
        leaq    8(%rdx), %rax
        movq    -64(%rsp), %rcx                 # 8-byte Reload
        cmpq    %rcx, %rax
        movq    %rax, -56(%rsp)                 # 8-byte Spill
        cmovaq  %rcx, %rax
        cltq
        movq    %rdx, -16(%rsp)                 # 8-byte Spill
        movq    %rax, 24(%rsp)                  # 8-byte Spill
        cmpq    %rax, %rdx
        jae     .LBB8_20
        xorl    %eax, %eax
        movq    %rax, -120(%rsp)                # 8-byte Spill
        movl    $256, %edx                      # imm = 0x100
        xorl    %eax, %eax
        jmp     .LBB8_6
.LBB8_19:                               #   in Loop: Header=BB8_6 Depth=2
        movq    -120(%rsp), %rax                # 8-byte Reload
        addl    $1, %eax
        movq    %rax, -120(%rsp)                # 8-byte Spill
        movq    -24(%rsp), %rdx                 # 8-byte Reload
        addq    $256, %rdx                      # imm = 0x100
        movq    -32(%rsp), %rax                 # 8-byte Reload
        cmpq    -40(%rsp), %rax                 # 8-byte Folded Reload
        jae     .LBB8_20
.LBB8_6:                                #   Parent Loop BB8_4 Depth=1
        movl    %eax, %edi
        movq    -128(%rsp), %rbp                # 8-byte Reload
        cmpq    %rdx, %rbp
        movq    %rdx, -24(%rsp)                 # 8-byte Spill
        cmovbq  %rbp, %rdx
        addq    $256, %rax                      # imm = 0x100
        cmpq    %rax, %rbp
        movq    %rax, %rcx
        cmovbq  %rbp, %rcx
        movq    %rax, -32(%rsp)                 # 8-byte Spill
        cmovbq  %rbp, %rax
        cmpl    %eax, %edi
        jge     .LBB8_19
        movslq  %edi, %r14
        movq    -96(%rsp), %rdi                 # 8-byte Reload
        leaq    (%rdi,%r14,8), %rdi
        movq    %rdi, (%rsp)                    # 8-byte Spill
        movslq  %edx, %r11
        subq    %r14, %r11
        andq    $-16, %r11
        movslq  %ecx, %r12
        movq    -120(%rsp), %rcx                # 8-byte Reload
        shll    $8, %ecx
        movslq  %ecx, %rcx
        subq    %rcx, %r12
        movslq  %eax, %rdx
        movq    %r12, %rcx
        andq    $-16, %rcx
        movq    -48(%rsp), %rax                 # 8-byte Reload
        leaq    (%rax,%r14,8), %rax
        movq    %rax, -8(%rsp)                  # 8-byte Spill
        movq    %r14, %r13
        movq    %rcx, 64(%rsp)                  # 8-byte Spill
        addq    %rcx, %r13
        xorl    %eax, %eax
        jmp     .LBB8_8
.LBB8_18:                               #   in Loop: Header=BB8_8 Depth=3
        movq    16(%rsp), %rax                  # 8-byte Reload
        cmpq    8(%rsp), %rax                   # 8-byte Folded Reload
        jae     .LBB8_19
.LBB8_8:                                #   Parent Loop BB8_4 Depth=1
        movl    %eax, %ecx
        addq    $256, %rax                      # imm = 0x100
        movq    -104(%rsp), %rdi                # 8-byte Reload
        cmpq    %rdi, %rax
        movq    %rax, 16(%rsp)                  # 8-byte Spill
        cmovaq  %rdi, %rax
        cmpl    %eax, %ecx
        jge     .LBB8_18
        movslq  %ecx, %rdi
        movq    -128(%rsp), %rcx                # 8-byte Reload
        movq    %rdi, 48(%rsp)                  # 8-byte Spill
        imulq   %rdi, %rcx
        movq    -88(%rsp), %rdi                 # 8-byte Reload
        leaq    (%rdi,%rcx,8), %rdi
        movq    %rdi, 40(%rsp)                  # 8-byte Spill
        movq    -8(%rsp), %rdi                  # 8-byte Reload
        leaq    (%rdi,%rcx,8), %rcx
        movq    %rcx, 32(%rsp)                  # 8-byte Spill
        cltq
        movq    -112(%rsp), %rcx                # 8-byte Reload
        movq    (%rsp), %r10                    # 8-byte Reload
        movq    -16(%rsp), %r8                  # 8-byte Reload
        jmp     .LBB8_10
.LBB8_17:                               #   in Loop: Header=BB8_10 Depth=4
        movq    56(%rsp), %r8                   # 8-byte Reload
        addq    $1, %r8
        addq    %rbx, %r10
        addq    %rbx, %rcx
        cmpq    24(%rsp), %r8                   # 8-byte Folded Reload
        jae     .LBB8_18
.LBB8_10:                               #   Parent Loop BB8_4 Depth=1
        movq    %r8, 56(%rsp)                   # 8-byte Spill
        imulq   -104(%rsp), %r8                 # 8-byte Folded Reload
        movq    40(%rsp), %r15                  # 8-byte Reload
        movq    32(%rsp), %rdi                  # 8-byte Reload
        movq    48(%rsp), %r9                   # 8-byte Reload
        jmp     .LBB8_11
.LBB8_16:                               #   in Loop: Header=BB8_11 Depth=5
        addq    $1, %r9
        addq    %rbx, %rdi
        addq    %rbx, %r15
        cmpq    %rax, %r9
        jge     .LBB8_17
.LBB8_11:                               #   Parent Loop BB8_4 Depth=1
        leaq    (%r9,%r8), %rbp
        vmovsd  (%rsi,%rbp,8), %xmm0            # xmm0 = mem[0],zero
        movq    %r14, %rbp
        cmpq    $16, %r12
        jb      .LBB8_15
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ebp, %ebp
.LBB8_13:                               #   Parent Loop BB8_4 Depth=1
        vmovupd -96(%rdi,%rbp,8), %ymm2
        vmovupd -64(%rdi,%rbp,8), %ymm3
        vmovupd -32(%rdi,%rbp,8), %ymm4
        vmovupd (%rdi,%rbp,8), %ymm5
        vfmadd213pd     -96(%r10,%rbp,8), %ymm1, %ymm2 # ymm2 = (ymm1 * ymm2) + mem
        vfmadd213pd     -64(%r10,%rbp,8), %ymm1, %ymm3 # ymm3 = (ymm1 * ymm3) + mem
        vfmadd213pd     -32(%r10,%rbp,8), %ymm1, %ymm4 # ymm4 = (ymm1 * ymm4) + mem
        vfmadd213pd     (%r10,%rbp,8), %ymm1, %ymm5 # ymm5 = (ymm1 * ymm5) + mem
        vmovupd %ymm2, -96(%r10,%rbp,8)
        vmovupd %ymm3, -64(%r10,%rbp,8)
        vmovupd %ymm4, -32(%r10,%rbp,8)
        vmovupd %ymm5, (%r10,%rbp,8)
        addq    $16, %rbp
        cmpq    %rbp, %r11
        jne     .LBB8_13
        movq    %r13, %rbp
        cmpq    64(%rsp), %r12                  # 8-byte Folded Reload
        je      .LBB8_16
.LBB8_15:                               #   Parent Loop BB8_4 Depth=1
        vmovsd  (%r15,%rbp,8), %xmm1            # xmm1 = mem[0],zero
        vfmadd213sd     (%rcx,%rbp,8), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
        vmovsd  %xmm1, (%rcx,%rbp,8)
        addq    $1, %rbp
        cmpq    %rdx, %rbp
        jl      .LBB8_15
        jmp     .LBB8_16
.LBB8_21:
        addq    $72, %rsp
        popq    %rbx
        popq    %r12
        popq    %r13
        popq    %r14
        popq    %r15
        popq    %rbp
        vzeroupper
        retq
MatMulTiled_F32_V(float*, float*, float*, unsigned long, unsigned long, unsigned long):         # @MatMulTiled_F32_V(float*, float*, float*, unsigned long, unsigned long, unsigned long)
        pushq   %rbp
        pushq   %r15
        pushq   %r14
        pushq   %r13
        pushq   %r12
        pushq   %rbx
        subq    $72, %rsp
        movq    %r9, -128(%rsp)                 # 8-byte Spill
        movq    %r8, -104(%rsp)                 # 8-byte Spill
        movq    %rdx, -88(%rsp)                 # 8-byte Spill
        movq    %rdi, -112(%rsp)                # 8-byte Spill
        movq    %rcx, -64(%rsp)                 # 8-byte Spill
        addq    $7, %rcx
        movq    %rcx, -72(%rsp)                 # 8-byte Spill
        je      .LBB9_21
        movq    -104(%rsp), %rax                # 8-byte Reload
        addq    $255, %rax
        movq    %rax, 8(%rsp)                   # 8-byte Spill
        je      .LBB9_21
        movq    -128(%rsp), %rax                # 8-byte Reload
        addq    $255, %rax
        movq    %rax, -40(%rsp)                 # 8-byte Spill
        je      .LBB9_21
        movq    -88(%rsp), %rax                 # 8-byte Reload
        addq    $96, %rax
        movq    %rax, -48(%rsp)                 # 8-byte Spill
        movq    -128(%rsp), %rax                # 8-byte Reload
        leaq    (%r16,%rax,4), %rbx
        movq    -112(%rsp), %rcx                # 8-byte Reload
        addq    $96, %rcx
        movq    %rcx, -96(%rsp)                 # 8-byte Spill
        shlq    $5, %rax
        movq    %rax, -80(%rsp)                 # 8-byte Spill
        xorl    %edx, %edx
        jmp     .LBB9_4
.LBB9_20:                               #   in Loop: Header=BB9_4 Depth=1
        movq    -80(%rsp), %rax                 # 8-byte Reload
        addq    %rax, -96(%rsp)                 # 8-byte Folded Spill
        addq    %rax, -112(%rsp)                # 8-byte Folded Spill
        movq    -56(%rsp), %rax                 # 8-byte Reload
        movq    %rax, %rdx
        cmpq    -72(%rsp), %rax                 # 8-byte Folded Reload
        jae     .LBB9_21
.LBB9_4:                                # =>This Loop Header: Depth=1
        leaq    8(%rdx), %rax
        movq    -64(%rsp), %rcx                 # 8-byte Reload
        cmpq    %rcx, %rax
        movq    %rax, -56(%rsp)                 # 8-byte Spill
        cmovaq  %rcx, %rax
        cltq
        movq    %rdx, -16(%rsp)                 # 8-byte Spill
        movq    %rax, 24(%rsp)                  # 8-byte Spill
        cmpq    %rax, %rdx
        jae     .LBB9_20
        xorl    %eax, %eax
        movq    %rax, -120(%rsp)                # 8-byte Spill
        movl    $256, %edx                      # imm = 0x100
        xorl    %eax, %eax
        jmp     .LBB9_6
.LBB9_19:                               #   in Loop: Header=BB9_6 Depth=2
        movq    -120(%rsp), %rax                # 8-byte Reload
        addl    $1, %eax
        movq    %rax, -120(%rsp)                # 8-byte Spill
        movq    -24(%rsp), %rdx                 # 8-byte Reload
        addq    $256, %rdx                      # imm = 0x100
        movq    -32(%rsp), %rax                 # 8-byte Reload
        cmpq    -40(%rsp), %rax                 # 8-byte Folded Reload
        jae     .LBB9_20
.LBB9_6:                                #   Parent Loop BB9_4 Depth=1
        movl    %eax, %edi
        movq    -128(%rsp), %rbp                # 8-byte Reload
        cmpq    %rdx, %rbp
        movq    %rdx, -24(%rsp)                 # 8-byte Spill
        cmovbq  %rbp, %rdx
        addq    $256, %rax                      # imm = 0x100
        cmpq    %rax, %rbp
        movq    %rax, %rcx
        cmovbq  %rbp, %rcx
        movq    %rax, -32(%rsp)                 # 8-byte Spill
        cmovbq  %rbp, %rax
        cmpl    %eax, %edi
        jge     .LBB9_19
        movslq  %edi, %r14
        movq    -96(%rsp), %rdi                 # 8-byte Reload
        leaq    (%rdi,%r14,4), %rdi
        movq    %rdi, (%rsp)                    # 8-byte Spill
        movslq  %edx, %r11
        subq    %r14, %r11
        andq    $-32, %r11
        movslq  %ecx, %r12
        movq    -120(%rsp), %rcx                # 8-byte Reload
        shll    $8, %ecx
        movslq  %ecx, %rcx
        subq    %rcx, %r12
        movslq  %eax, %rdx
        movq    %r12, %rcx
        andq    $-32, %rcx
        movq    -48(%rsp), %rax                 # 8-byte Reload
        leaq    (%rax,%r14,4), %rax
        movq    %rax, -8(%rsp)                  # 8-byte Spill
        movq    %r14, %r13
        movq    %rcx, 64(%rsp)                  # 8-byte Spill
        addq    %rcx, %r13
        xorl    %eax, %eax
        jmp     .LBB9_8
.LBB9_18:                               #   in Loop: Header=BB9_8 Depth=3
        movq    16(%rsp), %rax                  # 8-byte Reload
        cmpq    8(%rsp), %rax                   # 8-byte Folded Reload
        jae     .LBB9_19
.LBB9_8:                                #   Parent Loop BB9_4 Depth=1
        movl    %eax, %ecx
        addq    $256, %rax                      # imm = 0x100
        movq    -104(%rsp), %rdi                # 8-byte Reload
        cmpq    %rdi, %rax
        movq    %rax, 16(%rsp)                  # 8-byte Spill
        cmovaq  %rdi, %rax
        cmpl    %eax, %ecx
        jge     .LBB9_18
        movslq  %ecx, %rdi
        movq    -128(%rsp), %rcx                # 8-byte Reload
        movq    %rdi, 48(%rsp)                  # 8-byte Spill
        imulq   %rdi, %rcx
        movq    -88(%rsp), %rdi                 # 8-byte Reload
        leaq    (%rdi,%rcx,4), %rdi
        movq    %rdi, 40(%rsp)                  # 8-byte Spill
        movq    -8(%rsp), %rdi                  # 8-byte Reload
        leaq    (%rdi,%rcx,4), %rcx
        movq    %rcx, 32(%rsp)                  # 8-byte Spill
        cltq
        movq    -112(%rsp), %rcx                # 8-byte Reload
        movq    (%rsp), %r10                    # 8-byte Reload
        movq    -16(%rsp), %r8                  # 8-byte Reload
        jmp     .LBB9_10
.LBB9_17:                               #   in Loop: Header=BB9_10 Depth=4
        movq    56(%rsp), %r8                   # 8-byte Reload
        addq    $1, %r8
        addq    %rbx, %r10
        addq    %rbx, %rcx
        cmpq    24(%rsp), %r8                   # 8-byte Folded Reload
        jae     .LBB9_18
.LBB9_10:                               #   Parent Loop BB9_4 Depth=1
        movq    %r8, 56(%rsp)                   # 8-byte Spill
        imulq   -104(%rsp), %r8                 # 8-byte Folded Reload
        movq    40(%rsp), %r15                  # 8-byte Reload
        movq    32(%rsp), %rdi                  # 8-byte Reload
        movq    48(%rsp), %r9                   # 8-byte Reload
        jmp     .LBB9_11
.LBB9_16:                               #   in Loop: Header=BB9_11 Depth=5
        addq    $1, %r9
        addq    %rbx, %rdi
        addq    %rbx, %r15
        cmpq    %rax, %r9
        jge     .LBB9_17
.LBB9_11:                               #   Parent Loop BB9_4 Depth=1
        leaq    (%r9,%r8), %rbp
        vmovss  (%rsi,%rbp,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        movq    %r14, %rbp
        cmpq    $32, %r12
        jb      .LBB9_15
        vbroadcastss    %xmm0, %ymm1
        xorl    %ebp, %ebp
.LBB9_13:                               #   Parent Loop BB9_4 Depth=1
        vmovups -96(%rdi,%rbp,4), %ymm2
        vmovups -64(%rdi,%rbp,4), %ymm3
        vmovups -32(%rdi,%rbp,4), %ymm4
        vmovups (%rdi,%rbp,4), %ymm5
        vfmadd213ps     -96(%r10,%rbp,4), %ymm1, %ymm2 # ymm2 = (ymm1 * ymm2) + mem
        vfmadd213ps     -64(%r10,%rbp,4), %ymm1, %ymm3 # ymm3 = (ymm1 * ymm3) + mem
        vfmadd213ps     -32(%r10,%rbp,4), %ymm1, %ymm4 # ymm4 = (ymm1 * ymm4) + mem
        vfmadd213ps     (%r10,%rbp,4), %ymm1, %ymm5 # ymm5 = (ymm1 * ymm5) + mem
        vmovups %ymm2, -96(%r10,%rbp,4)
        vmovups %ymm3, -64(%r10,%rbp,4)
        vmovups %ymm4, -32(%r10,%rbp,4)
        vmovups %ymm5, (%r10,%rbp,4)
        addq    $32, %rbp
        cmpq    %rbp, %r11
        jne     .LBB9_13
        movq    %r13, %rbp
        cmpq    64(%rsp), %r12                  # 8-byte Folded Reload
        je      .LBB9_16
.LBB9_15:                               #   Parent Loop BB9_4 Depth=1
        vmovss  (%r15,%rbp,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        vfmadd213ss     (%rcx,%rbp,4), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
        vmovss  %xmm1, (%rcx,%rbp,4)
        addq    $1, %rbp
        cmpq    %rdx, %rbp
        jl      .LBB9_15
        jmp     .LBB9_16
.LBB9_21:
        addq    $72, %rsp
        popq    %rbx
        popq    %r12
        popq    %r13
        popq    %r14
        popq    %r15
        popq    %rbp
        vzeroupper
        retq