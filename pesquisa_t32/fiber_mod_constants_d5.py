#!/usr/bin/env python3
"""Rank of quintic fiber maps modulo fiber complementation.

Balance of a nonzero fiber F_z is unchanged by adding the constant one.
For homogeneous quintic RSBFs in n=16, the seven-dimensional kernel
f(u,v)=h(u+v) acts on each fiber by precisely such a constant.

This script projects each 256-bit fiber truth table modulo constants,
computes the exact rank spectrum, and finds a deterministic greedy set of
fibers spanning the resulting 266-dimensional quotient.
"""
import collections
import json
import sys
from pathlib import Path

import fiber_rank_spectrum_d5 as base

ALL_ONES=(1<<256)-1


def normalize_mod_constants(truth):
    return truth^(ALL_ONES if (truth&1) else 0)


def generate():
    orbits=base.cyclic_orbits()
    assert len(orbits)==273

    profiles={}
    ranks={}
    for z in range(1,256):
        vectors=[
            normalize_mod_constants(base.fiber_profile(orbit,z))
            for _,orbit in orbits
        ]
        profiles[z]=vectors
        ranks[z]=base.gf2_rank(vectors)

    histogram=collections.Counter(ranks.values())
    expected={
        11:1,19:2,31:4,32:4,38:4,54:8,56:16,
        57:16,60:16,62:40,66:56,68:8,70:80,
    }
    assert dict(histogram)==expected

    representatives=sorted({
        base.canonical_rotation(z)
        for z in range(1,256)
    })
    assert len(representatives)==35

    selected=[]
    remaining=list(representatives)
    history=[]
    while remaining:
        best_rank=-1
        best_z=None
        for z in remaining:
            candidate=selected+[z]
            rank=base.joint_rank(profiles,candidate,len(orbits))
            if rank>best_rank:
                best_rank=rank
                best_z=z
        selected.append(best_z)
        remaining.remove(best_z)
        history.append(best_rank)
        if best_rank==266:
            break

    assert selected==[
        0x1F,0x37,0x2F,0x3B,0x3D,
        0x57,0x5B,0x07,0x0B,0x15,
    ]
    assert history==[70,125,154,182,210,236,251,256,261,266]

    return {
        "date_utc":"2026-10-06",
        "n":16,
        "degree":5,
        "coefficient_dimension":273,
        "quotient_by_fiber_constants_dimension":266,
        "common_kernel_dimension":7,
        "nonzero_fibers":255,
        "rank_histogram_mod_constants":{
            str(rank):count for rank,count in sorted(histogram.items())
        },
        "rotation_class_count":len(representatives),
        "greedy_quotient_determining_fibers":{
            "z_hex":[hex(z) for z in selected],
            "rank_history":history,
            "final_rank":history[-1],
            "determines_266_dimensional_quotient":history[-1]==266,
        },
        "status":"PASS",
        "interpretation":(
            "Fiber balance predicates factor through the 266-dimensional "
            "quotient because complementing an entire fiber preserves balance."
        ),
    }


if __name__=="__main__":
    if not __debug__:
        raise RuntimeError("Run without python -O; assertions are audit checks.")
    if len(sys.argv)!=2:
        raise SystemExit("usage: python3 fiber_mod_constants_d5.py OUTPUT.json")
    report=generate()
    Path(sys.argv[1]).write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps(report,indent=2))
