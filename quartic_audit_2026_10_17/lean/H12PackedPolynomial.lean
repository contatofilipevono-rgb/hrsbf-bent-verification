import H12CertificateTheory

namespace H12PackedPolynomial
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000
open H12BooleanPolynomial H12CertificateTheory

def unpack : List Nat → Nat → List Nat
  | [], _ => []
  | m::ms, word => if word.testBit 0 then m :: unpack ms (word >>> 1) else unpack ms (word >>> 1)

def value (n : Nat) (f : Nat → Bool) (book : List Nat) (word : Nat) : Bool :=
  evaluate n f (unpack book word)

theorem value_zero (n : Nat) (f : Nat → Bool) (book : List Nat) : value n f book 0 = false := by
  induction book with
  | nil => rfl
  | cons m ms ih => simpa [value, unpack] using ih

theorem cancel_double : ∀ a b : Bool, (a ^^ (a ^^ b)) = b := by decide

theorem value_xor (n : Nat) (f : Nat → Bool) (book : List Nat) (a b : Nat) :
    value n f book (a ^^^ b) = (value n f book a ^^ value n f book b) := by
  induction book generalizing a b with
  | nil => rfl
  | cons m ms ih =>
    simp only [value] at *
    cases ha : a.testBit 0 <;> cases hb : b.testBit 0 <;>
      simp only [unpack, Nat.testBit_xor, Nat.shiftRight_xor_distrib, ha, hb,
        Bool.false_xor, Bool.true_xor, Bool.not_false, Bool.not_true, ↓reduceIte,
        evaluate_cons, ih, Bool.false_eq_true, cancel_double, xor_interleave, Bool.xor_assoc, Bool.xor_left_comm]

def applyWord : List Nat → Nat → Nat
  | [], _ => 0
  | v::vs, word => (if word.testBit 0 then v else 0) ^^^ applyWord vs (word >>> 1)

theorem matrix_semantics (n : Nat) (f g : Nat → Bool) (book : List Nat)
    (rows : List (Nat × Nat)) (hrows : ∀ row ∈ rows, value n f book row.2 = monomial n g row.1)
    (word : Nat) : value n f book (applyWord (rows.map Prod.snd) word) =
      evaluate n g (unpack (rows.map Prod.fst) word) := by
  induction rows generalizing word with
  | nil => exact value_zero n f book
  | cons row rows ih =>
    have hh := hrows row List.mem_cons_self
    have ht := ih (fun row hr => hrows row (List.mem_cons_of_mem _ hr)) (word >>> 1)
    simp only [List.map_cons, applyWord, value_xor]
    cases hw : word.testBit 0 <;>
      simp only [hw, Bool.false_eq_true, ↓reduceIte, value_zero, Bool.false_xor, hh, ht,
        unpack, evaluate_cons]

#print axioms value_xor
#print axioms matrix_semantics

theorem value_unit (n : Nat) (f : Nat → Bool) (book : List Nat) (j : Nat) (hj : j < book.length) :
    value n f book (2^j) = monomial n f book[j] := by
  induction book generalizing j with
  | nil => simp at hj
  | cons m ms ih =>
    cases j with
    | zero =>
      change (monomial n f m ^^ value n f ms 0) = monomial n f m
      rw [value_zero, Bool.xor_false]
    | succ j =>
      have hb : (2^(j+1)).testBit 0 = false := by simp [Nat.testBit_two_pow]
      have hs : (2^(j+1)) >>> 1 = 2^j := by
        simp [Nat.shiftRight_eq_div_pow, Nat.pow_succ]
      simp only [value, unpack, hb, Bool.false_eq_true, ↓reduceIte, hs]
      exact ih j (by simpa using hj)

def encode (book : List Nat) (polynomial : List Nat) : Nat :=
  polynomial.foldr (fun m word => (2^(book.idxOf m)) ^^^ word) 0

theorem encode_sound (n : Nat) (f : Nat → Bool) (book polynomial : List Nat)
    (h : ∀ m ∈ polynomial, m ∈ book) : value n f book (encode book polynomial) = evaluate n f polynomial := by
  induction polynomial with
  | nil => exact value_zero n f book
  | cons m ms ih =>
    have hm := h m List.mem_cons_self
    have hj := List.idxOf_lt_length_of_mem hm
    change value n f book ((2^(book.idxOf m)) ^^^ encode book ms) =
      (monomial n f m ^^ evaluate n f ms)
    rw [value_xor, value_unit n f book _ hj, List.getElem_idxOf hj,
      ih (fun t ht => h t (List.mem_cons_of_mem m ht))]

def substitutionColumns (book : List Nat) (i : Nat) (form : List Nat) : List Nat :=
  book.map (fun m => encode book (substituteMonomial i form m))

theorem substitution_sound (n : Nat) (f : Nat → Bool) (book : List Nat) (i : Nat) (hi : i < n)
    (form : List Nat) (closed : ∀ m ∈ book, ∀ t ∈ substituteMonomial i form m, t ∈ book)
    (word : Nat) :
    value n f book (applyWord (substitutionColumns book i form) word) =
      value n (update f i (evaluate n f form)) book word := by
  let rows := book.map (fun m => (m, encode book (substituteMonomial i form m)))
  have hr : ∀ row ∈ rows, value n f book row.2 =
      monomial n (update f i (evaluate n f form)) row.1 := by
    intro row hrow
    obtain ⟨m,hm,rfl⟩ := List.mem_map.mp hrow
    exact (encode_sound n f book _ (closed m hm)).trans (evaluate_substitute_monomial n f i hi form m)
  have he := matrix_semantics n f (update f i (evaluate n f form)) book rows hr word
  simpa [rows, substitutionColumns, List.map_map, Function.comp_def, value] using he

