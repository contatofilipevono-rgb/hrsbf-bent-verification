Aqui está a análise algébrica exata da Etapa A no ramo $c_{99} = 1$, seguida pela arquitetura do pipeline simbólico/SAT para decidir a existência de sobreviventes bent em $H(16,4)$ sem enumeração cega.

---

### Parte 1: Relação Algébrica Exata entre $Q_4$ e $Q_{\text{0x0}} \oplus Q_{\text{0xf}}$

#### 1.1. Decomposição dos conjuntos de índices e decodificação dos 196 monômios
Sejam $P_1, P_2, P_3, P_4$ os quatro produtos bilineares $8 \times 8$ da fatoração de $Q_4$ (T28), onde cada par $(I_r, J_r)$ representa a soma das variáveis em $I_r$ multiplicada pela soma das variáveis em $J_r$:
* **$P_1$ (Bloco 1, 16 vars):** $I_1 = \{0,4,8,18,42,52,56,94\}$, $J_1 = \{14,22,46,71,81,85,98,106\}$.
* **$P_2$ (Bloco 2, 16 vars):** $I_2 = \{1,9,15,28,53,67,76,103\}$, $J_2 = \{3,11,34,45,55,69,78,89\}$.
* **$P_3$ (Bloco 3, 16 vars):** $I_3 = \{2,10,25,37,54,68,83,104\}$, $J_3 = \{12,20,29,33,41,48,96,110\}$. (Note que $I_3 \cup J_3 = M$ de T31).
* **$P_4$ (Bloco 4, 16 vars):** $I_4 = \{13,21,38,70,74,93,97,109\}$, $J_4 = \{24,32,47,72,80,86,91,107\}$.

Observe também que o conjunto $K$ da 5ª condição ($|K|=32$) é **exatamente a união disjunta dos blocos 2 e 4**:
$$K = (I_2 \cup J_2) \sqcup (I_4 \cup J_4) \implies K \equiv I_2 \oplus J_2 \oplus I_4 \oplus J_4 \pmod 2.$$

No ramo $c_{99} = 1$, a 5ª condição impõe $c_{57} = K$. Substituindo $c_{57} = K$ na forma original de $Q_4$ (que possuía 5 termos lineares $\{23,31,39,57,112\}$ e $4 \times 64 = 256$ termos quadráticos, totalizando 261 antes de $C_5$, ou 292 com $K$ expandido; no subespaço reduzido de 110 variáveis onde 3 variáveis foram eliminadas por $T_{20}, C_5, C_7$, $Q_4$ colapsa para `q4_terms = 228`), vejamos o que é o polinômio $L_{\text{coset}} := Q_{\text{0x0}} \oplus Q_{\text{0xf}}$ de **196 termos** listado em `monomials_hex`:

Decodificando os bitmasks hexadecimais de `monomials_hex` ($m = 2^u + 2^v$ para grau 2, $m = 2^u$ para grau 1):
1. **4 termos lineares:** `0x800000` ($2^{23}$), `0x80000000` ($2^{31}$), `0x8000000000` ($2^{39}$), `0x10000000000000000000000000000` ($2^{112}$). Ou seja, exatamente $S_{\text{lin}} := c_{23} \oplus c_{31} \oplus c_{39} \oplus c_{112}$.
2. **192 termos quadráticos ($3 \times 64$):**
   * `0xa` $= 2^1 + 2^3$ ($c_1 c_3 \in I_2 \times J_2$), `0x208` $= 2^3 + 2^9$ ($c_9 c_3 \in I_2 \times J_2$), ..., completando todos os **64 produtos de $I_2 \times J_2$**.
   * `0x1004` $= 2^2 + 2^{12}$ ($c_2 c_{12} \in I_3 \times J_3$), `0x1400` $= 2^{10} + 2^{12}$ ($c_{10} c_{12} \in I_3 \times J_3$), ..., completando todos os **64 produtos de $I_3 \times J_3$**.
   * `0x1002000` $= 2^{13} + 2^{24}$ ($c_{13} c_{24} \in I_4 \times J_4$), `0x1200000` $= 2^{21} + 2^{24}$ ($c_{21} c_{24} \in I_4 \times J_4$), ..., completando todos os **64 produtos de $I_4 \times J_4$**.

