import VonoV3C.Polarization

namespace VonoV3C

abbrev Coord (m : ℕ) := Fin m × Bool

def coord {m : ℕ} (a : Vec m) (u : Coord m) : Scalar :=
  if u.2 then (a u.1).2 else (a u.1).1

def dualUnit {m : ℕ} (u : Coord m) : Vec m :=
  Pi.single u.1 (if u.2 then (1, 0) else (0, 1))

def pairing {m : ℕ} (u v : Coord m) : Scalar :=
  if u.1 = v.1 ∧ u.2 ≠ v.2 then 1 else 0

theorem omega_dual {m : ℕ} (a : Vec m) (u : Coord m) :
    omega a (dualUnit u) = coord a u := by
  unfold omega
  rw [Finset.sum_eq_single u.1]
  · cases hu : u.2 <;> simp [dualUnit, coord, hu]
  · intro j hj hju
    simp [dualUnit, Pi.single_apply, hju]
  · simp

theorem omega_dual_dual {m : ℕ} (u v : Coord m) :
    omega (dualUnit u) (dualUnit v) = pairing u v := by
  rw [omega_dual]
  by_cases huv : u.1 = v.1
  · cases hu : u.2 <;> cases hv : v.2 <;>
      simp [coord, dualUnit, pairing, Pi.single_apply, huv, hu, hv]
  · cases hv : v.2 <;> simp [coord, dualUnit, pairing, Pi.single_apply, huv,
      Ne.symm huv, hv]

def minor {m : ℕ} (a b : Vec m) (u v : Coord m) : Scalar :=
  coord a u * coord b v + coord a v * coord b u

/-- Coordinate form of a vanishing quartic contraction. -/
theorem contraction_minors {m : ℕ} (a b : Vec m)
    (h : ∀ c d, pfaffian a b c d = 0) (u v : Coord m) :
    minor a b u v = omega a b * pairing u v := by
  have hh := h (dualUnit u) (dualUnit v)
  unfold pfaffian at hh
  rw [omega_dual_dual] at hh
  simp only [omega_dual] at hh
  have hz : omega a b * pairing u v + minor a b u v = 0 := by
    simpa [minor, add_assoc, mul_comm] using hh
  have he := congrArg (fun z : Scalar => z + omega a b * pairing u v) hz
  simpa [add_assoc, add_comm, add_left_comm] using he

/-- The Pluecker identity used to rule out a full-rank symplectic bivector. -/
theorem minor_pluecker {m : ℕ} (a b : Vec m) (u v w z : Coord m) :
    minor a b u v * minor a b w z +
    minor a b u w * minor a b v z +
    minor a b u z * minor a b v w = 0 := by
  unfold minor
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl, mul_zero, add_zero, zero_add]

theorem scalar_zero_or_one (z : Scalar) : z = 0 ∨ z = 1 := by
  have hv := Nat.le_one_iff_eq_zero_or_eq_one.mp
    (Nat.lt_succ_iff.mp (ZMod.val_lt z))
  rcases hv with hv | hv
  · left; rw [← ZMod.natCast_zmod_val z, hv]; rfl
  · right; rw [← ZMod.natCast_zmod_val z, hv]; rfl

theorem contraction_omega_zero {m : ℕ} (hm : 2 ≤ m) (a b : Vec m)
    (h : ∀ c d, pfaffian a b c d = 0) : omega a b = 0 := by
  let i : Fin m := ⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩
  let j : Fin m := ⟨1, Nat.lt_of_lt_of_le (by decide : 1 < 2) hm⟩
  have hij : i ≠ j := by intro he; have := congrArg Fin.val he; simp [i,j] at this
  have hh := minor_pluecker a b (i,false) (i,true) (j,false) (j,true)
  simp_rw [contraction_minors a b h] at hh
  simp [pairing, hij, Ne.symm hij] at hh
  rcases scalar_zero_or_one (omega a b) with hs | hs
  · exact hs
  · rw [hs] at hh
    norm_num at hh

theorem coord_ext {m : ℕ} (a b : Vec m)
    (h : ∀ u, coord a u = coord b u) : a = b := by
  funext i
  apply Prod.ext
  · exact h (i,false)
  · exact h (i,true)

