"""Control of Eq. (21) in Sun et al. (2026) for one full cubic orbit.

This checks an algebraic identity, not the validity of all results in the paper.
No imports from the project's verifier. The source article is not redistributed.
"""
import json
from pathlib import Path

def evaluate(x, monomials):
    return sum((x & mask) == mask for mask in monomials) & 1

def run():
    cases = []
    for n in (8, 16):
        full = (1 << n) - 1
        cubic = tuple(sum(1 << j for j in {i, (i+1)%n, (i+2)%n}) for i in range(n))
        quadratic = tuple((1 << i) | (1 << ((i+2)%n)) for i in range(n))
        missing_linear = corrected_mismatches = weight = 0
        for x in range(1 << n):
            derivative = evaluate(x, cubic) ^ evaluate(x ^ full, cubic)
            quadratic_value = evaluate(x, quadratic)
            corrected = quadratic_value ^ (x.bit_count() & 1)
            missing_linear += derivative != quadratic_value
            corrected_mismatches += derivative != corrected
            weight += derivative
        if corrected_mismatches:
            raise RuntimeError("Corrected identity failed")
        if missing_linear != (1 << (n-1)):
            raise RuntimeError("Unexpected missing-linear-term comparison")
        x = 1
        cases.append({
            "n": n,
            "cubic_SANF": "[0,1,2]",
            "original_derivative_weight": weight,
            "equation_21_without_linear_mismatches": missing_linear,
            "corrected_identity_mismatches": corrected_mismatches,
            "at_e0": {
                "original_derivative": evaluate(x,cubic)^evaluate(x^full,cubic),
                "quadratic_only": evaluate(x,quadratic),
            },
            "corrected_identity": "D_ones f = Q_2 + sum_i x_i",
        })
    result = {
        "status": "verified",
        "source": "Sun-Shi-Liu-Fu 2026, Eq. (21), page 17",
        "scope": "Concrete identity check for a full orbit; no global refutation of the paper.",
        "cases": cases,
    }
    print(json.dumps(result, indent=2))
    Path(__file__).with_suffix(".json").write_text(json.dumps(result,indent=2)+"\n")
    return result

if __name__ == "__main__":
    run()
