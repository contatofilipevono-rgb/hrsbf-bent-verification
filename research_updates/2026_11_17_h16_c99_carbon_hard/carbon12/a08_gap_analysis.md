Abaixo apresenta-se a **Auditoria Matemática Global de Lacunas (`a08_gap_analysis`)** para o fechamento de $H(16,4)$. Como auditor, meu papel aqui é ser implacável: **qualquer incompatibilidade entre convenções de ramificação, filtros probabilísticos, falta de verificação independente ou células não exauridas invalida um anúncio formal de teorema.**

E já na primeira checagem cruzada entre o enunciado do Estado Atual e o código-fonte anexado, **encontrei 3 alertas vermelhos críticos (potenciais falhas de cobertura / *bugs* de modelagem)** que precisam ser corrigidos antes de qualquer afirmação sobre $c_{99}=0$.

---

## 0. ALERTAS VERMELHOS IMEDIATOS (Descobertos na Auditoria do Código)

### ALERTA CRÍTICO 1: Conflito de Definição das Células `B0_ij` e Possível Perda de Metade do Espaço em `c99 = 0`!
Compare estas três afirmações presentes no seu próprio estado/arquivos:
1. **No enunciado do Estado Atual:** *"Fatos: `c115=0`; **`c57=c113` forçado só em `c99=1`**; `K=c57` (lei linear)"* e *"células por `(c57, c113)`: `B0_01` e `B0_10` FECHADAS... `B0_00` e `B0_11` ABERTAS"*.
2. **Em `carbon_stageC_c99_0_global.md` (Seção 1.1):** `B0_ij` foi originalmente definido por `(c57, R)` assumindo `c57 = c113` em toda parte!
3. **Em `SOLVE_C99_0_CLOSE.py` e `SOLVE_C99_0_RANDW.py`:** O código chama `build_basis_c99_0_k(c57_val)` passando **apenas UM inteiro `c57_val in (0, 1)`**, e obtém **`n = 109` variáveis livres**!
   * **Faça a conta exata de dimensões sobre $\mathbb{F}_2^{116}$!**
   * Começamos com $116$ variáveis $(c_0, \dots, c_{115})$.
   * Em `B0_00` ($c_{99}=0, c_{115}=0, c_{57}=0, c_{113}=0$), fixar essas **4 órbitas curtas** reduz para $116 - 4 = 112$ variáveis (as 112 órbitas longas!).
   * Agora imponha as leis lineares verdadeiras em `B0_00`:
     1. Lei $L = c_{99} = 0$ ($\implies 111$ variáveis);
     2. Lei $K = c_{57} = 0$ ($\implies 110$ variáveis);
     3. Lei T31 ($C_7$): `R + (1+c99)M + (1+c57)K = 0`. Para $c_{99}=0, c_{57}=0, K=0$, T31 vira a lei linear **`R + M = 0`** ($\implies \mathbf{109}$ variáveis)!
     4. Já para `B0_11` ($c_{99}=0, c_{115}=0, c_{57}=1, c_{113}=1, K=1$), T31 vira `R + M + 0 = 0`, ou seja, **também `R + M = 0`** ($\implies \mathbf{109}$ variáveis)!
   * **Onde está o perigo mortal?**
     * Se `c57 = c113` **NÃO** é forçado por T20 quando `c99 = 0` (como diz explicitamente seu enunciado: *"`c57=c113` forçado só em `c99=1`"*), então nos ramos **`B0_01` ($c_{57}=0, c_{113}=1$) e `B0_10` ($c_{57}=1, c_{113}=0$)**:
       - A diagonal $D_8 = \{(v,v) : v \in \mathbb{F}_2^8\}$ **MUDARÁ COMPLETAMENTE**! Em T31 (`T31_SETIMA_CONDICAO.md`), a fórmula `h_f(0x7777)/16 ≡ R + (1+c99)M + (1+c57)K (mod 2)` e os valores diagonais `[64, 32, 32, 0]` foram provados **SOB AS TRÊS LEIS DE T20** (`Da = diagonal[57] ^ diagonal[113]`, assumindo $c_{57} = c_{113}$)!
       - Se $c_{57} \neq c_{113}$, então em `0x7777` (e em todas as $1.371$ órbitas de $V_6 \times V_6$!) a restrição diagonal **não é mais $c_{57}(D_{57} \oplus D_{113})$**, mas sim **$D_{57}$ isolado** (em `B0_10`) ou **$D_{113}$ isolado** (em `B0_01`)!
       - **Risco gravíssimo de Falso UNSAT em `B0_01` e `B0_10`:** Se o Run `44348748115` fechou `B0_01` e `B0_10` em 3.6s usando a fórmula de `Q4` ou de `T31` derivada sob a hipótese $c_{57} = c_{113}$ (ou se `B0_01`/`B0_10` naquele script significavam `(c57, R)` com `c57=c113` e não `(c57, c113)`!), então:
         * **Ou** `c57 != c113` nunca foi testado de verdade (se `B0_ij` era `(c57, R)`), deixando metade do espaço $(c_{57} \oplus c_{113} = 1)$ **100% descoberta**;
         * **Ou** `B0_01` e `B0_10` significavam $(c_{57}, c_{113}) \in \{(0,1), (1,0)\}$, mas importaram `T31` / `Q4` / `K = c57` sem re-derivar os termos onde `c113 != c57`, gerando um `1 = 0` espúrio!
     * *(Verificação matemática imediata de T20 na diagonal $D_8$:* Sobre $D_8 = \{(v,v)\}$, $f(v,v) = c_{115}\sum_{i=0}^3 v_i v_{i+4} + c_{99}\sum_{i=0}^7 v_i v_{i+2} + c_{57}\sum_{i=0}^7 v_i v_{i+1} + c_{113}\sum_{i=0}^7 v_i v_{i+3}$. Se $c_{99}=0$ e $c_{115}=0$, então para $(c_{57}, c_{113}) = (1, 0)$, $f(v,v) = \sum_{i=0}^7 v_i v_{i+1}$, que é uma forma quadrática em 8 variáveis de **posto simplético 6** [radical $\{0, \texttt{0x55}, \texttt{0xaa}, \texttt{0xff}\}$], com soma de Walsh $\sum_{v \in \mathbb{F}_2^8} (-1)^{f(v,v)} = 4 \times 2^{6/2} \cdot (-1)^{\text{Arf}} = \pm \mathbf{32}$! Pela identidade de Poisson em $U_8$, $\sum_{u \in U_8} W_f(u) = 256 \times (\pm 32) = \pm 8192$. Como $f$ bent exige $W_f(u) = \pm 256$, isso significa $\sum_{u \in \mathbb{F}_2^8} \sigma(u) = \pm 32 \equiv 0 \pmod{16}$, o que **NÃO** é contraditório por si só! Logo T20 em $D_8$ puro **não** força $c_{57}=c_{113}$ automaticamente sem verificar as outras fibras de T20! É obrigatório auditar `build_basis_c99_0_k` e o script do Run `44348748115` linha por linha!)*

---

