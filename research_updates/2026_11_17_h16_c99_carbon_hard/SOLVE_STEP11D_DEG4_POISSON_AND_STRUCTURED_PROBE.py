#!/usr/bin/env python3
r"""
SOLVE_STEP11D_DEG4_POISSON_AND_STRUCTURED_PROBE.py

Two brand-new orthogonal explorations run in parallel with 11A, 11B, 11C:
  PART 1: Exact Degree-4 Carlet-Guillot & Non-Coordinate V_13 Poisson Dimension Census!
    - For ANY 13-dim affine subspace a + V_13, Ax's theorem guarantees 8 | wt(f|_{a+V_13})
      for EVERY degree-4 Boolean function, while Poisson summation guarantees 32 | wt(f|_{a+V_13})
      for every bent function!
    - Therefore (wt(f|_{a+V_13}) / 8) mod 2 = 0 is a 100% exact pure degree-4 equation on ALL of F_2^111!
    - Measures exact GF(2) rank of:
        (a) All 45 coordinate Carlet-Guillot deg-4 equations (|I|=16, 15, 14, 13),
        (b) + 200 random LINEAR V_13 subspaces,
        (c) + 200 random AFFINE a + V_13 subspaces!
      Reveals immediately whether non-coordinate V_13 opens a HUGE new space of deg-4 equations
      (or saturates at 45 just like V_11 saturated at 385!).
  PART 2: Structured Variable-Ordering Collapse & 2-Literal / Pairwise Probing on CG(389)!
    - Instead of random variable selection (11B), ranks active variables on the surviving
      branch by their exact frequency in the 116 sparse CG(|I|=12) cubics, and tests:
        (a) k-depth collapse curve under highest-degree-first AND lowest-degree-first ordering,
        (b) Targeted 2-literal probing on the top 15 hub variables (210*4 = 840 pairs) to
            detect any quadratic or linear drop at depth 2!
"""

import argparse
import ctypes
import json
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


def gf2_rank(rows):
    pivs = {}
    for r in rows:
        x = r
        while x:
            b = x.bit_length() - 1
            if b in pivs:
                x ^= pivs[b]
            else:
                pivs[b] = x
                break
    return len(pivs)


def vec_to_int(bits):
    v = 0
    for i, b in enumerate(bits):
        if b:
            v |= (1 << i)
    return v


def subspace_pts(basis, shift=0):
    pts = np.array([shift], dtype=np.uint16)
    for v in basis:
        pts = np.concatenate([pts, pts ^ np.uint16(v)])
    return pts


