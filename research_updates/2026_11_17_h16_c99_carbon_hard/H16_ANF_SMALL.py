"""Enumerate small Boolean ANF systems by exact truth-table arithmetic."""


def anf_solutions(polynomials, dimension):
    """Return all masks satisfying every squarefree ANF in polynomials."""
    size = 1 << dimension
    universe = (1 << size) - 1
    coordinates = []
    for i in range(dimension):
        width = 1 << i
        value = ((1 << width) - 1) << width
        period = 2 * width
        while period < size:
            value |= value << period
            period *= 2
        coordinates.append(value)
    mono_cache = {0: universe}
    survivors = universe
    for poly in polynomials:
        values = 0
        for monomial in poly:
            if monomial not in mono_cache:
                assert monomial.bit_length() <= dimension
                value = universe
                mask = monomial
                while mask:
                    bit = mask & -mask
                    mask ^= bit
                    value &= coordinates[bit.bit_length() - 1]
                mono_cache[monomial] = value
            values ^= mono_cache[monomial]
        survivors &= universe ^ values
        if not survivors:
            return []
    solutions = []
    while survivors:
        bit = survivors & -survivors
        survivors ^= bit
        solutions.append(bit.bit_length() - 1)
    return solutions
