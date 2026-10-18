import H12GlobalChart2Data021

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound5396 : packedSelected [0,4,7,9,18] rootPS < 2^1333 := by decide +kernel

def env5397 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,8192,9957,8833,547,1345,9124,1024,8833,1976,8200,9188,8614,8361,697,9125,9957,1297,32,1284,4294967296,256,4294975528,1345,545]

theorem envBound5397 : H12AffineFastState.Bounded env5397 := by
  intro p hp
  have h : env5397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5396_5397 : H12AffineEnvironment.transform 15 547 env5396 = env5397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env5396 == env5397) = true)

theorem identity5397 : scanCanonicalize (H12AffineFastState.compose env5397 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound5397 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env5398 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,1297,8192,9292,8232,138,1345,8461,1024,8232,1297,8200,8525,8614,8361,16,8460,9292,1297,32,1284,4294967296,256,4294975528,1345,136]

theorem envBound5398 : H12AffineFastState.Bounded env5398 := by
  intro p hp
  have h : env5398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5397_5398 : H12AffineEnvironment.transform 8 169 env5397 = env5398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env5397 == env5398) = true)

theorem identity5398 : scanCanonicalize (H12AffineFastState.compose env5398 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound5398 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env5399 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,1297,268,1344,292,138,1345,1,1024,292,1297,260,65,170,421,16,0,1344,1297,32,1284,4294967296,256,4294967588,1345,136]

theorem envBound5399 : H12AffineFastState.Bounded env5399 := by
  intro p hp
  have h : env5399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5398_5399 : H12AffineEnvironment.transform 12 268 env5398 = env5399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env5398 == env5399) = true)

theorem identity5399 : scanCanonicalize (H12AffineFastState.compose env5399 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 252) := by decide +kernel

theorem selectedBound5399 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5400 : List Nat := [2,4,8,16,32,64,128,252,169,1024,0,1261,240,1212,216,138,1213,1,1024,216,1261,248,65,170,89,16,0,1212,1261,32,1272,4294967296,252,4294967512,1213,136]

theorem envBound5400 : H12AffineFastState.Bounded env5400 := by
  intro p hp
  have h : env5400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5399_5400 : H12AffineEnvironment.transform 7 252 env5399 = env5400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 252 env5399 == env5400) = true)

def env5401 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8200,17665,16777216,33554432,16856709,291164,16868228,16852629,16785799,1284,4294967296,16851588,4328616958,1345,33563272]

theorem envBound5401 : H12AffineFastState.Bounded env5401 := by
  intro p hp
  have h : env5401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5375_5401 : H12AffineEnvironment.transform 10 1 env5375 = env5401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5375 == env5401) = true)

theorem identity5401 : scanCanonicalize (H12AffineFastState.compose env5401 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 280387) := by decide +kernel

theorem selectedBound5401 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5402 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8200,17665,280387,33554432,356806,291164,337095,352726,288452,1284,4294967296,353735,4328616958,1345,33563272]

theorem envBound5402 : H12AffineFastState.Bounded env5402 := by
  intro p hp
  have h : env5402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5401_5402 : H12AffineEnvironment.transform 23 280387 env5401 = env5402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 280387 env5401 == env5402) = true)

def env5403 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,262144,1024,8832,1296,8200,17665,280387,33554432,353494,287820,337095,352726,288452,1284,4294967296,353735,4328613614,1345,33563272]

theorem envBound5403 : H12AffineFastState.Bounded env5403 := by
  intro p hp
  have h : env5403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5402_5403 : H12AffineEnvironment.transform 11 1296 env5402 = env5403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5402 == env5403) = true)

def env5404 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,0,1024,8832,1296,8200,17665,18243,33554432,91350,25676,74951,90582,26308,1284,4294967296,91591,4328613614,1345,33563272]

theorem envBound5404 : H12AffineFastState.Bounded env5404 := by
  intro p hp
  have h : env5404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5403_5404 : H12AffineEnvironment.transform 17 0 env5403 = env5404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env5403 == env5404) = true)

theorem identity5404 : scanCanonicalize (H12AffineFastState.compose env5404 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 74410) := by decide +kernel

theorem selectedBound5404 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5405 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,0,1024,8832,1296,8200,17665,18243,74410,91350,25676,74951,90582,26308,1284,4294967296,91591,4294984772,1345,65570]

theorem envBound5405 : H12AffineFastState.Bounded env5405 := by
  intro p hp
  have h : env5405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5404_5405 : H12AffineEnvironment.transform 24 74410 env5404 = env5405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 74410 env5404 == env5405) = true)

theorem identity5405 : scanCanonicalize (H12AffineFastState.compose env5405 (packedSelected [1,3,5,8,10,17,18,21,26] rootPS)) = affineNative (2^(15+1) ^^^ 18242) := by decide +kernel

theorem selectedBound5405 : packedSelected [1,3,5,8,10,17,18,21,26] rootPS < 2^1333 := by decide +kernel

def env5406 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,18242,1345,0,1024,8832,1296,8200,17665,18243,26088,9108,25676,25477,9876,26308,1284,4294967296,8837,4294984772,1345,18272]

theorem envBound5406 : H12AffineFastState.Bounded env5406 := by
  intro p hp
  have h : env5406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5405_5406 : H12AffineEnvironment.transform 15 18242 env5405 = env5406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 18242 env5405 == env5406) = true)

theorem identity5406 : scanCanonicalize (H12AffineFastState.compose env5406 (packedSelected [1,5,8,17,21,24] rootPS)) = affineNative (2^(13+1) ^^^ 2025) := by decide +kernel

theorem selectedBound5406 : packedSelected [1,5,8,17,21,24] rootPS < 2^1333 := by decide +kernel

def env5407 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,2025,8832,171,1345,0,1024,8832,1296,8200,744,170,8705,9108,9125,9324,9876,8493,1284,4294967296,8837,4294968237,1345,137]

theorem envBound5407 : H12AffineFastState.Bounded env5407 := by
  intro p hp
  have h : env5407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5406_5407 : H12AffineEnvironment.transform 13 2025 env5406 = env5407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2025 env5406 == env5407) = true)

def env5408 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,1,1024,8832,1296,8200,17665,18242,33554432,91351,25677,74950,90583,26309,1284,4294967296,91590,4328613614,1345,33563272]

theorem envBound5408 : H12AffineFastState.Bounded env5408 := by
  intro p hp
  have h : env5408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5403_5408 : H12AffineEnvironment.transform 17 1 env5403 = env5408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env5403 == env5408) = true)

theorem identity5408 : scanCanonicalize (H12AffineFastState.compose env5408 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 83686) := by decide +kernel

theorem selectedBound5408 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5409 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,1,1024,8832,1296,8200,17665,18242,83686,91351,25677,74950,90583,26309,1284,4294967296,91590,4294975496,1345,91246]

theorem envBound5409 : H12AffineFastState.Bounded env5409 := by
  intro p hp
  have h : env5409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5408_5409 : H12AffineEnvironment.transform 24 83686 env5408 = env5409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 83686 env5408 == env5409) = true)

theorem identity5409 : scanCanonicalize (H12AffineFastState.compose env5409 (packedSelected [1,10,26,28] rootPS)) = affineNative (2^(15+1) ^^^ 25830) := by decide +kernel

theorem selectedBound5409 : packedSelected [1,10,26,28] rootPS < 2^1333 := by decide +kernel

def env5410 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,25830,1345,1,1024,8832,1296,8200,17665,18242,8704,49,25677,16416,1329,26309,1284,4294967296,288,4294975496,1345,136]

theorem envBound5410 : H12AffineFastState.Bounded env5410 := by
  intro p hp
  have h : env5410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5409_5410 : H12AffineEnvironment.transform 15 25830 env5409 = env5410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25830 env5409 == env5410) = true)

theorem identity5410 : scanCanonicalize (H12AffineFastState.compose env5410 (packedSelected [0,1,4,5,7,8,17,21,22,23,24] rootPS)) = affineNative (2^(13+1) ^^^ 2024) := by decide +kernel

theorem selectedBound5410 : packedSelected [0,1,4,5,7,8,17,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env5411 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,2024,8832,8974,1345,1,1024,8832,1296,8200,745,170,8704,49,9125,1992,1329,8493,1284,4294967296,288,4294975496,1345,136]

theorem envBound5411 : H12AffineFastState.Bounded env5411 := by
  intro p hp
  have h : env5411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5410_5411 : H12AffineEnvironment.transform 13 2024 env5410 = env5411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2024 env5410 == env5411) = true)

theorem identity5411 : scanCanonicalize (H12AffineFastState.compose env5411 (packedSelected [0,1,3,4,5,7,8,12,13,15,18,21,22] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5411 : packedSelected [0,1,3,4,5,7,8,12,13,15,18,21,22] rootPS < 2^1333 := by decide +kernel

def env5412 : List Nat := [2,4,8,16,32,64,128,4,512,1024,1,1044,8192,1772,8832,8714,1093,1,1024,8832,1044,8200,745,170,8704,49,8865,1740,1077,8233,1024,4294967296,36,4294975496,1093,136]

theorem envBound5412 : H12AffineFastState.Bounded env5412 := by
  intro p hp
  have h : env5412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5411_5412 : H12AffineEnvironment.transform 7 4 env5411 = env5412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5411 == env5412) = true)

theorem identity5412 : scanCanonicalize (H12AffineFastState.compose env5412 (packedSelected [5,8,16] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5412 : packedSelected [5,8,16] rootPS < 2^1333 := by decide +kernel

def env5413 : List Nat := [2,4,8,16,0,64,128,4,512,1024,1,1044,8192,1740,8832,8714,1093,1,1024,8832,1044,8200,713,138,8704,17,8833,1740,1045,8201,1024,4294967296,4,4294975496,1093,136]

theorem envBound5413 : H12AffineFastState.Bounded env5413 := by
  intro p hp
  have h : env5413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5412_5413 : H12AffineEnvironment.transform 4 0 env5412 = env5413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5412 == env5413) = true)

def env5414 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,262144,1024,8832,1297,8200,17665,280387,33554432,353495,287821,337095,352726,288452,1284,4294967296,353735,4328613615,1345,33563272]

theorem envBound5414 : H12AffineFastState.Bounded env5414 := by
  intro p hp
  have h : env5414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5402_5414 : H12AffineEnvironment.transform 11 1297 env5402 = env5414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5402 == env5414) = true)

def env5415 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8200,17665,18243,33554432,91351,25677,74951,90582,26308,1284,4294967296,91591,4328613615,1345,33563272]

theorem envBound5415 : H12AffineFastState.Bounded env5415 := by
  intro p hp
  have h : env5415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5414_5415 : H12AffineEnvironment.transform 17 0 env5414 = env5415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env5414 == env5415) = true)

theorem identity5415 : scanCanonicalize (H12AffineFastState.compose env5415 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 18028) := by decide +kernel

theorem selectedBound5415 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5416 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8200,17665,18243,18028,91351,25677,74951,90582,26308,1284,4294967296,91591,4295041155,1345,25828]

theorem envBound5416 : H12AffineFastState.Bounded env5416 := by
  intro p hp
  have h : env5416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5415_5416 : H12AffineEnvironment.transform 24 18028 env5415 = env5416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 18028 env5415 == env5416) = true)

def env5417 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9924,8832,65536,1345,0,1024,8832,1297,8200,9157,8583,8360,66067,649,74951,67346,0,1284,4294967296,66307,4295041155,1345,544]

theorem envBound5417 : H12AffineFastState.Bounded env5417 := by
  intro p hp
  have h : env5417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5416_5417 : H12AffineEnvironment.transform 13 9924 env5416 = env5417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9924 env5416 == env5417) = true)

theorem identity5417 : scanCanonicalize (H12AffineFastState.compose env5417 (packedSelected [18] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound5417 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5418 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9924,8832,171,1345,0,1024,8832,1297,8200,9157,8583,8360,696,649,9324,1977,0,1284,4294967296,936,4294975528,1345,544]

theorem envBound5418 : H12AffineFastState.Bounded env5418 := by
  intro p hp
  have h : env5418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5417_5418 : H12AffineEnvironment.transform 15 171 env5417 = env5418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env5417 == env5418) = true)

theorem identity5418 : scanCanonicalize (H12AffineFastState.compose env5418 (packedSelected [9,16,22,23] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound5418 : packedSelected [9,16,22,23] rootPS < 2^1333 := by decide +kernel

def env5419 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,900,1344,260,171,1345,0,1024,260,1297,908,65,515,812,696,649,2024,1977,0,1284,4294967296,936,4294968236,1345,544]

theorem envBound5419 : H12AffineFastState.Bounded env5419 := by
  intro p hp
  have h : env5419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5418_5419 : H12AffineEnvironment.transform 12 900 env5418 = env5419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env5418 == env5419) = true)

theorem identity5419 : scanCanonicalize (H12AffineFastState.compose env5419 (packedSelected [16] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5419 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env5420 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1297,900,1344,260,138,1345,0,1024,260,1297,908,65,515,781,665,649,1993,1944,0,1284,4294967296,905,4294968205,1345,513]

theorem envBound5420 : H12AffineFastState.Bounded env5420 := by
  intro p hp
  have h : env5420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5419_5420 : H12AffineEnvironment.transform 4 1 env5419 = env5420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5419 == env5420) = true)

theorem identity5420 : scanCanonicalize (H12AffineFastState.compose env5420 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5420 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5421 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,269,1344,260,138,1345,0,1024,260,1297,261,65,138,388,16,0,1344,1297,0,1284,4294967296,256,4294967556,1345,136]

theorem envBound5421 : H12AffineFastState.Bounded env5421 := by
  intro p hp
  have h : env5421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5420_5421 : H12AffineEnvironment.transform 8 137 env5420 = env5421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5420 == env5421) = true)

theorem identity5421 : scanCanonicalize (H12AffineFastState.compose env5421 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 220) := by decide +kernel

theorem selectedBound5421 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5422 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1229,209,1180,216,138,1181,0,1024,216,1229,217,65,138,88,16,0,1180,1229,0,1240,4294967296,220,4294967512,1181,136]

theorem envBound5422 : H12AffineFastState.Bounded env5422 := by
  intro p hp
  have h : env5422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5421_5422 : H12AffineEnvironment.transform 7 220 env5421 = env5422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 220 env5421 == env5422) = true)

theorem identity5422 : scanCanonicalize (H12AffineFastState.compose env5422 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5422 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5423 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1229,209,1180,216,138,1181,0,1024,216,1229,217,65,138,88,16,0,1180,1229,0,1240,90,220,130,1181,136]

theorem envBound5423 : H12AffineFastState.Bounded env5423 := by
  intro p hp
  have h : env5423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5422_5423 : H12AffineEnvironment.transform 31 90 env5422 = env5423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5422 == env5423) = true)

def env5424 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9925,8832,65536,1345,0,1024,8832,1297,8200,9156,8582,8361,66066,648,74951,67347,1,1284,4294967296,66306,4295041155,1345,545]

theorem envBound5424 : H12AffineFastState.Bounded env5424 := by
  intro p hp
  have h : env5424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5416_5424 : H12AffineEnvironment.transform 13 9925 env5416 = env5424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9925 env5416 == env5424) = true)

theorem identity5424 : scanCanonicalize (H12AffineFastState.compose env5424 (packedSelected [18] rootPS)) = affineNative (2^(12+1) ^^^ 301) := by decide +kernel

theorem selectedBound5424 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5425 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,301,2024,941,65536,1345,0,1024,941,1297,293,745,171,388,66066,648,67050,67347,1,1284,4294967296,66306,4295033262,1345,545]

theorem envBound5425 : H12AffineFastState.Bounded env5425 := by
  intro p hp
  have h : env5425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5424_5425 : H12AffineEnvironment.transform 12 301 env5424 = env5425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 301 env5424 == env5425) = true)

theorem identity5425 : scanCanonicalize (H12AffineFastState.compose env5425 (packedSelected [1,5,8,17,21,24] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound5425 : packedSelected [1,5,8,17,21,24] rootPS < 2^1333 := by decide +kernel

def env5426 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,301,2024,941,171,1345,0,1024,941,1297,293,745,171,388,697,648,1345,1976,1,1284,4294967296,937,4294967557,1345,545]

theorem envBound5426 : H12AffineFastState.Bounded env5426 := by
  intro p hp
  have h : env5426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5425_5426 : H12AffineEnvironment.transform 15 171 env5425 = env5426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env5425 == env5426) = true)

theorem identity5426 : scanCanonicalize (H12AffineFastState.compose env5426 (packedSelected [16] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound5426 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env5427 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1297,301,1345,260,171,1345,0,1024,260,1297,293,64,171,388,16,33,1345,1297,1,1284,4294967296,256,4294967557,1345,136]

theorem envBound5427 : H12AffineFastState.Bounded env5427 := by
  intro p hp
  have h : env5427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5426_5427 : H12AffineEnvironment.transform 8 169 env5426 = env5427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env5426 == env5427) = true)

theorem identity5427 : scanCanonicalize (H12AffineFastState.compose env5427 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 173) := by decide +kernel

theorem selectedBound5427 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5428 : List Nat := [2,4,8,16,32,64,128,173,169,1024,1,1212,128,1260,169,171,1260,0,1024,169,1212,136,64,171,41,16,33,1260,1212,1,1193,4294967296,173,4294967464,1260,136]

theorem envBound5428 : H12AffineFastState.Bounded env5428 := by
  intro p hp
  have h : env5428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5427_5428 : H12AffineEnvironment.transform 7 173 env5427 = env5428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 173 env5427 == env5428) = true)

theorem identity5428 : scanCanonicalize (H12AffineFastState.compose env5428 (packedSelected [0,2,4] rootPS)) = affineNative (2^(31+1) ^^^ 91) := by decide +kernel

theorem selectedBound5428 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env5429 : List Nat := [2,4,8,16,32,64,128,173,169,1024,1,1212,128,1260,169,171,1260,0,1024,169,1212,136,64,171,41,16,33,1260,1212,1,1193,91,173,243,1260,136]

theorem envBound5429 : H12AffineFastState.Bounded env5429 := by
  intro p hp
  have h : env5429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5428_5429 : H12AffineEnvironment.transform 31 91 env5428 = env5429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 91 env5428 == env5429) = true)

theorem identity5429 : scanCanonicalize (H12AffineFastState.compose env5429 (packedSelected [8] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5429 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env5430 : List Nat := [2,4,8,16,1,64,128,140,136,1024,1,1181,128,1229,136,138,1229,0,1024,136,1181,136,64,138,8,16,0,1229,1181,1,1160,91,140,210,1229,136]

theorem envBound5430 : H12AffineFastState.Bounded env5430 := by
  intro p hp
  have h : env5430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5429_5430 : H12AffineEnvironment.transform 4 1 env5429 = env5430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5429 == env5430) = true)

theorem identity5430 : scanCanonicalize (H12AffineFastState.compose env5430 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 25) := by decide +kernel

