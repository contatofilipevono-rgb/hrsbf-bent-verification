import H12NumericFilters
import H12Truth
import H12FilterBridge
import H12TablePolynomial
import H12CertificateTheory

/-! Bentness implies the original 43 explicit filters. The bitset evaluator and
its numerical identities are linked to the original cyclic quartic functions. -/
namespace H12FilterLink
set_option maxRecDepth 100000
set_option maxHeartbeats 1000000000
open H12BooleanPolynomial H12CertificateTheory H12TablePolynomial

open H12Weight
universe u
variable {α : Type u}

def familyRows (indices : List Nat) (family : Nat → α → Bool) : List (Nat × (α → Bool)) :=
  indices.map (fun i => (i, family i))

theorem combine_family_congr_at (coeff : Nat → Bool) (indices : List Nat)
    (f g : Nat → α → Bool) (x : α) (h : ∀ i ∈ indices, f i x = g i x) :
    combine coeff (familyRows indices f) x = combine coeff (familyRows indices g) x := by
  induction indices with
  | nil => rfl
  | cons i indices ih =>
    simp only [familyRows, List.map_cons, combine] at *
    rw [h i List.mem_cons_self, ih (fun j hj => h j (List.mem_cons_of_mem i hj))]

theorem scale_step : ∀ c p v r : Bool,
    ((c && (p && v)) ^^ (p && r)) = (p && ((c && v) ^^ r)) := by decide

theorem combine_family_scale (coeff : Nat → Bool) (indices : List Nat)
    (p : α → Bool) (f : Nat → α → Bool) (x : α) :
    combine coeff (familyRows indices (fun i x => p x && f i x)) x =
      (p x && combine coeff (familyRows indices f) x) := by
  induction indices with
  | nil => simp [familyRows, combine]
  | cons i indices ih =>
    simp only [familyRows, List.map_cons, combine] at *
    rw [ih]
    exact scale_step ..

theorem count_congr_on (xs : List α) (f g : α → Bool) (h : ∀ x ∈ xs, f x = g x) :
    xs.countP f = xs.countP g := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    rw [List.countP_cons, List.countP_cons, h a List.mem_cons_self,
      ih (fun x hx => h x (List.mem_cons_of_mem a hx))]

theorem carry_congr_on (xs : List α) (f g : α → Bool) (h : ∀ x ∈ xs, f x = g x) :
    carry xs f = carry xs g := congrArg (fun n => n.testBit 1) (count_congr_on xs f g h)

theorem carry_filter (xs : List α) (p f : α → Bool) :
    carry (xs.filter p) f = carry xs (fun x => p x && f x) := by
  simp [carry, List.countP_filter, Bool.and_comm]

theorem originalRows_family : H12FilterBridge.originalRows =
    familyRows (List.range 43) (fun i x => H12.orbitValue (H12.quarticOrbits[i]!) x) := by
  rfl

#print axioms originalRows_family

open H12Truth H12FilterBridge H12Restriction

def cubeTable (s : Nat) : Nat :=
  andTables ((excluded s).map (fun i => ones ^^^ planes[i]!))

theorem cubeTable_bit (s x : Nat) (hx : x < 4096) :
    (cubeTable s).testBit x = zeroCoordinates (excluded s) x := by
  rw [cubeTable, andTables_bit _ x hx]
  simp only [List.all_map, zeroCoordinates]
  apply all_congr_on
  intro i hi
  have hib := excluded_bounds s i hi
  change (ones ^^^ planes[i]!).testBit x = !x.testBit i
  rw [Nat.testBit_xor, show ones.testBit x = true from by
    simp only [ones, Nat.testBit_two_pow_sub_one, hx, decide_true],
    variable_semantics ⟨i,hib⟩ ⟨x,hx⟩, Bool.true_xor]

#print axioms cubeTable_bit

theorem truth_data_agree : H12NumericFilters.truthTables = H12Truth.basisTables := rfl

theorem cube_data_exact : ∀ j : Fin 43,
    H12NumericFilters.cubeTables[j.val]! = cubeTable H12FilterBridge.supports[j.val]! := by decide +kernel

theorem maskedRows_family (j : Nat) :
    tableRows (H12NumericFilters.maskedRows j) = familyRows (List.range 43)
      (fun i x => (H12NumericFilters.truthTables[i]! &&& H12NumericFilters.cubeTables[j]!).testBit x) := by
  simp only [tableRows, H12NumericFilters.maskedRows, familyRows, List.map_map, Function.comp_def]

