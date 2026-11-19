#!/usr/bin/env python3
r"""
SOLVE_STEP38D_NUCLEAR_NEW_EQS_AND_Z16_LOCUS.py

THREE HIGH-IMPACT TESTS ON B1_11 AND B0_11 (ALL ZERO-TRUST VERIFIED):
  PART 1: Z_16^* SUBGROUP INVARIANT LOCI (G=Z_16^*, <3>, <15>, <9>, <7>)
    - Tests if the Z_16^*-invariant (dim 22) or subgroup-invariant loci close immediately to 1=0!
    - Also computes exact Z_16^* fixed-subspace dimensions of W_ess and R_free on eta = 0!
  PART 2: TRANSVERSE 8-DIM SUBSPACE H_even C_8-ORBIT DUAL-WALSH CONGRUENCES (MOD 16, 32, 64, 128)
    - Extracts ALL exact deg <= 3 congruences on H_even in C via Mobius inversion on weight <= 3,
      Zero-Trust verifies 0/30 mismatches on random points, and checks rank gain above CG(389)!
  PART 3: 2-ADIC PARSEVAL BIT 11 + 2-ADIC AUTOCORRELATION Delta_f(a) == 0 (for key C_16-orbits of a)
    - Extracts exact deg <= 3 polynomials in C via Mobius inversion, Zero-Trust verifies 0/30 mismatches,
      and checks rank gain above CG(389) (both at root AND on eta = 0)!
"""

import argparse
import ctypes
import random
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP36_C8_ORBIT_WALSH_KERNEL_LOCAL as s36


