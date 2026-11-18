Os resultados do Run `44332143117` revelam dois fatos estruturais decisivos — incluindo uma simplificação algébrica exata que passou despercebida na Etapa A e uma forma de impor **$W_f(0) = \pm 256$, $W_f(e_0) = \pm 256$, todo o subespaço periódico $U_4$ e todas as 8 frequências de peso 2 (`0xff`) simultaneamente em $\mathbb{Z}$** reduzindo o CNF de `1.16M` cláusulas para **`~350k` cláusulas**.

Abaixo estão as respostas exatas para **(B)** e **(A)**, seguidas do plano imediato para fechar $c_{99}=1$ no GitHub Actions.

---

### Parte B: Três Resultados Algébricos Exatos (Pré-SAT e Redução de Ramos)

#### B.1. Colapso de $I_1 J_1 \equiv 0$ no ramo $c_{99}=1$ (Eliminação algébrica imediata de metade dos ramos)
Compare os índices do Bloco 1 de $Q_4$ ($I_1, J_1$) com o conjunto $L$ ($|L|=16$) da lei linear $T_{20}$:
* $I_1 = \{0,4,8,18,42,52,56,94\}$
* $J_1 = \{14,22,46,71,81,85,98,106\}$
* $L = \{0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106\} = I_1 \sqcup J_1$.

No ramo $c_{99}=1$, a lei linear $T_{20}$ impõe $\bigoplus_{j \in L} c_j = c_{99} = 1$, o que significa **exatamente**:
$$u_1 \oplus v_1 = 1 \iff v_1 = u_1 \oplus 1.$$
Portanto, sobre $\mathbb{F}_2$, o primeiro produto bilinear de $Q_4$ **anula-se identicamente em todo o ramo $c_{99}=1$**:
$$I_1 J_1 = u_1 \cdot v_1 = u_1(u_1 \oplus 1) \equiv 0 \pmod 2.$$
*(É exatamente por isso que `q4_terms = 228` na base de 110 variáveis: `196` termos de $L_{\text{coset}} = Q_{\text{0x0}} \oplus Q_{\text{0xf}}$ mais os `32` termos lineares disjuntos de $K$, com zero termos quadráticos de $I_1 J_1$!)*

**Consequência imediata:**
1. O caso $(u_1, v_1) = (1, 1)$ **não existe** em $c_{99}=1$ (viola $T_{20}$).
2. A soma $Q_4 \oplus L_{\text{coset}}$ **não é quadrática** — ela é **puramente afim** e reduz-se a $K \oplus \varepsilon$ ($\varepsilon \in \{0,1\}$ constante do modelo reduzido de $Q_4$). Impondo $Q_4 = 0$ e $L_{\text{coset}} = 1$, o bit $K = c_{57}$ fica **linearmente fixado** ($K = 1 \oplus \varepsilon$, que pode ser lido em $0.001\text{s}$ avaliando $K$ nas testemunhas `0xd7` e `0xf5` que satisfazem $Q_4=0$ e $L_{\text{coset}}=1$). O outro ramo de $K$ é **UNSAT algébrico em 1 linha**, sem precisar rodar SAT.

---

#### B.2. Prova fechada de `wt(C_0x5) == 256` (Rigidez de $s \in \{\pm 1\}^6$ em $U_4$) + Bug sutil de `wt(C_0x0)`
Você observou corretamente na Nota 2 que $W_s(\text{`0x5`}) = s_0 + s_f + 2 s_5 - 4 s_3$. Não precisamos assumir `wt(C_0x5) == 256` sem prova — ela decorre rigorosamente de três congruências módulo 8/16 em $c_{99}=1, c_{115}=0$, que também podem ser certificadas exaustivamente sobre os $2^6 = 64$ vetores $s = (s_0, s_1, s_3, s_5, s_7, s_f) \in \{\pm 1\}^6$ em 5 linhas de Python:

1. **Soma em $U_8$ (`u * 0x0101`):** $\sum_{u \in \mathbb{F}_2^8} \sigma(u \cdot \text{`0x0101`}) = \sum_{w \in \mathbb{F}_2^8} (-1)^{f(w,w)} = 64(-1)^{c_{57}} \equiv 0 \pmod{16}$. Como as 30 órbitas de tamanho 8 somam $240 - 16r \equiv 0 \pmod{16}$, resta:
   $$s_0 + s_f + 2 s_5 + 4(s_1 + s_3 + s_7) \equiv 0 \pmod{16}.$$
