import H12Descent

/-! Fourier energy, flatness and rejection witnesses in dimension 12.
The definitions are linked to the original autocorrelation definition, with
no assumed Walsh-flatness premise. This module does not yet check the numeric
global certificate or prove the necessity of its quadratic filters. -/
namespace H12Walsh

def total (xs : List α) (f : α → Int) : Int := (xs.map f).sum

theorem total_add (xs : List α) (f g : α → Int) :
    total xs (fun x => f x + g x) = total xs f + total xs g := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    simp only [total, List.map_cons, List.sum_cons] at *
    rw [ih]; omega

theorem total_mul_left (xs : List α) (c : Int) (f : α → Int) :
    total xs (fun x => c * f x) = c * total xs f := by
  induction xs with
  | nil => simp [total]
  | cons a xs ih =>
    simp only [total, List.map_cons, List.sum_cons] at *
    rw [ih, Int.mul_add]

theorem total_mul_right (xs : List α) (c : Int) (f : α → Int) :
    total xs (fun x => f x * c) = total xs f * c := by
  simpa only [Int.mul_comm] using total_mul_left xs c f

theorem total_congr (xs : List α) (f g : α → Int)
    (h : ∀ x ∈ xs, f x = g x) : total xs f = total xs g := by
  exact congrArg List.sum (List.map_congr_left h)

theorem total_zero (xs : List α) : total xs (fun _ => 0) = 0 := by
  induction xs with
  | nil => rfl
  | cons a xs ih => simpa [total] using ih

theorem total_swap (xs : List α) (ys : List β) (f : α → β → Int) :
    total xs (fun x => total ys (f x)) = total ys (fun y => total xs (fun x => f x y)) := by
  induction xs with
  | nil => exact (total_zero ys).symm
  | cons a xs ih =>
    change total ys (f a) + total xs (fun x => total ys (f x)) =
      total ys (fun y => f a y + total xs (fun x => f x y))
    rw [total_add, ih]

theorem total_permutation (xs ys : List α) (h : xs.Perm ys) (f : α → Int) :
    total xs f = total ys f := by
  induction h with
  | nil => rfl
  | cons a _ ih => simpa [total] using congrArg (fun z => f a + z) ih
  | swap => simp [total, Int.add_left_comm]
  | trans _ _ ih1 ih2 => exact ih1.trans ih2

/- The Fourier energy identity is proved for an arbitrary finite translation
action and real sign character; the H12 XOR/character instantiation is separate. -/
theorem energy_identity (xs : List α) (op : α → α → α) (s chi : α → Int)
    (translate : ∀ x ∈ xs, (xs.map (op x)).Perm xs)
    (character : ∀ x ∈ xs, ∀ a ∈ xs, chi (op x a) = chi x * chi a)
    (unit : ∀ x ∈ xs, chi x * chi x = 1) :
    total xs (fun x => s x * chi x) * total xs (fun x => s x * chi x) =
      total xs (fun a => total xs (fun x => s x * s (op x a)) * chi a) := by
  calc
    _ = total xs (fun x => total xs (fun y => (s x * chi x) * (s y * chi y))) := by
      rw [← total_mul_right]
      apply total_congr
      intro x _
      exact (total_mul_left xs (s x * chi x) (fun y => s y * chi y)).symm
    _ = total xs (fun x => total xs (fun a => s x * s (op x a) * chi a)) := by
      apply total_congr
      intro x hx
      have hp := total_permutation _ _ (translate x hx)
        (fun y => (s x * chi x) * (s y * chi y))
      rw [← hp]
      simp only [total, List.map_map]
      apply congrArg List.sum
      apply List.map_congr_left
      intro a ha
      dsimp [Function.comp_def]
      rw [character x hx a ha]
      calc
        _ = (s x * s (op x a) * chi a) * (chi x * chi x) := by ac_rfl
        _ = s x * s (op x a) * chi a := by rw [unit x hx, Int.mul_one]
    _ = total xs (fun a => total xs (fun x => s x * s (op x a) * chi a)) := total_swap _ _ _
    _ = _ := by
      apply total_congr
      intro a _
      exact total_mul_right xs (chi a) (fun x => s x * s (op x a))

