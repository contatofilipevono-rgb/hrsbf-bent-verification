import H12MixedWideData017

namespace H12MixedWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref21 : PackedRefutes H12CertificateBridge.Target ps21 env21 :=
  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env21 active21 tree21 treeGood21 terminalChecked21)

theorem ref20 : PackedRefutes H12CertificateBridge.Target ps20 env20 := by
  apply PackedRefutes.eliminate ps20 env20 1 0 (by decide) [1] selectedBound20 identity20 psBound20 envBound20
  rw [psTrans20_21, envTrans20_21]; exact ref21

theorem ref19 : PackedRefutes H12CertificateBridge.Target ps19 env19 := by
  apply PackedRefutes.eliminate ps19 env19 11 2050 (by decide) [0] selectedBound19 identity19 psBound19 envBound19
  rw [psTrans19_20, envTrans19_20]; exact ref20

theorem ref18 : PackedRefutes H12CertificateBridge.Target ps18 env18 := by
  apply PackedRefutes.eliminate ps18 env18 2 2 (by decide) [0,7] selectedBound18 identity18 psBound18 envBound18
  rw [psTrans18_19, envTrans18_19]; exact ref19

theorem ref17 : PackedRefutes H12CertificateBridge.Target ps17 env17 := by
  apply PackedRefutes.eliminate ps17 env17 3 0 (by decide) [1,5] selectedBound17 identity17 psBound17 envBound17
  rw [psTrans17_18, envTrans17_18]; exact ref18

theorem ref16 : PackedRefutes H12CertificateBridge.Target ps16 env16 := by
  apply PackedRefutes.eliminate ps16 env16 4 10 (by decide) [0,4] selectedBound16 identity16 psBound16 envBound16
  rw [psTrans16_17, envTrans16_17]; exact ref17

theorem ref15 : PackedRefutes H12CertificateBridge.Target ps15 env15 := by
  apply PackedRefutes.eliminate ps15 env15 13 4112 (by decide) [6] selectedBound15 identity15 psBound15 envBound15
  rw [psTrans15_16, envTrans15_16]; exact ref16

theorem ref14 : PackedRefutes H12CertificateBridge.Target ps14 env14 := by
  apply PackedRefutes.eliminate ps14 env14 5 16 (by decide) [1,3] selectedBound14 identity14 psBound14 envBound14
  rw [psTrans14_15, envTrans14_15]; exact ref15

theorem ref13 : PackedRefutes H12CertificateBridge.Target ps13 env13 := by
  apply PackedRefutes.eliminate ps13 env13 14 0 (by decide) [0,2,4,7,9] selectedBound13 identity13 psBound13 envBound13
  rw [psTrans13_14, envTrans13_14]; exact ref14

theorem ref12 : PackedRefutes H12CertificateBridge.Target ps12 env12 := by
  apply PackedRefutes.eliminate ps12 env12 17 34848 (by decide) [2,4,6,9,11] selectedBound12 identity12 psBound12 envBound12
  rw [psTrans12_13, envTrans12_13]; exact ref13

theorem ref11 : PackedRefutes H12CertificateBridge.Target ps11 env11 := by
  apply PackedRefutes.eliminate ps11 env11 6 40 (by decide) [13] selectedBound11 identity11 psBound11 envBound11
  rw [psTrans11_12, envTrans11_12]; exact ref12

theorem ref10 : PackedRefutes H12CertificateBridge.Target ps10 env10 := by
  apply PackedRefutes.eliminate ps10 env10 16 4264 (by decide) [2,13,14] selectedBound10 identity10 psBound10 envBound10
  rw [psTrans10_11, envTrans10_11]; exact ref11

theorem ref9 : PackedRefutes H12CertificateBridge.Target ps9 env9 := by
  apply PackedRefutes.eliminate ps9 env9 15 32802 (by decide) [2,9,11,13,17,18,22] selectedBound9 identity9 psBound9 envBound9
  rw [psTrans9_10, envTrans9_10]; exact ref10

theorem ref8 : PackedRefutes H12CertificateBridge.Target ps8 env8 := by
  apply PackedRefutes.eliminate ps8 env8 12 8 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound8 identity8 psBound8 envBound8
  rw [psTrans8_9, envTrans8_9]; exact ref9

theorem ref7 : PackedRefutes H12CertificateBridge.Target ps7 env7 := by
  apply PackedRefutes.eliminate ps7 env7 22 180392 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound7 identity7 psBound7 envBound7
  rw [psTrans7_8, envTrans7_8]; exact ref8

theorem ref36 : PackedRefutes H12CertificateBridge.Target ps36 env36 :=
  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env36 active36 tree36 treeGood36 terminalChecked36)

