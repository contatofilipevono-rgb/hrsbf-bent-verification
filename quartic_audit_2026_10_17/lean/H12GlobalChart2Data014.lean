import H12GlobalChart2Data013

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def active3402 : List Nat := [0,1]

def tree3402 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3402 : H12WitnessSearch.Good tree3402 := H12GlobalWitnessIndex.good

theorem leafIdentity3402 : H12AffineFastState.composeSystem env3402 rootObs = leafEnv3402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3402 rootObs == leafEnv3402) = true)

theorem terminalChecked3402 : H12PackedTerminal.terminalCheckFast leafEnv3402 active3402 tree3402 = true := by decide +kernel

def env3403 : List Nat := [2,4,2,16,32,64,2,36,1,103,80,3,114,114,80,114,3,80,103,80,34,32,48,2,114,96,80,82,82,80,71,32,36,32,2,1]

theorem envBound3403 : H12AffineFastState.Bounded env3403 := by
  intro p hp
  have h : env3403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3397_3403 : H12AffineEnvironment.transform 8 1 env3397 = env3403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env3397 == env3403) = true)

theorem identity3403 : scanCanonicalize (H12AffineFastState.compose env3403 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 34) := by decide +kernel

theorem selectedBound3403 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3404 : List Nat := [2,4,2,16,32,34,2,36,1,5,50,3,16,16,50,16,3,50,5,50,34,32,48,2,16,2,50,48,48,50,37,32,36,32,2,1]

theorem envBound3404 : H12AffineFastState.Bounded env3404 := by
  intro p hp
  have h : env3404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3403_3404 : H12AffineEnvironment.transform 5 34 env3403 = env3404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 34 env3403 == env3404) = true)

def env3405 : List Nat := [2,4,2,16,0,2,2,4,1,5,18,3,16,16,18,16,3,18,5,18,2,0,16,2,16,2,18,16,16,18,5,0,4,0,2,1]

theorem envBound3405 : H12AffineFastState.Bounded env3405 := by
  intro p hp
  have h : env3405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3404_3405 : H12AffineEnvironment.transform 4 0 env3404 = env3405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3404 == env3405) = true)

theorem identity3405 : scanCanonicalize (H12AffineFastState.compose env3405 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3405 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3406 : List Nat := [2,4,2,2,0,2,2,4,1,5,0,3,2,2,0,2,3,0,5,0,2,0,2,2,2,2,0,2,2,0,5,0,4,0,2,1]

theorem envBound3406 : H12AffineFastState.Bounded env3406 := by
  intro p hp
  have h : env3406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3405_3406 : H12AffineEnvironment.transform 3 2 env3405 = env3406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3405 == env3406) = true)

def leafEnv3406 : List Nat := [2,4,2,2,0,2,2,4,1,5,0,3,2,2,0,2,3,0,5,0,2,0,2,2,5,2,1,2,0,2,2,0,5,0,4,0,4,2,2,1,0,2,1]

def active3406 : List Nat := [0,1]

def tree3406 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3406 : H12WitnessSearch.Good tree3406 := H12GlobalWitnessIndex.good

theorem leafIdentity3406 : H12AffineFastState.composeSystem env3406 rootObs = leafEnv3406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3406 rootObs == leafEnv3406) = true)

theorem terminalChecked3406 : H12PackedTerminal.terminalCheckFast leafEnv3406 active3406 tree3406 = true := by decide +kernel

def env3407 : List Nat := [2,4,2,16,1,3,2,5,1,5,19,3,16,16,19,16,3,19,5,19,3,1,17,2,16,2,19,17,17,19,4,1,5,1,2,1]

theorem envBound3407 : H12AffineFastState.Bounded env3407 := by
  intro p hp
  have h : env3407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3404_3407 : H12AffineEnvironment.transform 4 1 env3404 = env3407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3404 == env3407) = true)

def leafEnv3407 : List Nat := [2,4,2,16,1,3,2,5,1,5,19,3,16,16,19,16,3,19,5,19,3,1,17,2,4,16,1,2,19,17,17,19,4,1,5,1,4,16,2,1,0,17,1]

def active3407 : List Nat := [0,1,3]

def tree3407 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3407 : H12WitnessSearch.Good tree3407 := H12GlobalWitnessIndex.good

theorem leafIdentity3407 : H12AffineFastState.composeSystem env3407 rootObs = leafEnv3407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3407 rootObs == leafEnv3407) = true)

theorem terminalChecked3407 : H12PackedTerminal.terminalCheckFast leafEnv3407 active3407 tree3407 = true := by decide +kernel

def env3408 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,4096,8192,16384,8460,65536,11341,2048,524288,8460,16464,10248,17665,67845,8193,17745,2049,4177,11292,65799,11273,4294967296,256,4295566638,11340,512]

theorem envBound3408 : H12AffineFastState.Bounded env3408 := by
  intro p hp
  have h : env3408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3386_3408 : H12AffineEnvironment.transform 6 9 env3386 = env3408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env3386 == env3408) = true)

theorem identity3408 : scanCanonicalize (H12AffineFastState.compose env3408 (packedSelected [16,20] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3408 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env3409 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,4096,8192,16384,8232,65536,11341,2048,524288,8232,16464,10248,17445,67617,8193,17525,2049,4177,11292,65571,11273,4294967296,36,4295566346,11340,512]

theorem envBound3409 : H12AffineFastState.Bounded env3409 := by
  intro p hp
  have h : env3409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3408_3409 : H12AffineEnvironment.transform 7 36 env3408 = env3409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3408 == env3409) = true)

theorem identity3409 : scanCanonicalize (H12AffineFastState.compose env3409 (packedSelected [0,4,7,11,22,32] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound3409 : packedSelected [0,4,7,11,22,32] rootPS < 2^1333 := by decide +kernel

def env3410 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,4096,8192,16384,8232,2082,11341,2048,524288,8232,16464,10248,17445,3,8193,17525,2049,4177,11292,2049,11273,4294967296,36,4295502888,11340,512]

theorem envBound3410 : H12AffineFastState.Bounded env3410 := by
  intro p hp
  have h : env3410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3409_3410 : H12AffineEnvironment.transform 15 2082 env3409 = env3410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env3409 == env3410) = true)

theorem identity3410 : scanCanonicalize (H12AffineFastState.compose env3410 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 539239) := by decide +kernel

theorem selectedBound3410 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env3411 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,4096,8192,16384,8232,2082,11341,2048,524288,8232,16464,10248,17445,3,8193,17525,2049,4177,11292,2049,11273,539239,36,5711,11340,512]

theorem envBound3411 : H12AffineFastState.Bounded env3411 := by
  intro p hp
  have h : env3411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3410_3411 : H12AffineEnvironment.transform 31 539239 env3410 = env3411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 539239 env3410 == env3411) = true)

theorem identity3411 : scanCanonicalize (H12AffineFastState.compose env3411 (packedSelected [12,15] rootPS)) = affineNative (2^(13+1) ^^^ 1125) := by decide +kernel

theorem selectedBound3411 : packedSelected [12,15] rootPS < 2^1333 := by decide +kernel

def env3412 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,4096,8192,1125,8232,2082,11341,2048,524288,8232,1077,10248,64,3,8193,16,2049,4177,11292,2049,11273,539239,36,5711,11340,512]

theorem envBound3412 : H12AffineFastState.Bounded env3412 := by
  intro p hp
  have h : env3412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3411_3412 : H12AffineEnvironment.transform 13 1125 env3411 = env3412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1125 env3411 == env3412) = true)

theorem identity3412 : scanCanonicalize (H12AffineFastState.compose env3412 (packedSelected [0,1,2,3,4] rootPS)) = affineNative (2^(12+1) ^^^ 2089) := by decide +kernel

theorem selectedBound3412 : packedSelected [0,1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env3413 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,4096,2089,1125,2049,2082,1124,2048,524288,2049,1077,33,64,3,2088,16,2049,4177,1077,2049,1056,528974,36,5711,1125,512]

theorem envBound3413 : H12AffineFastState.Bounded env3413 := by
  intro p hp
  have h : env3413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3412_3413 : H12AffineEnvironment.transform 12 2089 env3412 = env3413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2089 env3412 == env3413) = true)

theorem identity3413 : scanCanonicalize (H12AffineFastState.compose env3413 (packedSelected [1,3] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound3413 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3414 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,4096,2089,1125,2049,2082,1124,2048,1024,2049,1077,33,64,3,2088,16,2049,4177,1077,2049,1056,5710,36,5711,1125,512]

theorem envBound3414 : H12AffineFastState.Bounded env3414 := by
  intro p hp
  have h : env3414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3413_3414 : H12AffineEnvironment.transform 18 1024 env3413 = env3414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env3413 == env3414) = true)

theorem identity3414 : scanCanonicalize (H12AffineFastState.compose env3414 (packedSelected [1,5] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound3414 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env3415 : List Nat := [2,4,8,16,32,64,9,36,512,1024,2048,1077,2089,1125,2049,2082,1124,2048,1024,2049,1077,33,64,3,2088,16,2049,1124,1077,2049,1056,635,36,634,1125,512]

theorem envBound3415 : H12AffineFastState.Bounded env3415 := by
  intro p hp
  have h : env3415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3414_3415 : H12AffineEnvironment.transform 11 1077 env3414 = env3415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env3414 == env3415) = true)

theorem identity3415 : scanCanonicalize (H12AffineFastState.compose env3415 (packedSelected [0] rootPS)) = affineNative (2^(8+1) ^^^ 56) := by decide +kernel

theorem selectedBound3415 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3416 : List Nat := [2,4,8,16,32,64,9,36,56,1024,2048,1077,2089,1125,2049,2082,1124,2048,1024,2049,1077,33,64,3,2088,16,2049,1124,1077,2049,1056,67,36,66,1125,56]

theorem envBound3416 : H12AffineFastState.Bounded env3416 := by
  intro p hp
  have h : env3416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3415_3416 : H12AffineEnvironment.transform 8 56 env3415 = env3416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 56 env3415 == env3416) = true)

theorem identity3416 : scanCanonicalize (H12AffineFastState.compose env3416 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 41) := by decide +kernel

theorem selectedBound3416 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3417 : List Nat := [2,4,8,16,32,41,9,36,56,1024,2048,1077,2089,1036,2049,2082,1037,2048,1024,2049,1077,33,41,3,2088,16,2049,1037,1077,2049,1056,42,36,43,1036,56]

theorem envBound3417 : H12AffineFastState.Bounded env3417 := by
  intro p hp
  have h : env3417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3416_3417 : H12AffineEnvironment.transform 5 41 env3416 = env3417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 41 env3416 == env3417) = true)

theorem identity3417 : scanCanonicalize (H12AffineFastState.compose env3417 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3417 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3418 : List Nat := [2,4,8,2,32,41,9,36,42,1024,2048,1063,2089,1036,2049,2082,1037,2048,1024,2049,1063,33,41,3,2088,2,2049,1037,1063,2049,1056,42,36,43,1036,42]

theorem envBound3418 : H12AffineFastState.Bounded env3418 := by
  intro p hp
  have h : env3418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3417_3418 : H12AffineEnvironment.transform 3 2 env3417 = env3418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3417 == env3418) = true)

theorem identity3418 : scanCanonicalize (H12AffineFastState.compose env3418 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound3418 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3419 : List Nat := [2,4,8,2,32,41,9,36,42,1024,33,1063,8,1036,32,3,1037,33,1024,32,1063,33,41,3,9,2,32,1037,1063,32,1056,42,36,43,1036,42]

theorem envBound3419 : H12AffineFastState.Bounded env3419 := by
  intro p hp
  have h : env3419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3418_3419 : H12AffineEnvironment.transform 10 33 env3418 = env3419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env3418 == env3419) = true)

theorem identity3419 : scanCanonicalize (H12AffineFastState.compose env3419 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound3419 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env3420 : List Nat := [2,4,8,2,32,41,9,36,42,15,33,40,8,3,32,3,2,33,15,32,40,33,41,3,9,2,32,2,40,32,47,42,36,43,3,42]

theorem envBound3420 : H12AffineFastState.Bounded env3420 := by
  intro p hp
  have h : env3420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3419_3420 : H12AffineEnvironment.transform 9 15 env3419 = env3420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env3419 == env3420) = true)

theorem identity3420 : scanCanonicalize (H12AffineFastState.compose env3420 (packedSelected [13] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound3420 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env3421 : List Nat := [2,4,8,2,10,3,9,14,0,15,11,2,8,3,10,3,2,11,15,10,2,11,3,3,9,2,10,2,2,10,5,0,14,1,3,0]

theorem envBound3421 : H12AffineFastState.Bounded env3421 := by
  intro p hp
  have h : env3421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3420_3421 : H12AffineEnvironment.transform 4 10 env3420 = env3421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env3420 == env3421) = true)

def leafEnv3421 : List Nat := [2,4,8,2,10,3,9,14,0,15,11,2,8,3,10,3,2,11,15,10,2,11,3,3,5,9,1,2,10,2,2,10,5,0,14,1,4,2,3,0,0,2,1]

def active3421 : List Nat := [0,1,2]

def tree3421 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3421 : H12WitnessSearch.Good tree3421 := H12GlobalWitnessIndex.good

theorem leafIdentity3421 : H12AffineFastState.composeSystem env3421 rootObs = leafEnv3421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3421 rootObs == leafEnv3421) = true)

theorem terminalChecked3421 : H12PackedTerminal.terminalCheckFast leafEnv3421 active3421 tree3421 = true := by decide +kernel

def env3422 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,11460,2049,524288,8460,16464,10248,17665,67980,8328,17745,2185,4177,11413,65934,11392,4294967296,256,4295566638,11461,512]

theorem envBound3422 : H12AffineFastState.Bounded env3422 := by
  intro p hp
  have h : env3422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3385_3422 : H12AffineEnvironment.transform 17 2049 env3385 = env3422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2049 env3385 == env3422) = true)

theorem identity3422 : scanCanonicalize (H12AffineFastState.compose env3422 (packedSelected [0,4,7,11,16,22,23] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound3422 : packedSelected [0,4,7,11,16,22,23] rootPS < 2^1333 := by decide +kernel

def env3423 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,16384,8233,65536,11460,2049,524288,8233,16464,10248,17444,67753,8328,17524,2185,4177,11413,65707,11392,4294967296,37,4295566347,11461,512]

theorem envBound3423 : H12AffineFastState.Bounded env3423 := by
  intro p hp
  have h : env3423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3422_3423 : H12AffineEnvironment.transform 7 37 env3422 = env3423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env3422 == env3423) = true)

theorem identity3423 : scanCanonicalize (H12AffineFastState.compose env3423 (packedSelected [0,4,7,11,16,20,22,32] rootPS)) = affineNative (2^(15+1) ^^^ 2083) := by decide +kernel

theorem selectedBound3423 : packedSelected [0,4,7,11,16,20,22,32] rootPS < 2^1333 := by decide +kernel

def env3424 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,16384,8233,2083,11460,2049,524288,8233,16464,10248,17444,138,8328,17524,2185,4177,11413,2184,11392,4294967296,37,4295502888,11461,512]

theorem envBound3424 : H12AffineFastState.Bounded env3424 := by
  intro p hp
  have h : env3424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3423_3424 : H12AffineEnvironment.transform 15 2083 env3423 = env3424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2083 env3423 == env3424) = true)

theorem identity3424 : scanCanonicalize (H12AffineFastState.compose env3424 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 539374) := by decide +kernel

theorem selectedBound3424 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env3425 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,16384,8233,2083,11460,2049,524288,8233,16464,10248,17444,138,8328,17524,2185,4177,11413,2184,11392,539374,37,5830,11461,512]

theorem envBound3425 : H12AffineFastState.Bounded env3425 := by
  intro p hp
  have h : env3425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3424_3425 : H12AffineEnvironment.transform 31 539374 env3424 = env3425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 539374 env3424 == env3425) = true)

def env3426 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4176,8233,2083,11460,2049,524288,8233,4096,10248,5236,138,8328,5156,2185,4177,11413,2184,11392,539374,37,5830,11461,512]

theorem envBound3426 : H12AffineFastState.Bounded env3426 := by
  intro p hp
  have h : env3426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3425_3426 : H12AffineEnvironment.transform 13 4176 env3425 = env3426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3425 == env3426) = true)

theorem identity3426 : scanCanonicalize (H12AffineFastState.compose env3426 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 11779) := by decide +kernel

theorem selectedBound3426 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3427 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4176,8233,2083,11460,2049,11779,8233,4096,10248,5236,138,8328,5156,2185,4177,11413,2184,11392,5357,37,5830,11461,512]

theorem envBound3427 : H12AffineFastState.Bounded env3427 := by
  intro p hp
  have h : env3427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3426_3427 : H12AffineEnvironment.transform 18 11779 env3426 = env3427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 11779 env3426 == env3427) = true)

theorem identity3427 : scanCanonicalize (H12AffineFastState.compose env3427 (packedSelected [11] rootPS)) = affineNative (2^(12+1) ^^^ 5180) := by decide +kernel

theorem selectedBound3427 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3428 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,5180,4176,5141,2083,6392,2049,6719,5141,4096,7220,5236,138,5300,5156,2185,4177,6313,2184,6332,5357,37,5830,6393,512]

theorem envBound3428 : H12AffineFastState.Bounded env3428 := by
  intro p hp
  have h : env3428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3427_3428 : H12AffineEnvironment.transform 12 5180 env3427 = env3428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5180 env3427 == env3428) = true)

theorem identity3428 : scanCanonicalize (H12AffineFastState.compose env3428 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 1566) := by decide +kernel

theorem selectedBound3428 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env3429 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,1566,546,1614,523,2083,3814,2049,3105,523,1566,2602,618,138,682,570,2185,1615,3767,2184,3746,755,37,216,3815,512]

theorem envBound3429 : H12AffineFastState.Bounded env3429 := by
  intro p hp
  have h : env3429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3428_3429 : H12AffineEnvironment.transform 11 1566 env3428 = env3429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1566 env3428 == env3429) = true)

theorem identity3429 : scanCanonicalize (H12AffineFastState.compose env3429 (packedSelected [1,3,6] rootPS)) = affineNative (2^(10+1) ^^^ 523) := by decide +kernel

