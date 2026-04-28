/*
 * Fused mul_mat for TQ4_1S / TQ3_1S weight types.
 *
 * ne[1]≤8: dp4a multi-token kernel (weight reuse across tokens)
 * ne[1]>8: runtime TQ4_1S→q8_0 scratch + cuBLAS tensor core GEMM
 */

#include "mmvq-tq.cuh"
#include "turbo-quant.cuh"
#include "convert.cuh"

#define MMVQ_TQ_NWARPS 4

// ============================================================================
// Pre-rotate activation to q8_1 format (for TQ4_1S dp4a path)
// ============================================================================

