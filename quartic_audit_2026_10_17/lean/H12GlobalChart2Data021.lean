import H12GlobalChart2Data020

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env5142 : List Nat := [2,4,8,16,10,17,16,4,25,5,2048,17,8,17,0,9,17,24,5,0,16,24,17,9,16,16,0,17,17,2059,5,0,4,1,17,25]

theorem envBound5142 : H12AffineFastState.Bounded env5142 := by
  intro p hp
  have h : env5142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5141_5142 : H12AffineEnvironment.transform 4 10 env5141 = env5142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env5141 == env5142) = true)

def env5143 : List Nat := [2,4,8,16,10,17,16,4,25,5,0,17,8,17,0,9,17,24,5,0,16,24,17,9,16,16,0,17,17,11,5,0,4,1,17,25]

theorem envBound5143 : H12AffineFastState.Bounded env5143 := by
  intro p hp
  have h : env5143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5142_5143 : H12AffineEnvironment.transform 10 0 env5142 = env5143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5142 == env5143) = true)

theorem identity5143 : scanCanonicalize (H12AffineFastState.compose env5143 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound5143 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5144 : List Nat := [2,4,8,9,10,8,9,4,0,5,0,8,8,8,0,9,8,1,5,0,9,1,8,9,9,9,0,8,8,11,5,0,4,1,8,0]

theorem envBound5144 : H12AffineFastState.Bounded env5144 := by
  intro p hp
  have h : env5144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5143_5144 : H12AffineEnvironment.transform 3 9 env5143 = env5144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env5143 == env5144) = true)

theorem identity5144 : scanCanonicalize (H12AffineFastState.compose env5144 (packedSelected [3] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5144 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5145 : List Nat := [0,4,8,9,8,8,9,4,0,5,0,8,8,8,0,9,8,1,5,0,9,1,8,9,9,9,0,8,8,9,5,0,4,1,8,0]

theorem envBound5145 : H12AffineFastState.Bounded env5145 := by
  intro p hp
  have h : env5145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5144_5145 : H12AffineEnvironment.transform 0 0 env5144 = env5145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5144 == env5145) = true)

def env5146 : List Nat := [2,4,8,16,10,17,16,4,25,5,1,17,8,17,0,9,17,24,5,0,16,24,17,9,16,16,0,17,17,10,5,0,4,1,17,25]

theorem envBound5146 : H12AffineFastState.Bounded env5146 := by
  intro p hp
  have h : env5146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5142_5146 : H12AffineEnvironment.transform 10 1 env5142 = env5146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5142 == env5146) = true)

theorem identity5146 : scanCanonicalize (H12AffineFastState.compose env5146 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound5146 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5147 : List Nat := [2,4,8,3,10,2,3,4,10,5,1,2,8,2,0,9,2,11,5,0,3,11,2,9,3,3,0,2,2,10,5,0,4,1,2,10]

theorem envBound5147 : H12AffineFastState.Bounded env5147 := by
  intro p hp
  have h : env5147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5146_5147 : H12AffineEnvironment.transform 3 3 env5146 = env5147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env5146 == env5147) = true)

def leafEnv5147 : List Nat := [2,4,8,3,10,2,3,4,10,5,1,2,8,2,0,9,2,11,5,0,3,11,2,9,5,3,1,3,0,2,2,10,5,0,4,1,4,2,2,10,0,3,1]

def active5147 : List Nat := [0,1,2]

def tree5147 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5147 : H12WitnessSearch.Good tree5147 := H12GlobalWitnessIndex.good

theorem leafIdentity5147 : H12AffineFastState.composeSystem env5147 rootObs = leafEnv5147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5147 rootObs == leafEnv5147) = true)

theorem terminalChecked5147 : H12PackedTerminal.terminalCheckFast leafEnv5147 active5147 tree5147 = true := by decide +kernel

def env5148 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,65536,4096,71197,524288,32768,4097,4194304,5124,98304,4259841,17,4260361,1044,1044,1073741824,4116,4294967296,5137,4295536695,4096,4268681]

theorem envBound5148 : H12AffineFastState.Bounded env5148 := by
  intro p hp
  have h : env5148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5129_5148 : H12AffineEnvironment.transform 7 5 env5129 = env5148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5129 == env5148) = true)

theorem identity5148 : scanCanonicalize (H12AffineFastState.compose env5148 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 38588) := by decide +kernel

theorem selectedBound5148 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5149 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,65536,4096,71197,524288,32768,4097,4194304,5124,98304,4259841,17,4260361,1044,1044,38588,4116,4294967296,5137,4295536695,4096,4268681]

theorem envBound5149 : H12AffineFastState.Bounded env5149 := by
  intro p hp
  have h : env5149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5148_5149 : H12AffineEnvironment.transform 29 38588 env5148 = env5149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 38588 env5148 == env5149) = true)

theorem identity5149 : scanCanonicalize (H12AffineFastState.compose env5149 (packedSelected [3,5,17] rootPS)) = affineNative (2^(21+1) ^^^ 35496) := by decide +kernel

theorem selectedBound5149 : packedSelected [3,5,17] rootPS < 2^1333 := by decide +kernel

def env5150 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,65536,4096,71197,524288,32768,4097,35496,5124,98304,101033,17,100513,1044,1044,38588,4116,4294967296,5137,4295536695,4096,108577]

theorem envBound5150 : H12AffineFastState.Bounded env5150 := by
  intro p hp
  have h : env5150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5149_5150 : H12AffineEnvironment.transform 21 35496 env5149 = env5150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 35496 env5149 == env5150) = true)

theorem identity5150 : scanCanonicalize (H12AffineFastState.compose env5150 (packedSelected [1,3,8,10,31] rootPS)) = affineNative (2^(15+1) ^^^ 43552) := by decide +kernel

theorem selectedBound5150 : packedSelected [1,3,8,10,31] rootPS < 2^1333 := by decide +kernel

def env5151 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,43552,4096,48189,524288,32768,4097,35496,5124,10784,8329,17,8833,1044,1044,38588,4116,4294967296,5137,4295536695,4096,513]

theorem envBound5151 : H12AffineFastState.Bounded env5151 := by
  intro p hp
  have h : env5151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5150_5151 : H12AffineEnvironment.transform 15 43552 env5150 = env5151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 43552 env5150 == env5151) = true)

theorem identity5151 : scanCanonicalize (H12AffineFastState.compose env5151 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 4791) := by decide +kernel

theorem selectedBound5151 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env5152 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,43552,4096,48189,4791,32768,4097,35496,5124,10784,8329,17,8833,1044,1044,38588,4116,4294967296,5137,4295008896,4096,513]

theorem envBound5152 : H12AffineFastState.Bounded env5152 := by
  intro p hp
  have h : env5152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5151_5152 : H12AffineEnvironment.transform 18 4791 env5151 = env5152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4791 env5151 == env5152) = true)

theorem identity5152 : scanCanonicalize (H12AffineFastState.compose env5152 (packedSelected [2,3,4,6,7,8,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 1693) := by decide +kernel

theorem selectedBound5152 : packedSelected [2,3,4,6,7,8,10,12] rootPS < 2^1333 := by decide +kernel

def env5153 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,1693,8192,1693,32768,43552,1693,43680,1066,32768,1692,35496,665,10784,8329,17,8833,1044,1044,32801,1673,4294967296,652,4295008896,1693,513]

theorem envBound5153 : H12AffineFastState.Bounded env5153 := by
  intro p hp
  have h : env5153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5152_5153 : H12AffineEnvironment.transform 11 1693 env5152 = env5153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1693 env5152 == env5153) = true)

def env5154 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,524288,32768,4097,4194304,5456,98305,4259841,324,4461637,1045,1045,1073741824,4165,4294967296,5444,4295536742,4096,4268681]

theorem envBound5154 : H12AffineFastState.Bounded env5154 := by
  intro p hp
  have h : env5154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5094_5154 : H12AffineEnvironment.transform 23 98305 env5094 = env5154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env5094 == env5154) = true)

theorem identity5154 : scanCanonicalize (H12AffineFastState.compose env5154 (packedSelected [3,5,24] rootPS)) = affineNative (2^(18+1) ^^^ 332617) := by decide +kernel

theorem selectedBound5154 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5155 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,332617,32768,4097,4194304,5456,98305,4259841,324,4461637,1045,1045,1073741824,4165,4294967296,5444,4295336751,4096,4268681]

theorem envBound5155 : H12AffineFastState.Bounded env5155 := by
  intro p hp
  have h : env5155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5154_5155 : H12AffineEnvironment.transform 18 332617 env5154 = env5155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 332617 env5154 == env5155) = true)

def env5156 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,332617,32768,4097,4194304,5456,98305,4259841,324,4461637,1045,1045,360608,4165,4294967296,5444,4295336751,4096,4268681]

theorem envBound5156 : H12AffineFastState.Bounded env5156 := by
  intro p hp
  have h : env5156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5155_5156 : H12AffineEnvironment.transform 29 360608 env5155 = env5156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env5155 == env5156) = true)

theorem identity5156 : scanCanonicalize (H12AffineFastState.compose env5156 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48236) := by decide +kernel

theorem selectedBound5156 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5157 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110373,32768,4097,4194304,5456,98305,4259841,324,4237353,1045,1045,81100,4165,4294967296,5444,4295040835,4096,4268681]

theorem envBound5157 : H12AffineFastState.Bounded env5157 := by
  intro p hp
  have h : env5157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5156_5157 : H12AffineEnvironment.transform 17 48236 env5156 = env5157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48236 env5156 == env5157) = true)

def env5158 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110113,32768,4097,4194304,5204,98305,4259841,64,4237353,1045,1045,81100,4165,4294967296,5184,4295040583,4096,4268681]

theorem envBound5158 : H12AffineFastState.Bounded env5158 := by
  intro p hp
  have h : env5158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5157_5158 : H12AffineEnvironment.transform 7 4 env5157 = env5158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5157 == env5158) = true)

theorem identity5158 : scanCanonicalize (H12AffineFastState.compose env5158 (packedSelected [1,3,8,10,31] rootPS)) = affineNative (2^(21+1) ^^^ 73864) := by decide +kernel

theorem selectedBound5158 : packedSelected [1,3,8,10,31] rootPS < 2^1333 := by decide +kernel

def env5159 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110113,32768,4097,73864,5204,98305,8329,64,100513,1045,1045,81100,4165,4294967296,5184,4295040583,4096,513]

theorem envBound5159 : H12AffineFastState.Bounded env5159 := by
  intro p hp
  have h : env5159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5158_5159 : H12AffineEnvironment.transform 21 73864 env5158 = env5159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73864 env5158 == env5159) = true)

theorem identity5159 : scanCanonicalize (H12AffineFastState.compose env5159 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 7270) := by decide +kernel

theorem selectedBound5159 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env5160 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,7270,4177,32768,65536,4096,32778,102983,32768,4097,72942,5204,98305,7407,64,100513,1045,1045,65706,4165,4294967296,5184,4295040583,4096,513]

theorem envBound5160 : H12AffineFastState.Bounded env5160 := by
  intro p hp
  have h : env5160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5159_5160 : H12AffineEnvironment.transform 12 7270 env5159 = env5160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7270 env5159 == env5160) = true)

theorem identity5160 : scanCanonicalize (H12AffineFastState.compose env5160 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1741) := by decide +kernel

theorem selectedBound5160 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env5161 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2731,1692,32768,65536,1741,32778,99466,32768,1740,68131,665,98305,2594,64,100513,1045,1045,65706,1672,4294967296,653,4295035018,1741,513]

theorem envBound5161 : H12AffineFastState.Bounded env5161 := by
  intro p hp
  have h : env5161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5160_5161 : H12AffineEnvironment.transform 11 1741 env5160 = env5161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1741 env5160 == env5161) = true)

def env5162 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2731,1692,32768,2176,1741,32778,35850,32768,1740,675,665,34945,2594,64,32801,1045,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5162 : H12AffineFastState.Bounded env5162 := by
  intro p hp
  have h : env5162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5161_5162 : H12AffineEnvironment.transform 15 2176 env5161 = env5162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env5161 == env5162) = true)

theorem identity5162 : scanCanonicalize (H12AffineFastState.compose env5162 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2160) := by decide +kernel

theorem selectedBound5162 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5163 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2731,1692,2160,2176,1741,2170,1146,2160,1740,675,665,241,2594,64,2129,1045,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5163 : H12AffineFastState.Bounded env5163 := by
  intro p hp
  have h : env5163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5162_5163 : H12AffineEnvironment.transform 14 2160 env5162 = env5163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2160 env5162 == env5163) = true)

theorem identity5163 : scanCanonicalize (H12AffineFastState.compose env5163 (packedSelected [2,4,5,8] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound5163 : packedSelected [2,4,5,8] rootPS < 2^1333 := by decide +kernel

def env5164 : List Nat := [2,4,8,16,32,59,128,4,512,1024,2048,1718,2731,1692,2059,2176,1718,2049,1025,2059,1719,675,665,138,2594,59,2090,1045,1045,2090,1672,4294967296,653,4294967306,1718,513]

theorem envBound5164 : H12AffineFastState.Bounded env5164 := by
  intro p hp
  have h : env5164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5163_5164 : H12AffineEnvironment.transform 5 59 env5163 = env5164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env5163 == env5164) = true)

def env5165 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2731,1692,32768,2177,1741,32778,35851,32768,1740,674,665,34944,2594,64,32800,1045,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5165 : H12AffineFastState.Bounded env5165 := by
  intro p hp
  have h : env5165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5161_5165 : H12AffineEnvironment.transform 15 2177 env5161 = env5165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env5161 == env5165) = true)

theorem identity5165 : scanCanonicalize (H12AffineFastState.compose env5165 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2139) := by decide +kernel

theorem selectedBound5165 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5166 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2731,1692,2139,2177,1741,2129,1104,2139,1740,674,665,219,2594,64,2171,1045,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5166 : H12AffineFastState.Bounded env5166 := by
  intro p hp
  have h : env5166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5165_5166 : H12AffineEnvironment.transform 14 2139 env5165 = env5166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2139 env5165 == env5166) = true)

def env5167 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,4194304,5205,98305,4259841,65,4237353,1045,1045,81100,4165,4294967296,5185,4295040582,4096,4268681]

theorem envBound5167 : H12AffineFastState.Bounded env5167 := by
  intro p hp
  have h : env5167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5157_5167 : H12AffineEnvironment.transform 7 5 env5157 = env5167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5157 == env5167) = true)

theorem identity5167 : scanCanonicalize (H12AffineFastState.compose env5167 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(21+1) ^^^ 40962) := by decide +kernel

theorem selectedBound5167 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5168 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,40962,5205,98305,106499,65,2091,1045,1045,81100,4165,4294967296,5185,4295040582,4096,98955]

theorem envBound5168 : H12AffineFastState.Bounded env5168 := by
  intro p hp
  have h : env5168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5167_5168 : H12AffineEnvironment.transform 21 40962 env5167 = env5168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 40962 env5167 == env5168) = true)

theorem identity5168 : scanCanonicalize (H12AffineFastState.compose env5168 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1092) := by decide +kernel

theorem selectedBound5168 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env5169 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,32768,65536,1092,43048,110112,32768,1093,40962,17,98305,106499,65,2091,1045,1045,75912,1025,4294967296,5,4295035394,1092,98955]

theorem envBound5169 : H12AffineFastState.Bounded env5169 := by
  intro p hp
  have h : env5169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5168_5169 : H12AffineEnvironment.transform 11 1092 env5168 = env5169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1092 env5168 == env5169) = true)

theorem identity5169 : scanCanonicalize (H12AffineFastState.compose env5169 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(14+1) ^^^ 2722) := by decide +kernel

theorem selectedBound5169 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5170 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,2722,65536,1092,8842,74882,2722,1093,10912,17,68259,76449,65,2091,1045,1045,75912,1025,4294967296,5,4295035394,1092,67625]

theorem envBound5170 : H12AffineFastState.Bounded env5170 := by
  intro p hp
  have h : env5170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5169_5170 : H12AffineEnvironment.transform 14 2722 env5169 = env5170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2722 env5169 == env5170) = true)

theorem identity5170 : scanCanonicalize (H12AffineFastState.compose env5170 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound5170 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env5171 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,2722,8322,1092,8842,1024,2722,1093,10912,17,10785,2595,65,2091,1045,1045,2058,1025,4294967296,5,4294978176,1092,10411]

theorem envBound5171 : H12AffineFastState.Bounded env5171 := by
  intro p hp
  have h : env5171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5170_5171 : H12AffineEnvironment.transform 15 8322 env5170 = env5171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env5170 == env5171) = true)

theorem identity5171 : scanCanonicalize (H12AffineFastState.compose env5171 (packedSelected [0,6,7,16] rootPS)) = affineNative (2^(31+1) ^^^ 10881) := by decide +kernel

theorem selectedBound5171 : packedSelected [0,6,7,16] rootPS < 2^1333 := by decide +kernel

def env5172 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,2722,8322,1092,8842,1024,2722,1093,10912,17,10785,2595,65,2091,1045,1045,2058,1025,10881,5,1,1092,10411]

theorem envBound5172 : H12AffineFastState.Bounded env5172 := by
  intro p hp
  have h : env5172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5171_5172 : H12AffineEnvironment.transform 31 10881 env5171 = env5172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10881 env5171 == env5172) = true)

theorem identity5172 : scanCanonicalize (H12AffineFastState.compose env5172 (packedSelected [0,2,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 2082) := by decide +kernel

theorem selectedBound5172 : packedSelected [0,2,6,7] rootPS < 2^1333 := by decide +kernel

def env5173 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,2082,1045,2722,2208,1092,2728,1024,2722,1093,642,17,515,2595,65,2091,1045,1045,2058,1025,675,5,1,1092,137]

theorem envBound5173 : H12AffineFastState.Bounded env5173 := by
  intro p hp
  have h : env5173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5172_5173 : H12AffineEnvironment.transform 12 2082 env5172 = env5173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2082 env5172 == env5173) = true)

def env5174 : List Nat := [2,4,8,16,32,64,128,5,168,1024,2048,1092,2082,1045,2058,2208,1092,2048,1024,2058,1093,42,17,171,2187,65,2091,1045,1045,2058,1025,11,5,1,1092,137]

theorem envBound5174 : H12AffineFastState.Bounded env5174 := by
  intro p hp
  have h : env5174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5173_5174 : H12AffineEnvironment.transform 8 168 env5173 = env5174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env5173 == env5174) = true)

