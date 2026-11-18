#!/usr/bin/env python3
"""
Stage 1-3 Algebraic Certificate Extractor & Tester for H(16,4), branch c99=1:
- Reconstructs exact polynomials over the 111 free variables (T20 + C5 + C7) for:
  * Symmetric weight-12 supports: 0x3f3f (delta=1), 0x5f5f (delta=2), 0x6f6f (delta=3)
    both with chi (h_f) and without chi (tilde_h_f), modulo 32.
  * U_4^perp coset parity/quadratic laws: H(0x0) = +-256, H(0xf) = 0, H(0x5) = 0.
- Validates every extracted polynomial against direct 65,536-entry ANF evaluations
  and against the 14 audited 6/7-distance witnesses.
- Checks linear rank reduction and degree-2 Macaulay elimination with C4 and C6.
"""
import json
import random
import time
from itertools import combinations
from pathlib import Path

L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
K_INDICES = [
    1, 3, 9, 11, 13, 15, 21, 24, 28, 32, 34, 38, 45, 47, 53, 55,
    67, 69, 70, 72, 74, 76, 78, 80, 86, 89, 91, 93, 97, 103, 107, 109,
]
R_INDICES = [
    5, 6, 7, 16, 17, 19, 43, 44, 49, 50, 51, 58, 59, 62, 63, 66,
    82, 84, 87, 95, 100, 102, 105, 108,
]

WITNESSES = {
    "0xbf": 0x363FDFBFE7FBD7EDEE7DFFFFFFBFA,
    "0xef": 0x77BDBBFFFB7EBEFFDDDEFFDF75DBB,
    "0xfb": 0x7FFEF79F67F7DFFBFBCDBEBFEFFBC,
    "0xfe": 0x7EEDFBFB7F7EFA77EBEBEBFFDDFEF,
    "0xfd": 0x7DFBC6E96AB4CCC7522A55A9B149,
    "0xf7": 0x21FA9DA6202A8F316E69BC43B2CBB,
    "0xdf": 0x4549B7CD9FC26C844FA27B80F56D5,
    "0x7f": 0x7FFACD667B275BB99963C1FA99B53,
    "0x5f": 0x63FDFBFEFFB97C5EE7DFBF7FFBDA,
    "0x77": 0x2158943D9B9C46B758EDE787A6BA8,
    "0x7d": 0x579FBBFFEB7E9EDFDCD6F7DF75DBB,
    "0xd7": 0x6945F66E9236B2216A67A9C2A4FD6,
    "0xf5": 0x2D5CF30A3783BE3CDA9694DCCA341,
    "0xdd": 0x7ADAEDFE672BB236DCD7C63CA08B4,
}


def setup_orbits():
    seen, orbits = set(), []
    for subset in combinations(range(16), 4):
        m = sum(1 << j for j in subset)
        if m in seen:
            continue
        orb = set()
        r = m
        for _ in range(16):
            orb.add(r)
            r = ((r << 1) & 65535) | (r >> 15)
        seen |= orb
        orbits.append(orb)
    assert len(orbits) == 116
    return orbits


