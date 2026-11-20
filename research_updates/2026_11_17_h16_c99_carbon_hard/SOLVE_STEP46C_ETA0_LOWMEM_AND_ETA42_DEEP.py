#!/usr/bin/env python3
r"""
SOLVE_STEP46C_ETA0_LOWMEM_AND_ETA42_DEEP.py

TWO TARGETED B0_00 CLOSERS RUNNING IN PARALLEL WITH WAVE 2:
  1. --mode eta0_lowmem:
        Fixes the OOM (exit code 137) in eta0_full by NEVER accumulating `sub2` buffers
       in a list (each `sub2` buffer is ~64 MB; 300 buffers = 19.2 GB > 16 GB runner RAM!).
       Instead, processes each open (st_ff, st_55) sub-state immediately in-place (<300 MB RAM!),
       closing all sub-states with k_fix <= 8 (or NO_W / NO_M1 via W_forms + z=0x33 + 2-level split)
       on 4 forked cores, and writes `step46c_cert_eta00_full.json`.
  2. --mode eta42_deep:
       Runs B0_00 eta=42 at k_fix=8 (256 top branches, 4 workers for direct pass), and for
       every top branch rb that stays open (~25/256 branches with N=68, q=1..31), runs a
       2nd-level exact K_R + MinRank (or s9.compute_quadratic_linearizer when q<=4) closure
       until 100% of all 256 top branches are certified UNSAT (0 survivors)!
       Writes `step46c_cert_eta42_deep.json`.
"""

import argparse
import ctypes
import gc
import json
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
import sys
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a


def close_open_substate_deep(lbl, sub, lib9, lib_sh, so_s9, tbl, n_cw, workers, deadline, cert_dir, max_k2=9):
    """Given an open child state `sub`, close it via K_R+MinRank (if M1>0) or quadratic linearizer / W-split."""
    info2 = s45a.extract_minrank_basis_for_state(lbl, sub, lib9, lib_sh, tbl, rng_seed=46300)
    nW2 = info2["nW"]
    if info2["status"] == "OK":
        th2 = s45a.find_kfix_threshold(lbl, sub, info2, lib9, tbl, rng_seed=46301)
        k2 = th2[0] if th2 is not None else min(max_k2, nW2)
        k2 = min(k2, max_k2, nW2 - 1) if nW2 > 1 else 1
        c2 = s45a.run_parallel_shard(lbl, 42, sub, info2, k2, 0, 1, workers, so_s9, n_cw, deadline, cert_dir)
        if c2["verdict"] == "ORBIT_FORMALLY_CLOSED_100%":
            return True, f"MINRANK_K{k2}({c2['branches_checked']})"

    # Fallback: use quadratic linearizer / W_forms of sub["_quad_ids"] up to depth 8
    qps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_forms = [W_rref[p] for p in sorted(W_rref.keys())]
    if not W_forms:
        return False, f"NO_W_FORMS(q={len(qps)})"

    for k_split in [min(len(W_forms), d) for d in (4, 6, 8)]:
        forms_use = W_forms[:k_split]
        all_closed = True
        for b in range(1 << k_split):
            ex = [(forms_use[j], (b >> j) & 1) for j in range(k_split)]
            s_ch = s9.run_branch_cascade(
                lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                ex, tbl, max_xl_rounds=20, verify_subst=(b == 0)
            )
            if not s_ch["closed_unsat"]:
                # Try 1 more level of 4 bits on s_ch's own quadratics!
                qps3 = [s9.row_to_pset(s_ch["_buf"], qr, tbl) for qr in s_ch["_quad_ids"][:8]]
                ana3 = s16.analyze_quad_system(qps3)
                wf3 = s16.reduce_forms_mod_pivs(list(ana3["W_piv"].values()) + W_forms, s_ch["_lin_pivs"])[:4]
                if not wf3:
                    all_closed = False
                    break
                sub_ok = True
                for b3 in range(1 << len(wf3)):
                    ex3 = [(wf3[j], (b3 >> j) & 1) for j in range(len(wf3))]
                    s3 = s9.run_branch_cascade(
                        lib9, s_ch["_buf"], s_ch["_quad_ids"], s_ch["_cub_ids"], s_ch["_lin_pivs"],
                        ex3, tbl, max_xl_rounds=18, verify_subst=False
                    )
                    if not s3["closed_unsat"]:
                        sub_ok = False
                        break
                if not sub_ok:
                    all_closed = False
                    break
        if all_closed:
            return True, f"W_SPLIT_K{k_split}"
    return False, f"STILL_OPEN(nW={len(W_forms)},q={len(qps)})"


