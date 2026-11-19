"""Exact common-kernel elimination and bounded low-rank search for Step 40A."""

import json
import math
import subprocess
from pathlib import Path

import numpy as np


def matmul(a, b):
    return (a @ b) & 1


def encode(rows):
    return [sum(int(x) << j for j, x in enumerate(row)) for row in rows]


def independent(vectors):
    pivots = {}
    keep = []
    for i, vector in enumerate(vectors):
        while vector:
            lead = vector.bit_length() - 1
            if lead not in pivots:
                pivots[lead] = vector
                keep.append(i)
                break
            vector ^= pivots[lead]
    return keep


def polynomial_rows(polys, w_idx, t_idx, rf_idx, matrix, slices):
    rhs = []
    quadratic = {}
    for p in polys:
        const = set()
        i = len(rhs)
        mm0 = np.zeros_like(matrix[i])
        mms = np.zeros_like(slices[:, i])
        for mon in p:
            ids = [j for j in w_idx.keys() | t_idx.keys() | rf_idx.keys() if mon >> j & 1]
            assert sum(1 << j for j in ids) == mon
            rcols = [rf_idx[j] for j in ids if j in rf_idx]
            if not rcols:
                const.add(mon)
                continue
            assert len(rcols) == 1 and len(ids) <= 3
            variables = [j for j in ids if j not in rf_idx]
            if len(variables) == 2:
                key = tuple(sorted(w_idx[j] for j in variables))
                quadratic.setdefault(key, np.zeros_like(matrix))[i, rcols[0]] ^= 1
            elif variables:
                (j,) = variables
                assert j in w_idx
                mms[w_idx[j], rcols[0]] ^= 1
            else:
                mm0[rcols[0]] ^= 1
        assert np.array_equal(mm0, matrix[i]) and np.array_equal(mms, slices[:, i])
        rhs.append(const)
    return rhs, quadratic


def tail_solution(rows, w_idx, t_idx, nullspace):
    tmask = sum(1 << j for j in t_idx)
    wmask = sum(1 << j for j in w_idx)
    pivots = {}
    for row in rows:
        assert all((x & wmask == x and x.bit_count() <= 2) or
                   (x & tmask == x and x.bit_count() == 1) for x in row)
        poly = set(row)
        mask = sum(x for x in row if x & tmask)
        while mask:
            bit = mask & -mask
            if bit not in pivots:
                pivots[bit] = mask, poly
                break
            prev, rhs = pivots[bit]
            mask ^= prev
            poly ^= rhs
        else:
            assert not poly
    assert len(pivots) == len(t_idx)
    solved = {}
    for bit, (mask, poly) in sorted(pivots.items(), reverse=True):
        result = {m for m in poly if not m & tmask}
        for b, value in solved.items():
            if mask & b:
                result ^= value
        solved[bit] = result
    return solved


def direction(matrices, mask):
    return np.bitwise_xor.reduce([m for k, m in enumerate(matrices) if mask >> k & 1], axis=0)


def explore(matrices, rref, nullspace, max_weight):
    exe = Path("h16_minrank_sparse").resolve()
    subprocess.run(["g++", "-O3", "-std=c++17",
                    str(Path(__file__).with_name("h16_minrank_sparse.cpp")), "-o", str(exe)], check=True)
    n, rows, cols = matrices.shape
    lines = [f"{n} {rows} {max_weight}"] + [" ".join(map(str, encode(m))) for m in matrices]
    data = subprocess.run([str(exe)], input="\n".join(lines), text=True,
                          capture_output=True, check=True, timeout=120).stdout
    hits = {int(m): int(r) for m, r in (line.split() for line in data.splitlines())}
    for m, rank in hits.items():
        assert len(rref(direction(matrices, m))[1]) == rank
    seed = sorted(hits, key=lambda m: (hits[m], m.bit_count(), m))
    basis = [seed[i] for i in independent(seed)]
    extra = {}
    if len(basis) <= 13:
        span = [0]
        for b in basis:
            span += [a ^ b for a in span]
        for a in span[1:]:
            if a not in hits:
                rank = len(rref(direction(matrices, a))[1])
                if rank <= 10:
                    extra[a] = rank
    all_low = hits | extra
    computed = {str(i): sum(rank == i for rank in hits.values()) for i in range(11)}
    counts = {}
    for cutoff in (6, 8, 10):
        vectors = sorted(a for a, rank in all_low.items() if rank <= cutoff)
        generators = [vectors[i] for i in independent(vectors)]
        ds = [direction(matrices, a) for a in generators]
        image_dim = len(rref(np.concatenate(ds, axis=1))[1]) if ds else 0
        row_dim = len(rref(np.concatenate(ds, axis=0))[1]) if ds else 0
        max_rank = None
        if 0 < len(ds) <= 12:
            combinations = [np.zeros_like(ds[0])]
            for matrix in ds:
                combinations += [prev ^ matrix for prev in combinations]
            max_rank = max(len(rref(m)[1]) for m in combinations)
        counts[str(cutoff)] = {"found": len(vectors), "span_dim": len(generators),
                               "basis": [[i for i in range(n) if a >> i & 1] for a in generators],
                               "image_dim": image_dim, "common_kernel_dim": cols - row_dim,
                               "max_rank_entire_span": max_rank}
    return {"checked_weight_le": max_weight,
            "directions_checked": sum(math.comb(n, k) for k in range(1, max_weight + 1)),
            "sparse_rank_histogram": computed,
            "extra_low_rank_in_seed_span": len(extra),
            "low_rank": counts,
            "witnesses": [[m, rank] for m, rank in sorted(all_low.items())]}


