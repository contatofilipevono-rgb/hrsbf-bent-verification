import H12GlobalChart2Data016

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem identity4159 : scanCanonicalize (H12AffineFastState.compose env4159 (packedSelected [2,5] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4159 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4160 : List Nat := [2,4,8,11,32,64,128,37,136,1024,0,1071,41,1125,0,171,1124,0,1025,0,1070,32,65,139,160,11,1,1124,1070,0,1056,43,37,43,1125,137]

theorem envBound4160 : H12AffineFastState.Bounded env4160 := by
  intro p hp
  have h : env4160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4159_4160 : H12AffineEnvironment.transform 3 11 env4159 = env4160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4159 == env4160) = true)

theorem identity4160 : scanCanonicalize (H12AffineFastState.compose env4160 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 72) := by decide +kernel

theorem selectedBound4160 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4161 : List Nat := [2,4,8,11,32,64,72,37,64,1024,0,1071,41,1125,0,99,1124,0,1025,0,1070,32,65,67,104,11,1,1124,1070,0,1056,43,37,43,1125,65]

theorem envBound4161 : H12AffineFastState.Bounded env4161 := by
  intro p hp
  have h : env4161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4160_4161 : H12AffineEnvironment.transform 6 72 env4160 = env4161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 72 env4160 == env4161) = true)

def env4162 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,1,78399,32768,4097,8201,5456,16777216,8329,16880644,8460,16879957,16876565,16848825,1285,4294967296,16875525,4295006105,1344,513]

theorem envBound4162 : H12AffineFastState.Bounded env4162 := by
  intro p hp
  have h : env4162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4138_4162 : H12AffineEnvironment.transform 17 1 env4138 = env4162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4138 == env4162) = true)

theorem identity4162 : scanCanonicalize (H12AffineFastState.compose env4162 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 111896) := by decide +kernel

theorem selectedBound4162 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4163 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,1,78399,32768,4097,8201,5456,111896,8329,8476,8460,9293,12557,41633,1285,4294967296,13597,4295006105,1344,513]

theorem envBound4163 : H12AffineFastState.Bounded env4163 := by
  intro p hp
  have h : env4163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4162_4163 : H12AffineEnvironment.transform 23 111896 env4162 = env4163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 111896 env4162 == env4163) = true)

theorem identity4163 : scanCanonicalize (H12AffineFastState.compose env4163 (packedSelected [0,2,3,5,6,9,10,13,20,21] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound4163 : packedSelected [0,2,3,5,6,9,10,13,20,21] rootPS < 2^1333 := by decide +kernel

def env4164 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,8864,65536,1345,1,78399,8864,4097,8201,5456,71608,8329,8476,8460,9293,12557,1,1285,4294967296,13597,4294980921,1344,513]

theorem envBound4164 : H12AffineFastState.Bounded env4164 := by
  intro p hp
  have h : env4164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4163_4164 : H12AffineEnvironment.transform 14 8864 env4163 = env4164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env4163 == env4164) = true)

theorem identity4164 : scanCanonicalize (H12AffineFastState.compose env4164 (packedSelected [18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4164 : packedSelected [18,20] rootPS < 2^1333 := by decide +kernel

def env4165 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1345,8864,65536,1345,1,75567,8864,1297,8201,64,66216,8329,8476,8460,9293,9245,1,1285,4294967296,8205,4294975529,1344,513]

theorem envBound4165 : H12AffineFastState.Bounded env4165 := by
  intro p hp
  have h : env4165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4164_4165 : H12AffineEnvironment.transform 11 1296 env4164 = env4165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4164 == env4165) = true)

theorem identity4165 : scanCanonicalize (H12AffineFastState.compose env4165 (packedSelected [18] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4165 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env4166 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1296,8192,1345,8232,65536,1345,1,75175,8232,1297,8201,64,65568,8329,8476,8460,9293,9245,1,1285,4294967296,8205,4294975529,1344,137]

theorem envBound4166 : H12AffineFastState.Bounded env4166 := by
  intro p hp
  have h : env4166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4165_4166 : H12AffineEnvironment.transform 8 136 env4165 = env4166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4165 == env4166) = true)

theorem identity4166 : scanCanonicalize (H12AffineFastState.compose env4166 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound4166 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4167 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1296,269,1345,293,65536,1345,1,66730,293,1297,260,64,65568,388,17,1,1344,1296,1,1285,4294967296,256,4294967588,1344,137]

theorem envBound4167 : H12AffineFastState.Bounded env4167 := by
  intro p hp
  have h : env4167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4166_4167 : H12AffineEnvironment.transform 12 269 env4166 = env4167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env4166 == env4167) = true)

theorem identity4167 : scanCanonicalize (H12AffineFastState.compose env4167 (packedSelected [2,3,4,10] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound4167 : packedSelected [2,3,4,10] rootPS < 2^1333 := by decide +kernel

def env4168 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1296,269,1345,293,171,1345,1,1025,293,1297,260,64,139,388,17,1,1344,1296,1,1285,4294967296,256,4294967588,1344,137]

theorem envBound4168 : H12AffineFastState.Bounded env4168 := by
  intro p hp
  have h : env4168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4167_4168 : H12AffineEnvironment.transform 15 171 env4167 = env4168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env4167 == env4168) = true)

theorem identity4168 : scanCanonicalize (H12AffineFastState.compose env4168 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound4168 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4169 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1077,40,1124,0,171,1124,1,1025,0,1076,33,64,139,161,17,1,1125,1077,1,1056,4294967296,37,4294967297,1125,137]

theorem envBound4169 : H12AffineFastState.Bounded env4169 := by
  intro p hp
  have h : env4169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4168_4169 : H12AffineEnvironment.transform 7 37 env4168 = env4169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4168 == env4169) = true)

theorem identity4169 : scanCanonicalize (H12AffineFastState.compose env4169 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 163) := by decide +kernel

theorem selectedBound4169 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4170 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1077,40,1124,0,171,1124,1,1025,0,1076,33,64,139,161,17,1,1125,1077,1,1056,163,37,162,1125,137]

theorem envBound4170 : H12AffineFastState.Bounded env4170 := by
  intro p hp
  have h : env4170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4169_4170 : H12AffineEnvironment.transform 31 163 env4169 = env4170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 163 env4169 == env4170) = true)

theorem identity4170 : scanCanonicalize (H12AffineFastState.compose env4170 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound4170 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4171 : List Nat := [2,4,8,16,32,64,24,37,16,1024,0,1077,40,1124,0,51,1124,1,1025,0,1076,33,64,19,57,17,1,1125,1077,1,1056,59,37,58,1125,17]

theorem envBound4171 : H12AffineFastState.Bounded env4171 := by
  intro p hp
  have h : env4171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4170_4171 : H12AffineEnvironment.transform 6 24 env4170 = env4171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env4170 == env4171) = true)

theorem identity4171 : scanCanonicalize (H12AffineFastState.compose env4171 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4171 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4172 : List Nat := [2,4,8,16,32,0,24,37,16,1024,0,1077,40,1060,0,51,1060,1,1025,0,1076,33,0,19,57,17,1,1061,1077,1,1056,59,37,58,1061,17]

theorem envBound4172 : H12AffineFastState.Bounded env4172 := by
  intro p hp
  have h : env4172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4171_4172 : H12AffineEnvironment.transform 5 0 env4171 = env4172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4171 == env4172) = true)

def env4173 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8201,5456,16777216,8329,16880644,270605,16879957,16876565,17311111,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4173 : H12AffineFastState.Bounded env4173 := by
  intro p hp
  have h : env4173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4136_4173 : H12AffineEnvironment.transform 10 1 env4136 = env4173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4136 == env4173) = true)

theorem identity4173 : scanCanonicalize (H12AffineFastState.compose env4173 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 537118) := by decide +kernel

theorem selectedBound4173 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4174 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8201,5456,537118,8329,632346,270605,631627,636427,6041,1285,4294967296,635419,4295599526,1344,513]

theorem envBound4174 : H12AffineFastState.Bounded env4174 := by
  intro p hp
  have h : env4174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4173_4174 : H12AffineEnvironment.transform 23 537118 env4173 = env4174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 537118 env4173 == env4174) = true)

def env4175 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,0,524288,32768,4097,8201,5456,537118,8329,632346,8461,631627,636427,6041,1285,4294967296,635419,4295599526,1344,513]

theorem envBound4175 : H12AffineFastState.Bounded env4175 := by
  intro p hp
  have h : env4175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4174_4175 : H12AffineEnvironment.transform 17 0 env4174 = env4175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4174 == env4175) = true)

theorem identity4175 : scanCanonicalize (H12AffineFastState.compose env4175 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 940) := by decide +kernel

theorem selectedBound4175 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4176 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,940,65536,1345,0,524288,940,4097,8201,5456,537118,8329,599478,8461,598247,603559,6041,1285,4294967296,602551,4295566858,1344,513]

theorem envBound4176 : H12AffineFastState.Bounded env4176 := by
  intro p hp
  have h : env4176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4175_4176 : H12AffineEnvironment.transform 14 940 env4175 = env4176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 940 env4175 == env4176) = true)

theorem identity4176 : scanCanonicalize (H12AffineFastState.compose env4176 (packedSelected [1,5,9,15,20,21,22] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound4176 : packedSelected [1,5,9,15,20,21,22] rootPS < 2^1333 := by decide +kernel

def env4177 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5148,4177,940,65536,1345,0,524288,940,4097,5141,5456,525826,5269,594346,5393,595195,590267,6041,1285,4294967296,591275,4295561750,1344,513]

theorem envBound4177 : H12AffineFastState.Bounded env4177 := by
  intro p hp
  have h : env4177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4176_4177 : H12AffineEnvironment.transform 12 5148 env4176 = env4177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env4176 == env4177) = true)

theorem identity4177 : scanCanonicalize (H12AffineFastState.compose env4177 (packedSelected [1,3,4,5,8,9,12,13,15,17] rootPS)) = affineNative (2^(18+1) ^^^ 70451) := by decide +kernel

theorem selectedBound4177 : packedSelected [1,3,4,5,8,9,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4178 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5148,4177,940,65536,1345,0,70451,940,4097,5141,5456,70961,5269,665,5393,1992,4744,6041,1285,4294967296,5784,4294967589,1344,513]

theorem envBound4178 : H12AffineFastState.Bounded env4178 := by
  intro p hp
  have h : env4178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4177_4178 : H12AffineEnvironment.transform 18 70451 env4177 = env4178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70451 env4177 == env4178) = true)

theorem identity4178 : scanCanonicalize (H12AffineFastState.compose env4178 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4178 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4179 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,5148,4177,292,65536,1345,0,70075,292,4097,5141,5456,70961,5269,17,5393,1344,4096,5393,1285,4294967296,5136,4294967589,1344,137]

theorem envBound4179 : H12AffineFastState.Bounded env4179 := by
  intro p hp
  have h : env4179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4178_4179 : H12AffineEnvironment.transform 8 136 env4178 = env4179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4178 == env4179) = true)

theorem identity4179 : scanCanonicalize (H12AffineFastState.compose env4179 (packedSelected [20] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4179 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env4180 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,268,1345,292,65536,1345,0,66731,292,1297,261,64,65569,389,17,1,1344,1296,1,1285,4294967296,256,4294967589,1344,137]

theorem envBound4180 : H12AffineFastState.Bounded env4180 := by
  intro p hp
  have h : env4180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4179_4180 : H12AffineEnvironment.transform 11 1296 env4179 = env4180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4179 == env4180) = true)

def env4181 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,40,1125,0,65536,1125,0,66731,0,1077,33,64,65569,161,17,1,1124,1076,1,1057,4294967296,36,4294967297,1124,137]

theorem envBound4181 : H12AffineFastState.Bounded env4181 := by
  intro p hp
  have h : env4181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4180_4181 : H12AffineEnvironment.transform 7 36 env4180 = env4181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4180 == env4181) = true)

theorem identity4181 : scanCanonicalize (H12AffineFastState.compose env4181 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65665) := by decide +kernel

theorem selectedBound4181 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4182 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,40,1125,0,65536,1125,0,66731,0,1077,33,64,65569,161,17,1,1124,1076,1,1057,65665,36,65664,1124,137]

theorem envBound4182 : H12AffineFastState.Bounded env4182 := by
  intro p hp
  have h : env4182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4181_4182 : H12AffineEnvironment.transform 31 65665 env4181 = env4182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65665 env4181 == env4182) = true)

theorem identity4182 : scanCanonicalize (H12AffineFastState.compose env4182 (packedSelected [1,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4182 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4183 : List Nat := [2,4,8,16,32,0,128,36,136,1024,1,1076,40,1061,0,65536,1061,0,66731,0,1077,33,0,65569,161,17,1,1060,1076,1,1057,65665,36,65664,1060,137]

theorem envBound4183 : H12AffineFastState.Bounded env4183 := by
  intro p hp
  have h : env4183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4182_4183 : H12AffineEnvironment.transform 5 0 env4182 = env4183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4182 == env4183) = true)

def env4184 : List Nat := [2,4,8,16,32,0,128,36,136,1024,1,1076,40,1061,0,128,1061,0,1067,0,1077,33,0,161,161,17,1,1060,1076,1,1057,1,36,0,1060,137]

theorem envBound4184 : H12AffineFastState.Bounded env4184 := by
  intro p hp
  have h : env4184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4183_4184 : H12AffineEnvironment.transform 15 128 env4183 = env4184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 128 env4183 == env4184) = true)

def env4185 : List Nat := [2,4,8,16,32,0,56,36,48,1024,1,1076,40,1061,0,56,1061,0,1067,0,1077,33,0,25,25,17,1,1060,1076,1,1057,1,36,0,1060,49]

theorem envBound4185 : H12AffineFastState.Bounded env4185 := by
  intro p hp
  have h : env4185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4184_4185 : H12AffineEnvironment.transform 6 56 env4184 = env4185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 56 env4184 == env4185) = true)

theorem identity4185 : scanCanonicalize (H12AffineFastState.compose env4185 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4185 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4186 : List Nat := [2,4,8,16,10,0,18,14,26,1024,1,1054,2,1039,0,18,1039,0,1025,0,1055,11,0,25,25,17,1,1038,1054,1,1035,1,14,0,1038,27]

theorem envBound4186 : H12AffineFastState.Bounded env4186 := by
  intro p hp
  have h : env4186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4185_4186 : H12AffineEnvironment.transform 4 10 env4185 = env4186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4185 == env4186) = true)

def leafEnv4186 : List Nat := [2,4,8,16,10,0,18,14,26,1024,1,1054,2,1039,0,18,1039,0,1025,0,1055,11,0,25,1034,25,1,17,1,1038,1054,1,1035,1,14,0,4,8,1038,27,0,1055,1]

def active4186 : List Nat := [0,1,2,3,9]

def tree4186 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4186 : H12WitnessSearch.Good tree4186 := H12GlobalWitnessIndex.good

theorem leafIdentity4186 : H12AffineFastState.composeSystem env4186 rootObs = leafEnv4186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4186 rootObs == leafEnv4186) = true)

theorem terminalChecked4186 : H12PackedTerminal.terminalCheckFast leafEnv4186 active4186 tree4186 = true := by decide +kernel

def env4187 : List Nat := [2,4,8,16,32,0,57,36,49,1024,1,1076,40,1061,0,57,1061,0,1067,0,1077,33,0,24,24,17,1,1060,1076,1,1057,1,36,0,1060,48]

theorem envBound4187 : H12AffineFastState.Bounded env4187 := by
  intro p hp
  have h : env4187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4184_4187 : H12AffineEnvironment.transform 6 57 env4184 = env4187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env4184 == env4187) = true)

def env4188 : List Nat := [2,4,8,16,0,0,25,4,17,1024,1,1044,8,1029,0,25,1029,0,1035,0,1045,1,0,24,24,17,1,1028,1044,1,1025,1,4,0,1028,16]

theorem envBound4188 : H12AffineFastState.Bounded env4188 := by
  intro p hp
  have h : env4188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4187_4188 : H12AffineEnvironment.transform 4 0 env4187 = env4188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4187 == env4188) = true)

theorem identity4188 : scanCanonicalize (H12AffineFastState.compose env4188 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4188 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4189 : List Nat := [2,4,2,16,0,0,19,4,17,1024,1,1044,2,1029,0,19,1029,0,1025,0,1045,1,0,18,18,17,1,1028,1044,1,1025,1,4,0,1028,16]

theorem envBound4189 : H12AffineFastState.Bounded env4189 := by
  intro p hp
  have h : env4189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4188_4189 : H12AffineEnvironment.transform 2 2 env4188 = env4189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4188 == env4189) = true)

def leafEnv4189 : List Nat := [2,4,2,16,0,0,19,4,17,1024,1,1044,2,1029,0,19,1029,0,1025,0,1045,1,0,18,1024,18,1,17,1,1028,1044,1,1025,1,4,0,4,2,1028,16,0,1045,1]

def active4189 : List Nat := [0,1,3,9]

def tree4189 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4189 : H12WitnessSearch.Good tree4189 := H12GlobalWitnessIndex.good

theorem leafIdentity4189 : H12AffineFastState.composeSystem env4189 rootObs = leafEnv4189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4189 rootObs == leafEnv4189) = true)

theorem terminalChecked4189 : H12PackedTerminal.terminalCheckFast leafEnv4189 active4189 tree4189 = true := by decide +kernel

def env4190 : List Nat := [2,4,8,16,1,0,24,5,16,1024,1,1045,9,1028,0,24,1028,0,1034,0,1044,0,0,24,24,17,1,1029,1045,1,1024,1,5,0,1029,17]

theorem envBound4190 : H12AffineFastState.Bounded env4190 := by
  intro p hp
  have h : env4190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4187_4190 : H12AffineEnvironment.transform 4 1 env4187 = env4190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4187 == env4190) = true)

