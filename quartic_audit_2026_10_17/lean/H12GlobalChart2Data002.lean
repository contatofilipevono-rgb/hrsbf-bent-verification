import H12GlobalChart2Data001

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem identity475 : scanCanonicalize (H12AffineFastState.compose env475 (packedSelected [2,6,7,9] rootPS)) = affineNative (2^(12+1) ^^^ 2317) := by decide +kernel

theorem selectedBound475 : packedSelected [2,6,7,9] rootPS < 2^1333 := by decide +kernel

def env476 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2317,4824,32768,65536,1345,33708,524288,32768,4096,261,6104,98564,2436,5377,33060,4825,1297,2697,1284,4294967296,256,4295591459,1344,513]

theorem envBound476 : H12AffineFastState.Bounded env476 := by
  intro p hp
  have h : env476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans475_476 : H12AffineEnvironment.transform 12 2317 env475 = env476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2317 env475 == env476) = true)

def env477 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,2317,4176,32768,65536,1345,33060,524288,32768,4096,261,5456,98564,2436,5377,33060,4177,1297,2049,1284,4294967296,256,4295591083,1344,137]

theorem envBound477 : H12AffineFastState.Bounded env477 := by
  intro p hp
  have h : env477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans476_477 : H12AffineEnvironment.transform 8 136 env476 = env477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env476 == env477) = true)

theorem identity477 : scanCanonicalize (H12AffineFastState.compose env477 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(18+1) ^^^ 99726) := by decide +kernel

theorem selectedBound477 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env478 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,2317,4176,32768,65536,1345,33060,99726,32768,4096,261,5456,98564,2436,5377,33060,4177,1297,2049,1284,4294967296,256,4294967589,1344,137]

theorem envBound478 : H12AffineFastState.Bounded env478 := by
  intro p hp
  have h : env478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans477_478 : H12AffineEnvironment.transform 18 99726 env477 = env478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 99726 env477 == env478) = true)

theorem identity478 : scanCanonicalize (H12AffineFastState.compose env478 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound478 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env479 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1296,2317,1344,32768,65536,1345,33060,99726,32768,1296,261,64,98564,2436,17,33060,1345,1297,2049,1284,4294967296,256,4294967589,1344,137]

theorem envBound479 : H12AffineFastState.Bounded env479 := by
  intro p hp
  have h : env479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans478_479 : H12AffineEnvironment.transform 11 1296 env478 = env479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env478 == env479) = true)

theorem identity479 : scanCanonicalize (H12AffineFastState.compose env479 (packedSelected [2,3,4,10] rootPS)) = affineNative (2^(14+1) ^^^ 2341) := by decide +kernel

theorem selectedBound479 : packedSelected [2,3,4,10] rootPS < 2^1333 := by decide +kernel

def env480 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1296,2317,1344,2341,65536,1345,2049,68779,2341,1296,261,64,67617,2436,17,2049,1345,1297,2049,1284,4294967296,256,4294967589,1344,137]

theorem envBound480 : H12AffineFastState.Bounded env480 := by
  intro p hp
  have h : env480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans479_480 : H12AffineEnvironment.transform 14 2341 env479 = env480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2341 env479 == env480) = true)

def env481 : List Nat := [2,4,8,16,32,64,120,256,112,1024,2048,1296,2317,1344,2341,65536,1345,2049,68691,2341,1296,261,64,67617,2428,17,2049,1345,1297,2049,1284,4294967296,256,4294967589,1344,113]

theorem envBound481 : H12AffineFastState.Bounded env481 := by
  intro p hp
  have h : env481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans480_481 : H12AffineEnvironment.transform 6 120 env480 = env481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env480 == env481) = true)

theorem identity481 : scanCanonicalize (H12AffineFastState.compose env481 (packedSelected [5] rootPS)) = affineNative (2^(15+1) ^^^ 2423) := by decide +kernel

theorem selectedBound481 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env482 : List Nat := [2,4,8,16,32,64,120,256,112,1024,2048,1296,2317,1344,2341,2423,1345,2049,1316,2341,1296,261,64,342,2428,17,2049,1345,1297,2049,1284,4294967296,256,4294967589,1344,113]

theorem envBound482 : H12AffineFastState.Bounded env482 := by
  intro p hp
  have h : env482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans481_482 : H12AffineEnvironment.transform 15 2423 env481 = env482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2423 env481 == env482) = true)

theorem identity482 : scanCanonicalize (H12AffineFastState.compose env482 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound482 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env483 : List Nat := [2,4,8,16,32,64,120,37,112,1024,2048,1077,2088,1125,2048,2130,1124,2049,1025,2048,1077,32,64,115,2137,17,2049,1124,1076,2049,1057,4294967296,37,4294967296,1125,113]

theorem envBound483 : H12AffineFastState.Bounded env483 := by
  intro p hp
  have h : env483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans482_483 : H12AffineEnvironment.transform 7 37 env482 = env483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env482 == env483) = true)

theorem identity483 : scanCanonicalize (H12AffineFastState.compose env483 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound483 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env484 : List Nat := [2,4,8,16,32,64,120,37,112,1024,2048,1077,2088,1125,2048,2130,1124,2049,1025,2048,1077,32,64,115,2137,17,2049,1124,1076,2049,1057,42,37,42,1125,113]

theorem envBound484 : H12AffineFastState.Bounded env484 := by
  intro p hp
  have h : env484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans483_484 : H12AffineEnvironment.transform 31 42 env483 = env484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env483 == env484) = true)

theorem identity484 : scanCanonicalize (H12AffineFastState.compose env484 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound484 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env485 : List Nat := [2,4,8,16,32,10,50,37,58,1024,2048,1077,2088,1071,2048,2072,1070,2049,1025,2048,1077,32,10,57,2067,17,2049,1070,1076,2049,1057,42,37,42,1071,59]

theorem envBound485 : H12AffineFastState.Bounded env485 := by
  intro p hp
  have h : env485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans484_485 : H12AffineEnvironment.transform 5 10 env484 = env485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env484 == env485) = true)

def leafEnv485 : List Nat := [2,4,8,16,32,10,50,37,58,1024,2048,1077,2088,1071,2048,2072,1070,2049,1025,2048,1077,32,10,57,1056,2067,1,17,2049,1070,1076,2049,1057,42,37,42,4,2082,1071,59,0,1076,1]

def active485 : List Nat := [0,1,2,3,4,9,10]

def tree485 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood485 : H12WitnessSearch.Good tree485 := H12GlobalWitnessIndex.good

theorem leafIdentity485 : H12AffineFastState.composeSystem env485 rootObs = leafEnv485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env485 rootObs == leafEnv485) = true)

theorem terminalChecked485 : H12PackedTerminal.terminalCheckFast leafEnv485 active485 tree485 = true := by decide +kernel

def env486 : List Nat := [2,4,8,16,32,64,121,256,113,1024,2048,1296,2317,1344,2341,65536,1345,2049,68690,2341,1296,261,64,67617,2429,17,2049,1345,1297,2049,1284,4294967296,256,4294967589,1344,112]

theorem envBound486 : H12AffineFastState.Bounded env486 := by
  intro p hp
  have h : env486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans480_486 : H12AffineEnvironment.transform 6 121 env480 = env486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env480 == env486) = true)

theorem identity486 : scanCanonicalize (H12AffineFastState.compose env486 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound486 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env487 : List Nat := [2,4,8,16,32,64,121,37,113,1024,2048,1077,2088,1125,2048,65536,1124,2049,68690,2048,1077,32,64,67617,2136,17,2049,1124,1076,2049,1057,4294967296,37,4294967296,1125,112]

theorem envBound487 : H12AffineFastState.Bounded env487 := by
  intro p hp
  have h : env487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans486_487 : H12AffineEnvironment.transform 7 37 env486 = env487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env486 == env487) = true)

theorem identity487 : scanCanonicalize (H12AffineFastState.compose env487 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 96) := by decide +kernel

theorem selectedBound487 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env488 : List Nat := [2,4,8,16,32,64,121,37,113,1024,2048,1077,2088,1125,2048,65536,1124,2049,68690,2048,1077,32,64,67617,2136,17,2049,1124,1076,2049,1057,96,37,96,1125,112]

theorem envBound488 : H12AffineFastState.Bounded env488 := by
  intro p hp
  have h : env488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans487_488 : H12AffineEnvironment.transform 31 96 env487 = env488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 96 env487 == env488) = true)

def env489 : List Nat := [2,4,8,16,32,64,121,37,113,1024,0,1077,40,1125,0,65536,1124,1,66642,0,1077,32,64,65569,88,17,1,1124,1076,1,1057,96,37,96,1125,112]

theorem envBound489 : H12AffineFastState.Bounded env489 := by
  intro p hp
  have h : env489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans488_489 : H12AffineEnvironment.transform 10 0 env488 = env489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env488 == env489) = true)

theorem identity489 : scanCanonicalize (H12AffineFastState.compose env489 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 25) := by decide +kernel

theorem selectedBound489 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env490 : List Nat := [2,4,8,16,32,64,121,37,113,1024,0,1077,40,1125,0,25,1124,1,1099,0,1077,32,64,56,88,17,1,1124,1076,1,1057,96,37,96,1125,112]

theorem envBound490 : H12AffineFastState.Bounded env490 := by
  intro p hp
  have h : env490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans489_490 : H12AffineEnvironment.transform 15 25 env489 = env490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env489 == env490) = true)

def env491 : List Nat := [2,4,8,16,0,64,89,5,81,1024,0,1045,8,1093,0,25,1092,1,1099,0,1045,0,64,24,88,17,1,1092,1044,1,1025,64,5,64,1093,80]

theorem envBound491 : H12AffineFastState.Bounded env491 := by
  intro p hp
  have h : env491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans490_491 : H12AffineEnvironment.transform 4 0 env490 = env491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env490 == env491) = true)

theorem identity491 : scanCanonicalize (H12AffineFastState.compose env491 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound491 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env492 : List Nat := [2,4,8,16,0,10,19,5,27,1024,0,1045,8,1039,0,25,1038,1,1025,0,1045,0,10,24,18,17,1,1038,1044,1,1025,10,5,10,1039,26]

theorem envBound492 : H12AffineFastState.Bounded env492 := by
  intro p hp
  have h : env492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans491_492 : H12AffineEnvironment.transform 5 10 env491 = env492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env491 == env492) = true)

def leafEnv492 : List Nat := [2,4,8,16,0,10,19,5,27,1024,0,1045,8,1039,0,25,1038,1,1025,0,1045,0,10,24,1024,18,1,17,1,1038,1044,1,1025,10,5,10,4,2,1039,26,0,1044,1]

def active492 : List Nat := [0,1,2,3,9]

def tree492 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood492 : H12WitnessSearch.Good tree492 := H12GlobalWitnessIndex.good

theorem leafIdentity492 : H12AffineFastState.composeSystem env492 rootObs = leafEnv492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env492 rootObs == leafEnv492) = true)

theorem terminalChecked492 : H12PackedTerminal.terminalCheckFast leafEnv492 active492 tree492 = true := by decide +kernel

def env493 : List Nat := [2,4,8,16,1,64,88,4,80,1024,0,1044,9,1092,0,25,1093,1,1099,0,1044,1,64,25,88,17,1,1093,1045,1,1024,65,4,65,1092,81]

theorem envBound493 : H12AffineFastState.Bounded env493 := by
  intro p hp
  have h : env493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans490_493 : H12AffineEnvironment.transform 4 1 env490 = env493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env490 == env493) = true)

def leafEnv493 : List Nat := [2,4,8,16,1,64,88,4,80,1024,0,1044,9,1092,0,25,1093,1,1099,0,1044,1,64,25,1099,88,1,17,1,1093,1045,1,1024,65,4,65,4,3,1092,81,0,1045,1]

def active493 : List Nat := [0,1,2,3,5,9]

def tree493 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood493 : H12WitnessSearch.Good tree493 := H12GlobalWitnessIndex.good

theorem leafIdentity493 : H12AffineFastState.composeSystem env493 rootObs = leafEnv493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env493 rootObs == leafEnv493) = true)

theorem terminalChecked493 : H12PackedTerminal.terminalCheckFast leafEnv493 active493 tree493 = true := by decide +kernel

def env494 : List Nat := [2,4,8,16,32,64,121,37,113,1024,1,1077,41,1125,1,65536,1124,0,66643,1,1077,32,64,65568,89,17,0,1124,1076,0,1057,96,37,96,1125,112]

theorem envBound494 : H12AffineFastState.Bounded env494 := by
  intro p hp
  have h : env494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans488_494 : H12AffineEnvironment.transform 10 1 env488 = env494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env488 == env494) = true)

theorem identity494 : scanCanonicalize (H12AffineFastState.compose env494 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound494 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env495 : List Nat := [2,4,8,16,32,10,51,37,59,1024,1,1077,41,1071,1,65536,1070,0,66585,1,1077,32,10,65568,19,17,0,1070,1076,0,1057,42,37,42,1071,58]

theorem envBound495 : H12AffineFastState.Bounded env495 := by
  intro p hp
  have h : env495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans494_495 : H12AffineEnvironment.transform 5 10 env494 = env495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env494 == env495) = true)

theorem identity495 : scanCanonicalize (H12AffineFastState.compose env495 (packedSelected [3] rootPS)) = affineNative (2^(15+1) ^^^ 24) := by decide +kernel

theorem selectedBound495 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env496 : List Nat := [2,4,8,16,32,10,51,37,59,1024,1,1077,41,1071,1,24,1070,0,1025,1,1077,32,10,56,19,17,0,1070,1076,0,1057,42,37,42,1071,58]

theorem envBound496 : H12AffineFastState.Bounded env496 := by
  intro p hp
  have h : env496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans495_496 : H12AffineEnvironment.transform 15 24 env495 = env496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env495 == env496) = true)

def leafEnv496 : List Nat := [2,4,8,16,32,10,51,37,59,1024,1,1077,41,1071,1,24,1070,0,1025,1,1077,32,10,56,1056,19,1,17,0,1070,1076,0,1057,42,37,42,4,35,1071,58,0,1076,1]

def active496 : List Nat := [0,1,2,3,4,9]

def tree496 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood496 : H12WitnessSearch.Good tree496 := H12GlobalWitnessIndex.good

theorem leafIdentity496 : H12AffineFastState.composeSystem env496 rootObs = leafEnv496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env496 rootObs == leafEnv496) = true)

theorem terminalChecked496 : H12PackedTerminal.terminalCheckFast leafEnv496 active496 tree496 = true := by decide +kernel

def env497 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,2317,4177,32768,65536,1345,33061,524288,32768,4096,261,5457,98564,2436,5377,33060,4176,1297,2048,1284,4294967296,256,4295591082,1344,136]

theorem envBound497 : H12AffineFastState.Bounded env497 := by
  intro p hp
  have h : env497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans476_497 : H12AffineEnvironment.transform 8 137 env476 = env497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env476 == env497) = true)

theorem identity497 : scanCanonicalize (H12AffineFastState.compose env497 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound497 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env498 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,2317,4177,32768,33167,1345,33061,524288,32768,4096,261,5457,139,2436,5377,33060,4176,1297,2048,1284,4294967296,256,4295492901,1344,136]

theorem envBound498 : H12AffineFastState.Bounded env498 := by
  intro p hp
  have h : env498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans497_498 : H12AffineEnvironment.transform 15 33167 env497 = env498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env497 == env498) = true)

theorem identity498 : scanCanonicalize (H12AffineFastState.compose env498 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound498 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env499 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2317,1345,32768,33167,1345,33061,524288,32768,1296,261,65,139,2436,17,33060,1344,1297,2048,1284,4294967296,256,4295492901,1344,136]

theorem envBound499 : H12AffineFastState.Bounded env499 := by
  intro p hp
  have h : env499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans498_499 : H12AffineEnvironment.transform 11 1296 env498 = env499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env498 == env499) = true)

theorem identity499 : scanCanonicalize (H12AffineFastState.compose env499 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound499 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env500 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2317,1345,2340,2219,1345,2049,524288,2340,1296,261,65,139,2436,17,2048,1344,1297,2048,1284,4294967296,256,4295492901,1344,136]

theorem envBound500 : H12AffineFastState.Bounded env500 := by
  intro p hp
  have h : env500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans499_500 : H12AffineEnvironment.transform 14 2340 env499 = env500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env499 == env500) = true)

theorem identity500 : scanCanonicalize (H12AffineFastState.compose env500 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound500 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env501 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2317,1345,2340,2219,1345,2049,1024,2340,1296,261,65,139,2436,17,2048,1344,1297,2048,1284,4294967296,256,4294967589,1344,136]

theorem envBound501 : H12AffineFastState.Bounded env501 := by
  intro p hp
  have h : env501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans500_501 : H12AffineEnvironment.transform 18 1024 env500 = env501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env500 == env501) = true)

def env502 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,43681,524288,32768,4096,10249,6104,98564,8329,5377,33061,4825,1297,9093,1284,4294967296,256,4295601967,1344,513]

theorem envBound502 : H12AffineFastState.Bounded env502 := by
  intro p hp
  have h : env502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans474_502 : H12AffineEnvironment.transform 21 10249 env474 = env502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env474 == env502) = true)