theorem selectedBound5430 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5431 : List Nat := [2,4,8,16,1,25,128,140,136,1024,1,1181,128,1172,136,138,1172,0,1024,136,1181,136,25,138,8,16,0,1172,1181,1,1160,2,140,139,1172,136]

theorem envBound5431 : H12AffineFastState.Bounded env5431 := by
  intro p hp
  have h : env5431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5430_5431 : H12AffineEnvironment.transform 5 25 env5430 = env5431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env5430 == env5431) = true)

theorem identity5431 : scanCanonicalize (H12AffineFastState.compose env5431 (packedSelected [6] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound5431 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5432 : List Nat := [2,4,8,16,1,25,2,14,10,1024,1,1055,2,1046,10,8,1046,0,1024,10,1055,10,25,8,8,16,0,1046,1055,1,1034,2,14,9,1046,10]

theorem envBound5432 : H12AffineFastState.Bounded env5432 := by
  intro p hp
  have h : env5432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5431_5432 : H12AffineEnvironment.transform 6 2 env5431 = env5432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env5431 == env5432) = true)

theorem identity5432 : scanCanonicalize (H12AffineFastState.compose env5432 (packedSelected [1,2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5432 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env5433 : List Nat := [0,4,8,16,1,25,0,12,8,1024,1,1053,0,1044,8,8,1044,0,1024,8,1053,8,25,8,8,16,0,1044,1053,1,1032,0,12,9,1044,8]

theorem envBound5433 : H12AffineFastState.Bounded env5433 := by
  intro p hp
  have h : env5433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5432_5433 : H12AffineEnvironment.transform 0 0 env5432 = env5433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5432 == env5433) = true)

def env5434 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8200,17665,18242,33554432,91350,25676,74950,90583,26309,1284,4294967296,91590,4328613615,1345,33563272]

theorem envBound5434 : H12AffineFastState.Bounded env5434 := by
  intro p hp
  have h : env5434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5414_5434 : H12AffineEnvironment.transform 17 1 env5414 = env5434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env5414 == env5434) = true)

theorem identity5434 : scanCanonicalize (H12AffineFastState.compose env5434 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 8736) := by decide +kernel

theorem selectedBound5434 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5435 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8200,17665,18242,8736,91350,25676,74950,90583,26309,1284,4294967296,91590,4295050447,1345,168]

theorem envBound5435 : H12AffineFastState.Bounded env5435 := by
  intro p hp
  have h : env5435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5434_5435 : H12AffineEnvironment.transform 24 8736 env5434 = env5435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8736 env5434 == env5435) = true)

theorem identity5435 : scanCanonicalize (H12AffineFastState.compose env5435 (packedSelected [1,3,24,28] rootPS)) = affineNative (2^(15+1) ^^^ 25798) := by decide +kernel

theorem selectedBound5435 : packedSelected [1,3,24,28] rootPS < 2^1333 := by decide +kernel

def env5436 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,25798,1345,1,1024,8832,1297,8200,17665,18242,8736,16,25676,16384,1297,26309,1284,4294967296,256,4294975497,1345,168]

theorem envBound5436 : H12AffineFastState.Bounded env5436 := by
  intro p hp
  have h : env5436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5435_5436 : H12AffineEnvironment.transform 15 25798 env5435 = env5436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25798 env5435 == env5436) = true)

theorem identity5436 : scanCanonicalize (H12AffineFastState.compose env5436 (packedSelected [1,3,5,8,12,13,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5436 : packedSelected [1,3,5,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5437 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1297,8192,16384,8832,25798,1345,1,1024,8832,1297,8200,17665,18242,8705,16,25676,16384,1297,26309,1284,4294967296,256,4294975497,1345,137]

theorem envBound5437 : H12AffineFastState.Bounded env5437 := by
  intro p hp
  have h : env5437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5436_5437 : H12AffineEnvironment.transform 4 1 env5436 = env5437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5436 == env5437) = true)

theorem identity5437 : scanCanonicalize (H12AffineFastState.compose env5437 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5437 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5438 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,8192,16384,8201,25798,1345,1,1024,8201,1297,8200,17665,17867,8328,16,25676,16384,1297,25676,1284,4294967296,256,4294975497,1345,137]

theorem envBound5438 : H12AffineFastState.Bounded env5438 := by
  intro p hp
  have h : env5438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5437_5438 : H12AffineEnvironment.transform 8 137 env5437 = env5438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5437 == env5438) = true)

theorem identity5438 : scanCanonicalize (H12AffineFastState.compose env5438 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 2) := by decide +kernel

theorem selectedBound5438 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env5439 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,2,16384,11,17604,1345,1,1024,11,1297,10,17665,17867,138,16,17486,16384,1297,17486,1284,4294967296,256,4294967307,1345,137]

theorem envBound5439 : H12AffineFastState.Bounded env5439 := by
  intro p hp
  have h : env5439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5438_5439 : H12AffineEnvironment.transform 12 2 env5438 = env5439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2 env5438 == env5439) = true)

theorem identity5439 : scanCanonicalize (H12AffineFastState.compose env5439 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound5439 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5440 : List Nat := [2,4,8,16,1,64,9,256,0,1024,1,1297,2,16384,11,17485,1345,1,1024,11,1297,10,17665,17730,3,16,17486,16384,1297,17486,1284,4294967296,256,4294967307,1345,0]

theorem envBound5440 : H12AffineFastState.Bounded env5440 := by
  intro p hp
  have h : env5440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5439_5440 : H12AffineEnvironment.transform 6 9 env5439 = env5440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env5439 == env5440) = true)

theorem identity5440 : scanCanonicalize (H12AffineFastState.compose env5440 (packedSelected [4,9] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound5440 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env5441 : List Nat := [2,4,8,16,1,64,9,15,0,1024,1,1054,2,16384,11,17485,1102,1,1024,11,1054,10,17422,17485,3,16,17486,16384,1054,17486,1035,4294967296,15,4294967307,1102,0]

theorem envBound5441 : H12AffineFastState.Bounded env5441 := by
  intro p hp
  have h : env5441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5440_5441 : H12AffineEnvironment.transform 7 15 env5440 = env5441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env5440 == env5441) = true)

theorem identity5441 : scanCanonicalize (H12AffineFastState.compose env5441 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 24) := by decide +kernel

theorem selectedBound5441 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env5442 : List Nat := [2,4,8,16,1,24,9,15,0,1024,1,1054,2,16384,11,17429,1046,1,1024,11,1054,10,17422,17429,3,16,17430,16384,1054,17430,1035,4294967296,15,4294967307,1046,0]

theorem envBound5442 : H12AffineFastState.Bounded env5442 := by
  intro p hp
  have h : env5442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5441_5442 : H12AffineEnvironment.transform 5 24 env5441 = env5442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 24 env5441 == env5442) = true)

theorem identity5442 : scanCanonicalize (H12AffineFastState.compose env5442 (packedSelected [0,1,3,5] rootPS)) = affineNative (2^(31+1) ^^^ 17430) := by decide +kernel

theorem selectedBound5442 : packedSelected [0,1,3,5] rootPS < 2^1333 := by decide +kernel

def env5443 : List Nat := [2,4,8,16,1,24,9,15,0,1024,1,1054,2,16384,11,17429,1046,1,1024,11,1054,10,17422,17429,3,16,17430,16384,1054,17430,1035,17430,15,17437,1046,0]

theorem envBound5443 : H12AffineFastState.Bounded env5443 := by
  intro p hp
  have h : env5443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5442_5443 : H12AffineEnvironment.transform 31 17430 env5442 = env5443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 17430 env5442 == env5443) = true)

theorem identity5443 : scanCanonicalize (H12AffineFastState.compose env5443 (packedSelected [1,10] rootPS)) = affineNative (2^(13+1) ^^^ 19) := by decide +kernel

theorem selectedBound5443 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env5444 : List Nat := [2,4,8,16,1,24,9,15,0,1024,1,1054,2,19,11,1030,1046,1,1024,11,1054,10,1053,1030,3,16,1029,19,1054,1029,1035,1029,15,1038,1046,0]

theorem envBound5444 : H12AffineFastState.Bounded env5444 := by
  intro p hp
  have h : env5444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5443_5444 : H12AffineEnvironment.transform 13 19 env5443 = env5444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 19 env5443 == env5444) = true)

theorem identity5444 : scanCanonicalize (H12AffineFastState.compose env5444 (packedSelected [0,1,2,3,12] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound5444 : packedSelected [0,1,2,3,12] rootPS < 2^1333 := by decide +kernel

def env5445 : List Nat := [2,4,0,16,1,16,1,7,0,1024,1,1046,2,19,3,1030,1046,1,1024,3,1046,2,1045,1030,3,16,1029,19,1046,1029,1027,1029,7,1030,1046,0]

theorem envBound5445 : H12AffineFastState.Bounded env5445 := by
  intro p hp
  have h : env5445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5444_5445 : H12AffineEnvironment.transform 2 0 env5444 = env5445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5444 == env5445) = true)

theorem identity5445 : scanCanonicalize (H12AffineFastState.compose env5445 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 6) := by decide +kernel

theorem selectedBound5445 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5446 : List Nat := [2,4,0,16,1,16,1,7,0,6,1,16,2,19,3,0,16,1,6,3,16,2,19,0,3,16,3,19,16,3,5,3,7,0,16,0]

theorem envBound5446 : H12AffineFastState.Bounded env5446 := by
  intro p hp
  have h : env5446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5445_5446 : H12AffineEnvironment.transform 9 6 env5445 = env5446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 6 env5445 == env5446) = true)

theorem identity5446 : scanCanonicalize (H12AffineFastState.compose env5446 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5446 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5447 : List Nat := [0,4,0,16,1,16,1,5,0,4,1,16,0,17,1,0,16,1,4,1,16,0,17,0,1,16,1,17,16,1,5,1,5,0,16,0]

theorem envBound5447 : H12AffineFastState.Bounded env5447 := by
  intro p hp
  have h : env5447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5446_5447 : H12AffineEnvironment.transform 0 0 env5446 = env5447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5446 == env5447) = true)

theorem identity5447 : scanCanonicalize (H12AffineFastState.compose env5447 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound5447 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5448 : List Nat := [0,4,0,1,1,1,1,5,0,4,1,1,0,0,1,0,1,1,4,1,1,0,0,0,1,1,1,0,1,1,5,1,5,0,1,0]

theorem envBound5448 : H12AffineFastState.Bounded env5448 := by
  intro p hp
  have h : env5448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5447_5448 : H12AffineEnvironment.transform 3 1 env5447 = env5448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env5447 == env5448) = true)

def env5449 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4096,8201,17665,16777216,33554432,16880645,291165,16892164,16876565,16787847,1284,4294967296,16875524,4328640895,1345,33563272]

theorem envBound5449 : H12AffineFastState.Bounded env5449 := by
  intro p hp
  have h : env5449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5272_5449 : H12AffineEnvironment.transform 21 8201 env5272 = env5449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 8201 env5272 == env5449) = true)

def env5450 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,10880,65536,1345,262144,1024,10880,4096,8201,17665,16777216,33554432,16858757,291165,16870276,16854677,16787847,1284,4294967296,16853636,4328619007,1345,33563272]

theorem envBound5450 : H12AffineFastState.Bounded env5450 := by
  intro p hp
  have h : env5450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5449_5450 : H12AffineEnvironment.transform 14 10880 env5449 = env5450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10880 env5449 == env5450) = true)

def env5451 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8201,17665,16777216,33554432,16856709,291165,16868228,16852629,16785799,1284,4294967296,16851588,4328616959,1345,33563272]

theorem envBound5451 : H12AffineFastState.Bounded env5451 := by
  intro p hp
  have h : env5451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5450_5451 : H12AffineEnvironment.transform 10 0 env5450 = env5451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5450 == env5451) = true)

theorem identity5451 : scanCanonicalize (H12AffineFastState.compose env5451 (packedSelected [11] rootPS)) = affineNative (2^(24+1) ^^^ 71351) := by decide +kernel

theorem selectedBound5451 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5452 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8201,17665,16777216,71351,16856709,291165,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,78911]

theorem envBound5452 : H12AffineFastState.Bounded env5452 := by
  intro p hp
  have h : env5452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5451_5452 : H12AffineEnvironment.transform 24 71351 env5451 = env5452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 71351 env5451 == env5452) = true)

def env5453 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,5392,1024,8832,4096,8201,17665,16777216,71351,16856709,25677,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,78911]

theorem envBound5453 : H12AffineFastState.Bounded env5453 := by
  intro p hp
  have h : env5453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5452_5453 : H12AffineEnvironment.transform 17 5392 env5452 = env5453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5392 env5452 == env5453) = true)

def env5454 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,65536,1345,0,1024,8832,1296,8201,17665,16777216,66471,16851861,25677,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,74031]

theorem envBound5454 : H12AffineFastState.Bounded env5454 := by
  intro p hp
  have h : env5454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5453_5454 : H12AffineEnvironment.transform 11 1296 env5453 = env5454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5453 == env5454) = true)

theorem identity5454 : scanCanonicalize (H12AffineFastState.compose env5454 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 25830) := by decide +kernel

theorem selectedBound5454 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5455 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,25830,1345,0,1024,8832,1296,8201,17665,16777216,26433,16795507,25677,16779106,16794227,16785799,1284,4294967296,16795234,4294993224,1345,17865]

theorem envBound5455 : H12AffineFastState.Bounded env5455 := by
  intro p hp
  have h : env5455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5454_5455 : H12AffineEnvironment.transform 15 25830 env5454 = env5455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25830 env5454 == env5455) = true)

theorem identity5455 : scanCanonicalize (H12AffineFastState.compose env5455 (packedSelected [1,5,6,8,17,21,24,25] rootPS)) = affineNative (2^(23+1) ^^^ 138) := by decide +kernel

theorem selectedBound5455 : packedSelected [1,5,6,8,17,21,24,25] rootPS < 2^1333 := by decide +kernel

def env5456 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,25830,1345,0,1024,8832,1296,8201,17665,138,26433,18425,25677,2024,17145,8461,1284,4294967296,18152,4294993224,1345,17865]

theorem envBound5456 : H12AffineFastState.Bounded env5456 := by
  intro p hp
  have h : env5456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5455_5456 : H12AffineEnvironment.transform 23 138 env5455 = env5456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 138 env5455 == env5456) = true)

theorem identity5456 : scanCanonicalize (H12AffineFastState.compose env5456 (packedSelected [0,4,7,16,22,23] rootPS)) = affineNative (2^(13+1) ^^^ 2024) := by decide +kernel

theorem selectedBound5456 : packedSelected [0,4,7,16,22,23] rootPS < 2^1333 := by decide +kernel

def env5457 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,2024,8832,8974,1345,0,1024,8832,1296,8201,745,138,8361,17,9125,2024,1297,8461,1284,4294967296,256,4294976160,1345,545]

theorem envBound5457 : H12AffineFastState.Bounded env5457 := by
  intro p hp
  have h : env5457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5456_5457 : H12AffineEnvironment.transform 13 2024 env5456 = env5457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2024 env5456 == env5457) = true)

theorem identity5457 : scanCanonicalize (H12AffineFastState.compose env5457 (packedSelected [1,3,8] rootPS)) = affineNative (2^(7+1) ^^^ 253) := by decide +kernel

theorem selectedBound5457 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env5458 : List Nat := [2,4,8,16,32,64,128,253,512,1024,0,1261,8192,1557,8832,8947,1212,0,1024,8832,1261,8201,745,138,8361,17,8792,1557,1260,8432,1273,4294967296,253,4294976160,1212,545]

theorem envBound5458 : H12AffineFastState.Bounded env5458 := by
  intro p hp
  have h : env5458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5457_5458 : H12AffineEnvironment.transform 7 253 env5457 = env5458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 253 env5457 == env5458) = true)

theorem identity5458 : scanCanonicalize (H12AffineFastState.compose env5458 (packedSelected [0,1,3,4,7,9,12,15] rootPS)) = affineNative (2^(12+1) ^^^ 209) := by decide +kernel

theorem selectedBound5458 : packedSelected [0,1,3,4,7,9,12,15] rootPS < 2^1333 := by decide +kernel

def env5459 : List Nat := [2,4,8,16,32,64,128,253,512,1024,0,1261,209,1557,593,546,1212,0,1024,593,1261,216,745,138,120,17,649,1557,1260,33,1273,4294967296,253,4294967921,1212,545]

theorem envBound5459 : H12AffineFastState.Bounded env5459 := by
  intro p hp
  have h : env5459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5458_5459 : H12AffineEnvironment.transform 12 209 env5458 = env5459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 209 env5458 == env5459) = true)

theorem identity5459 : scanCanonicalize (H12AffineFastState.compose env5459 (packedSelected [16] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5459 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env5460 : List Nat := [2,4,8,16,32,64,128,253,137,1024,0,1261,209,1180,216,171,1212,0,1024,216,1261,216,96,138,120,17,0,1180,1260,33,1273,4294967296,253,4294967544,1212,168]

theorem envBound5460 : H12AffineFastState.Bounded env5460 := by
  intro p hp
  have h : env5460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5459_5460 : H12AffineEnvironment.transform 8 137 env5459 = env5460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5459 == env5460) = true)

theorem identity5460 : scanCanonicalize (H12AffineFastState.compose env5460 (packedSelected [1,10,12] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5460 : packedSelected [1,10,12] rootPS < 2^1333 := by decide +kernel

def env5461 : List Nat := [2,4,8,16,0,64,128,221,137,1024,0,1229,209,1180,216,139,1180,0,1024,216,1229,216,64,138,88,17,0,1180,1228,1,1241,4294967296,221,4294967512,1180,136]

theorem envBound5461 : H12AffineFastState.Bounded env5461 := by
  intro p hp
  have h : env5461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5460_5461 : H12AffineEnvironment.transform 4 0 env5460 = env5461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5460 == env5461) = true)

theorem identity5461 : scanCanonicalize (H12AffineFastState.compose env5461 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 210) := by decide +kernel

theorem selectedBound5461 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5462 : List Nat := [2,4,8,16,0,64,128,221,137,1024,0,1229,209,1180,216,139,1180,0,1024,216,1229,216,64,138,88,17,0,1180,1228,1,1241,210,221,10,1180,136]

theorem envBound5462 : H12AffineFastState.Bounded env5462 := by
  intro p hp
  have h : env5462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5461_5462 : H12AffineEnvironment.transform 31 210 env5461 = env5462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 210 env5461 == env5462) = true)

def env5463 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8201,17665,16777216,66470,16851860,25677,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,74030]

theorem envBound5463 : H12AffineFastState.Bounded env5463 := by
  intro p hp
  have h : env5463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5453_5463 : H12AffineEnvironment.transform 11 1297 env5453 = env5463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5453 == env5463) = true)

theorem identity5463 : scanCanonicalize (H12AffineFastState.compose env5463 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 9006) := by decide +kernel

