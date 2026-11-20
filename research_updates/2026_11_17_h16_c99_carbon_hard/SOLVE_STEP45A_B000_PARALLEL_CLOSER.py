#!/usr/bin/env python3
r"""
SOLVE_STEP45A_B000_PARALLEL_CLOSER.py

4-CORE FORK-SAFE PARALLEL SHARDED FORMAL UNSAT CLOSER FOR B0_00:
  - Builds exact B0_00 root system (CG(389) + deg<=3 D8 cosets + cyclotomic cubics).
  - For each target non-zero eta orbit:
      * Computes deterministic 3-block shear (R_free > R_tail > W_ess), K_R, Mk_c,
        and 3-round MinRank basis (rng_seed = 4300 + em, matching Step 43B).
      * Computes exact fix_forms + rescue_forms + SHA-256 partition fingerprint.
      * Partitions [0, 2^{k_fix}) across n_shards and evaluates [lo, hi) across
        `workers` forked worker processes (with 1-level recursive rescue up to 4 bits
        on any open branch and Zero-Trust verify_subst on shard endpoints).
      * Emits formal JSON certificate to <cert-dir>/step45a_cert_eta<em:02d>_s<shard>_of_<n_shards>.json.
  - With --close-eta0:
      * Enumerates ALL balanced (0xFF, 0x55) open sub-states of B0_00 eta=0.
      * Runs 3-block shear + K_R + MinRank on every open sub-state; closes all small
        sub-states (k_fix <= 6 or nM1==0 with nW<=6 / z=0x33) directly and records
        exact thresholds for any remaining sub-states in step45a_cert_eta00_full.json.
"""

import argparse
import ctypes
import hashlib
import json
import multiprocessing
import random
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
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP40C_B11_LOWRANK_BASIS_SHATTER as s40c

# Read-only worker context populated in parent before fork()
_W_CTX = {}
_W_LIB9 = None
_W_BUF = None
_W_TBL = None


def _setup_lib9(so_path):
    lib9 = ctypes.CDLL(str(so_path))
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
    return lib9


def _init_worker():
    global _W_LIB9, _W_BUF, _W_TBL
    _W_LIB9 = _setup_lib9(_W_CTX["so_s9_path"])
    _W_TBL = s9.build_col_tables(111)
    buf_bytes = _W_CTX["buf_bytes"]
    n_u64 = len(buf_bytes) // 8
    _W_BUF = (ctypes.c_uint64 * n_u64)()
    ctypes.memmove(_W_BUF, buf_bytes, len(buf_bytes))


def _eval_branch_worker(rb):
    ctx = _W_CTX
    fix_forms = ctx["fix_forms"]
    k_fix = ctx["k_fix"]
    rescue_pool = ctx["rescue_forms"]
    lo, hi = ctx["lo"], ctx["hi"]
    verify_subst = (rb == lo or rb == hi - 1)
    ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
    sub = s9.run_branch_cascade(
        _W_LIB9, _W_BUF, ctx["quad_ids"], ctx["cub_ids"], ctx["lin_pivs"],
        ex_w, _W_TBL, max_xl_rounds=20, verify_subst=verify_subst
    )
    if sub["closed_unsat"]:
        return ("DIRECT", rb, 0)
    if "_quad_ids" not in sub:
        sub = s9.run_branch_cascade(
            _W_LIB9, _W_BUF, ctx["quad_ids"], ctx["cub_ids"], ctx["lin_pivs"],
            ex_w, _W_TBL, max_xl_rounds=80, verify_subst=False
        )
        if sub["closed_unsat"]:
            return ("DIRECT", rb, 0)
        if "_quad_ids" not in sub:
            return ("OPEN", rb, (-1, -1))

    sub_q_forms = []
    if sub["_quad_ids"]:
        sub_qps = [s9.row_to_pset(sub["_buf"], qr, _W_TBL) for qr in sub["_quad_ids"][:8]]
        sub_ana = s16.analyze_quad_system(sub_qps)
        sub_q_forms = list(sub_ana["W_piv"].values())
    rem_f = s16.reduce_forms_mod_pivs(sub_q_forms + rescue_pool, sub["_lin_pivs"])[:4]
    for ns in range(1, min(4, len(rem_f)) + 1):
        op_ns = False
        for sb in range(1 << ns):
            ex2 = [(rem_f[j], (sb >> j) & 1) for j in range(ns)]
            sub2 = s9.run_branch_cascade(
                _W_LIB9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                ex2, _W_TBL, max_xl_rounds=18, verify_subst=False
            )
            if not sub2["closed_unsat"]:
                op_ns = True
                break
        if not op_ns:
            return ("RESCUED", rb, ns)

    n_act = _W_TBL["n"] - len(sub["_lin_pivs"])
    return ("OPEN", rb, (n_act, len(sub["_quad_ids"])))


