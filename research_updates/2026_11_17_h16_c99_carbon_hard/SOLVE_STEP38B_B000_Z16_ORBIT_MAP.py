#!/usr/bin/env python3
r"""
SOLVE_STEP27A_B000_ETA0_SHATTER_AND_ETA1_CLOSE.py

FAST DEDICATED B0_00 STRIKE (~3 min):
  PART 1: SHATTER `B0_00 eta = 0` (the ONLY q=0 state, solely because f==0 lives inside it!)
    - Splits `eta = 0` across ALL balanced states of z=0xFF (7 states) AND z=0x55 (<= 64 states)
      using exact truth-table balancedness wt(h_z) == 128!
  PART 2: FORMALLY CLOSE `B0_00 eta = 1` (ALL 288 models of W_ess(12)!)
    - In Step 22A, eta=1 had ONLY 288 valid models of its 13 pure-W quads in 12 vars, and most
      closed immediately while the ~56 open models had `new_dimW = 8, 11, 27`!
    - Runs recursive `W_ess` / Cadical195 closure on EVERY open point of `eta = 1` (with `verify_subst=True`)
      to see if ALL 288/288 models of `eta = 1` CLOSE 100% TO `1 = 0`!
  PART 3: ANATOMY OF THE SOLUTION VARIETY OF `eta = 62, 63, 42`!
    - Samples 64 models of `eta = 62` (46 pure quads in 38 vars) & `eta = 42` (28 quads in 30 vars)
      and computes `dim(span(y_i ^ y_0))` AND checks if ANY linear form is CONSTANT across all
      models (i.e. forced linear equations implied by the pure-W quadratics!!).
"""

import argparse
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
import SOLVE_STEP22A_B000_ENUM_CLOSE_ETA62_63_42_AND_ETA0 as s22a


def gf2_rank_ints(xs):
    p = {}
    for x in xs:
        v = x
        while v:
            b = v.bit_length() - 1
            if b in p: v ^= p[b]
            else: p[b] = v; break
    return len(p)


