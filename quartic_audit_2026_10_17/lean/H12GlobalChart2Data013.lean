import H12GlobalChart2Data012

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem identity3155 : scanCanonicalize (H12AffineFastState.compose env3155 (packedSelected [1,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound3155 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env3156 : List Nat := [2,4,8,16,32,42,128,5,168,1024,0,1077,8,1039,32,139,1071,1,1024,32,1077,1,11,171,129,48,1,1039,1044,1,1024,184,5,184,1071,169]

theorem envBound3156 : H12AffineFastState.Bounded env3156 := by
  intro p hp
  have h : env3156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3155_3156 : H12AffineEnvironment.transform 5 42 env3155 = env3156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env3155 == env3156) = true)

theorem identity3156 : scanCanonicalize (H12AffineFastState.compose env3156 (packedSelected [1,3,12] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3156 : packedSelected [1,3,12] rootPS < 2^1333 := by decide +kernel

def env3157 : List Nat := [2,4,8,16,1,11,128,5,137,1024,0,1044,8,1039,1,139,1038,1,1024,1,1044,1,11,138,129,17,1,1039,1044,1,1024,153,5,153,1038,136]

theorem envBound3157 : H12AffineFastState.Bounded env3157 := by
  intro p hp
  have h : env3157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3156_3157 : H12AffineEnvironment.transform 4 1 env3156 = env3157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3156 == env3157) = true)

theorem identity3157 : scanCanonicalize (H12AffineFastState.compose env3157 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3157 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3158 : List Nat := [2,4,2,16,1,1,128,5,131,1024,0,1044,2,1029,1,129,1028,1,1024,1,1044,1,1,128,129,17,1,1029,1044,1,1024,147,5,147,1028,130]

theorem envBound3158 : H12AffineFastState.Bounded env3158 := by
  intro p hp
  have h : env3158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3157_3158 : H12AffineEnvironment.transform 2 2 env3157 = env3158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3157 == env3158) = true)

def env3159 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8201,17665,74628,33554432,5376,2122077,16384,1296,35652789,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound3159 : H12AffineFastState.Bounded env3159 := by
  intro p hp
  have h : env3159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3144_3159 : H12AffineEnvironment.transform 16 1345 env3144 = env3159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3144 == env3159) = true)

theorem identity3159 : scanCanonicalize (H12AffineFastState.compose env3159 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3159 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3160 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8201,17665,74628,2647256,5376,2122077,16384,1296,548973,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound3160 : H12AffineFastState.Bounded env3160 := by
  intro p hp
  have h : env3160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3159_3160 : H12AffineEnvironment.transform 24 2647256 env3159 = env3160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3159 == env3160) = true)

theorem identity3160 : scanCanonicalize (H12AffineFastState.compose env3160 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 598591) := by decide +kernel

theorem selectedBound3160 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3161 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,524288,8832,598591,8201,17665,74628,83687,5376,607074,16384,1296,548973,1284,4294967296,256,4295504153,1345,91247]

theorem envBound3161 : H12AffineFastState.Bounded env3161 := by
  intro p hp
  have h : env3161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3160_3161 : H12AffineEnvironment.transform 20 598591 env3160 = env3161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 598591 env3160 == env3161) = true)

theorem identity3161 : scanCanonicalize (H12AffineFastState.compose env3161 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(18+1) ^^^ 78399) := by decide +kernel

theorem selectedBound3161 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3162 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,78399,8832,4096,8201,17665,74628,83687,5376,29021,16384,1296,86610,1284,4294967296,256,4295033638,1345,91247]

theorem envBound3162 : H12AffineFastState.Bounded env3162 := by
  intro p hp
  have h : env3162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3161_3162 : H12AffineEnvironment.transform 18 78399 env3161 = env3162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78399 env3161 == env3162) = true)

theorem identity3162 : scanCanonicalize (H12AffineFastState.compose env3162 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 17899) := by decide +kernel

theorem selectedBound3162 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3163 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,17899,1345,1,30676,8832,4096,8201,17665,26223,780,5376,29021,16384,1296,6073,1284,4294967296,256,4294985421,1345,8580]

theorem envBound3163 : H12AffineFastState.Bounded env3163 := by
  intro p hp
  have h : env3163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3162_3163 : H12AffineEnvironment.transform 15 17899 env3162 = env3163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 17899 env3162 == env3163) = true)

theorem identity3163 : scanCanonicalize (H12AffineFastState.compose env3163 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4856) := by decide +kernel

theorem selectedBound3163 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3164 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4856,8832,5907,1345,1,9516,8832,4096,8201,6137,13463,780,5376,9125,4856,1296,6073,1284,4294967296,256,4294972469,1345,8580]

theorem envBound3164 : H12AffineFastState.Bounded env3164 := by
  intro p hp
  have h : env3164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3163_3164 : H12AffineEnvironment.transform 13 4856 env3163 = env3164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4856 env3163 == env3164) = true)

theorem identity3164 : scanCanonicalize (H12AffineFastState.compose env3164 (packedSelected [1,3,5,8,10,16,18,19] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound3164 : packedSelected [1,3,5,8,10,16,18,19] rootPS < 2^1333 := by decide +kernel

def env3165 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1945,8192,1377,8832,138,1345,1,9516,8832,1945,8201,96,8974,780,665,9125,1377,1296,32,1284,4294967296,256,4294968236,1345,8580]

theorem envBound3165 : H12AffineFastState.Bounded env3165 := by
  intro p hp
  have h : env3165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3164_3165 : H12AffineEnvironment.transform 11 1945 env3164 = env3165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env3164 == env3165) = true)

theorem identity3165 : scanCanonicalize (H12AffineFastState.compose env3165 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound3165 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env3166 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1077,8192,1377,8492,138,1345,1,9516,8492,1077,8201,96,8354,160,309,8201,1377,1296,32,1284,4294967296,256,4294967296,1345,8580]

theorem envBound3166 : H12AffineFastState.Bounded env3166 := by
  intro p hp
  have h : env3166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3165_3166 : H12AffineEnvironment.transform 8 428 env3165 = env3166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env3165 == env3166) = true)

theorem identity3166 : scanCanonicalize (H12AffineFastState.compose env3166 (packedSelected [0,1,7,8,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound3166 : packedSelected [0,1,7,8,10,15] rootPS < 2^1333 := by decide +kernel

def env3167 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1077,40,1377,260,138,1345,1,1284,260,1077,33,96,138,160,309,33,1377,1296,32,1284,4294967296,256,4294967296,1345,428]

theorem envBound3167 : H12AffineFastState.Bounded env3167 := by
  intro p hp
  have h : env3167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3166_3167 : H12AffineEnvironment.transform 12 40 env3166 = env3167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env3166 == env3167) = true)

theorem identity3167 : scanCanonicalize (H12AffineFastState.compose env3167 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound3167 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3168 : List Nat := [2,4,8,16,32,64,128,15,163,1024,0,1077,40,1134,11,138,1102,1,1035,11,1077,33,96,138,160,58,33,1134,1055,32,1035,4294967296,15,4294967296,1102,163]

theorem envBound3168 : H12AffineFastState.Bounded env3168 := by
  intro p hp
  have h : env3168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3167_3168 : H12AffineEnvironment.transform 7 15 env3167 = env3168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env3167 == env3168) = true)

theorem identity3168 : scanCanonicalize (H12AffineFastState.compose env3168 (packedSelected [1,2,4] rootPS)) = affineNative (2^(9+1) ^^^ 108) := by decide +kernel

theorem selectedBound3168 : packedSelected [1,2,4] rootPS < 2^1333 := by decide +kernel

def env3169 : List Nat := [2,4,8,16,32,64,128,15,163,108,0,89,40,2,11,138,34,1,103,11,89,33,96,138,160,58,33,2,115,32,103,4294967296,15,4294967296,34,163]

theorem envBound3169 : H12AffineFastState.Bounded env3169 := by
  intro p hp
  have h : env3169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3168_3169 : H12AffineEnvironment.transform 9 108 env3168 = env3169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 108 env3168 == env3169) = true)

theorem identity3169 : scanCanonicalize (H12AffineFastState.compose env3169 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound3169 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3170 : List Nat := [2,4,8,16,32,64,9,15,42,108,0,89,40,2,11,3,34,1,103,11,89,33,96,3,41,58,33,2,115,32,103,4294967296,15,4294967296,34,42]

theorem envBound3170 : H12AffineFastState.Bounded env3170 := by
  intro p hp
  have h : env3170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3169_3170 : H12AffineEnvironment.transform 6 9 env3169 = env3170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env3169 == env3170) = true)

theorem identity3170 : scanCanonicalize (H12AffineFastState.compose env3170 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound3170 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3171 : List Nat := [2,4,8,16,18,64,9,15,24,94,0,89,26,2,11,3,16,1,85,11,89,19,82,3,27,8,19,2,65,18,85,4294967296,15,4294967296,16,24]

theorem envBound3171 : H12AffineFastState.Bounded env3171 := by
  intro p hp
  have h : env3171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3170_3171 : H12AffineEnvironment.transform 4 18 env3170 = env3171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env3170 == env3171) = true)

theorem identity3171 : scanCanonicalize (H12AffineFastState.compose env3171 (packedSelected [2,9] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3171 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env3172 : List Nat := [2,4,8,2,0,64,9,15,10,76,0,75,8,2,11,3,2,1,71,11,75,1,64,3,9,8,1,2,65,0,71,4294967296,15,4294967296,2,10]

theorem envBound3172 : H12AffineFastState.Bounded env3172 := by
  intro p hp
  have h : env3172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3171_3172 : H12AffineEnvironment.transform 3 2 env3171 = env3172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3171 == env3172) = true)

theorem identity3172 : scanCanonicalize (H12AffineFastState.compose env3172 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3172 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3173 : List Nat := [2,4,2,2,0,64,3,5,0,70,0,65,2,2,1,3,2,1,71,1,65,1,64,3,3,2,1,2,65,0,71,4294967296,5,4294967296,2,0]

theorem envBound3173 : H12AffineFastState.Bounded env3173 := by
  intro p hp
  have h : env3173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3172_3173 : H12AffineEnvironment.transform 2 2 env3172 = env3173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3172 == env3173) = true)

theorem identity3173 : scanCanonicalize (H12AffineFastState.compose env3173 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 66) := by decide +kernel

theorem selectedBound3173 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3174 : List Nat := [2,4,2,2,0,64,3,5,0,70,0,65,2,2,1,3,2,1,71,1,65,1,64,3,3,2,1,2,65,0,71,66,5,66,2,0]

theorem envBound3174 : H12AffineFastState.Bounded env3174 := by
  intro p hp
  have h : env3174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3173_3174 : H12AffineEnvironment.transform 31 66 env3173 = env3174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 66 env3173 == env3174) = true)

theorem identity3174 : scanCanonicalize (H12AffineFastState.compose env3174 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 3) := by decide +kernel

theorem selectedBound3174 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3175 : List Nat := [2,4,2,2,0,3,3,5,0,5,0,2,2,2,1,3,2,1,4,1,2,1,3,3,3,2,1,2,2,0,4,1,5,1,2,0]

theorem envBound3175 : H12AffineFastState.Bounded env3175 := by
  intro p hp
  have h : env3175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3174_3175 : H12AffineEnvironment.transform 5 3 env3174 = env3175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 3 env3174 == env3175) = true)

def env3176 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8200,17665,206533,33554432,5376,2515996,16384,131153,1073741824,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3176 : H12AffineFastState.Bounded env3176 := by
  intro p hp
  have h : env3176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3110_3176 : H12AffineEnvironment.transform 10 1 env3110 = env3176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env3110 == env3176) = true)

theorem identity3176 : scanCanonicalize (H12AffineFastState.compose env3176 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 288452) := by decide +kernel

theorem selectedBound3176 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3177 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8200,17665,206533,33554432,5376,2515996,16384,131153,288452,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3177 : H12AffineFastState.Bounded env3177 := by
  intro p hp
  have h : env3177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3176_3177 : H12AffineEnvironment.transform 29 288452 env3176 = env3177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 288452 env3176 == env3177) = true)

def env3178 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,0,524288,8832,2097152,8200,17665,206533,33554432,5376,2253852,16384,131153,26308,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3178 : H12AffineFastState.Bounded env3178 := by
  intro p hp
  have h : env3178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3177_3178 : H12AffineEnvironment.transform 17 0 env3177 = env3178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env3177 == env3178) = true)

def env3179 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,0,524288,8832,2097152,8200,17665,74629,33554432,5376,2122076,16384,1297,26308,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3179 : H12AffineFastState.Bounded env3179 := by
  intro p hp
  have h : env3179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3178_3179 : H12AffineEnvironment.transform 16 1344 env3178 = env3179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3178 == env3179) = true)

theorem identity3179 : scanCanonicalize (H12AffineFastState.compose env3179 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3179 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3180 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,0,524288,8832,4096,8200,17665,74629,33554432,5376,29020,16384,1297,26308,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3180 : H12AffineFastState.Bounded env3180 := by
  intro p hp
  have h : env3180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3179_3180 : H12AffineEnvironment.transform 20 4096 env3179 = env3180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3179 == env3180) = true)

theorem identity3180 : scanCanonicalize (H12AffineFastState.compose env3180 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 21373) := by decide +kernel

theorem selectedBound3180 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3181 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,0,524288,8832,4096,8200,17665,74629,21373,5376,29020,16384,1297,26308,1285,4294967296,256,4295566467,1344,29173]

theorem envBound3181 : H12AffineFastState.Bounded env3181 := by
  intro p hp
  have h : env3181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3180_3181 : H12AffineEnvironment.transform 24 21373 env3180 = env3181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 21373 env3180 == env3181) = true)

theorem identity3181 : scanCanonicalize (H12AffineFastState.compose env3181 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound3181 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3182 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,8192,16384,8832,65536,1344,0,524288,8832,1944,8200,17665,74629,17637,664,26308,16384,1297,26308,1285,4294967296,256,4295566467,1344,26221]

theorem envBound3182 : H12AffineFastState.Bounded env3182 := by
  intro p hp
  have h : env3182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3181_3182 : H12AffineEnvironment.transform 11 1944 env3181 = env3182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env3181 == env3182) = true)

theorem identity3182 : scanCanonicalize (H12AffineFastState.compose env3182 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound3182 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3183 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,16384,908,65536,1344,0,524288,908,1944,260,17665,66185,17637,664,18376,16384,1297,18376,1285,4294967296,256,4295558543,1344,18273]

theorem envBound3183 : H12AffineFastState.Bounded env3183 := by
  intro p hp
  have h : env3183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3182_3183 : H12AffineEnvironment.transform 12 268 env3182 = env3183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env3182 == env3183) = true)

theorem identity3183 : scanCanonicalize (H12AffineFastState.compose env3183 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 1376) := by decide +kernel

theorem selectedBound3183 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3184 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1376,908,65536,1344,0,524288,908,1944,260,97,66185,389,664,680,1376,1297,680,1285,4294967296,256,4295558543,1344,513]

theorem envBound3184 : H12AffineFastState.Bounded env3184 := by
  intro p hp
  have h : env3184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3183_3184 : H12AffineEnvironment.transform 13 1376 env3183 = env3184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1376 env3183 == env3184) = true)

theorem identity3184 : scanCanonicalize (H12AffineFastState.compose env3184 (packedSelected [0,5,7,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound3184 : packedSelected [0,5,7,8,12,15] rootPS < 2^1333 := by decide +kernel

def env3185 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1376,908,546,1344,0,524288,908,1944,260,97,171,389,664,680,1376,1297,680,1285,4294967296,256,4295493549,1344,513]

theorem envBound3185 : H12AffineFastState.Bounded env3185 := by
  intro p hp
  have h : env3185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3184_3185 : H12AffineEnvironment.transform 15 546 env3184 = env3185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env3184 == env3185) = true)

theorem identity3185 : scanCanonicalize (H12AffineFastState.compose env3185 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound3185 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3186 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1376,908,546,1344,0,1024,908,1944,260,97,171,389,664,680,1376,1297,680,1285,4294967296,256,4294968237,1344,513]

theorem envBound3186 : H12AffineFastState.Bounded env3186 := by
  intro p hp
  have h : env3186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3185_3186 : H12AffineEnvironment.transform 18 1024 env3185 = env3186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env3185 == env3186) = true)

theorem identity3186 : scanCanonicalize (H12AffineFastState.compose env3186 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound3186 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3187 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,1328,268,1376,292,138,1344,0,1024,292,1328,260,97,171,389,48,0,1376,1297,0,1285,4294967296,256,4294967557,1344,169]

theorem envBound3187 : H12AffineFastState.Bounded env3187 := by
  intro p hp
  have h : env3187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3186_3187 : H12AffineEnvironment.transform 8 168 env3186 = env3187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env3186 == env3187) = true)

theorem identity3187 : scanCanonicalize (H12AffineFastState.compose env3187 (packedSelected [1,10] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3187 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env3188 : List Nat := [2,4,8,16,32,64,128,5,168,1024,1,1077,9,1125,33,138,1093,0,1024,33,1077,1,97,171,128,48,0,1125,1044,0,1024,4294967296,5,4294967296,1093,169]

theorem envBound3188 : H12AffineFastState.Bounded env3188 := by
  intro p hp
  have h : env3188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3187_3188 : H12AffineEnvironment.transform 7 5 env3187 = env3188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3187 == env3188) = true)

