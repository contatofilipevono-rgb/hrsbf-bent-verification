import H12GlobalChart2Data005

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound1432 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1433 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1296,8461,8323,1296,8461,1025,8461,1297,48,16,139,8329,16,8249,1296,1296,2357,1285,162,256,178,1296,137]

theorem envBound1433 : H12AffineFastState.Bounded env1433 := by
  intro p hp
  have h : env1433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1432_1433 : H12AffineEnvironment.transform 31 162 env1432 = env1433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 162 env1432 == env1433) = true)

theorem identity1433 : scanCanonicalize (H12AffineFastState.compose env1433 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound1433 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1434 : List Nat := [2,4,8,16,32,17,128,53,136,1024,2048,1060,8192,1061,8248,8323,1061,8248,1025,8248,1060,48,16,139,8329,16,8249,1061,1061,2048,1072,162,53,178,1061,137]

theorem envBound1434 : H12AffineFastState.Bounded env1434 := by
  intro p hp
  have h : env1434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1433_1434 : H12AffineEnvironment.transform 7 53 env1433 = env1434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env1433 == env1434) = true)

theorem identity1434 : scanCanonicalize (H12AffineFastState.compose env1434 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 2089) := by decide +kernel

theorem selectedBound1434 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1435 : List Nat := [2,4,8,16,32,17,128,53,136,1024,2048,1060,2089,1061,2065,2218,1061,2065,1025,2065,1060,48,16,139,2208,16,2064,1061,1061,2048,1072,162,53,178,1061,137]

theorem envBound1435 : H12AffineFastState.Bounded env1435 := by
  intro p hp
  have h : env1435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1434_1435 : H12AffineEnvironment.transform 12 2089 env1434 = env1435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2089 env1434 == env1435) = true)

def env1436 : List Nat := [2,4,8,0,32,1,128,37,136,1024,2048,1060,2089,1061,2049,2218,1061,2049,1025,2049,1060,32,0,139,2208,0,2048,1061,1061,2048,1056,162,37,162,1061,137]

theorem envBound1436 : H12AffineFastState.Bounded env1436 := by
  intro p hp
  have h : env1436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1435_1436 : H12AffineEnvironment.transform 3 0 env1435 = env1436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1435 == env1436) = true)

theorem identity1436 : scanCanonicalize (H12AffineFastState.compose env1436 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1436 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1437 : List Nat := [2,4,8,0,32,1,2,37,10,1024,2048,1060,2089,1061,2049,2088,1061,2049,1025,2049,1060,32,0,9,2082,0,2048,1061,1061,2048,1056,32,37,32,1061,11]

theorem envBound1437 : H12AffineFastState.Bounded env1437 := by
  intro p hp
  have h : env1437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1436_1437 : H12AffineEnvironment.transform 6 2 env1436 = env1437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1436 == env1437) = true)

def leafEnv1437 : List Nat := [2,4,8,0,32,1,2,37,10,1024,2048,1060,2089,1061,2049,2088,1061,2049,1025,2049,1060,32,0,9,1057,2082,1,0,2048,1061,1061,2048,1056,32,37,32,4,2082,1061,11,0,1061,1]

def active1437 : List Nat := [0,1,2,4,9,10]

def tree1437 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1437 : H12WitnessSearch.Good tree1437 := H12GlobalWitnessIndex.good

theorem leafIdentity1437 : H12AffineFastState.composeSystem env1437 rootObs = leafEnv1437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1437 rootObs == leafEnv1437) = true)

theorem terminalChecked1437 : H12PackedTerminal.terminalCheckFast leafEnv1437 active1437 tree1437 = true := by decide +kernel

def env1438 : List Nat := [2,4,8,1,32,0,128,36,136,1024,2048,1060,2089,1061,2048,2218,1061,2048,1025,2048,1060,33,1,139,2208,1,2049,1061,1061,2048,1057,162,36,163,1061,137]

theorem envBound1438 : H12AffineFastState.Bounded env1438 := by
  intro p hp
  have h : env1438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1435_1438 : H12AffineEnvironment.transform 3 1 env1435 = env1438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1435 == env1438) = true)

def leafEnv1438 : List Nat := [2,4,8,1,32,0,128,36,136,1024,2048,1060,2089,1061,2048,2218,1061,2048,1025,2048,1060,33,1,139,1056,2208,1,1,2049,1061,1061,2048,1057,162,36,163,4,2082,1061,137,0,1061,1]

def active1438 : List Nat := [0,1,2,4,6,9,10]

def tree1438 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1438 : H12WitnessSearch.Good tree1438 := H12GlobalWitnessIndex.good

theorem leafIdentity1438 : H12AffineFastState.composeSystem env1438 rootObs = leafEnv1438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1438 rootObs == leafEnv1438) = true)

theorem terminalChecked1438 : H12PackedTerminal.terminalCheckFast leafEnv1438 active1438 tree1438 = true := by decide +kernel

def env1439 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,157794305,1073741824,140788816,4294967296,157663568,4417151346,131073,33563272]

theorem envBound1439 : H12AffineFastState.Bounded env1439 := by
  intro p hp
  have h : env1439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans882_1439 : H12AffineEnvironment.transform 28 157794305 env882 = env1439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env882 == env1439) = true)

theorem identity1439 : scanCanonicalize (H12AffineFastState.compose env1439 (packedSelected [14] rootPS)) = affineNative (2^(25+1) ^^^ 19104069) := by decide +kernel

theorem selectedBound1439 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env1440 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,19104069,134217728,19125316,157794305,1073741824,140788816,4294967296,157663568,4335591479,131073,33563272]

theorem envBound1440 : H12AffineFastState.Bounded env1440 := by
  intro p hp
  have h : env1440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1439_1440 : H12AffineEnvironment.transform 25 19104069 env1439 = env1440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 19104069 env1439 == env1440) = true)

def env1441 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,19104069,21352528,19125316,2232401,1073741824,18977792,4294967296,2101504,4335591479,131073,33563272]

theorem envBound1441 : H12AffineFastState.Bounded env1441 := by
  intro p hp
  have h : env1441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1440_1441 : H12AffineEnvironment.transform 26 21352528 env1440 = env1441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352528 env1440 == env1441) = true)

theorem identity1441 : scanCanonicalize (H12AffineFastState.compose env1441 (packedSelected [35] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound1441 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env1442 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024068,131153,1073741824,16876544,4294967296,256,4333498423,131073,33563272]

theorem envBound1442 : H12AffineFastState.Bounded env1442 := by
  intro p hp
  have h : env1442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1441_1442 : H12AffineEnvironment.transform 20 4096 env1441 = env1442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env1441 == env1442) = true)

def env1443 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024068,131153,1073741824,16876544,4294967296,256,4332975159,131073,33563272]

theorem envBound1443 : H12AffineFastState.Bounded env1443 := by
  intro p hp
  have h : env1443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1442_1443 : H12AffineEnvironment.transform 18 1024 env1442 = env1443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env1442 == env1443) = true)

theorem identity1443 : scanCanonicalize (H12AffineFastState.compose env1443 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21105871) := by decide +kernel

theorem selectedBound1443 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env1444 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024068,131153,21105871,16876544,4294967296,256,4332975159,131073,33563272]

theorem envBound1444 : H12AffineFastState.Bounded env1444 := by
  intro p hp
  have h : env1444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1443_1444 : H12AffineEnvironment.transform 29 21105871 env1443 = env1444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21105871 env1443 == env1444) = true)

def env1445 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010965,21352448,17024020,131073,21105823,16876544,4294967296,256,4332975159,131073,33563272]

theorem envBound1445 : H12AffineFastState.Bounded env1445 := by
  intro p hp
  have h : env1445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1444_1445 : H12AffineEnvironment.transform 5 16 env1444 = env1445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1444 == env1445) = true)

def env1446 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010965,21352448,17024020,131073,21105823,16876544,4294967296,256,4332967607,131073,33554440]

theorem envBound1446 : H12AffineFastState.Bounded env1446 := by
  intro p hp
  have h : env1446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1445_1446 : H12AffineEnvironment.transform 12 640 env1445 = env1446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env1445 == env1446) = true)

def env1447 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897044,4097,20978847,16876544,4294967296,256,4332832439,4097,33554440]

theorem envBound1447 : H12AffineFastState.Bounded env1447 := by
  intro p hp
  have h : env1447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1446_1447 : H12AffineEnvironment.transform 16 4096 env1446 = env1447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1446 == env1447) = true)

theorem identity1447 : scanCanonicalize (H12AffineFastState.compose env1447 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16896389) := by decide +kernel

theorem selectedBound1447 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1448 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,16896389,16875797,21352448,16897044,4097,20978847,16876544,4294967296,256,4315944754,4097,16896397]

theorem envBound1448 : H12AffineFastState.Bounded env1448 := by
  intro p hp
  have h : env1448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1447_1448 : H12AffineEnvironment.transform 24 16896389 env1447 = env1448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16896389 env1447 == env1448) = true)

def env1449 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,16896389,16875797,21352448,16897044,4097,20978847,16876544,4294967296,256,4315944378,4097,16896397]

theorem envBound1449 : H12AffineFastState.Bounded env1449 := by
  intro p hp
  have h : env1449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1448_1449 : H12AffineEnvironment.transform 8 136 env1448 = env1449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1448 == env1449) = true)

theorem identity1449 : scanCanonicalize (H12AffineFastState.compose env1449 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1449 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1450 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,16777216,16880788,16875797,21337361,16879877,4097,20978847,16876544,4294967296,256,4315944378,4097,16880796]

theorem envBound1450 : H12AffineFastState.Bounded env1450 := by
  intro p hp
  have h : env1450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1449_1450 : H12AffineEnvironment.transform 13 1297 env1449 = env1450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env1449 == env1450) = true)

theorem identity1450 : scanCanonicalize (H12AffineFastState.compose env1450 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(23+1) ^^^ 103445) := by decide +kernel

theorem selectedBound1450 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1451 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,103445,129,5376,4456708,1296,4097,4294794,4117,4294967296,256,4299260335,4097,137]

theorem envBound1451 : H12AffineFastState.Bounded env1451 := by
  intro p hp
  have h : env1451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1450_1451 : H12AffineEnvironment.transform 23 103445 env1450 = env1451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103445 env1450 == env1451) = true)

theorem identity1451 : scanCanonicalize (H12AffineFastState.compose env1451 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound1451 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env1452 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,65536,4096,262144,1024,261,4096,4194304,17,70928,129,5376,4456708,1296,4097,4262287,4117,4294967296,256,4299227306,4097,137]

theorem envBound1452 : H12AffineFastState.Bounded env1452 := by
  intro p hp
  have h : env1452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1451_1452 : H12AffineEnvironment.transform 14 261 env1451 = env1452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env1451 == env1452) = true)

theorem identity1452 : scanCanonicalize (H12AffineFastState.compose env1452 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4527536) := by decide +kernel

theorem selectedBound1452 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1453 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,65536,4096,262144,1024,261,4096,4194304,17,70928,129,5376,4456708,1296,4097,4262287,4117,4527536,256,267546,4097,137]

theorem envBound1453 : H12AffineFastState.Bounded env1453 := by
  intro p hp
  have h : env1453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1452_1453 : H12AffineEnvironment.transform 31 4527536 env1452 = env1453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4527536 env1452 == env1453) = true)

theorem identity1453 : scanCanonicalize (H12AffineFastState.compose env1453 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound1453 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1454 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,262144,1024,261,4096,4194304,17,5530,129,5376,4456708,1296,4097,4196613,4117,4461882,256,267546,4097,137]

theorem envBound1454 : H12AffineFastState.Bounded env1454 := by
  intro p hp
  have h : env1454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1453_1454 : H12AffineEnvironment.transform 15 138 env1453 = env1454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env1453 == env1454) = true)

theorem identity1454 : scanCanonicalize (H12AffineFastState.compose env1454 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound1454 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env1455 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,7220,1024,261,4096,4194304,17,5530,129,5376,4201776,1296,4097,4196613,4117,4196622,256,2350,4097,137]

theorem envBound1455 : H12AffineFastState.Bounded env1455 := by
  intro p hp
  have h : env1455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1454_1455 : H12AffineEnvironment.transform 17 7220 env1454 = env1455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env1454 == env1455) = true)

def env1456 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,7220,1024,261,4096,5408,17,5530,129,5376,2064,1296,4097,7205,4117,7214,256,2350,4097,137]

theorem envBound1456 : H12AffineFastState.Bounded env1456 := by
  intro p hp
  have h : env1456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1455_1456 : H12AffineEnvironment.transform 21 5408 env1455 = env1456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1455 == env1456) = true)

theorem identity1456 : scanCanonicalize (H12AffineFastState.compose env1456 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 1427) := by decide +kernel

theorem selectedBound1456 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1457 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1427,8,1297,261,138,1427,2471,1024,261,1427,179,17,9,129,147,2064,1296,1426,2486,1414,2493,256,2350,1426,137]

theorem envBound1457 : H12AffineFastState.Bounded env1457 := by
  intro p hp
  have h : env1457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1456_1457 : H12AffineEnvironment.transform 11 1427 env1456 = env1457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1427 env1456 == env1457) = true)

theorem identity1457 : scanCanonicalize (H12AffineFastState.compose env1457 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 27) := by decide +kernel

theorem selectedBound1457 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1458 : List Nat := [2,4,8,16,32,16,128,256,136,1024,27,1427,8,1297,261,138,1427,444,1024,261,1427,179,17,9,129,147,11,1296,1426,429,1414,422,256,309,1426,137]

theorem envBound1458 : H12AffineFastState.Bounded env1458 := by
  intro p hp
  have h : env1458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1457_1458 : H12AffineEnvironment.transform 10 27 env1457 = env1458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 27 env1457 == env1458) = true)

def env1459 : List Nat := [2,4,8,16,32,16,128,20,136,1024,27,1159,8,1029,17,138,1159,168,1024,17,1159,179,17,9,129,147,11,1028,1158,185,1170,178,20,33,1158,137]

theorem envBound1459 : H12AffineFastState.Bounded env1459 := by
  intro p hp
  have h : env1459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1458_1459 : H12AffineEnvironment.transform 7 20 env1458 = env1459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1458 == env1459) = true)

theorem identity1459 : scanCanonicalize (H12AffineFastState.compose env1459 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1459 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1460 : List Nat := [2,4,8,16,32,16,35,20,43,1024,27,1060,8,1029,17,41,1060,11,1024,17,1060,16,17,9,34,48,11,1028,1061,26,1073,17,20,33,1061,42]

theorem envBound1460 : H12AffineFastState.Bounded env1460 := by
  intro p hp
  have h : env1460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1459_1460 : H12AffineEnvironment.transform 6 35 env1459 = env1460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1459 == env1460) = true)

theorem identity1460 : scanCanonicalize (H12AffineFastState.compose env1460 (packedSelected [0,2,5] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1460 : packedSelected [0,2,5] rootPS < 2^1333 := by decide +kernel

def env1461 : List Nat := [2,4,2,16,32,16,35,20,33,1024,17,1060,2,1029,17,35,1060,1,1024,17,1060,16,17,3,34,48,1,1028,1061,16,1073,17,20,33,1061,32]

theorem envBound1461 : H12AffineFastState.Bounded env1461 := by
  intro p hp
  have h : env1461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1460_1461 : H12AffineEnvironment.transform 2 2 env1460 = env1461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1460 == env1461) = true)

theorem identity1461 : scanCanonicalize (H12AffineFastState.compose env1461 (packedSelected [0,2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound1461 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1462 : List Nat := [2,4,2,16,1,16,2,20,0,1024,17,1029,2,1029,17,2,1029,1,1024,17,1029,16,17,3,3,17,1,1028,1028,16,1040,17,20,0,1028,1]

theorem envBound1462 : H12AffineFastState.Bounded env1462 := by
  intro p hp
  have h : env1462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1461_1462 : H12AffineEnvironment.transform 4 1 env1461 = env1462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1461 == env1462) = true)

theorem identity1462 : scanCanonicalize (H12AffineFastState.compose env1462 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1462 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1463 : List Nat := [2,4,2,0,1,0,2,4,0,1024,1,1029,2,1029,1,2,1029,1,1024,1,1029,0,1,3,3,1,1,1028,1028,0,1024,1,4,0,1028,1]

theorem envBound1463 : H12AffineFastState.Bounded env1463 := by
  intro p hp
  have h : env1463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1462_1463 : H12AffineEnvironment.transform 3 0 env1462 = env1463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1462 == env1463) = true)

def env1464 : List Nat := [2,4,8,16,32,16,128,21,136,1024,27,1158,8,1028,16,138,1158,169,1024,16,1158,179,17,9,129,147,11,1029,1159,184,1171,179,21,32,1159,137]

theorem envBound1464 : H12AffineFastState.Bounded env1464 := by
  intro p hp
  have h : env1464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1458_1464 : H12AffineEnvironment.transform 7 21 env1458 = env1464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1458 == env1464) = true)

theorem identity1464 : scanCanonicalize (H12AffineFastState.compose env1464 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1464 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1465 : List Nat := [2,4,8,16,0,16,128,21,136,1024,27,1158,8,1028,16,138,1158,137,1024,16,1158,147,17,9,129,147,11,1029,1159,152,1171,147,21,0,1159,137]

theorem envBound1465 : H12AffineFastState.Bounded env1465 := by
  intro p hp
  have h : env1465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1464_1465 : H12AffineEnvironment.transform 4 0 env1464 = env1465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1464 == env1465) = true)

