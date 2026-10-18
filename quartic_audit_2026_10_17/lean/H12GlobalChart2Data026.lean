import H12GlobalChart2Data025

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem treeGood6358 : H12WitnessSearch.Good tree6358 := H12GlobalWitnessIndex.good

theorem leafIdentity6358 : H12AffineFastState.composeSystem env6358 rootObs = leafEnv6358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6358 rootObs == leafEnv6358) = true)

theorem terminalChecked6358 : H12PackedTerminal.terminalCheckFast leafEnv6358 active6358 tree6358 = true := by decide +kernel

def env6359 : List Nat := [2,4,8,16,32,64,128,256,429,1024,1361,1077,1400,1124,1141,1247,1124,1360,1025,1141,1076,32,357,430,1521,17,1360,1345,1297,1360,1057,112,37,112,1124,428]

theorem envBound6359 : H12AffineFastState.Bounded env6359 := by
  intro p hp
  have h : env6359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6345_6359 : H12AffineEnvironment.transform 10 1361 env6345 = env6359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1361 env6345 == env6359) = true)

theorem identity6359 : scanCanonicalize (H12AffineFastState.compose env6359 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 27) := by decide +kernel

theorem selectedBound6359 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6360 : List Nat := [2,4,8,16,32,27,128,256,429,1024,1290,1077,1315,1087,1070,1156,1087,1291,1025,1070,1076,32,318,430,1450,17,1291,1306,1297,1291,1057,43,37,43,1087,428]

theorem envBound6360 : H12AffineFastState.Bounded env6360 := by
  intro p hp
  have h : env6360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6359_6360 : H12AffineEnvironment.transform 5 27 env6359 = env6360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 27 env6359 == env6360) = true)

def env6361 : List Nat := [2,4,8,0,32,11,128,256,429,1024,1290,1061,1315,1071,1070,1156,1071,1291,1025,1070,1060,32,302,430,1450,1,1291,1290,1281,1291,1057,43,37,43,1071,428]

theorem envBound6361 : H12AffineFastState.Bounded env6361 := by
  intro p hp
  have h : env6361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6360_6361 : H12AffineEnvironment.transform 3 0 env6360 = env6361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6360 == env6361) = true)

theorem identity6361 : scanCanonicalize (H12AffineFastState.compose env6361 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound6361 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6362 : List Nat := [2,4,8,0,32,11,128,36,137,1024,1070,1061,1031,1071,1070,1156,1071,1071,1025,1070,1060,32,10,138,1166,1,1071,1070,1061,1071,1057,43,37,43,1071,136]

theorem envBound6362 : H12AffineFastState.Bounded env6362 := by
  intro p hp
  have h : env6362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6361_6362 : H12AffineEnvironment.transform 7 36 env6361 = env6362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6361 == env6362) = true)

theorem identity6362 : scanCanonicalize (H12AffineFastState.compose env6362 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound6362 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6363 : List Nat := [2,4,8,0,32,11,41,36,32,1024,1070,1061,1031,1071,1070,1069,1071,1071,1025,1070,1060,32,10,35,1063,1,1071,1070,1061,1071,1057,43,37,43,1071,33]

theorem envBound6363 : H12AffineFastState.Bounded env6363 := by
  intro p hp
  have h : env6363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6362_6363 : H12AffineEnvironment.transform 6 41 env6362 = env6363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env6362 == env6363) = true)

theorem identity6363 : scanCanonicalize (H12AffineFastState.compose env6363 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound6363 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6364 : List Nat := [2,4,8,0,0,11,9,4,0,1024,1038,1029,1031,1039,1038,1037,1039,1039,1025,1038,1028,0,10,3,1031,1,1039,1038,1029,1039,1025,11,5,11,1039,1]

theorem envBound6364 : H12AffineFastState.Bounded env6364 := by
  intro p hp
  have h : env6364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6363_6364 : H12AffineEnvironment.transform 4 0 env6363 = env6364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6363 == env6364) = true)

def leafEnv6364 : List Nat := [2,4,8,0,0,11,9,4,0,1024,1038,1029,1031,1039,1038,1037,1039,1039,1025,1038,1028,0,10,3,1025,1031,1,1,1039,1038,1029,1039,1025,11,5,11,4,1037,1039,1,0,1029,1]

def active6364 : List Nat := [0,1,2,9]

def tree6364 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6364 : H12WitnessSearch.Good tree6364 := H12GlobalWitnessIndex.good

theorem leafIdentity6364 : H12AffineFastState.composeSystem env6364 rootObs = leafEnv6364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6364 rootObs == leafEnv6364) = true)

theorem terminalChecked6364 : H12PackedTerminal.terminalCheckFast leafEnv6364 active6364 tree6364 = true := by decide +kernel

def env6365 : List Nat := [2,4,8,1,32,10,128,256,429,1024,1290,1060,1315,1070,1070,1156,1070,1291,1025,1070,1061,32,303,430,1450,0,1291,1291,1280,1291,1057,43,37,43,1070,428]

theorem envBound6365 : H12AffineFastState.Bounded env6365 := by
  intro p hp
  have h : env6365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6360_6365 : H12AffineEnvironment.transform 3 1 env6360 = env6365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6360 == env6365) = true)

def env6366 : List Nat := [2,4,8,1,32,10,40,256,261,1024,1290,1060,1315,1070,1070,1068,1070,1291,1025,1070,1061,32,303,262,1282,0,1291,1291,1280,1291,1057,43,37,43,1070,260]

theorem envBound6366 : H12AffineFastState.Bounded env6366 := by
  intro p hp
  have h : env6366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6365_6366 : H12AffineEnvironment.transform 6 40 env6365 = env6366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env6365 == env6366) = true)

theorem identity6366 : scanCanonicalize (H12AffineFastState.compose env6366 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6366 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6367 : List Nat := [2,4,8,1,32,10,40,37,32,1024,1071,1060,1030,1070,1070,1068,1070,1070,1025,1070,1061,32,10,35,1063,0,1070,1070,1061,1070,1057,43,37,43,1070,33]

theorem envBound6367 : H12AffineFastState.Bounded env6367 := by
  intro p hp
  have h : env6367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6366_6367 : H12AffineEnvironment.transform 7 37 env6366 = env6367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6366 == env6367) = true)

def leafEnv6367 : List Nat := [2,4,8,1,32,10,40,37,32,1024,1071,1060,1030,1070,1070,1068,1070,1070,1025,1070,1061,32,10,35,1056,1063,1,0,1070,1070,1061,1070,1057,43,37,43,4,1036,1070,33,0,1060,1]

def active6367 : List Nat := [0,1,2,4,9]

def tree6367 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6367 : H12WitnessSearch.Good tree6367 := H12GlobalWitnessIndex.good

theorem leafIdentity6367 : H12AffineFastState.composeSystem env6367 rootObs = leafEnv6367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6367 rootObs == leafEnv6367) = true)

theorem terminalChecked6367 : H12PackedTerminal.terminalCheckFast leafEnv6367 active6367 tree6367 = true := by decide +kernel

def env6368 : List Nat := [2,4,8,1,32,10,41,256,260,1024,1290,1060,1315,1070,1070,1069,1070,1291,1025,1070,1061,32,303,263,1283,0,1291,1291,1280,1291,1057,43,37,43,1070,261]

theorem envBound6368 : H12AffineFastState.Bounded env6368 := by
  intro p hp
  have h : env6368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6365_6368 : H12AffineEnvironment.transform 6 41 env6365 = env6368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env6365 == env6368) = true)

def env6369 : List Nat := [2,4,8,1,0,10,9,256,260,1024,1290,1028,1283,1038,1038,1037,1038,1291,1025,1038,1029,0,271,263,1283,0,1291,1291,1280,1291,1025,11,5,11,1038,261]

theorem envBound6369 : H12AffineFastState.Bounded env6369 := by
  intro p hp
  have h : env6369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6368_6369 : H12AffineEnvironment.transform 4 0 env6368 = env6369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6368 == env6369) = true)

def leafEnv6369 : List Nat := [2,4,8,1,0,10,9,256,260,1024,1290,1028,1283,1038,1038,1037,1038,1291,1025,1038,1029,0,271,263,1285,1283,1,0,1291,1291,1280,1291,1025,11,5,11,4,1289,1038,261,0,1028,1]

def active6369 : List Nat := [0,1,2,7,9]

def tree6369 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6369 : H12WitnessSearch.Good tree6369 := H12GlobalWitnessIndex.good

theorem leafIdentity6369 : H12AffineFastState.composeSystem env6369 rootObs = leafEnv6369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6369 rootObs == leafEnv6369) = true)

theorem terminalChecked6369 : H12PackedTerminal.terminalCheckFast leafEnv6369 active6369 tree6369 = true := by decide +kernel

def env6370 : List Nat := [2,4,8,1,1,10,8,256,260,1024,1290,1029,1282,1039,1039,1036,1039,1291,1025,1039,1028,1,270,263,1283,0,1291,1291,1280,1291,1024,10,4,10,1039,261]

theorem envBound6370 : H12AffineFastState.Bounded env6370 := by
  intro p hp
  have h : env6370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6368_6370 : H12AffineEnvironment.transform 4 1 env6368 = env6370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6368 == env6370) = true)

theorem identity6370 : scanCanonicalize (H12AffineFastState.compose env6370 (packedSelected [4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6370 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6371 : List Nat := [2,4,8,1,1,10,8,4,0,1024,1038,1029,1030,1039,1039,1036,1039,1039,1025,1039,1028,1,10,3,1031,0,1039,1039,1028,1039,1024,10,4,10,1039,1]

theorem envBound6371 : H12AffineFastState.Bounded env6371 := by
  intro p hp
  have h : env6371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6370_6371 : H12AffineEnvironment.transform 7 4 env6370 = env6371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6370 == env6371) = true)

def leafEnv6371 : List Nat := [2,4,8,1,1,10,8,4,0,1024,1038,1029,1030,1039,1039,1036,1039,1039,1025,1039,1028,1,10,3,1025,1031,1,0,1039,1039,1028,1039,1024,10,4,10,4,1036,1039,1,0,1029,1]

def active6371 : List Nat := [0,1,2,9]

def tree6371 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6371 : H12WitnessSearch.Good tree6371 := H12GlobalWitnessIndex.good

theorem leafIdentity6371 : H12AffineFastState.composeSystem env6371 rootObs = leafEnv6371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6371 rootObs == leafEnv6371) = true)

theorem terminalChecked6371 : H12PackedTerminal.terminalCheckFast leafEnv6371 active6371 tree6371 = true := by decide +kernel

def env6372 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,2595,1993,2049,1025,2340,1945,909,712,515,2829,17,2049,1345,1297,2049,1932,113,904,988,1993,513]

theorem envBound6372 : H12AffineFastState.Bounded env6372 := by
  intro p hp
  have h : env6372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6343_6372 : H12AffineEnvironment.transform 31 113 env6343 = env6372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 113 env6343 == env6372) = true)

theorem identity6372 : scanCanonicalize (H12AffineFastState.compose env6372 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6372 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6373 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,1725,2721,1772,2049,2595,1772,2049,1025,2049,1724,680,712,515,2600,17,2049,1124,1076,2049,1705,113,685,761,1772,513]

theorem envBound6373 : H12AffineFastState.Bounded env6373 := by
  intro p hp
  have h : env6373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6372_6373 : H12AffineEnvironment.transform 7 37 env6372 = env6373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6372 == env6373) = true)

theorem identity6373 : scanCanonicalize (H12AffineFastState.compose env6373 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound6373 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6374 : List Nat := [2,4,8,16,32,64,128,37,136,1024,2048,1077,2089,1124,2049,2219,1124,2049,1025,2049,1076,32,64,139,2208,17,2049,1124,1076,2049,1057,113,37,113,1124,137]

theorem envBound6374 : H12AffineFastState.Bounded env6374 := by
  intro p hp
  have h : env6374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6373_6374 : H12AffineEnvironment.transform 8 136 env6373 = env6374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6373 == env6374) = true)

theorem identity6374 : scanCanonicalize (H12AffineFastState.compose env6374 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound6374 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6375 : List Nat := [2,4,8,16,32,26,128,37,136,1024,2048,1077,2089,1086,2049,2219,1086,2049,1025,2049,1076,32,26,139,2208,17,2049,1086,1076,2049,1057,43,37,43,1086,137]

theorem envBound6375 : H12AffineFastState.Bounded env6375 := by
  intro p hp
  have h : env6375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6374_6375 : H12AffineEnvironment.transform 5 26 env6374 = env6375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env6374 == env6375) = true)

theorem identity6375 : scanCanonicalize (H12AffineFastState.compose env6375 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound6375 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6376 : List Nat := [2,4,8,0,32,10,128,37,136,1024,2048,1061,2089,1070,2049,2219,1070,2049,1025,2049,1060,32,10,139,2208,1,2049,1070,1060,2049,1057,43,37,43,1070,137]

theorem envBound6376 : H12AffineFastState.Bounded env6376 := by
  intro p hp
  have h : env6376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6375_6376 : H12AffineEnvironment.transform 3 0 env6375 = env6376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6375 == env6376) = true)

def leafEnv6376 : List Nat := [2,4,8,0,32,10,128,37,136,1024,2048,1061,2089,1070,2049,2219,1070,2049,1025,2049,1060,32,10,139,1056,2208,1,1,2049,1070,1060,2049,1057,43,37,43,4,2083,1070,137,0,1061,1]

def active6376 : List Nat := [0,1,2,4,6,9,10]

def tree6376 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6376 : H12WitnessSearch.Good tree6376 := H12GlobalWitnessIndex.good

theorem leafIdentity6376 : H12AffineFastState.composeSystem env6376 rootObs = leafEnv6376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6376 rootObs == leafEnv6376) = true)

theorem terminalChecked6376 : H12PackedTerminal.terminalCheckFast leafEnv6376 active6376 tree6376 = true := by decide +kernel

def env6377 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,16384,8865,65536,16385,2048,524288,8865,1944,10249,17665,74661,8329,18392,9092,1344,1297,9093,16452,4294967296,17472,4295560590,16385,513]

theorem envBound6377 : H12AffineFastState.Bounded env6377 := by
  intro p hp
  have h : env6377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6299_6377 : H12AffineEnvironment.transform 11 1945 env6299 = env6377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6299 == env6377) = true)

theorem identity6377 : scanCanonicalize (H12AffineFastState.compose env6377 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(13+1) ^^^ 1993) := by decide +kernel

theorem selectedBound6377 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env6378 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,8865,65536,1992,2048,524288,8865,1944,10249,712,74661,8329,17,9092,1344,1297,9093,1933,4294967296,905,4295560590,1992,513]

theorem envBound6378 : H12AffineFastState.Bounded env6378 := by
  intro p hp
  have h : env6378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6377_6378 : H12AffineEnvironment.transform 13 1993 env6377 = env6378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1993 env6377 == env6378) = true)

theorem identity6378 : scanCanonicalize (H12AffineFastState.compose env6378 (packedSelected [0,2,4,5,6,8] rootPS)) = affineNative (2^(18+1) ^^^ 75566) := by decide +kernel

theorem selectedBound6378 : packedSelected [0,2,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env6379 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,8865,65536,1992,2048,75566,8865,1944,10249,712,74661,8329,17,9092,1344,1297,9093,1933,4294967296,905,4294978208,1992,513]

theorem envBound6379 : H12AffineFastState.Bounded env6379 := by
  intro p hp
  have h : env6379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6378_6379 : H12AffineEnvironment.transform 18 75566 env6378 = env6379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75566 env6378 == env6379) = true)

theorem identity6379 : scanCanonicalize (H12AffineFastState.compose env6379 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 8615) := by decide +kernel

theorem selectedBound6379 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env6380 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,8865,8615,1992,2048,1673,8865,1944,10249,712,514,8329,17,9092,1344,1297,9093,1933,4294967296,905,4294978208,1992,513]

theorem envBound6380 : H12AffineFastState.Bounded env6380 := by
  intro p hp
  have h : env6380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6379_6380 : H12AffineEnvironment.transform 15 8615 env6379 = env6380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8615 env6379 == env6380) = true)

theorem identity6380 : scanCanonicalize (H12AffineFastState.compose env6380 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6380 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6381 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1344,8232,8615,1345,2048,1024,8232,1297,10249,65,139,8329,17,8461,1344,1297,8460,1284,4294967296,256,4294977577,1345,136]

theorem envBound6381 : H12AffineFastState.Bounded env6381 := by
  intro p hp
  have h : env6381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6380_6381 : H12AffineEnvironment.transform 8 137 env6380 = env6381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6380 == env6381) = true)

def env6382 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,135233,6702101,148800,16876564,1073741824,131140,4294967296,17007940,4350177586,131072,33563272]

theorem envBound6382 : H12AffineFastState.Bounded env6382 := by
  intro p hp
  have h : env6382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6200_6382 : H12AffineEnvironment.transform 25 135233 env6200 = env6382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 135233 env6200 == env6382) = true)

theorem identity6382 : scanCanonicalize (H12AffineFastState.compose env6382 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2777497) := by decide +kernel

theorem selectedBound6382 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env6383 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,2777497,135233,6702101,148800,16876564,1073741824,131140,4294967296,17007940,4318040235,131072,2769681]

theorem envBound6383 : H12AffineFastState.Bounded env6383 := by
  intro p hp
  have h : env6383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6382_6383 : H12AffineEnvironment.transform 24 2777497 env6382 = env6383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2777497 env6382 == env6383) = true)

def env6384 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,16777216,684441,135233,4609045,148800,16876564,1073741824,131140,4294967296,17007940,4315938987,131072,676625]

