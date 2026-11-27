#!/usr/bin/env python3
"""
SOLVE_B000_K1_REDUCERS.py
Tests two k_fix reducers on C5-free B0_00, K=1, e=11 (baseline k_fix=18, 262,144 branches):
  - Reducer A (--mode 0xff): Pre-split on all balanced states of z=0xFF (12 states),
    run XL cascade + W_ess MinRank probe on each sub-state, compute sum(2^{k_fix, i}).
  - Reducer B (--mode sysb): Run Step 47B iterative (K_R + V_00 + V_0 + NT0_Polar + SysB)
    cascade on e=11 (both global NT=0 and U_1 subspaces d1=38,34,30,24) and on the first
    open z=0xFF sub-state.
100% C5-free (force_k=1, A14_LMASK, zero proved_extra).
"""

import argparse
import ctypes
import json
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_B000_K1_WESS_PILOT as pilot
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b


def build_b_tt():
    orbits = diag_v2.build_orbits_116()
    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc
    _, _, cb111 = b09.build_pure_111_basis(0, 0, 0)
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb
    return b_tt


def get_coset_bal_states(sr_cur, b_tt, z_val, max_dim=10):
    pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
    raw_forms = [
        sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]]))
        for k in range(256) if np.any(b_tt[:, pts[k]])
    ]
    z_free = s16.reduce_forms_mod_pivs(raw_forms, sr_cur["_lin_pivs"])
    nz = len(z_free)
    if nz > max_dim:
        return nz, None, None
    z_rref = s19.strict_rref_masks(z_free)
    z_pivs = sorted(z_rref.keys())
    z_forms = [z_rref[p] for p in z_pivs]
    z_tts = []
    for p in z_pivs:
        x = 1 << p
        for lp, (pv, _) in sr_cur["_lin_pivs"].items():
            if (((pv ^ (1 << lp)) & x).bit_count()) & 1:
                x |= (1 << lp)
        tt = np.zeros(256, dtype=np.uint8)
        tmp = x
        while tmp:
            lb = tmp & -tmp
            tt ^= b_tt[lb.bit_length() - 1, pts]
            tmp ^= lb
        z_tts.append(tt)
    x0 = sum((1 << lp) for lp, (_, pr) in sr_cur["_lin_pivs"].items() if pr)
    tt0 = np.zeros(256, dtype=np.uint8)
    tmp = x0
    while tmp:
        lb = tmp & -tmp
        tt0 ^= b_tt[lb.bit_length() - 1, pts]
        tmp ^= lb
    bal_sts = []
    for st in range(1 << nz):
        tt = tt0.copy()
        for j in range(nz):
            if (st >> j) & 1:
                tt ^= z_tts[j]
        if int(tt.sum()) == 128:
            bal_sts.append(st)
    return nz, z_forms, bal_sts


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mode", choices=["0xff", "sysb"], required=True)
    ap.add_argument("--rep", type=int, default=11)
    ap.add_argument("--shard-idx", type=int, default=0)
    ap.add_argument("--n-shards", type=int, default=1)
    ap.add_argument("--out", type=str, required=True)
    args = ap.parse_args()

    t0 = time.perf_counter()
    tag = f"k1r_{args.mode}_{args.rep}_{args.shard_idx}"
    root1, indep_forms, origin111, k_mask, lib9, lib_sh, _, tbl = pilot.setup_k1_root(tag)
    val_e, sr = pilot.get_rep_state(args.rep, root1, indep_forms, origin111, k_mask, lib9, tbl)
    b_tt = build_b_tt()
    print(f"[K=1 e={args.rep}] Ready in {time.perf_counter()-t0:.1f}s (dim={111-len(sr['_lin_pivs'])}, quads={len(sr['_quad_ids'])}, cubs={len(sr['_cub_ids'])})", flush=True)

    nz_ff, forms_ff, bal_ff = get_coset_bal_states(sr, b_tt, 0xFF, max_dim=8)
    print(f"[z=0xFF] dim={nz_ff}, total balanced states={len(bal_ff)}: {bal_ff}", flush=True)

    if args.mode == "0xff":
        results = []
        for idx, st_ff in enumerate(bal_ff):
            if idx % args.n_shards != args.shard_idx:
                continue
            ts0 = time.perf_counter()
            ex_ff = [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_ff, tbl, max_xl_rounds=25, verify_subst=True
            )
            lbl = f"K1_e{args.rep:02d}_ff{st_ff}"
            if sub["closed_unsat"]:
                rec = {
                    "ff_idx": idx, "st_ff": int(st_ff), "status": "CLOSED_DIRECT",
                    "dim": 0, "quads": 0, "cubs": 0, "nW": 0, "low_bas_dim": 0,
                    "k_fix": None, "branches": 0, "avg_branch_s": 0.0,
                    "elapsed_s": round(time.perf_counter() - ts0, 2),
                }
            else:
                info = s45a.extract_minrank_basis_for_state(lbl, sub, lib9, lib_sh, tbl, rng_seed=5200 + st_ff)
                rec = {
                    "ff_idx": idx, "st_ff": int(st_ff), "status": "OPEN",
                    "dim": 111 - len(sub["_lin_pivs"]),
                    "quads": len(sub["_quad_ids"]),
                    "cubs": len(sub["_cub_ids"]),
                    "minrank_status": info.get("status", "OK"),
                    "nW": info.get("nW", 0),
                    "low_bas_dim": info.get("low_bas_dim", 0),
                    "k_fix": None, "branches": None, "avg_branch_s": None,
                }
                if info.get("status") not in ("NO_W", "NO_M1"):
                    th = s45a.find_kfix_threshold(lbl, sub, info, lib9, tbl, rng_seed=5200 + st_ff)
                    if th is not None:
                        rec["k_fix"] = int(th[0])
                        rec["branches"] = 1 << int(th[0])
                        rec["avg_branch_s"] = round(th[1], 3)
                rec["elapsed_s"] = round(time.perf_counter() - ts0, 2)
            print(f"  [{lbl}] {rec}", flush=True)
            results.append(rec)

        out = {
            "mode": "0xff", "rep": args.rep, "nz_ff": nz_ff,
            "total_bal_ff": len(bal_ff), "shard_idx": args.shard_idx, "n_shards": args.n_shards,
            "states": results, "elapsed_s": round(time.perf_counter() - t0, 2),
        }
        Path(args.out).write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
    else:
        # Reducer B: Step 47B iterative SysB on e=11 AND on first open 0xFF sub-state!
        print(f"\n=== REDUCER B (STEP 47B ITERATIVE SYSB) ON K=1 e={args.rep} ===", flush=True)
        sys_ex = s45b.extract_eta_exact_system(0, sr, [], lib9, lib_sh, tbl, rng_seed=4711)
        s47b.audit_eta_cascade(f"K1_e{args.rep:02d}", sys_ex, lib9, rng_seed=4711)

        # Also test on first open 0xFF sub-state
        first_ff_info = None
        for st_ff in bal_ff:
            ex_ff = [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_ff, tbl, max_xl_rounds=25, verify_subst=True
            )
            if not sub["closed_unsat"]:
                print(f"\n=== REDUCER B (STEP 47B ITERATIVE SYSB) ON K=1 e={args.rep} ff={st_ff} ===", flush=True)
                sys_ex_ff = s45b.extract_eta_exact_system(0, sub, [], lib9, lib_sh, tbl, rng_seed=4722)
                s47b.audit_eta_cascade(f"K1_e{args.rep:02d}_ff{st_ff}", sys_ex_ff, lib9, rng_seed=4722)
                first_ff_info = {
                    "st_ff": int(st_ff),
                    "nW": int(sys_ex_ff["nW"]),
                    "M0_shape": list(sys_ex_ff["M0_c"].shape),
                }
                break

        out = {
            "mode": "sysb", "rep": args.rep,
            "e11_nW": int(sys_ex["nW"]),
            "e11_M0_shape": list(sys_ex["M0_c"].shape),
            "first_open_ff": first_ff_info,
            "elapsed_s": round(time.perf_counter() - t0, 2),
        }
        Path(args.out).write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
        print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
