"""Extract the representative quartics outside the antipodal family."""
import argparse
import csv
import struct
import zlib
from collections import Counter
from pathlib import Path

from antipodal_mm import affine_deviation, xor_table
from higher_filter import evaluate_orbit, xor_terms
from higher_project import LOW, TOP


def main():
    p = argparse.ArgumentParser()
    p.add_argument('catalog', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    lower = [affine_deviation(evaluate_orbit(o)) for _, o in LOW]
    quartic = [affine_deviation(evaluate_orbit(o)) for _, o in TOP]
    left, right = xor_table(lower[:12]), xor_table(lower[12:])
    counts = Counter()
    with (a.catalog / 'catalog-index.tsv').open(newline='') as index, (
            a.catalog / 'catalog.bin').open('rb') as data, a.output.open('w') as out:
        for row in csv.DictReader(index, delimiter='\t'):
            top, size, n, offset, width = [int(row[k]) for k in
                                          ('top', 'orbit_size', 'count', 'offset', 'length')]
            if not top or not n:
                continue
            data.seek(offset)
            lower = struct.unpack(f'<{n}I', zlib.decompress(data.read(width)))
            high = xor_terms(quartic, top)
            outside = [v for v in lower if left[v & 4095] ^ right[v >> 12] != high]
            if outside:
                for v in outside:
                    out.write(f'{top}\t{v}\t{size}\n')
                counts['outside'] += len(outside)
                counts['weighted'] += 4 * size * len(outside)
                counts['tops'] += 1
                counts['mixed_tops'] += len(outside) < n
    assert counts['weighted'] == 19216384 and counts['outside'] == 118520
    print(dict(counts))


if __name__ == '__main__':
    main()
