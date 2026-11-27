#!/usr/bin/env python3
"""
SOLVE_B000_K1_WESS_PILOT.py
100% C5-free W_ess quadratic-support MinRank probe & parallel UNSAT closer
for B0_00, K=1 (pilot on e=11 and e=3, plus sharded closure for any A14 rep).
Uses build_root(force_k=1) + A14_LMASK fiber selection + zero proved_extra.
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_B000_K1_CASCADE as k1c
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a


def compile_shear(tag):
    c_sh, so_sh = WORK_DIR / f"{tag}_sh.c", WORK_DIR / f"lib{tag}_sh.so"
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
    return lib_sh


def setup_k1_root(tag):
    lib_diag, lib9, lib_cg, lib_d8 = k1c.compile_kernels(tag)
    so_s9_path = WORK_DIR / f"lib{tag}_s9.so"
    lib_sh = compile_shear(tag)

    orbits = diag_v2.build_orbits_116()
    a14_forms = k1c.build_a14_layer_forms(orbits)
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

    indep_forms = []
    piv_tmp = {}
    for fm in a14_forms:
        xm = sum((1 << i) for i, cdir in enumerate(cb111) if (cdir & fm).bit_count() & 1)
        if not xm:
            continue
        v = xm
        while v:
            b = v.bit_length() - 1
            if b in piv_tmp:
                v ^= piv_tmp[b]
            else:
                piv_tmp[b] = v
                indep_forms.append((fm, xm))
                break
    assert len(indep_forms) == 7

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
    root1, _ = k1c.build_root(1, lib_diag, lib9, lib_cg, lib_d8, shared)
    assert not root1["closed_unsat"], "Unexpected K=1 root closure"
    return root1, indep_forms, origin111, k_mask, lib9, lib_sh, so_s9_path, tbl


def get_rep_state(e_rep, root1, indep_forms, origin111, k_mask, lib9, tbl):
    val_e = k1c.xor_selected(k1c.A14_LMASK, e_rep)
    assert (val_e & k_mask).bit_count() % 2 == 1, f"e={e_rep} is not K=1!"
    ex_e = []
    for fm, xm in indep_forms:
        rhs = ((val_e & fm).bit_count() ^ (origin111 & fm).bit_count()) & 1
        ex_e.append((xm, rhs))
    sr = s9.run_branch_cascade(
        lib9, root1["_buf"], root1["_quad_ids"], root1["_cub_ids"], root1["_lin_pivs"],
        ex_e, tbl, max_xl_rounds=25, verify_subst=True
    )
    return val_e, sr


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mode", choices=["probe", "close"], default="probe")
    ap.add_argument("--reps", type=str, default="11,3", help="Comma-separated reps for probe mode")
    ap.add_argument("--rep", type=int, default=11, help="Single rep for close mode")
    ap.add_argument("--kfix", type=int, default=0, help="Override k_fix for close mode (0=auto)")
    ap.add_argument("--auto-close-max-kfix", type=int, default=10,
                    help="In probe mode, auto-close rep 11 if k_fix <= this threshold")
    ap.add_argument("--shard-idx", type=int, default=0)
    ap.add_argument("--n-shards", type=int, default=1)
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--budget-min", type=float, default=35.0)
    ap.add_argument("--cert-dir", type=str, default="k1_wess_certs")
    args = ap.parse_args()

    t0 = time.perf_counter()
    deadline = t0 + args.budget_min * 60.0
    cert_dir = Path(args.cert_dir)
    cert_dir.mkdir(parents=True, exist_ok=True)

    tag = f"k1w_{args.mode}_{args.rep}_{args.shard_idx}"
    root1, indep_forms, origin111, k_mask, lib9, lib_sh, so_s9_path, tbl = setup_k1_root(tag)
    n_cw = tbl["n_col_words"]
    print(f"[K=1 ROOT READY] in {time.perf_counter()-t0:.1f}s (dim={111-len(root1['_lin_pivs'])})", flush=True)

    if args.mode == "probe":
        reps = [int(x.strip()) for x in args.reps.split(",") if x.strip()]
        probe_out = {"mode": "probe", "reps": []}
        for e_rep in reps:
            tr0 = time.perf_counter()
            val_e, sr = get_rep_state(e_rep, root1, indep_forms, origin111, k_mask, lib9, tbl)
            lbl = f"K1_e{e_rep:02d}"
            info = s45a.extract_minrank_basis_for_state(lbl, sr, lib9, lib_sh, tbl, rng_seed=5100 + e_rep)
            rec = {
                "e": e_rep,
                "val_e_hex": hex(val_e),
                "dim": 111 - len(sr["_lin_pivs"]),
                "quads": len(sr["_quad_ids"]),
                "cubs": len(sr["_cub_ids"]),
                "minrank_status": info.get("status", "OK"),
                "nW": info.get("nW", 0),
                "low_bas_dim": info.get("low_bas_dim", 0),
                "bas_len": len(info.get("bas", [])),
            }
            if info.get("status") not in ("NO_W", "NO_M1"):
                th = s45a.find_kfix_threshold(lbl, sr, info, lib9, tbl, rng_seed=5100 + e_rep)
                if th is not None:
                    best_k, avg_dt = th
                    rec["k_fix"] = int(best_k)
                    rec["total_branches"] = 1 << int(best_k)
                    rec["avg_branch_s"] = round(avg_dt, 3)
                    rec["est_4core_s"] = round(avg_dt * (1 << int(best_k)) / 4.0, 1)
                    print(f"  [{lbl}] nW={rec['nW']} low_bas_dim={rec['low_bas_dim']} -> k_fix={best_k} "
                          f"({rec['total_branches']} branches, avg={avg_dt:.2f}s, est_4core={rec['est_4core_s']}s)", flush=True)
                    if e_rep == 11 and best_k <= args.auto_close_max_kfix:
                        print(f"  [{lbl}] AUTO-CLOSING ALL {rec['total_branches']} BRANCHES NOW!", flush=True)
                        cert = s45a.run_parallel_shard(
                            lbl, e_rep, sr, info, int(best_k), 0, 1, args.workers,
                            so_s9_path, n_cw, deadline, cert_dir
                        )
                        cert["sector"] = "B0_00_K1_C5_FREE"
                        cert["e_rep"] = e_rep
                        (cert_dir / f"k1_cert_e{e_rep:02d}_full.json").write_text(json.dumps(cert, indent=2) + "\n")
                        rec["auto_close_cert"] = cert
                else:
                    rec["k_fix"] = None
                    print(f"  [{lbl}] nW={rec['nW']} low_bas_dim={rec['low_bas_dim']} -> NO_THRESHOLD in d_free scan", flush=True)
            else:
                print(f"  [{lbl}] minrank_status={rec['minrank_status']} nW={rec['nW']}", flush=True)
            rec["elapsed_s"] = round(time.perf_counter() - tr0, 2)
            probe_out["reps"].append(rec)

        out_p = cert_dir / "k1_wess_probe_summary.json"
        out_p.write_text(json.dumps(probe_out, indent=2) + "\n", encoding="utf-8")
        print(json.dumps(probe_out, indent=2), flush=True)
    else:
        e_rep = args.rep
        val_e, sr = get_rep_state(e_rep, root1, indep_forms, origin111, k_mask, lib9, tbl)
        lbl = f"K1_e{e_rep:02d}"
        info = s45a.extract_minrank_basis_for_state(lbl, sr, lib9, lib_sh, tbl, rng_seed=5100 + e_rep)
        k_fix = args.kfix
        if k_fix <= 0:
            th = s45a.find_kfix_threshold(lbl, sr, info, lib9, tbl, rng_seed=5100 + e_rep)
            assert th is not None, f"Could not auto-find k_fix for {lbl}"
            k_fix = int(th[0])
        cert = s45a.run_parallel_shard(
            lbl, e_rep, sr, info, k_fix, args.shard_idx, args.n_shards,
            args.workers, so_s9_path, n_cw, deadline, cert_dir
        )
        cert["sector"] = "B0_00_K1_C5_FREE"
        cert["e_rep"] = e_rep
        cert_path = cert_dir / f"k1_cert_e{e_rep:02d}_s{args.shard_idx}_of_{args.n_shards}.json"
        cert_path.write_text(json.dumps(cert, indent=2) + "\n", encoding="utf-8")
        print(json.dumps(cert, indent=2), flush=True)


if __name__ == "__main__":
    main()
