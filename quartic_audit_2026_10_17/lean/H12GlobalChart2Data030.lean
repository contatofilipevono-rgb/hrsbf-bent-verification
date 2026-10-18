import H12GlobalChart2Data029

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound7345 : H12AffineFastState.Bounded env7345 := by
  intro p hp
  have h : env7345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7344_7345 : H12AffineEnvironment.transform 11 1296 env7344 = env7345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7344 == env7345) = true)

theorem identity7345 : scanCanonicalize (H12AffineFastState.compose env7345 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 2478) := by decide +kernel

theorem selectedBound7345 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7346 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,2478,1297,262144,1025,32768,1296,396,17,34986,129,17,262281,1296,1296,32936,1284,295074,257,264494,1296,136]

theorem envBound7346 : H12AffineFastState.Bounded env7346 := by
  intro p hp
  have h : env7346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7345_7346 : H12AffineEnvironment.transform 15 2478 env7345 = env7346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2478 env7345 == env7346) = true)

theorem identity7346 : scanCanonicalize (H12AffineFastState.compose env7346 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound7346 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env7347 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,2478,1297,34849,1025,32768,1296,396,17,34986,129,17,34984,1296,1296,32936,1284,2179,257,33039,1296,136]

theorem envBound7347 : H12AffineFastState.Bounded env7347 := by
  intro p hp
  have h : env7347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7346_7347 : H12AffineEnvironment.transform 17 34849 env7346 = env7347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env7346 == env7347) = true)

theorem identity7347 : scanCanonicalize (H12AffineFastState.compose env7347 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 270) := by decide +kernel

theorem selectedBound7347 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7348 : List Nat := [2,4,8,16,32,17,128,256,137,1024,270,1296,8,1297,32768,160,1297,33071,1025,32768,1296,396,17,33188,129,17,33190,1296,1296,32936,1284,397,257,33039,1296,136]

theorem envBound7348 : H12AffineFastState.Bounded env7348 := by
  intro p hp
  have h : env7348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7347_7348 : H12AffineEnvironment.transform 10 270 env7347 = env7348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 270 env7347 == env7348) = true)

theorem identity7348 : scanCanonicalize (H12AffineFastState.compose env7348 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 167) := by decide +kernel

theorem selectedBound7348 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env7349 : List Nat := [2,4,8,16,32,17,128,167,137,1024,169,1207,8,1206,32768,160,1206,32904,1025,32768,1207,43,17,32771,129,17,32769,1207,1207,32936,1187,42,166,32936,1207,136]

theorem envBound7349 : H12AffineFastState.Bounded env7349 := by
  intro p hp
  have h : env7349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7348_7349 : H12AffineEnvironment.transform 7 167 env7348 = env7349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 167 env7348 == env7349) = true)

theorem identity7349 : scanCanonicalize (H12AffineFastState.compose env7349 (packedSelected [3,13] rootPS)) = affineNative (2^(14+1) ^^^ 162) := by decide +kernel

theorem selectedBound7349 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env7350 : List Nat := [2,4,8,16,32,17,128,167,137,1024,169,1207,8,1206,162,160,1206,42,1025,162,1207,43,17,161,129,17,163,1207,1207,10,1187,42,166,10,1207,136]

theorem envBound7350 : H12AffineFastState.Bounded env7350 := by
  intro p hp
  have h : env7350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7349_7350 : H12AffineEnvironment.transform 14 162 env7349 = env7350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 162 env7349 == env7350) = true)

theorem identity7350 : scanCanonicalize (H12AffineFastState.compose env7350 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound7350 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7351 : List Nat := [2,4,8,16,32,17,57,30,48,1024,16,1038,8,1039,27,25,1039,42,1025,27,1038,43,17,24,56,17,26,1038,1038,10,1050,42,31,10,1038,49]

theorem envBound7351 : H12AffineFastState.Bounded env7351 := by
  intro p hp
  have h : env7351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7350_7351 : H12AffineEnvironment.transform 6 57 env7350 = env7351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env7350 == env7351) = true)

theorem identity7351 : scanCanonicalize (H12AffineFastState.compose env7351 (packedSelected [7] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7351 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7352 : List Nat := [2,4,8,11,32,10,34,5,43,1024,11,1038,8,1039,0,2,1039,42,1025,0,1038,43,10,3,35,10,1,1038,1038,10,1025,42,4,10,1038,42]

theorem envBound7352 : H12AffineFastState.Bounded env7352 := by
  intro p hp
  have h : env7352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7351_7352 : H12AffineEnvironment.transform 3 11 env7351 = env7352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7351 == env7352) = true)

theorem identity7352 : scanCanonicalize (H12AffineFastState.compose env7352 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7352 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7353 : List Nat := [2,4,2,1,32,0,34,5,33,1024,1,1028,2,1029,0,2,1029,32,1025,0,1028,33,0,3,35,0,1,1028,1028,0,1025,32,4,0,1028,32]

theorem envBound7353 : H12AffineFastState.Bounded env7353 := by
  intro p hp
  have h : env7353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7352_7353 : H12AffineEnvironment.transform 2 2 env7352 = env7353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7352 == env7353) = true)

theorem identity7353 : scanCanonicalize (H12AffineFastState.compose env7353 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound7353 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7354 : List Nat := [2,4,2,1,1,0,3,5,0,1024,1,1028,2,1029,0,2,1029,1,1025,0,1028,0,0,3,2,0,1,1028,1028,0,1025,1,4,0,1028,1]

theorem envBound7354 : H12AffineFastState.Bounded env7354 := by
  intro p hp
  have h : env7354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7353_7354 : H12AffineEnvironment.transform 4 1 env7353 = env7354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7353 == env7354) = true)

def leafEnv7354 : List Nat := [2,4,2,1,1,0,3,5,0,1024,1,1028,2,1029,0,2,1029,1,1025,0,1028,0,0,3,1024,2,1,0,1,1028,1028,0,1025,1,4,0,5,2,1028,1,0,1028,1]

def active7354 : List Nat := [0,1,9]

def tree7354 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7354 : H12WitnessSearch.Good tree7354 := H12GlobalWitnessIndex.good

theorem leafIdentity7354 : H12AffineFastState.composeSystem env7354 rootObs = leafEnv7354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7354 rootObs == leafEnv7354) = true)

theorem terminalChecked7354 : H12PackedTerminal.terminalCheckFast leafEnv7354 active7354 tree7354 = true := by decide +kernel

def env7355 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,16777216,33554432,67108864,21352529,67130624,131153,1073741824,16876545,4294967296,256,4417151347,131073,33563272]

theorem envBound7355 : H12AffineFastState.Bounded env7355 := by
  intro p hp
  have h : env7355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6962_7355 : H12AffineEnvironment.transform 20 4097 env6962 = env7355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env6962 == env7355) = true)

def env7356 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878608,4294967296,537002321,4417151347,694534145,33563272]

theorem envBound7356 : H12AffineFastState.Bounded env7356 := by
  intro p hp
  have h : env7356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6395_7356 : H12AffineEnvironment.transform 34 694534145 env6395 = env7356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534145 env6395 == env7356) = true)

def env7357 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,157794304,1073741824,140788816,4294967296,157663569,4417151347,131073,33563272]

theorem envBound7357 : H12AffineFastState.Bounded env7357 := by
  intro p hp
  have h : env7357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7356_7357 : H12AffineEnvironment.transform 28 157794304 env7356 = env7357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env7356 == env7357) = true)

theorem identity7357 : scanCanonicalize (H12AffineFastState.compose env7357 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 88458576) := by decide +kernel

theorem selectedBound7357 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env7358 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,88458576,67130624,69338448,1073741824,86081792,4294967296,69207041,4417151347,131073,33563272]

theorem envBound7358 : H12AffineFastState.Bounded env7358 := by
  intro p hp
  have h : env7358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7357_7358 : H12AffineEnvironment.transform 26 88458576 env7357 = env7358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 88458576 env7357 == env7358) = true)

def env7359 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,2098432,23445584,2117632,131152,1073741824,16876544,4294967296,257,4352140403,131073,33563272]

theorem envBound7359 : H12AffineFastState.Bounded env7359 := by
  intro p hp
  have h : env7359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7358_7359 : H12AffineEnvironment.transform 25 2098432 env7358 = env7359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 2098432 env7358 == env7359) = true)

theorem identity7359 : scanCanonicalize (H12AffineFastState.compose env7359 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230468) := by decide +kernel

theorem selectedBound7359 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env7360 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,230468,33554432,2098432,6702100,2117632,131152,1073741824,131140,4294967296,257,4335591479,131073,33563272]

theorem envBound7360 : H12AffineFastState.Bounded env7360 := by
  intro p hp
  have h : env7360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7359_7360 : H12AffineEnvironment.transform 23 230468 env7359 = env7360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230468 env7359 == env7360) = true)

def env7361 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17664,230468,33554432,2098432,2518044,2117632,131152,1073741824,131140,4294967296,257,4331391039,131073,33563272]

theorem envBound7361 : H12AffineFastState.Bounded env7361 := by
  intro p hp
  have h : env7361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7360_7361 : H12AffineEnvironment.transform 21 10248 env7360 = env7361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env7360 == env7361) = true)

def env7362 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17664,230468,8328,2098432,2518044,2117632,131152,1073741824,131140,4294967296,257,4297844919,131073,512]

theorem envBound7362 : H12AffineFastState.Bounded env7362 := by
  intro p hp
  have h : env7362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7361_7362 : H12AffineEnvironment.transform 24 8328 env7361 = env7362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env7361 == env7362) = true)

theorem identity7362 : scanCanonicalize (H12AffineFastState.compose env7362 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 2220242) := by decide +kernel

theorem selectedBound7362 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env7363 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17664,230468,8328,2098432,2518044,2117632,131152,2220242,131140,4294967296,257,4297844919,131073,512]

theorem envBound7363 : H12AffineFastState.Bounded env7363 := by
  intro p hp
  have h : env7363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7362_7363 : H12AffineEnvironment.transform 29 2220242 env7362 = env7363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2220242 env7362 == env7363) = true)

theorem identity7363 : scanCanonicalize (H12AffineFastState.compose env7363 (packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 57693) := by decide +kernel

theorem selectedBound7363 : packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env7364 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,57693,10248,17664,230468,8328,58461,429377,45405,131152,65935,131140,4294967296,257,4295690730,131073,512]

theorem envBound7364 : H12AffineFastState.Bounded env7364 := by
  intro p hp
  have h : env7364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7363_7364 : H12AffineEnvironment.transform 20 57693 env7363 = env7364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 57693 env7363 == env7364) = true)

theorem identity7364 : scanCanonicalize (H12AffineFastState.compose env7364 (packedSelected [1,3,6,17,21,24,25,28] rootPS)) = affineNative (2^(14+1) ^^^ 8461) := by decide +kernel

theorem selectedBound7364 : packedSelected [1,3,6,17,21,24,25,28] rootPS < 2^1333 := by decide +kernel

def env7365 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,131072,262144,524288,8461,16464,10248,17664,206153,8328,17744,404556,4176,131152,65935,131140,4294967296,257,4295690730,131073,512]

theorem envBound7365 : H12AffineFastState.Bounded env7365 := by
  intro p hp
  have h : env7365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7364_7365 : H12AffineEnvironment.transform 14 8461 env7364 = env7365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8461 env7364 == env7365) = true)

theorem identity7365 : scanCanonicalize (H12AffineFastState.compose env7365 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(16+1) ^^^ 11460) := by decide +kernel

theorem selectedBound7365 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env7366 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,11460,262144,524288,8461,16464,10248,17664,67981,8328,17744,262280,4176,11412,65935,11392,4294967296,257,4295566638,11461,512]

theorem envBound7366 : H12AffineFastState.Bounded env7366 := by
  intro p hp
  have h : env7366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7365_7366 : H12AffineEnvironment.transform 16 11460 env7365 = env7366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 11460 env7365 == env7366) = true)

def env7367 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,11460,2048,524288,8461,16464,10248,17664,67981,8328,17744,2184,4176,11412,65935,11392,4294967296,257,4295566638,11461,512]

theorem envBound7367 : H12AffineFastState.Bounded env7367 := by
  intro p hp
  have h : env7367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7366_7367 : H12AffineEnvironment.transform 17 2048 env7366 = env7367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2048 env7366 == env7367) = true)

def env7368 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,16384,8461,65536,11340,2048,524288,8461,16464,10248,17664,67845,8192,17744,2048,4176,11292,65799,11272,4294967296,257,4295566638,11341,512]

theorem envBound7368 : H12AffineFastState.Bounded env7368 := by
  intro p hp
  have h : env7368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7367_7368 : H12AffineEnvironment.transform 6 8 env7367 = env7368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7367 == env7368) = true)

theorem identity7368 : scanCanonicalize (H12AffineFastState.compose env7368 (packedSelected [16,20] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound7368 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env7369 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,16384,8461,2082,11340,2048,524288,8461,16464,10248,17664,295,8192,17744,2048,4176,11292,2341,11272,4294967296,257,4295503116,11341,512]

theorem envBound7369 : H12AffineFastState.Bounded env7369 := by
  intro p hp
  have h : env7369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7368_7369 : H12AffineEnvironment.transform 15 2082 env7368 = env7369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env7368 == env7369) = true)

theorem identity7369 : scanCanonicalize (H12AffineFastState.compose env7369 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 15975) := by decide +kernel

theorem selectedBound7369 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env7370 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,16384,8461,2082,11340,2048,524288,8461,16464,10248,17664,295,8192,17744,2048,4176,11292,2341,11272,15975,257,529259,11341,512]

theorem envBound7370 : H12AffineFastState.Bounded env7370 := by
  intro p hp
  have h : env7370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7369_7370 : H12AffineEnvironment.transform 31 15975 env7369 = env7370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 15975 env7369 == env7370) = true)

theorem identity7370 : scanCanonicalize (H12AffineFastState.compose env7370 (packedSelected [11,16,18] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7370 : packedSelected [11,16,18] rootPS < 2^1333 := by decide +kernel

def env7371 : List Nat := [2,4,8,16,32,64,8,37,512,1024,2048,4096,8192,16384,8232,2082,11340,2048,524288,8232,16464,10248,17445,2,8192,17525,2048,4176,11292,2048,11272,15975,36,528974,11341,512]

theorem envBound7371 : H12AffineFastState.Bounded env7371 := by
  intro p hp
  have h : env7371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7370_7371 : H12AffineEnvironment.transform 7 37 env7370 = env7371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7370 == env7371) = true)

theorem identity7371 : scanCanonicalize (H12AffineFastState.compose env7371 (packedSelected [0,1,4,5,7,10,12,22] rootPS)) = affineNative (2^(12+1) ^^^ 2088) := by decide +kernel

theorem selectedBound7371 : packedSelected [0,1,4,5,7,10,12,22] rootPS < 2^1333 := by decide +kernel

def env7372 : List Nat := [2,4,8,16,32,64,8,37,512,1024,2048,4096,2088,16384,2048,2082,1124,2048,524288,2048,16464,32,17445,2,2088,17525,2048,4176,1076,2048,1056,5711,36,528974,1125,512]

theorem envBound7372 : H12AffineFastState.Bounded env7372 := by
  intro p hp
  have h : env7372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7371_7372 : H12AffineEnvironment.transform 12 2088 env7371 = env7372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2088 env7371 == env7372) = true)

theorem identity7372 : scanCanonicalize (H12AffineFastState.compose env7372 (packedSelected [1,3] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound7372 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7373 : List Nat := [2,4,8,16,32,64,8,37,512,1024,2048,4096,2088,16384,2048,2082,1124,2048,1025,2048,16464,32,17445,2,2088,17525,2048,4176,1076,2048,1056,5711,36,5711,1125,512]

theorem envBound7373 : H12AffineFastState.Bounded env7373 := by
  intro p hp
  have h : env7373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7372_7373 : H12AffineEnvironment.transform 18 1025 env7372 = env7373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env7372 == env7373) = true)

theorem identity7373 : scanCanonicalize (H12AffineFastState.compose env7373 (packedSelected [0,2,4] rootPS)) = affineNative (2^(13+1) ^^^ 1125) := by decide +kernel

theorem selectedBound7373 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env7374 : List Nat := [2,4,8,16,32,64,8,37,512,1024,2048,4096,2088,1125,2048,2082,1124,2048,1025,2048,1077,32,64,2,2088,16,2048,4176,1076,2048,1056,5711,36,5711,1125,512]

theorem envBound7374 : H12AffineFastState.Bounded env7374 := by
  intro p hp
  have h : env7374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7373_7374 : H12AffineEnvironment.transform 13 1125 env7373 = env7374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1125 env7373 == env7374) = true)

theorem identity7374 : scanCanonicalize (H12AffineFastState.compose env7374 (packedSelected [2,6] rootPS)) = affineNative (2^(11+1) ^^^ 3636) := by decide +kernel

theorem selectedBound7374 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env7375 : List Nat := [2,4,8,16,32,64,8,37,512,1024,2048,3636,2088,1125,2048,2082,1124,2048,1025,2048,1077,32,64,2,2088,16,2048,3684,1076,2048,1056,2171,36,2171,1125,512]

theorem envBound7375 : H12AffineFastState.Bounded env7375 := by
  intro p hp
  have h : env7375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7374_7375 : H12AffineEnvironment.transform 11 3636 env7374 = env7375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3636 env7374 == env7375) = true)

theorem identity7375 : scanCanonicalize (H12AffineFastState.compose env7375 (packedSelected [0,2,7] rootPS)) = affineNative (2^(10+1) ^^^ 42) := by decide +kernel

theorem selectedBound7375 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env7376 : List Nat := [2,4,8,16,32,64,8,37,512,1024,42,1566,2,1125,42,8,1124,42,1025,42,1077,32,64,2,2,16,42,1614,1076,42,1056,81,36,81,1125,512]

theorem envBound7376 : H12AffineFastState.Bounded env7376 := by
  intro p hp
  have h : env7376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7375_7376 : H12AffineEnvironment.transform 10 42 env7375 = env7376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 42 env7375 == env7376) = true)

theorem identity7376 : scanCanonicalize (H12AffineFastState.compose env7376 (packedSelected [0,2,10] rootPS)) = affineNative (2^(9+1) ^^^ 535) := by decide +kernel

