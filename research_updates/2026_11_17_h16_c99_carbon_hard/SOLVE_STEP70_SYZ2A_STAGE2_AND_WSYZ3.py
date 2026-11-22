#!/usr/bin/env python3
r"""
SOLVE_STEP70_SYZ2A_STAGE2_AND_WSYZ3.py
======================================
PURE-ALGEBRAIC GLOBAL (k_fix = 0) MATRIX-PENCIL LEFT-SYZYGY CLOSURE SUITE:

  PART A — COMPLETE SYZ-2A STAGE 1 + EXACT STAGE 2 (Full Boolean-Ring Lift over ALL nRF cols):
    Step 69 discovered NULLITY_HOMOG = 2,456 on B0_00 (eta=5), 45 on B0_11 (eta=5),
    and 43 on B0_11 (eta=0) for deg(v)<=2 on M1_strict!
    Here we:
      1. Compute SYZ-1A HOMOG nullity (deg-1 homogeneous top) to diagnose exact origin of H.
      2. Run SYZ-2A HOMOG TOP (max_null=3000) to capture ALL H homogeneous degree-2 null vectors.
      3. Run EXACT STAGE 2 in the Boolean ring F_2[W]/(W_k^2 - W_k) over ALL nRF columns:
           (v_0 + sum_k W_k v_k + sum_h alpha_h U_h(W))^T M1_strict(W) == 0.
      4. Zero-Trust verify V(W)^T M1_strict(W) == 0 on 64 random W (0 mismatches).
      5. Evaluate pure-W polynomials P(W) = V(W)^T b_1(W) -> 512-pt functional rank,
         joint rank with SYZ-1C, instant 1=0 check, exact algebraic degree census (deg 0..5).

  PART B — UNIFIED WEIGHTED-DEGREE-3 LEFT-SYZYGY MODULE (WSYZ-3) ON FULL DRF1:
    V_1(W)^T M1_strict(W) + V_2(W)^T M_{A3+D2}(W) + V_3^T M_{D3_wt}(W) == 0
    where deg(V_1)<=2 (on deg-1 M1_strict), deg(V_2)<=1 (on deg-2 Block_A3+D2),
    and deg(V_3)=0 (on deg-3 Block_D3_wt with no T_a T_b terms)!
    Couples ALL blocks of DRF1 simultaneously at top degree 3 (cost ~ SYZ-2A + 3% vars!).
    Runs Stage 1 (OpenMP AVX2 C RREF) + Stage 2 (exact Boolean-ring lift over ALL nRF cols)
    + Zero-Trust 64-pt verification + pure-W 512-pt rank & degree census!

  PART C — SYMBOLIC ANF EXTRACTION & CG(389) IR6 INJECTION OF B0_11's 2 GLOBAL PURE-W CUBICS:
    Pulls back the 2 SYZ-1C pure-W cubics (proven NEW outside P0 in Step 69) from W to the
    109 coefficients c, Zero-Trust verifies against P_syz on W_512 (0 mismatches), and injects
    them into s9.run_branch_cascade at k_fix=0 to measure new cubic rank & IR6 cascade!
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

import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP68_MATRIX_PENCIL_SYZYGY_ELIM as s68
import SOLVE_STEP69_DEG2_MATRIX_PENCIL_SYZYGY_GCP as s69


# ==============================================================================
# C OpenMP/AVX2 Engine:
#   1. solve_syz1a_homog_c  (quick diagnostic: v_a^T M_b + v_b^T M_a == 0)
#   2. solve_wsyz3_homog_c  (unified Stage 1: V1^(2)*M1 + V2^(1)*M2 + V3^(0)*M3 == 0 at deg 3)
#   3. solve_stage2_general_c (exact Boolean-ring Stage 2 lift over ALL nRF cols)
# ==============================================================================

C_STEP70_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <omp.h>

static int batch_reduce_and_insert(
    uint64_t *piv_rows, uint8_t *has_piv, int *n_piv_ptr,
    int n_vars, int n_words,
    uint64_t *batch_rows, int B
) {
    #pragma omp parallel for schedule(dynamic, 16)
    for (int i = 0; i < B; i++) {
        uint64_t *row = batch_rows + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) {
            uint64_t v = row[w];
            while (v) {
                int b = __builtin_ctzll(v);
                int col = (w << 6) + b;
                if (col >= n_vars) break;
                if (has_piv[col]) {
                    const uint64_t *pr = piv_rows + (size_t)col * n_words;
                    for (int k = w; k < n_words; k++) row[k] ^= pr[k];
                    v = row[w];
                } else {
                    break;
                }
            }
            if (v) break;
        }
    }

    int added = 0;
    int n_piv = *n_piv_ptr;
    for (int i = 0; i < B; i++) {
        if (n_piv >= n_vars) break;
        uint64_t *row = batch_rows + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) {
            uint64_t v = row[w];
            while (v) {
                int b = __builtin_ctzll(v);
                int col = (w << 6) + b;
                if (col >= n_vars) goto next_row;
                if (has_piv[col]) {
                    const uint64_t *pr = piv_rows + (size_t)col * n_words;
                    for (int k = w; k < n_words; k++) row[k] ^= pr[k];
                    v = row[w];
                } else {
                    has_piv[col] = 1;
                    memcpy(piv_rows + (size_t)col * n_words, row, (size_t)n_words * sizeof(uint64_t));
                    n_piv++;
                    added++;
                    goto next_row;
                }
            }
        }
    next_row:;
    }
    *n_piv_ptr = n_piv;
    return added;
}

static int backsub_free_cols(
    const uint64_t *piv_rows, const uint8_t *has_piv,
    int n_vars, int n_words, int n_piv,
    uint64_t *out_null, int max_null
) {
    int kn = n_vars - n_piv;
    if (kn <= 0 || max_null <= 0) return kn;
    int n_free = (kn < max_null) ? kn : max_null;
    int *free_cols = (int *)malloc((size_t)n_free * sizeof(int));
    int fi = 0;
    for (int col = 0; col < n_vars && fi < n_free; col++) {
        if (!has_piv[col]) free_cols[fi++] = col;
    }
    #pragma omp parallel for schedule(static)
    for (int f = 0; f < n_free; f++) {
        uint64_t *nv = out_null + (size_t)f * n_words;
        memset(nv, 0, (size_t)n_words * sizeof(uint64_t));
        int fc = free_cols[f];
        nv[fc >> 6] |= (1ULL << (fc & 63));
        for (int col = fc - 1; col >= 0; col--) {
            if (!has_piv[col]) continue;
            const uint64_t *pr = piv_rows + (size_t)col * n_words;
            int par = 0;
            int w0 = col >> 6;
            if ((col & 63) < 63) {
                uint64_t first_mask = (~0ULL) << ((col & 63) + 1);
                par ^= __builtin_parityll(pr[w0] & nv[w0] & first_mask);
            }
            for (int w = w0 + 1; w < n_words; w++) par ^= __builtin_parityll(pr[w] & nv[w]);
            if (par) nv[col >> 6] |= (1ULL << (col & 63));
        }
    }
    free(free_cols);
    return kn;
}

// 1. Quick diagnostic: SYZ-1A homogeneous degree-2 top: u_a^T M_b + u_b^T M_a == 0 (a < b)
int solve_syz1a_homog_c(
    int nW, int nRF_act, int r1,
    const uint8_t *Mw,
    int *out_rank
) {
    int n_vars = nW * r1;
    int n_words = (n_vars + 63) / 64;
    uint64_t *piv_rows = (uint64_t *)calloc((size_t)n_vars * n_words, sizeof(uint64_t));
    uint8_t *has_piv = (uint8_t *)calloc((size_t)n_vars, 1);
    const int B_MAX = 512;
    uint64_t *batch = (uint64_t *)malloc((size_t)B_MAX * n_words * sizeof(uint64_t));
    int b_cnt = 0, n_piv = 0;

    for (int a = 0; a < nW && n_piv < n_vars; a++) {
        const uint8_t *Ma = Mw + (size_t)a * r1 * nRF_act;
        int off_a = a * r1;
        for (int b = a + 1; b < nW && n_piv < n_vars; b++) {
            const uint8_t *Mb = Mw + (size_t)b * r1 * nRF_act;
            int off_b = b * r1;
            for (int col = 0; col < nRF_act; col++) {
                uint64_t *row = batch + (size_t)b_cnt * n_words;
                memset(row, 0, (size_t)n_words * sizeof(uint64_t));
                int any = 0;
                for (int r = 0; r < r1; r++) {
                    if (Mb[r * nRF_act + col]) { int c = off_a + r; row[c >> 6] ^= (1ULL << (c & 63)); any = 1; }
                    if (Ma[r * nRF_act + col]) { int c = off_b + r; row[c >> 6] ^= (1ULL << (c & 63)); any = 1; }
                }
                if (any) {
                    b_cnt++;
                    if (b_cnt == B_MAX) {
                        batch_reduce_and_insert(piv_rows, has_piv, &n_piv, n_vars, n_words, batch, b_cnt);
                        b_cnt = 0;
                        if (n_piv >= n_vars) break;
                    }
                }
            }
        }
    }
    if (b_cnt > 0 && n_piv < n_vars) {
        batch_reduce_and_insert(piv_rows, has_piv, &n_piv, n_vars, n_words, batch, b_cnt);
    }
    free(batch);
    free(has_piv);
    free(piv_rows);
    *out_rank = n_piv;
    return n_vars - n_piv;
}

// 2. Unified WSYZ-3 Homogeneous Degree-3 Top Solver:
//    q_{ab}^T M1_c + q_{ac}^T M1_b + q_{bc}^T M1_a
//  + u_a^T M2_{bc} + u_b^T M2_{ac} + u_c^T M2_{ab}
//  + v3^T M3_{abc} == 0   for all 0 <= a < b < c < nW.
// Variable layout:
//   q_{pair(i,j)}[r] : pair(i,j) * r1 + r             (nPairs * r1 vars)
//   u_k[r]           : off_u + k * r2 + r             (nW * r2 vars)
//   v3[r]            : off_v3 + r                     (r3 vars)
// Pass r2=0, r3=0 for pure SYZ-2A!
int solve_wsyz3_homog_c(
    int nW, int nRF_act, int r1, int r2, int r3,
    const uint8_t *Mw1,    // [nW * r1 * nRF_act]
    const uint8_t *Mww2,   // [nPairs * r2 * nRF_act]  (may be NULL if r2==0)
    const uint8_t *Mwww3,  // [n_trips_orig * r3 * nRF_act] indexed by orig_tidx[ti] (may be NULL if r3==0)
    const int *trip_a, const int *trip_b, const int *trip_c, const int *trip_orig_idx, int n_trips,
    uint64_t *out_null, int max_null, int *out_rank, int *out_trips_used
) {
    int nPairs = nW * (nW - 1) / 2;
    int off_u = nPairs * r1;
    int off_v3 = off_u + nW * r2;
    int n_vars = off_v3 + r3;
    int n_words = (n_vars + 63) / 64;

    int *pidx_lut = (int *)malloc((size_t)nW * nW * sizeof(int));
    {
        int p = 0;
        for (int i = 0; i < nW; i++)
            for (int j = i + 1; j < nW; j++) {
                pidx_lut[i * nW + j] = p;
                pidx_lut[j * nW + i] = p;
                p++;
            }
    }

    uint64_t *piv_rows = (uint64_t *)calloc((size_t)n_vars * n_words, sizeof(uint64_t));
    uint8_t *has_piv = (uint8_t *)calloc((size_t)n_vars, 1);

    const int B_MAX = 1024;
    uint64_t *batch = (uint64_t *)malloc((size_t)B_MAX * n_words * sizeof(uint64_t));
    int b_cnt = 0, n_piv = 0, t_used = 0;

    for (int ti = 0; ti < n_trips; ti++) {
        if (n_piv >= n_vars) break;
        t_used = ti + 1;
        int a = trip_a[ti], b = trip_b[ti], c = trip_c[ti];
        int pab = pidx_lut[a * nW + b];
        int pac = pidx_lut[a * nW + c];
        int pbc = pidx_lut[b * nW + c];
        int off_ab = pab * r1;
        int off_ac = pac * r1;
        int off_bc = pbc * r1;
        const uint8_t *Ma = Mw1 + (size_t)a * r1 * nRF_act;
        const uint8_t *Mb = Mw1 + (size_t)b * r1 * nRF_act;
        const uint8_t *Mc = Mw1 + (size_t)c * r1 * nRF_act;

        const uint8_t *M2_ab = (r2 > 0) ? (Mww2 + (size_t)pab * r2 * nRF_act) : NULL;
        const uint8_t *M2_ac = (r2 > 0) ? (Mww2 + (size_t)pac * r2 * nRF_act) : NULL;
        const uint8_t *M2_bc = (r2 > 0) ? (Mww2 + (size_t)pbc * r2 * nRF_act) : NULL;
        const uint8_t *M3_abc = (r3 > 0) ? (Mwww3 + (size_t)trip_orig_idx[ti] * r3 * nRF_act) : NULL;

        for (int col = 0; col < nRF_act; col++) {
            uint64_t *row = batch + (size_t)b_cnt * n_words;
            memset(row, 0, (size_t)n_words * sizeof(uint64_t));
            int any = 0;
            for (int r = 0; r < r1; r++) {
                if (Mc[r * nRF_act + col]) { int cc = off_ab + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
                if (Mb[r * nRF_act + col]) { int cc = off_ac + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
                if (Ma[r * nRF_act + col]) { int cc = off_bc + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
            }
            if (r2 > 0) {
                int ua = off_u + a * r2;
                int ub = off_u + b * r2;
                int uc = off_u + c * r2;
                for (int r = 0; r < r2; r++) {
                    if (M2_bc[r * nRF_act + col]) { int cc = ua + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
                    if (M2_ac[r * nRF_act + col]) { int cc = ub + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
                    if (M2_ab[r * nRF_act + col]) { int cc = uc + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
                }
            }
            if (r3 > 0) {
                for (int r = 0; r < r3; r++) {
                    if (M3_abc[r * nRF_act + col]) { int cc = off_v3 + r; row[cc >> 6] ^= (1ULL << (cc & 63)); any = 1; }
                }
            }
            if (any) {
                b_cnt++;
                if (b_cnt == B_MAX) {
                    batch_reduce_and_insert(piv_rows, has_piv, &n_piv, n_vars, n_words, batch, b_cnt);
                    b_cnt = 0;
                    if (n_piv >= n_vars) break;
                }
            }
        }
        if ((ti + 1) % 3000 == 0 || n_piv >= n_vars) {
            printf("      [HOMOG progress] trips=%d/%d | rank=%d/%d\n", ti + 1, n_trips, n_piv, n_vars);
            fflush(stdout);
        }
    }
    if (b_cnt > 0 && n_piv < n_vars) {
        batch_reduce_and_insert(piv_rows, has_piv, &n_piv, n_vars, n_words, batch, b_cnt);
    }

    int kn = backsub_free_cols(piv_rows, has_piv, n_vars, n_words, n_piv, out_null, max_null);
    free(batch);
    free(has_piv);
    free(piv_rows);
    free(pidx_lut);
    *out_rank = n_piv;
    *out_trips_used = t_used;
    return kn;
}

// 3. Exact Boolean-Ring Stage 2 Solver (dense bitset GF(2) RREF on [n_eqs x n_vars]):
//    Takes pre-built row matrix eq_bits [n_eqs * n_words] and computes exact right nullspace!
int solve_dense_gf2_nullspace_c(
    int n_eqs, int n_vars,
    const uint64_t *eq_bits,
    uint64_t *out_null, int max_null, int *out_rank
) {
    int n_words = (n_vars + 63) / 64;
    uint64_t *piv_rows = (uint64_t *)calloc((size_t)n_vars * n_words, sizeof(uint64_t));
    uint8_t *has_piv = (uint8_t *)calloc((size_t)n_vars, 1);
    const int B_MAX = 512;
    uint64_t *batch = (uint64_t *)malloc((size_t)B_MAX * n_words * sizeof(uint64_t));
    int n_piv = 0;

    for (int i = 0; i < n_eqs && n_piv < n_vars; i += B_MAX) {
        int B = (i + B_MAX <= n_eqs) ? B_MAX : (n_eqs - i);
        memcpy(batch, eq_bits + (size_t)i * n_words, (size_t)B * n_words * sizeof(uint64_t));
        batch_reduce_and_insert(piv_rows, has_piv, &n_piv, n_vars, n_words, batch, B);
    }
    int kn = backsub_free_cols(piv_rows, has_piv, n_vars, n_words, n_piv, out_null, max_null);
    free(batch);
    free(has_piv);
    free(piv_rows);
    *out_rank = n_piv;
    return kn;
}
"""


