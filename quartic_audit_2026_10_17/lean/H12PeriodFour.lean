import Std

/-! Exact finite periodic reduction for the quartic cyclic space in 12 variables.
No theorem of global H(12,4) nonexistence is asserted in this file.
All finite proofs use kernel reduction or elementary XOR identities.
No native_decide, bv_decide, sorry, or project-specific axiom is used.
-/
namespace H12
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

def quarticOrbits : List (List Nat) := [[15,30,60,120,240,480,960,1920,2055,3075,3585,3840],
[23,46,92,184,368,736,1472,1793,2059,2944,3077,3586],
[39,78,156,312,624,897,1248,1794,2067,2496,3081,3588],
[71,142,284,449,568,898,1136,1796,2083,2272,3089,3592],
[135,225,270,450,540,900,1080,1800,2115,2160,3105,3600],
[113,226,263,452,526,904,1052,1808,2104,2179,3137,3616],
[57,114,228,456,519,912,1038,1824,2076,2307,3201,3648],
[29,58,116,232,464,928,1031,1856,2062,2563,3329,3712],
[27,54,108,216,432,864,1539,1728,2061,2817,3078,3456],
[43,86,172,344,688,1376,1409,1541,2069,2752,2818,3082],
[75,150,300,600,705,1200,1410,1545,2085,2400,2820,3090],
[139,278,353,556,706,1112,1412,1553,2117,2224,2824,3106],
[177,267,354,534,708,1068,1416,1569,2136,2181,2832,3138],
[89,178,356,523,712,1046,1424,1601,2092,2309,2848,3202],
[45,90,180,360,720,1035,1440,1665,2070,2565,2880,3330],
[51,102,204,408,771,816,1542,1632,2073,2433,3084,3264],
[83,166,332,664,773,1217,1328,1546,2089,2434,2656,3092],
[147,294,588,609,777,1176,1218,1554,2121,2352,2436,3108],
[275,305,550,610,785,1100,1220,1570,2185,2200,2440,3140],
[153,306,531,612,801,1062,1224,1602,2124,2313,2448,3204],
[77,154,308,616,833,1043,1232,1666,2086,2464,2569,3332],
[99,198,387,396,774,792,1548,1584,2097,2241,3096,3168],
[163,326,389,652,778,1121,1304,1556,2129,2242,2608,3112],
[291,393,561,582,786,1122,1164,1572,2193,2244,2328,3144],
[281,401,547,562,802,1094,1124,1604,2188,2248,2321,3208],
[141,282,417,564,834,1059,1128,1668,2118,2256,2577,3336],
[195,390,780,1560,2145,3120],
[197,323,394,646,788,1073,1292,1576,2146,2209,2584,3152],
[201,402,537,579,804,1074,1158,1608,2148,2316,2337,3216],
[209,269,418,538,836,1076,1091,1672,2152,2182,2593,3344],
[101,202,404,643,808,1049,1286,1616,2098,2369,2572,3232],
[105,210,420,525,840,1050,1155,1680,2100,2310,2625,3360],
[53,106,212,424,848,1037,1283,1696,2074,2566,2689,3392],
[85,170,340,680,1045,1285,1345,1360,2090,2570,2690,2720],
[149,298,596,673,1061,1192,1289,1346,2122,2384,2578,2692],
[277,337,554,674,1093,1108,1297,1348,2186,2216,2594,2696],
[169,338,533,676,1066,1157,1313,1352,2132,2314,2626,2704],
[165,330,645,660,1065,1185,1290,1320,2130,2370,2580,2640],
[293,586,593,649,1097,1172,1186,1298,2194,2344,2372,2596],
[297,549,594,657,1098,1161,1188,1314,2196,2322,2376,2628],
[325,650,1105,1300,2210,2600],
[329,553,581,658,1106,1162,1169,1316,2212,2324,2338,2632],
[585,1170,2340]]
def periodicColumns : List (BitVec 16) := [0,26752,26752,26752,0,26752,26752,26752,26752,26752,0,26752,26752,26752,0,4680,26752,26752,4680,4680,26752,26752,26752,4680,4680,26752,0,26752,26752,26752,26752,0,26752,0,26752,0,26752,0,26752,26752,27808,26752,32768]
def repeated4 (y : Nat) : Nat := y + 16*y + 256*y
def monomialValue (s x : Nat) : Bool := (x &&& s) == s
def orbitValue (o : List Nat) (x : Nat) : Bool :=
  o.foldl (fun a s => a ^^ monomialValue s x) false

theorem basis_periodic_columns : ∀ j : Fin 43, ∀ y : Fin 16,
    orbitValue (quarticOrbits[j.val]!) (repeated4 y.val) =
      (periodicColumns[j.val]!).getLsbD y.val := by decide

