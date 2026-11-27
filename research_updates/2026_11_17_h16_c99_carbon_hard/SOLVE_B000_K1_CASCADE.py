#!/usr/bin/env python3
"""
SOLVE_B000_K1_CASCADE.py
C5-free full algebraic cascade (CG(389) + Q4 + D8 + Cyclotomic + V6xV6 + Rot4 + XL)
on B0_00, K=1 across all 16 Z_16^*-orbit representatives from A14:
  [1, 3, 9, 11, 21, 23, 29, 31, 33, 35, 41, 43, 53, 55, 61, 63]
Zero uncertified imports (NO proved_extra, NO unproved C5 K=0 assumption).
Includes built-in K=0 control check on shard 0.
"""

import argparse
import ctypes
import json
import subprocess
import sys
import time
from collections import defaultdict
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

ALL_K1_REPS = [1, 3, 9, 11, 21, 23, 29, 31, 33, 35, 41, 43, 53, 55, 61, 63]
A14_LMASK = [0x2, 0x4, 0x8, 0x1000, 0x2000, 0x4001, 0x1000000]


def xor_selected(values, select):
    res = 0
    while select:
        lb = select & -select
        res ^= values[lb.bit_length() - 1]
        select ^= lb
    return res


def build_a14_layer_forms(orbits):
    """Build exact bidegree (3,1) forms in f(u, u+z) matching A14 verify_h16_two_cuts_and_multipliers.py."""
    layers = defaultdict(int)
    for idx, orb in enumerate(orbits):
        for mon in orb:
            prod = [(0, 0)]
            for j in range(16):
                if (mon >> j) & 1:
                    k = j % 8
                    new_prod = [(u | (1 << k), z) for u, z in prod]
                    if j >= 8:
                        new_prod.extend((u, z | (1 << k)) for u, z in prod)
                    prod = new_prod
            for u, z in prod:
                if u.bit_count() == 3 and z.bit_count() == 1:
                    layers[(u, z)] ^= 1 << idx
    return [m for _, m in sorted(layers.items()) if m]


def compile_kernels(tag):
    c_diag, so_diag = WORK_DIR / f"{tag}_diag.c", WORK_DIR / f"lib{tag}_diag.so"
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

    c_s9, so_s9 = WORK_DIR / f"{tag}_s9.c", WORK_DIR / f"lib{tag}_s9.so"
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

    c_cg, so_cg = WORK_DIR / f"{tag}_cg.c", WORK_DIR / f"lib{tag}_cg.so"
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

    c_d8, so_d8 = WORK_DIR / f"{tag}_d8.c", WORK_DIR / f"lib{tag}_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]
    return lib_diag, lib9, lib_cg, lib_d8


