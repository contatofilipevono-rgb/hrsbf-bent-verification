"""Funnel of the 1176 (Pf4) homogeneous polars split by case (u30,u40,u42), and the parameter keys of the survivors.
Usage: python -I funil_casos.py"""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
M = json.load(open(os.path.join(here, "mapa_filtros.json")))
tab = json.load(open(os.path.join(here, "oito_tabela.json")))
homog = json.load(open(os.path.join(here, "homog1176.json")))
CASE = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}
fun = collections.defaultdict(collections.Counter)
keys = collections.defaultdict(collections.Counter)
for c in homog:
    k = params(c)
    case = CASE.get(k[:3], "outro" + "".join(map(str, k[:3])))
    ok8 = tab["".join(map(str, k))][0]
    ev, _ = even_ok(polar_of(t_from_coords(c)))
    ab = "ab=%d%d" % k[3:5]
    fun[case + " " + ab]["pf4"] += 1
    fun[case + " " + ab]["pf4&8"] += ok8
    fun[case + " " + ab]["pf4&par"] += ev
    fun[case]["pf4"] += 1
    fun[case]["pf4&8"] += ok8
    fun[case]["pf4&par"] += ev
    fun[case]["pf4&8&par"] += ok8 and ev
    if ok8 and ev:
        keys[case][k[3:]] += 1
for case in sorted(fun):
    print(case, dict(fun[case]))
for case in sorted(keys):
    print(case, "survivor keys (alpha,beta,x1,x2,y1,y2,w1,w2):", dict(keys[case]))
