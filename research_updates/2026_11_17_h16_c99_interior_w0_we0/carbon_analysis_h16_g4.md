Abaixo apresenta-se a análise rigorosa dos resultados auditados para o espaço de funções booleanas homogêneas quárticas rotacionalmente simétricas em $n=16$ variáveis ($\mathcal{H}_{16}$, grau 4), restrito ao ramo $c_{99} = 1$ — onde o representante $(0,2,8,10)$ possui estabilizador de ordem 4 sob $\mathbb{Z}_{16}$, gerando uma órbita curta de comprimento 4.

---

### 1. Arquitetura do Ramo $c_{99}=1$ e a Insuficiência Estrutural de $W_f(0), W_f(e_0)$ após C1..C7

Os dados estabelecem três fatos arquiteturais definitivos sobre o espaço de busca (cuja dimensão bruta de 116 cai para $\approx 109$ graus de liberdade efetivos após as restrições lineares e quadráticas/quárticas de C1..C7):

1. **Eliminação exata das caudas extremas ($k \le 5$ e $k \ge 107$):** 
   A varredura exaustiva sobre as $29.508.240$ tuplas admissíveis em $k=5$ (e seu dual de complementação $k=107$), somada ao controle $k \in [0,4]$, prova que qualquer função bent neste ramo exige estritamente $6 \le k \le 106$ órbitas longas ativas. Notavelmente, em $k=5$, $99,99992\%$ das falhas ocorrem já no viés global $W_f(0)$, restando apenas 24 candidatos que colapsam em $W_f(e_0)$.

2. **Transição de fase: de "obstrução rígida" na fronteira para "filtro poroso" no interior:**
   Enquanto na fronteira $k \le 5$ o par $(|W_f(0)|, |W_f(e_0)|) = (256, 256)$ atua como certificado de inexistência (0 sobreviventes), no interior central ($k \in [50,62]$) a situação inverte-se drasticamente. Sob amostragem estrita C1..C7:
   * Taxa de passagem em $|W_f(0)| = 256$: $\frac{124.907}{801.340} \approx \mathbf{15,59\%}$.
   * Taxa condicional de passagem em $|W_f(e_0)| = 256$ dado $|W_f(0)|=256$: $\frac{5.104}{124.907} \approx \mathbf{4,09\%}$ (taxa conjunta de $\mathbf{0,637\%}$).
   
   Na varredura de alta vazão (sem impor C6 a priori, ou seja, C1..C5+C7), das $255.463$ soluções que satisfazem $|W_f(0)|=|W_f(e_0)|=256$ na faixa central, $127.769$ ($\mathbf{50,015\%}$) já são C6/C7-válidas. Isso demonstra que **C6 é estatisticamente ortogonal (independente)** à condição arquimediana $|W_f(0)|=|W_f(e_0)|=256$ no interior denso/central: satisfazer os dois primeiros momentos espectrais não força C6 além da moeda justa em $\mathbb{F}_2$, e impor C1..C7 deixa um subespaço gigantesco ($\sim 0,64\%$ da variedade C1..C7 no centro, ou seja, da ordem de $\approx 2^{101}$ funções) intacto após testar $W_f(0)$ e $W_f(e_0)$.

3. **Ausência de obstrução $2$-ádica em $(A,B)$:**
   Como $W_f(0) = A + B$ e $W_f(e_0) = A - B$, a condição $|W_f(0)| = |W_f(e_0)| = 256$ equivale exatamente a $\{|A|, |B|\} = \{256, 0\}$ — ou seja, uma das subfunções de 15 variáveis $f|_{x_0=0}$ ou $f|_{x_0=1}$ é estritamente balanceada e a outra possui desequilíbrio $\pm 256$. Como o grau algébrico de $f|_{x_0=c}$ é no máximo 4, o Teorema de Ax-McEliece garante divisibilidade de $A$ e $B$ por $2^{\lceil 15/4 \rceil} = 2^4 = 16$; a simetria residual e as leis C1..C5 elevam esse piso $2$-ádico para **64**, como observado empiricamente. Como $256 = 4 \times 64$ e $0 = 0 \times 64$, os alvos $(A,B) \in \{(\pm 256, 0), (0, \pm 256)\}$ são perfeitamente compatíveis com o reticulado modular $64\mathbb{Z}^2$. Logo, métodos puramente congruenciais sobre $W_f(0)$ e $W_f(e_0)$ estão esgotados.

