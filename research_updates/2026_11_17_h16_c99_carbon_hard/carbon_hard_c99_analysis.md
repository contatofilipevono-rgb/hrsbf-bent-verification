Abaixo apresenta-se a auditoria matemática estrita e a investigação da via algébrica para exclusão do ramo $c_{99} = 1$ em $H(16,4)$, distinguindo rigorosamente fatos provados/verificados de conjecturas, testando cada hipótese intermediária contra o catálogo de testemunhas auditadas (usadas como oráculo de contraexemplos) e especificando o cálculo exato de certificação simbólica/2-ádica.

---

### 1. Auditoria Rigorosa do Estado Estabelecido no Ramo $c_{99} = 1$

Antes de propor qualquer identidade, precisamos separar o que está **provado/auditado nos artefatos fornecidos** daquilo que possui **pequenas lacunas documentais** no recorte apresentado.

#### 1.1. Estrutura algébrica de $C_1 \dots C_7$ em $c_{99} = 1$ (Provado por Código de Valores)
No espaço de $116$ órbitas rotacionais de monômios de grau $4$ em $16$ variáveis ($112$ órbitas longas de tamanho $16$, mais órbitas curtas — notavelmente $c_{99}, c_{113}, c_{115}$):
1. **As leis lineares e de fatoração ($C_1 \dots C_5$, T20/T28):**
   * Impor $c_{99} = 1$ fixa a paridade do conjunto $L$ ($|L|=16$, órbitas $\{0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106\}$) em $\sum_{j \in L} c_j \equiv 1 \pmod 2$.
   * Fixa a órbita curta $c_{115}=0$ (ou paridade associada às 3 leis T20) e $c_{113} = c_{57}$.
   * **Quinta condição ($C_5$):** No ramo $c_{99}=1$, reduz-se à lei **estritamente linear** $c_{57} \equiv \sum_{j \in K} c_j \pmod 2$, onde $|K|=32$.
   * **Quarta condição ($C_4$):** Uma forma quadrática fatorada sobre $\mathbb{F}_2$ de posto simplético $8$ ($4$ produtos disjuntos $I_r \cdot J_r$, cada lado de cardinalidade $8$, mais parte linear $\{23,31,39,57,112\}$). No ramo $c_{99}=1$, passa uma fração de $2^{-7}$ após $C_1\dots C_5$ (fração global do ramo: $1/128$ antes de $C_6, C_7$).
2. **Sétima condição ($C_7$, T31 — suporte periódico `0x7777`):**
   * **Teorema verificado (`VERIFICAR_SETIMA_CONDICAO_T31.py`):** Como $c_{99}=1 \implies 1+c_{99} \equiv 0 \pmod 2$ e $C_5 \implies c_{57} \equiv K \pmod 2$ (donde $(1+c_{57})K \equiv (1+K)K \equiv 0 \pmod 2$), a condição quadrática geral de $360$ monômios colapsa **exatamente** na lei **linear** sobre $\mathbb{F}_2$:
     $$R(c) := \sum_{j \in R} c_j \equiv 0 \pmod 2, \qquad |R| = 24,$$
     com $c_5 \in R$ livre e ausente de $C_1 \dots C_5$, dividindo o espaço sobrevivente exatamente por $2$.
3. **Sexta condição ($C_6$, T28/T32):**
   * Após eliminar $c_5$ via $C_7$, o modelo reduzido de $C_6$ no ramo $c_{99}=1$ permanece de grau superior ($29.960$ monômios antes da substituição de $c_5$). Pelos certificados T30 e T32, $C_6$ **não** elimina estados do quociente T27 isoladamente (derivada mista constante $1$ nas direções $d = e_{75}$ e $e = e_{42}+e_{81}+e_{94}+e_{106}$, que também preservam $C_7$).

#### 1.2. Fronteira Combinatória $k \le 5$ e $k \ge 107$ (`h16_c99_k5_report.json`)
* **Fato auditado:** Seja $k$ o número de órbitas longas ativas (dentre $112$, ou $108$ após fixar representantes de leis curtas — o relatório particiona por `i0 in 0..107`, indicando $112$ órbitas longas onde $k$ conta órbitas longas presentes/ausentes; note que $112 - 5 = 107$, justificando a dualidade `presentes` $k \le 5$ vs. `ausentes` $k \ge 107$).
* Em $k \in \{0,\dots,4\}$ (`1.359.552` tuplas admissíveis por lado) e $k = 5$ (`29.508.240` tuplas admissíveis por lado), **nenhuma** função bent existe (`bent_found = 0`).
* **Detalhe técnico importante da auditoria:** No relatório `h16_c99_k5_report.json`, note que `fwht_checked = 0`, enquanto `fail_hist` tem `29.508.216` no bin `"0"` e `24` no bin `"1"` (em `presentes` $k=5$). Isso significa que o filtro local pré-FWHT no script de fronteira rejeitou $100\%$ das tuplas admissíveis sem precisar chamar a FWHT completa (aqui `fail_hist` registra o índice ou estágio de falha rápida, pois `bent_candidates_verified = []`). **Pequena ressalva formal:** como o código-fonte de `h16_c99_k5` não está anexado ao prompt, a validade formal da exclusão $k \le 5 \cup k \ge 107$ depende da correção da condição de poda rápida daquele script (auditada por `validation_checks: 240`).

#### 1.3. Espectro de Peso 2 (`0x0003` a `0x0101`) e Cobertura 7-de-8
As $120 = \binom{16}{2}$ frequências $a \in \mathbb{F}_2^{16}$ de peso de Hamming $\operatorname{wt}(a)=2$ dividem-se sob rotação cíclica em **$8$ órbitas de distâncias** $d \in \{1,2,3,4,5,6,7,8\}$:
* $d=1,\dots,7$: representantes `0x0003`, `0x0005`, `0x0009`, `0x0011`, `0x0021`, `0x0041`, `0x0081` ($7$ órbitas de tamanho $16$, totalizando $112$ frequências).
* $d=8$ (antipodal): representante `0x0101` ($1$ órbita de tamanho $8$).
*(Verificação nos dados: `0x7f` passa $d=1\dots 7$ e falha $d=8$, logo `w2_120_pass_count` $= 7 \times 16 = 112$; `0xf7`, `0xfd`, `0xdf`, `0xbf` passam $6$ órbitas de tamanho $16$ e a de tamanho $8$, logo $6 \times 16 + 8 = 104$.)*

* **Auditoria das máscaras 7-de-8:**
  * Nos JSONs fornecidos no prompt estão explicitamente presentes os coeficientes hexadecimais de **5 das 8** testemunhas 7-de-8: `0xbf` ($d=7$ falha), `0xf7` ($d=4$ falha), `0x7f` ($d=8$ falha), `0xfd` ($d=2$ falha) e `0xdf` ($d=6$ falha).
  * As outras **3 máscaras ímpares** (`0xfe` [$d=1$ falha], `0xfb` [$d=3$ falha], `0xef` [$d=5$ falha]) são mencionadas no enunciado como já cobertas anteriormente (e de fato `walk_search` buscou apenas os $4$ alvos faltantes `["0xf7", "0x7f", "0xfd", "0xdf"]` porque `0x55` = bits ímpares já tinha `pass_0x55_c7 > 0` — na verdade `even_hist_c7` mostra contagens nas submáscaras pares sobre `pass_0x55_c7`, onde o índice `14` [`0b1110`] tem `1` ocorrência em `walk_search`, confirmando cobertura!). Contudo, registre-se por rigor que os hexadecimais explícitos de `0xfe`, `0xfb`, `0xef` não constam literalmente no JSON colado, embora sua existência decorra diretamente do filtro `pass_0x55_c7` + submáscaras de peso 3 em `even_hist_c7` (`idx 7, 11, 13, 14`).
* **Status de `0xff`:** `even_hist_c7[15] = 0` tanto em `directed_search` ($2.164$ sobreviventes de `0x55 + C7`) quanto em `walk_search` ($3.589$ sobreviventes de `0x55 + C7` em $7 \times 10^9$ passos). Isto é **evidência empírica fortíssima**, mas **não é prova de inexistência**, pois o espaço $C_1\dots C_7$ em $c_{99}=1$ tem tamanho $\approx 2^{116} \times \frac{5}{8 \times 128} \approx 5 \times 2^{106}$.

---

### 2. Investigação da Via Algébrica e Testes de Contraexemplo nas Testemunhas

Analisemos agora rigorosamente os fenômenos 2-ádicos revelados pelos relatórios e testemos **cada candidato a obstrução algébrica** contra as testemunhas auditadas.

#### 2.1. Fenômeno 1: Divisibilidade 2-ádica $W_f(a) \equiv 0 \pmod{128}$ vs. $64 \pmod{128}$
Em `cascade_periodic_report.json`, sobre todas as funções testadas que satisfazem $C_1\dots C_7$ (`pass_w0_we0_c7`, somando $255.449 + 179.966 + 11.179 = 446.594$ funções em três bandas de peso):
1. Para `u2_0x5555` ($\operatorname{wt}=8$, período $2$), `u4_0x1111` ($\operatorname{wt}=4$, período $4$) e `u4_w8_0x3333` ($\operatorname{wt}=8$, período $4$):
   $$W_f(a) \equiv 0 \pmod{128} \quad \text{em } \mathbf{100\%} \text{ dos casos } (446.594 / 446.594).$$
2. Para `u8_0x0101` ($d=8$) e `w2_d1_0x0003` $\dots$ `w2_d7_0x0081` ($d=1\dots 7$):
   $$W_f(a) \bmod 128 \in \{0, 64\} \quad \text{em } \mathbf{100\%} \text{ dos casos } (\text{`other`: } 0), \text{ com divisão } 50\% / 50\%.$$

**Explicação algébrica exata (e por que a camada $\bmod 128$ sozinha NÃO dá contradição imediata, mas reduz o grau):**

* **Teorema de McEliece / Valoração 2-ádica para Grau 4:** Para qualquer função booleana $f$ em $n=16$ variáveis com $\deg(f) \le 4$, o teorema clássico de divisibilidade de McEliece–Ax apenas garante $2^{\lceil 16/4 \rceil} = 2^4 = 16 \mid W_f(a)$, isto é, $W_f(a) \equiv 0 \pmod{32}$ (já que $W_f(a) = 2^{16} - 2\operatorname{wt}(f \oplus \ell_a)$ e $\operatorname{wt}(g) \equiv 0 \pmod{16}$ quando $\deg(g)\le 4$? Cuidado: um monômio de grau $4$ em $16$ variáveis tem peso $2^{16-4} = 4096$, logo $W_f(a) = 65536 - 2\operatorname{wt}(f \oplus \ell_a)$ tem valoração mínima a priori dada por $\operatorname{wt}(g) \equiv 0 \pmod{2^{\lceil 16/4 \rceil - 1}} = 8 \implies W_f(a) \equiv 0 \pmod{16}$!).
  * **Contraexemplo real nas testemunhas à divisibilidade global por 128:** Olhe para a testemunha `0xbf` (`0x363fdfbfe7fbd7edee7dffffffbfa`): nela, `w2_8_signed["0x81"] = -64`! E em `0x5f` e `0x7d`: `w2_8_signed["0x101"] = -192` ($\equiv 64 \pmod{128}$)! Em `0x77` e `0xf7`: `w2_8_signed["0x11"] = 192` e `320` ($\equiv 64 \pmod{128}$)! Em `0xf5` e `0xd7`: `704` e `448` ($\equiv 64 \pmod{128}$)!
  * Logo, sob $C_1\dots C_7$, $W_f(a)$ é **sempre múltiplo de $64$** para essas frequências ($64 \mid W_f(a)$, elevando a valoração 2-ádica em 2 bits acima do limite genérico de grau 4 graças à simetria diedral/rotacional do estabilizador de $a$ e às leis T20!).

* **Por que `0x5555`, `0x1111`, `0x3333` são $0 \pmod{128}$ sob $C_1\dots C_7$?**
  Porque o estabilizador cíclico de `0x5555` tem ordem $8$ ($\langle \rho^2 \rangle$), e o de `0x1111` e `0x3333` tem ordem $4$ ($\langle \rho^4 \rangle$). Para todo $a$ invariante por $\rho^4$ (isto é, $a = (u,u,u,u)$ com $u \in \mathbb{F}_2^4$, o subespaço periódico de período $4$, isomorfo a `0x1111 * u`), a função $f(x) + \langle a, x \rangle$ é invariante pelo grupo cíclico $C_4 = \langle \rho^4 \rangle$ de ordem $4$!
  Ao particionar $\mathbb{F}_2^{16}$ sob a ação de $\rho^4$:
  * Órbitas de tamanho $4$: contribuem múltiplos de $4$ ao peso de Hamming, logo múltiplos de $8$ a $W_f(a)$ — mas em conjunto com a involução de reversão / troca de metades $\rho^8$ ($x \leftrightarrow \rho^8(x)$, como na prova de T28/T31!), as órbitas genéricas têm tamanho $8$, e o subespaço fixo por $\rho^8$ ($\{(v,v) : v \in \mathbb{F}_2^8\}$, dimensão $8$) tem $W_{f|_{\text{fix}}}$ governado pela restrição $f(v,v)$.
  * Na restrição diagonal $x = (v,v)$, todo monômio $x_i x_j x_k x_\ell$ colapsa para grau $\le 2$ em $v \in \mathbb{F}_2^8$, exceto quando os 4 índices formam dois pares $\{i, i+8\}, \{j, j+8\}$ (que reduzem a $v_i v_j$, grau 2!). Mais ainda, como mostrado em `VERIFICAR_SETIMA_CONDICAO_T31.py`, sobre a diagonal $(v,v)$, **todas as órbitas exceto `{57, 99, 113, 115}` se anulam identicamente**! E sob as leis T20 ($c_{115}=0, c_{113}=c_{57}$), a diagonal inteira depende apenas de $c_{99}$ (pois `Da = diagonal[57]^diagonal[113]` se anula ou fixa o peso)!
  * Consequentemente, para frequências invariantes por $\rho^4$ (`0x5555`, `0x1111`, `0x3333`), a ação combinada de $\langle \rho^4 \rangle$ e das simetrias de bloco aniquila o bit de peso $64$ modulo $128$, forçando $W_f(a) \equiv 0 \pmod{128}$ identicamente sob $C_1\dots C_5$!

* **O Polinômio de Paridade de Peso 2 ($P_d(c) := \frac{W_f(e_0 + e_d)}{64} \bmod 2$):**
  Já para $a = e_0 + e_d$ ($d \in \{1,\dots,8\}$), $a$ **não** é invariante por $\rho^4$ (exceto nenhuma delas, pois $\operatorname{wt}(a)=2 < 4$), mas **toda** frequência $e_0 + e_d$ é invariante por uma **involução de reflexão** $\tau_d$ do grupo diedral $D_{16}$ ($\tau_d : i \mapsto d - i \pmod{16}$), e para $d=8$, também por $\rho^8$!
  *(Cuidado crucial! $f \in H(16,4)$ é invariante por **rotação** $C_{16}$, mas **não necessariamente por reflexão** $\tau_d$! Órbitas quirais vêm em pares $\{O, \tau(O)\}$.)*
  Mesmo sem invariância por reflexão de $f$, a decomposição $x = (v,w) \in \mathbb{F}_2^8 \times \mathbb{F}_2^8$ (ou em pares sob $\rho^8$) garante $64 \mid W_f(e_0+e_d)$ sob T20, definindo **oito polinômios booleanos bem-definidos sobre o espaço reduzido de $C_1\dots C_7$**:
  $$P_d(c) \equiv \frac{W_f(e_0 + e_d)}{64} \pmod 2, \qquad d \in \{1,2,3,4,5,6,7,8\}.$$
  Como uma função bent em $n=16$ exige $W_f(a) = \pm 256$, e $256 \equiv 0 \pmod{128}$, **bentness exige necessariamente o sistema algébrico simultâneo**:
  $$P_1(c) = P_2(c) = P_3(c) = P_4(c) = P_5(c) = P_6(c) = P_7(c) = P_8(c) = 0 \quad \text{em } \mathbb{F}_2.$$

---

#### 2.2. TESTE DE FOGO CONTRA AS TESTEMUNHAS: $P_1 = \dots = P_8 = 0$ gera contradição?

**HIPÓTESE CANDIDATA A (Obstrução $\bmod 128$ pura em peso 2):**
*Será que sob $c_{99}=1$ e $C_1\dots C_7$, existe uma relação linear ou algébrica entre $P_1,\dots,P_8$ tal que $\sum_{d \in S} P_d(c) \equiv 1 \pmod 2$, proibindo $P_1 = \dots = P_8 = 0$?*

**TESTE NAS TESTEMUNHAS AUDITADAS — REFUTAÇÃO CATEGÓRICA DA HIPÓTESE A!**
Basta calcular o vetor binário $(P_1(c), P_2(c), P_3(c), P_4(c), P_5(c), P_6(c), P_7(c), P_8(c)) = \left(\frac{W_f(e_0+e_d)}{64} \bmod 2\right)_{d=1}^8$ nas testemunhas 7-de-8 fornecidas em `search_7of8_0xff_report.json`!

Olhemos os valores exatos de `w2_8_signed` nas testemunhas `0x7f`, `0xfd`, `0xdf`:
1. **Testemunha `0x7f`** (`c = 0x7ffacd667b275bb99963c1fa99b53`):
   * `0x3`: $256$, `0x5`: $256$, `0x9`: $256$, `0x11`: $256$, `0x21`: $256$, `0x41`: $-256$, `0x81`: $256$, **`0x101`: $512$**.
   * Ora, $512 = 4 \times 128 \equiv \mathbf{0} \pmod{128}$!!
   * Portanto, para `0x7f`, temos:
     $$(P_1, P_2, P_3, P_4, P_5, P_6, P_7, P_8) = (0, 0, 0, 0, 0, 0, 0, \mathbf{0})!!$$
2. **Testemunha `0xfd`** (`c = 0x7dfbc6e96ab4ccc7522a55a9b149`):
   * Valores: $256, \mathbf{768}, 256, 256, -256, 256, 256, -256$.
   * Como $768 = 6 \times 128 \equiv \mathbf{0} \pmod{128}$, também para `0xfd` temos $(P_1,\dots,P_8) = (0,0,0,0,0,0,0,0)$!
3. **Testemunha `0xdf`** (`c = 0x4549b7cd9fc26c844fa27b80f56d5`):
   * Valores: $-256, 256, 256, 256, 256, \mathbf{768}, 256, -256$.
   * Novamente $768 \equiv 0 \pmod{128}$, logo $(P_1,\dots,P_8) = (0,0,0,0,0,0,0,0)$!
4. *(E também em `control_0xdd`: $256, 768, 256, 256, 256, \mathbf{0}, 256, 256 \implies$ todos múltiplos de $256$, não apenas de $128$!!)*

> **DESCOBERTA CRÍTICA 1 (Contraexemplo Decisivo):**
> As testemunhas `0x7f`, `0xfd`, `0xdf` e `0xdd` provam com **certeza matemática absoluta** que:
> 1. **NÃO existe contradição módulo $128$** entre $c_{99}=1$, $C_1\dots C_7$ e $W_f(e_0+e_d) \equiv 0 \pmod{128}$ para $d=1\dots 8$.
> 2. **Mais forte ainda (`0x7f`, `0xfd`, `0xdf`, `0xdd`):** Em `0x7f` ($512$), `0xfd` ($768$), `0xdf` ($768$) e `0xdd` ($768, 0$), **todas as 8 frequências de peso 2 já são múltiplas de $256$** ($W_f(e_0+e_d) \equiv 0 \pmod{256}$)!!
>    * Em `0xfd` e `0xdf` ($768 = 3 \times 256$), temos inclusive $\frac{W_f(e_0+e_d)}{256} \equiv 1 \pmod 2$ para **todas as 8 distâncias** $d=1,\dots,8$ simultaneamente!
>    * Isto **destrói** qualquer tentativa de provar a impossibilidade de `0xff` usando **apenas** congruências 2-ádicas módulo $128$, módulo $256$, ou mesmo $W_f(e_0+e_d) \equiv 256 \pmod{512}$!!
>    * Veja `0xfd`: `w2_8_signed` $= (256, \mathbf{768}, 256, 256, -256, 256, 256, -256)$. Note que $256 \equiv 256 \pmod{512}$, $-256 \equiv 256 \pmod{512}$, e **$768 = 512 + 256 \equiv 256 \pmod{512}$**!!
>    * **CHOQUE MATEMÁTICO:** Para `0xfd` (`0x7dfbc6e96ab4ccc7522a55a9b149`) e `0xdf` (`0x4549b7cd9fc26c844fa27b80f56d5`), vale simultaneamente:
>      * $c_{99} = 1$, $C_1 \dots C_7$ verdadeiras;
>      * $W_f(0) = -256 \equiv 256 \pmod{512}$;
>      * $W_f(e_0) = 256 \equiv 256 \pmod{512}$;
>      * **$W_f(e_0 + e_d) \equiv 256 \pmod{512}$ para TODAS as 8 distâncias $d = 1,2,3,4,5,6,7,8$!!**
>      *(Pois $768 - 256 = 512$! Logo até módulo $512$, `0xfd` e `0xdf` são **indistinguíveis** de uma função com máscara `0xff` = $\pm 256$! Elas só falham `0xff` em $\mathbb{Z}$ porque $768 \ne \pm 256$, isto é, no bit módulo $1024$ ou na norma arquimediana $\ell_2$/$\ell_4$!)*