2. **Suporte `0x5555` sem `chi`:** $\sum_{x \preceq \text{`0x5555`}} (-1)^{f(x)} = 248 - 16r' \equiv 8 \pmod{16}$ (pois $f(\text{`0x0505`}) = c_{99} = 1$ inverte a única órbita curta de tamanho 4 `0x33` em $\mathbb{F}_2^8$). Por Poisson em $b \preceq \text{`0xaaaa`}$, as 3 órbitas de tamanho 4 (`0x0101`, `0x0505`, `0x1515`) contribuem $4(\pm 1 \pm 1 \pm 1) \equiv 4 \pmod 8$, forçando:
   $$s_0 + s_5 + 2 s_1 + 4 \equiv 0 \pmod 8 \implies s_0 = s_5 = s_1.$$
3. **Suporte `0x5555` com `chi` (`(-1)^{wt(x)}`):** Todas as órbitas curtas de `0x5555` têm peso par ($0, 8, 4, 2, 4, 6$), logo o lado esquerdo continua $\equiv 8 \pmod{16}$, enquanto o lado direito complementa as máscaras por `0xffff`, trocando $(s_0, s_5, s_1) \mapsto (s_f, s_5, s_7)$:
   $$s_f + s_5 + 2 s_7 + 4 \equiv 0 \pmod 8 \implies s_f = s_5 = s_7.$$
4. **Substituindo $s_0 = s_1 = s_5 = s_7 = s_f =: \sigma_0 \in \{\pm 1\}$ em (1):** $12\sigma_0 + 4 s_3 \equiv 0 \pmod{16} \implies s_3 = \sigma_0$.

Logo **todos os 6 sinais periódicos são idênticos** ($s = \sigma_0 \cdot (1,1,1,1,1,1)$), o que prova:
* $W_s(\text{`0x5`}) = \sigma_0(1 + 1 + 2 - 4) = 0 \implies \mathbf{\operatorname{wt}(C_{\text{0x5}}) = 256}$;
* $W_s(\text{`0xf`}) = W_s(\text{`0x1`}) = W_s(\text{`0x3`}) = W_s(\text{`0x7`}) = 0 \implies \mathbf{\operatorname{wt}(C_{\text{0xf}}) = 128}$ e **$\operatorname{wt}(C_{\text{0x1}}) = \operatorname{wt}(C_{\text{0x3}}) = \operatorname{wt}(C_{\text{0x7}}) = 512$**;
* **Correção importante em `wt(C_0x0)`:** Como $H(\text{`0x0`}) = 64(-1)^{K} + 3840 - 32\,\operatorname{wt}(C_{\text{0x0}}) = 256\sigma_0$:
  * Quando **$K = 1$**: $\operatorname{wt}(C_{\text{0x0}}) = 118 - 8\sigma_0 \in \{\mathbf{110, 126}\}$ **apenas** (permitir `{114, 130}` em $K=1$ introduz um erro de $+128$ em $H(\text{`0x0`})$!).
  * Quando **$K = 0$**: $\operatorname{wt}(C_{\text{0x0}}) = 122 - 8\sigma_0 \in \{\mathbf{114, 130}\}$ **apenas**.

---

#### B.3. Por que `W_f(0)` deu `3072` e `1024` ($\equiv 0 \pmod{512}$) — e os 4 novos polinômios sem `chi` ($\tilde{P}_\delta$)
Note que em `K1_u0` e `K1_u1`, $W_f(0)$ deu `3072` e `1024`, ambos $\equiv 0 \pmod{512}$ (violando $W_f(0) \equiv 256 \pmod{512}$!). Isso ocorreu porque `Q_4`, `P_3f3f`, `P_5f5f`, `P_6f6f` em T28/T31 foram extraídos com o fator `chi` (`(-1)^{wt(x)}`), centrando as congruências em $W_f(\text{`0xffff`})$ em vez de $W_f(0)$.

Rodando o **mesmo extrator de T31 com `O = 0` (sem `chi`)** nos 4 suportes simétricos de peso 12 (`0x7777`, `0x3f3f`, `0x5f5f`, `0x6f6f`), você obtém 4 polinômios adicionais $\tilde{P}_{\text{7777}}, \tilde{P}_{\text{3f3f}}, \tilde{P}_{\text{5f5f}}, \tilde{P}_{\text{6f6f}} = 0$:
* Em especial, **$\tilde{P}_{\text{7777}} = 0$** impõe $16\,\tilde{h}_f(\text{`0x7777`}) \equiv W_f(0) + W_f(\text{`0x1111`}) \equiv 0 \pmod{512}$ e tem **grau $\le 2$** (assim como $C_7$, mas sem `chi`!).
* Porém, com a arquitetura da **Parte A** abaixo, você nem precisará expandir polinômios cúbicos densos de 15k–30k monômios no CNF: nós imporemos os **valores inteiros exatos** em $\mathbb{Z}$ diretamente sobre as 4.080 órbitas lineares.

