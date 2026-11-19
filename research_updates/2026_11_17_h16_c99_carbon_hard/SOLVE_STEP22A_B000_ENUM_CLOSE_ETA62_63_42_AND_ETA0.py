#!/usr/bin/env python3
r"""
SOLVE_STEP22A_B000_ENUM_CLOSE_ETA62_63_42_AND_ETA0.py

FORMAL CLOSURE PUSH ON B0_00 (17/64 ALREADY CLOSED DIRECTLY!):
  PART 1 (ENUMERATE & CLOSE eta=62, 63, 42, 43):
    - eta=62 & eta=63 each have 46 PURE QUADRATICS in ONLY 38 W_ess variables!
      Enumerates ALL solutions y in F_2^{38} via Cadical195 (blocking clauses) and checks
      EVERY solution in `run_branch_cascade(verify_subst=True)`!
      If 100% of solutions close to 1=0, eta=62 and eta=63 are 100% FORMALLY CLOSED!
    - Same for eta=42 (28 pure quads + 2 XL-D4 quads = 30 quads in 30 vars!).
  PART 2 (DISSECT & CLOSE THE 56 OPEN POINTS OF eta=1):
    - In Step 19B, eta=1 (dimW=12) closed 1,032/1,088 valid points; ONLY 56 points stayed open!
    - Inspects ALL 56 open points (N, q, c, new dimW) and attempts recursive closure on them!
  PART 3 (SHATTER eta=0 BY FORBIDDING f == 0 VIA z=0xFF (7 states) & z=0x55 (balanced states)):
    - Splits eta=0 (the ONLY q=0 state, solely because f==0 lives inside it!) across the 7
      balanced states of (b1,b2,b3) on z=0xFF and the balanced states of z=0x55 (6 forms -> <=64 states)!
"""

import ctypes
import random
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19


def enumerate_pure_w_models(y_quads, nW, max_models=500, time_budget=180.0):
    """Enumerate ALL models y in F_2^{nW} of `y_quads` using Cadical195 + blocking clauses!
    Returns (exhausted_bool, models_list)."""
    next_var = nW + 1
    pair_var = {}
    clauses = []

    def add_xor_small(lits, rhs):
        k = len(lits)
        if k == 0:
            if rhs: clauses.append([])
            return
        for mask in range(1 << k):
            if (mask.bit_count() & 1) != rhs:
                clauses.append([-lits[i] if ((mask >> i) & 1) else lits[i] for i in range(k)])

    def add_xor(lits, rhs):
        nonlocal next_var
        cur = list(lits)
        while len(cur) > 4:
            chunk = cur[:3]
            nv = next_var; next_var += 1
            add_xor_small(chunk + [nv], 0)
            cur = [nv] + cur[3:]
        add_xor_small(cur, rhs)

    for qm in y_quads:
        rhs, lits = 0, []
        for m in qm:
            if m == 0:
                rhs ^= 1
            elif m.bit_count() == 1:
                lits.append(m.bit_length())
            elif m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                key = (b0, b1)
                if key not in pair_var:
                    pv = next_var; next_var += 1
                    pair_var[key] = pv
                    u, v = b0 + 1, b1 + 1
                    clauses.append([-pv, u])
                    clauses.append([-pv, v])
                    clauses.append([pv, -u, -v])
                lits.append(pair_var[key])
        add_xor(lits, rhs)

    t0 = time.perf_counter()
    models = []
    exhausted = False
    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        while len(models) < max_models:
            if time.perf_counter() - t0 > time_budget:
                break
            if not slv.solve():
                exhausted = True
                break
            mod = slv.get_model()
            y = sum((1 << i) for i in range(nW) if mod[i] > 0)
            # Zero-trust verify
            for qm in y_quads:
                v = 0
                for m in qm:
                    if (y & m) == m: v ^= 1
                assert v == 0
            models.append(y)
            # Block ONLY on the nW primary variables!
            block = [-(i + 1) if ((y >> i) & 1) else (i + 1) for i in range(nW)]
            slv.add_clause(block)
    return exhausted, models, time.perf_counter() - t0


