"""Explicit polar B_z (entries as linear forms in the 21 coordinates) for the rotation-symmetric rows
z = 0, 63, 9 (=e0+e3), 27 (=e0+e1+e3+e4), 21 (=e0+e2+e4), and z = e0; plus lambda(z) for those rows
(as linear forms in t, since lambda involves the phase)."""
import sys, os, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

Bb = []
for k in range(21):
    code = "".join("1" if i == k else "0" for i in range(21))
    Bb.append(polar_of(t_from_coords(code)))


def form(z, kk):
    return [NAMES[c] for c in range(21) if Bb[c][kk][z]]


def fmt(l):
    return "+".join(l) if l else "0"


for z in (0, 1, 9, 27, 21, 42, 63):
    print("B_z for z=%d (%s):" % (z, format(z, "06b")[::-1]))
    for kk, (i, j) in enumerate(PAIRS):
        print("   %d%d: %s" % (i, j, fmt(form(z, kk))))
# B_z . 1 (row sums) for z = 9, 27
for z in (9, 27):
    print("row sums of B_z, z=%d:" % z)
    for i in range(6):
        acc = collections.Counter()
        for kk, (a, b) in enumerate(PAIRS):
            if i in (a, b):
                for c in range(21):
                    if Bb[c][kk][z]:
                        acc[c] ^= 1
        print("   deg_%d = %s" % (i, fmt([NAMES[c] for c in range(21) if acc[c]])))
