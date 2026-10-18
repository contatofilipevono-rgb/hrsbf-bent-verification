import H12WitnessData000
import H12WitnessData001
import H12WitnessData002
import H12WitnessData003
import H12WitnessData004
import H12WitnessData005
import H12WitnessData006
import H12WitnessData007
import H12WitnessData008
import H12WitnessData009
import H12WitnessData010
import H12WitnessData011
import H12WitnessData012
import H12WitnessData013
import H12WitnessData014
import H12WitnessData015
import H12WitnessData016
import H12WitnessData017
import H12WitnessData018
import H12WitnessData019
import H12WitnessData020
import H12WitnessData021
import H12WitnessData022
import H12WitnessData023
import H12WitnessData024
import H12WitnessData025
import H12WitnessData026
import H12WitnessData027
import H12WitnessData028
import H12WitnessData029
import H12WitnessData030
import H12WitnessData031
import H12WitnessData032
import H12WitnessData033
import H12WitnessData034
import H12WitnessData035
import H12WitnessData036
import H12WitnessData037
import H12WitnessData038
import H12WitnessData039
import H12WitnessData040

namespace H12Witnesses
open H12WitnessTheory
set_option maxRecDepth 100000

def entries : List Witness := H12WitnessData000.entries ++ H12WitnessData001.entries ++ H12WitnessData002.entries ++ H12WitnessData003.entries ++ H12WitnessData004.entries ++ H12WitnessData005.entries ++ H12WitnessData006.entries ++ H12WitnessData007.entries ++ H12WitnessData008.entries ++ H12WitnessData009.entries ++ H12WitnessData010.entries ++ H12WitnessData011.entries ++ H12WitnessData012.entries ++ H12WitnessData013.entries ++ H12WitnessData014.entries ++ H12WitnessData015.entries ++ H12WitnessData016.entries ++ H12WitnessData017.entries ++ H12WitnessData018.entries ++ H12WitnessData019.entries ++ H12WitnessData020.entries ++ H12WitnessData021.entries ++ H12WitnessData022.entries ++ H12WitnessData023.entries ++ H12WitnessData024.entries ++ H12WitnessData025.entries ++ H12WitnessData026.entries ++ H12WitnessData027.entries ++ H12WitnessData028.entries ++ H12WitnessData029.entries ++ H12WitnessData030.entries ++ H12WitnessData031.entries ++ H12WitnessData032.entries ++ H12WitnessData033.entries ++ H12WitnessData034.entries ++ H12WitnessData035.entries ++ H12WitnessData036.entries ++ H12WitnessData037.entries ++ H12WitnessData038.entries ++ H12WitnessData039.entries ++ H12WitnessData040.entries

theorem checked : entries.all check = true := by
  simp only [entries, List.all_append, H12WitnessData000.checked, H12WitnessData001.checked, H12WitnessData002.checked, H12WitnessData003.checked, H12WitnessData004.checked, H12WitnessData005.checked, H12WitnessData006.checked, H12WitnessData007.checked, H12WitnessData008.checked, H12WitnessData009.checked, H12WitnessData010.checked, H12WitnessData011.checked, H12WitnessData012.checked, H12WitnessData013.checked, H12WitnessData014.checked, H12WitnessData015.checked, H12WitnessData016.checked, H12WitnessData017.checked, H12WitnessData018.checked, H12WitnessData019.checked, H12WitnessData020.checked, H12WitnessData021.checked, H12WitnessData022.checked, H12WitnessData023.checked, H12WitnessData024.checked, H12WitnessData025.checked, H12WitnessData026.checked, H12WitnessData027.checked, H12WitnessData028.checked, H12WitnessData029.checked, H12WitnessData030.checked, H12WitnessData031.checked, H12WitnessData032.checked, H12WitnessData033.checked, H12WitnessData034.checked, H12WitnessData035.checked, H12WitnessData036.checked, H12WitnessData037.checked, H12WitnessData038.checked, H12WitnessData039.checked, H12WitnessData040.checked, Bool.true_and]

theorem rejects_every_entry : ∀ w ∈ entries, ¬H12Descent.BentAC
    (H12.quarticFunction (BitVec.ofNat 43 w.coefficient)) := checked_list_sound entries checked
#print axioms rejects_every_entry
end H12Witnesses
