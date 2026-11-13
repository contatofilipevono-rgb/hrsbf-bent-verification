"""Verify short phase identities for the three residual type-C maps."""
from collections import Counter

from count_near_antipodal import image_and_kernel
from higher_filter import solve, xor_terms
from line_phase_algebra import locate, mod8_bit, quadratic_moments, reduce_phase
from lower_dim_model import active_indices, build
from lower_dim_moments import conditions, phase_linear_system
from lower_dim_phase_prepare import fibre_masks, properties
from lower_dim_v3_symbolic import affine_at, count, equations_for_task, product, substitute


# Masks encode monomials in the phase coordinates after the mod-4 substitutions.
# The two source equations are the mod-8 weights of fibres 1 and 3.
CERTIFICATES = {
    447616277: ([], [0], "contradiction"),
    447616370: (
        [128, 256, 512, 1024, 2048, 16384, 32768, 65536, 131072],
        [0, 4, 16, 256, 512],
        "affine",
    ),
    447616701: (
        [4, 16, 64, 256, 512, 1024, 2048, 262144],
        [0, 4, 16, 64, 256, 512, 1024, 2048, 262144],
        "contradiction",
    ),
    447616730: ([64, 1024, 2048, 262144], [0], "exclusive_control"),
}

COMPACT = {
    447616277: ([0, 3], [0], 3, 0),
    447616370: ([0, 1, 9], [0, 3, 10], 4, 1 << 17),
    447616701: ([0, 2, 3], [0, 1, 9], 4, 0),
    447616730: ([0, 4, 6], [0, 1], 3, 1 << 17),
}


def compact_equations(polynomials, dimension):
    forms = []
    for q in polynomials:
        assert all(mask.bit_count() <= 2 for mask in q)
        forms.extend(
            sum(mask ^ (1 << i) for mask in q if mask.bit_count() == 2 and mask >> i & 1)
            for i in range(dimension)
        )
    image, _ = image_and_kernel(forms)
    forms = [mask for mask, _ in image]
    forms.extend(sum(1 << i for i in range(dimension) if 1 << i in q) for q in polynomials)
    image, _ = image_and_kernel(forms)
    normals = sorted((mask for mask, _ in image), reverse=True)
    sections = [solve([(mask, int(i == j)) for j, mask in enumerate(normals)], dimension)[0]
                for i in range(len(normals))]
    compressed = substitute(polynomials, [affine_at(i, 0, sections) for i in range(dimension)])
    # Substitute back to prove equality on the entire original phase space.
    variables = [{1 << i for i in active_indices(mask)} for mask in normals]
    assert substitute(compressed, variables) == polynomials
    return compressed, len(normals)


def verify():
    model = build((9, 18, 36))
    maps, lifts = map(list, zip(*model.maps))
    map_signatures, phase_signatures, property_count = properties(model, 1)
    assert property_count == 3
    for code, (multiplier1, multiplier3, kind) in CERTIFICATES.items():
        mapping = xor_terms(maps, code)
        root = xor_terms(lifts, code)
        signature = xor_terms(map_signatures, code)
        fibres = fibre_masks(mapping, 512, 3)
        initial_phase = root
        moments = conditions([fibres[1], fibres[3]], 9, 3)
        origin, basis, _ = phase_linear_system(moments, root, model.phases)
        assert origin is not None and len(basis) == 22
        root ^= xor_terms(model.phases, origin)
        signature ^= xor_terms(phase_signatures, origin)
        phases = [xor_terms(model.phases, mask) for mask in basis]
        signatures = [xor_terms(phase_signatures, mask) for mask in basis]
        reduced = reduce_phase(
            root, phases, signature, signatures, quadratic_moments(root, phases, moments), 0
        )
        assert reduced is not None
        root, phases, signature, signatures, remaining = reduced
        assert len(phases) == 20 and not remaining
        full_moments = [(subset, target) for subset, mask, target in moments if mask == 7]
        assert full_moments == [(fibres[1], 4), (fibres[3], 4)]
        p1, p3 = [mod8_bit(root, phases, subset, target) for subset, target in full_moments]
        compact, rank = compact_equations([p1, p3], len(phases))
        first, second, expected_rank, expected_count = COMPACT[code]
        assert compact == [set(first), set(second)] and rank == expected_rank
        admissible = sum(all(not (sum(word & mask == mask for mask in q) & 1) for q in compact)
                         for word in range(1 << rank))
        assert admissible << (len(phases) - rank) == expected_count
        actual = product(p1, set(multiplier1)) ^ product(p3, set(multiplier3))
        if kind == "contradiction":
            assert actual == {0}
        else:
            # Property 2 is non-affinity in the invariant four-space V2.
            bits = {(sum(((value >> bit) & 1) << i for i, value in enumerate(signatures)),
                     (signature >> bit) & 1) for bit in range(128, 192)} - {(0, 0)}
            (linear, constant), = bits
            target = {1 << i for i in active_indices(linear)}
            if constant ^ (kind == "exclusive_control"):
                target.add(0)
            assert actual == target
        print(code, kind, sorted(actual), flush=True)
        if kind != "contradiction":
            complete = conditions([fibres[i] for i in (0, 1, 3, 7)], 9, 3)
            origin, basis, _ = phase_linear_system(complete, initial_phase, model.phases)
            assert origin is not None
            initial_phase ^= xor_terms(model.phases, origin)
            full_directions = [(xor_terms(model.phases, mask), 0) for mask in basis]
            system = equations_for_task(0, initial_phase, 0, full_directions, complete)
            total, _, _, _ = count(len(basis), system, Counter())
            assert total == (24576 if kind == "affine" else 16384)
            print(code, "bent phases", total, flush=True)

    image = sorted(image_and_kernel(maps)[0], reverse=True)
    for code, expected, order_one_index in (
        (447615148, 447615843, 8),
        (447616496, 447616575, 9),
    ):
        original = xor_terms(maps, code)
        translated = sum(
            ((original >> (512*i + (y ^ 448))) & 1) << (512*i+y)
            for i in range(3) for y in range(512)
        )
        assert locate(image, translated) == expected
        root = xor_terms(lifts, expected)
        fibres = fibre_masks(translated, 512, 3)
        moments = conditions([fibres[1], fibres[3]], 9, 3)
        origin, basis, _ = phase_linear_system(moments, root, model.phases)
        assert origin is not None and len(basis) == 22
        root ^= xor_terms(model.phases, origin)
        phases = [xor_terms(model.phases, mask) for mask in basis]
        left, = quadratic_moments(root, phases, [moments[order_one_index]])
        right, = quadratic_moments(root, phases, [moments[53]])
        assert left ^ right == {0}
        print(code, "translated map has no bent phase", expected, flush=True)


if __name__ == "__main__":
    verify()
