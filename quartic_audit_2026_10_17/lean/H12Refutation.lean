import H12CertificateTheory

/-! Soundness of algebraic certificate trees. The terminal predicate is kept
abstract here: instantiating it with bentness and checking the actual finite
certificate are separate obligations, not hypotheses silently discharged here.
-/
namespace H12Refutation
open H12BooleanPolynomial H12CertificateTheory

abbrev Polynomial := List Nat
abbrev System := List Polynomial

def Models (n : Nat) (f : Nat → Bool) (ps : System) : Prop :=
  ∀ p ∈ ps, evaluate n f p = false

def observation (n : Nat) (f : Nat → Bool) (env : System) : List Bool :=
  env.map (evaluate n f)

def transform (i : Nat) (form : Polynomial) (ps : System) : System :=
  ps.map (fun p => normalizeFuel 20 (substitute i form p))

def selected (indices : List Nat) (ps : System) : Polynomial :=
  (indices.map (fun j => ps[j]?.getD [])).flatten

theorem selected_zero (n : Nat) (f : Nat → Bool) (ps : System)
    (hm : Models n f ps) (indices : List Nat) :
    evaluate n f (selected indices ps) = false := by
  induction indices with
  | nil => rfl
  | cons j js ih =>
    simp only [selected, List.map_cons, List.flatten_cons, evaluate_append] at *
    have hz : evaluate n f (ps[j]?.getD []) = false := by
      cases h : ps[j]? with
      | none => rfl
      | some p =>
        exact hm p (List.mem_of_getElem? h)
    rw [hz, ih]; rfl

theorem models_transform (n : Nat) (f : Nat → Bool) (ps : System)
    (i : Nat) (hi : i < n) (form : Polynomial)
    (hu : update f i (evaluate n f form) = f) (hm : Models n f ps) :
    Models n f (transform i form ps) := by
  intro q hq
  obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hq
  rw [evaluate_normalize, evaluate_substitute n f i hi, hu]
  exact hm p hp

theorem observation_transform (n : Nat) (f : Nat → Bool) (env : System)
    (i : Nat) (hi : i < n) (form : Polynomial)
    (hu : update f i (evaluate n f form) = f) :
    observation n f (transform i form env) = observation n f env := by
  simp only [observation, transform, List.map_map]
  apply List.map_congr_left
  intro p _
  exact (evaluate_normalize n f 20 (substitute i form p)).trans
    ((evaluate_substitute n f i hi form p).trans (congrArg (fun g => evaluate n g p) hu))

theorem flip_evaluate (n : Nat) (f : Nat → Bool) (form : Polynomial) :
    evaluate n f (0 :: form) = !evaluate n f form := by
  simp only [evaluate_cons, monomial_zero, Bool.true_xor]

theorem update_choice (n : Nat) (f : Nat → Bool) (i : Nat) (form : Polynomial) :
    update f i (evaluate n f form) = f ∨
      update f i (evaluate n f (0 :: form)) = f := by
  rw [flip_evaluate]
  by_cases h : f i = evaluate n f form
  · left; funext j; by_cases hj : j = i <;> simp [update, hj, h]
  · right
    have hf : (!evaluate n f form) = f i := by
      cases ha : f i <;> cases hb : evaluate n f form <;> simp_all
    funext j; by_cases hj : j = i <;> simp [update, hj, hf]

/- A proof tree carries exact polynomial equalities. An executable parser/checker
must establish these equalities for the supplied numeric certificate. -/
inductive Refutes (n : Nat) (target : List Bool → Prop) : System → System → Prop
  | contradiction (ps env : System) (indices : List Nat)
      (identity : normalizeFuel 20 (selected indices ps) = [0]) :
      Refutes n target ps env
  | eliminate (ps env : System) (i : Nat) (hi : i < n) (form : Polynomial)
      (indices : List Nat)
      (identity : normalizeFuel 20 (selected indices ps ++ ((2^i) :: form)) = [])
      (child : Refutes n target (transform i form ps) (transform i form env)) :
      Refutes n target ps env
  | split (ps env : System) (i : Nat) (hi : i < n) (form : Polynomial)
      (zero : Refutes n target (transform i form ps) (transform i form env))
      (one : Refutes n target (transform i (0 :: form) ps) (transform i (0 :: form) env)) :
      Refutes n target ps env
  | terminal (ps env : System)
      (rejection : ∀ f : Nat → Bool, ¬target (observation n f env)) :
      Refutes n target ps env

