"""Compare the explicit Lean affine/chart data with the audited CPU model."""
from pathlib import Path
from itertools import combinations
import hashlib,json,re


def main():
    root=Path(__file__).resolve().parent.parent
    model_path=root/'cpu_replay/model.json'
    affine_path=root/'lean/H12Affine.lean'
    filters_path=root/'lean/H12ChartFilters.lean'
    model=json.loads(model_path.read_text())
    affine=affine_path.read_text(encoding='utf-8')
    filters=filters_path.read_text(encoding='utf-8')
    def read_field(text,name):
        match=re.search(r'^def '+name+r'\s*:[^\n]*:=\s*(\[[^\n]+\])\s*$',text,re.M)
        assert match,name
        return json.loads(match.group(1))
    offsets=read_field(affine,'offsets');basis=read_field(affine,'basis')
    free=read_field(affine,'free');forms=read_field(affine,'forms')
    witnesses=read_field(affine,'witnesses');cases=read_field(affine,'cases')
    targets=read_field(filters,'targets')
    assert cases==[chart['case'] for chart in model['charts']]==[2,3,8,15]
    assert offsets==[chart['offset'] for chart in model['charts']]
    assert all(basis==chart['basis'] for chart in model['charts'])
    assert len(free)==len(set(free))==36 and all(0<=j<43 for j in free)
    assert all((v>>free[i]&1)==(i==j) for i in range(36) for j,v in enumerate(basis))
    assert forms==[[1<<i for i in range(43) if mask>>i&1] for mask in model['masks']]
    assert len(witnesses)==43
    for k,chart in enumerate(model['charts']):
        constraints=[set(row)^({0} if (chart['case']>>i&1 if i<4 else 0) else set())
                     for i,row in enumerate(forms)]
        for t in range(43):
            polynomial={1<<t}
            if offsets[k]>>t&1:polynomial.symmetric_difference_update([0])
            for i,v in enumerate(basis):
                if v>>t&1:polynomial.symmetric_difference_update([1<<free[i]])
            for i in witnesses[t]:
                assert 0<=i<7
                polynomial.symmetric_difference_update(constraints[i])
            assert not polynomial,(k,t)
        expected=[]
        for q in chart['quadratic_filters']:
            p=([0] if q['constant'] else [])+[1<<i for i in range(36) if q['linear']>>i&1]
            p += [(1<<i)|(1<<j) for i,j in combinations(range(36),2) if q['symmetric_rows'][i]>>j&1]
            expected.append(p)
        assert targets[k]==expected
    report={'status':'PASS_LEAN_AFFINE_AND_ROOT_DATA_MATCH_MODEL','charts':4,'chart_variables':36,
            'coordinate_reconstruction_identities':172,'transformed_filters':172,
            'sha256':{p.relative_to(root).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
                      for p in [model_path,affine_path,filters_path]},
            'scope':'Data/provenance comparison. Lean proofs and kernel replay are recorded separately.'}
    (root/'reports/AFFINE_CHART_DATA_AUDIT.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report))
    return report


if __name__=='__main__':main()
