import Std
namespace H12Descent
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def rotate4 (x : Nat) : Nat := ((BitVec.ofNat 12 x).rotateLeft 8).toNat
def repeat4 (y : Nat) : Nat := y + 16*y + 256*y
def representatives : List Nat := [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,274,275,276,277,278,279,280,281,282,283,284,285,286,287,290,291,292,293,294,295,296,297,298,299,300,301,302,303,306,307,308,309,310,311,312,313,314,315,316,317,318,319,322,323,324,325,326,327,328,329,330,331,332,333,334,335,338,339,340,341,342,343,344,345,346,347,348,349,350,351,354,355,356,357,358,359,360,361,362,363,364,365,366,367,370,371,372,373,374,375,376,377,378,379,380,381,382,383,386,387,388,389,390,391,392,393,394,395,396,397,398,399,402,403,404,405,406,407,408,409,410,411,412,413,414,415,418,419,420,421,422,423,424,425,426,427,428,429,430,431,434,435,436,437,438,439,440,441,442,443,444,445,446,447,450,451,452,453,454,455,456,457,458,459,460,461,462,463,466,467,468,469,470,471,472,473,474,475,476,477,478,479,482,483,484,485,486,487,488,489,490,491,492,493,494,495,498,499,500,501,502,503,504,505,506,507,508,509,510,511,547,548,549,550,551,552,553,554,555,556,557,558,559,563,564,565,566,567,568,569,570,571,572,573,574,575,579,580,581,582,583,584,585,586,587,588,589,590,591,595,596,597,598,599,600,601,602,603,604,605,606,607,611,612,613,614,615,616,617,618,619,620,621,622,623,627,628,629,630,631,632,633,634,635,636,637,638,639,643,644,645,646,647,648,649,650,651,652,653,654,655,659,660,661,662,663,664,665,666,667,668,669,670,671,675,676,677,678,679,680,681,682,683,684,685,686,687,691,692,693,694,695,696,697,698,699,700,701,702,703,707,708,709,710,711,712,713,714,715,716,717,718,719,723,724,725,726,727,728,729,730,731,732,733,734,735,739,740,741,742,743,744,745,746,747,748,749,750,751,755,756,757,758,759,760,761,762,763,764,765,766,767,820,821,822,823,824,825,826,827,828,829,830,831,836,837,838,839,840,841,842,843,844,845,846,847,852,853,854,855,856,857,858,859,860,861,862,863,868,869,870,871,872,873,874,875,876,877,878,879,884,885,886,887,888,889,890,891,892,893,894,895,900,901,902,903,904,905,906,907,908,909,910,911,916,917,918,919,920,921,922,923,924,925,926,927,932,933,934,935,936,937,938,939,940,941,942,943,948,949,950,951,952,953,954,955,956,957,958,959,964,965,966,967,968,969,970,971,972,973,974,975,980,981,982,983,984,985,986,987,988,989,990,991,996,997,998,999,1000,1001,1002,1003,1004,1005,1006,1007,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1093,1094,1095,1096,1097,1098,1099,1100,1101,1102,1103,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1125,1126,1127,1128,1129,1130,1131,1132,1133,1134,1135,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1157,1158,1159,1160,1161,1162,1163,1164,1165,1166,1167,1173,1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1189,1190,1191,1192,1193,1194,1195,1196,1197,1198,1199,1205,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1221,1222,1223,1224,1225,1226,1227,1228,1229,1230,1231,1237,1238,1239,1240,1241,1242,1243,1244,1245,1246,1247,1253,1254,1255,1256,1257,1258,1259,1260,1261,1262,1263,1269,1270,1271,1272,1273,1274,1275,1276,1277,1278,1279,1366,1367,1368,1369,1370,1371,1372,1373,1374,1375,1382,1383,1384,1385,1386,1387,1388,1389,1390,1391,1398,1399,1400,1401,1402,1403,1404,1405,1406,1407,1414,1415,1416,1417,1418,1419,1420,1421,1422,1423,1430,1431,1432,1433,1434,1435,1436,1437,1438,1439,1446,1447,1448,1449,1450,1451,1452,1453,1454,1455,1462,1463,1464,1465,1466,1467,1468,1469,1470,1471,1478,1479,1480,1481,1482,1483,1484,1485,1486,1487,1494,1495,1496,1497,1498,1499,1500,1501,1502,1503,1510,1511,1512,1513,1514,1515,1516,1517,1518,1519,1526,1527,1528,1529,1530,1531,1532,1533,1534,1535,1639,1640,1641,1642,1643,1644,1645,1646,1647,1655,1656,1657,1658,1659,1660,1661,1662,1663,1671,1672,1673,1674,1675,1676,1677,1678,1679,1687,1688,1689,1690,1691,1692,1693,1694,1695,1703,1704,1705,1706,1707,1708,1709,1710,1711,1719,1720,1721,1722,1723,1724,1725,1726,1727,1735,1736,1737,1738,1739,1740,1741,1742,1743,1751,1752,1753,1754,1755,1756,1757,1758,1759,1767,1768,1769,1770,1771,1772,1773,1774,1775,1783,1784,1785,1786,1787,1788,1789,1790,1791,1912,1913,1914,1915,1916,1917,1918,1919,1928,1929,1930,1931,1932,1933,1934,1935,1944,1945,1946,1947,1948,1949,1950,1951,1960,1961,1962,1963,1964,1965,1966,1967,1976,1977,1978,1979,1980,1981,1982,1983,1992,1993,1994,1995,1996,1997,1998,1999,2008,2009,2010,2011,2012,2013,2014,2015,2024,2025,2026,2027,2028,2029,2030,2031,2040,2041,2042,2043,2044,2045,2046,2047,2185,2186,2187,2188,2189,2190,2191,2201,2202,2203,2204,2205,2206,2207,2217,2218,2219,2220,2221,2222,2223,2233,2234,2235,2236,2237,2238,2239,2249,2250,2251,2252,2253,2254,2255,2265,2266,2267,2268,2269,2270,2271,2281,2282,2283,2284,2285,2286,2287,2297,2298,2299,2300,2301,2302,2303,2458,2459,2460,2461,2462,2463,2474,2475,2476,2477,2478,2479,2490,2491,2492,2493,2494,2495,2506,2507,2508,2509,2510,2511,2522,2523,2524,2525,2526,2527,2538,2539,2540,2541,2542,2543,2554,2555,2556,2557,2558,2559,2731,2732,2733,2734,2735,2747,2748,2749,2750,2751,2763,2764,2765,2766,2767,2779,2780,2781,2782,2783,2795,2796,2797,2798,2799,2811,2812,2813,2814,2815,3004,3005,3006,3007,3020,3021,3022,3023,3036,3037,3038,3039,3052,3053,3054,3055,3068,3069,3070,3071,3277,3278,3279,3293,3294,3295,3309,3310,3311,3325,3326,3327,3550,3551,3566,3567,3582,3583,3823,3839]
def fixedPoints : List Nat := (List.range 16).map repeat4
def triples (rs : List Nat) : List Nat :=
  rs.flatMap (fun r => [r, rotate4 r, rotate4 (rotate4 r)])