def compile_step70_c():
    c_p = WORK_DIR / "s70_syz.c"
    so_p = WORK_DIR / "libs70_syz.so"
    c_p.write_text(C_STEP70_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_p), "-o", str(so_p)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_p))
    lib.solve_syz1a_homog_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int),
    ]
    lib.solve_syz1a_homog_c.restype = ctypes.c_int

    lib.solve_wsyz3_homog_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.solve_wsyz3_homog_c.restype = ctypes.c_int

    lib.solve_dense_gf2_nullspace_c.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.POINTER(ctypes.c_int),
    ]
    lib.solve_dense_gf2_nullspace_c.restype = ctypes.c_int
    return lib


# ==============================================================================
# Helper: Exact degree<=3 expansion of Block_D3_wt (rows of Block_D3 with Mtt==0)
# ==============================================================================

def extract_and_expand_d3_wt(blk):
    """
    Filter Block_D3_rids to rows with zero T*T terms (exact deg <= 3 in W!).
    Expand M3(W) = M3_0 + sum_k W_k M3_k + sum_{a<b} W_a W_b M3_{ab} + sum_{a<b<c} W_a W_b W_c M3_{abc}
    in F_2[W] / (W_k^2 - W_k), and Zero-Trust verify on 32 random W!
    """
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    # Extract D3 slice from DRF1_all_t: DRF1_all = M1_strict + A3 + D2 + D3
    r_quad = blk["DRF1_quad_t"]["M0"].shape[0]
    all_t = blk["DRF1_all_t"]
    r_all = all_t["M0"].shape[0]
    r_d3_tot = r_all - r_quad
    if r_d3_tot == 0:
        return None

    # Find which D3 rows have NO Mtt entries
    has_tt = np.zeros(r_d3_tot, dtype=bool)
    for key, mat in all_t["Mtt"].items():
        has_tt |= np.any(mat[r_quad:] != 0, axis=1)
    keep_local = np.flatnonzero(~has_tt)
    r3 = len(keep_local)
    if r3 == 0:
        return None
    keep_all = r_quad + keep_local

    M0 = all_t["M0"][keep_all].copy()
    Mw = all_t["Mw"][:, keep_all, :].copy()
    Mt = all_t["Mt"][:, keep_all, :].copy()
    Mww = {k: v[keep_all].copy() for k, v in all_t["Mww"].items() if np.any(v[keep_all] != 0)}
    Mwt = {k: v[keep_all].copy() for k, v in all_t["Mwt"].items() if np.any(v[keep_all] != 0)}

    qt_c0 = blk["qt_c0"]
    qt_lin = blk["qt_lin"]
    B_qt = np.asarray(blk["B_qt"], dtype=np.uint8) if nT > 0 else np.zeros((0, nW, nW), dtype=np.uint8)

    nPairs = nW * (nW - 1) // 2
    nTrips = nW * (nW - 1) * (nW - 2) // 6
    pidx = {}
    p = 0
    for i in range(nW):
        for j in range(i + 1, nW):
            pidx[(i, j)] = p
            p += 1
    tidx = {}
    t = 0
    for a in range(nW):
        for b in range(a + 1, nW):
            for c in range(b + 1, nW):
                tidx[(a, b, c)] = t
                t += 1

    M3_0 = M0.copy()
    M3_w = Mw.copy()
    M3_ww = np.zeros((nPairs, r3, nRF), dtype=np.uint8)
    M3_www = np.zeros((nTrips, r3, nRF), dtype=np.uint8)

    # 1. Mt[a] * T_a
    for a in np.flatnonzero(qt_c0):
        M3_0 ^= Mt[a]
    for k in range(nW):
        for a in np.flatnonzero(qt_lin[:, k]):
            M3_w[k] ^= Mt[a]
    for i in range(nW):
        for j in range(i + 1, nW):
            pi = pidx[(i, j)]
            if (i, j) in Mww:
                M3_ww[pi] ^= Mww[(i, j)]
            for a in np.flatnonzero(B_qt[:, i, j]):
                M3_ww[pi] ^= Mt[a]

    # 2. Mwt[(p, t_a)] * W_p * T_{t_a}
    #    W_p * (c0 + sum_q L_q W_q + sum_{q<r} B_{q,r} W_q W_r) mod (W^2 - W):
    #      deg 1 (W_p): c0 ^ L_p
    #      deg 2 (W_p W_q, q != p): L_q ^ B_{min(p,q), max(p,q)}
    #      deg 3 (W_p W_q W_r, q<r, p not in {q,r}): B_{q,r}
    for (wp, ta), mat in Mwt.items():
        if qt_c0[ta] ^ qt_lin[ta, wp]:
            M3_w[wp] ^= mat
        for q in range(nW):
            if q == wp:
                continue
            i, j = (wp, q) if wp < q else (q, wp)
            if qt_lin[ta, q] ^ B_qt[ta, i, j]:
                M3_ww[pidx[(i, j)]] ^= mat
        # deg 3: pairs (q, r) with q < r, q != wp, r != wp where B_qt[ta, q, r] == 1
        qs, rs = np.nonzero(np.triu(B_qt[ta], k=1))
        for q, r in zip(qs, rs):
            q, r = int(q), int(r)
            if q == wp or r == wp:
                continue
            tri = tuple(sorted((wp, q, r)))
            M3_www[tidx[tri]] ^= mat

    # ZERO-TRUST VERIFY exact expansion on 32 random W!
    rng = np.random.default_rng(70111)
    W_zt = rng.integers(0, 2, size=(32, nW), dtype=np.uint8)
    T_zt = blk["eval_t_batch"](W_zt)
    for bi in range(32):
        wv, tv = W_zt[bi], T_zt[bi]
        # Reference evaluation from all_t directly
        ref = M0.copy()
        for k in np.flatnonzero(wv):
            ref ^= Mw[k]
        for a in np.flatnonzero(tv):
            ref ^= Mt[a]
        for (i, j), m in Mww.items():
            if wv[i] and wv[j]:
                ref ^= m
        for (i, a), m in Mwt.items():
            if wv[i] and tv[a]:
                ref ^= m
        # Expanded evaluation
        exp = M3_0.copy()
        nz = [int(k) for k in np.flatnonzero(wv)]
        for k in nz:
            exp ^= M3_w[k]
        for i_idx in range(len(nz)):
            for j_idx in range(i_idx + 1, len(nz)):
                exp ^= M3_ww[pidx[(nz[i_idx], nz[j_idx])]]
                for k_idx in range(j_idx + 1, len(nz)):
                    exp ^= M3_www[tidx[(nz[i_idx], nz[j_idx], nz[k_idx])]]
        assert np.array_equal(ref, exp), f"ZT FAIL: Block_D3_wt expansion mismatch at pt {bi}!"

    def eval_b3(W_mat, T_mat=None):
        return blk["DRF1_all_b"](W_mat, T_mat)[:, keep_all]

    return {
        "r3": r3,
        "keep_all": keep_all,
        "M0": np.ascontiguousarray(M3_0, dtype=np.uint8),
        "Mw": np.ascontiguousarray(M3_w, dtype=np.uint8),
        "Mww": np.ascontiguousarray(M3_ww, dtype=np.uint8),
        "Mwww": np.ascontiguousarray(M3_www, dtype=np.uint8),
        "b_eval": eval_b3,
    }


