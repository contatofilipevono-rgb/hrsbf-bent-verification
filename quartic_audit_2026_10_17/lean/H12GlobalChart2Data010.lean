import H12GlobalChart2Data009

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound2405 : H12AffineFastState.Bounded env2405 := by
  intro p hp
  have h : env2405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2404_2405 : H12AffineEnvironment.transform 8 136 env2404 = env2405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2404 == env2405) = true)

theorem identity2405 : scanCanonicalize (H12AffineFastState.compose env2405 (packedSelected [0,7] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound2405 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2406 : List Nat := [2,4,8,16,32,17,128,256,136,273,1,4096,269,4096,292,170,1,0,272,292,4097,261,4113,138,388,4113,0,4097,1,1,21,4294967296,256,4294967588,0,137]

theorem envBound2406 : H12AffineFastState.Bounded env2406 := by
  intro p hp
  have h : env2406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2405_2406 : H12AffineEnvironment.transform 5 17 env2405 = env2406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2405 == env2406) = true)

theorem identity2406 : scanCanonicalize (H12AffineFastState.compose env2406 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 276) := by decide +kernel

theorem selectedBound2406 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2407 : List Nat := [2,4,8,16,32,17,128,256,136,273,1,276,269,276,292,170,1,0,272,292,277,261,261,138,388,261,0,277,1,1,21,4294967296,256,4294967588,0,137]

theorem envBound2407 : H12AffineFastState.Bounded env2407 := by
  intro p hp
  have h : env2407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2406_2407 : H12AffineEnvironment.transform 11 276 env2406 = env2407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 276 env2406 == env2407) = true)

theorem identity2407 : scanCanonicalize (H12AffineFastState.compose env2407 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 182) := by decide +kernel

theorem selectedBound2407 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env2408 : List Nat := [2,4,8,16,32,17,128,182,136,167,1,162,187,162,146,170,1,0,166,146,163,179,179,138,50,179,0,163,1,1,21,4294967296,182,4294967442,0,137]

theorem envBound2408 : H12AffineFastState.Bounded env2408 := by
  intro p hp
  have h : env2408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2407_2408 : H12AffineEnvironment.transform 7 182 env2407 = env2408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 182 env2407 == env2408) = true)

theorem identity2408 : scanCanonicalize (H12AffineFastState.compose env2408 (packedSelected [8] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound2408 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env2409 : List Nat := [2,4,8,16,17,17,128,135,136,150,1,147,138,147,146,155,1,0,151,146,146,130,130,138,3,130,0,146,1,1,21,4294967296,135,4294967442,0,137]

theorem envBound2409 : H12AffineFastState.Bounded env2409 := by
  intro p hp
  have h : env2409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2408_2409 : H12AffineEnvironment.transform 4 17 env2408 = env2409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env2408 == env2409) = true)

theorem identity2409 : scanCanonicalize (H12AffineFastState.compose env2409 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 26) := by decide +kernel

theorem selectedBound2409 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env2410 : List Nat := [2,4,8,16,17,17,128,135,136,150,1,147,138,147,146,155,1,0,151,146,146,130,130,138,3,130,0,146,1,1,21,26,135,136,0,137]

theorem envBound2410 : H12AffineFastState.Bounded env2410 := by
  intro p hp
  have h : env2410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2409_2410 : H12AffineEnvironment.transform 31 26 env2409 = env2410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 26 env2409 == env2410) = true)

theorem identity2410 : scanCanonicalize (H12AffineFastState.compose env2410 (packedSelected [2,9] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound2410 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env2411 : List Nat := [2,4,8,16,17,17,19,20,27,5,1,0,25,0,1,8,1,0,4,1,1,17,17,25,3,17,0,1,1,1,21,26,20,27,0,26]

theorem envBound2411 : H12AffineFastState.Bounded env2411 := by
  intro p hp
  have h : env2411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2410_2411 : H12AffineEnvironment.transform 6 19 env2410 = env2411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env2410 == env2411) = true)

theorem identity2411 : scanCanonicalize (H12AffineFastState.compose env2411 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound2411 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2412 : List Nat := [2,4,8,10,11,11,9,14,1,5,1,0,3,0,1,8,1,0,4,1,1,11,11,3,3,11,0,1,1,1,15,0,14,1,0,0]

theorem envBound2412 : H12AffineFastState.Bounded env2412 := by
  intro p hp
  have h : env2412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2411_2412 : H12AffineEnvironment.transform 3 10 env2411 = env2412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env2411 == env2412) = true)

theorem identity2412 : scanCanonicalize (H12AffineFastState.compose env2412 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2412 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2413 : List Nat := [2,4,2,0,1,1,3,4,1,5,1,0,3,0,1,2,1,0,4,1,1,1,1,3,3,1,0,1,1,1,5,0,4,1,0,0]

theorem envBound2413 : H12AffineFastState.Bounded env2413 := by
  intro p hp
  have h : env2413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2412_2413 : H12AffineEnvironment.transform 2 2 env2412 = env2413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2412 == env2413) = true)

def env2414 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8200,5457,230469,8329,5377,402509,4177,131152,631938,131140,4294967296,257,4295729382,131073,513]

theorem envBound2414 : H12AffineFastState.Bounded env2414 := by
  intro p hp
  have h : env2414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2357_2414 : H12AffineEnvironment.transform 25 5377 env2357 = env2414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2357 == env2414) = true)

theorem identity2414 : scanCanonicalize (H12AffineFastState.compose env2414 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 366423) := by decide +kernel

theorem selectedBound2414 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2415 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,366423,32768,4097,8200,5457,230469,8329,5377,402509,4177,131152,275413,131140,4294967296,257,4295374769,131073,513]

theorem envBound2415 : H12AffineFastState.Bounded env2415 := by
  intro p hp
  have h : env2415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2414_2415 : H12AffineEnvironment.transform 18 366423 env2414 = env2415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 366423 env2414 == env2415) = true)

theorem identity2415 : scanCanonicalize (H12AffineFastState.compose env2415 (packedSelected [6,25] rootPS)) = affineNative (2^(17+1) ^^^ 103255) := by decide +kernel

theorem selectedBound2415 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2416 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,103255,1024,32768,4097,8200,5457,230469,8329,5377,243482,4177,131152,106626,131140,4294967296,257,4295206118,131073,513]

theorem envBound2416 : H12AffineFastState.Bounded env2416 := by
  intro p hp
  have h : env2416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2415_2416 : H12AffineEnvironment.transform 17 103255 env2415 = env2416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 103255 env2415 == env2416) = true)

def env2417 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,157794305,1073741824,140788816,4294967296,157663568,4417151346,131072,33563272]

theorem envBound2417 : H12AffineFastState.Bounded env2417 := by
  intro p hp
  have h : env2417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2108_2417 : H12AffineEnvironment.transform 28 157794305 env2108 = env2417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env2108 == env2417) = true)

theorem identity2417 : scanCanonicalize (H12AffineFastState.compose env2417 (packedSelected [14] rootPS)) = affineNative (2^(23+1) ^^^ 230468) := by decide +kernel

theorem selectedBound2417 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env2418 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,230468,33554432,67108864,134217728,67130625,140788805,1073741824,140788816,4294967296,140920084,4400604470,131072,33563272]

theorem envBound2418 : H12AffineFastState.Bounded env2418 := by
  intro p hp
  have h : env2418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2417_2418 : H12AffineEnvironment.transform 23 230468 env2417 = env2418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230468 env2417 == env2418) = true)

def env2419 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,230468,33554432,67108864,134217728,67130625,138695749,1073741824,138695760,4294967296,138827028,4400604470,131072,33563272]

theorem envBound2419 : H12AffineFastState.Bounded env2419 := by
  intro p hp
  have h : env2419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2418_2419 : H12AffineEnvironment.transform 20 4096 env2418 = env2419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2418 == env2419) = true)

theorem identity2419 : scanCanonicalize (H12AffineFastState.compose env2419 (packedSelected [35] rootPS)) = affineNative (2^(26+1) ^^^ 4609044) := by decide +kernel

theorem selectedBound2419 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env2420 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,230468,33554432,67108864,4609044,67130625,131153,1073741824,131140,4294967296,256,4400604470,131072,33563272]

theorem envBound2420 : H12AffineFastState.Bounded env2420 := by
  intro p hp
  have h : env2420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2419_2420 : H12AffineEnvironment.transform 26 4609044 env2419 = env2420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4609044 env2419 == env2420) = true)

def env2421 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,230468,33554432,67108864,4609044,67130625,131153,1073741824,131140,4294967296,256,4400079158,131072,33563272]

theorem envBound2421 : H12AffineFastState.Bounded env2421 := by
  intro p hp
  have h : env2421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2420_2421 : H12AffineEnvironment.transform 18 1024 env2420 = env2421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env2420 == env2421) = true)

theorem identity2421 : scanCanonicalize (H12AffineFastState.compose env2421 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 71409034) := by decide +kernel

theorem selectedBound2421 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env2422 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,230468,33554432,67108864,4609044,67130625,131153,71409034,131140,4294967296,256,4400079158,131072,33563272]

theorem envBound2422 : H12AffineFastState.Bounded env2422 := by
  intro p hp
  have h : env2422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2421_2422 : H12AffineEnvironment.transform 29 71409034 env2421 = env2422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 71409034 env2421 == env2422) = true)

def env2423 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230468,33554432,67108864,4588612,67110225,131153,71409034,131140,4294967296,256,4400066918,131072,33563272]

theorem envBound2423 : H12AffineFastState.Bounded env2423 := by
  intro p hp
  have h : env2423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2422_2423 : H12AffineEnvironment.transform 13 4176 env2422 = env2423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env2422 == env2423) = true)

def env2424 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230468,4259840,67108864,4588612,67110225,131153,71409034,131140,4294967296,256,4362252646,131072,4268680]

theorem envBound2424 : H12AffineFastState.Bounded env2424 := by
  intro p hp
  have h : env2424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2423_2424 : H12AffineEnvironment.transform 24 4259840 env2423 = env2424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4259840 env2423 == env2424) = true)

def env2425 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,4194304,5456,103492,4259840,67108864,4461636,67110225,4177,71409034,4164,4294967296,256,4362117478,4096,4268680]

theorem envBound2425 : H12AffineFastState.Bounded env2425 := by
  intro p hp
  have h : env2425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2424_2425 : H12AffineEnvironment.transform 16 4096 env2424 = env2425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env2424 == env2425) = true)

theorem identity2425 : scanCanonicalize (H12AffineFastState.compose env2425 (packedSelected [3,5,24] rootPS)) = affineNative (2^(14+1) ^^^ 5188) := by decide +kernel

theorem selectedBound2425 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env2426 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,5188,65536,4096,262144,1024,5188,4096,4194304,5456,65536,4259840,67108864,4461636,67110225,4177,71371214,4164,4294967296,256,4362089762,4096,4268680]

theorem envBound2426 : H12AffineFastState.Bounded env2426 := by
  intro p hp
  have h : env2426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2425_2426 : H12AffineEnvironment.transform 14 5188 env2425 = env2426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5188 env2425 == env2426) = true)

def env2427 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,5140,65536,4096,262144,1024,5140,4096,4194304,5376,65536,4259840,67108864,4461588,67110145,4097,71371166,4116,4294967296,256,4362089762,4096,4268680]

theorem envBound2427 : H12AffineFastState.Bounded env2427 := by
  intro p hp
  have h : env2427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2426_2427 : H12AffineEnvironment.transform 5 16 env2426 = env2427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2426 == env2427) = true)

def env2428 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,5140,65536,4096,262144,1024,5140,4096,74240,5376,65536,8704,67108864,341524,67110145,4097,67120030,4116,4294967296,256,4362089762,4096,136]

theorem envBound2428 : H12AffineFastState.Bounded env2428 := by
  intro p hp
  have h : env2428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2427_2428 : H12AffineEnvironment.transform 21 74240 env2427 = env2428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 74240 env2427 == env2428) = true)

theorem identity2428 : scanCanonicalize (H12AffineFastState.compose env2428 (packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound2428 : packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS < 2^1333 := by decide +kernel

def env2429 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1944,908,65536,1944,262144,1024,908,1944,74240,664,65536,8704,67108864,336268,67110145,1945,67120030,1932,4294967296,256,4362085050,1944,136]

theorem envBound2429 : H12AffineFastState.Bounded env2429 := by
  intro p hp
  have h : env2429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2428_2429 : H12AffineEnvironment.transform 11 1944 env2428 = env2429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env2428 == env2429) = true)

theorem identity2429 : scanCanonicalize (H12AffineFastState.compose env2429 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(25+1) ^^^ 16) := by decide +kernel

theorem selectedBound2429 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env2430 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1944,908,65536,1944,262144,1024,908,1944,74240,664,65536,8704,16,336268,1297,1945,11150,1932,4294967296,256,4294976170,1944,136]

theorem envBound2430 : H12AffineFastState.Bounded env2430 := by
  intro p hp
  have h : env2430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2429_2430 : H12AffineEnvironment.transform 25 16 env2429 = env2430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 16 env2429 == env2430) = true)

theorem identity2430 : scanCanonicalize (H12AffineFastState.compose env2430 (packedSelected [1,3,17] rootPS)) = affineNative (2^(15+1) ^^^ 900) := by decide +kernel

theorem selectedBound2430 : packedSelected [1,3,17] rootPS < 2^1333 := by decide +kernel

def env2431 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1944,908,900,1944,262144,1024,908,1944,8580,664,900,8704,16,270856,1297,1945,11150,1932,4294967296,256,4294976170,1944,136]

theorem envBound2431 : H12AffineFastState.Bounded env2431 := by
  intro p hp
  have h : env2431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2430_2431 : H12AffineEnvironment.transform 15 900 env2430 = env2431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 900 env2430 == env2431) = true)

theorem identity2431 : scanCanonicalize (H12AffineFastState.compose env2431 (packedSelected [4,16,22] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2431 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env2432 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,260,268,1296,262144,1024,260,1296,8580,16,268,8328,16,270464,1297,1297,10502,1284,4294967296,256,4294975522,1296,136]

theorem envBound2432 : H12AffineFastState.Bounded env2432 := by
  intro p hp
  have h : env2432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2431_2432 : H12AffineEnvironment.transform 8 136 env2431 = env2432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2431 == env2432) = true)

theorem identity2432 : scanCanonicalize (H12AffineFastState.compose env2432 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8226) := by decide +kernel

theorem selectedBound2432 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2433 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,260,268,1296,262144,1024,260,1296,8580,16,268,8328,16,270464,1297,1297,10502,1284,8226,256,0,1296,136]

theorem envBound2433 : H12AffineFastState.Bounded env2433 := by
  intro p hp
  have h : env2433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2432_2433 : H12AffineEnvironment.transform 31 8226 env2432 = env2433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8226 env2432 == env2433) = true)

theorem identity2433 : scanCanonicalize (H12AffineFastState.compose env2433 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound2433 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env2434 : List Nat := [2,4,8,16,32,16,128,256,136,46,2048,318,8192,318,260,268,318,262144,46,260,318,8580,16,268,8328,16,270464,319,319,10502,298,8226,256,0,318,136]

theorem envBound2434 : H12AffineFastState.Bounded env2434 := by
  intro p hp
  have h : env2434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2433_2434 : H12AffineEnvironment.transform 9 46 env2433 = env2434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env2433 == env2434) = true)

theorem identity2434 : scanCanonicalize (H12AffineFastState.compose env2434 (packedSelected [3,12] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2434 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env2435 : List Nat := [2,4,8,16,32,16,128,256,136,46,2048,318,8,318,260,268,318,262144,46,260,318,396,16,268,128,16,262280,319,319,2318,298,42,256,0,318,136]

theorem envBound2435 : H12AffineFastState.Bounded env2435 := by
  intro p hp
  have h : env2435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2434_2435 : H12AffineEnvironment.transform 12 8 env2434 = env2435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2434 == env2435) = true)

def env2436 : List Nat := [2,4,8,16,32,16,128,256,136,46,2048,318,8,318,260,268,318,2340,46,260,318,396,16,268,128,16,2476,319,319,2318,298,42,256,0,318,136]

theorem envBound2436 : H12AffineFastState.Bounded env2436 := by
  intro p hp
  have h : env2436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2435_2436 : H12AffineEnvironment.transform 17 2340 env2435 = env2436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env2435 == env2436) = true)

theorem identity2436 : scanCanonicalize (H12AffineFastState.compose env2436 (packedSelected [11,32] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound2436 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env2437 : List Nat := [2,4,8,16,32,16,128,134,136,46,2048,184,8,184,130,138,184,2210,46,130,184,10,16,138,128,16,2090,185,185,2184,172,42,134,0,184,136]

theorem envBound2437 : H12AffineFastState.Bounded env2437 := by
  intro p hp
  have h : env2437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2436_2437 : H12AffineEnvironment.transform 7 134 env2436 = env2437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env2436 == env2437) = true)

theorem identity2437 : scanCanonicalize (H12AffineFastState.compose env2437 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(10+1) ^^^ 169) := by decide +kernel

theorem selectedBound2437 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2438 : List Nat := [2,4,8,16,32,16,128,134,136,46,169,184,8,184,130,138,184,11,46,130,184,10,16,138,128,16,131,185,185,33,172,42,134,0,184,136]

theorem envBound2438 : H12AffineFastState.Bounded env2438 := by
  intro p hp
  have h : env2438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2437_2438 : H12AffineEnvironment.transform 10 169 env2437 = env2438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 169 env2437 == env2438) = true)

theorem identity2438 : scanCanonicalize (H12AffineFastState.compose env2438 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound2438 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2439 : List Nat := [2,4,8,16,18,16,128,134,136,28,155,138,8,138,130,138,138,11,28,130,138,10,16,138,128,16,131,139,139,19,158,24,134,0,138,136]

theorem envBound2439 : H12AffineFastState.Bounded env2439 := by
  intro p hp
  have h : env2439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2438_2439 : H12AffineEnvironment.transform 4 18 env2438 = env2439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env2438 == env2439) = true)

