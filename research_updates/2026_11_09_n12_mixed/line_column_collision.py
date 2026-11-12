"""Find unavoidable collisions with a rank-zero partial Walsh row."""

from itertools import combinations

from lower_dim_phase_prepare import truth_on_coordinates


def radical_bases(polar):
    matrices = [[0] * 6 for _ in range(64)]
    for k, (i, j) in enumerate(combinations(range(6), 2)):
        for z, rows in enumerate(matrices):
            if (polar >> (64 * k + z)) & 1:
                rows[i] ^= 1 << j
                rows[j] ^= 1 << i
    bases = []
    for rows in matrices:
        span = {0}
        basis = []
        for v in range(1, 64):
            if v in span or any((v & row).bit_count() % 2 for row in rows):
                continue
            span |= {v ^ u for u in span}
            basis.append(v)
        bases.append(basis)
    return bases


def collision(model, mapping, root, directions, polar):
    """Return rows that force a second contribution to an occupied column."""
    radicals = radical_bases(polar)
    if not any(len(basis) == 6 for basis in radicals):
        return None
    w_index = {model.coordinates[i] >> 6: i for i in range(0, 4096, 64)}
    tables = [truth_on_coordinates(mapping, root, 1)]
    tables.extend(truth_on_coordinates(0, h, 1) for h in directions)

    def derivative(z, v):
        return sum((((table >> (z + w_index[v])) ^ (table >> z)) & 1) << i
                   for i, table in enumerate(tables))

    for a, basis in enumerate(radicals):
        if len(basis) != 6:
            continue
        halfspaces = {}
        for z, other_basis in enumerate(radicals):
            if z == a:
                continue
            # The other row contributes precisely when all these affine bits vanish.
            conditions = {derivative(z, v) ^ derivative(a, v) for v in other_basis} - {0}
            if not conditions:
                return {"rank_zero_row": a, "other_rows": [z]}
            if len(conditions) != 1 or 1 in conditions:
                continue
            condition, = conditions
            if condition ^ 1 in halfspaces:
                return {"rank_zero_row": a, "other_rows": [halfspaces[condition ^ 1], z],
                        "affine_condition": condition}
            halfspaces[condition] = z
    return None
