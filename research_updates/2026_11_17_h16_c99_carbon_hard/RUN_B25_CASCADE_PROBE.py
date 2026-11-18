#!/usr/bin/env python3
"""
RUN_B25_CASCADE_PROBE.py
End-to-end driver & auditor for `in_cube_cascade.c` (Task b25_in_cube_degree_drop_c)
across the 4 symmetric cells: B1_00, B1_11, B0_11, B0_00.

Usage:
  python3 RUN_B25_CASCADE_PROBE.py              # runs all 4 symmetric cells
  python3 RUN_B25_CASCADE_PROBE.py B1_11 B0_00  # runs selected cells
"""
import ctypes
import json
import os
import random
import subprocess
import sys
import time
from pathlib import Path

from AUDIT_ALL_CELLS_111 import (
    C_SRC as C_SRC_AUDIT,
    I1, I2, I3, I4, J1, J2, J3, J4,
    K_INDICES, L_INDICES,
    all_v6_orbits, build_orbits_116, decode_row_to_pset, interleave16, rot8, rot16,
)
from SOLVE_C99_0_MASTER_CLOSE import build_c8_orbits, extract_sym2_poly, fiber_orbit_reps, gf2_nullspace_left
from SOLVE_STEP7_MOD32_ROT4 import U4_LIST, extract_mod8_from_orbits4, nullspace_basis, sample_rot4_wperp, span_set


MAX_VARS = 116


class CascadeSummary(ctypes.Structure):
    _fields_ = [
        ("unsat", ctypes.c_int),
        ("initial_fixed", ctypes.c_int),
        ("final_fixed", ctypes.c_int),
        ("final_bin_merges", ctypes.c_int),
        ("final_lin_pivs", ctypes.c_int),
        ("final_quad_pivs", ctypes.c_int),
        ("free_vars_remaining", ctypes.c_int),
        ("cascade_rounds", ctypes.c_int),
        ("probe_rounds", ctypes.c_int),
        ("probe_units_found", ctypes.c_int),
        ("probe_merges_found", ctypes.c_int),
        ("probe_zassenhaus_lins", ctypes.c_int),
        ("cubics_dropped", ctypes.c_int),
        ("cubics_remaining", ctypes.c_int),
        ("out_rep_var", ctypes.c_uint8 * MAX_VARS),
        ("out_rep_phase", ctypes.c_uint8 * MAX_VARS),
    ]


def compile_cascade_lib(work_dir: Path):
    c_file = work_dir / "in_cube_cascade.c"
    if not c_file.exists():
        raise FileNotFoundError(f"Missing {c_file}! Save in_cube_cascade.c in {work_dir}.")
    so_file = work_dir / "libincube_cascade.so"
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_file), "-o", str(so_file)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_file))
    lib.cascade_create_system.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32)
    ]
    lib.cascade_create_system.restype = ctypes.c_void_p
    lib.cascade_free_system.argtypes = [ctypes.c_void_p]
    lib.cascade_free_system.restype = None

    lib.cascade_and_probe.argtypes = [
        ctypes.c_void_p,
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.c_int,
        ctypes.POINTER(CascadeSummary),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int),
    ]
    lib.cascade_and_probe.restype = ctypes.c_int

    lib.cascade_batch_cubes.argtypes = [
        ctypes.c_void_p,
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int),
    ]
    lib.cascade_batch_cubes.restype = ctypes.c_int
    return lib


def pack_psets_to_csr(psets):
    offsets = [0]
    terms = []
    for pset in psets:
        for m in pset:
            if m == 0:
                terms.append(0xFFFFFF)
            else:
                vs = []
                tmp = m
                while tmp:
                    lsb = tmp & -tmp
                    vs.append(lsb.bit_length() - 1)
                    tmp ^= lsb
                while len(vs) < 3:
                    vs.append(0xFF)
                terms.append(vs[0] | (vs[1] << 8) | (vs[2] << 16))
        offsets.append(len(terms))
    off_arr = (ctypes.c_int * len(offsets))(*offsets)
    term_arr = (ctypes.c_uint32 * max(1, len(terms)))(*terms) if terms else (ctypes.c_uint32 * 1)(0)
    return len(psets), off_arr, term_arr


