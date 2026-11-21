"""Checks the rational bounds and finite profiles used in the modulo 127 audit."""
from fractions import Fraction as F
from itertools import combinations


def verify_cantelli():
    lower, upper = F(43, 20), F(72, 25)
    floor_half = F(383, 2048)
    b = [F(1,8), F(7,32), F(1,4), F(37,128), F(8,25), F(177,512)]
    b6 = min((F(1,2)-F(1,2**(r+1)))/2
             + b[6-r]/2**r
             + (2**r-1)*b[6-r-1]/2**(r+1) for r in (1,2,3))
    assert b6 == F(373,1024)
    assert F(127,128)*F(15,32) > 2*b6*(1-b6)
    assert upper < 8*b6
    for w0, w1 in ((F(55,256), F(218,1000)), (F(218,1000), F(221,1000))):
        mean0, mean1 = (16*w*(1-w) for w in (w0,w1))
        var_upper = 256*(w1-floor_half)**2*w1*(1-w1)
        margin = (mean0-lower)*(upper-mean1) - var_upper
        assert lower < mean0 < mean1 < upper
        assert margin > F(2155,100000)
        print("Cantelli interval and positive margin:", w0, w1, margin)


def verify_exterior_blocks():
    # A block with l complete pairs acts by adding two unused complete pairs.
    # For degree <= 3, l is 0 or 1. Only l=1 needs a rank check.
    for h in range(5, 17):
        for simple_pairs in range(4):
            available = h-simple_pairs
            assert available >= 2
            if simple_pairs > 1:
                continue
            assert available >= 4
            basis = {}
            for triple in combinations(range(available), 3):
                row = sum(1 << index for index in triple)
                while row:
                    pivot = row.bit_length()-1
                    if pivot not in basis:
                        basis[pivot] = row
                        break
                    row ^= basis[pivot]
            assert len(basis) == available
    print("Exterior incidence blocks: injective for h = 5,...,16.")


def energy_cost(k):
    result = F(128*k*k-k, 127)
    assert result.denominator == 1
    return result.numerator


def verify_unit_fiber_profiles():
    dimension = 16
    budget = (1 << (dimension-9))*129
    minimum = energy_cost(-126)
    assert 2*minimum > budget
    assert (128*253**2-253) > 127*budget
    allowed = [k for k in range(-252, 253) if k % 127 in (0, 1)
               and k not in (0, 1) and energy_cost(k) <= budget]
    assert allowed == [-127, -126, 127, 128]
    profiles = [(None, budget, budget, 2*(budget-256))]
    for k in allowed:
        ordinary_ones = budget-energy_cost(k)
        mass = ordinary_ones+k
        profiles.append((k, ordinary_ones, mass, 2*(mass-256)))
    assert profiles == [
        (None, 16512, 16512, 32512),
        (-127, 255, 128, -256),
        (-126, 510, 384, 256),
        (127, 257, 384, 256),
        (128, 0, 128, -256),
    ]
    for row in profiles:
        print("exception, ordinary ones, mass of k, W_restriction:", row)


def crt_minimum(step, residue, second_modulus, second_residues, vertex, cost):
    candidates = []
    for second_residue in second_residues:
        shift = (second_residue-residue)*pow(step, -1, second_modulus)
        base = residue+step*(shift % second_modulus)
        period = step*second_modulus
        index = (vertex-base)//period
        candidates.extend(base+period*k for k in (index, index+1))
    return min(map(cost,candidates))


def verify_g2():
    squared_mass_max = (1 << 30)+(1 << 16)+(1 << 8)
    ones_lower = min(F(126*((1 << 24)+s*(1 << 15))
                       - ((1 << 30)+(1 << 16)+s*(1 << 8)),125)
                     for s in (-1,1))
    assert ones_lower >= 8_220_000
    for codimension in (2,3,4):
        budget = squared_mass_max-8_220_000-128*((1 << (24-codimension))-(1 << 15))
        for j in range(10,16):
            minimum = crt_minimum(1 << (j-8), 1 << (j-9),127,(0,1),64,
                                  lambda k: k*k-128*k)
            distance = 1 << (32-codimension-(4*j)//3)
            assert minimum*distance > budget
    print("G2: all 18 exact CRT minima beat their square-mass budgets.")


def verify_section9_and_f2():
    M,p = 256,127
    w = F(255,2048)
    budget9 = 2-16*w + (64*w-4)/M + F(64,M*M)
    assert budget9 < F(243,10000)
    assert 4+F(16*M-64,2048)+F(1,4) == F(199,32) < F(249,40)
    for j, degree in ((5,7),(6,8),(7,10)):
        point_costs = [crt_minimum(1 << (j+1), r+(1 << j),p,(2,-2),2*p,
                                   lambda y:(y-r)*(y+r-4*p)) for r in (-2,-506)]
        assert F(min(point_costs),4*p*M*(1 << degree)) > budget9
    for j in (5,6,7,8):
        min_sq = min(crt_minimum(1 << (j+1), r+(1 << j),p,(2,-2),0,
                                 lambda x:x*x) for r in (-760,760))
        assert F(min_sq-760**2,M*M*(1 << ((4*j)//3))) > F(191,1024)
    assert F(760,256)-F(1,4) > F(191,4064)
    print("Section 9 and F2: exact progression minima and strict margins.")


def verify_three_control_valuation():
    possible = [
        (count, size)
        for count in range(1, 45)
        for size in range(1, min(28, 2*count)+1)
        if max(13+count-size, count+(28-size+3)//4) < 10
    ]
    assert possible == [(4, 8)]
    for a in range(1, 5):
        for b in range(1, 5-a):
            for c in range(1, 5-a-b):
                assert min(a,b,c) == 1
    print("Three controls: the only valuation-nine contribution has four disjoint pairs.")


def verify_four_products_valuation():
    for chosen in range(5):
        uncovered = 32-4*chosen
        threshold = (uncovered+2)//3
        assert chosen+threshold >= 10
        assert all(chosen+extra+max(0,uncovered-3*extra) >= 10
                   for extra in range(threshold+1))
    print("Up to four products: every sign-sum term is divisible by 1024.")


if __name__ == "__main__":
    verify_cantelli()
    verify_exterior_blocks()
    verify_unit_fiber_profiles()
    verify_g2()
    verify_section9_and_f2()
    verify_three_control_valuation()
    verify_four_products_valuation()
