import H12MixedPilotData004

namespace H12MixedPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def active31 : List Nat := [0,1,11]

def tree31 : H12WitnessSearch.Tree := (.node 3301694440488 (.node 2018052026282 (.node 1513149741165 (.leaf w8) (.leaf w9)) (.node 2153116908527 (.leaf w10) (.leaf w11))) (.node 3941661607850 (.node 3436759322733 (.leaf w12) (.leaf w13)) (.node 4076726490095 (.leaf w14) (.leaf w15))))

theorem treeGood31 : H12WitnessSearch.Good tree31 := (H12WitnessSearch.node_good 3301694440488 _ _ (H12WitnessSearch.node_good 2018052026282 _ _ (H12WitnessSearch.node_good 1513149741165 _ _ w8_good w9_good) (H12WitnessSearch.node_good 2153116908527 _ _ w10_good w11_good)) (H12WitnessSearch.node_good 3941661607850 _ _ (H12WitnessSearch.node_good 3436759322733 _ _ w12_good w13_good) (H12WitnessSearch.node_good 4076726490095 _ _ w14_good w15_good)))

theorem terminalChecked31 : H12PackedTerminal.terminalCheckFast env31 active31 tree31 = true := by decide +kernel

end H12MixedPilot