def env5175 : List Nat := [2,4,8,16,0,64,128,5,136,1024,2048,1092,2050,1045,2058,2176,1092,2048,1024,2058,1093,10,17,139,2187,65,2059,1045,1045,2058,1025,11,5,1,1092,137]

theorem envBound5175 : H12AffineFastState.Bounded env5175 := by
  intro p hp
  have h : env5175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5174_5175 : H12AffineEnvironment.transform 4 0 env5174 = env5175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5174 == env5175) = true)

theorem identity5175 : scanCanonicalize (H12AffineFastState.compose env5175 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound5175 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5176 : List Nat := [2,4,8,16,0,64,24,5,16,1024,2048,1092,2050,1045,2058,2072,1092,2048,1024,2058,1093,10,17,19,2067,65,2059,1045,1045,2058,1025,11,5,1,1092,17]

theorem envBound5176 : H12AffineFastState.Bounded env5176 := by
  intro p hp
  have h : env5176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5175_5176 : H12AffineEnvironment.transform 6 24 env5175 = env5176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env5175 == env5176) = true)

theorem identity5176 : scanCanonicalize (H12AffineFastState.compose env5176 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5176 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5177 : List Nat := [2,4,2,16,0,64,18,5,16,1024,2048,1092,2050,1045,2048,2066,1092,2048,1024,2048,1093,0,17,19,2067,65,2049,1045,1045,2048,1025,1,5,1,1092,17]

theorem envBound5177 : H12AffineFastState.Bounded env5177 := by
  intro p hp
  have h : env5177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5176_5177 : H12AffineEnvironment.transform 2 2 env5176 = env5177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5176 == env5177) = true)

theorem identity5177 : scanCanonicalize (H12AffineFastState.compose env5177 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5177 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5178 : List Nat := [2,4,2,16,0,16,18,5,16,1024,2048,1044,2050,1045,2048,2066,1044,2048,1024,2048,1045,0,17,19,2067,17,2049,1045,1045,2048,1025,1,5,1,1044,17]

theorem envBound5178 : H12AffineFastState.Bounded env5178 := by
  intro p hp
  have h : env5178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5177_5178 : H12AffineEnvironment.transform 5 16 env5177 = env5178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5177 == env5178) = true)

def env5179 : List Nat := [2,4,8,16,1,64,128,5,137,1024,2048,1092,2051,1045,2058,2177,1092,2048,1024,2058,1093,11,17,138,2187,65,2058,1045,1045,2058,1025,11,5,1,1092,137]

theorem envBound5179 : H12AffineFastState.Bounded env5179 := by
  intro p hp
  have h : env5179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5174_5179 : H12AffineEnvironment.transform 4 1 env5174 = env5179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5174 == env5179) = true)

theorem identity5179 : scanCanonicalize (H12AffineFastState.compose env5179 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound5179 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5180 : List Nat := [2,4,8,3,1,64,128,5,137,1024,2048,1092,2051,1030,2058,2177,1092,2048,1024,2058,1093,11,2,138,2187,65,2058,1030,1030,2058,1025,11,5,1,1092,137]

theorem envBound5180 : H12AffineFastState.Bounded env5180 := by
  intro p hp
  have h : env5180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5179_5180 : H12AffineEnvironment.transform 3 3 env5179 = env5180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env5179 == env5180) = true)

theorem identity5180 : scanCanonicalize (H12AffineFastState.compose env5180 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound5180 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5181 : List Nat := [2,4,8,3,1,64,2,5,11,1024,2048,1092,2051,1030,2058,2051,1092,2048,1024,2058,1093,11,2,8,2057,65,2058,1030,1030,2058,1025,11,5,1,1092,11]

theorem envBound5181 : H12AffineFastState.Bounded env5181 := by
  intro p hp
  have h : env5181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5180_5181 : H12AffineEnvironment.transform 6 2 env5180 = env5181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env5180 == env5181) = true)

theorem identity5181 : scanCanonicalize (H12AffineFastState.compose env5181 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 73) := by decide +kernel

theorem selectedBound5181 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5182 : List Nat := [2,4,8,3,1,64,2,5,11,1024,73,1092,74,1030,67,74,1092,73,1024,67,1093,11,2,8,64,65,67,1030,1030,67,1025,11,5,1,1092,11]

theorem envBound5182 : H12AffineFastState.Bounded env5182 := by
  intro p hp
  have h : env5182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5181_5182 : H12AffineEnvironment.transform 10 73 env5181 = env5182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 73 env5181 == env5182) = true)

theorem identity5182 : scanCanonicalize (H12AffineFastState.compose env5182 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound5182 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env5183 : List Nat := [2,4,8,3,1,64,2,5,11,15,73,75,74,9,67,74,75,73,15,67,74,11,2,8,64,65,67,9,9,67,14,11,5,1,75,11]

theorem envBound5183 : H12AffineFastState.Bounded env5183 := by
  intro p hp
  have h : env5183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5182_5183 : H12AffineEnvironment.transform 9 15 env5182 = env5183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env5182 == env5183) = true)

def env5184 : List Nat := [2,4,8,3,1,8,2,5,11,15,1,3,2,9,11,2,3,1,15,11,2,11,2,8,8,9,11,9,9,11,14,11,5,1,3,11]

theorem envBound5184 : H12AffineFastState.Bounded env5184 := by
  intro p hp
  have h : env5184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5183_5184 : H12AffineEnvironment.transform 5 8 env5183 = env5184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 8 env5183 == env5184) = true)

theorem identity5184 : scanCanonicalize (H12AffineFastState.compose env5184 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5184 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5185 : List Nat := [2,4,2,3,1,2,2,5,1,5,1,3,2,3,1,2,3,1,5,1,2,1,2,2,2,3,1,3,3,1,4,1,5,1,3,1]

theorem envBound5185 : H12AffineFastState.Bounded env5185 := by
  intro p hp
  have h : env5185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5184_5185 : H12AffineEnvironment.transform 2 2 env5184 = env5185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5184 == env5185) = true)

def leafEnv5185 : List Nat := [2,4,2,3,1,2,2,5,1,5,1,3,2,3,1,2,3,1,5,1,2,1,2,2,4,2,1,3,1,3,3,1,4,1,5,1,4,2,3,1,0,2,1]

def active5185 : List Nat := [0,1]

def tree5185 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5185 : H12WitnessSearch.Good tree5185 := H12GlobalWitnessIndex.good

theorem leafIdentity5185 : H12AffineFastState.composeSystem env5185 rootObs = leafEnv5185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5185 rootObs == leafEnv5185) = true)

theorem terminalChecked5185 : H12PackedTerminal.terminalCheckFast leafEnv5185 active5185 tree5185 = true := by decide +kernel

def env5186 : List Nat := [2,4,8,3,1,9,2,5,11,15,0,2,3,9,10,3,2,0,15,10,3,11,2,8,9,8,10,9,9,10,14,11,5,1,2,11]

theorem envBound5186 : H12AffineFastState.Bounded env5186 := by
  intro p hp
  have h : env5186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5183_5186 : H12AffineEnvironment.transform 5 9 env5183 = env5186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 9 env5183 == env5186) = true)

def leafEnv5186 : List Nat := [2,4,8,3,1,9,2,5,11,15,0,2,3,9,10,3,2,0,15,10,3,11,2,8,14,9,1,8,10,9,9,10,14,11,5,1,4,9,2,11,0,8,1]

def active5186 : List Nat := [0,1,2]

def tree5186 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5186 : H12WitnessSearch.Good tree5186 := H12GlobalWitnessIndex.good

theorem leafIdentity5186 : H12AffineFastState.composeSystem env5186 rootObs = leafEnv5186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5186 rootObs == leafEnv5186) = true)

theorem terminalChecked5186 : H12PackedTerminal.terminalCheckFast leafEnv5186 active5186 tree5186 = true := by decide +kernel

def env5187 : List Nat := [2,4,8,16,32,64,128,5,169,1024,2048,1092,2082,1045,2059,2208,1092,2049,1024,2059,1093,43,17,170,2186,65,2091,1045,1045,2058,1025,10,5,1,1092,137]

theorem envBound5187 : H12AffineFastState.Bounded env5187 := by
  intro p hp
  have h : env5187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5173_5187 : H12AffineEnvironment.transform 8 169 env5173 = env5187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env5173 == env5187) = true)

theorem identity5187 : scanCanonicalize (H12AffineFastState.compose env5187 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5187 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5188 : List Nat := [2,4,2,16,32,64,128,5,163,1024,2048,1092,2082,1045,2049,2208,1092,2049,1024,2049,1093,33,17,160,2176,65,2081,1045,1045,2048,1025,0,5,1,1092,131]

theorem envBound5188 : H12AffineFastState.Bounded env5188 := by
  intro p hp
  have h : env5188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5187_5188 : H12AffineEnvironment.transform 2 2 env5187 = env5188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5187 == env5188) = true)

def env5189 : List Nat := [2,4,2,16,32,64,0,5,35,1024,2048,1092,2082,1045,2049,2080,1092,2049,1024,2049,1093,33,17,32,2048,65,2081,1045,1045,2048,1025,0,5,1,1092,3]

theorem envBound5189 : H12AffineFastState.Bounded env5189 := by
  intro p hp
  have h : env5189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5188_5189 : H12AffineEnvironment.transform 6 0 env5188 = env5189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 0 env5188 == env5189) = true)

theorem identity5189 : scanCanonicalize (H12AffineFastState.compose env5189 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound5189 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5190 : List Nat := [2,4,2,16,19,64,0,5,16,1024,2048,1092,2065,1045,2049,2067,1092,2049,1024,2049,1093,18,17,19,2048,65,2066,1045,1045,2048,1025,0,5,1,1092,3]

theorem envBound5190 : H12AffineFastState.Bounded env5190 := by
  intro p hp
  have h : env5190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5189_5190 : H12AffineEnvironment.transform 4 19 env5189 = env5190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env5189 == env5190) = true)

def env5191 : List Nat := [2,4,2,16,19,0,0,5,16,1024,2048,1028,2065,1045,2049,2067,1028,2049,1024,2049,1029,18,17,19,2048,1,2066,1045,1045,2048,1025,0,5,1,1028,3]

theorem envBound5191 : H12AffineFastState.Bounded env5191 := by
  intro p hp
  have h : env5191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5190_5191 : H12AffineEnvironment.transform 5 0 env5190 = env5191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env5190 == env5191) = true)

theorem identity5191 : scanCanonicalize (H12AffineFastState.compose env5191 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound5191 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5192 : List Nat := [2,4,2,1,2,0,0,5,1,1024,2048,1028,2048,1028,2049,2050,1028,2049,1024,2049,1029,3,0,2,2048,1,2051,1028,1028,2048,1025,0,5,1,1028,3]

theorem envBound5192 : H12AffineFastState.Bounded env5192 := by
  intro p hp
  have h : env5192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5191_5192 : H12AffineEnvironment.transform 3 1 env5191 = env5192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env5191 == env5192) = true)

theorem identity5192 : scanCanonicalize (H12AffineFastState.compose env5192 (packedSelected [3] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5192 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5193 : List Nat := [0,4,0,1,0,0,0,5,1,1024,2048,1028,2048,1028,2049,2048,1028,2049,1024,2049,1029,1,0,0,2048,1,2049,1028,1028,2048,1025,0,5,1,1028,1]

theorem envBound5193 : H12AffineFastState.Bounded env5193 := by
  intro p hp
  have h : env5193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5192_5193 : H12AffineEnvironment.transform 0 0 env5192 = env5193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5192 == env5193) = true)

theorem identity5193 : scanCanonicalize (H12AffineFastState.compose env5193 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 0) := by decide +kernel

theorem selectedBound5193 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5194 : List Nat := [0,4,0,1,0,0,0,5,1,1024,0,1028,0,1028,1,0,1028,1,1024,1,1029,1,0,0,0,1,1,1028,1028,0,1025,0,5,1,1028,1]

theorem envBound5194 : H12AffineFastState.Bounded env5194 := by
  intro p hp
  have h : env5194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5193_5194 : H12AffineEnvironment.transform 10 0 env5193 = env5194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5193 == env5194) = true)

theorem identity5194 : scanCanonicalize (H12AffineFastState.compose env5194 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5194 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5195 : List Nat := [0,4,0,1,0,0,0,5,1,4,0,0,0,0,1,0,0,1,4,1,1,1,0,0,0,1,1,0,0,0,5,0,5,1,0,1]

theorem envBound5195 : H12AffineFastState.Bounded env5195 := by
  intro p hp
  have h : env5195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5194_5195 : H12AffineEnvironment.transform 9 4 env5194 = env5195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5194 == env5195) = true)

def leafEnv5195 : List Nat := [0,4,0,1,0,0,0,5,1,4,0,0,0,0,1,0,0,1,4,1,1,1,0,0,5,0,1,1,1,0,0,0,5,0,5,1,4,0,0,1,0,1,1]

def active5195 : List Nat := [1]

def tree5195 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5195 : H12WitnessSearch.Good tree5195 := H12GlobalWitnessIndex.good

theorem leafIdentity5195 : H12AffineFastState.composeSystem env5195 rootObs = leafEnv5195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5195 rootObs == leafEnv5195) = true)

theorem terminalChecked5195 : H12PackedTerminal.terminalCheckFast leafEnv5195 active5195 tree5195 = true := by decide +kernel

def env5196 : List Nat := [2,4,2,16,19,1,0,5,16,1024,2048,1029,2065,1045,2049,2067,1029,2049,1024,2049,1028,18,17,19,2048,0,2066,1045,1045,2048,1025,0,5,1,1029,3]

theorem envBound5196 : H12AffineFastState.Bounded env5196 := by
  intro p hp
  have h : env5196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5190_5196 : H12AffineEnvironment.transform 5 1 env5190 = env5196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env5190 == env5196) = true)

theorem identity5196 : scanCanonicalize (H12AffineFastState.compose env5196 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound5196 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5197 : List Nat := [2,4,2,3,0,1,0,5,3,1024,2048,1029,2050,1030,2049,2048,1029,2049,1024,2049,1028,1,2,0,2048,0,2049,1030,1030,2048,1025,0,5,1,1029,3]

theorem envBound5197 : H12AffineFastState.Bounded env5197 := by
  intro p hp
  have h : env5197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5196_5197 : H12AffineEnvironment.transform 3 3 env5196 = env5197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env5196 == env5197) = true)

theorem identity5197 : scanCanonicalize (H12AffineFastState.compose env5197 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5197 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5198 : List Nat := [0,4,0,1,0,1,0,5,1,1024,2048,1029,2048,1028,2049,2048,1029,2049,1024,2049,1028,1,0,0,2048,0,2049,1028,1028,2048,1025,0,5,1,1029,1]

theorem envBound5198 : H12AffineFastState.Bounded env5198 := by
  intro p hp
  have h : env5198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5197_5198 : H12AffineEnvironment.transform 0 0 env5197 = env5198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5197 == env5198) = true)

theorem identity5198 : scanCanonicalize (H12AffineFastState.compose env5198 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound5198 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5199 : List Nat := [0,4,0,1,0,1,0,5,1,1024,1,1029,1,1028,0,1,1029,0,1024,0,1028,1,0,0,1,0,0,1028,1028,1,1025,0,5,1,1029,1]

theorem envBound5199 : H12AffineFastState.Bounded env5199 := by
  intro p hp
  have h : env5199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5198_5199 : H12AffineEnvironment.transform 10 1 env5198 = env5199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5198 == env5199) = true)

theorem identity5199 : scanCanonicalize (H12AffineFastState.compose env5199 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5199 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5200 : List Nat := [0,4,0,1,0,1,0,5,1,4,1,1,1,0,0,1,1,0,4,0,0,1,0,0,1,0,0,0,0,1,5,0,5,1,1,1]

theorem envBound5200 : H12AffineFastState.Bounded env5200 := by
  intro p hp
  have h : env5200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5199_5200 : H12AffineEnvironment.transform 9 4 env5199 = env5200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5199 == env5200) = true)

def leafEnv5200 : List Nat := [0,4,0,1,0,1,0,5,1,4,1,1,1,0,0,1,1,0,4,0,0,1,0,0,5,1,1,0,0,0,0,1,5,0,5,1,4,1,1,1,0,1,1]

def active5200 : List Nat := [1]

def tree5200 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5200 : H12WitnessSearch.Good tree5200 := H12GlobalWitnessIndex.good

theorem leafIdentity5200 : H12AffineFastState.composeSystem env5200 rootObs = leafEnv5200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5200 rootObs == leafEnv5200) = true)

theorem terminalChecked5200 : H12PackedTerminal.terminalCheckFast leafEnv5200 active5200 tree5200 = true := by decide +kernel

def env5201 : List Nat := [2,4,2,16,32,64,1,5,34,1024,2048,1092,2082,1045,2049,2081,1092,2049,1024,2049,1093,33,17,33,2049,65,2081,1045,1045,2048,1025,0,5,1,1092,2]

theorem envBound5201 : H12AffineFastState.Bounded env5201 := by
  intro p hp
  have h : env5201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5188_5201 : H12AffineEnvironment.transform 6 1 env5188 = env5201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 1 env5188 == env5201) = true)

theorem identity5201 : scanCanonicalize (H12AffineFastState.compose env5201 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound5201 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5202 : List Nat := [2,4,2,3,32,64,1,5,34,1024,2048,1092,2082,1030,2049,2081,1092,2049,1024,2049,1093,33,2,33,2049,65,2081,1030,1030,2048,1025,0,5,1,1092,2]

theorem envBound5202 : H12AffineFastState.Bounded env5202 := by
  intro p hp
  have h : env5202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5201_5202 : H12AffineEnvironment.transform 3 3 env5201 = env5202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env5201 == env5202) = true)

def env5203 : List Nat := [2,4,2,3,32,32,1,5,34,1024,2048,1060,2082,1030,2049,2081,1060,2049,1024,2049,1061,33,2,33,2049,33,2081,1030,1030,2048,1025,0,5,1,1060,2]

theorem envBound5203 : H12AffineFastState.Bounded env5203 := by
  intro p hp
  have h : env5203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5202_5203 : H12AffineEnvironment.transform 5 32 env5202 = env5203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 32 env5202 == env5203) = true)

theorem identity5203 : scanCanonicalize (H12AffineFastState.compose env5203 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5203 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5204 : List Nat := [2,4,2,3,0,0,1,5,2,1024,2048,1028,2050,1030,2049,2049,1028,2049,1024,2049,1029,1,2,1,2049,1,2049,1030,1030,2048,1025,0,5,1,1028,2]

theorem envBound5204 : H12AffineFastState.Bounded env5204 := by
  intro p hp
  have h : env5204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5203_5204 : H12AffineEnvironment.transform 4 0 env5203 = env5204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5203 == env5204) = true)