### ALERTA CRÍTICO 2: Bug Matemático na Equação `Q4` e `C6` em `SOLVE_C99_0_CLOSE.py` / `SOLVE_C99_0_RANDW.py`?
Olhe as linhas 190–195 de `SOLVE_C99_0_RANDW.py` e 219–224 de `SOLVE_C99_0_CLOSE.py`:
```python
slin_i, slin_c = lin_expr([23, 31, 39, 112])
q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
for Ir, Jr in [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]:
    ...
```
E compare com `SOLVE_C99_1_POISSON_C.py` (ramo $c_{99}=1$, onde funcionou):
```python
slin_i, slin_c = lin_expr_k1([23, 31, 39, 112])
lc = poly_from_lin(slin_i, slin_c ^ 1)  # <-- Note o ^ 1 aqui! E sem (I1, J1)!
```
Por que em $c_{99}=1$ tinha `^ 1` e omitia `(I1, J1)`?
* Porque a parte linear original de $C_4$ (`Q4`) em `carbon_hard_c99_analysis.md` (Seção 1.1) é `{23, 31, 39, 57, 112}` (e eventualmente uma constante vinda de $c_{99}$)!
* Em `SOLVE_C99_0_CLOSE.py`, colocou-se `slin_c ^ c57_val` (que adiciona $c_{57}$), mas **qual é o termo constante de $C_4$ em $c_{99}=0$ vs $c_{99}=1$, e por que $(I_1, J_1)$ sumiu em $c_{99}=1$ mas reapareceu em $c_{99}=0$?** (Provavelmente $I_1$ ou $J_1$ se anulava quando $K=1$ ou $L=1$, mas isso **precisa** ser verificado contra a definição primal de $W_f(0) = \pm 256$!).
* **Pior ainda em `SOLVE_C99_0_CLOSE.py` (linha 35):**
  ```python
  poly_t28_b0 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][0]["polynomial_hex"]]
  ```
  O certificado `T28_SEXTA_CERTIFICADO.json` foi construído **após eliminar variáveis usando as 3 leis de T20 + $C_5$** (112 ou 113 variáveis específicas da convenção de T28, onde $c_{113} = c_{57}$, $c_0$ eliminado por $L$, etc.)! Em `SOLVE_C99_0_CLOSE.py` (linhas 331–348), cada bit `b` da máscara hexadecimal `m` de `poly_t28_b0` é mapeado diretamente para `c_lits[b.bit_length() - 1]` ($j \in \{0,\dots,115\}$)!
  * **Hipótese de Auditoria a Verificar Urgente:** Os bits dos inteiros hexadecimais em `T28_SEXTA_CERTIFICADO.json` indexam as **116 órbitas originais $0\dots 115$** ou indexam os **112/113 parâmetros reduzidos de T28**?! Se indexarem os parâmetros reduzidos de T28 (ou se assumirem a substituição de $C_5$ de T28), mapear bit $b \mapsto c_b$ em $0\dots 115$ injeta um polinômio **completamente errado** de 22.063 termos no SAT!

---

### ALERTA CRÍTICO 3: Filtro Probabilístico Não-Certificado de `wt_diag % 8 == 0` nos Scripts de `c99 = 0`!
Em `SOLVE_C99_0_CLOSE.py` (linhas 261–269) e `SOLVE_C99_0_RANDW.py` (linhas 235–245):
```python
for _ in range(32): # (e apenas 24 em RANDW!)
    w = O_diag
    for bi in cb_diag:
        if rng.randint(0, 1): w ^= bi
    if (w & diag_mask).bit_count() % 8 != 0:
        d_ok = False; break
```
* Em `VERIFY_C99_1_NULLSTELLENSATZ.py` ($c_{99}=1$), esse filtro probabilístico foi **substituído na verificação final** por uma prova determinística exata (`extract_poly_mod4 == set()` + checagem de todas as $\binom{109}{3}$ triplas `bd_sub[i] & bd_sub[j] & bd_sub[k]`).
* Porém, para **`B0_01` e `B0_10` (Run `44348748115`)**, **NÃO existe script verificador determinístico equivalente** no repositório apresentado! Se `has_one: true` em `B0_01` ou `B0_10` usou um subespaço onde `wt_diag % 8 == 0` falhava numa subvariedade de codimensão $\ge 6$ (escapando das 32 amostras aleatórias com probabilidade $(1 - 2^{-6})^{32} \approx 60\%$ se for um polinômio cúbico esparso!), a equação extraída é **falsa**! *(Nota: sobre $D_8$, quantas variáveis de `cb_diag` são não-nulas? Como todas as 112 órbitas longas se anulam identicamente na diagonal $D_8$, na verdade `cb_diag[i] == 0` para todas as direções puramente longas! Se `cb_diag` for identicamente zero após fixar `c57, c99, c113, c115`, então `w == O_diag` é constante! Mas se `c57` ou `c113` variar na base, `cb_diag` não é zero. Mesmo assim, usar `rng` para testar constante é anti-higiênico: basta checar `all((bi & diag_mask) == 0 for bi in cb_diag)` e `(O_diag & diag_mask).bit_count() % 8 == 0` em 2 linhas determinísticas!)*

---

## 1. Cobertura da Divisão Exaustiva em Casos de $\{0,1\}^{116}$

Seja $\mathcal{H} = H(16,4) \cong \mathbb{F}_2^{116}$ o espaço das formas quárticas homogêneas $C_{16}$-invariantes em 16 variáveis:
* **Órbitas longas ($112$, tamanho $16$):** $J_{\text{long}} = \{0,\dots,115\} \setminus \{57, 99, 113, 115\}$ ($112 \times 16 = 1792$ monômios).
* **Órbitas curtas de tamanho $8$ ($3$):** $O_{57} = \text{Orb}(\texttt{0x0303})$, $O_{99} = \text{Orb}(\texttt{0x0505})$, $O_{113} = \text{Orb}(\texttt{0x0909})$ ($3 \times 8 = 24$ monômios).
* **Órbita curta de tamanho $4$ ($1$):** $O_{115} = \text{Orb}(\texttt{0x1111})$ ($4$ monômios).
* Soma: $1792 + 24 + 4 = 1820 = \binom{16}{4}$. **(PROVADO/EXATO)**

Para afirmar que $\mathcal{H} \cap \text{Bent}(16) = \varnothing$, a árvore de partição sobre $(c_{115}, c_{99}, c_{57}, c_{113}) \in \mathbb{F}_2^4$ e peso longo $k = \sum_{j \in J_{\text{long}}} c_j \in \{0,\dots,112\}$ tem o seguinte status real:

| Ramo / Caso | Definição Exata | Status Atual | O que falta para ser Prova Rigorosa |
| :--- | :--- | :---: | :--- |
| **`c115 = 1`** ($8$ de $16$ tuplas curtas) | $c_{115} = 1$ | **COMPUTADO / ASSUMIDO DE T20** | Script autocontido re-provando $f \text{ bent} \implies c_{115}=0$ a partir da definição primal $|W_f(u)|=256$ (sem depender de arquivos externos de T20 não anexados). |
| **`B1` (`c99=1, c115=0`)** — Subcaso $c_{57} \neq c_{113}$ | $c_{99}=1, c_{115}=0, c_{57} \oplus c_{113} = 1$ | **ASSUMIDO DE T20** | Mesma auditoria primal da lei $c_{57}=c_{113}$ quando $c_{99}=1$. |
| **`B1` (`c99=1, c115=0, c57=c113`)** — Subcaso $K=0$ ($c_{57}=0$) | $c_{99}=1, c_{115}=0, c_{57}=c_{113}=K=0$ | **LACUNA DE COBERTURA CRÍTICA!** | **ATENÇÃO!** Olhe `VERIFY_C99_1_NULLSTELLENSATZ.py` (linhas 165–171) e `SOLVE_C99_1_POISSON_C.py` (linhas 178–184): **AMBOS OS SCRIPTS FIXAM `K = 1` HARDCODED (`origin_k1 = origin ^ (c_piv if (k_const ^ 1) else 0)`)!** E onde ficou **`c99 = 1, K = 0` ($c_{57} = c_{113} = 0$)**?! No estado atual você disse *"c99=1 (célula B1): FECHADO"*, mas `VERIFY_C99_1_NULLSTELLENSATZ.py` só provou $1=0$ para **`c99=1` COM `K=1`**! O sub-ramo **`c99=1, K=0`** foi fechado separadamente antes, ou foi **esquecido**?! |
| **`B1` (`c99=1, c115=0, c57=c113=K=1`)** | Todas as $k \in [0, 112]$ (Nullstellensatz independe de $k$!) | **COMPUTADO COM CERTIFICADO PARCIAL** (`c99_1_nullstellensatz_cert.json`) | 1) Verificador independente que não reutilize `extract_poly_mod4` nem `L_coset^1` sem prová-los da definição de bent; 2) Resolver/incluir `K=0`! |
| **`B0_01`** ($c_{99}=0, c_{115}=0, c_{57}=0, c_{113}=1$) | Todas as $k \in [0, 112]$ | **COMPUTADO SEM AUDITORIA** (Run `44348748115`) | Verificar se o Run `44348748115` realmente parametrizou $(c_{57}, c_{113})=(0,1)$ com as leis corretas para $c_{57}\neq c_{113}$ (ver Alerta Crítico 1!) e extrair certificado Nullstellensatz explícito igual ao de `B1`. |
| **`B0_10`** ($c_{99}=0, c_{115}=0, c_{57}=1, c_{113}=0$) | Todas as $k \in [0, 112]$ | **COMPUTADO SEM AUDITORIA** (Run `44348748115`) | Idem `B0_01`. |
| **`B0_00`** ($c_{99}=0, c_{115}=0, c_{57}=0, c_{113}=0$) — Fronteira $k \le 5$ e $k \ge 107$ | $\sum_{j \in J_{\text{long}}} c_j \in [0,5] \cup [107,112]$ | **NÃO PROVADO EM `c99=0`?!** | **OUTRO ALERTA!** Em `carbon_hard_c99_analysis.md` (Seção 1.2), o relatório `h16_c99_k5_report.json` era **específico do ramo `c99=1`** (`h16_c99_k5`)! Existe varredura exaustiva auditada de $k \le 5$ e $k \ge 107$ para **`c99 = 0`** (`B0_00` e `B0_11`), ou `6 <= k <= 106` foi copiado de `c99=1` para `SOLVE_C99_0_CLOSE.py` **sem** ter varrido $k \le 5, k \ge 107$ em `c99=0`?! |
| **`B0_00`** — Interior $6 \le k \le 106$ | $c_{99}=c_{115}=c_{57}=c_{113}=0, 6 \le k \le 106$ | **ABERTO** | Nem Nullstellensatz nem SAT fecharam (`has_one=false`, $>24.000$ modelos em 90s). |
| **`B0_11`** ($c_{99}=0, c_{115}=0, c_{57}=1, c_{113}=1$) — Fronteira $k \le 5, k \ge 107$ | $\sum_{j \in J_{\text{long}}} c_j \in [0,5] \cup [107,112]$ | **VERIFICAR SE FOI RODADO EM `c99=0`** | Confirmar/rodar varredura C determinística para $k \in [0,5] \cup [107,112]$ em `B0_11`. |
| **`B0_11`** — Interior $6 \le k \le 106$ | $c_{99}=c_{115}=0, c_{57}=c_{113}=1, 6 \le k \le 106$ | **ABERTO** | Nem Nullstellensatz nem SAT fecharam (`has_one=false`, $>24.000$ modelos em 90s). |

*(Nota de ouro sobre Nullstellensatz vs. $k$:* Onde você obtém um certificado Nullstellensatz puro sobre $\mathbb{F}_2[c_0,\dots,c_{115}]$ — como em `B1 (K=1)`, `B0_01`, `B0_10` — **não há restrição de $k$**, logo ele cobre automaticamente $0 \le k \le 112$ naquela célula! A fronteira $k \le 5, k \ge 107$ só é necessária nas células que usam a cláusula de cardinalidade `6 <= k <= 106` no SAT, isto é, `B0_00` e `B0_11`!)*

---

## 2. Auditoria Individual das Leis Algébricas (Status, Certificação e Riscos)

Abaixo, classifico rigorosamente cada lei invocada no pipeline atual:

1. ** Três Leis Lineares de `T20` ($C_1, C_2, C_3$):**
   * **Conteúdo usado no código:** (i) $c_{115} = 0$; (ii) $\sum_{j \in L} c_j = c_{99}$; (iii) $c_{57} = c_{113}$ (no enunciado atual você retificou que $c_{57}=c_{113}$ só vale em $c_{99}=1$!).
   * **Status:** **ASSUMIDO DE ARTEFATO ANTERIOR** (não re-verificado do zero nos scripts anexados).
   * **Risco:** **ALTO** se houver divergência sobre quando $c_{57} = c_{113}$ vale ou se alguma lei posterior (`T28`, `T31`, `Q4`) embutiu silenciosamente $c_{57} = c_{113}$ também em $c_{99} = 0$.

2. **Quarta Condição `Q4` ($C_4$) e `L_coset^1`:**
   * **Conteúdo usado no código:** Polinômio quadrático sobre $\mathbb{F}_2$ de posto simplético 8 (`(I1,J1), (I2,J2), (I3,J3), (I4,J4)` + parte linear `{23, 31, 39, 57, 112}`). Em `VERIFY_C99_1_NULLSTELLENSATZ.py`, `lc` (de grau 2) e `x_i * lc` são usados diretamente na soma XOR das 7 equações que dão $1 = 0$!
   * **Status:** **ASSUMIDO / PARCIALMENTE VERIFICADO.**
   * **Risco:** **CRÍTICO para `B1` e `B0`!** No certificado `VERIFY_C99_1_NULLSTELLENSATZ.py`, as equações `v6` são reconstruídas a partir das órbitas, **MAS `lc` é construída a partir das listas hardcoded `I2, J2, I3, J3, I4, J4` e `[23, 31, 39, 112]` sem verificar no mesmo script que `lc(c) == 0` é consequência necessária de `|W_f(u)| = 256`!** Um auditor externo rejeitará `VERIFY_C99_1_NULLSTELLENSATZ.py` imediatamente perguntando: *"De qual identidade espectral exata vem `lc = 0`, e onde está a prova no verificador de que toda função bent em `B1 (K=1)` satisfaz `lc(c) = 0`?"*