Esta verificação pelas testemunhas economiza meses de trabalho em um beco sem saída: **qualquer identidade puramente 2-ádica $\bmod 512$ restrita a $W_f(0), W_f(e_0)$ e às 120 frequências de peso 2 mais $C_1\dots C_7$ é FALSA**, pois `0xfd` e `0xdf` são contraexemplos explícitos!

---

#### 2.3. TESTE DE FOGO 2: Incluindo $W_f(\text{`0x0007`})$ (peso 3) ou suportes periódicos

Vejamos o que acontece em `0xfd` e `0xdf` na frequência `0x0007` (peso 3 consecutiva, $x_0 + x_1 + x_2$):
* Em `0xdf`: `W_f_0x0007 = 0` ($\equiv 0 \pmod{512}$, falha módulo $512$).
* Em `0xfd`: `W_f_0x0007 = 512` ($\equiv 0 \pmod{512}$, falha módulo $512$).
* Em `0xf7` e `0x7f` e `0xbf`: `W_f_0x0007 = 0` ($\equiv 0 \pmod{512}$, falha módulo $512$).
* **MAS** em `0x7d` (`0x579fbbffeb7e9edfdcd6f7df75dbb`): `W_f_0x0007 = 256` ($\equiv 256 \pmod{512}$), enquanto `w2_8_signed["0x5"] = 0` e `w2_8_signed["0x101"] = -192`!

Testemos então a **HIPÓTESE CANDIDATA B (Identidade acoplada $\bmod 512$ entre peso 2 e peso 3 / suportes periódicos):**
*Pode existir uma identidade sobre $\mathbb{F}_2$ envolvendo os bits de nível $256 \bmod 512$ de $\{0, e_0, e_0+e_d\}_{d=1}^8$ **junto com** `0x0007` (ou outras órbitas de um subespaço pequeno)?*

Aqui entra a **Identidade Exata de Subespaço (Poisson / Parseval Linear)** — a ferramenta algébrica canônica que **conecta valores inteiros exatos** (e congruências de alta potência de 2) sem precisar expandir polinômios gigantes de grau 8 em 112 variáveis!

---

### 3. A Via Algébrica Rigorosa: Identidades de Poisson–Parseval em Subespaços Invariantes e Quocientes Periódicos

Em vez de adivinhar congruências 2-ádicas soltas (que falharam contra `0xfd` e `0xdf` módulo 512 em peso $\le 2$), usemos as duas ferramentas exatas em $\mathbb{Z}$ sobre subespaços estruturados $U \subset \mathbb{F}_2^{16}$:

1. **Soma de Poisson Linear (Primeiros Momentos em Cosets):** Para qualquer subespaço linear $U \subset \mathbb{F}_2^{16}$ de dimensão $m$ e qualquer translação $y \in \mathbb{F}_2^{16}$,
   $$\sum_{a \in U} (-1)^{\langle a, y \rangle} W_f(a) = 2^m \sum_{x \in U^\perp} (-1)^{f(x+y)}.$$
   Para $y = 0$, denote $S(U) := \sum_{a \in U} W_f(a) = 2^m \, h_f(U^\perp)$, onde $h_f(U^\perp) = \sum_{x \in U^\perp} (-1)^{f(x)}$ é o **coeficiente de suporte** (exatamente o objeto `h_f(mask)` usado em T28 e T31!).
2. **Segundo Momento de Subespaço (Parseval Relativo / Autocorrelação):**
   $$\sum_{a \in U} W_f(a)^2 = 2^m \sum_{u \in U^\perp} \Delta_f(u), \qquad \text{onde } \Delta_f(u) = \sum_{x \in \mathbb{F}_2^{16}} (-1)^{f(x) \oplus f(x \oplus u)}.$$
   Se $f$ for bent, $|W_f(a)| = 256$ para todo $a \in U$, o que exige simultaneamente:
   * **(Momento 1 — Coeficiente de Suporte):** $h_f(U^\perp) = 2^{-m} \sum_{a \in U} (\pm 256)$, logo $|h_f(U^\perp)|$ é estritamente limitado e satisfaz congruências de sinais compatíveis com as órbitas rotacionais contidas em $U$!
   * **(Momento 2 — Derivadas Direcionais $\Delta_f(u) = 0$):** Para todo $u \in U^\perp \setminus \{0\}$, a derivada direcional $D_u f(x) = f(x) \oplus f(x \oplus u)$ tem **grau algébrico $\le 3$** (cúbica!) e deve ser balanceada ($\Delta_f(u) = 0$).

Apliquemos isso aos **três subespaços exatos** que emergem diretamente dos dados de `cascade_periodic_report.json` e T31:

---

#### Via Algébrica 1: O Subespaço Periódico $U_{\text{per},4}$ de Dimensão 4 (`0x0000`, `0x1111`, `0x3333`, `0x5555`, `0x7777`, `0xffff`)
Considere o subespaço $U_4 \subset \mathbb{F}_2^{16}$ dos vetores invariantes por $\rho^4$:
$$U_4 = \{ u \cdot \text{`0x1111`} : u \in \mathbb{F}_2^4 \}, \qquad |U_4| = 16.$$
Sob a rotação $\rho$ de $16$ variáveis, as $16$ frequências de $U_4$ dividem-se em exatamente **6 órbitas cíclicas** (todas já aparecem no caderno, em T20/T31 e em `cascade_periodic_report.json`!):
1. Peso 0 ($1$ elem.): `0x0000` $\longrightarrow W_f(\text{`0x0000`})$.
2. Peso 4 ($4$ elem.): órbita de `0x1111` $\longrightarrow 4 \, W_f(\text{`0x1111`})$.
3. Peso 8 alternada ($2$ elem.): órbita de `0x5555` (`0x5555`, `0xaaaa`) $\longrightarrow 2 \, W_f(\text{`0x5555`})$.
4. Peso 8 em blocos ($4$ elem.): órbita de `0x3333` (`0x3333`, `0x6666`, `0xcccc`, `0x9999`) $\longrightarrow 4 \, W_f(\text{`0x3333`})$.
5. Peso 12 ($4$ elem.): órbita de `0x7777` $\longrightarrow 4 \, W_f(\text{`0x7777`})$.
6. Peso 16 ($1$ elem.): `0xffff` $\longrightarrow W_f(\text{`0xffff`})$.

*(Soma dos tamanhos: $1 + 4 + 2 + 4 + 4 + 1 = 16$!)*

Pela identidade de Poisson em $U_4$, para qualquer $f \in H(16,4)$:
$$W_f(\text{`0x0000`}) + 4 W_f(\text{`0x1111`}) + 2 W_f(\text{`0x5555`}) + 4 W_f(\text{`0x3333`}) + 4 W_f(\text{`0x7777`}) + W_f(\text{`0xffff`}) = 16 \, h_f(U_4^\perp),$$
onde $U_4^\perp = \{ (x^{(0)}, x^{(1)}, x^{(2)}, x^{(3)}) \in (\mathbb{F}_2^4)^4 : x^{(0)} \oplus x^{(1)} \oplus x^{(2)} \oplus x^{(3)} = 0 \}$ tem dimensão $12$ ($4.096$ pontos)!

**Mais ainda: Decomposição Booleana-Walsh $4 \times 4$ sobre $U_4$!**
Não temos apenas 1 equação, temos a **transformada de Hadamard $4$-dimensional completa**! Para cada $v \in \mathbb{F}_2^4$, defina a soma sobre o coset $C_v = \{ x \in \mathbb{F}_2^{16} : x^{(0)} \oplus x^{(1)} \oplus x^{(2)} \oplus x^{(3)} = v \}$:
$$H(v) := \sum_{x \in C_v} (-1)^{f(x)}, \qquad v \in \mathbb{F}_2^4.$$
Por rotação $\rho$ (que atua ciclicamente nos $4$ bits de $v \in \mathbb{F}_2^4$!), $H(v)$ depende **apenas da órbita cíclica de $v$ em $\mathbb{F}_2^4$**:
* $v = \text{`0x0`}$ ($1$), $v \in [\text{`0x1`}]$ ($4$), $v \in [\text{`0x3`}]$ ($4$), $v \in [\text{`0x5`}]$ ($2$), $v \in [\text{`0x7`}]$ ($4$), $v = \text{`0xf`}$ ($1$).
E os $6$ valores de Walsh $(W_f(\text{`0x0000`}), W_f(\text{`0x1111`}), W_f(\text{`0x5555`}), W_f(\text{`0x3333`}), W_f(\text{`0x7777`}), W_f(\text{`0xffff`}))$ são obtidos por uma matriz $6 \times 6$ fixa invertível a partir dos $6$ inteiros $(H(\text{`0x0`}), H(\text{`0x1`}), H(\text{`0x5`}), H(\text{`0x3`}), H(\text{`0x7`}), H(\text{`0xf`}))$!

**Agora cruze isto com $c_{99} = 1$!**
Qual é a órbita $99$ na ordenação lexicográfica de `combinations(range(16), 4)` usada em `VERIFICAR_LIMITE_QUOCIENTE_T30.py` e `VERIFICAR_SETIMA_CONDICAO_T31.py`?
Vamos identificá-la **exatamente** a partir do código de `VERIFICAR_SETIMA_CONDICAO_T31.py`:
* No verificador T31:
  `for j in range(116): if j not in [57,99,113,115]: assert diagonal[j]==0`
  `Da = diagonal[57]^diagonal[113]; Db = diagonal[99]`
  `assert [64-2*((Da if a else 0)^(Db if b else 0)).bit_count() for a,b in [(0,0),(0,1),(1,0),(1,1)]] == [64,32,32,0]`
* Veja o que esse `assert` prova sobre a órbita $99$:
  1. Em $16$ variáveis, há $\binom{16}{4} = 1820$ monômios de grau $4$. Sob $C_{16}$:
     * **1 órbita de tamanho 4** (invariante por $\rho^4$): o monômio periódico $x_0 x_4 x_8 x_{12}$ (`0x1111`) e suas 3 rotações (`0x2222`, `0x4444`, `0x8888`)!
     * **3 órbitas de tamanho 8** (invariantes por $\rho^8$, isto é, pares de pares antipodais $\{i, i+8, j, j+8\}$ com $j - i \in \{1,2,3\}$, já que $j - i = 4$ dá a órbita de tamanho 4!):
       * $j-i = 1$: $\{0,1,8,9\}$ (`0x0303`)
       * $j-i = 2$: $\{0,2,8,10\}$ (`0x0505`)
       * $j-i = 3$: $\{0,3,8,11\}$ (`0x0909`)
     * $112$ órbitas longas de tamanho $16$ ($112 \times 16 + 3 \times 8 + 1 \times 4 = 1792 + 24 + 4 = 1820$!).
  2. Sobre a diagonal $x = (v,v)$ com $v \in \mathbb{F}_2^8$ restrita a `small` ($v \subseteq \{0,1,2,4,5,6\}$, i.e., bit $3$ e bit $7$ nulos!):
     * Um monômio só sobrevive em $(v,v)$ módulo 2 se sua órbita tiver tamanho $4$ ou $8$ (pois órbitas de tamanho $16$ vêm em pares $\{m, \rho^8(m)\}$ que se cancelam em $(v,v)$: $2 \equiv 0 \pmod 2$!). Logo as **4 órbitas curtas são exatamente `{57, 99, 113, 115}`**!!
     * Em `small` (`0x77`, sem bits $3$ e $7$):
       * Para `{0,4,8,12}` (tamanho 4): na diagonal $(v,v)$ reduz-se a $v_0 v_4 + v_1 v_5 + v_2 v_6 + v_3 v_7$. Em `small` ($v_3=v_7=0$), sobra $v_0 v_4 + v_1 v_5 + v_2 v_6$, função quadrática em $6$ variáveis (`small` tem $64$ pontos) de posto $6$, cujo peso em $64$ pontos é $2^{6-1} - 2^{3-1} = 32 - 4 = 28$? Não: `64 - 2*Db.bit_count() == 32` $\implies$ **`Db.bit_count() == 16`**!!
       * Qual função quadrática em $v_0,v_1,v_2,v_4,v_5,v_6$ tem peso $16$ em $64$ pontos? Uma forma de **posto 2** (um único produto $v_a v_b$, peso $64/4 = 16$)!
       * Vejamos as 4 órbitas curtas em `small` ($I = \{0,1,2,4,5,6\}$):
         - $\{0,4,8,12\} \mapsto v_0 v_4 + v_1 v_5 + v_2 v_6$ (3 termos disjuntos $\implies$ peso $28$, NÃO é 16! Espere: na órbita de tamanho 4 há apenas 4 monômios: $x_0 x_4 x_8 x_{12} \mapsto v_0 v_4$, $x_1 x_5 x_9 x_{13} \mapsto v_1 v_5$, $x_2 x_6 x_{10} x_{14} \mapsto v_2 v_6$, $x_3 x_7 x_{11} x_{15} \mapsto 0$. Mas se $c_{115}=0$ é imposto pelas 3 leis T20, `115` é `{0,4,8,12}`? Vamos checar a ordem lexicográfica de `combinations(range(16), 4)`!).
       * **Cálculo exato da ordem lexicográfica:** `combinations(range(16), 4)` gera tuplas $(i_0 < i_1 < i_2 < i_3)$ em ordem lexicográfica! Toda órbita contém pelo menos uma tupla com $i_0 = 0$:
         - `{0,1,8,9}` aparece em $(0,1,8,9)$;
         - `{0,2,8,10}` aparece em $(0,2,8,10)$;
         - `{0,3,8,11}` aparece em $(0,3,8,11)$;
         - `{0,4,8,12}` aparece em $(0,4,8,12)$ — a **última** tupla de órbita curta, próxima do final das $116$ órbitas! De fato, para $i_0=0$, após $(0,4,8,12)$ só existem órbitas com distância mínima $\ge 4$ — impossível em 16 variáveis exceto $(0,4,8,12)$! Logo **`115` é `{0,4,8,12}`** (a única órbita de tamanho 4, fixada em $c_{115}=0$ pelas leis T20)!
         - E as 3 órbitas de tamanho 8 são:
           * `57`: $(0,1,8,9) \mapsto v_0 v_1 + v_1 v_2 + v_2 v_3 + v_3 v_4 + v_4 v_5 + v_5 v_6 + v_6 v_7 + v_7 v_0$. Em `small` ($v_3=v_7=0$), sobra $(v_0 v_1 + v_1 v_2) + (v_4 v_5 + v_5 v_6) = v_1(v_0+v_2) + v_5(v_4+v_6)$ (posto 4).
           * `99`: $(0,2,8,10) \mapsto v_0 v_2 + v_1 v_3 + v_2 v_4 + v_3 v_5 + v_4 v_6 + v_5 v_7 + v_6 v_0 + v_7 v_1$. Em `small` ($v_3=v_7=0$), sobra $v_0 v_2 + v_2 v_4 + v_4 v_6 + v_6 v_0 = (v_0 + v_4)(v_2 + v_6)$ — **EXATAMENTE POSTO 2, PESO 16!!** (`64 - 2*16 = 32`! Conferido 100% com `Db = diagonal[99]`!!)
           * `113`: $(0,3,8,11) \mapsto v_0 v_3 + v_1 v_4 + v_2 v_5 + v_3 v_6 + v_4 v_7 + v_5 v_0 + v_6 v_1 + v_7 v_2$. Em `small` ($v_3=v_7=0$), sobra $v_1 v_4 + v_2 v_5 + v_5 v_0 + v_6 v_1 = v_1(v_4+v_6) + v_5(v_0+v_2)$, e somado com `57` (`Da = diagonal[57]^diagonal[113]`): $(v_1+v_5)(v_0+v_2+v_4+v_6)$, **TAMBÉM POSTO 2, PESO 16!!** E quando $a=1, b=1$, `Da ^ Db` é $(v_1+v_5)(v_0+v_2+v_4+v_6) + (v_0+v_4)(v_2+v_6)$, de posto 4, mas sobre $F_2^6$... espere: `[64, 32, 32, 0]` significa que `(Da ^ Db).bit_count() == 32` (função balanceada, porque $v_0+v_2+v_4+v_6 = (v_0+v_4)+(v_2+v_6)$; pondo $X = v_0+v_4, Y = v_2+v_6, Z = v_1+v_5$, `Da^Db` $= Z(X+Y) + XY$, que para $X+Y=0$ vale $X^2 = X$ linear não-nula $\implies$ peso $32$, Walsh $0$!).

> **IDENTIFICAÇÃO ESTRUTURAL EXATA (100% Provada):**
> * $c_{115} = 0$: órbita de tamanho 4, $\{0,4,8,12\}$.
> * $c_{57} = c_{113}$: par de órbitas de tamanho 8, $\{0,1,8,9\}$ e $\{0,3,8,11\}$.
> * **$c_{99} = 1$: a órbita de tamanho 8 simétrica de passo 2, $O_{99} = \text{órbita}(\{0,2,8,10\})$ (`0x0505`)!**

Olhe o significado geométrico de $c_{99} = 1$ (`0x0505`):
A órbita $O_{99}$ consiste nos $8$ monômios $x_i x_{i+2} x_{i+8} x_{i+10}$ ($i=0,\dots,7$).
1. Sob a restrição $x = (v,v)$ (subespaço de período $8$, dual de $U_8 = \{ u \cdot \text{`0x0101`} : u \in \mathbb{F}_2^8 \}$):
   $$f(v,v) = c_{57} \sum_{i=0}^7 v_i (v_{i+1} + v_{i+3}) + c_{99} \sum_{i=0}^7 v_i v_{i+2}.$$
   Para $c_{99} = 1$:
   * $f(v,v)$ divide-se na soma direta das coordenadas pares $(v_0, v_2, v_4, v_6)$ e ímpares $(v_1, v_3, v_5, v_7)$ quando $c_{57}=0$, e acopla pares e ímpares via $(v_0+v_2+v_4+v_6)(v_1+v_3+v_5+v_7)$? Calculemos exatamente:
     - Termo de $c_{99}=1$: $Q_{99}(v) = (v_0 v_2 + v_2 v_4 + v_4 v_6 + v_6 v_0) + (v_1 v_3 + v_3 v_5 + v_5 v_7 + v_7 v_1) = (v_0+v_4)(v_2+v_6) + (v_1+v_5)(v_3+v_7)$! (Posto simplético **4** em $\mathbb{F}_2^8$, **nulo** no subespaço $v_i = v_{i+4}$!).
     - Termo de $c_{57}=c_{113}$: $\sum_{i=0}^7 v_i(v_{i+1}+v_{i+3}) = (v_0+v_4)(v_1+v_3+v_5+v_7) + (v_2+v_6)(v_1+v_3+v_5+v_7) = (v_0+v_2+v_4+v_6)(v_1+v_3+v_5+v_7)$! (Posto simplético **2**!).
   * **Consequência extraordinária:** Sobre todo o subespaço diagonal $D_8 = \{(v,v) : v \in \mathbb{F}_2^8\}$ ($256$ pontos), **a restrição de QUALQUER $f \in H(16,4)$ sob T20 e $c_{99}=1$ depende APENAS de $c_{57} \in \{0,1\}$, sendo independente das 112 órbitas longas!**
   * Vamos calcular o espectro de Walsh de $g(v) := f(v,v)$ em $\mathbb{F}_2^8$ para $c_{99}=1$:
     Defina variáveis lineares independentes em $\mathbb{F}_2^8$:
     $X_0 = v_0+v_4$, $X_2 = v_2+v_6$, $X_1 = v_1+v_5$, $X_3 = v_3+v_7$ ($4$ coordenadas; as outras $4$ coordenadas são livres e **não aparecem em $f(v,v)$**!!).
     Logo, para qualquer máscara linear $\langle \alpha, v \rangle$:
     * $W_{f|_{D_8}}(0)$: como $4$ coordenadas são mudas, multiplica por $2^4 = 16$ a soma em $(X_0,X_2,X_1,X_3) \in \mathbb{F}_2^4$ de $(-1)^{X_0 X_2 + X_1 X_3 + c_{57}(X_0+X_2)(X_1+X_3)}$.
       - Se $c_{57} = 0$: soma de $(-1)^{X_0 X_2 + X_1 X_3}$ em $\mathbb{F}_2^4$ vale $2 \times 2 = 4 \implies W_{f|_{D_8}}(0) = 16 \times 4 = \mathbf{64}$.
       - Se $c_{57} = 1$: matriz simplética de $X_0 X_2 + X_1 X_3 + (X_0+X_2)(X_1+X_3)$ tem determinante $1$ (posto 4!), e Arf invariant $= 0 + 0 = 0$? Testemos os 16 pontos: para $(X_0,X_2) \in \{(0,0),(0,1),(1,0),(1,1)\}$:
         * $(0,0) \mapsto (-1)^{X_1 X_3}$ (soma $+2$);
         * $(1,1) \mapsto -(-1)^{X_1 X_3}$ (soma $-2$, cancela com $(0,0)$!!);
         * $(0,1) \mapsto (-1)^{X_1 X_3 + X_1 + X_3}$ ($1, -1, -1, -1 \implies$ soma $-2$);
         * $(1,0) \mapsto (-1)^{X_1 X_3 + X_1 + X_3}$ (soma $-2$).
         Soma total $= 2 - 2 - 2 - 2 = -4 \implies W_{f|_{D_8}}(0) = 16 \times (-4) = \mathbf{-64}$!
     * Portanto, para **toda** $f$ no ramo $c_{99}=1$ sob T20:
       $$\sum_{v \in \mathbb{F}_2^8} (-1)^{f(v,v)} = 64 \, (-1)^{c_{57}}!$$