Portanto, temos a identidade algébrica **exata e fechada**:
$$Q_{\text{0x0}} \oplus Q_{\text{0xf}} = (c_{23} \oplus c_{31} \oplus c_{39} \oplus c_{112}) \oplus I_2 J_2 \oplus I_3 J_3 \oplus I_4 J_4 = 1$$
*(O valor requerido é $1$ pois `required_value_for_bent` é $1$ para `0x0` e $0$ para `0xf`, confirmado por `0xd7` e `0xf5` que avaliam a $1$).*
Isso também explica imediatamente `symplectic_rank = 6`: a forma quadrática tem exatamente 3 pares hiperbólicos independentes $(I_2, J_2), (I_3, J_3), (I_4, J_4)$, sem variáveis do Bloco 1!

*(Nota sobre o 228 de `q4_terms`)*: Como $Q_4$ original é $S_{\text{lin}} \oplus c_{57} \oplus I_1 J_1 \oplus I_2 J_2 \oplus I_3 J_3 \oplus I_4 J_4$, por que ele tem 228 termos na base de 110 variáveis enquanto $Q_{\text{0x0}} \oplus Q_{\text{0xf}}$ tem 196 e usa os 48 índices intactos dos blocos 2, 3 e 4? Porque na escolha de pivôs das 110 variáveis livres (`free_dim_after_T20_C5_C7 = 110`), o pivô eliminado por $C_5$ ($c_{57} = K$) é o próprio $c_{57}$ (adicionando 32 termos lineares de $K$), e um dos pivôs eliminados por $T_{20}$ ou $C_7$ pertence ao Bloco 1 (ou substitui um termo em $I_1, J_1$), alterando a contagem de monômios de $c_{57} \oplus I_1 J_1$, mas deixando os 48 parâmetros de $P_2, P_3, P_4$ e $\{23,31,39,112\}$ completamente livres de pivôs!

#### 1.2. Cancelamento e Fatoração de $Q_4 \oplus (Q_{\text{0x0}} \oplus Q_{\text{0xf}})$
Sabemos que para uma função bent:
1. $Q_4 = 0$ (6ª condição, T28), onde no ramo $c_{99}=1$ temos $c_{57} = K$:
   $$Q_4 = S_{\text{lin}} \oplus K \oplus I_1 J_1 \oplus I_2 J_2 \oplus I_3 J_3 \oplus I_4 J_4 = 0$$
2. $Q_{\text{0x0}} \oplus Q_{\text{0xf}} = 1$ (nova lei dos cosets):
   $$L_{\text{coset}} = S_{\text{lin}} \oplus I_2 J_2 \oplus I_3 J_3 \oplus I_4 J_4 = 1$$

Fazendo o XOR direto $Q_4 \oplus L_{\text{coset}}$, **cancelam-se simultaneamente os 4 termos lineares $S_{\text{lin}}$ e os 192 termos quadráticos ($P_2, P_3, P_4$)**! Resta uma lei quadrática ultra-esparsa de **posto simplético 2 (um único produto bilinear $8 \times 8$)** acoplada à paridade $K$:

$$I_1 J_1 \oplus K = 1 \iff I_1 J_1 = K \oplus 1 \iff I_1 J_1 = c_{57} \oplus 1$$

Explicitamente, definindo as paridades lineares $u_r := \bigoplus_{i \in I_r} c_i$ e $v_r := \bigoplus_{j \in J_r} c_j$ para $r \in \{1,2,3,4\}$, o sistema quadrático de grau 2 inteiro se desacopla perfeitamente em:
1. **Equação de Posto Simplético 2 (Bloco 1 vs $K$):**
   $$u_1 \cdot v_1 = u_2 \oplus v_2 \oplus u_4 \oplus v_4 \oplus 1$$