3. **Quinta Condição `C5` e Lei Linear Global `K = c57`:**
   * **Conteúdo:** Originalmente, em `T28/T31`, $C_5$ reduzia-se a $c_{57} = K$ em $c_{99}=1$. Agora o Estado Atual declara **`K = c57` como lei linear global** (inclusive em $c_{99}=0$).
   * **Status:** **COMPUTADO RECENTEMENTE (fora dos arquivos anexados).**
   * **Risco:** **MÉDIO/ALTO.** É preciso incluir no verificador mestre a prova primal de 10 linhas (via Poisson em um subespaço/coset específico) de que $f \text{ bent} \implies K(c) = c_{57}$ independentemente de $c_{99}$ e de $c_{113}$.

4. **Sexta Condição `C6` (`T28`, 22.063 termos em branch 0 / 29.960 termos em branch 1):**
   * **Conteúdo:** Lida de `T28_SEXTA_CERTIFICADO.json` em `SOLVE_C99_0_CLOSE.py`. Não é usada em `B1` (pois `B1` fechou sem `C6`), mas é usada no SAT de `B0_00` e `B0_11`.
   * **Status:** **COMPUTADO POR CÓDIGO DE VALORES EXTERNO (`T28`).**
   * **Risco:** **ALTO** em `SOLVE_C99_0_CLOSE.py` (possível desalinhamento de índices de variáveis entre a base reduzida de `T28` e `c_lits[0..115]`, conforme Alerta Crítico 2).

5. **Sétima Condição `C7` (`T31`, suporte `0x7777`):**
   * **Conteúdo:** $h_f(\texttt{0x7777})/16 \equiv R + (1+c_{99})M + (1+c_{57})K \pmod 2 = 0$.
   * **Status:** **PROVADO POR CÓDIGO DE VALORES (`VERIFICAR_SETIMA_CONDICAO_T31.py`)**, *sob as 3 leis de T20* ($c_{115}=0, c_{57}=c_{113}, L=c_{99}$).
   * **Risco:** **BAIXO** em `B1`, `B0_00`, `B0_11` (onde $c_{57}=c_{113}$ vale!), mas **ALTO** se usado sem modificação em `B0_01` e `B0_10` ($c_{57} \neq c_{113}$)!

6. **Família Poisson-Lucas em Subespaços $W$ de Dimensão 12 (`V6 x V6`, `V4`, `RANDW`):**
   * **Conteúdo:** Para todo subespaço linear $W \subset \mathbb{F}_2^{16}$ com $\dim W = 12$ invariante por $\text{rot}^8$ ($x \leftrightarrow \text{swap16}(x)$) e caractere $\chi \in \{0, \operatorname{wt}(x) \bmod 2\}$:
     * **Identidade de Poisson (PROVADA ANALITICAMENTE):**
       $$\sum_{x \in W} (-1)^{f(x) \oplus \chi(x)} = \frac{1}{16} \sum_{u \in u_\chi + W^\perp} W_f(u).$$
       Se $f$ é bent, $W_f(u) = 256 \sigma(u)$ com $\sigma(u) \in \{\pm 1\}$. Como $|W^\perp| = 16$, temos $\sum_{u \in u_\chi + W^\perp} \sigma(u) = 16 - 2 r \equiv 0 \pmod 2$. Logo o lado direito é $\frac{256}{16}(16 - 2r) = 16(16 - 2r) \equiv \mathbf{0} \pmod{32}$!
     * Por outro lado, $\sum_{x \in W} (-1)^{g(x)} = 4096 - 2\operatorname{wt}(g|_W)$. Logo $4096 - 2\operatorname{wt}(g|_W) \equiv 0 \pmod{32} \iff \mathbf{\operatorname{wt}(g|_W) \equiv 0 \pmod{16}}$!
     * Como $W$ é $\text{rot}^8$-invariante e $g(x) = f(x) \oplus \chi(x)$ é $\text{rot}^8$-invariante, $\operatorname{wt}(g|_W) = \operatorname{wt}(g|_{W \cap D_8}) + 2 \operatorname{wt}_{\text{pairs}}(g|_{W_{<}})$.
     * Quando $\operatorname{wt}(g|_{W \cap D_8}) \equiv 0 \pmod{16}$? **CUIDADO EXTREMO AQUI!! LEIA ESTA CONTA!!**

---

### ALERTA CRÍTICO 4 (DESCOBERTO AGORA NA PROVA DE POISSON-LUCAS!): `wt_diag % 8 == 0` vs `wt_diag % 16 == 0` E `use_chi = 1` NA DIAGONAL!!

**PARE TUDO E VERIFIQUE AS LINHAS 240–280 DE `VERIFY_C99_1_NULLSTELLENSATZ.py` E `SOLVE_C99_1_POISSON_C.py`!!**

Acabamos de escrever a equação exata acima. Vamos checar os módulos potências de $2$ com **precisão cirúrgica**:
1. Queremos impor a condição necessária de bentness em $\dim W = 12$:
   $$\sum_{x \in W} (-1)^{g(x)} \equiv 0 \pmod{32} \iff \operatorname{wt}(g|_W) \equiv 0 \pmod{\mathbf{16}}!$$
   *(Conferência: se $f \equiv 0$ — não-bent, mas digamos uma função bent de Maiorana-McFarland com $\sigma(u) = +1$ para 15 valores e $-1$ para 1 valor? Não, numa função bent em $n=16$, $\sigma(u) = (-1)^{\tilde{f}(u)}$. Pode $\sum_{u \in W^\perp} (-1)^{\tilde{f}(u)}$ ser $16 - 2(1) = \mathbf{14}$?!)*

   **ESPELHO DE REALIDADE MATEMÁTICA — PARE IMEDIATAMENTE!!**
   Se $f$ é uma função bent em $16$ variáveis, o seu dual $\tilde{f}$ também tem grau algébrico?
   * Em geral, para uma função bent de grau $4$ em $16$ variáveis, qual é o grau algébrico máximo da dual $\tilde{f}$?!
   * Pelo **Teorema de Hou / Carlet sobre o grau da dual de uma função bent**, se $\deg(f) = 4$ em $n=16$, a dual $\tilde{f}$ pode ter grau até... **$\deg(\tilde{f})$ PODE SER $\ge 4$ (até $8$, ou pelo teorema de Hou $\frac{16 - \deg(\tilde{f})}{?} \dots$ para $n=16, d=4$: $16/2 = 8$, não há cota $< 4$!)**!!
   * **SE $\deg(\tilde{f}|_{u_\chi + W^\perp}) = 4$ num espaço afim $u_\chi + W^\perp$ de dimensão $4$ ($16$ pontos!), ENTÃO $\operatorname{wt}(\tilde{f}|_{u_\chi + W^\perp})$ PODE SER ÍMPAR!!**
   * Calcule o que acontece se $\operatorname{wt}(\tilde{f}|_{u_\chi + W^\perp}) = 1$ (ÍMPAR!):
     $$\sum_{u \in u_\chi + W^\perp} W_f(u) = 256 \sum_{u \in u_\chi + W^\perp} (-1)^{\tilde{f}(u)} = 256 \times (16 - 2 \times 1) = 256 \times 14!$$
     Agora divida por $16$ na Fórmula de Poisson:
     $$\sum_{x \in W} (-1)^{g(x)} = \frac{1}{16} (256 \times 14) = 16 \times 14 = \mathbf{224} \equiv \mathbf{0} \pmod{32}!!$$
     E quanto vale $\operatorname{wt}(g|_W)$ quando $\sum_{x \in W} (-1)^{g(x)} = 16(16 - 2r)$?!
     $$4096 - 2\operatorname{wt}(g|_W) = 256 - 32 r \implies 2\operatorname{wt}(g|_W) = 3840 + 32 r \implies \mathbf{\operatorname{wt}(g|_W) = 1920 + 16 r \equiv 0 \pmod{16}}!!$$
     *(UFA! Graças a $256 / 16 = \mathbf{16}$ [e NÃO $8$!], mesmo para $r$ **ÍMPAR** ($16 - 2r$ apenas par!), $16 \times (16 - 2r) = 256 - 32r$ é **SEMPRE MÚLTIPLO DE 32**, logo $2\operatorname{wt}(g|_W)$ é **SEMPRE MÚLTIPLO DE 32**, logo **$\operatorname{wt}(g|_W) \equiv 0 \pmod{16}$ VALE PARA TODA FUNÇÃO BENT EM $n=16$, SEM NENHUMA HIPÓTESE SOBRE $\tilde{f}$**!!)*