theorem identity3188 : scanCanonicalize (H12AffineFastState.compose env3188 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 242) := by decide +kernel

theorem selectedBound3188 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3189 : List Nat := [2,4,8,16,32,64,128,5,168,1024,1,1077,9,1125,33,138,1093,0,1024,33,1077,1,97,171,128,48,0,1125,1044,0,1024,242,5,242,1093,169]

theorem envBound3189 : H12AffineFastState.Bounded env3189 := by
  intro p hp
  have h : env3189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3188_3189 : H12AffineEnvironment.transform 31 242 env3188 = env3189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 242 env3188 == env3189) = true)

theorem identity3189 : scanCanonicalize (H12AffineFastState.compose env3189 (packedSelected [1,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound3189 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env3190 : List Nat := [2,4,8,16,32,10,128,5,168,1024,1,1077,9,1071,33,138,1039,0,1024,33,1077,1,43,171,128,48,0,1071,1044,0,1024,184,5,184,1039,169]

theorem envBound3190 : H12AffineFastState.Bounded env3190 := by
  intro p hp
  have h : env3190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3189_3190 : H12AffineEnvironment.transform 5 10 env3189 = env3190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env3189 == env3190) = true)

theorem identity3190 : scanCanonicalize (H12AffineFastState.compose env3190 (packedSelected [1,3,12] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3190 : packedSelected [1,3,12] rootPS < 2^1333 := by decide +kernel

def env3191 : List Nat := [2,4,8,16,1,10,128,5,137,1024,1,1044,9,1038,0,138,1039,0,1024,0,1044,1,10,138,128,17,0,1038,1044,0,1024,153,5,153,1039,136]

theorem envBound3191 : H12AffineFastState.Bounded env3191 := by
  intro p hp
  have h : env3191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3190_3191 : H12AffineEnvironment.transform 4 1 env3190 = env3191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3190 == env3191) = true)

theorem identity3191 : scanCanonicalize (H12AffineFastState.compose env3191 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3191 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3192 : List Nat := [2,4,2,16,1,0,128,5,131,1024,1,1044,3,1028,0,128,1029,0,1024,0,1044,1,0,128,128,17,0,1028,1044,0,1024,147,5,147,1029,130]

theorem envBound3192 : H12AffineFastState.Bounded env3192 := by
  intro p hp
  have h : env3192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3191_3192 : H12AffineEnvironment.transform 2 2 env3191 = env3192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3191 == env3192) = true)

def env3193 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8200,17665,74628,33554432,5376,2122077,16384,1296,26308,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound3193 : H12AffineFastState.Bounded env3193 := by
  intro p hp
  have h : env3193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3178_3193 : H12AffineEnvironment.transform 16 1345 env3178 = env3193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3178 == env3193) = true)

theorem identity3193 : scanCanonicalize (H12AffineFastState.compose env3193 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3193 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3194 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8200,17665,74628,2647256,5376,2122077,16384,1296,26308,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound3194 : H12AffineFastState.Bounded env3194 := by
  intro p hp
  have h : env3194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3193_3194 : H12AffineEnvironment.transform 24 2647256 env3193 = env3194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3193 == env3194) = true)

theorem identity3194 : scanCanonicalize (H12AffineFastState.compose env3194 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 74902) := by decide +kernel

theorem selectedBound3194 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3195 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,0,524288,8832,74902,8200,17665,74628,606286,5376,83403,16384,1296,26308,1284,4294967296,256,4294981553,1345,615110]

theorem envBound3195 : H12AffineFastState.Bounded env3195 := by
  intro p hp
  have h : env3195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3194_3195 : H12AffineEnvironment.transform 20 74902 env3194 = env3195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 74902 env3194 == env3195) = true)

theorem identity3195 : scanCanonicalize (H12AffineFastState.compose env3195 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(15+1) ^^^ 13462) := by decide +kernel

theorem selectedBound3195 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3196 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,13462,1345,0,524288,8832,4096,8200,17665,5906,554200,5376,29021,16384,1296,26308,1284,4294967296,256,4294981553,1345,546384]

theorem envBound3196 : H12AffineFastState.Bounded env3196 := by
  intro p hp
  have h : env3196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3195_3196 : H12AffineEnvironment.transform 15 13462 env3195 = env3196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13462 env3195 == env3196) = true)

theorem identity3196 : scanCanonicalize (H12AffineFastState.compose env3196 (packedSelected [20] rootPS)) = affineNative (2^(18+1) ^^^ 12980) := by decide +kernel

theorem selectedBound3196 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3197 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,13462,1345,0,12980,8832,4096,8200,17665,5906,18028,5376,29021,16384,1296,26308,1284,4294967296,256,4294981553,1345,25828]

theorem envBound3197 : H12AffineFastState.Bounded env3197 := by
  intro p hp
  have h : env3197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3196_3197 : H12AffineEnvironment.transform 18 12980 env3196 = env3197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 12980 env3196 == env3197) = true)

theorem identity3197 : scanCanonicalize (H12AffineFastState.compose env3197 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4856) := by decide +kernel

theorem selectedBound3197 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3198 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4856,8832,13462,1345,0,12980,8832,4096,8200,6137,5906,5268,5376,9125,4856,1296,13372,1284,4294967296,256,4294981553,1345,13852]

theorem envBound3198 : H12AffineFastState.Bounded env3198 := by
  intro p hp
  have h : env3198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3197_3198 : H12AffineEnvironment.transform 13 4856 env3197 = env3198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4856 env3197 == env3198) = true)

theorem identity3198 : scanCanonicalize (H12AffineFastState.compose env3198 (packedSelected [1,3,5,8,10,16,18,19] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound3198 : packedSelected [1,3,5,8,10,16,18,19] rootPS < 2^1333 := by decide +kernel

def env3199 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4856,260,5906,1345,0,4400,260,4096,908,6137,5906,5268,5376,33,4856,1296,6072,1284,4294967296,256,4294972469,1345,5528]

theorem envBound3199 : H12AffineFastState.Bounded env3199 := by
  intro p hp
  have h : env3199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3198_3199 : H12AffineEnvironment.transform 12 900 env3198 = env3199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env3198 == env3199) = true)

theorem identity3199 : scanCanonicalize (H12AffineFastState.compose env3199 (packedSelected [0,4,5,7,8,9,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 1725) := by decide +kernel

theorem selectedBound3199 : packedSelected [0,4,5,7,8,9,12,15] rootPS < 2^1333 := by decide +kernel

def env3200 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1725,900,1093,260,431,1345,0,1933,260,1725,908,324,431,553,957,33,1093,1296,261,1284,4294967296,256,4294967944,1345,805]

theorem envBound3200 : H12AffineFastState.Bounded env3200 := by
  intro p hp
  have h : env3200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3199_3200 : H12AffineEnvironment.transform 11 1725 env3199 = env3200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1725 env3199 == env3200) = true)

theorem identity3200 : scanCanonicalize (H12AffineFastState.compose env3200 (packedSelected [1,3,4,9] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3200 : packedSelected [1,3,4,9] rootPS < 2^1333 := by decide +kernel

def env3201 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1692,900,1093,260,398,1345,0,1933,260,1692,908,324,398,520,924,0,1093,1296,261,1284,4294967296,256,4294967944,1345,772]

theorem envBound3201 : H12AffineFastState.Bounded env3201 := by
  intro p hp
  have h : env3201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3200_3201 : H12AffineEnvironment.transform 4 1 env3200 = env3201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3200 == env3201) = true)

theorem identity3201 : scanCanonicalize (H12AffineFastState.compose env3201 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound3201 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env3202 : List Nat := [2,4,8,16,1,64,128,256,396,1024,1,1296,8,1093,260,398,1345,0,1025,260,1296,0,324,398,388,16,0,1093,1296,261,1284,4294967296,256,4294967556,1345,136]

theorem envBound3202 : H12AffineFastState.Bounded env3202 := by
  intro p hp
  have h : env3202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3201_3202 : H12AffineEnvironment.transform 8 396 env3201 = env3202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env3201 == env3202) = true)

theorem identity3202 : scanCanonicalize (H12AffineFastState.compose env3202 (packedSelected [0,1,2,3,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 81) := by decide +kernel

theorem selectedBound3202 : packedSelected [0,1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env3203 : List Nat := [2,4,8,16,1,64,128,256,396,1024,1,1296,8,1093,260,398,1345,0,1025,260,1296,0,324,398,388,16,0,1093,1296,261,1284,81,256,341,1345,136]

theorem envBound3203 : H12AffineFastState.Bounded env3203 := by
  intro p hp
  have h : env3203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3202_3203 : H12AffineEnvironment.transform 31 81 env3202 = env3203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 81 env3202 == env3203) = true)

theorem identity3203 : scanCanonicalize (H12AffineFastState.compose env3203 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound3203 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env3204 : List Nat := [2,4,8,16,1,64,128,4,136,1024,1,1044,8,1093,0,138,1093,0,1025,0,1044,0,64,138,128,16,0,1093,1044,1,1024,81,4,81,1093,136]

theorem envBound3204 : H12AffineFastState.Bounded env3204 := by
  intro p hp
  have h : env3204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3203_3204 : H12AffineEnvironment.transform 7 4 env3203 = env3204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3203 == env3204) = true)

theorem identity3204 : scanCanonicalize (H12AffineFastState.compose env3204 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 27) := by decide +kernel

theorem selectedBound3204 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3205 : List Nat := [2,4,8,16,1,64,27,4,19,1024,1,1044,8,1093,0,17,1093,0,1025,0,1044,0,64,17,27,16,0,1093,1044,1,1024,81,4,81,1093,19]

theorem envBound3205 : H12AffineFastState.Bounded env3205 := by
  intro p hp
  have h : env3205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3204_3205 : H12AffineEnvironment.transform 6 27 env3204 = env3205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 27 env3204 == env3205) = true)

theorem identity3205 : scanCanonicalize (H12AffineFastState.compose env3205 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 22) := by decide +kernel

theorem selectedBound3205 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3206 : List Nat := [2,4,8,16,1,64,27,4,19,22,1,2,8,83,0,17,83,0,23,0,2,0,64,17,27,16,0,83,2,1,22,81,4,81,83,19]

theorem envBound3206 : H12AffineFastState.Bounded env3206 := by
  intro p hp
  have h : env3206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3205_3206 : H12AffineEnvironment.transform 9 22 env3205 = env3206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 22 env3205 == env3206) = true)

theorem identity3206 : scanCanonicalize (H12AffineFastState.compose env3206 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound3206 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3207 : List Nat := [2,4,8,16,1,16,27,4,19,22,1,2,8,3,0,17,3,0,23,0,2,0,16,17,27,16,0,3,2,1,22,1,4,1,3,19]

theorem envBound3207 : H12AffineFastState.Bounded env3207 := by
  intro p hp
  have h : env3207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3206_3207 : H12AffineEnvironment.transform 5 16 env3206 = env3207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env3206 == env3207) = true)

theorem identity3207 : scanCanonicalize (H12AffineFastState.compose env3207 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3207 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3208 : List Nat := [2,4,8,2,1,2,9,4,1,4,1,2,8,3,0,3,3,0,5,0,2,0,2,3,9,2,0,3,2,1,4,1,4,1,3,1]

theorem envBound3208 : H12AffineFastState.Bounded env3208 := by
  intro p hp
  have h : env3208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3207_3208 : H12AffineEnvironment.transform 3 2 env3207 = env3208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3207 == env3208) = true)

theorem identity3208 : scanCanonicalize (H12AffineFastState.compose env3208 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3208 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3209 : List Nat := [2,4,3,2,1,2,2,4,1,4,1,2,3,3,0,3,3,0,5,0,2,0,2,3,2,2,0,3,2,1,4,1,4,1,3,1]

theorem envBound3209 : H12AffineFastState.Bounded env3209 := by
  intro p hp
  have h : env3209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3208_3209 : H12AffineEnvironment.transform 2 3 env3208 = env3209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3208 == env3209) = true)

def env3210 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,1,524288,8832,2097152,8200,17665,206533,33554432,5376,2253853,16384,131153,26309,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3210 : H12AffineFastState.Bounded env3210 := by
  intro p hp
  have h : env3210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3177_3210 : H12AffineEnvironment.transform 17 1 env3177 = env3210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env3177 == env3210) = true)

def env3211 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,1,524288,8832,2097152,8200,17665,74629,33554432,5376,2122077,16384,1297,26309,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3211 : H12AffineFastState.Bounded env3211 := by
  intro p hp
  have h : env3211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3210_3211 : H12AffineEnvironment.transform 16 1344 env3210 = env3211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3210 == env3211) = true)

theorem identity3211 : scanCanonicalize (H12AffineFastState.compose env3211 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3211 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3212 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,1,524288,8832,4096,8200,17665,74629,33554432,5376,29021,16384,1297,26309,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3212 : H12AffineFastState.Bounded env3212 := by
  intro p hp
  have h : env3212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3211_3212 : H12AffineEnvironment.transform 20 4096 env3211 = env3212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3211 == env3212) = true)

theorem identity3212 : scanCanonicalize (H12AffineFastState.compose env3212 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 8736) := by decide +kernel

theorem selectedBound3212 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3213 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,1,524288,8832,4096,8200,17665,74629,8736,5376,29021,16384,1297,26309,1285,4294967296,256,4295579102,1344,168]

theorem envBound3213 : H12AffineFastState.Bounded env3213 := by
  intro p hp
  have h : env3213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3212_3213 : H12AffineEnvironment.transform 24 8736 env3212 = env3213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8736 env3212 == env3213) = true)

theorem identity3213 : scanCanonicalize (H12AffineFastState.compose env3213 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound3213 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3214 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,8192,16384,8832,65536,1344,1,524288,8832,1945,8200,17665,74629,8736,665,26308,16384,1297,26309,1285,4294967296,256,4295574087,1344,168]

theorem envBound3214 : H12AffineFastState.Bounded env3214 := by
  intro p hp
  have h : env3214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3213_3214 : H12AffineEnvironment.transform 11 1945 env3213 = env3214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env3213 == env3214) = true)

theorem identity3214 : scanCanonicalize (H12AffineFastState.compose env3214 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound3214 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3215 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1328,8192,16384,8233,65536,1344,1,524288,8233,1328,8200,17665,74028,8329,48,25709,16384,1297,25708,1285,4294967296,256,4295573742,1344,168]

theorem envBound3215 : H12AffineFastState.Bounded env3215 := by
  intro p hp
  have h : env3215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3214_3215 : H12AffineEnvironment.transform 8 169 env3214 = env3215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env3214 == env3215) = true)

theorem identity3215 : scanCanonicalize (H12AffineFastState.compose env3215 (packedSelected [0,7,16] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3215 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env3216 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,8192,16384,8201,65536,1344,1,524288,8201,1296,8200,17665,73996,8329,16,25677,16384,1297,25676,1285,4294967296,256,4295573710,1344,136]

theorem envBound3216 : H12AffineFastState.Bounded env3216 := by
  intro p hp
  have h : env3216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3215_3216 : H12AffineEnvironment.transform 4 0 env3215 = env3216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3215 == env3216) = true)

theorem identity3216 : scanCanonicalize (H12AffineFastState.compose env3216 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(13+1) ^^^ 1344) := by decide +kernel

theorem selectedBound3216 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3217 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,8192,1344,8201,65536,1344,1,524288,8201,1296,8200,65,73996,8329,16,8461,1344,1297,8460,1285,4294967296,256,4295558542,1344,136]

theorem envBound3217 : H12AffineFastState.Bounded env3217 := by
  intro p hp
  have h : env3217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3216_3217 : H12AffineEnvironment.transform 13 1344 env3216 = env3217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1344 env3216 == env3217) = true)

theorem identity3217 : scanCanonicalize (H12AffineFastState.compose env3217 (packedSelected [1,3,5] rootPS)) = affineNative (2^(18+1) ^^^ 1500) := by decide +kernel

theorem selectedBound3217 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3218 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,8192,1344,8201,65536,1344,1,1500,8201,1296,8200,65,73996,8329,16,8461,1344,1297,8460,1285,4294967296,256,4295032914,1344,136]

theorem envBound3218 : H12AffineFastState.Bounded env3218 := by
  intro p hp
  have h : env3218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3217_3218 : H12AffineEnvironment.transform 18 1500 env3217 = env3218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1500 env3217 == env3218) = true)

theorem identity3218 : scanCanonicalize (H12AffineFastState.compose env3218 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 8282) := by decide +kernel

theorem selectedBound3218 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3219 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,8192,1344,8201,8282,1344,1,1500,8201,1296,8200,65,342,8329,16,8461,1344,1297,8460,1285,4294967296,256,4294975496,1344,136]

theorem envBound3219 : H12AffineFastState.Bounded env3219 := by
  intro p hp
  have h : env3219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3218_3219 : H12AffineEnvironment.transform 15 8282 env3218 = env3219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8282 env3218 == env3219) = true)

theorem identity3219 : scanCanonicalize (H12AffineFastState.compose env3219 (packedSelected [1,3,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 9) := by decide +kernel

theorem selectedBound3219 : packedSelected [1,3,10,13] rootPS < 2^1333 := by decide +kernel

def env3220 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1296,9,1344,0,83,1344,1,1500,0,1296,1,65,342,128,16,260,1344,1297,261,1285,4294967296,256,4294967297,1344,136]

theorem envBound3220 : H12AffineFastState.Bounded env3220 := by
  intro p hp
  have h : env3220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3219_3220 : H12AffineEnvironment.transform 12 9 env3219 = env3220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 9 env3219 == env3220) = true)