theorem selectedBound3429 : packedSelected [1,3,6] rootPS < 2^1333 := by decide +kernel

def env3430 : List Nat := [2,4,8,16,32,64,128,37,512,1024,523,1566,546,1614,523,552,1261,522,1578,523,1566,33,618,138,682,570,642,1615,1212,643,1193,755,37,216,1260,512]

theorem envBound3430 : H12AffineFastState.Bounded env3430 := by
  intro p hp
  have h : env3430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3429_3430 : H12AffineEnvironment.transform 10 523 env3429 = env3430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 523 env3429 == env3430) = true)

theorem identity3430 : scanCanonicalize (H12AffineFastState.compose env3430 (packedSelected [0,2,4] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound3430 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env3431 : List Nat := [2,4,8,16,32,64,128,37,42,1024,33,1076,8,1124,33,2,1261,32,1024,33,1076,33,64,138,128,16,168,1125,1212,169,1193,217,37,216,1260,42]

theorem envBound3431 : H12AffineFastState.Bounded env3431 := by
  intro p hp
  have h : env3431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3430_3431 : H12AffineEnvironment.transform 8 42 env3430 = env3431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env3430 == env3431) = true)

theorem identity3431 : scanCanonicalize (H12AffineFastState.compose env3431 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound3431 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3432 : List Nat := [2,4,8,16,32,58,128,37,42,1024,33,1076,8,1054,33,2,1175,32,1024,33,1076,33,58,138,128,16,168,1055,1212,169,1193,163,37,162,1174,42]

theorem envBound3432 : H12AffineFastState.Bounded env3432 := by
  intro p hp
  have h : env3432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3431_3432 : H12AffineEnvironment.transform 5 58 env3431 = env3432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env3431 == env3432) = true)

theorem identity3432 : scanCanonicalize (H12AffineFastState.compose env3432 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3432 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3433 : List Nat := [2,4,8,16,32,58,8,37,42,1024,33,1076,8,1054,33,2,1055,32,1024,33,1076,33,58,2,8,16,32,1055,1076,33,1057,43,37,42,1054,42]

theorem envBound3433 : H12AffineFastState.Bounded env3433 := by
  intro p hp
  have h : env3433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3432_3433 : H12AffineEnvironment.transform 6 8 env3432 = env3433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3432 == env3433) = true)

theorem identity3433 : scanCanonicalize (H12AffineFastState.compose env3433 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound3433 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3434 : List Nat := [2,4,8,3,32,41,8,37,42,1024,33,1063,8,1037,33,2,1036,32,1024,33,1063,33,41,2,8,3,32,1036,1063,33,1057,43,37,42,1037,42]

theorem envBound3434 : H12AffineFastState.Bounded env3434 := by
  intro p hp
  have h : env3434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3433_3434 : H12AffineEnvironment.transform 3 3 env3433 = env3434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env3433 == env3434) = true)

theorem identity3434 : scanCanonicalize (H12AffineFastState.compose env3434 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound3434 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env3435 : List Nat := [2,4,8,3,32,41,8,37,42,15,33,40,8,2,33,2,3,32,15,33,40,33,41,2,8,3,32,3,40,33,46,43,37,42,2,42]

theorem envBound3435 : H12AffineFastState.Bounded env3435 := by
  intro p hp
  have h : env3435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3434_3435 : H12AffineEnvironment.transform 9 15 env3434 = env3435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env3434 == env3435) = true)

theorem identity3435 : scanCanonicalize (H12AffineFastState.compose env3435 (packedSelected [13] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound3435 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env3436 : List Nat := [2,4,8,3,11,2,8,14,1,15,10,3,8,2,10,2,3,11,15,10,3,10,2,2,8,3,11,3,3,10,5,0,14,1,2,1]

theorem envBound3436 : H12AffineFastState.Bounded env3436 := by
  intro p hp
  have h : env3436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3435_3436 : H12AffineEnvironment.transform 4 11 env3435 = env3436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env3435 == env3436) = true)

def leafEnv3436 : List Nat := [2,4,8,3,11,2,8,14,1,15,10,3,8,2,10,2,3,11,15,10,3,10,2,2,5,8,1,3,11,3,3,10,5,0,14,1,4,2,2,1,0,3,1]

def active3436 : List Nat := [0,1,2]

def tree3436 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3436 : H12WitnessSearch.Good tree3436 := H12GlobalWitnessIndex.good

theorem leafIdentity3436 : H12AffineFastState.composeSystem env3436 rootObs = leafEnv3436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3436 rootObs == leafEnv3436) = true)

theorem terminalChecked3436 : H12PackedTerminal.terminalCheckFast leafEnv3436 active3436 tree3436 = true := by decide +kernel

def env3437 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4177,8233,2083,11460,2049,524288,8233,4097,10248,5237,138,8328,5157,2185,4177,11413,2184,11392,539374,37,5830,11461,512]

theorem envBound3437 : H12AffineFastState.Bounded env3437 := by
  intro p hp
  have h : env3437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3425_3437 : H12AffineEnvironment.transform 13 4177 env3425 = env3437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env3425 == env3437) = true)

theorem identity3437 : scanCanonicalize (H12AffineFastState.compose env3437 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1699) := by decide +kernel

theorem selectedBound3437 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3438 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4177,8233,2083,11460,2049,1699,8233,4097,10248,5237,138,8328,5157,2185,4177,11413,2184,11392,15437,37,5830,11461,512]

theorem envBound3438 : H12AffineFastState.Bounded env3438 := by
  intro p hp
  have h : env3438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3437_3438 : H12AffineEnvironment.transform 18 1699 env3437 = env3438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1699 env3437 == env3438) = true)

theorem identity3438 : scanCanonicalize (H12AffineFastState.compose env3438 (packedSelected [11] rootPS)) = affineNative (2^(12+1) ^^^ 88) := by decide +kernel

theorem selectedBound3438 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3439 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,88,4177,113,2083,3228,2049,1699,113,4097,2128,5237,138,208,5157,2185,4177,3277,2184,3288,7189,37,5830,3229,512]

theorem envBound3439 : H12AffineFastState.Bounded env3439 := by
  intro p hp
  have h : env3439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3438_3439 : H12AffineEnvironment.transform 12 88 env3438 = env3439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 88 env3438 == env3439) = true)

def env3440 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17665,230468,8329,2098433,2518044,2117633,131153,1073741824,131140,4294967296,256,4297844919,131073,513]

theorem envBound3440 : H12AffineFastState.Bounded env3440 := by
  intro p hp
  have h : env3440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3380_3440 : H12AffineEnvironment.transform 24 8329 env3380 = env3440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env3380 == env3440) = true)

def env3441 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8200,17665,230468,8329,2098433,2515996,2117633,131153,1073741824,131140,4294967296,256,4297842871,131073,513]

theorem envBound3441 : H12AffineFastState.Bounded env3441 := by
  intro p hp
  have h : env3441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3440_3441 : H12AffineEnvironment.transform 10 0 env3440 = env3441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env3440 == env3441) = true)

def env3442 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17665,230468,8329,5377,422940,16385,131153,1073741824,131140,4294967296,256,4295749815,131073,513]

theorem envBound3442 : H12AffineFastState.Bounded env3442 := by
  intro p hp
  have h : env3442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3441_3442 : H12AffineEnvironment.transform 20 4096 env3441 = env3442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3441 == env3442) = true)

theorem identity3442 : scanCanonicalize (H12AffineFastState.compose env3442 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 439024) := by decide +kernel

theorem selectedBound3442 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3443 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17665,230468,8329,5377,422940,16385,131153,439024,131140,4294967296,256,4295749815,131073,513]

theorem envBound3443 : H12AffineFastState.Bounded env3443 := by
  intro p hp
  have h : env3443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3442_3443 : H12AffineEnvironment.transform 29 439024 env3442 = env3443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 439024 env3442 == env3443) = true)

def env3444 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,176880,524288,32768,4096,8200,17665,230468,8329,5377,50924,16385,131153,0,131140,4294967296,256,4295749815,131073,513]

theorem envBound3444 : H12AffineFastState.Bounded env3444 := by
  intro p hp
  have h : env3444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3443_3444 : H12AffineEnvironment.transform 17 176880 env3443 = env3444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 176880 env3443 == env3444) = true)

theorem identity3444 : scanCanonicalize (H12AffineFastState.compose env3444 (packedSelected [0,4,7,18,20,22] rootPS)) = affineNative (2^(16+1) ^^^ 17032) := by decide +kernel

theorem selectedBound3444 : packedSelected [0,4,7,18,20,22] rootPS < 2^1333 := by decide +kernel

def env3445 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,17032,61560,524288,32768,4096,8200,17665,116428,8329,5377,50924,16385,17113,0,17100,4294967296,256,4295602751,17033,513]

theorem envBound3445 : H12AffineFastState.Bounded env3445 := by
  intro p hp
  have h : env3445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3444_3445 : H12AffineEnvironment.transform 16 17032 env3444 = env3445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17032 env3444 == env3445) = true)

theorem identity3445 : scanCanonicalize (H12AffineFastState.compose env3445 (packedSelected [16,18,20,23] rootPS)) = affineNative (2^(12+1) ^^^ 5781) := by decide +kernel

theorem selectedBound3445 : packedSelected [16,18,20,23] rootPS < 2^1333 := by decide +kernel

def env3446 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5781,16384,32768,65536,17032,50925,524288,32768,4096,5789,17665,116428,5660,5377,50924,16385,17113,0,17100,4294967296,256,4295591082,17033,513]

theorem envBound3446 : H12AffineFastState.Bounded env3446 := by
  intro p hp
  have h : env3446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3445_3446 : H12AffineEnvironment.transform 12 5781 env3445 = env3446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5781 env3445 == env3446) = true)

def env3447 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,16384,32768,65536,17032,50925,524288,32768,1296,909,17665,116428,780,17,50924,16385,17113,0,17100,4294967296,256,4295591082,17033,513]

theorem envBound3447 : H12AffineFastState.Bounded env3447 := by
  intro p hp
  have h : env3447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3446_3447 : H12AffineEnvironment.transform 11 1296 env3446 = env3447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3446 == env3447) = true)

theorem identity3447 : scanCanonicalize (H12AffineFastState.compose env3447 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 82410) := by decide +kernel

theorem selectedBound3447 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3448 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,16384,32768,65536,17032,50925,82410,32768,1296,909,17665,116428,780,17,50924,16385,17113,0,17100,4294967296,256,4295017792,17033,513]

theorem envBound3448 : H12AffineFastState.Bounded env3448 := by
  intro p hp
  have h : env3448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3447_3448 : H12AffineEnvironment.transform 18 82410 env3447 = env3448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 82410 env3447 == env3448) = true)

theorem identity3448 : scanCanonicalize (H12AffineFastState.compose env3448 (packedSelected [0,2,4,6,12,15] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound3448 : packedSelected [0,2,4,6,12,15] rootPS < 2^1333 := by decide +kernel

def env3449 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,1992,32768,65536,1344,33061,67106,32768,1296,909,713,98564,780,17,33060,1993,1297,0,1284,4294967296,256,4295000712,1345,513]

theorem envBound3449 : H12AffineFastState.Bounded env3449 := by
  intro p hp
  have h : env3449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3448_3449 : H12AffineEnvironment.transform 13 1992 env3448 = env3449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env3448 == env3449) = true)

theorem identity3449 : scanCanonicalize (H12AffineFastState.compose env3449 (packedSelected [4,9] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound3449 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3450 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,1992,32768,33167,1344,33061,34733,32768,1296,909,713,139,780,17,33060,1993,1297,0,1284,4294967296,256,4295000712,1345,513]

theorem envBound3450 : H12AffineFastState.Bounded env3450 := by
  intro p hp
  have h : env3450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3449_3450 : H12AffineEnvironment.transform 15 33167 env3449 = env3450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env3449 == env3450) = true)

theorem identity3450 : scanCanonicalize (H12AffineFastState.compose env3450 (packedSelected [0,6] rootPS)) = affineNative (2^(7+1) ^^^ 157) := by decide +kernel

theorem selectedBound3450 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3451 : List Nat := [2,4,8,16,32,64,128,157,512,1024,0,1165,536,1621,32768,32786,1245,32952,34352,32768,1165,528,713,139,657,17,32953,1620,1164,0,1177,4294967296,157,4295000712,1244,513]

theorem envBound3451 : H12AffineFastState.Bounded env3451 := by
  intro p hp
  have h : env3451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3450_3451 : H12AffineEnvironment.transform 7 157 env3450 = env3451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 157 env3450 == env3451) = true)

theorem identity3451 : scanCanonicalize (H12AffineFastState.compose env3451 (packedSelected [5,8] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound3451 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3452 : List Nat := [2,4,8,16,32,64,57,36,512,1024,0,1076,536,1621,32768,32786,1124,32769,34352,32768,1076,528,624,50,552,17,32768,1620,1077,0,1056,4294967296,36,4295000625,1125,513]

theorem envBound3452 : H12AffineFastState.Bounded env3452 := by
  intro p hp
  have h : env3452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3451_3452 : H12AffineEnvironment.transform 6 57 env3451 = env3452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env3451 == env3452) = true)

theorem identity3452 : scanCanonicalize (H12AffineFastState.compose env3452 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 48) := by decide +kernel

theorem selectedBound3452 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env3453 : List Nat := [2,4,8,16,32,64,57,36,48,1024,0,1076,40,1125,32768,32786,1124,32769,33792,32768,1076,32,64,50,24,17,32768,1124,1077,0,1056,4294967296,36,4295000065,1125,49]

theorem envBound3453 : H12AffineFastState.Bounded env3453 := by
  intro p hp
  have h : env3453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3452_3453 : H12AffineEnvironment.transform 8 48 env3452 = env3453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 48 env3452 == env3453) = true)

theorem identity3453 : scanCanonicalize (H12AffineFastState.compose env3453 (packedSelected [0,1,3] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound3453 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env3454 : List Nat := [2,4,8,16,32,64,57,36,48,1024,0,1076,40,1125,32768,32786,1124,32769,33792,32768,1076,32,64,50,24,17,32768,1124,1077,0,1056,43,36,32810,1125,49]

theorem envBound3454 : H12AffineFastState.Bounded env3454 := by
  intro p hp
  have h : env3454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3453_3454 : H12AffineEnvironment.transform 31 43 env3453 = env3454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env3453 == env3454) = true)

theorem identity3454 : scanCanonicalize (H12AffineFastState.compose env3454 (packedSelected [2,4] rootPS)) = affineNative (2^(14+1) ^^^ 1) := by decide +kernel

theorem selectedBound3454 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3455 : List Nat := [2,4,8,16,32,64,57,36,48,1024,0,1076,40,1125,1,19,1124,0,1025,1,1076,32,64,50,24,17,1,1124,1077,0,1056,43,36,43,1125,49]

theorem envBound3455 : H12AffineFastState.Bounded env3455 := by
  intro p hp
  have h : env3455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3454_3455 : H12AffineEnvironment.transform 14 1 env3454 = env3455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1 env3454 == env3455) = true)

def env3456 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,900,16384,32768,65536,17032,50925,524288,32768,1297,908,17665,116428,781,16,50924,16385,17113,0,17100,4294967296,256,4295591082,17033,513]

theorem envBound3456 : H12AffineFastState.Bounded env3456 := by
  intro p hp
  have h : env3456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3446_3456 : H12AffineEnvironment.transform 11 1297 env3446 = env3456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3446 == env3456) = true)

theorem identity3456 : scanCanonicalize (H12AffineFastState.compose env3456 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound3456 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3457 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,900,16384,293,65536,17032,18376,524288,293,1297,908,17665,83945,781,16,18377,16385,17113,0,17100,4294967296,256,4295558543,17033,513]

theorem envBound3457 : H12AffineFastState.Bounded env3457 := by
  intro p hp
  have h : env3457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3456_3457 : H12AffineEnvironment.transform 14 293 env3456 = env3457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env3456 == env3457) = true)

theorem identity3457 : scanCanonicalize (H12AffineFastState.compose env3457 (packedSelected [1,2,4,5,6,7,12,13,15] rootPS)) = affineNative (2^(18+1) ^^^ 1673) := by decide +kernel

theorem selectedBound3457 : packedSelected [1,2,4,5,6,7,12,13,15] rootPS < 2^1333 := by decide +kernel

def env3458 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,900,16384,293,65536,17032,18376,1673,293,1297,908,17665,83945,781,16,18377,16385,17113,0,17100,4294967296,256,4295033606,17033,513]

theorem envBound3458 : H12AffineFastState.Bounded env3458 := by
  intro p hp
  have h : env3458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3457_3458 : H12AffineEnvironment.transform 18 1673 env3457 = env3458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1673 env3457 == env3458) = true)

theorem identity3458 : scanCanonicalize (H12AffineFastState.compose env3458 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound3458 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3459 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,900,16384,293,170,17032,18376,1673,293,1297,908,17665,18243,781,16,18377,16385,17113,0,17100,4294967296,256,4294968236,17033,513]

theorem envBound3459 : H12AffineFastState.Bounded env3459 := by
  intro p hp
  have h : env3459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3458_3459 : H12AffineEnvironment.transform 15 170 env3458 = env3459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env3458 == env3459) = true)

theorem identity3459 : scanCanonicalize (H12AffineFastState.compose env3459 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound3459 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env3460 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1297,40,16384,293,170,16676,17508,1317,293,1297,32,17665,17647,161,16,17509,16385,16757,0,16736,4294967296,256,4294967296,16677,429]

theorem envBound3460 : H12AffineFastState.Bounded env3460 := by
  intro p hp
  have h : env3460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3459_3460 : H12AffineEnvironment.transform 8 428 env3459 = env3460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env3459 == env3460) = true)

theorem identity3460 : scanCanonicalize (H12AffineFastState.compose env3460 (packedSelected [5,8] rootPS)) = affineNative (2^(13+1) ^^^ 1125) := by decide +kernel

theorem selectedBound3460 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3461 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1297,40,1125,293,170,1345,1,1317,293,1297,32,356,138,161,16,0,1124,1296,0,1285,4294967296,256,4294967296,1344,429]

