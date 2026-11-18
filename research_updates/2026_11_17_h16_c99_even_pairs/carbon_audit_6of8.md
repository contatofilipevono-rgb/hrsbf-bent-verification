### Veredito Executivo da Auditoria

1. **Afirmação de cobertura dos subconjuntos de tamanho $\le 6$:** **Ainda NÃO está rigorosamente provada em 100%.** Com as **8 testemunhas C7-válidas auditadas** em mãos (`0xbf`, `0xef` e as 6 testemunhas de pares pares `0x5f`, `0x77`, `0xd7`, `0x7d`, `0xdd`, `0xf5`), estão rigorosamente cobertos **19 dos 28** subconjuntos de tamanho 6 (**67,9%**), **52 dos 56** de tamanho 5, e **100%** dos de tamanho $\le 4$. Faltam exatamente **9 subconjuntos de tamanho 6** (e 4 de tamanho 5), todos dependentes da existência de testemunhas C7-válidas no ramo $c_{99}=1$ para **`0xfe` (falta $d=1$)** e **`0xfb` (falta $d=3$)**.
2. **Correção pontual de rótulo no enunciado:** Na máscara `0xef` (`11101111₂`), o bit desligado é o bit 4, logo **falta $d=5$** (e não $d=7$). Isso é consistente com $i \mapsto 3i \bmod 16$, pois $3 \times 7 = 21 \equiv 5 \pmod{16}$.
3. **Não-invariância automática de $c_{99}=1$ e $C_1 \dots C_7$:** A permutação multiplicativa $\pi_m(i) = m i \bmod 16$ ($m \in \mathbb{Z}_{16}^\times$) **não preserva algebricamente** nem a condição de ramo $c_{99}=1$ nem o certificado `T28_SEXTA_CERTIFICADO.json`. O sucesso de `perm3` em `0xbf`, `0x5f` e `0xf5` foi uma propriedade empírica dessas testemunhas específicas (alta densidade de bits `1` nas órbitas pré-imagem), não um teorema de invariância de grupo.

---

### 1. Verificação Rigorosa de Cobertura ($\binom{8}{6} = 28$) e Ação de $\mathbb{Z}_{16}^\times$

#### 1.1. Convenção de bits e consistência aritmética das testemunhas
Os dados auditados fixam de forma unívoca o mapeamento $\text{bit } b \in \{0,\dots,7\} \leftrightarrow \text{distância cíclica } d = b+1 \in \{1,\dots,8\}$. Como as distâncias $d \in \{1,\dots,7\}$ têm órbitas de tamanho $16$ e a distância antipodal $d=8$ ($e_i + e_{i+8}$) tem órbita curta de tamanho $8$ ($7 \times 16 + 8 = 120 = \binom{16}{2}$), todas as contagens de peso 2 batem exatamente:
* `0x55` (`01010101₂`) $= \{1,3,5,7\}$ ($64$ vetores).
* `0x5f` ($\{2,4\}$), `0x7d` ($\{4,6\}$), `0x77` ($\{2,6\}$): $64 + 16 + 16 = \mathbf{96/120}$.
* `0xdd` ($\{4,8\}$), `0xf5` ($\{6,8\}$), `0xd7` ($\{2,8\}$): $64 + 16 + 8 = \mathbf{88/120}$.
* `0xbf` ($D \setminus \{7\}$) e `0xef` ($D \setminus \{5\}$): $6 \times 16 + 8 = \mathbf{104/120}$ (e ambas as strings hexadecimais de 116 bits têm exatamente o mesmo peso de Hamming total $k=94$, assim como `0x5f` e `0x7d` têm $k=87$ com $k_{\text{long}}=86$).

#### 1.2. Auditoria exaustiva dos $\binom{8}{6} = 28$ subconjuntos de tamanho 6
Indexando cada subconjunto $T \subset D = \{1,2,3,4,5,6,7,8\}$ de tamanho 6 pelo seu **par de distâncias omitidas** $D \setminus T = \{a,b\}$ ($\binom{8}{2} = 28$ pares):