2. **Equação de Posto Simplético 6 (Blocos 2, 3, 4 vs $S_{\text{lin}}$):**
   $$c_{23} \oplus c_{31} \oplus c_{39} \oplus c_{112} = u_2 v_2 \oplus u_3 v_3 \oplus u_4 v_4 \oplus 1$$

#### 1.3. Eliminação Direta de Variáveis e Ramificação Estrutural
* **Eliminação Linear Imediata (1 variável livre eliminada sem aumentar o grau de nada que não dependa de $S_{\text{lin}}$):**
  Como $c_{112}$ (ou $c_{23}, c_{31}, c_{39}$) aparece **linearmente** em $L_{\text{coset}} = 1$ e **não participa** de nenhum dos produtos $P_1, P_2, P_3, P_4$, nem de $K$, nem de $M$, nem de $R$ ($R \cap \{23,31,39,112\} = \emptyset$), podemos isolar e substituir:
  $$c_{112} \leftarrow 1 \oplus c_{23} \oplus c_{31} \oplus c_{39} \oplus u_2 v_2 \oplus u_3 v_3 \oplus u_4 v_4$$
  *(Atenção: antes de substituir $c_{112}$ nos polinômios cúbicos `0x3f3f`, `0x5f5f`, `0x6f6f`, `Q_0xf`, deve-se verificar se $c_{112}$ multiplica termos quadráticos neles — o que elevaria o grau para 4. Se $c_{112}$ aparecer apenas em grau $\le 1$ neles, a substituição é gratuita; caso contrário, mantém-se um bit auxiliar $s := c_{23} \oplus c_{31} \oplus c_{39} \oplus c_{112}$ eliminando $c_{112} = s \oplus c_{23} \oplus c_{31} \oplus c_{39}$ de forma puramente linear!)*
* **Eliminação Linear Condicional da Equação $u_1 v_1 = K \oplus 1$ (divisão em 2 sub-ramos lineares!):**
  Em vez de tratar $I_1 J_1 \oplus K = 1$ como 64 monômios quadráticos genéricos, note que ela depende de apenas **3 bits agregados**: $u_1, v_1$ e $K$ ($= c_{57}$). Há exatamente 4 atribuições válidas para $(u_1, v_1, K) \in \mathbb{F}_2^3$ que satisfazem $u_1 v_1 = K \oplus 1$:
  * **Sub-ramo A ($K = 0 \implies u_1 v_1 = 1$):** Força **3 novas leis lineares simultâneas**:
    $$K = 0, \quad u_1 = 1, \quad v_1 = 1.$$
    Isso elimina **mais 3 variáveis livres linearmente** (reduzindo a dimensão livre de 110 para **107** sem aumentar o grau de nenhum polinômio cúbico!), além de colapsar o plano $(d, e)$ de T30 (pois $e = e_{42}+e_{81}+e_{94}+e_{106}$ preserva $u_1$ e $v_1$, já que $\{42,94\} \subset I_1$ e $\{81,106\} \subset J_1$).
  * **Sub-ramo B ($K = 1 \implies u_1 v_1 = 0$):** Impõe a lei linear $K = 1$ (reduzindo a 109 variáveis) e divide $(u_1, v_1) \in \{(0,0), (0,1), (1,0)\}$ em **3 sub-casos puramente lineares de dimensão 107** cada!

**Conclusão da Parte 1:** Graças a $Q_4 \oplus Q_{\text{0x0}} \oplus Q_{\text{0xf}} = 1$, a 6ª condição ($Q_4=0$) inteira deixa de ser não-linear quando estratificada em **4 subespaços afins disjuntos de dimensão 107** definidos por $(K, u_1, v_1) \in \{(0,1,1), (1,0,0), (1,0,1), (1,1,0)\}$! E fixando adicionalmente as 6 paridades $(u_2, v_2, u_3, v_3, u_4, v_4) \in \mathbb{F}_2^6$ (64 subespaços afins, ou parametrizando em SAT), **ambas as condições quadráticas ($Q_4=0$ e $Q_{\text{0x0}} \oplus Q_{\text{0xf}}=1$) tornam-se 100% lineares**, reduzindo a dimensão livre para $110 - 3 - 7 = 100$ variáveis puramente lineares!