def extract_pure_w_quads(lib_sh, sr, W_rref, tbl):
    n, n_cw = tbl["n"], tbl["n_col_words"]
    mask64 = (1 << 64) - 1
    W_pivs = sorted(W_rref.keys())
    n_q = len(sr["_quad_ids"])
    qbuf = (ctypes.c_uint64 * (n_q * n_cw))()
    for i, qr in enumerate(sr["_quad_ids"]):
        ctypes.memmove(ctypes.byref(qbuf, i * n_cw * 8), ctypes.byref(sr["_buf"], qr * n_cw * 8), n_cw * 8)
    for p in W_pivs:
        rest = W_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                qbuf, n_q, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )
    w_to_j = {v: j for j, v in enumerate(W_pivs)}
    rt_piv = {}
    pure_y_quads = []
    for i in range(n_q):
        ps = s9.row_to_pset(qbuf, i, tbl)
        rmask, yset = 0, set()
        for m in ps:
            if m == 0: yset.add(0)
            elif m.bit_count() == 1:
                v = m.bit_length() - 1
                if v in w_to_j: yset.add(1 << w_to_j[v])
                else: rmask |= (1 << v)
            else:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                yset.add((1 << w_to_j[b0]) | (1 << w_to_j[b1]))
        while rmask:
            b = rmask.bit_length() - 1
            if b in rt_piv:
                pm, pys = rt_piv[b]
                rmask ^= pm; yset ^= pys
            else:
                rt_piv[b] = (rmask, yset); break
        else:
            if yset: pure_y_quads.append(sorted(yset))
    return W_pivs, pure_y_quads