theorem identity2439 : scanCanonicalize (H12AffineFastState.compose env2439 (packedSelected [7] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound2439 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env2440 : List Nat := [2,4,8,9,11,9,128,134,136,5,130,138,8,138,130,138,138,11,5,130,138,10,9,138,128,9,131,139,139,10,135,1,134,0,138,136]

theorem envBound2440 : H12AffineFastState.Bounded env2440 := by
  intro p hp
  have h : env2440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2439_2440 : H12AffineEnvironment.transform 3 9 env2439 = env2440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env2439 == env2440) = true)

def env2441 : List Nat := [2,4,8,16,32,16,128,256,136,46,2048,318,8,318,260,268,318,2341,46,260,318,396,16,268,128,16,2477,319,319,2318,298,42,256,0,318,136]

theorem envBound2441 : H12AffineFastState.Bounded env2441 := by
  intro p hp
  have h : env2441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2435_2441 : H12AffineEnvironment.transform 17 2341 env2435 = env2441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env2435 == env2441) = true)

theorem identity2441 : scanCanonicalize (H12AffineFastState.compose env2441 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 62) := by decide +kernel

theorem selectedBound2441 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2442 : List Nat := [2,4,8,16,32,16,128,62,136,46,2048,0,8,0,58,50,0,2075,46,58,0,178,16,50,128,16,2195,1,1,2096,20,42,62,0,0,136]

theorem envBound2442 : H12AffineFastState.Bounded env2442 := by
  intro p hp
  have h : env2442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2441_2442 : H12AffineEnvironment.transform 7 62 env2441 = env2442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 62 env2441 == env2442) = true)

theorem identity2442 : scanCanonicalize (H12AffineFastState.compose env2442 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound2442 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env2443 : List Nat := [2,4,8,16,11,16,128,21,136,5,2048,0,8,0,17,25,0,2075,5,17,0,153,16,25,128,16,2195,1,1,2075,20,1,21,0,0,136]

theorem envBound2443 : H12AffineFastState.Bounded env2443 := by
  intro p hp
  have h : env2443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2442_2443 : H12AffineEnvironment.transform 4 11 env2442 = env2443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env2442 == env2443) = true)

def env2444 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,5140,65536,4096,262144,1024,5140,4096,74241,5376,65536,8705,67108864,341525,67110145,4097,67120031,4116,4294967296,256,4362089762,4096,137]

theorem envBound2444 : H12AffineFastState.Bounded env2444 := by
  intro p hp
  have h : env2444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2427_2444 : H12AffineEnvironment.transform 21 74241 env2427 = env2444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 74241 env2427 == env2444) = true)

theorem identity2444 : scanCanonicalize (H12AffineFastState.compose env2444 (packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound2444 : packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS < 2^1333 := by decide +kernel

def env2445 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,8192,1296,260,65536,1296,262144,1024,260,1296,74241,16,65536,8705,67108864,336645,67110145,1297,67120031,1284,4294967296,256,4362084402,1296,137]

theorem envBound2445 : H12AffineFastState.Bounded env2445 := by
  intro p hp
  have h : env2445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2444_2445 : H12AffineEnvironment.transform 11 1296 env2444 = env2445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2444 == env2445) = true)

theorem identity2445 : scanCanonicalize (H12AffineFastState.compose env2445 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2445 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2446 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8192,1296,260,65536,1296,262144,1024,260,1296,73864,16,65536,8328,67108864,336268,67110145,1297,67119382,1284,4294967296,256,4362084402,1296,137]

theorem envBound2446 : H12AffineFastState.Bounded env2446 := by
  intro p hp
  have h : env2446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2445_2446 : H12AffineEnvironment.transform 8 137 env2445 = env2446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2445 == env2446) = true)

theorem identity2446 : scanCanonicalize (H12AffineFastState.compose env2446 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 8452) := by decide +kernel

theorem selectedBound2446 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2447 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8192,1296,260,8452,1296,262144,1024,260,1296,396,16,8452,8328,67108864,262280,67110145,1297,67119382,1284,4294967296,256,4362084402,1296,137]

theorem envBound2447 : H12AffineFastState.Bounded env2447 := by
  intro p hp
  have h : env2447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2446_2447 : H12AffineEnvironment.transform 15 8452 env2446 = env2447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8452 env2446 == env2447) = true)

theorem identity2447 : scanCanonicalize (H12AffineFastState.compose env2447 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2447 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2448 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,260,268,1296,262144,1024,260,1296,396,16,268,128,67108864,262280,67110145,1297,67111198,1284,4294967296,256,4362076218,1296,137]

theorem envBound2448 : H12AffineFastState.Bounded env2448 := by
  intro p hp
  have h : env2448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2447_2448 : H12AffineEnvironment.transform 12 8 env2447 = env2448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2447 == env2448) = true)

theorem identity2448 : scanCanonicalize (H12AffineFastState.compose env2448 (packedSelected [0,7,20] rootPS)) = affineNative (2^(25+1) ^^^ 16) := by decide +kernel

theorem selectedBound2448 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env2449 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,260,268,1296,262144,1024,260,1296,396,16,268,128,16,262280,1297,1297,2318,1284,4294967296,256,4294967338,1296,137]

theorem envBound2449 : H12AffineFastState.Bounded env2449 := by
  intro p hp
  have h : env2449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2448_2449 : H12AffineEnvironment.transform 25 16 env2448 = env2449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 16 env2448 == env2449) = true)

theorem identity2449 : scanCanonicalize (H12AffineFastState.compose env2449 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound2449 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2450 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,260,268,1296,262144,1024,260,1296,396,16,268,128,16,262280,1297,1297,2318,1284,42,256,0,1296,137]

theorem envBound2450 : H12AffineFastState.Bounded env2450 := by
  intro p hp
  have h : env2450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2449_2450 : H12AffineEnvironment.transform 31 42 env2449 = env2450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env2449 == env2450) = true)

theorem identity2450 : scanCanonicalize (H12AffineFastState.compose env2450 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound2450 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env2451 : List Nat := [2,4,8,16,32,16,128,256,137,46,2048,318,8,318,260,268,318,262144,46,260,318,396,16,268,128,16,262280,319,319,2318,298,42,256,0,318,137]

theorem envBound2451 : H12AffineFastState.Bounded env2451 := by
  intro p hp
  have h : env2451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2450_2451 : H12AffineEnvironment.transform 9 46 env2450 = env2451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env2450 == env2451) = true)

def env2452 : List Nat := [2,4,8,16,32,16,128,256,137,46,2048,318,8,318,260,268,318,2340,46,260,318,396,16,268,128,16,2476,319,319,2318,298,42,256,0,318,137]

theorem envBound2452 : H12AffineFastState.Bounded env2452 := by
  intro p hp
  have h : env2452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2451_2452 : H12AffineEnvironment.transform 17 2340 env2451 = env2452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env2451 == env2452) = true)

theorem identity2452 : scanCanonicalize (H12AffineFastState.compose env2452 (packedSelected [11,32] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound2452 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env2453 : List Nat := [2,4,8,16,32,16,128,134,137,46,2048,184,8,184,130,138,184,2210,46,130,184,10,16,138,128,16,2090,185,185,2184,172,42,134,0,184,137]

theorem envBound2453 : H12AffineFastState.Bounded env2453 := by
  intro p hp
  have h : env2453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2452_2453 : H12AffineEnvironment.transform 7 134 env2452 = env2453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env2452 == env2453) = true)

theorem identity2453 : scanCanonicalize (H12AffineFastState.compose env2453 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(10+1) ^^^ 168) := by decide +kernel

theorem selectedBound2453 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2454 : List Nat := [2,4,8,16,32,16,128,134,137,46,168,184,8,184,130,138,184,10,46,130,184,10,16,138,128,16,130,185,185,32,172,42,134,0,184,137]

theorem envBound2454 : H12AffineFastState.Bounded env2454 := by
  intro p hp
  have h : env2454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2453_2454 : H12AffineEnvironment.transform 10 168 env2453 = env2454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 168 env2453 == env2454) = true)

theorem identity2454 : scanCanonicalize (H12AffineFastState.compose env2454 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 16) := by decide +kernel

theorem selectedBound2454 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2455 : List Nat := [2,4,8,16,32,16,16,22,25,46,56,40,8,40,18,26,40,10,46,18,40,10,16,26,16,16,18,41,41,32,60,42,22,0,40,25]

theorem envBound2455 : H12AffineFastState.Bounded env2455 := by
  intro p hp
  have h : env2455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2454_2455 : H12AffineEnvironment.transform 6 16 env2454 = env2455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 16 env2454 == env2455) = true)

def env2456 : List Nat := [2,4,8,8,32,8,8,14,1,46,32,40,8,40,10,2,40,10,46,10,40,10,8,2,8,8,10,41,41,32,36,42,14,0,40,1]

theorem envBound2456 : H12AffineFastState.Bounded env2456 := by
  intro p hp
  have h : env2456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2455_2456 : H12AffineEnvironment.transform 3 8 env2455 = env2456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env2455 == env2456) = true)

def env2457 : List Nat := [2,4,8,8,0,8,8,14,1,14,0,8,8,8,10,2,8,10,14,10,8,10,8,2,8,8,10,9,9,0,4,10,14,0,8,1]

theorem envBound2457 : H12AffineFastState.Bounded env2457 := by
  intro p hp
  have h : env2457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2456_2457 : H12AffineEnvironment.transform 4 0 env2456 = env2457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2456 == env2457) = true)

def leafEnv2457 : List Nat := [2,4,8,8,0,8,8,14,1,14,0,8,8,8,10,2,8,10,14,10,8,10,8,2,4,8,1,8,10,9,9,0,4,10,14,0,4,2,8,1,0,8,1]

def active2457 : List Nat := [0,1,2]

def tree2457 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2457 : H12WitnessSearch.Good tree2457 := H12GlobalWitnessIndex.good

theorem leafIdentity2457 : H12AffineFastState.composeSystem env2457 rootObs = leafEnv2457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2457 rootObs == leafEnv2457) = true)

theorem terminalChecked2457 : H12PackedTerminal.terminalCheckFast leafEnv2457 active2457 tree2457 = true := by decide +kernel

def env2458 : List Nat := [2,4,8,8,1,8,8,14,1,15,1,9,8,9,10,2,9,10,15,10,9,10,8,2,8,8,10,8,8,1,5,11,14,0,9,1]

theorem envBound2458 : H12AffineFastState.Bounded env2458 := by
  intro p hp
  have h : env2458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2456_2458 : H12AffineEnvironment.transform 4 1 env2456 = env2458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2456 == env2458) = true)

theorem identity2458 : scanCanonicalize (H12AffineFastState.compose env2458 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2458 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2459 : List Nat := [2,4,2,2,1,2,2,4,1,5,1,3,2,3,0,2,3,0,5,0,3,0,2,2,2,2,0,2,2,1,5,1,4,0,3,1]

theorem envBound2459 : H12AffineFastState.Bounded env2459 := by
  intro p hp
  have h : env2459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2458_2459 : H12AffineEnvironment.transform 2 2 env2458 = env2459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2458 == env2459) = true)

def leafEnv2459 : List Nat := [2,4,2,2,1,2,2,4,1,5,1,3,2,3,0,2,3,0,5,0,3,0,2,2,5,2,1,2,0,2,2,1,5,1,4,0,4,2,3,1,0,3,1]

def active2459 : List Nat := [0,1]

def tree2459 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2459 : H12WitnessSearch.Good tree2459 := H12GlobalWitnessIndex.good

theorem leafIdentity2459 : H12AffineFastState.composeSystem env2459 rootObs = leafEnv2459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2459 rootObs == leafEnv2459) = true)

theorem terminalChecked2459 : H12PackedTerminal.terminalCheckFast leafEnv2459 active2459 tree2459 = true := by decide +kernel

def env2460 : List Nat := [2,4,8,9,32,9,9,15,0,46,33,40,8,40,11,3,40,10,46,11,40,10,9,3,9,9,11,41,41,32,37,42,15,0,40,0]

theorem envBound2460 : H12AffineFastState.Bounded env2460 := by
  intro p hp
  have h : env2460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2455_2460 : H12AffineEnvironment.transform 3 9 env2455 = env2460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env2455 == env2460) = true)

theorem identity2460 : scanCanonicalize (H12AffineFastState.compose env2460 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound2460 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2461 : List Nat := [2,4,8,9,11,9,9,15,0,5,10,3,8,3,11,3,3,10,5,11,3,10,9,3,9,9,11,2,2,11,14,1,15,0,3,0]

theorem envBound2461 : H12AffineFastState.Bounded env2461 := by
  intro p hp
  have h : env2461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2460_2461 : H12AffineEnvironment.transform 4 11 env2460 = env2461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env2460 == env2461) = true)

def leafEnv2461 : List Nat := [2,4,8,9,11,9,9,15,0,5,10,3,8,3,11,3,3,10,5,11,3,10,9,3,14,9,1,9,11,2,2,11,14,1,15,0,4,2,3,0,0,3,1]

def active2461 : List Nat := [0,1,2]

def tree2461 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2461 : H12WitnessSearch.Good tree2461 := H12GlobalWitnessIndex.good

theorem leafIdentity2461 : H12AffineFastState.composeSystem env2461 rootObs = leafEnv2461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2461 rootObs == leafEnv2461) = true)

theorem terminalChecked2461 : H12PackedTerminal.terminalCheckFast leafEnv2461 active2461 tree2461 = true := by decide +kernel

def env2462 : List Nat := [2,4,8,16,32,16,128,256,137,46,2048,318,8,318,260,268,318,2341,46,260,318,396,16,268,128,16,2477,319,319,2318,298,42,256,0,318,137]

theorem envBound2462 : H12AffineFastState.Bounded env2462 := by
  intro p hp
  have h : env2462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2451_2462 : H12AffineEnvironment.transform 17 2341 env2451 = env2462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env2451 == env2462) = true)

theorem identity2462 : scanCanonicalize (H12AffineFastState.compose env2462 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 62) := by decide +kernel

theorem selectedBound2462 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2463 : List Nat := [2,4,8,16,32,16,128,62,137,46,2048,0,8,0,58,50,0,2075,46,58,0,178,16,50,128,16,2195,1,1,2096,20,42,62,0,0,137]

theorem envBound2463 : H12AffineFastState.Bounded env2463 := by
  intro p hp
  have h : env2463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2462_2463 : H12AffineEnvironment.transform 7 62 env2462 = env2463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 62 env2462 == env2463) = true)

theorem identity2463 : scanCanonicalize (H12AffineFastState.compose env2463 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound2463 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env2464 : List Nat := [2,4,8,16,11,16,128,21,137,5,2048,0,8,0,17,25,0,2075,5,17,0,153,16,25,128,16,2195,1,1,2075,20,1,21,0,0,137]

theorem envBound2464 : H12AffineFastState.Bounded env2464 := by
  intro p hp
  have h : env2464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2463_2464 : H12AffineEnvironment.transform 4 11 env2463 = env2464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env2463 == env2464) = true)

def env2465 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,5141,65536,4096,262144,1024,5141,4096,4194304,5377,65536,4259840,67108864,4461589,67110144,4096,71371167,4117,4294967296,256,4362089762,4096,4268680]

theorem envBound2465 : H12AffineFastState.Bounded env2465 := by
  intro p hp
  have h : env2465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2426_2465 : H12AffineEnvironment.transform 5 17 env2426 = env2465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2426 == env2465) = true)

theorem identity2465 : scanCanonicalize (H12AffineFastState.compose env2465 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 15421) := by decide +kernel

theorem selectedBound2465 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env2466 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,5141,65536,4096,15421,1024,5141,4096,4194304,5377,65536,4259840,67108864,4204584,67110144,4096,71371167,4117,4294967296,256,4362089762,4096,4268680]

theorem envBound2466 : H12AffineFastState.Bounded env2466 := by
  intro p hp
  have h : env2466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2465_2466 : H12AffineEnvironment.transform 17 15421 env2465 = env2466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 15421 env2465 == env2466) = true)

theorem identity2466 : scanCanonicalize (H12AffineFastState.compose env2466 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 8194) := by decide +kernel

theorem selectedBound2466 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env2467 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,5141,65536,4096,15421,1024,5141,4096,8194,5377,65536,73730,67108864,2090,67110144,4096,67185053,4117,4294967296,256,4362089762,4096,66186]

theorem envBound2467 : H12AffineFastState.Bounded env2467 := by
  intro p hp
  have h : env2467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2466_2467 : H12AffineEnvironment.transform 21 8194 env2466 = env2467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 8194 env2466 == env2467) = true)

theorem identity2467 : scanCanonicalize (H12AffineFastState.compose env2467 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(25+1) ^^^ 71050) := by decide +kernel

theorem selectedBound2467 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env2468 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,5141,65536,4096,15421,1024,5141,4096,8194,5377,65536,73730,71050,2090,69770,4096,15383,4117,4294967296,256,4295041192,4096,66186]

theorem envBound2468 : H12AffineFastState.Bounded env2468 := by
  intro p hp
  have h : env2468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2467_2468 : H12AffineEnvironment.transform 25 71050 env2467 = env2468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 71050 env2467 == env2468) = true)

theorem identity2468 : scanCanonicalize (H12AffineFastState.compose env2468 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(10+1) ^^^ 934) := by decide +kernel

theorem selectedBound2468 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env2469 : List Nat := [2,4,8,16,32,17,128,256,512,1024,934,4096,8192,4097,5141,65536,4096,14235,1024,5141,4096,8194,5377,65536,73730,71050,908,69770,4096,14257,4117,4294967296,256,4295041192,4096,66186]

theorem envBound2469 : H12AffineFastState.Bounded env2469 := by
  intro p hp
  have h : env2469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2468_2469 : H12AffineEnvironment.transform 10 934 env2468 = env2469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 934 env2468 == env2469) = true)