theorem envBound6384 : H12AffineFastState.Bounded env6384 := by
  intro p hp
  have h : env6384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6383_6384 : H12AffineEnvironment.transform 20 4096 env6383 = env6384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env6383 == env6384) = true)

def env6385 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17665,16777216,684440,135233,4609044,148800,16876564,1073741824,131140,4294967296,17007940,4315938986,131072,676624]

theorem envBound6385 : H12AffineFastState.Bounded env6385 := by
  intro p hp
  have h : env6385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6383_6385 : H12AffineEnvironment.transform 20 4097 env6383 = env6385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env6383 == env6385) = true)

theorem identity6385 : scanCanonicalize (H12AffineFastState.compose env6385 (packedSelected [35] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound6385 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env6386 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,16777216,554201,5376,4477269,16385,16876564,1073741824,1285,4294967296,16875525,4315938986,1345,546385]

theorem envBound6386 : H12AffineFastState.Bounded env6386 := by
  intro p hp
  have h : env6386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6385_6386 : H12AffineEnvironment.transform 16 1345 env6385 = env6386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env6385 == env6386) = true)

theorem identity6386 : scanCanonicalize (H12AffineFastState.compose env6386 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(18+1) ^^^ 21584) := by decide +kernel

theorem selectedBound6386 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6387 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,21584,32768,4097,4194304,17665,16777216,8329,5376,4477269,16385,16876564,1073741824,1285,4294967296,16875525,4315938986,1345,513]

theorem envBound6387 : H12AffineFastState.Bounded env6387 := by
  intro p hp
  have h : env6387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6386_6387 : H12AffineEnvironment.transform 18 21584 env6386 = env6387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21584 env6386 == env6387) = true)

theorem identity6387 : scanCanonicalize (H12AffineFastState.compose env6387 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 4294794) := by decide +kernel

theorem selectedBound6387 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6388 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,21584,32768,4097,4194304,17665,16777216,8329,5376,4477269,16385,16876564,4294794,1285,4294967296,16875525,4315938986,1345,513]

theorem envBound6388 : H12AffineFastState.Bounded env6388 := by
  intro p hp
  have h : env6388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6387_6388 : H12AffineEnvironment.transform 29 4294794 env6387 = env6388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4294794 env6387 == env6388) = true)

theorem identity6388 : scanCanonicalize (H12AffineFastState.compose env6388 (packedSelected [0,7,20] rootPS)) = affineNative (2^(23+1) ^^^ 119692) := by decide +kernel

theorem selectedBound6388 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6389 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,21584,32768,4097,4194304,17665,119692,8329,5376,4477269,16385,22424,4294794,1285,4294967296,21385,4299281190,1345,513]

theorem envBound6389 : H12AffineFastState.Bounded env6389 := by
  intro p hp
  have h : env6389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6388_6389 : H12AffineEnvironment.transform 23 119692 env6388 = env6389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 119692 env6388 == env6389) = true)

theorem identity6389 : scanCanonicalize (H12AffineFastState.compose env6389 (packedSelected [9,22] rootPS)) = affineNative (2^(8+1) ^^^ 217) := by decide +kernel

theorem selectedBound6389 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env6390 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,4096,8192,16384,32768,65536,1345,262144,21584,32768,4097,4194304,17665,119125,8329,5376,4477269,16385,21825,4294794,1285,4294967296,20816,4299280895,1345,216]

theorem envBound6390 : H12AffineFastState.Bounded env6390 := by
  intro p hp
  have h : env6390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6389_6390 : H12AffineEnvironment.transform 8 217 env6389 = env6390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 217 env6389 == env6390) = true)

theorem identity6390 : scanCanonicalize (H12AffineFastState.compose env6390 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 13375) := by decide +kernel

theorem selectedBound6390 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6391 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,4096,8192,16384,32768,13375,1345,262144,21584,32768,4097,4194304,17665,58730,8329,5376,4477269,16385,21825,4242613,1285,4294967296,20816,4299220416,1345,216]

theorem envBound6391 : H12AffineFastState.Bounded env6391 := by
  intro p hp
  have h : env6391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6390_6391 : H12AffineEnvironment.transform 15 13375 env6390 = env6391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13375 env6390 == env6391) = true)

theorem identity6391 : scanCanonicalize (H12AffineFastState.compose env6391 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 5141) := by decide +kernel

theorem selectedBound6391 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env6392 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,4096,8192,16384,32768,13375,1345,262144,21584,32768,4097,4194304,17665,58730,8329,5376,4477269,16385,21825,4242613,1285,5141,20816,4256213,1345,216]

theorem envBound6392 : H12AffineFastState.Bounded env6392 := by
  intro p hp
  have h : env6392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6391_6392 : H12AffineEnvironment.transform 31 5141 env6391 = env6392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5141 env6391 == env6392) = true)

def env6393 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,897815632,4294967296,880939345,4425524339,34359738368,33563272]

theorem envBound6393 : H12AffineFastState.Bounded env6393 := by
  intro p hp
  have h : env6393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4_6393 : H12AffineEnvironment.transform 32 880939345 env4 = env6393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 32 880939345 env4 == env6393) = true)

def env6394 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,889442640,4294967296,872567889,4417151347,34359738368,33563272]

theorem envBound6394 : H12AffineFastState.Bounded env6394 := by
  intro p hp
  have h : env6394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6393_6394 : H12AffineEnvironment.transform 22 17664 env6393 = env6394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 22 17664 env6393 == env6394) = true)

def env6395 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878608,4294967296,537002321,4417151347,34359738368,33563272]

theorem envBound6395 : H12AffineFastState.Bounded env6395 := by
  intro p hp
  have h : env6395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6394_6395 : H12AffineEnvironment.transform 27 67130624 env6394 = env6395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 27 67130624 env6394 == env6395) = true)

def env6396 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878608,4294967296,537002321,4417151347,694534144,33563272]

theorem envBound6396 : H12AffineFastState.Bounded env6396 := by
  intro p hp
  have h : env6396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6395_6396 : H12AffineEnvironment.transform 34 694534144 env6395 = env6396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534144 env6395 == env6396) = true)

def env6397 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,157794304,1073741824,140788816,4294967296,157663569,4417151347,131072,33563272]

theorem envBound6397 : H12AffineFastState.Bounded env6397 := by
  intro p hp
  have h : env6397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6396_6397 : H12AffineEnvironment.transform 28 157794304 env6396 = env6397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env6396 == env6397) = true)

theorem identity6397 : scanCanonicalize (H12AffineFastState.compose env6397 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 23445584) := by decide +kernel

theorem selectedBound6397 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env6398 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,23445584,67130624,131152,1073741824,16876544,4294967296,257,4417151347,131072,33563272]

theorem envBound6398 : H12AffineFastState.Bounded env6398 := by
  intro p hp
  have h : env6398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6397_6398 : H12AffineEnvironment.transform 26 23445584 env6397 = env6398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 23445584 env6397 == env6398) = true)

def env6399 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,67108864,21352528,67130624,131152,1073741824,16876544,4294967296,257,4417151347,131072,33563272]

theorem envBound6399 : H12AffineFastState.Bounded env6399 := by
  intro p hp
  have h : env6399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6398_6399 : H12AffineEnvironment.transform 20 4096 env6398 = env6399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env6398 == env6399) = true)

theorem identity6399 : scanCanonicalize (H12AffineFastState.compose env6399 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 17011013) := by decide +kernel

theorem selectedBound6399 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env6400 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024069,131152,1073741824,16876544,4294967296,257,4333498422,131072,33563272]

theorem envBound6400 : H12AffineFastState.Bounded env6400 := by
  intro p hp
  have h : env6400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6399_6400 : H12AffineEnvironment.transform 25 17011013 env6399 = env6400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17011013 env6399 == env6400) = true)

def env6401 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024069,131152,1073741824,16876544,4294967296,257,4332975158,131072,33563272]

theorem envBound6401 : H12AffineFastState.Bounded env6401 := by
  intro p hp
  have h : env6401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6400_6401 : H12AffineEnvironment.transform 18 1024 env6400 = env6401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env6400 == env6401) = true)

theorem identity6401 : scanCanonicalize (H12AffineFastState.compose env6401 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21126303) := by decide +kernel

theorem selectedBound6401 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env6402 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024069,131152,21126303,16876544,4294967296,257,4332975158,131072,33563272]

theorem envBound6402 : H12AffineFastState.Bounded env6402 := by
  intro p hp
  have h : env6402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6401_6402 : H12AffineEnvironment.transform 29 21126303 env6401 = env6402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21126303 env6401 == env6402) = true)

def env6403 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,33554432,17011013,21332048,17011781,131152,21105823,16876544,4294967296,257,4332954678,131072,33563272]

theorem envBound6403 : H12AffineFastState.Bounded env6403 := by
  intro p hp
  have h : env6403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6402_6403 : H12AffineEnvironment.transform 13 4096 env6402 = env6403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env6402 == env6403) = true)

def env6404 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,33554432,17010965,21331968,17011733,131072,21105823,16876544,4294967296,257,4332954678,131072,33563272]

theorem envBound6404 : H12AffineFastState.Bounded env6404 := by
  intro p hp
  have h : env6404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6403_6404 : H12AffineEnvironment.transform 5 16 env6403 = env6404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6403 == env6404) = true)

theorem identity6404 : scanCanonicalize (H12AffineFastState.compose env6404 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015965) := by decide +kernel

theorem selectedBound6404 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6405 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,17015965,17010965,21331968,17011733,131072,21105823,16876544,4294967296,257,4315938987,131072,17008149]

theorem envBound6405 : H12AffineFastState.Bounded env6405 := by
  intro p hp
  have h : env6405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6404_6405 : H12AffineEnvironment.transform 24 17015965 env6404 = env6405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015965 env6404 == env6405) = true)

def env6406 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,33554432,17010964,21331969,17011732,131073,21105823,16876544,4294967296,257,4332954678,131072,33563272]

theorem envBound6406 : H12AffineFastState.Bounded env6406 := by
  intro p hp
  have h : env6406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6403_6406 : H12AffineEnvironment.transform 5 17 env6403 = env6406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6403 == env6406) = true)

theorem identity6406 : scanCanonicalize (H12AffineFastState.compose env6406 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230420) := by decide +kernel

theorem selectedBound6406 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6407 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,230420,33554432,5376,4588565,4096,131073,4294795,131092,4294967296,257,4332954678,131072,33563272]

theorem envBound6407 : H12AffineFastState.Bounded env6407 := by
  intro p hp
  have h : env6407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6406_6407 : H12AffineEnvironment.transform 23 230420 env6406 = env6407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230420 env6406 == env6407) = true)

theorem identity6407 : scanCanonicalize (H12AffineFastState.compose env6407 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound6407 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6408 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,230420,8329,5376,4588565,4096,131073,4294795,131092,4294967296,257,4299392191,131072,513]

theorem envBound6408 : H12AffineFastState.Bounded env6408 := by
  intro p hp
  have h : env6408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6407_6408 : H12AffineEnvironment.transform 24 8329 env6407 = env6408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env6407 == env6408) = true)

theorem identity6408 : scanCanonicalize (H12AffineFastState.compose env6408 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound6408 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env6409 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,13340,65536,131072,262144,1024,13340,4096,4194304,5376,208904,8329,5376,4588565,4096,131073,4275351,131092,4294967296,257,4299370659,131072,513]

theorem envBound6409 : H12AffineFastState.Bounded env6409 := by
  intro p hp
  have h : env6409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6408_6409 : H12AffineEnvironment.transform 14 13340 env6408 = env6409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env6408 == env6409) = true)

theorem identity6409 : scanCanonicalize (H12AffineFastState.compose env6409 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6409 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env6410 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,13340,65536,1296,262144,1024,13340,4096,4194304,5376,79128,8329,5376,4456709,4096,1297,4275351,1284,4294967296,257,4299240883,1296,513]

theorem envBound6410 : H12AffineFastState.Bounded env6410 := by
  intro p hp
  have h : env6410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6409_6410 : H12AffineEnvironment.transform 16 1296 env6409 = env6410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env6409 == env6410) = true)

theorem identity6410 : scanCanonicalize (H12AffineFastState.compose env6410 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6410 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6411 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4096,13340,65536,1296,262144,1024,13340,4096,4194304,5376,79128,8329,5376,4456709,4096,1297,4275351,1284,4294967296,257,4299240883,1296,136]

theorem envBound6411 : H12AffineFastState.Bounded env6411 := by
  intro p hp
  have h : env6411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6410_6411 : H12AffineEnvironment.transform 8 137 env6410 = env6411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6410 == env6411) = true)

theorem identity6411 : scanCanonicalize (H12AffineFastState.compose env6411 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 1281) := by decide +kernel

theorem selectedBound6411 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env6412 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1281,8192,1281,8477,65536,1296,262144,1024,8477,1281,4194304,1,73753,8329,1,4456709,1281,1297,4270486,1284,4294967296,257,4299235506,1296,136]

theorem envBound6412 : H12AffineFastState.Bounded env6412 := by
  intro p hp
  have h : env6412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6411_6412 : H12AffineEnvironment.transform 11 1281 env6411 = env6412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1281 env6411 == env6412) = true)

theorem identity6412 : scanCanonicalize (H12AffineFastState.compose env6412 (packedSelected [6,8,13] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound6412 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env6413 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1281,8192,1281,8477,65536,1296,262144,1024,8477,1281,396,1,73753,8329,1,262281,1281,1297,75802,1284,4294967296,257,4295041342,1296,136]

theorem envBound6413 : H12AffineFastState.Bounded env6413 := by
  intro p hp
  have h : env6413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6412_6413 : H12AffineEnvironment.transform 21 396 env6412 = env6413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env6412 == env6413) = true)

theorem identity6413 : scanCanonicalize (H12AffineFastState.compose env6413 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 270767) := by decide +kernel

theorem selectedBound6413 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6414 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1281,8192,1281,8477,65536,1296,262144,1024,8477,1281,396,1,73753,8329,1,262281,1281,1297,75802,1284,270767,257,327825,1296,136]

theorem envBound6414 : H12AffineFastState.Bounded env6414 := by
  intro p hp
  have h : env6414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6413_6414 : H12AffineEnvironment.transform 31 270767 env6413 = env6414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 270767 env6413 == env6414) = true)

def env6415 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,1281,8192,1281,8477,65536,1296,262144,1024,8477,1281,260,1,73753,8193,1,262145,1281,1297,75802,1284,270631,257,327705,1296,0]

theorem envBound6415 : H12AffineFastState.Bounded env6415 := by
  intro p hp
  have h : env6415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6414_6415 : H12AffineEnvironment.transform 6 8 env6414 = env6415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6414 == env6415) = true)

theorem identity6415 : scanCanonicalize (H12AffineFastState.compose env6415 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 8460) := by decide +kernel

theorem selectedBound6415 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6416 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,1281,8192,1281,8477,65536,1296,8460,1024,8477,1281,260,1,73753,8193,1,8461,1281,1297,75802,1284,43,257,74005,1296,0]

theorem envBound6416 : H12AffineFastState.Bounded env6416 := by
  intro p hp
  have h : env6416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6415_6416 : H12AffineEnvironment.transform 17 8460 env6415 = env6416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 8460 env6415 == env6416) = true)

def env6417 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1281,8192,1281,8477,65536,1296,8460,1024,8477,1281,260,1,73753,8193,1,8461,1281,1297,73754,1284,43,257,74005,1296,0]

theorem envBound6417 : H12AffineFastState.Bounded env6417 := by
  intro p hp
  have h : env6417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6416_6417 : H12AffineEnvironment.transform 10 0 env6416 = env6417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env6416 == env6417) = true)

theorem identity6417 : scanCanonicalize (H12AffineFastState.compose env6417 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 34) := by decide +kernel

theorem selectedBound6417 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6418 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1281,8192,1281,8477,34,1296,8460,1024,8477,1281,260,1,8251,8193,1,8461,1281,1297,8248,1284,43,257,8503,1296,0]

theorem envBound6418 : H12AffineFastState.Bounded env6418 := by
  intro p hp
  have h : env6418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6417_6418 : H12AffineEnvironment.transform 15 34 env6417 = env6418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34 env6417 == env6418) = true)

theorem identity6418 : scanCanonicalize (H12AffineFastState.compose env6418 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 56) := by decide +kernel

theorem selectedBound6418 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6419 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1281,56,1281,293,34,1296,308,1024,293,1281,260,1,3,57,1,309,1281,1297,0,1284,43,257,271,1296,0]

theorem envBound6419 : H12AffineFastState.Bounded env6419 := by
  intro p hp
  have h : env6419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6418_6419 : H12AffineEnvironment.transform 12 56 env6418 = env6419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 56 env6418 == env6419) = true)

def env6420 : List Nat := [2,4,8,16,32,17,8,36,1,1024,0,1061,56,1061,1,34,1076,16,1024,1,1061,32,1,3,57,1,17,1061,1077,0,1056,43,37,43,1076,0]

theorem envBound6420 : H12AffineFastState.Bounded env6420 := by
  intro p hp
  have h : env6420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6419_6420 : H12AffineEnvironment.transform 7 36 env6419 = env6420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6419 == env6420) = true)

theorem identity6420 : scanCanonicalize (H12AffineFastState.compose env6420 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6420 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6421 : List Nat := [2,4,2,16,32,17,2,36,1,1024,0,1061,50,1061,1,34,1076,16,1024,1,1061,32,1,3,51,1,17,1061,1077,0,1056,33,37,33,1076,0]

theorem envBound6421 : H12AffineFastState.Bounded env6421 := by
  intro p hp
  have h : env6421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6420_6421 : H12AffineEnvironment.transform 2 2 env6420 = env6421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6420 == env6421) = true)

