"""Exact short-fiber balance clauses for the K=0 replay."""
from collections import Counter
from itertools import combinations, product

SLICES = (255, 85, 51, 17, 119, 1)

def make_fibers(orbits, physical, evaluate):
    orbit_of = {monomial: i for i, group in enumerate(orbits) for monomial in group}
    def mask_at(point):
        m = 0
        positions = [i for i in range(16) if point>>i&1]
        for comb in combinations(positions, 4):
            m ^= 1 << orbit_of[sum(1<<i for i in comb)]
        return m
    for u in range(256):
        forms = mask_at(u | (u<<8))
        if any((forms & v).bit_count()%2 for v in physical):
            raise ValueError("Balance theorem requires zero diagonal on the physical chart")
    return {z:Counter(evaluate(mask_at(u|((u^z)<<8))) for u in range(256)) for z in SLICES}

def balance_count(terms, model):
    return sum(w for m,w in terms.items() if (m & model).bit_count()%2)

def add_balance(terms, cnf, top):
    """Encode the weighted affine evaluations using a carry network."""
    columns = [[] for _ in range(10)]
    def var():
        nonlocal top
        top += 1
        return top
    for mask, weight in sorted(terms.items()):
        if not mask:
            continue
        inputs=[i+1 for i in range(mask.bit_length()) if mask>>i&1]
        def xor(inputs, output):
            for values in product((False, True), repeat=len(inputs)):
                polarity=[-a if bit else a for a,bit in zip(inputs,values)]
                cnf.append(polarity + [output if sum(values)%2 else -output])
        while len(inputs)>1:
            output=var()
            xor(inputs[:2],output)
            inputs=[output]+inputs[2:]
        for j in range(weight.bit_length()):
            if weight>>j&1:
                columns[j].append(inputs[0])
    for j, bucket in enumerate(columns):
        while len(bucket)>1:
            arity=min(3,len(bucket))
            ins=[bucket.pop() for _ in range(arity)]
            s,c=var(),var()
            for values in product((False,True),repeat=arity):
                polarity=[-a if bit else a for a,bit in zip(ins,values)]
                ones=sum(values)
                cnf.append(polarity+[s if ones%2 else -s])
                cnf.append(polarity+[c if ones>=2 else -c])
            bucket.append(s)
            columns[j+1].append(c)
        target=128>>j&1
        if not bucket:
            if target:
                cnf.append([])
        else:
            cnf.append([bucket[0] if target else -bucket[0]])
    return top
