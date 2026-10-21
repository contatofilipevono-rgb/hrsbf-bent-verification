# Parecer adversarial — rodada 2 (H12, quártica homogênea RS em 12 variáveis)

Pacote: `H12_SEGUNDA_RODADA_ANALISE_ADVERSARIAL.zip`, SHA256 `2A6E96B6…D445`. Data: 21/10/2026.
Avaliador: Claude (Opus 5.5). Não se estima chance de aceitação. As notas da seção 0 medem a qualidade do manuscrito e do pacote; não são probabilidades.

---

## 0. Veredito e notas

**Veredito:** *revisão menor.* Nesta rodada, não encontrei erro matemático. Todas as respostas às críticas A1–A9 se sustentam. Três delas contrariam o parecer anterior: A3, A9 e o número de palavras do resumo em B3. Nas três, quem acerta é o autor. O que ainda impede a submissão são as declarações factuais, o DOI e o template, e não a prova.

| Eixo (peso) | Nota atual | Nota após as correções da seção 4 | O que separa as duas |
|---|---:|---:|---|
| A. Matemática e certificação (50%) | **9,0** | **9,6** | O resumo diminui o que foi formalizado (N1). Falta um mapa entre os lemas e os nomes Lean (N1). A coincidência 164.288 não é explicada (N2). Não houve rebuild do arquivo depositado (N5) |
| B. Escrita e interesse científico (30%) | **7,5** | **8,3** | Revisores e datas de diretório aparecem no corpo (N4). O título da Seção 6 está desatualizado (N3). Há citações só no corpo do texto (N7). Faltam dois antecedentes clássicos (N6). O teto vem do escopo de um único caso finito, e isso não se corrige no texto |
| C. Prontidão dos documentos (20%) | **5,5** | **9,0*** | Financiamento, interesses e contribuições estão pendentes. Não há DOI. O template não tem *Declarations*. Há documentos auxiliares desatualizados (N8–N10) |
| **Nota global ponderada** | **7,9 / 10** | **9,1 / 10*** | |

\* A nota "após" em C supõe que o autor forneça os fatos pendentes e conclua o depósito com DOI. Não preenchi nada por palpite. Sem esses dois itens, C fica em 7,0 e a global em 8,6.

---

## 1. O que executei, o que só li e o que não examinei

**Executei:**
- `python -I verify.py` (verificador independente, sem `-O`). O resultado foi `PASS_SUPPLEMENT_INTEGRITY` e `PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS`: 67.658 nós e 164.288 vetores, em **95,8 s** nesta máquina. A saída está em `verify_replay_output.txt`.
- Um script próprio, `round2_check.py`, que lê apenas o Markdown do artigo e `H12PeriodFour.lean`. As **33 checagens passaram**:
  - O Apêndice A coincide com `quarticOrbits` do Lean, índice a índice, nos 43 índices e 495 suportes, sem duplicatas.
  - As contagens de Burnside dão 43 (n=12) e 116 (n=16).
  - As 43 máscaras de filtro estão em órbitas distintas. A fórmula (3.2) coincide com o 2º bit do peso restrito (25 vetores c aleatórios × 43 filtros).
  - A paridade dos pesos restritos é sempre zero, o que confirma A9.
  - Os produtos 22/1/24 do Apêndice B reproduzem R1, R2 e R3. Também conferem Q30 = L + c26 + c40 + c26c42 e L = R1 + R3. A identidade (3.8) vale em todas as 2^19 atribuições das variáveis envolvidas.
  - Q42: w26 = w40 = w42 = 30, os demais w ≡ 0 (mod 4), todas as interseções são pares e Q42 = R2.
  - A restrição periódica de cada p_j bate com (3.4)–(3.5) e J. As tabelas-verdade A, B, E_3 e D estão corretas.
  - **Tabela de 16 códigos refeita linha a linha:** tupla, tabela-verdade, testemunha u, C_g(u) e resíduo conferem. Os sobreviventes são exatamente 2, 3, 8 e 15.
  - A congruência (3.7) C_f(r(u)) ≡ C_g(u) (mod 3) vale para 5 vetores c aleatórios, em todos os u.
  - A parametrização (3.9) satisfaz a tupla e R1 = R2 = R3 = 0 (600 amostras). O conjunto I tem 36 elementos.
  - Na tabela C.2, nós = eliminações + bifurcações + contradições + terminais, e folhas = bifurcações + 1 nas três raízes.
  - A quadrática antipodal é bent. Como sanidade, 30 quárticas aleatórias não são bent.
  - O resumo tem 169 palavras. O anterior tinha 160, como a resposta B3 afirma.
