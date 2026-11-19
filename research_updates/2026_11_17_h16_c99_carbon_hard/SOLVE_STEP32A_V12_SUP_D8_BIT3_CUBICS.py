#!/usr/bin/env python3
r"""
SOLVE_STEP32A_V12_SUP_D8_BIT3_CUBICS.py

FRONT 1 (40-vCPU Assault): EXACT BIT-3 CUBICS ((wt(f|_{a + V_12}) >> 3) & 1 == 0)
FOR 12-DIM SUBSPACES V_12 SUPERSET D_8 (V_12^perp subset D_8^perp)!
  - In Step 30, D8sup_0123 had `8 | wt(f|_{a+V_12})` IDENTICALLY AND `deg = 3` in ALL 3 open cells!
  - By Poisson summation, `16 | wt(f|_{a+V_12})` is 100% NECESSARY for EVERY bent function in
    B1_11, B0_11, AND B0_00 (independent of f_tilde|_{D_8^perp}!).
  - Extracts 120 exact Bit-3 degree-3 equations for V_12 superset D_8 in C (directly on the root
    affine subspace where 8 | wt holds identically!), verifies 0 mismatches on 500 random points,
    and checks if they add NEW CUBIC RANK above CG(389) & collapse B1_11, B0_11, B0_00!
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

C_V12_B3_SRC = r"""
#include <stdint.h>
#include <string.h>

static inline int pop64_arr(const uint64_t *a) {
    int s = 0;
    for (int w = 0; w < 64; w++) s += __builtin_popcountll(a[w]);
    return s;
}