#print axioms encode_sound
#print axioms substitution_sound

def LinearMask (n m : Nat) : Prop := m = 0 ∨ ∃ i, i < n ∧ 2^i = m

def QuadraticMask (n m : Nat) : Prop := LinearMask n m ∨
  ∃ a, a < n ∧ ∃ b, b < n ∧ (2^a ||| 2^b) = m

def quadraticBook (n : Nat) : List Nat :=
  0 :: ((List.range n).map (fun i => 2^i) ++
    (List.range n).flatMap (fun a => (List.range n).map (fun b => 2^a ||| 2^b)))

theorem quadraticBook_member (n m : Nat) : m ∈ quadraticBook n ↔ QuadraticMask n m := by
  simp [quadraticBook, QuadraticMask, LinearMask, List.mem_flatMap, or_assoc]

theorem clear_pair (a b : Nat) : ((2^a ||| 2^b) ^^^ 2^a) = if a = b then 0 else 2^b := by
  by_cases hab : a = b
  · subst b; simp
  · rw [if_neg hab]
    apply Nat.eq_of_testBit_eq
    intro j
    simp only [Nat.testBit_xor, Nat.testBit_or, Nat.testBit_two_pow]
    by_cases ha : a = j <;> by_cases hb : b = j <;> simp_all

theorem cleared_linear (n m i : Nat) (hq : QuadraticMask n m) (hb : m.testBit i = true) :
    LinearMask n (m ^^^ 2^i) := by
  rcases hq with (hzero | ⟨j,hj,he⟩) | ⟨a,ha,b,hb',he⟩
  · subst m; simp at hb
  · subst m
    have hji : j = i := by simpa only [Nat.testBit_two_pow, decide_eq_true_eq] using hb
    subst i
    left; exact Nat.xor_self _
  · subst m
    have hi : a = i ∨ b = i := by
      simpa only [Nat.testBit_or, Nat.testBit_two_pow, Bool.or_eq_true, decide_eq_true_eq] using hb
    rcases hi with hi | hi
    · subst i
      rw [clear_pair]
      by_cases he : a = b
      · simp only [he, ↓reduceIte]; exact Or.inl rfl
      · rw [if_neg he]; exact Or.inr ⟨b,hb',rfl⟩
    · subst i
      rw [Nat.or_comm (2^a) (2^b), clear_pair]
      by_cases he : b = a
      · simp only [he, ↓reduceIte]; exact Or.inl rfl
      · rw [if_neg he]; exact Or.inr ⟨a,ha,rfl⟩

theorem linear_union (n a b : Nat) (ha : LinearMask n a) (hb : LinearMask n b) :
    QuadraticMask n (a ||| b) := by
  rcases ha with rfl | ⟨i,hi,rfl⟩
  · rw [Nat.zero_or]; exact Or.inl hb
  · rcases hb with rfl | ⟨j,hj,rfl⟩
    · rw [Nat.or_zero]; exact Or.inl (Or.inr ⟨i,hi,rfl⟩)
    · exact Or.inr ⟨i,hi,j,hj,rfl⟩

theorem quadratic_substitution_closed (n i : Nat) (form : List Nat)
    (hf : ∀ a ∈ form, LinearMask n a) :
    ∀ m ∈ quadraticBook n, ∀ t ∈ substituteMonomial i form m, t ∈ quadraticBook n := by
  intro m hm t ht
  apply (quadraticBook_member n t).mpr
  have hq := (quadraticBook_member n m).mp hm
  unfold substituteMonomial at ht
  split at ht
  · rename_i hb
    obtain ⟨a,ha,rfl⟩ := List.mem_map.mp ht
    exact linear_union n a _ (hf a ha) (cleared_linear n m i hq hb)
  · have he : t = m := by simpa using ht
    subst t; exact hq

theorem quadratic_substitution_sound (n : Nat) (f : Nat → Bool) (i : Nat) (hi : i < n)
    (form : List Nat) (hf : ∀ a ∈ form, LinearMask n a) (word : Nat) :
    value n f (quadraticBook n) (applyWord (substitutionColumns (quadraticBook n) i form) word) =
      value n (update f i (evaluate n f form)) (quadraticBook n) word :=
  substitution_sound n f _ i hi form (quadratic_substitution_closed n i form hf) word

#print axioms quadratic_substitution_sound

theorem unpack_append (pre post : List Nat) (word : Nat) :
    unpack (pre ++ post) word = unpack pre word ++ unpack post (word >>> pre.length) := by
  induction pre generalizing word with
  | nil => simp [unpack]
  | cons m pre ih =>
    cases hb : word.testBit 0 <;>
      simp only [List.cons_append, unpack, hb, Bool.false_eq_true, ↓reduceIte,
        ih, List.length_cons, Nat.add_comm pre.length 1, Nat.shiftRight_add, List.cons_append]

theorem value_append (n : Nat) (f : Nat → Bool) (pre post : List Nat) (word : Nat) :
    value n f (pre ++ post) word = (value n f pre word ^^ value n f post (word >>> pre.length)) := by
  simp only [value, unpack_append, evaluate_append]

theorem unpack_prefix_zero (pre : List Nat) (word : Nat) :
    unpack pre (word <<< pre.length) = [] := by
  induction pre generalizing word with
  | nil => rfl
  | cons m pre ih =>
    have hb : (word <<< (pre.length+1)).testBit 0 = false := by simp
    have hs : (word <<< (pre.length+1)) >>> 1 = word <<< pre.length := by
      simp only [Nat.shiftLeft_eq, Nat.shiftRight_eq_div_pow, Nat.pow_succ, Nat.pow_one]
      rw [← Nat.mul_assoc]
      exact Nat.mul_div_cancel _ (by decide)
    simp only [List.length_cons, unpack, hb, Bool.false_eq_true, ↓reduceIte, hs]
    exact ih word