def leafEnv6421 : List Nat := [2,4,2,16,32,17,2,36,1,1024,0,1061,50,1061,1,34,1076,16,1024,1,1061,32,1,3,1056,51,1,1,17,1061,1077,0,1056,33,37,33,5,34,1076,0,0,1077,1]

def active6421 : List Nat := [0,1,3,4,9]

def tree6421 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6421 : H12WitnessSearch.Good tree6421 := H12GlobalWitnessIndex.good

theorem leafIdentity6421 : H12AffineFastState.composeSystem env6421 rootObs = leafEnv6421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6421 rootObs == leafEnv6421) = true)

theorem terminalChecked6421 : H12PackedTerminal.terminalCheckFast leafEnv6421 active6421 tree6421 = true := by decide +kernel

def env6422 : List Nat := [2,4,8,16,32,17,8,37,1,1024,0,1060,56,1060,0,34,1077,17,1024,0,1060,33,1,3,57,1,16,1060,1076,0,1057,43,36,42,1077,0]

theorem envBound6422 : H12AffineFastState.Bounded env6422 := by
  intro p hp
  have h : env6422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6419_6422 : H12AffineEnvironment.transform 7 37 env6419 = env6422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6419 == env6422) = true)

def leafEnv6422 : List Nat := [2,4,8,16,32,17,8,37,1,1024,0,1060,56,1060,0,34,1077,17,1024,0,1060,33,1,3,1057,57,1,1,16,1060,1076,0,1057,43,36,42,5,34,1077,0,0,1076,1]

def active6422 : List Nat := [0,1,2,3,4,9]

def tree6422 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6422 : H12WitnessSearch.Good tree6422 := H12GlobalWitnessIndex.good

theorem leafIdentity6422 : H12AffineFastState.composeSystem env6422 rootObs = leafEnv6422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6422 rootObs == leafEnv6422) = true)

theorem terminalChecked6422 : H12PackedTerminal.terminalCheckFast leafEnv6422 active6422 tree6422 = true := by decide +kernel

def env6423 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1281,8192,1281,8477,65536,1296,8460,1024,8477,1281,260,1,73753,8193,1,8461,1281,1297,73755,1284,43,257,74005,1296,0]

theorem envBound6423 : H12AffineFastState.Bounded env6423 := by
  intro p hp
  have h : env6423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6416_6423 : H12AffineEnvironment.transform 10 1 env6416 = env6423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env6416 == env6423) = true)

theorem identity6423 : scanCanonicalize (H12AffineFastState.compose env6423 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 57) := by decide +kernel

theorem selectedBound6423 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6424 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1281,57,1281,292,65536,1296,309,1024,292,1281,260,1,65568,56,1,308,1281,1297,65570,1284,43,257,65836,1296,0]

theorem envBound6424 : H12AffineFastState.Bounded env6424 := by
  intro p hp
  have h : env6424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6423_6424 : H12AffineEnvironment.transform 12 57 env6423 = env6424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 57 env6423 == env6424) = true)

theorem identity6424 : scanCanonicalize (H12AffineFastState.compose env6424 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 35) := by decide +kernel

theorem selectedBound6424 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6425 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1281,57,1281,292,35,1296,309,1024,292,1281,260,1,3,56,1,308,1281,1297,1,1284,43,257,271,1296,0]

theorem envBound6425 : H12AffineFastState.Bounded env6425 := by
  intro p hp
  have h : env6425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6424_6425 : H12AffineEnvironment.transform 15 35 env6424 = env6425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 35 env6424 == env6425) = true)

def env6426 : List Nat := [2,4,8,16,32,17,8,36,1,1024,1,1061,57,1061,0,35,1076,17,1024,0,1061,32,1,3,56,1,16,1061,1077,1,1056,43,37,43,1076,0]

theorem envBound6426 : H12AffineFastState.Bounded env6426 := by
  intro p hp
  have h : env6426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6425_6426 : H12AffineEnvironment.transform 7 36 env6425 = env6426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6425 == env6426) = true)

theorem identity6426 : scanCanonicalize (H12AffineFastState.compose env6426 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6426 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6427 : List Nat := [2,4,2,16,32,17,2,36,1,1024,1,1061,51,1061,0,35,1076,17,1024,0,1061,32,1,3,50,1,16,1061,1077,1,1056,33,37,33,1076,0]

theorem envBound6427 : H12AffineFastState.Bounded env6427 := by
  intro p hp
  have h : env6427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6426_6427 : H12AffineEnvironment.transform 2 2 env6426 = env6427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6426 == env6427) = true)

def leafEnv6427 : List Nat := [2,4,2,16,32,17,2,36,1,1024,1,1061,51,1061,0,35,1076,17,1024,0,1061,32,1,3,1056,50,1,1,16,1061,1077,1,1056,33,37,33,5,35,1076,0,0,1077,1]

def active6427 : List Nat := [0,1,3,4,9]

def tree6427 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6427 : H12WitnessSearch.Good tree6427 := H12GlobalWitnessIndex.good

theorem leafIdentity6427 : H12AffineFastState.composeSystem env6427 rootObs = leafEnv6427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6427 rootObs == leafEnv6427) = true)

theorem terminalChecked6427 : H12PackedTerminal.terminalCheckFast leafEnv6427 active6427 tree6427 = true := by decide +kernel

def env6428 : List Nat := [2,4,8,16,32,17,8,37,1,1024,1,1060,57,1060,1,35,1077,16,1024,1,1060,33,1,3,56,1,17,1060,1076,1,1057,43,36,42,1077,0]

theorem envBound6428 : H12AffineFastState.Bounded env6428 := by
  intro p hp
  have h : env6428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6425_6428 : H12AffineEnvironment.transform 7 37 env6425 = env6428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6425 == env6428) = true)

def leafEnv6428 : List Nat := [2,4,8,16,32,17,8,37,1,1024,1,1060,57,1060,1,35,1077,16,1024,1,1060,33,1,3,1057,56,1,1,17,1060,1076,1,1057,43,36,42,5,35,1077,0,0,1076,1]

def active6428 : List Nat := [0,1,2,3,4,9]

def tree6428 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6428 : H12WitnessSearch.Good tree6428 := H12GlobalWitnessIndex.good

theorem leafIdentity6428 : H12AffineFastState.composeSystem env6428 rootObs = leafEnv6428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6428 rootObs == leafEnv6428) = true)

theorem terminalChecked6428 : H12PackedTerminal.terminalCheckFast leafEnv6428 active6428 tree6428 = true := by decide +kernel

def env6429 : List Nat := [2,4,8,16,32,17,9,256,0,1024,2048,1281,8192,1281,8477,65536,1296,262144,1024,8477,1281,261,1,73753,8192,1,262144,1281,1297,75802,1284,270630,257,327704,1296,1]

theorem envBound6429 : H12AffineFastState.Bounded env6429 := by
  intro p hp
  have h : env6429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6414_6429 : H12AffineEnvironment.transform 6 9 env6414 = env6429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6414 == env6429) = true)

def env6430 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,33554432,17011013,21332049,17011780,131152,21105822,16876544,4294967296,257,4332954679,131072,33563272]

theorem envBound6430 : H12AffineFastState.Bounded env6430 := by
  intro p hp
  have h : env6430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6402_6430 : H12AffineEnvironment.transform 13 4097 env6402 = env6430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6402 == env6430) = true)

def env6431 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,33554432,17010965,21331969,17011732,131072,21105822,16876544,4294967296,257,4332954679,131072,33563272]

theorem envBound6431 : H12AffineFastState.Bounded env6431 := by
  intro p hp
  have h : env6431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6430_6431 : H12AffineEnvironment.transform 5 16 env6430 = env6431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6430 == env6431) = true)

theorem identity6431 : scanCanonicalize (H12AffineFastState.compose env6431 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230421) := by decide +kernel

theorem selectedBound6431 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6432 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,230421,33554432,5376,4588564,4097,131072,4294795,131093,4294967296,257,4332954679,131072,33563272]

theorem envBound6432 : H12AffineFastState.Bounded env6432 := by
  intro p hp
  have h : env6432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6431_6432 : H12AffineEnvironment.transform 23 230421 env6431 = env6432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230421 env6431 == env6432) = true)

theorem identity6432 : scanCanonicalize (H12AffineFastState.compose env6432 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound6432 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6433 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,230421,8329,5376,4588564,4097,131072,4294795,131093,4294967296,257,4299392190,131072,513]

theorem envBound6433 : H12AffineFastState.Bounded env6433 := by
  intro p hp
  have h : env6433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6432_6433 : H12AffineEnvironment.transform 24 8329 env6432 = env6433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env6432 == env6433) = true)

theorem identity6433 : scanCanonicalize (H12AffineFastState.compose env6433 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound6433 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env6434 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,13340,65536,131072,262144,1024,13340,4096,4194304,5377,208905,8329,5376,4588564,4097,131072,4275351,131093,4294967296,257,4299370658,131072,513]

theorem envBound6434 : H12AffineFastState.Bounded env6434 := by
  intro p hp
  have h : env6434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6433_6434 : H12AffineEnvironment.transform 14 13340 env6433 = env6434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env6433 == env6434) = true)

theorem identity6434 : scanCanonicalize (H12AffineFastState.compose env6434 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6434 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env6435 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,13340,65536,1297,262144,1024,13340,4096,4194304,5377,79128,8329,5376,4456709,4097,1297,4275351,1284,4294967296,257,4299240883,1297,513]

theorem envBound6435 : H12AffineFastState.Bounded env6435 := by
  intro p hp
  have h : env6435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6434_6435 : H12AffineEnvironment.transform 16 1297 env6434 = env6435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env6434 == env6435) = true)

theorem identity6435 : scanCanonicalize (H12AffineFastState.compose env6435 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6435 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6436 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4097,13340,65536,1297,262144,1024,13340,4096,4194304,5377,79128,8329,5376,4456709,4097,1297,4275351,1284,4294967296,257,4299240883,1297,136]

theorem envBound6436 : H12AffineFastState.Bounded env6436 := by
  intro p hp
  have h : env6436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6435_6436 : H12AffineEnvironment.transform 8 137 env6435 = env6436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6435 == env6436) = true)

theorem identity6436 : scanCanonicalize (H12AffineFastState.compose env6436 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound6436 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env6437 : List Nat := [2,4,8,1,32,1,128,256,137,1024,2048,4096,8192,4097,13325,65536,1280,262144,1024,13325,4096,4194304,5377,79113,8329,5376,4456709,4097,1280,4275334,1284,4294967296,257,4299240866,1280,136]

theorem envBound6437 : H12AffineFastState.Bounded env6437 := by
  intro p hp
  have h : env6437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6436_6437 : H12AffineEnvironment.transform 3 1 env6436 = env6437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6436 == env6437) = true)

theorem identity6437 : scanCanonicalize (H12AffineFastState.compose env6437 (packedSelected [6,8,13] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound6437 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env6438 : List Nat := [2,4,8,1,32,1,128,256,137,1024,2048,4096,8192,4097,13325,65536,1280,262144,1024,13325,4096,397,5377,79113,8329,5376,262280,4097,1280,81163,1284,4294967296,257,4295046191,1280,136]

theorem envBound6438 : H12AffineFastState.Bounded env6438 := by
  intro p hp
  have h : env6438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6437_6438 : H12AffineEnvironment.transform 21 397 env6437 = env6438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env6437 == env6438) = true)

theorem identity6438 : scanCanonicalize (H12AffineFastState.compose env6438 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 275630) := by decide +kernel

theorem selectedBound6438 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6439 : List Nat := [2,4,8,1,32,1,128,256,137,1024,2048,4096,8192,4097,13325,65536,1280,262144,1024,13325,4096,397,5377,79113,8329,5376,262280,4097,1280,81163,1284,275630,257,327809,1280,136]

theorem envBound6439 : H12AffineFastState.Bounded env6439 := by
  intro p hp
  have h : env6439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6438_6439 : H12AffineEnvironment.transform 31 275630 env6438 = env6439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 275630 env6438 == env6439) = true)

def env6440 : List Nat := [2,4,8,1,32,1,8,256,1,1024,2048,4096,8192,4097,13325,65536,1280,262144,1024,13325,4096,261,5377,79113,8193,5376,262144,4097,1280,81163,1284,275494,257,327689,1280,0]

theorem envBound6440 : H12AffineFastState.Bounded env6440 := by
  intro p hp
  have h : env6440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6439_6440 : H12AffineEnvironment.transform 6 8 env6439 = env6440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6439 == env6440) = true)

def env6441 : List Nat := [2,4,8,1,32,1,9,256,0,1024,2048,4096,8192,4097,13325,65536,1280,262144,1024,13325,4096,260,5377,79113,8192,5376,262145,4097,1280,81163,1284,275495,257,327688,1280,1]

theorem envBound6441 : H12AffineFastState.Bounded env6441 := by
  intro p hp
  have h : env6441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6439_6441 : H12AffineEnvironment.transform 6 9 env6439 = env6441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6439 == env6441) = true)

theorem identity6441 : scanCanonicalize (H12AffineFastState.compose env6441 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 8460) := by decide +kernel

theorem selectedBound6441 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6442 : List Nat := [2,4,8,1,32,1,9,256,0,1024,2048,4096,8192,4097,13325,65536,1280,8460,1024,13325,4096,260,5377,79113,8192,5376,8461,4097,1280,81163,1284,5419,257,73988,1280,1]

theorem envBound6442 : H12AffineFastState.Bounded env6442 := by
  intro p hp
  have h : env6442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6441_6442 : H12AffineEnvironment.transform 17 8460 env6441 = env6442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 8460 env6441 == env6442) = true)

def env6443 : List Nat := [2,4,8,1,32,1,9,256,0,1024,0,4096,8192,4097,13325,65536,1280,8460,1024,13325,4096,260,5377,79113,8192,5376,8461,4097,1280,79115,1284,5419,257,73988,1280,1]

theorem envBound6443 : H12AffineFastState.Bounded env6443 := by
  intro p hp
  have h : env6443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6442_6443 : H12AffineEnvironment.transform 10 0 env6442 = env6443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env6442 == env6443) = true)

theorem identity6443 : scanCanonicalize (H12AffineFastState.compose env6443 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 35) := by decide +kernel

theorem selectedBound6443 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6444 : List Nat := [2,4,8,1,32,1,9,256,0,1024,0,4096,8192,4097,13325,35,1280,8460,1024,13325,4096,260,5377,13610,8192,5376,8461,4097,1280,13608,1284,5419,257,8487,1280,1]

theorem envBound6444 : H12AffineFastState.Bounded env6444 := by
  intro p hp
  have h : env6444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6443_6444 : H12AffineEnvironment.transform 15 35 env6443 = env6444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 35 env6443 == env6444) = true)

theorem identity6444 : scanCanonicalize (H12AffineFastState.compose env6444 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 5416) := by decide +kernel

theorem selectedBound6444 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6445 : List Nat := [2,4,8,1,32,1,9,256,0,1024,0,4096,5416,4097,293,35,1280,5156,1024,293,4096,260,5377,2,5416,5376,5157,4097,1280,0,1284,5419,257,5135,1280,1]

theorem envBound6445 : H12AffineFastState.Bounded env6445 := by
  intro p hp
  have h : env6445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6444_6445 : H12AffineEnvironment.transform 12 5416 env6444 = env6445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5416 env6444 == env6445) = true)

def env6446 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,4096,5132,4097,1,35,1060,5156,1024,1,4096,32,5157,2,5132,5156,5157,4097,1060,0,1056,5135,37,5135,1060,1]

theorem envBound6446 : H12AffineFastState.Bounded env6446 := by
  intro p hp
  have h : env6446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6445_6446 : H12AffineEnvironment.transform 7 36 env6445 = env6446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6445 == env6446) = true)

theorem identity6446 : scanCanonicalize (H12AffineFastState.compose env6446 (packedSelected [2] rootPS)) = affineNative (2^(11+1) ^^^ 1070) := by decide +kernel

theorem selectedBound6446 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6447 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1070,34,1071,1,35,1060,10,1024,1,1070,32,11,2,34,10,11,1071,1060,0,1056,33,37,33,1060,1]

theorem envBound6447 : H12AffineFastState.Bounded env6447 := by
  intro p hp
  have h : env6447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6446_6447 : H12AffineEnvironment.transform 11 1070 env6446 = env6447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1070 env6446 == env6447) = true)

def leafEnv6447 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1070,34,1071,1,35,1060,10,1024,1,1070,32,11,2,1056,34,1,10,11,1071,1060,0,1056,33,37,33,5,34,1060,1,0,1060,1]

def active6447 : List Nat := [0,1,2,4,9]

def tree6447 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6447 : H12WitnessSearch.Good tree6447 := H12GlobalWitnessIndex.good

theorem leafIdentity6447 : H12AffineFastState.composeSystem env6447 rootObs = leafEnv6447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6447 rootObs == leafEnv6447) = true)

theorem terminalChecked6447 : H12PackedTerminal.terminalCheckFast leafEnv6447 active6447 tree6447 = true := by decide +kernel

def env6448 : List Nat := [2,4,8,1,32,1,9,37,0,1024,0,4096,5133,4097,0,35,1061,5156,1024,0,4096,33,5156,2,5133,5157,5157,4097,1061,0,1057,5134,36,5135,1061,1]

theorem envBound6448 : H12AffineFastState.Bounded env6448 := by
  intro p hp
  have h : env6448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6445_6448 : H12AffineEnvironment.transform 7 37 env6445 = env6448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6445 == env6448) = true)

