# Cobertura Completa de Subconjuntos até 6 de 8 Distâncias de Peso 2 em $H_{16}$ ($c_{99}=1$, C1–C7)

Investigação sobre quais pares de distâncias pares $\{2,4,6,8\}$ passam simultaneamente com as quatro distâncias ímpares `0x55` (`1,3,5,7`), além de C1–C7, $|W_f(0)|=256$ e $|W_f(e_0)|=256$, no ramo $c_{99}=1$ ($6 \le k \le 106$).

## Tabela Final dos 5 Alvos (mais controle `0xdd`)

| Distâncias pares | Alvo | Status | Hexadecimal (116 bits) | $k_{\text{long}}$ | $W_f(0), W_f(e_0)$ | 1ª falha (FWHT) |
|---|---|---|---|---:|---|---|
| 2 e 4 | `0x5f` | **testemunha auditada** | `0x63fdfbfeffb97c5ee7dfbf7ffbda` | 86 | `-256, 256` | `0x7 -> -128` |
| 2 e 6 | `0x77` | **testemunha auditada** | `0x2158943d9b9c46b758ede787a6ba8` | 57 | `256, 256` | `0x7 -> -128` |
| 4 e 6 | `0x7d` | **testemunha auditada** | `0x579fbbffeb7e9edfdcd6f7df75dbb` | 86 | `-256, 256` | `0x5 -> 0` |
| 2 e 8 | `0xd7` | **testemunha auditada** | `0x6945f66e9236b2216a67a9c2a4fd6` | 56 | `256, 256` | `0x7 -> 0` |
| 6 e 8 | `0xf5` | **testemunha auditada** | `0x2d5cf30a3783be3cda9694dcca341` | 56 | `256, 256` | `0x5 -> 704` |
| 4 e 8 (controle) | `0xdd` | **testemunha auditada** | `0x7adaedfe672bb236dcd7c63ca08b4` | 63 | `256, 256` | `0x5 -> 768` |

## Fechamento 28/28 de Todos os Subconjuntos de Tamanho $\le 6$

Complementando as 6 testemunhas de pares pares, a transformação $i \mapsto a i \bmod 16$ ($a \in \{1,3,5,7\}$) sobre `0xbf` (`0x363fdfbfe7fbd7edee7dffffffbfa`) produz quatro testemunhas **C1–C7 válidas** e auditadas em 65.536 entradas (todas com $W_f(0)=256$, $W_f(e_0)=-256$, `104/120` de peso 2):
- `0xbf` ($a=1$, falta $d=7$): `0x363fdfbfe7fbd7edee7dffffffbfa`
- `0xef` ($a=3$, falta $d=5$): `0x77bdbbfffb7ebeffdddeffdf75dbb`
- `0xfb` ($a=5$, falta $d=3$): `0x7ffef79f67f7dffbfbcdbebfeffbc`
- `0xfe` ($a=7$, falta $d=1$): `0x7eedfbfb7f7efa77ebebebffddfef`

Logo, **todo subconjunto de até seis das oito distâncias de peso 2 possui uma testemunha C7-válida que também passa em $W_f(0)$ e $W_f(e_0)$**; qualquer exclusão universal baseada nesses testes exige **pelo menos sete distâncias**.

## Execução e Reprodução

- **Cloud Run Job**: `h16-c99-even-pairs-mh85t` (`project-342eeb2f-3c82-4897-a4d`, `us-central1`, 8 vCPUs, 4 GiB RAM, `2m51.12s` no Cloud Run, `127.82s` no script Python).
- **Reprodução**:
  ```bash
  gcloud run jobs execute h16-c99-even-pairs --region=us-central1 --project=project-342eeb2f-3c82-4897-a4d --wait
  ```
