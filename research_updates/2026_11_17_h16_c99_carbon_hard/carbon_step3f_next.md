Os dados empíricos que você acabou de obter são ouro puro e expõem exatamente a anatomia do gargalo:

1. **Por que o Modo C matou o CaDiCaL e o CMS5:** Arvores CSA de $N=1024$ com alvo exato $512$ destroem a propagação unitária (UP). Como $512$ é o centro binomial, você precisa decidir quase todas as $1024$ folhas antes que os *carries* do topo gerem conflito. Além disso, o custo por conflito explode porque o solver visita milhares de cláusulas ternárias de *full-adders* a cada *backtrack*, derrubando a taxa para ridículos $\sim 80$ conflitos/s.
2. **Por que o Modo A voa ($1.53\text{s}$ no Cubo 0):** Polinômios ANF esparsos sobre $\mathbb{F}_2$ e CSAs pequenos ($\le 256$ bits) propagam instantaneamente quando algumas variáveis são fixadas.

Aqui está o diagnóstico exato para **(A), (B) e (C)** e o plano concreto para fechar `c99 = 1`.

---

### A) Como extrair MUITO MAIS equações polinomiais de grau $\le 3$ sobre $\mathbb{F}_2$ (Sem tocar em CSA $\ge 1024$)

O motivo pelo qual `0x3f3f`, `0x5f5f`, `0x6f6f` geraram equações polinomiais limpas é o **Teorema de Lucas / Teorema de McEliece (2-adic valuation do peso de Hamming)**:

Para qualquer função Booleana $g: \mathbb{F}_2^d \to \mathbb{F}_2$ de grau algébrico $\deg(g) \le r$, o peso de Hamming satisfaz:
$$\text{wt}(g) \equiv 0 \pmod{2^{\lceil d/r \rceil - 1}} \quad \text{(e para derivadas / restrições estruturadas, bits de } \text{wt}(g) \text{ são polinômios simétricos nos coeficientes ANF!)}$$

Mais especificamente, sobre $\mathbb{F}_2$, se avaliamos o peso de $f$ restrita a qualquer subespaço afim $a + U$ de dimensão $d$:
$$\text{wt}(f|_{a+U}) = \sum_{x \in a+U} f(x) \in \mathbb{Z}$$
Escrevendo cada $f(x) \in \{0,1\}$ como polinômio linear nos coeficientes livres $c_1, \dots, c_m$:
- O bit $2^0$ de $\text{wt}(f|_{a+U})$ é $\sigma_1$ (soma XOR = grau $\le 1$ nos $c_i$ — só não é zero se $\deg(f|_U) = d$).
- O bit $2^1$ é $\sigma_2\big((f(x))_{x \in a+U}\big) \pmod 2 \implies$ **polinômio quadrático exato** ($\deg \le 2$) nos $c_i$!
- O bit $2^2$ (quando $\sigma_1 = \sigma_2 = 0$ no subespaço, o que é garantido por McEliece sempre que $d > 2\deg(f|_U)$!) é $\sigma_4 \pmod 2$, e quando há pareamento por derivada nula ou simetria, **cai para grau 2 ou 3**!

**Onde estão as equações que você ainda NÃO extraiu:**

1. **Órbita completa sob o estabilizador do seu ansatz em $GL(16,2)$ (ou $S_8 \times S_2 / S_{16}$):**
   Você usou apenas `0x3f3f`, `0x5f5f`, `0x6f6f` (3 máscaras de peso 12 com estrutura $(6,6)$ nos dois bytes!).
   - Quantas máscaras de estrutura $(6,6)$ existem? $\binom{8}{6} \times \binom{8}{6} = 28 \times 28 = \mathbf{784}$ máscaras (ou $\binom{8}{2}=28$ se pareadas simetricamente como `0x3f3f`, `0x5f5f`, `0x6f6f`, `0x7777`, `0x7b7b`, `0x7d7d`, `0x7e7e`, `0xafaf`, `0xb7b7`, ...)! Você usou **apenas 3 de 28** (ou de 784)!
   - Mesmo que $f$ tenha simetrias parciais já embutidas na parametrização $K=1$, ao fixar `c99 = 1` (que quebra simetria ou seleciona um setor), aplicar **todas as permutações de coordenadas / transformações lineares que preservam a condição de bentness** aos polinômios de `0x3f3f` e `C6` gera dezenas/centenas de polinômios novos de grau $\le 3$ linearmente independentes!