def leafEnv4190 : List Nat := [2,4,8,16,1,0,24,5,16,1024,1,1045,9,1028,0,24,1028,0,1034,0,1044,0,0,24,1034,24,1,17,1,1029,1045,1,1024,1,5,0,4,3,1029,17,0,1044,1]

def active4190 : List Nat := [0,1,2,3,9]

def tree4190 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4190 : H12WitnessSearch.Good tree4190 := H12GlobalWitnessIndex.good

theorem leafIdentity4190 : H12AffineFastState.composeSystem env4190 rootObs = leafEnv4190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4190 rootObs == leafEnv4190) = true)

theorem terminalChecked4190 : H12PackedTerminal.terminalCheckFast leafEnv4190 active4190 tree4190 = true := by decide +kernel

def env4191 : List Nat := [2,4,8,16,32,0,128,36,136,1024,1,1076,40,1061,0,129,1061,0,1066,0,1077,33,0,160,161,17,1,1060,1076,1,1057,0,36,1,1060,137]

theorem envBound4191 : H12AffineFastState.Bounded env4191 := by
  intro p hp
  have h : env4191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4183_4191 : H12AffineEnvironment.transform 15 129 env4183 = env4191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 129 env4183 == env4191) = true)

theorem identity4191 : scanCanonicalize (H12AffineFastState.compose env4191 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4191 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4192 : List Nat := [2,4,8,16,11,0,128,15,136,1024,1,1055,3,1038,0,129,1038,0,1025,0,1054,10,0,139,138,17,1,1039,1055,1,1034,0,15,1,1039,137]

theorem envBound4192 : H12AffineFastState.Bounded env4192 := by
  intro p hp
  have h : env4192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4191_4192 : H12AffineEnvironment.transform 4 11 env4191 = env4192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4191 == env4192) = true)

def leafEnv4192 : List Nat := [2,4,8,16,11,0,128,15,136,1024,1,1055,3,1038,0,129,1038,0,1025,0,1054,10,0,139,1035,138,1,17,1,1039,1055,1,1034,0,15,1,4,9,1039,137,0,1054,1]

def active4192 : List Nat := [0,1,2,3,6,9]

def tree4192 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4192 : H12WitnessSearch.Good tree4192 := H12GlobalWitnessIndex.good

theorem leafIdentity4192 : H12AffineFastState.composeSystem env4192 rootObs = leafEnv4192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4192 rootObs == leafEnv4192) = true)

theorem terminalChecked4192 : H12PackedTerminal.terminalCheckFast leafEnv4192 active4192 tree4192 = true := by decide +kernel

def env4193 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1077,41,1124,1,65536,1124,0,66731,1,1076,32,64,65569,160,17,1,1125,1077,1,1056,4294967296,37,4294967296,1125,137]

theorem envBound4193 : H12AffineFastState.Bounded env4193 := by
  intro p hp
  have h : env4193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4180_4193 : H12AffineEnvironment.transform 7 37 env4180 = env4193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4180 == env4193) = true)

theorem identity4193 : scanCanonicalize (H12AffineFastState.compose env4193 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 163) := by decide +kernel

theorem selectedBound4193 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4194 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1077,41,1124,1,65536,1124,0,66731,1,1076,32,64,65569,160,17,1,1125,1077,1,1056,163,37,163,1125,137]

theorem envBound4194 : H12AffineFastState.Bounded env4194 := by
  intro p hp
  have h : env4194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4193_4194 : H12AffineEnvironment.transform 31 163 env4193 = env4194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 163 env4193 == env4194) = true)

theorem identity4194 : scanCanonicalize (H12AffineFastState.compose env4194 (packedSelected [1,3,4] rootPS)) = affineNative (2^(6+1) ^^^ 67) := by decide +kernel

theorem selectedBound4194 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4195 : List Nat := [2,4,8,16,32,64,67,37,75,1024,1,1077,41,1124,1,65536,1124,0,66664,1,1076,32,64,65569,99,17,1,1125,1077,1,1056,96,37,96,1125,74]

theorem envBound4195 : H12AffineFastState.Bounded env4195 := by
  intro p hp
  have h : env4195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4194_4195 : H12AffineEnvironment.transform 6 67 env4194 = env4195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 67 env4194 == env4195) = true)

theorem identity4195 : scanCanonicalize (H12AffineFastState.compose env4195 (packedSelected [2,5] rootPS)) = affineNative (2^(15+1) ^^^ 105) := by decide +kernel

theorem selectedBound4195 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4196 : List Nat := [2,4,8,16,32,64,67,37,75,1024,1,1077,41,1124,1,105,1124,0,1025,1,1076,32,64,72,99,17,1,1125,1077,1,1056,96,37,96,1125,74]

theorem envBound4196 : H12AffineFastState.Bounded env4196 := by
  intro p hp
  have h : env4196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4195_4196 : H12AffineEnvironment.transform 15 105 env4195 = env4196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 105 env4195 == env4196) = true)

theorem identity4196 : scanCanonicalize (H12AffineFastState.compose env4196 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound4196 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4197 : List Nat := [2,4,8,16,32,26,25,37,17,1024,1,1077,41,1086,1,51,1086,0,1025,1,1076,32,26,18,57,17,1,1087,1077,1,1056,58,37,58,1087,16]

theorem envBound4197 : H12AffineFastState.Bounded env4197 := by
  intro p hp
  have h : env4197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4196_4197 : H12AffineEnvironment.transform 5 26 env4196 = env4197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env4196 == env4197) = true)

def env4198 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,1,524288,32768,4097,8201,5456,537118,8329,632346,8460,631627,636427,6041,1285,4294967296,635419,4295599526,1344,513]

theorem envBound4198 : H12AffineFastState.Bounded env4198 := by
  intro p hp
  have h : env4198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4174_4198 : H12AffineEnvironment.transform 17 1 env4174 = env4198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4174 == env4198) = true)

theorem identity4198 : scanCanonicalize (H12AffineFastState.compose env4198 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound4198 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4199 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8864,65536,1345,1,524288,8864,4097,8201,5456,537118,8329,591034,8460,590315,595115,6041,1285,4294967296,594107,4295558918,1344,513]

theorem envBound4199 : H12AffineFastState.Bounded env4199 := by
  intro p hp
  have h : env4199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4198_4199 : H12AffineEnvironment.transform 14 8864 env4198 = env4199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env4198 == env4199) = true)

theorem identity4199 : scanCanonicalize (H12AffineFastState.compose env4199 (packedSelected [9,22,23] rootPS)) = affineNative (2^(18+1) ^^^ 75567) := by decide +kernel

theorem selectedBound4199 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4200 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8864,65536,1345,1,75567,8864,4097,8201,5456,70961,8329,9109,8460,9924,13188,6041,1285,4294967296,14228,4294975529,1344,513]

theorem envBound4200 : H12AffineFastState.Bounded env4200 := by
  intro p hp
  have h : env4200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4199_4200 : H12AffineEnvironment.transform 18 75567 env4199 = env4200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75567 env4199 == env4200) = true)

theorem identity4200 : scanCanonicalize (H12AffineFastState.compose env4200 (packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound4200 : packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4201 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5148,4177,5820,65536,1345,1,70451,5820,4097,5141,5456,70961,5269,6025,5392,4824,1944,6041,1285,4294967296,904,4294972469,1344,513]

theorem envBound4201 : H12AffineFastState.Bounded env4201 := by
  intro p hp
  have h : env4201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4200_4201 : H12AffineEnvironment.transform 12 5148 env4200 = env4201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env4200 == env4201) = true)

theorem identity4201 : scanCanonicalize (H12AffineFastState.compose env4201 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound4201 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4202 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,269,1344,941,65536,1345,1,67106,941,1296,260,65,65568,388,664,1,1993,1944,648,1285,4294967296,904,4294967588,1344,513]

theorem envBound4202 : H12AffineFastState.Bounded env4202 := by
  intro p hp
  have h : env4202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4201_4202 : H12AffineEnvironment.transform 11 1297 env4201 = env4202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4201 == env4202) = true)

theorem identity4202 : scanCanonicalize (H12AffineFastState.compose env4202 (packedSelected [4,5,8,9,10,12,17] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4202 : packedSelected [4,5,8,9,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4203 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1344,292,65536,1345,1,66731,292,1296,260,65,65568,388,17,1,1344,1297,1,1285,4294967296,257,4294967588,1344,136]

theorem envBound4203 : H12AffineFastState.Bounded env4203 := by
  intro p hp
  have h : env4203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4202_4203 : H12AffineEnvironment.transform 8 137 env4202 = env4203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4202 == env4203) = true)

theorem identity4203 : scanCanonicalize (H12AffineFastState.compose env4203 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 399) := by decide +kernel

theorem selectedBound4203 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4204 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1344,292,399,1345,1,1316,292,1296,260,65,431,388,17,1,1344,1297,1,1285,4294967296,257,4294967588,1344,136]

theorem envBound4204 : H12AffineFastState.Bounded env4204 := by
  intro p hp
  have h : env4204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4203_4204 : H12AffineEnvironment.transform 15 399 env4203 = env4204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 399 env4203 == env4204) = true)

theorem identity4204 : scanCanonicalize (H12AffineFastState.compose env4204 (packedSelected [1,2,3,4,5] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound4204 : packedSelected [1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env4205 : List Nat := [2,4,8,16,32,10,128,256,137,1024,1,1297,269,1290,292,399,1291,1,1316,292,1296,260,11,431,388,17,1,1290,1297,1,1285,4294967296,257,4294967588,1290,136]

theorem envBound4205 : H12AffineFastState.Bounded env4205 := by
  intro p hp
  have h : env4205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4204_4205 : H12AffineEnvironment.transform 5 10 env4204 = env4205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env4204 == env4205) = true)

theorem identity4205 : scanCanonicalize (H12AffineFastState.compose env4205 (packedSelected [0,2,3,4] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound4205 : packedSelected [0,2,3,4] rootPS < 2^1333 := by decide +kernel

def env4206 : List Nat := [2,4,8,16,32,10,57,256,48,1024,1,1297,269,1290,292,310,1291,1,1316,292,1296,260,11,278,317,17,1,1290,1297,1,1285,4294967296,257,4294967588,1290,49]

theorem envBound4206 : H12AffineFastState.Bounded env4206 := by
  intro p hp
  have h : env4206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4205_4206 : H12AffineEnvironment.transform 6 57 env4205 = env4206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env4205 == env4206) = true)

theorem identity4206 : scanCanonicalize (H12AffineFastState.compose env4206 (packedSelected [0,2,3,9] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound4206 : packedSelected [0,2,3,9] rootPS < 2^1333 := by decide +kernel

def env4207 : List Nat := [2,4,8,16,32,10,57,36,48,1024,1,1077,41,1070,0,18,1071,1,1024,0,1076,32,11,50,25,17,1,1070,1077,1,1057,4294967296,37,4294967296,1070,49]

theorem envBound4207 : H12AffineFastState.Bounded env4207 := by
  intro p hp
  have h : env4207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4206_4207 : H12AffineEnvironment.transform 7 36 env4206 = env4207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4206 == env4207) = true)

theorem identity4207 : scanCanonicalize (H12AffineFastState.compose env4207 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1086) := by decide +kernel

theorem selectedBound4207 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4208 : List Nat := [2,4,8,16,32,10,57,36,48,1024,1,1077,41,1070,0,18,1071,1,1024,0,1076,32,11,50,25,17,1,1070,1077,1,1057,1086,37,1086,1070,49]

theorem envBound4208 : H12AffineFastState.Bounded env4208 := by
  intro p hp
  have h : env4208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4207_4208 : H12AffineEnvironment.transform 31 1086 env4207 = env4208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1086 env4207 == env4208) = true)

theorem identity4208 : scanCanonicalize (H12AffineFastState.compose env4208 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4208 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4209 : List Nat := [2,4,8,1,32,10,40,36,33,1024,1,1060,41,1070,0,3,1071,1,1024,0,1061,32,11,35,8,0,1,1070,1060,1,1057,1071,37,1071,1070,32]

theorem envBound4209 : H12AffineFastState.Bounded env4209 := by
  intro p hp
  have h : env4209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4208_4209 : H12AffineEnvironment.transform 3 1 env4208 = env4209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4208 == env4209) = true)

theorem identity4209 : scanCanonicalize (H12AffineFastState.compose env4209 (packedSelected [2] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound4209 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4210 : List Nat := [2,4,8,1,32,10,40,36,33,14,1,42,41,32,0,3,33,1,14,0,43,32,11,35,8,0,1,32,42,1,47,33,37,33,32,32]

theorem envBound4210 : H12AffineFastState.Bounded env4210 := by
  intro p hp
  have h : env4210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4209_4210 : H12AffineEnvironment.transform 9 14 env4209 = env4210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env4209 == env4210) = true)

theorem identity4210 : scanCanonicalize (H12AffineFastState.compose env4210 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4210 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4211 : List Nat := [2,4,2,1,32,0,34,36,33,4,1,32,35,32,0,3,33,1,4,0,33,32,1,35,2,0,1,32,32,1,37,33,37,33,32,32]

theorem envBound4211 : H12AffineFastState.Bounded env4211 := by
  intro p hp
  have h : env4211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4210_4211 : H12AffineEnvironment.transform 2 2 env4210 = env4211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4210 == env4211) = true)

theorem identity4211 : scanCanonicalize (H12AffineFastState.compose env4211 (packedSelected [10] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4211 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env4212 : List Nat := [2,4,2,1,1,0,3,5,0,4,1,1,2,1,0,3,0,1,4,0,0,1,1,2,2,0,1,1,1,1,4,0,4,0,1,1]

theorem envBound4212 : H12AffineFastState.Bounded env4212 := by
  intro p hp
  have h : env4212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4211_4212 : H12AffineEnvironment.transform 4 1 env4211 = env4212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4211 == env4212) = true)

def env4213 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,140617,5456,16777216,8329,17011013,270604,17011732,16876565,1073741824,131140,4294967296,17007940,4295599527,131073,513]

theorem envBound4213 : H12AffineFastState.Bounded env4213 := by
  intro p hp
  have h : env4213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4071_4213 : H12AffineEnvironment.transform 21 140617 env4071 = env4213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 140617 env4071 == env4213) = true)

def env4214 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8201,5456,16777216,8329,16880645,270604,16879956,16876565,1073741824,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4214 : H12AffineFastState.Bounded env4214 := by
  intro p hp
  have h : env4214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4213_4214 : H12AffineEnvironment.transform 16 1344 env4213 = env4214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env4213 == env4214) = true)

theorem identity4214 : scanCanonicalize (H12AffineFastState.compose env4214 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 108674) := by decide +kernel

theorem selectedBound4214 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4215 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8201,5456,16777216,8329,16880645,270604,16879956,16876565,108674,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4215 : H12AffineFastState.Bounded env4215 := by
  intro p hp
  have h : env4215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4214_4215 : H12AffineEnvironment.transform 29 108674 env4214 = env4215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 108674 env4214 == env4215) = true)

def env4216 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8201,5456,16777216,8329,16880645,270604,16879956,16876565,106626,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4216 : H12AffineFastState.Bounded env4216 := by
  intro p hp
  have h : env4216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4215_4216 : H12AffineEnvironment.transform 10 0 env4215 = env4216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4215 == env4216) = true)

theorem identity4216 : scanCanonicalize (H12AffineFastState.compose env4216 (packedSelected [11] rootPS)) = affineNative (2^(15+1) ^^^ 13886) := by decide +kernel

theorem selectedBound4216 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4217 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,13886,1344,262144,524288,32768,4097,8201,5456,16777216,8329,16818747,270604,16820074,16822827,38588,1284,4294967296,16823866,4295529369,1345,513]

theorem envBound4217 : H12AffineFastState.Bounded env4217 := by
  intro p hp
  have h : env4217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4216_4217 : H12AffineEnvironment.transform 15 13886 env4216 = env4217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13886 env4216 == env4217) = true)

def env4218 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,13886,1344,0,524288,32768,4097,8201,5456,16777216,8329,16818747,8460,16820074,16822827,38588,1284,4294967296,16823866,4295529369,1345,513]

theorem envBound4218 : H12AffineFastState.Bounded env4218 := by
  intro p hp
  have h : env4218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4217_4218 : H12AffineEnvironment.transform 17 0 env4217 = env4218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4217 == env4218) = true)

theorem identity4218 : scanCanonicalize (H12AffineFastState.compose env4218 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 41515) := by decide +kernel

theorem selectedBound4218 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4219 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,13886,1344,0,524288,32768,4097,8201,5456,41515,8329,16,8460,1345,4096,38588,1284,4294967296,5137,4295529369,1345,513]

theorem envBound4219 : H12AffineFastState.Bounded env4219 := by
  intro p hp
  have h : env4219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4218_4219 : H12AffineEnvironment.transform 23 41515 env4218 = env4219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 41515 env4218 == env4219) = true)

theorem identity4219 : scanCanonicalize (H12AffineFastState.compose env4219 (packedSelected [20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4219 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env4220 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,32768,13495,1344,0,524288,32768,4097,8201,5456,41122,8329,16,8460,1345,4096,37941,1284,4294967296,5137,4295528720,1345,136]

theorem envBound4220 : H12AffineFastState.Bounded env4220 := by
  intro p hp
  have h : env4220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4219_4220 : H12AffineEnvironment.transform 8 137 env4219 = env4220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4219 == env4220) = true)

theorem identity4220 : scanCanonicalize (H12AffineFastState.compose env4220 (packedSelected [0,2,3,6,9,10,12,21,28] rootPS)) = affineNative (2^(14+1) ^^^ 13624) := by decide +kernel

theorem selectedBound4220 : packedSelected [0,2,3,6,9,10,12,21,28] rootPS < 2^1333 := by decide +kernel

def env4221 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,13624,13495,1344,0,524288,13624,4097,8201,5456,5530,8329,16,8460,1345,4096,8461,1284,4294967296,5137,4295500840,1345,136]

