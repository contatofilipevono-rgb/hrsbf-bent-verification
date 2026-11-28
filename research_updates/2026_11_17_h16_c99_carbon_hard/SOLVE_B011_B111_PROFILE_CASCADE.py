#!/usr/bin/env python3
"""
SOLVE_B011_B111_PROFILE_CASCADE.py

Pure-Algebraic Central-Profile Conditioning Cascade for H(16,4) Open Cells B0_11 and B1_11.
Integrates the central-profile taxonomy (alpha, beta, gamma; Fiber Classes I..IV; B1_11 |W_ff|=64 lemma)
from h16_perfil_central.zip directly into our full C/OpenMP algebraic cascade:
  DIAGNOSE_V2_STRUCTURE + CG(389, true c99) + Q4 + Cyclotomic + XL
    -> Exact Profile Ideal (deg <= 2, then deg == 3, with 10,000-pt direct truth-table Zero-Trust check)
    -> Step 63A (AC180 + AC4115 + D8-PQ72)
    -> Step 64A (Iterative Deep IR6 MAC_D3 if N <= 78)
    -> Step 45A W_ess MinRank (nW, low_bas_dim, k_fix).

Targets (--target):
  1. B011_III_ALPHA : B0_11 (c99=0, force_k=-1 C5-free) Class III (e=5, plus 22,37,54) x Tipo alpha
                      (alpha_union {(-128,+-128)}, alpha_h0 {(-128,+128)}, alpha_h1 {(-128,-128)}).
  2. B011_III_BETA  : B0_11 (c99=0, force_k=-1 C5-free) Class III (e=5, 22) x Tipo beta {(+128, 0)}.
  3. B011_I_BETA    : B0_11 (c99=0, force_k=-1 C5-free) Class I   (e=1, 3)  x Tipo beta {(+128, 0)}.
  4. B111_3TUPLE    : B1_11 (c99=1, force_k=1 proven C5) e=1 (and Root) with tightened 3-tuple
                      {(-64,-64), (-64,+64), (+64,0)} AND each of the 3 individual tuple branches.
"""

import argparse
import json
import sys
import time
from pathlib import Path

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP64A_AC180_MAC3_FUSION as s64a
import SOLVE_B111_B011_POISSON_ALGEBRA as spois


def state_sig(sr):
    if sr["closed_unsat"]:
        return {"closed": True, "dim": 0, "quads": 0, "cubs": 0}
    return {
        "closed": False,
        "dim": 111 - len(sr["_lin_pivs"]),
        "quads": len(sr["_quad_ids"]),
        "cubs": len(sr["_cub_ids"]),
    }