theorem identity2469 : scanCanonicalize (H12AffineFastState.compose env2469 (packedSelected [0,4,7,8,9,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2469 : packedSelected [0,4,7,8,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env2470 : List Nat := [2,4,8,16,32,17,128,256,512,1024,934,4096,8,4097,5141,65536,4096,6035,1024,5141,4096,10,5377,65536,65546,71050,908,69770,4096,6073,4117,4294967296,256,4295032992,4096,66186]

theorem envBound2470 : H12AffineFastState.Bounded env2470 := by
  intro p hp
  have h : env2470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2469_2470 : H12AffineEnvironment.transform 12 8 env2469 = env2470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2469 == env2470) = true)

theorem identity2470 : scanCanonicalize (H12AffineFastState.compose env2470 (packedSelected [0,2,4,5,11,12] rootPS)) = affineNative (2^(11+1) ^^^ 697) := by decide +kernel

theorem selectedBound2470 : packedSelected [0,2,4,5,11,12] rootPS < 2^1333 := by decide +kernel

def env2471 : List Nat := [2,4,8,16,32,17,128,256,512,1024,934,697,8,696,1708,65536,697,1322,1024,1708,697,10,1976,65536,65546,67379,908,66099,697,1280,684,4294967296,256,4295032992,697,66186]

theorem envBound2471 : H12AffineFastState.Bounded env2471 := by
  intro p hp
  have h : env2471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2470_2471 : H12AffineEnvironment.transform 11 697 env2470 = env2471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 697 env2470 == env2471) = true)

theorem identity2471 : scanCanonicalize (H12AffineFastState.compose env2471 (packedSelected [1,2,3,5,7,8,9,10,11,17] rootPS)) = affineNative (2^(9+1) ^^^ 558) := by decide +kernel

theorem selectedBound2471 : packedSelected [1,2,3,5,7,8,9,10,11,17] rootPS < 2^1333 := by decide +kernel

def env2472 : List Nat := [2,4,8,16,32,17,128,256,512,558,934,697,8,696,130,65536,697,772,558,130,697,10,406,65536,65546,65821,908,66099,697,814,684,4294967296,256,4295032992,697,66186]

theorem envBound2472 : H12AffineFastState.Bounded env2472 := by
  intro p hp
  have h : env2472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2471_2472 : H12AffineEnvironment.transform 9 558 env2471 = env2472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 558 env2471 == env2472) = true)

theorem identity2472 : scanCanonicalize (H12AffineFastState.compose env2472 (packedSelected [1,2,3,6,7,8,11,22] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound2472 : packedSelected [1,2,3,6,7,8,11,22] rootPS < 2^1333 := by decide +kernel

def env2473 : List Nat := [2,4,8,16,32,17,128,256,512,558,934,697,8,696,130,138,697,772,558,130,697,10,406,138,128,407,908,697,697,814,684,4294967296,256,4294967338,697,512]

theorem envBound2473 : H12AffineFastState.Bounded env2473 := by
  intro p hp
  have h : env2473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2472_2473 : H12AffineEnvironment.transform 15 138 env2472 = env2473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env2472 == env2473) = true)

theorem identity2473 : scanCanonicalize (H12AffineFastState.compose env2473 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 428) := by decide +kernel

theorem selectedBound2473 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2474 : List Nat := [2,4,8,16,32,17,128,256,512,558,934,697,8,696,130,138,697,772,558,130,697,10,406,138,128,407,908,697,697,814,684,428,256,390,697,512]

theorem envBound2474 : H12AffineFastState.Bounded env2474 := by
  intro p hp
  have h : env2474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2473_2474 : H12AffineEnvironment.transform 31 428 env2473 = env2474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 428 env2473 == env2474) = true)

theorem identity2474 : scanCanonicalize (H12AffineFastState.compose env2474 (packedSelected [3,10] rootPS)) = affineNative (2^(8+1) ^^^ 270) := by decide +kernel

theorem selectedBound2474 : packedSelected [3,10] rootPS < 2^1333 := by decide +kernel

def env2475 : List Nat := [2,4,8,16,32,17,128,256,270,288,168,439,8,438,130,138,439,10,288,130,439,10,406,138,128,407,130,439,439,32,418,428,256,390,439,270]

theorem envBound2475 : H12AffineFastState.Bounded env2475 := by
  intro p hp
  have h : env2475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2474_2475 : H12AffineEnvironment.transform 8 270 env2474 = env2475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 270 env2474 == env2475) = true)

theorem identity2475 : scanCanonicalize (H12AffineFastState.compose env2475 (packedSelected [1,26] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound2475 : packedSelected [1,26] rootPS < 2^1333 := by decide +kernel

def env2476 : List Nat := [2,4,8,16,32,17,128,134,136,166,168,49,8,48,130,138,49,10,166,130,49,10,16,138,128,17,130,49,49,32,36,42,134,0,49,136]

theorem envBound2476 : H12AffineFastState.Bounded env2476 := by
  intro p hp
  have h : env2476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2475_2476 : H12AffineEnvironment.transform 7 134 env2475 = env2476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env2475 == env2476) = true)

theorem identity2476 : scanCanonicalize (H12AffineFastState.compose env2476 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound2476 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2477 : List Nat := [2,4,8,16,32,17,8,14,0,46,32,49,8,48,10,2,49,10,46,10,49,10,16,2,8,17,10,49,49,32,36,42,14,0,49,0]

theorem envBound2477 : H12AffineFastState.Bounded env2477 := by
  intro p hp
  have h : env2477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2476_2477 : H12AffineEnvironment.transform 6 8 env2476 = env2477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env2476 == env2477) = true)

theorem identity2477 : scanCanonicalize (H12AffineFastState.compose env2477 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound2477 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2478 : List Nat := [2,4,8,9,32,8,8,14,0,46,32,40,8,41,10,2,40,10,46,10,40,10,9,2,8,8,10,40,40,32,36,42,14,0,40,0]

theorem envBound2478 : H12AffineFastState.Bounded env2478 := by
  intro p hp
  have h : env2478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2477_2478 : H12AffineEnvironment.transform 3 9 env2477 = env2478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env2477 == env2478) = true)

def env2479 : List Nat := [2,4,8,9,0,8,8,14,0,14,0,8,8,9,10,2,8,10,14,10,8,10,9,2,8,8,10,8,8,0,4,10,14,0,8,0]

theorem envBound2479 : H12AffineFastState.Bounded env2479 := by
  intro p hp
  have h : env2479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2478_2479 : H12AffineEnvironment.transform 4 0 env2478 = env2479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2478 == env2479) = true)

def env2480 : List Nat := [2,4,8,9,1,8,8,14,0,15,1,9,8,8,10,2,9,10,15,10,9,10,9,2,8,8,10,9,9,1,5,11,14,0,9,0]

theorem envBound2480 : H12AffineFastState.Bounded env2480 := by
  intro p hp
  have h : env2480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2478_2480 : H12AffineEnvironment.transform 4 1 env2478 = env2480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2478 == env2480) = true)

theorem identity2480 : scanCanonicalize (H12AffineFastState.compose env2480 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2480 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2481 : List Nat := [2,4,3,2,1,3,3,5,0,4,1,2,3,3,1,2,2,1,4,1,2,1,2,2,3,3,1,2,2,1,5,0,5,0,2,0]

theorem envBound2481 : H12AffineFastState.Bounded env2481 := by
  intro p hp
  have h : env2481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2480_2481 : H12AffineEnvironment.transform 2 3 env2480 = env2481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2480 == env2481) = true)

def leafEnv2481 : List Nat := [2,4,3,2,1,3,3,5,0,4,1,2,3,3,1,2,2,1,4,1,2,1,2,2,5,3,1,3,1,2,2,1,5,0,5,0,4,2,2,0,0,3,1]

def active2481 : List Nat := [0,1]

def tree2481 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2481 : H12WitnessSearch.Good tree2481 := H12GlobalWitnessIndex.good

theorem leafIdentity2481 : H12AffineFastState.composeSystem env2481 rootObs = leafEnv2481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2481 rootObs == leafEnv2481) = true)

theorem terminalChecked2481 : H12PackedTerminal.terminalCheckFast leafEnv2481 active2481 tree2481 = true := by decide +kernel

def env2482 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5456,103493,4259840,67108864,4461637,67110225,4176,71409034,4165,4294967296,256,4362117479,4097,4268680]

theorem envBound2482 : H12AffineFastState.Bounded env2482 := by
  intro p hp
  have h : env2482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2424_2482 : H12AffineEnvironment.transform 16 4097 env2424 = env2482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env2424 == env2482) = true)

theorem identity2482 : scanCanonicalize (H12AffineFastState.compose env2482 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 112197) := by decide +kernel

theorem selectedBound2482 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env2483 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,112197,5456,103493,46661,67108864,369152,67110225,4176,67120079,4165,4294967296,256,4362117479,4097,38093]

theorem envBound2483 : H12AffineFastState.Bounded env2483 := by
  intro p hp
  have h : env2483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2482_2483 : H12AffineEnvironment.transform 21 112197 env2482 = env2483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 112197 env2482 == env2483) = true)

def env2484 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,1024,32768,4096,112149,5376,103445,46613,67108864,369152,67110145,4096,67120031,4117,4294967296,256,4362117431,4097,38045]

theorem envBound2484 : H12AffineFastState.Bounded env2484 := by
  intro p hp
  have h : env2484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2483_2484 : H12AffineEnvironment.transform 5 16 env2483 = env2484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2483 == env2484) = true)

theorem identity2484 : scanCanonicalize (H12AffineFastState.compose env2484 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2484 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env2485 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,43048,1024,32768,4096,112149,5376,103445,46613,67108864,68136,67110145,4096,67120031,4117,4294967296,256,4362117431,4097,38045]

theorem envBound2485 : H12AffineFastState.Bounded env2485 := by
  intro p hp
  have h : env2485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2484_2485 : H12AffineEnvironment.transform 17 43048 env2484 = env2485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2484 == env2485) = true)

theorem identity2485 : scanCanonicalize (H12AffineFastState.compose env2485 (packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS)) = affineNative (2^(25+1) ^^^ 6025) := by decide +kernel

theorem selectedBound2485 : packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS < 2^1333 := by decide +kernel

def env2486 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,43048,1024,32768,4096,112149,5376,103445,46613,6025,68136,4744,4096,15382,4117,4294967296,256,4295014078,4097,38045]

theorem envBound2486 : H12AffineFastState.Bounded env2486 := by
  intro p hp
  have h : env2486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2485_2486 : H12AffineEnvironment.transform 25 6025 env2485 = env2486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 6025 env2485 == env2486) = true)

theorem identity2486 : scanCanonicalize (H12AffineFastState.compose env2486 (packedSelected [0,1,3,4,5,7,8,9,10,11,18,19,23,32] rootPS)) = affineNative (2^(15+1) ^^^ 514) := by decide +kernel

theorem selectedBound2486 : packedSelected [0,1,3,4,5,7,8,9,10,11,18,19,23,32] rootPS < 2^1333 := by decide +kernel

def env2487 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,514,4097,43048,1024,32768,4096,46103,5376,38423,46613,6025,2090,4744,4096,15382,4117,4294967296,256,4295014078,4097,38045]

theorem envBound2487 : H12AffineFastState.Bounded env2487 := by
  intro p hp
  have h : env2487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2486_2487 : H12AffineEnvironment.transform 15 514 env2486 = env2487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 514 env2486 == env2487) = true)

theorem identity2487 : scanCanonicalize (H12AffineFastState.compose env2487 (packedSelected [0,1,3,4,5,7,8,9,11,12,13,15,17,18,20] rootPS)) = affineNative (2^(14+1) ^^^ 5140) := by decide +kernel

theorem selectedBound2487 : packedSelected [0,1,3,4,5,7,8,9,11,12,13,15,17,18,20] rootPS < 2^1333 := by decide +kernel

def env2488 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,5140,514,4097,15420,1024,5140,4096,8195,5376,515,8705,6025,2090,4744,4096,15382,4117,4294967296,256,4294976170,4097,137]

theorem envBound2488 : H12AffineFastState.Bounded env2488 := by
  intro p hp
  have h : env2488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2487_2488 : H12AffineEnvironment.transform 14 5140 env2487 = env2488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5140 env2487 == env2488) = true)

theorem identity2488 : scanCanonicalize (H12AffineFastState.compose env2488 (packedSelected [2,5,6,7,9,12,13,15,16,17,18] rootPS)) = affineNative (2^(10+1) ^^^ 935) := by decide +kernel

theorem selectedBound2488 : packedSelected [2,5,6,7,9,12,13,15,16,17,18] rootPS < 2^1333 := by decide +kernel

def env2489 : List Nat := [2,4,8,16,32,16,128,256,512,1024,935,4096,8192,4096,5140,514,4097,14235,1024,5140,4096,8195,5376,515,8705,6025,909,4744,4096,14257,4117,4294967296,256,4294976170,4097,137]

theorem envBound2489 : H12AffineFastState.Bounded env2489 := by
  intro p hp
  have h : env2489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2488_2489 : H12AffineEnvironment.transform 10 935 env2488 = env2489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 935 env2488 == env2489) = true)

theorem identity2489 : scanCanonicalize (H12AffineFastState.compose env2489 (packedSelected [0,4,7,8,9,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2489 : packedSelected [0,4,7,8,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env2490 : List Nat := [2,4,8,16,32,16,128,256,512,1024,935,4096,8,4096,5140,514,4097,6035,1024,5140,4096,11,5376,515,521,6025,909,4744,4096,6073,4117,4294967296,256,4294967970,4097,137]

theorem envBound2490 : H12AffineFastState.Bounded env2490 := by
  intro p hp
  have h : env2490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2489_2490 : H12AffineEnvironment.transform 12 8 env2489 = env2490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2489 == env2490) = true)

theorem identity2490 : scanCanonicalize (H12AffineFastState.compose env2490 (packedSelected [2,4,6,7,8] rootPS)) = affineNative (2^(11+1) ^^^ 1055) := by decide +kernel

theorem selectedBound2490 : packedSelected [2,4,6,7,8] rootPS < 2^1333 := by decide +kernel

def env2491 : List Nat := [2,4,8,16,32,16,128,256,512,1024,935,1055,8,1055,11,514,1054,908,1024,11,1055,11,287,515,521,918,909,1687,1055,934,1034,4294967296,256,4294967970,1054,137]

theorem envBound2491 : H12AffineFastState.Bounded env2491 := by
  intro p hp
  have h : env2491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2490_2491 : H12AffineEnvironment.transform 11 1055 env2490 = env2491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1055 env2490 == env2491) = true)

theorem identity2491 : scanCanonicalize (H12AffineFastState.compose env2491 (packedSelected [0,1,3,4,5,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 271) := by decide +kernel

theorem selectedBound2491 : packedSelected [0,1,3,4,5,7,9] rootPS < 2^1333 := by decide +kernel

def env2492 : List Nat := [2,4,8,16,32,16,128,256,271,1024,168,1055,8,1055,11,269,1054,131,1024,11,1055,11,287,268,262,153,130,1432,1055,169,1034,4294967296,256,4294967725,1054,137]

theorem envBound2492 : H12AffineFastState.Bounded env2492 := by
  intro p hp
  have h : env2492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2491_2492 : H12AffineEnvironment.transform 8 271 env2491 = env2492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 271 env2491 == env2492) = true)

theorem identity2492 : scanCanonicalize (H12AffineFastState.compose env2492 (packedSelected [0,1,2,3,4,5,6,11] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound2492 : packedSelected [0,1,2,3,4,5,6,11] rootPS < 2^1333 := by decide +kernel

def env2493 : List Nat := [2,4,8,16,32,16,128,134,137,1024,168,1055,8,1055,11,139,1054,131,1024,11,1055,11,153,138,128,153,130,1054,1055,169,1034,4294967296,134,4294967339,1054,137]

theorem envBound2493 : H12AffineFastState.Bounded env2493 := by
  intro p hp
  have h : env2493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2492_2493 : H12AffineEnvironment.transform 7 134 env2492 = env2493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env2492 == env2493) = true)

theorem identity2493 : scanCanonicalize (H12AffineFastState.compose env2493 (packedSelected [0,1,2,3,4] rootPS)) = affineNative (2^(31+1) ^^^ 136) := by decide +kernel

theorem selectedBound2493 : packedSelected [0,1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env2494 : List Nat := [2,4,8,16,32,16,128,134,137,1024,168,1055,8,1055,11,139,1054,131,1024,11,1055,11,153,138,128,153,130,1054,1055,169,1034,136,134,163,1054,137]

theorem envBound2494 : H12AffineFastState.Bounded env2494 := by
  intro p hp
  have h : env2494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2493_2494 : H12AffineEnvironment.transform 31 136 env2493 = env2494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 136 env2493 == env2494) = true)

theorem identity2494 : scanCanonicalize (H12AffineFastState.compose env2494 (packedSelected [6] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2494 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2495 : List Nat := [2,4,8,16,10,16,128,134,137,1024,130,1055,8,1055,11,139,1054,131,1024,11,1055,11,153,138,128,153,130,1054,1055,131,1034,136,134,137,1054,137]

theorem envBound2495 : H12AffineFastState.Bounded env2495 := by
  intro p hp
  have h : env2495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2494_2495 : H12AffineEnvironment.transform 4 10 env2494 = env2495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2494 == env2495) = true)

theorem identity2495 : scanCanonicalize (H12AffineFastState.compose env2495 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound2495 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2496 : List Nat := [2,4,8,16,10,16,8,14,1,1024,10,1055,8,1055,11,3,1054,11,1024,11,1055,11,17,2,8,17,10,1054,1055,11,1034,0,14,1,1054,1]

theorem envBound2496 : H12AffineFastState.Bounded env2496 := by
  intro p hp
  have h : env2496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2495_2496 : H12AffineEnvironment.transform 6 8 env2495 = env2496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env2495 == env2496) = true)

theorem identity2496 : scanCanonicalize (H12AffineFastState.compose env2496 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound2496 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2497 : List Nat := [2,4,8,9,10,9,8,14,1,1024,10,1030,8,1030,11,3,1031,11,1024,11,1030,11,8,2,8,8,10,1031,1030,11,1034,0,14,1,1031,1]

theorem envBound2497 : H12AffineFastState.Bounded env2497 := by
  intro p hp
  have h : env2497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2496_2497 : H12AffineEnvironment.transform 3 9 env2496 = env2497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env2496 == env2497) = true)

def env2498 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,1024,32768,4096,112148,5377,103444,46612,67108864,369152,67110144,4097,67120030,4116,4294967296,256,4362117430,4097,38044]