theorem selectedBound7376 : packedSelected [0,2,10] rootPS < 2^1333 := by decide +kernel

def env7377 : List Nat := [2,4,8,16,32,64,8,37,512,535,42,9,2,626,42,8,627,42,534,42,546,32,64,2,2,16,42,89,547,42,567,81,36,81,626,512]

theorem envBound7377 : H12AffineFastState.Bounded env7377 := by
  intro p hp
  have h : env7377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7376_7377 : H12AffineEnvironment.transform 9 535 env7376 = env7377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 535 env7376 == env7377) = true)

theorem identity7377 : scanCanonicalize (H12AffineFastState.compose env7377 (packedSelected [13] rootPS)) = affineNative (2^(8+1) ^^^ 122) := by decide +kernel

theorem selectedBound7377 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env7378 : List Nat := [2,4,8,16,32,64,8,37,122,109,42,9,2,8,42,8,9,42,108,42,88,32,64,2,2,16,42,89,89,42,77,81,36,81,8,122]

theorem envBound7378 : H12AffineFastState.Bounded env7378 := by
  intro p hp
  have h : env7378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7377_7378 : H12AffineEnvironment.transform 8 122 env7377 = env7378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 122 env7377 == env7378) = true)

theorem identity7378 : scanCanonicalize (H12AffineFastState.compose env7378 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7378 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7379 : List Nat := [2,4,2,16,32,64,2,37,112,103,32,3,2,2,32,2,3,32,102,32,82,32,64,2,2,16,32,83,83,32,71,81,36,81,2,112]

theorem envBound7379 : H12AffineFastState.Bounded env7379 := by
  intro p hp
  have h : env7379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7378_7379 : H12AffineEnvironment.transform 2 2 env7378 = env7379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7378 == env7379) = true)

def env7380 : List Nat := [2,4,2,16,0,64,2,5,80,71,0,3,2,2,0,2,3,0,70,0,82,0,64,2,2,16,0,83,83,0,71,81,4,81,2,80]

theorem envBound7380 : H12AffineFastState.Bounded env7380 := by
  intro p hp
  have h : env7380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7379_7380 : H12AffineEnvironment.transform 4 0 env7379 = env7380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7379 == env7380) = true)

theorem identity7380 : scanCanonicalize (H12AffineFastState.compose env7380 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound7380 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7381 : List Nat := [2,4,2,2,0,64,2,5,66,71,0,3,2,2,0,2,3,0,70,0,64,0,64,2,2,2,0,65,65,0,71,67,4,67,2,66]

theorem envBound7381 : H12AffineFastState.Bounded env7381 := by
  intro p hp
  have h : env7381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7380_7381 : H12AffineEnvironment.transform 3 2 env7380 = env7381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env7380 == env7381) = true)

def leafEnv7381 : List Nat := [2,4,2,2,0,64,2,5,66,71,0,3,2,2,0,2,3,0,70,0,64,0,64,2,70,2,1,2,0,65,65,0,71,67,4,67,5,2,2,66,0,64,1]

def active7381 : List Nat := [0,1,5]

def tree7381 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7381 : H12WitnessSearch.Good tree7381 := H12GlobalWitnessIndex.good

theorem leafIdentity7381 : H12AffineFastState.composeSystem env7381 rootObs = leafEnv7381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7381 rootObs == leafEnv7381) = true)

theorem terminalChecked7381 : H12PackedTerminal.terminalCheckFast leafEnv7381 active7381 tree7381 = true := by decide +kernel

def env7382 : List Nat := [2,4,2,16,1,64,2,4,81,70,1,3,2,2,1,2,3,1,71,1,82,1,64,2,2,16,1,83,83,1,71,81,5,81,2,81]

theorem envBound7382 : H12AffineFastState.Bounded env7382 := by
  intro p hp
  have h : env7382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7379_7382 : H12AffineEnvironment.transform 4 1 env7379 = env7382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7379 == env7382) = true)

theorem identity7382 : scanCanonicalize (H12AffineFastState.compose env7382 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 2) := by decide +kernel

theorem selectedBound7382 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7383 : List Nat := [2,4,2,16,1,2,2,4,19,4,1,3,2,2,1,2,3,1,5,1,16,1,2,2,2,16,1,17,17,1,5,19,5,19,2,19]

theorem envBound7383 : H12AffineFastState.Bounded env7383 := by
  intro p hp
  have h : env7383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7382_7383 : H12AffineEnvironment.transform 5 2 env7382 = env7383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 2 env7382 == env7383) = true)

def leafEnv7383 : List Nat := [2,4,2,16,1,2,2,4,19,4,1,3,2,2,1,2,3,1,5,1,16,1,2,2,4,2,1,16,1,17,17,1,5,19,5,19,5,2,2,19,0,16,1]

def active7383 : List Nat := [0,1,3]

def tree7383 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7383 : H12WitnessSearch.Good tree7383 := H12GlobalWitnessIndex.good

theorem leafIdentity7383 : H12AffineFastState.composeSystem env7383 rootObs = leafEnv7383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7383 rootObs == leafEnv7383) = true)

theorem terminalChecked7383 : H12PackedTerminal.terminalCheckFast leafEnv7383 active7383 tree7383 = true := by decide +kernel

def env7384 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,4096,8192,16384,8461,65536,11341,2048,524288,8461,16464,10248,17664,67844,8193,17744,2049,4176,11293,65798,11273,4294967296,257,4295566638,11340,512]

theorem envBound7384 : H12AffineFastState.Bounded env7384 := by
  intro p hp
  have h : env7384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7367_7384 : H12AffineEnvironment.transform 6 9 env7367 = env7384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7367 == env7384) = true)

theorem identity7384 : scanCanonicalize (H12AffineFastState.compose env7384 (packedSelected [16,20] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7384 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env7385 : List Nat := [2,4,8,16,32,64,9,37,512,1024,2048,4096,8192,16384,8232,65536,11341,2048,524288,8232,16464,10248,17445,67617,8193,17525,2049,4176,11293,65571,11273,4294967296,36,4295566347,11340,512]

theorem envBound7385 : H12AffineFastState.Bounded env7385 := by
  intro p hp
  have h : env7385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7384_7385 : H12AffineEnvironment.transform 7 37 env7384 = env7385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7384 == env7385) = true)

theorem identity7385 : scanCanonicalize (H12AffineFastState.compose env7385 (packedSelected [0,4,7,11,22,32] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound7385 : packedSelected [0,4,7,11,22,32] rootPS < 2^1333 := by decide +kernel

def env7386 : List Nat := [2,4,8,16,32,64,9,37,512,1024,2048,4096,8192,16384,8232,2082,11341,2048,524288,8232,16464,10248,17445,3,8193,17525,2049,4176,11293,2049,11273,4294967296,36,4295502889,11340,512]

theorem envBound7386 : H12AffineFastState.Bounded env7386 := by
  intro p hp
  have h : env7386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7385_7386 : H12AffineEnvironment.transform 15 2082 env7385 = env7386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env7385 == env7386) = true)

theorem identity7386 : scanCanonicalize (H12AffineFastState.compose env7386 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 15975) := by decide +kernel

theorem selectedBound7386 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env7387 : List Nat := [2,4,8,16,32,64,9,37,512,1024,2048,4096,8192,16384,8232,2082,11341,2048,524288,8232,16464,10248,17445,3,8193,17525,2049,4176,11293,2049,11273,15975,36,528974,11340,512]

theorem envBound7387 : H12AffineFastState.Bounded env7387 := by
  intro p hp
  have h : env7387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7386_7387 : H12AffineEnvironment.transform 31 15975 env7386 = env7387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 15975 env7386 == env7387) = true)

theorem identity7387 : scanCanonicalize (H12AffineFastState.compose env7387 (packedSelected [12,15] rootPS)) = affineNative (2^(18+1) ^^^ 16485) := by decide +kernel

theorem selectedBound7387 : packedSelected [12,15] rootPS < 2^1333 := by decide +kernel

def env7388 : List Nat := [2,4,8,16,32,64,9,37,512,1024,2048,4096,8192,16384,8232,2082,11341,2048,16485,8232,16464,10248,17445,3,8193,17525,2049,4176,11293,2049,11273,15975,36,21035,11340,512]

theorem envBound7388 : H12AffineFastState.Bounded env7388 := by
  intro p hp
  have h : env7388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7387_7388 : H12AffineEnvironment.transform 18 16485 env7387 = env7388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 16485 env7387 == env7388) = true)

theorem identity7388 : scanCanonicalize (H12AffineFastState.compose env7388 (packedSelected [0,2,4] rootPS)) = affineNative (2^(12+1) ^^^ 2088) := by decide +kernel

theorem selectedBound7388 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env7389 : List Nat := [2,4,8,16,32,64,9,37,512,1024,2048,4096,2088,16384,2048,2082,1125,2048,16485,2048,16464,32,17445,3,2089,17525,2049,4176,1077,2049,1057,5711,36,21035,1124,512]

theorem envBound7389 : H12AffineFastState.Bounded env7389 := by
  intro p hp
  have h : env7389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7388_7389 : H12AffineEnvironment.transform 12 2088 env7388 = env7389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2088 env7388 == env7389) = true)

theorem identity7389 : scanCanonicalize (H12AffineFastState.compose env7389 (packedSelected [0,6,7] rootPS)) = affineNative (2^(8+1) ^^^ 43) := by decide +kernel

theorem selectedBound7389 : packedSelected [0,6,7] rootPS < 2^1333 := by decide +kernel

def env7390 : List Nat := [2,4,8,16,32,64,9,37,43,1024,2048,4096,2088,16384,2048,2082,1125,2048,16485,2048,16464,32,17445,3,2089,17525,2049,4176,1077,2049,1057,5220,36,20480,1124,43]

theorem envBound7390 : H12AffineFastState.Bounded env7390 := by
  intro p hp
  have h : env7390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7389_7390 : H12AffineEnvironment.transform 8 43 env7389 = env7390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 43 env7389 == env7390) = true)

theorem identity7390 : scanCanonicalize (H12AffineFastState.compose env7390 (packedSelected [1,5,6,10,11,12] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound7390 : packedSelected [1,5,6,10,11,12] rootPS < 2^1333 := by decide +kernel

def env7391 : List Nat := [2,4,8,16,32,64,9,37,43,1024,2048,4096,2088,4177,2048,2082,1125,2048,4148,2048,4097,32,5236,3,2089,5156,2049,4176,1077,2049,1057,5220,36,81,1124,43]

theorem envBound7391 : H12AffineFastState.Bounded env7391 := by
  intro p hp
  have h : env7391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7390_7391 : H12AffineEnvironment.transform 13 4177 env7390 = env7391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7390 == env7391) = true)

theorem identity7391 : scanCanonicalize (H12AffineFastState.compose env7391 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound7391 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7392 : List Nat := [2,4,8,16,3,64,9,6,8,1024,2048,4096,2059,4177,2048,2049,1094,2048,4119,2048,4097,3,5207,3,2058,5127,2049,4176,1046,2049,1026,5191,7,81,1095,8]

theorem envBound7392 : H12AffineFastState.Bounded env7392 := by
  intro p hp
  have h : env7392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7391_7392 : H12AffineEnvironment.transform 4 3 env7391 = env7392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env7391 == env7392) = true)

theorem identity7392 : scanCanonicalize (H12AffineFastState.compose env7392 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 2) := by decide +kernel

theorem selectedBound7392 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7393 : List Nat := [2,4,8,16,3,64,9,6,8,1024,2,4096,9,4177,2,3,1094,2,4119,2,4097,3,5207,3,8,5127,3,4176,1046,3,1026,5191,7,81,1095,8]

theorem envBound7393 : H12AffineFastState.Bounded env7393 := by
  intro p hp
  have h : env7393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7392_7393 : H12AffineEnvironment.transform 10 2 env7392 = env7393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 2 env7392 == env7393) = true)

theorem identity7393 : scanCanonicalize (H12AffineFastState.compose env7393 (packedSelected [10,13] rootPS)) = affineNative (2^(9+1) ^^^ 7) := by decide +kernel

theorem selectedBound7393 : packedSelected [10,13] rootPS < 2^1333 := by decide +kernel

def env7394 : List Nat := [2,4,8,16,3,64,9,6,8,7,2,4096,9,4177,2,3,65,2,4119,2,4097,3,4176,3,8,4096,3,4176,17,3,5,4160,7,81,64,8]

theorem envBound7394 : H12AffineFastState.Bounded env7394 := by
  intro p hp
  have h : env7394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7393_7394 : H12AffineEnvironment.transform 9 7 env7393 = env7394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 7 env7393 == env7394) = true)

theorem identity7394 : scanCanonicalize (H12AffineFastState.compose env7394 (packedSelected [1,5] rootPS)) = affineNative (2^(11+1) ^^^ 19) := by decide +kernel

theorem selectedBound7394 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env7395 : List Nat := [2,4,8,16,3,64,9,6,8,7,2,19,9,66,2,3,65,2,4,2,18,3,67,3,8,19,3,67,17,3,5,83,7,81,64,8]

theorem envBound7395 : H12AffineFastState.Bounded env7395 := by
  intro p hp
  have h : env7395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7394_7395 : H12AffineEnvironment.transform 11 19 env7394 = env7395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 19 env7394 == env7395) = true)

def env7396 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,11460,2049,524288,8461,16464,10248,17664,67981,8328,17744,2185,4176,11412,65935,11392,4294967296,257,4295566638,11461,512]

theorem envBound7396 : H12AffineFastState.Bounded env7396 := by
  intro p hp
  have h : env7396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7366_7396 : H12AffineEnvironment.transform 17 2049 env7366 = env7396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2049 env7366 == env7396) = true)

theorem identity7396 : scanCanonicalize (H12AffineFastState.compose env7396 (packedSelected [0,4,7,11,16,22,23] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7396 : packedSelected [0,4,7,11,16,22,23] rootPS < 2^1333 := by decide +kernel

def env7397 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,16384,8233,65536,11460,2049,524288,8233,16464,10248,17444,67753,8328,17524,2185,4176,11412,65707,11392,4294967296,37,4295566346,11461,512]

theorem envBound7397 : H12AffineFastState.Bounded env7397 := by
  intro p hp
  have h : env7397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7396_7397 : H12AffineEnvironment.transform 7 36 env7396 = env7397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7396 == env7397) = true)

theorem identity7397 : scanCanonicalize (H12AffineFastState.compose env7397 (packedSelected [0,4,7,11,16,20,22,32] rootPS)) = affineNative (2^(15+1) ^^^ 2083) := by decide +kernel

theorem selectedBound7397 : packedSelected [0,4,7,11,16,20,22,32] rootPS < 2^1333 := by decide +kernel

def env7398 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,16384,8233,2083,11460,2049,524288,8233,16464,10248,17444,138,8328,17524,2185,4176,11412,2184,11392,4294967296,37,4295502889,11461,512]

theorem envBound7398 : H12AffineFastState.Bounded env7398 := by
  intro p hp
  have h : env7398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7397_7398 : H12AffineEnvironment.transform 15 2083 env7397 = env7398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2083 env7397 == env7398) = true)

theorem identity7398 : scanCanonicalize (H12AffineFastState.compose env7398 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 16110) := by decide +kernel

theorem selectedBound7398 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env7399 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,16384,8233,2083,11460,2049,524288,8233,16464,10248,17444,138,8328,17524,2185,4176,11412,2184,11392,16110,37,529095,11461,512]

theorem envBound7399 : H12AffineFastState.Bounded env7399 := by
  intro p hp
  have h : env7399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7398_7399 : H12AffineEnvironment.transform 31 16110 env7398 = env7399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 16110 env7398 == env7399) = true)

def env7400 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4176,8233,2083,11460,2049,524288,8233,4096,10248,5236,138,8328,5156,2185,4176,11412,2184,11392,16110,37,529095,11461,512]

theorem envBound7400 : H12AffineFastState.Bounded env7400 := by
  intro p hp
  have h : env7400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7399_7400 : H12AffineEnvironment.transform 13 4176 env7399 = env7400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env7399 == env7400) = true)

theorem identity7400 : scanCanonicalize (H12AffineFastState.compose env7400 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(8+1) ^^^ 163) := by decide +kernel

theorem selectedBound7400 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7401 : List Nat := [2,4,8,16,32,64,128,36,163,1024,2048,4096,8192,4176,8233,2083,11460,2049,524288,8233,4096,10248,5236,138,8328,5156,2185,4176,11412,2184,11392,15437,37,528484,11461,163]

theorem envBound7401 : H12AffineFastState.Bounded env7401 := by
  intro p hp
  have h : env7401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7400_7401 : H12AffineEnvironment.transform 8 163 env7400 = env7401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 163 env7400 == env7401) = true)

theorem identity7401 : scanCanonicalize (H12AffineFastState.compose env7401 (packedSelected [11] rootPS)) = affineNative (2^(11+1) ^^^ 3276) := by decide +kernel

theorem selectedBound7401 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7402 : List Nat := [2,4,8,16,32,64,128,36,163,1024,2048,3276,8192,3228,8233,2083,11460,2049,524288,8233,3276,10248,2232,138,8328,2280,2185,3228,11412,2184,11392,8321,37,527528,11461,163]

theorem envBound7402 : H12AffineFastState.Bounded env7402 := by
  intro p hp
  have h : env7402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7401_7402 : H12AffineEnvironment.transform 11 3276 env7401 = env7402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3276 env7401 == env7402) = true)

def env7403 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4177,8233,2083,11460,2049,524288,8233,4097,10248,5237,138,8328,5157,2185,4176,11412,2184,11392,16110,37,529095,11461,512]

theorem envBound7403 : H12AffineFastState.Bounded env7403 := by
  intro p hp
  have h : env7403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7399_7403 : H12AffineEnvironment.transform 13 4177 env7399 = env7403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7399 == env7403) = true)

theorem identity7403 : scanCanonicalize (H12AffineFastState.compose env7403 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 2563) := by decide +kernel

theorem selectedBound7403 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7404 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,2563,4177,2602,2083,1735,2049,524288,2602,4097,523,5237,138,2699,5157,2185,4176,1687,2184,1667,5357,37,529095,1734,512]

theorem envBound7404 : H12AffineFastState.Bounded env7404 := by
  intro p hp
  have h : env7404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7403_7404 : H12AffineEnvironment.transform 12 2563 env7403 = env7404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2563 env7403 == env7404) = true)

