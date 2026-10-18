import json,itertools,time,sys
from pathlib import Path
root=Path(__file__).resolve().parent
d=json.loads((root/'model.json').read_text());pairs=list(itertools.combinations(range(36),2));index={v:i+37 for i,v in enumerate(pairs)}
linear_mask=(1<<37)-1
def pack(f):
 p=f['constant']|(f['linear']<<1)
 for i,j in pairs:
  if f['symmetric_rows'][i]>>j&1:p|=1<<index[(i,j)]
 return p
def matrices(p):
 rows=[0]*36;q=p>>37
 while q:
  b=q&-q;i,j=pairs[b.bit_length()-1];q^=b;rows[i]^=1<<j;rows[j]^=1<<i
 return rows
def substitute(p,pivot,form,rhs):
 # x_pivot = rhs + form, with form excluding pivot.
 li=p>>(pivot+1)&1;cross=matrices(p)[pivot]
 if li:p^=1<<(pivot+1)
 z=cross
 while z:
  b=z&-z;j=b.bit_length()-1;z^=b;p^=1<<index[tuple(sorted((pivot,j)))]
 if li:p^=form<<1
 if rhs:p^=cross<<1;p^=li
 p^=(form&cross)<<1
 z=form
 while z:
  b=z&-z;i=b.bit_length()-1;z^=b;zz=cross&~b
  while zz:
   bb=zz&-zz;j=bb.bit_length()-1;zz^=bb;p^=1<<index[tuple(sorted((i,j)))]
 return p
def gaussian(ps):
 piv={};w={}
 for i,row in enumerate(ps):
  combo=1<<i
  while row:
   k=row.bit_length()-1
   if k in piv:row^=piv[k];combo^=w[k]
   else:piv[k]=row;w[k]=combo;break
  if row and row<=linear_mask:return row,combo,list(piv.values())
 return None,None,list(piv.values())
def rank(rows):
 piv={}
 for v in rows:
  while v:
   k=v.bit_length()-1
   if k in piv:v^=piv[k]
   else:piv[k]=v;break
 return len(piv)
nodes=[];stats={'nodes':0,'solutions':0,'leaves':0,'contradictions':0,'max_leaf_dimension':0};t=time.time()
def recurse(ps,active,offset,basis):
 node={'linear_steps':[]};nid=len(nodes);nodes.append(node);stats['nodes']+=1
 if stats['nodes']%1000==0:print(stats,'seconds',round(time.time()-t,2),flush=True)
 if stats['nodes']>200000:raise RuntimeError('node limit')
 while True:
  row,combo,reduced=gaussian(ps)
  if row is None:break
  if row==1:
   node.update(kind='contradiction',combination=hex(combo));stats['contradictions']+=1;return nid
  l=row>>1;rhs=row&1;pivot=l.bit_length()-1;form=l^(1<<pivot)
  node['linear_steps'].append({'combination':hex(combo),'pivot':pivot})
  ps=[substitute(p,pivot,form,rhs) for p in ps]
  if rhs:offset^=basis[pivot]
  b=basis[pivot];basis=basis[:]
  for j in range(36):
   if form>>j&1:basis[j]^=b
  basis[pivot]=0;active^=1<<pivot
 if not any(ps):
  dim=active.bit_count();stats['solutions']+=1<<dim;stats['leaves']+=1;stats['max_leaf_dimension']=max(stats['max_leaf_dimension'],dim)
  node.update(kind='solutions',dimension=dim);return nid
 # Prefer low-rank quadratic constraints; any nonzero form is a sound split.
 best=None
 for p in [v for v in ps if v]+reduced:
  rr=matrices(p);r=rank(rr)
  if r and (best is None or r<best[0]):best=(r,rr)
  if r==2:break
 assert best
 form=next(v for v in best[1] if v);pivot=form.bit_length()-1;rest=form^(1<<pivot)
 node.update(kind='split',form=hex(form));children=[]
 for rhs in [0,1]:
  pp=[substitute(p,pivot,rest,rhs) for p in ps];bb=basis[:];off=offset^(basis[pivot] if rhs else 0)
  for j in range(36):
   if rest>>j&1:bb[j]^=basis[pivot]
  bb[pivot]=0;children.append(recurse(pp,active^(1<<pivot),off,bb))
 node['children']=children;return nid
roots=[]
for chart,ch in enumerate(d['charts']):
 before=stats['solutions'];print('CHART',chart,flush=True)
 roots.append(recurse([pack(f) for f in ch['quadratic_filters']],(1<<36)-1,ch['offset'],ch['basis']))
 print('CHART_COMPLETE',chart,'solutions',stats['solutions']-before,flush=True)
result={'format':'boolean-quadratic-affine-split-v1','roots':roots,'nodes':nodes,'stats':stats,'seconds':time.time()-t}
(root/'DECOMPOSITION.json').write_text(json.dumps(result,separators=(',',':')))
print(stats,'seconds',time.time()-t,flush=True)
