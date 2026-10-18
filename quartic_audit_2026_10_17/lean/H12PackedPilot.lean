import H12PackedPilotData004

namespace H12PackedPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem ref8 : PackedRefutes (fun _ => True) ps8 [] :=
  .contradiction _ _ [1,2,3] (by decide +kernel) (by decide +kernel)

theorem ref7 : PackedRefutes (fun _ => True) ps7 [] := by
  apply PackedRefutes.eliminate ps7 [] 17 23589 (by decide) [0,6,7,11] selectedBound7 id7 bound7 (by simp [packedBounded])
  rw [trans7_8]; exact ref8

theorem ref6 : PackedRefutes (fun _ => True) ps6 [] := by
  apply PackedRefutes.eliminate ps6 [] 15 34 (by decide) [0,4,7,9,11,12,15,20] selectedBound6 id6 bound6 (by simp [packedBounded])
  rw [trans6_7]; exact ref7

theorem ref13 : PackedRefutes (fun _ => True) ps13 [] :=
  .contradiction _ _ [5,8] (by decide +kernel) (by decide +kernel)

theorem ref12 : PackedRefutes (fun _ => True) ps12 [] := by
  apply PackedRefutes.eliminate ps12 [] 18 20 (by decide) [2] selectedBound12 id12 bound12 (by simp [packedBounded])
  rw [trans12_13]; exact ref13

theorem ref11 : PackedRefutes (fun _ => True) ps11 [] := by
  apply PackedRefutes.eliminate ps11 [] 13 5292 (by decide) [2,6] selectedBound11 id11 bound11 (by simp [packedBounded])
  rw [trans11_12]; exact ref12

theorem ref10 : PackedRefutes (fun _ => True) ps10 [] := by
  apply PackedRefutes.eliminate ps10 [] 15 35 (by decide) [2,14] selectedBound10 id10 bound10 (by simp [packedBounded])
  rw [trans10_11]; exact ref11

theorem ref9 : PackedRefutes (fun _ => True) ps9 [] := by
  apply PackedRefutes.eliminate ps9 [] 12 161 (by decide) [13] selectedBound9 id9 bound9 (by simp [packedBounded])
  rw [trans9_10]; exact ref10

theorem ref5 : PackedRefutes (fun _ => True) ps5 [] := by
  apply PackedRefutes.split ps5 [] 14 0 (by decide) bound5 (by simp [packedBounded])
  · rw [trans5_6]; exact ref6
  · rw [show 0 ^^^ 1 = 1 from by decide +kernel, trans5_9]; exact ref9

theorem ref4 : PackedRefutes (fun _ => True) ps4 [] := by
  apply PackedRefutes.eliminate ps4 [] 34 103566 (by decide) [0,2,4,6,7,9,11,14,23] selectedBound4 id4 bound4 (by simp [packedBounded])
  rw [trans4_5]; exact ref5

theorem ref3 : PackedRefutes (fun _ => True) ps3 [] := by
  apply PackedRefutes.eliminate ps3 [] 22 525328 (by decide) [2,11,14,18] selectedBound3 id3 bound3 (by simp [packedBounded])
  rw [trans3_4]; exact ref4

theorem ref2 : PackedRefutes (fun _ => True) ps2 [] := by
  apply PackedRefutes.eliminate ps2 [] 16 5357 (by decide) [3,5,10] selectedBound2 id2 bound2 (by simp [packedBounded])
  rw [trans2_3]; exact ref3

theorem ref23 : PackedRefutes (fun _ => True) ps23 [] :=
  .contradiction _ _ [2] (by decide +kernel) (by decide +kernel)

theorem ref22 : PackedRefutes (fun _ => True) ps22 [] := by
  apply PackedRefutes.eliminate ps22 [] 34 5204 (by decide) [0,2,7,23] selectedBound22 id22 bound22 (by simp [packedBounded])
  rw [trans22_23]; exact ref23

theorem ref21 : PackedRefutes (fun _ => True) ps21 [] := by
  apply PackedRefutes.eliminate ps21 [] 6 121 (by decide) [1,3] selectedBound21 id21 bound21 (by simp [packedBounded])
  rw [trans21_22]; exact ref22

theorem ref20 : PackedRefutes (fun _ => True) ps20 [] := by
  apply PackedRefutes.eliminate ps20 [] 17 2184 (by decide) [0,2,4,7,9] selectedBound20 id20 bound20 (by simp [packedBounded])
  rw [trans20_21]; exact ref21

theorem ref19 : PackedRefutes (fun _ => True) ps19 [] := by
  apply PackedRefutes.eliminate ps19 [] 12 160 (by decide) [2,6] selectedBound19 id19 bound19 (by simp [packedBounded])
  rw [trans19_20]; exact ref20