theorem identity7404 : scanCanonicalize (H12AffineFastState.compose env7404 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 169) := by decide +kernel

theorem selectedBound7404 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7405 : List Nat := [2,4,8,16,32,64,128,36,512,1024,169,4096,682,4177,643,138,1735,168,524288,643,4097,523,5237,138,546,5157,32,4176,1687,33,1667,5357,37,529095,1734,512]

theorem envBound7405 : H12AffineFastState.Bounded env7405 := by
  intro p hp
  have h : env7405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7404_7405 : H12AffineEnvironment.transform 10 169 env7404 = env7405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 169 env7404 == env7405) = true)

theorem identity7405 : scanCanonicalize (H12AffineFastState.compose env7405 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 4638) := by decide +kernel

theorem selectedBound7405 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env7406 : List Nat := [2,4,8,16,32,64,128,36,512,1024,169,4096,682,4177,643,138,1735,168,4638,643,4097,523,5237,138,546,5157,32,4176,1687,33,1667,5357,37,217,1734,512]

theorem envBound7406 : H12AffineFastState.Bounded env7406 := by
  intro p hp
  have h : env7406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7405_7406 : H12AffineEnvironment.transform 18 4638 env7405 = env7406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4638 env7405 == env7406) = true)

theorem identity7406 : scanCanonicalize (H12AffineFastState.compose env7406 (packedSelected [1,3,6] rootPS)) = affineNative (2^(8+1) ^^^ 43) := by decide +kernel

theorem selectedBound7406 : packedSelected [1,3,6] rootPS < 2^1333 := by decide +kernel

def env7407 : List Nat := [2,4,8,16,32,64,128,36,43,1024,169,4096,129,4177,168,138,1260,168,4149,168,4097,32,5237,138,9,5157,32,4176,1212,33,1192,5357,37,217,1261,43]

theorem envBound7407 : H12AffineFastState.Bounded env7407 := by
  intro p hp
  have h : env7407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7406_7407 : H12AffineEnvironment.transform 8 43 env7406 = env7407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 43 env7406 == env7407) = true)

theorem identity7407 : scanCanonicalize (H12AffineFastState.compose env7407 (packedSelected [1,3,10,13] rootPS)) = affineNative (2^(9+1) ^^^ 173) := by decide +kernel

theorem selectedBound7407 : packedSelected [1,3,10,13] rootPS < 2^1333 := by decide +kernel

def env7408 : List Nat := [2,4,8,16,32,64,128,36,43,173,169,4096,129,4177,168,138,65,168,4149,168,4097,32,4312,138,9,4232,32,4176,17,33,5,4160,37,217,64,43]

theorem envBound7408 : H12AffineFastState.Bounded env7408 := by
  intro p hp
  have h : env7408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7407_7408 : H12AffineEnvironment.transform 9 173 env7407 = env7408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 173 env7407 == env7408) = true)

theorem identity7408 : scanCanonicalize (H12AffineFastState.compose env7408 (packedSelected [1,5,10,15] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound7408 : packedSelected [1,5,10,15] rootPS < 2^1333 := by decide +kernel

def env7409 : List Nat := [2,4,8,16,32,64,8,36,43,37,33,4096,9,4177,32,2,65,32,4149,32,4097,32,4176,2,9,4096,32,4176,17,33,5,4160,37,81,64,43]

theorem envBound7409 : H12AffineFastState.Bounded env7409 := by
  intro p hp
  have h : env7409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7408_7409 : H12AffineEnvironment.transform 6 8 env7408 = env7409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7408 == env7409) = true)

theorem identity7409 : scanCanonicalize (H12AffineFastState.compose env7409 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound7409 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7410 : List Nat := [2,4,8,16,3,64,8,7,8,6,2,4096,9,4177,3,2,65,3,4118,3,4097,3,4176,2,9,4096,3,4176,17,2,5,4160,6,81,64,8]

theorem envBound7410 : H12AffineFastState.Bounded env7410 := by
  intro p hp
  have h : env7410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7409_7410 : H12AffineEnvironment.transform 4 3 env7409 = env7410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env7409 == env7410) = true)

theorem identity7410 : scanCanonicalize (H12AffineFastState.compose env7410 (packedSelected [1,5] rootPS)) = affineNative (2^(11+1) ^^^ 18) := by decide +kernel

theorem selectedBound7410 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env7411 : List Nat := [2,4,8,16,3,64,8,7,8,6,2,18,9,67,3,2,65,3,4,3,19,3,66,2,9,18,3,66,17,2,5,82,6,81,64,8]

theorem envBound7411 : H12AffineFastState.Bounded env7411 := by
  intro p hp
  have h : env7411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7410_7411 : H12AffineEnvironment.transform 11 18 env7410 = env7411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 18 env7410 == env7411) = true)

def env7412 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17664,230468,8329,2098432,2518044,2117632,131152,1073741824,131140,4294967296,257,4297844918,131073,513]

theorem envBound7412 : H12AffineFastState.Bounded env7412 := by
  intro p hp
  have h : env7412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7361_7412 : H12AffineEnvironment.transform 24 8329 env7361 = env7412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env7361 == env7412) = true)

def env7413 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8200,17664,230468,8329,2098432,2515996,2117632,131152,1073741824,131140,4294967296,257,4297842870,131073,513]

theorem envBound7413 : H12AffineFastState.Bounded env7413 := by
  intro p hp
  have h : env7413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7412_7413 : H12AffineEnvironment.transform 10 0 env7412 = env7413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env7412 == env7413) = true)

def env7414 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17664,230468,8329,5376,422940,16384,131152,1073741824,131140,4294967296,257,4295749814,131073,513]

theorem envBound7414 : H12AffineFastState.Bounded env7414 := by
  intro p hp
  have h : env7414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7413_7414 : H12AffineEnvironment.transform 20 4096 env7413 = env7414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env7413 == env7414) = true)

theorem identity7414 : scanCanonicalize (H12AffineFastState.compose env7414 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 309216) := by decide +kernel

theorem selectedBound7414 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7415 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17664,230468,8329,5376,422940,16384,131152,309216,131140,4294967296,257,4295749814,131073,513]

theorem envBound7415 : H12AffineFastState.Bounded env7415 := by
  intro p hp
  have h : env7415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7414_7415 : H12AffineEnvironment.transform 29 309216 env7414 = env7415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 309216 env7414 == env7415) = true)

theorem identity7415 : scanCanonicalize (H12AffineFastState.compose env7415 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound7415 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env7416 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,8200,17664,230468,8329,5376,422940,16384,131152,309216,131140,4294967296,257,4295206119,131073,513]

theorem envBound7416 : H12AffineFastState.Bounded env7416 := by
  intro p hp
  have h : env7416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7415_7416 : H12AffineEnvironment.transform 18 21585 env7415 = env7416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env7415 == env7416) = true)

theorem identity7416 : scanCanonicalize (H12AffineFastState.compose env7416 (packedSelected [4,9,16] rootPS)) = affineNative (2^(17+1) ^^^ 71522) := by decide +kernel

theorem selectedBound7416 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7417 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,71522,21585,32768,4096,8200,17664,230468,8329,5376,222078,16384,131152,106626,131140,4294967296,257,4295206119,131073,513]

theorem envBound7417 : H12AffineFastState.Bounded env7417 := by
  intro p hp
  have h : env7417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7416_7417 : H12AffineEnvironment.transform 17 71522 env7416 = env7417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 71522 env7416 == env7417) = true)

theorem identity7417 : scanCanonicalize (H12AffineFastState.compose env7417 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound7417 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7418 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,71522,1024,32768,4096,8200,5457,230468,8329,5376,209711,4177,131152,106626,131140,4294967296,257,4295206119,131073,513]

theorem envBound7418 : H12AffineFastState.Bounded env7418 := by
  intro p hp
  have h : env7418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7417_7418 : H12AffineEnvironment.transform 13 4177 env7417 = env7418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7417 == env7418) = true)

theorem identity7418 : scanCanonicalize (H12AffineFastState.compose env7418 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound7418 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env7419 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,8540,65536,131072,71522,1024,8540,4096,8200,5457,206104,8329,5376,209711,4177,131152,66014,131140,4294967296,257,4295165371,131073,513]

theorem envBound7419 : H12AffineFastState.Bounded env7419 := by
  intro p hp
  have h : env7419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7418_7419 : H12AffineEnvironment.transform 14 8540 env7418 = env7419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env7418 == env7419) = true)

def env7420 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17664,230468,8329,5377,422941,16385,131152,1073741824,131140,4294967296,257,4295749815,131073,513]

theorem envBound7420 : H12AffineFastState.Bounded env7420 := by
  intro p hp
  have h : env7420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7413_7420 : H12AffineEnvironment.transform 20 4097 env7413 = env7420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env7413 == env7420) = true)

theorem identity7420 : scanCanonicalize (H12AffineFastState.compose env7420 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 303777) := by decide +kernel

theorem selectedBound7420 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7421 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17664,230468,8329,5377,422941,16385,131152,303777,131140,4294967296,257,4295749815,131073,513]

theorem envBound7421 : H12AffineFastState.Bounded env7421 := by
  intro p hp
  have h : env7421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7420_7421 : H12AffineEnvironment.transform 29 303777 env7420 = env7421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 303777 env7420 == env7421) = true)

def env7422 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,8200,17664,98564,8329,5377,291165,16385,1296,303777,1284,4294967296,257,4295620087,1345,513]

theorem envBound7422 : H12AffineFastState.Bounded env7422 := by
  intro p hp
  have h : env7422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7421_7422 : H12AffineEnvironment.transform 16 1344 env7421 = env7422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env7421 == env7422) = true)

theorem identity7422 : scanCanonicalize (H12AffineFastState.compose env7422 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(13+1) ^^^ 4824) := by decide +kernel

theorem selectedBound7422 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env7423 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,32768,65536,1344,262144,524288,32768,4097,8200,6104,98564,8329,5377,271237,4825,1296,303777,1284,4294967296,257,4295599919,1345,513]

theorem envBound7423 : H12AffineFastState.Bounded env7423 := by
  intro p hp
  have h : env7423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7422_7423 : H12AffineEnvironment.transform 13 4824 env7422 = env7423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env7422 == env7423) = true)

theorem identity7423 : scanCanonicalize (H12AffineFastState.compose env7423 (packedSelected [2,4,6,7,16,23] rootPS)) = affineNative (2^(14+1) ^^^ 8865) := by decide +kernel

theorem selectedBound7423 : packedSelected [2,4,6,7,16,23] rootPS < 2^1333 := by decide +kernel

def env7424 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,8865,65536,1344,262144,524288,8865,4097,8200,6104,74661,8329,5377,271237,4825,1296,262144,1284,4294967296,257,4295558542,1345,513]

theorem envBound7424 : H12AffineFastState.Bounded env7424 := by
  intro p hp
  have h : env7424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7423_7424 : H12AffineEnvironment.transform 14 8865 env7423 = env7424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8865 env7423 == env7424) = true)

theorem identity7424 : scanCanonicalize (H12AffineFastState.compose env7424 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound7424 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7425 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4824,293,65536,1344,262144,524288,293,4097,908,6104,65569,781,5377,262145,4825,1296,262144,1284,4294967296,257,4295558542,1345,513]

theorem envBound7425 : H12AffineFastState.Bounded env7425 := by
  intro p hp
  have h : env7425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7424_7425 : H12AffineEnvironment.transform 12 900 env7424 = env7425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env7424 == env7425) = true)

theorem identity7425 : scanCanonicalize (H12AffineFastState.compose env7425 (packedSelected [4,9] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound7425 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env7426 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4824,293,65536,1344,0,524288,293,4097,908,6104,65569,781,5377,1,4825,1296,0,1284,4294967296,257,4295558542,1345,513]

theorem envBound7426 : H12AffineFastState.Bounded env7426 := by
  intro p hp
  have h : env7426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7425_7426 : H12AffineEnvironment.transform 17 0 env7425 = env7426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env7425 == env7426) = true)

def env7427 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4824,293,65536,1344,0,1024,293,4097,908,6104,65569,781,5377,1,4825,1296,0,1284,4294967296,257,4295033230,1345,513]

theorem envBound7427 : H12AffineFastState.Bounded env7427 := by
  intro p hp
  have h : env7427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7426_7427 : H12AffineEnvironment.transform 18 1024 env7426 = env7427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7426 == env7427) = true)

theorem identity7427 : scanCanonicalize (H12AffineFastState.compose env7427 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound7427 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7428 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4824,293,170,1344,0,1024,293,4097,908,6104,139,781,5377,1,4825,1296,0,1284,4294967296,257,4294967588,1345,513]

theorem envBound7428 : H12AffineFastState.Bounded env7428 := by
  intro p hp
  have h : env7428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7427_7428 : H12AffineEnvironment.transform 15 170 env7427 = env7428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env7427 == env7428) = true)

theorem identity7428 : scanCanonicalize (H12AffineFastState.compose env7428 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound7428 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7429 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,268,4176,293,170,1344,0,1024,293,4097,260,5456,139,389,5377,1,4177,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7429 : H12AffineFastState.Bounded env7429 := by
  intro p hp
  have h : env7429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7428_7429 : H12AffineEnvironment.transform 8 136 env7428 = env7429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7428 == env7429) = true)

theorem identity7429 : scanCanonicalize (H12AffineFastState.compose env7429 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound7429 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7430 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1076,268,1124,293,170,1344,0,1024,293,1077,260,356,139,389,309,1,1125,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7430 : H12AffineFastState.Bounded env7430 := by
  intro p hp
  have h : env7430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7429_7430 : H12AffineEnvironment.transform 11 1076 env7429 = env7430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env7429 == env7430) = true)

def env7431 : List Nat := [2,4,8,16,32,64,8,256,0,1024,0,1076,268,1124,293,34,1344,0,1024,293,1077,260,356,3,269,309,1,1125,1296,0,1284,4294967296,257,4294967588,1345,1]

theorem envBound7431 : H12AffineFastState.Bounded env7431 := by
  intro p hp
  have h : env7431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7430_7431 : H12AffineEnvironment.transform 6 8 env7430 = env7431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7430 == env7431) = true)

theorem identity7431 : scanCanonicalize (H12AffineFastState.compose env7431 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound7431 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7432 : List Nat := [2,4,8,16,32,64,8,256,0,1024,0,1076,268,1124,293,34,1344,0,1024,293,1077,260,356,3,269,309,1,1125,1296,0,1284,42,257,270,1345,1]

theorem envBound7432 : H12AffineFastState.Bounded env7432 := by
  intro p hp
  have h : env7432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7431_7432 : H12AffineEnvironment.transform 31 42 env7431 = env7432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env7431 == env7432) = true)

def env7433 : List Nat := [2,4,8,16,32,16,8,256,0,1024,0,1076,268,1076,293,34,1296,0,1024,293,1077,260,308,3,269,309,1,1077,1296,0,1284,42,257,270,1297,1]

theorem envBound7433 : H12AffineFastState.Bounded env7433 := by
  intro p hp
  have h : env7433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7432_7433 : H12AffineEnvironment.transform 5 16 env7432 = env7433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7432 == env7433) = true)

theorem identity7433 : scanCanonicalize (H12AffineFastState.compose env7433 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7433 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7434 : List Nat := [2,4,8,1,32,1,8,256,0,1024,0,1061,268,1061,293,34,1281,0,1024,293,1060,260,293,3,269,292,1,1060,1281,0,1284,42,257,270,1280,1]

theorem envBound7434 : H12AffineFastState.Bounded env7434 := by
  intro p hp
  have h : env7434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7433_7434 : H12AffineEnvironment.transform 3 1 env7433 = env7434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7433 == env7434) = true)

def env7435 : List Nat := [2,4,8,1,32,1,8,36,0,1024,0,1061,40,1061,1,34,1061,0,1024,1,1060,32,1,3,41,0,1,1060,1061,0,1056,42,37,42,1060,1]

theorem envBound7435 : H12AffineFastState.Bounded env7435 := by
  intro p hp
  have h : env7435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7434_7435 : H12AffineEnvironment.transform 7 36 env7434 = env7435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7434 == env7435) = true)

theorem identity7435 : scanCanonicalize (H12AffineFastState.compose env7435 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7435 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7436 : List Nat := [2,4,3,1,32,1,3,36,0,1024,0,1061,35,1061,1,34,1061,0,1024,1,1060,32,1,3,34,0,1,1060,1061,0,1056,33,37,33,1060,1]

theorem envBound7436 : H12AffineFastState.Bounded env7436 := by
  intro p hp
  have h : env7436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7435_7436 : H12AffineEnvironment.transform 2 3 env7435 = env7436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7435 == env7436) = true)

def leafEnv7436 : List Nat := [2,4,3,1,32,1,3,36,0,1024,0,1061,35,1061,1,34,1061,0,1024,1,1060,32,1,3,1056,34,1,0,1,1060,1061,0,1056,33,37,33,5,34,1060,1,0,1060,1]

def active7436 : List Nat := [0,1,4,9]

def tree7436 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7436 : H12WitnessSearch.Good tree7436 := H12GlobalWitnessIndex.good

theorem leafIdentity7436 : H12AffineFastState.composeSystem env7436 rootObs = leafEnv7436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7436 rootObs == leafEnv7436) = true)

theorem terminalChecked7436 : H12PackedTerminal.terminalCheckFast leafEnv7436 active7436 tree7436 = true := by decide +kernel

def env7437 : List Nat := [2,4,8,1,32,1,8,37,0,1024,0,1061,41,1061,0,34,1060,0,1024,0,1060,33,0,3,40,1,1,1060,1060,0,1057,42,36,43,1061,1]

theorem envBound7437 : H12AffineFastState.Bounded env7437 := by
  intro p hp
  have h : env7437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7434_7437 : H12AffineEnvironment.transform 7 37 env7434 = env7437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7434 == env7437) = true)

def leafEnv7437 : List Nat := [2,4,8,1,32,1,8,37,0,1024,0,1061,41,1061,0,34,1060,0,1024,0,1060,33,0,3,1057,40,1,1,1,1060,1060,0,1057,42,36,43,5,34,1061,1,0,1061,1]

def active7437 : List Nat := [0,1,2,4,9]

def tree7437 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7437 : H12WitnessSearch.Good tree7437 := H12GlobalWitnessIndex.good

