from pathlib import Path
from itertools import combinations
import json

def wedge(A,B):
 r=set()
 for a in A:
  for b in B:
   if a&b:continue
   m=a|b
   if m in r:r.remove(m)
   else:r.add(m)
 return r
def tau(A,d):
 r=set()
 for a,b in combinations(A,2):
  m=a|b
  if m.bit_count()!=d:continue
  if m in r:r.remove(m)
  else:r.add(m)
 return r
def rank(A,n):
 rows=[0]*n;piv={}
 for m in A:
  i,j=[i for i in range(n) if m>>i&1];rows[i]^=1<<j;rows[j]^=1<<i
 for r in rows:
  while r:
   p=r.bit_length()-1
   if p not in piv:piv[p]=r;break
   r^=piv[p]
 return len(piv)

root=Path(__file__).resolve().parent
source=json.loads((root/'ASTRA_CONTRAEXEMPLO_G7_SSPAN_07NOV.json').read_text())
c=source;p=c['parameters']
D=set(c['Delta']);At=set(c['At']);Bt=set(c['Bt']);Om=set(p['Omega_res']);n=10
A=set(p['A0']);B=set(p['B0'])
assert At==A^wedge({1},set(p['v1']))^wedge({2},set(p['v2']))
assert Bt==B^wedge({1},set(p['u1']))^wedge({2},set(p['u2']))
assert D==wedge(At,Bt)^wedge({3},Om)
assert not tau(D,8)
M3=[sum(1<<i for i in s) for s in combinations(range(n),3)]
M7=[sum(1<<i for i in s) for s in combinations(range(n),7)]
cols=[wedge(D,{m}) for m in M3];rhs=tau(D,7)
piv={};certificate=None
for m in M7:
 row=sum(1<<j for j,col in enumerate(cols) if m in col);b=int(m in rhs);rel=1<<m
 while row:
  p=row.bit_length()-1
  if p not in piv:piv[p]=(row,b,rel);break
  a,c0,s=piv[p];row^=a;b^=c0;rel^=s
 else:
  if b:
   certificate={m for m in M7 if rel>>m&1};break
assert certificate is not None
assert all(len(certificate&col)%2==0 for col in cols)
assert len(certificate&rhs)%2==1
given=set(source['dual_w'])
assert all(len(given&col)%2==0 for col in cols) and len(given&rhs)%2==1
# Direct truth table + integer Mobius, independent of pair-count tau.
coeff=[sum((v&m)==m for m in D)%2 for v in range(1<<n)]
for bit in range(n):
 for m in range(1<<n):
  if m>>bit&1:coeff[m]-=coeff[m^(1<<bit)]
assert all(coeff[m]%4==2*int(m in rhs) for m in M7)
assert all(coeff[m]%4==0 for m in range(1<<n) if m.bit_count()==8)
out={'scope':'Independent check of minimized Astra instance, reconstruction plus integer Mobius.','gamma2_zero':True,'ranks_core':[rank(A,n),rank(B,n),rank(A^B,n)],'ranks_modified':[rank(At,n),rank(Bt,n),rank(At^Bt,n)],'dual_rows':sorted(certificate),'dual_size':len(certificate),'Astra_dual_rows':sorted(given),'Astra_dual_verified':True,'cubic_columns_verified':len(cols),'wT_M':0,'wT_rhs':1,'integer_Mobius_agrees':True}
(root/'CONTROLE_CODEX_CONTRAEXEMPLO_ASTRA_G7_07NOV.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out))