def selftest_cascade_engine(lib):
    """Zero-Trust unit test verifying exactness on planted SAT & planted 1-step Probing UNSAT."""
    n = 12
    rng = random.Random(42)
    sol = rng.getrandbits(n)  # secret planted root!

    psets = []
    # 1) Create cubic & quadratic equations satisfied by `sol`, including a hidden failed literal on x_0:
    # Force x_0 == ((sol >> 0) & 1) via two cubics that collapse when x_0 = 1 ^ sol_0!
    sol0 = (sol >> 0) & 1
    bad0 = 1 ^ sol0
    # When x_0 == bad0, (x_0 ^ sol0) == 1:
    # Eq A: (x_0 ^ sol0) * (x_1 ^ 1) == 0  and  Eq B: (x_0 ^ sol0) * x_1 == 0  => forces x_0 == sol0!
    def lin_poly(v, c):
        p = {1 << v}
        if c:
            p.add(0)
        return p

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                out.symmetric_difference_update({a | b})
        return out

    p_x0 = lin_poly(0, sol0)  # vanishes at x_0 == sol0, equals 1 at x_0 == bad0!
    psets.append(mul_p(p_x0, mul_p({1 << 1}, {1 << 2, 0})))  # (x0^sol0)*x1*(x2^1) = 0
    psets.append(mul_p(p_x0, mul_p({1 << 1}, {1 << 2})))     # (x0^sol0)*x1*x2 = 0 -> sum = (x0^sol0)*x1 = 0
    psets.append(mul_p(p_x0, {1 << 1, 0}))                   # (x0^sol0)*(x1^1) = 0 -> forces x0 == sol0 in 1-step probe!

    # Also plant a Zassenhaus binary merge: x_3 == x_4 ^ ((sol>>3)&1) ^ ((sol>>4)&1)
    rel34 = ((sol >> 3) & 1) ^ ((sol >> 4) & 1)
    # In branch x_3=0 => x_4=rel34; in branch x_3=1 => x_4=1^rel34 via quadratic split:
    psets.append(mul_p(lin_poly(3, 1), lin_poly(4, rel34)))      # if x_3=0: 1*(x_4^rel34)=0
    psets.append(mul_p(lin_poly(3, 0), lin_poly(4, 1 ^ rel34)))  # if x_3=1: 1*(x_4^1^rel34)=0

    # Add 20 random cubics satisfied by `sol`
    for _ in range(20):
        p = set()
        for _ in range(8):
            comb = rng.sample(range(n), 3)
            m = (1 << comb[0]) | (1 << comb[1]) | (1 << comb[2])
            p.symmetric_difference_update({m})
        val = sum(1 for m in p if (sol & m) == m) & 1
        if val:
            p.symmetric_difference_update({0})
        psets.append(p)

    np_cnt, off_arr, term_arr = pack_psets_to_csr(psets)
    sys_ptr = lib.cascade_create_system(n, np_cnt, off_arr, term_arr)
    fmask = (ctypes.c_uint64 * 2)(0, 0)
    fval = (ctypes.c_uint64 * 2)(0, 0)
    summ = CascadeSummary()

    rc = lib.cascade_and_probe(sys_ptr, fmask, fval, 1, 4, ctypes.byref(summ), None, 0, None)
    assert rc == 0 and summ.unsat == 0, "Selftest FAILED: false UNSAT on satisfiable system!"
    assert summ.out_rep_var[0] == 254 and summ.out_rep_phase[0] == sol0, "Selftest FAILED: missed failed literal x_0!"
    # Check Zassenhaus binary equivalence x_4 -> x_3 ^ rel34
    assert summ.out_rep_var[4] == 3 and summ.out_rep_phase[4] == rel34, "Selftest FAILED: missed Zassenhaus merge!"

    # Also verify that fixing x_0 = bad0 immediately returns UNSAT = 1!
    fmask_bad = (ctypes.c_uint64 * 2)(1, 0)
    fval_bad = (ctypes.c_uint64 * 2)(bad0, 0)
    rc_bad = lib.cascade_and_probe(sys_ptr, fmask_bad, fval_bad, 0, 0, ctypes.byref(summ), None, 0, None)
    assert rc_bad == 1 and summ.unsat == 1, "Selftest FAILED: missed direct UNSAT!"
    lib.cascade_free_system(sys_ptr)
    print("[SELFTEST OK] Zero-Trust verification of Cascade + Probing + Zassenhaus passed!", flush=True)


