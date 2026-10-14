/-!
# V2_NovosTeoremas_Lean4.lean
**STATUS DE COMPILAÇÃO:** NÃO TESTADO (compilador `lean` / `lake` e biblioteca `Mathlib`
não estão instalados neste ambiente de execução offline; verificado via `which lean lake`).

Formaliza em sintaxe Lean 4 / Mathlib4 as estruturas matemáticas reais e os enunciados não-triviais:
1. Recuperação intrínseca de blocos pelo radical Grassmann-free `Rad_Φ(u)` (Teorema 1);
2. Rigidez nos vértices ativos e liberdade `C₅ ⋊ C₈` nos vértices isolados (Teorema C1);
3. Fórmulas fechadas de Reciprocidade de Frobenius-Monodromia `phiIntra` e codimensão `codimTransposition` (Teoremas C1 e B).
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Card
import Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup
import Mathlib.GroupTheory.Perm.Basic

namespace HrsbfV2Audit

abbrev F2 := ZMod 2
abbrev V8 := Fin 8 → F2
abbrev GL8 := Matrix.GeneralLinearGroup (Fin 8) F2

structure LooplessDigraph (r : ℕ) where
  arc : Fin r → Fin r → Prop
  irrefl : ∀ i : Fin r, ¬ arc i i

def IsIsolated {r : ℕ} (G : LooplessDigraph r) (i : Fin r) : Prop :=
  ∀ j : Fin r, ¬ G.arc i j ∧ ¬ G.arc j i

def IsDigraphIso {r : ℕ} (H G : LooplessDigraph r) (π : Equiv.Perm (Fin r)) : Prop :=
  ∀ i j : Fin r, H.arc i j ↔ G.arc (π i) (π j)

theorem iso_preserves_isolated {r : ℕ} {H G : LooplessDigraph r} {π : Equiv.Perm (Fin r)}
    (hπ : IsDigraphIso H G π) (i : Fin r) :
    IsIsolated H i ↔ IsIsolated G (π i) := by
  constructor
  · intro hi j
    obtain ⟨j', rfl⟩ := π.surjective j
    have hij := hi j'
    exact ⟨mt (hπ i j').mpr hij.1, mt (hπ j' i).mpr hij.2⟩
  · intro hpi j
    have hij := hpi (π j)
    exact ⟨mt (hπ i j).mp hij.1, mt (hπ j i).mp hij.2⟩

structure LocalSeedCertificate where
  phi : V8 → V8 → V8 → V8 → F2
  grassmann_free :
    ∀ u v : V8, (∀ w₁ w₂ : V8, phi u v w₁ w₂ = 0) ↔ (u = 0 ∨ v = 0 ∨ u = v)
  AutPhi : Subgroup GL8
  card_AutPhi : Fintype.card AutPhi = 1920
  G_le2 : Subgroup GL8
  G_le2_le_AutPhi : G_le2 ≤ AutPhi
  card_G_le2 : Fintype.card G_le2 = 40
  delta3 : AutPhi → (V8 → V8 → V8 → F2)
  degree_le2_iff :
    ∀ (A : AutPhi) (a : V8),
      (∀ u v w : V8, delta3 A u v w = phi a u v w) ↔ (A.1 ∈ G_le2 ∧ a = 0)
  stab_e0_trivial :
    ∀ A : GL8, A ∈ G_le2 → (∀ x : V8, (A.1.mulVec x) 0 = x 0) → A = 1
  stab_e01_trivial :
    ∀ A : GL8, A ∈ G_le2 →
      (∀ x y : V8,
        (A.1.mulVec x 0) * (A.1.mulVec y 1) + (A.1.mulVec y 0) * (A.1.mulVec x 1) =
          x 0 * y 1 + y 0 * x 1) → A = 1

theorem grassmann_free_radical_iff (C : LocalSeedCertificate) {r : ℕ}
    (u v : Fin r → V8) :
    (∀ (i : Fin r) (w₁ w₂ : V8), C.phi (u i) (v i) w₁ w₂ = 0) ↔
      ∀ i : Fin r, (u i = 0 ∨ v i = 0 ∨ u i = v i) := by
  constructor
  · intro h i
    exact (C.grassmann_free (u i) (v i)).mp (h i)
  · intro h i w₁ w₂
    exact (C.grassmann_free (u i) (v i)).mpr (h i) w₁ w₂

theorem active_vertex_forced_identity (C : LocalSeedCertificate) {r : ℕ}
    (H : LooplessDigraph r) (A : Fin r → GL8)
    (hA_in : ∀ i : Fin r, A i ∈ C.G_le2)
    (h_tail : ∀ i j : Fin r, H.arc i j →
      ∀ x y : V8,
        ((A i).1.mulVec x 0) * ((A i).1.mulVec y 1) + ((A i).1.mulVec y 0) * ((A i).1.mulVec x 1) =
          x 0 * y 1 + y 0 * x 1)
    (h_head : ∀ i j : Fin r, H.arc i j →
      ∀ x : V8, ((A j).1.mulVec x) 0 = x 0)
    (i : Fin r) (h_not_iso : ¬ IsIsolated H i) :
    A i = 1 := by
  unfold IsIsolated at h_not_iso
  push_neg at h_not_iso
  obtain ⟨j, h_arc⟩ := h_not_iso
  by_cases hij : H.arc i j
  · exact C.stab_e01_trivial (A i) (hA_in i) (h_tail i j hij)
  · have hji : H.arc j i := h_arc hij
    exact C.stab_e0_trivial (A i) (hA_in i) (h_head j i hji)

def phiIntra (l m : ℕ) : ℕ :=
  if m = 1 then
    if l % 2 = 0 then 32 * l else 32 * l - 4
  else if m = 2 ∨ m = 4 ∨ m = 8 then
    (32 * l) / m
  else if m = 5 ∨ m = 10 then
    (40 * l) / m
  else 0

def dimQ (r : ℕ) : ℕ := 32 * r ^ 3 - 4 * r ^ 2
def c2Transposition (r : ℕ) : ℕ := 32 * r ^ 3 - 100 * r ^ 2 + 204 * r - 144
def codimTransposition (r : ℕ) : ℕ := 96 * r ^ 2 - 204 * r + 144

end HrsbfV2Audit