- Leitura direta do Lean de `H12AffineFastState.Refutes` / `refutes_sound`, `H12Final` e `H12PeriodFour.quarticOrbits`, e localização de `bent_root`, `covers_bent`, `periodic_reduction`, `computed_filter_necessary`, `bent_passes` e `bent_iff_flat`.
- Literatura: arXiv 1708.09313 (Cusick–Sanger) lido em HTML. O Teorema 3.8 diz que, para n = 2p, "if f is bent then d is even". O Teorema 3.10 diz "If s_f ≤ n/2, then f is not bent", atribuído a Meng–Chen–Fu, Th. 13. Isso confere com a tabela do artigo. A descrição de Stănică–Maitra ("até dez variáveis", evidência experimental) foi confirmada em resumo público.

**Só li:** o texto do artigo, as respostas, o parecer anterior, os JSONs de auditoria, a carta, as declarações, o checklist, o README do template e as primeiras linhas de `main.tex` do template.

**Não examinei:**
- A reconstrução Lean. Não a simulei.
- Os PDFs do artigo, do template e do V1. Esta máquina não tem renderizador de PDF, então não houve leitura visual nem leitura do texto integral do V1.
- O PDF original de Meng–Chen–Fu. A definição exata de s_f não foi conferida na fonte primária.
- Sun et al. (DCC 2026), Polujan–Kudin–Pasalic e Tang: não tive acesso aos PDFs.
- As diretrizes atuais da DCC: a página exige login e não foi aberta.

---

## 2. Tabela dos 25 itens do parecer anterior

| Item | Situação | Comentário |
|---|---|---|
| A1 | **Resolvido** | Definições impressas em C.1. Conferi que a correspondência entre o Apêndice A e `quarticOrbits` vale nos dois sentidos |
| A2 | **Resolvido** | A tabela é aritmeticamente consistente. Ver N2 sobre a coincidência 164.288 |
| A3 | **Resolvido. A discordância do autor é válida** | No Lean, a regra `eliminate` exige apenas `compose env (Σ eqs) = z_i ⊕ a`. A prova de soundness usa `packedUpdate_eq` e funciona mesmo que `a` contenha z_i. A hipótese de independência sugerida antes era desnecessária |
| A4 | **Resolvido** | Os 16 casos foram refeitos e estão corretos |
| A5 | **Resolvido** | |
| A6 | **Resolvido** | Os números de Q42 conferem |
| A7 | **Resolvido** | O nome E_3 é consistente, inclusive no template |
| A8 | **Resolvido**, mas a explicação está no lugar errado | Ver N4: a frase sobre a data do diretório não deve ficar no artigo |
| A9 | **Resolvido. A discordância do autor é válida** | Cada monômio quártico vale 1 em 2^4 = 16 pontos de V_S. A condição de paridade é tautológica e foi confirmada numericamente |
| B1 | **Resolvido** | |
| B2 | **Resolvido parcialmente** | A tabela está correta onde pude conferir. Faltam dois antecedentes de contexto (N6). A definição de s_f não foi conferida na fonte primária |
| B3 | **Resolvido. A discordância do autor é válida** | 169 palavras agora; o resumo anterior tinha 160, e não ~190. Não verifiquei a faixa 150–250 na página da DCC |
| B4 | **Resolvido** | |
| B5 | **Resolvido** | |
| B6 | **Resolvido parcialmente** | A Seção 7 existe, mas a Seção 6 ainda se chama "…and availability of verification material" (N3) |
| B7 | **Resolvido** | |
| B8 | **Resolvido** | O número 116 e a ordem 4 da rotação em n=16 estão corretos |
| B9 | **Não verificado** por mim | Os PDFs de Polujan–Kudin–Pasalic e Tang não estavam acessíveis |
| C1 | **Pendente (bloqueio)** | Corretamente não preenchido |
| C2 | **Pendente (bloqueio para envio)** | Ainda não há DOI |
| C3 | **Resolvido** | |
| C4 | **Resolvido**, com o limite de método declarado | Não li o texto integral do V1 |
| C5 | **Resolvido parcialmente** | O template não tem a seção *Declarations* e usa `\section*` numerada à mão (N9) |
| C6 | **Pendente** | |
| C7 | **Resolvido**, mas criou o problema N4 | Medi 95,8 s |

Placar: 18 resolvidos, 3 parciais, 3 pendentes por fatos e 1 não verificado. Nenhuma resposta incorreta.

---

## 3. Novos achados

