"""Independent check of Argon's fibre-0/15 identity, by direct evaluation of the fibres (no polynomials).
E_t(code) = M(t, x0*x6) xor bit2(|P_t|);  claim on C_L3 x F_2^25:
   E_0 = E_15 = (1 ^ u24)(S(u) ^ c4) ^ u1*u24,  S = u11+u13+u16+u19+u22+u23,  c4 = bit 4 of the chart.
Also: how often do the four labels over z have 4 distinct values (D1, D2 independent)? Then |P_t| need not be 4B."""
import sys, random
from collections import Counter
REPO = sys.argv[1]
sys.path.insert(0, REPO)
from dim4_support_decode import decode
from higher_filter import xor_terms

model, basis, labels = decode(1)
S_BITS = (11, 13, 16, 19, 22, 23)
cl3 = [c for c in range(256) if all(bin(c & p).count("1") % 2 == 0 for p in (26, 60, 64))]
cat = (0, 1, 22, 23, 36, 37, 50, 51, 128, 129, 164, 165, 178, 179)
print("|CL3| =", len(cl3), " catalog charts in CL3:", all(c in cl3 for c in cat))

def E(code, t):
    labs = labels(xor_terms(basis, code))
    P = [x for x in range(256) if labs[x] == t]
    mom = sum(1 for x in P if (x & 1) and (x >> 6) & 1) & 1
    return mom ^ ((len(P) >> 2) & 1), len(P), labs

def formula(code):
    c = code >> 25; c4 = (c >> 4) & 1
    s = sum((code >> v) & 1 for v in S_BITS) & 1
    u1, u24 = (code >> 1) & 1, (code >> 24) & 1
    return ((1 ^ u24) & (s ^ c4)) ^ (u1 & u24)

rng = random.Random(2026)
for name, charts, N in (("CL3", cl3, 40), ("outside CL3", [c for c in range(256) if c not in cl3], 25)):
    bad = Counter(); dist4 = 0; nz = 0; not4 = 0; tot = 0
    for _ in range(N):
        c = rng.choice(charts)
        for _ in range(8):
            code = (c << 25) | rng.getrandbits(25)
            f = formula(code)
            for t in (0, 15):
                e, size, labs = E(code, t)
                tot += 1
                if e != f:
                    bad[t] += 1
                if size % 4:
                    not4 += 1
            for z in range(64):
                nz += 1
                if len({labs[z + 64 * s] for s in range(4)}) == 4:
                    dist4 += 1
    print(f"{name}: {tot} (map, t) pairs, mismatches with formula {dict(bad)}, |P_t| not mult. of 4: {not4}, "
          f"z with 4 distinct labels: {dist4}/{nz}")
