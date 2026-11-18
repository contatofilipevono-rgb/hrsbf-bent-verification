"""Verify elementary residue classes and exact energy thresholds for p=17."""
from fractions import Fraction
from math import isqrt


def verify_lattice():
    window = range(-2048, 2049)
    roots_by_bit = ((2, 66), (-70, 138))
    for bit, roots in enumerate(roots_by_bit):
        lower, upper = roots
        residues = [
            y for y in window if y % 17 in (2, 15) and y % 16 == 2 + 8*bit
        ]
        assert set(y % 272 for y in residues) == {lower % 272, upper % 272}
        assert not any(lower < y < upper for y in residues)
        assert min(y*y for y in residues) == 4 + 4896*bit
        assert (lower + upper, lower*upper) == (68, 132 - 9792*bit)
    assert min(abs(x) for x in window if x % 4 == 0 and x % 17 in (2, 15)) == 32


def verify_bounds():
    exact = {
        h: min(Fraction(5, 24), (17 + Fraction(2**h, 32)) / 144)
        for h in range(11)
    }
    assert all(exact[h] < Fraction(1, 8) for h in range(5))
    assert [exact[h] for h in range(5, 9)] == [
        Fraction(1, 8), Fraction(19, 144), Fraction(7, 48), Fraction(25, 144)
    ]
    assert all(exact[h] < Fraction(5, 32) for h in range(5, 8))
    assert isqrt(2**10) == 32
    assert Fraction(9792 * 1024, 17 * 2 * 2**20) == Fraction(9, 32)
    for s_over_16 in range(-64, 65):
        for ac_over_4352 in range(-256, 257):
            w = Fraction(32 * (64 * s_over_16 - 256 * ac_over_4352), 9)
            if w.denominator == 1:
                assert w % 2048 == 0
                if s_over_16 == 0:
                    assert w % 8192 == 0




def binary_rank(rows):
    pivots = {}
    for row in rows:
        while row:
            pivot = row.bit_length() - 1
            if pivot not in pivots:
                pivots[pivot] = row
                break
            row ^= pivots[pivot]
    return len(pivots)


def is_union_of_pairs(mask, pairs):
    return all((mask >> (2*i)) & 3 in (0, 3) for i in range(pairs))


def verify_moments_and_post18():
    for n, expected in ((8, 8), (10, 44), (12, 208), (14, 910)):
        pairs = n // 2
        degree = (n - 6) // 2
        labels = [i for i in range(1 << n) if i.bit_count() == degree]
        rows = [
            sum(1 << j for j, b in enumerate(labels)
                if not a & b and is_union_of_pairs(a | b, pairs))
            for a in labels
        ]
        assert binary_rank(rows) == expected

    def contribution(n, points, c):
        return Fraction(56576 * points, 2**(n+c))

    c2 = contribution(12, 364, 2)
    c3 = contribution(12, 364, 3)
    c4 = contribution(10, 66, 4)
    c5 = contribution(8, 10, 5)
    assert [c2, c3, c4, c5] == [
        Fraction(20111, 16), Fraction(20111, 32), Fraction(7293, 32), Fraction(1105, 16)
    ]
    assert c2 > 1020
    assert Fraction(2244 - c3, 9792) == Fraction(3041, 18432)
    assert Fraction(43, 256) > Fraction(3041, 18432)
    assert c3 * Fraction(15, 8) > 714
    assert c3 + c4 > Fraction(1275, 2)
    assert c3 > 561
    assert (c5 * Fraction(7, 4)) / Fraction(3, 32) == Fraction(15470, 12)
    assert c5 / Fraction(1, 32) >= Fraction(15470, 12)
    for w in (Fraction(11, 64), Fraction(23, 128)):
        assert c4 + Fraction(15470, 12) * (Fraction(105, 32) - 16*w) > 2244 - 9792*w

    assert Fraction(25, 144) < Fraction(23, 128)
    assert contribution(6, 1, 2) > 204
    assert contribution(8, 10, 2) > 476
    assert contribution(8, 10, 3) > 170
    assert contribution(6, 1, 4) > 17
    assert min((y-2)*(y-66) for y in range(-1024,1025)
               if y % 544 in ((-206) % 544, (-270) % 544)) == 56576


    assert (1972 // 68, 9792 // 68) == (29, 144)
    for w in (Fraction(23, 128), Fraction(47, 256)):
        upper = 1972 - 9792*w
        assert c3 > upper
        assert c4 + Fraction(15470, 12) * (Fraction(105, 32) - 16*w) > upper
        assert c5 + Fraction(1547, 6) * (Fraction(217, 32) - 32*w) > upper

    post20_c2 = contribution(14, 1820, 2)
    post20_c3 = contribution(14, 1820, 3)
    post20_c4 = contribution(12, 364, 4)
    post20_c5 = contribution(10, 66, 5)
    assert post20_c2 == Fraction(100555, 64) > 1564
    assert post20_c3 + Fraction(7,4)*post20_c4 > 1258
    assert post20_c3 + 2*post20_c4 > 1258
    assert (Fraction(7,4)*post20_c5) / Fraction(3,32) == Fraction(17017,8)
    assert post20_c5 / Fraction(1,32) >= Fraction(17017,8)
    for w in (Fraction(11,64), Fraction(23,128)):
        assert post20_c4 + Fraction(17017,8)*(Fraction(105,32) - 16*w) > 2788 - 9792*w


    post20_c6 = contribution(8, 10, 6)
    post20_c7 = contribution(6, 1, 7)
    assert (Fraction(7,4)*post20_c6) / Fraction(1,8) == Fraction(7735,16)
    assert post20_c6 / Fraction(1,16) >= Fraction(7735,16)
    assert Fraction(49,16)*post20_c7 / Fraction(1,32) >= Fraction(7735,16)
    assert Fraction(47,256) < Fraction(3,16)
    for w in (Fraction(23,128), Fraction(47,256)):
        upper = 2788 - 9792*w
        assert post20_c4 + Fraction(17017,8)*(Fraction(105,32) - 16*w) > upper
        assert post20_c5 + Fraction(7735,16)*(Fraction(31,4) - 32*w) > upper


if __name__ == "__main__":
    verify_lattice()
    verify_bounds()
    verify_moments_and_post18()
    print("PASS: CRT, moment ranks, weight bounds, energy comparisons and saturation divisibility.")
