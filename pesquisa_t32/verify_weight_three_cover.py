"""Check exact coverage of all 6,545 fixed-H weight-three families.

Run without Python -O. This verifies finite certificates; read the associated
mathematical proof for the necessary conditions being certified.
"""
import itertools
import json
from pathlib import Path
from audit_all_ones_obstruction import orbits, polar
from audit_independent_cnf import audit_certificates, REPS16, REPS32

if not __debug__:
    raise RuntimeError('Run without -O: certificate checks must remain enabled.')

root=Path(__file__).resolve().parent
o16=orbits(16,3);o32=orbits(32,3)
assert [s for s,_ in o16]==[s for s,_ in REPS16]
assert [s for s,_ in o32]==[s for s,_ in REPS32]
idx={s:i for i,(_,oo) in enumerate(o16) for s in oo}
b16=[polar(16,oo) for _,oo in o16]
for s,oo in o32:
    t=idx.get(tuple(sorted({i%16 for i in s})))
    b=polar(32,oo)
    assert [((b[i]^b[i+16])>>16)&65535 for i in range(16)]==([0]*16 if t is None else b16[t])
excluded=set();passing=set()
for c in itertools.combinations(range(35),3):
    h=sum(1<<j for j in c)
    rows=[b16[c[0]][i]^b16[c[1]][i]^b16[c[2]][i] for i in range(16)]
    (excluded if any(rows) else passing).add(h)
p=root/'certificados_81_complementares.json'
report=json.loads(p.read_text())
complement=[int(r['h'],16) for r in report['families']]
assert len(complement)==len(set(complement))==81
assert set(complement)==passing
checks=audit_certificates([p])
assert checks[p.name]['certificates_verified']==len(passing)
assert len(excluded)==6464 and len(passing)==81
assert len(excluded|passing)==6545 and not excluded&passing
print('PASS: 6,464 all-ones obstructions + 81 independently checked fiber certificates = 6,545 fixed-H weight-three families. Other H weights remain outside this result.')
