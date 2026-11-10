"""Replay the finite identities in the n=12 period-four note."""

from itertools import product


def require(condition, description):
    if not condition:
        raise RuntimeError(description)


def rotate(x, size, shift):
    return ((x << shift) | (x >> (size - shift))) & ((1 << size) - 1)


def orbit_partition(size, shift):
    unseen = set(range(1 << size))
    orbits = []
    while unseen:
        start = min(unseen)
        orbit = [start]
        y = rotate(start, size, shift)
        while y != start:
            orbit.append(y)
            y = rotate(y, size, shift)
        unseen.difference_update(orbit)
        orbits.append(tuple(orbit))
    return orbits


def character(u, x):
    return 1 - 2 * ((u & x).bit_count() % 2)


def walsh(values):
    result = [1 - 2 * v for v in values]
    step = 1
    while step < len(result):
        for start in range(0, len(result), 2 * step):
            for i in range(start, start + step):
                left, right = result[i], result[i + step]
                result[i], result[i + step] = left + right, left - right
        step *= 2
    return result


def main():
    orbits = orbit_partition(4, 1)
    reps = tuple(min(orbit) for orbit in orbits)
    require(reps == (0, 1, 3, 5, 7, 15), "Wrong period-four orbits")
    matrix = tuple(
        tuple(sum(character(u, x) for x in orbit) for orbit in orbits)
        for u in reps
    )
    require(matrix == (
        (1, 4, 4, 2, 4, 1),
        (1, 2, 0, 0, -2, -1),
        (1, 0, 0, -2, 0, 1),
        (1, 0, -4, 2, 0, 1),
        (1, -2, 0, 0, 2, -1),
        (1, -4, 4, 2, -4, 1),
    ), "Incorrect orbit-character matrix")

    zero_diagonal = admissible = 0
    for bits in product((0, 1), repeat=len(orbits)):
        table = [0] * 16
        for orbit, bit in zip(orbits, bits):
            for x in orbit:
                table[x] = bit
        spectrum = walsh(table)
        signs = [1 - 2 * b for b in bits]
        for u, row in zip(reps, matrix):
            require(spectrum[u] == sum(a * b for a, b in zip(row, signs)),
                    "Orbit Walsh sum differs from the transform")
        if not any(table[x] for x in (0, 5, 10, 15)):
            zero_diagonal += 1
            require(spectrum[3] == 0, "Adjacent Walsh coefficient was nonzero")
        if all(w % 3 != 0 for w in spectrum):
            admissible += 1
            require(spectrum[0] * spectrum[15] % 3 ==
                    (1 - 2 * (table[0] ^ table[15])) % 3,
                    "Admissible period-four sign relation failed")
    require(zero_diagonal == 8 and admissible == 16, "Unexpected table counts")

    orbits_12 = orbit_partition(12, 4)
    fixed = {orbit[0] for orbit in orbits_12 if len(orbit) == 1}
    expected = {x | (x << 4) | (x << 8) for x in range(16)}
    require(fixed == expected, "Wrong fixed points")
    require(sum(len(orbit) == 3 for orbit in orbits_12) == 1360,
            "Wrong number of nonfixed orbits")
    for u in range(16):
        frequency = u | (u << 4) | (u << 8)
        require(all(len({character(frequency, x) for x in orbit}) == 1
                    for orbit in orbits_12), "Character not orbit-invariant")

    q = [((x & 63) & (x >> 6)).bit_count() % 2 for x in range(1 << 12)]
    require(all(q[x] == q[rotate(x, 12, 1)] for x in range(len(q))),
            "Quadratic control is not rotation-symmetric")
    spectrum_q = walsh(q)
    require(all(abs(w) == 64 for w in spectrum_q), "Quadratic control is not bent")
    spectrum_g = walsh([q[x | (x << 4) | (x << 8)] for x in range(16)])
    require(all((spectrum_q[u | (u << 4) | (u << 8)] - spectrum_g[u]) % 3 == 0
                for u in range(16)), "Period-four congruence failed on the control")

    print("PASS: 6 orbit rows, 64 tables, 8 diagonal-zero tables, "
          "16 modularly admissible tables.")
    print("PASS: 16 fixed points, 1360 orbits of length 3, "
          "16 lifted characters and 4096 quadratic-control Walsh coefficients.")


if __name__ == "__main__":
    main()