theorem envBound4221 : H12AffineFastState.Bounded env4221 := by
  intro p hp
  have h : env4221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4220_4221 : H12AffineEnvironment.transform 14 13624 env4220 = env4221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13624 env4220 == env4221) = true)

def env4222 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,13624,13495,1344,0,1024,13624,4097,8201,5456,5530,8329,16,8460,1345,4096,8461,1284,4294967296,5137,4294975528,1345,136]

theorem envBound4222 : H12AffineFastState.Bounded env4222 := by
  intro p hp
  have h : env4222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4221_4222 : H12AffineEnvironment.transform 18 1024 env4221 = env4222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4221 == env4222) = true)

theorem identity4222 : scanCanonicalize (H12AffineFastState.compose env4222 (packedSelected [4,9] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4222 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env4223 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,8192,1345,8232,8615,1344,0,1024,8232,1297,8201,64,138,8329,16,8460,1345,1296,8461,1284,4294967296,257,4294975528,1345,136]

theorem envBound4223 : H12AffineFastState.Bounded env4223 := by
  intro p hp
  have h : env4223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4222_4223 : H12AffineEnvironment.transform 11 1296 env4222 = env4223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4222 == env4223) = true)

theorem identity4223 : scanCanonicalize (H12AffineFastState.compose env4223 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 8692) := by decide +kernel

theorem selectedBound4223 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4224 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,8192,1345,8232,8615,1344,0,1024,8232,1297,8201,64,138,8329,16,8460,1345,1296,8461,1284,8692,257,476,1345,136]

theorem envBound4224 : H12AffineFastState.Bounded env4224 := by
  intro p hp
  have h : env4224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4223_4224 : H12AffineEnvironment.transform 31 8692 env4223 = env4224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8692 env4223 == env4224) = true)

theorem identity4224 : scanCanonicalize (H12AffineFastState.compose env4224 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4224 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4225 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,1045,8192,1092,8232,8354,1093,0,1024,8232,1044,8201,64,138,8329,16,8201,1092,1045,8200,1025,8433,4,217,1092,136]

theorem envBound4225 : H12AffineFastState.Bounded env4225 := by
  intro p hp
  have h : env4225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4224_4225 : H12AffineEnvironment.transform 7 5 env4224 = env4225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4224 == env4225) = true)

theorem identity4225 : scanCanonicalize (H12AffineFastState.compose env4225 (packedSelected [1,13] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound4225 : packedSelected [1,13] rootPS < 2^1333 := by decide +kernel

def env4226 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,1045,8,1092,32,170,1093,0,1024,32,1044,1,64,138,129,16,1,1092,1045,0,1025,249,4,217,1092,136]

theorem envBound4226 : H12AffineFastState.Bounded env4226 := by
  intro p hp
  have h : env4226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4225_4226 : H12AffineEnvironment.transform 12 8 env4225 = env4226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env4225 == env4226) = true)

def env4227 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1045,8,1092,0,138,1093,0,1024,0,1044,1,64,138,129,16,1,1092,1045,0,1025,217,4,217,1092,136]

theorem envBound4227 : H12AffineFastState.Bounded env4227 := by
  intro p hp
  have h : env4227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4226_4227 : H12AffineEnvironment.transform 4 0 env4226 = env4227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4226 == env4227) = true)

theorem identity4227 : scanCanonicalize (H12AffineFastState.compose env4227 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound4227 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4228 : List Nat := [2,4,8,16,0,64,128,5,137,14,0,27,8,74,0,138,75,0,14,0,26,1,64,138,129,16,1,74,27,0,15,217,4,217,74,136]

theorem envBound4228 : H12AffineFastState.Bounded env4228 := by
  intro p hp
  have h : env4228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4227_4228 : H12AffineEnvironment.transform 9 14 env4227 = env4228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env4227 == env4228) = true)

def leafEnv4228 : List Nat := [2,4,8,16,0,64,128,5,137,14,0,27,8,74,0,138,75,0,14,0,26,1,64,138,14,129,1,16,1,74,27,0,15,217,4,217,4,3,74,136,0,27,1]

def active4228 : List Nat := [0,1,2,3,5,6]

def tree4228 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4228 : H12WitnessSearch.Good tree4228 := H12GlobalWitnessIndex.good

theorem leafIdentity4228 : H12AffineFastState.composeSystem env4228 rootObs = leafEnv4228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4228 rootObs == leafEnv4228) = true)

theorem terminalChecked4228 : H12PackedTerminal.terminalCheckFast leafEnv4228 active4228 tree4228 = true := by decide +kernel

def env4229 : List Nat := [2,4,8,16,1,64,128,5,137,1024,0,1045,8,1092,1,139,1093,0,1024,1,1044,1,64,138,129,16,1,1092,1045,0,1025,216,4,217,1092,136]

theorem envBound4229 : H12AffineFastState.Bounded env4229 := by
  intro p hp
  have h : env4229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4226_4229 : H12AffineEnvironment.transform 4 1 env4226 = env4229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4226 == env4229) = true)

theorem identity4229 : scanCanonicalize (H12AffineFastState.compose env4229 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 135) := by decide +kernel

theorem selectedBound4229 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4230 : List Nat := [2,4,8,16,1,64,128,5,137,135,0,146,8,195,1,139,194,0,135,1,147,1,64,138,129,16,1,195,146,0,134,216,4,217,195,136]

theorem envBound4230 : H12AffineFastState.Bounded env4230 := by
  intro p hp
  have h : env4230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4229_4230 : H12AffineEnvironment.transform 9 135 env4229 = env4230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 135 env4229 == env4230) = true)

theorem identity4230 : scanCanonicalize (H12AffineFastState.compose env4230 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound4230 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4231 : List Nat := [2,4,8,16,1,64,89,5,80,94,0,75,8,26,1,82,27,0,94,1,74,1,64,83,88,16,1,26,75,0,95,1,4,0,26,81]

theorem envBound4231 : H12AffineFastState.Bounded env4231 := by
  intro p hp
  have h : env4231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4230_4231 : H12AffineEnvironment.transform 6 89 env4230 = env4231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env4230 == env4231) = true)

def leafEnv4231 : List Nat := [2,4,8,16,1,64,89,5,80,94,0,75,8,26,1,82,27,0,94,1,74,1,64,83,94,88,1,16,1,26,75,0,95,1,4,0,4,2,26,81,0,75,1]

def active4231 : List Nat := [0,1,2,3,5]

def tree4231 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4231 : H12WitnessSearch.Good tree4231 := H12GlobalWitnessIndex.good

theorem leafIdentity4231 : H12AffineFastState.composeSystem env4231 rootObs = leafEnv4231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4231 rootObs == leafEnv4231) = true)

theorem terminalChecked4231 : H12PackedTerminal.terminalCheckFast leafEnv4231 active4231 tree4231 = true := by decide +kernel

def env4232 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,13624,13495,1344,0,1025,13624,4097,8201,5456,5530,8329,16,8460,1345,4096,8461,1284,4294967296,5137,4294975529,1345,136]

theorem envBound4232 : H12AffineFastState.Bounded env4232 := by
  intro p hp
  have h : env4232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4221_4232 : H12AffineEnvironment.transform 18 1025 env4221 = env4232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4221 == env4232) = true)

theorem identity4232 : scanCanonicalize (H12AffineFastState.compose env4232 (packedSelected [10,13] rootPS)) = affineNative (2^(12+1) ^^^ 5432) := by decide +kernel

theorem selectedBound4232 : packedSelected [10,13] rootPS < 2^1333 := by decide +kernel

def env4233 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5432,4177,0,399,1344,0,1025,0,4097,5425,5456,5530,5553,16,5172,1345,4096,5173,1284,4294967296,5137,4294972689,1345,136]

theorem envBound4233 : H12AffineFastState.Bounded env4233 := by
  intro p hp
  have h : env4233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4232_4233 : H12AffineEnvironment.transform 12 5432 env4232 = env4233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5432 env4232 == env4233) = true)

def env4234 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,40,1345,0,399,1344,0,1025,0,1297,33,64,138,161,16,292,1345,1296,293,1284,4294967296,257,4294967297,1345,136]

theorem envBound4234 : H12AffineFastState.Bounded env4234 := by
  intro p hp
  have h : env4234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4233_4234 : H12AffineEnvironment.transform 11 1296 env4233 = env4234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4233 == env4234) = true)

theorem identity4234 : scanCanonicalize (H12AffineFastState.compose env4234 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound4234 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4235 : List Nat := [2,4,8,16,32,64,40,256,33,1024,0,1296,40,1345,0,295,1344,0,1025,0,1297,33,64,34,9,16,292,1345,1296,293,1284,4294967296,257,4294967297,1345,32]

theorem envBound4235 : H12AffineFastState.Bounded env4235 := by
  intro p hp
  have h : env4235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4234_4235 : H12AffineEnvironment.transform 6 40 env4234 = env4235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env4234 == env4235) = true)

theorem identity4235 : scanCanonicalize (H12AffineFastState.compose env4235 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 340) := by decide +kernel

theorem selectedBound4235 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4236 : List Nat := [2,4,8,16,32,64,40,256,33,1024,0,1296,40,1345,0,295,1344,0,1025,0,1297,33,64,34,9,16,292,1345,1296,293,1284,340,257,341,1345,32]

theorem envBound4236 : H12AffineFastState.Bounded env4236 := by
  intro p hp
  have h : env4236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4235_4236 : H12AffineEnvironment.transform 31 340 env4235 = env4236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 340 env4235 == env4236) = true)

theorem identity4236 : scanCanonicalize (H12AffineFastState.compose env4236 (packedSelected [4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4236 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4237 : List Nat := [2,4,8,16,32,64,40,5,33,1024,0,1045,40,1092,0,34,1093,0,1025,0,1044,33,64,34,9,16,33,1092,1045,32,1025,81,4,80,1092,32]

theorem envBound4237 : H12AffineFastState.Bounded env4237 := by
  intro p hp
  have h : env4237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4236_4237 : H12AffineEnvironment.transform 7 5 env4236 = env4237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4236 == env4237) = true)

theorem identity4237 : scanCanonicalize (H12AffineFastState.compose env4237 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound4237 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4238 : List Nat := [2,4,8,16,32,64,40,5,33,46,0,59,40,106,0,34,107,0,47,0,58,33,64,34,9,16,33,106,59,32,47,81,4,80,106,32]

theorem envBound4238 : H12AffineFastState.Bounded env4238 := by
  intro p hp
  have h : env4238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4237_4238 : H12AffineEnvironment.transform 9 46 env4237 = env4238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env4237 == env4238) = true)

theorem identity4238 : scanCanonicalize (H12AffineFastState.compose env4238 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4238 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4239 : List Nat := [2,4,8,16,0,64,8,5,1,14,0,27,8,74,0,2,75,0,15,0,26,1,64,2,9,16,1,74,27,0,15,81,4,80,74,0]

theorem envBound4239 : H12AffineFastState.Bounded env4239 := by
  intro p hp
  have h : env4239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4238_4239 : H12AffineEnvironment.transform 4 0 env4238 = env4239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4238 == env4239) = true)

def leafEnv4239 : List Nat := [2,4,8,16,0,64,8,5,1,14,0,27,8,74,0,2,75,0,15,0,26,1,64,2,15,9,1,16,1,74,27,0,15,81,4,80,4,3,74,0,0,27,1]

def active4239 : List Nat := [0,1,2,3,5]

def tree4239 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4239 : H12WitnessSearch.Good tree4239 := H12GlobalWitnessIndex.good

theorem leafIdentity4239 : H12AffineFastState.composeSystem env4239 rootObs = leafEnv4239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4239 rootObs == leafEnv4239) = true)

theorem terminalChecked4239 : H12PackedTerminal.terminalCheckFast leafEnv4239 active4239 tree4239 = true := by decide +kernel

def env4240 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,41,1344,0,399,1344,0,1025,0,1296,32,65,139,160,16,293,1345,1297,292,1284,4294967296,256,4294967296,1345,136]

theorem envBound4240 : H12AffineFastState.Bounded env4240 := by
  intro p hp
  have h : env4240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4233_4240 : H12AffineEnvironment.transform 11 1297 env4233 = env4240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4233 == env4240) = true)

theorem identity4240 : scanCanonicalize (H12AffineFastState.compose env4240 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 277) := by decide +kernel

theorem selectedBound4240 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4241 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,41,1344,0,399,1344,0,1025,0,1296,32,65,139,160,16,293,1345,1297,292,1284,277,256,277,1345,136]

theorem envBound4241 : H12AffineFastState.Bounded env4241 := by
  intro p hp
  have h : env4241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4240_4241 : H12AffineEnvironment.transform 31 277 env4240 = env4241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 277 env4240 == env4241) = true)

theorem identity4241 : scanCanonicalize (H12AffineFastState.compose env4241 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound4241 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4242 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1077,41,1124,0,171,1124,0,1025,0,1076,32,65,139,160,16,1,1125,1077,0,1056,49,36,49,1125,136]

theorem envBound4242 : H12AffineFastState.Bounded env4242 := by
  intro p hp
  have h : env4242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4241_4242 : H12AffineEnvironment.transform 7 36 env4241 = env4242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4241 == env4242) = true)

theorem identity4242 : scanCanonicalize (H12AffineFastState.compose env4242 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 115) := by decide +kernel

theorem selectedBound4242 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4243 : List Nat := [2,4,8,16,32,64,115,36,122,1024,0,1077,41,1124,0,88,1124,0,1025,0,1076,32,65,120,83,16,1,1125,1077,0,1056,49,36,49,1125,123]

theorem envBound4243 : H12AffineFastState.Bounded env4243 := by
  intro p hp
  have h : env4243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4242_4243 : H12AffineEnvironment.transform 6 115 env4242 = env4243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 115 env4242 == env4243) = true)

theorem identity4243 : scanCanonicalize (H12AffineFastState.compose env4243 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound4243 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4244 : List Nat := [2,4,8,16,32,11,56,36,49,1024,0,1077,41,1071,0,19,1071,0,1025,0,1076,32,10,51,24,16,1,1070,1077,0,1056,49,36,49,1070,48]

theorem envBound4244 : H12AffineFastState.Bounded env4244 := by
  intro p hp
  have h : env4244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4243_4244 : H12AffineEnvironment.transform 5 11 env4243 = env4244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env4243 == env4244) = true)

theorem identity4244 : scanCanonicalize (H12AffineFastState.compose env4244 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4244 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4245 : List Nat := [2,4,8,11,32,11,35,36,42,1024,0,1070,41,1071,0,8,1071,0,1025,0,1071,32,10,40,3,11,1,1070,1070,0,1056,42,36,42,1070,43]

theorem envBound4245 : H12AffineFastState.Bounded env4245 := by
  intro p hp
  have h : env4245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4244_4245 : H12AffineEnvironment.transform 3 11 env4244 = env4245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4244 == env4245) = true)

theorem identity4245 : scanCanonicalize (H12AffineFastState.compose env4245 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4245 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4246 : List Nat := [2,4,8,11,11,11,8,15,1,1024,0,1029,2,1028,0,8,1028,0,1025,0,1028,11,10,3,3,11,1,1029,1029,0,1035,1,15,1,1029,0]

theorem envBound4246 : H12AffineFastState.Bounded env4246 := by
  intro p hp
  have h : env4246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4245_4246 : H12AffineEnvironment.transform 4 11 env4245 = env4246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4245 == env4246) = true)

def env4247 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,13886,1344,1,524288,32768,4097,8201,5456,16777216,8329,16818747,8461,16820074,16822827,38588,1284,4294967296,16823866,4295529369,1345,513]

theorem envBound4247 : H12AffineFastState.Bounded env4247 := by
  intro p hp
  have h : env4247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4217_4247 : H12AffineEnvironment.transform 17 1 env4217 = env4247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4217 == env4247) = true)

theorem identity4247 : scanCanonicalize (H12AffineFastState.compose env4247 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 33574) := by decide +kernel

theorem selectedBound4247 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4248 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,13886,1344,1,524288,32768,4097,8201,5456,33574,8329,8477,8461,9292,12557,38588,1284,4294967296,13596,4295529369,1345,513]

theorem envBound4248 : H12AffineFastState.Bounded env4248 := by
  intro p hp
  have h : env4248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4247_4248 : H12AffineEnvironment.transform 23 33574 env4247 = env4248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 33574 env4247 == env4248) = true)

theorem identity4248 : scanCanonicalize (H12AffineFastState.compose env4248 (packedSelected [9,22,23] rootPS)) = affineNative (2^(14+1) ^^^ 5172) := by decide +kernel

theorem selectedBound4248 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4249 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,5172,13886,1344,1,524288,5172,4097,8201,5456,5906,8329,8477,8461,9292,12557,648,1284,4294967296,13596,4295493549,1345,513]

theorem envBound4249 : H12AffineFastState.Bounded env4249 := by
  intro p hp
  have h : env4249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4248_4249 : H12AffineEnvironment.transform 14 5172 env4248 = env4249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5172 env4248 == env4249) = true)

theorem identity4249 : scanCanonicalize (H12AffineFastState.compose env4249 (packedSelected [1,3,5,8,12,13,15,17,18,20] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound4249 : packedSelected [1,3,5,8,12,13,15,17,18,20] rootPS < 2^1333 := by decide +kernel

def env4250 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4177,5172,5563,1344,1,524288,5172,4097,908,5456,5906,780,664,648,1993,4744,648,1284,4294967296,5785,4295493549,1345,513]

theorem envBound4250 : H12AffineFastState.Bounded env4250 := by
  intro p hp
  have h : env4250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4249_4250 : H12AffineEnvironment.transform 12 901 env4249 = env4250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env4249 == env4250) = true)

theorem identity4250 : scanCanonicalize (H12AffineFastState.compose env4250 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound4250 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env4251 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4177,5172,5563,1344,1,1025,5172,4097,908,5456,5906,780,664,648,1993,4744,648,1284,4294967296,5785,4294968236,1345,513]