theorem value_shift_prefix (n : Nat) (f : Nat → Bool) (pre post : List Nat) (word : Nat) :
    value n f (pre ++ post) (word <<< pre.length) = value n f post word := by
  rw [value_append]
  have hp : value n f pre (word <<< pre.length) = false := by
    rw [value, unpack_prefix_zero]; rfl
  have hs : (word <<< pre.length) >>> pre.length = word := by
    simp only [Nat.shiftLeft_eq, Nat.shiftRight_eq_div_pow]
    exact Nat.mul_div_cancel _ (Nat.two_pow_pos _)
  rw [hp, hs, Bool.false_xor]

theorem value_pad_right (n : Nat) (f : Nat → Bool) (book post : List Nat) (word : Nat)
    (hw : word < 2^book.length) : value n f (book ++ post) word = value n f book word := by
  rw [value_append, Nat.shiftRight_eq_zero word book.length hw, value_zero, Bool.xor_false]

theorem value_block (n : Nat) (f : Nat → Bool) (pre book post : List Nat) (word : Nat)
    (hw : word < 2^book.length) :
    value n f (pre ++ book ++ post) (word <<< pre.length) = value n f book word := by
  rw [List.append_assoc, value_shift_prefix, value_pad_right n f book post word hw]

#print axioms value_block

def denseMask (i : Nat) : Nat :=
  if i = 0 then 0 else if i < 37 then 2^(i-1) else
    2^((i-37)/36) ||| 2^((i-37)%36)

def denseBook : List Nat := (List.range 1333).map denseMask

theorem dense_length : denseBook.length = 1333 := by simp [denseBook]

theorem dense_get (i : Nat) (hi : i < 1333) : denseBook[i]'(by simpa [dense_length] using hi) = denseMask i := by
  simp [denseBook]

theorem dense_unit (j : Nat) (hj : j < 36) : denseMask (1+j) = 2^j := by
  simp only [denseMask, show 1+j ≠ 0 by omega, ↓reduceIte,
    show 1+j < 37 by omega, show 1+j-1 = j by omega]

theorem dense_pair (a b : Nat) (ha : a < 36) (hb : b < 36) :
    denseMask (37+a*36+b) = (2^a ||| 2^b) := by
  have hz : 37+a*36+b ≠ 0 := by omega
  have hl : ¬37+a*36+b < 37 := by omega
  have hd : (37+a*36+b-37)/36 = a := by omega
  have hm : (37+a*36+b-37)%36 = b := by omega
  simp only [denseMask,hz,hl,↓reduceIte,hd,hm]

theorem dense_member (m : Nat) : m ∈ denseBook ↔ QuadraticMask 36 m := by
  constructor
  · intro hm
    obtain ⟨i,hi,rfl⟩ := List.mem_map.mp hm
    have hib := List.mem_range.mp hi
    unfold denseMask
    split
    · exact Or.inl (Or.inl rfl)
    · split
      · exact Or.inl (Or.inr ⟨i-1,by omega,rfl⟩)
      · exact Or.inr ⟨(i-37)/36,by omega,(i-37)%36,by omega,rfl⟩
  · intro hq
    apply List.mem_map.mpr
    rcases hq with (rfl | ⟨j,hj,rfl⟩) | ⟨a,ha,b,hb,rfl⟩
    · exact ⟨0,by decide,rfl⟩
    · exact ⟨1+j,List.mem_range.mpr (by omega),dense_unit j hj⟩
    · exact ⟨37+a*36+b,List.mem_range.mpr (by omega),dense_pair a b ha hb⟩

theorem dense_substitution_sound (f : Nat → Bool) (i : Nat) (hi : i < 36)
    (form : List Nat) (hf : ∀ a ∈ form, LinearMask 36 a) (word : Nat) :
    value 36 f denseBook (applyWord (substitutionColumns denseBook i form) word) =
      value 36 (update f i (evaluate 36 f form)) denseBook word := by
  apply substitution_sound 36 f denseBook i hi form
  intro m hm t ht
  apply (dense_member t).mpr
  apply (quadraticBook_member 36 t).mp
  exact quadratic_substitution_closed 36 i form hf m
    ((quadraticBook_member 36 m).mpr ((dense_member m).mp hm)) t ht

#print axioms dense_substitution_sound

def scatter : Nat → Nat → Nat → Nat
  | 0, _, _ => 0
  | k+1, start, word => (if word.testBit 0 then 2^start else 0) ^^^ scatter k (start+1) (word >>> 1)

theorem scatter_bit (width start word j : Nat) :
    (scatter width start word).testBit j =
      if start ≤ j ∧ j < start+width then word.testBit (j-start) else false := by
  induction width generalizing start word with
  | zero => simp only [scatter, Nat.zero_testBit, Nat.add_zero, ite_eq_right (show ¬(start ≤ j ∧ j < start) by omega)]
  | succ width ih =>
    rw [scatter, Nat.testBit_xor]
    have hh : (if word.testBit 0 then 2^start else 0).testBit j =
        (word.testBit 0 && decide (start = j)) := by
      cases hb : word.testBit 0 <;> simp only [hb, Bool.false_eq_true, ↓reduceIte,
        Nat.zero_testBit, Nat.testBit_two_pow, Bool.false_and, Bool.true_and]
    rw [hh, ih, Nat.testBit_shiftRight]
    by_cases he : j = start
    · subst j
      simp [show ¬start+1 ≤ start by omega, show start < start+(width+1) by omega]
    · by_cases hl : start ≤ j
      · have hl' : start+1 ≤ j := by omega
        by_cases hu : j < start+(width+1)
        · have hu' : j < start+1+width := by omega
          have hd : 1+(j-(start+1)) = j-start := by omega
          simp only [show start ≠ j by omega, decide_false, Bool.and_false, hl', hu',
            and_self, ↓reduceIte, hl, hu, hd, Bool.false_xor]
        · have hu' : ¬j < start+1+width := by omega
          simp [show start ≠ j by omega, hl, hl', hu, hu']
      · have hl' : ¬start+1 ≤ j := by omega
        have he' : start ≠ j := by omega
        simp [he', hl, hl']

