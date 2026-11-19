#!/usr/bin/env python3
r"""
SOLVE_STEP15_ETA_17QUAD_CRUSH.py

EXPLOITS THE MASSIVE STEP 14A BREAKTHROUGH:
  Fixing just the 6 free bits of the diagonal-autocorrelation quotient eta(c) (64 states total!)
  shattered the 388-cubic wall in ALL THREE open cells:
    - B0_11: 64/64 states dropped +2 linears and jumped from 4 -> 17 QUADRATICS!
    - B1_11: 64/64 states dropped +2 linears and jumped from 4 -> 17 QUADRATICS!
    - B0_00: triggered a 5+ round runaway cascade (exceeded max_xl_rounds=5)!

STEP 15 DOES:
  1. Runs root x all 64 eta-states with max_xl_rounds=20 (zero-trust verified subst on first state!).
  2. Diagnoses the exact symplectic structure of the 17+ new quadratics (dim_W_ess, k_lin,
     linearizer forms!) on the surviving eta-states.
  3. Runs a recursive symplectic cascade on the 17+ quadratics (first deeply on eta-states 0..3
     to measure closure rate / depth / new linear & quad drops, and then across ALL 64 eta-states
     if branching is tractable!).
  4. ALSO tests combining eta(c) + the 4 extra linear forms of (0xFF + D_8) (16 states!) on
     state 0 to check if (eta U 0xFF+D_8) drops even more quadratics/linears or closes to 1=0!
"""

import argparse
import ctypes
import json
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


def quad_symplectic_dim_and_linearizers(qps, n):
    """Compute exact essential bilinear space dimension dim_W_ess and minimal linearizers
    (falls back cleanly to greedy linearizer if dim_W_ess > 8)."""
    # Build alternating bilinear matrices in 111-var space
    # Find essential variable support / bilinear image span
    img_piv = {}
    for ps in qps:
        # Build adjacency rows for this quad
        adj = {}
        for m in ps:
            if m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                adj[b0] = adj.get(b0, 0) ^ (1 << b1)
                adj[b1] = adj.get(b1, 0) ^ (1 << b0)
        for v, row in adj.items():
            x = row
            while x:
                b = x.bit_length() - 1
                if b in img_piv: x ^= img_piv[b]
                else: img_piv[b] = x; break
    dim_W = len(img_piv)
    if dim_W <= 8:
        li = s9.find_minimal_linearizers(qps, n)
        return dim_W, li["linearizer_forms_111"], "exact"
    # If dim_W > 8, greedily pick linear forms that appear in the most degree-2 monomials
    # or pick minimal linearizers of the first 4 quadratics / highest-frequency variables!
    freq = {}
    for ps in qps:
        for m in ps:
            if m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                freq[b0] = freq.get(b0, 0) + 1
                freq[b1] = freq.get(b1, 0) + 1
    top_vars = sorted(freq.keys(), key=lambda v: -freq[v])
    # Also try exact linearizer of top-4 quadratics with smallest support!
    # Return top 4 hub variable linear forms + exact linearizer of first 2 quads!
    li2 = s9.find_minimal_linearizers(qps[:2], n)
    forms = li2["linearizer_forms_111"]
    if not forms:
        forms = [1 << v for v in top_vars[:3]]
    return dim_W, forms, f"partial_q2(top_var_freq={freq[top_vars[0]] if top_vars else 0})"


