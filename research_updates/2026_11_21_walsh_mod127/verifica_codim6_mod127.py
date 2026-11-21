"""Checks the modulo-127 codimension-six addendum with integer arithmetic."""
from collections import Counter


def walsh(values):
    spectrum = list(values)
    width = 1
    while width < len(spectrum):
        for start in range(0, len(spectrum), 2*width):
            for i in range(start, start+width):
                a, b = spectrum[i], spectrum[i+width]
                spectrum[i], spectrum[i+width] = a+b, a-b
        width *= 2
    return spectrum


def wedge(a, b):
    out = set()
    for left in a:
        for right in b:
            if not left & right:
                mask = left | right
                out.symmetric_difference_update({mask})
    return out


def centered(a):
    return (a+63) % 127-63


def example_cubic():
    masks = (0x7FD3776BDB1, 0x1E8C7A3FC609, 0x4B9E12111A6, 0xAF56EB74D04)
    pairs = [(1 << i) | (1 << j) for i in range(10) for j in range(i)]
    quadratics = [{pair for p, pair in enumerate(pairs) if mask >> p & 1}
                  for mask in masks]
    product = {0}
    values = []
    for q in quadratics:
        product = wedge(product,q)
        values.append(tuple(sum(z & m == m for m in q) & 1 for z in range(1024)))
    assert not product

    # Use the sign formula on each point before applying the integer transform.
    spectrum = walsh(
        (-1)**sum(values[i][x & 1023] for i in range(4) if x >> (10+i) & 1)
        for x in range(16384)
    )
    translated = [value*(-1)**((b & 0x3608).bit_count() & 1)
                  for b, value in enumerate(spectrum)]
    assert translated[0] == 1248 and {w % 128 for w in translated} == {96}
    assert all((w*6**r*(-2)**(4-r)) % 2048 == 1536
               for w in set(translated) for r in range(5))
    assert centered(1248*(-3)) == -61
    print("Cubic26: all 2-adic residues verified by tensor factors; modular witness = -61.")


def next_digit_minimum(j, residues):
    period2 = 1 << (j+1)
    bit_class = 1+(1 << j)
    period = 127*period2
    minima = []
    for residue in residues:
        offset = ((residue-bit_class)*pow(period2,-1,127)) % 127
        value = bit_class+offset*period2
        minima.append(min(value,period-value))
    return min(minima)


def verify_modular_exclusion():
    for table in range(256):
        if table.bit_count() & 1:
            coefficients = walsh((-1)**(table >> x & 1) for x in range(8))
            assert Counter(map(abs,coefficients)) == {2: 7, 6: 1}

    residues = list(range(-32,33))
    for power, expected in enumerate(((*range(-10,11),-32,32),tuple(range(-3,4))), 1):
        residues = [z for z in residues if abs(centered(3**power*z)) <= 32]
        assert set(residues) == set(expected)
    assert 115**2 > 2**20//128**2 == 64

    allowed_a = [(4*z) % 127 for z in (*range(-10,11),-32,32)]
    for j, degree, minimum in ((2,3,91),(3,5,87),(4,6,111)):
        assert max(d for d in range(24) if d+(23-d+2)//3 <= 8+j) == degree
        assert next_digit_minimum(j,allowed_a) == minimum
        assert minimum**2-1 > 127*(1 << degree)
    print("CRT: two blocks excluded; one block forces normalized Walsh ≡ 1 mod 32.")


def calibrate_dimension_15():
    quadratic14 = lambda x: sum((x >> (2*i) & 1)*(x >> (2*i+1) & 1)
                                for i in range(7)) & 1
    semi_bent = walsh((-1)**quadratic14(x) for x in range(32768))
    assert set(semi_bent) == {0,-256,256}
    assert sum(v != 0 for v in semi_bent) == 16384

    def quadratic12(y):
        products = sum((y >> (2*i) & 1)*(y >> (2*i+1) & 1) for i in range(6))
        return (products+(y >> 12 & 1)) & 1

    two_large = walsh((-1)**((x >> 14)*quadratic12(x & 16383))
                      for x in range(32768))
    counts = Counter(two_large)
    assert counts[16384] == 2 and counts[-256]+counts[256] == 8192
    assert set(counts) == {-256,0,256,16384}
    print("Dimension 15: isolated examples of zero and two large coefficients verified.")


if __name__ == "__main__":
    example_cubic()
    verify_modular_exclusion()
    calibrate_dimension_15()