theorem scatter_native (width start word : Nat) :
    scatter width start word = (word % 2^width) <<< start := by
  apply Nat.eq_of_testBit_eq
  intro j
  rw [scatter_bit, Nat.testBit_shiftLeft, Nat.testBit_mod_two_pow]
  by_cases hl : start ≤ j
  · by_cases hu : j < start+width
    · have hd : j-start < width := by omega
      simp [hl,hu,hd]
    · have hd : ¬j-start < width := by omega
      simp [hl,hu,hd]
  · simp [hl]

#print axioms scatter_native

def unitMasks : Nat → Nat → List Nat
  | 0, _ => []
  | width+1, start => (2^start) :: unitMasks width (start+1)

def rowMasks (width start a : Nat) : List Nat :=
  (unitMasks width start).map (fun m => 2^a ||| m)

theorem rowMasks_cons (width start a : Nat) : rowMasks (width+1) start a =
    (2^a ||| 2^start) :: rowMasks width (start+1) a := rfl

theorem row_scatter (f : Nat → Bool) (a : Nat) (ha : a < 36) (width start word : Nat)
    (hw : start+width ≤ 36) :
    value 36 f denseBook (scatter width (37+a*36+start) word) =
      evaluate 36 f (unpack (rowMasks width start a) word) := by
  induction width generalizing start word with
  | zero => exact value_zero 36 f denseBook
  | succ width ih =>
    have hs : start < 36 := by omega
    have hp : 37+a*36+start < 1333 := by omega
    have hv : value 36 f denseBook (2^(37+a*36+start)) = monomial 36 f (2^a ||| 2^start) := by
      rw [value_unit 36 f denseBook _ (by simpa [dense_length] using hp), dense_get _ hp, dense_pair a start ha hs]
    have ht := ih (start+1) (word >>> 1) (by omega)
    rw [scatter, value_xor, show (37+a*36+start)+1 = 37+a*36+(start+1) by omega, ht]
    cases hb : word.testBit 0 <;>
      simp only [hb, Bool.false_eq_true, ↓reduceIte, value_zero, hv, Bool.false_xor,
        rowMasks_cons, unpack, evaluate_cons]

theorem unpack_map (book : List Nat) (g : Nat → Nat) (word : Nat) :
    unpack (book.map g) word = (unpack book word).map g := by
  induction book generalizing word with
  | nil => rfl
  | cons m book ih =>
    cases hb : word.testBit 0 <;>
      simp only [List.map_cons, unpack, hb, Bool.false_eq_true, ↓reduceIte, ih, List.map_cons]

theorem evaluate_union (n : Nat) (f : Nat → Bool) (mask : Nat) (polynomial : List Nat) :
    evaluate n f (polynomial.map (fun m => mask ||| m)) =
      (monomial n f mask && evaluate n f polynomial) := by
  induction polynomial with
  | nil => simp [evaluate]
  | cons m ms ih =>
    simp only [List.map_cons, evaluate_cons, monomial_union, ih, Bool.and_xor_distrib_left]

def linearValue (f : Nat → Bool) (word : Nat) : Bool :=
  evaluate 36 f (unpack (unitMasks 36 0) word)

def rowNative (a word : Nat) : Nat := (word % 2^36) <<< (37+a*36)

theorem rowNative_sound (f : Nat → Bool) (a word : Nat) (ha : a < 36) :
    value 36 f denseBook (rowNative a word) = (f a && linearValue f word) := by
  have hr := row_scatter f a ha 36 0 word (by decide)
  rw [rowMasks, unpack_map, evaluate_union, monomial_unit 36 f a ha] at hr
  simpa only [rowNative, scatter_native, Nat.add_zero, linearValue] using hr

theorem linear_scatter (f : Nat → Bool) (width start word : Nat) (hw : start+width ≤ 36) :
    value 36 f denseBook (scatter width (1+start) word) =
      evaluate 36 f (unpack (unitMasks width start) word) := by
  induction width generalizing start word with
  | zero => exact value_zero 36 f denseBook
  | succ width ih =>
    have hs : start < 36 := by omega
    have hp : 1+start < 1333 := by omega
    have hv : value 36 f denseBook (2^(1+start)) = monomial 36 f (2^start) := by
      rw [value_unit 36 f denseBook _ (by simpa [dense_length] using hp), dense_get _ hp, dense_unit start hs]
    have ht := ih (start+1) (word >>> 1) (by omega)
    rw [scatter, value_xor, show (1+start)+1 = 1+(start+1) by omega, ht]
    cases hb : word.testBit 0 <;>
      simp only [hb, Bool.false_eq_true, ↓reduceIte, value_zero, hv, Bool.false_xor,
        unitMasks, unpack, evaluate_cons]

def linearNative (word : Nat) : Nat := (word % 2^36) <<< 1

theorem linearNative_sound (f : Nat → Bool) (word : Nat) :
    value 36 f denseBook (linearNative word) = linearValue f word := by
  have hr := linear_scatter f 36 0 word (by decide)
  simpa only [linearNative, scatter_native, Nat.add_zero, linearValue] using hr

#print axioms rowNative_sound
#print axioms linearNative_sound

theorem linearValue_zero (f : Nat → Bool) : linearValue f 0 = false := value_zero 36 f (unitMasks 36 0)

