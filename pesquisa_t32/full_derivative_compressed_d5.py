#!/usr/bin/env python3
"""Compressed full derivative audit for quintic HRSBFs in n=16.

Starting from only one representative of each of the 35 nonzero fiber
rotation classes, reconstruct all 256 fibers F_z(u)=f(u,u+z) and evaluate
one representative of every cyclic rotation class of nonzero directions in
F_2^16.

For an original direction (a,b), the coordinates (u,z) with
x=(u,u+z) change by
    (u,z) -> (u+a, z+a+b).
Hence
    wt(D_(a,b) f)
      = sum_z wt(F_z(u) + F_{z+a+b}(u+a)).

There are 4,115 nonzero cyclic direction classes in 16 variables. A
rotation-symmetric Boolean function is bent iff every one of these derivative
classes has weight 32,768. The computation is exact and uses only the Python
standard library.
"""
import argparse
import hashlib
import itertools
import json
import struct
from collections import Counter
from pathlib import Path

N=16
H=8
SIZE=1<<N


def toggle(container,value):
    if value in container:
        container.remove(value)
    else:
        container.add(value)


def cyclic_orbits(n=N,degree=5):
    unseen=set(itertools.combinations(range(n),degree))
    out=[]
    while unseen:
        rep=min(unseen)
        orbit={
            tuple(sorted((i+shift)%n for i in rep))
            for shift in range(n)
        }
        unseen.difference_update(orbit)
        out.append((rep,sorted(orbit)))
    return out


def rotate(value,shift,bits):
    shift%=bits
    if not shift:
        return value
    mask=(1<<bits)-1
    return ((value<<shift)|(value>>(bits-shift)))&mask


def canonical_rotation(value,bits):
    return min(rotate(value,shift,bits) for shift in range(bits))


def rotation_period(value,bits):
    for period in range(1,bits+1):
        if rotate(value,period,bits)==value:
            return period
    raise AssertionError


MONOMIAL_TRUTH=[]
for mask in range(1<<H):
    truth=0
    for u in range(1<<H):
        if (u&mask)==mask:
            truth|=1<<u
    MONOMIAL_TRUTH.append(truth)


def fiber_profile(orbit,z):
    anf=set()
    for support in orbit:
        terms={0}
        for variable in support:
            if variable<H:
                factors=(1<<variable,)
            else:
                j=variable-H
                factors=(1<<j,0) if ((z>>j)&1) else (1<<j,)
            nxt=set()
            for left in terms:
                for right in factors:
                    toggle(nxt,left|right)
            terms=nxt
        for monomial in terms:
            toggle(anf,monomial)
    truth=0
    for monomial in anf:
        truth^=MONOMIAL_TRUTH[monomial]
    return truth


def build_representative_basis():
    orbits=cyclic_orbits()
    assert len(orbits)==273
    representatives=sorted({
        canonical_rotation(z,H)
        for z in range(1,1<<H)
    })
    assert len(representatives)==35
    basis=[
        [fiber_profile(orbit,z) for z in representatives]
        for _,orbit in orbits
    ]
    return orbits,representatives,basis


def representative_profiles(mask,basis):
    output=[0]*35
    value=mask
    while value:
        low=value&-value
        coefficient=low.bit_length()-1
        row=basis[coefficient]
        for j in range(35):
            output[j]^=row[j]
        value^=low
    return output


def reconstruct_all_fibers(representatives,profiles):
    """Use actual 16-bit rotations, avoiding a convention-dependent formula."""
    fibers=[None]*(1<<H)
    fibers[0]=0
    for representative,truth in zip(representatives,profiles):
        for shift in range(H):
            z_target=None
            target_truth=0
            for u in range(1<<H):
                x=u|((u^representative)<<H)
                x_rotated=rotate(x,shift,N)
                u_target=x_rotated&0xFF
                z=(x_rotated&0xFF)^((x_rotated>>H)&0xFF)
                if z_target is None:
                    z_target=z
                elif z_target!=z:
                    raise AssertionError("rotated fiber label depends on u")
                if (truth>>u)&1:
                    target_truth|=1<<u_target
            current=fibers[z_target]
            if current is not None and current!=target_truth:
                raise AssertionError("inconsistent fiber reconstruction")
            fibers[z_target]=target_truth
    assert all(value is not None for value in fibers)
    return fibers


BYTE_PERMUTATION=[[0]*256 for _ in range(8)]
for low in range(8):
    for byte in range(256):
        permuted=0
        for bit in range(8):
            if (byte>>(bit^low))&1:
                permuted|=1<<bit
        BYTE_PERMUTATION[low][byte]=permuted


