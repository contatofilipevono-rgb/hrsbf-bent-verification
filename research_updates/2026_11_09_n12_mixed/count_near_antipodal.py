"""Count bent quartics affine along the even hyperplane of the diagonal."""
import argparse
import base64
import json
import struct
from time import perf_counter
from collections import Counter
from itertools import combinations
from pathlib import Path

from higher_filter import evaluate_orbit, orbits, shift, solve, xor_terms
from higher_project import LOW, TOP, signs_to_walsh
from mobius_rule import integer_anf


def image_and_kernel(columns):
    pivots = {}
    kernel = []
    for i, value in enumerate(columns):
        code = 1 << i
        while value and (j := value.bit_length()) in pivots:
            old, witness = pivots[j]
            value ^= old
            code ^= witness
        if value:
            pivots[value.bit_length()] = value, code
        else:
            kernel.append(code)
    return list(pivots.values()), kernel


def truth_tables():
    coordinates = []
    for i in range(4096):
        z, s, u = i & 63, i >> 6 & 1, i >> 7
        w = u | ((s ^ (u.bit_count() & 1)) << 5)
        coordinates.append((z ^ w) | (w << 6))
    truth = []
    bad = []
    nonlinear = sum(1 << m for m in range(4096) if (m >> 7).bit_count() >= 2)
    for _, orb in (*orbits(12, 0), *orbits(12, 1), *LOW, *TOP):
        f = evaluate_orbit(orb)
        moved = sum(((f >> x) & 1) << i for i, x in enumerate(coordinates))
        truth.append(moved)
        bad.append(sum((a & 1) << m for m, a in enumerate(integer_anf(moved))) & nonlinear)
    _, kernel = image_and_kernel(bad)
    assert len(kernel) == 46
    return [xor_terms(truth, code) for code in kernel]


def split_pi_and_phase():
    pi, phase = [], []
    points = (1 << 128) - 1
    for table in truth_tables():
        h = table & points
        derivatives = [((table >> (128 * (1 << i))) & points) ^ h for i in range(5)]
        pi.append(sum(((d >> x) & 1) << (5 * x + i)
                      for i, d in enumerate(derivatives) for x in range(128)))
        phase.append(h)
    image, kernel = image_and_kernel(pi)
    assert len(image) == 31 and len(kernel) == 15
    return [(value, xor_terms(phase, code)) for value, code in image], [
        xor_terms(phase, code) for code in kernel]


def all_points(basis):
    output = [0]
    for b in basis:
        output.extend([x ^ b for x in output])
    return output


def rotation_orbits(permutation):
    unused = set(range(len(permutation)))
    while unused:
        x = min(unused)
        orbit = [x]
        while (y := permutation[orbit[-1]]) != x:
            orbit.append(y)
        unused.difference_update(orbit)
        yield orbit


def orbit_assignments():
    def rotate(x):
        z = x & 63
        return shift(z, 1, 6) | (((x >> 6) ^ (z >> 5)) << 6)

    u = [shift((1 << i) | 32, 1, 6) & 31 for i in range(5)]
    transpose = [sum(((b & v).bit_count() & 1) << i for i, v in enumerate(u))
                 for b in range(32)]
    labels = sorted(rotation_orbits([transpose.index(b) for b in range(32)]), key=len)
    powers = [list(range(128))]
    for _ in range(6):
        powers.append([rotate(x) for x in powers[-1]])

    by_length = {length: [] for length in (1, 3, 6)}
    for a, b, c in combinations(range(128), 3):
        d = a ^ b ^ c
        if d <= c:
            continue
        plane = (a, b, c, d)
        for length, candidates in by_length.items():
            power = powers[length]
            if any(power[x] not in plane for x in plane):
                continue
            orbit = tuple(tuple(power[x] for x in plane) for power in powers[:length])
            used = set(x for part in orbit for x in part)
            if len(used) == 4 * length:
                candidates.append((plane, sum(1 << x for x in used), orbit))
    return labels, by_length