/-- Vanishing minors force a dependent pair over F₂. -/
theorem minors_zero_dependent {m : ℕ} (a b : Vec m)
    (h : ∀ u v, minor a b u v = 0) : a = 0 ∨ b = 0 ∨ a = b := by
  classical
  by_cases ha : a = 0
  · exact Or.inl ha
  have hex : ∃ u, coord a u ≠ 0 := by
    by_contra hn
    apply ha
    apply coord_ext
    intro u
    have hu : coord a u = 0 := by
      by_contra hu
      exact hn ⟨u,hu⟩
    simpa [coord] using hu
  obtain ⟨u,hu⟩ := hex
  have hau : coord a u = 1 := (scalar_zero_or_one _).resolve_left hu
  have hv (v : Coord m) : coord b v = coord a v * coord b u := by
    have hh := h u v
    simp only [minor, hau, one_mul] at hh
    have he := congrArg (fun z : Scalar => z + coord a v * coord b u) hh
    simpa [add_assoc] using he
  rcases scalar_zero_or_one (coord b u) with hb | hb
  · right; left
    apply coord_ext
    intro v
    calc
      coord b v = 0 := by simpa only [hb, mul_zero] using hv v
      _ = coord (0 : Vec m) v := by simp [coord]
  · right; right
    apply coord_ext
    intro v
    simpa [hb] using (hv v).symm

/-- Property A for the fourth polarization, uniformly for m ≥ 2. -/
theorem pfaffian_property_A {m : ℕ} (hm : 2 ≤ m) (a b : Vec m)
    (h : ∀ c d, pfaffian a b c d = 0) : a = 0 ∨ b = 0 ∨ a = b := by
  have hz := contraction_omega_zero hm a b h
  apply minors_zero_dependent a b
  intro u v
  rw [contraction_minors a b h, hz, zero_mul]

/-- Property A for actual finite differences of the explicit quartic seed. -/
theorem seed_property_A {m : ℕ} (hm : 2 ≤ m) (a b : Vec m)
    (h : ∀ c d, fourth (seed m) a b c d 0 = 0) : a = 0 ∨ b = 0 ∨ a = b := by
  apply pfaffian_property_A hm a b
  intro c d
  simpa only [seed_fourth] using h c d

theorem diff_comm {V : Type*} [AddCommGroup V] (a b : V) (f : V → Scalar) :
    diff a (diff b f) = diff b (diff a f) := by
  funext x
  simp only [diff]
  have hab : x + a + b = x + b + a := by abel
  rw [hab]
  abel

/-- The analytic seed criterion needed for the relaxed index upper bound. -/
theorem constant_second_dependent {m : ℕ} (hm : 2 ≤ m) (a b : Vec m)
    (h : ∃ z : Scalar, ∀ x, diff a (diff b (seed m)) x = z) :
    a = 0 ∨ b = 0 ∨ a = b := by
  obtain ⟨z,hz⟩ := h
  have hf : diff a (diff b (seed m)) = fun _ => z := funext hz
  apply seed_property_A hm a b
  intro c d
  unfold fourth
  rw [diff_comm b c, diff_comm a c, diff_comm b d, diff_comm a d, hf]
  simp [diff]

@[simp] theorem vec_add_self {m : ℕ} (a : Vec m) : a + a = 0 := by
  funext i
  apply Prod.ext <;> simp [Pi.add_apply]

@[simp] theorem diff_zero {m : ℕ} (f : Vec m → Scalar) : diff 0 f = 0 := by
  funext x
  simp [diff]

@[simp] theorem diff_self {m : ℕ} (a : Vec m) (f : Vec m → Scalar) :
    diff a (diff a f) = 0 := by
  funext x
  simp only [diff]
  have hx : x + a + a = x := by rw [add_assoc, vec_add_self, add_zero]
  rw [hx]
  calc
    f x + f (x + a) + (f (x + a) + f x) =
        (f x + f x) + (f (x + a) + f (x + a)) := by abel
    _ = 0 := by simp

/-- Exact criterion for constant second differences, uniform in m. -/
theorem constant_second_iff {m : ℕ} (hm : 2 ≤ m) (a b : Vec m) :
    (∃ z : Scalar, ∀ x, diff a (diff b (seed m)) x = z) ↔
      a = 0 ∨ b = 0 ∨ a = b := by
  constructor
  · exact constant_second_dependent hm a b
  · intro h
    refine ⟨0, ?_⟩
    rcases h with ha | hb | hab
    · subst a; simp
    · subst b; simp [diff]
    · subst b; simp

/-- Exact zero-contraction criterion for actual fourth finite differences. -/
theorem fourth_pair_zero_iff {m : ℕ} (hm : 2 ≤ m) (a b : Vec m) :
    (∀ c d, fourth (seed m) a b c d 0 = 0) ↔
      a = 0 ∨ b = 0 ∨ a = b := by
  constructor
  · exact seed_property_A hm a b
  · intro h c d
    rcases h with ha | hb | hab
    · subst a; simp [fourth]
    · subst b; simp [fourth, diff]
    · subst b; simp [fourth]

end VonoV3C
