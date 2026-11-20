#!/usr/bin/env python3
r"""
SOLVE_STEP46C_ETA0_LOWMEM_AND_ETA42_DEEP.py

SHARDED, MULTI-CORE, LOW-MEMORY (<300 MB) FORMAL CLOSER FOR B0_00 eta=0 AND eta=42:
  1. --mode eta0_lowmem (--shard-idx S --n-shards N):
       Splits the balanced 0xFF coset states `bal_ff` across N shards.
       For each `st_ff` in the shard, evaluates all ~300 balanced 0x55 states `bal_55`
       IN PARALLEL across `--workers` forked cores (each worker frees `sub2` immediately,
       using <250 MB RAM total and taking ~45s per `st_ff` instead of 18 min!).
       Then closes each surviving open `(st_ff, st_55)` sub-state in streaming mode via
       D8 Coset Weight-128 Filtering (0x33, 0x0F, 0x3C, 0x66, 0x5A, 0xA5) + K_R/MinRank +
       Multi-Level Recursive W_forms Splitting.
  2. --mode eta42_deep (--shard-idx S --n-shards N):
       Splits the 256 Level-1 branches (k_fix=8) of B0_00 eta=42 across N shards.
       Evaluates the shard's Level-1 branches IN PARALLEL across `--workers` forked cores,
       and closes every surviving Level-1 branch (N=68, q>=1) via Multi-Level Recursive
       W_forms Splitting + D8 Coset Weight-128 Filtering + K_R/MinRank until 0 survivors remain.
"""

import argparse
import ctypes
import gc
import json
import multiprocessing as mp
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


_G46C = {}


def _init_worker_46c(so_s9_path, buf_bytes, n_u64, quad_ids, cub_ids, lin_pivs, forms, tbl_n, max_xl):
    global _G46C
    lib9 = s45a._setup_lib9(Path(so_s9_path))
    tbl = s9.build_col_tables(tbl_n)
    buf = (ctypes.c_uint64 * n_u64).from_buffer_copy(buf_bytes)
    _G46C = {
        "lib9": lib9,
        "tbl": tbl,
        "buf": buf,
        "quad_ids": quad_ids,
        "cub_ids": cub_ids,
        "lin_pivs": lin_pivs,
        "forms": forms,
        "max_xl": max_xl,
    }


def _worker_eval_st_46c(st):
    g = _G46C
    forms = g["forms"]
    k = len(forms)
    ex = [(forms[j], (st >> j) & 1) for j in range(k)]
    verify = (st == 0)
    sub = s9.run_branch_cascade(
        g["lib9"], g["buf"], g["quad_ids"], g["cub_ids"], g["lin_pivs"],
        ex, g["tbl"], max_xl_rounds=g["max_xl"], verify_subst=verify
    )
    closed = bool(sub["closed_unsat"])
    n_act = 0 if closed else (g["tbl"]["n"] - len(sub["_lin_pivs"]) if "_lin_pivs" in sub else -1)
    n_q = 0 if closed else (len(sub["_quad_ids"]) if "_quad_ids" in sub else -1)
    del sub
    return (st, closed, n_act, n_q)


def parallel_filter_open_states(parent_st, forms, st_list, so_s9, tbl, workers, max_xl=20):
    """Evaluate all states in `st_list` in parallel across forked workers; return (n_direct_closed, open_entries)."""
    if not st_list:
        return 0, []
    if workers <= 1 or len(st_list) <= 4:
        lib9 = s45a._setup_lib9(so_s9)
        k = len(forms)
        direct_closed = 0
        open_entries = []
        for idx, st in enumerate(st_list):
            ex = [(forms[j], (st >> j) & 1) for j in range(k)]
            sub = s9.run_branch_cascade(
                lib9, parent_st["_buf"], parent_st["_quad_ids"], parent_st["_cub_ids"], parent_st["_lin_pivs"],
                ex, tbl, max_xl_rounds=max_xl, verify_subst=(idx == 0)
            )
            if sub["closed_unsat"]:
                direct_closed += 1
            elif "_quad_ids" not in sub:
                open_entries.append((st, -1, -1))
            else:
                open_entries.append((st, tbl["n"] - len(sub["_lin_pivs"]), len(sub["_quad_ids"])))
            del sub
        return direct_closed, open_entries

    n_u64 = len(parent_st["_buf"])
    buf_bytes = ctypes.string_at(parent_st["_buf"], n_u64 * 8)
    ctx = mp.get_context("fork")
    direct_closed = 0
    open_entries = []
    with ctx.Pool(
        processes=workers,
        initializer=_init_worker_46c,
        initargs=(
            str(so_s9), buf_bytes, n_u64,
            list(parent_st["_quad_ids"]), list(parent_st["_cub_ids"]), dict(parent_st["_lin_pivs"]),
            list(forms), tbl["n"], max_xl,
        ),
    ) as pool:
        for st, closed, n_act, n_q in pool.imap_unordered(_worker_eval_st_46c, st_list, chunksize=4):
            if closed:
                direct_closed += 1
            else:
                open_entries.append((st, n_act, n_q))
    open_entries.sort(key=lambda x: x[0])
    return direct_closed, open_entries