def leafEnv6448 : List Nat := [2,4,8,1,32,1,9,37,0,1024,0,4096,5133,4097,0,35,1061,5156,1024,0,4096,33,5156,2,1057,5133,1,5157,5157,4097,1061,0,1057,5134,36,5135,5,34,1061,1,0,1061,1]

def active6448 : List Nat := [0,1,2,4,9,11]

def tree6448 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6448 : H12WitnessSearch.Good tree6448 := H12GlobalWitnessIndex.good

theorem leafIdentity6448 : H12AffineFastState.composeSystem env6448 rootObs = leafEnv6448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6448 rootObs == leafEnv6448) = true)

theorem terminalChecked6448 : H12PackedTerminal.terminalCheckFast leafEnv6448 active6448 tree6448 = true := by decide +kernel

def env6449 : List Nat := [2,4,8,1,32,1,9,256,0,1024,1,4096,8192,4097,13325,65536,1280,8460,1024,13325,4096,260,5377,79113,8192,5376,8461,4097,1280,79114,1284,5419,257,73988,1280,1]

theorem envBound6449 : H12AffineFastState.Bounded env6449 := by
  intro p hp
  have h : env6449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6442_6449 : H12AffineEnvironment.transform 10 1 env6442 = env6449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env6442 == env6449) = true)

theorem identity6449 : scanCanonicalize (H12AffineFastState.compose env6449 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 5417) := by decide +kernel

theorem selectedBound6449 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6450 : List Nat := [2,4,8,1,32,1,9,256,0,1024,1,4096,5417,4097,292,65536,1280,5157,1024,292,4096,260,5377,65568,5417,5376,5156,4097,1280,65571,1284,5419,257,70701,1280,1]

theorem envBound6450 : H12AffineFastState.Bounded env6450 := by
  intro p hp
  have h : env6450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6449_6450 : H12AffineEnvironment.transform 12 5417 env6449 = env6450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5417 env6449 == env6450) = true)

theorem identity6450 : scanCanonicalize (H12AffineFastState.compose env6450 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 34) := by decide +kernel

theorem selectedBound6450 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6451 : List Nat := [2,4,8,1,32,1,9,256,0,1024,1,4096,5417,4097,292,34,1280,5157,1024,292,4096,260,5377,2,5417,5376,5156,4097,1280,1,1284,5419,257,5135,1280,1]

theorem envBound6451 : H12AffineFastState.Bounded env6451 := by
  intro p hp
  have h : env6451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6450_6451 : H12AffineEnvironment.transform 15 34 env6450 = env6451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34 env6450 == env6451) = true)

def env6452 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,4096,5133,4097,0,34,1060,5157,1024,0,4096,32,5157,2,5133,5156,5156,4097,1060,1,1056,5135,37,5135,1060,1]

theorem envBound6452 : H12AffineFastState.Bounded env6452 := by
  intro p hp
  have h : env6452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6451_6452 : H12AffineEnvironment.transform 7 36 env6451 = env6452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6451 == env6452) = true)

theorem identity6452 : scanCanonicalize (H12AffineFastState.compose env6452 (packedSelected [2] rootPS)) = affineNative (2^(11+1) ^^^ 1070) := by decide +kernel

theorem selectedBound6452 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6453 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1070,35,1071,0,34,1060,11,1024,0,1070,32,11,2,35,10,10,1071,1060,1,1056,33,37,33,1060,1]

theorem envBound6453 : H12AffineFastState.Bounded env6453 := by
  intro p hp
  have h : env6453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6452_6453 : H12AffineEnvironment.transform 11 1070 env6452 = env6453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1070 env6452 == env6453) = true)

def leafEnv6453 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1070,35,1071,0,34,1060,11,1024,0,1070,32,11,2,1056,35,1,10,10,1071,1060,1,1056,33,37,33,5,35,1060,1,0,1060,1]

def active6453 : List Nat := [0,1,2,4,9]

def tree6453 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6453 : H12WitnessSearch.Good tree6453 := H12GlobalWitnessIndex.good

theorem leafIdentity6453 : H12AffineFastState.composeSystem env6453 rootObs = leafEnv6453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6453 rootObs == leafEnv6453) = true)

theorem terminalChecked6453 : H12PackedTerminal.terminalCheckFast leafEnv6453 active6453 tree6453 = true := by decide +kernel

def env6454 : List Nat := [2,4,8,1,32,1,9,37,0,1024,1,4096,5132,4097,1,34,1061,5157,1024,1,4096,33,5156,2,5132,5157,5156,4097,1061,1,1057,5134,36,5135,1061,1]

theorem envBound6454 : H12AffineFastState.Bounded env6454 := by
  intro p hp
  have h : env6454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6451_6454 : H12AffineEnvironment.transform 7 37 env6451 = env6454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6451 == env6454) = true)

def leafEnv6454 : List Nat := [2,4,8,1,32,1,9,37,0,1024,1,4096,5132,4097,1,34,1061,5157,1024,1,4096,33,5156,2,1057,5132,1,5157,5156,4097,1061,1,1057,5134,36,5135,5,35,1061,1,0,1061,1]

def active6454 : List Nat := [0,1,2,4,9,11]

def tree6454 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6454 : H12WitnessSearch.Good tree6454 := H12GlobalWitnessIndex.good

theorem leafIdentity6454 : H12AffineFastState.composeSystem env6454 rootObs = leafEnv6454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6454 rootObs == leafEnv6454) = true)

theorem terminalChecked6454 : H12PackedTerminal.terminalCheckFast leafEnv6454 active6454 tree6454 = true := by decide +kernel

def env6455 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,33554432,17010964,21331968,17011733,131073,21105822,16876544,4294967296,257,4332954679,131072,33563272]

theorem envBound6455 : H12AffineFastState.Bounded env6455 := by
  intro p hp
  have h : env6455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6430_6455 : H12AffineEnvironment.transform 5 17 env6430 = env6455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6430 == env6455) = true)

theorem identity6455 : scanCanonicalize (H12AffineFastState.compose env6455 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015964) := by decide +kernel

theorem selectedBound6455 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6456 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,17015964,17010964,21331968,17011733,131073,21105822,16876544,4294967296,257,4315938987,131072,17008148]

theorem envBound6456 : H12AffineFastState.Bounded env6456 := by
  intro p hp
  have h : env6456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6455_6456 : H12AffineEnvironment.transform 24 17015964 env6455 = env6456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015964 env6455 == env6456) = true)

def env6457 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024069,131152,1073741824,16876544,4294967296,257,4332975159,131072,33563272]

theorem envBound6457 : H12AffineFastState.Bounded env6457 := by
  intro p hp
  have h : env6457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6400_6457 : H12AffineEnvironment.transform 18 1025 env6400 = env6457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env6400 == env6457) = true)

theorem identity6457 : scanCanonicalize (H12AffineFastState.compose env6457 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21105871) := by decide +kernel

theorem selectedBound6457 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env6458 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024069,131152,21105871,16876544,4294967296,257,4332975159,131072,33563272]

theorem envBound6458 : H12AffineFastState.Bounded env6458 := by
  intro p hp
  have h : env6458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6457_6458 : H12AffineEnvironment.transform 29 21105871 env6457 = env6458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21105871 env6457 == env6458) = true)

def env6459 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010965,21352448,17024021,131072,21105823,16876544,4294967296,257,4332975159,131072,33563272]

theorem envBound6459 : H12AffineFastState.Bounded env6459 := by
  intro p hp
  have h : env6459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6458_6459 : H12AffineEnvironment.transform 5 16 env6458 = env6459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6458 == env6459) = true)

def env6460 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010965,21352448,17024021,131072,21105823,16876544,4294967296,257,4332967607,131072,33554440]

theorem envBound6460 : H12AffineFastState.Bounded env6460 := by
  intro p hp
  have h : env6460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6459_6460 : H12AffineEnvironment.transform 12 640 env6459 = env6460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env6459 == env6460) = true)

def env6461 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897045,4096,20978847,16876544,4294967296,257,4332832439,4096,33554440]

theorem envBound6461 : H12AffineFastState.Bounded env6461 := by
  intro p hp
  have h : env6461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6460_6461 : H12AffineEnvironment.transform 16 4096 env6460 = env6461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env6460 == env6461) = true)

theorem identity6461 : scanCanonicalize (H12AffineFastState.compose env6461 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16880789) := by decide +kernel

theorem selectedBound6461 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6462 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,16880789,16875797,21352448,16897045,4096,20978847,16876544,4294967296,257,4315959842,4096,16880797]

theorem envBound6462 : H12AffineFastState.Bounded env6462 := by
  intro p hp
  have h : env6462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6461_6462 : H12AffineEnvironment.transform 24 16880789 env6461 = env6462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16880789 env6461 == env6462) = true)

def env6463 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,16880789,16875797,21352448,16897045,4096,20978847,16876544,4294967296,257,4315959466,4096,16880797]

theorem envBound6463 : H12AffineFastState.Bounded env6463 := by
  intro p hp
  have h : env6463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6462_6463 : H12AffineEnvironment.transform 8 136 env6462 = env6463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6462 == env6463) = true)

theorem identity6463 : scanCanonicalize (H12AffineFastState.compose env6463 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound6463 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6464 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,4096,32768,65536,4096,262144,1025,32768,4096,4194304,5376,16777216,16880789,16875797,21331968,16876565,4096,20978847,16876544,4294967296,257,4315938986,4096,16880797]

theorem envBound6464 : H12AffineFastState.Bounded env6464 := by
  intro p hp
  have h : env6464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6463_6464 : H12AffineEnvironment.transform 13 4096 env6463 = env6464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env6463 == env6464) = true)

theorem identity6464 : scanCanonicalize (H12AffineFastState.compose env6464 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound6464 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6465 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,4096,32768,65536,4096,262144,1025,32768,4096,4194304,5376,98565,5520,16,4456709,1296,4096,4300186,1285,4294967296,257,4299260335,4096,5528]

theorem envBound6465 : H12AffineFastState.Bounded env6465 := by
  intro p hp
  have h : env6465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6464_6465 : H12AffineEnvironment.transform 23 98565 env6464 = env6465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env6464 == env6465) = true)

theorem identity6465 : scanCanonicalize (H12AffineFastState.compose env6465 (packedSelected [8,10,12] rootPS)) = affineNative (2^(17+1) ^^^ 105533) := by decide +kernel

theorem selectedBound6465 : packedSelected [8,10,12] rootPS < 2^1333 := by decide +kernel

def env6466 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,4096,32768,65536,4096,105533,1025,32768,4096,4194304,5376,98565,5520,16,4300088,1296,4096,4300186,1285,4294967296,257,4299260335,4096,5528]

theorem envBound6466 : H12AffineFastState.Bounded env6466 := by
  intro p hp
  have h : env6466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6465_6466 : H12AffineEnvironment.transform 17 105533 env6465 = env6466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 105533 env6465 == env6466) = true)

theorem identity6466 : scanCanonicalize (H12AffineFastState.compose env6466 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6466 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6467 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1296,32768,65536,1296,100653,1025,32768,1296,4194304,16,98565,128,16,4294696,1296,1296,4294794,1285,4294967296,257,4299260335,1296,136]

theorem envBound6467 : H12AffineFastState.Bounded env6467 := by
  intro p hp
  have h : env6467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6466_6467 : H12AffineEnvironment.transform 11 1296 env6466 = env6467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env6466 == env6467) = true)

theorem identity6467 : scanCanonicalize (H12AffineFastState.compose env6467 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 269) := by decide +kernel

theorem selectedBound6467 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6468 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1296,32768,269,1296,34848,1025,32768,1296,4194304,16,32776,128,16,4229413,1296,1296,4229511,1285,4294967296,257,4299194530,1296,136]

theorem envBound6468 : H12AffineFastState.Bounded env6468 := by
  intro p hp
  have h : env6468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6467_6468 : H12AffineEnvironment.transform 15 269 env6467 = env6468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 269 env6467 == env6468) = true)

theorem identity6468 : scanCanonicalize (H12AffineFastState.compose env6468 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 33061) := by decide +kernel

theorem selectedBound6468 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6469 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1296,32768,269,1296,34848,1025,32768,1296,33061,16,32776,128,16,2048,1296,1296,2210,1285,4294967296,257,4294967687,1296,136]

theorem envBound6469 : H12AffineFastState.Bounded env6469 := by
  intro p hp
  have h : env6469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6468_6469 : H12AffineEnvironment.transform 21 33061 env6468 = env6469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 33061 env6468 == env6469) = true)

theorem identity6469 : scanCanonicalize (H12AffineFastState.compose env6469 (packedSelected [3,8] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound6469 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env6470 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1296,261,269,1296,2341,1025,261,1296,32,16,269,128,16,2048,1296,1296,2210,1285,4294967296,257,4294967687,1296,136]

theorem envBound6470 : H12AffineFastState.Bounded env6470 := by
  intro p hp
  have h : env6470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6469_6470 : H12AffineEnvironment.transform 14 261 env6469 = env6470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env6469 == env6470) = true)

theorem identity6470 : scanCanonicalize (H12AffineFastState.compose env6470 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound6470 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6471 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1296,261,269,1296,2341,1025,261,1296,32,16,269,128,16,2048,1296,1296,2210,1285,43,257,428,1296,136]

theorem envBound6471 : H12AffineFastState.Bounded env6471 := by
  intro p hp
  have h : env6471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6470_6471 : H12AffineEnvironment.transform 31 43 env6470 = env6471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env6470 == env6471) = true)

theorem identity6471 : scanCanonicalize (H12AffineFastState.compose env6471 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound6471 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6472 : List Nat := [2,4,8,16,32,16,128,135,136,1024,2048,1175,8,1175,130,138,1175,2210,1025,130,1175,32,16,138,128,16,2048,1175,1175,2210,1154,43,134,43,1175,136]

theorem envBound6472 : H12AffineFastState.Bounded env6472 := by
  intro p hp
  have h : env6472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6471_6472 : H12AffineEnvironment.transform 7 135 env6471 = env6472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env6471 == env6472) = true)

theorem identity6472 : scanCanonicalize (H12AffineFastState.compose env6472 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6472 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6473 : List Nat := [2,4,2,16,32,16,128,135,130,1024,2048,1175,2,1175,130,128,1175,2210,1025,130,1175,32,16,128,128,16,2048,1175,1175,2210,1154,33,134,33,1175,130]

theorem envBound6473 : H12AffineFastState.Bounded env6473 := by
  intro p hp
  have h : env6473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6472_6473 : H12AffineEnvironment.transform 2 2 env6472 = env6473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6472 == env6473) = true)

theorem identity6473 : scanCanonicalize (H12AffineFastState.compose env6473 (packedSelected [0,4] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6473 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6474 : List Nat := [2,4,2,16,32,16,2,5,0,1024,2048,1045,2,1045,0,2,1045,2080,1025,0,1045,32,16,2,2,16,2048,1045,1045,2080,1024,33,4,33,1045,0]

theorem envBound6474 : H12AffineFastState.Bounded env6474 := by
  intro p hp
  have h : env6474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6473_6474 : H12AffineEnvironment.transform 6 2 env6473 = env6474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6473 == env6474) = true)

theorem identity6474 : scanCanonicalize (H12AffineFastState.compose env6474 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound6474 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6475 : List Nat := [2,4,2,16,32,16,2,5,0,5,2048,16,2,16,0,2,16,2080,4,0,16,32,16,2,2,16,2048,16,16,2080,5,33,4,33,16,0]

theorem envBound6475 : H12AffineFastState.Bounded env6475 := by
  intro p hp
  have h : env6475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6474_6475 : H12AffineEnvironment.transform 9 5 env6474 = env6475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env6474 == env6475) = true)

theorem identity6475 : scanCanonicalize (H12AffineFastState.compose env6475 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound6475 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6476 : List Nat := [2,4,2,16,32,16,2,5,0,5,32,16,2,16,0,2,16,0,4,0,16,32,16,2,2,16,32,16,16,0,5,33,4,33,16,0]

theorem envBound6476 : H12AffineFastState.Bounded env6476 := by
  intro p hp
  have h : env6476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6475_6476 : H12AffineEnvironment.transform 10 32 env6475 = env6476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env6475 == env6476) = true)

theorem identity6476 : scanCanonicalize (H12AffineFastState.compose env6476 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound6476 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6477 : List Nat := [2,4,2,16,19,16,2,5,0,5,19,16,2,16,0,2,16,0,4,0,16,19,16,2,2,16,19,16,16,0,5,18,4,18,16,0]

theorem envBound6477 : H12AffineFastState.Bounded env6477 := by
  intro p hp
  have h : env6477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6476_6477 : H12AffineEnvironment.transform 4 19 env6476 = env6477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env6476 == env6477) = true)

theorem identity6477 : scanCanonicalize (H12AffineFastState.compose env6477 (packedSelected [16] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound6477 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env6478 : List Nat := [2,4,2,3,0,3,2,5,0,5,0,3,2,3,0,2,3,0,4,0,3,0,3,2,2,3,0,3,3,0,5,1,4,1,3,0]

theorem envBound6478 : H12AffineFastState.Bounded env6478 := by
  intro p hp
  have h : env6478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6477_6478 : H12AffineEnvironment.transform 3 3 env6477 = env6478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env6477 == env6478) = true)

def leafEnv6478 : List Nat := [2,4,2,3,0,3,2,5,0,5,0,3,2,3,0,2,3,0,4,0,3,0,3,2,4,2,1,3,0,3,3,0,5,1,4,1,5,2,3,0,0,3,1]

