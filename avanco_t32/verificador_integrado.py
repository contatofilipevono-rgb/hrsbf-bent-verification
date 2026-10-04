"""HRSBF audit, exact integers, Python >=3.10 standard library only.

Finite verification, not a proof of the analytic reduction or of novelty.
No random search is reported as exhaustive. No GPU required.
Outputs: resultados.json, resultados.txt in this script's directory (or cwd).
"""
from itertools import combinations
from collections import Counter
from functools import lru_cache
from pathlib import Path
import hashlib
import json
import math
import platform
import random
import sys
import time


class VerificationError(RuntimeError):
    pass


def require(condition, message):
    if not condition:
        raise VerificationError(message)


@lru_cache(None)
def orbit_basis(n, degree):
    seen, result = set(), []
    for mon in combinations(range(n), degree):
        if mon in seen:
            continue
        orb = tuple(sorted({tuple(sorted((i+s) % n for i in mon)) for s in range(n)}))
        seen.update(orb)
        result.append(orb)
    require(len(seen) == math.comb(n, degree), 'Incomplete monomial partition')
    require(sum(map(len, result)) == len(seen), 'Overlapping monomial orbits')
    return tuple(result)


def anf_masks(orb):
    return tuple(sum(1 << i for i in mon) for mon in orb)