theorem identity5204 : scanCanonicalize (H12AffineFastState.compose env5204 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5204 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5205 : List Nat := [1,4,1,0,0,0,1,5,1,1024,2048,1028,2049,1029,2049,2049,1028,2049,1024,2049,1029,1,1,1,2049,1,2049,1029,1029,2048,1025,0,5,1,1028,1]

theorem envBound5205 : H12AffineFastState.Bounded env5205 := by
  intro p hp
  have h : env5205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5204_5205 : H12AffineEnvironment.transform 0 1 env5204 = env5205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5204 == env5205) = true)

theorem identity5205 : scanCanonicalize (H12AffineFastState.compose env5205 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound5205 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5206 : List Nat := [1,4,1,0,0,0,1,5,1,1024,1,1028,0,1029,0,0,1028,0,1024,0,1029,1,1,1,0,1,0,1029,1029,1,1025,0,5,1,1028,1]

theorem envBound5206 : H12AffineFastState.Bounded env5206 := by
  intro p hp
  have h : env5206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5205_5206 : H12AffineEnvironment.transform 10 1 env5205 = env5206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5205 == env5206) = true)

theorem identity5206 : scanCanonicalize (H12AffineFastState.compose env5206 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5206 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5207 : List Nat := [1,4,1,0,0,0,1,5,1,4,1,0,0,1,0,0,0,0,4,0,1,1,1,1,0,1,0,1,1,1,5,0,5,1,0,1]

theorem envBound5207 : H12AffineFastState.Bounded env5207 := by
  intro p hp
  have h : env5207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5206_5207 : H12AffineEnvironment.transform 9 4 env5206 = env5207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5206 == env5207) = true)

def leafEnv5207 : List Nat := [1,4,1,0,0,0,1,5,1,4,1,0,0,1,0,0,0,0,4,0,1,1,1,1,5,0,1,1,0,1,1,1,5,0,5,1,4,0,0,1,0,0,1]

def active5207 : List Nat := [1]

def tree5207 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5207 : H12WitnessSearch.Good tree5207 := H12GlobalWitnessIndex.good

theorem leafIdentity5207 : H12AffineFastState.composeSystem env5207 rootObs = leafEnv5207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5207 rootObs == leafEnv5207) = true)

theorem terminalChecked5207 : H12PackedTerminal.terminalCheckFast leafEnv5207 active5207 tree5207 = true := by decide +kernel

def env5208 : List Nat := [2,4,2,3,32,33,1,5,34,1024,2048,1061,2082,1030,2049,2081,1061,2049,1024,2049,1060,33,2,33,2049,32,2081,1030,1030,2048,1025,0,5,1,1061,2]

theorem envBound5208 : H12AffineFastState.Bounded env5208 := by
  intro p hp
  have h : env5208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5202_5208 : H12AffineEnvironment.transform 5 33 env5202 = env5208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env5202 == env5208) = true)

theorem identity5208 : scanCanonicalize (H12AffineFastState.compose env5208 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound5208 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5209 : List Nat := [2,4,2,3,3,2,1,5,1,1024,2048,1030,2049,1030,2049,2050,1030,2049,1024,2049,1031,2,2,2,2049,3,2050,1030,1030,2048,1025,0,5,1,1030,2]

theorem envBound5209 : H12AffineFastState.Bounded env5209 := by
  intro p hp
  have h : env5209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5208_5209 : H12AffineEnvironment.transform 4 3 env5208 = env5209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env5208 == env5209) = true)

theorem identity5209 : scanCanonicalize (H12AffineFastState.compose env5209 (packedSelected [3] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5209 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5210 : List Nat := [1,4,1,0,0,1,1,5,1,1024,2048,1029,2049,1029,2049,2049,1029,2049,1024,2049,1028,1,1,1,2049,0,2049,1029,1029,2048,1025,0,5,1,1029,1]

theorem envBound5210 : H12AffineFastState.Bounded env5210 := by
  intro p hp
  have h : env5210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5209_5210 : H12AffineEnvironment.transform 0 1 env5209 = env5210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5209 == env5210) = true)

theorem identity5210 : scanCanonicalize (H12AffineFastState.compose env5210 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 0) := by decide +kernel

theorem selectedBound5210 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5211 : List Nat := [1,4,1,0,0,1,1,5,1,1024,0,1029,1,1029,1,1,1029,1,1024,1,1028,1,1,1,1,0,1,1029,1029,0,1025,0,5,1,1029,1]

theorem envBound5211 : H12AffineFastState.Bounded env5211 := by
  intro p hp
  have h : env5211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5210_5211 : H12AffineEnvironment.transform 10 0 env5210 = env5211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5210 == env5211) = true)

theorem identity5211 : scanCanonicalize (H12AffineFastState.compose env5211 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5211 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5212 : List Nat := [1,4,1,0,0,1,1,5,1,4,0,1,1,1,1,1,1,1,4,1,0,1,1,1,1,0,1,1,1,0,5,0,5,1,1,1]

theorem envBound5212 : H12AffineFastState.Bounded env5212 := by
  intro p hp
  have h : env5212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5211_5212 : H12AffineEnvironment.transform 9 4 env5211 = env5212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5211 == env5212) = true)

def leafEnv5212 : List Nat := [1,4,1,0,0,1,1,5,1,4,0,1,1,1,1,1,1,1,4,1,0,1,1,1,5,1,1,0,1,1,1,0,5,0,5,1,4,1,1,1,0,0,1]

def active5212 : List Nat := [1]

def tree5212 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5212 : H12WitnessSearch.Good tree5212 := H12GlobalWitnessIndex.good

theorem leafIdentity5212 : H12AffineFastState.composeSystem env5212 rootObs = leafEnv5212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5212 rootObs == leafEnv5212) = true)

theorem terminalChecked5212 : H12PackedTerminal.terminalCheckFast leafEnv5212 active5212 tree5212 = true := by decide +kernel

def env5213 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,332617,32768,4097,4194304,5456,98305,4259841,324,4461637,1045,1045,360609,4165,4294967296,5444,4295336751,4096,4268681]

theorem envBound5213 : H12AffineFastState.Bounded env5213 := by
  intro p hp
  have h : env5213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5155_5213 : H12AffineEnvironment.transform 29 360609 env5155 = env5213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env5155 == env5213) = true)

theorem identity5213 : scanCanonicalize (H12AffineFastState.compose env5213 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5213 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5214 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,332568,32768,4097,4194304,5377,98305,4259841,277,4461588,1045,1045,360609,4116,4294967296,5397,4295336751,4096,4268681]

theorem envBound5214 : H12AffineFastState.Bounded env5214 := by
  intro p hp
  have h : env5214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5213_5214 : H12AffineEnvironment.transform 5 17 env5213 = env5214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5213 == env5214) = true)

def env5215 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,4194304,5456,16777216,4259840,16875844,4461636,16876565,16876564,1073741824,4164,4294967296,16880964,4295536742,4097,4268680]

theorem envBound5215 : H12AffineFastState.Bounded env5215 := by
  intro p hp
  have h : env5215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5093_5215 : H12AffineEnvironment.transform 16 4097 env5093 = env5215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env5093 == env5215) = true)

def env5216 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,4194304,5456,98304,4259840,324,4461636,1045,1044,1073741824,4164,4294967296,5444,4295536742,4097,4268680]

theorem envBound5216 : H12AffineFastState.Bounded env5216 := by
  intro p hp
  have h : env5216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5215_5216 : H12AffineEnvironment.transform 23 98304 env5215 = env5216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env5215 == env5216) = true)

theorem identity5216 : scanCanonicalize (H12AffineFastState.compose env5216 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 270344) := by decide +kernel

theorem selectedBound5216 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5217 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,270344,5456,98304,335880,324,13388,1045,1044,1073741824,4164,4294967296,5444,4295536742,4097,328320]

theorem envBound5217 : H12AffineFastState.Bounded env5217 := by
  intro p hp
  have h : env5217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5216_5217 : H12AffineEnvironment.transform 21 270344 env5216 = env5217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 270344 env5216 == env5217) = true)

def env5218 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,270344,5456,98304,335880,324,13388,1045,1044,360608,4164,4294967296,5444,4295536742,4097,328320]

theorem envBound5218 : H12AffineFastState.Bounded env5218 := by
  intro p hp
  have h : env5218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5217_5218 : H12AffineEnvironment.transform 29 360608 env5217 = env5218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env5217 == env5218) = true)

theorem identity5218 : scanCanonicalize (H12AffineFastState.compose env5218 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48236) := by decide +kernel

theorem selectedBound5218 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5219 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,48236,524288,32768,4097,40036,5456,98304,105572,324,13388,1045,1044,81100,4164,4294967296,5444,4295536742,4097,114412]

theorem envBound5219 : H12AffineFastState.Bounded env5219 := by
  intro p hp
  have h : env5219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5218_5219 : H12AffineEnvironment.transform 17 48236 env5218 = env5219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48236 env5218 == env5219) = true)

theorem identity5219 : scanCanonicalize (H12AffineFastState.compose env5219 (packedSelected [3,13,15,17,31] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5219 : packedSelected [3,13,15,17,31] rootPS < 2^1333 := by decide +kernel

def env5220 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4097,48236,524288,32768,4097,40036,5204,98304,105572,64,13388,1045,1044,81100,4164,4294967296,5184,4295536742,4097,114412]

theorem envBound5220 : H12AffineFastState.Bounded env5220 := by
  intro p hp
  have h : env5220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5219_5220 : H12AffineEnvironment.transform 7 4 env5219 = env5220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5219 == env5220) = true)

theorem identity5220 : scanCanonicalize (H12AffineFastState.compose env5220 (packedSelected [1,8,12,19] rootPS)) = affineNative (2^(12+1) ^^^ 7270) := by decide +kernel

theorem selectedBound5220 : packedSelected [1,8,12,19] rootPS < 2^1333 := by decide +kernel

def env5221 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,7270,4177,32768,65536,4097,32778,524288,32768,4097,40036,5204,98304,105572,64,2090,1045,1044,65706,4164,4294967296,5184,4295527424,4097,98954]

theorem envBound5221 : H12AffineFastState.Bounded env5221 := by
  intro p hp
  have h : env5221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5220_5221 : H12AffineEnvironment.transform 12 7270 env5220 = env5221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7270 env5220 == env5221) = true)

theorem identity5221 : scanCanonicalize (H12AffineFastState.compose env5221 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1092) := by decide +kernel

theorem selectedBound5221 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env5222 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1092,2082,1045,32768,65536,1093,32778,524288,32768,1093,34848,16,98304,100384,64,2090,1045,1044,65706,1024,4294967296,4,4295527424,1093,98954]

theorem envBound5222 : H12AffineFastState.Bounded env5222 := by
  intro p hp
  have h : env5222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5221_5222 : H12AffineEnvironment.transform 11 1092 env5221 = env5222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1092 env5221 == env5222) = true)

theorem identity5222 : scanCanonicalize (H12AffineFastState.compose env5222 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 68768) := by decide +kernel

theorem selectedBound5222 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env5223 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1092,2082,1045,32768,65536,1093,32778,68768,32768,1093,34848,16,98304,100384,64,2090,1045,1044,65706,1024,4294967296,4,4295065760,1093,98954]

theorem envBound5223 : H12AffineFastState.Bounded env5223 := by
  intro p hp
  have h : env5223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5222_5223 : H12AffineEnvironment.transform 18 68768 env5222 = env5223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 68768 env5222 == env5223) = true)

theorem identity5223 : scanCanonicalize (H12AffineFastState.compose env5223 (packedSelected [1,8,10,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 2208) := by decide +kernel

theorem selectedBound5223 : packedSelected [1,8,10,13,15,21] rootPS < 2^1333 := by decide +kernel

def env5224 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1092,2082,1045,32768,2208,1093,32778,1024,32768,1093,34848,16,34976,32896,64,2090,1045,1044,2058,1024,4294967296,4,4295002112,1093,35370]

theorem envBound5224 : H12AffineFastState.Bounded env5224 := by
  intro p hp
  have h : env5224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5223_5224 : H12AffineEnvironment.transform 15 2208 env5223 = env5224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2208 env5223 == env5224) = true)

theorem identity5224 : scanCanonicalize (H12AffineFastState.compose env5224 (packedSelected [1,3,10,13,15] rootPS)) = affineNative (2^(14+1) ^^^ 2091) := by decide +kernel

theorem selectedBound5224 : packedSelected [1,3,10,13,15] rootPS < 2^1333 := by decide +kernel

def env5225 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1092,2082,1045,2091,2208,1093,2081,1024,2091,1093,11,16,139,2219,64,2090,1045,1044,2058,1024,4294967296,4,4294967339,1093,513]

theorem envBound5225 : H12AffineFastState.Bounded env5225 := by
  intro p hp
  have h : env5225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5224_5225 : H12AffineEnvironment.transform 14 2091 env5224 = env5225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2091 env5224 == env5225) = true)

theorem identity5225 : scanCanonicalize (H12AffineFastState.compose env5225 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound5225 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5226 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1092,2082,1045,2091,2208,1093,2081,1024,2091,1093,11,16,139,2219,64,2090,1045,1044,2058,1024,123,4,80,1093,513]

theorem envBound5226 : H12AffineFastState.Bounded env5226 := by
  intro p hp
  have h : env5226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5225_5226 : H12AffineEnvironment.transform 31 123 env5225 = env5226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env5225 == env5226) = true)

theorem identity5226 : scanCanonicalize (H12AffineFastState.compose env5226 (packedSelected [2,4,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5226 : packedSelected [2,4,7] rootPS < 2^1333 := by decide +kernel

def env5227 : List Nat := [2,4,2,16,32,64,128,4,512,1024,2048,1092,2082,1045,2081,2208,1093,2081,1024,2081,1093,1,16,129,2209,64,2080,1045,1044,2048,1024,113,4,80,1093,513]

theorem envBound5227 : H12AffineFastState.Bounded env5227 := by
  intro p hp
  have h : env5227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5226_5227 : H12AffineEnvironment.transform 2 2 env5226 = env5227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5226 == env5227) = true)

theorem identity5227 : scanCanonicalize (H12AffineFastState.compose env5227 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5227 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5228 : List Nat := [2,4,2,16,32,17,128,4,512,1024,2048,1045,2082,1045,2081,2208,1044,2081,1024,2081,1044,1,16,129,2209,17,2080,1045,1044,2048,1024,32,4,1,1044,513]

theorem envBound5228 : H12AffineFastState.Bounded env5228 := by
  intro p hp
  have h : env5228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5227_5228 : H12AffineEnvironment.transform 5 17 env5227 = env5228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5227 == env5228) = true)

theorem identity5228 : scanCanonicalize (H12AffineFastState.compose env5228 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound5228 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5229 : List Nat := [2,4,2,16,32,17,19,4,512,1024,2048,1045,2082,1045,2081,2099,1044,2081,1024,2081,1044,1,16,18,2098,17,2080,1045,1044,2048,1024,32,4,1,1044,513]

theorem envBound5229 : H12AffineFastState.Bounded env5229 := by
  intro p hp
  have h : env5229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5228_5229 : H12AffineEnvironment.transform 6 19 env5228 = env5229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env5228 == env5229) = true)

theorem identity5229 : scanCanonicalize (H12AffineFastState.compose env5229 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 48) := by decide +kernel

theorem selectedBound5229 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5230 : List Nat := [2,4,2,16,32,17,19,4,48,1024,2048,1045,2082,1045,2081,2099,1044,2081,1024,2081,1044,1,16,18,2098,17,2080,1045,1044,2048,1024,32,4,1,1044,49]

theorem envBound5230 : H12AffineFastState.Bounded env5230 := by
  intro p hp
  have h : env5230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5229_5230 : H12AffineEnvironment.transform 8 48 env5229 = env5230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 48 env5229 == env5230) = true)

theorem identity5230 : scanCanonicalize (H12AffineFastState.compose env5230 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5230 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env5231 : List Nat := [2,4,2,16,1,17,19,4,17,1024,2048,1045,2051,1045,2048,2066,1044,2048,1024,2048,1044,1,16,18,2067,17,2049,1045,1044,2048,1024,1,4,1,1044,16]

theorem envBound5231 : H12AffineFastState.Bounded env5231 := by
  intro p hp
  have h : env5231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5230_5231 : H12AffineEnvironment.transform 4 1 env5230 = env5231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5230 == env5231) = true)

def env5232 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,270344,5456,98304,335880,324,13388,1045,1044,360609,4164,4294967296,5444,4295536742,4097,328320]

theorem envBound5232 : H12AffineFastState.Bounded env5232 := by
  intro p hp
  have h : env5232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5217_5232 : H12AffineEnvironment.transform 29 360609 env5217 = env5232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env5217 == env5232) = true)

theorem identity5232 : scanCanonicalize (H12AffineFastState.compose env5232 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5232 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5233 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,524288,32768,4097,270344,5376,98304,335880,276,13340,1045,1044,360609,4116,4294967296,5396,4295536694,4097,328320]

theorem envBound5233 : H12AffineFastState.Bounded env5233 := by
  intro p hp
  have h : env5233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5232_5233 : H12AffineEnvironment.transform 5 16 env5232 = env5233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5232 == env5233) = true)

def env5234 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,4194304,5456,98305,4259840,325,4461636,1044,1045,1073741824,4164,4294967296,5445,4295536742,4097,4268680]

theorem envBound5234 : H12AffineFastState.Bounded env5234 := by
  intro p hp
  have h : env5234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5215_5234 : H12AffineEnvironment.transform 23 98305 env5215 = env5234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env5215 == env5234) = true)

theorem identity5234 : scanCanonicalize (H12AffineFastState.compose env5234 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 795656) := by decide +kernel

theorem selectedBound5234 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5235 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,795656,5456,98305,861192,325,536652,1044,1045,1073741824,4164,4294967296,5445,4295536742,4097,853632]

theorem envBound5235 : H12AffineFastState.Bounded env5235 := by
  intro p hp
  have h : env5235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5234_5235 : H12AffineEnvironment.transform 21 795656 env5234 = env5235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 795656 env5234 == env5235) = true)

def env5236 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,795656,5456,98305,861192,325,536652,1044,1045,360608,4164,4294967296,5445,4295536742,4097,853632]

theorem envBound5236 : H12AffineFastState.Bounded env5236 := by
  intro p hp
  have h : env5236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5235_5236 : H12AffineEnvironment.transform 29 360608 env5235 = env5236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env5235 == env5236) = true)