def extract_minrank_basis_for_state(label, sr, lib9, lib_sh, tbl, rng_seed):
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    W_forms = [W_rref[p] for p in W_pivs]
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    R_vars = [v for v in active_now if v not in W_set]
    R_set = set(R_vars)
    nW = len(W_pivs)
    if nW == 0:
        return {"status": "NO_W", "nW": 0, "W_forms": [], "bas": [], "low_bas_dim": 0}

    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    M_eq = len(eq_ids)
    work = (ctypes.c_uint64 * (M_eq * n_cw))()
    for i, rid in enumerate(eq_ids):
        ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
    for p in W_pivs:
        rest = W_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )
    n_q = len(sr["_quad_ids"])
    tail_forms = []
    for qi in range(n_q):
        qps_sh = s9.row_to_pset(work, qi, tbl)
        rmask = 0
        for m in qps_sh:
            if m.bit_count() == 1:
                v = m.bit_length() - 1
                if v in R_set: rmask |= (1 << v)
        if rmask: tail_forms.append(rmask)
    T_rref = s19.strict_rref_masks(tail_forms)
    T_pivs = sorted(T_rref.keys())
    T_set = set(T_pivs)
    RF_vars = [v for v in R_vars if v not in T_set]
    RF_set = set(RF_vars)
    nRF = len(RF_vars)
    for p in T_pivs:
        rest = T_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )

    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        drf = sum(1 for v in vs if v in RF_set)
        dt_c = sum(1 for v in vs if v in T_set)
        col_meta.append((drf, dt_c, d))
        col_keys.append((3 - drf, 3 - dt_c, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc
        perm_to_orig[pc] = oc
    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    ech_rows = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc >= 0:
            ech_rows.append((r, col_meta[perm_to_orig[pc]]))
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    rf_idx = {v: i for i, v in enumerate(RF_vars)}
    M1_psets = [s9.row_to_pset(std_ech, r_id, tbl) for r_id, (drf, dt_c, _) in ech_rows if drf == 1 and dt_c == 0]
    nM = len(M1_psets)
    if nM == 0 or nRF == 0:
        return {"status": "NO_M1", "nW": nW, "W_forms": W_forms, "bas": [1 << k for k in range(nW)], "low_bas_dim": 0}

    M0 = np.zeros((nM, nRF), dtype=np.uint8)
    Mk = np.zeros((nW, nM, nRF), dtype=np.uint8)
    for ri, ps in enumerate(M1_psets):
        for m in ps:
            vs = [b for b in range(n) if (m >> b) & 1]
            rfvs = [rf_idx[v] for v in vs if v in RF_set]
            if len(rfvs) != 1: continue
            rfi = rfvs[0]
            wvs = [w_idx[v] for v in vs if v in w_idx]
            if len(wvs) == 0: M0[ri, rfi] ^= 1
            elif len(wvs) == 1: Mk[wvs[0], ri, rfi] ^= 1

    K_R = s40a.gf2_nullspace_np(Mk.reshape(nW * nM, nRF))
    M0_KR = (M0 @ K_R.T) & 1 if K_R.shape[0] > 0 else np.zeros((nM, 0), dtype=np.uint8)
    L_core = s40a.gf2_nullspace_np(M0_KR.T) if K_R.shape[0] > 0 else np.eye(nM, dtype=np.uint8)
    n_core_rows = L_core.shape[0]
    _, kr_pivs = s40a.gf2_rref_np(K_R) if K_R.shape[0] > 0 else (None, [])
    core_rf_cols = [c for c in range(nRF) if c not in set(kr_pivs)]
    nRC = len(core_rf_cols)
    Mk_c = np.zeros((nW, n_core_rows, nRC), dtype=np.uint8)
    for k in range(nW):
        Mk_c[k] = (L_core @ Mk[k])[:, core_rf_cols] & 1

    def mat_of(cm):
        acc = np.zeros((n_core_rows, nRC), dtype=np.uint8)
        for k in range(nW):
            if (cm >> k) & 1: acc ^= Mk_c[k]
        return acc

    rk_cap = max(4, min(24, max(4, nRC - 2)))
    found_low = {}
    def record_c(cm):
        if cm == 0 or cm in found_low: return
        rk = len(s40a.gf2_rref_np(mat_of(cm))[1])
        if rk <= rk_cap: found_low[cm] = rk

    for i in range(nW):
        record_c(1 << i)
        for j in range(i + 1, nW): record_c((1 << i) | (1 << j))

    tested_v = set()
    rng = random.Random(rng_seed)
    def probe_v(v):
        key = v.tobytes()
        if key in tested_v: return
        tested_v.add(key)
        Bv = np.zeros((n_core_rows, nW), dtype=np.uint8)
        for k in range(nW): Bv[:, k] = (Mk_c[k] @ v) & 1
        for row in s40a.gf2_nullspace_np(Bv):
            record_c(sum((1 << k) for k in range(nW) if row[k]))

    for j in range(nRC):
        e = np.zeros(nRC, dtype=np.uint8); e[j] = 1
        probe_v(e)
    for _ in range(3):
        cands = [cm for cm, rk in sorted(found_low.items(), key=lambda x: x[1]) if 1 <= rk <= rk_cap - 2][:15]
        for cm in cands:
            K = s40a.gf2_nullspace_np(mat_of(cm))
            for row in K: probe_v(row)
            if K.shape[0] >= 2:
                for _ in range(20):
                    a, b = rng.randrange(K.shape[0]), rng.randrange(K.shape[0])
                    if a != b: probe_v(K[a] ^ K[b])
        bas_cur, _ = s40c.gf2_basis_masks([cm for cm, _ in sorted(found_low.items(), key=lambda x: x[1])])
        for i in range(min(len(bas_cur), 25)):
            for j in range(i + 1, min(len(bas_cur), 25)):
                record_c(bas_cur[i] ^ bas_cur[j])

    sorted_low = [cm for cm, _ in sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))]
    low_bas_dim = len(s40c.gf2_basis_masks(sorted_low)[0])
    bas, _ = s40c.gf2_basis_masks(sorted_low + [1 << k for k in range(nW)])
    print(f"  [{label}] nW={nW}, core={n_core_rows}x{nRC} (K_R={K_R.shape[0]}), low_bas={low_bas_dim}/{nW}", flush=True)
    return {
        "status": "OK",
        "nW": nW,
        "core_shape": [int(n_core_rows), int(nRC)],
        "K_R": int(K_R.shape[0]),
        "low_bas_dim": int(low_bas_dim),
        "W_forms": W_forms,
        "bas": bas,
    }


