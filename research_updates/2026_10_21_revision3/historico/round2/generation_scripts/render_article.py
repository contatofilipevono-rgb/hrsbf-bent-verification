from pathlib import Path
import re,shutil
root=Path(__file__).resolve().parent
out=root.parents[1]/'outputs/H12_revisao2'
t=(out/'H12_preprint.md').read_text(encoding='utf-8')
# Reuse the ordinary-prose escaping rules of the checked first preparation.
source=(root.parents[1]/'work/prepare_h12_preprint.py').read_text(encoding='utf-8')
ns={'re':re};exec(source[source.index('def inline'):source.index('lines=text.splitlines()')],ns)
inline_base=ns['inline']
def inline(s):
 return inline_base(s).replace('[^v1]',r'\footnote{Related work by the author concerns antipodal necessity in degree at most three and the homogeneous cubic case (preprint, \url{https://doi.org/10.6084/m9.figshare.34165260.v2}). It is not used as a hypothesis here.}')
abstract=t.split('## Abstract\n\n')[1].split('\n\n**Keywords:')[0]
content=t[t.index('## 1 Introduction'):]
lines=content.splitlines();body=[];i=0
while i<len(lines):
 line=lines[i]
 if line.startswith('[^v1]:'):i+=1;continue
 if line.startswith('```'):
  code=[];i+=1
  while i<len(lines) and not lines[i].startswith('```'):code.append(lines[i]);i+=1
  replacements={'∀':r'\ensuremath{\forall}','→':r'\ensuremath{\to}','≠':r'\ensuremath{\ne}','α':r'\ensuremath{\alpha}','¬':r'\ensuremath{\neg}'}
  for j,s in enumerate(code):
   for a,b in replacements.items():s=s.replace(a,b)
   code[j]=s
  body.extend([r'\begin{Verbatim}[fontsize=\scriptsize,breaklines=true,breakanywhere=true,commandchars=\\\{\}]',*code,r'\end{Verbatim}']);i+=1;continue
 if line.startswith(r'\['):
  body.append(line);i+=1
  while i<len(lines):
   body.append(lines[i]);i+=1
   if body[-1].startswith(r'\]'):break
  continue
 if line.startswith('|'):
  rows=[]
  while i<len(lines) and lines[i].startswith('|'):
   cells=[s.strip() for s in lines[i].strip('|').split('|')]
   if not all(re.fullmatch('[-:]+',c) for c in cells): rows.append(cells)
   i+=1
  if rows[0][0]=='Index': spec='lll'
  elif rows[0][0]=='Source': spec='@{}'+''.join(r'>{\raggedright\arraybackslash}p{'+str(w)+r'\linewidth}' for w in [.23,.30,.38])+'@{}'
  elif rows[0][0]=='Code':spec='@{}'+''.join(r'>{\raggedright\arraybackslash}p{'+str(w)+r'\linewidth}' for w in [.06,.17,.13,.15,.11,.17])+'@{}'
  else:spec='@{}'+''.join(r'>{\raggedright\arraybackslash}p{'+str(w)+r'\linewidth}' for w in [.15,.12,.12,.16,.14,.17])+'@{}'
  tableenv='tabular' if rows[0][0]=='Code' else 'longtable'
  body.extend([r'{\footnotesize',r'\setlength{\tabcolsep}{3pt}',r'\begin{center}' if tableenv=='tabular' else '',r'\begin{'+tableenv+'}{'+spec+'}',r'\toprule'])
  for j,row in enumerate(rows):
   body.append(' & '.join(map(inline,row))+r' \\')
   if j==0:body.append(r'\midrule'+(r'\endhead' if tableenv=='longtable' else ''))
  body.extend([r'\bottomrule',r'\end{'+tableenv+'}',r'\end{center}' if tableenv=='tabular' else '',r'}']);continue
 if line.startswith('### '):body.append(r'\subsection*{'+inline(line[4:])+'}')
 elif line.startswith('## '):body.append(r'\section*{'+inline(line[3:])+'}')
 else:body.append(inline(line))
 i+=1