theorem identity3220 : scanCanonicalize (H12AffineFastState.compose env3220 (packedSelected [1,2,3] rootPS)) = affineNative (2^(7+1) ^^^ 205) := by decide +kernel

theorem selectedBound3220 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env3221 : List Nat := [2,4,8,16,0,64,128,205,137,1024,1,1245,9,1165,0,83,1165,1,1041,0,1245,1,65,155,128,16,201,1165,1244,200,1224,4294967296,205,4294967297,1165,136]

theorem envBound3221 : H12AffineFastState.Bounded env3221 := by
  intro p hp
  have h : env3221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3220_3221 : H12AffineEnvironment.transform 7 205 env3220 = env3221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 205 env3220 == env3221) = true)

theorem identity3221 : scanCanonicalize (H12AffineFastState.compose env3221 (packedSelected [1,2,10] rootPS)) = affineNative (2^(6+1) ^^^ 73) := by decide +kernel

theorem selectedBound3221 : packedSelected [1,2,10] rootPS < 2^1333 := by decide +kernel

def env3222 : List Nat := [2,4,8,16,0,64,73,4,64,1024,1,1044,9,1092,0,83,1092,1,1041,0,1044,1,65,82,73,16,0,1092,1045,1,1025,4294967296,4,4294967297,1092,65]

theorem envBound3222 : H12AffineFastState.Bounded env3222 := by
  intro p hp
  have h : env3222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3221_3222 : H12AffineEnvironment.transform 6 73 env3221 = env3222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 73 env3221 == env3222) = true)

theorem identity3222 : scanCanonicalize (H12AffineFastState.compose env3222 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound3222 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3223 : List Nat := [2,4,8,16,0,64,73,4,64,1024,1,1044,9,1092,0,83,1092,1,1041,0,1044,1,65,82,73,16,0,1092,1045,1,1025,75,4,74,1092,65]

theorem envBound3223 : H12AffineFastState.Bounded env3223 := by
  intro p hp
  have h : env3223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3222_3223 : H12AffineEnvironment.transform 31 75 env3222 = env3223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env3222 == env3223) = true)

def env3224 : List Nat := [2,4,8,0,0,64,73,4,64,1024,1,1028,9,1092,0,67,1092,1,1025,0,1028,1,65,66,73,0,0,1092,1029,1,1025,75,4,74,1092,65]

theorem envBound3224 : H12AffineFastState.Bounded env3224 := by
  intro p hp
  have h : env3224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3223_3224 : H12AffineEnvironment.transform 3 0 env3223 = env3224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3223 == env3224) = true)

def leafEnv3224 : List Nat := [2,4,8,0,0,64,73,4,64,1024,1,1028,9,1092,0,67,1092,1,1025,0,1028,1,65,66,1024,73,1,0,0,1092,1029,1,1025,75,4,74,4,2,1092,65,0,1029,1]

def active3224 : List Nat := [0,1,2,5,9]

def tree3224 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3224 : H12WitnessSearch.Good tree3224 := H12GlobalWitnessIndex.good

theorem leafIdentity3224 : H12AffineFastState.composeSystem env3224 rootObs = leafEnv3224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3224 rootObs == leafEnv3224) = true)

theorem terminalChecked3224 : H12PackedTerminal.terminalCheckFast leafEnv3224 active3224 tree3224 = true := by decide +kernel

def env3225 : List Nat := [2,4,8,1,0,64,73,4,64,1024,1,1029,9,1092,0,66,1092,1,1024,0,1029,1,65,67,73,1,0,1092,1028,1,1025,75,4,74,1092,65]

theorem envBound3225 : H12AffineFastState.Bounded env3225 := by
  intro p hp
  have h : env3225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3223_3225 : H12AffineEnvironment.transform 3 1 env3223 = env3225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env3223 == env3225) = true)

theorem identity3225 : scanCanonicalize (H12AffineFastState.compose env3225 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound3225 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3226 : List Nat := [2,4,8,1,0,10,3,4,10,1024,1,1029,9,1038,0,8,1038,1,1024,0,1029,1,11,9,3,1,0,1038,1028,1,1025,1,4,0,1038,11]

theorem envBound3226 : H12AffineFastState.Bounded env3226 := by
  intro p hp
  have h : env3226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3225_3226 : H12AffineEnvironment.transform 5 10 env3225 = env3226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env3225 == env3226) = true)

def leafEnv3226 : List Nat := [2,4,8,1,0,10,3,4,10,1024,1,1029,9,1038,0,8,1038,1,1024,0,1029,1,11,9,1025,3,1,1,0,1038,1028,1,1025,1,4,0,4,2,1038,11,0,1028,1]

def active3226 : List Nat := [0,1,2,9]

def tree3226 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3226 : H12WitnessSearch.Good tree3226 := H12GlobalWitnessIndex.good

theorem leafIdentity3226 : H12AffineFastState.composeSystem env3226 rootObs = leafEnv3226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3226 rootObs == leafEnv3226) = true)

theorem terminalChecked3226 : H12PackedTerminal.terminalCheckFast leafEnv3226 active3226 tree3226 = true := by decide +kernel

def env3227 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8200,17665,74628,33554432,5376,2122076,16384,1296,26309,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound3227 : H12AffineFastState.Bounded env3227 := by
  intro p hp
  have h : env3227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3210_3227 : H12AffineEnvironment.transform 16 1345 env3210 = env3227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3210 == env3227) = true)

theorem identity3227 : scanCanonicalize (H12AffineFastState.compose env3227 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3227 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3228 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8200,17665,74628,2647256,5376,2122076,16384,1296,26309,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound3228 : H12AffineFastState.Bounded env3228 := by
  intro p hp
  have h : env3228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3227_3228 : H12AffineEnvironment.transform 24 2647256 env3227 = env3228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3227 == env3228) = true)

theorem identity3228 : scanCanonicalize (H12AffineFastState.compose env3228 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 74903) := by decide +kernel

theorem selectedBound3228 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3229 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,1,524288,8832,74903,8200,17665,74628,606287,5376,83403,16384,1296,26309,1284,4294967296,256,4294981552,1345,615111]

theorem envBound3229 : H12AffineFastState.Bounded env3229 := by
  intro p hp
  have h : env3229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3228_3229 : H12AffineEnvironment.transform 20 74903 env3228 = env3229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 74903 env3228 == env3229) = true)

theorem identity3229 : scanCanonicalize (H12AffineFastState.compose env3229 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(15+1) ^^^ 13463) := by decide +kernel

theorem selectedBound3229 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3230 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,13463,1345,1,524288,8832,4096,8200,17665,5907,554200,5376,29020,16384,1296,26309,1284,4294967296,256,4294981552,1345,546384]

theorem envBound3230 : H12AffineFastState.Bounded env3230 := by
  intro p hp
  have h : env3230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3229_3230 : H12AffineEnvironment.transform 15 13463 env3229 = env3230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13463 env3229 == env3230) = true)

theorem identity3230 : scanCanonicalize (H12AffineFastState.compose env3230 (packedSelected [20] rootPS)) = affineNative (2^(18+1) ^^^ 17384) := by decide +kernel

theorem selectedBound3230 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3231 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,13463,1345,1,17384,8832,4096,8200,17665,5907,14128,5376,29020,16384,1296,26309,1284,4294967296,256,4294981552,1345,5560]

theorem envBound3231 : H12AffineFastState.Bounded env3231 := by
  intro p hp
  have h : env3231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3230_3231 : H12AffineEnvironment.transform 18 17384 env3230 = env3231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 17384 env3230 == env3231) = true)

theorem identity3231 : scanCanonicalize (H12AffineFastState.compose env3231 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4857) := by decide +kernel

theorem selectedBound3231 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3232 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4857,8832,13463,1345,1,4369,8832,4096,8200,6136,5907,14128,5376,9125,4857,1296,13372,1284,4294967296,256,4294981552,1345,5560]

theorem envBound3232 : H12AffineFastState.Bounded env3232 := by
  intro p hp
  have h : env3232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3231_3232 : H12AffineEnvironment.transform 13 4857 env3231 = env3232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4857 env3231 == env3232) = true)

theorem identity3232 : scanCanonicalize (H12AffineFastState.compose env3232 (packedSelected [1,5,8,12,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 43) := by decide +kernel

theorem selectedBound3232 : packedSelected [1,5,8,12,15,17] rootPS < 2^1333 := by decide +kernel

def env3233 : List Nat := [2,4,8,16,32,64,128,256,43,1024,1,4096,8192,4306,8363,13463,1345,1,4369,8363,4096,8200,5587,5432,13595,5376,8590,4306,1296,13372,1284,4294967296,256,4294981019,1345,5560]

theorem envBound3233 : H12AffineFastState.Bounded env3233 := by
  intro p hp
  have h : env3233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3232_3233 : H12AffineEnvironment.transform 8 43 env3232 = env3233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 43 env3232 == env3233) = true)

theorem identity3233 : scanCanonicalize (H12AffineFastState.compose env3233 (packedSelected [1,3,5,8,10,16,18,19] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3233 : packedSelected [1,3,5,8,10,16,18,19] rootPS < 2^1333 := by decide +kernel

def env3234 : List Nat := [2,4,8,16,1,64,128,256,10,1024,1,4096,8192,4306,8330,13463,1345,1,4369,8330,4096,8200,5587,5401,13595,5376,8590,4306,1296,13341,1284,4294967296,256,4294981019,1345,5529]

theorem envBound3234 : H12AffineFastState.Bounded env3234 := by
  intro p hp
  have h : env3234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3233_3234 : H12AffineEnvironment.transform 4 1 env3233 = env3234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3233 == env3234) = true)

theorem identity3234 : scanCanonicalize (H12AffineFastState.compose env3234 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound3234 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env3235 : List Nat := [2,4,8,16,1,64,128,256,10,1024,1,4096,269,4306,391,5530,1345,1,4369,391,4096,261,5587,5401,5142,5376,131,4306,1296,5392,1284,4294967296,256,4294972566,1345,5529]

theorem envBound3235 : H12AffineFastState.Bounded env3235 := by
  intro p hp
  have h : env3235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3234_3235 : H12AffineEnvironment.transform 12 269 env3234 = env3235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env3234 == env3235) = true)

theorem identity3235 : scanCanonicalize (H12AffineFastState.compose env3235 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound3235 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env3236 : List Nat := [2,4,8,16,1,64,128,256,10,1024,1,1296,269,1474,391,138,1345,1,1025,391,1296,261,195,9,262,16,131,1474,1296,0,1284,4294967296,256,4294967686,1345,137]

theorem envBound3236 : H12AffineFastState.Bounded env3236 := by
  intro p hp
  have h : env3236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3235_3236 : H12AffineEnvironment.transform 11 1296 env3235 = env3236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3235 == env3236) = true)

theorem identity3236 : scanCanonicalize (H12AffineFastState.compose env3236 (packedSelected [0,1,2,3,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound3236 : packedSelected [0,1,2,3,4,6] rootPS < 2^1333 := by decide +kernel

def env3237 : List Nat := [2,4,8,16,1,64,3,256,10,1024,1,1296,269,1345,260,9,1345,1,1025,260,1296,261,64,9,262,16,0,1345,1296,0,1284,4294967296,256,4294967557,1345,10]

theorem envBound3237 : H12AffineFastState.Bounded env3237 := by
  intro p hp
  have h : env3237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3236_3237 : H12AffineEnvironment.transform 6 3 env3236 = env3237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env3236 == env3237) = true)

theorem identity3237 : scanCanonicalize (H12AffineFastState.compose env3237 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound3237 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3238 : List Nat := [2,4,8,16,1,64,3,15,10,1024,1,1055,2,1102,11,9,1102,1,1025,11,1055,10,64,9,9,16,0,1102,1055,0,1035,4294967296,15,4294967306,1102,10]

theorem envBound3238 : H12AffineFastState.Bounded env3238 := by
  intro p hp
  have h : env3238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3237_3238 : H12AffineEnvironment.transform 7 15 env3237 = env3238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env3237 == env3238) = true)

theorem identity3238 : scanCanonicalize (H12AffineFastState.compose env3238 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 66) := by decide +kernel

theorem selectedBound3238 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3239 : List Nat := [2,4,8,16,1,64,3,15,10,1024,1,1055,2,1102,11,9,1102,1,1025,11,1055,10,64,9,9,16,0,1102,1055,0,1035,66,15,72,1102,10]

theorem envBound3239 : H12AffineFastState.Bounded env3239 := by
  intro p hp
  have h : env3239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3238_3239 : H12AffineEnvironment.transform 31 66 env3238 = env3239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 66 env3238 == env3239) = true)

theorem identity3239 : scanCanonicalize (H12AffineFastState.compose env3239 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound3239 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3240 : List Nat := [2,4,8,9,1,64,3,15,10,1024,1,1030,2,1102,11,9,1102,1,1025,11,1030,10,64,9,9,9,0,1102,1030,0,1035,66,15,72,1102,10]

theorem envBound3240 : H12AffineFastState.Bounded env3240 := by
  intro p hp
  have h : env3240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3239_3240 : H12AffineEnvironment.transform 3 9 env3239 = env3240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env3239 == env3240) = true)

theorem identity3240 : scanCanonicalize (H12AffineFastState.compose env3240 (packedSelected [1,2] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound3240 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env3241 : List Nat := [2,4,8,9,1,64,3,15,10,15,1,9,2,65,11,9,65,1,14,11,9,10,64,9,9,9,0,65,9,0,4,66,15,72,65,10]

theorem envBound3241 : H12AffineFastState.Bounded env3241 := by
  intro p hp
  have h : env3241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3240_3241 : H12AffineEnvironment.transform 9 15 env3240 = env3241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env3240 == env3241) = true)

theorem identity3241 : scanCanonicalize (H12AffineFastState.compose env3241 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 8) := by decide +kernel

theorem selectedBound3241 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3242 : List Nat := [2,4,8,9,1,8,3,15,10,15,1,9,2,9,11,9,9,1,14,11,9,10,8,9,9,9,0,9,9,0,4,10,15,0,9,10]

theorem envBound3242 : H12AffineFastState.Bounded env3242 := by
  intro p hp
  have h : env3242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3241_3242 : H12AffineEnvironment.transform 5 8 env3241 = env3242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 8 env3241 == env3242) = true)

theorem identity3242 : scanCanonicalize (H12AffineFastState.compose env3242 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3242 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3243 : List Nat := [2,4,3,2,1,3,3,4,1,4,1,2,2,2,0,2,2,1,5,0,2,1,3,2,2,2,0,2,2,0,4,1,4,0,2,1]

theorem envBound3243 : H12AffineFastState.Bounded env3243 := by
  intro p hp
  have h : env3243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3242_3243 : H12AffineEnvironment.transform 2 3 env3242 = env3243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3242 == env3243) = true)

def env3244 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,10249,17665,206532,33554432,5376,2518045,16384,131153,1073741824,131141,4294967296,256,4329274046,131072,33563272]

theorem envBound3244 : H12AffineFastState.Bounded env3244 := by
  intro p hp
  have h : env3244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3109_3244 : H12AffineEnvironment.transform 14 8833 env3109 = env3244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8833 env3109 == env3244) = true)

def env3245 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8201,17665,206532,33554432,5376,2515997,16384,131153,1073741824,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3245 : H12AffineFastState.Bounded env3245 := by
  intro p hp
  have h : env3245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3244_3245 : H12AffineEnvironment.transform 10 0 env3244 = env3245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env3244 == env3245) = true)

theorem identity3245 : scanCanonicalize (H12AffineFastState.compose env3245 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 2106429) := by decide +kernel

theorem selectedBound3245 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3246 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8201,17665,206532,33554432,5376,2515997,16384,131153,2106429,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3246 : H12AffineFastState.Bounded env3246 := by
  intro p hp
  have h : env3246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3245_3246 : H12AffineEnvironment.transform 29 2106429 env3245 = env3246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2106429 env3245 == env3246) = true)

def env3247 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,0,524288,8833,2097152,8201,17665,206532,33554432,5376,2253853,16384,131153,2106429,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3247 : H12AffineFastState.Bounded env3247 := by
  intro p hp
  have h : env3247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3246_3247 : H12AffineEnvironment.transform 17 0 env3246 = env3247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env3246 == env3247) = true)

def env3248 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,0,524288,8833,2097152,8201,17665,74628,33554432,5376,2122077,16384,1297,2106429,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3248 : H12AffineFastState.Bounded env3248 := by
  intro p hp
  have h : env3248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3247_3248 : H12AffineEnvironment.transform 16 1344 env3247 = env3248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3247 == env3248) = true)

theorem identity3248 : scanCanonicalize (H12AffineFastState.compose env3248 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3248 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3249 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,0,524288,8833,4096,8201,17665,74628,33554432,5376,29021,16384,1297,13373,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3249 : H12AffineFastState.Bounded env3249 := by
  intro p hp
  have h : env3249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3248_3249 : H12AffineEnvironment.transform 20 4096 env3248 = env3249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3248 == env3249) = true)

theorem identity3249 : scanCanonicalize (H12AffineFastState.compose env3249 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 1993) := by decide +kernel

theorem selectedBound3249 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3250 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,1993,8833,65536,1344,0,524288,8833,4096,8201,712,74628,33554432,5376,13972,1993,1297,13373,1285,4294967296,256,4329123895,1344,33563272]

