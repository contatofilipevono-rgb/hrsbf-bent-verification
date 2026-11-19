"""Bound all common isotropic subspaces and test pure-W relations on four fibers."""
from collections import Counter
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import null, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, rank, specialize, transform
from SOLVE_STEP54_GLOBAL_SYZYGIES import dependencies, residual
from SOLVE_STEP55_QUADRATIC_ISOTROPIC_FLAG import bilinear_form
import SOLVE_STEP50_SPLIT_QUOTIENT as step50


def rank_bound(coeff, U, J):
    n = U.shape[1]
    polar = bilinear_form(coeff, n)
    flats = []
    for vec in J:
        contraction = np.bitwise_xor.reduce(polar[np.flatnonzero(vec)], axis=0)
        flats.append(mul(U, contraction.T))
    current = np.zeros_like(flats[0])
    ranks = Counter()
    for i in range(1, 1 << len(J)):
        j = (i & -i).bit_length()-1
        current ^= flats[j]
        ranks[rank(current, rref)] += 1
    bound_outside = len(U) + len(J) - min(ranks)
    return {"free":len(U), "outside_points":sum(ranks.values()), "cross_rank_hist":ranks,
            "max_flat_outside":bound_outside, "max_flat":max(len(U),bound_outside),
            "unique_max":bound_outside < len(U)}


def probe(coeff, S, rhs, pure, fixed_bits, trial):
    left, right = residual(coeff, S, rhs)
    n = S.shape[1]
    cert = json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    U = null(unpack(cert["fixed_forms"], n))
    pivot = set(rref(U)[1])
    J = np.eye(n, dtype=np.uint8)[[j for j in range(n) if j not in pivot]]
    assert rank(np.concatenate((U, J)), rref) == n
    corrected = {m:A[50:] for m,A in left.items() if A[50:].any()}

    origin, _ = specialize(corrected, np.zeros(n, dtype=np.uint8), U)
    assert all(not A.any() for m,A in origin.items() if m.bit_count()>1)
    bound = rank_bound(corrected, U, J)
    print("STEP56_BOUND", json.dumps(bound), flush=True)
    cases = []
    for value in (0, 1, 85, 511):
        offset = np.zeros(n, dtype=np.uint8)
        for j, v in enumerate(J):
            if value >> j & 1:
                offset ^= v
        restricted, forms = specialize(left, offset, U)
        assert all(not A.any() for m,A in restricted.items() if m.bit_count()>1)
        cache = {0:{0}}
        r = [transform(poly, forms, cache) for poly in right]
        w = [transform(poly, forms, cache) for poly in pure]
        report, witnesses = dependencies(restricted, r, len(U), False, w, affine_rows=64)
        print("STEP56_FIBER", json.dumps({"offset":value, **report}), flush=True)
        cases.append({"offset":value, "report":report,"witnesses":[[sorted(p), c] for p,c in witnesses]})
    Path("step56_rank_bound.json").write_text(json.dumps({"bound":bound,"cases":cases}))


if __name__ == "__main__":
    step50.split_probe = probe
    step50.main()
