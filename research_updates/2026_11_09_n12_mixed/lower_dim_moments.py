"""Compile exact moment conditions for phases on the larger fibres."""
from functools import lru_cache
from itertools import combinations

from count_near_antipodal import image_and_kernel
from higher_filter import solve
from lower_dim_model import active_indices


@lru_cache(maxsize=None)
def moment_masks(width, max_order):
    size = 1 << width
    full = (1 << size) - 1
    coordinates = [full ^ (full // ((1 << (1 << i)) + 1)) for i in range(width)]
    result = [(0, full)]
    for order in range(1, max_order + 1):
        for support in combinations(range(width), order):
            mask = full
            for i in support:
                mask &= coordinates[i]
            result.append((order, mask))
    return result


def conditions(fibres, width, t):
    out = []
    for points in fibres:
        assert points.bit_count() == 1 << (2 * t)
        for order, coordinates in moment_masks(width, t):
            subset = points & coordinates
            if order == 0:
                out.append((subset, (1 << t) - 1, 1 << (t - 1)))
            else:
                size = subset.bit_count()
                if size & 1:
                    return None
                if order < t:
                    out.append((subset, (1 << (t - order)) - 1, (size // 2) & ((1 << (t - order)) - 1)))
    return out


def phase_linear_system(equations, reference, phase_kernel):
    def rows():
        for subset, _, residue in equations:
            rhs = (residue ^ (subset & reference).bit_count()) & 1
            row = sum(((subset & h).bit_count() & 1) << i for i, h in enumerate(phase_kernel))
            yield row, rhs
    return solve(rows(), len(phase_kernel))


def exact(equations, phase):
    return all(((subset & phase).bit_count() & modulus_mask) == residue
               for subset, modulus_mask, residue in equations)


def affine_phase_quotient(fibres, width, directions, signatures=None):
    """Quotient by phase shifts affine separately on every fibre."""
    degree_one = [mask for _, mask in moment_masks(width, 1)]
    projections = [0] * len(directions)
    size = 1 << width
    for label, points in enumerate(fibres):
        affine, _ = image_and_kernel([points & mask for mask in degree_one])
        rows = sorted((row for row, _ in affine), reverse=True)
        for i, direction in enumerate(directions):
            remainder = direction & points
            for row in rows:
                if remainder >> (row.bit_length() - 1) & 1:
                    remainder ^= row
            projections[i] |= remainder << (label * size)
    if signatures is not None:
        for i, signature in enumerate(signatures):
            projections[i] |= signature << (len(fibres) * size)
    image, kernel = image_and_kernel(projections)
    return [code for _, code in image], kernel


def signed_walsh(fibre, phase, width):
    table = [0] * (1 << width)
    for x in active_indices(fibre):
        table[x] = 1 - 2 * (phase >> x & 1)
    length = 1
    while length < len(table):
        for start in range(0, len(table), 2 * length):
            for x in range(start, start + length):
                a, b = table[x], table[x + length]
                table[x], table[x + length] = a + b, a - b
        length *= 2
    return table


def self_check():
    # An affine 2t-flat with a nonsingular quadratic sign is a positive
    # example. Changing one sign is a negative control on the same support.
    results = []
    for t in (1, 2, 3, 4):
        width = t + 6
        fibre = (1 << (1 << (2 * t))) - 1
        low_mask = (1 << t) - 1
        phase = sum((((x & (x >> t) & low_mask).bit_count() & 1) << x)
                    for x in range(1 << (2 * t)))
        equations = conditions([fibre], width, t)
        for h in (phase, phase ^ 1):
            direct = set(map(abs, signed_walsh(fibre, h, width))) == {1 << t}
            assert direct == exact(equations, h)
        assert exact(equations, phase)
        assert not exact(equations, phase ^ 1)
        results.append({"support_size": fibre.bit_count(), "ambient_dimension": width,
                        "walsh_amplitude": 1 << t, "checks": len(equations)})
    return results


if __name__ == "__main__":
    print(self_check())