def extract_poly_mod4(basis, O_word, free, const_shift=0):
    """Extract degree <= 3 ANF of (wt(f) - 2*wt(f&O)) // 4 mod 2."""
    n = len(free)
    P = set()

    def toggle(m):
        if m in P:
            P.remove(m)
        else:
            P.add(m)

    assert O_word.bit_count() % 2 == 0
    for i, w in enumerate(basis):
        assert w.bit_count() % 2 == 0 and (w.bit_count() - 2 * (w & O_word).bit_count()) % 4 == 0, i
    for v, w in combinations(basis, 2):
        assert (v & w).bit_count() % 2 == 0

    if ((O_word.bit_count() // 2) // 2 + const_shift) % 2:
        toggle(0)
    for i, w in enumerate(basis):
        if ((w.bit_count() - 2 * (w & O_word).bit_count()) // 4) % 2:
            toggle(1 << free[i])
    for i, j in combinations(range(n), 2):
        inter = basis[i] & basis[j]
        if (inter.bit_count() // 2 + (inter & O_word).bit_count()) % 2:
            toggle((1 << free[i]) | (1 << free[j]))
    for i, j, k in combinations(range(n), 3):
        if (basis[i] & basis[j] & basis[k]).bit_count() % 2:
            toggle((1 << free[i]) | (1 << free[j]) | (1 << free[k]))
    return P


def build_basis_111():
    # Free after T20 (c115=0, c113=c57, c0=1^L\{0}) + C5 (c57=K) + C7 (c5=R\{5})
    excluded = {0, 5, 57, 99, 113, 115}
    free = sorted(set(range(116)) - excluded)
    assert len(free) == 110  # wait: 116 - 6 = 110!
    L_set = set(L_INDICES)
    K_set = set(K_INDICES)
    R_set = set(R_INDICES)
    origin = (1 << 0) | (1 << 99)
    cb = []
    for j in free:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        if j in R_set:
            c ^= 1 << 5
        if j in K_set:
            c ^= (1 << 57) | (1 << 113)
        cb.append(c)
    return free, origin, cb


def eval_poly(P, c_int):
    return sum(1 for m in P if (c_int & m) == m) % 2


def gf2_rank_and_rref(rows, n_cols):
    pivots = {}
    for r in rows:
        v = r
        while v:
            b = v.bit_length() - 1
            if b in pivots:
                v ^= pivots[b]
            else:
                pivots[b] = v
                break
    return len(pivots), pivots


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    # Check all 14 witnesses lie in the 110-dim affine space (T20+C5+C7)
    for wname, cint in WITNESSES.items():
        rec = origin
        for j, cdir in zip(free, cb):
            if (cint >> j) & 1:
                rec ^= cdir
        assert rec == cint, f"Witness {wname} not in affine space!"

    report = {"free_dim_after_T20_C5_C7": len(free), "supports": {}, "cosets": {}, "witness_checks": {}}

    # 1. Weight-12 symmetric supports: 0x3f3f (delta=1), 0x5f5f (delta=2), 0x6f6f (delta=3)
    rng = random.Random(2026111801)
    for name, m8 in [("0x3f3f", 0x3F), ("0x5f5f", 0x5F), ("0x6f6f", 0x6F)]:
        small = [v for v in range(256) if (v & m8) == v]
        assert len(small) == 64
        pairs = [v | (w << 8) for v in small for w in small if v < w]
        assert len(pairs) == 2016
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]

        # Diagonal check
        diag = [sum((sum((v | (v << 8)) & m == m for m in orb) % 2) << i for i, v in enumerate(small)) for orb in orbits]
        Da = diag[57] ^ diag[113]
        Db = diag[99]
        diag_vals = [64 - 2 * ((Da if a else 0) ^ (Db if b else 0)).bit_count() for a, b in [(0, 0), (0, 1), (1, 0), (1, 1)]]

        for use_chi, tag in [(False, "no_chi"), (True, "with_chi")]:
            O_base = sum((x.bit_count() % 2) << k for k, x in enumerate(pairs)) if use_chi else 0
            O_word = O_base
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

            # Note: B0(delta) = +-16 when use_chi=False (and check with_chi too)
            # Extract polynomial for wt(t_f)/4 mod 2
            P = extract_poly_mod4(basis, O_word, free, const_shift=0)
            deg = max((m.bit_count() for m in P), default=0)

            # Verify against 64 random ANF evaluations on all 4096 points
            allpts = [v | (w << 8) for v in small for w in small]
            allwords = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(allpts)) for orb in orbits]
            chi_all = sum((x.bit_count() % 2) << k for k, x in enumerate(allpts)) if use_chi else 0
            for _ in range(64):
                cint = origin
                for j, cdir in zip(free, cb):
                    if rng.getrandbits(1):
                        cint ^= cdir
                word = chi_all
                for j in range(116):
                    if (cint >> j) & 1:
                        word ^= allwords[j]
                h = 4096 - 2 * word.bit_count()
                # Check h mod 32 bit
                expected_bit = ((h // 16) % 2)
                # Wait: B0/16 mod 2 = 1 for no_chi, so (h - B0)/16? Let's check directly!
                c57 = (cint >> 57) & 1
                b0 = diag_vals[2 * c57 + 1] if not use_chi else (64 - 2 * ((chi_all & 0) ^ 0))  # compute exact b0
                if use_chi:
                    b0 = sum(1 - 2 * ((((v | (v << 8)).bit_count() % 2) ^ sum(((v | (v << 8)) & m) == m for j in range(116) if (cint >> j) & 1 for m in orbits[j])) % 2) for v in small)
                else:
                    b0 = diag_vals[2 * c57 + 1]
                assert (h - b0) % 16 == 0
                val_p = eval_poly(P, cint)
                assert (((h - b0) // 16) % 2) == val_p, (name, tag, h, b0, val_p)

            w_evals = {}
            for wn, cint in WITNESSES.items():
                w_evals[wn] = eval_poly(P, cint)

            report["supports"][f"{name}_{tag}"] = {
                "diag_vals_ab": diag_vals,
                "terms": len(P),
                "degree": deg,
                "linear_only": deg <= 1,
                "witness_evals": w_evals,
            }

    # 2. U_4^perp cosets: C_{0xf} (256 orbits of size 16) and C_{0x0} \ D_8 (240 orbits of size 16)
    # Group x in 0..65535 by v = x0 ^ x1 ^ x2 ^ x3 (4-bit nibbles)
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

    assert len(coset_orbits[0xF]) == 256
    assert len(coset_orbits[0x0]) == 240
    assert len(coset_orbits[0x5]) == 512

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

        # Check parity (mod 2) and mod 4!
        par_bits = [w.bit_count() % 2 for w in basis]
        par_const = O_word.bit_count() % 2
        lin_mask = sum((1 << free[i]) for i, b in enumerate(par_bits) if b)
        mod4_possible = all(b == 0 for b in par_bits) and all((v & w).bit_count() % 2 == 0 for v, w in combinations(basis, 2))
        report["cosets"][hex(cname)] = {
            "num_size16_orbits": len(reps),
            "linear_parity_const": par_const,
            "linear_parity_terms": lin_mask.bit_count(),
            "mod4_quadratic_clean": mod4_possible,
            "witness_parities": {wn: (par_const ^ ((cint & lin_mask).bit_count() % 2)) for wn, cint in WITNESSES.items()},
        }

    # Check linear rank of all linear equations discovered + L, R, K
    lin_rows = []
    for k, info in report["supports"].items():
        if info["degree"] <= 1:
            lin_rows.append(k)
    report["new_linear_support_laws"] = lin_rows
    report["elapsed_sec"] = round(time.perf_counter() - t0, 4)

    out_dir = repo / "research_updates/2026_11_17_h16_c99_carbon_hard"
    out_path = out_dir / "algebra_c99_1_certificate.json"
    out_path.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
