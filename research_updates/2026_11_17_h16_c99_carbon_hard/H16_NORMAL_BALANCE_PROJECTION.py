"""Exact finite-image tests of normal-bent D8 coset balance."""

def normal_balance_count(tables, pivots, rank_cap=12):
    """Return the rank and number of balanced tables in the joint affine image."""
    options = normal_balance_options(tables, pivots, rank_cap)
    if options is None:
        return None
    forms, balanced = options
    return len(forms), len(balanced)


def normal_balance_options(tables, pivots, rank_cap=12):
    """Return exact linear forms and their balanced assignments in the joint image."""
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

    basis = []
    basis_index = {}
    forms = []
    for j, vector in enumerate(columns):
        coordinates = 0
        while vector:
            lead = vector.bit_length() - 1
            index = basis_index.get(lead)
            if index is None:
                index = len(basis)
                basis_index[lead] = index
                basis.append(vector)
                forms.append(0)
                if len(basis) > rank_cap:
                    return None
            vector ^= basis[index]
            coordinates ^= 1 << index
        while coordinates:
            bit = coordinates & -coordinates
            coordinates ^= bit
            forms[bit.bit_length() - 1] |= 1 << j

    image = [constant]
    for vector in basis:
        image += [point ^ vector for point in image]
    block_mask = (1 << 256) - 1
    balanced = [assignment for assignment, point in enumerate(image)
                if all(((point >> (256 * i)) & block_mask).bit_count() == 128
                       for i in range(len(tables)))]
    return forms, balanced
