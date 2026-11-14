"""Check coverage and replay selected certificates in the n=12 model."""
import argparse
import json
import random
import sys
from collections import Counter
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
MODEL = HERE.parent / "piloto-gauss-real" / "inputs_model"
if not MODEL.exists():
    MODEL = HERE.parent.parent / "fable_planos_pfaffiano"
sys.path.insert(0, str(MODEL))
from base12 import PAIRS, pack
from bitj import load_model, solve_affine, table_at
from poisson3 import eq3
from poisson3_lista import todos_subespacos3
from poisson5 import Bv_table, equacoes
from certifica import constant_mod32

Z = np.arange(64)
PARITY = np.array([i.bit_count() & 1 for i in Z.tolist()], dtype=np.uint8)


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def polar_array(encoded):
    value = int(encoded, 16)
    return np.array([[(value >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)


def representative(polar, generators, pivots):
    remainder = pack(polar)
    coordinates = 0
    while remainder:
        row, combination = pivots[remainder.bit_length() - 1]
        remainder ^= row
        coordinates ^= combination
    return table_at(np.zeros((64, 64), np.uint8), generators, coordinates), coordinates


def affine_part(table):
    linear = sum((table[:, 1 << j] ^ table[:, 0]).astype(np.uint8) << j for j in range(6))
    assert np.array_equal(table, table[:, :1] ^ PARITY[linear[:, None] & Z[None, :]])
    return linear


def character_rows(polar, table, directions):
    images = Bv_table(polar)
    expected = table[:, :1] ^ PARITY[
        sum((table[:, 1 << j] ^ table[:, 0]).astype(np.uint8) << j for j in range(6))[:, None] & Z[None, :]
    ]
    for k, (i, j) in enumerate(PAIRS):
        expected ^= polar[k, :, None] * (((Z >> i) & (Z >> j) & 1).astype(np.uint8))
    assert np.array_equal(expected, table)
    delta = table ^ table[:, :1]
    direction_masks = [affine_part(v) for v in directions]
    forms = np.zeros((64, 64), dtype=np.uint64)
    for i, linear in enumerate(direction_masks):
        forms |= (PARITY[linear[:, None] & Z[None, :]].astype(np.uint64) << i)
    return {
        d: [(z, int(forms[z, d]), int(delta[z, d])) for z in np.flatnonzero(images[:, d] == 0)]
        for d in range(64)
    }


def restrict(terms, part, kernel):
    return [
        (z, sum(((form & v).bit_count() & 1) << i for i, v in enumerate(kernel)), sign ^ ((form & part).bit_count() & 1))
        for z, form, sign in terms
    ]


def check_certificate(record, rows, dimension):
    level = record["level"]
    if level == "odd":
        assert len(rows[record["witness_d"]]) % 2 == 1
        return
    parity_equations = []
    for d in range(1, 64):
        terms = rows[d]
        assert len(terms) % 2 == 0
        coefficient, constant = 0, len(terms) // 2 % 2
        for _, form, sign in terms:
            coefficient ^= form
            constant ^= sign
        parity_equations.append((coefficient, constant))
    solution = solve_affine(parity_equations, dimension)
    if level == "mod4":
        assert solution is None
        return
    assert solution is not None
    part, kernel = solution
    if level == "forced":
        column = record["column"]
        sizes = Counter()
        inactive_or_variable = set()
        for d, terms in rows.items():
            for z, form, sign in restrict(terms, part, kernel):
                sizes[z] += 1
                if form or (sign ^ ((d & column).bit_count() & 1)):
                    inactive_or_variable.add(z)
        forced = sorted(set(sizes) - inactive_or_variable)
        total = 64 * sum(sizes[z] for z in forced)
        assert forced == record["forced_rows"] and total == record["max_forced_sum"] and total > 4096
        return
    modulus = int(level[3:])
    weights = Counter()
    for _, form, sign in restrict(rows[record["witness_d"]], part, kernel):
        weights[form] += 1 - 2 * sign
    scaled = {form: count * (64 // modulus) for form, count in weights.items() if count}
    assert all(count % 2 == 0 for count in scaled.values())
    constant, _ = constant_mod32({form: count // 2 for form, count in scaled.items()})
    assert constant and sum(weights.values()) % modulus == record["cert"]["residue"] != 0


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("--per-level", type=int, default=3)
    parser.add_argument("--l5-probes", type=int, default=48)
    parser.add_argument("--all-forced", action="store_true")
    args = parser.parse_args()
    names = ["certificados_autocorr.json", "certificados_autocorr_340.json", "certificados_forcado_20.json"]
    certificates = [r for name in names for r in read_json(args.source / name) if r["level"] != "open"]
    samples = {}
    for r in certificates:
        samples.setdefault(r["level"], []).append(r)
    rng = random.Random(1214)
    polars, generators, affine_directions, pivots = load_model()
    phase_dimension = len(affine_directions)
    subspaces = todos_subespacos3()
    checked = Counter()
    for level, records in samples.items():
        subset = records if args.per_level == 0 or (level == "forced" and args.all_forced) else rng.sample(records, min(args.per_level, len(records)))
        for record in subset:
            polar = polar_array(record["polar"])
            base, _ = representative(polar, generators, pivots)
            image = Bv_table(polar)
            solution = solve_affine(equacoes(image, base, affine_directions) + eq3(image, base, affine_directions, subspaces), phase_dimension)
            assert solution is not None
            part, kernel = solution
            assert part == int(record["part"], 16) and kernel == [int(v, 16) for v in record["ker"]]
            evaluated = table_at(base, affine_directions, part)
            directions = [table_at(np.zeros_like(base), affine_directions, v) for v in kernel]
            check_certificate(record, character_rows(polar, evaluated, directions), len(kernel))
            checked[level] += 1
    probes = [(1 << i) for i in range(len(polars))]
    probes += [sum(1 << i for i in rng.sample(range(len(polars)), 2)) for _ in range(args.l5_probes)]
    w_masks = [sum(1 << i for i in ix) for ix in ((4, 5, 6, 7, 8, 9, 22), (21, 23, 24))]
    counterexamples = []
    for c in sorted(set(probes)):
        expression = [((c & mask).bit_count() & 1) for mask in w_masks]
        if not any(expression):
            continue
        indices = [i for i in range(len(polars)) if c >> i & 1]
        polar = np.bitwise_xor.reduce([polars[i] for i in indices], axis=0)
        base = table_at(np.zeros((64, 64), np.uint8), generators, c)
        solution = solve_affine(equacoes(Bv_table(polar), base, affine_directions), phase_dimension)
        if solution is not None:
            counterexamples.append({"coordinates": indices, "W_forms": expression, "particular": hex(solution[0])})
    result = {"replay": dict(checked), "l5_only_outside_W": counterexamples,
              "l5_candidate_masks": len(set(probes))}
    (HERE / "audita_cobertura.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
