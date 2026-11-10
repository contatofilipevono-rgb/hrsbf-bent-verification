import json
from collections import defaultdict
from pathlib import Path
b=Path(__file__).parent
report=json.loads((b/'dual-quintic-projection.json').read_text())
by_high=defaultdict(list)
for row in report['classes']:
 by_high[row['mask']].append(row)
selected={high for high,branches in by_high.items() if all(r['contradiction'] or r['quartic_free']<=30 for r in branches)}
assert len(selected)==97
rows=[r for r in report['classes'] if r['mask'] in selected]
(b/'dual-quintic-complete-plan.json').write_text(json.dumps({'classes':rows},indent=2)+'\n')