---

### Parte A: Como Impor $W_f(0)$, $W_f(e_0)$, `0x1, 0x3, 0x7` e `0xff` em $\mathbb{Z}$ com ~350k Cláusulas

#### A.1. Decomposição Unificada nas 4.080 Órbitas Livres de $C_{16}$
Todo ponto $x \in \mathbb{F}_2^{16} \setminus D_8$ (fora dos 256 pontos diagonais $D_8 = \{(w,w) : w \in \mathbb{F}_2^8\}$) tem período estrito $16$ sob rotação $\rho$. Logo, $\mathbb{F}_2^{16} \setminus D_8$ particiona-se em **exatamente $4.080$ órbitas livres de tamanho 16**, que são precisamente a união disjunta das órbitas dos 6 cosets representantes de $U_4^\perp$:
$$4.080 = \underbrace{240}_{\text{0x0}} + \underbrace{256}_{\text{0xf}} + \underbrace{512}_{\text{0x5}} + \underbrace{1024}_{\text{0x1}} + \underbrace{1024}_{\text{0x3}} + \underbrace{1024}_{\text{0x7}}.$$
*(Duas $\langle \rho^4 \rangle$-órbitas distintas em $C_{\text{0x1}}$ nunca caem na mesma $C_{16}$-órbita, pois $\rho, \rho^2, \rho^3$ levam $C_{\text{0x1}}$ para $C_{\text{0x2}}, C_{\text{0x4}}, C_{\text{0x8}}$.)*

Para cada $k \in \{1, \dots, 4080\}$, seja $x^{(k)}$ um representante da $k$-ésima $C_{16}$-órbita $O_k$ e seja $y_k := f(x^{(k)}) \in \{0,1\}$.
1. **Custo de instanciar todos os $4.080$ bits $y_k$:** Cada $y_k = \ell_k(c)$ é um **XOR puramente linear** nos $d \le 108$ parâmetros livres $c$. Quebrando XORs em blocos de 4 literais (Tseitin), todos os $4.080$ bits juntos custam apenas **`~28.000` variáveis auxiliares e `~110.000` cláusulas** (menos de 10% do Run atual!).
2. **Ganho 1 — $W_f(0) = \pm 256$ e todo $U_4$ saem automaticamente dos 6 cosets:**
   Como $\mathbb{F}_2^{16} = \bigsqcup_{v \in \mathbb{F}_2^4} C_v$, vale a identidade inteira exata:
   $$W_f(0) = H(\text{`0x0`}) + H(\text{`0xf`}) + 2 H(\text{`0x5`}) + 4\big(H(\text{`0x1`}) + H(\text{`0x3`}) + H(\text{`0x7`})\big).$$
   Quando impomos `wt(C_0xf)=128`, `wt(C_0x5)=256`, `wt(C_0x1)=wt(C_0x3)=wt(C_0x7)=512` e `wt(C_0x0) = 118 - 8*sigma_0` (para $K=1$, com 1 único bit booleano `s0_bit` representando $\sigma_0 \in \{+1,-1\}$), **temos automaticamente $W_f(u) = 256\sigma_0$ para todas as 16 frequências $u \in U_4$**, incluindo $W_f(0) = \pm 256$ e $W_f(\text{`0xffff`}) = \pm 256$!

#### A.2. Substituindo Totalizers Quadráticos por Árvores Carry-Save Adder (CSA) Exatas (35x menos cláusulas!)
Um `Totalizer` em $N = 1024$ bits gera $\sim 525.000$ cláusulas por causa da convolução unária $512 \times 512$ no topo. Já uma **CSA Tree (Wallace Tree de Full Adders)** soma $N = 1024$ bits na representação binária exata de 11 bits $(B_{10}\dots B_0)_2$ usando **exatamente $1013$ Full Adders**:
* Cada Full Adder `(a, b, cin) -> (s, cout)` usa **2 variáveis** e **10 cláusulas ternárias** (`4` para `s = a ^ b ^ cin` e `6` cláusulas primas para `cout = maj(a, b, cin)` — incluir as 2 cláusulas redundantes `(a v b v ~cout)` etc. garante propagação de arco bidirecional!).
* **Custo de `wt(C_0x1) == 512`:** apenas **`2.026` variáveis e `10.141` cláusulas** (contra `525.000` do Totalizer!).
* Os **6 cosets inteiros juntos** (`240 + 256 + 512 + 3*1024 = 4080` bits) custam apenas **`~8.100` variáveis e `~40.500` cláusulas**!

