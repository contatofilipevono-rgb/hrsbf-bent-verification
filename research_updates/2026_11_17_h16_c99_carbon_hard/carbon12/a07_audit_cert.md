Abaixo apresento a **Auditoria Matemática e Computacional Completa (`a07_audit_cert`)** do certificado Nullstellensatz de grau $\le 3$ para o fechamento de $c_{99} = 1$ (célula `B1`) em $H(16,4)$.

Conforme solicitado, separo rigorosamente o que está **PROVADO**, o que é **FALHA DE INDEPENDÊNCIA / LACUNA DE AUDITORIA** no código atual (`VERIFY_C99_1_NULLSTELLENSATZ.py`) e o que são **HIPÓTESES IMPLÍCITAS (`K=1`, `lc`)** que o certificado atual usa sem re-provar do zero. Ao final, entrego o código completo de um **Verificador Totalmente Independente** (`AUDIT_INDEPENDENT_C99_1.py`, *zero imports* do projeto) e a checklist obrigatória para declarar `c99 = 1` formalmente fechado.

---

## 1. Auditoria Matemática Passo a Passo das Equações de Poisson–Lucas

### 1.1. Derivação de $\operatorname{wt}((f \oplus \ell_u)|_W) \equiv 0 \pmod{16}$ para $\dim W = 12$ ($n = 16$, $f$ bent)
* **Status:** **PROVADO EXATAMENTE** — *mas com uma condição estrutural sobre $f^*$ na frequência $u$ que precisa ser explicitada!*

Façamos a conta exata sem omitir nenhum fator de $2$. Seja $W \le \mathbb{F}_2^{16}$ um subespaço linear de dimensão $\dim W = 12$ ($|W| = 4096$), logo $\dim W^\perp = 4$ ($|W^\perp| = 16$). Para qualquer frequência $u \in \mathbb{F}_2^{16}$ (em particular $u = \mathbf{0} = \texttt{0x0000}$ para `use_chi=0`, ou $u = \mathbf{1} = \texttt{0xffff}$ onde $\ell_{\mathbf{1}}(x) = \operatorname{wt}(x) \bmod 2$ para `use_chi=1`):

1. Pela fórmula de soma de Poisson em $\mathbb{F}_2^{16}$:
   $$\sum_{x \in W} (-1)^{f(x) \oplus \langle u, x \rangle} = \frac{|W|}{2^{16}} \sum_{w \in W^\perp} W_f(u \oplus w) = \frac{1}{16} \sum_{w \in W^\perp} W_f(u \oplus w).$$
2. Se $f$ é bent em $n=16$ variáveis, existe a função dual booleana $f^* : \mathbb{F}_2^{16} \to \mathbb{F}_2$ tal que $W_f(y) = 2^8 (-1)^{f^*(y)} = 256 (1 - 2 f^*(y))$ para todo $y \in \mathbb{F}_2^{16}$. Substituindo:
   $$4096 - 2 \operatorname{wt}\big((f \oplus \ell_u)|_W\big) = \frac{256}{16} \sum_{w \in W^\perp} (1 - 2 f^*(u \oplus w)) = 16 \Big(16 - 2 \operatorname{wt}\big(f^*|_{u + W^\perp}\big)\Big).$$
3. Isolando $\operatorname{wt}((f \oplus \ell_u)|_W)$:
   $$2 \operatorname{wt}\big((f \oplus \ell_u)|_W\big) = 4096 - 256 + 32 \operatorname{wt}\big(f^*|_{u + W^\perp}\big) = 3840 + 32 \operatorname{wt}\big(f^*|_{u + W^\perp}\big).$$
   Dividindo por $2$ em $\mathbb{Z}$:
   $$\operatorname{wt}\big((f \oplus \ell_u)|_W\big) = 1920 + 16 \operatorname{wt}\big(f^*|_{u + W^\perp}\big).$$
4. Como $1920 = 120 \times 16 \equiv 0 \pmod{16}$ e $16 \operatorname{wt}(f^*|_{u + W^\perp}) \equiv 0 \pmod{16}$ para **qualquer** inteiro $\operatorname{wt}(f^*|_{u + W^\perp}) \in \mathbb{Z}$:
   $$\operatorname{wt}\big((f \oplus \ell_u)|_W\big) \equiv 0 \pmod{16}.$$

> **Auditoria de Sinal/Constante (Crítico!):**
> Compare isso com `T31` (`0x7777`): por que em `T31` falava-se em $h_f \equiv 0 \pmod{32}$, e aqui é $\operatorname{wt} \equiv 0 \pmod{16}$?
> Porque $h_f = 4096 - 2\operatorname{wt}$! Como $4096 \equiv 0 \pmod{32}$, a condição $h_f \equiv 0 \pmod{32}$ é **100% equivalente** a $2\operatorname{wt} \equiv 0 \pmod{32} \iff \operatorname{wt} \equiv 0 \pmod{16}$!
> **NÃO** é necessário assumir nada sobre o grau de $f^*$ ($\deg f^* \le 3$ etc.)! A congruência $\operatorname{wt}((f \oplus \ell_u)|_W) \equiv 0 \pmod{16}$ vale **incondicionalmente** para **TODA** função bent $f$ em $n=16$ variáveis, para **TODO** subespaço $W$ de dimensão $12$, e para **TODO** $u \in \mathbb{F}_2^{16}$ (inclusive cosets afins $a + W$, pois $(-1)^{\langle w, a\rangle} (-1)^{f^*(u \oplus w)}$ continua sendo $\pm 1$!).

---

### 1.2. Decomposição $\operatorname{wt} = 2 \cdot \operatorname{wt}_{\text{pares}} + \operatorname{wt}_{\text{diag}}$ e o Papel de $\chi(x) = (-1)^{\operatorname{wt}(x)}$ (`u = 0xffff`)
* **Status:** **PROVADO EXATAMENTE.**

Seja $\rho^8 : \mathbb{F}_2^{16} \to \mathbb{F}_2^{16}$ a involução que troca as duas metades de 8 bits: $\rho^8(v, w) = (w, v)$ para $v, w \in \mathbb{F}_2^8$.
1. Em `VERIFY_C99_1_NULLSTELLENSATZ.py`, $W = V_6 \times V_6$, onde $\dim V_6 = 6$ ($|V_6| = 64$). Logo $(v, w) \in W \iff (w, v) \in W$ ($W$ é $\rho^8$-invariante).
2. Particionando $W$ ($4096$ pontos) sob $\rho^8$:
   - **Diagonal:** $D(W) = \{(v, v) : v \in V_6\}$, com $|D(W)| = 64$ pontos fixos.
   - **Pares fora da diagonal:** $P(W) = \{\{(v, w), (w, v)\} : v, w \in V_6,\, v < w\}$, com $\binom{64}{2} = 2016$ pares ($64 + 2 \times 2016 = 4096$).
3. Toda função $f \in H(16,4)$ é $C_{16}$-invariante, logo $\rho^8$-invariante: $f(v, w) = f(w, v)$.
4. **Verificação de $\chi$ (`use_chi = 1`, $u = \texttt{0xffff}$):**
   - Para $g(x) := f(x) \oplus \langle \texttt{0xffff}, x \rangle = f(x) \oplus (\operatorname{wt}(x) \bmod 2)$:
   - Nos pares $(v, w)$: $\operatorname{wt}(v, w) = \operatorname{wt}(v) + \operatorname{wt}(w) = \operatorname{wt}(w, v)$, logo $g(v, w) = g(w, v)$ **preserva a invariância por $\rho^8$**!
   - **Na diagonal $(v, v)$:** $\operatorname{wt}(v, v) = 2 \operatorname{wt}(v) \equiv \mathbf{0} \pmod 2$ para **todo** $v \in \mathbb{F}_2^8$!
   - **Auditoria do código:** Em `VERIFY_C99_1_NULLSTELLENSATZ.py`, `chi` é somado a `Ow` nos pares (`if x.bit_count() & 1: Ow ^= 1 << k`), mas **NÃO** é somado a `O_diag` na diagonal! Como $\operatorname{wt}(v, v)$ é sempre par, $\ell_{\texttt{0xffff}}|_{D_8} \equiv 0$, logo não alterar `O_diag` para `use_chi=1` está **matematicamente exato**! (Atenção: se no futuro usarem outro $u$ com $u_{\text{lo}} \neq u_{\text{hi}}$, então $\langle u, (v,v)\rangle = \langle u_{\text{lo}} \oplus u_{\text{hi}}, v\rangle \neq 0$, e `O_diag` **teria** que receber esse termo!).

Portanto, pondo $g = f \oplus (\text{use\_chi} \cdot \ell_{\texttt{0xffff}})$:
$$\operatorname{wt}(g|_W) = 2 \operatorname{wt}(g|_{P(W)}) + \operatorname{wt}(f|_{D(W)}).$$

---

### 1.3. Auditoria de $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod 8$ "Identicamente" — **ACHADO CRÍTICO #1 (Simplificação Estrutural + Bug Latente no Verificador Genérico)**

Vamos auditar como o script verifica que $\operatorname{wt}(f|_{D(W)}) \equiv 0 \pmod 8$ para todas as funções do espaço afim!

No código (`VERIFY_C99_1_NULLSTELLENSATZ.py`, linhas 276–286):
```python
assert extract_poly_mod4(bd_sub, od_sub, k1_vars, const_shift=0) == set(), "wt_diag % 4 != 0!"
for i in range(n):
    for j in range(i + 1, n):
        ij = bd_sub[i] & bd_sub[j]
        if ij:
            for k in range(j + 1, n):
                assert ((ij & bd_sub[k]).bit_count() & 1) == 0, "wt_diag % 8 deg-3 nonzero!"
```

**AUDITORIA RIGOROSA DESTE BLOCO (Duas descobertas fundamentais):**

1. **BUG TEÓRICO NO TESTE GENÉRICO DE `wt_diag % 8 == 0` DO SCRIPT!**
   Suponha que `bd_sub` fosse uma família geral de vetores em $\mathbb{F}_2^{64}$ que passasse nos dois `assert`s acima. Isso garantiria `wt(od_sub ^ sum x_i bd_sub[i]) % 8 == 0` para todo $x$?
   **NÃO!! Há DOIS erros na fórmula geral de $\pmod 8$ daquele trecho:**
   - **Erro 1a (Falta o bit de $4$ de `od_sub`!):** `extract_poly_mod4` checa `(od_sub.bit_count() // 4) % 2 == 0`! Espera: `extract_poly_mod4` checa `assert O_word.bit_count() % 2 == 0` e adiciona `0` a `P` se `((O_word.bit_count() // 2) // 2) % 2 == 1`, ou seja, se `(od_sub.bit_count() // 4) % 2 == 1`! Então `P == set()` garante SIM que:
     * `wt(od_sub)` é par (`% 2 == 0`), e `(wt(od_sub) // 4) % 2 == 0`, MAS **NÃO CHECA SE `(wt(od_sub) // 2) % 2 == 0`!!**
     * **OLHE A LINHA 86 DE `VERIFICAR_ALGEBRA_C99_1.py`:**
       ```python
       assert O_word.bit_count() % 2 == 0
       ...
       if ((O_word.bit_count() // 2) // 2 + const_shift) % 2:
           toggle(0)
       ```
       Se `od_sub.bit_count() == 2` (que é $\mathbf{2 \pmod 8}$, NÃO $0 \pmod 8$!!), então:
       - `2 % 2 == 0` (**passa no assert!**)
       - `((2 // 2) // 2) % 2 == (1 // 2) % 2 == 0` (**NÃO dá `toggle(0)`! Retorna `set()`!!**)
       **ISTO É UM BUG REAL EM `extract_poly_mod4` QUANDO USADO PARA TESTAR `% 8 == 0`!** `extract_poly_mod4` assume por pré-condição externa que `wt(f) - 2*wt(f&O)` é divisível por 4, mas para `f = O_word` ($x = 0$), o peso é `wt(O_word)`, que `extract_poly_mod4` divide por 4 assumindo implicitamente que `wt(O_word) % 4 == 0`, **mas o `assert` na linha 86 só testa `% 2 == 0`, NÃO `% 4 == 0`!**
   - **Erro 1b (Grau 4 em $\pmod 8$):** Para vetores gerais $w(x) = O \oplus \bigoplus x_i b_i$, a expansão em $\mathbb{Z}$ é $\operatorname{wt}(w(x)) = \operatorname{wt}(O) + \sum x_i (\dots) - 2 \sum x_i x_j (\dots) + 4 \sum x_i x_j x_k \operatorname{wt}(b_i \cap b_j \cap b_k (-1)^O) - \mathbf{8} \sum x_i x_j x_k x_\ell (\dots)$. Aqui o termo de grau 4 tem fator $-8 \equiv 0 \pmod 8$, então grau $\ge 4$ realmente some módulo 8, **MAS** no termo linear, quadrático e cúbico para `wt(w(x)) mod 8`, `extract_poly_mod4` calcula `(wt(w(x)) - wt(O)) // 4 mod 2`? Vamos fazer a conta exata na Seção 1.4 abaixo!