---

### Parte 2: Pipeline Exato de Decisão Simbólica (Macaulay + XOR-SAT / Cardinalidade)

O objetivo é decidir a satisfatibilidade (ou extrair o espaço de sobreviventes) no ramo $c_{99}=1$ combinando:
* As leis algébricas sobre $\mathbb{F}_2$ (graus 1, 2 e 3);
* As restrições inteiras exatas de espectro de Walsh/Fourier (pesos de Hamming exatos nos cosets de órbitas de tamanho 16), que são **muito mais fortes** do que suas reduções módulo 4 ($Q_{\text{0x0}}, Q_{\text{0xf}}, Q_{\text{0x5}}$);
* Validação contínua contra as duas únicas testemunhas conhecidas que passam até aqui: `0xd7` e `0xf5`.

*(Verificação importante de sanidade)*: Note em `algebra_c99_3_combine.json` que `witnesses_passing_3f3f_5f5f_6f6f_Q0xf` contém `["0xd7", "0xf5"]`. Confirme logo no Passo 0 se `0xd7` e `0xf5` também satisfazem $C_1..C_7$ (incluindo $Q_4 = 0 \implies I_1 J_1 = K \oplus 1$) e quais são seus pesos exatos `wt(C_0x0)`, `wt(C_0xf)`, `wt(C_0x5)`!
* Se `0xd7` ou `0xf5` falharem nos pesos inteiros exatos (`wt(C_0xf)=128`, etc.), elas servem como testemunhas de calibração algébrica (devem passar na Fase 1/2 módulo 4 e ser eliminadas exatamente na Fase 3 de cardinalidade!).
* Se passarem nos pesos inteiros, qualquer prova de UNSAT exigirá suprimir simetrias ou adicionar novos suportes/cosets além de `{0x0, 0xf, 0x5}`.

Aqui está o pipeline exato em 4 estágios determinísticos:

---

#### Estágio 1: Pré-processamento Linear e Estratificação Bilinear (Python / Bitsets 128-bit)
Em vez de alimentar polinômios densos de 27.654 termos diretamente num solver, usamos a fatoração da Parte 1:

1. **Base afim inicial ($d = 110$):** Imponha $c_{99}=1$, as 3 leis lineares de $T_{20}$, $C_5$ ($c_{57} = K$) e $C_7$ ($R = 0$). Valide que os vetores de parâmetros de `0xd7` e `0xf5` pertencem a este espaço e anote suas tuplas $(K, u_1, v_1, u_2, v_2, u_3, v_3, u_4, v_4, S_{\text{lin}})$.
2. **Mais Suportes Periódicos Cúbicos (Expansão Barata):**
   Assim como `0x7777` deu uma lei linear ($R=0$) e `0x3f3f`, `0x5f5f`, `0x6f6f` deram polinômios cúbicos, gere programaticamente (em $< 5$ segundos, mesmo código de `algebra_c99_1`) os polinômios $\mathbb{F}_2$ de **todos os outros suportes periódicos de peso 12** invariantes ou semi-invariantes (ex.: `0x7b7b`, `0x7d7d`, `0x7e7e`, `0x3f5f`, `0x3f6f`, `0x5f6f`, e rotações de blocos) e **todos os 16 cosets** `0x0`..`0xf` (já sabemos que `0x0, 0x1, 0x3, 0x5, 0x7, 0xf` cobrem as classes de simetria principais, verifique `0x2, 0x4, 0x6, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe` — mesmo que equivalentes sob permutação de coordenadas do código, **a ANF candidata $f$ não é necessariamente invariante por todas as permutações**, logo cosets conjugados geram polinômios distintos sobre as 110 variáveis!).
   * Extraia imediatamente pelo escalonamento de Gauss sobre os monômios de grau $\le 2$ todas as **novas leis lineares** (grau 1) e **novas leis quadráticas** (grau 2, como os conjugados de $Q_{\text{0x0}} \oplus Q_{\text{0xf}} = 1$).
   * **Ponto crucial:** Se os cosets conjugados a `0xf` (ou permutações de coordenadas em $H(16,4)$) gerarem combinações $Q_{\text{0x0}} \oplus Q_{c} = 1$ análogas a $L_{\text{coset}}$, cada uma delas dará uma equação do tipo $I_1 J_1 \oplus K = 1$ para **outros blocos de produtos**! Múltiplas equações quadráticas de posto 2/6 forçam relações lineares via radicais ou Macaulay de grau 3.

