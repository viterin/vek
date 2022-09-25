package functions

import "golang.org/x/sys/cpu"

var UseAVX2 bool = cpu.X86.HasAVX2 && cpu.X86.HasFMA
