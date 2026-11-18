Abaixo está o plano completo para a **Etapa C**, dividido na tradução algébrico-estrutural rigorosa das ferramentas de `c99 = 1` para `c99 = 0` (Tarefa 1) e na arquitetura mínima, determinística e auditável de fechamento computacional de $H(16,4)$ no GitHub Actions (Tarefa 2).

---

## 1. Tradução das Técnicas de `c99 = 1` para o Ramo `c99 = 0`

Para entender exatamente o que muda entre os dois ramos, convém observar a geometria das **4 órbitas curtas** dentre as 116 órbitas ($112$ regulares de tamanho $16$, $3$ antipodais de tamanho $8$ — `c99`, `c57`, `c113` — e $1$ de tamanho $4$ — `c115`):
- No ramo **`c99 = 1`**, tínhamos $L = 1$, $c_{115} = 0$, $R = 0$ e $c_{57} = c_{113} = K$. Note por que a lei quadrática T31 não criava bifurcação lá: sobre $\mathbb{F}_2$, substituir $c_{57} = K$ anula identicamente o feixe quadrático $K \oplus c_{57}K = K(1 \oplus K) \equiv 0$.
- No ramo **`c99 = 0`**, temos $L = 0$, $c_{115} = 0$, $c_{57} = c_{113}$, mas **$c_{57}$ deixa de estar travado em $K$** e **$R$ deixa de ser $0$ a priori**, restando T31:
  $$R \oplus M \oplus K(1 \oplus c_{57}) = 0 \pmod 2.$$

### 1.1. Diagonal $D_8$ e `0x5555` (Teorema 1): A Divisão Obrigatória `c57 = 0` vs `c57 = 1` (e o refinamento por $R$)

Sim, **há uma divisão estrutural inevitável em `c57 = 0` vs `c57 = 1`**, e, para restaurar a força determinística do Teorema 1 em `0x5555`, convém refiná-la pelo bit $R \in \{0,1\}$, particionando `c99 = 0` em **4 células táticas completamente linearizadas** nas macro-variáveis:

| Célula (`c99 = 0`) | Órbitas curtas $(c_{99}, c_{115}, c_{57}, c_{113})$ | T31 Linearizada | Efeito na Diagonal $D_8$ | Efeito em `0x5555` (Teorema 1) |
| :--- | :---: | :---: | :--- | :--- |
| **`B0_00`** (`c57=0, R=0`) | $(0, 0, 0, 0)$ | $M = K$ | **Todas** as 4 órbitas curtas somem: a parte pura de grau 2 dos pares antipodais $\{i, i+8\}$ em $D_8$ zera; restam apenas projeções das 112 órbitas regulares. *(Célula homogênea)* | `c99` deixa de contribuir em `0x5555` e $L=R=0$: o RHS de paridade do Teorema 1 torna-se homogêneo ($0$). |
| **`B0_01`** (`c57=0, R=1`) | $(0, 0, 0, 0)$ | $M \oplus K = 1$ | Mesma anulação total das órbitas curtas em $D_8$, mas com assimetria global forçada por $R=1$ e $M \neq K$. | $R = 1$ injeta termo constante não-nulo nas identidades espectrais acopladas a `0x5555`, quebrando a solução nula. |
| **`B0_10`** (`c57=1, R=0`) | $(0, 0, 1, 1)$ | $M = 0$ ($K$ livre) | `c57 = c113 = 1` ativa simultaneamente os pares antipodais de passo $1$ e $3 \pmod 8$, criando um *offset* quadrático fixo em $D_8$. | `c57` e `c113` não são suportados dentro de `0x5555` puro, mas entram nas derivadas/acoplamentos mistos; $R=M=0$, $K$ fica livre de T31. |
| **`B0_11`** (`c57=1, R=1`) | $(0, 0, 1, 1)$ | $M = 1$ ($K$ livre) | Mesmo *offset* não-homogêneo de `c57 = c113 = 1` em $D_8$, somado a $M=1$. | Duplamente não-homogêneo ($c_{57}=1$ e $R=M=1$); $K$ permanece livre de T31 (podendo ser ramificado se necessário). |