def restrict(root, free, equations):
    projected = [(sum(((row & f).bit_count() & 1) << i for i, f in enumerate(free)),
                  bit ^ ((row & root).bit_count() & 1)) for row, bit in equations]
    base, span, _ = solve(projected, len(free))
    if base is None:
        return None, None
    return root ^ xor_terms(free, base), [xor_terms(free, f) for f in span]


def prepare_branches(pi_basis, depth):
    evaluation = [[sum(((v >> (5 * x + j)) & 1) << i
                       for i, (v, _) in enumerate(pi_basis)) for j in range(5)]
                  for x in range(128)]
    q_evals = [a ^ b for z in range(64) for a, b in zip(evaluation[z], evaluation[z + 64])]
    q_cols = [sum((row >> i & 1) << j for j, row in enumerate(q_evals))
              for i in range(len(pi_basis))]
    q_image, _ = image_and_kernel(q_cols)
    assert len(q_image) == 3
    q_space = sorted(all_points([v for v, _ in q_image]))
    label_orbits, candidates = orbit_assignments()
    branches = []
    info = []
    for q_index, q in enumerate(q_space[1:], 1):
        values = tuple(q >> (5 * z) & 31 for z in range(64))
        total = sum(x != 0 for x in values)
        if total % 2:
            info.append({"q_index": q_index, "q_weight": total, "branches": 0, "trials": 0})
            continue
        q_eq = [(row, q >> i & 1) for i, row in enumerate(q_evals)]
        root, free, _ = solve(q_eq, len(pi_basis))
        partial = [(0, 0, root, free)]
        sizes = []
        possible_suffix = [{0} for _ in range(len(label_orbits) + 1)]
        for i in reversed(range(len(label_orbits))):
            suffix = possible_suffix[i + 1]
            possible_suffix[i] = suffix | {k + len(label_orbits[i]) for k in suffix}
        for i, orbit in enumerate(label_orbits[:depth]):
            length = len(orbit)
            eligible = []
            for plane, used, parts in candidates[length]:
                if any(((x ^ 64) in plane) != (values[x & 63] == 0) for x in plane):
                    continue
                assigned = {x: label for label, part in zip(orbit, parts) for x in part}
                if any(assigned[x ^ 64] != label ^ values[x & 63]
                       for x, label in assigned.items() if (x ^ 64) in assigned):
                    continue
                # Equivariance supplies the equations on the remaining planes.
                equations = [(evaluation[x][j], orbit[0] >> j & 1) for x in plane for j in range(5)]
                injective = length if values[plane[0] & 63] else 0
                eligible.append((used, injective, equations))
            current = []
            for used, consumed, root, free in partial:
                for new_used, injective, equations in eligible:
                    used_labels = consumed + injective
                    if used & new_used or total // 2 - used_labels not in possible_suffix[i + 1]:
                        continue
                    moved_root, moved_free = restrict(root, free, equations)
                    if moved_root is not None:
                        current.append((used | new_used, used_labels, moved_root, moved_free))
            partial = current
            sizes.append({"label": orbit[0], "candidates": len(eligible),
                          "branches": len(partial), "trials": sum(1 << len(f) for _, _, _, f in partial)})
            print(q_index, total, sizes[-1], flush=True)
        summary = Counter(len(f) for _, _, _, f in partial)
        branches.extend((q, total, root, free) for _, _, root, free in partial)
        info.append({"q_index": q_index, "q_weight": total, "branches": len(partial), "levels": sizes,
                     "remaining_dimensions": dict(sorted(summary.items())),
                     "trials": sum(n << d for d, n in summary.items())})
    return branches, info, {length: len(planes) for length, planes in candidates.items()}


def solutions_for_phase(fibres, initial, kernel):
    rows = []
    for points in fibres:
        rows.append((sum(((h & points).bit_count() & 1) << j for j, h in enumerate(kernel)),
                     1 ^ ((initial & points).bit_count() & 1)))
    root, free, _ = solve(rows, len(kernel))
    return 0 if root is None else 1 << len(free)


