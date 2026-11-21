#!/usr/bin/env python3
r"""
SOLVE_STEP60A_DEEP_SHATTER_SINGULAR_CMSAT.py

DEEP PURE-ALGEBRAIC FULL-389 SHATTER PROBE FOR B0_11 & B1_11:
  Compares 3 subspace/flag families (all using TRUE dual annihilator U_1^perp):
    1. Step 41A Greedy Max-Untouched-Rows Flag `flag_cms`
    2. Step 57B (KR+V0)-optimized `U_opt`
    3. Exact Greedy Row-Annihilator Intersection `U_rowint` = \bigcap L(u_i) + Direct `L(u_best[0])`
  And attacks EVERY open `s9.run_branch_cascade` shattered residual (e.g. N=57 q=898 c=0,
  N=65 q=475 c=0, where `s9` truncated degree-3 XL at max_rows=16,000!) with FOUR exact engines:
    1. COMPACT UNTRUNCATED C DEGREE-3 XL (`compact_d3_xl_shatter`): remaps active vars to 0..N-1
       and runs UNTRUNCATED degree-3 XL + linear-drop cascade to exact fixpoint or `1 = 0`!
    2. CryptoMiniSat 5 (native arbitrary-length XOR clauses + GF(2) Gauss-Jordan elimination!)
    3. Singular `slimgb` over GF(2)[x]/(x^2+x) (quadratic-only shortcut + full residual!)
    4. CaDiCaL 195 (3-XOR Tseitin CNF)
  100% Zero-Trust audited: startup planted-solution & explicit-UNSAT checks for ALL 4 engines,
  plus live assumption-SAT planted audit on a real H(16,4) shattered residual!
"""

import argparse
import ctypes
import random
import shutil
import subprocess
import sys
import time
from pathlib import Path
import numpy as np
from pysat.solvers import Cadical195

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


_CTBL_CACHE = {}


def _get_ctbl(n_loc):
    if n_loc not in _CTBL_CACHE:
        _CTBL_CACHE[n_loc] = s9.build_col_tables(n_loc)
    return _CTBL_CACHE[n_loc]


def _eval_pset_bits(ps, val_bits):
    acc = 0
    for m in ps:
        if (m & val_bits) == m:
            acc ^= 1
    return acc