theorem identity5236 : scanCanonicalize (H12AffineFastState.compose env5236 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5236 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5237 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,524288,32768,4097,795656,5376,98305,861192,277,536604,1044,1045,360608,4116,4294967296,5397,4295536694,4097,853632]

theorem envBound5237 : H12AffineFastState.Bounded env5237 := by
  intro p hp
  have h : env5237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5236_5237 : H12AffineEnvironment.transform 5 16 env5236 = env5237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5236 == env5237) = true)

def env5238 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,795656,5456,98305,861192,325,536652,1044,1045,360609,4164,4294967296,5445,4295536742,4097,853632]

theorem envBound5238 : H12AffineFastState.Bounded env5238 := by
  intro p hp
  have h : env5238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5235_5238 : H12AffineEnvironment.transform 29 360609 env5235 = env5238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env5235 == env5238) = true)

theorem identity5238 : scanCanonicalize (H12AffineFastState.compose env5238 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48237) := by decide +kernel

theorem selectedBound5238 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5239 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,524288,32768,4097,563301,5456,98305,628837,325,536652,1044,1045,81100,4164,4294967296,5445,4295536742,4097,637677]

theorem envBound5239 : H12AffineFastState.Bounded env5239 := by
  intro p hp
  have h : env5239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5238_5239 : H12AffineEnvironment.transform 17 48237 env5238 = env5239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48237 env5238 == env5239) = true)

def env5240 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,524288,32768,4097,563301,5204,98305,628837,65,536652,1044,1045,81100,4164,4294967296,5185,4295536742,4097,637677]

theorem envBound5240 : H12AffineFastState.Bounded env5240 := by
  intro p hp
  have h : env5240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5239_5240 : H12AffineEnvironment.transform 7 4 env5239 = env5240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5239 == env5240) = true)

theorem identity5240 : scanCanonicalize (H12AffineFastState.compose env5240 (packedSelected [1,3,8,10,31] rootPS)) = affineNative (2^(18+1) ^^^ 112876) := by decide +kernel

theorem selectedBound5240 : packedSelected [1,3,8,10,31] rootPS < 2^1333 := by decide +kernel

def env5241 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,112876,32768,4097,73865,5204,98305,8329,65,100512,1044,1045,81100,4164,4294967296,5185,4295035018,4097,513]

theorem envBound5241 : H12AffineFastState.Bounded env5241 := by
  intro p hp
  have h : env5241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5240_5241 : H12AffineEnvironment.transform 18 112876 env5240 = env5241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 112876 env5240 == env5241) = true)

theorem identity5241 : scanCanonicalize (H12AffineFastState.compose env5241 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 2730) := by decide +kernel

theorem selectedBound5241 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env5242 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,2730,4177,32768,65536,4097,38599,102982,32768,4097,68131,5204,98305,2595,65,100512,1044,1045,71270,4164,4294967296,5185,4295035018,4097,513]

theorem envBound5242 : H12AffineFastState.Bounded env5242 := by
  intro p hp
  have h : env5242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5241_5242 : H12AffineEnvironment.transform 12 2730 env5241 = env5242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2730 env5241 == env5242) = true)

theorem identity5242 : scanCanonicalize (H12AffineFastState.compose env5242 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1740) := by decide +kernel

theorem selectedBound5242 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env5243 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2730,1693,32768,65536,1741,32779,99466,32768,1741,68131,664,98305,2595,65,100512,1044,1045,65706,1672,4294967296,653,4295035018,1741,513]

theorem envBound5243 : H12AffineFastState.Bounded env5243 := by
  intro p hp
  have h : env5243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5242_5243 : H12AffineEnvironment.transform 11 1740 env5242 = env5243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1740 env5242 == env5243) = true)

def env5244 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2730,1693,32768,2176,1741,32779,35850,32768,1741,675,664,34945,2595,65,32800,1044,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5244 : H12AffineFastState.Bounded env5244 := by
  intro p hp
  have h : env5244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5243_5244 : H12AffineEnvironment.transform 15 2176 env5243 = env5244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env5243 == env5244) = true)

theorem identity5244 : scanCanonicalize (H12AffineFastState.compose env5244 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2139) := by decide +kernel

theorem selectedBound5244 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5245 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2730,1693,2139,2176,1741,2128,1105,2139,1741,675,664,218,2595,65,2171,1044,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5245 : H12AffineFastState.Bounded env5245 := by
  intro p hp
  have h : env5245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5244_5245 : H12AffineEnvironment.transform 14 2139 env5244 = env5245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2139 env5244 == env5245) = true)

def env5246 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2730,1693,32768,2177,1741,32779,35851,32768,1741,674,664,34944,2595,65,32801,1044,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5246 : H12AffineFastState.Bounded env5246 := by
  intro p hp
  have h : env5246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5243_5246 : H12AffineEnvironment.transform 15 2177 env5243 = env5246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env5243 == env5246) = true)

theorem identity5246 : scanCanonicalize (H12AffineFastState.compose env5246 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2161) := by decide +kernel

theorem selectedBound5246 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5247 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2730,1693,2161,2177,1741,2170,1146,2161,1741,674,664,241,2595,65,2128,1044,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5247 : H12AffineFastState.Bounded env5247 := by
  intro p hp
  have h : env5247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5246_5247 : H12AffineEnvironment.transform 14 2161 env5246 = env5247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2161 env5246 == env5247) = true)

theorem identity5247 : scanCanonicalize (H12AffineFastState.compose env5247 (packedSelected [2,4,5,8] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound5247 : packedSelected [2,4,5,8] rootPS < 2^1333 := by decide +kernel

def env5248 : List Nat := [2,4,8,16,32,59,128,4,512,1024,2048,1719,2730,1693,2058,2177,1718,2049,1025,2058,1718,674,664,138,2595,58,2091,1044,1045,2091,1672,4294967296,653,4294967307,1718,513]

theorem envBound5248 : H12AffineFastState.Bounded env5248 := by
  intro p hp
  have h : env5248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5247_5248 : H12AffineEnvironment.transform 5 59 env5247 = env5248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env5247 == env5248) = true)

def env5249 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,524288,32768,4097,563301,5205,98305,628837,64,536652,1044,1045,81100,4164,4294967296,5184,4295536742,4097,637677]

theorem envBound5249 : H12AffineFastState.Bounded env5249 := by
  intro p hp
  have h : env5249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5239_5249 : H12AffineEnvironment.transform 7 5 env5239 = env5249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5239 == env5249) = true)

theorem identity5249 : scanCanonicalize (H12AffineFastState.compose env5249 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(18+1) ^^^ 14438) := by decide +kernel

theorem selectedBound5249 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5250 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,14438,32768,4097,40963,5205,98305,106499,64,2090,1044,1045,81100,4164,4294967296,5184,4295002112,4097,98955]

theorem envBound5250 : H12AffineFastState.Bounded env5250 := by
  intro p hp
  have h : env5250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5249_5250 : H12AffineEnvironment.transform 18 14438 env5249 = env5250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 14438 env5249 == env5250) = true)

theorem identity5250 : scanCanonicalize (H12AffineFastState.compose env5250 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1093) := by decide +kernel

theorem selectedBound5250 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env5251 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1044,32768,65536,1092,43048,11299,32768,1092,40963,16,98305,106499,64,2090,1044,1045,75913,1025,4294967296,5,4295002112,1092,98955]

theorem envBound5251 : H12AffineFastState.Bounded env5251 := by
  intro p hp
  have h : env5251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5250_5251 : H12AffineEnvironment.transform 11 1093 env5250 = env5251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1093 env5250 == env5251) = true)

theorem identity5251 : scanCanonicalize (H12AffineFastState.compose env5251 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 2209) := by decide +kernel

theorem selectedBound5251 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5252 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1044,32768,2209,1092,43048,11299,32768,1092,40963,16,34976,43170,64,2090,1044,1045,8232,1025,4294967296,5,4295002112,1092,35370]

theorem envBound5252 : H12AffineFastState.Bounded env5252 := by
  intro p hp
  have h : env5252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5251_5252 : H12AffineEnvironment.transform 15 2209 env5251 = env5252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2209 env5251 == env5252) = true)

theorem identity5252 : scanCanonicalize (H12AffineFastState.compose env5252 (packedSelected [1,3,12,13,15,21] rootPS)) = affineNative (2^(12+1) ^^^ 2083) := by decide +kernel

theorem selectedBound5252 : packedSelected [1,3,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env5253 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,2083,1044,32768,2209,1092,32779,1024,32768,1092,34848,16,34976,32897,64,2090,1044,1045,2059,1025,4294967296,5,4295002112,1092,35370]

theorem envBound5253 : H12AffineFastState.Bounded env5253 := by
  intro p hp
  have h : env5253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5252_5253 : H12AffineEnvironment.transform 12 2083 env5252 = env5253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2083 env5252 == env5253) = true)

theorem identity5253 : scanCanonicalize (H12AffineFastState.compose env5253 (packedSelected [1,3,10,13,15] rootPS)) = affineNative (2^(14+1) ^^^ 2091) := by decide +kernel

theorem selectedBound5253 : packedSelected [1,3,10,13,15] rootPS < 2^1333 := by decide +kernel

def env5254 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,2083,1044,2091,2209,1092,2080,1024,2091,1092,11,16,139,2218,64,2090,1044,1045,2059,1025,4294967296,5,4294967339,1092,513]

theorem envBound5254 : H12AffineFastState.Bounded env5254 := by
  intro p hp
  have h : env5254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5253_5254 : H12AffineEnvironment.transform 14 2091 env5253 = env5254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2091 env5253 == env5254) = true)

theorem identity5254 : scanCanonicalize (H12AffineFastState.compose env5254 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound5254 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5255 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,2083,1044,2091,2209,1092,2080,1024,2091,1092,11,16,139,2218,64,2090,1044,1045,2059,1025,123,5,80,1092,513]

theorem envBound5255 : H12AffineFastState.Bounded env5255 := by
  intro p hp
  have h : env5255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5254_5255 : H12AffineEnvironment.transform 31 123 env5254 = env5255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env5254 == env5255) = true)

theorem identity5255 : scanCanonicalize (H12AffineFastState.compose env5255 (packedSelected [2,4,7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5255 : packedSelected [2,4,7] rootPS < 2^1333 := by decide +kernel

def env5256 : List Nat := [2,4,3,16,32,64,128,5,512,1024,2048,1093,2083,1044,2080,2209,1092,2080,1024,2080,1092,0,16,128,2209,64,2081,1044,1045,2048,1025,112,5,80,1092,513]

theorem envBound5256 : H12AffineFastState.Bounded env5256 := by
  intro p hp
  have h : env5256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5255_5256 : H12AffineEnvironment.transform 2 3 env5255 = env5256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5255 == env5256) = true)

theorem identity5256 : scanCanonicalize (H12AffineFastState.compose env5256 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5256 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5257 : List Nat := [2,4,3,16,32,17,128,5,512,1024,2048,1044,2083,1044,2080,2209,1045,2080,1024,2080,1045,0,16,128,2209,17,2081,1044,1045,2048,1025,33,5,1,1045,513]

theorem envBound5257 : H12AffineFastState.Bounded env5257 := by
  intro p hp
  have h : env5257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5256_5257 : H12AffineEnvironment.transform 5 17 env5256 = env5257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5256 == env5257) = true)

theorem identity5257 : scanCanonicalize (H12AffineFastState.compose env5257 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound5257 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5258 : List Nat := [2,4,3,16,32,17,19,5,512,1024,2048,1044,2083,1044,2080,2098,1045,2080,1024,2080,1045,0,16,19,2098,17,2081,1044,1045,2048,1025,33,5,1,1045,513]

theorem envBound5258 : H12AffineFastState.Bounded env5258 := by
  intro p hp
  have h : env5258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5257_5258 : H12AffineEnvironment.transform 6 19 env5257 = env5258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env5257 == env5258) = true)

theorem identity5258 : scanCanonicalize (H12AffineFastState.compose env5258 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 16) := by decide +kernel

theorem selectedBound5258 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5259 : List Nat := [2,4,3,16,32,17,19,5,16,1024,2048,1044,2083,1044,2080,2098,1045,2080,1024,2080,1045,0,16,19,2098,17,2081,1044,1045,2048,1025,33,5,1,1045,17]

theorem envBound5259 : H12AffineFastState.Bounded env5259 := by
  intro p hp
  have h : env5259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5258_5259 : H12AffineEnvironment.transform 8 16 env5258 = env5259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 16 env5258 == env5259) = true)

def env5260 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,536870912,1073741824,553878608,4294967296,537002320,4417151347,34359738368,33563272]

theorem envBound5260 : H12AffineFastState.Bounded env5260 := by
  intro p hp
  have h : env5260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2854_5260 : H12AffineEnvironment.transform 27 67130625 env2854 = env5260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 27 67130625 env2854 == env5260) = true)

def env5261 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,536870912,1073741824,553878608,4294967296,537002320,4417151347,694534144,33563272]

theorem envBound5261 : H12AffineFastState.Bounded env5261 := by
  intro p hp
  have h : env5261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5260_5261 : H12AffineEnvironment.transform 34 694534144 env5260 = env5261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534144 env5260 == env5261) = true)

def env5262 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,157794304,1073741824,140788816,4294967296,157663568,4417151347,131072,33563272]

theorem envBound5262 : H12AffineFastState.Bounded env5262 := by
  intro p hp
  have h : env5262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5261_5262 : H12AffineEnvironment.transform 28 157794304 env5261 = env5262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env5261 == env5262) = true)

theorem identity5262 : scanCanonicalize (H12AffineFastState.compose env5262 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 6570324) := by decide +kernel

theorem selectedBound5262 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env5263 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,6570324,67130625,17006932,1073741824,1284,4294967296,16875524,4417151347,131072,33563272]

theorem envBound5263 : H12AffineFastState.Bounded env5263 := by
  intro p hp
  have h : env5263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5262_5263 : H12AffineEnvironment.transform 26 6570324 env5262 = env5263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 6570324 env5262 == env5263) = true)

def env5264 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,6570324,67130625,16876564,1073741824,1284,4294967296,16875524,4417151347,1344,33563272]

theorem envBound5264 : H12AffineFastState.Bounded env5264 := by
  intro p hp
  have h : env5264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5263_5264 : H12AffineEnvironment.transform 16 1344 env5263 = env5264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env5263 == env5264) = true)

def env5265 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4096,4194304,17665,16777216,33554432,67108864,4477268,67130625,16876564,1073741824,1284,4294967296,16875524,4417151347,1344,33563272]

theorem envBound5265 : H12AffineFastState.Bounded env5265 := by
  intro p hp
  have h : env5265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5264_5265 : H12AffineEnvironment.transform 20 4096 env5264 = env5265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env5264 == env5265) = true)

theorem identity5265 : scanCanonicalize (H12AffineFastState.compose env5265 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound5265 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env5266 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4096,4194304,17665,16777216,33554432,5376,4477268,16385,16876564,1073741824,1284,4294967296,16875524,4350047347,1344,33563272]

theorem envBound5266 : H12AffineFastState.Bounded env5266 := by
  intro p hp
  have h : env5266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5265_5266 : H12AffineEnvironment.transform 25 5376 env5265 = env5266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env5265 == env5266) = true)

def env5267 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17665,16777216,33554432,67108864,4477269,67130625,16876564,1073741824,1284,4294967296,16875524,4417151347,1344,33563272]

theorem envBound5267 : H12AffineFastState.Bounded env5267 := by
  intro p hp
  have h : env5267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5264_5267 : H12AffineEnvironment.transform 20 4097 env5264 = env5267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env5264 == env5267) = true)

def env5268 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,6570324,67130625,16876565,1073741824,1284,4294967296,16875524,4417151347,1345,33563272]

theorem envBound5268 : H12AffineFastState.Bounded env5268 := by
  intro p hp
  have h : env5268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5263_5268 : H12AffineEnvironment.transform 16 1345 env5263 = env5268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env5263 == env5268) = true)

def env5269 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17665,16777216,33554432,67108864,4477268,67130625,16876565,1073741824,1284,4294967296,16875524,4417151347,1345,33563272]

theorem envBound5269 : H12AffineFastState.Bounded env5269 := by
  intro p hp
  have h : env5269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5268_5269 : H12AffineEnvironment.transform 20 4096 env5268 = env5269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env5268 == env5269) = true)

theorem identity5269 : scanCanonicalize (H12AffineFastState.compose env5269 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 16880645) := by decide +kernel

theorem selectedBound5269 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env5270 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17665,16777216,33554432,16880645,4477268,16892164,16876565,1073741824,1284,4294967296,16875524,4333368694,1345,33563272]

theorem envBound5270 : H12AffineFastState.Bounded env5270 := by
  intro p hp
  have h : env5270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5269_5270 : H12AffineEnvironment.transform 25 16880645 env5269 = env5270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 16880645 env5269 == env5270) = true)

def env5271 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4096,4194304,17665,16777216,33554432,16880645,4477268,16892164,16876565,1073741824,1284,4294967296,16875524,4332843382,1345,33563272]

theorem envBound5271 : H12AffineFastState.Bounded env5271 := by
  intro p hp
  have h : env5271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5270_5271 : H12AffineEnvironment.transform 18 1024 env5270 = env5271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env5270 == env5271) = true)

theorem identity5271 : scanCanonicalize (H12AffineFastState.compose env5271 (packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS)) = affineNative (2^(29+1) ^^^ 20973966) := by decide +kernel

theorem selectedBound5271 : packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS < 2^1333 := by decide +kernel

def env5272 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4096,4194304,17665,16777216,33554432,16880645,4477268,16892164,16876565,20973966,1284,4294967296,16875524,4332843382,1345,33563272]

theorem envBound5272 : H12AffineFastState.Bounded env5272 := by
  intro p hp
  have h : env5272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5271_5272 : H12AffineEnvironment.transform 29 20973966 env5271 = env5272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 20973966 env5271 == env5272) = true)

def env5273 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,1024,32768,4096,8200,17665,16777216,33554432,16880645,291164,16892164,16876565,16787846,1284,4294967296,16875524,4328640894,1345,33563272]

theorem envBound5273 : H12AffineFastState.Bounded env5273 := by
  intro p hp
  have h : env5273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5272_5273 : H12AffineEnvironment.transform 21 8200 env5272 = env5273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 8200 env5272 == env5273) = true)

def env5274 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,10880,65536,1345,262144,1024,10880,4096,8200,17665,16777216,33554432,16858757,291164,16870276,16854677,16787846,1284,4294967296,16853636,4328619006,1345,33563272]