def build_cell_basis_110(c99_val: int, c57_val: int, c113_val: int):
    """
    Pure 110-variable basis for symmetric cells (c57 == c113):
      - Fixes c115 = 0, c99 = c99_val, c57 = c57_val, c113 = c113_val (4 short orbits)
      - Eliminates c0 via L = c99_val (T20) -> 111 vars
      - Eliminates 1 var via C5 (K = c57_val) -> N = 110 vars!
      (Note: for B1_00 where c99=1, c57=0, C_0xf parity gives K = 1 != c57 = 0 -> immediate 1 = 0!)
    """
    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    origin = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
    cb111 = []
    for j in free111:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        cb111.append(c)

    k_mask = sum(1 << j for j in K_INDICES)
    k_const = (origin & k_mask).bit_count() & 1
    piv_i = next(i for i, c in enumerate(cb111) if (c & k_mask).bit_count() & 1)
    c_piv = cb111[piv_i]
    origin_110 = origin ^ (c_piv if (k_const ^ c57_val) else 0)
    cb_110 = [c ^ (c_piv if ((c & k_mask).bit_count() & 1) else 0) for i, c in enumerate(cb111) if i != piv_i]
    assert len(cb_110) == 110
    return origin_110, cb_110


def select_vertex_cover_branch_vars(psets_deg2, n: int, k_max: int = 24):
    """Greedy maximum-degree vertex cover ordering on the quadratic co-occurrence graph G_2."""
    adj_wt = [[0] * n for _ in range(n)]
    deg = [0] * n
    for pset in psets_deg2:
        for m in pset:
            if m.bit_count() == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                adj_wt[i][j] += 1
                adj_wt[j][i] += 1
                deg[i] += 1
                deg[j] += 1
    chosen = []
    used = [False] * n
    cur_deg = list(deg)
    for _ in range(min(k_max, n)):
        best_v = max((v for v in range(n) if not used[v]), key=lambda v: cur_deg[v])
        used[best_v] = True
        chosen.append(best_v)
        for u in range(n):
            if not used[u] and adj_wt[best_v][u]:
                cur_deg[u] -= adj_wt[best_v][u]
    return chosen


