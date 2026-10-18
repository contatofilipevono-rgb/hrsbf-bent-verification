import H12GlobalChart2Data017

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans4397_4398 : H12AffineEnvironment.transform 31 43 env4397 = env4398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env4397 == env4398) = true)

theorem identity4398 : scanCanonicalize (H12AffineFastState.compose env4398 (packedSelected [1,3,4] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4398 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4399 : List Nat := [2,4,8,11,32,64,128,37,136,1024,1,1071,40,1125,1,65536,1124,1,66731,1,1070,32,65,65569,161,11,0,1124,1070,1,1056,43,37,43,1125,137]

theorem envBound4399 : H12AffineFastState.Bounded env4399 := by
  intro p hp
  have h : env4399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4398_4399 : H12AffineEnvironment.transform 3 11 env4398 = env4399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4398 == env4399) = true)

theorem identity4399 : scanCanonicalize (H12AffineFastState.compose env4399 (packedSelected [2,5] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound4399 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4400 : List Nat := [2,4,8,11,32,64,128,37,136,1024,1,1071,40,1125,1,170,1124,1,1025,1,1070,32,65,139,161,11,0,1124,1070,1,1056,43,37,43,1125,137]

theorem envBound4400 : H12AffineFastState.Bounded env4400 := by
  intro p hp
  have h : env4400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4399_4400 : H12AffineEnvironment.transform 15 170 env4399 = env4400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env4399 == env4400) = true)

theorem identity4400 : scanCanonicalize (H12AffineFastState.compose env4400 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 72) := by decide +kernel

theorem selectedBound4400 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4401 : List Nat := [2,4,8,11,32,64,72,37,64,1024,1,1071,40,1125,1,98,1124,1,1025,1,1070,32,65,67,105,11,0,1124,1070,1,1056,43,37,43,1125,65]

theorem envBound4401 : H12AffineFastState.Bounded env4401 := by
  intro p hp
  have h : env4401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4400_4401 : H12AffineEnvironment.transform 6 72 env4400 = env4401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 72 env4400 == env4401) = true)

def env4402 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,157794305,1073741824,140788816,4294967296,157663568,4417151347,131072,33563272]

theorem envBound4402 : H12AffineFastState.Bounded env4402 := by
  intro p hp
  have h : env4402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3736_4402 : H12AffineEnvironment.transform 28 157794305 env3736 = env4402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env3736 == env4402) = true)

theorem identity4402 : scanCanonicalize (H12AffineFastState.compose env4402 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 6702101) := by decide +kernel

theorem selectedBound4402 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env4403 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,6702101,67130624,16876564,1073741824,131141,4294967296,17007941,4417151347,131072,33563272]

theorem envBound4403 : H12AffineFastState.Bounded env4403 := by
  intro p hp
  have h : env4403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4402_4403 : H12AffineEnvironment.transform 26 6702101 env4402 = env4403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 6702101 env4402 == env4403) = true)

def env4404 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,16777216,33554432,67108864,4609045,67130624,16876564,1073741824,131141,4294967296,17007941,4417151347,131072,33563272]

theorem envBound4404 : H12AffineFastState.Bounded env4404 := by
  intro p hp
  have h : env4404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4403_4404 : H12AffineEnvironment.transform 20 4096 env4403 = env4404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env4403 == env4404) = true)

theorem identity4404 : scanCanonicalize (H12AffineFastState.compose env4404 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230469) := by decide +kernel

theorem selectedBound4404 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env4405 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,230469,33554432,67108864,4609045,67130624,131153,1073741824,131141,4294967296,256,4400604470,131072,33563272]

theorem envBound4405 : H12AffineFastState.Bounded env4405 := by
  intro p hp
  have h : env4405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4404_4405 : H12AffineEnvironment.transform 23 230469 env4404 = env4405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230469 env4404 == env4405) = true)

def env4406 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17665,230469,33554432,67108864,4609045,67130624,131153,1073741824,131141,4294967296,256,4400079158,131072,33563272]

theorem envBound4406 : H12AffineFastState.Bounded env4406 := by
  intro p hp
  have h : env4406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4405_4406 : H12AffineEnvironment.transform 18 1024 env4405 = env4406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4405 == env4406) = true)

theorem identity4406 : scanCanonicalize (H12AffineFastState.compose env4406 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 71409035) := by decide +kernel

theorem selectedBound4406 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env4407 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17665,230469,33554432,67108864,4609045,67130624,131153,71409035,131141,4294967296,256,4400079158,131072,33563272]

theorem envBound4407 : H12AffineFastState.Bounded env4407 := by
  intro p hp
  have h : env4407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4406_4407 : H12AffineEnvironment.transform 29 71409035 env4406 = env4407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 71409035 env4406 == env4407) = true)

def env4408 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230469,33554432,67108864,4588613,67110224,131153,71409035,131141,4294967296,256,4400066918,131072,33563272]

theorem envBound4408 : H12AffineFastState.Bounded env4408 := by
  intro p hp
  have h : env4408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4407_4408 : H12AffineEnvironment.transform 13 4176 env4407 = env4408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env4407 == env4408) = true)

def env4409 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230469,4259840,67108864,4588613,67110224,131153,71409035,131141,4294967296,256,4362252646,131072,4268680]

theorem envBound4409 : H12AffineFastState.Bounded env4409 := by
  intro p hp
  have h : env4409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4408_4409 : H12AffineEnvironment.transform 24 4259840 env4408 = env4409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4259840 env4408 == env4409) = true)

def env4410 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,4194304,5457,103493,4259840,67108864,4461637,67110224,4177,71409035,4165,4294967296,256,4362117478,4096,4268680]

theorem envBound4410 : H12AffineFastState.Bounded env4410 := by
  intro p hp
  have h : env4410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4409_4410 : H12AffineEnvironment.transform 16 4096 env4409 = env4410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env4409 == env4410) = true)

theorem identity4410 : scanCanonicalize (H12AffineFastState.compose env4410 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 65544) := by decide +kernel

theorem selectedBound4410 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4411 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,65544,5457,103493,8,67108864,332877,67110224,4177,67149187,4165,4294967296,256,4362117478,4096,8832]

theorem envBound4411 : H12AffineFastState.Bounded env4411 := by
  intro p hp
  have h : env4411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4410_4411 : H12AffineEnvironment.transform 21 65544 env4410 = env4411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65544 env4410 == env4411) = true)

def env4412 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,65544,5377,103445,8,67108864,332829,67110144,4097,67149187,4117,4294967296,256,4362117430,4096,8832]

theorem envBound4412 : H12AffineFastState.Bounded env4412 := by
  intro p hp
  have h : env4412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4411_4412 : H12AffineEnvironment.transform 5 16 env4411 = env4412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4411 == env4412) = true)

def env4413 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,65544,5377,103445,8,67108864,332829,67110144,4097,67149187,4117,4294967296,256,4362117430,4096,8320]

theorem envBound4413 : H12AffineFastState.Bounded env4413 := by
  intro p hp
  have h : env4413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4412_4413 : H12AffineEnvironment.transform 8 0 env4412 = env4413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env4412 == env4413) = true)

theorem identity4413 : scanCanonicalize (H12AffineFastState.compose env4413 (packedSelected [1,3,5,6,8,9,10,19,22,25] rootPS)) = affineNative (2^(11+1) ^^^ 1433) := by decide +kernel

theorem selectedBound4413 : packedSelected [1,3,5,6,8,9,10,19,22,25] rootPS < 2^1333 := by decide +kernel

def env4414 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,8192,1433,32768,65536,1433,262144,1024,32768,1433,65544,152,98700,8,67108864,328068,67110144,1432,67143706,1420,4294967296,256,4362117430,1433,8320]

theorem envBound4414 : H12AffineFastState.Bounded env4414 := by
  intro p hp
  have h : env4414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4413_4414 : H12AffineEnvironment.transform 11 1433 env4413 = env4414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1433 env4413 == env4414) = true)

def env4415 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,8192,1433,32768,65536,1433,262144,1024,32768,1433,65544,152,98700,8,16,328068,1296,1432,34826,1420,4294967296,256,4295008550,1433,8320]

theorem envBound4415 : H12AffineFastState.Bounded env4415 := by
  intro p hp
  have h : env4415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4414_4415 : H12AffineEnvironment.transform 25 16 env4414 = env4415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 16 env4414 == env4415) = true)

theorem identity4415 : scanCanonicalize (H12AffineFastState.compose env4415 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound4415 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4416 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,8,1433,32768,65536,1433,262144,1024,32768,1433,65544,152,98700,8,16,328068,1296,1432,34826,1420,4294967296,256,4295000366,1433,136]

theorem envBound4416 : H12AffineFastState.Bounded env4416 := by
  intro p hp
  have h : env4416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4415_4416 : H12AffineEnvironment.transform 12 8 env4415 = env4416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env4415 == env4416) = true)

theorem identity4416 : scanCanonicalize (H12AffineFastState.compose env4416 (packedSelected [1,3,4,5,8,9,10,12,16] rootPS)) = affineNative (2^(17+1) ^^^ 68014) := by decide +kernel

theorem selectedBound4416 : packedSelected [1,3,4,5,8,9,10,12,16] rootPS < 2^1333 := by decide +kernel

def env4417 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,8,1433,32768,65536,1433,68014,1024,32768,1433,65544,152,98700,8,16,2090,1296,1432,34826,1420,4294967296,256,4295000366,1433,136]

theorem envBound4417 : H12AffineFastState.Bounded env4417 := by
  intro p hp
  have h : env4417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4416_4417 : H12AffineEnvironment.transform 17 68014 env4416 = env4417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 68014 env4416 == env4417) = true)

theorem identity4417 : scanCanonicalize (H12AffineFastState.compose env4417 (packedSelected [1,3,17] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound4417 : packedSelected [1,3,17] rootPS < 2^1333 := by decide +kernel

def env4418 : List Nat := [2,4,8,16,32,16,128,14,0,1024,2048,1175,8,1175,32768,65536,1175,67744,1024,32768,1175,65544,152,98434,8,16,2090,1054,1174,34826,1154,4294967296,14,4295000096,1175,136]

theorem envBound4418 : H12AffineFastState.Bounded env4418 := by
  intro p hp
  have h : env4418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4417_4418 : H12AffineEnvironment.transform 7 14 env4417 = env4418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env4417 == env4418) = true)

theorem identity4418 : scanCanonicalize (H12AffineFastState.compose env4418 (packedSelected [5,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 2) := by decide +kernel

theorem selectedBound4418 : packedSelected [5,10,12] rootPS < 2^1333 := by decide +kernel

def env4419 : List Nat := [2,4,8,16,32,16,128,14,0,1024,2048,1175,8,1175,32768,2,1175,2210,1024,32768,1175,10,152,32896,8,16,2090,1054,1174,34826,1154,4294967296,14,4295000096,1175,136]

theorem envBound4419 : H12AffineFastState.Bounded env4419 := by
  intro p hp
  have h : env4419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4418_4419 : H12AffineEnvironment.transform 15 2 env4418 = env4419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2 env4418 == env4419) = true)

theorem identity4419 : scanCanonicalize (H12AffineFastState.compose env4419 (packedSelected [0,2,3,4,10,11,13] rootPS)) = affineNative (2^(10+1) ^^^ 1038) := by decide +kernel

theorem selectedBound4419 : packedSelected [0,2,3,4,10,11,13] rootPS < 2^1333 := by decide +kernel

def env4420 : List Nat := [2,4,8,16,32,16,128,14,0,1024,1038,1175,8,1175,32768,2,1175,1196,1024,32768,1175,10,152,32896,8,16,1060,1054,1174,33796,1154,4294967296,14,4295000096,1175,136]

theorem envBound4420 : H12AffineFastState.Bounded env4420 := by
  intro p hp
  have h : env4420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4419_4420 : H12AffineEnvironment.transform 10 1038 env4419 = env4420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1038 env4419 == env4420) = true)

theorem identity4420 : scanCanonicalize (H12AffineFastState.compose env4420 (packedSelected [2,3,4,5,7,11,15,20] rootPS)) = affineNative (2^(14+1) ^^^ 10) := by decide +kernel

theorem selectedBound4420 : packedSelected [2,3,4,5,7,11,15,20] rootPS < 2^1333 := by decide +kernel

def env4421 : List Nat := [2,4,8,16,32,16,128,14,0,1024,1038,1175,8,1175,10,2,1175,1196,1024,10,1175,10,152,138,8,16,1060,1054,1174,1038,1154,4294967296,14,4294967338,1175,136]

theorem envBound4421 : H12AffineFastState.Bounded env4421 := by
  intro p hp
  have h : env4421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4420_4421 : H12AffineEnvironment.transform 14 10 env4420 = env4421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10 env4420 == env4421) = true)

theorem identity4421 : scanCanonicalize (H12AffineFastState.compose env4421 (packedSelected [5,6] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound4421 : packedSelected [5,6] rootPS < 2^1333 := by decide +kernel

def env4422 : List Nat := [2,4,8,16,32,16,128,14,0,1024,1038,1175,8,1175,10,2,1175,1196,1024,10,1175,10,152,138,8,16,1060,1054,1174,1038,1154,42,14,0,1175,136]

theorem envBound4422 : H12AffineFastState.Bounded env4422 := by
  intro p hp
  have h : env4422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4421_4422 : H12AffineEnvironment.transform 31 42 env4421 = env4422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env4421 == env4422) = true)

theorem identity4422 : scanCanonicalize (H12AffineFastState.compose env4422 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4422 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env4423 : List Nat := [2,4,8,16,32,16,8,14,0,1024,1038,1055,8,1055,10,2,1055,1060,1024,10,1055,10,16,2,8,16,1060,1054,1054,1038,1034,42,14,0,1055,0]

theorem envBound4423 : H12AffineFastState.Bounded env4423 := by
  intro p hp
  have h : env4423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4422_4423 : H12AffineEnvironment.transform 6 8 env4422 = env4423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4422 == env4423) = true)

theorem identity4423 : scanCanonicalize (H12AffineFastState.compose env4423 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 54) := by decide +kernel

theorem selectedBound4423 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4424 : List Nat := [2,4,8,16,32,16,8,14,0,54,56,41,8,41,10,2,41,18,54,10,41,10,16,2,8,16,18,40,40,56,60,42,14,0,41,0]

theorem envBound4424 : H12AffineFastState.Bounded env4424 := by
  intro p hp
  have h : env4424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4423_4424 : H12AffineEnvironment.transform 9 54 env4423 = env4424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 54 env4423 == env4424) = true)

theorem identity4424 : scanCanonicalize (H12AffineFastState.compose env4424 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4424 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4425 : List Nat := [2,4,8,16,10,16,8,14,0,28,18,3,8,3,10,2,3,18,28,10,3,10,16,2,8,16,18,2,2,18,22,0,14,0,3,0]

theorem envBound4425 : H12AffineFastState.Bounded env4425 := by
  intro p hp
  have h : env4425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4424_4425 : H12AffineEnvironment.transform 4 10 env4424 = env4425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4424 == env4425) = true)

theorem identity4425 : scanCanonicalize (H12AffineFastState.compose env4425 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4425 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4426 : List Nat := [2,4,3,16,1,16,3,5,0,23,18,3,3,3,1,2,3,18,23,1,3,1,16,2,3,16,18,2,2,18,22,0,5,0,3,0]

theorem envBound4426 : H12AffineFastState.Bounded env4426 := by
  intro p hp
  have h : env4426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4425_4426 : H12AffineEnvironment.transform 2 3 env4425 = env4426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4425 == env4426) = true)

def env4427 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,8192,1433,32768,65536,1433,262144,1024,32768,1433,65544,152,98700,8,17,328068,1297,1432,34827,1420,4294967296,256,4295008551,1433,8320]

theorem envBound4427 : H12AffineFastState.Bounded env4427 := by
  intro p hp
  have h : env4427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4414_4427 : H12AffineEnvironment.transform 25 17 env4414 = env4427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17 env4414 == env4427) = true)

theorem identity4427 : scanCanonicalize (H12AffineFastState.compose env4427 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(12+1) ^^^ 128) := by decide +kernel

theorem selectedBound4427 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4428 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,128,1433,32768,65536,1433,262144,1024,32768,1433,65544,152,98700,8,17,328068,1297,1432,34827,1420,4294967296,256,4295000487,1433,0]

theorem envBound4428 : H12AffineFastState.Bounded env4428 := by
  intro p hp
  have h : env4428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4427_4428 : H12AffineEnvironment.transform 12 128 env4427 = env4428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 128 env4427 == env4428) = true)

theorem identity4428 : scanCanonicalize (H12AffineFastState.compose env4428 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 268) := by decide +kernel

theorem selectedBound4428 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4429 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,128,1433,32768,268,1433,262144,1024,32768,1433,260,152,32896,8,17,262280,1297,1432,34827,1420,4294967296,256,4295000487,1433,0]

theorem envBound4429 : H12AffineFastState.Bounded env4429 := by
  intro p hp
  have h : env4429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4428_4429 : H12AffineEnvironment.transform 15 268 env4428 = env4429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 268 env4428 == env4429) = true)

theorem identity4429 : scanCanonicalize (H12AffineFastState.compose env4429 (packedSelected [1,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 298240) := by decide +kernel

theorem selectedBound4429 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env4430 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,128,1433,32768,268,1433,262144,1024,32768,1433,260,152,32896,8,17,262280,1297,1432,34827,1420,298240,256,265383,1433,0]

theorem envBound4430 : H12AffineFastState.Bounded env4430 := by
  intro p hp
  have h : env4430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4429_4430 : H12AffineEnvironment.transform 31 298240 env4429 = env4430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 298240 env4429 == env4430) = true)

theorem identity4430 : scanCanonicalize (H12AffineFastState.compose env4430 (packedSelected [5,8,10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 35238) := by decide +kernel

theorem selectedBound4430 : packedSelected [5,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4431 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1433,128,1433,32768,268,1433,35238,1024,32768,1433,260,152,32896,8,17,35118,1297,1432,34827,1420,1190,256,34049,1433,0]

theorem envBound4431 : H12AffineFastState.Bounded env4431 := by
  intro p hp
  have h : env4431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4430_4431 : H12AffineEnvironment.transform 17 35238 env4430 = env4431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 35238 env4430 == env4431) = true)

theorem identity4431 : scanCanonicalize (H12AffineFastState.compose env4431 (packedSelected [1,5,10,12,15] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound4431 : packedSelected [1,5,10,12,15] rootPS < 2^1333 := by decide +kernel

def env4432 : List Nat := [2,4,8,16,32,16,128,135,0,1024,2048,1054,128,1054,32768,139,1054,34849,1024,32768,1054,131,152,32896,8,17,34985,1174,1055,34827,1035,1190,135,33926,1054,0]

theorem envBound4432 : H12AffineFastState.Bounded env4432 := by
  intro p hp
  have h : env4432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4431_4432 : H12AffineEnvironment.transform 7 135 env4431 = env4432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env4431 == env4432) = true)

