#!/usr/bin/env python3
"""
SOLVE_B111_SIG_INJECT.py

Pure-Algebraic 6-Coset (ff, 55, 33, 11, 77, e0) Signature Generator Injection for B1_11 (e=1, c99=1, force_k=1).
Uses compact signature files in b111_sig_inj/:
  - inj_b111_e1_sNN_e0V.json                   (expanded linear + quadratic generators in 0..110 vars)
  - inj_b111_e1_sNN_e0V_cubicas_compactas.json (compact minimal cubics for Q5 and e0)

Features an embedded C/OpenMP Fast Factored Compact-Cubic Expander (C_COMPACT_EXPAND_SRC) that:
  1. Pre-reduces the linear forms F_j modulo the current linear pivots (so expanded cubic rows
     contain ZERO pivot variables),
  2. Groups degree-3 y-monomials (j1 < j2 < j3) by prefix pair (j1, j2) into
       sum_{j1 < j2} (F_{j1}(x) * F_{j2}(x)) * (XOR_{j3 > j2} F_{j3}(x)),
     expanding 301 dense 100-variable cubics directly into s9's packed uint64_t row buffer in ~0.5s
     using <10 MB RAM (instead of 150 MB JSON text),
  3. Zero-Trust verifies EVERY expanded C cubic row against direct unexpanded y_j evaluation on
     64 random 111-bit vectors (0 mismatches), PLUS runs direct truth-table spectral Zero-Trust
     verification on fiber points matching the signature targets!

Targets (--job):
  1. S11_E0_0   : s11 (-64, 64, -64, -64, 64), e0=0   (1L + 44Q + 301C_Q5 + 0C_e0)
  2. S00_E0_0   : s00 (-64, -64,  0,   0,  0), e0=0   (1L + 39Q +  26C_Q5 + 0C_e0, 32/92 orbits)
  3. S00_E0_M32 : s00 (-64, -64,  0,   0,  0), e0=-32 (1L + 39Q +  26C_Q5 + 165C_e0 = 191C)
  4. S01_E0_0   : s01 (-64,  64, -64,  0,  0), e0=0   (1L + 41Q + 109C_Q5 + 0C_e0, 24/92 orbits w/ s02)
"""

import argparse
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
SIG_INJ_DIR = WORK_DIR / "b111_sig_inj"
sys.path.insert(0, str(WORK_DIR))

import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP64A_AC180_MAC3_FUSION as s64a
import SOLVE_B111_B011_POISSON_ALGEBRA as spois

JOB_SPECS = {
    "S11_E0_0": {
        "base_json": "inj_b111_e1_s11_e0+0.json",
        "comp_json": "inj_b111_e1_s11_e0+0_cubicas_compactas.json",
        "sig5": {0xFF: -64, 0x55: 64, 0x33: -64, 0x11: -64, 0x77: 64},
        "e0": 0,
    },
    "S00_E0_0": {
        "base_json": "inj_b111_e1_s00_e0+0.json",
        "comp_json": "inj_b111_e1_s00_e0+0_cubicas_compactas.json",
        "sig5": {0xFF: -64, 0x55: -64, 0x33: 0, 0x11: 0, 0x77: 0},
        "e0": 0,
    },
    "S00_E0_M32": {
        "base_json": "inj_b111_e1_s00_e0-32.json",
        "comp_json": "inj_b111_e1_s00_e0-32_cubicas_compactas.json",
        "sig5": {0xFF: -64, 0x55: -64, 0x33: 0, 0x11: 0, 0x77: 0},
        "e0": -32,
    },
    "S01_E0_0": {
        "base_json": "inj_b111_e1_s01_e0+0.json",
        "comp_json": "inj_b111_e1_s01_e0+0_cubicas_compactas.json",
        "sig5": {0xFF: -64, 0x55: 64, 0x33: -64, 0x11: 0, 0x77: 0},
        "e0": 0,
    },
}

C_COMPACT_EXPAND_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

