#!/usr/bin/env python3
"""Bounded adaptive search: necessary bent conditions for odd-degree HRSBF.

NumPy CPU and optional PyTorch CUDA backends. No claim of exhaustive proof.
All CUDA GEMMs use float32, TF32 disabled, with exact integer dot products
bounded by the number of orbit coefficients. CPU audits parity independently.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path

import numpy as np


def orbit_basis(n, degree):
    unseen = set(itertools.combinations(range(n), degree))
    orbits = []
    while unseen:
        representative = min(unseen)
        orbit = sorted({tuple(sorted((i + shift) % n for i in representative))
                        for shift in range(n)})
        unseen.difference_update(orbit)
        orbits.append((representative, orbit))
    return sorted(orbits)


def make_tables(n, degree):
    orbits = orbit_basis(n, degree)
    inputs = np.arange(1 << n, dtype=np.uint32)
    basis = np.zeros((len(orbits), len(inputs)), dtype=np.uint8)
    for row, (_, orbit) in enumerate(orbits):
        for support in orbit:
            mask = sum(1 << i for i in support)
            basis[row] ^= ((inputs & mask) == mask).astype(np.uint8)
    h = n // 2
    u = np.arange(1 << h, dtype=np.uint32)
    z = u.copy()
    indices = (u[None, :] | ((u[None, :] ^ z[:, None]) << h)).astype(np.int64)
    if np.any(basis[:, indices[0]]):
        raise RuntimeError('Odd-degree diagonal cancellation failed')
    return orbits, basis, indices


class Evaluator:
    def __init__(self, basis, indices, mode):
        if len(basis) >= 2 ** 24:
            raise ValueError('Dot products exceed the exact float32 integer range')
        self.basis = basis
        self.indices = indices
        self.backend = 'numpy-cpu'
        self.gpu = None
        self.torch = None
        if mode != 'cpu':
            try:
                import torch
                if torch.cuda.is_available():
                    self.torch = torch
                    torch.backends.cuda.matmul.allow_tf32 = False
                    torch.backends.cudnn.allow_tf32 = False
                    torch.set_float32_matmul_precision('highest')
                    self.basis_gpu = torch.tensor(basis, dtype=torch.float32, device='cuda')
                    self.indices_gpu = torch.tensor(indices.reshape(-1), device='cuda')
                    self.backend = 'torch-cuda-float32-TF32-disabled'
                    self.gpu = torch.cuda.get_device_name(0)
                elif mode == 'cuda':
                    raise RuntimeError('CUDA requested but no GPU is connected')
            except ImportError:
                if mode == 'cuda':
                    raise RuntimeError('CUDA backend needs PyTorch')
        self.basis_float = basis.astype(np.float32) if self.torch is None else None

    def evaluate(self, coefficients):
        count = len(coefficients)
        hsize = self.indices.shape[0]
        if self.torch is None:
            sums = coefficients.astype(np.float32) @ self.basis_float
            tables = sums.astype(np.int32) & 1
            weights = tables[:, self.indices.reshape(-1)].reshape(count, hsize, hsize).sum(axis=2)
            derivative_weights = np.bitwise_xor(tables, tables[:, ::-1]).sum(axis=1)
        else:
            t = self.torch
            with t.no_grad():
                c = t.tensor(coefficients, dtype=t.float32, device='cuda')
                sums = c @ self.basis_gpu
                tables_gpu = sums.to(t.int32).bitwise_and(1)
                weights = tables_gpu[:, self.indices_gpu].reshape(count, hsize, hsize).sum(dim=2).cpu().numpy()
                derivative_weights = tables_gpu.bitwise_xor(tables_gpu.flip((1,))).sum(dim=1).cpu().numpy()
                # Only rows needed for CPU controls are copied below.
                tables = tables_gpu[:min(4, count)].cpu().numpy()
        # Exact integer CPU XOR validates each round's first rows independently
        # of matrix multiplication, including before and after CUDA transfer.
        for j in range(min(4, count)):
            active = self.basis[coefficients[j].astype(bool)]
            direct = np.bitwise_xor.reduce(active, axis=0) if len(active) else np.zeros(self.basis.shape[1], dtype=np.uint8)
            if not np.array_equal(tables[j], direct):
                raise RuntimeError('Backend disagrees with independent XOR evaluator')
            direct_weights = direct[self.indices].sum(axis=1)
            if not np.array_equal(weights[j], direct_weights):
                raise RuntimeError('Fiber weights disagree with CPU reconstruction')
            if int(derivative_weights[j]) != int(np.bitwise_xor(direct, direct[::-1]).sum()):
                raise RuntimeError('All-ones derivative disagrees with CPU reconstruction')
        return weights, derivative_weights


def greedy_cover(failures):
    remaining = np.ones(len(failures), dtype=bool)
    selected = []
    while remaining.any():
        counts = failures[remaining].sum(axis=0)
        best = int(counts.argmax())
        if counts[best] == 0:
            break
        selected.append({'z': best + 1, 'new_exclusions': int(counts[best])})
        remaining &= ~failures[:, best]
    return selected, int(remaining.sum())


def draw_batch(rng, width, batch, elites, round_id):
    coefficients = rng.integers(0, 2, size=(batch, width), dtype=np.uint8)
    kinds = np.zeros(batch, dtype=np.uint8)  # fresh dense / sparse / mutated
    sparse_start = batch // 2
    mutation_start = 3 * batch // 4
    coefficients[sparse_start:mutation_start] = 0
    kinds[sparse_start:mutation_start] = 1
    for row in range(sparse_start, mutation_start):
        support = rng.choice(width, size=int(rng.integers(1, min(width, 12) + 1)), replace=False)
        coefficients[row, support] = 1
    if len(elites):
        kinds[mutation_start:] = 2
        for row in range(mutation_start, batch):
            coefficients[row] = elites[int(rng.integers(len(elites)))].copy()
            flips = rng.choice(width, size=int(rng.integers(1, min(width, 8) + 1)), replace=False)
            coefficients[row, flips] ^= 1
    empty = np.flatnonzero(coefficients.sum(axis=1) == 0)
    coefficients[empty, 0] = 1
    return coefficients, kinds


def candidate_record(coefficients, weights, derivative_weight, representatives):
    bad = np.flatnonzero(weights[1:] != len(weights) // 2)
    mask = sum(int(bit) << i for i, bit in enumerate(coefficients))
    witness = None if not len(bad) else {'z': int(bad[0] + 1), 'weight': int(weights[bad[0] + 1])}
    return {'coefficient_mask': hex(mask),
            'active_orbit_representatives': [list(representatives[i]) for i in np.flatnonzero(coefficients)],
            'allones_derivative_weight': int(derivative_weight),
            'unbalanced_nonzero_fibers': int(len(bad)),
            'exclusion_witness': witness,
            'status': 'EXCLUDED_BY_FIBER' if witness else 'NECESSARY_CONDITIONS_ONLY'}


def validate_sample_cover(folder, draws=8192, seed=90420261006, backend='cpu'):
    """New dense holdout; test learned cover and inspect its survivors."""
    folder = Path(folder)
    summary = json.loads((folder / 'summary.json').read_text())
    n, degree = summary['config']['n'], summary['config']['degree']
    orbits, basis, indices = make_tables(n, degree)
    cover = [record['z'] for record in summary['global_sample_cover']]
    if not cover:
        return {'status': 'NO_LEARNED_COVER'}
    rng = np.random.default_rng(seed)
    coefficients = rng.integers(0, 2, (draws, len(basis)), dtype=np.uint8)
    # This short cover evaluates only the selected fibers; all products are
    # exact integer values <= number of generators in float32.
    selected_basis = basis[:, indices[cover].reshape(-1)].astype(np.float32)
    weights = ((coefficients.astype(np.float32) @ selected_basis).astype(np.int32) & 1)
    weights = weights.reshape(draws, len(cover), 1 << (n//2)).sum(axis=2)
    survivors = np.flatnonzero(np.all(weights == (1 << (n//2-1)), axis=1))
    records = []
    additional_cover = []
    if len(survivors):
        engine = Evaluator(basis, indices, backend)
        all_weights, derivative = engine.evaluate(coefficients[survivors])
        failure = all_weights[:, 1:] != (1 << (n//2-1))
        additional_cover, still_uncovered = greedy_cover(failure)
        records = [candidate_record(coefficients[survivors[j]], all_weights[j], derivative[j],
                                    [r for r, _ in orbits]) for j in range(min(4, len(survivors)))]
    else:
        still_uncovered = 0
    result = {'fresh_seed': seed, 'fresh_dense_draws': draws, 'learned_fibers': cover,
              'cover_exclusions': draws - len(survivors), 'cover_survivors': len(survivors),
              'additional_fibers_covering_recorded_survivors': additional_cover,
              'still_uncovered_by_all_fibers': still_uncovered,
              'survivor_examples': records,
              'conclusion': 'A learned sample cover must be retested on independent draws; it is not a universal proof.'}
    (folder / 'holdout.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


def run(n=16, degree=5, rounds=4, batch=256, backend='auto', seed=20261006,
        output='resultados_fibras_loop', max_seconds=1800):
    if n not in (8, 16) or degree % 2 != 1 or degree < 3 or degree > n:
        raise ValueError('Supported targets: n=8 or 16 and homogeneous odd degree >=3')
    if rounds < 1 or batch < 8 or max_seconds < 1:
        raise ValueError('Positive bounded rounds, time and batch>=8 required')
    folder = Path(output)
    folder.mkdir(parents=True, exist_ok=True)
    config = dict(n=n, degree=degree, rounds=rounds, batch=batch, backend=backend,
                  seed=seed, max_seconds=max_seconds)
    started = time.monotonic()
    orbits, basis, indices = make_tables(n, degree)
    representatives = [rep for rep, _ in orbits]
    engine = Evaluator(basis, indices, backend)
    rng = np.random.default_rng(seed)
    elites = np.empty((0, len(basis)), dtype=np.uint8)
    previous_cover = []
    history = []
    failures_history = []
    potential_candidates = []
    best_records = []
    print(json.dumps({'backend': engine.backend, 'gpu': engine.gpu, 'basis_orbits': len(basis), 'config': config}), flush=True)
    for round_id in range(rounds):
        if round_id > 0 and time.monotonic() - started > max_seconds:
            break
        coefficients, kinds = draw_batch(rng, len(basis), batch, elites, round_id)
        weights, derivative = engine.evaluate(coefficients)
        expected_fiber_weight = (1 << (n // 2)) // 2
        failures = weights[:, 1:] != expected_fiber_weight
        derivative_balanced = derivative == (1 << n) // 2
        complementary_balanced = ~failures[:, -1]
        both = derivative_balanced & complementary_balanced
        all_balanced = ~failures.any(axis=1)
        # Evaluate a cover learned in the PREVIOUS round on a fresh dense cohort.
        holdout = kinds == 0
        if previous_cover:
            cols = [record['z'] - 1 for record in previous_cover]
            validation_exclusions = int(failures[holdout][:, cols].any(axis=1).sum())
        else:
            validation_exclusions = None
        cover, uncovered = greedy_cover(failures)
        order = np.argsort(failures.sum(axis=1), kind='stable')[:min(32, batch)]
        elites = coefficients[order].copy()
        for row in np.flatnonzero(all_balanced & derivative_balanced):
            potential_candidates.append(candidate_record(coefficients[row], weights[row], derivative[row], representatives))
        best_records = [candidate_record(coefficients[row], weights[row], derivative[row], representatives) for row in order[:4]]
        record = {'round': round_id + 1, 'tested': batch,
                  'cohorts': {name: int((kinds == index).sum()) for index, name in enumerate(('fresh_dense', 'fresh_sparse', 'elite_mutations'))},
                  'derivative_balanced': int(derivative_balanced.sum()),
                  'complementary_balanced': int(complementary_balanced.sum()),
                  'both_balanced': int(both.sum()),
                  'both_excluded_by_other_fibers': int((both & failures.any(axis=1)).sum()),
                  'all_nonzero_fibers_balanced': int(all_balanced.sum()),
                  'all_fibers_and_derivative_balanced': int((all_balanced & derivative_balanced).sum()),
                  'greedy_sample_cover': cover, 'uncovered_by_all_fibers': uncovered,
                  'previous_cover_fresh_dense_exclusions': validation_exclusions,
                  'fresh_dense_validation_size': int(holdout.sum()),
                  'closest_candidate_unbalanced_fiber_count': int(failures.sum(axis=1).min())}
        history.append(record)
        failures_history.append(failures)
        previous_cover = cover
        # Per-round data persists before the next round; Colab can export it.
        np.savez_compressed(folder / f'round_{round_id+1:04d}.npz',
                            coefficients=coefficients, kinds=kinds, weights=weights,
                            derivative_weights=derivative)
        (folder / 'checkpoint.json').write_text(json.dumps({'config': config,
            'completed_rounds': round_id + 1, 'rng_state': rng.bit_generator.state,
            'latest_cover': cover, 'warning': 'This is sampled evidence, not a universal certificate.'}, indent=2) + '\n')
        print(json.dumps(record), flush=True)
    failure_matrix = np.vstack(failures_history)
    global_cover, global_uncovered = greedy_cover(failure_matrix)
    summary = {'status': 'COMPLETED', 'config': config, 'actual_backend': engine.backend,
               'gpu': engine.gpu, 'basis_orbits': len(basis),
               'basis_sha256': hashlib.sha256(basis.tobytes()).hexdigest(),
               'representatives': [list(rep) for rep in representatives],
               'tested_total': sum(row['tested'] for row in history),
               'rounds_completed': len(history), 'rounds': history,
               'global_sample_cover': global_cover,
               'uncovered_by_all_fibers': global_uncovered,
               'potential_candidates': potential_candidates,
               'latest_closest_candidates': best_records,
               'elapsed_seconds': round(time.monotonic() - started, 3),
               'limitations': ['Adaptive samples can repeat candidates; tested_total counts draws.',
                              'A cover excludes only the recorded samples, not the full coefficient space.',
                              'No result is a proof of quintic nonexistence or proof-assistant certification.',
                              'GPU execution is reported only when the actual backend is CUDA.']}
    (folder / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    (folder / 'next_hypotheses.json').write_text(json.dumps({
        'classification': 'research proposals, not theorems',
        'proposals': [
            {'name': 'small_fiber_cover', 'fibers': [r['z'] for r in global_cover],
             'next_test': 'Evaluate on a new independent seed and all sparse supports up to a chosen bound.'},
            {'name': 'conditional_derivative_fiber_obstruction',
             'next_test': 'Search specifically among candidates satisfying all-ones derivative and complementary balance.'},
            {'name': 'universal_certificate',
             'next_test': 'Derive a faithful exact constraint model and independently verify exclusions; sample cover alone is insufficient.'}]}, indent=2) + '\n')
    return summary


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--n', type=int, default=16)
    parser.add_argument('--degree', type=int, default=5)
    parser.add_argument('--rounds', type=int, default=4)
    parser.add_argument('--batch', type=int, default=256)
    parser.add_argument('--backend', choices=('auto', 'cpu', 'cuda'), default='auto')
    parser.add_argument('--seed', type=int, default=20261006)
    parser.add_argument('--output', default='resultados_fibras_loop')
    parser.add_argument('--max-seconds', type=int, default=1800)
    args = parser.parse_args()
    result = run(**vars(args))
    print(json.dumps({k: result[k] for k in ('actual_backend', 'tested_total', 'rounds_completed', 'uncovered_by_all_fibers', 'elapsed_seconds')}, indent=2))
