"""Check the common two-dimensional phase image over all V1 supports."""
import argparse
from collections import Counter, defaultdict
from pathlib import Path
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("model_dir", type=Path)
    parser.add_argument("catalog", type=Path)
    args = parser.parse_args()
    sys.path.insert(0, str(args.model_dir.resolve()))
    from dim4_support_decode import decode
    from higher_filter import xor_terms
    from lower_dim_phase_prepare import fibre_masks

    model, basis, _ = decode(1)
    first, second = 0x084006C00810, 0x106002400C20
    plane = {0, first, second, first ^ second}
    coordinates = [sum(1 << x for x in range(256) if x >> i & 1) for i in (6, 7)]
    images = defaultdict(set)
    ranks = Counter()
    seen = set()
    for code in map(int, args.catalog.read_bytes().splitlines()):
        assert code not in seen
        seen.add(code)
        fibres = fibre_masks(xor_terms(basis, code), 256, 4)
        moments = [subset for fibre in fibres
                   for subset in (fibre, fibre & coordinates[0], fibre & coordinates[1])]
        columns = {sum(((phase & subset).bit_count() & 1) << j
                       for j, subset in enumerate(moments)) for phase in model.phases}
        assert columns <= plane, code
        images[code >> 25].update(columns)
        nonzero = len(columns - {0})
        ranks[0 if not nonzero else 1 if nonzero == 1 else 2] += 1
    assert len(seen) == 113040 and len(images) == 14
    assert all(image == plane for image in images.values())
    print(f"{len(seen)} supports, {len(images)} classes, one common phase plane")
    print("Ranks per support:", dict(sorted(ranks.items())))


if __name__ == "__main__":
    main()