theorem envBound2498 : H12AffineFastState.Bounded env2498 := by
  intro p hp
  have h : env2498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2483_2498 : H12AffineEnvironment.transform 5 17 env2483 = env2498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2483 == env2498) = true)

theorem identity2498 : scanCanonicalize (H12AffineFastState.compose env2498 (packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound2498 : packedSelected [0,1,3,4,5,6,7,8,9,10,16,19,20,25] rootPS < 2^1333 := by decide +kernel

def env2499 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,32768,65536,1944,262144,1024,32768,1945,106893,664,99213,41357,67108864,369152,67110144,1944,67120030,1933,4294967296,256,4362117430,1944,33541]

theorem envBound2499 : H12AffineFastState.Bounded env2499 := by
  intro p hp
  have h : env2499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2498_2499 : H12AffineEnvironment.transform 11 1945 env2498 = env2499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env2498 == env2499) = true)

def env2500 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,32768,65536,1944,262144,1024,32768,1945,106893,664,99213,41357,16,369152,1296,1944,11150,1933,4294967296,256,4295008550,1944,33541]

theorem envBound2500 : H12AffineFastState.Bounded env2500 := by
  intro p hp
  have h : env2500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2499_2500 : H12AffineEnvironment.transform 25 16 env2499 = env2500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 16 env2499 == env2500) = true)

theorem identity2500 : scanCanonicalize (H12AffineFastState.compose env2500 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 908) := by decide +kernel

theorem selectedBound2500 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2501 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,908,65536,1944,262144,1024,908,1945,74241,664,65537,8705,16,336268,1296,1944,11150,1933,4294967296,256,4294976170,1944,137]

theorem envBound2501 : H12AffineFastState.Bounded env2501 := by
  intro p hp
  have h : env2501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2500_2501 : H12AffineEnvironment.transform 14 908 env2500 = env2501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 908 env2500 == env2501) = true)

theorem identity2501 : scanCanonicalize (H12AffineFastState.compose env2501 (packedSelected [1,3,17] rootPS)) = affineNative (2^(15+1) ^^^ 8453) := by decide +kernel

theorem selectedBound2501 : packedSelected [1,3,17] rootPS < 2^1333 := by decide +kernel

def env2502 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,908,8453,1944,262144,1024,908,1945,772,664,8452,8705,16,262281,1296,1944,11150,1933,4294967296,256,4294976170,1944,137]

theorem envBound2502 : H12AffineFastState.Bounded env2502 := by
  intro p hp
  have h : env2502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2501_2502 : H12AffineEnvironment.transform 15 8453 env2501 = env2502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8453 env2501 == env2502) = true)

theorem identity2502 : scanCanonicalize (H12AffineFastState.compose env2502 (packedSelected [4,9,16] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2502 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2503 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1296,260,8453,1296,262144,1024,260,1297,396,16,8452,8329,16,262281,1296,1296,10502,1285,4294967296,256,4294975522,1296,137]

theorem envBound2503 : H12AffineFastState.Bounded env2503 := by
  intro p hp
  have h : env2503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2502_2503 : H12AffineEnvironment.transform 8 136 env2502 = env2503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2502 == env2503) = true)

theorem identity2503 : scanCanonicalize (H12AffineFastState.compose env2503 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound2503 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env2504 : List Nat := [2,4,8,16,32,17,128,256,136,1024,10,1297,8192,1296,260,8453,1296,262144,1024,260,1297,396,16,8452,8329,16,262281,1296,1296,8460,1285,4294967296,256,4294975522,1296,137]

theorem envBound2504 : H12AffineFastState.Bounded env2504 := by
  intro p hp
  have h : env2504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2503_2504 : H12AffineEnvironment.transform 10 10 env2503 = env2504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env2503 == env2504) = true)

theorem identity2504 : scanCanonicalize (H12AffineFastState.compose env2504 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 271534) := by decide +kernel

theorem selectedBound2504 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2505 : List Nat := [2,4,8,16,32,17,128,256,136,1024,10,1297,8192,1296,260,8453,1296,262144,1024,260,1297,396,16,8452,8329,16,262281,1296,1296,8460,1285,271534,256,263308,1296,137]

theorem envBound2505 : H12AffineFastState.Bounded env2505 := by
  intro p hp
  have h : env2505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2504_2505 : H12AffineEnvironment.transform 31 271534 env2504 = env2505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 271534 env2504 == env2505) = true)

theorem identity2505 : scanCanonicalize (H12AffineFastState.compose env2505 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 303) := by decide +kernel

theorem selectedBound2505 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env2506 : List Nat := [2,4,8,16,32,17,128,256,136,1024,10,1297,8192,1296,260,8453,1296,303,1024,260,1297,396,16,8452,8329,16,422,1296,1296,8460,1285,9601,256,1443,1296,137]

theorem envBound2506 : H12AffineFastState.Bounded env2506 := by
  intro p hp
  have h : env2506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2505_2506 : H12AffineEnvironment.transform 17 303 env2505 = env2506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 303 env2505 == env2506) = true)

def env2507 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,32768,65536,1944,262144,1024,32768,1945,106893,664,99213,41357,17,369152,1297,1944,11151,1933,4294967296,256,4295008551,1944,33541]

theorem envBound2507 : H12AffineFastState.Bounded env2507 := by
  intro p hp
  have h : env2507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2499_2507 : H12AffineEnvironment.transform 25 17 env2499 = env2507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17 env2499 == env2507) = true)

theorem identity2507 : scanCanonicalize (H12AffineFastState.compose env2507 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound2507 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2508 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,261,65536,1944,262144,1024,261,1945,73864,664,66184,8328,17,336645,1297,1944,11151,1933,4294967296,256,4294975522,1944,512]

theorem envBound2508 : H12AffineFastState.Bounded env2508 := by
  intro p hp
  have h : env2508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2507_2508 : H12AffineEnvironment.transform 14 261 env2507 = env2508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env2507 == env2508) = true)

theorem identity2508 : scanCanonicalize (H12AffineFastState.compose env2508 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 9101) := by decide +kernel

theorem selectedBound2508 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2509 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,261,9101,1944,262144,1024,261,1945,773,664,8453,8328,17,262280,1297,1944,11151,1933,4294967296,256,4294975522,1944,512]

theorem envBound2509 : H12AffineFastState.Bounded env2509 := by
  intro p hp
  have h : env2509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2508_2509 : H12AffineEnvironment.transform 15 9101 env2508 = env2509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9101 env2508 == env2509) = true)

theorem identity2509 : scanCanonicalize (H12AffineFastState.compose env2509 (packedSelected [1,5,8,10,13,17] rootPS)) = affineNative (2^(31+1) ^^^ 1071) := by decide +kernel

theorem selectedBound2509 : packedSelected [1,5,8,10,13,17] rootPS < 2^1333 := by decide +kernel

def env2510 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,8192,1944,261,9101,1944,262144,1024,261,1945,773,664,8453,8328,17,262280,1297,1944,11151,1933,1071,256,9229,1944,512]

theorem envBound2510 : H12AffineFastState.Bounded env2510 := by
  intro p hp
  have h : env2510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2509_2510 : H12AffineEnvironment.transform 31 1071 env2509 = env2510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1071 env2509 == env2510) = true)

theorem identity2510 : scanCanonicalize (H12AffineFastState.compose env2510 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2510 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env2511 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1296,261,8453,1296,262144,1024,261,1297,397,16,8453,8328,17,262280,1297,1296,10503,1285,1071,256,9229,1296,136]

theorem envBound2511 : H12AffineFastState.Bounded env2511 := by
  intro p hp
  have h : env2511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2510_2511 : H12AffineEnvironment.transform 8 136 env2510 = env2511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2510 == env2511) = true)

theorem identity2511 : scanCanonicalize (H12AffineFastState.compose env2511 (packedSelected [6] rootPS)) = affineNative (2^(12+1) ^^^ 1037) := by decide +kernel

theorem selectedBound2511 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2512 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,1037,1296,261,1288,1296,262144,1024,261,1297,397,16,1288,1157,17,262280,1297,1296,3338,1285,1071,256,0,1296,136]

theorem envBound2512 : H12AffineFastState.Bounded env2512 := by
  intro p hp
  have h : env2512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2511_2512 : H12AffineEnvironment.transform 12 1037 env2511 = env2512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1037 env2511 == env2512) = true)

theorem identity2512 : scanCanonicalize (H12AffineFastState.compose env2512 (packedSelected [3,12] rootPS)) = affineNative (2^(17+1) ^^^ 3109) := by decide +kernel

theorem selectedBound2512 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env2513 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,1037,1296,261,1288,1296,3109,1024,261,1297,397,16,1288,1157,17,3245,1297,1296,3338,1285,1071,256,0,1296,136]

theorem envBound2513 : H12AffineFastState.Bounded env2513 := by
  intro p hp
  have h : env2513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2512_2513 : H12AffineEnvironment.transform 17 3109 env2512 = env2513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 3109 env2512 == env2513) = true)

theorem identity2513 : scanCanonicalize (H12AffineFastState.compose env2513 (packedSelected [1,3,13] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound2513 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env2514 : List Nat := [2,4,8,16,32,17,128,134,136,1024,2048,1175,1037,1174,131,1166,1174,3109,1024,131,1175,11,16,1166,1157,17,3245,1175,1174,3212,1155,1071,134,0,1174,136]

theorem envBound2514 : H12AffineFastState.Bounded env2514 := by
  intro p hp
  have h : env2514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2513_2514 : H12AffineEnvironment.transform 7 134 env2513 = env2514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env2513 == env2514) = true)

theorem identity2514 : scanCanonicalize (H12AffineFastState.compose env2514 (packedSelected [1,15] rootPS)) = affineNative (2^(9+1) ^^^ 135) := by decide +kernel

theorem selectedBound2514 : packedSelected [1,15] rootPS < 2^1333 := by decide +kernel

def env2515 : List Nat := [2,4,8,16,32,17,128,134,136,135,2048,16,138,17,131,9,17,2210,135,131,16,11,16,9,2,17,2090,16,17,2059,4,168,134,0,17,136]

theorem envBound2515 : H12AffineFastState.Bounded env2515 := by
  intro p hp
  have h : env2515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2514_2515 : H12AffineEnvironment.transform 9 135 env2514 = env2515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 135 env2514 == env2515) = true)

theorem identity2515 : scanCanonicalize (H12AffineFastState.compose env2515 (packedSelected [9,22] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound2515 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env2516 : List Nat := [2,4,8,16,32,17,2,4,10,5,2048,16,8,17,1,9,17,2080,5,1,16,11,16,9,2,17,2090,16,17,2059,4,42,4,0,17,10]

theorem envBound2516 : H12AffineFastState.Bounded env2516 := by
  intro p hp
  have h : env2516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2515_2516 : H12AffineEnvironment.transform 6 2 env2515 = env2516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env2515 == env2516) = true)

theorem identity2516 : scanCanonicalize (H12AffineFastState.compose env2516 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound2516 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2517 : List Nat := [2,4,8,16,26,17,2,4,10,5,2048,16,8,17,1,9,17,2074,5,1,16,11,16,9,2,17,2064,16,17,2059,4,16,4,0,17,10]

theorem envBound2517 : H12AffineFastState.Bounded env2517 := by
  intro p hp
  have h : env2517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2516_2517 : H12AffineEnvironment.transform 4 26 env2516 = env2517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env2516 == env2517) = true)

theorem identity2517 : scanCanonicalize (H12AffineFastState.compose env2517 (packedSelected [0,2,7] rootPS)) = affineNative (2^(10+1) ^^^ 16) := by decide +kernel

theorem selectedBound2517 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env2518 : List Nat := [2,4,8,16,26,17,2,4,10,5,16,16,8,17,1,9,17,10,5,1,16,11,16,9,2,17,0,16,17,27,4,16,4,0,17,10]

theorem envBound2518 : H12AffineFastState.Bounded env2518 := by
  intro p hp
  have h : env2518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2517_2518 : H12AffineEnvironment.transform 10 16 env2517 = env2518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 16 env2517 == env2518) = true)

theorem identity2518 : scanCanonicalize (H12AffineFastState.compose env2518 (packedSelected [0,2] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound2518 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env2519 : List Nat := [2,4,1,16,19,17,2,4,3,5,16,16,1,17,1,0,17,3,5,1,16,2,16,0,2,17,0,16,17,18,4,16,4,0,17,3]

theorem envBound2519 : H12AffineFastState.Bounded env2519 := by
  intro p hp
  have h : env2519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2518_2519 : H12AffineEnvironment.transform 2 1 env2518 = env2519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env2518 == env2519) = true)

theorem identity2519 : scanCanonicalize (H12AffineFastState.compose env2519 (packedSelected [0,4] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound2519 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env2520 : List Nat := [2,4,1,3,0,2,2,4,3,5,3,3,1,2,1,0,2,3,5,1,3,2,3,0,2,2,0,3,2,1,4,3,4,0,2,3]

theorem envBound2520 : H12AffineFastState.Bounded env2520 := by
  intro p hp
  have h : env2520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2519_2520 : H12AffineEnvironment.transform 3 3 env2519 = env2520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env2519 == env2520) = true)

theorem identity2520 : scanCanonicalize (H12AffineFastState.compose env2520 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2520 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2521 : List Nat := [1,4,1,0,0,1,1,4,0,5,0,0,1,1,1,0,1,0,5,1,0,1,0,0,1,1,0,0,1,1,4,0,4,0,1,0]

theorem envBound2521 : H12AffineFastState.Bounded env2521 := by
  intro p hp
  have h : env2521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2520_2521 : H12AffineEnvironment.transform 0 1 env2520 = env2521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2520 == env2521) = true)

def env2522 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230468,4259841,67108864,4588612,67110225,131153,71409034,131140,4294967296,256,4362252647,131072,4268681]

theorem envBound2522 : H12AffineFastState.Bounded env2522 := by
  intro p hp
  have h : env2522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2423_2522 : H12AffineEnvironment.transform 24 4259841 env2423 = env2522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4259841 env2423 == env2522) = true)

def env2523 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,4194304,5456,103492,4259841,67108864,4461636,67110225,4177,71409034,4164,4294967296,256,4362117479,4096,4268681]

theorem envBound2523 : H12AffineFastState.Bounded env2523 := by
  intro p hp
  have h : env2523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2522_2523 : H12AffineEnvironment.transform 16 4096 env2522 = env2523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env2522 == env2523) = true)

theorem identity2523 : scanCanonicalize (H12AffineFastState.compose env2523 (packedSelected [3,5,24] rootPS)) = affineNative (2^(25+1) ^^^ 37892) := by decide +kernel

theorem selectedBound2523 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env2524 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,4194304,5456,103492,4259841,37892,4461636,37205,4177,4262286,4164,4294967296,256,4294980963,4096,4268681]

theorem envBound2524 : H12AffineFastState.Bounded env2524 := by
  intro p hp
  have h : env2524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2523_2524 : H12AffineEnvironment.transform 25 37892 env2523 = env2524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 37892 env2523 == env2524) = true)

def env2525 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,103444,4259841,37892,4461588,37125,4097,4262286,4116,4294967296,256,4294980915,4096,4268681]

theorem envBound2525 : H12AffineFastState.Bounded env2525 := by
  intro p hp
  have h : env2525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2524_2525 : H12AffineEnvironment.transform 5 16 env2524 = env2525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2524 == env2525) = true)

def env2526 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,74240,5376,103444,8705,37892,341524,37125,4097,11150,4116,4294967296,256,4294980915,4096,137]

theorem envBound2526 : H12AffineFastState.Bounded env2526 := by
  intro p hp
  have h : env2526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2525_2526 : H12AffineEnvironment.transform 21 74240 env2525 = env2526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 74240 env2525 == env2526) = true)

theorem identity2526 : scanCanonicalize (H12AffineFastState.compose env2526 (packedSelected [0,4,5,7,9,10,16,20,26] rootPS)) = affineNative (2^(14+1) ^^^ 5140) := by decide +kernel

theorem selectedBound2526 : packedSelected [0,4,5,7,9,10,16,20,26] rootPS < 2^1333 := by decide +kernel

def env2527 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,5140,65536,4096,262144,1024,5140,4096,74240,5376,65536,8705,16,341524,1297,4097,11150,4116,4294967296,256,4294980915,4096,137]

theorem envBound2527 : H12AffineFastState.Bounded env2527 := by
  intro p hp
  have h : env2527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2526_2527 : H12AffineEnvironment.transform 14 5140 env2526 = env2527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5140 env2526 == env2527) = true)

theorem identity2527 : scanCanonicalize (H12AffineFastState.compose env2527 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound2527 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2528 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,8192,1945,909,65536,1945,262144,1024,909,1945,74240,665,65536,8705,16,336269,1297,1944,11150,1933,4294967296,256,4294976170,1945,137]

theorem envBound2528 : H12AffineFastState.Bounded env2528 := by
  intro p hp
  have h : env2528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2527_2528 : H12AffineEnvironment.transform 11 1945 env2527 = env2528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env2527 == env2528) = true)

theorem identity2528 : scanCanonicalize (H12AffineFastState.compose env2528 (packedSelected [1,3,17] rootPS)) = affineNative (2^(15+1) ^^^ 900) := by decide +kernel

theorem selectedBound2528 : packedSelected [1,3,17] rootPS < 2^1333 := by decide +kernel

def env2529 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1945,8192,1945,909,900,1945,262144,1024,909,1945,8580,665,900,8705,16,270857,1297,1944,11150,1933,4294967296,256,4294976170,1945,137]

theorem envBound2529 : H12AffineFastState.Bounded env2529 := by
  intro p hp
  have h : env2529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2528_2529 : H12AffineEnvironment.transform 15 900 env2528 = env2529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 900 env2528 == env2529) = true)

theorem identity2529 : scanCanonicalize (H12AffineFastState.compose env2529 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2529 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env2530 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8192,1296,260,269,1296,262144,1024,260,1296,8580,16,269,8328,16,270464,1297,1297,10503,1284,4294967296,256,4294975523,1296,137]

