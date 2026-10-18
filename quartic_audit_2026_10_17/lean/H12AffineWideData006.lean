import H12AffineWideData005

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound56 : packedSelected [2,9,11,13,17,18,22] rootPS < 2^1333 := by decide +kernel

def env57 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8,16384,32768,32802,131072,262144,180308,1048576,16465,32904,180393,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound57 : H12AffineState.Bounded env57 := by
  intro p hp
  have h : env57.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans56_57 : H12PackedSparse.directTransform 12 8 env56 = env57 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 8 env56 == env57) = true)

theorem identity57 : scanCanonicalize (H12AffineState.compose env57 (packedSelected [2,13,14] rootPS)) = affineNative (2^(16+1) ^^^ 4265) := by decide +kernel

theorem selectedBound57 : packedSelected [2,13,14] rootPS < 2^1333 := by decide +kernel

def env58 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8,16384,32768,32802,4265,262144,53501,1048576,16465,32904,53248,16777216,33554432,20728,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound58 : H12AffineState.Bounded env58 := by
  intro p hp
  have h : env58.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans57_58 : H12PackedSparse.directTransform 16 4265 env57 = env58 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 4265 env57 == env58) = true)

theorem identity58 : scanCanonicalize (H12AffineState.compose env58 (packedSelected [13] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound58 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env59 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,32768,32802,4097,262144,53333,1048576,16465,32800,53248,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound59 : H12AffineState.Bounded env59 := by
  intro p hp
  have h : env59.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans58_59 : H12PackedSparse.directTransform 6 40 env58 = env59 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 40 env58 == env59) = true)

theorem identity59 : scanCanonicalize (H12AffineState.compose env59 (packedSelected [2,4,6,9,11] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound59 : packedSelected [2,4,6,9,11] rootPS < 2^1333 := by decide +kernel

def env60 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,32768,32802,4097,34848,53333,1048576,16465,32800,53248,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound60 : H12AffineState.Bounded env60 := by
  intro p hp
  have h : env60.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans59_60 : H12PackedSparse.directTransform 17 34848 env59 = env60 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 34848 env59 == env60) = true)

theorem identity60 : scanCanonicalize (H12AffineState.compose env60 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound60 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env61 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,0,34,4097,2080,20565,1048576,16465,32,20480,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound61 : H12AffineState.Bounded env61 := by
  intro p hp
  have h : env61.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans60_61 : H12PackedSparse.directTransform 14 0 env60 = env61 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env60 == env61) = true)

theorem identity61 : scanCanonicalize (H12AffineState.compose env61 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound61 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env62 : List Nat := [2,4,8,16,32,16,40,4,512,21,2048,4096,8,16384,0,34,4097,2080,20485,1048576,16385,32,20480,16777216,33554432,20480,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound62 : H12AffineState.Bounded env62 := by
  intro p hp
  have h : env62.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans61_62 : H12PackedSparse.directTransform 5 16 env61 = env62 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 16 env61 == env62) = true)

theorem identity62 : scanCanonicalize (H12AffineState.compose env62 (packedSelected [2] rootPS)) = affineNative (2^(13+1) ^^^ 4112) := by decide +kernel

theorem selectedBound62 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env63 : List Nat := [2,4,8,16,32,16,40,4,512,21,2048,4096,8,4112,0,34,4097,2080,21,1048576,4113,32,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound63 : H12AffineState.Bounded env63 := by
  intro p hp
  have h : env63.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans62_63 : H12PackedSparse.directTransform 13 4112 env62 = env63 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 4112 env62 == env63) = true)

theorem identity63 : scanCanonicalize (H12AffineState.compose env63 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound63 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env64 : List Nat := [2,4,8,16,10,16,2,4,512,21,2048,4096,8,4112,0,8,4097,2058,21,1048576,4113,10,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound64 : H12AffineState.Bounded env64 := by
  intro p hp
  have h : env64.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans63_64 : H12PackedSparse.directTransform 4 10 env63 = env64 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 4 10 env63 == env64) = true)

theorem identity64 : scanCanonicalize (H12AffineState.compose env64 (packedSelected [1,5] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound64 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env65 : List Nat := [2,4,8,1,10,1,2,4,512,4,2048,4096,8,4097,0,8,4097,2058,4,1048576,4096,10,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound65 : H12AffineState.Bounded env65 := by
  intro p hp
  have h : env65.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans64_65 : H12PackedSparse.directTransform 3 1 env64 = env65 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 1 env64 == env65) = true)

theorem identity65 : scanCanonicalize (H12AffineState.compose env65 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound65 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env66 : List Nat := [2,4,2,1,0,1,2,4,512,4,2048,4096,2,4097,0,2,4097,2048,4,1048576,4096,0,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound66 : H12AffineState.Bounded env66 := by
  intro p hp
  have h : env66.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans65_66 : H12PackedSparse.directTransform 2 2 env65 = env66 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 2 2 env65 == env66) = true)

theorem identity66 : scanCanonicalize (H12AffineState.compose env66 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 2) := by decide +kernel

theorem selectedBound66 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env67 : List Nat := [2,4,2,1,0,1,2,4,512,4,2,4096,2,4097,0,2,4097,2,4,1048576,4096,0,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound67 : H12AffineState.Bounded env67 := by
  intro p hp
  have h : env67.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans66_67 : H12PackedSparse.directTransform 10 2 env66 = env67 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 10 2 env66 == env67) = true)

theorem identity67 : scanCanonicalize (H12AffineState.compose env67 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 4) := by decide +kernel

theorem selectedBound67 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env68 : List Nat := [2,4,2,1,0,1,2,4,4,4,2,4096,2,4097,0,2,4097,2,4,1048576,4096,0,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound68 : H12AffineState.Bounded env68 := by
  intro p hp
  have h : env68.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans67_68 : H12PackedSparse.directTransform 8 4 env67 = env68 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 8 4 env67 == env68) = true)

def w24 : H12WitnessTheory.Witness := H12WitnessData002.batch13[192]'(by decide)

end H12AffineWide