**Ponto crítico na célula `B0_00` (`c57 = 0, R = 0`):**
Em `c99 = 1` (e nas células `B0_01`, `B0_10`, `B0_11`), pelo menos uma constante afim vale $1$, logo o vetor nulo $\mathbf{c} = \mathbf{0}$ já viola as equações algébricas locais. Na célula **`B0_00`**, todas as equações de paridade homogêneas são satisfeitas por $\mathbf{c} = \mathbf{0}$. Portanto:
1. Em `B0_00`, varreduras puramente algébricas locais (sem condição global de peso/Walsh) **não darão UNSAT imediato**, mas extrairão o **núcleo algébrico homogêneo** (leis lineares e cláusulas binárias/ternárias exatas).
2. A exclusão de $\mathbf{c} = \mathbf{0}$ e da vizinhança de peso baixo vem da condição espectral global ($W_f(0) = \pm 2^8 \neq 2^{16}$, que impõe $\operatorname{wt}(f) \in \{32640, 32896\}$) e da varredura exaustiva em C para $k \le k_{\min}$.

---

### 1.2. Cosets de $U_4^\perp$ (`H(v) = 0`)

- As identidades $H(v) = 0$ nos cosets não-triviais de $U_4^\perp$ decorrem diretamente do balanceamento/divisibilidade da restrição a $U_4$ e **continuam valendo integralmente em `c99 = 0`**.
- **O que muda na prática:**
  1. Nas equações primitivas de $H(v) = 0$, a matriz de incidência nas 112 órbitas regulares é **idêntica** à de `c99 = 1`. Onde `c99 = 1` contribuía com paridade $1$ no lado direito (RHS), agora entra `0`.
  2. Em `c57 = 1` (`B0_10` e `B0_11`), a soma das colunas de `c57` e `c113` passa para o RHS: nos cosets onde `c57` e `c113` têm incidência ímpar combinada, surge um termo constante `1`; onde têm incidência simétrica, cancelam-se mod 2.
  3. **Cuidado de auditoria:** qualquer lei derivada em `c99 = 1` que tenha combinado `H(v) = 0` com $R = 0$ ou $c_{57} = K$ não deve ser importada manualmente; re-executa-se a eliminação de Gauss sobre $\mathbb{F}_2$ em cada uma das 4 células `B0_ij`.

---

### 1.3. Suportes `0x3f3f`, `0x5f5f`, `0x6f6f` e Subconjuntos até 7-de-8 em Peso 2

As máscaras `0x3f3f` ($d=1$), `0x5f5f` ($d=2$) e `0x6f6f` ($d=3$) representam as três órbitas diedrais de restrições 6-de-8 de pares diagonais:
- **Em `c57 = 0` (`B0_00`, `B0_01`):** como `c99 = c115 = c57 = c113 = 0`, toda a camada de órbitas curtas desaparece desses três suportes de 12 bits e de todos os subconjuntos até 7-de-8 em peso 2. A matriz local nas 112 órbitas regulares é a mesma de `c99 = 1`, apenas com RHS ajustado por `c99: 1 -> 0` (e $R$). O extrator de leis locais deve operar em modo de **extração de equações implicadas (nullspace de paridade + backbone condicional / 2-XORs)** em vez de depender apenas de refutação local.
- **Em `c57 = 1` (`B0_10`, `B0_11`):** remover 2 pares diagonais a distância $d \in \{1, 2, 3\}$ intercepta de maneira assimétrica os ciclos de passo $1$ (`c57`), passo $2$ (`c99=0`) e passo $3$ (`c113`). Assim, `0x3f3f`, `0x5f5f` e `0x6f6f` recebem constantes afins não-nulas específicas de `c57 = c113 = 1`, reproduzindo o mesmo efeito de propagação forçada e colapso de posto observado em `c99 = 1`.

---

### 1.4. Redução de Grau `Q_0x0 ^ Q_0xf` e `Q_0xf`