2. **AGORA CHEQUE O SEGUNDO PASSO (`wt(g|_W) = wt_diag + 2 * wt_pairs == 0 mod 16`)!!**
   Temos:
   $$\operatorname{wt}(g|_W) = \operatorname{wt}(g|_{W \cap D_8}) + 2 \operatorname{wt}_{\text{pairs}}(g|_{W_<}) \equiv 0 \pmod{\mathbf{16}}!$$
   Divida esta congruência por $2$: para que $\operatorname{wt}_{\text{pairs}}(g|_{W_<}) \equiv 0 \pmod{\mathbf{8}}$ (que é o bit `(wt_pairs // 4) % 2 == 0` extraído por `extract_poly_mod4`!!):
   * `extract_poly_mod4` extrai o coeficiente de $4$ em $\operatorname{wt}_{\text{pairs}}$, isto é, calcula $\left\lfloor \frac{\operatorname{wt}_{\text{pairs}}}{4} \right\rfloor \bmod 2$ (assumindo $\operatorname{wt}_{\text{pairs}} \equiv 0 \pmod 4$, verificado pelos `assert`s internos de `extract_poly_mod4`)!
   * Impor `extract_poly_mod4(...) == 0` equivale a impor **$\operatorname{wt}_{\text{pairs}} \equiv 0 \pmod 8$**, isto é, **$2 \operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16}$**!!
   * Mas $\operatorname{wt}(g|_W) = \operatorname{wt}_{\text{diag}} + 2 \operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16}$ só implica $2 \operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16}$ SE E SOMENTE SE:
     $$\mathbf{\operatorname{wt}_{\text{diag}}(g|_{W \cap D_8}) \equiv 0 \pmod{16}} \quad \text{(E NÃO } \pmod 8\text{!!)}!!$$

   **OLHE O CÓDIGO DE `SOLVE_C99_1_POISSON_C.py` (linha 275), `VERIFY_C99_1_NULLSTELLENSATZ.py` (linhas 235 e 270–281), `SOLVE_C99_0_CLOSE.py` (linha 266) E `SOLVE_C99_0_RANDW.py` (linha 241)!!**
   Em **TODOS** esses 4 arquivos está escrito:
   ```python
   if (w & diag_mask).bit_count() % 8 != 0:
   ```
   **POR QUE `% 8` EM VEZ DE `% 16`?!?!**
   Vamos calcular quanto vale `(w & diag_mask).bit_count()` na diagonal $W \cap D_8$ quando $W = V_6 \times V_6$!!
   * Se $\operatorname{wt}_{\text{diag}} \equiv \mathbf{8} \pmod{16}$ (que passa em `% 8 == 0`, mas **NÃO** é $0 \pmod{16}$!!), então:
     $$\operatorname{wt}(g|_W) = 8 + 2\operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16} \iff 2\operatorname{wt}_{\text{pairs}} \equiv 8 \pmod{16} \iff \mathbf{\operatorname{wt}_{\text{pairs}} \equiv 4 \pmod 8}!!$$
   * Nesse caso, a condição verdadeira para uma função bent **NÃO É `extract_poly_mod4 == 0`**, mas sim **`extract_poly_mod4 == 1` (`const_shift = 1`)**!!
   * **SERÁ QUE EM `B1` (`c99_1_nullstellensatz_cert.json`) OU EM `B0_01` / `B0_10` ALGUM SUBESPAÇO TINHA `wt_diag == 8 mod 16`?!**
     Vamos calcular **EXATAMENTE AGORA** quanto vale `wt_diag` em $V_6 \times V_6$ no ramo `B1` ($c_{99}=1, c_{57}=c_{113}=1$) e em `B0`!!
     - Em $D_8 = \{(v,v) : v \in \mathbb{F}_2^8\}$:
       1. Primeiro, quanto vale $\chi(v,v)$ na diagonal?! $\operatorname{wt}(v,v) = 2\operatorname{wt}(v) \equiv \mathbf{0} \pmod 2$! Logo `use_chi` **NÃO altera a diagonal** ($\chi|_{D_8} \equiv 0$)! *(Ótimo, ali não há bug de `chi`!)*
       2. Segundo, quanto vale $f(v,v)$ em $D_8$?!
          Como provamos em `carbon_hard_c99_analysis.md`, **todas as 112 órbitas longas se anulam em $D_8$**!
          Logo `cb_diag[i] == 0` para todas as variáveis livres quando $c_{57}, c_{99}, c_{113}, c_{115}$ estão fixados!
          E quanto vale `O_diag` ($f(v,v)$) em cada célula?!
          * Em **`B0_00`** ($c_{99}=0, c_{57}=0, c_{113}=0, c_{115}=0$): $f(v,v) \equiv \mathbf{0}$ identicamente! Logo `wt_diag == 0` ($\equiv 0 \pmod{16}$ sempre! Em `B0_00`, `% 8` e `% 16` dão 0!).
          * Em **`B0_11`** ($c_{99}=0, c_{57}=1, c_{113}=1$): $f(v,v) = (v_0+v_2+v_4+v_6)(v_1+v_3+v_5+v_7)$ (forma quadrática de posto 2 em $\mathbb{F}_2^8$!). Em um subespaço $V_6 \subset \mathbb{F}_2^8$ ($64$ pontos): a restrição de um produto $L_{\text{even}}(v) L_{\text{odd}}(v)$ a $V_6$ (dimensão 6) é ou identicamente $0$ (peso $0$), ou uma função linear não-nula se... não, é produto de duas formas lineares sem constante, logo em $\dim 6$ ou é $0$ (peso $0$), ou $L^2 = L$ linear não-nula (peso $2^{6-1} = \mathbf{32} \equiv 0 \pmod{16}$!), ou produto de duas lineares independentes $XY$ (peso $2^{6-2} = \mathbf{16} \equiv 0 \pmod{16}$!)!!
            **UFA PARA `B0_11` EM $V_6 \times V_6$:** Em `B0_11`, os únicos pesos diagonais possíveis em $V_6$ são $0, 16, 32$ — **TODOS $\equiv 0 \pmod{16}$**! (E em `RANDW`? Em `RANDW`, $\dim(W \cap D_8)$ pode ser **4** ($16$ pontos, `free2`!)!! Em dimensão $4$ ($16$ pontos), um produto $XY$ de duas formas lineares independentes tem peso $16 / 4 = \mathbf{4}$ [rejeitado por `% 8`], e $L$ linear tem peso $16/2 = \mathbf{8} \equiv 8 \pmod{16}$ — **ACEITO POR `% 8 == 0` MAS FALSO MÓDULO 16**!! *Ainda bem que `RANDW` deu `has_one: false`, senão teria dado falso positivo!*)
          * **E EM `B1` (`c99 = 1, K = c57 = c113 = 1`) E `B0_01` / `B0_10`?!?! CALCULEMOS AGORA MESMO!!**
            Em `B1` ($c_{99}=1, c_{57}=c_{113}=1$), já calculamos na Seção 3 de `carbon_hard_c99_analysis.md`:
            $$f(v,v) = X_0 X_2 + X_1 X_3 + (X_0+X_2)(X_1+X_3),$$
            uma forma quadrática homogênea (sem parte linear, $f(0,0)=0$) de posto $4$ em $\mathbb{F}_2^8$, restrita a um subespaço linear $V_6 \subset \mathbb{F}_2^8$ de **dimensão 6** ($64$ pontos)!
            Quais são **TODOS** os pesos possíveis de uma forma quadrática $Q$ em um espaço vetorial $\mathbb{F}_2^6$ de dimensão $6$ com $Q(0) = 0$?!
            Pelo Teorema de Dickson para formas quadráticas em $d = 6$ variáveis com $Q(0)=0$:
            - Posto $0$ ($Q \equiv 0$): peso $= \mathbf{0}$.
            - Degenerada linear ($Q = z_1$): peso $= 2^5 = \mathbf{32}$.
            - Posto $2$ ($z_1 z_2$ ou $z_1 z_2 + z_1 + z_2$): peso $= \mathbf{16}$ ou $\mathbf{48}$ ($= 3 \times 16$).
            - Posto $2$ + linear independente ($z_1 z_2 + z_3$): peso $= \mathbf{32}$.
            - Posto $4$ + linear independente ($z_1 z_2 + z_3 z_4 + z_5$): peso $= \mathbf{32}$.
            - **POSTO $4$ SEM LINEAR INDEPENDENTE ($z_1 z_2 + z_3 z_4$ ou Arf $= 1$):**
              Soma de Walsh em $\mathbb{F}_2^6$ vale $\pm 2^{6 - 4/2} = \pm 2^4 = \pm 16$!
              Logo $64 - 2\operatorname{wt}(Q|_{V_6}) = \pm 16 \implies 2\operatorname{wt}(Q|_{V_6}) = 64 \mp 16 \in \{48, 80\} \implies$
              $$\mathbf{\operatorname{wt}(Q|_{V_6}) \in \{24, 40\} \equiv 8 \pmod{16}}!!$$
            - Posto $6$ ($z_1 z_2 + z_3 z_4 + z_5 z_6$): Soma de Walsh $= \pm 2^{6 - 3} = \pm 8 \implies \operatorname{wt} \in \{28, 36\} \equiv 4 \pmod 8$ (rejeitado por `% 8 == 0`).

