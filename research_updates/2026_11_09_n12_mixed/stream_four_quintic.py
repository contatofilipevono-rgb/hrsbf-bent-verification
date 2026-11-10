"""Audit large four-orbit catalogs in bounded-memory blocks."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path
from zipfile import Path as ZipPath, ZipFile

import numpy as np

from antipodal_mm import affine_deviation
from higher_filter import evaluate_orbit, xor_terms
from higher_project import LOW, TOP, UPPER
from summarize_two import audit


class DiagonalTest:
    def __init__(self):
        self.vectors = [affine_deviation(evaluate_orbit(o)) for _, o in LOW + TOP + UPPER[:66]]
        pivots = {}
        for value in self.vectors:
            while value:
                j = value.bit_length() - 1
                if j not in pivots:
                    pivots[j] = value
                    break
                value ^= pivots[j]
        self.positions = sorted(pivots)
        self.words = (len(pivots) + 63) // 64
        codes = [self.project(v) for v in self.vectors]
        self.upper = codes[len(LOW) + len(TOP):]
        self.parts = []
        for column, widths, offset in ((1, (14, 14, 15), len(LOW)), (2, (12, 13), 0)):
            shift = 0
            for bits in widths:
                table = [0]
                for code in codes[offset + shift:offset + shift + bits]:
                    table += [v ^ code for v in table]
                assert len(table) == 1 << bits
                mask = (1 << 64) - 1
                packed = np.array([[(v >> (64 * w)) & mask for w in range(self.words)]
                                   for v in table], dtype=np.uint64)
                self.parts.append((column, shift, (1 << bits) - 1, packed))
                shift += bits

    def project(self, vector):
        return sum(((vector >> pos) & 1) << j for j, pos in enumerate(self.positions))

    def outside(self, high, records):
        offset = xor_terms(self.upper, high)
        mask = (1 << 64) - 1
        expected = [(offset >> (64 * w)) & mask for w in range(self.words)]
        value = np.tile(np.asarray(expected, dtype=np.uint64), (len(records), 1))
        for column, shift, bitmask, table in self.parts:
            value ^= table[(records[:, column] >> shift) & bitmask]
        return np.any(value != 0, axis=1)


def process(root, projection, test, outside_file):
    records = []
    sample = defaultdict(set)
    positive = defaultdict(Counter)
    for folder in sorted((p for p in root.iterdir() if p.is_dir()), key=lambda p: p.name):
        report = json.loads((folder / 'report.json').read_text())
        i, part, bits = report['index'], report['shard'], report['shard_bits']
        chart = projection[i]
        high = chart['mask']
        assert not chart['contradiction'] and high == report['high_mask']
        assert chart.get('period4_branch') == report.get('period4_branch')
        assert bits == max(0, min(4, chart['quartic_free'] - 24)) and 0 <= part < 1 << bits
        assert report['quartic_trials'] == 1 << (chart['quartic_free'] - bits)
        _, lower, hits = map(int, (folder / 'totals.tsv').read_text().split())
        assert (lower, hits) == (report['lower_trials'], report['normalized_bent'])
        outside = 0
        read = 0
        with (folder / 'bent.tsv').open('rb') as stream:
            while block := stream.readlines(1 << 19):
                table = np.fromstring(b''.join(block), sep=' ', dtype=np.int64)
                assert len(table) == 3 * len(block)
                table = table.reshape(-1, 3)
                assert np.all(table[:, 0] == i)
                deviation = test.outside(high, table)
                for top, low in table[deviation, 1:]:
                    outside_file.write(f'{high}\t{top}\t{low}\n')
                outside += int(np.count_nonzero(deviation))
                if read == 0:
                    sample[high].add((int(table[0, 1]), int(table[0, 2])))
                read += len(table)
        assert read == hits
        positive[high]['normalized'] += hits
        positive[high]['outside_diagonal'] += outside
        records.append([i, part, bits, report['quartic_trials'], lower, hits, outside])
    for high, t, l, _, outside in audit(sample):
        example = np.array([[0, t, l]], dtype=np.int64)
        assert outside == test.outside(high, example)[0]
    return {'records': records, 'positive': {h: c for h, c in positive.items() if c['normalized']},
            'independently_checked_samples': sum(map(len, sample.values()))}


def main():
    p = argparse.ArgumentParser()
    p.add_argument('projection', type=Path)
    p.add_argument('source', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    projection = json.loads(a.projection.read_text())['classes']
    test = DiagonalTest()
    with a.output.with_suffix('.tsv').open('w') as outside:
        if a.source.is_dir():
            report = process(a.source, projection, test, outside)
        else:
            with ZipFile(a.source) as archive:
                report = process(ZipPath(archive), projection, test, outside)
    a.output.write_text(json.dumps(report, separators=(',', ':')) + '\n')
    print(a.source.name, 'shards', len(report['records']),
          'positive records', sum(c['normalized'] for c in report['positive'].values()),
          'outside diagonal', sum(c['outside_diagonal'] for c in report['positive'].values()), flush=True)


if __name__ == '__main__':
    main()
