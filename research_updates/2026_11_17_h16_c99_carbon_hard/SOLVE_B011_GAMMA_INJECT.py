#!/usr/bin/env python3
"""
SOLVE_B011_GAMMA_INJECT.py

Pure-Algebraic Tipo-Gamma Generator Injection (e=2 Class II, e=13 Class IV) &
Full 36-Representative Post-Cascade Profile Survival Census for B0_11 (C5-free, c99=0, force_k=-1).

Jobs (--job):
  1. E2_GP   : B0_11 e=2  (Class II) + gamma+ (inj_e2_gamma+.json:  2L + 63Q + 10C) -> AC180 -> W_ess
  2. E2_GM   : B0_11 e=2  (Class II) + gamma- (inj_e2_gamma-.json:  2L + 63Q + 14C) -> AC180 -> W_ess
  3. E13_GP  : B0_11 e=13 (Class IV) + gamma+ (inj_e13_gamma+.json: 2L + 65Q + 10C) -> AC180 -> W_ess
  4. E13_GM  : B0_11 e=13 (Class IV) + gamma- (inj_e13_gamma-.json: 2L + 65Q + 14C) -> AC180 -> W_ess
  5. SCAN36  : Fast post-cascade (0xff, 0x55) empty-profile-image & ideal-rank census across ALL 36
               B0_11 multiplier-orbit representatives for Tipo alpha+, alpha-, beta, and gamma.
"""

import argparse
import json
import random
import sys
import time
from itertools import combinations
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
GAMMA_INJ_DIR = WORK_DIR / "gamma_inj"
sys.path.insert(0, str(WORK_DIR))

import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP64A_AC180_MAC3_FUSION as s64a
import SOLVE_B111_B011_POISSON_ALGEBRA as spois

ALL_B011_REPS = [
    1, 2, 3, 5, 8, 9, 11, 13, 15, 19, 21, 22, 23, 27, 29, 31, 33, 34,
    35, 37, 40, 41, 43, 45, 47, 51, 53, 54, 55, 59, 61, 63, 87, 93, 119, 125,
]

# Exact spectral targets for gamma+ (h=2) and gamma- (h=6) on the 8 cosets used by gam_gens.py
GAMMA_TARGETS = {
    "gamma+": {0xFF: 0, 0x55: 64, 0x33: 0, 0x11: 32, 0x77: -32, 0x01: 0, 0x0F: 0, 0x2D: 0},
    "gamma-": {0xFF: 0, 0x55: 64, 0x33: 0, 0x11: -32, 0x77: 32, 0x01: 0, 0x0F: 0, 0x2D: 0},
}


def state_sig(sr):
    if sr["closed_unsat"]:
        return {"closed": True, "dim": 0, "quads": 0, "cubs": 0}
    return {
        "closed": False,
        "dim": 111 - len(sr["_lin_pivs"]),
        "quads": len(sr["_quad_ids"]),
        "cubs": len(sr["_cub_ids"]),
    }


