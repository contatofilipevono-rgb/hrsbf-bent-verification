#!/usr/bin/env python3
r"""
SOLVE_STEP59C_ALGEBRAIC_389_AND_BLOCKB.py

PRIORITY 1 PURE-ALGEBRAIC CLOSURE PROBE FOR B0_11 & B1_11:
  1. Complete (drf, dt_c, deg) equation census across both normal orbits (eta=0, 5 / 0, 3)
     AND the "M1_strict-broken" orbits (B0_11 eta=9, 11; B1_11 eta=8, 10) to reveal where
     the missing 30..64 M1_strict rows went (e.g., pure-(W,T) drf=0 cubics or dt_c=1 / drf=2!).
  2. Revived Full-389 `s9.run_branch_cascade` with FIXED dual-basis annihilator
     `F_sub = gf2_nullspace_np(U_opt[:d_free])` passed via `extra_lin_eqs` (fixing Step 56B's T_1 bug!),
     combined with Step 57B's (KR+V0)-optimized `U_opt` basis + CaDiCaL (`Cadical195`) SAT solving
     on any shattered residual (`N_active <= 80`)!
  3. Fiber-Linearized Full-DRF1 Pencil (`Block A` + `Block A3` `w_a w_b r_j` linearized on fiber)
     + Exact Pointwise / Fiber `Block B + Block C + Block D` Rank-Collapse Audit!
"""

import argparse
import ctypes
import subprocess
import sys
import time
from pathlib import Path
import numpy as np
from pysat.solvers import Cadical195

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_STRICT_RREF_N42 as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