---

### 2. Causa da Forte Assimetria entre `near_sparse` ($k \in [6,15]$) e `near_dense` ($k \in [97,106]$)

Embora $\binom{112}{k} = \binom{112}{112-k}$ torne os tamanhos dos espaços `near_sparse` ($k \in [6,15]$) e `near_dense` ($112-k \in [6,15]$) combinatorialmente simétricos, os resultados mostram **0 acertos** em $39,59\text{M}$ no `near_sparse` contra **11.131 acertos** ($5.656$ C7-válidos) em $37,83\text{M}$ no `near_dense`. Essa assimetria decorre de três mecanismos algébricos precisos:

1. **Não-invariância da transformação $c_{\text{long}} \mapsto \mathbf{1} \oplus c_{\text{long}}$ no espectro de Walsh:**
   Seja $S_{\text{long}}(x) = \sum_{i=1}^{112} \mathcal{O}_i(x)$ a soma de todas as 112 órbitas longas quárticas. Como $\sigma_4(x)$ (o polinômio simétrico elementar homogêneo de grau 4 em 16 variáveis) decompõe-se exatamente na soma de todas as 116 órbitas:
   $$\sigma_4(x) = S_{\text{long}}(x) \oplus \mathcal{O}_{57}(x) \oplus \mathcal{O}_{99}(x) \oplus \mathcal{O}_{113}(x) \oplus \mathcal{O}_{115}(x),$$
   complementar as órbitas longas equivale a somar $\sigma_4(x)$ módulo órbitas curtas. O espectro de Walsh de $\sigma_4(x)$ depende apenas do peso de Hamming $wt(x) \pmod 8$ (pois $\sigma_4(x) = \binom{wt(x)}{4} \bmod 2$, que vale $1 \iff wt(x) \equiv 4,5,6,7 \pmod 8$). Somar $\sigma_4(x)$ a um polinômio esparso **não preserva** a distribuição de pesos de $f$, mas injeta uma curvatura algébrica global máxima (todos os $\binom{16}{4} = 1820$ monômios, exceto os curtos ajustados).

2. **Armadilha de viés positivo (baixa capacidade de cancelamento) em `near_sparse`:**
   Uma função homogênea de grau 4 com apenas $k \in [6,15]$ órbitas longas e $c_{99}=1$ possui entre $4 + 96 = 100$ e $4 + 240 = 244$ monômios (de um total de $1820$). Para entradas $x \in \mathbb{F}_2^{16}$ de peso baixo ou moderado ($wt(x) \le 6$), a função esparsa avalia identicamente a $0$ na imensa maioria do cubo booleano, gerando um forte viés positivo $W_f(0) \gg 256$. Isso é visível já no primeiro filtro: em `near_sparse`, apenas $\mathbf{0,157\%}$ ($62.318 / 39,59\text{M}$) atingem $|W_f(0)|=256$, contra $\mathbf{2,459\%}$ ($930.379 / 37,83\text{M}$) em `near_dense` — uma supressão de **15,6 vezes** já em $W_f(0)$.