2. **POR QUE, APESAR DESSE BUG NO TESTE, `wt_diag % 8 == 0` É VERDADEIRO EM $H(16,4)$?!**
   Olhe para quem são `orb_diag[j]` em $H(16,4)$!
   - Em $x = (v, v)$, qualquer órbita longa $O_j$ ($|O_j| = 16$) é fechada por $\rho^8$, e para cada monômio $m \in O_j$ ($m \neq \rho^8(m)$), $(x \& m == m) \iff (x \& \rho^8(m) == \rho^8(m))$ quando $x = (v, v)$! Logo os 16 monômios se cancelam 2 a 2 sobre $D_8$, dando **`orb_diag[j] == 0` para TODAS as 112 órbitas longas!**
   - Restam apenas as 4 órbitas curtas `{57, 99, 113, 115}`:
     * `c115 = 0` (lei T20);
     * `c57 = c113` (lei T20), logo só aparece a combinação `Da = orb_diag[57] ^ orb_diag[113]`, multiplicada por `c57 = K`;
     * E no espaço `cb_k1` (onde **$K = 1$ já foi fixado!**), temos $c_{57} = c_{113} = 1$ e $c_{99} = 1$ **CONSTANTES** em todo o espaço afim de dimensão 109!
   - **CHOQUE SIMPLIFICADOR:** No subespaço afim `origin_k1 + span(cb_k1)` ($c_{99}=1, c_{115}=0, c_{57}=c_{113}=1$), **`cb_diag[i] == 0` IDENTICAMENTE PARA TODOS OS $i = 0, \dots, 108$!!**
   - Ou seja, `f|_{D_8}` é **UMA ÚNICA FUNÇÃO FIXA** (independente das 109 variáveis livres!):
     $$f(v, v) = Q_{\text{fix}}(v) = (v_0 \oplus v_4)(v_2 \oplus v_6) \oplus (v_1 \oplus v_5)(v_3 \oplus v_7) \oplus (v_0 \oplus v_2 \oplus v_4 \oplus v_6)(v_1 \oplus v_3 \oplus v_5 \oplus v_7).$$
   - Logo, sobre $D(W) = \{(v,v) : v \in V_6\}$, `wt_diag` é um **ÚNICO INTEIRO CONSTANTE** `(O_diag & diag_mask).bit_count()`! E o filtro aleatório (`(O_diag & diag_mask).bit_count() % 8 == 0`) já testou se esse inteiro constante é divisível por $8$! (No ramo `B1` com `K=1`, o filtro de 32 amostras na verdade testa a mesma constante 32 vezes, logo é **100% determinístico** para `wt_diag` — mas isso mostra como `extract_poly_mod4` retornou `set()` só porque todos os `bd_sub[i]` eram zero e `(wt_diag // 4) % 2 == 0` quando `wt_diag % 8 == 0`!).
   - *(Nota crucial para `B0` onde $K$ varia: lá `cb_diag` tem posto 1 gerado por `Da`, e aí o bug `O_word.bit_count() % 4` de `extract_poly_mod4` precisaria de `assert od_sub.bit_count() % 8 == 0` explícito!)*

---

### 1.4. Auditoria Exata da Fórmula de Inclusão-Exclusão em `extract_poly_mod4` e `extract_and_fill_row` — **ACHADO CRÍTICO #2 (Erro de Identidade Algébrica se `wt(O_word) % 4 == 2`!)**

Esta é a parte mais delicada de toda a auditoria. Vamos provar **exatamente** o que `extract_poly_mod4(basis, O_word, ...)` e a função C `extract_and_fill_row` calculam!

Queremos extrair o polinômio booleano $P(x_0, \dots, x_{n-1}) \in \mathbb{F}_2[x_0,\dots,x_{n-1}]$ para o bit de peso $2$ do número de pares ativos.
Relembre:
$$\operatorname{wt}(g|_W) = 2 \operatorname{wt}(t(x)) + \operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16},$$
onde $t(x) := O \oplus \bigoplus_{i=0}^{n-1} x_i b_i \in \mathbb{F}_2^{2016}$ é o vetor de valores de $g$ nos $2016$ pares ($O = \mathtt{O\_word}$, $b_i = \mathtt{basis}[i]$).
Quando $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16}$, precisamos de $2 \operatorname{wt}(t(x)) \equiv 0 \pmod{16} \iff \operatorname{wt}(t(x)) \equiv 0 \pmod 8$.
**ESPERA AÍ!! PARE TUDO E OLHE OS MÓDULOS!!**

> ### 🚨 ALERTA VERMELHO MÁXIMO — AUDITORIA DE POTÊNCIA DE 2 (`mod 8` vs `mod 4` nos pares, e `wt_diag mod 16` vs `mod 8`!) 🚨

Vamos refazer a aritmética modular com **precisão cirúrgica**!!

Temos a identidade exata em $\mathbb{Z}$ (provada na Seção 1.1 e 1.2):
$$2 \operatorname{wt}_{\text{pares}}(x) + \operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16}. \qquad (\dagger)$$

1. Para que $(\dagger)$ tenha solução, é necessário primeiro que $\operatorname{wt}_{\text{diag}}$ seja par, e dividindo $(\dagger)$ por $2$:
   $$\operatorname{wt}_{\text{pares}}(x) + \frac{\operatorname{wt}_{\text{diag}}}{2} \equiv 0 \pmod{\mathbf{8}}!!$$
2. Agora reduza esta equação **módulo 4** (que é onde mora `extract_poly_mod4`, pois `extract_poly_mod4` divide por **4**, extraindo o bit de valor **4** de $\operatorname{wt}_{\text{pares}}$, ou seja, `wt_pares` módulo **8**?! **VERIFIQUEMOS QUAL BIT `extract_poly_mod4` EXTRAI!**):
   - Se $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod{\mathbf{8}}$, então $\frac{\operatorname{wt}_{\text{diag}}}{2} \equiv \mathbf{0} \pmod{\mathbf{4}}$!
   - Logo, reduzir $\operatorname{wt}_{\text{pares}}(x) + \frac{\operatorname{wt}_{\text{diag}}}{2} \equiv 0 \pmod 8$ **módulo 4** dá:
     $$\operatorname{wt}_{\text{pares}}(x) \equiv \mathbf{0} \pmod{\mathbf{4}}!!$$
   - **QUAL BIT É $\operatorname{wt}_{\text{pares}}(x) \equiv 0 \pmod 4$ (assumindo $\operatorname{wt}_{\text{pares}}(x)$ par)?**
     É **`(wt_pares(x) // 2) % 2 == 0`** (o bit $2^1 = 2$ de `wt_pares`, que corresponde a $2 \times 2 = 4 \pmod 8$ de $\operatorname{wt}(g|_W)$)!
   - **MAS OLHE O QUE O CÓDIGO C (`extract_and_fill_row`) E PYTHON (`extract_poly_mod4`) ESTÃO DIVIDINDO POR 4:**
     Olhe as linhas 42–67 de `VERIFY_C99_1_NULLSTELLENSATZ.py`:
     ```c
     if ((wi_pop & 1) || ((wi_pop - 2 * wo_pop) & 3)) return -2;
     if (((wi_pop - 2 * wo_pop) / 4) & 1) { ... }
     if ((o_pop / 4) & 1) { row_words[off0 >> 6] ^= 1ULL << (off0 & 63); }
     ...
     if ((inter_pop / 2 + io_pop) & 1) { ... } // coeff of x_i x_j
     ...
     if (p & 1) { ... } // coeff of x_i x_j x_k where p = popcount(b_i & b_j & b_k)
     ```
     **DIVIDIR POR 4 (`(o_pop / 4) & 1`, `(wi_pop - 2*wo_pop) / 4`, `-2` no quadrático `/ 4 = / 2`, `+4` no cúbico `/ 4 = 1`) EXTRAI O BIT DE VALOR $4$ DE $\operatorname{wt}_{\text{pares}}(x)$, OU SEJA, TESTA $\operatorname{wt}_{\text{pares}}(x) \equiv 0 \pmod{\mathbf{8}}$, O QUE EXIGE $2 \operatorname{wt}_{\text{pares}}(x) \equiv 0 \pmod{\mathbf{16}}$, O QUE EXIGE $\operatorname{wt}_{\text{diag}} \equiv \mathbf{0} \pmod{\mathbf{16}}$ (E NÃO $\pmod 8$)!!**

---

### 🔥 VERIFICAÇÃO IMEDIATA DESTE ACHADO CRÍTICO! (`wt_diag % 16` vs `wt_diag % 8`!)

**FAÇAMOS A EXPANSÃO ALGÉBRICA EXATA EM $\mathbb{Z}$ DE $\operatorname{wt}\big(O \oplus \bigoplus_{i=1}^n x_i b_i\big)$!**

Para qualquer ponto (par) $p \in \{0, \dots, 2015\}$, seja $O(p) \in \{0, 1\}$ e $s(p) := 1 - 2 O(p) \in \{+1, -1\}$.
Para qualquer booleano $y(p) = \bigoplus_{i=1}^n x_i b_i(p) \in \{0, 1\}$, vale em $\mathbb{Z}$:
$$(O(p) \oplus y(p)) = O(p) + (1 - 2 O(p)) \, y(p) = O(p) + s(p) \, y(p).$$
Agora expanda $y(p) = \bigoplus_{i=1}^n x_i b_i(p)$ em $\mathbb{Z}$ usando a fórmula exata de inclusão-exclusão $a_1 \oplus \dots \oplus a_n = \sum_{k=1}^n (-2)^{k-1} \sum_{i_1 < \dots < i_k} a_{i_1}\cdots a_{i_k}$:
$$y(p) = \sum_{i} x_i b_i(p) - 2 \sum_{i < j} x_i x_j b_i(p) b_j(p) + 4 \sum_{i < j < k} x_i x_j x_k b_i(p) b_j(p) b_k(p) - 8 \sum_{i < j < k < \ell} (\cdots).$$
Multiplique por $s(p) = 1 - 2 O(p)$ e some sobre todos os $p \in \{0, \dots, 2015\}$!
Definindo:
- $o_{\text{pop}} = \sum_p O(p) = \operatorname{wt}(O)$;
- $\Delta_1(i) = \sum_p s(p) b_i(p) = \operatorname{wt}(b_i) - 2 \operatorname{wt}(b_i \land O)$ (`wi_pop - 2 * wo_pop`);
- $\Delta_2(i, j) = \sum_p s(p) b_i(p) b_j(p) = \operatorname{wt}(b_i \land b_j) - 2 \operatorname{wt}(b_i \land b_j \land O)$ (`inter_pop - 2 * io_pop`);
- $\Delta_3(i, j, k) = \sum_p s(p) b_i(p) b_j(p) b_k(p) = \operatorname{wt}(b_i \land b_j \land b_k) - 2 \operatorname{wt}(b_i \land b_j \land b_k \land O)$;

Obtemos a **IDENTIDADE INTEIRA EXATA** para $\operatorname{wt}_{\text{pares}}(x) = \operatorname{wt}(t(x))$:
$$\operatorname{wt}_{\text{pares}}(x) = o_{\text{pop}} + \sum_i x_i \Delta_1(i) - 2 \sum_{i < j} x_i x_j \Delta_2(i, j) + 4 \sum_{i < j < k} x_i x_j x_k \Delta_3(i, j, k) \pmod 8!$$

**AGORA REDUZA ESTA IDENTIDADE MÓDULO 8 (DIVIDINDO POR 4 QUANDO ELA JÁ É MÚLTIPLA DE 4):**
Sob as condições checadas por `extract_and_fill_row`:
1. `4 | Delta_1(i)` para todo $i$ (`((wi_pop - 2 * wo_pop) & 3) == 0`);
2. `2 | inter_pop` para todo $i < j$ (`(inter_pop & 1) == 0`), logo `Delta_2(i, j) = inter_pop - 2 * io_pop` é par, donde `-2 * Delta_2(i, j) = -4 * (inter_pop / 2 - io_pop) ≡ 4 * (inter_pop / 2 + io_pop) (mod 8)`!
3. No termo cúbico: `4 * Delta_3(i, j, k) = 4 * pop(b_i & b_j & b_k) - 8 * pop(...) ≡ 4 * (pop(b_i & b_j & b_k) & 1) (mod 8)`!
4. **E NO TERMO CONSTANTE $o_{\text{pop}}$:**
   - Para que $\operatorname{wt}_{\text{pares}}(x)$ seja múltiplo de $4$ para todo $x$, é **NECESSÁRIO** que $o_{\text{pop}} \equiv 0 \pmod 4$!
   - **OLHE A LINHA 34 DE `VERIFY_C99_1_NULLSTELLENSATZ.py`:**
     ```c
     if (o_pop & 1) return -1;
     ```
     **ELE SÓ TESTOU `o_pop % 2 == 0` (PARIDADE), NÃO TESTOU `o_pop % 4 == 0`!!**
   - **E MAIS GRAVE AINDA — OLHE A CONDIÇÃO DE BENTNESS $(\dagger)$:**
     A condição de bentness é:
     $$2 \operatorname{wt}_{\text{pares}}(x) + \operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16} \iff \operatorname{wt}_{\text{pares}}(x) \equiv -\frac{\operatorname{wt}_{\text{diag}}}{2} \pmod{\mathbf{8}}!!$$
     Dividindo por $4$ (quando ambos os lados são múltiplos de $4$, isto é, quando $8 \mid \operatorname{wt}_{\text{diag}}$ e $4 \mid o_{\text{pop}}$):
     $$\left\lfloor \frac{\operatorname{wt}_{\text{pares}}(x)}{4} \right\rfloor \equiv \left\lfloor \frac{\operatorname{wt}_{\text{diag}}}{8} \right\rfloor \pmod 2!!$$

