"""Run after Colab controls; bounded quintic experiments, not a universal proof."""
import itertools, json, time, zipfile, hashlib
from pathlib import Path
import numpy as np
import pesquisa_fibras_loop as research
from verify_fibras_loop import fwht

def run_conditioned_dense(exact_evaluate, previous=None, rounds=2000, batch=2048, fresh_supports=(160,192,224)):
    root=Path('a100_d5_condicionada_'+time.strftime('%Y%m%d_%H%M%S'))
    root.mkdir(exist_ok=True)
    orbits,basis,indices=research.make_tables(16,5)
    engine=research.Evaluator(basis,indices,'cuda')
    if engine.gpu is None: raise RuntimeError('CUDA required')
    width=len(basis); rng=np.random.default_rng(100261006)
    pool=np.empty((0,width),np.uint8); scores=np.empty(0,np.int32)
    strict=np.empty((0,width),np.uint8); strict_scores=np.empty(0,np.int32)
    if previous is not None:
        pool=np.vstack([previous['hall'],previous['conditional']])
        w,d=exact_evaluate(engine,pool)
        p=(~np.isin(w.sum(axis=1),[32640,32896])).astype(int)+(d!=32768)+(w[:,-1]!=128)
        scores=p*256+(w[:,1:]!=128).sum(axis=1)
        valid=p==0
        strict=pool[valid].copy();strict_scores=(w[valid,1:]!=128).sum(axis=1)
    def unique_best(c,s,limit=128):
        keep=[]; seen=set()
        for j in np.argsort(s,kind='stable'):
            key=np.packbits(c[j],bitorder='little').tobytes()
            if key not in seen: seen.add(key);keep.append(int(j))
            if len(keep)==limit: break
        return c[keep].copy(),s[keep].copy()
    records=[]; total_strict=0; candidates=[];start=time.monotonic()
    for step in range(rounds):
        if time.monotonic()-start>1800: break
        c=rng.integers(0,2,(batch,width),dtype=np.uint8)
        for j in range(batch//4):
            k=int(rng.choice(fresh_supports));c[j]=0;c[j,rng.choice(width,k,replace=False)]=1
        for j in range(batch//4,batch):
            source=strict if len(strict) and j%2 else pool
            if len(source):
                c[j]=source[int(rng.integers(len(source)))].copy()
                flips=(1,2,3,4,8,16,32)[(j+step//25)%7]
                c[j,rng.choice(width,flips,replace=False)]^=1
                if j%11==0:
                    parent=source[int(rng.integers(len(source)))];sel=rng.integers(0,2,width).astype(bool)
                    c[j,sel]=parent[sel]
        c[c.sum(axis=1)==0,0]=1
        w,d=exact_evaluate(engine,c)
        bad=(w[:,1:]!=128).sum(axis=1)
        ok_weight=np.isin(w.sum(axis=1),[32640,32896])
        ok_derivative=d==32768;ok_complement=w[:,-1]==128
        passed=ok_weight&ok_derivative&ok_complement
        penalties=(~ok_weight).astype(int)+(~ok_derivative)+(~ok_complement)
        score=penalties*256+bad
        pool,scores=unique_best(np.vstack([pool,c]),np.r_[scores,score])
        strict,strict_scores=unique_best(np.vstack([strict,c[passed]]),np.r_[strict_scores,bad[passed]])
        total_strict+=int(passed.sum())
        for j in np.flatnonzero(passed&(bad==0)):
            truth=np.bitwise_xor.reduce(basis[c[j].astype(bool)],axis=0)
            spectrum=fwht(truth)
            candidate={'coefficients':c[j].astype(int).tolist(),'bent':bool(np.all(np.abs(spectrum)==256)),
                       'absolute_walsh_values':np.unique(np.abs(spectrum)).tolist()}
            candidates.append(candidate)
        record={'round':step+1,'draws':batch,'passing_weight':int(ok_weight.sum()),
                'passing_all_three':int(passed.sum()),'all_fiber_survivors':int((bad==0).sum()),
                'best_priority_score':int(scores.min()),
                'best_strict_bad_fibers':int(strict_scores.min()) if len(strict) else None}
        records.append(record)
        np.savez_compressed(root/'checkpoint.npz',pool=pool,scores=scores,strict=strict,strict_scores=strict_scores,
                            rng_state=json.dumps(rng.bit_generator.state))
        if step%50==0:
            np.savez_compressed(root/f'round_{step+1:04d}.npz',coefficients=c,weights=w,derivative_weights=d)
            print('D5 CONDICIONADA',json.dumps(record),flush=True)
        (root/'progress.json').write_text(json.dumps({'gpu':engine.gpu,'rounds':records,'candidates':candidates},indent=2))
    # Fresh dense holdout never used as an evolutionary parent.
    hold_rng=np.random.default_rng(17100261006);hold=[]
    for _ in range(16):
        c=hold_rng.integers(0,2,(batch,width),dtype=np.uint8)
        for j in range(batch):
            k=int(hold_rng.choice(fresh_supports));c[j]=0;c[j,hold_rng.choice(width,k,replace=False)]=1
        w,d=exact_evaluate(engine,c)
        ok=np.isin(w.sum(axis=1),[32640,32896])&(d==32768)&(w[:,-1]==128)
        hold.append({'draws':batch,'passing_all_three':int(ok.sum()),'all_fiber_survivors':int(np.all(w[:,1:]==128,axis=1).sum())})
    # Independently rebuild the best strict elite's full ANF table and weights.
    best=None
    if len(strict):
        j=int(np.argmin(strict_scores));coeff=strict[j];truth=np.zeros(65536,np.uint8)
        inputs=np.arange(65536,dtype=np.uint32)
        for active,(rep,orbit) in zip(coeff,orbits):
            if active:
                for mon in orbit:
                    mask=sum(1<<i for i in mon);truth^=((inputs&mask)==mask).astype(np.uint8)
        weights=truth[indices].sum(axis=1);bad=int((weights[1:]!=128).sum())
        derivative=int((truth^truth[::-1]).sum());weight=int(truth.sum())
        assert weight in (32640,32896) and derivative==32768 and weights[-1]==128
        assert bad==int(strict_scores[j])
        spectrum=fwht(truth)
        best={'coefficients':coeff.astype(int).tolist(),'bad_fibers':bad,'weight':weight,'W0':65536-2*weight,
              'derivative_weight':derivative,'complementary_fiber_weight':int(weights[-1]),
              'absolute_walsh_values':np.unique(np.abs(spectrum)).tolist(),
              'bent':bool(np.all(np.abs(spectrum)==256)),
              'first_bad_fiber':next(({'z':z,'weight':int(weights[z])} for z in range(1,256) if weights[z]!=128),None),
              'truth_sha256':hashlib.sha256(truth.tobytes()).hexdigest(),'independent_integer_audit':'PASS'}
        (root/'best_strict.json').write_text(json.dumps(best,indent=2))
    summary={'gpu':engine.gpu,'degree':5,'n':16,'seed':100261006,'draws':len(records)*batch,
             'fresh_supports':list(fresh_supports),'strict_draws':total_strict,'best_strict_bad_fibers':None if best is None else best['bad_fibers'],
             'candidates':candidates,'holdout':hold,'rounds':records,'elapsed_seconds':time.monotonic()-start,
             'limitations':'Adaptive draws can repeat; finite evidence, not a universal proof.'}
    (root/'summary.json').write_text(json.dumps(summary,indent=2))
    archive=root.with_suffix('.zip')
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED) as z:
        for p in root.rglob('*'):
            if p.is_file():z.write(p,str(p))
        for name in ['campanha_densa_d5.py','pesquisa_fibras_loop.py','verify_fibras_loop.py']:
            if Path(name).exists():z.write(name)
    print('D5 FINAL',json.dumps({k:summary[k] for k in ['gpu','draws','strict_draws','best_strict_bad_fibers','elapsed_seconds']}),flush=True)
    print('D5 ZIP',str(archive),archive.stat().st_size,flush=True)
    return root,archive,summary
