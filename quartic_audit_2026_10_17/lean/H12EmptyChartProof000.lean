import H12EmptyChartData000

namespace H12EmptyChart

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref0 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env0 :=
  .contradiction _ [30] (by decide +kernel) (by decide +kernel)

end H12EmptyChart