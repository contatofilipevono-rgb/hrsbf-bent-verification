"""Preserve the supplied review; apply explicit corrections and typeset with amsart."""
from pathlib import Path
import hashlib, json, re

HERE=Path(__file__).resolve().parent
source=(HERE/'ORIGINAL_RECEBIDO.md').read_text(encoding='utf-8')
assert hashlib.sha256((HERE/'ORIGINAL_RECEBIDO.md').read_bytes()).hexdigest()=='54559e5debd0612d8e30d110e36afad42ae942d476351cda56b183aebeb56ba6'
text=source
changes=[]
def replace(old,new,reason):
    global text
    assert text.count(old)==1,(old[:90],text.count(old))
    text=text.replace(old,new)
    changes.append(dict(reason=reason,before=old,after=new))

replace('More precisely, if $n$ is even and $f$', 'More precisely, if $n>0$ is even and $f$', 'Make positivity explicit in the abstract, matching the theorem.')
replace('Bent functions are those at maximal distance from the affine functions; they were introduced by Rothaus [6] and are central to the design of stream and block ciphers.', 'Bent functions, introduced by Rothaus [6], attain the largest possible nonlinearity in even dimension, where nonlinearity is the minimum Hamming distance to an affine Boolean function.', 'State the precise nonlinearity property without an unsupported direct implementation claim.')
replace('Such functions have short descriptions (about $2^n/n$ free values), which makes them attractive both for search and for implementation, and rotation symmetric bent functions (RSBFs) have been studied extensively.', 'Their truth tables are constant on cyclic orbits, which reduces the number of independent values and is useful in computational searches. Rotation symmetric bent functions (RSBFs) have been studied extensively.', 'Avoid an unnecessary unproved asymptotic count in the introduction.')
replace('Partial results are due to Meng, Chen and Fu [2], Zhang and Gao [3], Cusick and Sanger [4] and Sun, Shi, Liu and Fu [5]; they treat, among other things, particular families of dimensions such as $n=2p$.', 'Earlier work includes Meng, Chen and Fu [2], Zhang and Gao [3], Cusick and Sanger [4], and Sun, Shi, Liu and Fu [5]. In particular, the homogeneous cubic case in dimensions $n=2p$, with $p>2$ prime, follows from [4, Theorem 3.8]. The present statement covers every positive even dimension and allows lower-degree terms. Cusick and Sanger also point out that Theorem 3.1 of [3] is false; that criterion is not used here.', 'Identify a previously known cubic family and disclose the correction to a cited historical criterion.')
replace('it is sharp in the sense of Section 5:', 'its hypotheses are nonvacuous, as Section 5 shows:', 'Existence witnesses prove nonvacuity, not an unspecified optimality claim.')
replace('a quadratic is balanced exactly when it is non-zero on its radical', 'a quadratic is balanced exactly when its normalisation $q+q(0)$ is non-zero on the radical of its polar', 'Restore the essential normalization in the strategy paragraph.')
replace('the subspace of $x$ with period $2^s$', 'the subspace of vectors fixed by rotation through $2^s$ coordinates', 'Avoid confusing a period with the least rotational period.')
replace('A derivative lowers the degree by at least one, so the iterated derivatives in (a) and (b) are constant, which gives independence of $x$;', 'A derivative lowers the degree by at least one. Thus $D_aD_bq$ and $D_aD_bD_cg$ are constant, giving the asserted independence of the base point;', 'Identify precisely which iterated derivatives are constant; the second derivative of a cubic need not be constant.')
replace('The only place where the cyclic structure of the dimension is used is a power-of-two identity $(S+I)^{2^s}=S^{2^s}+I$ in characteristic two.', 'The power-of-two assumption enters the quadratic rigidity argument through nilpotence of $\\rho+I$. Cyclic invariance is also used in the fixed-space coordinates, half-turn cancellation and fibre covariance.', 'Separate the power-of-two restriction from the other indispensable uses of cyclic symmetry.')
replace('**Sharpness (non-vacuity).**', '**Nonvacuity.**', 'Use the exact property established by the witnesses.')
replace('discusses sharpness and scope', 'discusses nonvacuity and scope', 'Keep the organization paragraph consistent with the exact role of the example.')
replace('and affine terms only permute Walsh values. So the antipodal coefficient cannot be dropped from the conclusion, and Theorem 1 is a *necessity* result, not a classification of bent cubics.', 'and affine additions permute Walsh frequencies and may reverse signs. Thus the hypotheses of Theorem 1 are attained, including invariant affine terms. The theorem gives a *necessary* coefficient condition, not a classification of bent cubics.', 'Constants reverse Walsh signs; state the correct role of the example.')
replace('has period $h$ and $h\\mid n/2=hm$', 'has period dividing $h$ and $h\\mid n/2=hm$', 'Repeated vectors may have smaller least period, including zero and all ones.')
replace('and it is sharp in the sense of Section 5', 'and its hypotheses are nonvacuous in the sense of Section 5', 'Normalize wording') if 'and it is sharp in the sense of Section 5' in text else None
replace('The latter has *not* been separately formalized; it is elementary and is checked by hand in this paper.', 'The latter has *not* been separately formalized; its complete mathematical argument is given in Lemma 3.2.', 'Describe the evidence without treating an author check as certification.')

