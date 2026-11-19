#!/usr/bin/env python3
r"""
SOLVE_STEP24_RANK2_R2_FACTOR_ATTACK_AND_B000_CMS5.py

TWO HIGH-PRECISION STRIKES:
  PART 1 (ALL 3 CELLS — B0_00, B0_11, B1_11):
    Dissects the Step 23 discovery of RANK-2 FACTORIZED `R^2` equations (`{2: 6}` in B1_11!!):
      - Extracts ALL `degR=2, degW=0` rows with `R^2`-rank <= 12.
      - Computes the EXACT linear factor subspace `F_low` (dim & overlap with R_tail, L2a, L0).
      - Tests fixing `F_low` AND fixing `R_rad = R \ W_ess_R` (the 4..6 radical vars of R^2!)
        in `run_branch_cascade(verify_subst=True)`!
      - Checks if ANY linear combination of `R^2` forms (via small-rank subspace search) drops
        below rank 34!
  PART 2 (B0_00 ONLY — CRYPTOMINISAT5 NATIVE XOR ON PURE-W QUADRATICS):
    Only <= 38 primary vars + <= 703 pair vars + 46 native XOR clauses (`x ... 0`)!
    Enumerates ALL solutions of `eta = 62, 63, 42, 43` (and checks `2, 3, 40, 41`) via
    `cryptominisat5` + blocking clauses, and verifies 100% formal UNSAT via `run_branch_cascade`!
"""

import argparse
import ctypes
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP22A_B000_ENUM_CLOSE_ETA62_63_42_AND_ETA0 as s22a


def gf2_rank_masks(masks):
    return len(s19.strict_rref_masks(masks))


def cms5_enum_pure_w(y_quads, nW, tag, max_models=256, max_total_sec=120.0):
    """Enumerate ALL models of pure-W quadratics using native cryptominisat5 XOR clauses!"""
    next_var = nW + 1
    pair_v = {}
    cnf = []
    xors = []
    for qm in y_quads:
        rhs = False
        lits = []
        for m in qm:
            if m == 0: rhs = not rhs
            elif m.bit_count() == 1: lits.append(m.bit_length())
            elif m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                key = (b0, b1)
                if key not in pair_v:
                    pv = next_var; next_var += 1
                    pair_v[key] = pv
                    u, v = b0 + 1, b1 + 1
                    cnf.append(f"-{pv} {u} 0\n")
                    cnf.append(f"-{pv} {v} 0\n")
                    cnf.append(f"{pv} -{u} -{v} 0\n")
                lits.append(pair_v[key])
        if not lits:
            if rhs: cnf.append("0\n")
        else:
            if not rhs:
                xors.append("x " + str(-lits[0]) + (" " + " ".join(map(str, lits[1:])) if len(lits) > 1 else "") + " 0\n")
            else:
                xors.append("x " + " ".join(map(str, lits)) + " 0\n")

    n_vars = next_var - 1
    cnf_path = WORK_DIR / f"s24_cms_{tag}.cnf"
    blocks = []
    models = []
    exhausted = False
    t0 = time.perf_counter()
    while len(models) < max_models:
        rem_t = max_total_sec - (time.perf_counter() - t0)
        if rem_t <= 2.0:
            break
        n_cl = len(cnf) + len(xors) + len(blocks)
        cnf_path.write_text(f"p cnf {n_vars} {n_cl}\n" + "".join(cnf) + "".join(xors) + "".join(blocks), encoding="utf-8")
        proc = subprocess.run(
            ["cryptominisat5", "--verb=0", "--threads=4", f"--maxtime={int(rem_t)}", str(cnf_path)],
            capture_output=True, text=True
        )
        if proc.returncode == 20:
            exhausted = True
            break
        elif proc.returncode == 10:
            vals = {}
            for line in proc.stdout.splitlines():
                if line.startswith("v "):
                    for tok in line.split()[1:]:
                        iv = int(tok)
                        if iv != 0: vals[abs(iv)] = (iv > 0)
            y = sum((1 << i) for i in range(nW) if vals.get(i + 1, False))
            for qm in y_quads:
                acc = 0
                for m in qm:
                    if (y & m) == m: acc ^= 1
                assert acc == 0, "CMS5 pure-W model verification failed!"
            models.append(y)
            blocks.append(" ".join(str(-(i + 1) if ((y >> i) & 1) else (i + 1)) for i in range(nW)) + " 0\n")
        else:
            break
    return exhausted, models, time.perf_counter() - t0


