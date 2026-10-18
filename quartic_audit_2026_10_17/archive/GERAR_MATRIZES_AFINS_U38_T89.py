"""Exact affine coefficient matrices on U38 for all 26 certified combinations."""
from pathlib import Path
root=Path(__file__).resolve().parent
from itertools import combinations
import sys,json,time,random
base=(Path(sys.argv[1]) if len(sys.argv)>1 else Path('work/gemini_adversarial_20261017')).resolve();sys.path.insert(0,str(base));sys.dont_write_bytecode=True
from check_joint_cubic_rank_and_syzygies import build_orbits,compute_zeta_bits
start=time.perf_counter();cert=json.loads((root/'T88_U38_COEFICIENTES_EXATOS.json').read_text());U=[int(v,16) for v in cert['basis_hex']];supports=[int(v,16) for v in cert['supports_hex']];combos=[int(v,16) for v in cert['quadratic_combinations_hex']];pairs=list(combinations(range(38),2));orbits,_=build_orbits(4)
offsets=[0]+U+[U[i]^U[j] for i,j in pairs];assert len(offsets)==742
def matrices(c):
 _,_,b2,_,_=compute_zeta_bits([c^v for v in offsets],orbits);evaluations=[b2[s] for s in supports];result=[]
 for combo in combos:
  v=0;m=combo
  while m:
   a=m&-m;v^=evaluations[a.bit_length()-1];m^=a
  a0=v&1;single=[v>>(i+1)&1 for i in range(38)];row=0
  for k,(i,j) in enumerate(pairs):row|=((v>>(39+k)&1)^a0^single[i]^single[j])<<k
  result.append(row)
 return result
B0=matrices(0);columns=[]
for j in range(116):
 Bj=matrices(1<<j);columns.append([v^z for v,z in zip(Bj,B0)])
 if j%12==11:print('coefficient matrices',j+1,'/116',round(time.perf_counter()-start,1),'s',flush=True)
def flatten(rows):return sum(row<<(703*k) for k,row in enumerate(rows))
def linear_rank(cols):
 pivots={};null=[]
 for j,v in enumerate(cols):
  witness=1<<j
  while v:
   p=v.bit_length()-1
   if p not in pivots:pivots[p]=(v,witness);break
   a,b=pivots[p];v^=a;witness^=b
  if not v:null.append(witness)
 return len(pivots),null
rank,kernel=linear_rank([flatten(c) for c in columns]);zero=[j for j,col in enumerate(columns) if not any(col)]
for d in U:
 v=[0]*26
 for j in range(116):
  if d>>j&1:v=[a^b for a,b in zip(v,columns[j])]
 assert not any(v)
seven=json.loads((root/'T31_SETIMA_CERTIFICADO.json').read_text());L=set(seven['L']);free=sorted(set(range(116))-{0,99,113,115})
t20cols=[]
for j in free:
 col=columns[j][:]
 if j in L:col=[a^b for a,b in zip(col,columns[0])]
 if j==57:col=[a^b for a,b in zip(col,columns[113])]
 t20cols.append(col)
rank_t20,kernel_t20=linear_rank([flatten(c) for c in t20cols]);zero_t20=[j for j,col in zip(free,t20cols) if not any(col)]
checks=[];rng=random.Random(2026101789)
for _ in range(8):
 c=rng.getrandbits(116);actual=matrices(c);expected=B0[:]
 for j in range(116):
  if c>>j&1:expected=[a^b for a,b in zip(expected,columns[j])]
 assert actual==expected;checks.append(hex(c))
result={'verification':'PASS','scope':'Exact affine map B(c) on the original 116 coefficient variables for the 26 U38 quadratic combinations. Degree <=3 and T88 imply B is affine; origin and all 116 unit vectors determine every coefficient. Fresh tests validate reconstruction. No global rank lower bound claimed.','basis_hex':cert['basis_hex'],'combinations_hex':cert['quadratic_combinations_hex'],'pair_order':pairs,'constant_matrices_hex':[hex(v) for v in B0],'coefficient_matrices_hex':[[hex(v) for v in col] for col in columns],'joint_affine_map_rank_original':rank,'zero_original_coordinates':zero,'kernel_original_hex':[hex(v) for v in kernel],'T20_free_indices':free,'joint_affine_map_rank_T20':rank_t20,'zero_T20_free_coordinates':zero_t20,'fresh_reconstruction_coefficients':checks,'matrix_entries_per_combination':703,'total_affine_coefficient_bits_checked':117*26*703,'seconds':time.perf_counter()-start}
(root/'T89_U38_MATRIZES_AFINS_CERTIFICADO.json').write_text(json.dumps(result,indent=2));print({k:v for k,v in result.items() if k not in ['coefficient_matrices_hex','constant_matrices_hex','pair_order','kernel_original_hex','basis_hex','combinations_hex']},flush=True)