theorem envBound4251 : H12AffineFastState.Bounded env4251 := by
  intro p hp
  have h : env4251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4250_4251 : H12AffineEnvironment.transform 18 1025 env4250 = env4251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4250 == env4251) = true)

theorem identity4251 : scanCanonicalize (H12AffineFastState.compose env4251 (packedSelected [0,2,6,9] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound4251 : packedSelected [0,2,6,9] rootPS < 2^1333 := by decide +kernel

def env4252 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,901,1993,940,547,1344,1,1025,940,1945,908,712,138,780,664,648,1993,1296,648,1284,4294967296,257,4294968236,1345,513]

theorem envBound4252 : H12AffineFastState.Bounded env4252 := by
  intro p hp
  have h : env4252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4251_4252 : H12AffineEnvironment.transform 11 1944 env4251 = env4252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env4251 == env4252) = true)

theorem identity4252 : scanCanonicalize (H12AffineFastState.compose env4252 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 760) := by decide +kernel

theorem selectedBound4252 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4253 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,901,1993,940,547,1344,1,1025,940,1945,908,712,138,780,664,648,1993,1296,648,1284,760,257,340,1345,513]

theorem envBound4253 : H12AffineFastState.Bounded env4253 := by
  intro p hp
  have h : env4253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4252_4253 : H12AffineEnvironment.transform 31 760 env4252 = env4253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 760 env4252 == env4253) = true)

theorem identity4253 : scanCanonicalize (H12AffineFastState.compose env4253 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4253 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4254 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,268,1344,293,170,1344,1,1025,293,1296,261,65,138,389,17,1,1344,1296,1,1284,113,257,340,1345,136]

theorem envBound4254 : H12AffineFastState.Bounded env4254 := by
  intro p hp
  have h : env4254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4253_4254 : H12AffineEnvironment.transform 8 137 env4253 = env4254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4253 == env4254) = true)

theorem identity4254 : scanCanonicalize (H12AffineFastState.compose env4254 (packedSelected [1,2] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound4254 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env4255 : List Nat := [2,4,8,16,32,64,121,256,112,1024,0,1297,268,1344,293,83,1344,1,1025,293,1296,261,65,115,380,17,1,1344,1296,1,1284,113,257,340,1345,113]

theorem envBound4255 : H12AffineFastState.Bounded env4255 := by
  intro p hp
  have h : env4255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4254_4255 : H12AffineEnvironment.transform 6 121 env4254 = env4255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env4254 == env4255) = true)

theorem identity4255 : scanCanonicalize (H12AffineFastState.compose env4255 (packedSelected [1,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4255 : packedSelected [1,4] rootPS < 2^1333 := by decide +kernel

def env4256 : List Nat := [2,4,8,16,32,64,121,5,112,1024,0,1044,9,1093,32,83,1093,1,1025,32,1045,0,65,115,121,17,1,1093,1045,1,1025,113,4,81,1092,113]

theorem envBound4256 : H12AffineFastState.Bounded env4256 := by
  intro p hp
  have h : env4256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4255_4256 : H12AffineEnvironment.transform 7 5 env4255 = env4256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4255 == env4256) = true)

theorem identity4256 : scanCanonicalize (H12AffineFastState.compose env4256 (packedSelected [0,1] rootPS)) = affineNative (2^(9+1) ^^^ 94) := by decide +kernel

theorem selectedBound4256 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env4257 : List Nat := [2,4,8,16,32,64,121,5,112,94,0,74,9,27,32,83,27,1,95,32,75,0,65,115,121,17,1,27,75,1,95,113,4,81,26,113]

theorem envBound4257 : H12AffineFastState.Bounded env4257 := by
  intro p hp
  have h : env4257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4256_4257 : H12AffineEnvironment.transform 9 94 env4256 = env4257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 94 env4256 == env4257) = true)

theorem identity4257 : scanCanonicalize (H12AffineFastState.compose env4257 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4257 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4258 : List Nat := [2,4,8,16,1,64,88,5,81,94,0,74,9,27,1,83,27,1,95,1,75,0,65,82,88,17,1,27,75,1,95,80,4,81,26,80]

theorem envBound4258 : H12AffineFastState.Bounded env4258 := by
  intro p hp
  have h : env4258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4257_4258 : H12AffineEnvironment.transform 4 1 env4257 = env4258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4257 == env4258) = true)

def env4259 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8201,5456,16777216,8329,16880645,270604,16879956,16876565,106627,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4259 : H12AffineFastState.Bounded env4259 := by
  intro p hp
  have h : env4259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4215_4259 : H12AffineEnvironment.transform 10 1 env4215 = env4259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4215 == env4259) = true)

theorem identity4259 : scanCanonicalize (H12AffineFastState.compose env4259 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 13855) := by decide +kernel

theorem selectedBound4259 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4260 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8201,5456,13855,8329,107034,270604,108363,111114,106627,1284,4294967296,112155,4295599527,1345,513]

theorem envBound4260 : H12AffineFastState.Bounded env4260 := by
  intro p hp
  have h : env4260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4259_4260 : H12AffineEnvironment.transform 23 13855 env4259 = env4260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 13855 env4259 == env4260) = true)

def env4261 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1344,0,524288,32768,4097,8201,5456,13855,8329,107034,8460,108363,111114,106627,1284,4294967296,112155,4295599527,1345,513]

theorem envBound4261 : H12AffineFastState.Bounded env4261 := by
  intro p hp
  have h : env4261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4260_4261 : H12AffineEnvironment.transform 17 0 env4260 = env4261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4260 == env4261) = true)

theorem identity4261 : scanCanonicalize (H12AffineFastState.compose env4261 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 13495) := by decide +kernel

theorem selectedBound4261 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4262 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,13495,1344,0,524288,32768,4097,8201,5456,13855,8329,38573,8460,37884,34493,37940,1284,4294967296,33452,4295528720,1345,513]

theorem envBound4262 : H12AffineFastState.Bounded env4262 := by
  intro p hp
  have h : env4262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4261_4262 : H12AffineEnvironment.transform 15 13495 env4261 = env4262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13495 env4261 == env4262) = true)

theorem identity4262 : scanCanonicalize (H12AffineFastState.compose env4262 (packedSelected [1,5,9,15,20,21,22] rootPS)) = affineNative (2^(14+1) ^^^ 13624) := by decide +kernel

theorem selectedBound4262 : packedSelected [1,5,9,15,20,21,22] rootPS < 2^1333 := by decide +kernel

def env4263 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,13624,13495,1344,0,524288,13624,4097,8201,5456,13855,8329,9109,8460,9924,13189,8460,1284,4294967296,14228,4295500840,1345,513]

theorem envBound4263 : H12AffineFastState.Bounded env4263 := by
  intro p hp
  have h : env4263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4262_4263 : H12AffineEnvironment.transform 14 13624 env4262 = env4263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13624 env4262 == env4263) = true)

theorem identity4263 : scanCanonicalize (H12AffineFastState.compose env4263 (packedSelected [1,3,5,8,12,13,15,17,20] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound4263 : packedSelected [1,3,5,8,12,13,15,17,20] rootPS < 2^1333 := by decide +kernel

def env4264 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,8192,1993,8864,9007,1344,0,524288,8864,1945,8201,712,8583,8329,9109,8460,9924,9245,8460,1284,4294967296,8204,4295500840,1345,513]

theorem envBound4264 : H12AffineFastState.Bounded env4264 := by
  intro p hp
  have h : env4264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4263_4264 : H12AffineEnvironment.transform 11 1944 env4263 = env4264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env4263 == env4264) = true)

theorem identity4264 : scanCanonicalize (H12AffineFastState.compose env4264 (packedSelected [4,9,23] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound4264 : packedSelected [4,9,23] rootPS < 2^1333 := by decide +kernel

def env4265 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,900,1993,292,171,1344,0,524288,292,1945,909,712,515,781,17,648,1344,1945,648,1284,4294967296,904,4295493548,1345,513]

theorem envBound4265 : H12AffineFastState.Bounded env4265 := by
  intro p hp
  have h : env4265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4264_4265 : H12AffineEnvironment.transform 12 900 env4264 = env4265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env4264 == env4265) = true)

def env4266 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,900,1993,292,171,1344,0,1024,292,1945,909,712,515,781,17,648,1344,1945,648,1284,4294967296,904,4294968236,1345,513]

theorem envBound4266 : H12AffineFastState.Bounded env4266 := by
  intro p hp
  have h : env4266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4265_4266 : H12AffineEnvironment.transform 18 1024 env4265 = env4266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4265 == env4266) = true)

theorem identity4266 : scanCanonicalize (H12AffineFastState.compose env4266 (packedSelected [4,9] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4266 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env4267 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1344,292,171,1344,0,1024,292,1296,260,65,138,388,17,1,1344,1296,1,1284,4294967296,257,4294967589,1345,136]

theorem envBound4267 : H12AffineFastState.Bounded env4267 := by
  intro p hp
  have h : env4267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4266_4267 : H12AffineEnvironment.transform 8 137 env4266 = env4267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4266 == env4267) = true)

theorem identity4267 : scanCanonicalize (H12AffineFastState.compose env4267 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 248) := by decide +kernel

theorem selectedBound4267 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4268 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1344,292,171,1344,0,1024,292,1296,260,65,138,388,17,1,1344,1296,1,1284,248,257,477,1345,136]

theorem envBound4268 : H12AffineFastState.Bounded env4268 := by
  intro p hp
  have h : env4268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4267_4268 : H12AffineEnvironment.transform 31 248 env4267 = env4268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 248 env4267 == env4268) = true)

theorem identity4268 : scanCanonicalize (H12AffineFastState.compose env4268 (packedSelected [0,1,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4268 : packedSelected [0,1,4] rootPS < 2^1333 := by decide +kernel

def env4269 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,1044,8,1093,33,171,1093,0,1024,33,1045,1,65,138,129,17,1,1093,1045,1,1025,248,4,216,1092,136]

theorem envBound4269 : H12AffineFastState.Bounded env4269 := by
  intro p hp
  have h : env4269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4268_4269 : H12AffineEnvironment.transform 7 5 env4268 = env4269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4268 == env4269) = true)

def env4270 : List Nat := [2,4,8,16,0,64,128,5,137,1024,1,1044,8,1093,1,139,1093,0,1024,1,1045,1,65,138,129,17,1,1093,1045,1,1025,216,4,216,1092,136]

theorem envBound4270 : H12AffineFastState.Bounded env4270 := by
  intro p hp
  have h : env4270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4269_4270 : H12AffineEnvironment.transform 4 0 env4269 = env4270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4269 == env4270) = true)

theorem identity4270 : scanCanonicalize (H12AffineFastState.compose env4270 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 135) := by decide +kernel

theorem selectedBound4270 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4271 : List Nat := [2,4,8,16,0,64,128,5,137,135,1,147,8,194,1,139,194,0,135,1,146,1,65,138,129,17,1,194,146,1,134,216,4,216,195,136]

theorem envBound4271 : H12AffineFastState.Bounded env4271 := by
  intro p hp
  have h : env4271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4270_4271 : H12AffineEnvironment.transform 9 135 env4270 = env4271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 135 env4270 == env4271) = true)

theorem identity4271 : scanCanonicalize (H12AffineFastState.compose env4271 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound4271 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4272 : List Nat := [2,4,8,16,0,16,128,5,137,135,1,147,8,146,1,139,146,0,135,1,146,1,17,138,129,17,1,146,146,1,134,136,4,136,147,136]

theorem envBound4272 : H12AffineFastState.Bounded env4272 := by
  intro p hp
  have h : env4272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4271_4272 : H12AffineEnvironment.transform 5 16 env4271 = env4272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4271 == env4272) = true)

def leafEnv4272 : List Nat := [2,4,8,16,0,16,128,5,137,135,1,147,8,146,1,139,146,0,135,1,146,1,17,138,135,129,1,17,1,146,146,1,134,136,4,136,4,2,147,136,0,146,1]

def active4272 : List Nat := [0,1,2,3,6]

def tree4272 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4272 : H12WitnessSearch.Good tree4272 := H12GlobalWitnessIndex.good

theorem leafIdentity4272 : H12AffineFastState.composeSystem env4272 rootObs = leafEnv4272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4272 rootObs == leafEnv4272) = true)

theorem terminalChecked4272 : H12PackedTerminal.terminalCheckFast leafEnv4272 active4272 tree4272 = true := by decide +kernel

def env4273 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,1044,8,1093,0,138,1093,0,1024,0,1045,1,65,138,129,17,1,1093,1045,1,1025,217,4,216,1092,136]

theorem envBound4273 : H12AffineFastState.Bounded env4273 := by
  intro p hp
  have h : env4273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4269_4273 : H12AffineEnvironment.transform 4 1 env4269 = env4273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4269 == env4273) = true)

theorem identity4273 : scanCanonicalize (H12AffineFastState.compose env4273 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound4273 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4274 : List Nat := [2,4,8,16,1,64,128,5,137,14,1,26,8,75,0,138,75,0,14,0,27,1,65,138,129,17,1,75,27,1,15,217,4,216,74,136]

theorem envBound4274 : H12AffineFastState.Bounded env4274 := by
  intro p hp
  have h : env4274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4273_4274 : H12AffineEnvironment.transform 9 14 env4273 = env4274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env4273 == env4274) = true)

theorem identity4274 : scanCanonicalize (H12AffineFastState.compose env4274 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4274 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4275 : List Nat := [2,4,8,16,1,64,8,5,1,14,1,26,8,75,0,2,75,0,14,0,27,1,65,2,9,17,1,75,27,1,15,81,4,80,74,0]

theorem envBound4275 : H12AffineFastState.Bounded env4275 := by
  intro p hp
  have h : env4275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4274_4275 : H12AffineEnvironment.transform 6 8 env4274 = env4275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4274 == env4275) = true)

def leafEnv4275 : List Nat := [2,4,8,16,1,64,8,5,1,14,1,26,8,75,0,2,75,0,14,0,27,1,65,2,14,9,1,17,1,75,27,1,15,81,4,80,4,3,74,0,0,27,1]

def active4275 : List Nat := [0,1,2,3,5]

def tree4275 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4275 : H12WitnessSearch.Good tree4275 := H12GlobalWitnessIndex.good

theorem leafIdentity4275 : H12AffineFastState.composeSystem env4275 rootObs = leafEnv4275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4275 rootObs == leafEnv4275) = true)

theorem terminalChecked4275 : H12PackedTerminal.terminalCheckFast leafEnv4275 active4275 tree4275 = true := by decide +kernel

def env4276 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,900,1993,292,171,1344,0,1025,292,1945,909,712,515,781,17,648,1344,1945,648,1284,4294967296,904,4294968237,1345,513]

theorem envBound4276 : H12AffineFastState.Bounded env4276 := by
  intro p hp
  have h : env4276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4265_4276 : H12AffineEnvironment.transform 18 1025 env4265 = env4276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4265 == env4276) = true)

theorem identity4276 : scanCanonicalize (H12AffineFastState.compose env4276 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound4276 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env4277 : List Nat := [2,4,8,16,32,64,128,256,429,1024,1,1077,41,1124,292,171,1344,0,1025,292,1076,32,357,430,160,17,293,1344,1076,293,1284,4294967296,37,4294967296,1345,428]

theorem envBound4277 : H12AffineFastState.Bounded env4277 := by
  intro p hp
  have h : env4277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4276_4277 : H12AffineEnvironment.transform 8 429 env4276 = env4277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env4276 == env4277) = true)

def env4278 : List Nat := [2,4,8,16,32,64,128,256,429,440,1,397,41,476,292,171,248,0,441,292,396,32,357,430,160,17,293,248,396,293,188,4294967296,37,4294967296,249,428]

theorem envBound4278 : H12AffineFastState.Bounded env4278 := by
  intro p hp
  have h : env4278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4277_4278 : H12AffineEnvironment.transform 9 440 env4277 = env4278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 440 env4277 == env4278) = true)

theorem identity4278 : scanCanonicalize (H12AffineFastState.compose env4278 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound4278 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4279 : List Nat := [2,4,8,16,32,64,128,256,429,440,1,397,41,476,292,171,248,0,441,292,396,32,357,430,160,17,293,248,396,293,188,75,37,75,249,428]

theorem envBound4279 : H12AffineFastState.Bounded env4279 := by
  intro p hp
  have h : env4279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4278_4279 : H12AffineEnvironment.transform 31 75 env4278 = env4279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env4278 == env4279) = true)

def env4280 : List Nat := [2,4,8,16,32,64,128,36,137,156,1,169,41,248,0,171,248,0,157,0,168,32,65,138,160,17,1,248,168,1,188,75,37,75,249,136]

theorem envBound4280 : H12AffineFastState.Bounded env4280 := by
  intro p hp
  have h : env4280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4279_4280 : H12AffineEnvironment.transform 7 36 env4279 = env4280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4279 == env4280) = true)

theorem identity4280 : scanCanonicalize (H12AffineFastState.compose env4280 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound4280 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4281 : List Nat := [2,4,8,16,27,64,128,31,137,156,1,146,18,195,0,144,195,0,157,0,147,27,65,138,155,17,1,195,147,1,135,75,30,75,194,136]

theorem envBound4281 : H12AffineFastState.Bounded env4281 := by
  intro p hp
  have h : env4281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4280_4281 : H12AffineEnvironment.transform 4 27 env4280 = env4281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env4280 == env4281) = true)

theorem identity4281 : scanCanonicalize (H12AffineFastState.compose env4281 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound4281 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4282 : List Nat := [2,4,8,16,27,64,18,31,27,14,1,0,18,81,0,2,81,0,15,0,1,27,65,24,9,17,1,81,1,1,21,75,30,75,80,26]

theorem envBound4282 : H12AffineFastState.Bounded env4282 := by
  intro p hp
  have h : env4282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4281_4282 : H12AffineEnvironment.transform 6 18 env4281 = env4282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env4281 == env4282) = true)

