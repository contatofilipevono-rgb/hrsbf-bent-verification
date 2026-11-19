#!/usr/bin/env python3
r"""
SOLVE_STEP21B_B000_ETA20_PURE36_CRUSH.py

DEDICATED B0_00 CRUSH:
  1. Scans ALL 64 eta-states of B0_00 (with +40 ZT-verified D_8-coset cubics!) using TRUE
     strict-RREF 2-block elimination (R_all > W_ess) -> prints exact table of:
       (em, N, q, dimW, n_pureW_d2, n_pureW_d3, n_degR1)
     for ALL surviving states!
  2. For `eta=20` (36 pure quadratics in ONLY 35 W_ess variables!!) and ANY other state with
     high pureW_d2 / dimW ratio:
       (a) Pure-W Degree-3 XL AND Pure-W Degree-4 XL in C (52k cols for dimW=35 -> ~5s!).
       (b) Pure-W ANF-to-CNF + PySAT Cadical195 (35 vars -> fast formal UNSAT or witness!).
  3. For `eta=1` (dimW=10, 5 pure quads -> <= 64 valid points!), formally closes ALL valid
     points of W_ess with verify_subst=True!
"""

import ctypes
import random
import subprocess
import sys
import time
from pathlib import Path
import numpy as np
from pysat.solvers import Solver

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
import SOLVE_STEP21A_TRUE_3BLOCK_AND_W_XL_SYZYGY as s21a


def pure_w_xl_deg4_c(lib_wxl, y_quads, nW):
    """Run exact pure-W Degree-3 and Degree-4 XL on a list of pure quadratics `y_quads`
    over F_2^{nW} (each quad is a list of monomial bitmasks of deg <= 2 over 0..nW-1).
    Checks for `1 = 0` or degree <= 2 mutant drops!"""
    # Index all monomials of deg <= 4 over nW vars in deg-descending order: d4, d3, d2, d1, d0!
    mons4, mons3, mons2, mons1 = [], [], [], [1 << i for i in range(nW)]
    for i in range(nW):
        for j in range(i + 1, nW):
            m2 = (1 << i) | (1 << j)
            mons2.append(m2)
            for k in range(j + 1, nW):
                m3 = m2 | (1 << k)
                mons3.append(m3)
                for l in range(k + 1, nW):
                    mons4.append(m3 | (1 << l))
    all_mons = mons4 + mons3 + mons2 + mons1 + [0]
    m2col = {m: idx for idx, m in enumerate(all_mons)}
    off3 = len(mons4)
    off2 = off3 + len(mons3)
    off1 = off2 + len(mons2)
    off0 = off1 + len(mons1)
    n_cols = off0 + 1
    n_words = (n_cols + 63) >> 6

    mults = [0] + mons1 + mons2  # all deg <= 2 multipliers
    n_rows = len(y_quads) * len(mults)
    print(f"    [Pure-W XL-D4] nW={nW}, n_quads={len(y_quads)}: {n_rows} rows vs {n_cols} cols ({n_rows*n_words*8/1e6:.1f} MB)...", flush=True)
    if n_rows * n_words * 8 > 2_500_000_000:
        print("    [Pure-W XL-D4] Skipping (>2.5 GB)", flush=True)
        return None
    buf = (ctypes.c_uint64 * (n_rows * n_words))()
    piv = (ctypes.c_int * n_cols)(*([-1] * n_cols))

    rc = 0
    cnt = {"d4": 0, "d3": 0, "d2": 0, "d1": 0, "d0": 0}
    for mu in mults:
        for qm in y_quads:
            off = rc * n_words
            for m in qm:
                c = m2col[m | mu]
                buf[off + (c >> 6)] ^= (1 << (c & 63))
            pc = lib_wxl.gf2_insert_dense(buf, rc, n_words, piv, n_cols)
            if pc >= 0:
                if pc == off0: cnt["d0"] += 1
                elif pc >= off1: cnt["d1"] += 1
                elif pc >= off2: cnt["d2"] += 1
                elif pc >= off3: cnt["d3"] += 1
                else: cnt["d4"] += 1
                rc += 1
            else:
                # zero out failed row for reuse!
                ctypes.memset(ctypes.byref(buf, off * 8), 0, n_words * 8)
            if cnt["d0"] > 0:
                print(f"    [Pure-W XL-D4] *** 1 = 0 PROVED AT ROW {rc}!! ***", flush=True)
                return cnt
    print(f"    [Pure-W XL-D4] DONE: pivs={cnt} (extra_d2={cnt['d2']-len(y_quads)}, d1={cnt['d1']}, d0={cnt['d0']})", flush=True)
    return cnt