theorem envBound3461 : H12AffineFastState.Bounded env3461 := by
  intro p hp
  have h : env3461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3460_3461 : H12AffineEnvironment.transform 13 1125 env3460 = env3461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1125 env3460 == env3461) = true)

theorem identity3461 : scanCanonicalize (H12AffineFastState.compose env3461 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound3461 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3462 : List Nat := [2,4,8,16,32,64,89,256,373,1024,0,1297,40,1125,293,115,1345,1,1317,293,1297,32,356,83,120,16,0,1124,1296,0,1285,4294967296,256,4294967296,1344,372]

theorem envBound3462 : H12AffineFastState.Bounded env3462 := by
  intro p hp
  have h : env3462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3461_3462 : H12AffineEnvironment.transform 6 89 env3461 = env3462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env3461 == env3462) = true)

theorem identity3462 : scanCanonicalize (H12AffineFastState.compose env3462 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3462 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3463 : List Nat := [2,4,8,16,1,64,89,256,340,1024,0,1297,9,1092,260,82,1345,1,1284,260,1297,1,325,83,89,16,0,1093,1296,0,1285,4294967296,256,4294967296,1344,341]

theorem envBound3463 : H12AffineFastState.Bounded env3463 := by
  intro p hp
  have h : env3463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3462_3463 : H12AffineEnvironment.transform 4 1 env3462 = env3463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3462 == env3463) = true)

theorem identity3463 : scanCanonicalize (H12AffineFastState.compose env3463 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3463 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3464 : List Nat := [2,4,8,16,1,64,89,5,81,1024,0,1044,9,1092,1,82,1092,1,1025,1,1044,1,64,83,89,16,0,1093,1045,0,1024,4294967296,5,4294967296,1093,80]

theorem envBound3464 : H12AffineFastState.Bounded env3464 := by
  intro p hp
  have h : env3464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3463_3464 : H12AffineEnvironment.transform 7 5 env3463 = env3464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3463 == env3464) = true)

theorem identity3464 : scanCanonicalize (H12AffineFastState.compose env3464 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 10) := by decide +kernel

theorem selectedBound3464 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3465 : List Nat := [2,4,8,16,1,64,89,5,81,1024,0,1044,9,1092,1,82,1092,1,1025,1,1044,1,64,83,89,16,0,1093,1045,0,1024,10,5,10,1093,80]

theorem envBound3465 : H12AffineFastState.Bounded env3465 := by
  intro p hp
  have h : env3465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3464_3465 : H12AffineEnvironment.transform 31 10 env3464 = env3465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10 env3464 == env3465) = true)

theorem identity3465 : scanCanonicalize (H12AffineFastState.compose env3465 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound3465 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3466 : List Nat := [2,4,8,16,1,17,8,5,0,1024,0,1044,9,1045,1,3,1045,1,1025,1,1044,1,17,2,8,16,0,1044,1045,0,1024,10,5,10,1044,1]

theorem envBound3466 : H12AffineFastState.Bounded env3466 := by
  intro p hp
  have h : env3466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3465_3466 : H12AffineEnvironment.transform 5 17 env3465 = env3466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3465 == env3466) = true)

theorem identity3466 : scanCanonicalize (H12AffineFastState.compose env3466 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3466 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3467 : List Nat := [2,4,3,16,1,17,3,5,0,1024,0,1044,2,1045,1,3,1045,1,1025,1,1044,1,17,2,3,16,0,1044,1045,0,1024,1,5,1,1044,1]

theorem envBound3467 : H12AffineFastState.Bounded env3467 := by
  intro p hp
  have h : env3467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3466_3467 : H12AffineEnvironment.transform 2 3 env3466 = env3467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3466 == env3467) = true)

def env3468 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,176881,524288,32768,4096,8200,17665,230468,8329,5377,50925,16385,131153,1,131140,4294967296,256,4295749815,131073,513]

theorem envBound3468 : H12AffineFastState.Bounded env3468 := by
  intro p hp
  have h : env3468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3443_3468 : H12AffineEnvironment.transform 17 176881 env3443 = env3468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 176881 env3443 == env3468) = true)

def env3469 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,1344,47025,524288,32768,4096,8200,17665,98564,8329,5377,50925,16385,1297,1,1284,4294967296,256,4295620087,1345,513]

theorem envBound3469 : H12AffineFastState.Bounded env3469 := by
  intro p hp
  have h : env3469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3468_3469 : H12AffineEnvironment.transform 16 1344 env3468 = env3469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3468 == env3469) = true)

theorem identity3469 : scanCanonicalize (H12AffineFastState.compose env3469 (packedSelected [4,9] rootPS)) = affineNative (2^(18+1) ^^^ 5017) := by decide +kernel

theorem selectedBound3469 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3470 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,1344,47025,5017,32768,4096,8200,17665,98564,8329,5377,50925,16385,1297,1,1284,4294967296,256,4295091822,1345,513]

theorem envBound3470 : H12AffineFastState.Bounded env3470 := by
  intro p hp
  have h : env3470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3469_3470 : H12AffineEnvironment.transform 18 5017 env3469 = env3470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5017 env3469 == env3470) = true)

theorem identity3470 : scanCanonicalize (H12AffineFastState.compose env3470 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 1993) := by decide +kernel

theorem selectedBound3470 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3471 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,1993,32768,65536,1344,47025,5017,32768,4096,8200,712,98564,8329,5377,33060,1992,1297,1,1284,4294967296,256,4295074215,1345,513]

theorem envBound3471 : H12AffineFastState.Bounded env3471 := by
  intro p hp
  have h : env3471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3470_3471 : H12AffineEnvironment.transform 13 1993 env3470 = env3471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1993 env3470 == env3471) = true)

theorem identity3471 : scanCanonicalize (H12AffineFastState.compose env3471 (packedSelected [16] rootPS)) = affineNative (2^(15+1) ^^^ 46874) := by decide +kernel

theorem selectedBound3471 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env3472 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,1993,32768,46874,1344,47025,5017,32768,4096,8200,712,13854,8329,5377,33060,1992,1297,1,1284,4294967296,256,4294973117,1345,513]

theorem envBound3472 : H12AffineFastState.Bounded env3472 := by
  intro p hp
  have h : env3472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3471_3472 : H12AffineEnvironment.transform 15 46874 env3471 = env3472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 46874 env3471 == env3472) = true)

theorem identity3472 : scanCanonicalize (H12AffineFastState.compose env3472 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 5781) := by decide +kernel

theorem selectedBound3472 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3473 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5781,1993,32768,33167,1344,33060,5017,32768,4096,5789,712,139,5660,5377,33060,1992,1297,1,1284,4294967296,256,4294973117,1345,513]

theorem envBound3473 : H12AffineFastState.Bounded env3473 := by
  intro p hp
  have h : env3473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3472_3473 : H12AffineEnvironment.transform 12 5781 env3472 = env3473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5781 env3472 == env3473) = true)

def env3474 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,1345,47024,524288,32768,4096,8200,17665,98565,8329,5377,50925,16385,1296,1,1285,4294967296,256,4295620086,1344,513]

theorem envBound3474 : H12AffineFastState.Bounded env3474 := by
  intro p hp
  have h : env3474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3468_3474 : H12AffineEnvironment.transform 16 1345 env3468 = env3474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3468 == env3474) = true)

theorem identity3474 : scanCanonicalize (H12AffineFastState.compose env3474 (packedSelected [4,9] rootPS)) = affineNative (2^(13+1) ^^^ 4824) := by decide +kernel

theorem selectedBound3474 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3475 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,32768,65536,1345,47024,524288,32768,4096,8200,6105,98565,8329,5377,37941,4825,1296,1,1285,4294967296,256,4295599918,1344,513]

theorem envBound3475 : H12AffineFastState.Bounded env3475 := by
  intro p hp
  have h : env3475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3474_3475 : H12AffineEnvironment.transform 13 4824 env3474 = env3475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env3474 == env3475) = true)

theorem identity3475 : scanCanonicalize (H12AffineFastState.compose env3475 (packedSelected [0,2,4,6,16] rootPS)) = affineNative (2^(18+1) ^^^ 100102) := by decide +kernel

theorem selectedBound3475 : packedSelected [0,2,4,6,16] rootPS < 2^1333 := by decide +kernel

def env3476 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,32768,65536,1345,47024,100102,32768,4096,8200,6105,98565,8329,5377,37941,4825,1296,1,1285,4294967296,256,4294975528,1344,513]

theorem envBound3476 : H12AffineFastState.Bounded env3476 := by
  intro p hp
  have h : env3476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3475_3476 : H12AffineEnvironment.transform 18 100102 env3475 = env3476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 100102 env3475 == env3476) = true)

theorem identity3476 : scanCanonicalize (H12AffineFastState.compose env3476 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound3476 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3477 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5148,4824,32768,65536,1345,33708,100102,32768,4096,5140,6105,98565,5269,5377,37941,4825,1296,1,1285,4294967296,256,4294972468,1344,513]

theorem envBound3477 : H12AffineFastState.Bounded env3477 := by
  intro p hp
  have h : env3477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3476_3477 : H12AffineEnvironment.transform 12 5148 env3476 = env3477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env3476 == env3477) = true)

theorem identity3477 : scanCanonicalize (H12AffineFastState.compose env3477 (packedSelected [1,3,5,8,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound3477 : packedSelected [1,3,5,8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3478 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,268,1992,32768,65536,1345,33708,100102,32768,1296,260,713,98565,389,17,33061,1993,1296,1,1285,4294967296,256,4294967588,1344,513]

theorem envBound3478 : H12AffineFastState.Bounded env3478 := by
  intro p hp
  have h : env3478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3477_3478 : H12AffineEnvironment.transform 11 1296 env3477 = env3478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3477 == env3478) = true)

theorem identity3478 : scanCanonicalize (H12AffineFastState.compose env3478 (packedSelected [1,3,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3478 : packedSelected [1,3,10,19] rootPS < 2^1333 := by decide +kernel

def env3479 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,268,1345,32768,65536,1345,33061,99727,32768,1296,260,64,98565,389,17,33061,1344,1296,1,1285,4294967296,256,4294967588,1344,136]

theorem envBound3479 : H12AffineFastState.Bounded env3479 := by
  intro p hp
  have h : env3479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3478_3479 : H12AffineEnvironment.transform 8 137 env3478 = env3479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3478 == env3479) = true)

theorem identity3479 : scanCanonicalize (H12AffineFastState.compose env3479 (packedSelected [2,3,4,10] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound3479 : packedSelected [2,3,4,10] rootPS < 2^1333 := by decide +kernel

def env3480 : List Nat := [2,4,8,16,32,64,128,37,137,1024,0,1077,41,1124,32768,65536,1124,32768,99498,32768,1077,33,64,98336,160,17,32768,1125,1077,1,1056,4294967296,37,4294967297,1125,136]

theorem envBound3480 : H12AffineFastState.Bounded env3480 := by
  intro p hp
  have h : env3480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3479_3480 : H12AffineEnvironment.transform 7 37 env3479 = env3480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env3479 == env3480) = true)

theorem identity3480 : scanCanonicalize (H12AffineFastState.compose env3480 (packedSelected [1,3,4] rootPS)) = affineNative (2^(14+1) ^^^ 153) := by decide +kernel

theorem selectedBound3480 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env3481 : List Nat := [2,4,8,16,32,64,128,37,137,1024,0,1077,41,1124,153,65536,1124,153,66611,153,1077,33,64,65721,160,17,153,1125,1077,1,1056,4294967296,37,4294967297,1125,136]

theorem envBound3481 : H12AffineFastState.Bounded env3481 := by
  intro p hp
  have h : env3481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3480_3481 : H12AffineEnvironment.transform 14 153 env3480 = env3481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 153 env3480 == env3481) = true)

theorem identity3481 : scanCanonicalize (H12AffineFastState.compose env3481 (packedSelected [1,3,12] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound3481 : packedSelected [1,3,12] rootPS < 2^1333 := by decide +kernel

def env3482 : List Nat := [2,4,8,16,32,64,25,37,16,1024,0,1077,41,1124,0,65536,1124,0,66611,0,1077,33,64,65568,57,17,0,1125,1077,1,1056,4294967296,37,4294967297,1125,17]

theorem envBound3482 : H12AffineFastState.Bounded env3482 := by
  intro p hp
  have h : env3482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3481_3482 : H12AffineEnvironment.transform 6 25 env3481 = env3482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env3481 == env3482) = true)

theorem identity3482 : scanCanonicalize (H12AffineFastState.compose env3482 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65625) := by decide +kernel

theorem selectedBound3482 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3483 : List Nat := [2,4,8,16,32,64,25,37,16,1024,0,1077,41,1124,0,65536,1124,0,66611,0,1077,33,64,65568,57,17,0,1125,1077,1,1056,65625,37,65624,1125,17]

theorem envBound3483 : H12AffineFastState.Bounded env3483 := by
  intro p hp
  have h : env3483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3482_3483 : H12AffineEnvironment.transform 31 65625 env3482 = env3483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65625 env3482 == env3483) = true)

def env3484 : List Nat := [2,4,8,16,32,64,25,37,16,1024,0,1077,41,1124,0,88,1124,0,1131,0,1077,33,64,120,57,17,0,1125,1077,1,1056,1,37,0,1125,17]

theorem envBound3484 : H12AffineFastState.Bounded env3484 := by
  intro p hp
  have h : env3484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3483_3484 : H12AffineEnvironment.transform 15 88 env3483 = env3484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 88 env3483 == env3484) = true)

theorem identity3484 : scanCanonicalize (H12AffineFastState.compose env3484 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound3484 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3485 : List Nat := [2,4,8,16,32,0,25,37,16,1024,0,1077,41,1060,0,24,1060,0,1067,0,1077,33,0,56,57,17,0,1061,1077,1,1056,1,37,0,1061,17]

theorem envBound3485 : H12AffineFastState.Bounded env3485 := by
  intro p hp
  have h : env3485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3484_3485 : H12AffineEnvironment.transform 5 0 env3484 = env3485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3484 == env3485) = true)

theorem identity3485 : scanCanonicalize (H12AffineFastState.compose env3485 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound3485 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3486 : List Nat := [2,4,8,16,10,0,25,15,16,1024,0,1055,3,1038,0,24,1038,0,1025,0,1055,11,0,18,19,17,0,1039,1055,1,1034,1,15,0,1039,17]

theorem envBound3486 : H12AffineFastState.Bounded env3486 := by
  intro p hp
  have h : env3486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3485_3486 : H12AffineEnvironment.transform 4 10 env3485 = env3486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env3485 == env3486) = true)

def leafEnv3486 : List Nat := [2,4,8,16,10,0,25,15,16,1024,0,1055,3,1038,0,24,1038,0,1025,0,1055,11,0,18,1035,19,1,17,0,1039,1055,1,1034,1,15,0,4,9,1039,17,0,1055,1]

def active3486 : List Nat := [0,1,2,3,9]

def tree3486 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3486 : H12WitnessSearch.Good tree3486 := H12GlobalWitnessIndex.good

theorem leafIdentity3486 : H12AffineFastState.composeSystem env3486 rootObs = leafEnv3486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3486 rootObs == leafEnv3486) = true)

theorem terminalChecked3486 : H12PackedTerminal.terminalCheckFast leafEnv3486 active3486 tree3486 = true := by decide +kernel

def env3487 : List Nat := [2,4,8,16,32,64,25,37,16,1024,0,1077,41,1124,0,89,1124,0,1130,0,1077,33,64,121,57,17,0,1125,1077,1,1056,0,37,1,1125,17]

theorem envBound3487 : H12AffineFastState.Bounded env3487 := by
  intro p hp
  have h : env3487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3483_3487 : H12AffineEnvironment.transform 15 89 env3483 = env3487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 89 env3483 == env3487) = true)

theorem identity3487 : scanCanonicalize (H12AffineFastState.compose env3487 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound3487 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3488 : List Nat := [2,4,8,16,11,64,25,14,16,1024,0,1054,2,1103,0,89,1103,0,1089,0,1054,10,64,82,18,17,0,1102,1054,1,1035,0,14,1,1102,17]

theorem envBound3488 : H12AffineFastState.Bounded env3488 := by
  intro p hp
  have h : env3488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3487_3488 : H12AffineEnvironment.transform 4 11 env3487 = env3488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env3487 == env3488) = true)

def env3489 : List Nat := [2,4,8,16,11,0,25,14,16,1024,0,1054,2,1039,0,25,1039,0,1025,0,1054,10,0,18,18,17,0,1038,1054,1,1035,0,14,1,1038,17]

theorem envBound3489 : H12AffineFastState.Bounded env3489 := by
  intro p hp
  have h : env3489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3488_3489 : H12AffineEnvironment.transform 5 0 env3488 = env3489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3488 == env3489) = true)

def leafEnv3489 : List Nat := [2,4,8,16,11,0,25,14,16,1024,0,1054,2,1039,0,25,1039,0,1025,0,1054,10,0,18,1034,18,1,17,0,1038,1054,1,1035,0,14,1,4,8,1038,17,0,1054,1]

def active3489 : List Nat := [0,1,2,3,9]

def tree3489 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3489 : H12WitnessSearch.Good tree3489 := H12GlobalWitnessIndex.good

theorem leafIdentity3489 : H12AffineFastState.composeSystem env3489 rootObs = leafEnv3489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3489 rootObs == leafEnv3489) = true)

theorem terminalChecked3489 : H12PackedTerminal.terminalCheckFast leafEnv3489 active3489 tree3489 = true := by decide +kernel

def env3490 : List Nat := [2,4,8,16,11,1,25,14,16,1024,0,1054,2,1038,0,24,1038,0,1024,0,1054,10,1,19,18,17,0,1039,1054,1,1035,0,14,1,1039,17]

theorem envBound3490 : H12AffineFastState.Bounded env3490 := by
  intro p hp
  have h : env3490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3488_3490 : H12AffineEnvironment.transform 5 1 env3488 = env3490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env3488 == env3490) = true)