theorem identity4282 : scanCanonicalize (H12AffineFastState.compose env4282 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4282 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4283 : List Nat := [2,4,8,10,1,64,8,5,1,14,1,0,8,75,0,2,75,0,15,0,1,1,65,2,9,11,1,75,1,1,15,75,4,75,74,0]

theorem envBound4283 : H12AffineFastState.Bounded env4283 := by
  intro p hp
  have h : env4283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4282_4283 : H12AffineEnvironment.transform 3 10 env4282 = env4283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4282 == env4283) = true)

def leafEnv4283 : List Nat := [2,4,8,10,1,64,8,5,1,14,1,0,8,75,0,2,75,0,15,0,1,1,65,2,15,9,1,11,1,75,1,1,15,75,4,75,4,3,74,0,0,1,1]

def active4283 : List Nat := [0,1,2,5]

def tree4283 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4283 : H12WitnessSearch.Good tree4283 := H12GlobalWitnessIndex.good

theorem leafIdentity4283 : H12AffineFastState.composeSystem env4283 rootObs = leafEnv4283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4283 rootObs == leafEnv4283) = true)

theorem terminalChecked4283 : H12PackedTerminal.terminalCheckFast leafEnv4283 active4283 tree4283 = true := by decide +kernel

def env4284 : List Nat := [2,4,8,16,32,64,128,37,136,157,1,168,41,249,1,171,248,0,156,1,169,32,64,139,160,17,0,248,169,0,188,75,37,75,249,137]

theorem envBound4284 : H12AffineFastState.Bounded env4284 := by
  intro p hp
  have h : env4284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4279_4284 : H12AffineEnvironment.transform 7 37 env4279 = env4284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4279 == env4284) = true)

theorem identity4284 : scanCanonicalize (H12AffineFastState.compose env4284 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 33) := by decide +kernel

theorem selectedBound4284 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4285 : List Nat := [2,4,8,16,32,33,128,37,136,157,1,168,41,152,1,171,153,0,156,1,169,32,33,139,160,17,0,153,169,0,188,42,37,42,152,137]

theorem envBound4285 : H12AffineFastState.Bounded env4285 := by
  intro p hp
  have h : env4285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4284_4285 : H12AffineEnvironment.transform 5 33 env4284 = env4285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env4284 == env4285) = true)

theorem identity4285 : scanCanonicalize (H12AffineFastState.compose env4285 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4285 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4286 : List Nat := [2,4,8,16,10,11,128,15,136,157,1,130,3,152,1,129,153,0,156,1,131,10,11,139,138,17,0,153,131,0,150,0,15,0,152,137]

theorem envBound4286 : H12AffineFastState.Bounded env4286 := by
  intro p hp
  have h : env4286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4285_4286 : H12AffineEnvironment.transform 4 10 env4285 = env4286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4285 == env4286) = true)

def env4287 : List Nat := [2,4,8,16,32,64,128,256,429,441,1,396,41,477,292,171,249,0,440,292,397,32,357,430,160,17,293,249,397,293,189,4294967296,37,4294967296,248,428]

theorem envBound4287 : H12AffineFastState.Bounded env4287 := by
  intro p hp
  have h : env4287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4277_4287 : H12AffineEnvironment.transform 9 441 env4277 = env4287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 441 env4277 == env4287) = true)

theorem identity4287 : scanCanonicalize (H12AffineFastState.compose env4287 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 366) := by decide +kernel

theorem selectedBound4287 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4288 : List Nat := [2,4,8,16,32,64,128,256,429,441,1,396,41,477,292,171,249,0,440,292,397,32,357,430,160,17,293,249,397,293,189,366,37,366,248,428]

theorem envBound4288 : H12AffineFastState.Bounded env4288 := by
  intro p hp
  have h : env4288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4287_4288 : H12AffineEnvironment.transform 31 366 env4287 = env4288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 366 env4287 == env4288) = true)

def env4289 : List Nat := [2,4,8,16,32,64,128,36,137,157,1,168,41,249,0,171,249,0,156,0,169,32,65,138,160,17,1,249,169,1,189,74,37,74,248,136]

theorem envBound4289 : H12AffineFastState.Bounded env4289 := by
  intro p hp
  have h : env4289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4288_4289 : H12AffineEnvironment.transform 7 36 env4288 = env4289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4288 == env4289) = true)

theorem identity4289 : scanCanonicalize (H12AffineFastState.compose env4289 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound4289 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4290 : List Nat := [2,4,8,16,26,64,128,30,137,157,1,146,19,195,0,145,195,0,156,0,147,26,65,138,154,17,1,195,147,1,135,74,31,74,194,136]

theorem envBound4290 : H12AffineFastState.Bounded env4290 := by
  intro p hp
  have h : env4290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4289_4290 : H12AffineEnvironment.transform 4 26 env4289 = env4290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env4289 == env4290) = true)

theorem identity4290 : scanCanonicalize (H12AffineFastState.compose env4290 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound4290 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4291 : List Nat := [2,4,8,16,26,64,19,30,26,14,1,1,19,80,0,2,80,0,15,0,0,26,65,25,9,17,1,80,0,1,20,74,31,74,81,27]

theorem envBound4291 : H12AffineFastState.Bounded env4291 := by
  intro p hp
  have h : env4291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4290_4291 : H12AffineEnvironment.transform 6 19 env4290 = env4291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env4290 == env4291) = true)

theorem identity4291 : scanCanonicalize (H12AffineFastState.compose env4291 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4291 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4292 : List Nat := [2,4,8,11,1,64,8,5,1,14,1,1,8,75,0,2,75,0,15,0,0,1,65,2,9,10,1,75,0,1,15,74,4,74,74,0]

theorem envBound4292 : H12AffineFastState.Bounded env4292 := by
  intro p hp
  have h : env4292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4291_4292 : H12AffineEnvironment.transform 3 11 env4291 = env4292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4291 == env4292) = true)

def leafEnv4292 : List Nat := [2,4,8,11,1,64,8,5,1,14,1,1,8,75,0,2,75,0,15,0,0,1,65,2,15,9,1,10,1,75,0,1,15,74,4,74,4,3,74,0,0,0,1]

def active4292 : List Nat := [0,1,2,5]

def tree4292 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4292 : H12WitnessSearch.Good tree4292 := H12GlobalWitnessIndex.good

theorem leafIdentity4292 : H12AffineFastState.composeSystem env4292 rootObs = leafEnv4292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4292 rootObs == leafEnv4292) = true)

theorem terminalChecked4292 : H12PackedTerminal.terminalCheckFast leafEnv4292 active4292 tree4292 = true := by decide +kernel

def env4293 : List Nat := [2,4,8,16,32,64,128,37,136,156,1,169,41,248,1,171,249,0,157,1,168,32,64,139,160,17,0,249,168,0,189,75,37,75,248,137]

theorem envBound4293 : H12AffineFastState.Bounded env4293 := by
  intro p hp
  have h : env4293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4288_4293 : H12AffineEnvironment.transform 7 37 env4288 = env4293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4288 == env4293) = true)

theorem identity4293 : scanCanonicalize (H12AffineFastState.compose env4293 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 33) := by decide +kernel

theorem selectedBound4293 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4294 : List Nat := [2,4,8,16,32,33,128,37,136,156,1,169,41,153,1,171,152,0,157,1,168,32,33,139,160,17,0,152,168,0,189,42,37,42,153,137]

theorem envBound4294 : H12AffineFastState.Bounded env4294 := by
  intro p hp
  have h : env4294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4293_4294 : H12AffineEnvironment.transform 5 33 env4293 = env4294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env4293 == env4294) = true)

theorem identity4294 : scanCanonicalize (H12AffineFastState.compose env4294 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4294 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4295 : List Nat := [2,4,8,16,10,11,128,15,136,156,1,131,3,153,1,129,152,0,157,1,130,10,11,139,138,17,0,152,130,0,151,0,15,0,153,137]

theorem envBound4295 : H12AffineFastState.Bounded env4295 := by
  intro p hp
  have h : env4295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4294_4295 : H12AffineEnvironment.transform 4 10 env4294 = env4295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4294 == env4295) = true)

def env4296 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1344,1,524288,32768,4097,8201,5456,13855,8329,107034,8461,108363,111114,106627,1284,4294967296,112155,4295599527,1345,513]

theorem envBound4296 : H12AffineFastState.Bounded env4296 := by
  intro p hp
  have h : env4296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4260_4296 : H12AffineEnvironment.transform 17 1 env4260 = env4296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4260 == env4296) = true)

theorem identity4296 : scanCanonicalize (H12AffineFastState.compose env4296 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 5562) := by decide +kernel

theorem selectedBound4296 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4297 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,5562,1344,1,524288,32768,4097,8201,5456,13855,8329,47008,8461,45809,42928,46393,1284,4294967296,41889,4295536669,1345,513]

theorem envBound4297 : H12AffineFastState.Bounded env4297 := by
  intro p hp
  have h : env4297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4296_4297 : H12AffineEnvironment.transform 15 5562 env4296 = env4297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5562 env4296 == env4297) = true)

theorem identity4297 : scanCanonicalize (H12AffineFastState.compose env4297 (packedSelected [9,22,23] rootPS)) = affineNative (2^(14+1) ^^^ 5173) := by decide +kernel

theorem selectedBound4297 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4298 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,5173,5562,1344,1,524288,5173,4097,8201,5456,13855,8329,9109,8461,9924,13189,8460,1284,4294967296,14228,4295500840,1345,513]

theorem envBound4298 : H12AffineFastState.Bounded env4298 := by
  intro p hp
  have h : env4298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4297_4298 : H12AffineEnvironment.transform 14 5173 env4297 = env4298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5173 env4297 == env4298) = true)

theorem identity4298 : scanCanonicalize (H12AffineFastState.compose env4298 (packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS)) = affineNative (2^(12+1) ^^^ 5780) := by decide +kernel

theorem selectedBound4298 : packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4299 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5780,4177,5173,5562,1344,1,524288,5173,4097,5789,5456,139,5661,5377,6041,4176,1297,6040,1284,4294967296,256,4295496380,1345,513]

theorem envBound4299 : H12AffineFastState.Bounded env4299 := by
  intro p hp
  have h : env4299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4298_4299 : H12AffineEnvironment.transform 12 5780 env4298 = env4299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5780 env4298 == env4299) = true)

theorem identity4299 : scanCanonicalize (H12AffineFastState.compose env4299 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 1965) := by decide +kernel

theorem selectedBound4299 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4300 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5780,4177,5173,5562,1344,1,1965,5173,4097,5789,5456,139,5661,5377,6041,4176,1297,6040,1284,4294967296,256,4294972689,1345,513]

theorem envBound4300 : H12AffineFastState.Bounded env4300 := by
  intro p hp
  have h : env4300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4299_4300 : H12AffineEnvironment.transform 18 1965 env4299 = env4300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1965 env4299 == env4300) = true)

theorem identity4300 : scanCanonicalize (H12AffineFastState.compose env4300 (packedSelected [4,9] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound4300 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env4301 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1076,672,1125,1,398,1344,1,1965,1,1077,681,356,139,553,309,941,1124,1297,940,1284,4294967296,256,4294967589,1345,513]

theorem envBound4301 : H12AffineFastState.Bounded env4301 := by
  intro p hp
  have h : env4301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4300_4301 : H12AffineEnvironment.transform 11 1076 env4300 = env4301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env4300 == env4301) = true)

theorem identity4301 : scanCanonicalize (H12AffineFastState.compose env4301 (packedSelected [0,2,4,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 271) := by decide +kernel

theorem selectedBound4301 : packedSelected [0,2,4,10,12,13] rootPS < 2^1333 := by decide +kernel

def env4302 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1076,672,1125,1,398,1344,1,1965,1,1077,681,356,139,553,309,941,1124,1297,940,1284,271,256,42,1345,513]

theorem envBound4302 : H12AffineFastState.Bounded env4302 := by
  intro p hp
  have h : env4302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4301_4302 : H12AffineEnvironment.transform 31 271 env4301 = env4302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 271 env4301 == env4302) = true)

theorem identity4302 : scanCanonicalize (H12AffineFastState.compose env4302 (packedSelected [0,2,3,4,5,10,18] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4302 : packedSelected [0,2,3,4,5,10,18] rootPS < 2^1333 := by decide +kernel

def env4303 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1076,41,1125,1,398,1344,1,1316,1,1077,32,356,139,160,309,292,1124,1297,293,1284,271,256,42,1345,136]

theorem envBound4303 : H12AffineFastState.Bounded env4303 := by
  intro p hp
  have h : env4303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4302_4303 : H12AffineEnvironment.transform 8 137 env4302 = env4303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4302 == env4303) = true)

theorem identity4303 : scanCanonicalize (H12AffineFastState.compose env4303 (packedSelected [0,1,3] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound4303 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env4304 : List Nat := [2,4,8,16,32,64,57,256,48,1024,1,1076,41,1125,1,311,1344,1,1316,1,1077,32,356,50,25,309,292,1124,1297,293,1284,271,256,42,1345,49]

theorem envBound4304 : H12AffineFastState.Bounded env4304 := by
  intro p hp
  have h : env4304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4303_4304 : H12AffineEnvironment.transform 6 57 env4303 = env4304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env4303 == env4304) = true)

theorem identity4304 : scanCanonicalize (H12AffineFastState.compose env4304 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4304 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4305 : List Nat := [2,4,8,16,32,17,57,256,48,1024,1,1076,41,1076,1,311,1297,1,1316,1,1077,32,309,50,25,309,292,1077,1297,293,1284,271,256,42,1296,49]

theorem envBound4305 : H12AffineFastState.Bounded env4305 := by
  intro p hp
  have h : env4305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4304_4305 : H12AffineEnvironment.transform 5 17 env4304 = env4305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4304 == env4305) = true)

theorem identity4305 : scanCanonicalize (H12AffineFastState.compose env4305 (packedSelected [0,12] rootPS)) = affineNative (2^(9+1) ^^^ 272) := by decide +kernel

theorem selectedBound4305 : packedSelected [0,12] rootPS < 2^1333 := by decide +kernel

def env4306 : List Nat := [2,4,8,16,32,17,57,256,48,272,1,292,41,292,1,311,1,1,52,1,293,32,309,50,25,309,292,293,1,293,20,271,256,42,0,49]

theorem envBound4306 : H12AffineFastState.Bounded env4306 := by
  intro p hp
  have h : env4306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4305_4306 : H12AffineEnvironment.transform 9 272 env4305 = env4306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 272 env4305 == env4306) = true)

theorem identity4306 : scanCanonicalize (H12AffineFastState.compose env4306 (packedSelected [1,2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4306 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env4307 : List Nat := [2,4,8,11,32,10,34,256,43,267,1,292,41,292,1,300,1,1,47,1,293,32,302,41,2,302,292,293,1,293,15,271,256,42,0,42]

theorem envBound4307 : H12AffineFastState.Bounded env4307 := by
  intro p hp
  have h : env4307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4306_4307 : H12AffineEnvironment.transform 3 11 env4306 = env4307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4306 == env4307) = true)

theorem identity4307 : scanCanonicalize (H12AffineFastState.compose env4307 (packedSelected [1,5] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound4307 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env4308 : List Nat := [2,4,8,11,32,10,34,14,43,5,1,42,41,42,1,34,1,1,47,1,43,32,32,41,2,32,42,43,1,43,15,1,14,42,0,42]

theorem envBound4308 : H12AffineFastState.Bounded env4308 := by
  intro p hp
  have h : env4308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4307_4308 : H12AffineEnvironment.transform 7 14 env4307 = env4308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env4307 == env4308) = true)

def env4309 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,1073741824,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4309 : H12AffineFastState.Bounded env4309 := by
  intro p hp
  have h : env4309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4213_4309 : H12AffineEnvironment.transform 16 1345 env4213 = env4309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env4213 == env4309) = true)

theorem identity4309 : scanCanonicalize (H12AffineFastState.compose env4309 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 17313159) := by decide +kernel

theorem selectedBound4309 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4310 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,17313159,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4310 : H12AffineFastState.Bounded env4310 := by
  intro p hp
  have h : env4310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4309_4310 : H12AffineEnvironment.transform 29 17313159 env4309 = env4310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 17313159 env4309 == env4310) = true)

def env4311 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,17311111,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4311 : H12AffineFastState.Bounded env4311 := by
  intro p hp
  have h : env4311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4310_4311 : H12AffineEnvironment.transform 10 0 env4310 = env4311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4310 == env4311) = true)

theorem identity4311 : scanCanonicalize (H12AffineFastState.compose env4311 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 332595) := by decide +kernel

theorem selectedBound4311 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4312 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,262144,332595,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,17118900,1285,4294967296,16875525,4295276180,1344,513]

theorem envBound4312 : H12AffineFastState.Bounded env4312 := by
  intro p hp
  have h : env4312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4311_4312 : H12AffineEnvironment.transform 18 332595 env4311 = env4312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 332595 env4311 == env4312) = true)

def env4313 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4177,32768,65536,1345,262144,332219,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,17118268,1285,4294967296,16875525,4295275548,1344,137]

theorem envBound4313 : H12AffineFastState.Bounded env4313 := by
  intro p hp
  have h : env4313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4312_4313 : H12AffineEnvironment.transform 8 136 env4312 = env4313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4312 == env4313) = true)

theorem identity4313 : scanCanonicalize (H12AffineFastState.compose env4313 (packedSelected [1,4,5,8,9,17,18,21,24] rootPS)) = affineNative (2^(23+1) ^^^ 111896) := by decide +kernel

theorem selectedBound4313 : packedSelected [1,4,5,8,9,17,18,21,24] rootPS < 2^1333 := by decide +kernel

def env4314 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4177,32768,65536,1345,262144,332219,32768,4097,8200,5456,111896,8329,8476,270604,9293,12557,295204,1285,4294967296,13597,4295275548,1344,137]

theorem envBound4314 : H12AffineFastState.Bounded env4314 := by
  intro p hp
  have h : env4314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4313_4314 : H12AffineEnvironment.transform 23 111896 env4313 = env4314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 111896 env4313 == env4314) = true)

