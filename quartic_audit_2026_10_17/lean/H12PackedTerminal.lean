import H12PackedPolynomial
import H12CertificateBridge

namespace H12PackedTerminal
set_option maxRecDepth 10000
set_option maxHeartbeats 10000000
open H12PackedPolynomial H12BooleanPolynomial H12TerminalTheory

theorem affineNative_mod (word : Nat) : affineNative word = word % 2^37 := by
  apply Nat.eq_of_testBit_eq
  intro j
  simp only [affineNative, linearNative, Nat.testBit_xor, Nat.testBit_shiftLeft,
    Nat.testBit_mod_two_pow, Nat.testBit_shiftRight]
  cases j with
  | zero =>
    cases hb : word.testBit 0 <;> simp [hb]
  | succ j =>
    have hc : (if word.testBit 0 then 1 else 0).testBit (j+1) = false := by
      cases word.testBit 0 with
      | false => exact Nat.zero_testBit _
      | true =>
        change (2^0 : Nat).testBit (j+1) = false
        simp only [Nat.testBit_two_pow, Nat.zero_ne_add_one, decide_false]
    rw [hc]
    simp only [Bool.false_xor]
    have hlt : (j+1 < 37) ↔ (j < 36) := by omega
    simp [hlt, Nat.add_comm]

theorem value_affine (f : Nat → Bool) (word : Nat) (hw : word < 2^37) :
    value 36 f denseBook word = affineValue f word := by
  have h := affineNative_sound f word
  rw [affineNative_mod, Nat.mod_eq_of_lt hw] at h
  exact h

def affineObservation (f : Nat → Bool) (env : List Nat) : List Bool := env.map (affineValue f)

theorem affineObservation_eq (f : Nat → Bool) (env : List Nat)
    (hb : ∀ p ∈ env, p < 2^37) : affineObservation f env = packedObservation f env := by
  apply List.map_congr_left
  intro p hp
  exact (value_affine f p (hb p hp)).symm

def expandEnv (env : List Nat) : H12Refutation.System := env.map (unpack denseBook)

theorem expanded_observation (f : Nat → Bool) (env : List Nat) :
    H12Refutation.observation 36 f (expandEnv env) = packedObservation f env := by
  simp only [H12Refutation.observation, expandEnv, List.map_map, Function.comp_def,
    packedObservation]
  rfl

def decode (env : List Nat) (active : List Nat) (z : Nat) : BitVec 43 :=
  fromObservation (affineObservation (assignment active z) env)

def terminalCheck (env : List Nat) (active : List Nat) (tree : H12WitnessSearch.Tree) : Bool :=
  env.all (fun p => decide (p < 2^37)) &&
  supportCheck 36 (expandEnv env) active &&
  (List.range (2^active.length)).all (fun z => H12WitnessSearch.lookup tree (decode env active z).toNat)

theorem terminalCheck_sound (env : List Nat) (active : List Nat) (tree : H12WitnessSearch.Tree)
    (hg : H12WitnessSearch.Good tree) (hc : terminalCheck env active tree = true) :
    ∀ f, ¬H12CertificateBridge.Target (packedObservation f env) := by
  simp only [terminalCheck, Bool.and_eq_true] at hc
  have hb : ∀ p ∈ env, p < 2^37 := by
    intro p hp
    exact of_decide_eq_true (List.all_eq_true.mp hc.1.1 p hp)
  intro f ht
  have hr := terminal_sound 36 (expandEnv env) active hc.1.2 (by
    intro z hz
    have hl := List.all_eq_true.mp hc.2 z (List.mem_range.mpr hz)
    have hd : decode env active z = H12TerminalTheory.decode 36 (expandEnv env) active z := by
      unfold decode H12TerminalTheory.decode
      rw [affineObservation_eq _ env hb, expanded_observation]
    rw [hd] at hl
    simpa using hg _ hl) f
  apply hr
  simpa only [H12CertificateBridge.Target, expanded_observation] using ht

#print axioms terminalCheck_sound