Em `c99 = 1`, provou-se `Q_0xf == 0` e `Q_0x0 ^ Q_0xf == 1` (logo `Q_0x0 == 1`). Como isso se traduz para `c99 = 0`?
- **O mecanismo de redução de grau sobrevive:** os monômios quadráticos nas 112 órbitas regulares dentro de `Q_0x0` e `Q_0xf` dependem apenas da estrutura combinatória dos blocos `0x0` e `0xf` módulo o ideal linear de `0x3f3f` / `0x5f5f` / `0x6f6f` / `H(v)=0`. Portanto, a soma `Q_0x0 ^ Q_0xf` **continua cancelando os termos quadráticos livres das órbitas regulares**, reduzindo-se a uma forma de grau $\le 1$ nas variáveis macro/curtas $(L, R, M, K, c_{57})$.
- **O valor do RHS muda conforme a célula:** em `c99 = 1`, $L = 1$ fixava a paridade afim em `1`. Em `c99 = 0` ($L = 0$):
  - Na célula homogênea `B0_00` (`c57=0, R=0, M=K=0`), como polinômios sem termo constante se anulam em $\mathbf{c} = \mathbf{0}$, não pode valer `Q_0x0 ^ Q_0xf == 1` se ambos tiverem termo constante nulo — em vez disso, a redução de grau manifesta-se como a lei homogênea **`Q_0x0 ^ Q_0xf == 0`** (ou `Q_0x0 ^ Q_0xf == α·K`, linear em $K$!), acoplando diretamente os dois invariantes quadráticos.
  - Nas células `B0_01`, `B0_10`, `B0_11` (e para `Q_0xf` isoladamente), o script de redução simbólica sobre o anel $\mathbb{F}_2[c_0,\dots,c_{115}]$ módulo o ideal local de cada célula extrai automaticamente a forma exata $\text{NF}(\mathtt{Q\_0xf})$ e $\text{NF}(\mathtt{Q\_0x0} \oplus \mathtt{Q\_0xf}) \in \{0, 1, K, 1 \oplus K\}$.

---

## 2. Roteiro Mínimo e Auditável para Fechar `c99 = 1` + `c99 = 0` (Python / C / SAT + GitHub Actions)

Para fechar $H(16,4)$ sem nenhuma lacuna de confiança (*zero trust gap*), o pipeline deve tratar as **5 células exaustivas e mutuamente exclusivas** sob o mesmo código-fonte parametrizado:
$$\mathcal{C} = \{\mathtt{B1}\ (c_{99}=1),\ \mathtt{B0\_00},\ \mathtt{B0\_01},\ \mathtt{B0\_10},\ \mathtt{B0\_11}\}.$$

### 2.1. Arquitetura Mínima de Scripts (6 Estágios `S0`–`S5`)

1. **`scripts/s00_build_model.py` (Python puro — Fonte Única de Verdade)**
   - Constrói do zero as 116 órbitas de $\binom{\mathbb{Z}_{16}}{4}$, verifica os tamanhos ($112 \times 16 + 3 \times 8 + 1 \times 4 = 1820$), exporta as tabelas exatas de incidência para $D_8$, `0x5555`, `0x3f3f`, `0x5f5f`, `0x6f6f`, cosets de $U_4^\perp$ e expressões ANF de $(L, R, M, K, \mathtt{Q\_0x0}\dots\mathtt{Q\_0xf})$.
   - Re-prova simbolicamente **T20** (`L = c99`, `c115 = 0`, `c57 = c113`) e **T31** (`R=0, c57=K` em `c99=1`; `R + M + K + c57*K = 0` em `c99=0`), gerando `artifacts/model_manifest.json` com hashes SHA-256.

2. **`scripts/s01_extract_cell_laws.py` (Python + GF(2)/ANF Symbolic Reducer)**
   - Recebe `--cell {B1, B0_00, B0_01, B0_10, B0_11}`.
   - Aplica em sequência auditável: (i) Teorema 1 em `0x5555`, (ii) subconjuntos até 7-de-8 em peso 2 sobre $D_8$, (iii) extração exata em `0x3f3f`, `0x5f5f`, `0x6f6f`, (iv) cosets $U_4^\perp$ (`H(v)=0`), e (v) redução simbólica de `Q_0xf` e `Q_0x0 ^ Q_0xf`.
   - **Certificado emitido:** `laws_<cell>.json` contendo o sistema linear escalonado (Gauss-Jordan em $\mathbb{F}_2$), as equações quadráticas reduzidas (incluindo 2-XOR/2-SAT implicadas) e a **matriz testemunha de derivação** $W_{\text{cell}}$ que prova que cada linha linear é combinação explícita de restrições primitivas.

