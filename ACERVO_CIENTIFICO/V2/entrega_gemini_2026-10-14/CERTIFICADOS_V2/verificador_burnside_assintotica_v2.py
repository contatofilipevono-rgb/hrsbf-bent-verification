#!/usr/bin/env python3
"""Verificador Independente da Tarefa B (Burnside, Pólya, Inversão de Möbius e Assintótica) — Projeto V2."""
from itertools import combinations, permutations
from math import factorial, comb, gcd, log2
from time import time
import suite_auditoria_e_novos_teoremas_v2 as suite

t0 = time()
print("======================================================================")
print("1. VALIDAÇÃO CRUZADA DE C_r(pi): INVERSÃO DE MÖBIUS vs. BFS DIRETO (r=2,3,4)")
print("======================================================================")

def canonical_part(part):
    return tuple(sorted(tuple(sorted(b)) for b in part))

def all_set_partitions(items):
    if not items:
        yield ()
        return
    x, *tail = items
    for p in all_set_partitions(tail):
        yield ((x,),) + p
        for j, b in enumerate(p):
            yield p[:j] + (tuple(sorted(b + (x,))),) + p[j + 1:]

def refines(a, b):
    return all(any(set(x).issubset(y) for y in b) for x in a)

def orbit_count_arcs(perm, arcs):
    arcs_set, seen = set(arcs), set()
    cnt = 0
    for x in arcs_set:
        if x in seen:
            continue
        cnt += 1
        y = x
        while y not in seen:
            seen.add(y)
            y = (perm[y[0]], perm[y[1]])
    return cnt

def fixed_connected_mobius(perm):
    n = len(perm)
    parts = sorted(
        {
            p for p in (canonical_part(p) for p in all_set_partitions(list(range(n))))
            if canonical_part(tuple(tuple(perm[x] for x in b) for b in p)) == p
        },
        key=lambda p: -len(p),
    )
    exact = {}
    for p in parts:
        arcs = ((i, j) for b in p for i in b for j in b if i != j)
        tot = 1 << orbit_count_arcs(perm, arcs)
        exact[p] = tot - sum(v for q, v in exact.items() if refines(q, p))
        assert exact[p] >= 0
    return exact[(tuple(range(n)),)]

def is_weakly_connected_bfs(r, arcs):
    adj = {i: set() for i in range(r)}
    for u, v in arcs:
        adj[u].add(v)
        adj[v].add(u)
    vis = {0}
    q = [0]
    while q:
        c = q.pop()
        for nxt in adj[c]:
            if nxt not in vis:
                vis.add(nxt)
                q.append(nxt)
    return len(vis) == r

for r in (2, 3, 4):
    dir_pairs = [(i, j) for i in range(r) for j in range(r) if i != j]
    conn_list = []
    for mask in range(1 << len(dir_pairs)):
        arcs = frozenset(dir_pairs[k] for k in range(len(dir_pairs)) if (mask >> k) & 1)
        if is_weakly_connected_bfs(r, arcs):
            conn_list.append(arcs)
    for p in permutations(range(r)):
        c_bfs = sum(1 for arcs in conn_list if frozenset((p[u], p[v]) for u, v in arcs) == arcs)
        c_mob = fixed_connected_mobius(p)
        assert c_bfs == c_mob
    print(f"  r={r}: d_{r} = {len(conn_list)} | Todas as {factorial(r)} permutações coincidem entre BFS direto e Möbius!")

print("\n======================================================================")
print("2. CODIMENSÃO EXATA DE TRANSPOSIÇÕES E DECOMPOSIÇÃO DE ERRO ASSINTÓTICO")
print("======================================================================")
for r in range(2, 8):
    D = 32 * (r ** 3) - 4 * (r ** 2)
    c2_tau_formula = 32 * (r ** 3) - 100 * (r ** 2) + 204 * r - 144
    codim_tau = 96 * (r ** 2) - 204 * r + 144
    assert D - c2_tau_formula == codim_tau
    c2_gen = suite.c2_general([(2, 1)] + [(1, 1)] * (r - 2))
    assert c2_tau_formula == c2_gen
    disc_err_log2 = log2(r) - 2 * (r - 1)
    aut_err_log2 = log2(comb(r, 2)) - (2 * r - 3) - codim_tau
    print(f"  r={r}: D={D:5d}, c_2(tau)={c2_tau_formula:5d}, D-c_2(tau)={codim_tau:4d} bits | log2(erro_desconexo)~{disc_err_log2:6.1f} vs log2(erro_Aut)~{aut_err_log2:7.1f}")

print(f"\n[OK] Verificação de Burnside e Assintótica concluída em {time()-t0:.2f}s.")