theorem envBound3250 : H12AffineFastState.Bounded env3250 := by
  intro p hp
  have h : env3250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3249_3250 : H12AffineEnvironment.transform 13 1993 env3249 = env3250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1993 env3249 == env3250) = true)

theorem identity3250 : scanCanonicalize (H12AffineFastState.compose env3250 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound3250 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3251 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,4096,8192,1377,8233,65536,1344,0,524288,8233,4096,8201,96,74028,33554432,5376,13372,1377,1297,13373,1285,4294967296,256,4329123895,1344,33562656]

theorem envBound3251 : H12AffineFastState.Bounded env3251 := by
  intro p hp
  have h : env3251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3250_3251 : H12AffineEnvironment.transform 8 168 env3250 = env3251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env3250 == env3251) = true)

theorem identity3251 : scanCanonicalize (H12AffineFastState.compose env3251 (packedSelected [1,10,12,13,15,19,21,24] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound3251 : packedSelected [1,10,12,13,15,19,21,24] rootPS < 2^1333 := by decide +kernel

def env3252 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1296,8192,1377,8233,65536,1344,0,524288,8233,1296,8201,96,74028,33554432,16,8492,1377,1297,8493,1285,4294967296,256,4329121063,1344,33562656]

theorem envBound3252 : H12AffineFastState.Bounded env3252 := by
  intro p hp
  have h : env3252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3251_3252 : H12AffineEnvironment.transform 11 1296 env3251 = env3252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3251 == env3252) = true)

theorem identity3252 : scanCanonicalize (H12AffineFastState.compose env3252 (packedSelected [1,3,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 8360) := by decide +kernel

theorem selectedBound3252 : packedSelected [1,3,10,19] rootPS < 2^1333 := by decide +kernel

def env3253 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1296,8192,1377,8233,65536,1344,0,524288,8233,1296,8201,96,74028,8360,16,8492,1377,1297,8493,1285,4294967296,256,4295558543,1344,136]

theorem envBound3253 : H12AffineFastState.Bounded env3253 := by
  intro p hp
  have h : env3253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3252_3253 : H12AffineEnvironment.transform 24 8360 env3252 = env3253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8360 env3252 == env3253) = true)

theorem identity3253 : scanCanonicalize (H12AffineFastState.compose env3253 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(7+1) ^^^ 253) := by decide +kernel

theorem selectedBound3253 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3254 : List Nat := [2,4,8,16,32,64,128,253,168,1024,0,1261,8192,1180,8233,65536,1213,0,524288,8233,1261,8201,96,73937,8360,16,8401,1180,1260,8400,1272,4294967296,253,4295558258,1213,136]

theorem envBound3254 : H12AffineFastState.Bounded env3254 := by
  intro p hp
  have h : env3254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3253_3254 : H12AffineEnvironment.transform 7 253 env3253 = env3254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 253 env3253 == env3254) = true)

theorem identity3254 : scanCanonicalize (H12AffineFastState.compose env3254 (packedSelected [5,6,8,25] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3254 : packedSelected [5,6,8,25] rootPS < 2^1333 := by decide +kernel

def env3255 : List Nat := [2,4,8,16,1,64,128,220,137,1024,0,1228,8192,1180,8200,65536,1180,0,524288,8200,1228,8201,65,73937,8329,16,8401,1180,1229,8400,1241,4294967296,220,4295558227,1180,136]

theorem envBound3255 : H12AffineFastState.Bounded env3255 := by
  intro p hp
  have h : env3255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3254_3255 : H12AffineEnvironment.transform 4 1 env3254 = env3255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3254 == env3255) = true)

theorem identity3255 : scanCanonicalize (H12AffineFastState.compose env3255 (packedSelected [0,7] rootPS)) = affineNative (2^(18+1) ^^^ 74843) := by decide +kernel

theorem selectedBound3255 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3256 : List Nat := [2,4,8,16,1,64,128,220,137,1024,0,1228,8192,1180,8200,65536,1180,0,74843,8200,1228,8201,65,73937,8329,16,8401,1180,1229,8400,1241,4294967296,220,4294975496,1180,136]

theorem envBound3256 : H12AffineFastState.Bounded env3256 := by
  intro p hp
  have h : env3256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3255_3256 : H12AffineEnvironment.transform 18 74843 env3255 = env3256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 74843 env3255 == env3256) = true)

theorem identity3256 : scanCanonicalize (H12AffineFastState.compose env3256 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 8282) := by decide +kernel

theorem selectedBound3256 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env3257 : List Nat := [2,4,8,16,1,64,128,220,137,1024,0,1228,8192,1180,8200,8282,1180,0,1025,8200,1228,8201,65,139,8329,16,8401,1180,1229,8400,1241,4294967296,220,4294975496,1180,136]

theorem envBound3257 : H12AffineFastState.Bounded env3257 := by
  intro p hp
  have h : env3257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3256_3257 : H12AffineEnvironment.transform 15 8282 env3256 = env3257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8282 env3256 == env3257) = true)

theorem identity3257 : scanCanonicalize (H12AffineFastState.compose env3257 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 9) := by decide +kernel

theorem selectedBound3257 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3258 : List Nat := [2,4,8,16,1,64,128,220,137,1024,0,1228,9,1180,1,83,1180,0,1025,1,1228,0,65,139,128,16,216,1180,1229,217,1241,4294967296,220,4294967297,1180,136]

theorem envBound3258 : H12AffineFastState.Bounded env3258 := by
  intro p hp
  have h : env3258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3257_3258 : H12AffineEnvironment.transform 12 9 env3257 = env3258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 9 env3257 == env3258) = true)

theorem identity3258 : scanCanonicalize (H12AffineFastState.compose env3258 (packedSelected [0,1] rootPS)) = affineNative (2^(6+1) ^^^ 73) := by decide +kernel

theorem selectedBound3258 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env3259 : List Nat := [2,4,8,16,1,64,73,21,64,1024,0,1029,9,1109,1,83,1109,0,1025,1,1029,0,65,66,73,16,17,1109,1028,16,1040,4294967296,21,4294967297,1109,65]

theorem envBound3259 : H12AffineFastState.Bounded env3259 := by
  intro p hp
  have h : env3259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3258_3259 : H12AffineEnvironment.transform 6 73 env3258 = env3259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 73 env3258 == env3259) = true)

theorem identity3259 : scanCanonicalize (H12AffineFastState.compose env3259 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3259 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3260 : List Nat := [2,4,8,0,1,64,73,5,64,1024,0,1029,9,1093,1,67,1093,0,1025,1,1029,0,65,66,73,0,1,1093,1028,0,1024,4294967296,5,4294967297,1093,65]

theorem envBound3260 : H12AffineFastState.Bounded env3260 := by
  intro p hp
  have h : env3260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3259_3260 : H12AffineEnvironment.transform 3 0 env3259 = env3260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3259 == env3260) = true)

theorem identity3260 : scanCanonicalize (H12AffineFastState.compose env3260 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 74) := by decide +kernel

theorem selectedBound3260 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3261 : List Nat := [2,4,8,0,1,64,73,5,64,1024,0,1029,9,1093,1,67,1093,0,1025,1,1029,0,65,66,73,0,1,1093,1028,0,1024,74,5,75,1093,65]

theorem envBound3261 : H12AffineFastState.Bounded env3261 := by
  intro p hp
  have h : env3261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3260_3261 : H12AffineEnvironment.transform 31 74 env3260 = env3261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 74 env3260 == env3261) = true)

def leafEnv3261 : List Nat := [2,4,8,0,1,64,73,5,64,1024,0,1029,9,1093,1,67,1093,0,1025,1,1029,0,65,66,1025,73,1,0,1,1093,1028,0,1024,74,5,75,4,2,1093,65,0,1028,1]

def active3261 : List Nat := [0,1,2,5,9]

def tree3261 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3261 : H12WitnessSearch.Good tree3261 := H12GlobalWitnessIndex.good

theorem leafIdentity3261 : H12AffineFastState.composeSystem env3261 rootObs = leafEnv3261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3261 rootObs == leafEnv3261) = true)

theorem terminalChecked3261 : H12PackedTerminal.terminalCheckFast leafEnv3261 active3261 tree3261 = true := by decide +kernel

def env3262 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8201,17665,74629,33554432,5376,2122076,16384,1296,2106429,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound3262 : H12AffineFastState.Bounded env3262 := by
  intro p hp
  have h : env3262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3247_3262 : H12AffineEnvironment.transform 16 1345 env3247 = env3262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3247 == env3262) = true)

theorem identity3262 : scanCanonicalize (H12AffineFastState.compose env3262 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3262 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3263 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8201,17665,74629,2647256,5376,2122076,16384,1296,2106429,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound3263 : H12AffineFastState.Bounded env3263 := by
  intro p hp
  have h : env3263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3262_3263 : H12AffineEnvironment.transform 24 2647256 env3262 = env3263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3262 == env3263) = true)

theorem identity3263 : scanCanonicalize (H12AffineFastState.compose env3263 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(15+1) ^^^ 26222) := by decide +kernel

theorem selectedBound3263 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3264 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,26222,1345,0,524288,8833,2097152,8201,17665,17899,2647256,5376,2122076,16384,1296,2106429,1284,4294967296,256,4297094473,1345,2639440]

theorem envBound3264 : H12AffineFastState.Bounded env3264 := by
  intro p hp
  have h : env3264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3263_3264 : H12AffineEnvironment.transform 15 26222 env3263 = env3264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26222 env3263 == env3264) = true)

theorem identity3264 : scanCanonicalize (H12AffineFastState.compose env3264 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3264 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3265 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,26222,1345,0,524288,8833,4096,8201,17665,17899,554200,5376,29020,16384,1296,13373,1284,4294967296,256,4294993225,1345,546384]

theorem envBound3265 : H12AffineFastState.Bounded env3265 := by
  intro p hp
  have h : env3265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3264_3265 : H12AffineEnvironment.transform 20 4096 env3264 = env3265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3264 == env3265) = true)

theorem identity3265 : scanCanonicalize (H12AffineFastState.compose env3265 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 4824) := by decide +kernel

theorem selectedBound3265 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3266 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,8833,13494,1345,0,524288,8833,4096,8201,6105,5939,534016,5376,9092,4824,1296,13373,1284,4294967296,256,4294981521,1345,525448]

theorem envBound3266 : H12AffineFastState.Bounded env3266 := by
  intro p hp
  have h : env3266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3265_3266 : H12AffineEnvironment.transform 13 4824 env3265 = env3266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env3265 == env3266) = true)

theorem identity3266 : scanCanonicalize (H12AffineFastState.compose env3266 (packedSelected [1,3,8,10,12,17] rootPS)) = affineNative (2^(18+1) ^^^ 9646) := by decide +kernel

theorem selectedBound3266 : packedSelected [1,3,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env3267 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,8833,13494,1345,0,9646,8833,4096,8201,6105,5939,942,5376,9092,4824,1296,13373,1284,4294967296,256,4294981521,1345,8486]

theorem envBound3267 : H12AffineFastState.Bounded env3267 := by
  intro p hp
  have h : env3267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3266_3267 : H12AffineEnvironment.transform 18 9646 env3266 = env3267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 9646 env3266 == env3267) = true)

theorem identity3267 : scanCanonicalize (H12AffineFastState.compose env3267 (packedSelected [1,3,5,13,15,19] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound3267 : packedSelected [1,3,5,13,15,19] rootPS < 2^1333 := by decide +kernel

def env3268 : List Nat := [2,4,8,16,32,64,128,256,429,1024,0,4096,8192,4469,8492,13494,1345,0,9646,8492,4096,8201,5236,5278,3,5376,8233,4469,1296,13373,1284,4294967296,256,4294980668,1345,8486]

theorem envBound3268 : H12AffineFastState.Bounded env3268 := by
  intro p hp
  have h : env3268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3267_3268 : H12AffineEnvironment.transform 8 429 env3267 = env3268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env3267 == env3268) = true)

theorem identity3268 : scanCanonicalize (H12AffineFastState.compose env3268 (packedSelected [1,2,3,4,5,6,7,8,12,13,15,16,21] rootPS)) = affineNative (2^(12+1) ^^^ 399) := by decide +kernel

theorem selectedBound3268 : packedSelected [1,2,3,4,5,6,7,8,12,13,15,16,21] rootPS < 2^1333 := by decide +kernel

def env3269 : List Nat := [2,4,8,16,32,64,128,256,429,1024,0,4096,399,4469,163,5433,1345,0,1057,163,4096,390,5236,5278,3,5376,422,4469,1296,5554,1284,4294967296,256,4294972851,1345,169]

theorem envBound3269 : H12AffineFastState.Bounded env3269 := by
  intro p hp
  have h : env3269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3268_3269 : H12AffineEnvironment.transform 12 399 env3268 = env3269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 399 env3268 == env3269) = true)

theorem identity3269 : scanCanonicalize (H12AffineFastState.compose env3269 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 1328) := by decide +kernel

theorem selectedBound3269 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3270 : List Nat := [2,4,8,16,32,64,128,256,429,1024,0,1328,399,1093,163,9,1345,0,1057,163,1328,390,324,430,3,48,422,1093,1296,130,1284,4294967296,256,4294967427,1345,169]

theorem envBound3270 : H12AffineFastState.Bounded env3270 := by
  intro p hp
  have h : env3270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3269_3270 : H12AffineEnvironment.transform 11 1328 env3269 = env3270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1328 env3269 == env3270) = true)

theorem identity3270 : scanCanonicalize (H12AffineFastState.compose env3270 (packedSelected [1,2,3,6,7,9,12,15] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3270 : packedSelected [1,2,3,6,7,9,12,15] rootPS < 2^1333 := by decide +kernel

def env3271 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1044,171,1093,163,9,1125,0,1057,163,1044,162,96,138,3,48,130,1093,1076,130,1056,4294967296,36,4294967427,1125,169]

theorem envBound3271 : H12AffineFastState.Bounded env3271 := by
  intro p hp
  have h : env3271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3270_3271 : H12AffineEnvironment.transform 7 36 env3270 = env3271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3270 == env3271) = true)

theorem identity3271 : scanCanonicalize (H12AffineFastState.compose env3271 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 95) := by decide +kernel

theorem selectedBound3271 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3272 : List Nat := [2,4,8,16,32,64,128,36,137,95,0,75,171,26,163,9,58,0,126,163,75,162,96,138,3,48,130,26,107,130,127,4294967296,36,4294967427,58,169]

theorem envBound3272 : H12AffineFastState.Bounded env3272 := by
  intro p hp
  have h : env3272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3271_3272 : H12AffineEnvironment.transform 9 95 env3271 = env3272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 95 env3271 == env3272) = true)

theorem identity3272 : scanCanonicalize (H12AffineFastState.compose env3272 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 91) := by decide +kernel

theorem selectedBound3272 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3273 : List Nat := [2,4,8,16,32,64,128,36,137,95,0,75,171,26,163,9,58,0,126,163,75,162,96,138,3,48,130,26,107,130,127,91,36,216,58,169]

theorem envBound3273 : H12AffineFastState.Bounded env3273 := by
  intro p hp
  have h : env3273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3272_3273 : H12AffineEnvironment.transform 31 91 env3272 = env3273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 91 env3272 == env3273) = true)

theorem identity3273 : scanCanonicalize (H12AffineFastState.compose env3273 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound3273 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env3274 : List Nat := [2,4,8,16,32,64,3,36,10,95,0,75,40,26,32,9,58,0,126,32,75,33,96,9,3,48,1,26,107,1,127,91,36,91,58,42]

theorem envBound3274 : H12AffineFastState.Bounded env3274 := by
  intro p hp
  have h : env3274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3273_3274 : H12AffineEnvironment.transform 6 3 env3273 = env3274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env3273 == env3274) = true)

theorem identity3274 : scanCanonicalize (H12AffineFastState.compose env3274 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound3274 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3275 : List Nat := [2,4,8,16,32,59,3,36,10,36,0,48,40,26,32,9,58,0,5,32,48,33,27,9,3,48,1,26,16,1,4,32,36,32,58,42]

theorem envBound3275 : H12AffineFastState.Bounded env3275 := by
  intro p hp
  have h : env3275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3274_3275 : H12AffineEnvironment.transform 5 59 env3274 = env3275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env3274 == env3275) = true)

theorem identity3275 : scanCanonicalize (H12AffineFastState.compose env3275 (packedSelected [0,3,4,5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3275 : packedSelected [0,3,4,5] rootPS < 2^1333 := by decide +kernel

def env3276 : List Nat := [2,4,8,16,1,26,3,5,10,5,0,17,9,26,1,9,27,0,5,1,17,0,27,9,3,17,1,26,16,1,4,1,5,1,27,11]

theorem envBound3276 : H12AffineFastState.Bounded env3276 := by
  intro p hp
  have h : env3276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3275_3276 : H12AffineEnvironment.transform 4 1 env3275 = env3276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3275 == env3276) = true)

theorem identity3276 : scanCanonicalize (H12AffineFastState.compose env3276 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound3276 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3277 : List Nat := [2,4,8,1,1,11,3,5,10,5,0,0,9,11,1,9,10,0,5,1,0,0,10,9,3,0,1,11,1,1,4,1,5,1,10,11]

theorem envBound3277 : H12AffineFastState.Bounded env3277 := by
  intro p hp
  have h : env3277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3276_3277 : H12AffineEnvironment.transform 3 1 env3276 = env3277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env3276 == env3277) = true)

