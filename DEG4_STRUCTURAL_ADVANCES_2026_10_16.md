# Avanços Estruturais em Grau 4 (Stănică–Maitra): Certificado Mínimo ($n=12$), Família $n=4p^r$, $n=16$ e $n=20$

**Data:** 16 de outubro de 2026  
**Verificador CPU Rápido:** [`verify_deg4_structural_advances.py`](verify_deg4_structural_advances.py)  
**Motor Híbrido GPU (A100) + CPU:** [`a100_deg4_mission.py`](a100_deg4_mission.py) | [`RUN_A100_DEG4_MISSION.ipynb`](RUN_A100_DEG4_MISSION.ipynb)  
**Extensões Formais Lean 4:** [`formal/StanicaMaitraDeg4_v3_extensions.lean`](formal/StanicaMaitraDeg4_v3_extensions.lean)  
**Certificado JSON:** [`results/deg4_structural_advances.json`](results/deg4_structural_advances.json)

---

## 1. Teorema da Dicotomia Espectral Bi-Antipodal na Família Infinita $n = 4p^r$

Seja $n = 4p^r$ ($h = 2p^r$, $p \ge 3$ primo ímpar, $r \ge 1$) e seja $g_0(u) = f(u, u) = \sum_{d=1}^{p^r} c_d Q_d(u)$ a restrição diagonal de $f \in \mathcal{H}_n$, onde:
$$Q_d(u) = \sum_{i=0}^{2p^r-1} u_i u_{i+d} \quad (1 \le d \le p^r - 1), \qquad Q_{p^r}(u) = \sum_{i=0}^{p^r-1} u_i u_{i+p^r}.$$

Mudando coordenadas em $\mathbb{F}_2^h = \mathbb{F}_2^{p^r} \times \mathbb{F}_2^{p^r}$ para $(x, x \oplus v)$ com $x, v \in \mathbb{F}_2^{p^r}$, todos os termos quadráticos $x_i x_{i+d}$ cancelam em $Q_d(x, x \oplus v)$ para $1 \le d \le p^r - 1$, resultando na forma afim em $x$:
$$g_0(x, x \oplus v) = \left\langle x,\; M_0(v) \oplus c_{p^r}(v \oplus 1_{p^r}) \right\rangle \oplus q_{\text{rem}}(v), \qquad M_0 = \sum_{d=1}^{p^r-1} c_d \left(R_{p^r}^d \oplus R_{p^r}^{-d}\right).$$

Somando inicialmente sobre $x \in \mathbb{F}_2^{p^r}$, obtém-se a **Dicotomia Espectral Bi-Antipodal** para todo $n = 4p^r$:
1. **Ramo $c_{p^r} = 0$ e $\bigoplus_{d \text{ par}} c_d = 0$ ($2^{p^r-2}$ setores, 25%):** A translação $v \mapsto v \oplus 1_{p^r}$ em $\ker(M_0)$ preserva $g_0$ e inverte $\langle 1_h, u\rangle = \langle 1_{p^r}, v\rangle$ (pois $p^r$ é ímpar), implicando identicamente **$W_{g_0}(1_h) = 0$**.
2. **Ramo $c_{p^r} = 0$ e $\bigoplus_{d \text{ par}} c_d = 1$ ($2^{p^r-2}$ setores, 25%):** A translação $v \mapsto v \oplus 1_{p^r}$ inverte $g_0$ e preserva $\langle z_2, u\rangle$, implicando identicamente **$A_0 = W_{g_0}(z_2) = 0$** e $\lvert W_{g_0}(1_h)\rvert = 2^{p^r + 1 + m_0}$, onde $2m_0 = \dim(\ker M_0 / \langle 1_{p^r}\rangle)$ é par (módulos circulantes autodualizados sobre $\mathbb{F}_2[C_{p^r}]$).
3. **Ramo $c_{p^r} = 1$ ($2^{p^r-1}$ setores, 50%):** Como $(M_0 \oplus I_{p^r})(1_{p^r}) = 1_{p^r} \ne 0$, tem-se $1_{p^r} \notin \ker(M_0 \oplus I_{p^r})$, logo $\dim\ker(M_0 \oplus I_{p^r}) = 2m_1$ é par e **$\lvert A_0\rvert = \lvert W_{g_0}(1_h)\rvert = \lvert W_{g_0}(z_2)\rvert = 2^{p^r + m_1}$** (valoração 2-ádica de paridade oposta ao caso $c_{p^r}=0$ para $m_0 = m_1 = 0$).

---

## 2. Certificado Mínimo e Cadeia Matroidal Ótima em $n = 12$

