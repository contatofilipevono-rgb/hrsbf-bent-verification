"""Fast consistency audit of the U38 certificate chain; not a fresh full rank replay."""
from pathlib import Path
from fractions import Fraction
import json,time
root=Path(__file__).resolve().parent;start=time.perf_counter()
def read(name):return json.loads((root/name).read_text())
def rank(rows):
 basis={}
 for v in rows:
  while v:
   p=v.bit_length()-1
   if p in basis:v^=basis[p]
   else:basis[p]=v;break
 return len(basis)
C=read('T88_U38_COEFICIENTES_EXATOS.json');rows=[int(v,16) for v in C['cubic_rows_hex']];combos=[int(v,16) for v in C['quadratic_combinations_hex']];assert len(rows)==385 and rank(rows)==359 and rank(combos)==26
for combo in combos:
 value=0
 for j,row in enumerate(rows):
  if combo>>j&1:value^=row
 assert value==0
A=read('T89_U38_MATRIZES_AFINS_CERTIFICADO.json');D=read('T91_U38_ENUMERACAO_MATRIZES.json');columns=[[int(v,16) for v in c] for c in A['coefficient_matrices_hex']];basis=[[int(v,16) for v in c] for c in D['basis_matrices_hex']];parities=[int(v,16) for v in D['parameter_parities_hex']];S=read('T31_SETIMA_CERTIFICADO.json');L=set(S['L'])
def flat(col):return sum(v<<(703*j) for j,v in enumerate(col))
assert rank([flat(c) for c in columns])==16 and rank([flat(c) for c in basis])==15
for j in D['T20_free_indices']:
 col=columns[j][:]
 if j in L:col=[a^b for a,b in zip(col,columns[0])]
 if j==57:col=[a^b for a,b in zip(col,columns[113])]
 actual=[0]*26
 for m,b in zip(parities,basis):
  if m>>j&1:actual=[a^c for a,c in zip(actual,b)]
 assert col==actual
for raw in C['basis_hex']:
 u=int(raw,16);value=0
 for j,col in enumerate(columns):
  if u>>j&1:value^=flat(col)
 assert value==0
G=read('T97_U38_BLOCOS_DE_PARIDADE.json');assert len(G['blocks'])==16 and all(len(g)==4 for g in G['blocks'])
for group in G['blocks']:
 assert all(columns[j]==columns[group[0]] for j in group)
assert set(sum((G['blocks'][i] for i in G['T20_b_equals_sum_of_block_parities']),[]))==L
seven=read('T92_U38_LIMITE_PONDERADO.json');eight=read('T96_U38_LIMITE_OITO_CONDICOES.json');verified=read('T94_LIMITE_U38_VERIFICACAO.json');assert verified['verification']=='PASS' and verified['pass_upper_bound']==seven['pass_upper_bound']
assert eight['character_histograms'][:127]==seven['character_histograms']
one=root/'T96_PARCIAL_128_256.json'
parts=[read(one.name)] if one.exists() else [read(f'T96_PARCIAL_{a}_{a+16}.json') for a in range(128,256,16)]
new=[]
for part in parts:assert part['dual_rank_check'];new+=part['histograms']
assert new==eight['character_histograms'][127:]
for target,k in [(seven,7),(eight,8)]:
 assert [r['character'] for r in target['character_histograms']]==list(range(1,1<<k));num=(589824+262144)*(1<<19)
 for row in target['character_histograms']:
  for b,h in enumerate(row['weighted_rank_histograms']):
   assert sum(h.values())==[589824,262144][b]
   for r,v in h.items():
    r=int(r);assert 0<=r<=38 and not r%2 and v>=0;num+=v*(1<<(19-r//2))
 bound=Fraction(num,1<<(26+k+19));assert [bound.numerator,bound.denominator]==target['pass_upper_bound']
bound=Fraction(*eight['pass_upper_bound']);percent=100*(1-bound);scaled=percent.numerator*10**10//percent.denominator;safe=f'{scaled//10**10}.{scaled%10**10:010d}'
result={'verification':'PASS','scope':'Fast certificate consistency audit: complete cubic nullspace, affine compression, translation kernel, parity blocks, exhaustive-character records and rational aggregation. This does not replace rerunning the original coefficient producers and full rank enumerations.','pass_upper_bound':[bound.numerator,bound.denominator],'excluded_percent_safe_lower':safe,'seconds':time.perf_counter()-start}
(root/'T98_CADEIA_U38_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(result)