theorem identity3277 : scanCanonicalize (H12AffineFastState.compose env3277 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3277 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3278 : List Nat := [2,4,2,1,1,1,3,5,0,5,0,0,3,1,1,3,0,0,5,1,0,0,0,3,3,0,1,1,1,1,4,1,5,1,0,1]

theorem envBound3278 : H12AffineFastState.Bounded env3278 := by
  intro p hp
  have h : env3278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3277_3278 : H12AffineEnvironment.transform 2 2 env3277 = env3278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3277 == env3278) = true)

def env3279 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,1,524288,8833,2097152,8201,17665,206532,33554432,5376,2253852,16384,131153,2106429,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3279 : H12AffineFastState.Bounded env3279 := by
  intro p hp
  have h : env3279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3246_3279 : H12AffineEnvironment.transform 17 1 env3246 = env3279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env3246 == env3279) = true)

def env3280 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,1,524288,8833,2097152,8201,17665,74628,33554432,5376,2122076,16384,1297,2106429,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3280 : H12AffineFastState.Bounded env3280 := by
  intro p hp
  have h : env3280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3279_3280 : H12AffineEnvironment.transform 16 1344 env3279 = env3280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3279 == env3280) = true)

theorem identity3280 : scanCanonicalize (H12AffineFastState.compose env3280 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3280 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3281 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,1,524288,8833,4096,8201,17665,74628,33554432,5376,29020,16384,1297,13373,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3281 : H12AffineFastState.Bounded env3281 := by
  intro p hp
  have h : env3281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3280_3281 : H12AffineEnvironment.transform 20 4096 env3280 = env3281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3280 == env3281) = true)

theorem identity3281 : scanCanonicalize (H12AffineFastState.compose env3281 (packedSelected [20] rootPS)) = affineNative (2^(12+1) ^^^ 5781) := by decide +kernel

theorem selectedBound3281 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3282 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5781,16384,5140,65536,1344,1,524288,5140,4096,5788,17665,70929,33554432,5376,18377,16384,1297,680,1285,4294967296,256,4329128299,1344,33559581]

theorem envBound3282 : H12AffineFastState.Bounded env3282 := by
  intro p hp
  have h : env3282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3281_3282 : H12AffineEnvironment.transform 12 5781 env3281 = env3282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5781 env3281 == env3282) = true)

theorem identity3282 : scanCanonicalize (H12AffineFastState.compose env3282 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 1377) := by decide +kernel

theorem selectedBound3282 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3283 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5781,1377,5140,65536,1344,1,524288,5140,4096,5788,96,70929,33554432,5376,680,1377,1297,680,1285,4294967296,256,4329112586,1344,33559581]

theorem envBound3283 : H12AffineFastState.Bounded env3283 := by
  intro p hp
  have h : env3283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3282_3283 : H12AffineEnvironment.transform 13 1377 env3282 = env3283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1377 env3282 == env3283) = true)

theorem identity3283 : scanCanonicalize (H12AffineFastState.compose env3283 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(24+1) ^^^ 388) := by decide +kernel

theorem selectedBound3283 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3284 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5781,1377,5140,65536,1344,1,524288,5140,4096,5788,96,70929,388,5376,680,1377,1297,680,1285,4294967296,256,4295558542,1344,5529]

theorem envBound3284 : H12AffineFastState.Bounded env3284 := by
  intro p hp
  have h : env3284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3283_3284 : H12AffineEnvironment.transform 24 388 env3283 = env3284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 388 env3283 == env3284) = true)

theorem identity3284 : scanCanonicalize (H12AffineFastState.compose env3284 (packedSelected [18] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound3284 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3285 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,269,1377,908,65536,1344,1,524288,908,1944,260,96,66185,388,664,680,1377,1297,680,1285,4294967296,256,4295558542,1344,513]

theorem envBound3285 : H12AffineFastState.Bounded env3285 := by
  intro p hp
  have h : env3285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3284_3285 : H12AffineEnvironment.transform 11 1944 env3284 = env3285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env3284 == env3285) = true)

theorem identity3285 : scanCanonicalize (H12AffineFastState.compose env3285 (packedSelected [0,5,7,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound3285 : packedSelected [0,5,7,8,12,15] rootPS < 2^1333 := by decide +kernel

def env3286 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,269,1377,908,547,1344,1,524288,908,1944,260,96,170,388,664,680,1377,1297,680,1285,4294967296,256,4295493549,1344,513]

theorem envBound3286 : H12AffineFastState.Bounded env3286 := by
  intro p hp
  have h : env3286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3285_3286 : H12AffineEnvironment.transform 15 547 env3285 = env3286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env3285 == env3286) = true)

theorem identity3286 : scanCanonicalize (H12AffineFastState.compose env3286 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound3286 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3287 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,269,1377,908,547,1344,1,1024,908,1944,260,96,170,388,664,680,1377,1297,680,1285,4294967296,256,4294968237,1344,513]

theorem envBound3287 : H12AffineFastState.Bounded env3287 := by
  intro p hp
  have h : env3287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3286_3287 : H12AffineEnvironment.transform 18 1024 env3286 = env3287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env3286 == env3287) = true)

theorem identity3287 : scanCanonicalize (H12AffineFastState.compose env3287 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound3287 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3288 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,1329,269,1377,293,138,1344,1,1024,293,1329,260,96,170,388,49,1,1377,1297,1,1285,4294967296,256,4294967556,1344,168]

theorem envBound3288 : H12AffineFastState.Bounded env3288 := by
  intro p hp
  have h : env3288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3287_3288 : H12AffineEnvironment.transform 8 169 env3287 = env3288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env3287 == env3288) = true)

def env3289 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8201,17665,74629,33554432,5376,2122077,16384,1296,2106429,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound3289 : H12AffineFastState.Bounded env3289 := by
  intro p hp
  have h : env3289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3279_3289 : H12AffineEnvironment.transform 16 1345 env3279 = env3289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3279 == env3289) = true)

theorem identity3289 : scanCanonicalize (H12AffineFastState.compose env3289 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3289 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3290 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8201,17665,74629,2647256,5376,2122077,16384,1296,2106429,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound3290 : H12AffineFastState.Bounded env3290 := by
  intro p hp
  have h : env3290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3289_3290 : H12AffineEnvironment.transform 24 2647256 env3289 = env3290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3289 == env3290) = true)

theorem identity3290 : scanCanonicalize (H12AffineFastState.compose env3290 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(15+1) ^^^ 26222) := by decide +kernel

theorem selectedBound3290 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3291 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,26222,1345,1,524288,8833,2097152,8201,17665,17899,2647256,5376,2122077,16384,1296,2106429,1284,4294967296,256,4297094473,1345,2639440]

theorem envBound3291 : H12AffineFastState.Bounded env3291 := by
  intro p hp
  have h : env3291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3290_3291 : H12AffineEnvironment.transform 15 26222 env3290 = env3291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26222 env3290 == env3291) = true)

theorem identity3291 : scanCanonicalize (H12AffineFastState.compose env3291 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3291 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3292 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,26222,1345,1,524288,8833,4096,8201,17665,17899,554200,5376,29021,16384,1296,13373,1284,4294967296,256,4294993225,1345,546384]

theorem envBound3292 : H12AffineFastState.Bounded env3292 := by
  intro p hp
  have h : env3292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3291_3292 : H12AffineEnvironment.transform 20 4096 env3291 = env3292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3291 == env3292) = true)

theorem identity3292 : scanCanonicalize (H12AffineFastState.compose env3292 (packedSelected [20] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound3292 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3293 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,16384,260,17899,1345,1,524288,260,4096,908,17665,17899,546653,5376,21208,16384,1296,6072,1284,4294967296,256,4294985420,1345,546384]

theorem envBound3293 : H12AffineFastState.Bounded env3293 := by
  intro p hp
  have h : env3293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3292_3293 : H12AffineEnvironment.transform 12 901 env3292 = env3293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env3292 == env3293) = true)

theorem identity3293 : scanCanonicalize (H12AffineFastState.compose env3293 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4857) := by decide +kernel

theorem selectedBound3293 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3294 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4857,260,5906,1345,1,524288,260,4096,908,6136,5906,525732,5376,33,4857,1296,6072,1284,4294967296,256,4294972469,1345,525481]

theorem envBound3294 : H12AffineFastState.Bounded env3294 := by
  intro p hp
  have h : env3294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3293_3294 : H12AffineEnvironment.transform 13 4857 env3293 = env3294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4857 env3293 == env3294) = true)

theorem identity3294 : scanCanonicalize (H12AffineFastState.compose env3294 (packedSelected [1,3,5,8,10,16,18,19] rootPS)) = affineNative (2^(18+1) ^^^ 4401) := by decide +kernel

theorem selectedBound3294 : packedSelected [1,3,5,8,10,16,18,19] rootPS < 2^1333 := by decide +kernel

def env3295 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4857,260,5906,1345,1,4401,260,4096,908,6136,5906,5269,5376,33,4857,1296,6072,1284,4294967296,256,4294972469,1345,5528]

theorem envBound3295 : H12AffineFastState.Bounded env3295 := by
  intro p hp
  have h : env3295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3294_3295 : H12AffineEnvironment.transform 18 4401 env3294 = env3295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4401 env3294 == env3295) = true)

theorem identity3295 : scanCanonicalize (H12AffineFastState.compose env3295 (packedSelected [0,4,5,7,8,9,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 1725) := by decide +kernel

theorem selectedBound3295 : packedSelected [0,4,5,7,8,9,12,15] rootPS < 2^1333 := by decide +kernel

def env3296 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1725,901,1092,260,431,1345,1,1932,260,1725,908,325,431,552,957,33,1092,1296,261,1284,4294967296,256,4294967944,1345,805]

theorem envBound3296 : H12AffineFastState.Bounded env3296 := by
  intro p hp
  have h : env3296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3295_3296 : H12AffineEnvironment.transform 11 1725 env3295 = env3296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1725 env3295 == env3296) = true)

theorem identity3296 : scanCanonicalize (H12AffineFastState.compose env3296 (packedSelected [1,3,4,9] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3296 : packedSelected [1,3,4,9] rootPS < 2^1333 := by decide +kernel

def env3297 : List Nat := [2,4,8,16,0,64,128,256,512,1024,0,1693,901,1092,260,399,1345,1,1932,260,1693,908,325,399,520,925,1,1092,1296,261,1284,4294967296,256,4294967944,1345,773]

theorem envBound3297 : H12AffineFastState.Bounded env3297 := by
  intro p hp
  have h : env3297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3296_3297 : H12AffineEnvironment.transform 4 0 env3296 = env3297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3296 == env3297) = true)

theorem identity3297 : scanCanonicalize (H12AffineFastState.compose env3297 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(8+1) ^^^ 397) := by decide +kernel

theorem selectedBound3297 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env3298 : List Nat := [2,4,8,16,0,64,128,256,397,1024,0,1296,8,1092,260,399,1345,1,1025,260,1296,1,325,399,389,16,1,1092,1296,261,1284,4294967296,256,4294967557,1345,136]

theorem envBound3298 : H12AffineFastState.Bounded env3298 := by
  intro p hp
  have h : env3298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3297_3298 : H12AffineEnvironment.transform 8 397 env3297 = env3298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 397 env3297 == env3298) = true)

theorem identity3298 : scanCanonicalize (H12AffineFastState.compose env3298 (packedSelected [0,1,2,3,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 341) := by decide +kernel

theorem selectedBound3298 : packedSelected [0,1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env3299 : List Nat := [2,4,8,16,0,64,128,256,397,1024,0,1296,8,1092,260,399,1345,1,1025,260,1296,1,325,399,389,16,1,1092,1296,261,1284,341,256,80,1345,136]

theorem envBound3299 : H12AffineFastState.Bounded env3299 := by
  intro p hp
  have h : env3299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3298_3299 : H12AffineEnvironment.transform 31 341 env3298 = env3299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 341 env3298 == env3299) = true)

theorem identity3299 : scanCanonicalize (H12AffineFastState.compose env3299 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3299 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env3300 : List Nat := [2,4,8,16,0,64,128,5,136,1024,0,1045,8,1092,1,138,1092,1,1025,1,1045,1,64,138,128,16,1,1092,1045,0,1025,80,5,80,1092,136]

theorem envBound3300 : H12AffineFastState.Bounded env3300 := by
  intro p hp
  have h : env3300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3299_3300 : H12AffineEnvironment.transform 7 5 env3299 = env3300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3299 == env3300) = true)

theorem identity3300 : scanCanonicalize (H12AffineFastState.compose env3300 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 26) := by decide +kernel

theorem selectedBound3300 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3301 : List Nat := [2,4,8,16,0,64,26,5,18,1024,0,1045,8,1092,1,16,1092,1,1025,1,1045,1,64,16,26,16,1,1092,1045,0,1025,80,5,80,1092,18]

theorem envBound3301 : H12AffineFastState.Bounded env3301 := by
  intro p hp
  have h : env3301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3300_3301 : H12AffineEnvironment.transform 6 26 env3300 = env3301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 26 env3300 == env3301) = true)

theorem identity3301 : scanCanonicalize (H12AffineFastState.compose env3301 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 23) := by decide +kernel

theorem selectedBound3301 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3302 : List Nat := [2,4,8,16,0,64,26,5,18,23,0,2,8,83,1,16,83,1,22,1,2,1,64,16,26,16,1,83,2,0,22,80,5,80,83,18]

theorem envBound3302 : H12AffineFastState.Bounded env3302 := by
  intro p hp
  have h : env3302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3301_3302 : H12AffineEnvironment.transform 9 23 env3301 = env3302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 23 env3301 == env3302) = true)

theorem identity3302 : scanCanonicalize (H12AffineFastState.compose env3302 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound3302 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3303 : List Nat := [2,4,8,16,0,16,26,5,18,23,0,2,8,3,1,16,3,1,22,1,2,1,16,16,26,16,1,3,2,0,22,0,5,0,3,18]

theorem envBound3303 : H12AffineFastState.Bounded env3303 := by
  intro p hp
  have h : env3303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3302_3303 : H12AffineEnvironment.transform 5 16 env3302 = env3303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env3302 == env3303) = true)

theorem identity3303 : scanCanonicalize (H12AffineFastState.compose env3303 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound3303 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3304 : List Nat := [2,4,8,3,0,3,9,5,1,4,0,2,8,3,1,3,3,1,5,1,2,1,3,3,9,3,1,3,2,0,5,0,5,0,3,1]

theorem envBound3304 : H12AffineFastState.Bounded env3304 := by
  intro p hp
  have h : env3304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3303_3304 : H12AffineEnvironment.transform 3 3 env3303 = env3304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env3303 == env3304) = true)

theorem identity3304 : scanCanonicalize (H12AffineFastState.compose env3304 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3304 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3305 : List Nat := [2,4,3,3,0,3,2,5,1,4,0,2,3,3,1,3,3,1,5,1,2,1,3,3,2,3,1,3,2,0,5,0,5,0,3,1]

theorem envBound3305 : H12AffineFastState.Bounded env3305 := by
  intro p hp
  have h : env3305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3304_3305 : H12AffineEnvironment.transform 2 3 env3304 = env3305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3304 == env3305) = true)

def leafEnv3305 : List Nat := [2,4,3,3,0,3,2,5,1,4,0,2,3,3,1,3,3,1,5,1,2,1,3,3,4,2,1,3,1,3,2,0,5,0,5,0,4,2,3,1,0,2,1]

def active3305 : List Nat := [0,1]

def tree3305 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3305 : H12WitnessSearch.Good tree3305 := H12GlobalWitnessIndex.good

theorem leafIdentity3305 : H12AffineFastState.composeSystem env3305 rootObs = leafEnv3305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3305 rootObs == leafEnv3305) = true)

theorem terminalChecked3305 : H12PackedTerminal.terminalCheckFast leafEnv3305 active3305 tree3305 = true := by decide +kernel

def env3306 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8200,17665,206532,33554432,5376,2515996,16384,131153,1073741824,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3306 : H12AffineFastState.Bounded env3306 := by
  intro p hp
  have h : env3306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3244_3306 : H12AffineEnvironment.transform 10 1 env3244 = env3306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env3244 == env3306) = true)

theorem identity3306 : scanCanonicalize (H12AffineFastState.compose env3306 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 33834573) := by decide +kernel

theorem selectedBound3306 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3307 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8200,17665,206532,33554432,5376,2515996,16384,131153,33834573,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3307 : H12AffineFastState.Bounded env3307 := by
  intro p hp
  have h : env3307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3306_3307 : H12AffineEnvironment.transform 29 33834573 env3306 = env3307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 33834573 env3306 == env3307) = true)

def env3308 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,0,524288,8833,2097152,8200,17665,206532,33554432,5376,2253852,16384,131153,33572429,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3308 : H12AffineFastState.Bounded env3308 := by
  intro p hp
  have h : env3308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3307_3308 : H12AffineEnvironment.transform 17 0 env3307 = env3308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env3307 == env3308) = true)

def env3309 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,0,524288,8833,2097152,8200,17665,74628,33554432,5376,2122076,16384,1297,33572429,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3309 : H12AffineFastState.Bounded env3309 := by
  intro p hp
  have h : env3309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3308_3309 : H12AffineEnvironment.transform 16 1344 env3308 = env3309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3308 == env3309) = true)

