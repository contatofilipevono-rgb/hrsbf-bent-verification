import H12PeriodFour
import H12Descent
import H12BooleanPolynomial
/-! Rotation acts by a permutation of the monomials in every generator.
This proof uses bit identities and finite orbit permutations, avoiding a table
over the 4,096 input values for each generator. -/
namespace H12Orbit

theorem rot_inverse (x : BitVec 12) : (x.rotateLeft 8).rotateLeft 4 = x := by
  apply BitVec.eq_of_getLsbD_eq
  intro i hi
  by_cases h : i < 4
  · simp [← BitVec.getLsbD_eq_getElem, BitVec.getLsbD_rotateLeft, h, show ¬8+i < 8 by omega,
      show 8+i < 12 by omega, show 8+i-8 = i by omega]
  · simp [BitVec.getLsbD_rotateLeft, h, show i-4 < 8 by omega,
      show 4+(i-4) = i by omega, hi]

theorem rot_and (x y : BitVec 12) :
    (x &&& y).rotateLeft 4 = (x.rotateLeft 4 &&& y.rotateLeft 4) := by
  apply BitVec.eq_of_getLsbD_eq
  intro i hi
  by_cases h : i < 4 <;> simp [BitVec.getLsbD_rotateLeft, h, hi, Bool.and_assoc]

theorem monomial_rotate (x m : BitVec 12) :
    (x.rotateLeft 8 &&& m) = m ↔ (x &&& m.rotateLeft 4) = m.rotateLeft 4 := by
  constructor
  · intro h
    have hh := congrArg (fun z : BitVec 12 => z.rotateLeft 4) h
    rwa [rot_and, rot_inverse] at hh
  · intro h
    have inv : ∀ z : BitVec 12, (z.rotateLeft 4).rotateLeft 8 = z := by
      intro z
      apply BitVec.eq_of_getLsbD_eq
      intro i hi
      by_cases h : i < 8
      · simp [← BitVec.getLsbD_eq_getElem, BitVec.getLsbD_rotateLeft, h, show ¬4+i < 4 by omega,
          show 4+i < 12 by omega, show 4+i-4 = i by omega]
      · simp [← BitVec.getLsbD_eq_getElem, BitVec.getLsbD_rotateLeft, h, show i-8 < 4 by omega,
          show 8+(i-8) = i by omega, hi]
    have hh : (x.rotateLeft 8 &&& m).rotateLeft 4 = m.rotateLeft 4 := by
      rw [rot_and, rot_inverse]
      exact h
    have hh' := congrArg (fun z : BitVec 12 => z.rotateLeft 8) hh
    simpa only [inv] using hh'
def rotateSupport (m : Nat) : Nat := ((BitVec.ofNat 12 m).rotateLeft 4).toNat

theorem monomial_nat_rotate (m x : Fin 4096) :
    H12.monomialValue m.val (H12Descent.rotate4 x.val) =
      H12.monomialValue (rotateSupport m.val) x.val := by
  apply Bool.eq_iff_iff.mpr
  simp only [H12.monomialValue, beq_iff_eq]
  have h := monomial_rotate (BitVec.ofNat 12 x.val) (BitVec.ofNat 12 m.val)
  simpa only [H12Descent.rotate4, rotateSupport, ← BitVec.toNat_inj, BitVec.toNat_and, BitVec.toNat_ofNat,
    Nat.mod_eq_of_lt x.isLt, Nat.mod_eq_of_lt m.isLt] using h

set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

def allQuarticMasks : List Nat :=
  (List.range 4096).filter (fun mask =>
    ((List.range 12).filter (fun i => mask.testBit i)).length == 4)

theorem all_supports_partitioned :
    H12Descent.sortFuel 9 H12.quarticOrbits.flatten = allQuarticMasks := by decide +kernel

#print axioms all_supports_partitioned

theorem cyclic_orbits_exact : ∀ j : Fin 43,
    H12Descent.sortFuel 4 (((List.range 12).map (fun k =>
      ((BitVec.ofNat 12 (H12.quarticOrbits[j.val]!).head!).rotateLeft k).toNat)).eraseDups) =
      H12.quarticOrbits[j.val]! := by decide +kernel

#print axioms cyclic_orbits_exact

theorem orbit_bounds : ∀ j : Fin 43,
    (H12.quarticOrbits[j.val]!).all (fun m => decide (m < 4096)) = true := by decide +kernel

theorem orbit_rotated_sorted : ∀ j : Fin 43,
    H12Descent.sortFuel 4 ((H12.quarticOrbits[j.val]!).map rotateSupport) =
      H12Descent.sortFuel 4 (H12.quarticOrbits[j.val]!) := by decide +kernel

theorem orbit_permutation (j : Fin 43) :
    ((H12.quarticOrbits[j.val]!).map rotateSupport).Perm (H12.quarticOrbits[j.val]!) :=
  H12BooleanPolynomial.permutation_of_sorted _ _ 4 (orbit_rotated_sorted j)

theorem xor_reorder : ∀ a b c : Bool, ((a ^^ b) ^^ c) = ((a ^^ c) ^^ b) := by decide

theorem basis_rotation_four (j : Fin 43) (x : Fin 4096) :
    H12.orbitValue (H12.quarticOrbits[j.val]!) (H12Descent.rotate4 x.val) =
      H12.orbitValue (H12.quarticOrbits[j.val]!) x.val := by
  have hm : ∀ m ∈ H12.quarticOrbits[j.val]!,
      H12.monomialValue m (H12Descent.rotate4 x.val) =
        H12.monomialValue (rotateSupport m) x.val := by
    intro m h
    have hb : m < 4096 := of_decide_eq_true (List.all_eq_true.mp (orbit_bounds j) m h)
    exact monomial_nat_rotate ⟨m,hb⟩ x
  calc
    H12.orbitValue (H12.quarticOrbits[j.val]!) (H12Descent.rotate4 x.val) =
        H12.orbitValue ((H12.quarticOrbits[j.val]!).map rotateSupport) x.val := by
      have he := List.map_congr_left hm
      have hh := congrArg (fun vs : List Bool => vs.foldl Bool.xor false) he
      simpa only [H12.orbitValue, List.foldl_map] using hh
    _ = H12.orbitValue (H12.quarticOrbits[j.val]!) x.val := by
      apply List.Perm.foldl_eq' (orbit_permutation j)
      intro a _ b _ z
      exact xor_reorder z _ _

theorem quartic_rotational_four (c : BitVec 43) :
    H12Descent.Rotational4 (H12.quarticFunction c) := by
  intro x hx
  have h : ∀ j : Fin 43,
      H12.orbitValue (H12.quarticOrbits[j.val]!) (H12Descent.rotate4 x) =
        H12.orbitValue (H12.quarticOrbits[j.val]!) x :=
    fun j => basis_rotation_four j ⟨x,hx⟩
  unfold H12.quarticFunction
  simp only [h]

#print axioms quartic_rotational_four

end H12Orbit
