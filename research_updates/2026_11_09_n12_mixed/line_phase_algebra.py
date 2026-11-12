"""Prove infeasibility of all phase tasks outside the two invariant antipodal planes."""
import argparse
import itertools
import json
from collections import Counter
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import solve, xor_terms
from line_column_collision import collision
from line_column_autocorrelation import exclude_by_autocorrelation
from lower_dim_model import build
from lower_dim_phase_prepare import truth_on_coordinates
from lower_dim_polar_structure import extract_polar
from lower_dim_v3_symbolic import affine_at, echelon, product, read_tasks, substitute
from line_zero_column import early_obstruction, final_obstruction, necessary_spectra

def quadratic_moments(root, directions, moments):
    equations = []
    for subset, mask, residue in moments:
        if mask < 3:
            continue
        base = root & subset
        restricted = [direction & subset for direction in directions]
        assert all(direction.bit_count() % 2 == 0 for direction in restricted)
        row = {0} if ((base.bit_count() ^ residue) & 2) else set()
        for i, direction in enumerate(restricted):
            if ((direction.bit_count() >> 1) ^ (base & direction).bit_count()) & 1:
                row.add(1 << i)
        for i, j in itertools.combinations(range(len(directions)), 2):
            if (restricted[i] & restricted[j]).bit_count() & 1:
                row.add((1 << i) | (1 << j))
        if row:
            equations.append(row)
    return equations


def reduce_phase(root, phases, signature, sig_directions, equations, lift_degree):
    while True:
        d = len(phases)
        rows = echelon(equations)
        if 0 in rows:
            return None
        linear = [q for m, q in rows.items() if m.bit_count() == 1]
        nonlinear = [q for m, q in rows.items() if m.bit_count() > 1]
        if not linear and lift_degree:
            pivot_rows = dict(rows)
            for q in nonlinear:
                degree = max(m.bit_count() for m in q)
                if degree >= lift_degree:
                    continue
                for i in range(d):
                    multiple = set()
                    for m in q:
                        multiple ^= {m | (1 << i)}
                    while multiple:
                        pivot = max(multiple, key=lambda m: (m.bit_count(), m))
                        if pivot not in pivot_rows:
                            pivot_rows[pivot] = multiple
                            break
                        multiple ^= pivot_rows[pivot]
            if 0 in pivot_rows:
                return None
            linear = [q for m, q in pivot_rows.items() if m.bit_count() == 1]
        if not linear:
            return root, phases, signature, sig_directions, nonlinear
        shift, free, _ = solve([(sum(m for m in q if m), int(0 in q)) for q in linear], d)
        assert shift is not None
        root ^= xor_terms(phases, shift)
        signature ^= xor_terms(sig_directions, shift)
        phases = [xor_terms(phases, x) for x in free]
        sig_directions = [xor_terms(sig_directions, x) for x in free]
        equations = substitute(nonlinear, [affine_at(i, shift, free) for i in range(d)])


def locate(image, target):
    code = 0
    for vector, witness in image:
        if target >> (vector.bit_length() - 1) & 1:
            target ^= vector
            code ^= witness
    assert not target
    return code


def signature_possible(signature, directions, properties):
    total = 0
    for subset in range(1 << properties):
        rows = [(sum(((v >> i) & 1) << j for j, v in enumerate(directions)), (signature >> i) & 1)
                for p in range(properties) if subset >> p & 1 for i in range(64*p, 64*p+64)]
        origin, free, _ = solve(rows, len(directions))
        if origin is not None:
            total += (-1 if subset.bit_count() % 2 else 1) * (1 << len(free))
    return total > 0


