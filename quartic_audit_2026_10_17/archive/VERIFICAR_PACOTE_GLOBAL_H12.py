"""Audit the received global archive without executing its binary."""
from pathlib import Path
import hashlib,json,math,time,zipfile,re,argparse
from itertools import combinations

parser=argparse.ArgumentParser(description='Verifica fonte, filtros e todos os lotes do ZIP global H12, sem executar o binario recebido. Requer Python 3.10+.')
parser.add_argument('archive')
parser.add_argument('--out',default='AUDITORIA_H12_GLOBAL.json')
args=parser.parse_args()
src=Path(args.archive)
out=Path(args.out)
t=time.perf_counter()
archive_hash=hashlib.sha256()
with src.open('rb') as f:
    for data in iter(lambda:f.read(1<<20),b''):archive_hash.update(data)
with zipfile.ZipFile(src) as z:
    prefix='h12_a100_global/'
    model=json.loads(z.read(prefix+'model.json'))
    audit=json.loads(z.read(prefix+'auditoria_independente.json'))
    source=z.read(prefix+'solver.cu')
    sha=hashlib.sha256(source).hexdigest()
    assert sha==model['cuda_sha256']==audit['source_sha256']
    assert model['basis_43_hex']==[hex(1<<i) for i in range(43)]
    assert model['active_equations']==43 and model['filters']==43
    assert model['process_exit_code']==0 and audit['dimension']==43
    assert model['requested_count']==1<<43 and model['start']==0
    assert model['log']==audit['log']
    # Exact source identification binds the reviewed algorithm and constants.
    assert sha=='0e346b6a0ecac8fdb553ee277333a4eb48244e163902ce238c706a06c59b2cba'
    text=source.decode()
    def array(name):
        line=next(v for v in text.splitlines() if re.match(r'static U '+name+r'\[',v))
        value=line.split('=',1)[1].rstrip(';')
        return json.loads(value.replace('{','[').replace('}',']').replace('ULL',''))
    L,Q,T,B=array('hL'),array('hQ'),array('hT'),array('basis')
    assert B==[1<<i for i in range(43)]
    def orbits(k):
        seen=set();result=[]
        for combo in combinations(range(12),k):
            v=sum(1<<j for j in combo)
            if v in seen:continue
            terms=[]
            for _ in range(12):
                if v not in terms:terms.append(v)
                v=((v<<1)&4095)|(v>>11)
            seen.update(terms);result.append(terms)
        return result
    orbs=orbits(4);assert len(orbs)==43
    truth=[]
    for j,terms in enumerate(orbs):
        anf=[0]*4096
        for m in terms:anf[m]^=1
        for bit in [1<<i for i in range(12)]:
            for x in range(4096):
                if x&bit:anf[x]^=anf[x^bit]
        column=sum(v<<x for x,v in enumerate(anf))
        assert column==sum(w<<(64*i) for i,w in enumerate(T[j]))
        truth.append(column)
    filters=[min(o) for o in orbits(8)];assert len(filters)==43
    for e,u in enumerate(filters):
        mask=sum(1<<x for x in range(4096) if x&u==x)
        columns=[t&mask for t in truth];weights=[v.bit_count() for v in columns]
        assert L[e]==sum(((w>>1)&1)<<j for j,w in enumerate(weights))
        for i in range(43):
            predicted=sum((((weights[i]&1)*(weights[j]&1))^((columns[i]&columns[j]).bit_count()&1))<<j for j in range(i+1,43))
            assert Q[e][i]==predicted
    print('PASS: 43 original truth columns and all 43 quadratic filters, by independent Mobius/carry formula.',flush=True)
    count=last_raw=last_w0=last_bent=0;gpu_ms=0.0;last=None;summary=None
    seen_validation=False;gpu=None;log_hash=hashlib.sha256()
    with z.open(prefix+model['log']) as f:
        for raw in f:
            log_hash.update(raw)
            line=raw.decode().strip()
            if not line:continue
            if line.startswith('GPU '):gpu=line;continue
            if line.startswith('CPU_GPU_VALIDATION_PASS '):
                assert line=='CPU_GPU_VALIDATION_PASS 2093'
                seen_validation=True;continue
            assert line.startswith('{'),line[:180]
            r=json.loads(line)
            if 'status' in r:
                assert summary is None
                summary=r;continue
            assert summary is None,'Output after completion summary'
            assert 'end_exclusive' in r,'Unexpected record: '+line[:180]
            count+=1
            end=count*(1<<20)
            assert r['tested']==r['end_exclusive']==end
            a,b,c=r['quadratic_survivors'],r['w0_survivors'],r['bent']
            assert 0<=c-last_bent<=b-last_w0<=a-last_raw<=1<<20
            assert 0<=c<=b<=a<=end
            ms=r['gpu_batch_ms'];assert math.isfinite(ms) and ms>=0
            gpu_ms+=ms;last_raw,last_w0,last_bent=a,b,c;last=r
            if count%1048576==0:print(f'LOG_AUDIT_PROGRESS {count}/8388608 batches',flush=True)
    expected={'status':'COMPLETE_RANGE','start':0,'count':1<<43,'requested':1<<43,'bent':0}
    assert count==1<<23 and summary==expected==model['range_summary']
    assert last_bent==0 and seen_validation
    assert audit['verification']=='PASS' and audit['covers_entire_model_domain'] is True
    assert audit['verified_log_start']==0 and audit['verified_log_end_exclusive']==1<<43
    assert len(audit['interval_tests'])==8
    result={'verification':'PASS_ARCHIVE_SOURCE_AND_COMPLETE_LOG',
            'archive_sha256':archive_hash.hexdigest(),'source_sha256':sha,
            'source_changes_from_prepared_version':['Two blank lines in parity helper','Default time limit 2400 to 5400 seconds'],
            'source_algorithm_and_all_embedded_constants_unchanged':True,
            'independent_mobius_truth_columns_verified':43,
            'independent_second_bit_carry_formulas_verified':43,
            'identity_basis_dimension':43,'five_initial_laws_assumed':False,
            'complete_range':summary,'batches_checked':count,
            'all_batch_boundaries_contiguous':True,'all_counter_increments_consistent':True,
            'full_log_sha256':log_hash.hexdigest(),'gpu_header':gpu,
            'cpu_gpu_validation_count':2093,'last_batch':last,
            'sum_reported_gpu_batch_seconds':gpu_ms/1000,
            'included_sparse_audit_consistent':True,'audit_seconds':time.perf_counter()-t,
            'limitations':['GPU enumeration was not repeated on this local machine.',
                           'Archive logs attest to the reported run; they are not a formal proof certificate of every hardware operation.',
                           'No conclusion for H(16,4), all even n, or novelty against literature.']}
out.write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps(result,indent=2),flush=True)
