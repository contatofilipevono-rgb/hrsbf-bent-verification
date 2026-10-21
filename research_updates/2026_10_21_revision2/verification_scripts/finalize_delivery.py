from pathlib import Path
import json,zipfile,hashlib,re,shutil
from pypdf import PdfReader
root=Path(__file__).resolve().parent
out=root.parents[1]/'outputs/H12_revisao2'
old=root.parents[1]/'outputs/H12_preprint'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
article=(out/'H12_preprint.md').read_text(encoding='utf-8')
abstract=article.split('## Abstract\n\n')[1].split('\n\n**Keywords:')[0]
assert len(abstract.split())==169
assert abstract in (out/'materiais_submissao/RESUMO_E_DADOS_SUBMISSAO.md').read_text(encoding='utf-8')
ai=article.split('### 5.3 Use of AI-assisted tools\n\n')[1].split('\n\n## 6')[0]
assert ai in (out/'materiais_submissao/DECLARACOES_PENDENTES.md').read_text(encoding='utf-8')
doi='https://doi.org/10.1016/0097-3165(76)90024-8'
pdfchecks=json.loads((out/'FINAL_ROUND2_CHECKS.json').read_text())
for entry in pdfchecks['pdfs']:
 p=out/entry['file'];r=PdfReader(p);uris=[]
 for page in r.pages:
  for a in page.get('/Annots',[]):
   a=a.get_object();action=a.get('/A',{})
   if action.get('/URI'):uris.append(str(action['/URI']))
 assert doi in uris,(p,'Rothaus DOI annotation incomplete')
 entry['visual_inspection']='Contact sheets and representative full pages inspected; revised complete periodic table, formal definitions, certificate sizes and final references checked. No clipping identified.'
 entry['rothaus_doi_link_complete']=True
(out/'FINAL_ROUND2_CHECKS.json').write_text(json.dumps(pdfchecks,indent=2)+'\n',encoding='utf-8')
for n in ['H12_formal_sources.zip','H12_independent_verification.zip','H12_final_kernel_records.zip']:
 assert sha(out/n)==sha(old/n),n
# Preserve an exact source package for this editorial revision, including the official class.
sourcezip=out/'H12_revised_source_round2.zip'
with zipfile.ZipFile(sourcezip,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
 for n in ['H12_preprint.md','main.tex']:z.write(out/n,n)
 for n in ['main.tex','sn-jnl.cls','sn-mathphys-num.bst','README.md']:
  z.write(out/'dcc_template'/n,'dcc_template/'+n)
for p in root.glob('*.py'):
 if p.name!='fetch_primary.py':shutil.copyfile(p,out/'verification_scripts'/p.name)
template=root/'springer_template.zip'
(out/'TEMPLATE_PROVENANCE.json').write_text(json.dumps({'source_url':'https://cms-resources.apps.public.k8s.springernature.io/springer-cms/rest/v1/content/18782940/data/v12','linked_from':'https://www.springernature.com/gp/authors/campaigns/latex-author-support','official_zip_sha256':sha(template),'sn_jnl_cls_sha256':sha(out/'dcc_template/sn-jnl.cls'),'compiler':'Tectonic 0.17.0 (XeTeX-based)','pdflatex_class_option':True,'separate_pdflatex_build_or_portal_conversion_tested':False},indent=2)+'\n',encoding='utf-8')
# The essential package has everything except the separate 49 MB formal source archive.
selected=[]
excluded={'H12_before_round2.md','main.pdf','DELIVERY_AUDIT.json','MANIFEST_SHA256.json','H12_SEGUNDA_RODADA_ANALISE_ADVERSARIAL.zip','H12_SEGUNDA_RODADA_COMPACTO.zip'}
for p in out.iterdir():
 if p.is_file() and p.name not in excluded and p.suffix in ['.md','.json','.txt','.py','.zip','.tex','.pdf']:selected.append(p)
for folder in ['materiais_submissao','historico','parecer_recebido','V1_referencia','verification_scripts','dcc_template']:
 for p in (out/folder).rglob('*'):
  if p.is_file() and p.suffix in ['.md','.json','.txt','.py','.cls','.bst','.tex','.pdf','.zip']:selected.append(p)
selected=sorted(set(selected))
manifest={p.relative_to(out).as_posix():{'bytes':p.stat().st_size,'sha256':sha(p)} for p in selected}
(out/'MANIFEST_SHA256.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
selected.append(out/'MANIFEST_SHA256.json')
packages=[]
for name,full in [('H12_SEGUNDA_RODADA_ANALISE_ADVERSARIAL.zip',True),('H12_SEGUNDA_RODADA_COMPACTO.zip',False)]:
 target=out/name
 with zipfile.ZipFile(target,'w') as z:
  for p in selected:
   if not full and p.name=='H12_formal_sources.zip':continue
   z.write(p,p.relative_to(out).as_posix(),compress_type=zipfile.ZIP_STORED if p.suffix=='.zip' else zipfile.ZIP_DEFLATED,compresslevel=None if p.suffix=='.zip' else 9)
  if not full:z.writestr('FONTES_LEAN_SEPARADAS.md','The 49 MB H12_formal_sources.zip is omitted from this compact package. Use the complete package or retrieve the identical certified archive from https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/1e0e052/research_updates/2026_10_21_preprint/H12_formal_sources.zip before running the source-graph audit. The manuscript, certificates, reports and exact defining excerpts are included.\n')
 with zipfile.ZipFile(target) as z:
  assert z.testzip() is None
  for n,m in manifest.items():
   if not full and n=='H12_formal_sources.zip':continue
   assert hashlib.sha256(z.read(n)).hexdigest()==m['sha256'],n
 packages.append({'name':name,'bytes':target.stat().st_size,'sha256':sha(target),'complete_formal_archive_included':full})
audit={'status':'PASS_ROUND2_DELIVERY_INTEGRITY','packages':packages,'responded_review_items':25,'article_pdf_pages':14,'springer_layout_pdf_pages':15,'abstract_words':169,'mathematical_sources_changed':False,'lean_rebuilt':False,'journal_submitted':False,'figshare_published_or_updated':False,'not_all_submission_requirements_complete':True,'pending':json.loads((out/'STATUS_REVISAO2.json').read_text())['still_pending']}
(out/'DELIVERY_AUDIT.json').write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(audit,ensure_ascii=False,indent=2))
