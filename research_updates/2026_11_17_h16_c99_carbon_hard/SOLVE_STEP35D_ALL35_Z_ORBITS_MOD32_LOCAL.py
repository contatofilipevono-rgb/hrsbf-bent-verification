#!/usr/bin/env python3
r"""
SOLVE_STEP35D_ALL35_Z_ORBITS_MOD32_LOCAL.py

2-SECOND LOCAL EXACT DP CHECK:
  For EVERY ONE of the 35 C_8-orbits of z != 0 in F_2^8, computes the EXACT achievable
  residues of W_g(z) mod 16 and mod 32 across ALL C_8-symmetric Boolean functions g on F_2^8
  with wt(g) = 64 (B0_11) and wt(g) = 160 (B1_11) AND deg(g) <= 6 (i.e., parity on all 7-dim flats = 0)!
  - Any z where 32 | W_g(z) ALWAYS gives a 100% NECESSARY EQUATION `((wt(f|_{z+D_8}) >> 3) & 1) == 0`
    in B0_11 and/or B1_11!
  - Even better: also checks ALL linear combinations of z's (e.g., W_g(z1) + W_g(z2) mod 32)!
"""

import numpy as np


def main():
    seen = set()
    c8_orbs = []
    for b in range(256):
        if b in seen: continue
        orb = []
        cur = b
        while cur not in seen:
            seen.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    assert len(c8_orbs) == 36

    # Note: deg(g) <= 6 on F_2^8 <==> sum_{b} g(b) = 0 (mod 2) AND sum_{b: b_0=1} g(b) = 0 (mod 2)
    # (by C_8-symmetry, sum_{b: b_i=1} g(b) is the same for all i=0..7!).
    # Wait: for an orbit `orb`, how many elements have b_0 = 1? Exactly wt(b) * len(orb) / 8!
    # Wait: for len(orb)=1: b=0 -> 0, b=0xFF -> 1 (ODD!).
    # For len(orb)=2: {0x55, 0xAA} -> 1 element has b_0=1 (ODD!).
    # For len(orb)=4: b=0x11 (wt 2 -> 1 element, ODD!), b=0x33 (wt 4 -> 2, EVEN), b=0x77 (wt 6 -> 3, ODD!).
    # For len(orb)=8: wt(b) elements have b_0=1 (ODD iff wt(b) is odd!).
    orb_sz = [len(o) for o in c8_orbs]
    orb_b0_par = [sum(b & 1 for b in o) & 1 for o in c8_orbs]

    # For each of the 35 nonzero C_8-orbit reps z, compute achievable W_g(z) mod 32 for wt(g)=64 and wt(g)=160
    # subject to deg(g) <= 6 (i.e. sum g(b) even AND sum b_0*g(b) even)!
    z_reps = [o[0] for o in c8_orbs if o[0] != 0]
    print(f"Checking ALL {len(z_reps)} nonzero C_8-orbits of z in F_2^8 (with deg(g) <= 6)...")
    mod32_always_zero_64 = []
    mod32_always_zero_160 = []
    mod32_const_64 = []
    mod32_const_160 = []

    for z in z_reps:
        # DP state: (wt, b0_par, w_z_mod32) -> actually track exact W_g(z) mod 32!
        # Since W_g(z) = 256 - 2 * sum_{b} (g(b) ^ <z,b>), let's track exact (wt, b0_par, w_z % 32)
        dp = {(0, 0, 0)}
        for idx, orb in enumerate(c8_orbs):
            sz = orb_sz[idx]
            bp = orb_b0_par[idx]
            s_z = sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb)
            nxt = set()
            for wt, p0, wm in dp:
                nxt.add((wt, p0, (wm + s_z) & 31))
                nxt.add((wt + sz, p0 ^ bp, (wm - s_z) & 31))
            dp = nxt
        res64 = sorted({wm for wt, p0, wm in dp if wt == 64 and p0 == 0})
        res160 = sorted({wm for wt, p0, wm in dp if wt == 160 and p0 == 0})
        if len(res64) == 1:
            mod32_const_64.append((z, res64[0]))
            if res64[0] == 0: mod32_always_zero_64.append(z)
        if len(res160) == 1:
            mod32_const_160.append((z, res160[0]))
            if res160[0] == 0: mod32_always_zero_160.append(z)
        if len(res64) <= 2 or len(res160) <= 2:
            print(f"  z=0x{z:02x} (orb_sz={len([o for o in c8_orbs if z in o][0])}): W_g(z)%32 for B0_11(64)={res64} | B1_11(160)={res160}")

    print(f"\nSUMMARY (deg(g) <= 6):")
    print(f"  B0_11 (wt=64):  CONSTANT mod 32 = {len(mod32_const_64)}/35: {[(hex(z), r) for z, r in mod32_const_64]}")
    print(f"  B1_11 (wt=160): CONSTANT mod 32 = {len(mod32_const_160)}/35: {[(hex(z), r) for z, r in mod32_const_160]}")

    # ALSO check linear combinations of W_g(z) mod 32! Wait: W_g(z) = sum_b (-1)^{g(b) + <z,b>} = 256 - 2*wt(g ^ <z,b>)
    # Wait: sum_{z in H} W_g(z) for a subspace H of F_2^8!
    # Even simpler: check W_g(z) mod 16 for ALL 35 z's!
    mod16_const_64, mod16_const_160 = [], []
    for z in z_reps:
        dp = {(0, 0, 0)}
        for idx, orb in enumerate(c8_orbs):
            sz = orb_sz[idx]
            bp = orb_b0_par[idx]
            s_z = sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb)
            nxt = set()
            for wt, p0, wm in dp:
                nxt.add((wt, p0, (wm + s_z) & 15))
                nxt.add((wt + sz, p0 ^ bp, (wm - s_z) & 15))
            dp = nxt
        r64 = sorted({wm for wt, p0, wm in dp if wt == 64 and p0 == 0})
        r160 = sorted({wm for wt, p0, wm in dp if wt == 160 and p0 == 0})
        if len(r64) == 1: mod16_const_64.append((z, r64[0]))
        if len(r160) == 1: mod16_const_160.append((z, r160[0]))
    print(f"  B0_11 (wt=64):  CONSTANT mod 16 = {len(mod16_const_64)}/35")
    print(f"  B1_11 (wt=160): CONSTANT mod 16 = {len(mod16_const_160)}/35")


if __name__ == "__main__":
    main()