# ==============================================================================
# Helper: Exact algebraic degree census & 512-pt functional rank
# ==============================================================================

def gf2_col_rank(M):
    piv = {}
    for j in range(M.shape[1]):
        v = 0
        for i in range(M.shape[0]):
            if M[i, j]:
                v |= (1 << i)
        while v:
            lb = v & -v
            if lb in piv:
                v ^= piv[lb]
            else:
                piv[lb] = v
                break
    return len(piv)


def exact_deg_census_eval(eval_fn, nW, n_polys, seed=70777):
    """
    Estimate/prove exact algebraic degree of each polynomial column via random 5-dim affine
    subspace Mobius transforms (exact lower bound, and exact for deg<=5 with 32 subspaces).
    Also returns exact constant-1 hit check and 512-pt functional rank!
    """
    rng = np.random.default_rng(seed)
    W_512 = rng.integers(0, 2, size=(512, nW), dtype=np.uint8)
    P_512 = eval_fn(W_512)
    rk_512 = gf2_col_rank(P_512)
    ones = np.ones((512, 1), dtype=np.uint8)
    hit_1 = (gf2_col_rank(np.hstack([P_512, ones])) == rk_512) and (rk_512 > 0)

    # Check exact degree up to 5 by evaluating on 24 random 5-dim affine cubes (32 pts each -> 768 pts)
    max_deg = np.full(n_polys, -1, dtype=np.int32)
    # First detect non-zero vs zero on W_512
    for j in range(n_polys):
        if np.any(P_512[:, j]):
            max_deg[j] = 0
            if np.any(P_512[:, j] != P_512[0, j]):
                max_deg[j] = 1

    # Random 5-dim cubes (exact parity over subcubes of dim d = 2, 3, 4, 5!)
    masks5 = np.arange(32, dtype=np.int32)
    bits5 = np.array([[(m >> b) & 1 for b in range(5)] for m in range(32)], dtype=np.uint8)
    for trial in range(24):
        base = rng.integers(0, 2, size=(1, nW), dtype=np.uint8)
        dirs = rng.integers(0, 2, size=(5, nW), dtype=np.uint8)
        W_cube = (base ^ ((bits5 @ dirs) & 1)).astype(np.uint8)
        F = eval_fn(W_cube)  # [32, n_polys]
        # Fast Mobius transform on 5 bits!
        M = F.copy()
        for b in range(5):
            step = 1 << b
            for m in range(0, 32, 2 * step):
                M[m + step : m + 2 * step] ^= M[m : m + step]
        for m in range(1, 32):
            d = int(m).bit_count()
            nz = np.flatnonzero(M[m])
            if len(nz):
                max_deg[nz] = np.maximum(max_deg[nz], d)

    hist = {}
    for d in max_deg:
        di = int(d)
        hist[di] = hist.get(di, 0) + 1
    return W_512, P_512, rk_512, hit_1, hist, max_deg