def solve_residual_with_cadical(buf, q_ids, c_ids, tbl, max_conf_budget=500000):
    """Encode surviving quadratic & cubic ANF equations in `buf` into CaDiCaL CNF and solve!"""
    psets = [s9.row_to_pset(buf, rid, tbl) for rid in list(q_ids) + list(c_ids)]
    active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(tbl["n"]) if (m >> b) & 1})
    var_to_sat = {v: i + 1 for i, v in enumerate(active_vars)}
    next_sat_var = len(active_vars) + 1
    mon_to_sat = {}
    clauses = []

    def get_mon_var(m):
        nonlocal next_sat_var
        vs = [b for b in range(tbl["n"]) if (m >> b) & 1]
        if len(vs) == 1:
            return var_to_sat[vs[0]]
        if m not in mon_to_sat:
            mv = next_sat_var
            next_sat_var += 1
            mon_to_sat[m] = mv
            lits = [var_to_sat[v] for v in vs]
            # mv <=> AND(lits)
            for l in lits:
                clauses.append([-mv, l])
            clauses.append([mv] + [-l for l in lits])
        return mon_to_sat[m]

    def add_xor_clauses(lits, rhs):
        # Split long XOR into 3-XOR chunks with auxiliary variables
        nonlocal next_sat_var
        cur = list(lits)
        cur_rhs = rhs
        while len(cur) > 3:
            a, b = cur[0], cur[1]
            aux = next_sat_var
            next_sat_var += 1
            # aux = a ^ b
            clauses.append([-a, -b, -aux])
            clauses.append([a, b, -aux])
            clauses.append([a, -b, aux])
            clauses.append([-a, b, aux])
            cur = [aux] + cur[2:]
        k = len(cur)
        for mask in range(1 << k):
            if (mask.bit_count() & 1) != cur_rhs:
                clauses.append([(-cur[i] if ((mask >> i) & 1) else cur[i]) for i in range(k)])

    for ps in psets:
        if not ps:
            continue
        if ps == {0}:
            return "UNSAT_1EQ0", 0
        rhs = 1 ^ (1 if 0 in ps else 0)
        lits = [get_mon_var(m) for m in sorted(ps) if m > 0]
        add_xor_clauses(lits, rhs)

    t0 = time.perf_counter()
    with Cadical195(bootstrap_with=clauses) as slv:
        slv.conf_budget(max_conf_budget)
        res = slv.solve_limited()
    dt = time.perf_counter() - t0
    if res is False:
        return "CADICAL_UNSAT", dt
    elif res is True:
        return "CADICAL_SAT", dt
    else:
        return "CADICAL_BUDGET", dt


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 59C: FULL-389 U1_PERP SHATTER + BLOCK-B/D ALGEBRAIC PROBE ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s59c_diag.c", WORK_DIR / "libs59c_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s59c_s9.c", WORK_DIR / "libs59c_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s59c_cg.c", WORK_DIR / "libs59c_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s59c_sh.c", WORK_DIR / "libs59c_sh.so"
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
        for mm in orb: mon_to_orb_arr[mm] = j
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
        for mm in orb: acc ^= ((X & mm) == mm).astype(np.uint8)
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

    test_etas = [5, 0, 9, 11] if cell_name == "B0_11" else [3, 0, 8, 10]
    rng = np.random.default_rng(5930)

    for em in test_etas:
        print(f"\n  ================================ [{cell_name} eta={em}] ================================", flush=True)
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
        W_forms_111 = [W_rref[p] for p in W_pivs]
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
        nW, nT, nRF = len(W_pivs), len(T_pivs), len(RF_vars)
        for p in T_pivs:
            rest = T_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )

        # 1. Exact (drf, dt_c, deg) census of all M_eq equations!
        census = {}
        for ri in range(M_eq):
            ps = s9.row_to_pset(work, ri, tbl)
            max_drf, max_dtc, max_deg = 0, 0, 0
            for m in ps:
                if m == 0:
                    continue
                vs = [b for b in range(n) if (m >> b) & 1]
                max_deg = max(max_deg, len(vs))
                max_drf = max(max_drf, sum(1 for v in vs if v in RF_set))
                max_dtc = max(max_dtc, sum(1 for v in vs if v in T_set))
            key = (max_drf, max_dtc, max_deg)
            census[key] = census.get(key, 0) + 1
        print(f"    [Census nW={nW}, nT={nT}, nRF={nRF}, M_eq={M_eq}]: {sorted(census.items())}", flush=True)

        # 2. Extract pencil (M0_c, Mk_c) and check pencil kernel {v : sum_k v_k Mk_c == 0}
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5930 + em)
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        Mk_flat = np.array([Mk_c[k].reshape(-1) for k in range(nW)], dtype=np.uint8)
        p_ker = s40a.gf2_nullspace_np(Mk_flat.T)
        print(f"    [M1_strict] shape={M0_c.shape}, dim(ker(w -> M(w)))={p_ker.shape[0]}", flush=True)

        # 3. ENGINE 1: FIXED U1_PERP FULL-389 s9.run_branch_cascade + CaDiCaL SAT ON SHATTERED RESIDUALS!
        print(f"    --- Engine 1: Fixed U1^perp Full-389 s9 Shatter + CaDiCaL (Step 57B U_opt) ---", flush=True)
        d_cands = [22, 24, 26, 28, 30] if cell_name == "B0_11" else [18, 20, 22, 24, 26]
        for d_free in d_cands:
            U_opt, _, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d_free, em_seed=em)
            U1 = U_opt[:d_free]
            F_sub = s40a.gf2_nullspace_np(U1)  # (k_fix, nW) TRUE ANNIHILATOR U1^perp!
            k_fix = F_sub.shape[0]
            fix_forms = []
            for row in F_sub:
                fm = 0
                for k in range(nW):
                    if row[k]:
                        fm ^= W_forms_111[k]
                fix_forms.append(fm)

            f_logs = []
            for tr in range(3):
                rb = 0 if tr == 0 else int(rng.integers(1, 1 << min(30, k_fix)))
                ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
                t_s9 = time.perf_counter()
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex_w, tbl, max_xl_rounds=25, verify_subst=False
                )
                dt_s9 = time.perf_counter() - t_s9
                if sub["closed_unsat"]:
                    f_logs.append(f"f{tr}:S9_UNSAT({dt_s9:.1f}s)")
                else:
                    n_act = 111 - len(sub["_lin_pivs"])
                    nq_s = len(sub["_quad_ids"])
                    nc_s = len(sub["_cub_ids"])
                    if n_act <= 85:
                        sat_st, dt_sat = solve_residual_with_cadical(sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], tbl)
                        f_logs.append(f"f{tr}:N={n_act},q={nq_s},c={nc_s}->{sat_st}({dt_s9:.1f}+{dt_sat:.1f}s)")
                    else:
                        f_logs.append(f"f{tr}:N={n_act},q={nq_s},c={nc_s}({dt_s9:.1f}s)")
            print(f"      d_free={d_free:2d}(k_fix={k_fix:2d}, r1_elim={bkey[0]:2d}): {' | '.join(f_logs)}", flush=True)

    print(f"\n[STEP 59C {cell_name}] DONE in {time.perf_counter()-t0:.1f}s", flush=True)


if __name__ == "__main__":
    main()
