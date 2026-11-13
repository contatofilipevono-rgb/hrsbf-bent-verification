# Certificado independente de catálogo para o plano comum de momentos de fase em $V_1$ ($n=12$, grau $4$)

## 1. Resumo executivo

A partir exclusivamente do modelo do bloco $V_1 = \langle 7, 14, 28, 56 \rangle$ (`dim4_support_decode.decode(1)`) e das equações de suporte sobre as fibras, certificamos que **todas as 19 direções de fase nos 48 momentos $(1, s_1, s_2)$ caem identicamente no plano**
$$L = \langle \mathtt{0x084006c00810},\; \mathtt{0x106002400c20} \rangle \subset \mathbb{F}_2^{48},$$
sem depender do catálogo `mapas_V1.txt`.

- **Classes fechadas por identidade polinomial em $\mathbb{F}_2$:** **14 de 14** (`0, 1, 22, 23, 36, 37, 50, 51, 128, 129, 164, 165, 178, 179`, divididas em **10 órbitas** pela simetria do modelo).
- **Classes que necessitam enumeração residual:** **0 de 14**.
- **Controle pós-hoc:** os 113.040 códigos de `mapas_V1.txt` (`sha256: 8d0eeebfd9cde035757047f220218098b697511c176614538f871c0a0a8ad7ea`) caem integralmente nas 14 cartas certificadas, com $H(u) = c_4$, $Q_c(u) = 0$ e colunas de fase contidas em $L$.

---

## 2. Reconstrução do modelo e filtragem das cartas (Etapa 0)

A decodificação `model, basis, labels = decode(1)` produz uma base linear com **33 parâmetros** ($u_0,\dots,u_{24}$ formando os 25 parâmetros baixos, e $c_0,\dots,c_7$ formando a carta de 8 bits `chart = code >> 25`):
- Os vetores `basis[0..24]` têm dependência nula em $(s_1, s_2)$ para todo $z \in \{0,\dots,63\}$.
- Os vetores de carta `basis[25..32]` satisfazem $D_{s_1} D_{s_2} T = 0$, i.e., cada fibra quadridimensional depende de $(s_1, s_2)$ de forma estritamente afim sobre $\mathbb{F}_2^2$.

Separando exatamente as hipóteses sobre as cartas em $\mathbb{F}_2^8$ ($256$ cartas):
1. **Ortogonalidade a $\mathrm{RM}(2,8)$ em grau $\le 2$ com máscaras puras em $z$ (`65` equações puramente na carta):**
   Como $\sum_{s_1,s_2} s_a s_b$ só retém o termo cruzado $s_1 s_2$, as equações de `indicator_products(0, basis, out_mask, [dom_mask])` com $\mathrm{wt}(\text{out\_mask}) \le 2$ e `dom_mask` puramente em $z$ eliminam toda dependência em $u_0,\dots,u_{24}$ e reduzem exatamente as $256$ cartas ao subespaço $C_{L_3}$ de **$32$ cartas colineares**, definido pelas paridades
   $$\text{paridades}(C_{L_3}) = [26,\; 60,\; 64], \qquad \text{base}(C_{L_3}) = [1,\; 14,\; 22,\; 36,\; 128].$$
2. **Acoplamento $\mathrm{RM}(2,8)$ de grau $\le 2$ com $u_0,\dots,u_{24}$ (`reduce_phase(..., 3)`):**
   Elimina $4$ cartas (`60, 61, 150, 151`), restando **$28$ cartas RM-válidas**.
3. **Somas de caracteres (`character_sums`):**
   Eliminam as $14$ cartas não-catálogo RM-válidas (`14, 15, 24, 25, 42, 43, 142, 143, 152, 153, 170, 171, 188, 189`), deixando exclusivamente as **$14$ cartas admissíveis**:
   $$[0,\; 1,\; 22,\; 23,\; 36,\; 37,\; 50,\; 51,\; 128,\; 129,\; 164,\; 165,\; 178,\; 179].$$
4. **Simetrias de coordenadas/rotação (`code_actions(model)`):**
   Agem internamente sobre os bits altos sem vazamento dos 25 bits baixos (`low_to_chart = False`), particionando as 14 cartas em **10 órbitas**: `[0], [1], [22], [23], [36, 50], [37, 51], [128], [129], [164, 178], [165, 179]`.

*(Observação adicional: mesmo **sem** `character_sums`, exigir $|F_t| \equiv 0 \pmod 8$ em todas as 16 fibras já elimina os sobreviventes de `RM(2,8)` em todas as 14 cartas não-catálogo.)*

