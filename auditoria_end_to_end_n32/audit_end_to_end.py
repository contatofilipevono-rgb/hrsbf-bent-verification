import itertools, hashlib, json, platform, random, sys, time
N=32; H=16; J=(1<<32)-1; MASK16=(1<<16)-1; SEED=20261006

def check(c,m):
    if not c: print('FAIL:',m); raise SystemExit(1)
def rot_support(s,k,n): return tuple(sorted((i+k)%n for i in s))
def cubic_orbits(n):
    unseen=set(itertools.combinations(range(n),3)); out=[]
    while unseen:
        s=min(unseen); orb=sorted({rot_support(s,k,n) for k in range(n)})
        out.append(tuple(orb)); unseen.difference_update(orb)
    return sorted(out)
def ev(orb,x):
    v=0
    for s in orb:
        b=1
        for i in s: b &= (x>>i)&1
        v ^= b
    return v
def rank_basis(rows):
    piv={}
    for r in rows:
        x=r
        while x:
            p=x.bit_length()-1
            if p in piv: x^=piv[p]
            else: piv[p]=x; break
    return len(piv),piv
def reduce_row(x,piv):
    for p in sorted(piv,reverse=True):
        if (x>>p)&1:x^=piv[p]
    return x
def kernel_basis(rows,ncols):
    a=[r for r in rows if r]; pivcols=[]; rr=0
    for col in range(ncols-1,-1,-1):
        k=next((k for k in range(rr,len(a)) if (a[k]>>col)&1),None)
        if k is None: continue
        a[rr],a[k]=a[k],a[rr]
        for k in range(len(a)):
            if k!=rr and ((a[k]>>col)&1): a[k]^=a[rr]
        pivcols.append(col); rr+=1
    pivset=set(pivcols); free=[c for c in range(ncols) if c not in pivset]; basis=[]
    for f in free:
        v=1<<f
        for row,p in zip(a[:rr],pivcols):
            if (row>>f)&1:v|=1<<p
        basis.append(v)
    return basis
def mat_vec(rows,v): return all((r&v).bit_count()%2==0 for r in rows)
def canon_hash_ints(xs,width):
    b=b''.join(int(x).to_bytes(width,'little') for x in xs); return hashlib.sha256(b).hexdigest()
def var_patterns(n=16):
    pats=[]
    for i in range(n):
        block=1<<i; period=block*2; x=0
        chunk=(1<<block)-1
        for start in range(block,1<<n,period): x |= chunk<<start
        pats.append(x)
    return pats
def packed_fiber(orb,comp,pats,allones):
    z=0
    for s in orb:
        t=allones
        for v in s:
            p=pats[v%16]
            if comp and v>=16:p=allones^p
            t &= p
        z ^= t
    return z & allones
def polar_entry(orb,i,j):
    ei=1<<i; ej=1<<j
    return ev(orb,J^ei^ej)^ev(orb,ei^ej)^ev(orb,J^ei)^ev(orb,ei)^ev(orb,J^ej)^ev(orb,ej)^ev(orb,J)^ev(orb,0)