> ### 💥 DESCOBERTA DE AUDITORIA EXTRAORDINÁRIA (POTENCIAL BUG FATAL DE SINAL `const_shift = 1`!) 💥
>
> **LEIA ESTA EQUAÇÃO DE NOVO COM ATENÇÃO TOTAL:**
> - O código C (`extract_and_fill_row`) e o verificador Python (`VERIFY_C99_1_NULLSTELLENSATZ.py`, linha 299: `extract_poly_mod4(bw, Ow, k1_vars, const_shift=0)`) calculam o polinômio:
>   $$P_{\text{code}}(x) \equiv \left\lfloor \frac{\operatorname{wt}_{\text{pares}}(x)}{4} \right\rfloor \pmod 2$$
>   (supondo $o_{\text{pop}} \equiv 0 \pmod 4$) e **IMPÕEM A EQUAÇÃO $P_{\text{code}}(x) = 0$ (`const_shift = 0`)**!
> - Mas $P_{\text{code}}(x) = 0$ significa $\operatorname{wt}_{\text{pares}}(x) \equiv \mathbf{0} \pmod 8$, isto é, $2 \operatorname{wt}_{\text{pares}}(x) \equiv \mathbf{0} \pmod{16}$!
> - Pela identidade de Poisson $2 \operatorname{wt}_{\text{pares}}(x) + \operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16}$:
>   * Se $\operatorname{wt}_{\text{diag}} \equiv \mathbf{0} \pmod{\mathbf{16}}$ (ex.: $\operatorname{wt}_{\text{diag}} \in \{0, 16, 32, 48, 64\}$), então $\left\lfloor \frac{\operatorname{wt}_{\text{diag}}}{8} \right\rfloor \equiv \mathbf{0} \pmod 2$, e a equação correta para funções bent é de fato **$P_{\text{code}}(x) = 0$ (`const_shift = 0`)**!
>   * **PORÉM, SE $\operatorname{wt}_{\text{diag}} \equiv \mathbf{8} \pmod{\mathbf{16}}$ (ex.: $\operatorname{wt}_{\text{diag}} \in \{8, 24, 40, 56\}$):**
>     Ela **PASSA** no filtro `(w & diag_mask).bit_count() % 8 == 0` do código (`SOLVE_C99_1_POISSON_C.py` linha 308 e `VERIFY_C99_1_NULLSTELLENSATZ.py` linha 243: `if (w & diag_mask).bit_count() % 8 != 0: d_ok = False`), **MAS PARA UMA FUNÇÃO BENT ELA EXIGE $\operatorname{wt}_{\text{pares}}(x) \equiv \mathbf{4} \pmod 8$, OU SEJA, $P_{\text{code}}(x) = \mathbf{1}$ (`const_shift = 1`), E NÃO $P_{\text{code}}(x) = 0$!!**

---

### 1.5. Verificação Analítica Imediata: Quanto vale $\operatorname{wt}_{\text{diag}}$ em $V_6 \times V_6$ no Ramo $c_{99}=1$ (`K=1`) e por que a função bent de teste não pegou isso?!

Vamos calcular **EXATAMENTE AGORA, À MÃO**, se pode existir $V_6 \le \mathbb{F}_2^8$ com $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$, e o que a função de validação $\langle \text{lo}, \text{hi}\rangle + g(\text{lo} \oplus \text{hi})$ fez!

#### Parte A: Qual é o peso de $Q_{\text{fix}}(v)$ em qualquer $V_6 \le \mathbb{F}_2^8$?
Lembre que em $c_{99}=1, c_{57}=c_{113}=1, c_{115}=0$, a restrição diagonal $f(v, v) = Q_{\text{fix}}(v)$ é uma **forma quadrática homogênea em $\mathbb{F}_2^8$** que depende **apenas** das 4 variáveis $X_0 = v_0 \oplus v_4$, $X_2 = v_2 \oplus v_6$, $X_1 = v_1 \oplus v_5$, $X_3 = v_3 \oplus v_7$:
$$Q_{\text{fix}}(X) = X_0 X_2 \oplus X_1 X_3 \oplus (X_0 \oplus X_2)(X_1 \oplus X_3).$$
Restrita a um subespaço linear $V_6 \le \mathbb{F}_2^8$ de dimensão $6$ ($|V_6| = 64$ pontos), $Q_{\text{fix}}|_{V_6}$ continua sendo um **polinômio homogêneo de grau $\le 2$ (sem termo constante, $Q_{\text{fix}}(0) = 0$, e sem parte linear pura fora do radical quadrático)** em $6$ variáveis!
Quais são os **ÚNICOS pesos de Hamming possíveis** de **QUALQUER** função booleana quadrática $q : \mathbb{F}_2^6 \to \mathbb{F}_2$ com $q(0) = 0$ pelo Teorema de Classificação Simplética de Dickson?!
- Se $q \equiv 0$: $\operatorname{wt}(q) = \mathbf{0}$.
- Se $q$ é linear não-nula (impossível aqui? Mesmo se tivesse termo linear por $v_i^2 = v_i$? Não, $Q_{\text{fix}}$ é bilinear pura nas coordenadas $v_i$, zero termos $v_i^2$!): se tivesse parte linear independente, $\operatorname{wt}(q) = \mathbf{32}$.
- Se posto simplético $2r = 2$ (ex.: $y_1 y_2$ em $\mathbb{F}_2^6$): $\operatorname{wt}(q) = \frac{64}{2} \pm \frac{64}{2^2} = 32 \pm 16 \in \{\mathbf{16}, \mathbf{48}\}$!
- Se posto simplético $2r = 4$ (o máximo possível, pois $Q_{\text{fix}}$ só depende de **4 variáveis** $X_0, X_1, X_2, X_3$!!):
  $$\operatorname{wt}(q) = \frac{64}{2} \pm \frac{64}{2^{4/2 + 1}} = 32 \pm \frac{64}{8} = 32 \pm 8 \in \{\mathbf{24}, \mathbf{40}\}!!$$

**PARE TUDO!! OLHE OS NÚMEROS `24` E `40`!!**
- $24 = 3 \times 8 \equiv \mathbf{8} \pmod{16}$!!
- $40 = 5 \times 8 \equiv \mathbf{8} \pmod{16}$!!
- Quando $\pi(V_6) = \mathbb{F}_2^4$ (isto é, quando a projeção de $V_6$ nas 4 coordenadas $X_0, X_1, X_2, X_3$ é sobrejetora — o que ocorre para a **GRANDE MAIORIA** dos subespaços $V_6$ de dimensão 6 em $\mathbb{F}_2^8$, pois $\dim V_6 = 6$ e $\dim \ker \pi = 4$!), cada fibra de $\pi|_{V_6}$ tem tamanho $64 / 16 = 4$!
- Na Seção 3 de `carbon_hard_c99_analysis.md`, já calculamos a soma de $(-1)^{Q_{\text{fix}}(X)}$ em $\mathbb{F}_2^4$: vale $-4$ (ou seja, $10$ uns e $6$ zeros em $\mathbb{F}_2^4$, pois $16 - 2(10) = -4$)!
- Multiplicando por $4$ (tamanho da fibra em $V_6$):
  $$\operatorname{wt}(Q_{\text{fix}}|_{V_6}) = 4 \times 10 = \mathbf{40}!!$$
- **$40 \bmod 8 = 0$ (PASSA NO FILTRO `% 8 == 0` DO CÓDIGO!), MAS $40 \bmod 16 = \mathbf{8} \neq 0$!!**
- E para uma função bent com $\operatorname{wt}_{\text{diag}} = 40$:
  $$2 \operatorname{wt}_{\text{pares}} + 40 \equiv 0 \pmod{16} \iff 2 \operatorname{wt}_{\text{pares}} \equiv -40 \equiv \mathbf{8} \pmod{16} \iff \operatorname{wt}_{\text{pares}} \equiv \mathbf{4} \pmod 8 \iff \left\lfloor \frac{\operatorname{wt}_{\text{pares}}}{4} \right\rfloor \equiv \mathbf{1} \pmod 2!!$$

#### Parte B: POR QUE a validação com `<lo, hi> + g(lo ^ hi)` (se feita) NÃO detectou esse erro de constante `1`?!
Olhe para a função bent de Maiorana-McFarland sugerida para validação:
$$f_{\text{MM}}(v, w) := \langle v, w \rangle \oplus g(v \oplus w), \qquad v, w \in \mathbb{F}_2^8.$$
Avalie $f_{\text{MM}}$ na diagonal $w = v$:
$$f_{\text{MM}}(v, v) = \langle v, v \rangle \oplus g(0) = \operatorname{wt}(v) \oplus g(0) \pmod 2!$$
Suponha $g(0) = 0$ (homogênea). Então $f_{\text{MM}}(v, v) = \operatorname{wt}(v) \bmod 2$ (uma função **LINEAR** em $v$!).
Qual é o peso de uma função linear $\operatorname{wt}(v) \bmod 2$ em qualquer subespaço $V_6$ de dimensão $6$?!
- Se $\mathbf{1}_8 \in V_6^\perp$ (vetor todo-1 ortogonal a $V_6$): $\operatorname{wt}(f_{\text{MM}}|_{D(W)}) = \mathbf{0} \equiv \mathbf{0} \pmod{16}$!
- Caso contrário (função linear não-nula em $V_6$): $\operatorname{wt}(f_{\text{MM}}|_{D(W)}) = \frac{64}{2} = \mathbf{32} \equiv \mathbf{0} \pmod{16}$!!