theorem ref18 : PackedRefutes (fun _ => True) ps18 [] := by
  apply PackedRefutes.eliminate ps18 [] 13 5292 (by decide) [12,15] selectedBound18 id18 bound18 (by simp [packedBounded])
  rw [trans18_19]; exact ref19

theorem ref17 : PackedRefutes (fun _ => True) ps17 [] := by
  apply PackedRefutes.eliminate ps17 [] 15 29742 (by decide) [0,6,7,14,20] selectedBound17 id17 bound17 (by simp [packedBounded])
  rw [trans17_18]; exact ref18

theorem ref28 : PackedRefutes (fun _ => True) ps28 [] :=
  .contradiction _ _ [0,2,7,11] (by decide +kernel) (by decide +kernel)

theorem ref27 : PackedRefutes (fun _ => True) ps27 [] := by
  apply PackedRefutes.eliminate ps27 [] 17 23589 (by decide) [0,4,6,7,9,13] selectedBound27 id27 bound27 (by simp [packedBounded])
  rw [trans27_28]; exact ref28

theorem ref26 : PackedRefutes (fun _ => True) ps26 [] := by
  apply PackedRefutes.eliminate ps26 [] 15 35 (by decide) [0,2,4,6,7,9,13,14] selectedBound26 id26 bound26 (by simp [packedBounded])
  rw [trans26_27]; exact ref27

theorem ref25 : PackedRefutes (fun _ => True) ps25 [] := by
  apply PackedRefutes.eliminate ps25 [] 18 273529 (by decide) [21] selectedBound25 id25 bound25 (by simp [packedBounded])
  rw [trans25_26]; exact ref26

theorem ref24 : PackedRefutes (fun _ => True) ps24 [] := by
  apply PackedRefutes.eliminate ps24 [] 34 602239 (by decide) [0,6,7,14,20] selectedBound24 id24 bound24 (by simp [packedBounded])
  rw [trans24_25]; exact ref25

theorem ref16 : PackedRefutes (fun _ => True) ps16 [] := by
  apply PackedRefutes.split ps16 [] 22 525328 (by decide) bound16 (by simp [packedBounded])
  · rw [trans16_17]; exact ref17
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, trans16_24]; exact ref24

theorem ref34 : PackedRefutes (fun _ => True) ps34 [] :=
  .contradiction _ _ [1,2,3] (by decide +kernel) (by decide +kernel)

theorem ref33 : PackedRefutes (fun _ => True) ps33 [] := by
  apply PackedRefutes.eliminate ps33 [] 17 23588 (by decide) [0,2,7,11] selectedBound33 id33 bound33 (by simp [packedBounded])
  rw [trans33_34]; exact ref34

theorem ref32 : PackedRefutes (fun _ => True) ps32 [] := by
  apply PackedRefutes.eliminate ps32 [] 15 34 (by decide) [2,4,6,9,11,12,15] selectedBound32 id32 bound32 (by simp [packedBounded])
  rw [trans32_33]; exact ref33

theorem ref31 : PackedRefutes (fun _ => True) ps31 [] := by
  apply PackedRefutes.eliminate ps31 [] 12 161 (by decide) [13] selectedBound31 id31 bound31 (by simp [packedBounded])
  rw [trans31_32]; exact ref32

theorem ref30 : PackedRefutes (fun _ => True) ps30 [] := by
  apply PackedRefutes.eliminate ps30 [] 34 78894 (by decide) [0,6,7,14,20] selectedBound30 id30 bound30 (by simp [packedBounded])
  rw [trans30_31]; exact ref31

theorem ref48 : PackedRefutes (fun _ => True) ps48 [] :=
  .contradiction _ _ [15] (by decide +kernel) (by decide +kernel)

theorem ref47 : PackedRefutes (fun _ => True) ps47 [] := by
  apply PackedRefutes.eliminate ps47 [] 5 12 (by decide) [0,1] selectedBound47 id47 bound47 (by simp [packedBounded])
  rw [trans47_48]; exact ref48

theorem ref46 : PackedRefutes (fun _ => True) ps46 [] := by
  apply PackedRefutes.eliminate ps46 [] 3 11 (by decide) [1,8] selectedBound46 id46 bound46 (by simp [packedBounded])
  rw [trans46_47]; exact ref47

theorem ref45 : PackedRefutes (fun _ => True) ps45 [] := by
  apply PackedRefutes.eliminate ps45 [] 6 9 (by decide) [1,5] selectedBound45 id45 bound45 (by simp [packedBounded])
  rw [trans45_46]; exact ref46

