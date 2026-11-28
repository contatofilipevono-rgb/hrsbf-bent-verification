#!/usr/bin/env python3
"""
SOLVE_B111_B011_POISSON_ALGEBRA.py

Pure-Algebraic Generalized Poisson Law Injection for H(16,4) Open Cells B1_11 and B0_11.
  - Exact A13/A14 admissible joint (W_ff, W_55) sets:
      * B1_11 (c99=1, c57=c113=1, proven C5 K=1): {(-64,-64), (-64,64), (64,0), (192,-64)}
        (and optional --wide-b111 adding (0,32), (0,-32))
      * B0_11 (c99=0, c57=c113=1, NO unproved C5 -> force_k=-1): {(-128,-128), (-128,128), (0,64), (128,0)}
  - Verifies true c99 is passed to CG12/CG11 (c99=1 for B1_11, c99=0 for B0_11).
  - Projects the active post-cascade affine subspace onto joint (z=0xff, z=0x55) (dim <= 11),
    extracts the EXACT vanishing ideal up to degree 3 (linear + quad + cubic) via GF(2) RREF,
    Zero-Trust verifies every extracted polynomial on 10,000 random points (0 violations on
    admissible tuples, exact detection on inadmissible tuples), and injects them into:
      DIAGNOSE_V2_STRUCTURE + CG(389) + Cyclotomic + XL -> Step 63A (AC180+D8-PQ72) -> MAC_D3 -> W_ess.
"""

