"""Verify odd multiplier equivalence on all cubic orbit generators."""
import argparse
import json
from pathlib import Path
from audit_all_ones_obstruction import orbits
from audit_next_weights import load_report

def groups(data):
    o16=orbits(16,3);o32=orbits(32,3)
    idx16={s:i for i,(_,o) in enumerate(o16) for s in o}
    idx32={s:i for i,(_,o) in enumerate(o32) for s in o}
    maps={}
    for m in range(1,32,2):
        p16=[idx16[tuple(sorted(m*i%16 for i in s))] for s,_ in o16]
        p32=[idx32[tuple(sorted(m*i%32 for i in s))] for s,_ in o32]
        assert sorted(p16)==list(range(35)) and sorted(p32)==list(range(155))
        for j,(_,o) in enumerate(o32):
            moved={tuple(sorted(m*i%32 for i in s)) for s in o}
            assert moved==set(o32[p32[j]][1])
            old=tuple(sorted({i%16 for i in o32[j][0]}))
            new=tuple(sorted({i%16 for i in o32[p32[j]][0]}))
            if old in idx16:assert idx16[new]==p16[idx16[old]]
            else:assert new not in idx16
        maps[m]=(p16,p32)
    pending={int(r['h'],16) for r in data['families'] if r['status']=='unresolved'}
    uncovered=set(pending);result=[]
    while uncovered:
        h=min(uncovered);members={}
        for m,(p16,p32) in maps.items():
            hh=sum(1<<p16[i] for i in range(35) if h>>i&1)
            assert hh in pending,'Pending set must be closed under tested symmetries.'
            members.setdefault(hex(hh),{'odd_multiplier':m,'permutation_155':p32})
        uncovered.difference_update(int(s,16) for s in members)
        result.append({'representative':hex(h),'H_weight':h.bit_count(),'members':members})
    return {'scope':'Equivalences only, no additional exclusion','pending_families':len(pending),
            'representatives':len(result),'families':result}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('input');p.add_argument('output');args=p.parse_args()
    data,_=load_report(Path(args.input));result=groups(data)
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('Verified:',result['pending_families'],'pending families,',result['representatives'],'representatives.')