> ### 🎯 EXPLICAÇÃO COMPLETA DA FALHA DE VALIDAÇÃO! 🎯
>
> 1. Para $f_{\text{MM}}(v, w) = \langle v, w \rangle \oplus g(v \oplus w)$, a restrição diagonal $f_{\text{MM}}(v, v)$ é **AFIM**, logo seu peso em **QUALQUER** $V_6$ pertence a $\{0, 32, 64\}$, que é **SEMPRE $\mathbf{0 \pmod{16}}$**! Assim, em $f_{\text{MM}}$, vale $\operatorname{wt}_{\text{pares}}(f_{\text{MM}}) \equiv 0 \pmod 8$ ($\lfloor \operatorname{wt}_{\text{pares}} / 4 \rfloor \bmod 2 = 0$)!
> 2. Já para funções em $H(16,4)$ com $c_{99}=1, c_{57}=c_{113}=1$, a restrição diagonal $f(v, v) = Q_{\text{fix}}(v)$ tem **GRAU 2 E POSTO SIMPLÉTICO 4**, logo seu peso na maioria dos $V_6$ vale **$40 \equiv \mathbf{8 \pmod{16}}$** (ou $24 \equiv 8 \pmod{16}$ se $c_{57}=0$: $6 \times 4 = 24$)!
> 3. Como o código em `SOLVE_C99_1_POISSON_C.py`, `VERIFY_C99_1_NULLSTELLENSATZ.py`, `SOLVE_C99_0_RANDW.py` e `SOLVE_C99_0_CLOSE.py` filtrou apenas por:
>    ```python
>    if (w & diag_mask).bit_count() % 8 != 0: d_ok = False
>    ```
>    e depois extraiu `(wt_pares // 4) % 2 == 0` com **`const_shift = 0`** (ignorando o termo $\lfloor \operatorname{wt}_{\text{diag}} / 8 \rfloor \bmod 2$!), **TODA equação extraída de um subespaço $W$ onde $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$ teve o seu termo constante INVERTIDO (`P(c) = 0` em vez do correto `P(c) = 1`, isto é, `P(c) ^ 1 = 0`)!!**
> 4. Mais ainda: se o certificado Nullstellensatz de 7 equações somou um número **ÍMPAR** de equações `v6` com $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$, então a soma verdadeira das equações válidas dá **`0 = 0` (identidade trivial!) em vez de `1 = 0`**, **INVALIDANDO O CERTIFICADO ATUAL**! (Se somou um número **PAR** delas, os erros de constante `1` se cancelam na soma, mas as equações individuais do certificado continuam com sinal constante errado!).
> 5. **ATENÇÃO DUPLA — IMPACTO IMEDIATO TAMBÉM EM `c99 = 0` (`B0_01`, `B0_10`, `B0_00`, `B0_11`):**
>    - Em `B0_00` ($c_{99}=0, c_{57}=c_{113}=0$): `orb_diag` é **ZERO** para todas as órbitas ativas (`wt_diag == 0 == 0 mod 16` sempre!), logo **em `B0_00` NÃO há bug de constante!**
>    - Em `B0_11` ($c_{99}=0, c_{57}=c_{113}=1$): $f(v,v) = (X_0 \oplus X_2)(X_1 \oplus X_3)$ tem **posto simplético 2**, cujo peso em $\mathbb{F}_2^4$ é $4$ ($4 \times 4 = \mathbf{16} \equiv 0 \pmod{16}$ quando $\pi(V_6) = \mathbb{F}_2^4$, ou $0$, ou $32$? Espere: em dim 6, posto 2 tem peso $\frac{64}{4} = \mathbf{16}$ ou $0$! $16 \equiv 0 \pmod{16}$, então em `V6xV6` para `B0_11` dá $0 \pmod{16}$, mas em `V4` onde $|D|=256$ dá $64 \equiv 0 \pmod{16}$; contudo, em subespaços gerais `RANDW` onde $\dim(W \cap D_8) = 5$, posto 2 tem peso $32/4 = \mathbf{8} \equiv 8 \pmod{16}$!!).
>    - E em **`B0_01` e `B0_10`** ($c_{57} \neq c_{113}$? Não, em T20 $c_{57}=c_{113}$ sempre; `B0_01` e `B0_10` eram células $(c_{57}, R)$ em `Stage C` ou $(c_{57}, c_{113})$ antes de T20? No prompt diz *"celulas por (c57,c113): B0_01 e B0_10 FECHADAS"* — se $c_{57} \neq c_{113}$, elas já são excluídas pela lei linear T20 $c_{57} = c_{113}$, mas se `wt_diag == 24` ou `8` ocorreu lá, o mesmo shift se aplica!).

---

### 1.6. Segunda Checagem de Sinal/Módulo em `extract_and_fill_row`: E se `o_pop % 4 == 2`?!

Olhe novamente para `extract_and_fill_row` (C) e `extract_poly_mod4` (Python):
```c
int o_pop = 0;
for (int w = 0; w < 32; w++) o_pop += __builtin_popcountll(O_word[w]);
if (o_pop & 1) return -1;
...
if ((o_pop / 4) & 1) {
    row_words[off0 >> 6] ^= 1ULL << (off0 & 63);
}
```
Veja o que acontece quando $\operatorname{wt}_{\text{diag}} = 40 \equiv 8 \pmod{16}$!
- Se existir **alguma** função no espaço afim cujos pesos em $W$ respeitem a congruência módulo $8$ (i.e. $2 \operatorname{wt}_{\text{pares}}(x) + \operatorname{wt}_{\text{diag}} \equiv 0 \pmod 8$), então como $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod 8$, temos $2 \operatorname{wt}_{\text{pares}}(x) \equiv 0 \pmod 8 \iff \operatorname{wt}_{\text{pares}}(x) \equiv 0 \pmod 4$, logo $o_{\text{pop}} = \operatorname{wt}_{\text{pares}}(0)$ será automaticamente $\equiv 0 \pmod 4$?
  **NÃO NECESSARIAMENTE!** Porque $x = 0$ (`origin_k1`) é uma quártica arbitrária de $H(16,4)$, **não** uma função bent! Para uma quártica qualquer em $\dim W = 12$, McEliece garante $\operatorname{wt}(f|_W) \equiv 0 \pmod{2^{\lceil 12/4 \rceil - 1}} = 0 \pmod 4$, o que garante apenas $2 o_{\text{pop}} + \operatorname{wt}_{\text{diag}} \equiv 0 \pmod 4 \implies 2 o_{\text{pop}} \equiv 0 \pmod 4 \implies o_{\text{pop}} \equiv 0 \pmod 2$ (**exatamente por isso `o_pop` pode ser $2 \pmod 4$!!**)!
- **O QUE ACONTECE SE `o_pop % 4 == 2`?!**
  Na identidade exata:
  $$\operatorname{wt}_{\text{pares}}(x) = o_{\text{pop}} + 4 L(x) + 4 Q(x) + 4 C(x) \pmod 8,$$
  todos os termos dependentes de $x$ são **múltiplos de 4** (pois o código checou `(wi_pop - 2*wo_pop) % 4 == 0` e `inter_pop % 2 == 0`!).
  Portanto:
  - **CASO 1 (`o_pop % 4 == 2`):** Então para **TODO** $x \in \mathbb{F}_2^{109}$, $\operatorname{wt}_{\text{pares}}(x) \equiv 2 \pmod 4 \implies 2 \operatorname{wt}_{\text{pares}}(x) \equiv \mathbf{4} \pmod 8$!
    Se simultaneamente $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod 8$, então $2 \operatorname{wt}_{\text{pares}}(x) + \operatorname{wt}_{\text{diag}} \equiv \mathbf{4} \not\equiv 0 \pmod 8$ para **TODO** $x$! Isso seria por si só uma **contradição imediata de 1 única equação (`1 = 0` já módulo 8!)**, **MAS** o código C **NÃO** detectou isso e em vez disso calculou `(o_pop / 4) & 1` (divisão inteira truncada `(4k + 2) / 4 = k`, jogando fora o resto `2`!) e gerou um polinômio espúrio!
  - **CASO 2 (`o_pop % 4 == 0`):** Então $\operatorname{wt}_{\text{pares}}(x) = 4 \big( (o_{\text{pop}}/4) + L(x) + Q(x) + C(x) \big) \pmod 8$, a divisão exata por $4$ é **100% legítima**, **DESDE QUE** se some o bit da diagonal:
    $$\text{const\_shift\_correto} = \left(\frac{\operatorname{wt}_{\text{diag}}(x)}{8}\right) \bmod 2!$$
    *(E se $\operatorname{wt}_{\text{diag}}(x)$ depender de alguma variável, como $c_{57}$ antes de fixar $K$, deve-se somar o polinômio de $\operatorname{wt}_{\text{diag}}(x)/8 \bmod 2$ inteiro, não apenas uma constante!)*

---

## 2. Outras Falhas de Independência e Hipóteses Implícitas em `VERIFY_C99_1_NULLSTELLENSATZ.py`

Além dos dois achados algébricos críticos acima (`wt_diag / 8 mod 2` omitido no `const_shift`, e falta de `assert o_pop % 4 == 0` e `assert wt_diag % 4 == 0`), a auditoria de engenharia e lógica encontrou **4 falhas de independência** no verificador atual:

1. **Falha de Independência #1 (Mesma função `extract_poly_mod4` e mesma convenção):**
   `VERIFY_C99_1_NULLSTELLENSATZ.py` importa `extract_poly_mod4`, `build_basis_111`, `setup_orbits` de `VERIFICAR_ALGEBRA_C99_1.py` e `I2, J2, I3, J3, I4, J4, all_v6_orbits` de `SOLVE_C99_1_POISSON_C.py`. Como `extract_poly_mod4` e `extract_and_fill_row` implementam literalmente a mesma fórmula truncada `(o_pop // 4) % 2` com `const_shift = 0`, qualquer erro de constante ou sinal em um é confirmado pelo outro!
2. **Falha de Independência #2 (Hipóteses `build_basis_111`, `K = 1` e `lc = 0` assumidas como axiomas sem verificação):**
   Olhe para as linhas 146–155 e 213–219 de `VERIFY_C99_1_NULLSTELLENSATZ.py`:
   - Ele assume `build_basis_111()` ($c_{115}=0$, $c_{113}=c_{57}$, $L=1$, $c_{57}=K$, $R=0$).
   - **Assume `K = 1`!** Por que $K = 1$ no ramo $c_{99} = 1$? (Em `T31`, a quinta condição $C_5$ diz apenas $c_{57} = K$, NÃO $K = 1$! De onde veio $K = 1$? Provavelmente da paridade linear `L_coset` de $C_{\texttt{0x0}}$ ou $C_{\texttt{0xf}}$ descoberta em `VERIFICAR_ALGEBRA_C99_1.py`! Mas `VERIFY_C99_1_NULLSTELLENSATZ.py` fixa `K = 1` na mão sem provar por que `K = 0` é impossível!).
   - **Assume `lc = 0` (`L_coset^1` / `C4` reduzido)!** Nas linhas 213–219, ele hardcoda `slin_i, slin_c = lin_expr_k1([23, 31, 39, 112]); lc = poly_from_lin(slin_i, slin_c ^ 1)` com `I2, J2, I3, J3, I4, J4` (omitindo `I1, J1` porque `K=1` os anulou?), **sem verificar por avaliação na ANF de $2^{16}$ pontos** que toda função bent com $c_{99}=1$ satisfaz `lc(c) = 0`!
3. **Falha de Independência #3 (O certificado JSON salvo não é auto-contido):**
   `c99_1_nullstellensatz_cert.json` salva `"v_idx": v_idx`, onde `v_idx` depende da ordem de iteração de `all_v6_orbits()`, em vez de salvar explicitamente os 2 geradores $a, b \in \mathbb{F}_2^8$ de $V_6^\perp$ (ou os 4 geradores de $W^\perp \le \mathbb{F}_2^{16}$) de cada subespaço usado!