Agora aplique a **Identidade de Poisson ao subespaço $U_8 = \{ u \cdot \text{`0x0101`} : u \in \mathbb{F}_2^8 \}$** (dimensão $8$, ortogonal a $C_8 = \{(v,w) : v \oplus w = 0\} = D_8$!! Espere: $\langle u \cdot \text{`0x0101`}, (v,w) \rangle = \langle u, v \oplus w \rangle$, logo **$U_8^\perp = D_8 = \{(v,v) : v \in \mathbb{F}_2^8\}$ EXATAMENTE**!!):

$$\sum_{u \in \mathbb{F}_2^8} W_f(u \cdot \text{`0x0101`}) = 2^8 \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v,v)} = 256 \times 64 (-1)^{c_{57}} = \mathbf{16384 \, (-1)^{c_{57}}}!!$$

E mais: para **qualquer** $z \in \mathbb{F}_2^8$, considerando $\sum_{u \in \mathbb{F}_2^8} (-1)^{\langle u, z \rangle} W_f(u \cdot \text{`0x0101`}) = 256 \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v, v \oplus z)}$!
Para $z = 0$, dividindo por $256$, obtemos uma **IDENTIDADE INTEIRA EXATA UNIVERSAL** para toda $f \in H(16,4)$ sob T20 com $c_{99} = 1$:
$$\sum_{u \in \mathbb{F}_2^8} \frac{W_f(u \cdot \text{`0x0101`})}{256} = 64 \, (-1)^{c_{57}}!!$$

> **Vamos verificar o que esta identidade diz sobre uma eventual função BENT no ramo $c_{99} = 1$!**
> Se $f$ for bent, então para cada um dos $256$ vetores $u \in \mathbb{F}_2^8$, $\sigma(u) := \frac{W_f(u \cdot \text{`0x0101`})}{256} \in \{+1, -1\}$ é a **função dual $\widetilde{f}$ restrita a $U_8$** ($f^*(u) \in \mathbb{F}_2$, $(-1)^{f^*(u)} = \sigma(u)$)!
> Como $f$ é invariante por $\rho$, $\sigma(u)$ é invariante pela rotação cíclica de $8$ bits em $u \in \mathbb{F}_2^8$ ($u \mapsto \rho_8(u)$, pois $\rho(u \cdot \text{`0x0101`}) = \rho_8(u) \cdot \text{`0x0101`}$)!
> Logo, $f^*(u \cdot \text{`0x0101`})$ teria de ser uma **função booleana rotacionalmente simétrica em 8 variáveis ($RSBF_8$)** cujo coeficiente de Walsh na origem vale:
> $$\sum_{u \in \mathbb{F}_2^8} (-1)^{f^*(u \cdot \text{`0x0101`})} = 64 \, (-1)^{c_{57}} \implies \operatorname{wt}\big(f^*|_{U_8}\big) = \begin{cases} 96 & \text{se } c_{57}=0, \\ 160 & \text{se } c_{57}=1. \end{cases}$$
> **E MAIS AINDA — TEOREMA DE DUALIDADE DE RESTRIÇÃO LINEAR (Carlet / Canteaut-Charpin):**
> Para **qualquer** função bent $f$ em $\mathbb{F}_2^{16}$ e qualquer subespaço $U_8$ de dimensão $8$, a decomposição espectral de $f$ restrita aos cosets de $U_8^\perp = D_8$ satisfaz a **Identidade Dual de Subespaço**:
> Para todo $\alpha \in \mathbb{F}_2^8$:
> $$\sum_{u \in \mathbb{F}_2^8} (-1)^{\langle \alpha, u \rangle} \sigma(u) = \frac{1}{256} \sum_{u \in \mathbb{F}_2^8} (-1)^{\langle \alpha, u \rangle} W_f(u \cdot \text{`0x0101`}) = \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v,v) \oplus \langle \alpha, v \rangle}!!$$
> **PARE E OLHE ESTA EQUAÇÃO COM ATENÇÃO ABSOLUTA!**
> Sejam $x = (v_1, v_2) \in \mathbb{F}_2^8 \times \mathbb{F}_2^8$. Se avaliarmos $\sum_{u \in \mathbb{F}_2^8} (-1)^{\langle \alpha, u \rangle} W_f(u \cdot \text{`0x0101`})$:
> $$\sum_{u \in \mathbb{F}_2^8} (-1)^{\langle \alpha, u \rangle} W_f(u \cdot \text{`0x0101`}) = \sum_{v_1, v_2 \in \mathbb{F}_2^8} (-1)^{f(v_1, v_2)} \sum_{u \in \mathbb{F}_2^8} (-1)^{\langle u, v_1 \oplus v_2 \oplus \alpha \rangle} = 256 \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v, v \oplus \alpha)}!$$
> **Agora avalie em $\alpha = 0$? Já fizemos! E em $\alpha \ne 0$? Não, olhe o OUTRO sentido da dualidade de Walsh para $\sigma(u)$!**
> Se $f$ é bent, então $\sigma(u) \in \{+1, -1\}$ para **todo** $u \in \mathbb{F}_2^8$!
> Logo a transformada de Walsh de $\sigma : \mathbb{F}_2^8 \to \{\pm 1\}$ em $\alpha \in \mathbb{F}_2^8$, definida por $\widehat{\sigma}(\alpha) := \sum_{u \in \mathbb{F}_2^8} (-1)^{\langle \alpha, u \rangle} \sigma(u)$, é **IDÊNTICA** a:
> $$\widehat{\sigma}(\alpha) = \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v, v \oplus \alpha)} \qquad \forall \alpha \in \mathbb{F}_2^8!!$$
> *(Verificação imediata: Em $\alpha = 0$, $\widehat{\sigma}(0) = \sum_v (-1)^{f(v,v)} = 64(-1)^{c_{57}}$! Em $\alpha = \text{`0xff`}$ ($z = 255$, uma das fibras de T27/T30!!), $\widehat{\sigma}(\text{`0xff`}) = \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v, \bar{v})}$!! Em $\alpha \in \{\text{`0x00`}, \text{`0x55`}, \text{`0xaa`}, \text{`0xff`}, \text{`0x33`}\}$ — **EXATAMENTE OS 5 VALORES `z in [0, 85, 170, 255, 51]` DE `VERIFICAR_LIMITE_QUOCIENTE_T30.py`!!**)*

**ISTO REVELA O CORAÇÃO ALGÉBRICO DE TODO O PROJETO (T20–T32):**
Em `VERIFICAR_LIMITE_QUOCIENTE_T30.py`, a linha:
`for z in [0,85,170,255,51]: for u in range(256): assert f(delta, u|((u^z)<<8))==0`
mostra que o quociente T27 e as condições T20 restringem $f$ às fibras $(v, v \oplus z)$ para $z \in \{0, \text{`0x55`}, \text{`0xaa`}, \text{`0xff`}, \text{`0x33`}\}$!
E pela identidade exata acima:
$$F(z) := \sum_{v \in \mathbb{F}_2^8} (-1)^{f(v, v \oplus z)} = \frac{1}{256} \sum_{u \in \mathbb{F}_2^8} (-1)^{\langle z, u \rangle} W_f(u \cdot \text{`0x0101`})!$$
Se $f$ for bent, então $\sigma(u) = \frac{W_f(u \cdot \text{`0x0101`})}{256} \in \{\pm 1\}$ é uma **função booleana verdadeira** em $\mathbb{F}_2^8$ invariante por $\rho_8$ ($36$ órbitas sob $C_8$: $1$ de tam. 1 [`0x00`], $1$ de tam. 1 [`0xff`], $1$ de tam. 2 [`0x55`], $3$ de tam. 4 [`0x11`, `0x33`, `0x77`], e $30$ de tam. 8)!
E mais: nas frequências de $U_8$ que já conhecemos:
* $u = \text{`0x00`}$ ($1$): $W_f(\text{`0x0000`}) = \pm 256 \implies \sigma(\text{`0x00`}) \in \{\pm 1\}$.
* $u \in [\text{`0x01`}]$ ($8$): $W_f(\text{`0x0101`}) = \pm 256 \implies \sigma(\text{`0x01`}) \in \{\pm 1\}$ (**é o bit 8 da máscara `0xff` — a distância $d=8$!**).
* $u \in [\text{`0x11`}]$ ($4$): $W_f(\text{`0x1111`}) = \pm 256 \implies \sigma(\text{`0x11`}) \in \{\pm 1\}$.
* $u \in [\text{`0x55`}]$ ($2$): $W_f(\text{`0x5555`}) = \pm 256 \implies \sigma(\text{`0x55`}) \in \{\pm 1\}$.
* $u \in [\text{`0x33`}]$ ($4$): $W_f(\text{`0x3333`}) = \pm 256 \implies \sigma(\text{`0x33`}) \in \{\pm 1\}$.
* $u \in [\text{`0x77`}]$ ($4$): $W_f(\text{`0x7777`}) = \pm 256 \implies \sigma(\text{`0x77`}) \in \{\pm 1\}$.
* $u = \text{`0xff`}$ ($1$): $W_f(\text{`0xffff`}) = \pm 256 \implies \sigma(\text{`0xff`}) \in \{\pm 1\}$.

**Agora olhe a projeção sobre $U_4 \subset U_8$ ($u \in \mathbb{F}_2^8$ periódicos de período 4, i.e. $u = \rho_8^4(u)$):**
Há exatamente $16$ tais vetores $u$: `0x00` (1), `0x11` (4), `0x55` (2), `0x33` (4), `0x77` (4), `0xff` (1)!
E os outros $240 = 256 - 16$ vetores de $U_8 \setminus U_4$ agrupam-se em órbitas sob $\rho_8^4$ de tamanho $2$ ($u \ne \rho_8^4(u)$), e sob $\rho_8$ em **30 órbitas de tamanho 8** (incluindo `0x01` $\leftrightarrow$ `0x0101`)!
Como para qualquer órbita $O$ de tamanho $8$ em $\mathbb{F}_2^8$, $\sum_{u \in O} \sigma(u) = 8 \sigma(u_O) \equiv 8 \pmod{16}$ se $\sigma(u_O) \in \{\pm 1\}$, e há $30$ tais órbitas ($30 \times (\pm 8) = 240 - 16 r \equiv 8 - 0 \equiv \mathbf{8} \pmod{16}$, pois $30$ é $2 \pmod 4$: $30 \times 8 = 240 \equiv 0 \pmod{16}$, e cada troca $+8 \to -8$ subtrai $16$!!):
$$\sum_{u \in U_8 \setminus U_4} \sigma(u) = \sum_{j=1}^{30} 8 \, \sigma(u_j) \equiv 30 \times 8 = 240 \equiv \mathbf{0} \pmod{16}!!$$

**ATENTE PARA ESTA CONGRUÊNCIA EXATA EM $\mathbb{Z}$!**
Se $\sigma(u) \in \{\pm 1\}$ para todo $u \in \mathbb{F}_2^8$ (condição necessária de bentness apenas nas $256$ frequências de $U_8$!), então:
1. Por um lado, provamos que no ramo $c_{99} = 1$:
   $$\sum_{u \in \mathbb{F}_2^8} \sigma(u) = 64 \, (-1)^{c_{57}} \equiv \mathbf{0} \pmod{16}.$$
2. Por outro lado, $\sum_{u \in U_8 \setminus U_4} \sigma(u) \equiv \mathbf{0} \pmod{16}$.
3. Logo, a soma nas **6 órbitas periódicas de $U_4$** deve satisfazer:
   $$S_{U_4}(\sigma) := \sigma(\text{`0x00`}) + \sigma(\text{`0xff`}) + 2\sigma(\text{`0x55`}) + 4\big(\sigma(\text{`0x11`}) + \sigma(\text{`0x33`}) + \sigma(\text{`0x77`})\big) \equiv 0 \pmod{16}!!$$
   Vamos testar se $\sigma_i \in \{\pm 1\}$ permite $S_{U_4}(\sigma) \equiv 0 \pmod{16}$!
   * $|\sigma(\text{`0x00`}) + \sigma(\text{`0xff`}) + 2\sigma(\text{`0x55`})| \le 4$. Para ser múltiplo de $4$ (necessário para $\equiv 0 \pmod{16}$!), temos $\sigma(\text{`0x00`}) = \sigma(\text{`0xff`})$!
     - Mais precisamente: em $H(16,4)$ sob T20, já sabemos quanto valem $\sigma(\text{`0x00`})$ e $\sigma(\text{`0xff`})$?
       Em `even_pairs_report.json` e `search_7of8_0xff_report.json`:
       Em `0xdd`: $W_f(0) = +256$; em `0x5f`: $W_f(0) = -256$. E quanto vale $W_f(\text{`0xffff`})$?
       Para $a = \text{`0xffff`}$, $\langle \text{`0xffff`}, x \rangle = \operatorname{wt}(x) \bmod 2$!
       Em T31 (`VERIFICAR_SETIMA_CONDICAO_T31.py`), `h_f(0x7777)` avalia `chi` = paridade de peso! Para o cubo inteiro $\mathbb{F}_2^{16}$, $W_f(\text{`0xffff`}) = \sum_{x \in \mathbb{F}_2^{16}} (-1)^{f(x) + \operatorname{wt}(x)}$!
   * De qualquer modo, com $\sigma_i \in \{\pm 1\}$:
     * Para $S_{U_4} \in \{-16, 0, +16\}$:
       - $S_{U_4} = +16 \iff$ **todos os 6 sinais valem $+1$**;
       - $S_{U_4} = -16 \iff$ **todos os 6 sinais valem $-1$**;
       - $S_{U_4} = 0 \iff \sigma(\text{`0x00`}) + \sigma(\text{`0xff`}) + 2\sigma(\text{`0x55`}) \in \{+4, -4, 0\}$:
         * Se $\sigma(\text{`0x00`}) + \sigma(\text{`0xff`}) = 0$ (sinais opostos!), então $0 + 2(\pm 1) = \pm 2 \not\equiv 0 \pmod 4$! **IMPOSSÍVEL!**
         * **TEOREMA DE SINAL FORÇADO (PROVADO AGORA!):** Para QUALQUER função bent em $H(16,4)$ sob T20 e $c_{99}=1$ (na verdade em **ambos** os ramos se $16 \mid \widehat{\sigma}(0)$, o que vale sempre pois $\widehat{\sigma}(0) \in \{64, -64, 128, \dots\}$!), **é OBRIGATÓRIO que**:
           $$W_f(\text{`0x0000`}) = W_f(\text{`0xffff`}) = W_f(\text{`0x5555`}) \quad \text{quando } \sigma(\text{`0x11`})+\sigma(\text{`0x33`})+\sigma(\text{`0x77`}) = \pm 3,$$
           ou **$W_f(\text{`0x0000`}) = W_f(\text{`0xffff`}) = -W_f(\text{`0x5555`})$** quando $\sigma(\text{`0x11`})+\sigma(\text{`0x33`})+\sigma(\text{`0x77`}) = \pm 1$!
           Em **TODOS** os casos possíveis,
           $$W_f(\text{`0x0000`}) = W_f(\text{`0xffff`})!!$$