theorem envBound5274 : H12AffineFastState.Bounded env5274 := by
  intro p hp
  have h : env5274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5273_5274 : H12AffineEnvironment.transform 14 10880 env5273 = env5274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10880 env5273 == env5274) = true)

def env5275 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8200,17665,16777216,33554432,16856709,291164,16868228,16852629,16785798,1284,4294967296,16851588,4328616958,1345,33563272]

theorem envBound5275 : H12AffineFastState.Bounded env5275 := by
  intro p hp
  have h : env5275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5274_5275 : H12AffineEnvironment.transform 10 0 env5274 = env5275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5274 == env5275) = true)

theorem identity5275 : scanCanonicalize (H12AffineFastState.compose env5275 (packedSelected [11] rootPS)) = affineNative (2^(24+1) ^^^ 354283) := by decide +kernel

theorem selectedBound5275 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5276 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,262144,1024,8832,4096,8200,17665,16777216,354283,16856709,291164,16868228,16852629,16785798,1284,4294967296,16851588,4295234581,1345,345443]

theorem envBound5276 : H12AffineFastState.Bounded env5276 := by
  intro p hp
  have h : env5276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5275_5276 : H12AffineEnvironment.transform 24 354283 env5275 = env5276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 354283 env5275 == env5276) = true)

def env5277 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,5392,1024,8832,4096,8200,17665,16777216,94971,16856709,25676,16868228,16852629,16785798,1284,4294967296,16851588,4294967557,1345,86131]

theorem envBound5277 : H12AffineFastState.Bounded env5277 := by
  intro p hp
  have h : env5277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5276_5277 : H12AffineEnvironment.transform 17 5392 env5276 = env5277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5392 env5276 == env5277) = true)

def env5278 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,65536,1345,0,1024,8832,1296,8200,17665,16777216,92139,16851861,25676,16868228,16852629,16785798,1284,4294967296,16851588,4294967557,1345,83299]

theorem envBound5278 : H12AffineFastState.Bounded env5278 := by
  intro p hp
  have h : env5278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5277_5278 : H12AffineEnvironment.transform 11 1296 env5277 = env5278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5277 == env5278) = true)

theorem identity5278 : scanCanonicalize (H12AffineFastState.compose env5278 (packedSelected [20] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound5278 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5279 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,16384,261,65536,1345,0,1024,261,1296,909,17665,16777216,83054,16842768,18377,16859137,16844048,16777731,1284,4294967296,16843009,4294967557,1345,83299]

theorem envBound5279 : H12AffineFastState.Bounded env5279 := by
  intro p hp
  have h : env5279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5278_5279 : H12AffineEnvironment.transform 12 901 env5278 = env5279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env5278 == env5279) = true)

theorem identity5279 : scanCanonicalize (H12AffineFastState.compose env5279 (packedSelected [1,3,5,8,10,17,21,26] rootPS)) = affineNative (2^(23+1) ^^^ 66217) := by decide +kernel

theorem selectedBound5279 : packedSelected [1,3,5,8,10,17,21,26] rootPS < 2^1333 := by decide +kernel

def env5280 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,16384,261,65536,1345,0,1024,261,1296,909,17665,66217,83054,697,18377,17064,1977,65706,1284,4294967296,936,4294967557,1345,83299]

theorem envBound5280 : H12AffineFastState.Bounded env5280 := by
  intro p hp
  have h : env5280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5279_5280 : H12AffineEnvironment.transform 23 66217 env5279 = env5280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 66217 env5279 == env5280) = true)

theorem identity5280 : scanCanonicalize (H12AffineFastState.compose env5280 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,17,22,23] rootPS)) = affineNative (2^(13+1) ^^^ 2024) := by decide +kernel

theorem selectedBound5280 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,17,22,23] rootPS < 2^1333 := by decide +kernel

def env5281 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,2024,261,65536,1345,0,1024,261,1296,909,745,66217,66438,697,33,1344,1977,65706,1284,4294967296,936,4294967557,1345,66187]

theorem envBound5281 : H12AffineFastState.Bounded env5281 := by
  intro p hp
  have h : env5281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5280_5281 : H12AffineEnvironment.transform 13 2024 env5280 = env5281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2024 env5280 == env5281) = true)

theorem identity5281 : scanCanonicalize (H12AffineFastState.compose env5281 (packedSelected [1,3,5,8,12,13,15,18,21] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound5281 : packedSelected [1,3,5,8,12,13,15,18,21] rootPS < 2^1333 := by decide +kernel

def env5282 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1296,301,1344,261,65536,1345,0,1024,261,1296,293,65,65537,65838,17,33,1344,1297,65706,1284,4294967296,256,4294967557,1345,65571]

theorem envBound5282 : H12AffineFastState.Bounded env5282 := by
  intro p hp
  have h : env5282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5281_5282 : H12AffineEnvironment.transform 8 168 env5281 = env5282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env5281 == env5282) = true)

theorem identity5282 : scanCanonicalize (H12AffineFastState.compose env5282 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5282 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5283 : List Nat := [2,4,8,16,1,64,128,256,137,1024,0,1296,268,1344,261,65536,1345,0,1024,261,1296,260,65,65537,65807,17,0,1344,1297,65675,1284,4294967296,256,4294967557,1345,65538]

theorem envBound5283 : H12AffineFastState.Bounded env5283 := by
  intro p hp
  have h : env5283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5282_5283 : H12AffineEnvironment.transform 4 1 env5282 = env5283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5282 == env5283) = true)

theorem identity5283 : scanCanonicalize (H12AffineFastState.compose env5283 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound5283 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5284 : List Nat := [2,4,8,16,1,64,128,256,137,1024,0,1296,268,1344,261,139,1345,0,1024,261,1296,260,65,138,388,17,0,1344,1297,0,1284,4294967296,256,4294967557,1345,137]

theorem envBound5284 : H12AffineFastState.Bounded env5284 := by
  intro p hp
  have h : env5284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5283_5284 : H12AffineEnvironment.transform 15 139 env5283 = env5284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env5283 == env5284) = true)

theorem identity5284 : scanCanonicalize (H12AffineFastState.compose env5284 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 81) := by decide +kernel

theorem selectedBound5284 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5285 : List Nat := [2,4,8,16,1,64,81,256,88,1024,0,1296,268,1344,261,90,1345,0,1024,261,1296,260,65,91,341,17,0,1344,1297,0,1284,4294967296,256,4294967557,1345,88]

theorem envBound5285 : H12AffineFastState.Bounded env5285 := by
  intro p hp
  have h : env5285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5284_5285 : H12AffineEnvironment.transform 6 81 env5284 = env5285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 81 env5284 == env5285) = true)

theorem identity5285 : scanCanonicalize (H12AffineFastState.compose env5285 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 13) := by decide +kernel

theorem selectedBound5285 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5286 : List Nat := [2,4,8,16,1,64,81,13,88,1024,0,1053,1,1101,8,90,1100,0,1024,8,1053,9,65,91,88,17,0,1101,1052,0,1033,4294967296,13,4294967304,1100,88]

theorem envBound5286 : H12AffineFastState.Bounded env5286 := by
  intro p hp
  have h : env5286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5285_5286 : H12AffineEnvironment.transform 7 13 env5285 = env5286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 13 env5285 == env5286) = true)

theorem identity5286 : scanCanonicalize (H12AffineFastState.compose env5286 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 82) := by decide +kernel

theorem selectedBound5286 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5287 : List Nat := [2,4,8,16,1,64,81,13,88,1024,0,1053,1,1101,8,90,1100,0,1024,8,1053,9,65,91,88,17,0,1101,1052,0,1033,82,13,90,1100,88]

theorem envBound5287 : H12AffineFastState.Bounded env5287 := by
  intro p hp
  have h : env5287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5286_5287 : H12AffineEnvironment.transform 31 82 env5286 = env5287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 82 env5286 == env5287) = true)

theorem identity5287 : scanCanonicalize (H12AffineFastState.compose env5287 (packedSelected [0,6] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5287 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5288 : List Nat := [0,4,8,16,1,64,81,13,88,1024,0,1053,1,1101,8,88,1100,0,1024,8,1053,9,65,89,88,17,0,1101,1052,0,1033,80,13,88,1100,88]

theorem envBound5288 : H12AffineFastState.Bounded env5288 := by
  intro p hp
  have h : env5288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5287_5288 : H12AffineEnvironment.transform 0 0 env5287 = env5288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5287 == env5288) = true)

theorem identity5288 : scanCanonicalize (H12AffineFastState.compose env5288 (packedSelected [0,2] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5288 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env5289 : List Nat := [0,4,1,16,1,64,81,4,81,1024,0,1044,1,1092,1,81,1093,0,1024,1,1044,0,65,80,81,17,0,1092,1045,0,1024,80,4,81,1093,81]

theorem envBound5289 : H12AffineFastState.Bounded env5289 := by
  intro p hp
  have h : env5289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5288_5289 : H12AffineEnvironment.transform 2 1 env5288 = env5289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5288 == env5289) = true)

def env5290 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8200,17665,16777216,92138,16851860,25676,16868228,16852629,16785798,1284,4294967296,16851588,4294967557,1345,83298]

theorem envBound5290 : H12AffineFastState.Bounded env5290 := by
  intro p hp
  have h : env5290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5277_5290 : H12AffineEnvironment.transform 11 1297 env5277 = env5290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5277 == env5290) = true)

theorem identity5290 : scanCanonicalize (H12AffineFastState.compose env5290 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 91213) := by decide +kernel

theorem selectedBound5290 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5291 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,1,1024,8832,1297,8200,17665,91213,92138,18393,25676,1993,17112,83403,1284,4294967296,18121,4294967557,1345,83298]

theorem envBound5291 : H12AffineFastState.Bounded env5291 := by
  intro p hp
  have h : env5291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5290_5291 : H12AffineEnvironment.transform 23 91213 env5290 = env5291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 91213 env5290 == env5291) = true)

theorem identity5291 : scanCanonicalize (H12AffineFastState.compose env5291 (packedSelected [0,1,4,5,6,7,8,9,12,13,15,21,23,24,25,26,31,32] rootPS)) = affineNative (2^(15+1) ^^^ 17898) := by decide +kernel

theorem selectedBound5291 : packedSelected [0,1,4,5,6,7,8,9,12,13,15,21,23,24,25,26,31,32] rootPS < 2^1333 := by decide +kernel

def env5292 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,17898,1345,1,1024,8832,1297,8200,17665,8615,8704,18393,25676,1993,17112,33,1284,4294967296,18121,4294967557,1345,136]

theorem envBound5292 : H12AffineFastState.Bounded env5292 := by
  intro p hp
  have h : env5292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5291_5292 : H12AffineEnvironment.transform 15 17898 env5291 = env5292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 17898 env5291 == env5292) = true)

theorem identity5292 : scanCanonicalize (H12AffineFastState.compose env5292 (packedSelected [3,9,12,13,15,17,22,24] rootPS)) = affineNative (2^(13+1) ^^^ 1124) := by decide +kernel

theorem selectedBound5292 : packedSelected [3,9,12,13,15,17,22,24] rootPS < 2^1333 := by decide +kernel

def env5293 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1124,8832,398,1345,1,1024,8832,1297,8200,357,8615,8704,957,8232,1993,1724,33,1284,4294967296,685,4294967557,1345,136]

theorem envBound5293 : H12AffineFastState.Bounded env5293 := by
  intro p hp
  have h : env5293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5292_5293 : H12AffineEnvironment.transform 13 1124 env5292 = env5293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1124 env5292 == env5293) = true)

theorem identity5293 : scanCanonicalize (H12AffineFastState.compose env5293 (packedSelected [0,4,5,7,8,16,22] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound5293 : packedSelected [0,4,5,7,8,16,22] rootPS < 2^1333 := by decide +kernel

def env5294 : List Nat := [2,4,8,16,32,64,128,256,396,1024,0,1297,8192,1124,8460,398,1345,1,1024,8460,1297,8200,357,8615,8588,49,8232,1093,1328,33,1284,4294967296,289,4294967557,1345,136]

theorem envBound5294 : H12AffineFastState.Bounded env5294 := by
  intro p hp
  have h : env5294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5293_5294 : H12AffineEnvironment.transform 8 396 env5293 = env5294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env5293 == env5294) = true)

theorem identity5294 : scanCanonicalize (H12AffineFastState.compose env5294 (packedSelected [5,8] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5294 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5295 : List Nat := [2,4,8,16,1,64,128,256,396,1024,0,1297,8192,1093,8460,398,1345,1,1024,8460,1297,8200,324,8582,8588,16,8201,1093,1297,0,1284,4294967296,256,4294967557,1345,136]

theorem envBound5295 : H12AffineFastState.Bounded env5295 := by
  intro p hp
  have h : env5295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5294_5295 : H12AffineEnvironment.transform 4 1 env5294 = env5295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5294 == env5295) = true)

theorem identity5295 : scanCanonicalize (H12AffineFastState.compose env5295 (packedSelected [0,1,2,3,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 8274) := by decide +kernel

theorem selectedBound5295 : packedSelected [0,1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env5296 : List Nat := [2,4,8,16,1,64,128,256,396,1024,0,1297,8192,1093,8460,398,1345,1,1024,8460,1297,8200,324,8582,8588,16,8201,1093,1297,0,1284,8274,256,8535,1345,136]

theorem envBound5296 : H12AffineFastState.Bounded env5296 := by
  intro p hp
  have h : env5296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5295_5296 : H12AffineEnvironment.transform 31 8274 env5295 = env5296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8274 env5295 == env5296) = true)

theorem identity5296 : scanCanonicalize (H12AffineFastState.compose env5296 (packedSelected [0,1,3,4,7,9,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound5296 : packedSelected [0,1,3,4,7,9,10,12] rootPS < 2^1333 := by decide +kernel

def env5297 : List Nat := [2,4,8,16,1,64,128,256,396,1024,0,1297,8,1093,260,398,1345,1,1024,260,1297,0,324,398,388,16,1,1093,1297,0,1284,90,256,351,1345,136]

theorem envBound5297 : H12AffineFastState.Bounded env5297 := by
  intro p hp
  have h : env5297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5296_5297 : H12AffineEnvironment.transform 12 8 env5296 = env5297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env5296 == env5297) = true)

theorem identity5297 : scanCanonicalize (H12AffineFastState.compose env5297 (packedSelected [1,2,4,7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound5297 : packedSelected [1,2,4,7] rootPS < 2^1333 := by decide +kernel

def env5298 : List Nat := [2,4,8,16,1,64,9,256,261,1024,0,1297,8,1093,260,263,1345,1,1024,260,1297,0,324,263,269,16,1,1093,1297,0,1284,90,256,351,1345,1]

theorem envBound5298 : H12AffineFastState.Bounded env5298 := by
  intro p hp
  have h : env5298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5297_5298 : H12AffineEnvironment.transform 6 9 env5297 = env5298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env5297 == env5298) = true)

theorem identity5298 : scanCanonicalize (H12AffineFastState.compose env5298 (packedSelected [0,1,2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5298 : packedSelected [0,1,2,4] rootPS < 2^1333 := by decide +kernel

def env5299 : List Nat := [2,4,8,16,1,64,9,5,0,1024,0,1044,8,1093,1,2,1092,1,1024,1,1044,0,65,2,8,16,1,1093,1044,0,1025,90,5,90,1092,1]

theorem envBound5299 : H12AffineFastState.Bounded env5299 := by
  intro p hp
  have h : env5299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5298_5299 : H12AffineEnvironment.transform 7 5 env5298 = env5299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5298 == env5299) = true)

theorem identity5299 : scanCanonicalize (H12AffineFastState.compose env5299 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5299 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5300 : List Nat := [2,4,8,16,1,16,9,5,0,1024,0,1044,8,1045,1,2,1044,1,1024,1,1044,0,17,2,8,16,1,1045,1044,0,1025,10,5,10,1044,1]

theorem envBound5300 : H12AffineFastState.Bounded env5300 := by
  intro p hp
  have h : env5300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5299_5300 : H12AffineEnvironment.transform 5 16 env5299 = env5300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5299 == env5300) = true)

theorem identity5300 : scanCanonicalize (H12AffineFastState.compose env5300 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound5300 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5301 : List Nat := [2,4,8,11,1,11,9,5,0,1024,0,1039,8,1038,1,2,1039,1,1024,1,1039,0,10,2,8,11,1,1038,1039,0,1025,10,5,10,1039,1]

theorem envBound5301 : H12AffineFastState.Bounded env5301 := by
  intro p hp
  have h : env5301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5300_5301 : H12AffineEnvironment.transform 3 11 env5300 = env5301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env5300 == env5301) = true)

theorem identity5301 : scanCanonicalize (H12AffineFastState.compose env5301 (packedSelected [3] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound5301 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5302 : List Nat := [2,4,8,11,1,11,9,5,0,15,0,0,8,1,1,2,0,1,15,1,0,0,10,2,8,11,1,1,0,0,14,10,5,10,0,1]

theorem envBound5302 : H12AffineFastState.Bounded env5302 := by
  intro p hp
  have h : env5302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5301_5302 : H12AffineEnvironment.transform 9 15 env5301 = env5302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env5301 == env5302) = true)

def env5303 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,5393,1024,8832,4096,8200,17665,16777216,94970,16856709,25677,16868228,16852629,16785798,1284,4294967296,16851588,4294967556,1345,86130]

theorem envBound5303 : H12AffineFastState.Bounded env5303 := by
  intro p hp
  have h : env5303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5276_5303 : H12AffineEnvironment.transform 17 5393 env5276 = env5303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5393 env5276 == env5303) = true)

def env5304 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,8832,65536,1345,1,1024,8832,1296,8200,17665,16777216,92138,16851861,25677,16868228,16852629,16785798,1284,4294967296,16851588,4294967556,1345,83298]

theorem envBound5304 : H12AffineFastState.Bounded env5304 := by
  intro p hp
  have h : env5304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5303_5304 : H12AffineEnvironment.transform 11 1296 env5303 = env5304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5303 == env5304) = true)

theorem identity5304 : scanCanonicalize (H12AffineFastState.compose env5304 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 1993) := by decide +kernel

theorem selectedBound5304 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5305 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1993,8832,65536,1345,1,1024,8832,1296,8200,712,16777216,73763,16851861,9092,16852045,16852629,16785798,1284,4294967296,16851588,4294967556,1345,66219]

theorem envBound5305 : H12AffineFastState.Bounded env5305 := by
  intro p hp
  have h : env5305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5304_5305 : H12AffineEnvironment.transform 13 1993 env5304 = env5305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1993 env5304 == env5305) = true)

