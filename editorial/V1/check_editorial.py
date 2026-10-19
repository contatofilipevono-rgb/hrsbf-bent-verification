"""Small exact falsification controls; none replaces a universal proof."""
from pathlib import Path
from itertools import combinations
import hashlib, json, re, subprocess
from pypdf import PdfReader

HERE=Path(__file__).resolve().parent
REPO=HERE.parents[1]

# Git stores text with LF; Windows checkouts may materialize CRLF.
manifest_path=HERE/'SHA256SUMS.json'
if manifest_path.exists():
    for name,digest in json.loads(manifest_path.read_text(encoding='utf-8')).items():
        raw=(HERE/name).read_bytes()
        if not name.endswith('.pdf'):
            raw=raw.replace(b'\r\n',b'\n')
        assert hashlib.sha256(raw).hexdigest()==digest, name

def parity(x): return x.bit_count() & 1
def shear(x): return x ^ (2 if x & 1 else 0)
def perm3(x): return (x & ~7) | ((x & 3)<<1) | ((x>>2)&1)
def T(x): return shear(perm3(shear(x)))

gauss=0; odd=0; nontrivial=0
for n in range(1,5):
    supports=[0]+[1<<i for i in range(n)]+[sum(1<<i for i in p) for p in combinations(range(n),2)]
    for code in range(1<<len(supports)):
        terms=[m for j,m in enumerate(supports) if code>>j&1]
        values=[sum((x&m)==m for m in terms)%2 for x in range(1<<n)]
        radical=[r for r in range(1<<n) if all(values[x^r]^values[x]^values[r]^values[0]==0 for x in range(1<<n))]
        S=sum(1-2*v for v in values)
        assert S*S==(1<<n)*sum(1-2*(values[r]^values[0]) for r in radical)
        gauss+=1
        if n>=3 and all(values[T(x)]==values[x] for x in range(1<<n)):
            U=[x for x in range(1<<n) if T(x)==x]
            assert (S==0)==(sum(1-2*values[x] for x in U)==0)
            for r in radical:
                avg=r^T(r)^T(T(r))
                assert avg in radical and avg in U
                assert values[avg]^values[0]==values[r]^values[0]
            odd+=1; nontrivial+=int(S==0)

affine_checks=0
for code in range(256):
    f=[(code>>x)&1 for x in range(8)]
    zero=all(f[x^y]^f[x]^f[y]^f[0]==0 for x in range(8) for y in range(8))
    affine=all(f[x]==(f[0]^parity(x & sum((f[1<<i]^f[0])<<i for i in range(3)))) for x in range(8))
    assert zero==affine
    affine_checks+=1

formal=REPO/'formalization'
ref='6dd183685ef8a5b033c1bcf8733496d57b853cc7'
diff=subprocess.run(['git','-c','safe.directory='+str(REPO),'-C',str(REPO),'diff','--exit-code',ref,'HEAD','--','formalization'],capture_output=True,check=True)
checks={}
for stem in ('ARTIGO_SIMPLIFICADO','APENDICE_PROVAS'):
    log=(HERE/(stem+'.log')).read_text(errors='replace')
    assert 'Overfull' not in log
    assert not re.search(r'undefined (?:references|citations)',log,re.I)
    reader=PdfReader(HERE/(stem+'.pdf'))
    assert all(p.extract_text().strip() for p in reader.pages)
    checks[stem]={'pages':len(reader.pages),'overfull_boxes':0,'nonempty_pages':True}
result=dict(gauss_quadratics=gauss,odd_order_invariant_quadratics=odd,balanced_odd_order_controls=nontrivial,zero_polar_affine_equivalences=affine_checks,formal_sources_unchanged_from_certified_commit=ref,new_lean_compilation=False,documents=checks,scope='Finite falsification and evidence checks; alternate universal proof is in the article')
(HERE/'EDITORIAL_CHECKS.json').write_bytes((json.dumps(result,indent=2)+'\n').encode())
print(json.dumps(result,indent=2))
