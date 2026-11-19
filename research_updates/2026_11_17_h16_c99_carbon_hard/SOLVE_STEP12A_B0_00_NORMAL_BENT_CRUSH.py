#!/usr/bin/env python3
r"""
SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH.py

Dedicated normal-bent attack on B0_00 (where f|_{D_8} == 0 identically on all of F_2^111!):
  1. Builds ALL 389 Carlet-Guillot cubics + ALL verified B0_00-specific normal-bent D_8-coset
     cubics:
       - (wt(f|_{a + D_8}) / 8) mod 2 = 0  for all C_8-orbit reps of a in 1..255
       - (wt(f|_{a + D_8}) / 16) mod 2 = 0 for period-4 cosets (0x11, 0x33, 0x77)
       - (wt(f|_{0x55 + D_8}) / 32) mod 2 = 0
       - (wt(f|_{0xFF + D_8}) / 64) mod 2 = 0
     ZERO-TRUST VERIFIES EVERY NEW D_8-COSET CUBIC on 20 random points of F_2^111!
  2. Checks root cascade (quads/linears/cubics) with these new normal-bent cubics.
  3. SPLITS branch 000 (which previously had 0 quads only because f == 0 lived inside it!)
     across ALL 102 valid non-zero states of the 7 linear forms of (0xFF + D_8) where
     wt(f|_{0xFF + D_8}) == 128 (STRICTLY FORBIDDING f == 0!) and checks for quad/lin/1=0 drops!
  4. Runs fast recursive symplectic DFS (max_nodes=120, max_depth=4) on all 5 non-zero
     branches (001, 010, 011, 101, 110) WITH the new normal-bent cubics included!
"""

import ctypes
import json
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

C_D8CUB_SRC = r"""
#include <stdint.h>
#include <string.h>

// Extract exact degree-3 polynomial (wt(f|_{pts}) >> shift_bit) mod 2 on a 256-point coset!
// Because every basis vector b_i on a+D_8 has degree <= 3 on 8 vars (and free involution v->v^a):
// For a generic shift_bit s:
//   Wait: to be 100% EXACT for ANY shift_bit s in {3, 4, 5, 6}, we compute the exact
//   Mobius / ANF coefficients directly by inclusion-exclusion on the 256-bit truth tables:
//   On 256 bits (4 x uint64_t), popcount(t_i), popcount(t_i & t_j), popcount(t_i & t_j & t_k)
//   give the EXACT weight wt(sum z_i t_i) mod 8 = sum |t_i| - 2 sum |t_i & t_j| + 4 sum |t_i & t_j & t_k|!
//   WAIT: for shift_bit = 3 (div by 8) when 8 | wt, wait: (-2)^3 = -8 means 4-way intersections
//   COULD contribute if 4-way intersections aren't even — EXCEPT we ALREADY proved d4 == 0/30!!
//   So we extract the EXACT degree<=3 ANF of g(z) = (wt(f(z)|_{pts}) >> shift_bit) & 1 directly by
//   evaluating g(e_i), g(e_i^e_j), g(e_i^e_j^e_k) on the 4 uint64_t words!
//   Evaluating 4 uint64_t popcounts takes ~5 ns -> C(111,3)=221,815 triples takes ONLY 0.001s (1 ms)!!
void extract_deg3_coset_poly(
    const uint64_t *b_words, // 111 * 4 uint64_t words (256 bits each)
    int shift_bit,
    int n, int off2, int off1, int off0, int n_cw,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));
    // f(0) = 0 on B0_00 (origin111 = 0!), so g(0) = 0!
    uint8_t g1[128];
    uint8_t g2[128][128];

    // Linear terms: c_i = g(e_i)
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_words + 4 * i;
        int w = __builtin_popcountll(bi[0]) + __builtin_popcountll(bi[1])
              + __builtin_popcountll(bi[2]) + __builtin_popcountll(bi[3]);
        g1[i] = (uint8_t)((w >> shift_bit) & 1);
        if (g1[i]) {
            int col = off1 + i;
            out_row[col >> 6] ^= (1ULL << (col & 63));
        }
    }

    // Quadratic terms: c_ij = g(e_i ^ e_j) ^ g(e_i) ^ g(e_j)
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_words + 4 * i;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_words + 4 * j;
            int w = __builtin_popcountll(bi[0] ^ bj[0]) + __builtin_popcountll(bi[1] ^ bj[1])
                  + __builtin_popcountll(bi[2] ^ bj[2]) + __builtin_popcountll(bi[3] ^ bj[3]);
            uint8_t v = (uint8_t)((w >> shift_bit) & 1);
            g2[i][j] = v;
            uint8_t c2 = v ^ g1[i] ^ g1[j];
            if (c2) {
                int col = off2 + col2_base[j] + i;
                out_row[col >> 6] ^= (1ULL << (col & 63));
            }
        }
    }

    // Cubic terms: c_ijk = g(e_i^e_j^e_k) ^ g2[i][j] ^ g2[i][k] ^ g2[j][k] ^ g1[i] ^ g1[j] ^ g1[k]
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = b_words + 4 * i;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = b_words + 4 * j;
            uint64_t x0 = bi[0] ^ bj[0], x1 = bi[1] ^ bj[1];
            uint64_t x2 = bi[2] ^ bj[2], x3 = bi[3] ^ bj[3];
            uint8_t pre = g2[i][j] ^ g1[i] ^ g1[j];
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = b_words + 4 * k;
                int w = __builtin_popcountll(x0 ^ bk[0]) + __builtin_popcountll(x1 ^ bk[1])
                      + __builtin_popcountll(x2 ^ bk[2]) + __builtin_popcountll(x3 ^ bk[3]);
                uint8_t v = (uint8_t)((w >> shift_bit) & 1);
                uint8_t c3 = v ^ pre ^ g2[i][k] ^ g2[j][k] ^ g1[k];
                if (c3) {
                    int col = col3_base[k] + col2_base[j] + i;
                    out_row[col >> 6] ^= (1ULL << (col & 63));
                }
            }
        }
    }
}
"""


