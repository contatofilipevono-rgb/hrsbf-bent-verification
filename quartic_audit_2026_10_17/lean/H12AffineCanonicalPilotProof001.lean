import H12AffineCanonicalPilotProof000

namespace H12AffineCanonicalPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

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

end H12AffineCanonicalPilot