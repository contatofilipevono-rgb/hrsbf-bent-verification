import H12AffineCanonicalPilotProof002

namespace H12AffineCanonicalPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem rejected (f : Nat → Bool) (hm : packedModels f rootPS) : ¬H12CertificateBridge.Target (packedObservation f rootObs) :=
  H12AffineState.reject_identity H12CertificateBridge.Target rootPS rootObs ref0 f hm

#print axioms rejected

end H12AffineCanonicalPilot