#!/usr/bin/env python3
"""
SOLVE_B000_K0_RECERT_GAPS.py
From-scratch formal UNSAT re-certification of the 9 K=0 audit-gap orbits in B0_00:
  - 7 proved_extra orbits (9 states): 1, 21, 22 ([22,60]), 23 ([23,61]), 43, 62, 63
  - 2 manifest-gap orbits (missing shards/fix_sha256): 3, 27
Zero proved_extra imports; verify_subst=True on EVERY branch (primary, retry, and rescue).
"""

import argparse
import ctypes
import hashlib
import json
import multiprocessing
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
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_B000_K1_CASCADE as k1c
import SOLVE_B000_K1_WESS_PILOT as pilot

_R_CTX = {}
_R_LIB9 = None
_R_BUF = None
_R_TBL = None


def _init_recert_worker():
    global _R_LIB9, _R_BUF, _R_TBL
    _R_LIB9 = s45a._setup_lib9(_R_CTX["so_s9_path"])
    _R_TBL = s9.build_col_tables(111)
    buf_bytes = _R_CTX["buf_bytes"]
    n_u64 = len(buf_bytes) // 8
    _R_BUF = (ctypes.c_uint64 * n_u64)()
    ctypes.memmove(_R_BUF, buf_bytes, len(buf_bytes))


def _eval_recert_branch(rb):
    """Evaluate branch rb with verify_subst=True on EVERY primary, retry, and rescue call."""
    ctx = _R_CTX
    fix_forms = ctx["fix_forms"]
    k_fix = ctx["k_fix"]
    rescue_pool = ctx["rescue_forms"]
    ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]

    sub = s9.run_branch_cascade(
        _R_LIB9, _R_BUF, ctx["quad_ids"], ctx["cub_ids"], ctx["lin_pivs"],
        ex_w, _R_TBL, max_xl_rounds=20, verify_subst=True
    )
    if sub["closed_unsat"]:
        return ("DIRECT", rb, 0)
    if "_quad_ids" not in sub:
        sub = s9.run_branch_cascade(
            _R_LIB9, _R_BUF, ctx["quad_ids"], ctx["cub_ids"], ctx["lin_pivs"],
            ex_w, _R_TBL, max_xl_rounds=80, verify_subst=True
        )
        if sub["closed_unsat"]:
            return ("DIRECT", rb, 0)
        if "_quad_ids" not in sub:
            return ("OPEN", rb, (-1, -1))

    sub_q_forms = []
    if sub["_quad_ids"]:
        sub_qps = [s9.row_to_pset(sub["_buf"], qr, _R_TBL) for qr in sub["_quad_ids"][:8]]
        sub_ana = s16.analyze_quad_system(sub_qps)
        sub_q_forms = list(sub_ana["W_piv"].values())
    rem_f = s16.reduce_forms_mod_pivs(sub_q_forms + rescue_pool, sub["_lin_pivs"])[:4]
    for ns in range(1, min(4, len(rem_f)) + 1):
        op_ns = False
        for sb in range(1 << ns):
            ex2 = [(rem_f[j], (sb >> j) & 1) for j in range(ns)]
            sub2 = s9.run_branch_cascade(
                _R_LIB9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                ex2, _R_TBL, max_xl_rounds=18, verify_subst=True
            )
            if not sub2["closed_unsat"]:
                op_ns = True
                break
        if not op_ns:
            return ("RESCUED", rb, ns)

    n_act = _R_TBL["n"] - len(sub["_lin_pivs"])
    return ("OPEN", rb, (n_act, len(sub["_quad_ids"])))


