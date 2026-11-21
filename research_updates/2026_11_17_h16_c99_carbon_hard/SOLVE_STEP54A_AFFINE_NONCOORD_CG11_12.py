#!/usr/bin/env python3
r"""
SOLVE_STEP54A_AFFINE_NONCOORD_CG11_12.py

BREAKTHROUGH ATTACK ON B0_11 & B1_11:
GENERAL AFFINE & NON-COORDINATE 11-DIM / 12-DIM SUBSPACE MOD-8 CUBIC EQUATIONS!

Mathematical Theorem (Zero-Trust verified):
  For ANY 16-variable bent function f of degree <= 4 and ANY affine subspace A of F_2^16
  of dimension k in {11, 12}:
    1. wt(f|_A) == 0 (mod 8)   (since W_f(u) = +-2^8 => 2^{k-7} | S_A => 2^{k-8} | wt(f|_A)).
    2. By the exact identity (s mod 2) == s - 2*C(s,2) + 4*C(s,3) (mod 8) applied pointwise to
       f(x) = XOR_{j=0}^{115} c_j g_j(x):
         wt(f|_A) == sum_j c_j alpha_j - 2 sum_{j<k} c_j c_k beta_{jk} + 4 sum_{j<k<l} c_j c_k c_l gamma_{jkl} (mod 8)
       where alpha_j = wt(g_j|_A), beta_{jk} = wt(g_j g_k|_A), gamma_{jkl} = wt(g_j g_k g_l|_A).
    3. By Ax-Warning / RM divisibility on dim(A) = k >= 11:
         deg(g_j) <= 4 => 4 | alpha_j ALWAYS!
         deg(g_j g_k) <= 8 => 2 | beta_{jk} ALWAYS!
    4. Dividing by 4 yields an EXACT F_2 polynomial equation of degree <= 3 in c_0..c_{115}
       (with ZERO degree-4 terms and ZERO carry terms!) for EVERY 11-dim or 12-dim affine
       subspace A (coordinate or non-coordinate, linear or affine!).

Previously, Step 10 ONLY tested linear coordinate subspaces (a = 0), which have alpha_j = 0
and beta_{jk} = 0. Here we test:
  - Family 1: Affine coordinate 11-dim subspaces (a != 0)
  - Family 2: Non-coordinate linear 11-dim subspaces (x_a + x_b = 0, x_a + x_b + x_c = 0, ...)
  - Family 3: Non-coordinate affine 11-dim subspaces (x_a + x_b = 1, ...)
  - Family 4: Random 11-dim and 12-dim affine subspaces over F_2^16
and measure how many NEW linear, quadratic, and cubic pivots they add to B0_11 and B1_11!
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


C_MOD8_SUBSPACE_SRC = r"""
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

// Expand product of 1, 2, or 3 orbit variables c_{js[0]} * ... into free111 row
// orb_map[j]: >=0 var idx, -1 fixed 0, -2 fixed 1, -3 c_0 = c99 ^ XOR L_vars
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

