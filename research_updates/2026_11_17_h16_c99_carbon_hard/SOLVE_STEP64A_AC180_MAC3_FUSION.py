#!/usr/bin/env python3
"""
H(16,4) STEP 64A — ALGEBRAIC FUSION: AC180+D8 AUTOCORR INJECTION -> DEEP IR6 MAC_D3 + TARGETED MAC_D4!
=====================================================================================================
In Step 63A (Run 44972834860), injecting 60-62 ZT-verified deg<=3 AC180 + D_8 autocorrelation
equations into s9 shattered ALL 217-227 cubics to c=0 and added +31..+35 brand-new quadratics
on B0_11 d1=28 (k_fix=16) (`N=69, q: 205->240, c: 217->0`) and dropped `-2` linear vars + `+314`
quadratics on B1_11 d1=20 (`N: 59->57, q: 560->874`), but NEVER ran MAC_D3/MAC_D4 afterwards!

This script fuses Step 63A + Step 63B (both 100% Zero-Trust verified!):
  1. On frontier open fibers:
       * B0_11: eta=5, 0 at d1=28 (k_fix=16) and d1=30 (k_fix=14)
       * B1_11: eta=3, 0, 10 at d1=22 (k_fix=23) and d1=24 (k_fix=21)
     using BOTH `s57b.optimize_u1_basis` AND `s60b.optimize_u1_joint`!
  2. Extracts & 50-sample direct 65,536-pt truth-table Zero-Trust verifies ALL `AC180 + D_8`
     deg<=3 equations AND `Joint V13(45) + AC_DEG4(40)` deg<=3 drops.
  3. Injects ALL verified deg<=3 equations jointly into `s9`.
  4. Immediately runs Zero-Trust planted-solution audited `Iterative Deep IR6 MAC_D3 <-> s9`
     (up to 4 outer rounds!) + `Targeted MAC_D4 (K=10, q_sub=240)` if still open!
"""

import argparse
import os
import random
import sys
import time
import numpy as np

THIS_DIR = os.path.dirname(os.path.abspath(__file__))
if THIS_DIR not in sys.path:
    sys.path.insert(0, THIS_DIR)

import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b
import SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK as s60b
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP63B_MAC_D4_AND_DEEP_XL_SHATTER as s63b


