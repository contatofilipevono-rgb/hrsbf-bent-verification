"""Exact controls for the new preliminary lemma and the two-variable example."""
from pathlib import Path
import hashlib,json,re,subprocess,unicodedata
from pypdf import PdfReader

HERE=Path(__file__).resolve().parent
assert hashlib.sha256((HERE/'ORIGINAL_RECEBIDO.md').read_bytes()).hexdigest()=='54559e5debd0612d8e30d110e36afad42ae942d476351cda56b183aebeb56ba6'
# Each integer is a truth table of an arbitrary Boolean function in 3 variables.
derivatives=[[sum((((f>>x)^(f>>(x^a)))&1)<<x for x in range(8)) for a in range(8)] for f in range(256)]
third_checks=0;affine_second_checks=0
for f in range(256):
    for a in range(8):
        for b in range(8):
            dab=derivatives[derivatives[f][a]][b]
            for c in range(8):
                third=derivatives[dab][c]
                assert third in (0,255)
                assert ((dab>>c)&1)==((dab&1)^(third&1))
                third_checks+=1;affine_second_checks+=1
example=[]
for beta in (0,1):
    for gamma in (0,1):
        for delta in (0,1):
            f=[beta*(x&1)*((x>>1)&1)^gamma*((x&1)^((x>>1)&1))^delta for x in range(4)]
            W=[sum(1-2*(f[x]^((x&b).bit_count()&1)) for x in range(4)) for b in range(4)]
            assert all(abs(w)==2 for w in W)==bool(beta)
            assert f[0]^f[3]==beta
            example.append(dict(beta=beta,gamma=gamma,delta=delta,walsh=W))
root=HERE.parents[1]
subprocess.run(['git','-c','safe.directory='+str(root),'-C',str(root),'diff','--exit-code','6dd183685ef8a5b033c1bcf8733496d57b853cc7','HEAD','--','formalization'],check=True,capture_output=True)
log=(HERE/'paper/ARTIGO_REVISADO.log').read_text(errors='replace')
assert not any(x in log for x in ('Overfull','Missing character','Undefined control sequence'))
assert not re.search('undefined (references|citations)',log,re.I)
reader=PdfReader(HERE/'paper/ARTIGO_REVISADO.pdf')
alltext='\n'.join(p.extract_text() for p in reader.pages)
normalized=' '.join(unicodedata.normalize('NFKC',alltext).split())
for label,title in [('Lemma 2.1','derivatives'),('Lemma 2.2','flat Walsh spectrum'),('Lemma 2.3','rotation symmetry'),('Lemma 3.1','Gauss sums'),('Lemma 3.2','odd-order averaging'),('Lemma 3.4','rigidity of rotation')]:
    assert label+' ('+title in normalized,(label,title)
for label in ['Lemma 2.1','Lemma 2.2','Lemma 2.3','Lemma 3.1','Lemma 3.2','Corollary 3.3','Lemma 3.4','Lemma 4.1','Proposition 4.2','Lemma 5.1']:
    assert label in alltext,label
result=dict(third_difference_constant_checks=third_checks,second_difference_affine_checks=affine_second_checks,two_variable_examples=example,pdf_pages=len(reader.pages),forbidden_typographic_diagnostics=0,formal_sources_unchanged=True,new_lean_compilation=False,scope='Finite controls and document diagnostics; universal proof remains the article argument')
(HERE/'CHECKS_JOURNAL.json').write_bytes((json.dumps(result,indent=2)+'\n').encode())
print(json.dumps({k:v for k,v in result.items() if k!='two_variable_examples'},indent=2))
