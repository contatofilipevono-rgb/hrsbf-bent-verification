"""Depois da busca: %run AUDITAR_RESULTADO_H12.py h12_a100_auditado
Confere cobertura do log, bent por ANF/FWHT e oito intervalos CPU/GPU.
Nao execute em paralelo com a busca. --self-test usa somente CPU.
"""
import argparse
import hashlib
from itertools import combinations
import json
from pathlib import Path
import random
import subprocess


def orbit_data(k):
    seen=set(); data=[]
    for combo in combinations(range(12),k):
        support=sum(1<<j for j in combo)
        if support in seen:continue
        terms=[];v=support
        for _ in range(12):
            if v not in terms:terms.append(v)
            v=((v<<1)&4095)|(v>>11)
        seen.update(terms);data.append(terms)
    return data


ORB=orbit_data(4)


def truth_from_anf(c):
    """Mobius sobre coeficientes ANF; independente da avaliacao por subcubos."""
    a=[0]*4096
    for j,terms in enumerate(ORB):
        if c>>j&1:
            for m in terms:a[m]^=1
    for i in range(12):
        bit=1<<i
        for x in range(4096):
            if x&bit:a[x]^=a[x^bit]
    return sum(v<<x for x,v in enumerate(a))


def is_bent(t):
    w=[1-2*(t>>x&1) for x in range(4096)]
    size=1
    while size<4096:
        for start in range(0,4096,2*size):
            for i in range(start,start+size):
                a,b=w[i],w[i+size];w[i],w[i+size]=a+b,a-b
        size*=2
    return all(abs(v)==64 for v in w)


def self_test():
    quadratic=sum((sum(((x>>(2*i))&1)*((x>>(2*i+1))&1) for i in range(6))&1)<<x for x in range(4096))
    assert is_bent(quadratic)
    assert not is_bent(0)
    assert not is_bent(1)
    assert len(ORB)==43
    # Direct polynomial check against Mobius at every input for two quartics.
    for c in (1,(1<<43)-1):
        t=truth_from_anf(c)
        for x in range(4096):
            direct=sum(sum((x&m)==m for m in terms) for j,terms in enumerate(ORB) if c>>j&1)&1
            assert t>>x&1==direct


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('folder',nargs='?',default='h12_a100_auditado')
    ap.add_argument('--self-test',action='store_true')
    args=ap.parse_args();self_test()
    if args.self_test:
        print('SELF_TEST_PASS: bent conhecida aceita, zero e impulso rejeitados; ANF/Mobius concordam.');return
    folder=Path(args.folder);model=json.loads((folder/'model.json').read_text())
    digest=hashlib.sha256((folder/'solver.cu').read_bytes()).hexdigest()
    assert digest==model['cuda_sha256'],'Fonte diferente da registrada'
    files=sorted(folder.glob('run_*.log'),key=lambda p:p.stat().st_mtime_ns)
    assert files,'Nenhum log encontrado'
    # Audit the newest invocation, including a deliberately partial time-limited run.
    log=files[-1];lines=log.read_text().splitlines()
    assert any(line.startswith('CPU_GPU_VALIDATION_PASS ') for line in lines),'Validacao GPU ausente'
    records=[json.loads(line) for line in lines if line.startswith('{')]
    summaries=[r for r in records if 'status' in r];assert len(summaries)==1,'Resumo final ausente/duplicado'
    summary=summaries[0]
    assert summary['status'] in ('COMPLETE_RANGE','COMPLETE_CONDITIONAL_RANGE','PARTIAL_TIME_LIMIT')
    begin=summary['start'];end=begin;last_tested=last_raw=last_w0=last_bent=0
    checked_bent=0
    for r in records:
        if r.get('bent') is True and 'coefficients_hex' in r:
            c=int(r['coefficients_hex'],16)
            assert c < 1<<43 and is_bent(truth_from_anf(c)),'Bent anunciada nao confirmada'
            checked_bent+=1
        if 'end_exclusive' not in r:continue
        assert r['end_exclusive']>end and r['tested']==r['end_exclusive']-begin
        assert r['tested']-last_tested<=1<<20
        raw,w0,bent=r['quadratic_survivors'],r['w0_survivors'],r['bent']
        assert 0<=bent-last_bent<=w0-last_w0<=raw-last_raw<=r['tested']-last_tested
        end=r['end_exclusive'];last_tested=r['tested'];last_raw=raw;last_w0=w0;last_bent=bent
    assert end==begin+summary['count'] and last_bent==summary['bent']==checked_bent
    key='basis_43_hex' if 'basis_43_hex' in model else 'basis_36_hex'
    basis=[int(v,16) for v in model[key]];n=len(basis);assert n in (36,43)
    assert 0<=begin<end<=1<<n
    if 'count' in model:assert model['start']==begin and model['count']==summary['count']
    if model.get('range_summary') is not None:assert model['range_summary']==summary
    if summary['status']=='PARTIAL_TIME_LIMIT':assert summary['count']<summary['requested']
    elif 'requested' in summary:assert summary['count']==summary['requested']
    columns=[truth_from_anf(v) for v in basis]
    filters=[(min(o),1) for o in orbit_data(8)]
    if n==36:filters += [(u,2) for u in (0x3cf,0x5d7,0x6db)]+[(4095,3)]
    masks=[sum(1<<x for x in range(4096) if (x&u)==x) for u,b in filters]
    def cpu(start,count):
        raw=w0=bent=0
        for z in range(start,start+count):
            truth=0
            for j,t in enumerate(columns):
                if z>>j&1:truth^=t
            if any(((truth&m).bit_count()>>b)&1 for m,(u,b) in zip(masks,filters)):continue
            raw+=1
            if truth.bit_count() not in (2016,2080):continue
            w0+=1;bent+=is_bent(truth)
        return raw,w0,bent
    rng=random.Random(107);width=128;total=1<<n
    starts=[0,(1<<20)-64,(1<<32)-64,total-width]+[rng.randrange(total-width+1) for _ in range(4)]
    results=[]
    for start in starts:
        expected=cpu(start,width)
        p=subprocess.run([str((folder/'solver').resolve()),str(start),str(width),'60'],capture_output=True,text=True,check=True,timeout=120)
        rr=[json.loads(line) for line in p.stdout.splitlines() if line.startswith('{')]
        r=next(r for r in reversed(rr) if 'end_exclusive' in r)
        assert r['tested']==width and r['end_exclusive']==start+width
        actual=tuple(r[k] for k in ('quadratic_survivors','w0_survivors','bent'))
        assert actual==expected,(start,expected,actual)
        results.append({'start':start,'count':width,'counts':list(actual)})
        print(f'INTERVAL_CPU_GPU_PASS start={start} count={width}',flush=True)
    report={'verification':'PASS','log':log.name,'source_sha256':digest,'dimension':n,'verified_log_start':begin,'verified_log_end_exclusive':end,
            'covers_entire_model_domain':begin==0 and end==total,'scope':'Global H(12,4)' if n==43 else 'Conditional on five initial laws',
            'independently_confirmed_bent':checked_bent,'interval_tests':results,
            'limitation':'Sparse replay strengthens implementation checks; it does not independently repeat the entire search.'}
    (folder/'auditoria_independente.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2))


if __name__=='__main__':main()
