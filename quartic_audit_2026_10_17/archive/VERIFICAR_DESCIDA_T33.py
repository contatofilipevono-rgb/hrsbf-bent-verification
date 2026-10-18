"""Verify exact descent of the seventh condition to the 33-dimensional T16 quotient."""
import json
from pathlib import Path
from itertools import combinations
base=Path(__file__).resolve().parent;cert=json.loads((base/'T33_DESCIDA_CERTIFICADO.json').read_text());formula=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text())
seen=set();orbits=[]
for t in combinations(range(16),4):
 m=sum(1<<j for j in t)
 if m in seen:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 seen|=orb;orbits.append(orb)
def add(B,v):
 while v:
  j=v.bit_length()-1
  if j in B:v^=B[j]
  else:B[j]=v;return False
 return True
rows={};quotient_rows={};section=[int(v,16) for v in cert['section_coefficients_hex']]
for z in [0,85,170,255,51]:
 for u in range(256):
  x=u|((u^z)<<8);row=sum((sum(x&m==m for m in orb)%2)<<j for j,orb in enumerate(orbits));add(rows,row)
  add(quotient_rows,sum(((c&row).bit_count()%2)<<j for j,c in enumerate(section)))
assert len(rows)==len(quotient_rows)==33
groups={name:formula[name] for name in ['R','M','K']};groups.update(a=[57],b=[99])
for name,indices in groups.items():
 mask=sum(1<<j for j in indices);assert add(dict(rows),mask)
 mapped=sum(((c&mask).bit_count()%2)<<j for j,c in enumerate(section))
 assert mapped==int(cert['forms_masks33_hex'][name],16)
assert int(cert['forms_masks33_hex']['R'],16)>>21==0x7e
print(json.dumps({'verification':'PASS','restriction_rank':33,'section_rank':33,'all_five_forms_determined_by_fibers':True,'forms_masks33_hex':cert['forms_masks33_hex'],'extension_seventh_gradient12_hex':'0x7e','scope':'Exact descent and quotient-coordinate formula. The domain counts and state mapper are checked separately in the CPU validation.'},indent=2))
