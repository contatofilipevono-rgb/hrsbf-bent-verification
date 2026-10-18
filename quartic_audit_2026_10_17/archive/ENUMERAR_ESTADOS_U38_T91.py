"""Enumerate the full 15-bit image of all 26 polar matrices under T20, each b."""
import json,time,math,base64,zlib,sys
from pathlib import Path
root=Path(__file__).resolve().parent
from collections import Counter
start=time.perf_counter();data=json.loads((root/'T89_U38_MATRIZES_AFINS_CERTIFICADO.json').read_text());cols=[[int(v,16) for v in c] for c in data['coefficient_matrices_hex']];B0=[int(v,16) for v in data['constant_matrices_hex']];pairs=[tuple(p) for p in data['pair_order']];seven=json.loads((root/'T31_SETIMA_CERTIFICADO.json').read_text());L=set(seven['L']);free=data['T20_free_indices']
def flat(c):return sum(v<<(703*k) for k,v in enumerate(c))
def echelon(columns):
 pivots={};independent=[];coordinates=[]
 for v in columns:
  coord=0
  while v:
   p=v.bit_length()-1
   if p in pivots:a,c=pivots[p];v^=a;coord^=c
   else:
    bit=1<<len(independent);pivots[p]=(v,coord^bit);independent.append(len(coordinates));coord=bit;break
  coordinates.append(coord)
 return independent,coordinates
tcols=[]
for j in free:
 col=cols[j][:]
 if j in L:col=[a^b for a,b in zip(col,cols[0])]
 if j==57:col=[a^b for a,b in zip(col,cols[113])]
 tcols.append(col)
indices,coords=echelon([flat(c) for c in tcols]);assert len(indices)==15
basis=[tcols[i] for i in indices]
for col,co in zip(tcols,coords):
 reconstructed=[0]*26
 for j,v in enumerate(basis):
  if co>>j&1:reconstructed=[a^b for a,b in zip(reconstructed,v)]
 assert reconstructed==col
parities=[sum(1<<j for j,co in zip(free,coords) if co>>k&1) for k in range(15)]
def unpack(packed):
 rows=[0]*38
 for k,(i,j) in enumerate(pairs):
  if packed>>k&1:rows[i]^=1<<j;rows[j]^=1<<i
 return rows
def rank(rows):
 basis={}
 for v in rows:
  while v:
   p=v.bit_length()-1
   if p in basis:v^=basis[p]
   else:basis[p]=v;break
 return len(basis)
basisrows=[[unpack(m) for m in col] for col in basis];reports=[]
for branch in [0,1]:
 constant=[a^(b if branch else 0) for a,b in zip(B0,cols[0])];current=[unpack(m) for m in constant];hist=[Counter() for _ in range(26)];best_hist=Counter();worst=[];old=0;signature_rank=Counter();case_rows=[]
 for ordinal in range(1<<15):
  gray=ordinal^(ordinal>>1)
  if ordinal:
   j=(gray^old).bit_length()-1
   current=[[a^b for a,b in zip(r,s)] for r,s in zip(current,basisrows[j])]
  old=gray;ranks=[rank(r) for r in current];assert all(r%2==0 for r in ranks)
  for h,r in zip(hist,ranks):h[r]+=1
  best_hist[max(ranks)]+=1
  if max(ranks)==0:worst.append(gray)
  case_rows.append(ranks)
  if ordinal%8192==8191:print('branch',branch,'states',ordinal+1,'elapsed',round(time.perf_counter()-start,1),flush=True)
 reports.append({'branch':branch,'states':32768,'constant_matrices_hex':[hex(v) for v in constant],'rank_histogram_per_combination':[dict(sorted(h.items())) for h in hist],'best_of_26_rank_histogram':dict(sorted(best_hist.items())),'all_matrices_zero_gray_states':worst,'rank_vectors_zlib_base64':base64.b64encode(zlib.compress(bytes(r for row in case_rows for r in row))).decode(),'rank_vector_encoding':'32768 Gray-order states, 26 unsigned rank bytes per state; zlib then base64'})
result={'verification':'PASS','scope':'All matrix images under the three T20 laws, separately for each b. Additional core restrictions may exclude some states; no assumption of uniformity after nonlinear filters. Individual rank histograms do not describe ranks of all 2^26-1 combinations.','image_dimension_per_branch':15,'T20_free_indices':free,'parameter_parities_hex':[hex(v) for v in parities],'chosen_free_indices':[free[i] for i in indices],'basis_matrices_hex':[[hex(v) for v in col] for col in basis],'branches':reports,'seconds':time.perf_counter()-start}
(root/'T91_U38_ENUMERACAO_MATRIZES.json').write_text(json.dumps(result,indent=2));print({k:v for k,v in result.items() if k not in ['branches','basis_matrices_hex','parameter_parities_hex','T20_free_indices']},flush=True)
for report in reports:print('branch',report['branch'],'best-rank histogram',report['best_of_26_rank_histogram'],'all-zero states',report['all_matrices_zero_gray_states'],flush=True)
