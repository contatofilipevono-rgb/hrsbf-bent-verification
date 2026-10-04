"""Independent verification of the h=1 affine-fiber obstruction certificate.

No imports from either the search program or its verifier. The matrices and
certificate rows are recomputed by evaluating the original 32-variable ANF.
"""
from itertools import combinations
from pathlib import Path
import json, hashlib, time

BASE=Path(__file__).resolve().parent

def check(ok, why):
    if not ok: raise RuntimeError(why)

def cyclic_orbits(n):
    groups={}
    for mon in combinations(range(n),3):
        rep=min(tuple(sorted((v+k)%n for v in mon)) for k in range(n))
        groups.setdefault(rep,[]).append(mon)
    return [tuple(groups[rep]) for rep in sorted(groups)]

def masks(orb): return [sum(1<<i for i in mon) for mon in orb]
def evaluate(poly,x): return sum((x&m)==m for m in poly)&1
def lift(u,z): return u|((u^z)<<16)

def direct_polar(poly,z):
    q0=evaluate(poly,lift(0,z))
    singles=[evaluate(poly,lift(1<<i,z)) for i in range(16)]
    rows=[0]*16
    for i,j in combinations(range(16),2):
        b=evaluate(poly,lift((1<<i)|(1<<j),z))^singles[i]^singles[j]^q0
        if b: rows[i]|=1<<j; rows[j]|=1<<i
    return rows

def rank(rows):
    pivots={}
    for row in rows:
        while row:
            p=row.bit_length()-1
            if p in pivots: row^=pivots[p]
            else: pivots[p]=row; break
    return len(pivots)

def run():
    start=time.perf_counter()
    inp=BASE/'certificado_7_fibras.json'
    data=json.loads(inp.read_text())
    cert=data
    check(cert['type']=='linear_contradiction','Wrong certificate type')
    check(cert['h']=='0x1','This checker is scoped to h=1')
    check(len(cert['equations'])==7 and cert['equation_count']==7,'Expected seven equations')
    orbs16,orbs32=cyclic_orbits(16),cyclic_orbits(32)
    check(len(orbs16)==35 and len(orbs32)==155,'Wrong orbit counts')
    check(all(len(o)==16 for o in orbs16) and all(len(o)==32 for o in orbs32),'Short cubic orbit')
    lookup16={mon:j for j,o in enumerate(orbs16) for mon in o}
    polys=list(map(masks,orbs32))
    hrows=[0]*35
    assignment=[]
    for j,o in enumerate(orbs32):
        images={tuple(sorted({v%16 for v in mon})) for mon in o}
        degrees={len(mon) for mon in images}
        check(len(degrees)==1,'Mixed folded degree')
        if degrees=={3}:
            targets={lookup16[mon] for mon in images}
            check(len(targets)==1,'Multiple folded orbit classes')
            target=targets.pop();hrows[target]|=1<<j;assignment.append(target)
        else: check(degrees=={2},'Unexpected folded degree');assignment.append(None)
    check(all(row.bit_count()==4 for row in hrows),'Not four lifts per h generator')
    check(rank(hrows)==35,'H projection not surjective')
    check(sum(a is None for a in assignment)==15,'Wrong antipodal orbit count')
    # Determine the 16 polar coefficient matrices of every original orbit
    # directly from ANF evaluations. This verifies the 155 -> 35 projection,
    # rather than trusting a symbolic folding implementation.
    polar_templates={}
    for j,poly in enumerate(polys):
        mats=tuple(tuple(direct_polar(poly,1<<k)) for k in range(16))
        a=assignment[j]
        if a is None:
            check(not any(row for mat in mats for row in mat),'Antipodal orbit changes polar tensor')
        elif a in polar_templates:
            check(mats==polar_templates[a],'Four lifts do not share polar tensor')
        else: polar_templates[a]=mats
    # Compare every template to the independent polarization of its 16-var
    # cubic. This also fixes index 0 and all other h labels unambiguously.
    for a,o in enumerate(orbs16):
        poly16=masks(o)
        for k in range(16):
            for i,j in combinations(range(16),2):
                b=0
                for subset in range(8):
                    x=0
                    for bit,direction in enumerate((1<<k,1<<i,1<<j)):
                        if subset>>bit&1:x^=direction
                    b^=evaluate(poly16,x)
                check(b==(polar_templates[a][k][i]>>j&1),'Incorrect H cubic tensor label')
    check(orbs16[0][0]==(0,1,2),'h=1 not contiguous orbit')
    selected=(hrows[0]&-hrows[0]).bit_length()-1
    representative=polys[selected]
    xor_row=0;xor_rhs=0;fibers=[];n_h=0
    for eq in cert['equations']:
        row=int(eq['row'],16);rhs=eq['rhs']
        if eq['kind']=='h':
            k=eq['index'];check(row==hrows[k],'Incorrect H equation row')
            check(rhs==int(k==0),'Incorrect H equation RHS');n_h+=1
        else:
            check(eq['kind']=='fiber','Unknown equation type')
            z,r=eq['z'],eq['r']
            check(z!=0 and r not in (0,z),'Dependent alleged radical pair')
            B=direct_polar(representative,z)
            check(rank(B)==14,'Fiber does not have polar rank 14')
            check(all((line&z).bit_count()%2==0 and (line&r).bit_count()%2==0 for line in B),'Incorrect radical vector')
            expected=0
            for j,poly in enumerate(polys):
                value=evaluate(poly,lift(r,z))^evaluate(poly,lift(0,z))
                if value: expected|=1<<j
                check((evaluate(poly,lift(z,z))^evaluate(poly,lift(0,z)))==0,'Half-turn derivative constraint fails')
            check(row==expected,'Incorrect fiber equation from original ANF')
            check(rhs==1,'Balance condition RHS not one')
            fibers.append({'z':z,'r':r,'polar_rank':14})
        xor_row^=row;xor_rhs^=rhs
    check(xor_row==0 and xor_rhs==1,'No XOR contradiction')
    result={'status':'verified','certificate_sha256':hashlib.sha256(inp.read_bytes()).hexdigest(),
        'h':'0x1','h_cubic':'sum_(i=0)^15 u_i*u_(i+1)*u_(i+2), indices modulo16',
        'family_dimension':120,'family_size':str(1<<120),
        'H_projection_rank':35,'verified_original_orbit_tensors':155,
        'direct_matrix_basis_directions_per_orbit':16,
        'equations':len(cert['equations']),'H_equations':n_h,
        'fiber_equations':len(fibers),'XOR_coefficients':0,'XOR_rhs':1,
        'fibers':fibers,'seconds':round(time.perf_counter()-start,3),
        'scope':'This fixed-H affine family only; neither all 32-variable HRS cubics nor literature novelty.'}
    (BASE/'resultado_7_fibras.json').write_text(json.dumps(result,indent=2))
    print(json.dumps({k:val for k,val in result.items() if k!='fibers'},indent=2))

if __name__=='__main__':run()