import argparse
import ctypes
import json
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
REPO_DIR = WORK_DIR.parent.parent
A14_DIR = REPO_DIR / "research_updates" / "2026_11_24_h16_diagonal_orbits"
sys.path.insert(0, str(WORK_DIR))
sys.path.insert(0, str(A14_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP63B_MAC_D4_AND_DEEP_XL_SHATTER as s63b
import SOLVE_STEP64A_AC180_MAC3_FUSION as s64a

A14_LMASK = [0x2, 0x4, 0x8, 0x1000, 0x2000, 0x4001, 0x1000000]

# Exact A13/A14 admissible (W_ff, W_55) sets (verified from 16 B0_11 duals and 110 B1_11 duals)
ADMISS_B011 = {(-128, -128), (-128, 128), (0, 64), (128, 0)}
ADMISS_B111 = {(-64, -64), (-64, 64), (64, 0), (192, -64)}
ADMISS_B111_WIDE = ADMISS_B111 | {(0, 32), (0, -32)}


def xor_selected(vals, mask):
    out = 0
    while mask:
        lb = mask & -mask
        out ^= vals[lb.bit_length() - 1]
        mask ^= lb
    return out


def build_a14_layer_forms(orbits):
    """Exact 7-dim (u^3 z) layer forms in 116-orbit coordinates (matches A14)."""
    from collections import defaultdict
    layers = defaultdict(int)
    for idx, orb in enumerate(orbits):
        for mon in orb:
            prod = [(0, 0)]
            for j in range(16):
                if (mon >> j) & 1:
                    k = j % 8
                    new_prod = [(u | (1 << k), z) for u, z in prod]
                    if j >= 8:
                        new_prod.extend((u, z | (1 << k)) for u, z in prod)
                    prod = new_prod
            for u, z in prod:
                if u.bit_count() == 3 and z.bit_count() == 1:
                    layers[(u, z)] ^= 1 << idx
    return [m for _, m in sorted(layers.items()) if m]


def compile_c_libs():
    c_diag, so_diag = WORK_DIR / "spois_diag.c", WORK_DIR / "libspois_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "spois_s9.c", WORK_DIR / "libspois_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(str(so_s9))

    c_cg, so_cg = WORK_DIR / "spois_cg.c", WORK_DIR / "libspois_cg.so"
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

    c_sh, so_sh = WORK_DIR / "spois_sh.c", WORK_DIR / "libspois_sh.so"
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

    lib_ac = s63a.compile_step63a_c()
    lib_d4 = s60c.compile_step60c_c()
    lib63 = s63b.compile_step63b_c()
    s63b.zt_audit_c_engines(lib63)
    return lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63


def build_cell_root_sound(cell_name, libs):
    """Build exact root for B1_11 (c99=1, force_k=1 proven) or B0_11 (c99=0, force_k=-1 C5-free)."""
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    # B1_11 has proven C5 (K=1); B0_11 has c99=0 so C5 is NOT proven -> force_k=-1!
    force_k = 1 if (c99 == 1 and c57 == 1) else -1
    print(f"=== Building {cell_name} root (c99={c99}, c57={c57}, c113={c113}, force_k={force_k}) ===", flush=True)

    orbits = diag_v2.build_orbits_116()
    a14_forms = build_a14_layer_forms(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for mon in orb:
            mon_to_orb_arr[mon] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)

    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1:
                row_mask |= 1 << m_idx
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
        for mon in orb:
            acc ^= ((X & mon) == mon).astype(np.uint8)
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
    n, n_cw = tbl["n"], tbl["n_col_words"]
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    b_tt_111 = np.zeros((111, 65536), dtype=np.uint8)
    for i, m_orb in enumerate(cb111):
        tmp = m_orb
        while tmp:
            lb = tmp & -tmp
            b_tt_111[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb
    o_tt_111 = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp
        o_tt_111 ^= orb_tt_np[lb.bit_length() - 1]
        tmp ^= lb

    # Explicit true-c99 CG12 + CG11 construction (zero c99=0 hardcoding bug!)
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
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr,
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr,
        )
    # Zero-trust verify 2 CG12 + 2 CG11 rows directly against lambda_I(f) with true c99!
    for idx_v in (0, 1, len(reps12), len(reps12) + 1):
        I_m = reps12[idx_v] if idx_v < len(reps12) else reps11[idx_v - len(reps12)]
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx_v * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        s10.zero_trust_verify_cg_row(rptr, I_m, c99, c57, c113, orbits, lib9, tbl)
    print(f"  [ZT CG] Verified true c99={c99} CG12/CG11 rows directly against lambda_I(f): PASS", flush=True)

    sys_data = diag_v2.build_cell_algebraic_system(
        cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta,
        extract_sec=18.0, force_k=force_k,
    )
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_base = n_base + len(cyc_cubs) + n_cg
    base_buf = (ctypes.c_uint64 * (total_base * n_cw))()
    ctypes.memmove(base_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, base_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(base_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, base_buf, [], list(range(total_base)), {}, [], tbl, max_xl_rounds=20, verify_subst=True)
    print(f"  [{cell_name} ROOT] closed={root['closed_unsat']}, dim={111 - len(root['_lin_pivs'])}, q={len(root['_quad_ids'])}, c={len(root['_cub_ids'])}", flush=True)

    all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices = s63a.build_all_4115_c16_shifts()
    c8_idx_256, z_reps_36, z_reps_py = s63a.build_c8_orbit_tables()
    coord_subs = s60c.build_coordinate_subspaces()

    return {
        "cell_name": cell_name, "c99": c99, "c57": c57, "c113": c113, "force_k": force_k,
        "tbl": tbl, "root": root, "cb111": cb111, "origin111": origin111, "a14_forms": a14_forms,
        "o_tt_111": o_tt_111, "b_tt_111": b_tt_111,
        "all_shifts_u16": all_shifts_u16, "all_shifts_py": all_shifts_py,
        "d8_shifts": d8_shifts, "struct_set": struct_set, "struct_indices": struct_indices,
        "c8_idx_256": c8_idx_256, "z_reps_36": z_reps_36, "z_reps_py": z_reps_py,
        "coord_subs": coord_subs,
    }


def fix_a14_fiber(env, e_val, lib9):
    """Fix the exact 7-dim (u^3 z) layer to A14 representative e_val."""
    cb111, origin111, a14_forms = env["cb111"], env["origin111"], env["a14_forms"]
    val_e = xor_selected(A14_LMASK, e_val)
    ex_e = []
    for fm in a14_forms:
        mask_111 = sum((((v & fm).bit_count() & 1) << i) for i, v in enumerate(cb111))
        rhs = ((val_e & fm).bit_count() ^ (origin111 & fm).bit_count()) & 1
        if mask_111 or rhs:
            ex_e.append((mask_111, rhs))
    root = env["root"]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_e, env["tbl"], max_xl_rounds=25, verify_subst=True,
    )
    return sr


def extract_poisson_joint_ideal(orig_f, basis_f, active_vars, admiss_set, max_deg=3, seed=9501):
    """
    Project affine subspace (orig_f, basis_f) onto joint (z=0xff, z=0x55) (512 bits),
    extract the EXACT vanishing ideal up to max_deg (in GF(2)[y_0..y_{d-1}]),
    pull back to 111-var psets, and Zero-Trust verify on 10,000 random points!
    """
    N = len(active_vars)
    # Extract 256-bit truth tables for z=0xff and z=0x55: x = u | ((u ^ z) << 8)
    idx_ff = np.array([u | ((u ^ 0xFF) << 8) for u in range(256)], dtype=np.int32)
    idx_55 = np.array([u | ((u ^ 0x55) << 8) for u in range(256)], dtype=np.int32)

    def pack512(tt):
        w_ff = int.from_bytes(np.packbits(tt[idx_ff], bitorder="little").tobytes(), "little")
        w_55 = int.from_bytes(np.packbits(tt[idx_55], bitorder="little").tobytes(), "little")
        return w_ff | (w_55 << 256)

    o_word = pack512(orig_f)
    b_words = [pack512(basis_f[i]) for i in range(N)]

    # Build basis B of span(b_words) and linear forms F_r (over active_vars 0..N-1)
    piv = {}
    B = []
    coords = []
    for bw in b_words:
        v = bw
        tag = 0
        while v:
            p = v.bit_length() - 1
            if p not in piv:
                j = len(B)
                B.append(v)
                piv[p] = (v, 1 << j)
                tag ^= 1 << j
                break
            r, t = piv[p]
            v ^= r
            tag ^= t
        coords.append(tag)
    d = len(B)
    assert d <= 14, f"Unexpectedly large joint (0xff, 0x55) dim={d}"
    # Linear form F_r in 111-var bitmask for each projected coordinate y_r (r=0..d-1)
    F_111 = [sum((((coords[i] >> r) & 1) << active_vars[i]) for i in range(N)) for r in range(d)]

    # Enumerate ALL 2^d states in the joint image
    span_w = [o_word]
    for b in B:
        span_w += [x ^ b for x in span_w]
    mask256 = (1 << 256) - 1
    S = []
    for y, w in enumerate(span_w):
        w_ff = 256 - 2 * (w & mask256).bit_count()
        w_55 = 256 - 2 * (w >> 256).bit_count()
        if (w_ff, w_55) in admiss_set:
            S.append(y)

    if len(S) == 0:
        return {"joint_dim": d, "admissible_states": 0, "closed_directly": True, "psets_le2": [{0}], "psets_deg3": []}

    # Exact vanishing ideal up to max_deg in GF(2)[y_0..y_{d-1}]
    mons = [0]
    for deg in range(1, max_deg + 1):
        for comb in combinations(range(d), deg):
            mons.append(sum(1 << c for c in comb))

    piv_eval = {}
    vanish_y_polys = {1: [], 2: [], 3: []}
    for m_idx, mon in enumerate(mons):
        ev = 0
        for si, y in enumerate(S):
            if (y & mon) == mon:
                ev |= 1 << si
        deg = mon.bit_count()
        comb = 1 << m_idx
        while ev:
            b = ev.bit_length() - 1
            if b in piv_eval:
                pev, pcomb = piv_eval[b]
                ev ^= pev
                comb ^= pcomb
            else:
                piv_eval[b] = (ev, comb)
                break
        if ev == 0 and deg >= 1:
            # Decode comb into list of y-monomials
            ymons = []
            tmp = comb
            while tmp:
                lb = tmp & -tmp
                ymons.append(mons[lb.bit_length() - 1])
                tmp ^= lb
            vanish_y_polys[deg].append(ymons)

    # Pull back y-polynomials to 111-var psets via y_r = <F_111[r], x>
    def mul_pset(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                m_ab = a | b
                if m_ab in out:
                    out.remove(m_ab)
                else:
                    out.add(m_ab)
        return out

    F_psets = [{1 << i for i in range(111) if (fm >> i) & 1} for fm in F_111]

    def pullback(ymons):
        acc = set()
        for ym in ymons:
            term = {0}
            tmp = ym
            while tmp:
                lb = tmp & -tmp
                term = mul_pset(term, F_psets[lb.bit_length() - 1])
                tmp ^= lb
            acc ^= term
        return acc

    psets_by_deg = {deg: [p for p in (pullback(ym) for ym in vanish_y_polys[deg]) if p] for deg in (1, 2, 3)}
    psets_le2 = psets_by_deg[1] + psets_by_deg[2]
    psets_deg3 = psets_by_deg[3]
    all_psets = psets_le2 + psets_deg3

    # 10,000-point Direct Truth-Table Zero-Trust Verification!
    rng = random.Random(seed)
    n_admiss = 0
    n_inadmiss = 0
    n_admiss_viol = 0
    n_inadmiss_caught_le2 = 0
    n_inadmiss_caught_all = 0
    o_ff = orig_f[idx_ff]
    o_55 = orig_f[idx_55]
    b_ff = basis_f[:, idx_ff]
    b_55 = basis_f[:, idx_55]

    def eval_pset_111(ps, x111):
        val = 0
        for mon in ps:
            if (x111 & mon) == mon:
                val ^= 1
        return val

    for _ in range(10000):
        # Sample random point in active_vars
        x111 = 0
        cur_ff = o_ff.copy()
        cur_55 = o_55.copy()
        for i in range(N):
            if rng.getrandbits(1):
                x111 |= 1 << active_vars[i]
                cur_ff ^= b_ff[i]
                cur_55 ^= b_55[i]
        w_ff = 256 - 2 * int(cur_ff.sum())
        w_55 = 256 - 2 * int(cur_55.sum())
        is_adm = (w_ff, w_55) in admiss_set
        v_le2 = any(eval_pset_111(ps, x111) for ps in psets_le2)
        v_all = v_le2 or any(eval_pset_111(ps, x111) for ps in psets_deg3)
        if is_adm:
            n_admiss += 1
            if v_all:
                n_admiss_viol += 1
        else:
            n_inadmiss += 1
            if v_le2:
                n_inadmiss_caught_le2 += 1
            if v_all:
                n_inadmiss_caught_all += 1

    assert n_admiss_viol == 0, f"ZERO-TRUST FAIL: {n_admiss_viol}/{n_admiss} admissible points violated Poisson ideal!"
    print(
        f"  [POISSON (0xff,0x55)] joint_dim={d}, |S|={len(S)}/{1<<d}, ideal_deg(1,2,3)="
        f"({len(psets_by_deg[1])},{len(psets_by_deg[2])},{len(psets_by_deg[3])}) | "
        f"ZT 10k: admiss={n_admiss} (viol=0), inadmiss={n_inadmiss} "
        f"(caught_le2={n_inadmiss_caught_le2}, caught_le3={n_inadmiss_caught_all})",
        flush=True,
    )
    return {
        "joint_dim": d,
        "admissible_states": len(S),
        "total_states": 1 << d,
        "closed_directly": False,
        "counts_by_deg": {str(k): len(psets_by_deg[k]) for k in (1, 2, 3)},
        "zt_10k": {
            "admissible": n_admiss,
            "admissible_violations": n_admiss_viol,
            "inadmissible": n_inadmiss,
            "caught_le2": n_inadmiss_caught_le2,
            "caught_le3": n_inadmiss_caught_all,
        },
        "psets_le2": psets_le2,
        "psets_deg3": psets_deg3,
    }


def measure_wess(label, sr, lib9, lib_sh, tbl, rng_seed):
    if sr["closed_unsat"]:
        return {"status": "CLOSED_UNSAT", "dim": 0, "quads": 0, "cubs": 0, "nW": 0, "low_bas_dim": 0, "k_fix": 0}
    dim = 111 - len(sr["_lin_pivs"])
    q = len(sr["_quad_ids"])
    c = len(sr["_cub_ids"])
    info = s45a.extract_minrank_basis_for_state(label, sr, lib9, lib_sh, tbl, rng_seed=rng_seed)
    nW = info.get("nW", 0)
    low_bas = info.get("low_bas_dim", 0)
    k_fix = None
    avg_dt = None
    if nW > 0 and low_bas > 0:
        th = s45a.find_kfix_threshold(label, sr, info, lib9, tbl, rng_seed=rng_seed + 17)
        if th is not None:
            k_fix, avg_dt = int(th[0]), round(float(th[1]), 3)
    return {"status": "OPEN", "dim": dim, "quads": q, "cubs": c, "nW": nW, "low_bas_dim": low_bas, "k_fix": k_fix, "avg_dt": avg_dt}


def run_pilot(cell_name, rep_e, libs, wide_b111=False):
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    env = build_cell_root_sound(cell_name, libs)
    tbl = env["tbl"]
    admiss = (ADMISS_B111_WIDE if wide_b111 else ADMISS_B111) if cell_name == "B1_11" else ADMISS_B011

    sr_base = fix_a14_fiber(env, rep_e, lib9)
    base_sig = {
        "closed": sr_base["closed_unsat"],
        "dim": 111 - len(sr_base["_lin_pivs"]),
        "quads": len(sr_base["_quad_ids"]),
        "cubs": len(sr_base["_cub_ids"]),
    }
    print(f"\n[{cell_name} e={rep_e}] BASELINE (CG+Q4+V6+Rot4+Cyc+XL): {base_sig}", flush=True)
    res = {"cell": cell_name, "rep": rep_e, "c99": env["c99"], "force_k": env["force_k"], "baseline": base_sig}
    if sr_base["closed_unsat"]:
        res["verdict"] = "CLOSED_AT_BASELINE"
        return res

    # Baseline W_ess
    res["baseline_wess"] = measure_wess(f"{cell_name}_e{rep_e}_base", sr_base, lib9, lib_sh, tbl, rng_seed=9500 + rep_e)
    print(f"  [BASELINE W_ess]: {res['baseline_wess']}", flush=True)

    # Extract Exact Joint (0xff, 0x55) Poisson Ideal on active baseline coordinates
    f_act = sorted(i for i in range(111) if i not in sr_base["_lin_pivs"])
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_base["_lin_pivs"], f_act)
    pois = extract_poisson_joint_ideal(orig_f, basis_f, f_act, admiss, max_deg=3, seed=9501 + rep_e)
    res["poisson_ideal"] = {k: v for k, v in pois.items() if k not in ("psets_le2", "psets_deg3")}

    # Stage 1: Inject Poisson deg <= 2 into s9
    sr_p2 = sr_base
    if pois["psets_le2"]:
        sr_p2, _ = s60c.inject_psets_into_s9(sr_base, pois["psets_le2"], lib9, tbl)
    res["after_poisson_le2"] = {
        "closed": sr_p2["closed_unsat"],
        "dim": 111 - len(sr_p2["_lin_pivs"]),
        "quads": len(sr_p2["_quad_ids"]),
        "cubs": len(sr_p2["_cub_ids"]),
    }
    print(f"  [AFTER POISSON deg<=2]: {res['after_poisson_le2']}", flush=True)

    # Stage 2: Inject Poisson deg == 3 into s9
    sr_p3 = sr_p2
    if not sr_p2["closed_unsat"] and pois["psets_deg3"]:
        sr_p3, _ = s60c.inject_psets_into_s9(sr_p2, pois["psets_deg3"], lib9, tbl)
    res["after_poisson_le3"] = {
        "closed": sr_p3["closed_unsat"],
        "dim": 111 - len(sr_p3["_lin_pivs"]),
        "quads": len(sr_p3["_quad_ids"]),
        "cubs": len(sr_p3["_cub_ids"]),
    }
    print(f"  [AFTER POISSON deg<=3]: {res['after_poisson_le3']}", flush=True)

    # Stage 3: Run Step 63A (AC180 + AC4115 + D8-PQ72) on post-Poisson state!
    sr_ac = sr_p3
    if not sr_p3["closed_unsat"]:
        f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
        orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
        out_st = {}
        s63a.run_autocorr_and_parseval_suite(
            orig_f3, basis_f3, f_act3, sr_p3,
            env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
            env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
            lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
            tag=f"{cell_name}_e{rep_e}_post_pois", seed=9600 + rep_e,
            vq_ctx=None, do_deg4_compare=False, out_states=out_st,
        )
        sr_ac = out_st.get("sub_ac", sr_p3)
    res["after_poisson_plus_ac180"] = {
        "closed": sr_ac["closed_unsat"],
        "dim": 111 - len(sr_ac["_lin_pivs"]),
        "quads": len(sr_ac["_quad_ids"]),
        "cubs": len(sr_ac["_cub_ids"]),
    }
    print(f"  [AFTER POISSON + AC180]: {res['after_poisson_plus_ac180']}", flush=True)

    # Stage 4: Optional MAC_D3 if N <= 78, and post-Poisson W_ess measurement!
    if not sr_ac["closed_unsat"] and (111 - len(sr_ac["_lin_pivs"])) <= 78:
        mac_status, mac_trace = s64a.run_mac_on_substate(
            sr_ac, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=False, tag=f"{cell_name}_e{rep_e}",
        )
        res["mac_d3"] = {"status": mac_status, "trace": mac_trace}
        print(f"  [MAC_D3]: {mac_status} | {mac_trace}", flush=True)

    res["after_wess"] = measure_wess(f"{cell_name}_e{rep_e}_after", sr_ac, lib9, lib_sh, tbl, rng_seed=9700 + rep_e)
    print(f"  [AFTER POISSON + AC180 W_ess]: {res['after_wess']}", flush=True)
    res["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", choices=["B1_11", "B0_11", "BOTH"], default="BOTH")
    ap.add_argument("--rep", type=int, default=None)
    ap.add_argument("--wide-b111", action="store_true")
    ap.add_argument("--out-json", type=str, default="poisson_algebra_results.json")
    args = ap.parse_args()

    libs = compile_c_libs()
    results = []
    if args.cell == "BOTH":
        results.append(run_pilot("B1_11", 1, libs, wide_b111=args.wide_b111))
        results.append(run_pilot("B0_11", 2, libs, wide_b111=args.wide_b111))
    else:
        rep_e = args.rep if args.rep is not None else (1 if args.cell == "B1_11" else 2)
        results.append(run_pilot(args.cell, rep_e, libs, wide_b111=args.wide_b111))

    Path(args.out_json).write_text(json.dumps(results, indent=2) + "\n", encoding="utf-8")
    print(f"\n=== WRITTEN TO {args.out_json} ===", flush=True)
    print(json.dumps(results, indent=2), flush=True)


if __name__ == "__main__":
    main()
