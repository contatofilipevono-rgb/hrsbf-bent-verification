import H12PackedTerminal

import H12WitnessData000

import H12WitnessData001

import H12WitnessData005

import H12WitnessData007

import H12WitnessData014

import H12WitnessData015

import H12WitnessData019

import H12WitnessData021

namespace H12ConcreteLeaf12

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

open H12PackedPolynomial H12PackedTerminal

def w0 : H12WitnessTheory.Witness := H12WitnessData000.batch0[0]'(by decide)

def w1 : H12WitnessTheory.Witness := H12WitnessData001.batch7[19]'(by decide)

def w2 : H12WitnessTheory.Witness := H12WitnessData005.batch11[32]'(by decide)

def w3 : H12WitnessTheory.Witness := H12WitnessData007.batch2[57]'(by decide)

def w4 : H12WitnessTheory.Witness := H12WitnessData014.batch4[17]'(by decide)

def w5 : H12WitnessTheory.Witness := H12WitnessData015.batch10[187]'(by decide)

def w6 : H12WitnessTheory.Witness := H12WitnessData019.batch15[74]'(by decide)

def w7 : H12WitnessTheory.Witness := H12WitnessData021.batch5[227]'(by decide)

theorem reject0 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w0.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData000.batch0 H12WitnessData000.batch0_checked _ (List.getElem_mem (by decide))

theorem good0 : H12WitnessSearch.Good (.leaf w0) := by
  intro c hc
  have he : w0.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject0

theorem reject1 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w1.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData001.batch7 H12WitnessData001.batch7_checked _ (List.getElem_mem (by decide))

theorem good1 : H12WitnessSearch.Good (.leaf w1) := by
  intro c hc
  have he : w1.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject1

theorem reject2 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w2.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData005.batch11 H12WitnessData005.batch11_checked _ (List.getElem_mem (by decide))

theorem good2 : H12WitnessSearch.Good (.leaf w2) := by
  intro c hc
  have he : w2.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject2

theorem reject3 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w3.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData007.batch2 H12WitnessData007.batch2_checked _ (List.getElem_mem (by decide))

theorem good3 : H12WitnessSearch.Good (.leaf w3) := by
  intro c hc
  have he : w3.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject3

theorem reject4 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w4.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData014.batch4 H12WitnessData014.batch4_checked _ (List.getElem_mem (by decide))

theorem good4 : H12WitnessSearch.Good (.leaf w4) := by
  intro c hc
  have he : w4.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject4

theorem reject5 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w5.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData015.batch10 H12WitnessData015.batch10_checked _ (List.getElem_mem (by decide))

theorem good5 : H12WitnessSearch.Good (.leaf w5) := by
  intro c hc
  have he : w5.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject5

theorem reject6 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w6.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData019.batch15 H12WitnessData019.batch15_checked _ (List.getElem_mem (by decide))

theorem good6 : H12WitnessSearch.Good (.leaf w6) := by
  intro c hc
  have he : w6.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject6

theorem reject7 : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w7.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData021.batch5 H12WitnessData021.batch5_checked _ (List.getElem_mem (by decide))

theorem good7 : H12WitnessSearch.Good (.leaf w7) := by
  intro c hc
  have he : w7.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact reject7

def env : List Nat := [2,0,2,0,0,0,2,0,512,0,2048,2050,2,2050,0,2,2050,2048,0,0,2050,0,0,2,0,2,1,0,2048,2050,2050,2048,0,0,0,0,0,2,2050,512,1,2050,0]

def active : List Nat := [0,8,10]

def tree : H12WitnessSearch.Tree := (.node 3577507687424 (.node 1649334550784 (.node 1239475721285 (.leaf w0) (.leaf w1)) (.node 1789231535429 (.leaf w2) (.leaf w3))) (.node 4127263501568 (.node 3712572569669 (.leaf w4) (.leaf w5)) (.node 4262328383813 (.leaf w6) (.leaf w7))))

theorem good : H12WitnessSearch.Good tree := (H12WitnessSearch.node_good 3577507687424 _ _ (H12WitnessSearch.node_good 1649334550784 _ _ (H12WitnessSearch.node_good 1239475721285 _ _ good0 good1) (H12WitnessSearch.node_good 1789231535429 _ _ good2 good3)) (H12WitnessSearch.node_good 4127263501568 _ _ (H12WitnessSearch.node_good 3712572569669 _ _ good4 good5) (H12WitnessSearch.node_good 4262328383813 _ _ good6 good7)))

theorem checked : terminalCheckFast env active tree = true := by decide +kernel

theorem rejected : ∀ f, ¬H12CertificateBridge.Target (packedObservation f env) := terminalCheckFast_sound env active tree good checked

#print axioms rejected

end H12ConcreteLeaf12