theorem ref35 : PackedRefutes H12CertificateBridge.Target ps35 env35 := by
  apply PackedRefutes.eliminate ps35 env35 8 4 (by decide) [1] selectedBound35 identity35 psBound35 envBound35
  rw [psTrans35_36, envTrans35_36]; exact ref36

theorem ref34 : PackedRefutes H12CertificateBridge.Target ps34 env34 := by
  apply PackedRefutes.eliminate ps34 env34 10 3 (by decide) [0] selectedBound34 identity34 psBound34 envBound34
  rw [psTrans34_35, envTrans34_35]; exact ref35

theorem ref33 : PackedRefutes H12CertificateBridge.Target ps33 env33 := by
  apply PackedRefutes.eliminate ps33 env33 2 2 (by decide) [0,7] selectedBound33 identity33 psBound33 envBound33
  rw [psTrans33_34, envTrans33_34]; exact ref34

theorem ref32 : PackedRefutes H12CertificateBridge.Target ps32 env32 := by
  apply PackedRefutes.eliminate ps32 env32 3 1 (by decide) [1,5] selectedBound32 identity32 psBound32 envBound32
  rw [psTrans32_33, envTrans32_33]; exact ref33

theorem ref31 : PackedRefutes H12CertificateBridge.Target ps31 env31 := by
  apply PackedRefutes.eliminate ps31 env31 4 10 (by decide) [0,4] selectedBound31 identity31 psBound31 envBound31
  rw [psTrans31_32, envTrans31_32]; exact ref32

theorem ref30 : PackedRefutes H12CertificateBridge.Target ps30 env30 := by
  apply PackedRefutes.eliminate ps30 env30 13 4113 (by decide) [2] selectedBound30 identity30 psBound30 envBound30
  rw [psTrans30_31, envTrans30_31]; exact ref31

theorem ref29 : PackedRefutes H12CertificateBridge.Target ps29 env29 := by
  apply PackedRefutes.eliminate ps29 env29 5 16 (by decide) [1,3] selectedBound29 identity29 psBound29 envBound29
  rw [psTrans29_30, envTrans29_30]; exact ref30

theorem ref28 : PackedRefutes H12CertificateBridge.Target ps28 env28 := by
  apply PackedRefutes.eliminate ps28 env28 14 0 (by decide) [0,2,4,7,9] selectedBound28 identity28 psBound28 envBound28
  rw [psTrans28_29, envTrans28_29]; exact ref29

theorem ref27 : PackedRefutes H12CertificateBridge.Target ps27 env27 := by
  apply PackedRefutes.eliminate ps27 env27 17 34848 (by decide) [2,4,6,9,11] selectedBound27 identity27 psBound27 envBound27
  rw [psTrans27_28, envTrans27_28]; exact ref28

theorem ref26 : PackedRefutes H12CertificateBridge.Target ps26 env26 := by
  apply PackedRefutes.eliminate ps26 env26 6 40 (by decide) [13] selectedBound26 identity26 psBound26 envBound26
  rw [psTrans26_27, envTrans26_27]; exact ref27

theorem ref25 : PackedRefutes H12CertificateBridge.Target ps25 env25 := by
  apply PackedRefutes.eliminate ps25 env25 16 4265 (by decide) [2,13,14] selectedBound25 identity25 psBound25 envBound25
  rw [psTrans25_26, envTrans25_26]; exact ref26

theorem ref24 : PackedRefutes H12CertificateBridge.Target ps24 env24 := by
  apply PackedRefutes.eliminate ps24 env24 12 8 (by decide) [2,9,11,13,17,18,22] selectedBound24 identity24 psBound24 envBound24
  rw [psTrans24_25, envTrans24_25]; exact ref25

theorem ref23 : PackedRefutes H12CertificateBridge.Target ps23 env23 := by
  apply PackedRefutes.eliminate ps23 env23 15 41002 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound23 identity23 psBound23 envBound23
  rw [psTrans23_24, envTrans23_24]; exact ref24

theorem ref22 : PackedRefutes H12CertificateBridge.Target ps22 env22 := by
  apply PackedRefutes.eliminate ps22 env22 22 213130 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound22 identity22 psBound22 envBound22
  rw [psTrans22_23, envTrans22_23]; exact ref23

theorem ref6 : PackedRefutes H12CertificateBridge.Target ps6 env6 := by
  apply PackedRefutes.split ps6 env6 9 236 (by decide) psBound6 envBound6
  · rw [psTrans6_7, envTrans6_7]; exact ref7
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, psTrans6_22, envTrans6_22]; exact ref22

