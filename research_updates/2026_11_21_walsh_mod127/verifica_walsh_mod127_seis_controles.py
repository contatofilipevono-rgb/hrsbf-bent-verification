"""Confere a aritmética das projeções CRT em cinco e seis controles."""

from fractions import Fraction


def projection_residues(controls):
    modulus = 1 << (8 - controls)
    return {(-1 + modulus * s) % 127 for s in range((1 << controls) + 1)}


def possible_pairs(modulus, valuation, dimension):
    moment = 1 << (dimension - 2 * valuation)
    scale = 1 << valuation
    for x in range(1, 2 * moment, 2):
        for y in range((-x) % modulus, 2 * moment, modulus):
            if x + y <= 2 * moment and scale * x * y - abs(x - y) <= scale * moment:
                yield (x, -y)


def possible_profiles(controls):
    modulus = 1 << (8 - controls)
    residues = projection_residues(controls)
    dimension = 32 - controls
    result = {}
    for d1 in range(1, dimension // 2 + 1):
        d2 = dimension - d1
        for v1 in range(1, 9):
            v2 = 9 - v1
            if not (2 * v1 <= d1 <= 4 * v1 and 2 * v2 <= d2 <= 4 * v2):
                continue
            first = list(possible_pairs(modulus, v1, d1))
            second = list(possible_pairs(modulus, v2, d2))
            pairs = {
                (pair1, pair2)
                for pair1 in first
                for pair2 in second
                if pair1[0] * pair2[0] % modulus == modulus - 1
                and all(a * b % 127 in residues for a in pair1 for b in pair2)
            }
            if pairs:
                result[(d1, d2, v1, v2)] = pairs
    return result


def spectral_values(sign_pair, spectral_class, modulus, bound):
    residues = projection_residues(6)
    return {
        a
        for a in range(-bound, bound + 1)
        if a % modulus == spectral_class % modulus
        and all(s * a % 127 in residues for s in sign_pair)
    }


def main():
    F = Fraction
    profiles = possible_profiles(6)
    assert set(profiles) == {(3, 23, 1, 8), (4, 22, 1, 8), (8, 18, 2, 7)}
    assert profiles[(8, 18, 2, 7)] == {((1, -19), (15, -1)), ((19, -1), (1, -15))}
    assert {p[0] for p in profiles[(3, 23, 1, 8)]} == {(1, -3), (3, -1)}
    small = spectral_values((15, -1), 1, 4, 64)
    assert small == {1, -19, -23, -27, -31, -51, -55, -59, -63}
    assert {a for a in small if a % 8 == 1} == {1, -23, -31, -55, -63}
    assert {a for a in small if a % 16 == 1} == {1, -31, -63}
    assert F(19**2 - 1, 4) > 15 and F(23**2 - 1, 16) > 15
    assert 4 * (31**2 - 1) == 15 * 256 < 63**2 - 1

    for exponent, residue, nearest in [(3, 3, (-253, 91)), (4, 7, (-345, 87)), (4, 15, (-1, 95))]:
        modulus = 1 << exponent
        values = spectral_values((1, -3), residue, modulus, 127 * modulus)
        assert (max(a for a in values if a < 0), min(a for a in values if a > 0)) == nearest
    assert F(91**2 - 1, 32) > 127
    assert F(127, 87**2 - 1) < F(5, 256)
    assert (127 - 94 * (F(1, 4) - F(1, 256))) / (87**2 - 1) < F(2, 128)
    for semirank in range(1, 10):
        density = (2 - F(2, 1 << semirank)) / 128
        norm_bound = F(1 + (1 << semirank), 2)
        assert 30014 * density - 258 * norm_bound / 256 > 127
    assert 30014 * F(7, 512) - F(258 * 4, 256) > 127

    exceptional_costs = [k * (k - 1) // 2 for k in (-15, -7, 9, 17)]
    assert exceptional_costs == [120, 28, 36, 136]
    assert all(cost % 4 == 0 for cost in exceptional_costs)
    assert 382 < 1 << (23 - 14)
    assert all(d + (23 - d + 3) // 4 >= 17 for d in range(14, 24))
    print("Três perfis CRT em seis controles e todos os limites exatos verificados.")


if __name__ == "__main__":
    main()
