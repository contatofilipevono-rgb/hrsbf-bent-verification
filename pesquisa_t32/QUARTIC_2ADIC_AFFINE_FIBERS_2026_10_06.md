# Quartic 2-adic descent and affine fibers (research note)

Status: exploratory, with proved structural lemmas and finite exact checks. This note does **not** claim a quartic nonexistence theorem.

## Setup

Let f be a homogeneous degree-4 rotation-symmetric Boolean function in n=32 variables. Write x=(u,v), u,v in F_2^16, and define

F_z(u)=f(u,u+z),   A_z=sum_u (-1)^{F_z(u)}.

## 1. Half-turn descent

For a distinct cyclic monomial orbit O(S), restriction to the half-turn diagonal x=(u,u) cancels unless the support S is invariant under translation by 16. An invariant quartic support is a union of two antipodal pairs. After identifying each pair, its monomial has degree 2.

Therefore every homogeneous quartic RS f satisfies

f(u,u)=q(u)

for a homogeneous quadratic RS function q in 16 variables.

The exact orbit count is:

- 1128 quartic cyclic monomial orbits in 32 variables;
- exactly 8 have nonzero half-turn-diagonal restriction;
- their restrictions span the 8 homogeneous quadratic RS orbit sums in 16 variables.

More generally, on a subspace obtained by repeating a block 2^s times, a monomial orbit can survive only when its support is a union of translation orbits of size 2^s. This gives a natural 2-adic degree-descent mechanism.

For fourfold repetition in n=32, the quartic restriction is at most linear. The only possible nonzero component is the parity orbit induced by the support {0,8,16,24}.

## 2. All half-diagonal fibers become cubic

For fixed z,

F_z(u)=f(u,u+z).

The degree-4 homogeneous part of F_z is independent of z and equals the degree-4 part of F_0. But F_0=q has degree at most 2. Hence

deg(F_z) <= 3

for every z in F_2^16.

Thus the quartic n=32 problem induces a family of cubic-or-lower functions in 16 variables.

## 3. Complementary fiber and twisted rotation

For z=1^16, rotation symmetry of f implies invariance of F_z under the affine map

tau(u_0,...,u_15)=(u_15+1,u_0,...,u_14).

An exact GF(2) rank computation gives

rank(f -> F_{1^16}) = 36.

Independently, the vector space of degree <=3 Boolean polynomials invariant under tau has dimension 36. Hence the image is exactly this invariant space.

Other exact ranks, useful for a periodic-fiber hierarchy, are:

z=0^16: 8
z=1^16: 36
z=0101...: 66
z=00110011...: 98
z=00010001...: 110
z=e_0: 189

These are finite structural checks, not nonexistence proofs.

## 4. Bent energy identity

If f is bent, Fourier transform in the fiber index gives

hat A(b)=sum_z A_z (-1)^{b.z}=W_f(b,b).

Therefore |hat A(b)|=2^16 for every b, and Parseval gives the necessary identity

sum_z A_z^2 = 2^32.

Since every F_z has degree <=3, standard Reed-Muller divisibility implies A_z is divisible by 64.

The diagonal term A_0 is especially rigid. Exhaustive classification of the 256 homogeneous quadratic RS functions in 16 variables gives:

|A_0| in {256,512,1024,2048,4096,8192,16384,32768,65536},

with squared-magnitude multiplicities

2^16: 128
2^18: 64
2^20: 32
2^22: 16
2^24: 8
2^26: 4
2^28: 2
2^30: 1
2^32: 1.

The 2^32 case is q=0. No nonzero homogeneous quadratic RS q in 16 variables is balanced.

Thus a hypothetical quartic bent f must distribute the remaining exact Parseval energy among cubic fibers subject simultaneously to:
- 64-divisibility of every A_z;
- cyclic-orbit equality A_{Sz}=A_z;
- additional affine invariance for periodic z;
- compatibility because all fibers arise from the same 1128 quartic coefficients.

## 5. Proposed target lemma

A promising next target is an **affine-fiber energy obstruction**:

> No compatible family of degree <=3 fibers arising from a homogeneous quartic RS function in 32 variables can satisfy sum_z A_z^2=2^32 together with |hat A(b)|=2^16 for all b.

A stronger route would classify possible character sums in the 36-dimensional tau-invariant cubic space and then combine them with the periodic z orbit hierarchy.

## 6. Scope

This note intentionally separates:
1. algebraic statements proved directly (degree descent, degree <=3 fibers, twisted invariance, Parseval identity);
2. exact finite computations (orbit counts, ranks, 256 quadratic diagonal spectra);
3. the still-open obstruction needed to exclude all quartic HRSBF bent functions.

Do not cite the rank data alone as a proof of quartic nonexistence.