theorem identity4314 : scanCanonicalize (H12AffineFastState.compose env4314 (packedSelected [0,2,4,5,6,8,9,10,12,17,22] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound4314 : packedSelected [0,2,4,5,6,8,9,10,12,17,22] rootPS < 2^1333 := by decide +kernel

def env4315 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4177,32768,65536,1345,262144,332219,32768,4097,5141,5456,98565,5268,5377,267537,4176,1296,295204,1285,4294967296,256,4295262209,1344,137]

theorem envBound4315 : H12AffineFastState.Bounded env4315 := by
  intro p hp
  have h : env4315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4314_4315 : H12AffineEnvironment.transform 12 5149 env4314 = env4315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env4314 == env4315) = true)

theorem identity4315 : scanCanonicalize (H12AffineFastState.compose env4315 (packedSelected [0,1,6,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 37940) := by decide +kernel

theorem selectedBound4315 : packedSelected [0,1,6,12,13] rootPS < 2^1333 := by decide +kernel

def env4316 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4177,32768,65536,1345,37940,99727,32768,4097,5141,5456,98565,5268,5377,33061,4176,1296,5392,1285,4294967296,256,4294972469,1344,137]

theorem envBound4316 : H12AffineFastState.Bounded env4316 := by
  intro p hp
  have h : env4316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4315_4316 : H12AffineEnvironment.transform 17 37940 env4315 = env4316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 37940 env4315 == env4316) = true)

def env4317 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4177,476,65536,1345,5608,66643,476,4097,5141,5456,65753,5268,5377,249,4176,1296,5392,1285,4294967296,256,4294972469,1344,137]

theorem envBound4317 : H12AffineFastState.Bounded env4317 := by
  intro p hp
  have h : env4317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4316_4317 : H12AffineEnvironment.transform 14 476 env4316 = env4317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 476 env4316 == env4317) = true)

theorem identity4317 : scanCanonicalize (H12AffineFastState.compose env4317 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound4317 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4318 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1076,41,1125,476,65536,1345,476,66643,476,1077,33,356,65753,160,309,249,1124,1296,292,1285,4294967296,256,4294967297,1344,137]

theorem envBound4318 : H12AffineFastState.Bounded env4318 := by
  intro p hp
  have h : env4318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4317_4318 : H12AffineEnvironment.transform 11 1076 env4317 = env4318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env4317 == env4318) = true)

theorem identity4318 : scanCanonicalize (H12AffineFastState.compose env4318 (packedSelected [0,1,2,4,7,10,12] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound4318 : packedSelected [0,1,2,4,7,10,12] rootPS < 2^1333 := by decide +kernel

def env4319 : List Nat := [2,4,8,16,32,64,128,221,136,1024,0,1076,41,1125,1,65536,1180,1,66643,1,1077,33,185,65753,160,232,249,1124,1229,249,1240,4294967296,221,4294967297,1181,137]

theorem envBound4319 : H12AffineFastState.Bounded env4319 := by
  intro p hp
  have h : env4319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4318_4319 : H12AffineEnvironment.transform 7 221 env4318 = env4319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env4318 == env4319) = true)

theorem identity4319 : scanCanonicalize (H12AffineFastState.compose env4319 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound4319 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4320 : List Nat := [2,4,8,16,32,64,121,36,113,1024,0,1076,41,1125,1,65536,1125,1,66643,1,1077,33,64,65568,89,17,0,1124,1076,0,1057,4294967296,36,4294967297,1124,112]

theorem envBound4320 : H12AffineFastState.Bounded env4320 := by
  intro p hp
  have h : env4320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4319_4320 : H12AffineEnvironment.transform 6 121 env4319 = env4320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env4319 == env4320) = true)

theorem identity4320 : scanCanonicalize (H12AffineFastState.compose env4320 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound4320 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4321 : List Nat := [2,4,8,16,32,64,121,36,113,1024,0,1076,41,1125,1,65536,1125,1,66643,1,1077,33,64,65568,89,17,0,1124,1076,0,1057,43,36,42,1124,112]

theorem envBound4321 : H12AffineFastState.Bounded env4321 := by
  intro p hp
  have h : env4321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4320_4321 : H12AffineEnvironment.transform 31 43 env4320 = env4321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env4320 == env4321) = true)

theorem identity4321 : scanCanonicalize (H12AffineFastState.compose env4321 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4321 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4322 : List Nat := [2,4,8,16,32,0,57,36,49,1024,0,1076,41,1061,1,65536,1061,1,66579,1,1077,33,0,65568,25,17,0,1060,1076,0,1057,43,36,42,1060,48]

theorem envBound4322 : H12AffineFastState.Bounded env4322 := by
  intro p hp
  have h : env4322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4321_4322 : H12AffineEnvironment.transform 5 0 env4321 = env4322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4321 == env4322) = true)

def env4323 : List Nat := [2,4,8,16,32,0,57,36,49,1024,0,1076,41,1061,1,56,1061,1,1067,1,1077,33,0,24,25,17,0,1060,1076,0,1057,43,36,42,1060,48]

theorem envBound4323 : H12AffineFastState.Bounded env4323 := by
  intro p hp
  have h : env4323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4322_4323 : H12AffineEnvironment.transform 15 56 env4322 = env4323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 56 env4322 == env4323) = true)

def env4324 : List Nat := [2,4,8,16,0,0,25,4,17,1024,0,1044,9,1029,1,24,1029,1,1035,1,1045,1,0,24,25,17,0,1028,1044,0,1025,11,4,10,1028,16]

theorem envBound4324 : H12AffineFastState.Bounded env4324 := by
  intro p hp
  have h : env4324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4323_4324 : H12AffineEnvironment.transform 4 0 env4323 = env4324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4323 == env4324) = true)

theorem identity4324 : scanCanonicalize (H12AffineFastState.compose env4324 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4324 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4325 : List Nat := [2,4,2,16,0,0,19,4,17,1024,0,1044,3,1029,1,18,1029,1,1025,1,1045,1,0,18,19,17,0,1028,1044,0,1025,1,4,0,1028,16]

theorem envBound4325 : H12AffineFastState.Bounded env4325 := by
  intro p hp
  have h : env4325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4324_4325 : H12AffineEnvironment.transform 2 2 env4324 = env4325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4324 == env4325) = true)

def leafEnv4325 : List Nat := [2,4,2,16,0,0,19,4,17,1024,0,1044,3,1029,1,18,1029,1,1025,1,1045,1,0,18,1024,19,1,17,0,1028,1044,0,1025,1,4,0,4,3,1028,16,0,1045,1]

def active4325 : List Nat := [0,1,3,9]

def tree4325 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4325 : H12WitnessSearch.Good tree4325 := H12GlobalWitnessIndex.good

theorem leafIdentity4325 : H12AffineFastState.composeSystem env4325 rootObs = leafEnv4325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4325 rootObs == leafEnv4325) = true)

theorem terminalChecked4325 : H12PackedTerminal.terminalCheckFast leafEnv4325 active4325 tree4325 = true := by decide +kernel

def env4326 : List Nat := [2,4,8,16,1,0,24,5,16,1024,0,1045,8,1028,1,25,1028,1,1034,1,1044,0,0,24,25,17,0,1029,1045,0,1024,10,5,11,1029,17]

theorem envBound4326 : H12AffineFastState.Bounded env4326 := by
  intro p hp
  have h : env4326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4323_4326 : H12AffineEnvironment.transform 4 1 env4323 = env4326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4323 == env4326) = true)

def leafEnv4326 : List Nat := [2,4,8,16,1,0,24,5,16,1024,0,1045,8,1028,1,25,1028,1,1034,1,1044,0,0,24,1034,25,1,17,0,1029,1045,0,1024,10,5,11,4,2,1029,17,0,1044,1]

def active4326 : List Nat := [0,1,2,3,9]

def tree4326 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4326 : H12WitnessSearch.Good tree4326 := H12GlobalWitnessIndex.good

theorem leafIdentity4326 : H12AffineFastState.composeSystem env4326 rootObs = leafEnv4326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4326 rootObs == leafEnv4326) = true)

theorem terminalChecked4326 : H12PackedTerminal.terminalCheckFast leafEnv4326 active4326 tree4326 = true := by decide +kernel

def env4327 : List Nat := [2,4,8,16,32,0,57,36,49,1024,0,1076,41,1061,1,57,1061,1,1066,1,1077,33,0,25,25,17,0,1060,1076,0,1057,43,36,42,1060,48]

theorem envBound4327 : H12AffineFastState.Bounded env4327 := by
  intro p hp
  have h : env4327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4322_4327 : H12AffineEnvironment.transform 15 57 env4322 = env4327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 57 env4322 == env4327) = true)

theorem identity4327 : scanCanonicalize (H12AffineFastState.compose env4327 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4327 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4328 : List Nat := [2,4,8,16,11,0,18,15,26,1024,0,1055,2,1038,1,18,1038,1,1025,1,1054,10,0,25,25,17,0,1039,1055,0,1034,0,15,1,1039,27]

theorem envBound4328 : H12AffineFastState.Bounded env4328 := by
  intro p hp
  have h : env4328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4327_4328 : H12AffineEnvironment.transform 4 11 env4327 = env4328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4327 == env4328) = true)

def leafEnv4328 : List Nat := [2,4,8,16,11,0,18,15,26,1024,0,1055,2,1038,1,18,1038,1,1025,1,1054,10,0,25,1035,25,1,17,0,1039,1055,0,1034,0,15,1,4,8,1039,27,0,1054,1]

def active4328 : List Nat := [0,1,2,3,9]

def tree4328 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4328 : H12WitnessSearch.Good tree4328 := H12GlobalWitnessIndex.good

theorem leafIdentity4328 : H12AffineFastState.composeSystem env4328 rootObs = leafEnv4328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4328 rootObs == leafEnv4328) = true)

theorem terminalChecked4328 : H12PackedTerminal.terminalCheckFast leafEnv4328 active4328 tree4328 = true := by decide +kernel

def env4329 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4177,477,65536,1345,5609,66642,477,4097,5141,5456,65752,5268,5377,248,4176,1296,5392,1285,4294967296,256,4294972469,1344,137]

theorem envBound4329 : H12AffineFastState.Bounded env4329 := by
  intro p hp
  have h : env4329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4316_4329 : H12AffineEnvironment.transform 14 477 env4316 = env4329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 477 env4316 == env4329) = true)

theorem identity4329 : scanCanonicalize (H12AffineFastState.compose env4329 (packedSelected [5] rootPS)) = affineNative (2^(15+1) ^^^ 5223) := by decide +kernel

theorem selectedBound4329 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4330 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5149,4177,477,5223,1345,5609,4149,477,4097,5141,5456,5311,5268,5377,248,4176,1296,5392,1285,4294967296,256,4294972469,1344,137]

theorem envBound4330 : H12AffineFastState.Bounded env4330 := by
  intro p hp
  have h : env4330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4329_4330 : H12AffineEnvironment.transform 15 5223 env4329 = env4330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5223 env4329 == env4330) = true)

theorem identity4330 : scanCanonicalize (H12AffineFastState.compose env4330 (packedSelected [0,1,2,4,7,10,12] rootPS)) = affineNative (2^(7+1) ^^^ 220) := by decide +kernel

theorem selectedBound4330 : packedSelected [0,1,2,4,7,10,12] rootPS < 2^1333 := by decide +kernel

def env4331 : List Nat := [2,4,8,16,32,64,128,220,136,1024,0,4096,5149,4177,1,5223,1181,5173,4149,1,4097,5141,5260,5311,5268,5341,248,4176,1228,5324,1241,4294967296,220,4294972469,1180,137]

theorem envBound4331 : H12AffineFastState.Bounded env4331 := by
  intro p hp
  have h : env4331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4330_4331 : H12AffineEnvironment.transform 7 220 env4330 = env4331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 220 env4330 == env4331) = true)

def env4332 : List Nat := [2,4,8,16,32,64,8,84,0,1024,0,4096,5149,4177,1,5223,1045,5173,4149,1,4097,5141,5124,5175,5148,5205,112,4176,1092,5188,1105,4294967296,84,4294972469,1044,1]

theorem envBound4332 : H12AffineFastState.Bounded env4332 := by
  intro p hp
  have h : env4332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4331_4332 : H12AffineEnvironment.transform 6 8 env4331 = env4332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4331 == env4332) = true)

theorem identity4332 : scanCanonicalize (H12AffineFastState.compose env4332 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 5151) := by decide +kernel

theorem selectedBound4332 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4333 : List Nat := [2,4,8,16,32,64,8,84,0,1024,0,4096,5149,4177,1,5223,1045,5173,4149,1,4097,5141,5124,5175,5148,5205,112,4176,1092,5188,1105,5151,84,42,1044,1]

theorem envBound4333 : H12AffineFastState.Bounded env4333 := by
  intro p hp
  have h : env4333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4332_4333 : H12AffineEnvironment.transform 31 5151 env4332 = env4333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5151 env4332 == env4333) = true)

def env4334 : List Nat := [2,4,8,16,32,16,8,4,0,1024,0,4096,5149,4097,1,5175,1045,5173,4149,1,4097,5141,5124,5175,5148,5125,32,4096,1044,5140,1025,5151,4,42,1044,1]

theorem envBound4334 : H12AffineFastState.Bounded env4334 := by
  intro p hp
  have h : env4334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4333_4334 : H12AffineEnvironment.transform 5 16 env4333 = env4334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4333 == env4334) = true)

theorem identity4334 : scanCanonicalize (H12AffineFastState.compose env4334 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4334 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4335 : List Nat := [2,4,8,16,0,16,8,4,0,1024,0,4096,5149,4097,1,5143,1045,5141,4117,1,4097,5141,5124,5143,5148,5125,0,4096,1044,5140,1025,5151,4,10,1044,1]

theorem envBound4335 : H12AffineFastState.Bounded env4335 := by
  intro p hp
  have h : env4335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4334_4335 : H12AffineEnvironment.transform 4 0 env4334 = env4335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4334 == env4335) = true)

theorem identity4335 : scanCanonicalize (H12AffineFastState.compose env4335 (packedSelected [7] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound4335 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4336 : List Nat := [2,4,8,16,0,16,8,4,0,1024,0,1044,9,1045,1,3,1045,1,1025,1,1045,1,16,3,8,17,0,1044,1044,0,1025,11,4,10,1044,1]

theorem envBound4336 : H12AffineFastState.Bounded env4336 := by
  intro p hp
  have h : env4336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4335_4336 : H12AffineEnvironment.transform 11 1044 env4335 = env4336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env4335 == env4336) = true)

theorem identity4336 : scanCanonicalize (H12AffineFastState.compose env4336 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4336 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4337 : List Nat := [2,4,8,0,0,0,8,4,0,1024,0,1028,9,1029,1,3,1029,1,1025,1,1029,1,0,3,8,1,0,1028,1028,0,1025,11,4,10,1028,1]

theorem envBound4337 : H12AffineFastState.Bounded env4337 := by
  intro p hp
  have h : env4337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4336_4337 : H12AffineEnvironment.transform 3 0 env4336 = env4337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4336 == env4337) = true)

def leafEnv4337 : List Nat := [2,4,8,0,0,0,8,4,0,1024,0,1028,9,1029,1,3,1029,1,1025,1,1029,1,0,3,1024,8,1,1,0,1028,1028,0,1025,11,4,10,4,3,1028,1,0,1029,1]

def active4337 : List Nat := [0,1,2,9]

def tree4337 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4337 : H12WitnessSearch.Good tree4337 := H12GlobalWitnessIndex.good

theorem leafIdentity4337 : H12AffineFastState.composeSystem env4337 rootObs = leafEnv4337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4337 rootObs == leafEnv4337) = true)

theorem terminalChecked4337 : H12PackedTerminal.terminalCheckFast leafEnv4337 active4337 tree4337 = true := by decide +kernel

def env4338 : List Nat := [2,4,8,16,32,17,8,5,0,1024,0,4096,5149,4096,1,5174,1045,5173,4149,1,4097,5141,5124,5175,5148,5124,33,4097,1045,5141,1024,5151,5,42,1044,1]

theorem envBound4338 : H12AffineFastState.Bounded env4338 := by
  intro p hp
  have h : env4338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4333_4338 : H12AffineEnvironment.transform 5 17 env4333 = env4338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4333 == env4338) = true)

theorem identity4338 : scanCanonicalize (H12AffineFastState.compose env4338 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound4338 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4339 : List Nat := [2,4,8,16,32,17,8,5,0,1024,0,1045,8,1045,1,35,1045,32,1056,1,1044,0,17,34,9,17,33,1044,1045,0,1024,10,5,42,1044,1]

theorem envBound4339 : H12AffineFastState.Bounded env4339 := by
  intro p hp
  have h : env4339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4338_4339 : H12AffineEnvironment.transform 11 1045 env4338 = env4339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env4338 == env4339) = true)

theorem identity4339 : scanCanonicalize (H12AffineFastState.compose env4339 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4339 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4340 : List Nat := [2,4,8,16,1,17,8,5,0,1024,0,1045,8,1045,1,2,1045,1,1025,1,1044,0,17,3,9,17,0,1044,1045,0,1024,10,5,11,1044,1]

theorem envBound4340 : H12AffineFastState.Bounded env4340 := by
  intro p hp
  have h : env4340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4339_4340 : H12AffineEnvironment.transform 4 1 env4339 = env4340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4339 == env4340) = true)

theorem identity4340 : scanCanonicalize (H12AffineFastState.compose env4340 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4340 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4341 : List Nat := [2,4,8,1,1,0,8,5,0,1024,0,1028,8,1028,1,2,1028,1,1025,1,1029,0,0,3,9,0,0,1029,1028,0,1024,10,5,11,1029,1]

theorem envBound4341 : H12AffineFastState.Bounded env4341 := by
  intro p hp
  have h : env4341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4340_4341 : H12AffineEnvironment.transform 3 1 env4340 = env4341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4340 == env4341) = true)

