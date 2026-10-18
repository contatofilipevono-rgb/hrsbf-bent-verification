"""Exhaustive degree-three coefficient audit on U38 (not random cubes)."""
from pathlib import Path
from itertools import combinations
import sys,json,time,contextlib,io
base=(Path(sys.argv[1]) if len(sys.argv)>1 else Path('work/gemini_adversarial_20261017')).resolve();sys.path.insert(0,str(base));sys.dont_write_bytecode=True
from check_joint_cubic_rank_and_syzygies import build_orbits,compute_zeta_bits
from inspect_26_quadratic_in_U_conditions import find_nullspace
with contextlib.redirect_stdout(io.StringIO()):
 from verify_14parity_normal_form import blocks,P_2laws
start=time.perf_counter();seven=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text());factor=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())['fourth_factorization']
qvars={0,5,23,57,99,113,115,31,39,112}|set(seven['K'])
for p in factor['products']:qvars.update(p['I']);qvars.update(p['J'])
Uvars=sorted(set(range(116))-qvars)
forms=[set(blocks['R1']+blocks['R2']+blocks['R3']+blocks['R4']),set(blocks['R2']+blocks['R3']),set(blocks['R2']+blocks['W1']),set(blocks['R3']+blocks['W2']),set(blocks['R1']+blocks['W3'])]
pivots={};U=[]
for j in Uvars:
 s=sum((j in f)<<i for i,f in enumerate(forms));v=1<<j
 while s:
  p=s.bit_length()-1
  if p not in pivots:pivots[p]=(s,v);break
  a,b=pivots[p];s^=a;v^=b
 if not s:U.append(v)
assert len(U)==38
def toggle(S,m):
 if m in S:S.remove(m)
 else:S.add(m)
def derivative(P,d):
 R=set()
 for m in P:
  s=m&d
  while s:toggle(R,m^s);s=(s-1)&(m&d)
 return R
for v in U:
 assert not derivative(P_2laws,v)
 assert all((v&sum(1<<j for j in seven[name])).bit_count()%2==0 for name in ['L','K','M','R'])
 assert all(not (v&sum(1<<j for j in p[side])) for p in factor['products'] for side in ['I','J'])
print('symbolic translation invariance PASS',flush=True)
subsets=[()] + [(i,) for i in range(38)] + list(combinations(range(38),2)) + list(combinations(range(38),3));index={t:i for i,t in enumerate(subsets)};pts=[]
for t in subsets:
 v=0
 for i in t:v^=U[i]
 pts.append(v)
orbits,_=build_orbits(4);_,r11=build_orbits(11);_,r12=build_orbits(12);periodic={0x3f3f,0x5f5f,0x6f6f,0x7777};r12=[v for v in r12 if v not in periodic]
print('evaluating complete coefficient set',len(pts),flush=True)
_,_,b2,_,_=compute_zeta_bits(pts,orbits)
triples=list(combinations(range(38),3));rows=[]
for support in r11+r12:
 values=b2[support];row=0
 for k,(i,j,l) in enumerate(triples):
  parity=(values>>index[()]&1)^(values>>index[(i,)]&1)^(values>>index[(j,)]&1)^(values>>index[(l,)]&1)^(values>>index[(i,j)]&1)^(values>>index[(i,l)]&1)^(values>>index[(j,l)]&1)^(values>>index[(i,j,l)]&1)
  row|=parity<<k
 rows.append(row)
null11=find_nullspace(rows[:len(r11)]);null12=find_nullspace(rows[len(r11):]);null=find_nullspace(rows)
print('EXACT cubic nullities',len(null11),len(null12),len(null),flush=True)
for v in null:
 result=0
 for j,row in enumerate(rows):
  if v>>j&1:result^=row
 assert result==0
certificate={'verification':'PASS','scope':'Exact U38 translation invariance and complete third-degree coefficient matrix. All 8436 basis triples tested, no random cubes. The degree upper bound <=3 follows from the carry-free covering formula; no uniform coset-rank bound is claimed.','basis_hex':[hex(v) for v in U],'evaluation_points':len(pts),'basis_triples':len(triples),'supports_hex':[hex(v) for v in r11+r12],'cubic_rows_hex':[hex(v) for v in rows],'nullity_w11':len(null11),'nullity_w12':len(null12),'nullity_joint':len(null),'quadratic_combinations_hex':[hex(v) for v in null],'seconds':time.perf_counter()-start}
(Path(__file__).resolve().parent/'T88_U38_COEFICIENTES_EXATOS.json').write_text(json.dumps(certificate,indent=2));print({k:v for k,v in certificate.items() if not isinstance(v,list)},flush=True)
