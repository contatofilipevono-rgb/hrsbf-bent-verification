"""Independent pre-submission audit.

No imports or code copied from the existing HRSBF verifiers.
Requires Python >=3.10 and NumPy >=2.0 (bitwise_count).
All arithmetic relevant to acceptance is exact.
"""
from itertools import combinations, product
from pathlib import Path
from collections import Counter
import hashlib, json, math, platform, sys, time
import numpy as np

def need(ok, message):
    if not ok:
        raise RuntimeError(message)

def cubic_orbits(n):
    # Oriented cyclic gap necklaces; no enumeration/sorting of monomial triples.
    necklaces = set()
    for a in range(1, n):
        for b in range(1, n-a):
            c = n-a-b
            necklaces.add(min((a,b,c), (b,c,a), (c,a,b)))
    result = []
    for a,b,c in sorted(necklaces):
        orbit = frozenset(sum(1 << j for j in ((i % n), ((i+a)%n), ((i+a+b)%n)))
                          for i in range(n))
        need(len(orbit) == (n//3 if a == b == c else n), "Wrong gap orbit length")
        result.append(orbit)
    need(sum(map(len,result)) == math.comb(n,3), "Gap enumeration does not cover all triples")
    need(len(set(result)) == len(result), "Duplicate gap orbits")
    return result

def generators(n):
    cubes = cubic_orbits(n)
    quadratics = [frozenset((1<<i)|(1<<((i+d)%n)) for i in range(n))
                  for d in range(1,n//2)]
    linear = frozenset(1<<i for i in range(n))
    return cubes + quadratics + [linear]

def evaluate_scalar(poly, x):
    return sum((x & m) == m for m in poly) & 1

def packed_table(poly, n):
    x = np.arange(1<<n, dtype=np.uint32)
    truth = np.zeros(1<<n, dtype=np.uint8)
    for monomial in poly:
        truth ^= ((x & monomial) == monomial).astype(np.uint8)
    # Input coordinate x remains explicit. No rotation compression is used.
    packed = np.packbits(truth, bitorder="little")
    packed = np.pad(packed,(0,(-len(packed))%8))
    return np.frombuffer(packed.tobytes(),dtype="<u8").copy()

def weight(packed):
    return int(np.bitwise_count(packed).sum(dtype=np.uint64))

def rank_packed(vectors):
    pivots = {}
    for vec in vectors:
        row = vec.copy()
        while np.any(row):
            block = int(np.flatnonzero(row)[0])
            word = int(row[block])
            bit = (word & -word).bit_length()-1
            pivot = 64*block + bit
            if pivot in pivots:
                row ^= pivots[pivot]
            else:
                pivots[pivot] = row
                break
    return len(pivots)

def ward_full_tables():
    n = 16
    polys = generators(n)
    need(len(polys) == 43, "Expected 43 generators")
    vectors = [packed_table(p,n) for p in polys]
    need(rank_packed(vectors) == 43, "Truth-table rank not 43")
    # Compare vectorized tables against scalar ANF evaluation on every coordinate.
    xvals = range(1<<n)
    for i, (poly,vec) in enumerate(zip(polys,vectors)):
        bytes_ = vec.view(np.uint8)
        scalar = np.fromiter((evaluate_scalar(poly,x) for x in xvals),dtype=np.uint8)
        need(np.array_equal(scalar,np.unpackbits(bytes_,bitorder="little")), "Scalar/vector table disagreement")
        # All period <=8 inputs are forced to zero.
        for y in range(256):
            need(evaluate_scalar(poly,y|(y<<8)) == 0, "Antipodal vanishing failed")
    records = {}
    for k in range(1,5):
        divisor = 1 << (9-k) # full weights: 256,128,64,32
        hist = Counter()
        digest = hashlib.sha256()
        checked = 0
        for indices in combinations(range(43),k):
            intersection = vectors[indices[0]].copy()
            for j in indices[1:]:
                intersection &= vectors[j]
            wt = weight(intersection)
            need(wt % divisor == 0, f"Ward failure at order {k}: {indices}, {wt}")
            hist[wt] += 1
            checked += 1
            digest.update((str(indices)+":"+str(wt)+"\n").encode())
        need(checked == math.comb(43,k), "Incomplete intersections")
        records[str(k)] = {"tested":checked,"full_table_divisor":divisor,
                          "violations":0,"weight_histogram":dict(sorted(hist.items())),
                          "sha256_ordered_records":digest.hexdigest()}
        print(f"PASS independent full tables: order {k}, {checked} intersections",flush=True)
    need(sum(r["tested"] for r in records.values())==136697,"Wrong total")
    # Negative control: adding the omitted antipodal generator invalidates 256-divisibility.
    antipodal = frozenset((1<<i)|(1<<(i+8)) for i in range(8))
    anti_weight = weight(packed_table(antipodal,16))
    need(anti_weight==32640 and anti_weight%256==128, "Negative scope control failed")
    return {"generator_order":"oriented gap necklaces, then distances 1..7, then L",
            "rank":43,"input_count":65536,"scalar_vector_entries_checked":43*65536,
            "antipodal_entries_checked":43*256,"orders":records,
            "total_intersections":136697,"negative_control_antipodal_weight":anti_weight,
            "arithmetic":"NumPy packed uint64 AND and exact popcounts; no compressed orbits"}

def small_bases():
    records = {}
    for n in (2,4,8):
        vectors = [packed_table(p,n) for p in generators(n)]
        current = np.zeros_like(vectors[0])
        weights = Counter({weight(current):1})
        prev = 0
        for j in range(1,1<<len(vectors)):
            gray = j^(j>>1)
            bit = (gray^prev).bit_length()-1
            current ^= vectors[bit]
            wt = weight(current)
            need(abs((1<<n)-2*wt) != 1<<(n//2), "Bent W0 in small base")
            weights[wt] += 1
            prev = gray
        records[str(n)] = {"generators":len(vectors),"functions":sum(weights.values()),
                           "W0_values":sorted((1<<n)-2*w for w in weights)}
    return records

def rank_binary(columns):
    rows = {}
    for value in columns:
        while value:
            bit = value.bit_length()-1
            if bit in rows:
                value ^= rows[bit]
            else:
                rows[bit] = value
                break
    return len(rows)

def apply_linear(cols, x):
    output = 0
    for i,col in enumerate(cols):
        if x>>i & 1:
            output ^= col
    return output

def quadratic_tables(n):
    polys = [frozenset([0])] + [frozenset([1<<i]) for i in range(n)]
    polys += [frozenset([(1<<i)|(1<<j)]) for i,j in combinations(range(n),2)]
    truths = [sum(evaluate_scalar(p,x)<<x for x in range(1<<n)) for p in polys]
    data = [0]
    for truth in truths:
        data += [v^truth for v in data]
    need(len(set(data))==1<<len(polys),"Quadratic enumeration lost rank")
    return data

def exhaustive_odd_linear_quadratic():
    # Every invertible binary 4x4 matrix, not only coordinate permutations.
    n = 4
    allq = quadratic_tables(n)
    invertible = odd_maps = pairs = 0
    orders = Counter()
    cache = {}
    for cols in product(range(16),repeat=4):
        if rank_binary(cols)!=4:
            continue
        invertible += 1
        perm = [apply_linear(cols,x) for x in range(16)]
        seen = set()
        cycles = []
        order = 1
        for x in range(16):
            if x in seen:
                continue
            cycle = []
            y = x
            while y not in seen:
                seen.add(y)
                cycle.append(y)
                y = perm[y]
            order = math.lcm(order,len(cycle))
            cycles.append(tuple(cycle))
        if order%2==0:
            continue
        odd_maps += 1
        orders[order] += 1
        masks = tuple(sorted(sum(1<<x for x in cyc) for cyc in cycles))
        fixed = sum(1<<x for x in range(16) if perm[x]==x)
        if masks not in cache:
            invariant = [q for q in allq if all((q&m) in (0,m) for m in masks)]
            for q in invariant:
                balanced_all = q.bit_count()==8
                balanced_fixed = 2*(q&fixed).bit_count()==fixed.bit_count()
                need(balanced_all==balanced_fixed, "Odd-order quadratic lemma counterexample")
            cache[masks] = len(invariant)
        pairs += cache[masks]
    need(invertible==20160,"GL(4,2) enumeration incomplete")
    need(orders[1]==1,"Identity missing")
    # Degree hypothesis matters: a degree-3 invariant counterexample.
    # For n=3 and cyclic order3, q=xyz is unbalanced on V but balanced on Fix(T).
    qtruth = sum(((x&7)==7)<<x for x in range(8))
    fixedtruth = ((qtruth>>0)&1)+((qtruth>>7)&1)
    need(qtruth.bit_count()!=4 and fixedtruth==1,"Degree-3 negative control failed")
    return {"dimension":4,"all_quadratic_functions":len(allq),"invertible_maps":invertible,
            "odd_order_maps":odd_maps,"orders":dict(sorted(orders.items())),
            "invariant_map_function_pairs":pairs,"distinct_cycle_partitions":len(cache),
            "violations":0,"negative_degree3_control":"xyz under a 3-cycle disproves extension beyond quadratics"}

def folded_orbit_controls():
    records = []
    for t in (2,4,8,16):
        allowed = set(generators(t))
        allowed.add(frozenset())
        for odd_m in (1,3,5,7,9,11):
            n = t*odd_m
            counts = Counter()
            source = cubic_orbits(n)
            for orbit in source:
                folded = set()
                for mon in orbit:
                    reduced = 0
                    while mon:
                        bit = mon & -mon
                        reduced |= 1<<((bit.bit_length()-1)%t)
                        mon ^= bit
                    if reduced in folded:
                        folded.remove(reduced)
                    else:
                        folded.add(reduced)
                folded = frozenset(folded)
                need(folded in allowed,"Folded orbit outside permitted space")
                degree = max((mon.bit_count() for mon in folded),default=0)
                counts[degree] += 1
            records.append({"t":t,"odd_multiplier":odd_m,"source_dimension":n,
                            "source_cubic_orbits":len(source),"folded_degree_counts":dict(sorted(counts.items()))})
    return {"scope":"Exhaustive orbit images for each listed dimension; finite controls only.",
            "records":records,"total_source_orbits":sum(r["source_cubic_orbits"] for r in records)}

def main():
    started = time.perf_counter()
    report = {"status":"running","python":sys.version,"numpy":np.__version__,
              "platform":platform.platform(),"script_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              "implementation_independence":"No imports from existing verifiers; gap enumeration, full input tables and NumPy popcounts.",
              "stages":{}}
    try:
        for name,fn in (("small_bases",small_bases),("ward_n16",ward_full_tables),
                        ("odd_order_quadratic",exhaustive_odd_linear_quadratic),
                        ("folded_orbits",folded_orbit_controls)):
            start = time.perf_counter()
            print("START "+name,flush=True)
            value = fn()
            report["stages"][name] = {"seconds":round(time.perf_counter()-start,3),"data":value}
            print("PASS "+name,flush=True)
        report["status"]="passed"
    except Exception as error:
        report["status"]="failed"
        report["error"]=repr(error)
        raise
    finally:
        report["elapsed_seconds"]=round(time.perf_counter()-started,3)
        Path(__file__).with_suffix(".json").write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps({"status":report["status"],"seconds":report["elapsed_seconds"]}),flush=True)

if __name__=="__main__":
    main()