**VERIFIQUEMOS ISSO IMEDIATAMENTE!**
Quanto vale $W_f(\text{`0xffff`})$ em relação a $W_f(\text{`0x0000`})$ no ramo $c_{99}=1$ sob $C_1\dots C_7$?!
Releia o enunciado de T28 / T20 / T31 nos seus próprios certificados:
1. Em T20 / T28, quais são as **cinco primeiras condições** ($C_1, C_2, C_3, C_4, C_5$) e a **sexta condição** ($C_6$)?
   * $C_1, C_2, C_3$: as três leis lineares T20 (vêm dos suportes de peso pequeno / diagonais `z in [0, 85, 170, 255, 51]`!).
   * $C_4$ e $C_5$: vêm de $W_f(\text{`0x0000`}) = \pm 256$ e $W_f(\text{`0xffff`}) = \pm 256$ (ou $W_f(e_0) = \pm 256$)!
   * Veja em `cascade_periodic_report.json`: os estágios do filtro são `pass_w0`, `pass_w0_we0`, `pass_w0_we0_c7`! E em `even_pairs_report.json`: `W_f_0`, `W_f_e0` (`unit_16_common`), `C1_to_C7_verified: true`!
   * Mais precisamente: $h_f(\text{mask})$ em T31 é definido como:
     `word = chi ^ ...` onde `chi = sum((x.bit_count()%2)<<k for k,x in enumerate(allpoints))`!
     Ou seja, $h_f(\text{mask}) = \sum_{x \preceq \text{mask}} (-1)^{f(x) + \operatorname{wt}(x)}$ é a **transformada de Möbius-Walsh** avaliada no suporte `mask` (`0xffff` corresponde a $W_f(\text{`0xffff`})$, `0x7ffe` / peso 15 corresponde a $W_f(e_0)$ ou vice-versa via inversão de Möbius de $W_f$)!
     Pela relação fundamental entre $W_f(a)$ e $h_f(u) := \sum_{x \preceq u} (-1)^{f(x) + \operatorname{wt}(x)}$?
     Calculemos exatamente para $u = \text{`0x7777`}$ (os $4096$ pontos com bits $3,7,11,15$ iguais a $0$):
     $$\sum_{x \preceq \text{`0x7777`}} (-1)^{f(x) + \operatorname{wt}(x)} = \frac{1}{2^{16}} \sum_{a \in \mathbb{F}_2^{16}} W_f(a) \sum_{x \preceq \text{`0x7777`}} (-1)^{\langle a \oplus \text{`0xffff`}, x \rangle} = \frac{1}{16} \sum_{b \preceq \text{`0x8888`}} W_f(\text{`0xffff`} \oplus b)!!$$
     **EUREKA!! OLHE ESSA IDENTIDADE EXATA!!**
     Vamos conferi-la bit a bit:
     * `small = [v for v in range(256) if v & 0x77 == v]`, `allpoints = [v | (w<<8) ...]`: são os $2^{12} = 4096$ pontos $x \in \mathbb{F}_2^{16}$ tais que $x \ \& \ \text{`0x8888`} = 0$ (ou seja, $x \preceq \text{`0x7777`}$)!
     * Para qualquer $c \in \mathbb{F}_2^{16}$, $\sum_{x \preceq \text{`0x7777`}} (-1)^{\langle c, x \rangle}$ vale $4096$ se $c \ \& \ \text{`0x7777`} = 0$ (isto é, $c \preceq \text{`0x8888`}$), e $0$ caso contrário!
     * Pondo $c = a \oplus \text{`0xffff`}$, a condição $c \preceq \text{`0x8888`}$ equivale a $a = \text{`0xffff`} \oplus b$ com $b \preceq \text{`0x8888`}$ (isto é, $a$ tem `1` em todas as $12$ posições de `0x7777`, e é livre nas $4$ posições $\{3, 7, 11, 15\}$ de `0x8888`!).
     * Como $f$ é invariante por rotação $\rho$, quais são as $16$ máscaras $a = \text{`0x7777`} \oplus \tilde{b}$ ($\tilde{b} \preceq \text{`0x8888`}$)?
       Sob a rotação $\rho^4$ (que permuta $\{3,7,11,15\}$ preservando `0x7777`), essas $16$ frequências $a$ dividem-se em **6 órbitas**:
       1. $\tilde{b} = \text{`0x8888`}$ ($1$ elem.): $a = \text{`0xffff`}$ ($\operatorname{wt}=16$).
       2. $\operatorname{wt}(\tilde{b}) = 3$ ($4$ elem.): p.ex. $a = \text{`0xfff7`}$, que é rotacionalmente equivalente a **`0xfffe`** ($\operatorname{wt}=15$, complementar de $e_0$)!
       3. $\tilde{b} \in \{\text{`0x8080`}, \text{`0x0808`}\}$ ($2$ elem.): $a = \text{`0xf7f7`}$, rotacionalmente equivalente a **`0x7f7f`** ($\operatorname{wt}=14$, complementar de `0x0101`, $d=8$)!
       4. $\tilde{b}$ com dois bits adjacentes em $\{3,7,11,15\}$, p.ex. $\text{`0x8800`}$ ($4$ elem.): $a = \text{`0xff77`}$, rotacionalmente equivalente a **`0xef7f` / complementar de `0x0011` ($d=4$)** ($\operatorname{wt}=14$)!
       5. $\operatorname{wt}(\tilde{b}) = 1$ ($4$ elem.): p.ex. $a = \text{`0x7777`} \oplus \text{`0x0008`} = \text{`0x777f`}$ ($\operatorname{wt}=13$, complementar de `0x0888` = rotação de **`0x0111`**, peso 3 com espaçamento 4)!
       6. $\tilde{b} = \text{`0x0000`}$ ($1$ elem.): $a = \text{`0x7777`}$ ($\operatorname{wt}=12$).

     Logo, `h_f(0x7777)` de T31 satisfaz a identidade exata:
     $$16 \, h_f(\text{`0x7777`}) = W_f(\text{`0xffff`}) + 4 W_f(\overline{e_0}) + 2 W_f(\overline{\text{`0x0101`}}) + 4 W_f(\overline{\text{`0x0011`}}) + 4 W_f(\overline{\text{`0x0111`}}) + W_f(\text{`0x7777`})!$$
     Dividindo por $16$: se $f$ é bent, todo $W_f(a) = \pm 256$, logo $\frac{W_f(a)}{16} = \pm 16 \equiv 0 \pmod{16}$, o que exige $h_f(\text{`0x7777`}) \equiv 0 \pmod{32}$ (já que a soma de $16$ parcelas $\pm 256$ vale $256 \times (16 - 2r) \equiv 0 \pmod{512}$ se $r$ for par — e aqui $r = \#\{\text{sinais } -1\}$ tem paridade igual a $\sigma(\text{`0xffff`}) \oplus \sigma(\text{`0x7777`})$, pois as outras órbitas têm tamanhos pares $4, 2, 4, 4$!).
     **VEJA A CONSEQUÊNCIA DO NÍVEL SEGUINTE ($\bmod 64$ em $h_f(\text{`0x7777`})$, isto é, $\bmod 1024$ na soma):**
     Olhe os coeficientes $1, 4, 2, 4, 4, 1$! É a **mesma estrutura $(1, 4, 2, 4, 4, 1)$**!
     Se $f$ é bent ($\sigma(a) = W_f(a)/256 \in \{\pm 1\}$):
     $$\frac{h_f(\text{`0x7777`})}{16} = \sigma(\text{`0xffff`}) + 4\sigma(\overline{e_0}) + 2\sigma(\overline{\text{`0x0101`}}) + 4\sigma(\overline{\text{`0x0011`}}) + 4\sigma(\overline{\text{`0x0111`}}) + \sigma(\text{`0x7777`})!$$
     * **Nível $1 \pmod 2$ (que é T31 = $C_7$!):**
       Reduzindo módulo $2$, os termos com $4$ e $2$ somem, restando:
       $$\frac{h_f(\text{`0x7777`})}{16} \equiv \sigma(\text{`0xffff`}) + \sigma(\text{`0x7777`}) \equiv 1 + 1 = 0 \pmod 2!$$
       *(É por isso que $h_f(\text{`0x7777`})$ tem de ser divisível por $32$!)*
     * **Nível $2 \pmod 4$ (divisibilidade por $64$ vs. $32$!!):**
       Se $\sigma(\text{`0xffff`}), \sigma(\overline{\text{`0x0101`}}), \sigma(\text{`0x7777`}) \in \{+1, -1\}$:
       - Se $\sigma(\text{`0xffff`}) = \sigma(\text{`0x7777`}) = \pm 1$, então $\sigma(\text{`0xffff`}) + \sigma(\text{`0x7777`}) = \pm 2$, e $2\sigma(\overline{\text{`0x0101`}}) = \pm 2$, logo a soma módulo $4$ vale $(\pm 2) + (\pm 2) \equiv \mathbf{0} \pmod 4$!!
       - Se $\sigma(\text{`0xffff`}) = -\sigma(\text{`0x7777`})$, então $\sigma(\text{`0xffff`}) + \sigma(\text{`0x7777`}) = 0$, e sobra $2\sigma(\overline{\text{`0x0101`}}) = \pm 2 \equiv \mathbf{2} \pmod 4$!!
       Portanto, para qualquer função bent:
       $$\left\lfloor \frac{h_f(\text{`0x7777`})}{32} \right\rfloor \equiv \frac{1 - \sigma(\text{`0xffff`})\sigma(\text{`0x7777`})}{2} \pmod 2!$$

---

#### Via Algébrica 2: Generalização Sistemática aos Suportes Periódicos `0x5f5f`, `0x6f6f`, `0x3f3f`, `0x7f7f` e Acoplamento Direto com Peso 2 (`0xff`)!

Agora conectemos isso **diretamente** às $8$ distâncias de peso 2 (`0xff`) para cercar `0xfd`, `0xdf`, `0xf7`, `0x7f`, `0xbf`!

Por que `0x7777` produziu uma lei **linear** $R(c) = 0$ no ramo $c_{99} = 1$?
Releia `VERIFICAR_SETIMA_CONDICAO_T31.py`:
1. Qualquer suporte simétrico sob troca de metades `mask = m8 | (m8 << 8)` (onde $m_8 \subset \{0,\dots,7\}$ tem cardinalidade $s$):
   * Tem $2^{2s}$ pontos $(v,w)$ com $v, w \preceq m_8$, sendo $2^s$ pontos diagonais $(v,v)$ e $\frac{2^{2s} - 2^s}{2}$ pares $\{ (v,w), (w,v) \}$ com $v < w$.
   * Como $f(v,w) = f(w,v)$ (pois $\rho^8(v,w) = (w,v)$ e $f$ é invariante por $\rho^8$!), cada par $(v,w)$ contribui $2(-1)^{f(v,w)}$ (ou $0$ se $\operatorname{wt}(v)+\operatorname{wt}(w)$ for ímpar? Não: $\operatorname{wt}(v,w) = \operatorname{wt}(v)+\operatorname{wt}(w)$ é **igual** em $(v,w)$ e $(w,v)$!).
   * Para $s = 6$ ($m_8$ com $6$ bits ligados e $2$ bits desligados! Existem $\binom{8}{2} = 28$ tais máscaras $m_8$, que sob rotação $\rho_8$ formam exatamente **4 órbitas** correspondetes à distância $\delta \in \{1, 2, 3, 4\}$ entre os dois zeros de $m_8$!):
     - **$\delta = 4$ (zeros em $\{3, 7\}$, antipodais em $\mathbb{Z}_8$):** `m8 = 0x77` $\implies$ suporte **`0x7777`** (T31)!
     - **$\delta = 1$ (zeros adjacentes, p.ex. $\{6, 7\}$):** `m8 = 0x3f` $\implies$ suporte **`0x3f3f`**!
     - **$\delta = 2$ (zeros a distância 2, p.ex. $\{5, 7\}$):** `m8 = 0x5f` $\implies$ suporte **`0x5f5f`** (citado explicitamente no final do documento T31: *"Os suportes 0x5f5f e 0x6f6f já têm modelos exploratórios completos..."*)!
     - **$\delta = 3$ (zeros a distância 3, p.ex. $\{4, 7\}$):** `m8 = 0x6f` $\implies$ suporte **`0x6f6f`** (também citado explicitamente em T31)!

**OLHE QUE MARAVILHA MATEMÁTICA!**
Os **quatro** suportes de peso 12 simétricos por $\rho^8$ — **`0x3f3f`** ($\delta=1$), **`0x5f5f`** ($\delta=2$), **`0x6f6f`** ($\delta=3$) e **`0x7777`** ($\delta=4$) — esgotam todas as escolhas de 2 zeros por metade!
E quais frequências $a$ aparecem na expansão de Walsh de $h_f(\text{mask}_\delta)$ (ou de sua versão sem `chi`, $\tilde{h}_f(\text{mask}_\delta) := \sum_{x \preceq \text{mask}_\delta} (-1)^{f(x)}$)??

Para $\tilde{h}_f(\text{mask}_\delta) = \sum_{x \preceq \text{mask}_\delta} (-1)^{f(x)}$ (sem `chi`, logo centrada em $a = 0$ em vez de $a = \text{`0xffff`}$, conectando-se **diretamente às frequências de peso 0, 1, 2, 3, 4** que você mediu nos relatórios!!):
$$16 \, \tilde{h}_f(\text{mask}_\delta) = \sum_{b \preceq \overline{\text{mask}_\delta}} W_f(b),$$
onde $\overline{\text{mask}_\delta}$ tem exatamente **4 bits ligados**: $\{i, i+\delta, i+8, i+8+\delta\} \pmod{16}$!
Vamos listar **TODAS as 16 frequências $b \preceq \{0, \delta, 8, 8+\delta\}$** para cada $\delta \in \{1, 2, 3, 4\}$!!

1. **Peso 0 ($1$ elem.):** $b = 0 \longrightarrow W_f(0)$.
2. **Peso 1 ($4$ elem.):** $4$ rotações de $e_0 \longrightarrow 4 W_f(e_0)$.
3. **Peso 2 ($\binom{4}{2} = 6$ elem.) — OLHE QUAIS DISTÂNCIAS DE PESO 2 APARECEM EM CADA $\delta$!!**
   Os pares dentro de $\{0, \delta, 8, 8+\delta\}$ têm distâncias:
   * $\{0, 8\}$ e $\{\delta, 8+\delta\}$: **2 elementos na distância $d = 8$ (`0x0101`)**!
   * $\{0, \delta\}$ e $\{8, 8+\delta\}$: **2 elementos na distância $d = \delta$**!
   * $\{0, 8+\delta\}$ e $\{\delta, 8\}$: distâncias $8-\delta$ e $8+\delta \equiv 8-\delta$: **2 elementos na distância $d = 8 - \delta$**!
   Portanto:
   * Em $\delta = 1$ (**`0x3f3f`**): aparecem $2 W_f(d=8) + 2 W_f(d=1) + 2 W_f(d=7)$!
   * Em $\delta = 2$ (**`0x5f5f`**): aparecem $2 W_f(d=8) + 2 W_f(d=2) + 2 W_f(d=6)$!
   * Em $\delta = 3$ (**`0x6f6f`**): aparecem $2 W_f(d=8) + 2 W_f(d=3) + 2 W_f(d=5)$!
   * Em $\delta = 4$ (**`0x7777`**): aparecem $2 W_f(d=8) + 4 W_f(d=4)$!
   **TODAS AS 8 DISTÂNCIAS DE PESO 2 ($d = 1,2,3,4,5,6,7,8$) APARECEM AGRUPADAS EXATAMENTE NOS PARES $(1,7), (2,6), (3,5), (4), (8)$!**
4. **Peso 3 ($4$ elem.):** Subconjuntos de 3 elementos de $\{0, \delta, 8, 8+\delta\}$: todos os 4 são rotacionalmente equivalentes entre si (basta aplicar $\rho^8$ e a simetria do retângulo? Cuidado: $\{0, \delta, 8\}$ e $\{\delta, 8, 8+\delta\}$ são equivalentes por $\rho^8$? $\rho^8(\{0,\delta,8\}) = \{8, 8+\delta, 0\}$, o mesmo conjunto! Na verdade $\{0,\delta,8\}$ e $\{0,8,8+\delta\}$ são dois conjuntos de tamanho 3: sob $\rho^8$, $\{0,\delta,8\} \leftrightarrow \{8, 8+\delta, 0\}$ é fixo? Não, $\{0,\delta,8\}$ sob $\rho^8$ vai em $\{0,8,8+\delta\}$! E $\{0,\delta,8+\delta\} \leftrightarrow \{8, 8+\delta, \delta\}$! Logo são **2 pares de órbitas quirais** $T_\delta^+ = \{0, \delta, 8\}$ e $T_\delta^- = \{0, \delta, 8+\delta\}$, cada um aparecendo $2$ vezes: $2 W_f(T_\delta^+) + 2 W_f(T_\delta^-)$!).
5. **Peso 4 ($1$ elem.):** $b = \{0, \delta, 8, 8+\delta\}$ — que são **EXATAMENTE AS QUATRO ÓRBITAS CURTAS DE $H(16,4)$**!!
   * $\delta = 1$: `b = 0x0303` (órbita `57`)!
   * $\delta = 2$: `b = 0x0505` (**órbita `99`!!**)!
   * $\delta = 3$: `b = 0x0909` (órbita `113`)!
   * $\delta = 4$: `b = 0x1111` (órbita `115`, nossa velha conhecida `u4_0x1111`!)!

---

### 4. Análise Algébrica de $\tilde{h}_f(\text{mask}_\delta)$ no Ramo $c_{99} = 1$ (e Teste Contra as Testemunhas!)

Escrevamos a identidade exata que acabamos de demonstrar para $\delta \in \{1, 2, 3, 4\}$:
$$16 \, \tilde{h}_f(\text{mask}_\delta) = W_f(0) + 4 W_f(e_0) + 2 W_f(d_8) + 2 W_f(d_\delta) + 2 W_f(d_{8-\delta}) + 2 W_f(T_\delta^+) + 2 W_f(T_\delta^-) + W_f(Q_\delta), \quad (\star_\delta)$$
onde para $\delta = 4$, $2 W_f(d_4) + 2 W_f(d_4) = 4 W_f(d_4)$, $2 W_f(T_4^+) + 2 W_f(T_4^-) = 4 W_f(\text{`0x0111`})$, e $Q_4 = \text{`0x1111`}$.

Agora calculemos **o termo diagonal $B_0(\delta) := \sum_{v \preceq m_{8,\delta}} (-1)^{f(v,v)}$** no lado esquerdo $\tilde{h}_f(\text{mask}_\delta) = B_0(\delta) + 4032 - 4 \operatorname{wt}(\tilde{t}_{f,\delta})$ no ramo $c_{99} = 1$!
Já provamos na Seção 3 a fórmula **exata** de $f(v,v)$ sob T20 ($c_{115}=0, c_{113}=c_{57}$) e $c_{99}=1$:
$$f(v,v) = (v_0+v_4)(v_2+v_6) + (v_1+v_5)(v_3+v_7) + c_{57}(v_0+v_2+v_4+v_6)(v_1+v_3+v_5+v_7).$$
Avaliemos $B_0(\delta) = \sum_{v \preceq m_{8,\delta}} (-1)^{f(v,v)}$ nos $64$ pontos de cada $m_{8,\delta}$:

1. **Caso $\delta = 4$ (`0x7777`, zeros em $\{3, 7\}$, logo $v_3 = v_7 = 0$):**
   * Já calculado por `VERIFICAR_SETIMA_CONDICAO_T31.py`!
   * Com $c_{99} = 1$: para $c_{57} = 0$, $B_0(4) = \mathbf{32}$; para $c_{57} = 1$, $B_0(4) = \mathbf{0}$!
2. **Caso $\delta = 2$ (`0x5f5f`, zeros em $\{5, 7\}$, logo $v_5 = v_7 = 0$):**
   * Substituindo $v_5 = v_7 = 0$ em $f(v,v)$:
     - $(v_1 + 0)(v_3 + 0) = v_1 v_3$;
     - $(v_0+v_4)(v_2+v_6) + v_1 v_3 + c_{57}(v_0+v_2+v_4+v_6)(v_1+v_3)$.
   * Note a simetria: ponha $X_0 = v_0+v_4$, $X_2 = v_2+v_6$ ($2$ variáveis livres, mais $2$ variáveis mudas $v_4, v_6$ que multiplicam a soma por $2^2 = 4$!), e $X_1 = v_1$, $X_3 = v_3$ ($2$ variáveis)!
   * A forma em $(X_0, X_2, X_1, X_3) \in \mathbb{F}_2^4$ é **IDÊNTICA** à forma de $\mathbb{F}_2^8$ inteiro: $X_0 X_2 + X_1 X_3 + c_{57}(X_0+X_2)(X_1+X_3)$, cuja soma em $\mathbb{F}_2^4$ já calculamos na Seção 3 e vale $+4$ (se $c_{57}=0$) e $-4$ (se $c_{57}=1$)!
   * Multiplicando por $4$ (das variáveis mudas $v_4, v_6$):
     $$B_0(2) = 4 \times 4 (-1)^{c_{57}} = \mathbf{16 \, (-1)^{c_{57}}} = \pm \mathbf{16}!!$$

**PARE IMEDIATAMENTE!! OLHE O VALOR DE $B_0(2)$ NO RAMO $c_{99} = 1$!!**
* Em `0x7777` ($\delta = 4$), $B_0(4) \in \{32, 0\}$, que é **múltiplo de 32**!
* Em **`0x5f5f` ($\delta = 2$)** — cujo complementar é `0xa0a0`, rotacionalmente equivalente a `0x0505` = **A PRÓPRIA ÓRBITA 99 ($c_{99}=1$)**!! — o termo diagonal vale:
  $$B_0(2) = \pm 16 \equiv \mathbf{16} \pmod{32} \qquad \text{SEMPRE que } c_{99} = 1!!$$
  *(Enquanto para $c_{99} = 0$: $f(v,v) = c_{57}(X_0+X_2)(v_1+v_3)$, soma em $\mathbb{F}_2^4$ vale $8$ se $c_{57}=1 \implies B_0(2) = 32$, ou $16$ se $c_{57}=0 \implies B_0(2) = 64$; em AMBOS os casos de $c_{99}=0$, $B_0(2) \in \{64, 32\} \equiv \mathbf{0} \pmod{32}$!!)*

**VERIFIQUEMOS O QUE ISSO FORÇA EM `0x5f5f` ($\delta = 2$)!!**
Para qualquer $f \in H(16,4)$ sob T20:
$$\tilde{h}_f(\text{`0x5f5f`}) = B_0(2) + \sum_{\substack{v,w \preceq \text{`0x5f`} \\ v < w}} 2 (-1)^{f(v,w)} = B_0(2) + 4032 - 4 \operatorname{wt}(\tilde{t}_{f,2}).$$
1. Para $\tilde{h}_f(\text{`0x5f5f`})$ ser divisível por $16$ (necessário pela equação $(\star_2)$ sempre que todos os $W_f$ do lado direito forem múltiplos de $32$, e **obrigatório por bentness** onde todos os $W_f = \pm 256$ implicam **$32 \mid \tilde{h}_f(\text{`0x5f5f`})$**!):
   * Como $4032 = 126 \times 32 \equiv 0 \pmod{32}$ e **$B_0(2) = \pm 16 \equiv 16 \pmod{32}$ no ramo $c_{99}=1$**:
     $$\tilde{h}_f(\text{`0x5f5f`}) \equiv 16 - 4 \operatorname{wt}(\tilde{t}_{f,2}) \pmod{32}!!$$
   * Primeiro, como $16 \mid \tilde{h}_f(\text{`0x5f5f`})$ (ou testando se $4 \mid \operatorname{wt}(\tilde{t}_{f,2})$!):
     - Em `0x7777` (T31), `VERIFICAR_SETIMA_CONDICAO_T31.py` verificou `assert all(w.bit_count()%4==0 for w in basis)` (para $\tilde{h}$, sem `O`), o que significava $4 \mid \operatorname{wt}(\tilde{t}_{f,4})$, logo $16 \mid 4\operatorname{wt}(\tilde{t}_{f,4})$.
     - Em `0x5f5f`, como $(\star_2)$ tem $W_f(Q_2) = W_f(\text{`0x0505`})$ no lado direito e $16 \mid W_f(b)$ para grau 4, temos $16 \mid 16 \tilde{h}_f$ trivialmente, mas para ter **$32 \mid \tilde{h}_f(\text{`0x5f5f`})$** (exigido se todos os $8$ termos de $(\star_2)$ forem $\pm 256$, pois a soma de $16$ parcelas $\pm 256$ é $256(16-2r) \equiv 0 \pmod{512} \implies \tilde{h}_f(\text{`0x5f5f`}) \equiv \mathbf{0} \pmod{32}$!!):
     $$\tilde{h}_f(\text{`0x5f5f`}) \equiv 0 \pmod{32} \iff 4 \operatorname{wt}(\tilde{t}_{f,2}) \equiv 16 \pmod{32} \iff \mathbf{\operatorname{wt}(\tilde{t}_{f,2}) \equiv 4 \pmod 8}!!$$
   * *(Contraste com $c_{99} = 0$: lá $B_0(2) \equiv 0 \pmod{32}$, então $\tilde{h}_f(\text{`0x5f5f`}) \equiv 0 \pmod{32}$ exige $\operatorname{wt}(\tilde{t}_{f,2}) \equiv 0 \pmod 8$, onde a função zero $f=0$ passa! Já em $c_{99} = 1$, a constante $\mathbf{1}$ aparece no polinômio de $\tilde{h}_f(\text{`0x5f5f`})/16 \bmod 2$ porque $B_0(2)/16 = \pm 1 \equiv \mathbf{1} \pmod 2$!!)*

Calculemos também $B_0(1)$ (`0x3f3f`, zeros em $\{6,7\}$) e $B_0(3)$ (`0x6f6f`, zeros em $\{4,7\}$) no ramo $c_{99}=1$:
* **Caso $\delta = 1$ (`0x3f3f`, $v_6 = v_7 = 0$):**
  - $X_0 = v_0+v_4$ (muda $v_4$, fator $2$), $X_2 = v_2$ (sem muda!), $X_1 = v_1+v_5$ (muda $v_5$, fator $2$), $X_3 = v_3$ (sem muda!).
  - Novamente $2$ variáveis mudas ($v_4, v_5$, fator $4$) e **a mesmíssima forma não-degenerada** $X_0 X_2 + X_1 X_3 + c_{57}(X_0+X_2)(X_1+X_3)$ em $\mathbb{F}_2^4$!!
  - Logo **$B_0(1) = \pm 16 \equiv 16 \pmod{32}$ TAMBÉM!**
* **Caso $\delta = 3$ (`0x6f6f`, $v_4 = v_7 = 0$):**
  - $X_0 = v_0$ (sem muda), $X_2 = v_2+v_6$ (muda $v_6$, fator $2$), $X_1 = v_1+v_5$ (muda $v_5$, fator $2$), $X_3 = v_3$ (sem muda).
  - Novamente fator $4$ vezes $\pm 4$: **$B_0(3) = \pm 16 \equiv 16 \pmod{32}$ TAMBÉM!**

> **TEOREMA DIAGONAL DOS QUATRO SUPORTES SIMÉTRICOS DE PESO 12 (PROVADO EXATAMENTE):**
> Sob as três leis lineares de T20, os termos diagonais $B_0(\delta) = \sum_{v \preceq m_{8,\delta}} (-1)^{f(v,v)}$ nos quatro suportes `0x3f3f` ($\delta=1$), `0x5f5f` ($\delta=2$), `0x6f6f` ($\delta=3$) e `0x7777` ($\delta=4$) valem:
> * Se $c_{99} = 0$: $B_0(\delta) \in \{32, 64\} \equiv \mathbf{0} \pmod{32}$ para **todos** $\delta \in \{1,2,3,4\}$.
> * **Se $c_{99} = 1$**: $B_0(4) \in \{0, 32\} \equiv 0 \pmod{32}$, mas **para $\delta \in \{1, 2, 3\}$, $B_0(\delta) = 16(-1)^{c_{57}} \equiv \mathbf{16} \pmod{32}$**!

#### Teste contra as Testemunhas Auditadas para $(\star_\delta)$!
Será que $\tilde{h}_f(\text{mask}_\delta) \equiv 0 \pmod{32}$ (as "oitava, nona e décima condições" em `0x3f3f`, `0x5f5f`, `0x6f6f`) já elimina todas as funções de $c_{99}=1$, ou as testemunhas 7-de-8 podem passar nelas?
**Usemos a equação $(\star_\delta)$ nas testemunhas 7-de-8 para testar!**
Olhe a equação $(\star_2)$ reduzida módulo $512$ (que equivale a $\tilde{h}_f(\text{`0x5f5f`}) \equiv 0 \pmod{32}$!):
$$16 \, \tilde{h}_f(\text{`0x5f5f`}) = W_f(0) + 4 W_f(e_0) + 2 W_f(d_8) + 2 W_f(d_2) + 2 W_f(d_6) + 2 W_f(T_2^+) + 2 W_f(T_2^-) + W_f(\text{`0x0505`}).$$
Na testemunha **`0xfd`** (`w2_8_signed`: $d_8 = -256, d_2 = 768, d_6 = 256$, $W_f(0) = -256, W_f(e_0) = 256$):
* $W_f(0) + 4 W_f(e_0) + 2 W_f(d_8) + 2 W_f(d_2) + 2 W_f(d_6) = -256 + 1024 - 512 + 1536 + 512 = 2304 \equiv \mathbf{256} \pmod{512}$.
* Para que o lado direito seja $\equiv 0 \pmod{512}$, basta que $2 W_f(T_2^+) + 2 W_f(T_2^-) + W_f(\text{`0x0505`}) \equiv 256 \pmod{512}$ (por exemplo, se $W_f(T_2^\pm) \equiv 0 \pmod{256}$ e $W_f(\text{`0x0505`}) \equiv 256 \pmod{512}$).
* **Porém**, observe o que acontece em $(\star_1), (\star_2), (\star_3)$ quando reduzimos módulo $256$:
  Como $W_f(0) = \pm 256 \equiv 0 \pmod{256}$ e $4 W_f(e_0) = \pm 1024 \equiv 0 \pmod{256}$ sob $C_1\dots C_6$, se impusermos a máscara **`0xff`** ($W_f(d_1)=\dots=W_f(d_8)=\pm 256$), então $2 W_f(d_8) + 2 W_f(d_\delta) + 2 W_f(d_{8-\delta}) = 2(\pm 256 \pm 256 \pm 256) \equiv \mathbf{0} \pmod{512}$? Não: $2 \times (\pm 3 \text{ ou } \pm 1) \times 256 \equiv \mathbf{512}$? Espere: $2 \times 256 = 512$!!
  **SIM!! $2 \times (\pm 256) = \pm 512 \equiv 0 \pmod{512}$ PARA CADA TERMO COM FATOR 2!!**

**REFAÇA ESSA CONTA AGORA MESMO — ISTO É GIGANTESCO!!**
Em $(\star_\delta)$, **TODOS** os termos com coeficiente $2$ ou $4$ têm a forma $2 W_f(\cdot)$ ou $4 W_f(\cdot)$!
Se $f$ for bent, **TODO** $W_f(a) = \pm 256$, logo:
* $4 W_f(e_0) = \pm 1024 \equiv \mathbf{0} \pmod{512}$;
* $2 W_f(d_8) = \pm 512 \equiv \mathbf{0} \pmod{512}$;
* $2 W_f(d_\delta) = \pm 512 \equiv \mathbf{0} \pmod{512}$;
* $2 W_f(d_{8-\delta}) = \pm 512 \equiv \mathbf{0} \pmod{512}$;
* $2 W_f(T_\delta^+) = \pm 512 \equiv \mathbf{0} \pmod{512}$;
* $2 W_f(T_\delta^-) = \pm 512 \equiv \mathbf{0} \pmod{512}$!

Logo, módulo $512$, $(\star_\delta)$ colapsa para:
$$16 \, \tilde{h}_f(\text{mask}_\delta) \equiv W_f(0) + W_f(Q_\delta) \equiv 256 + 256 \equiv \mathbf{0} \pmod{512}!!$$
E **mesmo SEM bentness** (para qualquer função $f$ no espaço reduzido T20!):
Como $64 \mid W_f(d_j)$ (provado/observado em `cascade_periodic_report.json`), $2 W_f(d_j) \equiv 0 \pmod{128}$. Mas e $W_f(T_\delta^\pm)$ e $W_f(Q_\delta)$?
Pelo polinômio de valores em $\text{mask}_\delta$ (exatamente o método de `VERIFICAR_SETIMA_CONDICAO_T31.py` aplicado a `0x3f3f`, `0x5f5f`, `0x6f6f` — que o próprio documento T31 afirma na última seção já terem modelos exploratórios com verificação direta!):
* Em `0x7777` (com `chi`), o polinômio tinha grau $2$ ($360$ monômios) e colapsou para grau $1$ ($R=0$, $24$ variáveis) em $c_{99}=1$!
* Em `0x5f5f`, `0x6f6f` e `0x3f3f` (com e sem `chi`, dando **6 novos polinômios exatos** $\tilde{P}_\delta(c), P_\delta^{\chi}(c)$ de grau pequeno — tipicamente grau $\le 3$ pelo cancelamento de interseções quádruplas de pares $(v,w)$!), cada um impõe uma condição algébrica necessária $\tilde{P}_\delta(c) = 0$ e $P_\delta^\chi(c) = 0$!

**Por que precisamos testar os graus desses polinômios antes de afirmar contradição?**
Porque em `0x7777` sem `chi` ($\tilde{h}_f(\text{`0x7777`})$), o lado direito envolve $W_f(0)$ e $W_f(\text{`0x1111`})$; e nas testemunhas como `0x7f` ou `0xfd`, **não sabemos** se elas satisfazem $\tilde{h}_f(\text{`0x5f5f`}) \equiv 0 \pmod{32}$, pois essas testemunhas só foram filtradas até $C_7$ (`0x7777` com `chi`)! Elas **podem perfeitamente violar** `0x5f5f` ou `0x6f6f`, mas não todas as $2^{106}$ funções de $C_1\dots C_7$ precisam violá-los se os polinômios não forem algebricamente dependentes!

---

#### Via Algébrica 3 (A Mais Forte para Excluir `0xff` Diretamente): O Sistema Quadrático/Cúbico de Segunda Ordem (Derivadas Direcionais $\Delta_f(\text{`0x0101`}) = 0$ e $\Delta_f(\text{`0x1111`}) = 0$)

Aqui está a obstrução algébrica que **ataca diretamente `0x7f`, `0xfd`, `0xdf`, `0xf7`, `0xbf`** (onde congruências lineares de Walsh falham ou têm espaço demais) e cujo grau em $c \in \mathbb{F}_2^{113}$ é **estritamente quadrático**:

Considere a **autocorrelação (derivada direcional)** $\Delta_f(u) = \sum_{x \in \mathbb{F}_2^{16}} (-1)^{D_u f(x)}$, onde $D_u f(x) = f(x) \oplus f(x \oplus u)$.
Se $f$ é bent, **$\Delta_f(u) = 0$ para TODO $u \ne 0$**!

Escolha especificamente os vetores $u$ de alta simetria cíclica:
1. **$u = \text{`0xffff`}$ (complementação global $x \mapsto \bar{x}$):**
   * $D_{\text{`0xffff`}} f(x) = f(x) \oplus f(x \oplus \mathbf{1})$ tem **grau $\le 3$** e é **invariante por todo o grupo $C_{16}$**!
   * Mais ainda: como $f$ é homogênea de grau $4$, para cada órbita $O_j$, $D_{\mathbf{1}}(x_a x_b x_c x_d) = (x_a+1)(x_b+1)(x_c+1)(x_d+1) + x_a x_b x_c x_d$.
   * Somada sobre toda a órbita $O_j$ de tamanho $16$ (ou $8$), os termos constantes somam $|O_j| \equiv 0 \pmod 2$ (logo $D_{\mathbf{1}} f(\mathbf{0}) = 0$ sempre!), os termos lineares somam $\binom{4}{1}\frac{|O_j|}{16} \sum x_i = 4 \frac{|O_j|}{16} \sum x_i \equiv 0 \pmod 2$ para todas as órbitas longas ($|O_j|=16 \implies 4 \equiv 0$) e para órbitas de tamanho $8$ ($4 \times \frac{1}{2} = 2 \equiv 0$)! (Para $|O_{115}|=4$, daria $1 \cdot \sum x_i$, que é **por que T20 força $c_{115} = 0$**!! Pois se $c_{115}=1$, $D_{\mathbf{1}} f$ ou $f(x,x,x,x)$ teria termo linear ímpar!).
2. **$u = \text{`0x5555`}$ e $u = \text{`0x1111`}$ e $u = \text{`0x0101`}$ (troca ou translação periódica!):**
   * Tome **$u = \text{`0x5555`}$** (invariante por $\rho^2$, ordem $8$): $D_{\text{`0x5555`}} f(x)$ é uma função cúbica invariante por $\langle \rho^2 \rangle$.
   * Tome **$u = \text{`0x1111`}$** (invariante por $\rho^4$, ordem $4$): $D_{\text{`0x1111`}} f(x)$ é cúbica invariante por $\langle \rho^4 \rangle$.
   * **E OLHE PARA $u \in D_8 = \{(v,v) : v \in \mathbb{F}_2^8\}$** — em particular **$u = \text{`0x0101`}$** ($v = e_0 \in \mathbb{F}_2^8$), **$u = \text{`0x0505`}$** ($v = e_0 + e_2$, associada a $O_{99}$!!), **$u = \text{`0x1111`}$** ($v = \text{`0x11`}$), **$u = \text{`0x5555`}$** ($v = \text{`0x55`}$), **$u = \text{`0x3333`}$** ($v = \text{`0x33`}$)!

**Calculemos $D_u f$ restrita ao subespaço $D_8 = \{(w,w) : w \in \mathbb{F}_2^8\}$ quando $u = (v,v) \in D_8$!**
Como $D_8$ é fechado por adição, se $x = (w,w) \in D_8$ e $u = (v,v) \in D_8$, então $x \oplus u = (w \oplus v, w \oplus v) \in D_8$!!
Logo a restrição de $D_{(v,v)} f$ a $D_8$ é simplesmente a derivada direcional de $g(w) := f(w,w)$ na direção $v \in \mathbb{F}_2^8$!
E nós **JÁ PROVAΜOS** que para **TODA** $f$ no ramo $c_{99} = 1$ sob T20:
$$g(w) = (w_0+w_4)(w_2+w_6) + (w_1+w_5)(w_3+w_7) + c_{57}(w_0+w_2+w_4+w_6)(w_1+w_3+w_5+w_7)!$$
Olhe o **radical linear** de $g(w)$: $g(w)$ depende **apenas** de $(w_0+w_4, w_2+w_6, w_1+w_5, w_3+w_7)$, logo para **TODO** $v \in \mathbb{F}_2^8$ invariante por $\rho_8^4$ — isto é, $v \in \{\text{`0x11`}, \text{`0x33`}, \text{`0x55`}, \text{`0x77`}, \text{`0xff`}\}$ (correspondendo a **$u \in \{\text{`0x1111`}, \text{`0x3333`}, \text{`0x5555`}, \text{`0x7777`}, \text{`0xffff`}\}$**) — vale $v_i + v_{i+4} = 0$, donde:
$$D_u f(w,w) = g(w) \oplus g(w \oplus v) \equiv \mathbf{0} \pmod 2 \qquad \forall w \in \mathbb{F}_2^8!!$$
Isso significa que na decomposição de $\mathbb{F}_2^{16}$ em pares $\{(y_1, y_2), (y_2, y_1)\}$ sob $\rho^8$:
$$\Delta_f(u) = \sum_{w \in \mathbb{F}_2^8} (-1)^{D_u f(w,w)} + 2 \sum_{y_1 < y_2} (-1)^{D_u f(y_1, y_2)} = \mathbf{256} + 2 \sum_{y_1 < y_2} (-1)^{D_u f(y_1, y_2)}!!$$
*(Mais ainda: para $u = \text{`0xffff`}$, além de $\rho^8$, o ponto $(y_1, y_2)$ também emparelha com $(\bar{y}_1, \bar{y}_2)$, multiplicando a valoração 2-ádica de $\Delta_f(u)$!)*

E o que acontece quando **$u = \text{`0x0505`}$** ($v = e_0 + e_2$, logo $v_0+v_4 = 1, v_2+v_6 = 1, v_1+v_5 = 0, v_3+v_7 = 0$)?
* Em $c_{99} = 1$: $g(w) \oplus g(w \oplus v) = (X_0+1)(X_2+1) \oplus X_0 X_2 \oplus c_{57}((X_0+1)+(X_2+1))(X_1+X_3) \oplus c_{57}(X_0+X_2)(X_1+X_3) = X_0 + X_2 + 1$ — uma função **afim não-constante** em $D_8$, cuja soma sobre $w \in \mathbb{F}_2^8$ vale **ZERO** ($\sum_{w} (-1)^{D_{\text{`0x0505`}} f(w,w)} = 0$, enquanto para $c_{99}=0$ e $c_{57}=0$ valeria $+256$!!)!

---

#### Via Algébrica 4: Restrição Afim / Polinômios Exatos de $W_f(a)$ e Incompatibilidade Algébrica (Gröbner / SAT Simbólico sem Busca Cega)

Façamos agora um balanço crítico e honesto: por que $C_4$ (de $W_f(0)$ ou $W_f(\text{`0xffff`})$) e $C_7$ (`0x7777`) fatoraram em polinômios de grau $\le 2$ em $c \in \mathbb{F}_2^{113}$, enquanto $C_6$ (T28) teve $29.960$ monômios?
* **Motivo exato:** Um coeficiente $h_f(\text{mask})$ sobre um suporte de $N$ pontos tem expansão polinomial em $c$ obtida de `wt(t_f)` via a identidade simétrica elementar binária:
  $$\binom{\operatorname{wt}(t_f)}{2^r} \pmod 2.$$
  - Quando a simetria do suporte força os pesos individuais e interseções duas-a-duas dos geradores $w_i$ a serem múltiplos de $2^{r-1}$, o bit $\left\lfloor \frac{\operatorname{wt}(t_f)}{2^r} \right\rfloor \bmod 2$ tem **grau algébrico no máximo $r$** em $c \in \mathbb{F}_2^{113}$!
  - Em `0x7777` ($4096 = 2^{12}$ pontos, $2016$ pares): queríamos $\operatorname{wt}(t_f)/4 \bmod 2$ ($r = 2$, a priori grau $\le 3$ pelas interseções triplas `(basis[i]&basis[j]&basis[k]).bit_count()%2`), e os termos cúbicos se cancelaram, dando **grau $2$** (e **grau $1$** em $c_{99}=1$)!
  - Já em $W_f(a)$ sobre $\mathbb{F}_2^{16}$ inteiro ($65536 = 2^{16}$ pontos): querer $W_f(a) \equiv 0 \pmod{128}$ é pedir $\operatorname{wt}(f \oplus \ell_a) \equiv 0 \pmod{64}$ ($2^6$), e pedir $W_f(a) = \pm 256$ ($\equiv 256 \pmod{512}$) é pedir $\operatorname{wt}(f \oplus \ell_a) \equiv 128 \pmod{256}$ ($2^7$)! Sem redução por um estabilizador grande de $a$, o grau em $c$ cresce até $6$ ou $8$ (como os $29.960$ monômios de $C_6$)!

**MAS OLHE PARA OS SUPORTES DE PESO $\le 12$ E ESTABILIZADORES GRANDES!**
Se tomarmos suportes `mask` com **$\operatorname{wt}(\text{mask}) = 8$** ($256$ pontos!) ou **$\operatorname{wt}(\text{mask}) = 10$** ($1024$ pontos!) ou **$\operatorname{wt}(\text{mask}) = 12$** ($4096$ pontos!):
1. **Suportes de peso $8$ ($256$ pontos!):**
   Para qualquer função bent em $16$ variáveis, e **QUALQUER** máscara `mask` de peso $8$ ($\operatorname{wt}(\text{mask}) = 8$, logo $|\{b \preceq \overline{\text{mask}}\}| = 2^8 = 256$):
   $$256 \, h_f(\text{mask}) = \sum_{b \preceq \overline{\text{mask}}} W_f(\text{`0xffff`} \oplus b) = \sum_{b \preceq \overline{\text{mask}}} (\pm 256) \implies h_f(\text{mask}) = \sum_{b \preceq \overline{\text{mask}}} \sigma(\text{`0xffff`} \oplus b) \in \mathbb{Z}!$$
   **Cuidado!** Aqui $256 / 256 = 1$, então a simples divisibilidade 2-ádica dá apenas $2 \mid h_f(\text{mask})$... **A MENOS QUE `mask` SEJA INVARIANTE POR UM SUBGRUPO DE ROTAÇÕES**!
   Veja o que acontece quando **`mask` é invariante por $\rho^2$** (`mask = 0x5555`, peso 8!):
   * $\overline{\text{mask}} = \text{`0xaaaa`}$ também é invariante por $\rho^2$ (grupo $C_8$ de ordem $8$)!
   * Sob $C_8 = \langle \rho^2 \rangle$, os $256$ subconjuntos $b \preceq \text{`0xaaaa`}$ têm **EXATAMENTE a mesma decomposição de órbitas de $\mathbb{F}_2^8$ sob $\rho_8$** que fizemos na Seção 3!!
     - $30$ órbitas de tamanho $8 \implies 30 \times (\pm 8) \equiv \mathbf{0} \pmod{16}$;
     - $3$ órbitas de tamanho $4$ (`0x2222`, `0x6666`, `0xeeee` $\leftrightarrow$ `0x1111`, `0x3333`, `0x7777`!);
     - $1$ órbita de tamanho $2$ (`0x0a0a` $\leftrightarrow$ `0x0505` = **$O_{99}$**!!);
     - $2$ órbitas de tamanho $1$ (`0x0000` e `0xaaaa` $\leftrightarrow$ `0x5555`!).
   * Logo, se $f$ é bent, a soma $\tilde{h}_f(\text{`0x5555`}) = \sum_{x \preceq \text{`0x5555`}} (-1)^{f(x)}$ **sobre APENAS 256 PONTOS** deve satisfazer:
     $$\tilde{h}_f(\text{`0x5555`}) = \sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) + 2\sigma(\text{`0x0505`}) + 4\big(\sigma(\text{`0x1111`}) + \sigma(\text{`0x3333`}) + \sigma(\text{`0x7777`})\big) + 16 k!!$$
   **PARE TUDO E CALCULE $f(x)$ RESTRITA AOS 256 PONTOS DE `0x5555` (TODAS AS ÍMPARES $x_1 = x_3 = \dots = x_{15} = 0$)!!**