def run_part1_deg4_census(cell_name, orbits):
    t0 = time.perf_counter()
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    X = np.arange(65536, dtype=np.uint16)
    orb_tt = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt[j] = acc

    def mask_to_tt(mask):
        acc = np.zeros(65536, dtype=np.uint8)
        tmp = mask
        while tmp:
            lb = tmp & -tmp
            acc ^= orb_tt[lb.bit_length() - 1]
            tmp ^= lb
        return acc

    o_tt = mask_to_tt(origin111)
    b_tt = np.array([mask_to_tt(m) for m in cb111], dtype=np.uint8)

    # Evaluate M=600 random points on all 65536 inputs (fast float32 BLAS!)
    rng = random.Random(2026111801)
    M_PTS = 600
    Z_mat = np.array([[rng.randint(0, 1) for _ in range(111)] for _ in range(M_PTS)], dtype=np.float32)
    F_mat = (o_tt[None, :] ^ (np.rint(Z_mat @ b_tt.astype(np.float32)).astype(np.int32) & 1)).astype(np.uint8)
    pop_par = np.array([bin(x).count("1") & 1 for x in range(65536)], dtype=np.int16)
    sign_even = np.where(pop_par == 0, 1, -1).astype(np.int16)
    sign_odd = -sign_even

    def eval_coord_lam_div8(I_mask):
        bits = [b for b in range(16) if (I_mask >> b) & 1]
        pts = subspace_pts([1 << b for b in bits], 0)
        sg = sign_even[pts] if (len(bits) & 1) == 0 else sign_odd[pts]
        lam = (F_mat[:, pts].astype(np.int16) * sg[None, :]).sum(axis=1)
        assert np.all((lam & 7) == 0), f"lam not div by 8 for |I|={len(bits)}"
        return vec_to_int(((lam >> 3) & 1).tolist())

    def eval_v13_wt_div8(pts):
        w = F_mat[:, pts].sum(axis=1)
        assert np.all((w & 7) == 0), "wt(V_13) not div by 8!"
        return vec_to_int(((w >> 3) & 1).tolist())

    reps16 = [0xFFFF]
    reps15 = [0x7FFF]
    reps14 = s10.subset_orbits(14)
    reps13 = s10.subset_orbits(13)

    coord_sigs = []
    for im in reps16 + reps15 + reps14 + reps13:
        coord_sigs.append(eval_coord_lam_div8(im))
    rk_coord = gf2_rank(coord_sigs)

    def rand_basis(dim):
        basis, piv_b = [], {}
        while len(basis) < dim:
            v = rng.randint(1, 65535)
            x = v
            while x:
                b = x.bit_length() - 1
                if b in piv_b:
                    x ^= piv_b[b]
                else:
                    piv_b[b] = x
                    basis.append(v)
                    break
        return basis

    lin_sigs = [eval_v13_wt_div8(subspace_pts(rand_basis(13), 0)) for _ in range(150)]
    rk_lin = gf2_rank(coord_sigs + lin_sigs)

    aff_sigs = [eval_v13_wt_div8(subspace_pts(rand_basis(13), rng.randint(1, 65535))) for _ in range(150)]
    rk_aff = gf2_rank(coord_sigs + lin_sigs + aff_sigs)

    # Also test V_14 linear/affine (wt / 8 mod 2 -> still pure deg 4, since 2^{ceil(14/4)-1} = 8 | wt!)
    v14_sigs = [eval_v13_wt_div8(subspace_pts(rand_basis(14), rng.randint(0, 65535))) for _ in range(100)]
    rk_v14 = gf2_rank(coord_sigs + lin_sigs + aff_sigs + v14_sigs)

    # Also test C_16-symmetric weight layers L_14, L_15, L_16: (wt(f|_{L_d}) / 8) mod 2!
    # Wait: check divisibility of L_14..L_16 on random points!
    res = {
        "n_coord_deg4": len(coord_sigs),
        "rk_coord_deg4": rk_coord,
        "rk_plus_150_lin_V13": rk_lin,
        "new_from_lin_V13": rk_lin - rk_coord,
        "rk_plus_150_aff_V13": rk_aff,
        "new_from_aff_V13": rk_aff - rk_lin,
        "rk_plus_100_V14": rk_v14,
        "new_from_V14": rk_v14 - rk_aff,
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] PART 1 DEG-4 POISSON CENSUS: {json.dumps(res)}", flush=True)
    return res