#print axioms energy_identity

theorem xor_translation (a : Nat) (ha : a < 4096) :
    ((List.range 4096).map (fun x => a ^^^ x)).Perm (List.range 4096) := by
  have hinj : ∀ x y : Nat, a ^^^ x = a ^^^ y → x = y := by
    intro x y h
    have hh := congrArg (fun z => a ^^^ z) h
    simpa only [← Nat.xor_assoc, Nat.xor_self, Nat.zero_xor] using hh
  have hnodup : ((List.range 4096).map (fun x => a ^^^ x)).Nodup := by
    exact List.Pairwise.map (R := fun x y : Nat => x ≠ y)
      (fun x => a ^^^ x) (fun x y hne he => hne (hinj x y he)) List.nodup_range
  have hmem : ∀ y, y ∈ (List.range 4096).map (fun x => a ^^^ x) ↔ y ∈ List.range 4096 := by
    intro y
    constructor
    · intro h
      obtain ⟨x,hx,rfl⟩ := List.mem_map.mp h
      exact List.mem_range.mpr (Nat.xor_lt_two_pow (n:=12) ha (List.mem_range.mp hx))
    · intro hy
      apply List.mem_map.mpr
      refine ⟨a ^^^ y, List.mem_range.mpr (Nat.xor_lt_two_pow (n:=12) ha (List.mem_range.mp hy)), ?_⟩
      simp only [← Nat.xor_assoc, Nat.xor_self, Nat.zero_xor]
  apply List.perm_iff_count.mpr
  intro y
  simp only [hnodup.count, List.nodup_range.count, hmem y]

def sign (b : Bool) : Int := if b then -1 else 1

theorem sign_xor : ∀ a b : Bool, sign (a ^^ b) = sign a * sign b := by decide
theorem sign_square : ∀ a : Bool, sign a * sign a = 1 := by decide

def dotBits : Nat → Nat → Nat → Bool
  | 0, _, _ => false
  | n+1, a, x => dotBits n a x ^^ (a.testBit n && x.testBit n)

theorem xor_distribute : ∀ a b c d : Bool,
    ((a ^^ b) ^^ (c ^^ d)) = ((a ^^ c) ^^ (b ^^ d)) := by decide

theorem dotBits_xor (n a x y : Nat) :
    dotBits n a (x ^^^ y) = (dotBits n a x ^^ dotBits n a y) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [dotBits, Nat.testBit_xor, Bool.and_xor_distrib_left, ih]
    exact xor_distribute _ _ _ _

theorem dotBits_zero (n a : Nat) : dotBits n a 0 = false := by
  induction n with
  | zero => rfl
  | succ n ih => simp [dotBits, ih]

def character (a x : Nat) : Int := sign (dotBits 12 a x)

theorem character_xor (a x y : Nat) :
    character a (x ^^^ y) = character a x * character a y := by
  exact (congrArg sign (dotBits_xor 12 a x y)).trans (sign_xor _ _)

theorem character_zero (a : Nat) : character a 0 = 1 := by
  simp [character, dotBits_zero, sign]

theorem derivative_product (f : Nat → Bool) (u x : Nat) :
    sign (f x) * sign (f (x ^^^ u)) = H12Descent.derivativeSign f u x := by
  cases h1 : f x <;> cases h2 : f (x ^^^ u) <;>
    simp [sign, H12Descent.derivativeSign, h1, h2]

theorem total_one (xs : List α) : total xs (fun _ => 1) = (xs.length : Int) := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    simp only [total, List.map_cons, List.sum_cons, List.length_cons] at *
    rw [ih]; omega

