import H12Restriction
import H12Weight
import H12Quadratic
import H12Orbit

namespace H12FilterBridge
open H12BooleanPolynomial H12Weight H12Restriction
set_option maxRecDepth 100000
set_option maxHeartbeats 1000000000

def supports : List Nat := [255, 383, 639, 509, 447, 703, 765, 831, 1013, 507, 479, 735, 893, 863, 1375, 763, 927, 1003, 1005, 503, 495, 751, 957, 879, 1391, 891, 943, 1455, 1403, 759, 975, 983, 987, 989, 887, 1399, 955, 951, 1463, 1467, 1495, 1499, 1755]
def excluded (s : Nat) : List Nat := (List.range 12).filter (fun i => !s.testBit i)
theorem zeroCoordinates_subset (s x : Nat) (hx : x < 4096) :
    zeroCoordinates (excluded s) x = ((x &&& s) == x) := by
  apply Bool.eq_iff_iff.mpr
  simp only [beq_iff_eq]
  constructor
  · intro hz
    have hz' := List.all_eq_true.mp hz
    apply Nat.eq_of_testBit_eq
    intro i
    simp only [Nat.testBit_and]
    by_cases hi : i < 12
    · cases hs : s.testBit i
      · have hm : i ∈ excluded s := by simp [excluded, hi, hs]
        have he := hz' i hm
        have hb : x.testBit i = false := by simpa using he
        simp [hs, hb]
      · simp [hs]
    · have hb : x.testBit i = false := Nat.testBit_lt_two_pow
        (Nat.lt_of_lt_of_le hx (Nat.pow_le_pow_right (n:=2) Nat.zero_lt_two (i:=12) (j:=i) (by omega)))
      simp [hb]
  · intro h
    apply List.all_eq_true.mpr
    intro i hi
    have hm := List.mem_filter.mp hi
    have hs : s.testBit i = false := by simpa using hm.2
    have he := congrArg (fun z => z.testBit i) h
    simp only [Nat.testBit_and, hs, Bool.and_false] at he
    simp [← he]

def points (s : Nat) : List Nat := (List.range 4096).filter (fun x => (x &&& s) == x)

theorem points_eq_restriction (s : Nat) :
    points s = (List.range 4096).filter (zeroCoordinates (excluded s)) := by
  apply List.filter_congr
  intro x hx
  exact (zeroCoordinates_subset s x (List.mem_range.mp hx)).symm