2. **Os bits 2-ádicos dos próprios cosets que travaram o Modo C (Substituir CSA-1024 por Polinômios de Grau 2 e 3!):**
   Veja por que o Modo C travou: você pediu `wt == 512` em um coset de 1024 bits usando somadores inteiros.
   Mas `wt == 512` em $1024$ bits implica aritmeticamente:
   $$\text{wt} \equiv 0 \pmod{512} \implies b_0 = 0,\; b_1 = 0,\; b_2 = 0,\; b_3 = 0,\; \dots,\; b_8 = 0,\; b_9 = 1$$
   Em vez de montar uma árvore CSA de 1024 folhas:
   - Restrinja $D_a f$ a subespaços $W$ de dimensão $d \in \{10, 11, 12\}$ onde a condição de bent/Walsh ou decomposição em subespaços exige $\text{wt}(D_a f|_W) \equiv 0 \pmod{2^k}$ (pela relação de Parseval/Poisson: $\sum_{u \in W^\perp} W_f(u) = 2^d (\dots)$, como todo $W_f(u) = \pm 2^8$, a soma de $2^{16-d}$ sinais $\pm 1$ determina $\text{wt}(f|_W)$ módulo $2^{8 - (16-d) + 1} = 2^{d-7}$ **EXATAMENTE**!).
   - **Pare e leia essa identidade (Fórmula de Poisson para funções Bent em $n=16$):**
     Para **QUALQUER** subespaço afim $y + W$ de dimensão $d \ge 8$:
     $$2^d - 2\,\text{wt}(f|_{y+W}) = \sum_{x \in y+W} (-1)^{f(x)} = \frac{1}{2^{16-d}} \sum_{u \in W^\perp} (-1)^{\langle u, y \rangle} W_f(u)$$
     Como $f$ é bent, $W_f(u) = 2^8 (-1)^{f^*(u)}$. Logo:
     $$\text{wt}(f|_{y+W}) = 2^{d-1} - 2^{d-9} \sum_{u \in W^\perp} (-1)^{\langle u, y \rangle + f^*(u)}$$
     Olhe o expoente $2^{d-9}$ (e note que uma soma de números ímpares $\pm 1$ de tamanho par $2^{16-d}$ ainda tem divisibilidade extra!):
     - Para **$d = 10$**: $\text{wt}(f|_{y+W})$ é múltiplo de $2^2 = 4$ (e $\text{wt}/4 \bmod 2$ depende da soma de 64 sinais $\implies$ congruência exata módulo 8!).
     - Para **$d = 12$** (como `0x3f3f`, que tem peso 12!): $W^\perp$ tem dimensão $4$ ($16$ elementos). A soma de $16$ sinais $\pm 1$ de uma função $g$ em $\mathbb{F}_2^4$:
       - É sempre $\equiv 16 - 2\,\text{wt}(g) \pmod{32}$.
       - Se sabemos que $\deg(f^*) \le 8$ (na verdade, para $n=16$, $\deg(f) \le 8 \implies \deg(f^*) \le 8$, e em subespaços de dim 4 toda função tem peso par a menos que tenha grau 4!), obtemos bits **exatos** de $\text{wt}(f|_{y+W})$ para **QUALQUER** subespaço $W$ de dimensão $11, 12, 13, 14$!
   - **Tradução direta:** `0x3f3f`, `0x5f5f`, `0x6f6f` não são mágicos isolados — **QUALQUER subespaço linear $W \subset \mathbb{F}_2^{16}$ de dimensão 12 ou 13** gera equações polinomiais de grau $\le 3$ sobre $\mathbb{F}_2$ via Poisson + Lucas! Existem milhares desses subespaços; você só usou 3!

---

### B) Atacar pelo outro lado: Cube-and-Conquer no Modo A + Filtro Nativo C em $D_a f$

Antes mesmo de rodar Macaulay grau 4, olhe para o número que você já tem na mão:
> **Modo A resolve o Cubo 0 em 1.53 segundos!**

Quantos cubos existem na sua decomposição atual? E o Modo A deu `UNSAT` em `1.53s` no Cubo 0 (ou encontrou poucos candidatos)?

1. **Se o Modo A deu UNSAT em 1.53s no Cubo 0:**
   Você **NÃO PRECISA** do Modo C! Os cosets de 1024 bits só desaceleraram o solver em $>60\times$!
   - Com **Cube-and-Conquer (March_cu ou cubagem estática nas variáveis de maior atividade VSIDS do Modo A)**: se cada cubo leva $\sim 1.5\text{s}$ no CaDiCaL em 1 core, em uma máquina de **64 vCPUs** você varre **2.500 cubos por minuto** ($150.000$ cubos/hora).
   - E se um cubo do Modo A der `SAT`? Aí sim você testa a solução inteira em **1 nanossegundo** em C verificando a Fast Walsh-Hadamard Transform (FWHT de $2^{16}$ leva $0.05\text{ms}$!) ou adiciona cláusula de bloqueio se falhar nos cosets de 1024 bits (**CEGAR / Lazy Constraint**: nunca coloque CSA de 1024 bits dentro do CNF; cheque `wt == 512` em C num callback `ExternalPropagator` / `IPASIR-UP` do CaDiCaL 1.9.5 apenas quando uma atribuição completa ou parcial for atingida!).

