# Verificação Exaustiva H16 ($n=16$, grau 4 homogêneo, ramo $c_{99}=1$, $k=5$)

Este diretório contém o código reproduzível e o relatório JSON da verificação exaustiva para funções booleanas homogêneas quárticas em 16 variáveis, invariantes por rotação cíclica, no ramo $c_{99}=1$ com exatamente **5 órbitas longas presentes** ou **5 órbitas longas ausentes**.

## Resultados Principais

- **Controle acumulado ($k=0..4$)**: reproduzido exatamente (`1.359.552` admissíveis por lado; `presentes`: todas falham em $W_f(0)$; `ausentes`: `1.359.480` falham em $W_f(0)$ e `72` falham em $W_f(e_0)$).
- **Contagem independente por DP e soma binomial ($k=5$)**: **29.508.240** candidatas admissíveis por lado (**59.016.480** no total), dentro de $\binom{112}{5} = 134.153.712$ escolhas por lado.
- **Particionamento**: 108 lotes disjuntos por lado (indexados pelo menor índice $i_0 \in \{0,\dots,107\}$), todos concluídos e conferidos (`108/108` por lado).
- **Faixa $k=5$ (`presentes`)**: `29.508.216` falham em $W_f(0)$, `24` falham em $W_f(e_0)$, `0` funções bent.
- **Faixa $k=5$ (`ausentes`)**: `29.504.628` falham em $W_f(0)$, `3.612` falham em $W_f(e_0)$, `0` funções bent.

**Conclusão autorizada**: uma eventual H16 bent no ramo $c_{99}=1$ precisa usar entre **6 e 106** das 112 órbitas longas. O interior do ramo continua aberto.

## Reprodução Local / Linux / GitHub Actions

```bash
python3 research_updates/2026_11_17_h16_c99_k5/run_h16_study.py --work-dir /tmp/h16_work --workers $(nproc) --run-full
```

## Execução Original no Google Cloud

- **Projeto**: `project-342eeb2f-3c82-4897-a4d` (`us-central1`)
- **Cloud Run Job**: `h16-c99-k5-full` (execução `h16-c99-k5-full-5r8zl`, 8 vCPUs, 4 GiB RAM, `23.46s` totais, `4.398s` na faixa $k=5$).
