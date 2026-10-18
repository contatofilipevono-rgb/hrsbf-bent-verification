import H12AffineCanonicalPilotData005

namespace H12AffineCanonicalPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref21 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env21 :=
  .terminal _ (H12AffineState.leaf_sound env21 rootObs leafEnv21 active21 tree21 rootObsBound treeGood21 leafIdentity21 terminalChecked21)

theorem ref20 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env20 := by
  apply H12AffineState.Refutes.eliminate env20 1 0 (by decide) [1] selectedBound20 identity20 envBound20
  · rw [envTrans20_21]; exact envBound21
  · rw [envTrans20_21]; exact ref21

theorem ref19 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env19 := by
  apply H12AffineState.Refutes.eliminate env19 11 2050 (by decide) [0] selectedBound19 identity19 envBound19
  · rw [envTrans19_20]; exact envBound20
  · rw [envTrans19_20]; exact ref20

theorem ref18 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env18 := by
  apply H12AffineState.Refutes.eliminate env18 2 2 (by decide) [0,7] selectedBound18 identity18 envBound18
  · rw [envTrans18_19]; exact envBound19
  · rw [envTrans18_19]; exact ref19

theorem ref17 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env17 := by
  apply H12AffineState.Refutes.eliminate env17 3 0 (by decide) [1,5] selectedBound17 identity17 envBound17
  · rw [envTrans17_18]; exact envBound18
  · rw [envTrans17_18]; exact ref18

theorem ref16 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env16 := by
  apply H12AffineState.Refutes.eliminate env16 4 10 (by decide) [0,4] selectedBound16 identity16 envBound16
  · rw [envTrans16_17]; exact envBound17
  · rw [envTrans16_17]; exact ref17

theorem ref15 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env15 := by
  apply H12AffineState.Refutes.eliminate env15 13 4112 (by decide) [6] selectedBound15 identity15 envBound15
  · rw [envTrans15_16]; exact envBound16
  · rw [envTrans15_16]; exact ref16

theorem ref14 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env14 := by
  apply H12AffineState.Refutes.eliminate env14 5 16 (by decide) [1,3] selectedBound14 identity14 envBound14
  · rw [envTrans14_15]; exact envBound15
  · rw [envTrans14_15]; exact ref15

theorem ref13 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env13 := by
  apply H12AffineState.Refutes.eliminate env13 14 0 (by decide) [0,2,4,7,9] selectedBound13 identity13 envBound13
  · rw [envTrans13_14]; exact envBound14
  · rw [envTrans13_14]; exact ref14

theorem ref12 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env12 := by
  apply H12AffineState.Refutes.eliminate env12 17 34848 (by decide) [2,4,6,9,11] selectedBound12 identity12 envBound12
  · rw [envTrans12_13]; exact envBound13
  · rw [envTrans12_13]; exact ref13

theorem ref11 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env11 := by
  apply H12AffineState.Refutes.eliminate env11 6 40 (by decide) [13] selectedBound11 identity11 envBound11
  · rw [envTrans11_12]; exact envBound12
  · rw [envTrans11_12]; exact ref12

theorem ref10 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env10 := by
  apply H12AffineState.Refutes.eliminate env10 16 4264 (by decide) [2,13,14] selectedBound10 identity10 envBound10
  · rw [envTrans10_11]; exact envBound11
  · rw [envTrans10_11]; exact ref11

theorem ref9 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env9 := by
  apply H12AffineState.Refutes.eliminate env9 15 32802 (by decide) [2,9,11,13,17,18,22] selectedBound9 identity9 envBound9
  · rw [envTrans9_10]; exact envBound10
  · rw [envTrans9_10]; exact ref10

theorem ref8 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env8 := by
  apply H12AffineState.Refutes.eliminate env8 12 8 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound8 identity8 envBound8
  · rw [envTrans8_9]; exact envBound9
  · rw [envTrans8_9]; exact ref9

theorem ref7 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env7 := by
  apply H12AffineState.Refutes.eliminate env7 22 180392 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound7 identity7 envBound7
  · rw [envTrans7_8]; exact envBound8
  · rw [envTrans7_8]; exact ref8

theorem ref36 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env36 :=
  .terminal _ (H12AffineState.leaf_sound env36 rootObs leafEnv36 active36 tree36 rootObsBound treeGood36 leafIdentity36 terminalChecked36)

