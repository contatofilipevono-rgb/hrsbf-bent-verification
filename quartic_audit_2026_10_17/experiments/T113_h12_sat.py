import sys, itertools, json, time, argparse, os
from pathlib import Path
sys.path.insert(0, str(Path('work/deps_local').resolve()))
from pysat.solvers import Solver

class Circuit:
 def __init__(self):
  self.n=44; self.zero=44; self.cl=[[-44]]; self.cache={}
 def gate(self,op,a,b):
  z=self.zero
  if op=='xor':
   if a==b:return z
   if a==-b:return -z
   if abs(a)==z:return b if a==z else -b
   if abs(b)==z:return a if b==z else -a
  else:
   if a==b:return a
   if a==-b or a==z or b==z:return z
   if a==-z:return b
   if b==-z:return a
  a,b=sorted([a,b]); key=(op,a,b)
  if key in self.cache:return self.cache[key]
  self.n+=1; r=self.n;self.cache[key]=r
  if op=='xor':self.cl += [[a,b,-r],[-a,-b,-r],[a,-b,r],[-a,b,r]]
  else:self.cl += [[-r,a],[-r,b],[r,-a,-b]]
  return r
 def xor(self,ls):
  v=self.zero
  for x in ls:v=self.gate('xor',v,x)
  return v
 def add(self,a,b,limit=None):
  out=[];c=self.zero
  for i in range(min(max(len(a),len(b)),limit or 10000)):
   x=a[i] if i<len(a) else self.zero;y=b[i] if i<len(b) else self.zero
   t=self.gate('xor',x,y);out.append(self.gate('xor',t,c))
   c=self.gate('xor',self.gate('and',x,y),self.gate('and',t,c))
  if limit is None or len(out)<limit:out.append(c)
  while len(out)>1 and out[-1]==self.zero:out.pop()
  return out
 def weighted(self,terms,limit=None):
  queue=[[lit if w>>i&1 else self.zero for i in range(w.bit_length())] for lit,w in terms if w]
  if not queue:return [self.zero]
  while len(queue)>1:
   queue=[self.add(queue[i],queue[i+1],limit) if i+1<len(queue) else queue[i] for i in range(0,len(queue),2)]
  return queue[0]
 def targets(self,bits,targets):
  self.n+=1;s=self.n
  assert len(targets)==2
  for j,target in enumerate(targets):
   if target<0 or target>=(1<<len(bits)):
    self.cl.append([s if j==0 else -s]);continue
   for i,b in enumerate(bits):self.cl.append([s if j==0 else -s,b if target>>i&1 else -b])

def orbit(x):return sorted({((x<<j)|(x>>(12-j)))&4095 for j in range(12)})
def build():
 seen=set();oo=[]
 for inds in itertools.combinations(range(12),4):
  x=sum(1<<i for i in inds)
  if x not in seen:o=orbit(x);oo.append(o);seen.update(o)
 seen=set();xx=[]
 for x in range(4096):
  if x not in seen:o=orbit(x);xx.append(o);seen.update(o)
 c=Circuit();tv=[]
 for o in xx:
  x=o[0];tv.append(c.xor([j+1 for j,mon in enumerate(oo) if sum(x&s==s for s in mon)%2]))
 return c,oo,xx,tv

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--freqs',default='0,4095,1365,819,273,585,1,3,5,7,15');ap.add_argument('--solver',default='cadical195');ap.add_argument('--prefix',default='work/T113');ap.add_argument('--filters',action='store_true');ap.add_argument('--period4',action='store_true');args=ap.parse_args()
 Path(args.prefix+'.pid').write_text(str(os.getpid()))
 c,oo,xx,tv=build();freqs=[int(x) for x in args.freqs.split(',')]
 if args.period4:
  rows=[0x18c8000,0x10000000000,0x3d57a733bee,0x40000000000]
  bits=[c.xor([j+1 for j in range(43) if r>>j&1]) for r in rows]
  for z in range(16):
   if z not in [6,7,8,11]:c.cl.append([-b if z>>i&1 else b for i,b in enumerate(bits)])
  data=json.loads(Path('work/T114_xl.json').read_text())
  for mask,_ in data['linear']:
   r=int(mask,16)
   # XL polynomial bit 0 is the constant, bits j+1 are c_j.
   out=c.xor([j+1 for j in range(43) if r>>(j+1)&1])
   c.cl.append([out if r&1 else -out])
 if args.filters:
  for weight in range(8,12):
   reps=sorted({min(orbit(sum(1<<j for j in inds))) for inds in itertools.combinations(range(12),weight)})
   for support in reps:
    terms=[(t,sum(x&support==x for x in o)) for o,t in zip(xx,tv)]
    bits=c.weighted(terms,weight-6)
    for b in bits[:weight-6]:c.cl.append([-b])
  print('subcube filters added',c.n,len(c.cl),flush=True)
 for a in freqs:
  terms=[];base=2048 if a else 0
  for o,t in zip(xx,tv):
   k=sum(1-2*((x&a).bit_count()%2) for x in o)
   if k<0:base+=k;terms.append((-t,-k))
   elif k:terms.append((t,k))
  c.targets(c.weighted(terms),[2016-base,2080-base])
 print('built',c.n,len(c.cl),'frequencies',freqs,flush=True)
 path=Path(args.prefix+'.cnf')
 with path.open('w') as f:
  f.write(f'p cnf {c.n} {len(c.cl)}\n')
  for clause in c.cl:f.write(' '.join(map(str,clause))+' 0\n')
 t=time.perf_counter()
 if args.solver=='crypto':
  dllpath=os.add_dll_directory(str(Path('work/deps_local/pycryptosat-5.17.0.data/platlib').resolve()))
  import pycryptosat
  s=pycryptosat.Solver(threads=2)
  for cl in c.cl:s.add_clause(cl)
  for (op,a,b),out in c.cache.items():
   if op=='xor':s.add_xor_clause([abs(a),abs(b),out],(a<0)^(b<0))
  ans,model=s.solve()
  print('CRYPTO SAT',ans,'time',time.perf_counter()-t,flush=True)
  if ans:Path(args.prefix+'.json').write_text(json.dumps({'sat':True,'coefficient':hex(sum(1<<j for j in range(43) if model[j+1]))}))
  return
 with Solver(name=args.solver,bootstrap_with=c.cl,with_proof=True) as s:
  ans=s.solve();print('SAT',ans,'time',time.perf_counter()-t,'stats',s.accum_stats(),flush=True)
  if ans:
   model=s.get_model();coeff=sum(1<<j for j in range(43) if model[j]>0)
   actual=[]
   for a in freqs:
    actual.append(sum((1-2*(sum(((coeff>>j)&1)*sum(x&m==m for m in o) for j,o in enumerate(oo))%2))*(1-2*((x&a).bit_count()%2)) for x in range(4096)))
   assert all(abs(x)==64 for x in actual),(hex(coeff),actual)
   result={'sat':True,'coefficient':hex(coeff),'walsh':actual,'frequencies':freqs}
  else:
   proof=s.get_proof();Path(args.prefix+'.drat').write_text('\n'.join(proof)+'\n');result={'sat':False,'proof_lines':len(proof),'frequencies':freqs}
  Path(args.prefix+'.json').write_text(json.dumps(result,indent=2))
if __name__=='__main__':main()
