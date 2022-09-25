.LCPI0_0:
        .zero   32,1
.LCPI0_1:
        .zero   16,1
Not_V(bool*, unsigned long):                            # @Not_V(bool*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB0_17
        cmpq    $16, %rsi
        jae     .LBB0_3
        xorl    %eax, %eax
        jmp     .LBB0_16
.LBB0_3:
        cmpq    $128, %rsi
        jae     .LBB0_5
        xorl    %eax, %eax
        jmp     .LBB0_13
.LBB0_5:
        movq    %rsi, %rax
        andq    $-128, %rax
        leaq    -128(%rax), %rcx
        movq    %rcx, %r8
        shrq    $7, %r8
        addq    $1, %r8
        testq   %rcx, %rcx
        je      .LBB0_6
        movq    %r8, %rdx
        andq    $-2, %rdx
        xorl    %ecx, %ecx
        vmovaps .LCPI0_0(%rip), %ymm0           # ymm0 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
        vxorps  (%rdi,%rcx), %ymm0, %ymm1
        vxorps  32(%rdi,%rcx), %ymm0, %ymm2
        vxorps  64(%rdi,%rcx), %ymm0, %ymm3
        vxorps  96(%rdi,%rcx), %ymm0, %ymm4
        vmovups %ymm1, (%rdi,%rcx)
        vmovups %ymm2, 32(%rdi,%rcx)
        vmovups %ymm3, 64(%rdi,%rcx)
        vmovups %ymm4, 96(%rdi,%rcx)
        vxorps  128(%rdi,%rcx), %ymm0, %ymm1
        vxorps  160(%rdi,%rcx), %ymm0, %ymm2
        vxorps  192(%rdi,%rcx), %ymm0, %ymm3
        vxorps  224(%rdi,%rcx), %ymm0, %ymm4
        vmovups %ymm1, 128(%rdi,%rcx)
        vmovups %ymm2, 160(%rdi,%rcx)
        vmovups %ymm3, 192(%rdi,%rcx)
        vmovups %ymm4, 224(%rdi,%rcx)
        addq    $256, %rcx                      # imm = 0x100
        addq    $-2, %rdx
        jne     .LBB0_8
        testb   $1, %r8b
        je      .LBB0_11
.LBB0_10:
        vmovaps .LCPI0_0(%rip), %ymm0           # ymm0 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        vxorps  (%rdi,%rcx), %ymm0, %ymm1
        vxorps  32(%rdi,%rcx), %ymm0, %ymm2
        vxorps  64(%rdi,%rcx), %ymm0, %ymm3
        vxorps  96(%rdi,%rcx), %ymm0, %ymm0
        vmovups %ymm1, (%rdi,%rcx)
        vmovups %ymm2, 32(%rdi,%rcx)
        vmovups %ymm3, 64(%rdi,%rcx)
        vmovups %ymm0, 96(%rdi,%rcx)
.LBB0_11:
        cmpq    %rsi, %rax
        je      .LBB0_17
        testb   $112, %sil
        je      .LBB0_16
.LBB0_13:
        movq    %rax, %rcx
        movq    %rsi, %rax
        andq    $-16, %rax
        vmovaps .LCPI0_1(%rip), %xmm0           # xmm0 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
.LBB0_14:                               # =>This Inner Loop Header: Depth=1
        vxorps  (%rdi,%rcx), %xmm0, %xmm1
        vmovups %xmm1, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB0_14
        cmpq    %rsi, %rax
        je      .LBB0_17