def load_and_verify_gamma_json(json_path, rep_e, gname, sr_base, env, seed=11600):
    """
    Load inj_e{e}_{gamma±}.json, verify 100% variable-indexing compatibility with sr_base['_lin_pivs'],
    convert lin + polys into 111-var psets (split into deg<=2 and deg==3), and run a targeted
    Zero-Trust truth-table check on the post-cascade fiber!
    """
    raw = json.loads(Path(json_path).read_text(encoding="utf-8"))
    entry = raw[str(rep_e)]
    lin_list = entry.get("lin", [])
    poly_list = entry.get("polys", [])

    f_act = sorted(i for i in range(111) if i not in sr_base["_lin_pivs"])
    f_act_set = set(f_act)

    # 1. Verify EVERY variable index in inj_e*.json is an active (free) variable of sr_base!
    all_vars_used = {v for vars_, _ in lin_list for v in vars_} | {v for p in poly_list for m in p for v in m}
    leaked_pivs = sorted(all_vars_used - f_act_set)
    assert not leaked_pivs, (
        f"INDEX MISMATCH: {json_path} uses pivot variables {leaked_pivs} not in f_act (len={len(f_act)})!"
    )

    # 2. Convert lin_list and poly_list to 111-var psets (bitmasks over 0..110, 0 = constant 1)
    psets_lin = []
    for vars_, c in lin_list:
        ps = {1 << int(v) for v in vars_}
        if int(c) & 1:
            ps.add(0)
        if ps:
            psets_lin.append(ps)

    psets_deg2 = []
    psets_deg3 = []
    for p in poly_list:
        ps = set()
        for mono in p:
            m_mask = 0
            for v in mono:
                m_mask |= 1 << int(v)
            if m_mask in ps:
                ps.remove(m_mask)
            else:
                ps.add(m_mask)
        if not ps:
            continue
        max_d = max(m.bit_count() for m in ps)
        if max_d <= 2:
            psets_deg2.append(ps)
        elif max_d == 3:
            psets_deg3.append(ps)
        else:
            raise ValueError(f"Unexpected degree {max_d} in {json_path}")

    # 3. Targeted Zero-Trust Check on the (0xff, 0x55) = (0, 64) & (0x33) = 0 subspace:
    # Also extract our own exact (0xff, 0x55) = (0, 64) ideal (with 10,000-pt ZT verification!)
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_base["_lin_pivs"], f_act)
    pois_g = spois.extract_poisson_joint_ideal(
        orig_f, basis_f, f_act, {(0, 64)}, max_deg=3, seed=seed + rep_e
    )

    # Direct truth-table verification of the 2 linear equations in psets_lin on all points hitting
    # (W_55 == 64, W_33 == 0, W_11 == tgt[0x11], W_77 == tgt[0x77])!
    tgt = GAMMA_TARGETS[gname]
    z_check = (0x55, 0x33, 0x11, 0x77)
    idx_map = {z: np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.int32) for z in z_check}
    o_z = {z: orig_f[idx_map[z]] for z in z_check}
    b_z = {z: basis_f[:, idx_map[z]] for z in z_check}

    def eval_ps(ps, x111):
        val = 0
        for mon in ps:
            if (x111 & mon) == mon:
                val ^= 1
        return val

    # Solve the 2 linear equations + (0xff, 0x55) linear equations to sample points satisfying W_55=64
    rng = random.Random(seed + 77)
    n_q_match = 0
    n_q_viol_lin = 0
    n_q_viol_poly = 0
    N = len(f_act)
    for _ in range(15000):
        x111 = 0
        # First check W_55 == 64 fast!
        c55 = o_z[0x55].copy()
        picks = [rng.getrandbits(1) for _ in range(N)]
        for i, bit in enumerate(picks):
            if bit:
                x111 |= 1 << f_act[i]
                c55 ^= b_z[0x55][i]
        if 256 - 2 * int(c55.sum()) != 64:
            continue
        c33 = o_z[0x33].copy()
        for i, bit in enumerate(picks):
            if bit:
                c33 ^= b_z[0x33][i]
        if 256 - 2 * int(c33.sum()) != 0:
            continue
        c11 = o_z[0x11].copy()
        for i, bit in enumerate(picks):
            if bit:
                c11 ^= b_z[0x11][i]
        if 256 - 2 * int(c11.sum()) != tgt[0x11]:
            continue
        c77 = o_z[0x77].copy()
        for i, bit in enumerate(picks):
            if bit:
                c77 ^= b_z[0x77][i]
        if 256 - 2 * int(c77.sum()) != tgt[0x77]:
            continue
        n_q_match += 1
        if any(eval_ps(ps, x111) for ps in psets_lin):
            n_q_viol_lin += 1
    assert n_q_viol_lin == 0, f"ZT FAIL: {n_q_viol_lin}/{n_q_match} points matching Q=(55,33,11,77) violated psets_lin!"
    print(
        f"  [ZT GAMMA JSON {Path(json_path).name}] active_vars_used={len(all_vars_used)}/{len(f_act)} (0 pivot leaks), "
        f"lin={len(psets_lin)}, deg2={len(psets_deg2)}, deg3={len(psets_deg3)} | "
        f"Q=(55,33,11,77) ZT matches={n_q_match} (lin_viol=0)",
        flush=True,
    )

    return {
        "file": Path(json_path).name,
        "active_vars_used": len(all_vars_used),
        "fiber_active_vars": len(f_act),
        "pivot_leaks": 0,
        "n_lin": len(psets_lin),
        "n_deg2": len(psets_deg2),
        "n_deg3": len(psets_deg3),
        "zt_q_matches": n_q_match,
        "zt_q_lin_violations": n_q_viol_lin,
        "poisson_ff55_zt": pois_g["zt_10k"],
        "psets_le2": psets_lin + psets_deg2 + pois_g["psets_le2"],
        "psets_deg3": psets_deg3 + pois_g["psets_deg3"],
    }


