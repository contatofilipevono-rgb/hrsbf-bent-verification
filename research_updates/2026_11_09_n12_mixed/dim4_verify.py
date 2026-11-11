"""Independent phase counting and full-Walsh checks for the dim-four counter."""
import argparse
import json
import struct
from pathlib import Path

from count_near_antipodal import image_and_kernel
from dim4_model import model
from higher_filter import xor_terms
from higher_project import signs_to_walsh
from mobius_rule import integer_anf


def recover(model_columns, target):
    image, _ = image_and_kernel([p for p, _ in model_columns])
    code = 0
    for row, witness in sorted(image, reverse=True):
        if row.bit_length() == target.bit_length():
            target ^= row
            code ^= witness
    assert not target
    return code


def gray_inverse(value):
    result = 0
    while value:
        result ^= value
        value >>= 1
    return result


def split_truth(truth, coordinates):
    moved = sum((truth >> x & 1) << i for i, x in enumerate(coordinates))
    mask = (1 << 256) - 1
    phase = moved & mask
    derivatives = [((moved >> (256 << i)) & mask) ^ phase for i in range(4)]
    mapping = sum(sum((d >> x & 1) << i for i, d in enumerate(derivatives)) << (4 * x)
                  for x in range(256))
    return mapping, phase


def reference_count(mapping, reference, phase_kernel):
    # This path enumerates the residual phases by popcount on the original
    # 256-bit tables. It does not build the counter's quadratic equations.
    from higher_filter import solve
    fibres = [0] * 16
    for x in range(256):
        fibres[mapping >> (4 * x) & 15] |= 1 << x
    assert all(f.bit_count() == 16 for f in fibres)
    equations = []
    for fibre in fibres:
        moments = [fibre] + [sum(1 << x for x in range(256) if fibre >> x & 1 and x >> i & 1)
                              for i in range(8)]
        for i, moment in enumerate(moments):
            rhs = ((reference & moment).bit_count() & 1) ^ (
                (moment.bit_count() // 2 & 1) if i else 0)
            row = sum(((h & moment).bit_count() & 1) << j for j, h in enumerate(phase_kernel))
            equations.append((row, rhs))
    root, free, _ = solve(equations, len(phase_kernel))
    assert root is not None
    phase = reference ^ xor_terms(phase_kernel, root)
    moved = [xor_terms(phase_kernel, f) for f in free]
    count = 0
    for ordinal in range(1 << len(free)):
        if ordinal:
            phase ^= moved[(ordinal & -ordinal).bit_length() - 1]
        if all((phase & f).bit_count() % 4 == 2 for f in fibres):
            count += 1
    return count, len(free)


def controls(space, output):
    _, coordinates, columns, phase_kernel = model(space)
    quadratic = sum(((x & (x >> 6)).bit_count() & 1) << x for x in range(4096))
    sources = [("quadratic", quadratic)]
    witness_file = Path(__file__).with_name("near-antipodal-witnesses.txt")
    if witness_file.exists():
        import base64
        payload = base64.b64decode(witness_file.read_text(encoding="ascii").splitlines()[0])
        labels, phase = payload[:128], int.from_bytes(payload[128:], "little")
        truth = 0
        for x in range(4096):
            a, w = x & 63, x >> 6
            point = (a ^ w) | ((w.bit_count() & 1) << 6)
            truth |= (((phase >> point) ^ (w & labels[point]).bit_count()) & 1) << x
        sources.append(("quartic_U", truth))
    report = []
    for name, truth in sources:
        assert set(map(abs, signs_to_walsh(truth))) == {64}
        p, h = split_truth(truth, coordinates)
        code = recover(columns, p)
        reference = xor_terms([phase for _, phase in columns], code)
        count, dimension = reference_count(p, reference, phase_kernel)
        assert count
        report.append({"name": name, "space": space, "code": code, "ordinal": gray_inverse(code),
                       "functions": count, "residual_phase_dimension": dimension})
    output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


def verify(space, solutions_path):
    _, coordinates, columns, _ = model(space)
    maps = [p for p, _ in columns]
    raw = solutions_path.read_bytes()
    assert len(raw) % 48 == 0
    samples = min(32, len(raw) // 48)
    for j in range(samples):
        offset = (j * (len(raw) // 48 - 1) // max(1, samples - 1)) * 48
        code, count = struct.unpack_from("<QQ", raw, offset)
        phase = int.from_bytes(raw[offset + 16:offset + 48], "little")
        mapping = xor_terms(maps, code)
        truth = 0
        for i, original in enumerate(coordinates):
            x, u = i & 255, i >> 8
            bit = (phase >> x & 1) ^ ((mapping >> (4 * x) & u & 15).bit_count() & 1)
            truth |= bit << original
        assert set(map(abs, signs_to_walsh(truth))) == {64}
        assert max(m.bit_count() for m, c in enumerate(integer_anf(truth)) if c & 1) <= 4
        from higher_filter import shift
        assert all((truth >> x & 1) == (truth >> shift(x, 1) & 1) for x in range(4096))
        assert count > 0
    print({"verified_witnesses": samples, "solution_maps": len(raw) // 48})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=(1, 2), required=True)
    parser.add_argument("--controls", type=Path)
    parser.add_argument("--verify", type=Path)
    args = parser.parse_args()
    if args.controls:
        controls(args.space, args.controls)
    if args.verify:
        verify(args.space, args.verify)


if __name__ == "__main__":
    main()
