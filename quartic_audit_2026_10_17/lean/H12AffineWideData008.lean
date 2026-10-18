import H12AffineWideData007

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env76 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,5357,262144,524288,1048576,570592,73891,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound76 : H12AffineState.Bounded env76 := by
  intro p hp
  have h : env76.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans75_76 : H12PackedSparse.directTransform 16 5357 env75 = env76 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 5357 env75 == env76) = true)

theorem identity76 : scanCanonicalize (H12AffineState.compose env76 (packedSelected [2,11,14,18] rootPS)) = affineNative (2^(22+1) ^^^ 525328) := by decide +kernel

theorem selectedBound76 : packedSelected [2,11,14,18] rootPS < 2^1333 := by decide +kernel

def env77 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,5357,262144,524288,1048576,570592,73891,525328,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound77 : H12AffineState.Bounded env77 := by
  intro p hp
  have h : env77.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans76_77 : H12PackedSparse.directTransform 22 525328 env76 = env77 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 525328 env76 == env77) = true)

theorem identity77 : scanCanonicalize (H12AffineState.compose env77 (packedSelected [0,2,4,6,7,9,11,14,23] rootPS)) = affineNative (2^(34+1) ^^^ 103566) := by decide +kernel

theorem selectedBound77 : packedSelected [0,2,4,6,7,9,11,14,23] rootPS < 2^1333 := by decide +kernel

def env78 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,5357,262144,524288,1048576,570592,73891,525328,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,103566,68719476736]

theorem envBound78 : H12AffineState.Bounded env78 := by
  intro p hp
  have h : env78.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans77_78 : H12PackedSparse.directTransform 34 103566 env77 = env78 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 34 103566 env77 == env78) = true)

def env79 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,0,65536,5357,262144,524288,1048576,537824,73891,525328,16777216,33554432,533728,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,70798,68719476736]

theorem envBound79 : H12AffineState.Bounded env79 := by
  intro p hp
  have h : env79.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans78_79 : H12PackedSparse.directTransform 14 0 env78 = env79 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env78 == env79) = true)

theorem identity79 : scanCanonicalize (H12AffineState.compose env79 (packedSelected [0,4,7,9,11,12,15,20] rootPS)) = affineNative (2^(15+1) ^^^ 34) := by decide +kernel

theorem selectedBound79 : packedSelected [0,4,7,9,11,12,15,20] rootPS < 2^1333 := by decide +kernel

def env80 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,0,34,5357,262144,524288,1048576,537824,8321,525328,16777216,33554432,533728,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5292,68719476736]

theorem envBound80 : H12AffineState.Bounded env80 := by
  intro p hp
  have h : env80.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans79_80 : H12PackedSparse.directTransform 15 34 env79 = env80 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 34 env79 == env80) = true)

theorem identity80 : scanCanonicalize (H12AffineState.compose env80 (packedSelected [0,6,7,11] rootPS)) = affineNative (2^(17+1) ^^^ 23589) := by decide +kernel

theorem selectedBound80 : packedSelected [0,6,7,11] rootPS < 2^1333 := by decide +kernel

def env81 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,0,34,5357,23589,524288,1048576,537824,8321,525328,16777216,33554432,533728,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5292,68719476736]

theorem envBound81 : H12AffineState.Bounded env81 := by
  intro p hp
  have h : env81.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans80_81 : H12PackedSparse.directTransform 17 23589 env80 = env81 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 23589 env80 == env81) = true)

def env82 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,1,65536,5357,262144,524288,1048576,537825,73891,525328,16777216,33554432,533729,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,70799,68719476736]

theorem envBound82 : H12AffineState.Bounded env82 := by
  intro p hp
  have h : env82.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans78_82 : H12PackedSparse.directTransform 14 1 env78 = env82 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 1 env78 == env82) = true)

theorem identity82 : scanCanonicalize (H12AffineState.compose env82 (packedSelected [13] rootPS)) = affineNative (2^(12+1) ^^^ 161) := by decide +kernel

theorem selectedBound82 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env83 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,16384,1,65536,5357,262144,524288,1048576,529472,65538,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,70799,68719476736]

theorem envBound83 : H12AffineState.Bounded env83 := by
  intro p hp
  have h : env83.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans82_83 : H12PackedSparse.directTransform 12 161 env82 = env83 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 161 env82 == env83) = true)

theorem identity83 : scanCanonicalize (H12AffineState.compose env83 (packedSelected [2,14] rootPS)) = affineNative (2^(15+1) ^^^ 35) := by decide +kernel

theorem selectedBound83 : packedSelected [2,14] rootPS < 2^1333 := by decide +kernel

def env84 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,16384,1,35,5357,262144,524288,1048576,529472,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5292,68719476736]

theorem envBound84 : H12AffineState.Bounded env84 := by
  intro p hp
  have h : env84.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans83_84 : H12PackedSparse.directTransform 15 35 env83 = env84 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 35 env83 == env84) = true)

theorem identity84 : scanCanonicalize (H12AffineState.compose env84 (packedSelected [2,6] rootPS)) = affineNative (2^(13+1) ^^^ 5292) := by decide +kernel

theorem selectedBound84 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env85 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,5292,1,35,5357,262144,524288,1048576,529472,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5292,68719476736]

theorem envBound85 : H12AffineState.Bounded env85 := by
  intro p hp
  have h : env85.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans84_85 : H12PackedSparse.directTransform 13 5292 env84 = env85 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 5292 env84 == env85) = true)

theorem identity85 : scanCanonicalize (H12AffineState.compose env85 (packedSelected [2] rootPS)) = affineNative (2^(18+1) ^^^ 20) := by decide +kernel

theorem selectedBound85 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env86 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,5292,1,35,5357,262144,20,1048576,5204,33,1028,16777216,33554432,1108,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5292,68719476736]

theorem envBound86 : H12AffineState.Bounded env86 := by
  intro p hp
  have h : env86.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans85_86 : H12PackedSparse.directTransform 18 20 env85 = env86 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 18 20 env85 == env86) = true)

def env87 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,570593,73891,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound87 : H12AffineState.Bounded env87 := by
  intro p hp
  have h : env87.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans74_87 : H12PackedSparse.directTransform 20 570593 env74 = env87 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 20 570593 env74 == env87) = true)

theorem identity87 : scanCanonicalize (H12AffineState.compose env87 (packedSelected [3,5,10] rootPS)) = affineNative (2^(16+1) ^^^ 103631) := by decide +kernel

theorem selectedBound87 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env88 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,103631,262144,524288,1048576,570593,73891,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound88 : H12AffineState.Bounded env88 := by
  intro p hp
  have h : env88.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans87_88 : H12PackedSparse.directTransform 16 103631 env87 = env88 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 103631 env87 == env88) = true)

def env89 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,65536,78959,262144,524288,1048576,529473,73891,8388608,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound89 : H12AffineState.Bounded env89 := by
  intro p hp
  have h : env89.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans88_89 : H12PackedSparse.directTransform 14 8352 env88 = env89 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 8352 env88 == env89) = true)

end H12AffineWide