"""Recount phases on the dimension-four support lists."""
import argparse
import json
from collections import Counter
from pathlib import Path

from count_near_antipodal import image_and_kernel
from dim4_support_decode import decode
from higher_filter import xor_terms
from line_phase_algebra import locate, quadratic_moments, reduce_phase
from lower_dim_moments import conditions, phase_linear_system
from lower_dim_phase_prepare import fibre_masks
from lower_dim_v3_symbolic import count


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("folder",type=Path)
    parser.add_argument("--space",type=int,choices=(1,2),required=True)
    parser.add_argument("--shard",type=int,default=0)
    parser.add_argument("--shards",type=int,default=1)
    parser.add_argument("--output",type=Path,required=True)
    parser.add_argument("--expected", type=Path, help="Previous verification report with positive map counts")
    args=parser.parse_args()
    space=args.space
    model,basis,labels=decode(space)
    map_basis,lifts=map(list,zip(*model.maps))
    image=sorted(image_and_kernel(map_basis)[0],reverse=True)
    if args.expected:
        reference = json.loads(args.expected.read_bytes())
        known = {int(code): count for code, count in reference["positive"].items()}
    else:
        records = json.loads((args.folder / f"V{space}_exclusivo_mapas.json").read_bytes())
        known = {row["codigo"]: row["fases"] for row in records}
        for row in records:
            decoded = labels(xor_terms(basis, row["codigo"]))
            assert "".join(f"{label:x}" for label in decoded) == row["rotulos"]
    counts=Counter()
    positive={}
    nonlinear=Counter()
    charts={}
    parity_profiles = Counter()
    s_coordinates = [sum(1 << x for x in range(256) if x >> i & 1) for i in (6, 7)]
    for index,line in enumerate((args.folder/f"mapas_V{space}.txt").read_text().splitlines()):
        if index%args.shards!=args.shard:continue
        code=int(line)
        chart=charts.setdefault(code>>(len(basis)-8), Counter())
        chart["supports"]+=1
        mapping=xor_terms(basis,code)
        parts=[mapping>>(256*i)&((1<<256)-1) for i in range(4)]
        mask=(1<<64)-1
        q=[tuple(((p>>(64*k))^p)&mask for p in parts) for k in (1,2)]
        if space==2 and q[0]==q[1]:
            counts["larger_by_map"]+=1
            chart["larger_by_map"]+=1
            continue
        maybe_larger = space == 1 and all(len(set(row)) == 1 for row in q)
        rep=locate(image,mapping)
        h=xor_terms(lifts,rep)
        f=fibre_masks(mapping,256,4)
        moments=conditions(f,8,2)
        assert moments is not None
        origin,kernel,_=phase_linear_system(moments,h,model.phases)
        short_moments = [
            (subset, 1, residue)
            for fibre in f
            for subset, residue in [(fibre, 0), *(
                (fibre & coordinate, (fibre & coordinate).bit_count() // 2 & 1)
                for coordinate in s_coordinates
            )]
        ]
        short_origin, _, _ = phase_linear_system(short_moments, h, model.phases)
        parity_profiles[(origin is not None, short_origin is not None)] += 1
        assert (origin is None) == (short_origin is None), code
        if origin is None:
            counts["linear_inconsistent"]+=1
            chart["linear_inconsistent"]+=1
            continue
        h^=xor_terms(model.phases,origin)
        ds=[xor_terms(model.phases,v) for v in kernel]
        qs=quadratic_moments(h,ds,moments)
        r=reduce_phase(h,ds,0,[0]*len(ds),qs,0)
        if r is None:
            counts["mod4_inconsistent"]+=1
            chart["mod4_inconsistent"]+=1
            continue
        h,free,_,_,qs=r
        nonlinear[len(qs)]+=1
        if len(qs)>8:
            r=reduce_phase(h,free,0,[0]*len(free),qs,3)
            if r is None:
                counts["mod4_inconsistent"]+=1
                chart["mod4_inconsistent"]+=1
                continue
            h,free,_,_,qs=r
        assert len(qs)<=10,(code,len(free),len(qs),maybe_larger)
        total,_,_,_=count(len(free),qs,Counter())
        if total and maybe_larger:
            def mixed_phase(phase):
                return (phase ^ phase >> 64 ^ phase >> 128 ^ phase >> 192) & mask
            offset = mixed_phase(h) ^ q[0][0] ^ q[1][0]
            deltas = [mixed_phase(d) for d in free]
            assert not offset and not any(deltas), (code, len(free), len(qs))
            counts["all_phases_in_larger"] += 1
            counts["functions_in_larger"] += total
            chart["all_phases_in_larger"] += 1
            chart["functions_in_larger"] += total
            continue
        if total:
            assert known[code]==total
            positive[code]=total
            counts["positive"]+=1
            chart["positive"]+=1
            chart["exclusive_functions"]+=total
        else:
            counts["quadratic_inconsistent"]+=1
            chart["quadratic_inconsistent"]+=1
    print(space,args.shard,dict(counts),dict(nonlinear),flush=True)
    if args.shards == 1:
        assert positive == known
        assert sum(counts.values()) - counts["functions_in_larger"] == (113040 if space == 1 else 166472)
        assert sum(positive.values()) == (1900544 if space == 1 else 2326528)
    parity = [[full, short, n] for (full, short), n in sorted(parity_profiles.items())]
    args.output.write_text(json.dumps({"counts":counts,"quadratic_ranks":nonlinear,"positive":positive,"charts":charts,"parity_profiles":parity})+"\n")


if __name__=="__main__":
    main()
