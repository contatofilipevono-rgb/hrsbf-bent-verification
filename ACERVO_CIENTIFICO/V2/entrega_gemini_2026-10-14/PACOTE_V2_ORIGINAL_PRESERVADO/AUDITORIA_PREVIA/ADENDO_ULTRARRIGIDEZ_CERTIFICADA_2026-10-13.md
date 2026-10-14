# V2 — Auditoria independente da ultra-rigidez local e teorema corrigido

**Data de referência:** 2026-10-13. **Projeto:** `contatofilipevono-rgb/hrsbf-bent-verification`.

**Base congelada:** branch `v2-sol-audit-revisions-20261008`, commit `1a921c586903f4adf6cdb9c8668e7813f10512cb`.

**Isolamento:** este é um **adendo de pesquisa e auditoria**, não uma alteração automática do manuscrito original, da V1 ou da V3-C. O código Lean do relatório externo não foi recompilado nem confundido com a certificação computacional finita abaixo.

## 1. Resumo do estado

Uma enumeração independente e exata sobre GF(2), reconstruída diretamente da semente

`f = Orb_8(01) + Orb_8(0123) + Orb_8(0125) + Orb_8(0135)`, 

confirma os seguintes invariantes locais:

| Invariante | Resultado |
|---|---:|
| Monômios homogêneos de grau 4 | 24 |
| Posto/nulidade de `C_(D^4 f)` | 22 / 6 |
| Elementos não nulos no núcleo com posto 4 / 8 | 3 / 60 |
| Dimensão do centroid linear da forma quártica `D^4f` | 1 |
| `GL(4,2)` | 20.160 |
| Candidatos de primeira/segunda matriz `P` / `Q` preservando o núcleo | 360 / 360 |
| Pares `P,Q` compatíveis com o tensor de bidegrau (2,2) | 1.080 |
| Pares também solúveis no bidegrau (1,3) | 60 |
| Soluções completas por par após condição (0,4) | 32 |
| `|Aut(D^4f)|` | **1.920** |
| `|G_{<=2}(f)|` | **40** |
| Translações de entrada não nulas em `G_{<=2}(f)` | **0** |
| Estabilizadores de `e_0^*` e `e_0^*∧e_1^*` nesse grupo | **1 e 1** |

Os 40 membros de `G_{<=2}(f)` satisfazem exatamente `f(Ax)=f(x)`. Suas ordens distribuem-se em `{1:1,2:1,4:10,5:4,8:20,10:4}`. O deslocamento cíclico `σ` tem ordem 8; existe `p` de ordem 5 tal que `σpσ^{-1}=p^3`; portanto o grupo é `C5 ⋊ C8` (ação por 3 mod 5).

**Procedimento exaustivo:** Os três bivetores de posto 4 no núcleo de `C_phi` têm todos o mesmo radical `U=Fix(σ^4)` (dimensão 4); como o núcleo e o posto dos bivetores são invariantes, qualquer automorfismo de `phi` preserva `U`. Em coordenadas `V=U⊕E`, enumeram-se `GL(4,2)` e matrizes em bloco `[[P,Y],[0,Q]]`: a parte (2,2) elimina quase todos os pares; a parte (1,3) fornece um sistema de 16 equações lineares nos 16 bits de `Y`; e a restrição (0,4) filtra as soluções finais. A enumeração não supõe previamente os grupos de ordem 1920 ou 40. No segundo estágio, calcula-se a ANF por transformada de Möbius para os 1.920 automorfismos e as 256 translações, decidindo exatamente quando o grau da diferença é `<=2`. O programa também verifica diretamente os estabilizadores.

**Arquivo reproduzível autônomo:** `certificar_ultrarrigidez_local.py`, Python 3 puro, sem bibliotecas adicionais. Os resultados são verificados com `assert` e recebem hashes SHA-256 determinísticos das listas ordenadas das matrizes.

## 2. Enunciado principal — classificação EA de perturbações quadráticas

Sejam `G,H` dígrafos **sem laços e sem vértices isolados**, com `r>=2`, sobre os blocos `(F_2^8)^r`. Seja

`(F_G)_i(x) = f(x_i) + x_(i,0) x_(i,1) Σ_(i→j) x_(j,0)`

com `deg(Q),deg(Q')<=2`. Então, **sob a condição local agora verificada pelo certificado computacional**, toda equivalência EA `F_H+Q' = B(F_G+Q)(Ax+a_0)+L+c_0` satisfaz

1. `B=P_π^{-1}` para um isomorfismo de dígrafos `π:H→G`;
2. `A=P_π⊗I_8`;
3. `a_0=0`;
4. `[Q']_2=P_π^{-1}[Q]_2(P_π⊗I_8)`.

Reciprocamente, a identidade em (4) produz uma equivalência EA, pois a diferença entre as perturbações é afim. Para um `G` fixo sem vértices isolados, a classificação é, portanto, dada pelas órbitas de `Aut(G)` na parte quadrática homogênea de dimensão `r*binom(8r,2)=4r²(8r-1)`; quando `Aut(G)` é trivial, há exatamente `2^{4r²(8r-1)}` classes.

### Prova algébrica global (condicional apenas ao lema local finito certificado)

**(i) Recuperação de blocos.** A quarta derivada das funções é o tensor `⊕_i phi_i` com saídas independentes `e_i`. O centroid de `phi` é unidimensional e a propriedade Grassmann-free do núcleo da contração implica a rigidez dos idempotentes: os idempotentes mínimos não nulos do centroid global são as projeções sobre `V_i`. A equivalência EA, portanto, permuta blocos de entrada; o suporte da quarta derivada em cada bloco fixa simultaneamente a permutação das linhas de saída. Escrevemos as mudanças de entrada restritas como `(A_i,a_i)` com `A_i∈Aut(phi)`.