1. **Redundância de 20 dos 24 Subespaços de Poisson:**
   - A ablação exata demonstra que nos Estágios 1 a 4 apenas **4 subespaços canônicos** (`V2_21`, `V1_9`, `V3`, `V4`) são necessários para obter os mesmos contadores (`712 -> 361 -> 20.158 -> 212.296 -> 8.688`), sendo os 12 subespaços auxiliares (`V1_63, V1_21, V1_27, V2_27, V2_9a, V2_9b, V1_7, V2_7a..d, V3_7a`) 100% redundantes.
   - Nos Estágios 5 a 9d (`z = 1, 11, 13, 31, 3, 5, 15, 23`), **todos os 8 filtros de Poisson (`V1_1` a `V1_23`) são 100% redundantes**: apenas os limites de energia diagonal $\sum_z W_z(b)^2 \le 4096$ e as congruências residuais em $b \in \{0, 21, 63\}$ reproduzem os mesmos contadores (`26.496 -> 94.936 -> 149.448 -> 106.552 -> 349.680 -> 23.636 -> 128 -> 0`).
2. **Unicidade da Cadeia Matroidal Ótima e Redução de 57,3% no Pico:**
   - Avaliando os postos de todos os $2^8 = 256$ subconjuntos das 8 órbitas finais após $V_4$ (posto 27), a sequência que permuta $O_5 \leftrightarrow O_3$ (`[1, 11, 13, 31, 5, 3, 15, 23]`) atinge o **posto cumulativo mínimo único** em cada etapa ($31 \to 34 \to 36 \to 37 \to 40 \to 41 \to 42 \to 43$), reduzindo o pico de sobreviventes de **`349.680`** para **`149.448`**.

---

## 3. Novos Setores Eliminados e Obstruções Hiperplanas em $n = 20$ ($h = 10, p = 5$)

1. **Postos de Fibras Curtas e 8 Sizígias Cruzadas em $V_2 = \{0, 341, 682, 1023\}$:**
   - $\operatorname{rk}(g_0) = 5$, $\operatorname{rk}(g_{1023}) = 13$, $\operatorname{rk}(g_{341}) = 22$, e posto conjunto $\operatorname{rk}(g_0, g_{1023}, g_{341}) = 32$ ($\Delta\text{rk} = 5, 13, 14$, revelando **8 sizígias lineares cruzadas**).
2. **Operadores de Quarto de Período $T_z(u) = R_{10}^5(u) \oplus \tau_5(z)$ nas 6 Órbitas de Tamanho 5:**
   - Para $z \in \{33, 99, 165, 231, 363, 495\}$ (postos `41, 41, 41, 42, 42, 41`), todos os 245 geradores são pares nas 256 órbitas de tamanho 4 de $T_z$, garantindo **$32 \mid A_z$** e **$32 \mid W_z(1023)$** (com $W_z(1023) = 0$ para $z \in \{33, 231, 363\}$).
3. **Eliminação Analítica de 24 dos 32 Setores Bi-Antipodais (75% de $2^{245}$):**
   - Em $b = 1023$, $W_{1023}(1023) = W_{341}(1023) = W_{682}(1023) = 0$, órbitas de tamanho 10 contribuem múltiplos de $10 \cdot 16^2 = 2560$, e órbitas de tamanho 5 contribuem múltiplos de $5 \cdot 32^2 = 5120 \equiv 0 \pmod{2560}$. Logo:
     $$W_0(1023)^2 \equiv 2^{20} = 1.048.576 \equiv 1536 \pmod{2560} \iff c_{244} = 0 \;\;\text{e}\;\; c_{186} \oplus c_{242} = 1 \pmod 2.$$
   - Isso elimina **todos os 16 setores com $c_{244} = 1$** mais 8 setores com $c_{244} = 0$, restando **8 de 32 setores (75% eliminado)**, todos com **$A_0 = 0$ e $W_0(341) = 0$**.
4. **Identidades Universais $\mathbb{Z}/4\mathbb{Z}$ e Obstrução Hiperplana em $z = 341$:**
   - Em $z = 1023$: $\sum_{i=1}^{51} v_i + v_{52} \equiv 0 \pmod 4$ em todas as $2^{13} = 8.192$ funções, implicando $32 \mid A_{1023}$ e $A_{1023}^2 \equiv 1536 \pmod{2560}$ identicamente.
   - Em $z = 341$: $K + v_a + v_b \equiv 0 \pmod 4$ nas $2^{22} = 4.194.304$ funções (onde $K$ soma as 102 órbitas de tamanho 10 e $v_a, v_b$ são as 2 órbitas de tamanho 2). A condição necessária **$160 \mid A_{341}$** e $W_{341}(682)^2 \equiv 256 \pmod{1280}$ equivale ao **hiperplano $\mathbb{F}_2$-linear $v_a \oplus v_b = 1$** (suportado em 152 geradores explícitos) junto a $K \equiv 3 \pmod 8$, reduzindo $4.194.304 \to 1.114.112$ funções (**73,44% eliminado**).

