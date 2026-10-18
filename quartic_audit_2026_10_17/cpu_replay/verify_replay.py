"""Independent exact audit of CPU chart coverage and every rejection witness.
Uses original ANF/Mobius truth tables, not the C model's embedded truth columns.
"""
from pathlib import Path
import argparse,csv,json,sys,itertools,hashlib,time
sys.path.insert(0,str(Path(__file__).resolve().parent.parent))
from verify_linear_laws import original_truth


def xor_selected(z,columns):
    v=0
    while z:
        bit=z&-z;v^=columns[bit.bit_length()-1];z^=bit
    return v


def main():
    ap=argparse.ArgumentParser();ap.add_argument('prefix');ap.add_argument('--require-full',action='store_true')
    ap.add_argument('--out');args=ap.parse_args();start=time.perf_counter()
    root=Path(__file__).resolve().parent;prefix=Path(args.prefix).resolve()
    model=json.loads((root/'model.json').read_text())
    laws=json.loads((root.parent/'linear_law_certificates.json').read_text())
    columns=[original_truth(o) for o in laws['basis']]
    packed_linear=[0]*43;packed_quadratic=[[0]*43 for _ in range(43)]
    for e,support in enumerate(laws['filter_supports']):
        subcube=sum(1<<x for x in range(4096) if x&support==x)
        cols=[t&subcube for t in columns]
        for i,v in enumerate(cols):packed_linear[i]|=((v.bit_count()>>1)&1)<<e
        for i,j in itertools.combinations(range(43),2):
            q=((cols[i].bit_count()&1)*(cols[j].bit_count()&1))^((cols[i]&cols[j]).bit_count()&1)
            packed_quadratic[i][j]|=q<<e
    def all_filters(c):
        value=0;z=c
        while z:
            bit=z&-z;i=bit.bit_length()-1;z^=bit;value^=packed_linear[i]
            zz=z
            while zz:
                b=zz&-zz;j=b.bit_length()-1;zz^=b;value^=packed_quadratic[i][j]
        return value
    lines=prefix.with_suffix('.log').read_text().splitlines()
    assert lines[0]=='SELF_TEST_PASS 8192 affine points and Gray updates'
    records=[json.loads(x) for x in lines[1:] if x.startswith('{')]
    finals=[r for r in records if 'status' in r];assert len(finals)==1
    summary=finals[0];bits=summary['high_bits'];full=bits==30
    assert summary['status']==('COMPLETE_NECESSARY_CHARTS' if full else 'PILOT_CHART_PREFIX')
    if args.require_full:assert full,'Pilot does not cover the complete necessary charts.'
    assert summary['tested']==4*(1<<(bits+6))
    jobs=[r for r in records if 'high_index_start' in r]
    for chart in range(4):
        pieces=sorted((r for r in jobs if r['chart']==chart),key=lambda r:r['high_index_start'])
        end=0
        for r in pieces:
            assert r['high_index_start']==end
            assert r['tested']==64*(r['high_index_end']-end)
            assert r['bent']==0;end=r['high_index_end']
        assert end==1<<bits
    observed=[{'quadratic':0,'w0':0} for _ in range(4)]
    character_columns=[sum(((x>>i)&1)<<x for x in range(4096)) for i in range(12)]
    characters={0:0};seen=set();files=sorted(prefix.parent.glob(prefix.name+'_thread*.csv'));assert files
    for file in files:
        with file.open(newline='') as stream:
            for row in csv.DictReader(stream):
                chart=int(row['chart']);z=int(row['free_coefficient'],16);c=int(row['original_coefficient'],16)
                a=int(row['witness_frequency']);w=int(row['walsh_value'])
                assert 0<=chart<4 and 0<=z<1<<(bits+6) and 0<=c<1<<43
                assert c==model['charts'][chart]['offset']^xor_selected(z,model['charts'][chart]['basis'])
                assert c not in seen;seen.add(c)
                assert all_filters(c)==0,(hex(c),'not a filter zero')
                assert 0<=a<4096 and abs(w)!=64,(hex(c),'missing rejection witness')
                truth=xor_selected(c,columns)
                if a not in characters:characters[a]=xor_selected(a,character_columns)
                actual=4096-2*(truth^characters[a]).bit_count()
                assert actual==w,(hex(c),a,actual,w)
                observed[chart]['quadratic']+=1
                observed[chart]['w0']+=abs(4096-2*truth.bit_count())==64
    for chart,obs in enumerate(observed):
        totals=[r for r in records if r.get('chart_complete')==chart];assert len(totals)==1
        assert all(obs[key]==totals[0][key]==sum(j[key] for j in jobs if j['chart']==chart) for key in obs)
    assert sum(x['quadratic'] for x in observed)==summary['quadratic']==len(seen)
    assert sum(x['w0'] for x in observed)==summary['w0']
    assert summary['bent']==0
    report={'status':'PASS_FULL_NECESSARY_CHARTS' if full else 'PASS_PILOT_ONLY',
            'coverage':'Four disjoint necessary affine charts, not a direct 2^43 enumeration.',
            'tested':summary['tested'],'quadratic_survivors':len(seen),
            'all_rejection_witnesses_independently_verified':len(seen),
            'w0_survivors':summary['w0'],'bent':0,'per_chart':observed,
            'run_elapsed_ms_reported':summary['elapsed_ms'],'audit_seconds':round(time.perf_counter()-start,3),
            'logical_scope':'Global exclusion additionally uses the proved four-case reduction and the three certified necessary linear laws.',
            'lean_global_nonexistence_formalized':False,
            'files':[{'name':p.name,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in [prefix.with_suffix('.log'),*files]]}
    if args.out:Path(args.out).write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2))


if __name__=='__main__':main()