def extract_all_pivots_for_cell(c99_val: int, c57_val: int, lib_audit, precomp):
    """Extracts the full ~6,400 to ~12,600 degree <= 3 pivot basis in N = 110 variables."""
    orbits, v6_list, pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, orb_tts = precomp
    origin, cb = build_cell_basis_110(c99_val, c57_val, c57_val)
    n = 110

    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64

    col3_base = (ctypes.c_int * (n * n))()
    col3_list = []
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            for k in range(j + 1, n):
                col3_list.append((1 << i) | (1 << j) | (1 << k))
            cur3 += (n - 1 - j)
    pair2_col, pair2_list = {}, []
    for i in range(n):
        for j in range(i + 1, n):
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + len(pair2_list)
            pair2_list.append(m)

    O_diag, O_pair, O_r4 = 0, 0, 0
    for j in range(116):
        if (origin >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
            O_r4 ^= orb_r4[j]
    cb_pair, cb_r4 = [], []
    for cdir in cb:
        vp, vr = 0, 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
                vr ^= orb_r4[j]
        cb_pair.append(vp)
        cb_r4.append(vr)

    mask64 = (1 << 64) - 1
    all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
    for i in range(n):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
        cur_row += 1

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                out.symmetric_difference_update({a | b})
        return out

    def insert_pset(pset):
        if not pset or cur_row >= max_rows - 2:
            return -1
        base = cur_row * n_col_words
        row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
        ctypes.memset(row_ptr, 0, n_col_words * 8)
        for m in pset:
            d = m.bit_count()
            if d == 0:
                c = off0
            elif d == 1:
                c = off1 + (m.bit_length() - 1)
            elif d == 2:
                c = pair2_col[m]
            else:
                b0 = (m & -m).bit_length() - 1
                m1 = m ^ (1 << b0)
                b1 = (m1 & -m1).bit_length() - 1
                b2 = (m1 ^ (1 << b1)).bit_length() - 1
                c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        return pc

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    # 1. Exact C_{0xf} parity (wt_orb(C_{0xf}) == 128 => even! Immediately refutes B1_00!)
    c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_parity[j])
    p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
    if (origin & c0xf_mask).bit_count() & 1:
        p_0xf.add(0)
    insert_pset(p_0xf)
    drain_xl()

    # 2. Q4 (C4)
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        return [i for i, c in enumerate(cb) if (c & mask).bit_count() & 1], (origin & mask).bit_count() & 1

    def poly_from_lin(idxs, cst):
        p = {1 << i for i in idxs}
        if cst:
            p.add(0)
        return p

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
    pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
    for Ir, Jr in pairs_ij:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
    insert_pset(q4)
    drain_xl()

    # 3. Dual Fibers F_z (exact in c99=0; Krawtchouk nullspace in c57=1)
    if c99_val == 0 and piv_row_idx[off0] < 0:
        _, u8_size8, nonzero_z = build_c8_orbits()
        M_mod2_rows = []
        for z_rep, _ in nonzero_z:
            m_bits = 0
            for m, (_, a_orb) in enumerate(u8_size8):
                s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
                if (s_val // 2) & 1:
                    m_bits |= 1 << m
            M_mod2_rows.append(m_bits)
        null_z_vecs = gf2_nullspace_left(M_mod2_rows)

        def eval_x_form(x_pt):
            orb_vec = 0
            for j in range(116):
                if (orb_tts[j][x_pt >> 6] >> (x_pt & 63)) & 1:
                    orb_vec |= 1 << j
            o_bit = (origin & orb_vec).bit_count() & 1
            w_mask = 0
            for i, cdir in enumerate(cb):
                if (cdir & orb_vec).bit_count() & 1:
                    w_mask |= 1 << i
            return w_mask, o_bit

        if c57_val == 0:
            for z_rep, _ in nonzero_z:
                gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
                reps = fiber_orbit_reps(z_rep, gstep)
                forms = [eval_x_form(x) for x in reps]
                w_xor, o_xor = 0, 0
                for wm, ob in forms:
                    w_xor ^= wm
                    o_xor ^= ob
                lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
                if o_xor:
                    lin_p.add(0)
                insert_pset(lin_p)
                if not lin_p:
                    target_e2 = ((len(forms) // 2) // 2) & 1
                    q_fib = extract_sym2_poly([wm for wm, _ in forms], [ob for _, ob in forms], n)
                    if target_e2:
                        q_fib ^= {0}
                    insert_pset(q_fib)
                drain_xl()
        else:
            pair_forms_35 = [[eval_x_form(x) for x in fiber_orbit_reps(z_rep, 8)] for z_rep, _ in nonzero_z]
            for u_vec in null_z_vecs:
                w_xor, o_xor = 0, 0
                for z_i in range(len(nonzero_z)):
                    if (u_vec >> z_i) & 1:
                        for wm, ob in pair_forms_35[z_i]:
                            w_xor ^= wm
                            o_xor ^= ob
                lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
                if o_xor:
                    lin_p.add(0)
                insert_pset(lin_p)
            drain_xl()

    # 4. V6 x V6 + Diagonal shifts + Level-1 diag%8==4 + Corrected diag_div8_parity
    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)
        dmask = sum(1 << v for v in diag_pts)
        wt_diag = (O_diag & dmask).bit_count()

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            base_m = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib_audit.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            for m in range(MAX_CHARS):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib_audit.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        if lib_audit.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        ) != 0:
            return
        record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for pm in range(MAX_C_PAIRS):
            if lin_valid[pm] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for m in range(MAX_CHARS):
            if quad_valid[m] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        drain_xl()

    t_ext = time.perf_counter()
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0:
            break
        process_coset([v | (w << 8) for v in pts8 for w in pts8])

    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or (time.perf_counter() - t_ext) > 18.0 or cur_row >= max_rows - 150:
            break
        pts_set = set(pts8)
        coset_reps8, covered = [0], set(pts8)
        for cand in range(1, 256):
            if cand not in covered:
                coset_reps8.append(cand)
                covered |= {cand ^ p for p in pts_set}
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        for a0 in coset_reps8:
            a16 = a0 | (a0 << 8)
            if a0 != 0:
                process_coset([x ^ a16 for x in w_pts])
            process_coset([interleave16(x ^ a16) for x in w_pts])

    # 5. Add rot^4 mod-32 (dim 12) & mod-16 (dim 11) pivots
    rng = random.Random(20260707 + 10 * c99_val + c57_val)
    seen_w = set()
    for trial in range(700):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - t_ext) > 28.0:
            break
        codim = 4 if (trial % 3 != 2) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None or tuple(wp_basis) in seen_w:
            continue
        seen_w.add(tuple(wp_basis))
        W_pts = span_set(nullspace_basis(wp_basis))
        diag_mask, r4_indices, picked_r4 = 0, [], set()
        for x in W_pts:
            if (x & 0xFF) == (x >> 8):
                diag_mask |= 1 << (x & 0xFF)
            else:
                ri = rep_of_x[x]
                if ri not in picked_r4:
                    picked_r4.add(ri)
                    r4_indices.append(ri)
        d0 = (O_diag & diag_mask).bit_count()
        if d0 % 4 != 0:
            continue
        sub_cb = [sum((1 << idx) for idx, ri in enumerate(r4_indices) if (vr >> ri) & 1) for vr in cb_r4]
        for use_chi in (0, 1):
            src_O = O_r4 ^ (chi_r4 if use_chi else 0)
            sub_O = sum((1 << idx) for idx, ri in enumerate(r4_indices) if (src_O >> ri) & 1)
            P2, Q4_p, _ = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
            if P2 is not None:
                insert_pset(P2)
                if codim == 4 and Q4_p is not None and max((m.bit_count() for m in Q4_p), default=0) <= 3:
                    insert_pset(Q4_p)
                drain_xl()

    all_psets, deg2_psets = [], []
    if piv_row_idx[off0] < 0:
        for r_idx in range(cur_row):
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            all_psets.append(pset)
            if max((m.bit_count() for m in pset), default=0) <= 2:
                deg2_psets.append(pset)
    return (piv_row_idx[off0] >= 0), deg_pivs, all_psets, deg2_psets