theorem identity5305 : scanCanonicalize (H12AffineFastState.compose env5305 (packedSelected [1,3,16,18,24,28] rootPS)) = affineNative (2^(23+1) ^^^ 66184) := by decide +kernel

theorem selectedBound5305 : packedSelected [1,3,16,18,24,28] rootPS < 2^1333 := by decide +kernel

def env5306 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1993,8832,65536,1345,1,1024,8832,1296,8200,712,66184,73763,8477,9092,9925,9245,74510,1284,4294967296,8204,4294967556,1345,66219]

theorem envBound5306 : H12AffineFastState.Bounded env5306 := by
  intro p hp
  have h : env5306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5305_5306 : H12AffineEnvironment.transform 23 66184 env5305 = env5306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 66184 env5305 == env5306) = true)

theorem identity5306 : scanCanonicalize (H12AffineFastState.compose env5306 (packedSelected [1,3,5,8,12,13,15,16,17,18] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5306 : packedSelected [1,3,5,8,12,13,15,16,17,18] rootPS < 2^1333 := by decide +kernel

def env5307 : List Nat := [2,4,8,16,0,64,128,256,512,1024,0,1296,8192,1993,8832,65536,1345,1,1024,8832,1296,8200,712,66184,73731,8477,9092,9925,9245,74510,1284,4294967296,8204,4294967556,1345,66187]

theorem envBound5307 : H12AffineFastState.Bounded env5307 := by
  intro p hp
  have h : env5307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5306_5307 : H12AffineEnvironment.transform 4 0 env5306 = env5307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5306 == env5307) = true)

theorem identity5307 : scanCanonicalize (H12AffineFastState.compose env5307 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 515) := by decide +kernel

theorem selectedBound5307 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5308 : List Nat := [2,4,8,16,0,64,128,256,512,1024,0,1296,8192,1993,8832,515,1345,1,1024,8832,1296,8200,712,139,8704,8477,9092,9925,9245,8461,1284,4294967296,8204,4294967556,1345,136]

theorem envBound5308 : H12AffineFastState.Bounded env5308 := by
  intro p hp
  have h : env5308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5307_5308 : H12AffineEnvironment.transform 15 515 env5307 = env5308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 515 env5307 == env5308) = true)

theorem identity5308 : scanCanonicalize (H12AffineFastState.compose env5308 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound5308 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env5309 : List Nat := [2,4,8,16,0,64,128,256,512,1024,0,1296,901,1993,261,515,1345,1,1024,261,1296,909,712,139,389,664,1,1344,1944,648,1284,4294967296,905,4294967556,1345,136]

theorem envBound5309 : H12AffineFastState.Bounded env5309 := by
  intro p hp
  have h : env5309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5308_5309 : H12AffineEnvironment.transform 12 901 env5308 = env5309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env5308 == env5309) = true)

theorem identity5309 : scanCanonicalize (H12AffineFastState.compose env5309 (packedSelected [0,1,2,3,4,6,8] rootPS)) = affineNative (2^(8+1) ^^^ 261) := by decide +kernel

theorem selectedBound5309 : packedSelected [0,1,2,3,4,6,8] rootPS < 2^1333 := by decide +kernel

def env5310 : List Nat := [2,4,8,16,0,64,128,256,261,1024,0,1296,128,1228,261,262,1345,1,1024,261,1296,136,461,139,389,413,1,1344,1181,397,1284,4294967296,140,4294967556,1345,136]

theorem envBound5310 : H12AffineFastState.Bounded env5310 := by
  intro p hp
  have h : env5310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5309_5310 : H12AffineEnvironment.transform 8 261 env5309 = env5310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 261 env5309 == env5310) = true)

def env5311 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8200,17665,16777216,92139,16851860,25677,16868228,16852629,16785798,1284,4294967296,16851588,4294967556,1345,83299]

theorem envBound5311 : H12AffineFastState.Bounded env5311 := by
  intro p hp
  have h : env5311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5303_5311 : H12AffineEnvironment.transform 11 1297 env5303 = env5311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5303 == env5311) = true)

theorem identity5311 : scanCanonicalize (H12AffineFastState.compose env5311 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 65536) := by decide +kernel

theorem selectedBound5311 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5312 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,8832,65536,1345,0,1024,8832,1297,8200,17665,65536,92139,9108,25677,25476,9877,74118,1284,4294967296,8836,4294967556,1345,83299]

theorem envBound5312 : H12AffineFastState.Bounded env5312 := by
  intro p hp
  have h : env5312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5311_5312 : H12AffineEnvironment.transform 23 65536 env5311 = env5312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65536 env5311 == env5312) = true)

theorem identity5312 : scanCanonicalize (H12AffineFastState.compose env5312 (packedSelected [1,5,8,17,21,24] rootPS)) = affineNative (2^(13+1) ^^^ 9925) := by decide +kernel

theorem selectedBound5312 : packedSelected [1,5,8,17,21,24] rootPS < 2^1333 := by decide +kernel

def env5313 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,9925,8832,65536,1345,0,1024,8832,1297,8200,9156,65536,65838,9108,648,1345,9877,74118,1284,4294967296,8836,4294967556,1345,74662]

theorem envBound5313 : H12AffineFastState.Bounded env5313 := by
  intro p hp
  have h : env5313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5312_5313 : H12AffineEnvironment.transform 13 9925 env5312 = env5313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9925 env5312 == env5313) = true)

theorem identity5313 : scanCanonicalize (H12AffineFastState.compose env5313 (packedSelected [18] rootPS)) = affineNative (2^(12+1) ^^^ 300) := by decide +kernel

theorem selectedBound5313 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5314 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,300,2025,940,65536,1345,0,1024,940,1297,292,744,65536,65838,696,648,1345,1977,65706,1284,4294967296,936,4294967556,1345,66186]

theorem envBound5314 : H12AffineFastState.Bounded env5314 := by
  intro p hp
  have h : env5314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5313_5314 : H12AffineEnvironment.transform 12 300 env5313 = env5314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 300 env5313 == env5314) = true)

theorem identity5314 : scanCanonicalize (H12AffineFastState.compose env5314 (packedSelected [1,3,5,6,8,12,13,15,17,25] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound5314 : packedSelected [1,3,5,6,8,12,13,15,17,25] rootPS < 2^1333 := by decide +kernel

def env5315 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1297,300,1345,260,65536,1345,0,1024,260,1297,292,64,65536,65838,16,32,1345,1297,65706,1284,4294967296,256,4294967556,1345,65570]

theorem envBound5315 : H12AffineFastState.Bounded env5315 := by
  intro p hp
  have h : env5315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5314_5315 : H12AffineEnvironment.transform 8 168 env5314 = env5315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env5314 == env5315) = true)

theorem identity5315 : scanCanonicalize (H12AffineFastState.compose env5315 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound5315 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5316 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1297,300,1345,260,138,1345,0,1024,260,1297,292,64,138,420,16,32,1345,1297,32,1284,4294967296,256,4294967556,1345,168]

theorem envBound5316 : H12AffineFastState.Bounded env5316 := by
  intro p hp
  have h : env5316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5315_5316 : H12AffineEnvironment.transform 15 138 env5315 = env5316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env5315 == env5316) = true)

theorem identity5316 : scanCanonicalize (H12AffineFastState.compose env5316 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound5316 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env5317 : List Nat := [2,4,8,16,32,64,128,14,168,1024,0,1055,34,1103,10,138,1103,0,1024,10,1055,42,64,138,170,16,32,1103,1055,32,1034,4294967296,14,4294967306,1103,168]

theorem envBound5317 : H12AffineFastState.Bounded env5317 := by
  intro p hp
  have h : env5317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5316_5317 : H12AffineEnvironment.transform 7 14 env5316 = env5317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env5316 == env5317) = true)

theorem identity5317 : scanCanonicalize (H12AffineFastState.compose env5317 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound5317 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5318 : List Nat := [2,4,8,16,32,64,40,14,0,1024,0,1055,34,1103,10,34,1103,0,1024,10,1055,42,64,34,2,16,32,1103,1055,32,1034,4294967296,14,4294967306,1103,0]

theorem envBound5318 : H12AffineFastState.Bounded env5318 := by
  intro p hp
  have h : env5318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5317_5318 : H12AffineEnvironment.transform 6 40 env5317 = env5318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env5317 == env5318) = true)

theorem identity5318 : scanCanonicalize (H12AffineFastState.compose env5318 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 3) := by decide +kernel

theorem selectedBound5318 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5319 : List Nat := [2,4,8,16,32,64,40,14,0,1024,0,1055,34,1103,10,34,1103,0,1024,10,1055,42,64,34,2,16,32,1103,1055,32,1034,3,14,9,1103,0]

theorem envBound5319 : H12AffineFastState.Bounded env5319 := by
  intro p hp
  have h : env5319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5318_5319 : H12AffineEnvironment.transform 31 3 env5318 = env5319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 3 env5318 == env5319) = true)

theorem identity5319 : scanCanonicalize (H12AffineFastState.compose env5319 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 25) := by decide +kernel

theorem selectedBound5319 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5320 : List Nat := [2,4,8,16,32,25,40,14,0,1024,0,1055,34,1046,10,34,1046,0,1024,10,1055,42,25,34,2,16,32,1046,1055,32,1034,3,14,9,1046,0]

theorem envBound5320 : H12AffineFastState.Bounded env5320 := by
  intro p hp
  have h : env5320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5319_5320 : H12AffineEnvironment.transform 5 25 env5319 = env5320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env5319 == env5320) = true)

theorem identity5320 : scanCanonicalize (H12AffineFastState.compose env5320 (packedSelected [1,2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5320 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env5321 : List Nat := [2,4,2,16,32,19,34,4,0,1024,0,1045,34,1046,0,34,1046,0,1024,0,1045,32,19,34,2,16,32,1046,1045,32,1024,3,4,3,1046,0]

theorem envBound5321 : H12AffineFastState.Bounded env5321 := by
  intro p hp
  have h : env5321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5320_5321 : H12AffineEnvironment.transform 2 2 env5320 = env5321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5320 == env5321) = true)

theorem identity5321 : scanCanonicalize (H12AffineFastState.compose env5321 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5321 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5322 : List Nat := [2,4,2,16,0,19,2,4,0,1024,0,1045,2,1046,0,2,1046,0,1024,0,1045,0,19,2,2,16,0,1046,1045,0,1024,3,4,3,1046,0]

theorem envBound5322 : H12AffineFastState.Bounded env5322 := by
  intro p hp
  have h : env5322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5321_5322 : H12AffineEnvironment.transform 4 0 env5321 = env5322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5321 == env5322) = true)

theorem identity5322 : scanCanonicalize (H12AffineFastState.compose env5322 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 6) := by decide +kernel

theorem selectedBound5322 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5323 : List Nat := [2,4,2,16,0,19,2,4,0,6,0,19,2,16,0,2,16,0,6,0,19,0,19,2,2,16,0,16,19,0,6,3,4,3,16,0]

theorem envBound5323 : H12AffineFastState.Bounded env5323 := by
  intro p hp
  have h : env5323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5322_5323 : H12AffineEnvironment.transform 9 6 env5322 = env5323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 6 env5322 == env5323) = true)

theorem identity5323 : scanCanonicalize (H12AffineFastState.compose env5323 (packedSelected [13] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5323 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env5324 : List Nat := [1,4,1,16,0,16,1,4,0,5,0,16,1,16,0,1,16,0,5,0,16,0,16,1,1,16,0,16,16,0,5,0,4,0,16,0]

theorem envBound5324 : H12AffineFastState.Bounded env5324 := by
  intro p hp
  have h : env5324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5323_5324 : H12AffineEnvironment.transform 0 1 env5323 = env5324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5323 == env5324) = true)

def leafEnv5324 : List Nat := [1,4,1,16,0,16,1,4,0,5,0,16,1,16,0,1,16,0,5,0,16,0,16,1,5,1,1,16,0,16,16,0,5,0,4,0,4,1,16,0,0,16,1]

def active5324 : List Nat := [1,3]

def tree5324 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5324 : H12WitnessSearch.Good tree5324 := H12GlobalWitnessIndex.good

theorem leafIdentity5324 : H12AffineFastState.composeSystem env5324 rootObs = leafEnv5324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5324 rootObs == leafEnv5324) = true)

theorem terminalChecked5324 : H12PackedTerminal.terminalCheckFast leafEnv5324 active5324 tree5324 = true := by decide +kernel

def env5325 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,262144,1024,8833,4096,8200,17665,16777216,33554432,16856708,291164,16868229,16852628,16785799,1284,4294967296,16851589,4328616959,1345,33563272]

theorem envBound5325 : H12AffineFastState.Bounded env5325 := by
  intro p hp
  have h : env5325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5274_5325 : H12AffineEnvironment.transform 10 1 env5274 = env5325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5274 == env5325) = true)

theorem identity5325 : scanCanonicalize (H12AffineFastState.compose env5325 (packedSelected [11] rootPS)) = affineNative (2^(24+1) ^^^ 17065930) := by decide +kernel

theorem selectedBound5325 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5326 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,262144,1024,8833,4096,8200,17665,16777216,17065930,16856708,291164,16868229,16852628,16785799,1284,4294967296,16851589,4312077365,1345,17057090]

theorem envBound5326 : H12AffineFastState.Bounded env5326 := by
  intro p hp
  have h : env5326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5325_5326 : H12AffineEnvironment.transform 24 17065930 env5325 = env5326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17065930 env5325 == env5326) = true)

def env5327 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,5392,1024,8833,4096,8200,17665,16777216,16806618,16856708,25676,16868229,16852628,16785799,1284,4294967296,16851589,4311810341,1345,16797778]

theorem envBound5327 : H12AffineFastState.Bounded env5327 := by
  intro p hp
  have h : env5327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5326_5327 : H12AffineEnvironment.transform 17 5392 env5326 = env5327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5392 env5326 == env5327) = true)

def env5328 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,65536,1345,0,1024,8833,1296,8200,17665,16777216,16803786,16851860,25676,16868229,16852628,16785799,1284,4294967296,16851589,4311810341,1345,16794946]

theorem envBound5328 : H12AffineFastState.Bounded env5328 := by
  intro p hp
  have h : env5328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5327_5328 : H12AffineEnvironment.transform 11 1296 env5327 = env5328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5327 == env5328) = true)

theorem identity5328 : scanCanonicalize (H12AffineFastState.compose env5328 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound5328 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5329 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,547,1345,0,1024,8833,1296,8200,17665,16777216,16803786,16785847,25676,16802214,16786615,16785799,1284,4294967296,16785574,4311745286,1345,16794946]

theorem envBound5329 : H12AffineFastState.Bounded env5329 := by
  intro p hp
  have h : env5329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5328_5329 : H12AffineEnvironment.transform 15 547 env5328 = env5329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env5328 == env5329) = true)

theorem identity5329 : scanCanonicalize (H12AffineFastState.compose env5329 (packedSelected [1,3,5,8,10,17,18,21,26] rootPS)) = affineNative (2^(13+1) ^^^ 1376) := by decide +kernel

theorem selectedBound5329 : packedSelected [1,3,5,8,10,17,18,21,26] rootPS < 2^1333 := by decide +kernel

def env5330 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1376,8833,547,1345,0,1024,8833,1296,8200,97,16777216,16786090,16785847,8492,16786630,16786615,16785799,1284,4294967296,16785574,4311745286,1345,16777250]

theorem envBound5330 : H12AffineFastState.Bounded env5330 := by
  intro p hp
  have h : env5330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5329_5330 : H12AffineEnvironment.transform 13 1376 env5329 = env5330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1376 env5329 == env5330) = true)

theorem identity5330 : scanCanonicalize (H12AffineFastState.compose env5330 (packedSelected [1,5,8,17,21,24] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound5330 : packedSelected [1,5,8,17,21,24] rootPS < 2^1333 := by decide +kernel

def env5331 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,8192,1376,8201,171,1345,0,1024,8201,1296,8200,97,16777216,16785442,16785847,8492,16786630,16786615,16785799,1284,4294967296,16785574,4311744910,1345,16777250]

theorem envBound5331 : H12AffineFastState.Bounded env5331 := by
  intro p hp
  have h : env5331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5330_5331 : H12AffineEnvironment.transform 8 136 env5330 = env5331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env5330 == env5331) = true)

def env5332 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,1,1024,8833,1297,8200,17665,16777216,16803787,16851861,25676,16868229,16852628,16785799,1284,4294967296,16851589,4311810341,1345,16794947]

theorem envBound5332 : H12AffineFastState.Bounded env5332 := by
  intro p hp
  have h : env5332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5327_5332 : H12AffineEnvironment.transform 11 1297 env5327 = env5332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5327 == env5332) = true)

theorem identity5332 : scanCanonicalize (H12AffineFastState.compose env5332 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 17898) := by decide +kernel

theorem selectedBound5332 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5333 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,1,1024,8833,1297,8200,17665,17898,8737,91775,25676,75375,91006,25709,1284,4294967296,92015,4295050447,1345,169]

theorem envBound5333 : H12AffineFastState.Bounded env5333 := by
  intro p hp
  have h : env5333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5332_5333 : H12AffineEnvironment.transform 23 17898 env5332 = env5333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 17898 env5332 == env5333) = true)

theorem identity5333 : scanCanonicalize (H12AffineFastState.compose env5333 (packedSelected [1,3,24,28] rootPS)) = affineNative (2^(15+1) ^^^ 26223) := by decide +kernel

theorem selectedBound5333 : packedSelected [1,3,24,28] rootPS < 2^1333 := by decide +kernel

def env5334 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,26223,1345,1,1024,8833,1297,8200,17665,17898,8737,16,25676,16384,1297,25709,1284,4294967296,256,4294976160,1345,169]

theorem envBound5334 : H12AffineFastState.Bounded env5334 := by
  intro p hp
  have h : env5334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5333_5334 : H12AffineEnvironment.transform 15 26223 env5333 = env5334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26223 env5333 == env5334) = true)

theorem identity5334 : scanCanonicalize (H12AffineFastState.compose env5334 (packedSelected [1,3,5,8,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound5334 : packedSelected [1,3,5,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5335 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,8192,16384,8201,25831,1345,1,1024,8201,1297,8200,17665,17898,8361,16,25676,16384,1297,25709,1284,4294967296,256,4294975528,1345,169]

theorem envBound5335 : H12AffineFastState.Bounded env5335 := by
  intro p hp
  have h : env5335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5334_5335 : H12AffineEnvironment.transform 8 136 env5334 = env5335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env5334 == env5335) = true)

theorem identity5335 : scanCanonicalize (H12AffineFastState.compose env5335 (packedSelected [0,1,3,4,7,8,9,12,15,18] rootPS)) = affineNative (2^(12+1) ^^^ 128) := by decide +kernel

theorem selectedBound5335 : packedSelected [0,1,3,4,7,8,9,12,15,18] rootPS < 2^1333 := by decide +kernel

def env5336 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,128,16384,137,17511,1345,1,1024,137,1297,136,17665,17898,41,16,17612,16384,1297,17645,1284,4294967296,256,4294967464,1345,169]

