import sys,itertools,time,json
from pathlib import Path
sys.path.insert(0,str(Path('outputs').resolve()))
from RODAR_H12_A100_GLOBAL import prepare
t=time.time();_,truth,eqs,_,_=prepare();print('prepared',time.time()-t,flush=True)
mons=[0]+[sum(1<<j for j in inds) for k in range(1,4) for inds in itertools.combinations(range(43),k)]
idx={m:i for i,m in enumerate(mons)}
polys=[]
for e,c,l,rows in eqs:
 p=([0] if c else [])+[1<<j for j in range(43) if l>>j&1]+[(1<<i)|(1<<j) for i,r in enumerate(rows) for j in range(43) if r>>j&1]
 polys.append(p)
piv={};proof={};linear=[]
for ei,p in enumerate(polys):
 for j in range(-1,43):
  row=0
  for m in p:row^=1<<idx[m|(0 if j<0 else 1<<j)]
  combo=1<<(ei*44+j+1)
  while row:
   pos=row.bit_length()-1
   if pos in piv:row^=piv[pos];combo^=proof[pos]
   else:
    piv[pos]=row;proof[pos]=combo
    if pos<=43:linear.append((hex(row),hex(combo)));print('linear',hex(row),'degree',mons[pos].bit_count(),flush=True)
    break
print('rank',len(piv),'linear',len(linear),'seconds',time.time()-t,flush=True)
Path('work/T114_xl.json').write_text(json.dumps({'linear':linear,'rank':len(piv)}))
