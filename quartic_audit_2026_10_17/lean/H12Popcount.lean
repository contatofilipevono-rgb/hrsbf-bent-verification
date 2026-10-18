import H12Bits

namespace H12Popcount

def bv (b : Bool) : Nat := if b then 1 else 0

def read : Nat → List Nat → Nat → Nat
  | 0, _, _ => 0
  | k+1, ps, x => bv ((ps.headD 0).testBit x) + 2 * read k ps.tail x

def add : Nat → List Nat → List Nat → Nat → List Nat × Nat
  | 0, _, _, carry => ([], carry)
  | k+1, as, bs, carry =>
    let a := as.headD 0
    let b := bs.headD 0
    let s := a ^^^ b ^^^ carry
    let c := (a &&& b) ||| ((a ^^^ b) &&& carry)
    let result := add k as.tail bs.tail c
    (s :: result.1, result.2)

theorem full_adder (a b c : Bool) :
    bv a + bv b + bv c = bv (a ^^ b ^^ c) + 2 * bv ((a && b) || ((a ^^ b) && c)) := by
  cases a <;> cases b <;> cases c <;> decide

theorem add_sound (k : Nat) (as bs : List Nat) (carry x : Nat) :
    read k as x + read k bs x + bv (carry.testBit x) =
      read k (add k as bs carry).1 x + 2^k * bv ((add k as bs carry).2.testBit x) := by
  induction k generalizing as bs carry with
  | zero => simp [read, add]
  | succ k ih =>
    have ht := ih as.tail bs.tail ((as.headD 0 &&& bs.headD 0) |||
      ((as.headD 0 ^^^ bs.headD 0) &&& carry))
    have hf := full_adder ((as.headD 0).testBit x) ((bs.headD 0).testBit x) (carry.testBit x)
    simp only [add, read, List.headD_cons, List.tail_cons, Nat.testBit_xor,
      Nat.testBit_or, Nat.testBit_and, Nat.pow_succ] at *
    rw [Nat.mul_assoc (2^k) 2, Nat.mul_left_comm (2^k) 2]
    omega

theorem read_bound (k : Nat) (ps : List Nat) (x : Nat) : read k ps x < 2^k := by
  induction k generalizing ps with
  | zero => simp [read]
  | succ k ih =>
    have hb : bv ((ps.headD 0).testBit x) ≤ 1 := by
      cases (ps.headD 0).testBit x <;> decide
    have ht := ih ps.tail
    simp only [read, Nat.pow_succ]
    omega

#print axioms add_sound

theorem add_exact (k : Nat) (as bs : List Nat) (x : Nat)
    (h : read k as x + read k bs x < 2^k) :
    read k (add k as bs 0).1 x = read k as x + read k bs x := by
  have he := add_sound k as bs 0 x
  cases hb : ((add k as bs 0).2).testBit x <;> simp [bv, hb] at he <;> omega

theorem read_shift (k : Nat) (ps : List Nat) (shift x : Nat) :
    read k (ps.map (fun p => p >>> shift)) x = read k ps (x+shift) := by
  induction k generalizing ps with
  | zero => rfl
  | succ k ih =>
    cases ps with
    | nil => simp only [List.map_nil, read, List.headD_nil, List.tail_nil, Nat.zero_testBit]; exact congrArg (fun z => bv false + 2*z) (ih [])
    | cons p ps => simp only [List.map_cons, read, List.headD_cons, List.tail_cons, Nat.testBit_shiftRight, Nat.add_comm shift x, ih]

def sum (xs : List α) (f : α → Nat) := (xs.map f).sum

theorem sum_add (xs : List α) (f g : α → Nat) :
    sum xs (fun x => f x + g x) = sum xs f + sum xs g := by
  induction xs with
  | nil => rfl
  | cons a xs ih => simp only [sum, List.map_cons, List.sum_cons] at *; omega

theorem sum_congr (xs : List α) (f g : α → Nat) (h : ∀ x ∈ xs, f x = g x) :
    sum xs f = sum xs g := congrArg List.sum (List.map_congr_left h)

def fold : Nat → Nat → List Nat → List Nat
  | 0, _, ps => ps
  | n+1, k, ps => fold n k (add k ps (ps.map (fun p => p >>> (2^n))) 0).1

theorem fold_sound (depth k : Nat) (ps : List Nat) (bound : Nat)
    (hb : ∀ x, read k ps x ≤ bound) (hw : 2^depth * bound < 2^k) (x : Nat) :
    read k (fold depth k ps) x = sum (List.range (2^depth)) (fun j => read k ps (x+j)) := by
  induction depth generalizing ps bound with
  | zero => simp [fold, sum]
  | succ n ih =>
    let next := (add k ps (ps.map (fun p => p >>> (2^n))) 0).1
    have htwo : 2*bound < 2^k := by
      have hp : 1 ≤ 2^n := Nat.one_le_two_pow
      have hg := Nat.mul_le_mul_right (2*bound) hp
      simp only [Nat.pow_succ] at hw
      rw [Nat.mul_assoc] at hw
      omega
    have hn (y : Nat) : read k next y = read k ps y + read k ps (y+2^n) := by
      unfold next
      rw [add_exact]
      · rw [read_shift]
      · rw [read_shift]; have h1 := hb y; have h2 := hb (y+2^n); omega
    have hnb (y : Nat) : read k next y ≤ 2*bound := by
      rw [hn]; have h1 := hb y; have h2 := hb (y+2^n); omega
    have hkw : 2^n * (2*bound) < 2^k := by
      simpa only [Nat.pow_succ, Nat.mul_assoc] using hw
    change read k (fold n k next) x = _
    rw [ih next (2*bound) hnb hkw]
    have hs : sum (List.range (2^n)) (fun j => read k next (x+j)) =
        sum (List.range (2^n)) (fun j => read k ps (x+j) + read k ps (x+2^n+j)) := by
      apply sum_congr; intro j _; rw [hn]; congr 2; omega
    rw [hs, sum_add]
    simp only [Nat.pow_succ, Nat.mul_two, List.range_add, sum, List.map_append,
      List.sum_append, List.map_map, Function.comp_def]
    congr 2
    apply List.map_congr_left
    intro j _
    congr 1
    omega