theorem envBound2530 : H12AffineFastState.Bounded env2530 := by
  intro p hp
  have h : env2530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2529_2530 : H12AffineEnvironment.transform 8 137 env2529 = env2530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2529 == env2530) = true)

theorem identity2530 : scanCanonicalize (H12AffineFastState.compose env2530 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8227) := by decide +kernel

theorem selectedBound2530 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2531 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8192,1296,260,269,1296,262144,1024,260,1296,8580,16,269,8328,16,270464,1297,1297,10503,1284,8227,256,0,1296,137]

theorem envBound2531 : H12AffineFastState.Bounded env2531 := by
  intro p hp
  have h : env2531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2530_2531 : H12AffineEnvironment.transform 31 8227 env2530 = env2531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8227 env2530 == env2531) = true)

theorem identity2531 : scanCanonicalize (H12AffineFastState.compose env2531 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound2531 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env2532 : List Nat := [2,4,8,16,32,16,128,256,137,47,2048,319,8192,319,260,269,319,262144,47,260,319,8580,16,269,8328,16,270464,318,318,10503,299,8227,256,0,319,137]

theorem envBound2532 : H12AffineFastState.Bounded env2532 := by
  intro p hp
  have h : env2532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2531_2532 : H12AffineEnvironment.transform 9 47 env2531 = env2532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env2531 == env2532) = true)

theorem identity2532 : scanCanonicalize (H12AffineFastState.compose env2532 (packedSelected [3,12] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2532 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env2533 : List Nat := [2,4,8,16,32,16,128,256,137,47,2048,319,8,319,260,269,319,262144,47,260,319,396,16,269,128,16,262280,318,318,2319,299,43,256,0,319,137]

theorem envBound2533 : H12AffineFastState.Bounded env2533 := by
  intro p hp
  have h : env2533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2532_2533 : H12AffineEnvironment.transform 12 8 env2532 = env2533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2532 == env2533) = true)

def env2534 : List Nat := [2,4,8,16,32,16,128,256,137,47,2048,319,8,319,260,269,319,2340,47,260,319,396,16,269,128,16,2476,318,318,2319,299,43,256,0,319,137]

theorem envBound2534 : H12AffineFastState.Bounded env2534 := by
  intro p hp
  have h : env2534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2533_2534 : H12AffineEnvironment.transform 17 2340 env2533 = env2534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env2533 == env2534) = true)

theorem identity2534 : scanCanonicalize (H12AffineFastState.compose env2534 (packedSelected [11,32] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound2534 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env2535 : List Nat := [2,4,8,16,32,16,128,135,137,47,2048,184,8,184,131,138,184,2211,47,131,184,11,16,138,128,16,2091,185,185,2184,172,43,135,0,184,137]

theorem envBound2535 : H12AffineFastState.Bounded env2535 := by
  intro p hp
  have h : env2535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2534_2535 : H12AffineEnvironment.transform 7 135 env2534 = env2535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env2534 == env2535) = true)

theorem identity2535 : scanCanonicalize (H12AffineFastState.compose env2535 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(10+1) ^^^ 169) := by decide +kernel

theorem selectedBound2535 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2536 : List Nat := [2,4,8,16,32,16,128,135,137,47,169,184,8,184,131,138,184,10,47,131,184,11,16,138,128,16,130,185,185,33,172,43,135,0,184,137]

theorem envBound2536 : H12AffineFastState.Bounded env2536 := by
  intro p hp
  have h : env2536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2535_2536 : H12AffineEnvironment.transform 10 169 env2535 = env2536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 169 env2535 == env2536) = true)

theorem identity2536 : scanCanonicalize (H12AffineFastState.compose env2536 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound2536 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2537 : List Nat := [2,4,8,16,18,16,128,135,137,29,155,138,8,138,131,138,138,10,29,131,138,11,16,138,128,16,130,139,139,19,158,25,135,0,138,137]

theorem envBound2537 : H12AffineFastState.Bounded env2537 := by
  intro p hp
  have h : env2537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2536_2537 : H12AffineEnvironment.transform 4 18 env2536 = env2537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env2536 == env2537) = true)

theorem identity2537 : scanCanonicalize (H12AffineFastState.compose env2537 (packedSelected [7] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound2537 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env2538 : List Nat := [2,4,8,8,10,8,128,135,137,5,131,138,8,138,131,138,138,10,5,131,138,11,8,138,128,8,130,139,139,11,134,1,135,0,138,137]

theorem envBound2538 : H12AffineFastState.Bounded env2538 := by
  intro p hp
  have h : env2538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2537_2538 : H12AffineEnvironment.transform 3 8 env2537 = env2538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env2537 == env2538) = true)

def leafEnv2538 : List Nat := [2,4,8,8,10,8,128,135,137,5,131,138,8,138,131,138,138,10,5,131,138,11,8,138,134,128,1,8,130,139,139,11,134,1,135,0,4,2,138,137,0,138,1]

def active2538 : List Nat := [0,1,2,6]

def tree2538 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2538 : H12WitnessSearch.Good tree2538 := H12GlobalWitnessIndex.good

theorem leafIdentity2538 : H12AffineFastState.composeSystem env2538 rootObs = leafEnv2538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2538 rootObs == leafEnv2538) = true)

theorem terminalChecked2538 : H12PackedTerminal.terminalCheckFast leafEnv2538 active2538 tree2538 = true := by decide +kernel

def env2539 : List Nat := [2,4,8,16,32,16,128,256,137,47,2048,319,8,319,260,269,319,2341,47,260,319,396,16,269,128,16,2477,318,318,2319,299,43,256,0,319,137]

theorem envBound2539 : H12AffineFastState.Bounded env2539 := by
  intro p hp
  have h : env2539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2533_2539 : H12AffineEnvironment.transform 17 2341 env2533 = env2539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env2533 == env2539) = true)

theorem identity2539 : scanCanonicalize (H12AffineFastState.compose env2539 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 63) := by decide +kernel

theorem selectedBound2539 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2540 : List Nat := [2,4,8,16,32,16,128,63,137,47,2048,0,8,0,59,50,0,2074,47,59,0,179,16,50,128,16,2194,1,1,2096,20,43,63,0,0,137]

theorem envBound2540 : H12AffineFastState.Bounded env2540 := by
  intro p hp
  have h : env2540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2539_2540 : H12AffineEnvironment.transform 7 63 env2539 = env2540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 63 env2539 == env2540) = true)

theorem identity2540 : scanCanonicalize (H12AffineFastState.compose env2540 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2540 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env2541 : List Nat := [2,4,8,16,10,16,128,21,137,5,2048,0,8,0,17,24,0,2074,5,17,0,153,16,24,128,16,2194,1,1,2074,20,1,21,0,0,137]

theorem envBound2541 : H12AffineFastState.Bounded env2541 := by
  intro p hp
  have h : env2541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2540_2541 : H12AffineEnvironment.transform 4 10 env2540 = env2541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2540 == env2541) = true)

def env2542 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,74241,5376,103444,8704,37892,341525,37125,4097,11151,4116,4294967296,256,4294980915,4096,136]

theorem envBound2542 : H12AffineFastState.Bounded env2542 := by
  intro p hp
  have h : env2542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2525_2542 : H12AffineEnvironment.transform 21 74241 env2525 = env2542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 74241 env2525 == env2542) = true)

theorem identity2542 : scanCanonicalize (H12AffineFastState.compose env2542 (packedSelected [0,4,5,7,9,10,16,20,26] rootPS)) = affineNative (2^(14+1) ^^^ 5788) := by decide +kernel

theorem selectedBound2542 : packedSelected [0,4,5,7,9,10,16,20,26] rootPS < 2^1333 := by decide +kernel

def env2543 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,5788,65536,4096,262144,1024,5788,4096,74241,5376,66184,8704,664,341525,1945,4097,11151,4116,4294967296,256,4294980915,4096,136]

theorem envBound2543 : H12AffineFastState.Bounded env2543 := by
  intro p hp
  have h : env2543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2542_2543 : H12AffineEnvironment.transform 14 5788 env2542 = env2543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5788 env2542 == env2543) = true)

theorem identity2543 : scanCanonicalize (H12AffineFastState.compose env2543 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound2543 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env2544 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,8192,1296,908,65536,1296,262144,1024,908,1296,74241,16,66184,8704,664,336645,1945,1297,11151,1284,4294967296,256,4294975523,1296,136]

theorem envBound2544 : H12AffineFastState.Bounded env2544 := by
  intro p hp
  have h : env2544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2543_2544 : H12AffineEnvironment.transform 11 1296 env2543 = env2544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2543 == env2544) = true)

theorem identity2544 : scanCanonicalize (H12AffineFastState.compose env2544 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 901) := by decide +kernel

theorem selectedBound2544 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2545 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,8192,1296,908,901,1296,262144,1024,908,1296,8580,16,269,8704,664,270464,1945,1297,11151,1284,4294967296,256,4294975523,1296,136]

theorem envBound2545 : H12AffineFastState.Bounded env2545 := by
  intro p hp
  have h : env2545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2544_2545 : H12AffineEnvironment.transform 15 901 env2544 = env2545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 901 env2544 == env2545) = true)

theorem identity2545 : scanCanonicalize (H12AffineFastState.compose env2545 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2545 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2546 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,260,269,1296,262144,1024,260,1296,8580,16,269,8328,16,270464,1297,1297,10503,1284,4294967296,256,4294975523,1296,136]

theorem envBound2546 : H12AffineFastState.Bounded env2546 := by
  intro p hp
  have h : env2546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2545_2546 : H12AffineEnvironment.transform 8 136 env2545 = env2546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2545 == env2546) = true)

theorem identity2546 : scanCanonicalize (H12AffineFastState.compose env2546 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8227) := by decide +kernel

theorem selectedBound2546 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2547 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,260,269,1296,262144,1024,260,1296,8580,16,269,8328,16,270464,1297,1297,10503,1284,8227,256,0,1296,136]

theorem envBound2547 : H12AffineFastState.Bounded env2547 := by
  intro p hp
  have h : env2547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2546_2547 : H12AffineEnvironment.transform 31 8227 env2546 = env2547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8227 env2546 == env2547) = true)

theorem identity2547 : scanCanonicalize (H12AffineFastState.compose env2547 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound2547 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env2548 : List Nat := [2,4,8,16,32,16,128,256,136,47,2048,319,8192,319,260,269,319,262144,47,260,319,8580,16,269,8328,16,270464,318,318,10503,299,8227,256,0,319,136]

theorem envBound2548 : H12AffineFastState.Bounded env2548 := by
  intro p hp
  have h : env2548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2547_2548 : H12AffineEnvironment.transform 9 47 env2547 = env2548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env2547 == env2548) = true)

theorem identity2548 : scanCanonicalize (H12AffineFastState.compose env2548 (packedSelected [3,12] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2548 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env2549 : List Nat := [2,4,8,16,32,16,128,256,136,47,2048,319,8,319,260,269,319,262144,47,260,319,396,16,269,128,16,262280,318,318,2319,299,43,256,0,319,136]

theorem envBound2549 : H12AffineFastState.Bounded env2549 := by
  intro p hp
  have h : env2549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2548_2549 : H12AffineEnvironment.transform 12 8 env2548 = env2549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2548 == env2549) = true)

def env2550 : List Nat := [2,4,8,16,32,16,128,256,136,47,2048,319,8,319,260,269,319,2340,47,260,319,396,16,269,128,16,2476,318,318,2319,299,43,256,0,319,136]

theorem envBound2550 : H12AffineFastState.Bounded env2550 := by
  intro p hp
  have h : env2550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2549_2550 : H12AffineEnvironment.transform 17 2340 env2549 = env2550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env2549 == env2550) = true)

theorem identity2550 : scanCanonicalize (H12AffineFastState.compose env2550 (packedSelected [11,32] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound2550 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env2551 : List Nat := [2,4,8,16,32,16,128,135,136,47,2048,184,8,184,131,138,184,2211,47,131,184,11,16,138,128,16,2091,185,185,2184,172,43,135,0,184,136]

theorem envBound2551 : H12AffineFastState.Bounded env2551 := by
  intro p hp
  have h : env2551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2550_2551 : H12AffineEnvironment.transform 7 135 env2550 = env2551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env2550 == env2551) = true)

theorem identity2551 : scanCanonicalize (H12AffineFastState.compose env2551 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(10+1) ^^^ 168) := by decide +kernel

theorem selectedBound2551 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2552 : List Nat := [2,4,8,16,32,16,128,135,136,47,168,184,8,184,131,138,184,11,47,131,184,11,16,138,128,16,131,185,185,32,172,43,135,0,184,136]

theorem envBound2552 : H12AffineFastState.Bounded env2552 := by
  intro p hp
  have h : env2552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2551_2552 : H12AffineEnvironment.transform 10 168 env2551 = env2552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 168 env2551 == env2552) = true)

theorem identity2552 : scanCanonicalize (H12AffineFastState.compose env2552 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound2552 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2553 : List Nat := [2,4,8,16,32,16,17,22,25,47,57,41,8,41,18,27,41,11,47,18,41,11,16,27,17,16,18,40,40,32,61,43,22,0,41,25]

theorem envBound2553 : H12AffineFastState.Bounded env2553 := by
  intro p hp
  have h : env2553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2552_2553 : H12AffineEnvironment.transform 6 17 env2552 = env2553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env2552 == env2553) = true)

def env2554 : List Nat := [2,4,8,8,32,8,9,14,1,47,33,41,8,41,10,3,41,11,47,10,41,11,8,3,9,8,10,40,40,32,37,43,14,0,41,1]

theorem envBound2554 : H12AffineFastState.Bounded env2554 := by
  intro p hp
  have h : env2554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2553_2554 : H12AffineEnvironment.transform 3 8 env2553 = env2554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env2553 == env2554) = true)

theorem identity2554 : scanCanonicalize (H12AffineFastState.compose env2554 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2554 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2555 : List Nat := [2,4,8,8,10,8,9,14,1,5,11,3,8,3,10,3,3,11,5,10,3,11,8,3,9,8,10,2,2,10,15,1,14,0,3,1]

theorem envBound2555 : H12AffineFastState.Bounded env2555 := by
  intro p hp
  have h : env2555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2554_2555 : H12AffineEnvironment.transform 4 10 env2554 = env2555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2554 == env2555) = true)

def env2556 : List Nat := [2,4,8,9,32,9,8,15,0,47,32,41,8,41,11,2,41,11,47,11,41,11,9,2,8,9,11,40,40,32,36,43,15,0,41,0]

theorem envBound2556 : H12AffineFastState.Bounded env2556 := by
  intro p hp
  have h : env2556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2553_2556 : H12AffineEnvironment.transform 3 9 env2553 = env2556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env2553 == env2556) = true)

def env2557 : List Nat := [2,4,8,9,0,9,8,15,0,15,0,9,8,9,11,2,9,11,15,11,9,11,9,2,8,9,11,8,8,0,4,11,15,0,9,0]

theorem envBound2557 : H12AffineFastState.Bounded env2557 := by
  intro p hp
  have h : env2557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2556_2557 : H12AffineEnvironment.transform 4 0 env2556 = env2557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2556 == env2557) = true)

def env2558 : List Nat := [2,4,8,9,1,9,8,15,0,14,1,8,8,8,11,2,8,11,14,11,8,11,9,2,8,9,11,9,9,1,5,10,15,0,8,0]

theorem envBound2558 : H12AffineFastState.Bounded env2558 := by
  intro p hp
  have h : env2558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2556_2558 : H12AffineEnvironment.transform 4 1 env2556 = env2558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2556 == env2558) = true)

theorem identity2558 : scanCanonicalize (H12AffineFastState.compose env2558 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2558 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2559 : List Nat := [2,4,2,3,1,3,2,5,0,4,1,2,2,2,1,2,2,1,4,1,2,1,3,2,2,3,1,3,3,1,5,0,5,0,2,0]

theorem envBound2559 : H12AffineFastState.Bounded env2559 := by
  intro p hp
  have h : env2559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2558_2559 : H12AffineEnvironment.transform 2 2 env2558 = env2559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2558 == env2559) = true)

def leafEnv2559 : List Nat := [2,4,2,3,1,3,2,5,0,4,1,2,2,2,1,2,2,1,4,1,2,1,3,2,5,2,1,3,1,3,3,1,5,0,5,0,4,2,2,0,0,2,1]

def active2559 : List Nat := [0,1]

def tree2559 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2559 : H12WitnessSearch.Good tree2559 := H12GlobalWitnessIndex.good

theorem leafIdentity2559 : H12AffineFastState.composeSystem env2559 rootObs = leafEnv2559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2559 rootObs == leafEnv2559) = true)

theorem terminalChecked2559 : H12PackedTerminal.terminalCheckFast leafEnv2559 active2559 tree2559 = true := by decide +kernel

def env2560 : List Nat := [2,4,8,16,32,16,128,256,136,47,2048,319,8,319,260,269,319,2341,47,260,319,396,16,269,128,16,2477,318,318,2319,299,43,256,0,319,136]

theorem envBound2560 : H12AffineFastState.Bounded env2560 := by
  intro p hp
  have h : env2560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2549_2560 : H12AffineEnvironment.transform 17 2341 env2549 = env2560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env2549 == env2560) = true)

theorem identity2560 : scanCanonicalize (H12AffineFastState.compose env2560 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 63) := by decide +kernel

theorem selectedBound2560 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2561 : List Nat := [2,4,8,16,32,16,128,63,136,47,2048,0,8,0,59,50,0,2074,47,59,0,179,16,50,128,16,2194,1,1,2096,20,43,63,0,0,136]

theorem envBound2561 : H12AffineFastState.Bounded env2561 := by
  intro p hp
  have h : env2561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2560_2561 : H12AffineEnvironment.transform 7 63 env2560 = env2561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 63 env2560 == env2561) = true)

theorem identity2561 : scanCanonicalize (H12AffineFastState.compose env2561 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2561 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env2562 : List Nat := [2,4,8,16,10,16,128,21,136,5,2048,0,8,0,17,24,0,2074,5,17,0,153,16,24,128,16,2194,1,1,2074,20,1,21,0,0,136]

theorem envBound2562 : H12AffineFastState.Bounded env2562 := by
  intro p hp
  have h : env2562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2561_2562 : H12AffineEnvironment.transform 4 10 env2561 = env2562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2561 == env2562) = true)

