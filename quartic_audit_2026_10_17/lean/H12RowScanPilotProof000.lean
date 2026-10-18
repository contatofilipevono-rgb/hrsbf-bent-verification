import H12RowScanPilotData000

namespace H12RowScanPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref16 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env16 :=
  .terminal _ (H12AffineRowScanState.leaf_sound env16 rootObs leafEnv16 active16 tree16 rootObsBound treeGood16 leafIdentity16 terminalChecked16)

theorem ref15 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env15 := by
  apply H12AffineRowScanState.Refutes.eliminate env15 1 0 (by decide) [1] selectedBound15 identity15 envBound15
  · rw [envTrans15_16]; exact envBound16
  · rw [envTrans15_16]; exact ref16

theorem ref14 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env14 := by
  apply H12AffineRowScanState.Refutes.eliminate env14 11 2050 (by decide) [0] selectedBound14 identity14 envBound14
  · rw [envTrans14_15]; exact envBound15
  · rw [envTrans14_15]; exact ref15

theorem ref13 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env13 := by
  apply H12AffineRowScanState.Refutes.eliminate env13 2 2 (by decide) [0,7] selectedBound13 identity13 envBound13
  · rw [envTrans13_14]; exact envBound14
  · rw [envTrans13_14]; exact ref14

theorem ref12 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env12 := by
  apply H12AffineRowScanState.Refutes.eliminate env12 3 0 (by decide) [1,5] selectedBound12 identity12 envBound12
  · rw [envTrans12_13]; exact envBound13
  · rw [envTrans12_13]; exact ref13

theorem ref11 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env11 := by
  apply H12AffineRowScanState.Refutes.eliminate env11 4 10 (by decide) [0,4] selectedBound11 identity11 envBound11
  · rw [envTrans11_12]; exact envBound12
  · rw [envTrans11_12]; exact ref12

theorem ref10 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env10 := by
  apply H12AffineRowScanState.Refutes.eliminate env10 13 4112 (by decide) [6] selectedBound10 identity10 envBound10
  · rw [envTrans10_11]; exact envBound11
  · rw [envTrans10_11]; exact ref11

theorem ref9 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env9 := by
  apply H12AffineRowScanState.Refutes.eliminate env9 5 16 (by decide) [1,3] selectedBound9 identity9 envBound9
  · rw [envTrans9_10]; exact envBound10
  · rw [envTrans9_10]; exact ref10

theorem ref8 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env8 := by
  apply H12AffineRowScanState.Refutes.eliminate env8 14 0 (by decide) [0,2,4,7,9] selectedBound8 identity8 envBound8
  · rw [envTrans8_9]; exact envBound9
  · rw [envTrans8_9]; exact ref9

theorem ref7 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env7 := by
  apply H12AffineRowScanState.Refutes.eliminate env7 17 34848 (by decide) [2,4,6,9,11] selectedBound7 identity7 envBound7
  · rw [envTrans7_8]; exact envBound8
  · rw [envTrans7_8]; exact ref8

theorem ref6 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env6 := by
  apply H12AffineRowScanState.Refutes.eliminate env6 6 40 (by decide) [13] selectedBound6 identity6 envBound6
  · rw [envTrans6_7]; exact envBound7
  · rw [envTrans6_7]; exact ref7

theorem ref5 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env5 := by
  apply H12AffineRowScanState.Refutes.eliminate env5 16 4264 (by decide) [2,13,14] selectedBound5 identity5 envBound5
  · rw [envTrans5_6]; exact envBound6
  · rw [envTrans5_6]; exact ref6

theorem ref4 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env4 := by
  apply H12AffineRowScanState.Refutes.eliminate env4 15 32802 (by decide) [2,9,11,13,17,18,22] selectedBound4 identity4 envBound4
  · rw [envTrans4_5]; exact envBound5
  · rw [envTrans4_5]; exact ref5

theorem ref3 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env3 := by
  apply H12AffineRowScanState.Refutes.eliminate env3 12 8 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound3 identity3 envBound3
  · rw [envTrans3_4]; exact envBound4
  · rw [envTrans3_4]; exact ref4

theorem ref2 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env2 := by
  apply H12AffineRowScanState.Refutes.eliminate env2 22 180392 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound2 identity2 envBound2
  · rw [envTrans2_3]; exact envBound3
  · rw [envTrans2_3]; exact ref3

theorem ref31 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env31 :=
  .terminal _ (H12AffineRowScanState.leaf_sound env31 rootObs leafEnv31 active31 tree31 rootObsBound treeGood31 leafIdentity31 terminalChecked31)