def analyze(cell, matrix, slices, polys, quads, w_idx, t_idx, rf_idx, rref, nullspace):
    rhs, quadratic = polynomial_rows(polys, w_idx, t_idx, rf_idx, matrix, slices)
    tails = tail_solution(quads, w_idx, t_idx, nullspace)
    affine_k = nullspace(slices.reshape(-1, slices.shape[-1]))
    coefficients = np.concatenate([*slices, *quadratic.values()], axis=0)
    k = nullspace(coefficients)
    constants = matmul(matrix, k.T)
    _, active = rref(constants)
    eliminated = k[active]
    n = matrix.shape[1]
    combined = np.vstack((k, np.eye(n, dtype=np.uint8)))
    complement = combined[independent(encode(combined))[len(k):]]
    assert len(k) + len(complement) == n
    projector = nullspace(constants.T)
    # Keep every compatibility equation, including those with no R coefficients.
    reduced0 = matmul(matmul(projector, matrix), complement.T)
    reducedk = matmul(matmul(projector, slices), complement.T)
    assert not matmul(projector, constants).any()
    assert not matmul(coefficients, k.T).any()
    reduced_q = {ij: matmul(matmul(projector, m), complement.T) for ij, m in quadratic.items()}
    assert reduced0.shape[0] == matrix.shape[0] - len(active)
    gauge = len(k) - len(eliminated)
    # In coordinates [a,b,g], a=eliminated, b=complement, g=gauge; g never occurs.
    gauge_basis = matmul(nullspace(constants), k)
    assert len(gauge_basis) == gauge and not matmul(matrix, gauge_basis.T).any()

    # Verify projected row span equals all equations annihilating the eliminable columns.
    assert len(rref(projector)[1]) + len(active) == matrix.shape[0]
    lift_equations = np.concatenate((constants[:, active], matrix @ complement.T & 1), axis=1)
    assert np.array_equal(matmul(projector, lift_equations)[:,len(active):], reduced0)
    print("STEP41_REDUCED", json.dumps({"cell": cell, "original": list(matrix.shape),
        "eliminated": len(active), "gauge": gauge, "effective": list(reduced0.shape),
        "affine_common_kernel": len(affine_k), "full_common_kernel": len(k),
        "quadratic_slices": len(quadratic), "projected_quadratic_slices": sum(x.any().item() for x in reduced_q.values()),
        "retaining_gauge": [len(projector), len(complement) + gauge]}), flush=True)

    output = {"w_vars": list(w_idx), "tail_vars": list(t_idx), "r_vars": list(rf_idx),
              "tails": {str(b): sorted(p) for b, p in tails.items()},
              "source_rhs_anf": [sorted(p) for p in rhs],
              "projector": encode(projector), "complement": encode(complement),
              "eliminated": encode(eliminated), "gauge_basis": encode(gauge_basis),
              "reduced_constant": encode(reduced0),
              "reduced_slices": [encode(m) for m in reducedk],
              "reduced_quadratic_slices": [[i, j, encode(m)] for (i, j), m in reduced_q.items() if m.any()]}
    path = Path(f"step41_{cell}.json")
    path.write_text(json.dumps(output))
    result = explore(reducedk, rref, nullspace, 4)
    contrasts = []
    for w in ([1 << 16 ^ 1 << 27] if cell == "B1_11" else [1 << 15, 1 << 26 ^ 1 << 30]):
        projected = direction(reducedk, w)
        derivative = np.zeros_like(reducedk)
        for (i, j), q in reduced_q.items():
            if w >> i & 1:
                derivative[j] ^= q
            if w >> j & 1:
                derivative[i] ^= q
            if (w >> i & 1) and (w >> j & 1):
                projected ^= q
        contrasts.append({"support": [i for i in range(len(slices)) if w >> i & 1],
                          "source_affine_rank": len(rref(direction(slices, w))[1]),
                          "projected_affine_rank": len(rref(direction(reducedk, w))[1]),
                          "derivative_rank_at_zero": len(rref(projected)[1]),
                          "derivative_depends_on_w": bool(derivative.any())})
    assert all(x["source_affine_rank"] >= x["projected_affine_rank"] for x in contrasts)
    result["contrasts"] = contrasts
    output["search"] = result
    path.write_text(json.dumps(output))
    print("STEP41_MINRANK", json.dumps({k: v for k, v in result.items() if k != "witnesses"}), flush=True)
