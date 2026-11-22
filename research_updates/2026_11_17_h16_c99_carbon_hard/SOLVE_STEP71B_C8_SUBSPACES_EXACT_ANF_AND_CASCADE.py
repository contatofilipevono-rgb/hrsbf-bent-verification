#!/usr/bin/env python3
r"""
SOLVE_STEP71B_C8_SUBSPACES_EXACT_ANF_AND_CASCADE.py
===================================================
PURE-THEORETICAL BREAKTHROUGH FOLLOW-UP TO STEP 71A T2!

Step 71A T2 proved that the SINGLE untwisted C_8-invariant even/odd split E_8 (+) O_8
produces **+16 BRAND-NEW DEGREE-<=3 EQUATIONS OUTSIDE CG(389) AT ROOT N=109** on ALL THREE
cells (B0_00, B0_11, B1_11) — breaking the 70-step degree-3 saturation barrier!

Here we systematically harvest ALL C_8-invariant 8-dim subspaces & symmetric twists:
  1. ALL 36 C_8-orbit-inequivalent graph subspaces V_p = {(u_e, (p * u)_o)} (p in 36 C_8-orbits;
     p=0 is E_8, p=1 is adjacent-pair diagonal, etc.) — ALL share the exact 36x36 C_8-Walsh
     kernel K_{E8} and ALL 66 ZT-verified mod-16/32/64 syzygies + Parseval!
  2. ALL 8 mixed uniserial C_8-subspaces U_k = M_k(E_8) (+) M_{8-k}(O_8) (k=0..7; k=0 is O_8,
     k=4 is D_8, k=1,2,3,5,6,7 are brand-new C_8-invariant 8-dim subspaces!).
  3. Symmetric twists gamma in {0xFF (d=1), 0x55 (d=2), 0x11, 0x33, 0x77 (d=4)} on E_8!

ZERO-TRUST PROTOCOL (100% AIRTIGHT):
  - Every subspace V and every syzygy u^T S^{(V)} == c0 (mod 2^{k+1}) is verified on BOTH real
    C16-RSB bent functions (quad_b1, quad_d1) with 0 mismatches BEFORE touching H(16,4)!
  - Every surviving deg<=3 equation at ROOT N=109 is extracted to its EXACT symbolic deg<=3 ANF
    via fast OpenMP C Mobius transform on all 1+N+C(N,2)+C(N,3) = 215,930 wt<=3 points, AND
    Zero-Trust verified against direct 65,536-pt truth-table evaluation on 256 independent random
    root points (asserting 0 mismatches!)!
  - ALL Zero-Trust verified deg<=3 ANF equations are then INJECTED into CG(389) at ROOT N=109
    via s9.run_branch_cascade (IR6), and tested at ROOT AND on ALL representative eta-orbits
    for linear/quadratic cascades, N-drop, and direct 1=0 closure!
"""

import argparse
import ctypes
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP65A_ALL4116_WALSH_2ADIC_AND_INTEGER_SPECTRUM as s65a
import SOLVE_STEP66_ALL36_TWISTED_D8_DUALS as s66
import SOLVE_STEP71A_THEORETICAL_FRONTIERS as s71a


# ==============================================================================
# Ultra-Fast OpenMP C Engine:
#   1. Batch-evaluate S_a^{(V)} (36 or m coset reps x 256 pts) on B points in root affine space!
#   2. Exact deg<=3 ANF extraction via direct wt<=3 evaluation + Mobius inversion (OpenMP)!
# ==============================================================================

C_STEP71B_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

// Fast bitset parity evaluation of a truth table subset of 256 points (4 uint64 words!)
// For a subspace V with M_cos coset reps, each coset has 256 points (packed as 4 uint64 words).
// Actually we pre-pack the truth table of base_tt and basis_u8[N] RESTRICTED to the M_cos*256 points
// of this subspace! Each coset is 4 uint64 words (256 bits) -> popcount of 4 words takes ~4 ns!!
//
// Packed layout:
//   base_sub [M_cos * 4]         (uint64)
//   basis_sub[N * M_cos * 4]     (uint64)
//   pts_lo[P], pts_hi[P]         (uint64 masks of N <= 111 active vars)
//   twist_mask[4]                (uint64: bit u is 1 if gamma.u == 1, else 0; 0 for untwisted!)
// Output:
//   out_S[P * M_cos] (int32): for each point p and coset c,
//     S = sum_{u=0}^{255} (-1)^{f(x_{c,u}) ^ (gamma.u)} = 256 - 2 * popcount(tt ^ twist_mask)!
void eval_subspace_S_batch_c(
    int N, int M_cos, int P,
    const uint64_t *base_sub,    // [M_cos * 4]
    const uint64_t *basis_sub,   // [N * M_cos * 4]
    const uint64_t *twist_mask,  // [4]
    const uint64_t *pts_lo,      // [P]
    const uint64_t *pts_hi,      // [P]
    int32_t *out_S               // [P * M_cos]
) {
    int stride = M_cos * 4;
    #pragma omp parallel for schedule(static)
    for (int p = 0; p < P; p++) {
        uint64_t lo = pts_lo[p], hi = pts_hi[p];
        uint64_t *buf = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        memcpy(buf, base_sub, (size_t)stride * sizeof(uint64_t));
        uint64_t m = lo;
        while (m) {
            int k = __builtin_ctzll(m);
            const uint64_t *bk = basis_sub + (size_t)k * stride;
            for (int w = 0; w < stride; w++) buf[w] ^= bk[w];
            m &= m - 1;
        }
        m = hi;
        while (m) {
            int k = 64 + __builtin_ctzll(m);
            const uint64_t *bk = basis_sub + (size_t)k * stride;
            for (int w = 0; w < stride; w++) buf[w] ^= bk[w];
            m &= m - 1;
        }
        int32_t *dst = out_S + (size_t)p * M_cos;
        uint64_t t0 = twist_mask[0], t1 = twist_mask[1], t2 = twist_mask[2], t3 = twist_mask[3];
        for (int c = 0; c < M_cos; c++) {
            const uint64_t *cw = buf + (size_t)c * 4;
            int pop = __builtin_popcountll(cw[0] ^ t0)
                    + __builtin_popcountll(cw[1] ^ t1)
                    + __builtin_popcountll(cw[2] ^ t2)
                    + __builtin_popcountll(cw[3] ^ t3);
            dst[c] = 256 - 2 * pop;
        }
        free(buf);
    }
}

