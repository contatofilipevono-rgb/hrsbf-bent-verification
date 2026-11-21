#!/usr/bin/env python3
r"""
SOLVE_STEP56B_FULL405_MINRANK_AND_SAT.py

THREE CRITICAL TESTS ON THE FULL 405-EQUATION IDEAL OF B0_11 & B1_11:
  1. FULL (drf, dt_c, lead_d) CENSUS OF `std_ech` AFTER FIXING `eta`:
     In Step 45B..56A, `extract_eta_exact_system` ONLY kept `M1_strict` (63..89 rows with
     drf==1, dt_c==0, deg_W<=1) and discarded ~300 of the 388 cubic equations!
     We count how many equations lie in every (drf, dt_c) bucket, and how many TOTAL
     equations become linear in R_F (drf==1, degree <= 2 in W) once T = Q(W) is substituted!
  2. FULL-405 `s9.run_branch_cascade` ON MINRANK COMPLEMENT FIBERS `T_1 W = t_1`:
     For nt1 in [6, 8, 10, 12, 14, 16, 18, 20, 22, 24]:
     Adds the `nt1` linear equations `T_1 W = t_1` (from the MinRank basis of Mk_c!)
     directly into the FULL 405-equation system (`sr["_buf"]`) and runs `s9.run_branch_cascade`
     (full degree-3 XL in C across ALL 405 equations, not just the 71 bilinear ones!)
     on t_1 = 0 and 3 random non-zero fibers t_1 != 0!
     Checks at which `nt1` the FULL 405-equation XL cascade closes directly to `1 = 0`
     (`closed_unsat = True`) or drops N / cubics!
  3. HYBRID `s9` + CaDiCaL SAT SOLVER BENCHMARK:
     Converts the residual cubic/quadratic system after `s9` on a fiber into CNF (via ANF
     monomial encoding + XOR clauses) and benchmarks CaDiCaL (`pysat`) solve time!
"""

import argparse
import ctypes
import subprocess
import sys
import time
from pathlib import Path
import numpy as np
from pysat.solvers import Solver

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


def add_xor_clauses(solver, lits, rhs):
    """Add exact XOR constraint (x_0 ^ x_1 ^ ... == rhs) to PySAT solver using chunks of <= 4."""
    cur = list(lits)
    r = rhs & 1
    if not cur:
        if r == 1:
            solver.add_clause([1])
            solver.add_clause([-1])
        return
    while len(cur) > 4:
        chunk = cur[:3]
        aux = solver.nof_vars() + 1
        # aux == chunk[0] ^ chunk[1] ^ chunk[2]
        for mask in range(16):
            b0, b1, b2, ba = (mask & 1), (mask >> 1) & 1, (mask >> 2) & 1, (mask >> 3) & 1
            if (b0 ^ b1 ^ b2 ^ ba) == 1:
                solver.add_clause([
                    -chunk[0] if b0 else chunk[0],
                    -chunk[1] if b1 else chunk[1],
                    -chunk[2] if b2 else chunk[2],
                    -aux if ba else aux,
                ])
        cur = [aux] + cur[3:]
    k = len(cur)
    for mask in range(1 << k):
        parity = bin(mask).count("1") & 1
        if parity != r:
            clause = [(-cur[i] if ((mask >> i) & 1) else cur[i]) for i in range(k)]
            solver.add_clause(clause)


