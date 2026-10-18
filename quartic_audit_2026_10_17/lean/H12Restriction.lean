import H12Walsh

namespace H12Restriction
open H12Walsh

theorem total_append (xs ys : List α) (f : α → Int) :
    total (xs ++ ys) f = total xs f + total ys f := by
  simp [total, List.map_append, List.sum_append]

theorem dot_comm (n a x : Nat) : dotBits n a x = dotBits n x a := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [dotBits, ih, Bool.and_comm]

theorem character_frequency_xor (a b x : Nat) :
    character (a ^^^ b) x = character a x * character b x := by
  have hc (u v : Nat) : character u v = character v u := congrArg sign (dot_comm 12 u v)
  rw [hc (a ^^^ b) x, character_xor, ← hc a x, ← hc b x]

theorem dot_unit (n i x : Nat) :
    dotBits n (2^i) x = if i < n then x.testBit i else false := by
  induction n with
  | zero => simp [dotBits]
  | succ n ih =>
    rw [dotBits, ih]
    simp only [Nat.testBit_two_pow]
    by_cases he : i = n
    · subst i; simp
    · by_cases hl : i < n
      · simp [he, hl, show i < n+1 by omega]
      · simp [he, hl, show ¬i < n+1 by omega]

theorem character_unit (i x : Nat) (hi : i < 12) :
    character (2^i) x = sign (x.testBit i) := by
  simp only [character, dot_unit, hi, ↓reduceIte]

def frequencySpan : List Nat → List Nat
  | [] => [0]
  | v :: vs => frequencySpan vs ++ (frequencySpan vs).map (fun a => v ^^^ a)

def characterProduct (vs : List Nat) (x : Nat) : Int :=
  vs.foldr (fun v p => (1 + character v x) * p) 1

theorem frequencySpan_length (vs : List Nat) : (frequencySpan vs).length = 2^vs.length := by
  induction vs with
  | nil => rfl
  | cons v vs ih => simp [frequencySpan, ih, Nat.pow_succ, Nat.mul_two]

theorem character_span_sum (vs : List Nat) (x : Nat) :
    total (frequencySpan vs) (fun a => character a x) = characterProduct vs x := by
  induction vs with
  | nil => simp [frequencySpan, characterProduct, total, character_zero_left]
  | cons v vs ih =>
    rw [frequencySpan, total_append]
    have hm : total ((frequencySpan vs).map (fun a => v ^^^ a)) (fun a => character a x) =
        character v x * total (frequencySpan vs) (fun a => character a x) := by
      simp only [total, List.map_map]
      change total (frequencySpan vs) (fun a => character (v ^^^ a) x) = _
      have hp := total_congr (frequencySpan vs) _ _ (fun a _ => character_frequency_xor v a x)
      exact hp.trans (total_mul_left _ _ _)
    rw [hm, ih]
    simp only [characterProduct, List.foldr_cons, Int.add_mul, Int.one_mul]

def zeroCoordinates (is : List Nat) (x : Nat) : Bool := is.all (fun i => !x.testBit i)

theorem zeroCoordinates_cons (i : Nat) (is : List Nat) (x : Nat) :
    zeroCoordinates (i :: is) x = (!x.testBit i && zeroCoordinates is x) := rfl

theorem unit_product (is : List Nat) (x : Nat) (bounds : ∀ i ∈ is, i < 12) :
    characterProduct (is.map (fun i => 2^i)) x =
      if zeroCoordinates is x then (2:Int)^is.length else 0 := by
  induction is with
  | nil => simp [characterProduct, zeroCoordinates]
  | cons i is ih =>
    have hi := bounds i (List.mem_cons_self)
    have ht := ih (fun j hj => bounds j (List.mem_cons_of_mem i hj))
    simp only [List.map_cons, characterProduct, List.foldr_cons] at *
    rw [character_unit i x hi, ht]
    cases hx : x.testBit i <;> cases hz : zeroCoordinates is x <;>
      simp [zeroCoordinates_cons, hx, hz, sign, Int.pow_succ, Int.mul_comm]

