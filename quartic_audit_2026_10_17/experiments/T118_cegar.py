import sys,os,time,json
from pathlib import Path
sys.path.insert(0,str(Path('work').resolve()))
sys.path.insert(0,str(Path('outputs').resolve()))
from T113_h12_sat import Circuit,build
from RODAR_H12_A100_GLOBAL import prepare
os.add_dll_directory(str(Path('work/deps_local/pycryptosat-5.17.0.data/platlib').resolve()))
import pycryptosat
Path('work/T118.pid').write_text(str(os.getpid()))
c,oo,xx,tv=build();_,truth,eqs,_,_=prepare()
for e,k,linear,rows in eqs:
 terms=[j+1 for j in range(43) if linear>>j&1]
 terms += [c.gate('and',i+1,j+1) for i,row in enumerate(rows) for j in range(43) if row>>j&1]
 out=c.xor(terms);c.cl.append([out if k else -out])
row_masks=[0x18c8000,0x10000000000,0x3d57a733bee,0x40000000000]
bits=[c.xor([j+1 for j in range(43) if mask>>j&1]) for mask in row_masks]
for z in range(16):
 if z not in [6,7,8,11]:c.cl.append([-b if z>>i&1 else b for i,b in enumerate(bits)])
# Make the affine consequence explicit for native Gaussian elimination.
v=c.xor([j+1 for j in range(43) if (row_masks[2]^(1<<42))>>j&1]);c.cl.append([v])
s=pycryptosat.Solver(threads=2);sent=0;known=set();freqs=[]
def sync():
 global sent
 exclude=set()
 for (op,a,b),out in c.cache.items():
  if op=='xor':
   exclude.update([(a,b,-out),(-a,-b,-out),(a,-b,out),(-a,b,out)])
   if out not in known:
    s.add_xor_clause([abs(a),abs(b),out],(a<0)^(b<0));known.add(out)
 for cl in c.cl[sent:]:
  if tuple(cl) not in exclude:s.add_clause(cl)
 sent=len(c.cl)
def add_frequency(a):
 terms=[];base=2048 if a else 0
 for o,t in zip(xx,tv):
  k=sum(1-2*((x&a).bit_count()%2) for x in o)
  if k<0:base+=k;terms.append((-t,-k))
  elif k:terms.append((t,k))
 c.targets(c.weighted(terms),[2016-base,2080-base]);freqs.append(a);sync()
def fwht(coeff):
 values=0
 for j,t in enumerate(truth):
  if coeff>>j&1:values^=t
 v=[1-2*((values>>x)&1) for x in range(4096)];step=1
 while step<4096:
  for start in range(0,4096,step*2):
   for j in range(start,start+step):x,y=v[j],v[j+step];v[j],v[j+step]=x+y,x-y
  step*=2
 return v
add_frequency(0)
for iteration in range(30):
 print('SOLVE',iteration,'frequencies',freqs,'vars',c.n,'clauses',len(c.cl),flush=True)
 t=time.time();ans,model=s.solve(time_limit=110)
 print('ANSWER',ans,'seconds',time.time()-t,flush=True)
 if ans is None:
  Path('work/T118_partial.json').write_text(json.dumps({'status':'TIMEOUT','frequencies':freqs}));break
 if not ans:
  Path('work/T118_unsat.cnf').write_text(f'p cnf {c.n} {len(c.cl)}\n'+''.join(' '.join(map(str,cl))+' 0\n' for cl in c.cl))
  Path('work/T118_unsat.json').write_text(json.dumps({'status':'UNSAT_CRYPTO_REQUIRES_PROOF_REPLAY','frequencies':freqs}));break
 coeff=sum(1<<j for j in range(43) if model[j+1]);w=fwht(coeff)
 assert all(abs(w[a])==64 for a in freqs),(hex(coeff),freqs,[w[a] for a in freqs])
 bad=sorted([a for a in range(4096) if abs(w[a])!=64],key=lambda a:-abs(w[a]))
 print('MODEL',hex(coeff),'next',bad[0] if bad else 'BENT',flush=True)
 if not bad:Path('work/T118_bent.json').write_text(json.dumps({'coefficient':hex(coeff)}));break
 add_frequency(bad[0])