theorem leafIdentity7437 : H12AffineFastState.composeSystem env7437 rootObs = leafEnv7437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7437 rootObs == leafEnv7437) = true)

theorem terminalChecked7437 : H12PackedTerminal.terminalCheckFast leafEnv7437 active7437 tree7437 = true := by decide +kernel

def env7438 : List Nat := [2,4,8,16,32,17,8,256,0,1024,0,1076,268,1077,293,34,1297,0,1024,293,1077,260,309,3,269,309,1,1076,1296,0,1284,42,257,270,1296,1]

theorem envBound7438 : H12AffineFastState.Bounded env7438 := by
  intro p hp
  have h : env7438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7432_7438 : H12AffineEnvironment.transform 5 17 env7432 = env7438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7432 == env7438) = true)

theorem identity7438 : scanCanonicalize (H12AffineFastState.compose env7438 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound7438 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7439 : List Nat := [2,4,8,16,32,17,8,52,0,1024,0,1076,56,1077,17,34,1061,0,1024,17,1077,48,1,3,57,1,1,1076,1060,0,1072,42,53,58,1060,1]

theorem envBound7439 : H12AffineFastState.Bounded env7439 := by
  intro p hp
  have h : env7439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7438_7439 : H12AffineEnvironment.transform 7 52 env7438 = env7439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env7438 == env7439) = true)

def env7440 : List Nat := [2,4,8,0,32,1,8,36,0,1024,0,1060,40,1061,1,34,1061,0,1024,1,1061,32,1,3,41,1,1,1060,1060,0,1056,42,37,42,1060,1]

theorem envBound7440 : H12AffineFastState.Bounded env7440 := by
  intro p hp
  have h : env7440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7439_7440 : H12AffineEnvironment.transform 3 0 env7439 = env7440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7439 == env7440) = true)

theorem identity7440 : scanCanonicalize (H12AffineFastState.compose env7440 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7440 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7441 : List Nat := [2,4,3,0,32,1,3,36,0,1024,0,1060,35,1061,1,34,1061,0,1024,1,1061,32,1,3,34,1,1,1060,1060,0,1056,33,37,33,1060,1]

theorem envBound7441 : H12AffineFastState.Bounded env7441 := by
  intro p hp
  have h : env7441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7440_7441 : H12AffineEnvironment.transform 2 3 env7440 = env7441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7440 == env7441) = true)

def leafEnv7441 : List Nat := [2,4,3,0,32,1,3,36,0,1024,0,1060,35,1061,1,34,1061,0,1024,1,1061,32,1,3,1056,34,1,1,1,1060,1060,0,1056,33,37,33,5,34,1060,1,0,1061,1]

def active7441 : List Nat := [0,1,4,9]

def tree7441 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7441 : H12WitnessSearch.Good tree7441 := H12GlobalWitnessIndex.good

theorem leafIdentity7441 : H12AffineFastState.composeSystem env7441 rootObs = leafEnv7441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7441 rootObs == leafEnv7441) = true)

theorem terminalChecked7441 : H12PackedTerminal.terminalCheckFast leafEnv7441 active7441 tree7441 = true := by decide +kernel

def env7442 : List Nat := [2,4,8,1,32,0,8,37,0,1024,0,1061,41,1060,0,34,1061,0,1024,0,1060,33,1,3,40,1,1,1061,1060,0,1057,42,36,43,1060,1]

theorem envBound7442 : H12AffineFastState.Bounded env7442 := by
  intro p hp
  have h : env7442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7439_7442 : H12AffineEnvironment.transform 3 1 env7439 = env7442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7439 == env7442) = true)

def leafEnv7442 : List Nat := [2,4,8,1,32,0,8,37,0,1024,0,1061,41,1060,0,34,1061,0,1024,0,1060,33,1,3,1057,40,1,1,1,1061,1060,0,1057,42,36,43,5,34,1060,1,0,1061,1]

def active7442 : List Nat := [0,1,2,4,9]

def tree7442 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7442 : H12WitnessSearch.Good tree7442 := H12GlobalWitnessIndex.good

theorem leafIdentity7442 : H12AffineFastState.composeSystem env7442 rootObs = leafEnv7442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7442 rootObs == leafEnv7442) = true)

theorem terminalChecked7442 : H12PackedTerminal.terminalCheckFast leafEnv7442 active7442 tree7442 = true := by decide +kernel

def env7443 : List Nat := [2,4,8,16,32,64,9,256,1,1024,0,1076,268,1124,293,35,1344,0,1024,293,1077,260,356,2,268,309,1,1125,1296,0,1284,4294967296,257,4294967588,1345,0]

theorem envBound7443 : H12AffineFastState.Bounded env7443 := by
  intro p hp
  have h : env7443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7430_7443 : H12AffineEnvironment.transform 6 9 env7430 = env7443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7430 == env7443) = true)

theorem identity7443 : scanCanonicalize (H12AffineFastState.compose env7443 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 270) := by decide +kernel

theorem selectedBound7443 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7444 : List Nat := [2,4,8,16,32,64,9,256,1,1024,0,1076,268,1124,293,35,1344,0,1024,293,1077,260,356,2,268,309,1,1125,1296,0,1284,270,257,42,1345,0]

theorem envBound7444 : H12AffineFastState.Bounded env7444 := by
  intro p hp
  have h : env7444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7443_7444 : H12AffineEnvironment.transform 31 270 env7443 = env7444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 270 env7443 == env7444) = true)

def env7445 : List Nat := [2,4,8,16,32,16,9,256,1,1024,0,1076,268,1076,293,35,1296,0,1024,293,1077,260,308,2,268,309,1,1077,1296,0,1284,270,257,42,1297,0]

theorem envBound7445 : H12AffineFastState.Bounded env7445 := by
  intro p hp
  have h : env7445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7444_7445 : H12AffineEnvironment.transform 5 16 env7444 = env7445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7444 == env7445) = true)

theorem identity7445 : scanCanonicalize (H12AffineFastState.compose env7445 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7445 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7446 : List Nat := [2,4,8,1,32,1,9,256,1,1024,0,1061,268,1061,293,35,1281,0,1024,293,1060,260,293,2,268,292,1,1060,1281,0,1284,270,257,42,1280,0]

theorem envBound7446 : H12AffineFastState.Bounded env7446 := by
  intro p hp
  have h : env7446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7445_7446 : H12AffineEnvironment.transform 3 1 env7445 = env7446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7445 == env7446) = true)

def env7447 : List Nat := [2,4,8,1,32,1,9,36,1,1024,0,1061,40,1061,1,35,1061,0,1024,1,1060,32,1,2,40,0,1,1060,1061,0,1056,42,37,42,1060,0]

theorem envBound7447 : H12AffineFastState.Bounded env7447 := by
  intro p hp
  have h : env7447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7446_7447 : H12AffineEnvironment.transform 7 36 env7446 = env7447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7446 == env7447) = true)

theorem identity7447 : scanCanonicalize (H12AffineFastState.compose env7447 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7447 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7448 : List Nat := [2,4,3,1,32,1,2,36,1,1024,0,1061,35,1061,1,35,1061,0,1024,1,1060,32,1,2,35,0,1,1060,1061,0,1056,33,37,33,1060,0]

theorem envBound7448 : H12AffineFastState.Bounded env7448 := by
  intro p hp
  have h : env7448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7447_7448 : H12AffineEnvironment.transform 2 3 env7447 = env7448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7447 == env7448) = true)

def leafEnv7448 : List Nat := [2,4,3,1,32,1,2,36,1,1024,0,1061,35,1061,1,35,1061,0,1024,1,1060,32,1,2,1056,35,1,0,1,1060,1061,0,1056,33,37,33,5,34,1060,0,0,1060,1]

def active7448 : List Nat := [0,1,4,9]

def tree7448 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7448 : H12WitnessSearch.Good tree7448 := H12GlobalWitnessIndex.good

theorem leafIdentity7448 : H12AffineFastState.composeSystem env7448 rootObs = leafEnv7448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7448 rootObs == leafEnv7448) = true)

theorem terminalChecked7448 : H12PackedTerminal.terminalCheckFast leafEnv7448 active7448 tree7448 = true := by decide +kernel

def env7449 : List Nat := [2,4,8,1,32,1,9,37,1,1024,0,1061,41,1061,0,35,1060,0,1024,0,1060,33,0,2,41,1,1,1060,1060,0,1057,43,36,42,1061,0]

theorem envBound7449 : H12AffineFastState.Bounded env7449 := by
  intro p hp
  have h : env7449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7446_7449 : H12AffineEnvironment.transform 7 37 env7446 = env7449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7446 == env7449) = true)

def leafEnv7449 : List Nat := [2,4,8,1,32,1,9,37,1,1024,0,1061,41,1061,0,35,1060,0,1024,0,1060,33,0,2,1057,41,1,1,1,1060,1060,0,1057,43,36,42,5,34,1061,0,0,1061,1]

def active7449 : List Nat := [0,1,2,4,9]

def tree7449 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7449 : H12WitnessSearch.Good tree7449 := H12GlobalWitnessIndex.good

theorem leafIdentity7449 : H12AffineFastState.composeSystem env7449 rootObs = leafEnv7449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7449 rootObs == leafEnv7449) = true)

theorem terminalChecked7449 : H12PackedTerminal.terminalCheckFast leafEnv7449 active7449 tree7449 = true := by decide +kernel

def env7450 : List Nat := [2,4,8,16,32,17,9,256,1,1024,0,1076,268,1077,293,35,1297,0,1024,293,1077,260,309,2,268,309,1,1076,1296,0,1284,270,257,42,1296,0]

theorem envBound7450 : H12AffineFastState.Bounded env7450 := by
  intro p hp
  have h : env7450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7444_7450 : H12AffineEnvironment.transform 5 17 env7444 = env7450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7444 == env7450) = true)

theorem identity7450 : scanCanonicalize (H12AffineFastState.compose env7450 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound7450 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7451 : List Nat := [2,4,8,16,32,17,9,52,1,1024,0,1076,56,1077,17,35,1061,0,1024,17,1077,48,1,2,56,1,1,1076,1060,0,1072,58,53,42,1060,0]

theorem envBound7451 : H12AffineFastState.Bounded env7451 := by
  intro p hp
  have h : env7451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7450_7451 : H12AffineEnvironment.transform 7 52 env7450 = env7451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env7450 == env7451) = true)

def env7452 : List Nat := [2,4,8,0,32,1,9,36,1,1024,0,1060,40,1061,1,35,1061,0,1024,1,1061,32,1,2,40,1,1,1060,1060,0,1056,42,37,42,1060,0]

theorem envBound7452 : H12AffineFastState.Bounded env7452 := by
  intro p hp
  have h : env7452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7451_7452 : H12AffineEnvironment.transform 3 0 env7451 = env7452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7451 == env7452) = true)

theorem identity7452 : scanCanonicalize (H12AffineFastState.compose env7452 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7452 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7453 : List Nat := [2,4,3,0,32,1,2,36,1,1024,0,1060,35,1061,1,35,1061,0,1024,1,1061,32,1,2,35,1,1,1060,1060,0,1056,33,37,33,1060,0]

theorem envBound7453 : H12AffineFastState.Bounded env7453 := by
  intro p hp
  have h : env7453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7452_7453 : H12AffineEnvironment.transform 2 3 env7452 = env7453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7452 == env7453) = true)

def leafEnv7453 : List Nat := [2,4,3,0,32,1,2,36,1,1024,0,1060,35,1061,1,35,1061,0,1024,1,1061,32,1,2,1056,35,1,1,1,1060,1060,0,1056,33,37,33,5,34,1060,0,0,1061,1]

def active7453 : List Nat := [0,1,4,9]

def tree7453 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7453 : H12WitnessSearch.Good tree7453 := H12GlobalWitnessIndex.good

theorem leafIdentity7453 : H12AffineFastState.composeSystem env7453 rootObs = leafEnv7453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7453 rootObs == leafEnv7453) = true)

theorem terminalChecked7453 : H12PackedTerminal.terminalCheckFast leafEnv7453 active7453 tree7453 = true := by decide +kernel

def env7454 : List Nat := [2,4,8,1,32,0,9,37,1,1024,0,1061,41,1060,0,35,1061,0,1024,0,1060,33,1,2,41,1,1,1061,1060,0,1057,43,36,42,1060,0]

theorem envBound7454 : H12AffineFastState.Bounded env7454 := by
  intro p hp
  have h : env7454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7451_7454 : H12AffineEnvironment.transform 3 1 env7451 = env7454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7451 == env7454) = true)

def leafEnv7454 : List Nat := [2,4,8,1,32,0,9,37,1,1024,0,1061,41,1060,0,35,1061,0,1024,0,1060,33,1,2,1057,41,1,1,1,1061,1060,0,1057,43,36,42,5,34,1060,0,0,1061,1]

def active7454 : List Nat := [0,1,2,4,9]

def tree7454 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7454 : H12WitnessSearch.Good tree7454 := H12GlobalWitnessIndex.good

theorem leafIdentity7454 : H12AffineFastState.composeSystem env7454 rootObs = leafEnv7454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7454 rootObs == leafEnv7454) = true)

theorem terminalChecked7454 : H12PackedTerminal.terminalCheckFast leafEnv7454 active7454 tree7454 = true := by decide +kernel

def env7455 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4824,293,65536,1344,0,1025,293,4097,908,6104,65569,781,5377,1,4825,1296,0,1284,4294967296,257,4295033231,1345,513]

theorem envBound7455 : H12AffineFastState.Bounded env7455 := by
  intro p hp
  have h : env7455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7426_7455 : H12AffineEnvironment.transform 18 1025 env7426 = env7455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env7426 == env7455) = true)

theorem identity7455 : scanCanonicalize (H12AffineFastState.compose env7455 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound7455 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7456 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4824,293,547,1344,0,1025,293,4097,908,6104,514,781,5377,1,4825,1296,0,1284,4294967296,257,4294968236,1345,513]

theorem envBound7456 : H12AffineFastState.Bounded env7456 := by
  intro p hp
  have h : env7456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7455_7456 : H12AffineEnvironment.transform 15 547 env7455 = env7456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env7455 == env7456) = true)

def env7457 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,268,4176,293,171,1344,0,1025,293,4097,260,5456,138,389,5377,1,4177,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7457 : H12AffineFastState.Bounded env7457 := by
  intro p hp
  have h : env7457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7456_7457 : H12AffineEnvironment.transform 8 136 env7456 = env7457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7456 == env7457) = true)

theorem identity7457 : scanCanonicalize (H12AffineFastState.compose env7457 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1260) := by decide +kernel

theorem selectedBound7457 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7458 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1260,268,1212,293,171,1344,0,1025,293,1261,260,444,138,389,493,1,1213,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7458 : H12AffineFastState.Bounded env7458 := by
  intro p hp
  have h : env7458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7457_7458 : H12AffineEnvironment.transform 11 1260 env7457 = env7458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1260 env7457 == env7458) = true)

theorem identity7458 : scanCanonicalize (H12AffineFastState.compose env7458 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7458 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7459 : List Nat := [2,4,8,16,32,64,128,4,136,1024,0,1260,8,1212,33,171,1092,0,1025,33,1261,0,184,138,129,233,1,1213,1044,0,1024,4294967296,5,4294967328,1093,137]

theorem envBound7459 : H12AffineFastState.Bounded env7459 := by
  intro p hp
  have h : env7459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7458_7459 : H12AffineEnvironment.transform 7 4 env7458 = env7459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7458 == env7459) = true)

theorem identity7459 : scanCanonicalize (H12AffineFastState.compose env7459 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound7459 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7460 : List Nat := [2,4,8,16,32,64,88,4,80,1024,0,1076,8,1124,33,115,1092,0,1025,33,1077,0,96,82,89,49,1,1125,1044,0,1024,4294967296,5,4294967328,1093,81]

theorem envBound7460 : H12AffineFastState.Bounded env7460 := by
  intro p hp
  have h : env7460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7459_7460 : H12AffineEnvironment.transform 6 88 env7459 = env7460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env7459 == env7460) = true)

theorem identity7460 : scanCanonicalize (H12AffineFastState.compose env7460 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 0) := by decide +kernel

theorem selectedBound7460 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7461 : List Nat := [2,4,8,16,32,64,88,4,80,1024,0,1076,8,1124,33,115,1092,0,1025,33,1077,0,96,82,89,49,1,1125,1044,0,1024,0,5,32,1093,81]

theorem envBound7461 : H12AffineFastState.Bounded env7461 := by
  intro p hp
  have h : env7461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7460_7461 : H12AffineEnvironment.transform 31 0 env7460 = env7461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 0 env7460 == env7461) = true)

theorem identity7461 : scanCanonicalize (H12AffineFastState.compose env7461 (packedSelected [0,2] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound7461 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env7462 : List Nat := [2,4,8,16,32,42,50,4,58,1024,0,1076,8,1038,33,25,1070,0,1025,33,1077,0,10,56,51,49,1,1039,1044,0,1024,0,5,32,1071,59]

theorem envBound7462 : H12AffineFastState.Bounded env7462 := by
  intro p hp
  have h : env7462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7461_7462 : H12AffineEnvironment.transform 5 42 env7461 = env7462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env7461 == env7462) = true)

def env7463 : List Nat := [2,4,8,16,0,10,18,4,26,1024,0,1044,8,1038,1,25,1038,0,1025,1,1045,0,10,24,19,17,1,1039,1044,0,1024,0,5,0,1039,27]

theorem envBound7463 : H12AffineFastState.Bounded env7463 := by
  intro p hp
  have h : env7463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7462_7463 : H12AffineEnvironment.transform 4 0 env7462 = env7463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7462 == env7463) = true)

theorem identity7463 : scanCanonicalize (H12AffineFastState.compose env7463 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7463 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7464 : List Nat := [2,4,2,16,0,0,18,4,16,1024,0,1044,2,1028,1,19,1028,0,1025,1,1045,0,0,18,19,17,1,1029,1044,0,1024,0,5,0,1029,17]

theorem envBound7464 : H12AffineFastState.Bounded env7464 := by
  intro p hp
  have h : env7464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7463_7464 : H12AffineEnvironment.transform 2 2 env7463 = env7464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7463 == env7464) = true)

def leafEnv7464 : List Nat := [2,4,2,16,0,0,18,4,16,1024,0,1044,2,1028,1,19,1028,0,1025,1,1045,0,0,18,1025,19,1,17,1,1029,1044,0,1024,0,5,0,5,2,1029,17,0,1045,1]

