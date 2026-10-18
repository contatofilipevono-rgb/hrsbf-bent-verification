import H12AffineCanonicalPilotProof001

namespace H12AffineCanonicalPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref103 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env103 := by
  apply H12AffineState.Refutes.eliminate env103 34 78894 (by decide) [0,6,7,14,20] selectedBound103 identity103 envBound103
  · rw [envTrans103_104]; exact envBound104
  · rw [envTrans103_104]; exact ref104

theorem ref121 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env121 :=
  .contradiction _ [15] (by decide +kernel) (by decide +kernel)

theorem ref120 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env120 := by
  apply H12AffineState.Refutes.eliminate env120 5 12 (by decide) [0,1] selectedBound120 identity120 envBound120
  · rw [envTrans120_121]; exact envBound121
  · rw [envTrans120_121]; exact ref121

theorem ref119 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env119 := by
  apply H12AffineState.Refutes.eliminate env119 3 11 (by decide) [1,8] selectedBound119 identity119 envBound119
  · rw [envTrans119_120]; exact envBound120
  · rw [envTrans119_120]; exact ref120

theorem ref118 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env118 := by
  apply H12AffineState.Refutes.eliminate env118 6 9 (by decide) [1,5] selectedBound118 identity118 envBound118
  · rw [envTrans118_119]; exact envBound119
  · rw [envTrans118_119]; exact ref119

theorem ref117 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env117 := by
  apply H12AffineState.Refutes.eliminate env117 10 147 (by decide) [0,4] selectedBound117 identity117 envBound117
  · rw [envTrans117_118]; exact envBound118
  · rw [envTrans117_118]; exact ref118

theorem ref116 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env116 := by
  apply H12AffineState.Refutes.eliminate env116 9 5 (by decide) [2] selectedBound116 identity116 envBound116
  · rw [envTrans116_117]; exact envBound117
  · rw [envTrans116_117]; exact ref117

theorem ref115 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env115 := by
  apply H12AffineState.Refutes.eliminate env115 8 32 (by decide) [2,11] selectedBound115 identity115 envBound115
  · rw [envTrans115_116]; exact envBound116
  · rw [envTrans115_116]; exact ref116

theorem ref114 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env114 := by
  apply H12AffineState.Refutes.eliminate env114 11 1589 (by decide) [0,7] selectedBound114 identity114 envBound114
  · rw [envTrans114_115]; exact envBound115
  · rw [envTrans114_115]; exact ref115

theorem ref113 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env113 := by
  apply H12AffineState.Refutes.eliminate env113 34 5292 (by decide) [0,2,5,7,8,11,12] selectedBound113 identity113 envBound113
  · rw [envTrans113_114]; exact envBound114
  · rw [envTrans113_114]; exact ref114

theorem ref112 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env112 := by
  apply H12AffineState.Refutes.eliminate env112 13 5773 (by decide) [2,6] selectedBound112 identity112 envBound112
  · rw [envTrans112_113]; exact envBound113
  · rw [envTrans112_113]; exact ref113

theorem ref111 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env111 := by
  apply H12AffineState.Refutes.eliminate env111 12 640 (by decide) [1,3] selectedBound111 identity111 envBound111
  · rw [envTrans111_112]; exact envBound112
  · rw [envTrans111_112]; exact ref112

theorem ref110 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env110 := by
  apply H12AffineState.Refutes.eliminate env110 15 8323 (by decide) [0,4,6,7,9] selectedBound110 identity110 envBound110
  · rw [envTrans110_111]; exact envBound111
  · rw [envTrans110_111]; exact ref111

theorem ref109 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env109 := by
  apply H12AffineState.Refutes.eliminate env109 17 2185 (by decide) [21] selectedBound109 identity109 envBound109
  · rw [envTrans109_110]; exact envBound110
  · rw [envTrans109_110]; exact ref110

theorem ref108 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env108 := by
  apply H12AffineState.Refutes.eliminate env108 18 94334 (by decide) [0,6,7,14,20] selectedBound108 identity108 envBound108
  · rw [envTrans108_109]; exact envBound109
  · rw [envTrans108_109]; exact ref109

theorem ref102 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env102 := by
  apply H12AffineState.Refutes.split env102 22 525328 (by decide) envBound102
  · rw [envTrans102_103]; exact envBound103
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, envTrans102_108]; exact envBound108
  · rw [envTrans102_103]; exact ref103
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, envTrans102_108]; exact ref108

theorem ref88 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env88 := by
  apply H12AffineState.Refutes.split env88 14 8352 (by decide) envBound88
  · rw [envTrans88_89]; exact envBound89
  · rw [show 8352 ^^^ 1 = 8353 from by decide +kernel, envTrans88_102]; exact envBound102
  · rw [envTrans88_89]; exact ref89
  · rw [show 8352 ^^^ 1 = 8353 from by decide +kernel, envTrans88_102]; exact ref102

theorem ref87 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env87 := by
  apply H12AffineState.Refutes.eliminate env87 16 103631 (by decide) [3,5,10] selectedBound87 identity87 envBound87
  · rw [envTrans87_88]; exact envBound88
  · rw [envTrans87_88]; exact ref88

theorem ref74 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env74 := by
  apply H12AffineState.Refutes.split env74 20 570592 (by decide) envBound74
  · rw [envTrans74_75]; exact envBound75
  · rw [show 570592 ^^^ 1 = 570593 from by decide +kernel, envTrans74_87]; exact envBound87
  · rw [envTrans74_75]; exact ref75
  · rw [show 570592 ^^^ 1 = 570593 from by decide +kernel, envTrans74_87]; exact ref87

theorem ref73 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env73 := by
  apply H12AffineState.Refutes.eliminate env73 21 73891 (by decide) [0,3,7,9,10,13,14,20,21,22,24,26] selectedBound73 identity73 envBound73
  · rw [envTrans73_74]; exact envBound74
  · rw [envTrans73_74]; exact ref74

theorem ref1 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env1 := by
  apply H12AffineState.Refutes.split env1 7 252 (by decide) envBound1
  · rw [envTrans1_2]; exact envBound2
  · rw [show 252 ^^^ 1 = 253 from by decide +kernel, envTrans1_73]; exact envBound73
  · rw [envTrans1_2]; exact ref2
  · rw [show 252 ^^^ 1 = 253 from by decide +kernel, envTrans1_73]; exact ref73

theorem ref0 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env0 := by
  apply H12AffineState.Refutes.eliminate env0 25 566496 (by decide) [1,3,5,8,10,19] selectedBound0 identity0 envBound0
  · rw [envTrans0_1]; exact envBound1
  · rw [envTrans0_1]; exact ref1

end H12AffineCanonicalPilot