theorem identity3490 : scanCanonicalize (H12AffineFastState.compose env3490 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3490 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3491 : List Nat := [2,4,2,16,1,1,19,4,16,1024,0,1044,2,1028,0,18,1028,0,1024,0,1044,0,1,19,18,17,0,1029,1044,1,1025,0,4,1,1029,17]

theorem envBound3491 : H12AffineFastState.Bounded env3491 := by
  intro p hp
  have h : env3491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3490_3491 : H12AffineEnvironment.transform 2 2 env3490 = env3491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3490 == env3491) = true)

def leafEnv3491 : List Nat := [2,4,2,16,1,1,19,4,16,1024,0,1044,2,1028,0,18,1028,0,1024,0,1044,0,1,19,1025,18,1,17,0,1029,1044,1,1025,0,4,1,4,2,1029,17,0,1044,1]

def active3491 : List Nat := [0,1,3,9]

def tree3491 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3491 : H12WitnessSearch.Good tree3491 := H12GlobalWitnessIndex.good

theorem leafIdentity3491 : H12AffineFastState.composeSystem env3491 rootObs = leafEnv3491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3491 rootObs == leafEnv3491) = true)

theorem terminalChecked3491 : H12PackedTerminal.terminalCheckFast leafEnv3491 active3491 tree3491 = true := by decide +kernel

def env3492 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17665,230468,8329,5376,422941,16384,131153,1073741824,131140,4294967296,256,4295749814,131073,513]

theorem envBound3492 : H12AffineFastState.Bounded env3492 := by
  intro p hp
  have h : env3492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3441_3492 : H12AffineEnvironment.transform 20 4097 env3441 = env3492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env3441 == env3492) = true)

theorem identity3492 : scanCanonicalize (H12AffineFastState.compose env3492 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 436145) := by decide +kernel

theorem selectedBound3492 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3493 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17665,230468,8329,5376,422941,16384,131153,436145,131140,4294967296,256,4295749814,131073,513]

theorem envBound3493 : H12AffineFastState.Bounded env3493 := by
  intro p hp
  have h : env3493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3492_3493 : H12AffineEnvironment.transform 29 436145 env3492 = env3493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 436145 env3492 == env3493) = true)

theorem identity3493 : scanCanonicalize (H12AffineFastState.compose env3493 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound3493 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env3494 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,21585,32768,4097,8200,17665,230468,8329,5376,422941,16384,131153,436145,131140,4294967296,256,4295206119,131073,513]

theorem envBound3494 : H12AffineFastState.Bounded env3494 := by
  intro p hp
  have h : env3494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3493_3494 : H12AffineEnvironment.transform 18 21585 env3493 = env3494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env3493 == env3494) = true)

theorem identity3494 : scanCanonicalize (H12AffineFastState.compose env3494 (packedSelected [4,9,16] rootPS)) = affineNative (2^(17+1) ^^^ 198451) := by decide +kernel

theorem selectedBound3494 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3495 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,198451,21585,32768,4097,8200,17665,230468,8329,5376,95022,16384,131153,106626,131140,4294967296,256,4295206119,131073,513]

theorem envBound3495 : H12AffineFastState.Bounded env3495 := by
  intro p hp
  have h : env3495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3494_3495 : H12AffineEnvironment.transform 17 198451 env3494 = env3495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 198451 env3494 == env3495) = true)

theorem identity3495 : scanCanonicalize (H12AffineFastState.compose env3495 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound3495 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env3496 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,198451,1025,32768,4097,8200,5457,230468,8329,5376,74622,4176,131153,106626,131140,4294967296,256,4295206119,131073,513]

theorem envBound3496 : H12AffineFastState.Bounded env3496 := by
  intro p hp
  have h : env3496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3495_3496 : H12AffineEnvironment.transform 13 4176 env3495 = env3496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3495 == env3496) = true)

theorem identity3496 : scanCanonicalize (H12AffineFastState.compose env3496 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound3496 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env3497 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,8540,65536,131072,198451,1025,8540,4097,8200,5457,206104,8329,5376,74622,4176,131153,66014,131140,4294967296,256,4295165371,131073,513]

theorem envBound3497 : H12AffineFastState.Bounded env3497 := by
  intro p hp
  have h : env3497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3496_3497 : H12AffineEnvironment.transform 14 8540 env3496 = env3497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env3496 == env3497) = true)

def env3498 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8201,17665,230468,8329,2098433,2515997,2117633,131153,1073741824,131140,4294967296,256,4297842870,131073,513]

theorem envBound3498 : H12AffineFastState.Bounded env3498 := by
  intro p hp
  have h : env3498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3440_3498 : H12AffineEnvironment.transform 10 1 env3440 = env3498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env3440 == env3498) = true)

def env3499 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17665,230468,8329,5377,422941,16385,131153,1073741824,131140,4294967296,256,4295749814,131073,513]

theorem envBound3499 : H12AffineFastState.Bounded env3499 := by
  intro p hp
  have h : env3499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3498_3499 : H12AffineEnvironment.transform 20 4096 env3498 = env3499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3498 == env3499) = true)

theorem identity3499 : scanCanonicalize (H12AffineFastState.compose env3499 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 148105) := by decide +kernel

theorem selectedBound3499 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3500 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17665,230468,8329,5377,422941,16385,131153,148105,131140,4294967296,256,4295749814,131073,513]

theorem envBound3500 : H12AffineFastState.Bounded env3500 := by
  intro p hp
  have h : env3500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3499_3500 : H12AffineEnvironment.transform 29 148105 env3499 = env3500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 148105 env3499 == env3500) = true)

def env3501 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,17032,262144,524288,32768,4096,8201,17665,116428,8329,5377,276117,16385,17113,1,17100,4294967296,256,4295602750,17033,513]

theorem envBound3501 : H12AffineFastState.Bounded env3501 := by
  intro p hp
  have h : env3501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3500_3501 : H12AffineEnvironment.transform 16 17032 env3500 = env3501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17032 env3500 == env3501) = true)

theorem identity3501 : scanCanonicalize (H12AffineFastState.compose env3501 (packedSelected [0,4,7,18,20,22] rootPS)) = affineNative (2^(17+1) ^^^ 61561) := by decide +kernel

theorem selectedBound3501 : packedSelected [0,4,7,18,20,22] rootPS < 2^1333 := by decide +kernel

def env3502 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,17032,61561,524288,32768,4096,8201,17665,116428,8329,5377,50924,16385,17113,1,17100,4294967296,256,4295602750,17033,513]

theorem envBound3502 : H12AffineFastState.Bounded env3502 := by
  intro p hp
  have h : env3502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3501_3502 : H12AffineEnvironment.transform 17 61561 env3501 = env3502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 61561 env3501 == env3502) = true)

theorem identity3502 : scanCanonicalize (H12AffineFastState.compose env3502 (packedSelected [16,18,20,23] rootPS)) = affineNative (2^(12+1) ^^^ 5780) := by decide +kernel

theorem selectedBound3502 : packedSelected [16,18,20,23] rootPS < 2^1333 := by decide +kernel

def env3503 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5780,16384,32768,65536,17032,50925,524288,32768,4096,5789,17665,116428,5661,5377,50924,16385,17113,1,17100,4294967296,256,4295591082,17033,513]

theorem envBound3503 : H12AffineFastState.Bounded env3503 := by
  intro p hp
  have h : env3503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3502_3503 : H12AffineEnvironment.transform 12 5780 env3502 = env3503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5780 env3502 == env3503) = true)

def env3504 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,16384,32768,65536,17032,50925,524288,32768,1296,909,17665,116428,781,17,50924,16385,17113,1,17100,4294967296,256,4295591082,17033,513]

theorem envBound3504 : H12AffineFastState.Bounded env3504 := by
  intro p hp
  have h : env3504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3503_3504 : H12AffineEnvironment.transform 11 1296 env3503 = env3504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3503 == env3504) = true)

theorem identity3504 : scanCanonicalize (H12AffineFastState.compose env3504 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 82411) := by decide +kernel

theorem selectedBound3504 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3505 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,16384,32768,65536,17032,50925,82411,32768,1296,909,17665,116428,781,17,50924,16385,17113,1,17100,4294967296,256,4295017793,17033,513]

theorem envBound3505 : H12AffineFastState.Bounded env3505 := by
  intro p hp
  have h : env3505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3504_3505 : H12AffineEnvironment.transform 18 82411 env3504 = env3505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 82411 env3504 == env3505) = true)

theorem identity3505 : scanCanonicalize (H12AffineFastState.compose env3505 (packedSelected [0,2,4,6,12,15] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound3505 : packedSelected [0,2,4,6,12,15] rootPS < 2^1333 := by decide +kernel

def env3506 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1992,32768,65536,1344,33061,67107,32768,1296,909,713,98564,781,17,33060,1993,1297,1,1284,4294967296,256,4295000713,1345,513]

theorem envBound3506 : H12AffineFastState.Bounded env3506 := by
  intro p hp
  have h : env3506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3505_3506 : H12AffineEnvironment.transform 13 1992 env3505 = env3506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env3505 == env3506) = true)

theorem identity3506 : scanCanonicalize (H12AffineFastState.compose env3506 (packedSelected [4,9] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound3506 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3507 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1992,32768,33167,1344,33061,34732,32768,1296,909,713,139,781,17,33060,1993,1297,1,1284,4294967296,256,4295000713,1345,513]

theorem envBound3507 : H12AffineFastState.Bounded env3507 := by
  intro p hp
  have h : env3507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3506_3507 : H12AffineEnvironment.transform 15 33167 env3506 = env3507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env3506 == env3507) = true)

theorem identity3507 : scanCanonicalize (H12AffineFastState.compose env3507 (packedSelected [0,6] rootPS)) = affineNative (2^(7+1) ^^^ 157) := by decide +kernel

theorem selectedBound3507 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3508 : List Nat := [2,4,8,16,32,64,128,157,512,1024,1,1165,537,1621,32768,32786,1245,32952,34353,32768,1165,528,713,139,656,17,32953,1620,1164,1,1177,4294967296,157,4295000713,1244,513]

theorem envBound3508 : H12AffineFastState.Bounded env3508 := by
  intro p hp
  have h : env3508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3507_3508 : H12AffineEnvironment.transform 7 157 env3507 = env3508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 157 env3507 == env3508) = true)

theorem identity3508 : scanCanonicalize (H12AffineFastState.compose env3508 (packedSelected [5,8] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound3508 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3509 : List Nat := [2,4,8,16,32,64,57,36,512,1024,1,1076,537,1621,32768,32786,1124,32769,34353,32768,1076,528,624,50,553,17,32768,1620,1077,1,1056,4294967296,36,4295000624,1125,513]

theorem envBound3509 : H12AffineFastState.Bounded env3509 := by
  intro p hp
  have h : env3509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3508_3509 : H12AffineEnvironment.transform 6 57 env3508 = env3509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env3508 == env3509) = true)

theorem identity3509 : scanCanonicalize (H12AffineFastState.compose env3509 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 48) := by decide +kernel

theorem selectedBound3509 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env3510 : List Nat := [2,4,8,16,32,64,57,36,48,1024,1,1076,41,1125,32768,32786,1124,32769,33793,32768,1076,32,64,50,25,17,32768,1124,1077,1,1056,4294967296,36,4295000064,1125,49]

theorem envBound3510 : H12AffineFastState.Bounded env3510 := by
  intro p hp
  have h : env3510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3509_3510 : H12AffineEnvironment.transform 8 48 env3509 = env3510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 48 env3509 == env3510) = true)

theorem identity3510 : scanCanonicalize (H12AffineFastState.compose env3510 (packedSelected [0,1,3] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound3510 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env3511 : List Nat := [2,4,8,16,32,64,57,36,48,1024,1,1076,41,1125,32768,32786,1124,32769,33793,32768,1076,32,64,50,25,17,32768,1124,1077,1,1056,43,36,32811,1125,49]

theorem envBound3511 : H12AffineFastState.Bounded env3511 := by
  intro p hp
  have h : env3511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3510_3511 : H12AffineEnvironment.transform 31 43 env3510 = env3511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env3510 == env3511) = true)

theorem identity3511 : scanCanonicalize (H12AffineFastState.compose env3511 (packedSelected [2,4] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound3511 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3512 : List Nat := [2,4,8,16,32,64,57,36,48,1024,1,1076,41,1125,0,18,1124,1,1025,0,1076,32,64,50,25,17,0,1124,1077,1,1056,43,36,43,1125,49]

theorem envBound3512 : H12AffineFastState.Bounded env3512 := by
  intro p hp
  have h : env3512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3511_3512 : H12AffineEnvironment.transform 14 0 env3511 = env3512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 0 env3511 == env3512) = true)

def env3513 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,16384,32768,65536,17032,50925,524288,32768,1297,908,17665,116428,780,16,50924,16385,17113,1,17100,4294967296,256,4295591082,17033,513]

theorem envBound3513 : H12AffineFastState.Bounded env3513 := by
  intro p hp
  have h : env3513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3503_3513 : H12AffineEnvironment.transform 11 1297 env3503 = env3513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3503 == env3513) = true)

theorem identity3513 : scanCanonicalize (H12AffineFastState.compose env3513 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound3513 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3514 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,16384,292,65536,17032,18377,524288,292,1297,908,17665,83944,780,16,18376,16385,17113,1,17100,4294967296,256,4295558542,17033,513]

theorem envBound3514 : H12AffineFastState.Bounded env3514 := by
  intro p hp
  have h : env3514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3513_3514 : H12AffineEnvironment.transform 14 292 env3513 = env3514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env3513 == env3514) = true)

theorem identity3514 : scanCanonicalize (H12AffineFastState.compose env3514 (packedSelected [1,2,4,5,6,7,12,13,15] rootPS)) = affineNative (2^(18+1) ^^^ 1673) := by decide +kernel

theorem selectedBound3514 : packedSelected [1,2,4,5,6,7,12,13,15] rootPS < 2^1333 := by decide +kernel

def env3515 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,16384,292,65536,17032,18377,1673,292,1297,908,17665,83944,780,16,18376,16385,17113,1,17100,4294967296,256,4295033607,17033,513]

theorem envBound3515 : H12AffineFastState.Bounded env3515 := by
  intro p hp
  have h : env3515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3514_3515 : H12AffineEnvironment.transform 18 1673 env3514 = env3515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1673 env3514 == env3515) = true)

theorem identity3515 : scanCanonicalize (H12AffineFastState.compose env3515 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound3515 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3516 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,16384,292,171,17032,18377,1673,292,1297,908,17665,18243,780,16,18376,16385,17113,1,17100,4294967296,256,4294968236,17033,513]

theorem envBound3516 : H12AffineFastState.Bounded env3516 := by
  intro p hp
  have h : env3516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3515_3516 : H12AffineEnvironment.transform 15 171 env3515 = env3516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env3515 == env3516) = true)

theorem identity3516 : scanCanonicalize (H12AffineFastState.compose env3516 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound3516 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env3517 : List Nat := [2,4,8,16,32,64,128,256,428,1024,1,1297,41,16384,292,171,16676,17509,1317,292,1297,32,17665,17647,160,16,17508,16385,16757,1,16736,4294967296,256,4294967296,16677,429]

theorem envBound3517 : H12AffineFastState.Bounded env3517 := by
  intro p hp
  have h : env3517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3516_3517 : H12AffineEnvironment.transform 8 428 env3516 = env3517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env3516 == env3517) = true)

theorem identity3517 : scanCanonicalize (H12AffineFastState.compose env3517 (packedSelected [5,8] rootPS)) = affineNative (2^(13+1) ^^^ 1125) := by decide +kernel

theorem selectedBound3517 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3518 : List Nat := [2,4,8,16,32,64,128,256,428,1024,1,1297,41,1125,292,171,1345,0,1317,292,1297,32,356,138,160,16,1,1124,1296,1,1285,4294967296,256,4294967296,1344,429]

theorem envBound3518 : H12AffineFastState.Bounded env3518 := by
  intro p hp
  have h : env3518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3517_3518 : H12AffineEnvironment.transform 13 1125 env3517 = env3518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1125 env3517 == env3518) = true)

theorem identity3518 : scanCanonicalize (H12AffineFastState.compose env3518 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound3518 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3519 : List Nat := [2,4,8,16,32,64,89,256,373,1024,1,1297,41,1125,292,114,1345,0,1317,292,1297,32,356,83,121,16,1,1124,1296,1,1285,4294967296,256,4294967296,1344,372]

theorem envBound3519 : H12AffineFastState.Bounded env3519 := by
  intro p hp
  have h : env3519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3518_3519 : H12AffineEnvironment.transform 6 89 env3518 = env3519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env3518 == env3519) = true)

theorem identity3519 : scanCanonicalize (H12AffineFastState.compose env3519 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3519 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3520 : List Nat := [2,4,8,16,1,64,89,256,340,1024,1,1297,8,1092,261,83,1345,0,1284,261,1297,1,325,83,88,16,1,1093,1296,1,1285,4294967296,256,4294967296,1344,341]

theorem envBound3520 : H12AffineFastState.Bounded env3520 := by
  intro p hp
  have h : env3520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3519_3520 : H12AffineEnvironment.transform 4 1 env3519 = env3520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3519 == env3520) = true)

theorem identity3520 : scanCanonicalize (H12AffineFastState.compose env3520 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3520 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3521 : List Nat := [2,4,8,16,1,64,89,5,81,1024,1,1044,8,1092,0,83,1092,0,1025,0,1044,1,64,83,88,16,1,1093,1045,1,1024,4294967296,5,4294967296,1093,80]

theorem envBound3521 : H12AffineFastState.Bounded env3521 := by
  intro p hp
  have h : env3521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3520_3521 : H12AffineEnvironment.transform 7 5 env3520 = env3521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3520 == env3521) = true)

theorem identity3521 : scanCanonicalize (H12AffineFastState.compose env3521 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound3521 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3522 : List Nat := [2,4,8,16,1,64,89,5,81,1024,1,1044,8,1092,0,83,1092,0,1025,0,1044,1,64,83,88,16,1,1093,1045,1,1024,11,5,11,1093,80]

theorem envBound3522 : H12AffineFastState.Bounded env3522 := by
  intro p hp
  have h : env3522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3521_3522 : H12AffineEnvironment.transform 31 11 env3521 = env3522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env3521 == env3522) = true)