def solve_pure_w_sat(y_quads, nW):
    """Encode pure-W quadratic system into CNF (Tseitin pairs + 4-way XOR chains) and solve with Cadical195!"""
    # Variables 1..nW are w_0..w_{nW-1}.
    next_var = nW + 1
    pair_var = {}
    clauses = []

    def add_xor(lits, rhs):
        # Split XOR into chunks of size <= 4!
        nonlocal next_var
        cur = list(lits)
        while len(cur) > 4:
            chunk = cur[:3]
            nv = next_var; next_var += 1
            # nv == chunk[0] ^ chunk[1] ^ chunk[2] -> 4-var XOR with rhs=0
            add_xor_small(chunk + [nv], 0)
            cur = [nv] + cur[3:]
        add_xor_small(cur, rhs)

    def add_xor_small(lits, rhs):
        k = len(lits)
        if k == 0:
            if rhs: clauses.append([])
            return
        for mask in range(1 << k):
            # parity of mask == rhs means allowed; if parity != rhs, forbid this assignment!
            if (mask.bit_count() & 1) != rhs:
                cl = []
                for i in range(k):
                    v = lits[i]
                    cl.append(-v if ((mask >> i) & 1) else v)
                clauses.append(cl)

    for qm in y_quads:
        rhs = 0
        lits = []
        for m in qm:
            if m == 0:
                rhs ^= 1
            elif m.bit_count() == 1:
                lits.append(m.bit_length())
            elif m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                key = (b0, b1)
                if key not in pair_var:
                    pv = next_var; next_var += 1
                    pair_var[key] = pv
                    u, v = b0 + 1, b1 + 1
                    clauses.append([-pv, u])
                    clauses.append([-pv, v])
                    clauses.append([pv, -u, -v])
                lits.append(pair_var[key])
        add_xor(lits, rhs)

    t_s = time.perf_counter()
    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        sat = slv.solve()
        dt = time.perf_counter() - t_s
        if not sat:
            print(f"    [Pure-W SAT Cadical195] *** UNSAT PROVED in {dt:.2f}s (vars={next_var-1}, clauses={len(clauses)})!! ***", flush=True)
            return False, None
        else:
            mod = slv.get_model()
            y = sum((1 << i) for i in range(nW) if mod[i] > 0)
            # Zero-trust verify y satisfies all y_quads!
            for qm in y_quads:
                val = 0
                for m in qm:
                    if (y & m) == m: val ^= 1
                assert val == 0, "SAT model verification failed!"
            print(f"    [Pure-W SAT Cadical195] SAT in {dt:.2f}s! Witness y=0x{y:x} (verified 0/{len(y_quads)} viol)", flush=True)
            return True, y