---

## 4. Setores Eliminados e Peneira Espectral em $n = 16$ ($h = 8, \dim\mathcal{H}_{16} = 116$)

- **Postos em $V_2 = \{0, 85, 170, 255\}$:** $\operatorname{rk}(g_0) = 4$, $\operatorname{rk}(g_{255}) = 8$, $\operatorname{rk}(g_{85}) = 14$, posto conjunto **21** (5 sizígias cruzadas).
- **Eliminação de 12 dos 16 setores (75% de $2^{116}$):** Como $64 \mid A_{255}, A_{85}$, $W_{255}(255) = W_{85}(255) = 0$, e $32 \mid A_z, W_z(255)$ para $z \in \{17, 51, 119\}$, Parseval em $b = 0, 255 \pmod{2048}$ força **$64 \mid A_0$ e $64 \mid W_0(255)$**, deixando apenas os **4 setores** com $c_{115} = 0$ e $c_{57} \oplus c_{113} = 0$.
- **Peneira em $V_1(255)$ e $V_2$:** Reduz $4.096 \to 864$ classes no posto 12 ($78,91\%$ eliminado) e $2.097.152 \to 391.804$ classes em T11 ($81,32\%$ eliminado).

---

## 5. Síntese Pós-A100 (T0–T13) e Demonstrações Analíticas v4 ([`verify_t11_t13_and_v4_advances.py`](verify_t11_t13_and_v4_advances.py))

### 5.1. Caracterização Analítica Exata das 6.144 Exceções em $n = 20$ (`T12_affine_exceptions.npz`)
Na enumeração integral dos $2^{30} = 1.073.741.824$ estados da imagem de posto 32 sobre $V_2 = \{0, 341, 682, 1023\}$ após impor $c_{244} = 0$ e $c_{186} \oplus c_{242} = 1$, a A100 identificou que os sobreviventes formam o hiperplano $\tau(f) = 0$ ($2^{29} = 536.870.912$ estados) menos **6.144 exceções**, resultando em $536.864.768$ sobreviventes ($1.835.011 / 2.097.152 = 87,500143\%$ de exclusão). Demonstramos analiticamente (e verificamos bit-a-bit na CPU em $1,65\text{ s}$) que:
- **Redundância de todas as 1.023 frequências $b \ne 0$:** Pelo Teorema Chinês dos Restos entre a divisibilidade 2-ádica ($8 \mid L_g(b)$) e a ação de $R_{20}^4$ de ordem 5 ($L_g(b) \equiv W_h(y(b,g)) \pmod{10}$), todo estado em $\tau(f) = 0$ satisfaz automaticamente $L_g(b) \equiv W_h(y(b,g)) + 20 \pmod{40}$, tornando todas as frequências $b \ne 0$ redundantes em $\tau(f) = 0$.
- **Caracterização pela Desigualdade Triangular de Poisson em $b = 0$:** As **6.144 exceções** são **identicamente** os estados de $\tau(f) = 0$ que violam a cota $L_\infty$ de Poisson em $b = 0$:
  $$\lvert A_0 \pm 2 A_{341} + A_{1023}\rvert \le 1024 \iff 2\lvert A_{341}\rvert + \lvert A_{1023}\rvert \le 1024.$$
- **Decomposição Exata ($3.072 + 3.072 = 6.144$):** A projeção conjunta $(g_{341}, g_{1023})$ tem posto $27$ ($22 + 13 - 8$ sizígias cruzadas), de modo que cada estado de $g_{341}$ admite $2^5 = 32$ estados compatíveis de $g_{1023}$ e $2^3 = 8$ setores de $g_0$. Entre os $2^{21}$ estados de $g_{341}$ em $\tau(f)=0$, apenas $60$ possuem $\lvert A_{341}\rvert \ge 480$:
  1. **12 estados** com $A_{341} = \pm 640$: todos os $32$ estados compatíveis de $g_{1023}$ têm $A_{1023} = \pm 64$, dando $2(640)+64 = 1344 > 1024$ e gerando $12 \times 32 \times 8 = \mathbf{3.072}$ exceções;
  2. **48 estados** com $A_{341} = \pm 480$: exatamente $8$ dos $32$ estados compatíveis de $g_{1023}$ têm $A_{1023} = \pm 256$, dando $2(480)+256 = 1216 > 1024$ e gerando $48 \times 8 \times 8 = \mathbf{3.072}$ exceções.

