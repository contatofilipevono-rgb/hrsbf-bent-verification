"""Independently verify affine coverage, symbolic substitutions and C constants."""
from pathlib import Path
from itertools import combinations
import json,re,sys,contextlib,io
sys.path.insert(0,str(Path(__file__).resolve().parent.parent))
from verify_linear_laws import original_truth,main as verify_linear_certificates
from verify_periodic_reduction import main as verify_periodic_image


def rank(rows):
    piv={}
    for value in rows:
        while value:
            j=value.bit_length()-1
            if j in piv:value^=piv[j]
            else:piv[j]=value;break
    return len(piv)


def validated_model():
    root=Path(__file__).resolve().parent
    model=json.loads((root/'model.json').read_text())
    source=json.loads((root.parent/'linear_law_certificates.json').read_text())
    with contextlib.redirect_stdout(io.StringIO()):
        verify_linear_certificates()
        verify_periodic_image()
    expected_masks=[0x18c8000,1<<40,0x2d57a733bee,1<<42]+[
        int(law['coefficient_mask'],16) for law in source['laws']]
    assert model['masks']==expected_masks
    assert [ch['case'] for ch in model['charts']]==[2,3,8,15]
    truth=[original_truth(o) for o in source['basis']]
    original=[]
    for support in source['filter_supports']:
        mask=sum(1<<x for x in range(4096) if x&support==x)
        cols=[v&mask for v in truth]
        poly={1<<i for i,v in enumerate(cols) if v.bit_count()>>1&1}
        for i,j in combinations(range(43),2):
            q=((cols[i].bit_count()&1)*(cols[j].bit_count()&1))^((cols[i]&cols[j]).bit_count()&1)
            if q:poly.add((1<<i)|(1<<j))
        original.append(poly)
    assert rank(model['masks'])==7
    polynomials=[]
    for chart in model['charts']:
        basis=chart['basis'];offset=chart['offset'];case=chart['case']
        assert 0<=offset<1<<43 and all(0<=v<1<<43 for v in basis)
        assert len(basis)==36 and rank(basis)==36
        rhs=[case>>j&1 for j in range(4)]+[0,0,0]
        assert all((m&offset).bit_count()%2==v for m,v in zip(model['masks'],rhs))
        assert all((m&v).bit_count()%2==0 for m in model['masks'] for v in basis)
        image=[({0} if offset>>j&1 else set())|{1<<i for i,b in enumerate(basis) if b>>j&1}
               for j in range(43)]
        transformed=[]
        for poly,f in zip(original,chart['quadratic_filters']):
            result=set()
            for monomial in poly:
                if monomial.bit_count()==1:terms=image[monomial.bit_length()-1]
                else:
                    i=(monomial&-monomial).bit_length()-1;j=(monomial^(1<<i)).bit_length()-1
                    terms=[]
                    for a in image[i]:
                        for b in image[j]:terms.append(a|b)
                for term in terms:
                    if term in result:result.remove(term)
                    else:result.add(term)
            expected=({0} if f['constant'] else set())|{1<<i for i in range(36) if f['linear']>>i&1}
            for i,j in combinations(range(36),2):
                assert (f['symmetric_rows'][i]>>j&1)==(f['symmetric_rows'][j]>>i&1)
                if f['symmetric_rows'][i]>>j&1:expected.add((1<<i)|(1<<j))
            assert result==expected
            transformed.append(result)
        polynomials.append(transformed)
    arrays={name:json.loads(body.replace('ULL','').replace('{','[').replace('}',']'))
            for name,body in re.findall(r'static const U (\w+)(?:\[\d+\])+\s*=\s*(\{[^;]+\});',
                                      (root/'model_data.h').read_text())}
    assert arrays['OFFSET']==[ch['offset'] for ch in model['charts']]
    assert arrays['BASIS']==model['charts'][0]['basis']
    assert arrays['TRUTH']==[[(v>>(64*w))&((1<<64)-1) for w in range(64)] for v in truth]
    assert arrays['ORIGL']==[sum(m for m in p if m.bit_count()==1) for p in original]
    expected_q=[]
    for p in original:
        rows=[0]*43
        for m in p:
            if m.bit_count()==2:
                i=(m&-m).bit_length()-1;j=(m^(1<<i)).bit_length()-1;rows[i]^=1<<j
        expected_q.append(rows)
    assert arrays['ORIGQ']==expected_q
    base=[];delta=[];hh=[]
    for ch,polys in zip(model['charts'],polynomials):
        base.append([sum((sum((x&m)==m for m in p if m<64)%2)<<x for x in range(64)) for p in polys])
        dd=[]
        for j in range(6,36):
            row=[]
            for p in polys:
                derivative={m^(1<<j) for m in p if m>>j&1 and (m^(1<<j))<64}
                row.append(sum((sum((x&m)==m for m in derivative)%2)<<x for x in range(64)))
            dd.append(row)
        delta.append(dd)
    for i in range(6,36):
        hh.append([sum((1<<(j-6)) for j in range(6,36) if j!=i and ((1<<i)|(1<<j)) in p)
                   for p in polynomials[0]])
    assert arrays['BASE']==base and arrays['DELTA']==delta and arrays['HH']==hh
    # Short analytical exclusion: Q_0x3cf + R1 + R3 + (1+c42)R2 = c40*c42.
    relations=[{1<<i for i in law['indices']} for law in source['laws']]
    identity=original[30]^relations[0]^relations[2]^relations[1]
    for monomial in relations[1]:
        product=monomial|(1<<42)
        if product in identity:identity.remove(product)
        else:identity.add(product)
    assert identity=={(1<<40)|(1<<42)}
    assert polynomials[3][30]=={0}
    assert model['total_chart_candidates']==4*(1<<36)
    return model,polynomials,truth


if __name__=='__main__':
    validated_model()
    print('PASS: affine ranks, all 172 substitutions and every embedded C constant independently verified.')