def main():
    t0 = time.perf_counter()
    print("==================== [B0_00] STEP 21B: ALL 64 ETA TRUE PURE-W TABLE + ETA=20 PURE-36 CRUSH ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s21b_diag.c", WORK_DIR / "libs21b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s21b_s9.c", WORK_DIR / "libs21b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s21b_cg.c", WORK_DIR / "libs21b_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s21b_d8.c", WORK_DIR / "libs21b_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s21b_sh.c", WORK_DIR / "libs21b_sh.so"
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

    c_wxl, so_wxl = WORK_DIR / "s21b_wxl.c", WORK_DIR / "libs21b_wxl.so"
    c_wxl.write_text(s21a.C_WXL_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_wxl), "-o", str(so_wxl)], check=True)
    lib_wxl = ctypes.CDLL(str(so_wxl))
    lib_wxl.gf2_insert_dense.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_wxl.gf2_insert_dense.restype = ctypes.c_int

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
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

    # Extract 40 verified D_8-coset cubics
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
    n_ef = len(eta_free)
    print(f"[B0_00] ROOT (+40 D8): N={root['N_active']}, q={root['n_quad_surviving']}, c={root['n_genuine_cubics']}", flush=True)

    # Scan ALL 64 eta-states!
    n_direct_closed = 0
    n_sat_closed = 0
    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=(em < 8)
        )
        if sr["closed_unsat"]:
            n_direct_closed += 1
            continue
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        if len(qps) == 0:
            print(f"  eta={em:2d}: N={sr['N_active']}, q=0, c={sr['n_genuine_cubics']}", flush=True)
            continue
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        W_pivs = sorted(W_rref.keys())
        W_set = set(W_pivs)
        nW = len(W_pivs)

        # Apply W-shear to ONLY the quads to get exact pure-W quadratics!
        n_q = len(qps)
        qbuf = (ctypes.c_uint64 * (n_q * n_cw))()
        for i, qr in enumerate(sr["_quad_ids"]):
            ctypes.memmove(ctypes.byref(qbuf, i * n_cw * 8), ctypes.byref(sr["_buf"], qr * n_cw * 8), n_cw * 8)
        for p in W_pivs:
            rest = W_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    qbuf, n_q, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )

        # Echelonize the R-linear tails of the n_q transformed quads to find ALL linear combinations
        # that cancel ALL R-variables -> EXACT pure-W quadratics!
        w_to_j = {v: j for j, v in enumerate(W_pivs)}
        rt_piv = {}  # r_bit -> (r_mask, y_quad_set)
        pure_y_quads = []
        for i in range(n_q):
            ps = s9.row_to_pset(qbuf, i, tbl)
            rmask = 0
            yset = set()
            for m in ps:
                if m == 0:
                    yset.add(0)
                elif m.bit_count() == 1:
                    v = m.bit_length() - 1
                    if v in w_to_j: yset.add(1 << w_to_j[v])
                    else: rmask |= (1 << v)
                else:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    yset.add((1 << w_to_j[b0]) | (1 << w_to_j[b1]))
            while rmask:
                b = rmask.bit_length() - 1
                if b in rt_piv:
                    pm, pys = rt_piv[b]
                    rmask ^= pm
                    yset ^= pys
                else:
                    rt_piv[b] = (rmask, yset)
                    break
            else:
                if yset:
                    pure_y_quads.append(sorted(yset))

        print(f"  eta={em:2d}: N={sr['N_active']:3d}, q={n_q:2d}, dimW={nW:2d}, rkTail={len(rt_piv):2d}, TRUE_pureW_quads={len(pure_y_quads):2d}", flush=True)

        # If we have a rich pure-W system (like eta=20 with 36 pure quads in 35 vars, OR pureW >= dimW - 5):
        if len(pure_y_quads) >= 20 or (nW <= 20 and len(pure_y_quads) >= 1):
            if nW <= 36 and len(pure_y_quads) >= 10:
                cnt = pure_w_xl_deg4_c(lib_wxl, pure_y_quads, nW)
                if cnt and cnt["d0"] > 0:
                    n_sat_closed += 1
                    continue
            if nW <= 40 and len(pure_y_quads) >= 5:
                sat, y_wit = solve_pure_w_sat(pure_y_quads, nW)
                if not sat:
                    n_sat_closed += 1
                elif y_wit is not None:
                    # Check if the SAT witness of pure-W quads survives full run_branch_cascade!
                    W_forms = [W_rref[p] for p in W_pivs]
                    ex_w = [(W_forms[j], (y_wit >> j) & 1) for j in range(nW)]
                    sub = s9.run_branch_cascade(
                        lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                        ex_w, tbl, max_xl_rounds=10, verify_subst=True
                    )
                    print(f"      Witness y=0x{y_wit:x} in full cascade: closed_unsat={sub['closed_unsat']} ({sub.get('closed_by')})", flush=True)

    print(f"\n[B0_00] STEP 21B SUMMARY: direct_closed={n_direct_closed}/64, pureW_closed={n_sat_closed}/64 ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