**VAMOS CALCULAR ISSO À MÃO AGORA MESMO — SÃO SÓ 8 VARIÁVEIS PARES $(x_0, x_2, x_4, x_6, x_8, x_{10}, x_{12}, x_{14})$!!**
Quando pomos $x_1 = x_3 = x_5 = x_7 = x_9 = x_{11} = x_{13} = x_{15} = 0$:
* Qualquer monômio $x_a x_b x_c x_d$ que misture coordenadas pares e ímpares **ANULA-SE IDENTICAMENTE**!
* Só sobrevivem os monômios cujos 4 índices são **todos pares**: $\{2i_0, 2i_1, 2i_2, 2i_3\}$!
* Em uma órbita $O_j$ de $H(16,4)$, se um representante tem 4 índices todos pares, então:
  - As $8$ rotações pares $\rho^{2r}$ mantêm os 4 índices pares (dando uma órbita de grau 4 em $8$ variáveis $y_r := x_{2r}$, $r \in \mathbb{Z}_8$!).
  - As $8$ rotações ímpares $\rho^{2r+1}$ mandam os 4 índices para todos ímpares (que se anulam em `0x5555`!).
* Quantos monômios de grau $4$ existem em $8$ variáveis $(y_0,\dots,y_7)$? Apenas $\binom{8}{4} = \mathbf{70}$ monômios, que sob rotação $\rho_8$ de $8$ variáveis formam **APENAS 10 ÓRBITAS** ($8$ órbitas de tamanho $8$, $1$ órbita de tamanho $4$ [`{0,1,4,5}` em $y$, que é **`{0,2,8,10}` = A NOSSA ÓRBITA $O_{99}$!!**], e $1$ órbita de tamanho $2$ [`{0,2,4,6}` em $y$, que é **`{0,4,8,12}` = A ÓRBITA $O_{115}$!!**])!!
  *(Conferência: $8 \times 8 + 1 \times 4 + 1 \times 2 = 64 + 4 + 2 = 70 = \binom{8}{4}$!!)*