# ==============================================================================
# Unified Stage 1 + Exact Stage 2 Driver (handles BOTH SYZ-2A and WSYZ-3!)
# ==============================================================================

def run_stage1_and_stage2(
    label, blk, lib70,
    include_block2=False, include_block3=False,
    max_null=3000, seed=70000
):
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    M1_t = blk["M1_strict_t"]
    M1_0 = np.ascontiguousarray(M1_t["M0"], dtype=np.uint8)
    M1_w = np.ascontiguousarray(M1_t["Mw"], dtype=np.uint8)
    r1 = M1_0.shape[0]

    # Block 2: Block_A3 + Block_D2 (rows r1 .. r_quad-1 of DRF1_quad)
    r2 = 0
    M2_0 = M2_w = M2_ww = None
    b2_eval = None
    if include_block2:
        DQ_t = blk["DRF1_quad_t"]
        rq = DQ_t["M0"].shape[0]
        if rq > r1:
            M0_q, Mw_q, Mww_q = s68.expand_quad_pencil_in_W(
                DQ_t, blk["qt_c0"], blk["qt_lin"], blk["B_qt"], nW, nT, nRF
            )
            r2 = rq - r1
            M2_0 = np.ascontiguousarray(M0_q[r1:], dtype=np.uint8)
            M2_w = np.ascontiguousarray(Mw_q[:, r1:, :], dtype=np.uint8)
            M2_ww = np.ascontiguousarray(Mww_q[:, r1:, :], dtype=np.uint8)
            b2_eval = lambda W_mat, T_mat=None: blk["DRF1_quad_b"](W_mat, T_mat)[:, r1:]

    # Block 3: Block_D3_wt (deg <= 3 in W)
    r3 = 0
    d3 = None
    if include_block3:
        d3 = extract_and_expand_d3_wt(blk)
        if d3 is not None:
            r3 = d3["r3"]

    # Determine active columns at deg-3 top!
    act_mask = np.any(M1_w != 0, axis=(0, 1))
    if r2 > 0:
        act_mask |= np.any(M2_ww != 0, axis=(0, 1))
    if r3 > 0:
        act_mask |= np.any(d3["Mwww"] != 0, axis=(0, 1))
    act_cols = list(np.flatnonzero(act_mask))
    nRF_act = len(act_cols)

    M1_w_act = np.ascontiguousarray(M1_w[:, :, act_cols], dtype=np.uint8)
    M2_ww_act = np.ascontiguousarray(M2_ww[:, :, act_cols], dtype=np.uint8) if r2 > 0 else np.zeros(1, dtype=np.uint8)
    M3_www_act = np.ascontiguousarray(d3["Mwww"][:, :, act_cols], dtype=np.uint8) if r3 > 0 else np.zeros(1, dtype=np.uint8)

    nPairs = nW * (nW - 1) // 2
    n_vars_s1 = nPairs * r1 + nW * r2 + r3
    n_words_s1 = (n_vars_s1 + 63) // 64

    trips = [(a, b, c) for a in range(nW) for b in range(a + 1, nW) for c in range(b + 1, nW)]
    rng = np.random.default_rng(seed)
    perm = rng.permutation(len(trips))
    ta = np.ascontiguousarray([trips[i][0] for i in perm], dtype=np.int32)
    tb = np.ascontiguousarray([trips[i][1] for i in perm], dtype=np.int32)
    tc = np.ascontiguousarray([trips[i][2] for i in perm], dtype=np.int32)
    t_orig = np.ascontiguousarray(perm, dtype=np.int32)

    out_null_s1 = np.zeros((max_null, n_words_s1), dtype=np.uint64)
    out_rk = ctypes.c_int(0)
    out_tu = ctypes.c_int(0)

    print(
        f"\n  ======== [{label}] STAGE 1 HOMOG TOP: nW={nW}, r1={r1}, r2={r2}, r3={r3}, "
        f"nRF_act={nRF_act}/{nRF} -> vars={n_vars_s1:,}, eqs={len(trips)*nRF_act:,} ========",
        flush=True,
    )
    t1 = time.perf_counter()
    kn_s1 = lib70.solve_wsyz3_homog_c(
        nW, nRF_act, r1, r2, r3,
        M1_w_act.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        M2_ww_act.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        M3_www_act.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        ta.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        tb.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        tc.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        t_orig.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        len(trips),
        out_null_s1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        max_null, ctypes.byref(out_rk), ctypes.byref(out_tu),
    )
    dt1 = time.perf_counter() - t1
    print(
        f"  *** [{label} STAGE 1 RESULT] ***: rank={out_rk.value:,}/{n_vars_s1:,} | "
        f"NULLITY_HOMOG={kn_s1} | trips_used={out_tu.value}/{len(trips)} ({dt1:.1f}s)",
        flush=True,
    )

    if kn_s1 == 0:
        return {"kn_s1": 0, "kn_s2": 0, "rk_512": 0, "hit_1": False}

    H = min(kn_s1, max_null)
    if kn_s1 > max_null:
        print(f"  [WARN] kn_s1={kn_s1} > max_null={max_null}; capping Stage 2 to H={H}!", flush=True)

    # Unpack the H Stage-1 basis vectors into:
    #   Q_basis [H, nPairs, r1], U_basis [H, nW, r2], V3_basis [H, r3]
    off_u = nPairs * r1
    off_v3 = off_u + nW * r2
    raw_bits = np.unpackbits(
        out_null_s1[:H].view(np.uint8), axis=1, bitorder="little"
    )[:, :n_vars_s1]
    Q_basis = raw_bits[:, :off_u].reshape(H, nPairs, r1).copy()
    U_basis = raw_bits[:, off_u:off_v3].reshape(H, nW, r2).copy() if r2 > 0 else np.zeros((H, nW, 0), dtype=np.uint8)
    V3_basis = raw_bits[:, off_v3:].copy() if r3 > 0 else np.zeros((H, 0), dtype=np.uint8)

    # Build EXACT STAGE 2 Boolean-Ring system over ALL nRF columns!
    # Unknowns:
    #   v1_0 : [0 .. r1)
    #   v1_k : [(k+1)*r1 .. (k+2)*r1)    for k=0..nW-1
    #   v2_0 : [off_v2 .. off_v2 + r2)
    #   alpha: [off_al .. off_al + H)
    off_v2 = (nW + 1) * r1
    off_al = off_v2 + r2
    n_vars_s2 = off_al + H
    n_words_s2 = (n_vars_s2 + 63) // 64
    n_eqs_s2 = (1 + nW + nPairs) * nRF

    t2 = time.perf_counter()
    # Build dense uint8 matrix [n_eqs_s2, n_vars_s2] in blocks then packbits -> ultra-fast in numpy!
    E = np.zeros((n_eqs_s2, n_vars_s2), dtype=np.uint8)
    row_ptr = 0

    # 1. Constant (1): v1_0^T M1_0 + v2_0^T M2_0 + sum_h alpha_h (V3_h^T M3_0) == 0
    E[row_ptr : row_ptr + nRF, 0:r1] = M1_0.T
    if r2 > 0:
        E[row_ptr : row_ptr + nRF, off_v2 : off_v2 + r2] = M2_0.T
    if r3 > 0:
        E[row_ptr : row_ptr + nRF, off_al : off_al + H] = ((V3_basis.astype(np.uint32) @ d3["M0"].astype(np.uint32)) & 1).T
    row_ptr += nRF

    # 2. Linear (W_k, k=0..nW-1):
    #    v1_0^T M1_k + v1_k^T (M1_0 ^ M1_k) + v2_0^T M2_k
    #    + sum_h alpha_h [ U_{h,k}^T (M2_0 ^ M2_k) ^ V3_h^T M3_k ] == 0
    for k in range(nW):
        sl = slice(row_ptr, row_ptr + nRF)
        E[sl, 0:r1] = M1_w[k].T
        E[sl, (k + 1) * r1 : (k + 2) * r1] = (M1_0 ^ M1_w[k]).T
        if r2 > 0:
            E[sl, off_v2 : off_v2 + r2] = M2_w[k].T
            E[sl, off_al : off_al + H] ^= ((U_basis[:, k, :].astype(np.uint32) @ (M2_0 ^ M2_w[k]).astype(np.uint32)) & 1).T
        if r3 > 0:
            E[sl, off_al : off_al + H] ^= ((V3_basis.astype(np.uint32) @ d3["Mw"][k].astype(np.uint32)) & 1).T
        row_ptr += nRF

    # 3. Quadratic (W_a W_b, a < b):
    #    v1_a^T M1_b + v1_b^T M1_a + v2_0^T M2_{ab}
    #    + sum_h alpha_h [ Q_{h,ab}^T (M1_0 ^ M1_a ^ M1_b)
    #                    ^ U_{h,a}^T (M2_b ^ M2_{ab}) ^ U_{h,b}^T (M2_a ^ M2_{ab})
    #                    ^ V3_h^T M3_{ab} ] == 0
    pidx = 0
    for a in range(nW):
        M1_a = M1_w[a]
        for b in range(a + 1, nW):
            sl = slice(row_ptr, row_ptr + nRF)
            M1_b = M1_w[b]
            E[sl, (a + 1) * r1 : (a + 2) * r1] = M1_b.T
            E[sl, (b + 1) * r1 : (b + 2) * r1] = M1_a.T
            al_blk = ((Q_basis[:, pidx, :].astype(np.uint32) @ (M1_0 ^ M1_a ^ M1_b).astype(np.uint32)) & 1).T
            if r2 > 0:
                M2_ab = M2_ww[pidx]
                E[sl, off_v2 : off_v2 + r2] = M2_ab.T
                al_blk ^= ((U_basis[:, a, :].astype(np.uint32) @ (M2_w[b] ^ M2_ab).astype(np.uint32)) & 1).T
                al_blk ^= ((U_basis[:, b, :].astype(np.uint32) @ (M2_w[a] ^ M2_ab).astype(np.uint32)) & 1).T
            if r3 > 0:
                al_blk ^= ((V3_basis.astype(np.uint32) @ d3["Mww"][pidx].astype(np.uint32)) & 1).T
            E[sl, off_al : off_al + H] = al_blk
            row_ptr += nRF
            pidx += 1

    # Pack E into uint64 bitset [n_eqs_s2, n_words_s2]
    pad_cols = n_words_s2 * 64 - n_vars_s2
    if pad_cols > 0:
        E_pad = np.hstack([E, np.zeros((n_eqs_s2, pad_cols), dtype=np.uint8)])
    else:
        E_pad = E
    eq_bits = np.ascontiguousarray(np.packbits(E_pad, axis=1, bitorder="little").view(np.uint64))
    del E, E_pad

    max_null_s2 = 2048
    out_null_s2 = np.zeros((max_null_s2, n_words_s2), dtype=np.uint64)
    rk_s2 = ctypes.c_int(0)
    kn_s2 = lib70.solve_dense_gf2_nullspace_c(
        n_eqs_s2, n_vars_s2,
        eq_bits.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        out_null_s2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        max_null_s2, ctypes.byref(rk_s2),
    )
    dt2 = time.perf_counter() - t2
    print(
        f"  *** [{label} STAGE 2 EXACT BOOLEAN-RING LIFT] ***: vars={n_vars_s2:,} (H={H}), "
        f"eqs={n_eqs_s2:,} -> rank={rk_s2.value:,}/{n_vars_s2:,} | *** FULL_SYZ_NULLITY = {kn_s2} *** ({dt2:.1f}s)",
        flush=True,
    )

    if kn_s2 == 0:
        return {"kn_s1": kn_s1, "kn_s2": 0, "rk_512": 0, "hit_1": False}

    S = min(kn_s2, max_null_s2)
    sol_bits = np.unpackbits(
        out_null_s2[:S].view(np.uint8), axis=1, bitorder="little"
    )[:, :n_vars_s2]

    V1_0 = sol_bits[:, 0:r1].copy()
    V1_w = sol_bits[:, r1 : (nW + 1) * r1].reshape(S, nW, r1).copy()
    V2_0 = sol_bits[:, off_v2 : off_v2 + r2].copy() if r2 > 0 else np.zeros((S, 0), dtype=np.uint8)
    AL = sol_bits[:, off_al : off_al + H].copy()

    # Reconstruct top parts Q_sol [S, nPairs, r1], U_sol [S, nW, r2], V3_sol [S, r3]
    Q_sol = ((AL.astype(np.uint32) @ Q_basis.reshape(H, -1).astype(np.uint32)) & 1).astype(np.uint8).reshape(S, nPairs, r1)
    U_sol = ((AL.astype(np.uint32) @ U_basis.reshape(H, -1).astype(np.uint32)) & 1).astype(np.uint8).reshape(S, nW, r2) if r2 > 0 else np.zeros((S, nW, 0), dtype=np.uint8)
    V3_sol = ((AL.astype(np.uint32) @ V3_basis.astype(np.uint32)) & 1).astype(np.uint8) if r3 > 0 else np.zeros((S, 0), dtype=np.uint8)

    # Pair lookup array for fast batch evaluation
    pair_a = np.array([a for a in range(nW) for b in range(a + 1, nW)], dtype=np.int32)
    pair_b = np.array([b for a in range(nW) for b in range(a + 1, nW)], dtype=np.int32)

    # ZERO-TRUST VERIFY V1(W)^T M1(W) + V2(W)^T M2(W) + V3^T M3(W) == 0 on 64 random W (ALL nRF cols)!
    W_zt = rng.integers(0, 2, size=(64, nW), dtype=np.uint8)
    T_zt = blk["eval_t_batch"](W_zt)
    for bi in range(64):
        wv, tv = W_zt[bi], T_zt[bi]
        ww = (wv[pair_a] & wv[pair_b]).astype(np.uint8)
        # V1(wv): [S, r1]
        v1 = V1_0.copy()
        for k in np.flatnonzero(wv):
            v1 ^= V1_w[:, k, :]
        for pi in np.flatnonzero(ww):
            v1 ^= Q_sol[:, pi, :]
        M1_pt = blk["eval_drf1_mat_point"](blk["M1_strict_t"], wv, tv)
        acc = (v1.astype(np.uint32) @ M1_pt.astype(np.uint32)) & 1
        if r2 > 0:
            v2 = V2_0.copy()
            for k in np.flatnonzero(wv):
                v2 ^= U_sol[:, k, :]
            M2_pt = blk["eval_drf1_mat_point"](blk["DRF1_quad_t"], wv, tv)[r1:]
            acc ^= (v2.astype(np.uint32) @ M2_pt.astype(np.uint32)) & 1
        if r3 > 0:
            M3_pt = blk["eval_drf1_mat_point"](blk["DRF1_all_t"], wv, tv)[d3["keep_all"]]
            acc ^= (V3_sol.astype(np.uint32) @ M3_pt.astype(np.uint32)) & 1
        assert not np.any(acc), f"ZT FAIL [{label}]: Stage-2 syzygy violated at W_zt[{bi}]!"
    print(f"    [ZT-{label}-STAGE2]: Verified ALL {S} Boolean-ring syzygies on 64 random W (ALL {nRF} cols, 0 mismatches)!", flush=True)

    # Evaluate pure-W polynomials P(W) = V1(W)^T b1(W) + V2(W)^T b2(W) + V3^T b3(W)
    def eval_pure_W(W_mat):
        B = W_mat.shape[0]
        T_mat = blk["eval_t_batch"](W_mat)
        b1 = blk["M1_strict_b"](W_mat, T_mat)  # [B, r1]
        # Compute V1(W) . b1(W) in vectorized chunks:
        out = ((b1.astype(np.uint32) @ V1_0.T.astype(np.uint32)) & 1).astype(np.uint8)
        for k in range(nW):
            wk = W_mat[:, k : k + 1]
            if np.any(wk):
                out ^= ((b1.astype(np.uint32) @ V1_w[:, k, :].T.astype(np.uint32)) & 1).astype(np.uint8) & wk
        # Quadratic Q_sol: only sum over active pairs with non-zero Q_sol
        Q_nz_pairs = np.flatnonzero(np.any(Q_sol != 0, axis=(0, 2)))
        for pi in Q_nz_pairs:
            ww_col = (W_mat[:, pair_a[pi]] & W_mat[:, pair_b[pi]])[:, None]
            if np.any(ww_col):
                out ^= ((b1.astype(np.uint32) @ Q_sol[:, pi, :].T.astype(np.uint32)) & 1).astype(np.uint8) & ww_col
        if r2 > 0:
            b2 = b2_eval(W_mat, T_mat)
            out ^= ((b2.astype(np.uint32) @ V2_0.T.astype(np.uint32)) & 1).astype(np.uint8)
            for k in range(nW):
                wk = W_mat[:, k : k + 1]
                if np.any(wk):
                    out ^= ((b2.astype(np.uint32) @ U_sol[:, k, :].T.astype(np.uint32)) & 1).astype(np.uint8) & wk
        if r3 > 0:
            b3 = d3["b_eval"](W_mat, T_mat)
            out ^= ((b3.astype(np.uint32) @ V3_sol.T.astype(np.uint32)) & 1).astype(np.uint8)
        return out

    W_512, P_512, rk_512, hit_1, deg_hist, max_deg = exact_deg_census_eval(eval_pure_W, nW, S, seed=seed + 777)
    # Count how many Stage-2 syzygies actually have non-zero alpha (genuine top deg-3 lift vs deg<=1!)
    n_genuine_top = int(np.sum(np.any(AL != 0, axis=1)))
    print(
        f"  *** [{label} PURE-W RESULT] ***: S={S} (genuine_top={n_genuine_top}) | "
        f"*** 512pt_FUNC_RANK = {rk_512} *** | *** HIT_1=0: {hit_1} *** | deg_hist={deg_hist}",
        flush=True,
    )
    return {
        "kn_s1": kn_s1, "kn_s2": kn_s2, "S": S, "n_genuine_top": n_genuine_top,
        "rk_512": rk_512, "hit_1": hit_1, "deg_hist": deg_hist,
        "W_512": W_512, "P_512": P_512, "eval_pure_W": eval_pure_W,
    }