3. **Acoplamento destrutivo entre $A$ e $B$ sob esparsidade:**
   Para passar em ambos os testes, exige-se $A=0$ ou $B=0$. Restringindo a $x_0=1$, $f(1, x') = g_4(x') \oplus g_3(x')$, onde $g_3$ é cúbica homogênea em 15 variáveis derivada dos monômios de $f$ que contêm $x_0$. Em `near_sparse`, cada órbita longa contribui com apenas $\frac{4}{16} \times 16 = 4$ monômios contendo $x_0$, logo $g_3$ tem entre $25$ e $61$ monômios cúbicos (com $c_{99}=1$ contribuindo com $x_2 x_8 x_{10}$). Um polinômio $g_4 \oplus g_3$ tão esparso não tem entropia algébrica suficiente para atingir simultaneamente o balanceamento exato em um semiespaço ($A=0$ ou $B=0$) e o desvio mínimo permitido ($256$) no outro: na fronteira $k=5$, apenas $24$ em $29,5\text{M}$ passavam em $W_f(0)$ e **todas** falhavam em $W_f(e_0)$; em $k=107$, já havia $3.612$ passagens em $W_f(0)$ ($150\times$ mais). No `near_dense`, a presença de $\sigma_4(x)$ fornece cancelamento oscilatório de Krawtchouk sobre as camadas de peso de Hamming, permitindo que pequenas subtrações de $6$ a $15$ órbitas sintonizem $(A,B)$ em $\{(\pm 256,0), (0,\pm 256)\}$ com probabilidade condicional de $\mathbf{1,20\%}$ ($11.131 / 930.379$).

---

### 3. Significado da Falha Universal em `0x3` ($e_0 + e_1$) e a Próxima Estratégia de Ataque

#### A. O que significa falhar 16/16 vezes em $u = e_0 + e_1$ (`0x3`)?
Para uma HRSBF em 16 variáveis, o espectro de Walsh $W_f(u)$ é constante sobre cada órbita de $\mathbb{F}_2^{16}$ sob a rotação cíclica (e também invariante por reversão diedral se a classe for auto-reversa, mas estritamente constante nos ciclos de $\mathbb{Z}_{16}$). Existem 4.116 órbitas espectrais no total, mas apenas **8 órbitas de peso 2**, representadas pelos pares aditivos $e_0 + e_d$ para $d \in \{1, 2, \dots, 8\}$.

1. **Confirmação da quantização $64\mathbb{Z}$ e independência espectral:**
   Note que todos os valores reportados em `0x3` ($192 = 3\cdot 64$, $448 = 7\cdot 64$, $512 = 8\cdot 64$, $640 = 10\cdot 64$) são **múltiplos exatos de 64**. Escrevendo a decomposição em 4 co-conjuntos de $(x_0, x_1) \in \mathbb{F}_2^2$:
   $$S_{ab} = \sum_{x_0=a,\, x_1=b} (-1)^{f(x)}, \quad a,b \in \{0,1\},$$
   temos:
   $$\begin{aligned}
   W_f(0) &= S_{00} + S_{01} + S_{10} + S_{11}, \\
   W_f(e_0) &= S_{00} + S_{01} - S_{10} - S_{11}, \\
   W_f(e_1) &= S_{00} - S_{01} + S_{10} - S_{11}, \\
   W_f(e_0 + e_1) &= S_{00} - S_{01} - S_{10} + S_{11}.
   \end{aligned}$$
   Pela simetria de rotação, $W_f(e_1) = W_f(e_0)$ é garantido **automaticamente** ($S_{01} = S_{10}$ sempre!). Assim, fixar $W_f(0)$ e $W_f(e_0)$ determina unicamente $S_{00} + S_{01} = A$ e $S_{10} + S_{11} = B$ (com $S_{01}=S_{10}$), mas **deixa 1 grau de liberdade inteiro completamente livre**: o parâmetro $S_{11}$ (ou equivalentemente $S_{00} - S_{01}$). Especificamente, se $A=256, B=0$ (logo $S_{11} = -S_{10} = -S_{01}$ e $S_{00} = 256 - S_{01}$):
   $$W_f(e_0 + e_1) = (256 - S_{01}) - S_{01} - S_{01} + (-S_{01}) = 256 - 4 S_{01}.$$
   
2. **A Lei Algébrica Oculta em `0x3` (Restrição Exata sobre $S_{01}$):**
   Esta identidade elementar revela algo extraordinário! Sob $(A,B) = (256, 0)$, temos:
   $$|W_f(e_0 + e_1)| = |256 - 4 S_{01}| = 256 \iff 256 - 4 S_{01} \in \{+256, -256\} \iff S_{01} \in \{0, 128\}.$$
   Mais geralmente, para qualquer solução com $\{|A|, |B|\} = \{256, 0\}$, a condição $|W_f(e_0 + e_1)| = 256$ exige que $W_f(e_0 + e_1) \equiv 256 \equiv 0 \pmod{128}$, enquanto os valores observados nas testemunhas ($192, 448, 640$) satisfazem $W_f(e_0 + e_1) \equiv \mathbf{64} \pmod{128}$!
   * Em outras palavras: $S_{01}$ é sempre múltiplo de 16 (pois $4 S_{01}$ é múltiplo de 64). Sempre que $S_{01} \equiv 16 \pmod{32}$, obtém-se $256 - 4 S_{01} \equiv 64 \pmod{128}$, **proibindo modularmente** $|W_f(e_0+e_1)| = 256$ (foi o que ocorreu nas testemunhas com 192, 448 e 640, correspondendo a $S_{01} \in \{16, -48, -96\}$ ou sinais simétricos!). E mesmo quando $S_{01} \equiv 0 \pmod{32}$ (ex.: testemunha com $512$, onde $S_{01} = -64$), a gaussiana central de $S_{01}$ espalha os valores longe de $\{0, 128\}$. Isso explica por que 16 em 16 testemunhas falharam imediatamente em `0x3`.

---

#### B. Próxima Condição Algébrica, Suporte Periódico e Estratégia Computacional

Com base na identidade $W_f(e_0 + e_1) = 256 - 4 S_{01}$ (e sua análoga para qualquer $e_0 + e_d$), o ataque mais afiado ao interior $6 \le k \le 106$ divide-se em três frentes imediatas:

1. **Extrair a Condição Algébrica **C8** a partir de $W_f(e_0 + e_d) \equiv 0 \pmod{128}$ para $d \in \{1, \dots, 8\}$:**
   * Na fórmula acima, para $(A,B) = (\pm 256, 0)$ ou $(0, \pm 256)$, ter $|W_f(e_0 + e_d)| = 256$ exige **necessariamente** que $S_{01}^{(d)} = \sum_{x_0=0, x_d=1} (-1)^{f(x)}$ seja múltiplo de **32** (para que $4 S_{01}^{(d)} \equiv 0 \pmod{128}$).
   * Como observado nos valores $192, 448, 640$, $S_{01}^{(1)}$ frequentemente cai em $16 \pmod{32}$! Pelo Teorema de McEliece / expansão em polinômios simétricos dos coeficientes $c_i \in \mathbb{F}_2$, o resíduo $\frac{S_{01}^{(d)}}{16} \bmod 2$ sobre o subespaço $\{x_0=0, x_d=1\} \cong \mathbb{F}_2^{14}$ é dado pela soma dos coeficientes de grau máximo (ou pelo polinômio de grau $\le 4$ nos $c_i$ análogo a T28/C6, induzido pela derivada de segunda ordem / restrição codimensão-2).
   * **Ação algébrica imediata:** Derivar os 8 polinômios booleanos sobre os coeficientes de órbita $P_d(c) \equiv \frac{W_f(e_0 + e_d)}{64} \pmod 2$ para $d = 1, 2, 3, 4, 5, 6, 7, 8$ (especialmente $d=2, 4, 8$, que interagem diretamente com o estabilizador $\{0,2,8,10\}$ de $c_{99}=1$!). Toda função bent exige $W_f(u) = \pm 256 \implies \frac{W_f(u)}{64} = \pm 4 \equiv 0 \pmod 2$, logo **$P_d(c) = 0$ para todo $d \in \{1,\dots,8\}$**! Pelos dados de `0x3`, apenas $P_1(c)=0$ já cortará metade (ou $100\%$, se houver obstrução algébrica em algum $d \in \{2,4,8\}$!) da variedade C1..C7!
   * *Verificação crucial em $d=8$ e $d=2$:* Como $\mathcal{O}_{99}$ tem representante $(0,2,8,10)$, restringir $(x_0, x_8)$ ou $(x_0, x_2)$ colapsa monômios de $\mathcal{O}_{99}$ para grau 2 nas 14 variáveis restantes. Verifique imediatamente nos 16 vetores testemunhas (e nos $89.888$ do `full_interior`, se salvos) os valores de $W_f(e_0+e_2)$, $W_f(e_0+e_4)$ e $W_f(e_0+e_8) \bmod 128$: há alta chance de que $P_2(c)$, $P_4(c)$ ou $P_8(c)$ gere uma **contradição algébrica direta** com $c_{99}=1$ + C1..C7, ou reduza a variedade por um fator de $2^8 = 256$ puramente em $\mathbb{F}_2$!

2. **Restrição a Suportes Periódicos (Subgrupos de $\mathbb{Z}_{16}$ / Pontos Fixos Diedrais e de Frobenius):**
   * Avaliar $f$ nos subespaços invariantes por subgrupos de $\mathbb{Z}_{16}$:
     * Período 8 ($x_{i+8} = x_i$, dimensão 8): $W_f$ restrito ou somas sobre pontos de período $2, 4, 8$. Note que para $x$ de período 8 ($x_{i+8}=x_i$), o monômio $(0,2,8,10)$ reduz-se a $x_0 x_2 x_0 x_2 = x_0 x_2$ (grau 2!).
     * Pelo Teorema de Normalidade / Canteaut-Charpin-Kyureghyan sobre subespaços fixos por automorfismos de ordem potência de 2: como $\rho^8$ (translação por 8) é uma involução em $\text{Aut}(f)$ cujo espaço fixo $V_8 = \{x : x_{i+8} = x_i\}$ tem dimensão $8$, a restrição $f|_{V_8}$ (função em 8 variáveis!) relaciona-se módulo congruências de Walsh e dualidade de pontos fixos com o caráter bent de $f$. Na verdade, um resultado clássico sobre funções bent invariantes sob permutação involutiva livre de pontos fixos nas coordenadas (pares $(i, i+8)$): para $u \in V_8$, $W_f(u) \equiv W_{f|_{V_8}}(u|_{V_8}) \pmod{\dots}$ — mais precisamente, órbitas de pares $(x, \rho^8(x))$ fora de $V_8$ têm tamanho 2 e se cancelam exatamente em $\sum_{x \notin V_8} (-1)^{f(x) + u\cdot x}$ módulo simetrias quando decompostas! Mais forte ainda: **Teorema de Hou-Langevin / Carlet sobre funções bent rotacionalmente simétricas em $n=2m$**: para $u \in V_8$, as somas sobre $x \notin V_8$ agrupam-se sob a involução $x \mapsto \rho^8(x)$? Não apenas pares de tamanho 2, mas sob o grupo $\langle \rho^2 \rangle$ ou $\langle \rho^8 \rangle$: se uma órbita de $x$ sob um $2$-grupo $G$ não é fixa e $u$ é $G$-invariante, $\sum_{y \in G\cdot x} (-1)^{f(y)+u\cdot y} = |G\cdot x| (-1)^{f(x)+u\cdot x}$, logo:
     $$\sum_{x \in \mathbb{F}_2^{16}} (-1)^{f(x) + u \cdot x} \equiv \sum_{x \in \text{Fix}(G)} (-1)^{f(x) + u \cdot x} \pmod{2 \text{ (e potências superiores via Burnside!)}}$$
     Aplicando o **Lema de Burnside p-ádico (identidade de congruência de órbitas para $G = \langle \rho^8 \rangle \cong \mathbb{Z}_2$, $G = \langle \rho^4 \rangle \cong \mathbb{Z}_4$, $G = \langle \rho^2 \rangle \cong \mathbb{Z}_8$, $G = \langle \rho \rangle \cong \mathbb{Z}_{16}$)**:
     Para $u \in V_8$ ($u_{i+8}=u_i$, logo $2^8 = 256$ frequências!), toda órbita de $\langle \rho^8 \rangle$ fora de $V_8$ tem tamanho 2, mas sob $\langle \rho \rangle$ em $u=0$: já usaram T20/T28 em $u=0$! Aplicar exatamente a **mesma decomposição de Burnside de T20/T28 para $u \in V_8 \setminus \{0\}$** (especialmente $u = e_0 + e_8 \in V_8$, invariante por $\rho^8$, e $u = e_0 + e_4 + e_8 + e_{12} \in V_4$, invariante por $\rho^4$, e $u = e_0 + e_2 + \dots + e_{14} \in V_2$, invariante por $\rho^2$!).
   * **Este é o ponto mais letal de toda a teoria HRSBF em $n=16$:**
     1. Para $u^{(2)} = (1,0,1,0,\dots,1,0)$ (período 2, peso 8, invariante por $\rho^2$, grupo de ordem **8**!), $\langle \rho^2 \rangle$ age preservando $f(x) + u^{(2)}\cdot x$! Pelo Lema de Burnside, a soma em $\mathbb{F}_2^{16}$ módulo $16$ e módulo $256$ reduz-se às órbitas curtas de $\langle \rho^2 \rangle$ ($V_2$ de dimensão 2, $V_4$ de dimensão 4, $V_8$ de dimensão 8)! Isso gera leis algébricas **lineares e quadráticas** (análogas a C1..C5 de T20!) diretamente para $|W_f(u^{(2)})| = 256$!
     2. Para $u^{(4)} = e_0 + e_4 + e_8 + e_{12}$ (período 4, invariante por $\rho^4$, grupo de ordem **4**), $\langle \rho^4 \rangle$ preserva $f(x) + u^{(4)}\cdot x$, gerando novas leis lineares/quadráticas sobre os coeficientes $c_i$!
     3. Para $u^{(8)} = e_0 + e_8$ (período 8, invariante por $\rho^8$, grupo de ordem **2**), $\langle \rho^8 \rangle$ preserva $f(x) + u^{(8)}\cdot x$, reduzindo $W_f(e_0 + e_8) \bmod 512$ a uma integral sobre $V_8$ (apenas 256 pontos!) mais correções de pares!

3. **Pipeline Computacional Imediato (Ordem de Execução):**
   * **Passo 1 (Auditoria Instantânea nos 16 ou 89.888 vetores já gerados):** Avaliar apenas $W_f(u^{(2)})$, $W_f(u^{(4)})$ e $W_f(e_0 + e_8)$. Como $u^{(2)}$ tem estabilizador de ordem 8, $W_f(u^{(2)})$ pode ser calculado sem FWHT de $65.536$, somando apenas sobre representantes das órbitas de $\langle \rho^2 \rangle$ ($\approx 8.220$ órbitas em vez de $65.536$ pontos).
   * **Passo 2 (Extração Simbólica de T20/T28 nos pontos periódicos $u^{(2)}, u^{(4)}, u^{(8)}$):** Replicar o gerador algébrico que produziu C1..C7 (em $u=0$) para $u = u^{(2)}$ ($\text{Stab} = \langle \rho^2 \rangle$, ordem 8) e $u = u^{(4)}$ ($\text{Stab} = \langle \rho^4 \rangle$, ordem 4). Como $c_{99} = (0,2,8,10)$ está **inteiramente contido nos índices pares**, em $u^{(2)}$ o produto escalar $u^{(2)} \cdot x = x_0 \oplus x_2 \oplus \dots \oplus x_{14}$ acopla-se de forma assimétrica máxima com $\mathcal{O}_{99}$. Isso produzirá novas equações algébricas exatas sobre $c_1, \dots, c_{112}$ (reduzindo a dimensão livre de 109 por várias dezenas de equações lineares/baixa ordem ou provando inconsistência imediata do ramo $c_{99}=1$ sobre $\mathbb{F}_2$).
   * **Passo 3 (Filtro em Cascata no Kernel de Alta Vazão, caso o sistema algébrico sobreviva):** Nunca mais parar o filtro em $(W_f(0), W_f(e_0))$. No avaliador bitwise de 65.536 pontos, acumular em um único passe (usando *popcount* / registradores AVX-512 ou words de 64 bits das fatias $(x_0, x_1)$ e $(x_0, x_8)$) a quádrupla $(S_{00}, S_{01}, S_{10}, S_{11})$. Isso fornece **$W_f(0)$, $W_f(e_0)$ e $W_f(e_0+e_1)$ a custo computacional zero adicional** (mesma passagem de memória!), reduzindo os falsos positivos do interior em pelo menos duas ordens de grandeza antes de qualquer FWHT completo.