from pathlib import Path
import json,hashlib,re
from collections import Counter

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'outputs/H12_preprint'
report={
 'scope':'Targeted overlap review; not a full proof audit of the two papers or exhaustive priority search',
 'papers':[
  {'file':'RAZ_Polujan_Alexandr_2026.pdf','pages':15,'doi':'10.1109/TIT.2026.3685133','publication':'IEEE Transactions on Information Theory 72(6), 4341-4351 (2026)',
   'overlap_checks':{'cubic_classification':'ten variables, not the target quartic space','maximum_degree_family':'n/2: degree six at n=12','quartic_family':'Theorem V.6: n=2m, m odd, 3 does not divide m; excludes n=12'},
   'visually_checked_pages':[6,8,13],'result':'No stated H(12,4) theorem or counterexample identified'},
  {'file':'2026-1799.pdf','pages':22,'url':'https://eprint.iacr.org/2026/1799','status':'Preprint, IACR ePrint 2026/1799',
   'overlap_checks':{'Theorem4.5':'n=30*7^j, j>=0','Theorem5.4':'n=70*t, t>=1','target_dimension_in_either_parameter_set':False},
   'visually_checked_pages':[14,18],'result':'Neither construction includes n=12'}],
 'editorial_action':'Cite published Polujan-Kudin-Pasalic paper; discuss Tang as a preprint in the introduction; emphasize degree versus homogeneity',
 'notation_warning':'Algebraic degree is invariant under invertible affine input changes, but homogeneity is not. Do not infer coordinate homogeneity from univariate exponents.'}
for item in report['papers']:
 item['sha256']=hashlib.sha256((Path(r'C:/Users/Valer/Downloads')/item['file']).read_bytes()).hexdigest()

# Concrete positive control from Eq. (IV.1), n=12, m=6.
# It has the antipodal quadratic part plus degrees five and six.
n=12;m=6
terms=set()
def toggle(mask):
 if mask in terms:terms.remove(mask)
 else:terms.add(mask)
for i in range(m):toggle((1<<i)|(1<<(i+m)))
for i in range(n):
 mask=sum(1<<((i+j)%n) for j in range(m-1))
 toggle(mask);toggle(mask|(1<<((i+m)%n)))
anf=[0]*4096
for mask in terms:anf[mask]=1
values=anf[:]
for j in range(12):
 for x in range(4096):
  if x>>j&1:values[x]^=values[x^(1<<j)]
walsh=[1-2*v for v in values]
step=1
while step<4096:
 for start in range(0,4096,2*step):
  for j in range(start,start+step):a,b=walsh[j],walsh[j+step];walsh[j]=a+b;walsh[j+step]=a-b
 step*=2
assert set(map(abs,walsh))=={64}
counts=dict(sorted(Counter(x.bit_count() for x in terms).items()))
assert counts=={2:6,5:12,6:12}
assert {((x<<1)&4095)|(x>>11) for x in terms}==terms
report['positive_control']={'source':'Polujan-Kudin-Pasalic Eq. (IV.1), n=12, m=6','anf_terms_by_degree':counts,'all_4096_walsh_absolute_values':64,'rotation_symmetric':True,'homogeneous':False,'purpose':'Confirms the interpretation of the construction; not a CUDA pipeline benchmark'}
(OUT/'LITERATURE_OVERLAP_AUDIT.json').write_text(json.dumps(report,indent=2)+'\n')

p=OUT/'H12_preprint.md';text=p.read_text(encoding='utf-8')
needle='For twelve variables, the prime-factor hypotheses'
assert needle in text
addition='''Rotation symmetry alone does not exclude bentness above degree two. Recent constructions of Polujan, Kudin and Pasalic [6] produce rotation symmetric bent functions outside the completed Maiorana--McFarland class. Their quartic family has $n=2m$ with $m$ odd and $3\\nmid m$, while their maximum-degree family has degree six when $n=12$. Tang's preprint (Cryptology ePrint Archive 2026/1799, https://eprint.iacr.org/2026/1799) gives constructions in dimensions $30\\cdot7^j$ and $70t$, neither of which includes twelve. These existence results concern a different question from homogeneous quartic nonexistence. Here homogeneity refers to the whole algebraic normal form, rather than just its maximum degree.

'''
text=text.replace(needle,addition+needle)
text+='\n[6] Polujan, A., Kudin, S., Pasalic, E.: Rotation-symmetric bent functions outside the completed Maiorana--McFarland class. IEEE Trans. Inf. Theory **72**(6), 4341–4351 (2026). https://doi.org/10.1109/TIT.2026.3685133\n'
head,tail=text.split('## References',1)
order=list(dict.fromkeys(int(x) for x in re.findall(r'\[(\d+)\]',head)))
mapping={old:i+1 for i,old in enumerate(order)};assert set(mapping)==set(range(1,7))
change=lambda s:re.sub(r'\[(\d+)\]',lambda m:'['+str(mapping[int(m.group(1))])+']',s)
head=change(head)
entries=[change(line) for line in tail.splitlines() if re.match(r'^\[\d\]',line)]
entries.sort(key=lambda s:int(re.match(r'\[(\d+)\]',s).group(1)))
text=head+'## References\n\n'+'\n\n'.join(entries)+'\n'
p.write_text(text,encoding='utf-8')
src=(ROOT/'work/prepare_h12_preprint.py').read_text(encoding='utf-8');chunk=src[src.index('def inline'):src.index('pkg=OUT/')]
exec(chunk,{'re':re,'text':text,'OUT':OUT})
print(json.dumps(report['positive_control'],indent=2))