theorem identity4432 : scanCanonicalize (H12AffineFastState.compose env4432 (packedSelected [1,5,6,7,8] rootPS)) = affineNative (2^(14+1) ^^^ 1166) := by decide +kernel

theorem selectedBound4432 : packedSelected [1,5,6,7,8] rootPS < 2^1333 := by decide +kernel

def env4433 : List Nat := [2,4,8,16,32,16,128,135,0,1024,2048,1054,128,1054,1166,139,1054,3247,1024,1166,1054,131,152,1038,8,17,3111,1174,1055,3205,1035,1190,135,8,1054,0]

theorem envBound4433 : H12AffineFastState.Bounded env4433 := by
  intro p hp
  have h : env4433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4432_4433 : H12AffineEnvironment.transform 14 1166 env4432 = env4433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1166 env4432 == env4433) = true)

theorem identity4433 : scanCanonicalize (H12AffineFastState.compose env4433 (packedSelected [0,1,2,3,5,6,9,18] rootPS)) = affineNative (2^(10+1) ^^^ 1068) := by decide +kernel

theorem selectedBound4433 : packedSelected [0,1,2,3,5,6,9,18] rootPS < 2^1333 := by decide +kernel

def env4434 : List Nat := [2,4,8,16,32,16,128,135,0,1024,1068,1054,128,1054,1166,139,1054,131,1024,1166,1054,131,152,1038,8,17,11,1174,1055,169,1035,1190,135,8,1054,0]

theorem envBound4434 : H12AffineFastState.Bounded env4434 := by
  intro p hp
  have h : env4434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4433_4434 : H12AffineEnvironment.transform 10 1068 env4433 = env4434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1068 env4433 == env4434) = true)

theorem identity4434 : scanCanonicalize (H12AffineFastState.compose env4434 (packedSelected [2,3,5,6,7,9] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound4434 : packedSelected [2,3,5,6,7,9] rootPS < 2^1333 := by decide +kernel

def env4435 : List Nat := [2,4,8,16,32,16,128,135,0,14,34,16,128,16,128,139,16,131,14,128,16,131,152,0,8,17,11,152,17,169,5,168,135,8,16,0]

theorem envBound4435 : H12AffineFastState.Bounded env4435 := by
  intro p hp
  have h : env4435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4434_4435 : H12AffineEnvironment.transform 9 14 env4434 = env4435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env4434 == env4435) = true)

theorem identity4435 : scanCanonicalize (H12AffineFastState.compose env4435 (packedSelected [0,2,3,5,6] rootPS)) = affineNative (2^(6+1) ^^^ 10) := by decide +kernel

theorem selectedBound4435 : packedSelected [0,2,3,5,6] rootPS < 2^1333 := by decide +kernel

def env4436 : List Nat := [2,4,8,16,32,16,10,13,0,14,34,16,10,16,10,1,16,9,14,10,16,9,18,0,8,17,11,18,17,35,5,34,13,8,16,0]

theorem envBound4436 : H12AffineFastState.Bounded env4436 := by
  intro p hp
  have h : env4436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4435_4436 : H12AffineEnvironment.transform 6 10 env4435 = env4436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 10 env4435 == env4436) = true)

theorem identity4436 : scanCanonicalize (H12AffineFastState.compose env4436 (packedSelected [1,2,3] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound4436 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env4437 : List Nat := [0,4,8,16,32,16,8,13,0,12,32,16,8,16,8,1,16,9,12,8,16,9,16,0,8,17,9,16,17,33,5,32,13,8,16,0]

theorem envBound4437 : H12AffineFastState.Bounded env4437 := by
  intro p hp
  have h : env4437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4436_4437 : H12AffineEnvironment.transform 0 0 env4436 = env4437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env4436 == env4437) = true)

theorem identity4437 : scanCanonicalize (H12AffineFastState.compose env4437 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound4437 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4438 : List Nat := [0,4,8,16,16,16,8,13,0,12,16,16,8,16,8,1,16,9,12,8,16,9,16,0,8,17,9,16,17,17,5,16,13,8,16,0]

theorem envBound4438 : H12AffineFastState.Bounded env4438 := by
  intro p hp
  have h : env4438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4437_4438 : H12AffineEnvironment.transform 4 16 env4437 = env4438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env4437 == env4438) = true)

theorem identity4438 : scanCanonicalize (H12AffineFastState.compose env4438 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4438 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4439 : List Nat := [0,4,8,0,0,0,8,13,0,12,0,0,8,0,8,1,0,9,12,8,0,9,0,0,8,1,9,0,1,1,5,0,13,8,0,0]

theorem envBound4439 : H12AffineFastState.Bounded env4439 := by
  intro p hp
  have h : env4439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4438_4439 : H12AffineEnvironment.transform 3 0 env4438 = env4439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4438 == env4439) = true)

theorem identity4439 : scanCanonicalize (H12AffineFastState.compose env4439 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound4439 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4440 : List Nat := [0,4,1,0,0,0,1,4,0,5,0,0,1,0,1,1,0,0,5,1,0,0,0,0,1,1,0,0,1,1,5,0,4,1,0,0]

theorem envBound4440 : H12AffineFastState.Bounded env4440 := by
  intro p hp
  have h : env4440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4439_4440 : H12AffineEnvironment.transform 2 1 env4439 = env4440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env4439 == env4440) = true)

def env4441 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,65544,5377,103445,8,67108864,332829,67110144,4097,67149187,4117,4294967296,256,4362117430,4096,8321]

theorem envBound4441 : H12AffineFastState.Bounded env4441 := by
  intro p hp
  have h : env4441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4412_4441 : H12AffineEnvironment.transform 8 1 env4412 = env4441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env4412 == env4441) = true)

theorem identity4441 : scanCanonicalize (H12AffineFastState.compose env4441 (packedSelected [1,3,5,6,8,9,10,19,22,25] rootPS)) = affineNative (2^(12+1) ^^^ 5401) := by decide +kernel

theorem selectedBound4441 : packedSelected [1,3,5,6,8,9,10,19,22,25] rootPS < 2^1333 := by decide +kernel

def env4442 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,5401,4096,32768,65536,4096,262144,1024,32768,4096,65544,5377,103445,8,67108864,332829,67110144,4097,67149187,4117,4294967296,256,4362114095,4096,5528]

theorem envBound4442 : H12AffineFastState.Bounded env4442 := by
  intro p hp
  have h : env4442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4441_4442 : H12AffineEnvironment.transform 12 5401 env4441 = env4442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5401 env4441 == env4442) = true)

def env4443 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,5401,4096,32768,65536,4096,262144,1024,32768,4096,65544,5377,103445,8,5376,332829,4096,4097,34947,4117,4294967296,256,4295000367,4096,5528]

theorem envBound4443 : H12AffineFastState.Bounded env4443 := by
  intro p hp
  have h : env4443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4442_4443 : H12AffineEnvironment.transform 25 5376 env4442 = env4443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env4442 == env4443) = true)

theorem identity4443 : scanCanonicalize (H12AffineFastState.compose env4443 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound4443 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env4444 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,5401,4096,32768,65536,4096,2341,1024,32768,4096,65544,5377,103445,8,5376,73016,4096,4097,34947,4117,4294967296,256,4295000367,4096,5528]

theorem envBound4444 : H12AffineFastState.Bounded env4444 := by
  intro p hp
  have h : env4444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4443_4444 : H12AffineEnvironment.transform 17 2341 env4443 = env4444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env4443 == env4444) = true)

theorem identity4444 : scanCanonicalize (H12AffineFastState.compose env4444 (packedSelected [13,17] rootPS)) = affineNative (2^(31+1) ^^^ 5141) := by decide +kernel

theorem selectedBound4444 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env4445 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,5401,4096,32768,65536,4096,2341,1024,32768,4096,65544,5377,103445,8,5376,73016,4096,4097,34947,4117,5141,256,38202,4096,5528]

theorem envBound4445 : H12AffineFastState.Bounded env4445 := by
  intro p hp
  have h : env4445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4444_4445 : H12AffineEnvironment.transform 31 5141 env4444 = env4445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5141 env4444 == env4445) = true)

theorem identity4445 : scanCanonicalize (H12AffineFastState.compose env4445 (packedSelected [5,10,19] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4445 : packedSelected [5,10,19] rootPS < 2^1333 := by decide +kernel

def env4446 : List Nat := [2,4,8,16,32,16,8,256,1,1024,2048,4096,5401,4096,32768,65536,4096,2341,1024,32768,4096,65544,5377,103445,8,5376,73016,4096,4097,34827,4117,5141,256,38202,4096,5392]

theorem envBound4446 : H12AffineFastState.Bounded env4446 := by
  intro p hp
  have h : env4446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4445_4446 : H12AffineEnvironment.transform 6 8 env4445 = env4446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4445 == env4446) = true)

theorem identity4446 : scanCanonicalize (H12AffineFastState.compose env4446 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(14+1) ^^^ 5141) := by decide +kernel

theorem selectedBound4446 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4447 : List Nat := [2,4,8,16,32,16,8,256,1,1024,2048,4096,5401,4096,5141,65536,4096,2341,1024,5141,4096,65544,5377,65536,8,5376,73016,4096,4097,7198,4117,5141,256,303,4096,5392]

theorem envBound4447 : H12AffineFastState.Bounded env4447 := by
  intro p hp
  have h : env4447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4446_4447 : H12AffineEnvironment.transform 14 5141 env4446 = env4447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5141 env4446 == env4447) = true)

theorem identity4447 : scanCanonicalize (H12AffineFastState.compose env4447 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 7190) := by decide +kernel

theorem selectedBound4447 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env4448 : List Nat := [2,4,8,16,32,16,8,256,1,1024,2048,4096,5401,4096,5141,7190,4096,2341,1024,5141,4096,7198,5377,7190,8,5376,302,4096,4097,7198,4117,5141,256,303,4096,5392]

theorem envBound4448 : H12AffineFastState.Bounded env4448 := by
  intro p hp
  have h : env4448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4447_4448 : H12AffineEnvironment.transform 15 7190 env4447 = env4448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 7190 env4447 == env4448) = true)

theorem identity4448 : scanCanonicalize (H12AffineFastState.compose env4448 (packedSelected [0,2,3,4,6,11,13] rootPS)) = affineNative (2^(11+1) ^^^ 42) := by decide +kernel

theorem selectedBound4448 : packedSelected [0,2,3,4,6,11,13] rootPS < 2^1333 := by decide +kernel

def env4449 : List Nat := [2,4,8,16,32,16,8,256,1,1024,2048,42,1331,42,1087,3132,42,2341,1024,1087,42,3124,1323,3132,8,1322,302,42,43,3124,63,1087,256,303,42,1338]

theorem envBound4449 : H12AffineFastState.Bounded env4449 := by
  intro p hp
  have h : env4449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4448_4449 : H12AffineEnvironment.transform 11 42 env4448 = env4449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 42 env4448 == env4449) = true)

theorem identity4449 : scanCanonicalize (H12AffineFastState.compose env4449 (packedSelected [1,2,3,6,7,9,11] rootPS)) = affineNative (2^(10+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4449 : packedSelected [1,2,3,6,7,9,11] rootPS < 2^1333 := by decide +kernel

def env4450 : List Nat := [2,4,8,16,32,16,8,256,1,1024,1296,42,1331,42,1087,300,42,1077,1024,1087,42,292,1323,300,8,1322,302,42,43,292,63,1087,256,303,42,1338]

theorem envBound4450 : H12AffineFastState.Bounded env4450 := by
  intro p hp
  have h : env4450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4449_4450 : H12AffineEnvironment.transform 10 1296 env4449 = env4450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1296 env4449 == env4450) = true)

theorem identity4450 : scanCanonicalize (H12AffineFastState.compose env4450 (packedSelected [6,10] rootPS)) = affineNative (2^(9+1) ^^^ 267) := by decide +kernel

theorem selectedBound4450 : packedSelected [6,10] rootPS < 2^1333 := by decide +kernel

def env4451 : List Nat := [2,4,8,16,32,16,8,256,1,267,27,42,56,42,308,300,42,318,267,308,42,292,32,300,8,33,302,42,43,292,63,308,256,303,42,49]

theorem envBound4451 : H12AffineFastState.Bounded env4451 := by
  intro p hp
  have h : env4451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4450_4451 : H12AffineEnvironment.transform 9 267 env4450 = env4451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 267 env4450 == env4451) = true)

theorem identity4451 : scanCanonicalize (H12AffineFastState.compose env4451 (packedSelected [0,3,4,7,9] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound4451 : packedSelected [0,3,4,7,9] rootPS < 2^1333 := by decide +kernel

def env4452 : List Nat := [2,4,8,16,32,16,8,15,1,4,27,42,56,42,59,35,42,49,4,59,42,43,32,35,8,33,33,42,43,43,63,59,15,32,42,49]

theorem envBound4452 : H12AffineFastState.Bounded env4452 := by
  intro p hp
  have h : env4452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4451_4452 : H12AffineEnvironment.transform 7 15 env4451 = env4452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env4451 == env4452) = true)

theorem identity4452 : scanCanonicalize (H12AffineFastState.compose env4452 (packedSelected [1,2] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound4452 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env4453 : List Nat := [2,4,8,16,17,16,8,15,1,4,27,27,9,27,10,18,27,0,4,10,27,26,17,18,8,16,16,27,26,26,14,10,15,17,27,0]

theorem envBound4453 : H12AffineFastState.Bounded env4453 := by
  intro p hp
  have h : env4453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4452_4453 : H12AffineEnvironment.transform 4 17 env4452 = env4453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env4452 == env4453) = true)

theorem identity4453 : scanCanonicalize (H12AffineFastState.compose env4453 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4453 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4454 : List Nat := [2,4,8,0,1,0,8,15,1,4,11,11,9,11,10,2,11,0,4,10,11,10,1,2,8,0,0,11,10,10,14,10,15,1,11,0]

theorem envBound4454 : H12AffineFastState.Bounded env4454 := by
  intro p hp
  have h : env4454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4453_4454 : H12AffineEnvironment.transform 3 0 env4453 = env4454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4453 == env4454) = true)

def env4455 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,5401,4096,32768,65536,4096,262144,1024,32768,4096,65544,5377,103445,8,5377,332829,4097,4097,34946,4117,4294967296,256,4295000366,4096,5528]

theorem envBound4455 : H12AffineFastState.Bounded env4455 := by
  intro p hp
  have h : env4455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4442_4455 : H12AffineEnvironment.transform 25 5377 env4442 = env4455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env4442 == env4455) = true)

theorem identity4455 : scanCanonicalize (H12AffineFastState.compose env4455 (packedSelected [1,3,8] rootPS)) = affineNative (2^(11+1) ^^^ 1433) := by decide +kernel

theorem selectedBound4455 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env4456 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1433,128,1433,32768,65536,1433,262144,1024,32768,1433,65544,152,98700,8,152,328068,1432,1432,34946,1420,4294967296,256,4295000366,1433,1]

theorem envBound4456 : H12AffineFastState.Bounded env4456 := by
  intro p hp
  have h : env4456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4455_4456 : H12AffineEnvironment.transform 11 1433 env4455 = env4456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1433 env4455 == env4456) = true)

theorem identity4456 : scanCanonicalize (H12AffineFastState.compose env4456 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 268) := by decide +kernel

theorem selectedBound4456 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4457 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1433,128,1433,32768,268,1433,262144,1024,32768,1433,260,152,32896,8,152,262280,1432,1432,34946,1420,4294967296,256,4295000366,1433,1]

theorem envBound4457 : H12AffineFastState.Bounded env4457 := by
  intro p hp
  have h : env4457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4456_4457 : H12AffineEnvironment.transform 15 268 env4456 = env4457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 268 env4456 == env4457) = true)

theorem identity4457 : scanCanonicalize (H12AffineFastState.compose env4457 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 162) := by decide +kernel

theorem selectedBound4457 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4458 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1433,128,1433,32768,268,1433,262144,1024,32768,1433,260,152,32896,8,152,262280,1432,1432,34946,1420,162,256,33164,1433,1]

theorem envBound4458 : H12AffineFastState.Bounded env4458 := by
  intro p hp
  have h : env4458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4457_4458 : H12AffineEnvironment.transform 31 162 env4457 = env4458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 162 env4457 == env4458) = true)

theorem identity4458 : scanCanonicalize (H12AffineFastState.compose env4458 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound4458 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4459 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1433,128,1433,260,268,1433,262144,1024,260,1433,260,152,388,8,152,262280,1432,1432,2438,1420,162,256,136,1433,1]

theorem envBound4459 : H12AffineFastState.Bounded env4459 := by
  intro p hp
  have h : env4459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4458_4459 : H12AffineEnvironment.transform 14 260 env4458 = env4459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env4458 == env4459) = true)

theorem identity4459 : scanCanonicalize (H12AffineFastState.compose env4459 (packedSelected [1,3,10,26] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4459 : packedSelected [1,3,10,26] rootPS < 2^1333 := by decide +kernel

def env4460 : List Nat := [2,4,8,16,32,16,8,256,1,1024,2048,1297,8,1297,260,268,1297,262144,1024,260,1297,260,16,268,8,16,262144,1296,1296,2318,1284,42,256,0,1297,1]

theorem envBound4460 : H12AffineFastState.Bounded env4460 := by
  intro p hp
  have h : env4460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4459_4460 : H12AffineEnvironment.transform 6 8 env4459 = env4460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4459 == env4460) = true)

theorem identity4460 : scanCanonicalize (H12AffineFastState.compose env4460 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 284) := by decide +kernel

theorem selectedBound4460 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4461 : List Nat := [2,4,8,16,32,16,8,256,1,1024,2048,1297,8,1297,260,268,1297,284,1024,260,1297,260,16,268,8,16,284,1296,1296,2318,1284,42,256,0,1297,1]

theorem envBound4461 : H12AffineFastState.Bounded env4461 := by
  intro p hp
  have h : env4461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4460_4461 : H12AffineEnvironment.transform 17 284 env4460 = env4461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 284 env4460 == env4461) = true)

theorem identity4461 : scanCanonicalize (H12AffineFastState.compose env4461 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound4461 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env4462 : List Nat := [2,4,8,16,32,16,8,256,1,47,2048,318,8,318,260,268,318,284,47,260,318,260,16,268,8,16,284,319,319,2318,299,42,256,0,318,1]

theorem envBound4462 : H12AffineFastState.Bounded env4462 := by
  intro p hp
  have h : env4462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4461_4462 : H12AffineEnvironment.transform 9 47 env4461 = env4462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env4461 == env4462) = true)

theorem identity4462 : scanCanonicalize (H12AffineFastState.compose env4462 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 310) := by decide +kernel