# ==============================================================================
# PART C: Symbolic ANF extraction & IR6 injection of B0_11's 2 SYZ-1C cubics!
# ==============================================================================

def extract_and_inject_b011_syz1c_cubics(em, root, eta_free, tbl, lib9, lib_sh, lib68, blk):
    """
    Symbolically extract the exact degree<=3 ANF of the 2 SYZ-1C pure-W cubics on B0_11,
    Zero-Trust verify on W_512 (0 mismatches), map back to original 109 vars c via W_forms_111,
    and inject into s9.run_branch_cascade at k_fix=0!
    """
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    DQ_t = blk["DRF1_quad_t"]
    rq = DQ_t["M0"].shape[0]
    M0_q, Mw_q, Mww_q = s68.expand_quad_pencil_in_W(DQ_t, blk["qt_c0"], blk["qt_lin"], blk["B_qt"], nW, nT, nRF)
    nv_c = (nW + 1) * rq
    nw_c = (nv_c + 63) // 64
    out_n = np.zeros((256, nw_c), dtype=np.uint64)
    out_rk = ctypes.c_int(0)
    kn = lib68.solve_syz_deg1_on_quad_pencil_c(
        nW, nRF, rq,
        M0_q.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        Mw_q.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        Mww_q.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        out_n.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        256, ctypes.byref(out_rk),
    )
    nu = s68.unpack_null_vecs(out_n, kn, nv_c)
    rng = np.random.default_rng(70900 + em)
    W_512 = rng.integers(0, 2, size=(512, nW), dtype=np.uint8)
    P_syz = s68.eval_syzygy_pure_W_polys(nu, nW, rq, 0, blk["DRF1_quad_b"], None, W_512, is_quad_full=True)

    # Pick linearly independent non-zero columns of P_syz
    piv = {}
    ind_cols = []
    for j in range(P_syz.shape[1]):
        v = 0
        for i in range(512):
            if P_syz[i, j]:
                v |= (1 << i)
        orig_v = v
        while v:
            lb = v & -v
            if lb in piv:
                v ^= piv[lb]
            else:
                piv[lb] = v
                ind_cols.append(j)
                break
    print(f"\n  [PART C B0_11 eta={em}] SYZ-1C independent pure-W polys: {len(ind_cols)} (from kn={kn})", flush=True)
    if not ind_cols:
        return

    # Exact Möbius extraction of degree<=3 ANF in W using direct evaluation on all wt<=3 vectors of F_2^nW!
    # Total vectors of wt <= 3: 1 + 44 + 946 + 13244 = 14,235 -> evaluates in 0.15s!
    mon_list = [()]
    for i in range(nW):
        mon_list.append((i,))
    for i in range(nW):
        for j in range(i + 1, nW):
            mon_list.append((i, j))
    for i in range(nW):
        for j in range(i + 1, nW):
            for k in range(j + 1, nW):
                mon_list.append((i, j, k))
    nM = len(mon_list)
    W_probe = np.zeros((nM, nW), dtype=np.uint8)
    for idx, tup in enumerate(mon_list):
        for v in tup:
            W_probe[idx, v] = 1
    nu_sel = nu[ind_cols]
    F_probe = s68.eval_syzygy_pure_W_polys(nu_sel, nW, rq, 0, blk["DRF1_quad_b"], None, W_probe, is_quad_full=True)

    # Exact Mobius inversion for wt<=3:
    # c(0) = f(0)
    # c(i) = f(e_i) ^ c(0)
    # c(i,j) = f(e_i+e_j) ^ c(i) ^ c(j) ^ c(0)
    # c(i,j,k) = f(e_i+e_j+e_k) ^ c(i,j) ^ c(i,k) ^ c(j,k) ^ c(i) ^ c(j) ^ c(k) ^ c(0)
    mon_to_idx = {m: idx for idx, m in enumerate(mon_list)}
    C_anf = np.zeros_like(F_probe)
    C_anf[0] = F_probe[0]
    for i in range(nW):
        idx = mon_to_idx[(i,)]
        C_anf[idx] = F_probe[idx] ^ C_anf[0]
    for i in range(nW):
        ii = mon_to_idx[(i,)]
        for j in range(i + 1, nW):
            jj = mon_to_idx[(j,)]
            ij = mon_to_idx[(i, j)]
            C_anf[ij] = F_probe[ij] ^ C_anf[ii] ^ C_anf[jj] ^ C_anf[0]
    for i in range(nW):
        ii = mon_to_idx[(i,)]
        for j in range(i + 1, nW):
            jj = mon_to_idx[(j,)]
            ij = mon_to_idx[(i, j)]
            for k in range(j + 1, nW):
                kk = mon_to_idx[(k,)]
                ik = mon_to_idx[(i, k)]
                jk = mon_to_idx[(j, k)]
                ijk = mon_to_idx[(i, j, k)]
                C_anf[ijk] = F_probe[ijk] ^ C_anf[ij] ^ C_anf[ik] ^ C_anf[jk] ^ C_anf[ii] ^ C_anf[jj] ^ C_anf[kk] ^ C_anf[0]

    # ZERO-TRUST VERIFY extracted deg<=3 ANF against P_syz[:, ind_cols] on ALL 512 random W!
    for ci in range(len(ind_cols)):
        nz_m = np.flatnonzero(C_anf[:, ci])
        pred = np.zeros(512, dtype=np.uint8)
        for mi in nz_m:
            tup = mon_list[mi]
            if len(tup) == 0:
                pred ^= 1
            elif len(tup) == 1:
                pred ^= W_512[:, tup[0]]
            elif len(tup) == 2:
                pred ^= (W_512[:, tup[0]] & W_512[:, tup[1]])
            else:
                pred ^= (W_512[:, tup[0]] & W_512[:, tup[1]] & W_512[:, tup[2]])
        mis = int(np.sum(pred != P_syz[:, ind_cols[ci]]))
        print(f"    [ZT-PART-C poly #{ci}]: deg<=3 ANF terms={len(nz_m)} | 512-pt mismatches={mis}", flush=True)
        assert mis == 0, f"ZT FAIL: poly #{ci} has deg > 3 or mismatch ({mis})!"

    # Pull back each pure-W cubic ANF to original 109-variable c-space using W_forms_111!
    W_forms = blk["W_forms_111"]
    n_c = tbl["n"]
    n_cw = tbl["n_col_words"]

    def lin_mask_to_vars(mask):
        out = []
        tmp = mask
        while tmp:
            lb = tmp & -tmp
            out.append(lb.bit_length() - 1)
            tmp ^= lb
        return out

    W_var_lists = [lin_mask_to_vars(m) for m in W_forms]
    c_psets = []
    for ci in range(len(ind_cols)):
        ps = set()
        for mi in np.flatnonzero(C_anf[:, ci]):
            tup = mon_list[mi]
            if len(tup) == 0:
                ps ^= {0}
            elif len(tup) == 1:
                for v0 in W_var_lists[tup[0]]:
                    ps ^= {1 << v0}
            elif len(tup) == 2:
                for v0 in W_var_lists[tup[0]]:
                    for v1 in W_var_lists[tup[1]]:
                        ps ^= {(1 << v0) | (1 << v1)}
            else:
                for v0 in W_var_lists[tup[0]]:
                    for v1 in W_var_lists[tup[1]]:
                        m01 = (1 << v0) | (1 << v1)
                        for v2 in W_var_lists[tup[2]]:
                            ps ^= {m01 | (1 << v2)}
        c_psets.append(ps)
        max_d = max((m.bit_count() for m in ps), default=0)
        print(f"    [PART C poly #{ci} pullback to c]: terms={len(ps)}, max_deg={max_d}", flush=True)

    # Inject into s9.run_branch_cascade at eta (k_fix = 0)!
    n_ef = len(eta_free)
    ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
    sr_base = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=False,
    )
    # Append c_psets to root["_buf"] copy and re-run s9!
    n_old_q = len(root["_quad_ids"])
    n_old_c = len(root["_cub_ids"])
    n_tot_old = len(root["_buf"]) // n_cw
    n_add = len(c_psets)
    new_buf = (ctypes.c_uint64 * ((n_tot_old + n_add) * n_cw))()
    ctypes.memmove(new_buf, root["_buf"], n_tot_old * n_cw * 8)
    new_cids = list(root["_cub_ids"])
    for idx_a, ps in enumerate(c_psets):
        rid = n_tot_old + idx_a
        s9.pset_to_row(ps, new_buf, rid, tbl)
        new_cids.append(rid)

    sr_inj = s9.run_branch_cascade(
        lib9, new_buf, root["_quad_ids"], new_cids, root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=False,
    )
    print(
        f"  *** [PART C INJECTION B0_11 eta={em}] ***:\n"
        f"      BASE: closed={sr_base['closed_unsat']}, N={sr_base.get('N_active')}, q={len(sr_base.get('_quad_ids', []))}, c={len(sr_base.get('_cub_ids', []))}\n"
        f"      +SYZ: closed={sr_inj['closed_unsat']}, N={sr_inj.get('N_active')}, q={len(sr_inj.get('_quad_ids', []))}, c={len(sr_inj.get('_cub_ids', []))}",
        flush=True,
    )


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", required=True, choices=["B0_00", "B0_11", "B1_11"])
    ap.add_argument("--etas", nargs="+", type=int, required=True)
    ap.add_argument("--modes", nargs="+", default=["syz1a_h", "syz2a", "wsyz3", "partc"])
    args = ap.parse_args()
    t0 = time.perf_counter()

    lib70 = compile_step70_c()
    lib68 = s68.compile_step68_c()
    env = s63a.setup_cell_env(args.cell)
    lib9, lib_sh = env["lib9"], env["lib_sh"]
    tbl, root, eta_free = env["tbl"], env["root"], env["eta_free"]

    for em in args.etas:
        print(f"\n################################################################################", flush=True)
        print(f"  STEP 70: {args.cell} eta={em} (modes={args.modes})", flush=True)
        print(f"################################################################################", flush=True)
        blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=7000 + em)
        if blk["closed_unsat"]:
            print(f"  [{args.cell} eta={em}] CLOSED UNSAT AT ETA!", flush=True)
            continue

        nW, nRF = blk["nW"], blk["nRF"]
        M1_w = np.ascontiguousarray(blk["M1_strict_t"]["Mw"], dtype=np.uint8)
        r1 = M1_w.shape[1]
        act_cols = [j for j in range(nRF) if np.any(M1_w[:, :, j] != 0)]
        M1_w_act = np.ascontiguousarray(M1_w[:, :, act_cols], dtype=np.uint8)

        if "syz1a_h" in args.modes:
            rk1 = ctypes.c_int(0)
            kn1 = lib70.solve_syz1a_homog_c(
                nW, len(act_cols), r1,
                M1_w_act.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                ctypes.byref(rk1),
            )
            print(
                f"  [DIAG {args.cell} eta={em} SYZ-1A HOMOG]: nW={nW}, r1={r1}, nRF_act={len(act_cols)}/{nRF} "
                f"-> rank={rk1.value}/{nW*r1} | *** NULLITY_1A_HOMOG = {kn1} ***",
                flush=True,
            )

        if "partc" in args.modes and args.cell == "B0_11":
            extract_and_inject_b011_syz1c_cubics(em, root, eta_free, tbl, lib9, lib_sh, lib68, blk)

        if "syz2a" in args.modes:
            run_stage1_and_stage2(
                f"{args.cell}_e{em}_SYZ2A", blk, lib70,
                include_block2=False, include_block3=False,
                max_null=3000, seed=70100 + em,
            )

        if "wsyz3" in args.modes:
            run_stage1_and_stage2(
                f"{args.cell}_e{em}_WSYZ3", blk, lib70,
                include_block2=True, include_block3=True,
                max_null=3000, seed=70200 + em,
            )

    print(f"\n[STEP 70 {args.cell} etas={args.etas}] COMPLETED in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()
