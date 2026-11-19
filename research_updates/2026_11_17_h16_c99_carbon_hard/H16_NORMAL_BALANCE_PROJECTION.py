"""Exact finite-image tests of normal-bent D8 coset balance."""

def _range_basis(columns, rank_cap):
    basis = {}
    for vector in columns:
        while vector:
            lead = vector.bit_length() - 1
            if lead not in basis:
                basis[lead] = vector
                if len(basis) > rank_cap:
                    return None
                break
            vector ^= basis[lead]
    return list(basis.values())


def normal_balance_count(tables, pivots, rank_cap=12):
    """Return (rank, balanced_count) or None above the rank cap.

    Each table is (constant, columns) in 256-bit truth-table encoding.
    The equations in pivots have form parity(mask & coeffs) = rhs.
    Maps for all supplied cosets are projected jointly.
    """
    n = len(tables[0][1])
    columns = [0] * n
    constant = 0
    for i, (phase, linear) in enumerate(tables):
        shift = 256 * i
        constant |= phase << shift
        for j, vector in enumerate(linear):
            columns[j] |= vector << shift
    pivot_mask = sum(1 << p for p in pivots)
    for p, (mask, rhs) in pivots.items():
        assert mask & pivot_mask == 1 << p
        if rhs:
            constant ^= columns[p]
        rest = mask ^ (1 << p)
        while rest:
            bit = rest & -rest
            rest ^= bit
            columns[bit.bit_length() - 1] ^= columns[p]
        columns[p] = 0
    basis = _range_basis(columns, rank_cap)
    if basis is None:
        return None
    image = [constant]
    for vector in basis:
        image += [point ^ vector for point in image]
    block_mask = (1 << 256) - 1
    count = sum(all(((point >> (256 * i)) & block_mask).bit_count() == 128
                    for i in range(len(tables))) for point in image)
    return len(basis), count