---

#### Estágio 2: Eliminação de Macaulay em Grau 3 (e Grau 4 Parcial) sobre $\mathbb{F}_2$
Temos o conjunto de polinômios cúbicos $\mathcal{P}_3 = \{P_{\text{3f3f}}, P_{\text{5f5f}}, P_{\text{6f6f}}, Q_{\text{0xf}}, \dots\}$ (note que $Q_{\text{0x0}}$ já é redundante pois $Q_{\text{0x0}} = Q_{\text{0xf}} \oplus L_{\text{coset}} \oplus 1$) e polinômios quadráticos $\mathcal{P}_2 = \{I_1 J_1 \oplus K \oplus 1, L_{\text{coset}} \oplus 1, \dots\}$.

1. **Restrição aos 4 Sub-ramos Lineares de $(K, u_1, v_1)$:**
   Para cada um dos 4 casos $\sigma \in \{(0,1,1), (1,0,0), (1,0,1), (1,1,0)\}$:
   * Elimine 3 variáveis por substituição linear exata ($d \le 107$). Como a substituição é **linear**, o grau máximo de $\mathcal{P}_3$ continua sendo **3**!
2. **Matriz de Macaulay $M_3$ sobre $\mathbb{F}_2$ (Custo muito baixo!):**
   Em $d = 107$ variáveis booleanas ($x_i^2 = x_i$), o número total de monômios de grau $\le 3$ é:
   $$N_{\le 3} = \binom{107}{0} + \binom{107}{1} + \binom{107}{2} + \binom{107}{3} = 1 + 107 + 5.671 + 198.485 = 204.264 \text{ colunas.}$$
   Construa as linhas de $M_3$:
   * Todas as equações cúbicas $P \in \mathcal{P}_3$ restritas a $\sigma$;
   * Todos os deslocamentos lineares das quadráticas: $x_i \cdot Q$ para todo $i \in \{1..107\}$ e toda $Q \in \mathcal{P}_2$ (por exemplo, $107 \times |\mathcal{P}_2|$ linhas cúbicas!).
   * **Ordene as colunas por grau decrescente (`degrevlex`: grau 3 $\to$ grau 2 $\to$ grau 1 $\to$ constante `1`)** e execute Eliminação Gaussiana esparsa bit-packed (`uint64_t` ou `M4RI` / C++ `std::bitset` / Cython). Uma matriz esparsa de $\sim 500 \times 204.264$ sobre $\mathbb{F}_2$ escalona em **menos de 1 segundo em CPU**.
   * **Resultados possíveis em $M_3$:**
     * Se a linha `[0, 0, ..., 0 | 1]` aparecer no span $\implies$ **UNSAT algébrico provado** para o sub-ramo $\sigma$ (com certificado dual $\sum \alpha_k R_k = 1$ verificável em 10 linhas de Python!).
     * Todas as linhas reduzidas cujo pivô cai no bloco de **grau 1** são **novas leis lineares implicadas**! Substitua-as de volta, reduza $d$, e repita até o ponto fixo (XL / Gröbner parcial sem explosão de grau).
     * Todas as linhas reduzidas cujo pivô cai no bloco de **grau 2** enriquecem $\mathcal{P}_2$, gerando mais $d$ linhas $x_i \cdot Q_{\text{novo}}$ na iteração seguinte de $M_3$!
