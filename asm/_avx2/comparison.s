.LCPI0_0:
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
Lt_F64_V(bool*, double*, double*, unsigned long):                    # @Lt_F64_V(bool*, double*, double*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB0_7
        cmpq    $16, %rcx
        jae     .LBB0_3
        xorl    %r8d, %r8d
        jmp     .LBB0_6
.LBB0_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI0_0(%rip), %xmm0           # xmm0 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rsi,%rax,8), %ymm1
        vmovupd 32(%rsi,%rax,8), %ymm2
        vmovupd 64(%rsi,%rax,8), %ymm3
        vmovupd 96(%rsi,%rax,8), %ymm4
        vcmpltpd        (%rdx,%rax,8), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpackssdw       %xmm1, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpltpd        32(%rdx,%rax,8), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpltpd        64(%rdx,%rax,8), %ymm3, %ymm3
        vpunpckldq      %xmm2, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
        vextractf128    $1, %ymm3, %xmm2
        vpackssdw       %xmm2, %xmm3, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpltpd        96(%rdx,%rax,8), %ymm4, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm0, %xmm3, %xmm3
        vpbroadcastd    %xmm3, %xmm3
        vpbroadcastd    %xmm2, %xmm2
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vpblendd        $12, %xmm2, %xmm1, %xmm1        # xmm1 = xmm1[0,1],xmm2[2,3]
        vmovdqu %xmm1, (%rdi,%rax)
        addq    $16, %rax
        cmpq    %rax, %r8
        jne     .LBB0_4
        cmpq    %rcx, %r8
        je      .LBB0_7
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vucomisd        (%rdx,%r8,8), %xmm0
        setb    (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB0_6
.LBB0_7:
        vzeroupper
        retq
.LCPI1_0:
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
Lt_F32_V(bool*, float*, float*, unsigned long):                    # @Lt_F32_V(bool*, float*, float*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB1_7
        cmpq    $32, %rcx
        jae     .LBB1_3
        xorl    %r8d, %r8d
        jmp     .LBB1_6
.LBB1_3:
        movq    %rcx, %r8
        andq    $-32, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI1_0(%rip), %xmm0           # xmm0 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rax,4), %ymm1
        vmovups 32(%rsi,%rax,4), %ymm2
        vmovups 64(%rsi,%rax,4), %ymm3
        vmovups 96(%rsi,%rax,4), %ymm4
        vcmpltps        (%rdx,%rax,4), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpltps        32(%rdx,%rax,4), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpltps        64(%rdx,%rax,4), %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm5
        vpackssdw       %xmm5, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpltps        96(%rdx,%rax,4), %ymm4, %ymm4
        vpand   %xmm0, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm0, %xmm4, %xmm4
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vinserti128     $1, %xmm2, %ymm1, %ymm1
        vpunpcklqdq     %ymm3, %ymm1, %ymm1     # ymm1 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
        vpermq  $216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
        vmovdqu %ymm1, (%rdi,%rax)
        addq    $32, %rax
        cmpq    %rax, %r8
        jne     .LBB1_4
        cmpq    %rcx, %r8
        je      .LBB1_7
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdx,%r8,4), %xmm0
        setb    (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB1_6
.LBB1_7:
        vzeroupper
        retq
.LCPI2_0:
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
Lte_F64_V(bool*, double*, double*, unsigned long):                   # @Lte_F64_V(bool*, double*, double*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB2_7
        cmpq    $16, %rcx
        jae     .LBB2_3
        xorl    %r8d, %r8d
        jmp     .LBB2_6
.LBB2_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI2_0(%rip), %xmm0           # xmm0 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rsi,%rax,8), %ymm1
        vmovupd 32(%rsi,%rax,8), %ymm2
        vmovupd 64(%rsi,%rax,8), %ymm3
        vmovupd 96(%rsi,%rax,8), %ymm4
        vcmplepd        (%rdx,%rax,8), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpackssdw       %xmm1, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmplepd        32(%rdx,%rax,8), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmplepd        64(%rdx,%rax,8), %ymm3, %ymm3
        vpunpckldq      %xmm2, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
        vextractf128    $1, %ymm3, %xmm2
        vpackssdw       %xmm2, %xmm3, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmplepd        96(%rdx,%rax,8), %ymm4, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm0, %xmm3, %xmm3
        vpbroadcastd    %xmm3, %xmm3
        vpbroadcastd    %xmm2, %xmm2
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vpblendd        $12, %xmm2, %xmm1, %xmm1        # xmm1 = xmm1[0,1],xmm2[2,3]
        vmovdqu %xmm1, (%rdi,%rax)
        addq    $16, %rax
        cmpq    %rax, %r8
        jne     .LBB2_4
        cmpq    %rcx, %r8
        je      .LBB2_7
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vucomisd        (%rdx,%r8,8), %xmm0
        setbe   (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB2_6
.LBB2_7:
        vzeroupper
        retq
.LCPI3_0:
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
Lte_F32_V(bool*, float*, float*, unsigned long):                   # @Lte_F32_V(bool*, float*, float*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB3_7
        cmpq    $32, %rcx
        jae     .LBB3_3
        xorl    %r8d, %r8d
        jmp     .LBB3_6
.LBB3_3:
        movq    %rcx, %r8
        andq    $-32, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI3_0(%rip), %xmm0           # xmm0 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rax,4), %ymm1
        vmovups 32(%rsi,%rax,4), %ymm2
        vmovups 64(%rsi,%rax,4), %ymm3
        vmovups 96(%rsi,%rax,4), %ymm4
        vcmpleps        (%rdx,%rax,4), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpleps        32(%rdx,%rax,4), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpleps        64(%rdx,%rax,4), %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm5
        vpackssdw       %xmm5, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpleps        96(%rdx,%rax,4), %ymm4, %ymm4
        vpand   %xmm0, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm0, %xmm4, %xmm4
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vinserti128     $1, %xmm2, %ymm1, %ymm1
        vpunpcklqdq     %ymm3, %ymm1, %ymm1     # ymm1 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
        vpermq  $216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
        vmovdqu %ymm1, (%rdi,%rax)
        addq    $32, %rax
        cmpq    %rax, %r8
        jne     .LBB3_4
        cmpq    %rcx, %r8
        je      .LBB3_7
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdx,%r8,4), %xmm0
        setbe   (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB3_6
.LBB3_7:
        vzeroupper
        retq
.LCPI4_0:
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
Gt_F64_V(bool*, double*, double*, unsigned long):                    # @Gt_F64_V(bool*, double*, double*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB4_7
        cmpq    $16, %rcx
        jae     .LBB4_3
        xorl    %r8d, %r8d
        jmp     .LBB4_6
.LBB4_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI4_0(%rip), %xmm0           # xmm0 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdx,%rax,8), %ymm1
        vmovupd 32(%rdx,%rax,8), %ymm2
        vmovupd 64(%rdx,%rax,8), %ymm3
        vmovupd 96(%rdx,%rax,8), %ymm4
        vcmpltpd        (%rsi,%rax,8), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpackssdw       %xmm1, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpltpd        32(%rsi,%rax,8), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpltpd        64(%rsi,%rax,8), %ymm3, %ymm3
        vpunpckldq      %xmm2, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
        vextractf128    $1, %ymm3, %xmm2
        vpackssdw       %xmm2, %xmm3, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpltpd        96(%rsi,%rax,8), %ymm4, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm0, %xmm3, %xmm3
        vpbroadcastd    %xmm3, %xmm3
        vpbroadcastd    %xmm2, %xmm2
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vpblendd        $12, %xmm2, %xmm1, %xmm1        # xmm1 = xmm1[0,1],xmm2[2,3]
        vmovdqu %xmm1, (%rdi,%rax)
        addq    $16, %rax
        cmpq    %rax, %r8
        jne     .LBB4_4
        cmpq    %rcx, %r8
        je      .LBB4_7
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vucomisd        (%rdx,%r8,8), %xmm0
        seta    (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB4_6
.LBB4_7:
        vzeroupper
        retq
.LCPI5_0:
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
Gt_F32_V(bool*, float*, float*, unsigned long):                    # @Gt_F32_V(bool*, float*, float*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB5_7
        cmpq    $32, %rcx
        jae     .LBB5_3
        xorl    %r8d, %r8d
        jmp     .LBB5_6
.LBB5_3:
        movq    %rcx, %r8
        andq    $-32, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI5_0(%rip), %xmm0           # xmm0 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB5_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdx,%rax,4), %ymm1
        vmovups 32(%rdx,%rax,4), %ymm2
        vmovups 64(%rdx,%rax,4), %ymm3
        vmovups 96(%rdx,%rax,4), %ymm4
        vcmpltps        (%rsi,%rax,4), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpltps        32(%rsi,%rax,4), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpltps        64(%rsi,%rax,4), %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm5
        vpackssdw       %xmm5, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpltps        96(%rsi,%rax,4), %ymm4, %ymm4
        vpand   %xmm0, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm0, %xmm4, %xmm4
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vinserti128     $1, %xmm2, %ymm1, %ymm1
        vpunpcklqdq     %ymm3, %ymm1, %ymm1     # ymm1 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
        vpermq  $216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
        vmovdqu %ymm1, (%rdi,%rax)
        addq    $32, %rax
        cmpq    %rax, %r8
        jne     .LBB5_4
        cmpq    %rcx, %r8
        je      .LBB5_7
.LBB5_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdx,%r8,4), %xmm0
        seta    (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB5_6
.LBB5_7:
        vzeroupper
        retq
.LCPI6_0:
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
Gte_F64_V(bool*, double*, double*, unsigned long):                   # @Gte_F64_V(bool*, double*, double*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB6_7
        cmpq    $16, %rcx
        jae     .LBB6_3
        xorl    %r8d, %r8d
        jmp     .LBB6_6
.LBB6_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI6_0(%rip), %xmm0           # xmm0 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdx,%rax,8), %ymm1
        vmovupd 32(%rdx,%rax,8), %ymm2
        vmovupd 64(%rdx,%rax,8), %ymm3
        vmovupd 96(%rdx,%rax,8), %ymm4
        vcmplepd        (%rsi,%rax,8), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpackssdw       %xmm1, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmplepd        32(%rsi,%rax,8), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmplepd        64(%rsi,%rax,8), %ymm3, %ymm3
        vpunpckldq      %xmm2, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
        vextractf128    $1, %ymm3, %xmm2
        vpackssdw       %xmm2, %xmm3, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmplepd        96(%rsi,%rax,8), %ymm4, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm0, %xmm3, %xmm3
        vpbroadcastd    %xmm3, %xmm3
        vpbroadcastd    %xmm2, %xmm2
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vpblendd        $12, %xmm2, %xmm1, %xmm1        # xmm1 = xmm1[0,1],xmm2[2,3]
        vmovdqu %xmm1, (%rdi,%rax)
        addq    $16, %rax
        cmpq    %rax, %r8
        jne     .LBB6_4
        cmpq    %rcx, %r8
        je      .LBB6_7
.LBB6_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vucomisd        (%rdx,%r8,8), %xmm0
        setae   (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB6_6
.LBB6_7:
        vzeroupper
        retq
.LCPI7_0:
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
Gte_F32_V(bool*, float*, float*, unsigned long):                   # @Gte_F32_V(bool*, float*, float*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB7_7
        cmpq    $32, %rcx
        jae     .LBB7_3
        xorl    %r8d, %r8d
        jmp     .LBB7_6
.LBB7_3:
        movq    %rcx, %r8
        andq    $-32, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI7_0(%rip), %xmm0           # xmm0 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdx,%rax,4), %ymm1
        vmovups 32(%rdx,%rax,4), %ymm2
        vmovups 64(%rdx,%rax,4), %ymm3
        vmovups 96(%rdx,%rax,4), %ymm4
        vcmpleps        (%rsi,%rax,4), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpleps        32(%rsi,%rax,4), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpleps        64(%rsi,%rax,4), %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm5
        vpackssdw       %xmm5, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpleps        96(%rsi,%rax,4), %ymm4, %ymm4
        vpand   %xmm0, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm0, %xmm4, %xmm4
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vinserti128     $1, %xmm2, %ymm1, %ymm1
        vpunpcklqdq     %ymm3, %ymm1, %ymm1     # ymm1 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
        vpermq  $216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
        vmovdqu %ymm1, (%rdi,%rax)
        addq    $32, %rax
        cmpq    %rax, %r8
        jne     .LBB7_4
        cmpq    %rcx, %r8
        je      .LBB7_7
.LBB7_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdx,%r8,4), %xmm0
        setae   (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB7_6
.LBB7_7:
        vzeroupper
        retq
.LCPI8_0:
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
Eq_F64_V(bool*, double*, double*, unsigned long):                    # @Eq_F64_V(bool*, double*, double*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB8_7
        cmpq    $16, %rcx
        jae     .LBB8_3
        xorl    %r8d, %r8d
        jmp     .LBB8_6
.LBB8_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI8_0(%rip), %xmm0           # xmm0 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB8_4:                                # =>This Inner Loop Header: Depth=1
        vmovupd (%rdx,%rax,8), %ymm1
        vmovupd 32(%rdx,%rax,8), %ymm2
        vmovupd 64(%rdx,%rax,8), %ymm3
        vmovupd 96(%rdx,%rax,8), %ymm4
        vcmpeqpd        (%rsi,%rax,8), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpackssdw       %xmm1, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpeqpd        32(%rsi,%rax,8), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpeqpd        64(%rsi,%rax,8), %ymm3, %ymm3
        vpunpckldq      %xmm2, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
        vextractf128    $1, %ymm3, %xmm2
        vpackssdw       %xmm2, %xmm3, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpeqpd        96(%rsi,%rax,8), %ymm4, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm0, %xmm3, %xmm3
        vpbroadcastd    %xmm3, %xmm3
        vpbroadcastd    %xmm2, %xmm2
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vpblendd        $12, %xmm2, %xmm1, %xmm1        # xmm1 = xmm1[0,1],xmm2[2,3]
        vmovdqu %xmm1, (%rdi,%rax)
        addq    $16, %rax
        cmpq    %rax, %r8
        jne     .LBB8_4
        cmpq    %rcx, %r8
        je      .LBB8_7
.LBB8_6:                                # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vucomisd        (%rdx,%r8,8), %xmm0
        sete    (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB8_6
.LBB8_7:
        vzeroupper
        retq
.LCPI9_0:
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
Eq_F32_V(bool*, float*, float*, unsigned long):                    # @Eq_F32_V(bool*, float*, float*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB9_7
        cmpq    $32, %rcx
        jae     .LBB9_3
        xorl    %r8d, %r8d
        jmp     .LBB9_6
.LBB9_3:
        movq    %rcx, %r8
        andq    $-32, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI9_0(%rip), %xmm0           # xmm0 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB9_4:                                # =>This Inner Loop Header: Depth=1
        vmovups (%rdx,%rax,4), %ymm1
        vmovups 32(%rdx,%rax,4), %ymm2
        vmovups 64(%rdx,%rax,4), %ymm3
        vmovups 96(%rdx,%rax,4), %ymm4
        vcmpeqps        (%rsi,%rax,4), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpeqps        32(%rsi,%rax,4), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpeqps        64(%rsi,%rax,4), %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm5
        vpackssdw       %xmm5, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpeqps        96(%rsi,%rax,4), %ymm4, %ymm4
        vpand   %xmm0, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm0, %xmm4, %xmm4
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vinserti128     $1, %xmm2, %ymm1, %ymm1
        vpunpcklqdq     %ymm3, %ymm1, %ymm1     # ymm1 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
        vpermq  $216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
        vmovdqu %ymm1, (%rdi,%rax)
        addq    $32, %rax
        cmpq    %rax, %r8
        jne     .LBB9_4
        cmpq    %rcx, %r8
        je      .LBB9_7
.LBB9_6:                                # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdx,%r8,4), %xmm0
        sete    (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB9_6
.LBB9_7:
        vzeroupper
        retq
.LCPI10_0:
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
Neq_F64_V(bool*, double*, double*, unsigned long):                   # @Neq_F64_V(bool*, double*, double*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB10_7
        cmpq    $16, %rcx
        jae     .LBB10_3
        xorl    %r8d, %r8d
        jmp     .LBB10_6
.LBB10_3:
        movq    %rcx, %r8
        andq    $-16, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI10_0(%rip), %xmm0          # xmm0 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB10_4:                               # =>This Inner Loop Header: Depth=1
        vmovupd (%rdx,%rax,8), %ymm1
        vmovupd 32(%rdx,%rax,8), %ymm2
        vmovupd 64(%rdx,%rax,8), %ymm3
        vmovupd 96(%rdx,%rax,8), %ymm4
        vcmpneqpd       (%rsi,%rax,8), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpackssdw       %xmm1, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpneqpd       32(%rsi,%rax,8), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpneqpd       64(%rsi,%rax,8), %ymm3, %ymm3
        vpunpckldq      %xmm2, %xmm1, %xmm1     # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
        vextractf128    $1, %ymm3, %xmm2
        vpackssdw       %xmm2, %xmm3, %xmm2
        vpackssdw       %xmm2, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpneqpd       96(%rsi,%rax,8), %ymm4, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm0, %xmm3, %xmm3
        vpbroadcastd    %xmm3, %xmm3
        vpbroadcastd    %xmm2, %xmm2
        vpunpckldq      %xmm3, %xmm2, %xmm2     # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
        vpblendd        $12, %xmm2, %xmm1, %xmm1        # xmm1 = xmm1[0,1],xmm2[2,3]
        vmovdqu %xmm1, (%rdi,%rax)
        addq    $16, %rax
        cmpq    %rax, %r8
        jne     .LBB10_4
        cmpq    %rcx, %r8
        je      .LBB10_7
.LBB10_6:                               # =>This Inner Loop Header: Depth=1
        vmovsd  (%rsi,%r8,8), %xmm0             # xmm0 = mem[0],zero
        vucomisd        (%rdx,%r8,8), %xmm0
        setne   (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB10_6
.LBB10_7:
        vzeroupper
        retq
.LCPI11_0:
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
Neq_F32_V(bool*, float*, float*, unsigned long):                   # @Neq_F32_V(bool*, float*, float*, unsigned long)
        testq   %rcx, %rcx
        je      .LBB11_7
        cmpq    $32, %rcx
        jae     .LBB11_3
        xorl    %r8d, %r8d
        jmp     .LBB11_6
.LBB11_3:
        movq    %rcx, %r8
        andq    $-32, %r8
        xorl    %eax, %eax
        vmovdqa .LCPI11_0(%rip), %xmm0          # xmm0 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB11_4:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rdx,%rax,4), %ymm1
        vmovups 32(%rdx,%rax,4), %ymm2
        vmovups 64(%rdx,%rax,4), %ymm3
        vmovups 96(%rdx,%rax,4), %ymm4
        vcmpneqps       (%rsi,%rax,4), %ymm1, %ymm1
        vextractf128    $1, %ymm1, %xmm5
        vpackssdw       %xmm5, %xmm1, %xmm1
        vpacksswb       %xmm1, %xmm1, %xmm1
        vcmpneqps       32(%rsi,%rax,4), %ymm2, %ymm2
        vpand   %xmm0, %xmm1, %xmm1
        vextractf128    $1, %ymm2, %xmm5
        vpackssdw       %xmm5, %xmm2, %xmm2
        vpacksswb       %xmm2, %xmm2, %xmm2
        vpand   %xmm0, %xmm2, %xmm2
        vcmpneqps       64(%rsi,%rax,4), %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm5
        vpackssdw       %xmm5, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpneqps       96(%rsi,%rax,4), %ymm4, %ymm4
        vpand   %xmm0, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm0, %xmm4, %xmm4
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vinserti128     $1, %xmm2, %ymm1, %ymm1
        vpunpcklqdq     %ymm3, %ymm1, %ymm1     # ymm1 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
        vpermq  $216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
        vmovdqu %ymm1, (%rdi,%rax)
        addq    $32, %rax
        cmpq    %rax, %r8
        jne     .LBB11_4
        cmpq    %rcx, %r8
        je      .LBB11_7
.LBB11_6:                               # =>This Inner Loop Header: Depth=1
        vmovss  (%rsi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
        vucomiss        (%rdx,%r8,4), %xmm0
        setne   (%rdi,%r8)
        addq    $1, %r8
        cmpq    %r8, %rcx
        jne     .LBB11_6
.LBB11_7:
        vzeroupper
        retq
.LCPI12_0:
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
LtNumber_F64_V(bool*, double*, double, unsigned long):               # @LtNumber_F64_V(bool*, double*, double, unsigned long)
        testq   %rdx, %rdx
        je      .LBB12_7
        cmpq    $16, %rdx
        jae     .LBB12_3
        xorl    %eax, %eax
        jmp     .LBB12_6
.LBB12_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI12_0(%rip), %xmm2          # xmm2 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB12_4:                               # =>This Inner Loop Header: Depth=1
        vmovupd (%rsi,%rcx,8), %ymm3
        vmovupd 32(%rsi,%rcx,8), %ymm4
        vmovupd 64(%rsi,%rcx,8), %ymm5
        vmovupd 96(%rsi,%rcx,8), %ymm6
        vcmpltpd        %ymm1, %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm7
        vpackssdw       %xmm7, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm2, %xmm3, %xmm3
        vcmpltpd        %ymm1, %ymm4, %ymm4
        vextractf128    $1, %ymm4, %xmm7
        vpackssdw       %xmm7, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vcmpltpd        %ymm1, %ymm5, %ymm4
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpltpd        %ymm1, %ymm6, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpackssdw       %xmm5, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vpbroadcastd    %xmm5, %xmm5
        vpbroadcastd    %xmm4, %xmm4
        vpunpckldq      %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
        vpblendd        $12, %xmm4, %xmm3, %xmm3        # xmm3 = xmm3[0,1],xmm4[2,3]
        vmovdqu %xmm3, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB12_4
        cmpq    %rdx, %rax
        je      .LBB12_7
.LBB12_6:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        seta    (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB12_6
.LBB12_7:
        vzeroupper
        retq
.LCPI13_0:
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
LtNumber_F32_V(bool*, float*, float, unsigned long):               # @LtNumber_F32_V(bool*, float*, float, unsigned long)
        testq   %rdx, %rdx
        je      .LBB13_7
        cmpq    $32, %rdx
        jae     .LBB13_3
        xorl    %eax, %eax
        jmp     .LBB13_6
.LBB13_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI13_0(%rip), %xmm2          # xmm2 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB13_4:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx,4), %ymm3
        vmovups 32(%rsi,%rcx,4), %ymm4
        vmovups 64(%rsi,%rcx,4), %ymm5
        vmovups 96(%rsi,%rcx,4), %ymm6
        vcmpltps        %ymm1, %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm7
        vpackssdw       %xmm7, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm2, %xmm3, %xmm3
        vcmpltps        %ymm1, %ymm4, %ymm4
        vextractf128    $1, %ymm4, %xmm7
        vpackssdw       %xmm7, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpltps        %ymm1, %ymm5, %ymm5
        vextractf128    $1, %ymm5, %xmm7
        vpackssdw       %xmm7, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vcmpltps        %ymm1, %ymm6, %ymm6
        vextractf128    $1, %ymm6, %xmm7
        vpackssdw       %xmm7, %xmm6, %xmm6
        vpacksswb       %xmm6, %xmm6, %xmm6
        vpand   %xmm2, %xmm6, %xmm6
        vinserti128     $1, %xmm6, %ymm5, %ymm5
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vpunpcklqdq     %ymm5, %ymm3, %ymm3     # ymm3 = ymm3[0],ymm5[0],ymm3[2],ymm5[2]
        vpermq  $216, %ymm3, %ymm3              # ymm3 = ymm3[0,2,1,3]
        vmovdqu %ymm3, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB13_4
        cmpq    %rdx, %rax
        je      .LBB13_7
.LBB13_6:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        seta    (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB13_6
.LBB13_7:
        vzeroupper
        retq
.LCPI14_0:
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
LteNumber_F64_V(bool*, double*, double, unsigned long):              # @LteNumber_F64_V(bool*, double*, double, unsigned long)
        testq   %rdx, %rdx
        je      .LBB14_7
        cmpq    $16, %rdx
        jae     .LBB14_3
        xorl    %eax, %eax
        jmp     .LBB14_6
.LBB14_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI14_0(%rip), %xmm2          # xmm2 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB14_4:                               # =>This Inner Loop Header: Depth=1
        vmovupd (%rsi,%rcx,8), %ymm3
        vmovupd 32(%rsi,%rcx,8), %ymm4
        vmovupd 64(%rsi,%rcx,8), %ymm5
        vmovupd 96(%rsi,%rcx,8), %ymm6
        vcmplepd        %ymm1, %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm7
        vpackssdw       %xmm7, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm2, %xmm3, %xmm3
        vcmplepd        %ymm1, %ymm4, %ymm4
        vextractf128    $1, %ymm4, %xmm7
        vpackssdw       %xmm7, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vcmplepd        %ymm1, %ymm5, %ymm4
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmplepd        %ymm1, %ymm6, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpackssdw       %xmm5, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vpbroadcastd    %xmm5, %xmm5
        vpbroadcastd    %xmm4, %xmm4
        vpunpckldq      %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
        vpblendd        $12, %xmm4, %xmm3, %xmm3        # xmm3 = xmm3[0,1],xmm4[2,3]
        vmovdqu %xmm3, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB14_4
        cmpq    %rdx, %rax
        je      .LBB14_7
.LBB14_6:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        setae   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB14_6
.LBB14_7:
        vzeroupper
        retq
.LCPI15_0:
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
LteNumber_F32_V(bool*, float*, float, unsigned long):              # @LteNumber_F32_V(bool*, float*, float, unsigned long)
        testq   %rdx, %rdx
        je      .LBB15_7
        cmpq    $32, %rdx
        jae     .LBB15_3
        xorl    %eax, %eax
        jmp     .LBB15_6
.LBB15_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI15_0(%rip), %xmm2          # xmm2 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB15_4:                               # =>This Inner Loop Header: Depth=1
        vmovups (%rsi,%rcx,4), %ymm3
        vmovups 32(%rsi,%rcx,4), %ymm4
        vmovups 64(%rsi,%rcx,4), %ymm5
        vmovups 96(%rsi,%rcx,4), %ymm6
        vcmpleps        %ymm1, %ymm3, %ymm3
        vextractf128    $1, %ymm3, %xmm7
        vpackssdw       %xmm7, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vpand   %xmm2, %xmm3, %xmm3
        vcmpleps        %ymm1, %ymm4, %ymm4
        vextractf128    $1, %ymm4, %xmm7
        vpackssdw       %xmm7, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpleps        %ymm1, %ymm5, %ymm5
        vextractf128    $1, %ymm5, %xmm7
        vpackssdw       %xmm7, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vcmpleps        %ymm1, %ymm6, %ymm6
        vextractf128    $1, %ymm6, %xmm7
        vpackssdw       %xmm7, %xmm6, %xmm6
        vpacksswb       %xmm6, %xmm6, %xmm6
        vpand   %xmm2, %xmm6, %xmm6
        vinserti128     $1, %xmm6, %ymm5, %ymm5
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vpunpcklqdq     %ymm5, %ymm3, %ymm3     # ymm3 = ymm3[0],ymm5[0],ymm3[2],ymm5[2]
        vpermq  $216, %ymm3, %ymm3              # ymm3 = ymm3[0,2,1,3]
        vmovdqu %ymm3, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB15_4
        cmpq    %rdx, %rax
        je      .LBB15_7
.LBB15_6:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        setae   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB15_6
.LBB15_7:
        vzeroupper
        retq
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
GtNumber_F64_V(bool*, double*, double, unsigned long):               # @GtNumber_F64_V(bool*, double*, double, unsigned long)
        testq   %rdx, %rdx
        je      .LBB16_7
        cmpq    $16, %rdx
        jae     .LBB16_3
        xorl    %eax, %eax
        jmp     .LBB16_6
.LBB16_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI16_0(%rip), %xmm2          # xmm2 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB16_4:                               # =>This Inner Loop Header: Depth=1
        vcmpltpd        (%rsi,%rcx,8), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpltpd        32(%rsi,%rcx,8), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpltpd        64(%rsi,%rcx,8), %ymm1, %ymm5
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vextractf128    $1, %ymm5, %xmm4
        vpackssdw       %xmm4, %xmm5, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpltpd        96(%rsi,%rcx,8), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpackssdw       %xmm5, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vpbroadcastd    %xmm5, %xmm5
        vpbroadcastd    %xmm4, %xmm4
        vpunpckldq      %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
        vpblendd        $12, %xmm4, %xmm3, %xmm3        # xmm3 = xmm3[0,1],xmm4[2,3]
        vmovdqu %xmm3, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB16_4
        cmpq    %rdx, %rax
        je      .LBB16_7
.LBB16_6:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        setb    (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB16_6
.LBB16_7:
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
GtNumber_F32_V(bool*, float*, float, unsigned long):               # @GtNumber_F32_V(bool*, float*, float, unsigned long)
        testq   %rdx, %rdx
        je      .LBB17_7
        cmpq    $32, %rdx
        jae     .LBB17_3
        xorl    %eax, %eax
        jmp     .LBB17_6
.LBB17_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI17_0(%rip), %xmm2          # xmm2 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB17_4:                               # =>This Inner Loop Header: Depth=1
        vcmpltps        (%rsi,%rcx,4), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpltps        32(%rsi,%rcx,4), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpltps        64(%rsi,%rcx,4), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vcmpltps        96(%rsi,%rcx,4), %ymm1, %ymm6
        vpand   %xmm2, %xmm5, %xmm5
        vextractf128    $1, %ymm6, %xmm7
        vpackssdw       %xmm7, %xmm6, %xmm6
        vpacksswb       %xmm6, %xmm6, %xmm6
        vpand   %xmm2, %xmm6, %xmm6
        vinserti128     $1, %xmm6, %ymm5, %ymm5
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vpunpcklqdq     %ymm5, %ymm3, %ymm3     # ymm3 = ymm3[0],ymm5[0],ymm3[2],ymm5[2]
        vpermq  $216, %ymm3, %ymm3              # ymm3 = ymm3[0,2,1,3]
        vmovdqu %ymm3, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB17_4
        cmpq    %rdx, %rax
        je      .LBB17_7
.LBB17_6:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        setb    (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB17_6
.LBB17_7:
        vzeroupper
        retq
.LCPI18_0:
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
GteNumber_F64_V(bool*, double*, double, unsigned long):              # @GteNumber_F64_V(bool*, double*, double, unsigned long)
        testq   %rdx, %rdx
        je      .LBB18_7
        cmpq    $16, %rdx
        jae     .LBB18_3
        xorl    %eax, %eax
        jmp     .LBB18_6
.LBB18_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI18_0(%rip), %xmm2          # xmm2 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB18_4:                               # =>This Inner Loop Header: Depth=1
        vcmplepd        (%rsi,%rcx,8), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmplepd        32(%rsi,%rcx,8), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmplepd        64(%rsi,%rcx,8), %ymm1, %ymm5
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vextractf128    $1, %ymm5, %xmm4
        vpackssdw       %xmm4, %xmm5, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmplepd        96(%rsi,%rcx,8), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpackssdw       %xmm5, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vpbroadcastd    %xmm5, %xmm5
        vpbroadcastd    %xmm4, %xmm4
        vpunpckldq      %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
        vpblendd        $12, %xmm4, %xmm3, %xmm3        # xmm3 = xmm3[0,1],xmm4[2,3]
        vmovdqu %xmm3, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB18_4
        cmpq    %rdx, %rax
        je      .LBB18_7
.LBB18_6:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        setbe   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB18_6
.LBB18_7:
        vzeroupper
        retq
.LCPI19_0:
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
GteNumber_F32_V(bool*, float*, float, unsigned long):              # @GteNumber_F32_V(bool*, float*, float, unsigned long)
        testq   %rdx, %rdx
        je      .LBB19_7
        cmpq    $32, %rdx
        jae     .LBB19_3
        xorl    %eax, %eax
        jmp     .LBB19_6
.LBB19_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI19_0(%rip), %xmm2          # xmm2 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB19_4:                               # =>This Inner Loop Header: Depth=1
        vcmpleps        (%rsi,%rcx,4), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpleps        32(%rsi,%rcx,4), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpleps        64(%rsi,%rcx,4), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vcmpleps        96(%rsi,%rcx,4), %ymm1, %ymm6
        vpand   %xmm2, %xmm5, %xmm5
        vextractf128    $1, %ymm6, %xmm7
        vpackssdw       %xmm7, %xmm6, %xmm6
        vpacksswb       %xmm6, %xmm6, %xmm6
        vpand   %xmm2, %xmm6, %xmm6
        vinserti128     $1, %xmm6, %ymm5, %ymm5
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vpunpcklqdq     %ymm5, %ymm3, %ymm3     # ymm3 = ymm3[0],ymm5[0],ymm3[2],ymm5[2]
        vpermq  $216, %ymm3, %ymm3              # ymm3 = ymm3[0,2,1,3]
        vmovdqu %ymm3, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB19_4
        cmpq    %rdx, %rax
        je      .LBB19_7
.LBB19_6:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        setbe   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB19_6
.LBB19_7:
        vzeroupper
        retq
.LCPI20_0:
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
EqNumber_F64_V(bool*, double*, double, unsigned long):               # @EqNumber_F64_V(bool*, double*, double, unsigned long)
        testq   %rdx, %rdx
        je      .LBB20_7
        cmpq    $16, %rdx
        jae     .LBB20_3
        xorl    %eax, %eax
        jmp     .LBB20_6
.LBB20_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI20_0(%rip), %xmm2          # xmm2 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB20_4:                               # =>This Inner Loop Header: Depth=1
        vcmpeqpd        (%rsi,%rcx,8), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpeqpd        32(%rsi,%rcx,8), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpeqpd        64(%rsi,%rcx,8), %ymm1, %ymm5
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vextractf128    $1, %ymm5, %xmm4
        vpackssdw       %xmm4, %xmm5, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpeqpd        96(%rsi,%rcx,8), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpackssdw       %xmm5, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vpbroadcastd    %xmm5, %xmm5
        vpbroadcastd    %xmm4, %xmm4
        vpunpckldq      %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
        vpblendd        $12, %xmm4, %xmm3, %xmm3        # xmm3 = xmm3[0,1],xmm4[2,3]
        vmovdqu %xmm3, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB20_4
        cmpq    %rdx, %rax
        je      .LBB20_7
.LBB20_6:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        sete    (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB20_6
.LBB20_7:
        vzeroupper
        retq
.LCPI21_0:
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
EqNumber_F32_V(bool*, float*, float, unsigned long):               # @EqNumber_F32_V(bool*, float*, float, unsigned long)
        testq   %rdx, %rdx
        je      .LBB21_7
        cmpq    $32, %rdx
        jae     .LBB21_3
        xorl    %eax, %eax
        jmp     .LBB21_6
.LBB21_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI21_0(%rip), %xmm2          # xmm2 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB21_4:                               # =>This Inner Loop Header: Depth=1
        vcmpeqps        (%rsi,%rcx,4), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpeqps        32(%rsi,%rcx,4), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpeqps        64(%rsi,%rcx,4), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vcmpeqps        96(%rsi,%rcx,4), %ymm1, %ymm6
        vpand   %xmm2, %xmm5, %xmm5
        vextractf128    $1, %ymm6, %xmm7
        vpackssdw       %xmm7, %xmm6, %xmm6
        vpacksswb       %xmm6, %xmm6, %xmm6
        vpand   %xmm2, %xmm6, %xmm6
        vinserti128     $1, %xmm6, %ymm5, %ymm5
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vpunpcklqdq     %ymm5, %ymm3, %ymm3     # ymm3 = ymm3[0],ymm5[0],ymm3[2],ymm5[2]
        vpermq  $216, %ymm3, %ymm3              # ymm3 = ymm3[0,2,1,3]
        vmovdqu %ymm3, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB21_4
        cmpq    %rdx, %rax
        je      .LBB21_7
.LBB21_6:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        sete    (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB21_6
.LBB21_7:
        vzeroupper
        retq
.LCPI22_0:
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
NeqNumber_F64_V(bool*, double*, double, unsigned long):              # @NeqNumber_F64_V(bool*, double*, double, unsigned long)
        testq   %rdx, %rdx
        je      .LBB22_7
        cmpq    $16, %rdx
        jae     .LBB22_3
        xorl    %eax, %eax
        jmp     .LBB22_6
.LBB22_3:
        movq    %rdx, %rax
        andq    $-16, %rax
        vbroadcastsd    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI22_0(%rip), %xmm2          # xmm2 = <1,1,1,1,u,u,u,u,u,u,u,u,u,u,u,u>
.LBB22_4:                               # =>This Inner Loop Header: Depth=1
        vcmpneqpd       (%rsi,%rcx,8), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpackssdw       %xmm3, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpneqpd       32(%rsi,%rcx,8), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpneqpd       64(%rsi,%rcx,8), %ymm1, %ymm5
        vpunpckldq      %xmm4, %xmm3, %xmm3     # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
        vextractf128    $1, %ymm5, %xmm4
        vpackssdw       %xmm4, %xmm5, %xmm4
        vpackssdw       %xmm4, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpneqpd       96(%rsi,%rcx,8), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpackssdw       %xmm5, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vpand   %xmm2, %xmm5, %xmm5
        vpbroadcastd    %xmm5, %xmm5
        vpbroadcastd    %xmm4, %xmm4
        vpunpckldq      %xmm5, %xmm4, %xmm4     # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
        vpblendd        $12, %xmm4, %xmm3, %xmm3        # xmm3 = xmm3[0,1],xmm4[2,3]
        vmovdqu %xmm3, (%rdi,%rcx)
        addq    $16, %rcx
        cmpq    %rcx, %rax
        jne     .LBB22_4
        cmpq    %rdx, %rax
        je      .LBB22_7
.LBB22_6:                               # =>This Inner Loop Header: Depth=1
        vucomisd        (%rsi,%rax,8), %xmm0
        setne   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB22_6
.LBB22_7:
        vzeroupper
        retq
.LCPI23_0:
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
NeqNumber_F32_V(bool*, float*, float, unsigned long):              # @NeqNumber_F32_V(bool*, float*, float, unsigned long)
        testq   %rdx, %rdx
        je      .LBB23_7
        cmpq    $32, %rdx
        jae     .LBB23_3
        xorl    %eax, %eax
        jmp     .LBB23_6
.LBB23_3:
        movq    %rdx, %rax
        andq    $-32, %rax
        vbroadcastss    %xmm0, %ymm1
        xorl    %ecx, %ecx
        vmovdqa .LCPI23_0(%rip), %xmm2          # xmm2 = <1,1,1,1,1,1,1,1,u,u,u,u,u,u,u,u>
.LBB23_4:                               # =>This Inner Loop Header: Depth=1
        vcmpneqps       (%rsi,%rcx,4), %ymm1, %ymm3
        vextractf128    $1, %ymm3, %xmm4
        vpackssdw       %xmm4, %xmm3, %xmm3
        vpacksswb       %xmm3, %xmm3, %xmm3
        vcmpneqps       32(%rsi,%rcx,4), %ymm1, %ymm4
        vpand   %xmm2, %xmm3, %xmm3
        vextractf128    $1, %ymm4, %xmm5
        vpackssdw       %xmm5, %xmm4, %xmm4
        vpacksswb       %xmm4, %xmm4, %xmm4
        vpand   %xmm2, %xmm4, %xmm4
        vcmpneqps       64(%rsi,%rcx,4), %ymm1, %ymm5
        vextractf128    $1, %ymm5, %xmm6
        vpackssdw       %xmm6, %xmm5, %xmm5
        vpacksswb       %xmm5, %xmm5, %xmm5
        vcmpneqps       96(%rsi,%rcx,4), %ymm1, %ymm6
        vpand   %xmm2, %xmm5, %xmm5
        vextractf128    $1, %ymm6, %xmm7
        vpackssdw       %xmm7, %xmm6, %xmm6
        vpacksswb       %xmm6, %xmm6, %xmm6
        vpand   %xmm2, %xmm6, %xmm6
        vinserti128     $1, %xmm6, %ymm5, %ymm5
        vinserti128     $1, %xmm4, %ymm3, %ymm3
        vpunpcklqdq     %ymm5, %ymm3, %ymm3     # ymm3 = ymm3[0],ymm5[0],ymm3[2],ymm5[2]
        vpermq  $216, %ymm3, %ymm3              # ymm3 = ymm3[0,2,1,3]
        vmovdqu %ymm3, (%rdi,%rcx)
        addq    $32, %rcx
        cmpq    %rcx, %rax
        jne     .LBB23_4
        cmpq    %rdx, %rax
        je      .LBB23_7
.LBB23_6:                               # =>This Inner Loop Header: Depth=1
        vucomiss        (%rsi,%rax,4), %xmm0
        setne   (%rdi,%rax)
        addq    $1, %rax
        cmpq    %rax, %rdx
        jne     .LBB23_6
.LBB23_7:
        vzeroupper
        retq