from itertools import combinations
from pathlib import Path
import json,random,time

N=8
def reg(p,off=0):
 m=p.bit_length()-1
 A={(1<<(off+i))|(1<<(off+m+i)) for i in range(m)}
 B={(1<<(off+j+1))|(1<<(off+m+j)) for j in range(m-1)}
 B|={(1<<(off+i))|(1<<(off+2*m-1)) for i in range(m) if p>>i&1}
 return A,B,2*m
def product(A,B,exterior=False):
 out=set()
 for a in A:
  for b in B:
   if exterior and a&b:continue
   t=a|b
   if t in out:out.remove(t)
   else:out.add(t)
 return out
def tau_high(D):
 out=0
 for a,b in combinations(D,2):
  if (a|b).bit_count()>=6:out^=1<<(a|b)
 return out
def solve_cols(cols,target):
 piv={}
 for j,v in enumerate(cols):
  rel=1<<j
  while v:
   p=v.bit_length()-1
   if p not in piv:piv[p]=(v,rel);break
   v^=piv[p][0];rel^=piv[p][1]
 rel=0
 while target:
  p=target.bit_length()-1
  if p not in piv:return None
  target^=piv[p][0];rel^=piv[p][1]
 return rel
def all_subspaces(n,k):
 for piv in combinations(range(n),k):
  slots=[(r,j) for r,p in enumerate(piv) for j in range(p+1,n) if j not in piv]
  for bits in range(1<<len(slots)):
   basis=[1<<p for p in piv]
   for h,(r,j) in enumerate(slots):
    if bits>>h&1:basis[r]^=1<<j
   yield basis
def tables(A):
 rows=[0]*8
 for mask in A:
  i,j=[i for i in range(8) if mask>>i&1];rows[i]^=1<<j;rows[j]^=1<<i
 vals=[]
 for v in range(256):
  r=0
  for i in range(8):
   if v>>i&1:r^=rows[i]
  vals.append([(r&w).bit_count()%2 for w in range(256)])
 return vals
def zero_top(basis,a,b):
 k=len(basis)
 ar={(i,j):a[basis[i]][basis[j]] for i,j in combinations(range(k),2)}
 br={(i,j):b[basis[i]][basis[j]] for i,j in combinations(range(k),2)}
 for ids in combinations(range(k),4):
  z=0
  for pair in combinations(ids,2):
   other=tuple(i for i in ids if i not in pair)
   z^=ar[pair]&br[other]
  if z:return False
 return True
results=[];start=time.time()
for label,blocks in [('F4_F4',[7,7]),('F4_squared',[21]),('irr4_19',[19]),('irr4_25',[25]),('irr4_31',[31])]:
 A=set();B=set();off=0
 for p in blocks:
  a,b,n=reg(p,off);A|=a;B|=b;off+=n
 D=product(A,B);quadratics=[(1<<i)|(1<<j) for i,j in combinations(range(8),2)]
 target=tau_high(D)
 cols=[tau_high(D^{q})^target for q in quadratics]
 sol=solve_cols(cols,target)
 witness=None;i7=None;i7_failure=None;direct_i6=None;affine6_count=0;direct_i7_count=0;lift_check=None
 if sol is not None:
  witness=D^{q for i,q in enumerate(quadratics) if sol>>i&1}
  values=[sum(int((v&m)==m) for m in witness)%2 for v in range(256)]
  coeff=values[:]
  for i in range(8):
   for m in range(256):
    if m>>i&1:coeff[m]-=coeff[m^(1<<i)]
  assert all(coeff[m]%4==0 for m in range(256) if m.bit_count()>=6)
  # Direct Walsh on all seven-flats, from the exact ambient transform.
  walsh=[1-2*v for v in values]
  for bit in range(8):
   for m in range(256):
    if not m>>bit&1:
     u,v=walsh[m],walsh[m|(1<<bit)]
     walsh[m]=u+v;walsh[m|(1<<bit)]=u-v
  i7=True
  for ell in range(1,256):
   for u in range(1,256):
    if u==ell:continue
    for sign in [-1,1]:
     w=(walsh[u]+sign*walsh[u^ell])//2
     if w%16:
      i7=False;i7_failure={'ell':ell,'u':u,'sign':sign,'Walsh':w};break
    if not i7:break
   if not i7:break
  lift_check=all(coeff[m]%(4 if m.bit_count()==6 else 8)==0 for m in range(256) if m.bit_count()>=6)
  assert lift_check==i7
  # Independent direct restriction and Walsh transform for every seven-flat.
  direct_all=True
  for h in all_subspaces(8,7):
   span=[0]
   for v in h:span += [z^v for z in span]
   unseen=set(range(256))
   while unseen:
    off=min(unseen);coset=[off^z for z in span]
    local=[1-2*values[z] for z in coset]
    for bit in range(7):
     for m in range(128):
      if not m>>bit&1:
       u,v=local[m],local[m|(1<<bit)]
       local[m]=u+v;local[m|(1<<bit)]=u-v
    if any(w%16 for w in local[1:]):direct_all=False
    unseen.difference_update(coset);direct_i7_count+=1
  assert direct_i7_count==510 and direct_all==i7
 # Exhaust all six-dimensional subspaces; if none works, no larger one works.
 a=tables(A);b=tables(B);count=0;isotropic6=[]
 for basis in all_subspaces(8,6):
  count+=1
  if zero_top(basis,a,b):isotropic6.append(basis)
  if witness is not None:
   # For degree <=4 in six variables, all Walsh coefficients agree
   # modulo 8: intersections with a linear function have even weight.
   # Therefore the weight mod4 tests I6, including every affine coset.
   span=[0]
   for v in basis:span += [z^v for z in span]
   unseen=set(range(256))
   while unseen:
    off=min(unseen);coset=[off^z for z in span]
    assert sum(values[z] for z in coset)%4==0
    unseen.difference_update(coset);affine6_count+=1
 assert count==10795
 iso5=next((basis for basis in all_subspaces(8,5) if zero_top(basis,a,b)),None)
 assert iso5 is not None
 out={'label':label,'blocks':blocks,'R2_sufficient':sol is not None,'D_ANF_masks':sorted(witness) if witness is not None else None,'direct_I6_affine_flats_checked':affine6_count,'I7':i7,'direct_I7_affine_flats_checked':direct_i7_count,'liftability_integer_coefficients':lift_check,'I7_counterexample':i7_failure,'dimension6_subspaces_tested':count,'dimension6_zeros':len(isotropic6),'dimension5_witness':iso5}
 results.append(out);print(json.dumps(out),flush=True)
(Path(__file__).resolve().parent/'CONTROLE_INDEPENDENTE_POSTO8_07NOV.json').write_text(json.dumps({'scope':'Cinco pencils regulares em oito variaveis; nao classifica as 101 classes nem reexecuta decide2.py. I6 do testemunho usa equivalencia com perfil mod4 completo.','cases':results,'seconds':time.time()-start},indent=2),encoding='utf-8')
