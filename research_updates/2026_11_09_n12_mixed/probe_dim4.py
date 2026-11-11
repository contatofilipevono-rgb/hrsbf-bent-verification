"""Size the dimension-four map spaces and sample their support filters."""
import argparse
import collections
import json
from itertools import combinations
from pathlib import Path
from random import Random
from time import perf_counter

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import evaluate_orbit, orbits, xor_terms
from higher_project import LOW, TOP
from mobius_rule import integer_anf
from outside_polar_profiles import PAIRS, cyclic_subspaces, polar_column

def complementary(basis):
    span = set(all_points(basis))
    out = []
    for e in (1,2,4,8,16,32):
        if e not in span:
            out.append(e)
            span |= {x ^ e for x in span}
    return out

spaces=[b for b in cyclic_subspaces() if len(b)==4]
even=[1|32, 2|32,4|32,8|32,16|32]
original=[evaluate_orbit(o) for _,o in (*orbits(12,0),*orbits(12,1),*LOW,*TOP)]

def analyse(basis, samples=32768, seed_value=12124):
    cols = all_points(complementary(basis) + basis)
    coord = [(z ^ w)|(w << 6) for w in cols for z in range(64)]
    mask=sum(1 << m for m in range(4096) if (m >> 8).bit_count() >= 2)
    moved = [sum(((f >> x) & 1) << i for i,x in enumerate(coord)) for f in original]
    forbidden = [sum((a & 1) << m for m,a in enumerate(integer_anf(f))) & mask for f in moved]
    for i, c in enumerate(forbidden):
        j = i - (len(original) - 43)
        if j < 0:
            continue
        a = j in (0,4,7,9,22,27,29,37)
        b = j in (1,3,5,8,24,28,34,36)
        forbidden[i] = c | (a << 4096) | (b << 4097)
    _, kernel = image_and_kernel(forbidden)
    phases = (1 << 256) - 1
    def pi(f):
        return sum((((f >> (256 << j)) ^ f)&phases) << (256*j) for j in range(4))
    image, phase = image_and_kernel([pi(xor_terms(moved,c)) for c in kernel])
    print('basis',basis,'inside U',all(not x.bit_count()%2 for x in basis),'RS dim',len(kernel),'map dim',len(image),'phase dim',len(phase),'maps',1<<len(image))

    # Small uniform sample of the map space, before any phase work.
    maps = [sum(sum((p >> (256*j+x)&1)<<j for j in range(4))<<(4*x)
                for x in range(256)) for p,_ in image]
    seed = Random(seed_value)
    quadratics = [sum(1 << x for x in range(256) if x & ((1 << i) | (1 << j)) == ((1 << i) | (1 << j)))
                  for i,j in combinations(range(8),2)]
    stats = collections.Counter()
    start=perf_counter()
    for _ in range(samples):
        m = xor_terms(maps, seed.getrandbits(len(maps)))
        sizes = [0]*16
        sums = [0]*16
        fibers = [0]*16
        for x in range(256):
            b = m&15
            m >>= 4
            sizes[b]+=1
            if sizes[b] > 16: break
            sums[b]^=x
            fibers[b]|=1<<x
        else:
            stats["balanced"]+=1
            if not any(sums) and all(not (P & row).bit_count()&1 for P in fibers for row in quadratics):
                stats["support_moments"]+=1
    seconds = perf_counter() - start
    print('sample',dict(stats),'seconds',round(seconds,3))
    return {'basis': basis, 'RS_dimension': len(kernel), 'map_dimension': len(image),
            'phase_dimension': len(phase), 'samples': samples, 'seed': seed_value,
            'filters': dict(stats), 'seconds': seconds}

def isotropic(polar,b):
    for u,v in combinations(b,2):
        out=0
        for k,(i,j) in enumerate(PAIRS):
            if (((u>>i)&(v>>j))^((u>>j)&(v>>i)))&1:
                out^=(polar>>(64*k))&((1<<64)-1)
        if out:
            return False
    return True

def compare_catalogue(path):
    lo=[polar_column(o) for _,o in LOW]
    hi=[polar_column(o) for _,o in TOP]
    counts=collections.Counter()
    with path.open(encoding="utf-8") as f:
        for line in f:
            t,l,m=map(int,line.split())
            counts[t,l]+=4*m
    group=collections.Counter()
    p_cache={}
    for (t,l),n in counts.items():
        p=xor_terms(hi,t)^xor_terms(lo,l)
        if p not in p_cache:p_cache[p]=tuple(isotropic(p,b) for b in [*spaces,even])
        group[p_cache[p]]+=n
    print('catalogue membership by space V1,V2,U',dict(sorted(group.items())))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--catalogue", type=Path)
    parser.add_argument('--samples', type=int, default=32768)
    parser.add_argument('--seed', type=int, default=12124)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    reports = []
    for basis in spaces:
        reports.append(analyse(basis, args.samples, args.seed))
    if args.catalogue:
        compare_catalogue(args.catalogue)
    if args.output:
        args.output.write_text(json.dumps(reports, indent=2) + "\n", encoding="utf-8")
