from pathlib import Path
import sys,json,itertools,hashlib
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'archive'))
from RODAR_H12_A100_GLOBAL import prepare,orbits
root=Path(__file__).resolve().parent;root.mkdir(exist_ok=True)
_,truth,eqs,_,_=prepare()
lawdata=json.loads((root.parent/'linear_law_certificates.json').read_text())
masks=[0x18c8000,1<<40,0x2d57a733bee,1<<42]+[int(x['coefficient_mask'],16) for x in lawdata['laws']]
def affine(rhs):
 piv={}
 for row,v in zip(masks,rhs):
  while row:
   k=row.bit_length()-1
   if k in piv:r,b=piv[k];row^=r;v^=b
   else:piv[k]=(row,v);break
  assert row or not v
 off=0
 for k in sorted(piv):
  row,v=piv[k]
  if (row&off).bit_count()%2 != v:off^=1<<k
 basis=[]
 for j in range(43):
  if j in piv:continue
  v=1<<j
  for k in sorted(piv):
   if (v&piv[k][0]).bit_count()%2:v^=1<<k
  basis.append(v)
 assert len(basis)==36
 assert all((row&off).bit_count()%2==r for row,r in zip(masks,rhs))
 assert all((row&v).bit_count()%2==0 for row in masks for v in basis)
 return off,basis
def evaluate(coeff,e):
 _,k,l,rows=eqs[e];v=k^((coeff&l).bit_count()%2)
 for i,row in enumerate(rows):
  if coeff>>i&1:v^=(coeff&row).bit_count()%2
 return v
charts=[]
for case in [2,3,8,15]:
 off,basis=affine([case>>j&1 for j in range(4)]+[0]*3)
 transformed=[]
 for e in range(43):
  c=evaluate(off,e);lin=[evaluate(off^v,e)^c for v in basis]
  rows=[0]*36
  for i,j in itertools.combinations(range(36),2):
   if evaluate(off^basis[i]^basis[j],e)^lin[i]^lin[j]^c:rows[i]^=1<<j;rows[j]^=1<<i
  # Verify substitution symbolically, independently of point interpolation.
  coordinate=[([0] if off>>j&1 else [])+[1<<i for i,v in enumerate(basis) if v>>j&1] for j in range(43)]
  _,origc,origl,origrows=eqs[e];poly={0} if origc else set()
  def toggle(m):
   if m in poly:poly.remove(m)
   else:poly.add(m)
  for j in range(43):
   if origl>>j&1:
    for m in coordinate[j]:toggle(m)
  for i,row in enumerate(origrows):
   for j in range(43):
    if row>>j&1:
     for a in coordinate[i]:
      for b in coordinate[j]:toggle(a|b)
  expected=({0} if c else set())|{1<<i for i,b in enumerate(lin) if b}|{(1<<i)|(1<<j) for i,j in itertools.combinations(range(36),2) if rows[i]>>j&1}
  assert poly==expected
  transformed.append({'constant':c,'linear':sum(b<<i for i,b in enumerate(lin)),'symmetric_rows':rows})
 charts.append({'case':case,'offset':off,'basis':basis,'quadratic_filters':transformed})
assert all(ch['basis']==charts[0]['basis'] for ch in charts)
assert all([f['symmetric_rows'] for f in ch['quadratic_filters']]==[f['symmetric_rows'] for f in charts[0]['quadratic_filters']] for ch in charts)
patterns=[sum(((x>>i)&1)<<x for x in range(64)) for i in range(6)]
base=[];delta=[]
for ch in charts:
 bb=[];dd=[[0]*43 for _ in range(30)]
 for e,f in enumerate(ch['quadratic_filters']):
  bb.append(0)
  word=0
  for x in range(64):
   bit=f['constant']^((f['linear']&x).bit_count()%2)
   for i in range(6):
    if x>>i&1:bit^=((f['symmetric_rows'][i]&x&~((1<<(i+1))-1)).bit_count()%2)
   word|=bit<<x
  bb[-1]=word
  for j in range(30):
   bit=j+6;w=((1<<64)-1) if f['linear']>>bit&1 else 0
   for i in range(6):
    if f['symmetric_rows'][bit]>>i&1:w^=patterns[i]
   dd[j][e]=w
 base.append(bb);delta.append(dd)
hh=[[f['symmetric_rows'][j+6]>>6 for f in charts[0]['quadratic_filters']] for j in range(30)]
originalL=[e[2] for e in eqs];originalQ=[e[3] for e in eqs]
def array(name,shape,values):
 def fmt(v):return '{'+','.join(fmt(x) for x in v)+'}' if isinstance(v,list) else str(v)+'ULL'
 return 'static const U '+name+''.join('['+str(d)+']' for d in shape)+'='+fmt(values)+';\n'
data='typedef unsigned long long U;\n'
data+=array('OFFSET',[4],[ch['offset'] for ch in charts])+array('BASIS',[36],charts[0]['basis'])
data+=array('BASE',[4,43],base)+array('DELTA',[4,30,43],delta)+array('HH',[30,43],hh)
data+=array('TRUTH',[43,64],[[(v>>(64*w))&((1<<64)-1) for w in range(64)] for v in truth])
data+=array('ORIGL',[43],originalL)+array('ORIGQ',[43,43],originalQ)
(root/'model_data.h').write_text(data)
(root/'model.json').write_text(json.dumps({'scope':'Four necessary affine charts; all potential bent functions are covered if the separately verified reduction lemmas hold.',
 'original_dimension':43,'chart_dimension':36,'total_chart_candidates':4*(1<<36),'masks':masks,'charts':charts,
 'transformed_filters_verified':'Exact symbolic Boolean substitution, independent of interpolation.'},indent=2))
print('generated',len(data),'bytes; 172 transformed filters checked symbolically')
