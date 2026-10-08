"""Resume only unresolved exact-certificate screens with more directions."""
import argparse
import json
from pathlib import Path
from research_next_weights import solve, lower_rank, global_equations
from triagem_familias_t32 import model, coefficient_forms

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('input');p.add_argument('directions');p.add_argument('output');args=p.parse_args()
    data=json.loads(Path(args.input).read_text());zs=json.loads(Path(args.directions).read_text())['directions']
    reps,_,hrows,_=model();forms={z:coefficient_forms(reps,z,hrows) for z in zs};glob=global_equations()
    for i,r in enumerate(data['families']):
        if r['status']!='unresolved':continue
        data['families'][i]=solve(int(r['h'],16),hrows,forms,glob)
        if data['families'][i]['status']=='unresolved':
            data['families'][i]=lower_rank(int(r['h'],16),hrows,forms,glob)
        print(r['h'],data['families'][i]['status'],flush=True)
    for w,counts in data['weights'].items():
        subset=[r for r in data['families'] if int(r['h'],16).bit_count()==int(w)]
        counts['additional_certificates']=sum(r['status']=='excluded' for r in subset)
        counts['unresolved']=sum(r['status']=='unresolved' for r in subset)
    data['directions']=sorted(set(data['directions'])|set(zs))
    Path(args.output).write_text(json.dumps(data,indent=2)+'\n')