def originalRows : List (Nat × (Nat → Bool)) := [(0, fun x => H12.orbitValue (H12.quarticOrbits[(0 : Fin 43).val]!) x),(1, fun x => H12.orbitValue (H12.quarticOrbits[(1 : Fin 43).val]!) x),(2, fun x => H12.orbitValue (H12.quarticOrbits[(2 : Fin 43).val]!) x),(3, fun x => H12.orbitValue (H12.quarticOrbits[(3 : Fin 43).val]!) x),(4, fun x => H12.orbitValue (H12.quarticOrbits[(4 : Fin 43).val]!) x),(5, fun x => H12.orbitValue (H12.quarticOrbits[(5 : Fin 43).val]!) x),(6, fun x => H12.orbitValue (H12.quarticOrbits[(6 : Fin 43).val]!) x),(7, fun x => H12.orbitValue (H12.quarticOrbits[(7 : Fin 43).val]!) x),(8, fun x => H12.orbitValue (H12.quarticOrbits[(8 : Fin 43).val]!) x),(9, fun x => H12.orbitValue (H12.quarticOrbits[(9 : Fin 43).val]!) x),(10, fun x => H12.orbitValue (H12.quarticOrbits[(10 : Fin 43).val]!) x),(11, fun x => H12.orbitValue (H12.quarticOrbits[(11 : Fin 43).val]!) x),(12, fun x => H12.orbitValue (H12.quarticOrbits[(12 : Fin 43).val]!) x),(13, fun x => H12.orbitValue (H12.quarticOrbits[(13 : Fin 43).val]!) x),(14, fun x => H12.orbitValue (H12.quarticOrbits[(14 : Fin 43).val]!) x),(15, fun x => H12.orbitValue (H12.quarticOrbits[(15 : Fin 43).val]!) x),(16, fun x => H12.orbitValue (H12.quarticOrbits[(16 : Fin 43).val]!) x),(17, fun x => H12.orbitValue (H12.quarticOrbits[(17 : Fin 43).val]!) x),(18, fun x => H12.orbitValue (H12.quarticOrbits[(18 : Fin 43).val]!) x),(19, fun x => H12.orbitValue (H12.quarticOrbits[(19 : Fin 43).val]!) x),(20, fun x => H12.orbitValue (H12.quarticOrbits[(20 : Fin 43).val]!) x),(21, fun x => H12.orbitValue (H12.quarticOrbits[(21 : Fin 43).val]!) x),(22, fun x => H12.orbitValue (H12.quarticOrbits[(22 : Fin 43).val]!) x),(23, fun x => H12.orbitValue (H12.quarticOrbits[(23 : Fin 43).val]!) x),(24, fun x => H12.orbitValue (H12.quarticOrbits[(24 : Fin 43).val]!) x),(25, fun x => H12.orbitValue (H12.quarticOrbits[(25 : Fin 43).val]!) x),(26, fun x => H12.orbitValue (H12.quarticOrbits[(26 : Fin 43).val]!) x),(27, fun x => H12.orbitValue (H12.quarticOrbits[(27 : Fin 43).val]!) x),(28, fun x => H12.orbitValue (H12.quarticOrbits[(28 : Fin 43).val]!) x),(29, fun x => H12.orbitValue (H12.quarticOrbits[(29 : Fin 43).val]!) x),(30, fun x => H12.orbitValue (H12.quarticOrbits[(30 : Fin 43).val]!) x),(31, fun x => H12.orbitValue (H12.quarticOrbits[(31 : Fin 43).val]!) x),(32, fun x => H12.orbitValue (H12.quarticOrbits[(32 : Fin 43).val]!) x),(33, fun x => H12.orbitValue (H12.quarticOrbits[(33 : Fin 43).val]!) x),(34, fun x => H12.orbitValue (H12.quarticOrbits[(34 : Fin 43).val]!) x),(35, fun x => H12.orbitValue (H12.quarticOrbits[(35 : Fin 43).val]!) x),(36, fun x => H12.orbitValue (H12.quarticOrbits[(36 : Fin 43).val]!) x),(37, fun x => H12.orbitValue (H12.quarticOrbits[(37 : Fin 43).val]!) x),(38, fun x => H12.orbitValue (H12.quarticOrbits[(38 : Fin 43).val]!) x),(39, fun x => H12.orbitValue (H12.quarticOrbits[(39 : Fin 43).val]!) x),(40, fun x => H12.orbitValue (H12.quarticOrbits[(40 : Fin 43).val]!) x),(41, fun x => H12.orbitValue (H12.quarticOrbits[(41 : Fin 43).val]!) x),(42, fun x => H12.orbitValue (H12.quarticOrbits[(42 : Fin 43).val]!) x)]

theorem originalRows_bounds : ∀ row ∈ originalRows, row.1 < 43 := by
  simp [originalRows]

theorem original_combine (c : BitVec 43) :
    combine c.getLsbD originalRows = H12.quarticFunction c := by
  funext x
  simp only [originalRows, combine, H12.quarticFunction, Bool.xor_false, Bool.xor_assoc]

theorem carry_zero_of_mod_four (xs : List Nat) (f : Nat → Bool)
    (h : xs.countP f % 4 = 0) : carry xs f = false := by
  cases hc : carry xs f
  · rfl
  · have hh : (xs.countP f / 2) % 2 = 1 := by
      simpa only [carry, Nat.testBit_eq_decide_div_mod_eq, Nat.pow_one, decide_eq_true_eq] using hc
    omega

theorem excluded_bounds (s : Nat) : ∀ i ∈ excluded s, i < 12 := by
  intro i hi
  exact List.mem_range.mp (List.mem_filter.mp hi).1

theorem excluded_lengths : ∀ j : Fin 43, (excluded supports[j.val]!).length = 4 := by decide +kernel

theorem point_counts : ∀ j : Fin 43, (points supports[j.val]!).length = 256 := by decide +kernel

theorem computed_filter_necessary (c : BitVec 43)
    (hb : H12Descent.BentAC (H12.quarticFunction c)) (j : Fin 43) :
    evaluate 43 c.getLsbD (rowPolynomial (points supports[j.val]!) originalRows) = false := by
  rw [carry_of_combination 43 c.getLsbD _ _ originalRows_bounds, original_combine]
  apply carry_zero_of_mod_four
  rw [points_eq_restriction]
  exact restriction_weight_mod_four _ hb (excluded supports[j.val]!)
    (excluded_lengths j) (excluded_bounds _)
    (by rw [← points_eq_restriction]; exact point_counts j)

#print axioms computed_filter_necessary
end H12FilterBridge
