import H12TerminalTheory
import H12WitnessSearch
import H12ChartFilters

namespace H12CertificateBridge
open H12BooleanPolynomial H12Refutation H12TerminalTheory

def Target (bits : List Bool) : Prop :=
  H12Descent.BentAC (H12.quarticFunction (fromObservation bits))

def terminalCheck (n : Nat) (env : System) (active : List Nat) (tree : H12WitnessSearch.Tree) : Bool :=
  supportCheck n env active && (List.range (2^active.length)).all
    (fun z => H12WitnessSearch.lookup tree (decode n env active z).toNat)

theorem terminalCheck_sound (n : Nat) (env : System) (active : List Nat) (tree : H12WitnessSearch.Tree)
    (hg : H12WitnessSearch.Good tree) (hc : terminalCheck n env active tree = true) :
    ∀ f : Nat → Bool, ¬Target (observation n f env) := by
  simp only [terminalCheck, Bool.and_eq_true] at hc
  apply terminal_sound n env active hc.1
  intro z hz
  have hl := List.all_eq_true.mp hc.2 z (List.mem_range.mpr hz)
  have hr := hg (decode n env active z).toNat hl
  simpa using hr

def rootEnv (k : Nat) : System := (List.range 43).map (H12Affine.rowU k)

theorem root_observation (k : Nat) (u : BitVec 36) :
    fromObservation (observation 36 u.getLsbD (rootEnv k)) = H12Affine.embed k u := by
  apply BitVec.eq_of_getLsbD_eq
  intro i hi
  rw [fromObservation, H12Affine.get_fromFn _ i hi, H12Affine.embed,
    H12Affine.get_fromFn _ i hi]
  simp [rootEnv, observation, List.getD_eq_getElem?_getD, hi]

theorem no_bent_of_three_refutations
    (proof : ∀ k : Fin 3, Refutes 36 Target H12ChartFilters.targets[k.val]! (rootEnv k.val)) :
    ∀ c : BitVec 43, ¬H12Descent.BentAC (H12.quarticFunction c) := by
  intro c hb
  obtain ⟨k,u,he,hm⟩ := H12ChartFilters.bent_root c hb
  have hr := refutes_sound 36 Target _ _ (proof k) u.getLsbD hm
  apply hr
  change H12Descent.BentAC (H12.quarticFunction (fromObservation
    (observation 36 u.getLsbD (rootEnv k.val))))
  rwa [root_observation, he]

#print axioms terminalCheck_sound
#print axioms root_observation
#print axioms no_bent_of_three_refutations
end H12CertificateBridge
