"""Extract map-only obstructions from fibre 1 of the A0 form."""
from itertools import combinations

from lower_dim_v3_symbolic import affine_at, echelon, product


def quadras(root, directions):
    for z in range(64):
        zz = (z >> 3) | ((z & 7) << 3)
        if z >= zz or not (z.bit_count() & 1):
            continue
        x = z >> 3
        r = x ^ (z & 7)
        u = [affine_at(i, root[z] ^ 1, [g[z] for g in directions]) for i in range(3)]
        phases = (set(), {0} if x & 1 else set(), u[0], u[0] ^ ({0} if (x ^ r) & 1 else set()))
        points = []
        for zz0, shift, phase in zip((z, z, zz, zz), (0, r, x, x ^ r), phases):
            position = [({0} if zz0 >> i & 1 else set()) for i in range(6)]
            position += [a ^ ({0} if shift >> i & 1 else set()) for i, a in enumerate(u)]
            points.append((position, phase))
        yield points


def consistency_equations(g0, gs):
    quads = list(quadras(g0, gs))
    matrix = {}
    conditions = []
    for indices in [()] + [(i,) for i in range(9)] + list(combinations(range(9), 2)):
        low = set()
        high = set()
        phase_sum = set()
        row = 0
        for i, quad in enumerate(quads):
            coefficient = set()
            for point, reference in quad:
                value = {0}
                for j in indices:
                    value = product(value, point[j])
                coefficient ^= value
                phase_sum ^= product(value, reference)
                high ^= product(value, low)
                low ^= value
            assert coefficient in (set(), {0})
            row |= int(bool(coefficient)) << i
        rhs = phase_sum ^ high if indices else phase_sum
        while row:
            lead = row.bit_length() - 1
            if lead not in matrix:
                matrix[lead] = row, rhs
                break
            prev, remainder = matrix[lead]
            row ^= prev
            rhs ^= remainder
        if not row and rhs:
            conditions.append(rhs)
    assert len(matrix) == 7
    return list(echelon(conditions).values())