**(ii) Terceiras derivadas *intra-bloco*: comparação correta.** Restrinja as duas expressões EA a um bloco `V_i` mantendo os outros blocos fixos em zero. Cada acoplamento cúbico é no máximo quadrático em `x_i` e `Q,Q'` são de grau `<=2`. A **diferença** `f(A_ix_i+a_i)+f(x_i)` tem grau `<=2`: suas quartas derivadas já são iguais e a igualdade das terceiras derivadas cancela toda a parte cúbica. Pelo certificado local, `a_i=0` e `f(A_ix_i)=f(x_i)`; logo `A_i∈G_{<=2}(f)`.

**ATENÇÃO — reparo de uma falha de prova do texto recebido.** Não é correto dizer que `D³f(0)` é nula para todas as direções apenas porque `[f]_3=0`. Para `u=e_0+e_3`, `v=e_1`, `w=e_2`, o programa verifica `D_uD_vD_w f(0)=1`. A prova correta compara `D³f(A_i x+a_i)` com `D³f(x)`; as contribuições de grau 4 cancelam porque `A_i∈Aut(phi)`.

**(iii) Terceiras derivadas mistas.** Para `i≠j`, `D³|_(V_i,V_i,V_j)` elimina todas as sementes quárticas e todas as perturbações quadráticas; resta apenas o tensor simples correspondente ao arco `i→j`, com fatores `(e_0^*∧e_1^*)` na origem e `e_0^*` no destino. A igualdade dos tensores determina o isomorfismo orientado `π`. Para qualquer arco, as transformações internas `A_i,A_j` preservam respectivamente essas formas; como os estabilizadores no grupo de ordem 40 são triviais, `A_i=A_j=I_8`. Todo vértice incide em algum arco por hipótese; assim todos os blocos são identidades.

**(iv) Quadráticas.** `F_H=P_π^{-1}F_G(P_π⊗I_8)` vale exatamente. Cancelá-las na relação EA deixa `Q'=P_π^{-1}Q(P_π⊗I_8)+` termo afim; a identidade das partes homogêneas quadráticas é necessária e suficiente. QED (assumido o certificado finito local).

**Status de rigor:** prova matemática reduzida a lemas finitos integralmente enumerados por código Python transparente, **não** formalizada em Lean nem avaliada por referee. O texto é adequado para circulação de auditoria, não constitui por si só aceitação de periódico.

## 3. Correção de indecomponibilidade: critério que inclui Q

O texto externo declara falsamente: para `deg Q<=2`, “`F_G+Q` é EA-indecomponível **se e somente se** `G` é fracamente conexo”. Contraexemplo: `r=2`, `G` sem arcos, `Q=(x_(1,0)x_(2,0),0)`. O grafo é desconexo, mas a perturbação une os dois blocos de modo que não há decomposição EA de saídas não triviais, dada a recuperação intrínseca dos blocos pela quarta derivada.

**Critério corrigido (teorema, para a definição usual de produto EA com dois fatores de entrada e saída não nulos).** Defina o grafo não orientado de dependências `K(G,Q)` com vértices `[r]` e arestas:

- todas as arestas subjacentes aos arcos de `G`;
- `{i,j}` sempre que `i≠j` e uma parcela quadrática da ANF de `Q_i` contém uma variável do bloco `V_j`.

Então `F_G+Q` é EA-indecomponível **se e somente se** `K(G,Q)` é conexo.

**Prova:** Se `K` é desconexo, escolha uma partição em uniões de seus componentes conexos. Os acoplamentos cúbicos não cruzam a partição; nem existe monômio quadrático da coordenada `i` com variável em um bloco da outra parte. Após subtração de funções afins, as saídas em cada parte dependem só de entradas da própria parte: há decomposição direta literal. Reciprocamente, uma decomposição EA força, pela quarta derivada e pelos idempotentes mínimos, uma partição dos blocos `V_i` e das linhas de saída `e_i`. As terceiras derivadas mistas proíbem arcos entre partes; na ausência desses arcos cruzados, os acoplamentos não produzem derivadas de segunda ordem entre um bloco de entrada da parte oposta e uma coordenada de saída de outra parte. Os monômios quadráticos externos de `Q` não podem desaparecer por mudanças internas invertíveis, permutações de blocos ou adição afim. Portanto não há arestas de `K` entre partes e `K` é desconexo. QED.

Este critério é mais forte que o original: `G` conexo ainda garante indecomponibilidade para todo `Q`; porém `G` desconexo pode gerar funções indecomponíveis via `Q`.

## 4. Regra de incorporação e ressalvas

- **Aprovado para registrar:** cálculos finitos da semente; lema local sobre estabilizadores; prova global corrigida da classificação EA (com indicação explícita do certificado); contraexemplo e critério correto de indecomponibilidade.
- **Não aprovado como “provado em Lean”:** o código Lean fornecido no relatório de terceiros não verifica a enumeração do grupo, os idempotentes do centroid global nem o teorema EA.
- **Ainda não auditado nesta rodada:** família indutiva em `2m`, separação V3-C, teoria assintótica de automorfismos de dígrafos e prioridade bibliográfica de ultra-rigidez.
- Não fundir este adendo com o manuscrito V2 original sem delta review adicional. Não modificar branches de V1 ou V3-C.