**MEU DEUS, OLHE O QUE ACABAMOS DE DESCOBRIR!!**
Sobre o suporte `0x5555` ($256$ pontos, isomorfo a $\mathbb{F}_2^8$ nas variáveis $y_r = x_{2r}$):
1. Das **116 órbitas** de $H(16,4)$, **106 ÓRBITAS ANULAM-SE IDENTICAMENTE** em `0x5555`!!
2. Sobrevivem **APENAS 10 ÓRBITAS** de $H(16,4)$:
   * $c_{115}$ (`{0,4,8,12}` $\mapsto y_0 y_2 y_4 y_6 + y_1 y_3 y_5 y_7$), que vale **$c_{115} = 0$** pelas leis T20!
   * **$c_{99}$** (`{0,2,8,10}` $\mapsto y_0 y_1 y_4 y_5 + y_1 y_2 y_5 y_6 + y_2 y_3 y_6 y_7 + y_3 y_0 y_7 y_4$), que no nosso ramo está **FIXADA EM $c_{99} = 1$**!!
   * E apenas **8 órbitas longas** (as órbitas puramente pares: `{0,2,4,6}`, `{0,2,4,8}`, `{0,2,4,10}`, `{0,2,4,12}`, `{0,2,6,8}`, `{0,2,6,10}`, `{0,2,6,12}`, `{0,2,8,12}` — que são **8 dos 16 elementos do conjunto $L$ de T28/T31**? VERIFIQUEMOS!!)!

**VAMOS CONFERIR O CONJUNTO $L$ DE T31 (`L = [0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106]`, $|L|=16$)!!**
Por que $|L| = 16$ e a lei T20 impõe $c_{99} \equiv \sum_{j \in L} c_j \pmod 2$?!
* Porque em $H(8,4)$ há $8$ órbitas longas (e se olharmos `0x3333` ou `0x5555`...), espere: quantas órbitas puramente pares existem em $H(16,4)$? Acabamos de provar que $\binom{8}{4} = 70 = 8 \times 8 + 4 + 2$, logo há **EXATAMENTE 8 órbitas longas puramente pares**!
* Então o que é a restrição $f|_{\text{`0x5555`}}(y)$? É uma função em **$H(8, 4)$** (homogênea quártica rotacionalmente simétrica em **8 variáveis** $y_0,\dots,y_7$) dependendo de **APENAS 8 BITS LIVRES** $(b_1, \dots, b_8) \in \mathbb{F}_2^8$, com a órbita curta $\{0,1,4,5\}_y$ **FIXADA EM $c_{99} = 1$** e $\{0,2,4,6\}_y$ **FIXADA EM $c_{115} = 0$**!!
* **SÃO APENAS $2^8 = 256$ FUNÇÕES POSSÍVEIS EM $\mathbb{F}_2^8$ PARA O UNIVERSO INTEIRO DE $2^{106}$ FUNÇÕES DO RAMO $c_{99} = 1$!!**

**VAMOS VERIFICAR TODAS AS CONSEQUÊNCIAS DESTA REDUÇÃO DE $2^{106}$ PARA $2^8 = 256$ AGORA MESMO!!**

Seja $g_8(y) := f(y_0, 0, y_1, 0, y_2, 0, y_3, 0, y_4, 0, y_5, 0, y_6, 0, y_7, 0) \in H(8,4)$ a restrição de $f$ ao subespaço `0x5555`.
Pela Identidade de Poisson para o subespaço `0x5555` ($V_{\text{even}} \subset \mathbb{F}_2^{16}$, dimensão $8$, ortogonal a $V_{\text{odd}} = \{ a \preceq \text{`0xaaaa`} \}$), para **TODO** $\alpha \in \mathbb{F}_2^8$:
$$W_{g_8}(\alpha) := \sum_{y \in \mathbb{F}_2^8} (-1)^{g_8(y) \oplus \langle \alpha, y \rangle} = \frac{1}{256} \sum_{b \preceq \text{`0xaaaa`}} W_f\big(\iota_{\text{even}}(\alpha) \oplus b\big),$$
onde $\iota_{\text{even}}(\alpha) \preceq \text{`0x5555`}$ coloca $\alpha$ nas posições pares!

1. **Em $\alpha = \text{`0x00`}$ e $\alpha = \text{`0xff`}$ ($\iota_{\text{even}}(\text{`0xff`}) = \text{`0x5555`}$):**
   Se $f$ for bent em $\mathbb{F}_2^{16}$, então cada $W_f(\cdot)/256 = \sigma(\cdot) \in \{+1, -1\}$!
   Logo:
   * Para $\alpha = \text{`0x00`}$:
     $$W_{g_8}(\text{`0x00`}) = \sum_{b \preceq \text{`0xaaaa`}} \sigma(b) = \sigma(\text{`0x0000`}) + \sigma(\text{`0xaaaa`}) + 2\sigma(\text{`0x0a0a`}) + 4\big(\sigma(\text{`0x2222`}) + \sigma(\text{`0x6666`}) + \sigma(\text{`0xeeee`})\big) + 8 \sum_{r=1}^{30} \sigma(O_r).$$
     Por invariância rotacional de $f$: $\sigma(\text{`0xaaaa`}) = \sigma(\text{`0x5555`})$, $\sigma(\text{`0x0a0a`}) = \sigma(\text{`0x0505`})$.
     Note a congruência módulo $4$ de $W_{g_8}(\text{`0x00`})$:
     $$W_{g_8}(\text{`0x00`}) \equiv \sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) + 2\sigma(\text{`0x0505`}) \pmod 4!$$
     Como $\sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) \in \{-2, 0, +2\}$ e $2\sigma(\text{`0x0505`}) = \pm 2$:
     - Se $\sigma(\text{`0x0000`}) = \sigma(\text{`0x5555`})$ (que já vimos na Seção 3 estar ligado a $S_{U_4}$!), então $(\pm 2) + (\pm 2) \equiv \mathbf{0} \pmod 4$;
     - Se $\sigma(\text{`0x0000`}) = -\sigma(\text{`0x5555`})$, então $0 \pm 2 \equiv \mathbf{2} \pmod 4$;
     - Em **NENHUM** caso $W_{g_8}(\text{`0x00`})$ pode ser ímpar (claro, é par). Mas quanto vale $W_{g_8}(\text{`0x00`}) \bmod 8$ em $H(8,4)$ quando a órbita curta $\{0,1,4,5\}_y$ tem coeficiente $c_{99} = 1$ e $\{0,2,4,6\}_y$ tem coeficiente $c_{115} = 0$?!

**CALCULEMOS $W_{g_8}(\text{`0x00`}) \bmod 8$ EXATAMENTE AGORA!!**
Em $\mathbb{F}_2^8$, particione os $256$ pontos $y \in \mathbb{F}_2^8$ pela rotação $\rho_8$:
* $2$ pontos fixos (`0x00` e `0xff`):
  - $g_8(\text{`0x00`}) = 0 \implies (-1)^0 = +1$.
  - $g_8(\text{`0xff`}) \equiv 8 \cdot \sum_{r=1}^8 b_r + 4 \cdot c_{99} + 2 \cdot c_{115} = 0 + 0 + 0 = 0 \pmod 2 \implies (-1)^0 = +1$.
  Soma nos 2 pontos fixos $= +2$.
* $1$ órbita de tamanho $2$ (`0x55`, `0xaa`, onde $y = (1,0,1,0,1,0,1,0)$):
  - Em `0x55`, apenas os $4$ bits pares de $y$ valem $1$: o único monômio de grau $4$ suportado em $\{0,2,4,6\}$ é $y_0 y_2 y_4 y_6$, que pertence à órbita $c_{115} = 0$!!
  - Logo $g_8(\text{`0x55`}) = c_{115} = 0 \implies$ soma na órbita de tamanho $2$ vale $+2$!
* $3$ órbitas de tamanho $4$ (`0x11`, `0x33`, `0x77` em $\mathbb{F}_2^8$):
  - Em `0x11` ($\operatorname{wt}(y) = 2$): grau $4 \implies g_8(\text{`0x11`}) = 0 \implies$ soma $= +4$!
  - Em `0x33` ($y$ suportado em $\{0,1,4,5\}$, $\operatorname{wt}(y)=4$!): o **ÚNICO** monômio de grau $4$ suportado em $\{0,1,4,5\}$ é $y_0 y_1 y_4 y_5$, cujo coeficiente é **EXATAMENTE $c_{99}$**!!
    * Se $c_{99} = 0$: $g_8(\text{`0x33`}) = 0 \implies$ soma $= +4$.
    * **Se $c_{99} = 1$**: $g_8(\text{`0x33`}) = \mathbf{1} \implies (-1)^1 = -1 \implies$ **soma $= -4$**!!
  - Em `0x77` ($y$ suportado em $\{0,1,2,4,5,6\}$, $\operatorname{wt}(y)=6$, com $\binom{6}{4} = 15$ monômios de grau $4$!):
    Quais órbitas de $H(8,4)$ têm número **ímpar** de monômios contidos em $\{0,1,2,4,5,6\}$ (zeros em $\{3,7\}$)?
    Um monômio em $O$ está em $\{0,1,2,4,5,6\} \iff$ sua rotação não toca $3$ nem $7$.
    * Para `{0,2,4,6}` ($c_{115}=0$, tam. 2): $y_0 y_2 y_4 y_6$ não toca $\{3,7\}$, $y_1 y_3 y_5 y_7$ toca $\implies 1$ monômio, mas $c_{115}=0$!
    * Para `{0,1,4,5}` ($c_{99}=1$, tam. 4): `{0,1,4,5}` e `{1,2,5,6}` não tocam $\{3,7\}$, as outras 2 tocam $\implies 2 \equiv 0 \pmod 2$!
    * Para cada uma das **8 órbitas longas** $O_r$ de tamanho $8$ em $\mathbb{F}_2^8$: sob $\rho_8^4$ (que preserva $\{3,7\}$!), todo monômio $m \in O_r$ forma um **par distinto** $\{m, \rho_8^4(m)\}$ (pois a única órbita invariante por $\rho_8^4$ é `{0,1,4,5}` = $O_{99}$ e `{0,2,4,6}` = $O_{115}$!), e $m$ evita $\{3,7\} \iff \rho_8^4(m)$ evita $\{3,7\}$!!
    * **PORTANTO, TODA ÓRBITA LONGA TEM UM NÚMERO PAR DE MONÔMIOS EM `0x77`!!**
    * Logo **$g_8(\text{`0x77`}) = c_{115} = 0$ IDENTICAMENTE PARA TODAS AS $2^8$ ESCOLHAS!!** Soma em `0x77` $= +4$!
* $30$ órbitas de tamanho $8$: cada uma contribui $+8$ ou $-8$, logo a soma das $30$ órbitas vale $30 \times 8 - 16 s = 240 - 16 s \equiv \mathbf{0} \pmod{16}$!!

**SOME TUDO AGORA MESMO — SEM APROXIMAÇÃO, CONTA EXATA EM $\mathbb{Z}$!!**
$$W_{g_8}(\text{`0x00`}) = \underbrace{2}_{\text{fixos}} + \underbrace{2}_{\text{`0x55`}} + \underbrace{4}_{\text{`0x11`}} + \underbrace{4(-1)^{c_{99}}}_{\text{`0x33`}} + \underbrace{4}_{\text{`0x77`}} + \underbrace{240 - 16 s}_{30 \text{ órbitas de } 8}!!$$
* Para $c_{99} = 0$: $2 + 2 + 4 + 4 + 4 + 240 - 16 s = 256 - 16 s \equiv \mathbf{0} \pmod{16}$!
* **PARA $c_{99} = 1$**:
  $$W_{g_8}(\text{`0x00`}) = 2 + 2 + 4 - 4 + 4 + 240 - 16 s = 248 - 16 s \equiv \mathbf{8} \pmod{16}!!$$

**PARE O RELÓGIO!! LEIA E RELEIA AS DUAS EQUAÇÕES QUE ACABAMOS DE PROVAR PARA $W_{g_8}(\text{`0x00`})$!!**

1. **Pela geometria de $g_8 = f|_{\text{`0x5555`}}$ no ramo $c_{99} = 1$ (e $c_{115} = 0$ de T20):**
   $$W_{g_8}(\text{`0x00`}) \equiv \mathbf{8} \pmod{16} \quad \text{(em particular, } W_{g_8}(\text{`0x00`}) \equiv \mathbf{0} \pmod 4 \text{ e } \not\equiv 0 \pmod{16}\text{)}!!$$
   *(Observação imediata: qual lei T20 conserta isso? Releia a definição de $c_{99}$ em T31: `c = (1<<j) ^ ... ^ ((1<<99) if j in L else 0)`!! As 3 leis T20 **FORÇAM** $c_{99} \equiv \sum_{j \in L} c_j \pmod 2$ EXATAMENTE PORQUE $L$ É O CONJUNTO DAS 16 ÓRBITAS QUE TÊM CONTRIBUIÇÃO ÍMPAR $s \bmod 2$?! Espere: $248 - 16 s$ já é $8 \pmod{16}$ **QUALQUER QUE SEJA $s \in \mathbb{Z}$**!! Porque $16 s \equiv 0 \pmod{16}$!!)*

**VERIFIQUE A CONTA $2 + 2 + 4 - 4 + 4 + 240$ DE NOVO, COM RIGOR ABSOLUTO!!**
Vamos somar os tamanhos das órbitas de $\mathbb{F}_2^8$ sob $\rho_8$:
* Tamanho $1$: `0x00` (peso 0), `0xff` (peso 8) $\longrightarrow 2$ pontos.
* Tamanho $2$: `0x55` (peso 4: $\{0,2,4,6\}$ e $\{1,3,5,7\}$) $\longrightarrow 2$ pontos.
* Tamanho $4$: Quantas órbitas de tamanho $4$ existem em $\mathbb{F}_2^8$ (invariantes por $\rho_8^4$, mas não por $\rho_8^2$)?
  Um vetor $y \in \mathbb{F}_2^8$ é invariante por $\rho_8^4 \iff y = (u, u)$ com $u \in \mathbb{F}_2^4$.
  Há $2^4 = 16$ tais vetores!
  Dessas $16$ palavras:
  - $2$ têm período $1$ (`0x00`, `0xff` $\to$ tam. 1);
  - $2$ têm período $2$ (`0x55`, `0xaa` $\to$ tam. 2);
  - Sobram $16 - 4 = 12$ palavras, que formam $12 / 4 = \mathbf{3}$ órbitas de tamanho $4$:
    1. $u = \text{`0x1`}$ (`0x11`, peso 2: $\{0,4\}$) $\longrightarrow 4$ pontos;
    2. $u = \text{`0x3`}$ (`0x33`, peso 4: $\{0,1,4,5\}$) $\longrightarrow 4$ pontos;
    3. $u = \text{`0x7`}$ (`0x77`, peso 6: $\{0,1,2,4,5,6\}$) $\longrightarrow 4$ pontos!
  - E os outros $256 - 16 = 240$ pontos de $\mathbb{F}_2^8$ têm período estrito $8$, formando $240 / 8 = \mathbf{30}$ órbitas de tamanho $8$!
  Soma dos tamanhos: $2 + 2 + 4 + 4 + 4 + 240 = \mathbf{256}$. **100% EXATO!**

Agora reavalie $g_8(y)$ em cada representante quando $c_{115} = 0$ e $c_{99} = 1$:
1. `0x00` ($\operatorname{wt}=0$): $g_8(\text{`0x00`}) = 0 \implies (-1)^0 = +1$.
2. `0xff` ($\operatorname{wt}=8$): quantos monômios há em $g_8$?
   - Cada órbita longa de $H(8,4)$ tem $8$ monômios $\implies 8 \equiv 0 \pmod 2$.
   - A órbita `{0,1,4,5}` ($c_{99}$) tem $4$ monômios $\implies 4 \equiv 0 \pmod 2$.
   - A órbita `{0,2,4,6}` ($c_{115}$) tem $2$ monômios $\implies 2 \equiv 0 \pmod 2$.
   - Logo $g_8(\text{`0xff`}) = 0$ sempre! $\implies (-1)^0 = +1$.
   *(Soma tam. 1 $= 1 + 1 = \mathbf{2}$.)*
3. `0x55` ($\operatorname{wt}=4$, suporte $\{0,2,4,6\}$): único quádruplo é $\{0,2,4,6\}$, que é a órbita $c_{115}$!
   - Se $c_{115} = 0$: $g_8(\text{`0x55`}) = 0 \implies 2 \times (+1) = \mathbf{+2}$.
   - *(E se $c_{115} = 1$? Daria $2 \times (-1) = -2$, mudando a soma em $4$, não em $8$! Confiramos se `115` é realmente `{0,4,8,12}`: sim, a única órbita de tamanho 4 em $H(16,4)$!)*
