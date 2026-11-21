#!/usr/bin/env python3
r"""
SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT.py

TWO HIGH-LEVERAGE TESTS TO MINIMIZE NT1 (MAXIMIZE d1 WITH final_rK == 0) ON B0_11 & B1_11:
  1. GREEDY (dim(K_R) + dim(V_0))-OPTIMIZED SUBSPACE U_1 SEARCH:
     Previously, `U_full` was built by `s44a.minrank_basis` with 1 fixed seed, which only orders
     individual basis vectors by matrix rank without optimizing the *joint* common kernels
     K_R(U_1) = nullspace(vstack(Mu1)) and V_0(U_1) = nullspace(hstack(Mu1).T)!
     Here we:
       - Try 24 seeds/parameter combinations of `minrank_basis`, AND
       - Run a greedy hill-climber (swapping basis vectors between U_1 and T_1) that directly
         MAXIMIZES `2 * dim(V_0(U_1)) + dim(K_R(U_1))` (and `r_elim_KR + r_elim_V0` in Round 1)!
       - Run `run_cascade_uncapped` on the optimized U_1 across d1 = 18..30 (B0_11) and
         d1 = 16..24 (B1_11) to find the new MINIMUM `NT1` that achieves `final_rK = 0`!
  2. BLOCK B (`(drf=2, dt_c=0, deg=2)`) ANATOMY ON ROOT K_R & CROSS-TERM KERNEL `left_nullspace([A_tilde | H])`:
     - Checks how many non-zero columns of `A_rf2` touch the 11 root-K_R variables vs the 29 core variables.
     - Computes `left_nullspace([A_tilde | H])` (where BOTH quadratic `r_a r_b` AND cross-terms `d_p(u_1) r_a`
       cancel identically!), and injects any resulting strictly-bilinear rows into `(M0, Mk)`!
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
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b


def round1_elim_score(M0_c, Mu_list):
    """
    Fast score for a d1-dimensional basis Mu_list:
    Returns (total_r1_elim, dim_KR, dim_V0, rK_after_r1).
    """
    mR, rK = M0_c.shape
    KR = s40a.gf2_nullspace_np(np.vstack(Mu_list))
    d_kr = KR.shape[0]
    if d_kr > 0:
        M0_KR = (M0_c @ KR.T) & 1
        L_kr = s40a.gf2_nullspace_np(M0_KR.T)
        _, kr_pivs = s40a.gf2_rref_np(KR)
        kr_set = set(kr_pivs)
        keep_c = [c for c in range(rK) if c not in kr_set]
        M0_1 = (L_kr @ M0_c[:, keep_c]) & 1
        Mu_1 = [(L_kr @ M[:, keep_c]) & 1 for M in Mu_list]
    else:
        M0_1 = M0_c
        Mu_1 = Mu_list
    if M0_1.shape[1] == 0:
        return rK, d_kr, mR, 0
    V0 = s40a.gf2_nullspace_np(np.hstack(Mu_1).T)
    d_v0 = V0.shape[0]
    if d_v0 > 0:
        V0_M0 = (V0 @ M0_1) & 1
        _, piv_v0 = s40a.gf2_rref_np(V0_M0)
        e_v0 = len(piv_v0)
    else:
        e_v0 = 0
    rK_rem = M0_1.shape[1] - e_v0
    tot_elim = rK - rK_rem
    return tot_elim, d_kr, d_v0, rK_rem


def optimize_u1_basis(M0_c, Mk_c, d1, em_seed=0):
    """
    1. Searches over 16 minrank_basis seeds/configs to find the best initial d1-subspace.
    2. Applies greedy 1-swap local search (swapping u_i in U1 with t_j in T1) to maximize
       (tot_elim, d_v0, d_kr).
    """
    nW = len(Mk_c)
    best_U = None
    best_key = (-1, -1, -1)

    for s_idx in range(16):
        rk_cap = 20 if (s_idx % 3 == 0) else (24 if (s_idx % 3 == 1) else 28)
        n_rds = 2 + (s_idx % 3)
        _, full_bas, _ = s44a.minrank_basis(Mk_c, rk_cap=rk_cap, n_rounds=n_rds, seed=5700 + 37 * s_idx + em_seed)
        U_cand = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_cand[a, k] = 1
        Mu = [np.zeros_like(M0_c) for _ in range(d1)]
        for a in range(d1):
            for k in range(nW):
                if U_cand[a, k]:
                    Mu[a] ^= Mk_c[k]
        tot_e, d_kr, d_v0, _ = round1_elim_score(M0_c, Mu)
        key = (tot_e, d_v0, d_kr)
        if key > best_key:
            best_key = key
            best_U = U_cand.copy()

    # Precompute all nW matrices for best_U rows
    M_all = [np.zeros_like(M0_c) for _ in range(nW)]
    for a in range(nW):
        for k in range(nW):
            if best_U[a, k]:
                M_all[a] ^= Mk_c[k]

    # Greedy swap loop (up to 2 passes)
    for _pass in range(2):
        improved = False
        for i in range(d1 - 1, -1, -1):
            for j in range(d1, nW):
                # Try swapping i and j
                M_all[i], M_all[j] = M_all[j], M_all[i]
                tot_e, d_kr, d_v0, _ = round1_elim_score(M0_c, M_all[:d1])
                key = (tot_e, d_v0, d_kr)
                if key > best_key:
                    best_key = key
                    best_U[[i, j]] = best_U[[j, i]]
                    improved = True
                    break
                else:
                    M_all[i], M_all[j] = M_all[j], M_all[i]
        if not improved:
            break

    return best_U, M_all[:d1], best_key


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 57B: GREEDY (KR+V0) BASIS OPTIMIZER & BLOCK-B CROSS-KERNEL ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s57b_diag.c", WORK_DIR / "libs57b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s57b_s9.c", WORK_DIR / "libs57b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s57b_cg.c", WORK_DIR / "libs57b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s57b_sh.c", WORK_DIR / "libs57b_sh.so"
    c_sh.write_text(s17.C_SHEAR_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_sh), "-o", str(so_sh)], check=True)
    lib_sh = ctypes.CDLL(str(so_sh))
    lib_sh.shear_subst_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib_sh.remap_rows_by_perm.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
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
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
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
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    etas = [5, 12, 0, 1] if cell_name == "B0_11" else [0, 1, 4, 5]
    for em in etas:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5700 + em)
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        print(f"\n  === [{cell_name} eta={em}] GREEDY (KR+V0) BASIS OPTIMIZATION (nW={nW}, mR={M0_c.shape[0]}, rK={M0_c.shape[1]}) ===", flush=True)

        d1_list = [20, 22, 24, 25, 26, 27, 28] if cell_name == "B0_11" else [16, 17, 18, 19, 20, 22]
        for d1 in d1_list:
            t_d = time.perf_counter()
            _, Mu_opt, best_key = optimize_u1_basis(M0_c, Mk_c, d1, em_seed=em)
            rK_f, lg = s55b.run_cascade_uncapped(M0_c, Mu_opt, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
            print(
                f"    d1={d1:2d}(NT1={nW-d1:2d}) [r1_elim={best_key[0]:2d}, V0={best_key[1]:2d}, KR={best_key[2]:2d}]: "
                f"final_rK={rK_f:2d} ({time.perf_counter()-t_d:4.1f}s) | {' ; '.join(lg)}",
                flush=True,
            )

    print(f"\n[{cell_name}] STEP 57B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