### 5.2. Extensão do Lema de Redução ao Período 4 para Potências de Primos $n = 4p^r$ ($p \ge 5$ primo, $r \ge 1$)
- Sob a ação do grupo cíclico $G = \langle R_n^4 \rangle \cong C_{p^r}$ de ordem $p^r$ em $\mathbb{F}_2^{4p^r}$, toda órbita não fixa tem cardinalidade $p^k$ ($1 \le k \le r$), logo **múltipla de $p$**. Como $p^r$ é ímpar e $2^{2p^r} \equiv 4 \pmod p$ por Fermat para todo $r \ge 1$, vale para todo vetor de período 4 $a = (b, \dots, b)$:
  $$W_f(b, \dots, b) \equiv W_h(b) \pmod p, \qquad h(y) = f(y, \dots, y) : \mathbb{F}_2^4 \to \mathbb{F}_2.$$
- Para todo primo $p \ge 5$, $0, \pm 2 \not\equiv \pm 4 \pmod p$, logo $\lvert W_h(b)\rvert \ge 4$ para todo $b \in \mathbb{F}_2^4$; por Parseval em 4 variáveis ($\sum_b W_h(b)^2 = 256 = 16 \cdot 4^2$), segue $\lvert W_h(b)\rvert = 4$ ($h$ é bent) **e** o sinal dual fica travado nos 16 pontos de período 4: $f^*(y, \dots, y) = h^*(y)$.
- Como toda órbita quártica em $\mathcal{H}_{4p^r}$ tem tamanho em $\{4p^r, 2p^r, p^r\}$ com $p^r$ ímpar e $2p^r \equiv 2 \pmod 4$, as três condições lineares independentes:
  $$c_{p^r} = 0, \qquad \bigoplus_{\substack{1 \le d < p^r \\ d \text{ par}}} c_d = 1, \qquad \tau(f) = 0 \quad \left(\lvert\operatorname{supp}(\tau)\rvert = \frac{3(p^r - 1)}{2}p^{2r}\right)$$
  excluem exatamente **$7/8$ ($87,5\%$) de $\mathcal{H}_{4p^r}$ para todo primo $p \ge 5$ e todo $r \ge 1$** (verificado exaustivamente até $p^r = 25, n = 100$ com $39.225$ geradores).

### 5.3. Teorema Universal de Grau $\le 3$ e Divisibilidade de Stickelberger–McEliece nas Fibras $g_z$
- Para todo $n = 2h$ par e toda $f \in \mathcal{H}_{2h}$, o pareamento pela involução $R_{2h}^h$ cancela identicamente todos os monômios de grau 4 em $u$ na restrição $g_z(u) = f(u, u \oplus z)$, provando que **$\deg(g_z) \le 3$ incondicionalmente para todo $z \in \mathbb{F}_2^h$**.
- Para todo $z \ne 0$, como $g_z(u \oplus z) = g_z(u)$, $g_z \oplus \langle b, u\rangle$ (quando $\langle b, z\rangle = 0$) fatora por $\mathbb{F}_2^h / \langle z\rangle \cong \mathbb{F}_2^{h-1}$ com grau $\le 3$. Pelo teorema de Ax–Katz / Stickelberger–McEliece, segue incondicionalmente:
  $$2^{\lceil (h-1)/3 \rceil + 1} \;\Big|\; W_{g_z}(b) \qquad \forall f \in \mathcal{H}_{2h}, \;\forall z \in \mathbb{F}_2^h \setminus \{0\}, \;\forall b \in \mathbb{F}_2^h,$$
  garantindo $16 \mid W_{g_z}(b)$ em $n = 16, 20$, $32 \mid W_{g_z}(b)$ em $n = 24$, e $64 \mid W_{g_z}(b)$ em $n = 28$.

### 5.4. Próxima Etapa Concreta em $n = 20$: Filtração sobre as 6 Órbitas de Período 5
- Cada órbita de tamanho 5 em $z \in \{33, 99, 165, 231, 363, 495\}$ adiciona **posto zero** além do seu representante único (pois $g_{R_{10}(z)}(u) = g_z(R_{10}^{-1}(u \oplus \tau_1(z)))$).
- A cadeia gulosa de incremento mínimo de posto sobre $V_2$ (posto 32) é:
  $$32 \xrightarrow{+z_{33}\;(+29)} 61 \xrightarrow{+z_{231}\;(+16)} 77 \xrightarrow{+z_{363}\;(+4)} 81 \xrightarrow{+z_{99}\;(+15)} 96 \xrightarrow{+z_{165}\;(+5)} 101 \xrightarrow{+z_{495}\;(+0)} 101,$$
  onde $z = 363$ adiciona apenas $+4$ parâmetros, $z = 165$ adiciona $+5$, e $z = 495$ é **100% determinado linearmente** ($\Delta\operatorname{rk} = 0$) pelas fibras anteriores.

