from pathlib import Path
import zipfile, subprocess, sys, json
out=Path.cwd()/'outputs/H12_preprint'
dest=Path.cwd()/'work/reviewer_delivery_check'
dest.mkdir(parents=True,exist_ok=True)
with zipfile.ZipFile(out/'H12_PACOTE_ANALISE_ADVERSARIAL.zip') as z:
    for name in ['H12_preprint.md','audit_article_transcription.py']:
        (dest/name).write_bytes(z.read(name))
def run(args):
    p=subprocess.run([sys.executable,'-X','utf8',*args],cwd=dest,capture_output=True,text=True)
    return p.returncode
assert run(['audit_article_transcription.py'])==0
original=(dest/'H12_preprint.md').read_text(encoding='utf-8')
cases={
    'duplicate_orbit_representative':('0,1,2,3','0,1,2,4'),
    'wrong_linear_identity_factor':('(1,7),(3,1)','(1,8),(3,1)'),
    'wrong_periodic_truth_table':('0x6ca0','0x6ca1'),
}
results=[]
for name,(old,new) in cases.items():
    assert old in original
    (dest/'corrupted.md').write_text(original.replace(old,new,1),encoding='utf-8')
    code=run(['audit_article_transcription.py','--article','corrupted.md'])
    assert code!=0, name
    results.append({'case':name,'expected_rejection':True,'exit_code':code})
code=run(['-O','audit_article_transcription.py'])
assert code!=0
results.append({'case':'optimization_disables_assertions','expected_rejection':True,'exit_code':code})
report={'status':'PASS_REVIEWER_EXTRACTION_AND_NEGATIVE_CHECKS','clean_extracted_copy_passed':True,'corrupted_copies_rejected':results,'mathematical_article_changed':False,'lean_rebuilt':False}
(out/'REVIEWER_DELIVERY_TESTS.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(report,indent=2))
