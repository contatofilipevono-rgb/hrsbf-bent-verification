"""Build the map and phase bases for an invariant antipodal subspace."""
from dataclasses import dataclass
from functools import lru_cache
from itertools import combinations

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import evaluate_orbit, orbits, xor_terms
from higher_project import LOW, TOP
from mobius_rule import integer_anf
from outside_polar_profiles import cyclic_subspaces
from probe_dim4 import complementary


@lru_cache(maxsize=None)
def rotation_truth():
    return [evaluate_orbit(o) for _, o in (*orbits(12, 0), *orbits(12, 1), *LOW, *TOP)]


@lru_cache(maxsize=None)
def anf(table, width):
    """Use packed Möbius steps on a binary truth table."""
    mask = (1 << (1 << width)) - 1
    for i in range(width):
        step = 1 << i
        zeros = mask // ((1 << step) + 1)
        table ^= (table & zeros) << step
    return table


def active_indices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


@dataclass
class Model:
    basis: tuple
    coordinates: list
    maps: list
    phases: list

    @property
    def nbase(self):
        return 12 - len(self.basis)


def build(basis):
    basis = tuple(basis)
    r = len(basis)
    width = 12 - r
    size = 1 << width
    flat_points = all_points(complementary(list(basis)) + list(basis))
    coordinates = [(z ^ w) | (w << 6) for w in flat_points for z in range(64)]
    forbidden = sum(1 << m for m in range(4096) if (m >> width).bit_count() >= 2)
    truth = []
    exclusions = []
    base = rotation_truth()
    top_offset = len(base) - len(TOP)
    for i, table in enumerate(base):
        moved = sum((table >> x & 1) << k for k, x in enumerate(coordinates))
        truth.append(moved)
        row = anf(moved, 12) & forbidden
        j = i - top_offset
        row |= int(j in (0, 4, 7, 9, 22, 27, 29, 37)) << 4096
        row |= int(j in (1, 3, 5, 8, 24, 28, 34, 36)) << 4097
        exclusions.append(row)
    _, kernel = image_and_kernel(exclusions)
    functions = [xor_terms(truth, code) for code in kernel]
    mask = (1 << size) - 1
    phases = [table & mask for table in functions]
    projections = [sum((((table >> (size << j)) ^ table) & mask) << (size * j)
                       for j in range(r)) for table in functions]
    image, null = image_and_kernel(projections)
    return Model(basis, coordinates, [(p, xor_terms(phases, code)) for p, code in image],
                 [xor_terms(phases, code) for code in null])


def derivative_quotient(pi, r):
    """Derivatives of pi along the w/V coordinates, restricted to w/V=0."""
    size = 1 << (12 - r)
    return sum((((pi >> (size * i + 64 * (1 << j))) ^ (pi >> (size * i))) & ((1 << 64) - 1))
               << (64 * (r * j + i)) for j in range(6 - r) for i in range(r))


def cubic(pi, r):
    width = 12 - r
    size = 1 << width
    mask = (1 << size) - 1
    cubic_mask = sum(1 << m for m in range(size) if m.bit_count() == 3)
    return sum((anf(pi >> (size * j) & mask, width) & cubic_mask) << (size * j) for j in range(r))


def cubic_wedge(left, right, width):
    result = 0
    for a in active_indices(left):
        for b in active_indices(right):
            if not a & b:
                result ^= 1 << (a | b)
    return result


def pair_filter(pi_cubic, r):
    """The degree-six coefficients of every product pi_i*pi_j must vanish."""
    size = 1 << (12 - r)
    mask = (1 << size) - 1
    coordinates = [pi_cubic >> (size * i) & mask for i in range(r)]
    return all(not cubic_wedge(a, b, 12 - r) for a, b in combinations(coordinates, 2))


def check_controls():
    from dim4_model import model
    for space, basis in enumerate([v for v in cyclic_subspaces() if len(v) == 4], 1):
        old_basis, old_coordinates, old_maps, old_phases = model(space)
        got = build(basis)
        assert list(got.basis) == old_basis and got.coordinates == old_coordinates
        unshuffle = [(sum(((p >> (4*x+j)) & 1) << x for x in range(256)) << (256*j))
                     for p, _ in old_maps for j in range(4)]
        expected = [(sum(unshuffle[4*i:4*i+4]), h) for i, (_, h) in enumerate(old_maps)]
        # Different packing changes the elimination order but leaves the span.
        assert len(image_and_kernel([p for p, _ in expected + got.maps])[0]) == len(got.maps)
        assert len(image_and_kernel(old_phases + got.phases)[0]) == len(got.phases)
    for width in range(1, 8):
        import random
        table = random.Random(width).getrandbits(1 << width)
        assert anf(anf(table, width), width) == table
        if width == 7:
            coefficients = integer_anf(table)
            expected = sum((c & 1) << m for m, c in enumerate(coefficients[:1 << width]))
            assert anf(table, width) == expected


def main():
    check_controls()
    for basis in cyclic_subspaces():
        r = len(basis)
        if r not in (2, 3):
            continue
        m = build(basis)
        cubic_columns = [cubic(p, r) for p, _ in m.maps]
        quotients = [derivative_quotient(p, r) for p, _ in m.maps]
        joint = [a | b << (r * (1 << (12 - r))) for a, b in zip(cubic_columns, quotients)]
        print({"basis": basis, "map_dimension": len(m.maps), "phase_dimension": len(m.phases),
               "cubic_dimension": len(image_and_kernel(cubic_columns)[0]),
               "quotient_dimension": len(image_and_kernel(quotients)[0]),
               "cubic_quotient_dimension": len(image_and_kernel(joint)[0])})


if __name__ == "__main__":
    main()
