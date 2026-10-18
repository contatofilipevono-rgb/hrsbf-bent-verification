import H12AffinePilotData001

namespace H12AffinePilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans17_18 : H12PackedSparse.directTransform 22 213130 env17 = env18 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 213130 env17 == env18) = true)

theorem identity18 : scanCanonicalize (H12AffineState.compose env18 (packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS)) = affineNative (2^(15+1) ^^^ 41002) := by decide +kernel

theorem selectedBound18 : packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS < 2^1333 := by decide +kernel

def env19 : List Nat := [2,4,8,16,32,64,128,256,512,237,2048,4096,8192,16384,32768,41002,131072,262144,524288,1048576,16465,4194304,188576,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound19 : H12AffineState.Bounded env19 := by
  intro p hp
  have h : env19.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans18_19 : H12PackedSparse.directTransform 15 41002 env18 = env19 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 41002 env18 == env19) = true)

theorem identity19 : scanCanonicalize (H12AffineState.compose env19 (packedSelected [2,9,11,13,17,18,22] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound19 : packedSelected [2,9,11,13,17,18,22] rootPS < 2^1333 := by decide +kernel

def env20 : List Nat := [2,4,8,16,32,64,128,256,512,237,2048,4096,8,16384,32768,32802,131072,262144,524288,1048576,16465,4194304,180392,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound20 : H12AffineState.Bounded env20 := by
  intro p hp
  have h : env20.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans19_20 : H12PackedSparse.directTransform 12 8 env19 = env20 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 8 env19 == env20) = true)

theorem identity20 : scanCanonicalize (H12AffineState.compose env20 (packedSelected [2,13,14] rootPS)) = affineNative (2^(16+1) ^^^ 4265) := by decide +kernel

theorem selectedBound20 : packedSelected [2,13,14] rootPS < 2^1333 := by decide +kernel

def env21 : List Nat := [2,4,8,16,32,64,128,256,512,237,2048,4096,8,16384,32768,32802,4265,262144,524288,1048576,16465,4194304,53249,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound21 : H12AffineState.Bounded env21 := by
  intro p hp
  have h : env21.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans20_21 : H12PackedSparse.directTransform 16 4265 env20 = env21 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 4265 env20 == env21) = true)

theorem identity21 : scanCanonicalize (H12AffineState.compose env21 (packedSelected [13] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound21 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env22 : List Nat := [2,4,8,16,32,64,40,256,512,69,2048,4096,8,16384,32768,32802,4097,262144,524288,1048576,16465,4194304,53249,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound22 : H12AffineState.Bounded env22 := by
  intro p hp
  have h : env22.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans21_22 : H12PackedSparse.directTransform 6 40 env21 = env22 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 40 env21 == env22) = true)

theorem identity22 : scanCanonicalize (H12AffineState.compose env22 (packedSelected [2,4,6,9,11] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound22 : packedSelected [2,4,6,9,11] rootPS < 2^1333 := by decide +kernel

def env23 : List Nat := [2,4,8,16,32,64,40,256,512,69,2048,4096,8,16384,32768,32802,4097,34848,524288,1048576,16465,4194304,53249,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound23 : H12AffineState.Bounded env23 := by
  intro p hp
  have h : env23.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans22_23 : H12PackedSparse.directTransform 17 34848 env22 = env23 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 34848 env22 == env23) = true)

theorem identity23 : scanCanonicalize (H12AffineState.compose env23 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound23 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env24 : List Nat := [2,4,8,16,32,64,40,256,512,69,2048,4096,8,16384,0,34,4097,2080,524288,1048576,16465,4194304,20481,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound24 : H12AffineState.Bounded env24 := by
  intro p hp
  have h : env24.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans23_24 : H12PackedSparse.directTransform 14 0 env23 = env24 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env23 == env24) = true)

theorem identity24 : scanCanonicalize (H12AffineState.compose env24 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound24 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env25 : List Nat := [2,4,8,16,32,16,40,256,512,21,2048,4096,8,16384,0,34,4097,2080,524288,1048576,16385,4194304,20481,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound25 : H12AffineState.Bounded env25 := by
  intro p hp
  have h : env25.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans24_25 : H12PackedSparse.directTransform 5 16 env24 = env25 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 16 env24 == env25) = true)

theorem identity25 : scanCanonicalize (H12AffineState.compose env25 (packedSelected [2] rootPS)) = affineNative (2^(13+1) ^^^ 4113) := by decide +kernel

theorem selectedBound25 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env26 : List Nat := [2,4,8,16,32,16,40,256,512,21,2048,4096,8,4113,0,34,4097,2080,524288,1048576,4112,4194304,16,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound26 : H12AffineState.Bounded env26 := by
  intro p hp
  have h : env26.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans25_26 : H12PackedSparse.directTransform 13 4113 env25 = env26 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 4113 env25 == env26) = true)

theorem identity26 : scanCanonicalize (H12AffineState.compose env26 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound26 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env27 : List Nat := [2,4,8,16,10,16,2,256,512,21,2048,4096,8,4113,0,8,4097,2058,524288,1048576,4112,4194304,16,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound27 : H12AffineState.Bounded env27 := by
  intro p hp
  have h : env27.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans26_27 : H12PackedSparse.directTransform 4 10 env26 = env27 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 4 10 env26 == env27) = true)

theorem identity27 : scanCanonicalize (H12AffineState.compose env27 (packedSelected [1,5] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound27 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env28 : List Nat := [2,4,8,1,10,1,2,256,512,4,2048,4096,8,4096,0,8,4097,2058,524288,1048576,4097,4194304,1,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound28 : H12AffineState.Bounded env28 := by
  intro p hp
  have h : env28.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans27_28 : H12PackedSparse.directTransform 3 1 env27 = env28 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 1 env27 == env28) = true)

theorem identity28 : scanCanonicalize (H12AffineState.compose env28 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound28 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env29 : List Nat := [2,4,2,1,0,1,2,256,512,4,2048,4096,2,4096,0,2,4097,2048,524288,1048576,4097,4194304,1,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound29 : H12AffineState.Bounded env29 := by
  intro p hp
  have h : env29.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans28_29 : H12PackedSparse.directTransform 2 2 env28 = env29 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 2 2 env28 == env29) = true)

theorem identity29 : scanCanonicalize (H12AffineState.compose env29 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 3) := by decide +kernel

theorem selectedBound29 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env30 : List Nat := [2,4,2,1,0,1,2,256,512,4,3,4096,2,4096,0,2,4097,3,524288,1048576,4097,4194304,1,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound30 : H12AffineState.Bounded env30 := by
  intro p hp
  have h : env30.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12AffinePilot