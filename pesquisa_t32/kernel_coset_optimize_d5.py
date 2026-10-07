#!/usr/bin/env python3
"""Optimize exactly the 7-bit diagonal-kernel coset of a quintic HRSBF.

For n=16 and degree 5, the kernel of f -> D_(e0,e0)f is
    k(u,v)=h(u+v)
with h in the 7-dimensional quintic HRSBF space on 8 variables.

Adding k changes a general derivative block for direction (a,b) by the
constant D_(a+b)h(z) on the fiber indexed by z. For each direction class,
the 128 possible kernel choices are therefore the length-128 Walsh transform
of 128 aggregated block autocorrelations.

This script evaluates all 128 variants simultaneously and exactly, choosing
variants by full nonzero autocorrelation energy and by the number of exactly
balanced derivative classes.
"""
import argparse
import itertools
import json
from pathlib import Path

import full_derivative_compressed_d5 as full
import diagonal_kernel_d5 as kernel


def fwht(values):
    output=list(values)
    step=1
    while step<len(output):
        for start in range(0,len(output),2*step):
            for offset in range(step):
                left=output[start+offset]
                right=output[start+offset+step]
                output[start+offset]=left+right
                output[start+offset+step]=left-right
        step*=2
    return output


def h_basis_truths():
    result=[]
    for _,orbit in kernel.cyclic_orbits(8,5):
        truth=0
        for z in range(256):
            value=0
            for support in orbit:
                value^=int(all((z>>i)&1 for i in support))
            if value:
                truth|=1<<z
        result.append(truth)
    assert len(result)==7
    return result


def kernel_masks():
    report=kernel.generate()
    masks=[
        int(row["coefficient_mask_273"],16)
        for row in report["kernel_basis"]
    ]
    assert len(masks)==7
    return masks


def combine_mask(choice,masks):
    result=0
    for i,mask in enumerate(masks):
        if (choice>>i)&1:
            result^=mask
    return result


def optimize(coefficient_mask):
    _,representatives,basis=full.build_representative_basis()
    representative_profiles=full.representative_profiles(
        coefficient_mask,basis
    )
    fibers=full.reconstruct_all_fibers(
        representatives,representative_profiles
    )

    h_basis=h_basis_truths()
    masks=kernel_masks()

    derivative_signatures=[
        [
            sum(
                ((((h>>z)&1)^((h>>(z^q))&1))<<i)
                for i,h in enumerate(h_basis)
            )
            for z in range(256)
        ]
        for q in range(256)
    ]

    translations=[
        [full.translate_truth(truth,p) for p in range(256)]
        for truth in fibers
    ]

    energies=[0]*128
    balanced_classes=[0]*128
    balanced_directions=[0]*128

    direction_representatives=sorted({
        full.canonical_rotation(direction,16)
        for direction in range(1,1<<16)
    })
    assert len(direction_representatives)==4115

    for direction in direction_representatives:
        a=direction&0xFF
        b=(direction>>8)&0xFF
        p=a
        q=a^b
        multiplicity=full.rotation_period(direction,16)

        grouped=[0]*128
        signatures=derivative_signatures[q]
        for z in range(256):
            block_weight=(
                fibers[z]^translations[z^q][p]
            ).bit_count()
            block_autocorrelation=256-2*block_weight
            grouped[signatures[z]]+=block_autocorrelation

        autocorrelations=fwht(grouped)
        for choice,value in enumerate(autocorrelations):
            energies[choice]+=multiplicity*value*value
            if value==0:
                balanced_classes[choice]+=1
                balanced_directions[choice]+=multiplicity

    fiber_weights=[truth.bit_count() for truth in fibers]
    global_weights=[]
    for choice in range(128):
        h_truth=0
        for i,truth in enumerate(h_basis):
            if (choice>>i)&1:
                h_truth^=truth
        weight=sum(
            256-fiber_weights[z] if ((h_truth>>z)&1)
            else fiber_weights[z]
            for z in range(256)
        )
        global_weights.append(weight)

    bad_fibers=sum(
        fiber_weights[z]!=128 for z in range(1,256)
    )
    bad_fiber_classes=sum(
        fibers[z].bit_count()!=128 for z in representatives
    )

    best_energy=min(
        range(128),
        key=lambda choice:(energies[choice],-balanced_classes[choice])
    )
    best_balanced=max(
        range(128),
        key=lambda choice:(balanced_classes[choice],-energies[choice])
    )

    target_choices=[
        choice for choice,weight in enumerate(global_weights)
        if weight==32640
    ]
    best_target=None
    if target_choices:
        best_target=min(
            target_choices,
            key=lambda choice:(energies[choice],-balanced_classes[choice])
        )

    def record(choice):
        kernel_mask=combine_mask(choice,masks)
        return {
            "kernel_choice":choice,
            "kernel_choice_binary":format(choice,"07b"),
            "kernel_mask_273":hex(kernel_mask),
            "resulting_coefficient_mask":hex(coefficient_mask^kernel_mask),
            "global_weight":global_weights[choice],
            "autocorrelation_energy_nonzero":energies[choice],
            "balanced_derivative_rotation_classes":balanced_classes[choice],
            "balanced_nonzero_directions":balanced_directions[choice],
        }

    report={
        "date_utc":"2026-10-06",
        "n":16,
        "degree":5,
        "base_coefficient_mask":hex(coefficient_mask),
        "kernel_dimension":7,
        "variants_evaluated":128,
        "bad_nonzero_fibers_invariant":bad_fibers,
        "bad_fiber_rotation_classes_invariant":bad_fiber_classes,
        "global_weight_range":[min(global_weights),max(global_weights)],
        "target_weight_32640_variant_count":len(target_choices),
        "original_variant":record(0),
        "best_energy_variant":record(best_energy),
        "max_balanced_classes_variant":record(best_balanced),
        "best_target_weight_variant":(
            None if best_target is None else record(best_target)
        ),
        "all_variant_summary":[
            {
                "choice":choice,
                "weight":global_weights[choice],
                "energy":energies[choice],
                "balanced_classes":balanced_classes[choice],
                "balanced_directions":balanced_directions[choice],
            }
            for choice in range(128)
        ],
        "status":"PASS",
        "interpretation":(
            "Optimization is exhaustive only over the exact 7-dimensional "
            "kernel coset of the supplied 266-dimensional quotient point."
        ),
    }
    return report


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--mask",required=True)
    parser.add_argument("--output",default="kernel_coset_optimization_d5.json")
    args=parser.parse_args()
    report=optimize(int(args.mask,0))
    Path(args.output).write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps({
        "variants_evaluated":report["variants_evaluated"],
        "bad_nonzero_fibers_invariant":report["bad_nonzero_fibers_invariant"],
        "global_weight_range":report["global_weight_range"],
        "target_weight_32640_variant_count":
            report["target_weight_32640_variant_count"],
        "original_variant":report["original_variant"],
        "best_energy_variant":report["best_energy_variant"],
        "max_balanced_classes_variant":
            report["max_balanced_classes_variant"],
    },indent=2))


if __name__=="__main__":
    main()
