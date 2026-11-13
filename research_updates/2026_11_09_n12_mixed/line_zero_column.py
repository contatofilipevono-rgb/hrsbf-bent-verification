"""Use character sums of quadratic row radicals to bound Walsh column energy."""
from collections import Counter
from math import gcd

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import shift, solve
from line_column_collision import radical_bases
from lower_dim_phase_prepare import truth_on_coordinates
from lower_dim_v3_symbolic import affine_at, substitute


def odd_radical_support(polar):
    odd = set()
    for basis in radical_bases(polar):
        odd.symmetric_difference_update(all_points(basis))
    return min(odd) if odd else None


def radical_derivatives(model, mapping, phase, directions, polar):
    """Yield the affine derivative on each radical vector of each row."""
    index = {model.coordinates[i] >> 6: i for i in range(0, 4096, 64)}
    rank = len(model.basis)
    tables = [truth_on_coordinates(mapping, phase, rank)]
    tables.extend(truth_on_coordinates(0, h, rank) for h in directions)
    for z, basis in enumerate(radical_bases(polar)):
        for v in all_points(basis):
            derivative = sum(
                ((((table >> (z + index[v])) ^ (table >> z)) & 1) << i)
                for i, table in enumerate(tables)
            )
            yield z, v, derivative


def energy_spectrum(model, mapping, phase, directions, polar, beta=0):
    """Return the character expansion of the column's squared norm divided by 64."""
    spectrum = Counter()
    for _, v, derivative in radical_derivatives(model, mapping, phase, directions, polar):
        offset = (v & beta).bit_count() & 1
        spectrum[derivative >> 1] += (-1)**((derivative & 1) ^ offset)
    return {mask: coeff for mask, coeff in sorted(spectrum.items()) if coeff}


def character_values(spectrum):
    """Evaluate a character sum on the dual of the span of its frequencies."""
    image, _ = image_and_kernel(spectrum)
    basis = sorted((v for v, _ in image), reverse=True)
    values = [0] * (1 << len(basis))
    for mask, coeff in spectrum.items():
        key = 0
        for i, vector in enumerate(basis):
            if mask >> (vector.bit_length() - 1) & 1:
                mask ^= vector
                key |= 1 << i
        assert not mask
        values[key] += coeff
    for i in range(len(basis)):
        half = 1 << i
        for start in range(0, len(values), 2 * half):
            for j in range(start, start + half):
                a, b = values[j], values[j + half]
                values[j], values[j + half] = a + b, a - b
    return basis, values


def necessary_spectra(model, mapping, phase, directions, polar):
    by_direction = {}
    for _, v, derivative in radical_derivatives(model, mapping, phase, directions, polar):
        by_direction.setdefault(v, Counter())[derivative >> 1] += (-1)**(derivative & 1)
    for v, spectrum in sorted(by_direction.items()):
        if not v or v != min(shift(v, k, 6) for k in range(6)):
            continue
        yield ("derivative", v), 0, {mask: weight for mask, weight in spectrum.items() if weight}
    for beta in (0, 63, 21):
        spectrum = Counter()
        for v, terms in by_direction.items():
            sign = (-1)**((v & beta).bit_count() & 1)
            for mask, weight in terms.items():
                spectrum[mask] += sign * weight
        yield ("column", beta), 64, {mask: weight for mask, weight in spectrum.items() if weight}


def early_obstruction(spectra):
    """Find a derivative or column condition impossible on the affine phase space."""
    for (kind, index), target, terms in spectra:
        obstruction = arithmetic_obstruction(terms, target)
        if obstruction is not None:
            return {kind: index, "spectrum": terms, "arithmetic": obstruction}
        if len(image_and_kernel(terms)[0]) <= 15:
            basis, values = character_values(terms)
            if target not in values:
                return {kind: index, "spectrum": terms, "character_rank": len(basis)}
    return None


def arithmetic_obstruction(terms, target):
    variable = {mask: weight for mask, weight in terms.items() if mask}
    if abs(terms.get(0, 0) - target) > sum(map(abs, variable.values())):
        return {"inequality": "triangle"}
    divisor = gcd(*variable.values())
    if not divisor:
        return None
    delta = sum(terms.values()) - target
    if delta % (2 * divisor):
        return {"modulus": 2 * divisor, "residue": delta % (2 * divisor)}
    parity = 0
    for mask, weight in variable.items():
        if (weight // divisor) & 1:
            parity ^= mask
    if not parity and delta % (4 * divisor):
        return {"modulus": 4 * divisor, "residue": delta % (4 * divisor)}
    return None


def exceptional_certificate(spectrum, quadratics, dimension):
    # Set a,b,c,d,e equal to the characters of 532,3584,4177,11307,17492.
    assert spectrum == {
        0: 192, 532: -48, 3584: -8, 4177: -48, 11307: -24, 17492: -24, 26751: 24,
    }
    assert 11307 ^ 17492 == 26751
    # -24d-24e+24de >= -24, so energy 64 requires a=b=c=1.
    # Only a=c=1 are needed for the contradiction.
    masks = [532, 4177]
    origin, basis, rank = solve([(mask, 0) for mask in masks], dimension)
    assert origin == 0 and rank == 2
    variables = [affine_at(i, origin, basis) for i in range(dimension)]
    indices = [0, 5, 7, 10]
    total = set()
    for i in indices:
        total ^= quadratics[i]
    assert substitute([total], variables) == [{0}]
    return {"forced_linear_masks": masks, "quadratic_indices": indices,
            "quadratic_sum": sorted(total)}


def final_obstruction(model, mapping, phase, directions, polar, quadratics, code):
    spectrum = energy_spectrum(model, mapping, phase, directions, polar)
    bound = spectrum.get(0, 0) - sum(abs(w) for mask, w in spectrum.items() if mask)
    certificate = {"energy_spectrum": spectrum, "triangle_lower_bound": bound}
    if bound <= 64:
        assert code == 2023
        certificate.update(exceptional_certificate(spectrum, quadratics, len(directions)))
    return certificate