def build_fix_and_rescue_forms(info, k_fix):
    nW = info["nW"]
    W_forms = info["W_forms"]
    bas = info["bas"]
    d_free = nW - k_fix
    assert 0 <= d_free < nW, f"Invalid d_free={d_free} for nW={nW}, k_fix={k_fix}"
    sub_L = np.zeros((d_free, nW), dtype=np.uint8)
    for ri, cm in enumerate(bas[:d_free]):
        for k in range(nW):
            if (cm >> k) & 1:
                sub_L[ri, k] = 1
    F_sub = s40a.gf2_nullspace_np(sub_L)
    assert F_sub.shape[0] == k_fix
    fix_forms = []
    for row in F_sub:
        fm = 0
        for k in range(nW):
            if row[k]:
                fm ^= W_forms[k]
        fix_forms.append(fm)

    # Rescue forms from deeper subspace F_res orthogonal to bas[:max(1, d_free - 6)]
    d_res = max(1, d_free - 6)
    sub_R = np.zeros((d_res, nW), dtype=np.uint8)
    for ri, cm in enumerate(bas[:d_res]):
        for k in range(nW):
            if (cm >> k) & 1:
                sub_R[ri, k] = 1
    F_res = s40a.gf2_nullspace_np(sub_R)
    cand_rescue = []
    for row in F_res:
        fm = 0
        for k in range(nW):
            if row[k]:
                fm ^= W_forms[k]
        cand_rescue.append(fm)
    # Extract forms linearly independent of fix_forms (+ W_forms fallback)
    fix_rref = s19.strict_rref_masks(fix_forms)
    rescue_forms = []
    seen_rref = dict(fix_rref)
    for fm in cand_rescue + W_forms:
        x = fm
        for p, pm in seen_rref.items():
            if (x >> p) & 1:
                x ^= pm
        if x != 0:
            rescue_forms.append(fm)
            seen_rref = s19.strict_rref_masks(list(seen_rref.values()) + [fm])
            if len(rescue_forms) >= 12:
                break

    fix_sha = hashlib.sha256(",".join(hex(f) for f in fix_forms).encode()).hexdigest()[:16]
    return fix_forms, rescue_forms, fix_sha