theorem ref30 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env30 := by
  apply H12AffineRowScanState.Refutes.eliminate env30 8 4 (by decide) [1] selectedBound30 identity30 envBound30
  · rw [envTrans30_31]; exact envBound31
  · rw [envTrans30_31]; exact ref31

theorem ref29 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env29 := by
  apply H12AffineRowScanState.Refutes.eliminate env29 10 3 (by decide) [0] selectedBound29 identity29 envBound29
  · rw [envTrans29_30]; exact envBound30
  · rw [envTrans29_30]; exact ref30

theorem ref28 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env28 := by
  apply H12AffineRowScanState.Refutes.eliminate env28 2 2 (by decide) [0,7] selectedBound28 identity28 envBound28
  · rw [envTrans28_29]; exact envBound29
  · rw [envTrans28_29]; exact ref29

theorem ref27 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env27 := by
  apply H12AffineRowScanState.Refutes.eliminate env27 3 1 (by decide) [1,5] selectedBound27 identity27 envBound27
  · rw [envTrans27_28]; exact envBound28
  · rw [envTrans27_28]; exact ref28

theorem ref26 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env26 := by
  apply H12AffineRowScanState.Refutes.eliminate env26 4 10 (by decide) [0,4] selectedBound26 identity26 envBound26
  · rw [envTrans26_27]; exact envBound27
  · rw [envTrans26_27]; exact ref27

theorem ref25 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env25 := by
  apply H12AffineRowScanState.Refutes.eliminate env25 13 4113 (by decide) [2] selectedBound25 identity25 envBound25
  · rw [envTrans25_26]; exact envBound26
  · rw [envTrans25_26]; exact ref26

theorem ref24 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env24 := by
  apply H12AffineRowScanState.Refutes.eliminate env24 5 16 (by decide) [1,3] selectedBound24 identity24 envBound24
  · rw [envTrans24_25]; exact envBound25
  · rw [envTrans24_25]; exact ref25

theorem ref23 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env23 := by
  apply H12AffineRowScanState.Refutes.eliminate env23 14 0 (by decide) [0,2,4,7,9] selectedBound23 identity23 envBound23
  · rw [envTrans23_24]; exact envBound24
  · rw [envTrans23_24]; exact ref24

theorem ref22 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env22 := by
  apply H12AffineRowScanState.Refutes.eliminate env22 17 34848 (by decide) [2,4,6,9,11] selectedBound22 identity22 envBound22
  · rw [envTrans22_23]; exact envBound23
  · rw [envTrans22_23]; exact ref23

theorem ref21 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env21 := by
  apply H12AffineRowScanState.Refutes.eliminate env21 6 40 (by decide) [13] selectedBound21 identity21 envBound21
  · rw [envTrans21_22]; exact envBound22
  · rw [envTrans21_22]; exact ref22

theorem ref20 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env20 := by
  apply H12AffineRowScanState.Refutes.eliminate env20 16 4265 (by decide) [2,13,14] selectedBound20 identity20 envBound20
  · rw [envTrans20_21]; exact envBound21
  · rw [envTrans20_21]; exact ref21

theorem ref19 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env19 := by
  apply H12AffineRowScanState.Refutes.eliminate env19 12 8 (by decide) [2,9,11,13,17,18,22] selectedBound19 identity19 envBound19
  · rw [envTrans19_20]; exact envBound20
  · rw [envTrans19_20]; exact ref20

theorem ref18 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env18 := by
  apply H12AffineRowScanState.Refutes.eliminate env18 15 41002 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound18 identity18 envBound18
  · rw [envTrans18_19]; exact envBound19
  · rw [envTrans18_19]; exact ref19

theorem ref17 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env17 := by
  apply H12AffineRowScanState.Refutes.eliminate env17 22 213130 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound17 identity17 envBound17
  · rw [envTrans17_18]; exact envBound18
  · rw [envTrans17_18]; exact ref18

theorem ref1 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env1 := by
  apply H12AffineRowScanState.Refutes.split env1 9 236 (by decide) envBound1
  · rw [envTrans1_2]; exact envBound2
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, envTrans1_17]; exact envBound17
  · rw [envTrans1_2]; exact ref2
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, envTrans1_17]; exact ref17

theorem ref0 : H12AffineRowScanState.Refutes H12CertificateBridge.Target rootPS rootObs env0 := by
  apply H12AffineRowScanState.Refutes.eliminate env0 20 17596 (by decide) [3,5,10] selectedBound0 identity0 envBound0
  · rw [envTrans0_1]; exact envBound1
  · rw [envTrans0_1]; exact ref1

end H12RowScanPilot