theorem selectedBound4462 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env4463 : List Nat := [2,4,8,16,32,16,8,256,1,47,310,318,8,318,260,268,318,284,47,260,318,260,16,268,8,16,284,319,319,56,299,42,256,0,318,1]

theorem envBound4463 : H12AffineFastState.Bounded env4463 := by
  intro p hp
  have h : env4463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4462_4463 : H12AffineEnvironment.transform 10 310 env4462 = env4463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 310 env4462 == env4463) = true)

theorem identity4463 : scanCanonicalize (H12AffineFastState.compose env4463 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound4463 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4464 : List Nat := [2,4,8,16,32,16,8,36,1,47,18,26,8,26,32,40,26,56,47,32,26,32,16,40,8,16,56,27,27,56,15,42,36,0,26,1]

theorem envBound4464 : H12AffineFastState.Bounded env4464 := by
  intro p hp
  have h : env4464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4463_4464 : H12AffineEnvironment.transform 7 36 env4463 = env4464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4463 == env4464) = true)

theorem identity4464 : scanCanonicalize (H12AffineFastState.compose env4464 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4464 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4465 : List Nat := [2,4,8,16,0,16,8,4,1,15,18,26,8,26,0,8,26,24,15,0,26,0,16,8,8,16,24,27,27,24,15,10,4,0,26,1]

theorem envBound4465 : H12AffineFastState.Bounded env4465 := by
  intro p hp
  have h : env4465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4464_4465 : H12AffineEnvironment.transform 4 0 env4464 = env4465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4464 == env4465) = true)

theorem identity4465 : scanCanonicalize (H12AffineFastState.compose env4465 (packedSelected [0,4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4465 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env4466 : List Nat := [2,4,2,16,0,16,2,4,1,5,18,16,2,16,0,2,16,18,5,0,16,0,16,2,2,16,18,17,17,18,5,0,4,0,16,1]

theorem envBound4466 : H12AffineFastState.Bounded env4466 := by
  intro p hp
  have h : env4466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4465_4466 : H12AffineEnvironment.transform 2 2 env4465 = env4466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4465 == env4466) = true)

theorem identity4466 : scanCanonicalize (H12AffineFastState.compose env4466 (packedSelected [11] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound4466 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4467 : List Nat := [2,4,2,2,0,2,2,4,1,5,0,2,2,2,0,2,2,0,5,0,2,0,2,2,2,2,0,3,3,0,5,0,4,0,2,1]

theorem envBound4467 : H12AffineFastState.Bounded env4467 := by
  intro p hp
  have h : env4467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4466_4467 : H12AffineEnvironment.transform 3 2 env4466 = env4467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env4466 == env4467) = true)

def leafEnv4467 : List Nat := [2,4,2,2,0,2,2,4,1,5,0,2,2,2,0,2,2,0,5,0,2,0,2,2,5,2,1,2,0,3,3,0,5,0,4,0,4,2,2,1,0,2,1]

def active4467 : List Nat := [0,1]

def tree4467 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4467 : H12WitnessSearch.Good tree4467 := H12GlobalWitnessIndex.good

theorem leafIdentity4467 : H12AffineFastState.composeSystem env4467 rootObs = leafEnv4467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4467 rootObs == leafEnv4467) = true)

theorem terminalChecked4467 : H12PackedTerminal.terminalCheckFast leafEnv4467 active4467 tree4467 = true := by decide +kernel

def env4468 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,262144,1024,32768,4096,65544,5376,103444,8,67108864,332828,67110145,4096,67149187,4116,4294967296,256,4362117431,4096,8832]

theorem envBound4468 : H12AffineFastState.Bounded env4468 := by
  intro p hp
  have h : env4468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4411_4468 : H12AffineEnvironment.transform 5 17 env4411 = env4468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4411 == env4468) = true)

theorem identity4468 : scanCanonicalize (H12AffineFastState.compose env4468 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound4468 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env4469 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1024,32768,4096,65544,5376,103444,8,67108864,113716,67110145,4096,67149187,4116,4294967296,256,4362117431,4096,8832]

theorem envBound4469 : H12AffineFastState.Bounded env4469 := by
  intro p hp
  have h : env4469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4468_4469 : H12AffineEnvironment.transform 17 43048 env4468 = env4469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env4468 == env4469) = true)

theorem identity4469 : scanCanonicalize (H12AffineFastState.compose env4469 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(15+1) ^^^ 46110) := by decide +kernel

theorem selectedBound4469 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4470 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,46110,4096,43048,1024,32768,4096,46102,5376,8202,8,67108864,2090,67110145,4096,67149187,4116,4294967296,256,4362117431,4096,8832]

theorem envBound4470 : H12AffineFastState.Bounded env4470 := by
  intro p hp
  have h : env4470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4469_4470 : H12AffineEnvironment.transform 15 46110 env4469 = env4470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 46110 env4469 == env4470) = true)

theorem identity4470 : scanCanonicalize (H12AffineFastState.compose env4470 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(25+1) ^^^ 13697) := by decide +kernel

theorem selectedBound4470 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env4471 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,46110,4096,43048,1024,32768,4096,46102,5376,8202,8,13697,2090,12416,4096,43010,4116,4294967296,256,4295005366,4096,8832]

theorem envBound4471 : H12AffineFastState.Bounded env4471 := by
  intro p hp
  have h : env4471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4470_4471 : H12AffineEnvironment.transform 25 13697 env4470 = env4471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 13697 env4470 == env4471) = true)

theorem identity4471 : scanCanonicalize (H12AffineFastState.compose env4471 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(14+1) ^^^ 16178) := by decide +kernel

theorem selectedBound4471 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env4472 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,16178,2860,4096,5914,1024,16178,4096,2852,5376,8202,8,13697,2090,12416,4096,5936,4116,4294967296,256,4294978436,4096,8832]

theorem envBound4472 : H12AffineFastState.Bounded env4472 := by
  intro p hp
  have h : env4472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4471_4472 : H12AffineEnvironment.transform 14 16178 env4471 = env4472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 16178 env4471 == env4472) = true)

theorem identity4472 : scanCanonicalize (H12AffineFastState.compose env4472 (packedSelected [0,1,3,5,7,8,12,13,15,16,17] rootPS)) = affineNative (2^(12+1) ^^^ 5278) := by decide +kernel

theorem selectedBound4472 : packedSelected [0,1,3,5,7,8,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env4473 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,5278,4097,2988,2860,4096,5914,1024,2988,4096,2852,5376,5268,8,287,2090,1054,4096,5936,4116,4294967296,256,4294975258,4096,5662]

theorem envBound4473 : H12AffineFastState.Bounded env4473 := by
  intro p hp
  have h : env4473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4472_4473 : H12AffineEnvironment.transform 12 5278 env4472 = env4473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5278 env4472 == env4473) = true)

theorem identity4473 : scanCanonicalize (H12AffineFastState.compose env4473 (packedSelected [8,10,11,13,15,16,18] rootPS)) = affineNative (2^(10+1) ^^^ 814) := by decide +kernel

theorem selectedBound4473 : packedSelected [8,10,11,13,15,16,18] rootPS < 2^1333 := by decide +kernel

def env4474 : List Nat := [2,4,8,16,32,17,128,256,512,1024,814,4096,5278,4097,130,2,4096,5914,1024,130,4096,10,5376,5268,8,287,772,1054,4096,5936,4116,4294967296,256,4294972468,4096,5662]

theorem envBound4474 : H12AffineFastState.Bounded env4474 := by
  intro p hp
  have h : env4474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4473_4474 : H12AffineEnvironment.transform 10 814 env4473 = env4474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 814 env4473 == env4474) = true)

theorem identity4474 : scanCanonicalize (H12AffineFastState.compose env4474 (packedSelected [0,2,4,5,11,12] rootPS)) = affineNative (2^(11+1) ^^^ 539) := by decide +kernel

theorem selectedBound4474 : packedSelected [0,2,4,5,11,12] rootPS < 2^1333 := by decide +kernel

def env4475 : List Nat := [2,4,8,16,32,17,128,256,512,1024,814,539,1669,538,130,2,539,1281,1024,130,539,10,1819,1679,8,287,772,1054,539,1323,527,4294967296,256,4294968879,539,1029]

theorem envBound4475 : H12AffineFastState.Bounded env4475 := by
  intro p hp
  have h : env4475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4474_4475 : H12AffineEnvironment.transform 11 539 env4474 = env4475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 539 env4474 == env4475) = true)

theorem identity4475 : scanCanonicalize (H12AffineFastState.compose env4475 (packedSelected [0,2,3,5,6,9,11,13] rootPS)) = affineNative (2^(9+1) ^^^ 167) := by decide +kernel

theorem selectedBound4475 : packedSelected [0,2,3,5,6,9,11,13] rootPS < 2^1333 := by decide +kernel

def env4476 : List Nat := [2,4,8,16,32,17,128,256,512,167,814,539,546,538,130,2,539,422,167,130,539,10,956,552,8,287,772,185,539,396,527,4294967296,256,4294967944,539,162]

theorem envBound4476 : H12AffineFastState.Bounded env4476 := by
  intro p hp
  have h : env4476.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4475_4476 : H12AffineEnvironment.transform 9 167 env4475 = env4476 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 167 env4475 == env4476) = true)

theorem identity4476 : scanCanonicalize (H12AffineFastState.compose env4476 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound4476 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4477 : List Nat := [2,4,8,16,32,17,128,256,42,167,260,49,8,48,130,2,49,422,167,130,49,10,406,2,8,287,302,185,49,396,37,4294967296,256,4294967458,49,162]

theorem envBound4477 : H12AffineFastState.Bounded env4477 := by
  intro p hp
  have h : env4477.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4476_4477 : H12AffineEnvironment.transform 8 42 env4476 = env4477 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env4476 == env4477) = true)

theorem identity4477 : scanCanonicalize (H12AffineFastState.compose env4477 (packedSelected [0,1,3,7,11] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound4477 : packedSelected [0,1,3,7,11] rootPS < 2^1333 := by decide +kernel

def env4478 : List Nat := [2,4,8,16,32,17,128,135,42,167,131,49,8,48,130,2,49,33,167,130,49,10,17,2,8,152,169,185,49,11,37,4294967296,135,4294967458,49,162]

theorem envBound4478 : H12AffineFastState.Bounded env4478 := by
  intro p hp
  have h : env4478.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4477_4478 : H12AffineEnvironment.transform 7 135 env4477 = env4478 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env4477 == env4478) = true)

theorem identity4478 : scanCanonicalize (H12AffineFastState.compose env4478 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 131) := by decide +kernel

theorem selectedBound4478 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4479 : List Nat := [2,4,8,16,32,17,128,135,42,167,131,49,8,48,130,2,49,33,167,130,49,10,17,2,8,152,169,185,49,11,37,131,135,33,49,162]

theorem envBound4479 : H12AffineFastState.Bounded env4479 := by
  intro p hp
  have h : env4479.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4478_4479 : H12AffineEnvironment.transform 31 131 env4478 = env4479 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 131 env4478 == env4479) = true)

theorem identity4479 : scanCanonicalize (H12AffineFastState.compose env4479 (packedSelected [0,3,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4479 : packedSelected [0,3,4] rootPS < 2^1333 := by decide +kernel

def env4480 : List Nat := [2,4,8,16,1,17,128,135,11,134,131,16,8,17,130,2,16,0,134,130,16,10,17,2,8,152,136,152,16,11,4,131,135,0,16,131]

theorem envBound4480 : H12AffineFastState.Bounded env4480 := by
  intro p hp
  have h : env4480.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4479_4480 : H12AffineEnvironment.transform 4 1 env4479 = env4480 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4479 == env4480) = true)

theorem identity4480 : scanCanonicalize (H12AffineFastState.compose env4480 (packedSelected [2,3] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound4480 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env4481 : List Nat := [2,4,8,16,1,17,3,4,11,5,0,16,8,17,1,2,16,0,5,1,16,10,17,2,8,27,11,27,16,11,4,0,4,0,16,0]

theorem envBound4481 : H12AffineFastState.Bounded env4481 := by
  intro p hp
  have h : env4481.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4480_4481 : H12AffineEnvironment.transform 6 3 env4480 = env4481 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env4480 == env4481) = true)

def env4482 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5457,103492,4259840,67108864,4461636,67110224,4176,71409035,4164,4294967296,256,4362117479,4097,4268680]

theorem envBound4482 : H12AffineFastState.Bounded env4482 := by
  intro p hp
  have h : env4482.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4409_4482 : H12AffineEnvironment.transform 16 4097 env4409 = env4482 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env4409 == env4482) = true)

theorem identity4482 : scanCanonicalize (H12AffineFastState.compose env4482 (packedSelected [3,5,24] rootPS)) = affineNative (2^(12+1) ^^^ 520) := by decide +kernel

theorem selectedBound4482 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4483 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,520,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5457,103492,4259840,67108864,4461636,67110224,4176,71409035,4164,4294967296,256,4362109807,4097,4259968]

theorem envBound4483 : H12AffineFastState.Bounded env4483 := by
  intro p hp
  have h : env4483.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4482_4483 : H12AffineEnvironment.transform 12 520 env4482 = env4483 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 520 env4482 == env4483) = true)

def env4484 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,520,4176,32768,65536,4097,35360,1024,32768,4096,4194304,5457,103492,4259840,67108864,4234852,67110224,4176,71409035,4164,4294967296,256,4362109807,4097,4259968]

theorem envBound4484 : H12AffineFastState.Bounded env4484 := by
  intro p hp
  have h : env4484.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4483_4484 : H12AffineEnvironment.transform 17 35360 env4483 = env4484 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 35360 env4483 == env4484) = true)

theorem identity4484 : scanCanonicalize (H12AffineFastState.compose env4484 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 38478) := by decide +kernel

theorem selectedBound4484 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4485 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,520,4176,32768,65536,4097,35360,1024,32768,4096,38478,5457,103492,104014,67108864,2090,67110224,4176,67177413,4164,4294967296,256,4362109807,4097,104142]

theorem envBound4485 : H12AffineFastState.Bounded env4485 := by
  intro p hp
  have h : env4485.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4484_4485 : H12AffineEnvironment.transform 21 38478 env4484 = env4485 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 38478 env4484 == env4485) = true)

theorem identity4485 : scanCanonicalize (H12AffineFastState.compose env4485 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(25+1) ^^^ 98767) := by decide +kernel

theorem selectedBound4485 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env4486 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,520,4176,32768,65536,4097,35360,1024,32768,4096,38478,5457,103492,104014,98767,2090,99487,4176,35338,4164,4294967296,256,4295033504,4097,104142]

theorem envBound4486 : H12AffineFastState.Bounded env4486 := by
  intro p hp
  have h : env4486.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4485_4486 : H12AffineEnvironment.transform 25 98767 env4485 = env4486 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 98767 env4485 == env4486) = true)

theorem identity4486 : scanCanonicalize (H12AffineFastState.compose env4486 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(15+1) ^^^ 2940) := by decide +kernel

theorem selectedBound4486 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env4487 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,520,4176,32768,2940,4097,35360,1024,32768,4096,38478,5457,40760,40242,35507,2090,36835,4176,35338,4164,4294967296,256,4294969820,4097,40370]

theorem envBound4487 : H12AffineFastState.Bounded env4487 := by
  intro p hp
  have h : env4487.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4486_4487 : H12AffineEnvironment.transform 15 2940 env4486 = env4487 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2940 env4486 == env4487) = true)

theorem identity4487 : scanCanonicalize (H12AffineFastState.compose env4487 (packedSelected [1,2,3,5,6,7,8,12,13,15,16,17,18,22] rootPS)) = affineNative (2^(10+1) ^^^ 502) := by decide +kernel

theorem selectedBound4487 : packedSelected [1,2,3,5,6,7,8,12,13,15,16,17,18,22] rootPS < 2^1333 := by decide +kernel

def env4488 : List Nat := [2,4,8,16,32,64,128,256,512,1024,502,4096,520,4176,32768,650,4097,33750,1024,32768,4096,38478,5457,38606,38084,33605,476,34325,4176,33788,4164,4294967296,256,4294967338,4097,37956]

theorem envBound4488 : H12AffineFastState.Bounded env4488 := by
  intro p hp
  have h : env4488.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4487_4488 : H12AffineEnvironment.transform 10 502 env4487 = env4488 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 502 env4487 == env4488) = true)

theorem identity4488 : scanCanonicalize (H12AffineFastState.compose env4488 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(14+1) ^^^ 642) := by decide +kernel

theorem selectedBound4488 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4489 : List Nat := [2,4,8,16,32,64,128,256,512,1024,502,4096,520,4176,642,650,4097,340,1024,642,4096,5324,5457,5196,5702,455,476,1175,4176,382,4164,4294967296,256,4294967338,4097,5830]

theorem envBound4489 : H12AffineFastState.Bounded env4489 := by
  intro p hp
  have h : env4489.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4488_4489 : H12AffineEnvironment.transform 14 642 env4488 = env4489 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 642 env4488 == env4489) = true)

theorem identity4489 : scanCanonicalize (H12AffineFastState.compose env4489 (packedSelected [1,3,4,8,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1222) := by decide +kernel

theorem selectedBound4489 : packedSelected [1,3,4,8,9,16] rootPS < 2^1333 := by decide +kernel

def env4490 : List Nat := [2,4,8,16,32,64,128,256,512,1024,502,1222,520,1174,642,650,1223,340,1024,642,1222,10,407,138,640,455,476,1175,1174,382,1154,4294967296,256,4294967338,1223,512]

theorem envBound4490 : H12AffineFastState.Bounded env4490 := by
  intro p hp
  have h : env4490.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4489_4490 : H12AffineEnvironment.transform 11 1222 env4489 = env4490 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1222 env4489 == env4490) = true)

theorem identity4490 : scanCanonicalize (H12AffineFastState.compose env4490 (packedSelected [0,4,6,7,9] rootPS)) = affineNative (2^(31+1) ^^^ 429) := by decide +kernel

theorem selectedBound4490 : packedSelected [0,4,6,7,9] rootPS < 2^1333 := by decide +kernel

def env4491 : List Nat := [2,4,8,16,32,64,128,256,512,1024,502,1222,520,1174,642,650,1223,340,1024,642,1222,10,407,138,640,455,476,1175,1174,382,1154,429,256,391,1223,512]

theorem envBound4491 : H12AffineFastState.Bounded env4491 := by
  intro p hp
  have h : env4491.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4490_4491 : H12AffineEnvironment.transform 31 429 env4490 = env4491 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 429 env4490 == env4491) = true)

def env4492 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,520,4176,32768,65536,4097,35361,1024,32768,4096,4194304,5457,103492,4259840,67108864,4234853,67110224,4176,71409035,4164,4294967296,256,4362109807,4097,4259968]

