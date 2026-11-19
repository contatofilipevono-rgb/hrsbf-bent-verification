"""Find an exact chart cover for the five-column polar block."""
import itertools
import json
from pathlib import Path
import random

import numpy as np

from H16_POLAR_FLAGS import add, encode, null, radical_flag, rref
from H16_SPECIALIZED_KERNEL import mul, specialize


def translation_radical(coeff, dim):
    width = coeff[0].size
    polar = np.zeros((dim, width, dim), dtype=np.uint8)
    for mask, value in coeff.items():
        if mask.bit_count() == 2:
            j, k = [i for i in range(dim) if mask >> i & 1]
            polar[j, :, k] ^= value.ravel()
            polar[k, :, j] ^= value.ravel()
    radical = null(polar.reshape(-1, dim))
    restricted, _ = specialize(coeff, np.zeros(dim, dtype=np.uint8), radical)
    assert all(not A.any() for p, A in restricted.items() if p.bit_count() > 1)
    changes = [restricted.get(1 << i, np.zeros_like(coeff[0])).ravel()
               for i in range(len(radical))]
    stabilizer = mul(null(np.array(changes, dtype=np.uint8).T), radical)
    assert len(rref(stabilizer)[1]) == len(stabilizer)
    return stabilizer


def all_images(coeff, stabilizer):
    dim = stabilizer.shape[1]
    pivots = set(rref(stabilizer)[1])
    complement = np.eye(dim, dtype=np.uint8)[[j for j in range(dim) if j not in pivots]]
    restricted, _ = specialize(coeff, np.zeros(dim, dtype=np.uint8), complement)
    terms = [p for p, A in restricted.items() if A.any()]
    assignments = np.arange(1 << len(complement), dtype=np.uint32)
    matrices = mul((assignments[:, None] & terms == terms).astype(np.uint8),
                   np.array([restricted[p].ravel() for p in terms], dtype=np.uint8))
    images = set()
    for A in matrices.reshape((-1, 19, 5)):
        canonical, pivots = rref(A.T)
        assert len(pivots) == 5
        images.add(tuple(encode(canonical)))
    return sorted(images)


def cover(images):
    rng = random.Random(51050)
    charts = [tuple(1 << j for j in subset) for subset in itertools.combinations(range(19), 5)]
    charts += [tuple(rng.getrandbits(19) for _ in range(5)) for _ in range(1536)]
    def covers(chart, image):
        basis = {}
        for x in image:
            col = sum(((x & f).bit_count() & 1) << j for j, f in enumerate(chart))
            if not add(basis, col):
                return False
        return True
    cover_masks = [sum(int(covers(chart, image)) << j for j, image in enumerate(images))
                   for chart in charts]
    remaining = (1 << len(images))-1
    chosen = []
    while remaining:
        index = max(range(len(charts)), key=lambda i: (cover_masks[i] & remaining).bit_count())
        count = (cover_masks[index] & remaining).bit_count()
        assert count > 0  # The coordinate projections alone cover every 5-plane.
        chosen.append({"rows": charts[index], "new_images": count})
        remaining &= ~cover_masks[index]
    return chosen


def main():
    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    dim, coeff, S = next(item for item in radical_flag(data) if item[0] == 30)
    origin, _ = specialize(coeff, np.zeros(S.shape[1], dtype=np.uint8), S)
    K = null(np.concatenate([A for p, A in origin.items() if p], axis=0))
    assert len(K) == 5
    blocks = {p: mul(A, K.T) for p, A in coeff.items()}
    U = np.concatenate(list(blocks.values()), axis=1)
    _, rows = rref(U.T)
    assert len(rows) == 19
    small = {p: A[rows] for p, A in blocks.items()}
    stabilizer = translation_radical(small, S.shape[1])
    assert not mul(null(stabilizer), S.T).any()
    images = all_images(small, stabilizer)
    assert len(images) == 512
    charts = cover(images)
    result = {"row_coordinates": rows, "dependence_dim": S.shape[1]-len(stabilizer),
              "stabilizer_dim": len(stabilizer), "linear_forms": encode(null(stabilizer)),
              "images": len(images), "charts": charts}
    Path("step51_charts.json").write_text(json.dumps(result))
    print("STEP51_CHARTS", json.dumps(result), flush=True)


if __name__ == "__main__":
    main()