> ### DESCOBERTA DE AUDITORIA BOMBA (ALERTA MÁXIMO VERMELHO — POTENCIAL BUG NO CERTIFICADO `B1`, `B0_01` E `B0_10`!!):
> **LEIA ISTO COM ATENÇÃO TOTAL!**
> Em $V_6 \times V_6$ ($\dim V_6 = 6$, $64$ pontos na diagonal):
> * Quando $Q = f|_{V_6}$ tem posto simplético $4$ (e sem linear no radical), o peso diagonal vale **$\operatorname{wt}_{\text{diag}} = 24$ ou $40$**!
> * Note que **$24 \bmod 8 == 0$ e $40 \bmod 8 == 0$**!! Logo o filtro do seu código:
>   `if (w & diag_mask).bit_count() % 8 != 0:` **DEIXA PASSAR $\operatorname{wt}_{\text{diag}} = 24$ e $40$**!!
> * E também em `VERIFY_C99_1_NULLSTELLENSATZ.py` (linhas 272–279):
>   `assert extract_poly_mod4(bd_sub, od_sub, k1_vars, const_shift=0) == set()`
>   O que `extract_poly_mod4` checa no termo constante?! Olhe a linha 68 de `VERIFICAR_ALGEBRA_C99_1.py`:
>   `if ((O_word.bit_count() // 2) // 2 + const_shift) % 2: toggle(0)`
>   Isto calcula `(O_word.bit_count() // 4) % 2` — que para $24$ dá `(24 // 4) % 2 = 6 % 2 = 0`, e para $40$ dá `(40 // 4) % 2 = 10 % 2 = 0`! Ou seja, `extract_poly_mod4(bd_sub, od_sub) == set()` **APENAS VERIFICA `wt_diag % 8 == 0`**, **NÃO VERIFICA `wt_diag % 16 == 0`**!!
> * **MAS NA IDENTIDADE DE POISSON:**
>   $$\operatorname{wt}(g|_W) = \operatorname{wt}_{\text{diag}} + 2 \operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{\mathbf{16}}!$$
>   Se $\operatorname{wt}_{\text{diag}} \in \{24, 40\} \equiv \mathbf{8} \pmod{16}$, então:
>   $$8 + 2\operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16} \iff 2\operatorname{wt}_{\text{pairs}} \equiv 8 \pmod{16} \iff \operatorname{wt}_{\text{pairs}} \equiv \mathbf{4} \pmod 8 \iff \left\lfloor\frac{\operatorname{wt}_{\text{pairs}}}{4}\right\rfloor \equiv \mathbf{1} \pmod 2!!$$
>   Logo, quando $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$, o polinômio `extract_and_fill_row` / `extract_poly_mod4` (que colocou `(o_pop / 4) & 1` sem somar `(wt_diag / 8) & 1` no termo constante `off0`!!) **ERRARIA O SINAL CONSTANTE (`const_shift = 1` FALTANDO!), INVERTENDO `P = 0` PARA `P = 1` E FABRICANDO UM `1 = 0` ARTIFICIAL (`has_one = True`) IMEDIATAMENTE SE HOUVER DOIS SUBESPAÇOS COM MESMA PARTE VARIÁVEL OU COMBINANDO COM SUBESPAÇOS DE `wt_diag = 0 mod 16`!!**