def active7464 : List Nat := [0,1,3,9]

def tree7464 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7464 : H12WitnessSearch.Good tree7464 := H12GlobalWitnessIndex.good

theorem leafIdentity7464 : H12AffineFastState.composeSystem env7464 rootObs = leafEnv7464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7464 rootObs == leafEnv7464) = true)

theorem terminalChecked7464 : H12PackedTerminal.terminalCheckFast leafEnv7464 active7464 tree7464 = true := by decide +kernel

def env7465 : List Nat := [2,4,8,16,1,11,19,4,27,1024,0,1045,8,1038,0,25,1039,0,1025,0,1044,0,10,25,18,16,1,1039,1044,0,1024,0,5,1,1038,26]

theorem envBound7465 : H12AffineFastState.Bounded env7465 := by
  intro p hp
  have h : env7465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7462_7465 : H12AffineEnvironment.transform 4 1 env7462 = env7465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7462 == env7465) = true)

theorem identity7465 : scanCanonicalize (H12AffineFastState.compose env7465 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7465 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7466 : List Nat := [2,4,8,1,1,11,2,4,10,1024,0,1028,8,1038,0,8,1039,0,1025,0,1029,0,10,8,3,1,1,1039,1029,0,1024,0,5,1,1038,11]

theorem envBound7466 : H12AffineFastState.Bounded env7466 := by
  intro p hp
  have h : env7466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7465_7466 : H12AffineEnvironment.transform 3 1 env7465 = env7466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7465 == env7466) = true)

def leafEnv7466 : List Nat := [2,4,8,1,1,11,2,4,10,1024,0,1028,8,1038,0,8,1039,0,1025,0,1029,0,10,8,1025,3,1,1,1,1039,1029,0,1024,0,5,1,5,3,1038,11,0,1028,1]

def active7466 : List Nat := [0,1,2,9]

def tree7466 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7466 : H12WitnessSearch.Good tree7466 := H12GlobalWitnessIndex.good

theorem leafIdentity7466 : H12AffineFastState.composeSystem env7466 rootObs = leafEnv7466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7466 rootObs == leafEnv7466) = true)

theorem terminalChecked7466 : H12PackedTerminal.terminalCheckFast leafEnv7466 active7466 tree7466 = true := by decide +kernel

def env7467 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,269,4177,293,170,1344,0,1025,293,4097,261,5457,139,388,5377,1,4176,1296,0,1284,4294967296,257,4294967589,1345,136]

theorem envBound7467 : H12AffineFastState.Bounded env7467 := by
  intro p hp
  have h : env7467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7456_7467 : H12AffineEnvironment.transform 8 137 env7456 = env7467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7456 == env7467) = true)

theorem identity7467 : scanCanonicalize (H12AffineFastState.compose env7467 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7467 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7468 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,269,1344,293,170,1344,0,1025,293,1296,261,64,139,388,16,1,1345,1296,0,1284,4294967296,257,4294967589,1345,136]

theorem envBound7468 : H12AffineFastState.Bounded env7468 := by
  intro p hp
  have h : env7468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7467_7468 : H12AffineEnvironment.transform 11 1297 env7467 = env7468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7467 == env7468) = true)

def env7469 : List Nat := [2,4,8,16,32,64,8,256,1,1024,0,1297,269,1344,293,34,1344,0,1025,293,1296,261,64,3,268,16,1,1345,1296,0,1284,4294967296,257,4294967589,1345,0]

theorem envBound7469 : H12AffineFastState.Bounded env7469 := by
  intro p hp
  have h : env7469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7468_7469 : H12AffineEnvironment.transform 6 8 env7468 = env7469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7468 == env7469) = true)

theorem identity7469 : scanCanonicalize (H12AffineFastState.compose env7469 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound7469 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7470 : List Nat := [2,4,8,16,32,64,8,256,1,1024,0,1297,269,1344,293,34,1344,0,1025,293,1296,261,64,3,268,16,1,1345,1296,0,1284,123,257,350,1345,0]

theorem envBound7470 : H12AffineFastState.Bounded env7470 := by
  intro p hp
  have h : env7470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7469_7470 : H12AffineEnvironment.transform 31 123 env7469 = env7470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env7469 == env7470) = true)

def env7471 : List Nat := [2,4,8,16,32,16,8,256,1,1024,0,1297,269,1296,293,34,1296,0,1025,293,1296,261,16,3,268,16,1,1297,1296,0,1284,43,257,270,1297,0]

theorem envBound7471 : H12AffineFastState.Bounded env7471 := by
  intro p hp
  have h : env7471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7470_7471 : H12AffineEnvironment.transform 5 16 env7470 = env7471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7470 == env7471) = true)

theorem identity7471 : scanCanonicalize (H12AffineFastState.compose env7471 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7471 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7472 : List Nat := [2,4,8,16,32,16,8,31,1,1024,0,1038,18,1039,58,34,1039,0,1025,58,1039,26,16,3,19,16,1,1038,1039,0,1051,43,30,17,1038,0]

theorem envBound7472 : H12AffineFastState.Bounded env7472 := by
  intro p hp
  have h : env7472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7471_7472 : H12AffineEnvironment.transform 7 31 env7471 = env7472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7471 == env7472) = true)

def env7473 : List Nat := [2,4,8,16,16,16,8,31,1,1024,0,1038,18,1039,10,18,1039,0,1025,10,1039,26,16,3,19,16,1,1038,1039,0,1051,27,30,17,1038,0]

theorem envBound7473 : H12AffineFastState.Bounded env7473 := by
  intro p hp
  have h : env7473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7472_7473 : H12AffineEnvironment.transform 4 16 env7472 = env7473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7472 == env7473) = true)

theorem identity7473 : scanCanonicalize (H12AffineFastState.compose env7473 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7473 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7474 : List Nat := [2,4,8,10,10,10,8,5,1,1024,0,1038,8,1039,10,8,1039,0,1025,10,1039,0,10,3,9,10,1,1038,1039,0,1025,1,4,11,1038,0]

theorem envBound7474 : H12AffineFastState.Bounded env7474 := by
  intro p hp
  have h : env7474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7473_7474 : H12AffineEnvironment.transform 3 10 env7473 = env7474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7473 == env7474) = true)

def leafEnv7474 : List Nat := [2,4,8,10,10,10,8,5,1,1024,0,1038,8,1039,10,8,1039,0,1025,10,1039,0,10,3,1024,9,1,10,1,1038,1039,0,1025,1,4,11,5,8,1038,0,0,1038,1]

def active7474 : List Nat := [0,1,2,9]

def tree7474 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7474 : H12WitnessSearch.Good tree7474 := H12GlobalWitnessIndex.good

theorem leafIdentity7474 : H12AffineFastState.composeSystem env7474 rootObs = leafEnv7474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7474 rootObs == leafEnv7474) = true)

theorem terminalChecked7474 : H12PackedTerminal.terminalCheckFast leafEnv7474 active7474 tree7474 = true := by decide +kernel

def env7475 : List Nat := [2,4,8,16,17,16,8,31,1,1024,0,1038,18,1039,11,19,1039,0,1025,11,1039,26,16,3,19,16,1,1038,1039,0,1051,26,30,17,1038,0]

theorem envBound7475 : H12AffineFastState.Bounded env7475 := by
  intro p hp
  have h : env7475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7472_7475 : H12AffineEnvironment.transform 4 17 env7472 = env7475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7472 == env7475) = true)

theorem identity7475 : scanCanonicalize (H12AffineFastState.compose env7475 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7475 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7476 : List Nat := [2,4,8,0,1,0,8,15,1,1024,0,1038,2,1039,11,3,1039,0,1025,11,1039,10,0,3,3,0,1,1038,1039,0,1035,10,14,1,1038,0]

theorem envBound7476 : H12AffineFastState.Bounded env7476 := by
  intro p hp
  have h : env7476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7475_7476 : H12AffineEnvironment.transform 3 0 env7475 = env7476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7475 == env7476) = true)

def leafEnv7476 : List Nat := [2,4,8,0,1,0,8,15,1,1024,0,1038,2,1039,11,3,1039,0,1025,11,1039,10,0,3,1034,3,1,0,1,1038,1039,0,1035,10,14,1,5,3,1038,0,0,1038,1]

def active7476 : List Nat := [0,1,2,9]

def tree7476 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7476 : H12WitnessSearch.Good tree7476 := H12GlobalWitnessIndex.good

theorem leafIdentity7476 : H12AffineFastState.composeSystem env7476 rootObs = leafEnv7476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7476 rootObs == leafEnv7476) = true)

theorem terminalChecked7476 : H12PackedTerminal.terminalCheckFast leafEnv7476 active7476 tree7476 = true := by decide +kernel

def env7477 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1297,269,1297,293,34,1297,0,1025,293,1296,261,17,3,268,16,1,1296,1296,0,1284,42,257,271,1296,0]

theorem envBound7477 : H12AffineFastState.Bounded env7477 := by
  intro p hp
  have h : env7477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7470_7477 : H12AffineEnvironment.transform 5 17 env7470 = env7477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7470 == env7477) = true)

theorem identity7477 : scanCanonicalize (H12AffineFastState.compose env7477 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound7477 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7478 : List Nat := [2,4,8,16,26,17,8,256,1,1024,0,1297,269,1297,287,24,1297,0,1025,287,1296,261,17,3,268,16,1,1296,1296,0,1284,16,257,271,1296,0]

theorem envBound7478 : H12AffineFastState.Bounded env7478 := by
  intro p hp
  have h : env7478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7477_7478 : H12AffineEnvironment.transform 4 26 env7477 = env7478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env7477 == env7478) = true)

def env7479 : List Nat := [2,4,8,16,26,17,8,20,1,1024,0,1029,25,1029,11,24,1029,0,1025,11,1028,17,17,3,24,16,1,1028,1028,0,1040,16,21,27,1028,0]

theorem envBound7479 : H12AffineFastState.Bounded env7479 := by
  intro p hp
  have h : env7479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7478_7479 : H12AffineEnvironment.transform 7 20 env7478 = env7479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7478 == env7479) = true)

theorem identity7479 : scanCanonicalize (H12AffineFastState.compose env7479 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7479 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7480 : List Nat := [2,4,8,0,10,1,8,4,1,1024,0,1029,9,1029,11,8,1029,0,1025,11,1028,1,1,3,8,0,1,1028,1028,0,1024,0,5,11,1028,0]

theorem envBound7480 : H12AffineFastState.Bounded env7480 := by
  intro p hp
  have h : env7480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7479_7480 : H12AffineEnvironment.transform 3 0 env7479 = env7480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7479 == env7480) = true)

def leafEnv7480 : List Nat := [2,4,8,0,10,1,8,4,1,1024,0,1029,9,1029,11,8,1029,0,1025,11,1028,1,1,3,1025,8,1,0,1,1028,1028,0,1024,0,5,11,5,8,1028,0,0,1029,1]

def active7480 : List Nat := [0,1,2,9]

def tree7480 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7480 : H12WitnessSearch.Good tree7480 := H12GlobalWitnessIndex.good

theorem leafIdentity7480 : H12AffineFastState.composeSystem env7480 rootObs = leafEnv7480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7480 rootObs == leafEnv7480) = true)

theorem terminalChecked7480 : H12PackedTerminal.terminalCheckFast leafEnv7480 active7480 tree7480 = true := by decide +kernel

def env7481 : List Nat := [2,4,8,16,26,17,8,21,1,1024,0,1028,24,1028,10,24,1028,0,1025,10,1029,16,17,3,25,16,1,1029,1029,0,1041,16,20,26,1029,0]

theorem envBound7481 : H12AffineFastState.Bounded env7481 := by
  intro p hp
  have h : env7481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7478_7481 : H12AffineEnvironment.transform 7 21 env7478 = env7481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7478 == env7481) = true)

theorem identity7481 : scanCanonicalize (H12AffineFastState.compose env7481 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7481 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7482 : List Nat := [2,4,8,10,0,11,8,15,1,1024,0,1028,2,1028,10,2,1028,0,1025,10,1029,10,11,3,3,10,1,1029,1029,0,1035,10,14,0,1029,0]

theorem envBound7482 : H12AffineFastState.Bounded env7482 := by
  intro p hp
  have h : env7482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7481_7482 : H12AffineEnvironment.transform 3 10 env7481 = env7482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7481 == env7482) = true)

def leafEnv7482 : List Nat := [2,4,8,10,0,11,8,15,1,1024,0,1028,2,1028,10,2,1028,0,1025,10,1029,10,11,3,1034,3,1,10,1,1029,1029,0,1035,10,14,0,5,2,1029,0,0,1028,1]

def active7482 : List Nat := [0,1,2,9]

def tree7482 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7482 : H12WitnessSearch.Good tree7482 := H12GlobalWitnessIndex.good

theorem leafIdentity7482 : H12AffineFastState.composeSystem env7482 rootObs = leafEnv7482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7482 rootObs == leafEnv7482) = true)

theorem terminalChecked7482 : H12PackedTerminal.terminalCheckFast leafEnv7482 active7482 tree7482 = true := by decide +kernel

def env7483 : List Nat := [2,4,8,16,32,64,9,256,0,1024,0,1297,269,1344,293,35,1344,0,1025,293,1296,261,64,2,269,16,1,1345,1296,0,1284,4294967296,257,4294967589,1345,1]

theorem envBound7483 : H12AffineFastState.Bounded env7483 := by
  intro p hp
  have h : env7483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7468_7483 : H12AffineEnvironment.transform 6 9 env7468 = env7483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7468 == env7483) = true)

theorem identity7483 : scanCanonicalize (H12AffineFastState.compose env7483 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 350) := by decide +kernel

theorem selectedBound7483 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7484 : List Nat := [2,4,8,16,32,64,9,256,0,1024,0,1297,269,1344,293,35,1344,0,1025,293,1296,261,64,2,269,16,1,1345,1296,0,1284,350,257,123,1345,1]

theorem envBound7484 : H12AffineFastState.Bounded env7484 := by
  intro p hp
  have h : env7484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7483_7484 : H12AffineEnvironment.transform 31 350 env7483 = env7484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 350 env7483 == env7484) = true)

def env7485 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,1297,269,1296,293,35,1296,0,1025,293,1296,261,16,2,269,16,1,1297,1296,0,1284,270,257,43,1297,1]

theorem envBound7485 : H12AffineFastState.Bounded env7485 := by
  intro p hp
  have h : env7485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7484_7485 : H12AffineEnvironment.transform 5 16 env7484 = env7485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7484 == env7485) = true)

theorem identity7485 : scanCanonicalize (H12AffineFastState.compose env7485 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound7485 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7486 : List Nat := [2,4,8,16,26,16,9,256,0,1024,0,1297,269,1296,287,25,1296,0,1025,287,1296,261,16,2,269,16,1,1297,1296,0,1284,270,257,17,1297,1]

theorem envBound7486 : H12AffineFastState.Bounded env7486 := by
  intro p hp
  have h : env7486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7485_7486 : H12AffineEnvironment.transform 4 26 env7485 = env7486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env7485 == env7486) = true)

def env7487 : List Nat := [2,4,8,16,26,16,9,20,0,1024,0,1029,25,1028,11,25,1028,0,1025,11,1028,17,16,2,25,16,1,1029,1028,0,1040,26,21,17,1029,1]

theorem envBound7487 : H12AffineFastState.Bounded env7487 := by
  intro p hp
  have h : env7487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7486_7487 : H12AffineEnvironment.transform 7 20 env7486 = env7487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7486 == env7487) = true)

theorem identity7487 : scanCanonicalize (H12AffineFastState.compose env7487 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7487 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7488 : List Nat := [2,4,8,11,1,11,9,15,0,1024,0,1029,2,1028,11,2,1028,0,1025,11,1028,10,11,2,2,11,1,1029,1028,0,1035,1,14,10,1029,1]

theorem envBound7488 : H12AffineFastState.Bounded env7488 := by
  intro p hp
  have h : env7488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7487_7488 : H12AffineEnvironment.transform 3 11 env7487 = env7488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7487 == env7488) = true)

def leafEnv7488 : List Nat := [2,4,8,11,1,11,9,15,0,1024,0,1029,2,1028,11,2,1028,0,1025,11,1028,10,11,2,1034,2,1,11,1,1029,1028,0,1035,1,14,10,5,3,1029,1,0,1029,1]

def active7488 : List Nat := [0,1,2,9]

def tree7488 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7488 : H12WitnessSearch.Good tree7488 := H12GlobalWitnessIndex.good

theorem leafIdentity7488 : H12AffineFastState.composeSystem env7488 rootObs = leafEnv7488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7488 rootObs == leafEnv7488) = true)

theorem terminalChecked7488 : H12PackedTerminal.terminalCheckFast leafEnv7488 active7488 tree7488 = true := by decide +kernel

def env7489 : List Nat := [2,4,8,16,26,16,9,21,0,1024,0,1028,24,1029,10,25,1029,0,1025,10,1029,16,16,2,24,16,1,1028,1029,0,1041,27,20,17,1028,1]

theorem envBound7489 : H12AffineFastState.Bounded env7489 := by
  intro p hp
  have h : env7489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7486_7489 : H12AffineEnvironment.transform 7 21 env7486 = env7489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7486 == env7489) = true)

theorem identity7489 : scanCanonicalize (H12AffineFastState.compose env7489 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7489 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7490 : List Nat := [2,4,8,0,10,0,9,5,0,1024,0,1028,8,1029,10,9,1029,0,1025,10,1029,0,0,2,8,0,1,1028,1029,0,1025,11,4,1,1028,1]

theorem envBound7490 : H12AffineFastState.Bounded env7490 := by
  intro p hp
  have h : env7490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7489_7490 : H12AffineEnvironment.transform 3 0 env7489 = env7490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7489 == env7490) = true)

def leafEnv7490 : List Nat := [2,4,8,0,10,0,9,5,0,1024,0,1028,8,1029,10,9,1029,0,1025,10,1029,0,0,2,1024,8,1,0,1,1028,1029,0,1025,11,4,1,5,8,1028,1,0,1028,1]

def active7490 : List Nat := [0,1,2,9]

def tree7490 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7490 : H12WitnessSearch.Good tree7490 := H12GlobalWitnessIndex.good

