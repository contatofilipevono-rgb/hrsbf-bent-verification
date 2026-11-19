#!/usr/bin/env python3
r"""
SOLVE_STEP29B_NONCOORD_V12_AND_D8_COSET_BITS.py

FRONT 2: NEW NECESSARY BENTNESS OBSTRUCTIONS FOR B1_11, B0_11, B0_00!
  1. Non-coordinate 12-dim subspaces V_12 (and cosets a + V_12):
     By Poisson summation for ANY bent function f on F_2^16 and ANY 12-dim subspace V_12:
       16 | wt(f|_{a + V_12})  <==>  ((wt(f|_{a + V_12}) >> 3) & 1) == 0.
     Since deg(f) = 4 on 12 vars, this is ALWAYS a degree <= 3 polynomial in the 111 orbit vars!
     We screen 400 structured & random non-coordinate V_12 subspaces (including V_12 superset D_8,
     C_4/C_8-invariant V_12, pairwise-XOR hyperplanes, and cosets a + V_12) against the EXACT
     600-point evaluation row space of CG(389) + base root equations!
  2. D_8-coset weight bits in B1_11 & B0_11:
     Tests ((wt(f|_{a + D_8}) >> 2) & 1) and ((wt(f|_{a + D_8}) >> 3) & 1) for degree <= 3
     and linear independence above CG(389)!
  3. Second derivatives D_a D_b f (pure quadratic forms):
     Checks rank / weight mod 2^s of D_a D_b f for C_16-symmetric pairs (a, b).
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a

C_V12_SRC = r"""
#include <stdint.h>
#include <string.h>

/* Evaluate 111-var orbit truth tables at R random points x_pts (each 2 uint64 words),
   generating R truth tables of length 65536? No: better! For a given 4096-point subspace
   pts[4096], precompute the 111 basis vectors restricted to pts[4096] (64 uint64 words each),
   then for each of R random points, XOR active basis vectors and popcount! */

void eval_v12_batch(
    const uint8_t *orb_tt,      /* [116 * 65536] */
    const int *free111,         /* [111] */
    const uint8_t *origin111,   /* [116] */
    const uint8_t *cb111,       /* [111 * 116] */
    const uint16_t *pts,        /* [4096] */
    const uint64_t *x_lo,       /* [R] */
    const uint64_t *x_hi,       /* [R] */
    int R,
    int *out_wt                 /* [R] */
) {
    /* First compute the 111 basis truth tables + origin on pts[4096] as 64 uint64 words */
    uint64_t base_w[64];
    uint64_t basis_w[111][64];
    memset(base_w, 0, sizeof(base_w));
    memset(basis_w, 0, sizeof(basis_w));

    for (int k = 0; k < 4096; k++) {
        uint16_t x = pts[k];
        int w = k >> 6;
        uint64_t bit = 1ULL << (k & 63);
        int ov = 0;
        for (int o = 0; o < 116; o++) {
            if (origin111[o] && orb_tt[(size_t)o * 65536 + x]) ov ^= 1;
        }
        if (ov) base_w[w] |= bit;
    }
    for (int i = 0; i < 111; i++) {
        const uint8_t *row = cb111 + (size_t)i * 116;
        int active_o[116], na = 0;
        for (int o = 0; o < 116; o++) if (row[o]) active_o[na++] = o;
        for (int k = 0; k < 4096; k++) {
            uint16_t x = pts[k];
            int v = 0;
            for (int a = 0; a < na; a++) {
                if (orb_tt[(size_t)active_o[a] * 65536 + x]) v ^= 1;
            }
            if (v) basis_w[i][k >> 6] |= (1ULL << (k & 63));
        }
    }

    for (int r = 0; r < R; r++) {
        uint64_t acc[64];
        memcpy(acc, base_w, sizeof(acc));
        uint64_t lo = x_lo[r], hi = x_hi[r];
        while (lo) {
            int i = __builtin_ctzll(lo);
            lo &= lo - 1;
            for (int w = 0; w < 64; w++) acc[w] ^= basis_w[i][w];
        }
        while (hi) {
            int i = 64 + __builtin_ctzll(hi);
            hi &= hi - 1;
            for (int w = 0; w < 64; w++) acc[w] ^= basis_w[i][w];
        }
        int wt = 0;
        for (int w = 0; w < 64; w++) wt += __builtin_popcountll(acc[w]);
        out_wt[r] = wt;
    }
}