4. `0x11` ($\operatorname{wt}=2$, suporte $\{0,4\}$): não contém nenhum conjunto de 4 elementos $\implies g_8(\text{`0x11`}) = 0 \implies 4 \times (+1) = \mathbf{+4}$.
5. `0x33` ($\operatorname{wt}=4$, suporte $\{0,1,4,5\}$): único conjunto de 4 elementos é $\{0,1,4,5\}$ em $y$, que corresponde em $x$ ($x_{2r} = y_r$) a **$\{0, 2, 8, 10\}$**!!
   - $\{0, 2, 8, 10\}$ é **EXATAMENTE** a órbita `99` ($c_{99} = 1$)!
   - Logo $g_8(\text{`0x33`}) = c_{99} = 1 \implies 4 \times (-1) = \mathbf{-4}$!!
6. `0x77` ($\operatorname{wt}=6$, suporte $\{0,1,2,4,5,6\}$, zeros em $\{3,7\}$):
   - Verifiquemos o pareamento por $\rho_8^4$: $\rho_8^4$ troca $0 \leftrightarrow 4$, $1 \leftrightarrow 5$, $2 \leftrightarrow 6$, $3 \leftrightarrow 7$.
   - Se um subconjunto $M \subset \{0,1,2,4,5,6\}$ de tamanho $4$ é **fixo** por $\rho_8^4$ ($\rho_8^4(M) = M$), então $M$ é união de **dois pares** dentre $\{\{0,4\}, \{1,5\}, \{2,6\}\}$!
   - Quantos pares de pares existem dentre $\{\{0,4\}, \{1,5\}, \{2,6\}\}$?! **$\binom{3}{2} = 3$ SUBCONJUNTOS FIXOS POR $\rho_8^4$**:
     * $\{0,4\} \cup \{1,5\} = \{0,1,4,5\}$ (está em $O_{\{0,1,4,5\}} = O_{99}$!);
     * $\{1,5\} \cup \{2,6\} = \{1,2,5,6\}$ (TAMBÉM está em $O_{\{0,1,4,5\}} = O_{99}$! $1+1 = 2 \equiv 0 \pmod 2$!);
     * **$\{0,4\} \cup \{2,6\} = \{0,2,4,6\}$** (está em $O_{\{0,2,4,6\}} = O_{115}$!!)!
   - **AHA!! ESPERE!! E $\{0, 2, 4, 6\}$ vs. OUTRAS ÓRBITAS?!** Nenhum outro subconjunto de tamanho 4 é fixo por $\rho_8^4$, porque um subconjunto de tamanho 4 fixo por uma involução sem pontos fixos $\rho_8^4$ TEM de ser união de 2 órbitas de tamanho 2 de $\rho_8^4$! Em $\{0,1,2,4,5,6\}$, as órbitas de $\rho_8^4$ são EXATAMENTE $\{0,4\}, \{1,5\}, \{2,6\}$! Logo os **ÚNICOS** subconjuntos de tamanho 4 fixos por $\rho_8^4$ em $\{0,1,2,4,5,6\}$ são $\{0,1,4,5\}$, $\{1,2,5,6\}$ e $\{0,2,4,6\}$! Todos os outros $15 - 3 = 12$ subconjuntos de tamanho 4 vêm em $6$ pares $\{M, \rho_8^4(M)\}$ com $M \ne \rho_8^4(M)$, e ambos pertencem à **mesma** órbita de $\rho_8$!
   - Logo, cada órbita longa de $\rho_8$ contém um número **PAR** de elementos em $\{0,1,2,4,5,6\}$! (A soma dos $12$ elementos nas órbitas longas é par em cada órbita!).
   - Portanto, $g_8(\text{`0x77`}) = c_{115} = 0 \implies 4 \times (+1) = \mathbf{+4}$!!
7. As $30$ órbitas de tamanho $8$: cada uma tem $8$ pontos com o mesmo valor de $g_8(y)$, logo contribui $+8$ ou $-8$.
   Se $r$ delas têm $g_8(y) = 1$, a contribuição é $(30 - r)(+8) + r(-8) = 240 - 16 r \equiv \mathbf{0} \pmod{16}$!!

**PORTANTO, ESTÁ 100% PROVADO SEM NENHUMA HIPÓTESE EXTRA:**
Para **TODA** função $f \in H(16,4)$ com $c_{115} = 0$ e $c_{99} = 1$:
$$\tilde{h}_f(\text{`0x5555`}) = W_{g_8}(\text{`0x00`}) = 248 - 16 r \equiv \mathbf{8} \pmod{16}!!$$

---

### 5. O Que $\tilde{h}_f(\text{`0x5555`}) \equiv 8 \pmod{16}$ Implica (e o Teste Rigoroso de Consistência!)

Agora compare $\tilde{h}_f(\text{`0x5555`}) \equiv 8 \pmod{16}$ com a expansão de Poisson sobre $b \preceq \text{`0xaaaa`}$ se $f$ for **BENT** ($\sigma(b) = W_f(b)/256 \in \{+1, -1\}$ para todo $b \preceq \text{`0xaaaa`}$):

Relembremos a decomposição de $\{b \preceq \text{`0xaaaa`}\}$ ($256$ frequências) sob $\rho^2$ (isomorfa a $\mathbb{F}_2^8$ sob $\rho_8$!):
* $1$ frequência de tam. 1: `0x0000` $\longrightarrow \sigma(\text{`0x0000`})$.
* $1$ frequência de tam. 1: `0xaaaa` (na órbita de `0x5555`) $\longrightarrow \sigma(\text{`0x5555`})$.
* $1$ órbita de tam. 2: `0x0a0a`? **ATENÇÃO EXTREMA AQUI!! CUIDADO COM O ISOMORFISMO $y_r = x_{2r+1}$!!**
  Em $\{b \preceq \text{`0xaaaa`}\}$ (posições $\{1,3,5,7,9,11,13,15\}$):
  - Qual é a órbita de tamanho $2$ sob $\rho^2$?! É `0x55` nas variáveis ímpares, isto é, $\{1, 5, 9, 13\} = \text{`0x2222`}$ (rotação de **`0x1111`**!!), **NÃO** `0x0a0a`!!
  *(FOI POR ISSO QUE FIZEMOS A VERIFICAÇÃO BIT A BIT!! Veja como a auditoria rigorosa salvou um erro de índice!)*

**REFAÇAMOS A TABELA EXATA DAS 6 ÓRBITAS CURTAS DE $\{b \preceq \text{`0xaaaa`}\}$ SOB $\rho^2$:**
As posições ímpares são $2r+1$ para $r = 0,1,2,3,4,5,6,7$:
1. $y = \text{`0x00`}$ ($1$ elem.): $b = \text{`0x0000`}$ $\longrightarrow 1 \cdot \sigma(\text{`0x0000`})$.
2. $y = \text{`0xff`}$ ($1$ elem.): $b = \text{`0xaaaa`}$ (órbita de `0x5555`) $\longrightarrow 1 \cdot \sigma(\text{`0x5555`})$.
3. $y = \text{`0x55`}$ ($2$ elem., $r \in \{0,2,4,6\} \implies$ bits $\{1,5,9,13\}$): $b = \text{`0x2222`}$ (**órbita de `0x1111`**!) $\longrightarrow 2 \cdot \sigma(\text{`0x1111`})$.
4. $y = \text{`0x11`}$ ($4$ elem., $r \in \{0,4\} \implies$ bits $\{1, 9\}$): $b = \text{`0x0202`}$ (**órbita de `0x0101` = $d_8$**!) $\longrightarrow 4 \cdot \sigma(\text{`0x0101`})$.
5. $y = \text{`0x33`}$ ($4$ elem., $r \in \{0,1,4,5\} \implies$ bits $\{1,3,9,11\}$): $b = \text{`0x0a0a`}$ (**órbita de `0x0505` = $O_{99}$**!) $\longrightarrow 4 \cdot \sigma(\text{`0x0505`})$.
6. $y = \text{`0x77`}$ ($4$ elem., $r \in \{0,1,2,4,5,6\} \implies$ bits $\{1,3,5,9,11,13\}$): $b = \text{`0x2a2a`}$ (**órbita de `0x1515`**!) $\longrightarrow 4 \cdot \sigma(\text{`0x1515`})$.
7. As $30$ órbitas de tamanho $8$ sob $\rho^2$: contribuem $240 - 16 q \equiv \mathbf{0} \pmod{16}$!!

**AGORA IGUALE OS DOIS LADOS MÓDULO $16$ SE $f$ FOR BENT ($\sigma(\cdot) \in \{+1, -1\}$)!!**
Pela igualdade exata $\tilde{h}_f(\text{`0x5555`}) = \sum_{b \preceq \text{`0xaaaa`}} \sigma(b)$:
* **Lado Esquerdo (provado para toda $f$ com $c_{115}=0, c_{99}=1$):**
  $$\tilde{h}_f(\text{`0x5555`}) \equiv \mathbf{8} \pmod{16}!$$
* **Lado Direito (para $\sigma_i \in \{+1, -1\}$):**
  $$RHS \equiv \underbrace{\sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) + 2\sigma(\text{`0x1111`})}_{\in \{-4, -2, 0, +2, +4\}} + 4\big(\underbrace{\sigma(\text{`0x0101`}) + \sigma(\text{`0x0505`}) + \sigma(\text{`0x1515`})}_{\in \{-3, -1, +1, +3\}}\big) \pmod{16}!$$

**OLHE A EQUAÇÃO MÓDULO 4 PRIMEIRO (ONDE AS TRÊS LEIS T20 ENTRAM!!):**
* Lado Esquerdo $\equiv 8 \equiv \mathbf{0} \pmod 4$.
* Lado Direito $\equiv \sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) + 2\sigma(\text{`0x1111`}) \pmod 4$:
  - Exige $\sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) = \pm 2 \implies$ **$\sigma(\text{`0x0000`}) = \sigma(\text{`0x5555`})$**!!
* **E AGORA OLHE MÓDULO 8 e MÓDULO 16!!**
  Como $\sigma(\text{`0x0101`}) + \sigma(\text{`0x0505`}) + \sigma(\text{`0x1515`})$ é a soma de **3 números ímpares** ($\pm 1$), ela vale **SEMPRE $\pm 1$ ou $\pm 3$ (ÍMPAR!!)**!
  Multiplicada por $4$:
  $$4\big(\sigma(\text{`0x0101`}) + \sigma(\text{`0x0505`}) + \sigma(\text{`0x1515`})\big) \in \{-12, -4, +4, +12\} \implies \mathbf{\equiv 4 \pmod 8 \quad SEMPRE!!}$$
  Logo, para que $RHS \equiv 8 \equiv \mathbf{0} \pmod 8$, o primeiro bloco $\sigma(\text{`0x0000`}) + \sigma(\text{`0x5555`}) + 2\sigma(\text{`0x1111`})$ **TEM DE VALER $\pm 4$ ($\equiv 4 \pmod 8$), E NUNCA $0$**!!
  Ou seja, **É FORÇADO COM 100% DE NECESSIDADE MATEMÁTICA**:
  $$\sigma(\text{`0x0000`}) = \sigma(\text{`0x5555`}) = \sigma(\text{`0x1111`})!!$$
  Mais ainda! Juntando com o **Teorema de Sinal Forçado de $U_4$ da Seção 3**:
  Lembre que na Seção 3 provamos em $U_4$ que:
  $$\sigma(\text{`0x0000`}) + \sigma(\text{`0xffff`}) + 2\sigma(\text{`0x5555`}) + 4\big(\sigma(\text{`0x1111`}) + \sigma(\text{`0x3333`}) + \sigma(\text{`0x7777`})\big) \equiv 0 \pmod{16}!!$$
  Naquela equação de $U_4$, a parcela $4(\sigma(\text{`0x1111`}) + \sigma(\text{`0x3333`}) + \sigma(\text{`0x7777`}))$ **TAMBÉM vale $\pm 4$ ou $\pm 12 \equiv 4 \pmod 8$**, o que **TAMBÉM** força $\sigma(\text{`0x0000`}) + \sigma(\text{`0xffff`}) + 2\sigma(\text{`0x5555`}) = \pm 4$, isto é:
  $$\sigma(\text{`0x0000`}) = \sigma(\text{`0xffff`}) = \sigma(\text{`0x5555`})!!$$
  E fazendo o mesmo com `h_f(0x5555)` **COM `chi`** (centrado em `0xffff` em vez de `0x0000`!):
  Em `h_f(0x5555)` com `chi`: como todo ponto $y \in \mathbb{F}_2^8$ das órbitas `0x00`, `0xff`, `0x55`, `0x11`, `0x33`, `0x77` tem **peso de Hamming PAR** ($0, 8, 4, 2, 4, 6$ — TODOS PARES!!), nas 6 órbitas curtas $(-1)^{\operatorname{wt}(y)} = +1$ **NÃO MUDA NADA**, logo $h_f(\text{`0x5555`}) \equiv \mathbf{8} \pmod{16}$ **TAMBÉM**, forçando:
  $$\sigma(\text{`0xffff`}) = \sigma(\text{`0x5555`}) = \sigma(\text{`0xeeee`}) = \sigma(\text{`0x7777`})!!$$
  E voltando à equação de $U_4$ módulo $16$ com $\sigma_0 := \sigma(\text{`0x0000`}) = \sigma(\text{`0xffff`}) = \sigma(\text{`0x5555`}) = \sigma(\text{`0x1111`}) = \sigma(\text{`0x7777`})$:
  $$S_{U_4} = \sigma_0 + \sigma_0 + 2\sigma_0 + 4\big(\sigma_0 + \sigma(\text{`0x3333`}) + \sigma_0\big) = 12 \sigma_0 + 4 \sigma(\text{`0x3333`}) \equiv 0 \pmod{16} \implies \mathbf{\sigma(\text{`0x3333`}) = \sigma_0}!!$$

> ### TEOREMA 1 (Rigidez Total de Sinal em $U_4$ no Ramo $c_{99} = 1$ — 100% Provado Aqui!)
> Para **qualquer** função bent $f \in H(16,4)$ satisfazendo $c_{115} = 0$ e $c_{99} = 1$, **TODAS as 16 frequências do subespaço periódico $U_4$ têm OBRIGATORIAMENTE o mesmo sinal $\sigma_0 \in \{+1, -1\}$**:
> $$W_f(\text{`0x0000`}) = W_f(\text{`0x1111`}) = W_f(\text{`0x3333`}) = W_f(\text{`0x5555`}) = W_f(\text{`0x7777`}) = W_f(\text{`0xffff`}) = 256 \, \sigma_0!!$$
> **CONSEQUÊNCIA IMEDIATA DE SOMA DE POISSON EM $U_4$:**
> Como todas as $16$ frequências de $U_4$ valem $256 \sigma_0$:
> $$\sum_{x \in U_4^\perp} (-1)^{f(x)} = \frac{1}{16} \sum_{a \in U_4} W_f(a) = \frac{16 \times 256 \sigma_0}{16} = \mathbf{256 \, \sigma_0},$$
> e para **QUALQUER** $v \in \mathbb{F}_2^4 \setminus \{0\}$ (todos os outros $15$ cosets $C_v = \{x \in \mathbb{F}_2^{16} : x^{(0)} \oplus x^{(1)} \oplus x^{(2)} \oplus x^{(3)} = v\}$ de tamanho $4096$!):
> $$H(v) = \sum_{x \in C_v} (-1)^{f(x)} = \frac{1}{16} \sum_{a \in U_4} (-1)^{\langle u_a, v \rangle} (256 \sigma_0) = \mathbf{0} \qquad \forall v \in \mathbb{F}_2^4 \setminus \{0\}!!$$

**LEIA A ÚLTIMA LINHA TRÊS VEZES — ELA ACABA DE TRANSFORMAR O PROBLEMA INTEIRO!!**

Se existir uma função bent $f \in H(16,4)$ com $c_{99} = 1$ (e $c_{115} = 0$), então:
1. Em **TODOS os 15 cosets não-nulos $C_v$ ($v \in \mathbb{F}_2^4 \setminus \{0\}$)**, $f$ tem de ser **EXATAMENTE BALANCEADA** ($2048$ zeros e $2048$ uns em cada coset de $4096$ pontos: $H(\text{`0x1`}) = H(\text{`0x3`}) = H(\text{`0x5`}) = H(\text{`0x7`}) = H(\text{`0xf`}) = \mathbf{0}$!!)!
2. **VERIFIQUEMOS JÁ $H(\text{`0xf`})$ e $H(\text{`0x5`})$ NO ESPAÇO DE 116 ÓRBITAS!**
   O que é o coset $C_{\text{`0xf`}} = \{ x \in \mathbb{F}_2^{16} : x^{(0)} \oplus x^{(1)} \oplus x^{(2)} \oplus x^{(3)} = \text{`0xf`} \}$ e o coset $C_{\text{`0x5`}}$?!
   * Lembre que $x^{(0)} \oplus x^{(1)} \oplus x^{(2)} \oplus x^{(3)} = (x_0+x_4+x_8+x_{12}, \, x_1+x_5+x_9+x_{13}, \, x_2+x_6+x_{10}+x_{14}, \, x_3+x_7+x_{11}+x_{15})$!
   * Considere os pontos de $C_v$ que pertencem ao **subespaço diagonal $D_8 = \{(w,w) : w \in \mathbb{F}_2^8\}$**!
     Em $x = (w,w)$ ($x^{(2)} = x^{(0)}$ e $x^{(3)} = x^{(1)}$!), temos:
     $$x^{(0)} \oplus x^{(1)} \oplus x^{(2)} \oplus x^{(3)} = x^{(0)} \oplus x^{(1)} \oplus x^{(0)} \oplus x^{(1)} = \mathbf{0}!!$$
     Ou seja, **TODA A DIAGONAL $D_8$ CAI INTEIRA DENTRO DE $C_{\text{`0x0`}}$, E OS 15 COSETS $C_v$ ($v \ne 0$) NÃO TÊM NENHUM PONTO FIXO SOB $\rho^8$!!**
   * Melhor ainda: sob o grupo $\langle \rho^4, \text{involuções} \rangle$, em $C_{\text{`0xf`}}$ e $C_{\text{`0x5`}}$ (ambos invariantes por $\rho^2$, logo o grupo $C_8 = \langle \rho^2 \rangle$ ou mesmo $C_{16} = \langle \rho \rangle$ para $C_{\text{`0xf`}}$ age **INTEIRAMENTE DENTRO DE $C_{\text{`0xf`}}$**!!):
     **OLHE PARA $C_{\text{`0xf`}}$!!**
     $C_{\text{`0xf`}}$ é o conjunto dos $4096$ pontos $x \in \mathbb{F}_2^{16}$ tais que:
     $$x_i \oplus x_{i+4} \oplus x_{i+8} \oplus x_{i+12} = 1 \qquad \text{para } i = 0, 1, 2, 3!$$
     $C_{\text{`0xf`}}$ é **100% INVARIANTE PELO GRUPO COMPLETO $C_{16} = \langle \rho \rangle$ DE ORDEM 16**!!
     Vamos decompor os $4096$ pontos de $C_{\text{`0xf`}}$ em órbitas sob $C_{16}$!!
     - Pode um ponto $x \in C_{\text{`0xf`}}$ ser fixo por $\rho^8$ ($x_i = x_{i+8}$)?
       Se $x_i = x_{i+8}$, então $x_i \oplus x_{i+4} \oplus x_i \oplus x_{i+4} = \mathbf{0} \ne 1$!! **IMPOSSÍVEL!!**
     - Logo, **NENHUM PONTO DE $C_{\text{`0xf`}}$ É FIXO POR $\rho^8$ (E PORTANTO NENHUM PONTO TEM PERÍODO 1, 2, 4 OU 8)!!**
     - **TODOS OS 4096 PONTOS DE $C_{\text{`0xf`}}$ DIVIDEM-SE EXATAMENTE EM $4096 / 16 = \mathbf{256}$ ÓRBITAS LIVRES DE TAMANHO 16 SOB $C_{16}$!!**
     - Cada uma das $256$ órbitas contribui $+16$ ou $-16$ para $H(\text{`0xf`})$!
     - Para que $H(\text{`0xf`}) = 0$, $f$ restrita às **256 órbitas de $C_{\text{`0xf`}}$** (uma tabela-verdade de **apenas $256$ bits** $T_{\text{`0xf`}}(c) \in \mathbb{F}_2^{256}$, **LINEAR** nos $116$ coeficientes $c$!!) deve ter **EXATAMENTE PESO DE HAMMING 128** ($\operatorname{wt}(T_{\text{`0xf`}}(c)) = 128$)!!

   * **E AGORA OLHE PARA $C_{\text{`0x5`}}$ ($v = (1,0,1,0)$) E $C_{\text{`0x1`}}$ ($v = (1,0,0,0)$)!!**
     - Em $C_{\text{`0x5`}}$: $x_0+x_4+x_8+x_{12} = 1$, $x_2+x_6+x_{10}+x_{14} = 1$, $x_1+x_5+x_9+x_{13} = 0$, $x_3+x_7+x_{11}+x_{15} = 0$.
       Invariante por $\langle \rho^2 \rangle$ (ordem $8$). Nenhum ponto é fixo por $\rho^8$ (pois nos bits pares daria $0 \ne 1$)! Logo todos os $4096$ pontos de $C_{\text{`0x5`}}$ dividem-se em **$4096 / 8 = 512$ órbitas livres de tamanho 8** sob $\langle \rho^2 \rangle$, e $H(\text{`0x5`}) = 0 \iff$ um código linear $T_{\text{`0x5`}}(c) \in \mathbb{F}_2^{512}$ tem peso exato $256$!
     - Em $C_{\text{`0x1`}}$ e $C_{\text{`0x7`}}$ e $C_{\text{`0x3`}}$: também nenhum ponto é fixo por $\rho^8$, e todos são invariantes por $\langle \rho^4 \rangle$ (ordem $4$), dando códigos lineares de comprimento $1024$ que devem ter peso exato $512$!

   * **E OLHE O QUE ACONTECE EM $C_{\text{`0x0`}}$ ($H(\text{`0x0`}) = 256 \sigma_0$)!!**
     Em $C_{\text{`0x0`}}$ ($x_i \oplus x_{i+4} \oplus x_{i+8} \oplus x_{i+12} = 0$ para $i=0,1,2,3$), invariante por $C_{16}$:
     - Pontos fixos por $\rho^8$ em $C_{\text{`0x0`}}$: são **todos** os $256$ pontos de $D_8 = \{(w,w) : w \in \mathbb{F}_2^8\}$!
       E nós **JÁ CALCULAMOS** a soma de $(-1)^{f(x)}$ em $D_8$ no ramo $c_{99}=1$: vale **$64 (-1)^{c_{57}}$**!!
     - Sobram $4096 - 256 = 3840$ pontos em $C_{\text{`0x0`}} \setminus D_8$, que têm período estrito $16$ sob $C_{16}$, formando **$3840 / 16 = 240$ órbitas livres de tamanho 16**!!
     - Se $q_0 \in \{0, \dots, 240\}$ dessas $240$ órbitas têm $f = 1$, sua soma vale $(240 - 2 q_0) \times 16 = 3840 - 32 q_0 \equiv \mathbf{0} \pmod{32}$!
     - Somando com $D_8$:
       $$H(\text{`0x0`}) = 64 (-1)^{c_{57}} + 3840 - 32 q_0!$$
       Note que $64(-1)^{c_{57}} \equiv 64 \pmod{128}$, enquanto $3840 = 30 \times 128 \equiv 0 \pmod{128}$!
       Para que $H(\text{`0x0`}) = 256 \sigma_0 \equiv 0 \pmod{256}$:
       $$3840 \pm 64 - 32 q_0 = \pm 256 \implies q_0 = \frac{3840 + 64(-1)^{c_{57}} - 256 \sigma_0}{32} = 120 + 2(-1)^{c_{57}} - 8 \sigma_0 \equiv \mathbf{2} \pmod 4!!$$
       **OUTRA LEI LINEAR OU QUADRÁTICA EXATA SOBRE $\mathbb{F}_2$!!**
       Porque $q_0 \equiv 2 \pmod 4$ exige, primeiro, que **$q_0$ seja PAR ($q_0 \equiv 0 \pmod 2$ — uma LEI LINEAR em $c$!)** e, segundo, que **$\lfloor q_0 / 2 \rfloor \equiv 1 \pmod 2$ (uma LEI QUADRÁTICA em $c$, exatamente como $C_4$!!)**!!
       Mais ainda: em $C_{\text{`0xf`}}$ ($256$ órbitas de tamanho $16$, exigindo peso $q_{\text{`0xf`}} = 128 \equiv 0 \pmod 8$!):
       - $q_{\text{`0xf`}} \equiv 0 \pmod 2$ (lei linear);
       - $\lfloor q_{\text{`0xf`}} / 2 \rfloor \equiv 0 \pmod 2$ (lei quadrática);
       - $\lfloor q_{\text{`0xf`}} / 4 \rfloor \equiv 0 \pmod 2$ (lei de grau $\le 4$ sobre apenas $256$ palavras de código!).