def active6478 : List Nat := [0,1]

def tree6478 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6478 : H12WitnessSearch.Good tree6478 := H12GlobalWitnessIndex.good

theorem leafIdentity6478 : H12AffineFastState.composeSystem env6478 rootObs = leafEnv6478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6478 rootObs == leafEnv6478) = true)

theorem terminalChecked6478 : H12PackedTerminal.terminalCheckFast leafEnv6478 active6478 tree6478 = true := by decide +kernel

def env6479 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,16880789,16875797,21352448,16897045,4096,20978847,16876544,4294967296,257,4315959467,4096,16880797]

theorem envBound6479 : H12AffineFastState.Bounded env6479 := by
  intro p hp
  have h : env6479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6462_6479 : H12AffineEnvironment.transform 8 137 env6462 = env6479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6462 == env6479) = true)

theorem identity6479 : scanCanonicalize (H12AffineFastState.compose env6479 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 103445) := by decide +kernel

theorem selectedBound6479 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env6480 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,103445,128,5376,4473877,16384,4096,4294794,4117,4294967296,257,4299277502,4096,136]

theorem envBound6480 : H12AffineFastState.Bounded env6480 := by
  intro p hp
  have h : env6480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6479_6480 : H12AffineEnvironment.transform 23 103445 env6479 = env6480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103445 env6479 == env6480) = true)

def env6481 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103445,128,5376,312477,16384,4096,67586,4117,4294967296,257,4295050294,4096,136]

theorem envBound6481 : H12AffineFastState.Bounded env6481 := by
  intro p hp
  have h : env6481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6480_6481 : H12AffineEnvironment.transform 21 32904 env6480 = env6481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32904 env6480 == env6481) = true)

theorem identity6481 : scanCanonicalize (H12AffineFastState.compose env6481 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 295075) := by decide +kernel

theorem selectedBound6481 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6482 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103445,128,5376,312477,16384,4096,67586,4117,295075,257,378005,4096,136]

theorem envBound6482 : H12AffineFastState.Bounded env6482 := by
  intro p hp
  have h : env6482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6481_6482 : H12AffineEnvironment.transform 31 295075 env6481 = env6482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 295075 env6481 == env6482) = true)

theorem identity6482 : scanCanonicalize (H12AffineFastState.compose env6482 (packedSelected [1,3,4,9,13,16,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound6482 : packedSelected [1,3,4,9,13,16,17,24,28] rootPS < 2^1333 := by decide +kernel

def env6483 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4097,32768,65536,4096,262144,1025,32768,4096,32904,5377,103445,128,5376,300188,4097,4096,67586,4117,295075,257,365716,4096,136]

theorem envBound6483 : H12AffineFastState.Bounded env6483 := by
  intro p hp
  have h : env6483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6482_6483 : H12AffineEnvironment.transform 13 4097 env6482 = env6483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6482 == env6483) = true)

theorem identity6483 : scanCanonicalize (H12AffineFastState.compose env6483 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6483 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6484 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1297,262144,1025,32768,1297,32904,16,98564,128,17,295309,1296,1297,67586,1284,295075,257,360837,1297,136]

theorem envBound6484 : H12AffineFastState.Bounded env6484 := by
  intro p hp
  have h : env6484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6483_6484 : H12AffineEnvironment.transform 11 1297 env6483 = env6484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6483 == env6484) = true)

theorem identity6484 : scanCanonicalize (H12AffineFastState.compose env6484 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 100783) := by decide +kernel

theorem selectedBound6484 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6485 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1297,100783,1025,32768,1297,32904,16,98564,128,17,67618,1296,1297,67586,1284,67852,257,2090,1297,136]

theorem envBound6485 : H12AffineFastState.Bounded env6485 := by
  intro p hp
  have h : env6485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6484_6485 : H12AffineEnvironment.transform 17 100783 env6484 = env6485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100783 env6484 == env6485) = true)

theorem identity6485 : scanCanonicalize (H12AffineFastState.compose env6485 (packedSelected [1,3,8] rootPS)) = affineNative (2^(15+1) ^^^ 399) := by decide +kernel

theorem selectedBound6485 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6486 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,399,1297,34848,1025,32768,1297,32904,16,32907,128,17,2477,1296,1297,2445,1284,2179,257,2090,1297,136]

theorem envBound6486 : H12AffineFastState.Bounded env6486 := by
  intro p hp
  have h : env6486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6485_6486 : H12AffineEnvironment.transform 15 399 env6485 = env6486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 399 env6485 == env6486) = true)

theorem identity6486 : scanCanonicalize (H12AffineFastState.compose env6486 (packedSelected [1] rootPS)) = affineNative (2^(14+1) ^^^ 130) := by decide +kernel

theorem selectedBound6486 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6487 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,130,399,1297,2210,1025,130,1297,10,16,9,128,17,2477,1296,1297,2445,1284,2179,257,2090,1297,136]

theorem envBound6487 : H12AffineFastState.Bounded env6487 := by
  intro p hp
  have h : env6487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6486_6487 : H12AffineEnvironment.transform 14 130 env6486 = env6487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 130 env6486 == env6487) = true)

theorem identity6487 : scanCanonicalize (H12AffineFastState.compose env6487 (packedSelected [10] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6487 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6488 : List Nat := [2,4,8,16,32,16,128,134,137,1024,2048,1175,9,1174,130,9,1175,2210,1025,130,1175,10,16,9,128,17,2091,1174,1175,2059,1154,2179,135,2090,1175,136]

theorem envBound6488 : H12AffineFastState.Bounded env6488 := by
  intro p hp
  have h : env6488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6487_6488 : H12AffineEnvironment.transform 7 134 env6487 = env6488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6487 == env6488) = true)

theorem identity6488 : scanCanonicalize (H12AffineFastState.compose env6488 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 42) := by decide +kernel

theorem selectedBound6488 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6489 : List Nat := [2,4,8,16,32,16,128,134,137,1024,42,1175,9,1174,130,9,1175,136,1025,130,1175,10,16,9,128,17,1,1174,1175,33,1154,169,135,0,1175,136]

theorem envBound6489 : H12AffineFastState.Bounded env6489 := by
  intro p hp
  have h : env6489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6488_6489 : H12AffineEnvironment.transform 10 42 env6488 = env6489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 42 env6488 == env6489) = true)

theorem identity6489 : scanCanonicalize (H12AffineFastState.compose env6489 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound6489 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env6490 : List Nat := [2,4,8,11,32,11,128,134,137,1024,42,1164,9,1165,130,9,1164,136,1025,130,1164,10,11,9,128,10,1,1165,1164,33,1154,169,135,0,1164,136]

theorem envBound6490 : H12AffineFastState.Bounded env6490 := by
  intro p hp
  have h : env6490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6489_6490 : H12AffineEnvironment.transform 3 11 env6489 = env6490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env6489 == env6490) = true)

theorem identity6490 : scanCanonicalize (H12AffineFastState.compose env6490 (packedSelected [9] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6490 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env6491 : List Nat := [2,4,3,0,32,0,128,134,130,1024,33,1159,2,1158,130,2,1159,131,1025,130,1159,1,0,2,128,1,1,1158,1159,33,1154,162,135,0,1159,131]

theorem envBound6491 : H12AffineFastState.Bounded env6491 := by
  intro p hp
  have h : env6491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6490_6491 : H12AffineEnvironment.transform 2 3 env6490 = env6491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6490 == env6491) = true)

theorem identity6491 : scanCanonicalize (H12AffineFastState.compose env6491 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6491 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6492 : List Nat := [2,4,3,0,32,0,3,5,1,1024,33,1028,2,1029,1,2,1028,0,1025,1,1028,1,0,2,3,1,1,1029,1028,33,1025,33,4,0,1028,0]

theorem envBound6492 : H12AffineFastState.Bounded env6492 := by
  intro p hp
  have h : env6492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6491_6492 : H12AffineEnvironment.transform 6 3 env6491 = env6492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6491 == env6492) = true)

def leafEnv6492 : List Nat := [2,4,3,0,32,0,3,5,1,1024,33,1028,2,1029,1,2,1028,0,1025,1,1028,1,0,2,1024,3,1,1,1,1029,1028,33,1025,33,4,0,5,3,1028,0,0,1028,1]

def active6492 : List Nat := [0,1,4,9]

def tree6492 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6492 : H12WitnessSearch.Good tree6492 := H12GlobalWitnessIndex.good

theorem leafIdentity6492 : H12AffineFastState.composeSystem env6492 rootObs = leafEnv6492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6492 rootObs == leafEnv6492) = true)

theorem terminalChecked6492 : H12PackedTerminal.terminalCheckFast leafEnv6492 active6492 tree6492 = true := by decide +kernel

def env6493 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103445,128,5376,312476,16384,4096,67587,4117,4294967296,257,4295050295,4096,136]

theorem envBound6493 : H12AffineFastState.Bounded env6493 := by
  intro p hp
  have h : env6493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6480_6493 : H12AffineEnvironment.transform 21 32905 env6480 = env6493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32905 env6480 == env6493) = true)

theorem identity6493 : scanCanonicalize (H12AffineFastState.compose env6493 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 267447) := by decide +kernel

theorem selectedBound6493 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6494 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103445,128,5376,312476,16384,4096,67587,4117,267447,257,348288,4096,136]

theorem envBound6494 : H12AffineFastState.Bounded env6494 := by
  intro p hp
  have h : env6494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6493_6494 : H12AffineEnvironment.transform 31 267447 env6493 = env6494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 267447 env6493 == env6494) = true)

def env6495 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897044,4097,20978846,16876544,4294967296,257,4332832438,4097,33554440]

theorem envBound6495 : H12AffineFastState.Bounded env6495 := by
  intro p hp
  have h : env6495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6460_6495 : H12AffineEnvironment.transform 16 4097 env6460 = env6495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env6460 == env6495) = true)

theorem identity6495 : scanCanonicalize (H12AffineFastState.compose env6495 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16875908) := by decide +kernel

theorem selectedBound6495 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6496 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,16875908,16875796,21352448,16897044,4097,20978846,16876544,4294967296,257,4315957042,4097,16875916]

theorem envBound6496 : H12AffineFastState.Bounded env6496 := by
  intro p hp
  have h : env6496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6495_6496 : H12AffineEnvironment.transform 24 16875908 env6495 = env6496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16875908 env6495 == env6496) = true)

def env6497 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,16777216,16875908,16875796,21337360,16879876,4097,20978846,16876544,4294967296,257,4315939362,4097,16875916]

theorem envBound6497 : H12AffineFastState.Bounded env6497 := by
  intro p hp
  have h : env6497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6496_6497 : H12AffineEnvironment.transform 13 1296 env6496 = env6497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env6496 == env6497) = true)

theorem identity6497 : scanCanonicalize (H12AffineFastState.compose env6497 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(23+1) ^^^ 104093) := by decide +kernel

theorem selectedBound6497 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env6498 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,104093,5913,6025,4457357,1945,4097,4295171,4765,4294967296,257,4299265215,4097,5905]

theorem envBound6498 : H12AffineFastState.Bounded env6498 := by
  intro p hp
  have h : env6498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6497_6498 : H12AffineEnvironment.transform 23 104093 env6497 = env6498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 104093 env6497 == env6498) = true)

theorem identity6498 : scanCanonicalize (H12AffineFastState.compose env6498 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6498 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env6499 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,103444,5520,5376,4456708,1296,4097,4294794,4116,4294967296,257,4299265215,4097,5528]

theorem envBound6499 : H12AffineFastState.Bounded env6499 := by
  intro p hp
  have h : env6499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6498_6499 : H12AffineEnvironment.transform 8 137 env6498 = env6499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6498 == env6499) = true)

theorem identity6499 : scanCanonicalize (H12AffineFastState.compose env6499 (packedSelected [4,5,8,9,13,16,17] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6499 : packedSelected [4,5,8,9,13,16,17] rootPS < 2^1333 := by decide +kernel

def env6500 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,98565,129,17,4456708,1296,1296,4294794,1285,4294967296,257,4299260334,1296,137]

theorem envBound6500 : H12AffineFastState.Bounded env6500 := by
  intro p hp
  have h : env6500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6499_6500 : H12AffineEnvironment.transform 11 1297 env6499 = env6500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6499 == env6500) = true)

theorem identity6500 : scanCanonicalize (H12AffineFastState.compose env6500 (packedSelected [1,3,5] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6500 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6501 : List Nat := [2,4,8,16,32,16,2,256,11,1024,2048,1297,9,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,98565,3,17,4456708,1296,1296,4294664,1285,4294967296,257,4299260204,1296,11]

theorem envBound6501 : H12AffineFastState.Bounded env6501 := by
  intro p hp
  have h : env6501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6500_6501 : H12AffineEnvironment.transform 6 2 env6500 = env6501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6500 == env6501) = true)

theorem identity6501 : scanCanonicalize (H12AffineFastState.compose env6501 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 100393) := by decide +kernel

theorem selectedBound6501 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6502 : List Nat := [2,4,8,16,32,16,2,256,11,1024,2048,1297,9,1296,32768,65536,1296,100393,1025,32768,1297,4194304,16,98565,3,17,4294957,1296,1296,4294664,1285,4294967296,257,4299260204,1296,11]

theorem envBound6502 : H12AffineFastState.Bounded env6502 := by
  intro p hp
  have h : env6502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6501_6502 : H12AffineEnvironment.transform 17 100393 env6501 = env6502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100393 env6501 == env6502) = true)

theorem identity6502 : scanCanonicalize (H12AffineFastState.compose env6502 (packedSelected [1,10] rootPS)) = affineNative (2^(15+1) ^^^ 1062) := by decide +kernel

theorem selectedBound6502 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6503 : List Nat := [2,4,8,16,32,16,2,256,11,1024,2048,1297,9,1296,32768,1062,1296,35855,1025,32768,1297,4194304,16,34083,3,17,4230411,1296,1296,4230190,1285,4294967296,257,4299195658,1296,11]

theorem envBound6503 : H12AffineFastState.Bounded env6503 := by
  intro p hp
  have h : env6503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6502_6503 : H12AffineEnvironment.transform 15 1062 env6502 = env6503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1062 env6502 == env6503) = true)

theorem identity6503 : scanCanonicalize (H12AffineFastState.compose env6503 (packedSelected [3,12] rootPS)) = affineNative (2^(21+1) ^^^ 33845) := by decide +kernel

theorem selectedBound6503 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6504 : List Nat := [2,4,8,16,32,16,2,256,11,1024,2048,1297,9,1296,32768,1062,1296,35855,1025,32768,1297,33845,16,34083,3,17,2366,1296,1296,2075,1285,4294967296,257,4294967615,1296,11]

theorem envBound6504 : H12AffineFastState.Bounded env6504 := by
  intro p hp
  have h : env6504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6503_6504 : H12AffineEnvironment.transform 21 33845 env6503 = env6504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 33845 env6503 == env6504) = true)

theorem identity6504 : scanCanonicalize (H12AffineFastState.compose env6504 (packedSelected [1,3,13] rootPS)) = affineNative (2^(14+1) ^^^ 1338) := by decide +kernel

theorem selectedBound6504 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env6505 : List Nat := [2,4,8,16,32,16,2,256,11,1024,2048,1297,9,1296,1338,1062,1296,2357,1025,1338,1297,271,16,25,3,17,2366,1296,1296,2075,1285,4294967296,257,4294967615,1296,11]

theorem envBound6505 : H12AffineFastState.Bounded env6505 := by
  intro p hp
  have h : env6505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6504_6505 : H12AffineEnvironment.transform 14 1338 env6504 = env6505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1338 env6504 == env6505) = true)

theorem identity6505 : scanCanonicalize (H12AffineFastState.compose env6505 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 1280) := by decide +kernel

theorem selectedBound6505 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6506 : List Nat := [2,4,8,16,32,16,2,256,11,1024,2048,1297,9,1296,1338,1062,1296,2357,1025,1338,1297,271,16,25,3,17,2366,1296,1296,2075,1285,1280,257,1087,1296,11]

theorem envBound6506 : H12AffineFastState.Bounded env6506 := by
  intro p hp
  have h : env6506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6505_6506 : H12AffineEnvironment.transform 31 1280 env6505 = env6506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1280 env6505 == env6506) = true)

def env6507 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,32768,65536,4097,262144,1025,32768,4096,4194304,17,16777216,16875908,16875796,21337361,16879877,4097,20978846,16876544,4294967296,257,4315939363,4097,16875916]

theorem envBound6507 : H12AffineFastState.Bounded env6507 := by
  intro p hp
  have h : env6507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6496_6507 : H12AffineEnvironment.transform 13 1297 env6496 = env6507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env6496 == env6507) = true)

theorem identity6507 : scanCanonicalize (H12AffineFastState.compose env6507 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound6507 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env6508 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,32768,65536,4097,262144,1025,32768,4096,4194304,17,103444,5520,5376,4456709,1297,4097,4294794,4116,4294967296,257,4299265591,4097,5528]

theorem envBound6508 : H12AffineFastState.Bounded env6508 := by
  intro p hp
  have h : env6508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6507_6508 : H12AffineEnvironment.transform 23 103444 env6507 = env6508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env6507 == env6508) = true)

theorem identity6508 : scanCanonicalize (H12AffineFastState.compose env6508 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 5788) := by decide +kernel

theorem selectedBound6508 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env6509 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,5788,65536,4097,262144,1025,5788,4096,4194304,17,66184,5520,5376,4456709,1297,4097,4267542,4116,4294967296,257,4299227307,4097,5528]

