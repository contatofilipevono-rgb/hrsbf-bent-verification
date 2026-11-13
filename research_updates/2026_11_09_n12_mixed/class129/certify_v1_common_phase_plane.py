"""Standalone model-based certificate & verifier for the V1 common phase plane (n=12, deg 4)."""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
from itertools import combinations
import json
from pathlib import Path
import sys
from time import perf_counter

THIS_DIR = Path(__file__).resolve().parent
MIXED_DIR = THIS_DIR.parent
if str(MIXED_DIR) not in sys.path:
    sys.path.insert(0, str(MIXED_DIR))

from count_near_antipodal import image_and_kernel
from dim4_balance_charts import character_sums
from dim4_support_decode import decode
from dim4_support_moments import indicator_products, moment_equations
from higher_filter import xor_terms
from line_column_autocorrelation import affine_consequences
from line_phase_algebra import locate, reduce_phase
from lower_dim_moments import moment_masks
from lower_dim_orbits import code_actions
from lower_dim_phase_prepare import fibre_masks

FIRST = 0x084006C00810
SECOND = 0x106002400C20
V_BAD = 0x030420102180
L_PERP_INDICES = (7, 8, 13, 20, 29, 34, 40, 41)
BAD_PHASES = (6, 7, 13)

CL3_PARITIES = (26, 60, 64)
CL3_BASIS = (1, 14, 22, 36, 128)

S_BITS = (11, 13, 16, 19, 22, 23)
H_BITS = (11, 13, 16, 19, 22, 23, 24)
L_BITS = (1, 11, 13, 16, 19, 22, 23)

CATALOG_CHARTS = (0, 1, 22, 23, 36, 37, 50, 51, 128, 129, 164, 165, 178, 179)
NON_CAT_RM_CHARTS = (14, 15, 24, 25, 42, 43, 142, 143, 152, 153, 170, 171, 188, 189)
INFEASIBLE_CL3_CHARTS = (60, 61, 150, 151)

# Single deg-2 RM(2,8) moment certificate (output_mask, domain_mask_name) yielding H(u) == c4 directly per chart.
RM_H_CERTS = {
    0: (3, "s1*s2"),
    1: (3, "s1*s2"),
    22: (6, "z0*s1"),
    23: (6, "z0*s1"),
    36: (3, "z0*s1"),
    37: (3, "z0*s1"),
    50: (6, "z0*s2"),
    51: (6, "z0*s2"),
    128: (3, "z0*s1"),
    129: (3, "z0*s1"),
    164: (3, "z1*s1"),
    165: (3, "z1*s1"),
    178: (6, "z0*s2"),
    179: (6, "z0*s2"),
}