def solve_residual_with_cadical(sr_res, tbl, conflict_budget=50000):
    """
    Encode the residual quadratic + cubic system in `sr_res` into CaDiCaL195 and solve.
    Returns (is_sat, elapsed_sec, n_vars, n_clauses).
    """
    t0 = time.perf_counter()
    n = tbl["n"]
    q_ids = sr_res.get("_quad_ids", [])
    c_ids = sr_res.get("_cub_ids", [])
    all_ids = list(q_ids) + list(c_ids)
    psets = [s9.row_to_pset(sr_res["_buf"], rid, tbl) for rid in all_ids]

    # Map active variables and degree-2 / degree-3 monomials to SAT variables
    var_map = {}
    mon_map = {}
    next_v = 1

    for ps in psets:
        for m in ps:
            if m == 0:
                continue
            vs = [b for b in range(n) if (m >> b) & 1]
            for v in vs:
                if v not in var_map:
                    var_map[v] = next_v
                    next_v += 1
            if len(vs) >= 2 and m not in mon_map:
                mon_map[m] = (next_v, [var_map[v] for v in vs])
                next_v += 1

    with Solver(name="cadical195") as slv:
        # Touch highest var
        if next_v > 1:
            slv.add_clause([next_v - 1, -(next_v - 1)])
        # Add AND definitions for monomials: m_var <=> AND(v_lits)
        for m, (m_var, v_lits) in mon_map.items():
            for vl in v_lits:
                slv.add_clause([-m_var, vl])
            slv.add_clause([m_var] + [-vl for vl in v_lits])
        # Add XOR equation for each polynomial
        for ps in psets:
            rhs = 1 if (0 in ps) else 0
            lits = []
            for m in ps:
                if m == 0:
                    continue
                if m.bit_count() == 1:
                    v = m.bit_length() - 1
                    lits.append(var_map[v])
                else:
                    lits.append(mon_map[m][0])
            add_xor_clauses(slv, lits, rhs)
        slv.conf_budget(conflict_budget)
        res = slv.solve_limited()
        return res, time.perf_counter() - t0, slv.nof_vars(), slv.nof_clauses()


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 56B: FULL-405 IDEAL CENSUS + MINRANK-XL + SAT ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s56b_diag.c", WORK_DIR / "libs56b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s56b_s9.c", WORK_DIR / "libs56b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s56b_cg.c", WORK_DIR / "libs56b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s56b_sh.c", WORK_DIR / "libs56b_sh.so"
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
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1
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

    rng = np.random.default_rng(5622)
    etas = [5, 0] if cell_name == "B0_11" else [0, 1]

    for em in etas:
        n_ef = len(eta_free)
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=False
        )
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        W_pivs = sorted(W_rref.keys())
        W_set = set(W_pivs)
        active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
        R_vars = [v for v in active_now if v not in W_set]
        R_set = set(R_vars)

        eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
        M_eq = len(eq_ids)
        work = (ctypes.c_uint64 * (M_eq * n_cw))()
        for i, rid in enumerate(eq_ids):
            ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
        for p in W_pivs:
            rest = W_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )
        n_q = len(sr["_quad_ids"])
        tail_forms = []
        for qi in range(n_q):
            qps_sh = s9.row_to_pset(work, qi, tbl)
            rmask = 0
            for m in qps_sh:
                if m.bit_count() == 1:
                    v = m.bit_length() - 1
                    if v in R_set:
                        rmask |= (1 << v)
            if rmask:
                tail_forms.append(rmask)
        T_rref = s19.strict_rref_masks(tail_forms)
        T_pivs = sorted(T_rref.keys())
        T_set = set(T_pivs)
        RF_vars = [v for v in R_vars if v not in T_set]
        RF_set = set(RF_vars)
        for p in T_pivs:
            rest = T_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )

        # PART 1: Full (drf, dt_c, lead_d) census of std_ech
        col_keys, col_meta = [], []
        for c in range(n_cols):
            d = int(tbl["col_deg"][c])
            vs = []
            if d >= 1: vs.append(int(tbl["col_v0"][c]))
            if d >= 2: vs.append(int(tbl["col_v1"][c]))
            if d >= 3: vs.append(int(tbl["col_v2"][c]))
            drf = sum(1 for v in vs if v in RF_set)
            dt_c = sum(1 for v in vs if v in T_set)
            col_meta.append((drf, dt_c, d))
            col_keys.append((3 - drf, 3 - dt_c, 3 - d, c))
        col_keys.sort()
        orig_to_perm = (ctypes.c_int * n_cols)()
        perm_to_orig = [0] * n_cols
        for pc, (_, _, _, oc) in enumerate(col_keys):
            orig_to_perm[oc] = pc
            perm_to_orig[pc] = oc
        perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
        lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        ech_rows = []
        bucket_hist = {}
        for r in range(M_eq):
            pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
            if pc >= 0:
                meta = col_meta[perm_to_orig[pc]]
                ech_rows.append((r, meta))
                bucket_hist[meta] = bucket_hist.get(meta, 0) + 1

        print(f"\n  === [{cell_name} eta={em}] PART 1: FULL {len(ech_rows)}-EQUATION CENSUS (drf, dt_c, deg) ===", flush=True)
        for k_meta, cnt in sorted(bucket_hist.items()):
            print(f"    (drf={k_meta[0]}, dt_c={k_meta[1]}, deg={k_meta[2]}): {cnt:3d} eqs", flush=True)

        # PART 2: Full-405 `s9.run_branch_cascade` when adding `nt1` MinRank-complement linear forms T_1
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5600 + em)
        nW = sys_ex["nW"]
        Mk_c = sys_ex["Mk_c"]
        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5620 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        # Note: sheared W variable k corresponds to linear form `W_rref[W_pivs[k]]` in original 111-var space!
        # Let's verify: in `work`, variable `p = W_pivs[k]` was sheared by replacing `p` with `W_rref[p]`,
        # which means `w_k` in the sheared system IS the linear form `W_rref[W_pivs[k]]` in the unsheared `sr["_buf"]`!
        W_forms_111 = [W_rref[p] for p in W_pivs]

        print(f"\n  === [{cell_name} eta={em}] PART 2: FULL-405 s9 XL CASCADE ON MINRANK T1 FIBERS ===", flush=True)
        base_sr_rows = len(sr["_quad_ids"]) + len(sr["_cub_ids"])
        for nt1 in [8, 12, 14, 16, 18, 20, 22, 24]:
            d1 = nW - nt1
            T1 = U_full[d1:]  # (nt1, nW)
            # Each row j of T1 defines a linear form in 111-var space: XOR_{k : T1[j,k]==1} W_forms_111[k]
            t1_forms_111 = []
            for j in range(nt1):
                fm = 0
                for k in range(nW):
                    if T1[j, k]:
                        fm ^= W_forms_111[k]
                t1_forms_111.append(fm)

            # Test fiber 0 (t1=0) and fiber 1 (random t1!=0)
            f_logs = []
            for f_i in range(2):
                rhs_bits = [0] * nt1 if f_i == 0 else [int(rng.integers(0, 2)) for _ in range(nt1)]
                # Build linear psets for T1 W = rhs_bits and append to sr["_buf"]
                tot_r = base_sr_rows + nt1
                buf_f = (ctypes.c_uint64 * (tot_r * n_cw))()
                for idx_r, rid in enumerate(list(sr["_quad_ids"]) + list(sr["_cub_ids"])):
                    ctypes.memmove(ctypes.byref(buf_f, idx_r * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
                for j in range(nt1):
                    ps_lin = {1 << b for b in range(n) if (t1_forms_111[j] >> b) & 1}
                    if rhs_bits[j]:
                        ps_lin.add(0)
                    s9.pset_to_row(ps_lin, buf_f, base_sr_rows + j, tbl)

                q_ids_f = list(range(len(sr["_quad_ids"]))) + list(range(base_sr_rows, tot_r))
                c_ids_f = list(range(len(sr["_quad_ids"]), base_sr_rows))
                t_c = time.perf_counter()
                res_f = s9.run_branch_cascade(
                    lib9, buf_f, q_ids_f, c_ids_f, dict(sr["_lin_pivs"]),
                    [], tbl, max_xl_rounds=25, verify_subst=False
                )
                dt_c = time.perf_counter() - t_c
                if res_f.get("closed_unsat"):
                    f_logs.append(f"f{f_i}:CLOSED_UNSAT(r={res_f.get('rounds')},{dt_c:.2f}s)")
                elif "N_active" in res_f:
                    s_str = f"f{f_i}:N={res_f['N_active']},q={res_f['n_quad_surviving']},c={res_f['n_genuine_cubics']}({dt_c:.2f}s)"
                    # Run CaDiCaL with 50k conflict budget if N_active <= 55
                    if f_i == 0 and res_f["N_active"] <= 55:
                        sat_r, sat_t, nv_s, nc_s = solve_residual_with_cadical(res_f, tbl, conflict_budget=50000)
                        s_str += f"[SAT:{sat_r},{sat_t:.2f}s]"
                    f_logs.append(s_str)
                else:
                    f_logs.append(f"f{f_i}:{res_f.get('note')}({dt_c:.2f}s)")
            print(f"    nt1={nt1:2d}(d1={d1:2d}): " + " | ".join(f_logs), flush=True)

    print(f"\n[{cell_name}] STEP 56B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
