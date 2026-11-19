#!/usr/bin/env python3
"""Verify projected branches of B0_00 eta=0 or eta=1."""

import ctypes
import random
import subprocess
import sys
import time
from pathlib import Path
import argparse
import hashlib
import json
from itertools import combinations

from H16_ANF_SMALL import anf_solutions
from H16_NORMAL_BALANCE_PROJECTION import normal_balance_count, normal_balance_options
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


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--scan", action="store_true")
    parser.add_argument("--focus-eta", type=int)
    parser.add_argument("--eta", type=int, default=1, choices=(0, 1))
    parser.add_argument("--shard", type=int, default=0)
    parser.add_argument("--shards", type=int, default=1)
    args = parser.parse_args()
    if not 0 <= args.shard < args.shards:
        parser.error("expected 0 <= shard < shards")
    t0 = time.perf_counter()
    print("==================== [B0_00] STEP 29A: ETA=1 FULL CLOSURE ====================", flush=True)

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

    # q = 0 in B0_00. Every nonzero diagonal coset must be balanced.
    origin_tt = np.zeros(65536, dtype=np.uint8)
    origin_mask = origin111
    while origin_mask:
        bit = origin_mask & -origin_mask
        origin_mask ^= bit
        origin_tt ^= orb_tt_np[bit.bit_length() - 1]

    def pack_256(values):
        return int.from_bytes(np.packbits(values, bitorder="little").tobytes(), "little")

    cosets = (0x55, 0xFF, 0x11, 0x33, 0x77, 0x01)
    truth = {}
    for z in cosets:
        pts = [u | ((u ^ z) << 8) for u in range(256)]
        truth[z] = (pack_256(origin_tt[pts]),
                    [pack_256(row[pts]) for row in b_tt])

    groups = [(z,) for z in cosets] + list(combinations(cosets, 2))

    def choose_balance_split(pivots, max_states):
        best = None
        for group in groups:
            result = normal_balance_options([truth[z] for z in group], pivots, rank_cap=9)
            if result is None:
                continue
            forms, states = result
            if form_count := len(forms):
                if len(states) < 1 << form_count and len(states) <= max_states:
                    candidate = (len(states), form_count, group, forms, states)
                    if best is None or candidate[:3] < best[:3]:
                        best = candidate
        return best

    def exclude_on_balance(pivots):
        for group in groups:
            count = normal_balance_count([truth[z] for z in group], pivots)
            if count is not None and count[1] == 0:
                return group, count[0]
        return None

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

    if args.scan or args.focus_eta is not None:
        def cascade(state, constraints, rounds=24):
            return s9.run_branch_cascade(
                lib9, state["_buf"], state["_quad_ids"], state["_cub_ids"],
                state["_lin_pivs"], constraints, tbl,
                max_xl_rounds=rounds, verify_subst=True,
                linear_conflict=exclude_on_balance if args.focus_eta is not None and state is not root else None,
            )

        def assign(forms, value):
            return [(form, (value >> i) & 1) for i, form in enumerate(forms)]

        def pure_w_options(state):
            qps = [s9.row_to_pset(state["_buf"], qr, tbl) for qr in state["_quad_ids"]]
            if not qps:
                return 0, None
            analysis = s16.analyze_quad_system(qps)
            w_rref = s19.strict_rref_masks(list(analysis["W_piv"].values()))
            n_w = len(w_rref)
            if n_w > 14:
                return n_w, None
            pivots, polys = s22a.extract_pure_w_quads(lib_sh, state, w_rref, tbl)
            forms = [w_rref[p] for p in pivots]
            values = anf_solutions(polys, len(forms))
            return n_w, (forms, values, len(polys))

        def pick_projection(state, cap):
            n_w, pure = pure_w_options(state)
            options = []
            pure_count = None
            if pure is not None:
                forms, values, n_eqs = pure
                pure_count = len(values)
                if pure_count <= cap and (pure_count < 1 << len(forms) or pure_count == 0):
                    options.append((len(values), len(forms), f"pure_W_{n_eqs}", forms, values))
            balance = choose_balance_split(state["_lin_pivs"], max_states=cap)
            if balance is not None:
                count, rank, group, forms, values = balance
                options.append((count, rank, ",".join(f"{z:#04x}" for z in group), forms, values))
            best = min(options, key=lambda item: item[:3]) if options else None
            return n_w, pure_count, best

        summary = []
        eta_values = range(args.shard, 1 << n_ef, args.shards) if args.focus_eta is None else (args.focus_eta,)
        for eta in eta_values:
            if eta in (0, 1):
                continue
            started = time.perf_counter()
            deadline = started + (210 if args.focus_eta is not None else 65)
            record = {"eta": eta, "status": "open"}
            print(f"eta={eta} starting", flush=True)
            state = cascade(root, assign(eta_free, eta))
            if state["closed_unsat"]:
                record.update(status="root_unsat", reason=state["closed_by"])
            elif "_buf" not in state:
                record.update(status="capped", reason=state.get("note"))
            elif hit := exclude_on_balance(state["_lin_pivs"]):
                record.update(status="balance_unsat", group=hit[0], rank=hit[1])
            else:
                record.update(active=state["N_active"], quads=len(state["_quad_ids"]))
                n_w, pure_count, option = pick_projection(state, cap=40)
                record.update(nW=n_w, pure_models=pure_count)
                if option is not None:
                    count, rank, label, forms, values = option
                    values = sorted(values)
                    anchor = hashlib.sha256(json.dumps([eta_free, forms, values]).encode()).hexdigest()
                    assigned_values = values if args.focus_eta is None else values[args.shard::args.shards]
                    record.update(projection=label, rank=rank, cases=count, anchor=anchor,
                                  assigned=assigned_values, tested=0, remaining=[], shard=args.shard)
                    for value in assigned_values:

                        if time.perf_counter() >= deadline:
                            break
                        assignments = assign(forms, value)
                        pivots = state["_lin_pivs"].copy()
                        feasible = all(s9.add_linear_rref(pivots, mask, rhs) for mask, rhs in assignments)
                        record["tested"] += 1
                        if not feasible or exclude_on_balance(pivots):
                            continue
                        child = cascade(state, assignments, rounds=18)
                        if child["closed_unsat"]:
                            continue
                        if "_lin_pivs" in child and exclude_on_balance(child["_lin_pivs"]):
                            continue
                        record["remaining"].append(value)
                    if record["tested"] == len(assigned_values) and not record["remaining"]:
                        record["status"] = "projection_unsat" if args.focus_eta is None else "shard_unsat"
            record["seconds"] = round(time.perf_counter() - started, 2)
            summary.append(record)
            kind = "STEP31" if args.focus_eta is None else "STEP33"
            print(kind + "_RESULT " + json.dumps(record), flush=True)
            filename = (f"step31_b000_scan_{args.shard}.json" if args.focus_eta is None else
                        f"step33_b000_eta{eta}_{args.shard}.json")
            (WORK_DIR / filename).write_text(
                json.dumps({"eta_forms": eta_free, "summary": summary}, indent=2),
                encoding="utf-8",
            )
        return

    # --------------------------------------------------------------------------
    # PART 2: FULL CLOSURE ATTEMPT ON B0_00 eta = 1 (ALL 288 MODELS + RECURSIVE W_ess!)
    # --------------------------------------------------------------------------
    print(f"\n--- B0_00 eta={args.eta} ---", flush=True)
    ex1 = [(eta_free[k], (args.eta >> k) & 1) for k in range(n_ef)]
    sr1 = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex1, tbl, max_xl_rounds=20, verify_subst=True
    )
    if args.eta == 0:
        groups0 = (0xFF, 0x55)
        options = normal_balance_options([truth[z] for z in groups0], sr1["_lin_pivs"])
        assert options is not None, "joint coset image exceeded rank cap"
        W_forms1, models1 = options
        nW1 = len(W_forms1)
        print(f"eta=0 joint cosets={groups0} rank={nW1} balanced={len(models1)}/{1<<nW1}",
              flush=True)
    else:
        qps1 = [s9.row_to_pset(sr1["_buf"], qr, tbl) for qr in sr1["_quad_ids"]]
        ana1 = s16.analyze_quad_system(qps1)
        W_rref1 = s19.strict_rref_masks(list(ana1["W_piv"].values()))
        W_pivs1, pure_y1 = s22a.extract_pure_w_quads(lib_sh, sr1, W_rref1, tbl)
        W_forms1 = [W_rref1[p] for p in W_pivs1]
        nW1 = len(W_pivs1)
        exh1, models1, _ = s22a.enumerate_pure_w_models(pure_y1, nW1, max_models=5000, time_budget=30.0)
        assert exh1
    models1 = sorted(set(models1))
    anchor = hashlib.sha256(json.dumps([eta_free, W_forms1, models1]).encode()).hexdigest()
    assigned = models1[args.shard::args.shards]
    print(f"eta={args.eta} shard={args.shard}/{args.shards} | {len(assigned)}/{len(models1)} models | anchor={anchor}",
          flush=True)
    n_cl1, n_rec_cl, n_still_open = 0, 0, 0
    open_details = []
    coset_closed = []
    for idx_m, y in enumerate(assigned):
        if idx_m % 24 == 0:
            print(f"eta={args.eta} progress: {idx_m}/{len(assigned)} direct={n_cl1} "
                  f"recursive={n_rec_cl} balance={len(coset_closed)}", flush=True)
        ex_w = [(W_forms1[j], (y >> j) & 1) for j in range(nW1)]
        sub = s9.run_branch_cascade(
            lib9, sr1["_buf"], sr1["_quad_ids"], sr1["_cub_ids"], sr1["_lin_pivs"],
            ex_w, tbl, max_xl_rounds=10, verify_subst=True
        )
        if sub.get("note") == "max_xl_rounds_reached":
            sub = s9.run_branch_cascade(
                lib9, sr1["_buf"], sr1["_quad_ids"], sr1["_cub_ids"], sr1["_lin_pivs"],
                ex_w, tbl, max_xl_rounds=40, verify_subst=True
            )
        if not sub["closed_unsat"] and "_buf" not in sub:
            open_details.append((y, None, None, None, -1, -1))
            n_still_open += 1
            continue
        if sub["closed_unsat"]:
            n_cl1 += 1
        else:
            hit = exclude_on_balance(sub["_lin_pivs"])
            if hit is not None:
                group, rank = hit
                coset_closed.append((y, group, rank))
                print(f"eta={args.eta} balance contradiction: w_mask={y:#x} cosets={group} rank={rank}",
                      flush=True)
                continue
            if args.eta == 0:
                split = choose_balance_split(sub["_lin_pivs"], max_states=12)
                if split is not None:
                    _, _, coset_group, forms, admissible = split
                    still_open = 0
                    for b in admissible:
                        constraints = [(form, (b >> i) & 1) for i, form in enumerate(forms)]
                        child = s9.run_branch_cascade(
                            lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"],
                            sub["_lin_pivs"], constraints, tbl,
                            max_xl_rounds=20, verify_subst=True
                        )
                        if not child["closed_unsat"]:
                            if "_lin_pivs" not in child or exclude_on_balance(child["_lin_pivs"]) is None:
                                still_open += 1
                    if still_open == 0:
                        n_rec_cl += 1
                        continue
                    open_details.append((y, sub["N_active"], sub["n_quad_surviving"],
                                         "coset", coset_group, still_open))
                else:
                    open_details.append((y, sub["N_active"], sub["n_quad_surviving"],
                                         "coset", None, 1))
                n_still_open += 1
                continue
            # Inspect new W_ess! If new_dimW <= 12, exhaustively close recursively!!
            nqps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub.get("_quad_ids", [])]
            nana = s16.analyze_quad_system(nqps) if nqps else {"dim_W_ess": 99, "W_piv": {}}
            ndw = nana["dim_W_ess"]
            if 0 < ndw <= 11:
                W2_rref = s19.strict_rref_masks(list(nana["W_piv"].values()))
                W2_pivs, pure_y2 = s22a.extract_pure_w_quads(lib_sh, sub, W2_rref, tbl)
                W2_forms = [W2_rref[p] for p in W2_pivs]
                exh2, mods2, _ = s22a.enumerate_pure_w_models(pure_y2, len(W2_pivs), max_models=4096, time_budget=10.0)
                sub_op = 0
                for y2 in mods2:
                    ex_w2 = [(W2_forms[j], (y2 >> j) & 1) for j in range(len(W2_pivs))]
                    sub2 = s9.run_branch_cascade(
                        lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                        ex_w2, tbl, max_xl_rounds=20, verify_subst=True
                    )
                    if not sub2["closed_unsat"]:
                        sub_op += 1
                if exh2 and sub_op == 0:
                    n_rec_cl += 1
                    continue
                open_details.append((y, sub["N_active"], len(nqps), ndw, len(mods2), sub_op))
            else:
                open_details.append((y, sub["N_active"], len(nqps), ndw, -1, -1))
            n_still_open += 1
    assert n_cl1 + n_rec_cl + len(coset_closed) + n_still_open == len(assigned)
    print(f"  [eta={args.eta}] SHARD MODELS = {len(assigned)} / {len(models1)}: direct_closed={n_cl1}, rec_W_closed={n_rec_cl}, balance_closed={len(coset_closed)}, STILL_OPEN={n_still_open}", flush=True)
    (WORK_DIR / f"step30_b000_eta{args.eta}_{args.shard}.json").write_text(
        json.dumps({"models": len(models1), "anchor": anchor, "shard": args.shard,
                    "shards": args.shards, "assigned": assigned, "direct_closed": n_cl1,
                    "recursive_closed": n_rec_cl, "balance_closed": coset_closed,
                    "open": open_details}, indent=2),
        encoding="utf-8",
    )
    for od in open_details:
        print(f"      OPEN y=0x{od[0]:03x}: N={od[1]}, q={od[2]}, new_dimW={od[3]}, mods2={od[4]}, open2={od[5]}", flush=True)

    print(f"\n[B0_00] STEP 30A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
