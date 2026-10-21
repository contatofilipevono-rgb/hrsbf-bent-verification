"""Check mathematical data transcribed in the article, starting from its tables."""
from pathlib import Path
import re, json, hashlib, argparse
if not __debug__:
    raise RuntimeError('Run without -O: assertions are part of this audit.')

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--article',type=Path,help='Path to H12_preprint.md')
args=parser.parse_args()
default=Path(__file__).resolve().parent/'H12_preprint.md'
if not default.exists(): default=Path.cwd()/'outputs/H12_preprint/H12_preprint.md'
article=args.article or default
out=article.resolve().parent
text=article.read_text(encoding='utf-8')
app_a=text.split('## Appendix A:')[1].split('## Appendix B:')[0]
rows=re.findall(r'\| (\d+) \| \$\\\{([0-9,]+)\\\}\$ \| (\d+) \|',app_a)
assert len(rows)==43
orbits=[]
for index,support,size in rows:
    assert int(index)==len(orbits)
    support=set(map(int,support.split(',')))
    orb={sum(1<<((i+s)%12) for i in support) for s in range(12)}
    assert len(orb)==int(size)
    orbits.append(orb)
flat=[s for orb in orbits for s in orb]
assert len(flat)==len(set(flat))==495
assert set(flat)=={x for x in range(4096) if x.bit_count()==4}
def monomial(s,x): return x&s==s
def values(x):
    return [sum(monomial(s,x) for s in orb)%2 for orb in orbits]
app_b=text.split('## Appendix B:')[1].split('## Appendix C:')[0]
mask_block=app_b.split('\\begin{gathered}')[1].split('\\end{gathered}')[0]
masks=list(map(int,re.findall(r'\d+',mask_block)))
assert len(masks)==43 and all(s.bit_count()==8 for s in masks)
filter_orbits=[{sum(1<<((i+k)%12) for i in range(12) if s>>i&1) for k in range(12)} for s in masks]
assert len(set.union(*filter_orbits))==495 and sum(map(len,filter_orbits))==495
Q=[]
for support in masks:
    points=[x for x in range(4096) if x&support==x]
    columns=[0]*43
    for bit,x in enumerate(points):
        for j,v in enumerate(values(x)):
            if v: columns[j]|=1<<bit
    weights=[v.bit_count() for v in columns]
    q=set()
    for i in range(43):
        if weights[i]//2%2: q.add(1<<i)
        for j in range(i):
            if ((weights[i]&1)*(weights[j]&1)+(columns[i]&columns[j]).bit_count())%2:
                q.add((1<<i)|(1<<j))
    Q.append(q)
def add(*polys):
    ans=set()
    for p in polys: ans.symmetric_difference_update(p)
    return ans
def mul(a,b):
    ans=set()
    for x in a:
        for y in b: ans.symmetric_difference_update({x|y})
    return ans
rblock=text.split('R_1={}&')[1].split('\\end{aligned}')[0]
rparts=[rblock.split('R_2={}&')[0],rblock.split('R_2={}&')[1].split('R_3={}&')[0],rblock.split('R_3={}&')[1]]
R=[{1<<int(i) for i in re.findall(r'c_\{?(\d+)\}?',p)} for p in rparts]
pair_sections=[app_b.split('For $R_1$')[1].split('For $R_2$')[0],app_b.split('For $R_2$')[1].split('For $R_3$')[0],app_b.split('For $R_3$')[1].split('In particular')[0]]
counts=[]
for r,part in zip(R,pair_sections):
    pairs=[tuple(map(int,p)) for p in re.findall(r'\((\d+),(-?\d+)\)',part)]
    counts.append(len(pairs))
    result=add(*(mul({0 if v==-1 else 1<<v},Q[j]) for j,v in pairs))
    assert result==r, ('linear identity',len(counts))
assert counts==[22,1,24]
assert Q[42]==R[1]
assert masks[30]==975
assert add(Q[30],R[0],R[2],mul({0,1<<42},R[1]))=={(1<<40)|(1<<42)}

J=list(map(int,re.search(r'J=\\\{([0-9,]+)\\\}',text).group(1).split(',')))
alpha=[15,18,19,23,24]
for y in range(16):
    bits=[y>>i&1 for i in range(4)]
    a=sum(bits[i]*bits[(i+1)%4] for i in range(4))%2
    b=(bits[0]*bits[2]+bits[1]*bits[3])%2
    c=sum(all(bits[i] for i in range(4) if i!=skip) for skip in range(4))%2
    d=int(y==15)
    p=values(y|(y<<4)|(y<<8))
    expected=[((a if j in alpha else 0)^(b if j==40 else 0)^(c if j in J else 0)^(d if j==42 else 0)) for j in range(43)]
    assert p==expected, ('period four restriction',y)
accepted=[]
for code in range(16):
    truth=[]
    for y in range(16):
        b=[y>>i&1 for i in range(4)]
        basis=[sum(b[i]*b[(i+1)%4] for i in range(4))%2,(b[0]*b[2]+b[1]*b[3])%2,sum(all(b[i] for i in range(4) if i!=skip) for skip in range(4))%2,int(y==15)]
        truth.append(sum((code>>i&1)*basis[i] for i in range(4))%2)
    ac=[sum((-1)**(truth[x]^truth[x^u]) for x in range(16)) for u in range(1,16)]
    if all(v%3==0 for v in ac): accepted.append((code,sum(v<<i for i,v in enumerate(truth))))
table=[(int(a),int(b,16)) for a,b in re.findall(r'\| (\d+) \| \$\([^\n]+?\$ \| `0x([0-9a-f]+)` \|',text)]
assert accepted==table==[(2,0x6ca0),(3,0x7ee8),(8,0x8000),(15,0x9668)]

# Verify the displayed triangular affine parametrization symbolically.
free=list(range(24))+[25,27,28,29,30,31,32,33,34,35,38,39]
assert len(free)==36 and len(set(free))==36
constant=1<<36
for code,_ in accepted[:3]:
    c={i:1<<k for k,i in enumerate(free)}
    a,b,g,d=[constant*(code>>i&1) for i in range(4)]
    def xor(indices):
        v=0
        for i in indices: v^=c[i]
        return v
    c[24]=a^xor([15,18,19,23]); c[40]=b; c[42]=d; c[26]=b^d
    c[36]=xor([1,7,9,18,24,32,34])
    c[37]=xor([0,1,2,6,7,9,12,15,18,23,24,25,32,34,36])
    c[41]=g^xor([j for j in J if j!=41])
    for r in R: assert xor([s.bit_length()-1 for s in r])==0
    assert (xor(alpha),c[40],xor(J),c[42])==(a,b,g,d)
    assert all(c[i]==1<<k for k,i in enumerate(free))

report={'status':'PASS_ARTICLE_DATA_RECONSTRUCTION','source':'Current article tables and explicit formulas; no imported filter JSON or certificate result used','article_sha256':hashlib.sha256(text.encode()).hexdigest(),'quartic_orbits':43,'covered_quartic_supports':495,'coordinate_filter_orbits':43,'filters_reconstructed_from_truth_values':43,'linear_identity_product_counts':counts,'excluded_periodic_identity':True,'periodic_restriction_all_basis_functions':True,'periodic_classification':accepted,'affine_parametrizations_symbolically_checked':3,'lean_rebuilt':False,'scope':'Checks transcribed structural data, not a new global proof or external peer review'}
(out/'ARTICLE_TRANSCRIPTION_AUDIT.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(report,indent=2))