theorem envBound5336 : H12AffineFastState.Bounded env5336 := by
  intro p hp
  have h : env5336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5335_5336 : H12AffineEnvironment.transform 12 128 env5335 = env5336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 128 env5335 == env5336) = true)

theorem identity5336 : scanCanonicalize (H12AffineFastState.compose env5336 (packedSelected [1,3,5,10,12,13] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound5336 : packedSelected [1,3,5,10,12,13] rootPS < 2^1333 := by decide +kernel

def env5337 : List Nat := [2,4,8,16,32,64,128,221,136,1024,1,1228,128,16384,137,17511,1180,1,1024,137,1228,136,17628,17463,41,16,17612,16384,1228,17645,1241,4294967296,221,4294967464,1180,169]

theorem envBound5337 : H12AffineFastState.Bounded env5337 := by
  intro p hp
  have h : env5337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5336_5337 : H12AffineEnvironment.transform 7 221 env5336 = env5337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env5336 == env5337) = true)

theorem identity5337 : scanCanonicalize (H12AffineFastState.compose env5337 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5337 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5338 : List Nat := [2,4,8,16,32,16,128,141,136,1024,1,1180,128,16384,137,17463,1180,1,1024,137,1180,136,17548,17463,41,16,17564,16384,1180,17597,1161,4294967296,141,4294967464,1180,169]

theorem envBound5338 : H12AffineFastState.Bounded env5338 := by
  intro p hp
  have h : env5338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5337_5338 : H12AffineEnvironment.transform 5 16 env5337 = env5338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5337 == env5338) = true)

theorem identity5338 : scanCanonicalize (H12AffineFastState.compose env5338 (packedSelected [1,3,8] rootPS)) = affineNative (2^(13+1) ^^^ 1213) := by decide +kernel

theorem selectedBound5338 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env5339 : List Nat := [2,4,8,16,32,16,128,141,136,1024,1,1180,128,1213,137,138,1180,1,1024,137,1180,136,49,138,41,16,33,1213,1180,0,1161,4294967296,141,4294967464,1180,169]

theorem envBound5339 : H12AffineFastState.Bounded env5339 := by
  intro p hp
  have h : env5339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5338_5339 : H12AffineEnvironment.transform 13 1213 env5338 = env5339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1213 env5338 == env5339) = true)

theorem identity5339 : scanCanonicalize (H12AffineFastState.compose env5339 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5339 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5340 : List Nat := [2,4,8,16,0,16,128,141,136,1024,1,1180,128,1181,137,138,1180,1,1024,137,1180,136,17,138,9,16,1,1181,1180,0,1161,4294967296,141,4294967432,1180,137]

theorem envBound5340 : H12AffineFastState.Bounded env5340 := by
  intro p hp
  have h : env5340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5339_5340 : H12AffineEnvironment.transform 4 0 env5339 = env5340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5339 == env5340) = true)

theorem identity5340 : scanCanonicalize (H12AffineFastState.compose env5340 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound5340 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5341 : List Nat := [2,4,8,16,0,16,128,141,136,1024,1,1180,128,1181,137,138,1180,1,1024,137,1180,136,17,138,9,16,1,1181,1180,0,1161,11,141,131,1180,137]

theorem envBound5341 : H12AffineFastState.Bounded env5341 := by
  intro p hp
  have h : env5341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5340_5341 : H12AffineEnvironment.transform 31 11 env5340 = env5341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env5340 == env5341) = true)

def env5342 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,5393,1024,8833,4096,8200,17665,16777216,16806619,16856708,25677,16868229,16852628,16785799,1284,4294967296,16851589,4311810340,1345,16797779]

theorem envBound5342 : H12AffineFastState.Bounded env5342 := by
  intro p hp
  have h : env5342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5326_5342 : H12AffineEnvironment.transform 17 5393 env5326 = env5342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5393 env5326 == env5342) = true)

def env5343 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,65536,1345,1,1024,8833,1296,8200,17665,16777216,16803787,16851860,25677,16868229,16852628,16785799,1284,4294967296,16851589,4311810340,1345,16794947]

theorem envBound5343 : H12AffineFastState.Bounded env5343 := by
  intro p hp
  have h : env5343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5342_5343 : H12AffineEnvironment.transform 11 1296 env5342 = env5343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5342 == env5343) = true)

theorem identity5343 : scanCanonicalize (H12AffineFastState.compose env5343 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 26223) := by decide +kernel

theorem selectedBound5343 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5344 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,8833,26223,1345,1,1024,8833,1296,8200,17665,16777216,16803787,16795131,25677,16778730,16793851,16785799,1284,4294967296,16794858,4311770955,1345,16794947]

theorem envBound5344 : H12AffineFastState.Bounded env5344 := by
  intro p hp
  have h : env5344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5343_5344 : H12AffineEnvironment.transform 15 26223 env5343 = env5344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26223 env5343 == env5344) = true)

theorem identity5344 : scanCanonicalize (H12AffineFastState.compose env5344 (packedSelected [1,10,26,28] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5344 : packedSelected [1,10,26,28] rootPS < 2^1333 := by decide +kernel

def env5345 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,8192,16384,8200,25830,1345,1,1024,8200,1296,8200,17665,16777216,16803138,16795131,25677,16778730,16793851,16785799,1284,4294967296,16794858,4311770562,1345,16794947]

theorem envBound5345 : H12AffineFastState.Bounded env5345 := by
  intro p hp
  have h : env5345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5344_5345 : H12AffineEnvironment.transform 8 137 env5344 = env5345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5344 == env5345) = true)

theorem identity5345 : scanCanonicalize (H12AffineFastState.compose env5345 (packedSelected [0,1,4,5,7,8,17,21,22,23,24] rootPS)) = affineNative (2^(13+1) ^^^ 1376) := by decide +kernel

theorem selectedBound5345 : packedSelected [0,1,4,5,7,8,17,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env5346 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,8192,1376,8200,8582,1345,1,1024,8200,1296,8200,97,16777216,16785442,16777371,8493,16778730,16778651,16785799,1284,4294967296,16777610,4311752866,1345,16777251]

theorem envBound5346 : H12AffineFastState.Bounded env5346 := by
  intro p hp
  have h : env5346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5345_5346 : H12AffineEnvironment.transform 13 1376 env5345 = env5346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1376 env5345 == env5346) = true)

theorem identity5346 : scanCanonicalize (H12AffineFastState.compose env5346 (packedSelected [0,1,3,4,5,7,8,12,13,15,18,21,22] rootPS)) = affineNative (2^(23+1) ^^^ 430) := by decide +kernel

theorem selectedBound5346 : packedSelected [0,1,3,4,5,7,8,12,13,15,18,21,22] rootPS < 2^1333 := by decide +kernel

def env5347 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,8192,1376,8200,8582,1345,1,1024,8200,1296,8200,97,430,8588,309,8493,1092,1077,8233,1284,4294967296,36,4294975756,1345,397]

theorem envBound5347 : H12AffineFastState.Bounded env5347 := by
  intro p hp
  have h : env5347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5346_5347 : H12AffineEnvironment.transform 23 430 env5346 = env5347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 430 env5346 == env5347) = true)

theorem identity5347 : scanCanonicalize (H12AffineFastState.compose env5347 (packedSelected [5,8,16] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound5347 : packedSelected [5,8,16] rootPS < 2^1333 := by decide +kernel

def env5348 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,1076,8192,1092,8200,8354,1125,1,1024,8200,1076,8200,97,138,8360,17,8201,1092,1077,8233,1056,4294967296,36,4294975528,1125,169]

theorem envBound5348 : H12AffineFastState.Bounded env5348 := by
  intro p hp
  have h : env5348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5347_5348 : H12AffineEnvironment.transform 7 36 env5347 = env5348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env5347 == env5348) = true)

theorem identity5348 : scanCanonicalize (H12AffineFastState.compose env5348 (packedSelected [1,3,5] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound5348 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5349 : List Nat := [2,4,8,16,32,64,121,36,112,1024,1,1076,8192,1092,8200,8283,1125,1,1024,8200,1076,8200,97,115,8273,17,8201,1092,1077,8233,1056,4294967296,36,4294975528,1125,80]

theorem envBound5349 : H12AffineFastState.Bounded env5349 := by
  intro p hp
  have h : env5349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5348_5349 : H12AffineEnvironment.transform 6 121 env5348 = env5349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env5348 == env5349) = true)

theorem identity5349 : scanCanonicalize (H12AffineFastState.compose env5349 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound5349 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5350 : List Nat := [2,4,8,16,32,64,121,36,112,1024,1,1076,40,1092,32,115,1125,1,1024,32,1076,32,97,115,121,17,33,1092,1077,1,1056,4294967296,36,4294967296,1125,80]

theorem envBound5350 : H12AffineFastState.Bounded env5350 := by
  intro p hp
  have h : env5350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5349_5350 : H12AffineEnvironment.transform 12 40 env5349 = env5350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env5349 == env5350) = true)

theorem identity5350 : scanCanonicalize (H12AffineFastState.compose env5350 (packedSelected [0,2,4] rootPS)) = affineNative (2^(31+1) ^^^ 10) := by decide +kernel

theorem selectedBound5350 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env5351 : List Nat := [2,4,8,16,32,64,121,36,112,1024,1,1076,40,1092,32,115,1125,1,1024,32,1076,32,97,115,121,17,33,1092,1077,1,1056,10,36,10,1125,80]

theorem envBound5351 : H12AffineFastState.Bounded env5351 := by
  intro p hp
  have h : env5351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5350_5351 : H12AffineEnvironment.transform 31 10 env5350 = env5351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10 env5350 == env5351) = true)

theorem identity5351 : scanCanonicalize (H12AffineFastState.compose env5351 (packedSelected [0,1,7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5351 : packedSelected [0,1,7] rootPS < 2^1333 := by decide +kernel

def env5352 : List Nat := [2,4,8,16,1,64,88,5,81,1024,1,1045,9,1092,1,82,1092,1,1024,1,1045,1,64,82,88,17,0,1092,1044,1,1025,10,5,10,1092,80]

theorem envBound5352 : H12AffineFastState.Bounded env5352 := by
  intro p hp
  have h : env5352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5351_5352 : H12AffineEnvironment.transform 4 1 env5351 = env5352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5351 == env5352) = true)

theorem identity5352 : scanCanonicalize (H12AffineFastState.compose env5352 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound5352 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5353 : List Nat := [2,4,8,16,1,10,18,5,27,1024,1,1045,9,1038,1,24,1038,1,1024,1,1045,1,10,24,18,17,0,1038,1044,1,1025,10,5,10,1038,26]

theorem envBound5353 : H12AffineFastState.Bounded env5353 := by
  intro p hp
  have h : env5353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5352_5353 : H12AffineEnvironment.transform 5 10 env5352 = env5353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env5352 == env5353) = true)

def leafEnv5353 : List Nat := [2,4,8,16,1,10,18,5,27,1024,1,1045,9,1038,1,24,1038,1,1024,1,1045,1,10,24,1025,18,1,17,0,1038,1044,1,1025,10,5,10,4,3,1038,26,0,1044,1]

def active5353 : List Nat := [0,1,2,3,9]

def tree5353 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5353 : H12WitnessSearch.Good tree5353 := H12GlobalWitnessIndex.good

theorem leafIdentity5353 : H12AffineFastState.composeSystem env5353 rootObs = leafEnv5353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5353 rootObs == leafEnv5353) = true)

theorem terminalChecked5353 : H12PackedTerminal.terminalCheckFast leafEnv5353 active5353 tree5353 = true := by decide +kernel

def env5354 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,0,1024,8833,1297,8200,17665,16777216,16803786,16851861,25677,16868229,16852628,16785799,1284,4294967296,16851589,4311810340,1345,16794946]

theorem envBound5354 : H12AffineFastState.Bounded env5354 := by
  intro p hp
  have h : env5354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5342_5354 : H12AffineEnvironment.transform 11 1297 env5342 = env5354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5342 == env5354) = true)

theorem identity5354 : scanCanonicalize (H12AffineFastState.compose env5354 (packedSelected [20] rootPS)) = affineNative (2^(23+1) ^^^ 8615) := by decide +kernel

theorem selectedBound5354 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env5355 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,0,1024,8833,1297,8200,17665,8615,18029,66098,25677,82466,67379,32,1284,4294967296,66338,4295041155,1345,25829]

theorem envBound5355 : H12AffineFastState.Bounded env5355 := by
  intro p hp
  have h : env5355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5354_5355 : H12AffineEnvironment.transform 23 8615 env5354 = env5355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 8615 env5354 == env5355) = true)

def env5356 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,0,1024,8833,1297,8200,17665,8583,17997,66066,25677,82434,67347,0,1284,4294967296,66306,4295041155,1345,25797]

theorem envBound5356 : H12AffineFastState.Bounded env5356 := by
  intro p hp
  have h : env5356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5355_5356 : H12AffineEnvironment.transform 4 0 env5355 = env5356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5355 == env5356) = true)

theorem identity5356 : scanCanonicalize (H12AffineFastState.compose env5356 (packedSelected [18] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound5356 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5357 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,1297,8192,16384,8833,139,1345,0,1024,8833,1297,8200,17665,8583,17997,665,25677,17033,1944,0,1284,4294967296,905,4294975496,1345,25797]

theorem envBound5357 : H12AffineFastState.Bounded env5357 := by
  intro p hp
  have h : env5357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5356_5357 : H12AffineEnvironment.transform 15 139 env5356 = env5357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env5356 == env5357) = true)

theorem identity5357 : scanCanonicalize (H12AffineFastState.compose env5357 (packedSelected [9,16,22,23] rootPS)) = affineNative (2^(13+1) ^^^ 1344) := by decide +kernel

theorem selectedBound5357 : packedSelected [9,16,22,23] rootPS < 2^1333 := by decide +kernel

def env5358 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,1297,8192,1344,8833,139,1345,0,1024,8833,1297,8200,65,8583,781,665,8461,1993,1944,0,1284,4294967296,905,4294975496,1345,8581]

theorem envBound5358 : H12AffineFastState.Bounded env5358 := by
  intro p hp
  have h : env5358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5357_5358 : H12AffineEnvironment.transform 13 1344 env5357 = env5358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1344 env5357 == env5358) = true)

theorem identity5358 : scanCanonicalize (H12AffineFastState.compose env5358 (packedSelected [16] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound5358 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env5359 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,1297,900,1344,261,139,1345,0,1024,261,1297,908,65,515,781,665,649,1993,1944,0,1284,4294967296,905,4294968204,1345,513]

theorem envBound5359 : H12AffineFastState.Bounded env5359 := by
  intro p hp
  have h : env5359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5358_5359 : H12AffineEnvironment.transform 12 900 env5358 = env5359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env5358 == env5359) = true)

theorem identity5359 : scanCanonicalize (H12AffineFastState.compose env5359 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5359 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5360 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1297,269,1344,261,139,1345,0,1024,261,1297,261,65,138,388,16,0,1344,1297,0,1284,4294967296,256,4294967557,1345,136]

theorem envBound5360 : H12AffineFastState.Bounded env5360 := by
  intro p hp
  have h : env5360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5359_5360 : H12AffineEnvironment.transform 8 137 env5359 = env5360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5359 == env5360) = true)

theorem identity5360 : scanCanonicalize (H12AffineFastState.compose env5360 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound5360 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5361 : List Nat := [2,4,8,16,0,64,128,221,137,1024,1,1228,208,1181,216,139,1180,0,1024,216,1228,216,65,138,89,16,0,1181,1228,0,1241,4294967296,221,4294967512,1180,136]

theorem envBound5361 : H12AffineFastState.Bounded env5361 := by
  intro p hp
  have h : env5361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5360_5361 : H12AffineEnvironment.transform 7 221 env5360 = env5361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env5360 == env5361) = true)

theorem identity5361 : scanCanonicalize (H12AffineFastState.compose env5361 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5361 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5362 : List Nat := [2,4,8,16,0,64,128,221,137,1024,1,1228,208,1181,216,139,1180,0,1024,216,1228,216,65,138,89,16,0,1181,1228,0,1241,90,221,130,1180,136]

theorem envBound5362 : H12AffineFastState.Bounded env5362 := by
  intro p hp
  have h : env5362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5361_5362 : H12AffineEnvironment.transform 31 90 env5361 = env5362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5361 == env5362) = true)

def env5363 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1297,8192,16384,8833,65536,1345,0,1024,8833,1297,8200,17665,8582,17996,66067,25677,82435,67346,1,1284,4294967296,66307,4295041155,1345,25796]

theorem envBound5363 : H12AffineFastState.Bounded env5363 := by
  intro p hp
  have h : env5363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5355_5363 : H12AffineEnvironment.transform 4 1 env5355 = env5363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5355 == env5363) = true)

theorem identity5363 : scanCanonicalize (H12AffineFastState.compose env5363 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound5363 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env5364 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1297,8192,1992,8833,65536,1345,0,1024,8833,1297,8200,713,8582,388,66067,9093,67019,67346,1,1284,4294967296,66307,4295041155,1345,8972]

theorem envBound5364 : H12AffineFastState.Bounded env5364 := by
  intro p hp
  have h : env5364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5363_5364 : H12AffineEnvironment.transform 13 1992 env5363 = env5364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env5363 == env5364) = true)

theorem identity5364 : scanCanonicalize (H12AffineFastState.compose env5364 (packedSelected [1,5,8,17,21,24] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound5364 : packedSelected [1,5,8,17,21,24] rootPS < 2^1333 := by decide +kernel

def env5365 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1297,8192,1992,8833,138,1345,0,1024,8833,1297,8200,713,8582,388,665,9093,1345,1944,1,1284,4294967296,905,4294975497,1345,8972]

theorem envBound5365 : H12AffineFastState.Bounded env5365 := by
  intro p hp
  have h : env5365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5364_5365 : H12AffineEnvironment.transform 15 138 env5364 = env5365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env5364 == env5365) = true)