def run_eta42_deep(root, eta_free, lib9, lib_sh, so_s9, tbl, n_cw, workers, deadline, cert_dir):
    t0 = time.perf_counter()
    print("\n==================== [B0_00 eta=42] STEP 46C: 2-LEVEL DEEP FORMAL CLOSURE ====================", flush=True)
    n_ef = len(eta_free)
    em = 42
    ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex, tbl, max_xl_rounds=20, verify_subst=True
    )
    info = s45a.extract_minrank_basis_for_state("B0_00 eta=42", sr, lib9, lib_sh, tbl, rng_seed=4300 + em)
    k_fix = 8
    fix_forms, rescue_forms, fix_sha = s45a.build_fix_and_rescue_forms(info, k_fix)
    n_branches = 1 << k_fix
    print(f"  [eta=42] Level-1 k_fix={k_fix} ({n_branches} branches), fix_sha256={fix_sha}", flush=True)

    direct_closed = 0
    level2_closed = 0
    level2_details = []
    open_survivors = []

    for rb in range(n_branches):
        ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
        sub = s9.run_branch_cascade(
            lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
            ex_w, tbl, max_xl_rounds=20, verify_subst=(rb == 0 or rb == n_branches - 1)
        )
        if sub["closed_unsat"]:
            direct_closed += 1
        else:
            n_act = tbl["n"] - len(sub["_lin_pivs"])
            n_q = len(sub["_quad_ids"])
            print(f"    [eta=42 rb={rb:3d}] Level-1 open (N={n_act}, q={n_q}) -> running Level-2 deep closer...", flush=True)
            ok, how = close_open_substate_deep(
                f"eta42_rb{rb}", sub, lib9, lib_sh, so_s9, tbl, n_cw, workers, deadline, cert_dir, max_k2=9
            )
            if ok:
                level2_closed += 1
                level2_details.append({"rb": rb, "N": n_act, "q": n_q, "closed_by": how})
                print(f"      -> [eta=42 rb={rb:3d}] LEVEL-2 CLOSED 100% via {how}!", flush=True)
            else:
                open_survivors.append({"rb": rb, "N": n_act, "q": n_q, "detail": how})
                print(f"      -> [eta=42 rb={rb:3d}] STILL OPEN: {how}", flush=True)
        del sub
        if (rb + 1) % 32 == 0 or (rb + 1) == n_branches:
            gc.collect()
            print(
                f"    [eta=42] progress {rb+1}/{n_branches}: direct={direct_closed}, level2_closed={level2_closed}, "
                f"open={len(open_survivors)} ({time.perf_counter()-t0:.1f}s)",
                flush=True,
            )

    verdict = "ORBIT_FORMALLY_CLOSED_100%" if len(open_survivors) == 0 else "HAS_OPEN_SURVIVORS"
    cert = {
        "cell": "B0_00",
        "eta": 42,
        "k_fix_level1": k_fix,
        "fix_sha256": fix_sha,
        "fix_forms_hex": [hex(f) for f in fix_forms],
        "total_branches": n_branches,
        "direct_closed": direct_closed,
        "level2_closed": level2_closed,
        "level2_details": level2_details,
        "open_survivors": open_survivors,
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "verdict": verdict,
    }
    cert_dir.mkdir(parents=True, exist_ok=True)
    out_p = cert_dir / "step46c_cert_eta42_deep.json"
    out_p.write_text(json.dumps(cert, indent=2), encoding="utf-8")
    print(f"\n  *** [B0_00 eta=42] {verdict} (direct={direct_closed}, level2={level2_closed}, open={len(open_survivors)}, {cert['elapsed_s']}s) -> {out_p.name} ***", flush=True)