theorem identity1465 : scanCanonicalize (H12AffineFastState.compose env1465 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1465 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1466 : List Nat := [2,4,8,10,0,10,128,15,136,1024,1,1158,8,1028,10,138,1158,137,1024,10,1158,137,11,9,129,137,11,1029,1159,130,1161,137,15,0,1159,137]

theorem envBound1466 : H12AffineFastState.Bounded env1466 := by
  intro p hp
  have h : env1466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1465_1466 : H12AffineEnvironment.transform 3 10 env1465 = env1466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1465 == env1466) = true)

theorem identity1466 : scanCanonicalize (H12AffineFastState.compose env1466 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1466 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1467 : List Nat := [2,4,8,10,0,10,2,15,10,1024,1,1028,8,1028,10,8,1028,11,1024,10,1028,11,11,9,3,11,11,1029,1029,0,1035,11,15,0,1029,11]

theorem envBound1467 : H12AffineFastState.Bounded env1467 := by
  intro p hp
  have h : env1467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1466_1467 : H12AffineEnvironment.transform 6 2 env1466 = env1467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1466 == env1467) = true)

theorem identity1467 : scanCanonicalize (H12AffineFastState.compose env1467 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1467 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1468 : List Nat := [2,4,2,0,0,0,2,5,0,1024,1,1028,2,1028,0,2,1028,1,1024,0,1028,1,1,3,3,1,1,1029,1029,0,1025,1,5,0,1029,1]

theorem envBound1468 : H12AffineFastState.Bounded env1468 := by
  intro p hp
  have h : env1468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1467_1468 : H12AffineEnvironment.transform 2 2 env1467 = env1468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1467 == env1468) = true)

def env1469 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,7220,1024,261,4096,5409,17,5530,129,5376,2065,1296,4097,7204,4117,7215,256,2350,4097,137]

theorem envBound1469 : H12AffineFastState.Bounded env1469 := by
  intro p hp
  have h : env1469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1455_1469 : H12AffineEnvironment.transform 21 5409 env1455 = env1469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1455 == env1469) = true)

theorem identity1469 : scanCanonicalize (H12AffineFastState.compose env1469 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1469 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1470 : List Nat := [2,4,8,16,32,16,3,256,11,1024,2048,4096,8,1297,261,9,4096,7220,1024,261,4096,5409,17,5401,2,5376,2065,1296,4097,7204,4117,7215,256,2350,4097,10]

theorem envBound1470 : H12AffineFastState.Bounded env1470 := by
  intro p hp
  have h : env1470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1469_1470 : H12AffineEnvironment.transform 6 3 env1469 = env1470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1469 == env1470) = true)

theorem identity1470 : scanCanonicalize (H12AffineFastState.compose env1470 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound1470 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1471 : List Nat := [2,4,8,16,32,16,3,256,11,1024,26,4096,8,1297,261,9,4096,5166,1024,261,4096,5409,17,5401,2,5376,11,1296,4097,5182,4117,5173,256,308,4097,10]

theorem envBound1471 : H12AffineFastState.Bounded env1471 := by
  intro p hp
  have h : env1471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1470_1471 : H12AffineEnvironment.transform 10 26 env1470 = env1471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env1470 == env1471) = true)

def env1472 : List Nat := [2,4,8,16,32,16,3,256,11,1024,26,1296,8,1297,261,9,1296,318,1024,261,1296,49,17,9,2,16,11,1296,1297,302,1285,293,256,308,1297,10]

theorem envBound1472 : H12AffineFastState.Bounded env1472 := by
  intro p hp
  have h : env1472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1471_1472 : H12AffineEnvironment.transform 11 1296 env1471 = env1472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1471 == env1472) = true)

theorem identity1472 : scanCanonicalize (H12AffineFastState.compose env1472 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1472 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1473 : List Nat := [2,4,8,16,0,16,3,256,11,1024,26,1296,8,1297,261,9,1296,286,1024,261,1296,17,17,9,2,16,11,1296,1297,270,1285,261,256,276,1297,10]

theorem envBound1473 : H12AffineFastState.Bounded env1473 := by
  intro p hp
  have h : env1473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1472_1473 : H12AffineEnvironment.transform 4 0 env1472 = env1473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1472 == env1473) = true)

theorem identity1473 : scanCanonicalize (H12AffineFastState.compose env1473 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 30) := by decide +kernel

theorem selectedBound1473 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1474 : List Nat := [2,4,8,16,0,16,3,30,11,1024,26,1038,8,1039,27,9,1038,0,1024,27,1038,17,17,9,2,16,11,1038,1039,16,1051,27,30,10,1039,10]

theorem envBound1474 : H12AffineFastState.Bounded env1474 := by
  intro p hp
  have h : env1474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1473_1474 : H12AffineEnvironment.transform 7 30 env1473 = env1474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 30 env1473 == env1474) = true)

theorem identity1474 : scanCanonicalize (H12AffineFastState.compose env1474 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1474 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1475 : List Nat := [2,4,8,0,0,0,3,14,11,1024,10,1038,8,1039,11,9,1038,0,1024,11,1038,1,1,9,2,0,11,1038,1039,0,1035,11,14,10,1039,10]

theorem envBound1475 : H12AffineFastState.Bounded env1475 := by
  intro p hp
  have h : env1475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1474_1475 : H12AffineEnvironment.transform 3 0 env1474 = env1475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1474 == env1475) = true)

theorem identity1475 : scanCanonicalize (H12AffineFastState.compose env1475 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1475 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1476 : List Nat := [2,4,3,0,0,0,3,5,0,1024,1,1029,3,1028,0,2,1029,0,1024,0,1029,1,1,2,2,0,0,1029,1028,0,1024,0,5,1,1028,1]

theorem envBound1476 : H12AffineFastState.Bounded env1476 := by
  intro p hp
  have h : env1476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1475_1476 : H12AffineEnvironment.transform 2 3 env1475 = env1476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1475 == env1476) = true)

def leafEnv1476 : List Nat := [2,4,3,0,0,0,3,5,0,1024,1,1029,3,1028,0,2,1029,0,1024,0,1029,1,1,2,1024,2,1,0,0,1029,1028,0,1024,0,5,1,4,3,1028,1,0,1028,1]

def active1476 : List Nat := [0,1,9]

def tree1476 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1476 : H12WitnessSearch.Good tree1476 := H12GlobalWitnessIndex.good

theorem leafIdentity1476 : H12AffineFastState.composeSystem env1476 rootObs = leafEnv1476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1476 rootObs == leafEnv1476) = true)

theorem terminalChecked1476 : H12PackedTerminal.terminalCheckFast leafEnv1476 active1476 tree1476 = true := by decide +kernel

def env1477 : List Nat := [2,4,8,16,32,16,3,256,11,1024,26,1297,8,1297,261,9,1297,319,1024,261,1297,48,17,8,2,17,11,1296,1296,303,1284,292,256,308,1296,10]

theorem envBound1477 : H12AffineFastState.Bounded env1477 := by
  intro p hp
  have h : env1477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1471_1477 : H12AffineEnvironment.transform 11 1297 env1471 = env1477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1471 == env1477) = true)

theorem identity1477 : scanCanonicalize (H12AffineFastState.compose env1477 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound1477 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1478 : List Nat := [2,4,8,16,32,16,3,52,11,1024,26,1061,8,1061,49,9,1061,11,1024,49,1061,48,17,8,2,17,11,1060,1060,27,1072,16,52,0,1060,10]

theorem envBound1478 : H12AffineFastState.Bounded env1478 := by
  intro p hp
  have h : env1478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1477_1478 : H12AffineEnvironment.transform 7 52 env1477 = env1478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env1477 == env1478) = true)

theorem identity1478 : scanCanonicalize (H12AffineFastState.compose env1478 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound1478 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1479 : List Nat := [2,4,8,16,10,16,3,30,11,1024,26,1039,8,1039,27,9,1039,11,1024,27,1039,26,17,8,2,17,11,1038,1038,27,1050,16,30,0,1038,10]

theorem envBound1479 : H12AffineFastState.Bounded env1479 := by
  intro p hp
  have h : env1479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1478_1479 : H12AffineEnvironment.transform 4 10 env1478 = env1479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env1478 == env1479) = true)

theorem identity1479 : scanCanonicalize (H12AffineFastState.compose env1479 (packedSelected [10] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1479 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1480 : List Nat := [2,4,8,0,10,0,3,14,11,1024,10,1039,8,1039,11,9,1039,11,1024,11,1039,10,1,8,2,1,11,1038,1038,11,1034,0,14,0,1038,10]

theorem envBound1480 : H12AffineFastState.Bounded env1480 := by
  intro p hp
  have h : env1480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1479_1480 : H12AffineEnvironment.transform 3 0 env1479 = env1480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1479 == env1480) = true)

def env1481 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,16896389,16875797,21352448,16897044,4097,20978847,16876544,4294967296,256,4315944379,4097,16896397]

theorem envBound1481 : H12AffineFastState.Bounded env1481 := by
  intro p hp
  have h : env1481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1448_1481 : H12AffineEnvironment.transform 8 137 env1448 = env1481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1448 == env1481) = true)

theorem identity1481 : scanCanonicalize (H12AffineFastState.compose env1481 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(23+1) ^^^ 103445) := by decide +kernel

theorem selectedBound1481 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1482 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,103445,17808,5376,4473877,16385,4097,4294794,4117,4294967296,256,4299260334,4097,17816]

theorem envBound1482 : H12AffineFastState.Bounded env1482 := by
  intro p hp
  have h : env1482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1481_1482 : H12AffineEnvironment.transform 23 103445 env1481 = env1482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103445 env1481 == env1482) = true)

theorem identity1482 : scanCanonicalize (H12AffineFastState.compose env1482 (packedSelected [0,1,3,4,7,9,10,16,17,19,20,21] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound1482 : packedSelected [0,1,3,4,7,9,10,16,17,19,20,21] rootPS < 2^1333 := by decide +kernel

def env1483 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,103445,5520,5376,4461589,4097,4097,4294794,4117,4294967296,256,4299260334,4097,5528]

theorem envBound1483 : H12AffineFastState.Bounded env1483 := by
  intro p hp
  have h : env1483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1482_1483 : H12AffineEnvironment.transform 13 4096 env1482 = env1483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1482 == env1483) = true)

theorem identity1483 : scanCanonicalize (H12AffineFastState.compose env1483 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound1483 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env1484 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4096,32768,33166,4096,262144,1024,32768,4096,4194304,5376,5531,5520,5376,4461589,4097,4097,4196612,4117,4294967296,256,4299161632,4097,5528]

theorem envBound1484 : H12AffineFastState.Bounded env1484 := by
  intro p hp
  have h : env1484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1483_1484 : H12AffineEnvironment.transform 15 33166 env1483 = env1484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env1483 == env1484) = true)

theorem identity1484 : scanCanonicalize (H12AffineFastState.compose env1484 (packedSelected [0,1,3,4,7,9,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound1484 : packedSelected [0,1,3,4,7,9,12,15] rootPS < 2^1333 := by decide +kernel

def env1485 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4096,32768,33166,4096,34849,1024,32768,4096,4194304,5376,5531,5520,5376,4234292,4097,4097,4196612,4117,4294967296,256,4299161632,4097,5528]

theorem envBound1485 : H12AffineFastState.Bounded env1485 := by
  intro p hp
  have h : env1485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1484_1485 : H12AffineEnvironment.transform 17 34849 env1484 = env1485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env1484 == env1485) = true)

theorem identity1485 : scanCanonicalize (H12AffineFastState.compose env1485 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 3092) := by decide +kernel

theorem selectedBound1485 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env1486 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,3092,9,3092,32768,33166,3092,34849,1024,32768,3092,4194304,2324,2447,2436,2324,4227104,3093,3093,4196612,3073,4294967296,256,4299161632,3093,2444]

theorem envBound1486 : H12AffineFastState.Bounded env1486 := by
  intro p hp
  have h : env1486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1485_1486 : H12AffineEnvironment.transform 11 3092 env1485 = env1486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3092 env1485 == env1486) = true)

theorem identity1486 : scanCanonicalize (H12AffineFastState.compose env1486 (packedSelected [0,2,4,6,8,11] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound1486 : packedSelected [0,2,4,6,8,11] rootPS < 2^1333 := by decide +kernel

def env1487 : List Nat := [2,4,8,16,32,16,128,256,137,1024,261,1297,9,1297,32768,33166,1297,33060,1024,32768,1297,4194304,17,138,129,17,4227104,1296,1296,4194305,1284,4294967296,256,4299161632,1296,137]

theorem envBound1487 : H12AffineFastState.Bounded env1487 := by
  intro p hp
  have h : env1487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1486_1487 : H12AffineEnvironment.transform 10 261 env1486 = env1487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env1486 == env1487) = true)

theorem identity1487 : scanCanonicalize (H12AffineFastState.compose env1487 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 32930) := by decide +kernel

theorem selectedBound1487 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1488 : List Nat := [2,4,8,16,32,16,128,256,137,1024,261,1297,9,1297,32768,33166,1297,33060,1024,32768,1297,32930,17,138,129,17,130,1296,1296,32931,1284,4294967296,256,4295000194,1296,137]

theorem envBound1488 : H12AffineFastState.Bounded env1488 := by
  intro p hp
  have h : env1488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1487_1488 : H12AffineEnvironment.transform 21 32930 env1487 = env1488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32930 env1487 == env1488) = true)

theorem identity1488 : scanCanonicalize (H12AffineFastState.compose env1488 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1488 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1489 : List Nat := [2,4,8,16,32,16,35,256,42,1024,261,1297,9,1297,32768,33069,1297,33060,1024,32768,1297,32769,17,41,34,17,33,1296,1296,32768,1284,4294967296,256,4295000097,1296,42]

theorem envBound1489 : H12AffineFastState.Bounded env1489 := by
  intro p hp
  have h : env1489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1488_1489 : H12AffineEnvironment.transform 6 35 env1488 = env1489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1488 == env1489) = true)

theorem identity1489 : scanCanonicalize (H12AffineFastState.compose env1489 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound1489 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1490 : List Nat := [2,4,8,16,11,16,8,256,1,1024,261,1297,9,1297,32768,33030,1297,33039,1024,32768,1297,32769,17,2,9,17,10,1296,1296,32768,1284,4294967296,256,4295000074,1296,1]

theorem envBound1490 : H12AffineFastState.Bounded env1490 := by
  intro p hp
  have h : env1490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1489_1490 : H12AffineEnvironment.transform 4 11 env1489 = env1490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env1489 == env1490) = true)

theorem identity1490 : scanCanonicalize (H12AffineFastState.compose env1490 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 33047) := by decide +kernel

theorem selectedBound1490 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1491 : List Nat := [2,4,8,16,11,16,8,256,1,1024,261,1297,9,1297,32768,33030,1297,33039,1024,32768,1297,32769,17,2,9,17,10,1296,1296,32768,1284,33047,256,285,1296,1]

theorem envBound1491 : H12AffineFastState.Bounded env1491 := by
  intro p hp
  have h : env1491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1490_1491 : H12AffineEnvironment.transform 31 33047 env1490 = env1491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 33047 env1490 == env1491) = true)

theorem identity1491 : scanCanonicalize (H12AffineFastState.compose env1491 (packedSelected [6] rootPS)) = affineNative (2^(14+1) ^^^ 25) := by decide +kernel

theorem selectedBound1491 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1492 : List Nat := [2,4,8,16,11,16,8,256,1,1024,261,1297,9,1297,25,287,1297,278,1024,25,1297,24,17,2,9,17,10,1296,1296,25,1284,270,256,285,1296,1]

theorem envBound1492 : H12AffineFastState.Bounded env1492 := by
  intro p hp
  have h : env1492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1491_1492 : H12AffineEnvironment.transform 14 25 env1491 = env1492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 25 env1491 == env1492) = true)

def env1493 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897045,4096,20978846,16876544,4294967296,256,4332832438,4096,33554440]

theorem envBound1493 : H12AffineFastState.Bounded env1493 := by
  intro p hp
  have h : env1493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1446_1493 : H12AffineEnvironment.transform 16 4097 env1446 = env1493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1446 == env1493) = true)

theorem identity1493 : scanCanonicalize (H12AffineFastState.compose env1493 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16893076) := by decide +kernel

theorem selectedBound1493 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1494 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,16893076,16875796,21352448,16897045,4096,20978846,16876544,4294967296,256,4315939362,4096,16893084]

theorem envBound1494 : H12AffineFastState.Bounded env1494 := by
  intro p hp
  have h : env1494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1493_1494 : H12AffineEnvironment.transform 24 16893076 env1493 = env1494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16893076 env1493 == env1494) = true)

def env1495 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,16893076,16875796,21352448,16897045,4096,20978846,16876544,4294967296,256,4315938986,4096,16893084]

theorem envBound1495 : H12AffineFastState.Bounded env1495 := by
  intro p hp
  have h : env1495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1494_1495 : H12AffineEnvironment.transform 8 136 env1494 = env1495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1494 == env1495) = true)

