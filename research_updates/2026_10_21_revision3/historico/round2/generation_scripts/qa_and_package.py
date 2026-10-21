from pathlib import Path
import json,shutil,re,zipfile,hashlib,subprocess,sys
from pypdf import PdfReader
import pypdfium2 as pdfium
from PIL import Image,ImageDraw
root=Path(__file__).resolve().parent
out=root.parents[1]/'outputs/H12_revisao2';old=root.parents[1]/'outputs/H12_preprint'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
qa=out/'qa';qa.mkdir(exist_ok=True)
pdfreports=[]
for label,p in [('reading',out/'main.pdf'),('dcc',out/'dcc_template/main.pdf')]:
 r=PdfReader(p);s='\n'.join(page.extract_text() or '' for page in r.pages)
 for needle in ['quarticFunction','BentAC','walsh','142,802','142,930','64,343','Claude']:
  assert needle in s,(label,needle)
 assert '\ufffd' not in s,(label,'replacement glyph')
 log=p.with_suffix('.log').read_text(errors='replace')
 assert 'Missing character:' not in log
 assert 'Overfull \\hbox' not in log and 'Overfull \\vbox' not in log
 doc=pdfium.PdfDocument(p);thumbs=[]
 for i in range(len(doc)):
  im=doc[i].render(scale=1.2).to_pil().convert('RGB')
  im.save(qa/f'{label}_{i+1:02d}.png')
  im.thumbnail((260,370));thumbs.append(im)
 sheet=Image.new('RGB',(4*280,((len(thumbs)+3)//4)*400),'#cccccc');d=ImageDraw.Draw(sheet)
 for i,im in enumerate(thumbs):
  x=(i%4)*280+10;y=(i//4)*400+20;sheet.paste(im,(x,y));d.text((x,y-15),f'{label} page {i+1}',fill='black')
 sheet.save(qa/f'{label}_contact.png')
 pdfreports.append({'file':str(p.relative_to(out)),'pages':len(r.pages),'missing_glyph_warnings':0,'overfull_box_warnings':0,'sha256':sha(p),'visual_inspection':'rendered; awaiting model inspection'})
shutil.copyfile(out/'main.pdf',out/'H12_quartic_revised_round2.pdf')
hist=out/'historico';hist.mkdir(exist_ok=True)
for n in ['H12_quartic_preprint_v1.pdf','H12_preprint.md','H12_MATERIAIS_SUBMISSAO_PARA_REVISAO.zip']:
 shutil.copyfile(old/n,hist/n)
received=out/'parecer_recebido';received.mkdir(exist_ok=True)
for p in (root.parents[1]/'work/adversarial_received_2026_10_21').iterdir():
 if p.is_file():shutil.copyfile(p,received/p.name)
v1=out/'V1_referencia';v1.mkdir(exist_ok=True)
shutil.copyfile(root/'V1_PUBLIC_VERSION2.pdf',v1/'HRSBF_v2.pdf')
(v1/'README.md').write_text('Public V1 version 2, DOI https://doi.org/10.6084/m9.figshare.34165260.v2; original public PDF https://ndownloader.figshare.com/files/70190304. Included for the requested full comparison. SHA256 '+sha(v1/'HRSBF_v2.pdf')+'. No changes to V1 were made.\n',encoding='utf-8')
# Mathematical payloads remain byte-identical; no certificate is regenerated here.
for n in ['H12_formal_sources.zip','H12_independent_verification.zip','H12_final_kernel_records.zip','LITERATURE_OVERLAP_AUDIT.json']:
 shutil.copyfile(old/n,out/n);assert sha(out/n)==sha(old/n)
(out/'dcc_template/README.md').write_text('''# Springer layout draft — round 2

Uses the official Springer Nature article template package linked from the DCC author guidelines (December 2024 package), with its original sn-jnl.cls and numerical bibliography style. Source: https://www.springernature.com/gp/authors/campaigns/latex-author-support

The main.tex source uses the pdflatex class option and standard LaTeX constructs; displayed Unicode Lean symbols are rendered through math escapes while the exact Unicode source is preserved in the Markdown supplement. Both PDFs were compiled with Tectonic (XeTeX-based). A separate pdfLaTeX build and the journal portal converter were not executed. This is a layout draft for review, with author declarations still to be finalized. It is not a claim of complete portal compliance or an actual submission.
''',encoding='utf-8')
scripts=out/'verification_scripts';scripts.mkdir(exist_ok=True)
for p in root.glob('*.py'):
 if p.name!='fetch_primary.py':shutil.copyfile(p,scripts/p.name)
shutil.copyfile(out/'audit_article_transcription.py',scripts/'audit_article_transcription.py')
# Run the report's finite checking script only after its full source was inspected.
p=subprocess.run([sys.executable,'-I','-X','utf8',str(received/'check_h12.py')],capture_output=True,text=True)
assert p.returncode==0 and 'False' not in p.stdout
(out/'RECEIVED_CHECK_REPLAY.txt').write_text(p.stdout+'\nThis is a finite consistency check, not a Lean rebuild.\n',encoding='utf-8')
checks={'status':'PASS_ROUND2_STRUCTURAL_AND_PDF_CHECKS','abstract_words':169,'pdfs':pdfreports,'formal_source_zip_unchanged':sha(out/'H12_formal_sources.zip')==sha(old/'H12_formal_sources.zip'),'independent_certificate_zip_unchanged':sha(out/'H12_independent_verification.zip')==sha(old/'H12_independent_verification.zip'),'original_numbered_equation_tags_retained':True,'received_finite_script_passed':True,'lean_rebuilt':False,'journal_submitted':False,'figshare_updated_to_this_revision':False}
(out/'FINAL_ROUND2_CHECKS.json').write_text(json.dumps(checks,indent=2)+'\n',encoding='utf-8')
print(json.dumps(checks,indent=2))
