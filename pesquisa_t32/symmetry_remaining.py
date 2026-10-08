"""Check full coefficient permutations induced by odd index multipliers."""
import json
from pathlib import Path
from audit_independent_cnf import REPS32, REPS16, TARGETS, need

KNOWN_SIX={'0xc0000004','0x60000008','0x50000040','0x42000080','0x41000400','0x240000800'}

def classes(path):
    remaining={int(f['h'],16) for f in json.loads(Path(path).read_text()) if f['h'] not in KNOWN_SIX}
    need(len(remaining)==24,'Unexpected remaining list.')
    look32={m:j for j,(_,orb) in enumerate(REPS32) for m in orb}
    look16={m:j for j,(_,orb) in enumerate(REPS16) for m in orb}
    permutations={}
    for k in range(1,32,2):
        p32=[look32[sum(1<<((k*i)%32) for i in s)] for s,_ in REPS32]
        p16=[look16[sum(1<<((k*i)%16) for i in s)] for s,_ in REPS16]
        need(sorted(p32)==list(range(155)) and sorted(p16)==list(range(35)),'Not a permutation.')
        need(all(TARGETS[p32[j]]==(None if TARGETS[j] is None else p16[TARGETS[j]]) for j in range(155)),'Projection does not commute.')
        permutations[k]=(p16,p32)
    output=[]; unseen=set(remaining)
    while unseen:
        h=min(unseen); witnesses={}
        for k,(p16,p32) in permutations.items():
            target=sum(((h>>i)&1)<<p16[i] for i in range(35))
            if target not in witnesses:
                witnesses[target]={'odd_multiplier':k,'coefficient_permutation_155':p32}
        need(set(witnesses)<=remaining,'Orbit leaves remaining list.')
        output.append({'representative':hex(h),'members':{hex(v):witnesses[v] for v in sorted(witnesses)}})
        unseen.difference_update(witnesses)
    need(sum(len(c['members']) for c in output)==24,'Incomplete orbit partition.')
    return output

if __name__=='__main__':
    import argparse
    p=argparse.ArgumentParser();p.add_argument('families',type=Path);p.add_argument('output',type=Path);a=p.parse_args()
    result=classes(a.families);a.output.write_text(json.dumps(result,indent=2)+'\n')
    print('24 families:',len(result),'verified symmetry classes')