C_MOBIUS3_SRC = r"""
#include <stdint.h>
#include <string.h>

static inline void set_bit(uint64_t *row, int col) {
    row[col >> 6] |= (1ULL << (col & 63));
}

/* Extract exact deg <= 3 ANF of F(x) = ((sum_z w_z * S_z(x)) >> shift) & 1
 * where each coset z in 0..35 has 256 points packed as 4 uint64_t words in orig_z[36*4] and b_z[n*36*4].
 * S_z(x) = 256 - 2 * popcnt(orig_z[z] ^ XOR_{i in x} b_z[i][z]).
 * Actually: sum_z w_z * (256 - 2*wt_z) = const_256 - 2 * sum_z w_z * wt_z.
 * We compute exact signed sum S = sum_{z=0}^{35} w_z * (256 - 2*wt_z) and return ((S >> shift) & 1).
 */
static inline int eval_coset_lincomb_bit(
    const uint64_t *cur_z, const int64_t *wz, int n_cosets, int shift
) {
    int64_t acc = 0;
    for (int z = 0; z < n_cosets; z++) {
        int64_t w = wz[z];
        if (!w) continue;
        const uint64_t *p = cur_z + z * 4;
        int wt = __builtin_popcountll(p[0]) + __builtin_popcountll(p[1])
               + __builtin_popcountll(p[2]) + __builtin_popcountll(p[3]);
        acc += w * (256 - 2 * wt);
    }
    return (int)((acc >> shift) & 1LL);
}

void extract_deg3_coset_lincomb(
    const uint64_t *orig_z, const uint64_t *b_z, const int64_t *wz,
    int n_cosets, int shift, int n,
    int off2, int off1, int off0, int n_cw,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));
    int n_words = n_cosets * 4;
    uint64_t buf1[144], buf2[144], buf3[144];
    uint8_t f1[128];
    uint8_t f2[128][128];

    int f0 = eval_coset_lincomb_bit(orig_z, wz, n_cosets, shift);
    if (f0) set_bit(out_row, off0);

    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_z + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) buf1[w] = orig_z[w] ^ bi[w];
        f1[i] = (uint8_t)eval_coset_lincomb_bit(buf1, wz, n_cosets, shift);
        if (f1[i] ^ f0) set_bit(out_row, off1 + i);
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_z + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) buf1[w] = orig_z[w] ^ bi[w];
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_z + (size_t)j * n_words;
            for (int w = 0; w < n_words; w++) buf2[w] = buf1[w] ^ bj[w];
            uint8_t val = (uint8_t)eval_coset_lincomb_bit(buf2, wz, n_cosets, shift);
            f2[i][j] = val;
            if ((val ^ f1[i] ^ f1[j] ^ f0) & 1) {
                set_bit(out_row, off2 + col2_base[i] + (j - i - 1));
            }
        }
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_z + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) buf1[w] = orig_z[w] ^ bi[w];
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_z + (size_t)j * n_words;
            for (int w = 0; w < n_words; w++) buf2[w] = buf1[w] ^ bj[w];
            int base3 = col3_base[i * n + j];
            uint8_t pref = (uint8_t)(f2[i][j] ^ f1[i] ^ f1[j] ^ f0);
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = b_z + (size_t)k * n_words;
                for (int w = 0; w < n_words; w++) buf3[w] = buf2[w] ^ bk[w];
                uint8_t f123 = (uint8_t)eval_coset_lincomb_bit(buf3, wz, n_cosets, shift);
                uint8_t c3 = f123 ^ f2[i][k] ^ f2[j][k] ^ f1[k] ^ pref;
                if (c3 & 1) set_bit(out_row, base3 + (k - j - 1));
            }
        }
    }
}

/* Extract exact deg <= 3 ANF of Parseval bit: ((sum_{z=1}^{35} sz[z]*S_z^2 - P_target) >> shift) & 1 */
static inline int eval_parseval_bit(
    const uint64_t *cur_z, const int64_t *sz, int n_cosets, int64_t p_target, int shift
) {
    int64_t acc = 0;
    for (int z = 1; z < n_cosets; z++) {
        const uint64_t *p = cur_z + z * 4;
        int wt = __builtin_popcountll(p[0]) + __builtin_popcountll(p[1])
               + __builtin_popcountll(p[2]) + __builtin_popcountll(p[3]);
        int64_t s = 256 - 2 * wt;
        acc += sz[z] * s * s;
    }
    return (int)(((acc - p_target) >> shift) & 1LL);
}

void extract_deg3_parseval(
    const uint64_t *orig_z, const uint64_t *b_z, const int64_t *sz,
    int n_cosets, int64_t p_target, int shift, int n,
    int off2, int off1, int off0, int n_cw,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));
    int n_words = n_cosets * 4;
    uint64_t buf1[144], buf2[144], buf3[144];
    uint8_t f1[128];
    uint8_t f2[128][128];

    int f0 = eval_parseval_bit(orig_z, sz, n_cosets, p_target, shift);
    if (f0) set_bit(out_row, off0);
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_z + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) buf1[w] = orig_z[w] ^ bi[w];
        f1[i] = (uint8_t)eval_parseval_bit(buf1, sz, n_cosets, p_target, shift);
        if (f1[i] ^ f0) set_bit(out_row, off1 + i);
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_z + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) buf1[w] = orig_z[w] ^ bi[w];
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_z + (size_t)j * n_words;
            for (int w = 0; w < n_words; w++) buf2[w] = buf1[w] ^ bj[w];
            uint8_t val = (uint8_t)eval_parseval_bit(buf2, sz, n_cosets, p_target, shift);
            f2[i][j] = val;
            if ((val ^ f1[i] ^ f1[j] ^ f0) & 1) {
                set_bit(out_row, off2 + col2_base[i] + (j - i - 1));
            }
        }
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_z + (size_t)i * n_words;
        for (int w = 0; w < n_words; w++) buf1[w] = orig_z[w] ^ bi[w];
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_z + (size_t)j * n_words;
            for (int w = 0; w < n_words; w++) buf2[w] = buf1[w] ^ bj[w];
            int base3 = col3_base[i * n + j];
            uint8_t pref = (uint8_t)(f2[i][j] ^ f1[i] ^ f1[j] ^ f0);
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = b_z + (size_t)k * n_words;
                for (int w = 0; w < n_words; w++) buf3[w] = buf2[w] ^ bk[w];
                uint8_t f123 = (uint8_t)eval_parseval_bit(buf3, sz, n_cosets, p_target, shift);
                uint8_t c3 = f123 ^ f2[i][k] ^ f2[j][k] ^ f1[k] ^ pref;
                if (c3 & 1) set_bit(out_row, base3 + (k - j - 1));
            }
        }
    }
}

/* Extract exact deg <= 3 ANF of 2-adic autocorrelation bit:
 * Delta_f(a) = 65536 - 4 * wt_half(D_a f), where orig_da and b_da[i] store the 32768 pair-reps in 512 uint64_t words!
 */
static inline int eval_ac_bit(const uint64_t *cur, int shift) {
    int wt = 0;
    for (int w = 0; w < 512; w++) wt += __builtin_popcountll(cur[w]);
    int64_t delta = 65536LL - 4LL * (int64_t)wt;
    return (int)((delta >> shift) & 1LL);
}

void extract_deg3_autocorr(
    const uint64_t *orig_da, const uint64_t *b_da, int shift, int n,
    int off2, int off1, int off0, int n_cw,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));
    uint64_t buf1[512], buf2[512];
    uint8_t f1[128];
    uint8_t f2[128][128];

    int f0 = eval_ac_bit(orig_da, shift);
    if (f0) set_bit(out_row, off0);
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_da + (size_t)i * 512;
        for (int w = 0; w < 512; w++) buf1[w] = orig_da[w] ^ bi[w];
        f1[i] = (uint8_t)eval_ac_bit(buf1, shift);
        if (f1[i] ^ f0) set_bit(out_row, off1 + i);
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_da + (size_t)i * 512;
        for (int w = 0; w < 512; w++) buf1[w] = orig_da[w] ^ bi[w];
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_da + (size_t)j * 512;
            for (int w = 0; w < 512; w++) buf2[w] = buf1[w] ^ bj[w];
            uint8_t val = (uint8_t)eval_ac_bit(buf2, shift);
            f2[i][j] = val;
            if ((val ^ f1[i] ^ f1[j] ^ f0) & 1) {
                set_bit(out_row, off2 + col2_base[i] + (j - i - 1));
            }
        }
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_da + (size_t)i * 512;
        for (int w = 0; w < 512; w++) buf1[w] = orig_da[w] ^ bi[w];
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_da + (size_t)j * 512;
            for (int w = 0; w < 512; w++) buf2[w] = buf1[w] ^ bj[w];
            int base3 = col3_base[i * n + j];
            uint8_t pref = (uint8_t)(f2[i][j] ^ f1[i] ^ f1[j] ^ f0);
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = b_da + (size_t)k * 512;
                int wt = 0;
                for (int w = 0; w < 512; w++) wt += __builtin_popcountll(buf2[w] ^ bk[w]);
                int64_t delta = 65536LL - 4LL * (int64_t)wt;
                uint8_t f123 = (uint8_t)((delta >> shift) & 1LL);
                uint8_t c3 = f123 ^ f2[i][k] ^ f2[j][k] ^ f1[k] ^ pref;
                if (c3 & 1) set_bit(out_row, base3 + (k - j - 1));
            }
        }
    }
}
"""