theorem envBound4492 : H12AffineFastState.Bounded env4492 := by
  intro p hp
  have h : env4492.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4483_4492 : H12AffineEnvironment.transform 17 35361 env4483 = env4492 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 35361 env4483 == env4492) = true)

theorem identity4492 : scanCanonicalize (H12AffineFastState.compose env4492 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4492 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env4493 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,520,4097,32768,65536,4097,35361,1024,32768,4096,4194304,5376,103445,4259840,67108864,4234804,67110145,4097,71409035,4117,4294967296,256,4362109758,4097,4259968]

theorem envBound4493 : H12AffineFastState.Bounded env4493 := by
  intro p hp
  have h : env4493.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4492_4493 : H12AffineEnvironment.transform 5 17 env4492 = env4493 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4492 == env4493) = true)

theorem identity4493 : scanCanonicalize (H12AffineFastState.compose env4493 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound4493 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4494 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,520,4097,32768,65536,4097,35361,1024,32768,4096,4194304,5376,103445,4259840,5376,4234804,4097,4097,4294795,4117,4294967296,256,4295005758,4097,4259968]

theorem envBound4494 : H12AffineFastState.Bounded env4494 := by
  intro p hp
  have h : env4494.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4493_4494 : H12AffineEnvironment.transform 25 5376 env4493 = env4494 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env4493 == env4494) = true)

theorem identity4494 : scanCanonicalize (H12AffineFastState.compose env4494 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 772) := by decide +kernel

theorem selectedBound4494 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env4495 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,520,4097,772,65536,4097,2341,1024,772,4096,4194304,5376,71441,4259840,5376,4201776,4097,4097,4262799,4117,4294967296,256,4294972730,4097,4259968]

theorem envBound4495 : H12AffineFastState.Bounded env4495 := by
  intro p hp
  have h : env4495.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4494_4495 : H12AffineEnvironment.transform 14 772 env4494 = env4495 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 772 env4494 == env4495) = true)

theorem identity4495 : scanCanonicalize (H12AffineFastState.compose env4495 (packedSelected [1,3,10,13,15] rootPS)) = affineNative (2^(21+1) ^^^ 7711) := by decide +kernel

theorem selectedBound4495 : packedSelected [1,3,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4496 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,520,4097,772,65536,4097,2341,1024,772,4096,7711,5376,71441,73247,5376,815,4097,4097,71056,4117,4294967296,256,4294972730,4097,73375]

theorem envBound4496 : H12AffineFastState.Bounded env4496 := by
  intro p hp
  have h : env4496.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4495_4496 : H12AffineEnvironment.transform 21 7711 env4495 = env4496 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 7711 env4495 == env4496) = true)

theorem identity4496 : scanCanonicalize (H12AffineFastState.compose env4496 (packedSelected [13,17] rootPS)) = affineNative (2^(31+1) ^^^ 5140) := by decide +kernel

theorem selectedBound4496 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env4497 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,520,4097,772,65536,4097,2341,1024,772,4096,7711,5376,71441,73247,5376,815,4097,4097,71056,4117,5140,256,302,4097,73375]

theorem envBound4497 : H12AffineFastState.Bounded env4497 := by
  intro p hp
  have h : env4497.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4496_4497 : H12AffineEnvironment.transform 31 5140 env4496 = env4497 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5140 env4496 == env4497) = true)

theorem identity4497 : scanCanonicalize (H12AffineFastState.compose env4497 (packedSelected [5,10,19] rootPS)) = affineNative (2^(15+1) ^^^ 2446) := by decide +kernel

theorem selectedBound4497 : packedSelected [5,10,19] rootPS < 2^1333 := by decide +kernel

def env4498 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,520,4097,772,2446,4097,2341,1024,772,4096,7711,5376,7839,6033,5376,815,4097,4097,7198,4117,5140,256,302,4097,5905]

theorem envBound4498 : H12AffineFastState.Bounded env4498 := by
  intro p hp
  have h : env4498.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4497_4498 : H12AffineEnvironment.transform 15 2446 env4497 = env4498 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2446 env4497 == env4498) = true)

theorem identity4498 : scanCanonicalize (H12AffineFastState.compose env4498 (packedSelected [1,3,5] rootPS)) = affineNative (2^(11+1) ^^^ 1432) := by decide +kernel

theorem selectedBound4498 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env4499 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1432,520,1433,772,2446,1433,2341,1024,772,1432,2951,152,2823,521,152,815,1433,1433,2438,1421,396,256,302,1433,649]

theorem envBound4499 : H12AffineFastState.Bounded env4499 := by
  intro p hp
  have h : env4499.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4498_4499 : H12AffineEnvironment.transform 11 1432 env4498 = env4499 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1432 env4498 == env4499) = true)

theorem identity4499 : scanCanonicalize (H12AffineFastState.compose env4499 (packedSelected [0,2,9,10,11,12,13,16] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound4499 : packedSelected [0,2,9,10,11,12,13,16] rootPS < 2^1333 := by decide +kernel

def env4500 : List Nat := [2,4,8,16,32,17,128,256,512,5,2048,413,520,412,772,2446,412,2341,5,772,413,2951,152,2823,521,152,815,412,412,2438,392,396,256,302,412,649]

theorem envBound4500 : H12AffineFastState.Bounded env4500 := by
  intro p hp
  have h : env4500.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4499_4500 : H12AffineEnvironment.transform 9 5 env4499 = env4500 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env4499 == env4500) = true)

theorem identity4500 : scanCanonicalize (H12AffineFastState.compose env4500 (packedSelected [0,1,2,3,4,7,9,10,11,13,18] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound4500 : packedSelected [0,1,2,3,4,7,9,10,11,13,18] rootPS < 2^1333 := by decide +kernel

def env4501 : List Nat := [2,4,8,16,32,17,128,31,512,5,2048,130,520,131,539,2193,131,2106,5,539,130,2712,152,2584,521,152,560,131,131,2201,151,147,31,49,131,649]

theorem envBound4501 : H12AffineFastState.Bounded env4501 := by
  intro p hp
  have h : env4501.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4500_4501 : H12AffineEnvironment.transform 7 31 env4500 = env4501 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env4500 == env4501) = true)

theorem identity4501 : scanCanonicalize (H12AffineFastState.compose env4501 (packedSelected [3,10,13] rootPS)) = affineNative (2^(10+1) ^^^ 539) := by decide +kernel

theorem selectedBound4501 : packedSelected [3,10,13] rootPS < 2^1333 := by decide +kernel

def env4502 : List Nat := [2,4,8,16,32,17,128,31,512,5,539,130,520,131,539,650,131,545,5,539,130,131,152,3,521,152,560,131,131,642,151,147,31,49,131,649]

theorem envBound4502 : H12AffineFastState.Bounded env4502 := by
  intro p hp
  have h : env4502.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4501_4502 : H12AffineEnvironment.transform 10 539 env4501 = env4502 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 539 env4501 == env4502) = true)

theorem identity4502 : scanCanonicalize (H12AffineFastState.compose env4502 (packedSelected [0,3,4] rootPS)) = affineNative (2^(8+1) ^^^ 11) := by decide +kernel

theorem selectedBound4502 : packedSelected [0,3,4] rootPS < 2^1333 := by decide +kernel

def env4503 : List Nat := [2,4,8,16,32,17,128,31,11,5,16,130,3,131,16,129,131,42,5,16,130,131,152,3,2,152,59,131,131,137,151,147,31,49,131,130]

theorem envBound4503 : H12AffineFastState.Bounded env4503 := by
  intro p hp
  have h : env4503.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4502_4503 : H12AffineEnvironment.transform 8 11 env4502 = env4503 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 11 env4502 == env4503) = true)

theorem identity4503 : scanCanonicalize (H12AffineFastState.compose env4503 (packedSelected [3,6] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4503 : packedSelected [3,6] rootPS < 2^1333 := by decide +kernel

def env4504 : List Nat := [2,4,2,16,32,17,128,21,1,5,16,130,3,131,16,129,131,32,5,16,130,131,146,3,2,146,49,131,131,131,151,147,21,49,131,130]

theorem envBound4504 : H12AffineFastState.Bounded env4504 := by
  intro p hp
  have h : env4504.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4503_4504 : H12AffineEnvironment.transform 2 2 env4503 = env4504 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4503 == env4504) = true)

theorem identity4504 : scanCanonicalize (H12AffineFastState.compose env4504 (packedSelected [0,2,7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4504 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env4505 : List Nat := [2,4,2,16,1,17,128,21,1,5,16,130,3,131,16,129,131,1,5,16,130,131,146,3,2,146,16,131,131,131,151,147,21,16,131,130]

theorem envBound4505 : H12AffineFastState.Bounded env4505 := by
  intro p hp
  have h : env4505.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4504_4505 : H12AffineEnvironment.transform 4 1 env4504 = env4505 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4504 == env4505) = true)

theorem identity4505 : scanCanonicalize (H12AffineFastState.compose env4505 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4505 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4506 : List Nat := [2,4,2,1,1,0,128,4,1,5,1,130,3,131,1,129,131,1,5,1,130,131,131,3,2,131,1,131,131,131,134,130,4,1,131,130]

theorem envBound4506 : H12AffineFastState.Bounded env4506 := by
  intro p hp
  have h : env4506.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4505_4506 : H12AffineEnvironment.transform 3 1 env4505 = env4506 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4505 == env4506) = true)

theorem identity4506 : scanCanonicalize (H12AffineFastState.compose env4506 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound4506 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4507 : List Nat := [2,4,2,1,1,0,3,4,1,5,1,1,3,0,1,2,0,1,5,1,1,0,0,3,2,0,1,0,0,0,5,1,4,1,0,1]

theorem envBound4507 : H12AffineFastState.Bounded env4507 := by
  intro p hp
  have h : env4507.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4506_4507 : H12AffineEnvironment.transform 6 3 env4506 = env4507 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env4506 == env4507) = true)

theorem identity4507 : scanCanonicalize (H12AffineFastState.compose env4507 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound4507 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4508 : List Nat := [1,4,1,1,1,0,0,4,1,5,1,1,0,0,1,1,0,1,5,1,1,0,0,0,1,0,1,0,0,0,5,1,4,1,0,1]

theorem envBound4508 : H12AffineFastState.Bounded env4508 := by
  intro p hp
  have h : env4508.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4507_4508 : H12AffineEnvironment.transform 0 1 env4507 = env4508 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env4507 == env4508) = true)

def env4509 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4096,4194304,5457,230469,4259841,67108864,4588613,67110224,131153,71409035,131141,4294967296,256,4362252647,131072,4268681]

theorem envBound4509 : H12AffineFastState.Bounded env4509 := by
  intro p hp
  have h : env4509.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4408_4509 : H12AffineEnvironment.transform 24 4259841 env4408 = env4509 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4259841 env4408 == env4509) = true)

def env4510 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,4194304,5457,103493,4259841,67108864,4461637,67110224,4177,71409035,4165,4294967296,256,4362117479,4096,4268681]

theorem envBound4510 : H12AffineFastState.Bounded env4510 := by
  intro p hp
  have h : env4510.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4509_4510 : H12AffineEnvironment.transform 16 4096 env4509 = env4510 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env4509 == env4510) = true)

theorem identity4510 : scanCanonicalize (H12AffineFastState.compose env4510 (packedSelected [3,5,24] rootPS)) = affineNative (2^(25+1) ^^^ 4259913) := by decide +kernel

theorem selectedBound4510 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4511 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,1024,32768,4096,4194304,5457,103493,4259841,4259913,4461637,4261145,4177,40386,4165,4294967296,256,4299268398,4096,4268681]

theorem envBound4511 : H12AffineFastState.Bounded env4511 := by
  intro p hp
  have h : env4511.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4510_4511 : H12AffineEnvironment.transform 25 4259913 env4510 = env4511 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 4259913 env4510 == env4511) = true)

def env4512 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5377,103445,4259841,4259865,4461589,4261145,4097,40338,4117,4294967296,256,4299268398,4096,4268681]

theorem envBound4512 : H12AffineFastState.Bounded env4512 := by
  intro p hp
  have h : env4512.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4511_4512 : H12AffineEnvironment.transform 5 16 env4511 = env4512 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4511 == env4512) = true)

def env4513 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5377,103445,4259841,4259865,4461589,4261145,4097,40338,4117,4294967296,256,4299268398,4096,4268169]

theorem envBound4513 : H12AffineFastState.Bounded env4513 := by
  intro p hp
  have h : env4513.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4512_4513 : H12AffineEnvironment.transform 8 0 env4512 = env4513 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env4512 == env4513) = true)

theorem identity4513 : scanCanonicalize (H12AffineFastState.compose env4513 (packedSelected [5,9,10,22,26] rootPS)) = affineNative (2^(21+1) ^^^ 65665) := by decide +kernel

theorem selectedBound4513 : packedSelected [5,9,10,22,26] rootPS < 2^1333 := by decide +kernel

def env4514 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,65665,5377,103445,128,152,332948,1432,4097,40338,4117,4294967296,256,4295008687,4096,8200]

theorem envBound4514 : H12AffineFastState.Bounded env4514 := by
  intro p hp
  have h : env4514.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4513_4514 : H12AffineEnvironment.transform 21 65665 env4513 = env4514 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65665 env4513 == env4514) = true)

def env4515 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1296,8192,1296,32768,65536,1296,262144,1024,32768,1296,65665,17,98565,128,152,328068,1432,1297,34946,1285,4294967296,256,4295008687,1296,8200]

theorem envBound4515 : H12AffineFastState.Bounded env4515 := by
  intro p hp
  have h : env4515.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4514_4515 : H12AffineEnvironment.transform 11 1296 env4514 = env4515 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4514 == env4515) = true)

theorem identity4515 : scanCanonicalize (H12AffineFastState.compose env4515 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(12+1) ^^^ 129) := by decide +kernel

theorem selectedBound4515 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4516 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1296,129,1296,32768,65536,1296,262144,1024,32768,1296,65665,17,98565,128,152,328068,1432,1297,34946,1285,4294967296,256,4295000366,1296,137]

theorem envBound4516 : H12AffineFastState.Bounded env4516 := by
  intro p hp
  have h : env4516.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4515_4516 : H12AffineEnvironment.transform 12 129 env4515 = env4516 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 129 env4515 == env4516) = true)

theorem identity4516 : scanCanonicalize (H12AffineFastState.compose env4516 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 100773) := by decide +kernel

theorem selectedBound4516 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4517 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1296,129,1296,32768,65536,1296,100773,1024,32768,1296,65665,17,98565,128,152,34849,1432,1297,34946,1285,4294967296,256,4295000366,1296,137]

theorem envBound4517 : H12AffineFastState.Bounded env4517 := by
  intro p hp
  have h : env4517.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4516_4517 : H12AffineEnvironment.transform 17 100773 env4516 = env4517 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100773 env4516 == env4517) = true)

theorem identity4517 : scanCanonicalize (H12AffineFastState.compose env4517 (packedSelected [0,1,3,7,8,20] rootPS)) = affineNative (2^(15+1) ^^^ 32776) := by decide +kernel

theorem selectedBound4517 : packedSelected [0,1,3,7,8,20] rootPS < 2^1333 := by decide +kernel

def env4518 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1296,129,1296,32768,32776,1296,2477,1024,32768,1296,32905,17,269,128,152,34849,1432,1297,34946,1285,4294967296,256,4295000366,1296,137]

theorem envBound4518 : H12AffineFastState.Bounded env4518 := by
  intro p hp
  have h : env4518.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4517_4518 : H12AffineEnvironment.transform 15 32776 env4517 = env4518 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32776 env4517 == env4518) = true)

theorem identity4518 : scanCanonicalize (H12AffineFastState.compose env4518 (packedSelected [3,4,6,9,10,12,15,16] rootPS)) = affineNative (2^(9+1) ^^^ 140) := by decide +kernel

theorem selectedBound4518 : packedSelected [3,4,6,9,10,12,15,16] rootPS < 2^1333 := by decide +kernel

def env4519 : List Nat := [2,4,8,16,32,16,128,256,0,140,2048,412,129,412,32768,32776,412,2477,140,32768,412,32905,17,269,128,152,34849,276,413,34946,393,4294967296,256,4295000366,412,137]

theorem envBound4519 : H12AffineFastState.Bounded env4519 := by
  intro p hp
  have h : env4519.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4518_4519 : H12AffineEnvironment.transform 9 140 env4518 = env4519 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 140 env4518 == env4519) = true)

def env4520 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1297,8192,1297,32768,65536,1297,262144,1024,32768,1297,65665,16,98564,128,152,328069,1432,1296,34947,1284,4294967296,256,4295008687,1297,8200]

theorem envBound4520 : H12AffineFastState.Bounded env4520 := by
  intro p hp
  have h : env4520.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4514_4520 : H12AffineEnvironment.transform 11 1297 env4514 = env4520 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4514 == env4520) = true)

theorem identity4520 : scanCanonicalize (H12AffineFastState.compose env4520 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound4520 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4521 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1297,8,1297,32768,65536,1297,262144,1024,32768,1297,65665,16,98564,128,152,328069,1432,1296,34947,1284,4294967296,256,4295000487,1297,0]

theorem envBound4521 : H12AffineFastState.Bounded env4521 := by
  intro p hp
  have h : env4521.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4520_4521 : H12AffineEnvironment.transform 12 8 env4520 = env4521 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env4520 == env4521) = true)

theorem identity4521 : scanCanonicalize (H12AffineFastState.compose env4521 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 269) := by decide +kernel

theorem selectedBound4521 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4522 : List Nat := [2,4,8,16,32,16,128,256,0,1024,2048,1297,8,1297,32768,269,1297,262144,1024,32768,1297,396,16,32777,128,152,262280,1432,1296,34947,1284,4294967296,256,4295000487,1297,0]

theorem envBound4522 : H12AffineFastState.Bounded env4522 := by
  intro p hp
  have h : env4522.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4521_4522 : H12AffineEnvironment.transform 15 269 env4521 = env4522 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 269 env4521 == env4522) = true)

theorem identity4522 : scanCanonicalize (H12AffineFastState.compose env4522 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound4522 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4523 : List Nat := [2,4,8,16,32,16,128,15,0,1024,2048,1054,8,1054,32768,2,1054,262144,1024,32768,1054,131,16,32777,128,152,262280,1175,1055,34947,1035,4294967296,15,4295000232,1054,0]

theorem envBound4523 : H12AffineFastState.Bounded env4523 := by
  intro p hp
  have h : env4523.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4522_4523 : H12AffineEnvironment.transform 7 15 env4522 = env4523 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env4522 == env4523) = true)

theorem identity4523 : scanCanonicalize (H12AffineFastState.compose env4523 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 11) := by decide +kernel

theorem selectedBound4523 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4524 : List Nat := [2,4,8,16,32,16,128,15,0,1024,2048,1054,8,1054,11,2,1054,262144,1024,11,1054,131,16,2,128,152,262280,1175,1055,2184,1035,4294967296,15,4294967459,1054,0]