theorem identity1495 : scanCanonicalize (H12AffineFastState.compose env1495 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 119044) := by decide +kernel

theorem selectedBound1495 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1496 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,119044,5520,20496,4456708,1297,4096,4312474,21764,4294967296,256,4299280814,4096,5528]

theorem envBound1496 : H12AffineFastState.Bounded env1496 := by
  intro p hp
  have h : env1496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1495_1496 : H12AffineEnvironment.transform 23 119044 env1495 = env1496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 119044 env1495 == env1496) = true)

theorem identity1496 : scanCanonicalize (H12AffineFastState.compose env1496 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1496 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1497 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,103444,5520,5376,4456708,1297,4096,4294794,4116,4294967296,256,4299265214,4096,5528]

theorem envBound1497 : H12AffineFastState.Bounded env1497 := by
  intro p hp
  have h : env1497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1496_1497 : H12AffineEnvironment.transform 13 1296 env1496 = env1497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env1496 == env1497) = true)

theorem identity1497 : scanCanonicalize (H12AffineFastState.compose env1497 (packedSelected [4,5,8,9,13,16,17] rootPS)) = affineNative (2^(21+1) ^^^ 32904) := by decide +kernel

theorem selectedBound1497 : packedSelected [4,5,8,9,13,16,17] rootPS < 2^1333 := by decide +kernel

def env1498 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,262144,1024,32768,4096,32904,16,103444,5520,5376,295308,1297,4096,67586,4116,4294967296,256,4295038006,4096,5528]

theorem envBound1498 : H12AffineFastState.Bounded env1498 := by
  intro p hp
  have h : env1498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1497_1498 : H12AffineEnvironment.transform 21 32904 env1497 = env1498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32904 env1497 == env1498) = true)

theorem identity1498 : scanCanonicalize (H12AffineFastState.compose env1498 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound1498 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1499 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,34849,1024,32768,4096,32904,16,103444,5520,5376,2477,1297,4096,67586,4116,4294967296,256,4295038006,4096,5528]

theorem envBound1499 : H12AffineFastState.Bounded env1499 := by
  intro p hp
  have h : env1499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1498_1499 : H12AffineEnvironment.transform 17 34849 env1498 = env1499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env1498 == env1499) = true)

theorem identity1499 : scanCanonicalize (H12AffineFastState.compose env1499 (packedSelected [10,12,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1499 : packedSelected [10,12,21] rootPS < 2^1333 := by decide +kernel

def env1500 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1296,260,65536,4097,2341,1024,260,4096,396,16,70928,5520,5376,2477,1297,4096,67586,4116,4294967296,256,4295038006,4096,5528]

theorem envBound1500 : H12AffineFastState.Bounded env1500 := by
  intro p hp
  have h : env1500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1499_1500 : H12AffineEnvironment.transform 14 260 env1499 = env1500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1499 == env1500) = true)

theorem identity1500 : scanCanonicalize (H12AffineFastState.compose env1500 (packedSelected [3,12,15,24] rootPS)) = affineNative (2^(15+1) ^^^ 5530) := by decide +kernel

theorem selectedBound1500 : packedSelected [3,12,15,24] rootPS < 2^1333 := by decide +kernel

def env1501 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1296,260,5530,4097,2341,1024,260,4096,396,16,138,5520,5376,2477,1297,4096,7576,4116,4294967296,256,4294967724,4096,5528]

theorem envBound1501 : H12AffineFastState.Bounded env1501 := by
  intro p hp
  have h : env1501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1500_1501 : H12AffineEnvironment.transform 15 5530 env1500 = env1501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5530 env1500 == env1501) = true)

theorem identity1501 : scanCanonicalize (H12AffineFastState.compose env1501 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1501 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1502 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,8,1296,260,139,1296,2341,1024,260,1297,396,16,138,129,17,2477,1297,1297,2185,1285,4294967296,256,4294967724,1297,137]

theorem envBound1502 : H12AffineFastState.Bounded env1502 := by
  intro p hp
  have h : env1502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1501_1502 : H12AffineEnvironment.transform 11 1297 env1501 = env1502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1501 == env1502) = true)

theorem identity1502 : scanCanonicalize (H12AffineFastState.compose env1502 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 33) := by decide +kernel

theorem selectedBound1502 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1503 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,8,1296,260,139,1296,2341,1024,260,1297,396,16,138,129,17,2477,1297,1297,2185,1285,33,256,397,1297,137]

theorem envBound1503 : H12AffineFastState.Bounded env1503 := by
  intro p hp
  have h : env1503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1502_1503 : H12AffineEnvironment.transform 31 33 env1502 = env1503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 33 env1502 == env1503) = true)

theorem identity1503 : scanCanonicalize (H12AffineFastState.compose env1503 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 444) := by decide +kernel

theorem selectedBound1503 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1504 : List Nat := [2,4,8,16,32,16,128,256,136,1024,444,1297,8,1296,260,139,1296,153,1024,260,1297,396,16,138,129,17,17,1297,1297,309,1285,33,256,397,1297,137]

theorem envBound1504 : H12AffineFastState.Bounded env1504 := by
  intro p hp
  have h : env1504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1503_1504 : H12AffineEnvironment.transform 10 444 env1503 = env1504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 444 env1503 == env1504) = true)

theorem identity1504 : scanCanonicalize (H12AffineFastState.compose env1504 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound1504 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1505 : List Nat := [2,4,8,16,17,16,128,256,136,1024,397,1297,8,1296,260,139,1296,153,1024,260,1297,396,16,138,129,17,17,1297,1297,260,1285,16,256,397,1297,137]

theorem envBound1505 : H12AffineFastState.Bounded env1505 := by
  intro p hp
  have h : env1505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1504_1505 : H12AffineEnvironment.transform 4 17 env1504 = env1505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env1504 == env1505) = true)

theorem identity1505 : scanCanonicalize (H12AffineFastState.compose env1505 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1505 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1506 : List Nat := [2,4,8,11,10,11,128,256,136,1024,397,1290,8,1291,260,139,1291,130,1024,260,1290,396,11,138,129,10,10,1290,1290,260,1285,11,256,397,1290,137]

theorem envBound1506 : H12AffineFastState.Bounded env1506 := by
  intro p hp
  have h : env1506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1505_1506 : H12AffineEnvironment.transform 3 11 env1505 = env1506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1505 == env1506) = true)

theorem identity1506 : scanCanonicalize (H12AffineFastState.compose env1506 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1506 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1507 : List Nat := [2,4,2,1,0,1,128,256,130,1024,391,1280,2,1281,260,129,1281,130,1024,260,1280,390,1,128,129,0,0,1280,1280,260,1285,1,256,391,1280,131]

theorem envBound1507 : H12AffineFastState.Bounded env1507 := by
  intro p hp
  have h : env1507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1506_1507 : H12AffineEnvironment.transform 2 2 env1506 = env1507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1506 == env1507) = true)

theorem identity1507 : scanCanonicalize (H12AffineFastState.compose env1507 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1507 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1508 : List Nat := [2,4,2,1,0,1,2,256,0,1024,261,1280,2,1281,260,3,1281,0,1024,260,1280,260,1,2,3,0,0,1280,1280,260,1285,1,256,261,1280,1]

theorem envBound1508 : H12AffineFastState.Bounded env1508 := by
  intro p hp
  have h : env1508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1507_1508 : H12AffineEnvironment.transform 6 2 env1507 = env1508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1507 == env1508) = true)

theorem identity1508 : scanCanonicalize (H12AffineFastState.compose env1508 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1508 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1509 : List Nat := [2,4,2,1,0,1,2,5,0,1024,0,1029,2,1028,1,3,1028,0,1024,1,1029,1,1,2,3,0,0,1029,1029,1,1024,1,5,0,1029,1]

theorem envBound1509 : H12AffineFastState.Bounded env1509 := by
  intro p hp
  have h : env1509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1508_1509 : H12AffineEnvironment.transform 7 5 env1508 = env1509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1508 == env1509) = true)

def leafEnv1509 : List Nat := [2,4,2,1,0,1,2,5,0,1024,0,1029,2,1028,1,3,1028,0,1024,1,1029,1,1,2,1024,3,1,0,0,1029,1029,1,1024,1,5,0,4,2,1029,1,0,1029,1]

def active1509 : List Nat := [0,1,9]

def tree1509 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1509 : H12WitnessSearch.Good tree1509 := H12GlobalWitnessIndex.good

theorem leafIdentity1509 : H12AffineFastState.composeSystem env1509 rootObs = leafEnv1509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1509 rootObs == leafEnv1509) = true)

theorem terminalChecked1509 : H12PackedTerminal.terminalCheckFast leafEnv1509 active1509 tree1509 = true := by decide +kernel

def env1510 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,16893076,16875796,21352448,16897045,4096,20978846,16876544,4294967296,256,4315938987,4096,16893084]

theorem envBound1510 : H12AffineFastState.Bounded env1510 := by
  intro p hp
  have h : env1510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1494_1510 : H12AffineEnvironment.transform 8 137 env1494 = env1510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1494 == env1510) = true)

theorem identity1510 : scanCanonicalize (H12AffineFastState.compose env1510 (packedSelected [6,25] rootPS)) = affineNative (2^(23+1) ^^^ 115732) := by decide +kernel

theorem selectedBound1510 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env1511 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,115732,128,17664,4461588,4097,4096,4315274,16404,4294967296,256,4299277503,4096,136]

theorem envBound1511 : H12AffineFastState.Bounded env1511 := by
  intro p hp
  have h : env1511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1510_1511 : H12AffineEnvironment.transform 23 115732 env1510 = env1511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 115732 env1510 == env1511) = true)

theorem identity1511 : scanCanonicalize (H12AffineFastState.compose env1511 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound1511 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1512 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4096,32768,65536,4097,262144,1024,32768,4096,4194304,5376,103444,128,5376,4461588,4097,4096,4294794,4116,4294967296,256,4299265215,4096,136]

theorem envBound1512 : H12AffineFastState.Bounded env1512 := by
  intro p hp
  have h : env1512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1511_1512 : H12AffineEnvironment.transform 13 4096 env1511 = env1512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1511 == env1512) = true)

def env1513 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010965,21352448,17024020,131073,21105823,16876544,4294967296,256,4332967606,131073,33554441]

theorem envBound1513 : H12AffineFastState.Bounded env1513 := by
  intro p hp
  have h : env1513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1445_1513 : H12AffineEnvironment.transform 12 641 env1445 = env1513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env1445 == env1513) = true)

def env1514 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897044,4097,20978847,16876544,4294967296,256,4332832438,4097,33554441]

theorem envBound1514 : H12AffineFastState.Bounded env1514 := by
  intro p hp
  have h : env1514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1513_1514 : H12AffineEnvironment.transform 16 4096 env1513 = env1514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1513 == env1514) = true)

theorem identity1514 : scanCanonicalize (H12AffineFastState.compose env1514 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 119692) := by decide +kernel

theorem selectedBound1514 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1515 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,119692,33554432,21145,4457356,1944,4097,4312851,22412,4294967296,256,4332832438,4097,33554441]

theorem envBound1515 : H12AffineFastState.Bounded env1515 := by
  intro p hp
  have h : env1515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1514_1515 : H12AffineEnvironment.transform 23 119692 env1514 = env1515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 119692 env1514 == env1515) = true)

def env1516 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,119692,128,21145,4457356,1944,4097,4312851,22412,4294967296,256,4299277878,4097,137]

theorem envBound1516 : H12AffineFastState.Bounded env1516 := by
  intro p hp
  have h : env1516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1515_1516 : H12AffineEnvironment.transform 24 128 env1515 = env1516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env1515 == env1516) = true)

theorem identity1516 : scanCanonicalize (H12AffineFastState.compose env1516 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1516 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1517 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,104093,128,6024,4457356,1944,4097,4295170,4765,4294967296,256,4299260711,4097,137]

theorem envBound1517 : H12AffineFastState.Bounded env1517 := by
  intro p hp
  have h : env1517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1516_1517 : H12AffineEnvironment.transform 13 1297 env1516 = env1517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env1516 == env1517) = true)

theorem identity1517 : scanCanonicalize (H12AffineFastState.compose env1517 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1517 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1518 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,103445,128,5376,4456708,1296,4097,4294794,4117,4294967296,256,4299260335,4097,137]

theorem envBound1518 : H12AffineFastState.Bounded env1518 := by
  intro p hp
  have h : env1518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1517_1518 : H12AffineEnvironment.transform 8 136 env1517 = env1518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1517 == env1518) = true)

theorem identity1518 : scanCanonicalize (H12AffineFastState.compose env1518 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1518 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env1519 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,65536,4096,262144,1024,260,4096,4194304,17,70929,128,5376,4456708,1296,4097,4262286,4117,4294967296,256,4299227307,4097,137]

theorem envBound1519 : H12AffineFastState.Bounded env1519 := by
  intro p hp
  have h : env1519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1518_1519 : H12AffineEnvironment.transform 14 260 env1518 = env1519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1518 == env1519) = true)

theorem identity1519 : scanCanonicalize (H12AffineFastState.compose env1519 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4522145) := by decide +kernel

theorem selectedBound1519 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1520 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,65536,4096,262144,1024,260,4096,4194304,17,70929,128,5376,4456708,1296,4097,4262286,4117,4522145,256,262154,4097,137]

theorem envBound1520 : H12AffineFastState.Bounded env1520 := by
  intro p hp
  have h : env1520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1519_1520 : H12AffineEnvironment.transform 31 4522145 env1519 = env1520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4522145 env1519 == env1520) = true)

theorem identity1520 : scanCanonicalize (H12AffineFastState.compose env1520 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound1520 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1521 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,262144,1024,260,4096,4194304,17,5530,128,5376,4456708,1296,4097,4196613,4117,4456490,256,262154,4097,137]

theorem envBound1521 : H12AffineFastState.Bounded env1521 := by
  intro p hp
  have h : env1521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1520_1521 : H12AffineEnvironment.transform 15 139 env1520 = env1521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env1520 == env1521) = true)

theorem identity1521 : scanCanonicalize (H12AffineFastState.compose env1521 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound1521 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env1522 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,7220,1024,260,4096,4194304,17,5530,128,5376,4201776,1296,4097,4196613,4117,4201502,256,7230,4097,137]

theorem envBound1522 : H12AffineFastState.Bounded env1522 := by
  intro p hp
  have h : env1522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1521_1522 : H12AffineEnvironment.transform 17 7220 env1521 = env1522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env1521 == env1522) = true)

def env1523 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,7220,1024,260,4096,5408,17,5530,128,5376,2064,1296,4097,7205,4117,2366,256,7230,4097,137]

theorem envBound1523 : H12AffineFastState.Bounded env1523 := by
  intro p hp
  have h : env1523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1522_1523 : H12AffineEnvironment.transform 21 5408 env1522 = env1523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1522 == env1523) = true)

theorem identity1523 : scanCanonicalize (H12AffineFastState.compose env1523 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 1427) := by decide +kernel

theorem selectedBound1523 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1524 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1427,9,1297,260,139,1427,2471,1024,260,1427,179,17,9,128,147,2064,1296,1426,2486,1414,2366,256,2477,1426,137]

theorem envBound1524 : H12AffineFastState.Bounded env1524 := by
  intro p hp
  have h : env1524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1523_1524 : H12AffineEnvironment.transform 11 1427 env1523 = env1524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1427 env1523 == env1524) = true)

theorem identity1524 : scanCanonicalize (H12AffineFastState.compose env1524 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound1524 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1525 : List Nat := [2,4,8,16,32,16,128,256,136,1024,26,1427,9,1297,260,139,1427,445,1024,260,1427,179,17,9,128,147,10,1296,1426,428,1414,292,256,439,1426,137]

theorem envBound1525 : H12AffineFastState.Bounded env1525 := by
  intro p hp
  have h : env1525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1524_1525 : H12AffineEnvironment.transform 10 26 env1524 = env1525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env1524 == env1525) = true)

def env1526 : List Nat := [2,4,8,16,32,16,128,20,136,1024,26,1159,9,1029,16,139,1159,169,1024,16,1159,179,17,9,128,147,10,1028,1158,184,1170,48,20,163,1158,137]

theorem envBound1526 : H12AffineFastState.Bounded env1526 := by
  intro p hp
  have h : env1526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1525_1526 : H12AffineEnvironment.transform 7 20 env1525 = env1526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1525 == env1526) = true)

theorem identity1526 : scanCanonicalize (H12AffineFastState.compose env1526 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1526 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1527 : List Nat := [2,4,8,16,32,16,35,20,43,1024,26,1060,9,1029,16,40,1060,10,1024,16,1060,16,17,9,35,48,10,1028,1061,27,1073,48,20,0,1061,42]

theorem envBound1527 : H12AffineFastState.Bounded env1527 := by
  intro p hp
  have h : env1527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1526_1527 : H12AffineEnvironment.transform 6 35 env1526 = env1527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1526 == env1527) = true)

theorem identity1527 : scanCanonicalize (H12AffineFastState.compose env1527 (packedSelected [2,5] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1527 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env1528 : List Nat := [2,4,2,16,32,16,35,20,33,1024,16,1060,3,1029,16,34,1060,0,1024,16,1060,16,17,3,35,48,0,1028,1061,17,1073,48,20,0,1061,32]

theorem envBound1528 : H12AffineFastState.Bounded env1528 := by
  intro p hp
  have h : env1528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1527_1528 : H12AffineEnvironment.transform 2 2 env1527 = env1528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1527 == env1528) = true)

