"""Rebuild all quartic weight-eight filters from 35 complementary pairs."""
from pathlib import Path
from itertools import combinations
import json,hashlib
from verify_linear_laws import original_truth


def main():
    root=Path(__file__).resolve().parent
    source=root/'linear_law_certificates.json'
    data=json.loads(source.read_text())
    owner={m:i for i,orbit in enumerate(data['basis']) for m in orbit}
    assert len(owner)==495==sum(map(len,data['basis']))
    assert set(owner)=={sum(1<<i for i in inds) for inds in combinations(range(12),4)}
    truth=[original_truth(o) for o in data['basis']]
    filters=[]
    for support in data['filter_supports']:
        pairs=[];polynomial=set()
        for a in sorted(owner):
            if a&support==a and a<(support^a):
                b=support^a
                assert b in owner and a&b==0 and a|b==support
                monomial=(1<<owner[a])|(1<<owner[b])
                polynomial.symmetric_difference_update([monomial])
                pairs.append({'support_a':a,'support_b':b,'coordinate_a':owner[a],'coordinate_b':owner[b]})
        assert len(pairs)==35
        cube=sum(1<<x for x in range(4096) if x&support==x)
        columns=[v&cube for v in truth]
        expected={1<<i for i,v in enumerate(columns) if (v.bit_count()>>1)&1}
        for i,j in combinations(range(43),2):
            polar=((columns[i].bit_count()&1)*(columns[j].bit_count()&1))^((columns[i]&columns[j]).bit_count()&1)
            if polar:expected.symmetric_difference_update([(1<<i)|(1<<j)])
        assert polynomial==expected
        filters.append({'support':support,'pairs':pairs,'polynomial_masks':sorted(polynomial)})
    report={'status':'PASS_43_COMPLEMENT_PAIR_FILTERS','source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
            'pairs_per_support':35,'filters':filters,
            'scope':'Exact equality with the existing quadratic filters. Mathematical derivation in COMPLEMENT_PAIR_IDENTITY.md; not a global Lean nonexistence proof.'}
    (root/'reports/COMPLEMENT_PAIR_FILTERS.json').write_text(json.dumps(report,indent=2))
    print(json.dumps({'status':report['status'],'filters':len(filters),'pairs_each':35,
                      'reduced_term_counts':[len(f['polynomial_masks']) for f in filters]}))
    return report


if __name__=='__main__':main()