theorem envBound4524 : H12AffineFastState.Bounded env4524 := by
  intro p hp
  have h : env4524.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4523_4524 : H12AffineEnvironment.transform 14 11 env4523 = env4524 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 11 env4523 == env4524) = true)

theorem identity4524 : scanCanonicalize (H12AffineFastState.compose env4524 (packedSelected [0,1,3,5] rootPS)) = affineNative (2^(31+1) ^^^ 2202) := by decide +kernel

theorem selectedBound4524 : packedSelected [0,1,3,5] rootPS < 2^1333 := by decide +kernel

def env4525 : List Nat := [2,4,8,16,32,16,128,15,0,1024,2048,1054,8,1054,11,2,1054,262144,1024,11,1054,131,16,2,128,152,262280,1175,1055,2184,1035,2202,15,2105,1054,0]

theorem envBound4525 : H12AffineFastState.Bounded env4525 := by
  intro p hp
  have h : env4525.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4524_4525 : H12AffineEnvironment.transform 31 2202 env4524 = env4525 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2202 env4524 == env4525) = true)

theorem identity4525 : scanCanonicalize (H12AffineFastState.compose env4525 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 2211) := by decide +kernel

theorem selectedBound4525 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env4526 : List Nat := [2,4,8,16,32,16,128,15,0,1024,2048,1054,8,1054,11,2,1054,2211,1024,11,1054,131,16,2,128,152,2091,1175,1055,2184,1035,2202,15,2105,1054,0]

theorem envBound4526 : H12AffineFastState.Bounded env4526 := by
  intro p hp
  have h : env4526.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4525_4526 : H12AffineEnvironment.transform 17 2211 env4525 = env4526 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2211 env4525 == env4526) = true)

theorem identity4526 : scanCanonicalize (H12AffineFastState.compose env4526 (packedSelected [0,3,6] rootPS)) = affineNative (2^(10+1) ^^^ 154) := by decide +kernel

theorem selectedBound4526 : packedSelected [0,3,6] rootPS < 2^1333 := by decide +kernel

def env4527 : List Nat := [2,4,8,16,32,16,128,15,0,1024,154,1054,8,1054,11,2,1054,57,1024,11,1054,131,16,2,128,152,177,1175,1055,18,1035,0,15,163,1054,0]

theorem envBound4527 : H12AffineFastState.Bounded env4527 := by
  intro p hp
  have h : env4527.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4526_4527 : H12AffineEnvironment.transform 10 154 env4526 = env4527 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 154 env4526 == env4527) = true)

theorem identity4527 : scanCanonicalize (H12AffineFastState.compose env4527 (packedSelected [0,2,3,4,11] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound4527 : packedSelected [0,2,3,4,11] rootPS < 2^1333 := by decide +kernel

def env4528 : List Nat := [2,4,8,16,18,16,128,15,0,1024,154,1054,8,1054,11,2,1054,11,1024,11,1054,131,16,2,128,152,131,1175,1055,18,1035,0,15,145,1054,0]

theorem envBound4528 : H12AffineFastState.Bounded env4528 := by
  intro p hp
  have h : env4528.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4527_4528 : H12AffineEnvironment.transform 4 18 env4527 = env4528 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env4527 == env4528) = true)

theorem identity4528 : scanCanonicalize (H12AffineFastState.compose env4528 (packedSelected [0,1,2,4] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4528 : packedSelected [0,1,2,4] rootPS < 2^1333 := by decide +kernel

def env4529 : List Nat := [2,4,8,16,18,16,8,15,0,1024,18,1054,8,1054,11,2,1054,11,1024,11,1054,11,16,2,8,16,11,1055,1055,18,1035,0,15,25,1054,0]

theorem envBound4529 : H12AffineFastState.Bounded env4529 := by
  intro p hp
  have h : env4529.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4528_4529 : H12AffineEnvironment.transform 6 8 env4528 = env4529 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4528 == env4529) = true)

theorem identity4529 : scanCanonicalize (H12AffineFastState.compose env4529 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound4529 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4530 : List Nat := [2,4,8,9,11,9,8,15,0,1024,11,1031,8,1031,11,2,1031,11,1024,11,1031,11,9,2,8,9,11,1030,1030,11,1035,0,15,0,1031,0]

theorem envBound4530 : H12AffineFastState.Bounded env4530 := by
  intro p hp
  have h : env4530.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4529_4530 : H12AffineEnvironment.transform 3 9 env4529 = env4530 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env4529 == env4530) = true)

theorem identity4530 : scanCanonicalize (H12AffineFastState.compose env4530 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4530 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4531 : List Nat := [2,4,2,3,1,3,2,5,0,1024,1,1031,2,1031,1,2,1031,1,1024,1,1031,1,3,2,2,3,1,1030,1030,1,1025,0,5,0,1031,0]

theorem envBound4531 : H12AffineFastState.Bounded env4531 := by
  intro p hp
  have h : env4531.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4530_4531 : H12AffineEnvironment.transform 2 2 env4530 = env4531 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4530 == env4531) = true)

theorem identity4531 : scanCanonicalize (H12AffineFastState.compose env4531 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound4531 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env4532 : List Nat := [2,4,2,3,1,3,2,5,0,5,1,2,2,2,1,2,2,1,5,1,2,1,3,2,2,3,1,3,3,1,4,0,5,0,2,0]

theorem envBound4532 : H12AffineFastState.Bounded env4532 := by
  intro p hp
  have h : env4532.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4531_4532 : H12AffineEnvironment.transform 9 5 env4531 = env4532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env4531 == env4532) = true)

def leafEnv4532 : List Nat := [2,4,2,3,1,3,2,5,0,5,1,2,2,2,1,2,2,1,5,1,2,1,3,2,4,2,1,3,1,3,3,1,4,0,5,0,4,2,2,0,0,2,1]

def active4532 : List Nat := [0,1]

def tree4532 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4532 : H12WitnessSearch.Good tree4532 := H12GlobalWitnessIndex.good

theorem leafIdentity4532 : H12AffineFastState.composeSystem env4532 rootObs = leafEnv4532 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4532 rootObs == leafEnv4532) = true)

theorem terminalChecked4532 : H12PackedTerminal.terminalCheckFast leafEnv4532 active4532 tree4532 = true := by decide +kernel

def env4533 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,8192,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5377,103445,4259841,4259865,4461589,4261145,4097,40338,4117,4294967296,256,4299268398,4096,4268168]

theorem envBound4533 : H12AffineFastState.Bounded env4533 := by
  intro p hp
  have h : env4533.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4512_4533 : H12AffineEnvironment.transform 8 1 env4512 = env4533 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env4512 == env4533) = true)

theorem identity4533 : scanCanonicalize (H12AffineFastState.compose env4533 (packedSelected [5,9,10,22,26] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound4533 : packedSelected [5,9,10,22,26] rootPS < 2^1333 := by decide +kernel

def env4534 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,4096,8,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5377,103445,4259841,4259865,4461589,4261145,4097,40338,4117,4294967296,256,4299260198,4096,4259968]

theorem envBound4534 : H12AffineFastState.Bounded env4534 := by
  intro p hp
  have h : env4534.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4533_4534 : H12AffineEnvironment.transform 12 8 env4533 = env4534 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env4533 == env4534) = true)

def env4535 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1296,8,1296,32768,65536,1296,262144,1024,32768,1296,4194304,17,98565,4259841,4259865,4456709,4261145,1297,34946,1285,4294967296,256,4299260198,1296,4259968]

theorem envBound4535 : H12AffineFastState.Bounded env4535 := by
  intro p hp
  have h : env4535.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4534_4535 : H12AffineEnvironment.transform 11 1296 env4534 = env4535 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4534 == env4535) = true)

theorem identity4535 : scanCanonicalize (H12AffineFastState.compose env4535 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound4535 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4536 : List Nat := [2,4,8,16,32,16,9,256,1,1024,2048,1296,8,1296,32768,65536,1296,262144,1024,32768,1296,4194304,17,98565,4259841,4259865,4456709,4261145,1297,34827,1285,4294967296,256,4299260198,1296,4259849]

theorem envBound4536 : H12AffineFastState.Bounded env4536 := by
  intro p hp
  have h : env4536.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4535_4536 : H12AffineEnvironment.transform 6 9 env4535 = env4536 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env4535 == env4536) = true)

theorem identity4536 : scanCanonicalize (H12AffineFastState.compose env4536 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(21+1) ^^^ 297252) := by decide +kernel

theorem selectedBound4536 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4537 : List Nat := [2,4,8,16,32,16,9,256,1,1024,2048,1296,8,1296,32768,65536,1296,262144,1024,32768,1296,297252,17,98565,362789,362813,34849,363581,1297,34827,1285,4294967296,256,4295297026,1296,362797]

theorem envBound4537 : H12AffineFastState.Bounded env4537 := by
  intro p hp
  have h : env4537.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4536_4537 : H12AffineEnvironment.transform 21 297252 env4536 = env4537 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 297252 env4536 == env4537) = true)

theorem identity4537 : scanCanonicalize (H12AffineFastState.compose env4537 (packedSelected [0,1,3,7,8,20] rootPS)) = affineNative (2^(15+1) ^^^ 32776) := by decide +kernel

theorem selectedBound4537 : packedSelected [0,1,3,7,8,20] rootPS < 2^1333 := by decide +kernel

def env4538 : List Nat := [2,4,8,16,32,16,9,256,1,1024,2048,1296,8,1296,32768,32776,1296,262144,1024,32768,1296,297252,17,269,264493,264501,34849,265269,1297,34827,1285,4294967296,256,4295264266,1296,264485]

theorem envBound4538 : H12AffineFastState.Bounded env4538 := by
  intro p hp
  have h : env4538.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4537_4538 : H12AffineEnvironment.transform 15 32776 env4537 = env4538 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32776 env4537 == env4538) = true)

theorem identity4538 : scanCanonicalize (H12AffineFastState.compose env4538 (packedSelected [3,4,6,9,10,12,15,16] rootPS)) = affineNative (2^(17+1) ^^^ 3361) := by decide +kernel

theorem selectedBound4538 : packedSelected [3,4,6,9,10,12,15,16] rootPS < 2^1333 := by decide +kernel

def env4539 : List Nat := [2,4,8,16,32,16,9,256,1,1024,2048,1296,8,1296,32768,32776,1296,3361,1024,32768,1296,33797,17,269,1036,1044,34849,276,1297,34827,1285,4294967296,256,4295001387,1296,1028]

theorem envBound4539 : H12AffineFastState.Bounded env4539 := by
  intro p hp
  have h : env4539.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4538_4539 : H12AffineEnvironment.transform 17 3361 env4538 = env4539 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 3361 env4538 == env4539) = true)

def env4540 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1297,8,1297,32768,65536,1297,262144,1024,32768,1297,4194304,16,98564,4259841,4259865,4456708,4261145,1296,34947,1284,4294967296,256,4299260198,1297,4259968]

theorem envBound4540 : H12AffineFastState.Bounded env4540 := by
  intro p hp
  have h : env4540.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4534_4540 : H12AffineEnvironment.transform 11 1297 env4534 = env4540 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4534 == env4540) = true)

theorem identity4540 : scanCanonicalize (H12AffineFastState.compose env4540 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(21+1) ^^^ 65665) := by decide +kernel

theorem selectedBound4540 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4541 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1297,8,1297,32768,65536,1297,262144,1024,32768,1297,65665,16,98564,128,152,328069,1432,1296,34947,1284,4294967296,256,4295000487,1297,1]

theorem envBound4541 : H12AffineFastState.Bounded env4541 := by
  intro p hp
  have h : env4541.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4540_4541 : H12AffineEnvironment.transform 21 65665 env4540 = env4541 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65665 env4540 == env4541) = true)

theorem identity4541 : scanCanonicalize (H12AffineFastState.compose env4541 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 269) := by decide +kernel

theorem selectedBound4541 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4542 : List Nat := [2,4,8,16,32,16,128,256,1,1024,2048,1297,8,1297,32768,269,1297,262144,1024,32768,1297,396,16,32777,128,152,262280,1432,1296,34947,1284,4294967296,256,4295000487,1297,1]

theorem envBound4542 : H12AffineFastState.Bounded env4542 := by
  intro p hp
  have h : env4542.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4541_4542 : H12AffineEnvironment.transform 15 269 env4541 = env4542 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 269 env4541 == env4542) = true)

theorem identity4542 : scanCanonicalize (H12AffineFastState.compose env4542 (packedSelected [8,12,13,15,17] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound4542 : packedSelected [8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4543 : List Nat := [2,4,8,16,32,16,128,15,1,1024,2048,1054,8,1054,32768,2,1054,262144,1024,32768,1054,131,16,32777,128,152,262280,1175,1055,34947,1035,4294967296,15,4295000232,1054,1]

theorem envBound4543 : H12AffineFastState.Bounded env4543 := by
  intro p hp
  have h : env4543.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4542_4543 : H12AffineEnvironment.transform 7 15 env4542 = env4543 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env4542 == env4543) = true)

theorem identity4543 : scanCanonicalize (H12AffineFastState.compose env4543 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 11) := by decide +kernel

theorem selectedBound4543 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4544 : List Nat := [2,4,8,16,32,16,128,15,1,1024,2048,1054,8,1054,11,2,1054,262144,1024,11,1054,131,16,2,128,152,262280,1175,1055,2184,1035,4294967296,15,4294967459,1054,1]

theorem envBound4544 : H12AffineFastState.Bounded env4544 := by
  intro p hp
  have h : env4544.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4543_4544 : H12AffineEnvironment.transform 14 11 env4543 = env4544 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 11 env4543 == env4544) = true)

theorem identity4544 : scanCanonicalize (H12AffineFastState.compose env4544 (packedSelected [0,1,3,5] rootPS)) = affineNative (2^(31+1) ^^^ 2202) := by decide +kernel

theorem selectedBound4544 : packedSelected [0,1,3,5] rootPS < 2^1333 := by decide +kernel

def env4545 : List Nat := [2,4,8,16,32,16,128,15,1,1024,2048,1054,8,1054,11,2,1054,262144,1024,11,1054,131,16,2,128,152,262280,1175,1055,2184,1035,2202,15,2105,1054,1]

theorem envBound4545 : H12AffineFastState.Bounded env4545 := by
  intro p hp
  have h : env4545.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4544_4545 : H12AffineEnvironment.transform 31 2202 env4544 = env4545 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2202 env4544 == env4545) = true)

theorem identity4545 : scanCanonicalize (H12AffineFastState.compose env4545 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 2211) := by decide +kernel

theorem selectedBound4545 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env4546 : List Nat := [2,4,8,16,32,16,128,15,1,1024,2048,1054,8,1054,11,2,1054,2211,1024,11,1054,131,16,2,128,152,2091,1175,1055,2184,1035,2202,15,2105,1054,1]

theorem envBound4546 : H12AffineFastState.Bounded env4546 := by
  intro p hp
  have h : env4546.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4545_4546 : H12AffineEnvironment.transform 17 2211 env4545 = env4546 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2211 env4545 == env4546) = true)

theorem identity4546 : scanCanonicalize (H12AffineFastState.compose env4546 (packedSelected [0,3,6] rootPS)) = affineNative (2^(10+1) ^^^ 154) := by decide +kernel

theorem selectedBound4546 : packedSelected [0,3,6] rootPS < 2^1333 := by decide +kernel

def env4547 : List Nat := [2,4,8,16,32,16,128,15,1,1024,154,1054,8,1054,11,2,1054,57,1024,11,1054,131,16,2,128,152,177,1175,1055,18,1035,0,15,163,1054,1]

theorem envBound4547 : H12AffineFastState.Bounded env4547 := by
  intro p hp
  have h : env4547.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4546_4547 : H12AffineEnvironment.transform 10 154 env4546 = env4547 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 154 env4546 == env4547) = true)

theorem identity4547 : scanCanonicalize (H12AffineFastState.compose env4547 (packedSelected [0,2,3,4,11] rootPS)) = affineNative (2^(6+1) ^^^ 59) := by decide +kernel

theorem selectedBound4547 : packedSelected [0,2,3,4,11] rootPS < 2^1333 := by decide +kernel

def env4548 : List Nat := [2,4,8,16,32,16,59,15,1,1024,33,1054,8,1054,11,2,1054,57,1024,11,1054,56,16,2,59,35,10,1068,1055,18,1035,0,15,24,1054,1]

theorem envBound4548 : H12AffineFastState.Bounded env4548 := by
  intro p hp
  have h : env4548.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4547_4548 : H12AffineEnvironment.transform 6 59 env4547 = env4548 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 59 env4547 == env4548) = true)

theorem identity4548 : scanCanonicalize (H12AffineFastState.compose env4548 (packedSelected [1,2,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4548 : packedSelected [1,2,4] rootPS < 2^1333 := by decide +kernel

def env4549 : List Nat := [2,4,8,16,10,16,17,15,1,1024,11,1054,8,1054,11,2,1054,19,1024,11,1054,18,16,2,17,9,10,1030,1055,18,1035,0,15,24,1054,1]

theorem envBound4549 : H12AffineFastState.Bounded env4549 := by
  intro p hp
  have h : env4549.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4548_4549 : H12AffineEnvironment.transform 4 10 env4548 = env4549 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4548 == env4549) = true)

theorem identity4549 : scanCanonicalize (H12AffineFastState.compose env4549 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound4549 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4550 : List Nat := [2,4,8,9,10,9,8,15,1,1024,11,1031,8,1031,11,2,1031,10,1024,11,1031,11,9,2,8,9,10,1030,1030,11,1035,0,15,1,1031,1]

theorem envBound4550 : H12AffineFastState.Bounded env4550 := by
  intro p hp
  have h : env4550.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4549_4550 : H12AffineEnvironment.transform 3 9 env4549 = env4550 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env4549 == env4550) = true)

def env4551 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5376,103444,4259841,4259864,4461588,4261145,4096,40339,4116,4294967296,256,4299268398,4096,4268681]

theorem envBound4551 : H12AffineFastState.Bounded env4551 := by
  intro p hp
  have h : env4551.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4511_4551 : H12AffineEnvironment.transform 5 17 env4511 = env4551 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4511 == env4551) = true)

theorem identity4551 : scanCanonicalize (H12AffineFastState.compose env4551 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound4551 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env4552 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1024,32768,4096,4194304,5376,103444,4259841,4259864,4242492,4261145,4096,40339,4116,4294967296,256,4299268398,4096,4268681]

theorem envBound4552 : H12AffineFastState.Bounded env4552 := by
  intro p hp
  have h : env4552.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4551_4552 : H12AffineEnvironment.transform 17 43048 env4551 = env4552 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env4551 == env4552) = true)

theorem identity4552 : scanCanonicalize (H12AffineFastState.compose env4552 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 46103) := by decide +kernel

