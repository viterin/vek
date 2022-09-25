.LCPI0_0:
        .quad   0x7fefffffffffffff              # double 1.7976931348623157E+308
Min_F64_D(double*, unsigned long):                        # @Min_F64_D(double*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB0_1
        cmpq    $16, %rsi
        jae     .LBB0_4
        vmovsd  .LCPI0_0(%rip), %xmm0           # xmm0 = mem[0],zero
        xorl    %eax, %eax
        jmp     .LBB0_11
.LBB0_1:
        vmovsd  .LCPI0_0(%rip), %xmm0           # xmm0 = mem[0],zero
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
        vbroadcastsd    .LCPI0_0(%rip), %ymm0   # ymm0 = [1.7976931348623157E+308,1.7976931348623157E+308,1.7976931348623157E+308,1.7976931348623157E+308]
        xorl    %edx, %edx
        vmovapd %ymm0, %ymm1
        vmovapd %ymm0, %ymm2
        vmovapd %ymm0, %ymm3
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
        vminpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vminpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vminpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vminpd  96(%rdi,%rdx,8), %ymm3, %ymm3
        vminpd  128(%rdi,%rdx,8), %ymm0, %ymm0
        vminpd  160(%rdi,%rdx,8), %ymm1, %ymm1
        vminpd  192(%rdi,%rdx,8), %ymm2, %ymm2
        vminpd  224(%rdi,%rdx,8), %ymm3, %ymm3
        addq    $32, %rdx
        addq    $-2, %rcx
        jne     .LBB0_7
        testb   $1, %r8b
        je      .LBB0_10
.LBB0_9:
        vminpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vminpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vminpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vminpd  96(%rdi,%rdx,8), %ymm3, %ymm3
.LBB0_10:
        vminpd  %ymm3, %ymm0, %ymm0
        vminpd  %ymm2, %ymm1, %ymm1
        vminpd  %ymm0, %ymm1, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vminpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vminsd  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB0_12
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
        vminsd  (%rdi,%rax,8), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_11
.LBB0_12:
        vzeroupper
        retq
.LBB0_5:
        vbroadcastsd    .LCPI0_0(%rip), %ymm0   # ymm0 = [1.7976931348623157E+308,1.7976931348623157E+308,1.7976931348623157E+308,1.7976931348623157E+308]
        xorl    %edx, %edx
        vmovapd %ymm0, %ymm1
        vmovapd %ymm0, %ymm2
        vmovapd %ymm0, %ymm3
        testb   $1, %r8b
        jne     .LBB0_9
        jmp     .LBB0_10
.LCPI1_0:
        .long   0x7f7fffff                      # float 3.40282347E+38
Min_F32_F(float*, unsigned long):                        # @Min_F32_F(float*, unsigned long)
        testq   %rsi, %rsi
        je      .LBB1_1
        cmpq    $32, %rsi
        jae     .LBB1_4
        vmovss  .LCPI1_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
        xorl    %eax, %eax
        jmp     .LBB1_11
.LBB1_1:
        vmovss  .LCPI1_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
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
        vbroadcastss    .LCPI1_0(%rip), %ymm0   # ymm0 = [3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38]
        xorl    %edx, %edx
        vmovaps %ymm0, %ymm1
        vmovaps %ymm0, %ymm2
        vmovaps %ymm0, %ymm3
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        vminps  (%rdi,%rdx,4), %ymm0, %ymm0
        vminps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vminps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vminps  96(%rdi,%rdx,4), %ymm3, %ymm3
        vminps  128(%rdi,%rdx,4), %ymm0, %ymm0
        vminps  160(%rdi,%rdx,4), %ymm1, %ymm1
        vminps  192(%rdi,%rdx,4), %ymm2, %ymm2
        vminps  224(%rdi,%rdx,4), %ymm3, %ymm3
        addq    $64, %rdx
        addq    $-2, %rcx
        jne     .LBB1_7
        testb   $1, %r8b
        je      .LBB1_10
.LBB1_9:
        vminps  (%rdi,%rdx,4), %ymm0, %ymm0
        vminps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vminps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vminps  96(%rdi,%rdx,4), %ymm3, %ymm3
