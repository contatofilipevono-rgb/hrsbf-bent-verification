"""Certify a coefficient identity excluding two of the nine V3 matrix forms."""
import argparse
import json
from pathlib import Path

from higher_filter import xor_terms
from lower_dim_model import anf, build
from lower_dim_v3_q_classify import NORMAL_FORMS, decompose, normal_form_q, prepare_space


FOURTH_ORBIT = (1 << 15) | (1 << 23) | (1 << 39)
HIGH = sum(1 << i for i in range(64) if i.bit_count() >= 4)


def restricted_anf(h):
    truth = sum(((h >> (9 * x + 64 * u)) & 1) << (x + 8 * u)
                for x in range(8) for u in range(8))
    return anf(truth, 6)


def verify():
    model = build((9, 18, 36))
    space = prepare_space()
    phase_lifts = [h for _, h in model.maps]
    for p, h in model.maps + [(0, h) for h in model.phases]:
        q, _, g = decompose(p)
        coefficient = (restricted_anf(h) >> 15) & 1
        identity = ((g[7] ^ g[21]).bit_count() & 1) ^ ((q >> (3 * (64 + 7) + 1)) & 1)
        assert coefficient == identity
    for h in model.phases:
        assert not restricted_anf(h) & HIGH
    fixed_zero_directions = space.g_directions + [xor_terms(space.q_lifts, code)
                                                for code in NORMAL_FORMS]
    for code in fixed_zero_directions:
        high = restricted_anf(xor_terms(phase_lifts, code)) & HIGH
        assert high in (0, FOURTH_ORBIT)

    cases = []
    for code, (family, power) in NORMAL_FORMS.items():
        q = normal_form_q(family, power)
        assert q == xor_terms(space.q_values, code)
        columns = [((q >> (3 * (64 * k + z))) & 7)
                   for z in range(64) for k in range(3)]
        annihilates_111 = all(columns[3 * z] ^ columns[3 * z + 1] ^ columns[3 * z + 2] == 0
                              for z in range(64))
        assert annihilates_111 == (family in ("zero", "B"))
        forced = None
        if family == "A":
            # At both z=7 and z=21, r=111 and Im Q is the even plane.
            # Since fibre 0 is already full on Phi, sigma(g) equals one there.
            for z in (7, 21):
                image = {0}
                for column in columns[3 * z:3 * z + 3]:
                    image |= {v ^ column for v in list(image)}
                assert image == {0, 3, 5, 6}
            forced = (q >> (3 * (64 + 7) + 1)) & 1
            assert forced == (power != 0)
        cases.append({"q_code": code, "normal_form": [family, power],
                      "affine_in_larger_V1": annihilates_111,
                      "forced_quartic_coefficient": forced})
    return {"coefficient_identity_basis_checks": 60,
            "fixed_zero_high_degree_basis_checks": len(fixed_zero_directions) + len(model.phases),
            "quartic_orbit_masks": [15, 23, 39], "cases": cases,
            "remaining_Q": [351, 315, 56]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    report = verify()
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
