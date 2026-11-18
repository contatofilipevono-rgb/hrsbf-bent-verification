#!/usr/bin/env python3
"""
Stage 2 Algebraic Certificate Extractor:
Extracts the exact degree <= 3 ANF polynomials for the U_4^perp coset conditions
from Theorem 1: H(0xf)=0, H(0x0)=+-256, H(0x5)=0 (mod 8 / mod 4),
checks their degrees, linear/quadratic structure, and evaluates them on all 14
audited 6/7-distance witnesses (including 0x7f).
"""
import json
import random
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import (
    WITNESSES,
    build_basis_111,
    eval_poly,
    extract_poly_mod4,
    setup_orbits,
)


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    coset_orbits = {0x0: [], 0xF: [], 0x5: []}
    visited = bytearray(65536)
    for x in range(65536):
        if visited[x]:
            continue
        cur, members = x, []
        while not visited[cur]:
            visited[cur] = 1
            members.append(cur)
            cur = ((cur << 1) & 0xFFFF) | (cur >> 15)
        if len(members) == 16:
            v = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if v in (0x0, 0xF, 0x5, 0xA):
                key = 0x5 if v in (0x5, 0xA) else v
                coset_orbits[key].append(members[0])

    out = {"coset_polynomials": {}}
    rng = random.Random(2026111802)

    for cname, reps in coset_orbits.items():
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(reps)) for orb in orbits]
        O_word = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_word ^= words[j]
        basis = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= words[j]
            basis.append(w)

        P = extract_poly_mod4(basis, O_word, free, const_shift=0)
        deg = max((m.bit_count() for m in P), default=0)

        # Verify against 64 random ANF evaluations on the coset
        for _ in range(64):
            cint = origin
            for j, cdir in zip(free, cb):
                if rng.getrandbits(1):
                    cint ^= cdir
            w_eval = O_word
            for j, bword in zip(free, basis):
                if (cint >> j) & 1:
                    w_eval ^= bword
            wt = w_eval.bit_count()
            assert wt % 2 == 0
            # sum over 16*len(reps) points: 16*(len(reps) - 2*wt)
            # (wt // 2) % 2 == eval_poly(P, cint) ? Wait: extract_poly_mod4 computes (wt - 2*(wt? no, O_word^w))//4 mod 2
            # Actually O_word ^ w = w_eval, and wt(w_eval) = 2*(#pairs) -> extract_poly_mod4(basis, O_word) gives (wt(w_eval) - wt(O_word))//2?
            # Wait: in extract_poly_mod4, O_word is the base word, and (wt(O_word ^ x) - wt(O_word)) / 2 mod 2:
            # Wait: in T31, each bit of `pairs` represents 2 points (total 4096), so `4096 - 2*wt(full) = ... - 4*wt(pairs)`.
            # Here each bit of `reps` represents 16 points! So sum = 16*(len(reps) - 2*wt(w_eval)).
            # And wt(w_eval) mod 4 == 2 * eval_poly(P, cint) ? Let's check!
            # Wait: wt(A ^ B) = wt(A) + wt(B) - 2*wt(A & B). Since wt(A) % 4 == 0 and wt(B) % 4 == 0? No, wt(B) % 2 == 0, and extract_poly_mod4 checks (wt(B) - 2*wt(B&O)) % 4 == 0!
            # Thus wt(w_eval) // 2 % 2 == eval_poly(P, cint) when O_word.bit_count() % 4 == 0!
            assert (wt // 2) % 2 == eval_poly(P, cint), (hex(cname), wt, eval_poly(P, cint))

        # For H(0xf)=0: 16*(256 - 2*wt) = 0 => wt = 128 => wt//2 = 64 => (wt//2)%2 == 0!
        # For H(0x5)=0: 16*(512 - 2*wt) = 0 => wt = 256 => wt//2 = 128 => (wt//2)%2 == 0!
        # For H(0x0)=+-256: D8 contributes +-64, so C_{0x0}\D8 must sum to +-256 - (+-64) in {+-192, +-320}.
        #   16*(240 - 2*wt) in {+-192, +-320} => 240 - 2*wt in {+-12, +-20} => wt in {114, 126, 110, 130} => wt//2 in {55, 63, 55, 65} => (wt//2)%2 == 1 ALWAYS!
        expected_target = 1 if cname == 0x0 else 0
        w_evals = {wn: eval_poly(P, cint) for wn, cint in WITNESSES.items()}
        out["coset_polynomials"][hex(cname)] = {
            "terms": len(P),
            "degree": deg,
            "required_value_for_bent": expected_target,
            "witness_evals": w_evals,
            "witnesses_passing": [wn for wn, v in w_evals.items() if v == expected_target],
            "witnesses_failing": [wn for wn, v in w_evals.items() if v != expected_target],
        }

    out["elapsed_sec"] = round(time.perf_counter() - t0, 4)
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/algebra_c99_2_cosets.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