theorem identity3309 : scanCanonicalize (H12AffineFastState.compose env3309 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3309 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3310 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,0,524288,8833,4096,8200,17665,74628,33554432,5376,29020,16384,1297,33572429,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3310 : H12AffineFastState.Bounded env3310 := by
  intro p hp
  have h : env3310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3309_3310 : H12AffineEnvironment.transform 20 4096 env3309 = env3310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3309 == env3310) = true)

theorem identity3310 : scanCanonicalize (H12AffineFastState.compose env3310 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 21372) := by decide +kernel

theorem selectedBound3310 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3311 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,0,524288,8833,4096,8200,17665,74628,21372,5376,29020,16384,1297,5425,1285,4294967296,256,4295566467,1344,29172]

theorem envBound3311 : H12AffineFastState.Bounded env3311 := by
  intro p hp
  have h : env3311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3310_3311 : H12AffineEnvironment.transform 24 21372 env3310 = env3311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 21372 env3310 == env3311) = true)

theorem identity3311 : scanCanonicalize (H12AffineFastState.compose env3311 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 9325) := by decide +kernel

theorem selectedBound3311 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3312 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,9325,8833,65536,1344,0,524288,8833,4096,8200,8556,74628,14097,5376,5425,9325,1297,5425,1285,4294967296,256,4295566467,1344,5529]

theorem envBound3312 : H12AffineFastState.Bounded env3312 := by
  intro p hp
  have h : env3312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3311_3312 : H12AffineEnvironment.transform 13 9325 env3311 = env3312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9325 env3311 == env3312) = true)

theorem identity3312 : scanCanonicalize (H12AffineFastState.compose env3312 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound3312 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3313 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,268,1377,909,65536,1344,0,524288,909,4096,260,96,66184,5661,5376,5425,1377,1297,5425,1285,4294967296,256,4295558543,1344,5529]

theorem envBound3313 : H12AffineFastState.Bounded env3313 := by
  intro p hp
  have h : env3313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3312_3313 : H12AffineEnvironment.transform 12 268 env3312 = env3313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env3312 == env3313) = true)

theorem identity3313 : scanCanonicalize (H12AffineFastState.compose env3313 (packedSelected [18] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound3313 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3314 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1377,909,65536,1344,0,524288,909,1944,260,96,66184,389,664,681,1377,1297,681,1285,4294967296,256,4295558543,1344,513]

theorem envBound3314 : H12AffineFastState.Bounded env3314 := by
  intro p hp
  have h : env3314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3313_3314 : H12AffineEnvironment.transform 11 1944 env3313 = env3314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env3313 == env3314) = true)

theorem identity3314 : scanCanonicalize (H12AffineFastState.compose env3314 (packedSelected [0,5,7,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound3314 : packedSelected [0,5,7,8,12,15] rootPS < 2^1333 := by decide +kernel

def env3315 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1377,909,546,1344,0,524288,909,1944,260,96,170,389,664,681,1377,1297,681,1285,4294967296,256,4295493549,1344,513]

theorem envBound3315 : H12AffineFastState.Bounded env3315 := by
  intro p hp
  have h : env3315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3314_3315 : H12AffineEnvironment.transform 15 546 env3314 = env3315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env3314 == env3315) = true)

theorem identity3315 : scanCanonicalize (H12AffineFastState.compose env3315 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound3315 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3316 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1377,909,546,1344,0,1024,909,1944,260,96,170,389,664,681,1377,1297,681,1285,4294967296,256,4294968237,1344,513]

theorem envBound3316 : H12AffineFastState.Bounded env3316 := by
  intro p hp
  have h : env3316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3315_3316 : H12AffineEnvironment.transform 18 1024 env3315 = env3316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env3315 == env3316) = true)

theorem identity3316 : scanCanonicalize (H12AffineFastState.compose env3316 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound3316 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3317 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,1329,268,1377,292,139,1344,0,1024,292,1329,260,96,170,389,49,0,1377,1297,0,1285,4294967296,256,4294967556,1344,168]

theorem envBound3317 : H12AffineFastState.Bounded env3317 := by
  intro p hp
  have h : env3317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3316_3317 : H12AffineEnvironment.transform 8 169 env3316 = env3317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env3316 == env3317) = true)

def env3318 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8200,17665,74629,33554432,5376,2122077,16384,1296,33572429,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound3318 : H12AffineFastState.Bounded env3318 := by
  intro p hp
  have h : env3318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3308_3318 : H12AffineEnvironment.transform 16 1345 env3308 = env3318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3308 == env3318) = true)

theorem identity3318 : scanCanonicalize (H12AffineFastState.compose env3318 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3318 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3319 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8200,17665,74629,2647256,5376,2122077,16384,1296,2630293,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound3319 : H12AffineFastState.Bounded env3319 := by
  intro p hp
  have h : env3319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3318_3319 : H12AffineEnvironment.transform 24 2647256 env3318 = env3319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3318 == env3319) = true)

theorem identity3319 : scanCanonicalize (H12AffineFastState.compose env3319 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(18+1) ^^^ 90310) := by decide +kernel

theorem selectedBound3319 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3320 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,90310,8833,2097152,8200,17665,74629,2163742,5376,2122077,16384,1296,2179667,1284,4294967296,256,4297134886,1345,2172566]

theorem envBound3320 : H12AffineFastState.Bounded env3320 := by
  intro p hp
  have h : env3320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3319_3320 : H12AffineEnvironment.transform 18 90310 env3319 = env3320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 90310 env3319 == env3320) = true)

theorem identity3320 : scanCanonicalize (H12AffineFastState.compose env3320 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3320 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3321 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,90310,8833,4096,8200,17665,74629,70686,5376,29021,16384,1296,86611,1284,4294967296,256,4295033638,1345,79510]

theorem envBound3321 : H12AffineFastState.Bounded env3321 := by
  intro p hp
  have h : env3321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3320_3321 : H12AffineEnvironment.transform 20 4096 env3320 = env3321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3320 == env3321) = true)

theorem identity3321 : scanCanonicalize (H12AffineFastState.compose env3321 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 21107) := by decide +kernel

theorem selectedBound3321 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3322 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,21107,1345,0,12981,8833,4096,8200,17665,29174,18029,5376,29021,16384,1296,32,1284,4294967296,256,4294988117,1345,25829]

theorem envBound3322 : H12AffineFastState.Bounded env3322 := by
  intro p hp
  have h : env3322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3321_3322 : H12AffineEnvironment.transform 15 21107 env3321 = env3322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 21107 env3321 == env3322) = true)

theorem identity3322 : scanCanonicalize (H12AffineFastState.compose env3322 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4857) := by decide +kernel

theorem selectedBound3322 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3323 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4857,8833,138,1345,0,12981,8833,4096,8200,6136,8975,5268,5376,9124,4857,1296,32,1284,4294967296,256,4294968236,1345,13852]

theorem envBound3323 : H12AffineFastState.Bounded env3323 := by
  intro p hp
  have h : env3323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3322_3323 : H12AffineEnvironment.transform 13 4857 env3322 = env3323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4857 env3322 == env3323) = true)

theorem identity3323 : scanCanonicalize (H12AffineFastState.compose env3323 (packedSelected [1,3,5,8,10,16,18,19] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound3323 : packedSelected [1,3,5,8,10,16,18,19] rootPS < 2^1333 := by decide +kernel

def env3324 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,8192,1376,8833,138,1345,0,9516,8833,1945,8200,97,8975,781,665,9124,1376,1296,32,1284,4294967296,256,4294968236,1345,8581]

theorem envBound3324 : H12AffineFastState.Bounded env3324 := by
  intro p hp
  have h : env3324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3323_3324 : H12AffineEnvironment.transform 11 1945 env3323 = env3324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env3323 == env3324) = true)

theorem identity3324 : scanCanonicalize (H12AffineFastState.compose env3324 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound3324 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env3325 : List Nat := [2,4,8,16,32,64,128,256,428,1024,1,1077,8192,1376,8493,138,1345,0,9516,8493,1077,8200,97,8355,161,309,8200,1376,1296,32,1284,4294967296,256,4294967296,1345,8581]

theorem envBound3325 : H12AffineFastState.Bounded env3325 := by
  intro p hp
  have h : env3325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3324_3325 : H12AffineEnvironment.transform 8 428 env3324 = env3325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env3324 == env3325) = true)

theorem identity3325 : scanCanonicalize (H12AffineFastState.compose env3325 (packedSelected [0,1,7,8,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound3325 : packedSelected [0,1,7,8,10,15] rootPS < 2^1333 := by decide +kernel

def env3326 : List Nat := [2,4,8,16,32,64,128,256,428,1024,1,1077,41,1376,260,138,1345,0,1285,260,1077,33,97,138,161,309,33,1376,1296,32,1284,4294967296,256,4294967296,1345,428]

theorem envBound3326 : H12AffineFastState.Bounded env3326 := by
  intro p hp
  have h : env3326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3325_3326 : H12AffineEnvironment.transform 12 41 env3325 = env3326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env3325 == env3326) = true)

theorem identity3326 : scanCanonicalize (H12AffineFastState.compose env3326 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound3326 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3327 : List Nat := [2,4,8,16,32,64,128,15,163,1024,1,1077,41,1135,11,138,1102,0,1034,11,1077,33,97,138,161,58,33,1135,1055,32,1035,4294967296,15,4294967296,1102,163]

theorem envBound3327 : H12AffineFastState.Bounded env3327 := by
  intro p hp
  have h : env3327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3326_3327 : H12AffineEnvironment.transform 7 15 env3326 = env3327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env3326 == env3327) = true)

theorem identity3327 : scanCanonicalize (H12AffineFastState.compose env3327 (packedSelected [1,2,4] rootPS)) = affineNative (2^(9+1) ^^^ 108) := by decide +kernel

theorem selectedBound3327 : packedSelected [1,2,4] rootPS < 2^1333 := by decide +kernel

def env3328 : List Nat := [2,4,8,16,32,64,128,15,163,108,1,89,41,3,11,138,34,0,102,11,89,33,97,138,161,58,33,3,115,32,103,4294967296,15,4294967296,34,163]

theorem envBound3328 : H12AffineFastState.Bounded env3328 := by
  intro p hp
  have h : env3328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3327_3328 : H12AffineEnvironment.transform 9 108 env3327 = env3328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 108 env3327 == env3328) = true)

theorem identity3328 : scanCanonicalize (H12AffineFastState.compose env3328 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound3328 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3329 : List Nat := [2,4,8,16,32,64,9,15,42,108,1,89,41,3,11,3,34,0,102,11,89,33,97,3,40,58,33,3,115,32,103,4294967296,15,4294967296,34,42]

theorem envBound3329 : H12AffineFastState.Bounded env3329 := by
  intro p hp
  have h : env3329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3328_3329 : H12AffineEnvironment.transform 6 9 env3328 = env3329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env3328 == env3329) = true)

theorem identity3329 : scanCanonicalize (H12AffineFastState.compose env3329 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound3329 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3330 : List Nat := [2,4,8,16,19,64,9,15,25,95,1,89,26,3,11,3,17,0,85,11,89,18,82,3,27,9,18,3,64,19,84,4294967296,15,4294967296,17,25]

theorem envBound3330 : H12AffineFastState.Bounded env3330 := by
  intro p hp
  have h : env3330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3329_3330 : H12AffineEnvironment.transform 4 19 env3329 = env3330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env3329 == env3330) = true)

theorem identity3330 : scanCanonicalize (H12AffineFastState.compose env3330 (packedSelected [2,9] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3330 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env3331 : List Nat := [2,4,8,2,1,64,9,15,11,77,1,75,8,3,11,3,3,0,71,11,75,0,64,3,9,9,0,3,64,1,70,4294967296,15,4294967296,3,11]

theorem envBound3331 : H12AffineFastState.Bounded env3331 := by
  intro p hp
  have h : env3331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3330_3331 : H12AffineEnvironment.transform 3 2 env3330 = env3331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3330 == env3331) = true)

theorem identity3331 : scanCanonicalize (H12AffineFastState.compose env3331 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3331 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3332 : List Nat := [2,4,3,2,1,64,2,4,0,70,1,64,3,3,0,3,3,0,71,0,64,0,64,3,2,2,0,3,64,1,70,4294967296,4,4294967296,3,0]

theorem envBound3332 : H12AffineFastState.Bounded env3332 := by
  intro p hp
  have h : env3332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3331_3332 : H12AffineEnvironment.transform 2 3 env3331 = env3332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3331 == env3332) = true)

theorem identity3332 : scanCanonicalize (H12AffineFastState.compose env3332 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 66) := by decide +kernel

theorem selectedBound3332 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3333 : List Nat := [2,4,3,2,1,64,2,4,0,70,1,64,3,3,0,3,3,0,71,0,64,0,64,3,2,2,0,3,64,1,70,66,4,66,3,0]

theorem envBound3333 : H12AffineFastState.Bounded env3333 := by
  intro p hp
  have h : env3333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3332_3333 : H12AffineEnvironment.transform 31 66 env3332 = env3333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 66 env3332 == env3333) = true)

theorem identity3333 : scanCanonicalize (H12AffineFastState.compose env3333 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 2) := by decide +kernel

theorem selectedBound3333 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3334 : List Nat := [2,4,3,2,1,2,2,4,0,4,1,2,3,3,0,3,3,0,5,0,2,0,2,3,2,2,0,3,2,1,4,0,4,0,3,0]

theorem envBound3334 : H12AffineFastState.Bounded env3334 := by
  intro p hp
  have h : env3334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3333_3334 : H12AffineEnvironment.transform 5 2 env3333 = env3334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 2 env3333 == env3334) = true)

def env3335 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,1,524288,8833,2097152,8200,17665,206532,33554432,5376,2253853,16384,131153,33572428,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3335 : H12AffineFastState.Bounded env3335 := by
  intro p hp
  have h : env3335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3307_3335 : H12AffineEnvironment.transform 17 1 env3307 = env3335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env3307 == env3335) = true)

def env3336 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,1,524288,8833,2097152,8200,17665,74628,33554432,5376,2122077,16384,1297,33572428,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3336 : H12AffineFastState.Bounded env3336 := by
  intro p hp
  have h : env3336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3335_3336 : H12AffineEnvironment.transform 16 1344 env3335 = env3336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3335 == env3336) = true)

theorem identity3336 : scanCanonicalize (H12AffineFastState.compose env3336 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3336 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3337 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,1,524288,8833,4096,8200,17665,74628,33554432,5376,29021,16384,1297,33572428,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3337 : H12AffineFastState.Bounded env3337 := by
  intro p hp
  have h : env3337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3336_3337 : H12AffineEnvironment.transform 20 4096 env3336 = env3337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3336 == env3337) = true)

theorem identity3337 : scanCanonicalize (H12AffineFastState.compose env3337 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 8737) := by decide +kernel

theorem selectedBound3337 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3338 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,1,524288,8833,4096,8200,17665,74628,8737,5376,29021,16384,1297,25709,1285,4294967296,256,4295579102,1344,169]

theorem envBound3338 : H12AffineFastState.Bounded env3338 := by
  intro p hp
  have h : env3338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3337_3338 : H12AffineEnvironment.transform 24 8737 env3337 = env3338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8737 env3337 == env3338) = true)

theorem identity3338 : scanCanonicalize (H12AffineFastState.compose env3338 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(11+1) ^^^ 1329) := by decide +kernel

theorem selectedBound3338 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3339 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1329,8192,16384,8833,65536,1344,1,524288,8833,1329,8200,17665,74628,8737,49,25708,16384,1297,25709,1285,4294967296,256,4295573743,1344,169]

theorem envBound3339 : H12AffineFastState.Bounded env3339 := by
  intro p hp
  have h : env3339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3338_3339 : H12AffineEnvironment.transform 11 1329 env3338 = env3339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1329 env3338 == env3339) = true)

theorem identity3339 : scanCanonicalize (H12AffineFastState.compose env3339 (packedSelected [1,17,21,24] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3339 : packedSelected [1,17,21,24] rootPS < 2^1333 := by decide +kernel

def env3340 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1329,8192,16384,8200,65536,1344,1,524288,8200,1329,8200,17665,73997,8360,49,25708,16384,1297,25709,1285,4294967296,256,4295573743,1344,169]

theorem envBound3340 : H12AffineFastState.Bounded env3340 := by
  intro p hp
  have h : env3340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3339_3340 : H12AffineEnvironment.transform 8 137 env3339 = env3340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3339 == env3340) = true)

theorem identity3340 : scanCanonicalize (H12AffineFastState.compose env3340 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3340 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3341 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1296,8192,16384,8200,65536,1344,1,524288,8200,1296,8200,17665,73997,8329,16,25677,16384,1297,25676,1285,4294967296,256,4295573710,1344,136]

theorem envBound3341 : H12AffineFastState.Bounded env3341 := by
  intro p hp
  have h : env3341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3340_3341 : H12AffineEnvironment.transform 4 1 env3340 = env3341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3340 == env3341) = true)

theorem identity3341 : scanCanonicalize (H12AffineFastState.compose env3341 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(13+1) ^^^ 1344) := by decide +kernel

theorem selectedBound3341 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3342 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1296,8192,1344,8200,65536,1344,1,524288,8200,1296,8200,65,73997,8329,16,8461,1344,1297,8460,1285,4294967296,256,4295558542,1344,136]