3. **Macaulay Seletivo de Grau 4 ($M_4$ focalizado):**
   Em $d \approx 100$, $\binom{100}{4} \approx 3.9 \times 10^6$ colunas é grande para matriz densa, mas **não precisamos de todas as multiplicações**: multiplique $Q \in \mathcal{P}_2$ apenas pelas formas quadráticas $u_r x_i$ ou pares de variáveis que compartilham suporte nos termos cúbicos de $P_{\text{5f5f}}$ (que só tem 5.064 cúbicos) e $P_{\text{3f3f}} \oplus P_{\text{6f6f}}$, usando tabelas hash esparsas de monômios (`uint128_t` bitmask $\to$ pivô) para cancelar os termos de grau 4 on-the-fly.

---

#### Estágio 3: Formulação Híbrida Exata em CryptoMiniSat (XOR-SAT + Cardinalidade Exata das Órbitas)
As equações polinomiais $Q_{\text{0x0}}, Q_{\text{0xf}}, Q_{\text{0x5}}$ capturam **apenas a soma dos bits das órbitas módulo 2 (ou módulo 4)**! A condição real de bentness nos cosets impõe **pesos de Hamming inteiros exatos** sobre os vetores de avaliação das órbitas de tamanho 16:
* `coset 0xf` (256 órbitas de tamanho 16): cada órbita $O_k$ ($k=1..256$) tem um bit de paridade/valor constante linearizado $y^{(f)}_k = \ell^{(f)}_k(c) \in \mathbb{F}_2$ (pois sobre os geradores da ANF, a avaliação da função ou da diferença em cada ponto/órbita é **uma combinação XOR puramente linear** dos 110 parâmetros livres $c$!). A condição `wt(C_0xf) = 128` exige que, dentre os 256 bits $y^{(f)}_1, \dots, y^{(f)}_{256}$, **exatamente 128 sejam 1**!
* `coset 0x5` (512 órbitas): `wt(C_0x5) = 256` exige que, dentre os 512 bits lineares $y^{(5)}_1, \dots, y^{(5)}_{512}$, **exatamente 256 sejam 1**! (Veja que módulo 4 isso colapsou para o polinômio identicamente zero `0 = 0`, perdendo **100% da informação**, enquanto a restrição inteira $\sum_{k=1}^{512} y^{(5)}_k = 256$ corta fortemente o espaço!).
* `coset 0x0` (240 órbitas): `wt(C_0x0) \in \{110, 114, 126, 130\}` sobre os 240 bits lineares $y^{(0)}_1, \dots, y^{(0)}_{240}$.
* Idem para `coset 0x1` (1024 órbitas, peso 512), `0x3` (1024 órbitas, peso 512), `0x7` (1024 órbitas, peso 512) — todos tinham polinômio módulo 4 nulo (`terms: 0`), mas como restrições pseudo-booleanas / cardinalidade sobre formas lineares em $c$, são hiperplanos combinatórios fortíssimos!

**Por que essa codificação evita 100% os 27.654 monômios cúbicos no SAT solver?**
Porque o polinômio cúbico de 27.654 termos ($Q_{\text{0xf}}$) nada mais era do que o bit $\sigma_2(y^{(f)})$ (segundo polinômio simétrico elementar $\sum_{i < j} y_i y_j \bmod 2$, ou soma de produtos de pares na órbita)! No SAT solver, **nós não codificamos os 27.654 termos cúbicos**: nós definimos diretamente os bits de órbita via cláusulas `XOR` nativas do **CryptoMiniSat 5** e aplicamos redes de contagem (Cardinality Networks / Sequential Counters / BDDs)!

##### Arquitetura Exata do CNF+XOR para CryptoMiniSat (por sub-ramo $\sigma$):

1. **Variáveis Primárias ($d \le 107$ vars):**
   $c_1, \dots, c_d \in \{0,1\}$ (parâmetros livres da ANF após $T_{20}, C_5, C_7$, sub-ramo $\sigma$ de $(K, u_1, v_1)$, e quaisquer leis lineares descobertas no Estágio 2).