def run_conditioned_branch(env, sr_base, rep_e, branch_label, admiss_set, libs, run_wess=True, run_ac180=True, seed_offset=0):
    """
    Given an already-built fiber state sr_base, extract the exact (0xff, 0x55) profile ideal for admiss_set
    (with 10,000-point direct truth-table Zero-Trust check), inject deg<=2 then deg==3 into s9,
    run Step 63A (AC180+D8-PQ72), optional Step 64A MAC_D3 (if N<=78), and measure W_ess (nW, low_bas_dim, k_fix).
    """
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    tbl = env["tbl"]
    cell_name = env["cell_name"]
    tag = f"{cell_name}_e{rep_e}_{branch_label}"
    print(f"\n--- [{tag}] Admissible (W_ff, W_55) = {sorted(admiss_set)} ---", flush=True)

    out = {
        "cell": cell_name,
        "rep": rep_e,
        "branch": branch_label,
        "admissible_tuples": [list(x) for x in sorted(admiss_set)],
        "baseline": state_sig(sr_base),
    }
    if sr_base["closed_unsat"]:
        out["verdict"] = "CLOSED_AT_BASELINE"
        return out

    f_act = sorted(i for i in range(111) if i not in sr_base["_lin_pivs"])
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_base["_lin_pivs"], f_act)

    pois = spois.extract_poisson_joint_ideal(
        orig_f, basis_f, f_act, admiss_set, max_deg=3, seed=10400 + rep_e * 100 + seed_offset
    )
    out["profile_ideal"] = {k: v for k, v in pois.items() if k not in ("psets_le2", "psets_deg3")}

    if pois.get("closed_directly"):
        out["verdict"] = "CLOSED_BY_EMPTY_PROFILE_IMAGE"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        print(f"  [{tag}] *** CLOSED DIRECTLY: 0 states in fiber attain {sorted(admiss_set)}! ***", flush=True)
        return out

    # Stage 1: Inject deg <= 2 profile ideal into s9
    sr_p2 = sr_base
    if pois["psets_le2"]:
        sr_p2, _ = s60c.inject_psets_into_s9(sr_base, pois["psets_le2"], lib9, tbl)
    out["after_profile_le2"] = state_sig(sr_p2)
    print(f"  [{tag} AFTER PROFILE deg<=2]: {out['after_profile_le2']}", flush=True)

    if sr_p2["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_PROFILE_DEG2"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        print(f"  [{tag}] *** CLOSED UNSAT (0=1) AT PROFILE deg<=2! ***", flush=True)
        return out

    # Stage 2: Inject deg == 3 profile ideal into s9
    sr_p3 = sr_p2
    if pois["psets_deg3"]:
        sr_p3, _ = s60c.inject_psets_into_s9(sr_p2, pois["psets_deg3"], lib9, tbl)
    out["after_profile_le3"] = state_sig(sr_p3)
    print(f"  [{tag} AFTER PROFILE deg<=3]: {out['after_profile_le3']}", flush=True)

    if sr_p3["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_PROFILE_DEG3"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        print(f"  [{tag}] *** CLOSED UNSAT (0=1) AT PROFILE deg<=3! ***", flush=True)
        return out

    # Stage 3: Step 63A (AC180 + AC4115 + D8-PQ72)
    sr_ac = sr_p3
    if run_ac180:
        f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
        orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
        out_st = {}
        s63a.run_autocorr_and_parseval_suite(
            orig_f3, basis_f3, f_act3, sr_p3,
            env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
            env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
            lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
            tag=tag, seed=10500 + rep_e * 100 + seed_offset,
            vq_ctx=None, do_deg4_compare=False, out_states=out_st,
        )
        sr_ac = out_st.get("sub_ac", sr_p3)
        out["ac180_injected_count"] = len(out_st.get("injected_psets", []))
    out["after_ac180"] = state_sig(sr_ac)
    print(f"  [{tag} AFTER AC180]: {out['after_ac180']}", flush=True)

    if sr_ac["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_AC180"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        print(f"  [{tag}] *** CLOSED UNSAT (0=1) AFTER AC180! ***", flush=True)
        return out

    # Stage 4: Step 64A MAC_D3 if N <= 78
    N_cur = 111 - len(sr_ac["_lin_pivs"])
    if N_cur <= 78:
        mac_status, mac_trace = s64a.run_mac_on_substate(
            sr_ac, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=False, tag=tag
        )
        out["mac_d3"] = {"status": mac_status, "trace": mac_trace}
        print(f"  [{tag} MAC_D3]: {mac_status} | {mac_trace}", flush=True)
        if "UNSAT" in mac_status or "1EQ0" in mac_status:
            out["verdict"] = f"CLOSED_{mac_status}"
            out["elapsed_s"] = round(time.perf_counter() - t0, 2)
            return out

    # Stage 5: W_ess MinRank measurement
    if run_wess:
        out["after_wess"] = spois.measure_wess(
            f"{tag}_wess", sr_ac, lib9, lib_sh, tbl, rng_seed=10600 + rep_e * 100 + seed_offset
        )
        print(f"  [{tag} AFTER W_ess]: {out['after_wess']}", flush=True)

    out["verdict"] = "OPEN"
    out["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return out


def run_target(target_name, libs):
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    results = []

    if target_name == "B011_III_ALPHA":
        env = spois.build_cell_root_sound("B0_11", libs)
        tbl = env["tbl"]
        # Primary Class III rep e=5: measure baseline W_ess, then test alpha_union, alpha_h0, alpha_h1
        sr_e5 = spois.fix_a14_fiber(env, 5, lib9)
        base_wess_e5 = spois.measure_wess("B0_11_e5_base", sr_e5, lib9, lib_sh, tbl, rng_seed=10405)
        print(f"\n[B0_11 Class III e=5 BASELINE W_ess]: {base_wess_e5}", flush=True)

        for idx_b, (blabel, aset) in enumerate([
            ("alpha_union", {(-128, 128), (-128, -128)}),
            ("alpha_h0_p128", {(-128, 128)}),
            ("alpha_h1_m128", {(-128, -128)}),
        ]):
            r = run_conditioned_branch(env, sr_e5, 5, blabel, aset, libs, run_wess=True, run_ac180=True, seed_offset=idx_b)
            r["baseline_wess"] = base_wess_e5
            results.append(r)

        # Also test the other 3 Class III reps (e=22, 37, 54) on alpha_union & alpha_h0 (fast cascade check)
        for rep_e in (22, 37, 54):
            sr_e = spois.fix_a14_fiber(env, rep_e, lib9)
            r_u = run_conditioned_branch(
                env, sr_e, rep_e, "alpha_union", {(-128, 128), (-128, -128)},
                libs, run_wess=True, run_ac180=False, seed_offset=10
            )
            results.append(r_u)

    elif target_name == "B011_III_BETA":
        env = spois.build_cell_root_sound("B0_11", libs)
        tbl = env["tbl"]
        for rep_e in (5, 22):
            sr_e = spois.fix_a14_fiber(env, rep_e, lib9)
            base_wess = spois.measure_wess(f"B0_11_e{rep_e}_base", sr_e, lib9, lib_sh, tbl, rng_seed=10500 + rep_e)
            print(f"\n[B0_11 Class III e={rep_e} BASELINE W_ess]: {base_wess}", flush=True)
            r = run_conditioned_branch(
                env, sr_e, rep_e, "beta_128_0", {(128, 0)},
                libs, run_wess=True, run_ac180=(rep_e == 5), seed_offset=20
            )
            r["baseline_wess"] = base_wess
            results.append(r)

    elif target_name == "B011_I_BETA":
        env = spois.build_cell_root_sound("B0_11", libs)
        tbl = env["tbl"]
        for rep_e in (1, 3):
            sr_e = spois.fix_a14_fiber(env, rep_e, lib9)
            base_wess = spois.measure_wess(f"B0_11_e{rep_e}_base", sr_e, lib9, lib_sh, tbl, rng_seed=10600 + rep_e)
            print(f"\n[B0_11 Class I e={rep_e} BASELINE W_ess]: {base_wess}", flush=True)
            r = run_conditioned_branch(
                env, sr_e, rep_e, "beta_128_0", {(128, 0)},
                libs, run_wess=True, run_ac180=(rep_e == 1), seed_offset=30
            )
            r["baseline_wess"] = base_wess
            results.append(r)

    elif target_name == "B111_3TUPLE":
        env = spois.build_cell_root_sound("B1_11", libs)
        tbl = env["tbl"]
        sr_e1 = spois.fix_a14_fiber(env, 1, lib9)
        base_wess = spois.measure_wess("B1_11_e1_base", sr_e1, lib9, lib_sh, tbl, rng_seed=10701)
        print(f"\n[B1_11 e=1 BASELINE W_ess]: {base_wess}", flush=True)

        # Test tightened 3-tuple union AND each of the 3 individual tuples on B1_11 e=1!
        for idx_b, (blabel, aset) in enumerate([
            ("3tuple_union", {(-64, -64), (-64, 64), (64, 0)}),
            ("tuple_m64_m64", {(-64, -64)}),
            ("tuple_m64_p64", {(-64, 64)}),
            ("tuple_p64_0", {(64, 0)}),
        ]):
            r = run_conditioned_branch(
                env, sr_e1, 1, blabel, aset,
                libs, run_wess=True, run_ac180=True, seed_offset=40 + idx_b
            )
            r["baseline_wess"] = base_wess
            results.append(r)

    else:
        raise ValueError(f"Unknown target: {target_name}")

    return results


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--target",
        choices=["B011_III_ALPHA", "B011_III_BETA", "B011_I_BETA", "B111_3TUPLE", "ALL"],
        required=True,
    )
    ap.add_argument("--out-json", type=str, default="profile_cascade_results.json")
    args = ap.parse_args()

    t0 = time.perf_counter()
    libs = spois.compile_c_libs()
    all_res = []
    targets = (
        ["B011_III_ALPHA", "B011_III_BETA", "B011_I_BETA", "B111_3TUPLE"]
        if args.target == "ALL"
        else [args.target]
    )
    for tgt in targets:
        all_res.extend(run_target(tgt, libs))

    payload = {
        "target": args.target,
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "results": all_res,
    }
    Path(args.out_json).write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    print(f"\n=== WRITTEN TO {args.out_json} ({payload['elapsed_s']}s) ===", flush=True)
    print(json.dumps(payload, indent=2), flush=True)


if __name__ == "__main__":
    main()