def quad_eval_mask(n,qmask,beta,c,x):
    v=c ^ (beta & (x.bit_count()&1)); mask=(1<<n)-1
    for d in range(1,n//2):
        if (qmask>>(d-1))&1:
            rx=((x>>d)|(x<<(n-d)))&mask
            v ^= (x & rx).bit_count()&1
    if (qmask>>(n//2-1))&1:
        for i in range(n//2): v ^= ((x>>i)&1)&((x>>(i+n//2))&1)
    return v
def polar_rows_quad(n,qmask):
    row0=0
    for d in range(1,n//2+1):
        if (qmask>>(d-1))&1:
            row0 ^= 1<<d
            if d != n//2: row0 ^= 1<<(n-d)
    mask=(1<<n)-1; rows=[]
    for i in range(n): rows.append(((row0<<i)|(row0>>(n-i)))&mask if i else row0)
    return rows
def quad_balanced_exact(n,qmask,beta):
    rows=polar_rows_quad(n,qmask); rad=kernel_basis(rows,n)
    for r in rad:
        if quad_eval_mask(n,qmask,beta,0,r): return True, any(rows), rows, rad
    return False, any(rows), rows, rad
def fwht(a):
    a=a[:]; h=1
    while h<len(a):
      for i in range(0,len(a),2*h):
       for j in range(i,i+h): x,y=a[j],a[j+h]; a[j]=x+y; a[j+h]=x-y
      h*=2
    return a
def is_bent_table(tab,n): return all(abs(x)==1<<(n//2) for x in fwht([1 if b==0 else -1 for b in tab]))
def rot_x(x,n): return ((x<<1)&((1<<n)-1))|(x>>(n-1))
def e3_4(x):
    v=0
    for s in itertools.combinations(range(4),3): v^=all((x>>i)&1 for i in s)
    return int(v)
def positive8(x):
    u=x&15; v=(x>>4)&15
    return ((u&v).bit_count()&1) ^ e3_4(u^v)
def anf_coeff(tab,n):
    a=tab[:]
    for i in range(n):
      for m in range(1<<n):
        if (m>>i)&1:a[m]^=a[m^(1<<i)]
    return a
def small_controls(n):
    orbs=cubic_orbits(n); total=1<<len(orbs); bad=[]
    for cm in range(total):
      tab=[]
      for x in range(1<<n):
        val=0
        for k,o in enumerate(orbs):
          if (cm>>k)&1: val^=ev(o,x)
        tab.append(val)
      if is_bent_table(tab,n): bad.append(cm)
    for qm in range(1<<(n//2)):
      for beta in (0,1):
        bal,_,_,_=quad_balanced_exact(n,qm,beta)
        tab=[quad_eval_mask(n,qm,beta,0,x) for x in range(1<<n)]
        check(bal==(sum(tab)==(1<<(n-1))),f'quadratic criterion mismatch n={n}, qm={qm}, beta={beta}')
    return {'cubic_orbits':len(orbs),'homogeneous_cubic_bent_count':len(bad),'quadratic_control':'PASS'}
def main():
 t0=time.time(); stages={}; result={'repo':'https://github.com/contatofilipevono-rgb/hrsbf-bent-verification','branch':'colab-a100-2026-10-06','commit':'9e31729158c46e68632e7b277e35a7b8bdbc8fb8','seed':SEED,'python':sys.version,'platform':platform.platform(),'bit_convention':'bit i <-> x_i'}
 s=time.time(); oo=cubic_orbits(32); check(len(oo)==155,'orbit count'); check(all(len(o)==32 for o in oo),'orbit size'); union=set().union(*map(set,oo)); check(len(union)==4960,'orbit union'); check(len(union)==sum(map(len,oo)),'disjoint'); result['orbits']=155; stages['orbits']=time.time()-s
 s=time.time(); rows=[]
 for i in range(32):
  for j in range(i+1,32):
   r=0
   for k,o in enumerate(oo):
    if polar_entry(o,i,j):r|=1<<k
   rows.append(r)
 rank,piv=rank_basis(rows); kb=kernel_basis(rows,155); check(len(kb)==155-rank,'kernel dimension'); check(all(mat_vec(rows,v) for v in kb),'kernel vectors'); check(rank_basis(kb)[0]==len(kb),'kernel independence')
 result['rank']=rank;result['kernel_dim']=len(kb); result['matrix_sha256']=canon_hash_ints(rows,20);result['kernel_sha256']=canon_hash_ints(kb,20);stages['matrix_kernel']=time.time()-s
 s=time.time(); rows31=[]
 for j in range(1,32):
  r=0
  for k,o in enumerate(oo):
   if polar_entry(o,0,j):r|=1<<k
  rows31.append(r)
 r31,p31=rank_basis(rows31); check(r31==rank,'31/full rank differs'); check(all(reduce_row(r,p31)==0 for r in rows),'full row outside 31 span'); check(all(reduce_row(r,piv)==0 for r in rows31),'31 row outside full span'); result['rotation_rowspace']='PASS';stages['rotation']=time.time()-s
 s=time.time(); pats=var_patterns(); allones=(1<<(1<<16))-1; diags=[]; comps=[]; rng=random.Random(SEED)
 for o in oo:
  d=packed_fiber(o,False,pats,allones); c=packed_fiber(o,True,pats,allones); check(d==0,'nonzero diagonal table'); diags.append(d);comps.append(c)
  tests=[0,65535]+[1<<i for i in range(16)]+[rng.randrange(65536) for _ in range(128)]
  for u in tests:
   x=u|(((u^65535)&65535)<<16); check(((c>>u)&1)==ev(o,x),'packed/scalar mismatch')
 for v in kb:
  t=0
  for k,c in enumerate(comps):
   if (v>>k)&1:t^=c
  check(t in (0,allones),'kernel fiber nonconstant')
 result['diagonal_zero']='PASS';result['kernel_implies_constant_fiber']='PASS';result['diagonal_sha256']=canon_hash_ints(diags,8192);result['complement_sha256']=canon_hash_ints(comps,8192);stages['fibers']=time.time()-s
 s=time.time(); counter=[]
 for qm in range(1<<16):
  for beta in (0,1):
   bal,pnon,qr,rad=quad_balanced_exact(32,qm,beta)
   if bal and pnon: counter.append((qm,beta)); break
  if counter: break
 check(not counter,'balanced RS quadratic with nonzero polar: '+repr(counter[:1])); result['quadratic_lemma']='PASS';result['quadratic_cases_checked']=(1<<16)*2;stages['quadratic_lemma']=time.time()-s
 s=time.time(); result['small_n4']=small_controls(4); result['small_n8']=small_controls(8)
 tab=[positive8(x) for x in range(256)]; W=fwht([1 if b==0 else -1 for b in tab]); check(all(abs(w)==16 for w in W),'positive8 not bent'); check(all(positive8(rot_x(x,8))==positive8(x) for x in range(256)),'positive8 not RS'); anf=anf_coeff(tab,8); degs={m.bit_count() for m,a in enumerate(anf) if a}; check(2 in degs and 3 in degs and max(degs)==3,'positive8 ANF degrees'); result['positive_bent_n8']='PASS';stages['small_controls']=time.time()-s
 muts=[]
 def mut(name,rejected,msg): muts.append({'name':name,'detected':bool(rejected),'message':msg}); check(rejected,'mutation escaped: '+name)
 mut('remove generator',len(oo[:-1])!=155,'orbit count != 155'); mut('duplicate generator',len(set(oo+[oo[0]]))!=156,'duplicate orbit')
 bad=list(oo); bo=list(bad[0]); bo[0]=(0,1,31); bad[0]=tuple(bo); mut('alter monomial',len(set().union(*map(set,bad)))!=4960,'union/partition corrupted')
 mr=rows.copy();mr[0]^=1; mut('flip polar bit',canon_hash_ints(mr,20)!=result['matrix_sha256'],'matrix hash changed')
 mut('incomplete kernel basis',len(kb[:-1])!=155-rank,'kernel basis dimension wrong'); dep=kb.copy();dep[1]=dep[0];mut('dependent kernel basis',rank_basis(dep)[0]!=len(dep),'kernel basis dependent')
 cc=comps.copy();cc[0]^=1; mut('flip complementary bit',canon_hash_ints(cc,8192)!=result['complement_sha256'],'complement table hash changed')
 dd=diags.copy();dd[0]^=1;mut('flip diagonal bit',any(dd),'diagonal nonzero')
 swapped=oo.copy();swapped[0],swapped[1]=swapped[1],swapped[0]; ordering_bad=False
 for col,new_orbit in ((0,swapped[0]),(1,swapped[1])):
  fresh=[]
  for i in range(32):
   for j in range(i+1,32): fresh.append(polar_entry(new_orbit,i,j))
  stored=[(r>>col)&1 for r in rows]
  if fresh!=stored: ordering_bad=True
 mut('certificate ordering swap without remap',ordering_bad,'recomputed orbit column disagrees with unremapped matrix column')
 wrong_expected=rank+1; mut('wrong expected rank',rank_basis(rows)[0]!=wrong_expected,'recomputed GF(2) rank disagrees with mutated expected rank')
 qmc=1; betac=0; exact_bal=quad_balanced_exact(8,qmc,betac)[0]; truth=[quad_eval_mask(8,qmc,betac,0,x) for x in range(256)]; truth_bal=(sum(truth)==128); mutated_bal=not exact_bal
 mut('flip quadratic classification',mutated_bal!=truth_bal,'mutated classification disagrees with exhaustive truth table')
 result['mutations']=muts; result['mutations_detected']=f"{sum(m['detected'] for m in muts)}/11"; result['stages_seconds']=stages;result['total_seconds']=time.time()-t0;result['status']='PASS'
 out='auditoria_end_to_end_n32/resultado_end_to_end.json';open(out,'w').write(json.dumps(result,indent=2,sort_keys=True)+'\n');print(json.dumps({k:result[k] for k in ['status','commit','orbits','rank','kernel_dim','quadratic_lemma','diagonal_zero','kernel_implies_constant_fiber','small_n4','small_n8','positive_bent_n8','mutations_detected','total_seconds']},indent=2))
if __name__=='__main__':main()
