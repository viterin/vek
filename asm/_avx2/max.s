.LCPI0_0:
        .quad   0xffefffffffffffff              # double -1.7976931348623157E+308
Max_F64(double*, unsigned long):                          # @Max_F64(double*, unsigned long)
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
        vbroadcastsd    .LCPI0_0(%rip), %ymm0   # ymm0 = [-1.7976931348623157E+308,-1.7976931348623157E+308,-1.7976931348623157E+308,-1.7976931348623157E+308]
        xorl    %edx, %edx
        vmovapd %ymm0, %ymm1
        vmovapd %ymm0, %ymm2
        vmovapd %ymm0, %ymm3
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
        vmaxpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vmaxpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vmaxpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vmaxpd  96(%rdi,%rdx,8), %ymm3, %ymm3
        vmaxpd  128(%rdi,%rdx,8), %ymm0, %ymm0
        vmaxpd  160(%rdi,%rdx,8), %ymm1, %ymm1
        vmaxpd  192(%rdi,%rdx,8), %ymm2, %ymm2
        vmaxpd  224(%rdi,%rdx,8), %ymm3, %ymm3
        addq    $32, %rdx
        addq    $-2, %rcx
        jne     .LBB0_7
        testb   $1, %r8b
        je      .LBB0_10
.LBB0_9:
        vmaxpd  (%rdi,%rdx,8), %ymm0, %ymm0
        vmaxpd  32(%rdi,%rdx,8), %ymm1, %ymm1
        vmaxpd  64(%rdi,%rdx,8), %ymm2, %ymm2
        vmaxpd  96(%rdi,%rdx,8), %ymm3, %ymm3
.LBB0_10:
        vmaxpd  %ymm3, %ymm0, %ymm0
        vmaxpd  %ymm2, %ymm1, %ymm1
        vmaxpd  %ymm0, %ymm1, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vmaxpd  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vmaxsd  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB0_12
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
        vmaxsd  (%rdi,%rax,8), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_11
.LBB0_12:
        vzeroupper
        retq
.LBB0_5:
        vbroadcastsd    .LCPI0_0(%rip), %ymm0   # ymm0 = [-1.7976931348623157E+308,-1.7976931348623157E+308,-1.7976931348623157E+308,-1.7976931348623157E+308]
        xorl    %edx, %edx
        vmovapd %ymm0, %ymm1
        vmovapd %ymm0, %ymm2
        vmovapd %ymm0, %ymm3
        testb   $1, %r8b
        jne     .LBB0_9
        jmp     .LBB0_10
.LCPI1_0:
        .long   0xff7fffff                      # float -3.40282347E+38
Max_F32(float*, unsigned long):                          # @Max_F32(float*, unsigned long)
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
        vbroadcastss    .LCPI1_0(%rip), %ymm0   # ymm0 = [-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38]
        xorl    %edx, %edx
        vmovaps %ymm0, %ymm1
        vmovaps %ymm0, %ymm2
        vmovaps %ymm0, %ymm3
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        vmaxps  (%rdi,%rdx,4), %ymm0, %ymm0
        vmaxps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vmaxps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vmaxps  96(%rdi,%rdx,4), %ymm3, %ymm3
        vmaxps  128(%rdi,%rdx,4), %ymm0, %ymm0
        vmaxps  160(%rdi,%rdx,4), %ymm1, %ymm1
        vmaxps  192(%rdi,%rdx,4), %ymm2, %ymm2
        vmaxps  224(%rdi,%rdx,4), %ymm3, %ymm3
        addq    $64, %rdx
        addq    $-2, %rcx
        jne     .LBB1_7
        testb   $1, %r8b
        je      .LBB1_10
.LBB1_9:
        vmaxps  (%rdi,%rdx,4), %ymm0, %ymm0
        vmaxps  32(%rdi,%rdx,4), %ymm1, %ymm1
        vmaxps  64(%rdi,%rdx,4), %ymm2, %ymm2
        vmaxps  96(%rdi,%rdx,4), %ymm3, %ymm3
.LBB1_10:
        vmaxps  %ymm3, %ymm0, %ymm0
        vmaxps  %ymm2, %ymm1, %ymm1
        vmaxps  %ymm0, %ymm1, %ymm0
        vextractf128    $1, %ymm0, %xmm1
        vmaxps  %xmm1, %xmm0, %xmm0
        vpermilpd       $1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
        vmaxps  %xmm1, %xmm0, %xmm0
        vmovshdup       %xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
        vmaxss  %xmm1, %xmm0, %xmm0
        cmpq    %rsi, %rax
        je      .LBB1_12
.LBB1_11:                               # =>This Inner Loop Header: Depth=1
        vmaxss  (%rdi,%rax,4), %xmm0, %xmm0
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB1_11
.LBB1_12:
        vzeroupper
        retq
