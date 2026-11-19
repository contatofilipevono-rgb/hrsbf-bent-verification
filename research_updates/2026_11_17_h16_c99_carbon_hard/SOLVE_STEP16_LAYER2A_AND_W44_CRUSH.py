#!/usr/bin/env python3
r"""
SOLVE_STEP16_LAYER2A_AND_W44_CRUSH.py

EXPLOITS THE STEP 15 DISCOVERY:
  Fixing Layer 1 (deg_u=3, deg_z=1 -> eta, 6 free bits = 64 states):
    - B0_00: 16/64 CLOSED immediately! Remaining 47 non-zero states have 11..41 QUADRATICS!
    - B0_11 & B1_11: 64/64 states jump to 17 QUADRATICS living inside a CLOSED 44..45-dim
      essential subspace W_45 (NOT 101 vars!!).

STEP 16 TESTS THREE MASSIVE CONSEQUENCES ON B0_00, B0_11, B1_11:
  PART 1 (ALL 3 CELLS): Exact anatomy of the 17..41 quadratics on surviving eta-states:
    - Separates pure W_ess quadratics (zero radical linear tail!) vs quadratics with radical linear tails.
    - Runs exact dim_W_ess & top-variable inspection on B0_00's q=41, q=23, q=21, q=17 states (skipping q=0!).
  PART 2 (THE LAYER-2A FILTRATION BOMB — ALL 3 CELLS):
    - Extracts Layer 2a = (deg_u=2, deg_z=1) linear forms of f(u, u+z) (raw rank 14 -> only ~7 extra
      bits on top of eta!).
    - Measures overlap of Layer 2a with W_ess (the 44-dim quadratic support)!
    - Exhaustively tests ALL 2^{n_2a} (<= 128) states of Layer 2a on top of eta-state[0] (and a non-zero
      eta-state in B0_00!): checks how many CLOSE to 1=0, how many NEW linears drop, and how many
      NEW quadratics drop from the 370 cubics!
  PART 3 (LAYER 2 FULL FILTRATION — deg_u=2, deg_z=2):
    - Checks what happens when fixing subsets of the remaining Layer 2 (deg_u=2) variables (the exact
      W_44 subspace!) on top of eta + Layer 2a!
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
import SOLVE_STEP14_ETA128_SPLIT_ON_CG389 as s14


def build_orb_degu_degz_vecs(orbits):
    """For each orbit j in 0..115, expand f_j(u, u+z) and return bit-vectors for:
       - L1:  (deg_u=3, deg_z=1)  [eta, raw rank 8 -> 7 in 111]
       - L2a: (deg_u=2, deg_z=1)  [raw rank 14 in 111]
       - L2b: (deg_u=2, deg_z=2)  [raw rank 55 in 111]
       - L0:  (deg_u=0, deg_z=4)  [raw rank 35 in 111]
    """
    sets_by_tag = {t: [set() for _ in range(116)] for t in ("L1", "L2a", "L2b", "L0")}
    for j, orb in enumerate(orbits):
        for m in orb:
            bits = [b for b in range(16) if (m >> b) & 1]
            terms = [(0, 0)]
            for b in bits:
                if b < 8:
                    ub = 1 << b
                    terms = [(um | ub, zm) for (um, zm) in terms]
                else:
                    k = b - 8
                    ub, zb = 1 << k, 1 << k
                    nt = []
                    for (um, zm) in terms:
                        nt.append((um | ub, zm))
                        nt.append((um, zm | zb))
                    terms = nt
            for (um, zm) in terms:
                du, dz = um.bit_count(), zm.bit_count()
                key = (um << 8) | zm
                tag = None
                if du == 3 and dz == 1: tag = "L1"
                elif du == 2 and dz == 1: tag = "L2a"
                elif du == 2 and dz == 2: tag = "L2b"
                elif du == 0 and dz == 4: tag = "L0"
                if tag is not None:
                    s = sets_by_tag[tag][j]
                    if key in s: s.remove(key)
                    else: s.add(key)

    out = {}
    for tag, slist in sets_by_tag.items():
        all_keys = sorted(set().union(*slist))
        km = {k: idx for idx, k in enumerate(all_keys)}
        vecs = [0] * 116
        for j in range(116):
            v = 0
            for k in slist[j]:
                v |= (1 << km[k])
            vecs[j] = v
        out[tag] = (len(all_keys), vecs)
    return out


def extract_forms_from_orb_vecs(cb111, orb_vecs, n_coords):
    basis_v = []
    for cm in cb111:
        v = 0
        while cm:
            lb = cm & -cm; v ^= orb_vecs[lb.bit_length() - 1]; cm ^= lb
        basis_v.append(v)
    piv, forms = {}, []
    for bit in range(n_coords):
        fm = sum((1 << i) for i in range(111) if (basis_v[i] >> bit) & 1)
        if fm == 0: continue
        rem = fm
        while rem:
            b = rem.bit_length() - 1
            if b in piv: rem ^= piv[b]
            else: piv[b] = rem; forms.append(fm); break
    return forms


def reduce_forms_mod_pivs(forms, lin_pivs):
    free, piv = [], {}
    for fm in forms:
        m = fm
        for p, (pv, pr) in lin_pivs.items():
            if (m >> p) & 1: m ^= pv
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in piv: rem ^= piv[b]
            else: piv[b] = rem; free.append(m); break
    return free


def analyze_quad_system(qps):
    """Analyze bilinear essential subspace W_ess AND how many quads have ZERO linear terms outside W_ess!"""
    img_piv = {}
    quad_vars = set()
    for ps in qps:
        adj = {}
        for m in ps:
            if m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                quad_vars.add(b0); quad_vars.add(b1)
                adj[b0] = adj.get(b0, 0) ^ (1 << b1)
                adj[b1] = adj.get(b1, 0) ^ (1 << b0)
        for row in adj.values():
            x = row
            while x:
                b = x.bit_length() - 1
                if b in img_piv: x ^= img_piv[b]
                else: img_piv[b] = x; break
    # Also check how many quads have linear terms outside img_piv (i.e. in radical)!
    # A linear vector l is in W_ess iff reducing l by img_piv gives 0!
    lin_tails_outside = []
    pure_in_W = 0
    for ps in qps:
        lmask = 0
        for m in ps:
            if m.bit_count() == 1:
                lmask |= m
        rem = lmask
        while rem:
            b = rem.bit_length() - 1
            if b in img_piv: rem ^= img_piv[b]
            else: break
        if rem == 0:
            pure_in_W += 1
        else:
            lin_tails_outside.append(rem)
    # Rank of radical linear tails!
    tail_piv = {}
    for t in lin_tails_outside:
        x = t
        while x:
            b = x.bit_length() - 1
            if b in tail_piv: x ^= tail_piv[b]
            else: tail_piv[b] = x; break
    return {
        "n_quads": len(qps),
        "dim_W_ess": len(img_piv),
        "n_vars_in_deg2_terms": len(quad_vars),
        "n_pure_in_W_ess": pure_in_W,
        "rank_radical_linear_tails": len(tail_piv),
        "W_piv": img_piv,
    }


def run_step16_cell(cell_name, lib_diag, lib9, lib_cg, orbits, layer_vecs,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 16: LAYER-2A (deg_u=2,deg_z=1) & W_44 CRUSH ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=False)

    # Extract L1 (eta), L2a (deg_u=2, deg_z=1), L2b (deg_u=2, deg_z=2), L0 (deg_u=0, deg_z=4) forms!
    forms_L1 = extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    forms_L2a = extract_forms_from_orb_vecs(cb111, layer_vecs["L2a"][1], layer_vecs["L2a"][0])
    forms_L2b = extract_forms_from_orb_vecs(cb111, layer_vecs["L2b"][1], layer_vecs["L2b"][0])
    forms_L0 = extract_forms_from_orb_vecs(cb111, layer_vecs["L0"][1], layer_vecs["L0"][0])

    eta_free = reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)
    tot_eta = 1 << n_ef

    # Pick representative surviving eta states (in B0_00, scan all 64 and pick the q=41, q=23, q=17, and q=0 states!)
    chosen_states = []
    if cell_name == "B0_00":
        by_q = {}
        for em in range(tot_eta):
            ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
            sr = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                ex, tbl, max_xl_rounds=20, verify_subst=False
            )
            if not sr["closed_unsat"] and "n_quad_surviving" in sr:
                q = sr["n_quad_surviving"]
                if q not in by_q:
                    by_q[q] = (em, sr)
        for q_val in sorted(by_q.keys(), reverse=True):
            chosen_states.append(by_q[q_val])
        print(f"[B0_00] Distinct surviving q levels across 64 eta-states: {sorted(by_q.keys(), reverse=True)}", flush=True)
    else:
        for em in (0, 1):
            ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
            sr = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                ex, tbl, max_xl_rounds=20, verify_subst=False
            )
            if not sr["closed_unsat"]:
                chosen_states.append((em, sr))

    # PART 1: Exact W_ess anatomy for each chosen eta state!
    part1_rep = []
    for em, sr in chosen_states:
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        ana = analyze_quad_system(qps)
        # Check overlap between W_piv and L2a, L2b, L0!
        l2a_free = reduce_forms_mod_pivs(forms_L2a, sr["_lin_pivs"])
        l2b_free = reduce_forms_mod_pivs(forms_L2b, sr["_lin_pivs"])
        l0_free = reduce_forms_mod_pivs(forms_L0, sr["_lin_pivs"])
        # How many of l2a_free lie INSIDE W_ess?
        W_piv = ana["W_piv"]
        l2a_in_W = 0
        for fm in l2a_free:
            rem = fm
            while rem:
                b = rem.bit_length() - 1
                if b in W_piv: rem ^= W_piv[b]
                else: break
            if rem == 0: l2a_in_W += 1
        rec = {
            "eta": em, "N": sr["N_active"], "q": ana["n_quads"], "c": sr["n_genuine_cubics"],
            "dim_W_ess": ana["dim_W_ess"], "n_vars_deg2": ana["n_vars_in_deg2_terms"],
            "pure_in_W_ess": ana["n_pure_in_W_ess"], "rank_rad_lin_tails": ana["rank_radical_linear_tails"],
            "l2a_free": len(l2a_free), "l2a_in_W": l2a_in_W, "l2b_free": len(l2b_free), "l0_free": len(l0_free),
        }
        part1_rep.append(rec)
        print(f"  [{cell_name}] PART 1 eta={em:0{n_ef}b}: {json.dumps(rec)}", flush=True)

    # PART 2: THE LAYER-2A BOMB! Test ALL states of L2a (<= 128 states) on top of chosen_states[0] (and q=0 if B0_00!)
    targets_p2 = [chosen_states[0]]
    if cell_name == "B0_00" and chosen_states[-1][1]["n_quad_surviving"] == 0:
        targets_p2.append(chosen_states[-1])

    part2_rep = []
    rng = random.Random(2026111916)
    for em, sr in targets_p2:
        l2a_free = reduce_forms_mod_pivs(forms_L2a, sr["_lin_pivs"])
        n2a = len(l2a_free)
        tot_2a = 1 << n2a
        # Cap exhaustive test to 128 states (or sample 64 if n2a > 7)
        if tot_2a <= 128:
            masks = list(range(tot_2a))
        else:
            masks = [rng.getrandbits(n2a) for _ in range(64)]
            if cell_name == "B0_00":
                masks[0] = 1  # ensure non-zero
        cl_2a, q_h, l_h, n_h, w_sample = 0, {}, {}, {}, []
        for mk in masks:
            ex = [(l2a_free[k], (mk >> k) & 1) for k in range(n2a)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex, tbl, max_xl_rounds=15, verify_subst=(mk == masks[0])
            )
            if sub["closed_unsat"]:
                cl_2a += 1
            elif "n_quad_surviving" in sub:
                q = sub["n_quad_surviving"]; l = sub["total_lin_dropped"]; na = sub["N_active"]
                q_h[q] = q_h.get(q, 0) + 1
                l_h[l] = l_h.get(l, 0) + 1
                n_h[na] = n_h.get(na, 0) + 1
                if len(w_sample) < 3 and q > 0:
                    sqps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
                    sa = analyze_quad_system(sqps)
                    w_sample.append({"mk": mk, "N": na, "q": q, "c": sub["n_genuine_cubics"],
                                     "dim_W": sa["dim_W_ess"], "pure_W": sa["n_pure_in_W_ess"],
                                     "rad_tails": sa["rank_radical_linear_tails"]})
        p2 = {
            "eta": em, "init_q": sr["n_quad_surviving"], "n2a_free": n2a, "tested": len(masks),
            "closed": cl_2a, "q_hist": q_h, "l_hist": l_h, "N_hist": n_h, "sample_W": w_sample,
        }
        part2_rep.append(p2)
        print(f"  [{cell_name}] PART 2 LAYER-2A (eta={em:0{n_ef}b}, init_q={sr['n_quad_surviving']}, n2a={n2a}): {json.dumps(p2)}", flush=True)

    # PART 3: Test fixing L0 (deg_u=0, deg_z=4, 35 forms) AND fixing partial L2b (10, 20, 30, 40, 45 forms of W_ess!)
    em0, sr0 = chosen_states[0]
    l2b_free = reduce_forms_mod_pivs(forms_L2b, sr0["_lin_pivs"])
    l0_free = reduce_forms_mod_pivs(forms_L0, sr0["_lin_pivs"])
    part3_rep = {}
    for label, flist, ks in [
        ("L2b_prefix", l2b_free, [10, 20, 30, 40, min(48, len(l2b_free))]),
        ("L0_prefix", l0_free, [10, 20, min(35, len(l0_free))]),
    ]:
        curve = []
        for kf in ks:
            if kf <= 0 or kf > len(flist): continue
            cl_c, qs, ls, ns = 0, [], [], []
            for _ in range(6):
                ex = [(flist[k], rng.randint(0, 1)) for k in range(kf)]
                sub = s9.run_branch_cascade(
                    lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
                    ex, tbl, max_xl_rounds=12, verify_subst=False
                )
                if sub["closed_unsat"]: cl_c += 1
                elif "n_quad_surviving" in sub:
                    qs.append(sub["n_quad_surviving"]); ls.append(sub["total_lin_dropped"]); ns.append(sub["N_active"])
            curve.append({
                "k": kf, "closed_of_6": cl_c,
                "max_q": max(qs) if qs else 0, "avg_q": round(sum(qs)/len(qs), 1) if qs else 0,
                "max_l": max(ls) if ls else 0, "min_N": min(ns) if ns else 0,
            })
        part3_rep[label] = curve
        print(f"  [{cell_name}] PART 3 {label} on eta={em0:0{n_ef}b}: {curve}", flush=True)

    summary = {
        "cell": cell_name, "part1": part1_rep, "part2": part2_rep, "part3": part3_rep,
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] STEP 16 SUMMARY: {json.dumps(summary)}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s16_diag.c", WORK_DIR / "libs16_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s16_s9.c", WORK_DIR / "libs16_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s16_cg.c", WORK_DIR / "libs16_cg.so"
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
    layer_vecs = build_orb_degu_degz_vecs(orbits)
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step16_cell(
            cname, lib_diag, lib9, lib_cg, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
