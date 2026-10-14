import VonoV3C.Blocks

open scoped BigOperators
namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}
abbrev Input (ι : Type*) (m : ℕ) := Blocks.Input ι m
abbrev Output (ι : Type*) := ι → Scalar
abbrev CubicVec := Fin 3 → Scalar

def cubic (x : CubicVec) : Scalar := x 0 * x 1 * x 2

/-- Algebraic annihilation of a cubic, without enumeration. -/
theorem cubic_fourth_zero (a b c d x : CubicVec) :
    fourth cubic a b c d x = 0 := by
  simp only [fourth, diff, cubic, Pi.add_apply]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl,
    show (4 : Scalar) = 0 from rfl, show (8 : Scalar) = 0 from rfl,
    show (16 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]

def firstIndex (hm : 2 ≤ m) : Fin m :=
  ⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩
def p (hm : 2 ≤ m) (v : Vec m) : Scalar := (v (firstIndex hm)).1
def q (hm : 2 ≤ m) (v : Vec m) : Scalar := (v (firstIndex hm)).2

def couplingLinear (hm : 2 ≤ m) (adj : ι → ι → Bool) (i : ι) :
    Input ι m →ₗ[Scalar] CubicVec where
  toFun x k := if k = 0 then p hm (x i) else if k = 1 then q hm (x i) else
    ∑ j, if adj i j then p hm (x j) else 0
  map_add' := by
    intro x y
    funext k
    by_cases h0 : k = 0 <;> by_cases h1 : k = 1 <;>
      simp [h0, h1, p, q, Pi.add_apply, Finset.sum_add_distrib, ite_add]
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro j hj
    split_ifs <;> simp
  map_smul' := by
    intro t x
    funext k
    by_cases h0 : k = 0 <;> by_cases h1 : k = 1 <;>
      simp [h0, h1, p, q, Pi.smul_apply, smul_eq_mul, Finset.mul_sum, mul_ite]

def component (hm : 2 ≤ m) (adj : ι → ι → Bool) (i : ι)
    (x : Input ι m) : Scalar := seed m (x i) + cubic (couplingLinear hm adj i x)
def graphMap (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (x : Input ι m) : Output ι := fun i => component hm adj i x

def Loopless (adj : ι → ι → Bool) : Prop := ∀ i, adj i i = false

theorem component_formula (hm : 2 ≤ m) (adj : ι → ι → Bool) (i : ι)
    (x : Input ι m) : component hm adj i x =
    seed m (x i) + p hm (x i) * q hm (x i) *
      ∑ j, if adj i j then p hm (x j) else 0 := by
  simp [component, cubic, couplingLinear]

theorem diff_add {V : Type*} [Add V] (a : V) (f g : V → Scalar) :
    diff a (fun x => f x + g x) = fun x => diff a f x + diff a g x := by
  funext x
  simp only [diff]
  abel

theorem diff_comp_linear {V W : Type*} [AddCommGroup V] [Module Scalar V]
    [AddCommGroup W] [Module Scalar W] (e : V →ₗ[Scalar] W)
    (a : V) (f : W → Scalar) :
    diff a (f ∘ e) = (diff (e a) f) ∘ e := by
  funext x
  simp [diff, e.map_add]

theorem third_comp_linear {V W : Type*} [AddCommGroup V] [Module Scalar V]
    [AddCommGroup W] [Module Scalar W] (e : V →ₗ[Scalar] W)
    (a b c : V) (f : W → Scalar) :
    diff a (diff b (diff c (f ∘ e))) =
      (diff (e a) (diff (e b) (diff (e c) f))) ∘ e := by
  rw [diff_comp_linear, diff_comp_linear, diff_comp_linear]

theorem fourth_comp_linear {V W : Type*} [AddCommGroup V] [Module Scalar V]
    [AddCommGroup W] [Module Scalar W] (e : V →ₗ[Scalar] W)
    (a b c d x : V) (f : W → Scalar) :
    fourth (f ∘ e) a b c d x = fourth f (e a) (e b) (e c) (e d) (e x) := by
  unfold fourth
  rw [diff_comp_linear, diff_comp_linear, diff_comp_linear, diff_comp_linear]
  rfl

/-- The actual graph component has the already certified seed polarization. -/
theorem fourth_component (hm : 2 ≤ m) (adj : ι → ι → Bool) (i : ι)
    (a b c d x : Input ι m) :
    fourth (component hm adj i) a b c d x =
      pfaffian (a i) (b i) (c i) (d i) := by
  change fourth (fun y => (seed m ∘ (LinearMap.proj i : Input ι m →ₗ[Scalar] Vec m)) y +
    (cubic ∘ couplingLinear hm adj i) y) a b c d x = _
  unfold fourth
  simp only [diff_add]
  change fourth (seed m ∘ (LinearMap.proj i : Input ι m →ₗ[Scalar] Vec m)) a b c d x +
    fourth (cubic ∘ couplingLinear hm adj i) a b c d x = _
  rw [fourth_comp_linear, fourth_comp_linear, cubic_fourth_zero, add_zero]
  exact seed_fourth _ _ _ _ _

end VonoV3C.GraphFamily