def run_step15_cell(cell_name, lib_diag, lib9, lib_cg, orbits, orb_eta, orb_tt_np,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 15: ETA-64 -> 17+ QUAD SYMPLECTIC CRUSH ====================", flush=True)
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=False)

    # Extract 7 eta forms in 111-var space
    basis_eta = []
    for cm in cb111:
        v = 0
        while cm:
            lb = cm & -cm; v ^= orb_eta[lb.bit_length() - 1]; cm ^= lb
        basis_eta.append(v)
    piv, eta_forms_111 = {}, []
    for bit in range(280):
        fm = sum((1 << i) for i in range(111) if (basis_eta[i] >> bit) & 1)
        if fm == 0: continue
        rem = fm
        while rem:
            b = rem.bit_length() - 1
            if b in piv: rem ^= piv[b]
            else: piv[b] = rem; eta_forms_111.append(fm); break
    assert len(eta_forms_111) == 7

    root_eta_free, rp = [], {}
    for fm in eta_forms_111:
        m = fm
        for p, (pv, pr) in root["_lin_pivs"].items():
            if (m >> p) & 1: m ^= pv
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in rp: rem ^= rp[b]
            else: rp[b] = rem; root_eta_free.append(m); break
    n_ef = len(root_eta_free)
    tot_eta = 1 << n_ef
    print(f"[{cell_name}] Root N={root['N_active']}, q={root['n_quad_surviving']}, c={root['n_genuine_cubics']}; "
          f"eta_free={n_ef} ({tot_eta} states)", flush=True)

    # 1. Run ALL 64 eta-states with max_xl_rounds=20 (zero-trust verify subst on em=0!)
    eta_closed = 0
    eta_hit_max = 0
    eta_surv_states = []
    q_hist, l_hist, n_hist = {}, {}, {}

    for em in range(tot_eta):
        ex = [(root_eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=(em == 0)
        )
        if sr["closed_unsat"]:
            eta_closed += 1
        elif "n_quad_surviving" not in sr:
            eta_hit_max += 1
            print(f"  [{cell_name}] eta={em:0{n_ef}b} HIT MAX ROUNDS (20)!! logs={sr.get('round_logs', [])[-3:]}", flush=True)
        else:
            q = sr["n_quad_surviving"]
            l = sr["total_lin_dropped"]
            na = sr["N_active"]
            q_hist[q] = q_hist.get(q, 0) + 1
            l_hist[l] = l_hist.get(l, 0) + 1
            n_hist[na] = n_hist.get(na, 0) + 1
            if len(eta_surv_states) < 6:
                eta_surv_states.append((em, sr))

    print(f"[{cell_name}] ALL {tot_eta} ETA STATES ({time.perf_counter()-t0:.1f}s): "
          f"CLOSED={eta_closed}/{tot_eta}, hit_max={eta_hit_max}, q_hist={q_hist}, l_hist={l_hist}, N_hist={n_hist}", flush=True)

    # 2. Diagnose symplectic anatomy & run deep recursive split on the first 4 surviving eta states!
    diag_reports = []
    for em, sr in eta_surv_states[:4]:
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        dim_W, lforms, mode = quad_symplectic_dim_and_linearizers(qps, n)
        print(f"  [{cell_name}] eta={em:0{n_ef}b}: N={sr['N_active']}, q={len(qps)}, c={sr['n_genuine_cubics']}, "
              f"dim_W_ess={dim_W}, mode={mode}, n_lin_forms={len(lforms)}", flush=True)

        # Split by lforms[:4] (up to 16 sub-branches) and recurse up to depth 3 (node cap 120)!
        nodes, cl_l, op_l = 0, 0, []
        def dfs(node, depth):
            nonlocal nodes, cl_l
            nodes += 1
            if "n_quad_surviving" not in node or node["n_quad_surviving"] == 0 or depth >= 4 or nodes >= 80:
                op_l.append({
                    "d": depth, "N": node.get("N_active", -1),
                    "q": node.get("n_quad_surviving", -1), "c": node.get("n_genuine_cubics", -1),
                    "l_drop": node.get("total_lin_dropped", 0),
                })
                return
            nqps = [s9.row_to_pset(node["_buf"], qr, tbl) for qr in node["_quad_ids"]]
            dw, sfs, _ = quad_symplectic_dim_and_linearizers(nqps, n)
            use = sfs[:3]
            if not use:
                op_l.append({"d": depth, "N": node["N_active"], "q": node["n_quad_surviving"], "dw": dw})
                return
            for sm in range(1 << len(use)):
                if nodes >= 80:
                    op_l.append({"d": depth + 1, "trunc": True})
                    return
                sub = s9.run_branch_cascade(
                    lib9, node["_buf"], node["_quad_ids"], node["_cub_ids"], node["_lin_pivs"],
                    [(use[j], (sm >> j) & 1) for j in range(len(use))], tbl, max_xl_rounds=10, verify_subst=False
                )
                if sub["closed_unsat"]:
                    cl_l += 1
                else:
                    dfs(sub, depth + 1)

        dfs(sr, 1)
        rep = {
            "eta": em, "N": sr["N_active"], "q": len(qps), "dim_W_ess": dim_W, "mode": mode,
            "dfs_nodes": nodes, "dfs_closed": cl_l, "dfs_open": len(op_l), "sample_open": op_l[:5],
        }
        diag_reports.append(rep)
        print(f"    -> DFS(eta={em:0{n_ef}b}): nodes={nodes}, closed={cl_l}, open={len(op_l)}, sample={op_l[:3]}", flush=True)

    # 3. Also test (eta_state[0] + 0xFF+D_8 extra 4 forms) -> 16 states!
    ff_combo_rep = None
    if eta_surv_states:
        em0, sr0 = eta_surv_states[0]
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i, m in enumerate(cb111):
            tmp = m
            while tmp:
                lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
        D8 = np.array([v | (v << 8) for v in range(256)], dtype=np.uint16)
        pts_ff = D8 ^ np.uint16(0xFF)
        ff_free, fp = [], {}
        for x in pts_ff:
            m = sum((1 << i) for i in range(111) if b_tt[i, x])
            for p, (pv, pr) in sr0["_lin_pivs"].items():
                if (m >> p) & 1: m ^= pv
            rem = m
            while rem:
                b = rem.bit_length() - 1
                if b in fp: rem ^= fp[b]
                else: fp[b] = rem; ff_free.append(m); break
        n_ff = len(ff_free)
        fc_cl, fc_qh, fc_lh = 0, {}, {}
        for fm_mask in range(1 << min(n_ff, 5)):
            ex = [(ff_free[k], (fm_mask >> k) & 1) for k in range(min(n_ff, 5))]
            sub = s9.run_branch_cascade(
                lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
                ex, tbl, max_xl_rounds=10, verify_subst=False
            )
            if sub["closed_unsat"]:
                fc_cl += 1
            else:
                q = sub.get("n_quad_surviving", -1); l = sub.get("total_lin_dropped", 0)
                fc_qh[q] = fc_qh.get(q, 0) + 1
                fc_lh[l] = fc_lh.get(l, 0) + 1
        ff_combo_rep = {"eta0": em0, "ff_extra_free": n_ff, "closed": fc_cl, "q_hist": fc_qh, "l_hist": fc_lh}
        print(f"[{cell_name}] COMBO (eta0 + 0xFF+D8): {json.dumps(ff_combo_rep)}", flush=True)

    summary = {
        "cell": cell_name, "eta_free": n_ef, "eta_closed": eta_closed, "eta_hit_max": eta_hit_max,
        "q_hist": q_hist, "l_hist": l_hist, "N_hist": n_hist,
        "symplectic_dfs": diag_reports, "ff_combo": ff_combo_rep,
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] STEP 15 SUMMARY: {json.dumps(summary)}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s15_diag.c", WORK_DIR / "libs15_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s15_s9.c", WORK_DIR / "libs15_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s15_cg.c", WORK_DIR / "libs15_cg.so"
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
    orb_eta = s14.build_orb_eta(orbits)
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step15_cell(
            cname, lib_diag, lib9, lib_cg, orbits, orb_eta, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
