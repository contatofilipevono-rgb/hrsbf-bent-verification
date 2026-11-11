"""Match the F4 parameters to Fable's psi families without a catalogue."""
import argparse
import itertools
import json
from collections import Counter
from pathlib import Path

from construct_near_antipodal_field import construct, maps
from near_antipodal_field import coordinates, mul, square


def psi(mapping):
    result = bytes((b & 7) ^ (b >> 3) for b in mapping[:64])
    assert result == bytes((b & 7) ^ (b >> 3) for b in mapping[64:])
    for y, beta in zip(result, mapping[:64]):
        c = y.bit_count() & 1
        P = (y & 1) ^ (3 * (y >> 1 & 1)) ^ (2 * (y >> 2 & 1))
        assert c == beta.bit_count() & 1
        assert P == coordinates(beta)[1]
    return result


def balanced_odd(epsilon):
    choices = []
    for a, b, A, B, C in itertools.product(range(4), repeat=5):
        if (not a and not b) or (epsilon and b):
            continue
        L = mul(A, b) ^ mul(B, a) ^ mul(C, mul(square(a), square(b)))
        if L and (L ^ square(C)):
            choices.append((a, b, A, B, C))
    assert len(choices) == (108 if epsilon else 540)
    return choices


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--compare-planes", type=Path)
    args = parser.parse_args()
    selected = {mapping for _, mapping in maps()}
    all_maps = set()
    all_psi = Counter()
    selected_psi = Counter()
    even_psi = set()
    odd_choices = [balanced_odd(epsilon) for epsilon in (0, 1)]
    for eps, r, j, lam, mu in itertools.product(range(2), (2, 3), range(2), range(2), range(2)):
        for odd in odd_choices[eps]:
            mapping = construct(eps, r, j, lam, mu, odd)
            assert mapping not in all_maps
            all_maps.add(mapping)
            value = psi(mapping)
            all_psi[value] += 1
            even_psi.add(bytes(value[z] for z in range(64) if not z.bit_count() & 1))
            if mapping in selected:
                selected_psi[value] += 1
    assert len(all_maps) == 10368 and len(all_psi) == 72 and len(even_psi) == 8
    assert set(all_psi.values()) == {144}
    distribution = Counter(selected_psi[value] // 4 for value in all_psi)
    assert distribution == {0: 34, 6: 32, 20: 4, 24: 2}
    if args.compare_planes:
        raw = args.compare_planes.read_bytes()
        observed = {raw[i:i + 128] for i in range(0, len(raw), 144)}
        assert all_maps == observed
    report = {
        "plane_maps": len(all_maps),
        "psi_functions": len(all_psi),
        "even_psi_restrictions": len(even_psi),
        "maps_per_psi": 144,
        "odd_choices_per_psi": 36,
        "s_orientations": 4,
        "families": [
            {"odd_choices_with_phase": n, "psi_functions": count, "maps_with_phase": 4 * n * count}
            for n, count in sorted(distribution.items())
        ],
        "selected_maps": sum(selected_psi.values()),
    }
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
