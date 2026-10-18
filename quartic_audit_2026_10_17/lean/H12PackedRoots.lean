import H12PackedPolynomial
import H12CertificateBridge
namespace H12PackedRoots
open H12PackedPolynomial H12BooleanPolynomial H12Refutation H12CertificateBridge
set_option maxRecDepth 100000
set_option maxHeartbeats 1000000000

def packSystem (ps : System) : List Nat := ps.map (encode denseBook)

def closedSystem (ps : System) : Bool := ps.all (fun p => p.all denseBook.contains)

theorem closedSystem_sound (ps : System) (hc : closedSystem ps = true) :
    ∀ p ∈ ps, ∀ m ∈ p, m ∈ denseBook := by
  intro p hp m hm
  have h := List.all_eq_true.mp (List.all_eq_true.mp hc p hp) m hm
  exact List.contains_iff_mem.mp h

theorem packSystem_models (f : Nat → Bool) (ps : System) (hc : closedSystem ps = true)
    (hm : Models 36 f ps) : packedModels f (packSystem ps) := by
  intro q hq
  obtain ⟨p,hp,rfl⟩ := List.mem_map.mp hq
  rw [encode_sound 36 f denseBook p (closedSystem_sound ps hc p hp)]
  exact hm p hp

theorem packSystem_observation (f : Nat → Bool) (env : System) (hc : closedSystem env = true) :
    packedObservation f (packSystem env) = observation 36 f env := by
  simp only [packedObservation, packSystem, List.map_map, Function.comp_def, observation]
  apply List.map_congr_left
  intro p hp
  exact encode_sound 36 f denseBook p (closedSystem_sound env hc p hp)

def rootPS (k : Nat) : List Nat := packSystem H12ChartFilters.targets[k]!
def rootEnv (k : Nat) : List Nat := packSystem (H12CertificateBridge.rootEnv k)

def rootClosedCheck : Bool := (List.range 3).all (fun k =>
  closedSystem H12ChartFilters.targets[k]! && closedSystem (H12CertificateBridge.rootEnv k))

theorem rootClosed_checked : rootClosedCheck = true := by decide +kernel
#print axioms rootClosed_checked

theorem rootClosed (k : Fin 3) :
    closedSystem H12ChartFilters.targets[k.val]! = true ∧
    closedSystem (H12CertificateBridge.rootEnv k.val) = true := by
  have h := List.all_eq_true.mp rootClosed_checked k.val (List.mem_range.mpr k.isLt)
  simpa only [Bool.and_eq_true] using h

theorem no_bent_of_packed_refutations
    (proof : ∀ k : Fin 3, PackedRefutes Target (rootPS k.val) (rootEnv k.val)) :
    ∀ c : BitVec 43, ¬H12Descent.BentAC (H12.quarticFunction c) := by
  intro c hb
  obtain ⟨k,u,he,hm⟩ := H12ChartFilters.bent_root c hb
  have hc := rootClosed k
  have hp : packedModels u.getLsbD (rootPS k.val) := packSystem_models _ _ hc.1 hm
  have hr := packedRefutes_sound Target _ _ (proof k) u.getLsbD hp
  apply hr
  rw [rootEnv, packSystem_observation _ _ hc.2]
  change H12Descent.BentAC (H12.quarticFunction (H12TerminalTheory.fromObservation
    (observation 36 u.getLsbD (H12CertificateBridge.rootEnv k.val))))
  rw [H12CertificateBridge.root_observation, he]
  exact hb

#print axioms no_bent_of_packed_refutations
end H12PackedRoots