theorem ref5 : PackedRefutes H12CertificateBridge.Target ps5 env5 := by
  apply PackedRefutes.eliminate ps5 env5 20 17596 (by decide) [3,5,10] selectedBound5 identity5 psBound5 envBound5
  rw [psTrans5_6, envTrans5_6]; exact ref6

theorem ref53 : PackedRefutes H12CertificateBridge.Target ps53 env53 :=
  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env53 active53 tree53 treeGood53 terminalChecked53)

theorem ref52 : PackedRefutes H12CertificateBridge.Target ps52 env52 := by
  apply PackedRefutes.eliminate ps52 env52 1 0 (by decide) [1] selectedBound52 identity52 psBound52 envBound52
  rw [psTrans52_53, envTrans52_53]; exact ref53

theorem ref51 : PackedRefutes H12CertificateBridge.Target ps51 env51 := by
  apply PackedRefutes.eliminate ps51 env51 11 2051 (by decide) [0] selectedBound51 identity51 psBound51 envBound51
  rw [psTrans51_52, envTrans51_52]; exact ref52

theorem ref50 : PackedRefutes H12CertificateBridge.Target ps50 env50 := by
  apply PackedRefutes.eliminate ps50 env50 2 2 (by decide) [0,7] selectedBound50 identity50 psBound50 envBound50
  rw [psTrans50_51, envTrans50_51]; exact ref51

theorem ref49 : PackedRefutes H12CertificateBridge.Target ps49 env49 := by
  apply PackedRefutes.eliminate ps49 env49 3 0 (by decide) [1,5] selectedBound49 identity49 psBound49 envBound49
  rw [psTrans49_50, envTrans49_50]; exact ref50

theorem ref48 : PackedRefutes H12CertificateBridge.Target ps48 env48 := by
  apply PackedRefutes.eliminate ps48 env48 4 10 (by decide) [0,4] selectedBound48 identity48 psBound48 envBound48
  rw [psTrans48_49, envTrans48_49]; exact ref49

theorem ref47 : PackedRefutes H12CertificateBridge.Target ps47 env47 := by
  apply PackedRefutes.eliminate ps47 env47 13 4113 (by decide) [6] selectedBound47 identity47 psBound47 envBound47
  rw [psTrans47_48, envTrans47_48]; exact ref48

theorem ref46 : PackedRefutes H12CertificateBridge.Target ps46 env46 := by
  apply PackedRefutes.eliminate ps46 env46 5 16 (by decide) [1,3] selectedBound46 identity46 psBound46 envBound46
  rw [psTrans46_47, envTrans46_47]; exact ref47

theorem ref45 : PackedRefutes H12CertificateBridge.Target ps45 env45 := by
  apply PackedRefutes.eliminate ps45 env45 14 0 (by decide) [0,2,4,7,9] selectedBound45 identity45 psBound45 envBound45
  rw [psTrans45_46, envTrans45_46]; exact ref46

theorem ref44 : PackedRefutes H12CertificateBridge.Target ps44 env44 := by
  apply PackedRefutes.eliminate ps44 env44 17 34848 (by decide) [2,4,6,9,11] selectedBound44 identity44 psBound44 envBound44
  rw [psTrans44_45, envTrans44_45]; exact ref45

theorem ref43 : PackedRefutes H12CertificateBridge.Target ps43 env43 := by
  apply PackedRefutes.eliminate ps43 env43 6 40 (by decide) [13] selectedBound43 identity43 psBound43 envBound43
  rw [psTrans43_44, envTrans43_44]; exact ref44

theorem ref42 : PackedRefutes H12CertificateBridge.Target ps42 env42 := by
  apply PackedRefutes.eliminate ps42 env42 16 4264 (by decide) [2,13,14] selectedBound42 identity42 psBound42 envBound42
  rw [psTrans42_43, envTrans42_43]; exact ref43

theorem ref41 : PackedRefutes H12CertificateBridge.Target ps41 env41 := by
  apply PackedRefutes.eliminate ps41 env41 15 32802 (by decide) [2,9,11,13,17,18,22] selectedBound41 identity41 psBound41 envBound41
  rw [psTrans41_42, envTrans41_42]; exact ref42

theorem ref40 : PackedRefutes H12CertificateBridge.Target ps40 env40 := by
  apply PackedRefutes.eliminate ps40 env40 22 180393 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound40 identity40 psBound40 envBound40
  rw [psTrans40_41, envTrans40_41]; exact ref41

theorem ref39 : PackedRefutes H12CertificateBridge.Target ps39 env39 := by
  apply PackedRefutes.eliminate ps39 env39 12 8 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound39 identity39 psBound39 envBound39
  rw [psTrans39_40, envTrans39_40]; exact ref40