1. **Grupo I — Omitem 2 distâncias pares ($\binom{4}{2} = 6$ subconjuntos): PROVADOS (6/6)**
   Cobertos exatamente pelas 6 testemunhas auditadas em `0x55 + C7`:
   * `0x5f` ($D \setminus \{6,8\}$), `0x77` ($D \setminus \{4,8\}$), `0xd7` ($D \setminus \{4,6\}$), `0x7d` ($D \setminus \{2,8\}$), `0xdd` ($D \setminus \{2,6\}$), `0xf5` ($D \setminus \{2,4\}$).

2. **Grupo II — Omitem $d=7$ e mais uma distância ($7$ subconjuntos): PROVADOS (7/7)**
   Todos são subconjuntos diretos da testemunha auditada de tamanho 7 **`0xbf`** ($D \setminus \{7\}$):
   * `0xbe` ($D \setminus \{1,7\}$), `0xbd` ($D \setminus \{2,7\}$), `0xbb` ($D \setminus \{3,7\}$), `0xb7` ($D \setminus \{4,7\}$), `0xaf` ($D \setminus \{5,7\}$), `0x9f` ($D \setminus \{6,7\}$), `0x3f` ($D \setminus \{7,8\}$).

3. **Grupo III — Omitem $d=5$ e $x \neq 7$ ($6$ subconjuntos novos): PROVADOS (6/6)**
   Todos são subconjuntos diretos da testemunha auditada de tamanho 7 **`0xef`** ($D \setminus \{5\}$):
   * `0xee` ($D \setminus \{1,5\}$), `0xed` ($D \setminus \{2,5\}$), `0xeb` ($D \setminus \{3,5\}$), `0xe7` ($D \setminus \{4,5\}$), `0xcf` ($D \setminus \{5,6\}$), `0x6f` ($D \setminus \{5,8\}$).

4. **Grupo IV — Par omitido em $\{1,3\} \times \{1,2,3,4,6,8\}$ com pelo menos um elemento em $\{1,3\}$ ($9$ subconjuntos): NÃO PROVADOS (0/9)**
   Nenhum destes 9 subconjuntos está contido em `0xbf` (pois todos contêm $7$), nem em `0xef` (pois todos contêm $5$), nem nas 6 testemunhas de pares pares (pois todos contêm **3 ou 4** distâncias pares, enquanto cada testemunha de `0x55` cobre apenas 2 pares):
   * **Omitindo $\{1,3\}$ (1 subconjunto):** `0xfa` ($D \setminus \{1,3\} = \{2,4,5,6,7,8\}$).
   * **Omitindo $d=1$ e uma par (4 subconjuntos):** `0xfc` ($D \setminus \{1,2\}$), `0xf6` ($D \setminus \{1,4\}$), `0xde` ($D \setminus \{1,6\}$), `0x7e` ($D \setminus \{1,8\}$).
   * **Omitindo $d=3$ e uma par (4 subconjuntos):** `0xf9` ($D \setminus \{2,3\}$), `0xf3` ($D \setminus \{3,4\}$), `0xdb` ($D \setminus \{3,6\}$), `0x7b` ($D \setminus \{3,8\}$).

*(Nota adicional sobre tamanhos $<6$: pelo Princípio da Casa dos Pombos, todo subconjunto de tamanho $\le 4$ que contenha $\{5,7\}$ omite ao menos 2 elementos de $\{2,4,6,8\}$, logo **100% dos tamanhos $\le 4$ já estão provados**; no tamanho 5, **52 de 56** estão provados e faltam apenas os 4 subconjuntos $D \setminus \{1,3,e\}$ para $e \in \{2,4,6,8\}$: `0xf8`, `0xf2`, `0xda`, `0x7a`.)*