def parityMask (c : BitVec 43) (mask : Nat) : Bool :=
  (List.range 43).foldl
    (fun a j => a ^^ (c.getLsbD j && mask.testBit j)) false

def pack4 (a b c d : Bool) : BitVec 4 :=
  (if a then 1 else 0) ||| (if b then 2 else 0) |||
  (if c then 4 else 0) ||| (if d then 8 else 0)

def parameters (c : BitVec 43) : BitVec 4 :=
  pack4 (c.getLsbD 15 ^^ c.getLsbD 18 ^^ c.getLsbD 19 ^^ c.getLsbD 23 ^^ c.getLsbD 24) (c.getLsbD 40) (c.getLsbD 1 ^^ c.getLsbD 2 ^^ c.getLsbD 3 ^^ c.getLsbD 5 ^^ c.getLsbD 6 ^^ c.getLsbD 7 ^^ c.getLsbD 8 ^^ c.getLsbD 9 ^^ c.getLsbD 11 ^^ c.getLsbD 12 ^^ c.getLsbD 13 ^^ c.getLsbD 16 ^^ c.getLsbD 17 ^^ c.getLsbD 20 ^^ c.getLsbD 21 ^^ c.getLsbD 22 ^^ c.getLsbD 25 ^^ c.getLsbD 27 ^^ c.getLsbD 28 ^^ c.getLsbD 29 ^^ c.getLsbD 30 ^^ c.getLsbD 32 ^^ c.getLsbD 34 ^^ c.getLsbD 36 ^^ c.getLsbD 38 ^^ c.getLsbD 39 ^^ c.getLsbD 41) (c.getLsbD 42)

def restrictionTable (c : BitVec 43) : BitVec 16 :=
  (if c.getLsbD 1 then 26752 else 0) ^^^
  (if c.getLsbD 2 then 26752 else 0) ^^^
  (if c.getLsbD 3 then 26752 else 0) ^^^
  (if c.getLsbD 5 then 26752 else 0) ^^^
  (if c.getLsbD 6 then 26752 else 0) ^^^
  (if c.getLsbD 7 then 26752 else 0) ^^^
  (if c.getLsbD 8 then 26752 else 0) ^^^
  (if c.getLsbD 9 then 26752 else 0) ^^^
  (if c.getLsbD 11 then 26752 else 0) ^^^
  (if c.getLsbD 12 then 26752 else 0) ^^^
  (if c.getLsbD 13 then 26752 else 0) ^^^
  (if c.getLsbD 15 then 4680 else 0) ^^^
  (if c.getLsbD 16 then 26752 else 0) ^^^
  (if c.getLsbD 17 then 26752 else 0) ^^^
  (if c.getLsbD 18 then 4680 else 0) ^^^
  (if c.getLsbD 19 then 4680 else 0) ^^^
  (if c.getLsbD 20 then 26752 else 0) ^^^
  (if c.getLsbD 21 then 26752 else 0) ^^^
  (if c.getLsbD 22 then 26752 else 0) ^^^
  (if c.getLsbD 23 then 4680 else 0) ^^^
  (if c.getLsbD 24 then 4680 else 0) ^^^
  (if c.getLsbD 25 then 26752 else 0) ^^^
  (if c.getLsbD 27 then 26752 else 0) ^^^
  (if c.getLsbD 28 then 26752 else 0) ^^^
  (if c.getLsbD 29 then 26752 else 0) ^^^
  (if c.getLsbD 30 then 26752 else 0) ^^^
  (if c.getLsbD 32 then 26752 else 0) ^^^
  (if c.getLsbD 34 then 26752 else 0) ^^^
  (if c.getLsbD 36 then 26752 else 0) ^^^
  (if c.getLsbD 38 then 26752 else 0) ^^^
  (if c.getLsbD 39 then 26752 else 0) ^^^
  (if c.getLsbD 40 then 27808 else 0) ^^^
  (if c.getLsbD 41 then 26752 else 0) ^^^
  (if c.getLsbD 42 then 32768 else 0)

def normalTable (p : BitVec 4) : BitVec 16 :=
  (if p.getLsbD 0 then 0x1248 else 0) ^^^
  (if p.getLsbD 1 then 0x6ca0 else 0) ^^^
  (if p.getLsbD 2 then 0x6880 else 0) ^^^
  (if p.getLsbD 3 then 0x8000 else 0)

theorem normal_pack : ∀ a b c d : Bool,
    normalTable (pack4 a b c d) =
      (if a then 0x1248 else 0) ^^^ (if b then 0x6ca0 else 0) ^^^
      (if c then 0x6880 else 0) ^^^ (if d then 0x8000 else 0) := by decide

