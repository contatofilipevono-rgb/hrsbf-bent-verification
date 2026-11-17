# Busca no Interior ($6 \le k \le 106$) do Ramo $c_{99}=1$ (C7) por $|W_f(0)| = |W_f(e_0)| = 256$

Investigação sobre a suficiência dos dois primeiros testes de Walsh ($W_f(0)$ e $W_f(e_0)$, com $e_0 = \text{0x0001}$) no interior do ramo $c_{99}=1$ (após todas as sete condições históricas C1–C7 de `T28_SEXTA_CERTIFICADO.json` e `T31_SETIMA_CERTIFICADO.json`).

## Resultado Principal

**Existem milhares de testemunhas válidas em C1–C7 que satisfazem $|W_f(0)| = |W_f(e_0)| = 256$** — não há obstrução modular para $(A, B) \in \{(\pm 256, 0), (0, \pm 256)\}$ no interior do ramo.

### Resumo por Faixa (Amostragem Estrita C7)

| Faixa | $k$ (órbitas longas) | C1–C5+C7 testados | C7 válidos | Passam $W_f(0)$ | Passam ambos ($W_f(0)$ e $W_f(e_0)$) |
|---|---:|---:|---:|---:|---:|
| `near_sparse` | $[6, 15]$ | 1.583.465 | 791.376 | 1.218 | 0 |
| `central` | $[50, 62]$ | 1.600.000 | 801.340 | 124.907 | **5.104** |
| `near_dense` | $[97, 106]$ | 1.513.702 | 757.886 | 18.705 | **233** |

Na varredura de alta vazão (`bands_c157_fast`, ~157,2 milhões de vetores C1–C5+C7), foram encontrados **223.313** vetores C7-válidos satisfazendo $|W_f(0)| = |W_f(e_0)| = 256$ (`127.769` em `central`, `5.656` em `near_dense`, `89.888` em `full_interior`).

### Primeira Testemunha Auditada (65.536 entradas diretas + FWHT completo)

- **Coeficientes (116 bits)**: `0xdcc662e2c890c0324c1549b289` (`41` órbitas longas + `99`, total `42` órbitas ativas)
- **C1–C7**: todas `true`
- **Metades**: $A = 256$ (`wt = 16.256`), $B = 0$ (`wt = 16.384`)
- **Walsh**: $W_f(0) = 256$, $W_f(e_0) = 256$ (e todas as 16 frequências unitárias = `256`)
- **Primeira frequência que falha**: `0x3` ($e_0 + e_1$) com $W_f(\text{0x3}) = 640$ (não bent).

## Execução no Google Cloud

- **Projeto**: `project-342eeb2f-3c82-4897-a4d` (`us-central1`)
- **Cloud Run Job**: `h16-c99-interior-pilot` (execução `h16-c99-interior-pilot-ph2z6`, 8 vCPUs, 4 GiB RAM, `4m27.18s` totais no Cloud Run, `234.10s` no script Python).
- **Reprodução**:
  ```bash
  gcloud run jobs execute h16-c99-interior-pilot --region=us-central1 --project=project-342eeb2f-3c82-4897-a4d --wait
  ```