def run_parallel_shard(label, eta, sr, info, k_fix, shard_idx, n_shards, workers, so_s9_path, n_col_words, deadline, cert_dir):
    t0 = time.perf_counter()
    fix_forms, rescue_forms, fix_sha = build_fix_and_rescue_forms(info, k_fix)
    n_branches = 1 << k_fix
    lo = (n_branches * shard_idx) // n_shards
    hi = (n_branches * (shard_idx + 1)) // n_shards
    total_shard = hi - lo
    print(
        f"  [{label}] k_fix={k_fix}, total={n_branches}, shard {shard_idx}/{n_shards} [{lo}..{hi}) "
        f"({total_shard} branches), workers={workers}, fix_sha256={fix_sha}",
        flush=True,
    )

    max_active_row = max([-1] + list(sr["_quad_ids"]) + list(sr["_cub_ids"])) + 1
    n_bytes = max_active_row * n_col_words * 8
    buf_bytes = ctypes.string_at(ctypes.addressof(sr["_buf"]), n_bytes)

    _W_CTX.clear()
    _W_CTX.update({
        "so_s9_path": str(so_s9_path),
        "buf_bytes": buf_bytes,
        "quad_ids": list(sr["_quad_ids"]),
        "cub_ids": list(sr["_cub_ids"]),
        "lin_pivs": dict(sr["_lin_pivs"]),
        "fix_forms": fix_forms,
        "rescue_forms": rescue_forms + info["W_forms"],
        "k_fix": k_fix,
        "lo": lo,
        "hi": hi,
    })

    direct_closed = 0
    rec_closed = 0
    open_list = []
    checked = 0
    aborted_budget = False

    if total_shard > 0:
        ctx = multiprocessing.get_context("fork")
        with ctx.Pool(processes=workers, initializer=_init_worker) as pool:
            it = pool.imap_unordered(_eval_branch_worker, range(lo, hi), chunksize=2)
            for tag, rb, payload in it:
                checked += 1
                if tag == "DIRECT":
                    direct_closed += 1
                elif tag == "RESCUED":
                    rec_closed += 1
                else:
                    open_list.append({"rb": rb, "N": payload[0], "q": payload[1]})
                    print(f"    [{label}] OPEN_BRANCH rb={rb}: N={payload[0]}, q={payload[1]}", flush=True)
                    if len(open_list) >= 8:
                        aborted_budget = False
                        pool.terminate()
                        break
                if checked % 64 == 0 or checked == total_shard:
                    print(
                        f"    [{label}] s{shard_idx}/{n_shards} progress {checked}/{total_shard}: "
                        f"direct={direct_closed}, rescued={rec_closed}, open={len(open_list)} ({time.perf_counter()-t0:.1f}s)",
                        flush=True,
                    )
                if deadline is not None and time.perf_counter() > deadline - 45.0 and checked < total_shard:
                    print(f"    [{label}] s{shard_idx}/{n_shards} STOPPING at {checked}/{total_shard} near deadline", flush=True)
                    aborted_budget = True
                    pool.terminate()
                    break

    elapsed = round(time.perf_counter() - t0, 2)
    if open_list:
        verdict = "HAS_OPEN_SURVIVORS"
    elif checked < total_shard or aborted_budget:
        verdict = "INCOMPLETE_BUDGET"
    elif n_shards == 1:
        verdict = "ORBIT_FORMALLY_CLOSED_100%"
    else:
        verdict = "SHARD_CLOSED_100%"

    cert = {
        "cell": "B0_00",
        "eta": int(eta),
        "k_fix": int(k_fix),
        "nW": int(info["nW"]),
        "low_bas_dim": int(info["low_bas_dim"]),
        "fix_sha256": fix_sha,
        "fix_forms_hex": [hex(f) for f in fix_forms],
        "shard_idx": int(shard_idx),
        "n_shards": int(n_shards),
        "lo": int(lo),
        "hi": int(hi),
        "total_branches_in_shard": int(total_shard),
        "branches_checked": int(checked),
        "direct_closed": int(direct_closed),
        "rec_closed": int(rec_closed),
        "open_survivors": open_list,
        "zt_verified_endpoints": [int(lo), int(hi - 1)] if total_shard > 0 and checked == total_shard else [],
        "elapsed_s": elapsed,
        "verdict": verdict,
    }
    cert_dir.mkdir(parents=True, exist_ok=True)
    cert_path = cert_dir / f"step45a_cert_eta{eta:02d}_s{shard_idx}_of_{n_shards}.json"
    cert_path.write_text(json.dumps(cert, indent=2), encoding="utf-8")
    print(f"  *** [{label}] {verdict} ({checked}/{total_shard}, direct={direct_closed}, rec={rec_closed}, open={len(open_list)}, {elapsed:.1f}s) -> {cert_path.name} ***", flush=True)
    return cert


