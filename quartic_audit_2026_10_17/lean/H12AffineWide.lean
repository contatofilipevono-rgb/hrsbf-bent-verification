import H12AffineWideData011

namespace H12AffineWide

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

theorem ref65 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env65 := by
  apply H12AffineState.Refutes.eliminate env65 2 2 (by decide) [0,7] selectedBound65 identity65 envBound65
  · rw [envTrans65_66]; exact envBound66
  · rw [envTrans65_66]; exact ref66

theorem ref64 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env64 := by
  apply H12AffineState.Refutes.eliminate env64 3 1 (by decide) [1,5] selectedBound64 identity64 envBound64
  · rw [envTrans64_65]; exact envBound65
  · rw [envTrans64_65]; exact ref65

theorem ref63 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env63 := by
  apply H12AffineState.Refutes.eliminate env63 4 10 (by decide) [0,4] selectedBound63 identity63 envBound63
  · rw [envTrans63_64]; exact envBound64
  · rw [envTrans63_64]; exact ref64

theorem ref62 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env62 := by
  apply H12AffineState.Refutes.eliminate env62 13 4112 (by decide) [2] selectedBound62 identity62 envBound62
  · rw [envTrans62_63]; exact envBound63
  · rw [envTrans62_63]; exact ref63

theorem ref61 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env61 := by
  apply H12AffineState.Refutes.eliminate env61 5 16 (by decide) [1,3] selectedBound61 identity61 envBound61
  · rw [envTrans61_62]; exact envBound62
  · rw [envTrans61_62]; exact ref62

theorem ref60 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env60 := by
  apply H12AffineState.Refutes.eliminate env60 14 0 (by decide) [0,2,4,7,9] selectedBound60 identity60 envBound60
  · rw [envTrans60_61]; exact envBound61
  · rw [envTrans60_61]; exact ref61

theorem ref59 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env59 := by
  apply H12AffineState.Refutes.eliminate env59 17 34848 (by decide) [2,4,6,9,11] selectedBound59 identity59 envBound59
  · rw [envTrans59_60]; exact envBound60
  · rw [envTrans59_60]; exact ref60

theorem ref58 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env58 := by
  apply H12AffineState.Refutes.eliminate env58 6 40 (by decide) [13] selectedBound58 identity58 envBound58
  · rw [envTrans58_59]; exact envBound59
  · rw [envTrans58_59]; exact ref59

theorem ref57 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env57 := by
  apply H12AffineState.Refutes.eliminate env57 16 4265 (by decide) [2,13,14] selectedBound57 identity57 envBound57
  · rw [envTrans57_58]; exact envBound58
  · rw [envTrans57_58]; exact ref58

theorem ref56 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env56 := by
  apply H12AffineState.Refutes.eliminate env56 12 8 (by decide) [2,9,11,13,17,18,22] selectedBound56 identity56 envBound56
  · rw [envTrans56_57]; exact envBound57
  · rw [envTrans56_57]; exact ref57

theorem ref55 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env55 := by
  apply H12AffineState.Refutes.eliminate env55 22 188577 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound55 identity55 envBound55
  · rw [envTrans55_56]; exact envBound56
  · rw [envTrans55_56]; exact ref56

theorem ref54 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env54 := by
  apply H12AffineState.Refutes.eliminate env54 15 41002 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound54 identity54 envBound54
  · rw [envTrans54_55]; exact envBound55
  · rw [envTrans54_55]; exact ref55

theorem ref38 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env38 := by
  apply H12AffineState.Refutes.split env38 9 236 (by decide) envBound38
  · rw [envTrans38_39]; exact envBound39
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, envTrans38_54]; exact envBound54
  · rw [envTrans38_39]; exact ref39
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, envTrans38_54]; exact ref54

theorem ref37 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env37 := by
  apply H12AffineState.Refutes.eliminate env37 20 115870 (by decide) [3,5,10] selectedBound37 identity37 envBound37
  · rw [envTrans37_38]; exact envBound38
  · rw [envTrans37_38]; exact ref38

theorem ref4 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env4 := by
  apply H12AffineState.Refutes.split env4 18 189616 (by decide) envBound4
  · rw [envTrans4_5]; exact envBound5
  · rw [show 189616 ^^^ 1 = 189617 from by decide +kernel, envTrans4_37]; exact envBound37
  · rw [envTrans4_5]; exact ref5
  · rw [show 189616 ^^^ 1 = 189617 from by decide +kernel, envTrans4_37]; exact ref37

theorem ref3 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env3 := by
  apply H12AffineState.Refutes.eliminate env3 21 41088 (by decide) [13,21] selectedBound3 identity3 envBound3
  · rw [envTrans3_4]; exact envBound4
  · rw [envTrans3_4]; exact ref4