theorem selectedBound4552 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4553 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1024,32768,4096,46103,5376,103444,111638,111631,2091,110862,4096,40339,4116,4294967296,256,4295038265,4096,104094]

theorem envBound4553 : H12AffineFastState.Bounded env4553 := by
  intro p hp
  have h : env4553.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4552_4553 : H12AffineEnvironment.transform 21 46103 env4552 = env4553 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 46103 env4552 == env4553) = true)

theorem identity4553 : scanCanonicalize (H12AffineFastState.compose env4553 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(12+1) ^^^ 5520) := by decide +kernel

theorem selectedBound4553 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env4554 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,5520,4097,32768,65536,4096,40376,1024,32768,4096,33159,5376,103444,98694,98719,2091,99486,4096,40339,4116,4294967296,256,4295038265,4096,104094]

theorem envBound4554 : H12AffineFastState.Bounded env4554 := by
  intro p hp
  have h : env4554.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4553_4554 : H12AffineEnvironment.transform 12 5520 env4553 = env4554 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5520 env4553 == env4554) = true)

theorem identity4554 : scanCanonicalize (H12AffineFastState.compose env4554 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(14+1) ^^^ 8114) := by decide +kernel

theorem selectedBound4554 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env4555 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,5520,4097,8114,65536,4096,522,1024,8114,4096,7733,5376,68518,73268,73261,2091,72492,4096,545,4116,4294967296,256,4295038265,4096,67884]

theorem envBound4555 : H12AffineFastState.Bounded env4555 := by
  intro p hp
  have h : env4555.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4554_4555 : H12AffineEnvironment.transform 14 8114 env4554 = env4555 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8114 env4554 == env4555) = true)

theorem identity4555 : scanCanonicalize (H12AffineFastState.compose env4555 (packedSelected [0,7,11,18] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound4555 : packedSelected [0,7,11,18] rootPS < 2^1333 := by decide +kernel

def env4556 : List Nat := [2,4,8,16,32,17,128,15,512,1024,2048,4096,5279,4097,7869,65536,4096,522,1024,7869,4096,7733,5135,68265,73268,73261,2091,72227,4096,545,4116,4294967296,15,4295038006,4096,67619]

theorem envBound4556 : H12AffineFastState.Bounded env4556 := by
  intro p hp
  have h : env4556.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4555_4556 : H12AffineEnvironment.transform 7 15 env4555 = env4556 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env4555 == env4556) = true)

theorem identity4556 : scanCanonicalize (H12AffineFastState.compose env4556 (packedSelected [1,3,5,10,12,17] rootPS)) = affineNative (2^(11+1) ^^^ 3646) := by decide +kernel

theorem selectedBound4556 : packedSelected [1,3,5,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4557 : List Nat := [2,4,8,16,32,17,128,15,512,1024,2048,3646,2721,3647,131,65536,3646,522,1024,131,3646,11,2609,68265,65546,65555,2091,66589,3646,545,3626,4294967296,15,4295035400,3646,67619]

theorem envBound4557 : H12AffineFastState.Bounded env4557 := by
  intro p hp
  have h : env4557.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4556_4557 : H12AffineEnvironment.transform 11 3646 env4556 = env4557 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3646 env4556 == env4557) = true)

theorem identity4557 : scanCanonicalize (H12AffineFastState.compose env4557 (packedSelected [0,2,5,6,9,11] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4557 : packedSelected [0,2,5,6,9,11] rootPS < 2^1333 := by decide +kernel

def env4558 : List Nat := [2,4,8,16,32,17,8,15,512,1024,2048,3646,2601,3647,11,65536,3646,522,1024,11,3646,11,2609,68129,65546,65555,2091,66589,3646,545,3626,4294967296,15,4295035400,3646,67619]

theorem envBound4558 : H12AffineFastState.Bounded env4558 := by
  intro p hp
  have h : env4558.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4557_4558 : H12AffineEnvironment.transform 6 8 env4557 = env4558 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4557 == env4558) = true)

theorem identity4558 : scanCanonicalize (H12AffineFastState.compose env4558 (packedSelected [0,1,3,4,5,7,9] rootPS)) = affineNative (2^(15+1) ^^^ 2595) := by decide +kernel

theorem selectedBound4558 : packedSelected [0,1,3,4,5,7,9] rootPS < 2^1333 := by decide +kernel

def env4559 : List Nat := [2,4,8,16,32,17,8,15,512,1024,2048,3646,2601,3647,11,2595,3646,522,1024,11,3646,11,2609,2,2601,2608,2091,3646,3646,545,3626,4294967296,15,4294967339,3646,512]

theorem envBound4559 : H12AffineFastState.Bounded env4559 := by
  intro p hp
  have h : env4559.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4558_4559 : H12AffineEnvironment.transform 15 2595 env4558 = env4559 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2595 env4558 == env4559) = true)

theorem identity4559 : scanCanonicalize (H12AffineFastState.compose env4559 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 545) := by decide +kernel

theorem selectedBound4559 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env4560 : List Nat := [2,4,8,16,32,17,8,15,512,1024,545,1055,8,1054,11,2,1055,522,1024,11,1055,11,16,2,8,17,522,1055,1055,545,1035,4294967296,15,4294967339,1055,512]

theorem envBound4560 : H12AffineFastState.Bounded env4560 := by
  intro p hp
  have h : env4560.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4559_4560 : H12AffineEnvironment.transform 10 545 env4559 = env4560 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 545 env4559 == env4560) = true)

theorem identity4560 : scanCanonicalize (H12AffineFastState.compose env4560 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 563) := by decide +kernel

theorem selectedBound4560 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4561 : List Nat := [2,4,8,16,32,17,8,15,512,1024,545,1055,8,1054,11,2,1055,522,1024,11,1055,11,16,2,8,17,522,1055,1055,545,1035,563,15,536,1055,512]

theorem envBound4561 : H12AffineFastState.Bounded env4561 := by
  intro p hp
  have h : env4561.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4560_4561 : H12AffineEnvironment.transform 31 563 env4560 = env4561 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 563 env4560 == env4561) = true)

theorem identity4561 : scanCanonicalize (H12AffineFastState.compose env4561 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound4561 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4562 : List Nat := [2,4,8,16,32,17,8,15,42,1024,11,1055,8,1054,11,2,1055,32,1024,11,1055,11,16,2,8,17,32,1055,1055,11,1035,25,15,50,1055,42]

theorem envBound4562 : H12AffineFastState.Bounded env4562 := by
  intro p hp
  have h : env4562.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4561_4562 : H12AffineEnvironment.transform 8 42 env4561 = env4562 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env4561 == env4562) = true)

theorem identity4562 : scanCanonicalize (H12AffineFastState.compose env4562 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound4562 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4563 : List Nat := [2,4,8,16,19,17,8,15,25,1024,11,1055,8,1054,11,2,1055,19,1024,11,1055,11,16,2,8,17,19,1055,1055,11,1035,25,15,1,1055,25]

theorem envBound4563 : H12AffineFastState.Bounded env4563 := by
  intro p hp
  have h : env4563.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4562_4563 : H12AffineEnvironment.transform 4 19 env4562 = env4563 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env4562 == env4563) = true)

def env4564 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5457,103492,4259841,67108864,4461636,67110224,4176,71409035,4164,4294967296,256,4362117478,4097,4268681]

theorem envBound4564 : H12AffineFastState.Bounded env4564 := by
  intro p hp
  have h : env4564.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4509_4564 : H12AffineEnvironment.transform 16 4097 env4509 = env4564 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env4509 == env4564) = true)

theorem identity4564 : scanCanonicalize (H12AffineFastState.compose env4564 (packedSelected [3,5,24] rootPS)) = affineNative (2^(25+1) ^^^ 8777) := by decide +kernel

theorem selectedBound4564 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4565 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,1024,32768,4096,4194304,5457,103492,4259841,8777,4461636,10009,4176,4308930,4164,4294967296,256,4295000879,4097,4268681]

theorem envBound4565 : H12AffineFastState.Bounded env4565 := by
  intro p hp
  have h : env4565.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4564_4565 : H12AffineEnvironment.transform 25 8777 env4564 = env4565 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 8777 env4564 == env4565) = true)

def env4566 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,65536,1345,262144,1024,32768,1344,4194304,17,98564,4259841,8777,4456708,10009,1296,4303490,1284,4294967296,256,4295000879,1345,4268681]

theorem envBound4566 : H12AffineFastState.Bounded env4566 := by
  intro p hp
  have h : env4566.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4565_4566 : H12AffineEnvironment.transform 11 1344 env4565 = env4566 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1344 env4565 == env4566) = true)

theorem identity4566 : scanCanonicalize (H12AffineFastState.compose env4566 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(21+1) ^^^ 73865) := by decide +kernel

theorem selectedBound4566 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4567 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,65536,1345,262144,1024,32768,1344,73865,17,98564,8328,8777,336269,10009,1296,35339,1284,4294967296,256,4295000879,1345,512]

theorem envBound4567 : H12AffineFastState.Bounded env4567 := by
  intro p hp
  have h : env4567.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4566_4567 : H12AffineEnvironment.transform 21 73865 env4566 = env4567 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73865 env4566 == env4567) = true)

theorem identity4567 : scanCanonicalize (H12AffineFastState.compose env4567 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 8453) := by decide +kernel

theorem selectedBound4567 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4568 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,8453,1345,262144,1024,32768,1344,396,17,40961,8328,8777,262280,10009,1296,35339,1284,4294967296,256,4295000879,1345,512]

theorem envBound4568 : H12AffineFastState.Bounded env4568 := by
  intro p hp
  have h : env4568.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4567_4568 : H12AffineEnvironment.transform 15 8453 env4567 = env4568 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8453 env4567 == env4568) = true)

theorem identity4568 : scanCanonicalize (H12AffineFastState.compose env4568 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(14+1) ^^^ 772) := by decide +kernel

theorem selectedBound4568 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env4569 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,772,8453,1345,262144,1024,772,1344,396,17,8965,8328,8777,262280,10009,1296,2319,1284,4294967296,256,4294967339,1345,512]

theorem envBound4569 : H12AffineFastState.Bounded env4569 := by
  intro p hp
  have h : env4569.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4568_4569 : H12AffineEnvironment.transform 14 772 env4568 = env4569 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 772 env4568 == env4569) = true)

theorem identity4569 : scanCanonicalize (H12AffineFastState.compose env4569 (packedSelected [6,25] rootPS)) = affineNative (2^(12+1) ^^^ 520) := by decide +kernel

theorem selectedBound4569 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env4570 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,520,1296,772,781,1345,262144,1024,772,1344,396,17,269,640,65,262280,1297,1296,2319,1284,4294967296,256,4294967339,1345,512]

theorem envBound4570 : H12AffineFastState.Bounded env4570 := by
  intro p hp
  have h : env4570.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4569_4570 : H12AffineEnvironment.transform 12 520 env4569 = env4570 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 520 env4569 == env4570) = true)

theorem identity4570 : scanCanonicalize (H12AffineFastState.compose env4570 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 555) := by decide +kernel

theorem selectedBound4570 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4571 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,520,1296,772,781,1345,262144,1024,772,1344,396,17,269,640,65,262280,1297,1296,2319,1284,555,256,512,1345,512]

theorem envBound4571 : H12AffineFastState.Bounded env4571 := by
  intro p hp
  have h : env4571.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4570_4571 : H12AffineEnvironment.transform 31 555 env4570 = env4571 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 555 env4570 == env4571) = true)

theorem identity4571 : scanCanonicalize (H12AffineFastState.compose env4571 (packedSelected [3,5,10] rootPS)) = affineNative (2^(9+1) ^^^ 559) := by decide +kernel

theorem selectedBound4571 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env4572 : List Nat := [2,4,8,16,32,64,128,256,512,559,2048,879,520,831,772,781,878,262144,559,772,879,396,17,269,640,65,262280,830,831,2319,811,555,256,512,878,512]

theorem envBound4572 : H12AffineFastState.Bounded env4572 := by
  intro p hp
  have h : env4572.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4571_4572 : H12AffineEnvironment.transform 9 559 env4571 = env4572 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 559 env4571 == env4572) = true)

theorem identity4572 : scanCanonicalize (H12AffineFastState.compose env4572 (packedSelected [1,8,12] rootPS)) = affineNative (2^(17+1) ^^^ 2211) := by decide +kernel

theorem selectedBound4572 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env4573 : List Nat := [2,4,8,16,32,64,128,256,512,559,2048,879,520,831,772,781,878,2211,559,772,879,396,17,269,640,65,2091,830,831,2319,811,555,256,512,878,512]

theorem envBound4573 : H12AffineFastState.Bounded env4573 := by
  intro p hp
  have h : env4573.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4572_4573 : H12AffineEnvironment.transform 17 2211 env4572 = env4573 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2211 env4572 == env4573) = true)

theorem identity4573 : scanCanonicalize (H12AffineFastState.compose env4573 (packedSelected [1,3,13] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound4573 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env4574 : List Nat := [2,4,8,16,32,64,128,134,512,559,2048,745,520,697,642,651,744,2211,559,642,745,10,17,139,640,65,2091,696,697,2185,685,555,134,512,744,512]

theorem envBound4574 : H12AffineFastState.Bounded env4574 := by
  intro p hp
  have h : env4574.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4573_4574 : H12AffineEnvironment.transform 7 134 env4573 = env4574 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env4573 == env4574) = true)

theorem identity4574 : scanCanonicalize (H12AffineFastState.compose env4574 (packedSelected [1,3,5] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4574 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env4575 : List Nat := [2,4,8,16,32,17,128,134,512,559,2048,696,520,697,642,651,697,2211,559,642,696,10,17,139,640,16,2091,696,697,2185,685,555,134,512,697,512]

theorem envBound4575 : H12AffineFastState.Bounded env4575 := by
  intro p hp
  have h : env4575.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4574_4575 : H12AffineEnvironment.transform 5 17 env4574 = env4575 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4574 == env4575) = true)

theorem identity4575 : scanCanonicalize (H12AffineFastState.compose env4575 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 146) := by decide +kernel

theorem selectedBound4575 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4576 : List Nat := [2,4,8,16,32,17,128,134,146,189,2048,42,154,43,16,25,43,2211,189,16,42,10,17,139,18,16,2091,42,43,2185,63,185,134,146,43,146]

theorem envBound4576 : H12AffineFastState.Bounded env4576 := by
  intro p hp
  have h : env4576.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4575_4576 : H12AffineEnvironment.transform 8 146 env4575 = env4576 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 146 env4575 == env4576) = true)

theorem identity4576 : scanCanonicalize (H12AffineFastState.compose env4576 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4576 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4577 : List Nat := [2,4,8,16,11,17,128,134,146,150,2048,1,154,0,16,25,0,2184,150,16,1,10,17,139,18,16,2048,1,0,2185,20,146,134,146,0,146]

theorem envBound4577 : H12AffineFastState.Bounded env4577 := by
  intro p hp
  have h : env4577.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4576_4577 : H12AffineEnvironment.transform 4 11 env4576 = env4577 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4576 == env4577) = true)

theorem identity4577 : scanCanonicalize (H12AffineFastState.compose env4577 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound4577 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4578 : List Nat := [2,4,8,16,11,17,19,21,1,5,2048,1,9,0,16,25,0,2075,5,16,1,10,17,24,18,16,2048,1,0,2074,20,1,21,1,0,1]

theorem envBound4578 : H12AffineFastState.Bounded env4578 := by
  intro p hp
  have h : env4578.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4577_4578 : H12AffineEnvironment.transform 6 19 env4577 = env4578 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env4577 == env4578) = true)

theorem identity4578 : scanCanonicalize (H12AffineFastState.compose env4578 (packedSelected [0,4] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound4578 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env4579 : List Nat := [2,4,8,16,11,17,19,21,1,5,26,1,9,0,16,25,0,1,5,16,1,10,17,24,18,16,26,1,0,0,20,1,21,1,0,1]

theorem envBound4579 : H12AffineFastState.Bounded env4579 := by
  intro p hp
  have h : env4579.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4578_4579 : H12AffineEnvironment.transform 10 26 env4578 = env4579 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env4578 == env4579) = true)

def env4580 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,8192,1297,32768,65536,1344,262144,1024,32768,1345,4194304,16,98565,4259841,8777,4456709,10009,1297,4303491,1285,4294967296,256,4295000879,1344,4268681]

theorem envBound4580 : H12AffineFastState.Bounded env4580 := by
  intro p hp
  have h : env4580.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4565_4580 : H12AffineEnvironment.transform 11 1345 env4565 = env4580 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1345 env4565 == env4580) = true)

theorem identity4580 : scanCanonicalize (H12AffineFastState.compose env4580 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(21+1) ^^^ 66176) := by decide +kernel

theorem selectedBound4580 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4581 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,8192,1297,32768,65536,1344,262144,1024,32768,1345,66176,16,98565,641,8777,328581,10009,1297,43011,1285,4294967296,256,4295000879,1344,8201]

theorem envBound4581 : H12AffineFastState.Bounded env4581 := by
  intro p hp
  have h : env4581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4580_4581 : H12AffineEnvironment.transform 21 66176 env4580 = env4581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 66176 env4580 == env4581) = true)

def env4582 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230469,33554432,67108864,4588612,67110225,131153,71409035,131141,4294967296,256,4400066919,131072,33563272]

theorem envBound4582 : H12AffineFastState.Bounded env4582 := by
  intro p hp
  have h : env4582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4407_4582 : H12AffineEnvironment.transform 13 4177 env4407 = env4582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env4407 == env4582) = true)

theorem identity4582 : scanCanonicalize (H12AffineFastState.compose env4582 (packedSelected [1,3,6,10,19,24,25,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound4582 : packedSelected [1,3,6,10,19,24,25,26,28,31] rootPS < 2^1333 := by decide +kernel

def env4583 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230469,8329,67108864,4588612,67110225,131153,71409035,131141,4294967296,256,4366504430,131072,513]

theorem envBound4583 : H12AffineFastState.Bounded env4583 := by
  intro p hp
  have h : env4583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4582_4583 : H12AffineEnvironment.transform 24 8329 env4582 = env4583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env4582 == env4583) = true)

theorem identity4583 : scanCanonicalize (H12AffineFastState.compose env4583 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound4583 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env4584 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230469,8329,5376,4588612,4177,131153,4294795,131141,4294967296,256,4299392238,131072,513]

theorem envBound4584 : H12AffineFastState.Bounded env4584 := by
  intro p hp
  have h : env4584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4583_4584 : H12AffineEnvironment.transform 25 5376 env4583 = env4584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env4583 == env4584) = true)

theorem identity4584 : scanCanonicalize (H12AffineFastState.compose env4584 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 4329689) := by decide +kernel

theorem selectedBound4584 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env4585 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4096,4194304,5456,230469,8329,5376,4588612,4177,131153,4294795,131141,4329689,256,103479,131072,513]