theorem refutes_sound (n : Nat) (target : List Bool → Prop) (ps env : System)
    (proof : Refutes n target ps env) :
    ∀ f : Nat → Bool, Models n f ps → ¬target (observation n f env) := by
  induction proof with
  | contradiction ps env indices identity =>
    intro f hm _
    have hz := selected_zero n f ps hm indices
    have he := evaluate_normalize n f 20 (selected indices ps)
    rw [identity, hz] at he
    simpa [evaluate, monomial_zero] using he
  | eliminate ps env i hi form indices identity child ih =>
    intro f hm ht
    have hz := selected_zero n f ps hm indices
    have he := evaluate_normalize n f 20 (selected indices ps ++ ((2^i) :: form))
    rw [identity, evaluate_append, hz] at he
    have hu := update_of_equation n f i hi form (by simpa [evaluate] using he.symm)
    apply ih f (models_transform n f ps i hi form hu hm)
    rwa [observation_transform n f env i hi form hu]
  | split ps env i hi form zero one ih0 ih1 =>
    intro f hm ht
    rcases update_choice n f i form with hu | hu
    · apply ih0 f (models_transform n f ps i hi form hu hm)
      rwa [observation_transform n f env i hi form hu]
    · apply ih1 f (models_transform n f ps i hi (0 :: form) hu hm)
      rwa [observation_transform n f env i hi (0 :: form) hu]
  | terminal ps env rejection =>
    intro f _
    exact rejection f

#print axioms refutes_sound

inductive Tree where
  | contradiction (indices : List Nat)
  | eliminate (i : Nat) (form : Polynomial) (indices : List Nat) (child : Tree)
  | split (i : Nat) (form : Polynomial) (zero one : Tree)
  | terminal (witness : Nat)
  deriving Repr

def check (n : Nat) (terminal : Nat → System → Bool) : Tree → System → System → Bool
  | .contradiction indices, ps, _ => normalizeFuel 20 (selected indices ps) == [0]
  | .eliminate i form indices child, ps, env =>
      decide (i < n) &&
      (normalizeFuel 20 (selected indices ps ++ ((2^i) :: form)) == []) &&
      check n terminal child (transform i form ps) (transform i form env)
  | .split i form zero one, ps, env =>
      decide (i < n) &&
      check n terminal zero (transform i form ps) (transform i form env) &&
      check n terminal one (transform i (0 :: form) ps) (transform i (0 :: form) env)
  | .terminal w, _, env => terminal w env

theorem check_produces_refutation (n : Nat) (target : List Bool → Prop)
    (terminal : Nat → System → Bool)
    (terminal_sound : ∀ w env, terminal w env = true →
      ∀ f : Nat → Bool, ¬target (observation n f env))
    (tree : Tree) : ∀ ps env, check n terminal tree ps env = true →
      Refutes n target ps env := by
  induction tree with
  | contradiction indices =>
    intro ps env h
    simp only [check, beq_iff_eq] at h
    exact Refutes.contradiction ps env indices h
  | eliminate i form indices child ih =>
    intro ps env h
    simp only [check, Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at h
    exact Refutes.eliminate ps env i h.1.1 form indices h.1.2 (ih _ _ h.2)
  | split i form zero one ih0 ih1 =>
    intro ps env h
    simp only [check, Bool.and_eq_true, decide_eq_true_eq] at h
    exact Refutes.split ps env i h.1.1 form (ih0 _ _ h.1.2) (ih1 _ _ h.2)
  | terminal w =>
    intro ps env h
    exact Refutes.terminal ps env (terminal_sound w env h)

theorem check_sound (n : Nat) (target : List Bool → Prop)
    (terminal : Nat → System → Bool)
    (terminal_sound : ∀ w env, terminal w env = true →
      ∀ f : Nat → Bool, ¬target (observation n f env))
    (tree : Tree) (ps env : System) (checked : check n terminal tree ps env = true) :
    ∀ f : Nat → Bool, Models n f ps → ¬target (observation n f env) :=
  refutes_sound n target ps env
    (check_produces_refutation n target terminal terminal_sound tree ps env checked)

#print axioms check_sound

/- Small kernel-evaluated controls exercise cancellation, elimination, invalid
identities and bounds. The global numeric certificate is not instantiated here. -/
example : check 1 (fun _ _ => false) (.contradiction [0,1]) [[1],[0,1]] [[1]] = true :=
  by decide +kernel

example : check 1 (fun _ env => env == [[0]])
    (.eliminate 0 [0] [0] (.terminal 0)) [[0,1]] [[1]] = true := by decide +kernel

example : check 1 (fun _ _ => true)
    (.eliminate 0 [] [0] (.terminal 0)) [[0,1]] [[1]] = false := by decide +kernel

example : check 1 (fun _ _ => true)
    (.split 1 [] (.terminal 0) (.terminal 0)) [] [[1]] = false := by decide +kernel

example : check 1 (fun _ _ => true) (.contradiction [0]) [] [] = false := by decide +kernel
end H12Refutation