# Concrete 33-bit counterexamples preserving exact failure under each relaxed hypothesis.
RELAXATION_WITNESSES = {
    "R1_outside_CL3": {
        "code": 0x04000000,
        "violated": ("CL3_pure_z_RM", "RM_deg2", "char_sums", "fibre_sizes"),
        "description": "Chart 2 violates pure-z deg-2 RM constraints [26,60,64] and escapes L.",
    },
    "R2_no_RM_chart1": {
        "code": 0x039C593E,
        "violated": ("RM_2_8",),
        "preserved": ("CL3", "char_sums", "size16_all"),
        "description": "Passes all char_sums and |Ft|==16 for all t, fails RM(2,8), escapes L.",
    },
    "R2_no_RM_chart129": {
        "code": 0x1037B6BC6,
        "violated": ("RM_2_8",),
        "preserved": ("CL3", "char_sums", "size16_all"),
        "description": "Class 129: passes all char_sums and |Ft|==16, fails RM(2,8), escapes L.",
    },
    "R2_no_RM_chart164": {
        "code": 0x149604002,
        "violated": ("RM_2_8",),
        "preserved": ("CL3", "char_sums", "size16_all"),
        "description": "Class 164: passes all char_sums and |Ft|==16, fails RM(2,8), escapes L.",
    },
    "R3_no_char_sums_single_F15_mod8_only": {
        "code": 0x1D480124,
        "violated": ("exact_char_sums", "all_Ft_mod8"),
        "preserved": ("CL3", "RM_2_8", "F15_mod8"),
        "description": "Chart 14: passes 100% RM(2,8) and |F15|=0 (%8==0), fails exact char_sums & t!=15 mod 8, escapes L.",
    },
    "R4_no_mod8_chart1": {"code": 0x0300080E, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart22": {"code": 0x2D80304E, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart23": {"code": 0x2F106812, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart36": {"code": 0x4980C003, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart37": {"code": 0x4B505057, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart50": {"code": 0x65401873, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart51": {"code": 0x6740E01E, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart128": {"code": 0x101801012, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart129": {"code": 0x103D0204F, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart164": {"code": 0x149902802, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart165": {"code": 0x14B50684A, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart178": {"code": 0x16532D003, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
    "R4_no_mod8_chart179": {"code": 0x167D00003, "violated": ("Ft_mod8", "exact_char_sums"), "preserved": ("CL3", "RM_2_8", "affine_char_sums")},
}


def fmt_m256(m256: int) -> str:
    """Format a 256-bit Boolean truth table over (z0..z5, s1, s2) in ANF."""
    vec = [(m256 >> x) & 1 for x in range(256)]
    for i in range(8):
        for m in range(256):
            if m & (1 << i):
                vec[m] ^= vec[m ^ (1 << i)]
    names = ["z0", "z1", "z2", "z3", "z4", "z5", "s1", "s2"]
    return "+".join(
        "1" if m == 0 else "*".join(names[i] for i in range(8) if (m >> i) & 1)
        for m, b in enumerate(vec)
        if b
    )


def make_bit_vars(dim: int) -> tuple[int, list[int]]:
    """Build exact 2^dim-bit masks for variables 0..dim-1 using pure Python ints."""
    nbits = 1 << dim
    ones = (1 << nbits) - 1
    out = []
    for i in range(dim):
        half = 1 << i
        cur = ((1 << half) - 1) << half
        step = half << 1
        while step < nbits:
            cur |= cur << step
            step <<= 1
        out.append(cur)
    return ones, out


def l_perp_basis(first: int = FIRST, second: int = SECOND) -> list[int]:
    """Compute a systematic 46-vector GF(2) basis of L^perp in F_2^48."""
    piv0 = first.bit_length() - 1
    row1 = second ^ (first if (second >> piv0) & 1 else 0)
    piv1 = row1.bit_length() - 1
    row0 = first ^ (row1 if (first >> piv1) & 1 else 0)
    basis_perp = []
    for b in range(48):
        if b in (piv0, piv1):
            continue
        vec = 1 << b
        if (row0 >> b) & 1:
            vec ^= 1 << piv0
        if (row1 >> b) & 1:
            vec ^= 1 << piv1
        assert (vec & first).bit_count() & 1 == 0
        assert (vec & second).bit_count() & 1 == 0
        basis_perp.append(vec)
    assert len(basis_perp) == 46
    return basis_perp


def phase_columns(model, basis, code: int) -> tuple[list[int], list[int]]:
    """Return (48-bit phase columns for all 19 phases, 16 fibre sizes) for a 33-bit code."""
    coords = [sum(1 << x for x in range(256) if (x >> i) & 1) for i in (6, 7)]
    tt = xor_terms(basis, code)
    fms = fibre_masks(tt, 256, 4)
    moms = [sub for f in fms for sub in (f, f & coords[0], f & coords[1])]
    cols = [
        sum((((phase & sub).bit_count() & 1) << j) for j, sub in enumerate(moms))
        for phase in model.phases
    ]
    return cols, [f.bit_count() for f in fms]


def stage0_chart_reduction(model, basis, labels) -> dict:
    """Derive chart filtration 256 -> 32 (CL3) -> 28 (RM deg<=2) -> 14 (RM+char_sums) -> 10 orbits."""
    for j in range(33):
        labs = labels(basis[j])
        for z in range(64):
            v00, v01, v10, v11 = labs[z], labs[z + 64], labs[z + 128], labs[z + 192]
            assert (v00 ^ v01 ^ v10 ^ v11) == 0, f"D_s1 D_s2 != 0 at basis[{j}], z={z}"
            if j < 25:
                assert v00 == v01 == v10 == v11, f"basis[{j}] depends on s1/s2 at z={z}"

    # Pure-z deg<=2 RM(2,8) equations depend only on chart c_0..c_7 (because sum_{s1,s2} s_a s_b only retains s1*s2).
    mmasks = moment_masks(8, 2)
    pure_chart_eqs = []
    for out_mask in range(1, 16):
        if out_mask.bit_count() > 2:
            continue
        for _, dm in mmasks:
            for eq in indicator_products(0, basis, out_mask, [dm]):
                if eq and all((m & ((1 << 25) - 1)) == 0 for m in eq):
                    pure_chart_eqs.append([m >> 25 for m in eq])

    def _sat(monos, chart):
        acc = 0
        for m in monos:
            if (chart & m) == m:
                acc ^= 1
        return acc == 0

    cl3 = tuple(c for c in range(256) if all(_sat(ms, c) for ms in pure_chart_eqs))
    expected_cl3 = tuple(
        c for c in range(256) if all((c & p).bit_count() & 1 == 0 for p in CL3_PARITIES)
    )
    assert cl3 == expected_cl3 and len(cl3) == 32

    rm_deg2_valid = []
    rm_char_valid = []
    for c in cl3:
        b_c = xor_terms(basis, c << 25)
        res2 = reduce_phase(b_c, basis[:25], c << 25, [1 << i for i in range(25)], moment_equations(b_c, basis[:25], 1, 2), 3)
        if res2 is None:
            continue
        rm_deg2_valid.append(c)
        sh, ker, _ = affine_consequences(list(character_sums(b_c, basis[:25])), 25)
        if sh is None:
            continue
        b_cs = b_c ^ xor_terms(basis[:25], sh)
        d_cs = [xor_terms(basis[:25], v) for v in ker]
        cd_cs = list(ker)
        res_cs = reduce_phase(b_cs, d_cs, (c << 25) ^ sh, cd_cs, moment_equations(b_cs, d_cs, 1, 2), 3)
        if res_cs is not None:
            rm_char_valid.append(c)

    assert tuple(rm_deg2_valid) == tuple(sorted(CATALOG_CHARTS + NON_CAT_RM_CHARTS))
    assert tuple(rm_char_valid) == CATALOG_CHARTS

    # Verify coordinate/ambient symmetries act cleanly inside C_L3 and partition 14 charts into 10 orbits.
    map_basis = [p for p, _ in model.maps]
    img_m, null_m = image_and_kernel(map_basis)
    img_d, null_d = image_and_kernel(basis)
    assert not null_m and not null_d
    ech_m = sorted(img_m, reverse=True)
    ech_d = sorted(img_d, reverse=True)
    d_in_m = [locate(ech_m, b) for b in basis]
    chart_gens = []
    for _, cols in code_actions(model):
        d_cols = [locate(ech_d, xor_terms(map_basis, xor_terms(cols, cm))) for cm in d_in_m]
        assert all((col >> 25) == 0 for col in d_cols[:25]), "Low bits leaked into chart subspace!"
        chart_gens.append([col >> 25 for col in d_cols[25:]])
    unseen = set(rm_char_valid)
    orbits = []
    for root in rm_char_valid:
        if root not in unseen:
            continue
        orb = {root}
        stack = [root]
        while stack:
            cur = stack.pop()
            for gen in chart_gens:
                nxt = xor_terms(gen, cur)
                if nxt not in orb:
                    orb.add(nxt)
                    stack.append(nxt)
        unseen -= orb
        orbits.append(sorted(orb))
    assert orbits == [[0], [1], [22], [23], [36, 50], [37, 51], [128], [129], [164, 178], [165, 179]]

    return {
        "cl3_count": len(cl3),
        "pure_z_rm_eqs": len(pure_chart_eqs),
        "rm_deg2_valid": rm_deg2_valid,
        "rm_char_valid": rm_char_valid,
        "chart_orbits": orbits,
    }


def stage1_exact_anf_over_cl3(
    model, basis, labels, *, first: int = FIRST, second: int = SECOND
) -> dict:
    """Prove exact deg-2 formula Q_c(u) on ALL 2^30 maps of CL3 x F_2^25 with zero sampling."""
    mons25 = [()]
    for deg in range(1, 5):
        mons25.extend(combinations(range(25), deg))
    idx25 = {m: i for i, m in enumerate(mons25)}

    def mul_linear(poly_int: int, lin_vars: list[int]) -> int:
        res = 0
        x = poly_int
        while x:
            lsb = x & -x
            m = mons25[lsb.bit_length() - 1]
            for v in lin_vars:
                nm = m if v in m else tuple(sorted(m + (v,)))
                res ^= 1 << idx25[nm]
            x ^= lsb
        return res

    # Build exact deg<=4 indicators I_{z,a}(u) for all z in 0..63, a in 0..15.
    i_poly = [[0] * 16 for _ in range(64)]
    for z in range(64):
        dp = [1]
        for b in range(4):
            vs = [j for j in range(25) if (basis[j] >> (256 * b + z)) & 1]
            ndp = []
            for p_prev in dp:
                px = mul_linear(p_prev, vs)
                ndp.append(p_prev ^ px)
                ndp.append(px)
            dp = ndp
        for rev_a, poly in enumerate(dp):
            a = ((rev_a & 1) << 3) | ((rev_a & 2) << 1) | ((rev_a & 4) >> 1) | ((rev_a & 8) >> 3)
            i_poly[z][a] = poly

    cl3 = tuple(
        c for c in range(256) if all((c & p).bit_count() & 1 == 0 for p in CL3_PARITIES)
    )
    l_perp = l_perp_basis(first, second)
    p_bits = [
        [
            [((phase >> (z + 64 * s1 + 128 * s2)) & 1) for s1 in range(2) for s2 in range(2)]
            for z in range(64)
        ]
        for phase in model.phases
    ]

    bad_phase_hits = set()
    bad_row_hits = set()
    for c in cl3:
        labs_c = labels(xor_terms(basis[25:], c))
        pi_c = labs_c[:64]
        d1_c = [labs_c[z] ^ labs_c[z + 64] for z in range(64)]
        d2_c = [labs_c[z] ^ labs_c[z + 128] for z in range(64)]
        c_const = 1 ^ ((c >> 4) & 1)
        expected_q = (1 << idx25[(24,)]) if c_const else 0
        for v in L_BITS:
            expected_q ^= 1 << idx25[tuple(sorted((v, 24)))]

        for k in range(19):
            mom_polys = [0] * 48
            for t in range(16):
                for z in range(64):
                    w00, w01, w10, w11 = p_bits[k][z]
                    a0 = t ^ pi_c[z]
                    d1, d2 = d1_c[z], d2_c[z]
                    if w00:
                        mom_polys[3 * t] ^= i_poly[z][a0]
                    if w01:
                        p01 = i_poly[z][a0 ^ d2]
                        mom_polys[3 * t] ^= p01
                        mom_polys[3 * t + 2] ^= p01
                    if w10:
                        p10 = i_poly[z][a0 ^ d1]
                        mom_polys[3 * t] ^= p10
                        mom_polys[3 * t + 1] ^= p10
                    if w11:
                        p11 = i_poly[z][a0 ^ d1 ^ d2]
                        mom_polys[3 * t] ^= p11
                        mom_polys[3 * t + 1] ^= p11
                        mom_polys[3 * t + 2] ^= p11

            for r_idx, lp in enumerate(l_perp):
                proj = 0
                for j in range(48):
                    if (lp >> j) & 1:
                        proj ^= mom_polys[j]
                if proj:
                    bad_phase_hits.add(k)
                    bad_row_hits.add(r_idx)
                    assert proj == expected_q, (
                        f"ANF mismatch at chart={c}, phase={k}, L_perp_row={r_idx}"
                    )

    assert sorted(bad_phase_hits) == list(BAD_PHASES)
    assert sorted(bad_row_hits) == list(L_PERP_INDICES)
    return {
        "total_maps_proved": len(cl3) * (1 << 25),
        "bad_phases": sorted(bad_phase_hits),
        "bad_l_perp_rows": sorted(bad_row_hits),
    }


def _lin_bit_mask(cb: int, cd: list[int], bit_idx: int, ones: int, va: list[int]) -> int:
    acc = ones if ((cb >> bit_idx) & 1) else 0
    for r, cr in enumerate(cd):
        if (cr >> bit_idx) & 1:
            acc ^= va[r]
    return acc


def verify_catalog_chart(
    chart: int,
    model,
    basis,
    labels,
    *,
    h_bits: tuple[int, ...] = H_BITS,
    z0s1_override: int | None = None,
) -> dict:
    """Certify a single catalog chart purely from decode(1) + RM deg<=2 + |F15|%8==0."""
    assert chart in CATALOG_CHARTS
    c4 = (chart >> 4) & 1
    c_const = 1 ^ c4

    # 1. Verify single explicit RM(2,8) moment equation produces H(u) == c4 directly.
    mmasks = moment_masks(8, 2)
    dom_map = {fmt_m256(m): m for _, m in mmasks}
    out_mask, dom_name = RM_H_CERTS[chart]
    b_c = xor_terms(basis, chart << 25)
    h_mask_expected = sum(1 << v for v in h_bits)
    matched_eqs = [
        eq
        for eq in indicator_products(b_c, basis[:25], out_mask, [dom_map[dom_name]])
        if all(m == 0 or (m & (m - 1)) == 0 for m in eq)
    ]
    assert any(
        sum(m for m in eq if m != 0) == h_mask_expected and ((1 if 0 in eq else 0) == c4)
        for eq in matched_eqs
    ), f"RM H-certificate failed for chart {chart} using {(out_mask, dom_name)}"

    # 2. Exhaustive pure-Python 2^24 bit-sliced verification on the H(u) == c4 hyperplane.
    ones, va = make_bit_vars(24)
    piv_bit = h_bits[0]
    free_bits = [i for i in range(25) if i != piv_bit]
    cb24 = (chart << 25) | ((1 << piv_bit) if c4 else 0)
    cd24 = [((1 << b) | (1 << piv_bit) if (h_mask_expected >> b) & 1 else (1 << b)) for b in free_bits]
    b24 = xor_terms(basis, cb24)
    d24 = [xor_terms(basis, m) for m in cd24]

    m_z0s1 = dom_map["z0*s1"] if z0s1_override is None else z0s1_override
    m_s1s2 = dom_map["s1*s2"]
    chart_labs = labels(b24)
    cnt1 = 0
    cnt2 = 0
    eq_z0s1 = 0
    eq_s1s2 = 0
    for z in range(64):
        hit_t0 = [15 ^ chart_labs[z + 64 * s] for s in range(4)]
        mults_t0 = Counter(hit_t0)
        cs = []
        for k in range(4):
            acc = 0
            for r, dr in enumerate(d24):
                if (dr >> (256 * k + z)) & 1:
                    acc ^= va[r]
            cs.append(acc)
        for a, m in mults_t0.items():
            ind = cs[0] if (a & 1) else (ones ^ cs[0])
            ind &= cs[1] if ((a >> 1) & 1) else (ones ^ cs[1])
            ind &= cs[2] if ((a >> 2) & 1) else (ones ^ cs[2])
            ind &= cs[3] if ((a >> 3) & 1) else (ones ^ cs[3])
            if m == 4:
                cnt2 ^= ind
            elif m == 2:
                cnt2 ^= cnt1 & ind
                cnt1 ^= ind
            else:
                raise AssertionError(f"Non-collinear multiplicity {m} in chart {chart}")
            coeff = 0
            coeff_s1s2 = 0
            for s in range(4):
                if hit_t0[s] == a:
                    if (m_z0s1 >> (z + 64 * s)) & 1:
                        coeff ^= 1
                    if chart == 0 and ((m_s1s2 >> (z + 64 * s)) & 1):
                        coeff_s1s2 ^= 1
            if coeff:
                eq_z0s1 ^= ind
            if coeff_s1s2:
                eq_s1s2 ^= ind

    u24 = _lin_bit_mask(cb24, cd24, 24, ones, va)
    l_form = ones if c_const else 0
    for v in L_BITS:
        l_form ^= _lin_bit_mask(cb24, cd24, v, ones, va)
    q_arr = u24 & l_form
    assert cnt1 == 0, f"bit1(|F15|) != 0 on chart {chart}"
    assert (q_arr ^ cnt2 ^ eq_z0s1) == 0, (
        f"Universal Stage-2 identity failed on chart {chart}!"
    )

    # Ground-truth spot check against independent fibre_masks + phase_columns on sample maps.
    if z0s1_override is None and h_bits == H_BITS:
        lp0 = l_perp_basis()[L_PERP_INDICES[0]]
        for y in (0, 1, 2, 1 << 23):
            code = cb24 ^ xor_terms(cd24, y)
            f15 = fibre_masks(xor_terms(basis, code), 256, 4)[15]
            sz = f15.bit_count()
            assert ((sz >> 1) & 1) == ((cnt1 >> y) & 1)
            assert ((sz >> 2) & 1) == ((cnt2 >> y) & 1)
            assert ((f15 & m_z0s1).bit_count() & 1) == ((eq_z0s1 >> y) & 1)
            cols, _ = phase_columns(model, basis, code)
            for k in range(19):
                got = (cols[k] & lp0).bit_count() & 1
                exp = ((q_arr >> y) & 1) if k in BAD_PHASES else 0
                assert got == exp

    extra = {}
    if chart == 0:
        # Class 0 stronger closures: (i) linear u24 == 0 under RM+char_sums, (ii) RM-only bit2(|F15|) == <1_{F15}, s1*s2>.
        assert cnt2 == eq_s1s2, "Chart 0 bit2(|F15|) != <1_F15, s1*s2>!"
        extra["class0_rm_only_bit2_eq_s1s2"] = True
        sh, ker, _ = affine_consequences(list(character_sums(b_c, basis[:25])), 25)
        b_cs = b_c ^ xor_terms(basis[:25], sh)
        d_cs = [xor_terms(basis[:25], v) for v in ker]
        _, _, cb_rc, cd_rc, _ = reduce_phase(
            b_cs, d_cs, sh, list(ker), moment_equations(b_cs, d_cs, 1, 4), 5
        )
        assert (cb_rc >> 24) & 1 == 0 and all(((v >> 24) & 1) == 0 for v in cd_rc)
        extra["class0_rm_char_linear_u24_zero"] = True

    return {
        "chart": chart,
        "status": "closed_by_identity",
        "c_const": c_const,
        "c4": c4,
        "rm_h_cert": {"out_mask": out_mask, "dom_mask": dom_name, "rhs": c4},
        "verified_maps_in_H_slice": 1 << 24,
        "residual_enumeration": 0,
        "survivors": 0,
        "witness": None,
        "extra": extra,
    }


def verify_non_catalog_rm_chart(chart: int, basis) -> dict:
    """Verify non-catalog RM-valid chart closes by char_sums AND (without char_sums) by all |Ft|%8==0."""
    assert chart in NON_CAT_RM_CHARTS
    b_c = xor_terms(basis, chart << 25)
    sh, ker, _ = affine_consequences(list(character_sums(b_c, basis[:25])), 25)
    if sh is not None:
        b_cs = b_c ^ xor_terms(basis[:25], sh)
        d_cs = [xor_terms(basis[:25], v) for v in ker]
        res_cs = reduce_phase(b_cs, d_cs, (chart << 25) ^ sh, list(ker), moment_equations(b_cs, d_cs, 1, 4), 5)
        assert res_cs is None, f"Unexpected RM+char_sums survivor on chart {chart}"

    res2 = reduce_phase(b_c, basis[:25], chart << 25, [1 << i for i in range(25)], moment_equations(b_c, basis[:25], 1, 2), 3)
    b, d, cb, cd, _ = res2
    res4 = reduce_phase(b, d, cb, cd, moment_equations(b, d, 1, 4), 5)
    assert res4 is not None
    b4, d4, cb4, cd4, nonlin = res4
    dim = len(d4)
    ones, va = make_bit_vars(dim)
    monos = {0: ones}
    for i in range(dim):
        monos[1 << i] = va[i]

    def gm(mask: int) -> int:
        if mask not in monos:
            low = mask & -mask
            monos[mask] = monos[low] & gm(mask ^ low)
        return monos[mask]

    rm_ok = ones
    for eq in sorted(nonlin, key=len):
        acc = 0
        for m in eq:
            acc ^= gm(m)
        rm_ok &= ones ^ acc

    survivors = 0
    x = rm_ok
    while x:
        lsb = x & -x
        x ^= lsb
        y = lsb.bit_length() - 1
        code = cb4 ^ xor_terms(cd4, y)
        if all((f.bit_count() & 7) == 0 for f in fibre_masks(xor_terms(basis, code), 256, 4)):
            survivors += 1
    assert survivors == 0
    return {
        "chart": chart,
        "status": "closed_non_catalog_rm_chart",
        "rm_dim": dim,
        "rm_survivors": rm_ok.bit_count(),
        "rm_plus_all_mod8_survivors": survivors,
        "char_sums_infeasible": True,
        "residual_enumeration": 0,
        "survivors": 0,
        "witness": None,
    }


def verify_chart_slice(chart: int, model, basis, labels) -> dict:
    """Verify any chart c in 0..255 deterministically without loading a catalog."""
    if chart in CATALOG_CHARTS:
        return verify_catalog_chart(chart, model, basis, labels)
    if chart in NON_CAT_RM_CHARTS:
        return verify_non_catalog_rm_chart(chart, basis)
    cl3_ok = all((chart & p).bit_count() & 1 == 0 for p in CL3_PARITIES)
    if not cl3_ok:
        return {"chart": chart, "status": "infeasible_stage0_pure_z_rm", "survivors": 0, "witness": None}
    b_c = xor_terms(basis, chart << 25)
    res2 = reduce_phase(b_c, basis[:25], chart << 25, [1 << i for i in range(25)], moment_equations(b_c, basis[:25], 1, 2), 3)
    assert res2 is None and chart in INFEASIBLE_CL3_CHARTS
    return {"chart": chart, "status": "infeasible_rm_deg2", "survivors": 0, "witness": None}


def audit_witnesses(model, basis) -> dict:
    """Verify every preserved relaxation witness is decodable and fails L under its exact relaxation."""
    plane = {0, FIRST, SECOND, FIRST ^ SECOND}
    mmasks = moment_masks(8, 2)
    affine_cs_cache: dict[int, tuple[int | None, list[tuple[int, int]]]] = {}
    summary = {}
    for name, spec in RELAXATION_WITNESSES.items():
        code = spec["code"]
        chart = code >> 25
        u_low = code & ((1 << 25) - 1)
        tt = xor_terms(basis, code)
        fms = fibre_masks(tt, 256, 4)
        sizes = [f.bit_count() for f in fms]
        rm_fail = any(
            ((ft & m).bit_count() & 1) != 0
            for ft in fms
            for _, m in mmasks
        )
        exact_cs_fail = any(
            val != 0 for _, _, spec_cs in character_sums(tt, []) for val in spec_cs.values()
        )
        if chart not in affine_cs_cache:
            b_c = xor_terms(basis, chart << 25)
            sh, ker, _ = affine_consequences(list(character_sums(b_c, basis[:25])), 25)
            ech_k = sorted(image_and_kernel(ker)[0], reverse=True) if sh is not None else []
            affine_cs_cache[chart] = (sh, ech_k)
        sh, ech_k = affine_cs_cache[chart]
        if sh is None:
            affine_cs_fail = True
        else:
            rem = u_low ^ sh
            for vec, _ in ech_k:
                if (rem >> (vec.bit_length() - 1)) & 1:
                    rem ^= vec
            affine_cs_fail = rem != 0
        cols, _ = phase_columns(model, basis, code)
        in_plane = all(col in plane for col in cols)
        cl3_ok = all((chart & p).bit_count() & 1 == 0 for p in CL3_PARITIES)
        assert not in_plane, f"Witness {name} unexpectedly landed in L!"
        if "RM_2_8" in spec.get("preserved", ()):
            assert not rm_fail
        if "RM_2_8" in spec["violated"]:
            assert rm_fail
        if "char_sums" in spec.get("preserved", ()):
            assert not exact_cs_fail
        if "affine_char_sums" in spec.get("preserved", ()):
            assert not affine_cs_fail
        if "exact_char_sums" in spec["violated"]:
            assert exact_cs_fail
        if "size16_all" in spec.get("preserved", ()):
            assert all(s == 16 for s in sizes)
        if "F15_mod8" in spec.get("preserved", ()):
            assert (sizes[15] & 7) == 0
        if "CL3" in spec.get("preserved", ()):
            assert cl3_ok
        summary[name] = {
            "code": hex(code),
            "chart": chart,
            "cl3_ok": cl3_ok,
            "rm_fail": rm_fail,
            "affine_cs_fail": affine_cs_fail,
            "exact_cs_fail": exact_cs_fail,
            "sizes_mod8": [s & 7 for s in sizes],
            "in_plane": in_plane,
        }
    return summary


def run_negative_tests(model, basis, labels) -> None:
    """Verify the verifier catches injected corruptions in L, H(u), and m(x)."""
    # 1. Corrupt L basis vector in Stage 1 on CL3.
    caught_l = False
    try:
        stage1_exact_anf_over_cl3(model, basis, labels, first=FIRST ^ 1)
    except AssertionError:
        caught_l = True
    assert caught_l, "Failed to detect corrupted L plane!"

    # 2. Corrupt H(u) mask on pilot Class 164.
    caught_h = False
    try:
        verify_catalog_chart(164, model, basis, labels, h_bits=H_BITS[:-1])
    except AssertionError:
        caught_h = True
    assert caught_h, "Failed to detect corrupted H(u) certificate!"

    # 3. Corrupt z0*s1 domain mask on Class 129.
    caught_m = False
    try:
        m_z0s1 = moment_masks(8, 2)[14][1]
        verify_catalog_chart(129, model, basis, labels, z0s1_override=m_z0s1 ^ 1)
    except AssertionError:
        caught_m = True
    assert caught_m, "Failed to detect corrupted support mask <1_F15, z0*s1>!"


def verify_catalog_control(catalog_path: Path, model, basis) -> dict:
    """Post-hoc coverage check across all 113,040 supports in mapas_V1.txt."""
    raw = catalog_path.read_bytes()
    sha256 = hashlib.sha256(raw).hexdigest()
    codes = [int(line) for line in raw.splitlines()]
    plane = {0, FIRST, SECOND, FIRST ^ SECOND}
    h_mask = sum(1 << v for v in H_BITS)
    l_mask = sum(1 << v for v in L_BITS)
    coords = [sum(1 << x for x in range(256) if (x >> i) & 1) for i in (6, 7)]
    charts_seen = Counter()
    for code in codes:
        chart = code >> 25
        assert chart in CATALOG_CHARTS, f"Catalog code outside 14 charts: {hex(code)}"
        c4 = (chart >> 4) & 1
        assert ((code & h_mask).bit_count() & 1) == c4
        u24 = (code >> 24) & 1
        q_val = u24 & ((1 ^ c4) ^ ((code & l_mask).bit_count() & 1))
        assert q_val == 0
        fms = fibre_masks(xor_terms(basis, code), 256, 4)
        assert all(f.bit_count() == 16 for f in fms)
        moms = [sub for f in fms for sub in (f, f & coords[0], f & coords[1])]
        for phase in model.phases:
            col = sum((((phase & sub).bit_count() & 1) << j) for j, sub in enumerate(moms))
            assert col in plane
        charts_seen[chart] += 1
    assert sum(charts_seen.values()) == len(codes)
    return {"catalog_sha256": sha256, "total_codes": len(codes), "charts": dict(sorted(charts_seen.items()))}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--chart", type=int, choices=range(256), help="Verify a single chart 0..255 and emit JSON")
    parser.add_argument("--charts", type=int, nargs="+", help="Verify specific charts")
    parser.add_argument("--all", action="store_true", help="Run Stage 0, Stage 1 (2^30), all 28 RM charts, witnesses, and negative tests")
    parser.add_argument("--core", action="store_true", help="Run Stage 0, Stage 1 (2^30), and witness audit (without full 2^24 chart sweep)")
    parser.add_argument("--negative-test", action="store_true", help="Run self-tests for wrong certificate detection")
    parser.add_argument("--catalog", type=Path, help="Optional post-hoc mapas_V1.txt coverage check")
    parser.add_argument("--output", type=Path, help="Optional JSON output path")
    args = parser.parse_args()

    t0 = perf_counter()
    model, basis, labels = decode(1)
    report: dict = {}

    if args.chart is not None:
        report = verify_chart_slice(args.chart, model, basis, labels)
    elif args.charts:
        report = {"charts": [verify_chart_slice(c, model, basis, labels) for c in args.charts]}
    elif args.core:
        report["stage0"] = stage0_chart_reduction(model, basis, labels)
        report["stage1"] = stage1_exact_anf_over_cl3(model, basis, labels)
        report["witnesses"] = audit_witnesses(model, basis)
    else:
        report["stage0"] = stage0_chart_reduction(model, basis, labels)
        report["stage1"] = stage1_exact_anf_over_cl3(model, basis, labels)
        report["stage2_catalog"] = [verify_catalog_chart(c, model, basis, labels) for c in CATALOG_CHARTS]
        if args.all:
            report["stage2_non_catalog"] = [verify_non_catalog_rm_chart(c, basis) for c in NON_CAT_RM_CHARTS]
        report["witnesses"] = audit_witnesses(model, basis)

    if args.all or args.negative_test:
        run_negative_tests(model, basis, labels)
        report["negative_tests_passed"] = True

    if args.catalog is not None:
        report["catalog_control"] = verify_catalog_control(args.catalog, model, basis)

    report["elapsed_s"] = round(perf_counter() - t0, 3)
    text = json.dumps(report, indent=2) + "\n"
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    else:
        print(text, end="")


if __name__ == "__main__":
    main()
