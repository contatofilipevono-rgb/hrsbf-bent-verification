"""Independent full rank replay for the seven-condition U38 weighted bound."""
from pathlib import Path
from fractions import Fraction
from collections import Counter
import json,time,sys
root=Path(__file__).resolve().parent;start=time.perf_counter();D=json.loads((root/'T91_U38_ENUMERACAO_MATRIZES.json').read_text());A=json.loads((root/'T89_U38_MATRIZES_AFINS_CERTIFICADO.json').read_text());S=json.loads((root/'T31_SETIMA_CERTIFICADO.json').read_text());chosen=D['chosen_free_indices'];L=set(S['L']);selected=list(range(7,15));pairs=A['pair_order'];basis=[[int(v,16) for v in c] for c in D['basis_matrices_hex']]
blocks=[[0,4,8,18,42,52,56,94],[14,22,46,71,81,85,98,106],[1,9,15,28,53,67,76,103],[3,11,34,45,55,69,78,89],[2,10,25,37,54,68,83,104],[12,20,29,33,41,48,96,110],[13,21,38,70,74,93,97,109],[24,32,47,72,80,86,91,107]];masks=[sum(1<<j for j in b) for b in blocks]
def rank_lsb(rows):
 pivots={}
 for v in rows:
  while v:
   p=v&-v
   if p in pivots:v^=pivots[p]
   else:pivots[p]=v;break
 return len(pivots)
def unpack(m):
 rows=[0]*38
 for k,(i,j) in enumerate(pairs):
  if m>>k&1:rows[i]|=1<<j;rows[j]|=1<<i
 return rows
def rank_msb(rows):
 pivots=[0]*38;r=0
 for v in rows:
  while v:
   p=v.bit_length()-1
   if pivots[p]:v^=pivots[p]
   else:pivots[p]=v;r+=1;break
 return r
weights=[]
for b in range(2):
 rows=[];c=b*((1<<0)|(1<<99));old=0
 for n in range(32768):
  g=n^(n>>1)
  if n:
   bit=(g^old).bit_length()-1;j=chosen[bit];c^=(1<<j)^((1<<0) if j in L else 0)
  old=g;u1,v1,u2,v2,u3,v3,u4,v4=[(c&m).bit_count()%2 for m in masks];assert u1^v1==b
  K=u2^v2^u4^v4;M=u3^v3;J1=v2^u4;J2=u2^v4;J3=v3^u4^v4;count=0
  for a in (0,1):
   if b and a!=K:continue
   if b or K or (M^J1) or (M^J2):count+=8
   else:
    R=((1^b)&M)^((1^a)&K);constant=b^K^M^(R&J3)^(a&K)
    if not constant:count+=16
  rows.append(count)
 weights.append(rows)
assert [sum(w) for w in weights]==[589824,262144]
histograms=[];numerator=0
first,last=(int(sys.argv[1]),int(sys.argv[2])) if len(sys.argv)>2 else (128,256)
for character in range(first,last):
 changes=[]
 for b in basis:
  packed=0
  for j,r in enumerate(selected):
   if character>>j&1:packed^=b[r]
  changes.append(unpack(packed))
 bybranch=[]
 for branch in range(2):
  packed=0
  for j,r in enumerate(selected):
   if character>>j&1:packed^=int(D['branches'][branch]['constant_matrices_hex'][r],16)
  current=unpack(packed);counts=Counter();previous=0
  for ordinal,weight in enumerate(weights[branch]):
   gray=ordinal^(ordinal>>1)
   if ordinal:
    change=changes[(gray^previous).bit_length()-1];current=[x^y for x,y in zip(current,change)]
   previous=gray
   if weight:
    rank=rank_lsb(current);assert rank==rank_msb(current);assert not rank%2;counts[rank]+=weight
  bybranch.append(dict(sorted(counts.items())));numerator+=sum(amount*(1<<(19-rank//2)) for rank,amount in counts.items())
 histograms.append({'character':character,'weighted_rank_histograms':bybranch})
 if character%8==0:print('independent characters',character,'/127',round(time.perf_counter()-start,1),'s',flush=True)
if len(sys.argv)>2:
 (root/f'T96_PARCIAL_{first}_{last}.json').write_text(json.dumps({'first':first,'last':last,'histograms':histograms,'numerator':numerator,'dual_rank_check':True,'seconds':time.perf_counter()-start},indent=2));sys.exit(0)
raise RuntimeError('Use two range arguments to write an exhaustive character partition.')