theorem ref68 : PackedRefutes H12CertificateBridge.Target ps68 env68 :=
  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env68 active68 tree68 treeGood68 terminalChecked68)

theorem ref67 : PackedRefutes H12CertificateBridge.Target ps67 env67 := by
  apply PackedRefutes.eliminate ps67 env67 8 4 (by decide) [1] selectedBound67 identity67 psBound67 envBound67
  rw [psTrans67_68, envTrans67_68]; exact ref68

theorem ref66 : PackedRefutes H12CertificateBridge.Target ps66 env66 := by
  apply PackedRefutes.eliminate ps66 env66 10 2 (by decide) [0] selectedBound66 identity66 psBound66 envBound66
  rw [psTrans66_67, envTrans66_67]; exact ref67

theorem ref65 : PackedRefutes H12CertificateBridge.Target ps65 env65 := by
  apply PackedRefutes.eliminate ps65 env65 2 2 (by decide) [0,7] selectedBound65 identity65 psBound65 envBound65
  rw [psTrans65_66, envTrans65_66]; exact ref66

theorem ref64 : PackedRefutes H12CertificateBridge.Target ps64 env64 := by
  apply PackedRefutes.eliminate ps64 env64 3 1 (by decide) [1,5] selectedBound64 identity64 psBound64 envBound64
  rw [psTrans64_65, envTrans64_65]; exact ref65

theorem ref63 : PackedRefutes H12CertificateBridge.Target ps63 env63 := by
  apply PackedRefutes.eliminate ps63 env63 4 10 (by decide) [0,4] selectedBound63 identity63 psBound63 envBound63
  rw [psTrans63_64, envTrans63_64]; exact ref64

theorem ref62 : PackedRefutes H12CertificateBridge.Target ps62 env62 := by
  apply PackedRefutes.eliminate ps62 env62 13 4112 (by decide) [2] selectedBound62 identity62 psBound62 envBound62
  rw [psTrans62_63, envTrans62_63]; exact ref63

theorem ref61 : PackedRefutes H12CertificateBridge.Target ps61 env61 := by
  apply PackedRefutes.eliminate ps61 env61 5 16 (by decide) [1,3] selectedBound61 identity61 psBound61 envBound61
  rw [psTrans61_62, envTrans61_62]; exact ref62

theorem ref60 : PackedRefutes H12CertificateBridge.Target ps60 env60 := by
  apply PackedRefutes.eliminate ps60 env60 14 0 (by decide) [0,2,4,7,9] selectedBound60 identity60 psBound60 envBound60
  rw [psTrans60_61, envTrans60_61]; exact ref61

theorem ref59 : PackedRefutes H12CertificateBridge.Target ps59 env59 := by
  apply PackedRefutes.eliminate ps59 env59 17 34848 (by decide) [2,4,6,9,11] selectedBound59 identity59 psBound59 envBound59
  rw [psTrans59_60, envTrans59_60]; exact ref60

theorem ref58 : PackedRefutes H12CertificateBridge.Target ps58 env58 := by
  apply PackedRefutes.eliminate ps58 env58 6 40 (by decide) [13] selectedBound58 identity58 psBound58 envBound58
  rw [psTrans58_59, envTrans58_59]; exact ref59

theorem ref57 : PackedRefutes H12CertificateBridge.Target ps57 env57 := by
  apply PackedRefutes.eliminate ps57 env57 16 4265 (by decide) [2,13,14] selectedBound57 identity57 psBound57 envBound57
  rw [psTrans57_58, envTrans57_58]; exact ref58

theorem ref56 : PackedRefutes H12CertificateBridge.Target ps56 env56 := by
  apply PackedRefutes.eliminate ps56 env56 12 8 (by decide) [2,9,11,13,17,18,22] selectedBound56 identity56 psBound56 envBound56
  rw [psTrans56_57, envTrans56_57]; exact ref57

theorem ref55 : PackedRefutes H12CertificateBridge.Target ps55 env55 := by
  apply PackedRefutes.eliminate ps55 env55 22 188577 (by decide) [0,2,6,9,11,13,17,18,22,27] selectedBound55 identity55 psBound55 envBound55
  rw [psTrans55_56, envTrans55_56]; exact ref56

theorem ref54 : PackedRefutes H12CertificateBridge.Target ps54 env54 := by
  apply PackedRefutes.eliminate ps54 env54 15 41002 (by decide) [0,2,7,11,13,14,17,18,20] selectedBound54 identity54 psBound54 envBound54
  rw [psTrans54_55, envTrans54_55]; exact ref55