def build_root(force_k, lib_diag, lib9, lib_cg, lib_d8, shared):
    orbits, v6_list, rot4_data, fiber_meta, tbl, cyc_cubs, cg_buf, n_cg, d8_buf, n_d8 = shared
    n_cw = tbl["n_col_words"]
    sys_data = diag_v2.build_cell_algebraic_system(
        "B0_00", lib_diag, orbits, v6_list, rot4_data, fiber_meta,
        extract_sec=18.0, force_k=force_k
    )
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + n_d8
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, n_d8 * n_cw * 8)
    root = s9.run_branch_cascade(
        lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl,
        max_xl_rounds=10, verify_subst=True
    )
    return root, sys_data["deg_pivs_111"]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--reps", type=str, default=",".join(map(str, ALL_K1_REPS)),
                    help="Comma-separated A14 e-reps to run")
    ap.add_argument("--run-control", action="store_true",
                    help="Also run K=0 control check (e=0 OPEN, known K=0 root-closed rep CLOSED)")
    ap.add_argument("--max-xl", type=int, default=25, help="Max XL cascade rounds per rep")
    ap.add_argument("--out", type=str, required=True, help="Output JSON path")
    args = ap.parse_args()

    t0 = time.perf_counter()
    reps = [int(x.strip()) for x in args.reps.split(",") if x.strip()]
    lib_diag, lib9, lib_cg, lib_d8 = compile_kernels(f"k1_{reps[0]}")

    orbits = diag_v2.build_orbits_116()
    a14_forms = build_a14_layer_forms(orbits)
    k_mask = sum(1 << j for j in diag_v2.K_INDICES)

    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)

    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1:
                row_mask |= (1 << m_idx)
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
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
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

    # Map A14 layer forms into 111-var masks
    a14_x111_forms = []
    for fm in a14_forms:
        xm = sum((1 << i) for i, cdir in enumerate(cb111) if (cdir & fm).bit_count() & 1)
        if xm:
            a14_x111_forms.append((fm, xm))

    # Extract 7 independent layer forms
    indep_forms = []
    piv_tmp = {}
    for fm, xm in a14_x111_forms:
        v = xm
        while v:
            b = v.bit_length() - 1
            if b in piv_tmp:
                v ^= piv_tmp[b]
            else:
                piv_tmp[b] = v
                indep_forms.append((fm, xm))
                break
    assert len(indep_forms) == 7, f"Expected 7 independent layer forms, got {len(indep_forms)}"

    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb

    seen_a, d8_specs = set(), []
    for a in range(1, 256):
        if a in seen_a:
            continue
        orb_a = [((a << sh) | (a >> (8 - sh))) & 0xFF for sh in range(8)]
        seen_a.update(orb_a)
        olen = len(set(orb_a))
        d8_specs.append((a, 3))
        if olen == 4:
            d8_specs.append((a, 4))
        elif olen == 2:
            d8_specs.append((a, 5))
        elif olen == 1:
            d8_specs.append((a, 6))

    d8_buf = (ctypes.c_uint64 * (len(d8_specs) * n_cw))()
    for idx_d, (a, sb) in enumerate(d8_specs):
        pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
        b_words = (ctypes.c_uint64 * (111 * 4))()
        for i in range(111):
            bits = b_tt[i, pts]
            for w in range(4):
                val = 0
                for b in range(64):
                    if bits[w * 64 + b]:
                        val |= (1 << b)
                b_words[i * 4 + w] = val
        rptr = ctypes.cast(ctypes.byref(d8_buf, idx_d * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_d8.extract_deg3_coset_poly(
            b_words, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
            tbl["col2_base"], tbl["col3_base"], rptr
        )

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    orb_map[115] = -1
    orb_map[99] = -1
    orb_map[57] = -1
    orb_map[113] = -1
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

    cyc_cubs = s9.extract_verified_cyclotomic_cubics("B0_00", orbits, origin111, cb111, layers, c0x0)
    shared = (orbits, v6_list, rot4_data, fiber_meta, tbl, cyc_cubs, cg_buf, n_cg, d8_buf, len(d8_specs))

    def layer_constraints_for_e(e_val):
        val_e = xor_selected(A14_LMASK, e_val)
        ex = []
        for fm, xm in indep_forms:
            rhs = ((val_e & fm).bit_count() ^ (origin111 & fm).bit_count()) & 1
            ex.append((xm, rhs))
        return val_e, ex

    out = {"controls": {}, "k1_root": {}, "reps": []}

    # Optional K=0 control check (reproduce e=0 OPEN and verify at least one K=0 rep CLOSED)
    if args.run_control:
        tc0 = time.perf_counter()
        root0, deg0 = build_root(0, lib_diag, lib9, lib_cg, lib_d8, shared)
        out["controls"]["k0_root"] = {
            "closed_unsat": bool(root0["closed_unsat"]),
            "root_lin_pivs": len(root0["_lin_pivs"]),
            "root_dim": 111 - len(root0["_lin_pivs"]),
            "root_quads": len(root0["_quad_ids"]),
            "root_cubs": len(root0["_cub_ids"]),
            "base_deg_pivs": deg0,
        }
        # Test e=0 (must be K=0 and OPEN, dim=102, q=0)
        val0, ex0 = layer_constraints_for_e(0)
        assert (val0 & k_mask).bit_count() % 2 == 0
        sr0 = s9.run_branch_cascade(
            lib9, root0["_buf"], root0["_quad_ids"], root0["_cub_ids"], root0["_lin_pivs"],
            ex0, tbl, max_xl_rounds=20, verify_subst=True
        )
        out["controls"]["k0_e0"] = {
            "closed_unsat": bool(sr0["closed_unsat"]),
            "dim": 0 if sr0["closed_unsat"] else 111 - len(sr0["_lin_pivs"]),
            "quads": 0 if sr0["closed_unsat"] else len(sr0["_quad_ids"]),
        }
        assert not sr0["closed_unsat"] and out["controls"]["k0_e0"]["dim"] == 102 and out["controls"]["k0_e0"]["quads"] == 0
        # Also test a known K=0 root-closed fiber (scan even e until one closes to verify CLOSED path works!)
        closed_ctrl = None
        for e_try in range(2, 128, 2):
            vt, ext = layer_constraints_for_e(e_try)
            if (vt & k_mask).bit_count() % 2 != 0:
                continue
            srt = s9.run_branch_cascade(
                lib9, root0["_buf"], root0["_quad_ids"], root0["_cub_ids"], root0["_lin_pivs"],
                ext, tbl, max_xl_rounds=20, verify_subst=True
            )
            if srt["closed_unsat"]:
                closed_ctrl = {"e": e_try, "closed_unsat": True}
                break
        assert closed_ctrl is not None, "K=0 control failed to find any root-closed fiber!"
        out["controls"]["k0_closed_control"] = closed_ctrl
        out["controls"]["elapsed_s"] = round(time.perf_counter() - tc0, 2)
        print(f"[CONTROL PASS] K=0 e=0 OPEN(102,0), e={closed_ctrl['e']} CLOSED in {out['controls']['elapsed_s']}s", flush=True)

    # Build K=1 root (force_k=1, ZERO proved_extra!)
    tk0 = time.perf_counter()
    root1, deg1 = build_root(1, lib_diag, lib9, lib_cg, lib_d8, shared)
    out["k1_root"] = {
        "closed_unsat": bool(root1["closed_unsat"]),
        "root_lin_pivs": len(root1["_lin_pivs"]),
        "root_dim": 0 if root1["closed_unsat"] else 111 - len(root1["_lin_pivs"]),
        "root_quads": 0 if root1["closed_unsat"] else len(root1["_quad_ids"]),
        "root_cubs": 0 if root1["closed_unsat"] else len(root1["_cub_ids"]),
        "base_deg_pivs": deg1,
        "elapsed_s": round(time.perf_counter() - tk0, 2),
    }
    print(f"[K=1 ROOT] closed={out['k1_root']['closed_unsat']} dim={out['k1_root']['root_dim']} "
          f"quads={out['k1_root']['root_quads']} cubs={out['k1_root']['root_cubs']} ({out['k1_root']['elapsed_s']}s)", flush=True)

    for e_rep in reps:
        te0 = time.perf_counter()
        val_e, ex_e = layer_constraints_for_e(e_rep)
        k_bit = (val_e & k_mask).bit_count() % 2
        assert k_bit == 1, f"e={e_rep} does not have K=1!"
        if root1["closed_unsat"]:
            rec = {
                "e": e_rep, "val_e_hex": hex(val_e), "K": k_bit,
                "status": "CLOSED_AT_K1_ROOT", "dim": 0, "quads": 0, "cubs": 0,
                "elapsed_s": 0.0,
            }
        else:
            sr = s9.run_branch_cascade(
                lib9, root1["_buf"], root1["_quad_ids"], root1["_cub_ids"], root1["_lin_pivs"],
                ex_e, tbl, max_xl_rounds=args.max_xl, verify_subst=True
            )
            dt = round(time.perf_counter() - te0, 2)
            if sr["closed_unsat"]:
                rec = {
                    "e": e_rep, "val_e_hex": hex(val_e), "K": k_bit,
                    "status": "CLOSED", "dim": 0, "quads": 0, "cubs": 0,
                    "elapsed_s": dt,
                }
            else:
                rec = {
                    "e": e_rep, "val_e_hex": hex(val_e), "K": k_bit,
                    "status": "OPEN",
                    "dim": 111 - len(sr["_lin_pivs"]),
                    "quads": len(sr["_quad_ids"]),
                    "cubs": len(sr["_cub_ids"]),
                    "elapsed_s": dt,
                }
        out["reps"].append(rec)
        print(f"  [K=1 e={e_rep:2d}] status={rec['status']} dim={rec['dim']} quads={rec['quads']} cubs={rec['cubs']} ({rec['elapsed_s']}s)", flush=True)

    out["total_elapsed_s"] = round(time.perf_counter() - t0, 2)
    Path(args.out).write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
    print(f"[DONE] Wrote {args.out} in {out['total_elapsed_s']}s", flush=True)


if __name__ == "__main__":
    main()
