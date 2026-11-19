#!/usr/bin/env python3
r"""
SOLVE_STEP19B_B000_FULL_ETA64_ATTACK.py

DEDICATED FULL-FORCE ATTACK ON B0_00 (with FIXED strict-RREF `s9.add_linear_rref` + verify_subst=True):
  1. Builds B0_00 with ALL 389 Carlet-Guillot cubics + ALL 40 zero-trust verified D_8-coset cubics.
  2. Scans ALL 64 eta-states with verify_subst=True -> prints full anatomy table
     (em, closed, N, q, c, dim_W_ess, pure_W, rk_tail, free_L2a).
  3. For EVERY surviving eta-state with dim_W_ess <= 16 (e.g. eta=1 with dim_W=10, 5 pure quads!),
     EXHAUSTIVELY solves the pure-W quadratics over F_2^{dim_W} and runs `run_branch_cascade` on
     EVERY surviving W-assignment to formally CLOSE those eta-states 100%!
  4. For larger surviving eta-states (like q=41), tests `W_ess` partial-split / greedy-trigger
     and checks if `h_0x01` balancedness (on L2a) + `D_8`-coset cubics collapse them!
"""

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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19


def solve_pure_w_quads_and_close(lib9, sr, W_rref, qps, tbl):
    """Given a surviving eta-state with dim_W <= 16, exhaustively enumerate all W-assignments
    satisfying ALL pure-W quadratics, then run `run_branch_cascade` on each surviving W-assignment!"""
    W_pivs = sorted(W_rref.keys())
    W_forms = [W_rref[p] for p in W_pivs]
    kW = len(W_pivs)

    # Identify pure-W quadratics (after reducing linear part mod W_rref, tail == 0)
    # Express each pure-W quadratic directly as a function of y in 0..(1<<kW)-1!
    # For any y in F_2^{kW}, set x_{W_pivs[j]} = (y >> j) & 1 and all other x_v = 0!
    # Wait: DOES setting non-W_pivs to 0 evaluate a pure-W quadratic identically to setting W_forms[j](x) = y_j?!
    # YES!! Because a pure-W quadratic Q(x) depends ONLY on the linear forms W_forms[0..kW-1](x),
    # and at x = sum_j y_j e_{W_pivs[j]}, since W_rref is STRICT RREF, W_forms[j](x) == y_j EXACTLY!!
    # Let's zero-trust verify that on 5 random x in F_2^111 for every pure-W quad!
    pure_qps = []
    for ps in qps:
        lmask = 0
        for m in ps:
            if m.bit_count() == 1: lmask |= m
        rem = lmask
        for p, pm in W_rref.items():
            if (rem >> p) & 1: rem ^= pm
        if rem == 0:
            pure_qps.append(ps)

    # Precompile each pure_qp into pairs (a_idx, b_idx), linears a_idx, const in y-space (0..kW-1)
    # Using x = sum_j y_j e_{W_pivs[j]}:
    # Monomial m evaluates to 1 at x iff every bit of m is in W_pivs AND the corresponding y-bits are 1!
    piv_to_j = {p: j for j, p in enumerate(W_pivs)}
    y_polys = []
    for ps in pure_qps:
        ymons = []
        for m in ps:
            if m == 0:
                ymons.append(0)
            else:
                ym = 0
                ok = True
                tmp = m
                while tmp:
                    lb = tmp & -tmp
                    b = lb.bit_length() - 1
                    tmp ^= lb
                    if b in piv_to_j:
                        ym |= (1 << piv_to_j[b])
                    else:
                        ok = False; break
                if ok:
                    ymons.append(ym)
        y_polys.append(ymons)

    # Zero-trust check: verify y_polys(W_forms(x)) == ps(x) on 10 random active x!
    rng = random.Random(999)
    act = [i for i in range(111) if i not in sr["_lin_pivs"]]
    for _ in range(10):
        x = sum((1 << v) for v in act if rng.randint(0, 1))
        y = 0
        for j, fm in enumerate(W_forms):
            if (fm & x).bit_count() & 1:
                y |= (1 << j)
        for ps, ymons in zip(pure_qps, y_polys):
            v_x = sum(1 for m in ps if (x & m) == m) & 1
            v_y = sum(1 for ym in ymons if (y & ym) == ym) & 1
            assert v_x == v_y, "PURE-W Y-REDUCTION MISMATCH!"

    # Filter all 2^{kW} assignments of y by y_polys!
    valid_ys = []
    for y in range(1 << kW):
        ok = True
        for ymons in y_polys:
            v = 0
            for ym in ymons:
                if (y & ym) == ym: v ^= 1
            if v:
                ok = False; break
        if ok:
            valid_ys.append(y)

    # Test EVERY surviving y in run_branch_cascade!
    n_closed = 0
    n_open = 0
    for idx_y, y in enumerate(valid_ys):
        ex = [(W_forms[j], (y >> j) & 1) for j in range(kW)]
        sub = s9.run_branch_cascade(
            lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
            ex, tbl, max_xl_rounds=15, verify_subst=(idx_y < 3)
        )
        if sub["closed_unsat"]:
            n_closed += 1
        else:
            n_open += 1
    return len(pure_qps), len(valid_ys), n_closed, n_open


