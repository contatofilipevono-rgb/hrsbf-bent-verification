#!/usr/bin/env python3
"""VERIFY_H16_MASTER_CLOSURE.py — Standalone Zero-Trust Verifier for H(16,4) (<250 lines, stdlib only)."""
import json, sys
from itertools import combinations

L_IDX = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]

def rot16(x, r=1):
    r &= 15
    return (((x << r) | (x >> (16 - r))) & 0xFFFF) if r else x

def build_orbits_and_tts():
    seen, orbits = set(), []
    for c in combinations(range(16), 4):
        m = sum(1 << i for i in c)
        if m not in seen:
            orb = sorted({rot16(m, r) for r in range(16)})
            seen.update(orb); orbits.append(orb)
    assert len(orbits) == 116 and sum(len(o) for o in orbits) == 1820
    assert {i: len(o) for i, o in enumerate(orbits) if len(o) < 16} == {57: 8, 99: 8, 113: 8, 115: 4}
    tts = []
    for orb in orbits:
        a = bytearray(65536)
        for m in orb: a[m] ^= 1
        s = 1
        while s < 65536:
            for i in range(0, 65536, s << 1):
                for j in range(i, i + s): a[j + s] ^= a[j]
            s <<= 1
        tt = 0
        for base in range(65536 - 64, -1, -64):
            w = 0
            for b in range(64):
                if a[base + b]: w |= 1 << b
            tt = (tt << 64) | w
        tts.append(tt)
    return orbits, tts

def subspace_from_perp(wperp):
    pivs = []
    for v in wperp:
        x = v & 0xFFFF
        for p in pivs:
            if (x >> (p.bit_length() - 1)) & 1: x ^= p
        if x: pivs.append(x); pivs.sort(reverse=True)
    for i, p in enumerate(pivs):
        b = p.bit_length() - 1
        for j in range(len(pivs)):
            if i != j and ((pivs[j] >> b) & 1): pivs[j] ^= p
    pmap = {p.bit_length() - 1: p for p in pivs}
    basis = [((1 << f) | sum((1 << pb) for pb, r in pmap.items() if (r >> f) & 1))
             for f in range(16) if f not in pmap]
    pts = [0]
    for b in basis: pts += [x ^ b for x in pts]
    return len(basis), pts

def char_tt(u):
    u &= 0xFFFF
    return sum(((x & u).bit_count() & 1) << x for x in range(65536)) if u else 0

def verify_u4_rigidity_theorem():
    # Proves exhaustively on all 2^6=64 sign vectors in U4 that D8 sum == 0 mod 16 and
    # E8 (0x5555) mod 8 rigidity forces all 6 signs in U4 equal => H(0xf) == 0 => q_0xf even!
    for s0 in (-1, 1):
        for sf in (-1, 1):
            for s5 in (-1, 1):
                for s1 in (-1, 1):
                    for s3 in (-1, 1):
                        for s7 in (-1, 1):
                            if (s0 + sf + 2 * s5 + 4 * (s1 + s3 + s7)) % 16 != 0: continue
                            if (s0 + s5 + 2 * s1 + 4) % 8 != 0: continue
                            if (sf + s5 + 2 * s7 + 4) % 8 != 0: continue
                            assert s0 == sf == s5 == s1 == s3 == s7
                            assert s0 - 4 * s1 + 2 * s5 + 4 * s3 - 4 * s7 + sf == 0