---

## 3. Redução polinomial exata sobre $C_{L_3} \times \mathbb{F}_2^{25}$ (Etapa 1)

Sem aplicar **nenhuma** hipótese de suporte além da estrutura do modelo restrita a $C_{L_3}$, calculamos exatamente em $\mathbb{F}_2[u_0,\dots,u_{24}]$ a forma normal algébrica (ANF, grau $\le 4$) de todas as $19$ colunas de fase contra os $46$ vetores da base sistemática de $L^\perp$ (`stage1_exact_anf_over_cl3`, cobrindo $2^{30}$ mapas sem amostragem):

- **$16$ das $19$ fases** pertencem identicamente a $L$. Apenas as fases `[6, 7, 13]` escapam fora de $L$.
- **$38$ das $46$ equações de $L^\perp$** anulam-se identicamente em todo $C_{L_3} \times \mathbb{F}_2^{25}$.
- Todas as $3 \times 8$ projeções restantes (`l_perp_basis()` índices `[7, 8, 13, 20, 29, 34, 40, 41]`, com vetor característico $\mathtt{0x030420102180}$) coincidem com um único polinômio de grau $2$:
  $$Q_c(u) = u_{24}\,\big(1 \oplus c_4 \oplus u_1 \oplus S(u)\big),$$
  onde $c_4 = (c \gg 4) \& 1$ e
  $$S(u) := u_{11} \oplus u_{13} \oplus u_{16} \oplus u_{19} \oplus u_{22} \oplus u_{23}, \qquad H(u) := S(u) \oplus u_{24}.$$

---

## 4. Identidade exata na fibra $F_{15}$ e certificados por classe (Etapa 2)

Defina $\mathrm{bit}_1(N) = (N \gg 1)\&1$ e $\mathrm{bit}_2(N) = (N \gg 2)\&1$. Sobre qualquer mapa de $C_{L_3} \times \mathbb{F}_2^{25}$ (e em particular verificado de forma exaustiva nos $2^{24}$ mapas do hiperplano $H(u)=c_4$ em cada uma das 14 cartas):

1. $\mathrm{bit}_1(|F_{15}|) \equiv 0$ (isto é, $|F_{15}| \equiv 0 \pmod 4$, porque em cada $z \in \{0,\dots,63\}$ a multiplicidade da projeção colinear é $0, 2$ ou $4$ — e para $\mathrm{bit}_1$ soma módulo $2$ de pares anula a contribuição linear).
2. Vale a identidade exata sem termo residual:
   $$Q_c(u) \oplus \mathrm{bit}_2(|F_{15}(u)|) \oplus \langle \mathbf{1}_{F_{15}(u)},\, z_0 s_1 \rangle \equiv H(u) \oplus c_4.$$

Em cada uma das **14 cartas**, uma **única** equação de momentos de `RM(2,8)` de grau $2$ (`indicator_products`, com uma única máscara de saída de peso $2$ e um único monômio de domínio de grau $2$) força diretamente a relação linear **$H(u) = c_4$**:

| Cartas (`chart`) | $c_4$ | $1 \oplus c_4$ | Máscara de saída (`out_mask`) | Monômio de domínio | Equação certificada |
|---|---:|---:|---:|---|---|
| `0, 1` | `0` | `1` | `3` | `s1*s2` | $H(u) = 0$ |
| `22, 23` | `1` | `0` | `6` | `z0*s1` | $H(u) = 1$ |
| `36, 37, 128, 129` | `0` | `1` | `3` | `z0*s1` | $H(u) = 0$ |
| `50, 51, 178, 179` | `1` | `0` | `6` | `z0*s2` | $H(u) = 1$ |
| `164, 165` | `0` | `1` | `3` | `z1*s1` | $H(u) = 0$ |

Substituindo $H(u) = c_4$ na identidade da Etapa 2, segue imediatamente em todas as 14 classes:
$$Q_c(u) = \mathrm{bit}_2(|F_{15}(u)|) \oplus \langle \mathbf{1}_{F_{15}(u)},\, z_0 s_1 \rangle.$$
Como:
- a ortogonalidade de $F_{15}$ a $\mathrm{RM}(2,8)$ (momento de grau $2$ em $z_0 s_1$ no indicador de grau $4$) anula $\langle \mathbf{1}_{F_{15}}, z_0 s_1 \rangle = 0$; e
- a condição de tamanho $|F_{15}| \equiv 0 \pmod 8$ (em particular $|F_{15}| = 16$) anula $\mathrm{bit}_2(|F_{15}|) = 0$;

