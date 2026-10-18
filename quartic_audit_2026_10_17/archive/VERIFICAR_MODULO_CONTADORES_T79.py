"""Replay only invertible modular operations; independently count solutions."""
from pathlib import Path
from math import gcd
import json,time
root=Path(__file__).resolve().parent;start=time.perf_counter();data=json.loads((root/'T79_MODULO_CONTADORES_CERTIFICADO.json').read_text());tables=json.loads((root/'T75_PROJECAO_WALSH_CERTIFICADO.json').read_text())['tables'];results=[]
for case in data['cases']:
 table=tables[str(case['d'])];active=[j for j,N in enumerate(table['full_input_orbit_counts']) if N];widths=[(16*table['quotient_class_periods'][j]).bit_length()-1 for j in active]
 assert active==case['active_counter_indices'] and widths==case['counter_widths']
 A=[[row[j]%256 for j in active] for row in table['matrix']];assert A==[[v%256 for v in row] for row in case['matrix']];m=len(A);n=len(A[0])
 assert all((A[i][j]*(1<<widths[j]))%256==0 for i in range(m) for j in range(n))
 for op in case['operations']:
  name=op[0]
  if name=='row_swap':_,i,j=op;A[i],A[j]=A[j],A[i]
  elif name=='column_swap':
   _,i,j=op
   for row in A:row[i],row[j]=row[j],row[i]
  elif name=='row_scale':_,i,k=op;assert gcd(k,256)==1;A[i]=[k*v%256 for v in A[i]]
  elif name=='row_subtract':_,i,j,k=op;assert i!=j;A[i]=[(a-k*b)%256 for a,b in zip(A[i],A[j])]
  elif name=='column_subtract':
   _,i,j,k=op;assert i!=j
   for row in A:row[i]=(row[i]-k*row[j])%256
  else:raise AssertionError(name)
 assert A==case['diagonal_matrix'];r=case['rank_mod_power_of_two'];assert all(A[i][j]==0 for i in range(m) for j in range(n) if i!=j)
 assert all(A[i][i]>0 and 256%A[i][i]==0 for i in range(r));assert all(not A[i][j] for i in range(r,m) for j in range(r,n))
 kernel=256**(n-r)
 for i in range(r):kernel*=A[i][i]
 mult=1<<(8*n-sum(widths));domain=1<<sum(widths);counts=[]
 for parameter in case['parameter_cases']:
  a=parameter['a'];b=parameter['b'];rhs=[(128-64*a-96*b)%256]*m
  for op in case['operations']:
   if op[0]=='row_swap':_,i,j=op;rhs[i],rhs[j]=rhs[j],rhs[i]
   elif op[0]=='row_scale':_,i,k=op;rhs[i]=k*rhs[i]%256
   elif op[0]=='row_subtract':_,i,j,k=op;rhs[i]=(rhs[i]-k*rhs[j])%256
  feasible=all(rhs[i]%A[i][i]==0 for i in range(r)) and all(rhs[i]==0 for i in range(r,m))
  count=kernel//mult if feasible else 0;assert kernel%mult==0
  assert str(count)==parameter['residue_solutions'] and str(domain)==parameter['counter_residue_domain']
  assert count and domain==count*(1<<parameter['density_power_of_two']);counts.append(str(count))
 results.append({'d':case['d'],'residue_domain_bits':sum(widths),'solution_bits':int(counts[0]).bit_length()-1,'density_bits':parameter['density_power_of_two'],'all_four_parameter_cases_feasible':True,'operations_replayed':len(case['operations'])})
result={'verification':'PASS','cases':results,'seconds':time.perf_counter()-start,'scope':'Exact counts only for relaxed counter residues. This is not a density bound on coefficient vectors and does not establish attainable bent candidates.'}
(root/'T79_MODULO_CONTADORES_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
