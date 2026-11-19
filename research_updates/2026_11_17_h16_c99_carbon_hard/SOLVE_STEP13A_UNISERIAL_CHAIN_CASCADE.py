#!/usr/bin/env python3
r"""
SOLVE_STEP13A_UNISERIAL_CHAIN_CASCADE.py

Exploits the Step 12B breakthrough (fixing ONLY 5 free linear forms of E_9 = 0xFF+D_8
dropped 2 BRAND-NEW QUADRATICS on 100% of the 32 surviving states of B0_11, whereas fixing
80 random variables dropped 0!):

  PART 1: Exact Uniserial C_16-Invariant Chain E_9 < E_10 < E_11 < E_12 < E_13 < E_14!
    - Extracts the exact evaluation-code linear forms for each layer E_k = ker((1+rho)^k).
    - Tests consistent random states at EVERY layer E_9, E_10, E_11, E_12, E_13, E_14
      on the surviving linearized branch of B0_00, B0_11, B1_11 (ALL 388 CG cubics!).
    - Measures the EXACT layer E_k where quadratics, linear pivots, and 1 = 0 avalanche!
  PART 2: Deep Symplectic Cascade on B0_11's 32 E_9-Survivors (AND ALL 6 surviving branches!):
    - On B0_11, recursively linearizes the 2 new quadratics dropped on every E_9 survivor
      (depth up to 4) to see if B0_11 collapses to 1 = 0 right inside E_9!
  PART 3: Single Low-Rank Coset Scan (0x55+D_8, 0x11+D_8, 0x33+D_8, 0x77+D_8):
    - Tests whether fixing ANY individual high-symmetry D_8-coset (only 12..20 linear forms!)
      triggers a massive quadratic/linear/1=0 drop in B0_00, B0_11, or B1_11!
"""

import argparse
import ctypes
import json
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


def apply_1_plus_rho(x):
    return x ^ (((x << 1) | (x >> 15)) & 0xFFFF)


def build_ek_sets():
    E_sets = {}
    for k in (8, 9, 10, 11, 12, 13, 14):
        pts = []
        for x in range(65536):
            y = x
            for _ in range(k):
                y = apply_1_plus_rho(y)
            if y == 0:
                pts.append(x)
        E_sets[k] = np.array(pts, dtype=np.uint16)
    return E_sets


def extract_linear_forms_on_pts(b_tt, pts):
    """Return a GF(2)-independent basis of 111-bit evaluation linear forms on `pts`."""
    piv = {}
    forms = []
    # Vectorized or fast loop
    for x in pts:
        col = b_tt[:, x]
        if not np.any(col):
            continue
        m = 0
        for i in np.flatnonzero(col):
            m |= (1 << int(i))
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in piv:
                rem ^= piv[b]
            else:
                piv[b] = rem
                forms.append(m)
                break
    return forms


def reduce_forms_modulo_lin_pivs(forms, lin_pivs):
    """Project 111-bit linear forms modulo existing linear pivots (var -> (pv, pr)),
    returning a maximal independent subset of free forms (mask, base_const)."""
    piv = {}
    free_forms = []
    for fm in forms:
        m = fm
        c = 0
        # Eliminate any pivot variable in lin_pivs
        for p, (pv, pr) in lin_pivs.items():
            if (m >> p) & 1:
                m ^= pv
                c ^= pr
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in piv:
                rem ^= piv[b]
            else:
                piv[b] = rem
                free_forms.append((m, c))
                break
    return free_forms