def orbitPartition : List Nat := fixedPoints ++ triples representatives

def mergeFuel : Nat → List Nat → List Nat → List Nat
  | 0, xs, ys => xs ++ ys
  | _+1, [], ys => ys
  | _+1, xs, [] => xs
  | n+1, a::as, b::bs =>
    if a ≤ b then a :: mergeFuel n as (b::bs) else b :: mergeFuel n (a::as) bs
theorem merge_perm (n : Nat) (xs ys : List Nat) :
    (mergeFuel n xs ys).Perm (xs ++ ys) := by
  induction n generalizing xs ys with
  | zero => exact .refl _
  | succ n ih =>
    cases xs with
    | nil => simp [mergeFuel]
    | cons a as =>
      cases ys with
      | nil => simp [mergeFuel]
      | cons b bs =>
        simp only [mergeFuel]
        split
        · exact (ih as (b::bs)).cons a
        · exact ((ih (a::as) bs).cons b).trans List.perm_middle.symm
def sortFuel : Nat → List Nat → List Nat
  | 0, xs => xs
  | n+1, xs =>
    mergeFuel xs.length (sortFuel n (xs.take (xs.length/2)))
      (sortFuel n (xs.drop (xs.length/2)))
theorem sort_perm (n : Nat) (xs : List Nat) : (sortFuel n xs).Perm xs := by
  induction n generalizing xs with
  | zero => exact .refl _
  | succ n ih =>
    exact (merge_perm _ _ _).trans
      (((ih _).append (ih _)).trans (List.Perm.of_eq (List.take_append_drop ..)))

theorem sorted_partition :
    sortFuel 12 orbitPartition = List.range 4096 := by decide +kernel

theorem partition_perm : orbitPartition.Perm (List.range 4096) := by
  have h := (sort_perm 12 orbitPartition).symm
  rw [sorted_partition] at h
  exact h

theorem perm_sum_int {xs ys : List Int} (h : xs.Perm ys) : xs.sum = ys.sum := by
  induction h with
  | nil => simp
  | cons _ _ ih => simp [ih]
  | swap => simpa [List.sum_cons] using Int.add_left_comm ..
  | trans _ _ ih₁ ih₂ => simp [ih₁, ih₂]

theorem triple_sum (rs : List Nat) (h : Nat → Int)
    (hi : ∀ r ∈ rs, h (rotate4 r) = h r ∧ h (rotate4 (rotate4 r)) = h r) :
    ((triples rs).map h).sum = 3 * (rs.map h).sum := by
  induction rs with
  | nil => simp [triples]
  | cons r rs ih =>
    have hr := hi r (by simp)
    have ht : ∀ a ∈ rs, h (rotate4 a) = h a ∧ h (rotate4 (rotate4 a)) = h a := by
      intro a ha; exact hi a (by simp [ha])
    have he := ih ht
    simp only [triples, List.flatMap_cons, List.map_append, List.sum_append,
      List.map_cons, List.map_nil, List.sum_cons, List.sum_nil] at he ⊢
    rw [hr.1, hr.2]
    omega

