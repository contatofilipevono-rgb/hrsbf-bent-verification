"""Save evidence for completed data modules of an unfinished chart certificate.
This does not establish coverage by a chart root, a subtree, or a global theorem.
"""
from pathlib import Path
import argparse,hashlib,json,re

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--report',required=True);p.add_argument('--register',action='store_true');args=p.parse_args()
 assert Path(args.report).name==args.report,'Use a report basename.'
 root=Path(__file__).resolve().parent.parent;lean=root/'lean';reports=root/'reports';parent=json.loads((reports/args.report).read_text())
 match=re.fullmatch(r'(H12GlobalChart[012])Certificate',parent['library']);assert match,'Expected a concrete global-chart library.'
 prefix=match[1];selected=[]
 for e in parent['results']:
  if e['module']!=f'{prefix}Data{len(selected):03d}' or e.get('build_exit_code')!=0 or e.get('kernel_exit_code')!=0:break
  selected.append(e)
 assert selected,'No completed data prefix to preserve.'
 dependencies={};stack=[e['module'] for e in selected]
 while stack:
  name=stack.pop();file=lean/(name+'.lean')
  if name in dependencies or not file.exists():continue
  dependencies[name]=hashlib.sha256(file.read_bytes()).hexdigest();stack.extend(re.findall(r'^import\s+(\w+)',file.read_text(encoding='utf-8'),re.M))
 for name,sha in dependencies.items():assert parent['dependencies'][name]==sha,('changed dependency',name)
 for e in selected:
  assert e['source_sha256']==dependencies[e['module']]
  for phase in ['build','kernel']:
   text=(reports/('sequential_'+parent['library'])/(e['module']+'_'+phase+'.log')).read_text(encoding='utf-8')
   assert not any(x in text for x in ['sorryAx','ofReduceBool','error:']),(e['module'],phase)
 output=reports/'LEAN_VERIFIED_PREFIX_AUDIT.json';data=json.loads(output.read_text()) if output.exists() else {'status':'PASS_VERIFIED_DATA_PREFIX_EVIDENCE','root_coverage':False,'unconditional_global_theorem':False,'groups':[]}
 assert data['status']=='PASS_VERIFIED_DATA_PREFIX_EVIDENCE' and data['root_coverage'] is False
 previous=next((g for g in data['groups'] if g['prefix']==prefix),None)
 if previous:
  assert len(previous['results'])<=len(selected),'Refusing to replace a longer prefix.'
  for name,sha in previous['dependencies'].items():assert dependencies[name]==sha,('changed previous prefix',name)
 snapshot=dict(parent);snapshot.update(status='PARTIAL_DATA_PREFIX_SNAPSHOT',results=selected,modules_verified=len(selected),root_coverage=False,snapshot_not_live_status=True)
 folder=reports/'partial_progress';folder.mkdir(exist_ok=True);snapshotfile=folder/args.report;snapshotfile.write_text(json.dumps(snapshot,indent=2))
 group={'prefix':prefix,'library':parent['library'],'results':selected,'dependencies':dependencies,'parent_progress_snapshot':snapshotfile.relative_to(reports).as_posix(),'root_coverage':False}
 data['groups']=[g for g in data['groups'] if g['prefix']!=prefix]+[group];data['scope']='Completed data consistency lemmas only. No chart root or subtree coverage follows from this prefix.'
 output.write_text(json.dumps(data,indent=2))
 if args.register:
  config=lean/'lakefile.toml';text=config.read_text(encoding='utf-8');name=prefix+'VerifiedDataPrefix';block='[[lean_lib]]\nname = "'+name+'"\nroots = '+json.dumps([e['module'] for e in selected])+'\n'
  pattern=r'(?ms)^\[\[lean_lib\]\]\s*\nname = "'+name+r'".*?(?=^\[\[lean_lib\]\]|\Z)';text=re.sub(pattern,lambda _:block+'\n',text) if re.search(pattern,text) else text.rstrip()+'\n\n'+block
  config.write_text(text.rstrip()+'\n',encoding='utf-8')
 print(data['status'],prefix,len(selected),'data modules; root coverage remains unproved')

if __name__=='__main__':main()
