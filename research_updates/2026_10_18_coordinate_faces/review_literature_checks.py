from pathlib import Path
import hashlib
import itertools
import json
import time
import argparse

def orbits(n, degree):
    seen = set()
    result = []
    for mon in itertools.combinations(range(n), degree):
        if mon in seen:
            continue
        orbit = sorted({tuple(sorted((i+s) % n for i in mon)) for s in range(n)})
        seen.update(orbit)
        result.append(orbit)
    return result

def truth_bits(orbit, inputs):
    masks = [sum(1 << i for i in mon) for mon in orbit]
    data = bytearray((len(inputs)+7)//8)
    for j, x in enumerate(inputs):
        value = sum((x & mask) == mask for mask in masks) % 2
        data[j//8] |= value << (j % 8)
    return int.from_bytes(data, 'little')

started = time.monotonic()
n = 16
mask = (1 << n)-1
reps = []
for x in range(1 << n):
    if ((x << 8) | (x >> 8)) & mask == x:
        continue
    if x == min(((x << s) | (x >> (n-s))) & mask for s in range(n)):
        reps.append(x)
generators = orbits(n, 3) + [o for o in orbits(n, 2) if len(o) == n] + [[(i,) for i in range(n)]]
assert len(reps) == 4080 and len(generators) == 43
bits = [truth_bits(o, reps) for o in generators]
counts, failures = [], []
for order in range(1, 5):
    count = fail = 0
    divisor = 1 << (5-order)
    for indices in itertools.combinations(range(len(bits)), order):
        intersection = bits[indices[0]]
        for i in indices[1:]:
            intersection &= bits[i]
        count += 1
        fail += intersection.bit_count() % divisor != 0
    counts.append(count)
    failures.append(fail)
assert failures == [0]*4
# Explicitly verify vanishing on the omitted fixed subspace.
fixed = [z | (z << 8) for z in range(256)]
assert all(truth_bits(o, fixed) == 0 for o in generators)

states = list(itertools.product(range(2), repeat=2))
matrix = [[(-1)**(a*b*c) if b == bb else 0 for bb,c in states] for a,b in states]
power = [[int(i == j) for j in range(4)] for i in range(4)]
for _ in range(32):
    power = [[sum(power[i][k]*matrix[k][j] for k in range(4)) for j in range(4)] for i in range(4)]
walsh = sum(power[i][i] for i in range(4))
assert walsh == 85032960

# Does the cubic t=16 divisibility argument directly carry over to quartic n=12?
quartic_orbits = orbits(12, 4)
quartic_bits = [truth_bits(o, list(range(4096))) for o in quartic_orbits]
obstruction = None
for order in range(1, 7):
    divisor = 1 << (7-order)
    for indices in itertools.combinations(range(len(quartic_bits)), order):
        intersection = quartic_bits[indices[0]]
        for i in indices[1:]:
            intersection &= quartic_bits[i]
        weight = intersection.bit_count()
        if weight % divisor:
            obstruction = {'order': order, 'required_divisor_for_64_divisibility': divisor, 'intersection_weight': weight, 'generators': [quartic_orbits[i] for i in indices]}
            break
    if obstruction:
        break
assert obstruction is not None
# Turn the failed Ward condition into an explicit member of the quartic span.
selected_bits = [truth_bits(o, list(range(4096))) for o in obstruction['generators']]
for subset in range(1, 1 << len(selected_bits)):
    table = 0
    for i, bitset in enumerate(selected_bits):
        if subset >> i & 1:
            table ^= bitset
    if table.bit_count() % 64:
        obstruction['explicit_quartic_span_member'] = {'selected_generators': [obstruction['generators'][i] for i in range(len(selected_bits)) if subset >> i & 1], 'weight': table.bit_count(), 'walsh_at_zero': 4096-2*table.bit_count()}
        break
assert 'explicit_quartic_span_member' in obstruction

def fwht(values):
    values = list(values)
    h = 1
    while h < len(values):
        for base in range(0, len(values), 2*h):
            for j in range(base, base+h):
                a, b = values[j], values[j+h]
                values[j], values[j+h] = a+b, a-b
        h *= 2
    return values

q_values = [sum(((x >> i) & 1)*((x >> (i+6)) & 1) for i in range(6)) % 2 for x in range(4096)]
assert set(map(abs, fwht([1-2*v for v in q_values]))) == {64}
assert all(q_values[z | (z << 6)] == z.bit_count() % 2 for z in range(64))
h_values = [sum(all((x >> ((i+j)%12)) & 1 for j in range(4)) for i in range(12)) % 2 for x in range(4096)]
assert sum(h_values) == 936
assert sum(1-2*v for v in h_values) == 2224

parser = argparse.ArgumentParser(description='Finite checks for the literature review; no global theorem.')
parser.add_argument('--out', type=Path, default=Path('outputs/literature_review'))
output = parser.parse_args().out
output.mkdir(parents=True, exist_ok=True)
report = {'scope': 'Independent finite arithmetic checks only; no proof of odd-order reduction or global quartic theorem.', 'ward_t16': {'representatives': len(reps), 'generators': len(generators), 'counts_by_order': counts, 'failures_by_order': failures, 'vanishing_on_V8_checked': True}, 'transfer_t32': {'walsh_at_zero': walsh, 'weight': ((1<<32)-walsh)//2, 'weight_div32_mod2048': (((1<<32)-walsh)//2//32)%2048}, 'quartic_n12_direct_ward64_failure': obstruction, 'seconds': time.monotonic()-started, 'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
report['quadratic_rotation_symmetric_bent_counterexample'] = {'formula': 'q(x)=XOR_{i=0}^5 x_i*x_{i+6}', 'walsh_absolute_values': [64], 'restriction_to_V6': 'sum(z_i), degree 1', 'full_FWHT_checked': True}
report['quartic_weight_independent_direct_evaluation'] = {'formula': 'h(x)=XOR_{i=0}^{11} x_i*x_{i+1}*x_{i+2}*x_{i+3}, indices mod12', 'weight': sum(h_values), 'walsh_at_zero': sum(1-2*v for v in h_values)}
(output/'FINITE_LITERATURE_CHECKS.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
print(json.dumps(report))
