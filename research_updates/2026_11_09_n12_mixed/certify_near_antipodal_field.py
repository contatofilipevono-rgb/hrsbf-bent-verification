"""Certify the coefficient identities used in the F4 classification."""
import argparse
import itertools
import json
from pathlib import Path

from analyse_near_antipodal_phases import label_action, phase_rows
from construct_near_antipodal_field import construct, kernel_phases, lift_map
from count_near_antipodal import image_and_kernel, split_pi_and_phase
from higher_filter import solve, xor_terms
from near_antipodal_field import ODD, POINTS, PROJECTIVE, coordinates, fit, mul, square, trace


EVEN_POINTS = {
    (coordinates(x & 63)[0], (x >> 6) ^ ((x >> 2 ^ x >> 3) & 1),
     coordinates(x & 63)[1], coordinates(x & 63)[2]): x
    for x in range(128) if not (x & 63).bit_count() & 1
}


def generic_coefficients(mapping):
    even = [
        fit([coordinates(mapping[EVEN_POINTS[t, 0, u, v]])[2] for u, v in PROJECTIVE])
        for t in (0, 1)
    ]
    A, B, C, D, E = even[0]
    F, G, H = [even[0][i] ^ even[1][i] for i in range(3)]
    assert even[0][3:] == even[1][3:]
    assert B in (0, 1) and D in (0, 1)
    assert trace(A ^ C ^ E) == 0
    a = B ^ C ^ D ^ E
    delta = 1 ^ G ^ H
    alpha = mapping[EVEN_POINTS[0, 0, 1, 0]].bit_count() & 1
    gamma = alpha ^ (mapping[EVEN_POINTS[0, 0, 1, 2]].bit_count() & 1)

    signs = [mapping[z].bit_count() & 1 for z in POINTS]
    odd_alpha, odd_beta = signs[1] ^ 1, signs[0] ^ 1
    candidates = [g for g in range(4) if all(
        value == 1 ^ (odd_alpha * int(u != 0)) ^ (odd_beta * int(v != 0))
        ^ trace(mul(g, mul(u, square(v))))
        for (u, v), value in zip(PROJECTIVE, signs))]
    assert len(candidates) == 1
    odd_gamma = candidates[0]
    alpha_1 = trace(F ^ delta)
    gamma_1 = 1 ^ trace(G)
    assert odd_beta == gamma ^ gamma_1
    assert trace(odd_gamma) == alpha ^ alpha_1 ^ gamma ^ gamma_1

    op = fit([coordinates(mapping[z])[1] for z in POINTS])
    oq = fit([coordinates(mapping[z])[2] for z in POINTS])
    oa, ob, oc, od, oe = op
    oA, oB, oC, oD, oE = oq
    assert (oc, od, oe, oD, oE) == (E ^ H, E, 0, D, E)

    for x, label in enumerate(mapping):
        z = x & 63
        t, u, v = coordinates(z)
        norm_u, norm_v = int(u != 0), int(v != 0)
        _, P, Q = coordinates(label)
        uv = mul(square(u), square(v))
        if z.bit_count() & 1:
            scalar = 1 ^ (odd_alpha * norm_u) ^ (odd_beta * norm_v)
            scalar ^= trace(mul(odd_gamma, mul(u, square(v))))
            scalar ^= t * (((odd_beta ^ trace(odd_gamma)) * norm_u)
                           ^ (odd_beta * trace(mul(u, square(v)))))
            assert label.bit_count() & 1 == scalar
            want_p = mul(oa, u) ^ mul(ob, v) ^ mul(oc, uv) ^ mul(od, norm_u * v)
            want_p ^= t * mul(ob ^ oc ^ od, u)
            want_q = mul(oA, u) ^ mul(oB, v) ^ mul(oC, uv) ^ mul(oD, norm_u * v)
            want_q ^= mul(od, norm_v * u)
            want_q ^= t * (mul(oa ^ oB ^ oC ^ oD ^ ob ^ oc, u)
                           ^ mul(ob, v) ^ mul(oc ^ od, uv))
        else:
            eta = (x >> 6) ^ ((z >> 2 ^ z >> 3) & 1)
            want_p = mul(a, u) ^ mul(E, uv ^ (norm_u * v)) ^ (t * mul(delta, u))
            want_q = mul(eta ^ A, u) ^ mul(B, v) ^ mul(C, uv)
            want_q ^= mul(D, norm_u * v) ^ mul(E, norm_v * u)
            want_q ^= t * (mul(F, u) ^ mul(G, v) ^ mul(H, uv))
            scalar = (alpha * norm_u) ^ (gamma * trace(mul(u, square(v))))
            if t:
                scalar = (trace(F ^ delta) * norm_u) ^ (
                    (1 ^ trace(G)) * trace(mul(u, square(v))))
            assert label.bit_count() & 1 == scalar
        assert (P, Q) == (want_p, want_q)
    return A, B, C, D, E, F, G, H


