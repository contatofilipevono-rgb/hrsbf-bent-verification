from pathlib import Path
import re,zipfile,json,hashlib,ast,csv,io,runpy,sys,contextlib
root=Path(__file__).resolve().parent
out=root.parent if (root.parent/'H12_formal_sources.zip').exists() else root.parents[1]/'outputs/H12_revisao3'
sha=lambda b:hashlib.sha256(b).hexdigest()
sourcezip=out/'H12_formal_sources.zip';pyzip=out/'H12_independent_verification.zip'
sets=[];records=[]
with zipfile.ZipFile(sourcezip) as z:
 pins=json.loads(z.read('SOURCE_SHA256.json'))
 for chart in range(3):
  leaves={};active={};used={}
  for name in z.namelist():
   if not re.fullmatch(f'H12CloudChart{chart}Data'+r'\d+\.lean',name):continue
   raw=z.read(name);assert sha(raw)==pins[name];used[name]=sha(raw);s=raw.decode().replace('\r','')
   for m in re.finditer(r'^def leafEnv(\d+)\s*: List Nat := (\[[^\n]*\])',s,re.M):leaves[int(m[1])]=ast.literal_eval(m[2])
   for m in re.finditer(r'^def active(\d+)\s*: List Nat := (\[[^\n]*\])',s,re.M):active[int(m[1])]=ast.literal_eval(m[2])
  assert set(leaves)==set(active)
  allc=set();multiplicity=0
  for node,rows in leaves.items():
   a=active[node];assert len(a)==len(set(a)) and len(rows)==43
   allowed=sum(1<<i for i in a)
   assert all(0<=v<2**37 and not (v>>1)&~allowed for v in rows)
   count=1<<len(a);multiplicity+=count
   for t in range(count):
    x=sum(((t>>k)&1)<<i for k,i in enumerate(a))
    c=sum((((v>>1)&x).bit_count()&1 ^ (v&1))<<j for j,v in enumerate(rows))
    assert c not in allc,(chart,node,'duplicate image');allc.add(c)
  assert len(allc)==multiplicity
  sets.append(allc);records.append({'chart':chart,'terminal_states':len(leaves),'assignments':multiplicity,'distinct_coefficient_vectors':len(allc),'sorted_uint64_le_sha256':sha(b''.join(c.to_bytes(8,'little') for c in sorted(allc))),'certified_data_source_count':len(used)})
with zipfile.ZipFile(pyzip) as z:
 csvset=set();bychart=[set() for _ in range(4)]
 for n in z.namelist():
  if re.fullmatch(r'.*/full_thread\d+\.csv',n):
   for r in csv.DictReader(io.StringIO(z.read(n).decode())):
    c=int(r['original_coefficient'],16);ch=int(r['chart']);assert c not in csvset;csvset.add(c);bychart[ch].add(c)
 for i,s in enumerate(sets):assert s==bychart[i]
 assert not bychart[3] and sum(map(len,sets))==len(set.union(*sets))==len(csvset)==164288
# Independently reconstruct the article's 43 quadratics and evaluate them on ALL terminal images in bit slices.
sys.argv=[str(out/'audit_article_transcription.py'),'--article',str(out/'H12_preprint.md')]
with contextlib.redirect_stdout(io.StringIO()):ns=runpy.run_path(str(out/'audit_article_transcription.py'))
vecs=sorted(csvset);size=(len(vecs)+7)//8;buffers=[bytearray(size) for _ in range(43)]
for k,c in enumerate(vecs):
 for j in range(43):
  if c>>j&1:buffers[j][k//8]|=1<<(k%8)
planes=[int.from_bytes(b,'little') for b in buffers]
for poly in ns['Q']:
 value=0
 for mon in poly:
  term=(1<<len(vecs))-1
  while mon:
   bit=mon&-mon;term&=planes[bit.bit_length()-1];mon^=bit
  value^=term
 assert value==0
report={'status':'PASS_EXACT_TERMINAL_IMAGE_COMPARISON','article_sha256':sha((out/'H12_preprint.md').read_bytes()),'source_zip_sha256':sha(sourcezip.read_bytes()),'python_zip_sha256':sha(pyzip.read_bytes()),'charts':records,'all_terminal_images_distinct':True,'all_43_quadratics_zero_on_every_terminal_image':True,'python_csv_image_sets_equal_lean_terminal_image_sets':True,'total':len(csvset),'new_lean_execution':False,'limit':'Finite source/data audit of the certified terminal images; not a fresh Lean rebuild. Coverage of all common zeros also uses the sound split/elimination rules and the independent checker.'}
(out/'TERMINAL_IMAGE_COMPARISON.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(report,indent=2))
