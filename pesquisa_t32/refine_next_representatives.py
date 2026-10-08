"""Complete fiber-orbit screening for symmetry representatives; audit output."""
import argparse
import json
from pathlib import Path
from audit_next_weights import load_report
from symmetry_next_weights import groups
from research_next_weights import solve, lower_rank, global_equations
from triagem_familias_t32 import model, coefficient_forms
from audit_independent_cnf import orbit_directions
from audit_all_ones_obstruction import orbits

def perm_bits(x,m):
    return sum(1<<(m*i%16) for i in range(16) if x>>i&1)

def move(rec,h,m):
    out=dict(rec);out['h']=h
    if rec['status']!='excluded':return out
    oo=orbits(16,3);index={s:i for i,(_,o) in enumerate(oo) for s in o}
    pp=[index[tuple(sorted(m*i%16 for i in s))] for s,_ in oo]
    cert=[]
    for eq in rec['certificate']:
        q=dict(eq)
        if q['kind']=='h':q['index']=pp[q['index']]
        elif q['kind']=='fiber':q['z']=perm_bits(q['z'],m);q['r']=perm_bits(q['r'],m)
        elif q['kind']=='all_ones_polar':q['column']=m*q['column']%32
        else:assert q['kind']=='all_ones_linear'
        cert.append(q)
    out['certificate']=cert
    if 'forced_zero_radical' in rec:
        out['forced_zero_radical']=dict(rec['forced_zero_radical'])
        out['forced_zero_radical']['z']=perm_bits(out['forced_zero_radical']['z'],m)
    return out

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('input');p.add_argument('output');args=p.parse_args()
    data,_=load_report(Path(args.input));sym=groups(data);zs=orbit_directions()
    reps,_,hrows,_=model();forms={}
    for i,z in enumerate(zs,1):
        forms[z]=coefficient_forms(reps,z,hrows)
        if i%512==0:print('Prepared',i,'fiber orbits',flush=True)
    glob=global_equations();lookup={r['h']:i for i,r in enumerate(data['families'])}
    for g in sym['families']:
        h=int(g['representative'],16);rec=solve(h,hrows,forms,glob)
        if rec['status']=='unresolved':rec=lower_rank(h,hrows,forms,glob)
        print('Representative',hex(h),rec['status'],flush=True)
        for hh,witness in g['members'].items():
            data['families'][lookup[hh]]=move(rec,hh,witness['odd_multiplier'])
        for w,counts in data['weights'].items():
            sub=[r for r in data['families'] if int(r['h'],16).bit_count()==int(w)]
            counts['additional_certificates']=sum(r['status']=='excluded' for r in sub)
            counts['unresolved']=sum(r['status']=='unresolved' for r in sub)
        data['directions']=sorted(set(data['directions'])|set(zs))
        data['complete_fiber_orbit_representatives']=4115
        Path(args.output).write_text(json.dumps(data,indent=2)+'\n')