def translate_truth(truth,direction):
    """Return u -> truth(u+direction) for an 8-variable truth table."""
    raw=truth.to_bytes(32,"little")
    high=direction>>3
    low=direction&7
    permutation=BYTE_PERMUTATION[low]
    return int.from_bytes(
        bytes(permutation[raw[index^high]] for index in range(32)),
        "little",
    )


def all_direction_class_weights(fibers):
    translations=[
        [translate_truth(truth,p) for p in range(1<<H)]
        for truth in fibers
    ]
    direction_representatives=sorted({
        canonical_rotation(direction,N)
        for direction in range(1,1<<N)
    })
    assert len(direction_representatives)==4115

    weights={}
    for direction in direction_representatives:
        a=direction&0xFF
        b=(direction>>H)&0xFF
        p=a
        q=a^b
        weight=sum(
            (fibers[z]^translations[z^q][p]).bit_count()
            for z in range(1<<H)
        )
        weights[direction]=weight
    return weights


def audit(mask):
    _,representatives,basis=build_representative_basis()
    rep_profiles=representative_profiles(mask,basis)
    fibers=reconstruct_all_fibers(representatives,rep_profiles)
    weights=all_direction_class_weights(fibers)

    histogram=Counter(weights.values())
    digest=hashlib.sha256()
    for direction,weight in sorted(weights.items()):
        digest.update(struct.pack("<HI",direction,weight))

    balanced=sum(weight==32768 for weight in weights.values())
    global_weight=sum(truth.bit_count() for truth in fibers)
    w0=SIZE-2*global_weight
    signed_nonzero_autocorrelation=0
    autocorrelation_energy=0
    weighted_balanced_directions=0
    for direction,weight in weights.items():
        multiplicity=rotation_period(direction,N)
        autocorrelation=SIZE-2*weight
        signed_nonzero_autocorrelation+=multiplicity*autocorrelation
        autocorrelation_energy+=multiplicity*autocorrelation*autocorrelation
        if weight==SIZE//2:
            weighted_balanced_directions+=multiplicity

    # Standard autocorrelation identities:
    # sum_a AC_f(a)=W_f(0)^2 and
    # sum_b W_f(b)^4=2^n sum_a AC_f(a)^2.
    assert signed_nonzero_autocorrelation==w0*w0-SIZE
    walsh_fourth_moment=SIZE*(SIZE*SIZE+autocorrelation_energy)

    first_failures=[
        {"direction":hex(direction),"weight":weight}
        for direction,weight in sorted(weights.items())
        if weight!=32768
    ][:20]

    report={
        "n":N,
        "degree":5,
        "coefficient_mask":hex(mask),
        "active_orbits":mask.bit_count(),
        "global_weight":global_weight,
        "zero_frequency_walsh":w0,
        "nonzero_direction_rotation_classes":len(weights),
        "nonzero_directions":SIZE-1,
        "balanced_derivative_rotation_classes":balanced,
        "balanced_nonzero_directions":weighted_balanced_directions,
        "unbalanced_derivative_rotation_classes":len(weights)-balanced,
        "minimum_derivative_weight":min(weights.values()),
        "maximum_derivative_weight":max(weights.values()),
        "signed_nonzero_autocorrelation":signed_nonzero_autocorrelation,
        "autocorrelation_energy_nonzero":autocorrelation_energy,
        "walsh_fourth_moment":walsh_fourth_moment,
        "bent_fourth_moment_baseline":SIZE**3,
        "walsh_fourth_moment_excess":SIZE*autocorrelation_energy,
        "all_nonzero_derivatives_balanced":balanced==len(weights),
        "bent_by_derivative_characterization":autocorrelation_energy==0,
        "ordered_direction_weight_sha256":digest.hexdigest(),
        "derivative_weight_histogram":{
            str(weight):count for weight,count in sorted(histogram.items())
        },
        "first_unbalanced_classes":first_failures,
        "scope":(
            "For a rotation-symmetric Boolean function, checking one direction "
            "per cyclic class is exhaustive. Bentness is equivalent to all "
            "nonzero derivatives being balanced."
        ),
    }
    return report


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--mask",required=True)
    parser.add_argument("--output",default="full_derivative_compressed_audit.json")
    args=parser.parse_args()
    report=audit(int(args.mask,0))
    Path(args.output).write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps({
        key:report[key] for key in (
            "global_weight",
            "nonzero_direction_rotation_classes",
            "balanced_derivative_rotation_classes",
            "balanced_nonzero_directions",
            "minimum_derivative_weight",
            "maximum_derivative_weight",
            "autocorrelation_energy_nonzero",
            "walsh_fourth_moment_excess",
            "bent_by_derivative_characterization",
            "ordered_direction_weight_sha256",
        )
    },indent=2))


if __name__=="__main__":
    main()