def run_gamma_job(rep_e, gname, json_filename, libs):
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    env = spois.build_cell_root_sound("B0_11", libs)
    tbl = env["tbl"]

    sr_base = spois.fix_a14_fiber(env, rep_e, lib9)
    base_wess = spois.measure_wess(f"B0_11_e{rep_e}_base", sr_base, lib9, lib_sh, tbl, rng_seed=11600 + rep_e)
    print(f"\n[B0_11 e={rep_e} BASELINE W_ess]: {base_wess}", flush=True)

    ginfo = load_and_verify_gamma_json(
        GAMMA_INJ_DIR / json_filename, rep_e, gname, sr_base, env, seed=11600 + (1 if gname == "gamma+" else 2)
    )

    tag = f"B0_11_e{rep_e}_{gname}"
    out = {
        "cell": "B0_11",
        "rep": rep_e,
        "profile": gname,
        "baseline": state_sig(sr_base),
        "baseline_wess": base_wess,
        "gamma_generators": {k: v for k, v in ginfo.items() if k not in ("psets_le2", "psets_deg3")},
    }

    # Stage 1: Inject lin + deg<=2 into s9 (using fixed pre-substituted inject_psets_into_s9)
    sr_p2, _ = s60c.inject_psets_into_s9(sr_base, ginfo["psets_le2"], lib9, tbl)
    out["after_gamma_le2"] = state_sig(sr_p2)
    print(f"  [{tag} AFTER GAMMA lin+deg<=2]: {out['after_gamma_le2']}", flush=True)
    if sr_p2["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_GAMMA_DEG2"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 2: Inject deg==3 into s9
    sr_p3, _ = s60c.inject_psets_into_s9(sr_p2, ginfo["psets_deg3"], lib9, tbl)
    out["after_gamma_le3"] = state_sig(sr_p3)
    print(f"  [{tag} AFTER GAMMA deg<=3]: {out['after_gamma_le3']}", flush=True)
    if sr_p3["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_GAMMA_DEG3"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 3: Step 63A (AC180 + AC4115 + D8-PQ72)
    f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
    orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
    out_st = {}
    s63a.run_autocorr_and_parseval_suite(
        orig_f3, basis_f3, f_act3, sr_p3,
        env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
        env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
        lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
        tag=tag, seed=11700 + rep_e,
        vq_ctx=None, do_deg4_compare=False, out_states=out_st,
    )
    sr_ac = out_st.get("sub_ac", sr_p3)
    out["ac180_injected_count"] = len(out_st.get("injected_psets", []))
    out["after_ac180"] = state_sig(sr_ac)
    print(f"  [{tag} AFTER AC180]: {out['after_ac180']}", flush=True)
    if sr_ac["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_AC180"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 4: Optional MAC_D3 if N <= 78
    if (111 - len(sr_ac["_lin_pivs"])) <= 78:
        mac_status, mac_trace = s64a.run_mac_on_substate(
            sr_ac, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=False, tag=tag
        )
        out["mac_d3"] = {"status": mac_status, "trace": mac_trace}

    # Stage 5: Post-Gamma + AC180 W_ess MinRank measurement
    out["after_wess"] = spois.measure_wess(f"{tag}_wess", sr_ac, lib9, lib_sh, tbl, rng_seed=11800 + rep_e)
    print(f"  [{tag} AFTER W_ess]: {out['after_wess']}", flush=True)
    out["verdict"] = "OPEN"
    out["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return out


def run_scan36(libs):
    """
    Fast post-cascade (0xff, 0x55) empty-profile-image & ideal-rank scan across ALL 36 B0_11 reps
    for Tipo alpha+ (-128,+128), alpha- (-128,-128), alpha_union, beta (+128,0), and gamma (0,+64).
    """
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    env = spois.build_cell_root_sound("B0_11", libs)

    idx_ff = np.array([u | ((u ^ 0xFF) << 8) for u in range(256)], dtype=np.int32)
    idx_55 = np.array([u | ((u ^ 0x55) << 8) for u in range(256)], dtype=np.int32)
    mask256 = (1 << 256) - 1

    def pack512(tt):
        w_ff = int.from_bytes(np.packbits(tt[idx_ff], bitorder="little").tobytes(), "little")
        w_55 = int.from_bytes(np.packbits(tt[idx_55], bitorder="little").tobytes(), "little")
        return w_ff | (w_55 << 256)

    profile_types = [
        ("alpha_p", {(-128, 128)}),
        ("alpha_m", {(-128, -128)}),
        ("alpha_union", {(-128, 128), (-128, -128)}),
        ("beta", {(128, 0)}),
        ("gamma", {(0, 64)}),
    ]

    rows_out = []
    dead_counts = {pname: [] for pname, _ in profile_types}

    for rep_e in ALL_B011_REPS:
        te = time.perf_counter()
        sr = spois.fix_a14_fiber(env, rep_e, lib9)
        if sr["closed_unsat"]:
            for pname, _ in profile_types:
                dead_counts[pname].append(rep_e)
            rows_out.append({"rep": rep_e, "closed_at_baseline": True})
            continue

        f_act = sorted(i for i in range(111) if i not in sr["_lin_pivs"])
        orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr["_lin_pivs"], f_act)

        o_word = pack512(orig_f)
        b_words = [pack512(basis_f[i]) for i in range(len(f_act))]
        piv = {}
        B = []
        for bw in b_words:
            v = bw
            while v:
                p = v.bit_length() - 1
                if p not in piv:
                    B.append(v)
                    piv[p] = v
                    break
                v ^= piv[p]
        d = len(B)
        span_w = [o_word]
        for b in B:
            span_w += [x ^ b for x in span_w]

        tuples_at_y = []
        hist = {}
        for w in span_w:
            t_pair = (256 - 2 * (w & mask256).bit_count(), 256 - 2 * (w >> 256).bit_count())
            tuples_at_y.append(t_pair)
            hist[t_pair] = hist.get(t_pair, 0) + 1

        mons = [0]
        for deg in (1, 2, 3):
            for comb in combinations(range(d), deg):
                mons.append(sum(1 << c for c in comb))

        rep_info = {
            "rep": rep_e,
            "baseline": state_sig(sr),
            "joint_ff55_dim": d,
            "total_states": 1 << d,
            "attained_tuples": {f"({k[0]},{k[1]})": v for k, v in sorted(hist.items())},
            "profiles": {},
            "elapsed_s": round(time.perf_counter() - te, 2),
        }

        for pname, aset in profile_types:
            S = [y for y, tp in enumerate(tuples_at_y) if tp in aset]
            if not S:
                dead_counts[pname].append(rep_e)
                rep_info["profiles"][pname] = {"states": 0, "status": "CLOSED_0.00S_EMPTY_IMAGE"}
            else:
                piv_ev = {}
                vanish = {1: 0, 2: 0, 3: 0}
                for mon in mons:
                    ev = 0
                    for si, y in enumerate(S):
                        if (y & mon) == mon:
                            ev |= 1 << si
                    deg = mon.bit_count()
                    while ev:
                        b = ev.bit_length() - 1
                        if b in piv_ev:
                            ev ^= piv_ev[b]
                        else:
                            piv_ev[b] = ev
                            break
                    if ev == 0 and deg >= 1:
                        vanish[deg] += 1
                rep_info["profiles"][pname] = {
                    "states": len(S),
                    "status": "ALIVE",
                    "ideal_deg_1_2_3": vanish,
                }

        print(
            f"  [SCAN36 e={rep_e:3d}] base=({rep_info['baseline']['dim']},{rep_info['baseline']['quads']},{rep_info['baseline']['cubs']}) "
            f"d={d} | alpha_u={rep_info['profiles']['alpha_union']['states']} "
            f"beta={rep_info['profiles']['beta']['states']} "
            f"gamma={rep_info['profiles']['gamma']['states']}",
            flush=True,
        )
        rows_out.append(rep_info)

    summary = {
        "total_reps": len(ALL_B011_REPS),
        "closed_0s_by_empty_image": {k: {"count": len(v), "reps": v} for k, v in dead_counts.items()},
        "alive_counts": {k: len(ALL_B011_REPS) - len(v) for k, v in dead_counts.items()},
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "reps": rows_out,
    }
    print(f"\n=== [SCAN36 SUMMARY] closed_0s_by_empty_image = {summary['closed_0s_by_empty_image']} ===", flush=True)
    return summary


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--job",
        choices=["E2_GP", "E2_GM", "E13_GP", "E13_GM", "SCAN36"],
        required=True,
    )
    ap.add_argument("--out-json", type=str, default="b011_gamma_inject_out.json")
    args = ap.parse_args()

    libs = spois.compile_c_libs()
    if args.job == "E2_GP":
        res = run_gamma_job(2, "gamma+", "inj_e2_gamma+.json", libs)
    elif args.job == "E2_GM":
        res = run_gamma_job(2, "gamma-", "inj_e2_gamma-.json", libs)
    elif args.job == "E13_GP":
        res = run_gamma_job(13, "gamma+", "inj_e13_gamma+.json", libs)
    elif args.job == "E13_GM":
        res = run_gamma_job(13, "gamma-", "inj_e13_gamma-.json", libs)
    elif args.job == "SCAN36":
        res = run_scan36(libs)
    else:
        raise ValueError(args.job)

    Path(args.out_json).write_text(json.dumps(res, indent=2) + "\n", encoding="utf-8")
    print(f"\n=== WRITTEN TO {args.out_json} ===", flush=True)


if __name__ == "__main__":
    main()
