"""Combine linear consequences of partial Walsh column autocorrelations."""
from collections import Counter

from count_near_antipodal import image_and_kernel
from higher_filter import solve, xor_terms
from line_zero_column import character_values
from lower_dim_phase_prepare import truth_on_coordinates


def restrict(spectrum, origin, directions):
    result = Counter()
    for mask, coeff in spectrum.items():
        key = sum(((mask & v).bit_count() & 1) << i for i, v in enumerate(directions))
        result[key] += coeff * (-1)**((mask & origin).bit_count() & 1)
    return {m: c for m, c in result.items() if c}


def affine_consequences(sums, dimension):
    """Restrict phases to all linear consequences of the prescribed character sums."""
    trace = []
    original_root = 0
    original_directions = [1 << i for i in range(dimension)]
    while True:
        equations = {}
        for name, target, spectrum in sums:
            if len(image_and_kernel(spectrum)[0]) > 15:
                continue
            basis, values = character_values(spectrum)
            accepted = [i for i, value in enumerate(values) if value == target]
            if not accepted:
                trace.append({"incompatible_sum": name, "spectrum": spectrum,
                              "target": target, "character_rank": len(basis)})
                return None, [], trace
            root = accepted[0]
            _, normals, _ = solve([(x ^ root, 0) for x in accepted[1:]], len(basis))
            for normal in normals:
                mask = xor_terms(basis, normal)
                rhs = (normal & root).bit_count() & 1
                equations.setdefault((mask, rhs), name)
        origin, free, rank = solve(equations, dimension)
        if not rank and origin is not None:
            return original_root, original_directions, trace
        trace.append({
            "dimension": dimension, "rank": rank,
            "equations": [[mask, rhs, name] for (mask, rhs), name in equations.items()],
            "consistent": origin is not None,
        })
        if origin is None:
            return None, [], trace
        original_root ^= xor_terms(original_directions, origin)
        original_directions = [xor_terms(original_directions, v) for v in free]
        sums = [(name, target, restrict(spectrum, origin, free)) for name, target, spectrum in sums]
        dimension = len(free)


def column_sums(model, mapping, phase, directions, beta):
    # Each point is represented by the affine bit of its sign.
    index = {model.coordinates[i] >> 6: i for i in range(0, 4096, 64)}
    tables = [truth_on_coordinates(mapping, phase, 1)]
    tables.extend(truth_on_coordinates(0, h, 1) for h in directions)
    signs = [(-1)**((beta & w).bit_count() & 1) for w in range(64)]
    rows = []
    for z in range(64):
        row = Counter()
        for w in range(64):
            position = z + index[w]
            t = sum(((table >> position) & 1) << i for i, table in enumerate(tables))
            row[t >> 1] += signs[w] * (1 - 2*(t & 1))
        rows.append({mask: weight for mask, weight in row.items() if weight})
    for shift in range(1, 64):
        terms = Counter()
        for z in range(64):
            other = z ^ shift
            if z < other:
                for mask, weight in rows[z].items():
                    for other_mask, other_weight in rows[other].items():
                        terms[mask ^ other_mask] += weight * other_weight
        spectrum = {mask: weight for mask, weight in terms.items() if weight}
        if spectrum:
            yield ("autocorrelation", beta, shift), 0, spectrum


def exclude_by_autocorrelation(model, mapping, phase, directions, spectra):
    origin, basis, trace = affine_consequences(spectra, len(directions))
    if origin is None:
        return "joint_energy", {"energy_trace": trace}
    phase ^= xor_terms(directions, origin)
    directions = [xor_terms(directions, v) for v in basis]
    column_trace = []
    # These columns suffice for the residual cases; each step is a necessary condition.
    for beta in (0, 63, 21, *range(1, 17)):
        sums = list(column_sums(model, mapping, phase, directions, beta))
        origin, basis, steps = affine_consequences(sums, len(directions))
        if steps:
            column_trace.append({"column": beta, "steps": steps})
        if origin is None:
            return "column_autocorrelation", {"energy_trace": trace, "column_trace": column_trace}
        phase ^= xor_terms(directions, origin)
        directions = [xor_terms(directions, v) for v in basis]
    return None, {}
