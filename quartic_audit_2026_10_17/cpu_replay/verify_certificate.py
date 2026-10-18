"""Check a complete symbolic affine-split certificate and every Walsh witness.
The checker does not enumerate the 2^38 chart assignments and does not run C/GPU.
"""
from pathlib import Path
from itertools import combinations
import csv,json,time,hashlib
from verify_model import validated_model


def main():
    root=Path(__file__).resolve().parent;start=time.perf_counter()
    model,polys,truth=validated_model()
    certificate=json.loads((root/'DECOMPOSITION.json').read_text())
    assert certificate['format']=='boolean-quadratic-affine-split-v1'
    assert len(certificate['roots'])==4 and len(set(certificate['roots']))==4
    monomials=[0]+[1<<i for i in range(36)]+[(1<<i)|(1<<j) for i,j in combinations(range(36),2)]
    monomial_index={m:i for i,m in enumerate(monomials)}
    def pack(poly):
        return sum(1<<monomial_index[m] for m in poly)
    def substitutions(pivot,form,rhs):
        # Independent definition: replace each affected monomial by its Boolean
        # polynomial image, then XOR its old value out. No polar-matrix formula.
        replacements=[]
        for index,monomial in enumerate(monomials):
            if not monomial>>pivot&1:
                continue
            rest=monomial^(1<<pivot);image=0
            if rhs:image^=1<<monomial_index[rest]
            mask=form
            while mask:
                bit=mask&-mask;mask^=bit;image^=1<<monomial_index[rest|bit]
            replacements.append((1<<index,image^(1<<index)))
        return replacements
    def substitute(poly,replacements):
        result=poly
        for bit,delta in replacements:
            if poly&bit:result^=delta
        return result
    witnesses={}
    for file in root.glob('full_thread*.csv'):
        with file.open(newline='') as stream:
            for row in csv.DictReader(stream):
                c=int(row['original_coefficient'],16)
                assert c not in witnesses
                witnesses[c]=(int(row['witness_frequency']),int(row['walsh_value']))
    character_basis=[sum(((x>>i)&1)<<x for x in range(4096)) for i in range(12)]
    characters={0:0};visited=set();checked=set();stats={'nodes':0,'linear_steps':0,'empty_leaves':0,'solution_leaves':0}
    def xor_selected(value,columns):
        result=0
        while value:
            bit=value&-value;value^=bit;result^=columns[bit.bit_length()-1]
        return result
    def check_witness(c):
        assert c in witnesses and c not in checked
        a,w=witnesses[c];assert 0<=a<4096 and abs(w)!=64
        if a not in characters:characters[a]=xor_selected(a,character_basis)
        actual=4096-2*(xor_selected(c,truth)^characters[a]).bit_count()
        assert actual==w,(hex(c),a,actual,w)
        checked.add(c)
    def eliminate(ps,active,offset,basis,form,rhs,pivot):
        assert 0<=pivot<36 and form>>pivot&1 and not form&~active
        rest=form^(1<<pivot);rr=substitutions(pivot,rest,rhs)
        pp=[substitute(p,rr) for p in ps]
        bb=basis[:]
        if rhs:offset^=basis[pivot]
        for i in range(36):
            if rest>>i&1:bb[i]^=basis[pivot]
        bb[pivot]=0
        return pp,active^(1<<pivot),offset,bb
    def visit(nid,ps,active,offset,basis):
        assert 0<=nid<len(certificate['nodes']) and nid not in visited
        visited.add(nid);stats['nodes']+=1;node=certificate['nodes'][nid]
        for step in node['linear_steps']:
            combination=int(step['combination'],16);assert 0<combination<1<<43
            row=xor_selected(combination,ps)
            assert row>>37==0 and row>>1
            ps,active,offset,basis=eliminate(ps,active,offset,basis,row>>1,row&1,step['pivot'])
            stats['linear_steps']+=1
        if node['kind']=='contradiction':
            combination=int(node['combination'],16);assert 0<combination<1<<43
            assert xor_selected(combination,ps)==1
            stats['empty_leaves']+=1
        elif node['kind']=='solutions':
            assert not any(ps)
            dimension=active.bit_count();assert dimension==node['dimension']
            vectors=[basis[j] for j in range(36) if active>>j&1]
            for z in range(1<<dimension):check_witness(offset^xor_selected(z,vectors))
            stats['solution_leaves']+=1
        else:
            assert node['kind']=='split' and len(node['children'])==2
            form=int(node['form'],16);assert form and not form&~active
            pivot=form.bit_length()-1
            for rhs,child in enumerate(node['children']):
                visit(child,*eliminate(ps,active,offset,basis,form,rhs,pivot))
    for i,chart in enumerate(model['charts']):
        visit(certificate['roots'][i],[pack(p) for p in polys[i]],(1<<36)-1,chart['offset'],chart['basis'])
    assert len(visited)==len(certificate['nodes'])
    assert checked==set(witnesses)
    report={'status':'PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS',
            'original_dimension':43,'necessary_chart_dimensions':[36]*4,
            'symbolic_cover_stats':stats,'all_quad_zeros_covered':len(checked),
            'every_leaf_function_has_original_ANF_walsh_rejection':True,
            'no_chart_domain_enumeration_used_by_checker':True,
            'seconds':round(time.perf_counter()-start,3),
            'certificate_sha256':hashlib.sha256((root/'DECOMPOSITION.json').read_bytes()).hexdigest(),
            'checker_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'model_checker_sha256':hashlib.sha256((root/'verify_model.py').read_bytes()).hexdigest(),
            'initial_linear_and_periodic_certificates_rechecked':True,
            'scope':'Complete finite certificate conditional on the separately checked necessary chart reductions. This Python checker is not itself a Lean proof.'}
    (root/'SYMBOLIC_CERTIFICATE_AUDIT.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2))


if __name__=='__main__':main()
