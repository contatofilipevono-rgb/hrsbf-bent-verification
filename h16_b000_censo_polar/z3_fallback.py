"""Interface booleana mínima para a biblioteca de sistema libz3."""
from ctypes import CDLL, POINTER, byref, c_char_p, c_int, c_uint, c_void_p

lib=CDLL("libz3.so.4")
P=c_void_p

def api(name, restype, *argtypes):
    fn=getattr(lib,"Z3_"+name)
    fn.restype,fn.argtypes=restype,argtypes
    return fn

cfg=api("mk_config",P)
ctx=api("mk_context",P,P)
ctx_delete=api("del_context",None,P)
cfg_delete=api("del_config",None,P)
symbol=api("mk_string_symbol",P,P,c_char_p)
int_symbol=api("mk_int_symbol",P,P,c_int)
bool_sort=api("mk_bool_sort",P,P)
constant=api("mk_const",P,P,P,P)
neg=api("mk_not",P,P,P)
disjunction=api("mk_or",P,P,c_uint,POINTER(P))
xor=api("mk_xor",P,P,P,P)
false=api("mk_false",P,P)
tactic=api("mk_tactic",P,P,c_char_p)
tactic_ref=api("tactic_inc_ref",None,P,P)
mk_solver=api("mk_solver_from_tactic",P,P,P)
solver_ref=api("solver_inc_ref",None,P,P)
assertion=api("solver_assert",None,P,P,P)
params=api("mk_params",P,P)
params_ref=api("params_inc_ref",None,P,P)
params_unref=api("params_dec_ref",None,P,P)
uint_param=api("params_set_uint",None,P,P,P,c_uint)
set_params=api("solver_set_params",None,P,P,P)
check=api("solver_check",c_int,P,P)
get_model=api("solver_get_model",P,P,P)
model_ref=api("model_inc_ref",None,P,P)
model_eval=api("model_eval",c_int,P,P,P,c_int,POINTER(P))
bool_value=api("get_bool_value",c_int,P,P)

class Solver:
    def __init__(self):
        zcfg=cfg()
        self.context=ctx(zcfg)
        cfg_delete(zcfg)
        self.sort=bool_sort(self.context)
        sat=tactic(self.context,b"sat")
        tactic_ref(self.context,sat)
        self.s=mk_solver(self.context,sat)
        solver_ref(self.context,self.s)
        self.values={}
        self.negatives={}

    def ast(self,lit):
        i=abs(lit)
        if i not in self.values:
            self.values[i]=constant(self.context,int_symbol(self.context,i),self.sort)
        base=self.values[i]
        if lit>0:return base
        if i not in self.negatives:
            self.negatives[i]=neg(self.context,base)
        return self.negatives[i]

    def add_clause(self,lits):
        asts=[self.ast(v) for v in lits]
        c=disjunction(self.context,len(asts),(P*len(asts))(*asts)) if asts else false(self.context)
        assertion(self.context,self.s,c)

    def add_xor_clause(self,lits,rhs):
        asts=[self.ast(v) for v in lits]
        while len(asts)>1:
            next_level=[xor(self.context,x,y) for x,y in zip(asts[::2],asts[1::2])]
            if len(asts)%2:next_level.append(asts[-1])
            asts=next_level
        c=asts[0] if rhs else neg(self.context,asts[0])
        assertion(self.context,self.s,c)

    def solve(self,time_limit):
        p=params(self.context)
        params_ref(self.context,p)
        uint_param(self.context,p,symbol(self.context,b"timeout"),int(1000*time_limit))
        set_params(self.context,self.s,p)
        params_unref(self.context,p)
        res=check(self.context,self.s)
        if res != 1:
            return (False if res==-1 else None),None
        m=get_model(self.context,self.s)
        model_ref(self.context,m)
        sol=[None]*(max(self.values)+1)
        for i,a in self.values.items():
            v=P()
            if model_eval(self.context,m,a,1,byref(v)):
                sol[i]=bool_value(self.context,v)==1
        return True,sol