theorem selectedBound5463 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5464 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8201,17665,9006,66470,65722,25677,82090,67003,681,1284,4294967296,65962,4294993224,1345,74030]

theorem envBound5464 : H12AffineFastState.Bounded env5464 := by
  intro p hp
  have h : env5464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5463_5464 : H12AffineEnvironment.transform 23 9006 env5463 = env5464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 9006 env5463 == env5464) = true)

theorem identity5464 : scanCanonicalize (H12AffineFastState.compose env5464 (packedSelected [1,3,6,10,12,13,15,16,21,23,24,25,26,28,32] rootPS)) = affineNative (2^(15+1) ^^^ 18242) := by decide +kernel

theorem selectedBound5464 : packedSelected [1,3,6,10,12,13,15,16,21,23,24,25,26,28,32] rootPS < 2^1333 := by decide +kernel

def env5465 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,18242,1345,1,1024,8832,1297,8201,17665,9006,17636,18424,25677,2024,17145,681,1284,4294967296,18152,4294993224,1345,26220]

theorem envBound5465 : H12AffineFastState.Bounded env5465 := by
  intro p hp
  have h : env5465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5464_5465 : H12AffineEnvironment.transform 15 18242 env5464 = env5465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 18242 env5464 == env5465) = true)

theorem identity5465 : scanCanonicalize (H12AffineFastState.compose env5465 (packedSelected [6,16,18,25] rootPS)) = affineNative (2^(13+1) ^^^ 1377) := by decide +kernel

theorem selectedBound5465 : packedSelected [6,16,18,25] rootPS < 2^1333 := by decide +kernel

def env5466 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1377,8832,547,1345,1,1024,8832,1297,8201,96,9006,389,665,8492,2024,1944,681,1284,4294967296,905,4294975529,1345,8973]

theorem envBound5466 : H12AffineFastState.Bounded env5466 := by
  intro p hp
  have h : env5466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5465_5466 : H12AffineEnvironment.transform 13 1377 env5465 = env5466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1377 env5465 == env5466) = true)

theorem identity5466 : scanCanonicalize (H12AffineFastState.compose env5466 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5466 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5467 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,8192,1377,8201,170,1345,1,1024,8201,1297,8201,96,8615,389,16,8492,1377,1297,32,1284,4294967296,256,4294975529,1345,8580]

theorem envBound5467 : H12AffineFastState.Bounded env5467 := by
  intro p hp
  have h : env5467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5466_5467 : H12AffineEnvironment.transform 8 137 env5466 = env5467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5466 == env5467) = true)

theorem identity5467 : scanCanonicalize (H12AffineFastState.compose env5467 (packedSelected [5,8] rootPS)) = affineNative (2^(12+1) ^^^ 301) := by decide +kernel

theorem selectedBound5467 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5468 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,301,1377,292,170,1345,1,1024,292,1297,292,96,138,389,16,1,1377,1297,32,1284,4294967296,256,4294967556,1345,169]

theorem envBound5468 : H12AffineFastState.Bounded env5468 := by
  intro p hp
  have h : env5468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5467_5468 : H12AffineEnvironment.transform 12 301 env5467 = env5468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 301 env5467 == env5468) = true)

theorem identity5468 : scanCanonicalize (H12AffineFastState.compose env5468 (packedSelected [1,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound5468 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5469 : List Nat := [2,4,8,16,32,64,128,221,137,1024,0,1228,240,1212,249,170,1180,1,1024,249,1228,249,96,138,88,16,1,1212,1228,32,1241,4294967296,221,4294967513,1180,169]

theorem envBound5469 : H12AffineFastState.Bounded env5469 := by
  intro p hp
  have h : env5469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5468_5469 : H12AffineEnvironment.transform 7 221 env5468 = env5469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env5468 == env5469) = true)

theorem identity5469 : scanCanonicalize (H12AffineFastState.compose env5469 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5469 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5470 : List Nat := [2,4,8,16,0,64,128,221,137,1024,0,1228,208,1180,217,138,1180,1,1024,217,1228,217,64,138,88,16,1,1180,1228,0,1241,4294967296,221,4294967513,1180,137]

theorem envBound5470 : H12AffineFastState.Bounded env5470 := by
  intro p hp
  have h : env5470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5469_5470 : H12AffineEnvironment.transform 4 0 env5469 = env5470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5469 == env5470) = true)

theorem identity5470 : scanCanonicalize (H12AffineFastState.compose env5470 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 218) := by decide +kernel

theorem selectedBound5470 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5471 : List Nat := [2,4,8,16,0,64,128,221,137,1024,0,1228,208,1180,217,138,1180,1,1024,217,1228,217,64,138,88,16,1,1180,1228,0,1241,218,221,3,1180,137]

theorem envBound5471 : H12AffineFastState.Bounded env5471 := by
  intro p hp
  have h : env5471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5470_5471 : H12AffineEnvironment.transform 31 218 env5470 = env5471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 218 env5470 == env5471) = true)

theorem identity5471 : scanCanonicalize (H12AffineFastState.compose env5471 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 80) := by decide +kernel

theorem selectedBound5471 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5472 : List Nat := [2,4,8,16,0,64,80,13,89,1024,0,1052,0,1100,9,90,1100,1,1024,9,1052,9,64,90,88,16,1,1100,1052,0,1033,10,13,3,1100,89]

theorem envBound5472 : H12AffineFastState.Bounded env5472 := by
  intro p hp
  have h : env5472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5471_5472 : H12AffineEnvironment.transform 6 80 env5471 = env5472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 80 env5471 == env5472) = true)

theorem identity5472 : scanCanonicalize (H12AffineFastState.compose env5472 (packedSelected [0,6] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5472 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5473 : List Nat := [0,4,8,16,0,64,80,13,89,1024,0,1052,0,1100,9,88,1100,1,1024,9,1052,9,64,88,88,16,1,1100,1052,0,1033,8,13,1,1100,89]

theorem envBound5473 : H12AffineFastState.Bounded env5473 := by
  intro p hp
  have h : env5473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5472_5473 : H12AffineEnvironment.transform 0 0 env5472 = env5473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5472 == env5473) = true)

theorem identity5473 : scanCanonicalize (H12AffineFastState.compose env5473 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 25) := by decide +kernel

theorem selectedBound5473 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5474 : List Nat := [0,4,8,16,0,25,9,13,0,1024,0,1052,0,1045,9,1,1045,1,1024,9,1052,9,25,1,1,16,1,1045,1052,0,1033,8,13,1,1045,0]

theorem envBound5474 : H12AffineFastState.Bounded env5474 := by
  intro p hp
  have h : env5474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5473_5474 : H12AffineEnvironment.transform 5 25 env5473 = env5474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env5473 == env5474) = true)

def env5475 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,5393,1024,8832,4096,8201,17665,16777216,71351,16856709,25676,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,78911]

theorem envBound5475 : H12AffineFastState.Bounded env5475 := by
  intro p hp
  have h : env5475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5452_5475 : H12AffineEnvironment.transform 17 5393 env5452 = env5475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5393 env5452 == env5475) = true)

def env5476 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,65536,1345,1,1024,8832,1296,8201,17665,16777216,66471,16851861,25676,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,74031]

theorem envBound5476 : H12AffineFastState.Bounded env5476 := by
  intro p hp
  have h : env5476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5475_5476 : H12AffineEnvironment.transform 11 1296 env5475 = env5476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5475 == env5476) = true)

theorem identity5476 : scanCanonicalize (H12AffineFastState.compose env5476 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound5476 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5477 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,170,1345,1,1024,8832,1296,8201,17665,16777216,781,16786239,25676,16802606,16787007,16785799,1284,4294967296,16785966,4294993224,1345,8581]

theorem envBound5477 : H12AffineFastState.Bounded env5477 := by
  intro p hp
  have h : env5477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5476_5477 : H12AffineEnvironment.transform 15 170 env5476 = env5477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env5476 == env5477) = true)

theorem identity5477 : scanCanonicalize (H12AffineFastState.compose env5477 (packedSelected [1,3,6,9,16,18,22,23,24,25,28] rootPS)) = affineNative (2^(13+1) ^^^ 1376) := by decide +kernel

theorem selectedBound5477 : packedSelected [1,3,6,9,16,18,22,23,24,25,28] rootPS < 2^1333 := by decide +kernel

def env5478 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1376,8832,170,1345,1,1024,8832,1296,8201,97,16777216,781,16786239,8492,16787022,16787007,16785799,1284,4294967296,16785966,4294975528,1345,8581]

theorem envBound5478 : H12AffineFastState.Bounded env5478 := by
  intro p hp
  have h : env5478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5477_5478 : H12AffineEnvironment.transform 13 1376 env5477 = env5478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1376 env5477 == env5478) = true)

theorem identity5478 : scanCanonicalize (H12AffineFastState.compose env5478 (packedSelected [1,5,8,9,16,17,18,21,22,23,24] rootPS)) = affineNative (2^(23+1) ^^^ 8582) := by decide +kernel

theorem selectedBound5478 : packedSelected [1,5,8,9,16,17,18,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env5479 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1376,8832,170,1345,1,1024,8832,1296,8201,97,8582,781,697,8492,1992,1977,1,1284,4294967296,936,4294975528,1345,8581]

theorem envBound5479 : H12AffineFastState.Bounded env5479 := by
  intro p hp
  have h : env5479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5478_5479 : H12AffineEnvironment.transform 23 8582 env5478 = env5479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 8582 env5478 == env5479) = true)

def env5480 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8201,17665,16777216,66470,16851860,25676,16868228,16852629,16785799,1284,4294967296,16851588,4294993224,1345,74030]

theorem envBound5480 : H12AffineFastState.Bounded env5480 := by
  intro p hp
  have h : env5480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5475_5480 : H12AffineEnvironment.transform 11 1297 env5475 = env5480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5475 == env5480) = true)

theorem identity5480 : scanCanonicalize (H12AffineFastState.compose env5480 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 18275) := by decide +kernel

theorem selectedBound5480 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5481 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8201,17665,18275,66470,91383,25676,74983,90614,26340,1284,4294967296,91623,4294993224,1345,74030]

theorem envBound5481 : H12AffineFastState.Bounded env5481 := by
  intro p hp
  have h : env5481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5480_5481 : H12AffineEnvironment.transform 23 18275 env5480 = env5481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 18275 env5480 == env5481) = true)

theorem identity5481 : scanCanonicalize (H12AffineFastState.compose env5481 (packedSelected [1,3,5,6,8,10,17,21,25,26] rootPS)) = affineNative (2^(15+1) ^^^ 25831) := by decide +kernel

theorem selectedBound5481 : packedSelected [1,3,5,6,8,10,17,21,25,26] rootPS < 2^1333 := by decide +kernel

def env5482 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,25831,1345,0,1024,8832,1297,8201,17665,18275,26433,16,25676,16384,1297,26340,1284,4294967296,256,4294993224,1345,17865]

theorem envBound5482 : H12AffineFastState.Bounded env5482 := by
  intro p hp
  have h : env5482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5481_5482 : H12AffineEnvironment.transform 15 25831 env5481 = env5482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25831 env5481 == env5482) = true)

theorem identity5482 : scanCanonicalize (H12AffineFastState.compose env5482 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound5482 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5483 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1297,8192,16384,8232,25831,1345,0,1024,8232,1297,8201,17665,17867,26089,16,25676,16384,1297,25676,1284,4294967296,256,4294993224,1345,17865]

theorem envBound5483 : H12AffineFastState.Bounded env5483 := by
  intro p hp
  have h : env5483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5482_5483 : H12AffineEnvironment.transform 8 168 env5482 = env5483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env5482 == env5483) = true)

theorem identity5483 : scanCanonicalize (H12AffineFastState.compose env5483 (packedSelected [1,3,8] rootPS)) = affineNative (2^(7+1) ^^^ 140) := by decide +kernel

theorem selectedBound5483 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env5484 : List Nat := [2,4,8,16,32,64,128,140,168,1024,0,1181,8192,16384,8232,25831,1229,0,1024,8232,1181,8201,17549,17479,25701,16,25676,16384,1181,25676,1160,4294967296,140,4294993092,1229,17477]

theorem envBound5484 : H12AffineFastState.Bounded env5484 := by
  intro p hp
  have h : env5484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5483_5484 : H12AffineEnvironment.transform 7 140 env5483 = env5484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env5483 == env5484) = true)

theorem identity5484 : scanCanonicalize (H12AffineFastState.compose env5484 (packedSelected [0,1,3,4,5,7,9] rootPS)) = affineNative (2^(13+1) ^^^ 9293) := by decide +kernel

theorem selectedBound5484 : packedSelected [0,1,3,4,5,7,9] rootPS < 2^1333 := by decide +kernel

def env5485 : List Nat := [2,4,8,16,32,64,128,140,168,1024,0,1181,8192,9293,8232,170,1229,0,1024,8232,1181,8201,8384,8202,40,16,1,9293,1181,1,1160,4294967296,140,4294967433,1229,8200]

theorem envBound5485 : H12AffineFastState.Bounded env5485 := by
  intro p hp
  have h : env5485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5484_5485 : H12AffineEnvironment.transform 13 9293 env5484 = env5485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9293 env5484 == env5485) = true)

theorem identity5485 : scanCanonicalize (H12AffineFastState.compose env5485 (packedSelected [16] rootPS)) = affineNative (2^(12+1) ^^^ 160) := by decide +kernel

theorem selectedBound5485 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env5486 : List Nat := [2,4,8,16,32,64,128,140,168,1024,0,1181,160,1261,136,170,1229,0,1024,136,1181,169,96,170,40,16,1,1261,1181,1,1160,4294967296,140,4294967433,1229,168]

theorem envBound5486 : H12AffineFastState.Bounded env5486 := by
  intro p hp
  have h : env5486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5485_5486 : H12AffineEnvironment.transform 12 160 env5485 = env5486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 160 env5485 == env5486) = true)

theorem identity5486 : scanCanonicalize (H12AffineFastState.compose env5486 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound5486 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env5487 : List Nat := [2,4,8,16,32,64,2,14,42,1024,0,1055,34,1135,10,40,1103,0,1024,10,1055,43,96,40,40,16,1,1135,1055,1,1034,4294967296,14,4294967307,1103,42]

theorem envBound5487 : H12AffineFastState.Bounded env5487 := by
  intro p hp
  have h : env5487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5486_5487 : H12AffineEnvironment.transform 6 2 env5486 = env5487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env5486 == env5487) = true)

theorem identity5487 : scanCanonicalize (H12AffineFastState.compose env5487 (packedSelected [0,7] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound5487 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5488 : List Nat := [2,4,8,16,11,64,2,14,1,1024,0,1055,9,1092,10,3,1103,0,1024,10,1055,0,75,3,3,16,1,1092,1055,1,1034,4294967296,14,4294967307,1103,1]

theorem envBound5488 : H12AffineFastState.Bounded env5488 := by
  intro p hp
  have h : env5488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5487_5488 : H12AffineEnvironment.transform 4 11 env5487 = env5488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env5487 == env5488) = true)

theorem identity5488 : scanCanonicalize (H12AffineFastState.compose env5488 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 25) := by decide +kernel

theorem selectedBound5488 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5489 : List Nat := [2,4,8,16,11,25,2,14,1,1024,0,1055,9,1053,10,3,1046,0,1024,10,1055,0,18,3,3,16,1,1053,1055,1,1034,4294967296,14,4294967307,1046,1]

theorem envBound5489 : H12AffineFastState.Bounded env5489 := by
  intro p hp
  have h : env5489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5488_5489 : H12AffineEnvironment.transform 5 25 env5488 = env5489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env5488 == env5489) = true)

theorem identity5489 : scanCanonicalize (H12AffineFastState.compose env5489 (packedSelected [0,1,10] rootPS)) = affineNative (2^(31+1) ^^^ 1039) := by decide +kernel

theorem selectedBound5489 : packedSelected [0,1,10] rootPS < 2^1333 := by decide +kernel

def env5490 : List Nat := [2,4,8,16,11,25,2,14,1,1024,0,1055,9,1053,10,3,1046,0,1024,10,1055,0,18,3,3,16,1,1053,1055,1,1034,1039,14,1028,1046,1]

theorem envBound5490 : H12AffineFastState.Bounded env5490 := by
  intro p hp
  have h : env5490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5489_5490 : H12AffineEnvironment.transform 31 1039 env5489 = env5490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1039 env5489 == env5490) = true)

theorem identity5490 : scanCanonicalize (H12AffineFastState.compose env5490 (packedSelected [0,2,12] rootPS)) = affineNative (2^(9+1) ^^^ 13) := by decide +kernel

theorem selectedBound5490 : packedSelected [0,2,12] rootPS < 2^1333 := by decide +kernel

def env5491 : List Nat := [2,4,8,16,11,25,2,14,1,13,0,18,9,16,10,3,27,0,13,10,18,0,18,3,3,16,1,16,18,1,7,2,14,9,27,1]

theorem envBound5491 : H12AffineFastState.Bounded env5491 := by
  intro p hp
  have h : env5491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5490_5491 : H12AffineEnvironment.transform 9 13 env5490 = env5491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 13 env5490 == env5491) = true)

theorem identity5491 : scanCanonicalize (H12AffineFastState.compose env5491 (packedSelected [0,1] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound5491 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5492 : List Nat := [2,4,0,16,3,17,2,6,1,5,0,18,1,16,2,3,19,0,5,2,18,0,18,3,3,16,1,16,18,1,7,2,6,1,19,1]

theorem envBound5492 : H12AffineFastState.Bounded env5492 := by
  intro p hp
  have h : env5492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5491_5492 : H12AffineEnvironment.transform 2 0 env5491 = env5492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5491 == env5492) = true)

theorem identity5492 : scanCanonicalize (H12AffineFastState.compose env5492 (packedSelected [2,13] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5492 : packedSelected [2,13] rootPS < 2^1333 := by decide +kernel

def env5493 : List Nat := [0,4,0,16,1,17,0,4,1,5,0,16,1,16,0,1,17,0,5,0,16,0,16,1,1,16,1,16,16,1,5,0,4,1,17,1]

theorem envBound5493 : H12AffineFastState.Bounded env5493 := by
  intro p hp
  have h : env5493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5492_5493 : H12AffineEnvironment.transform 0 0 env5492 = env5493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5492 == env5493) = true)

theorem identity5493 : scanCanonicalize (H12AffineFastState.compose env5493 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound5493 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5494 : List Nat := [0,4,0,1,1,0,0,4,1,5,0,1,1,1,0,1,0,0,5,0,1,0,1,1,1,1,1,1,1,1,5,0,4,1,0,1]

theorem envBound5494 : H12AffineFastState.Bounded env5494 := by
  intro p hp
  have h : env5494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5493_5494 : H12AffineEnvironment.transform 3 1 env5493 = env5494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env5493 == env5494) = true)

def env5495 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,262144,1024,8833,4096,8201,17665,16777216,33554432,16856708,291165,16868229,16852628,16785798,1284,4294967296,16851589,4328616958,1345,33563272]

