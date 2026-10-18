import H12AffineWideData009

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound103 : H12AffineState.Bounded env103 := by
  intro p hp
  have h : env103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans102_103 : H12PackedSparse.directTransform 22 525328 env102 = env103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 525328 env102 == env103) = true)

theorem identity103 : scanCanonicalize (H12AffineState.compose env103 (packedSelected [0,6,7,14,20] rootPS)) = affineNative (2^(34+1) ^^^ 78894) := by decide +kernel

theorem selectedBound103 : packedSelected [0,6,7,14,20] rootPS < 2^1333 := by decide +kernel

def env104 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,65536,78958,262144,524288,1048576,529472,73891,525328,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,78894,68719476736]

theorem envBound104 : H12AffineState.Bounded env104 := by
  intro p hp
  have h : env104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans103_104 : H12PackedSparse.directTransform 34 78894 env103 = env104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 34 78894 env103 == env104) = true)

theorem identity104 : scanCanonicalize (H12AffineState.compose env104 (packedSelected [13] rootPS)) = affineNative (2^(12+1) ^^^ 161) := by decide +kernel

theorem selectedBound104 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env105 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,16384,0,65536,70863,262144,524288,1048576,529472,65538,525328,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,70799,68719476736]

theorem envBound105 : H12AffineState.Bounded env105 := by
  intro p hp
  have h : env105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans104_105 : H12PackedSparse.directTransform 12 161 env104 = env105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 161 env104 == env105) = true)

theorem identity105 : scanCanonicalize (H12AffineState.compose env105 (packedSelected [2,4,6,9,11,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 34) := by decide +kernel

theorem selectedBound105 : packedSelected [2,4,6,9,11,12,15] rootPS < 2^1333 := by decide +kernel

def env106 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,16384,0,34,5357,262144,524288,1048576,529472,32,525328,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5293,68719476736]

theorem envBound106 : H12AffineState.Bounded env106 := by
  intro p hp
  have h : env106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans105_106 : H12PackedSparse.directTransform 15 34 env105 = env106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 34 env105 == env106) = true)

theorem identity106 : scanCanonicalize (H12AffineState.compose env106 (packedSelected [0,2,7,11] rootPS)) = affineNative (2^(17+1) ^^^ 23588) := by decide +kernel

theorem selectedBound106 : packedSelected [0,2,7,11] rootPS < 2^1333 := by decide +kernel

def env107 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,161,16384,0,34,5357,23588,524288,1048576,529472,32,525328,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5293,68719476736]

theorem envBound107 : H12AffineState.Bounded env107 := by
  intro p hp
  have h : env107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans106_107 : H12PackedSparse.directTransform 17 23588 env106 = env107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 23588 env106 == env107) = true)

def env108 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,65536,78958,262144,524288,1048576,529472,73891,525329,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound108 : H12AffineState.Bounded env108 := by
  intro p hp
  have h : env108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans102_108 : H12PackedSparse.directTransform 22 525329 env102 = env108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 525329 env102 == env108) = true)

theorem identity108 : scanCanonicalize (H12AffineState.compose env108 (packedSelected [0,6,7,14,20] rootPS)) = affineNative (2^(18+1) ^^^ 94334) := by decide +kernel

theorem selectedBound108 : packedSelected [0,6,7,14,20] rootPS < 2^1333 := by decide +kernel

def env109 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,65536,78958,262144,94334,1048576,91198,73891,95343,16777216,33554432,95295,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound109 : H12AffineState.Bounded env109 := by
  intro p hp
  have h : env109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans108_109 : H12PackedSparse.directTransform 18 94334 env108 = env109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 18 94334 env108 == env109) = true)

theorem identity109 : scanCanonicalize (H12AffineState.compose env109 (packedSelected [21] rootPS)) = affineNative (2^(17+1) ^^^ 2185) := by decide +kernel

theorem selectedBound109 : packedSelected [21] rootPS < 2^1333 := by decide +kernel

def env110 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,65536,78958,2185,94334,1048576,91198,73891,95343,16777216,33554432,95295,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound110 : H12AffineState.Bounded env110 := by
  intro p hp
  have h : env110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans109_110 : H12PackedSparse.directTransform 17 2185 env109 = env110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 2185 env109 == env110) = true)

theorem identity110 : scanCanonicalize (H12AffineState.compose env110 (packedSelected [0,4,6,7,9] rootPS)) = affineNative (2^(15+1) ^^^ 8323) := by decide +kernel

theorem selectedBound110 : packedSelected [0,4,6,7,9] rootPS < 2^1333 := by decide +kernel

def env111 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,8323,5357,2185,20733,1048576,17597,32,21740,16777216,33554432,21692,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound111 : H12AffineState.Bounded env111 := by
  intro p hp
  have h : env111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans110_111 : H12PackedSparse.directTransform 15 8323 env110 = env111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 8323 env110 == env111) = true)

theorem identity111 : scanCanonicalize (H12AffineState.compose env111 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 640) := by decide +kernel

theorem selectedBound111 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env112 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,640,16384,545,515,5357,2185,20733,1048576,17597,32,21740,16777216,33554432,21692,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound112 : H12AffineState.Bounded env112 := by
  intro p hp
  have h : env112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans111_112 : H12PackedSparse.directTransform 12 640 env111 = env112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 640 env111 == env112) = true)

theorem identity112 : scanCanonicalize (H12AffineState.compose env112 (packedSelected [2,6] rootPS)) = affineNative (2^(13+1) ^^^ 5773) := by decide +kernel

theorem selectedBound112 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env113 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,640,5773,545,515,5357,2185,1648,1048576,4656,32,609,16777216,33554432,561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound113 : H12AffineState.Bounded env113 := by
  intro p hp
  have h : env113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans112_113 : H12PackedSparse.directTransform 13 5773 env112 = env113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 5773 env112 == env113) = true)

theorem identity113 : scanCanonicalize (H12AffineState.compose env113 (packedSelected [0,2,5,7,8,11,12] rootPS)) = affineNative (2^(34+1) ^^^ 5292) := by decide +kernel

theorem selectedBound113 : packedSelected [0,2,5,7,8,11,12] rootPS < 2^1333 := by decide +kernel

def env114 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,640,5773,545,515,5357,2185,1648,1048576,4656,32,609,16777216,33554432,561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5292,68719476736]

theorem envBound114 : H12AffineState.Bounded env114 := by
  intro p hp
  have h : env114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans113_114 : H12PackedSparse.directTransform 34 5292 env113 = env114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 34 5292 env113 == env114) = true)

theorem identity114 : scanCanonicalize (H12AffineState.compose env114 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1589) := by decide +kernel

theorem selectedBound114 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env115 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,1589,640,184,545,515,728,2185,1648,1048576,1029,32,609,16777216,33554432,561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,665,68719476736]

theorem envBound115 : H12AffineState.Bounded env115 := by
  intro p hp
  have h : env115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans114_115 : H12PackedSparse.directTransform 11 1589 env114 = env115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 11 1589 env114 == env115) = true)

end H12AffineWide