def main():
    t0 = time.perf_counter()
    print("==================== [B0_00] STEP 22A: FORMAL CLOSURE OF eta=62,63,42,1 + eta=0 SHATTER ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s22a_diag.c", WORK_DIR / "libs22a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s22a_s9.c", WORK_DIR / "libs22a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s22a_cg.c", WORK_DIR / "libs22a_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s22a_d8.c", WORK_DIR / "libs22a_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s22a_sh.c", WORK_DIR / "libs22a_sh.so"
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
    free111, origin111, cb111 = b09.build_pure_111_basis(0, 0, 0)
    n, n_cw = tbl["n"], tbl["n_col_words"]

    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb

    seen_a, d8_specs = set(), []
    for a in range(1, 256):
        if a in seen_a: continue
        orb_a = [((a << s) | (a >> (8 - s))) & 0xFF for s in range(8)]
        seen_a.update(orb_a)
        olen = len(set(orb_a))
        d8_specs.append((a, 3))
        if olen == 4: d8_specs.append((a, 4))
        elif olen == 2: d8_specs.append((a, 5))
        elif olen == 1: d8_specs.append((a, 6))

    d8_buf = (ctypes.c_uint64 * (len(d8_specs) * n_cw))()
    for idx_d, (a, sb) in enumerate(d8_specs):
        pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
        b_words = (ctypes.c_uint64 * (111 * 4))()
        for i in range(111):
            bits = b_tt[i, pts]
            for w in range(4):
                val = 0
                for b in range(64):
                    if bits[w * 64 + b]: val |= (1 << b)
                b_words[i * 4 + w] = val
        rptr = ctypes.cast(ctypes.byref(d8_buf, idx_d * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_d8.extract_deg3_coset_poly(
            b_words, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
            tbl["col2_base"], tbl["col3_base"], rptr
        )

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1; orb_map[99] = -1; orb_map[57] = -1; orb_map[113] = -1
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    # --------------------------------------------------------------------------
    # PART 1: FORMAL CLOSURE ATTEMPT ON eta = 62, 63, 42!
    # --------------------------------------------------------------------------
    print("\n--- PART 1: ENUMERATE ALL PURE-W MODELS & FORMALLY CLOSE eta = 62, 63, 42 ---", flush=True)
    for em in [62, 63, 42]:
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=True
        )
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        W_pivs, pure_y = extract_pure_w_quads(lib_sh, sr, W_rref, tbl)
        W_forms = [W_rref[p] for p in W_pivs]
        nW = len(W_pivs)
        exh, models, dt = enumerate_pure_w_models(pure_y, nW, max_models=200, time_budget=180.0)
        print(f"  [eta={em}] nW={nW}, pure_quads={len(pure_y)}: exhausted={exh}, n_models={len(models)} ({dt:.2f}s)", flush=True)
        n_cl, n_op = 0, 0
        for idx_m, y in enumerate(models):
            ex_w = [(W_forms[j], (y >> j) & 1) for j in range(nW)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_w, tbl, max_xl_rounds=12, verify_subst=(idx_m < 3)
            )
            if sub["closed_unsat"]: n_cl += 1
            else:
                n_op += 1
                if n_op <= 3:
                    print(f"      OPEN model y=0x{y:x}: N={sub['N_active']}, q={sub.get('n_quad_surviving')}, c={sub.get('n_genuine_cubics')}", flush=True)
        if exh and n_op == 0:
            print(f"  *** [B0_00 eta={em}] 100% FORMALLY CLOSED (EXHAUSTED ALL {len(models)} PURE-W MODELS -> 100% 1=0)!! ***", flush=True)
        else:
            print(f"  [B0_00 eta={em}] closed={n_cl}/{len(models)}, open={n_op}, exhausted={exh}", flush=True)

    # --------------------------------------------------------------------------
    # PART 2: DISSECT ALL 56 OPEN POINTS OF eta = 1!
    # --------------------------------------------------------------------------
    print("\n--- PART 2: DISSECT & CLOSE ALL SURVIVING POINTS OF eta = 1 (dimW=12) ---", flush=True)
    ex1 = [(eta_free[k], (1 >> k) & 1) for k in range(n_ef)]
    sr1 = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex1, tbl, max_xl_rounds=20, verify_subst=True
    )
    qps1 = [s9.row_to_pset(sr1["_buf"], qr, tbl) for qr in sr1["_quad_ids"]]
    ana1 = s16.analyze_quad_system(qps1)
    W_rref1 = s19.strict_rref_masks(list(ana1["W_piv"].values()))
    W_pivs1, pure_y1 = extract_pure_w_quads(lib_sh, sr1, W_rref1, tbl)
    W_forms1 = [W_rref1[p] for p in W_pivs1]
    nW1 = len(W_pivs1)
    exh1, models1, dt1 = enumerate_pure_w_models(pure_y1, nW1, max_models=5000, time_budget=30.0)
    print(f"  [eta=1] nW={nW1}, pure_quads={len(pure_y1)}: exhausted={exh1}, total_models={len(models1)} ({dt1:.2f}s)", flush=True)
    n_cl1, n_op1 = 0, 0
    open_q_hist = {}
    for idx_m, y in enumerate(models1):
        ex_w = [(W_forms1[j], (y >> j) & 1) for j in range(nW1)]
        sub = s9.run_branch_cascade(
            lib9, sr1["_buf"], sr1["_quad_ids"], sr1["_cub_ids"], sr1["_lin_pivs"],
            ex_w, tbl, max_xl_rounds=12, verify_subst=(idx_m < 3)
        )
        if sub["closed_unsat"]:
            n_cl1 += 1
        else:
            n_op1 += 1
            qv = sub.get("n_quad_surviving", -1)
            key = (sub["N_active"], qv)
            open_q_hist[key] = open_q_hist.get(key, 0) + 1
            if n_op1 <= 5:
                # Analyze NEW quads dropped at this open point!
                nqps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub.get("_quad_ids", [])]
                nana = s16.analyze_quad_system(nqps) if nqps else {}
                print(f"      eta=1 OPEN #{n_op1} y=0x{y:03x}: N={sub['N_active']}, q={qv}, c={sub.get('n_genuine_cubics')}, new_dimW={nana.get('dim_W_ess',0)}, new_pureW={nana.get('n_pure_in_W_ess',0)}", flush=True)
    print(f"  [eta=1] SUMMARY: closed={n_cl1}/{len(models1)}, open={n_op1}, open_(N,q)_hist={open_q_hist}", flush=True)

    # --------------------------------------------------------------------------
    # PART 3: SHATTER eta = 0 BY FORBIDDING f == 0 ON z=0xFF (7 states) & z=0x55 (balanced)!
    # --------------------------------------------------------------------------
    print("\n--- PART 3: SHATTER B0_00 eta = 0 BY z=0xFF & z=0x55 BALANCEDNESS ---", flush=True)
    ex0 = [(eta_free[k], 0) for k in range(n_ef)]
    sr0 = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex0, tbl, max_xl_rounds=20, verify_subst=True
    )
    # Extract linear forms of h_{0xFF}(u) and h_{0x55}(u) from b_tt!
    for z_name, z_val in [("0xFF", 0xFF), ("0x55", 0x55)]:
        pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
        # Collect unique linear forms (111-bit masks) from b_tt[:, pts], reduced mod sr0["_lin_pivs"]
        raw_forms = []
        for k in range(256):
            col = b_tt[:, pts[k]]
            if np.any(col):
                fm = sum((1 << int(i)) for i in np.flatnonzero(col))
                raw_forms.append(fm)
        z_free = s16.reduce_forms_mod_pivs(raw_forms, sr0["_lin_pivs"])
        nz = len(z_free)
        print(f"  [eta=0, z={z_name}] free linear forms = {nz} (2^{nz} = {1<<nz} states)", flush=True)
        if nz <= 7:
            # Evaluate actual wt(h_z) for each of the 2^nz states!
            # Build mapping from z_free assignment to truth table on pts:
            # Find for each bit j in 0..nz-1 a basis vector x_j in ker(sr0["_lin_pivs"]) with z_free[k](x_j) = delta_{j,k}!
            z_rref = s19.strict_rref_masks(z_free)
            z_pivs = sorted(z_rref.keys())
            z_forms = [z_rref[p] for p in z_pivs]
            # For x = e_{z_pivs[j]} ^ (pivot adjustments from sr0["_lin_pivs"]):
            # Wait: z_forms are already reduced mod sr0["_lin_pivs"], so z_pivs are ALL active vars!
            z_tts = []
            for p in z_pivs:
                x = 1 << p
                for lp, (pv, pr) in sr0["_lin_pivs"].items():
                    if (((pv ^ (1 << lp)) & x).bit_count()) & 1:
                        x |= (1 << lp)
                tt = np.zeros(256, dtype=np.uint8)
                tmp = x
                while tmp: lb = tmp & -tmp; tt ^= b_tt[lb.bit_length() - 1, pts]; tmp ^= lb
                z_tts.append(tt)
            # Base point (all active = 0)
            x0 = 0
            for lp, (pv, pr) in sr0["_lin_pivs"].items():
                if pr: x0 |= (1 << lp)
            tt0 = np.zeros(256, dtype=np.uint8)
            tmp = x0
            while tmp: lb = tmp & -tmp; tt0 ^= b_tt[lb.bit_length() - 1, pts]; tmp ^= lb

            n_bal, n_bal_cl, q_h = 0, 0, {}
            for st in range(1 << nz):
                tt = tt0.copy()
                for j in range(nz):
                    if (st >> j) & 1: tt ^= z_tts[j]
                if int(tt.sum()) != 128:
                    continue
                n_bal += 1
                ex_z = [(z_forms[j], (st >> j) & 1) for j in range(nz)]
                sub = s9.run_branch_cascade(
                    lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
                    ex_z, tbl, max_xl_rounds=15, verify_subst=(n_bal <= 2)
                )
                if sub["closed_unsat"]: n_bal_cl += 1
                else:
                    qv = sub.get("n_quad_surviving", -1)
                    q_h[qv] = q_h.get(qv, 0) + 1
            print(f"    [eta=0, z={z_name}] balanced={n_bal}/{1<<nz} | CLOSED={n_bal_cl}/{n_bal} | q_hist={dict(sorted(q_h.items()))}", flush=True)

    print(f"\n[B0_00] STEP 22A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