(HERE/'ARTIGO_REVISADO_AUDITADO.md').write_bytes(text.encode('utf-8'))
(HERE/'ALTERACOES_EXATAS.json').write_bytes((json.dumps(changes,ensure_ascii=False,indent=2)+'\n').encode('utf-8'))

title=text.splitlines()[0][2:]
abstract=text.split('## Abstract\n\n',1)[1].split('\n\n---',1)[0]
body=text.split('## 1. Introduction',1)[1].split('\n## References',1)[0]
body='## 1. Introduction'+body
body=body.replace('[4, Theorem 3.8]',r'\cite[Theorem~3.8]{ref4}')
body=re.sub(r'\[([1-6])\]',lambda m:r'\cite{ref'+m.group(1)+'}',body)
body=body.replace('$S+I$',r'$\rho+I$')

def inline(s):
    # Preserve math verbatim while converting Markdown outside math.
    tokens={}
    def keep(m):
        key=f'ZZMATH{len(tokens)}ZZ';tokens[key]=m.group(0);return key
    s=re.sub(r'\$[^$]*\$',keep,s)
    s=re.sub(r'`([^`]+)`',lambda m:r'\nolinkurl{'+m.group(1)+'}',s)
    s=re.sub(r'\*\*([^*]+)\*\*',lambda m:r'\textbf{'+m.group(1)+'}',s)
    s=re.sub(r'\*([^*]+)\*',lambda m:r'\emph{'+m.group(1)+'}',s)
    for key,value in tokens.items(): s=s.replace(key,value)
    return s

out=[];theorem=False;proof=False;table=[]
def end_table():
    if not table:return
    rows=[x for x in table if not re.match(r'^\|[\s|:-]+\|$',x)]
    out.append(r'\begin{center}\small\begin{tabular}{@{}>{\raggedright\arraybackslash}p{0.29\textwidth}>{\raggedright\arraybackslash}p{0.65\textwidth}@{}}\toprule')
    for i,row in enumerate(rows):
        cells=[inline(x.strip()) for x in row.strip('|').split('|')]
        assert len(cells)==2,cells
        out.append(' & '.join(cells)+r' \\'+(r'\midrule' if i==0 else ''))
    out.append(r'\bottomrule\end{tabular}\end{center}')
    table.clear()

for line in body.splitlines():
    if line.startswith('|'):
        table.append(line);continue
    end_table()
    if line.strip()=='---':continue
    match=re.match(r'^## \d+\. (.+)$',line)
    if match:out.append(r'\section{'+inline(match.group(1))+'}');continue
    match=re.match(r'^### \d+\.\d+ (.+)$',line)
    if match:out.append(r'\subsection{'+inline(match.group(1))+'}');continue
    match=re.match(r'^> \*\*(Theorem|Corollary) [12]\.\*\* (.+)$',line)
    if match:
        env='maintheorem' if match.group(1)=='Theorem' else 'maincorollary'
        out.append(r'\begin{'+env+'}'+inline(match.group(2))+r'\end{'+env+'}');continue
    match=re.match(r'^\*\*(Lemma|Corollary|Proposition) (\d+\.\d+)(?: \((.*?)\))?\.\*\*\s*(.*)$',line)
    if match:
        assert not theorem and not proof
        env=match.group(1).lower();theorem=env
        out.append(r'\begin{'+env+'}'+('['+inline(match.group(3))+']' if match.group(3) else '')+'\n'+inline(match.group(4)));continue
    if line.startswith('*Proof.*') or line.startswith('**Proof of Theorem 1.**'):
        if theorem:out.append(r'\end{'+theorem+'}');theorem=False
        prefix='*Proof.*' if line.startswith('*Proof.*') else '**Proof of Theorem 1.**'
        out.append(r'\begin{proof}'+('[Proof of Theorem 1]' if prefix.startswith('**') else ''))
        proof=True;line=line[len(prefix):].lstrip()
    if line.endswith('$\\square$') or line.endswith('$\\blacksquare$'):
        line=re.sub(r'\$\\(?:square|blacksquare)\$$','',line)
        out.append(inline(line));out.append(r'\end{proof}');proof=False;continue
    out.append(inline(line))
