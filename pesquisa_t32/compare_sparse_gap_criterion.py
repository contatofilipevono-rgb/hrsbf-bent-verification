#!/usr/bin/env python3
"""Overlap with gap criterion quoted as Theorem 3.10 in arXiv:1708.09313."""
import itertools,json,math,hashlib
from pathlib import Path
from compressed_quintic_constraints import build_basis
orbits,reps,periods,basis=build_basis()
def gap(s):
    return max([b-a for a,b in zip(s,s[1:])]+[16+s[0]-s[-1]])
gaps=[gap(rep) for rep,orb in orbits]
small=[i for i,g in enumerate(gaps) if g<=8]
z1=reps.index(1)
passing=[]
for ids in itertools.combinations(range(273),3):
    if (basis[ids[0]][z1]^basis[ids[1]][z1]^basis[ids[2]][z1]).bit_count()==128:
        passing.append({'orbit_ids':ids,'max_cyclic_gap':max(gaps[i] for i in ids),
                        'covered_by_gap_criterion':all(gaps[i]<=8 for i in ids)})
report={'source':'https://arxiv.org/pdf/1708.09313, Theorem 3.10 (attributed there to Meng et al.)',
 'n':16,'degree':5,'total_orbits':273,'orbits_max_gap_le_8':len(small),
 'nonzero_support_le_3_covered_by_gap_criterion':sum(math.comb(len(small),k) for k in range(1,4)),
 'nonzero_support_le_3_total':sum(math.comb(273,k) for k in range(1,4)),
 'triples_balanced_on_z1':passing,
 'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
 'scope':'Overlap count with one published sufficient exclusion criterion only; noncoverage does not establish novelty.'}
Path(__file__).with_name('sparse_gap_overlap_2026-10-07.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='triples_balanced_on_z1'},indent=2))
print('triples balanced on z1:',len(passing),'covered by gap:',sum(x['covered_by_gap_criterion'] for x in passing))