def mod8_bit(root, directions, support, target):
    """Bit two of weight(root XOR sum x_i directions[i]) minus target."""
    restricted = [h & support for h in directions]

    def imbalance(points):
        return points.bit_count() - 2 * (points & root).bit_count()

    offset = (root & support).bit_count() - target
    assert offset % 2 == 0 and all(x.bit_count() % 2 == 0 for x in restricted)
    entries = [(0, offset // 2)]
    entries.extend((1 << i, imbalance(h) // 2) for i, h in enumerate(restricted))
    for i, j in itertools.combinations(range(len(restricted)), 2):
        overlap = restricted[i] & restricted[j]
        entries.append(((1 << i) | (1 << j), -imbalance(overlap)))
        # The cubic terms have even coefficients after dividing by two.
    result = {m for m, coeff in entries if coeff & 2}
    odd = [m for m, coeff in entries if coeff & 1]
    for a, b in itertools.combinations(odd, 2):
        result ^= {a | b}
    for i, j, k in itertools.combinations(range(len(restricted)), 3):
        if (restricted[i] & restricted[j] & restricted[k]).bit_count() % 2:
            result ^= {(1 << i) | (1 << j) | (1 << k)}
    return result


def check_phases(tasks_path, column_energy=False, column_autocorrelation=False):
    model = build((63,))
    maps = [p for p, _ in model.maps]

    def polar(mapping, phase):
        return extract_polar(model, truth_on_coordinates(mapping, phase, 1))

    details = []
    for code, _, properties, root, signature, directions, moments in read_tasks(tasks_path):
        mapping = xor_terms(maps, code)
        origin_polar = polar(mapping, root)
        image, kernel = image_and_kernel([polar(0, h) for h, _ in directions])
        image = sorted(image, reverse=True)
        phases, signatures = map(list, zip(*directions))
        kernel_phases = [xor_terms(phases, x) for x in kernel]
        kernel_signatures = [xor_terms(signatures, x) for x in kernel]
        polar_cases = sorted(all_points([v for v, _ in image]))
        for displacement in polar_cases:
            representative = locate(image, displacement)
            phase = root ^ xor_terms(phases, representative)
            sig = signature ^ xor_terms(signatures, representative)
            ds, ss = kernel_phases, kernel_signatures
            record = {"map_code": code, "polar": f"{origin_polar ^ displacement:0240x}"}
            details.append(record)
            if not signature_possible(sig, ss, properties):
                record["exclusion"] = "signature"
                continue

            certificate = collision(model, mapping, phase, ds, origin_polar ^ displacement)
            if certificate is not None:
                record["exclusion"] = "column_collision"
                record["column_certificate"] = certificate
                continue

            if column_energy or column_autocorrelation:
                spectra = list(necessary_spectra(model, mapping, phase, ds, origin_polar ^ displacement))
                certificate = early_obstruction(spectra)
                if certificate is not None:
                    record["exclusion"] = "derivative" if "derivative" in certificate else "column_energy"
                    record["energy_certificate"] = certificate
                    continue
                if column_autocorrelation:
                    method, certificate = exclude_by_autocorrelation(model, mapping, phase, ds, spectra)
                    assert method is not None, ("unresolved spectral case", record)
                    record["exclusion"] = method
                    record.update(certificate)
                    continue

            equations = quadratic_moments(phase, ds, moments)
            reduced = reduce_phase(phase, ds, sig, ss, equations, 3)
            if reduced is None:
                record["exclusion"] = "mod4"
                continue
            phase, ds, sig, ss, equations = reduced
            if not signature_possible(sig, ss, properties):
                record["exclusion"] = "signature_after_mod4"
                continue
            record["dimension_mod4"] = len(ds)

            if column_energy:
                certificate = final_obstruction(
                    model, mapping, phase, ds, origin_polar ^ displacement, equations, code
                )
                record["exclusion"] = "zero_column_after_mod4"
                record["energy_certificate"] = certificate
                continue

            equations.extend(mod8_bit(phase, ds, subset, target)
                             for subset, mask, target in moments if mask >= 7)
            reduced = reduce_phase(phase, ds, sig, ss, equations, 4)
            if reduced is None:
                record["exclusion"] = "mod8"
                continue
            raise AssertionError(("unresolved case", record))
        print(code, len(polar_cases), dict(Counter(r["exclusion"] for r in details)), flush=True)
    assert len(details) == 2096 and len({r["map_code"] for r in details}) == 49
    counts = Counter(r["exclusion"] for r in details)
    if column_autocorrelation:
        assert counts == {"signature": 728, "column_collision": 925, "derivative": 413,
                          "column_energy": 5, "joint_energy": 16, "column_autocorrelation": 9}
    elif column_energy:
        assert counts == {"signature": 728, "column_collision": 925, "derivative": 413,
                          "column_energy": 5, "mod4": 7, "zero_column_after_mod4": 18}
    else:
        assert counts == {"signature": 728, "column_collision": 925, "mod4": 388, "mod8": 55}
    return {"task_count":49, "task_polar_pairs":len(details), "excluded":dict(counts),
            "phase_assignments_enumerated":0, "details":details}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tasks", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    method = parser.add_mutually_exclusive_group()
    method.add_argument("--column-energy", action="store_true")
    method.add_argument("--column-autocorrelation", action="store_true")
    args = parser.parse_args()
    report = check_phases(args.tasks, args.column_energy, args.column_autocorrelation)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print({key: value for key, value in report.items() if key != "details"})


if __name__ == "__main__":
    main()