theorem identity502 : scanCanonicalize (H12AffineFastState.compose env502 (packedSelected [2,6,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 8233) := by decide +kernel

theorem selectedBound502 : packedSelected [2,6,7,9] rootPS < 2^1333 := by decide +kernel

def env503 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,8233,65536,1345,2696,524288,8233,4096,10249,6104,74029,8329,5377,8460,4825,1297,9093,1284,4294967296,256,4295560966,1344,513]

theorem envBound503 : H12AffineFastState.Bounded env503 := by
  intro p hp
  have h : env503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans502_503 : H12AffineEnvironment.transform 14 8233 env502 = env503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env502 == env503) = true)

def env504 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,8233,65536,1345,2048,524288,8233,4096,10249,5456,74029,8329,5377,8460,4177,1297,8461,1284,4294967296,256,4295560590,1344,137]

theorem envBound504 : H12AffineFastState.Bounded env504 := by
  intro p hp
  have h : env504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans503_504 : H12AffineEnvironment.transform 8 136 env503 = env504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env503 == env504) = true)

theorem identity504 : scanCanonicalize (H12AffineFastState.compose env504 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(18+1) ^^^ 75175) := by decide +kernel

theorem selectedBound504 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env505 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,8233,65536,1345,2048,75175,8233,4096,10249,5456,74029,8329,5377,8460,4177,1297,8461,1284,4294967296,256,4294977577,1344,137]

theorem envBound505 : H12AffineFastState.Bounded env505 := by
  intro p hp
  have h : env505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans504_505 : H12AffineEnvironment.transform 18 75175 env504 = env505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75175 env504 == env505) = true)

theorem identity505 : scanCanonicalize (H12AffineFastState.compose env505 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound505 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env506 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1297,8192,1345,8233,65536,1345,2048,75175,8233,1297,10249,65,74029,8329,16,8460,1344,1297,8461,1284,4294967296,256,4294977577,1344,137]

theorem envBound506 : H12AffineFastState.Bounded env506 := by
  intro p hp
  have h : env506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans505_506 : H12AffineEnvironment.transform 11 1297 env505 = env506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env505 == env506) = true)

theorem identity506 : scanCanonicalize (H12AffineFastState.compose env506 (packedSelected [1,2,3,4,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 2316) := by decide +kernel

theorem selectedBound506 : packedSelected [1,2,3,4,5,10,13] rootPS < 2^1333 := by decide +kernel

def env507 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1297,2316,1345,2341,65536,1345,2048,68779,2341,1297,261,65,67617,2437,16,2048,1344,1297,2049,1284,4294967296,256,4294967589,1344,137]

theorem envBound507 : H12AffineFastState.Bounded env507 := by
  intro p hp
  have h : env507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans506_507 : H12AffineEnvironment.transform 12 2316 env506 = env507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2316 env506 == env507) = true)

def env508 : List Nat := [2,4,8,16,32,64,120,256,112,1024,2048,1297,2316,1345,2341,65536,1345,2048,68691,2341,1297,261,65,67617,2429,16,2048,1344,1297,2049,1284,4294967296,256,4294967589,1344,113]

theorem envBound508 : H12AffineFastState.Bounded env508 := by
  intro p hp
  have h : env508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans507_508 : H12AffineEnvironment.transform 6 120 env507 = env508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env507 == env508) = true)

theorem identity508 : scanCanonicalize (H12AffineFastState.compose env508 (packedSelected [5] rootPS)) = affineNative (2^(15+1) ^^^ 2423) := by decide +kernel

theorem selectedBound508 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env509 : List Nat := [2,4,8,16,32,64,120,256,112,1024,2048,1297,2316,1345,2341,2423,1345,2048,1316,2341,1297,261,65,342,2429,16,2048,1344,1297,2049,1284,4294967296,256,4294967589,1344,113]

theorem envBound509 : H12AffineFastState.Bounded env509 := by
  intro p hp
  have h : env509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans508_509 : H12AffineEnvironment.transform 15 2423 env508 = env509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2423 env508 == env509) = true)

theorem identity509 : scanCanonicalize (H12AffineFastState.compose env509 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound509 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env510 : List Nat := [2,4,8,16,32,64,120,37,112,1024,2048,1076,2089,1124,2048,2130,1124,2048,1025,2048,1076,32,65,115,2136,16,2048,1125,1076,2049,1057,4294967296,37,4294967296,1125,113]

theorem envBound510 : H12AffineFastState.Bounded env510 := by
  intro p hp
  have h : env510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans509_510 : H12AffineEnvironment.transform 7 37 env509 = env510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env509 == env510) = true)

theorem identity510 : scanCanonicalize (H12AffineFastState.compose env510 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 91) := by decide +kernel

theorem selectedBound510 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env511 : List Nat := [2,4,8,16,32,64,120,37,112,1024,2048,1076,2089,1124,2048,2130,1124,2048,1025,2048,1076,32,65,115,2136,16,2048,1125,1076,2049,1057,91,37,91,1125,113]

theorem envBound511 : H12AffineFastState.Bounded env511 := by
  intro p hp
  have h : env511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans510_511 : H12AffineEnvironment.transform 31 91 env510 = env511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 91 env510 == env511) = true)

theorem identity511 : scanCanonicalize (H12AffineFastState.compose env511 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound511 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env512 : List Nat := [2,4,8,16,32,42,18,37,26,1024,2048,1076,2089,1038,2048,2104,1038,2048,1025,2048,1076,32,43,25,2098,16,2048,1039,1076,2049,1057,49,37,49,1039,27]

theorem envBound512 : H12AffineFastState.Bounded env512 := by
  intro p hp
  have h : env512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans511_512 : H12AffineEnvironment.transform 5 42 env511 = env512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env511 == env512) = true)

def leafEnv512 : List Nat := [2,4,8,16,32,42,18,37,26,1024,2048,1076,2089,1038,2048,2104,1038,2048,1025,2048,1076,32,43,25,1056,2098,1,16,2048,1039,1076,2049,1057,49,37,49,4,2082,1039,27,0,1076,1]

def active512 : List Nat := [0,1,2,3,4,9,10]

def tree512 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood512 : H12WitnessSearch.Good tree512 := H12GlobalWitnessIndex.good

theorem leafIdentity512 : H12AffineFastState.composeSystem env512 rootObs = leafEnv512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env512 rootObs == leafEnv512) = true)

theorem terminalChecked512 : H12PackedTerminal.terminalCheckFast leafEnv512 active512 tree512 = true := by decide +kernel

def env513 : List Nat := [2,4,8,16,32,64,121,256,113,1024,2048,1297,2316,1345,2341,65536,1345,2048,68690,2341,1297,261,65,67617,2428,16,2048,1344,1297,2049,1284,4294967296,256,4294967589,1344,112]

theorem envBound513 : H12AffineFastState.Bounded env513 := by
  intro p hp
  have h : env513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans507_513 : H12AffineEnvironment.transform 6 121 env507 = env513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env507 == env513) = true)

theorem identity513 : scanCanonicalize (H12AffineFastState.compose env513 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound513 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env514 : List Nat := [2,4,8,16,32,64,121,37,113,1024,2048,1076,2089,1124,2048,65536,1124,2048,68690,2048,1076,32,65,67617,2137,16,2048,1125,1076,2049,1057,4294967296,37,4294967296,1125,112]

theorem envBound514 : H12AffineFastState.Bounded env514 := by
  intro p hp
  have h : env514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans513_514 : H12AffineEnvironment.transform 7 37 env513 = env514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env513 == env514) = true)

theorem identity514 : scanCanonicalize (H12AffineFastState.compose env514 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 49) := by decide +kernel

theorem selectedBound514 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env515 : List Nat := [2,4,8,16,32,64,121,37,113,1024,2048,1076,2089,1124,2048,65536,1124,2048,68690,2048,1076,32,65,67617,2137,16,2048,1125,1076,2049,1057,49,37,49,1125,112]

theorem envBound515 : H12AffineFastState.Bounded env515 := by
  intro p hp
  have h : env515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans514_515 : H12AffineEnvironment.transform 31 49 env514 = env515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 49 env514 == env515) = true)

def env516 : List Nat := [2,4,8,16,32,64,121,37,113,1024,0,1076,41,1124,0,65536,1124,0,66642,0,1076,32,65,65569,89,16,0,1125,1076,1,1057,49,37,49,1125,112]

theorem envBound516 : H12AffineFastState.Bounded env516 := by
  intro p hp
  have h : env516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans515_516 : H12AffineEnvironment.transform 10 0 env515 = env516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env515 == env516) = true)

theorem identity516 : scanCanonicalize (H12AffineFastState.compose env516 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 56) := by decide +kernel

theorem selectedBound516 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env517 : List Nat := [2,4,8,16,32,64,121,37,113,1024,0,1076,41,1124,0,56,1124,0,1130,0,1076,32,65,25,89,16,0,1125,1076,1,1057,49,37,49,1125,112]

theorem envBound517 : H12AffineFastState.Bounded env517 := by
  intro p hp
  have h : env517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans516_517 : H12AffineEnvironment.transform 15 56 env516 = env517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 56 env516 == env517) = true)

def env518 : List Nat := [2,4,8,16,0,64,89,5,81,1024,0,1044,9,1092,0,24,1092,0,1098,0,1044,0,65,25,89,16,0,1093,1044,1,1025,17,5,17,1093,80]

theorem envBound518 : H12AffineFastState.Bounded env518 := by
  intro p hp
  have h : env518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans517_518 : H12AffineEnvironment.transform 4 0 env517 = env518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env517 == env518) = true)

theorem identity518 : scanCanonicalize (H12AffineFastState.compose env518 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound518 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env519 : List Nat := [2,4,8,16,0,11,18,5,26,1024,0,1044,9,1039,0,24,1039,0,1025,0,1044,0,10,25,18,16,0,1038,1044,1,1025,17,5,17,1038,27]

theorem envBound519 : H12AffineFastState.Bounded env519 := by
  intro p hp
  have h : env519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans518_519 : H12AffineEnvironment.transform 5 11 env518 = env519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env518 == env519) = true)

def leafEnv519 : List Nat := [2,4,8,16,0,11,18,5,26,1024,0,1044,9,1039,0,24,1039,0,1025,0,1044,0,10,25,1024,18,1,16,0,1038,1044,1,1025,17,5,17,4,2,1038,27,0,1044,1]

def active519 : List Nat := [0,1,2,3,9]

def tree519 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood519 : H12WitnessSearch.Good tree519 := H12GlobalWitnessIndex.good

theorem leafIdentity519 : H12AffineFastState.composeSystem env519 rootObs = leafEnv519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env519 rootObs == leafEnv519) = true)

theorem terminalChecked519 : H12PackedTerminal.terminalCheckFast leafEnv519 active519 tree519 = true := by decide +kernel

def env520 : List Nat := [2,4,8,16,1,64,88,4,80,1024,0,1045,8,1093,0,25,1093,0,1099,0,1045,1,65,25,89,16,0,1092,1045,1,1024,16,4,16,1092,81]

theorem envBound520 : H12AffineFastState.Bounded env520 := by
  intro p hp
  have h : env520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans517_520 : H12AffineEnvironment.transform 4 1 env517 = env520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env517 == env520) = true)

def leafEnv520 : List Nat := [2,4,8,16,1,64,88,4,80,1024,0,1045,8,1093,0,25,1093,0,1099,0,1045,1,65,25,1099,89,1,16,0,1092,1045,1,1024,16,4,16,4,3,1092,81,0,1045,1]

def active520 : List Nat := [0,1,2,3,5,9]

def tree520 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood520 : H12WitnessSearch.Good tree520 := H12GlobalWitnessIndex.good

theorem leafIdentity520 : H12AffineFastState.composeSystem env520 rootObs = leafEnv520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env520 rootObs == leafEnv520) = true)

theorem terminalChecked520 : H12PackedTerminal.terminalCheckFast leafEnv520 active520 tree520 = true := by decide +kernel

def env521 : List Nat := [2,4,8,16,32,64,121,37,113,1024,1,1076,40,1124,1,65536,1124,1,66643,1,1076,32,65,65568,88,16,1,1125,1076,0,1057,49,37,49,1125,112]

theorem envBound521 : H12AffineFastState.Bounded env521 := by
  intro p hp
  have h : env521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans515_521 : H12AffineEnvironment.transform 10 1 env515 = env521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env515 == env521) = true)

theorem identity521 : scanCanonicalize (H12AffineFastState.compose env521 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound521 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env522 : List Nat := [2,4,8,16,32,43,18,37,26,1024,1,1076,40,1039,1,65536,1039,1,66616,1,1076,32,42,65568,51,16,1,1038,1076,0,1057,49,37,49,1038,27]

theorem envBound522 : H12AffineFastState.Bounded env522 := by
  intro p hp
  have h : env522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans521_522 : H12AffineEnvironment.transform 5 43 env521 = env522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env521 == env522) = true)

theorem identity522 : scanCanonicalize (H12AffineFastState.compose env522 (packedSelected [1] rootPS)) = affineNative (2^(15+1) ^^^ 57) := by decide +kernel

theorem selectedBound522 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env523 : List Nat := [2,4,8,16,32,43,18,37,26,1024,1,1076,40,1039,1,57,1039,1,1025,1,1076,32,42,25,51,16,1,1038,1076,0,1057,49,37,49,1038,27]

theorem envBound523 : H12AffineFastState.Bounded env523 := by
  intro p hp
  have h : env523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans522_523 : H12AffineEnvironment.transform 15 57 env522 = env523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 57 env522 == env523) = true)

def leafEnv523 : List Nat := [2,4,8,16,32,43,18,37,26,1024,1,1076,40,1039,1,57,1039,1,1025,1,1076,32,42,25,1056,51,1,16,1,1038,1076,0,1057,49,37,49,4,35,1038,27,0,1076,1]

def active523 : List Nat := [0,1,2,3,4,9]

def tree523 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood523 : H12WitnessSearch.Good tree523 := H12GlobalWitnessIndex.good

theorem leafIdentity523 : H12AffineFastState.composeSystem env523 rootObs = leafEnv523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env523 rootObs == leafEnv523) = true)

theorem terminalChecked523 : H12PackedTerminal.terminalCheckFast leafEnv523 active523 tree523 = true := by decide +kernel

def env524 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8233,65536,1345,2049,524288,8233,4096,10249,5457,74029,8329,5377,8460,4176,1297,8460,1284,4294967296,256,4295560591,1344,136]

theorem envBound524 : H12AffineFastState.Bounded env524 := by
  intro p hp
  have h : env524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans503_524 : H12AffineEnvironment.transform 8 137 env503 = env524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env503 == env524) = true)

theorem identity524 : scanCanonicalize (H12AffineFastState.compose env524 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 8614) := by decide +kernel

theorem selectedBound524 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env525 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8233,8614,1345,2049,524288,8233,4096,10249,5457,139,8329,5377,8460,4176,1297,8460,1284,4294967296,256,4295502889,1344,136]

theorem envBound525 : H12AffineFastState.Bounded env525 := by
  intro p hp
  have h : env525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans524_525 : H12AffineEnvironment.transform 15 8614 env524 = env525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8614 env524 == env525) = true)

theorem identity525 : scanCanonicalize (H12AffineFastState.compose env525 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound525 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env526 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1345,8233,8614,1345,2049,524288,8233,1296,10249,65,139,8329,17,8460,1344,1297,8460,1284,4294967296,256,4295502889,1344,136]

theorem envBound526 : H12AffineFastState.Bounded env526 := by
  intro p hp
  have h : env526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans525_526 : H12AffineEnvironment.transform 11 1296 env525 = env526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env525 == env526) = true)

theorem identity526 : scanCanonicalize (H12AffineFastState.compose env526 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 2317) := by decide +kernel

theorem selectedBound526 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env527 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2317,1345,2340,2219,1345,2049,524288,2340,1296,260,65,139,2436,17,2049,1344,1297,2049,1284,4294967296,256,4295492900,1344,136]

theorem envBound527 : H12AffineFastState.Bounded env527 := by
  intro p hp
  have h : env527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans526_527 : H12AffineEnvironment.transform 12 2317 env526 = env527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2317 env526 == env527) = true)

theorem identity527 : scanCanonicalize (H12AffineFastState.compose env527 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound527 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env528 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2317,1345,2340,2219,1345,2049,1024,2340,1296,260,65,139,2436,17,2049,1344,1297,2049,1284,4294967296,256,4294967588,1344,136]

theorem envBound528 : H12AffineFastState.Bounded env528 := by
  intro p hp
  have h : env528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans527_528 : H12AffineEnvironment.transform 18 1024 env527 = env528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env527 == env528) = true)

def env529 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878608,4294967296,537002320,4417151346,694534145,33563272]

theorem envBound529 : H12AffineFastState.Bounded env529 := by
  intro p hp
  have h : env529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7_529 : H12AffineEnvironment.transform 34 694534145 env7 = env529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534145 env7 == env529) = true)

def env530 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,157794304,1073741824,140788816,4294967296,157663568,4417151346,131073,33563272]

theorem envBound530 : H12AffineFastState.Bounded env530 := by
  intro p hp
  have h : env530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans529_530 : H12AffineEnvironment.transform 28 157794304 env529 = env530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env529 == env530) = true)

theorem identity530 : scanCanonicalize (H12AffineFastState.compose env530 (packedSelected [14] rootPS)) = affineNative (2^(25+1) ^^^ 18973700) := by decide +kernel

theorem selectedBound530 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env531 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,18973700,134217728,18993412,157794304,1073741824,140788816,4294967296,157663568,4335461750,131073,33563272]

theorem envBound531 : H12AffineFastState.Bounded env531 := by
  intro p hp
  have h : env531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans530_531 : H12AffineEnvironment.transform 25 18973700 env530 = env531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 18973700 env530 == env531) = true)

