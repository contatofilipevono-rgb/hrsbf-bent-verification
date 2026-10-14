#!/usr/bin/env python3
"""
Master A100 Execution Pipeline for HRSBF verification and research.

Stages:
  Stage 1: Exhaustive search of homogeneous quartic (degree 4) RS functions in n=10 (2^22 = 4.19M functions).
  Stage 2: Exhaustive search of RS functions of degree <= 3 in n=14 (2^33 = 8.58B functions).
  Stage 3: Deep adaptive quintic (degree 5) search campaign in n=16 (pesquisa_fibras_loop.py).

Usage:
  python run_a100_pipeline.py [--stages 1,2,3] [--n14-chunk-log2 13] [--stage3-seconds 3600]
"""
import sys, os, time, subprocess, argparse, json, pathlib

ROOT = pathlib.Path(__file__).resolve().parent

def run_cmd(cmd, desc):
    print(f"\n{'='*70}\n[PIPELINE] INICIANDO: {desc}\nCOMANDO: {' '.join(cmd)}\n{'='*70}\n", flush=True)
    t0 = time.time()
    p = subprocess.run(cmd, cwd=ROOT)
    elapsed = time.time() - t0
    if p.returncode != 0:
        print(f"\n[ERRO] {desc} falhou com código de retorno {p.returncode} após {elapsed:.1f}s\n", flush=True)
        return False, elapsed
    print(f"\n[SUCESSO] {desc} concluído com sucesso em {elapsed:.1f}s ({elapsed/60:.2f} min)\n", flush=True)
    return True, elapsed

def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--stages', type=str, default='1,2,3', help='Comma-separated stages to run: e.g. 1,2,3')
    ap.add_argument('--n14-chunk-log2', type=int, default=13, help='Batch size log2 for n=14 (default 13 = 8192)')
    ap.add_argument('--stage3-seconds', type=int, default=3600, help='Max seconds for Stage 3 quintic search (default 3600 = 1h)')
    args = ap.parse_args()

    stages = [int(s.strip()) for s in args.stages.split(',') if s.strip()]
    print(f"[PIPELINE A100] Estágios selecionados: {stages}", flush=True)

    summary = {'started_at': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()), 'stages': {}}

    # Probe GPU
    probe_ok, _ = run_cmd([sys.executable, 'pesquisa_t32/gpu_probe.py'], 'Sondagem de GPU CUDA')
    if not probe_ok:
        print("AVISO: CUDA não detectada no probe. Prosseguindo...")

    # Stage 1
    if 1 in stages:
        s1_out = ROOT / 'results' / 'stage1_quartic_n10'
        s1_out.mkdir(parents=True, exist_ok=True)
        cmd = [
            sys.executable, 'rs_quartic_n10.py',
            '--backend', 'cuda',
            '--output-dir', str(s1_out)
        ]
        ok, dt = run_cmd(cmd, 'Estágio 1: Quárticas Homogêneas em n=10 (4.19M funções)')
        summary['stages']['stage1_quartic_n10'] = {'success': ok, 'elapsed_seconds': dt}

    # Stage 2
    if 2 in stages:
        s2_out = ROOT / 'results' / 'stage2_rs_bent_n14'
        s2_out.mkdir(parents=True, exist_ok=True)
        cmd = [
            sys.executable, 'rs_bent_exhaustive.py',
            '14', str(args.n14_chunk_log2),
            '--backend', 'cuda',
            '--resume',
            '--output-dir', str(s2_out)
        ]
        ok, dt = run_cmd(cmd, 'Estágio 2: Varredura Exaustiva n=14 (8,58 bilhões de funções)')
        summary['stages']['stage2_rs_bent_n14'] = {'success': ok, 'elapsed_seconds': dt}

    # Stage 3
    if 3 in stages:
        s3_out = ROOT / 'results' / 'stage3_quintic_n16'
        s3_out.mkdir(parents=True, exist_ok=True)
        cmd = [
            sys.executable, 'pesquisa_t32/pesquisa_fibras_loop.py',
            '--n', '16',
            '--degree', '5',
            '--backend', 'cuda',
            '--rounds', '100',
            '--batch', '2048',
            '--max-seconds', str(args.stage3_seconds),
            '--output', str(s3_out)
        ]
        ok, dt = run_cmd(cmd, f'Estágio 3: Campanha Quíntica n=16 ({args.stage3_seconds}s)')
        summary['stages']['stage3_quintic_n16'] = {'success': ok, 'elapsed_seconds': dt}

    summary['finished_at'] = time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())
    sum_path = ROOT / 'results' / 'pipeline_summary.json'
    sum_path.parent.mkdir(parents=True, exist_ok=True)
    sum_path.write_text(json.dumps(summary, indent=2) + '\n')
    print(f"\n[PIPELINE FINALIZADO] Resumo salvo em {sum_path}\n", flush=True)

if __name__ == '__main__':
    main()