.LBB1_10:
        vminps  %ymm3, %ymm0, %ymm0
        vminps  %ymm2, %ymm1, %ymm1
        vminps  %ymm0, %ymm1, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vminps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vminps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vminss  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB1_12
.LBB1_11:                               # =>This Inner Loop Header: Depth=1
        vminss  (%rdi,%rax,4), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB1_11
.LBB1_12:
        vzeroupper
        retq
.LBB1_5:
        vbroadcastss    .LCPI1_0(%rip), %ymm0   # ymm0 = [3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38,3.40282347E+38]
        xorl    %edx, %edx
        vmovaps %ymm0, %ymm1
        vmovaps %ymm0, %ymm2
        vmovaps %ymm0, %ymm3
        testb   $1, %r8b
        jne     .LBB1_9
        jmp     .LBB1_10
Minimum_F64_V(double*, double*, unsigned long):                 # @Minimum_F64_V(double*, double*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB2_9
        cmpq    $16, %rdx
        jae     .LBB2_3
        xorl    %eax, %eax
        jmp     .LBB2_6
.LBB2_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        leaq    96(%rdi), %r8
        xorl    %ecx, %ecx
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rsi,%rcx,8), %ymm0
        vmovupd 32(%rsi,%rcx,8), %ymm1
        vmovupd 64(%rsi,%rcx,8), %ymm2
        vmovupd 96(%rsi,%rcx,8), %ymm3
        vcmpltpd        -96(%r8,%rcx,8), %ymm0, %ymm4
        vcmpltpd        -64(%r8,%rcx,8), %ymm1, %ymm5
        vcmpltpd        -32(%r8,%rcx,8), %ymm2, %ymm6
        vcmpltpd        (%r8,%rcx,8), %ymm3, %ymm7
        vmaskmovpd      %ymm0, %ymm4, -96(%r8,%rcx,8)
        vmaskmovpd      %ymm1, %ymm5, -64(%r8,%rcx,8)
        vmaskmovpd      %ymm2, %ymm6, -32(%r8,%rcx,8)
        vmaskmovpd      %ymm3, %ymm7, (%r8,%rcx,8)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB2_4
        cmpq    %rdx, %rax
        jne     .LBB2_6
.LBB2_9:
        vzeroupper
        retq
.LBB2_8:                                #   in Loop: Header=BB2_6 Depth=1
        addq    $1, %rax
        cmpq    %rax, %rdx
        je      .LBB2_9
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%rax,8), %xmm0            # xmm0 = mem[0],zero
        vucomisd        (%rdi,%rax,8), %xmm0
        jae     .LBB2_8
        vmovsd  %xmm0, (%rdi,%rax,8)
        jmp     .LBB2_8
Minimum_F32_V(float*, float*, unsigned long):                 # @Minimum_F32_V(float*, float*, unsigned long)
        testq   %rdx, %rdx
        je      .LBB3_9
        cmpq    $32, %rdx
        jae     .LBB3_3
        xorl    %eax, %eax
        jmp     .LBB3_6
.LBB3_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        leaq    96(%rdi), %r8
        xorl    %ecx, %ecx
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx,4), %ymm0
        vmovups 32(%rsi,%rcx,4), %ymm1
        vmovups 64(%rsi,%rcx,4), %ymm2
        vmovups 96(%rsi,%rcx,4), %ymm3
        vcmpltps        -96(%r8,%rcx,4), %ymm0, %ymm4
        vcmpltps        -64(%r8,%rcx,4), %ymm1, %ymm5
        vcmpltps        -32(%r8,%rcx,4), %ymm2, %ymm6
        vcmpltps        (%r8,%rcx,4), %ymm3, %ymm7
        vmaskmovps      %ymm0, %ymm4, -96(%r8,%rcx,4)
        vmaskmovps      %ymm1, %ymm5, -64(%r8,%rcx,4)
        vmaskmovps      %ymm2, %ymm6, -32(%r8,%rcx,4)
        vmaskmovps      %ymm3, %ymm7, (%r8,%rcx,4)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB3_4
        cmpq    %rdx, %rax
        jne     .LBB3_6