def env532 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,18973700,21352528,18993412,2232400,1073741824,18977792,4294967296,2101504,4335461750,131073,33563272]

theorem envBound532 : H12AffineFastState.Bounded env532 := by
  intro p hp
  have h : env532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans531_532 : H12AffineEnvironment.transform 26 21352528 env531 = env532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352528 env531 == env532) = true)

def env533 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,16880644,21352528,16892164,131152,1073741824,16876544,4294967296,256,4333368694,131073,33563272]

theorem envBound533 : H12AffineFastState.Bounded env533 := by
  intro p hp
  have h : env533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans532_533 : H12AffineEnvironment.transform 20 4096 env532 = env533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env532 == env533) = true)

theorem identity533 : scanCanonicalize (H12AffineFastState.compose env533 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230469) := by decide +kernel

theorem selectedBound533 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env534 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,230469,33554432,135233,4609045,148801,131152,1073741824,131141,4294967296,256,4333368694,131073,33563272]

theorem envBound534 : H12AffineFastState.Bounded env534 := by
  intro p hp
  have h : env534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans533_534 : H12AffineEnvironment.transform 23 230469 env533 = env534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230469 env533 == env534) = true)

theorem identity534 : scanCanonicalize (H12AffineFastState.compose env534 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 684441) := by decide +kernel

theorem selectedBound534 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env535 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,230469,684441,135233,4609045,148801,131152,1073741824,131141,4294967296,256,4299392239,131073,676625]

theorem envBound535 : H12AffineFastState.Bounded env535 := by
  intro p hp
  have h : env535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans534_535 : H12AffineEnvironment.transform 24 684441 env534 = env535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 684441 env534 == env535) = true)

def env536 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4096,4194304,5456,230469,664009,135233,4588613,136465,131152,1073741824,131141,4294967296,256,4299392239,131073,656193]

theorem envBound536 : H12AffineFastState.Bounded env536 := by
  intro p hp
  have h : env536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans535_536 : H12AffineEnvironment.transform 13 4176 env535 = env536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env535 == env536) = true)

theorem identity536 : scanCanonicalize (H12AffineFastState.compose env536 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 4427211) := by decide +kernel

theorem selectedBound536 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env537 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4096,4194304,5456,230469,664009,135233,4588613,136465,131152,4427211,131141,4294967296,256,4299392239,131073,656193]

theorem envBound537 : H12AffineFastState.Bounded env537 := by
  intro p hp
  have h : env537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans536_537 : H12AffineEnvironment.transform 29 4427211 env536 = env537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4427211 env536 == env537) = true)

theorem identity537 : scanCanonicalize (H12AffineFastState.compose env537 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound537 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env538 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,524288,32768,4096,4194304,5456,98564,533640,5376,4456708,4176,1297,4294794,1284,4294967296,256,4299260334,1344,525824]

theorem envBound538 : H12AffineFastState.Bounded env538 := by
  intro p hp
  have h : env538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans537_538 : H12AffineEnvironment.transform 16 1345 env537 = env538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env537 == env538) = true)

theorem identity538 : scanCanonicalize (H12AffineFastState.compose env538 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(21+1) ^^^ 623618) := by decide +kernel

theorem selectedBound538 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env539 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,524288,32768,4096,623618,5456,98564,533640,5376,886022,4176,1297,527496,1284,4294967296,256,4295493036,1344,525824]

theorem envBound539 : H12AffineFastState.Bounded env539 := by
  intro p hp
  have h : env539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans538_539 : H12AffineEnvironment.transform 21 623618 env538 = env539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 623618 env538 == env539) = true)

theorem identity539 : scanCanonicalize (H12AffineFastState.compose env539 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,20,21,22] rootPS)) = affineNative (2^(18+1) ^^^ 74882) := by decide +kernel

theorem selectedBound539 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,20,21,22] rootPS < 2^1333 := by decide +kernel

def env540 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,74882,32768,4096,41088,5456,98564,65546,5376,303492,4176,1297,75786,1284,4294967296,256,4295041326,1344,74370]

theorem envBound540 : H12AffineFastState.Bounded env540 := by
  intro p hp
  have h : env540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans539_540 : H12AffineEnvironment.transform 18 74882 env539 = env540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 74882 env539 == env540) = true)

theorem identity540 : scanCanonicalize (H12AffineFastState.compose env540 (packedSelected [1,3,4,5,8,9,12,13,15,16,21] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound540 : packedSelected [1,3,4,5,8,9,12,13,15,16,21] rootPS < 2^1333 := by decide +kernel

def env541 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,8322,1345,262144,1024,32768,4096,41088,5456,41350,8328,5376,303492,4176,1297,2184,1284,4294967296,256,4294967724,1344,512]

theorem envBound541 : H12AffineFastState.Bounded env541 := by
  intro p hp
  have h : env541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans540_541 : H12AffineEnvironment.transform 15 8322 env540 = env541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env540 == env541) = true)

theorem identity541 : scanCanonicalize (H12AffineFastState.compose env541 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 38329) := by decide +kernel

theorem selectedBound541 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env542 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,8322,1345,262144,1024,32768,4096,41088,5456,41350,8328,5376,303492,4176,1297,2184,1284,38329,256,37909,1344,512]

theorem envBound542 : H12AffineFastState.Bounded env542 := by
  intro p hp
  have h : env542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans541_542 : H12AffineEnvironment.transform 31 38329 env541 = env542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 38329 env541 == env542) = true)

theorem identity542 : scanCanonicalize (H12AffineFastState.compose env542 (packedSelected [3,5,10] rootPS)) = affineNative (2^(14+1) ^^^ 1361) := by decide +kernel

theorem selectedBound542 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env543 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,1361,8322,1345,262144,1024,1361,4096,9681,5456,9431,8328,5376,271573,4176,1297,2184,1284,4328,256,4420,1344,512]

theorem envBound543 : H12AffineFastState.Bounded env543 := by
  intro p hp
  have h : env543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans542_543 : H12AffineEnvironment.transform 14 1361 env542 = env543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1361 env542 == env543) = true)

theorem identity543 : scanCanonicalize (H12AffineFastState.compose env543 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(12+1) ^^^ 1117) := by decide +kernel

theorem selectedBound543 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env544 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,1117,4176,1361,1247,1345,262144,1024,1361,4096,396,5456,138,1237,5376,262280,4176,1297,2184,1284,4328,256,4420,1344,512]

theorem envBound544 : H12AffineFastState.Bounded env544 := by
  intro p hp
  have h : env544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans543_544 : H12AffineEnvironment.transform 12 1117 env543 = env544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1117 env543 == env544) = true)

theorem identity544 : scanCanonicalize (H12AffineFastState.compose env544 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 3361) := by decide +kernel

theorem selectedBound544 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env545 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,1117,4176,1361,1247,1345,3361,1024,1361,4096,396,5456,138,1237,5376,3497,4176,1297,2184,1284,4328,256,4420,1344,512]

theorem envBound545 : H12AffineFastState.Bounded env545 := by
  intro p hp
  have h : env545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans544_545 : H12AffineEnvironment.transform 17 3361 env544 = env545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 3361 env544 == env545) = true)

theorem identity545 : scanCanonicalize (H12AffineFastState.compose env545 (packedSelected [1,5,12] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound545 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env546 : List Nat := [2,4,8,16,32,64,128,256,512,5,2048,4096,88,4176,340,218,324,2340,5,340,4096,396,4437,138,208,4357,2476,4176,276,2184,257,4328,256,4420,325,512]

theorem envBound546 : H12AffineFastState.Bounded env546 := by
  intro p hp
  have h : env546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans545_546 : H12AffineEnvironment.transform 9 5 env545 = env546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env545 == env546) = true)

theorem identity546 : scanCanonicalize (H12AffineFastState.compose env546 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(11+1) ^^^ 2786) := by decide +kernel

theorem selectedBound546 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env547 : List Nat := [2,4,8,16,32,64,128,256,512,5,2048,2786,88,2738,340,218,324,2340,5,340,2786,396,2999,138,208,3047,2476,2738,276,2184,257,2570,256,2982,325,512]

theorem envBound547 : H12AffineFastState.Bounded env547 := by
  intro p hp
  have h : env547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans546_547 : H12AffineEnvironment.transform 11 2786 env546 = env547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2786 env546 == env547) = true)

theorem identity547 : scanCanonicalize (H12AffineFastState.compose env547 (packedSelected [1,3,13] rootPS)) = affineNative (2^(10+1) ^^^ 934) := by decide +kernel

theorem selectedBound547 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env548 : List Nat := [2,4,8,16,32,64,128,256,512,5,934,324,88,276,340,218,324,642,5,340,324,396,17,138,208,65,522,276,276,814,257,428,256,0,325,512]

theorem envBound548 : H12AffineFastState.Bounded env548 := by
  intro p hp
  have h : env548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans547_548 : H12AffineEnvironment.transform 10 934 env547 = env548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 934 env547 == env548) = true)

theorem identity548 : scanCanonicalize (H12AffineFastState.compose env548 (packedSelected [1,3,5] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound548 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env549 : List Nat := [2,4,8,16,32,64,8,256,512,5,814,324,88,276,340,82,324,522,5,340,324,260,17,2,88,65,522,276,276,814,257,292,256,0,325,512]

theorem envBound549 : H12AffineFastState.Bounded env549 := by
  intro p hp
  have h : env549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans548_549 : H12AffineEnvironment.transform 6 8 env548 = env549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env548 == env549) = true)

theorem identity549 : scanCanonicalize (H12AffineFastState.compose env549 (packedSelected [0] rootPS)) = affineNative (2^(8+1) ^^^ 269) := by decide +kernel

theorem selectedBound549 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env550 : List Nat := [2,4,8,16,32,64,8,256,269,5,35,324,88,276,340,82,324,263,5,340,324,260,17,2,88,65,263,276,276,35,257,292,256,0,325,269]

theorem envBound550 : H12AffineFastState.Bounded env550 := by
  intro p hp
  have h : env550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans549_550 : H12AffineEnvironment.transform 8 269 env549 = env550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 269 env549 == env550) = true)

def env551 : List Nat := [2,4,8,16,32,16,8,256,269,5,35,276,8,276,260,2,276,263,5,260,276,260,17,2,8,17,263,276,276,35,257,292,256,0,277,269]

theorem envBound551 : H12AffineFastState.Bounded env551 := by
  intro p hp
  have h : env551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans550_551 : H12AffineEnvironment.transform 5 16 env550 = env551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env550 == env551) = true)

theorem identity551 : scanCanonicalize (H12AffineFastState.compose env551 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 39) := by decide +kernel

theorem selectedBound551 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env552 : List Nat := [2,4,8,16,32,16,8,39,42,5,35,51,8,51,35,2,51,32,5,35,51,35,17,2,8,17,32,51,51,35,38,3,39,0,50,42]

theorem envBound552 : H12AffineFastState.Bounded env552 := by
  intro p hp
  have h : env552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans551_552 : H12AffineEnvironment.transform 7 39 env551 = env552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 39 env551 == env552) = true)

def env553 : List Nat := [2,4,8,16,32,17,8,256,269,5,35,277,9,276,261,3,277,263,5,261,277,260,17,2,9,16,263,276,276,35,257,292,256,0,276,269]

theorem envBound553 : H12AffineFastState.Bounded env553 := by
  intro p hp
  have h : env553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans550_553 : H12AffineEnvironment.transform 5 17 env550 = env553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env550 == env553) = true)

theorem identity553 : scanCanonicalize (H12AffineFastState.compose env553 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound553 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env554 : List Nat := [2,4,8,16,32,17,8,36,41,5,35,49,9,48,33,3,49,35,5,33,49,32,17,2,9,16,35,48,48,35,37,0,36,0,48,41]

theorem envBound554 : H12AffineFastState.Bounded env554 := by
  intro p hp
  have h : env554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans553_554 : H12AffineEnvironment.transform 7 36 env553 = env554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env553 == env554) = true)

theorem identity554 : scanCanonicalize (H12AffineFastState.compose env554 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound554 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env555 : List Nat := [2,4,1,16,32,17,1,36,32,5,35,49,0,48,33,3,49,35,5,33,49,32,17,2,0,16,35,48,48,35,37,0,36,0,48,32]

theorem envBound555 : H12AffineFastState.Bounded env555 := by
  intro p hp
  have h : env555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans554_555 : H12AffineEnvironment.transform 2 1 env554 = env555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env554 == env555) = true)

theorem identity555 : scanCanonicalize (H12AffineFastState.compose env555 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound555 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env556 : List Nat := [0,4,1,16,32,17,1,36,32,5,33,49,0,48,33,1,49,33,5,33,49,32,17,0,0,16,33,48,48,33,37,0,36,0,48,32]

theorem envBound556 : H12AffineFastState.Bounded env556 := by
  intro p hp
  have h : env556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans555_556 : H12AffineEnvironment.transform 0 0 env555 = env556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env555 == env556) = true)

def leafEnv556 : List Nat := [0,4,1,16,32,17,1,36,32,5,33,49,0,48,33,1,49,33,5,33,49,32,17,0,37,0,1,16,33,48,48,33,37,0,36,0,4,1,48,32,0,49,1]

def active556 : List Nat := [1,3,4]

def tree556 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood556 : H12WitnessSearch.Good tree556 := H12GlobalWitnessIndex.good

theorem leafIdentity556 : H12AffineFastState.composeSystem env556 rootObs = leafEnv556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env556 rootObs == leafEnv556) = true)

theorem terminalChecked556 : H12PackedTerminal.terminalCheckFast leafEnv556 active556 tree556 = true := by decide +kernel

def env557 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4096,4194304,5457,230469,664008,135233,4588612,136464,131152,1073741824,131141,4294967296,256,4299392239,131073,656192]

theorem envBound557 : H12AffineFastState.Bounded env557 := by
  intro p hp
  have h : env557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans535_557 : H12AffineEnvironment.transform 13 4177 env535 = env557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env535 == env557) = true)

theorem identity557 : scanCanonicalize (H12AffineFastState.compose env557 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 4950475) := by decide +kernel

theorem selectedBound557 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env558 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4096,4194304,5457,230469,664008,135233,4588612,136464,131152,4950475,131141,4294967296,256,4299392239,131073,656192]

theorem envBound558 : H12AffineFastState.Bounded env558 := by
  intro p hp
  have h : env558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans557_558 : H12AffineEnvironment.transform 29 4950475 env557 = env558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4950475 env557 == env558) = true)

theorem identity558 : scanCanonicalize (H12AffineFastState.compose env558 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound558 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env559 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,524288,32768,4096,4194304,5457,98565,533640,5377,4456708,4176,1296,4820107,1285,4294967296,256,4299260335,1345,525824]

theorem envBound559 : H12AffineFastState.Bounded env559 := by
  intro p hp
  have h : env559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans558_559 : H12AffineEnvironment.transform 16 1344 env558 = env559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env558 == env559) = true)

theorem identity559 : scanCanonicalize (H12AffineFastState.compose env559 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(21+1) ^^^ 772) := by decide +kernel

theorem selectedBound559 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env560 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,524288,32768,4096,772,5457,98565,533640,5377,262656,4176,1296,626575,1285,4294967296,256,4295066283,1345,525824]

theorem envBound560 : H12AffineFastState.Bounded env560 := by
  intro p hp
  have h : env560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans559_560 : H12AffineEnvironment.transform 21 772 env559 = env560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 772 env559 == env560) = true)

theorem identity560 : scanCanonicalize (H12AffineFastState.compose env560 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound560 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env561 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,1025,32768,4096,772,5457,98565,8329,5377,262656,4176,1296,101262,1285,4294967296,256,4295066283,1345,513]

theorem envBound561 : H12AffineFastState.Bounded env561 := by
  intro p hp
  have h : env561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans560_561 : H12AffineEnvironment.transform 18 1025 env560 = env561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env560 == env561) = true)

theorem identity561 : scanCanonicalize (H12AffineFastState.compose env561 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 33531) := by decide +kernel

theorem selectedBound561 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env562 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,33531,1344,262144,1025,32768,4096,772,5457,1022,8329,5377,262656,4176,1296,2421,1285,4294967296,256,4294967376,1345,513]

theorem envBound562 : H12AffineFastState.Bounded env562 := by
  intro p hp
  have h : env562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans561_562 : H12AffineEnvironment.transform 15 33531 env561 = env562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33531 env561 == env562) = true)

theorem identity562 : scanCanonicalize (H12AffineFastState.compose env562 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(31+1) ^^^ 15420) := by decide +kernel

theorem selectedBound562 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env563 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,33531,1344,262144,1025,32768,4096,772,5457,1022,8329,5377,262656,4176,1296,2421,1285,15420,256,15468,1345,513]

theorem envBound563 : H12AffineFastState.Bounded env563 := by
  intro p hp
  have h : env563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans562_563 : H12AffineEnvironment.transform 31 15420 env562 = env563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 15420 env562 == env563) = true)

theorem identity563 : scanCanonicalize (H12AffineFastState.compose env563 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 216) := by decide +kernel

theorem selectedBound563 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env564 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,4096,8192,4177,32768,32803,1344,262144,1025,32768,4096,476,5457,294,8329,5377,262360,4176,1296,2421,1285,15420,256,15468,1345,217]

theorem envBound564 : H12AffineFastState.Bounded env564 := by
  intro p hp
  have h : env564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans563_564 : H12AffineEnvironment.transform 8 216 env563 = env564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 216 env563 == env564) = true)

