package vek

import (
	"github.com/viterin/vek/internal/functions"
	"golang.org/x/sys/cpu"
	"runtime"
)

var cpuFeatures = map[string]bool{
	"AES":              cpu.X86.HasAES,              // AES hardware implementation (AES NI)
	"ADX":              cpu.X86.HasADX,              // Multi-precision add-carry instruction extensions
	"AVX":              cpu.X86.HasAVX,              // Advanced vector extension
	"AVX2":             cpu.X86.HasAVX2,             // Advanced vector extension 2
	"AVX512":           cpu.X86.HasAVX512,           // Advanced vector extension 512
	"AVX512F":          cpu.X86.HasAVX512F,          // Advanced vector extension 512 Foundation Instructions
	"AVX512CD":         cpu.X86.HasAVX512CD,         // Advanced vector extension 512 Conflict Detection Instructions
	"AVX512ER":         cpu.X86.HasAVX512ER,         // Advanced vector extension 512 Exponential and Reciprocal Instructions
	"AVX512PF":         cpu.X86.HasAVX512PF,         // Advanced vector extension 512 Prefetch Instructions Instructions
	"AVX512VL":         cpu.X86.HasAVX512VL,         // Advanced vector extension 512 Vector Length Extensions
	"AVX512BW":         cpu.X86.HasAVX512BW,         // Advanced vector extension 512 Byte and Word Instructions
	"AVX512DQ":         cpu.X86.HasAVX512DQ,         // Advanced vector extension 512 Doubleword and Quadword Instructions
	"AVX512IFMA":       cpu.X86.HasAVX512IFMA,       // Advanced vector extension 512 Integer Fused Multiply Add
	"AVX512VBMI":       cpu.X86.HasAVX512VBMI,       // Advanced vector extension 512 Vector Byte Manipulation Instructions
	"AVX5124VNNIW":     cpu.X86.HasAVX5124VNNIW,     // Advanced vector extension 512 Vector Neural Network Instructions Word variable precision
	"AVX5124FMAPS":     cpu.X86.HasAVX5124FMAPS,     // Advanced vector extension 512 Fused Multiply Accumulation Packed Single precision
	"AVX512VPOPCNTDQ":  cpu.X86.HasAVX512VPOPCNTDQ,  // Advanced vector extension 512 Double and quad word population count instructions
	"AVX512VPCLMULQDQ": cpu.X86.HasAVX512VPCLMULQDQ, // Advanced vector extension 512 Vector carry-less multiply operations
	"AVX512VNNI":       cpu.X86.HasAVX512VNNI,       // Advanced vector extension 512 Vector Neural Network Instructions
	"AVX512GFNI":       cpu.X86.HasAVX512GFNI,       // Advanced vector extension 512 Galois field New Instructions
	"AVX512VAES":       cpu.X86.HasAVX512VAES,       // Advanced vector extension 512 Vector AES instructions
	"AVX512VBMI2":      cpu.X86.HasAVX512VBMI2,      // Advanced vector extension 512 Vector Byte Manipulation Instructions 2
	"AVX512BITALG":     cpu.X86.HasAVX512BITALG,     // Advanced vector extension 512 Bit Algorithms
	"AVX512BF16":       cpu.X86.HasAVX512BF16,       // Advanced vector extension 512 BFloat16 Instructions
	"BMI1":             cpu.X86.HasBMI1,             // Bit manipulation instruction set 1
	"BMI2":             cpu.X86.HasBMI2,             // Bit manipulation instruction set 2
	"CX16":             cpu.X86.HasCX16,             // Compare and exchange 16 Bytes
	"ERMS":             cpu.X86.HasERMS,             // Enhanced REP for MOVSB and STOSB
	"FMA":              cpu.X86.HasFMA,              // Fused-multiply-add instructions
	"OSXSAVE":          cpu.X86.HasOSXSAVE,          // OS supports XSAVE/XRESTOR for saving/restoring XMM registers.
	"PCLMULQDQ":        cpu.X86.HasPCLMULQDQ,        // PCLMULQDQ instruction - most often used for AES-GCM
	"POPCNT":           cpu.X86.HasPOPCNT,           // Hamming weight instruction POPCNT.
	"RDRAND":           cpu.X86.HasRDRAND,           // RDRAND instruction (on-chip random number generator)
	"RDSEED":           cpu.X86.HasRDSEED,           // RDSEED instruction (on-chip random number generator)
	"SSE2":             cpu.X86.HasSSE2,             // Streaming SIMD extension 2 (always available on amd64)
	"SSE3":             cpu.X86.HasSSE3,             // Streaming SIMD extension 3
	"SSSE3":            cpu.X86.HasSSSE3,            // Supplemental streaming SIMD extension 3
	"SSE41":            cpu.X86.HasSSE41,            // Streaming SIMD extension 4 and 4.1
	"SSE42":            cpu.X86.HasSSE42,            // Streaming SIMD extension 4 and 4.2
}

type SystemInfo struct {
	CPUArchitecture string
	CPUFeatures     []string
	Acceleration    bool
}

// Info returns information about the current operating environment.
func Info() SystemInfo {
	var features []string
	for k, v := range cpuFeatures {
		if v {
			features = append(features, k)
		}
	}

	return SystemInfo{
		CPUArchitecture: runtime.GOARCH,
		CPUFeatures:     features,
		Acceleration:    functions.UseAVX2,
	}
}
