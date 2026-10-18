"""Find the smallest modular weight test rejecting each existing Walsh witness."""
from pathlib import Path
from collections import Counter
import csv,hashlib,json


def main():
    root=Path(__file__).resolve().parent.parent
    histogram=Counter();values=Counter();seen=set();sources=[]
    for path in sorted((root/'cpu_replay').glob('full_thread*.csv')):
        sources.append({'path':path.relative_to(root).as_posix(),
                        'sha256':hashlib.sha256(path.read_bytes()).hexdigest()})
        with path.open(newline='') as stream:
            for row in csv.DictReader(stream):
                c=int(row['original_coefficient'],16);w=int(row['walsh_value'])
                assert 0<=c<1<<43 and c not in seen and 0<=int(row['witness_frequency'])<4096
                assert -4096<=w<=4096 and w%2==0 and abs(w)!=64
                weight=(4096-w)//2
                bits=next(k for k in range(1,14) if weight%(1<<k) not in (2016%(1<<k),2080%(1<<k)))
                histogram[bits]+=1;values[w]+=1;seen.add(c)
    assert len(seen)==164288
    report={'status':'EXACT_WITNESS_LOW_BIT_AUDIT','total':len(seen),
            'minimum_weight_bits_to_reject':dict(sorted(histogram.items())),
            'walsh_values':dict(sorted(values.items())),'source_files':sources,
            'scope':'Optimization guidance. These modular witness checks are not yet implemented in Lean.'}
    (root/'reports/WALSH_WITNESS_MODULI.json').write_text(json.dumps(report,indent=2))
    print(json.dumps({'status':report['status'],'total':len(seen),'minimum_bits':dict(sorted(histogram.items()))}))


if __name__=='__main__':main()