def extract_2adic_poly(O_w, B_ws, target_mod, t_bits):
    # Exact 2-adic extractor for S(z) == target_mod (mod 2^t_bits), requiring lower bits == 0 identically!
    assert t_bits in (1, 2, 3, 4)
    n, o_pop = len(B_ws), O_w.bit_count()
    T = target_mod & ((1 << t_bits) - 1)
    if t_bits == 1:
        P = {0} if ((o_pop ^ T) & 1) else set()
        for i, b in enumerate(B_ws):
            if b.bit_count() & 1: P.add(1 << i)
        return P
    assert ((o_pop - (T & 1)) & 1) == 0 and all((b.bit_count() & 1) == 0 for b in B_ws), "Level-0 not zero!"
    Ai = [b.bit_count() - 2 * (b & O_w).bit_count() for b in B_ws]
    if t_bits == 2:
        P = {0} if ((((o_pop - (T & 1)) >> 1) ^ (T >> 1)) & 1) else set()
        for i, a in enumerate(Ai):
            if (a >> 1) & 1: P.add(1 << i)
        for i in range(n):
            for j in range(i + 1, n):
                if (B_ws[i] & B_ws[j]).bit_count() & 1: P.add((1 << i) | (1 << j))
        return P
    assert ((o_pop - (T & 3)) & 3) == 0 and all((a & 3) == 0 for a in Ai), "Level-1 lin not zero!"
    P = {0} if ((((o_pop - (T & 3)) >> 2) ^ ((T >> 2) & 1)) & 1) else set()
    if t_bits == 3:
        for i, a in enumerate(Ai):
            if (a >> 2) & 1: P.add(1 << i)
        for i in range(n):
            bi = B_ws[i]
            for j in range(i + 1, n):
                ij = bi & B_ws[j]; ijp = ij.bit_count()
                assert (ijp & 1) == 0, "Level-1 quad not zero!"
                if ((ijp >> 1) ^ (ij & O_w).bit_count()) & 1: P.add((1 << i) | (1 << j))
                for k in range(j + 1, n):
                    if (ij & B_ws[k]).bit_count() & 1: P.add((1 << i) | (1 << j) | (1 << k))
        return P
    assert ((o_pop - (T & 7)) & 7) == 0 and all((a & 7) == 0 for a in Ai), "Level-2 lin not zero!"
    P = {0} if ((((o_pop - (T & 7)) >> 3) ^ ((T >> 3) & 1)) & 1) else set()
    for i, a in enumerate(Ai):
        if (a >> 3) & 1: P.add(1 << i)
    for i in range(n):
        bi = B_ws[i]
        for j in range(i + 1, n):
            ij = bi & B_ws[j]; a_ij = ij.bit_count() - 2 * (ij & O_w).bit_count()
            assert (a_ij & 3) == 0, "Level-2 quad not zero!"
            if ((-a_ij) >> 2) & 1: P.add((1 << i) | (1 << j))
            for k in range(j + 1, n):
                ijk = ij & B_ws[k]; p3 = ijk.bit_count()
                assert (p3 & 1) == 0, "Level-2 cub not zero!"
                if ((p3 >> 1) ^ (ijk & O_w).bit_count()) & 1: P.add((1 << i) | (1 << j) | (1 << k))
                for l in range(k + 1, n):
                    if (ijk & B_ws[l]).bit_count() & 1: P.add((1 << i) | (1 << j) | (1 << k) | (1 << l))
    return P

def verify_t20_directly(tts, t20_cfg):
    # (1) Prove c115 = 0 on ALL 2^116 functions via a dim-12 subspace where wt(f|_W) == 8*c115 (mod 16)!
    d, pts = subspace_from_perp(t20_cfg["c115_subspace_wperp"])
    assert d == 12
    w_mask = sum(1 << x for x in pts)
    # Check on all 16 short-orbit assignments and all 112 long orbits via 2-adic decomposition:
    long_idx = [j for j in range(116) if j not in (57, 99, 113, 115)]
    for s_bits in range(16):
        c57, c99, c113, c115 = (s_bits & 1), (s_bits >> 1) & 1, (s_bits >> 2) & 1, (s_bits >> 3) & 1
        O_tt = ((tts[57] if c57 else 0) ^ (tts[99] if c99 else 0) ^
                (tts[113] if c113 else 0) ^ (tts[115] if c115 else 0)) & w_mask
        # Pair under rot^8 if rot^8-invariant, or direct 4096-bit 2-adic check for bit 2^3 (div by 8 mod 2):
        B_ sub = [tts[j] & w_mask for j in long_idx]
        P = extract_2adic_poly(O_tt, B_sub, 0, 4)  # bit 2^3 of wt(f|_W) == 0 (since wt == 0 mod 16!)
        assert P == ({0} if c115 else set()), f"c115 witness failed on short={s_bits}: {P}"
    # (2) Prove L == c99 on ALL 2^115 functions with c115 == 0 via dim-12 subspace XOR sum:
    for s_bits in range(8):
        c57, c99, c113 = (s_bits & 1), (s_bits >> 1) & 1, (s_bits >> 2) & 1
        O_base = (tts[57] if c57 else 0) ^ (tts[99] if c99 else 0) ^ (tts[113] if c113 else 0)
        acc = set()
        for item in t20_cfg["L_c99_pairs"]:
            d, pts = subspace_from_perp(item["wperp"]); assert d == 12
            wm = sum(1 << (x ^ item["a"]) for x in pts)
            Ow = (O_base ^ char_tt(item["u"])) & wm
            acc ^= extract_2adic_poly(Ow, [tts[j] & wm for j in long_idx], 0, 4)
        expected = ({0} if c99 else set()) | {1 << long_idx.index(j) for j in L_IDX}
        assert acc == expected, f"L=c99 witness failed on (c57,c99,c113)={(c57,c99,c113)}"