| # | Eixo | Gravidade | Onde | Problema e evidência | Correção mínima |
|---|---|---|---|---|---|
| N1 | A | **Moderada** | Resumo; §5.1; C.1 | O resumo diz apenas "A soundness theorem and the three concrete refutations are verified in Lean". No Lean, porém, a **redução inteira da Seção 3** também é formal: `H12FilterLink.bent_passes` (Lema 3.1), `H12PeriodFour.periodic_reduction` (Lema 3.3), `H12Audit.necessary_chart_constraints` e `H12Affine.covers_bent` (Lemas 3.2–3.4 e Prop. 3.5), `H12ChartFilters.bent_root`. O leitor conclui que a Seção 3 só tem prova humana, o que é falso e enfraquece o artigo. A carta já diz "rules, coverage and concrete instances". Há uma incoerência entre o resumo e a carta | Reescrever a frase do resumo (§4.1) e acrescentar a tabela Lema → Lean em C.1 (§4.2) |
| N2 | A | Menor | C.2 | 46.912 + 46.400 + 70.976 = **164.288**, exatamente o `all_quad_zeros_covered` do verificador Python. Ao mesmo tempo, o texto diz que as contagens do Python "are not counts of these three Lean trees". Um revisor vai perguntar por que os totais coincidem. A explicação provável é que, em cada terminal, as equações já se anulam identicamente, de modo que as atribuições terminais são exatamente os zeros comuns. Não verifiquei essa hipótese | Confirmar nos certificados e acrescentar uma frase (§4.3). Se não for essa a razão, explicar a coincidência |
| N3 | B | Editorial | Título da §6 | "Conclusion and availability of verification material" sobrou da versão anterior: a disponibilidade agora está na §7 | Usar "Conclusion and further directions" |
| N4 | B | **Moderada** | C.3 | O corpo do artigo cita "the copy prepared for the first review" e "a subsequent reviewer reported approximately 101 seconds", e explica o nome do diretório de 20/10. Isso expõe o processo de revisão (feito por IA) e soa defensivo, exatamente o que B4 pedia para remover | Substituir pelo parágrafo do §4.4. A explicação da data vai para o README do suplemento |
| N5 | A/C | **Moderada** | C.3 | "A full fresh rebuild of the minimal Lake distribution packaging has not been performed." Num artigo assistido por computador, o árbitro da DCC vai ler isso como "o pacote depositado não foi mostrado compilável". Não é falha de verdade, porque a integração original passou no `leanchecker`, mas é a maior lacuna de reprodutibilidade que resta | Fazer **um** rebuild limpo a partir exatamente do arquivo que irá ao DOI (pode levar horas, uma única vez) e registrar o hash, a versão e o tempo. Se isso não for viável antes do envio, manter a frase atual: ela é honesta |
| N6 | B | Menor | Tabela da §1 | Faltam dois antecedentes de contexto. (i) Stănică–Maitra–Clark (FSE 2004): inexistência de RotS bent homogênea de grau ≥ 3 com **uma só órbita** (MRS). Isso cobre as 43 funções p_j isoladas, e o artigo deve dizer que vai além disso. (ii) Funções bent homogêneas **não rotacionais** de grau 3 existem (Qu–Seberry–Pieprzyk 2000; Charnes–Rötteler–Beth 2002, até 12 variáveis). Junto com Polujan et al., isso mostra que **as duas** hipóteses, homogeneidade e rotação, são necessárias. *Conferir as referências na fonte antes de citar*: identifiquei-as de memória e pela busca, sem ler os PDFs | Duas linhas na tabela e uma frase (§4.5) |
| N7 | B | Editorial | §1 | Cusick–Sanger (arXiv:1708.09313) e Tang (ePrint 2026/1799) aparecem só no corpo do texto e não estão na lista de referências | Acrescentar como [7] e [8] |
| N8 | C | Menor | `RESUMO_E_DADOS_SUBMISSAO.md` | O texto diz "AI-assisted tools declaration — texto aprovado, **sem alteração**", mas o texto foi alterado (Claude foi incluído). O parágrafo "Journal status… author must confirm" contradiz a confirmação de 21/10 registrada no mesmo arquivo | Trocar para "texto atualizado em 21/10 (inclusão de Claude)" e apagar o parágrafo superado |
| N9 | C | Moderada | `dcc_template/main.tex` | (i) Não há a seção *Statements and Declarations* (Funding, Competing interests, Author contributions, Data availability) exigida pela Springer. Mesmo com os fatos pendentes, os campos devem existir como marcadores visíveis. (ii) As seções são `\section*{3 …}`, numeradas à mão, e quebram a numeração e as referências cruzadas do `sn-jnl` | Usar `\section{…}` e `\label`/`\ref`. Acrescentar `\bmhead{Funding}` etc. com o marcador `[AUTHOR TO CONFIRM]` |
| N10 | C | Menor | `CHECKLIST_ENVIO…`; `CARTA_STATUS.md` | Há itens marcados de forma errada. "[x] Declaração de IA mantida na forma aprovada" foi alterada. "[ ] Confirmar situação editorial do V1" já foi confirmada. "[ ] Preparar layout" já tem rascunho. Além disso, `CARTA_STATUS` fala de um "parágrafo sobre o depósito" que não existe na carta | Atualizar as marcações e a frase |

