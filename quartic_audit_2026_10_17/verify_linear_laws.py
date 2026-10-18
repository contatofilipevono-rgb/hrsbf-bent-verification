"""Verify exact Boolean polynomial certificates, without SAT/GPU or interpolation."""
from pathlib import Path
from itertools import combinations
import json


def original_truth(orbit):
    values = [0] * 4096
    for m in orbit:
        values[m] ^= 1
    for i in range(12):
        bit = 1 << i
        for x in range(4096):
            if x & bit:
                values[x] ^= values[x ^ bit]
    return sum(v << x for x, v in enumerate(values))


def main():
    root = Path(__file__).resolve().parent
    data = json.loads((root / 'linear_law_certificates.json').read_text())
    basis = data['basis']
    assert len(basis) == 43
    for orbit in basis:
        assert orbit and orbit==sorted({((orbit[0]<<j)|(orbit[0]>>(12-j)))&4095 for j in range(12)})
    assert sorted(m for o in basis for m in o) == sorted(
        sum(1 << i for i in inds) for inds in combinations(range(12), 4))
    supports=data['filter_supports']
    assert len(supports)==43 and all(s.bit_count()==8 for s in supports)
    support_orbits=[{((s<<j)|(s>>(12-j)))&4095 for j in range(12)} for s in supports]
    assert sum(map(len,support_orbits))==495
    assert set().union(*support_orbits)=={sum(1<<i for i in inds) for inds in combinations(range(12),8)}
    columns = [original_truth(o) for o in basis]
    polynomials = []
    for support in data['filter_supports']:
        subcube = sum(1 << x for x in range(4096) if x & support == x)
        cols = [v & subcube for v in columns]
        poly = {1 << j for j, v in enumerate(cols) if (v.bit_count() >> 1) & 1}
        for i, j in combinations(range(43), 2):
            q = ((cols[i].bit_count() & 1) * (cols[j].bit_count() & 1)) ^ (
                (cols[i] & cols[j]).bit_count() & 1)
            if q:
                poly.add((1 << i) | (1 << j))
        polynomials.append(poly)
    for law in data['laws']:
        assert law['rhs'] in [0,1] and len(set(law['indices']))==len(law['indices'])
        assert all(0<=i<43 for i in law['indices'])
        assert int(law['coefficient_mask'],16)==sum(1<<i for i in law['indices'])
        result = set()
        for term in law['products']:
            multiplier = term['multiplier_variable']
            bit = 0 if multiplier < 0 else 1 << multiplier
            for monomial in polynomials[term['filter']]:
                product = monomial | bit  # c_i^2 = c_i, exact Boolean ring.
                if product in result:
                    result.remove(product)
                else:
                    result.add(product)
        expected = {1 << i for i in law['indices']}
        if law['rhs']:
            expected.add(0)
        assert result == expected, (law['coefficient_mask'], result ^ expected)
    report = {'status': 'PASS', 'original_dimension': 43,
              'necessary_quadratic_filters': len(polynomials),
              'verified_boolean_polynomial_identities': len(data['laws']),
              'products_per_identity': [len(x['products']) for x in data['laws']],
              'scope': 'Three exact linear consequences; not a global UNSAT certificate.'}
    print(json.dumps(report, indent=2))
    return report


if __name__ == '__main__':
    main()