3. **`src/s02_boundary_sweep.c` (C11 + SIMD/OpenMP — Fronteiras de Peso $k$)**
   - Varre exaustivamente os pesos extremos nas 112 órbitas regulares: **`k <= 5`** (incluindo $k=0$ em `B0_00`, descartado instantaneamente por $W_f(0) = \pm 256$) e **`k >= 107`** ($112 - 5$) para cada uma das 5 células.
   - Usa as equações lineares de `s01` para podar o espaço de busca (fixando pivôs em $O(1)$ por *bitmask* de 64 bits) e aplica teste incremental de paridade de subespaços + FWHT rápida de 16 bits (`65536` pontos) apenas nos candidatos sobreviventes ao filtro linear.
   - **Certificado emitido:** `boundary_<cell>.log` + JSON com contagem determinística de combinações visitadas por $k \in [0,5] \cup [107,112]$, zero sobreviventes e hash do binário/input.

4. **`scripts/s03_encode_cnf.py` (Gerador DIMACS CNF Puro + Quebra de Simetria Verificada)**
   - Codifica a faixa central **`6 <= k <= 106`** de cada célula para DIMACS CNF **puro** (sem depender de extensões XOR proprietárias no certificado final, convertendo XORs em cláusulas CNF via variáveis auxiliares de Tseitin com corte $\le 4$ e restrição de cardinalidade $6 \le k \le 106$ por *Sequential Counter* / *Totalizer*):
     - Inclui todas as leis lineares e quadráticas reduzidas de `s01` (`Q_0xf`, `Q_0x0 ^ Q_0xf`, `0x3f3f/0x5f5f/0x6f6f`, `H(v)=0`, $D_8$, `0x5555`).
     - **Quebra de simetria residual ($\mathbb{Z}_{16}^\times$):** os multiplicadores $m \in \{3, 5, 7, 9, 11, 13, 15\} \pmod{16}$ permutam as 112 órbitas regulares preservando `c99`, `c115` e o par `c57 = c113` (logo preservam cada célula!). Adicionar cláusulas lexicográficas $\mathbf{c} \le_{\text{lex}} \pi_m(\mathbf{c})$ reduz o espaço de busca SAT em até $8\times$ de forma 100% compatível com LRAT.

5. **`scripts/s04_solve_cegar_lrat.sh` + `src/fwht_verifier.c` (CaDiCaL + CEGAR Espectral + `cake_lpr` / `lrat-check`)**
   - Resolve cada `cell.cnf` com **CaDiCaL** emitindo prova **LRAT** (ou DRAT convertida via `drat-trim -L`):
     - **Caso A (UNSAT algébrico direto):** as leis necessárias já são inconsistentes em $6 \le k \le 106$; o CaDiCaL gera `proof_<cell>.lrat` diretamente.
     - **Caso B (Sobreviventes algébricos refutados por Walsh/CEGAR):** se o CNF das condições necessárias admitir modelos candidatos $\mathbf{c}^{(j)}$, o *loop* C (`fwht_verifier.c`, $< 0.1\text{ ms}$ por FWHT de $2^{16}$) calcula $W_f(u)$, encontra um ponto testemunha $u_j \in \mathbb{F}_2^{16}$ com $|W_f(u_j)| \neq 256$ (ou um subespaço cuja identidade de divisibilidade falha), registra a tupla $(\mathbf{c}^{(j)}, u_j, W_f(u_j))$ em `walsh_refutations_<cell>.json`, adiciona a cláusula bloqueadora de $\mathbf{c}^{(j)}$ ao CNF de enumeração exaustiva e ao final certifica via LRAT que **não existem outros modelos além da lista finita explicitamente refutada por Walsh**.
   - Se alguma célula (`B0_00` ou `B0_10`/`B0_11` com $K \in \{0,1\}$) exceder 20 minutos, particiona-se em *cubes* explícitos (ex.: bit $K \in \{0,1\}$ e faixas de peso $k \in [6,35], [36,76], [77,106]$), cada qual com seu próprio `.lrat`.