def leafEnv4341 : List Nat := [2,4,8,1,1,0,8,5,0,1024,0,1028,8,1028,1,2,1028,1,1025,1,1029,0,0,3,1025,9,1,0,0,1029,1028,0,1024,10,5,11,4,2,1029,1,0,1029,1]

def active4341 : List Nat := [0,1,2,9]

def tree4341 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4341 : H12WitnessSearch.Good tree4341 := H12GlobalWitnessIndex.good

theorem leafIdentity4341 : H12AffineFastState.composeSystem env4341 rootObs = leafEnv4341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4341 rootObs == leafEnv4341) = true)

theorem terminalChecked4341 : H12PackedTerminal.terminalCheckFast leafEnv4341 active4341 tree4341 = true := by decide +kernel

def env4342 : List Nat := [2,4,8,16,32,64,9,85,1,1024,0,4096,5149,4177,1,5223,1044,5173,4149,1,4097,5141,5125,5174,5149,5204,113,4176,1093,5189,1104,4294967296,85,4294972469,1045,0]

theorem envBound4342 : H12AffineFastState.Bounded env4342 := by
  intro p hp
  have h : env4342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4331_4342 : H12AffineEnvironment.transform 6 9 env4331 = env4342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env4331 == env4342) = true)

theorem identity4342 : scanCanonicalize (H12AffineFastState.compose env4342 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound4342 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4343 : List Nat := [2,4,8,16,32,64,9,85,1,1024,0,4096,5149,4177,1,5223,1044,5173,4149,1,4097,5141,5125,5174,5149,5204,113,4176,1093,5189,1104,90,85,5231,1045,0]

theorem envBound4343 : H12AffineFastState.Bounded env4343 := by
  intro p hp
  have h : env4343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4342_4343 : H12AffineEnvironment.transform 31 90 env4342 = env4343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env4342 == env4343) = true)

def env4344 : List Nat := [2,4,8,16,32,16,9,5,1,1024,0,4096,5149,4097,1,5175,1044,5173,4149,1,4097,5141,5125,5174,5149,5124,33,4096,1045,5141,1024,10,5,5183,1045,0]

theorem envBound4344 : H12AffineFastState.Bounded env4344 := by
  intro p hp
  have h : env4344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4343_4344 : H12AffineEnvironment.transform 5 16 env4343 = env4344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4343 == env4344) = true)

theorem identity4344 : scanCanonicalize (H12AffineFastState.compose env4344 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound4344 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4345 : List Nat := [2,4,8,16,32,16,9,5,1,1024,0,1045,8,1044,1,34,1044,32,1056,1,1044,0,16,35,8,17,33,1045,1045,0,1024,10,5,42,1045,0]

theorem envBound4345 : H12AffineFastState.Bounded env4345 := by
  intro p hp
  have h : env4345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4344_4345 : H12AffineEnvironment.transform 11 1045 env4344 = env4345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env4344 == env4345) = true)

theorem identity4345 : scanCanonicalize (H12AffineFastState.compose env4345 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4345 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4346 : List Nat := [2,4,8,16,1,16,9,5,1,1024,0,1045,8,1044,1,3,1044,1,1025,1,1044,0,16,2,8,17,0,1045,1045,0,1024,10,5,11,1045,0]

theorem envBound4346 : H12AffineFastState.Bounded env4346 := by
  intro p hp
  have h : env4346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4345_4346 : H12AffineEnvironment.transform 4 1 env4345 = env4346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4345 == env4346) = true)

theorem identity4346 : scanCanonicalize (H12AffineFastState.compose env4346 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4346 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4347 : List Nat := [2,4,8,0,1,0,9,5,1,1024,0,1029,8,1028,1,3,1028,1,1025,1,1028,0,0,2,8,1,0,1029,1029,0,1024,10,5,11,1029,0]

theorem envBound4347 : H12AffineFastState.Bounded env4347 := by
  intro p hp
  have h : env4347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4346_4347 : H12AffineEnvironment.transform 3 0 env4346 = env4347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4346 == env4347) = true)

def leafEnv4347 : List Nat := [2,4,8,0,1,0,9,5,1,1024,0,1029,8,1028,1,3,1028,1,1025,1,1028,0,0,2,1025,8,1,1,0,1029,1029,0,1024,10,5,11,4,2,1029,0,0,1028,1]

def active4347 : List Nat := [0,1,2,9]

def tree4347 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4347 : H12WitnessSearch.Good tree4347 := H12GlobalWitnessIndex.good

theorem leafIdentity4347 : H12AffineFastState.composeSystem env4347 rootObs = leafEnv4347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4347 rootObs == leafEnv4347) = true)

theorem terminalChecked4347 : H12PackedTerminal.terminalCheckFast leafEnv4347 active4347 tree4347 = true := by decide +kernel

def env4348 : List Nat := [2,4,8,16,32,17,9,4,1,1024,0,4096,5149,4096,1,5174,1044,5173,4149,1,4097,5141,5125,5174,5149,5125,32,4097,1044,5140,1025,11,4,5182,1045,0]

theorem envBound4348 : H12AffineFastState.Bounded env4348 := by
  intro p hp
  have h : env4348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4343_4348 : H12AffineEnvironment.transform 5 17 env4343 = env4348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4343 == env4348) = true)

theorem identity4348 : scanCanonicalize (H12AffineFastState.compose env4348 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4348 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4349 : List Nat := [2,4,8,16,0,17,9,4,1,1024,0,4096,5149,4096,1,5142,1044,5141,4117,1,4097,5141,5125,5142,5149,5125,0,4097,1044,5140,1025,11,4,5150,1045,0]

theorem envBound4349 : H12AffineFastState.Bounded env4349 := by
  intro p hp
  have h : env4349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4348_4349 : H12AffineEnvironment.transform 4 0 env4348 = env4349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4348 == env4349) = true)

theorem identity4349 : scanCanonicalize (H12AffineFastState.compose env4349 (packedSelected [7] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound4349 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4350 : List Nat := [2,4,8,16,0,17,9,4,1,1024,0,1044,9,1044,1,2,1044,1,1025,1,1045,1,17,2,9,17,0,1045,1044,0,1025,11,4,10,1045,0]

theorem envBound4350 : H12AffineFastState.Bounded env4350 := by
  intro p hp
  have h : env4350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4349_4350 : H12AffineEnvironment.transform 11 1044 env4349 = env4350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env4349 == env4350) = true)

theorem identity4350 : scanCanonicalize (H12AffineFastState.compose env4350 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4350 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4351 : List Nat := [2,4,8,1,0,0,9,4,1,1024,0,1029,9,1029,1,2,1029,1,1025,1,1028,1,0,2,9,0,0,1028,1029,0,1025,11,4,10,1028,0]

theorem envBound4351 : H12AffineFastState.Bounded env4351 := by
  intro p hp
  have h : env4351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4350_4351 : H12AffineEnvironment.transform 3 1 env4350 = env4351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4350 == env4351) = true)

def leafEnv4351 : List Nat := [2,4,8,1,0,0,9,4,1,1024,0,1029,9,1029,1,2,1029,1,1025,1,1028,1,0,2,1024,9,1,0,0,1028,1029,0,1025,11,4,10,4,3,1028,0,0,1028,1]

def active4351 : List Nat := [0,1,2,9]

def tree4351 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4351 : H12WitnessSearch.Good tree4351 := H12GlobalWitnessIndex.good

theorem leafIdentity4351 : H12AffineFastState.composeSystem env4351 rootObs = leafEnv4351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4351 rootObs == leafEnv4351) = true)

theorem terminalChecked4351 : H12PackedTerminal.terminalCheckFast leafEnv4351 active4351 tree4351 = true := by decide +kernel

def env4352 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,32768,65536,1345,262144,332218,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,17118269,1285,4294967296,16875525,4295275549,1344,136]

theorem envBound4352 : H12AffineFastState.Bounded env4352 := by
  intro p hp
  have h : env4352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4312_4352 : H12AffineEnvironment.transform 8 137 env4312 = env4352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4312 == env4352) = true)

theorem identity4352 : scanCanonicalize (H12AffineFastState.compose env4352 (packedSelected [1,4,5,8,9,17,18,21,24] rootPS)) = affineNative (2^(17+1) ^^^ 37941) := by decide +kernel

theorem selectedBound4352 : packedSelected [1,4,5,8,9,17,18,21,24] rootPS < 2^1333 := by decide +kernel

def env4353 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,32768,65536,1345,37941,99727,32768,4097,8200,5456,16777216,8329,16880644,46393,16879957,16876565,16883720,1285,4294967296,16875525,4294975528,1344,136]

theorem envBound4353 : H12AffineFastState.Bounded env4353 := by
  intro p hp
  have h : env4353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4352_4353 : H12AffineEnvironment.transform 17 37941 env4352 = env4353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 37941 env4352 == env4353) = true)

theorem identity4353 : scanCanonicalize (H12AffineFastState.compose env4353 (packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 46482) := by decide +kernel

theorem selectedBound4353 : packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4354 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,32768,46482,1345,37941,12317,32768,4097,8200,5456,16777216,8329,16785814,46393,16786631,16789895,16782746,1285,4294967296,16790935,4294975528,1344,136]

theorem envBound4354 : H12AffineFastState.Bounded env4354 := by
  intro p hp
  have h : env4354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4353_4354 : H12AffineEnvironment.transform 15 46482 env4353 = env4354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 46482 env4353 == env4354) = true)

theorem identity4354 : scanCanonicalize (H12AffineFastState.compose env4354 (packedSelected [2,4,6,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound4354 : packedSelected [2,4,6,7,20] rootPS < 2^1333 := by decide +kernel

def env4355 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4177,32768,33167,1345,37941,1024,32768,4097,5141,5456,16777216,5268,16782731,33060,16781530,16778650,16782746,1285,4294967296,16777610,4294972469,1344,136]

theorem envBound4355 : H12AffineFastState.Bounded env4355 := by
  intro p hp
  have h : env4355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4354_4355 : H12AffineEnvironment.transform 12 5149 env4354 = env4355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env4354 == env4355) = true)

theorem identity4355 : scanCanonicalize (H12AffineFastState.compose env4355 (packedSelected [0,2,3,4,5,6,12,13] rootPS)) = affineNative (2^(23+1) ^^^ 38298) := by decide +kernel

theorem selectedBound4355 : packedSelected [0,2,3,4,5,6,12,13] rootPS < 2^1333 := by decide +kernel

def env4356 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4177,32768,33167,1345,37941,1024,32768,4097,5141,5456,38298,5268,32785,33060,34112,36864,32768,1285,4294967296,37904,4294972469,1344,136]

theorem envBound4356 : H12AffineFastState.Bounded env4356 := by
  intro p hp
  have h : env4356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4355_4356 : H12AffineEnvironment.transform 23 38298 env4355 = env4356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 38298 env4355 == env4356) = true)

theorem identity4356 : scanCanonicalize (H12AffineFastState.compose env4356 (packedSelected [0,2,4,5,6,8] rootPS)) = affineNative (2^(14+1) ^^^ 5393) := by decide +kernel

theorem selectedBound4356 : packedSelected [0,2,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env4357 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4177,5393,5278,1345,292,1024,5393,4097,5141,5456,139,5268,5376,5173,4177,1297,5393,1285,4294967296,257,4294972469,1344,136]

theorem envBound4357 : H12AffineFastState.Bounded env4357 := by
  intro p hp
  have h : env4357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4356_4357 : H12AffineEnvironment.transform 14 5393 env4356 = env4357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5393 env4356 == env4357) = true)

theorem identity4357 : scanCanonicalize (H12AffineFastState.compose env4357 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1427) := by decide +kernel

theorem selectedBound4357 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4358 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4177,5393,5278,1345,292,1024,5393,4097,5141,5456,139,5268,5376,5173,4177,1297,5393,1285,1427,257,4518,1344,136]

theorem envBound4358 : H12AffineFastState.Bounded env4358 := by
  intro p hp
  have h : env4358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4357_4358 : H12AffineEnvironment.transform 31 1427 env4357 = env4358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1427 env4357 == env4358) = true)

theorem identity4358 : scanCanonicalize (H12AffineFastState.compose env4358 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1387) := by decide +kernel

theorem selectedBound4358 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4359 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1387,374,1338,122,501,1345,292,1024,122,1386,382,59,139,511,107,350,1338,1297,122,1285,1427,257,1229,1344,136]

theorem envBound4359 : H12AffineFastState.Bounded env4359 := by
  intro p hp
  have h : env4359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4358_4359 : H12AffineEnvironment.transform 11 1387 env4358 = env4359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1387 env4358 == env4359) = true)

theorem identity4359 : scanCanonicalize (H12AffineFastState.compose env4359 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound4359 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4360 : List Nat := [2,4,8,16,26,64,128,256,137,1024,0,1361,332,1280,64,463,1345,286,1024,64,1360,324,1,139,453,81,350,1280,1297,64,1285,1427,257,1229,1344,136]

theorem envBound4360 : H12AffineFastState.Bounded env4360 := by
  intro p hp
  have h : env4360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4359_4360 : H12AffineEnvironment.transform 4 26 env4359 = env4360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env4359 == env4360) = true)

theorem identity4360 : scanCanonicalize (H12AffineFastState.compose env4360 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 21) := by decide +kernel

theorem selectedBound4360 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4361 : List Nat := [2,4,8,16,26,64,128,21,137,1024,0,1092,89,1045,64,218,1108,11,1024,64,1093,81,1,139,208,81,75,1045,1028,64,1040,1158,20,1229,1109,136]

theorem envBound4361 : H12AffineFastState.Bounded env4361 := by
  intro p hp
  have h : env4361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4360_4361 : H12AffineEnvironment.transform 7 21 env4360 = env4361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env4360 == env4361) = true)

theorem identity4361 : scanCanonicalize (H12AffineFastState.compose env4361 (packedSelected [6] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4361 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4362 : List Nat := [2,4,8,16,26,0,128,21,137,1024,0,1028,25,1045,0,154,1044,11,1024,0,1029,17,1,139,144,17,11,1045,1028,0,1040,1158,20,1165,1045,136]

theorem envBound4362 : H12AffineFastState.Bounded env4362 := by
  intro p hp
  have h : env4362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4361_4362 : H12AffineEnvironment.transform 5 0 env4361 = env4362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4361 == env4362) = true)

theorem identity4362 : scanCanonicalize (H12AffineFastState.compose env4362 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 30) := by decide +kernel

theorem selectedBound4362 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4363 : List Nat := [2,4,8,16,26,0,128,21,137,30,0,26,25,11,0,154,10,11,30,0,27,17,1,139,144,17,11,11,26,0,14,152,20,147,11,136]

theorem envBound4363 : H12AffineFastState.Bounded env4363 := by
  intro p hp
  have h : env4363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4362_4363 : H12AffineEnvironment.transform 9 30 env4362 = env4363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 30 env4362 == env4363) = true)

theorem identity4363 : scanCanonicalize (H12AffineFastState.compose env4363 (packedSelected [2,9] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4363 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env4364 : List Nat := [2,4,3,16,17,0,128,21,130,21,0,17,18,0,0,145,1,0,21,0,16,17,1,128,144,17,0,0,17,0,5,147,20,147,0,131]

theorem envBound4364 : H12AffineFastState.Bounded env4364 := by
  intro p hp
  have h : env4364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4363_4364 : H12AffineEnvironment.transform 2 3 env4363 = env4364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4363 == env4364) = true)

theorem identity4364 : scanCanonicalize (H12AffineFastState.compose env4364 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4364 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4365 : List Nat := [2,4,3,0,1,0,128,5,130,5,0,1,2,0,0,129,1,0,5,0,0,1,1,128,128,1,0,0,1,0,5,131,4,131,0,131]

theorem envBound4365 : H12AffineFastState.Bounded env4365 := by
  intro p hp
  have h : env4365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4364_4365 : H12AffineEnvironment.transform 3 0 env4364 = env4365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4364 == env4365) = true)

def env4366 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8200,5456,16777216,8329,16880644,270604,16879957,16876565,17311110,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4366 : H12AffineFastState.Bounded env4366 := by
  intro p hp
  have h : env4366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4310_4366 : H12AffineEnvironment.transform 10 1 env4310 = env4366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4310 == env4366) = true)

theorem identity4366 : scanCanonicalize (H12AffineFastState.compose env4366 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 791314) := by decide +kernel

theorem selectedBound4366 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4367 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8200,5456,791314,8329,886550,270604,885319,890631,276116,1285,4294967296,889623,4295599527,1344,513]

theorem envBound4367 : H12AffineFastState.Bounded env4367 := by
  intro p hp
  have h : env4367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4366_4367 : H12AffineEnvironment.transform 23 791314 env4366 = env4367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 791314 env4366 == env4367) = true)

def env4368 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,0,524288,32768,4097,8200,5456,529170,8329,624406,8460,623175,628487,13972,1285,4294967296,627479,4295599527,1344,513]

theorem envBound4368 : H12AffineFastState.Bounded env4368 := by
  intro p hp
  have h : env4368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4367_4368 : H12AffineEnvironment.transform 17 0 env4367 = env4368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4367 == env4368) = true)

theorem identity4368 : scanCanonicalize (H12AffineFastState.compose env4368 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 940) := by decide +kernel

theorem selectedBound4368 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4369 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,940,65536,1345,0,524288,940,4097,8200,5456,529170,8329,591034,8460,590315,595115,13972,1285,4294967296,594107,4295566859,1344,513]

theorem envBound4369 : H12AffineFastState.Bounded env4369 := by
  intro p hp
  have h : env4369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4368_4369 : H12AffineEnvironment.transform 14 940 env4368 = env4369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 940 env4368 == env4369) = true)