theorem maskedRows_bounds (j : Nat) :
    ∀ row ∈ tableRows (H12NumericFilters.maskedRows j), row.1 < 43 := by
  rw [maskedRows_family]
  intro row hr
  obtain ⟨i, hi, rfl⟩ := List.mem_map.mp hr
  exact List.mem_range.mp hi

theorem masked_value (j : Fin 43) (i x : Nat) (hi : i < 43) (hx : x < 4096) :
    (H12NumericFilters.truthTables[i]! &&& H12NumericFilters.cubeTables[j.val]!).testBit x =
      (zeroCoordinates (excluded supports[j.val]!) x && H12.orbitValue (H12.quarticOrbits[i]!) x) := by
  rw [truth_data_agree, cube_data_exact j, Nat.testBit_and,
    H12Truth.basis_semantics ⟨i,hi⟩ x hx, cubeTable_bit _ x hx]
  exact Bool.and_comm ..

theorem masked_combine (c : BitVec 43) (j : Fin 43) (x : Nat) (hx : x < 4096) :
    combine c.getLsbD (tableRows (H12NumericFilters.maskedRows j.val)) x =
      (zeroCoordinates (excluded supports[j.val]!) x && H12.quarticFunction c x) := by
  rw [maskedRows_family]
  have he := combine_family_congr_at c.getLsbD (List.range 43)
    (fun i x => (H12NumericFilters.truthTables[i]! &&& H12NumericFilters.cubeTables[j.val]!).testBit x)
    (fun i x => zeroCoordinates (excluded supports[j.val]!) x && H12.orbitValue (H12.quarticOrbits[i]!) x)
    x (fun i hi => masked_value j i x (List.mem_range.mp hi) hx)
  rw [he, combine_family_scale, ← originalRows_family, H12FilterBridge.original_combine]

theorem evaluated_fast_filter_zero (c : BitVec 43)
    (hb : H12Descent.BentAC (H12.quarticFunction c)) (j : Fin 43) :
    evaluate 43 c.getLsbD (fastPolynomial 12 (H12NumericFilters.maskedRows j.val)) = false := by
  rw [fastPolynomial_sound]
  change evaluate 43 c.getLsbD (rowPolynomial (List.range 4096)
    (tableRows (H12NumericFilters.maskedRows j.val))) = false
  rw [carry_of_combination 43 c.getLsbD (List.range 4096)
    (tableRows (H12NumericFilters.maskedRows j.val)) (maskedRows_bounds j.val)]
  have hc := carry_congr_on (List.range 4096)
    (combine c.getLsbD (tableRows (H12NumericFilters.maskedRows j.val)))
    (fun x => zeroCoordinates (excluded supports[j.val]!) x && H12.quarticFunction c x)
    (fun x hx => masked_combine c j x (List.mem_range.mp hx))
  rw [hc, ← carry_filter]
  apply H12FilterBridge.carry_zero_of_mod_four
  exact restriction_weight_mod_four _ hb (excluded supports[j.val]!)
    (excluded_lengths j) (excluded_bounds _)
    (by rw [← points_eq_restriction]; exact point_counts j)

theorem values_as_map (c : BitVec 43) : H12Quadratic.values c =
    H12NumericFilters.explicitPolynomials.map (evaluate 43 c.getLsbD) := rfl

theorem map_lookup (xs : List (List Nat)) (f : List Nat → Bool) (i : Nat) (hi : i < xs.length) :
    (xs.map f)[i]! = f xs[i]! := by
  simp [getElem!_pos, hi]

theorem bent_passes (c : BitVec 43)
    (hb : H12Descent.BentAC (H12.quarticFunction c)) : H12Quadratic.Passes c := by
  intro j
  have he := congrArg (evaluate 43 c.getLsbD) (H12NumericFilters.all_filters_exact j)
  rw [evaluate_normalize, evaluate_normalize] at he
  have hz := evaluated_fast_filter_zero c hb j
  have hq := he.symm.trans hz
  rw [values_as_map, map_lookup _ _ j.val (by simpa [H12NumericFilters.explicitPolynomials] using j.isLt)]
  exact hq

#print axioms bent_passes
end H12FilterLink