.LBB0_16:                               # =>This Inner Loop Header: Depth=1
        xorb    $1, (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_16
.LBB0_17:
        vzeroupper
        retq
.LBB0_6:
        xorl    %ecx, %ecx
        testb   $1, %r8b
        jne     .LBB0_10
        jmp     .LBB0_11
And_V(bool*, bool*, unsigned long):                          # @And_V(bool*, bool*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB1_13
        cmpq    $16, %rdx
        jae     .LBB1_3
        xorl    %eax, %eax
        jmp     .LBB1_12
.LBB1_3:
        cmpq    $128, %rdx
        jae     .LBB1_5
        xorl    %eax, %eax
        jmp     .LBB1_9
.LBB1_5:
        movq    %rdx, %rax
        andq    $-128, %rax
        xorl    %ecx, %ecx
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx), %ymm0
        vmovups 32(%rsi,%rcx), %ymm1
        vmovups 64(%rsi,%rcx), %ymm2
        vmovups 96(%rsi,%rcx), %ymm3
        vandps  (%rdi,%rcx), %ymm0, %ymm0
        vandps  32(%rdi,%rcx), %ymm1, %ymm1
        vandps  64(%rdi,%rcx), %ymm2, %ymm2
        vandps  96(%rdi,%rcx), %ymm3, %ymm3
        vmovups %ymm0, (%rdi,%rcx)
        vmovups %ymm1, 32(%rdi,%rcx)
        vmovups %ymm2, 64(%rdi,%rcx)
        vmovups %ymm3, 96(%rdi,%rcx)
        subq    $-128, %rcx
        cmpq    %rcx, %rax
        jne     .LBB1_6
        cmpq    %rdx, %rax
        je      .LBB1_13
        testb   $112, %dl
        je      .LBB1_12
.LBB1_9:
        movq    %rax, %rcx
        movq    %rdx, %rax
        andq    $-16, %rax
.LBB1_10:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx), %xmm0
        vandps  (%rdi,%rcx), %xmm0, %xmm0
        vmovups %xmm0, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB1_10
        cmpq    %rdx, %rax
        je      .LBB1_13
.LBB1_12:                               # =>This Inner Loop Header: Depth=1
        movzbl  (%rsi,%rax), %ecx
        andb    %cl, (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB1_12
.LBB1_13:
        vzeroupper
        retq
Or_V(bool*, bool*, unsigned long):                           # @Or_V(bool*, bool*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB2_13
        cmpq    $16, %rdx
        jae     .LBB2_3
        xorl    %eax, %eax
        jmp     .LBB2_12
.LBB2_3:
        cmpq    $128, %rdx
        jae     .LBB2_5
        xorl    %eax, %eax
        jmp     .LBB2_9
.LBB2_5:
        movq    %rdx, %rax
        andq    $-128, %rax
        xorl    %ecx, %ecx
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx), %ymm0
        vmovups 32(%rsi,%rcx), %ymm1
        vmovups 64(%rsi,%rcx), %ymm2
        vmovups 96(%rsi,%rcx), %ymm3
        vorps   (%rdi,%rcx), %ymm0, %ymm0
        vorps   32(%rdi,%rcx), %ymm1, %ymm1
        vorps   64(%rdi,%rcx), %ymm2, %ymm2
        vorps   96(%rdi,%rcx), %ymm3, %ymm3
        vmovups %ymm0, (%rdi,%rcx)
        vmovups %ymm1, 32(%rdi,%rcx)
        vmovups %ymm2, 64(%rdi,%rcx)
        vmovups %ymm3, 96(%rdi,%rcx)
        subq    $-128, %rcx
        cmpq    %rcx, %rax
        jne     .LBB2_6
        cmpq    %rdx, %rax
        je      .LBB2_13
        testb   $112, %dl
        je      .LBB2_12
.LBB2_9:
        movq    %rax, %rcx
        movq    %rdx, %rax
        andq    $-16, %rax
.LBB2_10:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx), %xmm0
        vorps   (%rdi,%rcx), %xmm0, %xmm0
        vmovups %xmm0, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB2_10
        cmpq    %rdx, %rax
        je      .LBB2_13