theorem ref35 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env35 := by
  apply H12AffineState.Refutes.eliminate env35 8 4 (by decide) [1] selectedBound35 identity35 envBound35
  · rw [envTrans35_36]; exact envBound36
  · rw [envTrans35_36]; exact ref36

theorem ref34 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env34 := by
  apply H12AffineState.Refutes.eliminate env34 10 3 (by decide) [0] selectedBound34 identity34 envBound34
  · rw [envTrans34_35]; exact envBound35
  · rw [envTrans34_35]; exact ref35

theorem ref33 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env33 := by
  apply H12AffineState.Refutes.eliminate env33 2 2 (by decide) [0,7] selectedBound33 identity33 envBound33
  · rw [envTrans33_34]; exact envBound34
  · rw [envTrans33_34]; exact ref34

theorem ref32 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env32 := by
  apply H12AffineState.Refutes.eliminate env32 3 1 (by decide) [1,5] selectedBound32 identity32 envBound32
  · rw [envTrans32_33]; exact envBound33
  · rw [envTrans32_33]; exact ref33

theorem ref31 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env31 := by
  apply H12AffineState.Refutes.eliminate env31 4 10 (by decide) [0,4] selectedBound31 identity31 envBound31
  · rw [envTrans31_32]; exact envBound32
  · rw [envTrans31_32]; exact ref32

theorem ref30 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env30 := by
  apply H12AffineState.Refutes.eliminate env30 13 4113 (by decide) [2] selectedBound30 identity30 envBound30
  · rw [envTrans30_31]; exact envBound31
  · rw [envTrans30_31]; exact ref31

theorem ref29 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env29 := by
  apply H12AffineState.Refutes.eliminate env29 5 16 (by decide) [1,3] selectedBound29 identity29 envBound29
  · rw [envTrans29_30]; exact envBound30
  · rw [envTrans29_30]; exact ref30

theorem ref28 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env28 := by
  apply H12AffineState.Refutes.eliminate env28 14 0 (by decide) [0,2,4,7,9] selectedBound28 identity28 envBound28
  · rw [envTrans28_29]; exact envBound29
  · rw [envTrans28_29]; exact ref29

theorem ref27 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env27 := by
  apply H12AffineState.Refutes.eliminate env27 17 34848 (by decide) [2,4,6,9,11] selectedBound27 identity27 envBound27
  · rw [envTrans27_28]; exact envBound28
  · rw [envTrans27_28]; exact ref28

theorem ref26 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env26 := by
  apply H12AffineState.Refutes.eliminate env26 6 40 (by decide) [13] selectedBound26 identity26 envBound26
  · rw [envTrans26_27]; exact envBound27
  · rw [envTrans26_27]; exact ref27

theorem ref25 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env25 := by
  apply H12AffineState.Refutes.eliminate env25 16 4265 (by decide) [2,13,14] selectedBound25 identity25 envBound25
  · rw [envTrans25_26]; exact envBound26
  · rw [envTrans25_26]; exact ref26

theorem ref24 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env24 := by
  apply H12AffineState.Refutes.eliminate env24 12 8 (by decide) [2,9,11,13,17,18,22] selectedBound24 identity24 envBound24
  · rw [envTrans24_25]; exact envBound25
  · rw [envTrans24_25]; exact ref25

theorem ref23 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env23 := by
  apply H12AffineState.Refutes.eliminate env23 15 41002 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound23 identity23 envBound23
  · rw [envTrans23_24]; exact envBound24
  · rw [envTrans23_24]; exact ref24

theorem ref22 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env22 := by
  apply H12AffineState.Refutes.eliminate env22 22 213130 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound22 identity22 envBound22
  · rw [envTrans22_23]; exact envBound23
  · rw [envTrans22_23]; exact ref23

theorem ref6 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env6 := by
  apply H12AffineState.Refutes.split env6 9 236 (by decide) envBound6
  · rw [envTrans6_7]; exact envBound7
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, envTrans6_22]; exact envBound22
  · rw [envTrans6_7]; exact ref7
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, envTrans6_22]; exact ref22

theorem ref5 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env5 := by
  apply H12AffineState.Refutes.eliminate env5 20 17596 (by decide) [3,5,10] selectedBound5 identity5 envBound5
  · rw [envTrans5_6]; exact envBound6
  · rw [envTrans5_6]; exact ref6

theorem ref53 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env53 :=
  .terminal _ (H12AffineState.leaf_sound env53 rootObs leafEnv53 active53 tree53 rootObsBound treeGood53 leafIdentity53 terminalChecked53)

