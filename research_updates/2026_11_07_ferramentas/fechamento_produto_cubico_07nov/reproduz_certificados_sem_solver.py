from pathlib import Path
import json,zlib
root=Path(__file__).parent
p=json.loads(zlib.decompress((root/'CERTIFICADOS_F4_2_L1.json.zlib').read_bytes()))
n=p['n'];m=p['extras'];certs=[int(x,16) for x in p['certificates_hex']];b0=int(p['b0'],16);b1=[int(x,16) for x in p['b1']];b2={(i,j):int(v,16) for i,j,v in p['b2']};C2=[int(x,16) for x in p['C2']];CL={(s,i,k):int(v,16) for s,i,k,v in p['CL']}
assert len(p['assignment_certificate_index'])==1<<m
for e,cidx in enumerate(p['assignment_certificate_index']):
 ks=[i for i in range(m) if e>>i&1];rhs=b0
 for k in ks:rhs^=b1[k]
 for i in range(len(ks)):
  for j in range(i+1,len(ks)):rhs^=b2[ks[i],ks[j]]
 y=certs[cidx]
 assert (y&rhs).bit_count()%2==1
 for c in C2:assert (y&c).bit_count()%2==0
 for s in [1,2]:
  for i in range(n):
   c=CL[s,i,None]
   for k in ks:c^=CL[s,i,k]
   assert (y&c).bit_count()%2==0
print('65536/65536 certificados de insolubilidade conferidos sem resolver sistemas.')
