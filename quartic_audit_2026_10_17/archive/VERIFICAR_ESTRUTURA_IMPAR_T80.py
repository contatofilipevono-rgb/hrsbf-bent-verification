"""Complete divisibility checks imply W(0)=W(ones) for bent candidates."""
import runpy,json,time
from pathlib import Path
from itertools import combinations
root=Path(__file__).resolve().parent;start=time.perf_counter();ctx=runpy.run_path(str(root/'VERIFICAR_NOVA_AMOSTRA_WALSH_T66.py'));words=ctx['words'];input_orbits=ctx['input_orbits'];details=[]
for weight in [1,3]:
 reps=[]
 for orbit in input_orbits:
  if len(orbit)!=16:continue
  x=orbit[0];q=(x^(x>>4)^(x>>8)^(x>>12))&15
  if q.bit_count()==weight:reps.append(x)
 assert len(reps)==1024
 columns=[sum((word>>x&1)<<i for i,x in enumerate(reps)) for word in words]
 assert all(w.bit_count()%8==0 for w in columns)
 assert all((columns[i]&columns[j]).bit_count()%4==0 for i,j in combinations(range(116),2))
 assert all((columns[i]&columns[j]&columns[k]).bit_count()%2==0 for i,j,k in combinations(range(116),3))
 details.append({'quotient_Hamming_weight':weight,'full_input_orbits':len(reps),'single_checks':116,'pair_checks':6670,'triple_checks':253460})
for orbit in input_orbits:
 x=orbit[0];q=(x^(x>>4)^(x>>8)^(x>>12))&15
 C=sum((1-2*((0x1111&v).bit_count()%2))-(1-2*((0x7777&v).bit_count()%2)) for v in orbit)
 expected=16 if q.bit_count()==1 else -16 if q.bit_count()==3 else 0
 assert C==expected
 # Short orbits always have even total weight; the entire odd part consists
 # of complete orbits in these two quotient classes.
 assert (x.bit_count()%2)==(q.bit_count()%2)
 assert len(orbit)==16 or x.bit_count()%2==0
result={'verification':'PASS','complete_divisibility_checks':details,'Walsh_difference_identity':'W1111-W7777=-32*(w_class1-w_class3)','odd_class_divisibility':'w_class1 and w_class3 are divisible by8 for every coefficient vector.','necessary_bent_consequences':['w_class1+w_class3=1024','W0=Wones','(w_class1,w_class3) belongs to {(504,520),(512,512),(520,504)}'],'proof':'Bent amplitudes at1111 and7777 force their count difference to be divisible by16. Each class count is divisible by8, so their sum is divisible by16. W0-Wones=65536-64*(their sum) is then divisible by1024; two values in {+256,-256} can have such a difference only if equal. This forces the sum to1024. The first difference restricts the pair to the three displayed possibilities.','seconds':time.perf_counter()-start,'scope':'Necessary structural statement for H(16,4), not a nonexistence proof or a claim of bibliographic novelty.'}
(root/'T80_ESTRUTURA_IMPAR_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