theorem envBound6509 : H12AffineFastState.Bounded env6509 := by
  intro p hp
  have h : env6509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6508_6509 : H12AffineEnvironment.transform 14 5788 env6508 = env6509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5788 env6508 == env6509) = true)

theorem identity6509 : scanCanonicalize (H12AffineFastState.compose env6509 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 7868) := by decide +kernel

theorem selectedBound6509 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env6510 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,5788,65536,4097,7868,1025,5788,4096,4194304,17,66184,5520,5376,4202425,1297,4097,4267542,4116,4294967296,257,4299227307,4097,5528]

theorem envBound6510 : H12AffineFastState.Bounded env6510 := by
  intro p hp
  have h : env6510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6509_6510 : H12AffineEnvironment.transform 17 7868 env6509 = env6510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7868 env6509 == env6510) = true)

theorem identity6510 : scanCanonicalize (H12AffineFastState.compose env6510 (packedSelected [5,6,8,25] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound6510 : packedSelected [5,6,8,25] rootPS < 2^1333 := by decide +kernel

def env6511 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,5788,139,4097,7868,1025,5788,4096,4194304,17,515,5520,5376,4202425,1297,4097,4202141,4116,4294967296,257,4299161632,4097,5528]

theorem envBound6511 : H12AffineFastState.Bounded env6511 := by
  intro p hp
  have h : env6511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6510_6511 : H12AffineEnvironment.transform 15 139 env6510 = env6511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env6510 == env6511) = true)

theorem identity6511 : scanCanonicalize (H12AffineFastState.compose env6511 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound6511 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6512 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,640,1297,261,139,1944,2341,1025,261,1945,4194304,17,515,521,665,4196384,1297,1944,4196612,1933,4294967296,257,4299161632,1944,513]

theorem envBound6512 : H12AffineFastState.Bounded env6512 := by
  intro p hp
  have h : env6512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6511_6512 : H12AffineEnvironment.transform 11 1945 env6511 = env6512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6511 == env6512) = true)

theorem identity6512 : scanCanonicalize (H12AffineFastState.compose env6512 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 2179) := by decide +kernel

theorem selectedBound6512 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6513 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,640,1297,261,139,1944,2341,1025,261,1945,4194304,17,515,521,665,4196384,1297,1944,4196612,1933,2179,257,4196515,1944,513]

theorem envBound6513 : H12AffineFastState.Bounded env6513 := by
  intro p hp
  have h : env6513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6512_6513 : H12AffineEnvironment.transform 31 2179 env6512 = env6513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2179 env6512 == env6513) = true)

def env6514 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,8,1297,261,139,1296,2341,1025,261,1297,4194304,17,139,129,17,4196384,1297,1296,4196612,1285,2179,257,4196515,1296,137]

theorem envBound6514 : H12AffineFastState.Bounded env6514 := by
  intro p hp
  have h : env6514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6513_6514 : H12AffineEnvironment.transform 8 136 env6513 = env6514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6513 == env6514) = true)

theorem identity6514 : scanCanonicalize (H12AffineFastState.compose env6514 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 286) := by decide +kernel

theorem selectedBound6514 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6515 : List Nat := [2,4,8,16,32,16,128,256,136,1024,286,1297,8,1297,261,139,1296,59,1025,261,1297,4194304,17,139,129,17,4194622,1297,1296,4194330,1285,413,257,4194749,1296,137]

theorem envBound6515 : H12AffineFastState.Bounded env6515 := by
  intro p hp
  have h : env6515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6514_6515 : H12AffineEnvironment.transform 10 286 env6514 = env6515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 286 env6514 == env6515) = true)

theorem identity6515 : scanCanonicalize (H12AffineFastState.compose env6515 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound6515 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6516 : List Nat := [2,4,8,16,32,16,128,36,136,1024,58,1077,8,1077,33,139,1076,59,1025,33,1077,4194304,17,139,129,17,4194330,1077,1076,4194330,1057,185,37,4194457,1076,137]

theorem envBound6516 : H12AffineFastState.Bounded env6516 := by
  intro p hp
  have h : env6516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6515_6516 : H12AffineEnvironment.transform 7 36 env6515 = env6516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6515 == env6516) = true)

theorem identity6516 : scanCanonicalize (H12AffineFastState.compose env6516 (packedSelected [2,4] rootPS)) = affineNative (2^(21+1) ^^^ 153) := by decide +kernel

theorem selectedBound6516 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6517 : List Nat := [2,4,8,16,32,16,128,36,136,1024,58,1077,8,1077,33,139,1076,59,1025,33,1077,153,17,139,129,17,131,1077,1076,131,1057,185,37,0,1076,137]

theorem envBound6517 : H12AffineFastState.Bounded env6517 := by
  intro p hp
  have h : env6517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6516_6517 : H12AffineEnvironment.transform 21 153 env6516 = env6517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 153 env6516 == env6517) = true)

theorem identity6517 : scanCanonicalize (H12AffineFastState.compose env6517 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound6517 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6518 : List Nat := [2,4,8,16,32,16,35,36,43,1024,58,1077,8,1077,33,40,1076,59,1025,33,1077,58,17,40,34,17,32,1077,1076,32,1057,26,37,0,1076,42]

theorem envBound6518 : H12AffineFastState.Bounded env6518 := by
  intro p hp
  have h : env6518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6517_6518 : H12AffineEnvironment.transform 6 35 env6517 = env6518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env6517 == env6518) = true)

theorem identity6518 : scanCanonicalize (H12AffineFastState.compose env6518 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound6518 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6519 : List Nat := [2,4,8,11,32,11,35,36,43,1024,33,1070,8,1070,33,40,1071,32,1025,33,1070,33,10,40,34,10,32,1070,1071,32,1057,1,37,0,1071,42]

theorem envBound6519 : H12AffineFastState.Bounded env6519 := by
  intro p hp
  have h : env6519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6518_6519 : H12AffineEnvironment.transform 3 11 env6518 = env6519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env6518 == env6519) = true)

theorem identity6519 : scanCanonicalize (H12AffineFastState.compose env6519 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6519 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6520 : List Nat := [2,4,8,11,1,11,2,5,10,1024,0,1039,8,1039,0,9,1038,1,1025,0,1039,0,10,9,3,10,1,1039,1038,1,1024,1,4,0,1038,11]

theorem envBound6520 : H12AffineFastState.Bounded env6520 := by
  intro p hp
  have h : env6520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6519_6520 : H12AffineEnvironment.transform 4 1 env6519 = env6520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6519 == env6520) = true)

def env6521 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,9,1297,261,139,1297,2341,1025,261,1296,4194304,17,138,128,16,4196384,1297,1297,4196612,1284,2179,257,4196515,1297,136]

theorem envBound6521 : H12AffineFastState.Bounded env6521 := by
  intro p hp
  have h : env6521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6513_6521 : H12AffineEnvironment.transform 8 137 env6513 = env6521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6513 == env6521) = true)

theorem identity6521 : scanCanonicalize (H12AffineFastState.compose env6521 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 163) := by decide +kernel

theorem selectedBound6521 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6522 : List Nat := [2,4,8,16,32,16,128,256,137,1024,163,1296,9,1297,261,139,1297,390,1025,261,1296,4194304,17,138,128,16,4194435,1297,1297,4194727,1284,32,257,4194304,1297,136]

theorem envBound6522 : H12AffineFastState.Bounded env6522 := by
  intro p hp
  have h : env6522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6521_6522 : H12AffineEnvironment.transform 10 163 env6521 = env6522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 163 env6521 == env6522) = true)

theorem identity6522 : scanCanonicalize (H12AffineFastState.compose env6522 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound6522 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6523 : List Nat := [2,4,8,16,27,16,128,256,137,1024,152,1296,9,1297,261,139,1297,390,1025,261,1296,4194304,17,138,128,16,4194435,1297,1297,4194716,1284,27,257,4194304,1297,136]

theorem envBound6523 : H12AffineFastState.Bounded env6523 := by
  intro p hp
  have h : env6523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6522_6523 : H12AffineEnvironment.transform 4 27 env6522 = env6523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env6522 == env6523) = true)

theorem identity6523 : scanCanonicalize (H12AffineFastState.compose env6523 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6523 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6524 : List Nat := [2,4,3,16,16,16,128,256,130,1024,147,1296,2,1297,261,128,1297,390,1025,261,1296,4194304,17,129,128,16,4194435,1297,1297,4194711,1284,16,257,4194304,1297,131]

theorem envBound6524 : H12AffineFastState.Bounded env6524 := by
  intro p hp
  have h : env6524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6523_6524 : H12AffineEnvironment.transform 2 3 env6523 = env6524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6523 == env6524) = true)

theorem identity6524 : scanCanonicalize (H12AffineFastState.compose env6524 (packedSelected [5] rootPS)) = affineNative (2^(21+1) ^^^ 130) := by decide +kernel

theorem selectedBound6524 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6525 : List Nat := [2,4,3,16,16,16,128,256,130,1024,147,1296,2,1297,261,128,1297,390,1025,261,1296,130,17,129,128,16,1,1297,1297,277,1284,16,257,130,1297,131]

theorem envBound6525 : H12AffineFastState.Bounded env6525 := by
  intro p hp
  have h : env6525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6524_6525 : H12AffineEnvironment.transform 21 130 env6524 = env6525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 130 env6524 == env6525) = true)

theorem identity6525 : scanCanonicalize (H12AffineFastState.compose env6525 (packedSelected [10] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound6525 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6526 : List Nat := [2,4,3,16,16,16,128,5,130,1024,147,1045,2,1044,0,128,1044,131,1025,0,1045,130,17,129,128,16,1,1044,1044,16,1025,16,4,130,1044,131]

theorem envBound6526 : H12AffineFastState.Bounded env6526 := by
  intro p hp
  have h : env6526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6525_6526 : H12AffineEnvironment.transform 7 5 env6525 = env6526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env6525 == env6526) = true)

theorem identity6526 : scanCanonicalize (H12AffineFastState.compose env6526 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6526 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6527 : List Nat := [2,4,3,16,16,16,3,5,1,1024,16,1045,2,1044,0,3,1044,0,1025,0,1045,1,17,2,3,16,1,1044,1044,16,1025,16,4,1,1044,0]

theorem envBound6527 : H12AffineFastState.Bounded env6527 := by
  intro p hp
  have h : env6527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6526_6527 : H12AffineEnvironment.transform 6 3 env6526 = env6527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6526 == env6527) = true)

def leafEnv6527 : List Nat := [2,4,3,16,16,16,3,5,1,1024,16,1045,2,1044,0,3,1044,0,1025,0,1045,1,17,2,1024,3,1,16,1,1044,1044,16,1025,16,4,1,5,2,1044,0,0,1044,1]

def active6527 : List Nat := [0,1,3,9]

def tree6527 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6527 : H12WitnessSearch.Good tree6527 := H12GlobalWitnessIndex.good

theorem leafIdentity6527 : H12AffineFastState.composeSystem env6527 rootObs = leafEnv6527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6527 rootObs == leafEnv6527) = true)

theorem terminalChecked6527 : H12PackedTerminal.terminalCheckFast leafEnv6527 active6527 tree6527 = true := by decide +kernel

def env6528 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010965,21352448,17024021,131072,21105823,16876544,4294967296,257,4332967606,131072,33554441]

theorem envBound6528 : H12AffineFastState.Bounded env6528 := by
  intro p hp
  have h : env6528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6459_6528 : H12AffineEnvironment.transform 12 641 env6459 = env6528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env6459 == env6528) = true)

def env6529 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897045,4096,20978847,16876544,4294967296,257,4332832438,4096,33554441]

theorem envBound6529 : H12AffineFastState.Bounded env6529 := by
  intro p hp
  have h : env6529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6528_6529 : H12AffineEnvironment.transform 16 4096 env6528 = env6529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env6528 == env6529) = true)

theorem identity6529 : scanCanonicalize (H12AffineFastState.compose env6529 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 104092) := by decide +kernel

theorem selectedBound6529 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6530 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,104092,33554432,6025,4474524,17033,4096,4295171,4764,4294967296,257,4332832438,4096,33554441]

theorem envBound6530 : H12AffineFastState.Bounded env6530 := by
  intro p hp
  have h : env6530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6529_6530 : H12AffineEnvironment.transform 23 104092 env6529 = env6530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 104092 env6529 == env6530) = true)

def env6531 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,104092,128,6025,4474524,17033,4096,4295171,4764,4294967296,257,4299277878,4096,137]

theorem envBound6531 : H12AffineFastState.Bounded env6531 := by
  intro p hp
  have h : env6531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6530_6531 : H12AffineEnvironment.transform 24 128 env6530 = env6531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env6530 == env6531) = true)

theorem identity6531 : scanCanonicalize (H12AffineFastState.compose env6531 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound6531 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6532 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,4096,32768,65536,4096,262144,1025,32768,4096,4194304,5376,104092,128,6025,4462236,4745,4096,4295171,4764,4294967296,257,4299265590,4096,137]

theorem envBound6532 : H12AffineFastState.Bounded env6532 := by
  intro p hp
  have h : env6532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6531_6532 : H12AffineEnvironment.transform 13 4096 env6531 = env6532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env6531 == env6532) = true)

theorem identity6532 : scanCanonicalize (H12AffineFastState.compose env6532 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound6532 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6533 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1945,32768,65536,1945,262144,1025,32768,1945,4194304,665,98565,128,16,4456709,1296,1945,4295171,1285,4294967296,257,4299260335,1945,137]

theorem envBound6533 : H12AffineFastState.Bounded env6533 := by
  intro p hp
  have h : env6533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6532_6533 : H12AffineEnvironment.transform 11 1945 env6532 = env6533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6532 == env6533) = true)

theorem identity6533 : scanCanonicalize (H12AffineFastState.compose env6533 (packedSelected [8,10,12] rootPS)) = affineNative (2^(17+1) ^^^ 101285) := by decide +kernel

theorem selectedBound6533 : packedSelected [8,10,12] rootPS < 2^1333 := by decide +kernel

def env6534 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1945,32768,65536,1945,101285,1025,32768,1945,4194304,665,98565,128,16,4295328,1296,1945,4295171,1285,4294967296,257,4299260335,1945,137]

theorem envBound6534 : H12AffineFastState.Bounded env6534 := by
  intro p hp
  have h : env6534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6533_6534 : H12AffineEnvironment.transform 17 101285 env6533 = env6534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 101285 env6533 == env6534) = true)

theorem identity6534 : scanCanonicalize (H12AffineFastState.compose env6534 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6534 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6535 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,32768,65536,1296,100652,1025,32768,1296,4194304,16,98565,128,16,4294697,1296,1296,4294794,1285,4294967296,257,4299260335,1296,137]

theorem envBound6535 : H12AffineFastState.Bounded env6535 := by
  intro p hp
  have h : env6535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6534_6535 : H12AffineEnvironment.transform 8 137 env6534 = env6535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6534 == env6535) = true)

theorem identity6535 : scanCanonicalize (H12AffineFastState.compose env6535 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 268) := by decide +kernel

theorem selectedBound6535 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6536 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,32768,268,1296,34848,1025,32768,1296,4194304,16,32777,128,16,4229413,1296,1296,4229510,1285,4294967296,257,4299194531,1296,137]

theorem envBound6536 : H12AffineFastState.Bounded env6536 := by
  intro p hp
  have h : env6536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6535_6536 : H12AffineEnvironment.transform 15 268 env6535 = env6536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 268 env6535 == env6536) = true)

theorem identity6536 : scanCanonicalize (H12AffineFastState.compose env6536 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 33061) := by decide +kernel

theorem selectedBound6536 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6537 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,32768,268,1296,34848,1025,32768,1296,33061,16,32777,128,16,2048,1296,1296,2211,1285,4294967296,257,4294967686,1296,137]

theorem envBound6537 : H12AffineFastState.Bounded env6537 := by
  intro p hp
  have h : env6537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6536_6537 : H12AffineEnvironment.transform 21 33061 env6536 = env6537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 33061 env6536 == env6537) = true)

theorem identity6537 : scanCanonicalize (H12AffineFastState.compose env6537 (packedSelected [3,8] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound6537 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env6538 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,261,268,1296,2341,1025,261,1296,32,16,268,128,16,2048,1296,1296,2211,1285,4294967296,257,4294967686,1296,137]

theorem envBound6538 : H12AffineFastState.Bounded env6538 := by
  intro p hp
  have h : env6538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6537_6538 : H12AffineEnvironment.transform 14 261 env6537 = env6538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env6537 == env6538) = true)

theorem identity6538 : scanCanonicalize (H12AffineFastState.compose env6538 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound6538 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6539 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,261,268,1296,2341,1025,261,1296,32,16,268,128,16,2048,1296,1296,2211,1285,42,257,428,1296,137]

theorem envBound6539 : H12AffineFastState.Bounded env6539 := by
  intro p hp
  have h : env6539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6538_6539 : H12AffineEnvironment.transform 31 42 env6538 = env6539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env6538 == env6539) = true)

theorem identity6539 : scanCanonicalize (H12AffineFastState.compose env6539 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6539 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6540 : List Nat := [2,4,8,16,32,16,128,134,137,1024,2048,1174,8,1174,131,138,1174,2211,1025,131,1174,32,16,138,128,16,2048,1174,1174,2211,1155,42,135,42,1174,137]

theorem envBound6540 : H12AffineFastState.Bounded env6540 := by
  intro p hp
  have h : env6540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6539_6540 : H12AffineEnvironment.transform 7 134 env6539 = env6540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6539 == env6540) = true)

