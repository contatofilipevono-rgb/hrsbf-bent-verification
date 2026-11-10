import json
from pathlib import Path
from higher_orbits import high_actions,orbit
b=Path(__file__).parent
p=json.loads((b/'dual-quintic-top-orbits.json').read_text())
g=orbit(int('40640b82416fcc8c',16),high_actions())
assert sum(r['mask'] in g for r in p['classes'])==1
p['classes']=[r for r in p['classes'] if r['mask'] not in g]
(b/'dual-quintic-new-tops.json').write_text(json.dumps(p,indent=2)+'\n')