theorem select_xor (a b : Bool) (x : BitVec 16) :
    (if a ^^ b then x else 0) = (if a then x else 0) ^^^ (if b then x else 0) := by
  cases a <;> cases b <;> simp

theorem restriction_normal_form (c : BitVec 43) :
    restrictionTable c = normalTable (parameters c) := by
  simp only [parameters, normal_pack, restrictionTable, select_xor]
  ac_rfl

def quarticFunction (c : BitVec 43) (x : Nat) : Bool :=
  (c.getLsbD 0 && orbitValue (quarticOrbits[(0 : Fin 43).val]!) x) ^^
  (c.getLsbD 1 && orbitValue (quarticOrbits[(1 : Fin 43).val]!) x) ^^
  (c.getLsbD 2 && orbitValue (quarticOrbits[(2 : Fin 43).val]!) x) ^^
  (c.getLsbD 3 && orbitValue (quarticOrbits[(3 : Fin 43).val]!) x) ^^
  (c.getLsbD 4 && orbitValue (quarticOrbits[(4 : Fin 43).val]!) x) ^^
  (c.getLsbD 5 && orbitValue (quarticOrbits[(5 : Fin 43).val]!) x) ^^
  (c.getLsbD 6 && orbitValue (quarticOrbits[(6 : Fin 43).val]!) x) ^^
  (c.getLsbD 7 && orbitValue (quarticOrbits[(7 : Fin 43).val]!) x) ^^
  (c.getLsbD 8 && orbitValue (quarticOrbits[(8 : Fin 43).val]!) x) ^^
  (c.getLsbD 9 && orbitValue (quarticOrbits[(9 : Fin 43).val]!) x) ^^
  (c.getLsbD 10 && orbitValue (quarticOrbits[(10 : Fin 43).val]!) x) ^^
  (c.getLsbD 11 && orbitValue (quarticOrbits[(11 : Fin 43).val]!) x) ^^
  (c.getLsbD 12 && orbitValue (quarticOrbits[(12 : Fin 43).val]!) x) ^^
  (c.getLsbD 13 && orbitValue (quarticOrbits[(13 : Fin 43).val]!) x) ^^
  (c.getLsbD 14 && orbitValue (quarticOrbits[(14 : Fin 43).val]!) x) ^^
  (c.getLsbD 15 && orbitValue (quarticOrbits[(15 : Fin 43).val]!) x) ^^
  (c.getLsbD 16 && orbitValue (quarticOrbits[(16 : Fin 43).val]!) x) ^^
  (c.getLsbD 17 && orbitValue (quarticOrbits[(17 : Fin 43).val]!) x) ^^
  (c.getLsbD 18 && orbitValue (quarticOrbits[(18 : Fin 43).val]!) x) ^^
  (c.getLsbD 19 && orbitValue (quarticOrbits[(19 : Fin 43).val]!) x) ^^
  (c.getLsbD 20 && orbitValue (quarticOrbits[(20 : Fin 43).val]!) x) ^^
  (c.getLsbD 21 && orbitValue (quarticOrbits[(21 : Fin 43).val]!) x) ^^
  (c.getLsbD 22 && orbitValue (quarticOrbits[(22 : Fin 43).val]!) x) ^^
  (c.getLsbD 23 && orbitValue (quarticOrbits[(23 : Fin 43).val]!) x) ^^
  (c.getLsbD 24 && orbitValue (quarticOrbits[(24 : Fin 43).val]!) x) ^^
  (c.getLsbD 25 && orbitValue (quarticOrbits[(25 : Fin 43).val]!) x) ^^
  (c.getLsbD 26 && orbitValue (quarticOrbits[(26 : Fin 43).val]!) x) ^^
  (c.getLsbD 27 && orbitValue (quarticOrbits[(27 : Fin 43).val]!) x) ^^
  (c.getLsbD 28 && orbitValue (quarticOrbits[(28 : Fin 43).val]!) x) ^^
  (c.getLsbD 29 && orbitValue (quarticOrbits[(29 : Fin 43).val]!) x) ^^
  (c.getLsbD 30 && orbitValue (quarticOrbits[(30 : Fin 43).val]!) x) ^^
  (c.getLsbD 31 && orbitValue (quarticOrbits[(31 : Fin 43).val]!) x) ^^
  (c.getLsbD 32 && orbitValue (quarticOrbits[(32 : Fin 43).val]!) x) ^^
  (c.getLsbD 33 && orbitValue (quarticOrbits[(33 : Fin 43).val]!) x) ^^
  (c.getLsbD 34 && orbitValue (quarticOrbits[(34 : Fin 43).val]!) x) ^^
  (c.getLsbD 35 && orbitValue (quarticOrbits[(35 : Fin 43).val]!) x) ^^
  (c.getLsbD 36 && orbitValue (quarticOrbits[(36 : Fin 43).val]!) x) ^^
  (c.getLsbD 37 && orbitValue (quarticOrbits[(37 : Fin 43).val]!) x) ^^
  (c.getLsbD 38 && orbitValue (quarticOrbits[(38 : Fin 43).val]!) x) ^^
  (c.getLsbD 39 && orbitValue (quarticOrbits[(39 : Fin 43).val]!) x) ^^
  (c.getLsbD 40 && orbitValue (quarticOrbits[(40 : Fin 43).val]!) x) ^^
  (c.getLsbD 41 && orbitValue (quarticOrbits[(41 : Fin 43).val]!) x) ^^
  (c.getLsbD 42 && orbitValue (quarticOrbits[(42 : Fin 43).val]!) x)