theorem leafIdentity7490 : H12AffineFastState.composeSystem env7490 rootObs = leafEnv7490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7490 rootObs == leafEnv7490) = true)

theorem terminalChecked7490 : H12PackedTerminal.terminalCheckFast leafEnv7490 active7490 tree7490 = true := by decide +kernel

def env7491 : List Nat := [2,4,8,16,32,17,9,256,0,1024,0,1297,269,1297,293,35,1297,0,1025,293,1296,261,17,2,269,16,1,1296,1296,0,1284,271,257,42,1296,1]

theorem envBound7491 : H12AffineFastState.Bounded env7491 := by
  intro p hp
  have h : env7491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7484_7491 : H12AffineEnvironment.transform 5 17 env7484 = env7491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7484 == env7491) = true)

theorem identity7491 : scanCanonicalize (H12AffineFastState.compose env7491 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7491 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7492 : List Nat := [2,4,8,16,32,17,9,31,0,1024,0,1038,18,1038,58,35,1038,0,1025,58,1039,26,17,2,18,16,1,1039,1039,0,1051,16,30,42,1039,1]

theorem envBound7492 : H12AffineFastState.Bounded env7492 := by
  intro p hp
  have h : env7492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7491_7492 : H12AffineEnvironment.transform 7 31 env7491 = env7492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7491 == env7492) = true)

def env7493 : List Nat := [2,4,8,16,16,17,9,31,0,1024,0,1038,18,1038,10,19,1038,0,1025,10,1039,26,17,2,18,16,1,1039,1039,0,1051,16,30,26,1039,1]

theorem envBound7493 : H12AffineFastState.Bounded env7493 := by
  intro p hp
  have h : env7493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7492_7493 : H12AffineEnvironment.transform 4 16 env7492 = env7493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7492 == env7493) = true)

theorem identity7493 : scanCanonicalize (H12AffineFastState.compose env7493 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7493 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7494 : List Nat := [2,4,8,0,0,1,9,15,0,1024,0,1038,2,1038,10,3,1038,0,1025,10,1039,10,1,2,2,0,1,1039,1039,0,1035,0,14,10,1039,1]

theorem envBound7494 : H12AffineFastState.Bounded env7494 := by
  intro p hp
  have h : env7494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7493_7494 : H12AffineEnvironment.transform 3 0 env7493 = env7494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7493 == env7494) = true)

def leafEnv7494 : List Nat := [2,4,8,0,0,1,9,15,0,1024,0,1038,2,1038,10,3,1038,0,1025,10,1039,10,1,2,1034,2,1,0,1,1039,1039,0,1035,0,14,10,5,2,1039,1,0,1038,1]

def active7494 : List Nat := [0,1,2,9]

def tree7494 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7494 : H12WitnessSearch.Good tree7494 := H12GlobalWitnessIndex.good

theorem leafIdentity7494 : H12AffineFastState.composeSystem env7494 rootObs = leafEnv7494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7494 rootObs == leafEnv7494) = true)

theorem terminalChecked7494 : H12PackedTerminal.terminalCheckFast leafEnv7494 active7494 tree7494 = true := by decide +kernel

def env7495 : List Nat := [2,4,8,16,17,17,9,31,0,1024,0,1038,18,1038,11,18,1038,0,1025,11,1039,26,17,2,18,16,1,1039,1039,0,1051,16,30,27,1039,1]

theorem envBound7495 : H12AffineFastState.Bounded env7495 := by
  intro p hp
  have h : env7495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7492_7495 : H12AffineEnvironment.transform 4 17 env7492 = env7495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7492 == env7495) = true)

theorem identity7495 : scanCanonicalize (H12AffineFastState.compose env7495 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7495 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7496 : List Nat := [2,4,8,11,10,10,9,4,0,1024,0,1038,9,1038,11,9,1038,0,1025,11,1039,1,10,2,9,11,1,1039,1039,0,1024,11,5,0,1039,1]

theorem envBound7496 : H12AffineFastState.Bounded env7496 := by
  intro p hp
  have h : env7496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7495_7496 : H12AffineEnvironment.transform 3 11 env7495 = env7496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7495 == env7496) = true)

def leafEnv7496 : List Nat := [2,4,8,11,10,10,9,4,0,1024,0,1038,9,1038,11,9,1038,0,1025,11,1039,1,10,2,1025,9,1,11,1,1039,1039,0,1024,11,5,0,5,8,1039,1,0,1038,1]

def active7496 : List Nat := [0,1,2,9]

def tree7496 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7496 : H12WitnessSearch.Good tree7496 := H12GlobalWitnessIndex.good

theorem leafIdentity7496 : H12AffineFastState.composeSystem env7496 rootObs = leafEnv7496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7496 rootObs == leafEnv7496) = true)

theorem terminalChecked7496 : H12PackedTerminal.terminalCheckFast leafEnv7496 active7496 tree7496 = true := by decide +kernel

def env7497 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,8200,17664,98565,8329,5377,291164,16385,1297,303777,1285,4294967296,257,4295620086,1344,513]

theorem envBound7497 : H12AffineFastState.Bounded env7497 := by
  intro p hp
  have h : env7497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7421_7497 : H12AffineEnvironment.transform 16 1345 env7421 = env7497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env7421 == env7497) = true)

theorem identity7497 : scanCanonicalize (H12AffineFastState.compose env7497 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound7497 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env7498 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,8192,16384,32768,65536,1345,262144,524288,32768,1945,8200,17664,98565,8329,665,288452,16385,1297,303777,1285,4294967296,257,4295615086,1344,513]

theorem envBound7498 : H12AffineFastState.Bounded env7498 := by
  intro p hp
  have h : env7498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7497_7498 : H12AffineEnvironment.transform 11 1944 env7497 = env7498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env7497 == env7498) = true)

theorem identity7498 : scanCanonicalize (H12AffineFastState.compose env7498 (packedSelected [4,16,22] rootPS)) = affineNative (2^(18+1) ^^^ 17352) := by decide +kernel

theorem selectedBound7498 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env7499 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,8192,16384,32768,65536,1345,262144,17352,32768,1945,8200,17664,98565,8329,665,288452,16385,1297,303777,1285,4294967296,257,4295074214,1344,513]

theorem envBound7499 : H12AffineFastState.Bounded env7499 := by
  intro p hp
  have h : env7499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7498_7499 : H12AffineEnvironment.transform 18 17352 env7498 = env7499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 17352 env7498 == env7499) = true)

theorem identity7499 : scanCanonicalize (H12AffineFastState.compose env7499 (packedSelected [4,9,16] rootPS)) = affineNative (2^(17+1) ^^^ 83434) := by decide +kernel

theorem selectedBound7499 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7500 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,8192,16384,32768,65536,1345,83434,17352,32768,1945,8200,17664,98565,8329,665,74542,16385,1297,124747,1285,4294967296,257,4295074214,1344,513]

theorem envBound7500 : H12AffineFastState.Bounded env7500 := by
  intro p hp
  have h : env7500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7499_7500 : H12AffineEnvironment.transform 17 83434 env7499 = env7500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 83434 env7499 == env7500) = true)

theorem identity7500 : scanCanonicalize (H12AffineFastState.compose env7500 (packedSelected [3,8,10,13,17] rootPS)) = affineNative (2^(15+1) ^^^ 41382) := by decide +kernel

theorem selectedBound7500 : packedSelected [3,8,10,13,17] rootPS < 2^1333 := by decide +kernel

def env7501 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,8192,16384,32768,41382,1345,58444,17352,32768,1945,8200,17664,8355,8329,665,33416,16385,1297,18157,1285,4294967296,257,4294967296,1344,513]

theorem envBound7501 : H12AffineFastState.Bounded env7501 := by
  intro p hp
  have h : env7501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7500_7501 : H12AffineEnvironment.transform 15 41382 env7500 = env7501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 41382 env7500 == env7501) = true)

theorem identity7501 : scanCanonicalize (H12AffineFastState.compose env7501 (packedSelected [1,3,5,8,12,13,15,21] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound7501 : packedSelected [1,3,5,8,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env7502 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,901,16384,32768,33315,1345,51145,17352,32768,1945,909,17664,806,780,665,33416,16385,1297,18157,1285,4294967296,257,4294967296,1344,513]

theorem envBound7502 : H12AffineFastState.Bounded env7502 := by
  intro p hp
  have h : env7502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7501_7502 : H12AffineEnvironment.transform 12 901 env7501 = env7502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env7501 == env7502) = true)

theorem identity7502 : scanCanonicalize (H12AffineFastState.compose env7502 (packedSelected [0,1,2,4,5,6,10,12,15] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound7502 : packedSelected [0,1,2,4,5,6,10,12,15] rootPS < 2^1333 := by decide +kernel

def env7503 : List Nat := [2,4,8,16,32,64,128,256,429,1024,0,1077,40,16384,32768,33166,1345,50276,16485,32768,1076,32,17664,139,161,308,33061,16385,1297,17728,1285,4294967296,257,4294967296,1344,428]

theorem envBound7503 : H12AffineFastState.Bounded env7503 := by
  intro p hp
  have h : env7503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7502_7503 : H12AffineEnvironment.transform 8 429 env7502 = env7503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env7502 == env7503) = true)

theorem identity7503 : scanCanonicalize (H12AffineFastState.compose env7503 (packedSelected [1,3,5,8] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound7503 : packedSelected [1,3,5,8] rootPS < 2^1333 := by decide +kernel

def env7504 : List Nat := [2,4,8,16,32,64,128,256,429,1024,0,1077,40,16384,292,170,1345,17728,16485,292,1076,32,17664,139,161,308,1,16385,1297,17728,1285,4294967296,257,4294967296,1344,428]

theorem envBound7504 : H12AffineFastState.Bounded env7504 := by
  intro p hp
  have h : env7504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7503_7504 : H12AffineEnvironment.transform 14 292 env7503 = env7504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env7503 == env7504) = true)

theorem identity7504 : scanCanonicalize (H12AffineFastState.compose env7504 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7504 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7505 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1077,40,16384,0,170,1125,17508,16485,0,1076,32,17444,139,161,16,1,16385,1077,17508,1057,4294967296,37,4294967296,1124,136]

theorem envBound7505 : H12AffineFastState.Bounded env7505 := by
  intro p hp
  have h : env7505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7504_7505 : H12AffineEnvironment.transform 7 36 env7504 = env7505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7504 == env7505) = true)

theorem identity7505 : scanCanonicalize (H12AffineFastState.compose env7505 (packedSelected [1,3] rootPS)) = affineNative (2^(13+1) ^^^ 1124) := by decide +kernel

theorem selectedBound7505 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7506 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1077,40,1124,0,170,1125,0,1025,0,1076,32,64,139,161,16,1,1125,1077,0,1057,4294967296,37,4294967296,1124,136]

theorem envBound7506 : H12AffineFastState.Bounded env7506 := by
  intro p hp
  have h : env7506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7505_7506 : H12AffineEnvironment.transform 13 1124 env7505 = env7506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1124 env7505 == env7506) = true)

theorem identity7506 : scanCanonicalize (H12AffineFastState.compose env7506 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 27) := by decide +kernel

theorem selectedBound7506 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7507 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1077,40,1124,0,170,1125,0,1025,0,1076,32,64,139,161,16,1,1125,1077,0,1057,27,37,27,1124,136]

theorem envBound7507 : H12AffineFastState.Bounded env7507 := by
  intro p hp
  have h : env7507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7506_7507 : H12AffineEnvironment.transform 31 27 env7506 = env7507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 27 env7506 == env7507) = true)

theorem identity7507 : scanCanonicalize (H12AffineFastState.compose env7507 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound7507 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7508 : List Nat := [2,4,8,16,32,10,128,36,137,1024,0,1077,40,1070,0,170,1071,0,1025,0,1076,32,10,139,161,16,1,1071,1077,0,1057,27,37,27,1070,136]

theorem envBound7508 : H12AffineFastState.Bounded env7508 := by
  intro p hp
  have h : env7508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7507_7508 : H12AffineEnvironment.transform 5 10 env7507 = env7508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env7507 == env7508) = true)

def env7509 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8201,17664,230468,8329,2098432,2515997,2117632,131152,1073741824,131140,4294967296,257,4297842871,131073,513]

theorem envBound7509 : H12AffineFastState.Bounded env7509 := by
  intro p hp
  have h : env7509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7412_7509 : H12AffineEnvironment.transform 10 1 env7412 = env7509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env7412 == env7509) = true)

def env7510 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17664,230468,8329,5376,422941,16384,131152,1073741824,131140,4294967296,257,4295749815,131073,513]

theorem envBound7510 : H12AffineFastState.Bounded env7510 := by
  intro p hp
  have h : env7510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7509_7510 : H12AffineEnvironment.transform 20 4096 env7509 = env7510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env7509 == env7510) = true)

theorem identity7510 : scanCanonicalize (H12AffineFastState.compose env7510 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 18329) := by decide +kernel

theorem selectedBound7510 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7511 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17664,230468,8329,5376,422941,16384,131152,18329,131140,4294967296,257,4295749815,131073,513]

theorem envBound7511 : H12AffineFastState.Bounded env7511 := by
  intro p hp
  have h : env7511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7510_7511 : H12AffineEnvironment.transform 29 18329 env7510 = env7511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 18329 env7510 == env7511) = true)

theorem identity7511 : scanCanonicalize (H12AffineFastState.compose env7511 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound7511 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env7512 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,8201,17664,230468,8329,5376,422941,16384,131152,18329,131140,4294967296,257,4295206118,131073,513]

theorem envBound7512 : H12AffineFastState.Bounded env7512 := by
  intro p hp
  have h : env7512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7511_7512 : H12AffineEnvironment.transform 18 21585 env7511 = env7512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env7511 == env7512) = true)

theorem identity7512 : scanCanonicalize (H12AffineFastState.compose env7512 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 59163) := by decide +kernel

theorem selectedBound7512 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7513 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,59163,131072,262144,21585,32768,4096,8201,17664,156511,8329,5376,422941,16384,131152,18329,131140,4294967296,257,4295115773,131073,513]

theorem envBound7513 : H12AffineFastState.Bounded env7513 := by
  intro p hp
  have h : env7513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7512_7513 : H12AffineEnvironment.transform 15 59163 env7512 = env7513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 59163 env7512 == env7513) = true)

theorem identity7513 : scanCanonicalize (H12AffineFastState.compose env7513 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound7513 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7514 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,46922,131072,262144,1024,32768,4096,8201,5457,144142,8329,5376,402508,4177,131152,6088,131140,4294967296,257,4295103404,131073,513]

theorem envBound7514 : H12AffineFastState.Bounded env7514 := by
  intro p hp
  have h : env7514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7513_7514 : H12AffineEnvironment.transform 13 4177 env7513 = env7514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7513 == env7514) = true)

theorem identity7514 : scanCanonicalize (H12AffineFastState.compose env7514 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound7514 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env7515 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8540,5654,131072,262144,1024,8540,4096,8201,5457,144142,8329,5376,402508,4177,131152,6088,131140,4294967296,257,4295103404,131073,513]

theorem envBound7515 : H12AffineFastState.Bounded env7515 := by
  intro p hp
  have h : env7515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7514_7515 : H12AffineEnvironment.transform 14 8540 env7514 = env7515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env7514 == env7515) = true)

def env7516 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17664,230468,8329,5377,422940,16385,131152,1073741824,131140,4294967296,257,4295749814,131073,513]

theorem envBound7516 : H12AffineFastState.Bounded env7516 := by
  intro p hp
  have h : env7516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7509_7516 : H12AffineEnvironment.transform 20 4097 env7509 = env7516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env7509 == env7516) = true)

theorem identity7516 : scanCanonicalize (H12AffineFastState.compose env7516 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 21209) := by decide +kernel

theorem selectedBound7516 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7517 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17664,230468,8329,5377,422940,16385,131152,21209,131140,4294967296,257,4295749814,131073,513]

theorem envBound7517 : H12AffineFastState.Bounded env7517 := by
  intro p hp
  have h : env7517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7516_7517 : H12AffineEnvironment.transform 29 21209 env7516 = env7517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21209 env7516 == env7517) = true)

def env7518 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4824,32768,65536,131072,262144,524288,32768,4097,8201,6104,230468,8329,5377,403140,4825,131152,1,131140,4294967296,257,4295729774,131073,513]

theorem envBound7518 : H12AffineFastState.Bounded env7518 := by
  intro p hp
  have h : env7518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7517_7518 : H12AffineEnvironment.transform 13 4824 env7517 = env7518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env7517 == env7518) = true)

theorem identity7518 : scanCanonicalize (H12AffineFastState.compose env7518 (packedSelected [0,4,7,18,20,22] rootPS)) = affineNative (2^(17+1) ^^^ 41632) := by decide +kernel

theorem selectedBound7518 : packedSelected [0,4,7,18,20,22] rootPS < 2^1333 := by decide +kernel

def env7519 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4824,32768,65536,131072,41632,524288,32768,4097,8201,6104,230468,8329,5377,164964,4825,131152,1,131140,4294967296,257,4295729774,131073,513]

theorem envBound7519 : H12AffineFastState.Bounded env7519 := by
  intro p hp
  have h : env7519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7518_7519 : H12AffineEnvironment.transform 17 41632 env7518 = env7519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41632 env7518 == env7519) = true)

theorem identity7519 : scanCanonicalize (H12AffineFastState.compose env7519 (packedSelected [0,2,6,9,18,20,23] rootPS)) = affineNative (2^(16+1) ^^^ 9925) := by decide +kernel

theorem selectedBound7519 : packedSelected [0,2,6,9,18,20,23] rootPS < 2^1333 := by decide +kernel

def env7520 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4824,32768,65536,9925,41632,524288,32768,4097,8201,6104,107137,8329,5377,41633,4825,9877,1,9857,4294967296,257,4295591083,9924,513]

theorem envBound7520 : H12AffineFastState.Bounded env7520 := by
  intro p hp
  have h : env7520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7519_7520 : H12AffineEnvironment.transform 16 9925 env7519 = env7520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9925 env7519 == env7520) = true)

def env7521 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1992,32768,65536,9925,41632,524288,32768,1297,8201,712,107137,8329,17,41633,1993,9877,1,9857,4294967296,257,4295591083,9924,513]

