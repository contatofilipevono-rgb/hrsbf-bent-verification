import H12FastPilotProof000

namespace H12FastPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem rejected (f : Nat → Bool) (hm : packedModels (H12AffineFastState.assignment env0 f) rootPS) : ¬H12CertificateBridge.Target (packedObservation (H12AffineFastState.assignment env0 f) rootObs) :=
  H12AffineFastState.refutes_sound H12CertificateBridge.Target rootPS rootObs env0 ref0 f hm

#print axioms rejected

end H12FastPilot