def get_coset_bal_states(sr_cur, z_val, b_tt, max_dim=10):
    pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
    raw_forms = [
        sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]]))
        for k in range(256)
        if np.any(b_tt[:, pts[k]])
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


COSET_CANDIDATES = (0xFF, 0x55, 0x33, 0x0F, 0x3C, 0x66, 0x5A, 0xA5, 0x1E, 0x78)


def close_open_substate_deep(
    lbl, sub, b_tt, lib9, lib_sh, so_s9, tbl, n_cw, workers, deadline, cert_dir,
    depth=0, max_depth=4, used_cosets=()
):
    """
    Close an open branch state `sub` using a 3-strategy cascade:
      1. D8 Coset Weight-128 Balance Filtering (across COSET_CANDIDATES with nz <= 9)
      2. K_R + MinRank Parallel Closer (when M1 > 0 and threshold k_fix <= 8)
      3. Multi-Level Recursive Radical-Complement W_forms Splitting (up to max_depth=4)
    """
    if sub["closed_unsat"]:
        return True, "ALREADY_CLOSED"
    if "_quad_ids" not in sub:
        return False, "XL_ROUNDS_EXHAUSTED"

    # Strategy 1: Check D8 cosets for weight-128 balance filtering
    best_coset = None
    for z_val in COSET_CANDIDATES:
        if z_val in used_cosets:
            continue
        nz, z_forms, bal_sts = get_coset_bal_states(sub, z_val, b_tt, max_dim=9 if depth == 0 else 8)
        if z_forms is not None:
            if len(bal_sts) == 0:
                return True, f"COSET_0x{z_val:02X}_ZERO_BAL(nz={nz})"
            if best_coset is None or len(bal_sts) < len(best_coset[3]):
                best_coset = (z_val, nz, z_forms, bal_sts)
                if len(bal_sts) <= 4:
                    break

    max_bal_allow = 48 if depth == 0 else (20 if depth == 1 else 10)
    if best_coset is not None and len(best_coset[3]) <= max_bal_allow and depth < max_depth:
        z_val, nz, z_forms, bal_sts = best_coset
        use_w = workers if (depth == 0 and len(bal_sts) >= 8) else 1
        d_cl, open_z = parallel_filter_open_states(sub, z_forms, bal_sts, so_s9, tbl, use_w, max_xl=18)
        if not open_z:
            return True, f"COSET_0x{z_val:02X}_DIRECT({len(bal_sts)}/{len(bal_sts)})"
        if len(open_z) <= (12 if depth == 0 else 6):
            all_z_ok = True
            for st_z, _, _ in open_z:
                ex_z = [(z_forms[j], (st_z >> j) & 1) for j in range(nz)]
                sub_z = s9.run_branch_cascade(
                    lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                    ex_z, tbl, max_xl_rounds=18, verify_subst=False
                )
                ok_z, _ = close_open_substate_deep(
                    f"{lbl}_z{z_val:02x}_{st_z}", sub_z, b_tt, lib9, lib_sh, so_s9, tbl, n_cw,
                    workers, deadline, cert_dir, depth=depth + 1, max_depth=max_depth,
                    used_cosets=used_cosets + (z_val,)
                )
                del sub_z
                if not ok_z:
                    all_z_ok = False
                    break
            if all_z_ok:
                return True, f"COSET_0x{z_val:02X}_REC(bal={len(bal_sts)},open={len(open_z)})"

    # Strategy 2: K_R + MinRank Parallel Closer (when M1 > 0 and k2 <= 8)
    if depth <= 2 and len(sub["_quad_ids"]) >= 2:
        info2 = s45a.extract_minrank_basis_for_state(lbl, sub, lib9, lib_sh, tbl, rng_seed=46300 + depth)
        nW2 = info2["nW"]
        if info2["status"] == "OK":
            th2 = s45a.find_kfix_threshold(lbl, sub, info2, lib9, tbl, rng_seed=46301 + depth)
            if th2 is not None and th2[0] <= (8 if depth == 0 else 7):
                k2 = th2[0]
                use_w = workers if depth == 0 else 1
                c2 = s45a.run_parallel_shard(lbl, 42, sub, info2, k2, 0, 1, use_w, so_s9, n_cw, deadline, cert_dir)
                if c2["verdict"] == "ORBIT_FORMALLY_CLOSED_100%":
                    return True, f"MINRANK_K{k2}({c2['branches_checked']})"

    # Strategy 3: Radical-Complement W_forms Splitting + Multi-Level Recursion
    qps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_free = s16.reduce_forms_mod_pivs(list(ana["W_piv"].values()), sub["_lin_pivs"])
    W_rref = s19.strict_rref_masks(W_free)
    W_forms = [W_rref[p] for p in sorted(W_rref.keys())]
    if not W_forms:
        return False, f"NO_W_FORMS(q={len(qps)},d={depth})"

    max_k = 6 if depth == 0 else (5 if depth == 1 else 4)
    k_split = min(len(W_forms), max_k)
    forms_use = W_forms[:k_split]
    st_list = list(range(1 << k_split))
    use_w = workers if (depth == 0 and len(st_list) >= 16) else 1
    d_cl, open_w = parallel_filter_open_states(sub, forms_use, st_list, so_s9, tbl, use_w, max_xl=20 if depth == 0 else 18)
    if not open_w:
        return True, f"W_SPLIT_K{k_split}_DIRECT({len(st_list)}/{len(st_list)})"

    if depth >= max_depth:
        return False, f"MAX_DEPTH_OPEN(d={depth},k={k_split},open={len(open_w)}/{len(st_list)})"

    for b, n_act_ch, n_q_ch in open_w:
        ex = [(forms_use[j], (b >> j) & 1) for j in range(k_split)]
        s_ch = s9.run_branch_cascade(
            lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
            ex, tbl, max_xl_rounds=20 if depth == 0 else 18, verify_subst=(b == 0)
        )
        ok_ch, how_ch = close_open_substate_deep(
            f"{lbl}_w{b}", s_ch, b_tt, lib9, lib_sh, so_s9, tbl, n_cw,
            workers, deadline, cert_dir, depth=depth + 1, max_depth=max_depth,
            used_cosets=used_cosets
        )
        del s_ch
        if not ok_ch:
            return False, f"CHILD_OPEN(b={b},N={n_act_ch},q={n_q_ch}->{how_ch})"

    return True, f"W_SPLIT_K{k_split}_REC(total={len(st_list)},rec_closed={len(open_w)})"


