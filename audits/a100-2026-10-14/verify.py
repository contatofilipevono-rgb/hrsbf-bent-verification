import pathlib,itertools,json,hashlib,time,argparse,subprocess,tempfile
import numpy as np
ap=argparse.ArgumentParser(description='Independent exact CPU verification of the A100 controls.')
ap.add_argument('--repo',type=pathlib.Path,default=pathlib.Path(__file__).resolve().parents[2])
ap.add_argument('--ref',default='b04d6366a3cccede346b9f4005f495bff9871817')
ap.add_argument('--output',type=pathlib.Path,default=pathlib.Path(__file__).with_name('independent_results.json'))
args=ap.parse_args()
workspace=tempfile.TemporaryDirectory(prefix='hrsbf-a100-audit-')
P=pathlib.Path(workspace.name)
for path in ['rs_bent_exhaustive.py','rs_quartic_n10.py','results/stage2_rs_bent_n14/result_n14.json','results/stage2_rs_bent_n14/checkpoint_n14.json','results/stage2_rs_bent_n14/bent_ids_n14.npy','results/stage1_quartic_n10/result_quartic_n10.json','results/stage3_quintic_n16/summary_stage3.json']:
    (P/pathlib.Path(path).name).write_bytes(subprocess.check_output(['git','show',args.ref+':'+path],cwd=args.repo))

def basis(n,degrees):
 xs=np.arange(1<<n,dtype=np.uint32);orbs=[]
 for d in degrees:
  seen=set()
  for mon in itertools.combinations(range(n),d):
   if mon in seen: continue
   o=sorted({tuple(sorted((i+s)%n for i in mon)) for s in range(n)})
   seen.update(o);orbs.append(o)
 G=np.zeros((len(orbs),1<<n),dtype=np.uint8)
 for j,o in enumerate(orbs):
  for mon in o:
   m=sum(1<<i for i in mon);G[j]^=(xs&m)==m
 return orbs,G

def walsh(truth):
 W=1-2*truth.astype(np.int32);N=W.shape[1]
 h=1
 while h<N:
  v=W.reshape(len(W),-1,2*h);a=v[:,:,:h].copy();b=v[:,:,h:].copy()
  v[:,:,:h]=a+b;v[:,:,h:]=a-b;h*=2
 return W

def combinations(G):
 out=np.zeros((1<<len(G),G.shape[1]),dtype=np.uint8)
 for j,g in enumerate(G):out[1<<j:1<<(j+1)]=out[:1<<j]^g
 return out

start=time.monotonic();r=json.loads((P/'result_n14.json').read_text());cp=json.loads((P/'checkpoint_n14.json').read_text());ids=np.load(P/'bent_ids_n14.npy',allow_pickle=False)
assert len(ids)==len(np.unique(ids))==r['bent_affine_representatives']==25176
assert np.array_equal(ids,np.array(cp['bent_ids'],dtype=np.int64))
assert r['tested']==cp['tested']==cp['next_index']==500006912
assert np.all((0<=ids)&(ids<r['tested']))
assert hashlib.sha256((P/'rs_bent_exhaustive.py').read_bytes()).hexdigest()==r['source_sha256']
assert hashlib.sha256((P/'bent_ids_n14.npy').read_bytes()).hexdigest()==r['ids_sha256']
orbs,G=basis(14,(2,3));assert [[list(m) for m in o] for o in orbs]==r['generator_orbits']
bad=[];spectra=set();weights={}
for k in range(0,len(ids),256):
 cur=ids[k:k+256];F=np.zeros((len(cur),16384),dtype=np.uint8)
 for j,g in enumerate(G):F^=((cur>>j)&1).astype(np.uint8)[:,None]&g
 W=walsh(F);bad.extend(cur[~np.all(np.abs(W)==128,axis=1)].tolist());spectra.update(np.unique(W).tolist())
 for w,num in zip(*np.unique(F.sum(axis=1),return_counts=True)): weights[int(w)]=weights.get(int(w),0)+int(num)
assert not bad
assert np.all(((ids>>6)&1)==1)
result={'n14':{'all_reported_positive_ids_have_P14':True,'ids_verified_exactly':len(ids),'failed':bad,'spectra':sorted(spectra),'weights':weights,'source_and_id_hashes_match':True,'prefix_coverage_fraction':r['tested']/r['expected'],'never_activated_orbits':[o[0] for o in orbs[29:]],'quadratic_bent_representatives':int(np.sum(ids<128)),'exact_cubic_bent_representatives':int(np.sum(ids>=128)),'seconds':round(time.monotonic()-start,3),'scope':'All reported positive IDs checked; absence of other bent IDs within the tested prefix has not been independently repeated.'}}
print(json.dumps(result),flush=True)
start=time.monotonic();orbs,G=basis(10,(4,));assert len(G)==22
low=combinations(G[:12]);high=combinations(G[12:]);total=survivors=nbent=0;bentids=[]
for k,H in enumerate(high):
 F=low^H;bal=(np.count_nonzero(F^F[:,::-1],axis=1)==512);idx=np.flatnonzero(bal)
 survivors+=len(idx);total+=len(F)
 if len(idx):
  W=walsh(F[bal]);hits=idx[np.all(np.abs(W)==32,axis=1)];bentids.extend((k*4096+hits).tolist())
 if k%128==0:print('quartic progress',k,'/ 1024',flush=True)
assert total==4194304 and survivors==1148928 and not bentids
result['quartic_n10']={'tested':total,'passed_DJ_filter':survivors,'bent':len(bentids),'independently_exhaustive':True,'seconds':round(time.monotonic()-start,3)}
print(json.dumps(result),flush=True)
start=time.monotonic();o,G=basis(16,(5,));summary=json.loads((P/'summary_stage3.json').read_text());computed=hashlib.sha256(G.tobytes()).hexdigest()
result['quintic_n16']={'basis_orbits':len(o),'basis_sha256_actual':computed,'basis_hash_match':computed==summary['basis_sha256'],'raw_candidates_or_fiber_witnesses_published':False,'scope':'Only summary and basis hash checked; individual exclusions cannot be verified from the published files.','seconds':round(time.monotonic()-start,3)}
args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2),flush=True)
