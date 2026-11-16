"""Readable per-polar table of Fable's level-8 polars (cases A, B, C) with the repo filters."""
import os, json, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
M = json.load(open(os.path.join(here, "mapa_filtros.json")))
with open(os.path.join(here, "polares_nivel8_filtros.tsv"), "w", encoding="utf-8") as fo:
    fo.write("# caso\tpolar(u30 u40 u42 a b c d e g h k m n p r A1 A2 A3 B1 B2 B3)\tfibra_nivel8\tpassa_nivel9\tentre_os_98\t"
             "alpha\tbeta\tpassa_8linhas\tmax_8linhas\tparidade_ok\tprimeiro_filtro_do_repo\n")
    for case in "ABC":
        for r in M["casos"][case]:
            k = params(r["code"])
            fo.write("%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\n" % (
                case, r["code"], r["fibra"], r["nivel9"], r["in98"], k[3], k[4], r["pass8"], r["max8"], r["even"], r["first"]))
both = [(case, r["code"], r["first"]) for case in "BC" for r in M["casos"][case] if r["nivel9"] and r["in98"]]
print("level9 & in98:", both)
