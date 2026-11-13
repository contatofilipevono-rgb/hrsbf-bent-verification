"""Build and verify short, auditable certificates for the 37 residual phase tasks of plane <21, 42> (space 3)."""
import argparse
import hashlib
import itertools
import json
import struct
from collections import Counter
from pathlib import Path
from time import perf_counter

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import shift, solve, xor_terms
from higher_project import signs_to_walsh
from line_phase_algebra import locate, mod8_bit, quadratic_moments, signature_possible
from lower_dim_model import active_indices, anf, build
from lower_dim_phase_prepare import preceding_spaces, prepare, truth_on_coordinates
from lower_dim_phase_verify import records
from lower_dim_plan import BASES
from lower_dim_v3_symbolic import echelon, gauss_sum, product, read_tasks


EXPECTED_HASHES = {
    "support.bin": "94942d314880be41e72bb218c98211c3842adccbee3cd0891e6d20f06191f00b",
    "support.json": "41f89b5c5811e3da8a0faf81a2d5d455d1a893135829badd31e33e8e5fc3d8f6",
    "orbits.bin": "c979409220dee862792715c7d33d98b6f0f83e7881a907e85f76d384e070b517",
    "orbits.json": "14b53d2d8546ada9c0f3549a012e527d1dd727c4be237cbfea0de0b34756f981",
    "orbits.weights.bin": "419a6234c9140289040ac48677ee0cb75fec8f0c8c38cee8867837dc232fe1a2",
    "tasks.json": "5b5d93b5562c6cbda0eb9ca304ade1b6d8974d032eb8699507b4b9bb441b6d99",
    "result.json": "46a53100ce98db8b7e7d8a56f210735287d6690dcf1554c6664a6d2b9c1db3e6",
    "result.witnesses.bin": "24f5094481c930b8b5b8e610b36a701bc68c2f82643c050dbb9ac8ef5df029be",
    "tasks_reconstructed.bin": "9a9689d8b7934ede01c4da2625a4f7f9081302daef12fd14b1b57de00378876f",
    "shifts.json": "fab089aa632bceece3bcc1a77e3ee4aa20061a2a90ba392fa6a6fea42ab590c0",
}

POSITIVE_CODES = (1, 19, 822549, 115044639, 115044803, 202149121)


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def ensure_reconstructed_inputs(artifacts_dir: Path) -> dict:
    tasks_bin = artifacts_dir / "tasks_reconstructed.bin"
    shifts_json = artifacts_dir / "shifts.json"
    if not tasks_bin.exists() or not shifts_json.exists():
        prepare(3, artifacts_dir / "orbits.bin", tasks_bin, 0, None, shifts_json)
    hashes = {}
    for name, expected in EXPECTED_HASHES.items():
        fpath = artifacts_dir / name
        if fpath.exists() and (not name.endswith(".json") or name == "shifts.json"):
            actual = sha256_file(fpath)
            assert actual == expected, f"SHA-256 mismatch for {name}: {actual} != {expected}"
            hashes[name] = actual
    return hashes


def reduce_quadratics_cpp(root, sig, directions, moments):
    """Exact Python translation of reduce_quadratics in lower_dim_phase_count.cpp."""
    d = len(directions)
    basis = {}
    for subset, modulus_mask, residue in moments:
        row = 0
        if (((root & subset).bit_count() ^ residue) & 2) != 0:
            row |= 1 << 0
        for i in range(d):
            di_val = directions[i][0]
            if (((di_val & subset).bit_count() >> 1) & 1) ^ ((root & di_val & subset).bit_count() & 1):
                row |= 1 << (1 + i)
        k = 1 + d
        for i in range(d):
            di_val = directions[i][0] & subset
            for j in range(i + 1, d):
                if (di_val & directions[j][0]).bit_count() & 1:
                    row |= 1 << k
                k += 1
        while row:
            p = row.bit_length() - 1
            if p == 0:
                return None
            if p not in basis:
                basis[p] = row
                break
            row ^= basis[p]

    particular = 0
    null = []
    constant = 1
    for i in range(1, d + 1):
        if i not in basis:
            null.append(1 << i)
            continue
        equation = basis[i] & ((1 << 64) - 1)
        if (equation & (particular | constant)).bit_count() & 1:
            particular |= 1 << i
        for idx in range(len(null)):
            if (equation & null[idx]).bit_count() & 1:
                null[idx] |= 1 << i
    if len(null) == d:
        return root, sig, directions
    for i in range(d):
        if particular & (1 << (i + 1)):
            root ^= directions[i][0]
            sig ^= directions[i][1]
    moved = []
    for v in null:
        p_val = 0
        p_sig = 0
        for i in range(d):
            if v & (1 << (i + 1)):
                p_val ^= directions[i][0]
                p_sig ^= directions[i][1]
        moved.append((p_val, p_sig))
    return root, sig, moved