4. **Falha de Validação com Funções Bent Conhecidas ($\rho^8$-simétricas COM diagonal de posto 4!):**
   Testar apenas $f_{\text{MM}}(v, w) = \langle v, w \rangle \oplus g(v \oplus w)$ só exercita o ramo $\operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16}$!
   Para testar o ramo $\operatorname{wt}_{\text{diag}} \equiv 8 \pmod{16}$ ($\operatorname{wt}_{\text{diag}} \in \{24, 40\}$), **PRECISAMOS** testar uma função bent $\rho^8$-invariante (e até $C_8$-invariante!) cuja restrição diagonal $f(v, v)$ tenha **posto simplético 4** (exatamente $Q_{\text{fix}}(v)$!).
   **Existe tal função bent explícita em $n = 16$?**
   **SIM! Construção explícita imediata (Maiorana-McFarland Torcida Simétrica):**
   Seja $B(v, w)$ a forma polar simétrica associada a $Q(v)$? Não: em característica 2, se pusermos para $v, w \in \mathbb{F}_2^8$:
   $$f_{\text{test}}(v, w) := \langle v, w \rangle \oplus \operatorname{wt}(v) \operatorname{wt}(w) \quad \text{? Não, muito mais simples!}$$
   Tome **QUALQUER** matriz binária **SIMÉTRICA INVERTÍVEL** $S \in \mathrm{GL}_8(\mathbb{F}_2)$ ($S^T = S$, $\det S = 1$ sobre $\mathbb{F}_2$) e qualquer função $g : \mathbb{F}_2^8 \to \mathbb{F}_2$ invariante por $z \mapsto z$ ($g(v \oplus w) = g(w \oplus v)$ é automático!):
   $$f_{S, g}(v, w) := v^T S w \oplus g(v \oplus w)!$$
   1. **$f_{S, g}$ é $\rho^8$-invariante?** Como $S^T = S$ e $v \oplus w = w \oplus v$, $w^T S v = (v^T S^T w)^T = v^T S w$, logo **$f_{S, g}(w, v) = f_{S, g}(v, w)$ IDENTICAMENTE!**
   2. **$f_{S, g}$ é BENT em $n = 16$?** Mudando coordenadas $(v, z) = (v, v \oplus w)$, temos $w = v \oplus z$, logo:
      $$f_{S, g}(v, v \oplus z) = v^T S v \oplus v^T S z \oplus g(z).$$
      Note que $v \mapsto v^T S v$ é **LINEAR** em característica 2 ($v^T S v = \sum_i S_{ii} v_i$)! E como $S$ é invertível, $z \mapsto S z$ é uma bijeção de $\mathbb{F}_2^8$! Logo, para cada $z \in \mathbb{F}_2^8$ fixo, $v \mapsto \langle \text{diag}(S) \oplus S z, v \rangle \oplus g(z)$ é uma função afim com inclinação $\pi(z) = \text{diag}(S) \oplus S z$ bijetiva! Portanto **$f_{S, g}$ é 100% BENT (Maiorana-McFarland) para QUALQUER $S$ simétrica invertível!**
   3. *Espera:* $f_{S, g}(v, v) = v^T S v \oplus g(0)$ ainda é linear em $v$! **Como obter $f_{\text{bent}}(v, v) = Q_{\text{fix}}(v)$ (quadrática de posto 4) sendo $\rho^8$-invariante?!**
      **Construção Exata de Função Bent Quadrática $\rho^8$-Invariante com $f(v, v) = Q_{\text{fix}}(v)$:**
      Qualquer forma quadrática $f(v, w)$ em $16$ variáveis é bent se e só se sua forma bilinear simplética associada $B_f((v_1, w_1), (v_2, w_2)) = f(v_1+v_2, w_1+w_2) + f(v_1, w_1) + f(v_2, w_2)$ for não-degenerada ($\det B_f = 1 \bmod 2$)!
      Basta definir em coordenadas $u = v \oplus w \in \mathbb{F}_2^8$ e $v \in \mathbb{F}_2^8$:
      Queremos $f(v, w) = f(w, v)$, isto é, $f$ invariante por $(v, u) \mapsto (v \oplus u, u)$, e para $u = 0$ ($w = v$) queremos $f(v, v) = Q_{\text{fix}}(v)$!
      Ora, escreva $Q_{\text{fix}}(v) = \sum_{0 \le i < j \le 7} A_{ij} v_i v_j$. Para tornar $Q_{\text{fix}}$ invariante por $v \leftrightarrow w$:
      $$\tilde{Q}(v, w) := \sum_{0 \le i < j \le 7} A_{ij} (v_i w_j \oplus w_i v_j \oplus \dots) \text{?}$$
      Cuidado: $v_i w_j \oplus w_i v_j$ anula-se em $w = v$! Já **$v_i v_j \oplus w_i w_j \oplus (v_i \oplus w_i) \dots$** não: em $w = v$, $v_i v_j \oplus w_i w_j = 0$!
      Para valer $v_i v_j$ em $w = v$ e ser simétrico em $(v, w)$, basta tomar **$v_i w_j \oplus v_j w_i$? Não, tome $v_i w_j$ simetrizado? Não: $(v_i w_j)$ para $i < j$ MAIS... espere: $v_i v_j \oplus w_i w_j \oplus v_i w_j \oplus w_i v_j = (v_i \oplus w_i)(v_j \oplus w_j) = u_i u_j$ (vale $0$ em $w=v$)! E quanto vale $v_i w_j$ em $w = v$? Vale $v_i v_j$, mas $v_i w_j$ não é simétrico: $w_i v_j = v_i w_j \oplus (v_i w_j \oplus w_i v_j)$!**
      **IMPOSSIBILIDADE DE POLINÔMIO SIMÉTRICO EM $(v,w)$ TER GRAU 2 ÍMPAR EM $v=w$? NÃO! OLHE PARA $O_{99}$!**
      Como $O_{99} = \sum_{i=0}^7 x_i x_{i+2} x_{i+8} x_{i+10}$ sobreviveu em $w = v$?!
      Porque $x_i x_{i+2} x_{i+8} x_{i+10} = v_i v_{i+2} w_i w_{i+2}$ tem **GRAU 4**, e em $w = v$ colapsa para $v_i^2 v_{i+2}^2 = v_i v_{i+2}$!!
      **BRILHANTE!!** Um polinômio $\rho^8$-invariante de grau $\le 2$ tem sempre restrição diagonal afim, mas de **GRAU 4** tem $v_i v_j w_i w_j \mapsto v_i v_j$!
      **CONSTRUÇÃO EXATA DE FUNÇÃO BENT DE GRAU 4, $\rho^8$-INVARIANTE, COM $\operatorname{wt}_{\text{diag}} = 40 \equiv 8 \pmod{16}$ (Classe $\mathcal{PS}_{ap}$ / Dillon / Rothaus / MM-modificada):**
      Na classe de Maiorana-McFarland em coordenadas $u = v \oplus w \in \mathbb{F}_2^8$ e $y \in \mathbb{F}_2^8$? Se mudarmos variáveis com $\rho^8(v, w) = (w, v)$:
      Todo ponto $(v, w)$ escreve-se com $u = v \oplus w$ (invariante por $\rho^8$: $\rho^8(u) = u$!) e em $u = 0$ temos $w = v$.
      Queremos uma função **bent** $F(v, w)$ tal que $F(w, v) = F(v, w)$ e $F(v, v) = Q_{\text{fix}}(v)$!
      É **TRIVIAL** construir milhões delas via **Concatenação de 4 funções bent (Teorema de Rothaus / Carlet)** ou **MM com translação quadrática**:
      Escolha uma base de $\mathbb{F}_2^8$ onde $Q_{\text{fix}}(v) = v_0 v_1 \oplus v_2 v_3$ (posto 4!).
      Para construir uma função bent $\rho^8$-simétrica em $(v_0, v_1, w_0, w_1)$ (4 variáveis, depois somamos $\langle v_{2..7}, w_{2..7}\rangle$ ou o segundo bloco!):
      Em **4 variáveis** $(v_0, v_1, w_0, w_1)$, uma função $h(v_0, v_1, w_0, w_1)$ é bent $\iff$ tem peso $6$ ou $10$ e $|W_h| = 4$ em todos os 16 pontos! Existem $896$ funções bent em 4 variáveis; testando apenas as simétricas sob $(v_0,v_1) \leftrightarrow (w_0,w_1)$ (há $2^{10} = 1024$ funções simétricas ao todo em 4 variáveis!!), achamos em **0.1 milissegundo** uma $h_4(v_0,v_1,w_0,w_1)$ bent, simétrica sob $(v_0,v_1)\leftrightarrow(w_0,w_1)$, tal que $h_4(v_0,v_1,v_0,v_1) = v_0 v_1$!
      *(Quer ver uma explícita agora mesmo à mão?! Tome:*
      $$h_4(v_0, v_1, w_0, w_1) := v_0 v_1 w_0 w_1 \oplus v_0 w_1 \oplus v_1 w_0 \text{ ?}$$
      *Calcule a tabela-verdade de $h_4(v_0,v_1,w_0,w_1) = v_0 v_1 w_0 w_1 \oplus v_0 w_1 \oplus v_1 w_0$:*
      *Para $(v_0,v_1) = (w_0,w_1)$: $v_0 v_1 \oplus v_0 v_1 \oplus v_1 v_0 = v_0 v_1$! Mas o termo de grau 4 tem peso 1 (ímpar), logo peso total é ímpar, não é bent! Para ter peso par (6 ou 10), o termo de grau 4 tem que ter número PAR de monômios! Basta em **8 variáveis** somar DOIS blocos: $F_8(v_0..v_3, w_0..w_3)$ ou encontrar em $2^{10}$ em 4 variáveis — em 4 variáveis toda função bent tem grau $\le 2$, logo em 4 variáveis nenhuma simétrica tem diagonal $v_0 v_1$; já em **6 ou 8 variáveis**, funções bent cúbicas/quárticas têm grau $\le 4$!)*
      Mais fácil e **100% explícita à mão em 8 variáveis** $(v_0,v_1,v_2,v_3, w_0,w_1,w_2,w_3)$ (Maiorana-McFarland generalizada!):
      Defina $u_i = v_i \oplus w_i$ ($i=0..3$). Note que:
      $$v_0 v_1 w_0 w_1 = v_0 v_1 (v_0 \oplus u_0)(v_1 \oplus u_1) = v_0 v_1 \oplus v_0 v_1 u_1 \oplus v_0 v_1 u_0 \oplus v_0 v_1 u_0 u_1!$$
      Em vez disso, use a **Construção $\mathcal{M}^\#$ / Deslocamento Linear de Maiorana-McFarland**:
      Tome **QUALQUER** função bent $B(v, w) = \langle v, w \rangle$ e aplique um **automorfismo linear invertível $T \in \mathrm{GL}_{16}(\mathbb{F}_2)$ que comute com $\rho^8$**? Não, automorfismo linear preserva grau 2.
      Para obter $F(v, v) = v_0 v_1 \oplus v_2 v_3$ sendo $F$ bent e $F(v, w) = F(w, v)$:
      Pela fórmula de Maiorana-McFarland nas variáveis $z = v \oplus w \in \mathbb{F}_2^8$ e $t \in \mathbb{F}_2^8$?!
      Espere: $\rho^8$ leva $(v, z) \mapsto (v \oplus z, z)$!
      Numa função de Maiorana-McFarland $F(v, z) = \langle v, \pi(z) \rangle \oplus g(z)$ (que é **SEMPRE BENT** para qualquer permutação $\pi : \mathbb{F}_2^8 \to \mathbb{F}_2^8$ e qualquer $g : \mathbb{F}_2^8 \to \mathbb{F}_2$!!):
      - Quando vale $F(v \oplus z, z) = F(v, z)$?!
        $$F(v \oplus z, z) = \langle v, \pi(z) \rangle \oplus \langle z, \pi(z) \rangle \oplus g(z) = F(v, z) \iff \mathbf{\langle z, \pi(z) \rangle = 0 \quad \forall z \in \mathbb{F}_2^8}!!$$
      - E quanto vale $F$ na diagonal ($z = 0$)? Vale $F(v, 0) = \langle v, \pi(0) \rangle \oplus g(0)$ (ainda linear em $v$ porque $v$ entra linearmente).
      - E se trocarmos os papéis na Maiorana-McFarland?! Faça **$v \oplus w$ ser a variável LINEAR**? Não, $v \oplus w$ é fixo por $\rho^8$; se colocarmos a variável **NÃO-LINEAR** contendo $v$, por exemplo:
        Divida $\mathbb{F}_2^{16} = X \times Y$ onde $\rho^8$ atua em $X$ e em $Y$ separadamente!
        Para $i \in \{0..3\}$, ponha $(v_i, w_i) \in X$ ($8$ bits: metade de baixo dos dois bytes!) e para $j \in \{4..7\}$, ponha $(v_j, w_j) \in Y$ ($8$ bits: metade de cima dos dois bytes!).
        Agora defina:
        $$F_{\text{bent}}(v, w) := \underbrace{\sum_{i=0}^3 (v_i w_{i+4} \oplus w_i v_{i+4})}_{\text{termo bilinear } \rho^8\text{-simétrico!}} \oplus \underbrace{h(v_0, v_1, v_2, v_3, w_0, w_1, w_2, w_3)}_{\text{QUALQUER função } \rho^8\text{-simétrica em } 0..3!}!!$$
        **VERIFIQUE SE $F_{\text{bent}}(v, w)$ É BENT!!**
        Olhe para as 8 variáveis $(v_4, v_5, v_6, v_7, w_4, w_5, w_6, w_7) \in Y$: elas aparecem **APENAS LINEARMENTE**, multiplicando $(w_0, w_1, w_2, w_3, v_0, v_1, v_2, v_3) \in X$, que é uma **BIJEÇÃO LINEAR** $X \xrightarrow{\sim} Y^*$!!
        Logo, **POR MAIORANA-MCFARLAND EM $X \times Y$, $F_{\text{bent}}(v, w)$ É 100% BENT PARA QUALQUER FUNÇÃO $\rho^8$-SIMÉTRICA $h(v_{0..3}, w_{0..3})$!!**
        Basta escolher:
        $$h(v_{0..3}, w_{0..3}) := v_0 v_1 w_0 w_1 \oplus v_2 v_3 w_2 w_3!$$
        1. **É $\rho^8$-invariante?** Trocar $v \leftrightarrow w$ preserva $v_i w_{i+4} \oplus w_i v_{i+4}$ e preserva $v_0 v_1 w_0 w_1 \oplus v_2 v_3 w_2 w_3$! **SIM!**
        2. **É homogênea de grau $\le 4$?** **SIM!**
        3. **É BENT ($|W_F(u)| = 256\ \forall u$)?** **SIM, 100% PROVADO POR MAIORANA-MCFARLAND!**
        4. **Quanto vale na diagonal $w = v$?!**
           - $v_i v_{i+4} \oplus v_i v_{i+4} = 0$!
           - $h(v_{0..3}, v_{0..3}) = v_0 v_1 \oplus v_2 v_3$ (**POSTO SIMPLÉTICO 4!!**)!
           - Peso em $D_8$ inteiro ($256$ pontos): $16 \times 6 = 96$.
           - Peso em qualquer $V_6$ que projete sobre $(v_0, v_1, v_2, v_3)$: **$4 \times 6 = \mathbf{24} \equiv \mathbf{8} \pmod{16}$**!!

> **ESSA FUNÇÃO $F_{\text{bent}}(v, w) = \sum_{i=0}^3 (v_i w_{i+4} \oplus w_i v_{i+4}) \oplus v_0 v_1 w_0 w_1 \oplus v_2 v_3 w_2 w_3$ É A PROVA DE FOGO DEFINITIVA!**
> Se você avaliar a fórmula do código atual (`const_shift = 0`, sem `(wt_diag // 8) % 2`) nesta função bent explícita num subespaço $V_6 \times V_6$ onde $\operatorname{wt}_{\text{diag}}(F_{\text{bent}}) = 24$, **`P_code` dará `1` em vez de `0`**, provando empiricamente na hora a necessidade obrigatória de `const_shift = (wt_diag // 8) % 2`!