def find_kfix_threshold(label, sr, info, lib9, tbl, rng_seed):
    nW = info["nW"]
    W_forms = info["W_forms"]
    bas = info["bas"]
    rng_sh = random.Random(rng_seed + 100)
    d_max = min(len(bas), nW)
    d_min = max(1, d_max - 26)
    best = None
    for d_free in range(d_max, d_min - 1, -2):
        k_fix = nW - d_free
        if d_free <= 0:
            continue
        sub_L = np.zeros((d_free, nW), dtype=np.uint8)
        for ri, cm in enumerate(bas[:d_free]):
            for k in range(nW):
                if (cm >> k) & 1:
                    sub_L[ri, k] = 1
        F_sub = s40a.gf2_nullspace_np(sub_L)
        fix_forms = []
        for row in F_sub:
            fm = 0
            for k in range(nW):
                if row[k]:
                    fm ^= W_forms[k]
            fix_forms.append(fm)
        n_cl = 0
        t_tr = time.perf_counter()
        for _ in range(4):
            rb = rng_sh.getrandbits(k_fix)
            ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_w, tbl, max_xl_rounds=20, verify_subst=False
            )
            if sub["closed_unsat"]:
                n_cl += 1
            else:
                break
        avg_dt = (time.perf_counter() - t_tr) / (n_cl if n_cl == 4 else (n_cl + 1))
        if n_cl == 4:
            if best is None:
                best = (k_fix, avg_dt)
            elif best[1] >= 4.0 and avg_dt * (1 << k_fix) < best[1] * (1 << best[0]):
                best = (k_fix, avg_dt)
            if avg_dt < 4.0:
                break
    return best