Soma de controle: $6 + 7 + 6 + 9 = \mathbf{28}$.

#### 1.3. Por que $\pi_m: i \mapsto m i \bmod 16$ NÃO prova os 9 restantes sem auditoria direta
Para $m \in \mathbb{Z}_{16}^\times = \{1,3,5,7,9,11,13,15\}$:
* **O que é algebricamente invariante para todo $m$ ímpar:**
  1. **Simetria rotacional e grau 4 homogêneo:** como $\mathbb{Z}_{16} \triangleleft \mathrm{AGL}(1,16)$, vale $T_1 \circ \pi_m = \pi_m \circ T_{m^{-1}}$, preservando $H_{16}^{(4)}$.
  2. **Partição de tamanhos de órbita ($k_{\text{long}}$ e $6 \le k \le 106$):** a única órbita de tamanho 4 ($\{0,4,8,12\}$), as 3 de tamanho 8 e as 112 longas de tamanho 16 são permutadas dentro de cada classe.
  3. **$W_f(0)$ e $W_f(e_0)$:** como $\pi_m(0)=0$, a permutação dual fixa $0$ e $e_0$.
  4. **Ação de $\mathbb{Z}_{16}^\times / \{\pm 1\} \cong \langle \bar{3} \rangle \cong C_4$ nas distâncias:** a reflexão $m=15$ ($i \mapsto -i$) age trivialmente nas 8 distâncias; o gerador $\bar{3} = \{3,13\}$ induz o **4-ciclo $(7 \to 5 \to 1 \to 3 \to 7)$** nas distâncias ímpares e a permutação **$(2\;6)(4)(8)$** nas pares (explicando exatamente `0x5f` $\leftrightarrow$ `0x7d`, `0xf5` $\leftrightarrow$ `0xd7`, e por que `0xdd` e `0x77` são fixos).

* **O que NÃO é invariante sob $m \notin \{1,15\}$:**
  1. **O ramo $c_{99} = 1$:** Em binário, $99 = \text{0x0063}$ representa a órbita longa de $S_{99} = \{0,1,5,6\}$. Sob o quociente $C_4 = \{\bar{1}, \bar{3}, \bar{9}, \bar{11}\}$, $S_{99}$ percorre **quatro órbitas longas distintas**:
     * $m \in \{1, 15\}$: $\{0,1,5,6\} \mapsto$ representante canônico **$99$** (`0x0063`);
     * $m \in \{3, 13\}$: $3\cdot\{0,1,5,6\} \equiv \{15,0,2,3\} \xrightarrow{+1} \{0,1,3,4\} \mapsto$ representante **$27$** (`0x001b`);
     * $m \in \{9, 7\}$: $9\cdot\{0,1,5,6\} \equiv \{0,6,9,13\} \xrightarrow{+10} \{0,3,7,10\} \mapsto$ representante **$1161$** (`0x0489`);
     * $m \in \{11, 5\}$: $11\cdot\{0,1,5,6\} \equiv \{0,2,7,11\} \mapsto$ representante **$2181$** (`0x0885`).
     Portanto, $\pi_m(f)$ só permanece no ramo $c_{99}=1$ se a testemunha original $f$ já tiver igual a `1` o coeficiente pré-imagem correspondente em $\{c_{27}, c_{1161}, c_{2181}\}$.
  2. **As restrições $C_1 \dots C_7$:** Como `T28_SEXTA_CERTIFICADO.json` foi construído ancorado na quebra de simetria $c_{99}=1$, $\pi_m$ não preserva o sistema de cláusulas $C_1 \dots C_7$; `perm3` deu `True` em `0xbf`, `0x5f` e `0xf5` apenas porque essas soluções específicas satisfaziam simultaneamente $C_1 \dots C_7$ e $\pi_3^{-1}(C_1 \dots C_7)$.