def q24_affine_space(pi_basis):
    values = [p for p, _ in pi_basis]
    evaluation = [[sum((p >> (5 * x + j) & 1) << i for i, p in enumerate(values))
                   for j in range(5)] for x in range(128)]
    prototype = construct(0, 2, 0, 0, 0, (0, 0, 0, 0, 0))
    equations = [(evaluation[z][j] ^ evaluation[z + 64][j],
                  (prototype[z] ^ prototype[z + 64]) >> j & 1)
                 for z in range(64) for j in range(5)]
    equations += [(evaluation[x][j], b >> j & 1)
                  for b, plane in ((0, (0, 63, 64, 127)), (21, (21, 42, 85, 106)))
                  for x in plane for j in range(5)]
    root, free, _ = solve(equations, 31)
    assert root is not None and len(free) == 27
    # Only the affine base and a vector-space basis are needed for the
    # coefficient identities. All identities below are affine in the map.
    for code in [root] + [root ^ v for v in free]:
        p = xor_terms(values, code)
        generic_coefficients(bytes(p >> (5 * x) & 31 for x in range(128)))
    return len(free)


def phase_identities(pi_basis):
    image, _ = image_and_kernel([p for p, _ in pi_basis])
    kernel = kernel_phases()
    cases = 0
    rows_found = set()
    for eps, r, j, lam, mu in itertools.product(range(2), (2, 3), range(2), range(2), range(2)):
        # Test a basis of the ten coefficient directions, not a list of maps.
        for direction in (0,) + tuple(1 << i for i in range(10)):
            odd = tuple(direction >> (2 * i) & 3 for i in range(5))
            mapping = construct(eps, r, j, lam, mu, odd)
            code = lift_map(mapping, image)
            phase = xor_terms([h for _, h in pi_basis], code)
            planes = [[] for _ in range(32)]
            for x, b in enumerate(mapping):
                if not (x & 63).bit_count() & 1:
                    planes[b].append(x)
            occupied = [b for b, p in enumerate(planes) if p]
            assert len(occupied) == 16 and all(len(planes[b]) == 4 for b in occupied)
            phase_row = {}
            for b in occupied:
                mask = sum(1 << x for x in planes[b])
                phase_row[b] = (
                    sum(((mask & h).bit_count() & 1) << k for k, h in enumerate(kernel)),
                    1 ^ ((phase & mask).bit_count() & 1),
                )
            action = label_action()
            assert all(phase_row[action[b]] == phase_row[b] for b in occupied)
            assert phase_row[0][0] == 1 << 12
            for b in (9, 18, 27):
                assert phase_row[b] == phase_row[0]
            a, b = (1, 11) if eps else (3, 5)
            assert phase_row[a][0] == phase_row[b][0]
            assert phase_row[a][1] ^ phase_row[b][1] == (1 ^ (eps * j) ^ trace(odd[1])), (eps, r, j, lam, mu, odd, phase_row[a], phase_row[b])

            c_bit = ((1 ^ j) * (mu ^ (eps * (r & 1)))) ^ (j * (lam ^ eps ^ (r & 1)))
            expected = (1 << 6) | ((1 ^ j) * ((1 << 8) | (1 << 10) | (1 << 12)))
            expected |= (j ^ ((1 ^ j) * (r & 1))) << 13
            expected |= c_bit << 14
            for b in occupied:
                if b not in (0, 9, 18, 27):
                    assert phase_row[b][0] == expected
            rows_found.add(expected)
            cases += 1
    return cases, len(rows_found)