theorem identity3522 : scanCanonicalize (H12AffineFastState.compose env3522 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound3522 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3523 : List Nat := [2,4,8,16,1,17,8,5,0,1024,1,1044,8,1045,0,2,1045,0,1025,0,1044,1,17,2,9,16,1,1044,1045,1,1024,11,5,11,1044,1]

theorem envBound3523 : H12AffineFastState.Bounded env3523 := by
  intro p hp
  have h : env3523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3522_3523 : H12AffineEnvironment.transform 5 17 env3522 = env3523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3522 == env3523) = true)

theorem identity3523 : scanCanonicalize (H12AffineFastState.compose env3523 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3523 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3524 : List Nat := [2,4,2,16,1,17,2,5,0,1024,1,1044,2,1045,0,2,1045,0,1025,0,1044,1,17,2,3,16,1,1044,1045,1,1024,1,5,1,1044,1]

theorem envBound3524 : H12AffineFastState.Bounded env3524 := by
  intro p hp
  have h : env3524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3523_3524 : H12AffineEnvironment.transform 2 2 env3523 = env3524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3523 == env3524) = true)

def env3525 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,17033,262144,524288,32768,4096,8201,17665,116429,8329,5377,276116,16385,17112,0,17101,4294967296,256,4295602751,17032,513]

theorem envBound3525 : H12AffineFastState.Bounded env3525 := by
  intro p hp
  have h : env3525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3500_3525 : H12AffineEnvironment.transform 16 17033 env3500 = env3525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17033 env3500 == env3525) = true)

def env3526 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,32768,65536,17033,262144,524288,32768,1296,8201,17665,116429,8329,17,271236,16385,17112,0,17101,4294967296,256,4295599919,17032,513]

theorem envBound3526 : H12AffineFastState.Bounded env3526 := by
  intro p hp
  have h : env3526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3525_3526 : H12AffineEnvironment.transform 11 1296 env3525 = env3526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3525 == env3526) = true)

theorem identity3526 : scanCanonicalize (H12AffineFastState.compose env3526 (packedSelected [18] rootPS)) = affineNative (2^(17+1) ^^^ 50925) := by decide +kernel

theorem selectedBound3526 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3527 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,32768,65536,17033,50925,524288,32768,1296,8201,17665,116429,8329,17,58729,16385,17112,0,17101,4294967296,256,4295599919,17032,513]

theorem envBound3527 : H12AffineFastState.Bounded env3527 := by
  intro p hp
  have h : env3527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3526_3527 : H12AffineEnvironment.transform 17 50925 env3526 = env3527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 50925 env3526 == env3527) = true)

theorem identity3527 : scanCanonicalize (H12AffineFastState.compose env3527 (packedSelected [10,13,15,24,28] rootPS)) = affineNative (2^(18+1) ^^^ 100102) := by decide +kernel

theorem selectedBound3527 : packedSelected [10,13,15,24,28] rootPS < 2^1333 := by decide +kernel

def env3528 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,32768,65536,17033,50925,100102,32768,1296,8201,17665,116429,8329,17,58729,16385,17112,0,17101,4294967296,256,4294975529,17032,513]

theorem envBound3528 : H12AffineFastState.Bounded env3528 := by
  intro p hp
  have h : env3528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3527_3528 : H12AffineEnvironment.transform 18 100102 env3527 = env3528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 100102 env3527 == env3528) = true)

theorem identity3528 : scanCanonicalize (H12AffineFastState.compose env3528 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound3528 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3529 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,16384,32768,65536,17033,50925,100102,32768,1296,909,17665,116429,781,17,50925,16385,17112,0,17101,4294967296,256,4294968237,17032,513]

theorem envBound3529 : H12AffineFastState.Bounded env3529 := by
  intro p hp
  have h : env3529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3528_3529 : H12AffineEnvironment.transform 12 900 env3528 = env3529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env3528 == env3529) = true)

def env3530 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1344,32768,65536,1993,33709,100102,32768,1296,909,65,99213,781,17,33709,1345,1944,0,1933,4294967296,256,4294968237,1992,513]

theorem envBound3530 : H12AffineFastState.Bounded env3530 := by
  intro p hp
  have h : env3530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3529_3530 : H12AffineEnvironment.transform 13 1344 env3529 = env3530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1344 env3529 == env3530) = true)

theorem identity3530 : scanCanonicalize (H12AffineFastState.compose env3530 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33542) := by decide +kernel

theorem selectedBound3530 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3531 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1344,32768,33542,1993,33709,1024,32768,1296,909,65,139,781,17,33709,1345,1944,0,1933,4294967296,256,4294968237,1992,513]

theorem envBound3531 : H12AffineFastState.Bounded env3531 := by
  intro p hp
  have h : env3531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3530_3531 : H12AffineEnvironment.transform 15 33542 env3530 = env3531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33542 env3530 == env3531) = true)

def env3532 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1345,32768,65536,1992,33708,100102,32768,1296,909,64,99212,781,17,33708,1344,1945,0,1932,4294967296,256,4294968237,1993,513]

theorem envBound3532 : H12AffineFastState.Bounded env3532 := by
  intro p hp
  have h : env3532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3529_3532 : H12AffineEnvironment.transform 13 1345 env3529 = env3532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1345 env3529 == env3532) = true)

theorem identity3532 : scanCanonicalize (H12AffineFastState.compose env3532 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3532 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env3533 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,269,1345,32768,65536,1345,33061,99727,32768,1296,260,64,98565,388,17,33061,1344,1296,0,1285,4294967296,256,4294967588,1344,136]

theorem envBound3533 : H12AffineFastState.Bounded env3533 := by
  intro p hp
  have h : env3533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3532_3533 : H12AffineEnvironment.transform 8 137 env3532 = env3533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3532 == env3533) = true)

theorem identity3533 : scanCanonicalize (H12AffineFastState.compose env3533 (packedSelected [2,3,4,10] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound3533 : packedSelected [2,3,4,10] rootPS < 2^1333 := by decide +kernel

def env3534 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,1077,40,1124,32768,65536,1124,32768,99498,32768,1077,33,64,98336,161,17,32768,1125,1077,0,1056,4294967296,37,4294967297,1125,136]

theorem envBound3534 : H12AffineFastState.Bounded env3534 := by
  intro p hp
  have h : env3534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3533_3534 : H12AffineEnvironment.transform 7 37 env3533 = env3534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env3533 == env3534) = true)

theorem identity3534 : scanCanonicalize (H12AffineFastState.compose env3534 (packedSelected [1,3,4] rootPS)) = affineNative (2^(14+1) ^^^ 152) := by decide +kernel

theorem selectedBound3534 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env3535 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,1077,40,1124,152,65536,1124,152,66610,152,1077,33,64,65720,161,17,152,1125,1077,0,1056,4294967296,37,4294967297,1125,136]

theorem envBound3535 : H12AffineFastState.Bounded env3535 := by
  intro p hp
  have h : env3535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3534_3535 : H12AffineEnvironment.transform 14 152 env3534 = env3535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 152 env3534 == env3535) = true)

theorem identity3535 : scanCanonicalize (H12AffineFastState.compose env3535 (packedSelected [1,3,12] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound3535 : packedSelected [1,3,12] rootPS < 2^1333 := by decide +kernel

def env3536 : List Nat := [2,4,8,16,32,64,25,37,16,1024,1,1077,40,1124,1,65536,1124,1,66610,1,1077,33,64,65569,56,17,1,1125,1077,0,1056,4294967296,37,4294967297,1125,17]

theorem envBound3536 : H12AffineFastState.Bounded env3536 := by
  intro p hp
  have h : env3536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3535_3536 : H12AffineEnvironment.transform 6 25 env3535 = env3536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env3535 == env3536) = true)

theorem identity3536 : scanCanonicalize (H12AffineFastState.compose env3536 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 107) := by decide +kernel

theorem selectedBound3536 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3537 : List Nat := [2,4,8,16,32,64,25,37,16,1024,1,1077,40,1124,1,65536,1124,1,66610,1,1077,33,64,65569,56,17,1,1125,1077,0,1056,107,37,106,1125,17]

theorem envBound3537 : H12AffineFastState.Bounded env3537 := by
  intro p hp
  have h : env3537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3536_3537 : H12AffineEnvironment.transform 31 107 env3536 = env3537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 107 env3536 == env3537) = true)

def env3538 : List Nat := [2,4,8,16,32,64,25,37,16,1024,1,1077,40,1124,1,88,1124,1,1130,1,1077,33,64,121,56,17,1,1125,1077,0,1056,107,37,106,1125,17]

theorem envBound3538 : H12AffineFastState.Bounded env3538 := by
  intro p hp
  have h : env3538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3537_3538 : H12AffineEnvironment.transform 15 88 env3537 = env3538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 88 env3537 == env3538) = true)

theorem identity3538 : scanCanonicalize (H12AffineFastState.compose env3538 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound3538 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3539 : List Nat := [2,4,8,16,11,64,25,14,16,1024,1,1054,3,1103,1,88,1103,1,1089,1,1054,10,64,82,19,17,1,1102,1054,0,1035,64,14,65,1102,17]

theorem envBound3539 : H12AffineFastState.Bounded env3539 := by
  intro p hp
  have h : env3539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3538_3539 : H12AffineEnvironment.transform 4 11 env3538 = env3539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env3538 == env3539) = true)

def env3540 : List Nat := [2,4,8,16,11,0,25,14,16,1024,1,1054,3,1039,1,24,1039,1,1025,1,1054,10,0,18,19,17,1,1038,1054,0,1035,0,14,1,1038,17]

theorem envBound3540 : H12AffineFastState.Bounded env3540 := by
  intro p hp
  have h : env3540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3539_3540 : H12AffineEnvironment.transform 5 0 env3539 = env3540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3539 == env3540) = true)

def leafEnv3540 : List Nat := [2,4,8,16,11,0,25,14,16,1024,1,1054,3,1039,1,24,1039,1,1025,1,1054,10,0,18,1034,19,1,17,1,1038,1054,0,1035,0,14,1,4,9,1038,17,0,1054,1]

def active3540 : List Nat := [0,1,2,3,9]

def tree3540 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3540 : H12WitnessSearch.Good tree3540 := H12GlobalWitnessIndex.good

theorem leafIdentity3540 : H12AffineFastState.composeSystem env3540 rootObs = leafEnv3540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3540 rootObs == leafEnv3540) = true)

theorem terminalChecked3540 : H12PackedTerminal.terminalCheckFast leafEnv3540 active3540 tree3540 = true := by decide +kernel

def env3541 : List Nat := [2,4,8,16,11,1,25,14,16,1024,1,1054,3,1038,1,25,1038,1,1024,1,1054,10,1,19,19,17,1,1039,1054,0,1035,1,14,0,1039,17]

theorem envBound3541 : H12AffineFastState.Bounded env3541 := by
  intro p hp
  have h : env3541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3539_3541 : H12AffineEnvironment.transform 5 1 env3539 = env3541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env3539 == env3541) = true)

theorem identity3541 : scanCanonicalize (H12AffineFastState.compose env3541 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3541 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3542 : List Nat := [2,4,2,16,1,1,19,4,16,1024,1,1044,3,1028,1,19,1028,1,1024,1,1044,0,1,19,19,17,1,1029,1044,0,1025,1,4,0,1029,17]

theorem envBound3542 : H12AffineFastState.Bounded env3542 := by
  intro p hp
  have h : env3542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3541_3542 : H12AffineEnvironment.transform 2 2 env3541 = env3542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3541 == env3542) = true)

def leafEnv3542 : List Nat := [2,4,2,16,1,1,19,4,16,1024,1,1044,3,1028,1,19,1028,1,1024,1,1044,0,1,19,1025,19,1,17,1,1029,1044,0,1025,1,4,0,4,3,1029,17,0,1044,1]

def active3542 : List Nat := [0,1,3,9]

def tree3542 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3542 : H12WitnessSearch.Good tree3542 := H12GlobalWitnessIndex.good

theorem leafIdentity3542 : H12AffineFastState.composeSystem env3542 rootObs = leafEnv3542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3542 rootObs == leafEnv3542) = true)

theorem terminalChecked3542 : H12PackedTerminal.terminalCheckFast leafEnv3542 active3542 tree3542 = true := by decide +kernel

def env3543 : List Nat := [2,4,8,16,32,64,25,37,16,1024,1,1077,40,1124,1,89,1124,1,1131,1,1077,33,64,120,56,17,1,1125,1077,0,1056,107,37,106,1125,17]

theorem envBound3543 : H12AffineFastState.Bounded env3543 := by
  intro p hp
  have h : env3543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3537_3543 : H12AffineEnvironment.transform 15 89 env3537 = env3543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 89 env3537 == env3543) = true)

theorem identity3543 : scanCanonicalize (H12AffineFastState.compose env3543 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound3543 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3544 : List Nat := [2,4,8,16,32,0,25,37,16,1024,1,1077,40,1060,1,25,1060,1,1067,1,1077,33,0,56,56,17,1,1061,1077,0,1056,43,37,42,1061,17]

theorem envBound3544 : H12AffineFastState.Bounded env3544 := by
  intro p hp
  have h : env3544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3543_3544 : H12AffineEnvironment.transform 5 0 env3543 = env3544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3543 == env3544) = true)

theorem identity3544 : scanCanonicalize (H12AffineFastState.compose env3544 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound3544 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3545 : List Nat := [2,4,8,16,10,0,25,15,16,1024,1,1055,2,1038,1,25,1038,1,1025,1,1055,11,0,18,18,17,1,1039,1055,0,1034,1,15,0,1039,17]

theorem envBound3545 : H12AffineFastState.Bounded env3545 := by
  intro p hp
  have h : env3545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3544_3545 : H12AffineEnvironment.transform 4 10 env3544 = env3545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env3544 == env3545) = true)

def leafEnv3545 : List Nat := [2,4,8,16,10,0,25,15,16,1024,1,1055,2,1038,1,25,1038,1,1025,1,1055,11,0,18,1035,18,1,17,1,1039,1055,0,1034,1,15,0,4,8,1039,17,0,1055,1]

def active3545 : List Nat := [0,1,2,3,9]

def tree3545 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3545 : H12WitnessSearch.Good tree3545 := H12GlobalWitnessIndex.good

theorem leafIdentity3545 : H12AffineFastState.composeSystem env3545 rootObs = leafEnv3545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3545 rootObs == leafEnv3545) = true)

theorem terminalChecked3545 : H12PackedTerminal.terminalCheckFast leafEnv3545 active3545 tree3545 = true := by decide +kernel

def env3546 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,32768,65536,17033,262144,524288,32768,1297,8201,17665,116429,8329,16,271237,16385,17112,0,17101,4294967296,256,4295599918,17032,513]

theorem envBound3546 : H12AffineFastState.Bounded env3546 := by
  intro p hp
  have h : env3546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3525_3546 : H12AffineEnvironment.transform 11 1297 env3525 = env3546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3525 == env3546) = true)

theorem identity3546 : scanCanonicalize (H12AffineFastState.compose env3546 (packedSelected [18] rootPS)) = affineNative (2^(17+1) ^^^ 33060) := by decide +kernel

theorem selectedBound3546 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3547 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,32768,65536,17033,33060,524288,32768,1297,8201,17665,116429,8329,16,41633,16385,17112,0,17101,4294967296,256,4295599918,17032,513]

theorem envBound3547 : H12AffineFastState.Bounded env3547 := by
  intro p hp
  have h : env3547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3546_3547 : H12AffineEnvironment.transform 17 33060 env3546 = env3547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 33060 env3546 == env3547) = true)

theorem identity3547 : scanCanonicalize (H12AffineFastState.compose env3547 (packedSelected [2,5,6,7,8,9,10,12,17,20] rootPS)) = affineNative (2^(18+1) ^^^ 100102) := by decide +kernel

theorem selectedBound3547 : packedSelected [2,5,6,7,8,9,10,12,17,20] rootPS < 2^1333 := by decide +kernel

def env3548 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,32768,65536,17033,33060,100102,32768,1297,8201,17665,116429,8329,16,41633,16385,17112,0,17101,4294967296,256,4294975528,17032,513]

theorem envBound3548 : H12AffineFastState.Bounded env3548 := by
  intro p hp
  have h : env3548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3547_3548 : H12AffineEnvironment.transform 18 100102 env3547 = env3548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 100102 env3547 == env3548) = true)

theorem identity3548 : scanCanonicalize (H12AffineFastState.compose env3548 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3548 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3549 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,16384,32768,65536,16384,33060,99727,32768,1297,8201,17665,115780,8329,16,41000,16385,16465,0,16452,4294967296,256,4294975528,16385,136]

theorem envBound3549 : H12AffineFastState.Bounded env3549 := by
  intro p hp
  have h : env3549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3548_3549 : H12AffineEnvironment.transform 8 137 env3548 = env3549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3548 == env3549) = true)

theorem identity3549 : scanCanonicalize (H12AffineFastState.compose env3549 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 58819) := by decide +kernel

theorem selectedBound3549 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3550 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,16384,32768,58819,16384,33060,24652,32768,1297,8201,17665,8583,8329,16,41000,16385,16465,0,16452,4294967296,256,4294975528,16385,136]

theorem envBound3550 : H12AffineFastState.Bounded env3550 := by
  intro p hp
  have h : env3550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3549_3550 : H12AffineEnvironment.transform 15 58819 env3549 = env3550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 58819 env3549 == env3550) = true)

def env3551 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17665,230468,8329,5376,422940,16384,131153,1073741824,131140,4294967296,256,4295749815,131073,513]

theorem envBound3551 : H12AffineFastState.Bounded env3551 := by
  intro p hp
  have h : env3551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3498_3551 : H12AffineEnvironment.transform 20 4097 env3498 = env3551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env3498 == env3551) = true)

theorem identity3551 : scanCanonicalize (H12AffineFastState.compose env3551 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 153545) := by decide +kernel

theorem selectedBound3551 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3552 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17665,230468,8329,5376,422940,16384,131153,153545,131140,4294967296,256,4295749815,131073,513]

theorem envBound3552 : H12AffineFastState.Bounded env3552 := by
  intro p hp
  have h : env3552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3551_3552 : H12AffineEnvironment.transform 29 153545 env3551 = env3552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 153545 env3551 == env3552) = true)

