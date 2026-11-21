#!/usr/bin/env python3
r"""
SOLVE_STEP58C_GCP_12VCPU_FES_ORBIT_BASES.py

12-vCPU GCP PARALLEL WORKER (startodonto7@gmail.com) FOR B0_11 & B1_11:
  Completes the 100% (40/40) Z_16^x-orbit optimization map & saves exact U_opt bases
  for our Bouillaguet FES Gray-Code AVX2 256-Way Global Orbit Closer:
    - Phase 1 (2 processes, < 4 GB RAM): extracts compact pencils for all 20 B0_11 + 20 B1_11 orbits.
    - Phase 2 (12 parallel workers, 100% CPU saturation):
      For each of the 40 orbits, sweeps d1 across [25..12] with greedy (KR+V0) optimization
      to find:
        1) best_d1_fes: largest d1 where Round-1 (KR+V0) alone gives rK_rem <= 6 (direct FES AVX2!)
           + saves exact U_opt basis rows as bitmasks!
        2) best_d1_rK0: largest d1 where uncapped SysB hits rK == 0 (closes all 14 prior None orbits!)
  Saves full JSON to /tmp/gcp_step58c_fes_orbit_bases.json.
"""

import ctypes
import json
import os
import subprocess
import sys
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path
import numpy as np

REPO_DIR = Path("/tmp/hrsbf-bent-verification/research_updates/2026_11_17_h16_c99_carbon_hard")
if not REPO_DIR.exists():
    REPO_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(REPO_DIR))

import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b
import SOLVE_STEP57C_GCP_12VCPU_ALL_ORBITS as s57c


def pack_u_opt(U):
    """Pack (nW, nW) uint8 matrix as list of int bitmasks."""
    res = []
    for row in U:
        m = 0
        for j, b in enumerate(row):
            if b:
                m |= (1 << j)
        res.append(int(m))
    return res


def phase2_worker_fes_orbit(item):
    cell_name, em, nW, M0_c, Mk_c = item
    t0 = time.perf_counter()
    pid = os.getpid()
    so_s9 = Path(f"/tmp/libs9_58c_{pid}.so")
    if not so_s9.exists():
        c_s9 = Path(f"/tmp/s9_58c_{pid}.c")
        c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
        subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    rK_init = int(M0_c.shape[1])
    d1_cands = [25, 24, 22, 20, 19, 18, 17, 16, 15, 14, 12] if cell_name == "B0_11" else [20, 19, 18, 17, 16, 15, 14, 13, 12]

    best_d1_fes = None
    best_rK_fes = None
    best_U_fes = None
    best_d1_rK0 = None
    best_U_rK0 = None
    d1_summary = {}

    for d1 in d1_cands:
        U_opt, Mu_opt, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d1, em_seed=em)
        r1_elim = int(bkey[0])
        rK_rem_r1 = rK_init - r1_elim
        # Run uncapped SysB only if we haven't found best_d1_rK0 yet (saves time!)
        rK_sysb = None
        if best_d1_rK0 is None:
            rK_sysb_val, lg = s55b.run_cascade_uncapped(M0_c, Mu_opt, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
            rK_sysb = int(rK_sysb_val)
            if rK_sysb == 0:
                best_d1_rK0 = d1
                best_U_rK0 = U_opt.copy()
        else:
            lg = []

        d1_summary[d1] = {
            "r1_key": [int(x) for x in bkey],
            "rK_rem_r1": int(rK_rem_r1),
            "rK_sysb": rK_sysb,
        }

        if rK_rem_r1 <= 6 and best_d1_fes is None:
            best_d1_fes = d1
            best_rK_fes = rK_rem_r1
            best_U_fes = U_opt.copy()

        # Once we have BOTH best_d1_fes (rK_rem_r1 <= 6) AND best_d1_rK0, we can stop early!
        if best_d1_fes is not None and best_d1_rK0 is not None:
            break

    rec = {
        "cell": cell_name,
        "eta": int(em),
        "nW": int(nW),
        "mR": int(M0_c.shape[0]),
        "rK_init": rK_init,
        "best_d1_fes": best_d1_fes,
        "best_rK_fes": best_rK_fes,
        "NT1_fes": (int(nW - best_d1_fes) if best_d1_fes is not None else None),
        "best_d1_rK0": best_d1_rK0,
        "NT1_rK0": (int(nW - best_d1_rK0) if best_d1_rK0 is not None else None),
        "U_opt_fes": (pack_u_opt(best_U_fes) if best_U_fes is not None else None),
        "U_opt_rK0": (pack_u_opt(best_U_rK0) if best_U_rK0 is not None else None),
        "d1_summary": d1_summary,
        "elapsed_s": round(time.perf_counter() - t0, 2),
    }
    print(
        f"  [{cell_name} eta={em:2d}] FES: d1={best_d1_fes}(rK_rem={best_rK_fes}, NT1={rec['NT1_fes']}) | "
        f"SysB: d1={best_d1_rK0}(NT1={rec['NT1_rK0']}) ({rec['elapsed_s']}s)",
        flush=True,
    )
    return rec


def main():
    t0 = time.perf_counter()
    print("==================== STEP 58C: 12-vCPU GCP FES ORBIT BASIS MAPPER (40/40 ORBITS) ====================", flush=True)

    all_items = []
    with ProcessPoolExecutor(max_workers=2) as ex1:
        futs1 = [ex1.submit(s57c.phase1_extract_cell_pencils, c) for c in ("B0_11", "B1_11")]
        for f in as_completed(futs1):
            all_items.extend(f.result())

    print(f"\n  [Phase 2] Launching 12-vCPU parallel FES basis mapping across {len(all_items)} orbits...", flush=True)
    all_results = []
    with ProcessPoolExecutor(max_workers=12) as ex2:
        futs2 = [ex2.submit(phase2_worker_fes_orbit, item) for item in all_items]
        for f in as_completed(futs2):
            all_results.append(f.result())

    all_results.sort(key=lambda r: (r["cell"], r["eta"]))
    out_path = Path("/tmp/gcp_step58c_fes_orbit_bases.json")
    out_path.write_text(json.dumps({
        "total_time_s": round(time.perf_counter() - t0, 2),
        "n_records": len(all_results),
        "records": all_results,
    }, indent=2), encoding="utf-8")
    print(f"==================== STEP 58C DONE in {time.perf_counter()-t0:.1f}s (saved {out_path}) ====================", flush=True)


if __name__ == "__main__":
    main()