theorem total_filter (xs : List α) (p : α → Bool) (f : α → Int) :
    total (xs.filter p) f = total xs (fun x => if p x then f x else 0) := by
  induction xs with
  | nil => rfl
  | cons a xs ih => cases h : p a <;> simp [total, h] at * <;> exact ih

theorem restriction_identity (f : Nat → Bool) (is : List Nat)
    (bounds : ∀ i ∈ is, i < 12) :
    total (frequencySpan (is.map (fun i => 2^i))) (walsh f) =
      (2:Int)^is.length * total ((List.range 4096).filter (zeroCoordinates is)) (fun x => sign (f x)) := by
  rw [show total (frequencySpan (is.map (fun i => 2^i))) (walsh f) =
      total (List.range 4096) (fun x => total (frequencySpan (is.map (fun i => 2^i)))
        (fun a => sign (f x) * character a x)) from total_swap _ _ _]
  have he := total_congr (List.range 4096) _ _ (fun x _ =>
    (total_mul_left (frequencySpan (is.map (fun i => 2^i))) (sign (f x)) (fun a => character a x)))
  rw [he]
  have hf : total (List.range 4096) (fun x => sign (f x) *
        total (frequencySpan (is.map (fun i => 2^i))) (fun a => character a x)) =
      total (List.range 4096) (fun x => if zeroCoordinates is x then
        (2:Int)^is.length * sign (f x) else 0) := by
    apply total_congr
    intro x _
    rw [character_span_sum, unit_product is x bounds]
    cases h : zeroCoordinates is x <;> simp [h, Int.mul_comm]
  rw [hf, ← total_filter, total_mul_left]

theorem total_mod128 (xs : List α) (f : α → Int)
    (h : ∀ x ∈ xs, f x % 128 = 64) :
    total xs f % 128 = (64 * (xs.length : Int)) % 128 := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    have ha := h a List.mem_cons_self
    have ht := ih (fun x hx => h x (List.mem_cons_of_mem a hx))
    simp only [total, List.map_cons, List.sum_cons, List.length_cons] at *
    omega

theorem restriction_sum_divisible (f : Nat → Bool) (hb : H12Descent.BentAC f)
    (is : List Nat) (len : is.length = 4) (bounds : ∀ i ∈ is, i < 12) :
    (8:Int) ∣ total ((List.range 4096).filter (zeroCoordinates is)) (fun x => sign (f x)) := by
  let frequencies := frequencySpan (is.map (fun i => 2^i))
  have hl : frequencies.length = 16 := by
    rw [frequencySpan_length, List.length_map, len]
  have hm : ∀ a ∈ frequencies, walsh f a % 128 = 64 := by
    intro a _
    rcases bent_walsh_values f hb a with h | h <;> rw [h] <;> decide
  have hd := total_mod128 frequencies (walsh f) hm
  rw [hl] at hd
  have hz : total frequencies (walsh f) % 128 = 0 := by simpa using hd
  have hp := restriction_identity f is bounds
  rw [len] at hp
  have hp' : total frequencies (walsh f) = 16 *
      total ((List.range 4096).filter (zeroCoordinates is)) (fun x => sign (f x)) := by
    simpa [frequencies] using hp
  obtain ⟨k,hk⟩ := Int.dvd_of_emod_eq_zero hz
  refine ⟨k, ?_⟩
  omega

theorem total_sign_weight (xs : List α) (f : α → Bool) :
    total xs (fun x => sign (f x)) = (xs.length : Int) - 2 * (xs.countP f : Int) := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    cases h : f a <;> simp [total, sign, h] at * <;> omega

theorem restriction_weight_mod_four (f : Nat → Bool) (hb : H12Descent.BentAC f)
    (is : List Nat) (len : is.length = 4) (bounds : ∀ i ∈ is, i < 12)
    (size : ((List.range 4096).filter (zeroCoordinates is)).length = 256) :
    (((List.range 4096).filter (zeroCoordinates is)).countP f) % 4 = 0 := by
  obtain ⟨k,hk⟩ := restriction_sum_divisible f hb is len bounds
  have hw := total_sign_weight ((List.range 4096).filter (zeroCoordinates is)) f
  rw [size] at hw
  omega

#print axioms restriction_identity
#print axioms restriction_weight_mod_four
end H12Restriction