theorem identity3552 : scanCanonicalize (H12AffineFastState.compose env3552 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound3552 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env3553 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,21585,32768,4097,8201,17665,230468,8329,5376,422940,16384,131153,153545,131140,4294967296,256,4295206118,131073,513]

theorem envBound3553 : H12AffineFastState.Bounded env3553 := by
  intro p hp
  have h : env3553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3552_3553 : H12AffineEnvironment.transform 18 21585 env3552 = env3553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env3552 == env3553) = true)

theorem identity3553 : scanCanonicalize (H12AffineFastState.compose env3553 (packedSelected [4,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 128843) := by decide +kernel

theorem selectedBound3553 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3554 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,128843,262144,21585,32768,4097,8201,17665,29455,8329,5376,361303,16384,128794,106626,128783,4294967296,256,4294988717,128842,513]

theorem envBound3554 : H12AffineFastState.Bounded env3554 := by
  intro p hp
  have h : env3554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3553_3554 : H12AffineEnvironment.transform 16 128843 env3553 = env3554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 128843 env3553 == env3554) = true)

theorem identity3554 : scanCanonicalize (H12AffineFastState.compose env3554 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound3554 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env3555 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,108315,262144,1025,32768,4097,8201,5457,9055,8329,5376,361303,4176,108362,106626,108383,4294967296,256,4294968317,108314,513]

theorem envBound3555 : H12AffineFastState.Bounded env3555 := by
  intro p hp
  have h : env3555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3554_3555 : H12AffineEnvironment.transform 13 4176 env3554 = env3555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3554 == env3555) = true)

theorem identity3555 : scanCanonicalize (H12AffineFastState.compose env3555 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound3555 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env3556 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,8540,65536,67143,262144,1025,8540,4097,8201,5457,9055,8329,5376,336395,4176,67094,66014,67075,4294967296,256,4294968317,67142,513]

theorem envBound3556 : H12AffineFastState.Bounded env3556 := by
  intro p hp
  have h : env3556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3555_3556 : H12AffineEnvironment.transform 14 8540 env3555 = env3556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env3555 == env3556) = true)

def env3557 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17665,230468,33554432,2098433,2518045,2117633,131153,1073741824,131140,4294967296,256,4331391039,131073,33563272]

theorem envBound3557 : H12AffineFastState.Bounded env3557 := by
  intro p hp
  have h : env3557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3379_3557 : H12AffineEnvironment.transform 21 10249 env3379 = env3557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env3379 == env3557) = true)

def env3558 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17665,230468,8328,2098433,2518045,2117633,131153,1073741824,131140,4294967296,256,4297844919,131073,512]

theorem envBound3558 : H12AffineFastState.Bounded env3558 := by
  intro p hp
  have h : env3558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3557_3558 : H12AffineEnvironment.transform 24 8328 env3557 = env3558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env3557 == env3558) = true)

theorem identity3558 : scanCanonicalize (H12AffineFastState.compose env3558 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 2220243) := by decide +kernel

theorem selectedBound3558 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env3559 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17665,230468,8328,2098433,2518045,2117633,131153,2220243,131140,4294967296,256,4297844919,131073,512]

theorem envBound3559 : H12AffineFastState.Bounded env3559 := by
  intro p hp
  have h : env3559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3558_3559 : H12AffineEnvironment.transform 29 2220243 env3558 = env3559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2220243 env3558 == env3559) = true)

theorem identity3559 : scanCanonicalize (H12AffineFastState.compose env3559 (packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 57692) := by decide +kernel

theorem selectedBound3559 : packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3560 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,57692,10249,17665,230468,8328,58461,429377,45405,131153,65935,131140,4294967296,256,4295690731,131073,512]

theorem envBound3560 : H12AffineFastState.Bounded env3560 := by
  intro p hp
  have h : env3560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3559_3560 : H12AffineEnvironment.transform 20 57692 env3559 = env3560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 57692 env3559 == env3560) = true)

theorem identity3560 : scanCanonicalize (H12AffineFastState.compose env3560 (packedSelected [1,3,6,17,21,24,25,28] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound3560 : packedSelected [1,3,6,17,21,24,25,28] rootPS < 2^1333 := by decide +kernel

def env3561 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,131072,262144,524288,8460,16464,10249,17665,206152,8328,17745,404557,4177,131153,65935,131140,4294967296,256,4295690731,131073,512]

theorem envBound3561 : H12AffineFastState.Bounded env3561 := by
  intro p hp
  have h : env3561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3560_3561 : H12AffineEnvironment.transform 14 8460 env3560 = env3561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env3560 == env3561) = true)

theorem identity3561 : scanCanonicalize (H12AffineFastState.compose env3561 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(16+1) ^^^ 11461) := by decide +kernel

theorem selectedBound3561 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env3562 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,11461,262144,524288,8460,16464,10249,17665,67981,8328,17745,262280,4177,11412,65935,11393,4294967296,256,4295566638,11460,512]

theorem envBound3562 : H12AffineFastState.Bounded env3562 := by
  intro p hp
  have h : env3562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3561_3562 : H12AffineEnvironment.transform 16 11461 env3561 = env3562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 11461 env3561 == env3562) = true)

def env3563 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,11461,2048,524288,8460,16464,10249,17665,67981,8328,17745,2184,4177,11412,65935,11393,4294967296,256,4295566638,11460,512]

theorem envBound3563 : H12AffineFastState.Bounded env3563 := by
  intro p hp
  have h : env3563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3562_3563 : H12AffineEnvironment.transform 17 2048 env3562 = env3563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2048 env3562 == env3563) = true)

theorem identity3563 : scanCanonicalize (H12AffineFastState.compose env3563 (packedSelected [0,4,7,11,16,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 2311) := by decide +kernel

theorem selectedBound3563 : packedSelected [0,4,7,11,16,22,23] rootPS < 2^1333 := by decide +kernel

def env3564 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,2311,11461,2048,524288,8460,16464,10249,17665,138,8328,17745,2184,4177,11412,2184,11393,4294967296,256,4295502889,11460,512]

theorem envBound3564 : H12AffineFastState.Bounded env3564 := by
  intro p hp
  have h : env3564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3563_3564 : H12AffineEnvironment.transform 15 2311 env3563 = env3564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2311 env3563 == env3564) = true)

theorem identity3564 : scanCanonicalize (H12AffineFastState.compose env3564 (packedSelected [16,20] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3564 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env3565 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,16384,8232,2083,11461,2048,524288,8232,16464,10249,17445,138,8328,17525,2184,4177,11412,2184,11393,4294967296,36,4295502889,11460,512]

theorem envBound3565 : H12AffineFastState.Bounded env3565 := by
  intro p hp
  have h : env3565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3564_3565 : H12AffineEnvironment.transform 7 36 env3564 = env3565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3564 == env3565) = true)

theorem identity3565 : scanCanonicalize (H12AffineFastState.compose env3565 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 539374) := by decide +kernel

theorem selectedBound3565 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env3566 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,16384,8232,2083,11461,2048,524288,8232,16464,10249,17445,138,8328,17525,2184,4177,11412,2184,11393,539374,36,5831,11460,512]

theorem envBound3566 : H12AffineFastState.Bounded env3566 := by
  intro p hp
  have h : env3566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3565_3566 : H12AffineEnvironment.transform 31 539374 env3565 = env3566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 539374 env3565 == env3566) = true)

def env3567 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4176,8232,2083,11461,2048,524288,8232,4096,10249,5237,138,8328,5157,2184,4177,11412,2184,11393,539374,36,5831,11460,512]

theorem envBound3567 : H12AffineFastState.Bounded env3567 := by
  intro p hp
  have h : env3567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3566_3567 : H12AffineEnvironment.transform 13 4176 env3566 = env3567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3566 == env3567) = true)

theorem identity3567 : scanCanonicalize (H12AffineFastState.compose env3567 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 11779) := by decide +kernel

theorem selectedBound3567 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3568 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4176,8232,2083,11461,2048,11779,8232,4096,10249,5237,138,8328,5157,2184,4177,11412,2184,11393,5357,36,5831,11460,512]

theorem envBound3568 : H12AffineFastState.Bounded env3568 := by
  intro p hp
  have h : env3568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3567_3568 : H12AffineEnvironment.transform 18 11779 env3567 = env3568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 11779 env3567 == env3568) = true)

theorem identity3568 : scanCanonicalize (H12AffineFastState.compose env3568 (packedSelected [11] rootPS)) = affineNative (2^(12+1) ^^^ 5300) := by decide +kernel

theorem selectedBound3568 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3569 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,5300,4176,5276,2083,6257,2048,6839,5276,4096,7357,5237,138,5180,5157,2184,4177,6176,2184,6197,5357,36,5831,6256,512]

theorem envBound3569 : H12AffineFastState.Bounded env3569 := by
  intro p hp
  have h : env3569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3568_3569 : H12AffineEnvironment.transform 12 5300 env3568 = env3569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5300 env3568 == env3569) = true)

theorem identity3569 : scanCanonicalize (H12AffineFastState.compose env3569 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 1566) := by decide +kernel

theorem selectedBound3569 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env3570 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,1566,682,1614,642,2083,3695,2048,3241,642,1566,2723,619,138,546,571,2184,1615,3646,2184,3627,755,36,217,3694,512]

theorem envBound3570 : H12AffineFastState.Bounded env3570 := by
  intro p hp
  have h : env3570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3569_3570 : H12AffineEnvironment.transform 11 1566 env3569 = env3570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1566 env3569 == env3570) = true)

theorem identity3570 : scanCanonicalize (H12AffineFastState.compose env3570 (packedSelected [1,3,6] rootPS)) = affineNative (2^(10+1) ^^^ 642) := by decide +kernel

theorem selectedBound3570 : packedSelected [1,3,6] rootPS < 2^1333 := by decide +kernel

def env3571 : List Nat := [2,4,8,16,32,64,128,36,512,1024,642,1566,682,1614,642,673,1261,642,1579,642,1566,33,619,138,546,571,522,1615,1212,522,1193,755,36,217,1260,512]

theorem envBound3571 : H12AffineFastState.Bounded env3571 := by
  intro p hp
  have h : env3571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3570_3571 : H12AffineEnvironment.transform 10 642 env3570 = env3571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 642 env3570 == env3571) = true)

theorem identity3571 : scanCanonicalize (H12AffineFastState.compose env3571 (packedSelected [0,2,4] rootPS)) = affineNative (2^(8+1) ^^^ 162) := by decide +kernel

theorem selectedBound3571 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env3572 : List Nat := [2,4,8,16,32,64,128,36,162,1024,32,1212,8,1260,32,3,1261,32,1161,32,1212,33,201,138,128,153,168,1261,1212,168,1193,81,36,217,1260,162]

theorem envBound3572 : H12AffineFastState.Bounded env3572 := by
  intro p hp
  have h : env3572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3571_3572 : H12AffineEnvironment.transform 8 162 env3571 = env3572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 162 env3571 == env3572) = true)

theorem identity3572 : scanCanonicalize (H12AffineFastState.compose env3572 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound3572 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3573 : List Nat := [2,4,8,16,32,64,9,36,43,1024,32,1077,8,1125,32,3,1124,32,1024,32,1077,33,64,3,9,16,33,1124,1077,33,1056,81,36,80,1125,43]

theorem envBound3573 : H12AffineFastState.Bounded env3573 := by
  intro p hp
  have h : env3573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3572_3573 : H12AffineEnvironment.transform 6 9 env3572 = env3573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env3572 == env3573) = true)

theorem identity3573 : scanCanonicalize (H12AffineFastState.compose env3573 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3573 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3574 : List Nat := [2,4,8,2,32,64,9,36,43,1024,32,1063,8,1125,32,3,1124,32,1024,32,1063,33,64,3,9,2,33,1124,1063,33,1056,67,36,66,1125,43]

theorem envBound3574 : H12AffineFastState.Bounded env3574 := by
  intro p hp
  have h : env3574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3573_3574 : H12AffineEnvironment.transform 3 2 env3573 = env3574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3573 == env3574) = true)

theorem identity3574 : scanCanonicalize (H12AffineFastState.compose env3574 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 40) := by decide +kernel

theorem selectedBound3574 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3575 : List Nat := [2,4,8,2,32,40,9,36,43,1024,32,1063,8,1037,32,3,1036,32,1024,32,1063,33,40,3,9,2,33,1036,1063,33,1056,43,36,42,1037,43]

theorem envBound3575 : H12AffineFastState.Bounded env3575 := by
  intro p hp
  have h : env3575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3574_3575 : H12AffineEnvironment.transform 5 40 env3574 = env3575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 40 env3574 == env3575) = true)

theorem identity3575 : scanCanonicalize (H12AffineFastState.compose env3575 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound3575 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env3576 : List Nat := [2,4,8,2,32,40,9,36,43,14,32,41,8,3,32,3,2,32,14,32,41,33,40,3,9,2,33,2,41,33,46,43,36,42,3,43]

theorem envBound3576 : H12AffineFastState.Bounded env3576 := by
  intro p hp
  have h : env3576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3575_3576 : H12AffineEnvironment.transform 9 14 env3575 = env3576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env3575 == env3576) = true)

theorem identity3576 : scanCanonicalize (H12AffineFastState.compose env3576 (packedSelected [13] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound3576 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env3577 : List Nat := [2,4,8,2,11,3,9,15,0,14,11,2,8,3,11,3,2,11,14,11,2,10,3,3,9,2,10,2,2,10,5,0,15,1,3,0]

theorem envBound3577 : H12AffineFastState.Bounded env3577 := by
  intro p hp
  have h : env3577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3576_3577 : H12AffineEnvironment.transform 4 11 env3576 = env3577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env3576 == env3577) = true)

def leafEnv3577 : List Nat := [2,4,8,2,11,3,9,15,0,14,11,2,8,3,11,3,2,11,14,11,2,10,3,3,5,9,1,2,10,2,2,10,5,0,15,1,4,2,3,0,0,2,1]

def active3577 : List Nat := [0,1,2]

def tree3577 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3577 : H12WitnessSearch.Good tree3577 := H12GlobalWitnessIndex.good

theorem leafIdentity3577 : H12AffineFastState.composeSystem env3577 rootObs = leafEnv3577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3577 rootObs == leafEnv3577) = true)

theorem terminalChecked3577 : H12PackedTerminal.terminalCheckFast leafEnv3577 active3577 tree3577 = true := by decide +kernel

def env3578 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4177,8232,2083,11461,2048,524288,8232,4097,10249,5236,138,8328,5156,2184,4177,11412,2184,11393,539374,36,5831,11460,512]

theorem envBound3578 : H12AffineFastState.Bounded env3578 := by
  intro p hp
  have h : env3578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3566_3578 : H12AffineEnvironment.transform 13 4177 env3566 = env3578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env3566 == env3578) = true)

theorem identity3578 : scanCanonicalize (H12AffineFastState.compose env3578 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1699) := by decide +kernel

theorem selectedBound3578 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3579 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4177,8232,2083,11461,2048,1699,8232,4097,10249,5236,138,8328,5156,2184,4177,11412,2184,11393,15437,36,5831,11460,512]

theorem envBound3579 : H12AffineFastState.Bounded env3579 := by
  intro p hp
  have h : env3579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3578_3579 : H12AffineEnvironment.transform 18 1699 env3578 = env3579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1699 env3578 == env3579) = true)

theorem identity3579 : scanCanonicalize (H12AffineFastState.compose env3579 (packedSelected [11] rootPS)) = affineNative (2^(12+1) ^^^ 209) := by decide +kernel

theorem selectedBound3579 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3580 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,209,4177,249,2083,3092,2048,1699,249,4097,2264,5236,138,89,5156,2184,4177,3141,2184,3152,7324,36,5831,3093,512]

theorem envBound3580 : H12AffineFastState.Bounded env3580 := by
  intro p hp
  have h : env3580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3579_3580 : H12AffineEnvironment.transform 12 209 env3579 = env3580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 209 env3579 == env3580) = true)

def env3581 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,11461,2049,524288,8460,16464,10249,17665,67981,8328,17745,2185,4177,11412,65935,11393,4294967296,256,4295566638,11460,512]

theorem envBound3581 : H12AffineFastState.Bounded env3581 := by
  intro p hp
  have h : env3581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3562_3581 : H12AffineEnvironment.transform 17 2049 env3562 = env3581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2049 env3562 == env3581) = true)

theorem identity3581 : scanCanonicalize (H12AffineFastState.compose env3581 (packedSelected [0,4,7,11,16,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound3581 : packedSelected [0,4,7,11,16,22,23] rootPS < 2^1333 := by decide +kernel

def env3582 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,2082,11461,2049,524288,8460,16464,10249,17665,431,8328,17745,2185,4177,11412,2477,11393,4294967296,256,4295503116,11460,512]

theorem envBound3582 : H12AffineFastState.Bounded env3582 := by
  intro p hp
  have h : env3582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3581_3582 : H12AffineEnvironment.transform 15 2082 env3581 = env3582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env3581 == env3582) = true)

theorem identity3582 : scanCanonicalize (H12AffineFastState.compose env3582 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 539459) := by decide +kernel

theorem selectedBound3582 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env3583 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,2082,11461,2049,524288,8460,16464,10249,17665,431,8328,17745,2185,4177,11412,2477,11393,539459,256,5711,11460,512]

theorem envBound3583 : H12AffineFastState.Bounded env3583 := by
  intro p hp
  have h : env3583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3582_3583 : H12AffineEnvironment.transform 31 539459 env3582 = env3583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 539459 env3582 == env3583) = true)

theorem identity3583 : scanCanonicalize (H12AffineFastState.compose env3583 (packedSelected [11,18,20] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound3583 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env3584 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,16384,8233,2082,11461,2049,524288,8233,16464,10249,17444,138,8328,17524,2185,4177,11412,2184,11393,539238,37,5711,11460,512]

theorem envBound3584 : H12AffineFastState.Bounded env3584 := by
  intro p hp
  have h : env3584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3583_3584 : H12AffineEnvironment.transform 7 37 env3583 = env3584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env3583 == env3584) = true)

def env3585 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4176,8233,2082,11461,2049,524288,8233,4096,10249,5236,138,8328,5156,2185,4177,11412,2184,11393,539238,37,5711,11460,512]