def compact_d3_xl_shatter(psets, n_vars, lib9, max_n=74, max_rounds=20):
    """
    UNTRUNCATED Compact N-Variable Degree-3 XL + Linear-Drop Cascade!
    Remaps active variables of `psets` to 0..N-1 so the Macaulay degree-<=3 echelon
    allocates `n_cols + 4` pivot slots — ZERO truncation!
    Returns (status, dt, N_final, q_psets_orig, c_psets_orig).
      status in {"XL3_UNSAT", "XL3_FIXPOINT", "XL3_SKIP_LARGE"}
    """
    t0 = time.perf_counter()
    clean = [ps for ps in psets if ps]
    for ps in clean:
        if ps == {0}:
            return "XL3_UNSAT", time.perf_counter() - t0, 0, [], []
    active_orig = sorted({b for ps in clean for m in ps if m > 0 for b in range(n_vars) if (m >> b) & 1})
    N = len(active_orig)
    if N == 0:
        return "XL3_FIXPOINT", time.perf_counter() - t0, 0, [], []
    if N <= 3:
        # Exact exhaustive check on <= 8 points
        for x in range(1 << N):
            vb = 0
            for i, ov in enumerate(active_orig):
                if (x >> i) & 1:
                    vb |= (1 << ov)
            if all(_eval_pset_bits(ps, vb) == 0 for ps in clean):
                return "XL3_FIXPOINT", time.perf_counter() - t0, N, [p for p in clean if max((m.bit_count() for m in p), default=0) <= 2], [p for p in clean if max((m.bit_count() for m in p), default=0) == 3]
        return "XL3_UNSAT", time.perf_counter() - t0, 0, [], []
    if N > max_n:
        return "XL3_SKIP_LARGE", 0.0, N, [], []

    orig_to_loc = {v: i for i, v in enumerate(active_orig)}
    ctbl = _get_ctbl(N)
    n_cw = ctbl["n_col_words"]
    n_cols = ctbl["n_cols"]
    off2, off1, off0 = ctbl["off2"], ctbl["off1"], ctbl["off0"]
    mask64 = (1 << 64) - 1

    # Remap psets to local 0..N-1 bitmasks
    loc_psets = []
    for ps in clean:
        lps = set()
        for m in ps:
            if m == 0:
                lps.add(0)
            else:
                lm = 0
                tmp = m
                while tmp:
                    lb = tmp & -tmp
                    ov = lb.bit_length() - 1
                    tmp ^= lb
                    lm |= (1 << orig_to_loc[ov])
                lps.symmetric_difference_update({lm})
        if lps:
            loc_psets.append(lps)

    lin_pivs = {}
    cur_count = len(loc_psets)
    work_cap = max(cur_count + 64, 4096)
    work = (ctypes.c_uint64 * (work_cap * n_cw))()
    for i, lps in enumerate(loc_psets):
        s9.pset_to_row(lps, work, i, ctbl)

    ech_cap = n_cols + 4
    ech = (ctypes.c_uint64 * (ech_cap * n_cw))()

    def apply_pivs(buf_arr, n_rows, piv_bits):
        for p in piv_bits:
            pv, pr = lin_pivs[p]
            m = pv ^ (1 << p)
            lib9.subst_one_linear_var_batch(
                buf_arr, n_rows, n_cw, N, off2, off1, off0,
                ctbl["col2_base"], ctbl["col3_base"],
                ctbl["col_deg"], ctbl["col_v0"], ctbl["col_v1"], ctbl["col_v2"],
                p, m & mask64, m >> 64, pr
            )

    def remap_back(lps):
        ops = set()
        for lm in lps:
            if lm == 0:
                ops.add(0)
            else:
                om = 0
                tmp = lm
                while tmp:
                    lb = tmp & -tmp
                    lv = lb.bit_length() - 1
                    tmp ^= lb
                    om |= (1 << active_orig[lv])
                ops.symmetric_difference_update({om})
        return ops

    for rnd in range(1, max_rounds + 1):
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        e_rows = 0
        d1_rows, d2_rows, d3_rows = [], [], []
        for r in range(cur_count):
            dst = ctypes.cast(ctypes.byref(ech, e_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(work, r * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_cw * 8)
            pc = lib9.gf2_echelon_insert_s9(ech, e_rows, n_cw, piv_idx, n_cols)
            if pc < 0:
                continue
            if pc == off0:
                return "XL3_UNSAT", time.perf_counter() - t0, N - len(lin_pivs), [], []
            elif pc >= off1:
                d1_rows.append(e_rows)
            elif pc >= off2:
                d2_rows.append(e_rows)
            else:
                d3_rows.append(e_rows)
            e_rows += 1

        if d1_rows:
            added_bits = []
            for r_id in d1_rows:
                ps = s9.row_to_pset(ech, r_id, ctbl)
                vm = 0
                rhs = 1 if (0 in ps) else 0
                for m in ps:
                    if m != 0:
                        vm |= m
                before = set(lin_pivs.keys())
                ok = s9.add_linear_rref(lin_pivs, vm, rhs)
                if not ok:
                    return "XL3_UNSAT", time.perf_counter() - t0, N - len(lin_pivs), [], []
                for nb in (set(lin_pivs.keys()) - before):
                    added_bits.append(nb)
            keep = d2_rows + d3_rows
            if len(keep) > work_cap:
                work_cap = len(keep) + 1024
                work = (ctypes.c_uint64 * (work_cap * n_cw))()
            for idx, r_id in enumerate(keep):
                ctypes.memmove(
                    ctypes.byref(work, idx * n_cw * 8),
                    ctypes.byref(ech, r_id * n_cw * 8),
                    n_cw * 8
                )
            cur_count = len(keep)
            apply_pivs(work, cur_count, added_bits)
            continue

        # No deg-1 drops: run UNTRUNCATED degree-3 XL on ALL d2_rows + any newly dropped d2_rows!
        active_loc = [i for i in range(N) if i not in lin_pivs]
        xl_new_d1 = []
        q_idx = 0
        while q_idx < len(d2_rows):
            qr = d2_rows[q_idx]
            q_idx += 1
            src_ptr = ctypes.cast(ctypes.byref(ech, qr * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            for vi in active_loc:
                dst_ptr = ctypes.cast(ctypes.byref(ech, e_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                lib9.mul_deg2_row_by_var(
                    src_ptr, dst_ptr, vi, N, off2, off1, off0, n_cw,
                    ctbl["col2_base"], ctbl["col3_base"],
                    ctbl["col_deg"], ctbl["col_v0"], ctbl["col_v1"]
                )
                pc = lib9.gf2_echelon_insert_s9(ech, e_rows, n_cw, piv_idx, n_cols)
                if pc < 0:
                    continue
                if pc == off0:
                    return "XL3_UNSAT", time.perf_counter() - t0, len(active_loc), [], []
                elif pc >= off1:
                    xl_new_d1.append(e_rows)
                    e_rows += 1
                elif pc >= off2:
                    d2_rows.append(e_rows)
                    e_rows += 1
                else:
                    e_rows += 1
            if xl_new_d1:
                break

        if xl_new_d1:
            added_bits = []
            for r_id in xl_new_d1:
                ps = s9.row_to_pset(ech, r_id, ctbl)
                vm = 0
                rhs = 1 if (0 in ps) else 0
                for m in ps:
                    if m != 0:
                        vm |= m
                before = set(lin_pivs.keys())
                ok = s9.add_linear_rref(lin_pivs, vm, rhs)
                if not ok:
                    return "XL3_UNSAT", time.perf_counter() - t0, len(active_loc), [], []
                for nb in (set(lin_pivs.keys()) - before):
                    added_bits.append(nb)
            keep = d2_rows + d3_rows
            if len(keep) > work_cap:
                work_cap = len(keep) + 1024
                work = (ctypes.c_uint64 * (work_cap * n_cw))()
            for idx, r_id in enumerate(keep):
                ctypes.memmove(
                    ctypes.byref(work, idx * n_cw * 8),
                    ctypes.byref(ech, r_id * n_cw * 8),
                    n_cw * 8
                )
            cur_count = len(keep)
            apply_pivs(work, cur_count, added_bits)
            continue

        # Reached TRUE UNTRUNCATED degree-3 XL fixpoint!
        q_out = [remap_back(s9.row_to_pset(ech, r_id, ctbl)) for r_id in d2_rows]
        c_out = [remap_back(s9.row_to_pset(ech, r_id, ctbl)) for r_id in d3_rows]
        return "XL3_FIXPOINT", time.perf_counter() - t0, len(active_loc), q_out, c_out

    # Max rounds reached
    q_out = [remap_back(s9.row_to_pset(work, r, ctbl)) for r in range(cur_count)]
    return "XL3_FIXPOINT", time.perf_counter() - t0, N - len(lin_pivs), q_out, []


def solve_psets_with_cadical(psets, n_vars, max_conf_budget=60000, assumptions_bits=None):
    """Exact Tseitin 3-XOR CNF encoder -> CaDiCaL 195. Verified ANF model on SAT."""
    active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(n_vars) if (m >> b) & 1})
    var_to_sat = {v: i + 1 for i, v in enumerate(active_vars)}
    next_sat_var = len(active_vars) + 1
    mon_to_sat = {}
    clauses = []

    def get_mon_var(m):
        nonlocal next_sat_var
        vs = [b for b in range(n_vars) if (m >> b) & 1]
        if len(vs) == 1:
            return var_to_sat[vs[0]]
        if m not in mon_to_sat:
            mv = next_sat_var
            next_sat_var += 1
            mon_to_sat[m] = mv
            lits = [var_to_sat[v] for v in vs]
            for l in lits:
                clauses.append([-mv, l])
            clauses.append([mv] + [-l for l in lits])
        return mon_to_sat[m]

    def add_xor_clauses(lits, rhs):
        nonlocal next_sat_var
        cur = list(lits)
        cur_rhs = rhs
        while len(cur) > 3:
            a, b = cur[0], cur[1]
            aux = next_sat_var
            next_sat_var += 1
            clauses.append([-a, -b, -aux])
            clauses.append([a, b, -aux])
            clauses.append([a, -b, aux])
            clauses.append([-a, b, aux])
            cur = [aux] + cur[2:]
        k = len(cur)
        for mask in range(1 << k):
            if (mask.bit_count() & 1) != cur_rhs:
                clauses.append([(-cur[i] if ((mask >> i) & 1) else cur[i]) for i in range(k)])

    for ps in psets:
        if not ps:
            continue
        if ps == {0}:
            return "UNSAT_1EQ0", 0.0, None
        rhs = 1 if 0 in ps else 0
        lits = [get_mon_var(m) for m in sorted(ps) if m > 0]
        add_xor_clauses(lits, rhs)

    t0 = time.perf_counter()
    with Cadical195(bootstrap_with=clauses) as slv:
        if assumptions_bits is not None:
            assump = [var_to_sat[v] if ((assumptions_bits >> v) & 1) else -var_to_sat[v] for v in active_vars]
            res = slv.solve(assumptions=assump)
        else:
            slv.conf_budget(max_conf_budget)
            res = slv.solve_limited()
        model = slv.get_model() if res is True else None
    dt = time.perf_counter() - t0
    if res is False:
        return "CAD_UNSAT", dt, None
    elif res is True:
        pos = {lit for lit in model if lit > 0}
        val_bits = 0
        for v, sv in var_to_sat.items():
            if sv in pos:
                val_bits |= (1 << v)
        for ps in psets:
            assert _eval_pset_bits(ps, val_bits) == 0, "CaDiCaL SAT model failed ANF check!"
        return "CAD_SAT", dt, val_bits
    return "CAD_BUDGET", dt, None


def solve_psets_with_cms5(psets, n_vars, max_time=25, tag="cms5", assumptions_bits=None):
    """Exact DIMACS native-XOR CNF encoder -> cryptominisat5 with GF(2) Gauss-Jordan."""
    cms_bin = shutil.which("cryptominisat5")
    if not cms_bin:
        return "NO_CMS5", 0.0, None
    active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(n_vars) if (m >> b) & 1})
    var_to_sat = {v: i + 1 for i, v in enumerate(active_vars)}
    next_sat_var = len(active_vars) + 1
    mon_to_sat = {}
    cnf_clauses = []
    xor_clauses = []

    def get_mon_var(m):
        nonlocal next_sat_var
        vs = [b for b in range(n_vars) if (m >> b) & 1]
        if len(vs) == 1:
            return var_to_sat[vs[0]]
        if m not in mon_to_sat:
            mv = next_sat_var
            next_sat_var += 1
            mon_to_sat[m] = mv
            lits = [var_to_sat[v] for v in vs]
            for l in lits:
                cnf_clauses.append([-mv, l])
            cnf_clauses.append([mv] + [-l for l in lits])
        return mon_to_sat[m]

    for ps in psets:
        if not ps:
            continue
        if ps == {0}:
            return "UNSAT_1EQ0", 0.0, None
        rhs = 1 if 0 in ps else 0
        lits = [get_mon_var(m) for m in sorted(ps) if m > 0]
        if len(lits) == 1:
            cnf_clauses.append([lits[0] if rhs else -lits[0]])
        else:
            xor_clauses.append((lits, rhs))

    if assumptions_bits is not None:
        for v in active_vars:
            sv = var_to_sat[v]
            cnf_clauses.append([sv if ((assumptions_bits >> v) & 1) else -sv])

    n_sat_vars = next_sat_var - 1
    n_total_cl = len(cnf_clauses) + len(xor_clauses)
    lines = [f"p cnf {n_sat_vars} {n_total_cl}\n"]
    for cl in cnf_clauses:
        lines.append(" ".join(map(str, cl)) + " 0\n")
    for lits, rhs in xor_clauses:
        if rhs == 0:
            lines.append("x " + str(-lits[0]) + " " + " ".join(map(str, lits[1:])) + " 0\n")
        else:
            lines.append("x " + " ".join(map(str, lits)) + " 0\n")

    cnf_path = WORK_DIR / f"s60a_{tag}.cnf"
    cnf_path.write_text("".join(lines), encoding="utf-8")
    t0 = time.perf_counter()
    try:
        proc = subprocess.run(
            [cms_bin, "--verb=0", "--threads=4", "--maxmatrixcols=5000", "--maxmatrixrows=5000",
             f"--maxtime={max_time}", str(cnf_path)],
            capture_output=True, text=True, timeout=max_time + 15
        )
        dt = time.perf_counter() - t0
    except subprocess.TimeoutExpired:
        return "CMS_TIMEOUT", time.perf_counter() - t0, None

    if proc.returncode == 20:
        return "CMS_UNSAT", dt, None
    elif proc.returncode == 10:
        pos = set()
        for line in proc.stdout.splitlines():
            if line.startswith("v "):
                for tok in line.split()[1:]:
                    iv = int(tok)
                    if iv > 0:
                        pos.add(iv)
        val_bits = 0
        for v, sv in var_to_sat.items():
            if sv in pos:
                val_bits |= (1 << v)
        for ps in psets:
            assert _eval_pset_bits(ps, val_bits) == 0, "CMS5 SAT model failed ANF check!"
        return "CMS_SAT", dt, val_bits
    return f"CMS_TO({proc.returncode})", dt, None


def solve_psets_with_singular(psets, n_vars, timeout_sec=30, tag="sing", verify_point=None):
    """Run Singular `slimgb` over GF(2) with field equations x_i^2 + x_i = 0."""
    sing_bin = shutil.which("Singular") or shutil.which("singular")
    if not sing_bin:
        return "NO_SING", 0.0, ""
    clean_psets = [ps for ps in psets if ps]
    for ps in clean_psets:
        if ps == {0}:
            return "UNSAT_1EQ0", 0.0, "has1=1"
    active_vars = sorted({b for ps in clean_psets for m in ps if m > 0 for b in range(n_vars) if (m >> b) & 1})
    if not active_vars:
        return "SING_OPEN", 0.0, "empty"

    var_names = [f"v{v}" for v in active_vars]
    poly_strs = []
    for ps in clean_psets:
        terms = []
        for m in sorted(ps):
            if m == 0:
                terms.append("1")
            else:
                vs = [f"v{b}" for b in active_vars if (m >> b) & 1]
                terms.append("*".join(vs))
        poly_strs.append("+".join(terms))

    field_eqs = [f"{vn}^2+{vn}" for vn in var_names]
    all_eqs = poly_strs + field_eqs
    v_decl = ",".join(var_names)

    subst_block = ""
    if verify_point is not None:
        subs = ",".join(f"v{v},{((verify_point >> v) & 1)}" for v in active_vars)
        subst_block = (
            f"int bad_pt = 0;\n"
            f"for (int i = 1; i <= sz; i = i + 1) {{\n"
            f"  if (subst(G[i], {subs}) != 0) {{ bad_pt = bad_pt + 1; }}\n"
            f"}}\n"
            f"printf(\"PT_BAD=%s\", bad_pt);\n"
        )

    script = (
        f"ring r = 2, ({v_decl}), dp;\n"
        f"ideal I = {','.join(all_eqs)};\n"
        f"option(redSB);\n"
        f"ideal G = slimgb(I);\n"
        f"int sz = size(G);\n"
        f"int has1 = (G[1] == 1);\n"
        f"int n_d1 = 0; int n_d2 = 0;\n"
        f"for (int i = 1; i <= sz; i = i + 1) {{\n"
        f"  int d = deg(G[i]);\n"
        f"  if (d == 1) {{ n_d1 = n_d1 + 1; }}\n"
        f"  if (d == 2) {{ n_d2 = n_d2 + 1; }}\n"
        f"}}\n"
        f"printf(\"GB_RES size=%s has1=%s d1=%s d2=%s\\n\", sz, has1, n_d1, n_d2);\n"
        f"{subst_block}"
        f"quit;\n"
    )
    f_in = WORK_DIR / f"s60a_{tag}.sing"
    f_in.write_text(script, encoding="utf-8")
    t0 = time.perf_counter()
    try:
        proc = subprocess.run([sing_bin, "-q", str(f_in)], capture_output=True, text=True, timeout=timeout_sec)
        dt = time.perf_counter() - t0
        out = (proc.stdout + "\n" + proc.stderr).strip()
        if verify_point is not None:
            assert "PT_BAD=0" in out, f"Singular planted-point verification failed! Output:\n{out[-400:]}"
        for line in out.splitlines():
            if "GB_RES" in line:
                if "has1=1" in line:
                    return "SING_UNSAT", dt, line.strip()
                return "SING_OPEN", dt, line.strip()
        return f"SING_RC({proc.returncode})", dt, out[-200:]
    except subprocess.TimeoutExpired:
        return "SING_TO", time.perf_counter() - t0, ""


def audit_all_solvers_zerotrust(rng, lib9):
    """100% Zero-Trust planted-solution & contradiction audit for ALL 4 engines (XL3, CaDiCaL, CMS5, Singular)!"""
    for name, fn in [
        ("CompactXL3", lambda ps, nv: compact_d3_xl_shatter(ps, nv, lib9)[0]),
        ("CaDiCaL", lambda ps, nv: solve_psets_with_cadical(ps, nv)[0]),
        ("CMS5", lambda ps, nv: solve_psets_with_cms5(ps, nv, max_time=10, tag="audit")[0]),
        ("Singular", lambda ps, nv: solve_psets_with_singular(ps, nv, timeout_sec=15, tag="audit")[0]),
    ]:
        st0 = fn([{0}], 12)
        assert "UNSAT" in st0, f"{name} failed 1=0 test: {st0}"
        st1 = fn([{1, 2}, {0, 1, 2}], 12)
        assert "UNSAT" in st1, f"{name} failed contradiction test: {st1}"

    # 10 random planted systems for CompactXL3 + CaDiCaL + CMS5 (n=16, m=28)
    for trial in range(10):
        n_t = 16
        x_pl = int(rng.integers(0, 1 << n_t))
        psets = []
        for _ in range(28):
            ps = set()
            for _ in range(int(rng.integers(2, 8))):
                deg = int(rng.integers(1, 4))
                vs = rng.choice(n_t, size=deg, replace=False)
                m = 0
                for v in vs:
                    m |= (1 << int(v))
                ps.symmetric_difference_update({m})
            if _eval_pset_bits(ps, x_pl) == 1:
                ps.symmetric_difference_update({0})
            psets.append(ps)
        st_x, _, _, q_x, c_x = compact_d3_xl_shatter(psets, n_t, lib9)
        assert st_x == "XL3_FIXPOINT", f"CompactXL3 planted false negative trial {trial}: {st_x}"
        for ps in q_x + c_x:
            assert _eval_pset_bits(ps, x_pl) == 0, f"CompactXL3 output poly violated planted sol!"
        st_c, _, _ = solve_psets_with_cadical(psets, n_t)
        assert st_c == "CAD_SAT", f"CaDiCaL planted false negative trial {trial}: {st_c}"
        st_m, _, _ = solve_psets_with_cms5(psets, n_t, max_time=15, tag="audit_pl")
        assert st_m == "CMS_SAT", f"CMS5 planted false negative trial {trial}: {st_m}"

    # 5 random planted systems for Singular (n=10, m=18, checking GB vanishes on x_pl!)
    for trial in range(5):
        n_t = 10
        x_pl = int(rng.integers(0, 1 << n_t))
        psets = []
        for _ in range(18):
            ps = set()
            for _ in range(int(rng.integers(2, 6))):
                deg = int(rng.integers(1, 4))
                vs = rng.choice(n_t, size=deg, replace=False)
                m = 0
                for v in vs:
                    m |= (1 << int(v))
                ps.symmetric_difference_update({m})
            if _eval_pset_bits(ps, x_pl) == 1:
                ps.symmetric_difference_update({0})
            psets.append(ps)
        st_s, _, info_s = solve_psets_with_singular(psets, n_t, timeout_sec=20, tag="audit_sing", verify_point=x_pl)
        assert st_s == "SING_OPEN", f"Singular planted false negative trial {trial}: {st_s} ({info_s})"

    print("  [ZERO-TRUST AUDIT] ALL 4 ENGINES PASSED: CompactXL3(10/10), CaDiCaL(10/10), CMS5(10/10), Singular(5/5 + GB subst=0)!", flush=True)


def build_step41a_flags(Mk_c, nW, seed=6001):
    """Port of Step 41A Parts 1 & 2 + Exact Greedy Row-Annihilator Intersection."""
    n_core_rows, nRC = Mk_c.shape[1], Mk_c.shape[2]

    def mat_of(cm):
        acc = np.zeros((n_core_rows, nRC), dtype=np.uint8)
        for k in range(nW):
            if (cm >> k) & 1:
                acc ^= Mk_c[k]
        return acc

    found_low = {}
    def record_c(cm):
        if cm == 0 or cm in found_low:
            return
        rk = len(s40a.gf2_rref_np(mat_of(cm))[1])
        if rk <= 26:
            found_low[cm] = rk

    for i in range(nW):
        record_c(1 << i)
        for j in range(i + 1, nW):
            record_c((1 << i) | (1 << j))

    rng_py = random.Random(seed)
    tested_v = set()
    def probe_v(v):
        key = v.tobytes()
        if key in tested_v:
            return
        tested_v.add(key)
        Bv = np.zeros((n_core_rows, nW), dtype=np.uint8)
        for k in range(nW):
            Bv[:, k] = (Mk_c[k] @ v) & 1
        for row in s40a.gf2_nullspace_np(Bv):
            record_c(sum((1 << k) for k in range(nW) if row[k]))

    for j in range(nRC):
        e = np.zeros(nRC, dtype=np.uint8)
        e[j] = 1
        probe_v(e)
    for _ in range(3):
        cands = [cm for cm, rk in sorted(found_low.items(), key=lambda x: x[1]) if 1 <= rk <= 22][:15]
        for cm in cands:
            K = s40a.gf2_nullspace_np(mat_of(cm))
            for row in K:
                probe_v(row)
            if K.shape[0] >= 2:
                for _ in range(20):
                    a, b = rng_py.randrange(K.shape[0]), rng_py.randrange(K.shape[0])
                    if a != b:
                        probe_v(K[a] ^ K[b])

    u_cands = []
    seen_u = set()
    def add_u(u):
        kb = u.tobytes()
        if kb not in seen_u and np.any(u):
            seen_u.add(kb)
            u_cands.append(u)

    for i in range(n_core_rows):
        u = np.zeros(n_core_rows, dtype=np.uint8)
        u[i] = 1
        add_u(u)
    for cm, rk in sorted(found_low.items(), key=lambda x: x[1])[:8]:
        if rk == 0:
            continue
        LK = s40a.gf2_nullspace_np(mat_of(cm).T)
        for row in LK[:20]:
            add_u(row)

    best_u = []
    for u in u_cands:
        Au = np.zeros((nRC, nW), dtype=np.uint8)
        for k in range(nW):
            Au[:, k] = (u @ Mk_c[k]) & 1
        K_u = s40a.gf2_nullspace_np(Au)
        best_u.append((K_u.shape[0], K_u, u, Au))
    best_u.sort(key=lambda x: -x[0])

    # Greedy Row-Annihilator Intersection chain
    C_int = np.zeros((0, nW), dtype=np.uint8)
    rowint_list = []
    used_u_idx = set()
    cur_dim = nW
    for _step in range(min(30, len(best_u))):
        best_pick = None
        for ui, (du, Ku, u, Au) in enumerate(best_u[:120]):
            if ui in used_u_idx:
                continue
            C_try = np.vstack([C_int, Au]) if C_int.shape[0] else Au
            R_try, p_try = s40a.gf2_rref_np(C_try)
            new_dim = nW - len(p_try)
            if new_dim == cur_dim:
                best_pick = (0, ui, R_try[:len(p_try)], new_dim)
                break
            loss = cur_dim - new_dim
            if best_pick is None or loss < best_pick[0]:
                best_pick = (loss, ui, R_try[:len(p_try)], new_dim)
        if best_pick is None:
            break
        loss, ui, C_new, new_dim = best_pick
        used_u_idx.add(ui)
        C_int = C_new
        cur_dim = new_dim
        if cur_dim < 14:
            break
        U_now = s40a.gf2_nullspace_np(C_int) if C_int.shape[0] else np.eye(nW, dtype=np.uint8)
        rowint_list.append((len(used_u_idx), cur_dim, U_now))

    # Step 41A Greedy Max-Untouched-Rows Flag
    pool = [cm for cm, _ in sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))[:250]]
    if best_u:
        for row in best_u[0][1]:
            cm = sum((1 << k) for k in range(nW) if row[k])
            if cm and cm not in pool:
                pool.append(cm)
    for k in range(nW):
        if (1 << k) not in pool:
            pool.append(1 << k)

    pool_cols = []
    for cm in pool:
        M = mat_of(cm)
        R, pivs = s40a.gf2_rref_np(M.T)
        c_masks = [sum((1 << r) for r in range(n_core_rows) if R[ri, r]) for ri in range(len(pivs))]
        pool_cols.append((cm, len(pivs), c_masks))

    flag_cms = []
    flag_piv = {}
    row_span_piv = {}

    def add_cost(c_masks):
        tmp = dict(row_span_piv)
        added = 0
        for m in c_masks:
            v = m
            while v:
                b = v.bit_length() - 1
                if b in tmp:
                    v ^= tmp[b]
                else:
                    tmp[b] = v
                    added += 1
                    break
        return added

    def is_indep_cm(cm):
        v = cm
        while v:
            b = v.bit_length() - 1
            if b in flag_piv:
                v ^= flag_piv[b]
            else:
                return True
        return False

    untouched_by_d = {}
    while len(flag_cms) < min(38, nW):
        best_choice = None
        for cm, rk, c_masks in pool_cols:
            if not is_indep_cm(cm):
                continue
            cost = add_cost(c_masks)
            key = (cost, rk)
            if best_choice is None or key < best_choice[0]:
                best_choice = (key, cm, c_masks)
        if best_choice is None:
            break
        _, cm, c_masks = best_choice
        flag_cms.append(cm)
        v = cm
        while v:
            b = v.bit_length() - 1
            if b in flag_piv:
                v ^= flag_piv[b]
            else:
                flag_piv[b] = v
                break
        for m in c_masks:
            v = m
            while v:
                b = v.bit_length() - 1
                if b in row_span_piv:
                    v ^= row_span_piv[b]
                else:
                    row_span_piv[b] = v
                    break
        untouched_by_d[len(flag_cms)] = n_core_rows - len(row_span_piv)

    return flag_cms, untouched_by_d, best_u, rowint_list


