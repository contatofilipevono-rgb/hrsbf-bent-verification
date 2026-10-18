def percent_lower(q):
 """A displayed decimal lower bound; exact fractions remain authoritative."""
 import math as _math
 from fractions import Fraction as _Fraction
 exact=100*q;v=float(exact)
 while _Fraction(str(v))>exact:v=_math.nextafter(v,-_math.inf)
 return v

def percent_upper(q):
 import math as _math
 from fractions import Fraction as _Fraction
 exact=100*q;v=float(exact)
 while _Fraction(str(v))<exact:v=_math.nextafter(v,_math.inf)
 return v

"""Two-sided consequence of the independently checked T35 character amplitudes."""
from pathlib import Path
from fractions import Fraction
import json
base=Path(__file__).resolve().parent
certificate=json.loads((base/'T35_LIMITE_CERTIFICADO.json').read_text())
verified=json.loads((base/'T35_LIMITE_VERIFICACAO.json').read_text())
assert verified['verification']=='PASS' and verified['independent_quadratic_bias_checks']==4800
lower=Fraction(0);upper=Fraction(0);branches=[]
for record in certificate['density']['branches']:
 assert [r['combination'] for r in record['combinations']]==list(range(1,8))
 amplitude=Fraction(0)
 for r in record['combinations']:
  rank=r['polar_rank'];assert rank%2==0
  value=Fraction(*r['radical_zero_fraction'])/2**(rank//2)
  assert value==Fraction(*r['average_absolute_slice_bias']);amplitude+=value
 lo=(1-amplitude)/8;hi=(1+amplitude)/8
 assert lo>0 and hi==Fraction(*record['conditional_joint_pass_upper_bound'])
 weight=Fraction(1,64 if record['branch']==0 else 128)
 lower+=weight*lo;upper+=weight*hi
 branches.append({'branch':record['branch'],'conditional_pass_lower_bound':str(lo),'conditional_pass_upper_bound':str(hi)})
assert upper==Fraction(verified['global_pass_upper_bound'])
assert lower+upper==Fraction(3,512)
report={'verification':'PASS','branches':branches,'nine_condition_pass_fraction_lower_bound':str(lower),'nine_condition_pass_fraction_upper_bound':str(upper),'nine_condition_excluded_fraction_lower_bound':str(1-upper),'nine_condition_excluded_fraction_upper_bound':str(1-lower),'excluded_percent_interval':[percent_lower(1-upper),percent_upper(1-lower)],'scope':'Exact rational corollary of the verified T35 amplitudes. At least the lower fraction of functions satisfies all nine necessary conditions; none is asserted to be bent. These same nine filters alone cannot reach 99.9% exclusion.'}
print(json.dumps(report,indent=2))
