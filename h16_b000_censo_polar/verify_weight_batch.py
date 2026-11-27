"""Windows-safe, multiprocessing batch verifier for H16 B0_00 polar survivors.

Runs the exact same verification as levantar.py + conferir.py:
  1. Direct Pfaffian + Möbius check (verify_pfaffians)
  2. Joint 8192-element quotient scan for 6 local balance targets + 2 residues (scan_short)
  3. Exact 35-diagonal-autocorrelation exclusion for ALL 2^56 lifts via precheck
     (parity propagation + sum bounds) and impossible_fiber, with 0 Z3 calls required.
     If any case is NOT excluded by precheck/impossible_fiber, it is flagged as
     'unresolved_needs_solver' instead of crashing on libz3.so.4.
"""
import argparse
import json
import os
import sys
import time
import types
from collections import Counter
from ctypes import c_uint, c_void_p
from multiprocessing import Pool
from pathlib import Path

def _resolve_base():
    here = Path(__file__).resolve().parent
    for cand in (here, here.parent, Path.cwd()):
        if (cand / "entrada.json").is_file() and (cand / "conferir.py").is_file():
            return cand
    raise FileNotFoundError("Could not locate entrada.json and conferir.py")


BASE = _resolve_base()
_HAS_REAL_Z3 = False


def _ensure_z3_or_mock():
    global _HAS_REAL_Z3
    if "z3_fallback" in sys.modules:
        return
    try:
        import z3_fallback  # noqa: F401
        _HAS_REAL_Z3 = True
        return
    except OSError:
        _HAS_REAL_Z3 = False
    z3_mock = types.ModuleType("z3_fallback")
    z3_mock.P = c_void_p
    z3_mock.c_uint = c_uint

    def _mock_api(name, restype, *argtypes):
        def _forbidden(*args, **kwargs):
            raise RuntimeError(f"Z3 API {name} invoked")
        return _forbidden

    class _ForbiddenSolver:
        def __init__(self):
            raise RuntimeError("Z3 Solver() invoked")

    z3_mock.api = _mock_api
    z3_mock.Solver = _ForbiddenSolver
    z3_mock.assertion = _mock_api("solver_assert", None)
    z3_mock.ctx_delete = _mock_api("del_context", None)
    sys.modules["z3_fallback"] = z3_mock


# Worker globals
_TABLES = None
_DOMAIN = None
_CONFERIR = None
_LEVANTAR = None


def _init_worker(base_str, skip_scan_short):
    global _TABLES, _DOMAIN, _CONFERIR, _LEVANTAR
    if base_str not in sys.path:
        sys.path.insert(0, base_str)
    _ensure_z3_or_mock()
    import conferir
    import levantar
    _CONFERIR = conferir
    _LEVANTAR = levantar
    data = json.loads((Path(base_str) / "entrada.json").read_text())
    _TABLES = [[int(v, 16) for v in row] for row in data["tabelas"]]
    _DOMAIN = None if skip_scan_short else levantar.joint_quotient(_TABLES)


def _verify_one(polar_hex):
    polar = int(polar_hex, 16)
    zt, af, signs = _CONFERIR.functions(_TABLES, polar)
    pf_ok = _LEVANTAR.verify_pfaffians(zt)
    assert pf_ok, f"Pfaffian check failed for {hex(polar)}"

    six = None
    signed = None
    if _DOMAIN is not None:
        six, signed = _LEVANTAR.scan_short(zt, _DOMAIN)
        for lift in (v for v in (six, signed) if v is not None):
            assert all((zt[z] ^ _CONFERIR.add(af[z], lift)).bit_count() == 128
                       for z in _LEVANTAR.ZS)
        if signed is not None:
            sign_rows = dict(signs)
            assert all(_CONFERIR.signed_value(sign_rows[t], signed) % mod == 0
                       for t, mod in zip(_LEVANTAR.T, _LEVANTAR.MODS, strict=True))

    # Run exact precheck + impossible_fiber (valid for ALL 2^56 lifts!)
    basis, reduced, failure = _CONFERIR.precheck(signs)
    rank = len(basis)
    model = None
    if failure:
        status = "excluido_" + failure[0]
    else:
        z_imp = _CONFERIR.impossible_fiber(zt, af)
        if z_imp is not None:
            status = "excluido_energia_w0"
            failure = hex(z_imp)
        elif _HAS_REAL_Z3:
            status, rank, failure, model = _CONFERIR.exact_solution(
                signs, 2.0, lambda: _CONFERIR.impossible_fiber(zt, af))
            if model is not None:
                assert _CONFERIR.independent_fwht(zt, af, model, signs) == (0, 65536)
        else:
            status = "unresolved_needs_solver"

    odd = [hex(t) for t, row in signs if sum(row.values()) % 2]
    return {
        "polar": hex(polar),
        "peso": polar.bit_count(),
        "six_ok": six is not None if _DOMAIN is not None else None,
        "signed_ok": signed is not None if _DOMAIN is not None else None,
        "levantamento_curto": hex(signed) if signed is not None else None,
        "posto_afim": rank,
        "falha": failure,
        "status": status,
        "paridades_impares": odd,
        "modelo": None if model is None else hex(model),
    }


def verify_file(source_path, workers=None, skip_scan_short=False, out_path=None):
    t0 = time.perf_counter()
    lines = [l.strip() for l in Path(source_path).read_text().splitlines() if l.strip()]
    n = len(lines)
    if workers is None:
        workers = max(1, min(os.cpu_count() or 1, 8))
    if n < 50:
        workers = 1

    if workers == 1:
        _init_worker(str(BASE), skip_scan_short)
        results = [_verify_one(l) for l in lines]
    else:
        chunksize = max(1, n // (workers * 8))
        with Pool(processes=workers, initializer=_init_worker,
                  initargs=(str(BASE), skip_scan_short)) as pool:
            results = pool.map(_verify_one, lines, chunksize=chunksize)

    elapsed = time.perf_counter() - t0
    counts = Counter()
    by_weight = Counter()
    for r in results:
        counts["total"] += 1
        by_weight[r["peso"]] += 1
        if r["six_ok"]:
            counts["pf_e_seis_conjuntos"] += 1
        if r["signed_ok"]:
            counts["pf_e_seis_e_residuos_conjuntos"] += 1
        counts[r["status"]] += 1
        if not r["paridades_impares"]:
            counts["paridade_inicial_ok"] += 1

    summary = {
        "source": str(source_path),
        "elapsed_sec": round(elapsed, 3),
        "workers": workers,
        "skip_scan_short": skip_scan_short,
        "by_weight": dict(sorted(by_weight.items())),
        "contagens": dict(counts),
        "unresolved": [r["polar"] for r in results if r["status"] == "unresolved_needs_solver"],
    }
    print(json.dumps(summary, indent=2), flush=True)

    if out_path:
        payload = dict(contagens=dict(counts), summary=summary, casos=results)
        Path(out_path).write_text(json.dumps(payload, indent=2) + "\n")
    return summary, results


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("source", help="Path to survivor hex file")
    ap.add_argument("--workers", type=int, default=None)
    ap.add_argument("--skip-scan-short", action="store_true",
                    help="Skip 8192-quotient scan_short (faster; precheck alone proves exclusion for all 2^56 lifts)")
    ap.add_argument("--out", default=None, help="Optional JSON output path")
    args = ap.parse_args()
    verify_file(args.source, workers=args.workers,
                skip_scan_short=args.skip_scan_short, out_path=args.out)


if __name__ == "__main__":
    main()