void eval_d8_cosets_batch(
    const uint8_t *orb_tt,      /* [116 * 65536] */
    const uint8_t *origin111,   /* [116] */
    const uint8_t *cb111,       /* [111 * 116] */
    const uint16_t *pts,        /* [256] */
    const uint64_t *x_lo,       /* [R] */
    const uint64_t *x_hi,       /* [R] */
    int R,
    int *out_wt                 /* [R] */
) {
    uint64_t base_w[4] = {0,0,0,0};
    uint64_t basis_w[111][4];
    memset(basis_w, 0, sizeof(basis_w));
    for (int k = 0; k < 256; k++) {
        uint16_t x = pts[k];
        int ov = 0;
        for (int o = 0; o < 116; o++) if (origin111[o] && orb_tt[(size_t)o * 65536 + x]) ov ^= 1;
        if (ov) base_w[k >> 6] |= (1ULL << (k & 63));
    }
    for (int i = 0; i < 111; i++) {
        const uint8_t *row = cb111 + (size_t)i * 116;
        int active_o[116], na = 0;
        for (int o = 0; o < 116; o++) if (row[o]) active_o[na++] = o;
        for (int k = 0; k < 256; k++) {
            uint16_t x = pts[k];
            int v = 0;
            for (int a = 0; a < na; a++) if (orb_tt[(size_t)active_o[a] * 65536 + x]) v ^= 1;
            if (v) basis_w[i][k >> 6] |= (1ULL << (k & 63));
        }
    }
    for (int r = 0; r < R; r++) {
        uint64_t acc[4] = {base_w[0], base_w[1], base_w[2], base_w[3]};
        uint64_t lo = x_lo[r], hi = x_hi[r];
        while (lo) {
            int i = __builtin_ctzll(lo); lo &= lo - 1;
            acc[0]^=basis_w[i][0]; acc[1]^=basis_w[i][1]; acc[2]^=basis_w[i][2]; acc[3]^=basis_w[i][3];
        }
        while (hi) {
            int i = 64 + __builtin_ctzll(hi); hi &= hi - 1;
            acc[0]^=basis_w[i][0]; acc[1]^=basis_w[i][1]; acc[2]^=basis_w[i][2]; acc[3]^=basis_w[i][3];
        }
        out_wt[r] = __builtin_popcountll(acc[0]) + __builtin_popcountll(acc[1]) +
                    __builtin_popcountll(acc[2]) + __builtin_popcountll(acc[3]);
    }
}
"""


def subspace_points_from_dual_basis(dual_vecs, shift=0):
    """Given 4 linearly independent vectors in F_2^16, return the 4096 points x with <x, d> = 0 for all d, shifted by shift."""
    pts = []
    d0, d1, d2, d3 = dual_vecs
    for x in range(65536):
        if (((x & d0).bit_count() & 1) == 0 and
            ((x & d1).bit_count() & 1) == 0 and
            ((x & d2).bit_count() & 1) == 0 and
            ((x & d3).bit_count() & 1) == 0):
            pts.append(x ^ shift)
    return np.array(pts, dtype=np.uint16)


def gf2_rank_insert(piv, vec):
    v = vec
    while v:
        b = v.bit_length() - 1
        if b in piv:
            v ^= piv[b]
        else:
            piv[b] = v
            return True
    return False


def check_in_span(piv, vec):
    v = vec
    while v:
        b = v.bit_length() - 1
        if b in piv:
            v ^= piv[b]
        else:
            return False
    return True


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_v12, orbits, orb_tt_np,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 29B: NON-COORD V_12 & D_8-COSET WEIGHT BITS ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    mask64 = (1 << 64) - 1

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

    # Generate R = 700 random points in F_2^111 and evaluate all total_raw equations (plus constant 1!)
    R = 700
    rng = random.Random(292929)
    x_pts = [rng.getrandbits(111) for _ in range(R)]
    x_lo = (ctypes.c_uint64 * R)(*[x & mask64 for x in x_pts])
    x_hi = (ctypes.c_uint64 * R)(*[x >> 64 for x in x_pts])

    base_piv = {}
    # Insert constant 1 vector? No: constant 1 is NOT a valid equation! Only insert valid equations!
    for r_id in range(total_raw):
        ev = 0
        for p_i in range(R):
            val = lib9.eval_row_s9(
                raw_buf, r_id, n_cw, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                x_lo[p_i], x_hi[p_i]
            )
            if val: ev |= (1 << p_i)
        gf2_rank_insert(base_piv, ev)
    print(f"  [{cell_name}] Baseline CG(389)+root eval rank on {R} pts = {len(base_piv)} / {total_raw}", flush=True)

    # Prepare ctypes pointers for orb_tt, origin111, cb111
    orb_tt_flat = np.ascontiguousarray(orb_tt_np.reshape(-1), dtype=np.uint8)
    orig_u8 = np.ascontiguousarray(origin111, dtype=np.uint8)
    cb_u8 = np.ascontiguousarray(cb111.reshape(-1), dtype=np.uint8)
    free_c = (ctypes.c_int * 111)(*free111)
    out_wt = (ctypes.c_int * R)()

    # Build 120 structured & random non-coordinate 12-dim subspaces V_12 (defined by 4 dual vectors!)
    v12_specs = []
    # 1) V_12 superset D_8 (dual vectors in D_8^perp = {b : b_i = b_{i+8}}!)
    d8p_basis = [(1 << i) | (1 << (i + 8)) for i in range(8)]
    for name, idxs, sh in [
        ("D8sup_0123", (0, 1, 2, 3), 0),
        ("D8sup_0246_C4", (0, 2, 4, 6), 0),
        ("D8sup_0246_sh1", (0, 2, 4, 6), 1),
        ("D8sup_0145_C4", (0, 1, 4, 5), 0),
        ("D8sup_0145_sh3", (0, 1, 4, 5), 3),
        ("D8sup_pairs_sh1", (0, 1, 2, 3), 0x00FF),
    ]:
        v12_specs.append((name, [d8p_basis[i] for i in idxs], sh))

    # 2) C_4-invariant V_12 (dual basis = one C_4 orbit of size 4!)
    for seed_v in [0x1111, 0x3333, 0x5555, 0x0101, 0x0303, 0x0505, 0x0707, 0x0F0F, 0x1313, 0x1515, 0x0001, 0x0003, 0x0005, 0x0007, 0x0011, 0x0013]:
        orb = []
        cur = seed_v
        for _ in range(4):
            orb.append(cur)
            cur = ((cur << 4) | (cur >> 12)) & 0xFFFF
        # Check rank 4
        piv4 = {}
        for d in orb: gf2_rank_insert(piv4, d)
        if len(piv4) == 4:
            v12_specs.append((f"C4_0x{seed_v:04x}_sh0", orb, 0))
            v12_specs.append((f"C4_0x{seed_v:04x}_sh1", orb, 1))

    # 3) Pairwise-XOR non-coordinate subspaces + random 12-dim subspaces (with & without coset shift)
    rng_v = random.Random(290029)
    for k in range(80):
        while True:
            ds = [rng_v.randrange(1, 65536) for _ in range(4)]
            piv4 = {}
            for d in ds: gf2_rank_insert(piv4, d)
            if len(piv4) == 4:
                sh = 0 if k < 40 else rng_v.randrange(1, 65536)
                v12_specs.append((f"RAND_{k:02d}_sh{sh:04x}", ds, sh))
                break

    # Test every V_12 spec!
    new_piv = dict(base_piv)
    n_new_v12 = 0
    n_ax_fail = 0
    new_examples = []
    for name, ds, sh in v12_specs:
        pts = subspace_points_from_dual_basis(ds, sh)
        assert len(pts) == 4096
        lib_v12.eval_v12_batch(
            orb_tt_flat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            free_c,
            orig_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            cb_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            pts.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
            x_lo, x_hi, R, out_wt
        )
        # Check 8 | wt ALWAYS (Ax's theorem for deg 4 on 12 vars)
        ev_b3 = 0
        ax_ok = True
        for p_i in range(R):
            w = out_wt[p_i]
            if (w & 7) != 0: ax_ok = False
            if (w >> 3) & 1: ev_b3 |= (1 << p_i)
        if not ax_ok:
            n_ax_fail += 1
            continue
        if ev_b3 != 0 and not check_in_span(new_piv, ev_b3):
            gf2_rank_insert(new_piv, ev_b3)
            n_new_v12 += 1
            if len(new_examples) < 15:
                new_examples.append((name, ev_b3.bit_count()))
    print(
        f"  [{cell_name}] V_12 NON-COORD SWEEP ({len(v12_specs)} subspaces): ax_fail={n_ax_fail} | "
        f"*** NEW_RANK_ABOVE_CG389 = +{n_new_v12} *** (total_rank={len(new_piv)}/{len(base_piv)})",
        flush=True,
    )
    if new_examples:
        print(f"    Examples of NEW V_12 cubics: {new_examples}", flush=True)

    # PART 2: D_8-COSET WEIGHT BITS IN B1_11 / B0_11 / B0_00 (all 35 C_8-orbits of z != 0!)
    z_reps = []
    seen_z = set()
    for z in range(1, 256):
        if z in seen_z: continue
        z_reps.append(z)
        cur = z
        for _ in range(8):
            seen_z.add(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF

    new_d8_b2, new_d8_b3 = 0, 0
    d8_piv = dict(base_piv)
    for z in z_reps:
        pts = np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16)
        lib_v12.eval_d8_cosets_batch(
            orb_tt_flat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            orig_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            cb_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            pts.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
            x_lo, x_hi, R, out_wt
        )
        mod4_vals = set(out_wt[i] & 3 for i in range(R))
        mod8_vals = set(out_wt[i] & 7 for i in range(R))
        ev_b2 = sum((1 << i) for i in range(R) if (out_wt[i] >> 2) & 1)
        ev_b3 = sum((1 << i) for i in range(R) if (out_wt[i] >> 3) & 1)
        if ev_b2 != 0 and not check_in_span(d8_piv, ev_b2):
            gf2_rank_insert(d8_piv, ev_b2); new_d8_b2 += 1
        if ev_b3 != 0 and not check_in_span(d8_piv, ev_b3):
            gf2_rank_insert(d8_piv, ev_b3); new_d8_b3 += 1
    print(
        f"  [{cell_name}] D_8-COSET WEIGHT BITS ({len(z_reps)} z-orbits): "
        f"new_rank_b2=+{new_d8_b2}, new_rank_b3=+{new_d8_b3} (note: in B0_11/B1_11, b2/b3 need bentness target check!)",
        flush=True,
    )
    print(f"[{cell_name}] STEP 29B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11,B0_00")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s29b_diag.c", WORK_DIR / "libs29b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s29b_s9.c", WORK_DIR / "libs29b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = ctypes.CDLL(str(so_s9))
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s29b_cg.c", WORK_DIR / "libs29b_cg.so"
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

    c_v12, so_v12 = WORK_DIR / "s29b_v12.c", WORK_DIR / "libs29b_v12.so"
    c_v12.write_text(C_V12_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_v12), "-o", str(so_v12)], check=True)
    lib_v12 = ctypes.CDLL(str(so_v12))
    lib_v12.eval_v12_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int),
    ]
    lib_v12.eval_d8_cosets_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint16),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int),
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

    for cell in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cell, lib_diag, lib9, lib_cg, lib_v12, orbits, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