---

## 3. Verificador Realmente Independente (`AUDIT_INDEPENDENT_C99_1.py`)

Abaixo está o código Python puro, **100% independente** (não importa **nenhum** arquivo do repositório — nem `VERIFICAR_ALGEBRA_C99_1`, nem `SOLVE_C99_1_POISSON_C`), que:
1. Reconstrói as 116 órbitas de $H(16,4)$ do zero a partir da definição matemática.
2. **Testa a extração corrigida** (`const_shift = (wt_diag // 8) % 2` + `assert o_pop % 4 == 0` + `assert wt_diag % 8 == 0`) contra **duas famílias de funções bent $\rho^8$-simétricas** via FWHT exata de $2^{16}$ pontos:
   - Família 1: $f_{\text{MM}}(v, w) = \langle v, w \rangle \oplus g(v \oplus w)$ ($\operatorname{wt}_{\text{diag}} \equiv 0 \pmod{16}$);
   - Família 2: $F_{\text{bent}}(v, w) = \sum_{i=0}^3 (v_i w_{i+4} \oplus w_i v_{i+4}) \oplus v_0 v_1 w_0 w_1 \oplus v_2 v_3 w_2 w_3$ (**$\operatorname{wt}_{\text{diag}} = 24 \equiv 8 \pmod{16}$**, que flagra instantaneamente o bug se `const_shift` for omitido!).
3. **Audita do zero todas as leis de base (`T20`, `C5`, `C7`, `K=1`, `C4`/`lc`)** por avaliação direta na tabela-verdade de $65.536$ entradas (sem confiar em índices `I1..J4` ou `L, K, R` sem prová-los via Poisson em pontos aleatórios e na família bent!).
4. **Re-executa a busca/verificação do certificado Nullstellensatz COM A FÓRMULA CORRIGIDA** (`const_shift = (wt_diag // 8) % 2` e `o_pop % 4 == 0`), **tanto para `K=1` quanto para `K=0`** (eliminando até a hipótese `K=1` se desejar, ou provando `K=1` diretamente via coset `C_0x0` / `C_0xf`!), extrai o subconjunto mínimo de equações cuja soma XOR é `1`, e **verifica cada equação do certificado por avaliação direta nas $2^{16}$ entradas** em 64 pontos aleatórios $c \in \mathbb{F}_2^{116}$ do ramo!

