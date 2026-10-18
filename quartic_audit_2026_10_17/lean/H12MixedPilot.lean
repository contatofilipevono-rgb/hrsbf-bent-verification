import H12MixedPilotData005

namespace H12MixedPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref16 : PackedRefutes H12CertificateBridge.Target ps16 env16 :=
  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env16 active16 tree16 treeGood16 terminalChecked16)

theorem ref15 : PackedRefutes H12CertificateBridge.Target ps15 env15 := by
  apply PackedRefutes.eliminate ps15 env15 1 0 (by decide) [1] selectedBound15 identity15 psBound15 envBound15
  rw [psTrans15_16, envTrans15_16]; exact ref16

theorem ref14 : PackedRefutes H12CertificateBridge.Target ps14 env14 := by
  apply PackedRefutes.eliminate ps14 env14 11 2050 (by decide) [0] selectedBound14 identity14 psBound14 envBound14
  rw [psTrans14_15, envTrans14_15]; exact ref15

theorem ref13 : PackedRefutes H12CertificateBridge.Target ps13 env13 := by
  apply PackedRefutes.eliminate ps13 env13 2 2 (by decide) [0,7] selectedBound13 identity13 psBound13 envBound13
  rw [psTrans13_14, envTrans13_14]; exact ref14

theorem ref12 : PackedRefutes H12CertificateBridge.Target ps12 env12 := by
  apply PackedRefutes.eliminate ps12 env12 3 0 (by decide) [1,5] selectedBound12 identity12 psBound12 envBound12
  rw [psTrans12_13, envTrans12_13]; exact ref13

theorem ref11 : PackedRefutes H12CertificateBridge.Target ps11 env11 := by
  apply PackedRefutes.eliminate ps11 env11 4 10 (by decide) [0,4] selectedBound11 identity11 psBound11 envBound11
  rw [psTrans11_12, envTrans11_12]; exact ref12

theorem ref10 : PackedRefutes H12CertificateBridge.Target ps10 env10 := by
  apply PackedRefutes.eliminate ps10 env10 13 4112 (by decide) [6] selectedBound10 identity10 psBound10 envBound10
  rw [psTrans10_11, envTrans10_11]; exact ref11

theorem ref9 : PackedRefutes H12CertificateBridge.Target ps9 env9 := by
  apply PackedRefutes.eliminate ps9 env9 5 16 (by decide) [1,3] selectedBound9 identity9 psBound9 envBound9
  rw [psTrans9_10, envTrans9_10]; exact ref10

theorem ref8 : PackedRefutes H12CertificateBridge.Target ps8 env8 := by
  apply PackedRefutes.eliminate ps8 env8 14 0 (by decide) [0,2,4,7,9] selectedBound8 identity8 psBound8 envBound8
  rw [psTrans8_9, envTrans8_9]; exact ref9

theorem ref7 : PackedRefutes H12CertificateBridge.Target ps7 env7 := by
  apply PackedRefutes.eliminate ps7 env7 17 34848 (by decide) [2,4,6,9,11] selectedBound7 identity7 psBound7 envBound7
  rw [psTrans7_8, envTrans7_8]; exact ref8

theorem ref6 : PackedRefutes H12CertificateBridge.Target ps6 env6 := by
  apply PackedRefutes.eliminate ps6 env6 6 40 (by decide) [13] selectedBound6 identity6 psBound6 envBound6
  rw [psTrans6_7, envTrans6_7]; exact ref7

theorem ref5 : PackedRefutes H12CertificateBridge.Target ps5 env5 := by
  apply PackedRefutes.eliminate ps5 env5 16 4264 (by decide) [2,13,14] selectedBound5 identity5 psBound5 envBound5
  rw [psTrans5_6, envTrans5_6]; exact ref6

theorem ref4 : PackedRefutes H12CertificateBridge.Target ps4 env4 := by
  apply PackedRefutes.eliminate ps4 env4 15 32802 (by decide) [2,9,11,13,17,18,22] selectedBound4 identity4 psBound4 envBound4
  rw [psTrans4_5, envTrans4_5]; exact ref5

theorem ref3 : PackedRefutes H12CertificateBridge.Target ps3 env3 := by
  apply PackedRefutes.eliminate ps3 env3 12 8 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound3 identity3 psBound3 envBound3
  rw [psTrans3_4, envTrans3_4]; exact ref4

theorem ref2 : PackedRefutes H12CertificateBridge.Target ps2 env2 := by
  apply PackedRefutes.eliminate ps2 env2 22 180392 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound2 identity2 psBound2 envBound2
  rw [psTrans2_3, envTrans2_3]; exact ref3

theorem ref31 : PackedRefutes H12CertificateBridge.Target ps31 env31 :=
  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env31 active31 tree31 treeGood31 terminalChecked31)

theorem ref30 : PackedRefutes H12CertificateBridge.Target ps30 env30 := by
  apply PackedRefutes.eliminate ps30 env30 8 4 (by decide) [1] selectedBound30 identity30 psBound30 envBound30
  rw [psTrans30_31, envTrans30_31]; exact ref31

