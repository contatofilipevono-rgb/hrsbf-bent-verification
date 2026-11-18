"""Finite arithmetic in the normalized p=17, Q=1 exclusion."""

from collections import defaultdict
from fractions import Fraction


def exception_weight(t):
    return t * (9 + 8 * t) // 17


def weighted_profiles(heavy, budget, start=0, profile=()):
    yield budget, profile
    for index in range(start, len(heavy)):
        value = heavy[index]
        excess = value - value % 2
        if excess <= budget:
            yield from weighted_profiles(
                heavy, budget - excess, index, profile + (value,)
            )


def main():
    # For |t| >= 70, t(9+8t)/17 exceeds the larger possible mass.
    assert all(Fraction(t * (9 + 8 * t), 17) > 2176 for t in (-70, 70))
    heavy = tuple(sorted(
        exception_weight(t)
        for t in range(-69, 70)
        if t % 17 in (0, 1) and 1 < exception_weight(t) <= 2176
    ))
    assert heavy == (
        112, 127, 145, 162, 495, 526, 562, 595,
        1150, 1197, 1251, 1300, 2077, 2140,
    )
    print('Possible heavy H values:', heavy)

    enum = {}
    kasami_tokura = {2048 - (1024 >> j) for j in range(10)}
    for mass in (1920, 2176):
        profiles = defaultdict(list)
        for weight, spikes in weighted_profiles(heavy, mass):
            if weight and weight < 2048 and weight not in kasami_tokura:
                continue
            if weight + sum(h**2 - h % 2 for h in spikes) < 128**2:
                continue
            profiles[weight].append(spikes)
        enum[mass] = dict(profiles)
        print(f'Mass {mass}:', {w: len(v) for w, v in sorted(profiles.items())})
    assert set(enum[1920]) == {0, 1024}
    assert set(enum[2176]) == {0, 1024, 1920, 2032, 2050}
    assert enum[2176][1920] == [(112, 145)]
    assert enum[2176][2032] == [(145,)]
    assert enum[2176][2050] == [(127,)]

    assert [h for h in heavy if h % 8 == 0] == [112]
    assert all(mass % 112 for mass in enum)
    assert max(mass // heavy[0] for mass in enum) <= 19
    assert max((mass - 1024) // heavy[0] for mass in enum) <= 10
    assert [h - h % 2 for h in heavy if (h - h % 2) % 16 == 0] == [112, 144]
    assert 2 * (1 << 10) + (1 << 17) < (1 << 20)

    for k in range(5):
        modulus = 256 >> k
        weight = (2048 >> k) + 2
        assert weight >= modulus - 2
        assert (modulus - 2)**2 > weight
        print(f'Hyperplane step {k}: modulus={modulus}, weight={weight}')
    assert (2048 >> 5) + 2 == 66
    print('Normalized Q=1 finite arithmetic verified.')


if __name__ == '__main__':
    main()