theorem envBound3585 : H12AffineFastState.Bounded env3585 := by
  intro p hp
  have h : env3585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3584_3585 : H12AffineEnvironment.transform 13 4176 env3584 = env3585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3584 == env3585) = true)

theorem identity3585 : scanCanonicalize (H12AffineFastState.compose env3585 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 11915) := by decide +kernel

theorem selectedBound3585 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3586 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4176,8233,2082,11461,2049,11915,8233,4096,10249,5236,138,8328,5156,2185,4177,11412,2184,11393,5357,37,5711,11460,512]

theorem envBound3586 : H12AffineFastState.Bounded env3586 := by
  intro p hp
  have h : env3586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3585_3586 : H12AffineEnvironment.transform 18 11915 env3585 = env3586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 11915 env3585 == env3586) = true)

theorem identity3586 : scanCanonicalize (H12AffineFastState.compose env3586 (packedSelected [11] rootPS)) = affineNative (2^(12+1) ^^^ 5300) := by decide +kernel

theorem selectedBound3586 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3587 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,5300,4176,5277,2082,6257,2049,6719,5277,4096,7357,5236,138,5180,5156,2185,4177,6176,2184,6197,5357,37,5711,6256,512]

theorem envBound3587 : H12AffineFastState.Bounded env3587 := by
  intro p hp
  have h : env3587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3586_3587 : H12AffineEnvironment.transform 12 5300 env3586 = env3587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5300 env3586 == env3587) = true)

theorem identity3587 : scanCanonicalize (H12AffineFastState.compose env3587 (packedSelected [0,2,6,22] rootPS)) = affineNative (2^(11+1) ^^^ 3092) := by decide +kernel

theorem selectedBound3587 : packedSelected [0,2,6,22] rootPS < 2^1333 := by decide +kernel

def env3588 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,3092,2208,3140,2185,2082,1125,2049,1579,2185,3092,169,2144,138,2088,2096,2185,3141,1076,2184,1057,2297,37,2651,1124,512]

theorem envBound3588 : H12AffineFastState.Bounded env3588 := by
  intro p hp
  have h : env3588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3587_3588 : H12AffineEnvironment.transform 11 3092 env3587 = env3588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3092 env3587 == env3588) = true)

theorem identity3588 : scanCanonicalize (H12AffineFastState.compose env3588 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 186) := by decide +kernel

theorem selectedBound3588 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3589 : List Nat := [2,4,8,16,32,64,128,37,512,1024,186,1198,26,1278,51,152,1125,187,1579,51,1198,169,218,138,146,138,51,1279,1076,50,1057,67,37,737,1124,512]

theorem envBound3589 : H12AffineFastState.Bounded env3589 := by
  intro p hp
  have h : env3589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3588_3589 : H12AffineEnvironment.transform 10 186 env3588 = env3589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 186 env3588 == env3589) = true)

theorem identity3589 : scanCanonicalize (H12AffineFastState.compose env3589 (packedSelected [2,4] rootPS)) = affineNative (2^(8+1) ^^^ 163) := by decide +kernel

theorem selectedBound3589 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3590 : List Nat := [2,4,8,16,32,64,128,37,163,1024,186,1198,26,1278,51,152,1125,187,1160,51,1198,169,218,138,146,138,51,1279,1076,50,1057,67,37,66,1124,163]

theorem envBound3590 : H12AffineFastState.Bounded env3590 := by
  intro p hp
  have h : env3590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3589_3590 : H12AffineEnvironment.transform 8 163 env3589 = env3590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 163 env3589 == env3590) = true)

theorem identity3590 : scanCanonicalize (H12AffineFastState.compose env3590 (packedSelected [6] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3590 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3591 : List Nat := [2,4,8,16,32,64,8,37,43,1024,50,1062,26,1142,51,16,1125,51,1024,51,1062,33,82,2,26,2,51,1143,1076,50,1057,67,37,66,1124,43]

theorem envBound3591 : H12AffineFastState.Bounded env3591 := by
  intro p hp
  have h : env3591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3590_3591 : H12AffineEnvironment.transform 6 8 env3590 = env3591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3590 == env3591) = true)

theorem identity3591 : scanCanonicalize (H12AffineFastState.compose env3591 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 103) := by decide +kernel

theorem selectedBound3591 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env3592 : List Nat := [2,4,8,16,32,64,8,37,43,103,50,65,26,17,51,16,2,51,103,51,65,33,82,2,26,2,51,16,83,50,70,67,37,66,3,43]

theorem envBound3592 : H12AffineFastState.Bounded env3592 := by
  intro p hp
  have h : env3592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3591_3592 : H12AffineEnvironment.transform 9 103 env3591 = env3592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 103 env3591 == env3592) = true)

theorem identity3592 : scanCanonicalize (H12AffineFastState.compose env3592 (packedSelected [13] rootPS)) = affineNative (2^(5+1) ^^^ 3) := by decide +kernel

theorem selectedBound3592 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env3593 : List Nat := [2,4,8,16,32,3,8,37,43,36,50,2,26,17,51,16,2,51,36,51,2,33,17,2,26,2,51,16,16,50,5,0,37,1,3,43]

theorem envBound3593 : H12AffineFastState.Bounded env3593 := by
  intro p hp
  have h : env3593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3592_3593 : H12AffineEnvironment.transform 5 3 env3592 = env3593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 3 env3592 == env3593) = true)

theorem identity3593 : scanCanonicalize (H12AffineFastState.compose env3593 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound3593 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3594 : List Nat := [2,4,8,16,10,3,8,15,1,14,24,2,26,17,25,16,2,25,14,25,2,11,17,2,26,2,25,16,16,24,5,0,15,1,3,1]

theorem envBound3594 : H12AffineFastState.Bounded env3594 := by
  intro p hp
  have h : env3594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3593_3594 : H12AffineEnvironment.transform 4 10 env3593 = env3594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env3593 == env3594) = true)

def leafEnv3594 : List Nat := [2,4,8,16,10,3,8,15,1,14,24,2,26,17,25,16,2,25,14,25,2,11,17,2,5,26,1,2,25,16,16,24,5,0,15,1,4,16,3,1,0,16,1]

def active3594 : List Nat := [0,1,2,3]

def tree3594 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3594 : H12WitnessSearch.Good tree3594 := H12GlobalWitnessIndex.good

theorem leafIdentity3594 : H12AffineFastState.composeSystem env3594 rootObs = leafEnv3594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3594 rootObs == leafEnv3594) = true)

theorem terminalChecked3594 : H12PackedTerminal.terminalCheckFast leafEnv3594 active3594 tree3594 = true := by decide +kernel

def env3595 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4177,8233,2082,11461,2049,524288,8233,4097,10249,5237,138,8328,5157,2185,4177,11412,2184,11393,539238,37,5711,11460,512]

theorem envBound3595 : H12AffineFastState.Bounded env3595 := by
  intro p hp
  have h : env3595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3584_3595 : H12AffineEnvironment.transform 13 4177 env3584 = env3595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env3584 == env3595) = true)

theorem identity3595 : scanCanonicalize (H12AffineFastState.compose env3595 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1578) := by decide +kernel

theorem selectedBound3595 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3596 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4177,8233,2082,11461,2049,1578,8233,4097,10249,5237,138,8328,5157,2185,4177,11412,2184,11393,15436,37,5711,11460,512]

theorem envBound3596 : H12AffineFastState.Bounded env3596 := by
  intro p hp
  have h : env3596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3595_3596 : H12AffineEnvironment.transform 18 1578 env3595 = env3596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1578 env3595 == env3596) = true)

theorem identity3596 : scanCanonicalize (H12AffineFastState.compose env3596 (packedSelected [11] rootPS)) = affineNative (2^(12+1) ^^^ 208) := by decide +kernel

theorem selectedBound3596 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3597 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,208,4177,249,2082,3093,2049,1578,249,4097,2265,5237,138,88,5157,2185,4177,3140,2184,3153,7324,37,5711,3092,512]

theorem envBound3597 : H12AffineFastState.Bounded env3597 := by
  intro p hp
  have h : env3597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3596_3597 : H12AffineEnvironment.transform 12 208 env3596 = env3597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 208 env3596 == env3597) = true)

theorem identity3597 : scanCanonicalize (H12AffineFastState.compose env3597 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 3814) := by decide +kernel

theorem selectedBound3597 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env3598 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,3814,208,3767,249,2082,3093,2049,1578,249,3815,2265,2707,138,88,2755,2185,3767,3140,2184,3153,634,37,2217,3092,512]

theorem envBound3598 : H12AffineFastState.Bounded env3598 := by
  intro p hp
  have h : env3598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3597_3598 : H12AffineEnvironment.transform 11 3814 env3597 = env3598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3814 env3597 == env3598) = true)

theorem identity3598 : scanCanonicalize (H12AffineFastState.compose env3598 (packedSelected [1,3,6] rootPS)) = affineNative (2^(8+1) ^^^ 43) := by decide +kernel

theorem selectedBound3598 : packedSelected [1,3,6] rootPS < 2^1333 := by decide +kernel

def env3599 : List Nat := [2,4,8,16,32,64,128,37,43,1024,2048,3277,208,3228,249,2082,3093,2049,1025,249,3276,2265,2232,138,88,2280,2185,3228,3140,2184,3153,81,37,2217,3092,43]

theorem envBound3599 : H12AffineFastState.Bounded env3599 := by
  intro p hp
  have h : env3599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3598_3599 : H12AffineEnvironment.transform 8 43 env3598 = env3599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 43 env3598 == env3599) = true)

theorem identity3599 : scanCanonicalize (H12AffineFastState.compose env3599 (packedSelected [0,1,2,3,4] rootPS)) = affineNative (2^(10+1) ^^^ 249) := by decide +kernel

theorem selectedBound3599 : packedSelected [0,1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env3600 : List Nat := [2,4,8,16,32,64,128,37,43,1024,249,1076,208,1125,249,219,1260,248,1025,249,1077,32,65,138,88,17,112,1125,1213,113,1192,81,37,80,1261,43]

theorem envBound3600 : H12AffineFastState.Bounded env3600 := by
  intro p hp
  have h : env3600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3599_3600 : H12AffineEnvironment.transform 10 249 env3599 = env3600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 249 env3599 == env3600) = true)

theorem identity3600 : scanCanonicalize (H12AffineFastState.compose env3600 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound3600 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3601 : List Nat := [2,4,8,16,11,64,128,14,0,1024,210,1055,208,1102,210,219,1223,211,1025,210,1054,11,65,138,88,17,91,1102,1174,90,1155,81,14,80,1222,0]

theorem envBound3601 : H12AffineFastState.Bounded env3601 := by
  intro p hp
  have h : env3601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3600_3601 : H12AffineEnvironment.transform 4 11 env3600 = env3601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env3600 == env3601) = true)

theorem identity3601 : scanCanonicalize (H12AffineFastState.compose env3601 (packedSelected [1,5,10] rootPS)) = affineNative (2^(9+1) ^^^ 140) := by decide +kernel

theorem selectedBound3601 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env3602 : List Nat := [2,4,8,16,11,64,128,14,0,140,210,147,208,194,210,219,75,211,141,210,146,11,65,138,88,17,91,194,26,90,15,81,14,80,74,0]

theorem envBound3602 : H12AffineFastState.Bounded env3602 := by
  intro p hp
  have h : env3602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3601_3602 : H12AffineEnvironment.transform 9 140 env3601 = env3602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 140 env3601 == env3602) = true)

theorem identity3602 : scanCanonicalize (H12AffineFastState.compose env3602 (packedSelected [1,5,13] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound3602 : packedSelected [1,5,13] rootPS < 2^1333 := by decide +kernel

def env3603 : List Nat := [2,4,8,16,11,64,88,14,0,84,10,75,8,26,10,3,75,11,85,10,74,11,65,82,88,17,91,26,26,90,15,81,14,80,74,0]

theorem envBound3603 : H12AffineFastState.Bounded env3603 := by
  intro p hp
  have h : env3603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3602_3603 : H12AffineEnvironment.transform 6 88 env3602 = env3603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env3602 == env3603) = true)

theorem identity3603 : scanCanonicalize (H12AffineFastState.compose env3603 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound3603 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3604 : List Nat := [2,4,8,16,11,26,2,14,0,14,10,17,8,26,10,3,17,11,15,10,16,11,27,8,2,17,1,26,26,0,15,11,14,10,16,0]

theorem envBound3604 : H12AffineFastState.Bounded env3604 := by
  intro p hp
  have h : env3604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3603_3604 : H12AffineEnvironment.transform 5 26 env3603 = env3604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env3603 == env3604) = true)

theorem identity3604 : scanCanonicalize (H12AffineFastState.compose env3604 (packedSelected [15] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3604 : packedSelected [15] rootPS < 2^1333 := by decide +kernel

def env3605 : List Nat := [2,4,2,16,1,16,2,4,0,4,0,17,2,16,0,3,17,1,5,0,16,1,17,2,2,17,1,16,16,0,5,1,4,0,16,0]

theorem envBound3605 : H12AffineFastState.Bounded env3605 := by
  intro p hp
  have h : env3605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3604_3605 : H12AffineEnvironment.transform 2 2 env3604 = env3605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3604 == env3605) = true)

theorem identity3605 : scanCanonicalize (H12AffineFastState.compose env3605 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound3605 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3606 : List Nat := [0,4,0,16,1,16,0,4,0,4,0,17,0,16,0,1,17,1,5,0,16,1,17,0,0,17,1,16,16,0,5,1,4,0,16,0]

theorem envBound3606 : H12AffineFastState.Bounded env3606 := by
  intro p hp
  have h : env3606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3605_3606 : H12AffineEnvironment.transform 0 0 env3605 = env3606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env3605 == env3606) = true)

def leafEnv3606 : List Nat := [0,4,0,16,1,16,0,4,0,4,0,17,0,16,0,1,17,1,5,0,16,1,17,0,4,0,1,17,1,16,16,0,5,1,4,0,4,1,16,0,0,16,1]

def active3606 : List Nat := [1,3]

def tree3606 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3606 : H12WitnessSearch.Good tree3606 := H12GlobalWitnessIndex.good

theorem leafIdentity3606 : H12AffineFastState.composeSystem env3606 rootObs = leafEnv3606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3606 rootObs == leafEnv3606) = true)

theorem terminalChecked3606 : H12PackedTerminal.terminalCheckFast leafEnv3606 active3606 tree3606 = true := by decide +kernel

def env3607 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17665,230468,8329,2098433,2518045,2117633,131153,1073741824,131140,4294967296,256,4297844918,131073,513]

theorem envBound3607 : H12AffineFastState.Bounded env3607 := by
  intro p hp
  have h : env3607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3557_3607 : H12AffineEnvironment.transform 24 8329 env3557 = env3607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env3557 == env3607) = true)

def env3608 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8201,17665,230468,8329,2098433,2515997,2117633,131153,1073741824,131140,4294967296,256,4297842870,131073,513]

theorem envBound3608 : H12AffineFastState.Bounded env3608 := by
  intro p hp
  have h : env3608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3607_3608 : H12AffineEnvironment.transform 10 0 env3607 = env3608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env3607 == env3608) = true)

def env3609 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17665,230468,8329,5377,422941,16385,131153,1073741824,131140,4294967296,256,4295749814,131073,513]

theorem envBound3609 : H12AffineFastState.Bounded env3609 := by
  intro p hp
  have h : env3609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3608_3609 : H12AffineEnvironment.transform 20 4096 env3608 = env3609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3608 == env3609) = true)

theorem identity3609 : scanCanonicalize (H12AffineFastState.compose env3609 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 50925) := by decide +kernel

theorem selectedBound3609 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3610 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17665,230468,8329,5377,422941,16385,131153,50925,131140,4294967296,256,4295749814,131073,513]

theorem envBound3610 : H12AffineFastState.Bounded env3610 := by
  intro p hp
  have h : env3610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3609_3610 : H12AffineEnvironment.transform 29 50925 env3609 = env3610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 50925 env3609 == env3610) = true)

def env3611 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,17032,262144,524288,32768,4096,8201,17665,116428,8329,5377,276117,16385,17113,50925,17100,4294967296,256,4295602750,17033,513]

theorem envBound3611 : H12AffineFastState.Bounded env3611 := by
  intro p hp
  have h : env3611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3610_3611 : H12AffineEnvironment.transform 16 17032 env3610 = env3611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17032 env3610 == env3611) = true)

theorem identity3611 : scanCanonicalize (H12AffineFastState.compose env3611 (packedSelected [16,18,32] rootPS)) = affineNative (2^(17+1) ^^^ 1) := by decide +kernel

theorem selectedBound3611 : packedSelected [16,18,32] rootPS < 2^1333 := by decide +kernel

def env3612 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,17032,1,524288,32768,4096,8201,17665,116428,8329,5377,13972,16385,17113,50925,17100,4294967296,256,4295602750,17033,513]

theorem envBound3612 : H12AffineFastState.Bounded env3612 := by
  intro p hp
  have h : env3612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3611_3612 : H12AffineEnvironment.transform 17 1 env3611 = env3612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env3611 == env3612) = true)

theorem identity3612 : scanCanonicalize (H12AffineFastState.compose env3612 (packedSelected [18,20] rootPS)) = affineNative (2^(14+1) ^^^ 28793) := by decide +kernel

theorem selectedBound3612 : packedSelected [18,20] rootPS < 2^1333 := by decide +kernel

def env3613 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,28793,65536,17032,1,524288,28793,4096,8201,17665,79541,8329,5377,13972,16385,17113,13972,17100,4294967296,256,4295574087,17033,513]

theorem envBound3613 : H12AffineFastState.Bounded env3613 := by
  intro p hp
  have h : env3613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3612_3613 : H12AffineEnvironment.transform 14 28793 env3612 = env3613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 28793 env3612 == env3613) = true)

def env3614 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,25961,65536,17032,1,524288,25961,1296,8201,17665,74661,8329,17,9092,16385,17113,9092,17100,4294967296,256,4295574087,17033,513]

theorem envBound3614 : H12AffineFastState.Bounded env3614 := by
  intro p hp
  have h : env3614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3613_3614 : H12AffineEnvironment.transform 11 1296 env3613 = env3614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3613 == env3614) = true)