theorem envBound5495 : H12AffineFastState.Bounded env5495 := by
  intro p hp
  have h : env5495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5450_5495 : H12AffineEnvironment.transform 10 1 env5450 = env5495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5450 == env5495) = true)

theorem identity5495 : scanCanonicalize (H12AffineFastState.compose env5495 (packedSelected [11] rootPS)) = affineNative (2^(24+1) ^^^ 16782998) := by decide +kernel

theorem selectedBound5495 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5496 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,262144,1024,8833,4096,8201,17665,16777216,16782998,16856708,291165,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16790558]

theorem envBound5496 : H12AffineFastState.Bounded env5496 := by
  intro p hp
  have h : env5496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5495_5496 : H12AffineEnvironment.transform 24 16782998 env5495 = env5496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16782998 env5495 == env5496) = true)

def env5497 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,5392,1024,8833,4096,8201,17665,16777216,16782998,16856708,25677,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16790558]

theorem envBound5497 : H12AffineFastState.Bounded env5497 := by
  intro p hp
  have h : env5497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5496_5497 : H12AffineEnvironment.transform 17 5392 env5496 = env5497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5392 env5496 == env5497) = true)

def env5498 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,65536,1345,0,1024,8833,1296,8201,17665,16777216,16778118,16851860,25677,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16785678]

theorem envBound5498 : H12AffineFastState.Bounded env5498 := by
  intro p hp
  have h : env5498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5497_5498 : H12AffineEnvironment.transform 11 1296 env5497 = env5498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5497 == env5498) = true)

theorem identity5498 : scanCanonicalize (H12AffineFastState.compose env5498 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 83296) := by decide +kernel

theorem selectedBound5498 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5499 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,65536,1345,0,1024,8833,1296,8201,17665,83296,83686,26356,25677,9957,25588,91366,1284,4294967296,26597,4294975496,1345,91246]

theorem envBound5499 : H12AffineFastState.Bounded env5499 := by
  intro p hp
  have h : env5499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5498_5499 : H12AffineEnvironment.transform 23 83296 env5498 = env5499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 83296 env5498 == env5499) = true)

theorem identity5499 : scanCanonicalize (H12AffineFastState.compose env5499 (packedSelected [1,3,5,6,8,9,10,17,18,21,22,23,25,26] rootPS)) = affineNative (2^(15+1) ^^^ 8974) := by decide +kernel

theorem selectedBound5499 : packedSelected [1,3,5,6,8,9,10,17,18,21,22,23,25,26] rootPS < 2^1333 := by decide +kernel

def env5500 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,8974,1345,0,1024,8833,1296,8201,17665,26222,26088,26356,25677,9957,25588,18408,1284,4294967296,26597,4294975496,1345,18272]

theorem envBound5500 : H12AffineFastState.Bounded env5500 := by
  intro p hp
  have h : env5500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5499_5500 : H12AffineEnvironment.transform 15 8974 env5499 = env5500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8974 env5499 == env5500) = true)

theorem identity5500 : scanCanonicalize (H12AffineFastState.compose env5500 (packedSelected [1,3,5,8,12,13,15,16,17] rootPS)) = affineNative (2^(13+1) ^^^ 9957) := by decide +kernel

theorem selectedBound5500 : packedSelected [1,3,5,8,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env5501 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,9957,8833,8974,1345,0,1024,8833,1296,8201,9188,139,781,17,680,9957,1297,8461,1284,4294967296,256,4294975496,1345,8581]

theorem envBound5501 : H12AffineFastState.Bounded env5501 := by
  intro p hp
  have h : env5501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5500_5501 : H12AffineEnvironment.transform 13 9957 env5500 = env5501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9957 env5500 == env5501) = true)

def env5502 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,1,1024,8833,1297,8201,17665,16777216,16778119,16851861,25677,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16785679]

theorem envBound5502 : H12AffineFastState.Bounded env5502 := by
  intro p hp
  have h : env5502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5497_5502 : H12AffineEnvironment.transform 11 1297 env5497 = env5502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5497 == env5502) = true)

theorem identity5502 : scanCanonicalize (H12AffineFastState.compose env5502 (packedSelected [20] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound5502 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5503 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1297,8192,16384,8232,65536,1345,1,1024,8232,1297,8201,17665,16777216,16777518,16851260,25677,16867628,16852029,16785798,1284,4294967296,16850988,4311836008,1345,16785679]

theorem envBound5503 : H12AffineFastState.Bounded env5503 := by
  intro p hp
  have h : env5503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5502_5503 : H12AffineEnvironment.transform 8 169 env5502 = env5503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env5502 == env5503) = true)

theorem identity5503 : scanCanonicalize (H12AffineFastState.compose env5503 (packedSelected [1,6,10,25,26,28] rootPS)) = affineNative (2^(23+1) ^^^ 91245) := by decide +kernel

theorem selectedBound5503 : packedSelected [1,6,10,25,26,28] rootPS < 2^1333 := by decide +kernel

def env5504 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1297,8192,16384,8232,65536,1345,1,1024,8232,1297,8201,17665,91245,91459,17745,25677,1345,16464,83435,1284,4294967296,17473,4294967557,1345,83298]

theorem envBound5504 : H12AffineFastState.Bounded env5504 := by
  intro p hp
  have h : env5504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5503_5504 : H12AffineEnvironment.transform 23 91245 env5503 = env5504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 91245 env5503 == env5504) = true)

theorem identity5504 : scanCanonicalize (H12AffineFastState.compose env5504 (packedSelected [3,12,13,15,16,18,21,24] rootPS)) = affineNative (2^(13+1) ^^^ 9325) := by decide +kernel

theorem selectedBound5504 : packedSelected [3,12,13,15,16,18,21,24] rootPS < 2^1333 := by decide +kernel

def env5505 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1297,8192,9325,8232,65536,1345,1,1024,8232,1297,8201,8556,65536,65838,8508,32,1345,9277,74118,1284,4294967296,8236,4294967557,1345,73999]

theorem envBound5505 : H12AffineFastState.Bounded env5505 := by
  intro p hp
  have h : env5505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5504_5505 : H12AffineEnvironment.transform 13 9325 env5504 = env5505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9325 env5504 == env5505) = true)

theorem identity5505 : scanCanonicalize (H12AffineFastState.compose env5505 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound5505 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env5506 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1297,269,1376,293,65536,1345,1,1024,293,1297,260,97,65536,65838,49,32,1345,1328,65675,1284,4294967296,289,4294967557,1345,65538]

theorem envBound5506 : H12AffineFastState.Bounded env5506 := by
  intro p hp
  have h : env5506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5505_5506 : H12AffineEnvironment.transform 12 269 env5505 = env5506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env5505 == env5506) = true)

theorem identity5506 : scanCanonicalize (H12AffineFastState.compose env5506 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound5506 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env5507 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1297,269,1376,293,138,1345,1,1024,293,1297,260,97,138,420,49,32,1345,1328,1,1284,4294967296,289,4294967557,1345,136]

theorem envBound5507 : H12AffineFastState.Bounded env5507 := by
  intro p hp
  have h : env5507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5506_5507 : H12AffineEnvironment.transform 15 138 env5506 = env5507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env5506 == env5507) = true)

theorem identity5507 : scanCanonicalize (H12AffineFastState.compose env5507 (packedSelected [0,1,2,3,4,6,8] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound5507 : packedSelected [0,1,2,3,4,6,8] rootPS < 2^1333 := by decide +kernel

def env5508 : List Nat := [2,4,8,16,32,64,3,256,42,1024,1,1297,269,1376,293,9,1345,1,1024,293,1297,260,97,9,295,49,32,1345,1328,1,1284,4294967296,289,4294967557,1345,11]

theorem envBound5508 : H12AffineFastState.Bounded env5508 := by
  intro p hp
  have h : env5508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5507_5508 : H12AffineEnvironment.transform 6 3 env5507 = env5508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env5507 == env5508) = true)

theorem identity5508 : scanCanonicalize (H12AffineFastState.compose env5508 (packedSelected [0,1,3,5,7] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound5508 : packedSelected [0,1,3,5,7] rootPS < 2^1333 := by decide +kernel

def env5509 : List Nat := [2,4,8,16,32,64,3,36,42,1024,1,1077,41,1092,1,9,1125,1,1024,1,1077,32,97,9,3,49,32,1125,1044,1,1056,4294967296,5,4294967329,1125,11]

theorem envBound5509 : H12AffineFastState.Bounded env5509 := by
  intro p hp
  have h : env5509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5508_5509 : H12AffineEnvironment.transform 7 36 env5508 = env5509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env5508 == env5509) = true)

theorem identity5509 : scanCanonicalize (H12AffineFastState.compose env5509 (packedSelected [1,2,3] rootPS)) = affineNative (2^(31+1) ^^^ 81) := by decide +kernel

theorem selectedBound5509 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env5510 : List Nat := [2,4,8,16,32,64,3,36,42,1024,1,1077,41,1092,1,9,1125,1,1024,1,1077,32,97,9,3,49,32,1125,1044,1,1056,81,5,112,1125,11]

theorem envBound5510 : H12AffineFastState.Bounded env5510 := by
  intro p hp
  have h : env5510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5509_5510 : H12AffineEnvironment.transform 31 81 env5509 = env5510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 81 env5509 == env5510) = true)

theorem identity5510 : scanCanonicalize (H12AffineFastState.compose env5510 (packedSelected [5] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5510 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5511 : List Nat := [2,4,3,16,32,64,3,36,33,1024,1,1077,34,1092,1,2,1125,1,1024,1,1077,32,97,2,3,49,32,1125,1044,1,1056,81,5,112,1125,0]

theorem envBound5511 : H12AffineFastState.Bounded env5511 := by
  intro p hp
  have h : env5511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5510_5511 : H12AffineEnvironment.transform 2 3 env5510 = env5511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5510 == env5511) = true)

theorem identity5511 : scanCanonicalize (H12AffineFastState.compose env5511 (packedSelected [0,4,6] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5511 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env5512 : List Nat := [2,4,3,16,1,64,3,5,0,1024,1,1044,3,1092,1,2,1092,1,1024,1,1044,1,64,2,3,16,1,1092,1044,1,1025,81,5,81,1092,0]

theorem envBound5512 : H12AffineFastState.Bounded env5512 := by
  intro p hp
  have h : env5512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5511_5512 : H12AffineEnvironment.transform 4 1 env5511 = env5512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5511 == env5512) = true)

theorem identity5512 : scanCanonicalize (H12AffineFastState.compose env5512 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 19) := by decide +kernel

theorem selectedBound5512 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5513 : List Nat := [2,4,3,16,1,19,3,5,0,1024,1,1044,3,1047,1,2,1047,1,1024,1,1044,1,19,2,3,16,1,1047,1044,1,1025,2,5,2,1047,0]

theorem envBound5513 : H12AffineFastState.Bounded env5513 := by
  intro p hp
  have h : env5513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5512_5513 : H12AffineEnvironment.transform 5 19 env5512 = env5513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 19 env5512 == env5513) = true)

def env5514 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,5393,1024,8833,4096,8201,17665,16777216,16782998,16856708,25676,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16790558]

theorem envBound5514 : H12AffineFastState.Bounded env5514 := by
  intro p hp
  have h : env5514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5496_5514 : H12AffineEnvironment.transform 17 5393 env5496 = env5514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5393 env5496 == env5514) = true)

def env5515 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,65536,1345,1,1024,8833,1296,8201,17665,16777216,16778118,16851860,25676,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16785678]

theorem envBound5515 : H12AffineFastState.Bounded env5515 := by
  intro p hp
  have h : env5515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5514_5515 : H12AffineEnvironment.transform 11 1296 env5514 = env5515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5514 == env5515) = true)

theorem identity5515 : scanCanonicalize (H12AffineFastState.compose env5515 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 74028) := by decide +kernel

theorem selectedBound5515 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5516 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,65536,1345,1,1024,8833,1296,8201,17665,74028,74410,696,25676,17065,1976,65706,1284,4294967296,937,4294984772,1345,65570]

theorem envBound5516 : H12AffineFastState.Bounded env5516 := by
  intro p hp
  have h : env5516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5515_5516 : H12AffineEnvironment.transform 23 74028 env5515 = env5516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 74028 env5515 == env5516) = true)

theorem identity5516 : scanCanonicalize (H12AffineFastState.compose env5516 (packedSelected [1,3,6,24,25,28] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound5516 : packedSelected [1,3,6,24,25,28] rootPS < 2^1333 := by decide +kernel

def env5517 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,16384,261,65536,1345,1,1024,261,1296,909,17665,66216,65838,696,18376,17065,1976,65706,1284,4294967296,937,4294984772,1345,65570]

theorem envBound5517 : H12AffineFastState.Bounded env5517 := by
  intro p hp
  have h : env5517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5516_5517 : H12AffineEnvironment.transform 12 900 env5516 = env5517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env5516 == env5517) = true)

theorem identity5517 : scanCanonicalize (H12AffineFastState.compose env5517 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 2025) := by decide +kernel

theorem selectedBound5517 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5518 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,2025,261,65536,1345,1,1024,261,1296,909,744,66216,65838,696,33,1344,1976,65706,1284,4294967296,937,4294968237,1345,65570]

theorem envBound5518 : H12AffineFastState.Bounded env5518 := by
  intro p hp
  have h : env5518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5517_5518 : H12AffineEnvironment.transform 13 2025 env5517 = env5518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2025 env5517 == env5518) = true)

theorem identity5518 : scanCanonicalize (H12AffineFastState.compose env5518 (packedSelected [1,3,5,8,12,13,15,16,21] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound5518 : packedSelected [1,3,5,8,12,13,15,16,21] rootPS < 2^1333 := by decide +kernel

def env5519 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1296,301,1344,261,65536,1345,1,1024,261,1296,292,65,65537,65838,17,33,1344,1297,65706,1284,4294967296,256,4294967556,1345,65570]

theorem envBound5519 : H12AffineFastState.Bounded env5519 := by
  intro p hp
  have h : env5519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5518_5519 : H12AffineEnvironment.transform 8 169 env5518 = env5519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env5518 == env5519) = true)

theorem identity5519 : scanCanonicalize (H12AffineFastState.compose env5519 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5519 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5520 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,269,1344,261,65536,1345,1,1024,261,1296,260,65,65537,65806,17,1,1344,1297,65674,1284,4294967296,256,4294967556,1345,65538]

theorem envBound5520 : H12AffineFastState.Bounded env5520 := by
  intro p hp
  have h : env5520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5519_5520 : H12AffineEnvironment.transform 4 0 env5519 = env5520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5519 == env5520) = true)

theorem identity5520 : scanCanonicalize (H12AffineFastState.compose env5520 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound5520 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5521 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,269,1344,261,139,1345,1,1024,261,1296,260,65,138,389,17,1,1344,1297,1,1284,4294967296,256,4294967556,1345,137]

theorem envBound5521 : H12AffineFastState.Bounded env5521 := by
  intro p hp
  have h : env5521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5520_5521 : H12AffineEnvironment.transform 15 139 env5520 = env5521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env5520 == env5521) = true)

theorem identity5521 : scanCanonicalize (H12AffineFastState.compose env5521 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 81) := by decide +kernel

theorem selectedBound5521 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5522 : List Nat := [2,4,8,16,0,64,81,256,88,1024,1,1296,269,1344,261,90,1345,1,1024,261,1296,260,65,91,340,17,1,1344,1297,1,1284,4294967296,256,4294967556,1345,88]

theorem envBound5522 : H12AffineFastState.Bounded env5522 := by
  intro p hp
  have h : env5522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5521_5522 : H12AffineEnvironment.transform 6 81 env5521 = env5522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 81 env5521 == env5522) = true)

theorem identity5522 : scanCanonicalize (H12AffineFastState.compose env5522 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 12) := by decide +kernel

theorem selectedBound5522 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5523 : List Nat := [2,4,8,16,0,64,81,12,88,1024,1,1052,1,1100,9,90,1101,1,1024,9,1052,8,65,91,88,17,1,1100,1053,1,1032,4294967296,12,4294967304,1101,88]

theorem envBound5523 : H12AffineFastState.Bounded env5523 := by
  intro p hp
  have h : env5523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5522_5523 : H12AffineEnvironment.transform 7 12 env5522 = env5523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 12 env5522 == env5523) = true)

theorem identity5523 : scanCanonicalize (H12AffineFastState.compose env5523 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 83) := by decide +kernel

theorem selectedBound5523 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5524 : List Nat := [2,4,8,16,0,64,81,12,88,1024,1,1052,1,1100,9,90,1101,1,1024,9,1052,8,65,91,88,17,1,1100,1053,1,1032,83,12,91,1101,88]

theorem envBound5524 : H12AffineFastState.Bounded env5524 := by
  intro p hp
  have h : env5524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5523_5524 : H12AffineEnvironment.transform 31 83 env5523 = env5524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 83 env5523 == env5524) = true)

theorem identity5524 : scanCanonicalize (H12AffineFastState.compose env5524 (packedSelected [0,6] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5524 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5525 : List Nat := [1,4,8,16,0,64,81,12,88,1024,1,1052,1,1100,9,89,1101,1,1024,9,1052,8,65,88,88,17,1,1100,1053,1,1032,80,12,88,1101,88]

theorem envBound5525 : H12AffineFastState.Bounded env5525 := by
  intro p hp
  have h : env5525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5524_5525 : H12AffineEnvironment.transform 0 1 env5524 = env5525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5524 == env5525) = true)

theorem identity5525 : scanCanonicalize (H12AffineFastState.compose env5525 (packedSelected [0,7] rootPS)) = affineNative (2^(5+1) ^^^ 24) := by decide +kernel

theorem selectedBound5525 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5526 : List Nat := [1,4,8,16,0,24,9,12,0,1024,1,1052,1,1044,9,1,1045,1,1024,9,1052,8,25,0,0,17,1,1044,1053,1,1032,8,12,0,1045,0]

theorem envBound5526 : H12AffineFastState.Bounded env5526 := by
  intro p hp
  have h : env5526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5525_5526 : H12AffineEnvironment.transform 5 24 env5525 = env5526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 24 env5525 == env5526) = true)

def env5527 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,0,1024,8833,1297,8201,17665,16777216,16778119,16851861,25676,16868229,16852628,16785798,1284,4294967296,16851589,4311836008,1345,16785679]

theorem envBound5527 : H12AffineFastState.Bounded env5527 := by
  intro p hp
  have h : env5527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5514_5527 : H12AffineEnvironment.transform 11 1297 env5514 = env5527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5514 == env5527) = true)

theorem identity5527 : scanCanonicalize (H12AffineFastState.compose env5527 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 9956) := by decide +kernel

theorem selectedBound5527 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5528 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9956,8833,65536,1345,0,1024,8833,1297,8201,9189,16777216,16778119,16851861,680,16844129,16852628,16785798,1284,4294967296,16851589,4311810956,1345,16785679]