theorem ref38 : PackedRefutes H12CertificateBridge.Target ps38 env38 := by
  apply PackedRefutes.split ps38 env38 9 236 (by decide) psBound38 envBound38
  · rw [psTrans38_39, envTrans38_39]; exact ref39
  · rw [show 236 ^^^ 1 = 237 from by decide +kernel, psTrans38_54, envTrans38_54]; exact ref54

theorem ref37 : PackedRefutes H12CertificateBridge.Target ps37 env37 := by
  apply PackedRefutes.eliminate ps37 env37 20 115870 (by decide) [3,5,10] selectedBound37 identity37 psBound37 envBound37
  rw [psTrans37_38, envTrans37_38]; exact ref38

theorem ref4 : PackedRefutes H12CertificateBridge.Target ps4 env4 := by
  apply PackedRefutes.split ps4 env4 18 189616 (by decide) psBound4 envBound4
  · rw [psTrans4_5, envTrans4_5]; exact ref5
  · rw [show 189616 ^^^ 1 = 189617 from by decide +kernel, psTrans4_37, envTrans4_37]; exact ref37

theorem ref3 : PackedRefutes H12CertificateBridge.Target ps3 env3 := by
  apply PackedRefutes.eliminate ps3 env3 21 41088 (by decide) [13,21] selectedBound3 identity3 psBound3 envBound3
  rw [psTrans3_4, envTrans3_4]; exact ref4

theorem ref72 : PackedRefutes H12CertificateBridge.Target ps72 env72 :=
  .contradiction _ _ [2,4,6,9,11,14,20,23] (by decide +kernel) (by decide +kernel)

theorem ref71 : PackedRefutes H12CertificateBridge.Target ps71 env71 := by
  apply PackedRefutes.eliminate ps71 env71 20 17596 (by decide) [3,5,10] selectedBound71 identity71 psBound71 envBound71
  rw [psTrans71_72, envTrans71_72]; exact ref72

theorem ref70 : PackedRefutes H12CertificateBridge.Target ps70 env70 := by
  apply PackedRefutes.eliminate ps70 env70 15 32802 (by decide) [0,4,7,14,18,22,23,35] selectedBound70 identity70 psBound70 envBound70
  rw [psTrans70_71, envTrans70_71]; exact ref71

theorem ref69 : PackedRefutes H12CertificateBridge.Target ps69 env69 := by
  apply PackedRefutes.eliminate ps69 env69 21 73890 (by decide) [13,21] selectedBound69 identity69 psBound69 envBound69
  rw [psTrans69_70, envTrans69_70]; exact ref70

theorem ref2 : PackedRefutes H12CertificateBridge.Target ps2 env2 := by
  apply PackedRefutes.split ps2 env2 34 14815280 (by decide) psBound2 envBound2
  · rw [psTrans2_3, envTrans2_3]; exact ref3
  · rw [show 14815280 ^^^ 1 = 14815281 from by decide +kernel, psTrans2_69, envTrans2_69]; exact ref69

theorem ref81 : PackedRefutes H12CertificateBridge.Target ps81 env81 :=
  .contradiction _ _ [1,2,3] (by decide +kernel) (by decide +kernel)

theorem ref80 : PackedRefutes H12CertificateBridge.Target ps80 env80 := by
  apply PackedRefutes.eliminate ps80 env80 17 23589 (by decide) [0,6,7,11] selectedBound80 identity80 psBound80 envBound80
  rw [psTrans80_81, envTrans80_81]; exact ref81

theorem ref79 : PackedRefutes H12CertificateBridge.Target ps79 env79 := by
  apply PackedRefutes.eliminate ps79 env79 15 34 (by decide) [0,4,7,9,11,12,15,20] selectedBound79 identity79 psBound79 envBound79
  rw [psTrans79_80, envTrans79_80]; exact ref80

theorem ref86 : PackedRefutes H12CertificateBridge.Target ps86 env86 :=
  .contradiction _ _ [5,8] (by decide +kernel) (by decide +kernel)

theorem ref85 : PackedRefutes H12CertificateBridge.Target ps85 env85 := by
  apply PackedRefutes.eliminate ps85 env85 18 20 (by decide) [2] selectedBound85 identity85 psBound85 envBound85
  rw [psTrans85_86, envTrans85_86]; exact ref86

theorem ref84 : PackedRefutes H12CertificateBridge.Target ps84 env84 := by
  apply PackedRefutes.eliminate ps84 env84 13 5292 (by decide) [2,6] selectedBound84 identity84 psBound84 envBound84
  rw [psTrans84_85, envTrans84_85]; exact ref85

theorem ref83 : PackedRefutes H12CertificateBridge.Target ps83 env83 := by
  apply PackedRefutes.eliminate ps83 env83 15 35 (by decide) [2,14] selectedBound83 identity83 psBound83 envBound83
  rw [psTrans83_84, envTrans83_84]; exact ref84