* **Ação imediata para fechar 28/28:** Basta aplicar `perm3` mais uma e duas vezes sobre `0xef` (testando $m \in \{9,7\}$ sobre `0xbf` para gerar candidatos a **`0xfe`** [falta $d=1$], e $m \in \{11,5\}$ sobre `0xbf` para gerar candidatos a **`0xfb`** [falta $d=3$]) e rodar o verificador `c_99 == 1` + `C1..C7`. Se **`0xfe`** e **`0xfb`** passarem (mesmo por reflexão $16-m$ caso uma falhe), os 9 subconjuntos restantes de tamanho 6 (e os 4 de tamanho 5) ficam **100% fechados** instantaneamente.

---

### 2. Significado Estrutural de `0x7` como Primeira Falha e a Barreira Seguinte

#### 2.1. Por que `0x7` aparece em `0x5f`, `0xd7` e `0x77` (enquanto `0x5` aparece em `0x7d` e `0xf5`)
Há duas camadas — uma de **ordenação de varredura** (que permite inclusive deduzir valores ocultos de peso 2) e uma de **acoplamento espectral profundo**:

1. **Ordem lexicográfica inteira ($u = 0, 1, \dots, 65535$) e dedução forense via `perm3`:**
   Na varredura sequencial do FWHT:
   * $u=0$ (peso 0) e $u=1,2,4$ (peso 1, órbita de $e_0$) passam;
   * $u=3,6$ ($e_0+e_1$ e $e_1+e_2$, $d=1$) passam sempre devido a `0x55`;
   * $u=5$ (`0x5` $= e_0+e_2$, $d=2$): nas máscaras onde $d=2$ falha (`0x7d` e `0xf5`), a varredura **obrigatoriamente** estoura em `0x5`. Nas máscaras onde $d=2$ passa (`0x5f`, `0xd7`, `0x77`), todos os índices $u \in \{0,\dots,6\}$ passam, e **$u=7$ (`0x7` $= e_0+e_1+e_2$, peso 3)** é o menor inteiro seguinte — ocorrendo *antes* dos representantes das distâncias pares restantes $d=4$ ($u=17$, `0x11`), $d=6$ ($u=65$, `0x41`) e $d=8$ ($u=257$, `0x101`).
   * **Consequência forense exata:** Como `0xd7 = perm3(0xf5)` e `0x7d = perm3(0x5f)` trocam $d=2 \leftrightarrow d=6$, sabemos sem precisar recalcular o FWHT que em `0xd7` a distância $d=6$ ($u=65$) falha com **$W_f(\text{0x41}) = 704$**, e em `0x5f` falha com **$W_f(\text{0x41}) = 0$**. A falha `0x7` foi reportada primeiro simplesmente porque $7 < 65$.

2. **Significado estrutural real de $W_f(\text{0x7}) \in \{-128, 0\}$:**
   * **Compensação energética de Parseval:** Como $\frac{1}{2^{16}}\sum_{u} W_f(u)^2 = 256^2$, desvios super-bent nas distâncias pares omitidas (como $|W_f|=704$ em `0xf5`/`0xd7`, onde $704^2 = 7{,}5625 \times 256^2$) drenam energia espectral e **forçam valores sub-bent** ($0, \pm 128$, quantizados em múltiplos de $32/64/128$ por Ax–Katz em grau 4) nas **35 órbitas longas de peso 3** ($\binom{16}{3}/16 = 35$), que não estavam penalizadas na busca.
   * **Trava do subcubo 3D $V_3 = \mathrm{span}(e_0, e_1, e_2) = \{0,\dots,7\}$:** Por inversão de Fourier no subespaço $V_3$, para cada $a \in \mathbb{F}_2^3$:
     $$\sum_{u=0}^{7} (-1)^{a \cdot u} W_f(u) = 8 \sum_{\substack{x \in \mathbb{F}_2^{16} \\ (x_0,x_1,x_2)=a}} (-1)^{f(x)}.$$
     Quando $u=0..6$ estão planos em $\pm 256$ ($W_f(0)=256 s_0$, $W_f(e_i)=256$, $W_f(d=1)=256 s_1$, $W_f(d=2)=256 s_2$ com $s_r \in \{\pm 1\}$), a soma normalizada dos 7 primeiros termos é
     $$\frac{1}{256}\sum_{u=0}^{6} W_f(u) = s_0 + 3 + 2s_1 + s_2 \equiv 1 \pmod 2 \quad (\text{sempre ímpar}).$$
     Para que $|W_f(\text{0x7})|$ também seja $256$, os 8 sinais em $V_3$ precisam formar uma função booleana de 3 variáveis (restrição da dual $\tilde{f}$ ao triângulo de distâncias $(1,1,2)$) cujo espectro de Walsh em $\mathbb{F}_2^3$ coincida simultaneamente com os 8 vieses das subfunções de grau $\le 4$ em 13 variáveis $f|_{(x_0,x_1,x_2)=a}$.

