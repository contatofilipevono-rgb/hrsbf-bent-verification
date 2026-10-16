"""Small exact checks supporting an analytic period-four folding lemma.
These checks do not replace the proof valid for every prime p>=5.
"""
from itertools import combinations
import numpy as np
import experiment_science as ex

def anf(truth):
    a=np.array(truth,dtype=np.uint8,copy=True)
    for bit in range(4):
        for x in range(16):
            if x>>bit&1:a[...,x]^=a[...,x^(1<<bit)]
    return a

def run(primes=(5,7,11,13,17,19)):
    records=[]
    for p in primes:
        n=4*p;gs=ex.generators(n)
        points=[sum(((pat>>(i%4))&1)<<i for i in range(n)) for pat in range(16)]
        truth=np.array([[sum((x&m)==m for m in orb)%2 for x in points] for _,orb in gs],dtype=np.uint8)
        coeff=anf(truth);pred=np.zeros_like(coeff)
        for i,(support,orb) in enumerate(gs):
            residues={j%4 for j in support}
            if len(orb)==n:
                if len(residues)==1:targets=[1,2,4,8]
                elif len(residues)==2 and residues not in ({0,2},{1,3}):targets=[3,6,12,9]
                elif len(residues)==3:targets=[7,11,13,14]
                else:targets=[]
            elif len(orb)==2*p:
                targets=[5,10] if len(residues)==2 else []
            elif len(orb)==p:targets=[15]
            else:raise AssertionError('Unexpected quartic orbit length')
            pred[i,targets]=1
        assert np.array_equal(coeff,pred)
        assert len(ex.rref(np.unique(coeff,axis=0))[2])==5
        equations=coeff[:,[15,7,5]].T
        assert len(ex.rref(equations)[2])==3
        records.append({'p':p,'n':n,'quartic_generators':len(gs),'all_generator_foldings_match':True,'folding_rank':5,'necessary_equations_rank':3,'fraction_satisfying_three_conditions':'1/8'})
    basis=np.zeros((5,16),dtype=np.uint8)
    for row,targets in enumerate(([1,2,4,8],[3,6,12,9],[5,10],[7,11,13,14],[15])):basis[row,targets]=1
    ids=np.arange(32,dtype=np.uint8);bits=(ids[:,None]>>np.arange(5))&1
    a=(bits@basis)&1;tt=anf(a);w=ex.fwht_cpu(1-2*tt.astype(np.int64))
    bent=np.all(np.abs(w)==4,axis=1)
    expected=(bits[:,2]==1)&(bits[:,3]==0)&(bits[:,4]==0)
    assert np.array_equal(bent,expected) and bent.sum()==4
    ex.save('T13_prime_folding.json',{'status':'PASS','finite_prime_checks':records,'four_variable_RS_zero_constant_functions_checked':32,'bent_count':4,'classification':'h=aL+bC+P; cubic and quartic coefficients zero','scope':'Finite checks of all generators and the base classification; the accompanying analytic orbit-congruence proof covers every prime p>=5. No nonexistence theorem or novelty claim.'})
    np.savez_compressed(ex.ROOT/'T13_n20_fold_map.npz',generator_fold_anf=anf(np.array([[sum((x&m)==m for m in orb)%2 for x in [sum(((pat>>(i%4))&1)<<i for i in range(20)) for pat in range(16)]] for _,orb in ex.generators(20)],dtype=np.uint8)))
    return records

if __name__=='__main__':print(run(),flush=True)
