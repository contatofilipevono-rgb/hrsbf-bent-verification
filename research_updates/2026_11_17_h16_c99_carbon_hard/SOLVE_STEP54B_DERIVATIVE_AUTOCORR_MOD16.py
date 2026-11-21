#!/usr/bin/env python3
r"""
SOLVE_STEP54B_DERIVATIVE_AUTOCORR_MOD16.py

BREAKTHROUGH SECOND-MOMENT (AUTOCORRELATION) ATTACK ON B0_11 & B1_11:
DERIVATIVE WEIGHT MOD 16 => EXACT DEGREE <= 3 EQUATIONS FOR EVERY a != 0!

Mathematical Theorem (Zero-Trust verified):
  A Boolean function f on F_2^16 is bent IFF every non-zero derivative D_a f(x) = f(x) ^ f(x ^ a)
  is balanced: wt_16(D_a f) = 32768, i.e., on the 15-dim quotient F_2^16 / <a>:
    wt_15(D_a f) = 16384 == 0 (mod 16).
  Since deg(f) = 4, every orbit derivative h_j = D_a g_j has deg(h_j) <= 3 on F_2^15!
  By the exact pointwise identity (s mod 2) == s - 2*C(s,2) + 4*C(s,3) - 8*C(s,4) (mod 16)
  and Ax-Warning divisibility on F_2^15:
    - r=1: deg(h_j) <= 3         => 16 | wt_15(h_j)         => 0 (mod 16)
    - r=2: deg(h_j h_k) <= 6     =>  4 | wt_15(h_j h_k)     => 8 | 2*wt_15(h_j h_k)     (QUADRATIC!)
    - r=3: deg(h_j h_k h_l) <= 9 =>  2 | wt_15(h_j h_k h_l) => 8 | 4*wt_15(h_j h_k h_l) (CUBIC!)
    - r=4: deg <= 12             =>  2 | wt_15(h_j h_k h_l h_r) => 16 | 8*wt_15(...)    (ZERO mod 16!)
    - r>=5: 16 | (-2)^{r-1}                                 => ZERO mod 16!
  Dividing by 8 gives an EXACT, ZERO-CARRY, PURE DEGREE <= 3 POLYNOMIAL EQUATION over F_2
  for EVERY SINGLE non-zero derivative direction a in F_2^16 \ {0}!

Unlike Carlet-Guillot (first-moment linear in (-1)^f), this encodes the QUADRATIC autocorrelation
Delta_f(a) = sum_x (-1)^{f(x) ^ f(x ^ a)} == 0 (mod 32)!
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
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a


C_DERIV_MOD16_SRC = r"""
#include <stdint.h>
#include <string.h>

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

static inline void toggle_vars_set(
    uint64_t *row, const int *vs, int nv,
    int n, int off2, int off1, int off0,
    const int *col2_base, const int *col3_base
) {
    int u[3], nu = 0;
    for (int i = 0; i < nv; i++) {
        int x = vs[i];
        int dup = 0;
        for (int j = 0; j < nu; j++) if (u[j] == x) { dup = 1; break; }
        if (!dup) u[nu++] = x;
    }
    if (nu == 0) toggle_bit(row, off0);
    else if (nu == 1) toggle_bit(row, off1 + u[0]);
    else if (nu == 2) toggle_bit(row, col_of_2(u[0], u[1], off2, col2_base));
    else toggle_bit(row, col_of_3(u[0], u[1], u[2], n, col3_base));
}