def env2563 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,103445,4259841,37892,4461589,37124,4096,4262286,4117,4294967296,256,4294980914,4096,4268681]

theorem envBound2563 : H12AffineFastState.Bounded env2563 := by
  intro p hp
  have h : env2563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2524_2563 : H12AffineEnvironment.transform 5 17 env2524 = env2563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2524 == env2563) = true)

theorem identity2563 : scanCanonicalize (H12AffineFastState.compose env2563 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2563 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env2564 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1024,32768,4096,4194304,5377,103445,4259841,37892,4242493,37124,4096,4262286,4117,4294967296,256,4294980914,4096,4268681]

theorem envBound2564 : H12AffineFastState.Bounded env2564 := by
  intro p hp
  have h : env2564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2563_2564 : H12AffineEnvironment.transform 17 43048 env2563 = env2564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2563 == env2564) = true)

theorem identity2564 : scanCanonicalize (H12AffineFastState.compose env2564 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 46102) := by decide +kernel

theorem selectedBound2564 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env2565 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1024,32768,4096,46102,5377,103445,111639,37892,2091,37124,4096,114072,4117,4294967296,256,4294980914,4096,104095]

theorem envBound2565 : H12AffineFastState.Bounded env2565 := by
  intro p hp
  have h : env2565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2564_2565 : H12AffineEnvironment.transform 21 46102 env2564 = env2565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 46102 env2564 == env2565) = true)

theorem identity2565 : scanCanonicalize (H12AffineFastState.compose env2565 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 5531) := by decide +kernel

theorem selectedBound2565 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env2566 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,5531,4096,43048,1024,32768,4096,46102,5377,33166,41356,37892,2091,37124,4096,43011,4117,4294967296,256,4294980914,4096,33540]

theorem envBound2566 : H12AffineFastState.Bounded env2566 := by
  intro p hp
  have h : env2566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2565_2566 : H12AffineEnvironment.transform 15 5531 env2565 = env2566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5531 env2565 == env2566) = true)

theorem identity2566 : scanCanonicalize (H12AffineFastState.compose env2566 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 3767) := by decide +kernel

theorem selectedBound2566 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env2567 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,3767,8192,3766,32768,2860,3767,43048,1024,32768,3767,43681,2998,33166,41356,35507,2091,36787,3767,43011,3746,4294967296,256,4294978437,3767,33540]

theorem envBound2567 : H12AffineFastState.Bounded env2567 := by
  intro p hp
  have h : env2567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2566_2567 : H12AffineEnvironment.transform 11 3767 env2566 = env2567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3767 env2566 == env2567) = true)

theorem identity2567 : scanCanonicalize (H12AffineFastState.compose env2567 (packedSelected [0,1,3,4,5,7,9,10,11,12,16,17,18] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2567 : packedSelected [0,1,3,4,5,7,9,10,11,12,16,17,18] rootPS < 2^1333 := by decide +kernel

def env2568 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,3767,8,3766,32768,2860,3767,34848,1024,32768,3767,35497,2998,33166,33156,35507,2091,36787,3767,34827,3746,4294967296,256,4294970253,3767,33540]

theorem envBound2568 : H12AffineFastState.Bounded env2568 := by
  intro p hp
  have h : env2568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2567_2568 : H12AffineEnvironment.transform 12 8 env2567 = env2568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2567 == env2568) = true)

theorem identity2568 : scanCanonicalize (H12AffineFastState.compose env2568 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(14+1) ^^^ 131) := by decide +kernel

theorem selectedBound2568 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2569 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,3767,8,3766,131,2860,3767,2211,1024,131,3767,2602,2998,269,263,2608,2091,3888,3767,2184,3746,4294967296,256,4294970253,3767,903]

theorem envBound2569 : H12AffineFastState.Bounded env2569 := by
  intro p hp
  have h : env2569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2568_2569 : H12AffineEnvironment.transform 14 131 env2568 = env2569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 131 env2568 == env2569) = true)

theorem identity2569 : scanCanonicalize (H12AffineFastState.compose env2569 (packedSelected [1,2,3,5,7,9,10,11,12,13,15] rootPS)) = affineNative (2^(10+1) ^^^ 1039) := by decide +kernel

theorem selectedBound2569 : packedSelected [1,2,3,5,7,9,10,11,12,13,15] rootPS < 2^1333 := by decide +kernel

def env2570 : List Nat := [2,4,8,16,32,17,128,256,512,1024,1039,696,8,697,131,1827,696,1196,1024,131,696,1573,1977,269,263,1599,1060,831,696,1159,685,4294967296,256,4294969218,696,903]

theorem envBound2570 : H12AffineFastState.Bounded env2570 := by
  intro p hp
  have h : env2570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2569_2570 : H12AffineEnvironment.transform 10 1039 env2569 = env2570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1039 env2569 == env2570) = true)

theorem identity2570 : scanCanonicalize (H12AffineFastState.compose env2570 (packedSelected [0,4,5,6,7,12,22] rootPS)) = affineNative (2^(9+1) ^^^ 937) := by decide +kernel

theorem selectedBound2570 : packedSelected [0,4,5,6,7,12,22] rootPS < 2^1333 := by decide +kernel

def env2571 : List Nat := [2,4,8,16,32,17,128,256,512,937,934,696,8,697,131,138,696,773,937,131,696,396,16,269,263,406,909,831,696,814,685,4294967296,256,4294967339,696,903]

theorem envBound2571 : H12AffineFastState.Bounded env2571 := by
  intro p hp
  have h : env2571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2570_2571 : H12AffineEnvironment.transform 9 937 env2570 = env2571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 937 env2570 == env2571) = true)

theorem identity2571 : scanCanonicalize (H12AffineFastState.compose env2571 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 1) := by decide +kernel

theorem selectedBound2571 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2572 : List Nat := [2,4,8,16,32,17,128,256,1,424,423,185,8,184,131,138,185,260,424,131,185,396,16,269,263,406,396,318,185,303,172,4294967296,256,4294967339,185,390]

theorem envBound2572 : H12AffineFastState.Bounded env2572 := by
  intro p hp
  have h : env2572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2571_2572 : H12AffineEnvironment.transform 8 1 env2571 = env2572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env2571 == env2572) = true)

theorem identity2572 : scanCanonicalize (H12AffineFastState.compose env2572 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound2572 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2573 : List Nat := [2,4,8,16,32,17,128,135,1,47,32,185,8,184,131,138,185,131,47,131,185,11,16,138,128,17,11,185,185,168,172,4294967296,135,4294967339,185,1]

theorem envBound2573 : H12AffineFastState.Bounded env2573 := by
  intro p hp
  have h : env2573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2572_2573 : H12AffineEnvironment.transform 7 135 env2572 = env2573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env2572 == env2573) = true)

theorem identity2573 : scanCanonicalize (H12AffineFastState.compose env2573 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound2573 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2574 : List Nat := [2,4,8,16,32,17,8,15,1,47,32,49,8,48,11,2,49,11,47,11,49,11,16,2,8,17,11,49,49,32,36,4294967296,15,4294967339,49,1]

theorem envBound2574 : H12AffineFastState.Bounded env2574 := by
  intro p hp
  have h : env2574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2573_2574 : H12AffineEnvironment.transform 6 8 env2573 = env2574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env2573 == env2574) = true)

theorem identity2574 : scanCanonicalize (H12AffineFastState.compose env2574 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 51) := by decide +kernel

theorem selectedBound2574 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2575 : List Nat := [2,4,8,16,32,17,8,15,1,47,32,49,8,48,11,2,49,11,47,11,49,11,16,2,8,17,11,49,49,32,36,51,15,24,49,1]

theorem envBound2575 : H12AffineFastState.Bounded env2575 := by
  intro p hp
  have h : env2575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2574_2575 : H12AffineEnvironment.transform 31 51 env2574 = env2575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 51 env2574 == env2575) = true)

theorem identity2575 : scanCanonicalize (H12AffineFastState.compose env2575 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound2575 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2576 : List Nat := [2,4,8,8,32,9,8,15,1,47,32,41,8,40,11,2,41,11,47,11,41,11,8,2,8,9,11,41,41,32,36,43,15,0,41,1]

theorem envBound2576 : H12AffineFastState.Bounded env2576 := by
  intro p hp
  have h : env2576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2575_2576 : H12AffineEnvironment.transform 3 8 env2575 = env2576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env2575 == env2576) = true)

def env2577 : List Nat := [2,4,8,8,0,9,8,15,1,15,0,9,8,8,11,2,9,11,15,11,9,11,8,2,8,9,11,9,9,0,4,11,15,0,9,1]

theorem envBound2577 : H12AffineFastState.Bounded env2577 := by
  intro p hp
  have h : env2577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2576_2577 : H12AffineEnvironment.transform 4 0 env2576 = env2577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2576 == env2577) = true)

def leafEnv2577 : List Nat := [2,4,8,8,0,9,8,15,1,15,0,9,8,8,11,2,9,11,15,11,9,11,8,2,4,8,1,9,11,9,9,0,4,11,15,0,4,2,9,1,0,8,1]

def active2577 : List Nat := [0,1,2]

def tree2577 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2577 : H12WitnessSearch.Good tree2577 := H12GlobalWitnessIndex.good

theorem leafIdentity2577 : H12AffineFastState.composeSystem env2577 rootObs = leafEnv2577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2577 rootObs == leafEnv2577) = true)

theorem terminalChecked2577 : H12PackedTerminal.terminalCheckFast leafEnv2577 active2577 tree2577 = true := by decide +kernel

def env2578 : List Nat := [2,4,8,8,1,9,8,15,1,14,1,8,8,9,11,2,8,11,14,11,8,11,8,2,8,9,11,8,8,1,5,10,15,0,8,1]

theorem envBound2578 : H12AffineFastState.Bounded env2578 := by
  intro p hp
  have h : env2578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2576_2578 : H12AffineEnvironment.transform 4 1 env2576 = env2578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2576 == env2578) = true)

theorem identity2578 : scanCanonicalize (H12AffineFastState.compose env2578 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2578 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2579 : List Nat := [2,4,3,3,1,2,3,4,1,5,1,3,3,2,0,2,3,0,5,0,3,0,3,2,3,2,0,3,3,1,5,1,4,0,3,1]

theorem envBound2579 : H12AffineFastState.Bounded env2579 := by
  intro p hp
  have h : env2579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2578_2579 : H12AffineEnvironment.transform 2 3 env2578 = env2579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2578 == env2579) = true)

def leafEnv2579 : List Nat := [2,4,3,3,1,2,3,4,1,5,1,3,3,2,0,2,3,0,5,0,3,0,3,2,5,3,1,2,0,3,3,1,5,1,4,0,4,2,3,1,0,2,1]

def active2579 : List Nat := [0,1]

def tree2579 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2579 : H12WitnessSearch.Good tree2579 := H12GlobalWitnessIndex.good

theorem leafIdentity2579 : H12AffineFastState.composeSystem env2579 rootObs = leafEnv2579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2579 rootObs == leafEnv2579) = true)

theorem terminalChecked2579 : H12PackedTerminal.terminalCheckFast leafEnv2579 active2579 tree2579 = true := by decide +kernel

def env2580 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5456,103493,4259841,67108864,4461637,67110225,4176,71409034,4165,4294967296,256,4362117478,4097,4268681]

theorem envBound2580 : H12AffineFastState.Bounded env2580 := by
  intro p hp
  have h : env2580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2522_2580 : H12AffineEnvironment.transform 16 4097 env2522 = env2580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env2522 == env2580) = true)

theorem identity2580 : scanCanonicalize (H12AffineFastState.compose env2580 (packedSelected [3,5,24] rootPS)) = affineNative (2^(25+1) ^^^ 4306437) := by decide +kernel

theorem selectedBound2580 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env2581 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5456,103493,4259841,4306437,4461637,4305748,4176,11151,4165,4294967296,256,4299233123,4097,4268681]

theorem envBound2581 : H12AffineFastState.Bounded env2581 := by
  intro p hp
  have h : env2581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2580_2581 : H12AffineEnvironment.transform 25 4306437 env2580 = env2581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 4306437 env2580 == env2581) = true)

def env2582 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,1024,32768,4096,4194304,5376,103445,4259841,4306437,4461589,4305668,4096,11151,4117,4294967296,256,4299233075,4097,4268681]

theorem envBound2582 : H12AffineFastState.Bounded env2582 := by
  intro p hp
  have h : env2582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2581_2582 : H12AffineEnvironment.transform 5 16 env2581 = env2582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2581 == env2582) = true)

theorem identity2582 : scanCanonicalize (H12AffineFastState.compose env2582 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2582 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env2583 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,43048,1024,32768,4096,4194304,5376,103445,4259841,4306437,4242493,4305668,4096,11151,4117,4294967296,256,4299233075,4097,4268681]

theorem envBound2583 : H12AffineFastState.Bounded env2583 := by
  intro p hp
  have h : env2583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2582_2583 : H12AffineEnvironment.transform 17 43048 env2582 = env2583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2582 == env2583) = true)

theorem identity2583 : scanCanonicalize (H12AffineFastState.compose env2583 (packedSelected [0,4,5,7,9,10,16,20,26] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2583 : packedSelected [0,4,5,7,9,10,16,20,26] rootPS < 2^1333 := by decide +kernel

def env2584 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,32768,65536,4097,43048,1024,32768,4096,4194304,5376,103445,4259841,4306060,4242493,4305293,4096,10502,4117,4294967296,256,4299232698,4097,4268032]

theorem envBound2584 : H12AffineFastState.Bounded env2584 := by
  intro p hp
  have h : env2584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2583_2584 : H12AffineEnvironment.transform 8 137 env2583 = env2584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2583 == env2584) = true)

theorem identity2584 : scanCanonicalize (H12AffineFastState.compose env2584 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 46102) := by decide +kernel

theorem selectedBound2584 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env2585 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,32768,65536,4097,43048,1024,32768,4096,46102,5376,103445,111639,65690,2091,66971,4096,10502,4117,4294967296,256,4295074220,4097,103446]

theorem envBound2585 : H12AffineFastState.Bounded env2585 := by
  intro p hp
  have h : env2585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2584_2585 : H12AffineEnvironment.transform 21 46102 env2584 = env2585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 46102 env2584 == env2585) = true)

theorem identity2585 : scanCanonicalize (H12AffineFastState.compose env2585 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound2585 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env2586 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,261,65536,4097,10541,1024,261,4096,13587,5376,70928,79122,65690,2091,66971,4096,10502,4117,4294967296,256,4295041193,4097,70931]

theorem envBound2586 : H12AffineFastState.Bounded env2586 := by
  intro p hp
  have h : env2586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2585_2586 : H12AffineEnvironment.transform 14 261 env2585 = env2586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env2585 == env2586) = true)

theorem identity2586 : scanCanonicalize (H12AffineFastState.compose env2586 (packedSelected [1,2,3,6,7,8,9,11] rootPS)) = affineNative (2^(15+1) ^^^ 7348) := by decide +kernel

theorem selectedBound2586 : packedSelected [1,2,3,6,7,8,9,11] rootPS < 2^1333 := by decide +kernel

def env2587 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,261,7348,4097,10541,1024,261,4096,13587,5376,2468,10662,7214,2091,6447,4096,10502,4117,4294967296,256,4294982685,4097,2471]

theorem envBound2587 : H12AffineFastState.Bounded env2587 := by
  intro p hp
  have h : env2587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2586_2587 : H12AffineEnvironment.transform 15 7348 env2586 = env2587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 7348 env2586 == env2587) = true)

theorem identity2587 : scanCanonicalize (H12AffineFastState.compose env2587 (packedSelected [0,4,7,8,9,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2587 : packedSelected [0,4,7,8,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env2588 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4096,261,7348,4097,2341,1024,261,4096,5403,5376,2468,2478,7214,2091,6447,4096,2318,4117,4294967296,256,4294974485,4097,2471]

theorem envBound2588 : H12AffineFastState.Bounded env2588 := by
  intro p hp
  have h : env2588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2587_2588 : H12AffineEnvironment.transform 12 8 env2587 = env2588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2587 == env2588) = true)

theorem identity2588 : scanCanonicalize (H12AffineFastState.compose env2588 (packedSelected [1,2,3,4,6,7] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2588 : packedSelected [1,2,3,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2589 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1076,8,1076,261,2176,1077,2341,1024,261,1076,303,308,2468,2478,2074,2091,3355,1076,2318,1057,4294967296,256,4294969377,1077,2471]

theorem envBound2589 : H12AffineFastState.Bounded env2589 := by
  intro p hp
  have h : env2589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2588_2589 : H12AffineEnvironment.transform 11 1076 env2588 = env2589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2588 == env2589) = true)

theorem identity2589 : scanCanonicalize (H12AffineFastState.compose env2589 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 396) := by decide +kernel

theorem selectedBound2589 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env2590 : List Nat := [2,4,8,16,32,16,128,256,137,1024,396,1076,8,1076,261,268,1077,169,1024,261,1076,303,308,40,34,406,423,1175,1076,130,1057,4294967296,256,4294967725,1077,43]

theorem envBound2590 : H12AffineFastState.Bounded env2590 := by
  intro p hp
  have h : env2590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2589_2590 : H12AffineEnvironment.transform 10 396 env2589 = env2590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 396 env2589 == env2590) = true)

theorem identity2590 : scanCanonicalize (H12AffineFastState.compose env2590 (packedSelected [0,2,9,12] rootPS)) = affineNative (2^(9+1) ^^^ 288) := by decide +kernel

theorem selectedBound2590 : packedSelected [0,2,9,12] rootPS < 2^1333 := by decide +kernel

def env2591 : List Nat := [2,4,8,16,32,16,128,256,137,288,396,276,8,276,261,268,277,169,288,261,276,303,308,40,34,406,423,439,276,130,257,4294967296,256,4294967725,277,43]

theorem envBound2591 : H12AffineFastState.Bounded env2591 := by
  intro p hp
  have h : env2591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2590_2591 : H12AffineEnvironment.transform 9 288 env2590 = env2591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 288 env2590 == env2591) = true)