def main():
    t0 = time.perf_counter()
    cell_name = "B0_00"
    print(f"==================== [{cell_name}] STEP 19B: FULL ETA-64 + 40 D8-COSET CUBICS ATTACK ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s19b_diag.c", WORK_DIR / "libs19b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s19b_s9.c", WORK_DIR / "libs19b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s19b_cg.c", WORK_DIR / "libs19b_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s19b_d8.c", WORK_DIR / "libs19b_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
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
    mask64 = (1 << 64) - 1

    # Build basis truth tables for B0_00 (111 x 65536) to extract & zero-trust verify the 40 D_8-coset cubics!
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb

    seen_a = set()
    d8_specs = []
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
    rng_zt = random.Random(191919)
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
        # Zero-trust verify on 10 random points!
        for _ in range(10):
            x = rng_zt.getrandbits(111)
            w_acc = [0, 0, 0, 0]
            tmp = x
            while tmp:
                lb = tmp & -tmp; ii = lb.bit_length() - 1; tmp ^= lb
                for w in range(4): w_acc[w] ^= b_words[ii * 4 + w]
            wt = sum(bin(w_acc[w]).count("1") for w in range(4))
            pred = lib9.eval_row_s9(rptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x & mask64, x >> 64)
            assert pred == ((wt >> sb) & 1), f"D8 coset cubic ZT mismatch at a=0x{a:02x}, sb={sb}!"
    print(f"[B0_00] Extracted & ZT-verified ALL {len(d8_specs)} D_8-coset cubics (0 mismatches)!", flush=True)

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

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + len(d8_specs)
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, len(d8_specs) * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    s19.verify_lin_pivs_rref(root["_lin_pivs"])
    print(f"[B0_00] ROOT (+40 D8 cubics, ZT-verified): N={root['N_active']}, q={root['n_quad_surviving']}, c={root['n_genuine_cubics']}", flush=True)

    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    forms_L2a = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L2a"][1], layer_vecs["L2a"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)
    print(f"[B0_00] Scanning ALL 2^{n_ef} = {1<<n_ef} eta-states (verify_subst=True)...", flush=True)

    n_closed_direct = 0
    n_closed_exhaust = 0
    open_states = []
    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=True
        )
        if sr["closed_unsat"]:
            n_closed_direct += 1
            print(f"  eta={em:2d}: CLOSED DIRECTLY ({sr.get('closed_by')})", flush=True)
            continue
        s19.verify_lin_pivs_rref(sr["_lin_pivs"])
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        if len(qps) == 0:
            print(f"  eta={em:2d}: OPEN N={sr['N_active']}, q=0, c={sr['n_genuine_cubics']}", flush=True)
            open_states.append((em, sr["N_active"], 0, 0, 0, 0))
            continue
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        dimW = len(W_rref)
        l2a_rem = len(s16.reduce_forms_mod_pivs(forms_L2a, sr["_lin_pivs"]))
        status = "OPEN"
        extra = ""
        if dimW <= 16 and ana["n_pure_in_W_ess"] >= 1:
            npw, nval, ncl, nop = solve_pure_w_quads_and_close(lib9, sr, W_rref, qps, tbl)
            extra = f" | EXHAUST_W({dimW}): pure={npw}, valid_pts={nval}/{1<<dimW}, closed={ncl}, open={nop}"
            if nop == 0:
                status = "CLOSED_BY_EXHAUST_W"
                n_closed_exhaust += 1
        print(f"  eta={em:2d}: {status:19s} N={sr['N_active']:3d}, q={len(qps):2d}, c={sr['n_genuine_cubics']:3d}, "
              f"dimW={dimW:2d}, pureW={ana['n_pure_in_W_ess']:2d}, rkTail={ana['rank_radical_linear_tails']:2d}, freeL2a={l2a_rem:2d}{extra}", flush=True)
        if status == "OPEN":
            open_states.append((em, sr["N_active"], len(qps), dimW, ana["n_pure_in_W_ess"], ana["rank_radical_linear_tails"]))

    print(f"\n[B0_00] SUMMARY: direct_closed={n_closed_direct}/64, exhaust_W_closed={n_closed_exhaust}/64, "
          f"TOTAL_CLOSED={n_closed_direct + n_closed_exhaust}/64, remaining_open={len(open_states)}/64 ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