def run_eta0_full(root, eta_free, b_tt, lib9, lib_sh, so_s9_path, tbl, n_col_words, workers, deadline, cert_dir):
    t0 = time.perf_counter()
    print("\n--- STEP 45A ETA=0 FULL BALANCED (0xFF x 0x55) SUB-STATE AUDIT & CLOSER ---", flush=True)

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
    ff_closed = 0
    ff_open = 0
    open_sub2 = []
    sub2_closed_direct = 0

    for st_ff in bal_ff:
        sub1 = s9.run_branch_cascade(
            lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
            [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)], tbl, max_xl_rounds=20, verify_subst=False
        )
        if sub1["closed_unsat"]:
            ff_closed += 1
            continue
        ff_open += 1
        nz_55, forms_55, bal_55 = get_coset_bal_states(sub1, 0x55, max_dim=10)
        if forms_55 is None:
            print(f"  [eta=0 ff={st_ff}] WARNING: 0x55 dim={nz_55} > 10", flush=True)
            continue
        for st_55 in bal_55:
            sub2 = s9.run_branch_cascade(
                lib9, sub1["_buf"], sub1["_quad_ids"], sub1["_cub_ids"], sub1["_lin_pivs"],
                [(forms_55[j], (st_55 >> j) & 1) for j in range(nz_55)], tbl, max_xl_rounds=18, verify_subst=False
            )
            if sub2["closed_unsat"]:
                sub2_closed_direct += 1
            else:
                open_sub2.append((st_ff, st_55, sub2))

    print(
        f"  [eta=0] 0xFF bal={len(bal_ff)} (closed={ff_closed}, open={ff_open}); "
        f"(0xFF x 0x55) sub2_closed_direct={sub2_closed_direct}, open_sub2={len(open_sub2)}",
        flush=True,
    )

    closed_100 = 0
    needs_sharding = []
    still_open = []
    for idx_s, (st_ff, st_55, sub2) in enumerate(open_sub2):
        lbl = f"eta0 ff={st_ff},55={st_55}"
        info = extract_minrank_basis_for_state(lbl, sub2, lib9, lib_sh, tbl, rng_seed=45000 + st_ff * 100 + st_55)
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
                    print(f"  *** [{lbl}] NO_M1 nW={nW}: CLOSED 100% (all {1<<nW} W branches)! ***", flush=True)
                    continue
                # Push 3rd coset z=0x33 on survivors
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
                            rem_z33_open += 1
                if rem_z33_open == 0:
                    closed_100 += 1
                    print(f"  *** [{lbl}] NO_M1 + z=0x33: CLOSED 100%! ***", flush=True)
                    continue
            still_open.append({"ff": st_ff, "st55": st_55, "status": info["status"], "nW": nW})
            continue

        if time.perf_counter() > deadline - 90.0:
            needs_sharding.append({"ff": st_ff, "st55": st_55, "status": "BUDGET_SKIP", "nW": nW})
            continue

        th = find_kfix_threshold(lbl, sub2, info, lib9, tbl, rng_seed=45100 + idx_s)
        if th is None:
            needs_sharding.append({"ff": st_ff, "st55": st_55, "status": "NO_THRESHOLD", "nW": nW})
            continue
        best_k, avg_dt = th
        if best_k <= 6:
            c_sub = run_parallel_shard(
                lbl, 0, sub2, info, best_k, 0, 1, workers, so_s9_path, n_col_words, deadline, cert_dir
            )
            if c_sub["verdict"] == "ORBIT_FORMALLY_CLOSED_100%":
                closed_100 += 1
            else:
                needs_sharding.append({"ff": st_ff, "st55": st_55, "nW": nW, "best_k": best_k, "verdict": c_sub["verdict"]})
        else:
            needs_sharding.append({"ff": st_ff, "st55": st_55, "nW": nW, "best_k": best_k, "avg_dt": round(avg_dt, 2)})

    summary = {
        "cell": "B0_00",
        "eta": 0,
        "bal_0xff_total": len(bal_ff),
        "bal_0xff_closed": ff_closed,
        "sub2_direct_closed": sub2_closed_direct,
        "open_sub2_total": len(open_sub2),
        "closed_100_via_minrank_or_z33": closed_100,
        "needs_sharding": needs_sharding,
        "still_open": still_open,
        "elapsed_s": round(time.perf_counter() - t0, 2),
    }
    cert_dir.mkdir(parents=True, exist_ok=True)
    out_p = cert_dir / "step45a_cert_eta00_full.json"
    out_p.write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print(f"\n=== [eta=0 SUMMARY] open_sub2={len(open_sub2)}, closed_100={closed_100}, needs_sharding={len(needs_sharding)}, still_open={len(still_open)} ({summary['elapsed_s']}s) ===", flush=True)