theorem identity1528 : scanCanonicalize (H12AffineFastState.compose env1528 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound1528 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1529 : List Nat := [2,4,2,16,1,16,2,20,0,1024,16,1029,3,1029,16,3,1029,0,1024,16,1029,16,17,3,2,17,0,1028,1028,17,1040,17,20,0,1028,1]

theorem envBound1529 : H12AffineFastState.Bounded env1529 := by
  intro p hp
  have h : env1529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1528_1529 : H12AffineEnvironment.transform 4 1 env1528 = env1529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1528 == env1529) = true)

theorem identity1529 : scanCanonicalize (H12AffineFastState.compose env1529 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1529 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1530 : List Nat := [2,4,2,0,1,0,2,4,0,1024,0,1029,3,1029,0,3,1029,0,1024,0,1029,0,1,3,2,1,0,1028,1028,1,1024,1,4,0,1028,1]

theorem envBound1530 : H12AffineFastState.Bounded env1530 := by
  intro p hp
  have h : env1530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1529_1530 : H12AffineEnvironment.transform 3 0 env1529 = env1530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1529 == env1530) = true)

def env1531 : List Nat := [2,4,8,16,32,16,128,21,136,1024,26,1158,9,1028,17,139,1158,168,1024,17,1158,179,17,9,128,147,10,1029,1159,185,1171,49,21,162,1159,137]

theorem envBound1531 : H12AffineFastState.Bounded env1531 := by
  intro p hp
  have h : env1531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1525_1531 : H12AffineEnvironment.transform 7 21 env1525 = env1531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1525 == env1531) = true)

theorem identity1531 : scanCanonicalize (H12AffineFastState.compose env1531 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1531 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1532 : List Nat := [2,4,8,16,0,16,128,21,136,1024,26,1158,9,1028,17,139,1158,136,1024,17,1158,147,17,9,128,147,10,1029,1159,153,1171,17,21,130,1159,137]

theorem envBound1532 : H12AffineFastState.Bounded env1532 := by
  intro p hp
  have h : env1532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1531_1532 : H12AffineEnvironment.transform 4 0 env1531 = env1532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1531 == env1532) = true)

theorem identity1532 : scanCanonicalize (H12AffineFastState.compose env1532 (packedSelected [2,5] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1532 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env1533 : List Nat := [2,4,8,10,0,10,128,15,136,1024,0,1158,9,1028,11,139,1158,136,1024,11,1158,137,11,9,128,137,10,1029,1159,131,1161,11,15,130,1159,137]

theorem envBound1533 : H12AffineFastState.Bounded env1533 := by
  intro p hp
  have h : env1533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1532_1533 : H12AffineEnvironment.transform 3 10 env1532 = env1533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1532 == env1533) = true)

theorem identity1533 : scanCanonicalize (H12AffineFastState.compose env1533 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1533 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1534 : List Nat := [2,4,8,10,0,10,2,15,10,1024,0,1028,9,1028,11,9,1028,10,1024,11,1028,11,11,9,2,11,10,1029,1029,1,1035,11,15,0,1029,11]

theorem envBound1534 : H12AffineFastState.Bounded env1534 := by
  intro p hp
  have h : env1534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1533_1534 : H12AffineEnvironment.transform 6 2 env1533 = env1534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1533 == env1534) = true)

theorem identity1534 : scanCanonicalize (H12AffineFastState.compose env1534 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1534 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1535 : List Nat := [2,4,2,0,0,0,2,5,0,1024,0,1028,3,1028,1,3,1028,0,1024,1,1028,1,1,3,2,1,0,1029,1029,1,1025,1,5,0,1029,1]

theorem envBound1535 : H12AffineFastState.Bounded env1535 := by
  intro p hp
  have h : env1535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1534_1535 : H12AffineEnvironment.transform 2 2 env1534 = env1535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1534 == env1535) = true)

def env1536 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,7220,1024,260,4096,5409,17,5530,128,5376,2065,1296,4097,7204,4117,2367,256,7230,4097,137]

theorem envBound1536 : H12AffineFastState.Bounded env1536 := by
  intro p hp
  have h : env1536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1522_1536 : H12AffineEnvironment.transform 21 5409 env1522 = env1536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1522 == env1536) = true)

theorem identity1536 : scanCanonicalize (H12AffineFastState.compose env1536 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1536 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1537 : List Nat := [2,4,8,16,32,16,3,256,11,1024,2048,4096,9,1297,260,8,4096,7220,1024,260,4096,5409,17,5401,3,5376,2065,1296,4097,7204,4117,2367,256,7230,4097,10]

theorem envBound1537 : H12AffineFastState.Bounded env1537 := by
  intro p hp
  have h : env1537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1536_1537 : H12AffineEnvironment.transform 6 3 env1536 = env1537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1536 == env1537) = true)

theorem identity1537 : scanCanonicalize (H12AffineFastState.compose env1537 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 27) := by decide +kernel

theorem selectedBound1537 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1538 : List Nat := [2,4,8,16,32,16,3,256,11,1024,27,4096,9,1297,260,8,4096,5167,1024,260,4096,5409,17,5401,3,5376,10,1296,4097,5183,4117,292,256,5157,4097,10]

theorem envBound1538 : H12AffineFastState.Bounded env1538 := by
  intro p hp
  have h : env1538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1537_1538 : H12AffineEnvironment.transform 10 27 env1537 = env1538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 27 env1537 == env1538) = true)

def env1539 : List Nat := [2,4,8,16,32,16,3,256,11,1024,27,1296,9,1297,260,8,1296,319,1024,260,1296,49,17,9,3,16,10,1296,1297,303,1285,292,256,309,1297,10]

theorem envBound1539 : H12AffineFastState.Bounded env1539 := by
  intro p hp
  have h : env1539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1538_1539 : H12AffineEnvironment.transform 11 1296 env1538 = env1539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1538 == env1539) = true)

theorem identity1539 : scanCanonicalize (H12AffineFastState.compose env1539 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1539 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1540 : List Nat := [2,4,8,16,0,16,3,256,11,1024,27,1296,9,1297,260,8,1296,287,1024,260,1296,17,17,9,3,16,10,1296,1297,271,1285,260,256,277,1297,10]

theorem envBound1540 : H12AffineFastState.Bounded env1540 := by
  intro p hp
  have h : env1540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1539_1540 : H12AffineEnvironment.transform 4 0 env1539 = env1540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1539 == env1540) = true)

theorem identity1540 : scanCanonicalize (H12AffineFastState.compose env1540 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 30) := by decide +kernel

theorem selectedBound1540 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1541 : List Nat := [2,4,8,16,0,16,3,30,11,1024,27,1038,9,1039,26,8,1038,1,1024,26,1038,17,17,9,3,16,10,1038,1039,17,1051,26,30,11,1039,10]

theorem envBound1541 : H12AffineFastState.Bounded env1541 := by
  intro p hp
  have h : env1541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1540_1541 : H12AffineEnvironment.transform 7 30 env1540 = env1541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 30 env1540 == env1541) = true)

theorem identity1541 : scanCanonicalize (H12AffineFastState.compose env1541 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1541 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1542 : List Nat := [2,4,8,0,0,0,3,14,11,1024,11,1038,9,1039,10,8,1038,1,1024,10,1038,1,1,9,3,0,10,1038,1039,1,1035,10,14,11,1039,10]

theorem envBound1542 : H12AffineFastState.Bounded env1542 := by
  intro p hp
  have h : env1542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1541_1542 : H12AffineEnvironment.transform 3 0 env1541 = env1542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1541 == env1542) = true)

theorem identity1542 : scanCanonicalize (H12AffineFastState.compose env1542 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1542 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1543 : List Nat := [2,4,3,0,0,0,3,5,0,1024,0,1029,2,1028,1,3,1029,1,1024,1,1029,1,1,2,3,0,1,1029,1028,1,1024,1,5,0,1028,1]

theorem envBound1543 : H12AffineFastState.Bounded env1543 := by
  intro p hp
  have h : env1543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1542_1543 : H12AffineEnvironment.transform 2 3 env1542 = env1543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1542 == env1543) = true)

def leafEnv1543 : List Nat := [2,4,3,0,0,0,3,5,0,1024,0,1029,2,1028,1,3,1029,1,1024,1,1029,1,1,2,1024,3,1,0,1,1029,1028,1,1024,1,5,0,4,2,1028,1,0,1028,1]

def active1543 : List Nat := [0,1,9]

def tree1543 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1543 : H12WitnessSearch.Good tree1543 := H12GlobalWitnessIndex.good

theorem leafIdentity1543 : H12AffineFastState.composeSystem env1543 rootObs = leafEnv1543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1543 rootObs == leafEnv1543) = true)

theorem terminalChecked1543 : H12PackedTerminal.terminalCheckFast leafEnv1543 active1543 tree1543 = true := by decide +kernel

def env1544 : List Nat := [2,4,8,16,32,16,3,256,11,1024,27,1297,9,1297,260,8,1297,318,1024,260,1297,48,17,8,3,17,10,1296,1296,302,1284,292,256,308,1296,10]

theorem envBound1544 : H12AffineFastState.Bounded env1544 := by
  intro p hp
  have h : env1544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1538_1544 : H12AffineEnvironment.transform 11 1297 env1538 = env1544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1538 == env1544) = true)

theorem identity1544 : scanCanonicalize (H12AffineFastState.compose env1544 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound1544 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1545 : List Nat := [2,4,8,16,32,16,3,52,11,1024,27,1061,9,1061,48,8,1061,10,1024,48,1061,48,17,8,3,17,10,1060,1060,26,1072,16,52,0,1060,10]

theorem envBound1545 : H12AffineFastState.Bounded env1545 := by
  intro p hp
  have h : env1545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1544_1545 : H12AffineEnvironment.transform 7 52 env1544 = env1545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env1544 == env1545) = true)

theorem identity1545 : scanCanonicalize (H12AffineFastState.compose env1545 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound1545 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1546 : List Nat := [2,4,8,16,10,16,3,30,11,1024,27,1039,9,1039,26,8,1039,10,1024,26,1039,26,17,8,3,17,10,1038,1038,26,1050,16,30,0,1038,10]

theorem envBound1546 : H12AffineFastState.Bounded env1546 := by
  intro p hp
  have h : env1546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1545_1546 : H12AffineEnvironment.transform 4 10 env1545 = env1546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env1545 == env1546) = true)

theorem identity1546 : scanCanonicalize (H12AffineFastState.compose env1546 (packedSelected [10] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1546 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1547 : List Nat := [2,4,8,0,10,0,3,14,11,1024,11,1039,9,1039,10,8,1039,10,1024,10,1039,10,1,8,3,1,10,1038,1038,10,1034,0,14,0,1038,10]

theorem envBound1547 : H12AffineFastState.Bounded env1547 := by
  intro p hp
  have h : env1547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1546_1547 : H12AffineEnvironment.transform 3 0 env1546 = env1547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1546 == env1547) = true)

def env1548 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,119692,129,21145,4457356,1944,4097,4312851,22412,4294967296,256,4299277879,4097,136]

theorem envBound1548 : H12AffineFastState.Bounded env1548 := by
  intro p hp
  have h : env1548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1515_1548 : H12AffineEnvironment.transform 24 129 env1515 = env1548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env1515 == env1548) = true)

theorem identity1548 : scanCanonicalize (H12AffineFastState.compose env1548 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1945) := by decide +kernel

theorem selectedBound1548 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1549 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1945,32768,65536,4096,262144,1024,32768,4096,4194304,665,103445,129,5376,4457356,1944,4097,4294794,4117,4294967296,256,4299260334,4097,136]

theorem envBound1549 : H12AffineFastState.Bounded env1549 := by
  intro p hp
  have h : env1549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1548_1549 : H12AffineEnvironment.transform 13 1945 env1548 = env1549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1945 env1548 == env1549) = true)

theorem identity1549 : scanCanonicalize (H12AffineFastState.compose env1549 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound1549 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1550 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1945,32768,65536,1945,262144,1024,32768,1945,4194304,665,99212,129,665,4457356,1944,1944,4294794,1932,4294967296,256,4299260334,1944,136]

theorem envBound1550 : H12AffineFastState.Bounded env1550 := by
  intro p hp
  have h : env1550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1549_1550 : H12AffineEnvironment.transform 11 1945 env1549 = env1550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env1549 == env1550) = true)

theorem identity1550 : scanCanonicalize (H12AffineFastState.compose env1550 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound1550 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env1551 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1945,32768,33166,1945,262144,1024,32768,1945,4194304,665,514,129,665,4457356,1944,1944,4196612,1932,4294967296,256,4299161632,1944,136]

theorem envBound1551 : H12AffineFastState.Bounded env1551 := by
  intro p hp
  have h : env1551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1550_1551 : H12AffineEnvironment.transform 15 33166 env1550 = env1551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env1550 == env1551) = true)

theorem identity1551 : scanCanonicalize (H12AffineFastState.compose env1551 (packedSelected [0,1,3,4,7,9,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 35497) := by decide +kernel

theorem selectedBound1551 : packedSelected [0,1,3,4,7,9,12,15] rootPS < 2^1333 := by decide +kernel

def env1552 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1945,32768,33166,1945,35497,1024,32768,1945,4194304,665,514,129,665,4229413,1944,1944,4196612,1932,4294967296,256,4299161632,1944,136]

theorem envBound1552 : H12AffineFastState.Bounded env1552 := by
  intro p hp
  have h : env1552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1551_1552 : H12AffineEnvironment.transform 17 35497 env1551 = env1552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 35497 env1551 == env1552) = true)

theorem identity1552 : scanCanonicalize (H12AffineFastState.compose env1552 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound1552 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env1553 : List Nat := [2,4,8,16,32,16,128,256,512,1024,261,1945,641,1945,32768,33166,1945,33708,1024,32768,1945,4194304,665,514,129,665,4227104,1944,1944,4194305,1932,4294967296,256,4299161632,1944,136]

theorem envBound1553 : H12AffineFastState.Bounded env1553 := by
  intro p hp
  have h : env1553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1552_1553 : H12AffineEnvironment.transform 10 261 env1552 = env1553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env1552 == env1553) = true)

theorem identity1553 : scanCanonicalize (H12AffineFastState.compose env1553 (packedSelected [0,2,4,6,8,11] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1553 : packedSelected [0,2,4,6,8,11] rootPS < 2^1333 := by decide +kernel

def env1554 : List Nat := [2,4,8,16,32,16,128,256,136,1024,261,1297,9,1297,32768,33166,1297,33060,1024,32768,1297,4194304,17,138,129,17,4227104,1296,1296,4194305,1284,4294967296,256,4299161632,1296,136]

theorem envBound1554 : H12AffineFastState.Bounded env1554 := by
  intro p hp
  have h : env1554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1553_1554 : H12AffineEnvironment.transform 8 136 env1553 = env1554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1553 == env1554) = true)

theorem identity1554 : scanCanonicalize (H12AffineFastState.compose env1554 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 32931) := by decide +kernel

theorem selectedBound1554 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1555 : List Nat := [2,4,8,16,32,16,128,256,136,1024,261,1297,9,1297,32768,33166,1297,33060,1024,32768,1297,32931,17,138,129,17,131,1296,1296,32930,1284,4294967296,256,4295000195,1296,136]

theorem envBound1555 : H12AffineFastState.Bounded env1555 := by
  intro p hp
  have h : env1555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1554_1555 : H12AffineEnvironment.transform 21 32931 env1554 = env1555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32931 env1554 == env1555) = true)

theorem identity1555 : scanCanonicalize (H12AffineFastState.compose env1555 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound1555 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1556 : List Nat := [2,4,8,16,32,16,34,256,42,1024,261,1297,9,1297,32768,33068,1297,33060,1024,32768,1297,32769,17,40,35,17,33,1296,1296,32768,1284,4294967296,256,4295000097,1296,42]

theorem envBound1556 : H12AffineFastState.Bounded env1556 := by
  intro p hp
  have h : env1556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1555_1556 : H12AffineEnvironment.transform 6 34 env1555 = env1556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env1555 == env1556) = true)

theorem identity1556 : scanCanonicalize (H12AffineFastState.compose env1556 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound1556 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1557 : List Nat := [2,4,8,16,10,16,8,256,0,1024,261,1297,9,1297,32768,33030,1297,33038,1024,32768,1297,32769,17,2,9,17,11,1296,1296,32768,1284,4294967296,256,4295000075,1296,0]

theorem envBound1557 : H12AffineFastState.Bounded env1557 := by
  intro p hp
  have h : env1557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1556_1557 : H12AffineEnvironment.transform 4 10 env1556 = env1557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env1556 == env1557) = true)

theorem identity1557 : scanCanonicalize (H12AffineFastState.compose env1557 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 18) := by decide +kernel

theorem selectedBound1557 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1558 : List Nat := [2,4,8,16,10,16,8,256,0,1024,261,1297,9,1297,32768,33030,1297,33038,1024,32768,1297,32769,17,2,9,17,11,1296,1296,32768,1284,18,256,32793,1296,0]

