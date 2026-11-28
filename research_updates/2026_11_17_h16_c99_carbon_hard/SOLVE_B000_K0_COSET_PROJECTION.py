#!/usr/bin/env python3
"""Exact affine projections of the short coset balance equations in K=0."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import time

import numpy as np

from SOLVE_B000_K0_RECERT_GAPS import b09, diag_v2
from SOLVE_B000_K0_WESS_REPLAY import ROOT_SHA, Replay, assignments, require, s19
from k0_balance_fallback import make_fibers


def project(terms, linear_pivots, max_rank):
    signed = Counter()
    for mask, weight in terms.items():
        sign = 1
        for p, (form, rhs) in linear_pivots.items():
            if mask & (1 << p):
                mask ^= form
                if rhs:
                    sign = -sign
        signed[mask] += sign * weight
    signed = {m: c for m, c in signed.items() if c}
    rref = s19.strict_rref_masks(list(signed))
    pivots = sorted(rref)
    result = {"rank": len(pivots), "nonzero_characters": len(signed)}
    if len(pivots) > max_rank:
        return result
    hist = np.zeros(1 << len(pivots), dtype="<i2")
    for mask, weight in signed.items():
        coords = sum((1 << i) for i, p in enumerate(pivots) if mask & (1 << p))
        reconstructed = 0
        for i, p in enumerate(pivots):
            if coords & (1 << i):
                reconstructed ^= rref[p]
        require(reconstructed == mask, "Failed to express character in projected basis")
        hist[coords] = weight
    for bit in range(len(pivots)):
        size = 1 << bit
        shaped = hist.reshape(-1, 2 * size)
        left, right = shaped[:, :size].copy(), shaped[:, size:].copy()
        shaped[:, :size] = left + right
        shaped[:, size:] = left - right
    balanced = np.flatnonzero(hist == 0)
    result.update(balanced_assignments=len(balanced),
                  histogram_sha256=hashlib.sha256(hist.tobytes()).hexdigest(),
                  min_absolute=int(np.min(np.abs(hist))))
    if len(balanced):
        origin = int(balanced[0])
        pivots_of_differences = {}
        for point in balanced:
            delta = int(point) ^ origin
            while delta:
                key = delta.bit_length() - 1
                if key not in pivots_of_differences:
                    pivots_of_differences[key] = delta
                    break
                delta ^= pivots_of_differences[key]
            if len(pivots_of_differences) == len(pivots):
                break
        result["balanced_affine_dim"] = len(pivots_of_differences)
        if len(pivots_of_differences) < len(pivots):
            result["basis_forms_hex"] = [hex(rref[p]) for p in pivots]
            result["balanced_affine_origin"] = origin
            result["balanced_affine_span"] = list(pivots_of_differences.values())
    return result


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--eta", type=int, required=True)
    p.add_argument("--rb", type=int, nargs="+", required=True)
    p.add_argument("--out", type=Path, required=True)
    args = p.parse_args()
    replay = Replay(args.eta, deadline=time.monotonic() + 600, max_depth=1)
    require(set(args.rb) <= set(replay.opened), "Unexpected source prefix")
    _, origin, basis = b09.build_pure_111_basis(0, 0, 0)
    require(origin == 0, "Expected linear physical chart")
    fibers = make_fibers(diag_v2.build_orbits_116(), basis, lambda c:
                         sum(((v & c).bit_count() % 2) << j for j, v in enumerate(basis)))
    leaves = {}
    for rb in args.rb:
        state = replay.cascade(replay.eta_state, assignments(replay.fix, rb))
        require(not state["closed_unsat"] and "_lin_pivs" in state, "Unexpected prefix residual")
        profiles = {z: project(terms, state["_lin_pivs"], 21) for z, terms in fibers.items()}
        leaves[rb] = profiles
        print("PROJECTION", rb, json.dumps(profiles), flush=True)
    args.out.write_text(json.dumps({"eta": args.eta, "root_sha256": ROOT_SHA,
                                    "fix_sha256": replay.fix_sha, "verify_subst": True,
                                    "conditional_on": "C5", "leaves": leaves}, indent=2) + "\n")


if __name__ == "__main__":
    main()
