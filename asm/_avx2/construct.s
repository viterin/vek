Repeat_F64_V(double*, double, unsigned long):                   # @Repeat_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB0_12
        cmpq    $16, %rsi
        jae     .LBB0_3
        xorl    %eax, %eax
        jmp     .LBB0_11
.LBB0_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        leaq    -16(%rax), %rcx
        movq    %rcx, %rdx
        shrq    $4, %rdx
        addq    $1, %rdx
        movl    %edx, %r8d
        andl    $3, %r8d
        cmpq    $48, %rcx
        jae     .LBB0_5
        xorl    %ecx, %ecx
        jmp     .LBB0_7
.LBB0_5:
        andq    $-4, %rdx
        xorl    %ecx, %ecx
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
        vmovups %ymm1, (%rdi,%rcx,8)
        vmovups %ymm1, 32(%rdi,%rcx,8)
        vmovups %ymm1, 64(%rdi,%rcx,8)
        vmovups %ymm1, 96(%rdi,%rcx,8)
        vmovups %ymm1, 128(%rdi,%rcx,8)
        vmovups %ymm1, 160(%rdi,%rcx,8)
        vmovups %ymm1, 192(%rdi,%rcx,8)
        vmovups %ymm1, 224(%rdi,%rcx,8)
        vmovups %ymm1, 256(%rdi,%rcx,8)
        vmovups %ymm1, 288(%rdi,%rcx,8)
        vmovups %ymm1, 320(%rdi,%rcx,8)
        vmovups %ymm1, 352(%rdi,%rcx,8)
        vmovups %ymm1, 384(%rdi,%rcx,8)
        vmovups %ymm1, 416(%rdi,%rcx,8)
        vmovups %ymm1, 448(%rdi,%rcx,8)
        vmovups %ymm1, 480(%rdi,%rcx,8)
        addq    $64, %rcx
        addq    $-4, %rdx
        jne     .LBB0_6
.LBB0_7:
        testq   %r8, %r8
        je      .LBB0_10
        leaq    (%rdi,%rcx,8), %rcx
        addq    $96, %rcx
        shlq    $7, %r8
        xorl    %edx, %edx
.LBB0_9:                                # =>This Inner Loop Header: Depth=1
        vmovups %ymm1, -96(%rcx,%rdx)
        vmovups %ymm1, -64(%rcx,%rdx)
        vmovups %ymm1, -32(%rcx,%rdx)
        vmovups %ymm1, (%rcx,%rdx)
        subq    $-128, %rdx
        cmpq    %rdx, %r8
        jne     .LBB0_9
.LBB0_10:
        cmpq    %rsi, %rax
        je      .LBB0_12
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_11
.LBB0_12:
        vzeroupper
        retq
Repeat_F32_V(float*, float, unsigned long):                   # @Repeat_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB1_12
        cmpq    $32, %rsi
        jae     .LBB1_3
        xorl    %eax, %eax
        jmp     .LBB1_11
.LBB1_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        leaq    -32(%rax), %rcx
        movq    %rcx, %rdx
        shrq    $5, %rdx
        addq    $1, %rdx
        movl    %edx, %r8d
        andl    $3, %r8d
        cmpq    $96, %rcx
        jae     .LBB1_5
        xorl    %ecx, %ecx
        jmp     .LBB1_7
.LBB1_5:
        andq    $-4, %rdx
        xorl    %ecx, %ecx
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm1, 64(%rdi,%rcx,4)
        vmovups %ymm1, 96(%rdi,%rcx,4)
        vmovups %ymm1, 128(%rdi,%rcx,4)
        vmovups %ymm1, 160(%rdi,%rcx,4)
        vmovups %ymm1, 192(%rdi,%rcx,4)
        vmovups %ymm1, 224(%rdi,%rcx,4)
        vmovups %ymm1, 256(%rdi,%rcx,4)
        vmovups %ymm1, 288(%rdi,%rcx,4)
        vmovups %ymm1, 320(%rdi,%rcx,4)
        vmovups %ymm1, 352(%rdi,%rcx,4)
        vmovups %ymm1, 384(%rdi,%rcx,4)
        vmovups %ymm1, 416(%rdi,%rcx,4)
        vmovups %ymm1, 448(%rdi,%rcx,4)
        vmovups %ymm1, 480(%rdi,%rcx,4)
        subq    $-128, %rcx
        addq    $-4, %rdx
        jne     .LBB1_6
.LBB1_7:
        testq   %r8, %r8
        je      .LBB1_10
        leaq    (%rdi,%rcx,4), %rcx
        addq    $96, %rcx
        shlq    $7, %r8
        xorl    %edx, %edx
.LBB1_9:                                # =>This Inner Loop Header: Depth=1
        vmovups %ymm1, -96(%rcx,%rdx)
        vmovups %ymm1, -64(%rcx,%rdx)
        vmovups %ymm1, -32(%rcx,%rdx)
        vmovups %ymm1, (%rcx,%rdx)
        subq    $-128, %rdx
        cmpq    %rdx, %r8
        jne     .LBB1_9
.LBB1_10:
        cmpq    %rsi, %rax
        je      .LBB1_12
.LBB1_11:                               # =>This Inner Loop Header: Depth=1
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB1_11
.LBB1_12:
        vzeroupper
        retq
.LCPI2_0:
        .quad   0x0000000000000000              # double 0
        .quad   0x3ff0000000000000              # double 1
        .quad   0x4000000000000000              # double 2
        .quad   0x4008000000000000              # double 3
.LCPI2_1:
        .quad   0x4010000000000000              # double 4
.LCPI2_2:
        .quad   0x4020000000000000              # double 8
.LCPI2_3:
        .quad   0x4028000000000000              # double 12
.LCPI2_4:
        .quad   0x4030000000000000              # double 16
.LCPI2_5:
        .quad   0x4034000000000000              # double 20
.LCPI2_6:
        .quad   0x4038000000000000              # double 24
.LCPI2_7:
        .quad   0x403c000000000000              # double 28
.LCPI2_8:
        .quad   0x4040000000000000              # double 32
.LCPI2_9:
        .quad   0x3ff0000000000000              # double 1
Range_F64_V(double*, double, unsigned long):                    # @Range_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB2_13
        cmpq    $16, %rsi
        jae     .LBB2_3
        xorl    %eax, %eax
        jmp     .LBB2_11
.LBB2_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        vaddpd  .LCPI2_0(%rip), %ymm1, %ymm1
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB2_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
        vbroadcastsd    .LCPI2_1(%rip), %ymm2   # ymm2 = [4.0E+0,4.0E+0,4.0E+0,4.0E+0]
        vbroadcastsd    .LCPI2_2(%rip), %ymm3   # ymm3 = [8.0E+0,8.0E+0,8.0E+0,8.0E+0]
        vbroadcastsd    .LCPI2_3(%rip), %ymm4   # ymm4 = [1.2E+1,1.2E+1,1.2E+1,1.2E+1]
        vbroadcastsd    .LCPI2_4(%rip), %ymm5   # ymm5 = [1.6E+1,1.6E+1,1.6E+1,1.6E+1]
        vbroadcastsd    .LCPI2_5(%rip), %ymm6   # ymm6 = [2.0E+1,2.0E+1,2.0E+1,2.0E+1]
        vbroadcastsd    .LCPI2_6(%rip), %ymm7   # ymm7 = [2.4E+1,2.4E+1,2.4E+1,2.4E+1]
        vbroadcastsd    .LCPI2_7(%rip), %ymm8   # ymm8 = [2.8E+1,2.8E+1,2.8E+1,2.8E+1]
        vbroadcastsd    .LCPI2_8(%rip), %ymm9   # ymm9 = [3.2E+1,3.2E+1,3.2E+1,3.2E+1]
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
        vaddpd  %ymm2, %ymm1, %ymm10
        vaddpd  %ymm3, %ymm1, %ymm11
        vaddpd  %ymm4, %ymm1, %ymm12
        vmovupd %ymm1, (%rdi,%rcx,8)
        vmovupd %ymm10, 32(%rdi,%rcx,8)
        vmovupd %ymm11, 64(%rdi,%rcx,8)
        vmovupd %ymm12, 96(%rdi,%rcx,8)
        vaddpd  %ymm5, %ymm1, %ymm10
        vaddpd  %ymm6, %ymm1, %ymm11
        vaddpd  %ymm7, %ymm1, %ymm12
        vaddpd  %ymm1, %ymm8, %ymm13
        vmovupd %ymm10, 128(%rdi,%rcx,8)
        vmovupd %ymm11, 160(%rdi,%rcx,8)
        vmovupd %ymm12, 192(%rdi,%rcx,8)
        vmovupd %ymm13, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        vaddpd  %ymm1, %ymm9, %ymm1
        addq    $-2, %rdx
        jne     .LBB2_6
        testb   $1, %r8b
        je      .LBB2_9
