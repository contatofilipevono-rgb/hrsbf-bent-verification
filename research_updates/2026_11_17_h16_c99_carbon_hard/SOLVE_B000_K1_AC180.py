#!/usr/bin/env python3
"""
SOLVE_B000_K1_AC180.py
Injects Step 63A (AC180 + all 4,115 C_16 autocorrelation mod-32/64/128+ + 36 D_8 Parseval P(d)
+ 36 D_8 Dual-Square Q_dual(v)) 50-pt direct-TT Zero-Trust verified deg<=3 equations into
C5-free B0_00, K=1 (root, e=11, e=3) and K=0, e=0 control, then measures post-AC180
(dim, quads, cubs, nW, low_bas_dim, k_fix) and auto-closes e=11 if k_fix <= 10.
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
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_B000_K1_CASCADE as k1c
import SOLVE_B000_K1_WESS_PILOT as pilot


def compile_lib_ac(tag):
    c_ac, so_ac = WORK_DIR / f"{tag}_ac.c", WORK_DIR / f"lib{tag}_ac.so"
    c_ac.write_text(s63a.C_STEP63A_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_ac), "-o", str(so_ac)],
        check=True,
    )
    lib_ac = ctypes.CDLL(str(so_ac))
    lib_ac.fwht_autocorr_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint16), ctypes.c_int, ctypes.POINTER(ctypes.c_int32),
    ]
    lib_ac.direct_wt15_verify_c.argtypes = lib_ac.fwht_autocorr_batch_c.argtypes
    lib_ac.eval_d8_parseval_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int64),
    ]
    lib_ac.extract_deriv_bit_anf_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_ac.extract_d8_pq_deg3_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    return lib_ac


def build_tt_111_b000():
    orbits = diag_v2.build_orbits_116()
    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc
    _, origin111, cb111 = b09.build_pure_111_basis(0, 0, 0)
    b_tt_111 = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt_111[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb
    o_tt_111 = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp
        o_tt_111 ^= orb_tt_np[lb.bit_length() - 1]
        tmp ^= lb
    return o_tt_111, b_tt_111


def run_ac180_on_state(label, sr, o_tt_111, b_tt_111, lib_ac, lib9, lib_sh, so_s9_path, tbl, tables63,
                       probe_wess=True, auto_close_e=None, auto_close_max_kfix=10, cert_dir=None, deadline=None, seed=63100):
    t0 = time.perf_counter()
    all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices, c8_idx_256, z_reps_36, z_reps_py = tables63
    act = sorted(i for i in range(111) if i not in sr["_lin_pivs"])
    orig_tt, basis_tt, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, sr["_lin_pivs"], act)

    before = {
        "dim": len(act),
        "quads": len(sr["_quad_ids"]),
        "cubs": len(sr["_cub_ids"]),
    }
    out_states = {}
    s63a.run_autocorr_and_parseval_suite(
        orig_tt, basis_tt, act, sr,
        all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
        c8_idx_256, z_reps_36, z_reps_py,
        lib_ac, None, lib9, tbl, None,
        tag=label, seed=seed, vq_ctx=None, do_deg4_compare=False, out_states=out_states
    )
    injected = out_states.get("injected_psets", [])
    sr_after = out_states.get("sub_ac", sr)

    rec = {
        "label": label,
        "before": before,
        "injected_zt_deg3_count": len(injected),
        "closed_unsat": bool(sr_after["closed_unsat"]),
        "after": {
            "dim": 0 if sr_after["closed_unsat"] else 111 - len(sr_after["_lin_pivs"]),
            "quads": 0 if sr_after["closed_unsat"] else len(sr_after["_quad_ids"]),
            "cubs": 0 if sr_after["closed_unsat"] else len(sr_after["_cub_ids"]),
        },
        "elapsed_ac180_s": round(time.perf_counter() - t0, 2),
    }

    if probe_wess and not sr_after["closed_unsat"] and len(sr_after["_quad_ids"]) > 0:
        tw0 = time.perf_counter()
        info = s45a.extract_minrank_basis_for_state(f"{label}_postAC", sr_after, lib9, lib_sh, tbl, rng_seed=seed + 50)
        rec["post_ac_wess"] = {
            "minrank_status": info.get("status", "OK"),
            "nW": info.get("nW", 0),
            "low_bas_dim": info.get("low_bas_dim", 0),
            "bas_len": len(info.get("bas", [])),
        }
        if info.get("status") not in ("NO_W", "NO_M1"):
            th = s45a.find_kfix_threshold(f"{label}_postAC", sr_after, info, lib9, tbl, rng_seed=seed + 50)
            if th is not None:
                best_k, avg_dt = th
                rec["post_ac_wess"]["k_fix"] = int(best_k)
                rec["post_ac_wess"]["total_branches"] = 1 << int(best_k)
                rec["post_ac_wess"]["avg_branch_s"] = round(avg_dt, 3)
                rec["post_ac_wess"]["est_4core_s"] = round(avg_dt * (1 << int(best_k)) / 4.0, 1)
                print(f"  [{label} POST-AC180 W_ess] nW={info['nW']} low_bas_dim={info['low_bas_dim']} "
                      f"-> k_fix={best_k} ({1<<best_k} branches, avg={avg_dt:.2f}s, est_4core={rec['post_ac_wess']['est_4core_s']}s)", flush=True)
                if auto_close_e is not None and best_k <= auto_close_max_kfix:
                    print(f"  [{label}] AUTO-CLOSING ALL {1<<best_k} BRANCHES NOW!", flush=True)
                    cert = s45a.run_parallel_shard(
                        f"{label}_postAC", auto_close_e, sr_after, info, int(best_k), 0, 1, 4,
                        so_s9_path, tbl["n_col_words"], deadline, cert_dir
                    )
                    cert["sector"] = "B0_00_K1_C5_FREE_POST_AC180"
                    cert["e_rep"] = auto_close_e
                    (cert_dir / f"k1_ac180_cert_e{auto_close_e:02d}_full.json").write_text(json.dumps(cert, indent=2) + "\n")
                    rec["auto_close_cert"] = cert
            else:
                rec["post_ac_wess"]["k_fix"] = None
        rec["elapsed_wess_s"] = round(time.perf_counter() - tw0, 2)

    return rec, sr_after


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--target", choices=["e11", "e3", "k0_e0"], required=True)
    ap.add_argument("--run-root", action="store_true")
    ap.add_argument("--auto-close-max-kfix", type=int, default=10)
    ap.add_argument("--budget-min", type=float, default=38.0)
    ap.add_argument("--out-dir", type=str, default="k1_ac180_out")
    args = ap.parse_args()

    t0 = time.perf_counter()
    deadline = t0 + args.budget_min * 60.0
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    tag = f"ac180_{args.target}"
    lib_ac = compile_lib_ac(tag)
    o_tt_111, b_tt_111 = build_tt_111_b000()
    all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices = s63a.build_all_4115_c16_shifts()
    c8_idx_256, z_reps_36, z_reps_py = s63a.build_c8_orbit_tables()
    tables63 = (all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices, c8_idx_256, z_reps_36, z_reps_py)

    summary = {"target": args.target, "results": []}

    if args.target == "k0_e0":
        # Sanity control on K=0, e=0
        lib_diag, lib9, lib_cg, lib_d8 = k1c.compile_kernels(tag)
        so_s9_path = WORK_DIR / f"lib{tag}_s9.so"
        lib_sh = pilot.compile_shear(tag)
        # Build K=0 root cleanly via pilot's shared builder? Easier: reuse setup_k1_root's components for K=0
        # Let's build K=0 root directly using build_cell_algebraic_system(..., force_k=0)
        root1, indep_forms, origin111, k_mask, _, _, _, tbl = pilot.setup_k1_root(f"{tag}_k1")
        # Rebuild K=0 root quickly using k1c.build_root(0, ...)
        orbits = diag_v2.build_orbits_116()
        mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
        for j, orb in enumerate(orbits):
            for m in orb: mon_to_orb_arr[m] = j
        reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)
        v6_list = diag_v2.all_v6_orbits()
        _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
        M_rows = [sum((1 << mi) for mi, (_, uo) in enumerate(u8_size8) if (sum(1 if ((u & rz).bit_count() & 1) == 0 else -1 for u in uo) // 2) & 1) for rz, _ in nonzero_z]
        fiber_meta = (nonzero_z, diag_v2.gf2_nullspace_left(M_rows))
        pair_idx, all_pairs = {}, []
        for v in range(256):
            for w in range(v + 1, 256): pair_idx[(v, w)] = len(all_pairs); all_pairs.append(v | (w << 8))
        seen_x = bytearray(65536); rot4_reps, rep_of_x = [], [-1] * 65536
        for x in range(65536):
            if (x & 0xFF) == (x >> 8) or seen_x[x]: continue
            ri = len(rot4_reps); rot4_reps.append(x)
            for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)): seen_x[y] = 1; rep_of_x[y] = ri
        coset_0xf_reps = []; vis16 = bytearray(65536)
        for x in range(65536):
            if vis16[x]: continue
            cur, mem = x, []
            while not vis16[cur]: vis16[cur] = 1; mem.append(cur); cur = diag_v2.rot16(cur)
            if len(mem) == 16 and ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF: coset_0xf_reps.append(mem[0])
        X = np.arange(65536, dtype=np.uint16); orb_tts = [bytearray(65536) for _ in range(116)]; orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
        orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
        for j, orb in enumerate(orbits):
            acc = np.zeros(65536, dtype=np.uint8)
            for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
            orb_tt_np[j] = acc; tt = bytearray(acc.tolist()); orb_tts[j] = tt
            orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
            orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
            orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
            orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
        chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)
        rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, lambda j, x: orb_tts[j][x])
        layers, c0x0 = s9.build_cyclotomic_layers()
        free111, origin111, cb111 = b09.build_pure_111_basis(0, 0, 0)
        n, n_cw = tbl["n"], tbl["n_col_words"]
        seen_a, d8_specs = set(), []
        for a in range(1, 256):
            if a in seen_a: continue
            oa = [((a << sh) | (a >> (8 - sh))) & 0xFF for sh in range(8)]; seen_a.update(oa); ol = len(set(oa))
            d8_specs.append((a, 3))
            if ol == 4: d8_specs.append((a, 4))
            elif ol == 2: d8_specs.append((a, 5))
            elif ol == 1: d8_specs.append((a, 6))
        d8_buf = (ctypes.c_uint64 * (len(d8_specs) * n_cw))()
        for idxd, (a, sb) in enumerate(d8_specs):
            pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
            bw = (ctypes.c_uint64 * (111 * 4))()
            for i in range(111):
                bits = b_tt_111[i, pts]
                for w in range(4):
                    val = 0
                    for b in range(64):
                        if bits[w * 64 + b]: val |= (1 << b)
                    bw[i * 4 + w] = val
            rptr = ctypes.cast(ctypes.byref(d8_buf, idxd * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_d8.extract_deg3_coset_poly(bw, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr)
        orb_map = (ctypes.c_int * 116)(*([-1] * 116))
        for i, j in enumerate(free111): orb_map[j] = i
        orb_map[0] = -3
        L_vars_py = [i for i, j in enumerate(free111) if j in set(diag_v2.L_INDICES)]
        L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)
        n_cg = len(reps12) + len(reps11); cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
        for idx, I_m in enumerate(reps12):
            rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_cg.build_cg12_row_c(I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py), n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr)
        for idx, I_m in enumerate(reps11):
            rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_cg.build_cg11_row_c(I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py), n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr)
        cyc_cubs = s9.extract_verified_cyclotomic_cubics("B0_00", orbits, origin111, cb111, layers, c0x0)
        shared = (orbits, v6_list, rot4_data, fiber_meta, tbl, cyc_cubs, cg_buf, n_cg, d8_buf, len(d8_specs))
        root0, _ = k1c.build_root(0, lib_diag, lib9, lib_cg, lib_d8, shared)
        ex0 = [(xm, ((origin111 & fm).bit_count()) & 1) for fm, xm in indep_forms]
        sr0 = s9.run_branch_cascade(lib9, root0["_buf"], root0["_quad_ids"], root0["_cub_ids"], root0["_lin_pivs"], ex0, tbl, max_xl_rounds=25, verify_subst=True)
        rec0, _ = run_ac180_on_state("B0_00_K0_e0", sr0, o_tt_111, b_tt_111, lib_ac, lib9, lib_sh, so_s9_path, tbl, tables63, probe_wess=False, seed=63000)
        summary["results"].append(rec0)
    else:
        root1, indep_forms, origin111, k_mask, lib9, lib_sh, so_s9_path, tbl = pilot.setup_k1_root(tag)
        if args.run_root:
            rec_r, root1_ac = run_ac180_on_state("B0_00_K1_ROOT", root1, o_tt_111, b_tt_111, lib_ac, lib9, lib_sh, so_s9_path, tbl, tables63, probe_wess=False, seed=63100)
            summary["results"].append(rec_r)
            if not root1_ac["closed_unsat"]:
                root1 = root1_ac
        e_rep = 11 if args.target == "e11" else 3
        _, sr = pilot.get_rep_state(e_rep, root1, indep_forms, origin111, k_mask, lib9, tbl)
        rec_e, _ = run_ac180_on_state(
            f"B0_00_K1_e{e_rep:02d}", sr, o_tt_111, b_tt_111, lib_ac, lib9, lib_sh, so_s9_path, tbl, tables63,
            probe_wess=True, auto_close_e=(e_rep if e_rep == 11 else None),
            auto_close_max_kfix=args.auto_close_max_kfix, cert_dir=out_dir, deadline=deadline, seed=63200 + e_rep
        )
        summary["results"].append(rec_e)

    summary["total_elapsed_s"] = round(time.perf_counter() - t0, 2)
    out_p = out_dir / f"ac180_{args.target}.json"
    out_p.write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(summary, indent=2), flush=True)


if __name__ == "__main__":
    main()