theorem ref82 : PackedRefutes H12CertificateBridge.Target ps82 env82 := by
  apply PackedRefutes.eliminate ps82 env82 12 161 (by decide) [13] selectedBound82 identity82 psBound82 envBound82
  rw [psTrans82_83, envTrans82_83]; exact ref83

theorem ref78 : PackedRefutes H12CertificateBridge.Target ps78 env78 := by
  apply PackedRefutes.split ps78 env78 14 0 (by decide) psBound78 envBound78
  · rw [psTrans78_79, envTrans78_79]; exact ref79
  · rw [show 0 ^^^ 1 = 1 from by decide +kernel, psTrans78_82, envTrans78_82]; exact ref82

theorem ref77 : PackedRefutes H12CertificateBridge.Target ps77 env77 := by
  apply PackedRefutes.eliminate ps77 env77 34 103566 (by decide) [0,2,4,6,7,9,11,14,23] selectedBound77 identity77 psBound77 envBound77
  rw [psTrans77_78, envTrans77_78]; exact ref78

theorem ref76 : PackedRefutes H12CertificateBridge.Target ps76 env76 := by
  apply PackedRefutes.eliminate ps76 env76 22 525328 (by decide) [2,11,14,18] selectedBound76 identity76 psBound76 envBound76
  rw [psTrans76_77, envTrans76_77]; exact ref77

theorem ref75 : PackedRefutes H12CertificateBridge.Target ps75 env75 := by
  apply PackedRefutes.eliminate ps75 env75 16 5357 (by decide) [3,5,10] selectedBound75 identity75 psBound75 envBound75
  rw [psTrans75_76, envTrans75_76]; exact ref76

theorem ref96 : PackedRefutes H12CertificateBridge.Target ps96 env96 :=
  .contradiction _ _ [2] (by decide +kernel) (by decide +kernel)

theorem ref95 : PackedRefutes H12CertificateBridge.Target ps95 env95 := by
  apply PackedRefutes.eliminate ps95 env95 34 5204 (by decide) [0,2,7,23] selectedBound95 identity95 psBound95 envBound95
  rw [psTrans95_96, envTrans95_96]; exact ref96

theorem ref94 : PackedRefutes H12CertificateBridge.Target ps94 env94 := by
  apply PackedRefutes.eliminate ps94 env94 6 121 (by decide) [1,3] selectedBound94 identity94 psBound94 envBound94
  rw [psTrans94_95, envTrans94_95]; exact ref95

theorem ref93 : PackedRefutes H12CertificateBridge.Target ps93 env93 := by
  apply PackedRefutes.eliminate ps93 env93 17 2184 (by decide) [0,2,4,7,9] selectedBound93 identity93 psBound93 envBound93
  rw [psTrans93_94, envTrans93_94]; exact ref94

theorem ref92 : PackedRefutes H12CertificateBridge.Target ps92 env92 := by
  apply PackedRefutes.eliminate ps92 env92 12 160 (by decide) [2,6] selectedBound92 identity92 psBound92 envBound92
  rw [psTrans92_93, envTrans92_93]; exact ref93

theorem ref91 : PackedRefutes H12CertificateBridge.Target ps91 env91 := by
  apply PackedRefutes.eliminate ps91 env91 13 5292 (by decide) [12,15] selectedBound91 identity91 psBound91 envBound91
  rw [psTrans91_92, envTrans91_92]; exact ref92

theorem ref90 : PackedRefutes H12CertificateBridge.Target ps90 env90 := by
  apply PackedRefutes.eliminate ps90 env90 15 29742 (by decide) [0,6,7,14,20] selectedBound90 identity90 psBound90 envBound90
  rw [psTrans90_91, envTrans90_91]; exact ref91

theorem ref101 : PackedRefutes H12CertificateBridge.Target ps101 env101 :=
  .contradiction _ _ [0,2,7,11] (by decide +kernel) (by decide +kernel)

theorem ref100 : PackedRefutes H12CertificateBridge.Target ps100 env100 := by
  apply PackedRefutes.eliminate ps100 env100 17 23589 (by decide) [0,4,6,7,9,13] selectedBound100 identity100 psBound100 envBound100
  rw [psTrans100_101, envTrans100_101]; exact ref101

theorem ref99 : PackedRefutes H12CertificateBridge.Target ps99 env99 := by
  apply PackedRefutes.eliminate ps99 env99 15 35 (by decide) [0,2,4,6,7,9,13,14] selectedBound99 identity99 psBound99 envBound99
  rw [psTrans99_100, envTrans99_100]; exact ref100