def even_plane_cases():
    """Check the four-point XOR calculations in the necessity argument."""
    retained = {}
    tested = 0
    for eps, C, E, G, H, D, lam, mu in itertools.product(
            range(2), range(4), range(4), (2, 3), range(4), range(2), range(2), range(2)):
        a0 = 1 ^ C ^ D ^ E
        delta = 1 ^ G ^ H
        A = a0 ^ lam
        F = mu ^ (2 * (eps ^ trace(delta)))
        tested += 1
        fibres = {}
        for key, x in EVEN_POINTS.items():
            t, eta, u, v = key
            uv = mul(square(u), square(v))
            P = mul(a0, u) ^ mul(E, uv ^ (int(u != 0) * v)) ^ (t * mul(delta, u))
            Q = mul(eta ^ A, u) ^ v ^ mul(C, uv) ^ mul(D, int(u != 0) * v)
            Q ^= mul(E, int(v != 0) * u) ^ (t * (mul(F, u) ^ mul(G, v) ^ mul(H, uv)))
            label = (eps * int(u != 0), P, Q)
            fibres.setdefault(label, []).append(x)
        if not all(len(p) == 4 and not (p[0] ^ p[1] ^ p[2] ^ p[3]) for p in fibres.values()):
            continue
        # Count zeros of the first odd coordinate on the five C3 orbits.
        # A completion must have exactly one such orbit, for the labels 7.
        possible = False
        for a, b in itertools.product(range(4), repeat=2):
            if eps and (not a or b):
                continue
            zeros = 0
            for u, v in PROJECTIVE:
                P = mul(a, u) ^ mul(b, v) ^ mul(E ^ H, mul(square(u), square(v)))
                P ^= mul(E, int(u != 0) * v)
                zeros += not P
            if zeros == 1:
                possible = True
                break
        if not possible:
            continue
        assert D == E == H == 0
        assert G in (2, 3) and {a0, a0 ^ delta} == {1, G}
        retained[eps] = retained.get(eps, 0) + 1
    assert retained == {0: 16, 1: 16}
    return tested, retained


def odd_phase_cases():
    """Check the field identities against the two-point fibre condition."""
    from construct_near_antipodal_field import LABELS, odd_parameters
    reports = {}
    for eps in (0, 1):
        expected = {
            label for (c, P, _), label in LABELS.items()
            if (P == 0 and c == 1) or (P != 0 and c == (1 ^ eps))
        }
        balanced = 0
        odd_phases = 0
        accepted = set()
        for values in itertools.product(range(4), repeat=5):
            a, b, A, B, C = values
            fibres = {}
            for (t, u, v), z in ODD.items():
                P = mul(a, u) ^ mul(b, v) ^ (t * mul(b, u))
                Q = mul(A, u) ^ mul(B, v) ^ mul(C, mul(square(u), square(v)))
                Q ^= t * (mul(a ^ B ^ C ^ b, u) ^ mul(b, v))
                label = LABELS[1 ^ (eps * int(u != 0)), P, Q]
                fibres.setdefault(label, []).append(z)
            if set(fibres) != expected or any(len(p) != 2 for p in fibres.values()):
                continue
            balanced += 1
            if any(not ((label & (z[0] ^ z[1])).bit_count() & 1)
                   for label, z in fibres.items()):
                continue
            odd_phases += 1
            if not eps and trace(b) != 1:
                continue
            accepted.add(values)
        assert accepted == set(odd_parameters(eps))
        reports[eps] = {"balanced": balanced, "odd_phases": odd_phases, "accepted": len(accepted)}
    assert reports == {0: {"balanced": 540, "odd_phases": 140, "accepted": 48},
                       1: {"balanced": 108, "odd_phases": 64, "accepted": 64}}
    return reports

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    pi_basis, _ = split_pi_and_phase()
    odd_report = odd_phase_cases()
    tested, retained = even_plane_cases()
    dimension = q24_affine_space(pi_basis)
    cases, rows = phase_identities(pi_basis)
    report = {"affine_q24_map_dimension": dimension, "basis_maps_for_generic_identities": dimension + 1,
              "phase_identity_basis_cases": cases, "injected_phase_rows": rows,
              "odd_field_cases": odd_report,
              "even_parameter_cases": tested, "retained_even_parts": retained,
              "generic_coefficient_identities": "verified",
              "even_fibre_phase_identities": "verified"}
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