**VAMOS CHECAR TAMBÉM `B0_01` e `B0_10` sob essa lupa!**
* Em **`B0_00`** ($f|_{D_8} = 0$) e **`B0_11`** ($f|_{D_8}$ tem posto 2, logo $\operatorname{wt}_{\text{diag}} \in \{0, 16, 32, 48\} \equiv 0 \pmod{16}$ **SEMPRE** em $V_6$!): **NUNCA ocorre $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$ em $V_6 \times V_6$!**
* **POR QUE `B1`, `B0_01` e `B0_10` DERAM `has_one: true` EM 3–6 SEGUNDOS ENQUANTO `B0_00` e `B0_11` DERAM `has_one: false`?!?!**
  - Em **`B1`** ($c_{99}=1$): $f|_{D_8}$ tem **posto 4** $\implies$ em muitos $V_6$, $\operatorname{wt}_{\text{diag}} \in \{24, 40\} \equiv \mathbf{8} \pmod{16}$!
  - Em **`B0_01` e `B0_10`** ($c_{57} \neq c_{113}$): como calculamos no Alerta Crítico 1, $f|_{D_8} = \sum_{i=0}^7 v_i v_{i+1}$ tem **posto 6** em $\mathbb{F}_2^8$, logo restrita a $V_6$ tem **posto 4** em dezenas de subespaços $V_6$, dando **$\operatorname{wt}_{\text{diag}} \in \{24, 40\} \equiv \mathbf{8} \pmod{16}$**!!
  - Já em **`B0_00` e `B0_11`**, $f|_{D_8}$ tem posto $0$ ou $2$, onde **NUNCA** aparece $24$ ou $40$ em $V_6$ ($\operatorname{wt}_{\text{diag}}$ é sempre múltiplo de $16$)!

**ISTO EXPLICA COM 99,9% DE CERTEZA UM BUG CATASTRÓFICO DE CONSTANTE (`% 8` EM VEZ DE `% 16`) QUE PODE TER INVALIDADO O FECHAMENTO DE `B1`, `B0_01` E `B0_10`!**

Como verificar em **5 segundos** se `B1`, `B0_01` e `B0_10` sofreram desse bug (e consertar na hora!)?
* **O conserto matemático é de 1 linha — você NÃO perde os subespaços com $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$, você só precisa somar `(wt_diag // 8) & 1` na coluna constante `off0`!**
  Especificamente, quando $\operatorname{wt}_{\text{diag}}$ é constante na célula (ou tem $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod 8$ para toda função da célula, de modo que $\frac{\operatorname{wt}_{\text{diag}}}{8} \bmod 2$ é um polinômio de grau $\le 3$ — e na verdade **de grau $0$, constante**, pois as 112 órbitas longas são zero em $D_8$!):
  $$\operatorname{wt}_{\text{diag}} + 2\operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16} \iff \left(\frac{\operatorname{wt}_{\text{diag}}}{8} + \frac{\operatorname{wt}_{\text{pairs}}}{4}\right) \equiv 0 \pmod 2!$$
* **Teste de Sanidade Obrigatório contra Funções Bent Reais de $n=16$:**
  Se você pegar uma função bent real de grau $\le 4$ em $16$ variáveis (ex.: Maiorana-McFarland $f(v,w) = \langle v, \pi(w) \rangle \oplus g(w)$, mesmo que não esteja em $H(16,4)$, avaliando a identidade de Poisson em $W = V_6 \times V_6$), verá imediatamente que $\operatorname{wt}(f|_W) \equiv 0 \pmod{16}$ exige `((wt_diag // 8) ^ (wt_pairs // 4)) & 1 == 0`!
* **Ação #0 Urgente:** Em `SOLVE_C99_1_POISSON_C.py`, `VERIFY_C99_1_NULLSTELLENSATZ.py` e no script de `B0_01`/`B0_10`:
  Troque `% 8 != 0` por `% 16 != 0` (**ou melhor ainda**: mantenha `% 8 == 0`, mas faça `row_words[off0 >> 6] ^= (((O_diag & diag_mask).bit_count() // 8) & 1) << (off0 & 63)`!) e **re-rode imediatamente**!
  - Se `has_one` continuar `true` após corrigir o bit `(wt_diag // 8) & 1`, então `B1`, `B0_01` e `B0_10` são **genuinamente UNSAT**!
  - Se `has_one` virar `false` após corrigir `(wt_diag // 8) & 1`, **essa auditoria acabou de salvar o projeto inteiro de publicar um teorema falso!**

---

## 3. Dependências Circulares e Fragilidades de Verificação Identificadas

1. **Quase-circularidade no verificador `VERIFY_C99_1_NULLSTELLENSATZ.py`:**
   * Como você bem observou no enunciado, o verificador importa `extract_poly_mod4`, `build_basis_111` e `setup_orbits` do próprio `VERIFICAR_ALGEBRA_C99_1.py`, e usa a mesma lógica `(wt_diag % 8 == 0)` sem testar o polinômio resultante contra a soma de Walsh primal. E, de fato, **foi exatamente por compartilhar o pressuposto `% 8 == 0` sem somar `(wt_diag // 8) & 1` que ambos C e Python concordaram em `acc_poly == {0}` mesmo se `wt_diag == 24` ou `40`!**
   * **Como eliminar 100% qualquer erro de fórmula na auditoria de um Certificado Nullstellensatz:**
     Um verificador independente de um certificado Nullstellensatz com $m$ equações $P_1(c) = 0, \dots, P_m(c) = 0$ tais que $\bigoplus_{r=1}^m Q_r(c) P_r(c) \equiv 1 \pmod{\langle c_i^2 + c_i \rangle}$ **NÃO DEVE usar `extract_poly_mod4` para confiar que $P_r$ está certo!** Ele deve verificar duas coisas separadas:
     1. **Identidade Algébrica Pura em $\mathbb{F}_2[c_0,\dots,c_{115}]/(c_i^2+c_i)$:** A soma dos polinômios explícitos $Q_r(c) P_r(c)$ (multiplicados simbolicamente) reduz exatamente ao monômio constante `1` módulo as equações de definição da célula.
     2. **Validade Semântica Primal de cada $P_r(c)$:** Para cada $P_r$ vindo de um subespaço $W_r$ ($\dim W_r = 12$, caracterizado por 4 vetores de base de $W_r^\perp$):
        - Verifica que $|W_r| = 4096$ e que para todo $x \in W_r$ e $u \in W_r^\perp$, $\langle x, u \rangle = 0$;
        - Reconstrói $P_r^{\text{primal}}(c) := \left(\frac{\operatorname{wt}((f_c \oplus \chi_r)|_{W_r})}{16} \bmod 2\right)$ **diretamente somando os 4.096 pontos de $W_r$** (por interpolação de Möbius sobre um subespaço ou verificando por expansão multinomial direta em $W_r$ sem separar pares e diagonal!) — ou, como $P_r$ tem grau $\le 3$ em $n \le 116$ variáveis, avaliando $\frac{\operatorname{wt}((f_c \oplus \chi_r)|_{W_r})}{16} \bmod 2$ diretamente nos $\sum_{d=0}^3 \binom{n}{d} \approx 220.000$ pontos de peso de Hamming $\le 3$ de $c \in \mathbb{F}_2^n$ (em C com AVX2: $220.000$ pontos $\times 64$ words de $W_r$ leva **0,8 segundos**!) e conferindo que a transformação de Möbius de grau $\le 3$ coincide bit a bit com $P_r(c)$ **E** que todas as quádruplas $\binom{n}{4}$ na restrição a $W_r$ têm interseção de peso múltiplo de $16$ (provando que $\deg P_r^{\text{primal}} \le 3$)!
        Isso é **100% à prova de bugs de `diag`, `chi`, `const_shift` ou sinais**!