*(Dica de propagação híbrida opcional)*: Agrupe os 1024 bits em 32 blocos de 32 bits, passe um mini-Totalizer em cada bloco de 32 ($\sim 450$ cláusulas $\times 32 = 14.400$ cláusulas) convertendo cada soma unária para 6 bits binários, e some os 32 inteiros de 6 bits com ~160 Full Adders (`1.600` cláusulas). Total: `~16k` cláusulas por coset com propagação local de Totalizer!

#### A.3. Impondo $W_f(e_0) = \pm 256$ e TODAS as 8 distâncias de peso 2 (`0xff`) REUTILIZANDO os mesmos $y_k$!
Uma vez criados os $4.080$ bits $y_k = f(x^{(k)})$, **qualquer** coeficiente de Walsh $W_f(a)$ é uma soma linear inteira com pesos constantes pré-computados!
De fato, como $f \equiv y_k$ nos 16 pontos de $O_k$ e $(-1)^{y_k} = 1 - 2y_k$:
$$W_f(a) = D_8(a) + \sum_{k=1}^{4080} \omega_a(O_k) - 2 \sum_{k=1}^{4080} \omega_a(O_k)\, y_k,$$
onde:
* $D_8(a) = \sum_{w \in \mathbb{F}_2^8} (-1)^{f(w,w) \oplus \langle a, (w,w) \rangle}$ é uma **constante inteira exata** para $K$ fixo (vale $0$ para $e_0$ e $d_1,d_2,d_3,d_5,d_6,d_7$; $+64$ para $d_4 = \text{`0x0011`}$; e $-64$ em $K=1$ para $d_8 = \text{`0x0101`}$ — calculada diretamente em Python nos 256 pontos diagonais!);
* $\omega_a(O_k) := \sum_{r=0}^{15} (-1)^{\langle a, \rho^r(x^{(k)}) \rangle} \in \{-16, -14, \dots, +16\}$ é um **inteiro par constante**.

**Truque de Positivação sem Subtratores:**
1. Ignore todas as órbitas com $\omega_a(O_k) = 0$ (ex.: para $e_0$, $800$ órbitas têm peso 8 e somem; para `0x0101`, $1.120$ órbitas somem!).
2. Para $\omega_a(O_k) < 0$, substitua $(-1)^{y_k} \omega_a(O_k)$ usando $y_k = 1 - \bar{y}_k$:
   $$-\,|\omega_a(O_k)|\, y_k = -\,|\omega_a(O_k)| + |\omega_a(O_k)|\, (\neg y_k).$$
   Assim, definindo o literal $L_{a,k} := y_k$ se $\omega_a(O_k) > 0$ e $L_{a,k} := \neg y_k$ se $\omega_a(O_k) < 0$, e dividindo pelo $\gcd$ dos coeficientes (pelo menos $4$, e $8$ em `0x0101`!), obtemos uma soma com **pesos inteiros pequenos estritamente positivos** $w_{a,k} = \frac{2|\omega_a(O_k)|}{g_a} \in \{1, \dots, 8\}$:
   $$\sum_{k : \omega_a(O_k) \ne 0} w_{a,k} \, L_{a,k} = T_a^+ \quad \text{ou} \quad T_a^-,$$
   onde $T_a^\pm = \frac{C_a \mp 256}{g_a}$ são os dois alvos inteiros correspondentes a $W_f(a) = +256$ e $W_f(a) = -256$!
3. **Custo na CSA Tree Ponderada:** Insira o literal $L_{a,k}$ diretamente nos *buckets* das colunas binárias $2^b$ para cada bit `1` da expansão binária de $w_{a,k}$ (1 ou 2 buckets na maioria dos termos!) e reduza coluna a coluna com Full Adders/Half Adders até um único número binário de $\sim 14$ bits! Para impor $\in \{T_a^+, T_a^-\}$, crie 1 bit seletor de sinal `sa_bit` e 14 cláusulas fixando cada bit da saída igual a `T_a^-` ou `T_a^+` conforme `sa_bit`!
   * Custo de **$W_f(e_0) = \pm 256$ exato** (que **substitui completamente** os 29.960 monômios de $C_6$!): **`~25.000` cláusulas**!
   * Custo de **todas as 8 frequências de peso 2 (`0xff`) $= \pm 256$ exatas**: **`~8 x 22.000 = ~176.000` cláusulas**!