theorem identity3614 : scanCanonicalize (H12AffineFastState.compose env3614 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 82410) := by decide +kernel

theorem selectedBound3614 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3615 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,25961,65536,17032,1,82410,25961,1296,8201,17665,74661,8329,17,9092,16385,17113,9092,17100,4294967296,256,4294968237,17033,513]

theorem envBound3615 : H12AffineFastState.Bounded env3615 := by
  intro p hp
  have h : env3615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3614_3615 : H12AffineEnvironment.transform 18 82410 env3614 = env3615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 82410 env3614 == env3615) = true)

theorem identity3615 : scanCanonicalize (H12AffineFastState.compose env3615 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 25830) := by decide +kernel

theorem selectedBound3615 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env3616 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,25961,25830,17032,1,9484,25961,1296,8201,17665,18243,8329,17,9092,16385,17113,9092,17100,4294967296,256,4294968237,17033,513]

theorem envBound3616 : H12AffineFastState.Bounded env3616 := by
  intro p hp
  have h : env3616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3615_3616 : H12AffineEnvironment.transform 15 25830 env3615 = env3616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25830 env3615 == env3616) = true)

theorem identity3616 : scanCanonicalize (H12AffineFastState.compose env3616 (packedSelected [0,1,2,5,6,9,13] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound3616 : packedSelected [0,1,2,5,6,9,13] rootPS < 2^1333 := by decide +kernel

def env3617 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,900,16384,18157,18274,17032,1,1672,18157,1296,909,17665,18243,781,17,0,16385,17113,0,17100,4294967296,256,4294968237,17033,513]

theorem envBound3617 : H12AffineFastState.Bounded env3617 := by
  intro p hp
  have h : env3617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3616_3617 : H12AffineEnvironment.transform 12 900 env3616 = env3617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env3616 == env3617) = true)

theorem identity3617 : scanCanonicalize (H12AffineFastState.compose env3617 (packedSelected [0,7] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound3617 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3618 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,900,1992,293,170,1344,1,1672,293,1296,909,713,139,781,17,0,1993,1297,0,1284,4294967296,256,4294968237,1345,513]

theorem envBound3618 : H12AffineFastState.Bounded env3618 := by
  intro p hp
  have h : env3618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3617_3618 : H12AffineEnvironment.transform 13 1992 env3617 = env3618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env3617 == env3618) = true)

theorem identity3618 : scanCanonicalize (H12AffineFastState.compose env3618 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 157) := by decide +kernel

theorem selectedBound3618 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3619 : List Nat := [2,4,8,16,32,64,128,157,512,1024,0,1165,537,1621,184,170,1245,1,1672,184,1165,528,713,139,656,17,0,1620,1164,0,1177,4294967296,157,4294967856,1244,513]

theorem envBound3619 : H12AffineFastState.Bounded env3619 := by
  intro p hp
  have h : env3619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3618_3619 : H12AffineEnvironment.transform 7 157 env3618 = env3619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 157 env3618 == env3619) = true)

theorem identity3619 : scanCanonicalize (H12AffineFastState.compose env3619 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 122) := by decide +kernel

theorem selectedBound3619 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3620 : List Nat := [2,4,8,16,32,64,128,157,122,1024,0,1165,99,1071,184,170,1245,1,1266,184,1165,106,179,139,234,17,0,1070,1164,0,1177,4294967296,157,4294967370,1244,123]

theorem envBound3620 : H12AffineFastState.Bounded env3620 := by
  intro p hp
  have h : env3620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3619_3620 : H12AffineEnvironment.transform 8 122 env3619 = env3620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 122 env3619 == env3620) = true)

theorem identity3620 : scanCanonicalize (H12AffineFastState.compose env3620 (packedSelected [1,3,8] rootPS)) = affineNative (2^(6+1) ^^^ 56) := by decide +kernel

theorem selectedBound3620 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env3621 : List Nat := [2,4,8,16,32,64,56,37,122,1024,0,1077,99,1071,0,18,1125,1,1098,0,1077,106,11,51,82,17,0,1070,1076,0,1057,4294967296,37,4294967370,1124,123]

theorem envBound3621 : H12AffineFastState.Bounded env3621 := by
  intro p hp
  have h : env3621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3620_3621 : H12AffineEnvironment.transform 6 56 env3620 = env3621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 56 env3620 == env3621) = true)

theorem identity3621 : scanCanonicalize (H12AffineFastState.compose env3621 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound3621 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3622 : List Nat := [2,4,8,16,32,11,56,37,49,1024,0,1077,40,1071,0,18,1070,1,1025,0,1077,33,11,51,25,17,0,1070,1076,0,1057,4294967296,37,4294967297,1071,48]

theorem envBound3622 : H12AffineFastState.Bounded env3622 := by
  intro p hp
  have h : env3622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3621_3622 : H12AffineEnvironment.transform 5 11 env3621 = env3622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env3621 == env3622) = true)

theorem identity3622 : scanCanonicalize (H12AffineFastState.compose env3622 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound3622 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3623 : List Nat := [2,4,8,16,32,11,56,37,49,1024,0,1077,40,1071,0,18,1070,1,1025,0,1077,33,11,51,25,17,0,1070,1076,0,1057,42,37,43,1071,48]

theorem envBound3623 : H12AffineFastState.Bounded env3623 := by
  intro p hp
  have h : env3623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3622_3623 : H12AffineEnvironment.transform 31 42 env3622 = env3623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env3622 == env3623) = true)

theorem identity3623 : scanCanonicalize (H12AffineFastState.compose env3623 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3623 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3624 : List Nat := [2,4,2,16,32,1,50,37,49,1024,0,1077,34,1061,0,18,1060,1,1025,0,1077,33,1,51,19,17,0,1060,1076,0,1057,32,37,33,1061,48]

theorem envBound3624 : H12AffineFastState.Bounded env3624 := by
  intro p hp
  have h : env3624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3623_3624 : H12AffineEnvironment.transform 2 2 env3623 = env3624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3623 == env3624) = true)

def env3625 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,25960,65536,17032,1,524288,25960,1297,8201,17665,74660,8329,16,9093,16385,17113,9093,17100,4294967296,256,4295574087,17033,513]

theorem envBound3625 : H12AffineFastState.Bounded env3625 := by
  intro p hp
  have h : env3625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3613_3625 : H12AffineEnvironment.transform 11 1297 env3613 = env3625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3613 == env3625) = true)

theorem identity3625 : scanCanonicalize (H12AffineFastState.compose env3625 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(13+1) ^^^ 9293) := by decide +kernel

theorem selectedBound3625 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3626 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,9293,293,65536,9925,1,524288,293,1297,8201,8524,74660,8329,16,9093,9292,9876,9093,9857,4294967296,256,4295566858,9924,513]

theorem envBound3626 : H12AffineFastState.Bounded env3626 := by
  intro p hp
  have h : env3626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3625_3626 : H12AffineEnvironment.transform 13 9293 env3625 = env3626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9293 env3625 == env3626) = true)

theorem identity3626 : scanCanonicalize (H12AffineFastState.compose env3626 (packedSelected [1,3,4,9,10,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 67107) := by decide +kernel

theorem selectedBound3626 : packedSelected [1,3,4,9,10,12,13] rootPS < 2^1333 := by decide +kernel

def env3627 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,9293,293,65536,9925,1,67107,293,1297,8201,8524,74660,8329,16,9093,9292,9876,9093,9857,4294967296,256,4294975529,9924,513]

theorem envBound3627 : H12AffineFastState.Bounded env3627 := by
  intro p hp
  have h : env3627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3626_3627 : H12AffineEnvironment.transform 18 67107 env3626 = env3627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 67107 env3626 == env3627) = true)

def env3628 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,268,1345,293,65536,1993,1,67107,293,1297,261,64,66216,389,16,649,1344,1944,649,1933,4294967296,256,4294967589,1992,513]

theorem envBound3628 : H12AffineFastState.Bounded env3628 := by
  intro p hp
  have h : env3628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3627_3628 : H12AffineEnvironment.transform 12 268 env3627 = env3628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env3627 == env3628) = true)

theorem identity3628 : scanCanonicalize (H12AffineFastState.compose env3628 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound3628 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3629 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,268,1345,293,547,1993,1,1024,293,1297,261,64,139,389,16,649,1344,1944,649,1933,4294967296,256,4294967589,1992,513]

theorem envBound3629 : H12AffineFastState.Bounded env3629 := by
  intro p hp
  have h : env3629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3628_3629 : H12AffineEnvironment.transform 15 547 env3628 = env3629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env3628 == env3629) = true)

theorem identity3629 : scanCanonicalize (H12AffineFastState.compose env3629 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3629 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3630 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,268,1345,293,170,1344,1,1024,293,1297,261,64,139,389,16,0,1344,1297,0,1284,4294967296,256,4294967589,1345,136]

theorem envBound3630 : H12AffineFastState.Bounded env3630 := by
  intro p hp
  have h : env3630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3629_3630 : H12AffineEnvironment.transform 8 137 env3629 = env3630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3629 == env3630) = true)

theorem identity3630 : scanCanonicalize (H12AffineFastState.compose env3630 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3630 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3631 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1077,40,1125,1,170,1124,1,1024,1,1077,33,64,139,161,16,0,1124,1077,0,1056,4294967296,36,4294967297,1125,136]

theorem envBound3631 : H12AffineFastState.Bounded env3631 := by
  intro p hp
  have h : env3631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3630_3631 : H12AffineEnvironment.transform 7 36 env3630 = env3631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3630 == env3631) = true)

theorem identity3631 : scanCanonicalize (H12AffineFastState.compose env3631 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound3631 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3632 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1077,40,1125,1,170,1124,1,1024,1,1077,33,64,139,161,16,0,1124,1077,0,1056,75,36,74,1125,136]

theorem envBound3632 : H12AffineFastState.Bounded env3632 := by
  intro p hp
  have h : env3632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3631_3632 : H12AffineEnvironment.transform 31 75 env3631 = env3632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env3631 == env3632) = true)

theorem identity3632 : scanCanonicalize (H12AffineFastState.compose env3632 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 66) := by decide +kernel

theorem selectedBound3632 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3633 : List Nat := [2,4,8,16,32,64,66,36,75,1024,0,1077,40,1125,1,104,1124,1,1024,1,1077,33,64,73,99,16,0,1124,1077,0,1056,75,36,74,1125,74]

theorem envBound3633 : H12AffineFastState.Bounded env3633 := by
  intro p hp
  have h : env3633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3632_3633 : H12AffineEnvironment.transform 6 66 env3632 = env3633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 66 env3632 == env3633) = true)

theorem identity3633 : scanCanonicalize (H12AffineFastState.compose env3633 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 49) := by decide +kernel

theorem selectedBound3633 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3634 : List Nat := [2,4,8,16,32,49,51,36,58,1024,0,1077,40,1044,1,25,1045,1,1024,1,1077,33,49,56,18,16,0,1045,1077,0,1056,58,36,59,1044,59]

theorem envBound3634 : H12AffineFastState.Bounded env3634 := by
  intro p hp
  have h : env3634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3633_3634 : H12AffineEnvironment.transform 5 49 env3633 = env3634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 49 env3633 == env3634) = true)

theorem identity3634 : scanCanonicalize (H12AffineFastState.compose env3634 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound3634 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3635 : List Nat := [2,4,8,16,16,1,3,20,10,1024,0,1029,24,1044,1,25,1045,1,1024,1,1029,17,1,8,18,16,0,1045,1029,0,1040,10,20,11,1044,11]

theorem envBound3635 : H12AffineFastState.Bounded env3635 := by
  intro p hp
  have h : env3635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3634_3635 : H12AffineEnvironment.transform 4 16 env3634 = env3635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env3634 == env3635) = true)

theorem identity3635 : scanCanonicalize (H12AffineFastState.compose env3635 (packedSelected [5] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3635 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3636 : List Nat := [2,4,8,0,0,1,3,4,10,1024,0,1029,8,1028,1,9,1029,1,1024,1,1029,1,1,8,2,0,0,1029,1029,0,1024,10,4,11,1028,11]

theorem envBound3636 : H12AffineFastState.Bounded env3636 := by
  intro p hp
  have h : env3636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3635_3636 : H12AffineEnvironment.transform 3 0 env3635 = env3636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3635 == env3636) = true)

def env3637 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,269,1344,293,65536,1992,1,67107,293,1297,260,65,66217,388,16,648,1345,1945,648,1932,4294967296,256,4294967588,1993,513]

theorem envBound3637 : H12AffineFastState.Bounded env3637 := by
  intro p hp
  have h : env3637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3627_3637 : H12AffineEnvironment.transform 12 269 env3627 = env3637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env3627 == env3637) = true)

def env3638 : List Nat := [2,4,8,16,32,64,128,252,512,1024,0,1261,241,1212,217,65536,1588,1,67107,217,1261,248,65,66217,120,16,648,1213,1637,648,1648,4294967296,252,4294967512,1589,513]

theorem envBound3638 : H12AffineFastState.Bounded env3638 := by
  intro p hp
  have h : env3638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3637_3638 : H12AffineEnvironment.transform 7 252 env3637 = env3638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 252 env3637 == env3638) = true)

theorem identity3638 : scanCanonicalize (H12AffineFastState.compose env3638 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 763) := by decide +kernel

theorem selectedBound3638 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3639 : List Nat := [2,4,8,16,32,64,128,252,512,1024,0,1261,241,1212,217,763,1588,1,1240,217,1261,248,65,82,120,16,648,1213,1637,648,1648,4294967296,252,4294967512,1589,513]

theorem envBound3639 : H12AffineFastState.Bounded env3639 := by
  intro p hp
  have h : env3639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3638_3639 : H12AffineEnvironment.transform 15 763 env3638 = env3639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 763 env3638 == env3639) = true)

theorem identity3639 : scanCanonicalize (H12AffineFastState.compose env3639 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound3639 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3640 : List Nat := [2,4,8,16,32,64,128,252,80,1024,0,1261,241,1212,217,171,1124,1,1240,217,1261,248,65,82,120,16,216,1213,1077,216,1056,4294967296,252,4294967512,1125,81]

theorem envBound3640 : H12AffineFastState.Bounded env3640 := by
  intro p hp
  have h : env3640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3639_3640 : H12AffineEnvironment.transform 8 80 env3639 = env3640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env3639 == env3640) = true)

theorem identity3640 : scanCanonicalize (H12AffineFastState.compose env3640 (packedSelected [0,1,2] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound3640 : packedSelected [0,1,2] rootPS < 2^1333 := by decide +kernel

def env3641 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1076,40,1125,0,114,1124,1,1025,0,1076,33,65,82,120,16,1,1124,1077,1,1056,4294967296,37,4294967297,1125,81]

theorem envBound3641 : H12AffineFastState.Bounded env3641 := by
  intro p hp
  have h : env3641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3640_3641 : H12AffineEnvironment.transform 6 89 env3640 = env3641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env3640 == env3641) = true)

theorem identity3641 : scanCanonicalize (H12AffineFastState.compose env3641 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound3641 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3642 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1076,40,1125,0,114,1124,1,1025,0,1076,33,65,82,120,16,1,1124,1077,1,1056,123,37,122,1125,81]

theorem envBound3642 : H12AffineFastState.Bounded env3642 := by
  intro p hp
  have h : env3642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3641_3642 : H12AffineEnvironment.transform 31 123 env3641 = env3642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env3641 == env3642) = true)

theorem identity3642 : scanCanonicalize (H12AffineFastState.compose env3642 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound3642 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3643 : List Nat := [2,4,8,1,32,64,72,37,65,1024,0,1061,40,1125,0,99,1124,1,1025,0,1061,33,65,67,105,1,1,1124,1060,1,1056,106,37,107,1125,64]

theorem envBound3643 : H12AffineFastState.Bounded env3643 := by
  intro p hp
  have h : env3643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3642_3643 : H12AffineEnvironment.transform 3 1 env3642 = env3643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env3642 == env3643) = true)

def leafEnv3643 : List Nat := [2,4,8,1,32,64,72,37,65,1024,0,1061,40,1125,0,99,1124,1,1025,0,1061,33,65,67,1057,105,1,1,1,1124,1060,1,1056,106,37,107,4,35,1125,64,0,1060,1]

def active3643 : List Nat := [0,1,2,4,5,9]

def tree3643 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3643 : H12WitnessSearch.Good tree3643 := H12GlobalWitnessIndex.good

theorem leafIdentity3643 : H12AffineFastState.composeSystem env3643 rootObs = leafEnv3643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3643 rootObs == leafEnv3643) = true)

theorem terminalChecked3643 : H12PackedTerminal.terminalCheckFast leafEnv3643 active3643 tree3643 = true := by decide +kernel

def env3644 : List Nat := [2,4,8,16,32,64,128,253,512,1024,0,1260,240,1213,216,65536,1589,1,67107,216,1260,249,65,66217,121,16,648,1212,1636,648,1649,4294967296,253,4294967513,1588,513]

theorem envBound3644 : H12AffineFastState.Bounded env3644 := by
  intro p hp
  have h : env3644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3637_3644 : H12AffineEnvironment.transform 7 253 env3637 = env3644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 253 env3637 == env3644) = true)

theorem identity3644 : scanCanonicalize (H12AffineFastState.compose env3644 (packedSelected [3,5,10] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound3644 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3645 : List Nat := [2,4,8,16,32,64,88,37,512,1024,0,1076,40,1125,0,65536,1589,1,67107,0,1076,33,65,66161,121,16,592,1124,1636,592,1649,4294967296,37,4294967297,1588,513]

theorem envBound3645 : H12AffineFastState.Bounded env3645 := by
  intro p hp
  have h : env3645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3644_3645 : H12AffineEnvironment.transform 6 88 env3644 = env3645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env3644 == env3645) = true)

theorem identity3645 : scanCanonicalize (H12AffineFastState.compose env3645 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound3645 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env3646 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1076,40,1125,0,65536,1124,1,66674,0,1076,33,65,65568,121,16,1,1124,1077,1,1056,4294967296,37,4294967297,1125,80]

theorem envBound3646 : H12AffineFastState.Bounded env3646 := by
  intro p hp
  have h : env3646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2