theorem identity564 : scanCanonicalize (H12AffineFastState.compose env564 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 7268) := by decide +kernel

theorem selectedBound564 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env565 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,4096,8192,4177,7268,7239,1344,262144,1025,7268,4096,476,5457,294,8329,5377,262360,4176,1296,2421,1285,15420,256,15468,1345,217]

theorem envBound565 : H12AffineFastState.Bounded env565 := by
  intro p hp
  have h : env565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans564_565 : H12AffineEnvironment.transform 14 7268 env564 = env565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 7268 env564 == env565) = true)

def env566 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,16777216,33554432,16880645,21352528,16892165,131153,1073741824,16876545,4294967296,257,4333368695,131073,33563272]

theorem envBound566 : H12AffineFastState.Bounded env566 := by
  intro p hp
  have h : env566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans532_566 : H12AffineEnvironment.transform 20 4097 env532 = env566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env532 == env566) = true)

theorem identity566 : scanCanonicalize (H12AffineFastState.compose env566 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound566 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env567 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,98565,33554432,5376,4477269,16384,131153,1073741824,1284,4294967296,257,4333368695,131073,33563272]

theorem envBound567 : H12AffineFastState.Bounded env567 := by
  intro p hp
  have h : env567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans566_567 : H12AffineEnvironment.transform 23 98565 env566 = env567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env566 == env567) = true)

theorem identity567 : scanCanonicalize (H12AffineFastState.compose env567 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound567 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env568 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,98565,8329,5376,4477269,16384,131153,1073741824,1284,4294967296,257,4299806206,131073,513]

theorem envBound568 : H12AffineFastState.Bounded env568 := by
  intro p hp
  have h : env568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans567_568 : H12AffineEnvironment.transform 24 8329 env567 = env568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env567 == env568) = true)

theorem identity568 : scanCanonicalize (H12AffineFastState.compose env568 (packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS)) = affineNative (2^(18+1) ^^^ 151825) := by decide +kernel

theorem selectedBound568 : packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env569 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,151825,32768,4097,4194304,17664,98565,8329,5376,4477269,16384,131153,1073741824,1284,4294967296,257,4299392239,131073,513]

theorem envBound569 : H12AffineFastState.Bounded env569 := by
  intro p hp
  have h : env569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans568_569 : H12AffineEnvironment.transform 18 151825 env568 = env569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 151825 env568 == env569) = true)

theorem identity569 : scanCanonicalize (H12AffineFastState.compose env569 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 4294795) := by decide +kernel

theorem selectedBound569 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env570 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,151825,32768,4097,4194304,17664,98565,8329,5376,4477269,16384,131153,4294795,1284,4294967296,257,4299392239,131073,513]

theorem envBound570 : H12AffineFastState.Bounded env570 := by
  intro p hp
  have h : env570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans569_570 : H12AffineEnvironment.transform 29 4294795 env569 = env570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4294795 env569 == env570) = true)

theorem identity570 : scanCanonicalize (H12AffineFastState.compose env570 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound570 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env571 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,131393,32768,4097,4194304,5456,98565,8329,5376,4456709,4176,131153,4294795,1284,4294967296,257,4299392239,131073,513]

theorem envBound571 : H12AffineFastState.Bounded env571 := by
  intro p hp
  have h : env571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans570_571 : H12AffineEnvironment.transform 13 4176 env570 = env571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env570 == env571) = true)

theorem identity571 : scanCanonicalize (H12AffineFastState.compose env571 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound571 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env572 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,1024,32768,4097,4194304,5456,98565,8329,5376,4456709,4176,1296,4294795,1284,4294967296,257,4299260334,1344,513]

theorem envBound572 : H12AffineFastState.Bounded env572 := by
  intro p hp
  have h : env572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans571_572 : H12AffineEnvironment.transform 16 1345 env571 = env572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env571 == env572) = true)

theorem identity572 : scanCanonicalize (H12AffineFastState.compose env572 (packedSelected [3,5,10] rootPS)) = affineNative (2^(31+1) ^^^ 99327) := by decide +kernel

theorem selectedBound572 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env573 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,1024,32768,4097,4194304,5456,98565,8329,5376,4456709,4176,1296,4294795,1284,99327,257,4194897,1344,513]

theorem envBound573 : H12AffineFastState.Bounded env573 := by
  intro p hp
  have h : env573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans572_573 : H12AffineEnvironment.transform 31 99327 env572 = env573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 99327 env572 == env573) = true)

theorem identity573 : scanCanonicalize (H12AffineFastState.compose env573 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 81470) := by decide +kernel

theorem selectedBound573 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env574 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,81470,1024,32768,4097,4194304,5456,98565,8329,5376,4276027,4176,1296,4294795,1284,99327,257,4194897,1344,513]

theorem envBound574 : H12AffineFastState.Bounded env574 := by
  intro p hp
  have h : env574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans573_574 : H12AffineEnvironment.transform 17 81470 env573 = env574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 81470 env573 == env574) = true)

theorem identity574 : scanCanonicalize (H12AffineFastState.compose env574 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(14+1) ^^^ 13973) := by decide +kernel

theorem selectedBound574 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env575 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,13973,65536,1345,81470,1024,13973,4097,4194304,5456,79760,8329,5376,4276027,4176,1296,4275742,1284,79210,257,4194897,1344,513]

theorem envBound575 : H12AffineFastState.Bounded env575 := by
  intro p hp
  have h : env575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans574_575 : H12AffineEnvironment.transform 14 13973 env574 = env575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13973 env574 == env575) = true)

theorem identity575 : scanCanonicalize (H12AffineFastState.compose env575 (packedSelected [0,7,20] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound575 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env576 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1992,8461,65536,1345,76198,1024,8461,1945,4194304,712,73736,8329,664,4270243,1992,1296,4270470,1284,74482,257,4194897,1344,513]

theorem envBound576 : H12AffineFastState.Bounded env576 := by
  intro p hp
  have h : env576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans575_576 : H12AffineEnvironment.transform 11 1944 env575 = env576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env575 == env576) = true)

theorem identity576 : scanCanonicalize (H12AffineFastState.compose env576 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 1955) := by decide +kernel

theorem selectedBound576 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env577 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1955,1944,8192,1992,8461,65536,1345,75269,1024,8461,1945,4194304,712,73736,8329,664,4269824,1992,1296,4269605,1284,74482,257,4194897,1344,513]

theorem envBound577 : H12AffineFastState.Bounded env577 := by
  intro p hp
  have h : env577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans576_577 : H12AffineEnvironment.transform 10 1955 env576 = env577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1955 env576 == env577) = true)

theorem identity577 : scanCanonicalize (H12AffineFastState.compose env577 (packedSelected [3,8,12,21] rootPS)) = affineNative (2^(21+1) ^^^ 74283) := by decide +kernel

theorem selectedBound577 : packedSelected [3,8,12,21] rootPS < 2^1333 := by decide +kernel

def env578 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1955,1944,8192,1992,8461,65536,1345,75269,1024,8461,1945,74283,712,73736,8329,664,1323,1992,1296,1038,1284,74482,257,73850,1344,513]

theorem envBound578 : H12AffineFastState.Bounded env578 := by
  intro p hp
  have h : env578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans577_578 : H12AffineEnvironment.transform 21 74283 env577 = env578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 74283 env577 == env578) = true)

def env579 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,18973700,21352529,18993412,2232401,1073741824,18977793,4294967296,2101505,4335461750,131073,33563272]

theorem envBound579 : H12AffineFastState.Bounded env579 := by
  intro p hp
  have h : env579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans531_579 : H12AffineEnvironment.transform 26 21352529 env531 = env579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352529 env531 == env579) = true)

def env580 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,16880644,21352529,16892164,131153,1073741824,16876545,4294967296,257,4333368694,131073,33563272]

theorem envBound580 : H12AffineFastState.Bounded env580 := by
  intro p hp
  have h : env580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans579_580 : H12AffineEnvironment.transform 20 4096 env579 = env580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env579 == env580) = true)

def env581 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,16777216,33554432,16880645,21352529,16892165,131152,1073741824,16876544,4294967296,256,4333368695,131073,33563272]

theorem envBound581 : H12AffineFastState.Bounded env581 := by
  intro p hp
  have h : env581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans579_581 : H12AffineEnvironment.transform 20 4097 env579 = env581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env579 == env581) = true)

theorem identity581 : scanCanonicalize (H12AffineFastState.compose env581 (packedSelected [35] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound581 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env582 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17664,16777216,33554432,16880645,21352529,16892165,1297,1073741824,16876544,4294967296,256,4333368695,1344,33563272]

theorem envBound582 : H12AffineFastState.Bounded env582 := by
  intro p hp
  have h : env582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans581_582 : H12AffineEnvironment.transform 16 1345 env581 = env582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env581 == env582) = true)

def env583 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4097,4194304,17664,16777216,33554432,16880645,21352529,16892165,1297,1073741824,16876544,4294967296,256,4332843383,1344,33563272]

theorem envBound583 : H12AffineFastState.Bounded env583 := by
  intro p hp
  have h : env583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans582_583 : H12AffineEnvironment.transform 18 1024 env582 = env583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env582 == env583) = true)

theorem identity583 : scanCanonicalize (H12AffineFastState.compose env583 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 20973966) := by decide +kernel

theorem selectedBound583 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env584 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4097,4194304,17664,16777216,33554432,16880645,21352529,16892165,1297,20973966,16876544,4294967296,256,4332843383,1344,33563272]

theorem envBound584 : H12AffineFastState.Bounded env584 := by
  intro p hp
  have h : env584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans583_584 : H12AffineEnvironment.transform 29 20973966 env583 = env584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 20973966 env583 == env584) = true)

theorem identity584 : scanCanonicalize (H12AffineFastState.compose env584 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound584 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env585 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4097,4194304,17664,98564,33554432,5377,4477269,16385,1297,4294794,1284,4294967296,256,4332843383,1344,33563272]

theorem envBound585 : H12AffineFastState.Bounded env585 := by
  intro p hp
  have h : env585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans584_585 : H12AffineEnvironment.transform 23 98564 env584 = env585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env584 == env585) = true)

def env586 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,4096,8192,16384,32768,65536,65,262144,256,32768,4097,4194304,16384,98564,33554432,4097,4477269,16385,17,4294794,4,4294967296,256,4332843383,64,33563272]

theorem envBound586 : H12AffineFastState.Bounded env586 := by
  intro p hp
  have h : env586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans585_586 : H12AffineEnvironment.transform 9 256 env585 = env586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env585 == env586) = true)

def env587 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,4096,8192,4176,32768,65536,65,262144,256,32768,4097,4194304,4176,98564,33554432,4097,4456709,4177,17,4294794,4,4294967296,256,4332822823,64,33563272]

theorem envBound587 : H12AffineFastState.Bounded env587 := by
  intro p hp
  have h : env587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans586_587 : H12AffineEnvironment.transform 13 4176 env586 = env587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env586 == env587) = true)

theorem identity587 : scanCanonicalize (H12AffineFastState.compose env587 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound587 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env588 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,4176,32768,65536,65,262144,256,32768,4097,4194304,4176,98564,33554432,4097,4456709,4177,17,4294794,4,4294967296,256,4332822823,64,33562625]

theorem envBound588 : H12AffineFastState.Bounded env588 := by
  intro p hp
  have h : env588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans587_588 : H12AffineEnvironment.transform 8 137 env587 = env588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env587 == env588) = true)

theorem identity588 : scanCanonicalize (H12AffineFastState.compose env588 (packedSelected [8,10,13,15] rootPS)) = affineNative (2^(21+1) ^^^ 217) := by decide +kernel

theorem selectedBound588 : packedSelected [8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env589 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,4176,32768,65536,65,262144,256,32768,4097,217,4176,98564,33554432,4097,262620,4177,17,100435,4,4294967296,256,4328628734,64,33562625]

theorem envBound589 : H12AffineFastState.Bounded env589 := by
  intro p hp
  have h : env589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans588_589 : H12AffineEnvironment.transform 21 217 env588 = env589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 217 env588 == env589) = true)

theorem identity589 : scanCanonicalize (H12AffineFastState.compose env589 (packedSelected [1,3,5,10,12,21] rootPS)) = affineNative (2^(24+1) ^^^ 37268) := by decide +kernel

theorem selectedBound589 : packedSelected [1,3,5,10,12,21] rootPS < 2^1333 := by decide +kernel

def env590 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,4176,32768,65536,65,262144,256,32768,4097,217,4176,98564,37268,4097,262620,4177,17,100435,4,4294967296,256,4295045226,64,45461]

theorem envBound590 : H12AffineFastState.Bounded env590 := by
  intro p hp
  have h : env590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans589_590 : H12AffineEnvironment.transform 24 37268 env589 = env590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 37268 env589 == env590) = true)

theorem identity590 : scanCanonicalize (H12AffineFastState.compose env590 (packedSelected [0,1,3,4,5,7,10,12,13,16,20,22] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound590 : packedSelected [0,1,3,4,5,7,10,12,13,16,20,22] rootPS < 2^1333 := by decide +kernel

def env591 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,4096,8192,4176,32768,65536,65,262144,5,32768,4097,217,4176,98305,37009,4097,262361,4177,17,100435,4,4294967296,5,4295045226,64,45200]

theorem envBound591 : H12AffineFastState.Bounded env591 := by
  intro p hp
  have h : env591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans590_591 : H12AffineEnvironment.transform 7 5 env590 = env591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env590 == env591) = true)

theorem identity591 : scanCanonicalize (H12AffineFastState.compose env591 (packedSelected [6,25] rootPS)) = affineNative (2^(14+1) ^^^ 12312) := by decide +kernel

theorem selectedBound591 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env592 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,4096,8192,4176,12312,65536,65,262144,5,12312,4097,217,4176,77849,8329,4097,262361,4177,17,79947,4,4294967296,5,4295045226,64,136]

theorem envBound592 : H12AffineFastState.Bounded env592 := by
  intro p hp
  have h : env592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans591_592 : H12AffineEnvironment.transform 14 12312 env591 = env592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 12312 env591 == env592) = true)

theorem identity592 : scanCanonicalize (H12AffineFastState.compose env592 (packedSelected [1,8,12] rootPS)) = affineNative (2^(12+1) ^^^ 4121) := by decide +kernel

theorem selectedBound592 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env593 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,4096,4121,4176,1,65536,65,262144,5,1,4097,217,4176,65536,4240,4097,262361,4177,17,67666,4,4294967296,5,4295032947,64,136]

theorem envBound593 : H12AffineFastState.Bounded env593 := by
  intro p hp
  have h : env593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans592_593 : H12AffineEnvironment.transform 12 4121 env592 = env593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4121 env592 == env593) = true)

def env594 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,64,89,16,1,65536,65,262144,5,1,65,217,16,65536,208,65,262361,17,17,67666,4,4294967296,5,4295032947,64,136]

theorem envBound594 : H12AffineFastState.Bounded env594 := by
  intro p hp
  have h : env594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans593_594 : H12AffineEnvironment.transform 11 64 env593 = env594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 64 env593 == env594) = true)

theorem identity594 : scanCanonicalize (H12AffineFastState.compose env594 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262386) := by decide +kernel

theorem selectedBound594 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env595 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,64,89,16,1,65536,65,262144,5,1,65,217,16,65536,208,65,262361,17,17,67666,4,262386,5,327809,64,136]

theorem envBound595 : H12AffineFastState.Bounded env595 := by
  intro p hp
  have h : env595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans594_595 : H12AffineEnvironment.transform 31 262386 env594 = env595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262386 env594 == env595) = true)

def env596 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,64,89,16,1,65536,65,80,5,1,65,217,16,65536,208,65,137,17,17,67666,4,162,5,65745,64,136]

theorem envBound596 : H12AffineFastState.Bounded env596 := by
  intro p hp
  have h : env596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans595_596 : H12AffineEnvironment.transform 17 80 env595 = env596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 80 env595 == env596) = true)

theorem identity596 : scanCanonicalize (H12AffineFastState.compose env596 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound596 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env597 : List Nat := [2,4,8,16,32,64,88,5,81,5,2048,64,89,16,1,65536,65,80,5,1,65,1,16,65536,8,65,81,17,17,67666,4,122,5,65545,64,80]

theorem envBound597 : H12AffineFastState.Bounded env597 := by
  intro p hp
  have h : env597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans596_597 : H12AffineEnvironment.transform 6 88 env596 = env597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env596 == env597) = true)

theorem identity597 : scanCanonicalize (H12AffineFastState.compose env597 (packedSelected [1,2,3,4,8] rootPS)) = affineNative (2^(15+1) ^^^ 2163) := by decide +kernel

theorem selectedBound597 : packedSelected [1,2,3,4,8] rootPS < 2^1333 := by decide +kernel

def env598 : List Nat := [2,4,8,16,32,64,88,5,81,5,2048,64,89,16,1,2163,65,80,5,1,65,1,16,2163,8,65,81,17,17,33,4,122,5,2170,64,80]

theorem envBound598 : H12AffineFastState.Bounded env598 := by
  intro p hp
  have h : env598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans597_598 : H12AffineEnvironment.transform 15 2163 env597 = env598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2163 env597 == env598) = true)

theorem identity598 : scanCanonicalize (H12AffineFastState.compose env598 (packedSelected [2,4] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound598 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env599 : List Nat := [2,4,8,16,32,64,88,5,81,5,33,64,89,16,1,82,65,80,5,1,65,1,16,82,8,65,81,17,17,33,4,122,5,91,64,80]

theorem envBound599 : H12AffineFastState.Bounded env599 := by
  intro p hp
  have h : env599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans598_599 : H12AffineEnvironment.transform 10 33 env598 = env599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env598 == env599) = true)