theorem envBound1558 : H12AffineFastState.Bounded env1558 := by
  intro p hp
  have h : env1558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1557_1558 : H12AffineEnvironment.transform 31 18 env1557 = env1558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 18 env1557 == env1558) = true)

theorem identity1558 : scanCanonicalize (H12AffineFastState.compose env1558 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 29) := by decide +kernel

theorem selectedBound1558 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1559 : List Nat := [2,4,8,16,10,16,8,29,0,1024,24,1036,9,1036,32768,32795,1036,32787,1024,32768,1036,32769,17,2,9,17,11,1037,1037,32768,1049,18,29,32793,1037,0]

theorem envBound1559 : H12AffineFastState.Bounded env1559 := by
  intro p hp
  have h : env1559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1558_1559 : H12AffineEnvironment.transform 7 29 env1558 = env1559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 29 env1558 == env1559) = true)

def env1560 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897045,4096,20978846,16876544,4294967296,256,4332832439,4096,33554441]

theorem envBound1560 : H12AffineFastState.Bounded env1560 := by
  intro p hp
  have h : env1560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1513_1560 : H12AffineEnvironment.transform 16 4097 env1513 = env1560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1513 == env1560) = true)

theorem identity1560 : scanCanonicalize (H12AffineFastState.compose env1560 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 116381) := by decide +kernel

theorem selectedBound1560 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1561 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,116381,33554432,18313,4462237,4744,4096,4315651,17053,4294967296,256,4332832439,4096,33554441]

theorem envBound1561 : H12AffineFastState.Bounded env1561 := by
  intro p hp
  have h : env1561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1560_1561 : H12AffineEnvironment.transform 23 116381 env1560 = env1561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 116381 env1560 == env1561) = true)

def env1562 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,116381,128,18313,4462237,4744,4096,4315651,17053,4294967296,256,4299277879,4096,137]

theorem envBound1562 : H12AffineFastState.Bounded env1562 := by
  intro p hp
  have h : env1562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1561_1562 : H12AffineEnvironment.transform 24 128 env1561 = env1562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env1561 == env1562) = true)

theorem identity1562 : scanCanonicalize (H12AffineFastState.compose env1562 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound1562 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1563 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,16384,32768,65536,1944,262144,1024,32768,1945,4194304,17664,116381,128,18313,4456708,1297,1945,4312474,17053,4294967296,256,4299277879,1945,137]

theorem envBound1563 : H12AffineFastState.Bounded env1563 := by
  intro p hp
  have h : env1563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1562_1563 : H12AffineEnvironment.transform 11 1945 env1562 = env1563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env1562 == env1563) = true)

theorem identity1563 : scanCanonicalize (H12AffineFastState.compose env1563 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1563 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1564 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1296,32768,65536,1944,262144,1024,32768,1945,4194304,16,99213,128,665,4456708,1297,1945,4294794,1933,4294967296,256,4299260711,1945,137]

theorem envBound1564 : H12AffineFastState.Bounded env1564 := by
  intro p hp
  have h : env1564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1563_1564 : H12AffineEnvironment.transform 13 1296 env1563 = env1564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env1563 == env1564) = true)

theorem identity1564 : scanCanonicalize (H12AffineFastState.compose env1564 (packedSelected [4,5,8,9,13,16,17] rootPS)) = affineNative (2^(21+1) ^^^ 33281) := by decide +kernel

theorem selectedBound1564 : packedSelected [4,5,8,9,13,16,17] rootPS < 2^1333 := by decide +kernel

def env1565 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1296,32768,65536,1944,262144,1024,32768,1945,33281,16,99213,128,665,295685,1297,1945,68235,1933,4294967296,256,4295033126,1945,137]

theorem envBound1565 : H12AffineFastState.Bounded env1565 := by
  intro p hp
  have h : env1565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1564_1565 : H12AffineEnvironment.transform 21 33281 env1564 = env1565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 33281 env1564 == env1565) = true)

theorem identity1565 : scanCanonicalize (H12AffineFastState.compose env1565 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 35496) := by decide +kernel

theorem selectedBound1565 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1566 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1296,32768,65536,1944,35496,1024,32768,1945,33281,16,99213,128,665,2477,1297,1945,68235,1933,4294967296,256,4295033126,1945,137]

theorem envBound1566 : H12AffineFastState.Bounded env1566 := by
  intro p hp
  have h : env1566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1565_1566 : H12AffineEnvironment.transform 17 35496 env1565 = env1566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 35496 env1565 == env1566) = true)

theorem identity1566 : scanCanonicalize (H12AffineFastState.compose env1566 (packedSelected [10,12,21] rootPS)) = affineNative (2^(14+1) ^^^ 909) := by decide +kernel

theorem selectedBound1566 : packedSelected [10,12,21] rootPS < 2^1333 := by decide +kernel

def env1567 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1296,909,65536,1944,2341,1024,909,1945,396,16,65536,128,665,2477,1297,1945,68235,1933,4294967296,256,4295033126,1945,137]

theorem envBound1567 : H12AffineFastState.Bounded env1567 := by
  intro p hp
  have h : env1567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1566_1567 : H12AffineEnvironment.transform 14 909 env1566 = env1567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 909 env1566 == env1567) = true)

theorem identity1567 : scanCanonicalize (H12AffineFastState.compose env1567 (packedSelected [3,12,15,24] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound1567 : packedSelected [3,12,15,24] rootPS < 2^1333 := by decide +kernel

def env1568 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,641,1296,909,138,1944,2341,1024,909,1945,396,16,138,128,665,2477,1297,1945,2561,1933,4294967296,256,4294967724,1945,137]

theorem envBound1568 : H12AffineFastState.Bounded env1568 := by
  intro p hp
  have h : env1568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1567_1568 : H12AffineEnvironment.transform 15 138 env1567 = env1568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env1567 == env1568) = true)

theorem identity1568 : scanCanonicalize (H12AffineFastState.compose env1568 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1568 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1569 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,9,1296,261,138,1296,2341,1024,261,1297,396,16,138,128,17,2477,1297,1297,2185,1285,4294967296,256,4294967724,1297,137]

theorem envBound1569 : H12AffineFastState.Bounded env1569 := by
  intro p hp
  have h : env1569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1568_1569 : H12AffineEnvironment.transform 8 136 env1568 = env1569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1568 == env1569) = true)

theorem identity1569 : scanCanonicalize (H12AffineFastState.compose env1569 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 32) := by decide +kernel

theorem selectedBound1569 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1570 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,9,1296,261,138,1296,2341,1024,261,1297,396,16,138,128,17,2477,1297,1297,2185,1285,32,256,396,1297,137]

theorem envBound1570 : H12AffineFastState.Bounded env1570 := by
  intro p hp
  have h : env1570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1569_1570 : H12AffineEnvironment.transform 31 32 env1569 = env1570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env1569 == env1570) = true)

theorem identity1570 : scanCanonicalize (H12AffineFastState.compose env1570 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 16) := by decide +kernel

theorem selectedBound1570 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1571 : List Nat := [2,4,8,16,32,16,128,256,136,1024,16,1297,9,1296,261,138,1296,309,1024,261,1297,396,16,138,128,17,445,1297,1297,153,1285,32,256,396,1297,137]

theorem envBound1571 : H12AffineFastState.Bounded env1571 := by
  intro p hp
  have h : env1571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1570_1571 : H12AffineEnvironment.transform 10 16 env1570 = env1571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 16 env1570 == env1571) = true)

theorem identity1571 : scanCanonicalize (H12AffineFastState.compose env1571 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 156) := by decide +kernel

theorem selectedBound1571 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1572 : List Nat := [2,4,8,16,32,16,128,156,136,1024,16,1165,9,1164,153,138,1164,169,1024,153,1165,16,16,138,128,17,33,1165,1165,153,1177,32,156,16,1165,137]

theorem envBound1572 : H12AffineFastState.Bounded env1572 := by
  intro p hp
  have h : env1572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1571_1572 : H12AffineEnvironment.transform 7 156 env1571 = env1572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 156 env1571 == env1572) = true)

theorem identity1572 : scanCanonicalize (H12AffineFastState.compose env1572 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound1572 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1573 : List Nat := [2,4,8,16,10,16,128,156,136,1024,16,1165,9,1164,153,138,1164,131,1024,153,1165,16,16,138,128,17,11,1165,1165,153,1177,10,156,16,1165,137]

theorem envBound1573 : H12AffineFastState.Bounded env1573 := by
  intro p hp
  have h : env1573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1572_1573 : H12AffineEnvironment.transform 4 10 env1572 = env1573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env1572 == env1573) = true)

theorem identity1573 : scanCanonicalize (H12AffineFastState.compose env1573 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1573 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1574 : List Nat := [2,4,2,16,0,16,128,150,130,1024,16,1159,3,1158,147,128,1158,131,1024,147,1159,16,16,128,128,17,1,1159,1159,147,1171,0,150,16,1159,131]

theorem envBound1574 : H12AffineFastState.Bounded env1574 := by
  intro p hp
  have h : env1574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1573_1574 : H12AffineEnvironment.transform 2 2 env1573 = env1574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1573 == env1574) = true)

theorem identity1574 : scanCanonicalize (H12AffineFastState.compose env1574 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1574 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1575 : List Nat := [2,4,2,16,0,16,2,20,0,1024,16,1029,3,1028,17,2,1028,1,1024,17,1029,16,16,2,2,17,1,1029,1029,17,1041,0,20,16,1029,1]

theorem envBound1575 : H12AffineFastState.Bounded env1575 := by
  intro p hp
  have h : env1575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1574_1575 : H12AffineEnvironment.transform 6 2 env1574 = env1575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1574 == env1575) = true)

theorem identity1575 : scanCanonicalize (H12AffineFastState.compose env1575 (packedSelected [6] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1575 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1576 : List Nat := [2,4,2,1,0,1,2,5,0,1024,1,1029,3,1028,0,2,1028,1,1024,0,1029,1,1,2,2,0,1,1029,1029,0,1024,0,5,1,1029,1]

theorem envBound1576 : H12AffineFastState.Bounded env1576 := by
  intro p hp
  have h : env1576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1575_1576 : H12AffineEnvironment.transform 3 1 env1575 = env1576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1575 == env1576) = true)

def leafEnv1576 : List Nat := [2,4,2,1,0,1,2,5,0,1024,1,1029,3,1028,0,2,1028,1,1024,0,1029,1,1,2,1024,2,1,0,1,1029,1029,0,1024,0,5,1,4,3,1029,1,0,1029,1]

def active1576 : List Nat := [0,1,9]

def tree1576 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1576 : H12WitnessSearch.Good tree1576 := H12GlobalWitnessIndex.good

theorem leafIdentity1576 : H12AffineFastState.composeSystem env1576 rootObs = leafEnv1576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1576 rootObs == leafEnv1576) = true)

theorem terminalChecked1576 : H12PackedTerminal.terminalCheckFast leafEnv1576 active1576 tree1576 = true := by decide +kernel

def env1577 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,116381,129,18313,4462237,4744,4096,4315651,17053,4294967296,256,4299277878,4096,136]

theorem envBound1577 : H12AffineFastState.Bounded env1577 := by
  intro p hp
  have h : env1577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1561_1577 : H12AffineEnvironment.transform 24 129 env1561 = env1577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env1561 == env1577) = true)

theorem identity1577 : scanCanonicalize (H12AffineFastState.compose env1577 (packedSelected [6,25] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1577 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env1578 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,115732,129,17664,4461588,4097,4096,4315274,16404,4294967296,256,4299277503,4096,136]

theorem envBound1578 : H12AffineFastState.Bounded env1578 := by
  intro p hp
  have h : env1578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1577_1578 : H12AffineEnvironment.transform 8 137 env1577 = env1578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1577 == env1578) = true)

theorem identity1578 : scanCanonicalize (H12AffineFastState.compose env1578 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound1578 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1579 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4096,32768,65536,4097,262144,1024,32768,4096,4194304,5376,103444,129,5376,4461588,4097,4096,4294794,4116,4294967296,256,4299265215,4096,136]

theorem envBound1579 : H12AffineFastState.Bounded env1579 := by
  intro p hp
  have h : env1579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1578_1579 : H12AffineEnvironment.transform 13 4096 env1578 = env1579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1578 == env1579) = true)

def env1580 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010964,21352449,17024021,131072,21105822,16876544,4294967296,256,4332975159,131073,33563272]

theorem envBound1580 : H12AffineFastState.Bounded env1580 := by
  intro p hp
  have h : env1580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1444_1580 : H12AffineEnvironment.transform 5 17 env1444 = env1580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1444 == env1580) = true)

def env1581 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010964,21352449,17024021,131072,21105822,16876544,4294967296,256,4332967607,131073,33554440]

theorem envBound1581 : H12AffineFastState.Bounded env1581 := by
  intro p hp
  have h : env1581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1580_1581 : H12AffineEnvironment.transform 12 640 env1580 = env1581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env1580 == env1581) = true)

def env1582 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897045,4096,20978846,16876544,4294967296,256,4332832439,4097,33554440]

theorem envBound1582 : H12AffineFastState.Bounded env1582 := by
  intro p hp
  have h : env1582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1581_1582 : H12AffineEnvironment.transform 16 4096 env1581 = env1582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1581 == env1582) = true)

theorem identity1582 : scanCanonicalize (H12AffineFastState.compose env1582 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 20609) := by decide +kernel

theorem selectedBound1582 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1583 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,20609,16875796,21352449,16897045,4096,20978846,16876544,4294967296,256,4299265590,4097,20617]

theorem envBound1583 : H12AffineFastState.Bounded env1583 := by
  intro p hp
  have h : env1583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1582_1583 : H12AffineEnvironment.transform 24 20609 env1582 = env1583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 20609 env1582 == env1583) = true)

def env1584 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,16777216,129,16875796,21331969,16876565,4096,20978846,16876544,4294967296,256,4299265590,4097,137]

theorem envBound1584 : H12AffineFastState.Bounded env1584 := by
  intro p hp
  have h : env1584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1583_1584 : H12AffineEnvironment.transform 13 4096 env1583 = env1584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1583 == env1584) = true)

theorem identity1584 : scanCanonicalize (H12AffineFastState.compose env1584 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(23+1) ^^^ 138) := by decide +kernel

theorem selectedBound1584 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env1585 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,138,129,98718,4554891,99487,4096,4201492,99466,4294967296,256,4299265590,4097,137]

theorem envBound1585 : H12AffineFastState.Bounded env1585 := by
  intro p hp
  have h : env1585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1584_1585 : H12AffineEnvironment.transform 23 138 env1584 = env1585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 138 env1584 == env1585) = true)

theorem identity1585 : scanCanonicalize (H12AffineFastState.compose env1585 (packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1585 : packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS < 2^1333 := by decide +kernel

def env1586 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,138,129,98718,4554891,99487,4096,4201492,99466,4294967296,256,4299265214,4097,137]

theorem envBound1586 : H12AffineFastState.Bounded env1586 := by
  intro p hp
  have h : env1586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1585_1586 : H12AffineEnvironment.transform 8 136 env1585 = env1586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1585 == env1586) = true)

theorem identity1586 : scanCanonicalize (H12AffineFastState.compose env1586 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(15+1) ^^^ 38046) := by decide +kernel

theorem selectedBound1586 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env1587 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4096,32768,38046,4096,262144,1024,32768,4096,4194304,5376,138,129,5376,4461589,4097,4096,4201492,4116,4294967296,256,4299161632,4097,137]

theorem envBound1587 : H12AffineFastState.Bounded env1587 := by
  intro p hp
  have h : env1587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1586_1587 : H12AffineEnvironment.transform 15 38046 env1586 = env1587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38046 env1586 == env1587) = true)

theorem identity1587 : scanCanonicalize (H12AffineFastState.compose env1587 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1587 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1588 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8,1297,32768,33167,1297,262144,1024,32768,1297,4194304,17,138,129,17,4456708,1296,1297,4196613,1285,4294967296,256,4299161632,1296,137]

theorem envBound1588 : H12AffineFastState.Bounded env1588 := by
  intro p hp
  have h : env1588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1587_1588 : H12AffineEnvironment.transform 11 1297 env1587 = env1588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1587 == env1588) = true)

theorem identity1588 : scanCanonicalize (H12AffineFastState.compose env1588 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 2184) := by decide +kernel

theorem selectedBound1588 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1589 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8,1297,2184,2311,1297,262144,1024,2184,1297,4194304,17,138,129,17,4456708,1296,1297,4196613,1285,4294967296,256,4299161632,1296,137]

theorem envBound1589 : H12AffineFastState.Bounded env1589 := by
  intro p hp
  have h : env1589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1588_1589 : H12AffineEnvironment.transform 14 2184 env1588 = env1589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2184 env1588 == env1589) = true)

theorem identity1589 : scanCanonicalize (H12AffineFastState.compose env1589 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 293) := by decide +kernel

theorem selectedBound1589 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1590 : List Nat := [2,4,8,16,32,17,128,256,136,1024,293,1297,8,1297,429,34,1297,262144,1024,429,1297,4194304,17,138,129,17,4456708,1296,1297,4194336,1285,4294967296,256,4299161632,1296,137]

theorem envBound1590 : H12AffineFastState.Bounded env1590 := by
  intro p hp
  have h : env1590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1589_1590 : H12AffineEnvironment.transform 10 293 env1589 = env1590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 293 env1589 == env1590) = true)

