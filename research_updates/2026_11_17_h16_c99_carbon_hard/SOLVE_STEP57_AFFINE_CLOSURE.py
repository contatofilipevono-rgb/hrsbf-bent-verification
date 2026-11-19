"""Inspect and iterate affine-coefficient elimination on the isotropic fibers."""
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import add, null, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, rank, specialize, transform
from SOLVE_STEP54_GLOBAL_SYZYGIES import multiply, residual
import SOLVE_STEP50_SPLIT_QUOTIENT as step50


def support(word):
    while word:
        bit = word & -word
        yield bit.bit_length() - 1
        word ^= bit


def pack_columns(matrix, n, width):
    rows = [0] * len(matrix[0])
    for term, block in matrix.items():
        assert term.bit_count() <= 1 or not block.any()
        for i, j in zip(*np.nonzero(block)):
            rows[i] |= 1 << (width * term.bit_length() + int(j))
    assert all(row.bit_length() <= (n + 1) * width for row in rows)
    return rows


def reduce_word(word, basis):
    for bit in sorted(basis, reverse=True):
        if word >> bit & 1:
            word ^= basis[bit]
    return word


def seed_test(affine, original, n, width):
    basis = {}
    first = {}
    for lhs, _ in affine:
        if lhs:
            add(basis, lhs)
    for lhs in original:
        add(first, lhs)
    variables = n * width + width
    signatures = {}
    seeds = []
    for j in range(width):
        word = 0
        for i in range(1, n + 1):
            image = reduce_word(1 << (i * width + j), basis)
            word |= image << ((i - 1) * variables)
        witness = 1 << j
        while word:
            lead = word.bit_length() - 1
            if lead not in signatures:
                signatures[lead] = (word, witness)
                break
            other, proof = signatures[lead]
            word ^= other
            witness ^= proof
        else:
            seeds.append(witness)
    seed_rank = {}
    for v in seeds:
        temp = dict(first)
        for i in range(1, n + 1):
            add(temp, v << (i * width))
        seed_rank[v] = len(temp) - len(first)
    return {"seed_dim": len(seeds), "seed_rank_gain": seed_rank,
            "seed_inside_original": [v for v in seeds if not reduce_word(v, first)]}


def affine_round(rows, n, width):
    multipliers = [0] + [1 << j for j in range(n)]
    coefficient_terms = multipliers + [a | b for j,a in enumerate(multipliers[1:]) for b in multipliers[j+2:]]
    lhs_position = {p:j for j,p in enumerate(coefficient_terms)}
    lhs_packs = []
    rhs_packs = []
    rhs_terms = [0]
    rhs_pos = {0:0}
    mask = (1 << width) - 1
    for a, b in rows:
        entries = [(multipliers[i], (a >> (i * width)) & mask) for i in range(n + 1)]
        entries = [(p, block) for p, block in entries if block]
        for q in multipliers:
            word = 0
            for p, block in entries:
                word ^= block << (width * lhs_position[p | q])
            lhs_packs.append(word)
            encoded = 0
            for p in multiply(b, q):
                if p not in rhs_pos:
                    rhs_pos[p] = len(rhs_terms)
                    rhs_terms.append(p)
                encoded |= 1 << rhs_pos[p]
            rhs_packs.append(encoded)
    rhs_width = len(rhs_terms)
    rhs_mask = (1 << rhs_width) - 1
    generators = [(a << rhs_width) | b for a,b in zip(lhs_packs,rhs_packs)]
    threshold = (n + 1) * width + rhs_width
    echelon = {}
    for j, word in enumerate(generators):
        witness = 1 << j
        while word:
            lead = word.bit_length() - 1
            if lead not in echelon:
                echelon[lead] = (word, witness)
                break
            other, trace = echelon[lead]
            word ^= other
            witness ^= trace

    next_rows = []
    traces = []
    for lead, (word, witness) in sorted(echelon.items()):
        if lead >= threshold:
            continue
        check = 0
        for j in support(witness):
            check ^= generators[j]
        assert check == word
        lhs = word >> rhs_width
        rhs = {rhs_terms[j] for j in support(word & rhs_mask)}
        next_rows.append((lhs,rhs))
        traces.append(list(support(witness)))
    affine = sum(a != 0 for a, _ in next_rows)
    constant = sum(0 < a <= mask for a, _ in next_rows)
    pure = [b for a,b in next_rows if a == 0]
    report = {"affine_rank":affine, "constant_rank":constant, "pure_rank":len(pure),
              "mixed_quadratic_rank":sum(j>=threshold for j in echelon),
              "max_rhs_degree":max((p.bit_count() for _, b in next_rows for p in b),default=0),
              "unit":{0} in pure}
    return next_rows, traces, report


def probe(coeff, S, rhs, pure, bits, trial):
    matrix, right = residual(coeff, S, rhs)
    cert = json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    n = S.shape[1]
    U = null(unpack(cert["fixed_forms"], n))
    pivots = set(rref(U)[1])
    J = np.eye(n, dtype=np.uint8)[[j for j in range(n) if j not in pivots]]
    assert (len(U), len(J)) == (35, 9)
    results = []
    for point in (0, 511):
        offset = np.zeros(n, dtype=np.uint8)
        for j, v in enumerate(J):
            if point >> j & 1:
                offset ^= v
        restricted, forms = specialize(matrix, offset, U)
        cache = {0:{0}}
        original = pack_columns(restricted, len(U), 25)
        rows = list(zip(original,[transform(poly,forms,cache) for poly in right]))
        rows.extend((0,transform(poly,forms,cache)) for poly in pure)
        rounds = []
        for number in range(1, 4):
            next_rows, traces, report = affine_round(rows, len(U), 25)
            if number == 1:
                assert report["affine_rank"] == 99
                report["seed"] = seed_test(next_rows, original, len(U), 25)
            print("STEP57_ROUND",json.dumps({"offset":point,"round":number,**report}),flush=True)
            rounds.append({"report":report,"rows":[[a,sorted(b)] for a,b in next_rows],"traces":traces})
            if report["unit"] or len(next_rows) == len(rows) or len(next_rows) > 180:
                break
            rows = next_rows
        results.append({"offset":point,"rounds":rounds})
    Path("step57_affine_closure.json").write_text(json.dumps(results))


if __name__ == "__main__":
    step50.split_probe = probe
    step50.main()