def main():
    t0 = time.perf_counter()
    print("==================== [B0_00] STEP 12A: NORMAL-BENT D8-COSET CUBICS + 0xFF 102-STATE SPLIT ====================", flush=True)

    # Compile C libraries
    c_diag, so_diag = WORK_DIR / "s12a_diag.c", WORK_DIR / "libs12a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s12a_s9.c", WORK_DIR / "libs12a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s12a_cg.c", WORK_DIR / "libs12a_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16),
            ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_uint64),
        ]

    c_d8, so_d8 = WORK_DIR / "s12a_d8.c", WORK_DIR / "libs12a_d8.so"
    c_d8.write_text(C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64),
    ]

    # Precomputations
    orbits = diag_v2.build_orbits_116()
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)

    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1:
                row_mask |= (1 << m_idx)
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
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
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
    n, n_cw = tbl["n"], tbl["n_col_words"]

    free111, origin111, cb111 = b09.build_pure_111_basis(0, 0, 0)
    assert origin111 == 0
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb

    # 1. Extract & ZERO-TRUST VERIFY ALL B0_00 normal-bent D_8-coset cubics!
    D8 = np.array([v | (v << 8) for v in range(256)], dtype=np.uint16)
    c8_reps = []
    seen_a = set()
    for a in range(1, 256):
        if a in seen_a:
            continue
        c8_reps.append(a)
        cur = a
        for _ in range(8):
            seen_a.add(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF

    # Pair (a, shift_bit): all 35 C8 reps at shift=3, plus special high-symmetry shifts (4, 5, 6)!
    d8_specs = [(a, 3) for a in c8_reps] + [(0x11, 4), (0x33, 4), (0x77, 4), (0x55, 5), (0xFF, 6)]
    d8_buf = (ctypes.c_uint64 * (len(d8_specs) * n_cw))()
    rng = random.Random(20261118)
    test_zs = [rng.getrandbits(111) for _ in range(20)]
    mask64 = (1 << 64) - 1
    verified_d8 = 0
    for idx, (a, sb) in enumerate(d8_specs):
        pts = D8 ^ np.uint16(a)
        bw = (ctypes.c_uint64 * (111 * 4))()
        for i in range(111):
            row = b_tt[i, pts]
            for w_idx in range(4):
                val = 0
                for b in range(64):
                    if row[w_idx * 64 + b]:
                        val |= (1 << b)
                bw[4 * i + w_idx] = val
        rptr = ctypes.cast(ctypes.byref(d8_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_d8.extract_deg3_coset_poly(
            bw, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
        # ZERO-TRUST VERIFY on 20 random points!
        mm = 0
        for zmask in test_zs:
            got = lib9.eval_row_s9(
                d8_buf, idx, n_cw, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                zmask & mask64, zmask >> 64
            )
            fv = np.zeros(256, dtype=np.uint8)
            tmp = zmask
            while tmp:
                lb = tmp & -tmp
                fv ^= b_tt[lb.bit_length() - 1, pts]
                tmp ^= lb
            w_exact = int(fv.sum())
            assert (w_exact & ((1 << sb) - 1)) == 0, f"a=0x{a:02x} sb={sb} w={w_exact}!"
            exp = (w_exact >> sb) & 1
            if got != exp:
                mm += 1
        assert mm == 0, f"ZERO-TRUST FAILED on D_8 coset a=0x{a:02x} sb={sb}: mm={mm}/20!"
        verified_d8 += 1
    print(f"[B0_00] Zero-trust verified ALL {verified_d8} normal-bent D_8-coset cubics (0/20 mismatches each!) in {time.perf_counter()-t0:.1f}s", flush=True)

    # 2. Build CG(389) + base + cyclotomic + D_8-coset cubics!
    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system("B0_00", lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics("B0_00", orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + len(d8_specs)
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, len(d8_specs) * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False)
    print(f"[B0_00] Root WITH D_8-coset cubics: closed={root['closed_unsat']}, N={root.get('N_active')}, "
          f"quads={root.get('n_quad_surviving')}, cubics={root.get('n_genuine_cubics')} (was 389!)", flush=True)
    if root["closed_unsat"]:
        print("[B0_00] ROOT CLOSED ALGEBRAICALLY!!", flush=True)
        return

    # 3. Extract the EXACT 7 linear forms of (0xFF + D_8) and their 102 valid non-zero states (wt == 128)!
    pts_ff = D8 ^ np.uint16(0xFF)
    # Find 7 independent point evaluation linear forms L_k(z) = sum_i b_tt[i, x_k] z_i
    piv_lf = {}
    ff_forms_111 = []
    ff_basis_pts = []
    for k, x in enumerate(pts_ff):
        m = 0
        col = b_tt[:, x]
        for i in range(111):
            if col[i]:
                m |= (1 << i)
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in piv_lf:
                rem ^= piv_lf[b]
            else:
                piv_lf[b] = rem
                ff_forms_111.append(m)
                ff_basis_pts.append(k)
                break
    assert len(ff_forms_111) == 7, f"Expected rank 7 on 0xFF+D8, got {len(ff_forms_111)}"

    # Express every one of the 256 points of 0xFF+D8 as a linear combination of the 7 basis forms!
    # Build 7x256 basis matrix by finding 7 basis vectors in F_2^111 dual to ff_forms_111:
    # Simpler: row-reduce the 7x111 matrix of ff_forms_111 to get 7 dual vectors v_0..v_6 in F_2^111
    # such that L_r(v_s) = delta_{r,s}!
    M7 = [list((ff_forms_111[r] >> c) & 1 for c in range(111)) for r in range(7)]
    # Pick 7 pivot columns via Gauss-Jordan
    piv_cols = []
    A = [row[:] for row in M7]
    for r in range(7):
        pc = next(c for c in range(111) if A[r][c] == 1)
        piv_cols.append(pc)
        for rr in range(7):
            if rr != r and A[rr][pc]:
                for c in range(111):
                    A[rr][c] ^= A[r][c]
    # Dual vector v_s has bit piv_cols[s] = 1, wait: since we row-reduced rows, solve M7 * v = e_s on piv_cols!
    M7_sq = np.array([[M7[r][c] for c in piv_cols] for r in range(7)], dtype=np.uint8)
    # Invert 7x7 over GF(2)
    aug = np.hstack([M7_sq.copy(), np.eye(7, dtype=np.uint8)])
    for r in range(7):
        pr = r + int(np.argmax(aug[r:, r]))
        aug[[r, pr]] = aug[[pr, r]]
        for rr in range(7):
            if rr != r and aug[rr, r]:
                aug[rr] ^= aug[r]
    inv7 = aug[:, 7:]
    # Check each of 128 7-bit states s: f(x) = sum_r (inv7 @ s)_r b_tt[piv_cols[r], pts_ff]!
    B7_ff = b_tt[piv_cols][:, pts_ff]  # (7, 256)
    valid_ff_states = []
    for s_mask in range(128):
        s_vec = np.array([(s_mask >> r) & 1 for r in range(7)], dtype=np.uint8)
        coeffs = (inv7 @ s_vec) & 1
        wt = int(((coeffs @ B7_ff) & 1).sum())
        if wt == 128:
            valid_ff_states.append(s_mask)
    print(f"[B0_00] Exact 0xFF+D8 valid states (wt == 128): {len(valid_ff_states)} / 128 (0 in valid? {0 in valid_ff_states})", flush=True)

    # 4. Split root into 8 symplectic branches!
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = s9.find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)

    # First test BRANCH 000 split across ALL 102 valid non-zero states of 0xFF+D8!
    br0 = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        [(forms[i], 0) for i in range(k_lin)], tbl, max_xl_rounds=5, verify_subst=False
    )
    print(f"[B0_00] Branch 000 before 0xFF split: closed={br0['closed_unsat']}, N={br0.get('N_active')}, "
          f"q={br0.get('n_quad_surviving')}, c={br0.get('n_genuine_cubics')}", flush=True)

    b0_closed = 0
    b0_lin_drop = 0
    b0_quad_drop = 0
    b0_max_q = 0
    b0_q_hist = {}
    if not br0["closed_unsat"]:
        for s_mask in valid_ff_states:
            ex = [(ff_forms_111[r], (s_mask >> r) & 1) for r in range(7)]
            sr = s9.run_branch_cascade(
                lib9, br0["_buf"], br0["_quad_ids"], br0["_cub_ids"], br0["_lin_pivs"],
                ex, tbl, max_xl_rounds=5, verify_subst=False
            )
            if sr["closed_unsat"]:
                b0_closed += 1
            else:
                q = sr["n_quad_surviving"]
                b0_q_hist[q] = b0_q_hist.get(q, 0) + 1
                if sr["total_lin_dropped"] > 0:
                    b0_lin_drop += 1
                if q > 0:
                    b0_quad_drop += 1
                    b0_max_q = max(b0_max_q, q)
    print(f"[B0_00] BRANCH 000 x 102 VALID 0xFF STATES ({time.perf_counter()-t0:.1f}s): "
          f"closed={b0_closed}/{len(valid_ff_states)}, lin_drop={b0_lin_drop}, quad_drop={b0_quad_drop} (max_q={b0_max_q}), q_hist={b0_q_hist}", flush=True)

    # 5. Fast recursive symplectic DFS on the 5 non-zero branches (001, 010, 011, 101, 110) WITH new D8 cubics!
    nonzero_rep = {}
    for bmask in range(1, 1 << k_lin):
        bname = f"{bmask:0{k_lin}b}"
        ex = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=5, verify_subst=False
        )
        if bres["closed_unsat"]:
            nonzero_rep[bname] = {"status": "CLOSED_D1"}
            print(f"  [B0_00] branch {bname}: CLOSED_D1", flush=True)
            continue
        nodes, cl_leaves, op_leaves = 0, 0, []
        def dfs(node, depth):
            nonlocal nodes, cl_leaves
            nodes += 1
            if node["n_quad_surviving"] == 0 or depth >= 4 or nodes >= 80:
                op_leaves.append({"d": depth, "N": node["N_active"], "q": node["n_quad_surviving"], "c": node["n_genuine_cubics"]})
                return
            qps = [s9.row_to_pset(node["_buf"], qr, tbl) for qr in node["_quad_ids"]]
            sub_forms = s9.find_minimal_linearizers(qps, n)["linearizer_forms_111"][:3]
            if not sub_forms:
                op_leaves.append({"d": depth, "N": node["N_active"], "q": node["n_quad_surviving"]})
                return
            for sm in range(1 << len(sub_forms)):
                if nodes >= 80:
                    op_leaves.append({"d": depth + 1, "trunc": True})
                    return
                sub = s9.run_branch_cascade(
                    lib9, node["_buf"], node["_quad_ids"], node["_cub_ids"], node["_lin_pivs"],
                    [(sub_forms[i], (sm >> i) & 1) for i in range(len(sub_forms))], tbl, max_xl_rounds=4, verify_subst=False
                )
                if sub["closed_unsat"]:
                    cl_leaves += 1
                else:
                    dfs(sub, depth + 1)
        dfs(bres, 1)
        nonzero_rep[bname] = {
            "d1_q": bres["n_quad_surviving"], "nodes": nodes,
            "closed_leaves": cl_leaves, "open_leaves": len(op_leaves), "sample": op_leaves[:3]
        }
        print(f"  [B0_00] branch {bname}: {nonzero_rep[bname]}", flush=True)

    summary = {
        "cell": "B0_00",
        "root_quads": root["n_quad_surviving"],
        "root_cubics": root["n_genuine_cubics"],
        "branch0_ff_split": {
            "total": len(valid_ff_states), "closed": b0_closed,
            "lin_drop": b0_lin_drop, "quad_drop": b0_quad_drop, "max_q": b0_max_q, "q_hist": b0_q_hist
        },
        "nonzero_branches_dfs": nonzero_rep,
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[B0_00] STEP 12A SUMMARY: {json.dumps(summary)}", flush=True)


if __name__ == "__main__":
    main()