theorem identity1590 : scanCanonicalize (H12AffineFastState.compose env1590 (packedSelected [8] rootPS)) = affineNative (2^(17+1) ^^^ 169) := by decide +kernel

theorem selectedBound1590 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env1591 : List Nat := [2,4,8,16,32,17,128,256,136,1024,293,1297,8,1297,429,34,1297,169,1024,429,1297,4194304,17,138,129,17,4194733,1296,1297,4194336,1285,4294967296,256,4299161632,1296,137]

theorem envBound1591 : H12AffineFastState.Bounded env1591 := by
  intro p hp
  have h : env1591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1590_1591 : H12AffineEnvironment.transform 17 169 env1590 = env1591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 169 env1590 == env1591) = true)

theorem identity1591 : scanCanonicalize (H12AffineFastState.compose env1591 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 136) := by decide +kernel

theorem selectedBound1591 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1592 : List Nat := [2,4,8,16,32,17,128,256,136,1024,293,1297,8,1297,429,34,1297,169,1024,429,1297,4194304,17,138,129,17,4194733,1296,1297,4194336,1285,136,256,4194472,1296,137]

theorem envBound1592 : H12AffineFastState.Bounded env1592 := by
  intro p hp
  have h : env1592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1591_1592 : H12AffineEnvironment.transform 31 136 env1591 = env1592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 136 env1591 == env1592) = true)

theorem identity1592 : scanCanonicalize (H12AffineFastState.compose env1592 (packedSelected [10] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1592 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1593 : List Nat := [2,4,8,16,32,17,128,256,136,1024,293,1297,8,1297,429,34,1297,169,1024,429,1297,397,17,138,129,17,32,1296,1297,429,1285,136,256,293,1296,137]

theorem envBound1593 : H12AffineFastState.Bounded env1593 := by
  intro p hp
  have h : env1593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1592_1593 : H12AffineEnvironment.transform 21 397 env1592 = env1593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1592 == env1593) = true)

theorem identity1593 : scanCanonicalize (H12AffineFastState.compose env1593 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1593 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1594 : List Nat := [2,4,8,0,32,1,128,256,136,1024,293,1281,8,1281,429,34,1281,169,1024,429,1281,397,1,138,129,1,32,1280,1281,429,1285,136,256,293,1280,137]

theorem envBound1594 : H12AffineFastState.Bounded env1594 := by
  intro p hp
  have h : env1594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1593_1594 : H12AffineEnvironment.transform 3 0 env1593 = env1594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1593 == env1594) = true)

theorem identity1594 : scanCanonicalize (H12AffineFastState.compose env1594 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 47) := by decide +kernel

theorem selectedBound1594 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1595 : List Nat := [2,4,8,0,32,1,128,47,136,1024,10,1070,8,1070,130,34,1070,169,1024,130,1070,162,1,138,129,1,32,1071,1070,130,1066,136,47,10,1071,137]

theorem envBound1595 : H12AffineFastState.Bounded env1595 := by
  intro p hp
  have h : env1595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1594_1595 : H12AffineEnvironment.transform 7 47 env1594 = env1595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 47 env1594 == env1595) = true)

theorem identity1595 : scanCanonicalize (H12AffineFastState.compose env1595 (packedSelected [12] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1595 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1596 : List Nat := [2,4,8,0,32,1,35,47,43,1024,10,1070,8,1070,33,34,1070,10,1024,33,1070,1,1,41,34,1,32,1071,1070,33,1066,43,47,10,1071,42]

theorem envBound1596 : H12AffineFastState.Bounded env1596 := by
  intro p hp
  have h : env1596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1595_1596 : H12AffineEnvironment.transform 6 35 env1595 = env1596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1595 == env1596) = true)

theorem identity1596 : scanCanonicalize (H12AffineFastState.compose env1596 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1596 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1597 : List Nat := [2,4,8,0,0,1,3,15,11,1024,10,1038,8,1038,1,2,1038,10,1024,1,1038,1,1,9,2,1,0,1039,1038,1,1034,11,15,10,1039,10]

theorem envBound1597 : H12AffineFastState.Bounded env1597 := by
  intro p hp
  have h : env1597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1596_1597 : H12AffineEnvironment.transform 4 0 env1596 = env1597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1596 == env1597) = true)

theorem identity1597 : scanCanonicalize (H12AffineFastState.compose env1597 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1597 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1598 : List Nat := [2,4,2,0,0,1,3,5,1,1024,0,1028,2,1028,1,2,1028,0,1024,1,1028,1,1,3,2,1,0,1029,1028,1,1024,1,5,0,1029,0]

theorem envBound1598 : H12AffineFastState.Bounded env1598 := by
  intro p hp
  have h : env1598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1597_1598 : H12AffineEnvironment.transform 2 2 env1597 = env1598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1597 == env1598) = true)

def leafEnv1598 : List Nat := [2,4,2,0,0,1,3,5,1,1024,0,1028,2,1028,1,2,1028,0,1024,1,1028,1,1,3,1024,2,1,1,0,1029,1028,1,1024,1,5,0,4,2,1029,0,0,1028,1]

def active1598 : List Nat := [0,1,9]

def tree1598 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1598 : H12WitnessSearch.Good tree1598 := H12GlobalWitnessIndex.good

theorem leafIdentity1598 : H12AffineFastState.composeSystem env1598 rootObs = leafEnv1598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1598 rootObs == leafEnv1598) = true)

theorem terminalChecked1598 : H12PackedTerminal.terminalCheckFast leafEnv1598 active1598 tree1598 = true := by decide +kernel

def env1599 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,16777216,128,16875796,21331968,16876564,4096,20978846,16876544,4294967296,256,4299265590,4097,136]

theorem envBound1599 : H12AffineFastState.Bounded env1599 := by
  intro p hp
  have h : env1599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1583_1599 : H12AffineEnvironment.transform 13 4097 env1583 = env1599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1583 == env1599) = true)

def env1600 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,4293120,128,4195092,262656,4195860,4096,106142,4195840,4294967296,256,4299265590,4097,136]

theorem envBound1600 : H12AffineFastState.Bounded env1600 := by
  intro p hp
  have h : env1600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1599_1600 : H12AffineEnvironment.transform 23 4293120 env1599 = env1600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293120 env1599 == env1600) = true)

def env1601 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,1297,32768,65536,1296,262144,1024,32768,1296,4194304,17,4293120,128,4195092,262656,4195860,1296,101262,4195840,4294967296,256,4299260710,1297,136]

theorem envBound1601 : H12AffineFastState.Bounded env1601 := by
  intro p hp
  have h : env1601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1600_1601 : H12AffineEnvironment.transform 11 1296 env1600 = env1601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1600 == env1601) = true)

theorem identity1601 : scanCanonicalize (H12AffineFastState.compose env1601 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(21+1) ^^^ 65798) := by decide +kernel

theorem selectedBound1601 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1602 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,1297,32768,65536,1296,262144,1024,32768,1296,65798,17,33542,128,66066,262656,67346,1296,101262,67334,4294967296,256,4295000608,1297,136]

theorem envBound1602 : H12AffineFastState.Bounded env1602 := by
  intro p hp
  have h : env1602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1601_1602 : H12AffineEnvironment.transform 21 65798 env1601 = env1602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65798 env1601 == env1602) = true)

theorem identity1602 : scanCanonicalize (H12AffineFastState.compose env1602 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(15+1) ^^^ 514) := by decide +kernel

theorem selectedBound1602 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env1603 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,1297,32768,514,1296,262144,1024,32768,1296,772,17,33542,128,16,262656,1296,1296,35212,1284,4294967296,256,4295000608,1297,136]

theorem envBound1603 : H12AffineFastState.Bounded env1603 := by
  intro p hp
  have h : env1603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1602_1603 : H12AffineEnvironment.transform 15 514 env1602 = env1603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 514 env1602 == env1603) = true)

theorem identity1603 : scanCanonicalize (H12AffineFastState.compose env1603 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 33158) := by decide +kernel

theorem selectedBound1603 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1604 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,1297,32768,514,1296,33158,1024,32768,1296,772,17,33542,128,16,33670,1296,1296,35212,1284,4294967296,256,4295000608,1297,136]

theorem envBound1604 : H12AffineFastState.Bounded env1604 := by
  intro p hp
  have h : env1604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1603_1604 : H12AffineEnvironment.transform 17 33158 env1603 = env1604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 33158 env1603 == env1604) = true)

theorem identity1604 : scanCanonicalize (H12AffineFastState.compose env1604 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1604 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1605 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,640,1297,260,514,1296,130,1024,260,1296,772,17,514,128,16,642,1296,1296,2184,1284,4294967296,256,4294968100,1297,136]

theorem envBound1605 : H12AffineFastState.Bounded env1605 := by
  intro p hp
  have h : env1605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1604_1605 : H12AffineEnvironment.transform 14 260 env1604 = env1605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1604 == env1605) = true)

theorem identity1605 : scanCanonicalize (H12AffineFastState.compose env1605 (packedSelected [1,3] rootPS)) = affineNative (2^(10+1) ^^^ 814) := by decide +kernel

theorem selectedBound1605 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1606 : List Nat := [2,4,8,16,32,17,128,256,512,1024,814,1296,640,1297,260,514,1296,130,1024,260,1296,772,17,514,128,16,642,1296,1296,934,1284,4294967296,256,4294968100,1297,136]

theorem envBound1606 : H12AffineFastState.Bounded env1606 := by
  intro p hp
  have h : env1606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1605_1606 : H12AffineEnvironment.transform 10 814 env1605 = env1606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 814 env1605 == env1606) = true)

theorem identity1606 : scanCanonicalize (H12AffineFastState.compose env1606 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(31+1) ^^^ 941) := by decide +kernel

theorem selectedBound1606 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env1607 : List Nat := [2,4,8,16,32,17,128,256,512,1024,814,1296,640,1297,260,514,1296,130,1024,260,1296,772,17,514,128,16,642,1296,1296,934,1284,941,256,137,1297,136]

theorem envBound1607 : H12AffineFastState.Bounded env1607 := by
  intro p hp
  have h : env1607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1606_1607 : H12AffineEnvironment.transform 31 941 env1606 = env1607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 941 env1606 == env1607) = true)

theorem identity1607 : scanCanonicalize (H12AffineFastState.compose env1607 (packedSelected [1,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 292) := by decide +kernel

theorem selectedBound1607 : packedSelected [1,10,12] rootPS < 2^1333 := by decide +kernel

def env1608 : List Nat := [2,4,8,16,32,17,128,256,292,1024,10,1296,420,1297,260,294,1296,130,1024,260,1296,32,17,294,128,16,422,1296,1296,130,1284,137,256,137,1297,136]

theorem envBound1608 : H12AffineFastState.Bounded env1608 := by
  intro p hp
  have h : env1608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1607_1608 : H12AffineEnvironment.transform 8 292 env1607 = env1608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 292 env1607 == env1608) = true)

theorem identity1608 : scanCanonicalize (H12AffineFastState.compose env1608 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound1608 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env1609 : List Nat := [2,4,8,16,32,17,128,14,42,1024,10,1054,170,1055,10,40,1054,130,1024,10,1054,32,17,40,128,16,168,1054,1054,130,1034,137,14,137,1055,136]

theorem envBound1609 : H12AffineFastState.Bounded env1609 := by
  intro p hp
  have h : env1609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1608_1609 : H12AffineEnvironment.transform 7 14 env1608 = env1609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env1608 == env1609) = true)

theorem identity1609 : scanCanonicalize (H12AffineFastState.compose env1609 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1609 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1610 : List Nat := [2,4,8,16,32,17,8,14,42,1024,10,1054,34,1055,10,40,1054,10,1024,10,1054,32,17,40,8,16,32,1054,1054,10,1034,1,14,1,1055,0]

theorem envBound1610 : H12AffineFastState.Bounded env1610 := by
  intro p hp
  have h : env1610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1609_1610 : H12AffineEnvironment.transform 6 8 env1609 = env1610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1609 == env1610) = true)

theorem identity1610 : scanCanonicalize (H12AffineFastState.compose env1610 (packedSelected [1,13] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound1610 : packedSelected [1,13] rootPS < 2^1333 := by decide +kernel

def env1611 : List Nat := [2,4,8,16,10,17,8,14,0,1024,10,1054,8,1055,10,2,1054,10,1024,10,1054,10,17,2,8,16,10,1054,1054,10,1034,1,14,1,1055,0]

theorem envBound1611 : H12AffineFastState.Bounded env1611 := by
  intro p hp
  have h : env1611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1610_1611 : H12AffineEnvironment.transform 4 10 env1610 = env1611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env1610 == env1611) = true)

theorem identity1611 : scanCanonicalize (H12AffineFastState.compose env1611 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound1611 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1612 : List Nat := [2,4,8,3,10,2,8,14,0,1024,10,1037,8,1036,10,2,1037,10,1024,10,1037,10,2,2,8,3,10,1037,1037,10,1034,1,14,1,1036,0]

theorem envBound1612 : H12AffineFastState.Bounded env1612 := by
  intro p hp
  have h : env1612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1611_1612 : H12AffineEnvironment.transform 3 3 env1611 = env1612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env1611 == env1612) = true)

theorem identity1612 : scanCanonicalize (H12AffineFastState.compose env1612 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1612 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1613 : List Nat := [2,4,2,3,0,2,2,4,0,1024,0,1031,2,1030,0,2,1031,0,1024,0,1031,0,2,2,2,3,0,1031,1031,0,1024,1,4,1,1030,0]

theorem envBound1613 : H12AffineFastState.Bounded env1613 := by
  intro p hp
  have h : env1613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1612_1613 : H12AffineEnvironment.transform 2 2 env1612 = env1613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1612 == env1613) = true)

theorem identity1613 : scanCanonicalize (H12AffineFastState.compose env1613 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound1613 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1614 : List Nat := [2,4,2,3,0,2,2,4,0,5,0,2,2,3,0,2,2,0,5,0,2,0,2,2,2,3,0,2,2,0,5,1,4,1,3,0]

theorem envBound1614 : H12AffineFastState.Bounded env1614 := by
  intro p hp
  have h : env1614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1613_1614 : H12AffineEnvironment.transform 9 5 env1613 = env1614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env1613 == env1614) = true)

def leafEnv1614 : List Nat := [2,4,2,3,0,2,2,4,0,5,0,2,2,3,0,2,2,0,5,0,2,0,2,2,5,2,1,3,0,2,2,0,5,1,4,1,4,2,3,0,0,2,1]

def active1614 : List Nat := [0,1]

def tree1614 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1614 : H12WitnessSearch.Good tree1614 := H12GlobalWitnessIndex.good

theorem leafIdentity1614 : H12AffineFastState.composeSystem env1614 rootObs = leafEnv1614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1614 rootObs == leafEnv1614) = true)

theorem terminalChecked1614 : H12PackedTerminal.terminalCheckFast leafEnv1614 active1614 tree1614 = true := by decide +kernel

def env1615 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,1296,32768,65536,1297,262144,1024,32768,1297,4194304,16,4293120,128,4195092,262656,4195860,1297,101263,4195840,4294967296,256,4299260711,1296,136]

theorem envBound1615 : H12AffineFastState.Bounded env1615 := by
  intro p hp
  have h : env1615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1600_1615 : H12AffineEnvironment.transform 11 1297 env1600 = env1615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1600 == env1615) = true)

theorem identity1615 : scanCanonicalize (H12AffineFastState.compose env1615 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(21+1) ^^^ 297389) := by decide +kernel

theorem selectedBound1615 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1616 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,1296,32768,65536,1297,262144,1024,32768,1297,297389,16,330669,128,297657,262656,298937,1297,101263,298925,4294967296,256,4295297674,1296,136]

theorem envBound1616 : H12AffineFastState.Bounded env1616 := by
  intro p hp
  have h : env1616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1615_1616 : H12AffineEnvironment.transform 21 297389 env1615 = env1616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 297389 env1615 == env1616) = true)

theorem identity1616 : scanCanonicalize (H12AffineFastState.compose env1616 (packedSelected [4,6,9,16,25] rootPS)) = affineNative (2^(17+1) ^^^ 35496) := by decide +kernel

theorem selectedBound1616 : packedSelected [4,6,9,16,25] rootPS < 2^1333 := by decide +kernel

def env1617 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,1296,32768,65536,1297,35496,1024,32768,1297,773,16,98565,128,17,34984,1297,1297,101263,1285,4294967296,256,4295065634,1296,136]

theorem envBound1617 : H12AffineFastState.Bounded env1617 := by
  intro p hp
  have h : env1617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1616_1617 : H12AffineEnvironment.transform 17 35496 env1616 = env1617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 35496 env1616 == env1617) = true)

theorem identity1617 : scanCanonicalize (H12AffineFastState.compose env1617 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 2989) := by decide +kernel

theorem selectedBound1617 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1618 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,1296,2989,65536,1297,261,1024,2989,1297,773,16,68264,128,17,773,1297,1297,65570,1285,4294967296,256,4295035791,1296,136]

theorem envBound1618 : H12AffineFastState.Bounded env1618 := by
  intro p hp
  have h : env1618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1617_1618 : H12AffineEnvironment.transform 14 2989 env1617 = env1618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2989 env1617 == env1618) = true)

