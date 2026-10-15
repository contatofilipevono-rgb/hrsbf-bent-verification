import Antipodal.Autocorrelation

/-! Canonical ANF coefficients from the Boolean Mobius transform.
These definitions concern the unique squarefree ANF, not an arbitrary
polynomial representation. -/
namespace HRSBF.Antipodal
open Finset

section Mobius
variable {ι : Type*} [DecidableEq ι]

def booleanMobius (F : Finset ι → F₂) (s : Finset ι) : F₂ :=
  ∑ t ∈ s.powerset, F t

/-- Boolean subset summation is its own inverse in characteristic two. -/
theorem booleanMobius_involution (F : Finset ι → F₂) (s : Finset ι) :
    booleanMobius (booleanMobius F) s = F s := by
  induction s using Finset.induction_on generalizing F with
  | empty => simp [booleanMobius]
  | @insert a s ha ih =>
    have hrec (G : Finset ι → F₂) :
        booleanMobius G (insert a s) =
          booleanMobius G s + booleanMobius (fun t => G (insert a t)) s :=
      sum_powerset_insert ha G
    rw [hrec, ih]
    have ht : ∀ t ∈ s.powerset,
        booleanMobius F (insert a t) =
          booleanMobius F t + booleanMobius (fun u => F (insert a u)) t := by
      intro t ht
      apply sum_powerset_insert
      exact fun hat => ha ((mem_powerset.mp ht) hat)
    change F s + (∑ t ∈ s.powerset, booleanMobius F (insert a t)) = _
    rw [sum_congr rfl ht, sum_add_distrib]
    change F s + (booleanMobius (booleanMobius F) s +
      booleanMobius (booleanMobius (fun u => F (insert a u))) s) = _
    rw [ih, ih, ← add_assoc, CharTwo.add_self_eq_zero, zero_add]

end Mobius

/-- Vector with precisely the given support. -/
def supportVector {n : ℕ} (s : Finset (Fin n)) : Vec n := fun i => if i ∈ s then 1 else 0

/-- Canonical coefficient of a squarefree support. -/
def anfCoefficient {n : ℕ} (f : Vec n → F₂) (s : Finset (Fin n)) : F₂ :=
  booleanMobius (fun t => f (supportVector t)) s

def vectorSupport {n : ℕ} (x : Vec n) : Finset (Fin n) := univ.filter (fun i => x i = 1)

@[simp] theorem supportVector_vectorSupport {n : ℕ} (x : Vec n) :
    supportVector (vectorSupport x) = x := by
  funext i
  have h01 : x i = 0 ∨ x i = 1 := (by decide : ∀ c : F₂, c = 0 ∨ c = 1) (x i)
  rcases h01 with hi | hi <;> simp [supportVector, vectorSupport, hi]

@[simp] theorem vectorSupport_supportVector {n : ℕ} (s : Finset (Fin n)) :
    vectorSupport (supportVector s) = s := by
  ext i
  simp [vectorSupport, supportVector]

/-- Exact reconstruction of every Boolean function from its canonical ANF. -/
theorem anf_reconstruction {n : ℕ} (f : Vec n → F₂) (x : Vec n) :
    (∑ s ∈ (vectorSupport x).powerset, anfCoefficient f s) = f x := by
  have h := booleanMobius_involution (fun s => f (supportVector s)) (vectorSupport x)
  simpa only [booleanMobius, anfCoefficient, supportVector_vectorSupport] using h

/-- Uniqueness of canonical coefficients from their squarefree evaluations. -/
theorem anfCoefficient_unique {n : ℕ} (f : Vec n → F₂)
    (c : Finset (Fin n) → F₂)
    (heval : ∀ s, (∑ t ∈ s.powerset, c t) = f (supportVector s)) :
    ∀ s, c s = anfCoefficient f s := by
  intro s
  have he : booleanMobius c = fun s => f (supportVector s) := funext heval
  rw [anfCoefficient, ← he, booleanMobius_involution]

/-- Actual degree bound: every canonical support above degree three vanishes. -/
def HasAlgebraicDegreeAtMostThree {n : ℕ} (f : Vec n → F₂) : Prop :=
  ∀ s : Finset (Fin n), 3 < s.card → anfCoefficient f s = 0

/-- Homogeneity is stated on the unique ANF, and requires a cubic term. -/
def IsHomogeneousCubic {n : ℕ} (f : Vec n → F₂) : Prop :=
  (∀ s : Finset (Fin n), s.card ≠ 3 → anfCoefficient f s = 0) ∧
    ∃ s : Finset (Fin n), s.card = 3 ∧ anfCoefficient f s = 1

def IsRotationSymmetric {n : ℕ} (f : Vec n → F₂) : Prop :=
  ∀ x, f (rotate x) = f x

/-- For an even positive dimension, use one canonical antipodal pair.
Rotation invariance is what makes this the coefficient of the orbit. -/
def antipodalANFCoefficient (h : ℕ) (f : Vec (2 * (h+1)) → F₂) : F₂ :=
  anfCoefficient f {⟨0, by omega⟩, ⟨h+1, by omega⟩}

theorem homogeneous_cubic_antipodal_zero (h : ℕ)
    (f : Vec (2 * (h+1)) → F₂) (hf : IsHomogeneousCubic f) :
    antipodalANFCoefficient h f = 0 := by
  apply hf.1
  have hne : (⟨0, by omega⟩ : Fin (2*(h+1))) ≠ ⟨h+1, by omega⟩ := by
    intro he
    have hv := congrArg Fin.val he
    dsimp at hv
    omega
  rw [Finset.card_pair hne]
  decide

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.booleanMobius_involution
#print axioms HRSBF.Antipodal.anf_reconstruction
#print axioms HRSBF.Antipodal.anfCoefficient_unique
#print axioms HRSBF.Antipodal.homogeneous_cubic_antipodal_zero
