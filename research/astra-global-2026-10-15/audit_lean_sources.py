"""Reject proof shortcuts in the project's Lean sources, ignoring comments/strings."""
from pathlib import Path
import re
root=Path(__file__).resolve().parents[2]/'formalization'
def code_only(s):
    out=[]; i=0; depth=0; string=False
    while i<len(s):
        if depth:
            if s.startswith('/-',i):depth+=1;i+=2
            elif s.startswith('-/',i):depth-=1;i+=2
            else:i+=1
        elif string:
            if s[i]=='\\':i+=2
            elif s[i]=='"':string=False;i+=1
            else:i+=1
        elif s.startswith('/-',i):depth=1;i+=2
        elif s.startswith('--',i):
            k=s.find('\n',i);i=len(s) if k<0 else k
        elif s[i]=='"':string=True;i+=1
        else:out.append(s[i]);i+=1
    assert depth==0 and not string
    return ''.join(out)
files=sorted((root/'Antipodal').glob('*.lean'))+[root/'Antipodal.lean',root/'CheckGlobal.lean']
for p in files:
    code=code_only(p.read_text())
    bad=re.findall(r'\b(?:sorry|admit|axiom|unsafe|native_decide)\b|Lean\.ofReduceBool',code)
    assert not bad,(str(p),bad)
print(f'Checked {len(files)} Lean files: no forbidden proof shortcuts.')
