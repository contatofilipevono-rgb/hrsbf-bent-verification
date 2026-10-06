"""Bounded Colab follow-up; finite experiments, never a universal certificate."""
import contextlib, itertools, json, time, zipfile, sys
from pathlib import Path
import numpy as np
import pesquisa_fibras_loop as research
from verify_fibras_loop import verify_round, fwht, directly_evaluate

DEADLINE = time.monotonic() + 7200
ROOT = Path('a100_adaptativa_' + time.strftime('%Y%m%d_%H%M%S'))
ROOT.mkdir(exist_ok=True)
UI = sys.stdout
STATE = {}
original_eval = research.Evaluator.evaluate
original_draw = research.draw_batch

def retain(coeffs, scores, limit=64):
    order = np.argsort(scores, kind='stable')
    keep, seen = [], set()
    for i in order:
        key = np.packbits(coeffs[i], bitorder='little').tobytes()
        if key not in seen:
            seen.add(key); keep.append(int(i))
        if len(keep) == limit: break
    return coeffs[keep].copy(), scores[keep].copy()

def audited_eval(self, coefficients):
    weights, derivative = original_eval(self, coefficients)
    width = coefficients.shape[1]
    bad = (weights[:, 1:] != weights.shape[1]//2).sum(axis=1)
    both = (derivative == self.basis.shape[1]//2) & (weights[:, -1] == weights.shape[1]//2)
    state = STATE.setdefault(width, {'hall':np.empty((0,width),np.uint8),'scores':np.empty(0,np.int32),
        'conditional':np.empty((0,width),np.uint8),'conditional_scores':np.empty(0,np.int32), 'stale':0})
    old = int(state['scores'].min()) if len(state['scores']) else 999
    state['hall'], state['scores'] = retain(np.vstack([state['hall'],coefficients]), np.r_[state['scores'],bad])
    state['conditional'], state['conditional_scores'] = retain(
        np.vstack([state['conditional'],coefficients[both]]), np.r_[state['conditional_scores'],bad[both]])
    state['stale'] = state['stale']+1 if int(state['scores'].min()) >= old else 0
    return weights, derivative

def adaptive_draw(rng, width, batch, elites, round_id):
    state = STATE.get(width)
    coefficients, kinds = original_draw(rng,width,batch,elites,round_id)
    if state is not None and len(state['hall']):
        for row in range(batch//2,batch):
            pool = state['conditional'] if row%2 and len(state['conditional']) else state['hall']
            coefficients[row] = pool[int(rng.integers(len(pool)))].copy()
            sizes = (1,2,4,8) if state['stale'] < 12 else (2,4,8,16,32)
            flips = rng.choice(width,size=min(width,sizes[row%len(sizes)]),replace=False)
            coefficients[row,flips] ^= 1
            if row%7 == 0:
                parent = state['hall'][int(rng.integers(len(state['hall'])))]
                mask = rng.integers(0,2,width,dtype=np.uint8).astype(bool)
                coefficients[row,mask] = parent[mask]
            kinds[row] = 2
    zero = np.flatnonzero(coefficients.sum(axis=1)==0)
    coefficients[zero,0] = 1
    if round_id%20 == 0:
        print('PROGRESSO',width,'rodada',round_id,'melhor',None if state is None else int(state['scores'].min()),flush=True,file=UI)
    return coefficients,kinds

research.Evaluator.evaluate = audited_eval
research.draw_batch = adaptive_draw

# Check the new selection logic without changing any mathematical condition.
for width in (7,273,715):
    test,kinds = adaptive_draw(np.random.default_rng(100+width),width,32,np.empty((0,width),np.uint8),0)
    if test.shape != (32,width) or np.any(test.sum(axis=1)==0) or not np.all((test==0)|(test==1)):
        raise RuntimeError('Adaptive selection control failed')

results=[]
for degree in (5,7):
    orbits,basis,indices = research.make_tables(16,degree)
    engine = research.Evaluator(basis,indices,'cuda')
    width=len(orbits); sparse_count=0; sparse_survivors=[]
    # Enumerate each nonzero coefficient support of size 1 or 2 exactly once.
    supports=itertools.chain(((i,) for i in range(width)),itertools.combinations(range(width),2))
    while time.monotonic()<DEADLINE:
        chunk=list(itertools.islice(supports,1024))
        if not chunk: break
        coefficients=np.zeros((len(chunk),width),np.uint8)
        for row,support in enumerate(chunk): coefficients[row,list(support)]=1
        weights,derivative=engine.evaluate(coefficients)
        survivors=np.flatnonzero(np.all(weights[:,1:]==128,axis=1)&(derivative==32768))
        for row in survivors:
            table=np.bitwise_xor.reduce(basis[coefficients[row].astype(bool)],axis=0)
            spectrum=fwht(table)
            sparse_survivors.append({'support':list(chunk[row]),'bent':bool(np.all(np.abs(spectrum)==256)),
                                    'absolute_walsh_values':np.unique(np.abs(spectrum)).tolist()})
        sparse_count+=len(chunk)
        if sparse_count%32768==0: print('ESPARSO',degree,sparse_count,flush=True,file=UI)
    expected=width+width*(width-1)//2
    result={'degree':degree,'basis_orbits':width,'tested':sparse_count,'expected':expected,
            'complete':sparse_count==expected,'survivors':sparse_survivors,'gpu':engine.gpu}
    results.append({'sparse':result})
    (ROOT/f'sparse_d{degree}.json').write_text(json.dumps(result,indent=2))
    print('ESPARSO FINAL',json.dumps(result),flush=True,file=UI)
    del engine,basis,indices

for cycle in range(4):
    for degree in (5,7):
        if time.monotonic()>=DEADLINE: break
        seed=70261006+1000*cycle+degree
        folder=ROOT/f'cycle{cycle+1}_d{degree}'
        with (ROOT/f'cycle{cycle+1}_d{degree}.log').open('w') as logfile, contextlib.redirect_stdout(logfile):
            summary=research.run(n=16,degree=degree,rounds=100,batch=2048,backend='cuda',seed=seed,
                                 output=str(folder),max_seconds=min(900,max(1,DEADLINE-time.monotonic())))
            witness=verify_round(folder,summary['rounds_completed'])
            holdout=research.validate_sample_cover(folder,draws=32768,seed=seed+987654321,backend='cuda')
        # Full Walsh check for every recorded candidate meeting necessary conditions.
        spectral=[]
        if summary['potential_candidates']:
            orbits,basis,indices=research.make_tables(16,degree)
            for candidate in summary['potential_candidates']:
                mask=int(candidate['coefficient_mask'],16)
                active=[i for i in range(len(basis)) if mask>>i&1]
                table=np.bitwise_xor.reduce(basis[active],axis=0) if active else np.zeros(65536,np.uint8)
                spectrum=fwht(table)
                spectral.append({'coefficient_mask':hex(mask),'bent':bool(np.all(np.abs(spectrum)==256)),
                                 'absolute_walsh_values':np.unique(np.abs(spectrum)).tolist()})
        record={'cycle':cycle+1,'degree':degree,'seed':seed,'draws':summary['tested_total'],
                'gpu':summary['gpu'],'elapsed':summary['elapsed_seconds'],'sample_cover':summary['global_sample_cover'],
                'all_fiber_survivors':summary['uncovered_by_all_fibers'],'witness':witness,
                'holdout':holdout,'full_spectral_checks':spectral,
                'global_best_unbalanced_fibers':int(STATE[summary['basis_orbits']]['scores'].min())}
        (folder/'independent_witness.json').write_text(json.dumps(witness,indent=2))
        (folder/'spectral_candidates.json').write_text(json.dumps(spectral,indent=2))
        results.append(record)
        (ROOT/'campaign_summary.json').write_text(json.dumps({'status':'RUNNING','records':results,
            'limitations':'Adaptive draws can repeat; sample covers and finite sparse classes are not universal proofs.'},indent=2))
        print('CICLO FINAL',json.dumps(record),flush=True,file=UI)
    if time.monotonic()>=DEADLINE: break
(ROOT/'campaign_summary.json').write_text(json.dumps({'status':'COMPLETED_BOUNDED','records':results,
    'limitations':'Adaptive draws can repeat; sample covers and finite sparse classes are not universal proofs.'},indent=2))
archive=ROOT.with_suffix('.zip')
with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED) as z:
    for path in ROOT.rglob('*'):
        if path.is_file(): z.write(path,str(path))
    for name in ('pesquisa_fibras_loop.py','verify_fibras_loop.py','validacao_cpu_gpu.json'):
        if Path(name).exists(): z.write(name)
print('CAMPANHA CONCLUIDA',archive,archive.stat().st_size,'bytes',flush=True,file=UI)