---

#### Teste Rigoroso do Teorema 1 contra as Testemunhas Auditadas!
Vamos verificar se alguma testemunha contradiz as etapas provadas do Teorema 1 (lembrando que o Teorema 1 só assume $c_{115}=0$, $c_{99}=1$ e $|W_f(a)| = 256$ nas frequências de $U_8 \cup \{b \preceq \text{`0xaaaa`}\}$):
* Em `cascade_periodic_report.json`, sobre $446.594$ funções com $c_{99}=1$ e $C_1\dots C_7$:
  - `u2_0x5555`, `u4_0x1111`, `u4_w8_0x3333` passaram $|W_f(a)|=256$ individualmente em $\sim 26\%$, $\sim 17\%$ e $\sim 35\%$ dos casos, e em cascata (`0x5555` $\cap$ `0x1111` $\cap$ `0x0101`) sobraram $4.363 + 3.389 + 216 = 7.968$ funções!
  - Isso é **100% consistente** com o Teorema 1: funções não-bent podem satisfazer $|W_f|=256$ em `0x0000`, `0x5555`, `0x1111`, `0x3333`, `0x7777`, `0xffff` individualmente (e quando satisfizerem em todas as $256$ frequências de $U_8$ e `0xaaaa`, terão obrigatoriamente os 6 sinais iguais!).
  - E na cascata completa de `cascade_periodic_report.json`, ao adicionar `0x0003` até `0x0021` ($d=1\dots 5$), o número de sobreviventes caiu para **$0$ em todas as três bandas** ($235$ milhões de candidatos testados)!

---

### 6. Onde Está o Conflito Algébrico Decisivo para `c99 = 1`? (Síntese das Lacunas vs. Fatos)

Resumamos com rigor cirúrgico o que provamos aqui e o que **falta computar simbolicamente** para fechar uma prova de inexistência do ramo $c_{99} = 1$:

#### O que está PROVADO analiticamente nesta investigação:
1. **Refutação de qualquer obstrução puramente 2-ádica módulo $512$ em peso $\le 2$:** As testemunhas auditadas `0xfd` e `0xdf` satisfazem $c_{99}=1$, $C_1\dots C_7$, $W_f(0) \equiv W_f(e_0) \equiv W_f(e_0+e_d) \equiv 256 \pmod{512}$ para **todas as 8 distâncias** $d=1,\dots,8$ simultaneamente. Logo, nenhuma identidade apenas nos polinômios $P_d(c) = W_f(e_0+e_d)/64 \bmod 2$ ou mesmo módulo $512$ em peso $\le 2$ pode provar a inexistência de `0xff`.
2. **Identificação exata de $O_{99} = \text{órbita}(\{0,2,8,10\})$ (`0x0505`) e fórmula diagonal universal:** Em $D_8 = \{(w,w) : w \in \mathbb{F}_2^8\}$, toda $f$ sob T20 e $c_{99}=1$ reduz-se a uma única forma quadrática dependendo só de $c_{57}$, com $\sum_{w \in \mathbb{F}_2^8} (-1)^{f(w,w)} = 64(-1)^{c_{57}}$.
3. **Teorema Diagonal nos Suportes Simétricos de Peso 12 (`0x3f3f`, `0x5f5f`, `0x6f6f`):** Ao contrário de `0x7777` (onde $B_0(4) \in \{0,32\} \equiv 0 \pmod{32}$), nos três suportes `0x3f3f` ($\delta=1$), `0x5f5f` ($\delta=2$) e `0x6f6f` ($\delta=3$), o termo diagonal no ramo $c_{99}=1$ vale **$B_0(\delta) = 16(-1)^{c_{57}} \equiv 16 \pmod{32}$**! Isso injeta o termo constante **`1`** nas condições de divisibilidade por $32$ de $\tilde{h}_f(\text{mask}_\delta)$ e $h_f(\text{mask}_\delta)$, acoplando os pares de distâncias $(d_1, d_7)$, $(d_2, d_6)$ e $(d_3, d_5)$.
4. **Redução Exata de Dimensão $113 \to 8$ no Suporte `0x5555` e Teorema 1 (Rigidez em $U_4$):**
   * Restrita aos $256$ pontos de `0x5555`, $f$ colapsa para um subespaço de dimensão **apenas $8$** ($256$ funções ao todo!), e satisfaz identicamente $\tilde{h}_f(\text{`0x5555`}) \equiv h_f(\text{`0x5555`}) \equiv \mathbf{8} \pmod{16}$ quando $c_{99}=1, c_{115}=0$.
   * Isso força para qualquer função bent no ramo $c_{99}=1$:
     $$W_f(\text{`0x0000`}) = W_f(\text{`0x1111`}) = W_f(\text{`0x3333`}) = W_f(\text{`0x5555`}) = W_f(\text{`0x7777`}) = W_f(\text{`0xffff`}) = 256 \sigma_0,$$
     e portanto o anulamento **exato em $\mathbb{Z}$** de todas as 5 somas de cosets periódicos não-nulos:
     $$H(\text{`0x1`}) = H(\text{`0x3`}) = H(\text{`0x5`}) = H(\text{`0x7`}) = H(\text{`0xf`}) = 0, \qquad H(\text{`0x0`}) = 256 \sigma_0.$$

#### Lacunas Explicitamente em Aberto (Por que ainda não temos $\bot$ só no papel):
* **Lacuna 1:** Embora $\tilde{h}_f(\text{`0x5555`}) \equiv 8 \pmod{16}$ force os 6 sinais de $U_4$ a serem iguais, ela **não** dá contradição sozinha em `0x5555`, pois $6 \sigma_0 + 4(\sigma(\text{`0x0101`}) + \sigma(\text{`0x0505`}) + \sigma(\text{`0x1515`}))$ vale $4 \sigma_0 + 4(\pm 1 \text{ ou } \pm 3)$: tomando $\sigma(\text{`0x0101`}) + \sigma(\text{`0x0505`}) + \sigma(\text{`0x1515`}) = \sigma_0$ (ou $-3\sigma_0$), obtém-se $4\sigma_0 + 4\sigma_0 = 8\sigma_0 \equiv 8 \pmod{16}$! **(Nota adicional grátis: isto prova também a relação de sinais exata $\sigma(\text{`0x0101`}) \cdot \sigma(\text{`0x0505`}) \cdot \sigma(\text{`0x1515`}) = -\sigma_0$!!)**
* **Lacuna 2:** Ainda não reconstruímos explicitamente (como polinômios sobre $\mathbb{F}_2^{113}$ após T20 e $c_{99}=1$) os geradores de:
  1. $H(\text{`0x0`}), H(\text{`0xf`}), H(\text{`0x5`}), H(\text{`0x3`}), H(\text{`0x1`}), H(\text{`0x7`})$ (especialmente as leis lineares e quadráticas de $q_0 \equiv 2 \pmod 4$ em $C_{\text{`0x0`}}$ e $q_{\text{`0xf`}} \equiv 0 \pmod 8$ em $C_{\text{`0xf`}}$!);
  2. Os 6 polinômios de suporte $\tilde{h}_f, h_f$ em `0x3f3f`, `0x5f5f`, `0x6f6f` módulo $32$ e $64$;
  3. A projeção nos subespaços de dimensão mínima (como `0x3333`, que também tem $\operatorname{wt}=8$, logo $256$ pontos onde quase todas as $116$ órbitas se anulam!).

---

### 7. Plano de Certificado Reproduzível (Segundos em Python Padrão / SAT Simbólico, Sem Busca Cega)

A descoberta da redução a suportes de peso $8$ (`0x5555`, `0x3333`, `0x0f0f`, `0x00ff`, `0x3c3c`...) e aos cosets $C_v$ de $U_4^\perp$ permite um **certificado algébrico de baixa dimensão** que roda em **segundos** em Python padrão (ou com um solver CDCL/XOR-SAT como CryptoMiniSat / CaDiCaL sobre variáveis projetadas, caso necessário):

#### Etapa 1: Auditoria das Leis Lineares e Quadráticas nos Cosets de $U_4^\perp$ e Suportes de Peso 12 (< 2 segundos em Python puro)
Escrever um script `VERIFICAR_ALGEBRA_C99_1.py` (nos moldes exatos de `VERIFICAR_SETIMA_CONDICAO_T31.py`) que:
1. Constrói a base de $112$ direções livres no ramo $c_{99}=1$ (impondo T20 + $C_5: c_{57}=K$ + $C_7: R=0$, restando **$111$ variáveis livres**).
2. **Teste imediato de novas leis lineares/quadráticas exatas derivadas do Teorema 1 ($H(v) = 0$ e $H(0) = \pm 256$):**
   * Constrói a matriz geradora $G_{\text{`0x0`}} \in \mathbb{F}_2^{111 \times 240}$ sobre as $240$ órbitas de tamanho $16$ de $C_{\text{`0x0`}} \setminus D_8$, e $G_{\text{`0xf`}} \in \mathbb{F}_2^{111 \times 256}$ sobre as $256$ órbitas de tamanho $16$ de $C_{\text{`0xf`}}$ (e analogamente $G_{\text{`0x5`}} \in \mathbb{F}_2^{111 \times 512}$, $G_{\text{`0x1`}}, G_{\text{`0x3`}}, G_{\text{`0x7`}} \in \mathbb{F}_2^{111 \times 1024}$).
   * Verifica as congruências de pesos das linhas de $G_v$:
     - Calcula os polinômios de grau $\le 2$ (ou $\le 3$) de $q_0 \equiv 2 \pmod 4$ e $q_{\text{`0xf`}} \equiv 0 \pmod 4$ (e $q_{\text{`0x5`}} \equiv 0 \pmod 4$).
     - Verifica se alguma combinação linear dessas equações sobre $\mathbb{F}_2$ reduz a $1 = 0$ (contradição direta de Gröbner em grau $\le 2$!) com $C_4$!
3. **Reconstrução exata de `0x3f3f`, `0x5f5f`, `0x6f6f` (com e sem `chi`, como em T31):**
   * Aplica literalmente o algoritmo de `VERIFICAR_SETIMA_CONDICAO_T31.py` aos $2016$ pares de `0x3f`, `0x5f`, `0x6f` (tanto com `O = chi` quanto com `O = 0`), extraindo os 6 polinômios sobre as $111$ variáveis livres.
   * **Checagem de sanidade obrigatória (Oráculo de Contraexemplos):** Avalia todos os polinômios extraídos nas testemunhas auditadas (`0xbf`, `0xf7`, `0x7f`, `0xfd`, `0xdf`, `0x5f`, `0x7d`, `0xf5`, `0xd7`, `0x77`, `0xdd`)! Qualquer identidade válida para *toda* função de $C_1\dots C_7$ tem de valer nas testemunhas; qualquer condição necessária de *bentness* (como $H(v)=0$ ou $\tilde{h}_f(\text{mask}_\delta) \equiv 0 \pmod{32}$) revelará exatamente **qual** condição algébrica elimina cada testemunha 7-de-8!

#### Etapa 2: Projeção por Suportes de Peso 8 (Eliminação por Decomposição de Subespaços Pequenos, Segundos)
Observe o poder da redução que encontramos em `0x5555` (dimensão $8$!):
* Em **qualquer** subespaço $V \subset \mathbb{F}_2^{16}$ de dimensão $8$ (ou $9$, $10$), como:
  - $V_1 = \text{`0x5555`}$ ($8$ coordenadas pares: depende de **apenas $8$ órbitas longas**!);
  - $V_2 = \text{`0x3333`}$ ($8$ coordenadas $\{0,1,4,5,8,9,12,13\}$: depende apenas dos monômios suportados em `0x3333`, que são $\binom{8}{4} = 70$ monômios, logo **no máximo $\approx 18$ órbitas** de $H(16,4)$!);
  - $V_3 = \text{`0x0f0f`}$ ($\binom{8}{4} = 70$ monômios $\implies$ **no máximo $\approx 18$ órbitas**!);
  - $V_4 = \text{`0x00ff`}$ ($8$ coordenadas consecutivas $\{0,\dots,7\}$: $\binom{8}{4} = 70$ monômios $\implies$ depende de **apenas as órbitas com diâmetro circular $\le 7$**, cerca de **$35$ órbitas**!).
* Sobre cada um desses subespaços $V_i$ de $256$ pontos, se $f$ for bent em $\mathbb{F}_2^{16}$, então:
  1. Para todo $\alpha \in V_i^*$, $W_{f|_{V_i}}(\alpha) = \frac{1}{256} \sum_{b \in V_i^\perp} W_f(\alpha \oplus b)$ deve satisfazer **todas as cotas inteiras e congruências de órbitas** de uma soma de $256$ sinais $\pm 1$ invariante pelo estabilizador de $V_i$ (por exemplo, $|W_{f|_{V_i}}(\alpha)| \le 256$, congruências $\bmod 16$ quando invariante por $\rho^2$ ou $\rho^4$, e a **identidade de momentos de 4ª ordem de Canteaut–Charpin**: $\sum_{\alpha \in V_i^*} W_{f|_{V_i}}(\alpha)^4$ acoplada às derivadas direcionais em $V_i$!).
  2. Mais forte ainda: para $u \in \{\text{`0x5555`}, \text{`0x1111`}, \text{`0x3333`}, \text{`0x0101`}, \text{`0xffff`}\}$, a condição $\Delta_f(u) = 0$ (derivada cúbica balanceada) fatora nos cosets de $U_4^\perp$ e reduz-se a restrições em subespaços projetados!

#### Etapa 3: Certificação Formal Unificada (Decisão Algébrica / UNSAT com Prova DRAT ou Gröbner Nullstellensatz)
Se a Etapa 1 produzir $m$ equações lineares e quadráticas adicionais (de $H(v)=0$, $H(0)=\pm 256$, e dos suportes `0x3f3f`, `0x5f5f`, `0x6f6f`, `0x3333`, `0x5555`):
1. **Caso Ideal (Certificado de Nullstellensatz / Eliminação Gaussiana de Macauley em Grau $\le 3$):**
   * Reduz-se o sistema linear primeiro (eliminando mais $r$ das $111$ variáveis livres, potencialmente baixando a dimensão livre de $111$ para $\sim 80\text{--}95$).
   * Testa-se a matriz de Macaulay de grau $2$ (ou $3$) das formas quadráticas $\{C_4, Q_{\text{`0x0`}}, Q_{\text{`0xf`}}, Q_{\text{`0x3f3f`}}, Q_{\text{`0x5f5f`}}, Q_{\text{`0x6f6f`}}, \dots\}$ sobre $\mathbb{F}_2$. Uma matriz de Macaulay em grau $2$ tem $\binom{95}{2} + 95 + 1 = 4.561$ colunas — **eliminação gaussiana exata em $< 0.2$ segundos em Python puro**! Se $1$ pertencer ao span, o vetor de multiplicadores é um **certificado algébrico de 1 página verificável instantaneamente**.
2. **Caso de Acoplamento Inteiro / Booleano nos Códigos Pequenos ($C_{\text{`0xf`}}$ de comprimento $256$ + $C_{\text{`0x0`}}$ de comprimento $240$ + `0x5555` / `0x3333`):**
   * Codifica-se como instância SAT/PB exata sobre as $\le 95$ variáveis booleanas livres **apenas as equações exatas provadas**:
     - Leis lineares ($C_1, C_2, C_3, C_5, C_7$, paridades de $q_0, q_{\text{`0xf`}}, \dots$) via Gauss-XOR nativo;
     - $C_4 = 0$ ($4$ produtos de paridades de $8$ bits — apenas **8 variáveis auxiliares**!);
     - Cardinalidade exata $\operatorname{wt}(G_{\text{`0xf`}} c) = 128$ ($256$ XORs), $\operatorname{wt}(G_{\text{`0x0`}} c) \in \{120 \pm 2 \pm 8\}$ ($240$ XORs), $\operatorname{wt}(G_{\text{`0x5`}} c) = 256$ ($512$ XORs) — **todas decorrentes rigorosamente do Teorema 1 provado acima, sem nenhuma aproximação!**
   * Note que diferentemente da busca cega sobre $2^{106}$ pontos avaliando Walsh de $65.536$ pontos, estas restrições de cardinalidade atuam diretamente sobre transformações **lineares** $G_v c$! Se o sistema for UNSAT com certificado DRAT/VeriPB verificável independentemente, teremos uma **prova matemática formal e auditável** de $H(16,4)_{c_{99}=1} \cap \operatorname{Bent}(16) = \varnothing$; se for SAT, o solver devolverá em segundos uma **super-testemunha** que satisfaz $C_1\dots C_7$ e **todo o espectro periódico $U_4$** ($H(v)=0$ para todo $v \ne 0$), isolando exatamente qual frequência fora de $U_4$ (e qual identidade adicional) é necessária!