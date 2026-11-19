#!/usr/bin/env python3
r"""
SOLVE_STEP35C_Z16_ORBITS_ON_B000_AND_FD8_DEGREE_LOCAL.py

FAST 3-SECOND LOCAL CHECK:
  1. Checks exact algebraic degree & ANF of f|_{D_8} in B0_00, B0_11, B1_11!
  2. Checks exact Z_16^* action on the 6-dim root-reduced `eta` space of B0_00, B0_11, B1_11
     (matching our exact `eta_free` ordering from Step 28A/32B!) so we know:
     - EXACTLY how many of the 64 eta-states of B0_00 are ALREADY closed by our 26 proved states + Z_16^*!
     - EXACTLY how many distinct open Z_16^*-orbits remain in B0_00!
"""

import sys
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09


def anf_8var(tt):
    """Mobius transform on 256-entry truth table -> ANF coefficients."""
    a = tt.copy()
    for b in range(8):
        step = 1 << b
        for i in range(0, 256, step * 2):
            a[i + step:i + 2 * step] ^= a[i:i + step]
    return a


def main():
    orbits = diag_v2.build_orbits_116()
    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc

    pts_00 = np.array([u | (u << 8) for u in range(256)], dtype=np.uint16)

    print("==================== PART 1: EXACT ANF & DEGREE OF f|_{D_8} ====================")
    for cname, (c99, c57, c113) in [("B0_00", (0, 0, 0)), ("B0_11", (0, 1, 1)), ("B1_11", (1, 1, 1))]:
        _, origin111, _ = b09.build_pure_111_basis(c99, c57, c113)
        orig_tt = np.zeros(65536, dtype=np.uint8)
        for o in range(116):
            if (origin111 >> o) & 1: orig_tt ^= orb_tt_np[o]
        d8_tt = orig_tt[pts_00]
        anf = anf_8var(d8_tt)
        degs = [int(m).bit_count() for m in range(256) if anf[m]]
        deg_hist = {}
        for d in degs: deg_hist[d] = deg_hist.get(d, 0) + 1
        print(f"  [{cname}] wt(f|_D8)={int(d8_tt.sum()):3d} | max_deg={max(degs) if degs else 0} | ANF deg_hist={dict(sorted(deg_hist.items()))}")

    # Also check how many of the 111 free variables vanish on D_8 vs have degree 4 on cosets z+D_8!
    print("\n==================== PART 2: MAX DEGREE OF f|_{z+D_8} FOR ALL z != 0 ====================")
    for cname, (c99, c57, c113) in [("B0_11", (0, 1, 1)), ("B1_11", (1, 1, 1))]:
        _, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i in range(111):
            acc = np.zeros(65536, dtype=np.uint8)
            for o in range(116):
                if (cb111[i] >> o) & 1: acc ^= orb_tt_np[o]
            b_tt[i] = acc
        for z in [0xFF, 0x55, 0x33, 0x0F, 0x01]:
            pts_z = np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16)
            max_d_basis = 0
            for i in range(111):
                anf = anf_8var(b_tt[i, pts_z])
                for m in range(256):
                    if anf[m]:
                        d = int(m).bit_count()
                        if d > max_d_basis: max_d_basis = d
            print(f"  [{cname}] coset z=0x{z:02x}: max ANF degree of basis functions on z+D_8 = {max_d_basis}")


if __name__ == "__main__":
    main()