.LBB2_12:                               # =>This Inner Loop Header: Depth=1
        movzbl  (%rsi,%rax), %ecx
        orb     %cl, (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB2_12
.LBB2_13:
        vzeroupper
        retq
Xor_V(bool*, bool*, unsigned long):                          # @Xor_V(bool*, bool*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB3_13
        cmpq    $16, %rdx
        jae     .LBB3_3
        xorl    %eax, %eax
        jmp     .LBB3_12
.LBB3_3:
        cmpq    $128, %rdx
        jae     .LBB3_5
        xorl    %eax, %eax
        jmp     .LBB3_9
.LBB3_5:
        movq    %rdx, %rax
        andq    $-128, %rax
        xorl    %ecx, %ecx
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx), %ymm0
        vmovups 32(%rsi,%rcx), %ymm1
        vmovups 64(%rsi,%rcx), %ymm2
        vmovups 96(%rsi,%rcx), %ymm3
        vxorps  (%rdi,%rcx), %ymm0, %ymm0
        vxorps  32(%rdi,%rcx), %ymm1, %ymm1
        vxorps  64(%rdi,%rcx), %ymm2, %ymm2
        vxorps  96(%rdi,%rcx), %ymm3, %ymm3
        vmovups %ymm0, (%rdi,%rcx)
        vmovups %ymm1, 32(%rdi,%rcx)
        vmovups %ymm2, 64(%rdi,%rcx)
        vmovups %ymm3, 96(%rdi,%rcx)
        subq    $-128, %rcx
        cmpq    %rcx, %rax
        jne     .LBB3_6
        cmpq    %rdx, %rax
        je      .LBB3_13
        testb   $112, %dl
        je      .LBB3_12
.LBB3_9:
        movq    %rax, %rcx
        movq    %rdx, %rax
        andq    $-16, %rax
.LBB3_10:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx), %xmm0
        vxorps  (%rdi,%rcx), %xmm0, %xmm0
        vmovups %xmm0, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB3_10
        cmpq    %rdx, %rax
        je      .LBB3_13