def env600 : List Nat := [2,4,8,16,0,64,88,5,81,5,1,64,89,16,1,82,65,80,5,1,65,1,16,82,8,65,81,17,17,1,4,90,5,91,64,80]

theorem envBound600 : H12AffineFastState.Bounded env600 := by
  intro p hp
  have h : env600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans599_600 : H12AffineEnvironment.transform 4 0 env599 = env600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env599 == env600) = true)

theorem identity600 : scanCanonicalize (H12AffineFastState.compose env600 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound600 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env601 : List Nat := [2,4,8,1,0,64,73,5,64,5,1,64,72,1,1,67,65,65,5,1,65,1,1,67,8,65,64,0,0,1,4,75,5,74,64,65]

theorem envBound601 : H12AffineFastState.Bounded env601 := by
  intro p hp
  have h : env601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans600_601 : H12AffineEnvironment.transform 3 1 env600 = env601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env600 == env601) = true)

def leafEnv601 : List Nat := [2,4,8,1,0,64,73,5,64,5,1,64,72,1,1,67,65,65,5,1,65,1,1,67,4,8,1,65,64,0,0,1,4,75,5,74,4,3,64,65,0,1,1]

def active601 : List Nat := [0,1,2,5]

def tree601 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood601 : H12WitnessSearch.Good tree601 := H12GlobalWitnessIndex.good

theorem leafIdentity601 : H12AffineFastState.composeSystem env601 rootObs = leafEnv601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env601 rootObs == leafEnv601) = true)

theorem terminalChecked601 : H12PackedTerminal.terminalCheckFast leafEnv601 active601 tree601 = true := by decide +kernel

def env602 : List Nat := [2,4,8,16,1,64,88,5,81,5,0,64,89,16,1,82,65,80,5,1,65,1,16,82,8,65,81,17,17,0,4,91,5,91,64,80]

theorem envBound602 : H12AffineFastState.Bounded env602 := by
  intro p hp
  have h : env602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans599_602 : H12AffineEnvironment.transform 4 1 env599 = env602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env599 == env602) = true)

theorem identity602 : scanCanonicalize (H12AffineFastState.compose env602 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound602 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env603 : List Nat := [2,4,8,16,1,10,18,5,27,5,0,10,19,16,1,24,11,26,5,1,11,1,16,24,8,11,27,17,17,0,4,17,5,17,10,26]

theorem envBound603 : H12AffineFastState.Bounded env603 := by
  intro p hp
  have h : env603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans602_603 : H12AffineEnvironment.transform 5 10 env602 = env603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env602 == env603) = true)

def leafEnv603 : List Nat := [2,4,8,16,1,10,18,5,27,5,0,10,19,16,1,24,11,26,5,1,11,1,16,24,4,8,1,11,27,17,17,0,4,17,5,17,4,3,10,26,0,16,1]

def active603 : List Nat := [0,1,2,3]

def tree603 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood603 : H12WitnessSearch.Good tree603 := H12GlobalWitnessIndex.good

theorem leafIdentity603 : H12AffineFastState.composeSystem env603 rootObs = leafEnv603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env603 rootObs == leafEnv603) = true)

theorem terminalChecked603 : H12PackedTerminal.terminalCheckFast leafEnv603 active603 tree603 = true := by decide +kernel

def env604 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,64,89,16,1,65536,65,81,5,1,65,217,16,65536,208,65,136,17,17,67666,4,163,5,65744,64,136]

theorem envBound604 : H12AffineFastState.Bounded env604 := by
  intro p hp
  have h : env604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans595_604 : H12AffineEnvironment.transform 17 81 env595 = env604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 81 env595 == env604) = true)

def env605 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,65,88,17,1,65536,65,262144,5,1,64,217,17,65536,209,64,262361,16,17,67666,4,4294967296,5,4295032947,64,136]

theorem envBound605 : H12AffineFastState.Bounded env605 := by
  intro p hp
  have h : env605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans593_605 : H12AffineEnvironment.transform 11 65 env593 = env605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 65 env593 == env605) = true)

theorem identity605 : scanCanonicalize (H12AffineFastState.compose env605 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262307) := by decide +kernel

theorem selectedBound605 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env606 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,65,88,17,1,65536,65,262144,5,1,64,217,17,65536,209,64,262361,16,17,67666,4,262307,5,327888,64,136]

theorem envBound606 : H12AffineFastState.Bounded env606 := by
  intro p hp
  have h : env606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans605_606 : H12AffineEnvironment.transform 31 262307 env605 = env606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262307 env605 == env606) = true)

def env607 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,65,88,17,1,65536,65,80,5,1,64,217,17,65536,209,64,137,16,17,67666,4,243,5,65664,64,136]

theorem envBound607 : H12AffineFastState.Bounded env607 := by
  intro p hp
  have h : env607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans606_607 : H12AffineEnvironment.transform 17 80 env606 = env607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 80 env606 == env607) = true)

def env608 : List Nat := [2,4,8,16,32,64,128,5,137,5,2048,65,88,17,1,65536,65,81,5,1,64,217,17,65536,209,64,136,16,17,67666,4,242,5,65665,64,136]

theorem envBound608 : H12AffineFastState.Bounded env608 := by
  intro p hp
  have h : env608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans606_608 : H12AffineEnvironment.transform 17 81 env606 = env608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 81 env606 == env608) = true)

theorem identity608 : scanCanonicalize (H12AffineFastState.compose env608 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound608 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env609 : List Nat := [2,4,8,16,32,64,88,5,81,5,2048,65,88,17,1,65536,65,81,5,1,64,1,17,65536,9,64,80,16,17,67666,4,42,5,65625,64,80]

theorem envBound609 : H12AffineFastState.Bounded env609 := by
  intro p hp
  have h : env609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans608_609 : H12AffineEnvironment.transform 6 88 env608 = env609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env608 == env609) = true)

theorem identity609 : scanCanonicalize (H12AffineFastState.compose env609 (packedSelected [1,2,3,4,8] rootPS)) = affineNative (2^(15+1) ^^^ 2163) := by decide +kernel

theorem selectedBound609 : packedSelected [1,2,3,4,8] rootPS < 2^1333 := by decide +kernel

def env610 : List Nat := [2,4,8,16,32,64,88,5,81,5,2048,65,88,17,1,2163,65,81,5,1,64,1,17,2163,9,64,80,16,17,33,4,42,5,2090,64,80]

theorem envBound610 : H12AffineFastState.Bounded env610 := by
  intro p hp
  have h : env610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans609_610 : H12AffineEnvironment.transform 15 2163 env609 = env610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2163 env609 == env610) = true)

theorem identity610 : scanCanonicalize (H12AffineFastState.compose env610 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound610 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env611 : List Nat := [2,4,8,16,32,64,88,5,81,5,33,65,88,17,1,82,65,81,5,1,64,1,17,82,9,64,80,16,17,33,4,42,5,11,64,80]

theorem envBound611 : H12AffineFastState.Bounded env611 := by
  intro p hp
  have h : env611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans610_611 : H12AffineEnvironment.transform 10 33 env610 = env611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env610 == env611) = true)

def env612 : List Nat := [2,4,8,16,0,64,88,5,81,5,1,65,88,17,1,82,65,81,5,1,64,1,17,82,9,64,80,16,17,1,4,10,5,11,64,80]

theorem envBound612 : H12AffineFastState.Bounded env612 := by
  intro p hp
  have h : env612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans611_612 : H12AffineEnvironment.transform 4 0 env611 = env612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env611 == env612) = true)

theorem identity612 : scanCanonicalize (H12AffineFastState.compose env612 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound612 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env613 : List Nat := [2,4,8,16,0,1,25,5,16,5,1,0,25,17,1,19,0,16,5,1,1,1,17,19,9,1,17,16,17,1,4,10,5,11,1,17]

theorem envBound613 : H12AffineFastState.Bounded env613 := by
  intro p hp
  have h : env613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans612_613 : H12AffineEnvironment.transform 5 1 env612 = env613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env612 == env613) = true)

def leafEnv613 : List Nat := [2,4,8,16,0,1,25,5,16,5,1,0,25,17,1,19,0,16,5,1,1,1,17,19,4,9,1,1,17,16,17,1,4,10,5,11,4,3,1,17,0,16,1]

def active613 : List Nat := [0,1,2,3]

def tree613 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood613 : H12WitnessSearch.Good tree613 := H12GlobalWitnessIndex.good

theorem leafIdentity613 : H12AffineFastState.composeSystem env613 rootObs = leafEnv613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env613 rootObs == leafEnv613) = true)

theorem terminalChecked613 : H12PackedTerminal.terminalCheckFast leafEnv613 active613 tree613 = true := by decide +kernel

def env614 : List Nat := [2,4,8,16,1,64,88,5,81,5,0,65,88,17,1,82,65,81,5,1,64,1,17,82,9,64,80,16,17,0,4,11,5,11,64,80]

theorem envBound614 : H12AffineFastState.Bounded env614 := by
  intro p hp
  have h : env614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans611_614 : H12AffineEnvironment.transform 4 1 env611 = env614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env611 == env614) = true)

theorem identity614 : scanCanonicalize (H12AffineFastState.compose env614 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound614 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env615 : List Nat := [2,4,8,16,1,10,18,5,27,5,0,11,18,17,1,24,11,27,5,1,10,1,17,24,9,10,26,16,17,0,4,11,5,11,10,26]

theorem envBound615 : H12AffineFastState.Bounded env615 := by
  intro p hp
  have h : env615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans614_615 : H12AffineEnvironment.transform 5 10 env614 = env615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env614 == env615) = true)

def leafEnv615 : List Nat := [2,4,8,16,1,10,18,5,27,5,0,11,18,17,1,24,11,27,5,1,10,1,17,24,4,9,1,10,26,16,17,0,4,11,5,11,4,3,10,26,0,16,1]

def active615 : List Nat := [0,1,2,3]

def tree615 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood615 : H12WitnessSearch.Good tree615 := H12GlobalWitnessIndex.good

theorem leafIdentity615 : H12AffineFastState.composeSystem env615 rootObs = leafEnv615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env615 rootObs == leafEnv615) = true)

theorem terminalChecked615 : H12PackedTerminal.terminalCheckFast leafEnv615 active615 tree615 = true := by decide +kernel

def env616 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,4096,8192,4177,32768,65536,65,262144,256,32768,4097,4194304,4177,98564,33554432,4097,4456708,4176,17,4294794,4,4294967296,256,4332822822,64,33563272]

theorem envBound616 : H12AffineFastState.Bounded env616 := by
  intro p hp
  have h : env616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans586_616 : H12AffineEnvironment.transform 13 4177 env586 = env616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env586 == env616) = true)

theorem identity616 : scanCanonicalize (H12AffineFastState.compose env616 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound616 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env617 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,4096,8192,4177,32768,65536,65,262144,256,32768,4097,4194304,4177,98564,8328,4097,4456708,4176,17,4294794,4,4294967296,256,4299260334,64,512]

theorem envBound617 : H12AffineFastState.Bounded env617 := by
  intro p hp
  have h : env617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans616_617 : H12AffineEnvironment.transform 24 8328 env616 = env617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env616 == env617) = true)

theorem identity617 : scanCanonicalize (H12AffineFastState.compose env617 (packedSelected [3,5,10] rootPS)) = affineNative (2^(11+1) ^^^ 65) := by decide +kernel

theorem selectedBound617 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env618 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,65,8192,16,32768,65536,65,262144,256,32768,64,4194304,16,98564,8328,64,4456708,17,17,4294794,4,4294967296,256,4299260334,64,512]

theorem envBound618 : H12AffineFastState.Bounded env618 := by
  intro p hp
  have h : env618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans617_618 : H12AffineEnvironment.transform 11 65 env617 = env618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 65 env617 == env618) = true)

theorem identity618 : scanCanonicalize (H12AffineFastState.compose env618 (packedSelected [1,12,13] rootPS)) = affineNative (2^(21+1) ^^^ 41088) := by decide +kernel

theorem selectedBound618 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env619 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,65,8192,16,32768,65536,65,262144,256,32768,64,41088,16,98564,8328,64,303492,17,17,75786,4,4294967296,256,4295041326,64,512]

theorem envBound619 : H12AffineFastState.Bounded env619 := by
  intro p hp
  have h : env619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans618_619 : H12AffineEnvironment.transform 21 41088 env618 = env619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41088 env618 == env619) = true)

theorem identity619 : scanCanonicalize (H12AffineFastState.compose env619 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 106538) := by decide +kernel

theorem selectedBound619 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env620 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,65,8192,16,32768,65536,65,262144,256,32768,64,41088,16,98564,8328,64,303492,17,17,75786,4,106538,256,33028,64,512]

theorem envBound620 : H12AffineFastState.Bounded env620 := by
  intro p hp
  have h : env620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans619_620 : H12AffineEnvironment.transform 31 106538 env619 = env620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106538 env619 == env620) = true)

theorem identity620 : scanCanonicalize (H12AffineFastState.compose env620 (packedSelected [4,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound620 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env621 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,65,8192,16,8460,65536,65,262144,256,8460,64,396,16,73736,8328,64,262280,17,17,75786,4,65830,256,8200,64,512]

theorem envBound621 : H12AffineFastState.Bounded env621 := by
  intro p hp
  have h : env621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans620_621 : H12AffineEnvironment.transform 14 8460 env620 = env621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env620 == env621) = true)

theorem identity621 : scanCanonicalize (H12AffineFastState.compose env621 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound621 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env622 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,65,8,16,260,65536,65,262144,256,260,64,396,16,65536,128,64,262280,17,17,67586,4,65830,256,0,64,512]

theorem envBound622 : H12AffineFastState.Bounded env622 := by
  intro p hp
  have h : env622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans621_622 : H12AffineEnvironment.transform 12 8 env621 = env622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env621 == env622) = true)

def env623 : List Nat := [2,4,8,16,32,64,8,256,512,256,2048,65,8,16,260,65536,65,262144,256,260,64,260,16,65536,8,64,262144,17,17,67586,4,65830,256,0,64,512]

theorem envBound623 : H12AffineFastState.Bounded env623 := by
  intro p hp
  have h : env623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans622_623 : H12AffineEnvironment.transform 6 8 env622 = env623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env622 == env623) = true)

theorem identity623 : scanCanonicalize (H12AffineFastState.compose env623 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 65616) := by decide +kernel

theorem selectedBound623 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env624 : List Nat := [2,4,8,16,32,64,8,256,512,256,2048,65,8,16,260,65536,65,65616,256,260,64,260,16,65536,8,64,65616,17,17,67586,4,65830,256,0,64,512]

theorem envBound624 : H12AffineFastState.Bounded env624 := by
  intro p hp
  have h : env624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans623_624 : H12AffineEnvironment.transform 17 65616 env623 = env624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 65616 env623 == env624) = true)

def env625 : List Nat := [2,4,8,16,32,64,8,256,512,256,0,65,8,16,260,65536,65,65616,256,260,64,260,16,65536,8,64,65616,17,17,65538,4,65830,256,0,64,512]

theorem envBound625 : H12AffineFastState.Bounded env625 := by
  intro p hp
  have h : env625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans624_625 : H12AffineEnvironment.transform 10 0 env624 = env625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env624 == env625) = true)

theorem identity625 : scanCanonicalize (H12AffineFastState.compose env625 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 118) := by decide +kernel

theorem selectedBound625 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env626 : List Nat := [2,4,8,16,32,64,8,118,512,118,0,65,8,16,114,65536,65,65616,118,114,64,114,16,65536,8,64,65616,17,17,65538,4,65616,118,0,64,512]

theorem envBound626 : H12AffineFastState.Bounded env626 := by
  intro p hp
  have h : env626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans625_626 : H12AffineEnvironment.transform 7 118 env625 = env626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 118 env625 == env626) = true)

theorem identity626 : scanCanonicalize (H12AffineFastState.compose env626 (packedSelected [2,4,11] rootPS)) = affineNative (2^(8+1) ^^^ 88) := by decide +kernel

theorem selectedBound626 : packedSelected [2,4,11] rootPS < 2^1333 := by decide +kernel

def env627 : List Nat := [2,4,8,16,32,64,8,118,88,118,0,65,8,16,114,65536,65,65616,118,114,64,114,16,65536,8,64,65616,17,17,65538,4,65616,118,0,64,88]

theorem envBound627 : H12AffineFastState.Bounded env627 := by
  intro p hp
  have h : env627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans626_627 : H12AffineEnvironment.transform 8 88 env626 = env627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 88 env626 == env627) = true)

theorem identity627 : scanCanonicalize (H12AffineFastState.compose env627 (packedSelected [2,4,9,18] rootPS)) = affineNative (2^(15+1) ^^^ 90) := by decide +kernel

theorem selectedBound627 : packedSelected [2,4,9,18] rootPS < 2^1333 := by decide +kernel

def env628 : List Nat := [2,4,8,16,32,64,8,118,88,118,0,65,8,16,114,90,65,10,118,114,64,114,16,90,8,64,10,17,17,88,4,10,118,0,64,88]

theorem envBound628 : H12AffineFastState.Bounded env628 := by
  intro p hp
  have h : env628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans627_628 : H12AffineEnvironment.transform 15 90 env627 = env628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 90 env627 == env628) = true)