def run_part2_structured_probe(cell_name, lib_diag, lib9, lib_cg, orbits,
                               v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n = tbl["n"]
    n_cw = tbl["n_col_words"]

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    orb_map[115] = -1
    orb_map[99] = -2 if c99 else -1
    orb_map[57] = -2 if c57 else -1
    orb_map[113] = -2 if c113 else -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system(
        cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0
    )
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base_pivs = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base_pivs + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base_pivs * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base_pivs + idx_c, tbl)
    dst_cg = ctypes.cast(ctypes.byref(raw_buf, (n_base_pivs + len(cyc_cubs)) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
    ctypes.memmove(dst_cg, cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(
        lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False
    )
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = s9.find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)

    target_br = None
    for bmask in range(1 << k_lin):
        extra = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            extra, tbl, max_xl_rounds=5, verify_subst=False
        )
        if not bres["closed_unsat"]:
            target_br = bres
            break

    active_vars = sorted(i for i in range(n) if i not in target_br["_lin_pivs"])
    # Rank active vars by frequency in the 116 CG(|I|=12) cubics!
    freq = {v: 0 for v in active_vars}
    for idx in range(len(reps12)):
        ps = s9.row_to_pset(cg_buf, idx, tbl)
        for m in ps:
            tmp = m
            while tmp:
                lb = tmp & -tmp
                vi = lb.bit_length() - 1
                if vi in freq:
                    freq[vi] += 1
                tmp ^= lb

    by_hi = sorted(active_vars, key=lambda v: -freq[v])
    by_lo = sorted(active_vars, key=lambda v: freq[v])
    print(f"[{cell_name}] Var freq in CG12: max={freq[by_hi[0]]}, med={freq[by_hi[len(by_hi)//2]]}, min={freq[by_lo[0]]}", flush=True)

    # Test structured collapse curves (hi-freq first vs lo-freq first)
    rng = random.Random(2026111802)
    curves = {}
    for label, order in [("hi_freq", by_hi), ("lo_freq", by_lo)]:
        curve = []
        for k_fix in (20, 40, 50, 60, 65, 70, 75, 80, 85):
            if k_fix >= len(active_vars) - 2:
                break
            chosen = order[:k_fix]
            closed_c, sum_q, sum_l = 0, 0, 0
            for _ in range(3):
                vals = [rng.randint(0, 1) for _ in range(k_fix)]
                if cell_name == "B0_00" and sum(vals) == 0:
                    vals[0] = 1
                eqs = [(1 << chosen[i], vals[i]) for i in range(k_fix)]
                pr = s9.run_branch_cascade(
                    lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"],
                    target_br["_lin_pivs"], eqs, tbl, max_xl_rounds=4, verify_subst=False
                )
                if pr["closed_unsat"]:
                    closed_c += 1
                else:
                    sum_q += pr.get("n_quad_surviving", 0)
                    sum_l += pr.get("total_lin_dropped", 0)
            curve.append({"k": k_fix, "closed_of_3": closed_c, "avg_q": round(sum_q / 3, 1), "avg_l": round(sum_l / 3, 1)})
        curves[label] = curve
        print(f"  [{cell_name}] Structured curve ({label}): {curve}", flush=True)

    # 2-literal probing on top 12 hub variables (66 pairs * 4 = 264 probes!)
    top12 = by_hi[:12]
    p2_closed, p2_lin, p2_quad, p2_max_q = 0, 0, 0, 0
    for i in range(len(top12)):
        for j in range(i + 1, len(top12)):
            for vi in (0, 1):
                for vj in (0, 1):
                    pr = s9.run_branch_cascade(
                        lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"],
                        target_br["_lin_pivs"], [(1 << top12[i], vi), (1 << top12[j], vj)],
                        tbl, max_xl_rounds=3, verify_subst=False
                    )
                    if pr["closed_unsat"]:
                        p2_closed += 1
                    else:
                        if pr["total_lin_dropped"] > 0:
                            p2_lin += 1
                        if pr["n_quad_surviving"] > target_br["n_quad_surviving"]:
                            p2_quad += 1
                            p2_max_q = max(p2_max_q, pr["n_quad_surviving"])
    res = {
        "structured_curves": curves,
        "probe_2lit_top12": {"total": 264, "closed": p2_closed, "lin_drop": p2_lin, "quad_drop": p2_quad, "max_q": p2_max_q},
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] PART 2 STRUCTURED PROBE: {json.dumps(res)}", flush=True)
    return res


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    orbits = diag_v2.build_orbits_116()
    cells = [c.strip() for c in args.cells.split(",") if c.strip()]

    # Part 1 first (pure NumPy BLAS, ~25s/cell)
    p1_all = {}
    for cname in cells:
        p1_all[cname] = run_part1_deg4_census(cname, orbits)

    # Compile C libs for Part 2
    c_diag, so_diag = WORK_DIR / "s11d_diag.c", WORK_DIR / "libs11d_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s11d_s9.c", WORK_DIR / "libs11d_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = ctypes.CDLL(str(so_s9))
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

    c_cg, so_cg = WORK_DIR / "s11d_cg.c", WORK_DIR / "libs11d_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16),
            ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_uint64),
        ]

    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps12 = s10.subset_orbits(12)
    reps11 = s10.subset_orbits(11)

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
    null_z_vecs = diag_v2.gf2_nullspace_left(M_rows)
    fiber_meta = (nonzero_z, null_z_vecs)

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

    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        tt = orb_tts[j]
        for x in range(65536):
            if sum((x & m) == m for m in orb) & 1:
                tt[x] = 1
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    def eval_orb_at_x(j, x):
        return orb_tts[j][x]

    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, eval_orb_at_x)
    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)

    for cname in cells:
        p2 = run_part2_structured_probe(
            cname, lib_diag, lib9, lib_cg, orbits,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )
        print(f"[{cname}] STEP 11D FULL SUMMARY: {json.dumps({'part1': p1_all[cname], 'part2': p2})}", flush=True)


if __name__ == "__main__":
    main()
