"""Exact arithmetic for the residual modulo-127 Walsh addendum."""
from itertools import combinations_with_replacement


def verify_weights():
    expected = {
        -1: (8_287_947, 25_067_776, 8_421_120, 25_067_776),
        1: (8_354_003, 25_132_800, 8_487_168, 25_132_800),
    }
    for sign in (-1, 1):
        mass = 2**24+2**15*sign
        square_mass = 2**30+2**16+2**8*sign
        scaled_t = 127*2**15-128*sign
        assert square_mass-mass == 254*scaled_t
        profile = (
            (126*mass-square_mass+124)//125,
            (126*mass+square_mass)//127,
            mass-2*scaled_t,
            mass+2*scaled_t,
        )
        assert profile == expected[sign]
        assert 0 < profile[2] < profile[3] < 3*2**23
        codimension = 8 if sign == -1 else 9
        assert profile[3] < 3*2**23-2**(24-codimension)
        print(f"s0={sign:+d}: N1={profile[:2]}, wt(C9)={profile[2:]}")


def energy_cost(k):
    numerator = 128*k*k-k
    assert numerator % 127 == 0
    return numerator//127


def verify_dimension_15():
    budget = 33_024
    assert 128*253**2-253 > 127*budget
    exceptions = tuple(k for k in range(-252,253) if k % 127 in (0,1)
                       and k not in (0,1) and energy_cost(k) <= budget)
    assert exceptions == (-127,-126,127,128)
    assert 3*min(map(energy_cost,exceptions)) > budget
    expected = ({32512},{16128,16384},{-256,0,256})
    for count in range(3):
        walsh = set()
        for profile in combinations_with_replacement(exceptions,count):
            ordinary_ones = budget-sum(map(energy_cost,profile))
            if ordinary_ones >= 0:
                walsh.add(ordinary_ones+sum(profile)-512)
        assert walsh == expected[count]
        print(f"{count} exceptions: feasible Walsh coefficients {sorted(walsh)}")
    assert (2**15-32_512)//2 == 128 < 2**11
    assert 3*16_128-256 > 2**15
    assert {2**14-(a+b)//2 for a,b in combinations_with_replacement(
        (16_128,16_384),2)} == {0,128,256}
    assert (2**14-63**2,2**14-64**2,2**14-2*64**2) == (12_415,12_288,8192)


def verify_valuation_26():
    survivors = {(count,union) for count in range(1,11)
                 for union in range(min(26,3*count)+1)
                 if count+26-union <= 9}
    assert survivors == {(9,26)}
    assert 8*3+2 == 26 and 9*3-26 == 1
    print("Dimension 26: only nine monomials covering all coordinates can contribute.")


if __name__ == "__main__":
    verify_weights()
    verify_dimension_15()
    verify_valuation_26()
