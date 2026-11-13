"""Recount the published positive dimension-four maps using quadratic forms."""
import argparse
import json
from collections import Counter
from pathlib import Path

from count_near_antipodal import image_and_kernel
from higher_filter import solve, xor_terms
from line_phase_algebra import locate, quadratic_moments, reduce_phase
from lower_dim_model import build
from lower_dim_moments import conditions, phase_linear_system
from lower_dim_phase_prepare import fibre_masks
from lower_dim_v3_symbolic import affine_at, count, gauss_sum, substitute


def profile(space, records):
    model = build(((7,14,28,56),(5,10,20,40))[space-1])
    maps, lifts = map(list, zip(*model.maps))
    image = sorted(image_and_kernel(maps)[0], reverse=True)
    groups = Counter()
    for row in records:
        labels = [int(ch, 16) for ch in row["rotulos"]]
        mapping = sum((label >> i & 1) << (256*i+x)
                      for x,label in enumerate(labels) for i in range(4))
        code = locate(image, mapping)
        root = xor_terms(lifts, code)
        fibres = fibre_masks(mapping, 256, 4)
        moments = conditions(fibres, 8, 2)
        origin, basis, _ = phase_linear_system(moments, root, model.phases)
        assert origin is not None and len(basis) == row["dim_linear"]
        root ^= xor_terms(model.phases, origin)
        phases = [xor_terms(model.phases, v) for v in basis]
        equations = quadratic_moments(root, phases, moments)
        result = reduce_phase(root, phases, 0, [0]*len(phases), equations, 0)
        assert result is not None
        _, ds, _, _, qs = result
        total, _, _, sums = count(len(ds), qs, Counter())
        assert total == row["fases"]
        if space == 1:
            assert len(qs) == 1 and gauss_sum(len(ds), qs[0])[1] == 2
        elif qs:
            assert len(qs) == 2
            forcing, = [q for q in [*qs, qs[0] ^ qs[1]]
                        if gauss_sum(len(ds), q)[0] == -(1 << (len(ds) - 1))]
            gradients = [sum(mask ^ (1 << i) for mask in forcing
                             if mask.bit_count() == 2 and mask >> i & 1) for i in range(len(ds))]
            a, b = [v for v, _ in image_and_kernel(gradients)[0]]
            roots = []
            for c in range(4):
                o,fs,_ = solve([(a,c&1),(b,c>>1)],len(ds))
                vs = [affine_at(i,o,fs) for i in range(len(ds))]
                if not substitute([forcing],vs):
                    roots.append(vs)
            variables, = roots
            linear, = substitute([next(q for q in qs if q != forcing)],variables)
            assert any(linear - {0}) and all(m.bit_count() <= 1 for m in linear)
            assert total == 1 << (len(ds)-3)
        groups[len(phases),len(ds),len(qs),total,tuple(sorted((s["sum"],s["rank"]) for s in sums))]+=1
    print(space, len(records),sum(row["fases"] for row in records),flush=True)
    for k,n in sorted(groups.items()): print(n,k,flush=True)
    expected = (120, 1900544) if space == 1 else (768, 2326528)
    assert (len(records), sum(row["fases"] for row in records)) == expected


if __name__=="__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("folder", type=Path)
    folder = parser.parse_args().folder
    for space in (1,2):
        records = json.loads((folder / f"V{space}_exclusivo_mapas.json").read_bytes())
        profile(space,records)