#print axioms fold_sound

theorem read_nil (k x : Nat) : read k [] x = 0 := by
  induction k with
  | zero => rfl
  | succ k ih => simp [read, ih, bv]

theorem read_single (k v x : Nat) : read (k+1) [v] x = bv (v.testBit x) := by
  simp [read, read_nil]

theorem sum_bv (xs : List α) (f : α → Bool) : sum xs (fun x => bv (f x)) = xs.countP f := by
  induction xs with
  | nil => rfl
  | cons a xs ih => cases ha : f a <;> simp [sum, bv, ha] at * <;> omega

def fastWeight (depth value : Nat) : Nat := read (depth+1) (fold depth (depth+1) [value]) 0

theorem fastWeight_sound (depth value : Nat) : fastWeight depth value =
    (List.range (2^depth)).countP (fun x => value.testBit x) := by
  unfold fastWeight
  have hb (x : Nat) : read (depth+1) [value] x ≤ 1 := by
    rw [read_single]; cases value.testBit x <;> decide
  have hw : 2^depth * 1 < 2^(depth+1) := by
    have h := Nat.two_pow_pos depth
    simp only [Nat.pow_succ, Nat.mul_one]
    omega
  rw [fold_sound depth (depth+1) [value] 1 hb hw]
  simp only [read_single, Nat.zero_add]
  exact sum_bv _ _

example : fastWeight 3 0b10110101 = 5 := by decide +kernel
example : fastWeight 12 (2^4096-1) = 4096 := by decide +kernel
#print axioms fastWeight_sound



theorem add_mod (k : Nat) (as bs : List Nat) (x : Nat) :
    read k (add k as bs 0).1 x = (read k as x + read k bs x) % 2^k := by
  have he := add_sound k as bs 0 x
  have hb := read_bound k (add k as bs 0).1 x
  cases ho : ((add k as bs 0).2).testBit x <;> simp [bv, ho] at he
  · rw [← he, Nat.mod_eq_of_lt (by omega)]
  · rw [he, Nat.add_mod_right, Nat.mod_eq_of_lt hb]

#print axioms add_mod

theorem sum_mod_congr (xs : List α) (f g : α → Nat) (m : Nat)
    (h : ∀ x ∈ xs, f x % m = g x % m) : sum xs f % m = sum xs g % m := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    have ha := h a List.mem_cons_self
    have ht := ih (fun x hx => h x (List.mem_cons_of_mem a hx))
    simp only [sum, List.map_cons, List.sum_cons] at *
    simp only [Nat.add_mod, ha, ht, Nat.mod_mod]

#print axioms sum_mod_congr

theorem fold_mod_sound (depth k : Nat) (ps : List Nat) (x : Nat) :
    read k (fold depth k ps) x =
      sum (List.range (2^depth)) (fun j => read k ps (x+j)) % 2^k := by
  induction depth generalizing ps with
  | zero => simp [fold, sum, Nat.mod_eq_of_lt (read_bound k ps x)]
  | succ n ih =>
    let next := (add k ps (ps.map (fun p => p >>> (2^n))) 0).1
    have hn (y : Nat) : read k next y = (read k ps y + read k ps (y+2^n)) % 2^k := by
      unfold next
      rw [add_mod, read_shift]
    change read k (fold n k next) x = _
    rw [ih]
    have hs : sum (List.range (2^n)) (fun j => read k next (x+j)) % 2^k =
        sum (List.range (2^n)) (fun j => read k ps (x+j) + read k ps (x+2^n+j)) % 2^k := by
      apply sum_mod_congr
      intro j _
      rw [hn, Nat.mod_mod, show x+j+2^n = x+2^n+j by omega]
    rw [hs, sum_add]
    simp only [Nat.pow_succ, Nat.mul_two, List.range_add, sum, List.map_append,
      List.sum_append, List.map_map, Function.comp_def]
    congr 3
    apply List.map_congr_left
    intro j _
    congr 1
    omega

#print axioms fold_mod_sound

def fastWeightMod (depth bits value : Nat) := read bits (fold depth bits [value]) 0

theorem fastWeightMod_sound (depth bits value : Nat) (hb : 0 < bits) :
    fastWeightMod depth bits value =
      (List.range (2^depth)).countP value.testBit % 2^bits := by
  obtain ⟨k,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : bits ≠ 0)
  rw [fastWeightMod, fold_mod_sound]
  simp only [read_single, Nat.zero_add]
  rw [sum_bv]

#print axioms fastWeightMod_sound




end H12Popcount