---

#### 2.2. Qual é a próxima barreira estrutural após 6 de 8 distâncias de peso 2?

Os dados revelam uma **assimetria estrutural decisiva** que define as duas próximas barreiras na ordem exata de ataque:

1. **Barreira Imediata — O bloqueio diádico `0x55` + 3 pares (7/8 omitindo uma distância par) e `0xff` (8/8 = 120/120):**
   Observe o contraste nos seus resultados:
   * **Fora de `0x55`** (omitindo 1 distância ímpar), o nível **7 de 8 já foi vencido**: `0xbf` e `0xef` já satisfazem **todas as 4 distâncias pares $\{2,4,6,8\}$ simultaneamente** (`104/120` vetores).
   * **Dentro de `0x55 + C7`** (exigindo todas as 4 distâncias ímpares $\{1,3,5,7\}$), $4{,}4 \times 10^8$ avaliações estagnaram em **exatamente 2 de 4 distâncias pares**, sem produzir **nenhuma** testemunha 7/8 que omita uma distância par:
     * **`0x7f`** (falta apenas $d=8$, a órbita antipodal curta: **112/120** vetores de peso 2 — fixa por $\mathbb{Z}_{16}^\times$);
     * **`0xf7`** (falta apenas $d=4$: 104/120 — fixa por $\mathbb{Z}_{16}^\times$);
     * **`0xdf` $\leftrightarrow$ `0xfd`** (falta $d=6$ ou $d=2$: 104/120 — par sob `perm3`);
     * e o fechamento completo de peso 2, **`0xff`** (**8/8 distâncias, 120/120 vetores**).
   Isso indica uma **tensão de paridade/congruência diádica** entre a soma espectral fixada no coset ímpar (`0x55`) e as derivadas direcionais de segunda ordem associadas à cadeia 2-ádica de $\mathbb{Z}_{16}$ ($d=8$, $d=4$ e $\{2,6\}$). Atingir `0x7f` (112/120) e `0xff` (120/120) dentro de $C_1 \dots C_7$ é o gargalo imediato genuíno.

2. **Barreira Seguinte Pós-`0xff` — As 35 órbitas de peso 3 (acoplamento triangular de $\tilde{f}$):**
   Mesmo que `0xff` seja atingido, $W_f(0)$, peso 1 e peso 2 cobrem apenas $1 + 16 + 120 = \mathbf{137}$ entradas de $65.536$ (**0,21%** do espectro). A barreira seguinte é estender a planicidade $|W_f(u)|=256$ para as **35 órbitas longas de peso 3** (560 entradas, começando por `0x7`), onde cada órbita $\{i,j,k\}$ impõe uma equação de compatibilidade de subcubo 3D acoplando os sinais de peso 2 do triângulo $(d(i,j), d(j,k), d(i,k))$ à distribuição de pesos das restrições de $f$ em $\mathbb{F}_2^{13}$.