static inline void add_orb_prod(
    uint64_t *row, const int *js, int nj,
    const int *orb_map, int c99, const int *L_vars, int nL,
    int n, int off2, int off1, int off0,
    const int *col2_base, const int *col3_base
) {
    int vs[3], nv = 0, has_c0 = 0;
    for (int i = 0; i < nj; i++) {
        int m = orb_map[js[i]];
        if (m == -1) return;
        else if (m == -2) continue;
        else if (m == -3) has_c0 = 1;
        else vs[nv++] = m;
    }
    if (!has_c0) {
        toggle_vars_set(row, vs, nv, n, off2, off1, off0, col2_base, col3_base);
    } else {
        if (c99) {
            toggle_vars_set(row, vs, nv, n, off2, off1, off0, col2_base, col3_base);
        }
        int vs2[3];
        for (int i = 0; i < nv; i++) vs2[i] = vs[i];
        for (int t = 0; t < nL; t++) {
            vs2[nv] = L_vars[t];
            toggle_vars_set(row, vs2, nv + 1, n, off2, off1, off0, col2_base, col3_base);
        }
    }
}

// Build exact wt_15(D_a f) == 0 (mod 16) cubic row.
// deriv_bits: (116, 512) packed uint64 truth tables of D_a g_j on F_2^16 / <a> (32768 pts).
// Returns 0 on success, <0 if divisibility fails.
int build_deriv_mod16_cubic_c(
    const uint64_t *deriv_bits, int nw,
    const int *orb_map, int c99, const int *L_vars, int nL,
    int n, int off2, int off1, int off0, int n_cw,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));

    int active[116], na = 0;
    for (int j = 0; j < 116; j++) {
        if (orb_map[j] == -1) continue;
        const uint64_t *bj = deriv_bits + (size_t)j * nw;
        uint64_t any = 0;
        for (int w = 0; w < nw; w++) any |= bj[w];
        if (any) active[na++] = j;
    }

    // 1. Linear terms: 8 | wt_15(h_j)
    for (int ia = 0; ia < na; ia++) {
        int j = active[ia];
        const uint64_t *bj = deriv_bits + (size_t)j * nw;
        int wt = 0;
        for (int w = 0; w < nw; w++) wt += __builtin_popcountll(bj[w]);
        if (wt & 7) return -1;
        if ((wt >> 3) & 1) {
            int js[1] = {j};
            add_orb_prod(out_row, js, 1, orb_map, c99, L_vars, nL, n, off2, off1, off0, col2_base, col3_base);
        }
    }

    // 2. Quadratic & Cubic terms
    uint64_t tmp[512];
    for (int ia = 0; ia < na; ia++) {
        int j = active[ia];
        const uint64_t *bj = deriv_bits + (size_t)j * nw;
        for (int ib = ia + 1; ib < na; ib++) {
            int k = active[ib];
            const uint64_t *bk = deriv_bits + (size_t)k * nw;
            int wt2 = 0;
            uint64_t any2 = 0;
            for (int w = 0; w < nw; w++) {
                uint64_t v = bj[w] & bk[w];
                tmp[w] = v;
                any2 |= v;
                wt2 += __builtin_popcountll(v);
            }
            if (wt2 & 3) return -2;
            if ((wt2 >> 2) & 1) {
                int js[2] = {j, k};
                add_orb_prod(out_row, js, 2, orb_map, c99, L_vars, nL, n, off2, off1, off0, col2_base, col3_base);
            }
            if (!any2) continue;
            for (int ic = ib + 1; ic < na; ic++) {
                int l = active[ic];
                const uint64_t *bl = deriv_bits + (size_t)l * nw;
                int wt3 = 0;
                for (int w = 0; w < nw; w++) {
                    wt3 += __builtin_popcountll(tmp[w] & bl[w]);
                }
                if (wt3 & 1) return -3;
                if ((wt3 >> 1) & 1) {
                    int js[3] = {j, k, l};
                    add_orb_prod(out_row, js, 3, orb_map, c99, L_vars, nL, n, off2, off1, off0, col2_base, col3_base);
                }
            }
        }
    }
    return 0;
}
"""


def eval_row_at_x111(row_ptr, x111, tbl):
    n = tbl["n"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    c2b, c3b = tbl["col2_base"], tbl["col3_base"]

    def get_bit(col):
        return (int(row_ptr[col >> 6]) >> (col & 63)) & 1

    acc = get_bit(off0)
    ones = [i for i in range(n) if x111[i]]
    for i in ones:
        acc ^= get_bit(off1 + i)
    for ia in range(len(ones)):
        i = ones[ia]
        b2 = off2 + c2b[i]
        for ib in range(ia + 1, len(ones)):
            j = ones[ib]
            acc ^= get_bit(b2 + (j - i - 1))
            b3 = c3b[i * n + j]
            for ic in range(ib + 1, len(ones)):
                k = ones[ic]
                acc ^= get_bit(b3 + (k - j - 1))
    return acc & 1


def canon_c16(a):
    best = a
    cur = a
    for _ in range(15):
        cur = ((cur << 1) | (cur >> 15)) & 0xFFFF
        if cur < best:
            best = cur
    return best


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 54B: DERIVATIVE AUTOCORRELATION MOD-16 CUBICS ====================", flush=True)

    c_dm, so_dm = WORK_DIR / "s54b_dm.c", WORK_DIR / "libs54b_dm.so"
    c_dm.write_text(C_DERIV_MOD16_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_dm), "-o", str(so_dm)], check=True)
    lib_dm = ctypes.CDLL(str(so_dm))
    lib_dm.build_deriv_mod16_cubic_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_dm.build_deriv_mod16_cubic_c.restype = ctypes.c_int

    c_diag, so_diag = WORK_DIR / "s54b_diag.c", WORK_DIR / "libs54b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s54b_s9.c", WORK_DIR / "libs54b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s54b_cg.c", WORK_DIR / "libs54b_cg.so"
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

    orbits = diag_v2.build_orbits_116()
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
    n, n_cw = tbl["n"], tbl["n_col_words"]
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

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
    total_base = n_base + len(cyc_cubs) + n_cg
    base_buf = (ctypes.c_uint64 * (total_base * n_cw))()
    ctypes.memmove(base_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, base_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(base_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    def _fmt_res(r):
        if r.get("closed_unsat"):
            return f"CLOSED_UNSAT=True (rounds={r.get('rounds')})"
        if "N_active" not in r:
            return f"closed_unsat=False (note={r.get('note')}, rounds={r.get('rounds')})"
        return (
            f"closed_unsat=False, N={r['N_active']}, n_lin={len(r['_lin_pivs'])}, "
            f"n_quad={r['n_quad_surviving']}, n_cub={r['n_genuine_cubics']}"
        )

    root0 = s9.run_branch_cascade(lib9, base_buf, [], list(range(total_base)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    print(f"  [BASELINE ROOT] {_fmt_res(root0)}", flush=True)

    # Build diverse C_16-distinct non-zero derivative directions a in F_2^16 \ {0}:
    # - ALL weight 1 (1 orbit), weight 2 (8 orbits), weight 3 (35 orbits)
    # - ALL rho^8-invariant a = v | (v << 8) (35 C_8-orbits)
    # - 150 random C_16-orbits of weights 4..15 + 0xFFFF
    seen_a = set()
    a_list = []

    def add_a(a):
        if a == 0:
            return
        c = canon_c16(a)
        if c not in seen_a:
            seen_a.add(c)
            a_list.append(c)

    # Weight 1, 2, 3
    for i in range(16):
        add_a(1 << i)
    for i in range(16):
        for j in range(i + 1, 16):
            add_a((1 << i) | (1 << j))
    for i in range(16):
        for j in range(i + 1, 16):
            for k in range(j + 1, 16):
                add_a((1 << i) | (1 << j) | (1 << k))
    # rho^8-invariant
    for v in range(1, 256):
        add_a(v | (v << 8))
    add_a(0xFFFF)
    # Random directions
    rng = np.random.default_rng(5422)
    while len(a_list) < 250:
        add_a(int(rng.integers(1, 65536)))

    print(f"  Testing {len(a_list)} C_16-distinct derivative directions a != 0...", flush=True)

    # 5 random 111-var vectors for Zero-Trust verification
    test_x111 = [rng.integers(0, 2, size=111, dtype=np.uint8) for _ in range(5)]
    test_c116 = []
    for xv in test_x111:
        c116 = np.zeros(116, dtype=np.uint8)
        for i, j in enumerate(free111):
            c116[j] = xv[i]
        c116[99] = c99; c116[57] = c57; c116[113] = c113; c116[115] = 0
        c116[0] = (c99 ^ sum(int(xv[i]) for i in L_vars_py)) & 1
        test_c116.append(c116)
    test_f_tt = [(c116.astype(np.uint16) @ orb_tt_np.astype(np.uint16)) & 1 for c116 in test_c116]

    deriv_rows = []
    zt_ok = 0
    zt_tot = 0
    fail_div = 0
    t_b = time.perf_counter()

    # Precompute bit-0..15 half-space indices
    half_pts_by_bit = [np.flatnonzero((X & (1 << b)) == 0).astype(np.uint16) for b in range(16)]

    for idx_a, a in enumerate(a_list):
        b0 = (a & -a).bit_length() - 1
        pts0 = half_pts_by_bit[b0]
        pts1 = pts0 ^ np.uint16(a)
        # D_a g_j on F_2^15 (shape 116 x 32768)
        d_bits = (orb_tt_np[:, pts0] ^ orb_tt_np[:, pts1]).reshape(116, 512, 64)
        packed = np.packbits(d_bits, axis=2, bitorder="little").view(np.uint64).reshape(116, 512)
        packed = np.ascontiguousarray(packed)
        out_row = (ctypes.c_uint64 * n_cw)()
        rc = lib_dm.build_deriv_mod16_cubic_c(
            packed.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), 512,
            orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
            tbl["col2_base"], tbl["col3_base"], out_row
        )
        if rc != 0:
            fail_div += 1
            continue
        if idx_a < 10:
            for ti in range(5):
                df_tt = test_f_tt[ti][pts0] ^ test_f_tt[ti][pts1]
                wt15 = int(df_tt.sum())
                assert (wt15 & 7) == 0, f"wt15={wt15} not div by 8!"
                expected_bit = (wt15 >> 3) & 1
                got_bit = eval_row_at_x111(out_row, test_x111[ti], tbl)
                zt_tot += 1
                if got_bit == expected_bit:
                    zt_ok += 1
                else:
                    raise RuntimeError(f"ZERO-TRUST MISMATCH at a=0x{a:04x}: exp={expected_bit}, got={got_bit}, wt15={wt15}")
        deriv_rows.append(out_row)
        if (idx_a + 1) in (50, 120, len(a_list)):
            print(f"    built {len(deriv_rows)}/{idx_a+1} rows (fail_div={fail_div}, ZT={zt_ok}/{zt_tot}, {time.perf_counter()-t_b:.1f}s)", flush=True)

    # Merge ALL derivative mod-16 cubics with baseline and run cascade!
    tot_all = total_base + len(deriv_rows)
    all_buf = (ctypes.c_uint64 * (tot_all * n_cw))()
    ctypes.memmove(all_buf, base_buf, total_base * n_cw * 8)
    for ri, r_arr in enumerate(deriv_rows):
        ctypes.memmove(ctypes.byref(all_buf, (total_base + ri) * n_cw * 8), r_arr, n_cw * 8)
    res_all = s9.run_branch_cascade(lib9, all_buf, [], list(range(tot_all)), {}, [], tbl, max_xl_rounds=25, verify_subst=True)
    print(
        f"\n  [BASELINE + {len(deriv_rows)} DERIV-AUTOCORR MOD-16 CUBICS] -> {_fmt_res(res_all)}",
        flush=True,
    )
    print(f"\n[{cell_name}] STEP 54B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