theorem identity5365 : scanCanonicalize (H12AffineFastState.compose env5365 (packedSelected [16] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5365 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env5366 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,8192,1345,8200,138,1345,0,1024,8200,1297,8200,64,8582,388,16,8460,1345,1297,1,1284,4294967296,256,4294975497,1345,8581]

theorem envBound5366 : H12AffineFastState.Bounded env5366 := by
  intro p hp
  have h : env5366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5365_5366 : H12AffineEnvironment.transform 8 137 env5365 = env5366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5365 == env5366) = true)

theorem identity5366 : scanCanonicalize (H12AffineFastState.compose env5366 (packedSelected [5,8] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound5366 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5367 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,268,1345,260,138,1345,0,1024,260,1297,260,64,138,388,16,0,1345,1297,1,1284,4294967296,256,4294967557,1345,137]

theorem envBound5367 : H12AffineFastState.Bounded env5367 := by
  intro p hp
  have h : env5367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5366_5367 : H12AffineEnvironment.transform 12 268 env5366 = env5367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env5366 == env5367) = true)

theorem identity5367 : scanCanonicalize (H12AffineFastState.compose env5367 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 80) := by decide +kernel

theorem selectedBound5367 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5368 : List Nat := [2,4,8,16,1,64,80,256,89,1024,1,1297,268,1345,260,90,1345,0,1024,260,1297,260,64,90,340,16,0,1345,1297,1,1284,4294967296,256,4294967557,1345,89]

theorem envBound5368 : H12AffineFastState.Bounded env5368 := by
  intro p hp
  have h : env5368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5367_5368 : H12AffineEnvironment.transform 6 80 env5367 = env5368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 80 env5367 == env5368) = true)

theorem identity5368 : scanCanonicalize (H12AffineFastState.compose env5368 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 12) := by decide +kernel

theorem selectedBound5368 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5369 : List Nat := [2,4,8,16,1,64,80,12,89,1024,1,1053,0,1101,8,90,1101,0,1024,8,1053,8,64,90,88,16,0,1101,1053,1,1032,4294967296,12,4294967305,1101,89]

theorem envBound5369 : H12AffineFastState.Bounded env5369 := by
  intro p hp
  have h : env5369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5368_5369 : H12AffineEnvironment.transform 7 12 env5368 = env5369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 12 env5368 == env5369) = true)

theorem identity5369 : scanCanonicalize (H12AffineFastState.compose env5369 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound5369 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5370 : List Nat := [2,4,8,16,1,64,80,12,89,1024,1,1053,0,1101,8,90,1101,0,1024,8,1053,8,64,90,88,16,0,1101,1053,1,1032,11,12,2,1101,89]

theorem envBound5370 : H12AffineFastState.Bounded env5370 := by
  intro p hp
  have h : env5370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5369_5370 : H12AffineEnvironment.transform 31 11 env5369 = env5370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env5369 == env5370) = true)

theorem identity5370 : scanCanonicalize (H12AffineFastState.compose env5370 (packedSelected [0,6] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5370 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5371 : List Nat := [1,4,8,16,1,64,80,12,89,1024,1,1053,0,1101,8,89,1101,0,1024,8,1053,8,64,89,88,16,0,1101,1053,1,1032,8,12,1,1101,89]

theorem envBound5371 : H12AffineFastState.Bounded env5371 := by
  intro p hp
  have h : env5371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5370_5371 : H12AffineEnvironment.transform 0 1 env5370 = env5371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5370 == env5371) = true)

theorem identity5371 : scanCanonicalize (H12AffineFastState.compose env5371 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5371 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5372 : List Nat := [1,4,8,16,1,17,1,12,8,1024,1,1053,0,1052,8,8,1052,0,1024,8,1053,8,17,8,9,16,0,1052,1053,1,1032,8,12,1,1052,8]

theorem envBound5372 : H12AffineFastState.Bounded env5372 := by
  intro p hp
  have h : env5372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5371_5372 : H12AffineEnvironment.transform 5 17 env5371 = env5372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5371 == env5372) = true)

theorem identity5372 : scanCanonicalize (H12AffineFastState.compose env5372 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5372 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5373 : List Nat := [1,4,1,16,1,17,1,5,1,1024,1,1044,0,1045,1,1,1045,0,1024,1,1044,1,17,1,0,16,0,1045,1044,1,1025,1,5,1,1045,1]

theorem envBound5373 : H12AffineFastState.Bounded env5373 := by
  intro p hp
  have h : env5373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5372_5373 : H12AffineEnvironment.transform 2 1 env5372 = env5373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5372 == env5373) = true)

theorem identity5373 : scanCanonicalize (H12AffineFastState.compose env5373 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound5373 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5374 : List Nat := [1,4,1,16,1,17,1,5,1,5,1,17,0,16,1,1,16,0,5,1,17,1,17,1,0,16,0,16,17,1,4,1,5,1,16,1]

theorem envBound5374 : H12AffineFastState.Bounded env5374 := by
  intro p hp
  have h : env5374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5373_5374 : H12AffineEnvironment.transform 9 5 env5373 = env5374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env5373 == env5374) = true)

def env5375 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,10881,65536,1345,262144,1024,10881,4096,8200,17665,16777216,33554432,16858756,291164,16870277,16854676,16787846,1284,4294967296,16853637,4328619007,1345,33563272]

theorem envBound5375 : H12AffineFastState.Bounded env5375 := by
  intro p hp
  have h : env5375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5273_5375 : H12AffineEnvironment.transform 14 10881 env5273 = env5375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10881 env5273 == env5375) = true)

def env5376 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,262144,1024,8833,4096,8200,17665,16777216,33554432,16856708,291164,16868229,16852628,16785798,1284,4294967296,16851589,4328616959,1345,33563272]

theorem envBound5376 : H12AffineFastState.Bounded env5376 := by
  intro p hp
  have h : env5376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5375_5376 : H12AffineEnvironment.transform 10 0 env5375 = env5376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5375 == env5376) = true)

theorem identity5376 : scanCanonicalize (H12AffineFastState.compose env5376 (packedSelected [11] rootPS)) = affineNative (2^(17+1) ^^^ 83810) := by decide +kernel

theorem selectedBound5376 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5377 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,83810,1024,8833,4096,8200,17665,16777216,33554432,16856708,79422,16868229,16852628,16785798,1284,4294967296,16851589,4328616959,1345,33563272]

theorem envBound5377 : H12AffineFastState.Bounded env5377 := by
  intro p hp
  have h : env5377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5376_5377 : H12AffineEnvironment.transform 17 83810 env5376 = env5377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 83810 env5376 == env5377) = true)

def env5378 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12636,8833,65536,1345,79422,1024,8833,4096,8200,13405,16777216,33554432,16856708,79422,16847577,16852628,16785798,1284,4294967296,16851589,4328587939,1345,33563272]

theorem envBound5378 : H12AffineFastState.Bounded env5378 := by
  intro p hp
  have h : env5378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5377_5378 : H12AffineEnvironment.transform 13 12636 env5377 = env5378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 12636 env5377 == env5378) = true)

theorem identity5378 : scanCanonicalize (H12AffineFastState.compose env5378 (packedSelected [0,4,6,7,9,16,25] rootPS)) = affineNative (2^(24+1) ^^^ 16856848) := by decide +kernel

theorem selectedBound5378 : packedSelected [0,4,6,7,9,16,25] rootPS < 2^1333 := by decide +kernel

def env5379 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12636,8833,65536,1345,79422,1024,8833,4096,8200,13405,16777216,16856848,16856708,79422,16847577,16852628,16785798,1284,4294967296,16851589,4311758259,1345,16848280]

theorem envBound5379 : H12AffineFastState.Bounded env5379 := by
  intro p hp
  have h : env5379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5378_5379 : H12AffineEnvironment.transform 24 16856848 env5378 = env5379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16856848 env5378 == env5379) = true)

theorem identity5379 : scanCanonicalize (H12AffineFastState.compose env5379 (packedSelected [3,5,8,10,20,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 73996) := by decide +kernel

theorem selectedBound5379 : packedSelected [3,5,8,10,20,28,31] rootPS < 2^1333 := by decide +kernel

def env5380 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12636,8833,65536,1345,79422,1024,8833,4096,8200,13405,73996,5660,6024,79422,13269,1944,65674,1284,4294967296,905,4295038143,1345,13460]

theorem envBound5380 : H12AffineFastState.Bounded env5380 := by
  intro p hp
  have h : env5380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5379_5380 : H12AffineEnvironment.transform 23 73996 env5379 = env5380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 73996 env5379 == env5380) = true)

theorem identity5380 : scanCanonicalize (H12AffineFastState.compose env5380 (packedSelected [3,5,8,10,12,13,15,17,26,28] rootPS)) = affineNative (2^(15+1) ^^^ 13854) := by decide +kernel

theorem selectedBound5380 : packedSelected [3,5,8,10,12,13,15,17,26,28] rootPS < 2^1333 := by decide +kernel

def env5381 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12636,8833,13854,1345,32,1024,8833,4096,8200,13405,5906,5660,6024,32,13269,1944,13972,1284,4294967296,905,4294976161,1345,13460]

theorem envBound5381 : H12AffineFastState.Bounded env5381 := by
  intro p hp
  have h : env5381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5380_5381 : H12AffineEnvironment.transform 15 13854 env5380 = env5381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13854 env5380 == env5381) = true)

theorem identity5381 : scanCanonicalize (H12AffineFastState.compose env5381 (packedSelected [0,4,7,9,18] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5381 : packedSelected [0,4,7,9,18] rootPS < 2^1333 := by decide +kernel

def env5382 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,12636,8200,13463,1345,32,1024,8200,4096,8200,13405,5531,5269,5377,32,12636,1297,13341,1284,4294967296,256,4294975528,1345,13460]

theorem envBound5382 : H12AffineFastState.Bounded env5382 := by
  intro p hp
  have h : env5382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5381_5382 : H12AffineEnvironment.transform 8 137 env5381 = env5382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5381 == env5382) = true)

theorem identity5382 : scanCanonicalize (H12AffineFastState.compose env5382 (packedSelected [5,8] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound5382 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5383 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,1345,5141,138,1345,32,1024,5141,4096,5141,64,5531,5269,5377,32,1345,1297,0,1284,4294967296,256,4294972469,1345,137]

theorem envBound5383 : H12AffineFastState.Bounded env5383 := by
  intro p hp
  have h : env5383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5382_5383 : H12AffineEnvironment.transform 12 5149 env5382 = env5383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env5382 == env5383) = true)

theorem identity5383 : scanCanonicalize (H12AffineFastState.compose env5383 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 47) := by decide +kernel

theorem selectedBound5383 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env5384 : List Nat := [2,4,8,16,32,64,128,47,137,1024,0,4096,5149,1134,5141,138,1134,32,1024,5141,4096,5141,64,5300,5269,5166,32,1134,1086,0,1067,4294967296,47,4294972469,1134,137]

theorem envBound5384 : H12AffineFastState.Bounded env5384 := by
  intro p hp
  have h : env5384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5383_5384 : H12AffineEnvironment.transform 7 47 env5383 = env5384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 47 env5383 == env5384) = true)

theorem identity5384 : scanCanonicalize (H12AffineFastState.compose env5384 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound5384 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5385 : List Nat := [2,4,8,16,32,64,8,47,1,1024,0,4096,5149,1134,5141,2,1134,32,1024,5141,4096,5141,64,5180,5149,5166,32,1134,1086,0,1067,4294967296,47,4294972469,1134,1]

theorem envBound5385 : H12AffineFastState.Bounded env5385 := by
  intro p hp
  have h : env5385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5384_5385 : H12AffineEnvironment.transform 6 8 env5384 = env5385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env5384 == env5385) = true)

theorem identity5385 : scanCanonicalize (H12AffineFastState.compose env5385 (packedSelected [0,1,2,3,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 32) := by decide +kernel

theorem selectedBound5385 : packedSelected [0,1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env5386 : List Nat := [2,4,8,16,32,64,8,47,1,1024,0,4096,5149,1134,5141,2,1134,32,1024,5141,4096,5141,64,5180,5149,5166,32,1134,1086,0,1067,32,47,5141,1134,1]

theorem envBound5386 : H12AffineFastState.Bounded env5386 := by
  intro p hp
  have h : env5386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5385_5386 : H12AffineEnvironment.transform 31 32 env5385 = env5386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env5385 == env5386) = true)

theorem identity5386 : scanCanonicalize (H12AffineFastState.compose env5386 (packedSelected [4,9] rootPS)) = affineNative (2^(11+1) ^^^ 1086) := by decide +kernel

theorem selectedBound5386 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env5387 : List Nat := [2,4,8,16,32,64,8,47,1,1024,0,1086,35,1134,43,2,1134,32,1024,43,1086,43,64,2,35,16,32,1134,1086,0,1067,32,47,43,1134,1]

theorem envBound5387 : H12AffineFastState.Bounded env5387 := by
  intro p hp
  have h : env5387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5386_5387 : H12AffineEnvironment.transform 11 1086 env5386 = env5387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1086 env5386 == env5387) = true)

theorem identity5387 : scanCanonicalize (H12AffineFastState.compose env5387 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound5387 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5388 : List Nat := [2,4,8,16,3,64,8,12,1,1024,0,1053,0,1101,8,2,1101,3,1024,8,1053,8,64,2,0,16,3,1101,1053,0,1032,3,12,8,1101,1]

theorem envBound5388 : H12AffineFastState.Bounded env5388 := by
  intro p hp
  have h : env5388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5387_5388 : H12AffineEnvironment.transform 4 3 env5387 = env5388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env5387 == env5388) = true)

theorem identity5388 : scanCanonicalize (H12AffineFastState.compose env5388 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5388 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5389 : List Nat := [2,4,8,16,3,17,8,12,1,1024,0,1053,0,1052,8,2,1052,3,1024,8,1053,8,17,2,0,16,3,1052,1053,0,1032,3,12,8,1052,1]

theorem envBound5389 : H12AffineFastState.Bounded env5389 := by
  intro p hp
  have h : env5389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5388_5389 : H12AffineEnvironment.transform 5 17 env5388 = env5389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5388 == env5389) = true)

theorem identity5389 : scanCanonicalize (H12AffineFastState.compose env5389 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5389 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5390 : List Nat := [0,4,8,16,1,17,8,12,1,1024,0,1053,0,1052,8,0,1052,1,1024,8,1053,8,17,0,0,16,1,1052,1053,0,1032,1,12,8,1052,1]

theorem envBound5390 : H12AffineFastState.Bounded env5390 := by
  intro p hp
  have h : env5390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5389_5390 : H12AffineEnvironment.transform 0 0 env5389 = env5390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5389 == env5390) = true)

theorem identity5390 : scanCanonicalize (H12AffineFastState.compose env5390 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5390 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5391 : List Nat := [0,4,1,16,1,17,1,5,1,1024,0,1044,0,1045,1,0,1045,1,1024,1,1044,1,17,0,0,16,1,1045,1044,0,1025,1,5,1,1045,1]

theorem envBound5391 : H12AffineFastState.Bounded env5391 := by
  intro p hp
  have h : env5391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5390_5391 : H12AffineEnvironment.transform 2 1 env5390 = env5391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5390 == env5391) = true)

theorem identity5391 : scanCanonicalize (H12AffineFastState.compose env5391 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound5391 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5392 : List Nat := [0,4,1,16,1,17,1,5,1,5,0,17,0,16,1,0,16,1,5,1,17,1,17,0,0,16,1,16,17,0,4,1,5,1,16,1]

theorem envBound5392 : H12AffineFastState.Bounded env5392 := by
  intro p hp
  have h : env5392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5391_5392 : H12AffineEnvironment.transform 9 5 env5391 = env5392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env5391 == env5392) = true)

def env5393 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12637,8833,65536,1345,79423,1024,8833,4096,8200,13404,16777216,33554432,16856708,79422,16847576,16852628,16785798,1284,4294967296,16851589,4328587938,1345,33563272]

theorem envBound5393 : H12AffineFastState.Bounded env5393 := by
  intro p hp
  have h : env5393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5377_5393 : H12AffineEnvironment.transform 13 12637 env5377 = env5393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 12637 env5377 == env5393) = true)

theorem identity5393 : scanCanonicalize (H12AffineFastState.compose env5393 (packedSelected [0,4,6,7,9,16,25] rootPS)) = affineNative (2^(23+1) ^^^ 8614) := by decide +kernel

theorem selectedBound5393 : packedSelected [0,4,6,7,9,16,25] rootPS < 2^1333 := by decide +kernel

def env5394 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12637,8833,65536,1345,79423,1024,8833,4096,8200,13404,8614,33554432,71458,79422,78718,67378,32,1284,4294967296,66339,4328587938,1345,33563272]

theorem envBound5394 : H12AffineFastState.Bounded env5394 := by
  intro p hp
  have h : env5394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5393_5394 : H12AffineEnvironment.transform 23 8614 env5393 = env5394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 8614 env5393 == env5394) = true)

theorem identity5394 : scanCanonicalize (H12AffineFastState.compose env5394 (packedSelected [20,23,32] rootPS)) = affineNative (2^(24+1) ^^^ 74378) := by decide +kernel

theorem selectedBound5394 : packedSelected [20,23,32] rootPS < 2^1333 := by decide +kernel

def env5395 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,12637,8833,65536,1345,79423,1024,8833,4096,8200,13404,8614,74378,71458,79422,78718,67378,32,1284,4294967296,66339,4294975528,1345,65538]

theorem envBound5395 : H12AffineFastState.Bounded env5395 := by
  intro p hp
  have h : env5395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5394_5395 : H12AffineEnvironment.transform 24 74378 env5394 = env5395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 74378 env5394 == env5395) = true)

theorem identity5395 : scanCanonicalize (H12AffineFastState.compose env5395 (packedSelected [0,4,5,7,8,9,12,13,15,17,18,24,28] rootPS)) = affineNative (2^(11+1) ^^^ 1976) := by decide +kernel

theorem selectedBound5395 : packedSelected [0,4,5,7,8,9,12,13,15,17,18,24,28] rootPS < 2^1333 := by decide +kernel

def env5396 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,8192,9957,8833,65536,1345,74119,1024,8833,1976,8200,9188,8614,74378,65690,74118,74950,67378,32,1284,4294967296,66339,4294975528,1345,65538]

theorem envBound5396 : H12AffineFastState.Bounded env5396 := by
  intro p hp
  have h : env5396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5395_5396 : H12AffineEnvironment.transform 11 1976 env5395 = env5396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1976 env5395 == env5396) = true)

theorem identity5396 : scanCanonicalize (H12AffineFastState.compose env5396 (packedSelected [0,4,7,9,18] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

end H12GlobalChart2