theorem linear_congr (f g : Nat → Bool) (width start word : Nat) (hw : start+width ≤ 36)
    (he : ∀ j, j < width → word.testBit j = true → f (start+j) = g (start+j)) :
    evaluate 36 f (unpack (unitMasks width start) word) =
      evaluate 36 g (unpack (unitMasks width start) word) := by
  induction width generalizing start word with
  | zero => rfl
  | succ width ih =>
    have ht := ih (start+1) (word >>> 1) (by omega) (by
      intro j hj hbit
      have hb : word.testBit (j+1) = true := by
        simpa only [Nat.testBit_shiftRight, Nat.add_comm] using hbit
      have hh := he (j+1) (by omega) hb
      simpa only [Nat.add_assoc, Nat.add_comm 1 j] using hh)
    cases hb : word.testBit 0 with
    | false => simpa only [unitMasks, unpack, hb, Bool.false_eq_true, ↓reduceIte] using ht
    | true =>
      have hs : start < 36 := by omega
      have hh := he 0 (by omega) hb
      simp only [Nat.add_zero] at hh
      simp only [unitMasks, unpack, hb, ↓reduceIte, evaluate_cons,
        monomial_unit 36 f start hs, monomial_unit 36 g start hs, hh, ht]

theorem affineValue_congr (f g : Nat → Bool) (word : Nat)
    (he : ∀ i, i < 36 → word.testBit (i+1) = true → f i = g i) :
    affineValue f word = affineValue g word := by
  have hl := linear_congr f g 36 0 (word >>> 1) (by decide) (by
    intro j hj hb
    have ht : word.testBit (j+1) = true := by
      simpa only [Nat.testBit_shiftRight, Nat.add_comm] using hb
    simpa only [Nat.zero_add] using he j hj ht)
  exact congrArg (fun b => word.testBit 0 ^^ b) hl

def affineSupportCheck (env : List Nat) (active : List Nat) : Bool :=
  env.all (fun word => (List.range 36).all (fun i => !word.testBit (i+1) || active.contains i))

theorem affineObservation_congr (env : List Nat) (active : List Nat)
    (hs : affineSupportCheck env active = true) (f g : Nat → Bool)
    (he : ∀ i ∈ active, f i = g i) : affineObservation f env = affineObservation g env := by
  apply List.map_congr_left
  intro word hw
  apply affineValue_congr f g word
  intro i hi hb
  have hh := List.all_eq_true.mp (List.all_eq_true.mp hs word hw) i (List.mem_range.mpr hi)
  have ha : i ∈ active := by simpa [hb] using hh
  exact he i ha

def terminalCheckFast (env : List Nat) (active : List Nat) (tree : H12WitnessSearch.Tree) : Bool :=
  env.all (fun p => decide (p < 2^37)) && affineSupportCheck env active &&
  (List.range (2^active.length)).all (fun z => H12WitnessSearch.lookup tree (decode env active z).toNat)

theorem terminalCheckFast_sound (env : List Nat) (active : List Nat) (tree : H12WitnessSearch.Tree)
    (hg : H12WitnessSearch.Good tree) (hc : terminalCheckFast env active tree = true) :
    ∀ f, ¬H12CertificateBridge.Target (packedObservation f env) := by
  simp only [terminalCheckFast, Bool.and_eq_true] at hc
  have hb : ∀ p ∈ env, p < 2^37 := by
    intro p hp
    exact of_decide_eq_true (List.all_eq_true.mp hc.1.1 p hp)
  intro f ht
  let z := pack active f
  have hz : z < 2^active.length := pack_lt active f
  have he : affineObservation (assignment active z) env = packedObservation f env := by
    rw [← affineObservation_eq f env hb]
    apply affineObservation_congr env active hc.1.2
    intro i hi
    exact assignment_pack active f i hi
  have hl := List.all_eq_true.mp hc.2 z (List.mem_range.mpr hz)
  have hr := hg _ hl
  apply hr
  have hd : decode env active z = fromObservation (packedObservation f env) := by
    unfold decode
    rw [he]
  simpa [hd, H12CertificateBridge.Target] using ht

#print axioms terminalCheckFast_sound
end H12PackedTerminal