obtém-se **$Q_c(u) = 0$ em todas as 14/14 classes por identidade algébrica direta**.

### Fechamentos mais fortes na Classe `0`
Na carta `0` (`c = 0`), como as derivadas de carta $(d_1, d_2)$ são identicamente nulas, o indicador de $F_{15}$ é constante em $(s_1, s_2)$ em cada $z$, logo $\mathrm{bit}_2(|F_{15}|) \equiv \langle \mathbf{1}_{F_{15}}, s_1 s_2 \rangle$ identicamente:
1. **Apenas `RM(2,8)` (sem `|Ft| % 8 == 0` nem `character_sums`):** `H(u)=0`, $\langle \mathbf{1}_{F_{15}}, s_1 s_2 \rangle = 0$ e $\langle \mathbf{1}_{F_{15}}, z_0 s_1 \rangle = 0$ já bastam para forçar $Q_0(u) = 0$.
2. **`RM(2,8)` + `character_sums` (sem `|Ft| % 8 == 0`):** a redução linear `reduce_phase` já fixa $u_{24} = 0$, anulando $Q_0(u)$ linearmente.

---

## 5. Origem intrínseca das hipóteses de fibra (Parseval / coset de codimensão 2)

Escrevendo a função booleana em $\mathbb{F}_2^8 \times V_1$ ($V_1 \cong \mathbb{F}_2^4$) como $f(x, y) = g(x) \oplus \langle T(x), y \rangle$ com $x \in \mathbb{F}_2^8$ e $y \in \mathbb{F}_2^4$, a transformada de Walsh em $(\alpha, t) \in \mathbb{F}_2^8 \times \mathbb{F}_2^4$ reduz-se às fibras $F_t = \{x \in \mathbb{F}_2^8 : T(x) = t\}$:
$$W_f(\alpha, t) = 16 \sum_{x \in F_t} (-1)^{g(x) \oplus \langle \alpha, x \rangle}.$$
Como $f$ é bent em $n=12$, tem-se $W_f(\alpha, t) \in \{\pm 64\}$, logo $\widetilde{W}_t(\alpha) := \sum_{x \in F_t} (-1)^{g(x)\oplus \langle \alpha, x \rangle} \in \{\pm 4\}$ para todos $(\alpha, t)$:

1. **Tamanho $|F_t| = 16$ (e $|F_t| \equiv 0 \pmod 8$) via Parseval em $\mathbb{F}_2^8$:**
   $$256\,|F_t| = \sum_{\alpha \in \mathbb{F}_2^8} \widetilde{W}_t(\alpha)^2 = 256 \cdot 4^2 = 256 \cdot 16 \implies |F_t| = 16.$$
2. **Ortogonalidade $\mathbf{1}_{F_t} \perp \mathrm{RM}(2,8)$ via média em subespaços afins de codimensão 2:**
   Para qualquer subespaço afim $A \subset \mathbb{F}_2^8$ de codimensão 2 definido por duas formas lineares distintas $\alpha_1, \alpha_2$ e $x_0 \in A$, seja $U = \{0, \alpha_1, \alpha_2, \alpha_1 \oplus \alpha_2\}$. Então
   $$4 \sum_{x \in F_t \cap A} (-1)^{g(x)} = \sum_{u \in U} (-1)^{\langle u, x_0 \rangle} \widetilde{W}_t(u) \implies \sum_{x \in F_t \cap A} (-1)^{g(x)} = \sum_{j=1}^4 (\pm 1) \equiv 0 \pmod 2.$$
   Logo $|F_t \cap A| \equiv 0 \pmod 2$ para todo subespaço afim $A$ de codimensão 2. Como todo monômio $x_i x_j$, $x_i$ e $1$ em $\mathbb{F}_2[x_0,\dots,x_7]$ é soma (mod 2) de indicadores de tais subespaços, resulta $\langle \mathbf{1}_{F_t}, m \rangle = 0$ para todo $m \in \mathrm{RM}(2,8)$.
3. **Papel do grau total ($\deg f \le 4$) e simetria rotacional:** o grau $\le 4$ limita o suporte a $33$ parâmetros em $V_1$ (`decode(1)`), e as identidades rotacionais adicionam `character_sums`, restringindo $C_{L_3}$ às 14 cartas do catálogo.

*(Nota sobre o fluxo com `gemini-4-carbon`: na chamada Vertex AI `LOW` exploratória observou-se referência incorreta a $\mathbb{F}_2^{16}$ e $\deg T_i \le 2$; o rascunho `HIGH` e a demonstração acima operam integralmente no regime real $n=12$, $V_1 \cong \mathbb{F}_2^4$, $W_f = \pm 64$.)*