theorem total_range_single (n : Nat) (g : Nat → Int)
    (hz : ∀ i, i < n+1 → i ≠ 0 → g i = 0) :
    total (List.range (n+1)) g = g 0 := by
  induction n with
  | zero => simp [total]
  | succ n ih =>
    rw [List.range_succ]
    simp only [total, List.map_append, List.sum_append, List.map_cons, List.map_nil,
      List.sum_cons, List.sum_nil, Int.add_zero]
    change total (List.range (n+1)) g + g (n+1) = g 0
    rw [ih (fun i hi hn => hz i (by omega) hn), hz (n+1) (by omega) (by omega), Int.add_zero]

def walsh (f : Nat → Bool) (a : Nat) : Int :=
  total (List.range 4096) (fun x => sign (f x) * character a x)

theorem walsh_as_signed_sum (f : Nat → Bool) (a : Nat) :
    walsh f a = total (List.range 4096) (fun x => sign (f x ^^ dotBits 12 a x)) :=
  total_congr _ _ _ (fun x _ => (sign_xor _ _).symm)

theorem bent_walsh_square (f : Nat → Bool) (hb : H12Descent.BentAC f) (a : Nat) :
    walsh f a * walsh f a = 4096 := by
  have he := energy_identity (List.range 4096) Nat.xor (fun x => sign (f x)) (character a)
    (fun x hx => xor_translation x (List.mem_range.mp hx))
    (fun x _ y _ => character_xor a x y)
    (fun x _ => sign_square _)
  change walsh f a * walsh f a = _ at he
  rw [he]
  have hz (u : Nat) (hu : u < 4096) (hn : u ≠ 0) :
      total (List.range 4096) (fun x => sign (f x) * sign (f (x ^^^ u))) * character a u = 0 := by
    have hp : total (List.range 4096) (fun x => sign (f x) * sign (f (x ^^^ u))) =
        total (List.range 4096) (H12Descent.derivativeSign f u) :=
      total_congr _ _ _ (fun x _ => derivative_product f u x)
    rw [hp, show total (List.range 4096) (H12Descent.derivativeSign f u) = 0 from hb u hu hn]
    exact Int.zero_mul _
  have hs := total_range_single 4095 _ hz
  change total (List.range 4096) _ = _ at hs
  apply Eq.trans hs
  rw [character_zero, Int.mul_one]
  calc
    _ = total (List.range 4096) (fun _ => 1) := by
      apply total_congr
      intro x _
      simp only [Nat.xor_zero]
      exact sign_square _
    _ = 4096 := by rw [total_one, List.length_range]; decide

#print axioms bent_walsh_square

theorem bent_walsh_values (f : Nat → Bool) (hb : H12Descent.BentAC f) (a : Nat) :
    walsh f a = 64 ∨ walsh f a = -64 := by
  have hs : (walsh f a).natAbs * (walsh f a).natAbs = 64 * 64 := by
    simpa using Int.natAbs_mul_natAbs_eq (bent_walsh_square f hb a)
  have ha : (walsh f a).natAbs = 64 := Nat.mul_self_inj.mp hs
  exact Int.natAbs_eq_iff.mp ha

theorem walsh_witness_rejects (f : Nat → Bool) (a : Nat) (w : Int)
    (value : walsh f a = w) (bad_square : w * w ≠ 4096) :
    ¬H12Descent.BentAC f := by
  intro hb
  apply bad_square
  simpa only [value] using bent_walsh_square f hb a

#print axioms bent_walsh_values
#print axioms walsh_witness_rejects

theorem character_zero_left (x : Nat) : character 0 x = 1 := by
  have h : ∀ n, dotBits n 0 x = false := by
    intro n
    induction n with
    | zero => rfl
    | succ n ih => simp [dotBits, ih]
  simp [character, h, sign]

theorem constant_zero_walsh : walsh (fun _ => false) 0 = 4096 := by
  unfold walsh
  have h : total (List.range 4096) (fun x => sign false * character 0 x) =
      total (List.range 4096) (fun _ => 1) := by
    apply total_congr
    intro x _
    simp [character_zero_left, sign]
  rw [h, total_one, List.length_range]
  decide

example : ¬H12Descent.BentAC (fun _ => false) :=
  walsh_witness_rejects _ 0 4096 constant_zero_walsh (by decide +kernel)
end H12Walsh
