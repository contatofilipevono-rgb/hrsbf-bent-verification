#!/usr/bin/env python3
"""Compact algebraic certificate for r-ind(f)=1 of the V2 8-variable seed.

No exhaustive enumeration of direction pairs is used.

The script:
  (1) constructs the linear map from Pluecker coordinates p_ij to the
      quadratic homogeneous part of D_a D_b Q, where Q is the quartic part;
  (2) verifies rank 22 over GF(2);
  (3) derives a six-dimensional kernel;
  (4) substitutes the kernel into four Grassmann-Pluecker relations;
  (5) verifies directly on the 2^6 Boolean kernel parameters that their only
      common Boolean zero is zero.

Step (5) is a tiny independent Boolean check equivalent to the Groebner
certificate stated in V2_ALGEBRAIC_PROOF_SEED_RIND1.md.
"""

from itertools import combinations, product

N=8
QUARTIC_REPS=((0,1,2,3),(0,1,2,5),(0,1,3,5))
PAIRS=list(combinations(range(N),2))
PI={p:i for i,p in enumerate(PAIRS)}


def orbit(rep):
    return {tuple(sorted((i+s)%N for i in rep)) for s in range(N)}


QUARTIC_MONOMIALS=set().union(*(orbit(r) for r in QUARTIC_REPS))


def build_matrix():
    M=[[0]*28 for _ in range(28)]
    for S in QUARTIC_MONOMIALS:
        S=set(S)
        for remaining in combinations(sorted(S),2):
            removed=tuple(sorted(S-set(remaining)))
            M[PI[tuple(remaining)]][PI[removed]] ^= 1
    return M


def rref_gf2(M):
    A=[row[:] for row in M]
    pivots=[]
    r=0
    for c in range(len(A[0])):
        pivot=next((i for i in range(r,len(A)) if A[i][c]),None)
        if pivot is None:
            continue
        A[r],A[pivot]=A[pivot],A[r]
        for i in range(len(A)):
            if i!=r and A[i][c]:
                A[i]=[x^y for x,y in zip(A[i],A[r])]
        pivots.append(c)
        r+=1
    return A,pivots


M=build_matrix()
R,pivots=rref_gf2(M)
assert len(pivots)==22
free=[i for i in range(28) if i not in pivots]
assert [PAIRS[i] for i in free]==[(3,7),(4,6),(4,7),(5,6),(5,7),(6,7)]


def kernel_pluecker(bits):
    # free variables u,v,w,x,y,z
    vec=[0]*28
    for col,val in zip(free,bits):
        vec[col]=val
    # In RREF, pivot + sum(free coefficients)=0.
    for row,pc in enumerate(pivots):
        val=0
        for col in free:
            val ^= R[row][col] & vec[col]
        vec[pc]=val
    return {PAIRS[i]:vec[i] for i in range(28)}


def pluecker(p,q):
    i,j,k,l=q
    return (p[(i,j)]*p[(k,l)]
            ^ p[(i,k)]*p[(j,l)]
            ^ p[(i,l)]*p[(j,k)])


FOUR_RELATIONS=((0,1,2,3),(0,3,4,7),(0,2,4,6),(0,1,2,5))

solutions=[]
for bits in product((0,1),repeat=6):
    p=kernel_pluecker(bits)
    if all(pluecker(p,q)==0 for q in FOUR_RELATIONS):
        solutions.append(bits)

assert solutions==[(0,0,0,0,0,0)]

print("Algebraic seed certificate: PASS")
print("quartic monomials:",len(QUARTIC_MONOMIALS))
print("contraction matrix rank: 22 / 28")
print("kernel dimension: 6")
print("four Pluecker relations suffice")
print("common Boolean kernel solutions:",solutions)
print("conclusion: ker(L) contains no nonzero decomposable bivector")
print("therefore r-ind(f)=ind(f)=1")
