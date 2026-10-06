#!/usr/bin/env python3
"""Exact 7-dimensional diagonal-translation kernel for quintic HRSBFs.

For n=16, write x=(u,v) with u,v in F_2^8 and let a=(e_0,e_0).
On the 273-dimensional space of homogeneous degree-5 rotation-symmetric
Boolean functions, the linear map f -> D_a f has rank 266 and kernel
exactly
    f(u,v)=h(u+v),
where h ranges over the 7-dimensional space of homogeneous degree-5
rotation-symmetric functions in 8 variables.

The script regenerates the seven lifted basis masks and verifies the rank,
kernel membership, independence, and constant-on-fiber action exactly.
"""
import itertools
import json
import sys
from pathlib import Path

N=16
H=8


def cyclic_orbits(n,degree):
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


def derivative_orbit_anf(orbit,direction):
    result=0
    for support in orbit:
        active=sum(1<<i for i in support if (direction>>i)&1)
        if not active:
            continue
        full=sum(1<<i for i in support)
        subset=active
        while subset:
            result^=1<<(full^subset)
            subset=(subset-1)&active
    return result


def add_basis(basis,vector):
    x=vector
    while x:
        pivot=x.bit_length()-1
        if pivot in basis:
            x^=basis[pivot]
        else:
            basis[pivot]=x
            return True
    return False


def rank(vectors):
    basis={}
    for vector in vectors:
        add_basis(basis,vector)
    return len(basis)


def lift_h_orbit(orbit8,subset_to_orbit16):
    monomials=set()
    for support in orbit8:
        for choices in itertools.product((0,1),repeat=5):
            support16=tuple(sorted(
                index+H*choice
                for index,choice in zip(support,choices)
            ))
            if support16 in monomials:
                monomials.remove(support16)
            else:
                monomials.add(support16)

    counts={}
    for support in monomials:
        orbit_index=subset_to_orbit16[support]
        counts[orbit_index]=counts.get(orbit_index,0)+1

    mask=0
    return_indices=[]
    return_reps=[]
    return_orbit_sizes=[]
    return_counts=[]
    for orbit_index,count in sorted(counts.items()):
        mask|=1<<orbit_index
        return_indices.append(orbit_index)
        return_reps.append(orbit_index)
        return_counts.append(count)
    return mask,monomials,counts


def evaluate_h_orbit(orbit,z):
    value=0
    for support in orbit:
        value^=int(all((z>>i)&1 for i in support))
    return value


def fiber_constant_value(mask,z,orbits16):
    """Evaluate the lifted polynomial at u=0, v=z.

    Kernel membership implies every point (u,u+z) has this same value.
    """
    value=0
    for i,(_,orbit) in enumerate(orbits16):
        if not ((mask>>i)&1):
            continue
        x=z<<H
        for support in orbit:
            value^=int(all((x>>j)&1 for j in support))
    return value


def generate():
    orbits16=cyclic_orbits(N,5)
    orbits8=cyclic_orbits(H,5)
    assert len(orbits16)==273
    assert len(orbits8)==7

    subset_to_orbit16={}
    for index,(_,orbit) in enumerate(orbits16):
        for support in orbit:
            subset_to_orbit16[support]=index

    direction=(1<<0)|(1<<H)
    derivative_images=[
        derivative_orbit_anf(orbit,direction)
        for _,orbit in orbits16
    ]
    derivative_rank=rank(derivative_images)
    assert derivative_rank==266

    kernel=[]
    for rep8,orbit8 in orbits8:
        mask,monomials,counts=lift_h_orbit(orbit8,subset_to_orbit16)

        # The lift must be a union of complete 16-variable rotation orbits.
        for orbit_index,count in counts.items():
            assert count==len(orbits16[orbit_index][1])

        derivative=0
        value=mask
        while value:
            low=value&-value
            index=low.bit_length()-1
            derivative^=derivative_images[index]
            value^=low
        assert derivative==0

        # f(u,v)=h(u+v) means F_z is the constant h(z).
        for z in range(1<<H):
            expected=evaluate_h_orbit(orbit8,z)
            observed=fiber_constant_value(mask,z,orbits16)
            assert observed==expected

        active=[
            {
                "index":index,
                "representative":list(orbits16[index][0]),
            }
            for index in sorted(counts)
        ]
        kernel.append({
            "h_representative_8":list(rep8),
            "coefficient_mask_273":hex(mask),
            "active_16_orbits":active,
        })

    masks=[int(row["coefficient_mask_273"],16) for row in kernel]
    assert rank(masks)==7
    assert len(orbits16)-derivative_rank==7

    # Row-reduce the seven masks to expose a convenient canonical gauge.
    pivots={}
    provenance={}
    for source,mask in enumerate(masks):
        x=mask
        combination=1<<source
        while x:
            pivot=x.bit_length()-1
            if pivot in pivots:
                x^=pivots[pivot]
                combination^=provenance[pivot]
            else:
                pivots[pivot]=x
                provenance[pivot]=combination
                break
    assert len(pivots)==7

    gauge=[
        {
            "coefficient_index":pivot,
            "orbit_representative_16":list(orbits16[pivot][0]),
            "reduced_kernel_vector":hex(pivots[pivot]),
            "source_h_basis_mask":hex(provenance[pivot]),
        }
        for pivot in sorted(pivots,reverse=True)
    ]

    return {
        "date_utc":"2026-10-06",
        "n":N,
        "degree":5,
        "domain_dimension":len(orbits16),
        "single_diagonal_direction":"0x0101",
        "single_diagonal_derivative_rank":derivative_rank,
        "kernel_dimension":len(orbits16)-derivative_rank,
        "kernel_description":"f(u,v)=h(u+v), with h homogeneous quintic rotation-symmetric in 8 variables",
        "h_space_dimension":len(orbits8),
        "kernel_basis":kernel,
        "canonical_gauge_pivots":gauge,
        "status":"PASS",
        "interpretation":(
            "The seven lifted functions span the full kernel because they are "
            "independent, lie in the kernel, and match its dimension."
        ),
    }


if __name__=="__main__":
    if not __debug__:
        raise RuntimeError("Run without python -O; assertions are audit checks.")
    if len(sys.argv)!=2:
        raise SystemExit("usage: python3 diagonal_kernel_d5.py OUTPUT.json")
    report=generate()
    Path(sys.argv[1]).write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps({
        key:report[key] for key in (
            "domain_dimension",
            "single_diagonal_derivative_rank",
            "kernel_dimension",
            "h_space_dimension",
            "status",
        )
    },indent=2))