// Build exact mod-8 cubic row for an affine subspace A of size n_pts (2048 or 4096, multiple of 64).
// orb_bits: (116, nw) packed uint64 truth tables of orbits 0..115 restricted to A.
// Returns 0 on success, -1 if divisibility (4|alpha or 2|beta) fails.
int build_subspace_mod8_cubic_c(
    const uint64_t *orb_bits, int nw,
    const int *orb_map, int c99, const int *L_vars, int nL,
    int n, int off2, int off1, int off0, int n_cw,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));

    // Only keep orbits that are NOT fixed 0 (orb_map[j] != -1) AND non-zero on A
    int active[116], na = 0;
    for (int j = 0; j < 116; j++) {
        if (orb_map[j] == -1) continue;
        const uint64_t *bj = orb_bits + (size_t)j * nw;
        uint64_t any = 0;
        for (int w = 0; w < nw; w++) any |= bj[w];
        if (any) active[na++] = j;
    }

    // 1. Linear terms: alpha_j = wt(g_j|_A), must be divisible by 4
    for (int ia = 0; ia < na; ia++) {
        int j = active[ia];
        const uint64_t *bj = orb_bits + (size_t)j * nw;
        int wt = 0;
        for (int w = 0; w < nw; w++) wt += __builtin_popcountll(bj[w]);
        if (wt & 3) return -1;
        if ((wt >> 2) & 1) {
            int js[1] = {j};
            add_orb_prod(out_row, js, 1, orb_map, c99, L_vars, nL, n, off2, off1, off0, col2_base, col3_base);
        }
    }

    // 2. Quadratic & Cubic terms
    uint64_t tmp[64]; // supports up to nw=64 (4096 pts = 12-dim subspace)
    for (int ia = 0; ia < na; ia++) {
        int j = active[ia];
        const uint64_t *bj = orb_bits + (size_t)j * nw;
        for (int ib = ia + 1; ib < na; ib++) {
            int k = active[ib];
            const uint64_t *bk = orb_bits + (size_t)k * nw;
            int wt2 = 0;
            uint64_t any2 = 0;
            for (int w = 0; w < nw; w++) {
                uint64_t v = bj[w] & bk[w];
                tmp[w] = v;
                any2 |= v;
                wt2 += __builtin_popcountll(v);
            }
            if (wt2 & 1) return -2;
            if ((wt2 >> 1) & 1) {
                int js[2] = {j, k};
                add_orb_prod(out_row, js, 2, orb_map, c99, L_vars, nL, n, off2, off1, off0, col2_base, col3_base);
            }
            if (!any2) continue;
            for (int ic = ib + 1; ic < na; ic++) {
                int l = active[ic];
                const uint64_t *bl = orb_bits + (size_t)l * nw;
                uint64_t par = 0;
                for (int w = 0; w < nw; w++) par ^= (tmp[w] & bl[w]);
                if (__builtin_parityll(par)) {
                    int js[3] = {j, k, l};
                    add_orb_prod(out_row, js, 3, orb_map, c99, L_vars, nL, n, off2, off1, off0, col2_base, col3_base);
                }
            }
        }
    }
    return 0;
}
"""


def make_affine_subspace_points(basis_vecs, shift):
    """Given k basis vectors (ints in 0..65535) and shift, return np.uint16 array of 2^k points."""
    pts = np.array([shift], dtype=np.uint16)
    for b in basis_vecs:
        pts = np.concatenate([pts, pts ^ np.uint16(b)])
    return pts


def subspace_from_constraints(eq_masks, rhs_bits):
    """
    Build affine subspace {x in F_2^16 : parity(x & eq_masks[i]) == rhs_bits[i]}.
    Returns (basis_vecs, shift) or None if inconsistent.
    """
    m = len(eq_masks)
    # Build (m, 17) augmented matrix
    M = np.zeros((m, 17), dtype=np.uint8)
    for i in range(m):
        for b in range(16):
            M[i, b] = (eq_masks[i] >> b) & 1
        M[i, 16] = rhs_bits[i] & 1
    # RREF
    r = 0
    pivs = []
    for c in range(16):
        if r >= m:
            break
        nz = np.where(M[r:, c] == 1)[0]
        if len(nz) == 0:
            continue
        p = r + int(nz[0])
        if p != r:
            M[[r, p]] = M[[p, r]]
        rows = np.where(M[:, c] == 1)[0]
        rows = rows[rows != r]
        if len(rows):
            M[rows] ^= M[r]
        pivs.append(c)
        r += 1
    for i in range(r, m):
        if M[i, 16]:
            return None
    piv_set = set(pivs)
    free_cols = [c for c in range(16) if c not in piv_set]
    shift = 0
    for idx_r, pc in enumerate(pivs):
        if M[idx_r, 16]:
            shift |= (1 << pc)
    basis = []
    for fc in free_cols:
        v = (1 << fc)
        for idx_r, pc in enumerate(pivs):
            if M[idx_r, fc]:
                v |= (1 << pc)
        basis.append(v)
    return basis, shift


def eval_row_at_x111(row_ptr, x111, tbl):
    """Evaluate a single 111-var degree<=3 row at x111 (list/array of 111 bits)."""
    n = tbl["n"]
    n_cw = tbl["n_col_words"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    c2b = tbl["col2_base"]
    c3b = tbl["col3_base"]

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


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 54A: AFFINE & NON-COORDINATE 11/12-DIM MOD-8 CUBICS ====================", flush=True)

    c_mod8, so_mod8 = WORK_DIR / "s54a_mod8.c", WORK_DIR / "libs54a_mod8.so"
    c_mod8.write_text(C_MOD8_SUBSPACE_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_mod8), "-o", str(so_mod8)], check=True)
    lib_m8 = ctypes.CDLL(str(so_mod8))
    lib_m8.build_subspace_mod8_cubic_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_m8.build_subspace_mod8_cubic_c.restype = ctypes.c_int

    c_diag, so_diag = WORK_DIR / "s54a_diag.c", WORK_DIR / "libs54a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s54a_s9.c", WORK_DIR / "libs54a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s54a_cg.c", WORK_DIR / "libs54a_cg.so"
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

    root0 = s9.run_branch_cascade(lib9, base_buf, [], list(range(total_base)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    print(f"  [BASELINE ROOT] closed={root0['closed']}, N={root0['N']}, n_lin={len(root0['_lin_pivs'])}, n_quad={len(root0['_quad_ids'])}, n_cub={len(root0['_cub_ids'])}", flush=True)

    # Generate 4 families of 11-dim and 12-dim affine subspaces
    rng = np.random.default_rng(5401)
    families = {}

    # Family 1: Affine coordinate 11-dim subspaces (non-zero shifts on the 5 fixed coordinates)
    fam1 = []
    for idx_r in range(0, len(reps11), 3):
        I_m = reps11[idx_r]
        fixed_bits = [b for b in range(16) if not ((I_m >> b) & 1)]
        eq_masks = [1 << b for b in fixed_bits]
        for rhs_mask in [1, 3, 7, 31]:
            rhs = [(rhs_mask >> i) & 1 for i in range(5)]
            fam1.append((eq_masks, rhs))
        if len(fam1) >= 120:
            break
    families["Fam1_AffineCoord11"] = fam1

    # Family 2: Non-coordinate linear 11-dim subspaces (structured parity constraints)
    fam2 = []
    # 1 parity x_0+x_d=0 + 4 coord constraints
    for d in [1, 2, 3, 4, 5, 6, 7, 8]:
        for c_off in range(4):
            eqs = [(1 << 0) | (1 << d)]
            used = {0, d}
            for k in range(16):
                b = (k + 3 * c_off + 1) % 16
                if b not in used:
                    eqs.append(1 << b)
                    used.add(b)
                if len(eqs) == 5:
                    break
            fam2.append((eqs, [0, 0, 0, 0, 0]))
    # 2 parities x_0+x_d1=0, x_1+x_d2=0 + 3 coord
    for d1 in [2, 4, 8]:
        for d2 in [3, 5, 9]:
            eqs = [(1 << 0) | (1 << d1), (1 << 1) | (1 << d2), 1 << 6, 1 << 7, 1 << 10]
            fam2.append((eqs, [0, 0, 0, 0, 0]))
    # 4 parities (D8-like: x_i + x_{i+8} = 0 for 4 pairs + 1 coord)
    for drop_i in range(4):
        eqs = [(1 << i) | (1 << (i + 8)) for i in range(4)] + [1 << (4 + drop_i)]
        fam2.append((eqs, [0, 0, 0, 0, 0]))
    # 5 parities (weight-2 and weight-3)
    for _ in range(60):
        eqs = []
        while len(eqs) < 5:
            wt = int(rng.choice([2, 3, 4]))
            bits = rng.choice(16, size=wt, replace=False)
            m = sum(1 << int(b) for b in bits)
            eqs.append(m)
        res = subspace_from_constraints(eqs, [0] * 5)
        if res is not None and len(res[0]) == 11:
            fam2.append((eqs, [0] * 5))
    families["Fam2_NonCoordLin11"] = fam2

    # Family 3: Non-coordinate AFFINE 11-dim subspaces (rhs != 0)
    fam3 = []
    for eqs, _ in fam2[:100]:
        rhs = [int(rng.integers(0, 2)) for _ in range(5)]
        if sum(rhs) == 0:
            rhs[0] = 1
        fam3.append((eqs, rhs))
    families["Fam3_NonCoordAff11"] = fam3

    # Family 4: Random 11-dim and 12-dim affine subspaces over F_2^16
    fam4 = []
    for target_dim in [11, 12]:
        m_eq = 16 - target_dim
        cnt = 0
        while cnt < 80:
            eqs = [int(rng.integers(1, 65536)) for _ in range(m_eq)]
            rhs = [int(rng.integers(0, 2)) for _ in range(m_eq)]
            res = subspace_from_constraints(eqs, rhs)
            if res is not None and len(res[0]) == target_dim:
                fam4.append((eqs, rhs))
                cnt += 1
    families["Fam4_RandomAff11_12"] = fam4

    # Prepare 5 random 111-var test vectors for Zero-Trust verification
    test_x111 = [rng.integers(0, 2, size=111, dtype=np.uint8) for _ in range(5)]
    test_c116 = []
    for xv in test_x111:
        c116 = np.zeros(116, dtype=np.uint8)
        for i, j in enumerate(free111):
            c116[j] = xv[i]
        c116[99] = c99; c116[57] = c57; c116[113] = c113; c116[115] = 0
        c116[0] = (c99 ^ sum(int(xv[i]) for i in L_vars_py)) & 1
        test_c116.append(c116)

    # Pre-evaluate truth tables of the 5 random test functions
    test_f_tt = [(c116.astype(np.uint16) @ orb_tt_np.astype(np.uint16)) & 1 for c116 in test_c116]

    all_new_rows = []
    for fam_name, sub_list in families.items():
        t_f = time.perf_counter()
        fam_rows = []
        zt_ok = 0
        zt_tot = 0
        fail_div = 0
        for idx_s, (eqs, rhs) in enumerate(sub_list):
            res = subspace_from_constraints(eqs, rhs)
            if res is None:
                continue
            basis, shift = res
            k_dim = len(basis)
            if k_dim not in (11, 12):
                continue
            pts = make_affine_subspace_points(basis, shift)
            nw = len(pts) // 64
            # Pack orb_tt_np[:, pts] into (116, nw) uint64
            sub_bits = orb_tt_np[:, pts].reshape(116, nw, 64)
            packed = np.packbits(sub_bits, axis=2, bitorder="little").view(np.uint64).reshape(116, nw)
            packed = np.ascontiguousarray(packed)
            out_row = (ctypes.c_uint64 * n_cw)()
            rc = lib_m8.build_subspace_mod8_cubic_c(
                packed.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), nw,
                orb_map, c99, L_vars_arr, len(L_vars_py),
                n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
                tbl["col2_base"], tbl["col3_base"], out_row
            )
            if rc != 0:
                fail_div += 1
                continue
            # Zero-trust verify first 5 subspaces of each family against exact wt(f|_A) mod 8
            if idx_s < 5:
                for ti in range(5):
                    wt_exact = int(test_f_tt[ti][pts].sum())
                    assert (wt_exact & 3) == 0, f"wt_exact={wt_exact} not div by 4!"
                    expected_bit = (wt_exact >> 2) & 1
                    got_bit = eval_row_at_x111(out_row, test_x111[ti], tbl)
                    zt_tot += 1
                    if got_bit == expected_bit:
                        zt_ok += 1
                    else:
                        raise RuntimeError(f"ZERO-TRUST MISMATCH in {fam_name} idx={idx_s}: expected={expected_bit}, got={got_bit}, wt={wt_exact}")
            fam_rows.append(out_row)

        # Test this family alone merged with baseline!
        tot_m = total_base + len(fam_rows)
        m_buf = (ctypes.c_uint64 * (tot_m * n_cw))()
        ctypes.memmove(m_buf, base_buf, total_base * n_cw * 8)
        for ri, r_arr in enumerate(fam_rows):
            ctypes.memmove(ctypes.byref(m_buf, (total_base + ri) * n_cw * 8), r_arr, n_cw * 8)
        res_m = s9.run_branch_cascade(lib9, m_buf, [], list(range(tot_m)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
        print(
            f"  [{fam_name}] built={len(fam_rows)} (div_fail={fail_div}), ZT={zt_ok}/{zt_tot} "
            f"-> closed={res_m['closed']}, N={res_m['N']}, n_lin={len(res_m['_lin_pivs'])}, "
            f"n_quad={len(res_m['_quad_ids'])}, n_cub={len(res_m['_cub_ids'])} ({time.perf_counter()-t_f:.1f}s)",
            flush=True,
        )
        all_new_rows.extend(fam_rows)

    # Finally test ALL families combined!
    tot_all = total_base + len(all_new_rows)
    all_buf = (ctypes.c_uint64 * (tot_all * n_cw))()
    ctypes.memmove(all_buf, base_buf, total_base * n_cw * 8)
    for ri, r_arr in enumerate(all_new_rows):
        ctypes.memmove(ctypes.byref(all_buf, (total_base + ri) * n_cw * 8), r_arr, n_cw * 8)
    res_all = s9.run_branch_cascade(lib9, all_buf, [], list(range(tot_all)), {}, [], tbl, max_xl_rounds=20, verify_subst=True)
    print(
        f"\n  [ALL 4 FAMILIES COMBINED ({len(all_new_rows)} new cubics)] "
        f"-> closed={res_all['closed']}, N={res_all['N']}, n_lin={len(res_all['_lin_pivs'])}, "
        f"n_quad={len(res_all['_quad_ids'])}, n_cub={len(res_all['_cub_ids'])}",
        flush=True,
    )
    print(f"\n[{cell_name}] STEP 54A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
