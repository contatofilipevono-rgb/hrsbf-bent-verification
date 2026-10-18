from pathlib import Path
import shutil
root=Path('outputs/hrsbf-bent-verification/quartic_audit_2026_10_17')
shutil.copy2(root/'lean/H12Orbit.lean',root/'experiments/H12Orbit_bruteforce_interrupted.lean')
source=Path('work/T150_orbit_fast.lean').read_text().replace('namespace OrbitFast','namespace H12Orbit').replace('end OrbitFast','end H12Orbit')
source=source.replace('namespace H12Orbit', '''/-! Rotation acts by a permutation of the monomials in every generator.
This proof uses bit identities and finite orbit permutations, avoiding a table
over the 4,096 input values for each generator. -/
namespace H12Orbit''')
source=source.replace('theorem orbit_bounds', '''def allQuarticMasks : List Nat :=
  (List.range 4096).filter (fun mask =>
    ((List.range 12).filter (fun i => mask.testBit i)).length == 4)

theorem all_supports_partitioned :
    H12Descent.sortFuel 9 H12.quarticOrbits.flatten = allQuarticMasks := by decide +kernel

#print axioms all_supports_partitioned

theorem orbit_bounds''')
(root/'lean/H12Orbit.lean').write_text(source)
lake=root/'lean/lakefile.toml'
lake.write_text(lake.read_text().replace('"H12Refutation"]','"H12Refutation", "H12Orbit"]'))
audit=root/'lean/H12Audit.lean'
source=audit.read_text().replace('import H12Quadratic','import H12Quadratic\nimport H12Orbit\nimport H12Refutation')
source=source.replace('    (hr : H12Descent.Rotational4 (H12.quarticFunction c))\n','')
source=source.replace('bent_rotational_four_cases _ c (quartic_representation c) hr hb','bent_rotational_four_cases _ c (quartic_representation c)\n    (H12Orbit.quartic_rotational_four c) hb')
source=source.replace('H12Descent.bent_rotational_descent _ hr hb u','H12Descent.bent_rotational_descent _ (H12Orbit.quartic_rotational_four c) hb u')
audit.write_text(source)
print('Integrated symbolic orbit proof; archived interrupted brute-force attempt.')
