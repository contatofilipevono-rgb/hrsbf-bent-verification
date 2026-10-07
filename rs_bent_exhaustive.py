#!/usr/bin/env python3
"""
Exhaustive search of rotation-symmetric Boolean functions of degree <= 3.

Usage:
    python rs_bent_exhaustive.py N [CHUNK_LOG2]

Constant and the unique RS linear term are omitted because adding either
preserves bentness. Reported bent counts should therefore be multiplied by 4
to include those affine choices.
"""
import sys, itertools, time
import numpy as np

try:
    import torch
    DEV = "cuda" if torch.cuda.is_available() else None
except Exception:
    torch, DEV = None, None

USE_TORCH = DEV is not None

def orbits(n, w):
    seen, out = set(), []
    for A in itertools.combinations(range(n), w):
        if A in seen:
            continue
        o = {tuple(sorted((a + s) % n for a in A)) for s in range(n)}
        seen |= o
        out.append(sorted(o))
    return out

def truth_table(n, orb):
    xs = np.arange(1 << n, dtype=np.int64)
    f = np.zeros(1 << n, dtype=np.int64)
    for A in orb:
        m = np.ones(1 << n, dtype=np.int64)
        for a in A:
            m &= (xs >> a) & 1
        f ^= m
    return f

def main():
    n = int(sys.argv[1])
    chunk_log2 = int(sys.argv[2]) if len(sys.argv) > 2 else (16 if USE_TORCH else 12)
    N = 1 << n
    target = 1 << (n // 2)

    q, c = orbits(n, 2), orbits(n, 3)
    gens = q + c
    k = len(gens)
    nq = len(q)

    antip_candidates = [i for i, o in enumerate(q) if len(o) == n // 2]
    if len(antip_candidates) != 1:
        raise RuntimeError(f"expected exactly one antipodal quadratic orbit, got {antip_candidates}")
    ant = antip_candidates[0]

    print(
        f"n={n} backend={'torch-cuda' if USE_TORCH else 'numpy'} "
        f"quad_orbits={nq} cubic_orbits={len(c)} functions={1<<k} (2^{k})",
        flush=True,
    )

    G = np.array([truth_table(n, o) for o in gens], dtype=np.float32)
    if USE_TORCH:
        Gd = torch.tensor(G, device=DEV)

    bits = np.arange(k, dtype=np.int64)
    tot = bent = bent_noP = bent_hom = survivors = 0
    bent_ids = []
    CH = 1 << chunk_log2
    t0 = time.time()

    for start in range(0, 1 << k, CH):
        idx = np.arange(start, min(start + CH, 1 << k), dtype=np.int64)
        C = ((idx[:, None] >> bits) & 1).astype(np.float32)

        if USE_TORCH:
            Ct = torch.tensor(C, device=DEV)
            F = (Ct @ Gd).remainder_(2).to(torch.int32)
            # x -> x + J is x -> bitwise complement, i.e. reverse truth-table index.
            bal = ((F ^ F.flip(1)).sum(1) == N // 2)
            S = F[bal]
            idx_s = torch.tensor(idx, device=DEV)[bal]
            W = 1 - 2 * S
            h = 1
            while h < N:
                W = W.view(W.shape[0], -1, 2, h)
                W = torch.stack(
                    (W[:, :, 0] + W[:, :, 1], W[:, :, 0] - W[:, :, 1]), 2
                ).view(-1, N)
                h *= 2
            isb = (W.abs() == target).all(1).cpu().numpy()
            sid = idx_s.cpu().numpy()
        else:
            F = ((C @ G) % 2).astype(np.int32)
            bal = ((F ^ F[:, ::-1]).sum(1) == N // 2)
            S = F[bal]
            sid = idx[bal]
            W = 1 - 2 * S
            h = 1
            while h < N:
                W = W.reshape(W.shape[0], -1, 2, h)
                W = np.stack(
                    (W[:, :, 0] + W[:, :, 1], W[:, :, 0] - W[:, :, 1]), 2
                ).reshape(-1, N)
                h *= 2
            isb = (np.abs(W) == target).all(1)

        tot += len(idx)
        survivors += len(sid)

        for i in sid[isb]:
            bent += 1
            bent_ids.append(int(i))
            row = (int(i) >> bits) & 1
            if row[ant] == 0:
                bent_noP += 1
            if row[:nq].sum() == 0 and row[nq:].sum() > 0:
                bent_hom += 1

        if start == 0 or ((start // CH) + 1) % 64 == 0:
            elapsed = time.time() - t0
            print(
                f"progress={min(start+CH,1<<k)}/{1<<k} "
                f"survivors={survivors} bent={bent} elapsed={elapsed:.1f}s",
                flush=True,
            )

    dt = time.time() - t0
    print(
        f"tested={tot} passed_DJ_filter={survivors} bent={bent} "
        f"bent_without_Pn={bent_noP} homogeneous_cubic_bent={bent_hom} "
        f"time={dt:.1f}s"
    )
    print(f"total_with_constant_and_RS_linear={4*bent}")

    np.save(f"bent_ids_n{n}.npy", np.array(bent_ids, dtype=np.int64))

    ok = bent_noP == 0 and bent_hom == 0
    print(
        "ANTIPODAL_RULE_AND_CUBIC_HOMOGENEOUS_NONEXISTENCE:",
        "CONSISTENT" if ok else "COUNTEREXAMPLE_CANDIDATE",
    )

if __name__ == "__main__":
    main()