6. **`scripts/s05_master_audit.py` (Verificador Independente Minimalista)**
   - Script pequeno ($\sim 300$ linhas, sem dependências externas pesadas) + binário verificado `lrat-check` / `cake_lpr` + 80 linhas de C puro para FWHT:
     1. Confere que a disjunção `B1 ∨ B0_00 ∨ B0_01 ∨ B0_10 ∨ B0_11` mais T20/T31 cobre $\{0,1\}^{116}$ sem brechas.
     2. Confere que $[0,5] \cup [6,106] \cup [107,112] = [0,112]$ em todas as células.
     3. Audita os certificados lineares/quadráticos de `s01`, a validade dos automorfismos $\mathbb{Z}_{16}^\times$ nas cláusulas de simetria de `s03`, cada testemunha $( \mathbf{c}^{(j)}, u_j )$ de `walsh_refutations_<cell>.json` (recalculando $W_f(u_j)$ do zero) e valida 100% dos arquivos `.lrat`.

---

### 2.2. Pipeline Reproduzível no GitHub Actions (`.github/workflows/close_h16_4.yml`)

```yaml
name: Close H(16,4) - Full Audit (c99=1 & c99=0)

on:
  push:
  workflow_dispatch:

jobs:
  stage0_model:
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v4
      - name: Build canonical 116-orbit model & verify T20/T31
        run: python3 scripts/s00_build_model.py --out artifacts/model_manifest.json
      - uses: actions/upload-artifact@v4
        with:
          name: canonical-model
          path: artifacts/model_manifest.json

  solve_cells:
    needs: stage0_model
    runs-on: ubuntu-24.04
    strategy:
      fail-fast: false
      matrix:
        cell: [B1, B0_00, B0_01, B0_10, B0_11]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with:
          name: canonical-model
          path: artifacts/
      - name: Build C tools (boundary sweep, FWHT verifier, CaDiCaL, lrat-check)
        run: make -j$(nproc) tools
      - name: S1 - Extract exact local & quadratic laws (${{ matrix.cell }})
        run: python3 scripts/s01_extract_cell_laws.py --cell ${{ matrix.cell }}
      - name: S2 - Exhaustive C sweep k<=5 and k>=107 (${{ matrix.cell }})
        run: ./bin/s02_boundary_sweep --cell ${{ matrix.cell }} --k-low 5 --k-high 107 --threads $(nproc)
      - name: S3 & S4 - Encode CNF, Solve SAT+CEGAR & Verify LRAT (${{ matrix.cell }})
        run: bash scripts/s04_solve_cegar_lrat.sh ${{ matrix.cell }}
      - uses: actions/upload-artifact@v4
        with:
          name: cert-${{ matrix.cell }}
          path: certs/${{ matrix.cell }}/

  master_audit:
    needs: [stage0_model, solve_cells]
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with:
          path: downloaded_certs/
      - name: Compile standalone auditor (C FWHT + LRAT checker)
        run: make audit_tools
      - name: S5 - Independent end-to-end verification of H(16,4)
        run: python3 scripts/s05_master_audit.py --certs-dir downloaded_certs/ --strict
      - name: Generate SHA-256 Proof Bundle Summary
        run: sha256sum downloaded_certs/**/* >> $GITHUB_STEP_SUMMARY
```

### Ordem Recomendada de Execução Imediata
1. Rodar **`s01_extract_cell_laws.py`** nas 4 células de `c99 = 0` (`B0_00`, `B0_01`, `B0_10`, `B0_11`) e inspecionar imediatamente dois números: o **posto linear $r_{\text{cell}}$** ganho sobre as 112 órbitas regulares e as formas reduzidas exatas de **`Q_0xf`** e **`Q_0x0 ^ Q_0xf`**.
2. Rodar **`s02_boundary_sweep`** nas 4 células de `c99 = 0` para igualar a fronteira $k \le 5, k \ge 107$ já fechada em `c99 = 1`.
3. Disparar o *matrix job* `solve_cells` (`B1` + 4 células `B0_ij`) com quebra de simetria $\mathbb{Z}_{16}^\times$ e validação final `s05_master_audit.py`.