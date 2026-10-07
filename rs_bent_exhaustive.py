#!/usr/bin/env python3
"""
Exhaustive search of rotation-symmetric Boolean functions of degree <= 3.

Usage:
    python rs_bent_exhaustive.py N [CHUNK_LOG2]

Constant and the unique RS linear term are omitted because adding either
preserves bentness. Reported bent counts should therefore be multiplied by 4
to include those affine choices.
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
    ap.add_argument('n', type=int)
    ap.add_argument('chunk_log2', type=int, nargs='?', default=12)
    ap.add_argument('--backend', choices=['auto', 'numpy', 'cuda'], default='auto')
    ap.add_argument('--output-dir', type=Path, default=Path('.'))
    ap.add_argument('--resume', action='store_true')
    ap.add_argument('--max-chunks', type=int, help='stop early with exit 3; useful for checkpoint validation')
    args = ap.parse_args()
    n, chunk_log2 = args.n, args.chunk_log2
    if n < 2 or n % 2 or n > 12:
        ap.error('supported dimensions are positive even n from 2 through 12')
    if not 0 <= chunk_log2 <= 16:
        ap.error('chunk_log2 must be between 0 and 16')
    if args.max_chunks is not None and args.max_chunks < 1:
        ap.error('max-chunks must be positive')
    if args.backend == 'cuda' and not USE_TORCH:
        ap.error('CUDA requested but unavailable; refusing silent CPU fallback')
    use_torch = USE_TORCH and args.backend != 'numpy'
    if use_torch:
        torch.backends.cuda.matmul.allow_tf32 = False
        torch.set_float32_matmul_precision('highest')
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
        f"n={n} backend={'torch-cuda' if use_torch else 'numpy'} "
        f"quad_orbits={nq} cubic_orbits={len(c)} functions={1<<k} (2^{k})",
        flush=True,
    )

    G = np.array([truth_table(n, o) for o in gens], dtype=np.float32)
    if use_torch:
        Gd = torch.tensor(G, device=DEV)

    bits = np.arange(k, dtype=np.int64)
    tot = bent = bent_noP = bent_hom = survivors = 0
    bent_ids = []
    CH = 1 << chunk_log2
    t0 = time.time()
    args.output_dir.mkdir(parents=True, exist_ok=True)
    checkpoint = args.output_dir / f'checkpoint_n{n}.json'
    source_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    begin = 0
    if args.resume and checkpoint.exists():
        saved = json.loads(checkpoint.read_text())
        if saved.get('source_sha256') != source_hash or saved.get('n') != n:
            raise ValueError('checkpoint source or dimension mismatch')
        begin = saved['next_index']
        tot, survivors = saved['tested'], saved['survivors']
        bent_ids = saved['bent_ids']
        bent, bent_noP, bent_hom = len(bent_ids), saved['bent_without_Pn'], saved['homogeneous_cubic_bent']
        if not 0 <= begin <= 1 << k or tot != begin:
            raise ValueError('invalid checkpoint coverage')
        print(f'resuming_at={begin}', flush=True)

    for batch_number, start in enumerate(range(begin, 1 << k, CH), 1):
        idx = np.arange(start, min(start + CH, 1 << k), dtype=np.int64)
        C = ((idx[:, None] >> bits) & 1).astype(np.float32)

        if use_torch:
            Ct = torch.tensor(C, device=DEV)
            F = (Ct @ Gd).remainder_(2).to(torch.int32)
            # x -> x + J is x -> bitwise complement, i.e. reverse truth-table index.
            bal = ((F ^ F.flip(1)).sum(1) == N // 2)
            S = F[bal]
            idx_s = torch.tensor(idx, device=DEV)[bal]
            W = 1 - 2 * S
            h = 1
            while W.shape[0] and h < N:
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
            row = (int(i) >> bits) & 1
            if row[ant] == 0:
                bent_noP += 1
            if row[:nq].sum() == 0 and row[nq:].sum() > 0:
                bent_hom += 1

        end = min(start + CH, 1 << k)
        stop_early = args.max_chunks is not None and batch_number >= args.max_chunks
        if batch_number == 1 or batch_number % 64 == 0 or end == 1 << k or stop_early:
            saved = {'n': n, 'source_sha256': source_hash, 'next_index': end,
                     'tested': tot, 'survivors': survivors, 'bent_ids': bent_ids,
                     'bent_without_Pn': bent_noP, 'homogeneous_cubic_bent': bent_hom}
            temporary = checkpoint.with_suffix('.tmp')
            temporary.write_text(json.dumps(saved)+'\n')
            temporary.replace(checkpoint)
            elapsed = time.time() - t0
            print(
                f"progress={min(start+CH,1<<k)}/{1<<k} "
                f"survivors={survivors} bent={bent} elapsed={elapsed:.1f}s",
                flush=True,
            )
        if stop_early:
            break

    dt = time.time() - t0
    print(
        f"tested={tot} passed_DJ_filter={survivors} bent={bent} "
        f"bent_without_Pn={bent_noP} homogeneous_cubic_bent={bent_hom} "
        f"time={dt:.1f}s"
    )
    print(f"total_with_constant_and_RS_linear={4*bent}")

    args.output_dir.mkdir(parents=True, exist_ok=True)
    ids_path = args.output_dir / f"bent_ids_n{n}.npy"
    np.save(ids_path, np.array(bent_ids, dtype=np.int64))

    complete = tot == 1 << k
    ok = bent_noP == 0 and bent_hom == 0
    report = {
        'n': n, 'backend': 'torch-cuda' if use_torch else 'numpy',
        'complete': tot == 1 << k, 'tested': tot, 'expected': 1 << k,
        'quadratic_orbits': nq, 'cubic_orbits': len(c),
        'generator_orbits': gens, 'antipodal_generator_index': ant,
        'chunk_log2': chunk_log2, 'passed_DJ_filter': survivors,
        'bent_affine_representatives': bent, 'bent_including_RS_affine': 4*bent,
        'bent_without_Pn': bent_noP, 'homogeneous_cubic_bent': bent_hom,
        'elapsed_seconds': dt, 'numpy_version': np.__version__,
        'torch_version': torch.__version__ if use_torch else None,
        'gpu': torch.cuda.get_device_name(0) if use_torch else None,
        'source_sha256': source_hash,
        'ids_sha256': hashlib.sha256(ids_path.read_bytes()).hexdigest(),
        'status': 'counterexample_candidate' if not ok else ('consistent' if complete else 'incomplete'),
        'scope': 'Finite exhaustive computational control; not a proof for all dimensions.'
    }
    (args.output_dir / f'result_n{n}.json').write_text(json.dumps(report, indent=2)+'\n')
    print(
        "ANTIPODAL_RULE_AND_CUBIC_HOMOGENEOUS_NONEXISTENCE:",
        "COUNTEREXAMPLE_CANDIDATE" if not ok else ("CONSISTENT" if complete else "INCOMPLETE"),
    )
    return 2 if not ok else (0 if complete else 3)

if __name__ == "__main__":
    sys.exit(main())
