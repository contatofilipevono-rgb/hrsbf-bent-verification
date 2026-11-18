# Máscara Conjunta de 8 Bits das Frequências de Peso 2 ($d=1..8$) em $H_{16}$ ($c_{99}=1$, C1–C7)

Investigação reproduzível sobre a existência simultânea de $|W_f(e_0 + e_d)| = 256$ para todas as oito distâncias $d=1,\dots,8$ (`0x0003`..`0x0101`), além de C7 e $|W_f(0)| = |W_f(e_0)| = 256$, reutilizando exatamente as mesmas sementes e faixas do commit `70564fa`.

## Regressão e Controle

- **Controle `0xdcc662e2c890c0324c1549b289`**: `41` órbitas longas, $W_f(0)=256$, $W_f(\text{0x0001})=256$, $W_f(\text{0x0003})=640$, $W_f(\text{0x5555})=-256$, bit 0 da máscara = `0` (**PASS**).
- **Regressão contra `70564fa`**:
  - `central_50_62`: `255.449` ocorrências (`255.449` distintas) e contadores individuais exatos `[28546, 27362, 28611, 24933, 28415, 27706, 28411, 23683]` (**PASS**).
  - `full_interior_6_106`: `179.966` ocorrências (`179.966` distintas) e contadores individuais exatos `[21284, 20958, 21217, 20026, 21189, 20899, 21382, 18076]` (**PASS**).
  - `near_dense_97_106`: `11.179` ocorrências (`11.179` distintas) e contadores individuais exatos `[1329, 1340, 1403, 1345, 1363, 1327, 1285, 1196]` (**PASS**).
  - Total global: `446.594` ocorrências (`446.593` vetores distintos).

## Resultado Principal

- **`0xff` não apareceu** na amostra (`found_0xff = false`; ausência amostral não fecha o ramo).
- **Máximo de bits ligados observados**: **7 de 8** (`mask = 0xbf`, faltando apenas `d=7` `0x0081`), encontrado em `full_interior_6_106`:
  - `0x363fdfbfe7fbd7edee7dffffffbfa` (`k_long = 91`, $W_f(0)=256$, $W_f(e_0)=-256$, `0x81 -> -64`).
- **Subconjuntos de menor cardinalidade com 0 ocorrências**: cardinalidade **6** (**13 subconjuntos** empatados: `0x5f, 0x6f, 0x77, 0x7b, 0x7d, 0xcf, 0xd7, 0xdb, 0xed, 0xf3, 0xf5, 0xfa, 0xfc`).

## Execução e Reprodução

- **Cloud Run Job**: `h16-c99-weight2-mask-74wcj` (`project-342eeb2f-3c82-4897-a4d`, `us-central1`, 8 vCPUs, 4 GiB RAM, `4m9.23s` no Cloud Run, `153.61s` no script Python).
- **Reprodução**:
  ```bash
  gcloud run jobs execute h16-c99-weight2-mask --region=us-central1 --project=project-342eeb2f-3c82-4897-a4d --wait
  ```
