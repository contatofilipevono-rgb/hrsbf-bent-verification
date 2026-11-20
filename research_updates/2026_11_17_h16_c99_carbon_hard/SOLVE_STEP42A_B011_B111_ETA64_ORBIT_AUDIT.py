#!/usr/bin/env python3
r"""
SOLVE_STEP42A_B011_B111_ETA64_ORBIT_AUDIT.py

INDEPENDENT COMPLETENESS AUDIT FOR B0_11 AND B1_11 (ALL 64 eta-STATES + EXACT Z_16^* ORBIT MAP):
  - Directly answers the completeness requirement in H16_STATUS_2026_11_20_STEPS65_72.md:
    * Tests ALL 64 `eta_free` states of B0_11 and B1_11 via s9.run_branch_cascade!
    * Computes the EXACT Z_16^* (order 8) permutation on the 64 eta-states (with exact c_0 = c_99 + sum_{L\{0}} c_j)!
    * Zero-Trust verifies 0 signature mismatches inside every Z_16^* orbit!
    * Reports exact closed/open counts, orbit decomposition, and (N, q, dimW) for EVERY distinct open orbit!
"""

import argparse
import ctypes
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
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19


def audit_cell(cell_name, lib_diag, lib9, lib_cg, orbits, layer_vecs,
               v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 42A: 64-STATE ETA COMPLETENESS AUDIT & Z_16* ORBITS ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1
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

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)
    n_states = 1 << n_ef
    print(f"  [{cell_name}] Root: N={111 - len(root['_lin_pivs'])}, q={len(root['_quad_ids'])}, cub={len(root['_cub_ids'])} | n_eta_free={n_ef} ({n_states} states)", flush=True)

    # Build exact Z_16^* action on the 2^{n_ef} eta-states!
    orb_of_mon = {m: j for j, orb in enumerate(orbits) for m in orb}
    def perm_mon(m, k):
        out = 0
        for i in range(16):
            if (m >> i) & 1: out |= (1 << ((k * i) & 15))
        return out
    perms = {k: [orb_of_mon[perm_mon(orbits[j][0], k)] for j in range(116)] for k in [1, 3, 5, 7, 9, 11, 13, 15]}
    lin_pivs = root["_lin_pivs"]

    def apply_pi_k_to_x111(x111, k):
        c = origin111
        tmp = x111
        while tmp:
            lb = tmp & -tmp; c ^= cb111[lb.bit_length() - 1]; tmp ^= lb
        p = perms[k]
        c_new = 0
        tmp = c
        while tmp:
            lb = tmp & -tmp; c_new |= (1 << p[lb.bit_length() - 1]); tmp ^= lb
        x_new = 0
        for i, j in enumerate(free111):
            if (c_new >> j) & 1: x_new |= (1 << i)
        return x_new

    def eval_eta_of_x111(x111):
        em = 0
        for j in range(n_ef):
            if (eta_free[j] & x111).bit_count() & 1:
                em |= (1 << j)
        return em

    rng = random.Random(4242)
    eta_map = {k: {} for k in perms}
    for em in range(n_states):
        piv_all = dict(lin_pivs)
        for j in range(n_ef):
            v = eta_free[j]
            rhs = (em >> j) & 1
            while v:
                b = v.bit_length() - 1
                if b in piv_all:
                    pv, pr = piv_all[b]; v ^= pv; rhs ^= pr
                else:
                    piv_all[b] = (v, rhs); break
            assert v != 0
        for b in sorted(piv_all.keys()):
            for hb in list(piv_all.keys()):
                if hb != b and ((piv_all[hb][0] >> b) & 1):
                    piv_all[hb] = (piv_all[hb][0] ^ piv_all[b][0], piv_all[hb][1] ^ piv_all[b][1])
        free_rem = [i for i in range(111) if i not in piv_all]
        pts_test = []
        for _ in range(3):
            x = 0
            for fr in free_rem:
                if rng.getrandbits(1): x |= (1 << fr)
            for b, (pv, pr) in piv_all.items():
                if pr ^ (((pv ^ (1 << b)) & x).bit_count() & 1): x |= (1 << b)
            assert eval_eta_of_x111(x) == em
            pts_test.append(x)
        for k in perms:
            imgs = set()
            for x in pts_test:
                x2 = apply_pi_k_to_x111(x, k)
                for lp, (pv, pr) in lin_pivs.items():
                    assert (((pv & x2).bit_count() & 1) == pr), f"Root lin_piv violated by k={k}!"
                imgs.add(eval_eta_of_x111(x2))
            assert len(imgs) == 1, f"eta not well-defined under k={k}: {imgs}"
            eta_map[k][em] = next(iter(imgs))

    # Run cascade on ALL n_states eta-states!
    sigs = {}
    direct_closed = set()
    for em in range(n_states):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=(em == 0)
        )
        if sr["closed_unsat"]:
            direct_closed.add(em)
            sigs[em] = ("CLOSED", 0, 0, 0)
        else:
            qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
            ana = s16.analyze_quad_system(qps)
            dimW = len(s19.strict_rref_masks(list(ana["W_piv"].values())))
            sigs[em] = ("OPEN", 111 - len(sr["_lin_pivs"]), len(sr["_quad_ids"]), dimW)

    seen_e = set()
    orbs = []
    for em in range(n_states):
        if em in seen_e: continue
        o = sorted({eta_map[k][em] for k in perms})
        seen_e |= set(o)
        orbs.append(o)
        s_set = {sigs[e] for e in o}
        assert len(s_set) == 1, f"Signature mismatch inside Z_16^* orbit {o}: {s_set}"

    open_orbs = [o for o in orbs if o[0] not in direct_closed]
    print(f"  *** [{cell_name}] ZERO-TRUST VERIFIED: {n_states} eta-states -> {len(orbs)} Z_16^*-orbits (0 mismatches!) ***", flush=True)
    print(f"  *** [{cell_name}] DIRECT CLOSED = {len(direct_closed)}/{n_states} | OPEN = {n_states - len(direct_closed)}/{n_states} in {len(open_orbs)} DISTINCT Z_16^*-ORBITS ***", flush=True)
    for idx_o, o in enumerate(orbs):
        st = sigs[o[0]]
        print(f"    Orbit {idx_o:2d} (sz={len(o)}): {str(o):24s} -> {st}", flush=True)
    print(f"[{cell_name}] STEP 42A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s42a_diag.c", WORK_DIR / "libs42a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s42a_s9.c", WORK_DIR / "libs42a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s42a_cg.c", WORK_DIR / "libs42a_cg.so"
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
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        audit_cell(
            cname, lib_diag, lib9, lib_cg, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