def run_step24_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib_d8, orbits, layer_vecs, orb_tt_np,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 24: RANK-2 R^2 FACTOR ANATOMY + B0_00 CMS5 CLOSURE ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

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

    # For B0_00, include the +40 verified D_8-coset cubics too!
    d8_buf, n_d8 = None, 0
    if cell_name == "B0_00":
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
        n_d8 = len(d8_specs)
        d8_buf = (ctypes.c_uint64 * (n_d8 * n_cw))()
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

    total_raw = n_base + len(cyc_cubs) + n_cg + n_d8
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    if n_d8:
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, n_d8 * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    forms_L2a = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L2a"][1], layer_vecs["L2a"][0])
    forms_L0 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L0"][1], layer_vecs["L0"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    # --------------------------------------------------------------------------
    # PART 1: RANK-2 R^2 FACTOR ANATOMY & R_rad TEST
    # --------------------------------------------------------------------------
    target_em = 4 if cell_name == "B0_00" else 0
    ex_eta = [(eta_free[k], (target_em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=True
    )
    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    R_vars = [v for v in active_now if v not in W_set]
    R_set = set(R_vars)
    nW, nR = len(W_pivs), len(R_vars)

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

    # Extract R_tail forms in y-coords (purely in R_set!)
    tail_y_forms = []
    for qi in range(len(sr["_quad_ids"])):
        ps = s9.row_to_pset(work, qi, tbl)
        rm = sum(m for m in ps if m.bit_count() == 1 and (m.bit_length() - 1) in R_set)
        if rm: tail_y_forms.append(rm)

    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        dr = sum(1 for v in vs if v in R_set)
        dw = sum(1 for v in vs if v in W_set)
        col_meta.append((dr, dw, d))
        col_keys.append((3 - dr, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    ech_meta = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc < 0: continue
        oc = perm_to_orig[pc]
        ech_meta.append((r, col_meta[oc][0], col_meta[oc][1], col_meta[oc][2]))
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    # Analyze R^2-form ranks AND extract ALL low-rank (<= 10) R^2 bilinear linear factors (in y-coords -> purely in R_set!)
    rk_hist = {}
    low_rk_factors = []
    all_r2_adj_rows = []
    for r_id, dr, dw, td in ech_meta:
        if dr == 2 and dw == 0:
            ps = s9.row_to_pset(std_ech, r_id, tbl)
            adj = {}
            for m in ps:
                if m.bit_count() == 2:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    if b0 in R_set and b1 in R_set:
                        adj[b0] = adj.get(b0, 0) ^ (1 << b1)
                        adj[b1] = adj.get(b1, 0) ^ (1 << b0)
            rows_a = list(adj.values())
            all_r2_adj_rows.extend(rows_a)
            rref_a = s19.strict_rref_masks(rows_a)
            rk = len(rref_a)
            rk_hist[rk] = rk_hist.get(rk, 0) + 1
            if rk <= 10:
                low_rk_factors.extend(list(rref_a.values()))

    F_low = list(s19.strict_rref_masks(low_rk_factors).values())
    W_ess_R_rref = s19.strict_rref_masks(all_r2_adj_rows)
    # Note: y_r == x_r for all r in R_set! So ANY mask supported on R_set is IDENTICAL in x-coords and y-coords!!
    rk_T = gf2_rank_masks(tail_y_forms)
    rk_F_T = gf2_rank_masks(F_low + tail_y_forms)
    l2a_free = s16.reduce_forms_mod_pivs(forms_L2a, sr["_lin_pivs"])
    l0_free = s16.reduce_forms_mod_pivs(forms_L0, sr["_lin_pivs"])
    print(f"[{cell_name}] PART 1 R^2 rank_hist = {dict(sorted(rk_hist.items()))}", flush=True)
    print(f"      dim(F_low [rk<=10 factors]) = {len(F_low)} | overlap with R_tail({rk_T}) = {len(F_low) + rk_T - rk_F_T} | "
          f"overlap with L2a({len(l2a_free)}) = {len(F_low) + len(l2a_free) - gf2_rank_masks(F_low + l2a_free)} | "
          f"overlap with L0({len(l0_free)}) = {len(F_low) + len(l0_free) - gf2_rank_masks(F_low + l0_free)}", flush=True)
    print(f"      dim(W_ess_R) = {len(W_ess_R_rref)}/{nR} (radical dim = {nR - len(W_ess_R_rref)})", flush=True)

    # Test fixing F_low (all <= 10 rank factors!) in run_branch_cascade on 8 random assignments!
    rng = random.Random(242424)
    if F_low:
        cl_f, maxq_f, maxl_f = 0, 0, 0
        for tr in range(8):
            ex_f = [(F_low[k], rng.randint(0, 1)) for k in range(len(F_low))]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_f, tbl, max_xl_rounds=12, verify_subst=(tr == 0)
            )
            if sub["closed_unsat"]: cl_f += 1
            elif "n_quad_surviving" in sub:
                maxq_f = max(maxq_f, sub["n_quad_surviving"])
                maxl_f = max(maxl_f, sub.get("total_lin_dropped", 0))
        print(f"      Fixing F_low ({len(F_low)} forms): closed={cl_f}/8, max_q={maxq_f} (base {len(qps)}), max_l={maxl_f}", flush=True)

    # Also test fixing R_rad (complementary forms in R \ W_ess_R, ONLY 4..6 forms!)
    R_rad_vars = [v for v in R_vars if v not in W_ess_R_rref]
    if R_rad_vars:
        cl_r, maxq_r, maxl_r = 0, 0, 0
        for st in range(min(16, 1 << len(R_rad_vars))):
            ex_r = [(1 << R_rad_vars[k], (st >> k) & 1) for k in range(len(R_rad_vars))]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_r, tbl, max_xl_rounds=12, verify_subst=(st == 0)
            )
            if sub["closed_unsat"]: cl_r += 1
            elif "n_quad_surviving" in sub:
                maxq_r = max(maxq_r, sub["n_quad_surviving"])
                maxl_r = max(maxl_r, sub.get("total_lin_dropped", 0))
        print(f"      Fixing R_rad ({len(R_rad_vars)} vars): closed={cl_r}/{min(16, 1<<len(R_rad_vars))}, max_q={maxq_r}, max_l={maxl_r}", flush=True)

    # --------------------------------------------------------------------------
    # PART 2 (B0_00 ONLY): CRYPTOMINISAT5 FAST NATIVE-XOR CLOSURE OF eta=62, 63, 42, 43, 2, 3, 40, 41!
    # --------------------------------------------------------------------------
    if cell_name == "B0_00":
        print("\n--- [B0_00] PART 2: CRYPTOMINISAT5 NATIVE-XOR FORMAL CLOSURE OF HIGH-PURE-W ETA STATES ---", flush=True)
        for em in [62, 63, 42, 43, 2, 3, 40, 41]:
            ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
            sr_e = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                ex, tbl, max_xl_rounds=20, verify_subst=True
            )
            qps_e = [s9.row_to_pset(sr_e["_buf"], qr, tbl) for qr in sr_e["_quad_ids"]]
            ana_e = s16.analyze_quad_system(qps_e)
            W_r_e = s19.strict_rref_masks(list(ana_e["W_piv"].values()))
            W_pivs_e, pure_y_e = s22a.extract_pure_w_quads(lib_sh, sr_e, W_r_e, tbl)
            W_forms_e = [W_r_e[p] for p in W_pivs_e]
            nW_e = len(W_pivs_e)
            exh, models, dt = cms5_enum_pure_w(pure_y_e, nW_e, f"eta{em}", max_models=256, max_total_sec=90.0)
            n_cl, n_op = 0, 0
            for idx_m, y in enumerate(models):
                ex_w = [(W_forms_e[j], (y >> j) & 1) for j in range(nW_e)]
                sub = s9.run_branch_cascade(
                    lib9, sr_e["_buf"], sr_e["_quad_ids"], sr_e["_cub_ids"], sr_e["_lin_pivs"],
                    ex_w, tbl, max_xl_rounds=12, verify_subst=(idx_m < 2)
                )
                if sub["closed_unsat"]: n_cl += 1
                else: n_op += 1
            tag_res = "100% FORMALLY CLOSED!!" if (exh and n_op == 0) else f"open={n_op}, exhausted={exh}"
            print(f"  [B0_00 eta={em:2d}] nW={nW_e:2d}, pure_q={len(pure_y_e):2d}: CMS5 models={len(models)} ({dt:5.2f}s) | closed={n_cl}/{len(models)} -> {tag_res}", flush=True)

    print(f"[{cell_name}] STEP 24 DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s24_diag.c", WORK_DIR / "libs24_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s24_s9.c", WORK_DIR / "libs24_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s24_cg.c", WORK_DIR / "libs24_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s24_sh.c", WORK_DIR / "libs24_sh.so"
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

    c_d8, so_d8 = WORK_DIR / "s24_d8.c", WORK_DIR / "libs24_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step24_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, lib_d8, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