theorem envBound3342 : H12AffineFastState.Bounded env3342 := by
  intro p hp
  have h : env3342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3341_3342 : H12AffineEnvironment.transform 13 1344 env3341 = env3342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1344 env3341 == env3342) = true)

theorem identity3342 : scanCanonicalize (H12AffineFastState.compose env3342 (packedSelected [1,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 220) := by decide +kernel

theorem selectedBound3342 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3343 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1228,8192,1180,8200,65536,1180,1,524288,8200,1228,8200,65,73937,8329,16,8401,1180,1229,8400,1241,4294967296,220,4295558226,1180,136]

theorem envBound3343 : H12AffineFastState.Bounded env3343 := by
  intro p hp
  have h : env3343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3342_3343 : H12AffineEnvironment.transform 7 220 env3342 = env3343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 220 env3342 == env3343) = true)

theorem identity3343 : scanCanonicalize (H12AffineFastState.compose env3343 (packedSelected [0,7] rootPS)) = affineNative (2^(18+1) ^^^ 74843) := by decide +kernel

theorem selectedBound3343 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3344 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1228,8192,1180,8200,65536,1180,1,74843,8200,1228,8200,65,73937,8329,16,8401,1180,1229,8400,1241,4294967296,220,4294975497,1180,136]

theorem envBound3344 : H12AffineFastState.Bounded env3344 := by
  intro p hp
  have h : env3344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3343_3344 : H12AffineEnvironment.transform 18 74843 env3343 = env3344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 74843 env3343 == env3344) = true)

theorem identity3344 : scanCanonicalize (H12AffineFastState.compose env3344 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 8282) := by decide +kernel

theorem selectedBound3344 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env3345 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1228,8192,1180,8200,8282,1180,1,1025,8200,1228,8200,65,139,8329,16,8401,1180,1229,8400,1241,4294967296,220,4294975497,1180,136]

theorem envBound3345 : H12AffineFastState.Bounded env3345 := by
  intro p hp
  have h : env3345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3344_3345 : H12AffineEnvironment.transform 15 8282 env3344 = env3345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8282 env3344 == env3345) = true)

theorem identity3345 : scanCanonicalize (H12AffineFastState.compose env3345 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound3345 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3346 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1228,8,1180,0,82,1180,1,1025,0,1228,0,65,139,129,16,217,1180,1229,216,1241,4294967296,220,4294967297,1180,136]

theorem envBound3346 : H12AffineFastState.Bounded env3346 := by
  intro p hp
  have h : env3346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3345_3346 : H12AffineEnvironment.transform 12 8 env3345 = env3346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env3345 == env3346) = true)

theorem identity3346 : scanCanonicalize (H12AffineFastState.compose env3346 (packedSelected [0,1] rootPS)) = affineNative (2^(6+1) ^^^ 73) := by decide +kernel

theorem selectedBound3346 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env3347 : List Nat := [2,4,8,16,1,64,73,21,64,1024,1,1029,8,1109,0,82,1109,1,1025,0,1029,0,65,66,72,16,16,1109,1028,17,1040,4294967296,21,4294967297,1109,65]

theorem envBound3347 : H12AffineFastState.Bounded env3347 := by
  intro p hp
  have h : env3347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3346_3347 : H12AffineEnvironment.transform 6 73 env3346 = env3347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 73 env3346 == env3347) = true)

theorem identity3347 : scanCanonicalize (H12AffineFastState.compose env3347 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3347 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3348 : List Nat := [2,4,8,0,1,64,73,5,64,1024,1,1029,8,1093,0,66,1093,1,1025,0,1029,0,65,66,72,0,0,1093,1028,1,1024,4294967296,5,4294967297,1093,65]

theorem envBound3348 : H12AffineFastState.Bounded env3348 := by
  intro p hp
  have h : env3348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3347_3348 : H12AffineEnvironment.transform 3 0 env3347 = env3348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3347 == env3348) = true)

theorem identity3348 : scanCanonicalize (H12AffineFastState.compose env3348 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 74) := by decide +kernel

theorem selectedBound3348 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3349 : List Nat := [2,4,8,0,1,64,73,5,64,1024,1,1029,8,1093,0,66,1093,1,1025,0,1029,0,65,66,72,0,0,1093,1028,1,1024,74,5,75,1093,65]

theorem envBound3349 : H12AffineFastState.Bounded env3349 := by
  intro p hp
  have h : env3349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3348_3349 : H12AffineEnvironment.transform 31 74 env3348 = env3349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 74 env3348 == env3349) = true)

def leafEnv3349 : List Nat := [2,4,8,0,1,64,73,5,64,1024,1,1029,8,1093,0,66,1093,1,1025,0,1029,0,65,66,1025,72,1,0,0,1093,1028,1,1024,74,5,75,4,3,1093,65,0,1028,1]

def active3349 : List Nat := [0,1,2,5,9]

def tree3349 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3349 : H12WitnessSearch.Good tree3349 := H12GlobalWitnessIndex.good

theorem leafIdentity3349 : H12AffineFastState.composeSystem env3349 rootObs = leafEnv3349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3349 rootObs == leafEnv3349) = true)

theorem terminalChecked3349 : H12PackedTerminal.terminalCheckFast leafEnv3349 active3349 tree3349 = true := by decide +kernel

def env3350 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8200,17665,74629,33554432,5376,2122076,16384,1296,33572428,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound3350 : H12AffineFastState.Bounded env3350 := by
  intro p hp
  have h : env3350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3335_3350 : H12AffineEnvironment.transform 16 1345 env3335 = env3350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3335 == env3350) = true)

theorem identity3350 : scanCanonicalize (H12AffineFastState.compose env3350 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3350 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3351 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8200,17665,74629,2647256,5376,2122076,16384,1296,2630292,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound3351 : H12AffineFastState.Bounded env3351 := by
  intro p hp
  have h : env3351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3350_3351 : H12AffineEnvironment.transform 24 2647256 env3350 = env3351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3350 == env3351) = true)

theorem identity3351 : scanCanonicalize (H12AffineFastState.compose env3351 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(18+1) ^^^ 90311) := by decide +kernel

theorem selectedBound3351 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3352 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,90311,8833,2097152,8200,17665,74629,2163743,5376,2122076,16384,1296,2179667,1284,4294967296,256,4297134886,1345,2172567]

theorem envBound3352 : H12AffineFastState.Bounded env3352 := by
  intro p hp
  have h : env3352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3351_3352 : H12AffineEnvironment.transform 18 90311 env3351 = env3352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 90311 env3351 == env3352) = true)

theorem identity3352 : scanCanonicalize (H12AffineFastState.compose env3352 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3352 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3353 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,90311,8833,4096,8200,17665,74629,70687,5376,29020,16384,1296,86611,1284,4294967296,256,4295033638,1345,79511]

theorem envBound3353 : H12AffineFastState.Bounded env3353 := by
  intro p hp
  have h : env3353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3352_3353 : H12AffineEnvironment.transform 20 4096 env3352 = env3353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3352 == env3353) = true)

theorem identity3353 : scanCanonicalize (H12AffineFastState.compose env3353 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 9006) := by decide +kernel

theorem selectedBound3353 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3354 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,9006,1345,1,17385,8833,4096,8200,17665,171,14129,5376,29020,16384,1296,29053,1284,4294967296,256,4294975496,1345,5561]

theorem envBound3354 : H12AffineFastState.Bounded env3354 := by
  intro p hp
  have h : env3354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3353_3354 : H12AffineEnvironment.transform 15 9006 env3353 = env3354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9006 env3353 == env3354) = true)

theorem identity3354 : scanCanonicalize (H12AffineFastState.compose env3354 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4856) := by decide +kernel

theorem selectedBound3354 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3355 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4856,8833,9006,1345,1,4369,8833,4096,8200,6137,171,14129,5376,9124,4856,1296,9093,1284,4294967296,256,4294975496,1345,5561]

theorem envBound3355 : H12AffineFastState.Bounded env3355 := by
  intro p hp
  have h : env3355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3354_3355 : H12AffineEnvironment.transform 13 4856 env3354 = env3355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4856 env3354 == env3355) = true)

theorem identity3355 : scanCanonicalize (H12AffineFastState.compose env3355 (packedSelected [3,5,8,10,12,13,16,17,18] rootPS)) = affineNative (2^(8+1) ^^^ 11) := by decide +kernel

theorem selectedBound3355 : packedSelected [3,5,8,10,12,13,16,17,18] rootPS < 2^1333 := by decide +kernel

def env3356 : List Nat := [2,4,8,16,32,64,128,256,11,1024,1,4096,8192,4339,8330,8485,1345,1,4369,8330,4096,8200,5618,171,13626,5376,8623,4339,1296,8590,1284,4294967296,256,4294975496,1345,5561]

theorem envBound3356 : H12AffineFastState.Bounded env3356 := by
  intro p hp
  have h : env3356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3355_3356 : H12AffineEnvironment.transform 8 11 env3355 = env3356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 11 env3355 == env3356) = true)

theorem identity3356 : scanCanonicalize (H12AffineFastState.compose env3356 (packedSelected [1,12,13,17,19] rootPS)) = affineNative (2^(11+1) ^^^ 1427) := by decide +kernel

theorem selectedBound3356 : packedSelected [1,12,13,17,19] rootPS < 2^1333 := by decide +kernel

def env3357 : List Nat := [2,4,8,16,32,64,128,256,11,1024,1,1427,8192,1376,8330,8485,1345,1,1154,8330,1427,8200,97,171,8361,147,8623,1376,1296,8590,1284,4294967296,256,4294975496,1345,42]

theorem envBound3357 : H12AffineFastState.Bounded env3357 := by
  intro p hp
  have h : env3357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3356_3357 : H12AffineEnvironment.transform 11 1427 env3356 = env3357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1427 env3356 == env3357) = true)

theorem identity3357 : scanCanonicalize (H12AffineFastState.compose env3357 (packedSelected [5,8] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound3357 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3358 : List Nat := [2,4,8,16,32,64,128,134,11,1024,1,1045,8192,1254,8330,8355,1223,1,1154,8330,1045,8200,97,171,8361,147,8233,1254,1174,8200,1154,4294967296,134,4294975496,1223,42]

theorem envBound3358 : H12AffineFastState.Bounded env3358 := by
  intro p hp
  have h : env3358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3357_3358 : H12AffineEnvironment.transform 7 134 env3357 = env3358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env3357 == env3358) = true)

theorem identity3358 : scanCanonicalize (H12AffineFastState.compose env3358 (packedSelected [0,1,2,4,5,6,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound3358 : packedSelected [0,1,2,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env3359 : List Nat := [2,4,8,16,32,64,128,134,11,1024,1,1045,41,1254,163,138,1223,1,1154,163,1045,33,97,171,128,147,0,1254,1174,33,1154,4294967296,134,4294967329,1223,42]

theorem envBound3359 : H12AffineFastState.Bounded env3359 := by
  intro p hp
  have h : env3359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3358_3359 : H12AffineEnvironment.transform 12 41 env3358 = env3359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env3358 == env3359) = true)

theorem identity3359 : scanCanonicalize (H12AffineFastState.compose env3359 (packedSelected [0,1,2,3,4,6] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3359 : packedSelected [0,1,2,3,4,6] rootPS < 2^1333 := by decide +kernel

def env3360 : List Nat := [2,4,8,16,0,64,128,134,11,1024,1,1045,9,1222,131,138,1223,1,1154,131,1045,1,65,139,128,147,0,1222,1174,1,1154,4294967296,134,4294967297,1223,10]

theorem envBound3360 : H12AffineFastState.Bounded env3360 := by
  intro p hp
  have h : env3360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3359_3360 : H12AffineEnvironment.transform 4 0 env3359 = env3360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3359 == env3360) = true)

theorem identity3360 : scanCanonicalize (H12AffineFastState.compose env3360 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound3360 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3361 : List Nat := [2,4,8,16,0,64,18,20,11,1024,1,1045,9,1108,17,24,1109,1,1040,17,1045,1,65,25,18,1,0,1108,1028,1,1040,4294967296,20,4294967297,1109,10]

theorem envBound3361 : H12AffineFastState.Bounded env3361 := by
  intro p hp
  have h : env3361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3360_3361 : H12AffineEnvironment.transform 6 18 env3360 = env3361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env3360 == env3361) = true)

def env3362 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,5377,6702101,16385,16876565,1073741824,131140,4294967296,17007940,4350047346,131072,33563272]

theorem envBound3362 : H12AffineFastState.Bounded env3362 := by
  intro p hp
  have h : env3362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2858_3362 : H12AffineEnvironment.transform 25 5377 env2858 = env3362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2858 == env3362) = true)

theorem identity3362 : scanCanonicalize (H12AffineFastState.compose env3362 (packedSelected [35] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3362 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env3363 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,16777216,33554432,5377,4609045,16385,16876565,1073741824,131140,4294967296,17007940,4350047346,131072,33563272]

theorem envBound3363 : H12AffineFastState.Bounded env3363 := by
  intro p hp
  have h : env3363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3362_3363 : H12AffineEnvironment.transform 20 4096 env3362 = env3363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3362 == env3363) = true)

theorem identity3363 : scanCanonicalize (H12AffineFastState.compose env3363 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound3363 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env3364 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,16777216,8329,5377,4609045,16385,16876565,1073741824,131140,4294967296,17007940,4316484859,131072,513]

theorem envBound3364 : H12AffineFastState.Bounded env3364 := by
  intro p hp
  have h : env3364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3363_3364 : H12AffineEnvironment.transform 24 8329 env3363 = env3364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env3363 == env3364) = true)

theorem identity3364 : scanCanonicalize (H12AffineFastState.compose env3364 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21584) := by decide +kernel

theorem selectedBound3364 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env3365 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21584,32768,4096,4194304,17665,16777216,8329,5377,4609045,16385,16876565,1073741824,131140,4294967296,17007940,4315938987,131072,513]

theorem envBound3365 : H12AffineFastState.Bounded env3365 := by
  intro p hp
  have h : env3365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3364_3365 : H12AffineEnvironment.transform 18 21584 env3364 = env3365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21584 env3364 == env3365) = true)

theorem identity3365 : scanCanonicalize (H12AffineFastState.compose env3365 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 21126303) := by decide +kernel

theorem selectedBound3365 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3366 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21584,32768,4096,4194304,17665,16777216,8329,5377,4609045,16385,16876565,21126303,131140,4294967296,17007940,4315938987,131072,513]

theorem envBound3366 : H12AffineFastState.Bounded env3366 := by
  intro p hp
  have h : env3366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3365_3366 : H12AffineEnvironment.transform 29 21126303 env3365 = env3366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21126303 env3365 == env3366) = true)

theorem identity3366 : scanCanonicalize (H12AffineFastState.compose env3366 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(23+1) ^^^ 250900) := by decide +kernel

theorem selectedBound3366 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env3367 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21584,32768,4096,4194304,17665,250900,8329,5377,4609045,16385,151553,4294795,131140,4294967296,20816,4299412671,131072,513]

theorem envBound3367 : H12AffineFastState.Bounded env3367 := by
  intro p hp
  have h : env3367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3366_3367 : H12AffineEnvironment.transform 23 250900 env3366 = env3367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 250900 env3366 == env3367) = true)

theorem identity3367 : scanCanonicalize (H12AffineFastState.compose env3367 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 4341896) := by decide +kernel

theorem selectedBound3367 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env3368 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21584,32768,4096,4194304,17665,250900,8329,5377,4609045,16385,151553,4294795,131140,4341896,20816,103479,131072,513]

theorem envBound3368 : H12AffineFastState.Bounded env3368 := by
  intro p hp
  have h : env3368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3367_3368 : H12AffineEnvironment.transform 31 4341896 env3367 = env3368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4341896 env3367 == env3368) = true)

def env3369 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,157794305,1073741824,140788816,4294967296,157663568,4417151347,131073,33563272]

theorem envBound3369 : H12AffineFastState.Bounded env3369 := by
  intro p hp
  have h : env3369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2856_3369 : H12AffineEnvironment.transform 28 157794305 env2856 = env3369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env2856 == env3369) = true)

theorem identity3369 : scanCanonicalize (H12AffineFastState.compose env3369 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 71713045) := by decide +kernel

theorem selectedBound3369 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env3370 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,71713045,67130624,86081812,1073741824,69338437,4294967296,86212677,4417151347,131073,33563272]

theorem envBound3370 : H12AffineFastState.Bounded env3370 := by
  intro p hp
  have h : env3370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3369_3370 : H12AffineEnvironment.transform 26 71713045 env3369 = env3370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 71713045 env3369 == env3370) = true)

def env3371 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,2098432,6702101,2117632,16876564,1073741824,131141,4294967296,17007941,4352140403,131073,33563272]

theorem envBound3371 : H12AffineFastState.Bounded env3371 := by
  intro p hp
  have h : env3371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3370_3371 : H12AffineEnvironment.transform 25 2098432 env3370 = env3371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 2098432 env3370 == env3371) = true)

theorem identity3371 : scanCanonicalize (H12AffineFastState.compose env3371 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound3371 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env3372 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,8329,2098432,6702101,2117632,16876564,1073741824,131141,4294967296,17007941,4318577914,131073,513]

theorem envBound3372 : H12AffineFastState.Bounded env3372 := by
  intro p hp
  have h : env3372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3371_3372 : H12AffineEnvironment.transform 24 8329 env3371 = env3372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env3371 == env3372) = true)

