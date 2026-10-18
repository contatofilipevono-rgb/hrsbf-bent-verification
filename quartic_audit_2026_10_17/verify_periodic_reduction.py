"""Exact four-case reduction and short-orbit weight arithmetic (standard library)."""
from pathlib import Path
import itertools,json


def rotation_orbit(x):
    return sorted({((x << j) | (x >> (12-j))) & 4095 for j in range(12)})


def main():
    root = Path(__file__).resolve().parent
    basis = json.loads((root/'linear_law_certificates.json').read_text())['basis']
    columns = [sum((sum((y*273)&s == s for s in o) & 1) << y for y in range(16))
               for o in basis]
    basis4 = [0x1248,0x6ca0,0x6880,0x8000]
    assert set(columns) <= {0,*basis4}
    masks = [sum(1 << j for j,v in enumerate(columns) if v == b) for b in basis4]
    assert masks == [0x18c8000,1<<40,0x2d57a733bee,1<<42]
    cases = []
    for p in range(16):
        table = 0
        for j,b in enumerate(basis4):
            if p >> j & 1:
                table ^= b
        correlations = [sum(1-2*(((table>>x)^(table>>(x^u)))&1)
                            for x in range(16)) for u in range(1,16)]
        if all(v % 3 == 0 for v in correlations):
            cases.append((p,table))
    assert [p for p,t in cases] == [2,3,8,15]
    seen = set(); input_orbits = []
    for x in range(4096):
        if x not in seen:
            o = rotation_orbit(x); seen.update(o); input_orbits.append(o)
    short = [o for o in input_orbits if len(o)<12]
    assert len(short)==17 and sum(map(len,short))==76
    assert sum(len(o)==12 for o in input_orbits)==335
    signatures = [sum((sum(o[0]&s==s for s in b)&1)<<j for j,b in enumerate(basis))
                  for o in short]
    # Check that short input values are controlled by four periodic parameters
    # plus the third antipodal coefficient. The certified linear filter removes it.
    controls = masks + [1<<26]
    span = {0}
    for row in controls:
        span |= {v^row for v in list(span)}
    assert all(v in span for v in signatures)
    weights=[]
    for p,table in cases:
        coeff = ((1<<15) if p&1 else 0) ^ ((1<<40) if p>>1&1 else 0)
        coeff ^= ((1<<1) if p>>2&1 else 0) ^ ((1<<42) if p>>3&1 else 0)
        coeff ^= (1<<26) if ((p>>1)^(p>>3))&1 else 0
        assert sum(((coeff&m).bit_count()&1)<<j for j,m in enumerate(masks))==p
        sw = sum(len(o)*((coeff&sig).bit_count()&1) for o,sig in zip(short,signatures))
        short_by_parity = [sum(len(o)*((coeff&sig).bit_count()&1)
                               for o,sig in zip(short,signatures) if o[0].bit_count()%2==b)
                           for b in [0,1]]
        targets = [(w-sw)//12 for w in [2016,2080] if (w-sw)%12==0]
        assert len(targets)==1
        even_odd = []
        for sign in [-1,1]:
            delta = sign*32-short_by_parity[0]+short_by_parity[1]
            if delta%12==0 and (targets[0]+delta//12)%2==0:
                even=(targets[0]+delta//12)//2
                even_odd.append([even,targets[0]-even])
        assert len(even_odd)==1
        weights.append({'parameter_code':p,'truth_table':hex(table),
                        'short_input_weight':sw,'long_orbits_weight':targets[0],
                        'required_total_weight':sw+12*targets[0],
                        'short_weights_even_odd':short_by_parity,
                        'required_long_weights_even_odd':even_odd[0]})
    report = {'status':'PASS','original_dimension':43,'periodic_image_dimension':4,
              'periodic_coefficient_masks':[hex(m) for m in masks],
              'allowed_cases':weights,'short_input_orbits':17,'short_input_points':76,
              'long_input_orbits':335,
              'scope':'Necessary reduction, not an UNSAT result or a replacement for the global GPU search.'}
    print(json.dumps(report,indent=2))
    return report


if __name__=='__main__':
    main()