theorem sum_decomposition (h : Nat → Int)
    (hi : ∀ r ∈ representatives,
      h (rotate4 r) = h r ∧ h (rotate4 (rotate4 r)) = h r) :
    ((List.range 4096).map h).sum =
      (fixedPoints.map h).sum + 3 * (representatives.map h).sum := by
  have hp := perm_sum_int (partition_perm.map h)
  rw [← hp]
  simp only [orbitPartition, List.map_append, List.sum_append]
  rw [triple_sum representatives h hi]

theorem descent_mod_three (h : Nat → Int)
    (hi : ∀ r ∈ representatives,
      h (rotate4 r) = h r ∧ h (rotate4 (rotate4 r)) = h r)
    (hzero : ((List.range 4096).map h).sum = 0) :
    3 ∣ (fixedPoints.map h).sum := by
  have hd := sum_decomposition h hi
  refine ⟨-((representatives.map h).sum), ?_⟩
  omega

#print axioms sorted_partition
#print axioms descent_mod_three

def derivativeSign (f : Nat → Bool) (u x : Nat) : Int :=
  if f x == f (x ^^^ u) then 1 else -1
def Rotational4 (f : Nat → Bool) : Prop :=
  ∀ x, x < 4096 → f (rotate4 x) = f x
def BentAC (f : Nat → Bool) : Prop :=
  ∀ u, u < 4096 → u ≠ 0 → ((List.range 4096).map (derivativeSign f u)).sum = 0

theorem rotate_xor (x y : BitVec 12) :
    (x ^^^ y).rotateLeft 8 = x.rotateLeft 8 ^^^ y.rotateLeft 8 := by
  apply BitVec.eq_of_getLsbD_eq
  intro i hi
  simp only [BitVec.getLsbD_rotateLeft, BitVec.getLsbD_xor]
  split
  · rfl
  · simp [hi]

theorem fixed_repeat : ∀ u : Fin 16,
    (BitVec.ofNat 12 (repeat4 u.val)).rotateLeft 8 = BitVec.ofNat 12 (repeat4 u.val) := by decide

theorem xor_compatibility : ∀ x : Fin 4096, ∀ u : Fin 16,
    rotate4 (x.val ^^^ repeat4 u.val) = rotate4 x.val ^^^ repeat4 u.val ∧
    (x.val ^^^ repeat4 u.val) < 4096 ∧ rotate4 x.val < 4096 := by
  intro x u
  have hu : repeat4 u.val < 4096 := by unfold repeat4; omega
  constructor
  · unfold rotate4
    rw [BitVec.ofNat_xor, rotate_xor, fixed_repeat u, BitVec.toNat_xor]
    simp [BitVec.toNat_ofNat, Nat.mod_eq_of_lt hu]
  · constructor
    · have hb := ((BitVec.ofNat 12 x.val) ^^^ (BitVec.ofNat 12 (repeat4 u.val))).isLt
      simpa [BitVec.toNat_xor, BitVec.toNat_ofNat, Nat.mod_eq_of_lt x.isLt,
        Nat.mod_eq_of_lt hu] using hb
    · exact ((BitVec.ofNat 12 x.val).rotateLeft 8).isLt

theorem representative_bounds : representatives.all (fun x => decide (x < 4096)) = true := by decide

theorem repeated_shift_bounds : ∀ u : Fin 15,
    repeat4 (u.val+1) < 4096 ∧ repeat4 (u.val+1) ≠ 0 := by decide

theorem bent_rotational_descent (f : Nat → Bool) (hr : Rotational4 f) (hb : BentAC f)
    (u : Fin 15) :
    3 ∣ (fixedPoints.map (derivativeSign f (repeat4 (u.val+1)))).sum := by
  have hu : u.val+1 < 16 := by omega
  have hd : ∀ x, x < 4096 →
      derivativeSign f (repeat4 (u.val+1)) (rotate4 x) =
        derivativeSign f (repeat4 (u.val+1)) x := by
    intro x hx
    have hc := xor_compatibility ⟨x,hx⟩ ⟨u.val+1,hu⟩
    unfold derivativeSign
    rw [hr x hx, ← hc.1, hr _ hc.2.1]
  apply descent_mod_three
  · intro r hm
    have hlt : r < 4096 := by
      have h := (List.all_eq_true.mp representative_bounds) r hm
      exact of_decide_eq_true h
    have hc := xor_compatibility ⟨r,hlt⟩ ⟨u.val+1,hu⟩
    exact ⟨hd r hlt, (hd (rotate4 r) hc.2.2).trans (hd r hlt)⟩
  · have hs := repeated_shift_bounds u
    exact hb _ hs.1 hs.2

#print axioms bent_rotational_descent
end H12Descent