theorem identity628 : scanCanonicalize (H12AffineFastState.compose env628 (packedSelected [2,4,9,23] rootPS)) = affineNative (2^(5+1) ^^^ 24) := by decide +kernel

theorem selectedBound628 : packedSelected [2,4,9,23] rootPS < 2^1333 := by decide +kernel

def env629 : List Nat := [2,4,8,16,32,24,8,46,0,46,0,25,8,16,42,2,25,10,46,42,24,42,16,2,8,24,10,17,17,0,4,10,46,0,24,0]

theorem envBound629 : H12AffineFastState.Bounded env629 := by
  intro p hp
  have h : env629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans628_629 : H12AffineEnvironment.transform 5 24 env628 = env629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 24 env628 == env629) = true)

def env630 : List Nat := [2,4,8,16,0,24,8,14,0,14,0,25,8,16,10,2,25,10,14,10,24,10,16,2,8,24,10,17,17,0,4,10,14,0,24,0]

theorem envBound630 : H12AffineFastState.Bounded env630 := by
  intro p hp
  have h : env630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans629_630 : H12AffineEnvironment.transform 4 0 env629 = env630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env629 == env630) = true)

def leafEnv630 : List Nat := [2,4,8,16,0,24,8,14,0,14,0,25,8,16,10,2,25,10,14,10,24,10,16,2,4,8,1,24,10,17,17,0,4,10,14,0,4,2,24,0,0,16,1]

def active630 : List Nat := [0,1,2,3]

def tree630 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood630 : H12WitnessSearch.Good tree630 := H12GlobalWitnessIndex.good

theorem leafIdentity630 : H12AffineFastState.composeSystem env630 rootObs = leafEnv630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env630 rootObs == leafEnv630) = true)

theorem terminalChecked630 : H12PackedTerminal.terminalCheckFast leafEnv630 active630 tree630 = true := by decide +kernel

def env631 : List Nat := [2,4,8,16,1,24,8,15,0,15,0,25,8,16,11,2,25,10,15,11,24,11,16,2,8,24,10,17,17,0,4,10,15,0,24,0]

theorem envBound631 : H12AffineFastState.Bounded env631 := by
  intro p hp
  have h : env631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans629_631 : H12AffineEnvironment.transform 4 1 env629 = env631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env629 == env631) = true)

theorem identity631 : scanCanonicalize (H12AffineFastState.compose env631 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound631 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env632 : List Nat := [2,4,0,16,1,16,0,7,0,7,0,17,0,16,3,2,17,2,7,3,16,3,16,2,0,16,2,17,17,0,4,2,7,0,16,0]

theorem envBound632 : H12AffineFastState.Bounded env632 := by
  intro p hp
  have h : env632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans631_632 : H12AffineEnvironment.transform 2 0 env631 = env632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env631 == env632) = true)

theorem identity632 : scanCanonicalize (H12AffineFastState.compose env632 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound632 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env633 : List Nat := [1,4,0,16,1,16,0,4,0,4,0,17,0,16,0,1,17,1,4,0,16,0,16,1,0,16,1,17,17,0,4,1,4,0,16,0]

theorem envBound633 : H12AffineFastState.Bounded env633 := by
  intro p hp
  have h : env633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans632_633 : H12AffineEnvironment.transform 0 1 env632 = env633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env632 == env633) = true)

def leafEnv633 : List Nat := [1,4,0,16,1,16,0,4,0,4,0,17,0,16,0,1,17,1,4,0,16,0,16,1,4,0,1,16,1,17,17,0,4,1,4,0,4,1,16,0,0,16,1]

def active633 : List Nat := [1,3]

def tree633 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood633 : H12WitnessSearch.Good tree633 := H12GlobalWitnessIndex.good

theorem leafIdentity633 : H12AffineFastState.composeSystem env633 rootObs = leafEnv633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env633 rootObs == leafEnv633) = true)

theorem terminalChecked633 : H12PackedTerminal.terminalCheckFast leafEnv633 active633 tree633 = true := by decide +kernel

def env634 : List Nat := [2,4,8,16,32,64,8,256,512,256,1,65,8,16,260,65536,65,65616,256,260,64,260,16,65536,8,64,65616,17,17,65539,4,65830,256,0,64,512]

theorem envBound634 : H12AffineFastState.Bounded env634 := by
  intro p hp
  have h : env634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans624_634 : H12AffineEnvironment.transform 10 1 env624 = env634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env624 == env634) = true)

theorem identity634 : scanCanonicalize (H12AffineFastState.compose env634 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 373) := by decide +kernel

theorem selectedBound634 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env635 : List Nat := [2,4,8,16,32,64,8,256,512,256,1,65,8,16,260,373,65,293,256,260,64,260,16,373,8,64,293,17,17,374,4,83,256,0,64,512]

theorem envBound635 : H12AffineFastState.Bounded env635 := by
  intro p hp
  have h : env635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans634_635 : H12AffineEnvironment.transform 15 373 env634 = env635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 373 env634 == env635) = true)

theorem identity635 : scanCanonicalize (H12AffineFastState.compose env635 (packedSelected [2,11] rootPS)) = affineNative (2^(8+1) ^^^ 82) := by decide +kernel

theorem selectedBound635 : packedSelected [2,11] rootPS < 2^1333 := by decide +kernel

def env636 : List Nat := [2,4,8,16,32,64,8,256,82,256,1,65,8,16,260,373,65,293,256,260,64,260,16,373,8,64,293,17,17,374,4,83,256,0,64,82]

theorem envBound636 : H12AffineFastState.Bounded env636 := by
  intro p hp
  have h : env636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans635_636 : H12AffineEnvironment.transform 8 82 env635 = env636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 82 env635 == env636) = true)

theorem identity636 : scanCanonicalize (H12AffineFastState.compose env636 (packedSelected [2,9,18] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound636 : packedSelected [2,9,18] rootPS < 2^1333 := by decide +kernel

def env637 : List Nat := [2,4,2,16,32,64,2,256,82,256,1,65,2,16,260,373,65,293,256,260,64,260,16,373,2,64,293,17,17,374,4,83,256,0,64,82]

theorem envBound637 : H12AffineFastState.Bounded env637 := by
  intro p hp
  have h : env637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans636_637 : H12AffineEnvironment.transform 2 2 env636 = env637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env636 == env637) = true)

theorem identity637 : scanCanonicalize (H12AffineFastState.compose env637 (packedSelected [2,32] rootPS)) = affineNative (2^(7+1) ^^^ 119) := by decide +kernel

theorem selectedBound637 : packedSelected [2,32] rootPS < 2^1333 := by decide +kernel

def env638 : List Nat := [2,4,2,16,32,64,2,119,82,119,1,65,2,16,115,2,65,82,119,115,64,115,16,2,2,64,82,17,17,1,4,83,119,0,64,82]

theorem envBound638 : H12AffineFastState.Bounded env638 := by
  intro p hp
  have h : env638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans637_638 : H12AffineEnvironment.transform 7 119 env637 = env638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 119 env637 == env638) = true)

def env639 : List Nat := [2,4,2,16,0,64,2,87,82,87,1,65,2,16,83,2,65,82,87,83,64,83,16,2,2,64,82,17,17,1,4,83,87,0,64,82]

theorem envBound639 : H12AffineFastState.Bounded env639 := by
  intro p hp
  have h : env639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans638_639 : H12AffineEnvironment.transform 4 0 env638 = env639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env638 == env639) = true)

theorem identity639 : scanCanonicalize (H12AffineFastState.compose env639 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound639 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env640 : List Nat := [2,4,2,16,0,16,2,7,2,7,1,17,2,16,3,2,17,2,7,3,16,3,16,2,2,16,2,17,17,1,4,3,7,0,16,2]

theorem envBound640 : H12AffineFastState.Bounded env640 := by
  intro p hp
  have h : env640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans639_640 : H12AffineEnvironment.transform 5 16 env639 = env640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env639 == env640) = true)

theorem identity640 : scanCanonicalize (H12AffineFastState.compose env640 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound640 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env641 : List Nat := [0,4,0,16,0,16,0,5,0,5,1,17,0,16,1,0,17,0,5,1,16,1,16,0,0,16,0,17,17,1,4,1,5,0,16,0]

theorem envBound641 : H12AffineFastState.Bounded env641 := by
  intro p hp
  have h : env641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans640_641 : H12AffineEnvironment.transform 0 0 env640 = env641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env640 == env641) = true)

def leafEnv641 : List Nat := [0,4,0,16,0,16,0,5,0,5,1,17,0,16,1,0,17,0,5,1,16,1,16,0,4,0,1,16,0,17,17,1,4,1,5,0,4,0,16,0,0,16,1]

def active641 : List Nat := [1,3]

def tree641 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood641 : H12WitnessSearch.Good tree641 := H12GlobalWitnessIndex.good

theorem leafIdentity641 : H12AffineFastState.composeSystem env641 rootObs = leafEnv641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env641 rootObs == leafEnv641) = true)

theorem terminalChecked641 : H12PackedTerminal.terminalCheckFast leafEnv641 active641 tree641 = true := by decide +kernel

def env642 : List Nat := [2,4,2,16,1,64,2,86,82,86,1,65,2,16,82,2,65,82,86,82,64,82,16,2,2,64,82,17,17,1,4,83,86,0,64,82]

theorem envBound642 : H12AffineFastState.Bounded env642 := by
  intro p hp
  have h : env642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans638_642 : H12AffineEnvironment.transform 4 1 env638 = env642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env638 == env642) = true)

def leafEnv642 : List Nat := [2,4,2,16,1,64,2,86,82,86,1,65,2,16,82,2,65,82,86,82,64,82,16,2,4,2,1,64,82,17,17,1,4,83,86,0,4,2,64,82,0,16,1]

def active642 : List Nat := [0,1,3,5]

def tree642 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood642 : H12WitnessSearch.Good tree642 := H12GlobalWitnessIndex.good

theorem leafIdentity642 : H12AffineFastState.composeSystem env642 rootObs = leafEnv642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env642 rootObs == leafEnv642) = true)

theorem terminalChecked642 : H12PackedTerminal.terminalCheckFast leafEnv642 active642 tree642 = true := by decide +kernel

def env643 : List Nat := [2,4,8,16,32,64,9,256,512,256,2048,65,8,16,260,65536,65,262144,256,260,64,261,16,65536,9,64,262145,17,17,67586,4,65830,256,0,64,512]

theorem envBound643 : H12AffineFastState.Bounded env643 := by
  intro p hp
  have h : env643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans622_643 : H12AffineEnvironment.transform 6 9 env622 = env643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env622 == env643) = true)

theorem identity643 : scanCanonicalize (H12AffineFastState.compose env643 (packedSelected [7] rootPS)) = affineNative (2^(15+1) ^^^ 341) := by decide +kernel

theorem selectedBound643 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env644 : List Nat := [2,4,8,16,32,64,9,256,512,256,2048,65,8,16,260,341,65,262144,256,260,64,261,16,341,9,64,262145,17,17,2391,4,115,256,0,64,512]

theorem envBound644 : H12AffineFastState.Bounded env644 := by
  intro p hp
  have h : env644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans643_644 : H12AffineEnvironment.transform 15 341 env643 = env644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 341 env643 == env644) = true)

def env645 : List Nat := [2,4,8,16,32,64,9,256,512,256,0,65,8,16,260,341,65,262144,256,260,64,261,16,341,9,64,262145,17,17,343,4,115,256,0,64,512]

theorem envBound645 : H12AffineFastState.Bounded env645 := by
  intro p hp
  have h : env645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans644_645 : H12AffineEnvironment.transform 10 0 env644 = env645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env644 == env645) = true)

theorem identity645 : scanCanonicalize (H12AffineFastState.compose env645 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 50) := by decide +kernel

theorem selectedBound645 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env646 : List Nat := [2,4,8,16,32,50,9,256,512,256,0,51,8,16,260,295,51,262144,256,260,50,261,16,295,9,50,262145,17,17,293,4,1,256,0,50,512]

theorem envBound646 : H12AffineFastState.Bounded env646 := by
  intro p hp
  have h : env646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans645_646 : H12AffineEnvironment.transform 5 50 env645 = env646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 50 env645 == env646) = true)

theorem identity646 : scanCanonicalize (H12AffineFastState.compose env646 (packedSelected [2,4] rootPS)) = affineNative (2^(8+1) ^^^ 11) := by decide +kernel

theorem selectedBound646 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env647 : List Nat := [2,4,8,16,32,50,9,256,11,256,0,51,8,16,260,295,51,262144,256,260,50,261,16,295,9,50,262145,17,17,293,4,1,256,0,50,11]

theorem envBound647 : H12AffineFastState.Bounded env647 := by
  intro p hp
  have h : env647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans646_647 : H12AffineEnvironment.transform 8 11 env646 = env647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 11 env646 == env647) = true)

theorem identity647 : scanCanonicalize (H12AffineFastState.compose env647 (packedSelected [2,11,18] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound647 : packedSelected [2,11,18] rootPS < 2^1333 := by decide +kernel

def env648 : List Nat := [2,4,2,16,32,50,3,256,1,256,0,51,2,16,260,295,51,262144,256,260,50,261,16,295,3,50,262145,17,17,293,4,1,256,0,50,1]

theorem envBound648 : H12AffineFastState.Bounded env648 := by
  intro p hp
  have h : env648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans647_648 : H12AffineEnvironment.transform 2 2 env647 = env648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env647 == env648) = true)

def env649 : List Nat := [2,4,2,16,0,18,3,256,1,256,0,19,2,16,260,263,19,262144,256,260,18,261,16,263,3,18,262145,17,17,261,4,1,256,0,18,1]

theorem envBound649 : H12AffineFastState.Bounded env649 := by
  intro p hp
  have h : env649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans648_649 : H12AffineEnvironment.transform 4 0 env648 = env649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env648 == env649) = true)

theorem identity649 : scanCanonicalize (H12AffineFastState.compose env649 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound649 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env650 : List Nat := [2,4,2,16,0,18,3,4,1,4,0,19,2,16,0,3,19,262144,4,0,18,1,16,3,3,18,262145,17,17,1,4,1,4,0,18,1]

theorem envBound650 : H12AffineFastState.Bounded env650 := by
  intro p hp
  have h : env650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans649_650 : H12AffineEnvironment.transform 7 4 env649 = env650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env649 == env650) = true)

theorem identity650 : scanCanonicalize (H12AffineFastState.compose env650 (packedSelected [5] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound650 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env651 : List Nat := [0,4,0,16,0,16,1,4,1,4,0,17,0,16,0,1,17,262144,4,0,16,1,16,1,1,16,262145,17,17,1,4,1,4,0,16,1]

theorem envBound651 : H12AffineFastState.Bounded env651 := by
  intro p hp
  have h : env651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans650_651 : H12AffineEnvironment.transform 0 0 env650 = env651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env650 == env651) = true)

theorem identity651 : scanCanonicalize (H12AffineFastState.compose env651 (packedSelected [9] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound651 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env652 : List Nat := [0,4,0,16,0,16,1,4,1,4,0,17,0,16,0,1,17,0,4,0,16,1,16,1,1,16,1,17,17,1,4,1,4,0,16,1]

theorem envBound652 : H12AffineFastState.Bounded env652 := by
  intro p hp
  have h : env652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans651_652 : H12AffineEnvironment.transform 17 0 env651 = env652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env651 == env652) = true)

def leafEnv652 : List Nat := [0,4,0,16,0,16,1,4,1,4,0,17,0,16,0,1,17,0,4,0,16,1,16,1,4,1,1,16,1,17,17,1,4,1,4,0,4,0,16,1,0,16,1]

def active652 : List Nat := [1,3]

def tree652 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood652 : H12WitnessSearch.Good tree652 := H12GlobalWitnessIndex.good

theorem leafIdentity652 : H12AffineFastState.composeSystem env652 rootObs = leafEnv652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env652 rootObs == leafEnv652) = true)

theorem terminalChecked652 : H12PackedTerminal.terminalCheckFast leafEnv652 active652 tree652 = true := by decide +kernel

def env653 : List Nat := [2,4,2,16,1,19,3,256,1,256,0,18,2,16,260,262,18,262144,256,260,19,261,16,262,3,19,262145,17,17,260,4,1,256,0,19,1]

theorem envBound653 : H12AffineFastState.Bounded env653 := by
  intro p hp
  have h : env653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans648_653 : H12AffineEnvironment.transform 4 1 env648 = env653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env648 == env653) = true)

theorem identity653 : scanCanonicalize (H12AffineFastState.compose env653 (packedSelected [9,11] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound653 : packedSelected [9,11] rootPS < 2^1333 := by decide +kernel

def env654 : List Nat := [2,4,2,16,1,19,3,5,1,5,0,18,2,16,1,3,18,262144,5,1,19,0,16,3,3,19,262145,17,17,1,4,1,5,0,19,1]

theorem envBound654 : H12AffineFastState.Bounded env654 := by
  intro p hp
  have h : env654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans653_654 : H12AffineEnvironment.transform 7 5 env653 = env654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env653 == env654) = true)

theorem identity654 : scanCanonicalize (H12AffineFastState.compose env654 (packedSelected [5] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound654 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env655 : List Nat := [1,4,1,16,1,16,0,5,1,5,0,17,1,16,1,0,17,262144,5,1,16,0,16,0,0,16,262145,17,17,1,4,1,5,0,16,1]

theorem envBound655 : H12AffineFastState.Bounded env655 := by
  intro p hp
  have h : env655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans654_655 : H12AffineEnvironment.transform 0 1 env654 = env655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env654 == env655) = true)