// Ultra-fast exact evaluation of K syzygy bit-equations (all from ONE subspace V!) on ALL
// 1 + N + C(N,2) + C(N,3) wt<=3 points, followed by exact Mobius inversion to extract deg<=3 ANF!
//
// Pre-grouped syzygies for this subspace V:
//   syz_u[K * M_cos] (int32), syz_c0[K] (int32), syz_shift[K] (int32: v2_min bit to extract!)
//   Also supports is_parseval[K] (if 1, evaluates sum_c orb_sz[c] * S[c]^2 - 65536 instead of u^T S - c0!)
// Output:
//   out_anf[K * n_mon_words] (uint64) where monomial index matches:
//     0: const
//     1..N: i
//     1+N .. 1+N+C(N,2)-1: (i<j) lex
//     1+N+C(N,2) .. n_mon-1: (i<j<k) lex
void extract_subspace_deg3_anf_c(
    int N, int M_cos, int K,
    const uint64_t *base_sub,
    const uint64_t *basis_sub,
    const uint64_t *twist_mask,
    const int32_t *syz_u,        // [K * M_cos]
    const int32_t *syz_c0,       // [K]
    const int32_t *syz_shift,    // [K]
    const uint8_t *is_parseval,  // [K]
    const int32_t *orb_sz,       // [M_cos]
    uint64_t *out_anf            // [K * n_mon_words]
) {
    int stride = M_cos * 4;
    int n1 = N;
    int n2 = N * (N - 1) / 2;
    int n3 = N * (N - 1) * (N - 2) / 6;
    int n_mon = 1 + n1 + n2 + n3;
    int n_words = (n_mon + 63) / 64;
    memset(out_anf, 0, (size_t)K * n_words * sizeof(uint64_t));

    // Precompute pair offset table for fast lookup of (i, j)
    int *p_off = (int *)malloc((size_t)N * N * sizeof(int));
    {
        int p = 0;
        for (int i = 0; i < N; i++)
            for (int j = i + 1; j < N; j++)
                p_off[i * N + j] = p++;
    }
    // Precompute triple offset for each i
    int *t_i_off = (int *)malloc((size_t)(N + 1) * sizeof(int));
    {
        int t = 0;
        for (int i = 0; i < N; i++) {
            t_i_off[i] = t;
            int rem = N - 1 - i;
            t += rem * (rem - 1) / 2;
        }
        t_i_off[N] = t;
    }

    uint64_t t0 = twist_mask[0], t1 = twist_mask[1], t2 = twist_mask[2], t3 = twist_mask[3];

    // Helper macro to evaluate K bits from buf[stride] into dst_bits[K]
    #define EVAL_K_BITS(BUF_PTR, DST_ARR) do { \
        int32_t S_loc[256]; \
        for (int c = 0; c < M_cos; c++) { \
            const uint64_t *cw = (BUF_PTR) + (size_t)c * 4; \
            int pop = __builtin_popcountll(cw[0] ^ t0) + __builtin_popcountll(cw[1] ^ t1) \
                    + __builtin_popcountll(cw[2] ^ t2) + __builtin_popcountll(cw[3] ^ t3); \
            S_loc[c] = 256 - 2 * pop; \
        } \
        int64_t pars_res = 0; \
        int pars_done = 0; \
        for (int ki = 0; ki < K; ki++) { \
            int64_t val = 0; \
            if (is_parseval[ki]) { \
                if (!pars_done) { \
                    int64_t s2 = 0; \
                    for (int c = 0; c < M_cos; c++) s2 += (int64_t)orb_sz[c] * (int64_t)S_loc[c] * (int64_t)S_loc[c]; \
                    pars_res = s2 - 65536LL; \
                    pars_done = 1; \
                } \
                val = pars_res; \
            } else { \
                const int32_t *uk = syz_u + (size_t)ki * M_cos; \
                for (int c = 0; c < M_cos; c++) if (uk[c]) val += (int64_t)uk[c] * (int64_t)S_loc[c]; \
                val -= (int64_t)syz_c0[ki]; \
            } \
            (DST_ARR)[ki] = (uint8_t)((val >> syz_shift[ki]) & 1LL); \
        } \
    } while(0)

    // 1. Constant f(0) -> c0[K]
    uint8_t *c0 = (uint8_t *)malloc((size_t)K);
    EVAL_K_BITS(base_sub, c0);
    for (int ki = 0; ki < K; ki++) if (c0[ki]) out_anf[(size_t)ki * n_words + 0] |= 1ULL;

    // 2. Weight-1 f(e_i) -> c1[N * K]
    uint8_t *c1 = (uint8_t *)malloc((size_t)N * K);
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
        uint64_t *buf = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        const uint64_t *bi = basis_sub + (size_t)i * stride;
        for (int w = 0; w < stride; w++) buf[w] = base_sub[w] ^ bi[w];
        uint8_t *fi = c1 + (size_t)i * K;
        EVAL_K_BITS(buf, fi);
        for (int ki = 0; ki < K; ki++) fi[ki] ^= c0[ki];
        free(buf);
    }
    for (int i = 0; i < N; i++) {
        int col = 1 + i;
        for (int ki = 0; ki < K; ki++)
            if (c1[(size_t)i * K + ki]) out_anf[(size_t)ki * n_words + (col >> 6)] |= (1ULL << (col & 63));
    }

    // 3. Weight-2 f(e_i + e_j) -> c2[n2 * K]
    uint8_t *c2 = (uint8_t *)malloc((size_t)n2 * K);
    #pragma omp parallel for schedule(dynamic, 2)
    for (int i = 0; i < N; i++) {
        uint64_t *buf_i = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        uint64_t *buf_ij = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        const uint64_t *bi = basis_sub + (size_t)i * stride;
        for (int w = 0; w < stride; w++) buf_i[w] = base_sub[w] ^ bi[w];
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_sub + (size_t)j * stride;
            for (int w = 0; w < stride; w++) buf_ij[w] = buf_i[w] ^ bj[w];
            int pidx = p_off[i * N + j];
            uint8_t *fij = c2 + (size_t)pidx * K;
            EVAL_K_BITS(buf_ij, fij);
            for (int ki = 0; ki < K; ki++)
                fij[ki] ^= c0[ki] ^ c1[(size_t)i * K + ki] ^ c1[(size_t)j * K + ki];
        }
        free(buf_i);
        free(buf_ij);
    }
    for (int p = 0; p < n2; p++) {
        int col = 1 + n1 + p;
        for (int ki = 0; ki < K; ki++)
            if (c2[(size_t)p * K + ki]) out_anf[(size_t)ki * n_words + (col >> 6)] |= (1ULL << (col & 63));
    }

    // 4. Weight-3 f(e_i + e_j + e_k) -> write directly into thread-local or synchronized out_anf!
    //    Parallelize over i; each i owns disjoint columns [1+n1+n2+t_i_off[i] .. t_i_off[i+1]),
    //    Wait: words may overlap across i boundaries! So collect bit-flags in flat uint8 c3 or
    //    use a per-i output array then pack! Since n3 = 209,934 and K <= 80, store in flat uint8?
    //    210k * 80 = 16 MB (tiny!) -> zero race conditions, 100% deterministic!
    uint8_t *c3 = (uint8_t *)malloc((size_t)n3 * K);
    #pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < N; i++) {
        uint64_t *buf_i = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        uint64_t *buf_ij = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        uint64_t *buf_ijk = (uint64_t *)malloc((size_t)stride * sizeof(uint64_t));
        const uint64_t *bi = basis_sub + (size_t)i * stride;
        for (int w = 0; w < stride; w++) buf_i[w] = base_sub[w] ^ bi[w];
        int tidx = t_i_off[i];
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_sub + (size_t)j * stride;
            for (int w = 0; w < stride; w++) buf_ij[w] = buf_i[w] ^ bj[w];
            int pij = p_off[i * N + j];
            for (int k = j + 1; k < N; k++) {
                const uint64_t *bk = basis_sub + (size_t)k * stride;
                for (int w = 0; w < stride; w++) buf_ijk[w] = buf_ij[w] ^ bk[w];
                uint8_t *fijk = c3 + (size_t)tidx * K;
                EVAL_K_BITS(buf_ijk, fijk);
                int pik = p_off[i * N + k];
                int pjk = p_off[j * N + k];
                for (int ki = 0; ki < K; ki++) {
                    fijk[ki] ^= c0[ki]
                              ^ c1[(size_t)i * K + ki] ^ c1[(size_t)j * K + ki] ^ c1[(size_t)k * K + ki]
                              ^ c2[(size_t)pij * K + ki] ^ c2[(size_t)pik * K + ki] ^ c2[(size_t)pjk * K + ki];
                }
                tidx++;
            }
        }
        free(buf_i);
        free(buf_ij);
        free(buf_ijk);
    }
    for (int t = 0; t < n3; t++) {
        int col = 1 + n1 + n2 + t;
        int w = col >> 6;
        uint64_t bit = 1ULL << (col & 63);
        const uint8_t *ct = c3 + (size_t)t * K;
        for (int ki = 0; ki < K; ki++)
            if (ct[ki]) out_anf[(size_t)ki * n_words + w] |= bit;
    }

    #undef EVAL_K_BITS
    free(c3);
    free(c2);
    free(c1);
    free(c0);
    free(t_i_off);
    free(p_off);
}
"""


def compile_step71b_c():
    c_p = WORK_DIR / "s71b_c8.c"
    so_p = WORK_DIR / "libs71b_c8.so"
    c_p.write_text(C_STEP71B_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_p), "-o", str(so_p)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_p))
    lib.eval_subspace_S_batch_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int32),
    ]
    lib.extract_subspace_deg3_anf_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int32), ctypes.POINTER(ctypes.c_int32),
        ctypes.POINTER(ctypes.c_int32), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int32), ctypes.POINTER(ctypes.c_uint64),
    ]
    return lib


# ==============================================================================
# Build ALL C_8-Invariant 8-Dim Subspaces & Their Exact ZT-Verified Syzygies!
# ==============================================================================

def poly_mul_rot8(p_mask, u):
    """Multiply u in F_2^8 by polynomial p(rot8) mod (rot8^8 - 1)."""
    res = 0
    for j in range(8):
        if (p_mask >> j) & 1:
            # rot8^j(u)
            rj = ((u << j) | (u >> (8 - j))) & 0xFF
            res ^= rj
    return res


def build_c8_orbits_with_step(step=1):
    """Build orbits of <rot8^step> on F_2^8."""
    seen = set()
    orbs = []
    for a in range(256):
        if a in seen:
            continue
        orb = []
        cur = a
        while cur not in seen:
            seen.add(cur)
            orb.append(cur)
            for _ in range(step):
                cur = diag_v2.rot8(cur)
        orbs.append(sorted(orb))
    return orbs


def gf2_basis_and_perp_16(vecs):
    """Given a list of 16-bit vectors spanning a subspace V, return (basis_V, basis_Vperp)."""
    piv = {}
    for v in vecs:
        x = int(v)
        while x:
            lb = x & -x
            if lb in piv:
                x ^= piv[lb]
            else:
                piv[lb] = x
                break
    basis = [piv[k] for k in sorted(piv.keys())]
    # Nullspace of basis (V^perp)
    pcols = set((k.bit_length() - 1) for k in piv.keys())
    # Put piv in RREF
    rref = dict(piv)
    for kb in sorted(rref.keys(), reverse=True):
        for ob in rref:
            if ob != kb and (rref[ob] & kb):
                rref[ob] ^= rref[kb]
    perp = []
    for fc in range(16):
        if fc in pcols:
            continue
        nv = (1 << fc)
        for kb, row in rref.items():
            if (row >> fc) & 1:
                nv |= kb
        perp.append(nv)
    return basis, perp


def span_from_basis(basis):
    out = [0]
    for b in basis:
        out += [x ^ b for x in out]
    return out


def build_all_c8_subspace_specs(real_bents):
    """
    Build all C_8-invariant 8-dim subspaces:
      (A) ALL 36 C_8-orbit-rep graph subspaces V_p = {(u_e, (p * u)_o)} (untwisted, d=1 -> 36 orbs)
      (B) Symmetric twists gamma in {0xFF (d=1), 0x55 (d=2), 0x11, 0x33, 0x77 (d=4)} on E_8 (p=0)
          AND gamma=0xFF (d=1) on V_p for p in {1, 3, 5, 7, 0x11, 0x33, 0x55, 0xFF}!
      (C) ALL 7 mixed uniserial C_8 subspaces U_k = M_k(E_8) (+) M_{8-k}(O_8) for k=1,2,3,5,6,7!
    For EVERY spec, build exact coset table [M_cos, 256], exact kernel K, extract mod-16/32/64
    syzygies, and ZERO-TRUST VERIFY every single one on real_bents (quad_b1, quad_d1)!
    """
    even_to_16, odd_to_16 = s71a.build_e8_o8_maps()
    c8_orbs_d1 = build_c8_orbits_with_step(1)  # 36 orbits
    assert len(c8_orbs_d1) == 36

    # Precompute C_8-Walsh kernel & syzygies for d=1, d=2, d=4!
    kernel_cache = {}
    for d_step in [1, 2, 4]:
        orbs = build_c8_orbits_with_step(d_step)
        M = len(orbs)
        K = np.zeros((M, M), dtype=np.int32)
        for ia, oa in enumerate(orbs):
            arep = oa[0]
            for iw, ow in enumerate(orbs):
                K[ia, iw] = sum(-1 if ((arep & w).bit_count() & 1) else 1 for w in ow)
        syz_list = []
        c0_all = K.sum(axis=1)
        ks = [3, 4, 5] if d_step <= 2 else [3, 4]
        for k in ks:
            u_vecs = s66.exact_left_nullspace_mod_2k(K, k)
            mod_t = 1 << (k + 1)
            for u in u_vecs:
                c0 = int(np.dot(u.astype(np.int64), c0_all.astype(np.int64))) % mod_t
                syz_list.append((k, mod_t, c0, u.astype(np.int32).copy()))
        orb_sz = np.array([len(o) for o in orbs], dtype=np.int32)
        kernel_cache[d_step] = (orbs, orb_sz, syz_list)
        print(f"  [KERNEL C_8 step={d_step}]: M={M} orbits -> {len(syz_list)} syzygies (ks={ks})", flush=True)

    specs = []

    def add_graph_spec(name, p_mask, gamma, d_step):
        orbs, orb_sz, syz_list = kernel_cache[d_step]
        M_cos = len(orbs)
        # Base subspace V_p: for u in 0..255, x_V[u] = even_to_16[u] ^ odd_to_16[p*u]
        x_V = np.array([even_to_16[u] ^ odd_to_16[poly_mul_rot8(p_mask, u)] for u in range(256)], dtype=np.int32)
        coset_pts = np.zeros((M_cos, 256), dtype=np.int32)
        for ia, oa in enumerate(orbs):
            coset_pts[ia] = x_V ^ odd_to_16[oa[0]]
        twist_mask = np.zeros(4, dtype=np.uint64)
        for u in range(256):
            if (gamma & u).bit_count() & 1:
                twist_mask[u >> 6] |= np.uint64(1 << (u & 63))
        # ZERO-TRUST VERIFY on BOTH real_bents!
        for bname, btt in real_bents:
            # Compute S[ia] for all M_cos
            tw_u8 = np.array([1 if ((gamma & u).bit_count() & 1) else 0 for u in range(256)], dtype=np.uint8)
            S = np.zeros(M_cos, dtype=np.int64)
            for ia in range(M_cos):
                vals = btt[coset_pts[ia]] ^ tw_u8
                S[ia] = 256 - 2 * int(np.sum(vals))
            assert int(np.sum(orb_sz * S * S)) == 65536, f"ZT FAIL Parseval on {name} / {bname}!"
            for k, mod_t, c0, u_vec in syz_list:
                lhs = int(np.dot(u_vec.astype(np.int64), S)) % mod_t
                assert lhs == c0, f"ZT FAIL syzygy on {name} / {bname}: {lhs} != {c0}!"
        specs.append({
            "name": name, "M_cos": M_cos, "coset_pts": coset_pts,
            "twist_mask": twist_mask, "orb_sz": orb_sz, "syz_list": syz_list,
        })

    # (A) ALL 36 C_8-orbit reps of V_p (untwisted, d=1)
    for oa in c8_orbs_d1:
        p = oa[0]
        add_graph_spec(f"Vp_0x{p:02x}_g00", p, 0, 1)

    # (B) Symmetric twists on E_8 (p=0) and key V_p's!
    for gamma, d_step in [(0xFF, 1), (0x55, 2), (0x11, 4), (0x33, 4), (0x77, 4)]:
        add_graph_spec(f"E8_g{gamma:02x}_d{d_step}", 0, gamma, d_step)
    for p in [0x01, 0x03, 0x05, 0x07, 0x11, 0x33, 0x55, 0xFF]:
        add_graph_spec(f"Vp_0x{p:02x}_gFF", p, 0xFF, 1)
        add_graph_spec(f"Vp_0x{p:02x}_g55", p, 0x55, 2)

    # (C) Mixed uniserial C_8-invariant 8-dim subspaces U_k = M_k(E_8) (+) M_{8-k}(O_8) for k=1..7!
    #     Here M_k(F_2^8) = ker((1 + rot8)^k) (dim k)!
    #     Build M_k basis by computing (1 + rot8)^k matrix on F_2^8!
    R8 = np.zeros((8, 8), dtype=np.uint8)
    for i in range(8):
        R8[i, i] ^= 1
        R8[(i + 1) & 7, i] ^= 1

    def get_Mk_8(k):
        # Compute M = (I + rot8)^k over GF(2)
        P = np.eye(8, dtype=np.uint8)
        for _ in range(k):
            P = (P @ R8) & 1
        # Right nullspace of P
        piv = {}
        for r in range(8):
            v = 0
            for c in range(8):
                if P[r, c]:
                    v |= (1 << c)
            while v:
                lb = v & -v
                if lb in piv:
                    v ^= piv[lb]
                else:
                    piv[lb] = v
                    break
        # RREF
        for kb in sorted(piv.keys(), reverse=True):
            for ob in piv:
                if ob != kb and (piv[ob] & kb):
                    piv[ob] ^= piv[kb]
        pcols = set(kb.bit_length() - 1 for kb in piv.keys())
        ns = []
        for fc in range(8):
            if fc in pcols:
                continue
            nv = (1 << fc)
            for kb, row in piv.items():
                if (row >> fc) & 1:
                    nv |= kb
            ns.append(nv)
        assert len(ns) == k
        return ns

    for k_u in [1, 2, 3, 5, 6, 7]:  # k=4 is D_8-like (wait: M_4(E_8) (+) M_4(O_8) != D_8!! Include k=4 too!)
        pass
    for k_u in [1, 2, 3, 4, 5, 6, 7]:
        b_e = [even_to_16[v] for v in get_Mk_8(k_u)]
        b_o = [odd_to_16[v] for v in get_Mk_8(8 - k_u)]
        basis_V = b_e + b_o
        _, basis_Vp = gf2_basis_and_perp_16(basis_V)
        assert len(basis_V) == 8 and len(basis_Vp) == 8
        pts_V = np.array(span_from_basis(basis_V), dtype=np.int32)
        pts_Vp = span_from_basis(basis_Vp)
        # Verify rot16^2 invariance of V and V^perp!
        V_set = set(int(x) for x in pts_V)
        Vp_set = set(int(x) for x in pts_Vp)
        assert all(diag_v2.rot16(x, 2) in V_set for x in V_set)
        assert all(diag_v2.rot16(x, 2) in Vp_set for x in Vp_set)

        # Find C_8-orbits on V^perp!
        seen_vp = set()
        vp_orbs = []
        for w in sorted(Vp_set):
            if w in seen_vp:
                continue
            orb = []
            cur = w
            while cur not in seen_vp:
                seen_vp.add(cur)
                orb.append(cur)
                cur = diag_v2.rot16(cur, 2)
            vp_orbs.append(orb)

        # Find C_8-orbits of cosets of V in F_2^16!
        # Canonical coset id = min element in (x ^ V)
        coset_seen = set()
        cos_orbs = []
        for x in range(65536):
            # Find canonical rep of coset x + V
            # Fast: skip if x already visited via an earlier coset
            if x in coset_seen:
                continue
            # Build C_8-orbit of cosets starting from x + V
            cur = x
            orb_reps = []
            while cur not in coset_seen:
                orb_reps.append(cur)
                for v in pts_V:
                    coset_seen.add(int(cur ^ v))
                cur = diag_v2.rot16(cur, 2)
            cos_orbs.append(orb_reps)

        M_cos = len(cos_orbs)
        M_vp = len(vp_orbs)
        K_u = np.zeros((M_cos, M_vp), dtype=np.int32)
        for ia, co in enumerate(cos_orbs):
            arep = co[0]
            for iw, vo in enumerate(vp_orbs):
                K_u[ia, iw] = sum(-1 if ((arep & w).bit_count() & 1) else 1 for w in vo)
        orb_sz = np.array([len(co) for co in cos_orbs], dtype=np.int32)
        assert int(np.sum(orb_sz)) == 256

        syz_u = []
        c0_all = K_u.sum(axis=1)
        for k in [3, 4, 5]:
            u_vecs = s66.exact_left_nullspace_mod_2k(K_u, k)
            mod_t = 1 << (k + 1)
            for u in u_vecs:
                c0 = int(np.dot(u.astype(np.int64), c0_all.astype(np.int64))) % mod_t
                syz_u.append((k, mod_t, c0, u.astype(np.int32).copy()))

        coset_pts = np.zeros((M_cos, 256), dtype=np.int32)
        for ia, co in enumerate(cos_orbs):
            coset_pts[ia] = pts_V ^ co[0]
        twist_mask = np.zeros(4, dtype=np.uint64)

        # ZERO-TRUST VERIFY on BOTH real_bents!
        for bname, btt in real_bents:
            S = np.array([256 - 2 * int(np.sum(btt[coset_pts[ia]])) for ia in range(M_cos)], dtype=np.int64)
            assert int(np.sum(orb_sz * S * S)) == 65536, f"ZT FAIL Parseval on Uk_{k_u} / {bname}!"
            for k, mod_t, c0, u_vec in syz_u:
                lhs = int(np.dot(u_vec.astype(np.int64), S)) % mod_t
                assert lhs == c0, f"ZT FAIL syzygy on Uk_{k_u} / {bname}: {lhs} != {c0}!"
        specs.append({
            "name": f"Uk_M{k_u}E_M{8-k_u}O", "M_cos": M_cos, "coset_pts": coset_pts,
            "twist_mask": twist_mask, "orb_sz": orb_sz, "syz_list": syz_u,
        })
        print(f"  [ZT-OK Uk_M{k_u}E_M{8-k_u}O]: M_cos={M_cos}, M_vp={M_vp}, syzs={len(syz_u)}", flush=True)

    print(f"  [TOTAL ZT-VERIFIED C_8 SUBSPACE SPECS]: {len(specs)} specs (ALL 100% passed quad_b1 & quad_d1!)", flush=True)
    return specs


def pack_subspace_tt_bits(base_tt, basis_u8, coset_pts):
    """Pack base_tt and basis_u8 restricted to coset_pts [M_cos, 256] into uint64 [M_cos*4] and [N, M_cos*4]."""
    flat = coset_pts.reshape(-1)
    b0 = np.ascontiguousarray(np.packbits(base_tt[flat], bitorder="little")).view(np.uint64).copy()
    bs = np.ascontiguousarray(np.packbits(basis_u8[:, flat], axis=1, bitorder="little")).view(np.uint64).copy()
    return np.ascontiguousarray(b0, dtype=np.uint64), np.ascontiguousarray(bs, dtype=np.uint64)


def run_cell(cell_name, specs, lib71b):
    t0 = time.perf_counter()
    print(f"\n================================================================================", flush=True)
    print(f"  [{cell_name}] STEP 71B: ALL C_8-INVARIANT 8-DIM SUBSPACES -> EXACT ANF & IR6 CASCADE", flush=True)
    print(f"================================================================================", flush=True)

    env = s63a.setup_cell_env(cell_name)
    lib9 = env["lib9"]
    tbl, root, root_act, eta_free = env["tbl"], env["root"], env["root_act"], env["eta_free"]
    base_tt, basis_u8, active_vars = s71a.get_root_affine_basis(env)
    N = len(active_vars)
    n_cw = tbl["n_col_words"]

    # 1. Pre-generate 1536 random root points + 12 random 5-dim cubes (384 pts) for saturation-free screening!
    #    (CG(389) + XL(Q_root) has dim ~820-1040 at root, so 1536 points guarantees ZERO saturation!)
    P_scr = 1536
    rng = np.random.default_rng(71500)
    C_scr = rng.integers(0, 2, size=(P_scr, N), dtype=np.uint8)
    bits5 = np.array([[(m >> b) & 1 for b in range(5)] for m in range(32)], dtype=np.uint8)
    n_cubes = 12
    C_cubes = np.zeros((n_cubes * 32, N), dtype=np.uint8)
    for ti in range(n_cubes):
        bc = rng.integers(0, 2, size=(1, N), dtype=np.uint8)
        dr = rng.integers(0, 2, size=(5, N), dtype=np.uint8)
        C_cubes[ti * 32 : (ti + 1) * 32] = (bc ^ ((bits5 @ dr) & 1)).astype(np.uint8)

    C_all = np.vstack([C_scr, C_cubes])  # [1920, N]
    P_all = C_all.shape[0]
    pts_lo = np.zeros(P_all, dtype=np.uint64)
    pts_hi = np.zeros(P_all, dtype=np.uint64)
    for k in range(N):
        col = C_all[:, k].astype(np.uint64)
        if k < 64:
            pts_lo |= (col << np.uint64(k))
        else:
            pts_hi |= (col << np.uint64(k - 64))

    # Build GF(2) pivot table initialized with ALL root CG(389) equations + ALL XL multiples x_k * Q_a(x) on C_scr!
    cg_scr = s71a.eval_root_cg_on_batch(env, C_scr)  # [P_scr, n_q + n_c]
    n_q_root = len(root["_quad_ids"])

    def vec_to_int(col_u8):
        v = 0
        for i in np.flatnonzero(col_u8):
            v |= (1 << int(i))
        return v

    piv_scr = {}
    def insert_piv(col_u8):
        v = vec_to_int(col_u8)
        while v:
            lb = v & -v
            if lb in piv_scr:
                v ^= piv_scr[lb]
            else:
                piv_scr[lb] = v
                return True
        return False

    for j in range(cg_scr.shape[1]):
        insert_piv(cg_scr[:, j])
    rk_cg_raw = len(piv_scr)
    # Add ALL XL degree-3 multiples x_k * Q_a(x) for a=0..n_q_root-1, k=0..N-1!
    for a in range(n_q_root):
        qa = cg_scr[:, a]
        for k in range(N):
            insert_piv(qa & C_scr[:, k])
    rk_cg_xl = len(piv_scr)
    print(f"  [{cell_name} ROOT N={N}] Baseline CG(389) {P_scr}-pt rank: raw={rk_cg_raw} | +XL(Q_root)={rk_cg_xl}", flush=True)

    # Also build independent 256-pt verification set C_zt!
    C_zt = rng.integers(0, 2, size=(256, N), dtype=np.uint8)
    zt_lo = np.zeros(256, dtype=np.uint64)
    zt_hi = np.zeros(256, dtype=np.uint64)
    for k in range(N):
        col = C_zt[:, k].astype(np.uint64)
        if k < 64:
            zt_lo |= (col << np.uint64(k))
        else:
            zt_hi |= (col << np.uint64(k - 64))

    # Precompute monomial list in active_vars (0..N-1) -> original 111-var bitmask!
    n1 = N
    n2 = N * (N - 1) // 2
    n3 = N * (N - 1) * (N - 2) // 6
    n_mon = 1 + n1 + n2 + n3
    n_mon_words = (n_mon + 63) // 64
    mon_orig_mask = np.zeros(n_mon, dtype=object)
    mon_orig_mask[0] = 0
    idx_m = 1
    for i in range(N):
        mon_orig_mask[idx_m] = (1 << active_vars[i])
        idx_m += 1
    for i in range(N):
        mi = 1 << active_vars[i]
        for j in range(i + 1, N):
            mon_orig_mask[idx_m] = mi | (1 << active_vars[j])
            idx_m += 1
    for i in range(N):
        mi = 1 << active_vars[i]
        for j in range(i + 1, N):
            mij = mi | (1 << active_vars[j])
            for k in range(j + 1, N):
                mon_orig_mask[idx_m] = mij | (1 << active_vars[k])
                idx_m += 1

    # Also precompute monomial evaluation on C_zt [256] for fast ZT verification!
    # Wait: we only evaluate the non-zero monomials of each extracted polynomial (fast!)
    mon_tuples = [()]
    for i in range(N): mon_tuples.append((i,))
    for i in range(N):
        for j in range(i + 1, N): mon_tuples.append((i, j))
    for i in range(N):
        for j in range(i + 1, N):
            for k in range(j + 1, N): mon_tuples.append((i, j, k))

    extracted_psets = []  # List of (tag, deg, pset_in_111_vars)
    deg4_count_total = 0
    hit_1_root = False

    for sp in specs:
        sname = sp["name"]
        M_cos = sp["M_cos"]
        b0_pk, bs_pk = pack_subspace_tt_bits(base_tt, basis_u8, sp["coset_pts"])
        S_all = np.zeros((P_all, M_cos), dtype=np.int32)
        lib71b.eval_subspace_S_batch_c(
            N, M_cos, P_all,
            b0_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            bs_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            sp["twist_mask"].ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            pts_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            pts_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            S_all.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
        )
        S_512 = S_all[:P_scr].astype(np.int64)
        S_cub = S_all[P_scr:].astype(np.int64)
        orb_sz = sp["orb_sz"].astype(np.int64)

        # Build candidate equations (syzygies + Parseval)
        cands = []  # (is_pars, v_min, c0, u_vec)
        # 1. Syzygies
        for k, mod_t, c0, u_vec in sp["syz_list"]:
            res512 = (S_512 @ u_vec.astype(np.int64)) - c0
            nz = res512[res512 != 0]
            if len(nz) == 0:
                continue
            v_min = min((int(x) & -int(x)).bit_length() - 1 for x in nz)
            if v_min < k + 1:
                cands.append((0, v_min, c0, u_vec))
        # 2. Parseval
        pars512 = np.sum((S_512 * S_512) * orb_sz[None, :], axis=1) - 65536
        nz_p = pars512[pars512 != 0]
        if len(nz_p) > 0:
            v_p = min((int(x) & -int(x)).bit_length() - 1 for x in nz_p)
            cands.append((1, v_p, 0, np.zeros(M_cos, dtype=np.int32)))

        if not cands:
            continue

        # Compute exact degree (on 12 5-dim cubes) and P_scr-pt independence for each candidate!
        nC = len(cands)
        F_512 = np.zeros((P_scr, nC), dtype=np.uint8)
        F_cub = np.zeros((n_cubes * 32, nC), dtype=np.uint8)
        pars_cub = np.sum((S_cub * S_cub) * orb_sz[None, :], axis=1) - 65536
        for ci, (is_p, vm, c0, u_vec) in enumerate(cands):
            if is_p:
                F_512[:, ci] = ((pars512 >> vm) & 1).astype(np.uint8)
                F_cub[:, ci] = ((pars_cub >> vm) & 1).astype(np.uint8)
            else:
                F_512[:, ci] = (((S_512 @ u_vec.astype(np.int64)) - c0) >> vm) & 1
                F_cub[:, ci] = (((S_cub @ u_vec.astype(np.int64)) - c0) >> vm) & 1

        # Exact Mobius transform on each of the 12 5-dim cubes!
        max_deg = np.full(nC, -1, dtype=np.int32)
        for ci in range(nC):
            if np.any(F_512[:, ci]):
                max_deg[ci] = 0
                if np.any(F_512[:, ci] != F_512[0, ci]):
                    max_deg[ci] = 1
        for ti in range(n_cubes):
            M = F_cub[ti * 32 : (ti + 1) * 32].copy()
            for b in range(5):
                step = 1 << b
                for m in range(0, 32, 2 * step):
                    M[m + step : m + 2 * step] ^= M[m : m + step]
            for m in range(1, 32):
                d = int(m).bit_count()
                nz = np.flatnonzero(M[m])
                if len(nz):
                    max_deg[nz] = np.maximum(max_deg[nz], d)

        # Pick linearly independent deg<=3 candidates outside current piv_scr (CG(389)+XL(Q_root))!
        sel_cands = []
        n_d4_here = 0
        for ci in range(nC):
            d = int(max_deg[ci])
            if d == 4:
                n_d4_here += 1
                continue
            if d > 3 or d < 0:
                continue
            # Check instant 1=0!
            if d == 0 and np.all(F_512[:, ci] == 1):
                hit_1_root = True
                print(f"  !!! INSTANT 1=0 DETECTED IN {sname} cand #{ci} !!!", flush=True)
            if insert_piv(F_512[:, ci]):
                sel_cands.append((ci, d))
        deg4_count_total += n_d4_here

        if not sel_cands:
            continue

        # Extract EXACT deg<=3 ANF in C for ALL sel_cands of this subspace!
        K_sel = len(sel_cands)
        syz_u_arr = np.zeros((K_sel, M_cos), dtype=np.int32)
        syz_c0_arr = np.zeros(K_sel, dtype=np.int32)
        syz_sh_arr = np.zeros(K_sel, dtype=np.int32)
        is_p_arr = np.zeros(K_sel, dtype=np.uint8)
        for ki, (ci, _) in enumerate(sel_cands):
            is_p, vm, c0, u_vec = cands[ci]
            is_p_arr[ki] = is_p
            syz_sh_arr[ki] = vm
            syz_c0_arr[ki] = c0
            syz_u_arr[ki] = u_vec

        out_anf = np.zeros((K_sel, n_mon_words), dtype=np.uint64)
        t_ex = time.perf_counter()
        lib71b.extract_subspace_deg3_anf_c(
            N, M_cos, K_sel,
            b0_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            bs_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            sp["twist_mask"].ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            syz_u_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            syz_c0_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            syz_sh_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            is_p_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            sp["orb_sz"].ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            out_anf.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        )
        dt_ex = time.perf_counter() - t_ex

        # ZERO-TRUST VERIFY EVERY EXTRACTED ANF ON 256 INDEPENDENT RANDOM ROOT POINTS C_zt!
        S_zt = np.zeros((256, M_cos), dtype=np.int32)
        lib71b.eval_subspace_S_batch_c(
            N, M_cos, 256,
            b0_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            bs_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            sp["twist_mask"].ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            S_zt.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
        )
        S_zt64 = S_zt.astype(np.int64)
        pars_zt = np.sum((S_zt64 * S_zt64) * orb_sz[None, :], axis=1) - 65536

        anf_bits = np.unpackbits(out_anf.view(np.uint8), axis=1, bitorder="little")[:, :n_mon]
        zt_passed = 0
        deg_dist_here = {}
        for ki, (ci, d_est) in enumerate(sel_cands):
            nz_cols = np.flatnonzero(anf_bits[ki])
            pred = np.zeros(256, dtype=np.uint8)
            for mc in nz_cols:
                tup = mon_tuples[int(mc)]
                if len(tup) == 0: pred ^= 1
                elif len(tup) == 1: pred ^= C_zt[:, tup[0]]
                elif len(tup) == 2: pred ^= (C_zt[:, tup[0]] & C_zt[:, tup[1]])
                else: pred ^= (C_zt[:, tup[0]] & C_zt[:, tup[1]] & C_zt[:, tup[2]])
            is_p, vm, c0, u_vec = cands[ci]
            if is_p:
                true_v = ((pars_zt >> vm) & 1).astype(np.uint8)
            else:
                true_v = ((((S_zt64 @ u_vec.astype(np.int64)) - c0) >> vm) & 1).astype(np.uint8)
            mis = int(np.sum(pred != true_v))
            assert mis == 0, f"ZT FAIL ANF extraction in {sname} cand #{ci} (est deg={d_est}): {mis}/256 mismatches!"
            zt_passed += 1
            pset = set(int(mon_orig_mask[int(mc)]) for mc in nz_cols)
            true_deg = max((m.bit_count() for m in pset), default=0)
            deg_dist_here[true_deg] = deg_dist_here.get(true_deg, 0) + 1
            extracted_psets.append((f"{sname}#{'P' if is_p else ci}", true_deg, pset))

        print(
            f"  *** [{cell_name} | {sname}] ***: +{K_sel} NEW deg<=3 eqs OUTSIDE CG(389) (deg={deg_dist_here}, "
            f"ZT 256-pt: {zt_passed}/{K_sel} 0-mis, {dt_ex:.2f}s) | total_new={len(extracted_psets)}",
            flush=True,
        )

    print(
        f"\n  ================================================================================\n"
        f"  *** [{cell_name} HARVEST SUMMARY] ***:\n"
        f"      TOTAL NEW ZT-VERIFIED deg<=3 EQS OUTSIDE CG(389) AT ROOT N={N}: {len(extracted_psets)}\n"
        f"      (total deg=4 candidates seen: {deg4_count_total} | hit_1_root={hit_1_root})\n"
        f"  ================================================================================",
        flush=True,
    )

    if not extracted_psets:
        return

    # 2. INJECT ALL NEW ZT-VERIFIED deg<=3 EQUATIONS INTO CG(389) AT ROOT N=109 AND RUN IR6!!
    n_tot_old = len(root["_buf"]) // n_cw
    n_add = len(extracted_psets)
    new_buf = (ctypes.c_uint64 * ((n_tot_old + n_add) * n_cw))()
    ctypes.memmove(new_buf, root["_buf"], n_tot_old * n_cw * 8)
    new_qids = list(root["_quad_ids"])
    new_cids = list(root["_cub_ids"])
    for idx_a, (tag, deg, ps) in enumerate(extracted_psets):
        rid = n_tot_old + idx_a
        s9.pset_to_row(ps, new_buf, rid, tbl)
        if deg <= 2:
            new_qids.append(rid)
        else:
            new_cids.append(rid)

    t_ir = time.perf_counter()
    sr_root_new = s9.run_branch_cascade(
        lib9, new_buf, new_qids, new_cids, root["_lin_pivs"],
        [], tbl, max_xl_rounds=30, verify_subst=True,
    )
    dt_ir = time.perf_counter() - t_ir
    print(
        f"\n  *** [{cell_name} ROOT IR6 CASCADE AFTER +{n_add} C_8 EQS] *** ({dt_ir:.1f}s):\n"
        f"      OLD ROOT: closed=False, N={N}, q={len(root['_quad_ids'])}, c={len(root['_cub_ids'])}\n"
        f"      NEW ROOT: closed={sr_root_new['closed_unsat']}, closed_by={sr_root_new.get('closed_by')}, "
        f"N={sr_root_new.get('N_active')}, q={len(sr_root_new.get('_quad_ids', []))}, c={len(sr_root_new.get('_cub_ids', []))}",
        flush=True,
    )

    if sr_root_new["closed_unsat"]:
        print(f"\n  !!!!!!!!!! [{cell_name}] 100% CLOSED UNSAT AT ROOT BY C_8 SUBSPACE EQUATIONS ALONE !!!!!!!!!!!", flush=True)
        return

    # 3. Test ALL representative eta-orbits on the enriched NEW ROOT!
    etas = [5, 0, 1, 2, 3, 4] if cell_name == "B0_00" else ([5, 0, 9, 11] if cell_name == "B0_11" else [3, 0, 8, 10])
    n_ef = len(eta_free)
    for em in etas:
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr_old = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=False,
        )
        sr_new = s9.run_branch_cascade(
            lib9, sr_root_new["_buf"], sr_root_new["_quad_ids"], sr_root_new["_cub_ids"], sr_root_new["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=30, verify_subst=False,
        )
        print(
            f"    [{cell_name} eta={em:2d}] OLD: closed={sr_old['closed_unsat']}, N={sr_old.get('N_active')}, "
            f"q={len(sr_old.get('_quad_ids', []))}, c={len(sr_old.get('_cub_ids', []))}  ==>  "
            f"NEW: closed={sr_new['closed_unsat']} ({sr_new.get('closed_by')}), N={sr_new.get('N_active')}, "
            f"q={len(sr_new.get('_quad_ids', []))}, c={len(sr_new.get('_cub_ids', []))}",
            flush=True,
        )

    print(f"\n[STEP 71B {cell_name}] COMPLETED in {time.perf_counter()-t0:.1f}s!", flush=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", required=True, choices=["B0_00", "B0_11", "B1_11"])
    args = ap.parse_args()

    real_bents = s71a.build_real_c16_bents()
    lib71b = compile_step71b_c()
    specs = build_all_c8_subspace_specs(real_bents)
    run_cell(args.cell, specs, lib71b)


if __name__ == "__main__":
    main()