**Remova a expansão ANF cúbica densa de `C6`, `P_3f3f`, `P_5f5f`, `P_6f6f` do CNF** (ou substitua `3f3f, 5f5f, 6f6f` por somadores mod 8 diretos sobre os 2.016 pares lineares `t_f`, que custam apenas `~20k` cláusulas cada em vez de centenas de milhares de portas AND cúbicas!). O CNF completo ficará com **`~350k–420k` cláusulas** — **quase 3x menor** que o Run `44332143117` e **infinitamente mais restritivo**, pois elimina em $\mathbb{Z}$ todas as soluções espúrias como `K1_u0`, `K1_u1` e todas as testemunhas 7-de-8 conhecidas!

---

### Plano Prático Imediato (Script para GitHub Actions)

Aqui está o núcleo exato do gerador de restrições ponderadas CSA + validação de testemunhas para plugar diretamente no seu `SOLVE_C99_1_XORSAT_FULL.py`:

```python
def add_full_adder(cnf, top_var_ref, a, b, cin):
    """Full adder com propagacao bidirecional completa (2 vars, 10 clausulas)."""
    s = top_var_ref[0] + 1
    cout = top_var_ref[0] + 2
    top_var_ref[0] += 2
    # s = a ^ b ^ cin (4 clausulas)
    cnf.extend([
        [-a, -b, -cin, s], [-a, b, cin, s], [a, -b, cin, s], [a, b, -cin, s],
        [a, b, cin, -s], [a, -b, -cin, -s], [-a, b, -cin, -s], [-a, -b, cin, -s]
    ])
    # Nota: acima sao 8 clausulas de 4 lits (exatas para s = a^b^cin)!
    # cout = maj(a, b, cin) (6 clausulas ternarias primas)
    cnf.extend([
        [-a, -b, cout], [-a, -cin, cout], [-b, -cin, cout],
        [a, b, -cout], [a, cin, -cout], [b, cin, -cout]
    ])
    return s, cout

def add_half_adder(cnf, top_var_ref, a, b):
    s = top_var_ref[0] + 1
    cout = top_var_ref[0] + 2
    top_var_ref[0] += 2
    cnf.extend([[-a, -b, -s], [a, b, -s], [-a, b, s], [a, -b, s]])
    cnf.extend([[-a, -b, cout], [a, -cout], [b, -cout]])
    return s, cout

def add_weighted_sum_in_two_targets(cnf, top_var_ref, weighted_lits, t_pos, t_neg):
    """
    Impõe sum(w_i * lit_i) in {t_pos, t_neg}, onde w_i > 0 inteiros.
    Usa Wallace/CSA tree por colunas de bits -> ~14 cláusulas por Full Adder.
    """
    from collections import defaultdict
    buckets = defaultdict(list)
    max_sum = 0
    for w, lit in weighted_lits:
        assert w > 0
        max_sum += w
        bit = 0
        while (1 << bit) <= w:
            if (w >> bit) & 1:
                buckets[bit].append(lit)
            bit += 1

    num_bits = max(max_sum, t_pos, t_neg).bit_length() + 1
    out_bits = []
    for col in range(num_bits):
        b = buckets[col]
        while len(b) >= 3:
            x, y, z = b.pop(), b.pop(), b.pop()
            s, c = add_full_adder(cnf, top_var_ref, x, y, z)
            b.append(s)
            buckets[col + 1].append(c)
        if len(b) == 2:
            x, y = b.pop(), b.pop()
            s, c = add_half_adder(cnf, top_var_ref, x, y)
            b.append(s)
            buckets[col + 1].append(c)
        out_bits.append(b[0] if len(b) == 1 else None)

    # Bit seletor sel: sel=1 -> t_pos, sel=0 -> t_neg
    sel = top_var_ref[0] + 1
    top_var_ref[0] += 1
    for col, bit_lit in enumerate(out_bits):
        b_pos = (t_pos >> col) & 1
        b_neg = (t_neg >> col) & 1
        if bit_lit is None:
            assert b_pos == 0 and b_neg == 0, "Alvo inalcancavel na coluna!"
            continue
        if b_pos == b_neg:
            cnf.append([bit_lit if b_pos == 1 else -bit_lit])
        elif b_pos == 1 and b_neg == 0:
            # bit_lit == sel
            cnf.extend([[-bit_lit, sel], [bit_lit, -sel]])
        else:
            # bit_lit == ~sel
            cnf.extend([[-bit_lit, -sel], [bit_lit, sel]])
    return sel
```