def run_mac_on_substate(sub, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=True, d4_k=10, d4_max_pivs=75000, tag=""):
    """Run Iterative Deep IR6 MAC_D3 <-> s9 + optional Targeted MAC_D4 on an already-built s9 state."""
    if sub["closed_unsat"]:
        return "S9_AC_UNSAT", "s9_closed_after_ac"

    trace = []
    zt_checked = 0
    for out_rd in range(1, max_outer + 1):
        q_ids = list(sub["_quad_ids"])
        c_ids = list(sub["_cub_ids"])
        psets = [s9.row_to_pset(sub["_buf"], rid, tbl) for rid in q_ids + c_ids]
        active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(tbl["n"]) if (m >> b) & 1})
        N = len(active_vars)
        if N == 0 or N > 78:
            trace.append(f"R{out_rd}:N={N},q={len(q_ids)},c={len(c_ids)}->STOP_N")
            break

        vmap = {v: i for i, v in enumerate(active_vars)}
        compact_polys = []
        for ps in psets:
            if not ps:
                continue
            if ps == {0}:
                return "S9_1EQ0", "1eq0"
            terms = []
            for m in ps:
                if m == 0:
                    terms.append(())
                else:
                    terms.append(tuple(sorted(vmap[b] for b in range(tbl["n"]) if (m >> b) & 1)))
            compact_polys.append(terms)

        # Zero-Trust planted audit on MAC_D3
        if zt_checked == 0:
            rng_p = random.Random(6401 + N)
            x_pl = [rng_p.getrandbits(1) for _ in range(N)]
            hit_pl, lin_pl, quad_pl, _, _, _ = s63b.run_mac_d3_deep_c(
                compact_polys, N, lib63, max_ir=2, max_boot_q=150, planted_x=x_pl
            )
            assert not hit_pl, f"ZT FAIL [{tag}]: Planted MAC_D3 triggered false 1=0!"
            for lp in lin_pl + quad_pl[:40]:
                val = 0
                for t in lp:
                    if len(t) == 0 or all(x_pl[i] for i in t):
                        val ^= 1
                assert val == 0, f"ZT FAIL [{tag}]: Planted MAC_D3 derived row violated!"
            zt_checked = 1

        t_m = time.perf_counter()
        hit_1eq0, lin_polys, quad_polys, n_pivs, n_cols_c, lg_in = s63b.run_mac_d3_deep_c(
            compact_polys, N, lib63, max_ir=max_ir, max_boot_q=400, planted_x=None
        )
        dt_m = time.perf_counter() - t_m
        in_str = ",".join(lg_in)

        if hit_1eq0:
            trace.append(f"R{out_rd}(N={N},q={len(q_ids)},c={len(c_ids)}):MAC_D3_1EQ0[{in_str}]({dt_m:.1f}s)")
            return f"MAC_D3_1EQ0_R{out_rd}", " -> ".join(trace)

        trace.append(f"R{out_rd}(N={N},q={len(q_ids)},c={len(c_ids)}):[{in_str}]({dt_m:.1f}s)")

        # If MAC_D3 found new linear equations, feed them back into s9!
        if lin_polys:
            ex_lin = []
            for lp in lin_polys:
                fm, rhs = 0, 0
                for t in lp:
                    if len(t) == 0:
                        rhs ^= 1
                    else:
                        fm ^= (1 << active_vars[t[0]])
                if fm != 0 or rhs != 0:
                    ex_lin.append((fm, rhs))
            if ex_lin:
                sub = s9.run_branch_cascade(
                    lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                    ex_lin, tbl, max_xl_rounds=25, verify_subst=False
                )
                if sub["closed_unsat"]:
                    trace.append("S9_UNSAT(1=0!)")
                    return f"S9_AFTER_MAC_R{out_rd}_UNSAT", " -> ".join(trace)
                continue

        # No linear drops -> optional Targeted / High-RAM MAC_D4 on final open state
        if do_d4 and len(c_ids) == 0 and N <= 74:
            q_lim = min(250, len(compact_polys))
            # ZT planted check on MAC_D4 (use K=min(10, d4_k) for fast planted check + full K)
            rng_d4 = random.Random(6499 + N)
            x_pl = [rng_d4.getrandbits(1) for _ in range(N)]
            hit_p4, lp4, qp4, _, _, _, _ = s63b.run_mac_d4_c(
                compact_polys, N, K=min(10, d4_k), lib63=lib63, do_d4_mults=True,
                q_sub_limit=min(150, q_lim), max_pivs=25000, planted_x=x_pl
            )
            assert not hit_p4, f"ZT FAIL [{tag}]: Planted MAC_D4_SUB false 1=0!"
            t_d4 = time.perf_counter()
            hit4, l4, q4, c4_new, rk4, nc4, ovf4 = s63b.run_mac_d4_c(
                compact_polys, N, K=d4_k, lib63=lib63, do_d4_mults=True,
                q_sub_limit=q_lim, max_pivs=d4_max_pivs, planted_x=None
            )
            dt4 = time.perf_counter() - t_d4
            trace.append(
                f"MAC_D4_SUB(N={N},K={d4_k},q={q_lim}):hit={hit4},rk={rk4}/{nc4},"
                f"l={len(l4)},q+={len(q4)},c+={c4_new},ovf={ovf4}({dt4:.1f}s)"
            )
            if hit4:
                return f"MAC_D4_1EQ0_R{out_rd}", " -> ".join(trace)
            # If High-RAM MAC_D4 found new linear or quadratic equations, feed back into s9!
            if l4 or q4:
                ex_new = []
                for lp in l4:
                    fm, rhs = 0, 0
                    for t in lp:
                        if len(t) == 0:
                            rhs ^= 1
                        else:
                            fm ^= (1 << active_vars[t[0]])
                    if fm != 0 or rhs != 0:
                        ex_new.append((fm, rhs))
                if ex_new:
                    sub = s9.run_branch_cascade(
                        lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                        ex_new, tbl, max_xl_rounds=25, verify_subst=False
                    )
                    if sub["closed_unsat"]:
                        trace.append("S9_AFTER_D4_UNSAT(1=0!)")
                        return f"S9_AFTER_D4_R{out_rd}_UNSAT", " -> ".join(trace)
                    continue
        break

    return "OPEN", " -> ".join(trace)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    ap.add_argument("--highmem-k", type=int, default=10)
    ap.add_argument("--max-pivs", type=int, default=75000)
    ap.add_argument("--only-frontier", action="store_true")
    args = ap.parse_args()
    cell_name = args.cell
    d4_k = args.highmem_k
    d4_max_pivs = args.max_pivs
    t0 = time.perf_counter()

    print(
        f"==================== [{cell_name}] STEP 64A: AC180+D8 -> DEEP IR6 MAC_D3 + MAC_D4(K={d4_k}, max_pivs={d4_max_pivs}) ====================",
        flush=True,
    )

    # Setup environment identically to Step 63A + compile Step 63B MAC_D3/D4 C engine
    env = s63a.setup_cell_env(cell_name)
    lib_ac, lib_d4, lib9, lib_sh = env["lib_ac"], env["lib_d4"], env["lib9"], env["lib_sh"]
    tbl, root, eta_free = env["tbl"], env["root"], env["eta_free"]
    o_tt_111, b_tt_111 = env["o_tt_111"], env["b_tt_111"]
    all_shifts_u16, all_shifts_py = env["all_shifts_u16"], env["all_shifts_py"]
    d8_shifts, struct_set, struct_indices = env["d8_shifts"], env["struct_set"], env["struct_indices"]
    c8_idx_256, z_reps_36, z_reps_py = env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"]
    coord_subs = env["coord_subs"]

    lib63 = s63b.compile_step63b_c()
    s63b.zt_audit_c_engines(lib63)
    print(f"  [{cell_name}] Env + C engines ready ({time.perf_counter()-t0:.1f}s)", flush=True)

    if args.only_frontier:
        jobs = [(5, [28]), (0, [28])] if cell_name == "B0_11" else [(0, [22, 24])]
    elif cell_name == "B0_11":
        jobs = [(5, [28]), (0, [28, 30])]
    else:
        jobs = [(3, [22, 24]), (0, [22, 24]), (10, [22, 24])]

    rng_f = np.random.default_rng(6440)

    for em, d_list in jobs:
        blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6440 + em)
        if blk["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED at eta!", flush=True)
            continue
        sr = blk["sr"]
        W_forms_111 = blk["W_forms_111"]
        nW = blk["nW"]
        M0_c, Mk_c = blk["M0_c"], blk["Mk_c"]
        U_iso_full, _ = s60b.build_iso_extended_basis(blk, seed=6450 + em)
        cand_bases = s61a.build_candidate_full_bases(blk, U_iso_full, em_seed=em)
        t1_rand = rng_f.integers(0, 2, size=nW, dtype=np.uint8)

        print(f"\n  ======== [{cell_name} eta={em}] nW={nW}, M1_strict={M0_c.shape} ========", flush=True)

        for d_free in d_list:
            # Test BOTH U1_m1 (Step 63A basis) and U1_joint (Step 61A basis)
            U_m1, _, _ = s57b.optimize_u1_basis(M0_c, Mk_c, d_free, em_seed=em)
            U_jt, _, src_jt = s61a.optimize_u1_joint(blk, d_free, t1_rand, cand_bases, do_swaps=True)
            basis_list = [("U1_m1", U_m1[:d_free]), (f"U1_jt({src_jt})", U_jt[:d_free])]

            for bname, U1 in basis_list:
                F_sub = s40a.gf2_nullspace_np(U1)
                k_fix = F_sub.shape[0]
                assert k_fix == nW - d_free and np.all(((U1 @ F_sub.T) & 1) == 0)

                fix_forms = []
                for row in F_sub:
                    fm = 0
                    for k in range(nW):
                        if row[k]:
                            fm ^= W_forms_111[k]
                    fix_forms.append(fm)

                print(f"\n    --- [{cell_name} eta={em} {bname} d1={d_free} (k_fix={k_fix})] ---", flush=True)
                closed_cnt = 0
                n_tested = 0
                for tr in range(2):
                    rb = 0 if tr == 0 else int(rng_f.integers(1, 1 << min(30, k_fix)))
                    ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
                    sub = s9.run_branch_cascade(
                        lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                        ex_w, tbl, max_xl_rounds=25, verify_subst=False,
                    )
                    n_tested += 1
                    if sub["closed_unsat"]:
                        closed_cnt += 1
                        print(f"      [f{tr}] BASELINE s9 CLOSED UNSAT", flush=True)
                        continue

                    f_act = sorted(i for i in range(111) if i not in sub["_lin_pivs"])
                    print(f"      [f{tr}] BASELINE OPEN: N={len(f_act)}, q={len(sub['_quad_ids'])}, c={len(sub['_cub_ids'])}", flush=True)

                    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, sub["_lin_pivs"], f_act)
                    out_st = {}
                    s63a.run_autocorr_and_parseval_suite(
                        orig_f, basis_f, f_act, sub,
                        all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
                        c8_idx_256, z_reps_36, z_reps_py,
                        lib_ac, lib_d4, lib9, tbl, coord_subs,
                        tag=f"{cell_name}_e{em}_{bname}_d{d_free}_f{tr}",
                        seed=64500 + em * 100 + d_free * 10 + tr,
                        vq_ctx=None,
                        do_deg4_compare=True,
                        out_states=out_st,
                    )

                    # Combine BOTH AC180+D8 deg<=3 AND Joint V13+AC deg<=3 drops into s9!
                    all_new = list(out_st.get("injected_psets", [])) + list(out_st.get("j_drops", []))
                    sub_fused = out_st.get("sub_ac", sub)
                    if out_st.get("j_drops") and not sub_fused["closed_unsat"]:
                        sub_fused, _ = s60c.inject_psets_into_s9(sub_fused, out_st["j_drops"], lib9, tbl)

                    N_fu = 111 - len(sub_fused["_lin_pivs"])
                    q_fu = len(sub_fused["_quad_ids"])
                    c_fu = len(sub_fused["_cub_ids"])
                    print(
                        f"      [f{tr}] POST-AC+V13 FUSION s9: CLOSED={sub_fused['closed_unsat']}, "
                        f"N={N_fu}, q={q_fu}, c={c_fu} (injected {len(all_new)} ZT-verified eqs)",
                        flush=True,
                    )

                    status, tr_str = run_mac_on_substate(
                        sub_fused, tbl, lib9, lib63, max_outer=4, max_ir=6,
                        do_d4=(tr == 0), d4_k=d4_k, d4_max_pivs=d4_max_pivs,
                        tag=f"{cell_name}_e{em}_{bname}_d{d_free}_f{tr}"
                    )
                    if status != "OPEN":
                        closed_cnt += 1
                    print(f"      *** [f{tr} FUSION VERDICT]: {status} | {tr_str}", flush=True)

                print(f"    ==> SUMMARY [{cell_name} eta={em} {bname} d1={d_free} (k_fix={k_fix})]: CLOSED = {closed_cnt}/{n_tested}", flush=True)

    print(f"\n[STEP 64A {cell_name}] DONE in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()