theorem ref29 : PackedRefutes H12CertificateBridge.Target ps29 env29 := by
  apply PackedRefutes.eliminate ps29 env29 10 3 (by decide) [0] selectedBound29 identity29 psBound29 envBound29
  rw [psTrans29_30, envTrans29_30]; exact ref30

theorem ref28 : PackedRefutes H12CertificateBridge.Target ps28 env28 := by
  apply PackedRefutes.eliminate ps28 env28 2 2 (by decide) [0,7] selectedBound28 identity28 psBound28 envBound28
  rw [psTrans28_29, envTrans28_29]; exact ref29

theorem ref27 : PackedRefutes H12CertificateBridge.Target ps27 env27 := by
  apply PackedRefutes.eliminate ps27 env27 3 1 (by decide) [1,5] selectedBound27 identity27 psBound27 envBound27
  rw [psTrans27_28, envTrans27_28]; exact ref28

theorem ref26 : PackedRefutes H12CertificateBridge.Target ps26 env26 := by
  apply PackedRefutes.eliminate ps26 env26 4 10 (by decide) [0,4] selectedBound26 identity26 psBound26 envBound26
  rw [psTrans26_27, envTrans26_27]; exact ref27

theorem ref25 : PackedRefutes H12CertificateBridge.Target ps25 env25 := by
  apply PackedRefutes.eliminate ps25 env25 13 4113 (by decide) [2] selectedBound25 identity25 psBound25 envBound25
  rw [psTrans25_26, envTrans25_26]; exact ref26

theorem ref24 : PackedRefutes H12CertificateBridge.Target ps24 env24 := by
  apply PackedRefutes.eliminate ps24 env24 5 16 (by decide) [1,3] selectedBound24 identity24 psBound24 envBound24
  rw [psTrans24_25, envTrans24_25]; exact ref25

theorem ref23 : PackedRefutes H12CertificateBridge.Target ps23 env23 := by
  apply PackedRefutes.eliminate ps23 env23 14 0 (by decide) [0,2,4,7,9] selectedBound23 identity23 psBound23 envBound23
  rw [psTrans23_24, envTrans23_24]; exact ref24

theorem ref22 : PackedRefutes H12CertificateBridge.Target ps22 env22 := by
  apply PackedRefutes.eliminate ps22 env22 17 34848 (by decide) [2,4,6,9,11] selectedBound22 identity22 psBound22 envBound22
  rw [psTrans22_23, envTrans22_23]; exact ref23

theorem ref21 : PackedRefutes H12CertificateBridge.Target ps21 env21 := by
  apply PackedRefutes.eliminate ps21 env21 6 40 (by decide) [13] selectedBound21 identity21 psBound21 envBound21
  rw [psTrans21_22, envTrans21_22]; exact ref22

theorem ref20 : PackedRefutes H12CertificateBridge.Target ps20 env20 := by
  apply PackedRefutes.eliminate ps20 env20 16 4265 (by decide) [2,13,14] selectedBound20 identity20 psBound20 envBound20
  rw [psTrans20_21, envTrans20_21]; exact ref21

theorem ref19 : PackedRefutes H12CertificateBridge.Target ps19 env19 := by
  apply PackedRefutes.eliminate ps19 env19 12 8 (by decide) [2,9,11,13,17,18,22] selectedBound19 identity19 psBound19 envBound19
  rw [psTrans19_20, envTrans19_20]; exact ref20

theorem ref18 : PackedRefutes H12CertificateBridge.Target ps18 env18 := by
  apply PackedRefutes.eliminate ps18 env18 15 41002 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound18 identity18 psBound18 envBound18
  rw [psTrans18_19, envTrans18_19]; exact ref19

theorem ref17 : PackedRefutes H12CertificateBridge.Target ps17 env17 := by
  apply PackedRefutes.eliminate ps17 env17 22 213130 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound17 identity17 psBound17 envBound17
  rw [psTrans17_18, envTrans17_18]; exact ref18

theorem ref1 : PackedRefutes H12CertificateBridge.Target ps1 env1 := by
  apply PackedRefutes.split ps1 env1 9 236 (by decide) psBound1 envBound1
  · rw [psTrans1_2, envTrans1_2]; exact ref2
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, psTrans1_17, envTrans1_17]; exact ref17

theorem ref0 : PackedRefutes H12CertificateBridge.Target ps0 env0 := by
  apply PackedRefutes.eliminate ps0 env0 20 17596 (by decide) [3,5,10] selectedBound0 identity0 psBound0 envBound0
  rw [psTrans0_1, envTrans0_1]; exact ref1

theorem rejected (f : Nat → Bool) (hm : packedModels f ps0) : ¬H12CertificateBridge.Target (packedObservation f env0) :=
  packedRefutes_sound H12CertificateBridge.Target _ _ ref0 f hm

#print axioms rejected

end H12MixedPilot