theorem identity655 : scanCanonicalize (H12AffineFastState.compose env655 (packedSelected [9] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound655 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env656 : List Nat := [1,4,1,16,1,16,0,5,1,5,0,17,1,16,1,0,17,0,5,1,16,0,16,0,0,16,1,17,17,1,4,1,5,0,16,1]

theorem envBound656 : H12AffineFastState.Bounded env656 := by
  intro p hp
  have h : env656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans655_656 : H12AffineEnvironment.transform 17 0 env655 = env656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env655 == env656) = true)

def leafEnv656 : List Nat := [1,4,1,16,1,16,0,5,1,5,0,17,1,16,1,0,17,0,5,1,16,0,16,0,4,0,1,16,1,17,17,1,4,1,5,0,4,1,16,1,0,16,1]

def active656 : List Nat := [1,3]

def tree656 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood656 : H12WitnessSearch.Good tree656 := H12GlobalWitnessIndex.good

theorem leafIdentity656 : H12AffineFastState.composeSystem env656 rootObs = leafEnv656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env656 rootObs == leafEnv656) = true)

theorem terminalChecked656 : H12PackedTerminal.terminalCheckFast leafEnv656 active656 tree656 = true := by decide +kernel

def env657 : List Nat := [2,4,8,16,32,64,9,256,512,256,1,65,8,16,260,341,65,262144,256,260,64,261,16,341,9,64,262145,17,17,342,4,115,256,0,64,512]

theorem envBound657 : H12AffineFastState.Bounded env657 := by
  intro p hp
  have h : env657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans644_657 : H12AffineEnvironment.transform 10 1 env644 = env657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env644 == env657) = true)

theorem identity657 : scanCanonicalize (H12AffineFastState.compose env657 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound657 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env658 : List Nat := [2,4,8,16,32,64,9,36,512,36,1,65,8,16,32,113,65,262144,36,32,64,33,16,113,9,64,262145,17,17,114,4,115,36,0,64,512]

theorem envBound658 : H12AffineFastState.Bounded env658 := by
  intro p hp
  have h : env658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans657_658 : H12AffineEnvironment.transform 7 36 env657 = env658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env657 == env658) = true)

theorem identity658 : scanCanonicalize (H12AffineFastState.compose env658 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 115) := by decide +kernel

theorem selectedBound658 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env659 : List Nat := [2,4,8,16,32,64,9,36,115,36,1,65,8,16,32,113,65,262144,36,32,64,33,16,113,9,64,262145,17,17,114,4,115,36,0,64,115]

theorem envBound659 : H12AffineFastState.Bounded env659 := by
  intro p hp
  have h : env659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans658_659 : H12AffineEnvironment.transform 8 115 env658 = env659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 115 env658 == env659) = true)

theorem identity659 : scanCanonicalize (H12AffineFastState.compose env659 (packedSelected [4,11,18] rootPS)) = affineNative (2^(17+1) ^^^ 10) := by decide +kernel

theorem selectedBound659 : packedSelected [4,11,18] rootPS < 2^1333 := by decide +kernel

def env660 : List Nat := [2,4,8,16,32,64,9,36,115,36,1,65,8,16,32,113,65,10,36,32,64,33,16,113,9,64,11,17,17,114,4,115,36,0,64,115]

theorem envBound660 : H12AffineFastState.Bounded env660 := by
  intro p hp
  have h : env660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans659_660 : H12AffineEnvironment.transform 17 10 env659 = env660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 10 env659 == env660) = true)

theorem identity660 : scanCanonicalize (H12AffineFastState.compose env660 (packedSelected [4,11,23] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound660 : packedSelected [4,11,23] rootPS < 2^1333 := by decide +kernel

def env661 : List Nat := [2,4,3,16,32,64,2,36,115,36,1,65,3,16,32,113,65,1,36,32,64,33,16,113,2,64,0,17,17,114,4,115,36,0,64,115]

theorem envBound661 : H12AffineFastState.Bounded env661 := by
  intro p hp
  have h : env661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans660_661 : H12AffineEnvironment.transform 2 3 env660 = env661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env660 == env661) = true)

theorem identity661 : scanCanonicalize (H12AffineFastState.compose env661 (packedSelected [11] rootPS)) = affineNative (2^(5+1) ^^^ 50) := by decide +kernel

theorem selectedBound661 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env662 : List Nat := [2,4,3,16,32,50,2,36,1,36,1,51,3,16,32,3,51,1,36,32,50,33,16,3,2,50,0,17,17,0,4,1,36,0,50,1]

theorem envBound662 : H12AffineFastState.Bounded env662 := by
  intro p hp
  have h : env662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans661_662 : H12AffineEnvironment.transform 5 50 env661 = env662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 50 env661 == env662) = true)

theorem identity662 : scanCanonicalize (H12AffineFastState.compose env662 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 2) := by decide +kernel

theorem selectedBound662 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env663 : List Nat := [2,4,3,16,2,16,2,6,1,6,1,17,3,16,2,3,17,1,6,2,16,3,16,3,2,16,0,17,17,0,4,1,6,0,16,1]

theorem envBound663 : H12AffineFastState.Bounded env663 := by
  intro p hp
  have h : env663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans662_663 : H12AffineEnvironment.transform 4 2 env662 = env663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 2 env662 == env663) = true)

def leafEnv663 : List Nat := [2,4,3,16,2,16,2,6,1,6,1,17,3,16,2,3,17,1,6,2,16,3,16,3,4,2,1,16,0,17,17,0,4,1,6,0,4,2,16,1,0,16,1]

def active663 : List Nat := [0,1,3]

def tree663 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood663 : H12WitnessSearch.Good tree663 := H12GlobalWitnessIndex.good

theorem leafIdentity663 : H12AffineFastState.composeSystem env663 rootObs = leafEnv663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env663 rootObs == leafEnv663) = true)

theorem terminalChecked663 : H12PackedTerminal.terminalCheckFast leafEnv663 active663 tree663 = true := by decide +kernel

def env664 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,32768,65536,64,262144,257,32768,4097,4194304,16385,98564,33554432,4096,4477269,16385,16,4294794,5,4294967296,256,4332843383,65,33563272]

theorem envBound664 : H12AffineFastState.Bounded env664 := by
  intro p hp
  have h : env664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans585_664 : H12AffineEnvironment.transform 9 257 env585 = env664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env585 == env664) = true)

theorem identity664 : scanCanonicalize (H12AffineFastState.compose env664 (packedSelected [5,15,17,24] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound664 : packedSelected [5,15,17,24] rootPS < 2^1333 := by decide +kernel

def env665 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,32768,65536,64,262144,257,32768,4097,4194304,16385,98564,8329,4096,4477269,16385,16,4294794,5,4294967296,256,4299280894,65,513]

theorem envBound665 : H12AffineFastState.Bounded env665 := by
  intro p hp
  have h : env665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans664_665 : H12AffineEnvironment.transform 24 8329 env664 = env665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env664 == env665) = true)

theorem identity665 : scanCanonicalize (H12AffineFastState.compose env665 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound665 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env666 : List Nat := [2,4,8,16,32,64,128,256,137,257,2048,4096,8192,16384,32768,65536,64,262144,257,32768,4097,4194304,16385,98564,8329,4096,4477269,16385,16,4294794,5,4294967296,256,4299280894,65,136]

theorem envBound666 : H12AffineFastState.Bounded env666 := by
  intro p hp
  have h : env666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans665_666 : H12AffineEnvironment.transform 8 137 env665 = env666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env665 == env666) = true)

theorem identity666 : scanCanonicalize (H12AffineFastState.compose env666 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound666 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env667 : List Nat := [2,4,8,16,32,64,128,256,137,257,2048,4096,8192,4176,32768,65536,64,262144,257,32768,4097,4194304,4177,98564,8329,4096,4456709,4177,16,4294794,5,4294967296,256,4299260334,65,136]

theorem envBound667 : H12AffineFastState.Bounded env667 := by
  intro p hp
  have h : env667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans666_667 : H12AffineEnvironment.transform 13 4176 env666 = env667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env666 == env667) = true)

theorem identity667 : scanCanonicalize (H12AffineFastState.compose env667 (packedSelected [3,5,10] rootPS)) = affineNative (2^(21+1) ^^^ 476) := by decide +kernel

theorem selectedBound667 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env668 : List Nat := [2,4,8,16,32,64,128,256,137,257,2048,4096,8192,4176,32768,65536,64,262144,257,32768,4097,476,4177,98564,8329,4096,262361,4177,16,100694,5,4294967296,256,4295065714,65,136]

theorem envBound668 : H12AffineFastState.Bounded env668 := by
  intro p hp
  have h : env668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans667_668 : H12AffineEnvironment.transform 21 476 env667 = env668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 476 env667 == env668) = true)

theorem identity668 : scanCanonicalize (H12AffineFastState.compose env668 (packedSelected [1,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 12313) := by decide +kernel

theorem selectedBound668 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env669 : List Nat := [2,4,8,16,32,64,128,256,137,257,2048,4096,8192,4176,12313,65536,64,262144,257,12313,4097,476,4177,78109,8329,4096,262361,4177,16,80207,5,4294967296,256,4295045227,65,136]

theorem envBound669 : H12AffineFastState.Bounded env669 := by
  intro p hp
  have h : env669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans668_669 : H12AffineEnvironment.transform 14 12313 env668 = env669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 12313 env668 == env669) = true)

theorem identity669 : scanCanonicalize (H12AffineFastState.compose env669 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound669 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env670 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,4096,8192,4176,12313,65536,64,262144,4,12313,4097,217,4177,77848,8329,4096,262361,4177,16,79946,5,4294967296,5,4295045227,65,136]

theorem envBound670 : H12AffineFastState.Bounded env670 := by
  intro p hp
  have h : env670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans669_670 : H12AffineEnvironment.transform 7 5 env669 = env670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env669 == env670) = true)

theorem identity670 : scanCanonicalize (H12AffineFastState.compose env670 (packedSelected [1,8,12] rootPS)) = affineNative (2^(12+1) ^^^ 4120) := by decide +kernel

theorem selectedBound670 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env671 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,4096,4120,4176,1,65536,64,262144,4,1,4097,217,4177,65536,4241,4096,262361,4177,16,67666,5,4294967296,5,4295032947,65,136]

theorem envBound671 : H12AffineFastState.Bounded env671 := by
  intro p hp
  have h : env671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans670_671 : H12AffineEnvironment.transform 12 4120 env670 = env671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4120 env670 == env671) = true)

def env672 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,64,88,16,1,65536,64,262144,4,1,65,217,17,65536,209,64,262361,17,16,67666,5,4294967296,5,4295032947,65,136]

theorem envBound672 : H12AffineFastState.Bounded env672 := by
  intro p hp
  have h : env672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans671_672 : H12AffineEnvironment.transform 11 64 env671 = env672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 64 env671 == env672) = true)

theorem identity672 : scanCanonicalize (H12AffineFastState.compose env672 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262307) := by decide +kernel

theorem selectedBound672 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env673 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,64,88,16,1,65536,64,262144,4,1,65,217,17,65536,209,64,262361,17,16,67666,5,262307,5,327888,65,136]

theorem envBound673 : H12AffineFastState.Bounded env673 := by
  intro p hp
  have h : env673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans672_673 : H12AffineEnvironment.transform 31 262307 env672 = env673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262307 env672 == env673) = true)

def env674 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,64,88,16,1,65536,64,80,4,1,65,217,17,65536,209,64,137,17,16,67666,5,243,5,65664,65,136]

theorem envBound674 : H12AffineFastState.Bounded env674 := by
  intro p hp
  have h : env674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans673_674 : H12AffineEnvironment.transform 17 80 env673 = env674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 80 env673 == env674) = true)

def env675 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,64,88,16,1,65536,64,81,4,1,65,217,17,65536,209,64,136,17,16,67666,5,242,5,65665,65,136]

theorem envBound675 : H12AffineFastState.Bounded env675 := by
  intro p hp
  have h : env675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans673_675 : H12AffineEnvironment.transform 17 81 env673 = env675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 81 env673 == env675) = true)

theorem identity675 : scanCanonicalize (H12AffineFastState.compose env675 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound675 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env676 : List Nat := [2,4,8,16,32,64,88,5,81,4,2048,64,88,16,1,65536,64,81,4,1,65,1,17,65536,9,64,80,17,16,67666,5,42,5,65625,65,80]

theorem envBound676 : H12AffineFastState.Bounded env676 := by
  intro p hp
  have h : env676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans675_676 : H12AffineEnvironment.transform 6 88 env675 = env676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env675 == env676) = true)

theorem identity676 : scanCanonicalize (H12AffineFastState.compose env676 (packedSelected [1,2,3,4,8] rootPS)) = affineNative (2^(15+1) ^^^ 2163) := by decide +kernel

theorem selectedBound676 : packedSelected [1,2,3,4,8] rootPS < 2^1333 := by decide +kernel

def env677 : List Nat := [2,4,8,16,32,64,88,5,81,4,2048,64,88,16,1,2163,64,81,4,1,65,1,17,2163,9,64,80,17,16,33,5,42,5,2090,65,80]

theorem envBound677 : H12AffineFastState.Bounded env677 := by
  intro p hp
  have h : env677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans676_677 : H12AffineEnvironment.transform 15 2163 env676 = env677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2163 env676 == env677) = true)

theorem identity677 : scanCanonicalize (H12AffineFastState.compose env677 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound677 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env678 : List Nat := [2,4,8,16,32,64,88,5,81,4,33,64,88,16,1,82,64,81,4,1,65,1,17,82,9,64,80,17,16,33,5,42,5,11,65,80]

theorem envBound678 : H12AffineFastState.Bounded env678 := by
  intro p hp
  have h : env678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans677_678 : H12AffineEnvironment.transform 10 33 env677 = env678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env677 == env678) = true)

def env679 : List Nat := [2,4,8,16,0,64,88,5,81,4,1,64,88,16,1,82,64,81,4,1,65,1,17,82,9,64,80,17,16,1,5,10,5,11,65,80]

theorem envBound679 : H12AffineFastState.Bounded env679 := by
  intro p hp
  have h : env679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans678_679 : H12AffineEnvironment.transform 4 0 env678 = env679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env678 == env679) = true)

theorem identity679 : scanCanonicalize (H12AffineFastState.compose env679 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound679 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env680 : List Nat := [2,4,8,16,0,1,25,5,16,4,1,1,25,16,1,19,1,16,4,1,0,1,17,19,9,1,17,17,16,1,5,10,5,11,0,17]

theorem envBound680 : H12AffineFastState.Bounded env680 := by
  intro p hp
  have h : env680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans679_680 : H12AffineEnvironment.transform 5 1 env679 = env680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env679 == env680) = true)

def leafEnv680 : List Nat := [2,4,8,16,0,1,25,5,16,4,1,1,25,16,1,19,1,16,4,1,0,1,17,19,5,9,1,1,17,17,16,1,5,10,5,11,4,3,0,17,0,17,1]

def active680 : List Nat := [0,1,2,3]

def tree680 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood680 : H12WitnessSearch.Good tree680 := H12GlobalWitnessIndex.good

theorem leafIdentity680 : H12AffineFastState.composeSystem env680 rootObs = leafEnv680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env680 rootObs == leafEnv680) = true)

theorem terminalChecked680 : H12PackedTerminal.terminalCheckFast leafEnv680 active680 tree680 = true := by decide +kernel

def env681 : List Nat := [2,4,8,16,1,64,88,5,81,4,0,64,88,16,1,82,64,81,4,1,65,1,17,82,9,64,80,17,16,0,5,11,5,11,65,80]

theorem envBound681 : H12AffineFastState.Bounded env681 := by
  intro p hp
  have h : env681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans678_681 : H12AffineEnvironment.transform 4 1 env678 = env681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env678 == env681) = true)

theorem identity681 : scanCanonicalize (H12AffineFastState.compose env681 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound681 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env682 : List Nat := [2,4,8,16,1,10,18,5,27,4,0,10,18,16,1,24,10,27,4,1,11,1,17,24,9,10,26,17,16,0,5,11,5,11,11,26]

theorem envBound682 : H12AffineFastState.Bounded env682 := by
  intro p hp
  have h : env682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans681_682 : H12AffineEnvironment.transform 5 10 env681 = env682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env681 == env682) = true)

def leafEnv682 : List Nat := [2,4,8,16,1,10,18,5,27,4,0,10,18,16,1,24,10,27,4,1,11,1,17,24,5,9,1,10,26,17,16,0,5,11,5,11,4,3,11,26,0,17,1]

def active682 : List Nat := [0,1,2,3]

def tree682 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood682 : H12WitnessSearch.Good tree682 := H12GlobalWitnessIndex.good

theorem leafIdentity682 : H12AffineFastState.composeSystem env682 rootObs = leafEnv682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env682 rootObs == leafEnv682) = true)

theorem terminalChecked682 : H12PackedTerminal.terminalCheckFast leafEnv682 active682 tree682 = true := by decide +kernel

def env683 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,65,89,17,1,65536,64,262144,4,1,64,217,16,65536,208,65,262361,16,16,67666,5,4294967296,5,4295032947,65,136]

theorem envBound683 : H12AffineFastState.Bounded env683 := by
  intro p hp
  have h : env683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans671_683 : H12AffineEnvironment.transform 11 65 env671 = env683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 65 env671 == env683) = true)