theorem ref98 : PackedRefutes H12CertificateBridge.Target ps98 env98 := by
  apply PackedRefutes.eliminate ps98 env98 18 273529 (by decide) [21] selectedBound98 identity98 psBound98 envBound98
  rw [psTrans98_99, envTrans98_99]; exact ref99

theorem ref97 : PackedRefutes H12CertificateBridge.Target ps97 env97 := by
  apply PackedRefutes.eliminate ps97 env97 34 602239 (by decide) [0,6,7,14,20] selectedBound97 identity97 psBound97 envBound97
  rw [psTrans97_98, envTrans97_98]; exact ref98

theorem ref89 : PackedRefutes H12CertificateBridge.Target ps89 env89 := by
  apply PackedRefutes.split ps89 env89 22 525328 (by decide) psBound89 envBound89
  · rw [psTrans89_90, envTrans89_90]; exact ref90
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, psTrans89_97, envTrans89_97]; exact ref97

theorem ref107 : PackedRefutes H12CertificateBridge.Target ps107 env107 :=
  .contradiction _ _ [1,2,3] (by decide +kernel) (by decide +kernel)

theorem ref106 : PackedRefutes H12CertificateBridge.Target ps106 env106 := by
  apply PackedRefutes.eliminate ps106 env106 17 23588 (by decide) [0,2,7,11] selectedBound106 identity106 psBound106 envBound106
  rw [psTrans106_107, envTrans106_107]; exact ref107

theorem ref105 : PackedRefutes H12CertificateBridge.Target ps105 env105 := by
  apply PackedRefutes.eliminate ps105 env105 15 34 (by decide) [2,4,6,9,11,12,15] selectedBound105 identity105 psBound105 envBound105
  rw [psTrans105_106, envTrans105_106]; exact ref106

theorem ref104 : PackedRefutes H12CertificateBridge.Target ps104 env104 := by
  apply PackedRefutes.eliminate ps104 env104 12 161 (by decide) [13] selectedBound104 identity104 psBound104 envBound104
  rw [psTrans104_105, envTrans104_105]; exact ref105

theorem ref103 : PackedRefutes H12CertificateBridge.Target ps103 env103 := by
  apply PackedRefutes.eliminate ps103 env103 34 78894 (by decide) [0,6,7,14,20] selectedBound103 identity103 psBound103 envBound103
  rw [psTrans103_104, envTrans103_104]; exact ref104

theorem ref121 : PackedRefutes H12CertificateBridge.Target ps121 env121 :=
  .contradiction _ _ [15] (by decide +kernel) (by decide +kernel)

theorem ref120 : PackedRefutes H12CertificateBridge.Target ps120 env120 := by
  apply PackedRefutes.eliminate ps120 env120 5 12 (by decide) [0,1] selectedBound120 identity120 psBound120 envBound120
  rw [psTrans120_121, envTrans120_121]; exact ref121

theorem ref119 : PackedRefutes H12CertificateBridge.Target ps119 env119 := by
  apply PackedRefutes.eliminate ps119 env119 3 11 (by decide) [1,8] selectedBound119 identity119 psBound119 envBound119
  rw [psTrans119_120, envTrans119_120]; exact ref120

theorem ref118 : PackedRefutes H12CertificateBridge.Target ps118 env118 := by
  apply PackedRefutes.eliminate ps118 env118 6 9 (by decide) [1,5] selectedBound118 identity118 psBound118 envBound118
  rw [psTrans118_119, envTrans118_119]; exact ref119

theorem ref117 : PackedRefutes H12CertificateBridge.Target ps117 env117 := by
  apply PackedRefutes.eliminate ps117 env117 10 147 (by decide) [0,4] selectedBound117 identity117 psBound117 envBound117
  rw [psTrans117_118, envTrans117_118]; exact ref118

theorem ref116 : PackedRefutes H12CertificateBridge.Target ps116 env116 := by
  apply PackedRefutes.eliminate ps116 env116 9 5 (by decide) [2] selectedBound116 identity116 psBound116 envBound116
  rw [psTrans116_117, envTrans116_117]; exact ref117

theorem ref115 : PackedRefutes H12CertificateBridge.Target ps115 env115 := by
  apply PackedRefutes.eliminate ps115 env115 8 32 (by decide) [2,11] selectedBound115 identity115 psBound115 envBound115
  rw [psTrans115_116, envTrans115_116]; exact ref116

theorem ref114 : PackedRefutes H12CertificateBridge.Target ps114 env114 := by
  apply PackedRefutes.eliminate ps114 env114 11 1589 (by decide) [0,7] selectedBound114 identity114 psBound114 envBound114
  rw [psTrans114_115, envTrans114_115]; exact ref115