static inline void toggle_bit(uint64_t *row, int col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

static inline int col_of_2(int a, int b, int off2, const int *col2_base) {
    if (a > b) { int t = a; a = b; b = t; }
    return off2 + col2_base[a] + (b - a - 1);
}

static inline int col_of_3(int a, int b, int c, int n, const int *col3_base) {
    int t;
    if (a > b) { t = a; a = b; b = t; }
    if (b > c) { t = b; b = c; c = t; }
    if (a > b) { t = a; a = b; b = t; }
    return col3_base[a * n + b] + (c - b - 1);
}

/*
 * Multiply an affine linear form (mask_lo, mask_hi, const_c) into an accumulator polynomial
 * represented as a packed s9 row? No: even simpler!
 * For K <= 32 affine linear forms y_j = c_j ^ <F_j, x> (j = 0..K-1):
 * First, in Python (or C), any product y_{j1} y_{j2} y_{j3} where y_j = c_j ^ Y_j (with Y_j = <F_j, x> homogeneous!)
 * expands immediately in y-coordinates into homogeneous products of Y_j (degrees 0, 1, 2, 3)!
 * So here in C, all K forms F_0..F_{K-1} are PURELY HOMOGENEOUS 111-bit masks (f_lo[j], f_hi[j])!
 *
 * For each cubic p in 0..n_cubs-1:
 *   - c0_p (uint8_t): constant term
 *   - lin_lo[p], lin_hi[p]: combined homogeneous degree-1 mask in x (XOR of F_j for [j] in P)
 *   - For each pair idx_pair = (j1 < j2) in 0..n_pairs-1:
 *       * has_q2[p * n_pairs + idx_pair] (uint8_t): 1 if [j1, j2] in P
 *       * l3_lo[p * n_pairs + idx_pair], l3_hi[p * n_pairs + idx_pair]:
 *         combined homogeneous linear mask L_{j1,j2}(x) = XOR_{j3 > j2 : [j1,j2,j3] in P} F_{j3}(x)!
 */
void expand_factored_cubics_batch_c(
    int K,
    const uint64_t *f_lo,
    const uint64_t *f_hi,
    int n_cubs,
    const uint8_t *c0_arr,
    const uint64_t *lin_lo,
    const uint64_t *lin_hi,
    int n_pairs,
    const int *pair_j1,
    const int *pair_j2,
    const uint8_t *has_q2,
    const uint64_t *l3_lo,
    const uint64_t *l3_hi,
    int n,
    int off2,
    int off1,
    int off0,
    int n_cw,
    const int *col2_base,
    const int *col3_base,
    uint64_t *out_rows
) {
    memset(out_rows, 0, (size_t)n_cubs * (size_t)n_cw * sizeof(uint64_t));

    /* Precompute Q_{j1, j2}(x) = F_{j1}(x) * F_{j2}(x) for all n_pairs <= 496 pairs */
    int *q1_cnt = (int *)calloc((size_t)n_pairs, sizeof(int));
    int *q1_v = (int *)malloc((size_t)n_pairs * 112 * sizeof(int));
    int *q2_cnt = (int *)calloc((size_t)n_pairs, sizeof(int));
    uint16_t *q2_u = (uint16_t *)malloc((size_t)n_pairs * 6160 * sizeof(uint16_t));
    uint16_t *q2_v = (uint16_t *)malloc((size_t)n_pairs * 6160 * sizeof(uint16_t));

    for (int pr = 0; pr < n_pairs; pr++) {
        int j1 = pair_j1[pr], j2 = pair_j2[pr];
        uint64_t lo1 = f_lo[j1], hi1 = f_hi[j1];
        uint64_t lo2 = f_lo[j2], hi2 = f_hi[j2];
        uint8_t b1[112], b2[112];
        for (int i = 0; i < n; i++) {
            b1[i] = (i < 64) ? (uint8_t)((lo1 >> i) & 1ULL) : (uint8_t)((hi1 >> (i - 64)) & 1ULL);
            b2[i] = (i < 64) ? (uint8_t)((lo2 >> i) & 1ULL) : (uint8_t)((hi2 >> (i - 64)) & 1ULL);
        }
        int c1 = 0, c2 = 0;
        for (int u = 0; u < n; u++) {
            if (b1[u] && b2[u]) {
                q1_v[pr * 112 + c1++] = u;
            }
            for (int v = u + 1; v < n; v++) {
                if ((b1[u] & b2[v]) ^ (b1[v] & b2[u])) {
                    q2_u[pr * 6160 + c2] = (uint16_t)u;
                    q2_v[pr * 6160 + c2] = (uint16_t)v;
                    c2++;
                }
            }
        }
        q1_cnt[pr] = c1;
        q2_cnt[pr] = c2;
    }

    #pragma omp parallel for schedule(dynamic, 1)
    for (int p = 0; p < n_cubs; p++) {
        uint64_t *row = out_rows + (size_t)p * (size_t)n_cw;
        if (c0_arr[p]) toggle_bit(row, off0);

        uint64_t llo = lin_lo[p], lhi = lin_hi[p];
        for (int i = 0; i < n; i++) {
            int bit = (i < 64) ? (int)((llo >> i) & 1ULL) : (int)((lhi >> (i - 64)) & 1ULL);
            if (bit) toggle_bit(row, off1 + i);
        }

        for (int pr = 0; pr < n_pairs; pr++) {
            size_t idx = (size_t)p * (size_t)n_pairs + (size_t)pr;
            uint8_t hq2 = has_q2[idx];
            uint64_t mlo = l3_lo[idx], mhi = l3_hi[idx];
            if (!hq2 && mlo == 0ULL && mhi == 0ULL) continue;

            int c1 = q1_cnt[pr];
            const int *p_q1 = q1_v + pr * 112;
            int c2 = q2_cnt[pr];
            const uint16_t *p_u = q2_u + pr * 6160;
            const uint16_t *p_v = q2_v + pr * 6160;

            if (hq2) {
                for (int k = 0; k < c1; k++) {
                    toggle_bit(row, off1 + p_q1[k]);
                }
                for (int k = 0; k < c2; k++) {
                    toggle_bit(row, col_of_2((int)p_u[k], (int)p_v[k], off2, col2_base));
                }
            }

            if (mlo != 0ULL || mhi != 0ULL) {
                int lvars[112], nL = 0;
                uint64_t tlo = mlo, thi = mhi;
                while (tlo) {
                    int b = __builtin_ctzll(tlo);
                    tlo &= tlo - 1ULL;
                    lvars[nL++] = b;
                }
                while (thi) {
                    int b = __builtin_ctzll(thi);
                    thi &= thi - 1ULL;
                    lvars[nL++] = 64 + b;
                }

                for (int k = 0; k < c1; k++) {
                    int u = p_q1[k];
                    for (int lw = 0; lw < nL; lw++) {
                        int w = lvars[lw];
                        if (u == w) toggle_bit(row, off1 + u);
                        else toggle_bit(row, col_of_2(u, w, off2, col2_base));
                    }
                }
                for (int k = 0; k < c2; k++) {
                    int u = (int)p_u[k], v = (int)p_v[k];
                    int c2_uv = col_of_2(u, v, off2, col2_base);
                    for (int lw = 0; lw < nL; lw++) {
                        int w = lvars[lw];
                        if (w == u || w == v) toggle_bit(row, c2_uv);
                        else toggle_bit(row, col_of_3(u, v, w, n, col3_base));
                    }
                }
            }
        }
    }

    free(q1_cnt);
    free(q1_v);
    free(q2_cnt);
    free(q2_u);
    free(q2_v);
}
"""


def compile_compact_expander():
    c_path = WORK_DIR / "scomp_exp.c"
    so_path = WORK_DIR / "libscomp_exp.so"
    c_path.write_text(C_COMPACT_EXPAND_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_path))
    lib.expand_factored_cubics_batch_c.argtypes = [
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64),
    ]
    return lib


def reduce_linear_form_mod_pivs(vars_list, lin_pivs):
    """
    Given a linear form sum_{v in vars_list} x_v, substitute all p in lin_pivs
    (where x_p = pr ^ sum_{q in pv ^ (1<<p)} x_q) to obtain an equivalent affine form
    (mask_111, const_bit) supported purely on active (non-pivot) variables!
    """
    mask = 0
    for v in vars_list:
        mask ^= 1 << int(v)
    c_bit = 0
    for p in sorted(lin_pivs.keys(), reverse=True):
        if (mask >> p) & 1:
            pv, pr = lin_pivs[p]
            mask ^= pv
            c_bit ^= pr
    assert not any((mask >> p) & 1 for p in lin_pivs), "Pivot leak after linear form reduction!"
    return mask, c_bit


def expand_compact_block_to_c_rows(formas, cubicas, lin_pivs, lib_exp, lib9, tbl, zt_seed=12801):
    """
    Expand a compact block (formas, cubicas) modulo lin_pivs directly into s9 uint64_t rows
    and run a 64-point algebraic Zero-Trust equivalence check on EVERY expanded row!
    """
    t0 = time.perf_counter()
    n_cubs = len(cubicas)
    if n_cubs == 0:
        return None, 0, {"n_cubs": 0, "zt_vectors": 0, "zt_mismatches": 0, "elapsed_s": 0.0}

    K = len(formas)
    # Reduce each form j in 0..K-1 modulo lin_pivs: y_j = c_j ^ Y_j, where Y_j = <F_j, x> is homogeneous!
    F_masks = []
    F_consts = []
    for f_vars in formas:
        m_j, c_j = reduce_linear_form_mod_pivs(f_vars, lin_pivs)
        F_masks.append(m_j)
        F_consts.append(c_j)

    # Pair indexing (j1 < j2)
    pair_to_idx = {}
    pair_j1, pair_j2 = [], []
    for j1 in range(K):
        for j2 in range(j1 + 1, K):
            pair_to_idx[(j1, j2)] = len(pair_j1)
            pair_j1.append(j1)
            pair_j2.append(j2)
    n_pairs = len(pair_j1)

    c0_arr = (ctypes.c_uint8 * n_cubs)()
    lin_lo = (ctypes.c_uint64 * n_cubs)()
    lin_hi = (ctypes.c_uint64 * n_cubs)()
    has_q2 = (ctypes.c_uint8 * (n_cubs * max(1, n_pairs)))()
    l3_lo = (ctypes.c_uint64 * (n_cubs * max(1, n_pairs)))()
    l3_hi = (ctypes.c_uint64 * (n_cubs * max(1, n_pairs)))()
    mask64 = (1 << 64) - 1

    # Convert each polynomial in y_j = c_j ^ Y_j into homogeneous polynomial in Y_j!
    for p_idx, poly in enumerate(cubicas):
        hom_terms = set()

        def toggle_hom(t_tuple):
            if t_tuple in hom_terms:
                hom_terms.remove(t_tuple)
            else:
                hom_terms.add(t_tuple)

        for mono in poly:
            # Expand product_{j in mono} (c_j ^ Y_j)
            u_j = sorted(set(int(j) for j in mono))
            d_m = len(u_j)
            for sub_mask in range(1 << d_m):
                # Bits with 0 pick c_j; bits with 1 pick Y_j
                ok_c = True
                chosen_Y = []
                for b_i in range(d_m):
                    j = u_j[b_i]
                    if (sub_mask >> b_i) & 1:
                        chosen_Y.append(j)
                    else:
                        if F_consts[j] == 0:
                            ok_c = False
                            break
                if ok_c:
                    toggle_hom(tuple(chosen_Y))

        c0 = 0
        l_mask = 0
        l3_masks = [0] * max(1, n_pairs)
        for ht in hom_terms:
            if len(ht) == 0:
                c0 ^= 1
            elif len(ht) == 1:
                l_mask ^= F_masks[ht[0]]
            elif len(ht) == 2:
                pr = pair_to_idx[ht]
                has_q2[p_idx * n_pairs + pr] ^= 1
            elif len(ht) == 3:
                pr = pair_to_idx[(ht[0], ht[1])]
                l3_masks[pr] ^= F_masks[ht[2]]

        c0_arr[p_idx] = c0
        lin_lo[p_idx] = l_mask & mask64
        lin_hi[p_idx] = l_mask >> 64
        for pr in range(n_pairs):
            m3 = l3_masks[pr]
            if m3:
                l3_lo[p_idx * n_pairs + pr] = m3 & mask64
                l3_hi[p_idx * n_pairs + pr] = m3 >> 64

    f_lo = (ctypes.c_uint64 * max(1, K))(*[m & mask64 for m in F_masks])
    f_hi = (ctypes.c_uint64 * max(1, K))(*[m >> 64 for m in F_masks])
    pj1_arr = (ctypes.c_int * max(1, n_pairs))(*pair_j1)
    pj2_arr = (ctypes.c_int * max(1, n_pairs))(*pair_j2)

    n, n_cw = tbl["n"], tbl["n_col_words"]
    out_rows = (ctypes.c_uint64 * (n_cubs * n_cw))()

    lib_exp.expand_factored_cubics_batch_c(
        K, f_lo, f_hi, n_cubs, c0_arr, lin_lo, lin_hi,
        n_pairs, pj1_arr, pj2_arr, has_q2, l3_lo, l3_hi,
        n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
        tbl["col2_base"], tbl["col3_base"], out_rows,
    )

    # Level-2 Zero-Trust Audit: verify EVERY expanded C row against direct unexpanded y_j evaluation on 64 random vectors!
    rng = random.Random(zt_seed)
    f_act = [i for i in range(111) if i not in lin_pivs]
    n_zt = 64
    zt_mismatches = 0
    for _ in range(n_zt):
        x_act = 0
        for i in f_act:
            if rng.getrandbits(1):
                x_act |= 1 << i
        # Reconstruct full 111-bit x satisfying lin_pivs
        x_full = x_act
        for p in sorted(lin_pivs.keys()):
            pv, pr = lin_pivs[p]
            rem = pv ^ (1 << p)
            bit_p = pr ^ ((x_full & rem).bit_count() & 1)
            if bit_p:
                x_full |= 1 << p
        # Evaluate y_j directly from original unreduced formas on x_full!
        y_vals = [sum((x_full >> int(v)) & 1 for v in f_vars) & 1 for f_vars in formas]
        x_lo = x_act & mask64
        x_hi = x_act >> 64
        for p_idx, poly in enumerate(cubicas):
            v_direct = 0
            for mono in poly:
                prod = 1
                for j in mono:
                    if not y_vals[int(j)]:
                        prod = 0
                        break
                v_direct ^= prod
            rptr = ctypes.cast(ctypes.byref(out_rows, p_idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            v_crow = lib9.eval_row_s9(
                rptr, n_cw, tbl["off0"] + 1,
                tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                x_lo, x_hi,
            )
            if v_direct != v_crow:
                zt_mismatches += 1

    assert zt_mismatches == 0, f"COMPACT EXPAND ZT FAIL: {zt_mismatches} mismatches across {n_cubs} cubics x {n_zt} pts!"
    dt = round(time.perf_counter() - t0, 2)
    print(f"  [COMPACT EXPAND C ({dt}s)] expanded {n_cubs} cubics (K={K} forms) | ZT {n_cubs}x{n_zt}: 0 mismatches!", flush=True)
    return out_rows, n_cubs, {"n_cubs": n_cubs, "K_forms": K, "zt_vectors": n_zt, "zt_mismatches": zt_mismatches, "elapsed_s": dt}


def state_sig(sr):
    if sr["closed_unsat"]:
        return {"closed": True, "dim": 0, "quads": 0, "cubs": 0}
    return {
        "closed": False,
        "dim": 111 - len(sr["_lin_pivs"]),
        "quads": len(sr["_quad_ids"]),
        "cubs": len(sr["_cub_ids"]),
    }


def inject_raw_c_rows_into_s9(sub_state, new_rows_buf, n_new_rows, lib9, tbl):
    """Append pre-substituted C rows (already reduced mod sub_state['_lin_pivs']) into sub_state and run s9 XL cascade."""
    if n_new_rows == 0 or sub_state["closed_unsat"]:
        return sub_state
    n_cw = tbl["n_col_words"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    q_ids = list(sub_state["_quad_ids"])
    c_ids = list(sub_state["_cub_ids"])
    n_old_q = len(q_ids)
    n_old_c = len(c_ids)
    n_old = n_old_q + n_old_c

    tot = n_old + n_new_rows
    new_buf = (ctypes.c_uint64 * (tot * n_cw))()
    for idx, r in enumerate(q_ids):
        ctypes.memmove(ctypes.byref(new_buf, idx * n_cw * 8), ctypes.byref(sub_state["_buf"], r * n_cw * 8), n_cw * 8)
    for idx, r in enumerate(c_ids):
        ctypes.memmove(ctypes.byref(new_buf, (n_old_q + idx) * n_cw * 8), ctypes.byref(sub_state["_buf"], r * n_cw * 8), n_cw * 8)

    new_q = list(range(n_old_q))
    new_c = list(range(n_old_q, n_old))
    ex_lin = []

    for r_i in range(n_new_rows):
        dst_idx = n_old + r_i
        ctypes.memmove(
            ctypes.byref(new_buf, dst_idx * n_cw * 8),
            ctypes.byref(new_rows_buf, r_i * n_cw * 8),
            n_cw * 8,
        )
        # Classify degree of row dst_idx
        min_col = None
        base_w = dst_idx * n_cw
        for w in range(n_cw):
            val = int(new_buf[base_w + w])
            if val:
                lb = val & -val
                min_col = (w << 6) + (lb.bit_length() - 1)
                break
        if min_col is None:
            continue
        if min_col == off0:
            return {"closed_unsat": True, "_lin_pivs": dict(sub_state["_lin_pivs"]), "_quad_ids": [], "_cub_ids": []}
        elif min_col >= off1:
            ps = s9.row_to_pset(new_buf, dst_idx, tbl)
            fm, rhs = 0, 0
            for m in ps:
                if m == 0:
                    rhs ^= 1
                else:
                    fm ^= m
            if fm or rhs:
                ex_lin.append((fm, rhs))
        elif min_col >= off2:
            new_q.append(dst_idx)
        else:
            new_c.append(dst_idx)

    return s9.run_branch_cascade(
        lib9, new_buf, new_q, new_c, sub_state["_lin_pivs"],
        ex_lin, tbl, max_xl_rounds=25, verify_subst=False,
    )


def run_job(job_name, libs, lib_exp):
    t0 = time.perf_counter()
    spec = JOB_SPECS[job_name]
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs

    env = spois.build_cell_root_sound("B1_11", libs)
    tbl = env["tbl"]
    sr_base = spois.fix_a14_fiber(env, 1, lib9)
    base_wess = spois.measure_wess("B1_11_e1_base", sr_base, lib9, lib_sh, tbl, rng_seed=12801)
    print(f"\n[B1_11 e=1 BASELINE W_ess]: {base_wess}", flush=True)

    f_act = sorted(i for i in range(111) if i not in sr_base["_lin_pivs"])
    f_act_set = set(f_act)

    base_data = json.loads((SIG_INJ_DIR / spec["base_json"]).read_text(encoding="utf-8"))["1"]
    comp_data = json.loads((SIG_INJ_DIR / spec["comp_json"]).read_text(encoding="utf-8"))

    lin_list = base_data.get("lin", [])
    poly_list = base_data.get("polys", [])

    # Verify 0 pivot leaks against sr_base['_lin_pivs']
    all_vars_used = {v for vars_, _ in lin_list for v in vars_} | {v for p in poly_list for m in p for v in m}
    for blk in ("Q5", "e0"):
        all_vars_used |= {v for f_vars in comp_data[blk]["formas"] for v in f_vars}
    leaked_pivs = sorted(all_vars_used - f_act_set)
    assert not leaked_pivs, f"PIVOT LEAK in {job_name}: {leaked_pivs}"

    psets_lin = []
    for vars_, c in lin_list:
        ps = {1 << int(v) for v in vars_}
        if int(c) & 1:
            ps.add(0)
        if ps:
            psets_lin.append(ps)

    psets_deg2 = []
    for p in poly_list:
        ps = set()
        for mono in p:
            m_mask = 0
            for v in mono:
                m_mask |= 1 << int(v)
            if m_mask in ps:
                ps.remove(m_mask)
            else:
                ps.add(m_mask)
        if ps:
            psets_deg2.append(ps)

    # Level-1 Direct Truth-Table Spectral Zero-Trust Check:
    # Verify lin (on W_ff == sig5[0xff]), e0 compact cubics (on W_01 == e0), and Q5 quads/cubics!
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_base["_lin_pivs"], f_act)
    sig5 = spec["sig5"]
    e0_tgt = spec["e0"]
    zs_all = (0xFF, 0x55, 0x33, 0x11, 0x77, 0x01)
    idx_map = {z: np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.int32) for z in zs_all}
    o_z = {z: orig_f[idx_map[z]] for z in zs_all}
    b_z = {z: basis_f[:, idx_map[z]] for z in zs_all}

    def eval_ps(ps, x111):
        val = 0
        for mon in ps:
            if (x111 & mon) == mon:
                val ^= 1
        return val

    def eval_compact_block(formas, cubicas, x111):
        y_vals = [sum((x111 >> int(v)) & 1 for v in f_vars) & 1 for f_vars in formas]
        for poly in cubicas:
            v_p = 0
            for mono in poly:
                prod = 1
                for j in mono:
                    if not y_vals[int(j)]:
                        prod = 0
                        break
                v_p ^= prod
            if v_p:
                return True
        return False

    rng = random.Random(12850)
    N = len(f_act)
    n_ff_match, n_ff_viol = 0, 0
    n_e0_match, n_e0_viol = 0, 0
    n_q5_match, n_q5_viol_q, n_q5_viol_c = 0, 0, 0
    e0_formas = comp_data["e0"]["formas"]
    e0_cubs = comp_data["e0"]["cubicas"]
    q5_formas = comp_data["Q5"]["formas"]
    q5_cubs = comp_data["Q5"]["cubicas"]

    for _ in range(12000):
        x111 = 0
        picks = [rng.getrandbits(1) for _ in range(N)]
        cff = o_z[0xFF].copy()
        c01 = o_z[0x01].copy()
        for i, bit in enumerate(picks):
            if bit:
                x111 |= 1 << f_act[i]
                cff ^= b_z[0xFF][i]
                c01 ^= b_z[0x01][i]
        w_ff = 256 - 2 * int(cff.sum())
        w_01 = 256 - 2 * int(c01.sum())

        if w_ff == sig5[0xFF]:
            n_ff_match += 1
            if any(eval_ps(ps, x111) for ps in psets_lin):
                n_ff_viol += 1
            # Check remaining 4 cosets of Q5
            c55 = o_z[0x55].copy()
            for i, bit in enumerate(picks):
                if bit:
                    c55 ^= b_z[0x55][i]
            if 256 - 2 * int(c55.sum()) == sig5[0x55]:
                c33 = o_z[0x33].copy()
                for i, bit in enumerate(picks):
                    if bit:
                        c33 ^= b_z[0x33][i]
                if 256 - 2 * int(c33.sum()) == sig5[0x33]:
                    c11 = o_z[0x11].copy()
                    for i, bit in enumerate(picks):
                        if bit:
                            c11 ^= b_z[0x11][i]
                    if 256 - 2 * int(c11.sum()) == sig5[0x11]:
                        c77 = o_z[0x77].copy()
                        for i, bit in enumerate(picks):
                            if bit:
                                c77 ^= b_z[0x77][i]
                        if 256 - 2 * int(c77.sum()) == sig5[0x77]:
                            n_q5_match += 1
                            if eval_compact_block(q5_formas, q5_cubs, x111):
                                n_q5_viol_c += 1

        if w_01 == e0_tgt:
            n_e0_match += 1
            if e0_cubs and eval_compact_block(e0_formas, e0_cubs, x111):
                n_e0_viol += 1
            if w_ff == sig5[0xFF] and n_q5_match > 0:
                pass

    assert n_ff_viol == 0 and n_e0_viol == 0 and n_q5_viol_c == 0, (
        f"SPECTRAL ZT FAIL: ff_viol={n_ff_viol}/{n_ff_match}, e0_viol={n_e0_viol}/{n_e0_match}, q5_viol={n_q5_viol_c}/{n_q5_match}"
    )
    print(
        f"  [SPECTRAL ZT {job_name}] ff_matches={n_ff_match} (viol=0), e0_matches={n_e0_match} (viol=0), "
        f"q5_matches={n_q5_match} (viol=0)",
        flush=True,
    )

    out = {
        "job": job_name,
        "cell": "B1_11",
        "rep": 1,
        "sig5": {hex(k): v for k, v in sig5.items()},
        "e0": e0_tgt,
        "baseline": state_sig(sr_base),
        "baseline_wess": base_wess,
        "generators_summary": {
            "n_lin": len(psets_lin),
            "n_quad_polys": len(psets_deg2),
            "n_q5_cubs": len(q5_cubs),
            "n_e0_cubs": len(e0_cubs),
            "pivot_leaks": 0,
            "zt_ff_matches": n_ff_match,
            "zt_e0_matches": n_e0_match,
            "zt_q5_matches": n_q5_match,
            "zt_violations": 0,
        },
    }

    # Stage 1: Inject lin + deg<=2 into s9
    sr_p2, _ = s60c.inject_psets_into_s9(sr_base, psets_lin + psets_deg2, lib9, tbl)
    out["after_sig_le2"] = state_sig(sr_p2)
    print(f"  [{job_name} AFTER SIG lin+deg<=2]: {out['after_sig_le2']}", flush=True)
    if sr_p2["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_SIG_DEG2"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 2: Expand compact Q5 cubics + e0 cubics modulo sr_p2['_lin_pivs'] in C/OpenMP (with 64-pt ZT check!)
    rows_q5, n_q5, zt_q5 = expand_compact_block_to_c_rows(
        q5_formas, q5_cubs, sr_p2["_lin_pivs"], lib_exp, lib9, tbl, zt_seed=12901
    )
    out["q5_expand_zt"] = zt_q5
    sr_p3 = inject_raw_c_rows_into_s9(sr_p2, rows_q5, n_q5, lib9, tbl)
    out["after_q5_cubics"] = state_sig(sr_p3)
    print(f"  [{job_name} AFTER Q5 CUBICS (+{n_q5}C)]: {out['after_q5_cubics']}", flush=True)
    if sr_p3["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_Q5_CUBICS"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    if e0_cubs:
        rows_e0, n_e0, zt_e0 = expand_compact_block_to_c_rows(
            e0_formas, e0_cubs, sr_p3["_lin_pivs"], lib_exp, lib9, tbl, zt_seed=12902
        )
        out["e0_expand_zt"] = zt_e0
        sr_p3 = inject_raw_c_rows_into_s9(sr_p3, rows_e0, n_e0, lib9, tbl)
        out["after_e0_cubics"] = state_sig(sr_p3)
        print(f"  [{job_name} AFTER e0 CUBICS (+{n_e0}C)]: {out['after_e0_cubics']}", flush=True)
        if sr_p3["closed_unsat"]:
            out["verdict"] = "CLOSED_UNSAT_AT_E0_CUBICS"
            out["elapsed_s"] = round(time.perf_counter() - t0, 2)
            return out

    # Stage 3: Step 63A (AC180 + AC4115 + D8-PQ72)
    f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
    orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
    out_st = {}
    s63a.run_autocorr_and_parseval_suite(
        orig_f3, basis_f3, f_act3, sr_p3,
        env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
        env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
        lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
        tag=job_name, seed=12950,
        vq_ctx=None, do_deg4_compare=False, out_states=out_st,
    )
    sr_ac = out_st.get("sub_ac", sr_p3)
    out["ac180_injected_count"] = len(out_st.get("injected_psets", []))
    out["after_ac180"] = state_sig(sr_ac)
    print(f"  [{job_name} AFTER AC180]: {out['after_ac180']}", flush=True)
    if sr_ac["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_AC180"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 4: Optional MAC_D3 if N <= 78
    if (111 - len(sr_ac["_lin_pivs"])) <= 78:
        mac_status, mac_trace = s64a.run_mac_on_substate(
            sr_ac, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=False, tag=job_name
        )
        out["mac_d3"] = {"status": mac_status, "trace": mac_trace}

    # Stage 5: Post-Signature + AC180 W_ess MinRank measurement
    out["after_wess"] = spois.measure_wess(f"{job_name}_wess", sr_ac, lib9, lib_sh, tbl, rng_seed=12990)
    print(f"  [{job_name} AFTER W_ess]: {out['after_wess']}", flush=True)
    out["verdict"] = "OPEN"
    out["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--job", choices=list(JOB_SPECS.keys()), required=True)
    ap.add_argument("--out-json", type=str, default="b111_sig_inject_out.json")
    args = ap.parse_args()

    libs = spois.compile_c_libs()
    lib_exp = compile_compact_expander()
    res = run_job(args.job, libs, lib_exp)
    Path(args.out_json).write_text(json.dumps(res, indent=2) + "\n", encoding="utf-8")
    print(f"\n=== WRITTEN TO {args.out_json} ===", flush=True)


if __name__ == "__main__":
    main()