theorem envBound7521 : H12AffineFastState.Bounded env7521 := by
  intro p hp
  have h : env7521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7520_7521 : H12AffineEnvironment.transform 11 1296 env7520 = env7521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7520 == env7521) = true)

theorem identity7521 : scanCanonicalize (H12AffineFastState.compose env7521 (packedSelected [18] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound7521 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env7522 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1992,292,65536,9925,9092,524288,292,1297,8201,712,74661,8329,17,9093,1993,9877,1,9857,4294967296,257,4295558543,9924,513]

theorem envBound7522 : H12AffineFastState.Bounded env7522 := by
  intro p hp
  have h : env7522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7521_7522 : H12AffineEnvironment.transform 14 292 env7521 = env7522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env7521 == env7522) = true)

theorem identity7522 : scanCanonicalize (H12AffineFastState.compose env7522 (packedSelected [1,2,3,6,7,9,10,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound7522 : packedSelected [1,2,3,6,7,9,10,12,13] rootPS < 2^1333 := by decide +kernel

def env7523 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1992,292,65536,1344,1,524288,292,1297,908,712,65568,780,17,0,1993,1296,1,1284,4294967296,257,4295558543,1345,513]

theorem envBound7523 : H12AffineFastState.Bounded env7523 := by
  intro p hp
  have h : env7523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7522_7523 : H12AffineEnvironment.transform 12 901 env7522 = env7523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env7522 == env7523) = true)

def env7524 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1992,292,65536,1344,1,1024,292,1297,908,712,65568,780,17,0,1993,1296,1,1284,4294967296,257,4295033231,1345,513]

theorem envBound7524 : H12AffineFastState.Bounded env7524 := by
  intro p hp
  have h : env7524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7523_7524 : H12AffineEnvironment.transform 18 1024 env7523 = env7524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7523 == env7524) = true)

theorem identity7524 : scanCanonicalize (H12AffineFastState.compose env7524 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound7524 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7525 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1992,292,171,1344,1,1024,292,1297,908,712,139,780,17,0,1993,1296,1,1284,4294967296,257,4294967588,1345,513]

theorem envBound7525 : H12AffineFastState.Bounded env7525 := by
  intro p hp
  have h : env7525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7524_7525 : H12AffineEnvironment.transform 15 171 env7524 = env7525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env7524 == env7525) = true)

theorem identity7525 : scanCanonicalize (H12AffineFastState.compose env7525 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound7525 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7526 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,269,1344,292,171,1344,1,1024,292,1297,260,64,139,388,17,0,1345,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7526 : H12AffineFastState.Bounded env7526 := by
  intro p hp
  have h : env7526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7525_7526 : H12AffineEnvironment.transform 8 136 env7525 = env7526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7525 == env7526) = true)

theorem identity7526 : scanCanonicalize (H12AffineFastState.compose env7526 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7526 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7527 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,41,1124,0,171,1124,1,1024,0,1077,32,64,139,160,17,0,1125,1076,1,1056,4294967296,37,4294967296,1125,137]

theorem envBound7527 : H12AffineFastState.Bounded env7527 := by
  intro p hp
  have h : env7527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7526_7527 : H12AffineEnvironment.transform 7 36 env7526 = env7527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7526 == env7527) = true)

theorem identity7527 : scanCanonicalize (H12AffineFastState.compose env7527 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound7527 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7528 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,41,1124,0,171,1124,1,1024,0,1077,32,64,139,160,17,0,1125,1076,1,1056,42,37,42,1125,137]

theorem envBound7528 : H12AffineFastState.Bounded env7528 := by
  intro p hp
  have h : env7528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7527_7528 : H12AffineEnvironment.transform 31 42 env7527 = env7528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env7527 == env7528) = true)

theorem identity7528 : scanCanonicalize (H12AffineFastState.compose env7528 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound7528 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7529 : List Nat := [2,4,8,16,32,1,128,36,136,1024,1,1076,41,1061,0,171,1061,1,1024,0,1077,32,1,139,160,17,0,1060,1076,1,1056,42,37,42,1060,137]

theorem envBound7529 : H12AffineFastState.Bounded env7529 := by
  intro p hp
  have h : env7529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7528_7529 : H12AffineEnvironment.transform 5 1 env7528 = env7529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env7528 == env7529) = true)

theorem identity7529 : scanCanonicalize (H12AffineFastState.compose env7529 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7529 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7530 : List Nat := [2,4,3,16,32,1,128,36,131,1024,1,1076,34,1061,0,160,1061,1,1024,0,1077,32,1,128,160,17,0,1060,1076,1,1056,33,37,33,1060,130]

theorem envBound7530 : H12AffineFastState.Bounded env7530 := by
  intro p hp
  have h : env7530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7529_7530 : H12AffineEnvironment.transform 2 3 env7529 = env7530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7529 == env7530) = true)

def leafEnv7530 : List Nat := [2,4,3,16,32,1,128,36,131,1024,1,1076,34,1061,0,160,1061,1,1024,0,1077,32,1,128,1056,160,1,17,0,1060,1076,1,1056,33,37,33,5,35,1060,130,0,1077,1]

def active7530 : List Nat := [0,1,3,4,6,9]

def tree7530 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7530 : H12WitnessSearch.Good tree7530 := H12GlobalWitnessIndex.good

theorem leafIdentity7530 : H12AffineFastState.composeSystem env7530 rootObs = leafEnv7530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7530 rootObs == leafEnv7530) = true)

theorem terminalChecked7530 : H12PackedTerminal.terminalCheckFast leafEnv7530 active7530 tree7530 = true := by decide +kernel

def env7531 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1992,292,65536,1344,1,1025,292,1297,908,712,65568,780,17,0,1993,1296,1,1284,4294967296,257,4295033230,1345,513]

theorem envBound7531 : H12AffineFastState.Bounded env7531 := by
  intro p hp
  have h : env7531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7523_7531 : H12AffineEnvironment.transform 18 1025 env7523 = env7531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env7523 == env7531) = true)

theorem identity7531 : scanCanonicalize (H12AffineFastState.compose env7531 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound7531 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7532 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1992,292,546,1344,1,1025,292,1297,908,712,514,780,17,0,1993,1296,1,1284,4294967296,257,4294968236,1345,513]

theorem envBound7532 : H12AffineFastState.Bounded env7532 := by
  intro p hp
  have h : env7532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7531_7532 : H12AffineEnvironment.transform 15 546 env7531 = env7532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env7531 == env7532) = true)

def env7533 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,269,1344,292,170,1344,1,1025,292,1297,260,64,138,388,17,0,1345,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7533 : H12AffineFastState.Bounded env7533 := by
  intro p hp
  have h : env7533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7532_7533 : H12AffineEnvironment.transform 8 136 env7532 = env7533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7532 == env7533) = true)

theorem identity7533 : scanCanonicalize (H12AffineFastState.compose env7533 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 252) := by decide +kernel

theorem selectedBound7533 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7534 : List Nat := [2,4,8,16,32,64,128,252,136,1024,1,1260,241,1212,216,170,1212,1,1025,216,1261,248,64,138,120,17,0,1213,1260,1,1272,4294967296,253,4294967512,1213,137]

theorem envBound7534 : H12AffineFastState.Bounded env7534 := by
  intro p hp
  have h : env7534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7533_7534 : H12AffineEnvironment.transform 7 252 env7533 = env7534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 252 env7533 == env7534) = true)

theorem identity7534 : scanCanonicalize (H12AffineFastState.compose env7534 (packedSelected [0,1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound7534 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env7535 : List Nat := [2,4,8,16,10,64,128,214,136,1024,1,1222,219,1174,216,128,1174,1,1025,216,1223,210,64,138,82,17,0,1175,1222,1,1234,4294967296,215,4294967512,1175,137]

theorem envBound7535 : H12AffineFastState.Bounded env7535 := by
  intro p hp
  have h : env7535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7534_7535 : H12AffineEnvironment.transform 4 10 env7534 = env7535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env7534 == env7535) = true)

theorem identity7535 : scanCanonicalize (H12AffineFastState.compose env7535 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 82) := by decide +kernel

theorem selectedBound7535 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7536 : List Nat := [2,4,8,16,10,64,82,4,90,1024,1,1044,9,1092,10,82,1092,1,1025,10,1045,0,64,88,82,17,0,1093,1044,1,1024,4294967296,5,4294967306,1093,91]

theorem envBound7536 : H12AffineFastState.Bounded env7536 := by
  intro p hp
  have h : env7536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7535_7536 : H12AffineEnvironment.transform 6 82 env7535 = env7536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 82 env7535 == env7536) = true)

theorem identity7536 : scanCanonicalize (H12AffineFastState.compose env7536 (packedSelected [5] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7536 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7537 : List Nat := [2,4,2,16,0,64,82,4,80,1024,1,1044,3,1092,0,82,1092,1,1025,0,1045,0,64,82,82,17,0,1093,1044,1,1024,4294967296,5,4294967296,1093,81]

theorem envBound7537 : H12AffineFastState.Bounded env7537 := by
  intro p hp
  have h : env7537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7536_7537 : H12AffineEnvironment.transform 2 2 env7536 = env7537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7536 == env7537) = true)

theorem identity7537 : scanCanonicalize (H12AffineFastState.compose env7537 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1) := by decide +kernel

theorem selectedBound7537 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7538 : List Nat := [2,4,2,16,0,64,82,4,80,1024,1,1044,3,1092,0,82,1092,1,1025,0,1045,0,64,82,82,17,0,1093,1044,1,1024,1,5,1,1093,81]

theorem envBound7538 : H12AffineFastState.Bounded env7538 := by
  intro p hp
  have h : env7538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7537_7538 : H12AffineEnvironment.transform 31 1 env7537 = env7538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1 env7537 == env7538) = true)

theorem identity7538 : scanCanonicalize (H12AffineFastState.compose env7538 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound7538 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7539 : List Nat := [2,4,2,16,0,1,19,4,17,1024,1,1044,3,1029,0,19,1029,1,1025,0,1045,0,1,19,19,17,0,1028,1044,1,1024,1,5,1,1028,16]

theorem envBound7539 : H12AffineFastState.Bounded env7539 := by
  intro p hp
  have h : env7539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7538_7539 : H12AffineEnvironment.transform 5 1 env7538 = env7539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env7538 == env7539) = true)

def leafEnv7539 : List Nat := [2,4,2,16,0,1,19,4,17,1024,1,1044,3,1029,0,19,1029,1,1025,0,1045,0,1,19,1025,19,1,17,0,1028,1044,1,1024,1,5,1,5,3,1028,16,0,1045,1]

def active7539 : List Nat := [0,1,3,9]

def tree7539 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7539 : H12WitnessSearch.Good tree7539 := H12GlobalWitnessIndex.good

theorem leafIdentity7539 : H12AffineFastState.composeSystem env7539 rootObs = leafEnv7539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7539 rootObs == leafEnv7539) = true)

theorem terminalChecked7539 : H12PackedTerminal.terminalCheckFast leafEnv7539 active7539 tree7539 = true := by decide +kernel

def env7540 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,268,1345,292,171,1344,1,1025,292,1297,261,65,139,389,17,0,1344,1296,1,1284,4294967296,257,4294967589,1345,136]

theorem envBound7540 : H12AffineFastState.Bounded env7540 := by
  intro p hp
  have h : env7540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7532_7540 : H12AffineEnvironment.transform 8 137 env7532 = env7540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7532 == env7540) = true)

def env7541 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1993,32768,65536,9925,41632,524288,32768,1296,8201,713,107137,8329,16,41633,1992,9877,1,9857,4294967296,257,4295591083,9924,513]

theorem envBound7541 : H12AffineFastState.Bounded env7541 := by
  intro p hp
  have h : env7541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7520_7541 : H12AffineEnvironment.transform 11 1297 env7520 = env7541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7520 == env7541) = true)

theorem identity7541 : scanCanonicalize (H12AffineFastState.compose env7541 (packedSelected [18] rootPS)) = affineNative (2^(14+1) ^^^ 8865) := by decide +kernel

theorem selectedBound7541 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env7542 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1993,8865,65536,9925,1,524288,8865,1296,8201,713,65568,8329,16,0,1992,9877,1,9857,4294967296,257,4295566858,9924,513]

theorem envBound7542 : H12AffineFastState.Bounded env7542 := by
  intro p hp
  have h : env7542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7541_7542 : H12AffineEnvironment.transform 14 8865 env7541 = env7542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8865 env7541 == env7542) = true)

theorem identity7542 : scanCanonicalize (H12AffineFastState.compose env7542 (packedSelected [1,3,4,9,10,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound7542 : packedSelected [1,3,4,9,10,12,13] rootPS < 2^1333 := by decide +kernel

def env7543 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,1993,292,65536,1344,1,524288,292,1296,908,713,65568,780,16,0,1992,1296,1,1284,4294967296,257,4295558543,1345,513]

theorem envBound7543 : H12AffineFastState.Bounded env7543 := by
  intro p hp
  have h : env7543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7542_7543 : H12AffineEnvironment.transform 12 901 env7542 = env7543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env7542 == env7543) = true)

def env7544 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,1993,292,65536,1344,1,1024,292,1296,908,713,65568,780,16,0,1992,1296,1,1284,4294967296,257,4295033231,1345,513]

theorem envBound7544 : H12AffineFastState.Bounded env7544 := by
  intro p hp
  have h : env7544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7543_7544 : H12AffineEnvironment.transform 18 1024 env7543 = env7544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7543 == env7544) = true)

theorem identity7544 : scanCanonicalize (H12AffineFastState.compose env7544 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound7544 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7545 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,1993,292,171,1344,1,1024,292,1296,908,713,139,780,16,0,1992,1296,1,1284,4294967296,257,4294967588,1345,513]

theorem envBound7545 : H12AffineFastState.Bounded env7545 := by
  intro p hp
  have h : env7545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7544_7545 : H12AffineEnvironment.transform 15 171 env7544 = env7545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env7544 == env7545) = true)

theorem identity7545 : scanCanonicalize (H12AffineFastState.compose env7545 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound7545 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7546 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,269,1345,292,171,1344,1,1024,292,1296,260,65,139,388,16,0,1344,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7546 : H12AffineFastState.Bounded env7546 := by
  intro p hp
  have h : env7546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7545_7546 : H12AffineEnvironment.transform 8 136 env7545 = env7546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7545 == env7546) = true)

theorem identity7546 : scanCanonicalize (H12AffineFastState.compose env7546 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7546 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7547 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1076,40,1124,1,171,1125,1,1024,1,1077,33,65,139,161,16,0,1125,1077,1,1057,4294967296,36,4294967297,1124,137]

theorem envBound7547 : H12AffineFastState.Bounded env7547 := by
  intro p hp
  have h : env7547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7546_7547 : H12AffineEnvironment.transform 7 37 env7546 = env7547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7546 == env7547) = true)

theorem identity7547 : scanCanonicalize (H12AffineFastState.compose env7547 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 162) := by decide +kernel

theorem selectedBound7547 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7548 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1076,40,1124,1,171,1125,1,1024,1,1077,33,65,139,161,16,0,1125,1077,1,1057,162,36,163,1124,137]

theorem envBound7548 : H12AffineFastState.Bounded env7548 := by
  intro p hp
  have h : env7548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7547_7548 : H12AffineEnvironment.transform 31 162 env7547 = env7548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 162 env7547 == env7548) = true)

theorem identity7548 : scanCanonicalize (H12AffineFastState.compose env7548 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7548 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7549 : List Nat := [2,4,8,1,32,64,128,37,136,1024,1,1061,40,1124,1,171,1125,1,1024,1,1060,33,65,139,161,1,0,1125,1060,1,1057,162,36,163,1124,137]

theorem envBound7549 : H12AffineFastState.Bounded env7549 := by
  intro p hp
  have h : env7549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7548_7549 : H12AffineEnvironment.transform 3 1 env7548 = env7549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7548 == env7549) = true)

def leafEnv7549 : List Nat := [2,4,8,1,32,64,128,37,136,1024,1,1061,40,1124,1,171,1125,1,1024,1,1060,33,65,139,1057,161,1,1,0,1125,1060,1,1057,162,36,163,5,35,1124,137,0,1061,1]

def active7549 : List Nat := [0,1,2,4,5,6,9]

def tree7549 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7549 : H12WitnessSearch.Good tree7549 := H12GlobalWitnessIndex.good

theorem leafIdentity7549 : H12AffineFastState.composeSystem env7549 rootObs = leafEnv7549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7549 rootObs == leafEnv7549) = true)

theorem terminalChecked7549 : H12PackedTerminal.terminalCheckFast leafEnv7549 active7549 tree7549 = true := by decide +kernel

def env7550 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,1993,292,65536,1344,1,1025,292,1296,908,713,65568,780,16,0,1992,1296,1,1284,4294967296,257,4295033230,1345,513]

theorem envBound7550 : H12AffineFastState.Bounded env7550 := by
  intro p hp
  have h : env7550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7543_7550 : H12AffineEnvironment.transform 18 1025 env7543 = env7550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env7543 == env7550) = true)

theorem identity7550 : scanCanonicalize (H12AffineFastState.compose env7550 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound7550 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7551 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,901,1993,292,546,1344,1,1025,292,1296,908,713,514,780,16,0,1992,1296,1,1284,4294967296,257,4294968236,1345,513]

theorem envBound7551 : H12AffineFastState.Bounded env7551 := by
  intro p hp
  have h : env7551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7550_7551 : H12AffineEnvironment.transform 15 546 env7550 = env7551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env7550 == env7551) = true)

def env7552 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,269,1345,292,170,1344,1,1025,292,1296,260,65,138,388,16,0,1344,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7552 : H12AffineFastState.Bounded env7552 := by
  intro p hp
  have h : env7552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7551_7552 : H12AffineEnvironment.transform 8 136 env7551 = env7552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7551 == env7552) = true)

theorem identity7552 : scanCanonicalize (H12AffineFastState.compose env7552 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 253) := by decide +kernel

theorem selectedBound7552 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7553 : List Nat := [2,4,8,16,32,64,128,253,136,1024,1,1260,240,1212,217,170,1213,1,1025,217,1261,249,65,138,121,16,0,1213,1261,1,1273,4294967296,252,4294967513,1212,137]

theorem envBound7553 : H12AffineFastState.Bounded env7553 := by
  intro p hp
  have h : env7553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7552_7553 : H12AffineEnvironment.transform 7 253 env7552 = env7553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 253 env7552 == env7553) = true)

