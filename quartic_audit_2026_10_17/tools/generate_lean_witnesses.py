"""Generate kernel-checked modular Walsh witnesses from preserved CSV data.
CSV Walsh values choose a modulus only. Every accepted rejection is recomputed
from the original quartic truth tables by the Lean kernel.
"""
from pathlib import Path
import csv,json,hashlib,math,re

def main():
 root=Path(__file__).resolve().parent.parent;lean=root/'lean'
 rows=[];sources=[]
 for file in sorted((root/'cpu_replay').glob('full_thread*.csv')):
  sources.append({'path':file.name,'sha256':hashlib.sha256(file.read_bytes()).hexdigest()})
  with file.open(newline='') as f:
   for row in csv.DictReader(f):
    c=int(row['original_coefficient'],16);a=int(row['witness_frequency']);w=int(row['walsh_value'])
    assert 0<=c<1<<43 and 0<=a<4096 and w%2==0 and abs(w)!=64
    weight=(4096-w)//2
    bits=next(k for k in range(1,14) if weight%(1<<k) not in (2016%(1<<k),2080%(1<<k)))
    rows.append((c,a,bits))
 assert len(rows)==164288 and len({r[0] for r in rows})==len(rows)
 rows.sort()
 modules=[]
 for start in range(0,len(rows),4096):
  part=rows[start:start+4096];name=f'H12WitnessData{start//4096:03}';modules.append(name)
  out='import H12WitnessTheory\n\nnamespace '+name+'\nopen H12WitnessTheory\nset_option maxRecDepth 100000\nset_option maxHeartbeats 1000000000\n\n'
  batches=[]
  for bs in range(0,len(part),256):
   bn=f'batch{bs//256}';batches.append(bn)
   out+='def '+bn+' : List Witness := [\n'+',\n'.join(f'  ⟨0x{c:x}, {a}, {k}⟩' for c,a,k in part[bs:bs+256])+']\n\n'
   out+=f'theorem {bn}_checked : {bn}.all check = true := by decide +kernel\n#print axioms {bn}_checked\n\n'
  out+='def entries : List Witness := '+' ++ '.join(batches)+'\n\n'
  out+='theorem checked : entries.all check = true := by\n  simp only [entries, List.all_append, '+', '.join(b+'_checked' for b in batches)+', Bool.true_and]\n\n'
  out+='theorem rejects_every_entry : ∀ w ∈ entries, ¬H12Descent.BentAC\n    (H12.quarticFunction (BitVec.ofNat 43 w.coefficient)) := checked_list_sound entries checked\n'
  out+='#print axioms rejects_every_entry\nend '+name+'\n'
  (lean/(name+'.lean')).write_text(out,encoding='utf-8')
 out='\n'.join('import '+m for m in modules)+'\n\nnamespace H12Witnesses\nopen H12WitnessTheory\nset_option maxRecDepth 100000\n\n'
 out+='def entries : List Witness := '+' ++ '.join(m+'.entries' for m in modules)+'\n\n'
 out+='theorem checked : entries.all check = true := by\n  simp only [entries, List.all_append, '+', '.join(m+'.checked' for m in modules)+', Bool.true_and]\n\n'
 out+='theorem rejects_every_entry : ∀ w ∈ entries, ¬H12Descent.BentAC\n    (H12.quarticFunction (BitVec.ofNat 43 w.coefficient)) := checked_list_sound entries checked\n'
 out+='#print axioms rejects_every_entry\nend H12Witnesses\n'
 (lean/'H12Witnesses.lean').write_text(out,encoding='utf-8')
 lakefile=lean/'lakefile.toml';s=lakefile.read_text(encoding='utf-8-sig')
 marker='[[lean_lib]]\nname = "H12WitnessCertificate"'
 if marker in s:s=s[:s.index(marker)].rstrip()+'\n'
 core=json.loads(re.search(r'roots\s*=\s*(\[[^\]]+\])',s).group(1))
 core=[m for m in core if not m.startswith('H12WitnessData') and m!='H12Witnesses']
 s=re.sub(r'roots\s*=\s*\[[^\]]+\]','roots = '+json.dumps(core),s,count=1)
 s+='\n[[lean_lib]]\nname = "H12WitnessCertificate"\nroots = '+json.dumps(modules+['H12Witnesses'])+'\n'
 lakefile.write_text(s,encoding='utf-8')
 report={'witnesses':len(rows),'data_modules':modules,'sources':sources,'rows_sha256':hashlib.sha256(json.dumps(rows,separators=(',',':')).encode()).hexdigest(),
 'status':'GENERATED_NOT_YET_KERNEL_VERIFIED','scope':'Concrete Walsh rejections only; tree coverage remains a separate obligation.'}
 (root/'reports/LEAN_WITNESS_DATA.json').write_text(json.dumps(report,indent=2))
 print(json.dumps({'witnesses':len(rows),'data_modules':len(modules)}))

if __name__=='__main__':main()