theorem linearValue_xor (f : Nat → Bool) (a b : Nat) :
    linearValue f (a ^^^ b) = (linearValue f a ^^ linearValue f b) :=
  value_xor 36 f (unitMasks 36 0) a b

def outerRows : Nat → Nat → Nat → Nat → Nat
  | 0, _, _, _ => 0
  | width+1, start, a, b => (if a.testBit 0 then rowNative start b else 0) ^^^
      outerRows width (start+1) (a >>> 1) b

theorem outerRows_sound (f : Nat → Bool) (width start a b : Nat) (hw : start+width ≤ 36) :
    value 36 f denseBook (outerRows width start a b) =
      (evaluate 36 f (unpack (unitMasks width start) a) && linearValue f b) := by
  induction width generalizing start a with
  | zero => simp only [outerRows, value_zero, unitMasks, unpack, evaluate, List.foldr_nil, Bool.false_and]
  | succ width ih =>
    have hs : start < 36 := by omega
    have ht := ih (start+1) (a >>> 1) (by omega)
    rw [outerRows, value_xor, ht]
    cases hb : a.testBit 0 <;>
      simp only [hb, Bool.false_eq_true, ↓reduceIte, value_zero, Bool.false_xor,
        rowNative_sound f start b hs, unitMasks, unpack, evaluate_cons,
        monomial_unit 36 f start hs, Bool.and_xor_distrib_right]

theorem outerProduct_sound (f : Nat → Bool) (a b : Nat) :
    value 36 f denseBook (outerRows 36 0 a b) = (linearValue f a && linearValue f b) :=
  outerRows_sound f 36 0 a b (by decide)

theorem constantNative_sound (f : Nat → Bool) (b : Bool) :
    value 36 f denseBook (if b then 1 else 0) = b := by
  cases b with
  | false => exact value_zero 36 f denseBook
  | true =>
    have hv := value_unit 36 f denseBook 0 (by rw [dense_length]; decide)
    rw [dense_get 0 (by decide), show denseMask 0 = 0 from rfl] at hv
    simpa only [Nat.pow_zero, monomial_zero, ↓reduceIte] using hv

theorem linearValue_cond (f : Nat → Bool) (b : Bool) (word : Nat) :
    linearValue f (if b then word else 0) = (b && linearValue f word) := by
  cases b <;> simp only [Bool.false_eq_true, ↓reduceIte, linearValue_zero, Bool.false_and, Bool.true_and]

def affineValue (f : Nat → Bool) (word : Nat) : Bool :=
  word.testBit 0 ^^ linearValue f (word >>> 1)

def productWord (a b : Nat) : Nat :=
  (if a.testBit 0 && b.testBit 0 then 1 else 0) ^^^
  linearNative ((if a.testBit 0 then b >>> 1 else 0) ^^^ (if b.testBit 0 then a >>> 1 else 0)) ^^^
  outerRows 36 0 (a >>> 1) (b >>> 1)

theorem affine_mul_bool : ∀ ca cb a b : Bool,
    (((ca && cb) ^^ ((ca && b) ^^ (cb && a))) ^^ (a && b)) = ((ca ^^ a) && (cb ^^ b)) := by decide

theorem productWord_sound (f : Nat → Bool) (a b : Nat) :
    value 36 f denseBook (productWord a b) = (affineValue f a && affineValue f b) := by
  simp only [productWord, value_xor, constantNative_sound, linearNative_sound,
    linearValue_xor, linearValue_cond, outerProduct_sound, affineValue]
  exact affine_mul_bool _ _ _ _

#print axioms productWord_sound

theorem clear_top_lt (word : Nat) (h : word ≠ 0) :
    word ^^^ 2^word.log2 < 2^word.log2 := by
  have hq : word / 2^word.log2 = 1 := by
    apply Nat.div_eq_of_lt_le
    · simpa using Nat.log2_self_le h
    · simpa [Nat.pow_succ, Nat.mul_comm] using (Nat.lt_log2_self (n := word))
  apply (Nat.div_eq_zero_iff_lt (Nat.two_pow_pos _)).mp
  rw [Nat.xor_div_two_pow, hq, Nat.div_self (Nat.two_pow_pos _)]
  decide

def applySparse : Nat → (Nat → Nat) → Nat → Nat
  | 0, _, _ => 0
  | fuel+1, column, word =>
      if word = 0 then 0
      else column word.log2 ^^^ applySparse fuel column (word ^^^ 2^word.log2)

theorem applySparse_sound (n : Nat) (f g : Nat → Bool) (book : List Nat)
    (column : Nat → Nat)
    (hcolumn : ∀ j (hj : j < book.length), value n f book (column j) = monomial n g book[j])
    (fuel word : Nat) (hf : fuel ≤ book.length) (hw : word < 2^fuel) :
    value n f book (applySparse fuel column word) = value n g book word := by
  induction fuel generalizing word with
  | zero =>
    have hz : word = 0 := by simpa using hw
    subst word
    simp only [applySparse, value_zero]
  | succ fuel ih =>
    by_cases hz : word = 0
    · subst word; simp only [applySparse, ↓reduceIte, value_zero]
    · have hi : word.log2 < fuel+1 := (Nat.log2_lt hz).mpr hw
      have hj : word.log2 < book.length := by omega
      have hr : word ^^^ 2^word.log2 < 2^fuel :=
        Nat.lt_of_lt_of_le (clear_top_lt word hz) (Nat.pow_le_pow_right (by decide) (by omega))
      have ht := ih (word ^^^ 2^word.log2) (by omega) hr
      rw [applySparse, ite_eq_right hz, value_xor, hcolumn _ hj, ht]
      have hd : 2^word.log2 ^^^ (word ^^^ 2^word.log2) = word := by
        rw [Nat.xor_comm word, ← Nat.xor_assoc, Nat.xor_self, Nat.zero_xor]
      calc
        _ = value n g book (2^word.log2 ^^^ (word ^^^ 2^word.log2)) := by
          have hv := value_xor n g book (2^word.log2) (word ^^^ 2^word.log2)
          rw [value_unit n g book _ hj] at hv
          exact hv.symm
        _ = value n g book word := by rw [hd]

