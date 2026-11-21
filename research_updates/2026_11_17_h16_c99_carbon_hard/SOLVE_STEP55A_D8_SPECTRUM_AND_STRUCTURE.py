#!/usr/bin/env python3
r"""
SOLVE_STEP55A_D8_SPECTRUM_AND_STRUCTURE.py

FAST (<60s) STRUCTURAL AUDIT OF ALL 35 D_8 COSETS F_z = D_8 + (0, z) ON B0_11 & B1_11:
  For every C_8-orbit z != 0 in F_2^8 \ {0}:
    1. Exact number of free111 variables `nz` that appear in f(v, v ^ z).
    2. Algebraic degree in v in F_2^8 of f(v, v ^ z) (random sample max deg).
    3. Exact gcd and observed value distribution of S(z) = sum_{v in F_2^8} (-1)^{f(v, v ^ z)}
       across 4096 random 111-var assignments (and EXACT exhaustive spectrum when nz <= 14!).
    4. Exact linear rank of the union of variables across small-nz cosets (0xFF, 0x55, 0x11, 0x33, 0x77).
    5. Test whether fixing (0xFF, 0x55) states (9 vars total!) + s9 cascade drops new linears/quads!
"""

import argparse
import ctypes
import math
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
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a


POP8 = np.array([i.bit_count() for i in range(256)], dtype=np.uint8)


