from collections import Counter
from functools import lru_cache
from itertools import combinations

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import solve, xor_terms
from line_column_autocorrelation import affine_consequences
from line_zero_column import character_values
from lower_dim_model import build


def prepare(space):
    model = build(((7, 14, 28, 56), (5, 10, 20, 40))[space-1])
    maps = [p for p, _ in model.maps]
    mask = (1 << 64) - 1

    def mixed(mapping):
        return sum(
            (((mapping >> (256*i+64*k)) ^ (mapping >> (256*i))) & mask)
            << (64*(4*(k-1)+i)) for k in (1,2) for i in range(4)
        )

    im, ker = image_and_kernel([mixed(p) for p in maps])
    lifts = [word for _, word in im]
    directions = [xor_terms(maps, v) for v in ker]
    return maps, lifts, directions


def character_sums(base, directions):
    for label in range(1,16):
        indices = [i for i in range(4) if label >> i & 1]
        form = xor_terms([base >> (256*i) for i in range(4)], label)
        spectra = Counter()
        for z in range(64):
            sign = (form >> z) & 1
            if any((form >> (z + 64*k)) & 1 != sign for k in (1,2)):
                continue
            mask = sum(
                (sum((p >> (256*i+z)) & 1 for i in indices) & 1) << j
                for j,p in enumerate(directions)
            )
            spectra[mask] += 1-2*sign
        yield label, 0, {mask: c for mask,c in spectra.items() if c}


def main():
    for space in (1,2):
        maps, lifts, directions = prepare(space)
        stats = Counter()
        for chart in range(256):
            base = xor_terms(maps, xor_terms(lifts, chart))
            rows = list(character_sums(base, directions))
            origin, free, trace = affine_consequences(rows,len(directions))
            stats[len(free) if origin is not None else -1]+=1
        print(space,stats)


if __name__ == "__main__":
    main()