.LBB2_8:
        vbroadcastsd    .LCPI2_1(%rip), %ymm2   # ymm2 = [4.0E+0,4.0E+0,4.0E+0,4.0E+0]
        vaddpd  %ymm2, %ymm1, %ymm2
        vbroadcastsd    .LCPI2_2(%rip), %ymm3   # ymm3 = [8.0E+0,8.0E+0,8.0E+0,8.0E+0]
        vaddpd  %ymm3, %ymm1, %ymm3
        vbroadcastsd    .LCPI2_3(%rip), %ymm4   # ymm4 = [1.2E+1,1.2E+1,1.2E+1,1.2E+1]
        vaddpd  %ymm4, %ymm1, %ymm4
        vmovupd %ymm1, (%rdi,%rcx,8)
        vmovupd %ymm2, 32(%rdi,%rcx,8)
        vmovupd %ymm3, 64(%rdi,%rcx,8)
        vmovupd %ymm4, 96(%rdi,%rcx,8)
.LBB2_9:
        cmpq    %rsi, %rax
        je      .LBB2_13
        vcvtsi2sd       %rax, %xmm14, %xmm1
        vaddsd  %xmm0, %xmm1, %xmm0
.LBB2_11:
        vmovsd  .LCPI2_9(%rip), %xmm1           # xmm1 = mem[0],zero
.LBB2_12:                               # =>This Inner Loop Header: Depth=1
        vmovsd  %xmm0, (%rdi,%rax,8)
        vaddsd  %xmm1, %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB2_12
.LBB2_13:
        vzeroupper
        retq
.LBB2_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB2_8
        jmp     .LBB2_9
.LCPI3_0:
        .long   0x00000000                      # float 0
        .long   0x3f800000                      # float 1
        .long   0x40000000                      # float 2
        .long   0x40400000                      # float 3
        .long   0x40800000                      # float 4
        .long   0x40a00000                      # float 5
        .long   0x40c00000                      # float 6
        .long   0x40e00000                      # float 7
.LCPI3_1:
        .long   0x41000000                      # float 8
.LCPI3_2:
        .long   0x41800000                      # float 16
.LCPI3_3:
        .long   0x41c00000                      # float 24
.LCPI3_4:
        .long   0x42000000                      # float 32
.LCPI3_5:
        .long   0x42200000                      # float 40
.LCPI3_6:
        .long   0x42400000                      # float 48
.LCPI3_7:
        .long   0x42600000                      # float 56
.LCPI3_8:
        .long   0x42800000                      # float 64
.LCPI3_9:
        .long   0x3f800000                      # float 1
Range_F32_V(float*, float, unsigned long):                    # @Range_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB3_13
        cmpq    $32, %rsi
        jae     .LBB3_3
        xorl    %eax, %eax
        jmp     .LBB3_11
.LBB3_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        vaddps  .LCPI3_0(%rip), %ymm1, %ymm1
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB3_4
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
        vbroadcastss    .LCPI3_1(%rip), %ymm2   # ymm2 = [8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0]
        vbroadcastss    .LCPI3_2(%rip), %ymm3   # ymm3 = [1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1]
        vbroadcastss    .LCPI3_3(%rip), %ymm4   # ymm4 = [2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1]
        vbroadcastss    .LCPI3_4(%rip), %ymm5   # ymm5 = [3.2E+1,3.2E+1,3.2E+1,3.2E+1,3.2E+1,3.2E+1,3.2E+1,3.2E+1]
        vbroadcastss    .LCPI3_5(%rip), %ymm6   # ymm6 = [4.0E+1,4.0E+1,4.0E+1,4.0E+1,4.0E+1,4.0E+1,4.0E+1,4.0E+1]
        vbroadcastss    .LCPI3_6(%rip), %ymm7   # ymm7 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
        vbroadcastss    .LCPI3_7(%rip), %ymm8   # ymm8 = [5.6E+1,5.6E+1,5.6E+1,5.6E+1,5.6E+1,5.6E+1,5.6E+1,5.6E+1]
        vbroadcastss    .LCPI3_8(%rip), %ymm9   # ymm9 = [6.4E+1,6.4E+1,6.4E+1,6.4E+1,6.4E+1,6.4E+1,6.4E+1,6.4E+1]
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
        vaddps  %ymm2, %ymm1, %ymm10
        vaddps  %ymm3, %ymm1, %ymm11
        vaddps  %ymm4, %ymm1, %ymm12
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm10, 32(%rdi,%rcx,4)
        vmovups %ymm11, 64(%rdi,%rcx,4)
        vmovups %ymm12, 96(%rdi,%rcx,4)
        vaddps  %ymm5, %ymm1, %ymm10
        vaddps  %ymm6, %ymm1, %ymm11
        vaddps  %ymm7, %ymm1, %ymm12
        vaddps  %ymm1, %ymm8, %ymm13
        vmovups %ymm10, 128(%rdi,%rcx,4)
        vmovups %ymm11, 160(%rdi,%rcx,4)
        vmovups %ymm12, 192(%rdi,%rcx,4)
        vmovups %ymm13, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        vaddps  %ymm1, %ymm9, %ymm1
        addq    $-2, %rdx
        jne     .LBB3_6
        testb   $1, %r8b
        je      .LBB3_9
.LBB3_8:
        vbroadcastss    .LCPI3_1(%rip), %ymm2   # ymm2 = [8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0,8.0E+0]
        vaddps  %ymm2, %ymm1, %ymm2
        vbroadcastss    .LCPI3_2(%rip), %ymm3   # ymm3 = [1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1,1.6E+1]
        vaddps  %ymm3, %ymm1, %ymm3
        vbroadcastss    .LCPI3_3(%rip), %ymm4   # ymm4 = [2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1,2.4E+1]
        vaddps  %ymm4, %ymm1, %ymm4
        vmovups %ymm1, (%rdi,%rcx,4)
        vmovups %ymm2, 32(%rdi,%rcx,4)
        vmovups %ymm3, 64(%rdi,%rcx,4)
        vmovups %ymm4, 96(%rdi,%rcx,4)
.LBB3_9:
        cmpq    %rsi, %rax
        je      .LBB3_13
        vcvtsi2ss       %rax, %xmm14, %xmm1
        vaddss  %xmm0, %xmm1, %xmm0