.LBB3_9:
        vzeroupper
        retq
.LBB3_8:                                #   in Loop: Header=BB3_6 Depth=1
        addq    $1, %rax
        cmpq    %rax, %rdx
        je      .LBB3_9
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdi,%rax,4), %xmm0
        jae     .LBB3_8
        vmovss  %xmm0, (%rdi,%rax,4)
        jmp     .LBB3_8
MinimumNumber_F64_V(double*, double, unsigned long):            # @MinimumNumber_F64_V(double*, double, unsigned long)
        testq   %rsi, %rsi
        je      .LBB4_9
        cmpq    $16, %rsi
        jae     .LBB4_3
        xorl    %eax, %eax
        jmp     .LBB4_6
.LBB4_3:
        movq    %rsi, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        leaq    96(%rdi), %rcx
        xorl    %edx, %edx
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
        vcmpltpd        -96(%rcx,%rdx,8), %ymm1, %ymm2
        vcmpltpd        -64(%rcx,%rdx,8), %ymm1, %ymm3
        vcmpltpd        -32(%rcx,%rdx,8), %ymm1, %ymm4
        vcmpltpd        (%rcx,%rdx,8), %ymm1, %ymm5
        vmaskmovpd      %ymm1, %ymm2, -96(%rcx,%rdx,8)
        vmaskmovpd      %ymm1, %ymm3, -64(%rcx,%rdx,8)
        vmaskmovpd      %ymm1, %ymm4, -32(%rcx,%rdx,8)
        vmaskmovpd      %ymm1, %ymm5, (%rcx,%rdx,8)
        addq    $16, %rdx
        cmpq    %rdx, %rax
        jne     .LBB4_4
        cmpq    %rsi, %rax
        jne     .LBB4_6
.LBB4_9:
        vzeroupper
        retq
.LBB4_8:                                #   in Loop: Header=BB4_6 Depth=1
        addq    $1, %rax
        cmpq    %rax, %rsi
        je      .LBB4_9
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
        vucomisd        (%rdi,%rax,8), %xmm0
        jae     .LBB4_8
        vmovsd  %xmm0, (%rdi,%rax,8)
        jmp     .LBB4_8
MinimumNumber_F32_V(float*, float, unsigned long):            # @MinimumNumber_F32_V(float*, float, unsigned long)
        testq   %rsi, %rsi
        je      .LBB5_9
        cmpq    $32, %rsi
        jae     .LBB5_3
        xorl    %eax, %eax
        jmp     .LBB5_6
.LBB5_3:
        movq    %rsi, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        leaq    96(%rdi), %rcx
        xorl    %edx, %edx
.LBB5_4:                                # =>This Inner Loop Header: Depth=1
        vcmpltps        -96(%rcx,%rdx,4), %ymm1, %ymm2
        vcmpltps        -64(%rcx,%rdx,4), %ymm1, %ymm3
        vcmpltps        -32(%rcx,%rdx,4), %ymm1, %ymm4
        vcmpltps        (%rcx,%rdx,4), %ymm1, %ymm5
        vmaskmovps      %ymm1, %ymm2, -96(%rcx,%rdx,4)
        vmaskmovps      %ymm1, %ymm3, -64(%rcx,%rdx,4)
        vmaskmovps      %ymm1, %ymm4, -32(%rcx,%rdx,4)
        vmaskmovps      %ymm1, %ymm5, (%rcx,%rdx,4)
        addq    $32, %rdx
        cmpq    %rdx, %rax
        jne     .LBB5_4
        cmpq    %rsi, %rax
        jne     .LBB5_6
.LBB5_9:
        vzeroupper
        retq
.LBB5_8:                                #   in Loop: Header=BB5_6 Depth=1
        addq    $1, %rax
        cmpq    %rax, %rsi
        je      .LBB5_9
.LBB5_6:                                # =>This Inner Loop Header: Depth=1
        vucomiss        (%rdi,%rax,4), %xmm0
        jae     .LBB5_8
        vmovss  %xmm0, (%rdi,%rax,4)
        jmp     .LBB5_8