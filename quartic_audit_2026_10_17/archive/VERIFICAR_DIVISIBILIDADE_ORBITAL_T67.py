"""Complete generator-overlap checks imply a statement for every coefficient vector."""
from pathlib import Path
from itertools import combinations
import json,time
root=Path(__file__).resolve().parent;start=time.perf_counter();seen=set();generators=[]
for indices in combinations(range(16),4):
 m=sum(1<<j for j in indices)
 if m in seen:continue
 orbit=sorted({((m<<j)|(m>>(16-j)))&65535 for j in range(16)});seen.update(orbit);generators.append(orbit)
seen=set();odd=[];even=[]
for x in range(65536):
 if x in seen:continue
 orbit={((x<<j)|(x>>(16-j)))&65535 for j in range(16)};seen.update(orbit)
 if len(orbit)==16:(odd if x.bit_count()%2 else even).append(x)
assert len(generators)==116 and len(odd)==2048 and len(even)==2032
def incidence(reps):
 return [sum((sum((r&m)==m for m in orbit)%2)<<i for i,r in enumerate(reps)) for orbit in generators]
O=incidence(odd);E=incidence(even)
assert all(v.bit_count()%8==0 for v in O)
pairs=0;triples=0
for i,j in combinations(range(116),2):assert (O[i]&O[j]).bit_count()%4==0;pairs+=1
for i,j,k in combinations(range(116),3):assert (O[i]&O[j]&O[k]).bit_count()%2==0;triples+=1
L=[i for i,v in enumerate(E) if v.bit_count()%4];T=[i for i,v in enumerate(E) if v.bit_count()%8==4]
assert L==[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106] and T==[23,31,39,112]
assert all((E[i]&E[j]).bit_count()%2==0 for i,j in combinations(range(116),2))
even_odd_triples=sum((E[i]&E[j]&E[k]).bit_count()%2 for i,j,k in combinations(range(116),3));assert even_odd_triples==128
Wones=sum((1-2*(sum((x&m)==m for m in generators[115])%2))*(1-2*(x.bit_count()%2)) for x in range(65536));assert Wones==16
assert -32*(E[115].bit_count()-O[115].bit_count())==256
result={'verification':'PASS','odd_generators_checked':116,'odd_pairs_checked':pairs,'odd_triples_checked':triples,'conclusion':'The number of full odd-weight input orbits with f=1 is divisible by 8 for every function in H(16,4).','proof':'Inclusion-exclusion for XOR weights: singleton terms are divisible by8, pair terms have coefficient-2 and intersections divisible by4, triple terms have coefficient4 and even intersections; all higher coefficients are divisible by8.','even_generator_exception_sets_verified':True,'even_triples_with_odd_intersection':even_odd_triples,'outside_core_counterexample_actual_Wones':Wones,'seconds':time.perf_counter()-start,'scope':'Complete finite overlap verification plus algebraic implication. Does not establish nonexistence or novelty.'}
(root/'T67_DIVISIBILIDADE_ORBITAL_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