.LBB3_12:                               # =>This Inner Loop Header: Depth=1
        movzbl  (%rsi,%rax), %ecx
        xorb    %cl, (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB3_12
.LBB3_13:
        vzeroupper
        retq
Select_F64_I(double*, double*, bool*, unsigned long):                # @Select_F64_I(double*, double*, bool*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB4_1
        cmpq    $1, %rcx
        jne     .LBB4_4
        xorl    %r8d, %r8d
        xorl    %eax, %eax
.LBB4_10:
        testb   $1, %cl
        je      .LBB4_13
        cmpb    $0, (%rdx,%r8)
        je      .LBB4_13
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
.LBB4_13:
        retq
.LBB4_1:
        xorl    %eax, %eax
        retq
.LBB4_4:
        movq    %rcx, %r9
        andq    $-2, %r9
        xorl    %r8d, %r8d
        xorl    %eax, %eax
        jmp     .LBB4_5
.LBB4_9:                                #   in Loop: Header=BB4_5 Depth=1
        addq    $2, %r8
        cmpq    %r8, %r9
        je      .LBB4_10
.LBB4_5:                                # =>This Inner Loop Header: Depth=1
        cmpb    $0, (%rdx,%r8)
        je      .LBB4_7
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
.LBB4_7:                                #   in Loop: Header=BB4_5 Depth=1
        cmpb    $0, 1(%rdx,%r8)
        je      .LBB4_9
        vmovsd  8(%rsi,%r8,8), %xmm0            # xmm0 = mem[0],zero
        vmovsd  %xmm0, (%rdi,%rax,8)
        addq    $1, %rax
        jmp     .LBB4_9
Select_F32_I(float*, float*, bool*, unsigned long):                # @Select_F32_I(float*, float*, bool*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB5_1
        cmpq    $1, %rcx
        jne     .LBB5_4
        xorl    %r8d, %r8d
        xorl    %eax, %eax
.LBB5_10:
        testb   $1, %cl
        je      .LBB5_13
        cmpb    $0, (%rdx,%r8)
        je      .LBB5_13
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
.LBB5_13:
        retq
.LBB5_1:
        xorl    %eax, %eax
        retq
.LBB5_4:
        movq    %rcx, %r9
        andq    $-2, %r9
        xorl    %r8d, %r8d
        xorl    %eax, %eax
        jmp     .LBB5_5
.LBB5_9:                                #   in Loop: Header=BB5_5 Depth=1
        addq    $2, %r8
        cmpq    %r8, %r9
        je      .LBB5_10
.LBB5_5:                                # =>This Inner Loop Header: Depth=1
        cmpb    $0, (%rdx,%r8)
        je      .LBB5_7
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
.LBB5_7:                                #   in Loop: Header=BB5_5 Depth=1
        cmpb    $0, 1(%rdx,%r8)
        je      .LBB5_9
        vmovss  4(%rsi,%r8,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vmovss  %xmm0, (%rdi,%rax,4)
        addq    $1, %rax
        jmp     .LBB5_9
All_I(bool*, unsigned long):                            # @All_I(bool*, unsigned long)
        movq    %rsi, %rax
        xorl    %ecx, %ecx
        andq    $-32, %rax
        je      .LBB0_1
        vpxor   %xmm0, %xmm0, %xmm0
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
        vpcmpeqb        (%rdi,%rcx), %ymm0, %ymm1
        vptest  %ymm1, %ymm1
        jne     .LBB0_9
        addq    $32, %rcx
        cmpq    %rax, %rcx
        jb      .LBB0_8
.LBB0_1:
        movb    $1, %al
        cmpq    %rsi, %rcx
        jae     .LBB0_6
        addq    $-1, %rsi
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
        movzbl  (%rdi,%rcx), %eax
        testb   %al, %al
        je      .LBB0_5
        leaq    1(%rcx), %rdx
        cmpq    %rcx, %rsi
        movq    %rdx, %rcx
        jne     .LBB0_3
.LBB0_5:
        testb   %al, %al
        setne   %al
.LBB0_6:
        vzeroupper
        retq
.LBB0_9:
        xorl    %eax, %eax
        vzeroupper
        retq
Any_I(bool*, unsigned long):                            # @Any_I(bool*, unsigned long)
        movq    %rsi, %rcx
        xorl    %eax, %eax
        andq    $-32, %rcx
        je      .LBB1_1
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
        vmovdqu (%rdi,%rax), %ymm0
        vptest  %ymm0, %ymm0
        jne     .LBB1_5
        addq    $32, %rax
        cmpq    %rcx, %rax
        jb      .LBB1_4
.LBB1_1:
        cmpq    %rsi, %rax
        jae     .LBB1_2
        addq    $-1, %rsi
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        movzbl  (%rdi,%rax), %ecx
        testb   %cl, %cl
        jne     .LBB1_9
        leaq    1(%rax), %rdx
        cmpq    %rax, %rsi
        movq    %rdx, %rax
        jne     .LBB1_7
.LBB1_9:
        testb   %cl, %cl
        setne   %al
        vzeroupper
        retq
.LBB1_5:
        movb    $1, %al
        vzeroupper
        retq
.LBB1_2:
        xorl    %eax, %eax
        vzeroupper
        retq
None_I(bool*, unsigned long):                           # @None_I(bool*, unsigned long)
        movq    %rsi, %rax
        xorl    %ecx, %ecx
        andq    $-32, %rax
        je      .LBB2_1
.LBB2_7:                                # =>This Inner Loop Header: Depth=1
        vmovdqu (%rdi,%rcx), %ymm0
        vptest  %ymm0, %ymm0
        jne     .LBB2_8
        addq    $32, %rcx
        cmpq    %rax, %rcx
        jb      .LBB2_7
.LBB2_1:
        movb    $1, %al
        cmpq    %rsi, %rcx
        jae     .LBB2_5
        addq    $-1, %rsi
.LBB2_3:                                # =>This Inner Loop Header: Depth=1
        cmpb    $0, (%rdi,%rcx)
        sete    %al
        jne     .LBB2_5
        leaq    1(%rcx), %rdx
        cmpq    %rcx, %rsi
        movq    %rdx, %rcx
        jne     .LBB2_3
.LBB2_5:
        vzeroupper
        retq
.LBB2_8:
        xorl    %eax, %eax
        vzeroupper
        retq
Count_I(bool*, unsigned long):                          # @Count_I(bool*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB9_1
        cmpq    $16, %rsi
        jae     .LBB9_4
        xorl    %ecx, %ecx
        xorl    %eax, %eax
        jmp     .LBB9_11
.LBB9_1:
        xorl    %eax, %eax
        retq
.LBB9_4:
        movq    %rsi, %rcx
        andq    $-16, %rcx
        leaq    -16(%rcx), %rax
        movq    %rax, %r8
        shrq    $4, %r8
        addq    $1, %r8
        testq   %rax, %rax
        je      .LBB9_5
        movq    %r8, %rdx
        andq    $-2, %rdx
        vpxor   %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        vpxor   %xmm1, %xmm1, %xmm1
        vpxor   %xmm2, %xmm2, %xmm2
        vpxor   %xmm3, %xmm3, %xmm3
.LBB9_7:                                # =>This Inner Loop Header: Depth=1
        vpmovzxbq       (%rdi,%rax), %ymm4      # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm0, %ymm0
        vpmovzxbq       4(%rdi,%rax), %ymm4     # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm1, %ymm1
        vpmovzxbq       8(%rdi,%rax), %ymm4     # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpmovzxbq       12(%rdi,%rax), %ymm5    # ymm5 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm2, %ymm2
        vpaddq  %ymm5, %ymm3, %ymm3
        vpmovzxbq       16(%rdi,%rax), %ymm4    # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm0, %ymm0
        vpmovzxbq       20(%rdi,%rax), %ymm4    # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm1, %ymm1
        vpmovzxbq       24(%rdi,%rax), %ymm4    # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpmovzxbq       28(%rdi,%rax), %ymm5    # ymm5 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm2, %ymm2
        vpaddq  %ymm5, %ymm3, %ymm3
        addq    $32, %rax
        addq    $-2, %rdx
        jne     .LBB9_7
        testb   $1, %r8b
        je      .LBB9_10
.LBB9_9:
        vpmovzxbq       (%rdi,%rax), %ymm4      # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpmovzxbq       4(%rdi,%rax), %ymm5     # ymm5 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm0, %ymm0
        vpaddq  %ymm5, %ymm1, %ymm1
        vpmovzxbq       8(%rdi,%rax), %ymm4     # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm2, %ymm2
        vpmovzxbq       12(%rdi,%rax), %ymm4    # ymm4 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero,mem[2],zero,zero,zero,zero,zero,zero,zero,mem[3],zero,zero,zero,zero,zero,zero,zero
        vpaddq  %ymm4, %ymm3, %ymm3
.LBB9_10:
        vpaddq  %ymm3, %ymm1, %ymm1
        vpaddq  %ymm2, %ymm0, %ymm0
        vpaddq  %ymm1, %ymm0, %ymm0
        vextracti128    $1, %ymm0, %xmm1
        vpaddq  %xmm1, %xmm0, %xmm0
        vpshufd $238, %xmm0, %xmm1              # xmm1 = xmm0[2,3,2,3]
        vpaddq  %xmm1, %xmm0, %xmm0
        vmovq   %xmm0, %rax
        cmpq    %rsi, %rcx
        je      .LBB9_12
.LBB9_11:                               # =>This Inner Loop Header: Depth=1
        movzbl  (%rdi,%rcx), %edx
        addq    %rdx, %rax
        addq    $1, %rcx
        cmpq    %rcx, %rsi
        jne     .LBB9_11
.LBB9_12:
        vzeroupper
        retq
.LBB9_5:
        vpxor   %xmm0, %xmm0, %xmm0
        xorl    %eax, %eax
        vpxor   %xmm1, %xmm1, %xmm1
        vpxor   %xmm2, %xmm2, %xmm2
        vpxor   %xmm3, %xmm3, %xmm3
        testb   $1, %r8b
        jne     .LBB9_9
        jmp     .LBB9_10