@lru_cache(None)
def variables(n):
    N = 1 << n
    return tuple(int.from_bytes(bytes(sum(((8*j+b) >> i & 1) << b for b in range(8))
                                      for j in range(max(1, N//8))), 'little') & ((1 << N)-1)
                 for i in range(n))


def truth_bits(n, polynomial):
    vs = variables(n)
    full = (1 << (1 << n))-1
    ans = 0
    for mon in polynomial:
        term = full
        while mon:
            bit = mon & -mon
            term &= vs[bit.bit_length()-1]
            mon ^= bit
        ans ^= term
    return ans


def unpack(word, n):
    N = 1 << n
    return [(b >> i) & 1 for b in word.to_bytes((N+7)//8, 'little') for i in range(8)][:N]


def fwht(values):
    a = list(values)
    h = 1
    while h < len(a):
        for start in range(0, len(a), 2*h):
            for j in range(start, start+h):
                x, y = a[j], a[j+h]
                a[j], a[j+h] = x+y, x-y
        h *= 2
    return a


def spectrum(word, n):
    w = fwht(1-2*v for v in unpack(word, n))
    require(sum(x*x for x in w) == 1 << (2*n), 'Parseval failed')
    require(w[0] == (1 << n)-2*word.bit_count(), 'Weight/Walsh mismatch')
    return w


def full_rank(rows):
    pivots = {}
    for row in rows:
        while row:
            p = row.bit_length()-1
            if p not in pivots:
                pivots[p] = row
                break
            row ^= pivots[p]
    return len(pivots)


def reduced_generators(n, with_linear=True):
    polys = [anf_masks(o) for d in (2, 3) for o in orbit_basis(n, d) if len(o) == n]
    if with_linear:
        polys.append(tuple(1 << i for i in range(n)))
    return polys


def stage_bases():
    result = {}
    for n in (2, 4, 8):
        gens = [truth_bits(n, p) for p in reduced_generators(n)]
        expected = {2:1, 4:3, 8:11}[n]
        require(len(gens) == expected, 'Incorrect base generator count')
        require(full_rank(gens) == expected, 'Dependent base generators')
        vals, word, prev = set(), 0, 0
        for c in range(1 << len(gens)):
            gray = c ^ (c >> 1)
            if c:
                word ^= gens[(gray ^ prev).bit_length()-1]
            prev = gray
            vals.add((1 << n)-2*word.bit_count())
        target = 1 << (n//2)
        require(target not in vals and -target not in vals, 'Bent-compatible base weight found')
        result[str(n)] = {'generators':len(gens), 'functions':1 << len(gens), 'W0_values':sorted(vals)}
    return result


def stage_ward():
    n, N = 16, 65536
    polys = reduced_generators(n)
    tables = [truth_bits(n, p) for p in polys]
    require(len(tables) == 43 and full_rank(tables) == 43, 'Wrong t16 dimension')
    antipodal = sum(1 << (u | (u << 8)) for u in range(256))
    require(all(t & antipodal == 0 for t in tables), 'Antipodal vanishing failed')
    representatives = []
    for x in range(N):
        if ((x << 8) | (x >> 8)) & (N-1) == x:
            continue
        if x == min(((x << s) | (x >> (16-s))) & (N-1) for s in range(16)):
            representatives.append(x)
    require(len(representatives) == 4080, 'Wrong input orbit count')
    # Independent evaluation on representatives: direct monomial evaluation.
    compressed = []
    for p in polys:
        w = sum((sum((x & m) == m for m in p) % 2) << j for j,x in enumerate(representatives))
        compressed.append(w)
    result = {}
    for k in range(1,5):
        total, core, digest = 0, 0, hashlib.sha256()
        for subset in combinations(range(43), k):
            a, b = tables[subset[0]], compressed[subset[0]]
            for i in subset[1:]:
                a &= tables[i]
                b &= compressed[i]
            wa, wb = a.bit_count(), b.bit_count()
            require(wa == 16*wb, f'Orbit/full table disagreement: {subset}')
            require(wb % (1 << (5-k)) == 0, f'Ward failure: {subset}')
            digest.update(bytes(subset)); digest.update(wb.to_bytes(4, 'little'))
            total += 1
            core += 42 not in subset  # L is the final generator.
        require(total == math.comb(43,k) and core == math.comb(42,k), 'Missing intersections')
        result[str(k)] = {'tested_43':total, 'tested_42_without_L':core,
                          'compressed_divisor':1 << (5-k), 'sha256_intersections':digest.hexdigest()}
    require(sum(v['tested_43'] for v in result.values()) == 136697, 'Wrong Ward total')
    return {'rank':43, 'input_representatives':4080, 'orders':result,
            'proof_core_conditions':124313, 'additional_with_L':12384}


def fold_orbit(orb, t):
    result = set()
    for mon in orb:
        reduced = sum(1 << i for i in {j % t for j in mon})
        result.symmetric_difference_update([reduced])
    return result


def stage_folding():
    result = []
    for t in (2,4,8,16):
        for m in (1,3,5):
            n = t*m
            forbidden = { (1 << i) | (1 << (i+t//2)) for i in range(t//2)}
            count = 0
            for orb in orbit_basis(n, 3):
                restricted = fold_orbit(orb,t)
                require(not (restricted & forbidden), 'Antipodal quadratic survives cubic fold')
                require(0 not in restricted, 'Unexpected constant')
                count += 1
            q = tuple((i,i+n//2) for i in range(n//2))
            require(fold_orbit(q,t) == forbidden, 'Positive quadratic fold control failed')
            result.append({'t':t,'odd_m':m,'cubic_orbits_tested':count})
    return {'scope':'finite controls only; general folding lemma proved in manuscript','cases':result}


def stage_positive_n12():
    n=12
    cubic = tuple(sorted({tuple(sorted((j+s)%n for j in (0,2,6))) for s in range(n)}))
    adjacent = tuple(tuple(sorted((i,(i+1)%n))) for i in range(n))
    antipodal = tuple((i,i+6) for i in range(6))
    poly = anf_masks(cubic+adjacent+antipodal)
    word = truth_bits(n,poly)
    w = spectrum(word,n)
    require(all(abs(v) == 64 for v in w), 'Known cubic nonhomogeneous bent control was missed')
    require(word.bit_count() == 2080, 'Positive control wrong weight')
    return {'homogeneous':False,'degree':3,'bent':True,'weight':2080,
            'walsh_distribution':dict(sorted(Counter(w).items())),
            'ANF':'sum i=0..11 x_i*x_(i+2)*x_(i+6) + sum i=0..11 x_i*x_(i+1) + sum i=0..5 x_i*x_(i+6), indices mod12'}


def stage_quartic_n8():
    tables = [truth_bits(8,anf_masks(o)) for o in orbit_basis(8,4)]
    require(len(tables) == 10, 'Wrong quartic basis')
    word, prev, best, bent, processed = 0,0,0,0,0
    for c in range(1024):
        gray = c ^ (c >> 1)
        if c:
            word ^= tables[(gray ^ prev).bit_length()-1]
        prev = gray
        w = spectrum(word,8)
        maximum = max(map(abs,w))
        bent += all(abs(v) == 16 for v in w)
        best = max(best,128-maximum//2)
        processed += 1
    require(processed == 1024 and bent == 0 and best == 110, 'Quartic regression failed')
    return {'scope':'all homogeneous quartic RS functions, including zero','processed':processed,
            'bent_count':bent,'max_nonlinearity':best,'novelty':'not established'}


def evaluation_rank(points, monomials):
    basis, used = {},0
    for x in points:
        used += 1
        row = sum(1 << j for j,m in enumerate(monomials) if x & m == m)
        while row:
            p = row.bit_length()-1
            if p not in basis:
                basis[p] = row
                break
            row ^= basis[p]
        if len(basis) == len(monomials):
            break
    return {'rank':len(basis),'columns':len(monomials),'points_used':used}


def stage_example_n16():
    # Ordering is by lexicographically minimal cyclic gap compositions.
    comps = sorted({min(g[i:]+g[:i] for i in range(3)) for a in range(1,15)
                    for b in range(1,16-a) for g in [(a,b,16-a-b)]})
    mask = 0xAB0111CB
    require(mask == int('10101011000000010001000111001011',2), 'Mask inconsistency')
    polynomial = set()
    for i,(a,b,c) in enumerate(comps):
        if mask >> i & 1:
            polynomial.update(sum(1 << j for j in {(v+s)%16 for v in (0,a,a+b)}) for s in range(16))
    word = truth_bits(16,polynomial)
    w = spectrum(word,16)
    truth = unpack(word,16)
    require(word.bit_count() == 32512 and w[0] == 512 and max(map(abs,w)) == 512, 'Example spectral mismatch')
    require(all(truth[x] == truth[((x<<1)|(x>>15)) & 65535] for x in range(65536)), 'Not rotation symmetric')
    ac_raw = fwht(v*v for v in w)
    require(all(v % 65536 == 0 for v in ac_raw), 'Noninteger autocorrelation')
    ac = [v//65536 for v in ac_raw]
    derivative_weights = [sum(truth[x] ^ truth[x ^ (1<<i)] for x in range(65536)) for i in range(16)]
    require(all(v == 32768 for v in derivative_weights), 'SAC failure')
    require(all(ac[1<<i] == 65536-2*derivative_weights[i] for i in range(16)), 'Autocorrelation methods disagree')
    monomials = [sum(1 << i for i in mon) for d in range(3) for mon in combinations(range(16),d)]
    ranks = {str(v):evaluation_rank((x for x in range(65536) if truth[x] == v),monomials) for v in (0,1)}
    require(all(r['rank'] == 137 for r in ranks.values()), 'AI lower bound not proved on both supports')
    return {'mask_hex':hex(mask),'mask_binary':bin(mask),'active_orbits':mask.bit_count(),
            'weight':word.bit_count(),'nonlinearity':32512,'max_abs_walsh':512,
            'walsh_distribution':dict(sorted(Counter(w).items())), 'AI':3,'evaluation_ranks':ranks,
            'SAC_derivative_weights':derivative_weights,'optimality':'unbalanced subclass only',
            'global_optimality':'not proved','literature_record':'not established'}


def fiber_polynomial(orb, half, z):
    """Full substitution x=(u,u+z), including constant and linear terms."""
    polynomial=set()
    for mon in orb:
        terms={0}
        for j in mon:
            variable = 1 << (j % half)
            affine_constant = (z >> (j-half)) & 1 if j >= half else 0
            new=set()
            for term in terms:
                new.symmetric_difference_update([term | variable])
                if affine_constant:
                    new.symmetric_difference_update([term])
            terms=new
        polynomial.symmetric_difference_update(terms)
    require(all(m.bit_count() <= 2 for m in polynomial), 'Fiber degree exceeds two')
    return polynomial


def kernel_basis(rows,n):
    rows=list(rows);pivots=[];r=0
    for col in range(n):
        pivot=next((j for j in range(r,n) if rows[j] >> col & 1),None)
        if pivot is None:
            continue
        rows[r],rows[pivot]=rows[pivot],rows[r]
        for j in range(n):
            if j != r and rows[j] >> col & 1:
                rows[j] ^= rows[r]
        pivots.append(col);r+=1
    result=[]
    for free in set(range(n))-set(pivots):
        v=1 << free
        for j,col in enumerate(pivots):
            if rows[j] >> free & 1:
                v |= 1 << col
        result.append(v)
    return result


def quadratic_balanced(poly,n):
    rows=[0]*n
    for m in poly:
        if m.bit_count()==2:
            lo=m & -m;hi=m ^ lo
            rows[lo.bit_length()-1] ^= hi
            rows[hi.bit_length()-1] ^= lo
    kernel=kernel_basis(rows,n)
    require(all(all((v&r).bit_count()%2 == 0 for r in rows) for v in kernel), 'Invalid radical basis')
    # q(v)+q(0), so the constant cancels; the linear terms must remain.
    return any(sum((v&m)==m for m in poly if m) % 2 for v in kernel)


def stage_fibers_t32():
    orbs=orbit_basis(32,3)
    require(len(orbs)==155, 'Wrong number of cubic orbits')
    polys=[fiber_polynomial(o,16,1) for o in orbs]
    # Independent substitution check against the original 32-variable ANF.
    # These finite checks supplement, rather than prove, the substitution identity.
    substitution_checks=0
    control_rng=random.Random(32016)
    for orb in orbs:
        masks=[sum(1<<j for j in mon) for mon in orb]
        for z in (0,1,3,0x8001):
            restricted=fiber_polynomial(orb,16,z)
            for u in [0,65535]+[control_rng.randrange(65536) for _ in range(16)]:
                x=u | ((u ^ z)<<16)
                original=sum((x&m)==m for m in masks)%2
                reduced=sum((u&m)==m for m in restricted)%2
                require(original==reduced,'Original ANF and substitution disagree')
                substitution_checks+=1
    passed, false_rejections=[],[]
    for i,p in enumerate(polys):
        algebraic=quadratic_balanced(p,16)
        direct=truth_bits(16,p).bit_count()==32768
        require(algebraic==direct,f'Radical and full fiber disagree: {i}')
        if direct:passed.append(i)
        truncated={m for m in p if m.bit_count()==2}
        if direct and not quadratic_balanced(truncated,16):false_rejections.append(i)
    require(len(passed)==19 and len(false_rejections)==15,'Individual fiber regression failed')
    witness=next(i for i,o in enumerate(orbs) if (0,1,16) in o)
    require(polys[witness]=={1<<15},'Lost linear witness u15')
    # Random sparse combinations: percentages apply only to this sampling scheme.
    rng=random.Random(2026);samples=10000;survived=0;direct_checks=0
    for trial in range(samples):
        chosen=rng.sample(range(155),rng.randint(2,8))
        p=set()
        for i in chosen:p.symmetric_difference_update(polys[i])
        balanced=quadratic_balanced(p,16)
        survived+=balanced
        if trial<100:
            require(balanced==(truth_bits(16,p).bit_count()==32768),'Combination fiber disagreement')
            direct_checks+=1
    return {'fiber':'x=(u,u+e0)','individual_orbits':155,'pass':len(passed),'reject':155-len(passed),
            'original_ANF_substitution_checks':substitution_checks,
            'pass_indices':passed,'false_rejections_if_linear_terms_omitted':false_rejections,
            'sampling':{'seed':2026,'trials':samples,'terms':'uniform integer 2..8, distinct orbits per trial',
                        'pass':survived,'reject':samples-survived,'direct_checks':direct_checks},
            'scope':'necessary single-fiber condition only; no global nonexistence conclusion'}


def stage_negative_controls():
    caught=False
    try:require(False,'intentional negative control')
    except VerificationError:caught=True
    require(caught,'Failure handling did not stop a false condition')
    require(int('10101011000000010001000111001011',2) != 0x558088E5,'Bad mask not detected')
    require(quadratic_balanced({1<<15},16) and not quadratic_balanced(set(),16),'Lost linear term not detected')
    return {'false_condition_raises':caught,'old_mask_rejected':True,'omitted_linear_term_detected':True}


def stage_t32_divisibility_boundary():
    # Transfer matrix for cyclic sum_i x_i*x_(i+1)*x_(i+2).
    matrix=[[0]*4 for _ in range(4)]
    for a in range(2):
        for b in range(2):
            for c in range(2):
                matrix[2*a+b][2*b+c]=(-1)**(a*b*c)
    power=[[int(i==j) for j in range(4)] for i in range(4)]
    small_checks=0
    for n in range(1,33):
        power=[[sum(power[i][k]*matrix[k][j] for k in range(4)) for j in range(4)] for i in range(4)]
        trace=sum(power[i][i] for i in range(4))
        if 3<=n<=12:
            poly=set()
            for i in range(n):
                poly.symmetric_difference_update([sum(1<<j for j in {i,(i+1)%n,(i+2)%n})])
            require(trace==(1<<n)-2*truth_bits(n,poly).bit_count(),'Transfer matrix disagrees with full truth table')
            small_checks+=1
    weight=((1<<32)-trace)//2
    require(trace==85032960 and weight==2104967168 and (weight//32)%2048==512,'t32 boundary mismatch')
    return {'W0':trace,'weight':weight,'compressed_weight':weight//32,
            'compressed_residue_mod_2048':512,'small_dimension_cross_checks':small_checks,
            'scope':'refutes this universal divisibility extension, not the bent conjecture'}


def main():
    folder=Path(__file__).resolve().parent if '__file__' in globals() else Path.cwd()
    report={'status':'running','python':sys.version,'platform':platform.platform(),
            'arithmetic':'exact Python integers; no GPU, no floating point',
            'stages':{},'not_claimed':['bibliographic novelty','global n16 optimum','complete t32 classification','Lean certification']}
    if '__file__' in globals():
        report['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    started=time.perf_counter();logs=[]
    def log(s):logs.append(s);print(s,flush=True)
    stages=[('negative_controls',stage_negative_controls),('small_bases',stage_bases),
            ('ward',stage_ward),('folding',stage_folding),('positive_bent_n12',stage_positive_n12),
            ('quartic_n8',stage_quartic_n8),('example_n16',stage_example_n16),('fibers_t32',stage_fibers_t32),
            ('t32_divisibility_boundary',stage_t32_divisibility_boundary)]
    try:
        for name,fn in stages:
            t=time.perf_counter();log('START '+name)
            data=fn()
            report['stages'][name]={'status':'passed','seconds':round(time.perf_counter()-t,3),'data':data}
            log('PASS '+name+': '+json.dumps(data,ensure_ascii=True))
        report['status']='passed'
        log('PASS: all specified finite checks completed. Scope limits remain as recorded.')
    except Exception as exc:
        report['status']='failed';report['error']=repr(exc)
        log('FAILED: '+repr(exc))
        raise
    finally:
        report['elapsed_seconds']=round(time.perf_counter()-started,3)
        (folder/'resultados.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
        (folder/'resultados.txt').write_text('\n'.join(logs)+'\n',encoding='utf-8')
    return report


if __name__=='__main__':
    main()