theorem identity6540 : scanCanonicalize (H12AffineFastState.compose env6540 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6540 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6541 : List Nat := [2,4,2,16,32,16,128,134,131,1024,2048,1174,2,1174,131,128,1174,2211,1025,131,1174,32,16,128,128,16,2048,1174,1174,2211,1155,32,135,32,1174,131]

theorem envBound6541 : H12AffineFastState.Bounded env6541 := by
  intro p hp
  have h : env6541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6540_6541 : H12AffineEnvironment.transform 2 2 env6540 = env6541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6540 == env6541) = true)

theorem identity6541 : scanCanonicalize (H12AffineFastState.compose env6541 (packedSelected [0,4] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6541 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6542 : List Nat := [2,4,2,16,32,16,2,4,1,1024,2048,1044,2,1044,1,2,1044,2081,1025,1,1044,32,16,2,2,16,2048,1044,1044,2081,1025,32,5,32,1044,1]

theorem envBound6542 : H12AffineFastState.Bounded env6542 := by
  intro p hp
  have h : env6542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6541_6542 : H12AffineEnvironment.transform 6 2 env6541 = env6542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6541 == env6542) = true)

theorem identity6542 : scanCanonicalize (H12AffineFastState.compose env6542 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound6542 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6543 : List Nat := [2,4,2,16,32,16,2,4,1,4,2048,16,2,16,1,2,16,2081,5,1,16,32,16,2,2,16,2048,16,16,2081,5,32,5,32,16,1]

theorem envBound6543 : H12AffineFastState.Bounded env6543 := by
  intro p hp
  have h : env6543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6542_6543 : H12AffineEnvironment.transform 9 4 env6542 = env6543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env6542 == env6543) = true)

theorem identity6543 : scanCanonicalize (H12AffineFastState.compose env6543 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound6543 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6544 : List Nat := [2,4,2,16,32,16,2,4,1,4,32,16,2,16,1,2,16,1,5,1,16,32,16,2,2,16,32,16,16,1,5,32,5,32,16,1]

theorem envBound6544 : H12AffineFastState.Bounded env6544 := by
  intro p hp
  have h : env6544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6543_6544 : H12AffineEnvironment.transform 10 32 env6543 = env6544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env6543 == env6544) = true)

theorem identity6544 : scanCanonicalize (H12AffineFastState.compose env6544 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound6544 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6545 : List Nat := [2,4,2,3,32,3,2,4,1,4,32,3,2,3,1,2,3,1,5,1,3,32,3,2,2,3,32,3,3,1,5,32,5,32,3,1]

theorem envBound6545 : H12AffineFastState.Bounded env6545 := by
  intro p hp
  have h : env6545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6544_6545 : H12AffineEnvironment.transform 3 3 env6544 = env6545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env6544 == env6545) = true)

theorem identity6545 : scanCanonicalize (H12AffineFastState.compose env6545 (packedSelected [16] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6545 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env6546 : List Nat := [2,4,2,3,1,3,2,4,1,4,1,3,2,3,1,2,3,1,5,1,3,1,3,2,2,3,1,3,3,1,5,1,5,1,3,1]

theorem envBound6546 : H12AffineFastState.Bounded env6546 := by
  intro p hp
  have h : env6546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6545_6546 : H12AffineEnvironment.transform 4 1 env6545 = env6546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6545 == env6546) = true)

def leafEnv6546 : List Nat := [2,4,2,3,1,3,2,4,1,4,1,3,2,3,1,2,3,1,5,1,3,1,3,2,4,2,1,3,1,3,3,1,5,1,5,1,5,2,3,1,0,3,1]

def active6546 : List Nat := [0,1]

def tree6546 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6546 : H12WitnessSearch.Good tree6546 := H12GlobalWitnessIndex.good

theorem leafIdentity6546 : H12AffineFastState.composeSystem env6546 rootObs = leafEnv6546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6546 rootObs == leafEnv6546) = true)

theorem terminalChecked6546 : H12PackedTerminal.terminalCheckFast leafEnv6546 active6546 tree6546 = true := by decide +kernel

def env6547 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,104092,129,6025,4474524,17033,4096,4295171,4764,4294967296,257,4299277879,4096,136]

theorem envBound6547 : H12AffineFastState.Bounded env6547 := by
  intro p hp
  have h : env6547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6530_6547 : H12AffineEnvironment.transform 24 129 env6530 = env6547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env6530 == env6547) = true)

theorem identity6547 : scanCanonicalize (H12AffineFastState.compose env6547 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6547 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env6548 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,103445,129,5376,4473877,16384,4096,4294794,4117,4294967296,257,4299277502,4096,136]

theorem envBound6548 : H12AffineFastState.Bounded env6548 := by
  intro p hp
  have h : env6548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6547_6548 : H12AffineEnvironment.transform 8 137 env6547 = env6548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6547 == env6548) = true)

def env6549 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103445,129,5376,312477,16384,4096,67586,4117,4294967296,257,4295050294,4096,136]

theorem envBound6549 : H12AffineFastState.Bounded env6549 := by
  intro p hp
  have h : env6549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6548_6549 : H12AffineEnvironment.transform 21 32904 env6548 = env6549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32904 env6548 == env6549) = true)

theorem identity6549 : scanCanonicalize (H12AffineFastState.compose env6549 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 279734) := by decide +kernel

theorem selectedBound6549 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6550 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103445,129,5376,312477,16384,4096,67586,4117,279734,257,327808,4096,136]

theorem envBound6550 : H12AffineFastState.Bounded env6550 := by
  intro p hp
  have h : env6550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6549_6550 : H12AffineEnvironment.transform 31 279734 env6549 = env6550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 279734 env6549 == env6550) = true)

def env6551 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103445,129,5376,312476,16384,4096,67587,4117,4294967296,257,4295050295,4096,136]

theorem envBound6551 : H12AffineFastState.Bounded env6551 := by
  intro p hp
  have h : env6551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6548_6551 : H12AffineEnvironment.transform 21 32905 env6548 = env6551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32905 env6548 == env6551) = true)

theorem identity6551 : scanCanonicalize (H12AffineFastState.compose env6551 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 315555) := by decide +kernel

theorem selectedBound6551 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6552 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103445,129,5376,312476,16384,4096,67587,4117,315555,257,365716,4096,136]

theorem envBound6552 : H12AffineFastState.Bounded env6552 := by
  intro p hp
  have h : env6552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6551_6552 : H12AffineEnvironment.transform 31 315555 env6551 = env6552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 315555 env6551 == env6552) = true)

theorem identity6552 : scanCanonicalize (H12AffineFastState.compose env6552 (packedSelected [1,3,4,9,13,16,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound6552 : packedSelected [1,3,4,9,13,16,17,24,28] rootPS < 2^1333 := by decide +kernel

def env6553 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4097,32768,65536,4096,262144,1025,32768,4096,32905,5377,103445,129,5376,300189,4097,4096,67587,4117,295074,257,365716,4096,136]

theorem envBound6553 : H12AffineFastState.Bounded env6553 := by
  intro p hp
  have h : env6553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6552_6553 : H12AffineEnvironment.transform 13 4097 env6552 = env6553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6552 == env6553) = true)

theorem identity6553 : scanCanonicalize (H12AffineFastState.compose env6553 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6553 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6554 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,262144,1025,32768,1297,32905,16,98564,129,17,295308,1296,1297,67587,1284,295074,257,360837,1297,136]

theorem envBound6554 : H12AffineFastState.Bounded env6554 := by
  intro p hp
  have h : env6554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6553_6554 : H12AffineEnvironment.transform 11 1297 env6553 = env6554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6553 == env6554) = true)

theorem identity6554 : scanCanonicalize (H12AffineFastState.compose env6554 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 100783) := by decide +kernel

theorem selectedBound6554 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6555 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,100783,1025,32768,1297,32905,16,98564,129,17,67619,1296,1297,67587,1284,67853,257,2090,1297,136]

theorem envBound6555 : H12AffineFastState.Bounded env6555 := by
  intro p hp
  have h : env6555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6554_6555 : H12AffineEnvironment.transform 17 100783 env6554 = env6555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100783 env6554 == env6555) = true)

theorem identity6555 : scanCanonicalize (H12AffineFastState.compose env6555 (packedSelected [1,3,8] rootPS)) = affineNative (2^(15+1) ^^^ 398) := by decide +kernel

theorem selectedBound6555 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6556 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,398,1297,34849,1025,32768,1297,32905,16,32906,129,17,2477,1296,1297,2445,1284,2179,257,2090,1297,136]

theorem envBound6556 : H12AffineFastState.Bounded env6556 := by
  intro p hp
  have h : env6556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6555_6556 : H12AffineEnvironment.transform 15 398 env6555 = env6556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 398 env6555 == env6556) = true)

theorem identity6556 : scanCanonicalize (H12AffineFastState.compose env6556 (packedSelected [1] rootPS)) = affineNative (2^(14+1) ^^^ 131) := by decide +kernel

theorem selectedBound6556 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6557 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,131,398,1297,2210,1025,131,1297,10,16,9,129,17,2477,1296,1297,2445,1284,2179,257,2090,1297,136]

theorem envBound6557 : H12AffineFastState.Bounded env6557 := by
  intro p hp
  have h : env6557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6556_6557 : H12AffineEnvironment.transform 14 131 env6556 = env6557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 131 env6556 == env6557) = true)

theorem identity6557 : scanCanonicalize (H12AffineFastState.compose env6557 (packedSelected [10] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6557 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6558 : List Nat := [2,4,8,16,32,16,128,134,137,1024,2048,1175,8,1174,131,8,1175,2210,1025,131,1175,10,16,9,129,17,2091,1174,1175,2059,1154,2179,135,2090,1175,136]

theorem envBound6558 : H12AffineFastState.Bounded env6558 := by
  intro p hp
  have h : env6558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6557_6558 : H12AffineEnvironment.transform 7 134 env6557 = env6558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6557 == env6558) = true)

theorem identity6558 : scanCanonicalize (H12AffineFastState.compose env6558 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 43) := by decide +kernel

theorem selectedBound6558 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6559 : List Nat := [2,4,8,16,32,16,128,134,137,1024,43,1175,8,1174,131,8,1175,137,1025,131,1175,10,16,9,129,17,0,1174,1175,32,1154,168,135,1,1175,136]

theorem envBound6559 : H12AffineFastState.Bounded env6559 := by
  intro p hp
  have h : env6559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6558_6559 : H12AffineEnvironment.transform 10 43 env6558 = env6559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 43 env6558 == env6559) = true)

theorem identity6559 : scanCanonicalize (H12AffineFastState.compose env6559 (packedSelected [0,2] rootPS)) = affineNative (2^(6+1) ^^^ 51) := by decide +kernel

theorem selectedBound6559 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env6560 : List Nat := [2,4,8,16,32,16,51,53,58,1024,43,1060,8,1061,48,8,1060,58,1025,48,1060,10,16,9,50,17,0,1061,1060,32,1073,27,52,1,1060,59]

theorem envBound6560 : H12AffineFastState.Bounded env6560 := by
  intro p hp
  have h : env6560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6559_6560 : H12AffineEnvironment.transform 6 51 env6559 = env6560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 51 env6559 == env6560) = true)

theorem identity6560 : scanCanonicalize (H12AffineFastState.compose env6560 (packedSelected [9] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound6560 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env6561 : List Nat := [2,4,8,16,27,16,8,14,1,1024,16,1055,8,1054,11,8,1055,1,1025,11,1055,10,16,9,9,17,0,1054,1055,27,1034,27,15,1,1055,0]

theorem envBound6561 : H12AffineFastState.Bounded env6561 := by
  intro p hp
  have h : env6561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6560_6561 : H12AffineEnvironment.transform 4 27 env6560 = env6561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env6560 == env6561) = true)

theorem identity6561 : scanCanonicalize (H12AffineFastState.compose env6561 (packedSelected [0,11] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6561 : packedSelected [0,11] rootPS < 2^1333 := by decide +kernel

def env6562 : List Nat := [2,4,3,16,16,16,3,5,1,1024,16,1044,3,1045,0,3,1044,1,1025,0,1044,1,16,2,2,17,0,1045,1044,16,1025,16,4,1,1044,0]

theorem envBound6562 : H12AffineFastState.Bounded env6562 := by
  intro p hp
  have h : env6562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6561_6562 : H12AffineEnvironment.transform 2 3 env6561 = env6562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6561 == env6562) = true)

def leafEnv6562 : List Nat := [2,4,3,16,16,16,3,5,1,1024,16,1044,3,1045,0,3,1044,1,1025,0,1044,1,16,2,1024,2,1,17,0,1045,1044,16,1025,16,4,1,5,2,1044,0,0,1044,1]

def active6562 : List Nat := [0,1,3,9]

def tree6562 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6562 : H12WitnessSearch.Good tree6562 := H12GlobalWitnessIndex.good

theorem leafIdentity6562 : H12AffineFastState.composeSystem env6562 rootObs = leafEnv6562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6562 rootObs == leafEnv6562) = true)

theorem terminalChecked6562 : H12PackedTerminal.terminalCheckFast leafEnv6562 active6562 tree6562 = true := by decide +kernel

def env6563 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897044,4097,20978846,16876544,4294967296,257,4332832439,4097,33554441]

theorem envBound6563 : H12AffineFastState.Bounded env6563 := by
  intro p hp
  have h : env6563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6528_6563 : H12AffineEnvironment.transform 16 4097 env6528 = env6563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env6528 == env6563) = true)

theorem identity6563 : scanCanonicalize (H12AffineFastState.compose env6563 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound6563 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6564 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,99213,33554432,665,4477837,22425,4097,4300563,1933,4294967296,257,4332832439,4097,33554441]

theorem envBound6564 : H12AffineFastState.Bounded env6564 := by
  intro p hp
  have h : env6564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6563_6564 : H12AffineEnvironment.transform 23 99213 env6563 = env6564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env6563 == env6564) = true)

def env6565 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,99213,33554432,665,4462237,4745,4097,4300563,1933,4294967296,257,4332815271,4097,33554441]

theorem envBound6565 : H12AffineFastState.Bounded env6565 := by
  intro p hp
  have h : env6565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6564_6565 : H12AffineEnvironment.transform 13 1296 env6564 = env6565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env6564 == env6565) = true)

theorem identity6565 : scanCanonicalize (H12AffineFastState.compose env6565 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(24+1) ^^^ 5912) := by decide +kernel

theorem selectedBound6565 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env6566 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,99213,5912,665,4462237,4745,4097,4300563,1933,4294967296,257,4299265215,4097,5905]

theorem envBound6566 : H12AffineFastState.Bounded env6566 := by
  intro p hp
  have h : env6566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6565_6566 : H12AffineEnvironment.transform 24 5912 env6565 = env6566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5912 env6565 == env6566) = true)

theorem identity6566 : scanCanonicalize (H12AffineFastState.compose env6566 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound6566 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env6567 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1296,32768,65536,1944,262144,1025,32768,1945,4194304,16,99213,129,665,4456708,1296,1944,4294794,1933,4294967296,257,4299260710,1944,136]

theorem envBound6567 : H12AffineFastState.Bounded env6567 := by
  intro p hp
  have h : env6567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6566_6567 : H12AffineEnvironment.transform 11 1945 env6566 = env6567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6566 == env6567) = true)

def env6568 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1297,32768,65536,4097,262144,1025,32768,4096,4194304,17,99213,33554432,665,4462236,4744,4097,4300563,1933,4294967296,257,4332815270,4097,33554441]

theorem envBound6568 : H12AffineFastState.Bounded env6568 := by
  intro p hp
  have h : env6568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6564_6568 : H12AffineEnvironment.transform 13 1297 env6564 = env6568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env6564 == env6568) = true)

theorem identity6568 : scanCanonicalize (H12AffineFastState.compose env6568 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound6568 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env6569 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1297,32768,65536,1944,262144,1025,32768,1945,4194304,17,99213,33554432,665,4456709,1297,1944,4294794,1933,4294967296,257,4332815270,1944,33554441]

theorem envBound6569 : H12AffineFastState.Bounded env6569 := by
  intro p hp
  have h : env6569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6568_6569 : H12AffineEnvironment.transform 11 1945 env6568 = env6569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6568 == env6569) = true)

theorem identity6569 : scanCanonicalize (H12AffineFastState.compose env6569 (packedSelected [3,5,8,10,13,15,17,21,24] rootPS)) = affineNative (2^(17+1) ^^^ 68015) := by decide +kernel

theorem selectedBound6569 : packedSelected [3,5,8,10,13,15,17,21,24] rootPS < 2^1333 := by decide +kernel

def env6570 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1297,32768,65536,1944,68015,1025,32768,1945,4194304,17,99213,33554432,665,4262058,1297,1944,4294794,1933,4294967296,257,4332815270,1944,33554441]

theorem envBound6570 : H12AffineFastState.Bounded env6570 := by
  intro p hp
  have h : env6570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6569_6570 : H12AffineEnvironment.transform 17 68015 env6569 = env6570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 68015 env6569 == env6570) = true)

theorem identity6570 : scanCanonicalize (H12AffineFastState.compose env6570 (packedSelected [1,3,5,8,10,13,15,17,21] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound6570 : packedSelected [1,3,5,8,10,13,15,17,21] rootPS < 2^1333 := by decide +kernel

def env6571 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1297,32768,138,1944,2341,1025,32768,1945,4194304,17,33543,33554432,665,4196384,1297,1944,4229120,1933,4294967296,257,4332749612,1944,33554441]

theorem envBound6571 : H12AffineFastState.Bounded env6571 := by
  intro p hp
  have h : env6571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6570_6571 : H12AffineEnvironment.transform 15 138 env6570 = env6571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env6570 == env6571) = true)