theorem envBound5528 : H12AffineFastState.Bounded env5528 := by
  intro p hp
  have h : env5528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5527_5528 : H12AffineEnvironment.transform 13 9956 env5527 = env5528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9956 env5527 == env5528) = true)

theorem identity5528 : scanCanonicalize (H12AffineFastState.compose env5528 (packedSelected [1,3,5,6,8,9,10,12,13,15,18,21,22,23,25,31] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound5528 : packedSelected [1,3,5,6,8,9,10,12,13,15,18,21,22,23,25,31] rootPS < 2^1333 := by decide +kernel

def env5529 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9956,8833,546,1345,0,1024,8833,1297,8201,9189,16777216,16778119,16785847,680,16779075,16786614,16785798,1284,4294967296,16785575,4311744942,1345,16785679]

theorem envBound5529 : H12AffineFastState.Bounded env5529 := by
  intro p hp
  have h : env5529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5528_5529 : H12AffineEnvironment.transform 15 546 env5528 = env5529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env5528 == env5529) = true)

theorem identity5529 : scanCanonicalize (H12AffineFastState.compose env5529 (packedSelected [0,3,4,7,12,13,15,16,18,21,22,23,24] rootPS)) = affineNative (2^(23+1) ^^^ 8583) := by decide +kernel

theorem selectedBound5529 : packedSelected [0,3,4,7,12,13,15,16,18,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env5530 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9956,8833,546,1345,0,1024,8833,1297,8201,9189,8583,8704,48,680,9924,1329,1,1284,4294967296,288,4294975529,1345,136]

theorem envBound5530 : H12AffineFastState.Bounded env5530 := by
  intro p hp
  have h : env5530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5529_5530 : H12AffineEnvironment.transform 23 8583 env5529 = env5530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 8583 env5529 == env5530) = true)

theorem identity5530 : scanCanonicalize (H12AffineFastState.compose env5530 (packedSelected [18] rootPS)) = affineNative (2^(12+1) ^^^ 301) := by decide +kernel

theorem selectedBound5530 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5531 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,301,1993,940,546,1345,0,1024,940,1297,292,712,170,813,48,680,2025,1329,1,1284,4294967296,288,4294967556,1345,136]

theorem envBound5531 : H12AffineFastState.Bounded env5531 := by
  intro p hp
  have h : env5531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5530_5531 : H12AffineEnvironment.transform 12 301 env5530 = env5531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 301 env5530 == env5531) = true)

theorem identity5531 : scanCanonicalize (H12AffineFastState.compose env5531 (packedSelected [1,3,9,12,13,15,21,22] rootPS)) = affineNative (2^(8+1) ^^^ 397) := by decide +kernel

theorem selectedBound5531 : packedSelected [1,3,9,12,13,15,21,22] rootPS < 2^1333 := by decide +kernel

def env5532 : List Nat := [2,4,8,16,32,64,128,256,397,1024,1,1297,301,1092,33,431,1345,0,1024,33,1297,292,325,170,160,48,293,1124,1329,1,1284,4294967296,288,4294967556,1345,136]

theorem envBound5532 : H12AffineFastState.Bounded env5532 := by
  intro p hp
  have h : env5532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5531_5532 : H12AffineEnvironment.transform 8 397 env5531 = env5532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 397 env5531 == env5532) = true)

theorem identity5532 : scanCanonicalize (H12AffineFastState.compose env5532 (packedSelected [5,8] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5532 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5533 : List Nat := [2,4,8,16,0,64,128,256,397,1024,1,1297,269,1092,1,399,1345,0,1024,1,1297,260,325,138,128,16,261,1092,1297,1,1284,4294967296,256,4294967556,1345,136]

theorem envBound5533 : H12AffineFastState.Bounded env5533 := by
  intro p hp
  have h : env5533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5532_5533 : H12AffineEnvironment.transform 4 0 env5532 = env5533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5532 == env5533) = true)

theorem identity5533 : scanCanonicalize (H12AffineFastState.compose env5533 (packedSelected [0,2,3,4] rootPS)) = affineNative (2^(31+1) ^^^ 351) := by decide +kernel

theorem selectedBound5533 : packedSelected [0,2,3,4] rootPS < 2^1333 := by decide +kernel

def env5534 : List Nat := [2,4,8,16,0,64,128,256,397,1024,1,1297,269,1092,1,399,1345,0,1024,1,1297,260,325,138,128,16,261,1092,1297,1,1284,351,256,91,1345,136]

theorem envBound5534 : H12AffineFastState.Bounded env5534 := by
  intro p hp
  have h : env5534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5533_5534 : H12AffineEnvironment.transform 31 351 env5533 = env5534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 351 env5533 == env5534) = true)

theorem identity5534 : scanCanonicalize (H12AffineFastState.compose env5534 (packedSelected [1,5] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5534 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env5535 : List Nat := [2,4,8,16,0,64,128,4,137,1024,1,1045,9,1092,1,139,1093,0,1024,1,1045,0,65,138,128,16,1,1092,1045,1,1024,91,4,91,1093,136]

theorem envBound5535 : H12AffineFastState.Bounded env5535 := by
  intro p hp
  have h : env5535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5534_5535 : H12AffineEnvironment.transform 7 4 env5534 = env5535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5534 == env5535) = true)

def env5536 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,10881,65536,1345,262144,1024,10881,4096,8201,17665,16777216,33554432,16858756,291165,16870277,16854676,16787847,1284,4294967296,16853637,4328619006,1345,33563272]

theorem envBound5536 : H12AffineFastState.Bounded env5536 := by
  intro p hp
  have h : env5536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5449_5536 : H12AffineEnvironment.transform 14 10881 env5449 = env5536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10881 env5449 == env5536) = true)

def env5537 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,262144,1024,8833,4096,8201,17665,16777216,33554432,16856708,291165,16868229,16852628,16785799,1284,4294967296,16851589,4328616958,1345,33563272]

theorem envBound5537 : H12AffineFastState.Bounded env5537 := by
  intro p hp
  have h : env5537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5536_5537 : H12AffineEnvironment.transform 10 0 env5536 = env5537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5536 == env5537) = true)

theorem identity5537 : scanCanonicalize (H12AffineFastState.compose env5537 (packedSelected [11] rootPS)) = affineNative (2^(15+1) ^^^ 13886) := by decide +kernel

theorem selectedBound5537 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5538 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,13886,1345,262144,1024,8833,4096,8201,17665,16777216,33554432,16777402,291165,16799163,16781482,16785799,1284,4294967296,16782523,4328539584,1345,33563272]

theorem envBound5538 : H12AffineFastState.Bounded env5538 := by
  intro p hp
  have h : env5538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5537_5538 : H12AffineEnvironment.transform 15 13886 env5537 = env5538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13886 env5537 == env5538) = true)

def env5539 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8833,9006,1345,262144,1024,8833,1296,8201,17665,16777216,33554432,16777402,287821,16793771,16778682,16785799,1284,4294967296,16777643,4328539584,1345,33563272]

theorem envBound5539 : H12AffineFastState.Bounded env5539 := by
  intro p hp
  have h : env5539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5538_5539 : H12AffineEnvironment.transform 11 1296 env5538 = env5539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5538 == env5539) = true)

def env5540 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8833,9006,1345,0,1024,8833,1296,8201,17665,16777216,33554432,16777402,25677,16793771,16778682,16785799,1284,4294967296,16777643,4328539584,1345,33563272]

theorem envBound5540 : H12AffineFastState.Bounded env5540 := by
  intro p hp
  have h : env5540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5539_5540 : H12AffineEnvironment.transform 17 0 env5539 = env5540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env5539 == env5540) = true)

theorem identity5540 : scanCanonicalize (H12AffineFastState.compose env5540 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound5540 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5541 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1992,8833,9006,1345,0,1024,8833,1296,8201,713,16777216,33554432,16777402,9093,16779107,16778682,16785799,1284,4294967296,16777643,4328522248,1345,33563272]

theorem envBound5541 : H12AffineFastState.Bounded env5541 := by
  intro p hp
  have h : env5541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5540_5541 : H12AffineEnvironment.transform 13 1992 env5540 = env5541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env5540 == env5541) = true)

theorem identity5541 : scanCanonicalize (H12AffineFastState.compose env5541 (packedSelected [1,5,6,8,17,21,24,25] rootPS)) = affineNative (2^(23+1) ^^^ 138) := by decide +kernel

theorem selectedBound5541 : packedSelected [1,5,6,8,17,21,24,25] rootPS < 2^1333 := by decide +kernel

def env5542 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1992,8833,9006,1345,0,1024,8833,1296,8201,713,138,33554432,48,9093,2025,1328,8461,1284,4294967296,289,4328522248,1345,33563272]

theorem envBound5542 : H12AffineFastState.Bounded env5542 := by
  intro p hp
  have h : env5542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5541_5542 : H12AffineEnvironment.transform 23 138 env5541 = env5542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 138 env5541 == env5542) = true)

theorem identity5542 : scanCanonicalize (H12AffineFastState.compose env5542 (packedSelected [0,4,7,16,22,23] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5542 : packedSelected [0,4,7,16,22,23] rootPS < 2^1333 := by decide +kernel

def env5543 : List Nat := [2,4,8,16,1,64,128,256,512,1024,0,1296,8192,1992,8833,8975,1345,0,1024,8833,1296,8201,713,138,33554432,17,9093,1992,1297,8461,1284,4294967296,256,4328522248,1345,33563272]

theorem envBound5543 : H12AffineFastState.Bounded env5543 := by
  intro p hp
  have h : env5543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5542_5543 : H12AffineEnvironment.transform 4 1 env5542 = env5543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5542 == env5543) = true)

theorem identity5543 : scanCanonicalize (H12AffineFastState.compose env5543 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(8+1) ^^^ 340) := by decide +kernel

theorem selectedBound5543 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env5544 : List Nat := [2,4,8,16,1,64,128,256,340,1024,0,1296,8192,1180,8661,8283,1345,0,1024,8661,1296,8201,413,138,33554432,17,8401,1180,1297,8461,1284,4294967296,256,4328522076,1345,33563100]

theorem envBound5544 : H12AffineFastState.Bounded env5544 := by
  intro p hp
  have h : env5544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5543_5544 : H12AffineEnvironment.transform 8 340 env5543 = env5544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 340 env5543 == env5544) = true)

theorem identity5544 : scanCanonicalize (H12AffineFastState.compose env5544 (packedSelected [0,4,7,9,13,17] rootPS)) = affineNative (2^(24+1) ^^^ 89) := by decide +kernel

theorem selectedBound5544 : packedSelected [0,4,7,9,13,17] rootPS < 2^1333 := by decide +kernel

def env5545 : List Nat := [2,4,8,16,1,64,128,256,340,1024,0,1296,8192,1180,8661,8283,1345,0,1024,8661,1296,8201,413,138,89,17,8401,1180,1297,8461,1284,4294967296,256,4294967557,1345,8581]

theorem envBound5545 : H12AffineFastState.Bounded env5545 := by
  intro p hp
  have h : env5545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5544_5545 : H12AffineEnvironment.transform 24 89 env5544 = env5545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 89 env5544 == env5545) = true)

theorem identity5545 : scanCanonicalize (H12AffineFastState.compose env5545 (packedSelected [1,3,5,10,12,13,16] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound5545 : packedSelected [1,3,5,10,12,13,16] rootPS < 2^1333 := by decide +kernel

def env5546 : List Nat := [2,4,8,16,1,64,128,256,340,1024,0,1296,269,1180,216,342,1345,0,1024,216,1296,260,413,138,89,17,476,1180,1297,0,1284,4294967296,256,4294967557,1345,136]

theorem envBound5546 : H12AffineFastState.Bounded env5546 := by
  intro p hp
  have h : env5546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5545_5546 : H12AffineEnvironment.transform 12 269 env5545 = env5546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env5545 == env5546) = true)

theorem identity5546 : scanCanonicalize (H12AffineFastState.compose env5546 (packedSelected [0,1,2,4] rootPS)) = affineNative (2^(31+1) ^^^ 210) := by decide +kernel

theorem selectedBound5546 : packedSelected [0,1,2,4] rootPS < 2^1333 := by decide +kernel

def env5547 : List Nat := [2,4,8,16,1,64,128,256,340,1024,0,1296,269,1180,216,342,1345,0,1024,216,1296,260,413,138,89,17,476,1180,1297,0,1284,210,256,471,1345,136]

theorem envBound5547 : H12AffineFastState.Bounded env5547 := by
  intro p hp
  have h : env5547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5546_5547 : H12AffineEnvironment.transform 31 210 env5546 = env5547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 210 env5546 == env5547) = true)

theorem identity5547 : scanCanonicalize (H12AffineFastState.compose env5547 (packedSelected [1,5,10,12] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound5547 : packedSelected [1,5,10,12] rootPS < 2^1333 := by decide +kernel

def env5548 : List Nat := [2,4,8,16,1,64,128,221,137,1024,0,1229,208,1180,216,139,1180,0,1024,216,1229,217,64,138,89,17,1,1180,1228,0,1241,210,221,10,1180,136]

theorem envBound5548 : H12AffineFastState.Bounded env5548 := by
  intro p hp
  have h : env5548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5547_5548 : H12AffineEnvironment.transform 7 221 env5547 = env5548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env5547 == env5548) = true)

theorem identity5548 : scanCanonicalize (H12AffineFastState.compose env5548 (packedSelected [0,10] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound5548 : packedSelected [0,10] rootPS < 2^1333 := by decide +kernel

def env5549 : List Nat := [2,4,8,16,1,64,88,5,81,1024,0,1045,8,1092,0,83,1092,0,1024,0,1045,1,64,82,89,17,1,1092,1044,0,1025,10,5,10,1092,80]

theorem envBound5549 : H12AffineFastState.Bounded env5549 := by
  intro p hp
  have h : env5549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5548_5549 : H12AffineEnvironment.transform 6 88 env5548 = env5549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env5548 == env5549) = true)

def env5550 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8833,9006,1345,1,1024,8833,1296,8201,17665,16777216,33554432,16777402,25676,16793771,16778682,16785799,1284,4294967296,16777643,4328539584,1345,33563272]

theorem envBound5550 : H12AffineFastState.Bounded env5550 := by
  intro p hp
  have h : env5550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5539_5550 : H12AffineEnvironment.transform 17 1 env5539 = env5550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env5539 == env5550) = true)

theorem identity5550 : scanCanonicalize (H12AffineFastState.compose env5550 (packedSelected [20] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound5550 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5551 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,900,16384,261,170,1345,1,1024,261,1296,909,17665,16777216,33554432,16777402,18376,16793771,16778682,16777731,1284,4294967296,16777643,4328539584,1345,33554700]

theorem envBound5551 : H12AffineFastState.Bounded env5551 := by
  intro p hp
  have h : env5551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5550_5551 : H12AffineEnvironment.transform 12 900 env5550 = env5551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env5550 == env5551) = true)

theorem identity5551 : scanCanonicalize (H12AffineFastState.compose env5551 (packedSelected [1,3,6,9,16,18,22,23,24,25,28] rootPS)) = affineNative (2^(24+1) ^^^ 18028) := by decide +kernel

theorem selectedBound5551 : packedSelected [1,3,6,9,16,18,22,23,24,25,28] rootPS < 2^1333 := by decide +kernel

def env5552 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,900,16384,261,170,1345,1,1024,261,1296,909,17665,16777216,18028,16777402,18376,16793771,16778682,16777731,1284,4294967296,16777643,4294968236,1345,18272]

theorem envBound5552 : H12AffineFastState.Bounded env5552 := by
  intro p hp
  have h : env5552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5551_5552 : H12AffineEnvironment.transform 24 18028 env5551 = env5552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 18028 env5551 == env5552) = true)

theorem identity5552 : scanCanonicalize (H12AffineFastState.compose env5552 (packedSelected [1,5,8,9,16,17,18,21,22,23,24] rootPS)) = affineNative (2^(23+1) ^^^ 514) := by decide +kernel

theorem selectedBound5552 : packedSelected [1,5,8,9,16,17,18,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env5553 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,900,16384,261,170,1345,1,1024,261,1296,909,17665,514,18028,696,18376,17065,1976,1,1284,4294967296,937,4294968236,1345,18272]

theorem envBound5553 : H12AffineFastState.Bounded env5553 := by
  intro p hp
  have h : env5553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5552_5553 : H12AffineEnvironment.transform 23 514 env5552 = env5553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 514 env5552 == env5553) = true)

def env5554 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8833,9007,1345,262144,1024,8833,1297,8201,17665,16777216,33554432,16777402,287820,16793770,16778683,16785799,1284,4294967296,16777642,4328539584,1345,33563272]

theorem envBound5554 : H12AffineFastState.Bounded env5554 := by
  intro p hp
  have h : env5554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5538_5554 : H12AffineEnvironment.transform 11 1297 env5538 = env5554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5538 == env5554) = true)

def env5555 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8833,9007,1345,0,1024,8833,1297,8201,17665,16777216,33554432,16777402,25676,16793770,16778683,16785799,1284,4294967296,16777642,4328539584,1345,33563272]

theorem envBound5555 : H12AffineFastState.Bounded env5555 := by
  intro p hp
  have h : env5555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5554_5555 : H12AffineEnvironment.transform 17 0 env5554 = env5555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env5554 == env5555) = true)

theorem identity5555 : scanCanonicalize (H12AffineFastState.compose env5555 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 18274) := by decide +kernel

theorem selectedBound5555 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5556 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8833,9007,1345,0,1024,8833,1297,8201,17665,18274,33554432,18392,25676,1992,17113,26341,1284,4294967296,18120,4328539584,1345,33563272]

theorem envBound5556 : H12AffineFastState.Bounded env5556 := by
  intro p hp
  have h : env5556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5555_5556 : H12AffineEnvironment.transform 23 18274 env5555 = env5556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 18274 env5555 == env5556) = true)

theorem identity5556 : scanCanonicalize (H12AffineFastState.compose env5556 (packedSelected [1,3,5,6,8,10,17,21,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound5556 : packedSelected [1,3,5,6,8,10,17,21,25,26] rootPS < 2^1333 := by decide +kernel

def env5557 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1992,8833,9007,1345,0,1024,8833,1297,8201,713,170,33554432,16,9092,1992,1297,8493,1284,4294967296,256,4328522248,1345,33563272]

theorem envBound5557 : H12AffineFastState.Bounded env5557 := by
  intro p hp
  have h : env5557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5556_5557 : H12AffineEnvironment.transform 13 1992 env5556 = env5557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env5556 == env5557) = true)

theorem identity5557 : scanCanonicalize (H12AffineFastState.compose env5557 (packedSelected [8,10,13,15] rootPS)) = affineNative (2^(7+1) ^^^ 140) := by decide +kernel