theorem identity1618 : scanCanonicalize (H12AffineFastState.compose env1618 (packedSelected [3,13] rootPS)) = affineNative (2^(15+1) ^^^ 2594) := by decide +kernel

theorem selectedBound1618 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env1619 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,1296,2989,2594,1297,261,1024,2989,1297,773,16,138,128,17,773,1297,1297,2560,1285,4294967296,256,4294967725,1296,136]

theorem envBound1619 : H12AffineFastState.Bounded env1619 := by
  intro p hp
  have h : env1619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1618_1619 : H12AffineEnvironment.transform 15 2594 env1618 = env1619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2594 env1618 == env1619) = true)

theorem identity1619 : scanCanonicalize (H12AffineFastState.compose env1619 (packedSelected [1,10,15] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1619 : packedSelected [1,10,15] rootPS < 2^1333 := by decide +kernel

def env1620 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8,1296,2341,2218,1297,261,1024,2341,1297,397,16,138,128,17,397,1297,1297,2184,1285,4294967296,256,4294967725,1296,136]

theorem envBound1620 : H12AffineFastState.Bounded env1620 := by
  intro p hp
  have h : env1620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1619_1620 : H12AffineEnvironment.transform 8 136 env1619 = env1620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1619 == env1620) = true)

theorem identity1620 : scanCanonicalize (H12AffineFastState.compose env1620 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 2184) := by decide +kernel

theorem selectedBound1620 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1621 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8,1296,2341,2218,1297,261,1024,2341,1297,397,16,138,128,17,397,1297,1297,2184,1285,2184,256,2341,1296,136]

theorem envBound1621 : H12AffineFastState.Bounded env1621 := by
  intro p hp
  have h : env1621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1620_1621 : H12AffineEnvironment.transform 31 2184 env1620 = env1621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2184 env1620 == env1621) = true)

theorem identity1621 : scanCanonicalize (H12AffineFastState.compose env1621 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 397) := by decide +kernel

theorem selectedBound1621 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1622 : List Nat := [2,4,8,16,32,17,128,256,136,1024,397,1297,8,1296,168,295,1297,261,1024,168,1297,397,16,138,128,17,397,1297,1297,261,1285,261,256,168,1296,136]

theorem envBound1622 : H12AffineFastState.Bounded env1622 := by
  intro p hp
  have h : env1622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1621_1622 : H12AffineEnvironment.transform 10 397 env1621 = env1622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 397 env1621 == env1622) = true)

theorem identity1622 : scanCanonicalize (H12AffineFastState.compose env1622 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 39) := by decide +kernel

theorem selectedBound1622 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1623 : List Nat := [2,4,8,16,32,17,128,39,136,1024,170,1078,8,1079,168,0,1078,34,1024,168,1078,170,16,138,128,17,170,1078,1078,34,1058,34,39,168,1079,136]

theorem envBound1623 : H12AffineFastState.Bounded env1623 := by
  intro p hp
  have h : env1623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1622_1623 : H12AffineEnvironment.transform 7 39 env1622 = env1623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 39 env1622 == env1623) = true)

theorem identity1623 : scanCanonicalize (H12AffineFastState.compose env1623 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1623 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1624 : List Nat := [2,4,8,16,32,17,8,39,0,1024,34,1078,8,1079,32,0,1078,34,1024,32,1078,34,16,2,8,17,34,1078,1078,34,1058,34,39,32,1079,0]

theorem envBound1624 : H12AffineFastState.Bounded env1624 := by
  intro p hp
  have h : env1624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1623_1624 : H12AffineEnvironment.transform 6 8 env1623 = env1624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1623 == env1624) = true)

theorem identity1624 : scanCanonicalize (H12AffineFastState.compose env1624 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound1624 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1625 : List Nat := [2,4,1,16,32,17,1,39,0,1024,34,1078,1,1079,32,0,1078,34,1024,32,1078,34,16,2,1,17,34,1078,1078,34,1058,34,39,32,1079,0]

theorem envBound1625 : H12AffineFastState.Bounded env1625 := by
  intro p hp
  have h : env1625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1624_1625 : H12AffineEnvironment.transform 2 1 env1624 = env1625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env1624 == env1625) = true)

theorem identity1625 : scanCanonicalize (H12AffineFastState.compose env1625 (packedSelected [6] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound1625 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1626 : List Nat := [2,4,1,16,3,17,1,4,0,1024,1,1045,1,1044,3,0,1045,1,1024,3,1045,1,16,2,1,17,1,1045,1045,1,1025,1,4,3,1044,0]

theorem envBound1626 : H12AffineFastState.Bounded env1626 := by
  intro p hp
  have h : env1626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1625_1626 : H12AffineEnvironment.transform 4 3 env1625 = env1626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env1625 == env1626) = true)

theorem identity1626 : scanCanonicalize (H12AffineFastState.compose env1626 (packedSelected [7] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound1626 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1627 : List Nat := [0,4,1,16,1,17,1,4,0,1024,1,1045,1,1044,1,0,1045,1,1024,1,1045,1,16,0,1,17,1,1045,1045,1,1025,1,4,1,1044,0]

theorem envBound1627 : H12AffineFastState.Bounded env1627 := by
  intro p hp
  have h : env1627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1626_1627 : H12AffineEnvironment.transform 0 0 env1626 = env1627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env1626 == env1627) = true)

theorem identity1627 : scanCanonicalize (H12AffineFastState.compose env1627 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound1627 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1628 : List Nat := [0,4,1,16,1,17,1,4,0,4,1,17,1,16,1,0,17,1,4,1,17,1,16,0,1,17,1,17,17,1,5,1,4,1,16,0]

theorem envBound1628 : H12AffineFastState.Bounded env1628 := by
  intro p hp
  have h : env1628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1627_1628 : H12AffineEnvironment.transform 9 4 env1627 = env1628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env1627 == env1628) = true)

def env1629 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,4293121,128,4195093,262657,4195861,4096,106143,4195841,4294967296,256,4299265590,4097,136]

theorem envBound1629 : H12AffineFastState.Bounded env1629 := by
  intro p hp
  have h : env1629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1599_1629 : H12AffineEnvironment.transform 23 4293121 env1599 = env1629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293121 env1599 == env1629) = true)

theorem identity1629 : scanCanonicalize (H12AffineFastState.compose env1629 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1629 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env1630 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,4292744,128,4194716,262280,4195484,4096,105494,4195464,4294967296,256,4299265215,4097,136]

theorem envBound1630 : H12AffineFastState.Bounded env1630 := by
  intro p hp
  have h : env1630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1629_1630 : H12AffineEnvironment.transform 8 137 env1629 = env1630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1629 == env1630) = true)

theorem identity1630 : scanCanonicalize (H12AffineFastState.compose env1630 (packedSelected [0,7,20] rootPS)) = affineNative (2^(21+1) ^^^ 5276) := by decide +kernel

theorem selectedBound1630 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env1631 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4097,32768,65536,4096,262144,1024,32768,4096,5276,5377,103444,128,5376,262280,4096,4096,105494,4116,4294967296,256,4295065635,4097,136]

theorem envBound1631 : H12AffineFastState.Bounded env1631 := by
  intro p hp
  have h : env1631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1630_1631 : H12AffineEnvironment.transform 21 5276 env1630 = env1631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5276 env1630 == env1631) = true)

theorem identity1631 : scanCanonicalize (H12AffineFastState.compose env1631 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 295075) := by decide +kernel

theorem selectedBound1631 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1632 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4097,32768,65536,4096,262144,1024,32768,4096,5276,5377,103444,128,5376,262280,4096,4096,105494,4116,295075,256,327808,4097,136]

theorem envBound1632 : H12AffineFastState.Bounded env1632 := by
  intro p hp
  have h : env1632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1631_1632 : H12AffineEnvironment.transform 31 295075 env1631 = env1632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 295075 env1631 == env1632) = true)

def env1633 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897044,4097,20978847,16876544,4294967296,256,4332832438,4096,33554440]

theorem envBound1633 : H12AffineFastState.Bounded env1633 := by
  intro p hp
  have h : env1633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1581_1633 : H12AffineEnvironment.transform 16 4097 env1581 = env1633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1581 == env1633) = true)

theorem identity1633 : scanCanonicalize (H12AffineFastState.compose env1633 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 17809) := by decide +kernel

theorem selectedBound1633 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1634 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,17809,16875797,21352449,16897044,4097,20978847,16876544,4294967296,256,4299260711,4096,17817]

theorem envBound1634 : H12AffineFastState.Bounded env1634 := by
  intro p hp
  have h : env1634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1633_1634 : H12AffineEnvironment.transform 24 17809 env1633 = env1634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17809 env1633 == env1634) = true)

def env1635 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,17809,16875797,21352449,16897044,4097,20978847,16876544,4294967296,256,4299260335,4096,17817]

theorem envBound1635 : H12AffineFastState.Bounded env1635 := by
  intro p hp
  have h : env1635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1634_1635 : H12AffineEnvironment.transform 8 136 env1634 = env1635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1634 == env1635) = true)

theorem identity1635 : scanCanonicalize (H12AffineFastState.compose env1635 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 119045) := by decide +kernel

theorem selectedBound1635 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1636 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,119045,17809,20496,4456708,1297,4097,4312474,21765,4294967296,256,4299260335,4096,17817]

theorem envBound1636 : H12AffineFastState.Bounded env1636 := by
  intro p hp
  have h : env1636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1635_1636 : H12AffineEnvironment.transform 23 119045 env1635 = env1636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 119045 env1635 == env1636) = true)

theorem identity1636 : scanCanonicalize (H12AffineFastState.compose env1636 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1636 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1637 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,103445,129,5376,4456708,1297,4097,4294794,4117,4294967296,256,4299260335,4096,137]

theorem envBound1637 : H12AffineFastState.Bounded env1637 := by
  intro p hp
  have h : env1637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1636_1637 : H12AffineEnvironment.transform 13 1296 env1636 = env1637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env1636 == env1637) = true)

theorem identity1637 : scanCanonicalize (H12AffineFastState.compose env1637 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound1637 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env1638 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,65536,4097,262144,1024,261,4096,4194304,16,70928,129,5376,4456708,1297,4097,4262287,4117,4294967296,256,4299227306,4096,137]

theorem envBound1638 : H12AffineFastState.Bounded env1638 := by
  intro p hp
  have h : env1638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1637_1638 : H12AffineEnvironment.transform 14 261 env1637 = env1638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env1637 == env1638) = true)

theorem identity1638 : scanCanonicalize (H12AffineFastState.compose env1638 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4527537) := by decide +kernel

theorem selectedBound1638 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1639 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,65536,4097,262144,1024,261,4096,4194304,16,70928,129,5376,4456708,1297,4097,4262287,4117,4527537,256,267547,4096,137]

theorem envBound1639 : H12AffineFastState.Bounded env1639 := by
  intro p hp
  have h : env1639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1638_1639 : H12AffineEnvironment.transform 31 4527537 env1638 = env1639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4527537 env1638 == env1639) = true)

theorem identity1639 : scanCanonicalize (H12AffineFastState.compose env1639 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound1639 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1640 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,262144,1024,261,4096,4194304,16,5530,129,5376,4456708,1297,4097,4196613,4117,4461883,256,267547,4096,137]

theorem envBound1640 : H12AffineFastState.Bounded env1640 := by
  intro p hp
  have h : env1640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1639_1640 : H12AffineEnvironment.transform 15 138 env1639 = env1640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env1639 == env1640) = true)

theorem identity1640 : scanCanonicalize (H12AffineFastState.compose env1640 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound1640 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env1641 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,7220,1024,261,4096,4194304,16,5530,129,5376,4201776,1297,4097,4196613,4117,4196623,256,2351,4096,137]

theorem envBound1641 : H12AffineFastState.Bounded env1641 := by
  intro p hp
  have h : env1641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1640_1641 : H12AffineEnvironment.transform 17 7220 env1640 = env1641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env1640 == env1641) = true)

def env1642 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,7220,1024,261,4096,5408,16,5530,129,5376,2064,1297,4097,7205,4117,7215,256,2351,4096,137]

theorem envBound1642 : H12AffineFastState.Bounded env1642 := by
  intro p hp
  have h : env1642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1641_1642 : H12AffineEnvironment.transform 21 5408 env1641 = env1642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1641 == env1642) = true)

theorem identity1642 : scanCanonicalize (H12AffineFastState.compose env1642 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 1427) := by decide +kernel

theorem selectedBound1642 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1643 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1427,8,1296,261,138,1426,2471,1024,261,1427,179,16,9,129,147,2064,1297,1426,2486,1414,2492,256,2351,1427,137]

theorem envBound1643 : H12AffineFastState.Bounded env1643 := by
  intro p hp
  have h : env1643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1642_1643 : H12AffineEnvironment.transform 11 1427 env1642 = env1643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1427 env1642 == env1643) = true)

theorem identity1643 : scanCanonicalize (H12AffineFastState.compose env1643 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound1643 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1644 : List Nat := [2,4,8,16,32,17,128,256,136,1024,26,1427,8,1296,261,138,1426,445,1024,261,1427,179,16,9,129,147,10,1297,1426,428,1414,422,256,309,1427,137]

theorem envBound1644 : H12AffineFastState.Bounded env1644 := by
  intro p hp
  have h : env1644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1643_1644 : H12AffineEnvironment.transform 10 26 env1643 = env1644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env1643 == env1644) = true)

def env1645 : List Nat := [2,4,8,16,32,17,128,20,136,1024,26,1159,8,1028,17,138,1158,169,1024,17,1159,179,16,9,129,147,10,1029,1158,184,1170,178,20,33,1159,137]

theorem envBound1645 : H12AffineFastState.Bounded env1645 := by
  intro p hp
  have h : env1645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1644_1645 : H12AffineEnvironment.transform 7 20 env1644 = env1645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1644 == env1645) = true)

theorem identity1645 : scanCanonicalize (H12AffineFastState.compose env1645 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1645 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1646 : List Nat := [2,4,8,16,32,17,35,20,43,1024,26,1060,8,1028,17,41,1061,10,1024,17,1060,16,16,9,34,48,10,1029,1061,27,1073,17,20,33,1060,42]

theorem envBound1646 : H12AffineFastState.Bounded env1646 := by
  intro p hp
  have h : env1646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1645_1646 : H12AffineEnvironment.transform 6 35 env1645 = env1646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1645 == env1646) = true)

theorem identity1646 : scanCanonicalize (H12AffineFastState.compose env1646 (packedSelected [0,2,5] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1646 : packedSelected [0,2,5] rootPS < 2^1333 := by decide +kernel

def env1647 : List Nat := [2,4,3,16,32,17,35,20,32,1024,17,1060,3,1028,17,34,1061,1,1024,17,1060,16,16,2,34,48,1,1029,1061,16,1073,17,20,33,1060,33]

theorem envBound1647 : H12AffineFastState.Bounded env1647 := by
  intro p hp
  have h : env1647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1646_1647 : H12AffineEnvironment.transform 2 3 env1646 = env1647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1646 == env1647) = true)

theorem identity1647 : scanCanonicalize (H12AffineFastState.compose env1647 (packedSelected [0,2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound1647 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1648 : List Nat := [2,4,3,16,1,17,2,20,1,1024,17,1029,3,1028,17,3,1028,1,1024,17,1029,16,16,2,3,17,1,1029,1028,16,1040,17,20,0,1029,0]

theorem envBound1648 : H12AffineFastState.Bounded env1648 := by
  intro p hp
  have h : env1648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1647_1648 : H12AffineEnvironment.transform 4 1 env1647 = env1648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1647 == env1648) = true)

theorem identity1648 : scanCanonicalize (H12AffineFastState.compose env1648 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1648 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1649 : List Nat := [2,4,3,0,1,1,2,4,1,1024,1,1029,3,1028,1,3,1028,1,1024,1,1029,0,0,2,3,1,1,1029,1028,0,1024,1,4,0,1029,0]

theorem envBound1649 : H12AffineFastState.Bounded env1649 := by
  intro p hp
  have h : env1649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1648_1649 : H12AffineEnvironment.transform 3 0 env1648 = env1649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1648 == env1649) = true)

def env1650 : List Nat := [2,4,8,16,32,17,128,21,136,1024,26,1158,8,1029,16,138,1159,168,1024,16,1158,179,16,9,129,147,10,1028,1159,185,1171,179,21,32,1158,137]

theorem envBound1650 : H12AffineFastState.Bounded env1650 := by
  intro p hp
  have h : env1650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1644_1650 : H12AffineEnvironment.transform 7 21 env1644 = env1650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1644 == env1650) = true)

theorem identity1650 : scanCanonicalize (H12AffineFastState.compose env1650 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1650 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1651 : List Nat := [2,4,8,16,0,17,128,21,136,1024,26,1158,8,1029,16,138,1159,136,1024,16,1158,147,16,9,129,147,10,1028,1159,153,1171,147,21,0,1158,137]

theorem envBound1651 : H12AffineFastState.Bounded env1651 := by
  intro p hp
  have h : env1651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1650_1651 : H12AffineEnvironment.transform 4 0 env1650 = env1651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1650 == env1651) = true)