---

## 6. Separação de hipóteses e contraexemplos preservados

| Relaxação | Hipóteses preservadas | Hipótese violada | Falha $L$? | Testemunhas decodificáveis (hex de 33 bits) |
|---|---|---|---|---|
| `R1_outside_CL3` | Apenas modelo `decode(1)` | $C_{L_3}$ (`RM` puro em $z$) | Sim | `0x04000000` (carta `2`) |
| `R2_no_RM` | $C_{L_3}$ + `character_sums == 0` exato + $\|F_t\|=16\ \forall t$ | `RM(2,8)` | Sim (`0` falhas só em `0`) | `0x039c593e` (`1`), `0x1037b6bc6` (`129`), `0x149604002` (`164`) |
| `R3_no_char_sums_single_F15_mod8_only` | $C_{L_3}$ + `100% RM(2,8)` + $\|F_{15}\|\equiv 0\pmod 8$ | `character_sums` exato e $\|F_{t\neq 15}\|\equiv 0\pmod 8$ | Sim | `0x1d480124` (carta `14`, tamanhos `[16,24,12,24,12,12,12,24,24,12,12,12,24,12,24,0]`) |
| `R3_alt_all_Ft_mod8` | $C_{L_3}$ + `100% RM(2,8)` + $\|F_t\|\equiv 0\pmod 8\ \forall t$ | `character_sums` | Não (`0` sobreviventes) | Nenhuma nas 14 cartas RM não-catálogo |
| `R4_no_mod8` | $C_{L_3}$ + `100% RM(2,8)` + envolvimento afim de `character_sums` (`affine_consequences`) | $\|F_{15}\| \equiv 0 \pmod 8$ (e partes não-lineares de `character_sums`) | Sim em 13/14 cartas (`0` fecha) | `0x0300080e` (`1`), `0x2d80304e` (`22`), `0x2f106812` (`23`), `0x4980c003` (`36`), `0x4b505057` (`37`), `0x65401873` (`50`), `0x6740e01e` (`51`), `0x101801012` (`128`), `0x103d0204f` (`129`), `0x149902802` (`164`), `0x14b50684a` (`165`), `0x16532d003` (`178`), `0x167d00003` (`179`) |

*Observação estrutural:* quando se impõem simultaneamente **100% `RM(2,8)`** e **todas as equações exatas (incluindo as não-lineares) de `character_sums == 0`**, o sistema conjunto já reproduz exatamente os **113.040** códigos do catálogo (`0` falhas em $L$ nas 14 cartas, mesmo sem impor $|F_t|=16$ à parte); inversamente, o certificado da **Etapa 2** evita resolver essas somas não-lineares usando apenas o envolvimento afim (`Stage 0`) e uma única condição de tamanho mod 8 na fibra $F_{15}$ (`|F15| % 8 == 0`, garantida por Parseval).

---

## 7. Verificação executável e controle por catálogo

Os artefatos executáveis deste certificado ficam em `research_updates/2026_11_09_n12_mixed/class129/`:
- **Verificador autônomo:** `certify_v1_common_phase_plane.py`
  - `--all --negative-test`: executa Etapa 0 (`256 -> 32 -> 28 -> 14`, 10 órbitas), Etapa 1 ANF exata em $C_{L_3}\times\mathbb{F}_2^{25}$, Etapa 2 exaustiva em $2^{24}$ mapas para todas as 14 cartas do catálogo, auditoria completa das 14 cartas RM não-catálogo, checagem das testemunhas de relaxação e testes negativos (detecção de adulteração de $L$, de $H(u)$ e de $z_0 s_1$).
  - `--chart <c>`: fatia independente por carta $c \in \{0,\dots,255\}$.
  - `--catalog <caminho/mapas_V1.txt>`: controle pós-hoc sobre os 113.040 códigos do catálogo.
- **Agregador de cobertura:** `aggregate_v1_plane_coverage.py`
  - Confere partição disjunta das **256** cartas, **0** sobreviventes, **0** testemunhas de falha e contagem **14/14** fechadas por identidade (`0` em enumeração residual).
- **Workflow GitHub Actions:** `.github/workflows/n12_v1_common_phase_plane.yml`
  - Matriz limitada a `max-parallel: 14` ($\le 32$ CPUs) sobre todas as 28 cartas RM-válidas, seguida do job agregador que fecha as 256 cartas e valida Etapa 1, testemunhas e testes negativos.
