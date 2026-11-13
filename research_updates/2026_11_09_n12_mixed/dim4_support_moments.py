from collections import Counter
from itertools import combinations

from count_near_antipodal import all_points, image_and_kernel
from dim4_support_decode import decode
from higher_filter import solve, xor_terms
from lower_dim_model import active_indices
from lower_dim_v3_symbolic import affine_at, echelon, substitute
from dim4_balance_charts import character_sums
from line_column_autocorrelation import affine_consequences
from pathlib import Path
import json
import argparse
import struct


MASK = (1 << 256) - 1


def indicator_products(origin, directions, output_mask, domain_masks):
    """Sums of pi-coordinate products on specified domain monomials."""
    bits = list(active_indices(output_mask))
    rows = [set() for _ in domain_masks]
    forms = [
        [(1 << i, (p >> (256*j)) & MASK) for i, p in enumerate(directions)]
        + [(0, (origin >> (256*j)) & MASK)]
        for j in bits
    ]
    terms = {0: MASK}
    for form in forms:
        next_terms = {}
        for a, value in terms.items():
            for b, column in form:
                if common := value & column:
                    next_terms[a | b] = next_terms.get(a | b, 0) ^ common
        terms = next_terms
    for a, value in terms.items():
        if value:
            for row, mask in zip(rows, domain_masks):
                if (value & mask).bit_count() & 1:
                    row.add(a)
    return rows


def moment_equations(origin, directions, min_output_degree, max_output_degree):
    variables = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    domains = [MASK, *variables, *(a & b for a,b in combinations(variables,2))]
    return [
        equation
        for output in range(1,16)
        if min_output_degree <= output.bit_count() <= max_output_degree
        for equation in indicator_products(origin,directions,output,domains)
        if equation
    ]


def main():
    parser = argparse.ArgumentParser(description="Compile dimension-four map charts from necessary moments.")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    report = {}
    for space in (1,2):
        _,basis,labels=decode(space)
        n=len(basis)-8
        dirs=basis[:n]
        prefix=basis[n:]
        stats=Counter()
        charts=[]
        for chart in range(256):
            origin=xor_terms(prefix,chart)
            rows=echelon(moment_equations(origin,dirs,1,2))
            if 0 in rows:
                stats["empty"]+=1
                continue
            lin=[(sum(p-{0}),int(0 in p)) for mask,p in rows.items() if mask.bit_count()==1]
            root,free,_=solve(lin,n)
            if root is None:
                stats["empty"]+=1
                continue
            base=origin^xor_terms(dirs,root)
            directions=[xor_terms(dirs,x) for x in free]
            n3=moment_equations(base,directions,3,3)
            rest=substitute([p for m,p in rows.items() if m.bit_count()==2],
                            [affine_at(i,root,free) for i in range(n)])
            rows3=echelon(rest+n3)
            if 0 in rows3:
                stats["empty3"]+=1
                continue
            lin3=[(sum(p-{0}),int(0 in p)) for mask,p in rows3.items() if mask.bit_count()==1]
            root3,free3,_=solve(lin3,len(free))
            base^=xor_terms(directions,root3)
            directions=[xor_terms(directions,x) for x in free3]
            n4=moment_equations(base,directions,4,4)
            rest=substitute([p for m,p in rows3.items() if m.bit_count()>=2],
                            [affine_at(i,root3,free3) for i in range(len(free))])
            rows4=echelon(rest+n4)
            if 0 in rows4:
                stats["empty4"]+=1
                continue
            lin4=[(sum(p-{0}),int(0 in p)) for mask,p in rows4.items() if mask.bit_count()==1]
            root4,free4,_=solve(lin4,len(free3))
            base^=xor_terms(directions,root4)
            directions=[xor_terms(directions,x) for x in free4]
            origin_balance,free_balance,_=affine_consequences(list(character_sums(base,directions)),len(directions))
            if origin_balance is None:
                stats["empty_balance"]+=1
                continue
            stats[len(free_balance)]+=1
            code_root = root ^ xor_terms(free, root3 ^ xor_terms(free3, root4 ^ xor_terms(free4,origin_balance)))
            code_basis = [xor_terms(free,xor_terms(free3,xor_terms(free4,v))) for v in free_balance]
            charts.append(dict(chart=chart, root=code_root, basis=code_basis))
        print(space,stats,flush=True)
        with (args.output / f"charts-{space}.bin").open("wb") as target:
            target.write(struct.pack("<I", len(charts)))
            for row in charts:
                root_code = row["root"] | (row["chart"] << n)
                target.write(struct.pack("<IQ", len(row["basis"]), root_code))
                for i, code in enumerate([root_code, *row["basis"]]):
                    mapping = xor_terms(basis, code)
                    packed = sum(label << (4*x) for x, label in enumerate(labels(mapping)))
                    if i:
                        target.write(struct.pack("<Q", code))
                    target.write(packed.to_bytes(128, "little"))
        report[space] = {"statistics": dict(stats),"charts":charts}
    (args.output / "charts.json").write_text(json.dumps(report,indent=2)+"\n", encoding="utf-8")


if __name__=="__main__":
    main()