.LBB3_11:
        vmovss  .LCPI3_9(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
.LBB3_12:                               # =>This Inner Loop Header: Depth=1
        vmovss  %xmm0, (%rdi,%rax,4)
        vaddss  %xmm1, %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB3_12
.LBB3_13:
        vzeroupper
        retq
.LBB3_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB3_8
        jmp     .LBB3_9
Gather_F64_V(double*, double*, unsigned long*, unsigned long):                # @Gather_F64_V(double*, double*, unsigned long*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB4_7
        cmpq    $16, %rcx
        jae     .LBB4_3
        xorl    %r8d, %r8d
        jmp     .LBB4_6
.LBB4_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %r9d, %r9d
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
        movq    (%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        movq    8(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm0, %xmm0     # xmm0 = xmm0[0,1],mem[0,1]
        movq    16(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm1            # xmm1 = mem[0],zero
        movq    24(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm1, %xmm1     # xmm1 = xmm1[0,1],mem[0,1]
        movq    32(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm2            # xmm2 = mem[0],zero
        movq    40(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm2, %xmm2     # xmm2 = xmm2[0,1],mem[0,1]
        movq    48(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm3            # xmm3 = mem[0],zero
        movq    56(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm3, %xmm3     # xmm3 = xmm3[0,1],mem[0,1]
        movq    64(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm4            # xmm4 = mem[0],zero
        movq    72(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm4, %xmm4     # xmm4 = xmm4[0,1],mem[0,1]
        movq    80(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm5            # xmm5 = mem[0],zero
        movq    88(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm5, %xmm5     # xmm5 = xmm5[0,1],mem[0,1]
        movq    96(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm6            # xmm6 = mem[0],zero
        movq    104(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm6, %xmm6     # xmm6 = xmm6[0,1],mem[0,1]
        movq    112(%rdx,%r9,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm7            # xmm7 = mem[0],zero
        movq    120(%rdx,%r9,8), %rax
        vmovhps (%rsi,%rax,8), %xmm7, %xmm7     # xmm7 = xmm7[0,1],mem[0,1]
        vmovups %xmm1, 16(%rdi,%r9,8)
        vmovups %xmm0, (%rdi,%r9,8)
        vmovups %xmm3, 48(%rdi,%r9,8)
        vmovups %xmm2, 32(%rdi,%r9,8)
        vmovups %xmm5, 80(%rdi,%r9,8)
        vmovups %xmm4, 64(%rdi,%r9,8)
        vmovups %xmm7, 112(%rdi,%r9,8)
        vmovups %xmm6, 96(%rdi,%r9,8)
        addq    $16, %r9
        cmpq    %r9, %r8
        jne     .LBB4_4
        cmpq    %rcx, %r8
        je      .LBB4_7
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
        movq    (%rdx,%r8,8), %rax
        vmovsd  (%rsi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vmovsd  %xmm0, (%rdi,%r8,8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB4_6
.LBB4_7:
        retq
Gather_F32_V(float*, float*, unsigned long*, unsigned long):                # @Gather_F32_V(float*, float*, unsigned long*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB5_7
        cmpq    $16, %rcx
        jae     .LBB5_3
        xorl    %r8d, %r8d
        jmp     .LBB5_6
.LBB5_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %r9d, %r9d
.LBB5_4:                                # =>This Inner Loop Header: Depth=1
        movq    (%rdx,%r9,8), %rax
        vmovss  (%rsi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        movq    8(%rdx,%r9,8), %rax
        vinsertps       $16, (%rsi,%rax,4), %xmm0, %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[2,3]
        movq    16(%rdx,%r9,8), %rax
        vinsertps       $32, (%rsi,%rax,4), %xmm0, %xmm0 # xmm0 = xmm0[0,1],mem[0],xmm0[3]
        movq    24(%rdx,%r9,8), %rax
        vinsertps       $48, (%rsi,%rax,4), %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],mem[0]
        movq    32(%rdx,%r9,8), %rax
        vmovss  (%rsi,%rax,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
        movq    40(%rdx,%r9,8), %rax
        vinsertps       $16, (%rsi,%rax,4), %xmm1, %xmm1 # xmm1 = xmm1[0],mem[0],xmm1[2,3]
        movq    48(%rdx,%r9,8), %rax
        vinsertps       $32, (%rsi,%rax,4), %xmm1, %xmm1 # xmm1 = xmm1[0,1],mem[0],xmm1[3]
        movq    56(%rdx,%r9,8), %rax
        vinsertps       $48, (%rsi,%rax,4), %xmm1, %xmm1 # xmm1 = xmm1[0,1,2],mem[0]
        movq    64(%rdx,%r9,8), %rax
        vmovss  (%rsi,%rax,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
        movq    72(%rdx,%r9,8), %rax
        vinsertps       $16, (%rsi,%rax,4), %xmm2, %xmm2 # xmm2 = xmm2[0],mem[0],xmm2[2,3]
        movq    80(%rdx,%r9,8), %rax
        vinsertps       $32, (%rsi,%rax,4), %xmm2, %xmm2 # xmm2 = xmm2[0,1],mem[0],xmm2[3]
        movq    88(%rdx,%r9,8), %rax
        vinsertps       $48, (%rsi,%rax,4), %xmm2, %xmm2 # xmm2 = xmm2[0,1,2],mem[0]
        movq    96(%rdx,%r9,8), %rax
        vmovss  (%rsi,%rax,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
        movq    104(%rdx,%r9,8), %rax
        vinsertps       $16, (%rsi,%rax,4), %xmm3, %xmm3 # xmm3 = xmm3[0],mem[0],xmm3[2,3]
        movq    112(%rdx,%r9,8), %rax
        vinsertps       $32, (%rsi,%rax,4), %xmm3, %xmm3 # xmm3 = xmm3[0,1],mem[0],xmm3[3]
        movq    120(%rdx,%r9,8), %rax
        vinsertps       $48, (%rsi,%rax,4), %xmm3, %xmm3 # xmm3 = xmm3[0,1,2],mem[0]
        vmovups %xmm0, (%rdi,%r9,4)
        vmovups %xmm1, 16(%rdi,%r9,4)
        vmovups %xmm2, 32(%rdi,%r9,4)
        vmovups %xmm3, 48(%rdi,%r9,4)
        addq    $16, %r9
        cmpq    %r9, %r8
        jne     .LBB5_4
        cmpq    %rcx, %r8
        je      .LBB5_7
.LBB5_6:                                # =>This Inner Loop Header: Depth=1
        movq    (%rdx,%r8,8), %rax
        vmovss  (%rsi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vmovss  %xmm0, (%rdi,%r8,4)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB5_6
.LBB5_7:
        retq
Scatter_F64_V(double*, double*, unsigned long*, unsigned long):               # @Scatter_F64_V(double*, double*, unsigned long*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB6_8
        leaq    -1(%rcx), %rax
        movl    %ecx, %r8d
        andl    $3, %r8d
        cmpq    $3, %rax
        jae     .LBB6_3
        xorl    %r9d, %r9d
        jmp     .LBB6_5
.LBB6_3:
        andq    $-4, %rcx
        xorl    %r9d, %r9d
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r9,8), %xmm0             # xmm0 = mem[0],zero
        movq    (%rdx,%r9,8), %rax
        vmovsd  %xmm0, (%rdi,%rax,8)
        vmovsd  8(%rsi,%r9,8), %xmm0            # xmm0 = mem[0],zero
        movq    8(%rdx,%r9,8), %rax
        vmovsd  %xmm0, (%rdi,%rax,8)
        vmovsd  16(%rsi,%r9,8), %xmm0           # xmm0 = mem[0],zero
        movq    16(%rdx,%r9,8), %rax
        vmovsd  %xmm0, (%rdi,%rax,8)
        vmovsd  24(%rsi,%r9,8), %xmm0           # xmm0 = mem[0],zero
        movq    24(%rdx,%r9,8), %rax
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $4, %r9
        cmpq    %r9, %rcx
        jne     .LBB6_4
.LBB6_5:
        testq   %r8, %r8
        je      .LBB6_8
        leaq    (%rdx,%r9,8), %rcx
        leaq    (%rsi,%r9,8), %rax
        xorl    %edx, %edx
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rax,%rdx,8), %xmm0            # xmm0 = mem[0],zero
        movq    (%rcx,%rdx,8), %rsi
        vmovsd  %xmm0, (%rdi,%rsi,8)
        addq    $1, %rdx
        cmpq    %rdx, %r8
        jne     .LBB6_7
.LBB6_8:
        retq
Scatter_F32_V(float*, float*, unsigned long*, unsigned long):               # @Scatter_F32_V(float*, float*, unsigned long*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB7_8
        leaq    -1(%rcx), %rax
        movl    %ecx, %r8d
        andl    $3, %r8d
        cmpq    $3, %rax
        jae     .LBB7_3
        xorl    %r9d, %r9d
        jmp     .LBB7_5
.LBB7_3:
        andq    $-4, %rcx
        xorl    %r9d, %r9d
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r9,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        movq    (%rdx,%r9,8), %rax
        vmovss  %xmm0, (%rdi,%rax,4)
        vmovss  4(%rsi,%r9,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        movq    8(%rdx,%r9,8), %rax
        vmovss  %xmm0, (%rdi,%rax,4)
        vmovss  8(%rsi,%r9,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        movq    16(%rdx,%r9,8), %rax
        vmovss  %xmm0, (%rdi,%rax,4)
        vmovss  12(%rsi,%r9,4), %xmm0           # xmm0 = mem[0],zero,zero,zero
        movq    24(%rdx,%r9,8), %rax
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $4, %r9
        cmpq    %r9, %rcx
        jne     .LBB7_4
.LBB7_5:
        testq   %r8, %r8
        je      .LBB7_8
        leaq    (%rdx,%r9,8), %rcx
        leaq    (%rsi,%r9,4), %rax
        xorl    %edx, %edx
.LBB7_7:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rax,%rdx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        movq    (%rcx,%rdx,8), %rsi
        vmovss  %xmm0, (%rdi,%rsi,4)
        addq    $1, %rdx
        cmpq    %rdx, %r8
        jne     .LBB7_7
.LBB7_8:
        retq
.LCPI8_0:
        .long   1                               # 0x1
.LCPI8_1:
        .quad   0x3ff0000000000000              # double 1
FromBool_F64_V(double*, bool*, unsigned long):                # @FromBool_F64_V(double*, bool*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB8_10
        cmpq    $16, %rdx
        jae     .LBB8_3
        xorl    %eax, %eax
        jmp     .LBB8_6
.LBB8_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
        vpxor   %xmm0, %xmm0, %xmm0
        vpcmpeqd        %xmm1, %xmm1, %xmm1
        vpbroadcastd    .LCPI8_0(%rip), %xmm2   # xmm2 = [1,1,1,1]
.LBB8_4:                                # =>This Inner Loop Header: Depth=1
        vmovd   (%rsi,%rcx), %xmm3              # xmm3 = mem[0],zero,zero,zero
        vmovd   4(%rsi,%rcx), %xmm4             # xmm4 = mem[0],zero,zero,zero
        vmovd   8(%rsi,%rcx), %xmm5             # xmm5 = mem[0],zero,zero,zero
        vmovd   12(%rsi,%rcx), %xmm6            # xmm6 = mem[0],zero,zero,zero
        vpcmpeqb        %xmm0, %xmm3, %xmm3
        vpxor   %xmm1, %xmm3, %xmm3
        vpmovzxbd       %xmm3, %xmm3            # xmm3 = xmm3[0],zero,zero,zero,xmm3[1],zero,zero,zero,xmm3[2],zero,zero,zero,xmm3[3],zero,zero,zero
        vpand   %xmm2, %xmm3, %xmm3
        vcvtdq2pd       %xmm3, %ymm3
        vpcmpeqb        %xmm0, %xmm4, %xmm4
        vpxor   %xmm1, %xmm4, %xmm4
        vpmovzxbd       %xmm4, %xmm4            # xmm4 = xmm4[0],zero,zero,zero,xmm4[1],zero,zero,zero,xmm4[2],zero,zero,zero,xmm4[3],zero,zero,zero
        vpand   %xmm2, %xmm4, %xmm4
        vcvtdq2pd       %xmm4, %ymm4
        vpcmpeqb        %xmm0, %xmm5, %xmm5
        vpxor   %xmm1, %xmm5, %xmm5
        vpmovzxbd       %xmm5, %xmm5            # xmm5 = xmm5[0],zero,zero,zero,xmm5[1],zero,zero,zero,xmm5[2],zero,zero,zero,xmm5[3],zero,zero,zero
        vpand   %xmm2, %xmm5, %xmm5
        vcvtdq2pd       %xmm5, %ymm5
        vpcmpeqb        %xmm0, %xmm6, %xmm6
        vpxor   %xmm1, %xmm6, %xmm6
        vpmovzxbd       %xmm6, %xmm6            # xmm6 = xmm6[0],zero,zero,zero,xmm6[1],zero,zero,zero,xmm6[2],zero,zero,zero,xmm6[3],zero,zero,zero
        vpand   %xmm2, %xmm6, %xmm6
        vcvtdq2pd       %xmm6, %ymm6
        vmovups %ymm3, (%rdi,%rcx,8)
        vmovups %ymm4, 32(%rdi,%rcx,8)
        vmovups %ymm5, 64(%rdi,%rcx,8)
        vmovups %ymm6, 96(%rdi,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB8_4
        cmpq    %rdx, %rax
        jne     .LBB8_6
.LBB8_10:
        vzeroupper
        retq
.LBB8_6:
        vmovq   .LCPI8_1(%rip), %xmm0           # xmm0 = mem[0],zero
        jmp     .LBB8_7
.LBB8_9:                                #   in Loop: Header=BB8_7 Depth=1
        vmovq   %xmm1, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        je      .LBB8_10
.LBB8_7:                                # =>This Inner Loop Header: Depth=1
        cmpb    $0, (%rsi,%rax)
        vmovdqa %xmm0, %xmm1
        jne     .LBB8_9
        vpxor   %xmm1, %xmm1, %xmm1
        jmp     .LBB8_9
.LCPI9_0:
        .long   1                               # 0x1
.LCPI9_1:
        .long   0x3f800000                      # float 1
FromBool_F32_V(float*, bool*, unsigned long):                # @FromBool_F32_V(float*, bool*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB9_10
        cmpq    $32, %rdx
        jae     .LBB9_3
        xorl    %eax, %eax
        jmp     .LBB9_6
.LBB9_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
        vpxor   %xmm0, %xmm0, %xmm0
        vpcmpeqd        %xmm1, %xmm1, %xmm1
        vpbroadcastd    .LCPI9_0(%rip), %ymm2   # ymm2 = [1,1,1,1,1,1,1,1]
.LBB9_4:                                # =>This Inner Loop Header: Depth=1
        vmovq   (%rsi,%rcx), %xmm3              # xmm3 = mem[0],zero
        vmovq   8(%rsi,%rcx), %xmm4             # xmm4 = mem[0],zero
        vmovq   16(%rsi,%rcx), %xmm5            # xmm5 = mem[0],zero
        vmovq   24(%rsi,%rcx), %xmm6            # xmm6 = mem[0],zero
        vpcmpeqb        %xmm0, %xmm3, %xmm3
        vpxor   %xmm1, %xmm3, %xmm3
        vpmovzxbd       %xmm3, %ymm3            # ymm3 = xmm3[0],zero,zero,zero,xmm3[1],zero,zero,zero,xmm3[2],zero,zero,zero,xmm3[3],zero,zero,zero,xmm3[4],zero,zero,zero,xmm3[5],zero,zero,zero,xmm3[6],zero,zero,zero,xmm3[7],zero,zero,zero
        vpand   %ymm2, %ymm3, %ymm3
        vcvtdq2ps       %ymm3, %ymm3
        vpcmpeqb        %xmm0, %xmm4, %xmm4
        vpxor   %xmm1, %xmm4, %xmm4
        vpmovzxbd       %xmm4, %ymm4            # ymm4 = xmm4[0],zero,zero,zero,xmm4[1],zero,zero,zero,xmm4[2],zero,zero,zero,xmm4[3],zero,zero,zero,xmm4[4],zero,zero,zero,xmm4[5],zero,zero,zero,xmm4[6],zero,zero,zero,xmm4[7],zero,zero,zero
        vpand   %ymm2, %ymm4, %ymm4
        vcvtdq2ps       %ymm4, %ymm4
        vpcmpeqb        %xmm0, %xmm5, %xmm5
        vpxor   %xmm1, %xmm5, %xmm5
        vpmovzxbd       %xmm5, %ymm5            # ymm5 = xmm5[0],zero,zero,zero,xmm5[1],zero,zero,zero,xmm5[2],zero,zero,zero,xmm5[3],zero,zero,zero,xmm5[4],zero,zero,zero,xmm5[5],zero,zero,zero,xmm5[6],zero,zero,zero,xmm5[7],zero,zero,zero
        vpand   %ymm2, %ymm5, %ymm5
        vcvtdq2ps       %ymm5, %ymm5
        vpcmpeqb        %xmm0, %xmm6, %xmm6
        vpxor   %xmm1, %xmm6, %xmm6
        vpmovzxbd       %xmm6, %ymm6            # ymm6 = xmm6[0],zero,zero,zero,xmm6[1],zero,zero,zero,xmm6[2],zero,zero,zero,xmm6[3],zero,zero,zero,xmm6[4],zero,zero,zero,xmm6[5],zero,zero,zero,xmm6[6],zero,zero,zero,xmm6[7],zero,zero,zero
        vpand   %ymm2, %ymm6, %ymm6
        vcvtdq2ps       %ymm6, %ymm6
        vmovups %ymm3, (%rdi,%rcx,4)
        vmovups %ymm4, 32(%rdi,%rcx,4)
        vmovups %ymm5, 64(%rdi,%rcx,4)
        vmovups %ymm6, 96(%rdi,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB9_4
        cmpq    %rdx, %rax
        jne     .LBB9_6
.LBB9_10:
        vzeroupper
        retq
.LBB9_6:
        vmovd   .LCPI9_1(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        jmp     .LBB9_7
.LBB9_9:                                #   in Loop: Header=BB9_7 Depth=1
        vmovd   %xmm1, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        je      .LBB9_10
.LBB9_7:                                # =>This Inner Loop Header: Depth=1
        cmpb    $0, (%rsi,%rax)
        vmovdqa %xmm0, %xmm1
        jne     .LBB9_9
        vpxor   %xmm1, %xmm1, %xmm1
        jmp     .LBB9_9
FromFloat32_F64_V(double*, float*, unsigned long):             # @FromFloat32_F64_V(double*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB10_11
        cmpq    $16, %rdx
        jae     .LBB10_3
        xorl    %eax, %eax
        jmp     .LBB10_10
.LBB10_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB10_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB10_6:                               # =>This Inner Loop Header: Depth=1
        vcvtps2pd       (%rsi,%rcx,4), %ymm0
        vcvtps2pd       16(%rsi,%rcx,4), %ymm1
        vcvtps2pd       32(%rsi,%rcx,4), %ymm2
        vcvtps2pd       48(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,8)
        vmovups %ymm1, 32(%rdi,%rcx,8)
        vmovups %ymm2, 64(%rdi,%rcx,8)
        vmovups %ymm3, 96(%rdi,%rcx,8)
        vcvtps2pd       64(%rsi,%rcx,4), %ymm0
        vcvtps2pd       80(%rsi,%rcx,4), %ymm1
        vcvtps2pd       96(%rsi,%rcx,4), %ymm2
        vcvtps2pd       112(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, 128(%rdi,%rcx,8)
        vmovups %ymm1, 160(%rdi,%rcx,8)
        vmovups %ymm2, 192(%rdi,%rcx,8)
        vmovups %ymm3, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %r9
        jne     .LBB10_6
        testb   $1, %r8b
        je      .LBB10_9
.LBB10_8:
        vcvtps2pd       (%rsi,%rcx,4), %ymm0
        vcvtps2pd       16(%rsi,%rcx,4), %ymm1
        vcvtps2pd       32(%rsi,%rcx,4), %ymm2
        vcvtps2pd       48(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,8)
        vmovups %ymm1, 32(%rdi,%rcx,8)
        vmovups %ymm2, 64(%rdi,%rcx,8)
        vmovups %ymm3, 96(%rdi,%rcx,8)
.LBB10_9:
        cmpq    %rdx, %rax
        je      .LBB10_11
.LBB10_10:                              # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vcvtss2sd       %xmm0, %xmm0, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB10_10
.LBB10_11:
        vzeroupper
        retq
.LBB10_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB10_8
        jmp     .LBB10_9
FromFloat64_F32_V(float*, double*, unsigned long):             # @FromFloat64_F32_V(float*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB11_11
        cmpq    $16, %rdx
        jae     .LBB11_3
        xorl    %eax, %eax
        jmp     .LBB11_10
.LBB11_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB11_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB11_6:                               # =>This Inner Loop Header: Depth=1
        vcvtpd2psy      (%rsi,%rcx,8), %xmm0
        vcvtpd2psy      32(%rsi,%rcx,8), %xmm1
        vcvtpd2psy      64(%rsi,%rcx,8), %xmm2
        vcvtpd2psy      96(%rsi,%rcx,8), %xmm3
        vmovupd %xmm0, (%rdi,%rcx,4)
        vmovupd %xmm1, 16(%rdi,%rcx,4)
        vmovupd %xmm2, 32(%rdi,%rcx,4)
        vmovupd %xmm3, 48(%rdi,%rcx,4)
        vcvtpd2psy      128(%rsi,%rcx,8), %xmm0
        vcvtpd2psy      160(%rsi,%rcx,8), %xmm1
        vcvtpd2psy      192(%rsi,%rcx,8), %xmm2
        vcvtpd2psy      224(%rsi,%rcx,8), %xmm3
        vmovupd %xmm0, 64(%rdi,%rcx,4)
        vmovupd %xmm1, 80(%rdi,%rcx,4)
        vmovupd %xmm2, 96(%rdi,%rcx,4)
        vmovupd %xmm3, 112(%rdi,%rcx,4)
        addq    $32, %rcx
        addq    $-2, %r9
        jne     .LBB11_6
        testb   $1, %r8b
        je      .LBB11_9
.LBB11_8:
        vcvtpd2psy      (%rsi,%rcx,8), %xmm0
        vcvtpd2psy      32(%rsi,%rcx,8), %xmm1
        vcvtpd2psy      64(%rsi,%rcx,8), %xmm2
        vcvtpd2psy      96(%rsi,%rcx,8), %xmm3
        vmovupd %xmm0, (%rdi,%rcx,4)
        vmovupd %xmm1, 16(%rdi,%rcx,4)
        vmovupd %xmm2, 32(%rdi,%rcx,4)
        vmovupd %xmm3, 48(%rdi,%rcx,4)
.LBB11_9:
        cmpq    %rdx, %rax
        je      .LBB11_11
.LBB11_10:                              # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vcvtsd2ss       %xmm0, %xmm0, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB11_10
.LBB11_11:
        retq
.LBB11_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB11_8
        jmp     .LBB11_9
FromInt64_F64_V(double*, long*, unsigned long):               # @FromInt64_F64_V(double*, long*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB12_11
        cmpq    $16, %rdx
        jae     .LBB12_3
        xorl    %r10d, %r10d
        jmp     .LBB12_10
.LBB12_3:
        movq    %rdx, %r10
        andq    $-16, %r10
        leaq    -16(%r10), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB12_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB12_6:                               # =>This Inner Loop Header: Depth=1
        vmovdqu (%rsi,%rcx,8), %xmm0
        vmovdqu 16(%rsi,%rcx,8), %xmm1
        vpextrq $1, %xmm0, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vmovdqu 32(%rsi,%rcx,8), %xmm3
        vmovq   %xmm0, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm0
        vpextrq $1, %xmm1, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovdqu 48(%rsi,%rcx,8), %xmm5
        vmovq   %xmm1, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm1
        vpextrq $1, %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vunpcklpd       %xmm2, %xmm0, %xmm8     # xmm8 = xmm0[0],xmm2[0]
        vmovq   %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vpextrq $1, %xmm3, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vunpcklpd       %xmm4, %xmm1, %xmm10    # xmm10 = xmm1[0],xmm4[0]
        vmovq   %xmm3, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm3
        vunpcklpd       %xmm6, %xmm2, %xmm9     # xmm9 = xmm2[0],xmm6[0]
        vmovdqu 80(%rsi,%rcx,8), %xmm4
        vpextrq $1, %xmm4, %rax
        vunpcklpd       %xmm5, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm5[0]
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vmovq   %xmm4, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vunpcklpd       %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0]
        vmovdqu 64(%rsi,%rcx,8), %xmm5
        vpextrq $1, %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vmovq   %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vmovdqu 112(%rsi,%rcx,8), %xmm7
        vpextrq $1, %xmm7, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm0
        vmovq   %xmm7, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm7
        vmovdqu 96(%rsi,%rcx,8), %xmm2
        vpextrq $1, %xmm2, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm1
        vunpcklpd       %xmm6, %xmm5, %xmm5     # xmm5 = xmm5[0],xmm6[0]
        vmovq   %xmm2, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vunpcklpd       %xmm0, %xmm7, %xmm0     # xmm0 = xmm7[0],xmm0[0]
        vunpcklpd       %xmm1, %xmm2, %xmm1     # xmm1 = xmm2[0],xmm1[0]
        vmovupd %xmm10, 16(%rdi,%rcx,8)
        vmovupd %xmm8, (%rdi,%rcx,8)
        vmovupd %xmm3, 32(%rdi,%rcx,8)
        vmovupd %xmm9, 48(%rdi,%rcx,8)
        vmovupd %xmm5, 64(%rdi,%rcx,8)
        vmovupd %xmm4, 80(%rdi,%rcx,8)
        vmovupd %xmm1, 96(%rdi,%rcx,8)
        vmovupd %xmm0, 112(%rdi,%rcx,8)
        vmovdqu 128(%rsi,%rcx,8), %xmm0
        vmovdqu 144(%rsi,%rcx,8), %xmm1
        vpextrq $1, %xmm0, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vmovdqu 160(%rsi,%rcx,8), %xmm3
        vmovq   %xmm0, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm0
        vpextrq $1, %xmm1, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovdqu 176(%rsi,%rcx,8), %xmm5
        vmovq   %xmm1, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm1
        vpextrq $1, %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vunpcklpd       %xmm2, %xmm0, %xmm8     # xmm8 = xmm0[0],xmm2[0]
        vmovq   %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vpextrq $1, %xmm3, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vunpcklpd       %xmm4, %xmm1, %xmm10    # xmm10 = xmm1[0],xmm4[0]
        vmovq   %xmm3, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm3
        vunpcklpd       %xmm6, %xmm2, %xmm9     # xmm9 = xmm2[0],xmm6[0]
        vmovdqu 208(%rsi,%rcx,8), %xmm4
        vpextrq $1, %xmm4, %rax
        vunpcklpd       %xmm5, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm5[0]
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vmovq   %xmm4, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vunpcklpd       %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0]
        vmovdqu 192(%rsi,%rcx,8), %xmm5
        vpextrq $1, %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vmovq   %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vmovdqu 240(%rsi,%rcx,8), %xmm7
        vpextrq $1, %xmm7, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm0
        vmovq   %xmm7, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm7
        vmovdqu 224(%rsi,%rcx,8), %xmm2
        vpextrq $1, %xmm2, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm1
        vunpcklpd       %xmm6, %xmm5, %xmm5     # xmm5 = xmm5[0],xmm6[0]
        vmovq   %xmm2, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vunpcklpd       %xmm0, %xmm7, %xmm0     # xmm0 = xmm7[0],xmm0[0]
        vunpcklpd       %xmm1, %xmm2, %xmm1     # xmm1 = xmm2[0],xmm1[0]
        vmovupd %xmm10, 144(%rdi,%rcx,8)
        vmovupd %xmm8, 128(%rdi,%rcx,8)
        vmovupd %xmm3, 160(%rdi,%rcx,8)
        vmovupd %xmm9, 176(%rdi,%rcx,8)
        vmovupd %xmm5, 192(%rdi,%rcx,8)
        vmovupd %xmm4, 208(%rdi,%rcx,8)
        vmovupd %xmm1, 224(%rdi,%rcx,8)
        vmovupd %xmm0, 240(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %r9
        jne     .LBB12_6
        testb   $1, %r8b
        je      .LBB12_9
.LBB12_8:
        vmovdqu (%rsi,%rcx,8), %xmm0
        vmovdqu 16(%rsi,%rcx,8), %xmm1
        vmovdqu 32(%rsi,%rcx,8), %xmm3
        vmovdqu 48(%rsi,%rcx,8), %xmm2
        vpextrq $1, %xmm0, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovq   %xmm0, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm0
        vunpcklpd       %xmm4, %xmm0, %xmm8     # xmm8 = xmm0[0],xmm4[0]
        vpextrq $1, %xmm1, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovq   %xmm1, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm1
        vunpcklpd       %xmm4, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm4[0]
        vpextrq $1, %xmm2, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovq   %xmm2, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm2
        vunpcklpd       %xmm4, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm4[0]
        vpextrq $1, %xmm3, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovq   %xmm3, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm3
        vmovdqu 80(%rsi,%rcx,8), %xmm5
        vpextrq $1, %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vmovq   %xmm5, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm5
        vmovdqu 64(%rsi,%rcx,8), %xmm7
        vpextrq $1, %xmm7, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm0
        vunpcklpd       %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0]
        vmovq   %xmm7, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vunpcklpd       %xmm6, %xmm5, %xmm5     # xmm5 = xmm5[0],xmm6[0]
        vmovdqu 112(%rsi,%rcx,8), %xmm6
        vpextrq $1, %xmm6, %rax
        vunpcklpd       %xmm0, %xmm4, %xmm0     # xmm0 = xmm4[0],xmm0[0]
        vcvtsi2sd       %rax, %xmm11, %xmm4
        vmovq   %xmm6, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vunpcklpd       %xmm4, %xmm6, %xmm4     # xmm4 = xmm6[0],xmm4[0]
        vmovdqu 96(%rsi,%rcx,8), %xmm6
        vpextrq $1, %xmm6, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm7
        vmovq   %xmm6, %rax
        vcvtsi2sd       %rax, %xmm11, %xmm6
        vunpcklpd       %xmm7, %xmm6, %xmm6     # xmm6 = xmm6[0],xmm7[0]
        vmovupd %xmm1, 16(%rdi,%rcx,8)
        vmovupd %xmm8, (%rdi,%rcx,8)
        vmovupd %xmm3, 32(%rdi,%rcx,8)
        vmovupd %xmm2, 48(%rdi,%rcx,8)
        vmovupd %xmm0, 64(%rdi,%rcx,8)
        vmovupd %xmm5, 80(%rdi,%rcx,8)
        vmovupd %xmm6, 96(%rdi,%rcx,8)
        vmovupd %xmm4, 112(%rdi,%rcx,8)
.LBB12_9:
        cmpq    %rdx, %r10
        je      .LBB12_11
.LBB12_10:                              # =>This Inner Loop Header: Depth=1
        vcvtsi2sdq      (%rsi,%r10,8), %xmm11, %xmm0
        vmovsd  %xmm0, (%rdi,%r10,8)
        addq    $1, %r10
        cmpq    %r10, %rdx
        jne     .LBB12_10
.LBB12_11:
        retq
.LBB12_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB12_8
        jmp     .LBB12_9
FromInt64_F32_V(float*, long*, unsigned long):               # @FromInt64_F32_V(float*, long*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB13_11
        cmpq    $16, %rdx
        jae     .LBB13_3
        xorl    %r11d, %r11d
        jmp     .LBB13_10
.LBB13_3:
        movq    %rdx, %r11
        andq    $-16, %r11
        leaq    -16(%r11), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB13_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB13_6:                               # =>This Inner Loop Header: Depth=1
        vmovdqu (%rsi,%rcx,8), %xmm0
        vpextrq $1, %xmm0, %r10
        vmovdqu 16(%rsi,%rcx,8), %xmm1
        vcvtsi2ss       %r10, %xmm8, %xmm2
        vmovq   %xmm0, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm0
        vmovq   %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vpextrq $1, %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm1
        vmovdqu 32(%rsi,%rcx,8), %xmm4
        vpextrq $1, %xmm4, %rax
        vmovdqu 48(%rsi,%rcx,8), %xmm5
        vcvtsi2ss       %rax, %xmm8, %xmm6
        vmovq   %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovq   %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm7
        vinsertps       $16, %xmm2, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm2[0],xmm0[2,3]
        vinsertps       $32, %xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0,1],xmm3[0],xmm0[3]
        vpextrq $1, %xmm5, %rax
        vinsertps       $48, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],xmm1[0]
        vcvtsi2ss       %rax, %xmm8, %xmm1
        vinsertps       $16, %xmm6, %xmm4, %xmm2 # xmm2 = xmm4[0],xmm6[0],xmm4[2,3]
        vmovdqu 64(%rsi,%rcx,8), %xmm3
        vpextrq $1, %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovq   %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vmovdqu 80(%rsi,%rcx,8), %xmm5
        vmovq   %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm6
        vinsertps       $32, %xmm7, %xmm2, %xmm2 # xmm2 = xmm2[0,1],xmm7[0],xmm2[3]
        vinsertps       $48, %xmm1, %xmm2, %xmm1 # xmm1 = xmm2[0,1,2],xmm1[0]
        vpextrq $1, %xmm5, %rax
        vinsertps       $16, %xmm4, %xmm3, %xmm2 # xmm2 = xmm3[0],xmm4[0],xmm3[2,3]
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vinsertps       $32, %xmm6, %xmm2, %xmm2 # xmm2 = xmm2[0,1],xmm6[0],xmm2[3]
        vmovdqu 96(%rsi,%rcx,8), %xmm4
        vpextrq $1, %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm5
        vmovq   %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovdqu 112(%rsi,%rcx,8), %xmm6
        vmovq   %xmm6, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm7
        vinsertps       $48, %xmm3, %xmm2, %xmm2 # xmm2 = xmm2[0,1,2],xmm3[0]
        vinsertps       $16, %xmm5, %xmm4, %xmm3 # xmm3 = xmm4[0],xmm5[0],xmm4[2,3]
        vpextrq $1, %xmm6, %rax
        vinsertps       $32, %xmm7, %xmm3, %xmm3 # xmm3 = xmm3[0,1],xmm7[0],xmm3[3]
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vinsertps       $48, %xmm4, %xmm3, %xmm3 # xmm3 = xmm3[0,1,2],xmm4[0]
        vmovups %xmm0, (%rdi,%rcx,4)
        vmovups %xmm1, 16(%rdi,%rcx,4)
        vmovups %xmm2, 32(%rdi,%rcx,4)
        vmovups %xmm3, 48(%rdi,%rcx,4)
        vmovdqu 128(%rsi,%rcx,8), %xmm0
        vpextrq $1, %xmm0, %rax
        vmovdqu 144(%rsi,%rcx,8), %xmm1
        vcvtsi2ss       %rax, %xmm8, %xmm2
        vmovq   %xmm0, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm0
        vmovq   %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vpextrq $1, %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm1
        vmovdqu 160(%rsi,%rcx,8), %xmm4
        vpextrq $1, %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm5
        vmovq   %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vinsertps       $16, %xmm2, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm2[0],xmm0[2,3]
        vmovdqu 176(%rsi,%rcx,8), %xmm2
        vpextrq $1, %xmm2, %r10
        vmovq   %xmm2, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm2
        vinsertps       $32, %xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0,1],xmm3[0],xmm0[3]
        vcvtsi2ss       %r10, %xmm8, %xmm3
        vinsertps       $48, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],xmm1[0]
        vmovdqu 192(%rsi,%rcx,8), %xmm1
        vpextrq $1, %xmm1, %rax
        vinsertps       $16, %xmm5, %xmm4, %xmm4 # xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
        vcvtsi2ss       %rax, %xmm8, %xmm5
        vmovq   %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm1
        vinsertps       $32, %xmm2, %xmm4, %xmm2 # xmm2 = xmm4[0,1],xmm2[0],xmm4[3]
        vmovdqu 208(%rsi,%rcx,8), %xmm4
        vpextrq $1, %xmm4, %r10
        vmovq   %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vinsertps       $48, %xmm3, %xmm2, %xmm2 # xmm2 = xmm2[0,1,2],xmm3[0]
        vcvtsi2ss       %r10, %xmm8, %xmm3
        vinsertps       $16, %xmm5, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm5[0],xmm1[2,3]
        vmovdqu 224(%rsi,%rcx,8), %xmm5
        vpextrq $1, %xmm5, %rax
        vinsertps       $32, %xmm4, %xmm1, %xmm1 # xmm1 = xmm1[0,1],xmm4[0],xmm1[3]
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovq   %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm5
        vinsertps       $48, %xmm3, %xmm1, %xmm1 # xmm1 = xmm1[0,1,2],xmm3[0]
        vmovdqu 240(%rsi,%rcx,8), %xmm3
        vpextrq $1, %xmm3, %r10
        vmovq   %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vinsertps       $16, %xmm4, %xmm5, %xmm4 # xmm4 = xmm5[0],xmm4[0],xmm5[2,3]
        vcvtsi2ss       %r10, %xmm8, %xmm5
        vinsertps       $32, %xmm3, %xmm4, %xmm3 # xmm3 = xmm4[0,1],xmm3[0],xmm4[3]
        vinsertps       $48, %xmm5, %xmm3, %xmm3 # xmm3 = xmm3[0,1,2],xmm5[0]
        vmovups %xmm0, 64(%rdi,%rcx,4)
        vmovups %xmm2, 80(%rdi,%rcx,4)
        vmovups %xmm1, 96(%rdi,%rcx,4)
        vmovups %xmm3, 112(%rdi,%rcx,4)
        addq    $32, %rcx
        addq    $-2, %r9
        jne     .LBB13_6
        testb   $1, %r8b
        je      .LBB13_9
.LBB13_8:
        vmovdqu (%rsi,%rcx,8), %xmm0
        vpextrq $1, %xmm0, %rax
        vmovdqu 16(%rsi,%rcx,8), %xmm1
        vcvtsi2ss       %rax, %xmm8, %xmm2
        vmovq   %xmm0, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm0
        vmovq   %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vpextrq $1, %xmm1, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm1
        vmovdqu 32(%rsi,%rcx,8), %xmm4
        vmovdqu 48(%rsi,%rcx,8), %xmm5
        vpextrq $1, %xmm4, %rax
        vinsertps       $16, %xmm2, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm2[0],xmm0[2,3]
        vcvtsi2ss       %rax, %xmm8, %xmm2
        vmovq   %xmm4, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovq   %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm6
        vinsertps       $32, %xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0,1],xmm3[0],xmm0[3]
        vinsertps       $48, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],xmm1[0]
        vpextrq $1, %xmm5, %rax
        vinsertps       $16, %xmm2, %xmm4, %xmm1 # xmm1 = xmm4[0],xmm2[0],xmm4[2,3]
        vcvtsi2ss       %rax, %xmm8, %xmm2
        vinsertps       $32, %xmm6, %xmm1, %xmm1 # xmm1 = xmm1[0,1],xmm6[0],xmm1[3]
        vmovdqu 64(%rsi,%rcx,8), %xmm3
        vpextrq $1, %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovq   %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vmovdqu 80(%rsi,%rcx,8), %xmm5
        vmovq   %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm6
        vinsertps       $48, %xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0,1,2],xmm2[0]
        vinsertps       $16, %xmm4, %xmm3, %xmm2 # xmm2 = xmm3[0],xmm4[0],xmm3[2,3]
        vpextrq $1, %xmm5, %rax
        vinsertps       $32, %xmm6, %xmm2, %xmm2 # xmm2 = xmm2[0,1],xmm6[0],xmm2[3]
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vinsertps       $48, %xmm3, %xmm2, %xmm2 # xmm2 = xmm2[0,1,2],xmm3[0]
        vmovdqu 96(%rsi,%rcx,8), %xmm3
        vpextrq $1, %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vmovq   %xmm3, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm3
        vmovdqu 112(%rsi,%rcx,8), %xmm5
        vmovq   %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm6
        vinsertps       $16, %xmm4, %xmm3, %xmm3 # xmm3 = xmm3[0],xmm4[0],xmm3[2,3]
        vinsertps       $32, %xmm6, %xmm3, %xmm3 # xmm3 = xmm3[0,1],xmm6[0],xmm3[3]
        vpextrq $1, %xmm5, %rax
        vcvtsi2ss       %rax, %xmm8, %xmm4
        vinsertps       $48, %xmm4, %xmm3, %xmm3 # xmm3 = xmm3[0,1,2],xmm4[0]
        vmovups %xmm0, (%rdi,%rcx,4)
        vmovups %xmm1, 16(%rdi,%rcx,4)
        vmovups %xmm2, 32(%rdi,%rcx,4)
        vmovups %xmm3, 48(%rdi,%rcx,4)
.LBB13_9:
        cmpq    %rdx, %r11
        je      .LBB13_11
.LBB13_10:                              # =>This Inner Loop Header: Depth=1
        vcvtsi2ssq      (%rsi,%r11,8), %xmm8, %xmm0
        vmovss  %xmm0, (%rdi,%r11,4)
        addq    $1, %r11
        cmpq    %r11, %rdx
        jne     .LBB13_10
.LBB13_11:
        retq
.LBB13_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB13_8
        jmp     .LBB13_9
FromInt32_F64_V(double*, int*, unsigned long):               # @FromInt32_F64_V(double*, int*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB14_11
        cmpq    $16, %rdx
        jae     .LBB14_3
        xorl    %eax, %eax
        jmp     .LBB14_10
.LBB14_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB14_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB14_6:                               # =>This Inner Loop Header: Depth=1
        vcvtdq2pd       (%rsi,%rcx,4), %ymm0
        vcvtdq2pd       16(%rsi,%rcx,4), %ymm1
        vcvtdq2pd       32(%rsi,%rcx,4), %ymm2
        vcvtdq2pd       48(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,8)
        vmovups %ymm1, 32(%rdi,%rcx,8)
        vmovups %ymm2, 64(%rdi,%rcx,8)
        vmovups %ymm3, 96(%rdi,%rcx,8)
        vcvtdq2pd       64(%rsi,%rcx,4), %ymm0
        vcvtdq2pd       80(%rsi,%rcx,4), %ymm1
        vcvtdq2pd       96(%rsi,%rcx,4), %ymm2
        vcvtdq2pd       112(%rsi,%rcx,4), %ymm3
        vmovupd %ymm0, 128(%rdi,%rcx,8)
        vmovups %ymm1, 160(%rdi,%rcx,8)
        vmovups %ymm2, 192(%rdi,%rcx,8)
        vmovups %ymm3, 224(%rdi,%rcx,8)
        addq    $32, %rcx
        addq    $-2, %r9
        jne     .LBB14_6
        testb   $1, %r8b
        je      .LBB14_9
.LBB14_8:
        vcvtdq2pd       (%rsi,%rcx,4), %ymm0
        vcvtdq2pd       16(%rsi,%rcx,4), %ymm1
        vcvtdq2pd       32(%rsi,%rcx,4), %ymm2
        vcvtdq2pd       48(%rsi,%rcx,4), %ymm3
        vmovupd %ymm0, (%rdi,%rcx,8)
        vmovups %ymm1, 32(%rdi,%rcx,8)
        vmovups %ymm2, 64(%rdi,%rcx,8)
        vmovups %ymm3, 96(%rdi,%rcx,8)
.LBB14_9:
        cmpq    %rdx, %rax
        je      .LBB14_11
.LBB14_10:                              # =>This Inner Loop Header: Depth=1
        vcvtsi2sdl      (%rsi,%rax,4), %xmm4, %xmm0
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB14_10
.LBB14_11:
        vzeroupper
        retq
.LBB14_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB14_8
        jmp     .LBB14_9
FromInt32_F32_V(float*, int*, unsigned long):               # @FromInt32_F32_V(float*, int*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB15_11
        cmpq    $32, %rdx
        jae     .LBB15_3
        xorl    %eax, %eax
        jmp     .LBB15_10
.LBB15_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB15_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB15_6:                               # =>This Inner Loop Header: Depth=1
        vcvtdq2ps       (%rsi,%rcx,4), %ymm0
        vcvtdq2ps       32(%rsi,%rcx,4), %ymm1
        vcvtdq2ps       64(%rsi,%rcx,4), %ymm2
        vcvtdq2ps       96(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        vcvtdq2ps       128(%rsi,%rcx,4), %ymm0
        vcvtdq2ps       160(%rsi,%rcx,4), %ymm1
        vcvtdq2ps       192(%rsi,%rcx,4), %ymm2
        vcvtdq2ps       224(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, 128(%rdi,%rcx,4)
        vmovups %ymm1, 160(%rdi,%rcx,4)
        vmovups %ymm2, 192(%rdi,%rcx,4)
        vmovups %ymm3, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %r9
        jne     .LBB15_6
        testb   $1, %r8b
        je      .LBB15_9
.LBB15_8:
        vcvtdq2ps       (%rsi,%rcx,4), %ymm0
        vcvtdq2ps       32(%rsi,%rcx,4), %ymm1
        vcvtdq2ps       64(%rsi,%rcx,4), %ymm2
        vcvtdq2ps       96(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
.LBB15_9:
        cmpq    %rdx, %rax
        je      .LBB15_11
.LBB15_10:                              # =>This Inner Loop Header: Depth=1
        vcvtsi2ssl      (%rsi,%rax,4), %xmm4, %xmm0
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB15_10
.LBB15_11:
        vzeroupper
        retq
.LBB15_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB15_8
        jmp     .LBB15_9
.LCPI16_0:
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
ToBool_F64_V(bool*, double*, unsigned long):                  # @ToBool_F64_V(bool*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB16_8
        cmpq    $16, %rdx
        jae     .LBB16_3
        xorl    %eax, %eax
        jmp     .LBB16_6
.LBB16_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        xorl    %ecx, %ecx
        vxorpd  %xmm0, %xmm0, %xmm0
        vmovdqa .LCPI16_0(%rip), %xmm1          # xmm1 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB16_4:                               # =>This Inner Loop Header: Depth=1
        vcmpneqpd       (%rsi,%rcx,8), %ymm0, %ymm2
        vextractf128    $1, %ymm2, %xmm3
        vpackssdw       %xmm3, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vcmpneqpd       32(%rsi,%rcx,8), %ymm0, %ymm3
        vpand   %xmm1, %xmm2, %xmm2
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm1, %xmm3, %xmm3
        vcmpneqpd       64(%rsi,%rcx,8), %ymm0, %ymm4
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vextractf128    $1, %ymm4, %xmm3
        vpackssdw       %xmm3, %xmm4, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm1, %xmm3, %xmm3
        vcmpneqpd       96(%rsi,%rcx,8), %ymm0, %ymm4
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm1, %xmm4, %xmm4
        vpbroadcastd    %xmm4, %xmm4
        vpbroadcastd    %xmm3, %xmm3
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vpblendd        $12, %xmm3, %xmm2, %xmm2        # xmm2 = xmm2[0,1],xmm3[2,3]
        vmovdqu %xmm2, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB16_4
        cmpq    %rdx, %rax
        je      .LBB16_8
.LBB16_6:
        vxorpd  %xmm0, %xmm0, %xmm0
.LBB16_7:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        setne   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB16_7
.LBB16_8:
        vzeroupper
        retq
.LCPI17_0:
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .byte   1                               # 0x1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
        .zero   1
ToBool_F32_V(bool*, float*, unsigned long):                  # @ToBool_F32_V(bool*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB17_8
        cmpq    $32, %rdx
        jae     .LBB17_3
        xorl    %eax, %eax
        jmp     .LBB17_6
.LBB17_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        xorl    %ecx, %ecx
        vxorps  %xmm0, %xmm0, %xmm0
        vmovdqa .LCPI17_0(%rip), %xmm1          # xmm1 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB17_4:                               # =>This Inner Loop Header: Depth=1
        vcmpneqps       (%rsi,%rcx,4), %ymm0, %ymm2
        vextractf128    $1, %ymm2, %xmm3
        vpackssdw       %xmm3, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vcmpneqps       32(%rsi,%rcx,4), %ymm0, %ymm3
        vpand   %xmm1, %xmm2, %xmm2
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm1, %xmm3, %xmm3
        vcmpneqps       64(%rsi,%rcx,4), %ymm0, %ymm4
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vcmpneqps       96(%rsi,%rcx,4), %ymm0, %ymm5
        vpand   %xmm1, %xmm4, %xmm4
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm1, %xmm5, %xmm5
        vinserti128     $1, %xmm5, %ymm4, %ymm4
        vinserti128     $1, %xmm3, %ymm2, %ymm2
        vpunpcklqdq     %ymm4, %ymm2, %ymm2     # ymm2 = ymm2[0],ymm4[0],ymm2[2],ymm4[2]
        vpermq  $216, %ymm2, %ymm2              # ymm2 = ymm2[0,2,1,3]
        vmovdqu %ymm2, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB17_4
        cmpq    %rdx, %rax
        je      .LBB17_8
.LBB17_6:
        vxorps  %xmm0, %xmm0, %xmm0
.LBB17_7:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        setne   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB17_7
.LBB17_8:
        vzeroupper
        retq
ToInt64_F64_V(long*, double*, unsigned long):                 # @ToInt64_F64_V(long*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB18_8
        leaq    -1(%rdx), %rcx
        movl    %edx, %r8d
        andl    $3, %r8d
        cmpq    $3, %rcx
        jae     .LBB18_3
        xorl    %ecx, %ecx
        jmp     .LBB18_5
.LBB18_3:
        andq    $-4, %rdx
        xorl    %ecx, %ecx
.LBB18_4:                               # =>This Inner Loop Header: Depth=1
        vcvttsd2si      (%rsi,%rcx,8), %rax
        movq    %rax, (%rdi,%rcx,8)
        vcvttsd2si      8(%rsi,%rcx,8), %rax
        movq    %rax, 8(%rdi,%rcx,8)
        vcvttsd2si      16(%rsi,%rcx,8), %rax
        movq    %rax, 16(%rdi,%rcx,8)
        vcvttsd2si      24(%rsi,%rcx,8), %rax
        movq    %rax, 24(%rdi,%rcx,8)
        addq    $4, %rcx
        cmpq    %rcx, %rdx
        jne     .LBB18_4
.LBB18_5:
        testq   %r8, %r8
        je      .LBB18_8
        leaq    (%rdi,%rcx,8), %rdx
        leaq    (%rsi,%rcx,8), %rcx
        xorl    %esi, %esi
.LBB18_7:                               # =>This Inner Loop Header: Depth=1
        vcvttsd2si      (%rcx,%rsi,8), %rax
        movq    %rax, (%rdx,%rsi,8)
        addq    $1, %rsi
        cmpq    %rsi, %r8
        jne     .LBB18_7
.LBB18_8:
        retq
ToInt64_F32_V(long*, float*, unsigned long):                 # @ToInt64_F32_V(long*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB19_8
        leaq    -1(%rdx), %rcx
        movl    %edx, %r8d
        andl    $3, %r8d
        cmpq    $3, %rcx
        jae     .LBB19_3
        xorl    %ecx, %ecx
        jmp     .LBB19_5
.LBB19_3:
        andq    $-4, %rdx
        xorl    %ecx, %ecx
.LBB19_4:                               # =>This Inner Loop Header: Depth=1
        vcvttss2si      (%rsi,%rcx,4), %rax
        movq    %rax, (%rdi,%rcx,8)
        vcvttss2si      4(%rsi,%rcx,4), %rax
        movq    %rax, 8(%rdi,%rcx,8)
        vcvttss2si      8(%rsi,%rcx,4), %rax
        movq    %rax, 16(%rdi,%rcx,8)
        vcvttss2si      12(%rsi,%rcx,4), %rax
        movq    %rax, 24(%rdi,%rcx,8)
        addq    $4, %rcx
        cmpq    %rcx, %rdx
        jne     .LBB19_4
.LBB19_5:
        testq   %r8, %r8
        je      .LBB19_8
        leaq    (%rdi,%rcx,8), %rdx
        leaq    (%rsi,%rcx,4), %rcx
        xorl    %esi, %esi
.LBB19_7:                               # =>This Inner Loop Header: Depth=1
        vcvttss2si      (%rcx,%rsi,4), %rax
        movq    %rax, (%rdx,%rsi,8)
        addq    $1, %rsi
        cmpq    %rsi, %r8
        jne     .LBB19_7
.LBB19_8:
        retq
ToInt32_F64_V(int*, double*, unsigned long):                 # @ToInt32_F64_V(int*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB20_11
        cmpq    $16, %rdx
        jae     .LBB20_3
        xorl    %eax, %eax
        jmp     .LBB20_10
.LBB20_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        leaq    -16(%rax), %rcx
        movq    %rcx, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB20_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB20_6:                               # =>This Inner Loop Header: Depth=1
        vcvttpd2dqy     (%rsi,%rcx,8), %xmm0
        vcvttpd2dqy     32(%rsi,%rcx,8), %xmm1
        vcvttpd2dqy     64(%rsi,%rcx,8), %xmm2
        vcvttpd2dqy     96(%rsi,%rcx,8), %xmm3
        vmovupd %xmm0, (%rdi,%rcx,4)
        vmovupd %xmm1, 16(%rdi,%rcx,4)
        vmovupd %xmm2, 32(%rdi,%rcx,4)
        vmovupd %xmm3, 48(%rdi,%rcx,4)
        vcvttpd2dqy     128(%rsi,%rcx,8), %xmm0
        vcvttpd2dqy     160(%rsi,%rcx,8), %xmm1
        vcvttpd2dqy     192(%rsi,%rcx,8), %xmm2
        vcvttpd2dqy     224(%rsi,%rcx,8), %xmm3
        vmovupd %xmm0, 64(%rdi,%rcx,4)
        vmovupd %xmm1, 80(%rdi,%rcx,4)
        vmovupd %xmm2, 96(%rdi,%rcx,4)
        vmovupd %xmm3, 112(%rdi,%rcx,4)
        addq    $32, %rcx
        addq    $-2, %r9
        jne     .LBB20_6
        testb   $1, %r8b
        je      .LBB20_9
.LBB20_8:
        vcvttpd2dqy     (%rsi,%rcx,8), %xmm0
        vcvttpd2dqy     32(%rsi,%rcx,8), %xmm1
        vcvttpd2dqy     64(%rsi,%rcx,8), %xmm2
        vcvttpd2dqy     96(%rsi,%rcx,8), %xmm3
        vmovupd %xmm0, (%rdi,%rcx,4)
        vmovupd %xmm1, 16(%rdi,%rcx,4)
        vmovupd %xmm2, 32(%rdi,%rcx,4)
        vmovupd %xmm3, 48(%rdi,%rcx,4)
.LBB20_9:
        cmpq    %rdx, %rax
        je      .LBB20_11
.LBB20_10:                              # =>This Inner Loop Header: Depth=1
        vcvttsd2si      (%rsi,%rax,8), %ecx
        movl    %ecx, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB20_10
.LBB20_11:
        retq
.LBB20_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB20_8
        jmp     .LBB20_9
ToInt32_F32_V(int*, float*, unsigned long):                 # @ToInt32_F32_V(int*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB21_11
        cmpq    $32, %rdx
        jae     .LBB21_3
        xorl    %eax, %eax
        jmp     .LBB21_10
.LBB21_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        leaq    -32(%rax), %rcx
        movq    %rcx, %r8
        shrq    $5, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB21_4
        movq    %r8, %r9
        andq    $-2, %r9
        xorl    %ecx, %ecx
.LBB21_6:                               # =>This Inner Loop Header: Depth=1
        vcvttps2dq      (%rsi,%rcx,4), %ymm0
        vcvttps2dq      32(%rsi,%rcx,4), %ymm1
        vcvttps2dq      64(%rsi,%rcx,4), %ymm2
        vcvttps2dq      96(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
        vcvttps2dq      128(%rsi,%rcx,4), %ymm0
        vcvttps2dq      160(%rsi,%rcx,4), %ymm1
        vcvttps2dq      192(%rsi,%rcx,4), %ymm2
        vcvttps2dq      224(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, 128(%rdi,%rcx,4)
        vmovups %ymm1, 160(%rdi,%rcx,4)
        vmovups %ymm2, 192(%rdi,%rcx,4)
        vmovups %ymm3, 224(%rdi,%rcx,4)
        addq    $64, %rcx
        addq    $-2, %r9
        jne     .LBB21_6
        testb   $1, %r8b
        je      .LBB21_9
.LBB21_8:
        vcvttps2dq      (%rsi,%rcx,4), %ymm0
        vcvttps2dq      32(%rsi,%rcx,4), %ymm1
        vcvttps2dq      64(%rsi,%rcx,4), %ymm2
        vcvttps2dq      96(%rsi,%rcx,4), %ymm3
        vmovups %ymm0, (%rdi,%rcx,4)
        vmovups %ymm1, 32(%rdi,%rcx,4)
        vmovups %ymm2, 64(%rdi,%rcx,4)
        vmovups %ymm3, 96(%rdi,%rcx,4)
.LBB21_9:
        cmpq    %rdx, %rax
        je      .LBB21_11
.LBB21_10:                              # =>This Inner Loop Header: Depth=1
        vcvttss2si      (%rsi,%rax,4), %ecx
        movl    %ecx, (%rdi,%rax,4)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB21_10
.LBB21_11:
        vzeroupper
        retq
.LBB21_4:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB21_8
        jmp     .LBB21_9