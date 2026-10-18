import H12WitnessTheory
import H12Affine

namespace H12TerminalTheory
open H12BooleanPolynomial H12Refutation

def Support (n : Nat) (env : System) (active : List Nat) : Prop :=
  ∀ p ∈ env, ∀ m ∈ p, ∀ i, i < n → m.testBit i = true → i ∈ active

def supportCheck (n : Nat) (env : System) (active : List Nat) : Bool :=
  env.all (fun p => p.all (fun m => (List.range n).all
    (fun i => !m.testBit i || active.contains i)))

theorem supportCheck_sound (n : Nat) (env : System) (active : List Nat)
    (h : supportCheck n env active = true) : Support n env active := by
  intro p hp m hm i hi hbit
  have hp' := List.all_eq_true.mp h p hp
  have hm' := List.all_eq_true.mp hp' m hm
  have hi' := List.all_eq_true.mp hm' i (List.mem_range.mpr hi)
  simpa [hbit] using hi'

theorem observation_congr (n : Nat) (env : System) (active : List Nat)
    (hs : Support n env active) (f g : Nat → Bool) (he : ∀ i ∈ active, f i = g i) :
    observation n f env = observation n g env := by
  unfold observation
  apply List.map_congr_left
  intro p hp
  have hm : p.map (monomial n f) = p.map (monomial n g) := by
    apply List.map_congr_left
    intro m hm
    unfold monomial
    apply H12Truth.all_congr_on
    intro i hi
    obtain ⟨hib,hbit⟩ := List.mem_filter.mp hi
    exact he i (hs p hp m hm i (List.mem_range.mp hib) hbit)
  have hh := congrArg (fun bs : List Bool => bs.foldr Bool.xor false) hm
  simpa only [List.foldr_map, evaluate] using hh

def pack (active : List Nat) (f : Nat → Bool) : Nat :=
  (BitVec.ofBoolListLE (active.map f)).toNat

def assignment (active : List Nat) (z : Nat) (i : Nat) : Bool := z.testBit (active.idxOf i)

theorem pack_lt (active : List Nat) (f : Nat → Bool) : pack active f < 2^active.length := by
  simpa [pack] using (BitVec.ofBoolListLE (active.map f)).isLt

theorem assignment_pack (active : List Nat) (f : Nat → Bool) (i : Nat) (hi : i ∈ active) :
    assignment active (pack active f) i = f i := by
  have hib := List.idxOf_lt_length_of_mem hi
  change (BitVec.ofBoolListLE (active.map f)).getLsbD (active.idxOf i) = f i
  rw [BitVec.getLsbD_ofBoolListLE, List.getD_eq_getElem?_getD,
    List.getElem?_eq_getElem (by simpa using hib)]
  simp only [Option.getD_some, List.getElem_map, List.getElem_idxOf hib]

def fromObservation (bits : List Bool) : BitVec 43 :=
  H12Affine.fromFn (fun i => bits.getD i.val false)

def decode (n : Nat) (env : System) (active : List Nat) (z : Nat) : BitVec 43 :=
  fromObservation (observation n (assignment active z) env)

theorem decode_covers (n : Nat) (env : System) (active : List Nat)
    (hs : Support n env active) (f : Nat → Bool) :
    ∃ z, z < 2^active.length ∧ decode n env active z = fromObservation (observation n f env) := by
  refine ⟨pack active f, pack_lt active f, ?_⟩
  unfold decode
  apply congrArg fromObservation
  exact observation_congr n env active hs _ f (fun i hi => assignment_pack active f i hi)

theorem terminal_sound (n : Nat) (env : System) (active : List Nat)
    (hs : supportCheck n env active = true)
    (hr : ∀ z, z < 2^active.length → ¬H12Descent.BentAC (H12.quarticFunction (decode n env active z))) :
    ∀ f : Nat → Bool, ¬H12Descent.BentAC (H12.quarticFunction (fromObservation (observation n f env))) := by
  intro f
  obtain ⟨z,hz,he⟩ := decode_covers n env active (supportCheck_sound n env active hs) f
  rw [← he]
  exact hr z hz

#print axioms terminal_sound
end H12TerminalTheory

