#!/usr/bin/env python3
"""Exact 8-variable inequivalence certificate against Pasalic et al. (IEEE TIT 2024), Examples 28, 29, 37.

Criterion: our quartic RS base block F1 has ordinary linearity index 1
(certify_base_relaxed_index.py). Hence existence of ANY independent pair
a,b with D_a D_b g == 0 proves g is not affine/EA-equivalent to F1,
because ordinary M-subspace dimension is invariant under equivalence.

Coordinates for published examples: (x1,x2,x3,y1,y2,y3,s1,s2).
The selector (s1,s2) chooses f1,f2,f3,f4 in lexicographic order.
Any alternative ordering of four selectors is affine on F_2^2 and does
not affect the separating invariant.
"""
import json
from pathlib import Path

def dot(a,b): return sum(x*y for x,y in zip(a,b)) & 1
def delta0(x): return int(not any(x))

def pi(y):
    y1,y2,y3=y
    return (y2*y3^y1^y2^y3, y1*y2^y1*y3^y2, y1*y2^y3)

def sigma(x):
    x1,x2,x3=x
    return (x1^x2^x3^(x2*x3), x2^x3^(x1*x3), x2^(x1*x2)^(x1*x3))

def h1(y):
    a,b,c=y
    return a*b*c^a*b^a*c^b*c^a^b^c

def h2(x):
    a,b,c=x
    return a*b*c^a*c^b*c^1

def ex28(i,x,y):
    return [
        dot(x,y)^delta0(x),
        dot(x,pi(y))^delta0(x),
        dot(x,y),
        dot(x,pi(y))^1,
    ][i]

def ex29(i,x,y):
    return [
        dot(x,pi(y))^h1(y),
        dot(x,pi(y))^h1(y),
        dot(y,sigma(x))^h2(x),
        dot(y,sigma(x))^h2(x)^1,
    ][i]

def ex37(i,x,y):
    x1,x2,x3=x; y1,y2,y3=y
    fs=[
      x1*(y2^y3^(y1*y3)) ^ x2*(y1^(y1*y3)^(y2*y3)) ^ x3*((y1*y2)^y3) ^ y1^y2^y3,
      x1*(y2^(y1*y2)^(y1*y3)) ^ x2*(y1^y2^(y1*y2)^(y2*y3)) ^ x3*(y1^(y1*y2)^y3^(y1*y3)^(y2*y3)) ^ y3^1,
      x1*(y1^y2^(y1*y2)^(y2*y3)) ^ x2*(y2^y3^(y1*y3)) ^ x3*(y1^y2^y3^(y2*y3)) ^ y2^y3^1,
      x1*(y1^y2^y3^(y2*y3)) ^ x2*((y1*y2)^y3) ^ x3*(y2^y3^(y1*y3)) ^ y1^1,
    ]
    return fs[i]

def truth(constructor):
    out=[]
    for z in range(256):
        q=[(z>>j)&1 for j in range(8)]
        x,y=q[:3],q[3:6]
        i=q[6]+2*q[7]
        out.append(constructor(i,x,y))
    return out

def walsh_abs(tt):
    return sorted({abs(sum(1 if (tt[x]^((u&x).bit_count()&1))==0 else -1 for x in range(256))) for u in range(256)})

def zero_second_derivative_pairs(tt):
    pairs=[]
    for a in range(1,256):
        for b in range(a+1,256):
            if all((tt[x]^tt[x^a]^tt[x^b]^tt[x^a^b]) == 0 for x in range(256)):
                pairs.append((a,b))
    return pairs

def main():
    result={"criterion":"existence of independent a,b with D_a D_b f identically zero; F1 has none"}
    for name,fn in [("Example28",ex28),("Example29",ex29),("Example37",ex37)]:
        tt=truth(fn)
        pairs=zero_second_derivative_pairs(tt)
        assert walsh_abs(tt)==[16], (name,walsh_abs(tt))
        assert pairs, name
        result[name]={
            "bent_walsh_absolute_values":[16],
            "zero_second_derivative_pair_count":len(pairs),
            "first_witness_decimal":list(pairs[0]),
            "first_witness_binary":[format(pairs[0][0],"08b"),format(pairs[0][1],"08b")],
            "conclusion":"ordinary linearity index >= 2, hence inequivalent to F1 (ind(F1)=1)"
        }
    out=Path(__file__).with_name("pasalic_2024_inequivalence_certificate.json")
    out.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))

if __name__=="__main__":
    main()