2. **Cláusulas XOR Nativas (`x ...` no formato DIMACS do CryptoMiniSat):**
   * **Paridades de Blocos ($P_2, P_3, P_4$):** Defina 6 variáveis auxiliares $u_2, v_2, u_3, v_3, u_4, v_4$ com 6 cláusulas XOR de comprimento 9 (`u_r ^ sum(I_r) = 0`), mais `s_lin ^ c23 ^ c31 ^ c39 ^ c112 = 0`. Codifique os 3 produtos `p_r = u_r & v_r` (9 cláusulas CNF de tamanho $\le 3$) e 1 cláusula XOR `s_lin ^ p_2 ^ p_3 ^ p_4 = 1`. *(Isso codifica $Q_4 = 0$ e $L_{\text{coset}} = 1$ inteiros com **apenas 9 variáveis auxiliares** em vez de 196 monômios!)*
   * **Avaliações de Pontos / Órbitas nos Cosets:**
     Lembre-se de como $t_f$ (em T28/T31 e nos cosets) é definido: para cada par trocado $\{x, \pi(x)\}$ ou órbita $O_k$, cada bit de avaliação da função $f(x)$ (ou diferença $f(x) \oplus f(x')$) é **uma forma afim puramente linear** nos parâmetros $c$ da ANF:
     $$z_m \equiv \ell_m(c) \pmod 2 \quad \text{(1 cláusula XOR nativa por avaliação necessária!)}$$
     *(Atenção: verifique na implementação de `algebra_c99_1` se cada órbita de tamanho 16 contribui com um bit linear $y_k = \ell_k(c)$ ou com um produto quadrático/AND de 2 formas lineares $y_k = \ell_{k,1}(c) \wedge \ell_{k,2}(c)$ — pois se o polinômio módulo 4 da soma $\sum y_k$ tem grau 3 quando dividido por 2, como $\lfloor \sum y_k / 2 \rfloor \bmod 2 = \sum_{i<j} y_i y_j \bmod 2$, então $\deg(\sum_{i<j} y_i y_j) = 3 \implies$ alguns $y_k$ têm grau 1 e alguns têm grau 2, ou $y_k$ é função de 2 bits lineares da órbita! Em ambos os casos, introduz-se 1 variável XOR para cada forma linear distinta $\ell(c)$ — no máximo $2^{12}=4096$ pontos em todo o espaço, mas restrito aos cosets `0xf`, `0x0`, `0x5` são apenas algumas centenas de formas lineares — e 3 cláusulas CNF por porta AND local da órbita para definir $y_k \in \{0,1\}$!)*
3. **Suportes Periódicos (`0x3f3f`, `0x5f5f`, `0x6f6f`):**
   Da mesma forma, **não use a expansão ANF de 14.701 termos cúbicos** no SAT! Use a **fórmula de código de valores** (como em T31: $h_f(S) = B_0 + 2|P| - 4\,\text{wt}(t_f)$):
   * Nos 2.016 pares trocados de `0x5f5f` (ou agrupados por simetria residual), $t_f(p) = f(v,w) \oplus f(w,v)$ é **100% linear em $c$**!
   * Mais forte ainda: bentness em suporte $S$ de peso 12 exige não apenas $h_f(S) \equiv 0 \pmod{32}$ (que era o polinômio cúbico!), mas que o coeficiente inteiro $h_f(S)$ assuma um valor válido do espectro bent / Walsh restrito! No mínimo, sobre os bits $t_f(p)$, a restrição $\text{wt}(t_f) \equiv \text{alvo} \pmod 8$ é uma simples **árvore de somadores XOR mod 8** (Full Adders booleanos: 5 variáveis auxiliares por par de somadores, crescimento linear $O(N)$, **zero explosão cúbica**), e o motor Gauss-Jordan nativo do CryptoMiniSat propaga todas as equações XOR instantaneamente durante o DPLL (`--gaussuntil=1000`).
4. **Restrições Exatas de Cardinalidade (`PySAT` / `PBLib` — Totalizer Encoding):**
   * Para `0xf`: `CardEnc.equals(lits=y_0xf, bound=128, encoding=EncType.totalizer)` ($\sim 256 \log_2^2(256)$ cláusulas, fortíssima propagação por Arc-Consistency generalizada!).
   * Para `0x5`: `CardEnc.equals(lits=y_0x5, bound=256, encoding=EncType.totalizer)`.
   * Para `0x0`: codifique um único Totalizer sobre os 240 literais `y_0x0` com saídas unárias $o_1, \dots, o_{131}$, e adicione 4 literais seletores $b_{110}, b_{114}, b_{126}, b_{130}$ impondo $\sum y^{(0)}_k \in \{110, 114, 126, 130\}$ com $\sim 10$ cláusulas unitárias/binárias nas saídas do Totalizer!

---

#### Estágio 4: Protocolo de Verificação Cruzada com `0xd7` e `0xf5` e Quebra de Simetria

Para garantir zero falsos negativos (bugs de sinal/constante que gerem um UNSAT espúrio):

1. **Teste Positivo Obrigatório (Unit Test das Testemunhas):**
   * Fixe as 110 variáveis nos valores exatos da testemunha `0xd7` (e depois `0xf5`) adicionando 110 cláusulas unitárias ao CNF+XOR **sem** as restrições inteiras novas (apenas com `0x3f3f`, `0x5f5f`, `0x6f6f` mod 32 e `Q_0x0`, `Q_0xf` mod 4 via somadores). O CryptoMiniSat **tem** de retornar `SAT` em $0.01\text{s}$.
   * Em seguida, inspecione nos modelos de `0xd7` e `0xf5` os valores exatos de $\text{wt}(C_{\text{0xf}})$, $\text{wt}(C_{\text{0x5}})$ e $\text{wt}(C_{\text{0x0}})$.
   * Solte 20 variáveis aleatórias de `0xd7` (mantendo 90 fixas) no modelo completo mod 4 para confirmar que o solver reencontra `0xd7`.
2. **Quebra de Simetria e Particionamento (`Cube-and-Conquer` sob $(u_2, v_2, u_3, v_3, u_4, v_4)$):**
   * Para cada um dos 4 sub-ramos $\sigma$ de $(K, u_1, v_1)$, existem $2^6 = 64$ atribuições das paridades $(u_2, v_2, u_3, v_3, u_4, v_4)$, totalizando **$4 \times 64 = 256$ cubos independentes**.
   * Em **cada um dos 256 cubos**, todas as condições $C_1..C_7$ e $L_{\text{coset}}$ são **100% lineares** ($d = 100$ variáveis livres reais, zero portas AND para $Q_4$ ou $L_{\text{coset}}$!).
   * Os 256 cubos podem ser despachados em paralelo (ex.: `multiprocessing` em todos os cores da CPU com CryptoMiniSat + Gauss-Jordan habilitado), gerando logs `DRAT/FRAT` caso retornem `UNSAT` ou despejando sobreviventes explícitos caso retornem `SAT` (para filtragem imediata via Fast Walsh-Hadamard Transform em $2^{16}$ pontos).

---

### Resumo Executivo dos Ganhos Imediatos
1. **$Q_4 \oplus (Q_{\text{0x0}} \oplus Q_{\text{0xf}}) = 1$ reduz-se exatamente a $I_1 J_1 = K \oplus 1$** (posto simplético 2, cancelando 196 termos de uma só vez).
2. **$Q_4 = 0$ e $Q_{\text{0x0}} \oplus Q_{\text{0xf}} = 1$ linearizam-se completamente** ao estratificar em 4 sub-ramos de $(K, u_1, v_1)$ (dimensão 107 para Macaulay grau 3) ou 256 cubos de $(K, u_1, v_1, u_2, v_2, u_3, v_3, u_4, v_4)$ (dimensão 100 puramente linear para CryptoMiniSat).
3. **A substituição dos polinômios cúbicos densos (27.654 termos) por bits lineares de órbita (`XOR`) + redes Totalizer exatas (`wt=128`, `wt=256`, `wt in {110,114,126,130}`)** recupera toda a informação inteira perdida em `0x5`, `0x1`, `0x3`, `0x7` sem nenhuma explosão algébrica de grau 3.