theorem ref72 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env72 :=
  .contradiction _ [2,4,6,9,11,14,20,23] (by decide +kernel) (by decide +kernel)

theorem ref71 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env71 := by
  apply H12AffineState.Refutes.eliminate env71 20 17596 (by decide) [3,5,10] selectedBound71 identity71 envBound71
  · rw [envTrans71_72]; exact envBound72
  · rw [envTrans71_72]; exact ref72

theorem ref70 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env70 := by
  apply H12AffineState.Refutes.eliminate env70 15 32802 (by decide) [0,4,7,14,18,22,23,35] selectedBound70 identity70 envBound70
  · rw [envTrans70_71]; exact envBound71
  · rw [envTrans70_71]; exact ref71

theorem ref69 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env69 := by
  apply H12AffineState.Refutes.eliminate env69 21 73890 (by decide) [13,21] selectedBound69 identity69 envBound69
  · rw [envTrans69_70]; exact envBound70
  · rw [envTrans69_70]; exact ref70

theorem ref2 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env2 := by
  apply H12AffineState.Refutes.split env2 34 14815280 (by decide) envBound2
  · rw [envTrans2_3]; exact envBound3
  · rw [show 14815280 ^^^ 1 = 14815281 from by decide +kernel, envTrans2_69]; exact envBound69
  · rw [envTrans2_3]; exact ref3
  · rw [show 14815280 ^^^ 1 = 14815281 from by decide +kernel, envTrans2_69]; exact ref69

theorem ref81 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env81 :=
  .contradiction _ [1,2,3] (by decide +kernel) (by decide +kernel)

theorem ref80 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env80 := by
  apply H12AffineState.Refutes.eliminate env80 17 23589 (by decide) [0,6,7,11] selectedBound80 identity80 envBound80
  · rw [envTrans80_81]; exact envBound81
  · rw [envTrans80_81]; exact ref81

theorem ref79 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env79 := by
  apply H12AffineState.Refutes.eliminate env79 15 34 (by decide) [0,4,7,9,11,12,15,20] selectedBound79 identity79 envBound79
  · rw [envTrans79_80]; exact envBound80
  · rw [envTrans79_80]; exact ref80

theorem ref86 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env86 :=
  .contradiction _ [5,8] (by decide +kernel) (by decide +kernel)

theorem ref85 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env85 := by
  apply H12AffineState.Refutes.eliminate env85 18 20 (by decide) [2] selectedBound85 identity85 envBound85
  · rw [envTrans85_86]; exact envBound86
  · rw [envTrans85_86]; exact ref86

theorem ref84 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env84 := by
  apply H12AffineState.Refutes.eliminate env84 13 5292 (by decide) [2,6] selectedBound84 identity84 envBound84
  · rw [envTrans84_85]; exact envBound85
  · rw [envTrans84_85]; exact ref85

theorem ref83 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env83 := by
  apply H12AffineState.Refutes.eliminate env83 15 35 (by decide) [2,14] selectedBound83 identity83 envBound83
  · rw [envTrans83_84]; exact envBound84
  · rw [envTrans83_84]; exact ref84

theorem ref82 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env82 := by
  apply H12AffineState.Refutes.eliminate env82 12 161 (by decide) [13] selectedBound82 identity82 envBound82
  · rw [envTrans82_83]; exact envBound83
  · rw [envTrans82_83]; exact ref83

theorem ref78 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env78 := by
  apply H12AffineState.Refutes.split env78 14 0 (by decide) envBound78
  · rw [envTrans78_79]; exact envBound79
  · rw [show 0 ^^^ 1 = 1 from by decide +kernel, envTrans78_82]; exact envBound82
  · rw [envTrans78_79]; exact ref79
  · rw [show 0 ^^^ 1 = 1 from by decide +kernel, envTrans78_82]; exact ref82

theorem ref77 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env77 := by
  apply H12AffineState.Refutes.eliminate env77 34 103566 (by decide) [0,2,4,6,7,9,11,14,23] selectedBound77 identity77 envBound77
  · rw [envTrans77_78]; exact envBound78
  · rw [envTrans77_78]; exact ref78

theorem ref76 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env76 := by
  apply H12AffineState.Refutes.eliminate env76 22 525328 (by decide) [2,11,14,18] selectedBound76 identity76 envBound76
  · rw [envTrans76_77]; exact envBound77
  · rw [envTrans76_77]; exact ref77

theorem ref75 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env75 := by
  apply H12AffineState.Refutes.eliminate env75 16 5357 (by decide) [3,5,10] selectedBound75 identity75 envBound75
  · rw [envTrans75_76]; exact envBound76
  · rw [envTrans75_76]; exact ref76

