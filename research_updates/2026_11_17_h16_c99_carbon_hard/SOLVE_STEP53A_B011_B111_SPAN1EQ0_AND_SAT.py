#!/usr/bin/env python3
r"""
SOLVE_STEP53A_B011_B111_SPAN1EQ0_AND_SAT.py

TESTS TWO BREAKTHROUGH HYPOTHESES ON B0_11 & B1_11 FIBERS:
  1. LINEAR-SPAN `1 = 0` TEST:
     Checks whether the all-ones vector 1 is in the F_2-linear span of the pure-u_1
     equations P_all (i.e. rank([P_all, 1]) == rank(P_all)) on t_1 = 0 AND random
     non-zero fibers t_1 != 0!
     If YES, then EVERY fiber collapses to a literal `1 = 0` contradiction via pure
     F_2 linear algebra (NO search over u_1 needed at all!).
  2. EXACT ANF + SAT (CaDiCaL) DEGREE-3 FIBER CLOSURE BENCHMARK:
     On d1 = 16 (and d1 = 24), extracts the exact ANF monomials of degree <= 3
     (or checks linear combinations that drop degree to <= 2!), and benchmarks
     how fast CaDiCaL proves UNSAT on a fiber!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b
import SOLVE_STEP52B_B011_B111_FIBER_AND_SAT_PROBE as s52b


def span_contains_ones(P_mat):
    """Return (rank_P, has_1_in_span) for P_mat of shape (n_samples, n_eqs)."""
    _, pivs0 = s40a.gf2_rref_np(P_mat.T)
    rk0 = len(pivs0)
    ones = np.ones((1, P_mat.shape[0]), dtype=np.uint8)
    _, pivs1 = s40a.gf2_rref_np(np.vstack([P_mat.T, ones]))
    rk1 = len(pivs1)
    return rk0, (rk1 == rk0)


def check_low_degree_in_span_16(P_65536):
    """
    Apply 16-var Fast Mobius Transform to every column of P_65536 (65536, m),
    then RREF the ANF matrix ordered by decreasing monomial degree to find:
      - whether constant 1 (monomial 0) is in the span (`1 = 0`!)
      - how many linearly independent deg<=1, deg<=2, deg<=3 equations are in the span!
    """
    m = P_65536.shape[1]
    A = P_65536.copy()
    for b in range(16):
        step = 1 << b
        A = A.reshape(-1, 2, step, m)
        A[:, 1, :, :] ^= A[:, 0, :, :]
        A = A.reshape(65536, m)
    # Only keep non-zero rows (monomials that appear in at least one equation)
    nz_mons = np.flatnonzero(A.any(axis=1))
    degs = s52b.POP16[nz_mons]
    # Sort monomials by DECREASING degree (so RREF eliminates highest-degree monomials first!)
    order = np.argsort(-degs, kind="stable")
    mons_sorted = nz_mons[order]
    degs_sorted = degs[order]
    M = A[mons_sorted, :].T.copy()  # (m, n_nz_mons)
    R, pivs = s40a.gf2_rref_np(M)
    # Each non-zero row r of R has leading (highest-degree!) monomial mons_sorted[pivs[r]]
    lead_degs = [int(degs_sorted[p]) for p in pivs]
    hist = {}
    for d in lead_degs:
        hist[d] = hist.get(d, 0) + 1
    has_1eq0 = (0 in lead_degs)
    return len(pivs), has_1eq0, sorted(hist.items())


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 53A: LINEAR-SPAN 1=0 & LOW-DEGREE ANF REDUCTION ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s53a_diag.c", WORK_DIR / "libs53a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s53a_s9.c", WORK_DIR / "libs53a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s53a_cg.c", WORK_DIR / "libs53a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s53a_sh.c", WORK_DIR / "libs53a_sh.so"
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
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    U16_all = np.zeros((65536, 16), dtype=np.uint8)
    idx16 = np.arange(65536, dtype=np.uint32)
    for b in range(16):
        U16_all[:, b] = (idx16 >> b) & 1

    test_cases = [(5, [24, 16]), (12, [16]), (0, [16])] if cell_name == "B0_11" else [(0, [16]), (1, [16])]
    rng = np.random.default_rng(5399)

    for em, d1_list in test_cases:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5300 + em)
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        L_core_T = sys_ex["L_core"].T.copy()

        def eval_bc(W_mat, _fn=sys_ex["eval_b_and_p0_batch"], _Lt=L_core_T):
            b_orig, _ = _fn(W_mat)
            return (b_orig @ _Lt) & 1

        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5320 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        for d1 in d1_list:
            U1 = U_full[:d1]
            T1 = U_full[d1:]
            nt1 = nW - d1
            Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
            for a in range(d1):
                for k in range(nW):
                    if U1[a, k]:
                        Mu1[a] ^= Mk_c[k]

            print(f"\n  === [{cell_name} eta={em} d1={d1}(NT1={nt1})] Linear-Span 1=0 & Reduced-ANF Check ===", flush=True)
            for f_idx in range(3):
                w_shift = np.zeros(nW, dtype=np.uint8) if f_idx == 0 else ((rng.integers(0, 2, size=nt1, dtype=np.uint8) @ T1) & 1)
                M0_f = M0_c.copy()
                for k in range(nW):
                    if w_shift[k]:
                        M0_f ^= Mk_c[k]

                def make_eb_f(U1_in, ws_in, eb_in):
                    def _fn(U_mat):
                        W_mat = ((U_mat @ U1_in) ^ ws_in[None, :]) & 1
                        return eb_in(W_mat)
                    return _fn

                rK_f, pure_fns = s52b.run_cascade_return_pure(M0_f, Mu1, make_eb_f(U1, w_shift, eval_bc), lib9, max_rounds=8)
                if rK_f != 0:
                    print(f"    fiber {f_idx}: rK={rK_f} (not 0)", flush=True)
                    continue
                if d1 == 16:
                    P_all = np.hstack([fn(U16_all) for fn in pure_fns])
                    rk, has_1eq0, red_degs = check_low_degree_in_span_16(P_all)
                    print(
                        f"    fiber {f_idx}: rK=0, eqs={P_all.shape[1]}, indep_rk={rk}, "
                        f"SPAN_HAS_1EQ0={has_1eq0}, REDUCED_ANF_DEGS={red_degs}",
                        flush=True,
                    )
                else:
                    U_samp = rng.integers(0, 2, size=(2048, d1), dtype=np.uint8)
                    P_s = np.hstack([fn(U_samp) for fn in pure_fns])
                    rk, has_1eq0 = span_contains_ones(P_s)
                    print(
                        f"    fiber {f_idx}: rK=0, eqs={P_s.shape[1]}, sample_rk={rk}, "
                        f"SPAN_HAS_1EQ0_ON_2048={has_1eq0}",
                        flush=True,
                    )

    print(f"\n[{cell_name}] STEP 53A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
