"""Exact periodic Walsh projection for n divisible by d; no solver dependency."""
from collections import defaultdict

def rotations(v,d):
 mask=(1<<d)-1
 return sorted({((v<<k)|(v>>(d-k)))&mask for k in range(d)})

def fold(x,n,d):
 assert n%d==0
 mask=(1<<d)-1;y=0
 for k in range(n//d):y^=(x>>(d*k))&mask
 return y

def repeat(v,n,d):
 return sum(v<<(d*k) for k in range(n//d))

def build_projection(input_orbits,n,d):
 seen=set();classes=[];class_index={}
 for y in range(1<<d):
  if y in seen:continue
  orbit=rotations(y,d);seen.update(orbit)
  for q in orbit:class_index[q]=len(classes)
  classes.append(orbit)
 groups=[[] for _ in classes];short=[]
 for orbit in input_orbits:
  if len(orbit)<n:short.append(orbit);continue
  groups[class_index[fold(orbit[0],n,d)]].append(orbit[0])
 matrix=[]
 for freq in classes:
  row=[]
  for orbit in classes:
   assert n%len(orbit)==0
   row.append((n//len(orbit))*sum(1-2*((freq[0]&q).bit_count()%2) for q in orbit))
  matrix.append(row)
 return {'n':n,'d':d,'classes':classes,'groups':groups,'matrix':matrix,'short_orbits':short,'frequencies':[repeat(orbit[0],n,d) for orbit in classes]}

def full_orbit_counts(tt,projection):
 return [sum(tt>>r&1 for r in group) for group in projection['groups']]

def walsh_from_counts(counts,a,b,projection):
 assert projection['n']==16 and projection['d'] in [4,8]
 # All short input orbits project to zero, and their contribution under T20
 # is 256-128*a-192*b. The complete zero-function sum fixes the baseline.
 return [(65536 if u==0 else 0)-128*a-192*b-2*sum(C*w for C,w in zip(row,counts)) for u,row in zip(projection['frequencies'],projection['matrix'])]
