"""Verify the archived residual-cell certificates, without searching for them."""
import argparse
from collections import Counter
from itertools import combinations
import json
from pathlib import Path
import re

from short_certs import MASK, PC, cells_of

def mapping_of(basis, code):
    value = 0
    while code:
        bit = code & -code
        value ^= basis[bit.bit_length() - 1]
        code ^= bit
    return value

CLASSES = (22, 23, 36, 37, 50, 51, 164, 165, 178, 179)


def verify(model, chart, records):
    coordinates = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    forms = Counter()
    for index, ((code, directions, metadata), row) in enumerate(
        zip(cells_of(model, chart), records, strict=True)
    ):
        expected = dict(class_=chart, cell_index=index, cell_base_code=code,
                        cell_dim=len(directions), **metadata)
        expected["class"] = expected.pop("class_")
        if any(row.get(key) != value for key, value in expected.items()):
            raise ValueError(f"Cell metadata mismatch: {chart}, {index}")
        terms = row["certificate"]
        if not 1 <= len(terms) <= 2:
            raise ValueError(f"Invalid certificate length: {chart}, {index}")
        tests = []
        for kind, label, arg in terms:
            t = int(label)
            if not 0 <= t < 16:
                raise ValueError(f"Invalid label: {t}")
            if kind == "M" and re.fullmatch(r"1|x[0-7](?:x[0-7])?", arg):
                mask = MASK
                for coordinate in re.findall(r"x([0-7])", arg):
                    mask &= coordinates[int(coordinate)]
                tests.append((t, mask, None))
            elif kind == "B" and arg in {"1", "2", "3", "4"}:
                tests.append((t, MASK, int(arg)))
            else:
                raise ValueError(f"Invalid equation: {kind}, {arg}")
        base = mapping_of(model.basis, code)
        delta = [mapping_of(model.basis, d) for d in directions]
        n = len(delta)
        if any(bit is not None for _, _, bit in tests):
            # Traverse the whole cell by Gray code for cardinality bits.
            def mappings():
                mapping = base
                for i in range(1 << n):
                    if i:
                        mapping ^= delta[(i & -i).bit_length() - 1]
                    yield mapping
        else:
            # Each indicator is a product of four affine coordinate tests.
            def mappings():
                for weight in range(min(4, n) + 1):
                    for subset in combinations(delta, weight):
                        mapping = base
                        for direction in subset:
                            mapping ^= direction
                        yield mapping
        for mapping in mappings():
            total = 0
            for label, mask, bit in tests:
                for i in range(4):
                    column = (mapping >> (256 * i)) & MASK
                    mask &= column if label >> i & 1 else MASK ^ column
                weight = mask.bit_count()
                total ^= (weight & 1) if bit is None else (((weight ^ 16) >> bit) & 1)
            if total != 1:
                raise ValueError(f"Certificate failed: {chart}, {index}")
        forms[tuple(tuple(term) for term in terms)] += 1
    return forms


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("repo", type=Path)
    parser.add_argument("--class", dest="chart", type=int, choices=CLASSES)
    args = parser.parse_args()
    model = PC.Model(str(args.repo.resolve()))
    root = Path(__file__).with_name("short-certificates")
    forms = Counter()
    for chart in (args.chart,) if args.chart is not None else CLASSES:
        records = json.loads((root / f"short-{chart}.json").read_text(encoding="utf-8"))
        found = verify(model, chart, records)
        forms.update(found)
        print(chart, sum(found.values()), len(found), flush=True)
    print("forms:", sorted(forms.items()), flush=True)


if __name__ == "__main__":
    main()

