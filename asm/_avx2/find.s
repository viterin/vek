Find_F64(double*, double, unsigned long):                        # @Find_F64(double*, double, unsigned long)
        movq    %rsi, %rcx
        andq    $-8, %rcx
        je      .LBB0_1
        vpbroadcastq    %xmm0, %ymm1
        xorl    %eax, %eax
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
        vpcmpeqq        (%rdi,%rax,8), %ymm1, %ymm2
        vpcmpeqq        32(%rdi,%rax,8), %ymm1, %ymm3
        vpor    %ymm2, %ymm3, %ymm4
        vptest  %ymm4, %ymm4
        jne     .LBB0_8
        addq    $8, %rax
        cmpq    %rcx, %rax
        jb      .LBB0_7
        cmpq    %rsi, %rax
        jb      .LBB0_3
.LBB0_9:
        vzeroupper
        retq
.LBB0_1:
        xorl    %eax, %eax
        cmpq    %rsi, %rax
        jae     .LBB0_9
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
        vucomisd        (%rdi,%rax,8), %xmm0
        je      .LBB0_9
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB0_3
        movq    %rsi, %rax
        vzeroupper
        retq
.LBB0_8:
        vmovmskpd       %ymm3, %ecx
        shll    $4, %ecx
        vmovmskpd       %ymm2, %edx
        orl     %ecx, %edx
        bsfl    %edx, %ecx
        addq    %rcx, %rax
        vzeroupper
        retq
Find_F32(float*, float, unsigned long):                        # @Find_F32(float*, float, unsigned long)
        movq    %rsi, %rcx
        andq    $-16, %rcx
        je      .LBB1_1
        vpbroadcastd    %xmm0, %ymm1
        xorl    %eax, %eax
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
        vpcmpeqd        (%rdi,%rax,4), %ymm1, %ymm2
        vpcmpeqd        32(%rdi,%rax,4), %ymm1, %ymm3
        vpor    %ymm2, %ymm3, %ymm4
        vptest  %ymm4, %ymm4
        jne     .LBB1_8
        addq    $16, %rax
        cmpq    %rcx, %rax
        jb      .LBB1_7
        cmpq    %rsi, %rax
        jb      .LBB1_3
.LBB1_9:
        vzeroupper
        retq
.LBB1_1:
        xorl    %eax, %eax
        cmpq    %rsi, %rax
        jae     .LBB1_9
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
        vucomiss        (%rdi,%rax,4), %xmm0
        je      .LBB1_9
        addq    $1, %rax
        cmpq    %rax, %rsi
        jne     .LBB1_3
        movq    %rsi, %rax
        vzeroupper
        retq
.LBB1_8:
        vmovmskps       %ymm3, %ecx
        shll    $8, %ecx
        vmovmskps       %ymm2, %edx
        orl     %ecx, %edx
        bsfl    %edx, %ecx
        addq    %rcx, %rax
        vzeroupper
        retq