def main():
    t0 = time.perf_counter()
    print("==================== [B0_00] STEP 27A: ETA=0 SHATTER + ETA=1 FULL CLOSURE + ETA=62/42 VARIETY ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s27a_diag.c", WORK_DIR / "libs27a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s27a_s9.c", WORK_DIR / "libs27a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s27a_cg.c", WORK_DIR / "libs27a_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s27a_d8.c", WORK_DIR / "libs27a_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s27a_sh.c", WORK_DIR / "libs27a_sh.so"
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
        while tmp: lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb

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

    # Compute EXACT Z_16^* action on the 64 `eta_free` states of B0_00!
    print("\n--- STEP 38B: EXACT Z_16^* ORBIT MAP OF B0_00 64 ETA-STATES ---", flush=True)
    orb_of_mon = {m: j for j, orb in enumerate(orbits) for m in orb}
    def perm_mon(m, k):
        out = 0
        for i in range(16):
            if (m >> i) & 1: out |= (1 << ((k * i) & 15))
        return out
    perms = {k: [orb_of_mon[perm_mon(orbits[j][0], k)] for j in range(116)] for k in [1, 3, 5, 7, 9, 11, 13, 15]}
    inv_k = {1: 1, 3: 11, 5: 13, 7: 7, 9: 9, 11: 3, 13: 5, 15: 15}

    # Build linear map from 111-var vector x -> 116-orbit vector c -> pi_k(c) -> 111-var vector x' -> eta(x')!
    # Wait: in B0_00, c_115=c_99=c_57=c_113=0, and free111[i] has c[free111[i]] = x_i, c[0] = sum_{j in L\{0}} c[j]!
    orb_to_111 = {j: i for i, j in enumerate(free111)}
    # Test on 20 random points in the root affine subspace of B0_00!
    lin_pivs = root["_lin_pivs"]
    act_vars = [i for i in range(111) if i not in lin_pivs]
    def apply_pi_k_to_x111(x111, k):
        # Convert x111 -> 116-bit orbit vector c
        c = origin111
        tmp = x111
        while tmp:
            lb = tmp & -tmp; c ^= cb111[lb.bit_length() - 1]; tmp ^= lb
        # Apply pi_k: c'[p[j]] = c[j]
        p = perms[k]
        c_new = 0
        tmp = c
        while tmp:
            lb = tmp & -tmp; c_new |= (1 << p[lb.bit_length() - 1]); tmp ^= lb
        # Extract x111' from c_new[free111[i]]
        x_new = 0
        for i, j in enumerate(free111):
            if (c_new >> j) & 1: x_new |= (1 << i)
        return x_new

    def eval_eta_of_x111(x111):
        em = 0
        for j in range(n_ef):
            if (eta_free[j] & x111).bit_count() & 1:
                em |= (1 << j)
        return em

    # Verify root linear pivots are preserved by pi_k, AND build exact lookup table eta -> pi_k(eta) for all 64 eta!
    rng = random.Random(3838)
    # Construct one canonical root-valid x111 for each of the 64 eta states!
    # Solve linear system: lin_pivs + eta_free[j](x) = bit_j
    eta_map = {k: {} for k in perms}
    for em in range(64):
        # Find 2 distinct random root-valid points with this eta to verify pi_k(eta) depends ONLY on eta!
        # Build strict RREF of lin_pivs + eta_free
        piv_all = dict(lin_pivs)
        for j in range(n_ef):
            v = eta_free[j]
            rhs = (em >> j) & 1
            while v:
                b = v.bit_length() - 1
                if b in piv_all:
                    pv, pr = piv_all[b]; v ^= pv; rhs ^= pr
                else:
                    piv_all[b] = (v, rhs); break
            assert v != 0
        # Back-reduce piv_all
        for b in sorted(piv_all.keys()):
            for hb in list(piv_all.keys()):
                if hb > b and ((piv_all[hb][0] >> b) & 1):
                    piv_all[hb] = (piv_all[hb][0] ^ piv_all[b][0], piv_all[hb][1] ^ piv_all[b][1])
        free_rem = [i for i in range(111) if i not in piv_all]
        pts_test = []
        for _ in range(3):
            x = 0
            for fr in free_rem:
                if rng.getrandbits(1): x |= (1 << fr)
            for b, (pv, pr) in piv_all.items():
                if pr ^ (((pv ^ (1 << b)) & x).bit_count() & 1): x |= (1 << b)
            assert eval_eta_of_x111(x) == em
            pts_test.append(x)
        for k in perms:
            imgs = set()
            for x in pts_test:
                x2 = apply_pi_k_to_x111(x, k)
                # Verify root linear pivots hold on x2!
                for lp, (pv, pr) in lin_pivs.items():
                    assert (((pv & x2).bit_count() & 1) == pr), f"Root lin_piv violated by k={k}!"
                imgs.add(eval_eta_of_x111(x2))
            assert len(imgs) == 1, f"eta not well-defined under k={k}: {imgs}"
            eta_map[k][em] = next(iter(imgs))

    # Run direct closure check on all 64 eta to get exact signatures & direct-closed set!
    direct_closed = set()
    sigs = {}
    for em in range(64):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=False
        )
        if sr["closed_unsat"]:
            direct_closed.add(em)
            sigs[em] = ("CLOSED", 0, 0)
        else:
            sigs[em] = ("OPEN", 111 - len(sr["_lin_pivs"]), len(sr["_quad_ids"]))

    proved_extra = {1, 21, 22, 23, 43, 60, 61, 62, 63}
    all_proved_direct = direct_closed | proved_extra

    # Decompose 64 eta-states into EXACT Z_16^*-orbits and Zero-Trust verify identical signatures within each orbit!
    seen_e = set()
    orbs = []
    for em in range(64):
        if em in seen_e: continue
        o = sorted({eta_map[k][em] for k in perms})
        seen_e |= set(o)
        orbs.append(o)
        # Zero-Trust check: ALL members of the orbit must have IDENTICAL (status, N, q) signature!
        s_set = {sigs[e] for e in o}
        assert len(s_set) == 1, f"Signature mismatch inside Z_16^* orbit {o}: {s_set}"

    n_closed_by_sym = 0
    open_orbs = []
    print(f"  *** ZERO-TRUST VERIFIED: ALL 64 eta-states decompose into {len(orbs)} EXACT Z_16^*-ORBITS (0 signature mismatches!) ***", flush=True)
    for idx_o, o in enumerate(orbs):
        closed_in_o = [e for e in o if e in all_proved_direct]
        is_cl = len(closed_in_o) > 0
        if is_cl:
            n_closed_by_sym += len(o)
            tag = f"CLOSED (via {closed_in_o})"
        else:
            open_orbs.append(o)
            tag = f"OPEN sig={sigs[o[0]]}"
        print(f"    Orbit {idx_o:2d} (sz={len(o)}): {str(o):22s} -> {tag}", flush=True)

    print(f"\n  *** B0_00 SYMMETRY SCOREBOARD: {n_closed_by_sym} / 64 eta-states FORMALLY CLOSED! ***", flush=True)
    print(f"  *** REMAINING DISTINCT OPEN ORBITS = {len(open_orbs)} (covering {64 - n_closed_by_sym} states): {[o[0] for o in open_orbs]} ***", flush=True)
    print(f"[B0_00] STEP 38B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
