"""Structure of the parity-even homogeneous polars (all N_d even), from h12_flags.npy (code = combination of the 21
homogeneous polar basis vectors).  Linear span, closure, maximal subspaces (greedy), and the equations that hold on it."""
import os, itertools, collections
import numpy as np

here = os.path.dirname(os.path.abspath(__file__))
flags = np.load(os.path.join(here, "h12_flags.npy"))
n = 21


def rank_and_basis(vecs):
    piv = {}
    for v in vecs:
        x = int(v)
        while x and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x:
            piv[x.bit_length() - 1] = x
    return len(piv), piv


for name, mask in (("even", (flags & 4) != 0), ("even & pass8", (flags & 6) == 6), ("even & pass8 & Pf4", flags == 7)):
    S = np.flatnonzero(mask)
    Sset = set(S.tolist())
    r, _ = rank_and_basis(S)
    # linear equations vanishing on S (annihilator of the span): dimension n - r
    zero_in = 0 in Sset
    samp = S[:300].tolist()
    closed = sum(1 for a, b in itertools.combinations(samp, 2) if (a ^ b) in Sset)
    print("%-20s size %6d | span dim %2d | contains 0: %s | sample sums inside: %d/%d" % (
        name, len(S), r, zero_in, closed, len(samp) * (len(samp) - 1) // 2))
# the even set: is it a union of cosets of a common subspace (stabilizer)?
S = set(np.flatnonzero((flags & 4) != 0).tolist())
base = min(S)
cand = [x ^ base for x in S]
stab = [v for v in cand if v and all((y ^ v) in S for y in itertools.islice(iter(S), 2000))]
stab = [v for v in stab if all((y ^ v) in S for y in S)]
r, _ = rank_and_basis(stab)
print("even set: stabilizer (translations preserving it) dimension:", r, "-> cosets:", len(S) >> r if r else len(S))