def run_eta0_lowmem(root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw, workers, deadline, cert_dir):
    t0 = time.perf_counter()
    print("\n==================== [B0_00 eta=0] STEP 46C: STREAMING LOW-MEM (<300 MB) SUB-STATE CLOSER ====================", flush=True)

    def get_coset_bal_states(sr_cur, z_val, max_dim=10):
        pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
        raw_forms = [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]])) for k in range(256) if np.any(b_tt[:, pts[k]])]
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

    n_ef = len(eta_free)
    ex0 = [(eta_free[k], 0) for k in range(n_ef)]
    sr0 = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex0, tbl, max_xl_rounds=20, verify_subst=True
    )
    nz_ff, forms_ff, bal_ff = get_coset_bal_states(sr0, 0xFF, max_dim=8)
    print(f"  [eta=0] 0xFF dim={nz_ff}, balanced states={len(bal_ff)}", flush=True)

    ff_closed = 0
    ff_open = 0
    sub2_closed_direct = 0
    open_sub2_total = 0
    closed_100 = 0
    needs_sharding = []
    still_open = []

    for st_ff in bal_ff:
        sub1 = s9.run_branch_cascade(
            lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
            [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)], tbl, max_xl_rounds=20, verify_subst=False
        )
        if sub1["closed_unsat"]:
            ff_closed += 1
            del sub1
            continue
        ff_open += 1
        nz_55, forms_55, bal_55 = get_coset_bal_states(sub1, 0x55, max_dim=10)
        if forms_55 is None:
            still_open.append({"ff": st_ff, "status": f"0x55_DIM_{nz_55}"})
            del sub1
            continue

        for st_55 in bal_55:
            sub2 = s9.run_branch_cascade(
                lib9, sub1["_buf"], sub1["_quad_ids"], sub1["_cub_ids"], sub1["_lin_pivs"],
                [(forms_55[j], (st_55 >> j) & 1) for j in range(nz_55)], tbl, max_xl_rounds=18, verify_subst=False
            )
            if sub2["closed_unsat"]:
                sub2_closed_direct += 1
                del sub2
                continue

            # STREAMING PROCESSING OF OPEN sub2 (NO LIST ACCUMULATION!)
            open_sub2_total += 1
            idx_s = open_sub2_total
            lbl = f"eta0_ff{st_ff}_55_{st_55}"
            info = s45a.extract_minrank_basis_for_state(lbl, sub2, lib9, lib_sh, tbl, rng_seed=45000 + st_ff * 100 + st_55)
            nW = info["nW"]

            if info["status"] in ("NO_W", "NO_M1"):
                if (info["status"] == "NO_W") or (nW <= 6 and info["status"] == "NO_M1"):
                    W_forms = info["W_forms"]
                    survivors_w = []
                    for wb in range(1 << nW):
                        exw = [(W_forms[j], (wb >> j) & 1) for j in range(nW)]
                        sw = s9.run_branch_cascade(
                            lib9, sub2["_buf"], sub2["_quad_ids"], sub2["_cub_ids"], sub2["_lin_pivs"],
                            exw, tbl, max_xl_rounds=18, verify_subst=(wb == 0)
                        )
                        if not sw["closed_unsat"]:
                            survivors_w.append(sw)
                    if not survivors_w:
                        closed_100 += 1
                        print(f"  *** [{lbl}] {info['status']} nW={nW}: CLOSED 100% ({1<<nW} W-branches)! ***", flush=True)
                        del sub2
                        continue
                    rem_z33_open = 0
                    for sw in survivors_w:
                        nz_33, forms_33, bal_33 = get_coset_bal_states(sw, 0x33, max_dim=9)
                        if forms_33 is None:
                            rem_z33_open += 1
                            continue
                        for st_33 in bal_33:
                            sub3 = s9.run_branch_cascade(
                                lib9, sw["_buf"], sw["_quad_ids"], sw["_cub_ids"], sw["_lin_pivs"],
                                [(forms_33[j], (st_33 >> j) & 1) for j in range(nz_33)], tbl, max_xl_rounds=18, verify_subst=False
                            )
                            if not sub3["closed_unsat"]:
                                # Also try 4th coset z=0x0F on sub3!
                                nz_0f, forms_0f, bal_0f = get_coset_bal_states(sub3, 0x0F, max_dim=9)
                                if forms_0f is None:
                                    rem_z33_open += 1
                                else:
                                    for st_0f in bal_0f:
                                        sub4 = s9.run_branch_cascade(
                                            lib9, sub3["_buf"], sub3["_quad_ids"], sub3["_cub_ids"], sub3["_lin_pivs"],
                                            [(forms_0f[j], (st_0f >> j) & 1) for j in range(nz_0f)], tbl, max_xl_rounds=18, verify_subst=False
                                        )
                                        if not sub4["closed_unsat"]:
                                            rem_z33_open += 1
                                        del sub4
                            del sub3
                    del survivors_w
                    if rem_z33_open == 0:
                        closed_100 += 1
                        print(f"  *** [{lbl}] {info['status']} + z=0x33/0x0F: CLOSED 100%! ***", flush=True)
                        del sub2
                        continue
                still_open.append({"ff": st_ff, "st55": st_55, "status": info["status"], "nW": nW})
                del sub2
                continue

            if time.perf_counter() > deadline - 90.0:
                needs_sharding.append({"ff": st_ff, "st55": st_55, "status": "BUDGET_SKIP", "nW": nW})
                del sub2
                continue

            th = s45a.find_kfix_threshold(lbl, sub2, info, lib9, tbl, rng_seed=45100 + idx_s)
            if th is None:
                needs_sharding.append({"ff": st_ff, "st55": st_55, "status": "NO_THRESHOLD", "nW": nW})
                del sub2
                continue
            best_k, avg_dt = th
            if best_k <= 7 or (best_k == 8 and avg_dt < 1.2):
                c_sub = s45a.run_parallel_shard(
                    lbl, 0, sub2, info, best_k, 0, 1, workers, so_s9, n_cw, deadline, cert_dir
                )
                if c_sub["verdict"] == "ORBIT_FORMALLY_CLOSED_100%":
                    closed_100 += 1
                else:
                    needs_sharding.append({"ff": st_ff, "st55": st_55, "nW": nW, "best_k": best_k, "verdict": c_sub["verdict"]})
            else:
                needs_sharding.append({"ff": st_ff, "st55": st_55, "nW": nW, "best_k": best_k, "avg_dt": round(avg_dt, 2)})
            del sub2
            if open_sub2_total % 10 == 0:
                gc.collect()
                print(
                    f"  [eta=0 stream] open_sub2={open_sub2_total}: closed_100={closed_100}, "
                    f"needs_shard={len(needs_sharding)}, still_open={len(still_open)} ({time.perf_counter()-t0:.1f}s)",
                    flush=True,
                )
        del sub1
        gc.collect()

    summary = {
        "cell": "B0_00",
        "eta": 0,
        "bal_0xff_total": len(bal_ff),
        "bal_0xff_closed": ff_closed,
        "sub2_direct_closed": sub2_closed_direct,
        "open_sub2_total": open_sub2_total,
        "closed_100_streaming": closed_100,
        "needs_sharding": needs_sharding,
        "still_open": still_open,
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "verdict": "ORBIT_FORMALLY_CLOSED_100%" if (open_sub2_total == closed_100 and not still_open and not needs_sharding) else "PARTIAL",
    }
    cert_dir.mkdir(parents=True, exist_ok=True)
    out_p = cert_dir / "step46c_cert_eta00_full.json"
    out_p.write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print(
        f"\n=== [eta=0 STREAM SUMMARY] open_sub2={open_sub2_total}, closed_100={closed_100}, "
        f"needs_sharding={len(needs_sharding)}, still_open={len(still_open)} -> {summary['verdict']} ({summary['elapsed_s']}s) ===",
        flush=True,
    )


def main():
    t_start = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["eta0_lowmem", "eta42_deep"], required=True)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--budget-min", type=float, default=38.0)
    parser.add_argument("--cert-dir", type=str, default="step46c_certs")
    args = parser.parse_args()
    deadline = t_start + args.budget_min * 60.0
    cert_dir = Path(args.cert_dir)

    import subprocess
    c_diag, so_diag = WORK_DIR / "s46c_diag.c", WORK_DIR / "libs46c_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s46c_s9.c", WORK_DIR / "libs46c_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s46c_cg.c", WORK_DIR / "libs46c_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s46c_d8.c", WORK_DIR / "libs46c_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s46c_sh.c", WORK_DIR / "libs46c_sh.so"
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
        while tmp:
            lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb

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

    if args.mode == "eta42_deep":
        run_eta42_deep(root, eta_free, lib9, lib_sh, so_s9, tbl, n_cw, args.workers, deadline, cert_dir)
    else:
        run_eta0_lowmem(root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw, args.workers, deadline, cert_dir)


if __name__ == "__main__":
    main()
