import H12WitnessLabelData000

namespace H12PartialWitnessLabelIndex

open H12WitnessSearch

def tree : Tree := H12WitnessLabelData000.tree

theorem good : Good tree := H12WitnessLabelData000.good

#print axioms good

end H12PartialWitnessLabelIndex