theorem ref44 : PackedRefutes (fun _ => True) ps44 [] := by
  apply PackedRefutes.eliminate ps44 [] 10 147 (by decide) [0,4] selectedBound44 id44 bound44 (by simp [packedBounded])
  rw [trans44_45]; exact ref45

theorem ref43 : PackedRefutes (fun _ => True) ps43 [] := by
  apply PackedRefutes.eliminate ps43 [] 9 5 (by decide) [2] selectedBound43 id43 bound43 (by simp [packedBounded])
  rw [trans43_44]; exact ref44

theorem ref42 : PackedRefutes (fun _ => True) ps42 [] := by
  apply PackedRefutes.eliminate ps42 [] 8 32 (by decide) [2,11] selectedBound42 id42 bound42 (by simp [packedBounded])
  rw [trans42_43]; exact ref43

theorem ref41 : PackedRefutes (fun _ => True) ps41 [] := by
  apply PackedRefutes.eliminate ps41 [] 11 1589 (by decide) [0,7] selectedBound41 id41 bound41 (by simp [packedBounded])
  rw [trans41_42]; exact ref42

theorem ref40 : PackedRefutes (fun _ => True) ps40 [] := by
  apply PackedRefutes.eliminate ps40 [] 34 5292 (by decide) [0,2,5,7,8,11,12] selectedBound40 id40 bound40 (by simp [packedBounded])
  rw [trans40_41]; exact ref41

theorem ref39 : PackedRefutes (fun _ => True) ps39 [] := by
  apply PackedRefutes.eliminate ps39 [] 13 5773 (by decide) [2,6] selectedBound39 id39 bound39 (by simp [packedBounded])
  rw [trans39_40]; exact ref40

theorem ref38 : PackedRefutes (fun _ => True) ps38 [] := by
  apply PackedRefutes.eliminate ps38 [] 12 640 (by decide) [1,3] selectedBound38 id38 bound38 (by simp [packedBounded])
  rw [trans38_39]; exact ref39

theorem ref37 : PackedRefutes (fun _ => True) ps37 [] := by
  apply PackedRefutes.eliminate ps37 [] 15 8323 (by decide) [0,4,6,7,9] selectedBound37 id37 bound37 (by simp [packedBounded])
  rw [trans37_38]; exact ref38

theorem ref36 : PackedRefutes (fun _ => True) ps36 [] := by
  apply PackedRefutes.eliminate ps36 [] 17 2185 (by decide) [21] selectedBound36 id36 bound36 (by simp [packedBounded])
  rw [trans36_37]; exact ref37

theorem ref35 : PackedRefutes (fun _ => True) ps35 [] := by
  apply PackedRefutes.eliminate ps35 [] 18 94334 (by decide) [0,6,7,14,20] selectedBound35 id35 bound35 (by simp [packedBounded])
  rw [trans35_36]; exact ref36

theorem ref29 : PackedRefutes (fun _ => True) ps29 [] := by
  apply PackedRefutes.split ps29 [] 22 525328 (by decide) bound29 (by simp [packedBounded])
  · rw [trans29_30]; exact ref30
  · rw [show 525328 ^^^ 1 = 525329 from by decide +kernel, trans29_35]; exact ref35

theorem ref15 : PackedRefutes (fun _ => True) ps15 [] := by
  apply PackedRefutes.split ps15 [] 14 8352 (by decide) bound15 (by simp [packedBounded])
  · rw [trans15_16]; exact ref16
  · rw [show 8352 ^^^ 1 = 8353 from by decide +kernel, trans15_29]; exact ref29

theorem ref14 : PackedRefutes (fun _ => True) ps14 [] := by
  apply PackedRefutes.eliminate ps14 [] 16 103631 (by decide) [3,5,10] selectedBound14 id14 bound14 (by simp [packedBounded])
  rw [trans14_15]; exact ref15

theorem ref1 : PackedRefutes (fun _ => True) ps1 [] := by
  apply PackedRefutes.split ps1 [] 20 570592 (by decide) bound1 (by simp [packedBounded])
  · rw [trans1_2]; exact ref2
  · rw [show 570592 ^^^ 1 = 570593 from by decide +kernel, trans1_14]; exact ref14

theorem ref0 : PackedRefutes (fun _ => True) ps0 [] := by
  apply PackedRefutes.eliminate ps0 [] 21 73891 (by decide) [0,3,7,9,10,13,14,20,21,22,24,26] selectedBound0 id0 bound0 (by simp [packedBounded])
  rw [trans0_1]; exact ref1

theorem no_model (f : Nat → Bool) (hm : packedModels f ps0) : False :=
  (packedRefutes_sound (fun _ => True) _ _ ref0 f hm) trivial

#print axioms no_model

end H12PackedPilot