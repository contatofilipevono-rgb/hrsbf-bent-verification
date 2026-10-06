#!/usr/bin/env python3
"""Independent audit of quadratic RS rigidity in power-of-two dimensions.

Enumerates every rotation-symmetric Boolean function of degree <=2 for
N=4,8,16 using orbit coefficients, computes its truth table, and checks
that every balanced function has zero quadratic component.
No project validator is imported.
"""

def orbit_masks(N):
    linear = [1 << i for i in range(N)]
    q_orbits=[]
    seen=set()
    for d in range(1, N//2 + 1):
        terms=set()
        for i in range(N):
            a=i; b=(i+d)%N
            terms.add((1<<a)|(1<<b))
        key=tuple(sorted(terms))
        if key not in seen:
            seen.add(key); q_orbits.append(key)
    return (tuple(linear), q_orbits)

def eval_orbit(terms,x):
    v=0
    for mask in terms:
        v ^= (x & mask) == mask
    return int(v)

def audit(N):
    lin, qs=orbit_masks(N)
    gens=[lin]+qs
    tables=[[eval_orbit(g,x) for x in range(1<<N)] for g in gens]
    balanced=0; bad=0
    # constant omitted: adding it preserves balance and quadratic part.
    for coeff in range(1<<len(gens)):
        wt=0
        for x in range(1<<N):
            v=0
            for j,T in enumerate(tables):
                if (coeff>>j)&1: v ^= T[x]
            wt += v
        if wt*2 == (1<<N):
            balanced += 1
            if coeff >> 1:
                bad += 1
    assert bad == 0, (N, balanced, bad)
    return len(qs), balanced

def main():
    for N in (4,8,16):
        q,b=audit(N)
        print(f"N={N}: quadratic orbits={q}, balanced normalized RS functions={b}, violations=0, PASS")
    print("ALL QUADRATIC RS RIGIDITY CHECKS PASS")

if __name__ == "__main__":
    main()
