import H12LabelPilotProof000

namespace H12LabelPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem rejected (f : Nat → Bool) (hm : packedModels (H12AffineRowScanState.assignment env0 f) rootPS) : ¬H12CertificateBridge.Target (packedObservation (H12AffineRowScanState.assignment env0 f) rootObs) :=
  H12AffineRowScanState.refutes_sound H12CertificateBridge.Target rootPS rootObs env0 ref0 f hm

#print axioms rejected

end H12LabelPilot