#print axioms applySparse_sound

theorem linearValue_unit (f : Nat → Bool) (j : Nat) (hj : j < 36) :
    linearValue f (2^j) = f j := by
  have hn : linearNative (2^j) = 2^(1+j) := by
    simp only [linearNative, Nat.mod_eq_of_lt (Nat.pow_lt_pow_right (a := 2) (by decide) hj),
      Nat.shiftLeft_eq, Nat.pow_one]
    rw [Nat.add_comm 1 j, Nat.pow_succ]
  have hv := linearNative_sound f (2^j)
  rw [hn, value_unit 36 f denseBook _ (by rw [dense_length]; omega),
    dense_get _ (by omega), dense_unit j hj, monomial_unit 36 f j hj] at hv
  exact hv.symm

theorem affineValue_unit (f : Nat → Bool) (j : Nat) (hj : j < 36) :
    affineValue f (2^(j+1)) = f j := by
  have hb : (2^(j+1)).testBit 0 = false := by simp [Nat.testBit_two_pow]
  have hs : (2^(j+1)) >>> 1 = 2^j := by simp [Nat.shiftRight_eq_div_pow, Nat.pow_succ]
  simp only [affineValue, hb, hs, Bool.false_xor, linearValue_unit f j hj]

def affineNative (a : Nat) : Nat :=
  (if a.testBit 0 then 1 else 0) ^^^ linearNative (a >>> 1)

theorem affineNative_sound (f : Nat → Bool) (a : Nat) :
    value 36 f denseBook (affineNative a) = affineValue f a := by
  rw [affineNative, value_xor, constantNative_sound, linearNative_sound]
  rfl


def variableProduct (a k : Nat) : Nat :=
  linearNative (if a.testBit 0 then 2^k else 0) ^^^ rowNative k (a >>> 1)

theorem variableProduct_bool : ∀ ca x y : Bool,
    ((ca && x) ^^ (x && y)) = ((ca ^^ y) && x) := by decide

theorem variableProduct_sound (f : Nat → Bool) (a k : Nat) (hk : k < 36) :
    value 36 f denseBook (variableProduct a k) = (affineValue f a && f k) := by
  rw [variableProduct, value_xor, linearNative_sound, linearValue_cond,
    linearValue_unit f k hk, rowNative_sound f k (a >>> 1) hk]
  exact variableProduct_bool _ _ _

def fastColumn (i a j : Nat) : Nat :=
  let m := denseMask j
  if m.testBit i then
    let rest := m ^^^ 2^i
    if rest = 0 then affineNative a
    else variableProduct a rest.log2
  else 2^j

theorem fastColumn_sound (f : Nat → Bool) (i a j : Nat) (hi : i < 36) (hj : j < 1333) :
    value 36 f denseBook (fastColumn i a j) =
      monomial 36 (update f i (affineValue f a)) (denseMask j) := by
  rw [monomial_update 36 f i hi]
  unfold fastColumn
  cases hb : (denseMask j).testBit i with
  | false =>
    simp only [hb, Bool.false_eq_true, ↓reduceIte]
    rw [value_unit 36 f denseBook _ (by rw [dense_length]; exact hj), dense_get j hj]
  | true =>
    simp only [hb, ↓reduceIte]
    have hq : QuadraticMask 36 (denseMask j) :=
      (dense_member _).mp (List.mem_map.mpr ⟨j,List.mem_range.mpr hj,rfl⟩)
    have hr := cleared_linear 36 (denseMask j) i hq hb
    by_cases hz : denseMask j ^^^ 2^i = 0
    · simp only [hz, ↓reduceIte, affineNative_sound, monomial_zero, Bool.true_and]
    · simp only [hz, ↓reduceIte]
      rcases hr with hzero | ⟨k,hk,he⟩
      · exact False.elim (hz hzero)
      · rw [← he, Nat.log2_two_pow, variableProduct_sound f a k hk,
          monomial_unit 36 f k hk, Bool.and_comm]

def fastSubstitute (i a word : Nat) : Nat := applySparse 1333 (fastColumn i a) word