theorem identity3372 : scanCanonicalize (H12AffineFastState.compose env3372 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3372 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env3373 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,16777216,8329,5376,4609045,16384,16876564,1073741824,131141,4294967296,17007941,4316484858,131073,513]

theorem envBound3373 : H12AffineFastState.Bounded env3373 := by
  intro p hp
  have h : env3373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3372_3373 : H12AffineEnvironment.transform 20 4096 env3372 = env3373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3372 == env3373) = true)

theorem identity3373 : scanCanonicalize (H12AffineFastState.compose env3373 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound3373 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env3374 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,4194304,17665,16777216,8329,5376,4609045,16384,16876564,1073741824,131141,4294967296,17007941,4315938987,131073,513]

theorem envBound3374 : H12AffineFastState.Bounded env3374 := by
  intro p hp
  have h : env3374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3373_3374 : H12AffineEnvironment.transform 18 21585 env3373 = env3374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env3373 == env3374) = true)

theorem identity3374 : scanCanonicalize (H12AffineFastState.compose env3374 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 21126303) := by decide +kernel

theorem selectedBound3374 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3375 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,4194304,17665,16777216,8329,5376,4609045,16384,16876564,21126303,131141,4294967296,17007941,4315938987,131073,513]

theorem envBound3375 : H12AffineFastState.Bounded env3375 := by
  intro p hp
  have h : env3375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3374_3375 : H12AffineEnvironment.transform 29 21126303 env3374 = env3375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21126303 env3374 == env3375) = true)

theorem identity3375 : scanCanonicalize (H12AffineFastState.compose env3375 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(23+1) ^^^ 250900) := by decide +kernel

theorem selectedBound3375 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env3376 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,4194304,17665,250900,8329,5376,4609045,16384,151552,4294795,131141,4294967296,20817,4299412671,131073,513]

theorem envBound3376 : H12AffineFastState.Bounded env3376 := by
  intro p hp
  have h : env3376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3375_3376 : H12AffineEnvironment.transform 23 250900 env3375 = env3376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 250900 env3375 == env3376) = true)

theorem identity3376 : scanCanonicalize (H12AffineFastState.compose env3376 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 4341897) := by decide +kernel

theorem selectedBound3376 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env3377 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,4194304,17665,250900,8329,5376,4609045,16384,151552,4294795,131141,4341897,20817,103478,131073,513]

theorem envBound3377 : H12AffineFastState.Bounded env3377 := by
  intro p hp
  have h : env3377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3376_3377 : H12AffineEnvironment.transform 31 4341897 env3376 = env3377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4341897 env3376 == env3377) = true)

def env3378 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,2098433,6702100,2117633,16876565,1073741824,131140,4294967296,17007940,4352140402,131073,33563272]

theorem envBound3378 : H12AffineFastState.Bounded env3378 := by
  intro p hp
  have h : env3378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3370_3378 : H12AffineEnvironment.transform 25 2098433 env3370 = env3378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 2098433 env3370 == env3378) = true)

theorem identity3378 : scanCanonicalize (H12AffineFastState.compose env3378 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230468) := by decide +kernel

theorem selectedBound3378 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env3379 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,230468,33554432,2098433,6702100,2117633,131153,1073741824,131140,4294967296,256,4335591478,131073,33563272]

theorem envBound3379 : H12AffineFastState.Bounded env3379 := by
  intro p hp
  have h : env3379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3378_3379 : H12AffineEnvironment.transform 23 230468 env3378 = env3379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230468 env3378 == env3379) = true)

def env3380 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17665,230468,33554432,2098433,2518044,2117633,131153,1073741824,131140,4294967296,256,4331391038,131073,33563272]

theorem envBound3380 : H12AffineFastState.Bounded env3380 := by
  intro p hp
  have h : env3380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3379_3380 : H12AffineEnvironment.transform 21 10248 env3379 = env3380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env3379 == env3380) = true)

def env3381 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17665,230468,8328,2098433,2518044,2117633,131153,1073741824,131140,4294967296,256,4297844918,131073,512]

theorem envBound3381 : H12AffineFastState.Bounded env3381 := by
  intro p hp
  have h : env3381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3380_3381 : H12AffineEnvironment.transform 24 8328 env3380 = env3381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env3380 == env3381) = true)

theorem identity3381 : scanCanonicalize (H12AffineFastState.compose env3381 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 2220242) := by decide +kernel

theorem selectedBound3381 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env3382 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17665,230468,8328,2098433,2518044,2117633,131153,2220242,131140,4294967296,256,4297844918,131073,512]

theorem envBound3382 : H12AffineFastState.Bounded env3382 := by
  intro p hp
  have h : env3382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3381_3382 : H12AffineEnvironment.transform 29 2220242 env3381 = env3382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2220242 env3381 == env3382) = true)

theorem identity3382 : scanCanonicalize (H12AffineFastState.compose env3382 (packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 57692) := by decide +kernel

theorem selectedBound3382 : packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3383 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,57692,10248,17665,230468,8328,58461,429376,45405,131153,65934,131140,4294967296,256,4295690730,131073,512]

theorem envBound3383 : H12AffineFastState.Bounded env3383 := by
  intro p hp
  have h : env3383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3382_3383 : H12AffineEnvironment.transform 20 57692 env3382 = env3383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 57692 env3382 == env3383) = true)

theorem identity3383 : scanCanonicalize (H12AffineFastState.compose env3383 (packedSelected [1,3,6,17,21,24,25,28] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound3383 : packedSelected [1,3,6,17,21,24,25,28] rootPS < 2^1333 := by decide +kernel

def env3384 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,131072,262144,524288,8460,16464,10248,17665,206152,8328,17745,404556,4177,131153,65934,131140,4294967296,256,4295690730,131073,512]

theorem envBound3384 : H12AffineFastState.Bounded env3384 := by
  intro p hp
  have h : env3384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3383_3384 : H12AffineEnvironment.transform 14 8460 env3383 = env3384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env3383 == env3384) = true)

theorem identity3384 : scanCanonicalize (H12AffineFastState.compose env3384 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(16+1) ^^^ 11460) := by decide +kernel

theorem selectedBound3384 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env3385 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,11460,262144,524288,8460,16464,10248,17665,67980,8328,17745,262280,4177,11413,65934,11392,4294967296,256,4295566638,11461,512]

theorem envBound3385 : H12AffineFastState.Bounded env3385 := by
  intro p hp
  have h : env3385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3384_3385 : H12AffineEnvironment.transform 16 11460 env3384 = env3385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 11460 env3384 == env3385) = true)

def env3386 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,11460,2048,524288,8460,16464,10248,17665,67980,8328,17745,2184,4177,11413,65934,11392,4294967296,256,4295566638,11461,512]

theorem envBound3386 : H12AffineFastState.Bounded env3386 := by
  intro p hp
  have h : env3386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3385_3386 : H12AffineEnvironment.transform 17 2048 env3385 = env3386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2048 env3385 == env3386) = true)

def env3387 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,16384,8460,65536,11340,2048,524288,8460,16464,10248,17665,67844,8192,17745,2048,4177,11293,65798,11272,4294967296,256,4295566638,11341,512]

theorem envBound3387 : H12AffineFastState.Bounded env3387 := by
  intro p hp
  have h : env3387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3386_3387 : H12AffineEnvironment.transform 6 8 env3386 = env3387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3386 == env3387) = true)

theorem identity3387 : scanCanonicalize (H12AffineFastState.compose env3387 (packedSelected [16,20] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound3387 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env3388 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,16384,8460,2082,11340,2048,524288,8460,16464,10248,17665,294,8192,17745,2048,4177,11293,2340,11272,4294967296,256,4295503116,11341,512]

theorem envBound3388 : H12AffineFastState.Bounded env3388 := by
  intro p hp
  have h : env3388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3387_3388 : H12AffineEnvironment.transform 15 2082 env3387 = env3388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env3387 == env3388) = true)

theorem identity3388 : scanCanonicalize (H12AffineFastState.compose env3388 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 539239) := by decide +kernel

theorem selectedBound3388 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env3389 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,16384,8460,2082,11340,2048,524288,8460,16464,10248,17665,294,8192,17745,2048,4177,11293,2340,11272,539239,256,5995,11341,512]

theorem envBound3389 : H12AffineFastState.Bounded env3389 := by
  intro p hp
  have h : env3389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3388_3389 : H12AffineEnvironment.transform 31 539239 env3388 = env3389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 539239 env3388 == env3389) = true)

theorem identity3389 : scanCanonicalize (H12AffineFastState.compose env3389 (packedSelected [11,16,18] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3389 : packedSelected [11,16,18] rootPS < 2^1333 := by decide +kernel

def env3390 : List Nat := [2,4,8,16,32,64,8,36,512,1024,2048,4096,8192,16384,8232,2082,11340,2048,524288,8232,16464,10248,17445,2,8192,17525,2048,4177,11293,2048,11272,539239,36,5711,11341,512]

theorem envBound3390 : H12AffineFastState.Bounded env3390 := by
  intro p hp
  have h : env3390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3389_3390 : H12AffineEnvironment.transform 7 36 env3389 = env3390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3389 == env3390) = true)

theorem identity3390 : scanCanonicalize (H12AffineFastState.compose env3390 (packedSelected [12,15] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound3390 : packedSelected [12,15] rootPS < 2^1333 := by decide +kernel

def env3391 : List Nat := [2,4,8,16,32,64,8,36,512,1024,2048,4096,8192,16384,8232,2082,11340,2048,1024,8232,16464,10248,17445,2,8192,17525,2048,4177,11293,2048,11272,15975,36,5711,11341,512]

theorem envBound3391 : H12AffineFastState.Bounded env3391 := by
  intro p hp
  have h : env3391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3390_3391 : H12AffineEnvironment.transform 18 1024 env3390 = env3391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env3390 == env3391) = true)

theorem identity3391 : scanCanonicalize (H12AffineFastState.compose env3391 (packedSelected [1,2,4,5,6,7,13] rootPS)) = affineNative (2^(13+1) ^^^ 1566) := by decide +kernel

theorem selectedBound3391 : packedSelected [1,2,4,5,6,7,13] rootPS < 2^1333 := by decide +kernel

def env3392 : List Nat := [2,4,8,16,32,64,8,36,512,1024,2048,4096,8192,1566,8232,2082,11340,2048,1024,8232,1614,10248,571,2,8192,619,2048,4177,11293,2048,11272,15975,36,5711,11341,512]

theorem envBound3392 : H12AffineFastState.Bounded env3392 := by
  intro p hp
  have h : env3392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3391_3392 : H12AffineEnvironment.transform 13 1566 env3391 = env3392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1566 env3391 == env3392) = true)

theorem identity3392 : scanCanonicalize (H12AffineFastState.compose env3392 (packedSelected [0,4,7,22] rootPS)) = affineNative (2^(12+1) ^^^ 2088) := by decide +kernel

theorem selectedBound3392 : packedSelected [0,4,7,22] rootPS < 2^1333 := by decide +kernel

def env3393 : List Nat := [2,4,8,16,32,64,8,36,512,1024,2048,4096,2088,1566,2048,2082,1124,2048,1024,2048,1614,32,571,2,2088,619,2048,4177,1077,2048,1056,5711,36,5711,1125,512]

theorem envBound3393 : H12AffineFastState.Bounded env3393 := by
  intro p hp
  have h : env3393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3392_3393 : H12AffineEnvironment.transform 12 2088 env3392 = env3393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2088 env3392 == env3393) = true)

theorem identity3393 : scanCanonicalize (H12AffineFastState.compose env3393 (packedSelected [0,6,7] rootPS)) = affineNative (2^(11+1) ^^^ 1124) := by decide +kernel

theorem selectedBound3393 : packedSelected [0,6,7] rootPS < 2^1333 := by decide +kernel

def env3394 : List Nat := [2,4,8,16,32,64,8,36,512,1024,2048,1124,2088,1566,2048,2082,1124,2048,1024,2048,1614,32,571,2,2088,619,2048,1077,1077,2048,1056,555,36,555,1125,512]

theorem envBound3394 : H12AffineFastState.Bounded env3394 := by
  intro p hp
  have h : env3394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3393_3394 : H12AffineEnvironment.transform 11 1124 env3393 = env3394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1124 env3393 == env3394) = true)

theorem identity3394 : scanCanonicalize (H12AffineFastState.compose env3394 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3394 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3395 : List Nat := [2,4,2,16,32,64,2,36,512,1024,2048,1124,2082,1556,2048,2082,1124,2048,1024,2048,1604,32,561,2,2082,609,2048,1077,1077,2048,1056,545,36,545,1125,512]

theorem envBound3395 : H12AffineFastState.Bounded env3395 := by
  intro p hp
  have h : env3395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3394_3395 : H12AffineEnvironment.transform 2 2 env3394 = env3395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3394 == env3395) = true)

theorem identity3395 : scanCanonicalize (H12AffineFastState.compose env3395 (packedSelected [0,10] rootPS)) = affineNative (2^(9+1) ^^^ 103) := by decide +kernel

theorem selectedBound3395 : packedSelected [0,10] rootPS < 2^1333 := by decide +kernel

def env3396 : List Nat := [2,4,2,16,32,64,2,36,512,103,2048,3,2082,627,2048,2082,3,2048,103,2048,547,32,561,2,2082,609,2048,82,82,2048,71,545,36,545,2,512]

theorem envBound3396 : H12AffineFastState.Bounded env3396 := by
  intro p hp
  have h : env3396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3395_3396 : H12AffineEnvironment.transform 9 103 env3395 = env3396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 103 env3395 == env3396) = true)

theorem identity3396 : scanCanonicalize (H12AffineFastState.compose env3396 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 593) := by decide +kernel

theorem selectedBound3396 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3397 : List Nat := [2,4,2,16,32,64,2,36,512,103,593,3,627,627,593,627,3,593,103,593,547,32,561,2,627,609,593,82,82,593,71,545,36,545,2,512]

theorem envBound3397 : H12AffineFastState.Bounded env3397 := by
  intro p hp
  have h : env3397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3396_3397 : H12AffineEnvironment.transform 10 593 env3396 = env3397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 593 env3396 == env3397) = true)

def env3398 : List Nat := [2,4,2,16,32,64,2,36,0,103,81,3,115,115,81,115,3,81,103,81,35,32,49,2,115,97,81,82,82,81,71,33,36,33,2,0]

theorem envBound3398 : H12AffineFastState.Bounded env3398 := by
  intro p hp
  have h : env3398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3397_3398 : H12AffineEnvironment.transform 8 0 env3397 = env3398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env3397 == env3398) = true)

theorem identity3398 : scanCanonicalize (H12AffineFastState.compose env3398 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 3) := by decide +kernel

theorem selectedBound3398 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3399 : List Nat := [2,4,2,16,32,3,2,36,0,36,18,3,48,48,18,48,3,18,36,18,35,32,49,2,48,34,18,17,17,18,4,33,36,33,2,0]

theorem envBound3399 : H12AffineFastState.Bounded env3399 := by
  intro p hp
  have h : env3399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3398_3399 : H12AffineEnvironment.transform 5 3 env3398 = env3399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 3 env3398 == env3399) = true)

def env3400 : List Nat := [2,4,2,16,0,3,2,4,0,4,18,3,16,16,18,16,3,18,4,18,3,0,17,2,16,2,18,17,17,18,4,1,4,1,2,0]

theorem envBound3400 : H12AffineFastState.Bounded env3400 := by
  intro p hp
  have h : env3400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3399_3400 : H12AffineEnvironment.transform 4 0 env3399 = env3400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3399 == env3400) = true)

def leafEnv3400 : List Nat := [2,4,2,16,0,3,2,4,0,4,18,3,16,16,18,16,3,18,4,18,3,0,17,2,4,16,1,2,18,17,17,18,4,1,4,1,4,16,2,0,0,17,1]

def active3400 : List Nat := [0,1,3]

def tree3400 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3400 : H12WitnessSearch.Good tree3400 := H12GlobalWitnessIndex.good

theorem leafIdentity3400 : H12AffineFastState.composeSystem env3400 rootObs = leafEnv3400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3400 rootObs == leafEnv3400) = true)

theorem terminalChecked3400 : H12PackedTerminal.terminalCheckFast leafEnv3400 active3400 tree3400 = true := by decide +kernel

def env3401 : List Nat := [2,4,2,16,1,3,2,5,0,5,18,3,17,17,18,17,3,18,5,18,2,1,16,2,17,3,18,17,17,18,4,0,5,0,2,0]

theorem envBound3401 : H12AffineFastState.Bounded env3401 := by
  intro p hp
  have h : env3401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3399_3401 : H12AffineEnvironment.transform 4 1 env3399 = env3401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3399 == env3401) = true)

theorem identity3401 : scanCanonicalize (H12AffineFastState.compose env3401 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound3401 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3402 : List Nat := [2,4,2,3,1,3,2,5,0,5,1,3,2,2,1,2,3,1,5,1,2,1,3,2,2,3,1,2,2,1,4,0,5,0,2,0]

theorem envBound3402 : H12AffineFastState.Bounded env3402 := by
  intro p hp
  have h : env3402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3401_3402 : H12AffineEnvironment.transform 3 3 env3401 = env3402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env3401 == env3402) = true)

def leafEnv3402 : List Nat := [2,4,2,3,1,3,2,5,0,5,1,3,2,2,1,2,3,1,5,1,2,1,3,2,4,2,1,3,1,2,2,1,4,0,5,0,4,2,2,0,0,2,1]

end H12GlobalChart2