theorem selectedBound5557 : packedSelected [8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env5558 : List Nat := [2,4,8,16,32,64,128,140,512,1024,0,1181,8192,1604,8833,8867,1229,0,1024,8833,1181,8201,713,170,33554432,16,8712,1604,1181,8353,1160,4294967296,140,4328522248,1229,33563272]

theorem envBound5558 : H12AffineFastState.Bounded env5558 := by
  intro p hp
  have h : env5558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5557_5558 : H12AffineEnvironment.transform 7 140 env5557 = env5558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env5557 == env5558) = true)

theorem identity5558 : scanCanonicalize (H12AffineFastState.compose env5558 (packedSelected [1,3,4,8,10,12,16,17,22] rootPS)) = affineNative (2^(24+1) ^^^ 8361) := by decide +kernel

theorem selectedBound5558 : packedSelected [1,3,4,8,10,12,16,17,22] rootPS < 2^1333 := by decide +kernel

def env5559 : List Nat := [2,4,8,16,32,64,128,140,512,1024,0,1181,8192,1604,8833,8867,1229,0,1024,8833,1181,8201,713,170,8361,16,8712,1604,1181,8353,1160,4294967296,140,4294976161,1229,545]

theorem envBound5559 : H12AffineFastState.Bounded env5559 := by
  intro p hp
  have h : env5559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5558_5559 : H12AffineEnvironment.transform 24 8361 env5558 = env5559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8361 env5558 == env5559) = true)

theorem identity5559 : scanCanonicalize (H12AffineFastState.compose env5559 (packedSelected [1,3,5,10,12,17] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound5559 : packedSelected [1,3,5,10,12,17] rootPS < 2^1333 := by decide +kernel

def env5560 : List Nat := [2,4,8,16,32,64,128,140,136,1024,0,1181,8192,1228,8201,8235,1229,0,1024,8201,1181,8201,65,170,8361,16,8320,1228,1181,8353,1160,4294967296,140,4294975529,1229,169]

theorem envBound5560 : H12AffineFastState.Bounded env5560 := by
  intro p hp
  have h : env5560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5559_5560 : H12AffineEnvironment.transform 8 136 env5559 = env5560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env5559 == env5560) = true)

theorem identity5560 : scanCanonicalize (H12AffineFastState.compose env5560 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5560 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5561 : List Nat := [2,4,8,16,32,16,128,140,136,1024,0,1181,8192,1180,8201,8235,1181,0,1024,8201,1181,8201,17,170,8361,16,8320,1180,1181,8353,1160,4294967296,140,4294975529,1181,169]

theorem envBound5561 : H12AffineFastState.Bounded env5561 := by
  intro p hp
  have h : env5561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5560_5561 : H12AffineEnvironment.transform 5 16 env5560 = env5561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5560 == env5561) = true)

theorem identity5561 : scanCanonicalize (H12AffineFastState.compose env5561 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5561 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5562 : List Nat := [2,4,8,16,0,16,128,140,136,1024,0,1181,8192,1180,8201,8203,1181,0,1024,8201,1181,8201,17,138,8329,16,8320,1180,1181,8321,1160,4294967296,140,4294975497,1181,137]

theorem envBound5562 : H12AffineFastState.Bounded env5562 := by
  intro p hp
  have h : env5562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5561_5562 : H12AffineEnvironment.transform 4 0 env5561 = env5562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5561 == env5562) = true)

theorem identity5562 : scanCanonicalize (H12AffineFastState.compose env5562 (packedSelected [1] rootPS)) = affineNative (2^(12+1) ^^^ 129) := by decide +kernel

theorem selectedBound5562 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5563 : List Nat := [2,4,8,16,0,16,128,140,136,1024,0,1181,129,1180,136,138,1181,0,1024,136,1181,136,17,138,8,16,1,1180,1181,0,1160,4294967296,140,4294967432,1181,137]

theorem envBound5563 : H12AffineFastState.Bounded env5563 := by
  intro p hp
  have h : env5563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5562_5563 : H12AffineEnvironment.transform 12 129 env5562 = env5563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 129 env5562 == env5563) = true)

theorem identity5563 : scanCanonicalize (H12AffineFastState.compose env5563 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound5563 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5564 : List Nat := [2,4,8,16,0,16,128,140,136,1024,0,1181,129,1180,136,138,1181,0,1024,136,1181,136,17,138,8,16,1,1180,1181,0,1160,11,140,131,1181,137]

theorem envBound5564 : H12AffineFastState.Bounded env5564 := by
  intro p hp
  have h : env5564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5563_5564 : H12AffineEnvironment.transform 31 11 env5563 = env5564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env5563 == env5564) = true)

theorem identity5564 : scanCanonicalize (H12AffineFastState.compose env5564 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound5564 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5565 : List Nat := [2,4,8,16,0,16,9,5,1,1024,0,1044,8,1045,1,3,1044,0,1024,1,1044,1,17,3,8,16,1,1045,1044,0,1025,11,5,10,1044,0]

theorem envBound5565 : H12AffineFastState.Bounded env5565 := by
  intro p hp
  have h : env5565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5564_5565 : H12AffineEnvironment.transform 6 9 env5564 = env5565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env5564 == env5565) = true)

theorem identity5565 : scanCanonicalize (H12AffineFastState.compose env5565 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound5565 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5566 : List Nat := [2,4,8,0,0,0,9,5,1,1024,0,1028,8,1029,1,3,1028,0,1024,1,1028,1,1,3,8,0,1,1029,1028,0,1025,11,5,10,1028,0]

theorem envBound5566 : H12AffineFastState.Bounded env5566 := by
  intro p hp
  have h : env5566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5565_5566 : H12AffineEnvironment.transform 3 0 env5565 = env5566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env5565 == env5566) = true)

def env5567 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8833,9007,1345,1,1024,8833,1297,8201,17665,16777216,33554432,16777402,25677,16793770,16778683,16785799,1284,4294967296,16777642,4328539584,1345,33563272]

theorem envBound5567 : H12AffineFastState.Bounded env5567 := by
  intro p hp
  have h : env5567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5554_5567 : H12AffineEnvironment.transform 17 1 env5554 = env5567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env5554 == env5567) = true)

theorem identity5567 : scanCanonicalize (H12AffineFastState.compose env5567 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 9007) := by decide +kernel

theorem selectedBound5567 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5568 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8833,9007,1345,1,1024,8833,1297,8201,17665,9007,33554432,9109,25677,25477,9876,680,1284,4294967296,8837,4328539584,1345,33563272]

theorem envBound5568 : H12AffineFastState.Bounded env5568 := by
  intro p hp
  have h : env5568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5567_5568 : H12AffineEnvironment.transform 23 9007 env5567 = env5568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 9007 env5567 == env5568) = true)

theorem identity5568 : scanCanonicalize (H12AffineFastState.compose env5568 (packedSelected [1,3,6,10,12,13,15,16,21,23,24,25,26,28,32] rootPS)) = affineNative (2^(13+1) ^^^ 9324) := by decide +kernel

theorem selectedBound5568 : packedSelected [1,3,6,10,12,13,15,16,21,23,24,25,26,28,32] rootPS < 2^1333 := by decide +kernel

def env5569 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,9324,8833,9007,1345,1,1024,8833,1297,8201,8557,9007,33554432,9109,33,2025,9876,680,1284,4294967296,8837,4328530348,1345,33563272]

theorem envBound5569 : H12AffineFastState.Bounded env5569 := by
  intro p hp
  have h : env5569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5568_5569 : H12AffineEnvironment.transform 13 9324 env5568 = env5569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9324 env5568 == env5569) = true)

theorem identity5569 : scanCanonicalize (H12AffineFastState.compose env5569 (packedSelected [6,16,18,25] rootPS)) = affineNative (2^(24+1) ^^^ 389) := by decide +kernel

theorem selectedBound5569 : packedSelected [6,16,18,25] rootPS < 2^1333 := by decide +kernel

def env5570 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,9324,8833,9007,1345,1,1024,8833,1297,8201,8557,9007,389,9109,33,2025,9876,680,1284,4294967296,8837,4294975529,1345,8973]

theorem envBound5570 : H12AffineFastState.Bounded env5570 := by
  intro p hp
  have h : env5570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5569_5570 : H12AffineEnvironment.transform 24 389 env5569 = env5570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 389 env5569 == env5570) = true)

theorem identity5570 : scanCanonicalize (H12AffineFastState.compose env5570 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound5570 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5571 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,901,2025,260,170,1345,1,1024,260,1297,908,744,170,389,16,33,2025,1297,680,1284,4294967296,256,4294968236,1345,136]

theorem envBound5571 : H12AffineFastState.Bounded env5571 := by
  intro p hp
  have h : env5571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5570_5571 : H12AffineEnvironment.transform 12 901 env5570 = env5571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env5570 == env5571) = true)

theorem identity5571 : scanCanonicalize (H12AffineFastState.compose env5571 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5571 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env5572 : List Nat := [2,4,8,16,0,64,128,256,512,1024,0,1297,901,1993,260,138,1345,1,1024,260,1297,908,712,138,389,16,1,1993,1297,648,1284,4294967296,256,4294968204,1345,136]

theorem envBound5572 : H12AffineFastState.Bounded env5572 := by
  intro p hp
  have h : env5572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5571_5572 : H12AffineEnvironment.transform 4 0 env5571 = env5572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5571 == env5572) = true)

theorem identity5572 : scanCanonicalize (H12AffineFastState.compose env5572 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5572 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env5573 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,1297,268,1344,260,138,1345,1,1024,260,1297,261,65,138,389,16,1,1344,1297,1,1284,4294967296,256,4294967557,1345,136]

theorem envBound5573 : H12AffineFastState.Bounded env5573 := by
  intro p hp
  have h : env5573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5572_5573 : H12AffineEnvironment.transform 8 137 env5572 = env5573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5572 == env5573) = true)

theorem identity5573 : scanCanonicalize (H12AffineFastState.compose env5573 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound5573 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5574 : List Nat := [2,4,8,16,0,64,128,221,137,1024,0,1228,209,1181,217,138,1180,1,1024,217,1228,216,65,138,88,16,1,1181,1228,1,1241,4294967296,221,4294967512,1180,136]

theorem envBound5574 : H12AffineFastState.Bounded env5574 := by
  intro p hp
  have h : env5574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5573_5574 : H12AffineEnvironment.transform 7 221 env5573 = env5574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env5573 == env5574) = true)

theorem identity5574 : scanCanonicalize (H12AffineFastState.compose env5574 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5574 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5575 : List Nat := [2,4,8,16,0,64,128,221,137,1024,0,1228,209,1181,217,138,1180,1,1024,217,1228,216,65,138,88,16,1,1181,1228,1,1241,90,221,130,1180,136]

theorem envBound5575 : H12AffineFastState.Bounded env5575 := by
  intro p hp
  have h : env5575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5574_5575 : H12AffineEnvironment.transform 31 90 env5574 = env5575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5574 == env5575) = true)

def env5576 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8201,17665,16777216,33554432,16856709,291165,16868228,16852629,16785798,1284,4294967296,16851588,4328616959,1345,33563272]

theorem envBound5576 : H12AffineFastState.Bounded env5576 := by
  intro p hp
  have h : env5576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5536_5576 : H12AffineEnvironment.transform 10 1 env5536 = env5576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5536 == env5576) = true)

theorem identity5576 : scanCanonicalize (H12AffineFastState.compose env5576 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 13855) := by decide +kernel

theorem selectedBound5576 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5577 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8201,17665,13855,33554432,65690,291165,87451,69770,6041,1284,4294967296,70811,4328616959,1345,33563272]

theorem envBound5577 : H12AffineFastState.Bounded env5577 := by
  intro p hp
  have h : env5577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5576_5577 : H12AffineEnvironment.transform 23 13855 env5576 = env5577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 13855 env5576 == env5577) = true)

def env5578 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,262144,1024,8832,1296,8201,17665,8975,33554432,65690,287821,82059,66970,649,1284,4294967296,65931,4328613615,1345,33563272]

theorem envBound5578 : H12AffineFastState.Bounded env5578 := by
  intro p hp
  have h : env5578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5577_5578 : H12AffineEnvironment.transform 11 1296 env5577 = env5578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5577 == env5578) = true)

def env5579 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,0,1024,8832,1296,8201,17665,8975,33554432,65690,25677,82059,66970,649,1284,4294967296,65931,4328613615,1345,33563272]

theorem envBound5579 : H12AffineFastState.Bounded env5579 := by
  intro p hp
  have h : env5579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5578_5579 : H12AffineEnvironment.transform 17 0 env5578 = env5579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env5578 == env5579) = true)

theorem identity5579 : scanCanonicalize (H12AffineFastState.compose env5579 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 26223) := by decide +kernel

theorem selectedBound5579 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5580 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,26223,1345,0,1024,8832,1296,8201,17665,8975,33554432,26357,25677,9956,25589,649,1284,4294967296,26596,4328521856,1345,33563272]

theorem envBound5580 : H12AffineFastState.Bounded env5580 := by
  intro p hp
  have h : env5580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5579_5580 : H12AffineEnvironment.transform 15 26223 env5579 = env5580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26223 env5579 == env5580) = true)

theorem identity5580 : scanCanonicalize (H12AffineFastState.compose env5580 (packedSelected [1,3,5,6,8,9,10,17,18,21,22,23,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1376) := by decide +kernel

theorem selectedBound5580 : packedSelected [1,3,5,6,8,9,10,17,18,21,22,23,25,26] rootPS < 2^1333 := by decide +kernel

def env5581 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1376,8832,8975,1345,0,1024,8832,1296,8201,97,8975,33554432,9109,8493,9956,9877,649,1284,4294967296,8836,4328521856,1345,33563272]

theorem envBound5581 : H12AffineFastState.Bounded env5581 := by
  intro p hp
  have h : env5581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5580_5581 : H12AffineEnvironment.transform 13 1376 env5580 = env5581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1376 env5580 == env5581) = true)

theorem identity5581 : scanCanonicalize (H12AffineFastState.compose env5581 (packedSelected [1,3,5,8,12,13,15,16,17] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound5581 : packedSelected [1,3,5,8,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env5582 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1376,260,139,1345,0,1024,260,1296,909,97,139,33554432,17,681,1376,1297,649,1284,4294967296,256,4328521856,1345,33554700]

theorem envBound5582 : H12AffineFastState.Bounded env5582 := by
  intro p hp
  have h : env5582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5581_5582 : H12AffineEnvironment.transform 12 900 env5581 = env5582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env5581 == env5582) = true)

def env5583 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,65536,1345,1,1024,8832,1296,8201,17665,8975,33554432,65690,25676,82059,66970,649,1284,4294967296,65931,4328613615,1345,33563272]

theorem envBound5583 : H12AffineFastState.Bounded env5583 := by
  intro p hp
  have h : env5583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5578_5583 : H12AffineEnvironment.transform 17 1 env5578 = env5583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env5578 == env5583) = true)

theorem identity5583 : scanCanonicalize (H12AffineFastState.compose env5583 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound5583 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5584 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,547,1345,1,1024,8832,1296,8201,17665,8975,33554432,697,25676,17064,1977,649,1284,4294967296,936,4328547532,1345,33563272]

theorem envBound5584 : H12AffineFastState.Bounded env5584 := by
  intro p hp
  have h : env5584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5583_5584 : H12AffineEnvironment.transform 15 547 env5583 = env5584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env5583 == env5584) = true)

theorem identity5584 : scanCanonicalize (H12AffineFastState.compose env5584 (packedSelected [1,3,6,24,25,28] rootPS)) = affineNative (2^(24+1) ^^^ 781) := by decide +kernel

theorem selectedBound5584 : packedSelected [1,3,6,24,25,28] rootPS < 2^1333 := by decide +kernel

def env5585 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8832,547,1345,1,1024,8832,1296,8201,17665,8975,781,697,25676,17064,1977,649,1284,4294967296,936,4294993857,1345,8581]

theorem envBound5585 : H12AffineFastState.Bounded env5585 := by
  intro p hp
  have h : env5585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5584_5585 : H12AffineEnvironment.transform 24 781 env5584 = env5585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 781 env5584 == env5585) = true)

theorem identity5585 : scanCanonicalize (H12AffineFastState.compose env5585 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 2024) := by decide +kernel

theorem selectedBound5585 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5586 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,2024,8832,547,1345,1,1024,8832,1296,8201,745,8975,781,697,9124,1344,1977,649,1284,4294967296,936,4294975529,1345,8581]

theorem envBound5586 : H12AffineFastState.Bounded env5586 := by
  intro p hp
  have h : env5586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5585_5586 : H12AffineEnvironment.transform 13 2024 env5585 = env5586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2024 env5585 == env5586) = true)

theorem identity5586 : scanCanonicalize (H12AffineFastState.compose env5586 (packedSelected [1,3,5,8,12,13,15,16,21] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound5586 : packedSelected [1,3,5,8,12,13,15,16,21] rootPS < 2^1333 := by decide +kernel

def env5587 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1296,8192,1344,8232,139,1345,1,1024,8232,1296,8201,65,8615,421,17,8460,1344,1297,33,1284,4294967296,256,4294975529,1345,8581]

theorem envBound5587 : H12AffineFastState.Bounded env5587 := by
  intro p hp
  have h : env5587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5586_5587 : H12AffineEnvironment.transform 8 168 env5586 = env5587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env5586 == env5587) = true)

theorem identity5587 : scanCanonicalize (H12AffineFastState.compose env5587 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound5587 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5588 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1296,269,1344,293,139,1345,1,1024,293,1296,260,65,170,421,17,1,1344,1297,33,1284,4294967296,256,4294967588,1345,136]

theorem envBound5588 : H12AffineFastState.Bounded env5588 := by
  intro p hp
  have h : env5588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5587_5588 : H12AffineEnvironment.transform 12 269 env5587 = env5588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env5587 == env5588) = true)

theorem identity5588 : scanCanonicalize (H12AffineFastState.compose env5588 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 172) := by decide +kernel

theorem selectedBound5588 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5589 : List Nat := [2,4,8,16,32,64,128,172,168,1024,1,1212,161,1260,137,139,1261,1,1024,137,1212,168,65,170,9,17,1,1260,1213,33,1192,4294967296,172,4294967432,1261,136]

theorem envBound5589 : H12AffineFastState.Bounded env5589 := by
  intro p hp
  have h : env5589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5588_5589 : H12AffineEnvironment.transform 7 172 env5588 = env5589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 172 env5588 == env5589) = true)

theorem identity5589 : scanCanonicalize (H12AffineFastState.compose env5589 (packedSelected [2,4,7] rootPS)) = affineNative (2^(31+1) ^^^ 243) := by decide +kernel

theorem selectedBound5589 : packedSelected [2,4,7] rootPS < 2^1333 := by decide +kernel

def env5590 : List Nat := [2,4,8,16,32,64,128,172,168,1024,1,1212,161,1260,137,139,1261,1,1024,137,1212,168,65,170,9,17,1,1260,1213,33,1192,243,172,123,1261,136]

