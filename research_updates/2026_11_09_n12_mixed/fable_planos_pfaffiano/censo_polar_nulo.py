"""Zero polar: count of bent functions = (#bijective lambda in Lambda) * 2^(dim h-kernel).

Every function with zero polar is f(z,w) = lambda(z).w + h(z).  Maiorana-McFarland:
  W_f(u,b) = 64 * sum_{z : lambda(z) = b} (-1)^{h(z) + u.z};  by Parseval over u, |W| = 64 for all (u,b) iff every
  fibre lambda^{-1}(b) has exactly one point, i.e. lambda is a bijection (independently of h).
The phase -> lambda map is linear with image Lambda (dim 31) and kernel of dimension 12 (h only), so the count is
#{bijective lambda in Lambda} * 2^12.  The census runs over all 2^31 lambda: lambda is bijective iff every one of
the 63 nonzero combinations of its output coordinates is balanced (weight 32 on F2^6).
Usage: python censo_polar_nulo.py [--shard i/n]"""
import os, sys, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np


def basis_tables():
    from bitj import load_model
    from cert_arvore import polar_data
    from poisson3_lista import todos_subespacos3
    T0, K = polar_data("0", load_model(), todos_subespacos3())
    words = []
    for k in K:
        lam = [(k[:, 1 << i] ^ k[:, 0]).astype(np.uint64) for i in range(6)]
        words.append([int(sum(int(b) << z for z, b in enumerate(l))) for l in lam])
    # row-reduce to a basis of Lambda (as 6-word vectors); kernel size = 2^(43 - rank)
    basis = []
    piv = {}
    for wv in words:
        key = sum(w << (64 * i) for i, w in enumerate(wv))
        x = key
        while x and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x:
            piv[x.bit_length() - 1] = x
    for x in piv.values():
        basis.append([(x >> (64 * i)) & ((1 << 64) - 1) for i in range(6)])
    return basis, len(K) - len(basis)


def count(basis, si=0, sm=1, low_bits=20):
    d = len(basis)
    B = np.array(basis, dtype=np.uint64)                   # d x 6
    low = np.zeros((1 << low_bits, 6), dtype=np.uint64)
    for j in range(low_bits):
        low[1 << j:2 << j] = low[:1 << j] ^ B[j]
    hi = d - low_bits
    total = 0
    for c in range(1 << hi):
        if c % sm != si:
            continue
        base = np.zeros(6, dtype=np.uint64)
        for j in range(hi):
            if c >> j & 1:
                base ^= B[low_bits + j]
        T = low ^ base
        alive = np.ones(len(T), dtype=bool)
        comb = [None] * 64
        comb[0] = np.zeros(len(T), dtype=np.uint64)
        for a in range(1, 64):
            lb = (a & -a).bit_length() - 1
            comb[a] = comb[a ^ (1 << lb)] ^ T[:, lb]
            alive &= np.bitwise_count(comb[a]) == 32
        total += int(alive.sum())
    return total


if __name__ == "__main__":
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    t0 = time.time()
    basis, kern = basis_tables()
    print("dim Lambda", len(basis), "| h-kernel", kern, flush=True)
    n = count(basis, si, sm)
    print("shard", si, "/", sm, ": bijective lambda", n, round(time.time() - t0, 1), "s", flush=True)
    if sm == 1:
        print("zero-polar bent functions:", n << kern)