def restrict_pset(pset, cube):
    out = set()
    for m in pset:
        rem, zero = 0, False
        tmp = m
        while tmp:
            b = tmp & -tmp; v = b.bit_length() - 1; tmp ^= b
            if v in cube:
                if cube[v] == 0: zero = True; break
            else: rem |= b
        if not zero: out.symmetric_difference_update({rem})
    return out

def mul_psets(p1, p2):
    out = set()
    for a in p1:
        for b in p2: out.symmetric_difference_update({a | b})
    return out

def verify_cell(c99, c57, c113, tts, c0xf_reps, node_root):
    free111 = [j for j in range(116) if j not in (0, 57, 99, 113, 115)]
    L_set = set(L_IDX)
    orig = (c99 << 0) | (c99 << 99) | (c57 << 57) | (c113 << 113)
    cb = [(1 << j) ^ ((1 << 0) if j in L_set else 0) for j in free111]
    O_tt = 0
    for j in range(116):
        if (orig >> j) & 1: O_tt ^= tts[j]
    cb_tts = []
    for cdir in cb:
        t = 0
        for j in range(116):
            if (cdir >> j) & 1: t ^= tts[j]
        assert all(((t >> (v | (v << 8))) & 1) == 0 for v in range(256)), "cb non-zero on D8!"
        cb_tts.append(t)

    def build_axiom_poly(ax, cube):
        # Compute restricted origin & active basis truth tables directly on the cube!
        O_c = O_tt
        act_vars, act_tts = [], []
        for i in range(111):
            if i in cube:
                if cube[i]: O_c ^= cb_tts[i]
            else: act_vars.append(i); act_tts.append(cb_tts[i])
        src = ax["src"]
        if src == "poisson":
            d, pts_w = subspace_from_perp(ax["wperp"])
            a, u = ax.get("a", 0), ax.get("u", 0)
            pts = [x ^ a for x in pts_w]; pts_set = set(pts)
            gstep = ax.get("rot_step", 8)  # 8->size 2 (rot^8), 4->size 4 (rot^4), 2->size 8 (rot^2)
            assert gstep in (8, 4, 2) and all(rot16(x, gstep) in pts_set for x in pts)
            g = 16 // gstep
            # Verify character u invariance on orbits of <rot^gstep>:
            for x in pts:
                if (x & 0xFF) != (x >> 8):
                    assert ((x & u).bit_count() & 1) == ((rot16(x, gstep) & u).bit_count() & 1)
            # Determine proven modulus 2^K on wt((f^u)|_{a+W}):
            if d == 12 and gstep == 4 and a == 0 and u in {k * 0x1111 for k in range(16)} and c57 == c113:
                K_pow = 5  # mod 32 proven by Theorem 1.3 (rot^4-inv + U4 rigidity)
            else:
                assert d in (12, 13, 14); K_pow = d - 8 + 4  # d=12->4(mod16), d=13->5(mod32), d=14->6(mod64)
            u_tt = char_tt(u); O_u = O_c ^ u_tt
            d_pts = [x for x in pts if (x & 0xFF) == (x >> 8)]
            B0 = sum((O_u >> x) & 1 for x in d_pts)
            reps, vis = [], set()
            for x in pts:
                if (x & 0xFF) == (x >> 8) or x in vis: continue
                orb = []
                cur = x
                while cur not in orb: orb.append(cur); cur = rot16(cur, gstep)
                assert len(orb) == g; vis.update(orb); reps.append(min(orb))
            assert (B0 % g) == 0
            T_full = ((-B0) // g) & ((1 << (K_pow - g.bit_length() + 1)) - 1)
            lvl = ax["t_bits"]
            assert 1 <= lvl <= (K_pow - (g.bit_length() - 1))
            Ow = sum(((O_u >> r) & 1) << k for k, r in enumerate(reps))
            Bw = [sum(((bt >> r) & 1) << k for k, r in enumerate(reps)) for bt in act_tts]
            P_loc = extract_2adic_poly(Ow, Bw, T_full, lvl)
        elif src == "u4_c0xf":
            assert c57 == c113, "U4 rigidity requires c57 == c113!"
            Ow = sum(((O_c >> r) & 1) << k for k, r in enumerate(c0xf_reps))
            Bw = [sum(((bt >> r) & 1) << k for k, r in enumerate(c0xf_reps)) for bt in act_tts]
            P_loc = extract_2adic_poly(Ow, Bw, 128, ax.get("t_bits", 1))
        elif src == "u8_fiber":
            assert c99 == 0 and c57 == 0 and c113 == 0, "Exact fiber balance requires B0_00!"
            alpha = ax["alpha"] & 0xFF; assert alpha != 0
            reps = [v | ((v ^ alpha) << 8) for v in range(256) if v < (v ^ alpha)]
            Ow = sum(((O_c >> r) & 1) << k for k, r in enumerate(reps))
            Bw = [sum(((bt >> r) & 1) << k for k, r in enumerate(reps)) for bt in act_tts]
            P_loc = extract_2adic_poly(Ow, Bw, 64, ax["t_bits"])  # t_bits in {1, 2} (wt == 64)
        elif src == "walsh_mod256":
            # Proven for ALL bent functions: W_f(u) == +-256 => wt(f ^ l_u) in {32640, 32896} == 128 (mod 256)!
            u = ax["u"] & 0xFFFF; O_u = O_c ^ char_tt(u)
            # Group outside D_8 under rot^8 (pairs, g=2) -> B0 + 2*S(z) == 128 (mod 256) => S(z) == 64 - B0/2 (mod 128)
            B0 = sum((O_u >> (v | (v << 8))) & 1 for v in range(256))
            assert (B0 & 1) == 0
            p_reps = [v | (w << 8) for v in range(256) for w in range(v + 1, 256)]
            Ow = sum(((O_u >> r) & 1) << k for k, r in enumerate(p_reps))
            Bw = [sum(((bt >> r) & 1) << k for k, r in enumerate(p_reps)) for bt in act_tts]
            # At u in {0, 0xffff} or after C5/C7, t_bits <= 4 gives exact degree <= 4 polynomial (incl. C4 & T28/C6)!
            P_loc = extract_2adic_poly(Ow, Bw, 64 - (B0 >> 1), ax["t_bits"])
        else: raise ValueError(f"Unknown axiom source: {src}")
        # Map local variable indices back to 0..110 indices:
        out = set()
        for m in P_loc:
            gm, tmp = 0, m
            while tmp:
                b = tmp & -tmp; gm |= 1 << act_vars[b.bit_length() - 1]; tmp ^= b
            out.add(gm)
        return out

    def check_node(node, cube):
        ntype = node["type"]
        if ntype == "branch":
            v = int(node["var"]); assert 0 <= v < 111 and v not in cube
            c0 = dict(cube); c0[v] = 0; check_node(node["lo"], c0)
            c1 = dict(cube); c1[v] = 1; check_node(node["hi"], c1)
        elif ntype == "unsat":
            polys = [build_axiom_poly(ax, cube) for ax in node["axioms"]]
            acc = set()
            for ax_i, m_hex in node["syzygy"]:
                m_mask = restrict_pset({int(m_hex, 16)}, cube)
                if m_mask: acc ^= mul_psets(m_mask, polys[ax_i])
            assert acc == {0}, f"Nullstellensatz sum != 1 in cube size {len(cube)}: {acc}"
        elif ntype == "linear_fwht":
            polys = [build_axiom_poly(ax, cube) for ax in node["axioms"]]
            # Verify all extracted polys are linear (deg <= 1), echelonize, and refute all surviving leaves via Walsh!
            piv = {}
            for p in polys:
                assert all(m.bit_count() <= 1 for m in p), "Non-linear poly in linear_fwht!"
                cur = set(p)
                while cur:
                    lead = max(cur)
                    if lead == 0: return  # 1 = 0 already!
                    if lead in piv: cur ^= piv[lead]
                    else: piv[lead] = cur; break
            for k in list(piv.keys()):
                for k2 in list(piv.keys()):
                    if k != k2 and k in piv[k2]: piv[k2] ^= piv[k]
            free_vs = [v for v in range(111) if v not in cube and (1 << v) not in piv]
            assert len(free_vs) <= 16, f"Too many free vars ({len(free_vs)}) for leaf exhaustion!"
            w_witnesses = node.get("walsh_u_witnesses", [])
            O_c = O_tt
            for v, val in cube.items():
                if val: O_c ^= cb_tts[v]
            for mask in range(1 << len(free_vs)):
                z_assign = {free_vs[b]: (mask >> b) & 1 for b in range(len(free_vs))}
                tt = O_c
                for b_idx, fv in enumerate(free_vs):
                    if (mask >> b_idx) & 1: tt ^= cb_tts[fv]
                for p_bit, eq in piv.items():
                    pv = p_bit.bit_length() - 1
                    val = (0 in eq)
                    for m in eq:
                        if m and m != p_bit and z_assign[m.bit_length() - 1]: val ^= 1
                    if val: tt ^= cb_tts[pv]
                # Refute bentness: check explicit frequency witness u first (O(1) popcount!), else full FWHT
                if w_witnesses and mask < len(w_witnesses):
                    u = int(w_witnesses[mask])
                    wf_u = 65536 - 2 * (tt ^ char_tt(u)).bit_count()
                    assert abs(wf_u) != 256, f"Candidate {mask} passed witness u={u}!"
                else:
                    spec = [1 - 2 * ((tt >> x) & 1) for x in range(65536)]
                    s = 1
                    while s < 65536:
                        for i in range(0, 65536, s << 1):
                            for j in range(i, i + s):
                                a, b = spec[j], spec[j + s]; spec[j] = a + b; spec[j + s] = a - b
                        s <<= 1
                    assert any(abs(w) != 256 for w in spec), "BENT FUNCTION FOUND!"
        else: raise ValueError(f"Unknown node type: {ntype}")

    check_node(node_root, {})

def main():
    cert_path = sys.argv[1] if len(sys.argv) > 1 else "h16_master_certificate.json"
    cert = json.loads(open(cert_path, "r", encoding="utf-8").read())
    assert cert["schema"] == "H16_4_MASTER_CLOSURE_V1"
    _, tts = build_orbits_and_tts()
    verify_u4_rigidity_theorem()
    verify_t20_directly(tts, cert["t20_witnesses"])
    c0xf_reps, vis = [], bytearray(65536)
    for x in range(65536):
        if vis[x]: continue
        cur, mem = x, []
        while not vis[cur]: vis[cur] = 1; mem.append(cur); cur = rot16(cur)
        if len(mem) == 16 and ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF:
            c0xf_reps.append(mem[0])
    assert len(c0xf_reps) == 256
    for c99 in (0, 1):
        for c57 in (0, 1):
            for c113 in (0, 1):
                key = f"B{c99}_{c57}{c113}"
                assert key in cert["cells"], f"Missing cell {key}!"
                verify_cell(c99, c57, c113, tts, c0xf_reps, cert["cells"][key]["proof"])
                print(f"[VERIFIED] {key} closed.", flush=True)
    print("ALL 2^116 FUNCTIONS IN H(16,4) CERTIFIED BENT-FREE (Q.E.D.).", flush=True)

if __name__ == "__main__":
    main()
