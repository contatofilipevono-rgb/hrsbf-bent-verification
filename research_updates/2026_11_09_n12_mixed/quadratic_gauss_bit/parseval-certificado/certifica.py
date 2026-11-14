"""A short character-coefficient certificate for Parseval obstructions.

It does not enumerate the affine parameter space.  It groups at most 4096
radical characters and proves a residue identity by a linear XOR relation
or integer coefficients of degree at most four.
"""
import collections
import itertools
import json
from pathlib import Path
import sys

import numpy as np

HERE = Path(__file__).resolve().parent
MODEL = HERE.parent / "piloto-gauss-real" / "inputs_model"
if not (MODEL / "base12.py").exists():
    MODEL = HERE.parent.parent / "fable_planos_pfaffiano"
sys.path.insert(0, str(MODEL))
import base12
import bitj
import poisson5
import poisson3
import poisson3_lista


def constant_mod32(weights):
    """Coefficient proof of constancy, with a linear shortcut when available."""
    divisible8 = all(value % 8 == 0 for form, value in weights.items() if form)
    xor_form = 0
    if divisible8:
        for form, value in weights.items():
            if form and (value // 8) & 1:
                xor_form ^= form
        if xor_form == 0:
            return True, {"method": "weights divisible8; one XOR relation", "xor_form": "0x0"}
    # Work in independent linear characters, not in all m original parameters.
    basis = {}
    for form in weights:
        x = form
        while x:
            h = x.bit_length() - 1
            if h in basis:
                x ^= basis[h][0]
            else:
                basis[h] = (x, 1 << len(basis))
                break
    reduced = {}
    for form, value in weights.items():
        x, combination = form, 0
        while x:
            h = x.bit_length() - 1
            x ^= basis[h][0]
            combination ^= basis[h][1]
        reduced[combination] = value
    nonconstant = [abs(value) for form, value in reduced.items() if form]
    order = min(((value & -value).bit_length() - 1 for value in nonconstant), default=5)
    max_degree = min(len(basis), max(0, 4 - order))
    checks = 0
    for degree in range(1, max_degree + 1):
        for indices in itertools.combinations(range(len(basis)), degree):
            mask = sum(1 << j for j in indices)
            value = sum(coefficient for form, coefficient in reduced.items() if form & mask == mask)
            checks += 1
            if (value * (1 << degree)) % 32:
                return False, {"method": "integer ANF coefficient check", "character_dimension": len(basis),
                               "checked": checks, "failed_monomial": hex(mask), "degree": degree}
    return True, {"method": "integer ANF coefficient check", "character_dimension": len(basis),
                  "maximum_degree_needed": max_degree, "checked": checks}


def certify(G, directions, label):
    m = len(directions)
    directions = np.array(directions, dtype=np.uint8)
    par = np.array([x.bit_count() & 1 for x in range(64)], dtype=np.uint8)
    hd = directions[:, :, 0]
    ld = sum(((directions[:, :, 1 << j] ^ hd) << j) for j in range(6))
    assert np.array_equal(directions, hd[:, :, None] ^ par[ld[:, :, None] & np.arange(64)])
    weights = collections.Counter()
    radical_size = 0
    ranks = collections.Counter()
    for z in range(64):
        row = G[z]
        coefficients = row.copy()
        for j in range(6):
            for point in range(64):
                if point >> j & 1:
                    coefficients[point] ^= coefficients[point ^ (1 << j)]
        assert not any(coefficients[p] for p in range(64) if p.bit_count() > 2)
        radical = [rho for rho in range(64) if all(
            not (row[rho ^ (1 << j)] ^ row[rho] ^ row[1 << j] ^ row[0]) for j in range(6))]
        assert len(radical) & (len(radical) - 1) == 0
        ranks[6 - (len(radical).bit_length() - 1)] += 1
        for rho in radical:
            form = sum(int(directions[i, z, rho] ^ directions[i, z, 0]) << i for i in range(m))
            weights[form] += (-1) ** int(row[rho] ^ row[0])
            radical_size += 1
    weights = {key: value for key, value in weights.items() if value}
    S0 = 64 * sum(weights.values())
    divisible8 = all(value % 8 == 0 for form, value in weights.items() if form)
    xor_form = 0
    if divisible8:
        for form, value in weights.items():
            if form and (value // 8) & 1:
                xor_form ^= form
    constant, certificate = constant_mod32(weights)
    residue = S0 % 2048 if constant else None
    # Independent direct row-sum checks; they verify construction but the
    # all-parameter residue assertion follows from the displayed identity.
    rng = np.random.default_rng(21036)
    tested = [0] + [int.from_bytes(rng.bytes((m + 7) // 8), "little") & ((1 << m) - 1)
                    for _ in range(16)]
    for theta in tested:
        table = G.copy()
        for i in range(m):
            if theta >> i & 1:
                table ^= directions[i]
        direct = int(((1 - 2 * table.astype(np.int64)).sum(axis=1) ** 2).sum())
        formula = 64 * sum(value * (-1) ** ((form & theta).bit_count() & 1)
                           for form, value in weights.items())
        assert direct == formula
        if constant:
            assert direct % 2048 == residue
    return {"label": label, "parameters": m, "radical_points": radical_size,
            "rank_profile": dict(sorted(ranks.items())), "S_at_zero": S0,
            "nonconstant_weights_divisible8": divisible8,
            "xor_odd_quotient_forms": hex(xor_form) if divisible8 else None,
            "constant_residue_proved": constant, "residue_mod2048": residue,
            "certificate": certificate,
            "excluded_by_residue": constant and residue != 0,
            "raw_sample_checks": len(tested),
            "character_coefficients": {hex(key): value for key, value in sorted(weights.items())}}


def main():
    assert constant_mod32({0: 5, 1: 1})[0] is False
    assert constant_mod32({1: 8, 2: 8, 3: 8})[0] is True
    assert constant_mod32({1: 8, 2: 8})[0] is False
    inputs = json.loads((HERE / "inputs.json").read_text(encoding="utf-8"))
    Bb, Gb, Gk, piv = bitj.load_model()
    subspaces = poisson3_lista.todos_subespacos3()
    results = []
    for sample in inputs["polars"]:
        value = int(sample["polar"], 16)
        B = np.array([[(value >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
        r, combination = base12.pack(B), 0
        while r:
            key = r.bit_length() - 1
            r ^= piv[key][0]
            combination ^= piv[key][1]
        G0 = np.bitwise_xor.reduce(Gb[[j for j in range(len(Gb)) if combination >> j & 1]], axis=0)
        part, ker = bitj.solve_affine(poisson5.equacoes(poisson5.Bv_table(B), G0, Gk) +
            poisson3.eq3(poisson5.Bv_table(B), G0, Gk, subspaces), len(Gk))
        base = bitj.table_at(G0, Gk, part)
        directions = [bitj.table_at(np.zeros_like(G0), Gk, k) for k in ker]
        result = certify(base, directions, sample["label"])
        if sample.get("expected_residue") is not None:
            assert result["constant_residue_proved"]
            assert result["residue_mod2048"] == sample["expected_residue"]
        result["polar"] = sample["polar"]
        results.append(result)
    witness = inputs["positive_witness"]
    t = np.zeros(4096, dtype=np.uint8)
    for monomial in witness["anf_supports"]:
        t ^= ((base12.X & monomial) == monomial).astype(np.uint8)
    control = certify(poisson5.tabela(t), Gk, "published bent control")
    assert control["S_at_zero"] == 4096 and not control["excluded_by_residue"]
    results.append(control)
    report = {"proof_method": "radical characters; an XOR relation or low-degree integer coefficients",
              "no_exhaustive_parameter_enumeration": True, "pilot_only": True, "cases": results}
    (HERE / "resultado.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"cases": [{k: v for k, v in r.items() if k not in ("character_coefficients", "polar")}
                               for r in results]}, indent=2))


if __name__ == "__main__":
    main()