theorem ref113 : PackedRefutes H12CertificateBridge.Target ps113 env113 := by
  apply PackedRefutes.eliminate ps113 env113 34 5292 (by decide) [0,2,5,7,8,11,12] selectedBound113 identity113 psBound113 envBound113
  rw [psTrans113_114, envTrans113_114]; exact ref114

theorem ref112 : PackedRefutes H12CertificateBridge.Target ps112 env112 := by
  apply PackedRefutes.eliminate ps112 env112 13 5773 (by decide) [2,6] selectedBound112 identity112 psBound112 envBound112
  rw [psTrans112_113, envTrans112_113]; exact ref113

theorem ref111 : PackedRefutes H12CertificateBridge.Target ps111 env111 := by
  apply PackedRefutes.eliminate ps111 env111 12 640 (by decide) [1,3] selectedBound111 identity111 psBound111 envBound111
  rw [psTrans111_112, envTrans111_112]; exact ref112

theorem ref110 : PackedRefutes H12CertificateBridge.Target ps110 env110 := by
  apply PackedRefutes.eliminate ps110 env110 15 8323 (by decide) [0,4,6,7,9] selectedBound110 identity110 psBound110 envBound110
  rw [psTrans110_111, envTrans110_111]; exact ref111

theorem ref109 : PackedRefutes H12CertificateBridge.Target ps109 env109 := by
  apply PackedRefutes.eliminate ps109 env109 17 2185 (by decide) [21] selectedBound109 identity109 psBound109 envBound109
  rw [psTrans109_110, envTrans109_110]; exact ref110

theorem ref108 : PackedRefutes H12CertificateBridge.Target ps108 env108 := by
  apply PackedRefutes.eliminate ps108 env108 18 94334 (by decide) [0,6,7,14,20] selectedBound108 identity108 psBound108 envBound108
  rw [psTrans108_109, envTrans108_109]; exact ref109

theorem ref102 : PackedRefutes H12CertificateBridge.Target ps102 env102 := by
  apply PackedRefutes.split ps102 env102 22 525328 (by decide) psBound102 envBound102
  · rw [psTrans102_103, envTrans102_103]; exact ref103
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, psTrans102_108, envTrans102_108]; exact ref108

theorem ref88 : PackedRefutes H12CertificateBridge.Target ps88 env88 := by
  apply PackedRefutes.split ps88 env88 14 8352 (by decide) psBound88 envBound88
  · rw [psTrans88_89, envTrans88_89]; exact ref89
  · rw [show 8352 ^^^ 1 = 8353 from by decide +kernel, psTrans88_102, envTrans88_102]; exact ref102

theorem ref87 : PackedRefutes H12CertificateBridge.Target ps87 env87 := by
  apply PackedRefutes.eliminate ps87 env87 16 103631 (by decide) [3,5,10] selectedBound87 identity87 psBound87 envBound87
  rw [psTrans87_88, envTrans87_88]; exact ref88

theorem ref74 : PackedRefutes H12CertificateBridge.Target ps74 env74 := by
  apply PackedRefutes.split ps74 env74 20 570592 (by decide) psBound74 envBound74
  · rw [psTrans74_75, envTrans74_75]; exact ref75
  · rw [show 570592 ^^^ 1 = 570593 from by decide +kernel, psTrans74_87, envTrans74_87]; exact ref87

theorem ref73 : PackedRefutes H12CertificateBridge.Target ps73 env73 := by
  apply PackedRefutes.eliminate ps73 env73 21 73891 (by decide) [0,3,7,9,10,13,14,20,21,22,24,26] selectedBound73 identity73 psBound73 envBound73
  rw [psTrans73_74, envTrans73_74]; exact ref74

theorem ref1 : PackedRefutes H12CertificateBridge.Target ps1 env1 := by
  apply PackedRefutes.split ps1 env1 7 252 (by decide) psBound1 envBound1
  · rw [psTrans1_2, envTrans1_2]; exact ref2
  · rw [show 252 ^^^ 1 = 253 from by decide +kernel, psTrans1_73, envTrans1_73]; exact ref73

theorem ref0 : PackedRefutes H12CertificateBridge.Target ps0 env0 := by
  apply PackedRefutes.eliminate ps0 env0 25 566496 (by decide) [1,3,5,8,10,19] selectedBound0 identity0 psBound0 envBound0
  rw [psTrans0_1, envTrans0_1]; exact ref1

theorem rejected (f : Nat → Bool) (hm : packedModels f ps0) : ¬H12CertificateBridge.Target (packedObservation f env0) :=
  packedRefutes_sound H12CertificateBridge.Target _ _ ref0 f hm

#print axioms rejected

end H12MixedWide