theorem ref96 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env96 :=
  .contradiction _ [2] (by decide +kernel) (by decide +kernel)

theorem ref95 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env95 := by
  apply H12AffineState.Refutes.eliminate env95 34 5204 (by decide) [0,2,7,23] selectedBound95 identity95 envBound95
  · rw [envTrans95_96]; exact envBound96
  · rw [envTrans95_96]; exact ref96

theorem ref94 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env94 := by
  apply H12AffineState.Refutes.eliminate env94 6 121 (by decide) [1,3] selectedBound94 identity94 envBound94
  · rw [envTrans94_95]; exact envBound95
  · rw [envTrans94_95]; exact ref95

theorem ref93 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env93 := by
  apply H12AffineState.Refutes.eliminate env93 17 2184 (by decide) [0,2,4,7,9] selectedBound93 identity93 envBound93
  · rw [envTrans93_94]; exact envBound94
  · rw [envTrans93_94]; exact ref94

theorem ref92 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env92 := by
  apply H12AffineState.Refutes.eliminate env92 12 160 (by decide) [2,6] selectedBound92 identity92 envBound92
  · rw [envTrans92_93]; exact envBound93
  · rw [envTrans92_93]; exact ref93

theorem ref91 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env91 := by
  apply H12AffineState.Refutes.eliminate env91 13 5292 (by decide) [12,15] selectedBound91 identity91 envBound91
  · rw [envTrans91_92]; exact envBound92
  · rw [envTrans91_92]; exact ref92

theorem ref90 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env90 := by
  apply H12AffineState.Refutes.eliminate env90 15 29742 (by decide) [0,6,7,14,20] selectedBound90 identity90 envBound90
  · rw [envTrans90_91]; exact envBound91
  · rw [envTrans90_91]; exact ref91

theorem ref101 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env101 :=
  .contradiction _ [0,2,7,11] (by decide +kernel) (by decide +kernel)

theorem ref100 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env100 := by
  apply H12AffineState.Refutes.eliminate env100 17 23589 (by decide) [0,4,6,7,9,13] selectedBound100 identity100 envBound100
  · rw [envTrans100_101]; exact envBound101
  · rw [envTrans100_101]; exact ref101

theorem ref99 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env99 := by
  apply H12AffineState.Refutes.eliminate env99 15 35 (by decide) [0,2,4,6,7,9,13,14] selectedBound99 identity99 envBound99
  · rw [envTrans99_100]; exact envBound100
  · rw [envTrans99_100]; exact ref100

theorem ref98 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env98 := by
  apply H12AffineState.Refutes.eliminate env98 18 273529 (by decide) [21] selectedBound98 identity98 envBound98
  · rw [envTrans98_99]; exact envBound99
  · rw [envTrans98_99]; exact ref99

theorem ref97 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env97 := by
  apply H12AffineState.Refutes.eliminate env97 34 602239 (by decide) [0,6,7,14,20] selectedBound97 identity97 envBound97
  · rw [envTrans97_98]; exact envBound98
  · rw [envTrans97_98]; exact ref98

theorem ref89 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env89 := by
  apply H12AffineState.Refutes.split env89 22 525328 (by decide) envBound89
  · rw [envTrans89_90]; exact envBound90
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, envTrans89_97]; exact envBound97
  · rw [envTrans89_90]; exact ref90
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, envTrans89_97]; exact ref97

theorem ref107 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env107 :=
  .contradiction _ [1,2,3] (by decide +kernel) (by decide +kernel)

theorem ref106 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env106 := by
  apply H12AffineState.Refutes.eliminate env106 17 23588 (by decide) [0,2,7,11] selectedBound106 identity106 envBound106
  · rw [envTrans106_107]; exact envBound107
  · rw [envTrans106_107]; exact ref107

theorem ref105 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env105 := by
  apply H12AffineState.Refutes.eliminate env105 15 34 (by decide) [2,4,6,9,11,12,15] selectedBound105 identity105 envBound105
  · rw [envTrans105_106]; exact envBound106
  · rw [envTrans105_106]; exact ref106

theorem ref104 : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env104 := by
  apply H12AffineState.Refutes.eliminate env104 12 161 (by decide) [13] selectedBound104 identity104 envBound104
  · rw [envTrans104_105]; exact envBound105
  · rw [envTrans104_105]; exact ref105

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

theorem rejected (f : Nat → Bool) (hm : packedModels f rootPS) : ¬H12CertificateBridge.Target (packedObservation f rootObs) :=
  H12AffineState.reject_identity H12CertificateBridge.Target rootPS rootObs ref0 f hm

#print axioms rejected

end H12AffineWide