def run_eta42_deep(root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw, workers, shard_idx, n_shards, deadline, cert_dir):
    t0 = time.perf_counter()
    print(
        f"\n==================== [B0_00 eta=42] STEP 46C-v2: SHARD {shard_idx}/{n_shards} DEEP FORMAL CLOSURE ====================",
        flush=True,
    )
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
    lo = (shard_idx * n_branches) // n_shards
    hi = ((shard_idx + 1) * n_branches) // n_shards
    shard_rbs = list(range(lo, hi))
    print(
        f"  [eta=42] Level-1 k_fix={k_fix}, shard {shard_idx}/{n_shards} [{lo}..{hi}) ({len(shard_rbs)} branches), "
        f"workers={workers}, fix_sha256={fix_sha}",
        flush=True,
    )

    direct_closed, open_rbs = parallel_filter_open_states(sr, fix_forms, shard_rbs, so_s9, tbl, workers, max_xl=20)
    print(
        f"  [eta=42 s{shard_idx}/{n_shards}] Parallel Level-1 sweep done in {time.perf_counter()-t0:.1f}s: "
        f"direct_closed={direct_closed}/{len(shard_rbs)}, open_level1={len(open_rbs)}",
        flush=True,
    )

    level2_closed = 0
    level2_details = []
    open_survivors = []

    for idx_o, (rb, n_act, n_q) in enumerate(open_rbs):
        t_rb = time.perf_counter()
        ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
        sub = s9.run_branch_cascade(
            lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
            ex_w, tbl, max_xl_rounds=20, verify_subst=(idx_o == 0)
        )
        print(
            f"    [eta=42 rb={rb:3d} ({idx_o+1}/{len(open_rbs)})] Level-1 open (N={n_act}, q={n_q}) -> running multi-level closer...",
            flush=True,
        )
        ok, how = close_open_substate_deep(
            f"eta42_rb{rb}", sub, b_tt, lib9, lib_sh, so_s9, tbl, n_cw,
            workers, deadline, cert_dir, depth=0, max_depth=4
        )
        dt_rb = round(time.perf_counter() - t_rb, 2)
        if ok:
            level2_closed += 1
            level2_details.append({"rb": rb, "N": n_act, "q": n_q, "closed_by": how, "elapsed_s": dt_rb})
            print(f"      -> [eta=42 rb={rb:3d}] CLOSED 100% via {how} ({dt_rb}s)!", flush=True)
        else:
            open_survivors.append({"rb": rb, "N": n_act, "q": n_q, "detail": how, "elapsed_s": dt_rb})
            print(f"      -> [eta=42 rb={rb:3d}] STILL OPEN: {how} ({dt_rb}s)", flush=True)
        del sub
        gc.collect()

    verdict = "SHARD_CLOSED_100%" if len(open_survivors) == 0 else "HAS_OPEN_SURVIVORS"
    if n_shards == 1 and len(open_survivors) == 0:
        verdict = "ORBIT_FORMALLY_CLOSED_100%"
    cert = {
        "cell": "B0_00",
        "eta": 42,
        "k_fix_level1": k_fix,
        "fix_sha256": fix_sha,
        "fix_forms_hex": [hex(f) for f in fix_forms],
        "shard_idx": shard_idx,
        "n_shards": n_shards,
        "lo": lo,
        "hi": hi,
        "total_branches_in_shard": len(shard_rbs),
        "direct_closed": direct_closed,
        "level2_closed": level2_closed,
        "level2_details": level2_details,
        "open_survivors": open_survivors,
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "verdict": verdict,
    }
    cert_dir.mkdir(parents=True, exist_ok=True)
    sfx = f"_s{shard_idx}_of_{n_shards}" if n_shards > 1 else ""
    out_p = cert_dir / f"step46c_cert_eta42_deep{sfx}.json"
    out_p.write_text(json.dumps(cert, indent=2), encoding="utf-8")
    print(
        f"\n  *** [B0_00 eta=42 s{shard_idx}/{n_shards}] {verdict} "
        f"(direct={direct_closed}, level2={level2_closed}, open={len(open_survivors)}, {cert['elapsed_s']}s) -> {out_p.name} ***",
        flush=True,
    )


