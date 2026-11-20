"""Classify all 512 B0_11 reduced fibers by exact GF2 polynomial row spans.

Consumes the symbolic global 68-variable ideal from Step70 and specializes
the 9 quotient bits by the Boolean subset-zeta transform. The 512 specialized
systems are exact, NOT samples. Equal canonical RREF row spaces imply equal
zero sets in the 59 common remaining coordinates.

The output transfers previously audited Step65/Step69 UNSAT certificates only
to genuinely identical polynomial row spaces. This does not test variable
permutations, nonlinear ideal equality, or other cells.
"""
from collections import Counter
import hashlib
import json
from pathlib import Path
import time

N_U=35
N_T=9
N_R=24
N_PREFIX=1<<N_T
LOW=(1<<N_U)-1
T_MASK=(1<<N_T)-1


def canonical_basis(rows):
    basis={}
    for original in rows:
        word=original
        while word:
            p=word.bit_length()-1
            if p not in basis:
                basis[p]=word
                break
            word ^= basis[p]
    # Reduced pivot basis: eliminate low pivots in higher rows.
    for p in sorted(basis):
        for q in sorted(basis):
            if q!=p and ((basis[q]>>p)&1):
                basis[q] ^= basis[p]
    return tuple(basis[p] for p in sorted(basis,reverse=True))


def c_masks(global_polys):
    reduced=[]
    for row in global_polys:
        for mon in row:
            assert 0<=mon<(1<<68)
            t=(mon>>N_U)&T_MASK
            compact=(mon&LOW) | ((mon>>(N_U+N_T))<<N_U)
            reduced.append((t,compact))
    return reduced


def main():
    start=time.monotonic()
    raw=Path("global/step70_global_fiber_ideal.json").read_bytes()
    source=json.loads(raw)
    assert source["variables"]==68 and source["original_count"]==63
    assert len(source["polynomials"])==63 and source["crosschecks"]=={"0":True,"64":True}
    monomials=sorted(set(
        (mon&LOW)|((mon>>(N_U+N_T))<<N_U)
        for poly in source["polynomials"] for mon in poly
    ))
    assert all(mon.bit_length()<=59 for mon in monomials)
    positions={mon:i for i,mon in enumerate(monomials)}
    cubic=[mon for mon in monomials if mon.bit_count()==3]
    cp={mon:i for i,mon in enumerate(cubic)}
    n_eqs=63
    all_block=[[0]*n_eqs for _ in range(N_PREFIX)]
    cubic_block=[[0]*n_eqs for _ in range(N_PREFIX)]
    for i,poly in enumerate(source["polynomials"]):
        for mon in poly:
            t=(mon>>N_U)&T_MASK
            compact=(mon&LOW)|((mon>>(N_U+N_T))<<N_U)
            all_block[t][i] ^= 1<<positions[compact]
            if compact.bit_count()==3:
                cubic_block[t][i] ^=1<<cp[compact]
    for bit in range(N_T):
        for t in range(N_PREFIX):
            if (t>>bit)&1:
                for i in range(n_eqs):
                    all_block[t][i] ^= all_block[t^(1<<bit)][i]
                    cubic_block[t][i] ^= cubic_block[t^(1<<bit)][i]
    # The zeta transform evaluates all polynomial t-coefficients at each offset.
    def audit_fiber(offset,path):
        original=json.loads(Path(path).read_text())
        assert original["variables"]==59 and original["original_count"]==63
        ref=[]
        for row in original["polynomials"][:63]:
            word=0
            for mon in row:
                word ^=1<<positions[mon]
            ref.append(word)
        assert all_block[offset]==ref, f"Specialization mismatch for fiber {offset}"
    audit_fiber(0,"fiber0/step60_fiber.json")
    audit_fiber(64,"fiber64/step60_fiber.json")
    spaces={}
    cubics={}
    for t in range(N_PREFIX):
        full=canonical_basis(all_block[t])
        degree3=canonical_basis(cubic_block[t])
        spaces.setdefault(full,[]).append(t)
        cubics.setdefault(degree3,[]).append(t)
    assert sum(map(len,spaces.values()))==N_PREFIX
    assert sum(map(len,cubics.values()))==N_PREFIX
    class0=next(group for k,group in spaces.items() if 0 in group)
    class64=next(group for k,group in spaces.items() if 64 in group)
    assert not set(class0).intersection(class64)
    known_closed=sorted(set(class0)|set(class64))
    biggest=sorted(spaces.values(),key=lambda a:-len(a))[:12]
    biggest_cubic=sorted(cubics.values(),key=lambda a:-len(a))[:12]
    report={
        "source_sha256":hashlib.sha256(raw).hexdigest(),
        "global_ideal_equations":n_eqs,
        "quotient_fibers":512,
        "specialized_monomials":len(monomials),
        "specialized_cubic_monomials":len(cubic),
        "exact_specialization_replay":{"0":True,"64":True},
        "distinct_full_row_spaces":len(spaces),
        "full_rowspace_size_histogram":dict(sorted(Counter(map(len,spaces.values())).items())),
        "largest_full_rowspace_classes":biggest,
        "distinct_cubic_row_spaces":len(cubics),
        "cubic_rowspace_size_histogram":dict(sorted(Counter(map(len,cubics.values())).items())),
        "largest_cubic_rowspace_classes":biggest_cubic,
        "closed_by_proven_rowspace_transfer":known_closed,
        "closed_count_by_rowspace_transfer":len(known_closed),
        "still_unclosed_offsets":sorted(set(range(512))-set(known_closed)),
        "scope":"B0_11 selected Step70 parent algebraic cell only",
        "warning":"Matching cubic spans alone never transfers UNSAT, only exact FULL RREF equality does.",
        "duration_seconds":round(time.monotonic()-start,2)
    }
    Path("step71_fiber_rowspaces_summary.json").write_text(json.dumps(report,indent=2)+"\n")
    print("STEP71_FIBER_ROWSPACES",json.dumps({k:v for k,v in report.items() if k not in
        {"still_unclosed_offsets","closed_by_proven_rowspace_transfer","largest_cubic_rowspace_classes",
         "largest_full_rowspace_classes"}}),flush=True)
    print("STEP71_EXACT_CLOSED_OFFSETS",known_closed,flush=True)
    print("STEP71_TOP_FULL_CLASSES",biggest,flush=True)


if __name__=="__main__":
    main()
