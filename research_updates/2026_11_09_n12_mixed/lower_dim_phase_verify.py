"""Check native phase outputs against exact Walsh and a separate phase loop."""
import argparse
import json
import struct
from pathlib import Path

from higher_filter import shift, xor_terms
from higher_project import signs_to_walsh
from lower_dim_model import active_indices, anf, build
from lower_dim_phase_prepare import preceding_spaces, truth_on_coordinates
from lower_dim_plan import BASES


def records(path, nbytes):
    raw = path.read_bytes()
    record_size = nbytes + 16
    assert len(raw) % record_size == 0
    result = {}
    for i in range(0, len(raw), record_size):
        code, count = struct.unpack_from("<QQ", raw, i)
        phase = int.from_bytes(raw[i + 16:i + record_size], "little")
        assert code not in result and count
        result[code] = count, phase
    return result


def verify_walsh(space, output):
    model = build(BASES[space - 1])
    r = len(model.basis)
    selected = list(output)
    if len(selected) > 24:
        selected = [selected[i * (len(selected) - 1) // 23] for i in range(24)]
    maps = [p for p, _ in model.maps]
    preceding = preceding_spaces(space)
    for code in selected:
        _, phase = output[code]
        mapping = xor_terms(maps, code)
        moved = truth_on_coordinates(mapping, phase, r)
        truth = sum(1 << model.coordinates[x] for x in active_indices(moved))
        assert set(map(abs, signs_to_walsh(truth))) == {64}
        assert max(m.bit_count() for m in active_indices(anf(truth, 12))) == 4
        assert all((truth >> x & 1) == (truth >> shift(x, 1) & 1) for x in range(4096))
        for basis in [model.basis] + preceding:
            # Directly evaluate mixed derivatives at all points until the first
            # nonzero value. This check uses the original 12 coordinates.
            affine = True
            for i, u in enumerate(basis):
                a = u | (u << 6)
                for v in basis[:i]:
                    b = v | (v << 6)
                    if any((truth >> x ^ truth >> (x ^ a) ^ truth >> (x ^ b)
                            ^ truth >> (x ^ a ^ b)) & 1 for x in range(4096)):
                        affine = False
                        break
                if not affine:
                    break
            assert affine == (basis == model.basis)
    return len(selected)


def verify_small_tasks(path, output, deferred):
    checked = 0
    with path.open("rb") as f:
        assert f.read(8) == b"PHS3451\0"
        _, words, nprop, _ = struct.unpack("<4I", f.read(16))
        nbytes = 8 * words
        while (header := f.read(20)) and checked < 12:
            code, dimension, factor, moments = struct.unpack("<QIII", header)
            if dimension > 13 or code in deferred:
                f.seek((1 + dimension) * (nbytes + 8 * nprop) + moments * (nbytes + 2), 1)
                continue
            root = int.from_bytes(f.read(nbytes), "little")
            signature = int.from_bytes(f.read(8 * nprop), "little")
            directions = [(int.from_bytes(f.read(nbytes), "little"),
                           int.from_bytes(f.read(8 * nprop), "little")) for _ in range(dimension)]
            conditions = [(int.from_bytes(f.read(nbytes), "little"), *f.read(2))
                          for _ in range(moments)]
            count = 0
            for word in range(1 << dimension):
                if word:
                    h, s = directions[(word & -word).bit_length() - 1]
                    root ^= h
                    signature ^= s
                if any(not (signature >> (64 * i) & ((1 << 64) - 1)) for i in range(nprop)):
                    continue
                if all(((root & subset).bit_count() & mask) == rhs for subset, mask, rhs in conditions):
                    count += 1
            assert (count << factor) == output.get(code, (0, 0))[0]
            checked += 1
    return checked


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tasks", type=Path, required=True)
    parser.add_argument("--prefix", type=Path, required=True)
    args = parser.parse_args()
    report = json.loads(args.prefix.with_suffix(".json").read_text())
    space = report["space"]
    nbytes = 1 << (9 - len(BASES[space - 1]))
    output = records(args.prefix.with_suffix(".witnesses.bin"), nbytes)
    raw = args.prefix.with_suffix(".deferred.bin").read_bytes()
    deferred = {code for code, in struct.iter_unpack("<Q", raw)}
    assert len(output) == report["maps"] and len(deferred) == report["deferred"]
    assert sum(v[0] for v in output.values()) == report["functions"]
    assert len(output.keys() & deferred) == 0
    print({"walsh_checks": verify_walsh(space, output),
           "independent_phase_counts": verify_small_tasks(args.tasks, output, deferred),
           "functions": report["functions"]})


if __name__ == "__main__":
    main()