def main():
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    lib_cascade = compile_cascade_lib(work_dir)
    selftest_cascade_engine(lib_cascade)

    # Compile extraction helper from AUDIT_ALL_CELLS_111
    c_audit = work_dir / "b25_audit_helper.c"
    so_audit = work_dir / "libb25_audit_helper.so"
    c_audit.write_text(C_SRC_AUDIT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_audit), "-o", str(so_audit)], check=True)
    lib_audit = ctypes.CDLL(str(so_audit))
    lib_audit.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_audit.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_audit.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_audit.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_audit.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_audit.gf2_echelon_insert.restype = ctypes.c_int

    # Shared precomputations
    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
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
        for y in (x, rot16(x, 4), rot16(x, 8), rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    orb_tts = [[0] * 1024 for _ in range(116)]
    for j, orb in enumerate(orbits):
        vd, vp, vr = 0, 0, 0
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[j][x >> 6] ^= 1 << (x & 63)
        for v in range(256):
            x = v | (v << 8)
            if (orb_tts[j][x >> 6] >> (x & 63)) & 1:
                vd |= 1 << v
        for k, x in enumerate(all_pairs):
            if (orb_tts[j][x >> 6] >> (x & 63)) & 1:
                vp |= 1 << k
        for k, x in enumerate(rot4_reps):
            if (orb_tts[j][x >> 6] >> (x & 63)) & 1:
                vr |= 1 << k
        orb_diag[j], orb_pair[j], orb_r4[j] = vd, vp, vr
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    coset_0xf_reps, vis16 = [], bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = rot16(cur)
        if len(mem) == 16 and ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF:
            coset_0xf_reps.append(mem[0])
    orb_0xf_parity = [sum(((orb_tts[j][x >> 6] >> (x & 63)) & 1) for x in coset_0xf_reps) & 1 for j in range(116)]
    precomp = (orbits, v6_list, pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, orb_tts)

    cell_map = {"B1_00": (1, 0), "B1_11": (1, 1), "B0_11": (0, 1), "B0_00": (0, 0)}
    requested = sys.argv[1:] if len(sys.argv) > 1 else ["B1_00", "B1_11", "B0_11", "B0_00"]

    report = {}
    for cname in requested:
        c99_val, c57_val = cell_map[cname]
        tc = time.perf_counter()
        has_one_ext, deg_pivs, all_psets, deg2_psets = extract_all_pivots_for_cell(c99_val, c57_val, lib_audit, precomp)
        if has_one_ext:
            report[cname] = {
                "N_input": 110,
                "closed_at_extraction_root": True,
                "deg_pivs": deg_pivs,
                "sec": round(time.perf_counter() - tc, 3),
            }
            print(f"[{cname}] CLOSED AT EXTRACTION ROOT (1=0)! {report[cname]}", flush=True)
            continue

        np_cnt, off_arr, term_arr = pack_psets_to_csr(all_psets)
        sys_ptr = lib_cascade.cascade_create_system(110, np_cnt, off_arr, term_arr)

        # 1. Global Root Probing (BEFORE splitting into cubes!)
        t_pr = time.perf_counter()
        fmask0 = (ctypes.c_uint64 * 2)(0, 0)
        fval0 = (ctypes.c_uint64 * 2)(0, 0)
        root_sum = CascadeSummary()
        rc_root = lib_cascade.cascade_and_probe(sys_ptr, fmask0, fval0, 1, 8, ctypes.byref(root_sum), None, 0, None)
        probe_sec = round(time.perf_counter() - t_pr, 3)

        cell_res = {
            "N_input": 110,
            "input_pivots": len(all_psets),
            "input_deg_pivs": deg_pivs,
            "root_probing": {
                "unsat_closed_at_root": bool(rc_root != 0),
                "probe_sec": probe_sec,
                "probe_rounds": root_sum.probe_rounds,
                "units_fixed_globally": root_sum.final_fixed,
                "binary_merges_found": root_sum.final_bin_merges,
                "extra_kary_lin_pivs": root_sum.final_lin_pivs,
                "quad_pivs_after_probe": root_sum.final_quad_pivs,
                "free_vars_remaining_before_cubes": 0 if rc_root else root_sum.free_vars_remaining,
                "total_vars_eliminated_before_cubes": 110 if rc_root else (110 - root_sum.free_vars_remaining),
            },
            "in_cube_benchmarks": {},
        }

        # 2. If root survived, benchmark In-Cube Degree-Drop Cascade at k in {8, 12, 16, 20}!
        if rc_root == 0:
            # Start from globally deduced root units!
            base_m0, base_m1, base_v0, base_v1 = 0, 0, 0, 0
            free_pool = []
            for v in range(110):
                if root_sum.out_rep_var[v] == 254:
                    if v < 64:
                        base_m0 |= 1 << v
                        if root_sum.out_rep_phase[v]:
                            base_v0 |= 1 << v
                    else:
                        base_m1 |= 1 << (v - 64)
                        if root_sum.out_rep_phase[v]:
                            base_v1 |= 1 << (v - 64)
                elif root_sum.out_rep_var[v] == v:
                    free_pool.append(v)

            vc_order = [v for v in select_vertex_cover_branch_vars(deg2_psets, 110, 110) if v in set(free_pool)]
            rng_c = random.Random(202625 + 10 * c99_val + c57_val)

            for k_depth in (8, 12, 16, 20):
                if k_depth > len(vc_order):
                    continue
                branch_vars = vc_order[:k_depth]
                n_sample = 256 if k_depth == 8 else 512
                c_masks = (ctypes.c_uint64 * (n_sample * 2))()
                c_vals = (ctypes.c_uint64 * (n_sample * 2))()

                for s_idx in range(n_sample):
                    bits = s_idx if k_depth == 8 else rng_c.getrandbits(k_depth)
                    m0, m1, v0, v1 = base_m0, base_m1, base_v0, base_v1
                    for b_pos, var_id in enumerate(branch_vars):
                        bit = (bits >> b_pos) & 1
                        if var_id < 64:
                            m0 |= 1 << var_id
                            if bit:
                                v0 |= 1 << var_id
                        else:
                            m1 |= 1 << (var_id - 64)
                            if bit:
                                v1 |= 1 << (var_id - 64)
                    c_masks[2 * s_idx], c_masks[2 * s_idx + 1] = m0, m1
                    c_vals[2 * s_idx], c_vals[2 * s_idx + 1] = v0, v1

                for do_in_probe, tag in [(0, f"k{k_depth}_cascade_only"), (1, f"k{k_depth}_cascade_plus_probe")]:
                    if do_in_probe and k_depth not in (12, 16):
                        continue
                    nb = 128 if do_in_probe else n_sample
                    out_u = (ctypes.c_uint8 * nb)()
                    out_rem = (ctypes.c_int * nb)()
                    tb = time.perf_counter()
                    u_cnt = lib_cascade.cascade_batch_cubes(
                        sys_ptr, nb, c_masks, c_vals, do_in_probe, out_u, out_rem
                    )
                    dt = time.perf_counter() - tb
                    surv_rems = [out_rem[i] for i in range(nb) if not out_u[i]]
                    cell_res["in_cube_benchmarks"][tag] = {
                        "cubes_tested": nb,
                        "unsat_cubes": u_cnt,
                        "unsat_pct": round(100.0 * u_cnt / nb, 2),
                        "surviving_min_vars": min(surv_rems) if surv_rems else 0,
                        "surviving_avg_vars": round(sum(surv_rems) / len(surv_rems), 2) if surv_rems else 0.0,
                        "ms_per_cube_wall": round(1000.0 * dt / nb, 3),
                    }

        lib_cascade.cascade_free_system(sys_ptr)
        cell_res["total_cell_sec"] = round(time.perf_counter() - tc, 3)
        report[cname] = cell_res
        print(f"[{cname}] {json.dumps(cell_res, indent=2)}", flush=True)

    print("=== FINAL B25 CASCADE & ALGEBRAIC PROBING REPORT ===", flush=True)
    print(json.dumps({"cells": report, "total_sec": round(time.perf_counter() - t0, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()