def test_subspace_shatter(label, U1, W_forms_111, sr, lib9, tbl, rng, n_trials=3,
                          do_singular=True, do_cms=True, do_cadical=True, live_audit_state=None):
    """
    Test pure-algebraic shatter of `U1` (d_free x nW) using TRUE dual annihilator
    `F_sub = gf2_nullspace_np(U1)` via:
      s9.run_branch_cascade -> Compact Untruncated D3 XL -> CMS5 / Singular slimgb / CaDiCaL!
    """
    d_free, nW = U1.shape
    F_sub = s40a.gf2_nullspace_np(U1)
    k_fix = F_sub.shape[0]
    assert k_fix == nW - d_free, f"Rank defect in U1: d_free={d_free}, k_fix={k_fix}, nW={nW}"
    assert np.all(((U1 @ F_sub.T) & 1) == 0), "Dual annihilator U1 @ F_sub^T != 0!"

    fix_forms = []
    for row in F_sub:
        fm = 0
        for k in range(nW):
            if row[k]:
                fm ^= W_forms_111[k]
        fix_forms.append(fm)

    n = tbl["n"]
    f_logs = []
    n_s9_closed, n_xl3_closed, n_any_closed = 0, 0, 0
    for tr in range(n_trials):
        rb = 0 if tr == 0 else sum(int(rng.integers(0, 2)) << j for j in range(k_fix))
        ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
        t_s9 = time.perf_counter()
        sub = s9.run_branch_cascade(
            lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
            ex_w, tbl, max_xl_rounds=25, verify_subst=(tr == 0)
        )
        dt_s9 = time.perf_counter() - t_s9
        if sub["closed_unsat"]:
            n_s9_closed += 1
            n_xl3_closed += 1
            n_any_closed += 1
            f_logs.append(f"f{tr}:S9_UNSAT({dt_s9:.1f}s)")
            continue

        n_act = 111 - len(sub["_lin_pivs"])
        nq_s = len(sub["_quad_ids"])
        nc_s = len(sub["_cub_ids"])
        q_psets = [s9.row_to_pset(sub["_buf"], rid, tbl) for rid in sub["_quad_ids"]]
        full_psets = q_psets + [s9.row_to_pset(sub["_buf"], rid, tbl) for rid in sub["_cub_ids"]]

        # Stage 2: UNTRUNCATED COMPACT DEGREE-3 XL!
        xl_st, xl_dt, n_after_xl, q_xl, c_xl = compact_d3_xl_shatter(full_psets, n, lib9, max_n=74)
        if xl_st == "XL3_UNSAT":
            n_xl3_closed += 1
            n_any_closed += 1
            f_logs.append(f"f{tr}:N={n_act},q={nq_s},c={nc_s}[s9:{dt_s9:.1f}s]->***XL3_UNSAT({xl_dt:.1f}s)***")
            continue
        elif xl_st == "XL3_FIXPOINT":
            q_psets = q_xl
            full_psets = q_xl + c_xl
            n_act_post = n_after_xl
            nq_post, nc_post = len(q_xl), len(c_xl)
            xl_tag = f"xl3({xl_dt:.1f}s)->N={n_act_post},q={nq_post},c={nc_post}"
        else:
            n_act_post, nq_post, nc_post = n_act, nq_s, nc_s
            xl_tag = f"N={n_act},q={nq_s},c={nc_s}"

        # Live Zero-Trust assumption-SAT planted audit on FIRST real open residual (O(clauses) = 0.01s)!
        if live_audit_state is not None and (not live_audit_state["done"]) and n_act_post <= 75 and full_psets:
            x_pl = sum(int(rng.integers(0, 2)) << b for b in range(n))
            pl_full = []
            for ps in full_psets:
                ps2 = set(ps)
                if _eval_pset_bits(ps2, x_pl) == 1:
                    ps2.symmetric_difference_update({0})
                pl_full.append(ps2)
            st_c, dt_c, _ = solve_psets_with_cadical(pl_full, n, assumptions_bits=x_pl)
            st_m, dt_m, _ = solve_psets_with_cms5(pl_full, n, max_time=10, tag="live_pl", assumptions_bits=x_pl)
            assert st_c == "CAD_SAT", f"LIVE PLANTED AUDIT CaDiCaL FAILED: {st_c}"
            assert st_m == "CMS_SAT", f"LIVE PLANTED AUDIT CMS5 FAILED: {st_m}"
            print(f"      [LIVE PLANTED AUDIT] Real residual (N={n_act_post},q={nq_post},c={nc_post}): CaDiCaL={st_c}({dt_c:.3f}s), CMS5={st_m}({dt_m:.3f}s)!", flush=True)
            live_audit_state["done"] = True

        res_parts = []
        closed_here = False

        # Stage 3: CryptoMiniSat 5 (native XOR + GF(2) Gauss-Jordan!)
        if do_cms and n_act_post <= 85:
            cms_st, cms_dt = None, 0.0
            if nq_post >= 100 and nc_post > 0:
                q_st, q_dt, _ = solve_psets_with_cms5(q_psets, n, max_time=10, tag="qonly")
                if q_st in ("CMS_UNSAT", "UNSAT_1EQ0"):
                    cms_st, cms_dt = "CMS_QONLY_UNSAT", q_dt
            if cms_st is None:
                cms_st, cms_dt, _ = solve_psets_with_cms5(full_psets, n, max_time=20, tag="full")
            res_parts.append(f"{cms_st}({cms_dt:.1f}s)")
            if "UNSAT" in cms_st:
                closed_here = True

        # Stage 4: Singular slimgb (over GF(2)) on first 2 fibers if N <= 65
        if do_singular and tr < 2 and n_act_post <= 65 and (not closed_here or tr == 0):
            sing_st, sing_dt = None, 0.0
            if nq_post >= 15:
                q_st, q_dt, _ = solve_psets_with_singular(q_psets, n, timeout_sec=25, tag="sq")
                if q_st in ("SING_UNSAT", "UNSAT_1EQ0"):
                    sing_st, sing_dt = "SING_Q_UNSAT", q_dt
                elif nc_post > 0 and n_act_post <= 52 and len(full_psets) <= 650:
                    sing_st, sing_dt, _ = solve_psets_with_singular(full_psets, n, timeout_sec=25, tag="sf")
                else:
                    sing_st, sing_dt = f"SING_Q_{q_st}", q_dt
            elif len(full_psets) <= 650:
                sing_st, sing_dt, _ = solve_psets_with_singular(full_psets, n, timeout_sec=25, tag="sf")
            if sing_st is not None:
                res_parts.append(f"{sing_st}({sing_dt:.1f}s)")
                if "UNSAT" in sing_st:
                    closed_here = True

        # Stage 5: CaDiCaL 195 fast comparison
        if do_cadical and n_act_post <= 85 and (not closed_here) and tr == 0:
            cad_st, cad_dt, _ = solve_psets_with_cadical(full_psets, n, max_conf_budget=60000)
            res_parts.append(f"{cad_st}({cad_dt:.1f}s)")
            if "UNSAT" in cad_st:
                closed_here = True

        if closed_here:
            n_any_closed += 1
        tag_str = ",".join(res_parts) if res_parts else "SKIP"
        f_logs.append(f"f{tr}:{xl_tag}[s9:{dt_s9:.1f}s]->{tag_str}")

    print(f"      [{label:16s} d={d_free:2d}, k_fix={k_fix:2d}] S9={n_s9_closed}/{n_trials}, XL3={n_xl3_closed}/{n_trials}, TOT={n_any_closed}/{n_trials} | " + " | ".join(f_logs), flush=True)
    return n_s9_closed, n_xl3_closed, n_any_closed


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--etas", type=str, default="")
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 60A: DEEP FULL-389 SHATTER (41A FLAG + COMPACT XL3 + CMS5 + SINGULAR) ====================", flush=True)
    rng = np.random.default_rng(6001)

    c_diag, so_diag = WORK_DIR / "s60a_diag.c", WORK_DIR / "libs60a_diag.so"
    c_diag.write_text(diag_v2.C_DIAG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_diag), "-o", str(so_diag)], check=True)
    lib_diag = ctypes.CDLL(str(so_diag))
    lib_diag.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_diag.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_diag.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_diag.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_diag.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_diag.gf2_echelon_insert.restype = ctypes.c_int

    c_s9, so_s9 = WORK_DIR / "s60a_s9.c", WORK_DIR / "libs60a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    audit_all_solvers_zerotrust(rng, lib9)

    c_cg, so_cg = WORK_DIR / "s60a_cg.c", WORK_DIR / "libs60a_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
            ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]

    c_sh, so_sh = WORK_DIR / "s60a_sh.c", WORK_DIR / "libs60a_sh.so"
    c_sh.write_text(s17.C_SHEAR_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_sh), "-o", str(so_sh)], check=True)
    lib_sh = ctypes.CDLL(str(so_sh))
    lib_sh.shear_subst_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib_sh.remap_rows_by_perm.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
    ]

    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for mm in orb: mon_to_orb_arr[mm] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)
    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1: row_mask |= (1 << m_idx)
        M_rows.append(row_mask)
    fiber_meta = (nonzero_z, diag_v2.gf2_nullspace_left(M_rows))

    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    seen_x = bytearray(65536)
    rot4_reps, rep_of_x = [], [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]: continue
        r_idx = len(rot4_reps); rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1; rep_of_x[y] = r_idx
    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]: continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1; mem.append(cur); cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF: coset_0xf_reps.append(mem[0])

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for mm in orb: acc ^= ((X & mm) == mm).astype(np.uint8)
        tt = bytearray(acc.tolist())
        orb_tts[j] = tt
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)
    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, lambda j, x: orb_tts[j][x])

    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1
    orb_map[99] = -2 if c99 else -1
    orb_map[57] = -2 if c57 else -1
    orb_map[113] = -2 if c113 else -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    if args.etas:
        test_etas = [int(x.strip()) for x in args.etas.split(",") if x.strip()]
    else:
        test_etas = [5, 0, 9] if cell_name == "B0_11" else [3, 0, 8]

    live_audit_state = {"done": False}

    for em in test_etas:
        print(f"\n  ================================ [{cell_name} eta={em}] ================================", flush=True)
        n_ef = len(eta_free)
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=False
        )
        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        W_pivs = sorted(W_rref.keys())
        W_forms_111 = [W_rref[p] for p in W_pivs]
        nW = len(W_pivs)

        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6001 + em)
        if sys_ex.get("closed_unsat"):
            print(f"    [eta={em}] ALREADY CLOSED AT ROOT!", flush=True)
            continue
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        print(f"    [Core Pencil] nW={nW}, M0_c.shape={M0_c.shape}", flush=True)
        if M0_c.shape[0] == 0 or M0_c.shape[1] == 0:
            continue

        flag_cms, untouched_by_d, best_u, rowint_list = build_step41a_flags(Mk_c, nW, seed=6001 + em)
        print(f"    [41A Top-8 dim(L(u))/{nW}]: {[x[0] for x in best_u[:8]]}", flush=True)
        u_str = ", ".join(f"L{d}:{untouched_by_d[d]}" for d in sorted(untouched_by_d) if d in (18, 20, 22, 24, 26, 28, 30, 32, 34))
        print(f"    [41A Greedy Untouched / {M0_c.shape[0]}]: {u_str}", flush=True)
        ri_str = ", ".join(f"r{nr}->d{dm}" for nr, dm, _ in rowint_list[:12])
        print(f"    [Exact Row-Int Chain]: {ri_str}", flush=True)

        d_ladder = [24, 26, 28, 30, 32] if cell_name == "B0_11" else [18, 20, 22, 24, 26, 28]

        print(f"    --- Strategy A: Step 41A Greedy-Untouched Flag ---", flush=True)
        for d_free in d_ladder:
            if d_free > len(flag_cms):
                continue
            U1 = np.zeros((d_free, nW), dtype=np.uint8)
            for ri, cm in enumerate(flag_cms[:d_free]):
                for k in range(nW):
                    if (cm >> k) & 1:
                        U1[ri, k] = 1
            test_subspace_shatter(
                f"41A_Flag", U1, W_forms_111, sr, lib9, tbl, rng,
                n_trials=3, do_singular=True, do_cms=True, do_cadical=True,
                live_audit_state=live_audit_state
            )

        print(f"    --- Strategy B: Step 57B U_opt (KR+V0) ---", flush=True)
        for d_free in d_ladder:
            U_opt, _, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d_free, em_seed=em)
            test_subspace_shatter(
                f"57B_Uopt(e={bkey[0]})", U_opt[:d_free], W_forms_111, sr, lib9, tbl, rng,
                n_trials=3, do_singular=True, do_cms=True, do_cadical=True,
                live_audit_state=live_audit_state
            )

        print(f"    --- Strategy C: Exact Row-Annihilator Intersection L(u_1)...L(u_r) ---", flush=True)
        tested_ri_dims = set()
        if best_u and best_u[0][0] < nW:
            du0, Ku0, _, _ = best_u[0]
            tested_ri_dims.add(du0)
            test_subspace_shatter(
                f"L(u_best[0])", Ku0, W_forms_111, sr, lib9, tbl, rng,
                n_trials=2, do_singular=False, do_cms=True, do_cadical=True,
                live_audit_state=live_audit_state
            )
        for nr, dm, U_ri in rowint_list:
            if dm in tested_ri_dims:
                continue
            lo_d = 24 if cell_name == "B0_11" else 18
            hi_d = 35 if cell_name == "B0_11" else 30
            if lo_d <= dm <= hi_d:
                tested_ri_dims.add(dm)
                test_subspace_shatter(
                    f"RowInt(r={nr})", U_ri, W_forms_111, sr, lib9, tbl, rng,
                    n_trials=3, do_singular=True, do_cms=True, do_cadical=True,
                    live_audit_state=live_audit_state
                )

    print(f"\n[STEP 60A {cell_name}] DONE in {time.perf_counter()-t0:.1f}s", flush=True)


if __name__ == "__main__":
    main()