theorem envBound5590 : H12AffineFastState.Bounded env5590 := by
  intro p hp
  have h : env5590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5589_5590 : H12AffineEnvironment.transform 31 243 env5589 = env5590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 243 env5589 == env5590) = true)

theorem identity5590 : scanCanonicalize (H12AffineFastState.compose env5590 (packedSelected [8] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5590 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env5591 : List Nat := [2,4,8,16,0,64,128,140,136,1024,1,1180,129,1228,137,139,1229,1,1024,137,1180,136,65,138,9,17,1,1228,1181,1,1160,211,140,91,1229,136]

theorem envBound5591 : H12AffineFastState.Bounded env5591 := by
  intro p hp
  have h : env5591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5590_5591 : H12AffineEnvironment.transform 4 0 env5590 = env5591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5590 == env5591) = true)

theorem identity5591 : scanCanonicalize (H12AffineFastState.compose env5591 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 81) := by decide +kernel

theorem selectedBound5591 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5592 : List Nat := [2,4,8,16,0,64,81,93,89,1024,1,1101,80,1053,88,90,1052,1,1024,88,1101,89,65,91,9,17,1,1053,1100,1,1113,2,93,91,1052,89]

theorem envBound5592 : H12AffineFastState.Bounded env5592 := by
  intro p hp
  have h : env5592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5591_5592 : H12AffineEnvironment.transform 6 81 env5591 = env5592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 81 env5591 == env5592) = true)

theorem identity5592 : scanCanonicalize (H12AffineFastState.compose env5592 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 24) := by decide +kernel

theorem selectedBound5592 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5593 : List Nat := [2,4,8,16,0,24,9,5,1,1024,1,1045,8,1053,0,2,1052,1,1024,0,1045,1,25,3,9,17,1,1053,1044,1,1025,2,5,3,1052,1]

theorem envBound5593 : H12AffineFastState.Bounded env5593 := by
  intro p hp
  have h : env5593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5592_5593 : H12AffineEnvironment.transform 5 24 env5592 = env5593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 24 env5592 == env5593) = true)

theorem identity5593 : scanCanonicalize (H12AffineFastState.compose env5593 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound5593 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5594 : List Nat := [2,4,0,16,0,16,1,5,1,1024,1,1045,0,1045,0,2,1044,1,1024,0,1045,1,17,3,1,17,1,1045,1044,1,1025,2,5,3,1044,1]

theorem envBound5594 : H12AffineFastState.Bounded env5594 := by
  intro p hp
  have h : env5594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5593_5594 : H12AffineEnvironment.transform 2 0 env5593 = env5594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5593 == env5594) = true)

theorem identity5594 : scanCanonicalize (H12AffineFastState.compose env5594 (packedSelected [6] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5594 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5595 : List Nat := [1,4,0,16,0,16,1,5,1,1024,1,1045,0,1045,0,1,1044,1,1024,0,1045,1,17,0,1,17,1,1045,1044,1,1025,1,5,0,1044,1]

theorem envBound5595 : H12AffineFastState.Bounded env5595 := by
  intro p hp
  have h : env5595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5594_5595 : H12AffineEnvironment.transform 0 1 env5594 = env5595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5594 == env5595) = true)

def env5596 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,262144,1024,8832,1297,8201,17665,8974,33554432,65690,287820,82058,66971,648,1284,4294967296,65930,4328613614,1345,33563272]

theorem envBound5596 : H12AffineFastState.Bounded env5596 := by
  intro p hp
  have h : env5596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5577_5596 : H12AffineEnvironment.transform 11 1297 env5577 = env5596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5577 == env5596) = true)

def env5597 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8201,17665,8974,33554432,65690,25676,82058,66971,648,1284,4294967296,65930,4328613614,1345,33563272]

theorem envBound5597 : H12AffineFastState.Bounded env5597 := by
  intro p hp
  have h : env5597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5596_5597 : H12AffineEnvironment.transform 17 0 env5596 = env5597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env5596 == env5597) = true)

theorem identity5597 : scanCanonicalize (H12AffineFastState.compose env5597 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 9957) := by decide +kernel

theorem selectedBound5597 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5598 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9957,8832,65536,1345,0,1024,8832,1297,8201,9188,8974,33554432,65690,681,75375,66971,648,1284,4294967296,65930,4328587275,1345,33563272]

theorem envBound5598 : H12AffineFastState.Bounded env5598 := by
  intro p hp
  have h : env5598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5597_5598 : H12AffineEnvironment.transform 13 9957 env5597 = env5598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9957 env5597 == env5598) = true)

theorem identity5598 : scanCanonicalize (H12AffineFastState.compose env5598 (packedSelected [1,3,5,6,8,9,10,12,13,15,18,21,22,23,25,31] rootPS)) = affineNative (2^(24+1) ^^^ 74411) := by decide +kernel

theorem selectedBound5598 : packedSelected [1,3,5,6,8,9,10,12,13,15,18,21,22,23,25,31] rootPS < 2^1333 := by decide +kernel

def env5599 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9957,8832,65536,1345,0,1024,8832,1297,8201,9188,8974,74411,65690,681,75375,66971,648,1284,4294967296,65930,4294976160,1345,65571]

theorem envBound5599 : H12AffineFastState.Bounded env5599 := by
  intro p hp
  have h : env5599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5598_5599 : H12AffineEnvironment.transform 24 74411 env5598 = env5599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 74411 env5598 == env5599) = true)

theorem identity5599 : scanCanonicalize (H12AffineFastState.compose env5599 (packedSelected [0,3,4,7,12,13,15,16,18,21,22,23,24] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5599 : packedSelected [0,3,4,7,12,13,15,16,18,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env5600 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,9324,8201,65536,1345,0,1024,8201,1297,8201,8557,8583,73762,65690,32,74982,66971,1,1284,4294967296,65930,4294975529,1345,65571]

theorem envBound5600 : H12AffineFastState.Bounded env5600 := by
  intro p hp
  have h : env5600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5599_5600 : H12AffineEnvironment.transform 8 137 env5599 = env5600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5599 == env5600) = true)

theorem identity5600 : scanCanonicalize (H12AffineFastState.compose env5600 (packedSelected [18] rootPS)) = affineNative (2^(15+1) ^^^ 8583) := by decide +kernel

theorem selectedBound5600 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5601 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,9324,8201,8583,1345,0,1024,8201,1297,8201,8557,8583,421,8477,32,1377,9244,1,1284,4294967296,8205,4294975529,1345,8612]

theorem envBound5601 : H12AffineFastState.Bounded env5601 := by
  intro p hp
  have h : env5601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5600_5601 : H12AffineEnvironment.transform 15 8583 env5600 = env5601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8583 env5600 == env5601) = true)

theorem identity5601 : scanCanonicalize (H12AffineFastState.compose env5601 (packedSelected [0,1,3,4,7,12,13,15,21,22] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound5601 : packedSelected [0,1,3,4,7,12,13,15,21,22] rootPS < 2^1333 := by decide +kernel

def env5602 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8,1124,1,399,1345,0,1024,1,1297,1,357,399,421,277,32,1377,1044,1,1284,4294967296,5,4294967329,1345,428]

theorem envBound5602 : H12AffineFastState.Bounded env5602 := by
  intro p hp
  have h : env5602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5601_5602 : H12AffineEnvironment.transform 12 8 env5601 = env5602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env5601 == env5602) = true)

theorem identity5602 : scanCanonicalize (H12AffineFastState.compose env5602 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5602 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env5603 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,1044,8,1124,1,138,1092,0,1024,1,1044,1,96,138,160,16,32,1124,1044,1,1025,4294967296,5,4294967329,1092,169]

theorem envBound5603 : H12AffineFastState.Bounded env5603 := by
  intro p hp
  have h : env5603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5602_5603 : H12AffineEnvironment.transform 7 5 env5602 = env5603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5602 == env5603) = true)

theorem identity5603 : scanCanonicalize (H12AffineFastState.compose env5603 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound5603 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5604 : List Nat := [2,4,8,16,32,64,121,5,112,1024,1,1044,8,1124,1,115,1092,0,1024,1,1044,1,96,115,89,16,32,1124,1044,1,1025,4294967296,5,4294967329,1092,80]

theorem envBound5604 : H12AffineFastState.Bounded env5604 := by
  intro p hp
  have h : env5604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5603_5604 : H12AffineEnvironment.transform 6 121 env5603 = env5604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env5603 == env5604) = true)

theorem identity5604 : scanCanonicalize (H12AffineFastState.compose env5604 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5604 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5605 : List Nat := [2,4,8,16,1,64,88,5,81,1024,1,1044,8,1093,1,82,1092,0,1024,1,1044,1,65,82,89,16,1,1093,1044,1,1025,4294967296,5,4294967296,1092,80]

theorem envBound5605 : H12AffineFastState.Bounded env5605 := by
  intro p hp
  have h : env5605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5604_5605 : H12AffineEnvironment.transform 4 1 env5604 = env5605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5604 == env5605) = true)

theorem identity5605 : scanCanonicalize (H12AffineFastState.compose env5605 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5605 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5606 : List Nat := [2,4,8,16,1,64,88,5,81,1024,1,1044,8,1093,1,82,1092,0,1024,1,1044,1,65,82,89,16,1,1093,1044,1,1025,90,5,90,1092,80]

theorem envBound5606 : H12AffineFastState.Bounded env5606 := by
  intro p hp
  have h : env5606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5605_5606 : H12AffineEnvironment.transform 31 90 env5605 = env5606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5605 == env5606) = true)

theorem identity5606 : scanCanonicalize (H12AffineFastState.compose env5606 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound5606 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5607 : List Nat := [2,4,8,16,1,10,18,5,27,1024,1,1044,8,1039,1,24,1038,0,1024,1,1044,1,11,24,19,16,1,1039,1044,1,1025,16,5,16,1038,26]

theorem envBound5607 : H12AffineFastState.Bounded env5607 := by
  intro p hp
  have h : env5607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5606_5607 : H12AffineEnvironment.transform 5 10 env5606 = env5607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env5606 == env5607) = true)

def leafEnv5607 : List Nat := [2,4,8,16,1,10,18,5,27,1024,1,1044,8,1039,1,24,1038,0,1024,1,1044,1,11,24,1025,19,1,16,1,1039,1044,1,1025,16,5,16,4,3,1038,26,0,1044,1]

def active5607 : List Nat := [0,1,2,3,9]

def tree5607 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5607 : H12WitnessSearch.Good tree5607 := H12GlobalWitnessIndex.good

theorem leafIdentity5607 : H12AffineFastState.composeSystem env5607 rootObs = leafEnv5607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5607 rootObs == leafEnv5607) = true)

theorem terminalChecked5607 : H12PackedTerminal.terminalCheckFast leafEnv5607 active5607 tree5607 = true := by decide +kernel

def env5608 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8201,17665,8974,33554432,65690,25677,82058,66971,648,1284,4294967296,65930,4328613614,1345,33563272]

theorem envBound5608 : H12AffineFastState.Bounded env5608 := by
  intro p hp
  have h : env5608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5596_5608 : H12AffineEnvironment.transform 17 1 env5596 = env5608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env5596 == env5608) = true)

theorem identity5608 : scanCanonicalize (H12AffineFastState.compose env5608 (packedSelected [20] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound5608 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5609 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1297,8192,16384,8232,65536,1345,1,1024,8232,1297,8201,17665,8614,33554432,65690,25677,82058,66971,32,1284,4294967296,65930,4328612934,1345,33562656]

theorem envBound5609 : H12AffineFastState.Bounded env5609 := by
  intro p hp
  have h : env5609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5608_5609 : H12AffineEnvironment.transform 8 168 env5608 = env5609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env5608 == env5609) = true)

theorem identity5609 : scanCanonicalize (H12AffineFastState.compose env5609 (packedSelected [1,6,10,25,26,28] rootPS)) = affineNative (2^(15+1) ^^^ 17867) := by decide +kernel

theorem selectedBound5609 : packedSelected [1,6,10,25,26,28] rootPS < 2^1333 := by decide +kernel

def env5610 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1297,8192,16384,8232,17867,1345,1,1024,8232,1297,8201,17665,8614,33554432,17745,25677,1345,16464,32,1284,4294967296,17473,4328530317,1345,33562656]

theorem envBound5610 : H12AffineFastState.Bounded env5610 := by
  intro p hp
  have h : env5610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5609_5610 : H12AffineEnvironment.transform 15 17867 env5609 = env5610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 17867 env5609 == env5610) = true)

theorem identity5610 : scanCanonicalize (H12AffineFastState.compose env5610 (packedSelected [3,12,13,15,16,18,21,24] rootPS)) = affineNative (2^(24+1) ^^^ 17637) := by decide +kernel

theorem selectedBound5610 : packedSelected [3,12,13,15,16,18,21,24] rootPS < 2^1333 := by decide +kernel

def env5611 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1297,8192,16384,8232,17867,1345,1,1024,8232,1297,8201,17665,8614,17637,17745,25677,1345,16464,32,1284,4294967296,17473,4294993256,1345,25797]

theorem envBound5611 : H12AffineFastState.Bounded env5611 := by
  intro p hp
  have h : env5611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5610_5611 : H12AffineEnvironment.transform 24 17637 env5610 = env5611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17637 env5610 == env5611) = true)

theorem identity5611 : scanCanonicalize (H12AffineFastState.compose env5611 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound5611 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env5612 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1297,269,16384,293,17867,1345,1,1024,293,1297,260,17665,171,17637,17745,17728,1345,16464,32,1284,4294967296,17473,4294984805,1345,17864]

theorem envBound5612 : H12AffineFastState.Bounded env5612 := by
  intro p hp
  have h : env5612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5611_5612 : H12AffineEnvironment.transform 12 269 env5611 = env5612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env5611 == env5612) = true)

theorem identity5612 : scanCanonicalize (H12AffineFastState.compose env5612 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5612 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env5613 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,269,16384,260,17867,1345,1,1024,260,1297,260,17665,138,17604,17745,17728,1345,16464,1,1284,4294967296,17473,4294984772,1345,17864]

theorem envBound5613 : H12AffineFastState.Bounded env5613 := by
  intro p hp
  have h : env5613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5612_5613 : H12AffineEnvironment.transform 4 1 env5612 = env5613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5612 == env5613) = true)

theorem identity5613 : scanCanonicalize (H12AffineFastState.compose env5613 (packedSelected [0,2,3,4,5,6,8,13] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound5613 : packedSelected [0,2,3,4,5,6,8,13] rootPS < 2^1333 := by decide +kernel

def env5614 : List Nat := [2,4,8,16,1,64,2,256,11,1024,1,1297,269,16384,260,17737,1345,1,1024,260,1297,260,17665,8,17478,17745,17728,1345,16464,1,1284,4294967296,17473,4294984772,1345,17738]

theorem envBound5614 : H12AffineFastState.Bounded env5614 := by
  intro p hp
  have h : env5614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5613_5614 : H12AffineEnvironment.transform 6 2 env5613 = env5614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env5613 == env5614) = true)

theorem identity5614 : scanCanonicalize (H12AffineFastState.compose env5614 (packedSelected [2,4,5,6,7,8] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5614 : packedSelected [2,4,5,6,7,8] rootPS < 2^1333 := by decide +kernel

def env5615 : List Nat := [2,4,8,16,1,64,2,5,11,1024,1,1044,8,16384,1,17484,1092,1,1024,1,1044,1,17412,8,17478,17492,17477,1092,16464,1,1025,4294967296,17473,4294984772,1092,17487]

theorem envBound5615 : H12AffineFastState.Bounded env5615 := by
  intro p hp
  have h : env5615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5614_5615 : H12AffineEnvironment.transform 7 5 env5614 = env5615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5614 == env5615) = true)

theorem identity5615 : scanCanonicalize (H12AffineFastState.compose env5615 (packedSelected [1,2,3] rootPS)) = affineNative (2^(31+1) ^^^ 17428) := by decide +kernel

theorem selectedBound5615 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env5616 : List Nat := [2,4,8,16,1,64,2,5,11,1024,1,1044,8,16384,1,17484,1092,1,1024,1,1044,1,17412,8,17478,17492,17477,1092,16464,1,1025,17428,17473,80,1092,17487]

theorem envBound5616 : H12AffineFastState.Bounded env5616 := by
  intro p hp
  have h : env5616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5615_5616 : H12AffineEnvironment.transform 31 17428 env5615 = env5616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 17428 env5615 == env5616) = true)

theorem identity5616 : scanCanonicalize (H12AffineFastState.compose env5616 (packedSelected [0,1,4] rootPS)) = affineNative (2^(13+1) ^^^ 1054) := by decide +kernel

theorem selectedBound5616 : packedSelected [0,1,4] rootPS < 2^1333 := by decide +kernel

def env5617 : List Nat := [2,4,8,16,1,64,2,5,11,1024,1,1044,8,1054,1,82,1092,1,1024,1,1044,1,26,8,88,74,91,1092,1102,1,1025,10,95,80,1092,81]

theorem envBound5617 : H12AffineFastState.Bounded env5617 := by
  intro p hp
  have h : env5617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5616_5617 : H12AffineEnvironment.transform 13 1054 env5616 = env5617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1054 env5616 == env5617) = true)

theorem identity5617 : scanCanonicalize (H12AffineFastState.compose env5617 (packedSelected [2,5] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound5617 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env5618 : List Nat := [2,4,8,16,1,26,2,5,11,1024,1,1044,8,1054,1,8,1054,1,1024,1,1044,1,26,8,2,16,1,1054,1044,1,1025,10,5,10,1054,11]

theorem envBound5618 : H12AffineFastState.Bounded env5618 := by
  intro p hp
  have h : env5618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5617_5618 : H12AffineEnvironment.transform 5 26 env5617 = env5618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env5617 == env5618) = true)

theorem identity5618 : scanCanonicalize (H12AffineFastState.compose env5618 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound5618 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5619 : List Nat := [2,4,0,16,1,18,2,5,3,1024,1,1044,0,1046,1,0,1046,1,1024,1,1044,1,18,0,2,16,1,1046,1044,1,1025,2,5,2,1046,3]

theorem envBound5619 : H12AffineFastState.Bounded env5619 := by
  intro p hp
  have h : env5619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5618_5619 : H12AffineEnvironment.transform 2 0 env5618 = env5619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5618 == env5619) = true)

theorem identity5619 : scanCanonicalize (H12AffineFastState.compose env5619 (packedSelected [6] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5619 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5620 : List Nat := [0,4,0,16,1,16,0,5,1,1024,1,1044,0,1044,1,0,1044,1,1024,1,1044,1,16,0,0,16,1,1044,1044,1,1025,0,5,0,1044,1]

theorem envBound5620 : H12AffineFastState.Bounded env5620 := by
  intro p hp
  have h : env5620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5619_5620 : H12AffineEnvironment.transform 0 0 env5619 = env5620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5619 == env5620) = true)

