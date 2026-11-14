"""Whole polar space: (Pf4) top filter x low parts -> (L5) viability -> (L5)+(L3) -> autocorrelation certificates
(odd / mod4 / mod 2^k) -> forced rows.  One record per (L5)-viable polar, with its plane signature.
Usage: python pipeline_todos.py <shard i/n> <out.json>"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from enum_polares_todos import setup
from poisson5 import Bv_table, equacoes, viavel
from piloto_espaco_polar import run_polar
from bitj import load_model
from base12 import pack, forma
from testemunhas12 import BA, BB, coords
from poisson3 import eq3
from poisson3_lista import todos_subespacos3

if __name__ == "__main__":
    si, sm = map(int, sys.argv[1].split("/")); out_path = sys.argv[2]
    Bb, Gb, Gk, topi, lows, codes = setup()
    Bb2, Gb2, Gk2, piv = load_model(); Vs = todos_subespacos3()
    res = []; k = -1; seen = 0
    for code in codes:
        sel0 = [topi[i] for i in range(len(topi)) if code >> i & 1]
        for low in range(1 << len(lows)):
            k += 1
            if k % sm != si:
                continue
            seen += 1
            sel = set(sel0)
            for i in range(len(lows)):
                if low >> i & 1:
                    sel ^= set(lows[i])
            sel = sorted(sel)
            B = np.bitwise_xor.reduce([Bb[j] for j in sel], axis=0) if sel else np.zeros((15, 64), np.uint8)
            G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
            v, rk = viavel(equacoes(Bv_table(B), G0, Gk))
            if not v:
                continue
            t0 = time.time()
            rec = run_polar(B, Bb2, Gb2, Gk2, piv, Vs, pack, Bv_table, equacoes, eq3, forma, coords, BA, BB)
            rec["seconds"] = round(time.time() - t0, 1)
            res.append(rec)
            json.dump({"seen": seen, "records": res}, open(out_path, "w"))
    json.dump({"seen": seen, "records": res, "done": True}, open(out_path, "w"))
    print("shard", si, "seen", seen, "viable", len(res))