2. **Decomposição em 4 subfunções de 14 bits ou 16 subfunções de 12 bits (Concatenação de Maiorana-McFarland / Rothaus):**
   Uma função bent em 16 variáveis restrita aos 4 cosets de um subespaço de codimensão 2 ($f_{00}, f_{01}, f_{10}, f_{11}$ em 14 variáveis, por exemplo fixando os 2 bits onde `c99` atua fortemente) satisfaz o **Teorema das 4 subfunções de Canteaut-Charpin**:
   $$W_{f_{00}}(u)^2 + W_{f_{01}}(u)^2 + W_{f_{10}}(u)^2 + W_{f_{11}}(u)^2 = 4 \cdot 2^{16} = 2^{18}$$
   e no domínio primal:
   $$D_a f_{00} \oplus D_a f_{01} \oplus D_a f_{10} \oplus D_a f_{11} = D_{(a,0,0)} \text{ da derivada mista de ordem 3!}$$
   Mais importante ainda: você descobriu que $\text{rank}(D_{\text{0xffff}} f) = 32$!
   - Isso significa que spoofing/projeção em $D_{\text{0xffff}} f$ depende de **apenas 32 combinações lineares independentes** ($z_1, \dots, z_{32}$) das variáveis livres!
   - E $\text{rank}(D_{\text{0x5555}} f) = 57$. Qual é o posto de $D_a f$ para outros vetores $a$ de peso alto ou simétricos (`0x3333`, `0x0f0f`, `0x00ff`, `0xffff ^ 0x0001`, etc.)?
   - Se existirem **dois ou três** vetores $a_1, a_2, a_3$ (ex: `0xffff`, `0xff00`, `0xf0f0`, `0xcccc`, `0xaaaa`) cada um com posto $\le 32$, você pode pré-filtrar ou acoplar os subespaços de dimensão $\le 32$ via **Meet-in-the-Middle / Join de tabelas de bits**, mas **26.8% de taxa de acerto** por derivada mostra que uma única derivada $D_a f$ filtra apenas $\sim 1.9$ bits de informação ($\log_2(1/0.268) \approx 1.9$ bits!).
   - **Conclusão crucial sobre $D_a f$ em C:** Varrer $2^{32}$ estados de `wt(D_a f) == 32768` é uma armadilha probabilística porque $\binom{65536}{32768}/2^{65536}$ concentrado num espaço de funções pares dá $O(1)$ de probabilidade ($\sim 26.8\%$). Ou seja, `wt(D_a f) == 32768` remove apenas ~1.9 bits! Já **uma única equação polinomial sobre $\mathbb{F}_2$** remove **exatamente 1 bit** com custo **zero** de árvore de soma e propaga algebricamente!

---

### C) Qual é o algoritmo EXATO que fecha `c99 = 1` com certeza (GitHub Actions ou 64 vCPUs GCP)

Não gaste vCPUs em busca cega de derivadas nem em CSA de 1024 bits. Faça esta sequência exata de **3 passos** (os Passos 1 e 2 rodam em minutos até no GitHub Actions; o Passo 3 escala linearmente em 64 vCPUs no GCP se sobrar algum cubo):

#### Passo 1: Gerador Automático de Polinômios Poisson-Lucas (Grau $\le 3$)
Escreva um script C/C++ rápido (usando bitsets de `uint64_t` para os monômios até grau 3 nas $m$ variáveis livres pós-$K=1, L_{\text{coset}}=1$):
1. Tome **todas as 28 máscaras simétricas $(6,6)$** (generalizando `0x3f3f, 0x5f5f, 0x6f6f`), mais as máscaras $(5,7)$ e $(4,8)$ de peso 12 e 13 (ex: `0x7f1f`, `0xff0f`, etc. — cerca de 200 a 500 subespaços $W$ de dimensão 12 e 13).
2. Para cada subespaço $W$, avalie simbolicamente o bit de Lucas ($\sigma_2$ ou $\sigma_4$ reduzido nos coeficientes livres) exatamente pelo mesmo extrator algébrico que gerou `0x3f3f` e `C6` (cuidando para **não** ter o bug de `const_shift`: valide cada polinômio gerado contra 10 funções bent conhecidas de $n=16$, ex: Maiorana-McFarland / Dillon, garantindo $P(f_{\text{bent}}) = 0$ em 100% delas!).
3. Jogue todos os polinômios gerados numa matriz sobre $\mathbb{F}_2$ (colunas = monômios de grau $\le 3$: $1 + m + \binom{m}{2} + \binom{m}{3}$).
   - Para $m \approx 60\text{--}80$, $\binom{m}{\le 3} \approx 35.000\text{--}85.000$ colunas!
   - **M4RI (`mzd_echelonize`) reduz uma matriz densa de $50.000 \times 85.000$ sobre $\mathbb{F}_2$ em menos de 4 segundos em 1 core!**