def build_k0_canonical_root(tag):
    lib_diag, lib9, lib_cg, lib_d8 = k1c.compile_kernels(tag)
    so_s9_path = WORK_DIR / f"lib{tag}_s9.so"
    lib_sh = pilot.compile_shear(tag)

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
        oa = [((a << sh) | (a >> (8 - sh))) & 0xFF for sh in range(8)]
        seen_a.update(oa)
        ol = len(set(oa))
        d8_specs.append((a, 3))
        if ol == 4:
            d8_specs.append((a, 4))
        elif ol == 2:
            d8_specs.append((a, 5))
        elif ol == 1:
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
    L_vars_py = [i for i, j in enumerate(free111) if j in set(diag_v2.L_INDICES)]
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
    root0, _ = k1c.build_root(0, lib_diag, lib9, lib_cg, lib_d8, shared)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root0["_lin_pivs"])
    assert len(eta_free) == 6, f"Expected 6 eta_free forms in K=0, got {len(eta_free)}"

    root_fp_items = [f"{p}:{hex(pv)}:{pr}" for p, (pv, pr) in sorted(root0["_lin_pivs"].items())]
    root_fp_items.extend(hex(f) for f in eta_free)
    root_sha256 = hashlib.sha256(",".join(root_fp_items).encode()).hexdigest()
    return root0, eta_free, root_sha256, lib9, lib_sh, so_s9_path, tbl


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--eta", type=int, required=True)
    ap.add_argument("--kfix", type=int, default=0, help="Fixed k_fix (0 = auto)")
    ap.add_argument("--max-kfix", type=int, default=12, help="Max k_fix to run in 1 job")
    ap.add_argument("--shard-idx", type=int, default=0)
    ap.add_argument("--n-shards", type=int, default=1)
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--out-dir", type=str, default="k0_recert_out")
    args = ap.parse_args()

    t0 = time.perf_counter()
    em = args.eta
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    root0, eta_free, root_sha256, lib9, lib_sh, so_s9_path, tbl = build_k0_canonical_root(f"k0rc_{em}")
    eta_free_hex = [hex(f) for f in eta_free]
    ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(6)]
    sr = s9.run_branch_cascade(
        lib9, root0["_buf"], root0["_quad_ids"], root0["_cub_ids"], root0["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=25, verify_subst=True
    )

    if sr["closed_unsat"]:
        cert = {
            "eta_rep": em,
            "root_sha256": root_sha256,
            "eta_free_hex": eta_free_hex,
            "pre_branch": {"dim": 0, "quads": 0, "cubs": 0, "nW": 0, "low_bas_dim": 0},
            "k_fix": 0,
            "fix_forms_hex": [],
            "fix_sha256": hashlib.sha256(b"").hexdigest()[:16],
            "total_branches": 1,
            "covered_branches": 1,
            "direct_closed": 1,
            "rescued_closed": 0,
            "open_survivors": [],
            "verified_subst_branches": 1,
            "verdict": "ORBIT_FORMALLY_CLOSED_100%",
            "elapsed_s": round(time.perf_counter() - t0, 2),
        }
    else:
        lbl = f"K0_eta{em:02d}"
        info = s45a.extract_minrank_basis_for_state(lbl, sr, lib9, lib_sh, tbl, rng_seed=4300 + em)
        pre_branch = {
            "dim": 111 - len(sr["_lin_pivs"]),
            "quads": len(sr["_quad_ids"]),
            "cubs": len(sr["_cub_ids"]),
            "nW": int(info.get("nW", 0)),
            "low_bas_dim": int(info.get("low_bas_dim", 0)),
            "minrank_status": info.get("status", "OK"),
        }
        print(f"[{lbl}] pre_branch={pre_branch}", flush=True)

        if info.get("status") in ("NO_W", "NO_M1"):
            k_fix = int(info["nW"])
            fix_forms = list(info["W_forms"])
            rescue_forms = []
            fix_sha = hashlib.sha256(",".join(hex(f) for f in fix_forms).encode()).hexdigest()[:16]
        else:
            k_fix = args.kfix
            if k_fix <= 0:
                th = s45a.find_kfix_threshold(lbl, sr, info, lib9, tbl, rng_seed=4300 + em)
                if th is None:
                    k_fix = min(int(info["nW"]), args.max_kfix + 1)
                else:
                    k_fix = int(th[0])
            fix_forms, rescue_forms, fix_sha = s45a.build_fix_and_rescue_forms(info, k_fix)

        n_branches = 1 << k_fix
        print(f"[{lbl}] k_fix={k_fix}, total_branches={n_branches}, fix_sha256={fix_sha}", flush=True)

        if k_fix > args.max_kfix:
            cert = {
                "eta_rep": em,
                "root_sha256": root_sha256,
                "eta_free_hex": eta_free_hex,
                "pre_branch": pre_branch,
                "k_fix": k_fix,
                "fix_forms_hex": [hex(f) for f in fix_forms],
                "fix_sha256": fix_sha,
                "total_branches": n_branches,
                "covered_branches": 0,
                "direct_closed": 0,
                "rescued_closed": 0,
                "open_survivors": [],
                "verified_subst_branches": 0,
                "verdict": "NEEDS_SHARDING",
                "elapsed_s": round(time.perf_counter() - t0, 2),
            }
        else:
            n_cw = tbl["n_col_words"]
            max_active_row = max([-1] + list(sr["_quad_ids"]) + list(sr["_cub_ids"])) + 1
            buf_bytes = ctypes.string_at(ctypes.addressof(sr["_buf"]), max_active_row * n_cw * 8)
            _R_CTX.clear()
            _R_CTX.update({
                "so_s9_path": str(so_s9_path),
                "buf_bytes": buf_bytes,
                "quad_ids": list(sr["_quad_ids"]),
                "cub_ids": list(sr["_cub_ids"]),
                "lin_pivs": dict(sr["_lin_pivs"]),
                "fix_forms": fix_forms,
                "rescue_forms": rescue_forms + info.get("W_forms", []),
                "k_fix": k_fix,
            })
            direct_closed = 0
            rescued_closed = 0
            open_list = []
            checked = 0
            n_branches = 1 << k_fix
            lo = (n_branches * args.shard_idx) // args.n_shards
            hi = (n_branches * (args.shard_idx + 1)) // args.n_shards
            total_shard = hi - lo
            ctx = multiprocessing.get_context("fork")
            with ctx.Pool(processes=args.workers, initializer=_init_recert_worker) as pool:
                for tag_r, rb, payload in pool.imap_unordered(_eval_recert_branch, range(lo, hi), chunksize=2):
                    checked += 1
                    if tag_r == "DIRECT":
                        direct_closed += 1
                    elif tag_r == "RESCUED":
                        rescued_closed += 1
                    else:
                        open_list.append({"rb": rb, "N": payload[0], "q": payload[1]})
                    if checked % 64 == 0 or checked == total_shard:
                        print(f"  [{lbl} s{args.shard_idx}/{args.n_shards}] {checked}/{total_shard} direct={direct_closed} rescued={rescued_closed} open={len(open_list)} ({time.perf_counter()-t0:.1f}s)", flush=True)

            verdict = ("ORBIT_FORMALLY_CLOSED_100%" if args.n_shards == 1 else "SHARD_CLOSED_100%") if (checked == total_shard and not open_list) else "HAS_OPEN_SURVIVORS"
            cert = {
                "eta_rep": em,
                "root_sha256": root_sha256,
                "eta_free_hex": eta_free_hex,
                "pre_branch": pre_branch,
                "k_fix": k_fix,
                "fix_forms_hex": [hex(f) for f in fix_forms],
                "fix_sha256": fix_sha,
                "shard_idx": args.shard_idx,
                "n_shards": args.n_shards,
                "lo": lo,
                "hi": hi,
                "total_branches": total_shard,
                "covered_branches": checked,
                "direct_closed": direct_closed,
                "rescued_closed": rescued_closed,
                "open_survivors": open_list,
                "verified_subst_branches": checked,
                "verdict": verdict,
                "elapsed_s": round(time.perf_counter() - t0, 2),
            }

    suffix = f"_s{args.shard_idx}_of_{args.n_shards}" if args.n_shards > 1 else ""
    out_p = out_dir / f"k0_recert_eta{em:02d}{suffix}.json"
    out_p.write_text(json.dumps(cert, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(cert, indent=2), flush=True)


if __name__ == "__main__":
    main()