theorem fastSubstitute_sound (f : Nat → Bool) (i a word : Nat) (hi : i < 36)
    (hw : word < 2^1333) :
    value 36 f denseBook (fastSubstitute i a word) =
      value 36 (update f i (affineValue f a)) denseBook word := by
  apply applySparse_sound
  · intro j hj
    have hj' : j < 1333 := by simpa only [dense_length] using hj
    rw [dense_get j hj']
    exact fastColumn_sound f i a j hi hj'
  · simp only [dense_length, Nat.le_refl]
  · exact hw

#print axioms fastSubstitute_sound

def applyScan : Nat → Nat → (Nat → Nat) → Nat → Nat
  | 0, _, _, _ => 0
  | width+1, start, column, word =>
      if word = 0 then 0
      else (if word.testBit 0 then column start else 0) ^^^
        applyScan width (start+1) column (word >>> 1)

theorem applyScan_sound (n : Nat) (f g : Nat → Bool) (book output : List Nat)
    (column : Nat → Nat) (start word : Nat)
    (hc : ∀ j (hj : j < book.length), value n f output (column (start+j)) = monomial n g book[j]) :
    value n f output (applyScan book.length start column word) = value n g book word := by
  induction book generalizing start word with
  | nil => exact value_zero n f output
  | cons m ms ih =>
    by_cases hz : word = 0
    · subst word; simp only [List.length_cons, applyScan, ↓reduceIte, value_zero]
    · have hh := hc 0 (by simp)
      simp only [Nat.add_zero, List.getElem_cons_zero] at hh
      have ht := ih (start+1) (word >>> 1) (by
        intro j hj
        have h := hc (j+1) (by simpa using Nat.succ_lt_succ hj)
        simpa only [Nat.add_assoc, Nat.add_comm 1 j, List.getElem_cons_succ] using h)
      simp only [List.length_cons, applyScan, hz, ↓reduceIte, value_xor, ht]
      cases hb : word.testBit 0
      · simp only [hb, Bool.false_eq_true, ↓reduceIte, value_zero, Bool.false_xor]
        simp only [value, unpack, hb, Bool.false_eq_true, ↓reduceIte]
      · simp only [hb, ↓reduceIte, hh]
        simp only [value, unpack, hb, ↓reduceIte, evaluate_cons]

def canonicalColumn (j : Nat) : Nat :=
  if j < 37 then 2^j
  else
    let a := (j-37)/36
    let b := (j-37)%36
    if a = b then 2^(1+a)
    else if a < b then 2^(37+a*36+b) else 2^(37+b*36+a)

theorem canonicalColumn_sound (f : Nat → Bool) (j : Nat) (hj : j < 1333) :
    value 36 f denseBook (canonicalColumn j) = monomial 36 f (denseMask j) := by
  unfold canonicalColumn
  split
  · rw [value_unit 36 f denseBook j (by rw [dense_length]; exact hj), dense_get j hj]
  · rename_i hn
    have ha : (j-37)/36 < 36 := by omega
    have hb : (j-37)%36 < 36 := by omega
    have hd : j = 37+((j-37)/36)*36+(j-37)%36 := by omega
    have hm : denseMask j = (2^((j-37)/36) ||| 2^((j-37)%36)) := by
      exact (congrArg denseMask hd).trans (dense_pair _ _ ha hb)
    rw [hm]
    dsimp only
    split
    · rename_i he
      rw [value_unit 36 f denseBook _ (by rw [dense_length]; omega),
        dense_get _ (by omega), dense_unit _ ha, ← he, Nat.or_self]
    · split
      · rw [value_unit 36 f denseBook _ (by rw [dense_length]; omega),
          dense_get _ (by omega), dense_pair _ _ ha hb]
      · rw [value_unit 36 f denseBook _ (by rw [dense_length]; omega),
          dense_get _ (by omega), dense_pair _ _ hb ha, Nat.or_comm]

def canonicalize (word : Nat) : Nat := applySparse 1333 canonicalColumn word

theorem canonicalize_sound (f : Nat → Bool) (word : Nat) (hw : word < 2^1333) :
    value 36 f denseBook (canonicalize word) = value 36 f denseBook word := by
  apply applySparse_sound
  · intro j hj
    have hj' : j < 1333 := by simpa only [dense_length] using hj
    rw [dense_get j hj']
    exact canonicalColumn_sound f j hj'
  · simp only [dense_length, Nat.le_refl]
  · exact hw

#print axioms canonicalize_sound

def scanSubstitute (i a word : Nat) : Nat := applyScan 1333 0 (fastColumn i a) word

theorem scanSubstitute_sound (f : Nat → Bool) (i a word : Nat) (hi : i < 36) :
    value 36 f denseBook (scanSubstitute i a word) =
      value 36 (update f i (affineValue f a)) denseBook word := by
  have h := applyScan_sound 36 f (update f i (affineValue f a)) denseBook denseBook
    (fastColumn i a) 0 word (by
      intro j hj
      have hj' : j < 1333 := by simpa only [dense_length] using hj
      simpa only [Nat.zero_add, dense_get j hj'] using fastColumn_sound f i a j hi hj')
  simpa only [dense_length, scanSubstitute] using h

def scanCanonicalize (word : Nat) : Nat := applyScan 1333 0 canonicalColumn word

theorem scanCanonicalize_sound (f : Nat → Bool) (word : Nat) :
    value 36 f denseBook (scanCanonicalize word) = value 36 f denseBook word := by
  have h := applyScan_sound 36 f f denseBook denseBook canonicalColumn 0 word (by
    intro j hj
    have hj' : j < 1333 := by simpa only [dense_length] using hj
    simpa only [Nat.zero_add, dense_get j hj'] using canonicalColumn_sound f j hj')
  simpa only [dense_length, scanCanonicalize] using h

theorem affineValue_xor (f : Nat → Bool) (a b : Nat) :
    affineValue f (a ^^^ b) = (affineValue f a ^^ affineValue f b) := by
  simp only [affineValue, Nat.testBit_xor, Nat.shiftRight_xor_distrib, linearValue_xor]
  cases a.testBit 0 <;> cases b.testBit 0 <;>
    cases linearValue f (a >>> 1) <;> cases linearValue f (b >>> 1) <;> rfl

def packedModels (f : Nat → Bool) (ps : List Nat) : Prop :=
  ∀ p ∈ ps, value 36 f denseBook p = false

def packedBounded (ps : List Nat) : Prop := ∀ p ∈ ps, p < 2^1333

def packedObservation (f : Nat → Bool) (env : List Nat) : List Bool :=
  env.map (value 36 f denseBook)

def packedTransform (i a : Nat) (ps : List Nat) : List Nat := ps.map (scanSubstitute i a)

def packedSelected : List Nat → List Nat → Nat
  | [], _ => 0
  | j::js, ps => ps[j]?.getD 0 ^^^ packedSelected js ps

theorem packedSelected_zero (f : Nat → Bool) (ps indices : List Nat) (hm : packedModels f ps) :
    value 36 f denseBook (packedSelected indices ps) = false := by
  induction indices with
  | nil => exact value_zero 36 f denseBook
  | cons j js ih =>
    rw [packedSelected, value_xor, ih]
    have hz : value 36 f denseBook (ps[j]?.getD 0) = false := by
      cases h : ps[j]? with
      | none => exact value_zero 36 f denseBook
      | some p => exact hm p (List.mem_of_getElem? h)
    rw [hz]; rfl

theorem packedUpdate_eq (f : Nat → Bool) (i a : Nat) (hi : i < 36)
    (h : value 36 f denseBook (affineNative (2^(i+1) ^^^ a)) = false) :
    update f i (affineValue f a) = f := by
  rw [affineNative_sound, affineValue_xor, affineValue_unit f i hi] at h
  have he : f i = affineValue f a := by
    cases hx : f i <;> cases hy : affineValue f a <;> simp_all
  funext j
  by_cases hj : j = i <;> simp [update, hj, he]

theorem packedModels_transform (f : Nat → Bool) (ps : List Nat) (i a : Nat) (hi : i < 36)
    (hb : packedBounded ps) (hu : update f i (affineValue f a) = f) (hm : packedModels f ps) :
    packedModels f (packedTransform i a ps) := by
  intro p hp
  obtain ⟨q,hq,rfl⟩ := List.mem_map.mp hp
  rw [scanSubstitute_sound f i a q hi, hu]
  exact hm q hq

theorem packedObservation_transform (f : Nat → Bool) (env : List Nat) (i a : Nat) (hi : i < 36)
    (hb : packedBounded env) (hu : update f i (affineValue f a) = f) :
    packedObservation f (packedTransform i a env) = packedObservation f env := by
  simp only [packedObservation, packedTransform, List.map_map, Function.comp_def]
  apply List.map_congr_left
  intro p hp
  rw [scanSubstitute_sound f i a p hi, hu]

theorem affineValue_flip (f : Nat → Bool) (a : Nat) : affineValue f (a ^^^ 1) = !affineValue f a := by
  rw [affineValue_xor]
  have ho : affineValue f 1 = true := by simp [affineValue, linearValue_zero]
  rw [ho, Bool.xor_true]

theorem packedUpdate_choice (f : Nat → Bool) (i a : Nat) :
    update f i (affineValue f a) = f ∨ update f i (affineValue f (a ^^^ 1)) = f := by
  rw [affineValue_flip]
  by_cases h : f i = affineValue f a
  · left; funext j; by_cases hj : j = i <;> simp [update, hj, h]
  · right
    have he : (!affineValue f a) = f i := by
      cases hx : f i <;> cases hy : affineValue f a <;> simp_all
    funext j; by_cases hj : j = i <;> simp [update, hj, he]

inductive PackedRefutes (target : List Bool → Prop) : List Nat → List Nat → Prop
  | contradiction (ps env indices : List Nat)
      (bounded : packedSelected indices ps < 2^1333)
      (identity : scanCanonicalize (packedSelected indices ps) = 1) : PackedRefutes target ps env
  | eliminate (ps env : List Nat) (i a : Nat) (hi : i < 36) (indices : List Nat)
      (bounded : packedSelected indices ps < 2^1333)
      (identity : scanCanonicalize (packedSelected indices ps) = affineNative (2^(i+1) ^^^ a))
      (bp : packedBounded ps) (be : packedBounded env)
      (child : PackedRefutes target (packedTransform i a ps) (packedTransform i a env)) :
      PackedRefutes target ps env
  | split (ps env : List Nat) (i a : Nat) (hi : i < 36)
      (bp : packedBounded ps) (be : packedBounded env)
      (zero : PackedRefutes target (packedTransform i a ps) (packedTransform i a env))
      (one : PackedRefutes target (packedTransform i (a ^^^ 1) ps) (packedTransform i (a ^^^ 1) env)) :
      PackedRefutes target ps env
  | terminal (ps env : List Nat) (rejection : ∀ f, ¬target (packedObservation f env)) :
      PackedRefutes target ps env

theorem packedRefutes_sound (target : List Bool → Prop) (ps env : List Nat)
    (proof : PackedRefutes target ps env) :
    ∀ f, packedModels f ps → ¬target (packedObservation f env) := by
  induction proof with
  | contradiction ps env indices bounded identity =>
    intro f hm _
    have hz := packedSelected_zero f ps indices hm
    have he := scanCanonicalize_sound f (packedSelected indices ps)
    rw [identity, hz] at he
    have ht : value 36 f denseBook 1 = true := by
      simpa using constantNative_sound f true
    rw [ht] at he
    cases he
  | eliminate ps env i a hi indices bounded identity bp be child ih =>
    intro f hm ht
    have hz := packedSelected_zero f ps indices hm
    have he := scanCanonicalize_sound f (packedSelected indices ps)
    rw [identity, hz] at he
    have hu := packedUpdate_eq f i a hi he
    apply ih f (packedModels_transform f ps i a hi bp hu hm)
    rwa [packedObservation_transform f env i a hi be hu]
  | split ps env i a hi bp be zero one ih0 ih1 =>
    intro f hm ht
    rcases packedUpdate_choice f i a with hu | hu
    · apply ih0 f (packedModels_transform f ps i a hi bp hu hm)
      rwa [packedObservation_transform f env i a hi be hu]
    · apply ih1 f (packedModels_transform f ps i (a ^^^ 1) hi bp hu hm)
      rwa [packedObservation_transform f env i (a ^^^ 1) hi be hu]
  | terminal ps env rejection => intro f _; exact rejection f

#print axioms packedRefutes_sound

#print axioms scanSubstitute_sound
#print axioms scanCanonicalize_sound
end H12PackedPolynomial