theorem identity2591 : scanCanonicalize (H12AffineFastState.compose env2591 (packedSelected [4,9,16] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound2591 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2592 : List Nat := [2,4,8,16,32,16,128,36,137,4,168,48,8,48,33,40,49,169,4,33,48,11,16,40,34,178,131,147,48,130,37,4294967296,36,4294967433,49,43]

theorem envBound2592 : H12AffineFastState.Bounded env2592 := by
  intro p hp
  have h : env2592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2591_2592 : H12AffineEnvironment.transform 7 36 env2591 = env2592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2591 == env2592) = true)

theorem identity2592 : scanCanonicalize (H12AffineFastState.compose env2592 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound2592 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2593 : List Nat := [2,4,8,16,32,16,128,36,137,4,168,48,8,48,33,40,49,169,4,33,48,11,16,40,34,178,131,147,48,130,37,11,36,130,49,43]

theorem envBound2593 : H12AffineFastState.Bounded env2593 := by
  intro p hp
  have h : env2593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2592_2593 : H12AffineEnvironment.transform 31 11 env2592 = env2593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env2592 == env2593) = true)

theorem identity2593 : scanCanonicalize (H12AffineFastState.compose env2593 (packedSelected [2,3,6] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound2593 : packedSelected [2,3,6] rootPS < 2^1333 := by decide +kernel

def env2594 : List Nat := [2,4,8,16,32,16,2,36,11,4,42,48,8,48,33,40,49,43,4,33,48,11,16,40,34,48,1,17,48,0,37,11,36,0,49,43]

theorem envBound2594 : H12AffineFastState.Bounded env2594 := by
  intro p hp
  have h : env2594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2593_2594 : H12AffineEnvironment.transform 6 2 env2593 = env2594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env2593 == env2594) = true)

def env2595 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,1024,32768,4096,4194304,5377,103444,4259841,4306437,4461588,4305669,4097,11151,4116,4294967296,256,4299233074,4097,4268681]

theorem envBound2595 : H12AffineFastState.Bounded env2595 := by
  intro p hp
  have h : env2595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2581_2595 : H12AffineEnvironment.transform 5 17 env2581 = env2595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2581 == env2595) = true)

theorem identity2595 : scanCanonicalize (H12AffineFastState.compose env2595 (packedSelected [0,4,5,7,9,10,16,20,26] rootPS)) = affineNative (2^(21+1) ^^^ 111772) := by decide +kernel

theorem selectedBound2595 : packedSelected [0,4,5,7,9,10,16,20,26] rootPS < 2^1333 := by decide +kernel

def env2596 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,1024,32768,4096,111772,5377,103444,46237,665,368776,1945,4097,11151,4116,4294967296,256,4295009198,4097,38421]

theorem envBound2596 : H12AffineFastState.Bounded env2596 := by
  intro p hp
  have h : env2596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2595_2596 : H12AffineEnvironment.transform 21 111772 env2595 = env2596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 111772 env2595 == env2596) = true)

def env2597 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,8192,1297,32768,65536,1297,262144,1024,32768,1296,106892,17,98564,41357,665,368776,1945,1297,11151,1284,4294967296,256,4295009198,1297,33541]

theorem envBound2597 : H12AffineFastState.Bounded env2597 := by
  intro p hp
  have h : env2597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2596_2597 : H12AffineEnvironment.transform 11 1296 env2596 = env2597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2596 == env2597) = true)

theorem identity2597 : scanCanonicalize (H12AffineFastState.compose env2597 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound2597 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2598 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,8192,1297,261,65536,1297,262144,1024,261,1296,73865,17,65537,8328,665,336269,1945,1297,11151,1284,4294967296,256,4294976171,1297,512]

theorem envBound2598 : H12AffineFastState.Bounded env2598 := by
  intro p hp
  have h : env2598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2597_2598 : H12AffineEnvironment.transform 14 261 env2597 = env2598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env2597 == env2598) = true)

theorem identity2598 : scanCanonicalize (H12AffineFastState.compose env2598 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 8453) := by decide +kernel

theorem selectedBound2598 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2599 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,8192,1297,261,8453,1297,262144,1024,261,1296,396,17,8452,8328,665,262280,1945,1297,11151,1284,4294967296,256,4294976171,1297,512]

theorem envBound2599 : H12AffineFastState.Bounded env2599 := by
  intro p hp
  have h : env2599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2598_2599 : H12AffineEnvironment.transform 15 8453 env2598 = env2599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8453 env2598 == env2599) = true)

theorem identity2599 : scanCanonicalize (H12AffineFastState.compose env2599 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(12+1) ^^^ 9) := by decide +kernel

theorem selectedBound2599 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2600 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,9,1297,261,268,1297,262144,1024,261,1296,396,17,269,129,665,262280,1945,1297,2950,1284,4294967296,256,4294967970,1297,512]

theorem envBound2600 : H12AffineFastState.Bounded env2600 := by
  intro p hp
  have h : env2600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2599_2600 : H12AffineEnvironment.transform 12 9 env2599 = env2600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 9 env2599 == env2600) = true)

theorem identity2600 : scanCanonicalize (H12AffineFastState.compose env2600 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2600 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env2601 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,261,268,1297,262144,1024,261,1296,396,17,269,129,16,262280,1296,1297,2319,1284,4294967296,256,4294967339,1297,137]

theorem envBound2601 : H12AffineFastState.Bounded env2601 := by
  intro p hp
  have h : env2601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2600_2601 : H12AffineEnvironment.transform 8 137 env2600 = env2601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2600 == env2601) = true)

theorem identity2601 : scanCanonicalize (H12AffineFastState.compose env2601 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound2601 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2602 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1297,261,268,1297,262144,1024,261,1296,396,17,269,129,16,262280,1296,1297,2319,1284,42,256,1,1297,137]

theorem envBound2602 : H12AffineFastState.Bounded env2602 := by
  intro p hp
  have h : env2602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2601_2602 : H12AffineEnvironment.transform 31 42 env2601 = env2602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env2601 == env2602) = true)

theorem identity2602 : scanCanonicalize (H12AffineFastState.compose env2602 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound2602 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env2603 : List Nat := [2,4,8,16,32,17,128,256,137,47,2048,319,9,318,261,268,318,262144,47,261,319,396,17,269,129,16,262280,319,318,2319,299,42,256,1,318,137]

theorem envBound2603 : H12AffineFastState.Bounded env2603 := by
  intro p hp
  have h : env2603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2602_2603 : H12AffineEnvironment.transform 9 47 env2602 = env2603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env2602 == env2603) = true)

def env2604 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1296,32768,65536,1296,262144,1024,32768,1297,106893,16,98565,41356,665,368776,1945,1296,11151,1285,4294967296,256,4295009198,1296,33540]

theorem envBound2604 : H12AffineFastState.Bounded env2604 := by
  intro p hp
  have h : env2604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2596_2604 : H12AffineEnvironment.transform 11 1297 env2596 = env2604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env2596 == env2604) = true)

theorem identity2604 : scanCanonicalize (H12AffineFastState.compose env2604 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 908) := by decide +kernel

theorem selectedBound2604 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2605 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1296,908,65536,1296,262144,1024,908,1297,74241,16,66185,8704,665,336644,1945,1296,11151,1285,4294967296,256,4294975522,1296,136]

theorem envBound2605 : H12AffineFastState.Bounded env2605 := by
  intro p hp
  have h : env2605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2604_2605 : H12AffineEnvironment.transform 14 908 env2604 = env2605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 908 env2604 == env2605) = true)

theorem identity2605 : scanCanonicalize (H12AffineFastState.compose env2605 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 2211) := by decide +kernel

theorem selectedBound2605 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2606 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1296,908,65536,1296,2211,1024,908,1297,74241,16,66185,8704,665,76711,1945,1296,11151,1285,4294967296,256,4294975522,1296,136]

theorem envBound2606 : H12AffineFastState.Bounded env2606 := by
  intro p hp
  have h : env2606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2605_2606 : H12AffineEnvironment.transform 17 2211 env2605 = env2606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2211 env2605 == env2606) = true)

def env2607 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230468,33554432,67108864,4588613,67110224,131153,71409034,131140,4294967296,256,4400066919,131072,33563272]

theorem envBound2607 : H12AffineFastState.Bounded env2607 := by
  intro p hp
  have h : env2607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2422_2607 : H12AffineEnvironment.transform 13 4177 env2422 = env2607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2422 == env2607) = true)

theorem identity2607 : scanCanonicalize (H12AffineFastState.compose env2607 (packedSelected [1,3,6,10,19,24,25,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound2607 : packedSelected [1,3,6,10,19,24,25,26,28,31] rootPS < 2^1333 := by decide +kernel

def env2608 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230468,8329,67108864,4588613,67110224,131153,71409034,131140,4294967296,256,4366504430,131072,513]

theorem envBound2608 : H12AffineFastState.Bounded env2608 := by
  intro p hp
  have h : env2608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2607_2608 : H12AffineEnvironment.transform 24 8329 env2607 = env2608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env2607 == env2608) = true)

theorem identity2608 : scanCanonicalize (H12AffineFastState.compose env2608 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 5377) := by decide +kernel

theorem selectedBound2608 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2609 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230468,8329,5377,4588613,4177,131153,4294795,131140,4294967296,256,4299392239,131072,513]

theorem envBound2609 : H12AffineFastState.Bounded env2609 := by
  intro p hp
  have h : env2609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2608_2609 : H12AffineEnvironment.transform 25 5377 env2608 = env2609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2608 == env2609) = true)

theorem identity2609 : scanCanonicalize (H12AffineFastState.compose env2609 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 4329689) := by decide +kernel

theorem selectedBound2609 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env2610 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230468,8329,5377,4588613,4177,131153,4294795,131140,4329689,256,103478,131072,513]

theorem envBound2610 : H12AffineFastState.Bounded env2610 := by
  intro p hp
  have h : env2610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2609_2610 : H12AffineEnvironment.transform 31 4329689 env2609 = env2610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4329689 env2609 == env2610) = true)

def env2611 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,230468,33554432,67108864,4609044,67130625,131153,1073741824,131140,4294967296,256,4400079159,131072,33563272]

theorem envBound2611 : H12AffineFastState.Bounded env2611 := by
  intro p hp
  have h : env2611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2420_2611 : H12AffineEnvironment.transform 18 1025 env2420 = env2611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env2420 == env2611) = true)

theorem identity2611 : scanCanonicalize (H12AffineFastState.compose env2611 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 71421402) := by decide +kernel

theorem selectedBound2611 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env2612 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,230468,33554432,67108864,4609044,67130625,131153,71421402,131140,4294967296,256,4400079159,131072,33563272]

theorem envBound2612 : H12AffineFastState.Bounded env2612 := by
  intro p hp
  have h : env2612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2611_2612 : H12AffineEnvironment.transform 29 71421402 env2611 = env2612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 71421402 env2611 == env2612) = true)

def env2613 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,4194304,5456,230468,33554432,67108864,4588612,67110225,131153,71409034,131140,4294967296,256,4400066919,131072,33563272]

theorem envBound2613 : H12AffineFastState.Bounded env2613 := by
  intro p hp
  have h : env2613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2612_2613 : H12AffineEnvironment.transform 13 4176 env2612 = env2613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env2612 == env2613) = true)

theorem identity2613 : scanCanonicalize (H12AffineFastState.compose env2613 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(25+1) ^^^ 33568136) := by decide +kernel

theorem selectedBound2613 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env2614 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,4194304,5456,230468,33554432,33568136,4588612,33566937,131153,37857282,131140,4294967296,256,4299392239,131072,33563272]

theorem envBound2614 : H12AffineFastState.Bounded env2614 := by
  intro p hp
  have h : env2614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2613_2614 : H12AffineEnvironment.transform 25 33568136 env2613 = env2614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 33568136 env2613 == env2614) = true)

theorem identity2614 : scanCanonicalize (H12AffineFastState.compose env2614 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound2614 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env2615 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,4194304,5456,230468,8328,5376,4588612,4177,131153,4294794,131140,4294967296,256,4299392239,131072,512]

theorem envBound2615 : H12AffineFastState.Bounded env2615 := by
  intro p hp
  have h : env2615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2614_2615 : H12AffineEnvironment.transform 24 8328 env2614 = env2615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env2614 == env2615) = true)

theorem identity2615 : scanCanonicalize (H12AffineFastState.compose env2615 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound2615 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2616 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,397,5456,230468,8328,5376,394697,4177,131153,100615,131140,4294967296,256,4295198050,131072,512]

theorem envBound2616 : H12AffineFastState.Bounded env2616 := by
  intro p hp
  have h : env2616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2615_2616 : H12AffineEnvironment.transform 21 397 env2615 = env2616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env2615 == env2616) = true)

theorem identity2616 : scanCanonicalize (H12AffineFastState.compose env2616 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound2616 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2617 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,1025,32768,4096,397,5456,98565,8328,5376,262280,4177,1296,100615,1285,4294967296,256,4295065635,1345,512]

theorem envBound2617 : H12AffineFastState.Bounded env2617 := by
  intro p hp
  have h : env2617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2616_2617 : H12AffineEnvironment.transform 16 1345 env2616 = env2617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2616 == env2617) = true)

theorem identity2617 : scanCanonicalize (H12AffineFastState.compose env2617 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 70710) := by decide +kernel

theorem selectedBound2617 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2618 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,1025,32768,4096,397,5456,98565,8328,5376,262280,4177,1296,100615,1285,70710,256,37909,1345,512]

theorem envBound2618 : H12AffineFastState.Bounded env2618 := by
  intro p hp
  have h : env2618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2617_2618 : H12AffineEnvironment.transform 31 70710 env2617 = env2618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 70710 env2617 == env2618) = true)

theorem identity2618 : scanCanonicalize (H12AffineFastState.compose env2618 (packedSelected [3,5,10] rootPS)) = affineNative (2^(14+1) ^^^ 2009) := by decide +kernel

theorem selectedBound2618 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2619 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,2009,65536,1345,262144,1025,2009,4096,397,5456,67292,8328,5376,262280,4177,1296,69342,1285,70710,256,5068,1345,512]

theorem envBound2619 : H12AffineFastState.Bounded env2619 := by
  intro p hp
  have h : env2619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2618_2619 : H12AffineEnvironment.transform 14 2009 env2618 = env2619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2009 env2618 == env2619) = true)

theorem identity2619 : scanCanonicalize (H12AffineFastState.compose env2619 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 76199) := by decide +kernel

theorem selectedBound2619 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env2620 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,2009,65536,1345,76199,1025,2009,4096,397,5456,67292,8328,5376,76079,4177,1296,69342,1285,70710,256,5068,1345,512]

theorem envBound2620 : H12AffineFastState.Bounded env2620 := by
  intro p hp
  have h : env2620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2619_2620 : H12AffineEnvironment.transform 17 76199 env2619 = env2620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 76199 env2619 == env2620) = true)

theorem identity2620 : scanCanonicalize (H12AffineFastState.compose env2620 (packedSelected [3,8,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 14154) := by decide +kernel

theorem selectedBound2620 : packedSelected [3,8,12,13] rootPS < 2^1333 := by decide +kernel

def env2621 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,2009,14154,1345,7917,1025,2009,4096,397,5456,12694,8328,5376,7781,4177,1296,14740,1285,9084,256,5068,1345,512]

theorem envBound2621 : H12AffineFastState.Bounded env2621 := by
  intro p hp
  have h : env2621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2620_2621 : H12AffineEnvironment.transform 15 14154 env2620 = env2621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 14154 env2620 == env2621) = true)

theorem identity2621 : scanCanonicalize (H12AffineFastState.compose env2621 (packedSelected [0,7,20] rootPS)) = affineNative (2^(9+1) ^^^ 653) := by decide +kernel

theorem selectedBound2621 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env2622 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,4096,8192,4176,340,12743,972,6240,652,340,4096,397,5085,12694,8328,5005,6376,4177,925,14740,904,9084,256,5068,972,512]

theorem envBound2622 : H12AffineFastState.Bounded env2622 := by
  intro p hp
  have h : env2622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2621_2622 : H12AffineEnvironment.transform 9 653 env2621 = env2622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 653 env2621 == env2622) = true)

theorem identity2622 : scanCanonicalize (H12AffineFastState.compose env2622 (packedSelected [3,8,12,21] rootPS)) = affineNative (2^(12+1) ^^^ 88) := by decide +kernel

theorem selectedBound2622 : packedSelected [3,8,12,21] rootPS < 2^1333 := by decide +kernel

def env2623 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,4096,88,4176,340,4511,972,6240,652,340,4096,397,5085,4558,208,5005,6376,4177,925,6604,904,804,256,5068,972,512]

theorem envBound2623 : H12AffineFastState.Bounded env2623 := by
  intro p hp
  have h : env2623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2622_2623 : H12AffineEnvironment.transform 12 88 env2622 = env2623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 88 env2622 == env2623) = true)

theorem identity2623 : scanCanonicalize (H12AffineFastState.compose env2623 (packedSelected [1,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 2155) := by decide +kernel

theorem selectedBound2623 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env2624 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,2155,88,2107,340,2548,972,11,652,340,2155,397,2998,2469,208,3046,131,2106,925,423,904,804,256,2983,972,512]

theorem envBound2624 : H12AffineFastState.Bounded env2624 := by
  intro p hp
  have h : env2624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2623_2624 : H12AffineEnvironment.transform 11 2155 env2623 = env2624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2155 env2623 == env2624) = true)

theorem identity2624 : scanCanonicalize (H12AffineFastState.compose env2624 (packedSelected [18,23] rootPS)) = affineNative (2^(10+1) ^^^ 303) := by decide +kernel

theorem selectedBound2624 : packedSelected [18,23] rootPS < 2^1333 := by decide +kernel

def env2625 : List Nat := [2,4,8,16,32,64,128,256,512,653,303,324,88,276,340,219,972,11,652,340,324,397,665,138,208,713,131,277,925,423,904,804,256,648,972,512]

