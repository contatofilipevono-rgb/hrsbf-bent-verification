#!/usr/bin/env python3
"""
Exhaustive search of homogeneous quartic (degree 4) rotation-symmetric Boolean functions in n=10.

Tests the Stanica-Maitra conjecture and antipodal necessity in degree 4 on 2^22 = 4,194,304 functions.
"""
import sys, itertools, time, argparse, json, hashlib
from pathlib import Path
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
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--n', type=int, default=10)
    ap.add_argument('--chunk-log2', type=int, default=12)
    ap.add_argument('--backend', choices=['auto', 'numpy', 'cuda'], default='auto')
    ap.add_argument('--output-dir', type=Path, default=Path('results/stage1_quartic_n10'))
    args = ap.parse_args()
    n = args.n
    chunk_log2 = args.chunk_log2
    use_torch = USE_TORCH and args.backend != 'numpy'

    if use_torch:
        torch.backends.cuda.matmul.allow_tf32 = False
        torch.set_float32_matmul_precision('highest')

    N = 1 << n
    target = 1 << (n // 2)

    gens = orbits(n, 4)
    k = len(gens)
    print(f"=== ESTÁGIO 1: Quárticas Homogêneas (Grau 4) em n={n} ===", flush=True)
    print(f"Backend: {'torch-cuda' if use_torch else 'numpy'} | Órbitas quárticas: {k} | Candidatos: 2^{k} = {1<<k}", flush=True)

    G = np.array([truth_table(n, o) for o in gens], dtype=np.float32)
    if use_torch:
        Gd = torch.tensor(G, device=DEV)

    bits = np.arange(k, dtype=np.int64)
    tot = bent = survivors = 0
    bent_ids = []
    CH = 1 << chunk_log2
    t0 = time.time()
    args.output_dir.mkdir(parents=True, exist_ok=True)

    for start in range(0, 1 << k, CH):
        idx = np.arange(start, min(start + CH, 1 << k), dtype=np.int64)
        C = ((idx[:, None] >> bits) & 1).astype(np.float32)

        if use_torch:
            Ct = torch.tensor(C, device=DEV)
            F = (Ct @ Gd).remainder_(2).to(torch.int32)
            bal = ((F ^ F.flip(1)).sum(1) == N // 2)
            S = F[bal]
            sid = torch.tensor(idx, device=DEV)[bal]
            W = 1 - 2 * S
            h = 1
            while W.shape[0] and h < N:
                W = W.view(W.shape[0], -1, 2, h)
                W = torch.stack(
                    (W[:, :, 0] + W[:, :, 1], W[:, :, 0] - W[:, :, 1]), 2
                ).view(-1, N)
                h *= 2
            isb = (W.abs() == target).all(1).cpu().numpy()
            sid = sid.cpu().numpy()
        else:
            F = ((C @ G) % 2).astype(np.int32)
            bal = ((F ^ F[:, ::-1]).sum(1) == N // 2)
            S = F[bal]
            sid = idx[bal]
            W = 1 - 2 * S
            h = 1
            while W.shape[0] and h < N:
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

    dt = time.time() - t0
    print(f"Testados: {tot}/{1<<k} | Sobreviventes D_J: {survivors} | Bent encontrados: {bent} | Tempo: {dt:.2f}s", flush=True)

    report = {
        'n': n,
        'degree': 4,
        'homogeneous': True,
        'backend': 'torch-cuda' if use_torch else 'numpy',
        'tested': tot,
        'quartic_orbits': k,
        'passed_DJ_filter': survivors,
        'homogeneous_quartic_bent': bent,
        'bent_ids': bent_ids,
        'elapsed_seconds': dt,
        'status': 'CONSISTENT_NO_BENT' if bent == 0 else 'COUNTEREXAMPLE_FOUND'
    }
    (args.output_dir / 'result_quartic_n10.json').write_text(json.dumps(report, indent=2) + '\n')
    print(f"Resultado salvo em {args.output_dir / 'result_quartic_n10.json'}")
    return 0

if __name__ == '__main__':
    sys.exit(main())