common=r'''\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{amsmath,amssymb,amsthm,booktabs,longtable,array,xurl,hyperref,microtype,fvextra}
\setlength{\emergencystretch}{2em}
\hypersetup{colorlinks=true,linkcolor=black,urlcolor=blue,pdftitle={Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables},pdfauthor={Filipe Martins Vono}}
'''
title='Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables'
header=r'\documentclass[11pt,a4paper]{article}'+'\n'+common+r'''
\usepackage{geometry}
\geometry{margin=27mm}
\title{'''+title+r'''}
\author{Filipe Martins Vono\\\small Centro Universit\'ario de Belo Horizonte (UniBH), Belo Horizonte, Brazil\\\small ORCID: \href{https://orcid.org/0009-0009-4994-8533}{0009-0009-4994-8533}\\\small\texttt{contatofilipevono@gmail.com}}
\date{Working revision 2 --- 21 October 2026}
\begin{document}
\maketitle
\begin{center}\small Revised for a second adversarial review. Not submitted to a journal.\\Licensed under \href{https://creativecommons.org/licenses/by/4.0/}{CC BY 4.0}.\end{center}
\section*{Abstract}
'''+inline(abstract)+'\n\n'+inline('**Keywords:** Boolean functions; bent functions; rotation symmetry; homogeneous functions; computer-assisted proof; Lean.')+'\n'
def finalize(tex):
 tex=tex.replace(r'\url{https://doi.org/10.1016/0097-3165(76})90024-8',r'\url{https://doi.org/10.1016/0097-3165(76)90024-8}')
 tex=tex.replace(r'[c_i]Q_S=\left\lfloor |v_i|/2\right\rfloor\bmod2,'+'\n'+r'\qquad'+'\n'+r'[c_ic_j]Q_S=(|v_i|\bmod2)(|v_j|\bmod2)+|v_i\cap v_j|\bmod2\quad(i<j).',r'\begin{aligned}\relax[c_i]Q_S&=\left\lfloor |v_i|/2\right\rfloor\bmod2,\\\relax[c_ic_j]Q_S&=(|v_i|\bmod2)(|v_j|\bmod2)+|v_i\cap v_j|\bmod2\quad(i<j).\end{aligned}')
 tex=tex.replace('c_{23}+c_{24}+c_{25}+c_{32}+c_{34}+c_{36}+c_{37}.',r'c_{23}+c_{24}+c_{25}\\&\quad+c_{32}+c_{34}+c_{36}+c_{37}.')
 tex=tex.replace(r'\gamma=\sum_{j\in J}c_j,\quad'+'\n'+r'J=\{1,2,3,5,6,7,8,9,11,12,13,16,17,20,21,22,25,27,28,29,30,32,34,36,38,39,41\}.',r'\begin{aligned}\gamma&=\sum_{j\in J}c_j,\\J&=\{1,2,3,5,6,7,8,9,11,12,13,16,17,20,21,22,\\&\qquad25,27,28,29,30,32,34,36,38,39,41\}.\end{aligned}')
 tex=tex.replace('$\\mathbb F_2[c_0,\\ldots,c_{42}]/(c_i^2+c_i)$, each','\\[\\mathbb F_2[c_0,\\ldots,c_{42}]/(c_i^2+c_i),\\]\neach')
 return tex.replace('ă',r'\u{a}').replace('–','--').replace('—','---').replace('“','``').replace('”',"''")+'\n\\end{document}\n'
reading_body='\n'.join(body).replace(r'\section*{References}',r'\clearpage'+'\n'+r'\section*{References}')
(out/'main.tex').write_text(finalize(header+reading_body),encoding='utf-8')
dcc=out/'dcc_template';dcc.mkdir(exist_ok=True)
shutil.copyfile(root/'template/sn-jnl.cls',dcc/'sn-jnl.cls')
shutil.copyfile(root/'template/sn-mathphys-num.bst',dcc/'sn-mathphys-num.bst')
sn=r'\documentclass[pdflatex,sn-mathphys-num]{sn-jnl}'+'\n'+common+r'''
\raggedbottom
\begin{document}
\title{'''+title+r'''}
\author*[1]{\fnm{Filipe Martins} \sur{Vono}}\email{contatofilipevono@gmail.com}
\affil*[1]{\orgname{Centro Universit\'ario de Belo Horizonte (UniBH)},\orgaddress{\city{Belo Horizonte},\country{Brazil}}}
\abstract{'''+inline(abstract)+r'''}
\keywords{Boolean functions, bent functions, rotation symmetry, homogeneous functions, computer-assisted proof, Lean}
\maketitle
\noindent\textit{Layout draft for adversarial review, 21 October 2026. Author declarations remain to be finalized before submission.}\\
\noindent ORCID: \url{https://orcid.org/0009-0009-4994-8533}
'''
dcc_body='\n'.join(body).replace('For $a,u\\in V$, define the Walsh transform',r'\enlargethispage{2pt}'+'\n'+'For $a,u\\in V$, define the Walsh transform')
(dcc/'main.tex').write_text(finalize(sn+dcc_body),encoding='utf-8')
print('TEX_READY',out/'main.tex',dcc/'main.tex')