theorem identity7553 : scanCanonicalize (H12AffineFastState.compose env7553 (packedSelected [0,1] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound7553 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env7554 : List Nat := [2,4,8,16,32,64,35,94,43,1024,1,1103,83,1055,122,9,1054,1,1025,122,1102,90,65,41,121,16,0,1054,1102,1,1114,4294967296,95,4294967418,1055,42]

theorem envBound7554 : H12AffineFastState.Bounded env7554 := by
  intro p hp
  have h : env7554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7553_7554 : H12AffineEnvironment.transform 6 35 env7553 = env7554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env7553 == env7554) = true)

theorem identity7554 : scanCanonicalize (H12AffineFastState.compose env7554 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound7554 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7555 : List Nat := [2,4,8,16,32,26,35,4,43,1024,1,1045,9,1055,32,9,1054,1,1025,32,1044,0,27,41,35,16,0,1054,1044,1,1024,4294967296,5,4294967328,1055,42]

theorem envBound7555 : H12AffineFastState.Bounded env7555 := by
  intro p hp
  have h : env7555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7554_7555 : H12AffineEnvironment.transform 5 26 env7554 = env7555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env7554 == env7555) = true)

theorem identity7555 : scanCanonicalize (H12AffineFastState.compose env7555 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound7555 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7556 : List Nat := [2,4,8,16,1,26,2,4,10,1024,1,1045,9,1055,1,9,1054,1,1025,1,1044,0,27,8,2,16,0,1054,1044,1,1024,4294967296,5,4294967297,1055,11]

theorem envBound7556 : H12AffineFastState.Bounded env7556 := by
  intro p hp
  have h : env7556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7555_7556 : H12AffineEnvironment.transform 4 1 env7555 = env7556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7555 == env7556) = true)

theorem identity7556 : scanCanonicalize (H12AffineFastState.compose env7556 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1) := by decide +kernel

theorem selectedBound7556 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7557 : List Nat := [2,4,8,16,1,26,2,4,10,1024,1,1045,9,1055,1,9,1054,1,1025,1,1044,0,27,8,2,16,0,1054,1044,1,1024,1,5,0,1055,11]

theorem envBound7557 : H12AffineFastState.Bounded env7557 := by
  intro p hp
  have h : env7557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7556_7557 : H12AffineEnvironment.transform 31 1 env7556 = env7557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1 env7556 == env7557) = true)

theorem identity7557 : scanCanonicalize (H12AffineFastState.compose env7557 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7557 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7558 : List Nat := [2,4,8,1,1,11,2,4,10,1024,1,1028,9,1038,1,9,1039,1,1025,1,1029,0,10,8,2,1,0,1039,1029,1,1024,1,5,0,1038,11]

theorem envBound7558 : H12AffineFastState.Bounded env7558 := by
  intro p hp
  have h : env7558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7557_7558 : H12AffineEnvironment.transform 3 1 env7557 = env7558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7557 == env7558) = true)

def leafEnv7558 : List Nat := [2,4,8,1,1,11,2,4,10,1024,1,1028,9,1038,1,9,1039,1,1025,1,1029,0,10,8,1025,2,1,1,0,1039,1029,1,1024,1,5,0,5,2,1038,11,0,1028,1]

def active7558 : List Nat := [0,1,2,9]

def tree7558 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7558 : H12WitnessSearch.Good tree7558 := H12GlobalWitnessIndex.good

theorem leafIdentity7558 : H12AffineFastState.composeSystem env7558 rootObs = leafEnv7558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7558 rootObs == leafEnv7558) = true)

theorem terminalChecked7558 : H12PackedTerminal.terminalCheckFast leafEnv7558 active7558 tree7558 = true := by decide +kernel

def env7559 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,268,1344,292,171,1344,1,1025,292,1296,261,64,139,389,16,0,1345,1296,1,1284,4294967296,257,4294967589,1345,136]

theorem envBound7559 : H12AffineFastState.Bounded env7559 := by
  intro p hp
  have h : env7559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7551_7559 : H12AffineEnvironment.transform 8 137 env7551 = env7559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7551 == env7559) = true)

def env7560 : List Nat := [2,4,8,16,32,64,8,256,1,1024,1,1297,268,1344,292,35,1344,1,1025,292,1296,261,64,3,269,16,0,1345,1296,1,1284,4294967296,257,4294967589,1345,0]

theorem envBound7560 : H12AffineFastState.Bounded env7560 := by
  intro p hp
  have h : env7560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7559_7560 : H12AffineEnvironment.transform 6 8 env7559 = env7560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7559 == env7560) = true)

theorem identity7560 : scanCanonicalize (H12AffineFastState.compose env7560 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound7560 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7561 : List Nat := [2,4,8,16,32,64,8,256,1,1024,1,1297,268,1344,292,35,1344,1,1025,292,1296,261,64,3,269,16,0,1345,1296,1,1284,123,257,350,1345,0]

theorem envBound7561 : H12AffineFastState.Bounded env7561 := by
  intro p hp
  have h : env7561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7560_7561 : H12AffineEnvironment.transform 31 123 env7560 = env7561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env7560 == env7561) = true)

def env7562 : List Nat := [2,4,8,16,32,16,8,256,1,1024,1,1297,268,1296,292,35,1296,1,1025,292,1296,261,16,3,269,16,0,1297,1296,1,1284,43,257,270,1297,0]

theorem envBound7562 : H12AffineFastState.Bounded env7562 := by
  intro p hp
  have h : env7562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7561_7562 : H12AffineEnvironment.transform 5 16 env7561 = env7562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7561 == env7562) = true)

theorem identity7562 : scanCanonicalize (H12AffineFastState.compose env7562 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7562 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7563 : List Nat := [2,4,8,16,32,16,8,31,1,1024,1,1038,19,1039,59,35,1039,1,1025,59,1039,26,16,3,18,16,0,1038,1039,1,1051,43,30,17,1038,0]

theorem envBound7563 : H12AffineFastState.Bounded env7563 := by
  intro p hp
  have h : env7563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7562_7563 : H12AffineEnvironment.transform 7 31 env7562 = env7563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7562 == env7563) = true)

def env7564 : List Nat := [2,4,8,16,16,16,8,31,1,1024,1,1038,19,1039,11,19,1039,1,1025,11,1039,26,16,3,18,16,0,1038,1039,1,1051,27,30,17,1038,0]

theorem envBound7564 : H12AffineFastState.Bounded env7564 := by
  intro p hp
  have h : env7564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7563_7564 : H12AffineEnvironment.transform 4 16 env7563 = env7564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7563 == env7564) = true)

theorem identity7564 : scanCanonicalize (H12AffineFastState.compose env7564 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7564 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7565 : List Nat := [2,4,8,10,10,10,8,5,1,1024,1,1038,9,1039,11,9,1039,1,1025,11,1039,0,10,3,8,10,0,1038,1039,1,1025,1,4,11,1038,0]

theorem envBound7565 : H12AffineFastState.Bounded env7565 := by
  intro p hp
  have h : env7565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7564_7565 : H12AffineEnvironment.transform 3 10 env7564 = env7565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7564 == env7565) = true)

def leafEnv7565 : List Nat := [2,4,8,10,10,10,8,5,1,1024,1,1038,9,1039,11,9,1039,1,1025,11,1039,0,10,3,1024,8,1,10,0,1038,1039,1,1025,1,4,11,5,9,1038,0,0,1038,1]

def active7565 : List Nat := [0,1,2,9]

def tree7565 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7565 : H12WitnessSearch.Good tree7565 := H12GlobalWitnessIndex.good

theorem leafIdentity7565 : H12AffineFastState.composeSystem env7565 rootObs = leafEnv7565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7565 rootObs == leafEnv7565) = true)

theorem terminalChecked7565 : H12PackedTerminal.terminalCheckFast leafEnv7565 active7565 tree7565 = true := by decide +kernel

def env7566 : List Nat := [2,4,8,16,17,16,8,31,1,1024,1,1038,19,1039,10,18,1039,1,1025,10,1039,26,16,3,18,16,0,1038,1039,1,1051,26,30,17,1038,0]

theorem envBound7566 : H12AffineFastState.Bounded env7566 := by
  intro p hp
  have h : env7566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7563_7566 : H12AffineEnvironment.transform 4 17 env7563 = env7566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7563 == env7566) = true)

theorem identity7566 : scanCanonicalize (H12AffineFastState.compose env7566 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7566 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7567 : List Nat := [2,4,8,0,1,0,8,15,1,1024,1,1038,3,1039,10,2,1039,1,1025,10,1039,10,0,3,2,0,0,1038,1039,1,1035,10,14,1,1038,0]

theorem envBound7567 : H12AffineFastState.Bounded env7567 := by
  intro p hp
  have h : env7567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7566_7567 : H12AffineEnvironment.transform 3 0 env7566 = env7567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7566 == env7567) = true)

def leafEnv7567 : List Nat := [2,4,8,0,1,0,8,15,1,1024,1,1038,3,1039,10,2,1039,1,1025,10,1039,10,0,3,1034,2,1,0,0,1038,1039,1,1035,10,14,1,5,2,1038,0,0,1038,1]

def active7567 : List Nat := [0,1,2,9]

def tree7567 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7567 : H12WitnessSearch.Good tree7567 := H12GlobalWitnessIndex.good

theorem leafIdentity7567 : H12AffineFastState.composeSystem env7567 rootObs = leafEnv7567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7567 rootObs == leafEnv7567) = true)

theorem terminalChecked7567 : H12PackedTerminal.terminalCheckFast leafEnv7567 active7567 tree7567 = true := by decide +kernel

def env7568 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1297,268,1297,292,35,1297,1,1025,292,1296,261,17,3,269,16,0,1296,1296,1,1284,42,257,271,1296,0]

theorem envBound7568 : H12AffineFastState.Bounded env7568 := by
  intro p hp
  have h : env7568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7561_7568 : H12AffineEnvironment.transform 5 17 env7561 = env7568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7561 == env7568) = true)

theorem identity7568 : scanCanonicalize (H12AffineFastState.compose env7568 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound7568 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7569 : List Nat := [2,4,8,16,26,17,8,256,1,1024,1,1297,268,1297,286,25,1297,1,1025,286,1296,261,17,3,269,16,0,1296,1296,1,1284,16,257,271,1296,0]

theorem envBound7569 : H12AffineFastState.Bounded env7569 := by
  intro p hp
  have h : env7569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7568_7569 : H12AffineEnvironment.transform 4 26 env7568 = env7569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env7568 == env7569) = true)

def env7570 : List Nat := [2,4,8,16,26,17,8,20,1,1024,1,1029,24,1029,10,25,1029,1,1025,10,1028,17,17,3,25,16,0,1028,1028,1,1040,16,21,27,1028,0]

theorem envBound7570 : H12AffineFastState.Bounded env7570 := by
  intro p hp
  have h : env7570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7569_7570 : H12AffineEnvironment.transform 7 20 env7569 = env7570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7569 == env7570) = true)

theorem identity7570 : scanCanonicalize (H12AffineFastState.compose env7570 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7570 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7571 : List Nat := [2,4,8,0,10,1,8,4,1,1024,1,1029,8,1029,10,9,1029,1,1025,10,1028,1,1,3,9,0,0,1028,1028,1,1024,0,5,11,1028,0]

theorem envBound7571 : H12AffineFastState.Bounded env7571 := by
  intro p hp
  have h : env7571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7570_7571 : H12AffineEnvironment.transform 3 0 env7570 = env7571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7570 == env7571) = true)

def leafEnv7571 : List Nat := [2,4,8,0,10,1,8,4,1,1024,1,1029,8,1029,10,9,1029,1,1025,10,1028,1,1,3,1025,9,1,0,0,1028,1028,1,1024,0,5,11,5,9,1028,0,0,1029,1]

def active7571 : List Nat := [0,1,2,9]

def tree7571 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7571 : H12WitnessSearch.Good tree7571 := H12GlobalWitnessIndex.good

theorem leafIdentity7571 : H12AffineFastState.composeSystem env7571 rootObs = leafEnv7571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7571 rootObs == leafEnv7571) = true)

theorem terminalChecked7571 : H12PackedTerminal.terminalCheckFast leafEnv7571 active7571 tree7571 = true := by decide +kernel

def env7572 : List Nat := [2,4,8,16,26,17,8,21,1,1024,1,1028,25,1028,11,25,1028,1,1025,11,1029,16,17,3,24,16,0,1029,1029,1,1041,16,20,26,1029,0]

theorem envBound7572 : H12AffineFastState.Bounded env7572 := by
  intro p hp
  have h : env7572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7569_7572 : H12AffineEnvironment.transform 7 21 env7569 = env7572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7569 == env7572) = true)

theorem identity7572 : scanCanonicalize (H12AffineFastState.compose env7572 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7572 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7573 : List Nat := [2,4,8,10,0,11,8,15,1,1024,1,1028,3,1028,11,3,1028,1,1025,11,1029,10,11,3,2,10,0,1029,1029,1,1035,10,14,0,1029,0]

theorem envBound7573 : H12AffineFastState.Bounded env7573 := by
  intro p hp
  have h : env7573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7572_7573 : H12AffineEnvironment.transform 3 10 env7572 = env7573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7572 == env7573) = true)

def leafEnv7573 : List Nat := [2,4,8,10,0,11,8,15,1,1024,1,1028,3,1028,11,3,1028,1,1025,11,1029,10,11,3,1034,2,1,10,0,1029,1029,1,1035,10,14,0,5,3,1029,0,0,1028,1]

def active7573 : List Nat := [0,1,2,9]

def tree7573 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7573 : H12WitnessSearch.Good tree7573 := H12GlobalWitnessIndex.good

theorem leafIdentity7573 : H12AffineFastState.composeSystem env7573 rootObs = leafEnv7573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7573 rootObs == leafEnv7573) = true)

theorem terminalChecked7573 : H12PackedTerminal.terminalCheckFast leafEnv7573 active7573 tree7573 = true := by decide +kernel

def env7574 : List Nat := [2,4,8,16,32,64,9,256,0,1024,1,1297,268,1344,292,34,1344,1,1025,292,1296,261,64,2,268,16,0,1345,1296,1,1284,4294967296,257,4294967589,1345,1]

theorem envBound7574 : H12AffineFastState.Bounded env7574 := by
  intro p hp
  have h : env7574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7559_7574 : H12AffineEnvironment.transform 6 9 env7559 = env7574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7559 == env7574) = true)

theorem identity7574 : scanCanonicalize (H12AffineFastState.compose env7574 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 350) := by decide +kernel

theorem selectedBound7574 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7575 : List Nat := [2,4,8,16,32,64,9,256,0,1024,1,1297,268,1344,292,34,1344,1,1025,292,1296,261,64,2,268,16,0,1345,1296,1,1284,350,257,123,1345,1]

theorem envBound7575 : H12AffineFastState.Bounded env7575 := by
  intro p hp
  have h : env7575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7574_7575 : H12AffineEnvironment.transform 31 350 env7574 = env7575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 350 env7574 == env7575) = true)

def env7576 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,1297,268,1296,292,34,1296,1,1025,292,1296,261,16,2,268,16,0,1297,1296,1,1284,270,257,43,1297,1]

theorem envBound7576 : H12AffineFastState.Bounded env7576 := by
  intro p hp
  have h : env7576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7575_7576 : H12AffineEnvironment.transform 5 16 env7575 = env7576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7575 == env7576) = true)

theorem identity7576 : scanCanonicalize (H12AffineFastState.compose env7576 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound7576 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7577 : List Nat := [2,4,8,16,26,16,9,256,0,1024,1,1297,268,1296,286,24,1296,1,1025,286,1296,261,16,2,268,16,0,1297,1296,1,1284,270,257,17,1297,1]

theorem envBound7577 : H12AffineFastState.Bounded env7577 := by
  intro p hp
  have h : env7577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7576_7577 : H12AffineEnvironment.transform 4 26 env7576 = env7577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env7576 == env7577) = true)

def env7578 : List Nat := [2,4,8,16,26,16,9,20,0,1024,1,1029,24,1028,10,24,1028,1,1025,10,1028,17,16,2,24,16,0,1029,1028,1,1040,26,21,17,1029,1]

theorem envBound7578 : H12AffineFastState.Bounded env7578 := by
  intro p hp
  have h : env7578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7577_7578 : H12AffineEnvironment.transform 7 20 env7577 = env7578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7577 == env7578) = true)

theorem identity7578 : scanCanonicalize (H12AffineFastState.compose env7578 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7578 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7579 : List Nat := [2,4,8,11,1,11,9,15,0,1024,1,1029,3,1028,10,3,1028,1,1025,10,1028,10,11,2,3,11,0,1029,1028,1,1035,1,14,10,1029,1]

theorem envBound7579 : H12AffineFastState.Bounded env7579 := by
  intro p hp
  have h : env7579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7578_7579 : H12AffineEnvironment.transform 3 11 env7578 = env7579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7578 == env7579) = true)

def leafEnv7579 : List Nat := [2,4,8,11,1,11,9,15,0,1024,1,1029,3,1028,10,3,1028,1,1025,10,1028,10,11,2,1034,3,1,11,0,1029,1028,1,1035,1,14,10,5,2,1029,1,0,1029,1]

def active7579 : List Nat := [0,1,2,9]

def tree7579 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7579 : H12WitnessSearch.Good tree7579 := H12GlobalWitnessIndex.good

theorem leafIdentity7579 : H12AffineFastState.composeSystem env7579 rootObs = leafEnv7579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7579 rootObs == leafEnv7579) = true)

theorem terminalChecked7579 : H12PackedTerminal.terminalCheckFast leafEnv7579 active7579 tree7579 = true := by decide +kernel

def env7580 : List Nat := [2,4,8,16,26,16,9,21,0,1024,1,1028,25,1029,11,24,1029,1,1025,11,1029,16,16,2,25,16,0,1028,1029,1,1041,27,20,17,1028,1]

theorem envBound7580 : H12AffineFastState.Bounded env7580 := by
  intro p hp
  have h : env7580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7577_7580 : H12AffineEnvironment.transform 7 21 env7577 = env7580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7577 == env7580) = true)

theorem identity7580 : scanCanonicalize (H12AffineFastState.compose env7580 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

end H12GlobalChart2