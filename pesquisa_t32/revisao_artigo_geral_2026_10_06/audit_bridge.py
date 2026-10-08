#!/usr/bin/env python3
"""Exact finite controls for the consolidated degree<=3 proof; not a formal proof."""
import itertools
import json
import platform
import random
from pathlib import Path


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def xor_term(poly, term):
    if term in poly:
        poly.remove(term)
    else:
        poly.add(term)


def orbits(n, degree):
    seen = set()
    for support in itertools.combinations(range(n), degree):
        if support in seen:
            continue
        orbit = {tuple(sorted((i + s) % n for i in support)) for s in range(n)}
        seen.update(orbit)
        yield {sum(1 << i for i in mon) for mon in orbit}


def substitute(poly, images):
    result = set()
    for term in poly:
        terms = {0}
        while term:
            bit = term & -term
            factor = images[bit.bit_length() - 1]
            product = set()
            for a in terms:
                for b in factor:
                    xor_term(product, a | b)
            terms = product
            term ^= bit
        for mon in terms:
            xor_term(result, mon)
    return result


def matrix(poly, n):
    rows = [0] * n
    for mon in poly:
        if mon.bit_count() == 2:
            i = (mon & -mon).bit_length() - 1
            j = (mon ^ (1 << i)).bit_length() - 1
            rows[i] ^= 1 << j
            rows[j] ^= 1 << i
    return rows


def identities(poly, n):
    h = n // 2
    diagonal = [{1 << (i % h)} for i in range(n)]
    require(not substitute(poly, diagonal), (n, "diagonal"))
    fiber = substitute(poly, [{1 << i} for i in range(h)] +
                       [{0, 1 << i} for i in range(h)])
    require(all(mon.bit_count() <= 2 for mon in fiber), (n, "fiber degree"))
    twisted = [{0, 1 << (h-1)}] + [{1 << (i-1)} for i in range(1, h)]
    require(substitute(fiber, twisted) == fiber, (n, "twisted invariance"))
    shifted = substitute(poly, [{0, 1 << i} for i in range(n)])
    derivative = poly ^ shifted
    require(all(mon.bit_count() <= 2 for mon in derivative), (n, "derivative degree"))
    D, F = matrix(derivative, n), matrix(fiber, h)
    for i in range(h):
        predicted = ((D[i] ^ D[i+h]) >> h) & ((1 << h)-1)
        require(predicted == F[i], (n, i, "polar transfer"))


def folded(poly, t):
    result = set()
    for mon in poly:
        reduced = 0
        while mon:
            bit = mon & -mon
            reduced |= 1 << ((bit.bit_length()-1) % t)
            mon ^= bit
        xor_term(result, reduced)
    return result


def allowed_basis(n):
    basis = list(orbits(n, 3))
    basis.extend(poly for poly in orbits(n, 2) if len(poly) == n)
    basis.extend(orbits(n, 1))
    return basis


def small_exhaustive(n):
    basis = allowed_basis(n)
    tables = [sum((sum((x & term) == term for term in p) & 1) << x
                  for x in range(1 << n)) for p in basis]
    diagonal_zero = 0
    for choice in range(1 << len(basis)):
        table = 0
        for i, word in enumerate(tables):
            if choice >> i & 1:
                table ^= word
        require(all(not (table >> (u | (u << (n//2))) & 1)
                    for u in range(1 << (n//2))), "small diagonal")
        diagonal_zero += 1
        spectrum = [1 - 2 * ((table >> x) & 1) for x in range(1 << n)]
        step = 1
        while step < len(spectrum):
            for start in range(0, len(spectrum), 2 * step):
                for offset in range(step):
                    a, b = spectrum[start+offset], spectrum[start+offset+step]
                    spectrum[start+offset], spectrum[start+offset+step] = a+b, a-b
            step *= 2
        require(any(abs(w) != 1 << (n//2) for w in spectrum), "unexpected bent")
    # Positive control: antipodal quadratic is bent and does not vanish diagonally.
    antipodal = {(1 << i) | (1 << (i+n//2)) for i in range(n//2)}
    require(substitute(antipodal, [{1 << (i % (n//2))} for i in range(n)]) ==
            {1 << i for i in range(n//2)}, "antipodal diagonal")
    return {"n": n, "generators": len(basis), "functions": diagonal_zero,
            "bent": 0, "antipodal_diagonal": "parity", "status": "PASS"}


def main():
    result = {"python": platform.python_version(),
              "status": "finite controls; general argument is algebraic",
              "power_of_two": [], "odd_fold": [], "small_exhaustive": []}
    for n in (2, 4, 8, 16, 32, 64):
        basis = allowed_basis(n)
        for poly in basis:
            identities(poly, n)
        rng = random.Random(20261006 + n)
        for _ in range(32):
            poly = set()
            for p in basis:
                if rng.getrandbits(1):
                    poly ^= p
            identities(poly, n)
        result["power_of_two"].append({"n": n, "basis": len(basis),
                                       "mixed_controls": 32, "status": "PASS"})
    for n in (6, 10, 12, 18, 20, 24, 30, 40, 48, 80, 96):
        t = n & -n
        count = 0
        target_basis = allowed_basis(t)
        target_terms = set().union(*target_basis)
        for poly in orbits(n, 3):
            g = folded(poly, t)
            require(g <= target_terms, (n, t, "folded allowed support"))
            identities(g, t)
            # The t-half-turn is the n-half-turn restricted to repeated blocks.
            require((n//2) % t == t//2, (n, t, "half-turn compatibility"))
            count += 1
        result["odd_fold"].append({"n": n, "t": t, "odd_multiplier": n//t,
                                   "cubic_orbits": count, "status": "PASS"})
    result["small_exhaustive"] = [small_exhaustive(n) for n in (2, 4, 8)]
    out = Path(__file__).with_name("audit_bridge.json")
    out.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