def count_branches(pi_basis, h_kernel, branches):
    stats = {}
    masks = [v for v, _ in pi_basis]
    phases = [h for _, h in pi_basis]
    for q, q_weight, root, free in branches:
        out = stats.setdefault(q, Counter(q_weight=q_weight))
        p = xor_terms(masks, root)
        h = xor_terms(phases, root)
        moved_p = [xor_terms(masks, code) for code in free]
        moved_h = [xor_terms(phases, code) for code in free]
        for word in range(1 << len(free)):
            if word:
                toggle = (word & -word).bit_length() - 1
                p ^= moved_p[toggle]
                h ^= moved_h[toggle]
            out["trials"] += 1
            remaining = p
            sizes = [0] * 32
            parity = [0] * 32
            fibres = [0] * 32
            for x in range(128):
                label = remaining & 31
                remaining >>= 5
                sizes[label] += 1
                if sizes[label] > 4:
                    break
                parity[label] ^= x
                fibres[label] |= 1 << x
            else:
                if any(parity):
                    continue
                assert all(s == 4 for s in sizes)
                out["plane_partitions"] += 1
                n = solutions_for_phase(fibres, h, h_kernel)
                if n:
                    out["maps_admitting_phases"] += 1
                    out["functions"] += n
                    out[f"phase_space_dimension_{n.bit_length() - 1}"] += 1
    return stats


def write_branches(path, pi_basis, h_kernel, branches):
    maps = [v for v, _ in pi_basis]
    phases = [h for _, h in pi_basis]
    q_indices = {q: i for i, q in enumerate(sorted({q for q, _, _, _ in branches}))}
    with path.open("wb") as out:
        out.write(struct.pack("<II", len(branches), len(h_kernel)))
        for h in h_kernel:
            out.write(h.to_bytes(16, "little"))
        for q, weight, root, free in branches:
            out.write(struct.pack("<III", q_indices[q], weight, len(free)))
            for code in [root] + free:
                p = xor_terms(maps, code)
                out.write(bytes(p >> (5 * x) & 31 for x in range(128)))
                out.write(xor_terms(phases, code).to_bytes(16, "little"))


def verify_witnesses(path):
    count = 0
    for line in path.read_text(encoding="ascii").splitlines():
        data = base64.b64decode(line)
        assert len(data) == 144
        labels = data[:128]
        assert all(p < 32 for p in labels)
        assert labels[:64] != labels[64:]
        phase = int.from_bytes(data[128:], "little")
        truth = 0
        for word in range(4096):
            a, w = word & 63, word >> 6
            base = (a ^ w) | ((w.bit_count() & 1) << 6)
            f = (phase >> base) ^ ((w & labels[base]).bit_count())
            truth |= (f & 1) << word
        assert all((truth >> word & 1) == (truth >> shift(word, 1) & 1)
                   for word in range(4096))
        anf = integer_anf(truth)
        assert max(m.bit_count() for m, c in enumerate(anf) if c & 1) == 4
        assert all(abs(a) == 64 for a in signs_to_walsh(truth))
        count += 1
    assert count
    return count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path, nargs="?")
    parser.add_argument("--plan", action="store_true")
    parser.add_argument("--export", type=Path)
    parser.add_argument("--verify-witnesses", type=Path)
    parser.add_argument("--depth", type=int, choices=range(5), default=4)
    args = parser.parse_args()
    if args.verify_witnesses:
        print("Witnesses verified by full Walsh transform:", verify_witnesses(args.verify_witnesses))
        return
    if not args.output:
        parser.error("an output path is required for the count or plan")
    start = perf_counter()
    pi_basis, h_kernel = split_pi_and_phase()
    branches, info, plane_count = prepare_branches(pi_basis, args.depth)
    result = {"orbit_plane_candidates": plane_count, "plan": info}
    print(result, flush=True)
    if args.export:
        write_branches(args.export, pi_basis, h_kernel, branches)
    if not args.plan and not args.export:
        stats = count_branches(pi_basis, h_kernel, branches)
        result["branches"] = sorted(stats.values(), key=lambda row: (row["q_weight"], row["trials"]))
        result["functions"] = sum(row["functions"] for row in stats.values())
        print(result["branches"], "functions", result["functions"], flush=True)
    print(f"{perf_counter() - start:.2f} seconds", flush=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
