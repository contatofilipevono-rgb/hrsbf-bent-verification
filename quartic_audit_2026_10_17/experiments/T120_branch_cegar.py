import sys,os,time,json,argparse,math
from pathlib import Path
sys.path.insert(0,str(Path('work').resolve()));sys.path.insert(0,str(Path('outputs').resolve()))
from T113_h12_sat import Circuit,build
from RODAR_H12_A100_GLOBAL import prepare
os.add_dll_directory(str(Path('work/deps_local/pycryptosat-5.17.0.data/platlib').resolve()))
import pycryptosat
ap=argparse.ArgumentParser();ap.add_argument('--case',type=int,default=2);args=ap.parse_args();p=args.case
assert p in [2,3,8,15]
c,oo,xx,tv=build();_,truth,eqs,_,_=prepare()
for e,k,linear,rows in eqs:
 terms=[j+1 for j in range(43) if linear>>j&1]
 terms += [c.gate('and',i+1,j+1) for i,row in enumerate(rows) for j in range(43) if row>>j&1]
 out=c.xor(terms);c.cl.append([out if k else -out])
masks=[0x18c8000,1<<40,0x2d57a733bee,1<<42]
for j,mask in enumerate(masks):
 out=c.xor([i+1 for i in range(43) if mask>>i&1]);c.cl.append([out if p>>j&1 else -out])
c.cl.append([27 if ((p>>1)^(p>>3))&1 else -27])
groups=[[(o,t) for o,t in zip(xx,tv) if len(o)==12 and o[0].bit_count()%2==b] for b in [0,1]]
targets={2:[80,85],3:[85,85],8:[84,88],15:[83,88]}[p]
for group,target in zip(groups,targets):
 bits=c.weighted([(t,1) for o,t in group])
 for j,b in enumerate(bits):c.cl.append([b if target>>j&1 else -b])
coeff0=(1<<15 if p&1 else 0)^(1<<40 if p>>1&1 else 0)^(1<<1 if p>>2&1 else 0)^(1<<42 if p>>3&1 else 0)^(1<<26 if ((p>>1)^(p>>3))&1 else 0)
short=[(o,sum((coeff0>>j&1)*sum(o[0]&m==m for m in mon) for j,mon in enumerate(oo))%2) for o in xx if len(o)<12]
long=[(o,t) for o,t in zip(xx,tv) if len(o)==12]
s=pycryptosat.Solver(threads=2);sent=0;known=set();freqs=[0,4095]
def sync():
 global sent
 exclude=set()
 for (op,a,b),out in c.cache.items():
  if op=='xor':
   exclude.update([(a,b,-out),(-a,-b,-out),(a,-b,out),(-a,b,out)])
   if out not in known:s.add_xor_clause([abs(a),abs(b),out],(a<0)^(b<0));known.add(out)
 for cl in c.cl[sent:]:
  if tuple(cl) not in exclude:s.add_clause(cl)
 sent=len(c.cl)
def add_frequency(a):
 def K(o):return sum(1-2*((x&a).bit_count()%2) for x in o)
 base=(4096 if a==0 else 0)-2*sum(K(o)*v for o,v in short)
 terms=[];shift=0
 for o,t in long:
  k=K(o)
  if k<0:shift+=k;terms.append((-t,-k))
  elif k:terms.append((t,k))
 gcd=math.gcd(*(w for _,w in terms));values=[]
 for sign in [-1,1]:
  target=(base-sign*64)//2-shift
  if target%gcd==0:values.append(target//gcd)
 if not values:c.cl.append([])
 else:
  if len(values)==1:values*=2
  c.targets(c.weighted([(lit,w//gcd) for lit,w in terms]),values)
 freqs.append(a);sync()
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
sync();hist=[]
for iteration in range(20):
 print('SOLVE',p,iteration,'freqs',freqs,'variables',c.n,'clauses',len(c.cl),flush=True)
 t=time.time();ans,model=s.solve(time_limit=110);print('ANSWER',ans,'seconds',time.time()-t,flush=True)
 if ans is None:
  Path(f'work/T120_case{p}.json').write_text(json.dumps({'status':'TIMEOUT','case':p,'frequencies':freqs,'models':hist},indent=2));break
 if not ans:
  Path(f'work/T120_case{p}.json').write_text(json.dumps({'status':'UNSAT_CRYPTO_REQUIRES_PROOF_REPLAY','case':p,'frequencies':freqs,'models':hist},indent=2))
  Path(f'work/T120_case{p}.cnf').write_text(f'p cnf {c.n} {len(c.cl)}\n'+''.join(' '.join(map(str,cl))+' 0\n' for cl in c.cl));break
 coeff=sum(1<<j for j in range(43) if model[j+1]);w=fwht(coeff)
 assert all(abs(w[a])==64 for a in freqs),(hex(coeff),freqs,[w[a] for a in freqs])
 bad=sorted([a for a in range(4096) if abs(w[a])!=64],key=lambda a:-abs(w[a]));hist.append(hex(coeff))
 print('MODEL',hex(coeff),'next',bad[0] if bad else 'BENT',flush=True)
 if not bad:Path(f'work/T120_BENT_case{p}.json').write_text(json.dumps({'coefficient':hex(coeff)}));break
 add_frequency(bad[0])