theorem identity5620 : scanCanonicalize (H12AffineFastState.compose env5620 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5620 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5621 : List Nat := [0,4,0,16,1,16,0,5,1,4,1,16,0,16,1,0,16,1,4,1,16,1,16,0,0,16,1,16,16,1,5,0,5,0,16,1]

theorem envBound5621 : H12AffineFastState.Bounded env5621 := by
  intro p hp
  have h : env5621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5620_5621 : H12AffineEnvironment.transform 9 4 env5620 = env5621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5620 == env5621) = true)

def leafEnv5621 : List Nat := [0,4,0,16,1,16,0,5,1,4,1,16,0,16,1,0,16,1,4,1,16,1,16,0,5,0,1,16,1,16,16,1,5,0,5,0,4,0,16,1,0,16,1]

def active5621 : List Nat := [1,3]

def tree5621 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5621 : H12WitnessSearch.Good tree5621 := H12GlobalWitnessIndex.good

theorem leafIdentity5621 : H12AffineFastState.composeSystem env5621 rootObs = leafEnv5621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5621 rootObs == leafEnv5621) = true)

theorem terminalChecked5621 : H12PackedTerminal.terminalCheckFast leafEnv5621 active5621 tree5621 = true := by decide +kernel

def env5622 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4096,4194304,17665,16777216,33554432,16880645,4477268,16892164,16876565,1073741824,1284,4294967296,16875524,4332843383,1345,33563272]

theorem envBound5622 : H12AffineFastState.Bounded env5622 := by
  intro p hp
  have h : env5622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5270_5622 : H12AffineEnvironment.transform 18 1025 env5270 = env5622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env5270 == env5622) = true)

theorem identity5622 : scanCanonicalize (H12AffineFastState.compose env5622 (packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS)) = affineNative (2^(29+1) ^^^ 20994526) := by decide +kernel

theorem selectedBound5622 : packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS < 2^1333 := by decide +kernel

def env5623 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4096,4194304,17665,16777216,33554432,16880645,4477268,16892164,16876565,20994526,1284,4294967296,16875524,4332843383,1345,33563272]

theorem envBound5623 : H12AffineFastState.Bounded env5623 := by
  intro p hp
  have h : env5623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5622_5623 : H12AffineEnvironment.transform 29 20994526 env5622 = env5623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 20994526 env5622 == env5623) = true)

theorem identity5623 : scanCanonicalize (H12AffineFastState.compose env5623 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 28888) := by decide +kernel

theorem selectedBound5623 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env5624 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4096,4194304,17665,16777216,28888,16880645,4477268,16892164,16876565,20994526,1284,4294967296,16875524,4299260335,1345,21072]

theorem envBound5624 : H12AffineFastState.Bounded env5624 := by
  intro p hp
  have h : env5624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5623_5624 : H12AffineEnvironment.transform 24 28888 env5623 = env5624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 28888 env5623 == env5624) = true)

theorem identity5624 : scanCanonicalize (H12AffineFastState.compose env5624 (packedSelected [3,5,8,10,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound5624 : packedSelected [3,5,8,10,28,31] rootPS < 2^1333 := by decide +kernel

def env5625 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1025,32768,4096,4194304,17665,98564,28888,5377,4477268,16384,1297,4315354,1284,4294967296,256,4299260335,1345,21072]

theorem envBound5625 : H12AffineFastState.Bounded env5625 := by
  intro p hp
  have h : env5625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5624_5625 : H12AffineEnvironment.transform 23 98564 env5624 = env5625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env5624 == env5625) = true)

theorem identity5625 : scanCanonicalize (H12AffineFastState.compose env5625 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,20,21,22] rootPS)) = affineNative (2^(15+1) ^^^ 53726) := by decide +kernel

theorem selectedBound5625 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,20,21,22] rootPS < 2^1333 := by decide +kernel

def env5626 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,53726,1345,262144,1025,32768,4096,4194304,17665,20698,28888,5377,4477268,16384,1297,4196612,1284,4294967296,256,4299182193,1345,21072]

theorem envBound5626 : H12AffineFastState.Bounded env5626 := by
  intro p hp
  have h : env5626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5625_5626 : H12AffineEnvironment.transform 15 53726 env5625 = env5626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 53726 env5625 == env5626) = true)

theorem identity5626 : scanCanonicalize (H12AffineFastState.compose env5626 (packedSelected [1,3,5,8,12,13,15,16,17,20] rootPS)) = affineNative (2^(17+1) ^^^ 63608) := by decide +kernel

theorem selectedBound5626 : packedSelected [1,3,5,8,12,13,15,16,17,20] rootPS < 2^1333 := by decide +kernel

def env5627 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,53726,1345,63608,1025,32768,4096,4194304,17665,20698,28888,5377,4237612,16384,1297,4196612,1284,4294967296,256,4299182193,1345,21072]

theorem envBound5627 : H12AffineFastState.Bounded env5627 := by
  intro p hp
  have h : env5627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5626_5627 : H12AffineEnvironment.transform 17 63608 env5626 = env5627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 63608 env5626 == env5627) = true)

def env5628 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,33166,1345,43048,1025,32768,4096,4194304,5457,138,8328,5377,4237612,4176,1297,4196612,1284,4294967296,256,4299161633,1345,512]

theorem envBound5628 : H12AffineFastState.Bounded env5628 := by
  intro p hp
  have h : env5628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5627_5628 : H12AffineEnvironment.transform 13 4176 env5627 = env5628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env5627 == env5628) = true)

theorem identity5628 : scanCanonicalize (H12AffineFastState.compose env5628 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound5628 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env5629 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,260,138,1345,10540,1025,260,4096,4194304,5457,138,8328,5377,4204584,4176,1297,4196612,1284,4294967296,256,4299161633,1345,512]

theorem envBound5629 : H12AffineFastState.Bounded env5629 := by
  intro p hp
  have h : env5629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5628_5629 : H12AffineEnvironment.transform 14 260 env5628 = env5629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env5628 == env5629) = true)

theorem identity5629 : scanCanonicalize (H12AffineFastState.compose env5629 (packedSelected [3,5,10] rootPS)) = affineNative (2^(21+1) ^^^ 13133) := by decide +kernel

theorem selectedBound5629 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5630 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,260,138,1345,10540,1025,260,4096,13133,5457,138,8328,5377,7013,4176,1297,14921,1284,4294967296,256,4294980460,1345,512]

theorem envBound5630 : H12AffineFastState.Bounded env5630 := by
  intro p hp
  have h : env5630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5629_5630 : H12AffineEnvironment.transform 21 13133 env5629 = env5630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 13133 env5629 == env5630) = true)

theorem identity5630 : scanCanonicalize (H12AffineFastState.compose env5630 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(10+1) ^^^ 935) := by decide +kernel

theorem selectedBound5630 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env5631 : List Nat := [2,4,8,16,32,64,128,256,512,1024,935,4096,8192,4176,260,138,1345,8843,1025,260,4096,13133,5457,138,8328,5377,4290,4176,1297,12782,1284,4294967296,256,4294980460,1345,512]

theorem envBound5631 : H12AffineFastState.Bounded env5631 := by
  intro p hp
  have h : env5631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5630_5631 : H12AffineEnvironment.transform 10 935 env5630 = env5631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 935 env5630 == env5631) = true)

theorem identity5631 : scanCanonicalize (H12AffineFastState.compose env5631 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 1288) := by decide +kernel

theorem selectedBound5631 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env5632 : List Nat := [2,4,8,16,32,64,128,256,512,1024,935,4096,1288,4176,260,138,1345,1923,1025,260,4096,5701,5457,138,1408,5377,4290,4176,1297,5350,1284,4294967296,256,4294973028,1345,512]

theorem envBound5632 : H12AffineFastState.Bounded env5632 := by
  intro p hp
  have h : env5632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5631_5632 : H12AffineEnvironment.transform 12 1288 env5631 = env5632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1288 env5631 == env5632) = true)

theorem identity5632 : scanCanonicalize (H12AffineFastState.compose env5632 (packedSelected [1,3,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 1993) := by decide +kernel

theorem selectedBound5632 : packedSelected [1,3,12,15] rootPS < 2^1333 := by decide +kernel

def env5633 : List Nat := [2,4,8,16,32,64,128,256,512,1024,935,1993,1288,1945,260,138,1345,1923,1025,260,1993,396,664,138,1408,712,1803,1945,1297,815,1284,4294967296,256,4294967725,1345,512]

theorem envBound5633 : H12AffineFastState.Bounded env5633 := by
  intro p hp
  have h : env5633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5632_5633 : H12AffineEnvironment.transform 11 1993 env5632 = env5633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1993 env5632 == env5633) = true)

theorem identity5633 : scanCanonicalize (H12AffineFastState.compose env5633 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 260) := by decide +kernel

theorem selectedBound5633 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5634 : List Nat := [2,4,8,16,32,64,128,256,260,1024,163,1229,1288,1181,260,138,1345,1159,1025,260,1229,396,412,138,1408,460,1039,1181,1297,43,1284,4294967296,256,4294967725,1345,260]

theorem envBound5634 : H12AffineFastState.Bounded env5634 := by
  intro p hp
  have h : env5634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5633_5634 : H12AffineEnvironment.transform 8 260 env5633 = env5634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 260 env5633 == env5634) = true)

theorem identity5634 : scanCanonicalize (H12AffineFastState.compose env5634 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 32) := by decide +kernel

theorem selectedBound5634 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5635 : List Nat := [2,4,8,16,32,64,128,256,260,1024,163,1229,1288,1181,260,138,1345,1159,1025,260,1229,396,412,138,1408,460,1039,1181,1297,43,1284,32,256,397,1345,260]

theorem envBound5635 : H12AffineFastState.Bounded env5635 := by
  intro p hp
  have h : env5635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5634_5635 : H12AffineEnvironment.transform 31 32 env5634 = env5635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env5634 == env5635) = true)

theorem identity5635 : scanCanonicalize (H12AffineFastState.compose env5635 (packedSelected [1,12,21] rootPS)) = affineNative (2^(9+1) ^^^ 256) := by decide +kernel

theorem selectedBound5635 : packedSelected [1,12,21] rootPS < 2^1333 := by decide +kernel

def env5636 : List Nat := [2,4,8,16,32,64,128,256,260,256,163,461,8,413,260,138,65,391,257,260,461,396,412,138,128,460,271,413,17,43,4,32,256,397,65,260]

theorem envBound5636 : H12AffineFastState.Bounded env5636 := by
  intro p hp
  have h : env5636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5635_5636 : H12AffineEnvironment.transform 9 256 env5635 = env5636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env5635 == env5636) = true)

def env5637 : List Nat := [2,4,8,16,32,64,8,256,260,256,43,325,8,277,260,2,65,271,257,260,325,260,276,2,8,324,271,277,17,43,4,32,256,261,65,260]

theorem envBound5637 : H12AffineFastState.Bounded env5637 := by
  intro p hp
  have h : env5637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5636_5637 : H12AffineEnvironment.transform 6 8 env5636 = env5637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env5636 == env5637) = true)

theorem identity5637 : scanCanonicalize (H12AffineFastState.compose env5637 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 92) := by decide +kernel

theorem selectedBound5637 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5638 : List Nat := [2,4,8,16,32,64,8,92,88,92,43,25,8,73,88,2,65,83,93,88,25,88,72,2,8,24,83,73,17,43,4,32,92,89,65,88]

theorem envBound5638 : H12AffineFastState.Bounded env5638 := by
  intro p hp
  have h : env5638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5637_5638 : H12AffineEnvironment.transform 7 92 env5637 = env5638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 92 env5637 == env5638) = true)

def env5639 : List Nat := [2,4,0,16,32,64,0,84,80,84,35,17,0,65,80,2,65,83,85,80,17,80,64,2,0,16,83,65,17,35,4,32,84,81,65,80]

theorem envBound5639 : H12AffineFastState.Bounded env5639 := by
  intro p hp
  have h : env5639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5638_5639 : H12AffineEnvironment.transform 2 0 env5638 = env5639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5638 == env5639) = true)

theorem identity5639 : scanCanonicalize (H12AffineFastState.compose env5639 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 50) := by decide +kernel

theorem selectedBound5639 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5640 : List Nat := [2,4,0,16,32,50,0,38,34,38,35,17,0,51,34,2,51,33,39,34,17,34,50,2,0,16,33,51,17,35,4,32,38,35,51,34]

theorem envBound5640 : H12AffineFastState.Bounded env5640 := by
  intro p hp
  have h : env5640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5639_5640 : H12AffineEnvironment.transform 5 50 env5639 = env5640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 50 env5639 == env5640) = true)

theorem identity5640 : scanCanonicalize (H12AffineFastState.compose env5640 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5640 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5641 : List Nat := [2,4,0,16,0,18,0,6,2,6,3,17,0,19,2,2,19,1,7,2,17,2,18,2,0,16,1,19,17,3,4,0,6,3,19,2]

theorem envBound5641 : H12AffineFastState.Bounded env5641 := by
  intro p hp
  have h : env5641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5640_5641 : H12AffineEnvironment.transform 4 0 env5640 = env5641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5640 == env5641) = true)

theorem identity5641 : scanCanonicalize (H12AffineFastState.compose env5641 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5641 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5642 : List Nat := [1,4,0,16,0,17,0,5,1,5,0,17,0,16,1,1,16,1,4,1,17,1,17,1,0,16,1,16,17,0,4,0,5,0,16,1]

theorem envBound5642 : H12AffineFastState.Bounded env5642 := by
  intro p hp
  have h : env5642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5641_5642 : H12AffineEnvironment.transform 0 1 env5641 = env5642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5641 == env5642) = true)

def leafEnv5642 : List Nat := [1,4,0,16,0,17,0,5,1,5,0,17,0,16,1,1,16,1,4,1,17,1,17,1,5,0,1,16,1,16,17,0,4,0,5,0,4,1,16,1,0,17,1]

def active5642 : List Nat := [1,3]

def tree5642 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5642 : H12WitnessSearch.Good tree5642 := H12GlobalWitnessIndex.good

theorem leafIdentity5642 : H12AffineFastState.composeSystem env5642 rootObs = leafEnv5642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5642 rootObs == leafEnv5642) = true)

theorem terminalChecked5642 : H12PackedTerminal.terminalCheckFast leafEnv5642 active5642 tree5642 = true := by decide +kernel

def env5643 : List Nat := [2,4,1,16,32,64,1,85,81,85,34,16,1,64,81,2,65,83,84,81,16,81,65,2,1,17,83,64,17,34,4,32,85,80,65,81]

theorem envBound5643 : H12AffineFastState.Bounded env5643 := by
  intro p hp
  have h : env5643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5638_5643 : H12AffineEnvironment.transform 2 1 env5638 = env5643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5638 == env5643) = true)

theorem identity5643 : scanCanonicalize (H12AffineFastState.compose env5643 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound5643 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5644 : List Nat := [2,4,1,16,32,48,1,37,33,37,34,16,1,48,33,2,49,35,36,33,16,33,49,2,1,17,35,48,17,34,4,32,37,32,49,33]

theorem envBound5644 : H12AffineFastState.Bounded env5644 := by
  intro p hp
  have h : env5644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5643_5644 : H12AffineEnvironment.transform 5 48 env5643 = env5644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env5643 == env5644) = true)

def env5645 : List Nat := [2,4,8,16,32,64,9,256,260,256,42,324,8,276,260,3,65,270,257,260,324,261,277,3,9,325,271,276,17,43,4,32,256,260,65,260]

theorem envBound5645 : H12AffineFastState.Bounded env5645 := by
  intro p hp
  have h : env5645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5636_5645 : H12AffineEnvironment.transform 6 9 env5636 = env5645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env5636 == env5645) = true)

theorem identity5645 : scanCanonicalize (H12AffineFastState.compose env5645 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 51) := by decide +kernel

theorem selectedBound5645 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5646 : List Nat := [2,4,8,16,32,51,9,256,260,256,42,311,8,276,260,3,50,270,257,260,311,261,277,3,9,310,271,276,17,43,4,32,256,260,50,260]

theorem envBound5646 : H12AffineFastState.Bounded env5646 := by
  intro p hp
  have h : env5646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5645_5646 : H12AffineEnvironment.transform 5 51 env5645 = env5646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 51 env5645 == env5646) = true)

theorem identity5646 : scanCanonicalize (H12AffineFastState.compose env5646 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 39) := by decide +kernel

theorem selectedBound5646 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5647 : List Nat := [2,4,8,16,32,51,9,39,35,39,42,16,8,51,35,3,50,41,38,35,16,34,50,3,9,17,40,51,17,43,4,32,39,35,50,35]

theorem envBound5647 : H12AffineFastState.Bounded env5647 := by
  intro p hp
  have h : env5647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5646_5647 : H12AffineEnvironment.transform 7 39 env5646 = env5647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 39 env5646 == env5647) = true)

theorem identity5647 : scanCanonicalize (H12AffineFastState.compose env5647 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5647 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5648 : List Nat := [1,4,8,16,32,48,9,36,32,36,41,16,8,48,32,0,49,41,37,32,16,33,49,0,9,17,40,48,17,40,4,32,36,32,49,32]

theorem envBound5648 : H12AffineFastState.Bounded env5648 := by
  intro p hp
  have h : env5648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5647_5648 : H12AffineEnvironment.transform 0 1 env5647 = env5648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5647 == env5648) = true)

def env5649 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,33167,1345,43049,1025,32768,4096,4194304,5456,139,8329,5377,4237612,4177,1297,4196612,1284,4294967296,256,4299161632,1345,513]

theorem envBound5649 : H12AffineFastState.Bounded env5649 := by
  intro p hp
  have h : env5649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5627_5649 : H12AffineEnvironment.transform 13 4177 env5627 = env5649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env5627 == env5649) = true)

theorem identity5649 : scanCanonicalize (H12AffineFastState.compose env5649 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5649 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5650 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,33167,1345,43049,1025,32768,4096,4194304,5456,139,8329,5377,4237612,4177,1297,4196612,1284,4294967296,256,4299161632,1345,136]

theorem envBound5650 : H12AffineFastState.Bounded env5650 := by
  intro p hp
  have h : env5650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5649_5650 : H12AffineEnvironment.transform 8 137 env5649 = env5650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5649 == env5650) = true)

theorem identity5650 : scanCanonicalize (H12AffineFastState.compose env5650 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 13508) := by decide +kernel

theorem selectedBound5650 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5651 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,13508,13643,1345,7405,1025,13508,4096,4194304,5456,139,8329,5377,4201960,4177,1297,4196612,1284,4294967296,256,4299161632,1345,136]

theorem envBound5651 : H12AffineFastState.Bounded env5651 := by
  intro p hp
  have h : env5651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5650_5651 : H12AffineEnvironment.transform 14 13508 env5650 = env5651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13508 env5650 == env5651) = true)

theorem identity5651 : scanCanonicalize (H12AffineFastState.compose env5651 (packedSelected [1,10] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound5651 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

end H12GlobalChart2