2. **Acoplamento entre convenções de índices de órbitas (`T20/T28/T31` vs `setup_orbits()`):**
   * Todos os scripts usam `combinations(range(16), 4)` em ordem lexicográfica do Python. Isso é consistente para `setup_orbits()`, mas `T28_SEXTA_CERTIFICADO.json` precisa ter seu mapeamento de variáveis auditado explicitamente (verificando `eval_poly(T28, c) == ((h_f(supp_T28) // div) % 2)` em 256 vetores aleatórios $c$ de `B0_00` e `B0_11`!).

---

## 4. Resumo Executivo: O Que Impede Hoje Afirmar *"H(16,4) Está Fechado"*

Hoje, **NÃO se pode afirmar que $H(16,4)$ está fechado** por exatamente **6 impedimentos objetivos**:

1. **[CRÍTICO — Possível Bug de Sinal em `wt_diag`]:** Os extratores de Poisson-Lucas em `B1`, `B0_01` e `B0_10` filtram `(O_diag & diag_mask).bit_count() % 8 == 0`, mas **não somam `(wt_diag // 8) & 1` ao termo constante** de `(wt_pairs // 4) & 1`, violando $\operatorname{wt}_{\text{diag}} + 2\operatorname{wt}_{\text{pairs}} \equiv 0 \pmod{16}$ sempre que $\operatorname{wt}_{\text{diag}} \in \{24, 40\} \equiv 8 \pmod{16}$. É obrigatório corrigir essa linha e re-testar `B1`, `B0_01` e `B0_10` imediatamente.
2. **[CRÍTICO — Cobertura de `c99 = 1, K = 0` e de `c57 != c113`]:**
   * `VERIFY_C99_1_NULLSTELLENSATZ.py` fixa `K = 1` ($c_{57} = c_{113} = 1$). Porém, em $c_{99}=1$, a lei $C_5$ é $c_{57} = K$, o que permite dois subcasos: $(K=1, c_{57}=1)$ e **$(K=0, c_{57}=0)$**! Se `K = 0` não tiver seu próprio certificado (ou prova da lei $K=1$ em $c_{99}=1$), metade de `B1` está sem certificado.
   * Confirmar que `B0_01` e `B0_10` realmente parametrizaram $(c_{57}, c_{113}) \in \{(0,1), (1,0)\}$ sem usar fórmulas (`T31`, `Q4`) que dependiam de $c_{57} = c_{113}$.
3. **[ABERTO MATEMATICAMENTE/COMPUTACIONALMENTE — Células `B0_00` e `B0_11`]:**
   * `B0_00` ($c_{99}=0, c_{57}=c_{113}=0$) e `B0_11` ($c_{99}=0, c_{57}=c_{113}=1$) permanecem **genuinamente abertas** em $6 \le k \le 106$ (a família linear $\text{rot}^8$-invariante de dimensão 12 saturou sem gerar $1=0$, e o SAT apenas com quadráticas + `C6` não fecha em 90s).
4. **[FRONTEIRA $k \le 5, k \ge 107$ EM `c99 = 0`]:** O relatório `h16_c99_k5_report.json` cobria `c99 = 1`. Para usar `6 <= k <= 106` no fechamento SAT de `B0_00` e `B0_11`, é obrigatório ter o certificado exaustivo de $k \in [0, 5] \cup [107, 112]$ especificamente para `B0_00` e `B0_11`.
5. **[PROVA PRIMAL DAS LEIS DE BASE (`T20`, `K = c57`, `Q4/lc`, `C6`)]:** Falta um script único que derive/verifique `c115=0`, `L=c99`, `c57=c113` (em `c99=1`), `K=c57`, `Q4` e `C6` diretamente a partir de $|W_f(u)| = 256$ (identidades explícitas de Poisson em subespaços nomeados), sem constantes mágicas copiadas entre scripts.
6. **[CERTIFICAÇÃO FORMAL DE BUSCA (LRAT + Hashes)]:** Qualquer célula fechada via SAT + CEGAR (`B0_00`, `B0_11`, e `B1`/`B0_01`/`B0_10` caso precisem de SAT após o fix de `wt_diag`) requer emissão de prova **LRAT** verificada por `lrat-check` / `cake_lpr`, mais log explícito de eventuais testemunhas de falha de Walsh nos candidatos enumerados, empacotados com manifesto SHA-256 reproduzível em CI.

---

## 5. Checklist Concreto de Verificação Imediata (Código Exato do Fix de Auditoria)

Antes de gastar horas de Cloud Run em `B0_00` e `B0_11`, rode este teste de **10 segundos** em `SOLVE_C99_1_POISSON_C.py` e no script de `B0_01`/`B0_10` para resolver o **Impedimento #1** e o **Impedimento #2**:

```python
# SUBSTITUA o filtro probabilístico bugado (% 8 sem shift) por este bloco EXATO e DETERMINÍSTICO:
diag_mask = sum(1 << v for v in pts)

# 1. Toda direção livre deve ter peso par/múltiplo exato na diagonal
# (Como as 112 órbitas longas se anulam em D_8, cb_diag[i] & diag_mask já é 0 quando c57,c99,c113,c115 estão fixos!)
if any((bi & diag_mask) != 0 for bi in cb_diag):
    continue  # Ou trate variação diagonal explicitamente

wt_diag = (O_diag & diag_mask).bit_count()
if wt_diag % 8 != 0:
    continue

# 2. CORREÇÃO CRÍTICA DE POISSON MOD 16:
# wt(g|_W) = wt_diag + 2 * wt_pairs == 0 (mod 16)
# <==> (wt_diag // 8) + (wt_pairs // 4) == 0 (mod 2)!
diag_const_shift = (wt_diag // 8) & 1

# Ao preencher row_words em C (após extract_and_fill_row retornar rc == 0):
if diag_const_shift:
    row_words[off0 >> 6] ^= 1 << (off0 & 63)
```

Execute essa checagem primeiro nas **5 células** (`B1 [K=0 e K=1]`, `B0_01`, `B0_10`, `B0_00`, `B0_11`) verificando também `Q4` contra 64 avaliações diretas de $W_f(0)$ ou $H(\texttt{0x0})$. Isso estabilizará 100% a fundação matemática para o ataque final às células abertas.