static inline void toggle_bit(uint64_t *row, int col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

/* Extract the EXACT cubic polynomial of ((wt(f(x)|_{pts}) >> 3) & 1) over active variables
   (where inactive variables have zero basis_w). Returns 0 if 8|wt held on all basis triples,
   else negative error code. */
int extract_v12_bit3_cubic_row(
    const uint8_t *orb_tt,      /* [116 * 65536] */
    const uint8_t *origin_root, /* [116] */
    const uint8_t *cb_root,     /* [111 * 116] (zero rows for inactive vars) */
    const uint8_t *is_active,   /* [111] */
    const uint16_t *pts,        /* [4096] */
    int n,                      /* 111 */
    int off2,
    int off1,
    int off0,
    int n_cw,
    const int *col2_base,
    const int *col3_base,
    uint64_t *out_row,          /* [n_cw] */
    int *out_verify_wts,        /* [R_ver] */
    const uint64_t *ver_lo,
    const uint64_t *ver_hi,
    int R_ver
) {
    uint64_t base_w[64];
    uint64_t basis_w[111][64];
    memset(base_w, 0, sizeof(base_w));
    memset(basis_w, 0, sizeof(basis_w));
    memset(out_row, 0, (size_t)n_cw * sizeof(uint64_t));

    for (int k = 0; k < 4096; k++) {
        uint16_t x = pts[k];
        int ov = 0;
        for (int o = 0; o < 116; o++) {
            if (origin_root[o] && orb_tt[(size_t)o * 65536 + x]) ov ^= 1;
        }
        if (ov) base_w[k >> 6] |= (1ULL << (k & 63));
    }
    for (int i = 0; i < n; i++) {
        if (!is_active[i]) continue;
        const uint8_t *row = cb_root + (size_t)i * 116;
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

    int wt0 = pop64_arr(base_w);
    if (wt0 & 7) return -1;
    int c0 = (wt0 >> 3) & 1;
    if (c0) toggle_bit(out_row, off0);

    int c1[111];
    memset(c1, 0, sizeof(c1));
    uint64_t tmp[64];
    for (int i = 0; i < n; i++) {
        if (!is_active[i]) continue;
        for (int w = 0; w < 64; w++) tmp[w] = base_w[w] ^ basis_w[i][w];
        int wti = pop64_arr(tmp);
        if (wti & 7) return -2;
        c1[i] = ((wti >> 3) & 1) ^ c0;
        if (c1[i]) toggle_bit(out_row, off1 + i);
    }

    /* Precompute c2[i][j] for all active pairs */
    static uint8_t c2[111][111];
    memset(c2, 0, sizeof(c2));
    uint64_t xij[64];
    for (int i = 0; i < n; i++) {
        if (!is_active[i]) continue;
        int b2_i = col2_base[i];
        for (int j = i + 1; j < n; j++) {
            if (!is_active[j]) continue;
            for (int w = 0; w < 64; w++) xij[w] = base_w[w] ^ basis_w[i][w] ^ basis_w[j][w];
            int wtij = pop64_arr(xij);
            if (wtij & 7) return -3;
            int cij = ((wtij >> 3) & 1) ^ c0 ^ c1[i] ^ c1[j];
            c2[i][j] = (uint8_t)cij;
            if (cij) toggle_bit(out_row, off2 + b2_i + (j - i - 1));
        }
    }

    /* Cubic c_{i,j,k} = ((wt(b0 ^ bi ^ bj ^ bk) >> 3) & 1) ^ c0 ^ ci ^ cj ^ ck ^ cij ^ cik ^ cjk */
    for (int i = 0; i < n; i++) {
        if (!is_active[i]) continue;
        for (int j = i + 1; j < n; j++) {
            if (!is_active[j]) continue;
            for (int w = 0; w < 64; w++) xij[w] = base_w[w] ^ basis_w[i][w] ^ basis_w[j][w];
            int c3_ij = col3_base[i * n + j];
            int base_par = c0 ^ c1[i] ^ c1[j] ^ c2[i][j];
            for (int k = j + 1; k < n; k++) {
                if (!is_active[k]) continue;
                int wtk = 0;
                const uint64_t *bk = basis_w[k];
                for (int w = 0; w < 64; w++) wtk += __builtin_popcountll(xij[w] ^ bk[w]);
                if (wtk & 7) return -4;
                int cijk = ((wtk >> 3) & 1) ^ base_par ^ c1[k] ^ c2[i][k] ^ c2[j][k];
                if (cijk) toggle_bit(out_row, c3_ij + (k - j - 1));
            }
        }
    }

    for (int r = 0; r < R_ver; r++) {
        memcpy(tmp, base_w, sizeof(tmp));
        uint64_t lo = ver_lo[r], hi = ver_hi[r];
        while (lo) {
            int i = __builtin_ctzll(lo); lo &= lo - 1;
            for (int w = 0; w < 64; w++) tmp[w] ^= basis_w[i][w];
        }
        while (hi) {
            int i = 64 + __builtin_ctzll(hi); hi &= hi - 1;
            for (int w = 0; w < 64; w++) tmp[w] ^= basis_w[i][w];
        }
        out_verify_wts[r] = pop64_arr(tmp);
    }
    return 0;
}
"""


def gf2_rank_insert(piv, vec):
    v = vec
    while v:
        b = v.bit_length() - 1
        if b in piv: v ^= piv[b]
        else: piv[b] = v; return True
    return False


def subspace_points_from_dual_basis(dual_vecs, shift=0):
    d0, d1, d2, d3 = dual_vecs
    X = np.arange(65536, dtype=np.uint32)
    def par(v):
        t = X & np.uint32(v)
        t ^= t >> 8; t ^= t >> 4; t ^= t >> 2; t ^= t >> 1
        return t & 1
    mask = (par(d0) == 0) & (par(d1) == 0) & (par(d2) == 0) & (par(d3) == 0)
    return (X[mask] ^ np.uint32(shift)).astype(np.uint16)


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_b3, orbits, layer_vecs, orb_tt_np,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, n_sub=120):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 32A: V_12 SUPERSET D_8 BIT-3 CUBICS (n_sub={n_sub}) ====================", flush=True)
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
    total_base = n_base + len(cyc_cubs) + n_cg
    base_buf = (ctypes.c_uint64 * (total_base * n_cw))()
    ctypes.memmove(base_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, base_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(base_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root0 = s9.run_branch_cascade(lib9, base_buf, [], list(range(total_base)), {}, [], tbl, max_xl_rounds=15, verify_subst=False)
    lin_pivs = root0["_lin_pivs"]
    print(f"  [{cell_name}] Baseline root: N_act={111 - len(lin_pivs)}, q={len(root0['_quad_ids'])}, cub={len(root0['_cub_ids'])}", flush=True)

    # Fold root0["_lin_pivs"] into origin_root & cb_root so we extract directly on the root affine subspace!
    orig_mask = origin111
    for lp, (_, prhs) in lin_pivs.items():
        if prhs: orig_mask ^= cb111[lp]
    is_act = np.zeros(111, dtype=np.uint8)
    cb_root_masks = [0] * 111
    for i in range(111):
        if i in lin_pivs: continue
        is_act[i] = 1
        m = cb111[i]
        for lp, (pmask, _) in lin_pivs.items():
            if (pmask >> i) & 1:
                m ^= cb111[lp]
        cb_root_masks[i] = m

    orb_tt_flat = np.ascontiguousarray(orb_tt_np.reshape(-1), dtype=np.uint8)
    orig_u8 = np.array([(orig_mask >> o) & 1 for o in range(116)], dtype=np.uint8)
    cb_u8 = np.array([(cb_root_masks[i] >> o) & 1 for i in range(111) for o in range(116)], dtype=np.uint8)

    # Generate n_sub 12-dim subspaces V_12 SUPERSET D_8 (4 linearly independent dual vectors in D_8^perp!)
    d8p_basis = [(1 << i) | (1 << (i + 8)) for i in range(8)]
    rng_v = random.Random(323232)
    v12_specs = [("D8sup_0123", [d8p_basis[0], d8p_basis[1], d8p_basis[2], d8p_basis[3]], 0)]
    while len(v12_specs) < n_sub:
        ds = []
        piv4 = {}
        while len(ds) < 4:
            mask8 = rng_v.randrange(1, 256)
            v16 = 0
            for b in range(8):
                if (mask8 >> b) & 1: v16 ^= d8p_basis[b]
            if gf2_rank_insert(piv4, v16):
                ds.append(v16)
        sh = 0 if (len(v12_specs) % 2 == 0) else rng_v.randrange(1, 65536)
        v12_specs.append((f"D8sup_{len(v12_specs):03d}", ds, sh))

    R_ver = 20
    rng_ver = random.Random(320032)
    ver_pts = []
    for _ in range(R_ver):
        x = 0
        for i in range(111):
            if is_act[i] and rng_ver.getrandbits(1): x |= (1 << i)
        ver_pts.append(x)
    ver_lo = (ctypes.c_uint64 * R_ver)(*[x & mask64 for x in ver_pts])
    ver_hi = (ctypes.c_uint64 * R_ver)(*[x >> 64 for x in ver_pts])
    out_vw = (ctypes.c_int * R_ver)()

    b3_buf = (ctypes.c_uint64 * (n_sub * n_cw))()
    n_ok, n_fail_mod8, zt_mis = 0, 0, 0
    t_ext = time.perf_counter()
    for idx_v, (vname, ds, sh) in enumerate(v12_specs):
        pts = subspace_points_from_dual_basis(ds, sh)
        rptr = ctypes.cast(ctypes.byref(b3_buf, n_ok * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        rv = R_ver if n_ok < 20 else 0
        rc = lib_b3.extract_v12_bit3_cubic_row(
            orb_tt_flat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            orig_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            cb_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            is_act.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            pts.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
            tbl["col2_base"], tbl["col3_base"], rptr, out_vw, ver_lo, ver_hi, rv
        )
        if rc != 0:
            n_fail_mod8 += 1
            continue
        if rv > 0:
            eq_mis = 0
            for p_i in range(rv):
                v_truth = (out_vw[p_i] >> 3) & 1
                v_poly = lib9.eval_row_s9(
                    rptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    ver_lo[p_i], ver_hi[p_i]
                )
                if v_truth != v_poly: eq_mis += 1
            if eq_mis > 0:
                zt_mis += eq_mis
                # Skip if degree > 3!
                continue
        n_ok += 1
    print(
        f"  [{cell_name}] V_12 superset D_8 Bit-3 extraction ({time.perf_counter()-t_ext:.1f}s): "
        f"deg<=3 exact = {n_ok}/{n_sub}, fail_mod8 = {n_fail_mod8}, deg>3_mismatches = {zt_mis}",
        flush=True,
    )
    if n_ok == 0:
        return

    # Inject all n_ok verified Bit-3 cubics into root0 and run cascade!
    r0_eqs = list(root0["_quad_ids"]) + list(root0["_cub_ids"])
    tot_new = len(r0_eqs) + n_ok
    comb_buf = (ctypes.c_uint64 * (tot_new * n_cw))()
    for i, rid in enumerate(r0_eqs):
        ctypes.memmove(ctypes.byref(comb_buf, i * n_cw * 8), ctypes.byref(root0["_buf"], rid * n_cw * 8), n_cw * 8)
    ctypes.memmove(ctypes.byref(comb_buf, len(r0_eqs) * n_cw * 8), b3_buf, n_ok * n_cw * 8)

    root1 = s9.run_branch_cascade(
        lib9, comb_buf, [], list(range(tot_new)), dict(lin_pivs), [], tbl, max_xl_rounds=25, verify_subst=True
    )
    if root1["closed_unsat"]:
        print(f"  [{cell_name}] *** BOOM!! ROOT CLOSED UNSAT (1 = 0) WITH +{n_ok} V_12>=D_8 BIT-3 CUBICS!! ***", flush=True)
        return
    print(
        f"  [{cell_name}] AFTER +{n_ok} V_12>=D_8 BIT-3 CUBICS: N_act={111-len(root1['_lin_pivs'])}, "
        f"q={len(root1['_quad_ids'])}, cub={len(root1['_cub_ids'])} (was cub={len(root0['_cub_ids'])})",
        flush=True,
    )

    # Sweep all 64 eta-states!
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root1["_lin_pivs"])
    n_ef = len(eta_free)
    n_cl = 0
    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root1["_buf"], root1["_quad_ids"], root1["_cub_ids"], root1["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=(em == 0)
        )
        if sr["closed_unsat"]: n_cl += 1
    print(f"  [{cell_name}] ETA SWEEP WITH V_12>=D_8 BIT-3: CLOSED = {n_cl} / {1<<n_ef} ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11,B0_00")
    parser.add_argument("--n_sub", type=int, default=120)
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s32a_diag.c", WORK_DIR / "libs32a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s32a_s9.c", WORK_DIR / "libs32a_s9.so"
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
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s32a_cg.c", WORK_DIR / "libs32a_cg.so"
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

    c_b3, so_b3 = WORK_DIR / "s32a_b3.c", WORK_DIR / "libs32a_b3.so"
    c_b3.write_text(C_V12_B3_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_b3), "-o", str(so_b3)], check=True)
    lib_b3 = ctypes.CDLL(str(so_b3))
    lib_b3.extract_v12_bit3_cubic_row.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
    ]
    lib_b3.extract_v12_bit3_cubic_row.restype = ctypes.c_int

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

    for cell in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cell, lib_diag, lib9, lib_cg, lib_b3, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, n_sub=args.n_sub
        )


if __name__ == "__main__":
    main()
