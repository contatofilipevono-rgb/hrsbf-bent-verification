import itertools,random,json,time
n=16;h=8;N=1<<n;full=(1<<N)-1
variables=[]
for i in range(n):
 block=(1<<(1<<i))-1;v=0
 for s in range(1<<i,N,2<<i):v|=block<<s
 variables.append(v)
unseen=set(itertools.combinations(range(n),5));basis=[]
while unseen:
 rep=min(unseen);orb={tuple(sorted((i+s)%n for i in rep)) for s in range(n)};unseen-=orb
 table=0
 for term in orb:
  mon=full
  for i in term:mon&=variables[i]
  table^=mon
 fiber=sum(((table>>(u|((u^255)<<8)))&1)<<u for u in range(256))
 basis.append((rep,table,fiber))
rng=random.Random(20261006);r={'n':16,'degree':5,'orbits':len(basis),'sample_size':4096,'balanced_derivatives':0,'balanced_complementary_fibers':0,'both_balanced':0};examples=[];excluded_by_other_fiber=0
for sample in range(4096):
 c=rng.getrandbits(len(basis));t=0;f=0
 for j,(_,v,w) in enumerate(basis):
  if c>>j&1:t^=v;f^=w
 # all-ones input translation reverses truth-table bits
 reverse=int.from_bytes(t.to_bytes(N//8,'little')[::-1],'little')
 # also reverse bits in each byte
 reverse=int.from_bytes(bytes(int(f'{b:08b}'[::-1],2) for b in reverse.to_bytes(N//8,'little')),'little')
 bd=(t^reverse).bit_count()==N//2;bf=f.bit_count()==128
 r['balanced_derivatives']+=bd;r['balanced_complementary_fibers']+=bf;r['both_balanced']+=bd and bf
 if bd and bf:
  raw=t.to_bytes(N//8,'little');witness=None
  for z in range(1,256):
   weight=sum((raw[(u|((u^z)<<8))>>3]>>((u|((u^z)<<8))&7))&1 for u in range(256))
   if weight!=128:witness={'z':z,'weight':weight};break
  excluded_by_other_fiber+=witness is not None
  if len(examples)<2:examples.append({'coefficients':hex(c),'derivative_weight':(t^reverse).bit_count(),'fiber_weight':f.bit_count(),'unbalanced_fiber_witness':witness})
r['examples_satisfying_both']=examples
r['both_balanced_excluded_by_other_fiber']=excluded_by_other_fiber
r['scope']='Deterministic sample; not exhaustive and not a proof of degree-five nonexistence.'
print(json.dumps(r,indent=2))