def run_initial_quadratic_elimination(root, signature, directions, moments):
    cur_root, cur_sig, cur_dirs = root, signature, list(directions)
    while True:
        before = len(cur_dirs)
        res = reduce_quadratics_cpp(cur_root, cur_sig, cur_dirs, moments)
        if res is None:
            return None
        cur_root, cur_sig, cur_dirs = res
        if len(cur_dirs) == before:
            return cur_root, cur_sig, cur_dirs


def mod16_bit_poly(root, directions, support, target, check_preconditions=False):
    """Exact polynomial in F_2[x_0..x_{d-1}]/(x_i^2+x_i) for bit 3 of weight(h & support) == target (mod 16),
    computed as bit 2 of U(x) = (weight(x) - target) // 2 mod 8 via 3-bit carry addition."""
    restricted = [h & support for h in directions]

    def imbalance(points):
        return points.bit_count() - 2 * (points & root).bit_count()

    offset = (root & support).bit_count() - target
    assert offset % 2 == 0
    entries = []
    if (offset // 2) % 8:
        entries.append((0, (offset // 2) % 8))
    for i, h in enumerate(restricted):
        assert imbalance(h) % 2 == 0
        c = (imbalance(h) // 2) % 8
        if c:
            entries.append((1 << i, c))
    for i, j in itertools.combinations(range(len(restricted)), 2):
        c = (-imbalance(restricted[i] & restricted[j])) % 8
        if c:
            entries.append(((1 << i) | (1 << j), c))
    for i, j, k in itertools.combinations(range(len(restricted)), 3):
        c = (2 * imbalance(restricted[i] & restricted[j] & restricted[k])) % 8
        if c:
            entries.append(((1 << i) | (1 << j) | (1 << k), c))
    for i, j, k, l in itertools.combinations(range(len(restricted)), 4):
        if (restricted[i] & restricted[j] & restricted[k] & restricted[l]).bit_count() & 1:
            entries.append(((1 << i) | (1 << j) | (1 << k) | (1 << l), 4))

    b0, b1, b2 = set(), set(), set()
    for m, c in entries:
        term = {m}
        if c & 1:
            c1 = product(term, b0)
            c2 = product(c1, b1)
            b0 ^= term
            b1 ^= c1
            b2 ^= c2
        if c & 2:
            c2 = product(term, b1)
            b1 ^= term
            b2 ^= c2
        if c & 4:
            b2 ^= term
    return b2


def regenerate_single_equation(desc, root, sig, phases, sigs, moments, properties):
    """Regenerate a single polynomial equation from its descriptor and verify preconditions."""
    d = len(phases)
    eq_type = desc["type"]
    if eq_type == "signature_identically_zero":
        p = desc["property"]
        assert 0 <= p < properties
        for i in range(64 * p, 64 * p + 64):
            assert ((sig >> i) & 1) == 0
            assert all(((v >> i) & 1) == 0 for v in sigs)
        return {0}
    if eq_type == "signature_rank1":
        p = desc["property"]
        bit_idx = desc["bit"]
        assert 0 <= p < properties and 0 <= bit_idx < 64
        full_bit = 64 * p + bit_idx
        target_mask = sum(((v >> full_bit) & 1) << j for j, v in enumerate(sigs))
        target_c = (sig >> full_bit) & 1
        assert target_mask or target_c
        for i in range(64 * p, 64 * p + 64):
            m = sum(((v >> i) & 1) << j for j, v in enumerate(sigs))
            c = (sig >> i) & 1
            if m or c:
                assert (m, c) == (target_mask, target_c), "Rank-1 signature precondition failed"
        poly = {1 << j for j in range(d) if (target_mask >> j) & 1}
        if not target_c:
            poly.add(0)
        return poly
    if eq_type == "mod4":
        m_idx = desc["moment_index"]
        subset, mask, residue = moments[m_idx]
        assert mask >= 3
        base = root & subset
        restricted = [direction & subset for direction in phases]
        assert ((base.bit_count() ^ residue) & 1) == 0
        assert all((r.bit_count() & 1) == 0 for r in restricted)
        row = {0} if ((base.bit_count() ^ residue) & 2) else set()
        for i, direction in enumerate(restricted):
            if ((direction.bit_count() >> 1) ^ (base & direction).bit_count()) & 1:
                row.add(1 << i)
        for i, j in itertools.combinations(range(d), 2):
            if (restricted[i] & restricted[j]).bit_count() & 1:
                row.add((1 << i) | (1 << j))
        return row
    if eq_type == "mod8":
        m_idx = desc["moment_index"]
        subset, mask, target = moments[m_idx]
        assert mask >= 7
        eq = mod8_bit(root, phases, subset, target)
        assert eq, "Mod 8 equation empty or precondition not met"
        return eq
    if eq_type == "mod16":
        m_idx = desc["moment_index"]
        subset, mask, target = moments[m_idx]
        assert mask >= 15
        eq = mod16_bit_poly(root, phases, subset, target, check_preconditions=True)
        assert eq, "Mod 16 equation empty or precondition not met"
        return eq
    raise ValueError(f"Unknown equation descriptor type: {eq_type}")


def build_all_equations(root, sig, phases, sigs, moments, properties):
    d = len(phases)
    labeled = []
    for p in range(properties):
        rows = []
        for i in range(64 * p, 64 * p + 64):
            mask = sum(((v >> i) & 1) << j for j, v in enumerate(sigs))
            c = (sig >> i) & 1
            if mask or c:
                rows.append((i - 64 * p, mask, c))
        if not rows:
            labeled.append(({"type": "signature_identically_zero", "property": p}, {0}))
            continue
        origin, _, rank = solve([(m, c) for _, m, c in rows], d)
        if origin is not None and rank == 1:
            bit_idx, mask, c = rows[0]
            poly = {1 << j for j in range(d) if (mask >> j) & 1}
            if not c:
                poly.add(0)
            labeled.append(({"type": "signature_rank1", "property": p, "bit": bit_idx}, poly))

    for m_idx, (subset, mask, residue) in enumerate(moments):
        if mask < 3:
            continue
        base = root & subset
        restricted = [direction & subset for direction in phases]
        row = {0} if ((base.bit_count() ^ residue) & 2) else set()
        for i, direction in enumerate(restricted):
            if ((direction.bit_count() >> 1) ^ (base & direction).bit_count()) & 1:
                row.add(1 << i)
        for i, j in itertools.combinations(range(d), 2):
            if (restricted[i] & restricted[j]).bit_count() & 1:
                row.add((1 << i) | (1 << j))
        if row:
            labeled.append(({"type": "mod4", "moment_index": m_idx}, row))

    for m_idx, (subset, mask, target) in enumerate(moments):
        if mask >= 7:
            eq = mod8_bit(root, phases, subset, target)
            if eq:
                labeled.append(({"type": "mod8", "moment_index": m_idx}, eq))

    for m_idx, (subset, mask, target) in enumerate(moments):
        if mask >= 15:
            b3 = mod16_bit_poly(root, phases, subset, target, check_preconditions=False)
            if b3:
                labeled.append(({"type": "mod16", "moment_index": m_idx}, b3))

    return labeled


def echelon_dag_step(labeled_eqs, d, allow_deg2_for_contradiction=False):
    basis = {}
    gen_nodes = []
    memo = {}

    def unpack_node(k):
        if k not in memo:
            kind = gen_nodes[k][0]
            if kind == "base":
                memo[k] = {(gen_nodes[k][1], 0)}
            else:
                _, parent_w, var_i = gen_nodes[k]
                parent_set = unpack_mask(parent_w)
                res = set()
                bit = 1 << var_i
                for eq_idx, m0 in parent_set:
                    res.symmetric_difference_update(((eq_idx, m0 | bit),))
                memo[k] = res
        return memo[k]

    def unpack_mask(gen_mask):
        res = set()
        m = gen_mask
        while m:
            lsb = m & -m
            idx = lsb.bit_length() - 1
            res ^= unpack_node(idx)
            m ^= lsb
        return res

    def insert(poly, node_desc):
        row = set(poly)
        g_idx = len(gen_nodes)
        gen_nodes.append(node_desc)
        w = 1 << g_idx
        while row:
            leading = max(row, key=lambda m: (m.bit_count(), m))
            if leading not in basis:
                basis[leading] = (row, w)
                return leading == 0
            b_row, b_w = basis[leading]
            row ^= b_row
            w ^= b_w
        return False

    for idx, (_, poly) in enumerate(labeled_eqs):
        if insert(poly, ("base", idx)):
            return "contradiction", unpack_mask(basis[0][1])

    if allow_deg2_for_contradiction:
        snapshot = [(m, set(row), w) for m, (row, w) in basis.items() if m.bit_count() == 1]
        for _, row, w in snapshot:
            for i in range(d):
                bit = 1 << i
                lifted_row = set()
                for m in row:
                    lifted_row.symmetric_difference_update((m | bit,))
                if insert(lifted_row, ("lift", w, i)):
                    return "contradiction", unpack_mask(basis[0][1])
        return "unresolved", None

    lin = [(row, unpack_mask(w)) for m, (row, w) in basis.items() if m.bit_count() == 1]
    if lin:
        return "linear", lin

    if all(m.bit_count() >= 2 for row, _ in basis.values() for m in row):
        return "stabilized", None

    for _ in range(2):
        before = len(basis)
        snapshot = [(m, set(row), w)
                    for m, (row, w) in basis.items()
                    if max(x.bit_count() for x in row) <= 2]
        for _, row, w in snapshot:
            for i in range(d):
                bit = 1 << i
                lifted_row = set()
                for m in row:
                    lifted_row.symmetric_difference_update((m | bit,))
                if insert(lifted_row, ("lift", w, i)):
                    return "contradiction", unpack_mask(basis[0][1])
        lin = [(row, unpack_mask(w)) for m, (row, w) in basis.items() if m.bit_count() == 1]
        if lin:
            return "linear", lin
        if len(basis) == before:
            break
    return "stabilized", None


def pack_witness_terms(labeled_eqs, terms_set):
    """Pack a set of (eq_idx, mono) pairs into a compact list of starting equations + multiplier polynomials."""
    by_eq = {}
    for eq_idx, mono in terms_set:
        by_eq.setdefault(eq_idx, set()).add(mono)
    items = []
    for eq_idx in sorted(by_eq):
        desc, poly = labeled_eqs[eq_idx]
        mult = sorted(by_eq[eq_idx])
        items.append({
            "source": desc,
            "equation_monomials": sorted(poly),
            "multiplier_monomials": mult,
        })
    return items


def find_farkas_witness(sg, ss, prop_idx):
    basis = {}
    for i in range(64):
        bit_pos = 64 * prop_idx + i
        vec = sum(((s >> bit_pos) & 1) << j for j, s in enumerate(ss))
        c = (sg >> bit_pos) & 1
        comb = 1 << i
        while vec:
            piv = vec & -vec
            if piv not in basis:
                basis[piv] = (vec, c, comb)
                break
            b_vec, b_c, b_comb = basis[piv]
            vec ^= b_vec
            c ^= b_c
            comb ^= b_comb
        if vec == 0 and c == 1:
            return comb
    return None


def eval_poly(poly, y_mask):
    acc = 0
    for m in poly:
        if (y_mask & m) == m:
            acc ^= 1
    return acc


def build_certificates(artifacts_dir: Path, output_path: Path):
    t_start = perf_counter()
    hashes = ensure_reconstructed_inputs(artifacts_dir)
    tasks_path = artifacts_dir / "tasks_reconstructed.bin"
    weights = dict(struct.iter_unpack("<QQ", (artifacts_dir / "orbits.weights.bin").read_bytes()))
    shifts = json.loads((artifacts_dir / "shifts.json").read_text(encoding="utf-8"))
    native_witnesses = records(artifacts_dir / "result.witnesses.bin", 128)
    model = build(BASES[2])
    maps = [p for p, _ in model.maps]

    all_task_codes = []
    quadratic_eliminated_codes = []
    residual_hist = Counter()
    residual_certificates = []

    for task_idx, (code, multiplier, properties, root, signature, directions, moments) in enumerate(read_tasks(tasks_path)):
        all_task_codes.append(code)
        res = run_initial_quadratic_elimination(root, signature, directions, moments)
        if res is None:
            quadratic_eliminated_codes.append(code)
            continue

        cur_root, cur_sig, cur_dirs = res
        d_res = len(cur_dirs)
        residual_hist[d_res] += 1
        phases = [p for p, _ in cur_dirs]
        sigs = [s for _, s in cur_dirs]
        orbit_size = weights[code]
        residual_rank = len(residual_certificates)

        if code not in POSITIVE_CODES:
            labeled = build_all_equations(cur_root, cur_sig, phases, sigs, moments, properties)
            status, terms_set = echelon_dag_step(labeled, d_res, allow_deg2_for_contradiction=True)
            assert status == "contradiction", f"Negative task {code} did not yield contradiction"
            witness_items = pack_witness_terms(labeled, terms_set)
            max_mult_deg = max(m.bit_count() for item in witness_items for m in item["multiplier_monomials"])
            residual_certificates.append({
                "residual_rank": residual_rank,
                "task_index": task_idx,
                "map_code": code,
                "orbit_size": orbit_size,
                "shift_kernel_dimension": multiplier,
                "initial_dimension": len(directions),
                "residual_dimension": d_res,
                "status": "negative",
                "certificate_kind": "hilbert_nullstellensatz_1_eq_0",
                "num_witness_equations": len(witness_items),
                "max_multiplier_degree": max_mult_deg,
                "witness_terms": witness_items,
            })
        else:
            sig_1_4 = [s >> 64 for s in sigs]
            image, kernel = image_and_kernel(sig_1_4)
            image = sorted(image, reverse=True)
            kernel_phases = [xor_terms(phases, x) for x in kernel]
            kernel_sigs = [xor_terms(sigs, x) for x in kernel]
            cases = sorted(all_points([v for v, _ in image]))

            coset_certs = []
            total_quot = 0
            first_witness_info = None

            for c_idx, disp in enumerate(cases):
                rep = locate(image, disp)
                ph = cur_root ^ xor_terms(phases, rep)
                sg = cur_sig ^ xor_terms(sigs, rep)
                ds = list(kernel_phases)
                ss = list(kernel_sigs)
                reduction_rounds = []
                is_empty = False
                empty_witness = None

                while True:
                    d_k = len(ds)
                    labeled = build_all_equations(ph, sg, ds, ss, moments, properties)
                    status, payload = echelon_dag_step(labeled, d_k, allow_deg2_for_contradiction=False)
                    if status == "contradiction":
                        is_empty = True
                        empty_witness = pack_witness_terms(labeled, payload)
                        break
                    elif status == "linear":
                        sh, fr, _ = solve([(sum(m for m in q if m), int(0 in q)) for q, _ in payload], d_k)
                        assert sh is not None
                        round_eqs = []
                        for l_poly, l_terms in payload:
                            round_eqs.append({
                                "linear_monomials": sorted(l_poly),
                                "witness_terms": pack_witness_terms(labeled, l_terms),
                            })
                        reduction_rounds.append({
                            "start_dimension": d_k,
                            "next_dimension": len(fr),
                            "shift_mask": sh,
                            "free_basis": fr,
                            "linear_equations": round_eqs,
                        })
                        ph ^= xor_terms(ds, sh)
                        sg ^= xor_terms(ss, sh)
                        ds = [xor_terms(ds, x) for x in fr]
                        ss = [xor_terms(ss, x) for x in fr]
                    else:
                        break

                if is_empty:
                    coset_certs.append({
                        "coset_index": c_idx,
                        "representative_mask": rep,
                        "status": "empty",
                        "reduction_rounds": reduction_rounds,
                        "contradiction_witness": empty_witness,
                        "quotient_count": 0,
                    })
                    continue

                farkas_masks = []
                for p in range(properties):
                    w_p = find_farkas_witness(sg, ss, p)
                    assert w_p is not None
                    farkas_masks.append(hex(w_p))

                labeled_final = build_all_equations(ph, sg, ds, ss, moments, properties)
                q_polys = [poly for _, poly in labeled_final if max(m.bit_count() for m in poly) <= 2]
                piv = echelon(q_polys)
                q_basis = [sorted(row) for row in piv.values()]

                sums = []
                poly_u = set()
                for ordinal in range(1 << len(q_basis)):
                    if ordinal:
                        poly_u ^= set(q_basis[(ordinal & -ordinal).bit_length() - 1])
                    val, rnk = gauss_sum(len(ds), poly_u)
                    sums.append({"sum": val, "rank": rnk})
                cnt = sum(item["sum"] for item in sums) // (1 << len(q_basis))
                total_quot += cnt

                if first_witness_info is None and cnt > 0:
                    y_sol = next(y for y in range(1 << len(ds)) if all(eval_poly(q, y) == 0 for q in q_basis))
                    w_phase = ph ^ xor_terms(ds, y_sol)
                    mapping = xor_terms(maps, code)
                    moved = truth_on_coordinates(mapping, w_phase, len(model.basis))
                    truth = sum(1 << model.coordinates[x] for x in active_indices(moved))
                    anf_mons = list(active_indices(anf(truth, 12)))
                    first_witness_info = {
                        "coset_index": c_idx,
                        "final_coords_mask": y_sol,
                        "phase_hex": hex(w_phase),
                        "anf_monomials": anf_mons,
                    }

                coset_certs.append({
                    "coset_index": c_idx,
                    "representative_mask": rep,
                    "status": "nonempty",
                    "reduction_rounds": reduction_rounds,
                    "final_dimension": len(ds),
                    "farkas_property_witnesses": farkas_masks,
                    "quadratic_basis": q_basis,
                    "gauss_sums": sums,
                    "quotient_count": cnt,
                })

            phases_per_map = total_quot << multiplier
            assert native_witnesses[code][0] == phases_per_map
            shift_vecs = shifts[str(code)]
            assert len(shift_vecs) == multiplier
            residual_certificates.append({
                "residual_rank": residual_rank,
                "task_index": task_idx,
                "map_code": code,
                "orbit_size": orbit_size,
                "shift_kernel_dimension": multiplier,
                "shift_basis_hex": shift_vecs,
                "initial_dimension": len(directions),
                "residual_dimension": d_res,
                "status": "positive",
                "certificate_kind": "polar_coset_quadratic_gauss_sum",
                "polar_image_dimension": len(image),
                "polar_kernel_dimension": len(kernel),
                "polar_image_echelon": [[v, w] for v, w in image],
                "polar_kernel_basis": kernel,
                "total_cosets": len(cases),
                "nonempty_cosets": sum(1 for c in coset_certs if c["status"] == "nonempty"),
                "quotient_count": total_quot,
                "phases_per_map": phases_per_map,
                "exclusive_functions": phases_per_map * orbit_size,
                "witness": first_witness_info,
                "native_witness_phase_hex": hex(native_witnesses[code][1]),
                "cosets": coset_certs,
            })

    construction_seconds = perf_counter() - t_start
    manifest = {
        "metadata": {
            "space": 3,
            "plane_basis": [21, 42],
            "ambient_n": 12,
            "algebraic_degree": 4,
            "repository": "contatofilipevono-rgb/hrsbf-bent-verification",
            "branch": "codex/n12-mixed-quartic",
            "head_commit": "cc8479613d24cdc0278cd39e31d0ee8b7e5b3a20",
            "github_actions_workflow": "n12_lower_dim_orbits.yml",
            "github_actions_run_id": 42950285592,
            "github_actions_commit": "3970b25389cbe495fe28ca4a8dd7b763b1326858",
            "artifact_name": "lower-dim-phase-orbits-3",
            "sha256_hashes": hashes,
            "bit_conventions": {
                "ambient_coordinates": "x = (z ^ w) | (w << 6) in F_2^12 with z in F_2^6 (bits 0..5) and w in F_2^6",
                "quotient_base_ordering": "low 6 bits index z in [1,2,4,8,16,32]; bits 6..9 index complementary w-basis [1,2,4,8]; bits 10..11 index plane basis [21,42]",
                "rotation_action": "12-bit cyclic shift x -> ((x << 1) & 4095) | (x >> 11)",
                "map_space_dimension": 30,
                "phase_space_dimension": 35,
                "fibre_orbit_representatives": [0, 1, 3],
                "fibre_size": 256,
                "properties_bit_layout": [
                    "bits 0..63 (property 0): 64-bit degree-4 top ANF signature",
                    "bits 64..127 (property 1): 64-bit second-derivative non-affinity signature on (7, 14, 28, 56)",
                    "bits 128..191 (property 2): 64-bit second-derivative non-affinity signature on (5, 10, 20, 40)",
                    "bits 192..255 (property 3): 64-bit second-derivative non-affinity signature on (9, 18, 36)",
                    "bits 256..319 (property 4): 64-bit second-derivative non-affinity signature on (27, 54)",
                ],
            },
        },
        "summary": {
            "maps_after_cubic_filter": 4063232,
            "balanced_support_maps": 386016,
            "support_orbits": 5874,
            "phase_tasks_total": len(all_task_codes),
            "quadratic_eliminated_tasks": len(quadratic_eliminated_codes),
            "residual_tasks_total": len(residual_certificates),
            "residual_negative_tasks": sum(1 for c in residual_certificates if c["status"] == "negative"),
            "residual_positive_tasks": sum(1 for c in residual_certificates if c["status"] == "positive"),
            "residual_dimension_histogram": {str(k): v for k, v in sorted(residual_hist.items())},
            "total_exclusive_functions": sum(
                c.get("exclusive_functions", 0) for c in residual_certificates
            ),
            "construction_seconds": construction_seconds,
        },
        "quadratic_eliminated_map_codes": quadratic_eliminated_codes,
        "residual_task_certificates": residual_certificates,
    }
    output_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    return manifest


def verify_witness_equation_combination(items, root, sig, phases, sigs, moments, properties):
    """Regenerate only the referenced equations from scratch and compute sum_k c_k(x) * E_k(x)."""
    acc = set()
    for item in items:
        regen = regenerate_single_equation(item["source"], root, sig, phases, sigs, moments, properties)
        assert sorted(regen) == item["equation_monomials"], (
            f"Regenerated polynomial mismatch for {item['source']}: {sorted(regen)} != {item['equation_monomials']}"
        )
        mult = set(item["multiplier_monomials"])
        acc ^= product(mult, regen)
    return acc


def verify_anf_and_walsh(model, maps, preceding, code, phase_1024, expected_anf_monomials=None):
    r = len(model.basis)
    mapping = xor_terms(maps, code)
    moved = truth_on_coordinates(mapping, phase_1024, r)
    truth = sum(1 << model.coordinates[x] for x in active_indices(moved))
    walsh = signs_to_walsh(truth)
    assert len(walsh) == 4096 and set(map(abs, walsh)) == {64}, "Walsh transform check failed"
    anf_mask = anf(truth, 12)
    monomials = list(active_indices(anf_mask))
    if expected_anf_monomials is not None:
        assert monomials == expected_anf_monomials, "ANF monomials mismatch"
    assert max(m.bit_count() for m in monomials) == 4, "Degree != 4"
    assert all((truth >> x & 1) == (truth >> shift(x, 1) & 1) for x in range(4096)), "Not rotation invariant"
    for basis in [model.basis] + preceding:
        affine = True
        for i, u in enumerate(basis):
            a = u | (u << 6)
            for v in basis[:i]:
                b = v | (v << 6)
                if any((truth >> x ^ truth >> (x ^ a) ^ truth >> (x ^ b)
                        ^ truth >> (x ^ a ^ b)) & 1 for x in range(4096)):
                    affine = False
                    break
            if not affine:
                break
        assert affine == (basis == model.basis), f"Affinity check failed on basis {basis}"


def verify_certificates(artifacts_dir: Path, manifest_path: Path):
    """Standalone CPU verifier: regenerates equations and checks all 37 certificates without repeating search."""
    t_start = perf_counter()
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    hashes = ensure_reconstructed_inputs(artifacts_dir)
    for name, expected in manifest["metadata"]["sha256_hashes"].items():
        if not name.endswith(".json") or name == "shifts.json":
            if name != "result.witnesses.bin" or name in hashes:
                assert hashes.get(name) == expected, f"Hash mismatch for {name}"

    tasks_path = artifacts_dir / "tasks_reconstructed.bin"
    weights = dict(struct.iter_unpack("<QQ", (artifacts_dir / "orbits.weights.bin").read_bytes()))
    shifts = json.loads((artifacts_dir / "shifts.json").read_text(encoding="utf-8"))
    model = build(BASES[2])
    maps = [p for p, _ in model.maps]
    preceding = preceding_spaces(3)

    t_quad_start = perf_counter()
    quad_eliminated = []
    residual_tasks = []
    for task_idx, task_tuple in enumerate(read_tasks(tasks_path)):
        code, multiplier, properties, root, signature, directions, moments = task_tuple
        res = run_initial_quadratic_elimination(root, signature, directions, moments)
        if res is None:
            quad_eliminated.append(code)
        else:
            residual_tasks.append((task_idx, task_tuple, res))
    quad_filter_seconds = perf_counter() - t_quad_start

    assert len(quad_eliminated) == 307
    assert quad_eliminated == manifest["quadratic_eliminated_map_codes"]
    assert len(residual_tasks) == 37
    assert len(manifest["residual_task_certificates"]) == 37

    verified_negatives = 0
    verified_positives = 0
    total_exclusive_functions = 0
    algebraic_cert_seconds = 0.0
    walsh_anf_seconds = 0.0

    for cert, (task_idx, (code, multiplier, properties, root, signature, directions, moments), (cur_root, cur_sig, cur_dirs)) in zip(
        manifest["residual_task_certificates"], residual_tasks
    ):
        t_alg = perf_counter()
        assert cert["task_index"] == task_idx
        assert cert["map_code"] == code
        assert cert["orbit_size"] == weights[code]
        assert cert["shift_kernel_dimension"] == multiplier
        assert cert["initial_dimension"] == len(directions)
        assert cert["residual_dimension"] == len(cur_dirs)
        phases = [p for p, _ in cur_dirs]
        sigs = [s for _, s in cur_dirs]

        if cert["status"] == "negative":
            acc = verify_witness_equation_combination(
                cert["witness_terms"], cur_root, cur_sig, phases, sigs, moments, properties
            )
            assert acc == {0}, f"Negative task {code} witness did not evaluate to 1=0: got {acc}"
            verified_negatives += 1
            algebraic_cert_seconds += perf_counter() - t_alg
        elif cert["status"] == "positive":
            image = [(v, w) for v, w in cert["polar_image_echelon"]]
            kernel = cert["polar_kernel_basis"]
            # Verify polar kernel/image decomposition
            sig_1_4 = [s >> 64 for s in sigs]
            chk_img, chk_ker = image_and_kernel(sig_1_4)
            assert sorted(chk_img, reverse=True) == image
            assert chk_ker == kernel
            kernel_phases = [xor_terms(phases, x) for x in kernel]
            kernel_sigs = [xor_terms(sigs, x) for x in kernel]
            cases = sorted(all_points([v for v, _ in image]))
            assert len(cases) == len(cert["cosets"]) == cert["total_cosets"]

            task_quotient_sum = 0
            for disp, coset_cert in zip(cases, cert["cosets"]):
                rep = locate(image, disp)
                assert rep == coset_cert["representative_mask"]
                ph = cur_root ^ xor_terms(phases, rep)
                sg = cur_sig ^ xor_terms(sigs, rep)
                ds = list(kernel_phases)
                ss = list(kernel_sigs)

                for rnd in coset_cert["reduction_rounds"]:
                    assert len(ds) == rnd["start_dimension"]
                    lin_rows = []
                    for leq in rnd["linear_equations"]:
                        l_poly = verify_witness_equation_combination(
                            leq["witness_terms"], ph, sg, ds, ss, moments, properties
                        )
                        assert sorted(l_poly) == leq["linear_monomials"]
                        assert all(m.bit_count() <= 1 for m in l_poly)
                        lin_rows.append((sum(m for m in l_poly if m), int(0 in l_poly)))
                    sh, fr, _ = solve(lin_rows, len(ds))
                    assert sh == rnd["shift_mask"] and fr == rnd["free_basis"]
                    ph ^= xor_terms(ds, sh)
                    sg ^= xor_terms(ss, sh)
                    ds = [xor_terms(ds, x) for x in fr]
                    ss = [xor_terms(ss, x) for x in fr]

                if coset_cert["status"] == "empty":
                    acc = verify_witness_equation_combination(
                        coset_cert["contradiction_witness"], ph, sg, ds, ss, moments, properties
                    )
                    assert acc == {0}, f"Empty coset {coset_cert['coset_index']} on {code} failed 1=0 check"
                    assert coset_cert["quotient_count"] == 0
                else:
                    assert len(ds) == coset_cert["final_dimension"]
                    # 1. Verify Farkas co-kernel witnesses for all 5 signature properties
                    assert len(coset_cert["farkas_property_witnesses"]) == properties
                    for p, w_hex in enumerate(coset_cert["farkas_property_witnesses"]):
                        w_p = int(w_hex, 16)
                        assert (((sg >> (64 * p)) & w_p).bit_count() & 1) == 1
                        assert all((((s >> (64 * p)) & w_p).bit_count() & 1) == 0 for s in ss)

                    # 2. Verify quadratic basis and completeness over all moments
                    q_eqs = quadratic_moments(ph, ds, moments)
                    for subset, mask, target in moments:
                        if mask >= 7:
                            e = mod8_bit(ph, ds, subset, target)
                            if e:
                                q_eqs.append(e)
                    for subset, mask, target in moments:
                        if mask >= 15:
                            b3 = mod16_bit_poly(ph, ds, subset, target, check_preconditions=True)
                            if b3 and max(m.bit_count() for m in b3) <= 2:
                                q_eqs.append(b3)
                    base_piv = echelon(q_eqs)
                    q_basis = [sorted(row) for row in base_piv.values()]
                    assert q_basis == coset_cert["quadratic_basis"]
                    assert all(m.bit_count() <= 2 for row in q_basis for m in row)

                    # Verify any degree-3 mod16 equations reduce to 0 modulo 1-var lifts of q_basis
                    lift_piv = dict(base_piv)
                    for q in list(base_piv.values()):
                        for i in range(len(ds)):
                            bit = 1 << i
                            mult = set()
                            for m in q:
                                mult.symmetric_difference_update((m | bit,))
                            while mult:
                                p_m = max(mult, key=lambda m: (m.bit_count(), m))
                                if p_m not in lift_piv:
                                    lift_piv[p_m] = mult
                                    break
                                mult ^= lift_piv[p_m]
                    for subset, mask, target in moments:
                        if mask >= 15:
                            b3 = mod16_bit_poly(ph, ds, subset, target, check_preconditions=True)
                            row = set(b3)
                            while row:
                                p_m = max(row, key=lambda m: (m.bit_count(), m))
                                assert p_m in lift_piv
                                row ^= lift_piv[p_m]

                    # 3. Verify Quadratic Gauss sums
                    sums = []
                    poly_u = set()
                    for ordinal in range(1 << len(q_basis)):
                        if ordinal:
                            poly_u ^= set(q_basis[(ordinal & -ordinal).bit_length() - 1])
                        val, rnk = gauss_sum(len(ds), poly_u)
                        sums.append({"sum": val, "rank": rnk})
                    assert sums == coset_cert["gauss_sums"]
                    cnt = sum(item["sum"] for item in sums) // (1 << len(q_basis))
                    assert cnt == coset_cert["quotient_count"]
                    task_quotient_sum += cnt

            assert task_quotient_sum == cert["quotient_count"]
            assert (task_quotient_sum << multiplier) == cert["phases_per_map"]
            assert cert["phases_per_map"] * cert["orbit_size"] == cert["exclusive_functions"]
            algebraic_cert_seconds += perf_counter() - t_alg

            # 4. Verify shift kernel basis and ANF witness by full Walsh, degree, rotation, and exclusivity
            t_walsh = perf_counter()
            shift_vecs = [int(v, 16) for v in cert["shift_basis_hex"]]
            assert cert["shift_basis_hex"] == shifts[str(code)]
            assert len(image_and_kernel(shift_vecs)[0]) == multiplier
            w_info = cert["witness"]
            w_phase = int(w_info["phase_hex"], 16)
            assert all(((w_phase & subset).bit_count() & mask) == rhs for subset, mask, rhs in moments)
            verify_anf_and_walsh(model, maps, preceding, code, w_phase, w_info["anf_monomials"])
            for s_mask in range(1, 1 << multiplier):
                verify_anf_and_walsh(model, maps, preceding, code, w_phase ^ xor_terms(shift_vecs, s_mask))
            native_phase = int(cert["native_witness_phase_hex"], 16)
            verify_anf_and_walsh(model, maps, preceding, code, native_phase)
            walsh_anf_seconds += perf_counter() - t_walsh

            total_exclusive_functions += cert["exclusive_functions"]
            verified_positives += 1
        else:
            raise ValueError(f"Invalid status: {cert['status']}")

    verification_seconds = perf_counter() - t_start
    assert verified_negatives == 31
    assert verified_positives == 6
    assert total_exclusive_functions == 309248
    report = {
        "verified_tasks": verified_negatives + verified_positives,
        "verified_negative_tasks": verified_negatives,
        "verified_positive_tasks": verified_positives,
        "quadratic_eliminated_tasks": len(quad_eliminated),
        "total_exclusive_functions": total_exclusive_functions,
        "construction_seconds": manifest["summary"]["construction_seconds"],
        "verification_seconds_total": verification_seconds,
        "verification_breakdown_seconds": {
            "quadratic_filter_344_to_37": quad_filter_seconds,
            "residual_37_algebraic_certificates": algebraic_cert_seconds,
            "positive_6_walsh_anf_and_shifts": walsh_anf_seconds,
        },
    }
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--artifacts",
        type=Path,
        default=Path(__file__).with_name("artifacts_space3"),
        help="Directory containing lower-dim-phase-orbits-3 artifacts",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).with_name("lower-dim-v2-residual-certificates.json"),
        help="Path to JSON certificate manifest",
    )
    parser.add_argument("--build", action="store_true", help="Build certificates from scratch")
    parser.add_argument("--verify", action="store_true", help="Verify certificates on CPU without search")
    args = parser.parse_args()

    if not args.build and not args.verify:
        args.build = True
        args.verify = True

    if args.build:
        manifest = build_certificates(args.artifacts, args.output)
        print({"stage": "build", **manifest["summary"]})
    if args.verify:
        report = verify_certificates(args.artifacts, args.output)
        print({"stage": "verify", **report})


if __name__ == "__main__":
    main()
