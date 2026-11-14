"""Real RS-model pilot for the direct/compressed quadratic Gauss-bit extractor.

References: exact row sums for every one of 32 parameter assignments, plus
the original bitj.bits routine on all weight <=2 assignments.  No cloud work.
"""
import importlib.util
import itertools
import json
from pathlib import Path
import sys
import time

import numpy as np

HERE = Path(__file__).resolve().parent
MODEL = HERE / "inputs_model"
if not (MODEL / "base12.py").exists():
    MODEL = HERE.parent.parent / "fable_planos_pfaffiano"
sys.path.insert(0, str(MODEL))
import base12
import bitj
import poisson5
import poisson3
import poisson3_lista

ARGON_PATH = HERE.parent / "auditoria-argon-poisson" / "argon_prova_poisson_bitj.py"
if not ARGON_PATH.exists():
    ARGON_PATH = HERE.parent / "audit_argon" / "argon_prova_poisson_bitj.py"
spec = importlib.util.spec_from_file_location("argon_direct", ARGON_PATH)
argon = importlib.util.module_from_spec(spec)
spec.loader.exec_module(argon)


def mobius(values, dimension):
    out = np.array(values, dtype=np.uint8).copy()
    for i in range(dimension):
        for mask in range(1 << dimension):
            if mask >> i & 1:
                out[mask] ^= out[mask ^ (1 << i)]
    return out


def fwht(values):
    a = np.array(values, dtype=np.int64).reshape(-1).copy()
    for i in range(12):
        blocks = a.reshape(-1, 2, 1 << i)
        left, right = blocks[:, 0].copy(), blocks[:, 1].copy()
        blocks[:, 0], blocks[:, 1] = left + right, left - right
    return a


def affine_parameters(G, directions):
    G = np.array(G, dtype=np.int64)
    directions = np.array(directions, dtype=np.int64)
    h0, hd = G[:, 0].copy(), directions[:, :, 0].copy()
    l0 = sum(((G[:, 1 << j] ^ h0) << j) for j in range(6))
    ld = sum(((directions[:, :, 1 << j] ^ hd) << j) for j in range(6))
    par = np.array([x.bit_count() & 1 for x in range(64)])
    assert np.array_equal(directions, hd[:, :, None] ^ par[ld[:, :, None] & np.arange(64)])
    q = G ^ h0[:, None] ^ par[l0[:, None] & np.arange(64)]
    B = np.stack([argon.eval_q_and_polar(row)[1] for row in q])
    return q, B, l0, ld, h0, hd