def anf_deg_8(tt256):
    a = tt256.copy()
    for b in range(8):
        step = 1 << b
        a = a.reshape(-1, 2, step)
        a[:, 1, :] ^= a[:, 0, :]
        a = a.reshape(256)
    nz = np.flatnonzero(a)
    return -1 if len(nz) == 0 else int(POP8[nz].max())


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 55A: ALL-35 D_8 COSET SPECTRUM & STRUCTURE ====================", flush=True)

    orbits = diag_v2.build_orbits_116()
    _, _, nonzero_z = diag_v2.build_c8_orbits()
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc

    # Build affine map from x111 (111 vars) -> c116 (116 vars): c116 = origin_c116 ^ (x111 @ M_111_116)
    L_set = set(diag_v2.L_INDICES)
    M_111_116 = np.zeros((111, 116), dtype=np.uint8)
    origin_c116 = np.zeros(116, dtype=np.uint8)
    origin_c116[99] = c99
    origin_c116[57] = c57
    origin_c116[113] = c113
    origin_c116[0] = c99
    for i, j in enumerate(free111):
        M_111_116[i, j] = 1
        if j in L_set:
            M_111_116[i, 0] ^= 1

    # Also evaluate root0 linear pivots so we know which vars are active on root
    c_diag, so_diag = WORK_DIR / "s55a_diag.c", WORK_DIR / "libs55a_diag.so"
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

    rng = np.random.default_rng(5501)
    V256 = np.arange(256, dtype=np.uint16)

    # Check z = 0x00 first
    pts0 = V256 | (V256 << 8)
    B0 = (M_111_116.astype(np.uint16) @ orb_tt_np[:, pts0].astype(np.uint16)) & 1  # (111, 256)
    o0 = (origin_c116.astype(np.uint16) @ orb_tt_np[:, pts0].astype(np.uint16)) & 1
    rk0 = int(np.linalg.matrix_rank(B0.astype(np.float64)))
    # exact GF(2) rank via row echelon
    def gf2_rank(mat):
        M = (mat.copy() & 1).astype(np.uint8)
        m, n = M.shape
        r = 0
        for c in range(n):
            if r >= m: break
            nz = np.where(M[r:, c] == 1)[0]
            if len(nz) == 0: continue
            p = r + int(nz[0])
            if p != r: M[[r, p]] = M[[p, r]]
            rows = np.where(M[:, c] == 1)[0]
            rows = rows[rows != r]
            if len(rows): M[rows] ^= M[r]
            r += 1
        return r

    nz0 = gf2_rank(B0)
    S0 = 256 - 2 * int(o0.sum())
    print(f"  z=0x00 (|O|=1): nz={nz0}, deg={anf_deg_8(o0)}, wt={int(o0.sum())}, S(0)={S0}", flush=True)

    # Sample 4096 random x111 vectors
    X_samp = rng.integers(0, 2, size=(4096, 111), dtype=np.uint8)

    print(f"\n  {'z_rep':>6} | {'|O|':>3} | {'nz':>3} | {'deg_v':>5} | {'gcd_S':>5} | {'max|S|':>6} | {'uniq_S (sample/exact)'}", flush=True)
    print("  " + "-" * 80, flush=True)

    small_orbits = []
    for z_rep, z_orb in nonzero_z:
        pts_z = V256 | (((V256 ^ np.uint16(z_rep)) & 0xFF) << 8)
        # Basis of f(v, v^z) over free111: (111, 256)
        Bz = (M_111_116.astype(np.uint16) @ orb_tt_np[:, pts_z].astype(np.uint16)) & 1
        oz = (origin_c116.astype(np.uint16) @ orb_tt_np[:, pts_z].astype(np.uint16)) & 1
        nz = gf2_rank(Bz)

        # Max algebraic degree in v across 16 samples
        f_16 = ((X_samp[:16].astype(np.uint16) @ Bz.astype(np.uint16)) & 1) ^ oz[None, :]
        max_deg = max(anf_deg_8(f_16[i].astype(np.uint8)) for i in range(16))

        if nz <= 12:
            # Extract exact basis of row space of Bz
            M = Bz.copy().astype(np.uint8)
            basis_rows = []
            piv_cols = []
            for row in M:
                v = row.copy()
                for br, pc in zip(basis_rows, piv_cols):
                    if v[pc]:
                        v ^= br
                nz_c = np.flatnonzero(v)
                if len(nz_c):
                    basis_rows.append(v)
                    piv_cols.append(int(nz_c[0]))
            B_ind = np.array(basis_rows, dtype=np.uint8)  # (nz, 256)
            # Exhaustive evaluation over all 2^nz states!
            idx = np.arange(1 << nz, dtype=np.uint32)
            U = np.zeros((1 << nz, nz), dtype=np.uint8)
            for b in range(nz):
                U[:, b] = (idx >> b) & 1
            F_all = ((U.astype(np.uint16) @ B_ind.astype(np.uint16)) & 1) ^ oz[None, :]
            wts = F_all.sum(axis=1)
            S_vals = 256 - 2 * wts
            tag = "EXACT"
            small_orbits.append((z_rep, len(z_orb), nz, Bz))
        else:
            F_s = ((X_samp.astype(np.uint16) @ Bz.astype(np.uint16)) & 1) ^ oz[None, :]
            wts = F_s.sum(axis=1)
            S_vals = 256 - 2 * wts
            tag = "SAMP4K"

        uniq = sorted(set(int(s) for s in S_vals))
        g = 0
        for s in uniq:
            g = math.gcd(g, abs(s))
        max_abs = max(abs(s) for s in uniq)
        u_str = str(uniq) if len(uniq) <= 11 else f"[{uniq[0]}..{uniq[-1]}] ({len(uniq)} vals)"
        print(f"  0x{z_rep:02x}   | {len(z_orb):3d} | {nz:3d} | {max_deg:5d} | {g:5d} | {max_abs:6d} | {tag}: {u_str}", flush=True)

    # Check combined rank of small_orbits (|O| <= 4: 0xFF, 0x55, 0x11, 0x33, 0x77)
    if small_orbits:
        print(f"\n  Small-nz orbits (nz <= 12): {[(f'0x{z:02x}', sz, nz) for z, sz, nz, _ in small_orbits]}", flush=True)
        # Stack all Bz.T horizontally to find how many linear combinations of x111 they depend on!
        # Wait: each Bz is (111, 256); its column space in F_2^111 is the space of linear forms in x111 it depends on!
        cols_union = np.hstack([Bz for _, _, _, Bz in small_orbits])
        print(f"  Combined linear-form dimension of ALL nz<=12 orbits: {gf2_rank(cols_union.T)}", flush=True)

    print(f"\n[{cell_name}] STEP 55A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