def run_step13a_cell(cell_name, lib_diag, lib9, lib_cg, orbits, orb_tt_np, E_sets,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 13A: UNISERIAL CHAIN E_9..E_14 CASCADE ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    orb_map[115] = -1
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False)
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    forms = s9.find_minimal_linearizers(root_quad_psets, n)["linearizer_forms_111"]
    k_lin = len(forms)

    # Pick first surviving branch (for B0_00 test branch 000!)
    target_br, target_bmask = None, None
    for bmask in range(1 << k_lin):
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            [(forms[i], (bmask >> i) & 1) for i in range(k_lin)], tbl, max_xl_rounds=5, verify_subst=False
        )
        if not bres["closed_unsat"]:
            target_br, target_bmask = bres, bmask
            break

    # Build b_tt for this cell
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb

    print(f"[{cell_name}] Target branch {target_bmask:0{k_lin}b}: N_act={target_br['N_active']}, "
          f"q={target_br['n_quad_surviving']}, c={target_br['n_genuine_cubics']}", flush=True)

    # --------------------------------------------------------------------------
    # PART 1: Uniserial Chain E_9 < E_10 < E_11 < E_12 < E_13 < E_14 Avalanche Curve!
    # --------------------------------------------------------------------------
    rng = random.Random(2026111813)
    ek_results = []
    for k in (9, 10, 11, 12, 13, 14):
        ek_forms_raw = extract_linear_forms_on_pts(b_tt, E_sets[k])
        free_f = reduce_forms_modulo_lin_pivs(ek_forms_raw, target_br["_lin_pivs"])
        nf = len(free_f)
        n_trials = 12
        cl_cnt, sum_q, max_q, sum_l, max_l, sum_c = 0, 0, 0, 0, 0, 0
        for tr in range(n_trials):
            vals = [rng.randint(0, 1) for _ in range(nf)]
            if cell_name == "B0_00" and sum(vals) == 0 and nf > 0:
                vals[0] = 1
            eqs = [(free_f[i][0], vals[i]) for i in range(nf)]
            sr = s9.run_branch_cascade(
                lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"], target_br["_lin_pivs"],
                eqs, tbl, max_xl_rounds=5, verify_subst=False
            )
            if sr["closed_unsat"]:
                cl_cnt += 1
            else:
                q = sr["n_quad_surviving"]
                l = sr["total_lin_dropped"]
                c = sr["n_genuine_cubics"]
                sum_q += q; max_q = max(max_q, q)
                sum_l += l; max_l = max(max_l, l)
                sum_c += c
        surv = n_trials - cl_cnt
        entry = {
            "E_k": k, "raw_rank": len(ek_forms_raw), "free_forms_in_branch": nf,
            "N_rem_init": target_br["N_active"] - nf,
            "closed_of_12": cl_cnt,
            "avg_quads": round(sum_q / surv, 1) if surv else 0.0, "max_q": max_q,
            "avg_lin_drop": round(sum_l / surv, 1) if surv else 0.0, "max_l": max_l,
            "avg_cubs": round(sum_c / surv, 1) if surv else 0.0,
        }
        ek_results.append(entry)
        print(f"  [{cell_name}] E_{k:2d} (raw_rk={len(ek_forms_raw):2d}, free={nf:2d}, N_rem={target_br['N_active']-nf:2d}): "
              f"closed={cl_cnt:2d}/12, avg_q={entry['avg_quads']} (max={max_q}), avg_l={entry['avg_lin_drop']} (max={max_l}), avg_c={entry['avg_cubs']}", flush=True)

    # --------------------------------------------------------------------------
    # PART 2: On B0_11 (or any cell where E_9 drops quads!), recursively split ALL 32 E_9 states!
    # --------------------------------------------------------------------------
    e9_raw = extract_linear_forms_on_pts(b_tt, E_sets[9])
    e9_free = reduce_forms_modulo_lin_pivs(e9_raw, target_br["_lin_pivs"])
    e9_cascade = None
    if len(e9_free) <= 6:
        tot_s = 1 << len(e9_free)
        d1_closed, d2_closed_states, total_open_leaves = 0, 0, 0
        sample_leaves = []
        for sm in range(tot_s):
            eqs = [(e9_free[i][0], (sm >> i) & 1) for i in range(len(e9_free))]
            sr = s9.run_branch_cascade(
                lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"], target_br["_lin_pivs"],
                eqs, tbl, max_xl_rounds=5, verify_subst=False
            )
            if sr["closed_unsat"]:
                d1_closed += 1
                continue
            if sr["n_quad_surviving"] == 0:
                total_open_leaves += 1
                if len(sample_leaves) < 5:
                    sample_leaves.append({"sm": sm, "N": sr["N_active"], "q": 0, "c": sr["n_genuine_cubics"]})
                continue
            # Recursively linearize dropped quadratics (depth up to 4)!
            state_open = []
            def dfs_q(node, depth):
                if node["n_quad_surviving"] == 0 or depth >= 4 or len(state_open) >= 16:
                    state_open.append({"d": depth, "N": node["N_active"], "q": node["n_quad_surviving"], "c": node["n_genuine_cubics"]})
                    return
                qps = [s9.row_to_pset(node["_buf"], qr, tbl) for qr in node["_quad_ids"]]
                sf = s9.find_minimal_linearizers(qps, n)["linearizer_forms_111"][:3]
                if not sf:
                    state_open.append({"d": depth, "N": node["N_active"], "q": node["n_quad_surviving"]})
                    return
                for b2 in range(1 << len(sf)):
                    sub = s9.run_branch_cascade(
                        lib9, node["_buf"], node["_quad_ids"], node["_cub_ids"], node["_lin_pivs"],
                        [(sf[j], (b2 >> j) & 1) for j in range(len(sf))], tbl, max_xl_rounds=4, verify_subst=False
                    )
                    if not sub["closed_unsat"]:
                        dfs_q(sub, depth + 1)
            dfs_q(sr, 1)
            if len(state_open) == 0:
                d2_closed_states += 1
            else:
                total_open_leaves += len(state_open)
                if len(sample_leaves) < 5:
                    sample_leaves.append({"sm": sm, "open_cnt": len(state_open), "first": state_open[0]})
        e9_cascade = {
            "n_e9_free": len(e9_free), "total_states": tot_s,
            "d1_closed": d1_closed, "d2_recursively_closed_states": d2_closed_states,
            "total_open_leaves": total_open_leaves, "sample_leaves": sample_leaves,
        }
        print(f"[{cell_name}] PART 2 E_9 RECURSIVE CASCADE: {json.dumps(e9_cascade)}", flush=True)

    # --------------------------------------------------------------------------
    # PART 3: Single High-Symmetry D_8-Coset Scan (0x55+D8, 0x11+D8, 0x33+D8, 0x77+D8)
    # --------------------------------------------------------------------------
    D8 = np.array([v | (v << 8) for v in range(256)], dtype=np.uint16)
    coset_scan = []
    for a in (0x55, 0x11, 0x33, 0x77):
        cf_raw = extract_linear_forms_on_pts(b_tt, D8 ^ np.uint16(a))
        cf_free = reduce_forms_modulo_lin_pivs(cf_raw, target_br["_lin_pivs"])
        nf = len(cf_free)
        cl_c, max_q, sum_q, max_l = 0, 0, 0, 0
        for _ in range(8):
            vals = [rng.randint(0, 1) for _ in range(nf)]
            if cell_name == "B0_00" and sum(vals) == 0 and nf > 0:
                vals[0] = 1
            sr = s9.run_branch_cascade(
                lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"], target_br["_lin_pivs"],
                [(cf_free[i][0], vals[i]) for i in range(nf)], tbl, max_xl_rounds=4, verify_subst=False
            )
            if sr["closed_unsat"]:
                cl_c += 1
            else:
                max_q = max(max_q, sr["n_quad_surviving"])
                sum_q += sr["n_quad_surviving"]
                max_l = max(max_l, sr["total_lin_dropped"])
        entry = {"coset": f"0x{a:02x}+D8", "free_forms": nf, "closed_of_8": cl_c,
                 "avg_q": round(sum_q / max(1, 8 - cl_c), 1), "max_q": max_q, "max_l": max_l}
        coset_scan.append(entry)
        print(f"  [{cell_name}] Coset {entry['coset']} (free={nf:2d}): closed={cl_c}/8, avg_q={entry['avg_q']} (max={max_q}), max_l={max_l}", flush=True)

    summary = {
        "cell": cell_name, "branch": target_bmask, "N_act": target_br["N_active"],
        "uniserial_chain_E9_E14": ek_results,
        "e9_recursive_cascade": e9_cascade,
        "coset_scan": coset_scan,
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] STEP 13A SUMMARY: {json.dumps(summary)}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s13a_diag.c", WORK_DIR / "libs13a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s13a_s9.c", WORK_DIR / "libs13a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s13a_cg.c", WORK_DIR / "libs13a_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16),
            ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_uint64),
        ]

    orbits = diag_v2.build_orbits_116()
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb: mon_to_orb_arr[m] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)
    E_sets = build_ek_sets()

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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step13a_cell(
            cname, lib_diag, lib9, lib_cg, orbits, orb_tt_np, E_sets,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