def main():
    t_start = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--etas", type=str, default="")
    parser.add_argument("--kfix-map", type=str, default="")
    parser.add_argument("--shard-idx", type=int, default=0)
    parser.add_argument("--n-shards", type=int, default=1)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--close-eta0", action="store_true")
    parser.add_argument("--budget-min", type=float, default=40.0)
    parser.add_argument("--cert-dir", type=str, default="step45a_certs")
    args = parser.parse_args()
    deadline = t_start + args.budget_min * 60.0
    cert_dir = Path(args.cert_dir)

    kfix_map = {}
    if args.kfix_map.strip():
        for part in args.kfix_map.split(","):
            if ":" in part:
                k, v = part.strip().split(":", 1)
                kfix_map[int(k)] = int(v)

    c_diag, so_diag = WORK_DIR / "s45a_diag.c", WORK_DIR / "libs45a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s45a_s9.c", WORK_DIR / "libs45a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = _setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s45a_cg.c", WORK_DIR / "libs45a_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s45a_d8.c", WORK_DIR / "libs45a_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s45a_sh.c", WORK_DIR / "libs45a_sh.so"
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
    n_ef = len(eta_free)

    eta_list = [int(x.strip()) for x in args.etas.split(",") if x.strip()]
    for idx_e, em in enumerate(eta_list):
        if time.perf_counter() > deadline - 90.0:
            print(f"[B0_00 eta={em}] SKIPPING (near budget limit)", flush=True)
            continue
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=(idx_e == 0)
        )
        lbl = f"B0_00 eta={em}"
        info = extract_minrank_basis_for_state(lbl, sr, lib9, lib_sh, tbl, rng_seed=4300 + em)
        if em in kfix_map:
            k_fix = kfix_map[em]
        else:
            th = find_kfix_threshold(lbl, sr, info, lib9, tbl, rng_seed=4300 + em)
            assert th is not None, f"Failed to find k_fix threshold for {lbl}"
            k_fix = th[0]
        run_parallel_shard(
            lbl, em, sr, info, k_fix, args.shard_idx, args.n_shards, args.workers,
            so_s9, n_cw, deadline, cert_dir
        )

    if args.close_eta0:
        run_eta0_full(root, eta_free, b_tt, lib9, lib_sh, so_s9, tbl, n_cw, args.workers, deadline, cert_dir)

    print(f"\n[B0_00] STEP 45A DONE ({time.perf_counter()-t_start:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