theorem envBound4585 : H12AffineFastState.Bounded env4585 := by
  intro p hp
  have h : env4585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4584_4585 : H12AffineEnvironment.transform 31 4329689 env4584 = env4585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4329689 env4584 == env4585) = true)

def env4586 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17665,230469,33554432,67108864,4609045,67130624,131153,1073741824,131141,4294967296,256,4400079159,131072,33563272]

theorem envBound4586 : H12AffineFastState.Bounded env4586 := by
  intro p hp
  have h : env4586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4405_4586 : H12AffineEnvironment.transform 18 1025 env4405 = env4586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4405 == env4586) = true)

theorem identity4586 : scanCanonicalize (H12AffineFastState.compose env4586 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 71421403) := by decide +kernel

theorem selectedBound4586 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env4587 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17665,230469,33554432,67108864,4609045,67130624,131153,71421403,131141,4294967296,256,4400079159,131072,33563272]

theorem envBound4587 : H12AffineFastState.Bounded env4587 := by
  intro p hp
  have h : env4587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4586_4587 : H12AffineEnvironment.transform 29 71421403 env4586 = env4587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 71421403 env4586 == env4587) = true)

def env4588 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,4194304,5457,230469,33554432,67108864,4588613,67110224,131153,71409035,131141,4294967296,256,4400066919,131072,33563272]

theorem envBound4588 : H12AffineFastState.Bounded env4588 := by
  intro p hp
  have h : env4588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4587_4588 : H12AffineEnvironment.transform 13 4176 env4587 = env4588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env4587 == env4588) = true)

theorem identity4588 : scanCanonicalize (H12AffineFastState.compose env4588 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(25+1) ^^^ 33568137) := by decide +kernel

theorem selectedBound4588 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env4589 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,4194304,5457,230469,33554432,33568137,4588613,33566937,131153,37857282,131141,4294967296,256,4299392238,131072,33563272]

theorem envBound4589 : H12AffineFastState.Bounded env4589 := by
  intro p hp
  have h : env4589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4588_4589 : H12AffineEnvironment.transform 25 33568137 env4588 = env4589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 33568137 env4588 == env4589) = true)

theorem identity4589 : scanCanonicalize (H12AffineFastState.compose env4589 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound4589 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env4590 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,4194304,5457,230469,8328,5377,4588613,4177,131153,4294794,131141,4294967296,256,4299392238,131072,512]

theorem envBound4590 : H12AffineFastState.Bounded env4590 := by
  intro p hp
  have h : env4590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4589_4590 : H12AffineEnvironment.transform 24 8328 env4589 = env4590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env4589 == env4590) = true)

theorem identity4590 : scanCanonicalize (H12AffineFastState.compose env4590 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound4590 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4591 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4096,397,5457,230469,8328,5377,394696,4177,131153,100615,131141,4294967296,256,4295198051,131072,512]

theorem envBound4591 : H12AffineFastState.Bounded env4591 := by
  intro p hp
  have h : env4591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4590_4591 : H12AffineEnvironment.transform 21 397 env4590 = env4591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env4590 == env4591) = true)

theorem identity4591 : scanCanonicalize (H12AffineFastState.compose env4591 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound4591 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env4592 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,1025,32768,4096,397,5457,98565,8328,5377,262280,4177,1297,100615,1285,4294967296,256,4295065635,1344,512]

theorem envBound4592 : H12AffineFastState.Bounded env4592 := by
  intro p hp
  have h : env4592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4591_4592 : H12AffineEnvironment.transform 16 1344 env4591 = env4592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env4591 == env4592) = true)

theorem identity4592 : scanCanonicalize (H12AffineFastState.compose env4592 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 70711) := by decide +kernel

theorem selectedBound4592 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4593 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,1025,32768,4096,397,5457,98565,8328,5377,262280,4177,1297,100615,1285,70711,256,37908,1344,512]

theorem envBound4593 : H12AffineFastState.Bounded env4593 := by
  intro p hp
  have h : env4593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4592_4593 : H12AffineEnvironment.transform 31 70711 env4592 = env4593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 70711 env4592 == env4593) = true)

theorem identity4593 : scanCanonicalize (H12AffineFastState.compose env4593 (packedSelected [3,5,10] rootPS)) = affineNative (2^(14+1) ^^^ 2009) := by decide +kernel

theorem selectedBound4593 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env4594 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,2009,65536,1344,262144,1025,2009,4096,397,5457,67292,8328,5377,262280,4177,1297,69342,1285,70711,256,5069,1344,512]

theorem envBound4594 : H12AffineFastState.Bounded env4594 := by
  intro p hp
  have h : env4594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4593_4594 : H12AffineEnvironment.transform 14 2009 env4593 = env4594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2009 env4593 == env4594) = true)

theorem identity4594 : scanCanonicalize (H12AffineFastState.compose env4594 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 12273) := by decide +kernel

theorem selectedBound4594 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env4595 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,2009,65536,1344,12273,1025,2009,4096,397,5457,67292,8328,5377,12153,4177,1297,69342,1285,70711,256,5069,1344,512]

theorem envBound4595 : H12AffineFastState.Bounded env4595 := by
  intro p hp
  have h : env4595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4594_4595 : H12AffineEnvironment.transform 17 12273 env4594 = env4595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 12273 env4594 == env4595) = true)

theorem identity4595 : scanCanonicalize (H12AffineFastState.compose env4595 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 14155) := by decide +kernel

theorem selectedBound4595 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env4596 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,2009,14155,1344,12273,1025,2009,4096,397,5457,12695,8328,5377,12153,4177,1297,14741,1285,9084,256,5069,1344,512]

theorem envBound4596 : H12AffineFastState.Bounded env4596 := by
  intro p hp
  have h : env4596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4595_4596 : H12AffineEnvironment.transform 15 14155 env4595 = env4596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 14155 env4595 == env4596) = true)

theorem identity4596 : scanCanonicalize (H12AffineFastState.compose env4596 (packedSelected [0,7,20] rootPS)) = affineNative (2^(9+1) ^^^ 653) := by decide +kernel

theorem selectedBound4596 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4597 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,4096,8192,4176,340,12742,973,10620,652,340,4096,397,5084,12695,8328,5004,10740,4177,924,14741,904,9084,256,5069,973,512]

theorem envBound4597 : H12AffineFastState.Bounded env4597 := by
  intro p hp
  have h : env4597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4596_4597 : H12AffineEnvironment.transform 9 653 env4596 = env4597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 653 env4596 == env4597) = true)

theorem identity4597 : scanCanonicalize (H12AffineFastState.compose env4597 (packedSelected [3,5,12,21] rootPS)) = affineNative (2^(12+1) ^^^ 88) := by decide +kernel

theorem selectedBound4597 : packedSelected [3,5,12,21] rootPS < 2^1333 := by decide +kernel

def env4598 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,4096,88,4176,340,4510,973,2340,652,340,4096,397,5084,4559,208,5004,2476,4177,924,6605,904,804,256,5069,973,512]

theorem envBound4598 : H12AffineFastState.Bounded env4598 := by
  intro p hp
  have h : env4598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4597_4598 : H12AffineEnvironment.transform 12 88 env4597 = env4598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 88 env4597 == env4598) = true)

theorem identity4598 : scanCanonicalize (H12AffineFastState.compose env4598 (packedSelected [1,8,12] rootPS)) = affineNative (2^(10+1) ^^^ 302) := by decide +kernel

theorem selectedBound4598 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env4599 : List Nat := [2,4,8,16,32,64,128,256,512,653,302,4096,88,4176,340,4510,973,10,652,340,4096,397,5084,4559,208,5004,130,4177,924,4323,904,804,256,5069,973,512]

theorem envBound4599 : H12AffineFastState.Bounded env4599 := by
  intro p hp
  have h : env4599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4598_4599 : H12AffineEnvironment.transform 10 302 env4598 = env4599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 302 env4598 == env4599) = true)

theorem identity4599 : scanCanonicalize (H12AffineFastState.compose env4599 (packedSelected [11,32] rootPS)) = affineNative (2^(11+1) ^^^ 325) := by decide +kernel

theorem selectedBound4599 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env4600 : List Nat := [2,4,8,16,32,64,128,256,512,653,302,325,88,277,340,219,973,10,652,340,325,397,665,138,208,713,130,276,924,422,904,804,256,648,973,512]

theorem envBound4600 : H12AffineFastState.Bounded env4600 := by
  intro p hp
  have h : env4600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4599_4600 : H12AffineEnvironment.transform 11 325 env4599 = env4600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 325 env4599 == env4600) = true)

theorem identity4600 : scanCanonicalize (H12AffineFastState.compose env4600 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 211) := by decide +kernel

theorem selectedBound4600 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env4601 : List Nat := [2,4,8,16,32,64,128,256,211,94,302,325,88,277,340,219,286,10,95,340,325,397,74,138,208,26,130,276,335,422,347,503,256,91,286,211]

theorem envBound4601 : H12AffineFastState.Bounded env4601 := by
  intro p hp
  have h : env4601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4600_4601 : H12AffineEnvironment.transform 8 211 env4600 = env4601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 211 env4600 == env4601) = true)

def env4602 : List Nat := [2,4,8,16,32,64,8,256,91,94,302,325,88,277,340,83,286,10,95,340,325,261,74,2,88,26,10,276,335,302,347,383,256,91,286,91]

theorem envBound4602 : H12AffineFastState.Bounded env4602 := by
  intro p hp
  have h : env4602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4601_4602 : H12AffineEnvironment.transform 6 8 env4601 = env4602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4601 == env4602) = true)

theorem identity4602 : scanCanonicalize (H12AffineFastState.compose env4602 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 87) := by decide +kernel

theorem selectedBound4602 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4603 : List Nat := [2,4,8,16,32,64,8,87,91,94,121,18,88,66,3,83,73,10,95,3,18,82,74,2,88,26,10,67,24,121,12,40,87,91,73,91]

theorem envBound4603 : H12AffineFastState.Bounded env4603 := by
  intro p hp
  have h : env4603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4602_4603 : H12AffineEnvironment.transform 7 87 env4602 = env4603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 87 env4602 == env4603) = true)

theorem identity4603 : scanCanonicalize (H12AffineFastState.compose env4603 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 50) := by decide +kernel

theorem selectedBound4603 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4604 : List Nat := [2,4,8,16,32,50,8,37,41,44,11,18,42,48,3,33,59,10,45,3,18,32,56,2,42,26,10,49,24,11,12,40,37,41,59,41]

theorem envBound4604 : H12AffineFastState.Bounded env4604 := by
  intro p hp
  have h : env4604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4603_4604 : H12AffineEnvironment.transform 5 50 env4603 = env4604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 50 env4603 == env4604) = true)

theorem identity4604 : scanCanonicalize (H12AffineFastState.compose env4604 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4604 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4605 : List Nat := [2,4,3,16,32,50,3,37,34,39,0,18,33,48,3,33,48,1,38,3,18,32,51,2,33,17,1,49,19,0,7,35,37,34,48,34]

theorem envBound4605 : H12AffineFastState.Bounded env4605 := by
  intro p hp
  have h : env4605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4604_4605 : H12AffineEnvironment.transform 2 3 env4604 = env4605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4604 == env4605) = true)

theorem identity4605 : scanCanonicalize (H12AffineFastState.compose env4605 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound4605 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4606 : List Nat := [1,4,0,16,32,49,0,37,33,36,0,17,33,48,0,33,48,1,37,0,17,32,48,1,33,17,1,49,16,0,4,32,37,33,48,33]

theorem envBound4606 : H12AffineFastState.Bounded env4606 := by
  intro p hp
  have h : env4606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4605_4606 : H12AffineEnvironment.transform 0 1 env4605 = env4606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env4605 == env4606) = true)

theorem identity4606 : scanCanonicalize (H12AffineFastState.compose env4606 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4606 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4607 : List Nat := [1,4,0,16,1,16,0,4,0,5,0,17,0,17,0,0,17,1,4,0,17,1,17,1,0,17,1,16,16,0,4,1,4,0,17,0]

theorem envBound4607 : H12AffineFastState.Bounded env4607 := by
  intro p hp
  have h : env4607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4606_4607 : H12AffineEnvironment.transform 4 1 env4606 = env4607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4606 == env4607) = true)

def leafEnv4607 : List Nat := [1,4,0,16,1,16,0,4,0,5,0,17,0,17,0,0,17,1,4,0,17,1,17,1,5,0,1,17,1,16,16,0,4,1,4,0,4,0,17,0,0,17,1]

def active4607 : List Nat := [1,3]

def tree4607 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4607 : H12WitnessSearch.Good tree4607 := H12GlobalWitnessIndex.good

theorem leafIdentity4607 : H12AffineFastState.composeSystem env4607 rootObs = leafEnv4607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4607 rootObs == leafEnv4607) = true)

theorem terminalChecked4607 : H12PackedTerminal.terminalCheckFast leafEnv4607 active4607 tree4607 = true := by decide +kernel

def env4608 : List Nat := [2,4,8,16,32,64,9,256,90,94,302,325,88,277,340,82,286,10,95,340,325,260,74,3,89,26,11,276,335,303,347,382,256,91,286,90]

theorem envBound4608 : H12AffineFastState.Bounded env4608 := by
  intro p hp
  have h : env4608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4601_4608 : H12AffineEnvironment.transform 6 9 env4601 = env4608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env4601 == env4608) = true)

theorem identity4608 : scanCanonicalize (H12AffineFastState.compose env4608 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 44) := by decide +kernel

theorem selectedBound4608 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4609 : List Nat := [2,4,8,16,32,64,9,44,90,94,2,105,88,57,120,82,50,10,95,120,105,40,74,3,89,26,11,56,99,3,119,82,44,91,50,90]

theorem envBound4609 : H12AffineFastState.Bounded env4609 := by
  intro p hp
  have h : env4609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4608_4609 : H12AffineEnvironment.transform 7 44 env4608 = env4609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 44 env4608 == env4609) = true)

theorem identity4609 : scanCanonicalize (H12AffineFastState.compose env4609 (packedSelected [1,3] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound4609 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4610 : List Nat := [0,4,8,16,32,64,9,44,88,92,0,105,88,57,120,80,48,8,93,120,105,40,72,1,89,24,9,56,97,1,117,80,44,89,48,88]

theorem envBound4610 : H12AffineFastState.Bounded env4610 := by
  intro p hp
  have h : env4610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4609_4610 : H12AffineEnvironment.transform 0 0 env4609 = env4610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env4609 == env4610) = true)

def env4611 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4096,4194304,5456,230469,33554432,67108864,4588612,67110225,131153,71409034,131141,4294967296,256,4400066918,131072,33563272]

theorem envBound4611 : H12AffineFastState.Bounded env4611 := by
  intro p hp
  have h : env4611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4587_4611 : H12AffineEnvironment.transform 13 4177 env4587 = env4611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env4587 == env4611) = true)

theorem identity4611 : scanCanonicalize (H12AffineFastState.compose env4611 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(25+1) ^^^ 5377) := by decide +kernel

theorem selectedBound4611 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env4612 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4096,4194304,5456,230469,33554432,5377,4588612,4176,131153,4294795,131141,4294967296,256,4332954727,131072,33563272]

theorem envBound4612 : H12AffineFastState.Bounded env4612 := by
  intro p hp
  have h : env4612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4611_4612 : H12AffineEnvironment.transform 25 5377 env4611 = env4612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env4611 == env4612) = true)

def env4613 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17665,16777216,33554432,67108864,4609044,67130624,16876564,1073741824,131141,4294967296,17007941,4417151347,131072,33563272]

theorem envBound4613 : H12AffineFastState.Bounded env4613 := by
  intro p hp
  have h : env4613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4403_4613 : H12AffineEnvironment.transform 20 4097 env4403 = env4613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env4403 == env4613) = true)

theorem identity4613 : scanCanonicalize (H12AffineFastState.compose env4613 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 17011013) := by decide +kernel

theorem selectedBound4613 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env4614 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17665,16777216,33554432,17011013,4609044,17024069,16876564,1073741824,131141,4294967296,17007941,4333498422,131072,33563272]

theorem envBound4614 : H12AffineFastState.Bounded env4614 := by
  intro p hp
  have h : env4614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4613_4614 : H12AffineEnvironment.transform 25 17011013 env4613 = env4614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17011013 env4613 == env4614) = true)

def env4615 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5457,16777216,33554432,17011013,4588612,17011733,16876564,1073741824,131141,4294967296,17007941,4333477990,131072,33563272]

theorem envBound4615 : H12AffineFastState.Bounded env4615 := by
  intro p hp
  have h : env4615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4614_4615 : H12AffineEnvironment.transform 13 4176 env4614 = env4615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env4614 == env4615) = true)

theorem identity4615 : scanCanonicalize (H12AffineFastState.compose env4615 (packedSelected [1,3,10,13,15,24,28,31,33,38] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound4615 : packedSelected [1,3,10,13,15,24,28,31,33,38] rootPS < 2^1333 := by decide +kernel

def env4616 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5457,16777216,8329,17011013,4588612,17011733,16876564,1073741824,131141,4294967296,17007941,4299915503,131072,513]

theorem envBound4616 : H12AffineFastState.Bounded env4616 := by
  intro p hp
  have h : env4616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4615_4616 : H12AffineEnvironment.transform 24 8329 env4615 = env4616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env4615 == env4616) = true)

def env4617 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,140616,5457,16777216,8329,17011013,270604,17011733,16876564,1073741824,131141,4294967296,17007941,4295599527,131072,513]

theorem envBound4617 : H12AffineFastState.Bounded env4617 := by
  intro p hp
  have h : env4617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4616_4617 : H12AffineEnvironment.transform 21 140616 env4616 = env4617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 140616 env4616 == env4617) = true)

def env4618 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,1073741824,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4618 : H12AffineFastState.Bounded env4618 := by
  intro p hp
  have h : env4618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4617_4618 : H12AffineEnvironment.transform 16 1344 env4617 = env4618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env4617 == env4618) = true)

theorem identity4618 : scanCanonicalize (H12AffineFastState.compose env4618 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 17313159) := by decide +kernel

theorem selectedBound4618 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4619 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,17313159,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4619 : H12AffineFastState.Bounded env4619 := by
  intro p hp
  have h : env4619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4618_4619 : H12AffineEnvironment.transform 29 17313159 env4618 = env4619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 17313159 env4618 == env4619) = true)

def env4620 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,17311111,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4620 : H12AffineFastState.Bounded env4620 := by
  intro p hp
  have h : env4620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4619_4620 : H12AffineEnvironment.transform 10 0 env4619 = env4620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4619 == env4620) = true)

theorem identity4620 : scanCanonicalize (H12AffineFastState.compose env4620 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 332595) := by decide +kernel

theorem selectedBound4620 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4621 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,262144,332595,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,17118900,1285,4294967296,16875525,4295276180,1344,513]

