"""Construct the 1,280 near-antipodal maps from parameters over F4."""
import argparse
import base64
import itertools
import json
from collections import Counter
from pathlib import Path

from analyse_near_antipodal_phases import phase_rows, plane_fibres
from count_near_antipodal import image_and_kernel, split_pi_and_phase
from higher_filter import solve, xor_terms
from near_antipodal_field import coordinates, mul, square, trace


def inverse(a):
    assert a
    return square(a)


LABELS = {(b.bit_count() & 1, *coordinates(b)[1:]): b for b in range(32)}
ODD_TRIPLES = tuple(
    (a, B, mul(square(mul(a, B)), 1 ^ rho))
    for a, B, rho in itertools.product((1, 2, 3), repeat=3)
    if (trace(inverse(B) ^ inverse(a)) == 1 if rho == 1 else trace(mul(rho, inverse(B))) == 1)
)
assert len(ODD_TRIPLES) == 16


def odd_parameters(epsilon):
    if epsilon:
        for (a, B, C), A in itertools.product(ODD_TRIPLES, range(4)):
            yield a, 0, A, B, C
        return
    for b, a, rho, B in itertools.product((2, 3), range(4), (1, 2, 3), range(4)):
        if trace(mul(square(rho), mul(B, inverse(b))) ^ mul(rho, mul(a, inverse(b)))):
            continue
        C = mul(square(b), 1 ^ rho)
        A = 1 ^ mul(mul(a, B), inverse(b)) ^ mul(C, mul(square(a), b))
        yield a, b, A, B, C


def construct(epsilon, r, j, lam, mu, odd):
    a, b, A, B, C = odd
    output = []
    for x in range(128):
        z = x & 63
        t, u, v = coordinates(z)
        norm = int(u != 0)
        if z.bit_count() & 1:
            c = 1 ^ (epsilon * norm)
            P = mul(a, u) ^ mul(b, v) ^ (t * mul(b, u))
            Q = mul(A, u) ^ mul(B, v) ^ mul(C, mul(square(u), square(v)))
            Q ^= t * (mul(a ^ B ^ C ^ b, u) ^ mul(b, v))
        else:
            eta = (x >> 6) ^ ((z >> 2 ^ z >> 3) & 1)
            c = epsilon * norm
            P = mul(1 ^ ((t ^ j) * (1 ^ r)), u)
            constant = lam ^ (2 * j) ^ (t * (lam ^ mu ^ (2 * (1 ^ epsilon))))
            Q = mul(eta ^ constant, u) ^ mul(1 ^ (t * r), v)
            Q ^= mul(j * (1 ^ r), mul(square(u), square(v)))
        output.append(LABELS[c, P, Q])
    return bytes(output)


def maps():
    for epsilon in (0, 1):
        for r, j, lam, mu in itertools.product((2, 3), range(2), range(2), range(2)):
            if epsilon and not j:
                continue
            for odd in odd_parameters(epsilon):
                yield (epsilon, r, j, lam, mu, *odd), construct(epsilon, r, j, lam, mu, odd)


def kernel_phases():
    def field_parts(z):
        sigma = z.bit_count() & 1
        t, u, v = coordinates(z)
        U, V = int(u != 0), int(v != 0)
        R = trace(mul(u, square(v)))
        T = trace(mul(2, mul(u, square(v))))
        return sigma, t, U, V, R, T

    z_functions = []
    for i in range(12):
        table = 0
        for z in range(64):
            sigma, t, U, V, R, T = field_parts(z)
            k = (1 ^ sigma) * t
            values = (1, sigma, k, U, sigma * U, k * U,
                      R, sigma * R, k * R,
                      (t * U) ^ (sigma * T),
                      (t * R) ^ (sigma * (V ^ T)),
                      (1 ^ U) * V)
            table |= values[i] << z
        z_functions.append(table | (table << 64))
    for i in range(3):
        table = 0
        for x in range(128):
            z = x & 63
            sigma, t, U, V, R, T = field_parts(z)
            eta = (x >> 6) ^ ((z >> 2 ^ z >> 3) & 1)
            values = ((eta * (1 ^ t)),
                      (eta * U) ^ (t * T),
                      (eta * R) ^ (t * (V ^ T)))
            table |= ((1 ^ sigma) * values[i]) << x
        z_functions.append(table)
    return z_functions


def lift_map(mapping, image):
    value = sum(b << (5 * x) for x, b in enumerate(mapping))
    witness = 0
    for row, code in sorted(image, reverse=True):
        if value.bit_length() == row.bit_length():
            value ^= row
            witness ^= code
    assert value == 0
    return witness


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--compare-planes", type=Path)
    parser.add_argument("--witnesses", type=Path)
    args = parser.parse_args()
    pi_basis, kernel = split_pi_and_phase()
    image, dependencies = image_and_kernel([p for p, _ in pi_basis])
    assert not dependencies
    explicit_kernel = kernel_phases()
    assert len(image_and_kernel(explicit_kernel)[0]) == 15
    span, _ = image_and_kernel(kernel)
    for h in explicit_kernel:
        for row, _ in sorted(span, reverse=True):
            if h.bit_length() == row.bit_length():
                h ^= row
        assert not h

    witnesses = []
    collected = set()
    counts = Counter()
    ranks = Counter()
    for parameters, mapping in maps():
        assert mapping not in collected
        collected.add(mapping)
        planes = plane_fibres(mapping)
        code = lift_map(mapping, image)
        phase = xor_terms([h for _, h in pi_basis], code)
        rows = phase_rows(planes, phase, explicit_kernel)
        root, free, _ = solve(rows, 15)
        assert root is not None and len(free) == 13
        if args.witnesses:
            full_phase = phase ^ xor_terms(explicit_kernel, root)
            witnesses.append(base64.b64encode(mapping + full_phase.to_bytes(16, "little")).decode("ascii"))
        counts[parameters[0]] += 1
        for beta in range(32):
            if beta == 0:
                assert rows[beta][0] == 1 << 12
            if beta in (9, 18, 27):
                assert rows[beta][0] == rows[0][0]
        injected = [b for b in range(32) if planes[b][0] ^ 64 not in planes[b]]
        assert len(injected) == 12
        assert len({rows[b][0] for b in injected}) == 1
        ranks[rows[injected[0]][0]] += 1

    if args.compare_planes:
        raw = args.compare_planes.read_bytes()
        catalogue = set()
        for i in range(0, len(raw), 144):
            mapping = raw[i:i + 128]
            phase = int.from_bytes(raw[i + 128:i + 144], "little")
            root, _, _ = solve(phase_rows(plane_fibres(mapping), phase, kernel), 15)
            if root is not None:
                catalogue.add(mapping)
        assert collected == catalogue
    assert dict(counts) == {0: 768, 1: 512}
    result = {"maps_by_epsilon": dict(counts), "maps": len(collected),
              "phases_per_map": 8192, "functions": len(collected) * 8192,
              "explicit_phase_kernel_dimension": 15,
              "injected_fibre_rows": [{"row": row, "maps": n} for row, n in sorted(ranks.items())]}
    if args.witnesses:
        # Forty deterministic samples cover the construction across its ordering.
        chosen = [witnesses[i * (len(witnesses) - 1) // 39] for i in range(40)]
        args.witnesses.write_text("\n".join(chosen) + "\n", encoding="ascii")
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
