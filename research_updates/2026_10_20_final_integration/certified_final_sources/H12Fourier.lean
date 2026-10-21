import H12Restriction

namespace H12Fourier
open H12Walsh H12Restriction

def frequencies : List Nat := frequencySpan ((List.range 12).map (fun i => 2^i))

theorem zero_coordinates_iff (z : Nat) (hz : z < 4096) :
    zeroCoordinates (List.range 12) z = decide (z = 0) := by
  apply Bool.eq_iff_iff.mpr
  simp only [decide_eq_true_eq]
  constructor
  · intro h
    have hv : BitVec.ofNat 12 z = BitVec.ofNat 12 0 := by
      apply BitVec.eq_of_getLsbD_eq
      intro i hi
      have hb : z.testBit i = false := by
        simpa using List.all_eq_true.mp h i (List.mem_range.mpr hi)
      simp only [BitVec.getLsbD_ofNat, hi, decide_true, Bool.true_and, hb, Nat.zero_testBit]
    simpa [BitVec.toNat_ofNat, Nat.mod_eq_of_lt hz] using congrArg BitVec.toNat hv
  · intro h
    subst z
    simp [zeroCoordinates]

theorem character_orthogonality (z : Nat) (hz : z < 4096) :
    total frequencies (fun a => character a z) = if z = 0 then 4096 else 0 := by
  have hs := character_span_sum ((List.range 12).map (fun i => 2^i)) z
  rw [unit_product (List.range 12) z (fun i hi => List.mem_range.mp hi)] at hs
  simpa [frequencies, zero_coordinates_iff z hz,
    show (2:Int)^12 = 4096 from by decide] using hs

theorem span_bounds (vs : List Nat) (bounds : ∀ v ∈ vs, v < 4096) :
    ∀ a ∈ frequencySpan vs, a < 4096 := by
  induction vs with
  | nil =>
    intro a ha
    have he : a = 0 := by simpa [frequencySpan] using ha
    subst a
    decide
  | cons v vs ih =>
    intro a ha
    have ht := ih (fun w hw => bounds w (List.mem_cons_of_mem v hw))
    rcases List.mem_append.mp ha with ha | ha
    · exact ht a ha
    · obtain ⟨b,hb,rfl⟩ := List.mem_map.mp ha
      exact Nat.xor_lt_two_pow (n:=12) (bounds v List.mem_cons_self) (ht b hb)

theorem frequencies_bounds : ∀ a ∈ frequencies, a < 4096 := by
  apply span_bounds
  intro v hv
  obtain ⟨i,hi,rfl⟩ := List.mem_map.mp hv
  have h : ∀ i : Fin 12, 2^i.val < 4096 := by decide +kernel
  exact h ⟨i,List.mem_range.mp hi⟩

theorem total_cons (a : α) (xs : List α) (f : α → Int) : total (a::xs) f = f a + total xs f := rfl

theorem total_indicator (xs : List Nat) (z : Nat) (value : Int) :
    total xs (fun x => if x = z then value else 0) = value * (xs.count z : Int) := by
  induction xs with
  | nil => simp [total]
  | cons a xs ih =>
    rw [total_cons, ih]
    by_cases h : a = z <;> simp [h, Int.mul_add, Int.add_comm]

#print axioms character_orthogonality


theorem total_point (xs : List Nat) (z : Nat) (value : Int)
    (hn : xs.Nodup) (hz : z ∈ xs) :
    total xs (fun x => if x = z then value else 0) = value := by
  rw [total_indicator, hn.count]
  simp [hz]

theorem fourier_inversion (g : Nat → Int) (u : Nat) (hu : u < 4096) :
    total frequencies (fun a =>
      total (List.range 4096) (fun x => g x * character a x) * character a u) = 4096 * g u := by
  have he : total frequencies (fun a =>
      total (List.range 4096) (fun x => g x * character a x) * character a u) =
      total (List.range 4096) (fun x => g x * total frequencies (fun a => character a (x ^^^ u))) := by
    calc
      _ = total frequencies (fun a => total (List.range 4096)
            (fun x => g x * character a x * character a u)) := by
        apply total_congr
        intro a _
        exact (total_mul_right _ _ _).symm
      _ = total (List.range 4096) (fun x => total frequencies
            (fun a => g x * character a x * character a u)) := total_swap _ _ _
      _ = _ := by
        apply total_congr
        intro x _
        rw [← total_mul_left]
        apply total_congr
        intro a _
        rw [character_xor, Int.mul_assoc]
  rw [he]
  have hp : total (List.range 4096) (fun x => g x *
      total frequencies (fun a => character a (x ^^^ u))) =
      total (List.range 4096) (fun x => if x = u then 4096 * g u else 0) := by
    apply total_congr
    intro x hx
    rw [character_orthogonality (x ^^^ u)
      (Nat.xor_lt_two_pow (n:=12) (List.mem_range.mp hx) hu)]
    by_cases h : x = u
    · subst x; simp [Int.mul_comm]
    · have hxor : x ^^^ u ≠ 0 := by
        intro heq
        have heq' := congrArg (fun z => z ^^^ u) heq
        simp only [Nat.xor_assoc, Nat.xor_self, Nat.xor_zero, Nat.zero_xor] at heq'
        exact h heq'
      simp [h, hxor]
  rw [hp]
  exact total_point _ _ _ List.nodup_range (List.mem_range.mpr hu)


def WalshFlat (f : Nat → Bool) : Prop :=
  ∀ a, a < 4096 → walsh f a * walsh f a = 4096

theorem flat_implies_bent (f : Nat → Bool) (hf : WalshFlat f) : H12Descent.BentAC f := by
  intro u hu hn
  let ac := fun v => total (List.range 4096) (fun x => sign (f x) * sign (f (x ^^^ v)))
  have he (a : Nat) : walsh f a * walsh f a =
      total (List.range 4096) (fun v => ac v * character a v) :=
    energy_identity (List.range 4096) Nat.xor (fun x => sign (f x)) (character a)
      (fun x hx => xor_translation x (List.mem_range.mp hx))
      (fun x _ y _ => character_xor a x y)
      (fun x _ => sign_square _)
  have hi := fourier_inversion ac u hu
  have hz : total frequencies (fun a =>
      total (List.range 4096) (fun x => ac x * character a x) * character a u) = 0 := by
    calc
      _ = total frequencies (fun a => 4096 * character a u) := by
        apply total_congr
        intro a ha
        rw [← he, hf a (frequencies_bounds a ha)]
      _ = 4096 * total frequencies (fun a => character a u) := total_mul_left _ _ _
      _ = 0 := by rw [character_orthogonality u hu, ite_eq_right hn, Int.mul_zero]
  have hac : ac u = 0 := by omega
  change total (List.range 4096) (H12Descent.derivativeSign f u) = 0
  calc
    _ = ac u := (total_congr _ _ _ (fun x _ => (derivative_product f u x).symm))
    _ = 0 := hac

theorem bent_iff_flat (f : Nat → Bool) : H12Descent.BentAC f ↔ WalshFlat f := by
  constructor
  · intro hb a _; exact bent_walsh_square f hb a
  · exact flat_implies_bent f

#print axioms fourier_inversion
#print axioms bent_iff_flat

end H12Fourier