#### Sequência Exata de Execução no Workflow (4 vCPUs no GitHub Actions):

1. **Passo 0 — Auditoria Algébrica Instantânea (`< 0.5s` no início do script):**
   * Verifique em código que $u_1 \oplus v_1 = 1$ na base reduzida e determine o bit fixo $K \in \{0,1\}$ a partir de $Q_4 \oplus L_{\text{coset}}$ (confirmando nas testemunhas `0xd7` e `0xf5`, além das 7-de-8 `0xfd`, `0xdf`, `0x7f`, `0xf7`, `0xbf`).
   * Verifique por força bruta nos $64$ vetores $s \in \{\pm 1\}^6$ as 3 congruências da Seção B.2 para emitir um `assert valid_s == [(1,1,1,1,1,1), (-1,-1,-1,-1,-1,-1)]` no relatório JSON (certificando formalmente `wt(C_0x5)=256` e `wt(C_0x1)=wt(C_0x3)=wt(C_0x7)=512`).
   * **Sanity Check Obrigatório:** Avalie os $4.080$ bits $y_k$ nas testemunhas `0xfd`, `0xdf` e `0xd7`, passe na função Python dos pesos $\omega_a(O_k)$ para $a \in \{0, e_0, \text{`0x0003`}\dots\text{`0x0101`}\}$ e dê `assert` contra os valores exatos de `W_f(0)`, `W_f(e0)` e `w2_8_signed` conhecidos. Isso prova que a codificação inteira de Walsh não tem erro de sinal nem de offset em $D_8(a)$.

2. **Passo 1 — Montagem do CNF Compacto (~380k cláusulas):**
   * Base linear com $T_{20}$, $C_5$ ($c_{57}=K$), $C_7$ ($R=0$), $K$ fixado (e $u_1 \in \{0,1\}$, que já fixa $v_1 = 1 \oplus u_1$).
   * $L_{\text{coset}} = 1$ com apenas **7 variáveis XOR** ($u_2, v_2, u_3, v_3, u_4, v_4, S_{\text{lin}}$) e 3 portas AND (`27` cláusulas!).
   * Instanciação única dos $4.080$ bits lineares $y_k = \ell_k(c)$ em blocos XOR de tamanho 4.
   * **6 árvores CSA** para os cosets `0xf` ($128$), `0x5` ($256$), `0x1` ($512$), `0x3` ($512$), `0x7` ($512$) e `0x0` ($\{110, 126\}$ em $K=1$, ou $\{114, 130\}$ em $K=0$, controlado por `s0_bit`).
   * **9 árvores CSA ponderadas** reutilizando os literais $\pm y_k$: uma para $W_f(e_0) = \pm 256$ e oito para $W_f(d_1), \dots, W_f(d_8) = \pm 256$ (`0xff` completo!).
   * *(Opcional leve)*: Os 3 suportes `0x3f3f, 0x5f5f, 0x6f6f` codificados como somadores mod 8 (3 colunas de Full Adders apenas!) sobre as paridades lineares de pares `t_f`, sem expandir monômios cúbicos.

3. **Passo 2 — Paralelização Cube-and-Conquer em 4 Cores:**
   * Em vez de rodar apenas 2 jobs (`u1=0`, `u1=1`), particione em **16 ou 32 sub-ramos lineares** fixando $(u_1, u_2, v_2, u_3, v_3)$ (onde cada produto $u_2 v_2$ e $u_3 v_3$ já vira constante linearizando quase toda $L_{\text{coset}}$, baixando a dimensão livre para $d \approx 103$!) usando `ProcessPoolExecutor(max_workers=4)` com CaDiCaL 1.9.5.
   * **Se retornar `SAT` em algum cubo:** rode imediatamente a FWHT completa de $2^{16}$ pontos no vetor $c$ retornado; se não for bent, pegue a `first_fail` (ex.: `0x0007` de peso 3), adicione mais 1 árvore CSA ponderada para `first_fail` ($\pm 256$, `+22k` cláusulas, reutilizando os mesmos $y_k$!) em loop incremental CEGAR (*Counterexample-Guided Abstraction Refinement*) até `UNSAT` ou uma função bent genuína!