theorem bit_select (b : Bool) (v : BitVec 16) (i : Nat) :
    (if b then v else 0).getLsbD i = (b && v.getLsbD i) := by
  cases b <;> simp

theorem quartic_periodic (c : BitVec 43) (y : Fin 16) :
    quarticFunction c (repeated4 y.val) = (restrictionTable c).getLsbD y.val := by
  unfold quarticFunction
  simp only [basis_periodic_columns, restrictionTable, BitVec.getLsbD_xor, bit_select]
  change ((c.getLsbD 0 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 1 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 2 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 3 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 4 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 5 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 6 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 7 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 8 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 9 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 10 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 11 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 12 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 13 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 14 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 15 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 16 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 17 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 18 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 19 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 20 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 21 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 22 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 23 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 24 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 25 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 26 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 27 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 28 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 29 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 30 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 31 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 32 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 33 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 34 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 35 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 36 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 37 && (0 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 38 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 39 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 40 && (27808 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 41 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 42 && (32768 : BitVec 16).getLsbD y.val)) = ((c.getLsbD 1 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 2 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 3 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 5 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 6 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 7 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 8 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 9 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 11 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 12 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 13 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 15 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 16 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 17 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 18 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 19 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 20 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 21 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 22 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 23 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 24 && (4680 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 25 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 27 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 28 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 29 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 30 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 32 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 34 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 36 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 38 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 39 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 40 && (27808 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 41 && (26752 : BitVec 16).getLsbD y.val) ^^ (c.getLsbD 42 && (32768 : BitVec 16).getLsbD y.val))
  simp
  all_goals ac_rfl

def autocorrelation4 (table : BitVec 16) (u : Nat) : Int :=
  ((List.range 16).map (fun x =>
    if table.getLsbD x == table.getLsbD (x ^^^ u) then (1 : Int) else -1)).sum

def admissibleMod3 (p : Nat) : Prop :=
  ∀ u : Fin 15, autocorrelation4 (normalTable (BitVec.ofNat 4 p)) (u.val+1) % 3 = 0

theorem four_case_classification : ∀ p : Fin 16,
    admissibleMod3 p.val ↔
      p.val = 2 ∨ p.val = 3 ∨ p.val = 8 ∨ p.val = 15 := by
  unfold admissibleMod3
  decide

theorem four_case_tables :
    normalTable 2 = 0x6ca0 ∧ normalTable 3 = 0x7ee8 ∧
    normalTable 8 = 0x8000 ∧ normalTable 15 = 0x9668 := by decide

theorem periodic_reduction (c : BitVec 43)
    (h : admissibleMod3 (parameters c).toNat) :
    restrictionTable c = 0x6ca0 ∨ restrictionTable c = 0x7ee8 ∨
    restrictionTable c = 0x8000 ∨ restrictionTable c = 0x9668 := by
  have hp := (four_case_classification ⟨(parameters c).toNat,
    (parameters c).isLt⟩).mp h
  rw [restriction_normal_form]
  rcases hp with h2 | h3 | h8 | h15
  · left; have he : parameters c = 2 := by apply BitVec.eq_of_toNat_eq; exact h2
    rw [he]; decide
  · right; left; have he : parameters c = 3 := by apply BitVec.eq_of_toNat_eq; exact h3
    rw [he]; decide
  · right; right; left; have he : parameters c = 8 := by apply BitVec.eq_of_toNat_eq; exact h8
    rw [he]; decide
  · right; right; right; have he : parameters c = 15 := by apply BitVec.eq_of_toNat_eq; exact h15
    rw [he]; decide

#print axioms basis_periodic_columns
#print axioms restriction_normal_form
#print axioms four_case_classification
#print axioms periodic_reduction
#print axioms quartic_periodic
end H12