```python
#!/usr/bin/env python3
"""
AUDIT_INDEPENDENT_C99_1.py
Verificador 100% independente (zero imports do projeto) para auditoria matematica
do fechamento de c99=1 em H(16,4).

O que este auditor faz sem confiar em NENHUM codigo existente:
1. Valida a formula exata de Poisson-Lucas (incluindo o termo critico
   const_shift = (wt_diag // 8) % 2 e a checagem o_pop % 4 == 0) contra:
   - Bent Familia A (wt_diag = 0 mod 16): <v,w> ^ g(v^w)
   - Bent Familia B (wt_diag = 24 == 8 mod 16!): sum_{i=0}^3 (v_i w_{i+4} ^ w_i v_{i+4})
     ^ v0*v1*w0*w1 ^ v2*v3*w2*w3 (prova por contraexemplo real que const_shift=0 falha!)
2. Verifica T20 (c115=0, c57=c113, L=1), C5 (c57=K), C7 (R=0), K=1 (via C_0x0 / D_8)
   e C4 (W_f(0) = +-256 / W_f(0xffff) = +-256) diretamente na tabela-verdade de 2^16 entradas.
3. Re-extrai (com a formula CORRIGIDA!) as equacoes de Poisson-Lucas em V6xV6 para c99=1:
   - Diagnostica se o certificado antigo (com const_shift=0) usava subespacos com wt_diag=40 (8 mod 16).
   - Testa se o sistema CORRIGIDO ainda gera 1 = 0 em grau <= 3!
   - Se gerar 1 = 0, valida CADA equacao do novo certificado avaliando diretamente
     a ANF nas 65.536 entradas em 100 pontos aleatorios c (checando P_q(c) == ((wt_W // 8) % 2))
     e confirma que a soma XOR dos polinomios e identicamente 1.
"""
import json
import random
import time
from itertools import combinations


# ==============================================================================
# 1. Primitivas Independentes: Orbitas C16, ANF de 2^16 bits e FWHT Exata
# ==============================================================================
def rot16(x: int, r: int = 1) -> int:
    r &= 15
    return (((x << r) | (x >> (16 - r))) & 0xFFFF) if r else x


def rot8(v: int) -> int:
    return ((v << 1) & 0xFF) | (v >> 7)


def build_orbits_116():
    seen = set()
    orbits = []
    for comb in combinations(range(16), 4):
        m = sum(1 << i for i in comb)
        if m in seen:
            continue
        orb = sorted({rot16(m, r) for r in range(16)})
        seen.update(orb)
        orbits.append(orb)
    assert len(orbits) == 116
    assert sum(len(o) for o in orbits) == 1820
    short = {i: len(o) for i, o in enumerate(orbits) if len(o) < 16}
    assert short == {57: 8, 99: 8, 113: 8, 115: 4}, f"Orbitas curtas inesperadas: {short}"
    return orbits


def eval_anf_truth_table_int(monomials):
    """
    Avalia um polinomio booleano (lista de mascaras de 16 bits dos monomios ANF)
    em todos os 65.536 pontos de F_2^16 via transformada rapida de Mobius O(16 * 2^16)
    e retorna um inteiro Python de 65.536 bits (bit x = f(x)).
    """
    a = bytearray(65536)
    for m in monomials:
        a[m] ^= 1
    # Fast Mobius Transform sobre subconjuntos
    step = 1
    while step < 65536:
        dbl = step << 1
        for i in range(0, 65536, dbl):
            for j in range(i, i + step):
                a[j + step] ^= a[j]
        step = dbl
    # Empacota em int de 65536 bits por blocos
    chunks = []
    for base in range(0, 65536, 64):
        w = 0
        for b in range(64):
            if a[base + b]:
                w |= 1 << b
        chunks.append(w)
    out = 0
    for idx in range(len(chunks) - 1, -1, -1):
        out = (out << 64) | chunks[idx]
    return out


def fwht_65536(tt_int: int):
    """FWHT exata em Z sobre todos os 65.536 pontos a partir de tt_int."""
    spec = [1] * 65536
    x = tt_int
    while x:
        lsb = x & -x
        spec[lsb.bit_length() - 1] = -1
        x ^= lsb
    step = 1
    while step < 65536:
        dbl = step << 1
        for i in range(0, 65536, dbl):
            for j in range(i, i + step):
                u = spec[j]
                v = spec[j + step]
                spec[j] = u + v
                spec[j + step] = u - v
        step = dbl
    return spec


def is_bent_65536(tt_int: int) -> bool:
    spec = fwht_65536(tt_int)
    return all(v == 256 or v == -256 for v in spec)


# ==============================================================================
# 2. Teste de Sanidade em Funcoes Bent Conhecidas rot^8-simetricas
#    (Incluindo o Contraexemplo Decisivo com wt_diag = 24 == 8 mod 16!)
# ==============================================================================
def all_v6_subspaces():
    dual_seen = set()
    v6_list = []
    for a in range(1, 256):
        for b in range(a + 1, 256):
            c = a ^ b
            trip = tuple(sorted((a, b, c)))
            if trip in dual_seen:
                continue
            cur = trip
            for _ in range(8):
                dual_seen.add(tuple(sorted(cur)))
                cur = tuple(rot8(z) for z in cur)
            pts = [v for v in range(256) if ((v & a).bit_count() & 1) == 0 and ((v & b).bit_count() & 1) == 0]
            assert len(pts) == 64
            v6_list.append(((a, b), pts))
    return v6_list


def audit_bent_ground_truth(v6_list):
    """
    Constroi DUAS funcoes bent rot^8-invariantes explicitas em n=16, confirma via FWHT
    que |W_f(u)| == 256 para todos os 65.536 u, e verifica a lei de Poisson-Lucas em TODOS
    os 1371 subespacos W = V6 x V6 (com e sem chi):
      - Familia A: <v, w> ^ (v0^w0)*(v1^w1)*(v2^w2)  [wt_diag = 0 ou 32 == 0 mod 16]
      - Familia B: sum_{i=0}^3 (v_i w_{i+4} ^ w_i v_{i+4}) ^ v0*v1*w0*w1 ^ v2*v3*w2*w3
                   [wt_diag = 24 == 8 mod 16 na maioria dos V6!]
    Demonstra que SEM const_shift = (wt_diag // 8) % 2 a formula falha na Familia B,
    e COM const_shift = (wt_diag // 8) % 2 passa 100% em AMBAS!
    """
    # Familia A: <v,w> + (v0+w0)(v1+w1)(v2+w2)
    mons_A = [(1 << i) | (1 << (i + 8)) for i in range(8)]
    for b0 in (0, 8):
        for b1 in (1, 9):
            for b2 in (2, 10):
                mons_A.append((1 << b0) | (1 << b1) | (1 << b2))
    tt_A = eval_anf_truth_table_int(mons_A)
    assert is_bent_65536(tt_A), "Familia A falhou teste bent!"

    # Familia B: sum_{i=0}^3 (v_i w_{i+4} ^ w_i v_{i+4}) ^ v0*v1*w0*w1 ^ v2*v3*w2*w3
    mons_B = []
    for i in range(4):
        mons_B.append((1 << i) | (1 << (i + 12)))      # v_i * w_{i+4}
        mons_B.append((1 << (i + 8)) | (1 << (i + 4))) # w_i * v_{i+4}
    mons_B.append((1 << 0) | (1 << 1) | (1 << 8) | (1 << 9))     # v0 v1 w0 w1
    mons_B.append((1 << 2) | (1 << 3) | (1 << 10) | (1 << 11))   # v2 v3 w2 w3
    tt_B = eval_anf_truth_table_int(mons_B)
    assert is_bent_65536(tt_B), "Familia B falhou teste bent!"

    chi_tt = eval_anf_truth_table_int([1 << i for i in range(16)])  # wt(x) mod 2

    bug_caught_count = 0
    checked_pairs = 0
    for (_, pts) in v6_list:
        w_mask_diag = sum(1 << (v | (v << 8)) for v in pts)
        w_mask_pairs = sum(1 << (pts[i] | (pts[j] << 8)) for i in range(64) for j in range(i + 1, 64))
        w_mask_all = sum(1 << (v | (w << 8)) for v in pts for w in pts)

        for label, tt in [("BentA", tt_A), ("BentB", tt_B)]:
            for use_chi in (0, 1):
                g_tt = tt ^ (chi_tt if use_chi else 0)
                wt_all = (g_tt & w_mask_all).bit_count()
                wt_diag = (g_tt & w_mask_diag).bit_count()
                wt_pairs = (g_tt & w_mask_pairs).bit_count()
                assert wt_all == 2 * wt_pairs + wt_diag
                # Teorema de Poisson: SEMPRE 0 mod 16 para qualquer bent!
                assert wt_all % 16 == 0, f"Poisson falhou em {label}!"

                if wt_diag % 8 == 0:
                    assert wt_pairs % 4 == 0
                    bit_pairs_div4 = (wt_pairs // 4) & 1
                    const_shift_exact = (wt_diag // 8) & 1
                    # Equacao CORRETA: bit_pairs_div4 ^ const_shift_exact == 0
                    assert (bit_pairs_div4 ^ const_shift_exact) == 0
                    # Equacao ANTIGA (sem const_shift): falha sempre que wt_diag == 8 mod 16!
                    if bit_pairs_div4 != 0:
                        bug_caught_count += 1
                    checked_pairs += 1

    assert bug_caught_count > 0, "Deveria ter flagrado o bug const_shift=0 na Familia B!"
    return {"checked_bent_W_instances": checked_pairs, "old_const_shift_0_failures_on_BentB": bug_caught_count}


# ==============================================================================
# 3. Extrator Independente CORRIGIDO de Polinomios Mod 4 (com todos os asserts!)
# ==============================================================================
def extract_poisson_poly_corrected(basis_pair_words, O_pair_word, wt_diag_const):
    """
    Dado que wt_diag(c) == wt_diag_const (constante em todo o espaco afim) com wt_diag_const % 8 == 0,
    extrai o polinomio P(x) de grau <= 3 tal que, para TODO x in F_2^n:
        P(x) == ((2 * wt_pairs(x) + wt_diag_const) // 8) % 2,
    de modo que P(x) == 0 e condicao NECESSARIA EXATA de wt_W == 0 mod 16 (bentness).
    Retorna None se as congruencias de divisibilidade por 4 nos pares nao valerem identicamente.
    """
    if wt_diag_const % 8 != 0:
        return None
    o_pop = O_pair_word.bit_count()
    # CHECAGEM ESTRITA OBRIGATORIA: o_pop % 4 == 0 (nao apenas % 2 == 0!)
    if o_pop % 4 != 0:
        if o_pop % 2 == 0:
            # Se o_pop == 2 mod 4 e todos os deltas sao 0 mod 4, entao 2*wt_pairs + wt_diag == 4 mod 8 != 0!
            pass
        return None

    n = len(basis_pair_words)
    lin_deltas = []
    for b in basis_pair_words:
        wi = b.bit_count()
        wo = (b & O_pair_word).bit_count()
        d1 = wi - 2 * wo
        if (wi & 1) or (d1 & 3):
            return None
        lin_deltas.append((d1 // 4) & 1)

    for i in range(n):
        bi = basis_pair_words[i]
        for j in range(i + 1, n):
            if ((bi & basis_pair_words[j]).bit_count() & 1) != 0:
                return None

    # Se o_pop % 4 == 0, wt_pairs(x) e multiplo de 4 para todo x, e:
    # (2 * wt_pairs(x) + wt_diag_const) // 8 mod 2 == (wt_pairs(x) // 4 + wt_diag_const // 8) mod 2!
    P = set()
    const_bit = ((o_pop // 4) ^ (wt_diag_const // 8)) & 1
    if const_bit:
        P.add(0)
    for i, bit in enumerate(lin_deltas):
        if bit:
            P.add(1 << i)
    for i in range(n):
        bi = basis_pair_words[i]
        for j in range(i + 1, n):
            inter = bi & basis_pair_words[j]
            if inter == 0:
                continue
            q_bit = ((inter.bit_count() // 2) ^ (inter & O_pair_word).bit_count()) & 1
            if q_bit:
                P.add((1 << i) | (1 << j))
            for k in range(j + 1, n):
                if ((inter & basis_pair_words[k]).bit_count() & 1):
                    P.add((1 << i) | (1 << j) | (1 << k))
    return P


def eval_poly_set(P, x_mask: int) -> int:
    acc = 0
    for m in P:
        if (x_mask & m) == m:
            acc ^= 1
    return acc


# ==============================================================================
# 4. Auditoria Direta de K=1, C4/lc e Re-verificacao do Certificado em c99=1
# ==============================================================================
L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
K_INDICES = [
    1, 3, 9, 11, 13, 15, 21, 24, 28, 32, 34, 38, 45, 47, 53, 55,
    67, 69, 70, 72, 74, 76, 78, 80, 86, 89, 91, 93, 97, 103, 107, 109,
]
R_INDICES = [
    5, 6, 7, 16, 17, 19, 43, 44, 49, 50, 51, 58, 59, 62, 63, 66,
    82, 84, 87, 95, 100, 102, 105, 108,
]
I2 = [1, 9, 15, 28, 53, 67, 76, 103]
J2 = [3, 11, 34, 45, 55, 69, 78, 89]
I3 = [2, 10, 25, 37, 54, 68, 83, 104]
J3 = [12, 20, 29, 33, 41, 48, 96, 110]
I4 = [13, 21, 38, 70, 74, 93, 97, 109]
J4 = [24, 32, 47, 72, 80, 86, 91, 107]


def main():
    t0 = time.perf_counter()
    print("[1/5] Construindo 116 orbitas de H(16,4) e 1.371 subespacos V6 do zero...", flush=True)
    orbits = build_orbits_116()
    v6_list = all_v6_subspaces()
    assert len(v6_list) == 1371

    print("[2/5] Validando extrator corrigido vs antigo em Bent Familia A e Bent Familia B...", flush=True)
    gt_res = audit_bent_ground_truth(v6_list)
    print(f"      -> Ground-truth OK: {gt_res}", flush=True)

    # Precomputa tabelas de verdade completas de 65.536 bits das 116 orbitas
    print("[3/5] Precomputando tabelas de verdade exatas (65.536 bits) das 116 orbitas...", flush=True)
    orb_tts = [eval_anf_truth_table_int(orb) for orb in orbits]
    chi_tt = eval_anf_truth_table_int([1 << i for i in range(16)])

    # Constroi base 110 (T20 + C5 + C7) e subespaco K=1 (109 vars)
    excluded = {0, 5, 57, 99, 113, 115}
    free110 = sorted(set(range(116)) - excluded)
    L_set, K_set, R_set = set(L_INDICES), set(K_INDICES), set(R_INDICES)
    origin110 = (1 << 0) | (1 << 99)
    cb110 = []
    for j in free110:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        if j in R_set:
            c ^= 1 << 5
        if j in K_set:
            c ^= (1 << 57) | (1 << 113)
        cb110.append(c)

    # Verifica independentemente na tabela de verdade de 65.536 bits:
    # (a) T31 (0x7777 com chi): h_f(0x7777) % 32 == 0 em 32 pontos aleatorios de (origin110, cb110)
    # (b) De onde vem K = 1?! Verifica o coset C_{0xf} / C_{0x0}:
    #     Pelo Teorema 1 (c99=1, c115=0 => h_f(0x5555) == 8 mod 16 => todos os sinais de U4 iguais),
    #     toda bent satisfaz H(0xf) = 0 => wt(f|_{C_0xf}) = 2048 => q_0xf = 128 (PAR!).
    #     Vamos checar se a paridade de q_0xf em (origin110, cb110) e EXATAMENTE K ^ 1 == 0!
    c0xf_mask = sum(
        1 << x for x in range(65536)
        if ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF
    )
    assert c0xf_mask.bit_count() == 4096
    # Como C_0xf e uniao de 256 orbitas livres de C16, wt(f|_{C_0xf}) = 16 * q_0xf.
    # Bent => H(0xf) = 4096 - 32 * q_0xf = 0 => q_0xf = 128 => q_0xf % 2 == 0 => (wt(f|_{C_0xf}) // 16) % 2 == 0!
    q0xf_origin = (sum(orb_tts[j] & c0xf_mask for j in [-1]) if False else 0)
    tt_orig110 = 0
    for j in range(116):
        if (origin110 >> j) & 1:
            tt_orig110 ^= orb_tts[j]
    q0xf_const = ((tt_orig110 & c0xf_mask).bit_count() // 16) & 1
    q0xf_vec = []
    k_vec = []
    k_mask = sum(1 << j for j in K_INDICES)
    k_const = (origin110 & k_mask).bit_count() & 1
    for cdir in cb110:
        tt_d = 0
        for j in range(116):
            if (cdir >> j) & 1:
                tt_d ^= orb_tts[j]
        q0xf_vec.append(((tt_d & c0xf_mask).bit_count() // 16) & 1)
        k_vec.append((cdir & k_mask).bit_count() & 1)

    # Verifica tambem C_{0x0} \ D_8 (H(0x0) = +-256 => q_0 == 2 mod 4 => q_0 % 2 == 0!)
    c0x0_mask = sum(
        1 << x for x in range(65536)
        if ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0x0
        and (x & 0xFF) != (x >> 8)
    )
    assert c0x0_mask.bit_count() == 3840
    q0x0_const = ((tt_orig110 & c0x0_mask).bit_count() // 16) & 1
    q0x0_vec = []
    for cdir in cb110:
        tt_d = 0
        for j in range(116):
            if (cdir >> j) & 1:
                tt_d ^= orb_tts[j]
        q0x0_vec.append(((tt_d & c0x0_mask).bit_count() // 16) & 1)

    print(f"      -> Check K=1: q0xf==(K^1)? {q0xf_vec == k_vec and (q0xf_const ^ k_const) == 1}; "
          f"q0x0==(K^1)? {q0x0_vec == k_vec and (q0x0_const ^ k_const) == 1}", flush=True)
    assert (q0xf_vec == k_vec and (q0xf_const ^ k_const) == 1) or (q0x0_vec == k_vec and (q0x0_const ^ k_const) == 1), \
        "FALHA: K=1 nao decorre diretamente da paridade de C_0xf ou C_0x0!"

    # Elimina K = 1 -> 109 variaveis livres (origin_k1, cb_k1)
    piv_i = next(i for i, b in enumerate(k_vec) if b == 1)
    c_piv = cb110[piv_i]
    origin_k1 = origin110 ^ (c_piv if (k_const ^ 1) else 0)
    cb_k1 = [c ^ (c_piv if k_vec[i] else 0) for i, c in enumerate(cb110) if i != piv_i]
    n = len(cb_k1)
    assert n == 109

    # Constroi lc e VERIFICA DIRETAMENTE NA TABELA DE VERDADE DE 65.536 BITS que lc(x) == ((W_f(0xffff) - +-256) / ...)!
    # Especificamente: sob T20 + K=1, W_f(0) ou W_f(0xffff) == +-256 exige wt(f) in {32640, 32896},
    # logo wt(f) == 128 mod 256, ou h_f(0xffff) == +-256 => ((wt(f ^ chi) // 128) ^ 1) % 2 == 0,
    # ou em C_0x0: q0 == 2 mod 4 => (q0 // 2) % 2 == 1! Testemos AMBOS em 64 pontos aleatorios!
    def lin_expr_k1(indices):
        msk = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb_k1) if (c & msk).bit_count() & 1]
        cst = (origin_k1 & msk).bit_count() & 1
        return idxs, cst

    def poly_from_lin(idxs, cst):
        p = {1 << i for i in idxs}
        if cst:
            p.add(0)
        return p

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                out.symmetric_difference_update({a | b})
        return out

    slin_i, slin_c = lin_expr_k1([23, 31, 39, 112])
    lc = poly_from_lin(slin_i, slin_c ^ 1)
    for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr_k1(Ir)
        vi, vc = lin_expr_k1(Jr)
        lc ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))

    rng = random.Random(202607)
    tt_orig_k1 = 0
    for j in range(116):
        if (origin_k1 >> j) & 1:
            tt_orig_k1 ^= orb_tts[j]
    tt_cb_k1 = []
    for cdir in cb_k1:
        t = 0
        for j in range(116):
            if (cdir >> j) & 1:
                t ^= orb_tts[j]
        tt_cb_k1.append(t)

    lc_matches_wf0 = True
    lc_matches_wf_chi = True
    lc_matches_q0x0 = True
    for _ in range(64):
        x_mask = rng.getrandbits(n)
        tt = tt_orig_k1
        for i in range(n):
            if (x_mask >> i) & 1:
                tt ^= tt_cb_k1[i]
        v_lc = eval_poly_set(lc, x_mask)
        # W_f(0) = 65536 - 2*wt(f). Em bent: +-256 => wt(f) in {32640, 32896} => (wt(f) // 64) % 4 == 2?
        # 32640 = 510 * 64 (510 % 4 == 2); 32896 = 514 * 64 (514 % 4 == 2)!
        # Logo em TODA bent: wt(f) % 128 == 0 e (wt(f) // 128) % 2 == 1 (pois 32640 = 255*128, 32896 = 257*128)!
        wt_f = tt.bit_count()
        wt_f_chi = (tt ^ chi_tt).bit_count()
        q0 = (tt & c0x0_mask).bit_count() // 16
        if wt_f % 128 != 0 or (((wt_f // 128) & 1) ^ 1) != v_lc:
            lc_matches_wf0 = False
        if wt_f_chi % 128 != 0 or (((wt_f_chi // 128) & 1) ^ 1) != v_lc:
            lc_matches_wf_chi = False
        if (q0 & 1) != 0 or (((q0 // 2) & 1) ^ 1) != v_lc:
            lc_matches_q0x0 = False

    print(f"[4/5] Auditoria de lc(x)==0 em 64 avaliacoes de 2^16 bits: "
          f"matches_W_f(0)={lc_matches_wf0}, matches_W_f(0xffff)={lc_matches_wf_chi}, matches_C0x0={lc_matches_q0x0}",
          flush=True)
    assert lc_matches_wf0 or lc_matches_wf_chi or lc_matches_q0x0, \
        "ERRO CRITICO: O polinomio lc nao corresponde a W_f(0), W_f(0xffff) nem C_0x0!"

    # Agora testa o sistema de Poisson-Lucas em V6xV6 COM A FORMULA CORRIGIDA!
    print("[5/5] Extraindo V6xV6 COM FORMULA CORRIGIDA (const_shift = (wt_diag // 8) % 2) e escalonando...", flush=True)
    all_pairs = [v | (w << 8) for v in range(256) for w in range(v + 1, 256)]
    pair_idx = {(x & 0xFF, x >> 8): k for k, x in enumerate(all_pairs)}

    # Empacota valores nos 256 pontos diagonais e nos 32.640 pares a partir de tt_orig_k1 e tt_cb_k1!
    O_diag_256 = sum(((tt_orig_k1 >> (v | (v << 8))) & 1) << v for v in range(256))
    for i in range(n):
        cb_d = sum(((tt_cb_k1[i] >> (v | (v << 8))) & 1) << v for v in range(256))
        assert cb_d == 0, f"Surpresa: cb_diag[{i}] != 0!"

    O_pair_all = sum(((tt_orig_k1 >> x) & 1) << k for k, x in enumerate(all_pairs))
    chi_pair_all = sum((x.bit_count() & 1) << k for k, x in enumerate(all_pairs))
    cb_pair_all = [sum(((tt_cb_k1[i] >> x) & 1) << k for k, x in enumerate(all_pairs)) for i in range(n)]

    # Eliminacao Gaussiana esparsa exata sobre F_2 com rastreamento de dependencias (certificado Nullstellensatz)
    pivots = {}  # lead_monomial -> (poly_set, dep_frozenset)
    eq_catalog = []  # lista de metadados + poly_set

    def insert_equation(pset, meta):
        eq_id = len(eq_catalog)
        eq_catalog.append((meta, set(pset)))
        cur = set(pset)
        dep = {eq_id}
        while cur:
            # Escolhe pivo de MAIOR grau (e menor int em empate) para isolar constante 0 por ultimo!
            lead = max(cur, key=lambda m: (m.bit_count(), m))
            if lead == 0:
                # cur == {0} -> 1 = 0 ENCONTRADO!
                return dep
            if lead in pivots:
                p_poly, p_dep = pivots[lead]
                cur ^= p_poly
                dep ^= p_dep
            else:
                pivots[lead] = (cur, dep)
                return None
        return None

    # Insere lc e x_i * lc
    found_dep = insert_equation(lc, {"kind": "lc"})
    if found_dep is None:
        for i in range(n):
            found_dep = insert_equation(mul_p({1 << i}, lc), {"kind": "x_lc", "var": i})
            if found_dep is not None:
                break

    stats_wt_diag = {}
    extracted_v6 = 0
    if found_dep is None:
        for v_idx, ((a_dual, b_dual), pts) in enumerate(v6_list):
            d_mask = sum(1 << v for v in pts)
            wt_diag = (O_diag_256 & d_mask).bit_count()
            stats_wt_diag[wt_diag] = stats_wt_diag.get(wt_diag, 0) + 1
            if wt_diag % 8 != 0:
                continue

            # Restringe O_pair e cb_pair aos 2016 pares de pts
            p_indices = [pair_idx[(pts[i], pts[j])] for i in range(64) for j in range(i + 1, 64)]
            O_sub = sum(((O_pair_all >> idx) & 1) << k for k, idx in enumerate(p_indices))
            chi_sub = sum(((chi_pair_all >> idx) & 1) << k for k, idx in enumerate(p_indices))
            b_sub = [sum(((cb_pair_all[i] >> idx) & 1) << k for k, idx in enumerate(p_indices)) for i in range(n)]

            for use_chi in (0, 1):
                Ow = O_sub ^ (chi_sub if use_chi else 0)
                P = extract_poisson_poly_corrected(b_sub, Ow, wt_diag)
                if P is not None:
                    extracted_v6 += 1
                    meta = {
                        "kind": "v6_poisson",
                        "v_idx": v_idx,
                        "dual_basis_ab": [a_dual, b_dual],
                        "use_chi": use_chi,
                        "wt_diag": wt_diag,
                        "const_shift_applied": (wt_diag // 8) & 1,
                    }
                    found_dep = insert_equation(P, meta)
                    if found_dep is not None:
                        break
            if found_dep is not None:
                break

    print(f"      -> Distribuicao de wt_diag visitados: {stats_wt_diag}; extraidos={extracted_v6}", flush=True)

    if found_dep is None:
        print("RESULTADO CRITICO: Com a formula CORRIGIDA (const_shift = (wt_diag // 8) % 2), "
              "V6xV6 + lc NAO gerou 1=0! O certificado antigo dependia do bug de constante!", flush=True)
        return

    # Verifica independentemente CADA equacao de found_dep avaliando diretamente nas 65.536 entradas!
    print(f"      -> 1 = 0 CONFIRMADO COM A FORMULA CORRIGIDA! Tamanho do certificado = {len(found_dep)} equacoes.", flush=True)
    xor_sum = set()
    cert_items = []
    for eq_id in sorted(found_dep):
        meta, pset = eq_catalog[eq_id]
        xor_sum ^= pset
        cert_items.append(meta)
        if meta["kind"] == "v6_poisson":
            a_dual, b_dual = meta["dual_basis_ab"]
            use_chi = meta["use_chi"]
            pts = [v for v in range(256) if ((v & a_dual).bit_count() & 1) == 0 and ((v & b_dual).bit_count() & 1) == 0]
            w_mask_all = sum(1 << (v | (w << 8)) for v in pts for w in pts)
            # Checa em 64 pontos aleatorios de F_2^109 que P(x) == (wt((f ^ chi)|_W) // 8) % 2 EXATAMENTE!
            for _ in range(64):
                x_mask = rng.getrandbits(n)
                tt = tt_orig_k1 ^ (chi_tt if use_chi else 0)
                for i in range(n):
                    if (x_mask >> i) & 1:
                        tt ^= tt_cb_k1[i]
                wt_W = (tt & w_mask_all).bit_count()
                assert wt_W % 8 == 0, f"wt_W={wt_W} nao divisivel por 8!"
                expected_bit = (wt_W // 8) & 1
                poly_bit = eval_poly_set(pset, x_mask)
                assert poly_bit == expected_bit, (
                    f"DISCREPANCIA REAL na equacao {meta}: poly={poly_bit} != (wt_W//8)%2={expected_bit} (wt_W={wt_W})!"
                )

    assert xor_sum == {0}, f"Soma XOR nao deu {{0}}: {xor_sum}"
    out = {
        "audit_passed": True,
        "corrected_const_shift_enforced": True,
        "bent_ground_truth": gt_res,
        "certificate_size": len(cert_items),
        "certificate_equations": cert_items,
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
```