theorem identity683 : scanCanonicalize (H12AffineFastState.compose env683 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262386) := by decide +kernel

theorem selectedBound683 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env684 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,65,89,17,1,65536,64,262144,4,1,64,217,16,65536,208,65,262361,16,16,67666,5,262386,5,327809,65,136]

theorem envBound684 : H12AffineFastState.Bounded env684 := by
  intro p hp
  have h : env684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans683_684 : H12AffineEnvironment.transform 31 262386 env683 = env684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262386 env683 == env684) = true)

def env685 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,65,89,17,1,65536,64,80,4,1,64,217,16,65536,208,65,137,16,16,67666,5,162,5,65745,65,136]

theorem envBound685 : H12AffineFastState.Bounded env685 := by
  intro p hp
  have h : env685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans684_685 : H12AffineEnvironment.transform 17 80 env684 = env685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 80 env684 == env685) = true)

theorem identity685 : scanCanonicalize (H12AffineFastState.compose env685 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound685 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env686 : List Nat := [2,4,8,16,32,64,88,5,81,4,2048,65,89,17,1,65536,64,80,4,1,64,1,16,65536,8,65,81,16,16,67666,5,122,5,65545,65,80]

theorem envBound686 : H12AffineFastState.Bounded env686 := by
  intro p hp
  have h : env686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans685_686 : H12AffineEnvironment.transform 6 88 env685 = env686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env685 == env686) = true)

theorem identity686 : scanCanonicalize (H12AffineFastState.compose env686 (packedSelected [1,2,3,4,8] rootPS)) = affineNative (2^(15+1) ^^^ 2163) := by decide +kernel

theorem selectedBound686 : packedSelected [1,2,3,4,8] rootPS < 2^1333 := by decide +kernel

def env687 : List Nat := [2,4,8,16,32,64,88,5,81,4,2048,65,89,17,1,2163,64,80,4,1,64,1,16,2163,8,65,81,16,16,33,5,122,5,2170,65,80]

theorem envBound687 : H12AffineFastState.Bounded env687 := by
  intro p hp
  have h : env687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans686_687 : H12AffineEnvironment.transform 15 2163 env686 = env687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2163 env686 == env687) = true)

theorem identity687 : scanCanonicalize (H12AffineFastState.compose env687 (packedSelected [2,4] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound687 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env688 : List Nat := [2,4,8,16,32,64,88,5,81,4,33,65,89,17,1,82,64,80,4,1,64,1,16,82,8,65,81,16,16,33,5,122,5,91,65,80]

theorem envBound688 : H12AffineFastState.Bounded env688 := by
  intro p hp
  have h : env688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans687_688 : H12AffineEnvironment.transform 10 33 env687 = env688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env687 == env688) = true)

def env689 : List Nat := [2,4,8,16,0,64,88,5,81,4,1,65,89,17,1,82,64,80,4,1,64,1,16,82,8,65,81,16,16,1,5,90,5,91,65,80]

theorem envBound689 : H12AffineFastState.Bounded env689 := by
  intro p hp
  have h : env689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans688_689 : H12AffineEnvironment.transform 4 0 env688 = env689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env688 == env689) = true)

theorem identity689 : scanCanonicalize (H12AffineFastState.compose env689 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound689 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env690 : List Nat := [2,4,8,1,0,64,73,5,64,4,1,65,72,0,1,67,64,65,4,1,64,1,1,67,8,65,64,1,1,1,5,75,5,74,65,65]

theorem envBound690 : H12AffineFastState.Bounded env690 := by
  intro p hp
  have h : env690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans689_690 : H12AffineEnvironment.transform 3 1 env689 = env690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env689 == env690) = true)

def leafEnv690 : List Nat := [2,4,8,1,0,64,73,5,64,4,1,65,72,0,1,67,64,65,4,1,64,1,1,67,5,8,1,65,64,1,1,1,5,75,5,74,4,3,65,65,0,0,1]

def active690 : List Nat := [0,1,2,5]

def tree690 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood690 : H12WitnessSearch.Good tree690 := H12GlobalWitnessIndex.good

theorem leafIdentity690 : H12AffineFastState.composeSystem env690 rootObs = leafEnv690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env690 rootObs == leafEnv690) = true)

theorem terminalChecked690 : H12PackedTerminal.terminalCheckFast leafEnv690 active690 tree690 = true := by decide +kernel

def env691 : List Nat := [2,4,8,16,1,64,88,5,81,4,0,65,89,17,1,82,64,80,4,1,64,1,16,82,8,65,81,16,16,0,5,91,5,91,65,80]

theorem envBound691 : H12AffineFastState.Bounded env691 := by
  intro p hp
  have h : env691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans688_691 : H12AffineEnvironment.transform 4 1 env688 = env691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env688 == env691) = true)

theorem identity691 : scanCanonicalize (H12AffineFastState.compose env691 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound691 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env692 : List Nat := [2,4,8,16,1,10,18,5,27,4,0,11,19,17,1,24,10,26,4,1,10,1,16,24,8,11,27,16,16,0,5,17,5,17,11,26]

theorem envBound692 : H12AffineFastState.Bounded env692 := by
  intro p hp
  have h : env692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans691_692 : H12AffineEnvironment.transform 5 10 env691 = env692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env691 == env692) = true)

def leafEnv692 : List Nat := [2,4,8,16,1,10,18,5,27,4,0,11,19,17,1,24,10,26,4,1,10,1,16,24,5,8,1,11,27,16,16,0,5,17,5,17,4,3,11,26,0,17,1]

def active692 : List Nat := [0,1,2,3]

def tree692 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood692 : H12WitnessSearch.Good tree692 := H12GlobalWitnessIndex.good

theorem leafIdentity692 : H12AffineFastState.composeSystem env692 rootObs = leafEnv692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env692 rootObs == leafEnv692) = true)

theorem terminalChecked692 : H12PackedTerminal.terminalCheckFast leafEnv692 active692 tree692 = true := by decide +kernel

def env693 : List Nat := [2,4,8,16,32,64,128,5,137,4,2048,65,89,17,1,65536,64,81,4,1,64,217,16,65536,208,65,136,16,16,67666,5,163,5,65744,65,136]

theorem envBound693 : H12AffineFastState.Bounded env693 := by
  intro p hp
  have h : env693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans684_693 : H12AffineEnvironment.transform 17 81 env684 = env693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 81 env684 == env693) = true)

def env694 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4097,4194304,17664,16777216,33554432,16880645,21352529,16892165,1297,1073741824,16876544,4294967296,256,4332843382,1344,33563272]

theorem envBound694 : H12AffineFastState.Bounded env694 := by
  intro p hp
  have h : env694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans582_694 : H12AffineEnvironment.transform 18 1025 env582 = env694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env582 == env694) = true)

theorem identity694 : scanCanonicalize (H12AffineFastState.compose env694 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 20994527) := by decide +kernel

theorem selectedBound694 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env695 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4097,4194304,17664,16777216,33554432,16880645,21352529,16892165,1297,20994527,16876544,4294967296,256,4332843382,1344,33563272]

theorem envBound695 : H12AffineFastState.Bounded env695 := by
  intro p hp
  have h : env695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans694_695 : H12AffineEnvironment.transform 29 20994527 env694 = env695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 20994527 env694 == env695) = true)

theorem identity695 : scanCanonicalize (H12AffineFastState.compose env695 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(24+1) ^^^ 28889) := by decide +kernel

theorem selectedBound695 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env696 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4097,4194304,17664,16777216,28889,16880645,21352529,16892165,1297,20994527,16876544,4294967296,256,4299260335,1344,21073]

theorem envBound696 : H12AffineFastState.Bounded env696 := by
  intro p hp
  have h : env696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans695_696 : H12AffineEnvironment.transform 24 28889 env695 = env696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 28889 env695 == env696) = true)

theorem identity696 : scanCanonicalize (H12AffineFastState.compose env696 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound696 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env697 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4097,4194304,17664,98564,28889,5377,4477269,16385,1297,4315355,1284,4294967296,256,4299260335,1344,21073]

theorem envBound697 : H12AffineFastState.Bounded env697 := by
  intro p hp
  have h : env697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans696_697 : H12AffineEnvironment.transform 23 98564 env696 = env697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env696 == env697) = true)

def env698 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4096,32768,65536,1345,262144,1025,32768,4097,4194304,5376,98564,8409,5377,4456789,4097,1297,4294875,1284,4294967296,256,4299260335,1344,593]

theorem envBound698 : H12AffineFastState.Bounded env698 := by
  intro p hp
  have h : env698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans697_698 : H12AffineEnvironment.transform 13 4096 env697 = env698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env697 == env698) = true)

theorem identity698 : scanCanonicalize (H12AffineFastState.compose env698 (packedSelected [3,4,9,10,15,16,17,24] rootPS)) = affineNative (2^(14+1) ^^^ 13972) := by decide +kernel

theorem selectedBound698 : packedSelected [3,4,9,10,15,16,17,24] rootPS < 2^1333 := by decide +kernel

def env699 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4096,13972,65536,1345,262144,1025,13972,4097,4194304,5376,79760,8409,5377,4456789,4097,1297,4275791,1284,4294967296,256,4299241275,1344,593]

theorem envBound699 : H12AffineFastState.Bounded env699 := by
  intro p hp
  have h : env699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans698_699 : H12AffineEnvironment.transform 14 13972 env698 = env699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13972 env698 == env699) = true)

def env700 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,13972,65536,1297,262144,1025,13972,4097,4194304,5376,79760,8329,5377,4456709,4097,1297,4275743,1284,4294967296,256,4299241275,1296,513]

theorem envBound700 : H12AffineFastState.Bounded env700 := by
  intro p hp
  have h : env700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans699_700 : H12AffineEnvironment.transform 5 16 env699 = env700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env699 == env700) = true)

theorem identity700 : scanCanonicalize (H12AffineFastState.compose env700 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound700 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env701 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,65536,1297,262144,1025,13341,4097,4194304,5376,79129,8329,5377,4456709,4097,1297,4275350,1284,4294967296,256,4299240882,1296,136]

theorem envBound701 : H12AffineFastState.Bounded env701 := by
  intro p hp
  have h : env701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans700_701 : H12AffineEnvironment.transform 8 137 env700 = env701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env700 == env701) = true)

theorem identity701 : scanCanonicalize (H12AffineFastState.compose env701 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(31+1) ^^^ 4273319) := by decide +kernel

theorem selectedBound701 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env702 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,65536,1297,262144,1025,13341,4097,4194304,5376,79129,8329,5377,4456709,4097,1297,4275350,1284,4273319,256,277,1296,136]

theorem envBound702 : H12AffineFastState.Bounded env702 := by
  intro p hp
  have h : env702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans701_702 : H12AffineEnvironment.transform 31 4273319 env701 = env702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4273319 env701 == env702) = true)

theorem identity702 : scanCanonicalize (H12AffineFastState.compose env702 (packedSelected [6,8,13] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound702 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env703 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,65536,1297,262144,1025,13341,4097,397,5376,79129,8329,5377,262280,4097,1297,81179,1284,79146,256,277,1296,136]

theorem envBound703 : H12AffineFastState.Bounded env703 := by
  intro p hp
  have h : env703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans702_703 : H12AffineEnvironment.transform 21 397 env702 = env703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env702 == env703) = true)

theorem identity703 : scanCanonicalize (H12AffineFastState.compose env703 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 65940) := by decide +kernel

theorem selectedBound703 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env704 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,65536,1297,65940,1025,13341,4097,397,5376,79129,8329,5377,65820,4097,1297,81179,1284,79146,256,277,1296,136]

theorem envBound704 : H12AffineFastState.Bounded env704 := by
  intro p hp
  have h : env704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans703_704 : H12AffineEnvironment.transform 17 65940 env703 = env704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 65940 env703 == env704) = true)

def env705 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,8208,1297,8580,1025,13341,4097,397,5376,5385,8329,5377,8460,4097,1297,7435,1284,5434,256,277,1296,136]

theorem envBound705 : H12AffineFastState.Bounded env705 := by
  intro p hp
  have h : env705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans704_705 : H12AffineEnvironment.transform 15 8208 env704 = env705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8208 env704 == env705) = true)

def env706 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,8209,1297,8581,1025,13341,4097,397,5376,5384,8329,5377,8461,4097,1297,7434,1284,5435,256,277,1296,136]

theorem envBound706 : H12AffineFastState.Bounded env706 := by
  intro p hp
  have h : env706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans704_706 : H12AffineEnvironment.transform 15 8209 env704 = env706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8209 env704 == env706) = true)

theorem identity706 : scanCanonicalize (H12AffineFastState.compose env706 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound706 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env707 : List Nat := [2,4,8,16,32,16,9,256,0,1024,2048,4096,8192,4096,13341,8209,1297,8460,1025,13341,4097,260,5376,5384,8192,5377,8461,4097,1297,7434,1284,5435,256,277,1296,1]

theorem envBound707 : H12AffineFastState.Bounded env707 := by
  intro p hp
  have h : env707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans706_707 : H12AffineEnvironment.transform 6 9 env706 = env707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env706 == env707) = true)

def env708 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,4096,8192,4096,13341,8209,1297,8460,1025,13341,4097,260,5376,5384,8192,5377,8461,4097,1297,5386,1284,5435,256,277,1296,1]

theorem envBound708 : H12AffineFastState.Bounded env708 := by
  intro p hp
  have h : env708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans707_708 : H12AffineEnvironment.transform 10 0 env707 = env708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env707 == env708) = true)

theorem identity708 : scanCanonicalize (H12AffineFastState.compose env708 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 50) := by decide +kernel

theorem selectedBound708 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env709 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,4096,50,4096,5167,35,1297,318,1025,5167,4097,260,5376,5384,50,5377,319,4097,1297,5386,1284,5435,256,277,1296,1]

theorem envBound709 : H12AffineFastState.Bounded env709 := by
  intro p hp
  have h : env709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans708_709 : H12AffineEnvironment.transform 12 50 env708 = env709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 50 env708 == env709) = true)

theorem identity709 : scanCanonicalize (H12AffineFastState.compose env709 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1290) := by decide +kernel

theorem selectedBound709 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env710 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,1290,50,1290,293,35,1297,318,1025,293,1291,260,10,2,50,11,319,1291,1297,0,1284,49,256,277,1296,1]

theorem envBound710 : H12AffineFastState.Bounded env710 := by
  intro p hp
  have h : env710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans709_710 : H12AffineEnvironment.transform 11 1290 env709 = env710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1290 env709 == env710) = true)

def env711 : List Nat := [2,4,8,0,32,0,9,256,0,1024,0,1290,34,1290,293,35,1281,302,1025,293,1291,260,10,2,34,11,303,1291,1281,0,1284,33,256,261,1280,1]

theorem envBound711 : H12AffineFastState.Bounded env711 := by
  intro p hp
  have h : env711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans710_711 : H12AffineEnvironment.transform 3 0 env710 = env711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env710 == env711) = true)

def leafEnv711 : List Nat := [2,4,8,0,32,0,9,256,0,1024,0,1290,34,1290,293,35,1281,302,1025,293,1291,260,10,2,1285,34,1,11,303,1291,1281,0,1284,33,256,261,4,34,1280,1,0,1280,1]

def active711 : List Nat := [0,1,2,4,7,9]

def tree711 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood711 : H12WitnessSearch.Good tree711 := H12GlobalWitnessIndex.good

theorem leafIdentity711 : H12AffineFastState.composeSystem env711 rootObs = leafEnv711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env711 rootObs == leafEnv711) = true)

theorem terminalChecked711 : H12PackedTerminal.terminalCheckFast leafEnv711 active711 tree711 = true := by decide +kernel

def env712 : List Nat := [2,4,8,1,32,1,9,256,0,1024,0,1290,35,1290,293,35,1280,303,1025,293,1291,260,10,2,35,11,302,1291,1280,0,1284,32,256,260,1281,1]

theorem envBound712 : H12AffineFastState.Bounded env712 := by
  intro p hp
  have h : env712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans710_712 : H12AffineEnvironment.transform 3 1 env710 = env712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env710 == env712) = true)

theorem identity712 : scanCanonicalize (H12AffineFastState.compose env712 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound712 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env713 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1070,35,1070,1,35,1060,11,1025,1,1071,32,10,2,35,11,10,1071,1060,0,1056,32,36,32,1061,1]

theorem envBound713 : H12AffineFastState.Bounded env713 := by
  intro p hp
  have h : env713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans712_713 : H12AffineEnvironment.transform 7 36 env712 = env713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env712 == env713) = true)

def leafEnv713 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1070,35,1070,1,35,1060,11,1025,1,1071,32,10,2,1057,35,1,11,10,1071,1060,0,1056,32,36,32,4,34,1061,1,0,1061,1]

def active713 : List Nat := [0,1,2,4,9]

def tree713 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood713 : H12WitnessSearch.Good tree713 := H12GlobalWitnessIndex.good

theorem leafIdentity713 : H12AffineFastState.composeSystem env713 rootObs = leafEnv713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env713 rootObs == leafEnv713) = true)

theorem terminalChecked713 : H12PackedTerminal.terminalCheckFast leafEnv713 active713 tree713 = true := by decide +kernel

def env714 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,4096,8192,4096,13341,8209,1297,8460,1025,13341,4097,260,5376,5384,8192,5377,8461,4097,1297,5387,1284,5435,256,277,1296,1]

theorem envBound714 : H12AffineFastState.Bounded env714 := by
  intro p hp
  have h : env714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2