theorem ref52 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env52 := by
  apply H12AffineState.Refutes.eliminate env52 1 0 (by decide) [1] selectedBound52 identity52 envBound52
  · rw [envTrans52_53]; exact envBound53
  · rw [envTrans52_53]; exact ref53

theorem ref51 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env51 := by
  apply H12AffineState.Refutes.eliminate env51 11 2051 (by decide) [0] selectedBound51 identity51 envBound51
  · rw [envTrans51_52]; exact envBound52
  · rw [envTrans51_52]; exact ref52

theorem ref50 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env50 := by
  apply H12AffineState.Refutes.eliminate env50 2 2 (by decide) [0,7] selectedBound50 identity50 envBound50
  · rw [envTrans50_51]; exact envBound51
  · rw [envTrans50_51]; exact ref51

theorem ref49 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env49 := by
  apply H12AffineState.Refutes.eliminate env49 3 0 (by decide) [1,5] selectedBound49 identity49 envBound49
  · rw [envTrans49_50]; exact envBound50
  · rw [envTrans49_50]; exact ref50

theorem ref48 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env48 := by
  apply H12AffineState.Refutes.eliminate env48 4 10 (by decide) [0,4] selectedBound48 identity48 envBound48
  · rw [envTrans48_49]; exact envBound49
  · rw [envTrans48_49]; exact ref49

theorem ref47 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env47 := by
  apply H12AffineState.Refutes.eliminate env47 13 4113 (by decide) [6] selectedBound47 identity47 envBound47
  · rw [envTrans47_48]; exact envBound48
  · rw [envTrans47_48]; exact ref48

theorem ref46 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env46 := by
  apply H12AffineState.Refutes.eliminate env46 5 16 (by decide) [1,3] selectedBound46 identity46 envBound46
  · rw [envTrans46_47]; exact envBound47
  · rw [envTrans46_47]; exact ref47

theorem ref45 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env45 := by
  apply H12AffineState.Refutes.eliminate env45 14 0 (by decide) [0,2,4,7,9] selectedBound45 identity45 envBound45
  · rw [envTrans45_46]; exact envBound46
  · rw [envTrans45_46]; exact ref46

theorem ref44 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env44 := by
  apply H12AffineState.Refutes.eliminate env44 17 34848 (by decide) [2,4,6,9,11] selectedBound44 identity44 envBound44
  · rw [envTrans44_45]; exact envBound45
  · rw [envTrans44_45]; exact ref45

theorem ref43 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env43 := by
  apply H12AffineState.Refutes.eliminate env43 6 40 (by decide) [13] selectedBound43 identity43 envBound43
  · rw [envTrans43_44]; exact envBound44
  · rw [envTrans43_44]; exact ref44

theorem ref42 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env42 := by
  apply H12AffineState.Refutes.eliminate env42 16 4264 (by decide) [2,13,14] selectedBound42 identity42 envBound42
  · rw [envTrans42_43]; exact envBound43
  · rw [envTrans42_43]; exact ref43

theorem ref41 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env41 := by
  apply H12AffineState.Refutes.eliminate env41 15 32802 (by decide) [2,9,11,13,17,18,22] selectedBound41 identity41 envBound41
  · rw [envTrans41_42]; exact envBound42
  · rw [envTrans41_42]; exact ref42

theorem ref40 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env40 := by
  apply H12AffineState.Refutes.eliminate env40 22 180393 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound40 identity40 envBound40
  · rw [envTrans40_41]; exact envBound41
  · rw [envTrans40_41]; exact ref41

theorem ref39 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env39 := by
  apply H12AffineState.Refutes.eliminate env39 12 8 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound39 identity39 envBound39
  · rw [envTrans39_40]; exact envBound40
  · rw [envTrans39_40]; exact ref40

theorem ref68 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env68 :=
  .terminal _ (H12AffineState.leaf_sound env68 rootObs leafEnv68 active68 tree68 rootObsBound treeGood68 leafIdentity68 terminalChecked68)

theorem ref67 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env67 := by
  apply H12AffineState.Refutes.eliminate env67 8 4 (by decide) [1] selectedBound67 identity67 envBound67
  · rw [envTrans67_68]; exact envBound68
  · rw [envTrans67_68]; exact ref68

theorem ref66 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env66 := by
  apply H12AffineState.Refutes.eliminate env66 10 2 (by decide) [0] selectedBound66 identity66 envBound66
  · rw [envTrans66_67]; exact envBound67
  · rw [envTrans66_67]; exact ref67

end H12AffineCanonicalPilot