assert not theorem and not proof
tex='\n'.join(out)
tex=re.sub(r'\$\$(.*?)\$\$',lambda m:'\n'+r'\begin{equation*}'+m.group(1)+r'\end{equation*}'+'\n',tex,flags=re.S)
# Break the longest trilinear display at mathematical equalities.
long=r'\Theta\big(d(u),\varepsilon(v),J\big)=\Theta\big(d(u),\varepsilon(v),\varepsilon(\mathbf 1_h)\big)+\Theta\big(d(u),\theta\varepsilon(v),\varepsilon(\mathbf 1_h)\big)=\Theta\big(d(u),d(v),\varepsilon(\mathbf 1_h)\big),'
assert tex.count(long)==1
tex=tex.replace(long,r'\begin{aligned}\Theta\big(d(u),\varepsilon(v),J\big)&=\Theta\big(d(u),\varepsilon(v),\varepsilon(\mathbf 1_h)\big)\\&\quad+\Theta\big(d(u),\theta\varepsilon(v),\varepsilon(\mathbf 1_h)\big)\\&=\Theta\big(d(u),d(v),\varepsilon(\mathbf 1_h)\big),\end{aligned}')

preamble=r'''\documentclass[11pt,reqno]{amsart}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern,amssymb,booktabs,array,hyperref,xurl}
\usepackage[a4paper,margin=27mm]{geometry}
\hypersetup{colorlinks=true,linkcolor=black,citecolor=black,urlcolor=blue}
\emergencystretch=1em
\newtheorem{maintheorem}{Theorem}
\newtheorem{maincorollary}[maintheorem]{Corollary}
\newtheorem{lemma}{Lemma}[section]
\newtheorem{corollary}[lemma]{Corollary}
\newtheorem{proposition}[lemma]{Proposition}
\title[Antipodal necessity through degree three]{TITLE}
\author{Filipe Martins Vono}
\subjclass[2020]{Primary 94D10; Secondary 06E30, 11T71}
\keywords{Bent functions, rotation symmetric Boolean functions, homogeneous Boolean functions, algebraic normal form, quadratic forms in characteristic two}
\date{Editorial revision, October 19, 2026}
\begin{document}
\begin{abstract}
ABSTRACT
\end{abstract}
\maketitle
'''.replace('TITLE',title).replace('ABSTRACT',inline(abstract))
bib=r'''
\begin{thebibliography}{6}
\raggedright
\bibitem{ref1} P.~St\u{a}nic\u{a} and S.~Maitra, Rotation symmetric Boolean functions---count and cryptographic properties, \emph{Discrete Applied Mathematics} \textbf{156} (2008), no.~10, 1567--1580. \href{https://doi.org/10.1016/j.dam.2007.04.029}{doi:10.1016/j.dam.2007.04.029}.
\bibitem{ref2} Q.~Meng, L.~Chen and F.-W.~Fu, On homogeneous rotation symmetric bent functions, \emph{Discrete Applied Mathematics} \textbf{158} (2010), no.~10, 1111--1117. \href{https://doi.org/10.1016/j.dam.2010.02.009}{doi:10.1016/j.dam.2010.02.009}.
\bibitem{ref3} X.~Zhang and G.~Gao, On the conjecture about the nonexistence of rotation symmetric bent functions, preprint (2013), \href{https://arxiv.org/abs/1303.2282}{arXiv:1303.2282}.
\bibitem{ref4} T.~W.~Cusick and E.~M.~Sanger, Rotation symmetric bent Boolean functions for $n=2p$, preprint (2017), \href{https://arxiv.org/abs/1708.09313}{arXiv:1708.09313}.
\bibitem{ref5} L.~Sun, Z.~Shi, J.~Liu and F.-W.~Fu, On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions, \emph{Designs, Codes and Cryptography} \textbf{94} (2026), no.~4, article~93. \href{https://doi.org/10.1007/s10623-026-01848-4}{doi:10.1007/s10623-026-01848-4}.
\bibitem{ref6} O.~S.~Rothaus, On ``bent'' functions, \emph{Journal of Combinatorial Theory, Series A} \textbf{20} (1976), no.~3, 300--305. \href{https://doi.org/10.1016/0097-3165(76)90024-8}{doi:10.1016/0097-3165(76)90024-8}.
\end{thebibliography}
\end{document}
'''
source = (preamble+tex+bib).replace('Stănică',r'St\u{a}nic\u{a}')
(HERE/'paper/ARTIGO_REVISADO.tex').write_bytes(('\n'.join(line.rstrip() for line in source.splitlines())+'\n').encode('utf-8'))
print('Applied',len(changes),'explicit corrections; generated standalone amsart source.')