theorem identity4369 : scanCanonicalize (H12AffineFastState.compose env4369 (packedSelected [9,22,23] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound4369 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4370 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4177,940,65536,1345,0,524288,940,4097,908,5456,529170,781,591034,648,590315,595115,5392,1285,4294967296,594107,4295558543,1344,513]

theorem envBound4370 : H12AffineFastState.Bounded env4370 := by
  intro p hp
  have h : env4370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4369_4370 : H12AffineEnvironment.transform 12 900 env4369 = env4370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env4369 == env4370) = true)

theorem identity4370 : scanCanonicalize (H12AffineFastState.compose env4370 (packedSelected [0,1,2,3,4,6,10,13,15,20] rootPS)) = affineNative (2^(18+1) ^^^ 70451) := by decide +kernel

theorem selectedBound4370 : packedSelected [0,1,2,3,4,6,10,13,15,20] rootPS < 2^1333 := by decide +kernel

def env4371 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4177,940,65536,1345,0,70451,940,4097,908,5456,65569,781,6025,648,4824,1944,5392,1285,4294967296,904,4294973116,1344,513]

theorem envBound4371 : H12AffineFastState.Bounded env4371 := by
  intro p hp
  have h : env4371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4370_4371 : H12AffineEnvironment.transform 18 70451 env4370 = env4371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70451 env4370 == env4371) = true)

theorem identity4371 : scanCanonicalize (H12AffineFastState.compose env4371 (packedSelected [1,3,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4371 : packedSelected [1,3,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4372 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,900,1345,940,65536,1345,0,67107,940,1297,908,64,65569,781,665,648,1992,1944,0,1285,4294967296,904,4294968236,1344,513]

theorem envBound4372 : H12AffineFastState.Bounded env4372 := by
  intro p hp
  have h : env4372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4371_4372 : H12AffineEnvironment.transform 11 1296 env4371 = env4372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4371 == env4372) = true)

theorem identity4372 : scanCanonicalize (H12AffineFastState.compose env4372 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4372 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4373 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,268,1345,292,65536,1345,0,66731,292,1297,260,64,65569,389,17,0,1344,1296,0,1285,4294967296,256,4294967588,1344,137]

theorem envBound4373 : H12AffineFastState.Bounded env4373 := by
  intro p hp
  have h : env4373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4372_4373 : H12AffineEnvironment.transform 8 136 env4372 = env4373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4372 == env4373) = true)

theorem identity4373 : scanCanonicalize (H12AffineFastState.compose env4373 (packedSelected [2,3,4,10] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound4373 : packedSelected [2,3,4,10] rootPS < 2^1333 := by decide +kernel

def env4374 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,268,1345,292,170,1345,0,1025,292,1297,260,64,139,389,17,0,1344,1296,0,1285,4294967296,256,4294967588,1344,137]

theorem envBound4374 : H12AffineFastState.Bounded env4374 := by
  intro p hp
  have h : env4374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4373_4374 : H12AffineEnvironment.transform 15 170 env4373 = env4374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env4373 == env4374) = true)

theorem identity4374 : scanCanonicalize (H12AffineFastState.compose env4374 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound4374 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4375 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1077,41,1124,1,170,1124,0,1025,1,1076,33,64,139,160,17,0,1125,1077,0,1056,4294967296,37,4294967297,1125,137]

theorem envBound4375 : H12AffineFastState.Bounded env4375 := by
  intro p hp
  have h : env4375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4374_4375 : H12AffineEnvironment.transform 7 37 env4374 = env4375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4374 == env4375) = true)

theorem identity4375 : scanCanonicalize (H12AffineFastState.compose env4375 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 163) := by decide +kernel

theorem selectedBound4375 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4376 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1077,41,1124,1,170,1124,0,1025,1,1076,33,64,139,160,17,0,1125,1077,0,1056,163,37,162,1125,137]

theorem envBound4376 : H12AffineFastState.Bounded env4376 := by
  intro p hp
  have h : env4376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4375_4376 : H12AffineEnvironment.transform 31 163 env4375 = env4376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 163 env4375 == env4376) = true)

theorem identity4376 : scanCanonicalize (H12AffineFastState.compose env4376 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound4376 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4377 : List Nat := [2,4,8,16,32,64,24,37,16,1024,1,1077,41,1124,1,50,1124,0,1025,1,1076,33,64,19,56,17,0,1125,1077,0,1056,59,37,58,1125,17]

theorem envBound4377 : H12AffineFastState.Bounded env4377 := by
  intro p hp
  have h : env4377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4376_4377 : H12AffineEnvironment.transform 6 24 env4376 = env4377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env4376 == env4377) = true)

theorem identity4377 : scanCanonicalize (H12AffineFastState.compose env4377 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4377 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4378 : List Nat := [2,4,8,16,32,0,24,37,16,1024,1,1077,41,1060,1,50,1060,0,1025,1,1076,33,0,19,56,17,0,1061,1077,0,1056,59,37,58,1061,17]

theorem envBound4378 : H12AffineFastState.Bounded env4378 := by
  intro p hp
  have h : env4378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4377_4378 : H12AffineEnvironment.transform 5 0 env4377 = env4378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4377 == env4378) = true)

def env4379 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1345,1,524288,32768,4097,8200,5456,529171,8329,624407,8461,623174,628486,13973,1285,4294967296,627478,4295599527,1344,513]

theorem envBound4379 : H12AffineFastState.Bounded env4379 := by
  intro p hp
  have h : env4379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4367_4379 : H12AffineEnvironment.transform 17 1 env4367 = env4379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4367 == env4379) = true)

theorem identity4379 : scanCanonicalize (H12AffineFastState.compose env4379 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 8865) := by decide +kernel

theorem selectedBound4379 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4380 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8865,65536,1345,1,524288,8865,4097,8200,5456,529171,8329,599478,8461,598247,603559,13973,1285,4294967296,602551,4295558918,1344,513]

theorem envBound4380 : H12AffineFastState.Bounded env4380 := by
  intro p hp
  have h : env4380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4379_4380 : H12AffineEnvironment.transform 14 8865 env4379 = env4380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8865 env4379 == env4380) = true)

theorem identity4380 : scanCanonicalize (H12AffineFastState.compose env4380 (packedSelected [9,22,23] rootPS)) = affineNative (2^(18+1) ^^^ 78007) := by decide +kernel

theorem selectedBound4380 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4381 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8865,65536,1345,1,78007,8865,4097,8200,5456,74660,8329,5377,8461,4176,1296,13973,1285,4294967296,256,4294981553,1344,513]

theorem envBound4381 : H12AffineFastState.Bounded env4381 := by
  intro p hp
  have h : env4381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4380_4381 : H12AffineEnvironment.transform 18 78007 env4380 = env4381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78007 env4380 == env4381) = true)

theorem identity4381 : scanCanonicalize (H12AffineFastState.compose env4381 (packedSelected [0,1,2,3,6,9,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound4381 : packedSelected [0,1,2,3,6,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4382 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1344,8865,65536,1345,1,75174,8865,1296,8200,65,74660,8329,16,8461,1345,1296,9092,1285,4294967296,256,4294976160,1344,513]

theorem envBound4382 : H12AffineFastState.Bounded env4382 := by
  intro p hp
  have h : env4382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4381_4382 : H12AffineEnvironment.transform 11 1297 env4381 = env4382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4381 == env4382) = true)

theorem identity4382 : scanCanonicalize (H12AffineFastState.compose env4382 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4382 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4383 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,8192,1344,8233,65536,1345,1,75174,8233,1296,8200,65,74028,8329,16,8461,1345,1296,8460,1285,4294967296,256,4294975528,1344,137]

theorem envBound4383 : H12AffineFastState.Bounded env4383 := by
  intro p hp
  have h : env4383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4382_4383 : H12AffineEnvironment.transform 8 136 env4382 = env4383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4382 == env4383) = true)

theorem identity4383 : scanCanonicalize (H12AffineFastState.compose env4383 (packedSelected [1,2,3,4,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound4383 : packedSelected [1,2,3,4,5,10,13] rootPS < 2^1333 := by decide +kernel

def env4384 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,269,1344,292,65536,1345,1,66731,292,1296,261,65,65569,388,16,0,1345,1296,1,1285,4294967296,256,4294967589,1344,137]

theorem envBound4384 : H12AffineFastState.Bounded env4384 := by
  intro p hp
  have h : env4384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4383_4384 : H12AffineEnvironment.transform 12 269 env4383 = env4384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env4383 == env4384) = true)

def env4385 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1077,41,1124,0,65536,1125,1,66731,0,1076,33,65,65569,160,16,0,1125,1076,1,1057,4294967296,36,4294967297,1124,137]

theorem envBound4385 : H12AffineFastState.Bounded env4385 := by
  intro p hp
  have h : env4385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4384_4385 : H12AffineEnvironment.transform 7 36 env4384 = env4385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4384 == env4385) = true)

theorem identity4385 : scanCanonicalize (H12AffineFastState.compose env4385 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65545) := by decide +kernel

theorem selectedBound4385 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4386 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1077,41,1124,0,65536,1125,1,66731,0,1076,33,65,65569,160,16,0,1125,1076,1,1057,65545,36,65544,1124,137]

theorem envBound4386 : H12AffineFastState.Bounded env4386 := by
  intro p hp
  have h : env4386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4385_4386 : H12AffineEnvironment.transform 31 65545 env4385 = env4386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65545 env4385 == env4386) = true)

theorem identity4386 : scanCanonicalize (H12AffineFastState.compose env4386 (packedSelected [1,3,4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4386 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4387 : List Nat := [2,4,8,0,32,64,128,36,136,1024,1,1061,41,1124,0,65536,1125,1,66731,0,1060,33,65,65569,160,0,0,1125,1060,1,1057,65545,36,65544,1124,137]

theorem envBound4387 : H12AffineFastState.Bounded env4387 := by
  intro p hp
  have h : env4387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4386_4387 : H12AffineEnvironment.transform 3 0 env4386 = env4387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4386 == env4387) = true)

def env4388 : List Nat := [2,4,8,0,32,64,128,36,136,1024,1,1061,41,1124,0,192,1125,1,1131,0,1060,33,65,225,160,0,0,1125,1060,1,1057,201,36,200,1124,137]

theorem envBound4388 : H12AffineFastState.Bounded env4388 := by
  intro p hp
  have h : env4388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4387_4388 : H12AffineEnvironment.transform 15 192 env4387 = env4388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 192 env4387 == env4388) = true)

def env4389 : List Nat := [2,4,8,0,32,64,104,36,96,1024,1,1061,41,1124,0,40,1125,1,1131,0,1060,33,65,9,72,0,0,1125,1060,1,1057,33,36,32,1124,97]

theorem envBound4389 : H12AffineFastState.Bounded env4389 := by
  intro p hp
  have h : env4389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4388_4389 : H12AffineEnvironment.transform 6 104 env4388 = env4389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 104 env4388 == env4389) = true)

theorem identity4389 : scanCanonicalize (H12AffineFastState.compose env4389 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound4389 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4390 : List Nat := [2,4,8,0,32,42,2,36,10,1024,1,1061,41,1038,0,40,1039,1,1025,0,1060,33,43,9,34,0,0,1039,1060,1,1057,33,36,32,1038,11]

theorem envBound4390 : H12AffineFastState.Bounded env4390 := by
  intro p hp
  have h : env4390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4389_4390 : H12AffineEnvironment.transform 5 42 env4389 = env4390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env4389 == env4390) = true)

def leafEnv4390 : List Nat := [2,4,8,0,32,42,2,36,10,1024,1,1061,41,1038,0,40,1039,1,1025,0,1060,33,43,9,1056,34,1,0,0,1039,1060,1,1057,33,36,32,4,34,1038,11,0,1061,1]

def active4390 : List Nat := [0,1,2,4,9]

def tree4390 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4390 : H12WitnessSearch.Good tree4390 := H12GlobalWitnessIndex.good

theorem leafIdentity4390 : H12AffineFastState.composeSystem env4390 rootObs = leafEnv4390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4390 rootObs == leafEnv4390) = true)

theorem terminalChecked4390 : H12PackedTerminal.terminalCheckFast leafEnv4390 active4390 tree4390 = true := by decide +kernel

def env4391 : List Nat := [2,4,8,0,32,64,105,36,97,1024,1,1061,41,1124,0,41,1125,1,1131,0,1060,33,65,8,73,0,0,1125,1060,1,1057,32,36,33,1124,96]

theorem envBound4391 : H12AffineFastState.Bounded env4391 := by
  intro p hp
  have h : env4391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4388_4391 : H12AffineEnvironment.transform 6 105 env4388 = env4391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 105 env4388 == env4391) = true)

def env4392 : List Nat := [2,4,8,0,0,64,73,4,65,1024,1,1029,9,1092,0,9,1093,1,1099,0,1028,1,65,8,73,0,0,1093,1028,1,1025,0,4,1,1092,64]

theorem envBound4392 : H12AffineFastState.Bounded env4392 := by
  intro p hp
  have h : env4392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4391_4392 : H12AffineEnvironment.transform 4 0 env4391 = env4392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4391 == env4392) = true)

theorem identity4392 : scanCanonicalize (H12AffineFastState.compose env4392 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound4392 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4393 : List Nat := [2,4,8,0,0,10,3,4,11,1024,1,1029,9,1038,0,9,1039,1,1025,0,1028,1,11,8,3,0,0,1039,1028,1,1025,0,4,1,1038,10]

theorem envBound4393 : H12AffineFastState.Bounded env4393 := by
  intro p hp
  have h : env4393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4392_4393 : H12AffineEnvironment.transform 5 10 env4392 = env4393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env4392 == env4393) = true)

def leafEnv4393 : List Nat := [2,4,8,0,0,10,3,4,11,1024,1,1029,9,1038,0,9,1039,1,1025,0,1028,1,11,8,1024,3,1,0,0,1039,1028,1,1025,0,4,1,4,2,1038,10,0,1029,1]

def active4393 : List Nat := [0,1,2,9]

def tree4393 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4393 : H12WitnessSearch.Good tree4393 := H12GlobalWitnessIndex.good

theorem leafIdentity4393 : H12AffineFastState.composeSystem env4393 rootObs = leafEnv4393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4393 rootObs == leafEnv4393) = true)

theorem terminalChecked4393 : H12PackedTerminal.terminalCheckFast leafEnv4393 active4393 tree4393 = true := by decide +kernel

def env4394 : List Nat := [2,4,8,0,1,64,72,5,64,1024,1,1028,8,1093,0,8,1092,1,1098,0,1029,0,65,8,73,0,0,1092,1029,1,1024,1,5,0,1093,65]

theorem envBound4394 : H12AffineFastState.Bounded env4394 := by
  intro p hp
  have h : env4394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4391_4394 : H12AffineEnvironment.transform 4 1 env4391 = env4394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4391 == env4394) = true)

def leafEnv4394 : List Nat := [2,4,8,0,1,64,72,5,64,1024,1,1028,8,1093,0,8,1092,1,1098,0,1029,0,65,8,1098,73,1,0,0,1092,1029,1,1024,1,5,0,4,3,1093,65,0,1028,1]

def active4394 : List Nat := [0,1,2,5,9]

def tree4394 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4394 : H12WitnessSearch.Good tree4394 := H12GlobalWitnessIndex.good

theorem leafIdentity4394 : H12AffineFastState.composeSystem env4394 rootObs = leafEnv4394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4394 rootObs == leafEnv4394) = true)

theorem terminalChecked4394 : H12PackedTerminal.terminalCheckFast leafEnv4394 active4394 tree4394 = true := by decide +kernel

def env4395 : List Nat := [2,4,8,0,32,64,128,36,136,1024,1,1061,41,1124,0,193,1125,1,1130,0,1060,33,65,224,160,0,0,1125,1060,1,1057,200,36,201,1124,137]

theorem envBound4395 : H12AffineFastState.Bounded env4395 := by
  intro p hp
  have h : env4395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4387_4395 : H12AffineEnvironment.transform 15 193 env4387 = env4395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 193 env4387 == env4395) = true)

theorem identity4395 : scanCanonicalize (H12AffineFastState.compose env4395 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound4395 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4396 : List Nat := [2,4,8,0,32,43,128,36,136,1024,1,1061,41,1039,0,170,1038,1,1025,0,1060,33,42,139,160,0,0,1038,1060,1,1057,163,36,162,1039,137]

theorem envBound4396 : H12AffineFastState.Bounded env4396 := by
  intro p hp
  have h : env4396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4395_4396 : H12AffineEnvironment.transform 5 43 env4395 = env4396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env4395 == env4396) = true)

def leafEnv4396 : List Nat := [2,4,8,0,32,43,128,36,136,1024,1,1061,41,1039,0,170,1038,1,1025,0,1060,33,42,139,1056,160,1,0,0,1038,1060,1,1057,163,36,162,4,34,1039,137,0,1061,1]

def active4396 : List Nat := [0,1,2,4,6,9]

def tree4396 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4396 : H12WitnessSearch.Good tree4396 := H12GlobalWitnessIndex.good

theorem leafIdentity4396 : H12AffineFastState.composeSystem env4396 rootObs = leafEnv4396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4396 rootObs == leafEnv4396) = true)

theorem terminalChecked4396 : H12PackedTerminal.terminalCheckFast leafEnv4396 active4396 tree4396 = true := by decide +kernel

def env4397 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1076,40,1125,1,65536,1124,1,66731,1,1077,32,65,65569,161,16,0,1124,1077,1,1056,4294967296,37,4294967296,1125,137]

theorem envBound4397 : H12AffineFastState.Bounded env4397 := by
  intro p hp
  have h : env4397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4384_4397 : H12AffineEnvironment.transform 7 37 env4384 = env4397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4384 == env4397) = true)

theorem identity4397 : scanCanonicalize (H12AffineFastState.compose env4397 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound4397 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4398 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1076,40,1125,1,65536,1124,1,66731,1,1077,32,65,65569,161,16,0,1124,1077,1,1056,43,37,43,1125,137]

theorem envBound4398 : H12AffineFastState.Bounded env4398 := by
  intro p hp
  have h : env4398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2