theorem identity1651 : scanCanonicalize (H12AffineFastState.compose env1651 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1651 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1652 : List Nat := [2,4,8,11,0,10,128,14,136,1024,1,1158,8,1029,11,138,1159,136,1024,11,1158,136,11,9,129,136,10,1028,1159,130,1160,136,14,0,1158,137]

theorem envBound1652 : H12AffineFastState.Bounded env1652 := by
  intro p hp
  have h : env1652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1651_1652 : H12AffineEnvironment.transform 3 11 env1651 = env1652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1651 == env1652) = true)

theorem identity1652 : scanCanonicalize (H12AffineFastState.compose env1652 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1652 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1653 : List Nat := [2,4,8,11,0,10,2,14,10,1024,1,1028,8,1029,11,8,1029,10,1024,11,1028,10,11,9,3,10,10,1028,1029,0,1034,10,14,0,1028,11]

theorem envBound1653 : H12AffineFastState.Bounded env1653 := by
  intro p hp
  have h : env1653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1652_1653 : H12AffineEnvironment.transform 6 2 env1652 = env1653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1652 == env1653) = true)

theorem identity1653 : scanCanonicalize (H12AffineFastState.compose env1653 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1653 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1654 : List Nat := [2,4,3,0,0,1,2,5,1,1024,1,1028,3,1029,0,3,1029,1,1024,0,1028,1,0,2,3,1,1,1028,1029,0,1025,1,5,0,1028,0]

theorem envBound1654 : H12AffineFastState.Bounded env1654 := by
  intro p hp
  have h : env1654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1653_1654 : H12AffineEnvironment.transform 2 3 env1653 = env1654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1653 == env1654) = true)

def env1655 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,7220,1024,261,4096,5409,16,5530,129,5376,2065,1297,4097,7204,4117,7214,256,2351,4096,137]

theorem envBound1655 : H12AffineFastState.Bounded env1655 := by
  intro p hp
  have h : env1655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1641_1655 : H12AffineEnvironment.transform 21 5409 env1641 = env1655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1641 == env1655) = true)

theorem identity1655 : scanCanonicalize (H12AffineFastState.compose env1655 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1655 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1656 : List Nat := [2,4,8,16,32,17,3,256,11,1024,2048,4096,8,1296,261,9,4097,7220,1024,261,4096,5409,16,5401,2,5376,2065,1297,4097,7204,4117,7214,256,2351,4096,10]

theorem envBound1656 : H12AffineFastState.Bounded env1656 := by
  intro p hp
  have h : env1656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1655_1656 : H12AffineEnvironment.transform 6 3 env1655 = env1656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1655 == env1656) = true)

theorem identity1656 : scanCanonicalize (H12AffineFastState.compose env1656 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 27) := by decide +kernel

theorem selectedBound1656 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1657 : List Nat := [2,4,8,16,32,17,3,256,11,1024,27,4096,8,1296,261,9,4097,5167,1024,261,4096,5409,16,5401,2,5376,10,1297,4097,5183,4117,5173,256,308,4096,10]

theorem envBound1657 : H12AffineFastState.Bounded env1657 := by
  intro p hp
  have h : env1657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1656_1657 : H12AffineEnvironment.transform 10 27 env1656 = env1657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 27 env1656 == env1657) = true)

def env1658 : List Nat := [2,4,8,16,32,17,3,256,11,1024,27,1296,8,1296,261,9,1297,319,1024,261,1296,49,16,9,2,16,10,1297,1297,303,1285,293,256,308,1296,10]

theorem envBound1658 : H12AffineFastState.Bounded env1658 := by
  intro p hp
  have h : env1658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1657_1658 : H12AffineEnvironment.transform 11 1296 env1657 = env1658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1657 == env1658) = true)

theorem identity1658 : scanCanonicalize (H12AffineFastState.compose env1658 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1658 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1659 : List Nat := [2,4,8,16,0,17,3,256,11,1024,27,1296,8,1296,261,9,1297,287,1024,261,1296,17,16,9,2,16,10,1297,1297,271,1285,261,256,276,1296,10]

theorem envBound1659 : H12AffineFastState.Bounded env1659 := by
  intro p hp
  have h : env1659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1658_1659 : H12AffineEnvironment.transform 4 0 env1658 = env1659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1658 == env1659) = true)

theorem identity1659 : scanCanonicalize (H12AffineFastState.compose env1659 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound1659 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1660 : List Nat := [2,4,8,16,0,17,3,31,11,1024,27,1039,8,1039,26,9,1038,0,1024,26,1039,17,16,9,2,16,10,1038,1038,16,1050,26,31,11,1039,10]

theorem envBound1660 : H12AffineFastState.Bounded env1660 := by
  intro p hp
  have h : env1660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1659_1660 : H12AffineEnvironment.transform 7 31 env1659 = env1660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env1659 == env1660) = true)

theorem identity1660 : scanCanonicalize (H12AffineFastState.compose env1660 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1660 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1661 : List Nat := [2,4,8,0,0,1,3,15,11,1024,11,1039,8,1039,10,9,1038,0,1024,10,1039,1,0,9,2,0,10,1038,1038,0,1034,10,15,11,1039,10]

theorem envBound1661 : H12AffineFastState.Bounded env1661 := by
  intro p hp
  have h : env1661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1660_1661 : H12AffineEnvironment.transform 3 0 env1660 = env1661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1660 == env1661) = true)

theorem identity1661 : scanCanonicalize (H12AffineFastState.compose env1661 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1661 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1662 : List Nat := [2,4,2,0,0,1,3,5,1,1024,1,1029,2,1029,0,3,1028,0,1024,0,1029,1,0,3,2,0,0,1028,1028,0,1024,0,5,1,1029,0]

theorem envBound1662 : H12AffineFastState.Bounded env1662 := by
  intro p hp
  have h : env1662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1661_1662 : H12AffineEnvironment.transform 2 2 env1661 = env1662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1661 == env1662) = true)

def leafEnv1662 : List Nat := [2,4,2,0,0,1,3,5,1,1024,1,1029,2,1029,0,3,1028,0,1024,0,1029,1,0,3,1024,2,1,0,0,1028,1028,0,1024,0,5,1,4,3,1029,0,0,1028,1]

def active1662 : List Nat := [0,1,9]

def tree1662 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1662 : H12WitnessSearch.Good tree1662 := H12GlobalWitnessIndex.good

theorem leafIdentity1662 : H12AffineFastState.composeSystem env1662 rootObs = leafEnv1662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1662 rootObs == leafEnv1662) = true)

theorem terminalChecked1662 : H12PackedTerminal.terminalCheckFast leafEnv1662 active1662 tree1662 = true := by decide +kernel

def env1663 : List Nat := [2,4,8,16,32,17,3,256,11,1024,27,1297,8,1296,261,9,1296,318,1024,261,1297,48,16,8,2,17,10,1297,1296,302,1284,292,256,308,1297,10]

theorem envBound1663 : H12AffineFastState.Bounded env1663 := by
  intro p hp
  have h : env1663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1657_1663 : H12AffineEnvironment.transform 11 1297 env1657 = env1663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1657 == env1663) = true)

theorem identity1663 : scanCanonicalize (H12AffineFastState.compose env1663 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound1663 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1664 : List Nat := [2,4,8,16,32,17,3,52,11,1024,27,1061,8,1060,49,9,1060,10,1024,49,1061,48,16,8,2,17,10,1061,1060,26,1072,16,52,0,1061,10]

theorem envBound1664 : H12AffineFastState.Bounded env1664 := by
  intro p hp
  have h : env1664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1663_1664 : H12AffineEnvironment.transform 7 52 env1663 = env1664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env1663 == env1664) = true)

theorem identity1664 : scanCanonicalize (H12AffineFastState.compose env1664 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound1664 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1665 : List Nat := [2,4,8,16,11,17,3,31,11,1024,27,1038,8,1039,26,9,1039,10,1024,26,1038,27,16,8,2,17,10,1038,1039,26,1051,16,31,0,1038,10]

theorem envBound1665 : H12AffineFastState.Bounded env1665 := by
  intro p hp
  have h : env1665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1664_1665 : H12AffineEnvironment.transform 4 11 env1664 = env1665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env1664 == env1665) = true)

theorem identity1665 : scanCanonicalize (H12AffineFastState.compose env1665 (packedSelected [10] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1665 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1666 : List Nat := [2,4,8,0,11,1,3,15,11,1024,11,1038,8,1039,10,9,1039,10,1024,10,1038,11,0,8,2,1,10,1038,1039,10,1035,0,15,0,1038,10]

theorem envBound1666 : H12AffineFastState.Bounded env1666 := by
  intro p hp
  have h : env1666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1665_1666 : H12AffineEnvironment.transform 3 0 env1665 = env1666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1665 == env1666) = true)

def env1667 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,17809,16875797,21352449,16897044,4097,20978847,16876544,4294967296,256,4299260334,4096,17817]

theorem envBound1667 : H12AffineFastState.Bounded env1667 := by
  intro p hp
  have h : env1667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1634_1667 : H12AffineEnvironment.transform 8 137 env1634 = env1667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1634 == env1667) = true)

theorem identity1667 : scanCanonicalize (H12AffineFastState.compose env1667 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound1667 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1668 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4097,32768,65536,4097,262144,1024,32768,4096,4194304,5377,16777216,5520,16875797,21331968,16876565,4097,20978847,16876544,4294967296,256,4299260334,4096,5528]

theorem envBound1668 : H12AffineFastState.Bounded env1668 := by
  intro p hp
  have h : env1668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1667_1668 : H12AffineEnvironment.transform 13 4097 env1667 = env1668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1667 == env1668) = true)

theorem identity1668 : scanCanonicalize (H12AffineFastState.compose env1668 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(23+1) ^^^ 103445) := by decide +kernel

theorem selectedBound1668 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1669 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4097,32768,65536,4097,262144,1024,32768,4096,4194304,5377,103445,5520,5376,4461589,4096,4097,4294794,4117,4294967296,256,4299260334,4096,5528]

theorem envBound1669 : H12AffineFastState.Bounded env1669 := by
  intro p hp
  have h : env1669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1668_1669 : H12AffineEnvironment.transform 23 103445 env1668 = env1669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103445 env1668 == env1669) = true)

theorem identity1669 : scanCanonicalize (H12AffineFastState.compose env1669 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound1669 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env1670 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4097,32768,33166,4097,262144,1024,32768,4096,4194304,5377,5531,5520,5376,4461589,4096,4097,4196612,4117,4294967296,256,4299161632,4096,5528]

theorem envBound1670 : H12AffineFastState.Bounded env1670 := by
  intro p hp
  have h : env1670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1669_1670 : H12AffineEnvironment.transform 15 33166 env1669 = env1670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env1669 == env1670) = true)

theorem identity1670 : scanCanonicalize (H12AffineFastState.compose env1670 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1670 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1671 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,32768,33166,1297,262144,1024,32768,1296,4194304,17,139,128,16,4456709,1296,1297,4196612,1285,4294967296,256,4299161632,1296,136]

theorem envBound1671 : H12AffineFastState.Bounded env1671 := by
  intro p hp
  have h : env1671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1670_1671 : H12AffineEnvironment.transform 11 1296 env1670 = env1671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1670 == env1671) = true)

theorem identity1671 : scanCanonicalize (H12AffineFastState.compose env1671 (packedSelected [1,3] rootPS)) = affineNative (2^(17+1) ^^^ 2048) := by decide +kernel

theorem selectedBound1671 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1672 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,32768,33166,1297,2048,1024,32768,1296,4194304,17,139,128,16,4196613,1296,1297,4196612,1285,4294967296,256,4299161632,1296,136]

theorem envBound1672 : H12AffineFastState.Bounded env1672 := by
  intro p hp
  have h : env1672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1671_1672 : H12AffineEnvironment.transform 17 2048 env1671 = env1672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2048 env1671 == env1672) = true)

theorem identity1672 : scanCanonicalize (H12AffineFastState.compose env1672 (packedSelected [5] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1672 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1673 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,2340,2218,1297,2048,1024,2340,1296,4194304,17,139,128,16,4196613,1296,1297,4196612,1285,4294967296,256,4299161632,1296,136]

theorem envBound1673 : H12AffineFastState.Bounded env1673 := by
  intro p hp
  have h : env1673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1672_1673 : H12AffineEnvironment.transform 14 2340 env1672 = env1673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env1672 == env1673) = true)

theorem identity1673 : scanCanonicalize (H12AffineFastState.compose env1673 (packedSelected [0,7] rootPS)) = affineNative (2^(21+1) ^^^ 261) := by decide +kernel

theorem selectedBound1673 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1674 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,2340,2218,1297,2048,1024,2340,1296,261,17,139,128,16,2048,1296,1297,2049,1285,4294967296,256,4294967589,1296,136]

theorem envBound1674 : H12AffineFastState.Bounded env1674 := by
  intro p hp
  have h : env1674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1673_1674 : H12AffineEnvironment.transform 21 261 env1673 = env1674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 261 env1673 == env1674) = true)

theorem identity1674 : scanCanonicalize (H12AffineFastState.compose env1674 (packedSelected [1,12] rootPS)) = affineNative (2^(31+1) ^^^ 309) := by decide +kernel

theorem selectedBound1674 : packedSelected [1,12] rootPS < 2^1333 := by decide +kernel

def env1675 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,2340,2218,1297,2048,1024,2340,1296,261,17,139,128,16,2048,1296,1297,2049,1285,309,256,16,1296,136]

theorem envBound1675 : H12AffineFastState.Bounded env1675 := by
  intro p hp
  have h : env1675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1674_1675 : H12AffineEnvironment.transform 31 309 env1674 = env1675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 309 env1674 == env1675) = true)

theorem identity1675 : scanCanonicalize (H12AffineFastState.compose env1675 (packedSelected [1,15] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound1675 : packedSelected [1,15] rootPS < 2^1333 := by decide +kernel

def env1676 : List Nat := [2,4,8,16,32,17,128,256,137,1024,261,1296,9,1297,33,431,1297,261,1024,33,1296,261,17,139,128,16,261,1296,1297,260,1285,309,256,16,1296,136]

theorem envBound1676 : H12AffineFastState.Bounded env1676 := by
  intro p hp
  have h : env1676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1675_1676 : H12AffineEnvironment.transform 10 261 env1675 = env1676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env1675 == env1676) = true)

def env1677 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010964,21352449,17024021,131072,21105822,16876544,4294967296,256,4332967606,131073,33554441]

theorem envBound1677 : H12AffineFastState.Bounded env1677 := by
  intro p hp
  have h : env1677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1580_1677 : H12AffineEnvironment.transform 12 641 env1580 = env1677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env1580 == env1677) = true)

def env1678 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897045,4096,20978846,16876544,4294967296,256,4332832438,4097,33554441]

theorem envBound1678 : H12AffineFastState.Bounded env1678 := by
  intro p hp
  have h : env1678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1677_1678 : H12AffineEnvironment.transform 16 4096 env1677 = env1678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1677 == env1678) = true)

theorem identity1678 : scanCanonicalize (H12AffineFastState.compose env1678 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(13+1) ^^^ 4744) := by decide +kernel

theorem selectedBound1678 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1679 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,4744,32768,65536,4096,262144,1024,32768,4096,4194304,6024,16777216,33554432,16875796,21332617,16877213,4096,20978846,16876544,4294967296,256,4332819518,4097,33554441]

theorem envBound1679 : H12AffineFastState.Bounded env1679 := by
  intro p hp
  have h : env1679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1678_1679 : H12AffineEnvironment.transform 13 4744 env1678 = env1679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4744 env1678 == env1679) = true)

def env1680 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,16777216,33554432,16875796,21331969,16876565,4096,20978846,16876544,4294967296,256,4332819518,4097,33554441]

theorem envBound1680 : H12AffineFastState.Bounded env1680 := by
  intro p hp
  have h : env1680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1679_1680 : H12AffineEnvironment.transform 8 136 env1679 = env1680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1679 == env1680) = true)

theorem identity1680 : scanCanonicalize (H12AffineFastState.compose env1680 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(23+1) ^^^ 138) := by decide +kernel

theorem selectedBound1680 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env1681 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,138,33554432,98718,4554891,99487,4096,4201492,99466,4294967296,256,4332819518,4097,33554441]

theorem envBound1681 : H12AffineFastState.Bounded env1681 := by
  intro p hp
  have h : env1681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1680_1681 : H12AffineEnvironment.transform 23 138 env1680 = env1681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 138 env1680 == env1681) = true)

theorem identity1681 : scanCanonicalize (H12AffineFastState.compose env1681 (packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS)) = affineNative (2^(24+1) ^^^ 128) := by decide +kernel

theorem selectedBound1681 : packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS < 2^1333 := by decide +kernel

def env1682 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,138,128,98718,4554891,99487,4096,4201492,99466,4294967296,256,4299265214,4097,137]

theorem envBound1682 : H12AffineFastState.Bounded env1682 := by
  intro p hp
  have h : env1682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1681_1682 : H12AffineEnvironment.transform 24 128 env1681 = env1682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env1681 == env1682) = true)

theorem identity1682 : scanCanonicalize (H12AffineFastState.compose env1682 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(15+1) ^^^ 38046) := by decide +kernel

theorem selectedBound1682 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env1683 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4096,32768,38046,4096,262144,1024,32768,4096,4194304,5376,138,128,5376,4461589,4097,4096,4201492,4116,4294967296,256,4299161632,4097,137]

end H12GlobalChart2