Verificado e **sem problema** (não são achados): Lema 3.1 e (3.1) (fator 16 = |V_S^⊥|), Lema 2.2, a semântica de E∘T na Seção 4 (coincide com o `Refutes` do Lean), a regra terminal (no Lean ela é `∀ f, ¬target`, sem depender de equações), Prop. 2.1, a quadrática antipodal e a afirmação sobre n=16.

---

## 4. Trechos reescritos (prontos para colar)

### 4.1 Resumo: substituir uma frase (N1). O resumo passa de 169 para cerca de 176 palavras, dentro de 150–250

> ~~A soundness theorem and the three concrete refutations are verified in Lean.~~
> **The necessary conditions, the coverage by the three families, a soundness theorem for the refutation rules and the three concrete refutations are all verified in Lean.**

### 4.2 Fim de C.1: tabela de correspondência (N1)

> The structural reduction of Section 3 is not only argued in the text; each step has a formal counterpart used by the final theorem:
>
> | Article | Lean |
> |---|---|
> | Lemma 2.2 | `H12Fourier.bent_iff_flat` |
> | Lemma 3.1 and (3.2) | `H12FilterBridge.computed_filter_necessary`, `H12FilterLink.bent_passes` |
> | Lemma 3.3 | `H12PeriodFour.periodic_reduction` |
> | Lemmas 3.2, 3.4 and Proposition 3.5 | `H12Audit.necessary_chart_constraints`, `H12Affine.covers_bent`, `H12ChartFilters.bent_root` |
> | Proposition 4.1 | `H12AffineFastState.refutes_sound` |
> | Proposition 5.1 | `H12CloudChart{0,1,2}.refutation` |
> | Theorem 1.1 | `H12Final.no_bent_quartic` |

*(O autor deve confirmar qual teorema Lean corresponde exatamente aos Lemas 3.2 e 3.4. Localizei `necessary_chart_constraints` como dependência de `covers_bent`, mas não li seu enunciado.)*

### 4.3 C.2: acrescentar após a tabela (N2, se a hipótese se confirmar)

> At every terminal state the forty-three equations vanish identically, so its enumerated assignments are exactly the common zeros of that state. Their total over the three roots, 164,288, therefore coincides with the number of quadratic zeros covered by the independent checker, although the two trees have different node structures.

### 4.4 C.3: substituir o 1º e o 2º parágrafos (N4)

> The formal integration was completed with Lean 4.35.0 at the source commit identified in the supplementary records; the two final modules were checked by `leanchecker`. Axiom reports for `all_chart_refutations`, `no_bent_quartic`, `no_flat_quartic` and `walsh_witness` contain only `propext`, `Classical.choice` and `Quot.sound`, with neither `sorryAx` nor `ofReduceBool`.
>
> The independent checker is a separate implementation in standard Python. On commodity hardware its replay takes about two minutes (observed between 96 and 139 seconds on different machines). Assertions are part of the checker, so it must be run without Python's optimization flag.

### 4.5 §1: após a tabela (N6, depois de conferir as fontes)

> Two classical boundaries frame the question. Nonexistence was established early for homogeneous rotation symmetric functions generated by a single cyclic orbit [SMC04]; the present space allows arbitrary sums of the forty-three orbits. Conversely, homogeneous cubic bent functions that are not rotation symmetric exist [QSP00, CRB02], and rotation symmetric bent functions that are not homogeneous exist [5]. Both hypotheses are therefore essential.

### 4.6 Título da §6 (N3)

> **6 Conclusion and further directions**

---

## 5. Pendências factuais (não preenchidas)

1. Financiamento: o autor precisa responder se houve ou não financiamento e qual foi.
2. Interesses concorrentes, financeiros e não financeiros.
3. Declaração de contribuição (autor único) e aprovação da versão final.
4. DOI público do depósito **com os arquivos desta revisão**. O rascunho Figshare atual tem os arquivos da 1ª preparação e não deve ser publicado assim.
5. Limite de arquivo suplementar e conversão no portal da DCC.
6. Fonte primária de Meng–Chen–Fu: confirmar a definição de s_f.
7. Antes de citar as referências do N6, conferi-las nas fontes.
8. Opcional, mas recomendado (N5): rebuild limpo do arquivo que será depositado.
