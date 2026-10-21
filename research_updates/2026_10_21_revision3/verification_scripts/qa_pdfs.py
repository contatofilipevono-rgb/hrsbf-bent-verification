from pathlib import Path
import json,hashlib,shutil
from pypdf import PdfReader
import pypdfium2 as pdfium
from PIL import Image,ImageDraw
out=Path('outputs/H12_revisao3');qa=out/'qa';qa.mkdir(exist_ok=True);reports=[]
shutil.copyfile(out/'main.pdf',out/'H12_quartic_revised_round3.pdf')
expected=['https://doi.org/10.1016/0097-3165(76)90024-8','https://doi.org/10.1016/S0166-218X(99)00234-6','https://doi.org/10.1007/978-3-540-25937-4_11']
for label,p in [('reading',out/'main.pdf'),('dcc',out/'dcc_template/main.pdf')]:
 r=PdfReader(p);s='\n'.join(page.extract_text() or '' for page in r.pages);log=p.with_suffix('.log').read_text(errors='replace')
 assert 'Missing character:' not in log and 'Overfull \\hbox' not in log and 'Overfull \\vbox' not in log
 assert '\ufffd' not in s
 for text in ['This work received no funding.','The author declares no competing interests.','164,288','States and Declarations' if False else 'Statements and Declarations']:
  assert text in s,(label,text)
 uris=[]
 for page in r.pages:
  for a in page.get('/Annots',[]):
   action=a.get_object().get('/A',{})
   if action.get('/URI'):uris.append(str(action['/URI']))
 assert all(u in uris for u in expected),(label,[u for u in expected if u not in uris])
 if label=='dcc':
  assert 'undefined' not in log.lower()
  tex=p.with_suffix('.tex').read_text();assert '\\section*{1 ' not in tex and '\\section{Introduction}\\label{sec:1}' in tex
  assert '\\begin{thebibliography}{11}' in tex and '\\bmhead{Author contributions}' in tex
 doc=pdfium.PdfDocument(p);thumbs=[]
 for i in range(len(doc)):
  im=doc[i].render(scale=1.2).to_pil().convert('RGB');im.save(qa/f'{label}_{i+1:02d}.png');im.thumbnail((260,370));thumbs.append(im)
 sheet=Image.new('RGB',(1120,((len(thumbs)+3)//4)*400),'#cccccc');d=ImageDraw.Draw(sheet)
 for i,im in enumerate(thumbs):
  x=(i%4)*280+10;y=(i//4)*400+20;sheet.paste(im,(x,y));d.text((x,y-15),f'{label} page{i+1}',fill='black')
 sheet.save(qa/f'{label}_contact.png')
 reports.append({'file':p.relative_to(out).as_posix(),'pages':len(r.pages),'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'overfull_boxes':0,'missing_glyphs':0,'doi_links_checked':expected,'visual_inspection':'awaiting contact sheets and changed pages'})
 print(label,len(r.pages),'declarations pages',[i+1 for i,page in enumerate(r.pages) if 'This work received no funding.' in (page.extract_text() or '')],'map pages',[i+1 for i,page in enumerate(r.pages) if 'Formal counterpart' in (page.extract_text() or '')])
(out/'FINAL_ROUND3_CHECKS.json').write_text(json.dumps({'status':'PASS_TEXT_LAYOUT_LINK_AND_TEMPLATE_CHECKS','abstract_words':180,'pdfs':reports,'formal_sources_changed':False,'lean_rebuilt':False},indent=2)+'\n',encoding='utf-8')