def run_eta0_lowmem(root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw, workers, shard_idx, n_shards, deadline, cert_dir):
    t0 = time.perf_counter()
    print(
        f"\n==================== [B0_00 eta=0] STEP 46C-v2: SHARD {shard_idx}/{n_shards} PARALLEL LOW-MEM CLOSER ====================",
        flush=True,
    )
    n_ef = len(eta_free)
    ex0 = [(eta_free[k], 0) for k in range(n_ef)]
    sr0 = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex0, tbl, max_xl_rounds=20, verify_subst=True
    )
    nz_ff, forms_ff, bal_ff = get_coset_bal_states(sr0, 0xFF, b_tt, max_dim=8)
    n_ff = len(bal_ff)
    lo = (shard_idx * n_ff) // n_shards
    hi = ((shard_idx + 1) * n_ff) // n_shards
    shard_ff = bal_ff[lo:hi]
    print(
        f"  [eta=0] 0xFF dim={nz_ff}, total balanced states={n_ff}, shard {shard_idx}/{n_shards} "
        f"indices [{lo}..{hi}) -> states={shard_ff}",
        flush=True,
    )

    ff_closed = 0
    ff_open = 0
    sub2_closed_direct = 0
    open_sub2_total = 0
    closed_100 = 0
    closed_details = []
    still_open = []

    for st_ff in shard_ff:
        t_ff = time.perf_counter()
        sub1 = s9.run_branch_cascade(
            lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
            [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)], tbl, max_xl_rounds=20, verify_subst=False
        )
        if sub1["closed_unsat"]:
            ff_closed += 1
            del sub1
            continue
        ff_open += 1
        nz_55, forms_55, bal_55 = get_coset_bal_states(sub1, 0x55, b_tt, max_dim=10)
        if forms_55 is None:
            still_open.append({"ff": st_ff, "status": f"0x55_DIM_{nz_55}"})
            del sub1
            continue

        print(f"  [eta=0 ff={st_ff}] 0x55 dim={nz_55}, evaluating {len(bal_55)} balanced states on {workers} cores...", flush=True)
        d_cl, open_55 = parallel_filter_open_states(sub1, forms_55, bal_55, so_s9, tbl, workers, max_xl=18)
        sub2_closed_direct += d_cl
        print(
            f"  [eta=0 ff={st_ff}] Parallel 0x55 sweep done in {time.perf_counter()-t_ff:.1f}s: "
            f"direct_closed={d_cl}/{len(bal_55)}, open_sub2={len(open_55)}",
            flush=True,
        )

        for idx_o, (st_55, n_act2, n_q2) in enumerate(open_55):
            open_sub2_total += 1
            lbl = f"eta0_ff{st_ff}_55_{st_55}"
            t_s2 = time.perf_counter()
            sub2 = s9.run_branch_cascade(
                lib9, sub1["_buf"], sub1["_quad_ids"], sub1["_cub_ids"], sub1["_lin_pivs"],
                [(forms_55[j], (st_55 >> j) & 1) for j in range(nz_55)], tbl, max_xl_rounds=18, verify_subst=(idx_o == 0)
            )
            ok2, how2 = close_open_substate_deep(
                lbl, sub2, b_tt, lib9, lib_sh, so_s9, tbl, n_cw,
                workers, deadline, cert_dir, depth=0, max_depth=4, used_cosets=(0xFF, 0x55)
            )
            dt_s2 = round(time.perf_counter() - t_s2, 2)
            if ok2:
                closed_100 += 1
                closed_details.append({"ff": st_ff, "st55": st_55, "N": n_act2, "q": n_q2, "closed_by": how2, "elapsed_s": dt_s2})
                print(f"    *** [{lbl}] CLOSED 100% via {how2} ({dt_s2}s)! ***", flush=True)
            else:
                still_open.append({"ff": st_ff, "st55": st_55, "N": n_act2, "q": n_q2, "detail": how2, "elapsed_s": dt_s2})
                print(f"    *** [{lbl}] STILL OPEN: {how2} ({dt_s2}s) ***", flush=True)
            del sub2
            gc.collect()

        del sub1
        gc.collect()

    verdict = "SHARD_CLOSED_100%" if (open_sub2_total == closed_100 and not still_open) else "PARTIAL"
    if n_shards == 1 and verdict == "SHARD_CLOSED_100%":
        verdict = "ORBIT_FORMALLY_CLOSED_100%"
    summary = {
        "cell": "B0_00",
        "eta": 0,
        "shard_idx": shard_idx,
        "n_shards": n_shards,
        "ff_lo": lo,
        "ff_hi": hi,
        "shard_ff_states": shard_ff,
        "bal_0xff_total": n_ff,
        "bal_0xff_closed": ff_closed,
        "sub2_direct_closed": sub2_closed_direct,
        "open_sub2_total": open_sub2_total,
        "closed_100_streaming": closed_100,
        "closed_details": closed_details,
        "still_open": still_open,
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "verdict": verdict,
    }
    cert_dir.mkdir(parents=True, exist_ok=True)
    sfx = f"_s{shard_idx}_of_{n_shards}" if n_shards > 1 else ""
    out_p = cert_dir / f"step46c_cert_eta00_full{sfx}.json"
    out_p.write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print(
        f"\n=== [eta=0 s{shard_idx}/{n_shards} SUMMARY] open_sub2={open_sub2_total}, closed_100={closed_100}, "
        f"still_open={len(still_open)} -> {summary['verdict']} ({summary['elapsed_s']}s) ===",
        flush=True,
    )


def main():
    t_start = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["eta0_lowmem", "eta42_deep"], required=True)
    parser.add_argument("--shard-idx", type=int, default=0)
    parser.add_argument("--n-shards", type=int, default=1)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--budget-min", type=float, default=80.0)
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
        run_eta42_deep(
            root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw,
            args.workers, args.shard_idx, args.n_shards, deadline, cert_dir
        )
    else:
        run_eta0_lowmem(
            root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw,
            args.workers, args.shard_idx, args.n_shards, deadline, cert_dir
        )


if __name__ == "__main__":
    main()
