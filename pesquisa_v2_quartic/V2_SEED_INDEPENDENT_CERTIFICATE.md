# Independent computational certificate for the V2 seed

Date: 2026-10-07

## Seed

The 8-variable Boolean seed is specified by the rotation-symmetric SANF orbit representatives

    (0,1)
    (0,1,2,3)
    (0,1,2,5)
    (0,1,3,5)

with indices modulo 8.

The accompanying script

    certificates/verify_seed_rind1.py

reconstructs the complete ANF directly from these four orbit representatives. It has no third-party dependencies.

## Independently recomputed facts

The generated ANF contains 32 distinct monomials and has algebraic degree 4.

Rotation symmetry is checked on all 256 inputs.

The full Walsh transform over all 256 masks has values only +/-16:

    +16 occurs 136 times
    -16 occurs 120 times.

Hence the seed is bent.

## Exhaustive relaxed-linearity certificate

For every unordered pair of distinct nonzero directions a,b in F_2^8, the script evaluates

    D_a D_b f(x)
      = f(x)+f(x+a)+f(x+b)+f(x+a+b)

on all 256 inputs.

Over F_2, distinct nonzero a,b are automatically linearly independent. There are exactly

    C(255,2)=32385

such unordered pairs.

The exhaustive computation finds

    constant second-derivative pairs = 0.

Therefore no two-dimensional relaxed M-subspace exists.

Every nonzero one-dimensional subspace is automatically an M-subspace because D_aD_a f=0. Consequently

    r-ind(f)=ind(f)=1.

This matches Definitions 1.4, 1.5, 4.1 and 4.2 of Polujan--Pott and their Remark 4.8 computational criterion.

## Why this is a certificate rather than a heuristic

The state space is finite and fully enumerated:
- all 256 truth-table inputs;
- all 256 Walsh masks;
- all 32385 unordered independent direction pairs;
- all 256 inputs for every second derivative.

No random sampling is used.

## Dependency chain

This single seed fact is the computational input used later to derive:
- r-ind(F_r)<=r by direct-sum projection/subadditivity;
- ind(F_r)=r-ind(F_r)=r=n/8 after the explicit r-dimensional lower bound;
- the complete classification of all M-subspaces of F_r;
- RMS_k(F_r)=MS_k(F_r);
- the closed all-k M-subspace spectrum.

## Reproduction

Run with any modern Python 3 interpreter:

    python3 certificates/verify_seed_rind1.py

Expected terminal conclusion:

    V2 seed certificate: PASS
    ANF monomials: 32
    algebraic degree: 4
    rotation symmetry: PASS (all 256 inputs)
    Walsh spectrum: {-16: 120, +16: 136}; bentness PASS
    independent direction pairs checked: 32385
    constant second-derivative pairs: 0
    conclusion: r-ind(f)=ind(f)=1

## V1 firewall

This certificate belongs exclusively to V2. V1 remains frozen and untouched.