def exact_bits_selected(G, selected):
    result = []
    signs = 1 - 2 * G.astype(np.int64)
    for index in selected:
        P = bitj.ANN[index]
        V = np.array([v for v in range(64)
                      if all((v & p).bit_count() % 2 == 0 for p in P)], dtype=np.int64)
        assert len(V) == 16
        OM, W0 = bitj.OM[index], bitj.W0[index]
        assert all(int(OM[a ^ b]) == int(OM[a]) ^ int(OM[b]) for a in range(16) for b in range(16))
        assert all(int(W0[a ^ b]) == int(W0[a]) ^ int(W0[b]) for a in range(4) for b in range(4))
        phase = np.array([[(-1) ** ((int(om) & int(v)).bit_count() & 1) for v in V] for om in OM])
        out = np.zeros((7, 64), dtype=np.uint8)
        for iw, w0 in enumerate(W0):
            K = signs[:, int(w0) ^ V] @ phase.T
            assert (K % 4 == 0).all()
            moment = bitj.IMASK @ (K // 4)
            assert (moment % 2 == 0).all()
            out[:, iw * 16:(iw + 1) * 16] = (moment % 4) // 2
        result.append(out)
    return np.array(result)


def check_family(name, G0, directions, selected, positive=False):
    m = len(directions)
    assert m == 5
    q, B, l0, ld, h0, hd = affine_parameters(G0, directions)
    truth = []
    bitj_checks = 0
    start = time.perf_counter()
    for theta in range(1 << m):
        G = G0.copy()
        for i in range(m):
            if theta >> i & 1:
                G ^= directions[i]
        reference = exact_bits_selected(G, selected)
        truth.append(reference)
        if theta.bit_count() <= 2:
            original, odd = bitj.bits(G)
            assert not odd.any()
            for j, index in enumerate(selected):
                got = original[:, index].transpose(0, 2, 1).reshape(7, 64)
                assert np.array_equal(got, reference[j]), (name, theta, index)
            bitj_checks += 1
    truth = np.array(truth)
    exact_seconds = time.perf_counter() - start
    coefficients = mobius(truth, m)
    assert not any(coefficients[x].any() for x in range(1 << m) if x.bit_count() > 2)
    quadratic_terms = int(sum(coefficients[x].sum() for x in range(1 << m) if x.bit_count() == 2))
    if positive:
        assert not truth[0].any()
        assert (np.abs(fwht(1 - 2 * G0.astype(np.int64))) == 64).all()
    aux_points = [y for y in range(64) if y.bit_count() <= 2]
    coefficient_checks = 0
    start = time.perf_counter()
    for j, index in enumerate(selected):
        P = bitj.ANN[index]
        V = [v for v in range(64) if all((v & p).bit_count() % 2 == 0 for p in P)]
        for im in range(7):
            Z = np.flatnonzero(bitj.IMASK[im]).tolist()
            for y in aux_points:
                w0, omega = int(bitj.W0[index, y >> 4]), int(bitj.OM[index, y & 15])
                N, c0, c1, c2 = argon.direct_bI_coefficients(q, B, l0, ld, h0, hd, Z, V, w0, omega)
                assert N % 2 == 0
                row = coefficients[:, j, im, y]
                assert int(c0) == int(row[0])
                assert all(int(c1[i]) == int(row[1 << i]) for i in range(m))
                assert all(int(c2[i, k]) == int(row[(1 << i) | (1 << k)])
                           for i, k in itertools.combinations(range(m), 2))
                coefficient_checks += 1
            joint = mobius(truth[:, j, im].T, 6)  # Aux first, theta second.
            assert not any(joint[y].any() for y in range(64) if y.bit_count() > 2)
            assert all(not mobius(joint[1 << y], m)[x]
                       for y in range(6) for x in range(1 << m) if x.bit_count() > 1)
            assert all(len(set(map(int, joint[(1 << y) | (1 << z)]))) == 1
                       for y, z in itertools.combinations(range(6), 2))
            for theta in range(1 << m):
                raw = truth[theta, j, im]
                compressed = [raw[0]] + [raw[1 << y] ^ raw[0] for y in range(6)]
                compressed += [raw[(1 << y) | (1 << z)] ^ raw[1 << y] ^ raw[1 << z] ^ raw[0]
                               for y, z in itertools.combinations(range(6), 2)]
                assert (not raw.any()) == (not any(compressed))
    direct_seconds = time.perf_counter() - start
    return {"name": name, "parameters": m, "assignments": 1 << m,
            "flats": selected, "moments_per_flat": 7, "auxiliary_points": 64,
            "original_bitj_calls": bitj_checks, "direct_coefficient_checks": coefficient_checks,
            "nonzero_quadratic_coefficients": quadratic_terms,
            "exact_reference_and_original_seconds": round(exact_seconds, 3),
            "direct_and_compression_seconds": round(direct_seconds, 3),
            "positive_control": positive}


def main():
    inputs = json.loads((HERE / "input_pilots.json").read_text(encoding="utf-8"))
    Bb, Gb, Gk, piv = bitj.load_model()
    val = int(inputs["mixed_polar"], 16)
    B = np.array([[(val >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
    r, combination = base12.pack(B), 0
    while r:
        key = r.bit_length() - 1
        r ^= piv[key][0]
        combination ^= piv[key][1]
    chosen = [j for j in range(len(Bb)) if combination >> j & 1]
    G0 = np.bitwise_xor.reduce(Gb[chosen], axis=0)
    sol = bitj.solve_affine(poisson5.equacoes(poisson5.Bv_table(B), G0, Gk) +
        poisson3.eq3(poisson5.Bv_table(B), G0, Gk, poisson3_lista.todos_subespacos3()), len(Gk))
    assert sol is not None and len(sol[1]) == inputs["expected_dim_U"]
    part, ker = sol
    mixed0 = bitj.table_at(G0, Gk, part)
    mixed_indices = [i * (len(ker) - 1) // 4 for i in range(5)]
    mixed_dirs = [bitj.table_at(np.zeros_like(G0), Gk, ker[i]) for i in mixed_indices]
    t = np.zeros(4096, dtype=np.uint8)
    for monomial in inputs["positive_witness"]["anf_supports"]:
        t ^= ((base12.X & monomial) == monomial).astype(np.uint8)
    assert max(x.bit_count() for x in inputs["positive_witness"]["anf_supports"]) == 4
    assert np.array_equal(t, t[((base12.X << 1) & 4095) | (base12.X >> 11)])
    positive0 = poisson5.tabela(t)
    selected = [0, 100, 400]
    positive_indices = [i * (len(Gk) - 1) // 4 for i in range(5)]
    report = {"model_dimensions": {"polar": len(Bb), "affine_part": len(Gk)},
              "mixed_dim_U": len(ker), "pilot_only": True,
              "mixed_direction_indices": mixed_indices,
              "positive_direction_indices": positive_indices,
              "warning": "Timings have different scopes; no speedup factor is inferred.",
              "families": [check_family("mixed actual polar", mixed0, mixed_dirs, selected),
                           check_family("published RS quartic bent witness", positive0, Gk[positive_indices], selected, True)]}
    (HERE / "resultado.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