theorem identity6571 : scanCanonicalize (H12AffineFastState.compose env6571 (packedSelected [1,3,5,8,10,13,15] rootPS)) = affineNative (2^(24+1) ^^^ 33548) := by decide +kernel

theorem selectedBound6571 : packedSelected [1,3,5,8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6572 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1297,32768,138,1944,2341,1025,32768,1945,4194304,17,33543,33548,665,4196384,1297,1944,4229120,1933,4294967296,257,4299161632,1944,33541]

theorem envBound6572 : H12AffineFastState.Bounded env6572 := by
  intro p hp
  have h : env6572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6571_6572 : H12AffineEnvironment.transform 24 33548 env6571 = env6572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 33548 env6571 == env6572) = true)

theorem identity6572 : scanCanonicalize (H12AffineFastState.compose env6572 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound6572 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6573 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1297,260,138,1944,2341,1025,260,1945,4194304,17,515,520,665,4196384,1297,1944,4196612,1933,4294967296,257,4299161632,1944,513]

theorem envBound6573 : H12AffineFastState.Bounded env6573 := by
  intro p hp
  have h : env6573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6572_6573 : H12AffineEnvironment.transform 14 260 env6572 = env6573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env6572 == env6573) = true)

theorem identity6573 : scanCanonicalize (H12AffineFastState.compose env6573 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 2570) := by decide +kernel

theorem selectedBound6573 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6574 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1297,260,138,1944,2341,1025,260,1945,4194304,17,515,520,665,4196384,1297,1944,4196612,1933,2570,257,4196906,1944,513]

theorem envBound6574 : H12AffineFastState.Bounded env6574 := by
  intro p hp
  have h : env6574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6573_6574 : H12AffineEnvironment.transform 31 2570 env6573 = env6574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2570 env6573 == env6574) = true)

def env6575 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,9,1297,260,138,1296,2341,1025,260,1297,4194304,17,139,128,17,4196384,1297,1296,4196612,1285,2178,257,4196514,1296,137]

theorem envBound6575 : H12AffineFastState.Bounded env6575 := by
  intro p hp
  have h : env6575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6574_6575 : H12AffineEnvironment.transform 8 136 env6574 = env6575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6574 == env6575) = true)

theorem identity6575 : scanCanonicalize (H12AffineFastState.compose env6575 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 287) := by decide +kernel

theorem selectedBound6575 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6576 : List Nat := [2,4,8,16,32,16,128,256,136,1024,287,1297,9,1297,260,138,1296,58,1025,260,1297,4194304,17,139,128,17,4194623,1297,1296,4194331,1285,413,257,4194749,1296,137]

theorem envBound6576 : H12AffineFastState.Bounded env6576 := by
  intro p hp
  have h : env6576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6575_6576 : H12AffineEnvironment.transform 10 287 env6575 = env6576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 287 env6575 == env6576) = true)

theorem identity6576 : scanCanonicalize (H12AffineFastState.compose env6576 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound6576 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6577 : List Nat := [2,4,8,16,32,16,128,36,136,1024,59,1077,9,1077,32,138,1076,58,1025,32,1077,4194304,17,139,128,17,4194331,1077,1076,4194331,1057,185,37,4194457,1076,137]

theorem envBound6577 : H12AffineFastState.Bounded env6577 := by
  intro p hp
  have h : env6577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6576_6577 : H12AffineEnvironment.transform 7 36 env6576 = env6577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6576 == env6577) = true)

theorem identity6577 : scanCanonicalize (H12AffineFastState.compose env6577 (packedSelected [2,4] rootPS)) = affineNative (2^(21+1) ^^^ 153) := by decide +kernel

theorem selectedBound6577 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6578 : List Nat := [2,4,8,16,32,16,128,36,136,1024,59,1077,9,1077,32,138,1076,58,1025,32,1077,153,17,139,128,17,130,1077,1076,130,1057,185,37,0,1076,137]

theorem envBound6578 : H12AffineFastState.Bounded env6578 := by
  intro p hp
  have h : env6578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6577_6578 : H12AffineEnvironment.transform 21 153 env6577 = env6578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 153 env6577 == env6578) = true)

theorem identity6578 : scanCanonicalize (H12AffineFastState.compose env6578 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound6578 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6579 : List Nat := [2,4,8,16,32,16,35,36,43,1024,59,1077,9,1077,32,41,1076,58,1025,32,1077,58,17,40,35,17,33,1077,1076,33,1057,26,37,0,1076,42]

theorem envBound6579 : H12AffineFastState.Bounded env6579 := by
  intro p hp
  have h : env6579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6578_6579 : H12AffineEnvironment.transform 6 35 env6578 = env6579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env6578 == env6579) = true)

theorem identity6579 : scanCanonicalize (H12AffineFastState.compose env6579 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound6579 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6580 : List Nat := [2,4,8,11,32,11,35,36,43,1024,32,1070,9,1070,32,41,1071,33,1025,32,1070,33,10,40,35,10,33,1070,1071,33,1057,1,37,0,1071,42]

theorem envBound6580 : H12AffineFastState.Bounded env6580 := by
  intro p hp
  have h : env6580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6579_6580 : H12AffineEnvironment.transform 3 11 env6579 = env6580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env6579 == env6580) = true)

theorem identity6580 : scanCanonicalize (H12AffineFastState.compose env6580 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6580 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6581 : List Nat := [2,4,8,11,1,11,2,5,10,1024,1,1039,9,1039,1,8,1038,0,1025,1,1039,0,10,9,2,10,0,1039,1038,0,1024,1,4,0,1038,11]

theorem envBound6581 : H12AffineFastState.Bounded env6581 := by
  intro p hp
  have h : env6581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6580_6581 : H12AffineEnvironment.transform 4 1 env6580 = env6581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6580 == env6581) = true)

def env6582 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1297,260,138,1297,2341,1025,260,1296,4194304,17,138,129,16,4196384,1297,1297,4196612,1284,2179,257,4196515,1297,136]

theorem envBound6582 : H12AffineFastState.Bounded env6582 := by
  intro p hp
  have h : env6582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6574_6582 : H12AffineEnvironment.transform 8 137 env6574 = env6582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6574 == env6582) = true)

theorem identity6582 : scanCanonicalize (H12AffineFastState.compose env6582 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 162) := by decide +kernel

theorem selectedBound6582 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6583 : List Nat := [2,4,8,16,32,16,128,256,137,1024,162,1296,8,1297,260,138,1297,391,1025,260,1296,4194304,17,138,129,16,4194434,1297,1297,4194726,1284,33,257,4194305,1297,136]

theorem envBound6583 : H12AffineFastState.Bounded env6583 := by
  intro p hp
  have h : env6583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6582_6583 : H12AffineEnvironment.transform 10 162 env6582 = env6583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 162 env6582 == env6583) = true)

theorem identity6583 : scanCanonicalize (H12AffineFastState.compose env6583 (packedSelected [2] rootPS)) = affineNative (2^(21+1) ^^^ 26) := by decide +kernel

theorem selectedBound6583 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6584 : List Nat := [2,4,8,16,32,16,128,256,137,1024,162,1296,8,1297,260,138,1297,391,1025,260,1296,26,17,138,129,16,152,1297,1297,444,1284,33,257,27,1297,136]

theorem envBound6584 : H12AffineFastState.Bounded env6584 := by
  intro p hp
  have h : env6584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6583_6584 : H12AffineEnvironment.transform 21 26 env6583 = env6584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 26 env6583 == env6584) = true)

theorem identity6584 : scanCanonicalize (H12AffineFastState.compose env6584 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6584 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6585 : List Nat := [2,4,3,16,32,16,128,256,130,1024,162,1296,3,1297,260,129,1297,391,1025,260,1296,17,17,129,129,16,147,1297,1297,439,1284,33,257,16,1297,131]

theorem envBound6585 : H12AffineFastState.Bounded env6585 := by
  intro p hp
  have h : env6585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6584_6585 : H12AffineEnvironment.transform 2 3 env6584 = env6585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6584 == env6585) = true)

theorem identity6585 : scanCanonicalize (H12AffineFastState.compose env6585 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound6585 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6586 : List Nat := [2,4,3,16,32,16,19,256,17,1024,49,1296,3,1297,260,18,1297,276,1025,260,1296,17,17,18,18,16,0,1297,1297,292,1284,33,257,16,1297,16]

theorem envBound6586 : H12AffineFastState.Bounded env6586 := by
  intro p hp
  have h : env6586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6585_6586 : H12AffineEnvironment.transform 6 19 env6585 = env6586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env6585 == env6586) = true)

theorem identity6586 : scanCanonicalize (H12AffineFastState.compose env6586 (packedSelected [10] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound6586 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6587 : List Nat := [2,4,3,16,32,16,19,5,17,1024,49,1045,3,1044,1,18,1044,17,1025,1,1045,17,17,18,18,16,0,1044,1044,33,1025,33,4,16,1044,16]

theorem envBound6587 : H12AffineFastState.Bounded env6587 := by
  intro p hp
  have h : env6587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6586_6587 : H12AffineEnvironment.transform 7 5 env6586 = env6587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env6586 == env6587) = true)

theorem identity6587 : scanCanonicalize (H12AffineFastState.compose env6587 (packedSelected [7] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound6587 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6588 : List Nat := [2,4,3,0,32,0,3,5,1,1024,33,1029,3,1028,1,2,1028,1,1025,1,1029,1,1,2,2,0,0,1028,1028,33,1025,33,4,0,1028,0]

theorem envBound6588 : H12AffineFastState.Bounded env6588 := by
  intro p hp
  have h : env6588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6587_6588 : H12AffineEnvironment.transform 3 0 env6587 = env6588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6587 == env6588) = true)

def leafEnv6588 : List Nat := [2,4,3,0,32,0,3,5,1,1024,33,1029,3,1028,1,2,1028,1,1025,1,1029,1,1,2,1024,2,1,0,0,1028,1028,33,1025,33,4,0,5,3,1028,0,0,1028,1]

def active6588 : List Nat := [0,1,4,9]

def tree6588 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6588 : H12WitnessSearch.Good tree6588 := H12GlobalWitnessIndex.good

theorem leafIdentity6588 : H12AffineFastState.composeSystem env6588 rootObs = leafEnv6588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6588 rootObs == leafEnv6588) = true)

theorem terminalChecked6588 : H12PackedTerminal.terminalCheckFast leafEnv6588 active6588 tree6588 = true := by decide +kernel

def env6589 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010964,21352449,17024020,131073,21105822,16876544,4294967296,257,4332975159,131072,33563272]

theorem envBound6589 : H12AffineFastState.Bounded env6589 := by
  intro p hp
  have h : env6589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6458_6589 : H12AffineEnvironment.transform 5 17 env6458 = env6589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6458 == env6589) = true)

def env6590 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010964,21352449,17024020,131073,21105822,16876544,4294967296,257,4332967607,131072,33554440]

theorem envBound6590 : H12AffineFastState.Bounded env6590 := by
  intro p hp
  have h : env6590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6589_6590 : H12AffineEnvironment.transform 12 640 env6589 = env6590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env6589 == env6590) = true)

def env6591 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897044,4097,20978846,16876544,4294967296,257,4332832439,4096,33554440]

theorem envBound6591 : H12AffineFastState.Bounded env6591 := by
  intro p hp
  have h : env6591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6590_6591 : H12AffineEnvironment.transform 16 4096 env6590 = env6591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env6590 == env6591) = true)

theorem identity6591 : scanCanonicalize (H12AffineFastState.compose env6591 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 5520) := by decide +kernel

theorem selectedBound6591 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6592 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,5520,16875796,21352449,16897044,4097,20978846,16876544,4294967296,257,4299281191,4096,5528]

theorem envBound6592 : H12AffineFastState.Bounded env6592 := by
  intro p hp
  have h : env6592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6591_6592 : H12AffineEnvironment.transform 24 5520 env6591 = env6592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5520 env6591 == env6592) = true)

def env6593 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,16384,32768,65536,1296,262144,1025,32768,1296,4194304,17664,16777216,128,16875796,21349649,16892164,1297,20973966,16876544,4294967296,257,4299277879,1296,136]

theorem envBound6593 : H12AffineFastState.Bounded env6593 := by
  intro p hp
  have h : env6593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6592_6593 : H12AffineEnvironment.transform 11 1296 env6592 = env6593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env6592 == env6593) = true)

theorem identity6593 : scanCanonicalize (H12AffineFastState.compose env6593 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound6593 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env6594 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,16384,32768,65536,1296,262144,1025,32768,1296,4194304,17664,99213,128,665,4474524,17033,1297,4295171,1933,4294967296,257,4299277879,1296,136]

theorem envBound6594 : H12AffineFastState.Bounded env6594 := by
  intro p hp
  have h : env6594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6593_6594 : H12AffineEnvironment.transform 23 99213 env6593 = env6594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env6593 == env6594) = true)

theorem identity6594 : scanCanonicalize (H12AffineFastState.compose env6594 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6594 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env6595 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,1296,32768,65536,1296,262144,1025,32768,1296,4194304,16,99213,128,665,4457356,1945,1297,4295171,1933,4294967296,257,4299260711,1296,136]

theorem envBound6595 : H12AffineFastState.Bounded env6595 := by
  intro p hp
  have h : env6595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6594_6595 : H12AffineEnvironment.transform 13 1296 env6594 = env6595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env6594 == env6595) = true)

theorem identity6595 : scanCanonicalize (H12AffineFastState.compose env6595 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6595 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6596 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1025,32768,1296,4194304,16,98564,128,16,4456709,1296,1297,4294794,1284,4294967296,257,4299260334,1296,136]

theorem envBound6596 : H12AffineFastState.Bounded env6596 := by
  intro p hp
  have h : env6596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6595_6596 : H12AffineEnvironment.transform 8 137 env6595 = env6596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6595 == env6596) = true)

theorem identity6596 : scanCanonicalize (H12AffineFastState.compose env6596 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 98566) := by decide +kernel

theorem selectedBound6596 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6597 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1025,32768,1296,98566,16,98564,128,16,360451,1296,1297,2444,1284,4294967296,257,4294967464,1296,136]

theorem envBound6597 : H12AffineFastState.Bounded env6597 := by
  intro p hp
  have h : env6597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6596_6597 : H12AffineEnvironment.transform 21 98566 env6596 = env6597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 98566 env6596 == env6597) = true)

theorem identity6597 : scanCanonicalize (H12AffineFastState.compose env6597 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 68014) := by decide +kernel

theorem selectedBound6597 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6598 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,68014,1025,32768,1296,98566,16,98564,128,16,35245,1296,1297,2444,1284,4294967296,257,4294967464,1296,136]

theorem envBound6598 : H12AffineFastState.Bounded env6598 := by
  intro p hp
  have h : env6598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6597_6598 : H12AffineEnvironment.transform 17 68014 env6597 = env6598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 68014 env6597 == env6598) = true)

theorem identity6598 : scanCanonicalize (H12AffineFastState.compose env6598 (packedSelected [3] rootPS)) = affineNative (2^(31+1) ^^^ 100615) := by decide +kernel

theorem selectedBound6598 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6599 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,68014,1025,32768,1296,98566,16,98564,128,16,35245,1296,1297,2444,1284,100615,257,100783,1296,136]

theorem envBound6599 : H12AffineFastState.Bounded env6599 := by
  intro p hp
  have h : env6599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6598_6599 : H12AffineEnvironment.transform 31 100615 env6598 = env6599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 100615 env6598 == env6599) = true)

theorem identity6599 : scanCanonicalize (H12AffineFastState.compose env6599 (packedSelected [1,10] rootPS)) = affineNative (2^(15+1) ^^^ 32907) := by decide +kernel

theorem selectedBound6599 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6600 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,32907,1296,35109,1025,32768,1296,397,16,399,128,16,35245,1296,1297,2444,1284,2444,257,2340,1296,136]

theorem envBound6600 : H12AffineFastState.Bounded env6600 := by
  intro p hp
  have h : env6600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6599_6600 : H12AffineEnvironment.transform 15 32907 env6599 = env6600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32907 env6599 == env6600) = true)

theorem identity6600 : scanCanonicalize (H12AffineFastState.compose env6600 (packedSelected [6] rootPS)) = affineNative (2^(14+1) ^^^ 271) := by decide +kernel

theorem selectedBound6600 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6601 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,271,388,1296,2090,1025,271,1296,397,16,399,128,16,2210,1296,1297,2444,1284,2444,257,2340,1296,136]

theorem envBound6601 : H12AffineFastState.Bounded env6601 := by
  intro p hp
  have h : env6601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6600_6601 : H12AffineEnvironment.transform 14 271 env6600 = env6601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 271 env6600 == env6601) = true)

theorem identity6601 : scanCanonicalize (H12AffineFastState.compose env6601 (packedSelected [12] rootPS)) = affineNative (2^(10+1) ^^^ 303) := by decide +kernel

theorem selectedBound6601 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env6602 : List Nat := [2,4,8,16,32,17,128,256,137,1024,303,1296,9,1296,271,388,1296,261,1025,271,1296,397,16,399,128,16,397,1296,1297,163,1284,163,257,11,1296,136]

theorem envBound6602 : H12AffineFastState.Bounded env6602 := by
  intro p hp
  have h : env6602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6601_6602 : H12AffineEnvironment.transform 10 303 env6601 = env6602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 303 env6601 == env6602) = true)

theorem identity6602 : scanCanonicalize (H12AffineFastState.compose env6602 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 140) := by decide +kernel

end H12GlobalChart2