theorem envBound2625 : H12AffineFastState.Bounded env2625 := by
  intro p hp
  have h : env2625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2624_2625 : H12AffineEnvironment.transform 10 303 env2624 = env2625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 303 env2624 == env2625) = true)

theorem identity2625 : scanCanonicalize (H12AffineFastState.compose env2625 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 90) := by decide +kernel

theorem selectedBound2625 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env2626 : List Nat := [2,4,8,16,32,64,128,256,90,215,303,324,88,276,340,219,406,11,214,340,324,397,195,138,208,147,131,277,455,423,466,382,256,210,406,90]

theorem envBound2626 : H12AffineFastState.Bounded env2626 := by
  intro p hp
  have h : env2626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2625_2626 : H12AffineEnvironment.transform 8 90 env2625 = env2626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 90 env2625 == env2626) = true)

def env2627 : List Nat := [2,4,8,16,32,64,8,256,90,95,303,324,88,276,340,83,286,11,94,340,324,261,75,2,88,27,11,277,335,303,346,382,256,90,286,90]

theorem envBound2627 : H12AffineFastState.Bounded env2627 := by
  intro p hp
  have h : env2627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2626_2627 : H12AffineEnvironment.transform 6 8 env2626 = env2627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env2626 == env2627) = true)

theorem identity2627 : scanCanonicalize (H12AffineFastState.compose env2627 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 6) := by decide +kernel

theorem selectedBound2627 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2628 : List Nat := [2,4,8,16,32,64,8,6,90,95,41,66,88,18,82,83,24,11,94,82,66,3,75,2,88,27,11,19,73,41,92,120,6,90,24,90]

theorem envBound2628 : H12AffineFastState.Bounded env2628 := by
  intro p hp
  have h : env2628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2627_2628 : H12AffineEnvironment.transform 7 6 env2627 = env2628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 6 env2627 == env2628) = true)

theorem identity2628 : scanCanonicalize (H12AffineFastState.compose env2628 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound2628 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2629 : List Nat := [2,4,8,16,3,64,8,6,90,95,10,66,88,18,82,83,24,11,94,82,66,3,75,2,88,27,11,19,73,10,92,91,6,90,24,90]

theorem envBound2629 : H12AffineFastState.Bounded env2629 := by
  intro p hp
  have h : env2629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2628_2629 : H12AffineEnvironment.transform 4 3 env2628 = env2629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env2628 == env2629) = true)

theorem identity2629 : scanCanonicalize (H12AffineFastState.compose env2629 (packedSelected [2,4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2629 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2630 : List Nat := [2,4,2,16,3,64,2,6,80,85,0,66,82,18,82,83,18,1,84,82,66,3,65,2,82,17,1,19,67,0,86,81,6,80,18,80]

theorem envBound2630 : H12AffineFastState.Bounded env2630 := by
  intro p hp
  have h : env2630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2629_2630 : H12AffineEnvironment.transform 2 2 env2629 = env2630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2629 == env2630) = true)

theorem identity2630 : scanCanonicalize (H12AffineFastState.compose env2630 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 18) := by decide +kernel

theorem selectedBound2630 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2631 : List Nat := [2,4,2,16,3,18,2,6,2,7,0,16,0,18,0,1,18,1,6,0,16,3,19,2,0,17,1,19,17,0,4,3,6,2,18,2]

theorem envBound2631 : H12AffineFastState.Bounded env2631 := by
  intro p hp
  have h : env2631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2630_2631 : H12AffineEnvironment.transform 5 18 env2630 = env2631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 18 env2630 == env2631) = true)

theorem identity2631 : scanCanonicalize (H12AffineFastState.compose env2631 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound2631 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2632 : List Nat := [0,4,0,16,1,16,0,4,0,5,0,16,0,16,0,1,16,1,4,0,16,1,17,0,0,17,1,17,17,0,4,1,4,0,16,0]

theorem envBound2632 : H12AffineFastState.Bounded env2632 := by
  intro p hp
  have h : env2632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2631_2632 : H12AffineEnvironment.transform 0 0 env2631 = env2632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env2631 == env2632) = true)

def leafEnv2632 : List Nat := [0,4,0,16,1,16,0,4,0,5,0,16,0,16,0,1,16,1,4,0,16,1,17,0,5,0,1,17,1,17,17,0,4,1,4,0,4,1,16,0,0,16,1]

def active2632 : List Nat := [1,3]

def tree2632 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2632 : H12WitnessSearch.Good tree2632 := H12GlobalWitnessIndex.good

theorem leafIdentity2632 : H12AffineFastState.composeSystem env2632 rootObs = leafEnv2632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2632 rootObs == leafEnv2632) = true)

theorem terminalChecked2632 : H12PackedTerminal.terminalCheckFast leafEnv2632 active2632 tree2632 = true := by decide +kernel

def env2633 : List Nat := [2,4,8,16,32,64,9,256,90,94,303,324,88,276,340,82,287,11,95,340,324,260,74,3,89,26,10,277,334,302,347,382,256,91,287,90]

theorem envBound2633 : H12AffineFastState.Bounded env2633 := by
  intro p hp
  have h : env2633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2626_2633 : H12AffineEnvironment.transform 6 9 env2626 = env2633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env2626 == env2633) = true)

theorem identity2633 : scanCanonicalize (H12AffineFastState.compose env2633 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 125) := by decide +kernel

theorem selectedBound2633 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2634 : List Nat := [2,4,8,16,32,64,9,125,90,94,82,57,88,105,41,82,98,11,95,41,57,121,74,3,89,26,10,104,51,83,38,3,125,91,98,90]

theorem envBound2634 : H12AffineFastState.Bounded env2634 := by
  intro p hp
  have h : env2634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2633_2634 : H12AffineEnvironment.transform 7 125 env2633 = env2634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 125 env2633 == env2634) = true)

theorem identity2634 : scanCanonicalize (H12AffineFastState.compose env2634 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 19) := by decide +kernel

theorem selectedBound2634 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2635 : List Nat := [2,4,8,16,32,19,9,46,9,13,1,57,11,58,41,1,49,11,12,41,57,42,25,3,10,26,10,59,51,0,38,3,46,8,49,9]

theorem envBound2635 : H12AffineFastState.Bounded env2635 := by
  intro p hp
  have h : env2635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2634_2635 : H12AffineEnvironment.transform 5 19 env2634 = env2635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 19 env2634 == env2635) = true)

def env2636 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4096,4194304,5457,230468,33554432,67108864,4588613,67110224,131153,71409035,131140,4294967296,256,4400066918,131072,33563272]

theorem envBound2636 : H12AffineFastState.Bounded env2636 := by
  intro p hp
  have h : env2636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2612_2636 : H12AffineEnvironment.transform 13 4177 env2612 = env2636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2612 == env2636) = true)

theorem identity2636 : scanCanonicalize (H12AffineFastState.compose env2636 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound2636 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env2637 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4096,4194304,5457,230468,33554432,5376,4588613,4176,131153,4294795,131140,4294967296,256,4332954726,131072,33563272]

theorem envBound2637 : H12AffineFastState.Bounded env2637 := by
  intro p hp
  have h : env2637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2636_2637 : H12AffineEnvironment.transform 25 5376 env2636 = env2637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2636 == env2637) = true)

def env2638 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,230468,33554432,67108864,134217728,67130625,138695748,1073741824,138695761,4294967296,138827029,4400604470,131072,33563272]

theorem envBound2638 : H12AffineFastState.Bounded env2638 := by
  intro p hp
  have h : env2638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2418_2638 : H12AffineEnvironment.transform 20 4097 env2418 = env2638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env2418 == env2638) = true)

theorem identity2638 : scanCanonicalize (H12AffineFastState.compose env2638 (packedSelected [35] rootPS)) = affineNative (2^(26+1) ^^^ 71713044) := by decide +kernel

theorem selectedBound2638 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env2639 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,230468,33554432,67108864,71713044,67130625,67245392,1073741824,67245381,4294967296,67113985,4400604470,131072,33563272]

theorem envBound2639 : H12AffineFastState.Bounded env2639 := by
  intro p hp
  have h : env2639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2638_2639 : H12AffineEnvironment.transform 26 71713044 env2638 = env2639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 71713044 env2638 == env2639) = true)

def env2640 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230468,33554432,67108864,67528988,67130625,67245392,1073741824,67245381,4294967296,67113985,4396404030,131072,33563272]

theorem envBound2640 : H12AffineFastState.Bounded env2640 := by
  intro p hp
  have h : env2640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2639_2640 : H12AffineEnvironment.transform 21 10248 env2639 = env2640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env2639 == env2640) = true)

def env2641 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230468,8328,67108864,67528988,67130625,67245392,1073741824,67245381,4294967296,67113985,4362857910,131072,512]

theorem envBound2641 : H12AffineFastState.Bounded env2641 := by
  intro p hp
  have h : env2641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2640_2641 : H12AffineEnvironment.transform 24 8328 env2640 = env2641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env2640 == env2641) = true)

theorem identity2641 : scanCanonicalize (H12AffineFastState.compose env2641 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 67233234) := by decide +kernel

theorem selectedBound2641 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env2642 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230468,8328,67108864,67528988,67130625,67245392,67233234,67245381,4294967296,67113985,4362857910,131072,512]

theorem envBound2642 : H12AffineFastState.Bounded env2642 := by
  intro p hp
  have h : env2642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2641_2642 : H12AffineEnvironment.transform 29 67233234 env2641 = env2642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67233234 env2641 == env2642) = true)

theorem identity2642 : scanCanonicalize (H12AffineFastState.compose env2642 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(16+1) ^^^ 21777) := by decide +kernel

theorem selectedBound2642 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env2643 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,10248,17664,119125,8328,67108864,67386381,67130625,67125313,67233234,67125332,4294967296,67113985,4362713255,21777,512]

theorem envBound2643 : H12AffineFastState.Bounded env2643 := by
  intro p hp
  have h : env2643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2642_2643 : H12AffineEnvironment.transform 16 21777 env2642 = env2643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21777 env2642 == env2643) = true)

theorem identity2643 : scanCanonicalize (H12AffineFastState.compose env2643 (packedSelected [0,6,7,9,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 35976) := by decide +kernel

theorem selectedBound2643 : packedSelected [0,6,7,9,20,22,25] rootPS < 2^1333 := by decide +kernel

def env2644 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35976,32768,4097,10248,17664,119125,8328,67108864,67386381,67130625,67125313,67233234,67125332,4294967296,67113985,4362155055,21777,512]

theorem envBound2644 : H12AffineFastState.Bounded env2644 := by
  intro p hp
  have h : env2644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2643_2644 : H12AffineEnvironment.transform 18 35976 env2643 = env2644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 35976 env2643 == env2644) = true)

theorem identity2644 : scanCanonicalize (H12AffineFastState.compose env2644 (packedSelected [3,5,8,10,28,31] rootPS)) = affineNative (2^(25+1) ^^^ 5377) := by decide +kernel

theorem selectedBound2644 : packedSelected [3,5,8,10,28,31] rootPS < 2^1333 := by decide +kernel

def env2645 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35976,32768,4097,10248,17664,119125,8328,5377,272652,16384,21824,127187,21845,4294967296,256,4295041326,21777,512]

theorem envBound2645 : H12AffineFastState.Bounded env2645 := by
  intro p hp
  have h : env2645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2644_2645 : H12AffineEnvironment.transform 25 5377 env2644 = env2645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2644 == env2645) = true)

theorem identity2645 : scanCanonicalize (H12AffineFastState.compose env2645 (packedSelected [4,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 29021) := by decide +kernel

theorem selectedBound2645 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2646 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,29021,65536,21777,262144,32213,29021,4097,10248,17664,73736,8328,5377,272652,16384,21824,65934,21845,4294967296,256,4295041326,21777,512]

theorem envBound2646 : H12AffineFastState.Bounded env2646 := by
  intro p hp
  have h : env2646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2645_2646 : H12AffineEnvironment.transform 14 29021 env2645 = env2646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 29021 env2645 == env2646) = true)

theorem identity2646 : scanCanonicalize (H12AffineFastState.compose env2646 (packedSelected [1,3,5,8,10,13,19,21] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound2646 : packedSelected [1,3,5,8,10,13,19,21] rootPS < 2^1333 := by decide +kernel

def env2647 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,65536,1344,262144,11652,8460,4097,10248,5457,73736,8328,5377,272652,4177,1297,65934,1284,4294967296,256,4295041326,1344,512]

theorem envBound2647 : H12AffineFastState.Bounded env2647 := by
  intro p hp
  have h : env2647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2646_2647 : H12AffineEnvironment.transform 13 4177 env2646 = env2647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2646 == env2647) = true)

theorem identity2647 : scanCanonicalize (H12AffineFastState.compose env2647 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 65910) := by decide +kernel

theorem selectedBound2647 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2648 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,65536,1344,262144,11652,8460,4097,10248,5457,73736,8328,5377,272652,4177,1297,65934,1284,65910,256,8280,1344,512]

theorem envBound2648 : H12AffineFastState.Bounded env2648 := by
  intro p hp
  have h : env2648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2647_2648 : H12AffineEnvironment.transform 31 65910 env2647 = env2648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65910 env2647 == env2648) = true)

theorem identity2648 : scanCanonicalize (H12AffineFastState.compose env2648 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound2648 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env2649 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,8322,1344,262144,11652,8460,4097,10248,5457,138,8328,5377,272652,4177,1297,8460,1284,8692,256,8280,1344,512]

theorem envBound2649 : H12AffineFastState.Bounded env2649 := by
  intro p hp
  have h : env2649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2648_2649 : H12AffineEnvironment.transform 15 8322 env2648 = env2649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env2648 == env2649) = true)

theorem identity2649 : scanCanonicalize (H12AffineFastState.compose env2649 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 15421) := by decide +kernel

theorem selectedBound2649 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2650 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,8322,1344,15421,11652,8460,4097,10248,5457,138,8328,5377,5425,4177,1297,8460,1284,8692,256,8280,1344,512]

theorem envBound2650 : H12AffineFastState.Bounded env2650 := by
  intro p hp
  have h : env2650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2649_2650 : H12AffineEnvironment.transform 17 15421 env2649 = env2650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 15421 env2649 == env2650) = true)

theorem identity2650 : scanCanonicalize (H12AffineFastState.compose env2650 (packedSelected [0,3,5,10] rootPS)) = affineNative (2^(11+1) ^^^ 2391) := by decide +kernel

theorem selectedBound2650 : packedSelected [0,3,5,10] rootPS < 2^1333 := by decide +kernel

def env2651 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,2391,8192,2310,8460,8322,1344,9578,11652,8460,2390,10248,3078,138,8328,3158,3174,2310,1297,8460,1284,8692,256,8280,1344,512]

theorem envBound2651 : H12AffineFastState.Bounded env2651 := by
  intro p hp
  have h : env2651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2650_2651 : H12AffineEnvironment.transform 11 2391 env2650 = env2651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2391 env2650 == env2651) = true)

theorem identity2651 : scanCanonicalize (H12AffineFastState.compose env2651 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(9+1) ^^^ 992) := by decide +kernel

theorem selectedBound2651 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2652 : List Nat := [2,4,8,16,32,64,128,256,512,992,2048,2391,8192,2310,8460,8322,672,8842,10852,8460,2390,10248,3046,138,8328,2998,2950,2310,753,8460,740,8692,256,8280,672,512]

theorem envBound2652 : H12AffineFastState.Bounded env2652 := by
  intro p hp
  have h : env2652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2651_2652 : H12AffineEnvironment.transform 9 992 env2651 = env2652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 992 env2651 == env2652) = true)

theorem identity2652 : scanCanonicalize (H12AffineFastState.compose env2652 (packedSelected [13,17] rootPS)) = affineNative (2^(12+1) ^^^ 2436) := by decide +kernel

theorem selectedBound2652 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env2653 : List Nat := [2,4,8,16,32,64,128,256,512,992,2048,2391,2436,2310,2184,2310,672,2830,992,2184,2390,396,3046,138,2316,2998,2950,2310,753,2184,740,2160,256,2524,672,512]

theorem envBound2653 : H12AffineFastState.Bounded env2653 := by
  intro p hp
  have h : env2653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2652_2653 : H12AffineEnvironment.transform 12 2436 env2652 = env2653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2436 env2652 == env2653) = true)

theorem identity2653 : scanCanonicalize (H12AffineFastState.compose env2653 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 186) := by decide +kernel

theorem selectedBound2653 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2654 : List Nat := [2,4,8,16,32,64,128,256,512,992,186,493,318,444,50,444,672,948,992,50,492,396,860,138,438,780,828,444,753,50,740,202,256,358,672,512]

theorem envBound2654 : H12AffineFastState.Bounded env2654 := by
  intro p hp
  have h : env2654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2653_2654 : H12AffineEnvironment.transform 10 186 env2653 = env2654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 186 env2653 == env2654) = true)

theorem identity2654 : scanCanonicalize (H12AffineFastState.compose env2654 (packedSelected [1,5,12] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound2654 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env2655 : List Nat := [2,4,8,16,32,64,128,256,42,458,186,493,318,444,50,444,138,414,458,50,492,396,374,138,438,294,278,444,219,50,206,202,256,358,138,42]

theorem envBound2655 : H12AffineFastState.Bounded env2655 := by
  intro p hp
  have h : env2655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2654_2655 : H12AffineEnvironment.transform 8 42 env2654 = env2655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env2654 == env2655) = true)

theorem identity2655 : scanCanonicalize (H12AffineFastState.compose env2655 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 54) := by decide +kernel

theorem selectedBound2655 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2656 : List Nat := [2,4,8,16,32,64,128,54,42,252,186,219,8,138,50,138,138,168,252,50,218,186,64,138,128,16,32,138,219,50,206,202,54,80,138,42]

theorem envBound2656 : H12AffineFastState.Bounded env2656 := by
  intro p hp
  have h : env2656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2655_2656 : H12AffineEnvironment.transform 7 54 env2655 = env2656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 54 env2655 == env2656) = true)

theorem identity2656 : scanCanonicalize (H12AffineFastState.compose env2656 (packedSelected [1,5] rootPS)) = affineNative (2^(6+1) ^^^ 26) := by decide +kernel

end H12GlobalChart2