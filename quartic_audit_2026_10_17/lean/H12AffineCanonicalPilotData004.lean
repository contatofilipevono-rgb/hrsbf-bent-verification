import H12AffineCanonicalPilotData003

namespace H12AffineCanonicalPilot

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

def env90 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,65536,78959,262144,524288,1048576,529473,73891,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound90 : H12AffineState.Bounded env90 := by
  intro p hp
  have h : env90.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans89_90 : H12PackedSparse.directTransform 22 525328 env89 = env90 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 525328 env89 == env90) = true)

theorem identity90 : scanCanonicalize (H12AffineState.compose env90 (packedSelected [0,6,7,14,20] rootPS)) = affineNative (2^(15+1) ^^^ 29742) := by decide +kernel

theorem selectedBound90 : packedSelected [0,6,7,14,20] rootPS < 2^1333 := by decide +kernel

def env91 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,29742,16449,262144,524288,1048576,529473,21645,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound91 : H12AffineState.Bounded env91 := by
  intro p hp
  have h : env91.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans90_91 : H12PackedSparse.directTransform 15 29742 env90 = env91 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 29742 env90 == env91) = true)

theorem identity91 : scanCanonicalize (H12AffineState.compose env91 (packedSelected [12,15] rootPS)) = affineNative (2^(13+1) ^^^ 5292) := by decide +kernel

theorem selectedBound91 : packedSelected [12,15] rootPS < 2^1333 := by decide +kernel

def env92 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,5292,8352,8322,5357,262144,524288,1048576,529473,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound92 : H12AffineState.Bounded env92 := by
  intro p hp
  have h : env92.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans91_92 : H12PackedSparse.directTransform 13 5292 env91 = env92 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 5292 env91 == env92) = true)

theorem identity92 : scanCanonicalize (H12AffineState.compose env92 (packedSelected [2,6] rootPS)) = affineNative (2^(12+1) ^^^ 160) := by decide +kernel

theorem selectedBound92 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env93 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,160,5292,0,34,5357,262144,524288,1048576,529473,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound93 : H12AffineState.Bounded env93 := by
  intro p hp
  have h : env93.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans92_93 : H12PackedSparse.directTransform 12 160 env92 = env93 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 160 env92 == env93) = true)

theorem identity93 : scanCanonicalize (H12AffineState.compose env93 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 2184) := by decide +kernel

theorem selectedBound93 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env94 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,160,5292,0,34,5357,2184,524288,1048576,529473,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound94 : H12AffineState.Bounded env94 := by
  intro p hp
  have h : env94.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans93_94 : H12PackedSparse.directTransform 17 2184 env93 = env94 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 2184 env93 == env94) = true)

theorem identity94 : scanCanonicalize (H12AffineState.compose env94 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound94 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env95 : List Nat := [2,4,8,16,32,64,121,4,512,1024,2048,4096,89,5205,0,34,5140,2161,524288,1048576,529473,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound95 : H12AffineState.Bounded env95 := by
  intro p hp
  have h : env95.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans94_95 : H12PackedSparse.directTransform 6 121 env94 = env95 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 121 env94 == env95) = true)

theorem identity95 : scanCanonicalize (H12AffineState.compose env95 (packedSelected [0,2,7,23] rootPS)) = affineNative (2^(34+1) ^^^ 5204) := by decide +kernel

theorem selectedBound95 : packedSelected [0,2,7,23] rootPS < 2^1333 := by decide +kernel

def env96 : List Nat := [2,4,8,16,32,64,121,4,512,1024,2048,4096,89,5205,0,34,5140,2161,524288,1048576,529473,33,525328,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,5204,68719476736]

theorem envBound96 : H12AffineState.Bounded env96 := by
  intro p hp
  have h : env96.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans95_96 : H12PackedSparse.directTransform 34 5204 env95 = env96 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 34 5204 env95 == env96) = true)

def env97 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,65536,78959,262144,524288,1048576,529473,73891,525329,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound97 : H12AffineState.Bounded env97 := by
  intro p hp
  have h : env97.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans89_97 : H12PackedSparse.directTransform 22 525329 env89 = env97 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 525329 env89 == env97) = true)

theorem identity97 : scanCanonicalize (H12AffineState.compose env97 (packedSelected [0,6,7,14,20] rootPS)) = affineNative (2^(34+1) ^^^ 602239) := by decide +kernel

theorem selectedBound97 : packedSelected [0,6,7,14,20] rootPS < 2^1333 := by decide +kernel

def env98 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,65536,78959,262144,524288,1048576,529473,73891,525329,16777216,33554432,525376,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,602239,68719476736]

theorem envBound98 : H12AffineState.Bounded env98 := by
  intro p hp
  have h : env98.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans97_98 : H12PackedSparse.directTransform 34 602239 env97 = env98 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 34 602239 env97 == env98) = true)

theorem identity98 : scanCanonicalize (H12AffineState.compose env98 (packedSelected [21] rootPS)) = affineNative (2^(18+1) ^^^ 273529) := by decide +kernel

theorem selectedBound98 : packedSelected [21] rootPS < 2^1333 := by decide +kernel

def env99 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,65536,78959,262144,273529,1048576,276536,73891,272488,16777216,33554432,272441,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,334854,68719476736]

theorem envBound99 : H12AffineState.Bounded env99 := by
  intro p hp
  have h : env99.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans98_99 : H12PackedSparse.directTransform 18 273529 env98 = env99 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 18 273529 env98 == env99) = true)

theorem identity99 : scanCanonicalize (H12AffineState.compose env99 (packedSelected [0,2,4,6,7,9,13,14] rootPS)) = affineNative (2^(15+1) ^^^ 35) := by decide +kernel

theorem selectedBound99 : packedSelected [0,2,4,6,7,9,13,14] rootPS < 2^1333 := by decide +kernel

def env100 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,35,13388,262144,273529,1048576,276536,8320,272488,16777216,33554432,272441,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,269349,68719476736]

theorem envBound100 : H12AffineState.Bounded env100 := by
  intro p hp
  have h : env100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans99_100 : H12PackedSparse.directTransform 15 35 env99 = env100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 35 env99 == env100) = true)

theorem identity100 : scanCanonicalize (H12AffineState.compose env100 (packedSelected [0,4,6,7,9,13] rootPS)) = affineNative (2^(17+1) ^^^ 23589) := by decide +kernel

theorem selectedBound100 : packedSelected [0,4,6,7,9,13] rootPS < 2^1333 := by decide +kernel

def env101 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8352,35,13388,23589,28764,1048576,25629,8320,29773,16777216,33554432,29724,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,16384,68719476736]

theorem envBound101 : H12AffineState.Bounded env101 := by
  intro p hp
  have h : env101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans100_101 : H12PackedSparse.directTransform 17 23589 env100 = env101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 23589 env100 == env101) = true)

def env102 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,65536,78958,262144,524288,1048576,529472,73891,8388608,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound102 : H12AffineState.Bounded env102 := by
  intro p hp
  have h : env102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans88_102 : H12PackedSparse.directTransform 14 8353 env88 = env102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 8353 env88 == env102) = true)

def env103 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,8353,65536,78958,262144,524288,1048576,529472,73891,525328,16777216,33554432,525377,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

end H12AffineCanonicalPilot