def pack_cosets_u64(tt_vec, pts_list):
    n_c = len(pts_list)
    arr = np.zeros(n_c * 4, dtype=np.uint64)
    for zi, pts in enumerate(pts_list):
        bits = tt_vec[pts]
        for w in range(4):
            val = 0
            base = w * 64
            for b in range(64):
                if bits[base + b]:
                    val |= (1 << b)
            arr[zi * 4 + w] = val
    return arr


def pack_half_da_u64(tt_vec, a_val, half_idx):
    d = tt_vec[half_idx] ^ tt_vec[half_idx ^ a_val]
    # Pack 32768 bits into 512 uint64s via numpy packbits (little endian)
    packed_bytes = np.packbits(d, bitorder="little")
    return packed_bytes.view(np.uint64).copy()


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_m3, orbits, layer_vecs, orb_tt_np,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 38D: Z_16* LOCI + H_even + PARSEVAL + AUTOCORR ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

    # Build root CG(389) + base system
    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1
    orb_map[99] = -2 if c99 else -1
    orb_map[57] = -2 if c57 else -1
    orb_map[113] = -2 if c113 else -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    print(f"  [{cell_name}] Baseline root: N={111 - len(root['_lin_pivs'])}, q={len(root['_quad_ids'])}, cub={len(root['_cub_ids'])}", flush=True)

    # ---------------- PART 1: Z_16^* SUBGROUP INVARIANT LOCI ----------------
    print(f"\n  --- PART 1: Z_16^* SUBGROUP INVARIANT LOCI ({cell_name}) ---", flush=True)
    orb_of_mon = {m: j for j, orb in enumerate(orbits) for m in orb}
    def perm_mon(m, k):
        out = 0
        for i in range(16):
            if (m >> i) & 1: out |= (1 << ((k * i) & 15))
        return out
    perms = {k: [orb_of_mon[perm_mon(orbits[j][0], k)] for j in range(116)] for k in [1, 3, 5, 7, 9, 11, 13, 15]}
    orb_to_111 = {j: i for i, j in enumerate(free111)}

    subgroups = [
        ("G=Z_16* (ord 8)", [3, 15]),
        ("<pi_3>  (ord 4)", [3]),
        ("<pi_15> (palin)", [15]),
        ("<pi_9>  (ord 2)", [9]),
        ("<pi_7>  (ord 2)", [7]),
    ]
    for sg_name, gens in subgroups:
        eqs_sg = []
        for k in gens:
            p = perms[k]
            for i, j in enumerate(free111):
                jp = p[j]
                if jp in orb_to_111:
                    ip = orb_to_111[jp]
                    if i < ip:
                        eqs_sg.append(((1 << i) | (1 << ip), 0))
        sub = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            eqs_sg, tbl, max_xl_rounds=20, verify_subst=True
        )
        if sub["closed_unsat"]:
            print(f"    [{sg_name}] -> *** CLOSED UNSAT (1 = 0)! ***", flush=True)
        else:
            qps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
            ana = s16.analyze_quad_system(qps)
            dimW = len(s19.strict_rref_masks(list(ana["W_piv"].values())))
            print(f"    [{sg_name}] -> OPEN: N={111 - len(sub['_lin_pivs'])}, q={len(sub['_quad_ids'])}, cub={len(sub['_cub_ids'])}, dimW={dimW}", flush=True)

    # Prepare orig_tt and b_tt for Parts 2 & 3
    orig_tt = np.zeros(65536, dtype=np.uint8)
    for o in range(116):
        if (origin111 >> o) & 1: orig_tt ^= orb_tt_np[o]
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i in range(111):
        acc = np.zeros(65536, dtype=np.uint8)
        for o in range(116):
            if (cb111[i] >> o) & 1: acc ^= orb_tt_np[o]
        b_tt[i] = acc

    def build_base_echelon():
        # Copy all raw_buf rows and build an echelon table for exact rank-gain testing!
        buf = (ctypes.c_uint64 * ((total_raw + 200) * n_cw))()
        ctypes.memmove(buf, raw_buf, total_raw * n_cw * 8)
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        rk = 0
        for r in range(total_raw):
            if lib9.gf2_echelon_insert_s9(buf, r, n_cw, piv_idx, n_cols) >= 0:
                rk += 1
        return buf, piv_idx, rk, total_raw

    ech_buf, piv_idx, base_rk, next_row = build_base_echelon()
    print(f"\n  [{cell_name}] Raw echelon rank before new eqs (raw_buf incl. CG389): {base_rk}", flush=True)

    rng_zt = random.Random(383838 + c99)
    zt_xs = [rng_zt.getrandbits(111) for _ in range(30)]
    zt_tts = []
    for x in zt_xs:
        tt = orig_tt.copy()
        tmp = x
        while tmp:
            lb = tmp & -tmp; tt ^= b_tt[lb.bit_length() - 1]; tmp ^= lb
        zt_tts.append(tt)

    def test_and_insert_row(row_arr, true_vals_30, label):
        nonlocal next_row
        # Zero-Trust check on 30 random points!
        mis = 0
        for x, tv in zip(zt_xs, true_vals_30):
            ev = lib9.eval_row_s9(
                row_arr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                x & mask64, x >> 64
            )
            if ev != tv:
                mis += 1
        if mis > 0:
            return False, False, mis
        # Insert into echelon copy (first copy to ech_buf[next_row])
        dst = ctypes.cast(ctypes.byref(ech_buf, next_row * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        ctypes.memmove(dst, row_arr, n_cw * 8)
        pc = lib9.gf2_echelon_insert_s9(ech_buf, next_row, n_cw, piv_idx, n_cols)
        if pc >= 0:
            next_row += 1
            return True, True, 0
        return True, False, 0

    # ---------------- PART 2: H_even C_8-ORBIT DUAL-WALSH CONGRUENCES ----------------
    print(f"\n  --- PART 2: TRANSVERSE H_even C_8-ORBIT DUAL-WALSH CONGRUENCES ({cell_name}) ---", flush=True)
    seen_c8, c8_orbs = set(), []
    for b in range(256):
        if b in seen_c8: continue
        orb, cur = [], b
        while cur not in seen_c8:
            seen_c8.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    z_reps = [o[0] for o in c8_orbs]
    z_sz = np.array([len(o) for o in c8_orbs], dtype=np.int64)
    A_c8 = np.array([[sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb) for orb in c8_orbs] for z in z_reps], dtype=np.int64)
    orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)

    def spread_bits(v):
        out = 0
        for b in range(8):
            if (v >> b) & 1: out |= (1 << (2 * b))
        return out
    even_pts = np.array([spread_bits(u) for u in range(256)], dtype=np.uint16)
    pts_heven = [even_pts ^ (spread_bits(z) << 1) for z in z_reps]

    orig_he = pack_cosets_u64(orig_tt, pts_heven)
    b_he = np.zeros((111, 36 * 4), dtype=np.uint64)
    for i in range(111):
        b_he[i] = pack_cosets_u64(b_tt[i], pts_heven)
    S_zt_he = np.zeros((30, 36), dtype=np.int64)
    for r, tt in enumerate(zt_tts):
        for zi in range(36):
            S_zt_he[r, zi] = 256 - 2 * int(tt[pts_heven[zi]].sum())

    he_extracted, he_new_rk = 0, 0
    row_tmp = (ctypes.c_uint64 * n_cw)()
    for MOD in (16, 32, 64, 128):
        shift = MOD.bit_length() - 1
        A_ext = np.vstack([A_c8, (MOD // 2) * orb_b0_par])
        ker = s36.mod_rref_kernel(A_ext, MOD)
        vs = [k[:36] % MOD for k in ker if np.any(k[:36] % MOD != 0)]
        for vi, v in enumerate(vs):
            vals = (S_zt_he @ v) % (2 * MOD)
            uniq = sorted(set(int(u) for u in vals))
            if not (len(uniq) == 2 and ((uniq[1] - uniq[0]) % (2 * MOD) == MOD)):
                continue
            v_c = np.ascontiguousarray(v, dtype=np.int64)
            lib_m3.extract_deg3_coset_lincomb(
                orig_he.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                b_he.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                v_c.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
                36, shift, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
                tbl["col2_base"], tbl["col3_base"], row_tmp
            )
            tv = [int(((S_zt_he[r] @ v) >> shift) & 1) for r in range(30)]
            ok, is_new, mis = test_and_insert_row(row_tmp, tv, f"H_even_MOD{MOD}_{vi}")
            if ok:
                he_extracted += 1
                if is_new:
                    he_new_rk += 1
                    print(f"    *** BRAND-NEW RANK FROM H_even MOD={MOD} idx={vi}! ***", flush=True)
    print(f"    [H_even SUMMARY] Zero-Trust verified deg<=3 eqs = {he_extracted}, NEW RANK ABOVE CG(389) = {he_new_rk}", flush=True)

    # ---------------- PART 3A: 2-ADIC PARSEVAL BIT 11 ON D_8 COSETS ----------------
    print(f"\n  --- PART 3A: 2-ADIC PARSEVAL BIT 11 ON D_8 COSETS ({cell_name}) ---", flush=True)
    pts_d8 = [np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16) for z in z_reps]
    orig_d8 = pack_cosets_u64(orig_tt, pts_d8)
    b_d8 = np.zeros((111, 36 * 4), dtype=np.uint64)
    for i in range(111):
        b_d8[i] = pack_cosets_u64(b_tt[i], pts_d8)
    S0_target = 128 if cell_name == "B0_11" else -64
    P_target = 65536 - S0_target * S0_target
    sz_c = np.ascontiguousarray(z_sz, dtype=np.int64)
    lib_m3.extract_deg3_parseval(
        orig_d8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        b_d8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        sz_c.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
        36, ctypes.c_int64(P_target), 11, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
        tbl["col2_base"], tbl["col3_base"], row_tmp
    )
    tv_p = []
    for tt in zt_tts:
        p = 0
        for zi in range(1, 36):
            s = 256 - 2 * int(tt[pts_d8[zi]].sum())
            p += int(z_sz[zi]) * s * s
        tv_p.append(int(((p - P_target) >> 11) & 1))
    ok_p, new_p, mis_p = test_and_insert_row(row_tmp, tv_p, "Parseval_bit11")
    print(f"    Parseval bit 11: deg<=3_verified={ok_p} (mis={mis_p}/30), NEW_RANK_ABOVE_CG389={new_p}", flush=True)

    # ---------------- PART 3B: 2-ADIC AUTOCORRELATION Delta_f(a) == 0 ----------------
    print(f"\n  --- PART 3B: 2-ADIC AUTOCORRELATION Delta_f(a) == 0 ({cell_name}) ---", flush=True)
    # Test a rich set of C_16-orbits of a != 0: D_8, U_4, H_even, weights 1,2,3,4,6,8!
    cand_as = [
        0xFFFF, 0x5555, 0x1111, 0x3333, 0x7777, 0x0F0F,
        0x0101, 0x0303, 0x0505, 0x0909, 0x0707, 0x1313, 0x1515, 0x1F1F,
        0x00FF, 0x55AA, 0x0055, 0x0033, 0x000F, 0x0011, 0x0015,
        0x0001, 0x0003, 0x0005, 0x0007, 0x0009, 0x000B, 0x000D, 0x0013, 0x0017, 0x0025, 0x0103, 0x0105, 0x0109,
    ]
    X_all = np.arange(65536, dtype=np.uint16)
    ac_verified, ac_new_rk = 0, 0
    for a_val in cand_as:
        # Compute min_v2 on the 30 random points
        deltas = []
        for tt in zt_tts:
            wt = int((tt ^ tt[X_all ^ a_val]).sum())
            deltas.append(65536 - 2 * wt)
        nz = [abs(d) for d in deltas if d != 0]
        if not nz: continue
        mv2 = min((d & -d).bit_length() - 1 for d in nz)
        # Quick check if bit mv2 is constant on zt_tts
        tv = [(d >> mv2) & 1 for d in deltas]
        if len(set(tv)) <= 1: continue
        # Build half_idx: one rep per pair {y, y ^ a_val}
        half_idx = X_all[X_all < (X_all ^ a_val)]
        assert len(half_idx) == 32768
        orig_da = pack_half_da_u64(orig_tt, a_val, half_idx)
        b_da = np.zeros((111, 512), dtype=np.uint64)
        for i in range(111):
            b_da[i] = pack_half_da_u64(b_tt[i], a_val, half_idx)
        lib_m3.extract_deg3_autocorr(
            orig_da.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            b_da.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            mv2, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
            tbl["col2_base"], tbl["col3_base"], row_tmp
        )
        ok, is_new, mis = test_and_insert_row(row_tmp, tv, f"AC_{a_val:04x}_v{mv2}")
        if ok:
            ac_verified += 1
            if is_new:
                ac_new_rk += 1
                print(f"    *** BRAND-NEW RANK FROM Delta_f(0x{a_val:04X}) bit {mv2}! ***", flush=True)
            else:
                print(f"    a=0x{a_val:04X} (bit {mv2:2d}): deg<=3 VERIFIED (0/30 mis), already in CG(389)", flush=True)
    print(f"    [AUTOCORR SUMMARY] Tested {len(cand_as)} orbits: deg<=3 verified = {ac_verified}, NEW RANK ABOVE CG(389) = {ac_new_rk}", flush=True)
    print(f"[{cell_name}] STEP 38D DONE ({time.perf_counter()-t0:.1f}s) | TOTAL NEW RANK = {he_new_rk + (1 if new_p else 0) + ac_new_rk}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s38d_diag.c", WORK_DIR / "libs38d_diag.so"
    c_diag.write_text(diag_v2.C_DIAG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_diag), "-o", str(so_diag)], check=True)
    lib_diag = ctypes.CDLL(str(so_diag))
    lib_diag.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_diag.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_diag.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_diag.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_diag.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_diag.gf2_echelon_insert.restype = ctypes.c_int

    c_s9, so_s9 = WORK_DIR / "s38d_s9.c", WORK_DIR / "libs38d_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = ctypes.CDLL(str(so_s9))
    lib9.subst_one_linear_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64, ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s38d_cg.c", WORK_DIR / "libs38d_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
            ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]

    c_m3, so_m3 = WORK_DIR / "s38d_m3.c", WORK_DIR / "libs38d_m3.so"
    c_m3.write_text(C_MOBIUS3_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_m3), "-o", str(so_m3)], check=True)
    lib_m3 = ctypes.CDLL(str(so_m3))
    lib_m3.extract_deg3_coset_lincomb.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_m3.extract_deg3_parseval.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int64),
        ctypes.c_int, ctypes.c_int64, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_m3.extract_deg3_autocorr.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb: mon_to_orb_arr[m] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)

    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1: row_mask |= (1 << m_idx)
        M_rows.append(row_mask)
    fiber_meta = (nonzero_z, diag_v2.gf2_nullspace_left(M_rows))

    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    seen_x = bytearray(65536)
    rot4_reps, rep_of_x = [], [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]: continue
        r_idx = len(rot4_reps); rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1; rep_of_x[y] = r_idx

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]: continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1; mem.append(cur); cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF: coset_0xf_reps.append(mem[0])

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc
        tt = bytearray(acc.tolist())
        orb_tts[j] = tt
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)
    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, lambda j, x: orb_tts[j][x])

    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cname, lib_diag, lib9, lib_cg, lib_m3, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