.LBB1_5:
        vbroadcastss    .LCPI1_0(%rip), %ymm0   # ymm0 = [-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38,-3.40282347E+38]
        xorl    %edx, %edx
        vmovaps %ymm0, %ymm1
        vmovaps %ymm0, %ymm2
        vmovaps %ymm0, %ymm3
        testb   $1, %r8b
        jne     .LBB1_9
        jmp     .LBB1_10
Maximum_F64(double*, double*, unsigned long):                   # @Maximum_F64(double*, double*, unsigned long)
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
        vmovupd -96(%r8,%rcx,8), %ymm4
        vmovupd -64(%r8,%rcx,8), %ymm5
        vmovupd -32(%r8,%rcx,8), %ymm6
        vmovupd (%r8,%rcx,8), %ymm7
        vcmpltpd        %ymm0, %ymm4, %ymm4
        vmaskmovpd      %ymm0, %ymm4, -96(%r8,%rcx,8)
        vcmpltpd        %ymm1, %ymm5, %ymm0
        vmaskmovpd      %ymm1, %ymm0, -64(%r8,%rcx,8)
        vcmpltpd        %ymm2, %ymm6, %ymm0
        vmaskmovpd      %ymm2, %ymm0, -32(%r8,%rcx,8)
        vcmpltpd        %ymm3, %ymm7, %ymm0
        vmaskmovpd      %ymm3, %ymm0, (%r8,%rcx,8)
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
        jbe     .LBB2_8
        vmovsd  %xmm0, (%rdi,%rax,8)
        jmp     .LBB2_8
Maximum_F32(float*, float*, unsigned long):                   # @Maximum_F32(float*, float*, unsigned long)
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
        vmovups -96(%r8,%rcx,4), %ymm4
        vmovups -64(%r8,%rcx,4), %ymm5
        vmovups -32(%r8,%rcx,4), %ymm6
        vmovups (%r8,%rcx,4), %ymm7
        vcmpltps        %ymm0, %ymm4, %ymm4
        vmaskmovps      %ymm0, %ymm4, -96(%r8,%rcx,4)
        vcmpltps        %ymm1, %ymm5, %ymm0
        vmaskmovps      %ymm1, %ymm0, -64(%r8,%rcx,4)
        vcmpltps        %ymm2, %ymm6, %ymm0
        vmaskmovps      %ymm2, %ymm0, -32(%r8,%rcx,4)
        vcmpltps        %ymm3, %ymm7, %ymm0
        vmaskmovps      %ymm3, %ymm0, (%r8,%rcx,4)
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
        jbe     .LBB3_8
        vmovss  %xmm0, (%rdi,%rax,4)
        jmp     .LBB3_8
MaximumNumber_F64(double*, double, unsigned long):              # @MaximumNumber_F64(double*, double, unsigned long)
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
        vmovupd -96(%rcx,%rdx,8), %ymm2
        vmovupd -64(%rcx,%rdx,8), %ymm3
        vmovupd -32(%rcx,%rdx,8), %ymm4
        vmovupd (%rcx,%rdx,8), %ymm5
        vcmpltpd        %ymm1, %ymm2, %ymm2
        vmaskmovpd      %ymm1, %ymm2, -96(%rcx,%rdx,8)
        vcmpltpd        %ymm1, %ymm3, %ymm2
        vmaskmovpd      %ymm1, %ymm2, -64(%rcx,%rdx,8)
        vcmpltpd        %ymm1, %ymm4, %ymm2
        vmaskmovpd      %ymm1, %ymm2, -32(%rcx,%rdx,8)
        vcmpltpd        %ymm1, %ymm5, %ymm2
        vmaskmovpd      %ymm1, %ymm2, (%rcx,%rdx,8)
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
        jbe     .LBB4_8
        vmovsd  %xmm0, (%rdi,%rax,8)
        jmp     .LBB4_8
MaximumNumber_F32(float*, float, unsigned long):              # @MaximumNumber_F32(float*, float, unsigned long)
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
        vmovups -96(%rcx,%rdx,4), %ymm2
        vmovups -64(%rcx,%rdx,4), %ymm3
        vmovups -32(%rcx,%rdx,4), %ymm4
        vmovups (%rcx,%rdx,4), %ymm5
        vcmpltps        %ymm1, %ymm2, %ymm2
        vmaskmovps      %ymm1, %ymm2, -96(%rcx,%rdx,4)
        vcmpltps        %ymm1, %ymm3, %ymm2
        vmaskmovps      %ymm1, %ymm2, -64(%rcx,%rdx,4)
        vcmpltps        %ymm1, %ymm4, %ymm2
        vmaskmovps      %ymm1, %ymm2, -32(%rcx,%rdx,4)
        vcmpltps        %ymm1, %ymm5, %ymm2
        vmaskmovps      %ymm1, %ymm2, (%rcx,%rdx,4)
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
        jbe     .LBB5_8
        vmovss  %xmm0, (%rdi,%rax,4)
        jmp     .LBB5_8