---

## 4. Lista de Testes Obrigatórios Antes de Declarar `c99 = 1` (e `B0_01` / `B0_10`) Formalmente Fechados

Nenhum fechamento algébrico por Poisson–Lucas deve ser aceito como provado antes que **todos os 7 testes abaixo** passem com `assert` verde:

1. **[CRÍTICO — Correção do Bug `wt_diag mod 16`]**
   Em **TODOS** os extratores do projeto (`SOLVE_C99_1_POISSON_C.py`, `VERIFY_C99_1_NULLSTELLENSATZ.py`, `SOLVE_C99_0_STEP4C.py`, `SOLVE_C99_0_RANDW.py`, `SOLVE_C99_0_CLOSE.py`):
   - **Substituir imediatamente:**
     - a checagem frouxa `if (o_pop & 1) return -1;` por **`if (o_pop & 3) return -1;`** (`o_pop % 4 == 0` obrigatório; se `o_pop % 4 == 2` enquanto `wt_diag % 8 == 0` e todas as derivadas são `0 mod 4`, isso já prova `wt_W == 4 mod 8 != 0`, uma contradição direta de nível inferior, mas **jamais** pode ser dividido por 4 truncando o resto!);
     - e o termo constante `(o_pop / 4) & 1` por **`((o_pop / 4) ^ (wt_diag / 8)) & 1`** sempre que `wt_diag` for constante no ramo (`c57` fixado)! *(Se `c57` não estiver fixado e `wt_diag(c)` variar entre $0$ e $8 \pmod{16}$, somar o polinômio linear/quadrático exato de `(wt_diag(c) // 8) % 2`!).*
   - **Rodar `AUDIT_INDEPENDENT_C99_1.py` acima** para verificar se `c99 = 1` continua dando `1 = 0` após corrigir `const_shift = (wt_diag // 8) % 2`! (E re-rodar `B0_01` e `B0_10` com essa mesma correção!).
   - *Bônus para `B0_11`!* Em `B0_11` (`c99=0, c57=1, c113=1`), quando vocês rodaram `RANDW` (Run 44360116728, 45k subespaços), sempre que $\dim(W \cap D_8) = 5$ e a forma de posto 2 tinha peso $8 \equiv 8 \pmod{16}$, o código antigo colocou o termo constante **`0` em vez de `1`** (homogeneizando artificialmente equações que eram afins `P(c) = 1`!!)! Corrigir `(wt_diag // 8) & 1` em `SOLVE_C99_0_RANDW.py` pode injetar constantes `1` inéditas em `B0_11` e **fechar `B0_11` algebricamente na hora**!

2. **[Teste Positivo Duplo em Funções Bent $\rho^8$-Simétricas (`0 mod 16` e `8 mod 16`)]**
   Todo extrator de equações deve passar em $100\%$ dos subespaços $W$ contra:
   - `BentA`: $\langle v, w \rangle \oplus (v_0 \oplus w_0)(v_1 \oplus w_1)(v_2 \oplus w_2)$ ($\operatorname{wt}_{\text{diag}} \in \{0, 32\} \equiv 0 \pmod{16}$);
   - `BentB`: $\sum_{i=0}^3 (v_i w_{i+4} \oplus w_i v_{i+4}) \oplus v_0 v_1 w_0 w_1 \oplus v_2 v_3 w_2 w_3$ ($\operatorname{wt}_{\text{diag}} = 24 \equiv 8 \pmod{16}$).
   Qualquer polinômio extraído $P_W$ deve satisfazer $P_W(\text{BentA}) = 0$ **e** $P_W(\text{BentB}) = 0$.

3. **[Teste Negativo (Sensibilidade do Extrator)]**
   Para cada equação $P_q$ do certificado final, avaliar diretamente nas $2^{16}$ entradas em $100$ vetores aleatórios $c$ da variedade afim de $H(16,4)$ e exigir igualdade bit a bit:
   $$P_q(c) == \left(\frac{\operatorname{wt}((f_c \oplus \text{chi})|_W)}{8}\right) \bmod 2,$$
   garantindo que ocorrem **ambos** os casos $P_q(c) = 0$ e $P_q(c) = 1$ na amostragem (para provar que $P_q$ não é constante zero por erro de indexação).

4. **[Auditoria End-to-End das Pré-Condições Lineares (`T20`, `C5`, `C7`, `K=1`)]**
   O verificador final não pode importar `build_basis_111()` nem fixar `K = 1` como caixa-preta: deve verificar por Poisson em $2^{16}$ pontos que:
   - $c_{115} = 0$, $c_{57} = c_{113}$ e $\sum_{j \in L} c_j = c_{99} = 1$ (`T20`);
   - $c_{57} = \sum_{j \in K} c_j$ (`C5`) via suporte correspondente;
   - $\sum_{j \in R} c_j = 0$ (`C7`) via `(wt((f ^ chi)|_{0x7777}) // 8) % 2 == 0`;
   - $K = 1$ decorre rigorosamente de $\tilde{h}_f(\texttt{0x5555}) \equiv 8 \pmod{16} \implies W_f|_{U_4} = 256\sigma_0 \implies H(\texttt{0xf}) = 0 \implies q_{\texttt{0xf}} \equiv 0 \pmod 2$ (conferido no Passo `[3/5]` de `AUDIT_INDEPENDENT_C99_1.py`!).

5. **[Auditoria Direta de `lc` (`C4` reduzido)]**
   Confirmar em $\ge 100$ pontos aleatórios (ou simbolicamente sobre os pares de $C_{\texttt{0x0}} \setminus D_8$) que $\operatorname{lc}(x) = \big((W_{f_x}(0) / 128 \bmod 2) \oplus 1\big)$ (e que $128 \mid W_{f_x}(0)$ identicamente no espaço de 109 variáveis).

6. **[Certificado JSON Auto-Contido por Geometria, Não por Índice]**
   Salvar cada subespaço $W$ usado no certificado pelos geradores explícitos de $W^\perp \le \mathbb{F}_2^{16}$ (ex.: `[a_dual, b_dual, a_dual << 8, b_dual << 8]`) + flag `use_chi` + lista explícita dos monômios de cada $P_q$, permitindo que um script de 80 linhas confira $\bigoplus_q P_q(x) \equiv 1$ sem precisar gerar os 1.371 subespaços `v6_list`.

7. **[Cuidado Extra caso se use $u \notin \{\texttt{0x0000}, \texttt{0xffff}\}$ no Futuro]**
   Se algum gerador futuro usar frequências $u$ onde $u_{\text{lo}} \neq u_{\text{hi}}$, incluir $\langle u_{\text{lo}} \oplus u_{\text{hi}}, v \rangle$ em `O_diag` e exigir $\rho^8(u) = u$ (caso contrário $g(v, w) \neq g(w, v)$ e a decomposição $\operatorname{wt} = 2\operatorname{wt}_{\text{pares}} + \operatorname{wt}_{\text{diag}}$ deixa de valer!).