theorem envBound4621 : H12AffineFastState.Bounded env4621 := by
  intro p hp
  have h : env4621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4620_4621 : H12AffineEnvironment.transform 18 332595 env4620 = env4621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 332595 env4620 == env4621) = true)

def env4622 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,32768,65536,1344,262144,332219,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,17118268,1285,4294967296,16875525,4295275548,1344,137]

theorem envBound4622 : H12AffineFastState.Bounded env4622 := by
  intro p hp
  have h : env4622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4621_4622 : H12AffineEnvironment.transform 8 136 env4621 = env4622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4621 == env4622) = true)

theorem identity4622 : scanCanonicalize (H12AffineFastState.compose env4622 (packedSelected [1,4,5,8,9,17,18,21,24] rootPS)) = affineNative (2^(17+1) ^^^ 37940) := by decide +kernel

theorem selectedBound4622 : packedSelected [1,4,5,8,9,17,18,21,24] rootPS < 2^1333 := by decide +kernel

def env4623 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,32768,65536,1344,37940,99727,32768,4097,8200,5457,16777216,8329,16880645,46392,16879957,16876564,16883720,1285,4294967296,16875525,4294975528,1344,137]

theorem envBound4623 : H12AffineFastState.Bounded env4623 := by
  intro p hp
  have h : env4623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4622_4623 : H12AffineEnvironment.transform 17 37940 env4622 = env4623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 37940 env4622 == env4623) = true)

theorem identity4623 : scanCanonicalize (H12AffineFastState.compose env4623 (packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound4623 : packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4624 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,32768,65536,1344,37940,99727,32768,4097,8200,5457,98565,8329,5376,46392,4176,1297,8461,1285,4294967296,256,4294975528,1344,137]

theorem envBound4624 : H12AffineFastState.Bounded env4624 := by
  intro p hp
  have h : env4624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4623_4624 : H12AffineEnvironment.transform 23 98565 env4623 = env4624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env4623 == env4624) = true)

theorem identity4624 : scanCanonicalize (H12AffineFastState.compose env4624 (packedSelected [5,8] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound4624 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4625 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4176,32768,65536,1344,37940,99727,32768,4097,5141,5457,98565,5268,5376,33061,4176,1297,5392,1285,4294967296,256,4294972469,1344,137]

theorem envBound4625 : H12AffineFastState.Bounded env4625 := by
  intro p hp
  have h : env4625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4624_4625 : H12AffineEnvironment.transform 12 5149 env4624 = env4625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env4624 == env4625) = true)

theorem identity4625 : scanCanonicalize (H12AffineFastState.compose env4625 (packedSelected [1,2,4,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 5172) := by decide +kernel

theorem selectedBound4625 : packedSelected [1,2,4,12,13] rootPS < 2^1333 := by decide +kernel

def env4626 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4176,5172,65536,1344,0,70075,5172,4097,5141,5457,70961,5268,5376,5393,4176,1297,5392,1285,4294967296,256,4294972469,1344,137]

theorem envBound4626 : H12AffineFastState.Bounded env4626 := by
  intro p hp
  have h : env4626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4625_4626 : H12AffineEnvironment.transform 14 5172 env4625 = env4626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5172 env4625 == env4626) = true)

theorem identity4626 : scanCanonicalize (H12AffineFastState.compose env4626 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound4626 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4627 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1297,268,1345,293,65536,1344,0,66730,293,1296,260,64,65568,389,17,0,1345,1297,1,1285,4294967296,256,4294967588,1344,137]

theorem envBound4627 : H12AffineFastState.Bounded env4627 := by
  intro p hp
  have h : env4627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4626_4627 : H12AffineEnvironment.transform 11 1297 env4626 = env4627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4626 == env4627) = true)

def env4628 : List Nat := [2,4,8,16,32,64,128,36,136,1024,0,1077,40,1125,1,65536,1124,0,66730,1,1076,32,64,65568,161,17,0,1125,1077,1,1057,4294967296,36,4294967296,1124,137]

theorem envBound4628 : H12AffineFastState.Bounded env4628 := by
  intro p hp
  have h : env4628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4627_4628 : H12AffineEnvironment.transform 7 36 env4627 = env4628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4627 == env4628) = true)

theorem identity4628 : scanCanonicalize (H12AffineFastState.compose env4628 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 163) := by decide +kernel

theorem selectedBound4628 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4629 : List Nat := [2,4,8,16,32,64,128,36,136,1024,0,1077,40,1125,1,65536,1124,0,66730,1,1076,32,64,65568,161,17,0,1125,1077,1,1057,163,36,163,1124,137]

theorem envBound4629 : H12AffineFastState.Bounded env4629 := by
  intro p hp
  have h : env4629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4628_4629 : H12AffineEnvironment.transform 31 163 env4628 = env4629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 163 env4628 == env4629) = true)

theorem identity4629 : scanCanonicalize (H12AffineFastState.compose env4629 (packedSelected [1,3,4] rootPS)) = affineNative (2^(6+1) ^^^ 66) := by decide +kernel

theorem selectedBound4629 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4630 : List Nat := [2,4,8,16,32,64,66,36,74,1024,0,1077,40,1125,1,65536,1124,0,66664,1,1076,32,64,65568,99,17,0,1125,1077,1,1057,97,36,97,1124,75]

theorem envBound4630 : H12AffineFastState.Bounded env4630 := by
  intro p hp
  have h : env4630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4629_4630 : H12AffineEnvironment.transform 6 66 env4629 = env4630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 66 env4629 == env4630) = true)

theorem identity4630 : scanCanonicalize (H12AffineFastState.compose env4630 (packedSelected [2,5] rootPS)) = affineNative (2^(15+1) ^^^ 105) := by decide +kernel

theorem selectedBound4630 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4631 : List Nat := [2,4,8,16,32,64,66,36,74,1024,0,1077,40,1125,1,105,1124,0,1025,1,1076,32,64,73,99,17,0,1125,1077,1,1057,97,36,97,1124,75]

theorem envBound4631 : H12AffineFastState.Bounded env4631 := by
  intro p hp
  have h : env4631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4630_4631 : H12AffineEnvironment.transform 15 105 env4630 = env4631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 105 env4630 == env4631) = true)

theorem identity4631 : scanCanonicalize (H12AffineFastState.compose env4631 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound4631 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4632 : List Nat := [2,4,8,16,32,26,24,36,16,1024,0,1077,40,1087,1,51,1086,0,1025,1,1076,32,26,19,57,17,0,1087,1077,1,1057,59,36,59,1086,17]

theorem envBound4632 : H12AffineFastState.Bounded env4632 := by
  intro p hp
  have h : env4632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4631_4632 : H12AffineEnvironment.transform 5 26 env4631 = env4632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env4631 == env4632) = true)

def env4633 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1076,41,1124,0,65536,1125,0,66730,0,1077,33,64,65568,160,17,0,1124,1076,1,1056,4294967296,37,4294967297,1125,137]

theorem envBound4633 : H12AffineFastState.Bounded env4633 := by
  intro p hp
  have h : env4633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4627_4633 : H12AffineEnvironment.transform 7 37 env4627 = env4633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4627 == env4633) = true)

theorem identity4633 : scanCanonicalize (H12AffineFastState.compose env4633 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65665) := by decide +kernel

theorem selectedBound4633 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4634 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1076,41,1124,0,65536,1125,0,66730,0,1077,33,64,65568,160,17,0,1124,1076,1,1056,65665,37,65664,1125,137]

theorem envBound4634 : H12AffineFastState.Bounded env4634 := by
  intro p hp
  have h : env4634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4633_4634 : H12AffineEnvironment.transform 31 65665 env4633 = env4634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65665 env4633 == env4634) = true)

theorem identity4634 : scanCanonicalize (H12AffineFastState.compose env4634 (packedSelected [1,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4634 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4635 : List Nat := [2,4,8,16,32,0,128,37,136,1024,0,1076,41,1060,0,65536,1061,0,66730,0,1077,33,0,65568,160,17,0,1060,1076,1,1056,65665,37,65664,1061,137]

theorem envBound4635 : H12AffineFastState.Bounded env4635 := by
  intro p hp
  have h : env4635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4634_4635 : H12AffineEnvironment.transform 5 0 env4634 = env4635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4634 == env4635) = true)

def env4636 : List Nat := [2,4,8,16,32,0,128,37,136,1024,0,1076,41,1060,0,128,1061,0,1066,0,1077,33,0,160,160,17,0,1060,1076,1,1056,1,37,0,1061,137]

theorem envBound4636 : H12AffineFastState.Bounded env4636 := by
  intro p hp
  have h : env4636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4635_4636 : H12AffineEnvironment.transform 15 128 env4635 = env4636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 128 env4635 == env4636) = true)

theorem identity4636 : scanCanonicalize (H12AffineFastState.compose env4636 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4636 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4637 : List Nat := [2,4,8,16,11,0,128,14,136,1024,0,1055,2,1039,0,128,1038,0,1025,0,1054,10,0,139,139,17,0,1039,1055,1,1035,1,14,0,1038,137]

theorem envBound4637 : H12AffineFastState.Bounded env4637 := by
  intro p hp
  have h : env4637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4636_4637 : H12AffineEnvironment.transform 4 11 env4636 = env4637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4636 == env4637) = true)

def leafEnv4637 : List Nat := [2,4,8,16,11,0,128,14,136,1024,0,1055,2,1039,0,128,1038,0,1025,0,1054,10,0,139,1034,139,1,17,0,1039,1055,1,1035,1,14,0,4,8,1038,137,0,1054,1]

def active4637 : List Nat := [0,1,2,3,6,9]

def tree4637 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4637 : H12WitnessSearch.Good tree4637 := H12GlobalWitnessIndex.good

theorem leafIdentity4637 : H12AffineFastState.composeSystem env4637 rootObs = leafEnv4637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4637 rootObs == leafEnv4637) = true)

theorem terminalChecked4637 : H12PackedTerminal.terminalCheckFast leafEnv4637 active4637 tree4637 = true := by decide +kernel

def env4638 : List Nat := [2,4,8,16,32,0,128,37,136,1024,0,1076,41,1060,0,129,1061,0,1067,0,1077,33,0,161,160,17,0,1060,1076,1,1056,0,37,1,1061,137]

theorem envBound4638 : H12AffineFastState.Bounded env4638 := by
  intro p hp
  have h : env4638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4635_4638 : H12AffineEnvironment.transform 15 129 env4635 = env4638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 129 env4635 == env4638) = true)

def env4639 : List Nat := [2,4,8,16,32,0,56,37,48,1024,0,1076,41,1060,0,57,1061,0,1067,0,1077,33,0,25,24,17,0,1060,1076,1,1056,0,37,1,1061,49]

theorem envBound4639 : H12AffineFastState.Bounded env4639 := by
  intro p hp
  have h : env4639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4638_4639 : H12AffineEnvironment.transform 6 56 env4638 = env4639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 56 env4638 == env4639) = true)

def env4640 : List Nat := [2,4,8,16,0,0,24,5,16,1024,0,1044,9,1028,0,25,1029,0,1035,0,1045,1,0,25,24,17,0,1028,1044,1,1024,0,5,1,1029,17]

theorem envBound4640 : H12AffineFastState.Bounded env4640 := by
  intro p hp
  have h : env4640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4639_4640 : H12AffineEnvironment.transform 4 0 env4639 = env4640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4639 == env4640) = true)

def leafEnv4640 : List Nat := [2,4,8,16,0,0,24,5,16,1024,0,1044,9,1028,0,25,1029,0,1035,0,1045,1,0,25,1035,24,1,17,0,1028,1044,1,1024,0,5,1,4,3,1029,17,0,1045,1]

def active4640 : List Nat := [0,1,2,3,9]

def tree4640 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4640 : H12WitnessSearch.Good tree4640 := H12GlobalWitnessIndex.good

theorem leafIdentity4640 : H12AffineFastState.composeSystem env4640 rootObs = leafEnv4640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4640 rootObs == leafEnv4640) = true)

theorem terminalChecked4640 : H12PackedTerminal.terminalCheckFast leafEnv4640 active4640 tree4640 = true := by decide +kernel

def env4641 : List Nat := [2,4,8,16,1,0,25,4,17,1024,0,1045,8,1029,0,24,1028,0,1034,0,1044,0,0,25,24,17,0,1029,1045,1,1025,0,4,1,1028,16]

theorem envBound4641 : H12AffineFastState.Bounded env4641 := by
  intro p hp
  have h : env4641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4639_4641 : H12AffineEnvironment.transform 4 1 env4639 = env4641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4639 == env4641) = true)

theorem identity4641 : scanCanonicalize (H12AffineFastState.compose env4641 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4641 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4642 : List Nat := [2,4,3,16,1,0,18,4,17,1024,0,1045,3,1029,0,19,1028,0,1025,0,1044,0,0,18,19,17,0,1029,1045,1,1025,0,4,1,1028,16]

theorem envBound4642 : H12AffineFastState.Bounded env4642 := by
  intro p hp
  have h : env4642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4641_4642 : H12AffineEnvironment.transform 2 3 env4641 = env4642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4641 == env4642) = true)

def leafEnv4642 : List Nat := [2,4,3,16,1,0,18,4,17,1024,0,1045,3,1029,0,19,1028,0,1025,0,1044,0,0,18,1024,19,1,17,0,1029,1045,1,1025,0,4,1,4,2,1028,16,0,1044,1]

def active4642 : List Nat := [0,1,3,9]

def tree4642 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4642 : H12WitnessSearch.Good tree4642 := H12GlobalWitnessIndex.good

theorem leafIdentity4642 : H12AffineFastState.composeSystem env4642 rootObs = leafEnv4642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4642 rootObs == leafEnv4642) = true)

theorem terminalChecked4642 : H12PackedTerminal.terminalCheckFast leafEnv4642 active4642 tree4642 = true := by decide +kernel

def env4643 : List Nat := [2,4,8,16,32,0,57,37,49,1024,0,1076,41,1060,0,56,1061,0,1067,0,1077,33,0,24,25,17,0,1060,1076,1,1056,0,37,1,1061,48]

theorem envBound4643 : H12AffineFastState.Bounded env4643 := by
  intro p hp
  have h : env4643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4638_4643 : H12AffineEnvironment.transform 6 57 env4638 = env4643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env4638 == env4643) = true)

theorem identity4643 : scanCanonicalize (H12AffineFastState.compose env4643 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4643 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4644 : List Nat := [2,4,8,16,10,0,19,15,27,1024,0,1054,3,1038,0,18,1039,0,1025,0,1055,11,0,24,25,17,0,1038,1054,1,1034,0,15,1,1039,26]

theorem envBound4644 : H12AffineFastState.Bounded env4644 := by
  intro p hp
  have h : env4644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4643_4644 : H12AffineEnvironment.transform 4 10 env4643 = env4644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4643 == env4644) = true)

def leafEnv4644 : List Nat := [2,4,8,16,10,0,19,15,27,1024,0,1054,3,1038,0,18,1039,0,1025,0,1055,11,0,24,1035,25,1,17,0,1038,1054,1,1034,0,15,1,4,9,1039,26,0,1055,1]

def active4644 : List Nat := [0,1,2,3,9]

def tree4644 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4644 : H12WitnessSearch.Good tree4644 := H12GlobalWitnessIndex.good

theorem leafIdentity4644 : H12AffineFastState.composeSystem env4644 rootObs = leafEnv4644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4644 rootObs == leafEnv4644) = true)

theorem terminalChecked4644 : H12PackedTerminal.terminalCheckFast leafEnv4644 active4644 tree4644 = true := by decide +kernel

def env4645 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4176,32768,65536,1344,262144,332218,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,17118269,1285,4294967296,16875525,4295275549,1344,136]

theorem envBound4645 : H12AffineFastState.Bounded env4645 := by
  intro p hp
  have h : env4645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4621_4645 : H12AffineEnvironment.transform 8 137 env4621 = env4645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4621 == env4645) = true)

theorem identity4645 : scanCanonicalize (H12AffineFastState.compose env4645 (packedSelected [1,4,5,8,9,17,18,21,24] rootPS)) = affineNative (2^(23+1) ^^^ 111897) := by decide +kernel

theorem selectedBound4645 : packedSelected [1,4,5,8,9,17,18,21,24] rootPS < 2^1333 := by decide +kernel

def env4646 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4176,32768,65536,1344,262144,332218,32768,4097,8200,5457,111897,8329,8476,270604,9292,12557,295204,1285,4294967296,13596,4295275549,1344,136]

theorem envBound4646 : H12AffineFastState.Bounded env4646 := by
  intro p hp
  have h : env4646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4645_4646 : H12AffineEnvironment.transform 23 111897 env4645 = env4646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 111897 env4645 == env4646) = true)

theorem identity4646 : scanCanonicalize (H12AffineFastState.compose env4646 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17,18,20] rootPS)) = affineNative (2^(17+1) ^^^ 37940) := by decide +kernel

theorem selectedBound4646 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17,18,20] rootPS < 2^1333 := by decide +kernel

def env4647 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4176,32768,65536,1344,37940,99726,32768,4097,8200,5457,111897,8329,8476,46392,9292,12557,5392,1285,4294967296,13596,4294975529,1344,136]

theorem envBound4647 : H12AffineFastState.Bounded env4647 := by
  intro p hp
  have h : env4647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4646_4647 : H12AffineEnvironment.transform 17 37940 env4646 = env4647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 37940 env4646 == env4647) = true)

theorem identity4647 : scanCanonicalize (H12AffineFastState.compose env4647 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound4647 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4648 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,268,4176,32768,65536,1344,37940,99726,32768,4097,260,5457,103445,389,16,37940,1344,4097,5392,1285,4294967296,5136,4294967589,1344,136]

theorem envBound4648 : H12AffineFastState.Bounded env4648 := by
  intro p hp
  have h : env4648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4647_4648 : H12AffineEnvironment.transform 12 268 env4647 = env4648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env4647 == env4648) = true)

theorem identity4648 : scanCanonicalize (H12AffineFastState.compose env4648 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4648 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4649 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,268,1344,32768,65536,1344,33060,99726,32768,1297,260,65,98565,389,16,33060,1344,1297,0,1285,4294967296,256,4294967589,1344,136]

theorem envBound4649 : H12AffineFastState.Bounded env4649 := by
  intro p hp
  have h : env4649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4648_4649 : H12AffineEnvironment.transform 11 1296 env4648 = env4649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4648 == env4649) = true)

theorem identity4649 : scanCanonicalize (H12AffineFastState.compose env4649 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound4649 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4650 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,268,1344,32768,33167,1344,33060,1025,32768,1297,260,65,138,389,16,33060,1344,1297,0,1285,4294967296,256,4294967589,1344,136]

theorem envBound4650 : H12AffineFastState.Bounded env4650 := by
  intro p hp
  have h : env4650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2