#### Passo 2: Macaulay Grau 3 + Grau 4 Parcial com `M4RI`
Com essa base expandida $\{P_i\}$ de centenas de equações de grau $\le 3$ (em vez de apenas 4 polinômios!):
1. Multiplique todas as equações de grau 2 por monômios de grau $\le 2$ e as de grau 3 por monômios de grau $1$ $\implies$ **Macaulay de Grau 4**.
2. Número de monômios de grau $\le 4$:
   - Se $m \le 65$ (após eliminar variáveis lineares de $K=1$ e $L_{\text{coset}}$): $\binom{65}{\le 4} = 721.826$ colunas ($\sim 90\text{ MB}$ por 1000 linhas em `M4RI`, ou use `spasm` / Gauss esparso por blocos em C++ consumindo $< 4\text{ GB}$ RAM).
3. Há dois desfechos possíveis na redução de Gauss:
   - **Desfecho 2A (Nocaute Algébrico):** Aparece a linha `1 = 0` com `c99 = 1` (prova algébrica instantânea de `UNSAT`!), ou surgem dezenas de **novas equações de grau 1 e 2** que colapsam $m$ de $\sim 65$ para $\le 35$.
   - **Desfecho 2B (Estabilização):** O ideal não contém `1` em grau 4, mas te entrega uma base reduzida de equações de grau 1, 2 e 3 muito mais forte que o Modo A atual.

#### Passo 3: Modo A Turbinado + CaDiCaL `IPASIR-UP` (Lazy Walsh/Coset Check) + Cube-and-Conquer (64 vCPUs)
Se o Passo 2 não der `1 = 0` direto:
1. Alimente o **Modo A** com as novas equações lineares/quadráticas/cúbicas reduzidas do Passo 2 (mantendo **ZERO** árvores CSA $\ge 1024$).
2. Acople ao **CaDiCaL 1.9.5** um verificador C via `CaDiCaL::ExternalPropagator` (são 60 linhas de C++!):
   - Só chame o callback quando o solver encontrar um modelo completo do Modo A (`notify_assignment` completo).
   - No callback em C, reconstrua a tabela-verdade de $65.536$ bits (em `uint64_t[1024]`), cheque `popcount` dos cosets de 1024 bits (`0x1`, `0x3`, `0x7`) em **2 microssegundos** via `__builtin_popcountll`, e rode a FWHT em **50 microssegundos**.
   - Se falhar, devolva uma cláusula de bloqueio (ou o *nogood* das variáveis que determinam o coset violado).
3. Gere $2^{10} = 1024$ a $2^{12} = 4096$ cubos usando `march_cu` (ou `cadical --lookahead`) no CNF do Modo A Turbinado e rode em paralelo em **64 vCPUs no GCP** (`c3d-highcpu-60` AMD Genoa AVX-512):
   - A $\le 1.5\text{s}$ por cubo (provavelmente $< 0.2\text{s}$ com as equações novas das outras 25 máscaras $(6,6)$), **4096 cubos fecham em menos de 100 segundos de relógio em 64 cores**.

---

### Resumo Executivo da Decisão Imediata

1. **Abandone imediatamente árvores CSA $\ge 1024$ no CNF** (elas são a única razão do timeout no Modo C). Se precisar das restrições de 1024 bits, cheque-as *lazy* em C fora do CNF quando o Modo A der `SAT`.
2. **Abandone varredura bruta de `wt(D_a f) == 32768`** (taxa de sobrevivência de $26.8\%$ é fraca demais para podar $2^{60+}$).
3. **Ação #1 agora mesmo no GitHub Actions:** Extraia os polinômios `no_chi` para **todas as outras 25 máscaras simétricas $(6,6)$** (irmãs exatas de `0x3f3f, 0x5f5f, 0x6f6f`, validadas contra funções bent conhecidas para evitar qualquer bug de constante) + rode eliminação Gaussiana `M4RI` em grau 3 (e grau 4 se $m \le 65$), e benchmarke o **Modo A + essas 25 irmãs** nos cubos! É altíssima a chance de o tempo por cubo cair de `1.53s` para milissegundos ou fechar algebricamente no `M4RI`.