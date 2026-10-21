# Guia de escrita para Designs, Codes and Cryptography

Análise editorial em 21/10/2026 para o artigo sobre H(12,4). Base: artigo integral de Sun et al., introduções e passagens demonstrativas/computacionais de três outros artigos publicados na revista e instruções oficiais atuais. Este guia distingue observação de estilo, regra editorial e escolha recomendada para nosso manuscrito. A amostra não permite afirmar que um estilo, isoladamente, garante aceitação.

## 1. Fontes e finalidade da leitura

| Fonte primária | Conteúdo consultado | Uso editorial |
|---|---|---|
| Sun, Shi, Liu e Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, DCC 94, 93 (2026), [DOI](https://doi.org/10.1007/s10623-026-01848-4) | PDF integral local de 22 páginas; estrutura, introdução, preliminares, organização dos teoremas, exemplos e conclusão; inspeção visual das páginas 2, 5 e 19 | Referência temática mais próxima e modelo para organizar um resultado de inexistência |
| Bartoli e Timpanella, *Further results on a family of bent functions from permutations*, DCC 94, 84 (2026), [texto integral aberto](https://link.springer.com/article/10.1007/s10623-026-01815-z) | Resumo, introdução, §2 e passagens demonstrativas do §3 | Transição de antecedentes para uma melhoria precisamente delimitada; hipóteses apresentadas junto dos enunciados |
| Polujan e Pott, *Cubic bent functions outside the completed Maiorana–McFarland class*, DCC 88, 1701–1722 (2020), [texto integral aberto](https://link.springer.com/article/10.1007/s10623-019-00712-y) | Introdução, §3.1, Teorema 3.3, algoritmos e conclusão da versão disponível | Relação entre resultados matemáticos, cálculos explícitos, software e apêndices |
| Budaghyan e Pal, *Arithmetization-oriented APN permutations*, DCC 93, 1067–1088 (2025; publicação online em 2024), [texto integral aberto](https://link.springer.com/article/10.1007/s10623-024-01487-7) | Resumo, introdução e §4, incluindo discussão da Tabela 3 | Separação de resultados demonstrados, verificação para parâmetros finitos e conjectura |
| [Instruções oficiais da revista](https://link.springer.com/journal/10623/submission-guidelines) | Requisitos de resumo, formatação, referências, suplementos e declarações | Regras atuais; prevalecem sobre escolhas de artigos anteriores |

O PDF de Sun utilizado é `C:/Users/Valer/Downloads/s10623-026-01848-4.pdf`. O texto publicado confirma a data de 13/04/2026. As páginas seguintes são as páginas internas do PDF, numeradas de 1 a 22. Esta leitura editorial não equivale a uma auditoria matemática de todos os resultados desses artigos nem a uma revisão exaustiva de prioridade.

## 2. O que aprender especificamente com Sun et al.

Nas páginas 1–2, a introdução vai de bentness e simetria por rotação à conjectura, aos resultados anteriores e às contribuições do artigo. A conjectura recebe um enunciado separado; o leitor não precisa deduzi-la da motivação. O último parágrafo fornece a organização das seções.

As preliminares, páginas 3–5, fixam as convenções para suporte, grau, Walsh, derivada, autocorrelação, rotação, órbitas e a representação curta da forma algébrica normal. A notação especializada aparece antes de ser usada nos resultados.

O §3 é dividido pelo mecanismo matemático: autocorrelações, distâncias de índices e derivadas no caso cúbico. Não é uma descrição da ordem em que os autores realizaram a pesquisa. As subseções começam por explicar o objetivo da técnica e introduzem apenas então os objetos necessários. Há exemplos nas páginas 10, 15 e 18 que mostram como aplicar as hipóteses dos teoremas. A tabela das páginas 19–20 compara resultados sob condições explícitas. A conclusão da página 21 retoma o alcance parcial dos resultados.

**Aplicação ao nosso artigo:** a estrutura principal deve seguir as dependências da prova: família concreta e bentness; condições necessárias; cobertura por três cartas; correção do certificado; refutações concretas; teorema de inexistência. Nomes de módulos, tentativas do GitHub e problemas de cache não são divisões matemáticas do artigo.

**O que não transferir automaticamente:** o tratamento predominantemente analítico de Sun não elimina a necessidade de descrever nossa etapa finita. A tabela de antecedentes só deve incluir comparações cujas hipóteses tenham sido conferidas. Não copiar a declaração de ausência de dados de outro artigo: nossa pesquisa produziu certificados, fontes e registros de verificação.

## 3. Padrões observados nos outros artigos

### 3.1 Delimitar a contribuição antes da prova técnica

Bartoli e Timpanella identificam na introdução uma família já estudada e a questão específica que será aprofundada. O §2 recupera um resultado anterior com referência precisa antes de formular os avanços seguintes. As hipóteses permanecem visíveis nos enunciados e nas passagens que os relacionam. Esse encadeamento é um modelo útil para situar nosso caso de doze variáveis sem anunciar uma resolução geral da conjectura. [Fonte](https://link.springer.com/article/10.1007/s10623-026-01815-z).

### 3.2 Integrar computação ao argumento

No §3.1 de Polujan e Pott, o Teorema 3.3 é acompanhado pela descrição das verificações de equivalência e dos invariantes calculados, com indicação de Magma e Mathematica. Representantes e outros dados são remetidos ao apêndice. O leitor vê a ligação entre a pergunta matemática e o cálculo. Isso oferece um exemplo publicado de exposição com computação, mas não estabelece uma política editorial específica de aceitação de provas Lean. Para nós, o ponto essencial é explicar o que a verificação concreta prova e como se liga ao enunciado universal. [Fonte](https://link.springer.com/article/10.1007/s10623-019-00712-y).

### 3.3 Distinguir os estatutos das afirmações

Budaghyan e Pal distinguem, no resumo e no §4, condições demonstradas, resultados computacionais para parâmetros finitos e uma conjectura sobre uma família infinita. A Tabela 3 é acompanhada do domínio pesquisado. Aplicaremos essa precisão à diferença entre enumeração original, certificado finito e teorema aceito pelo kernel. Nenhuma delas será apresentada como generalização para outras dimensões. [Fonte](https://link.springer.com/article/10.1007/s10623-024-01487-7).

## 4. Regras oficiais atuais relevantes

As instruções consultadas pedem título conciso e informativo, resumo de 150–250 palavras, 4–6 palavras-chave, abreviaturas definidas, títulos de seções com até três níveis e citações numéricas entre colchetes. Recomendam o modelo LaTeX da Springer Nature e exigem fontes editáveis. Devem ser preparadas as declarações aplicáveis e a disponibilidade dos dados. A política distingue edição linguística assistida de uso mais amplo de modelos de linguagem, cuja documentação deve refletir o trabalho efetivamente realizado. [Instruções oficiais](https://link.springer.com/journal/10623/submission-guidelines).

Resumos curtos ou decisões de formatação de artigos anteriores não substituem essas orientações atuais. Não inferimos um limite de páginas obrigatório a partir da amostra.

## 5. Estrutura recomendada para nosso manuscrito

1. **Introduction.** Contexto da conjectura, antecedentes diretamente pertinentes, enunciado de inexistência para grau quatro em doze variáveis e descrição breve da estratégia assistida por computador. A comparação com Sun precisa indicar o resultado ou as hipóteses pertinentes, sem usar a data de publicação como argumento de relevância.
2. **Preliminaries and the quartic cyclic space.** Definições convencionais em F₂¹², a base das órbitas, Walsh e autocorrelação. Demonstrar a identificação da família matemática com a representação concreta usada na formalização.
3. **Necessary conditions and affine reduction.** Derivar os filtros e as relações necessárias; explicar o período quatro, a exclusão do quarto caso e a cobertura pelas três cartas.
4. **Refutation certificates.** Definir o significado de um estado e de uma refutação. Demonstrar a correção das regras de substituição, bifurcação e rejeição terminal. Incluir um exemplo pequeno representativo de uma regra; qualquer exemplo novo deve ser conferido antes de entrar no texto definitivo.
5. **Certified verification and proof of the main theorem.** Enunciar a validade das três refutações concretas, descrever seu vínculo com os dados e a checagem pelo kernel, e compor a contradição final. A existência dessa seção não dispensa expor a matemática das seções anteriores.
6. **Conclusion.** Explicar o que o caso H(12,4) acrescenta e quais problemas permanecem. Separar claramente o resultado quártico do trabalho cúbico anterior.
7. **Supplementary material and data availability.** Certificados completos, fontes, versões, comandos de reprodução e hashes, vinculados a uma versão estável do pacote. Não prometer reconstrução integral em minutos.

Esta é uma escolha de organização para nossa prova, inspirada pela amostra. A revista não prescreve exatamente essas sete divisões. A quantidade final de seções depende do manuscrito, não do número de etapas do programa.

## 6. Regras de redação que adotaremos

- Apresentar o problema e o resultado antes dos detalhes de implementação.
- Introduzir cada bloco de prova com uma frase que diga qual obstáculo ele resolve.
- Formular hipóteses e quantificadores completos nos enunciados. Evitar depender de uma condição lembrada de várias páginas antes.
- Usar notação matemática no corpo: c ∈ F₂⁴³ e funções em F₂¹². Explicar a correspondência com `BitVec 43` na seção de formalização.
- Distinguir resultados anteriores, proposições demonstradas no texto e verificação de instâncias concretas. Não transformar uma conferência extensa em “cálculo imediato”.
- Reservar tabelas para comparar hipóteses, casos ou dados. Não usar painéis de progresso ou número de módulos como evidência matemática.
- Manter a etapa computacional explícita desde o resumo. O certificado pode ficar no suplemento; a razão pela qual ele implica o teorema deve ficar no artigo.
- Apresentar Lean como parte do método de verificação, com versão e declaração certificada; evitar tanto a promoção do software quanto sua ocultação.
- Evitar adjetivos sobre importância e originalidade. Dizer qual caso foi resolvido e por qual mecanismo.
- Usar inglês claro, referências precisas e frases de transição curtas; não imitar erros de linguagem ou construções particulares de um autor.

## 7. Exemplo original de título e resumo

**Título de trabalho:** *Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables*.

**Resumo de trabalho, sujeito à revisão conjunta do manuscrito:**

We prove that no homogeneous rotation symmetric Boolean function of algebraic degree four in twelve variables is bent. The argument combines structural restrictions with a finite certificate verified in Lean. We first derive necessary conditions from restricted weight divisibility and from autocorrelations on periodic inputs. These conditions place every possible bent function in one of three explicit affine families. We then certify a refutation for each family using Boolean polynomial identities, affine substitutions, exhaustive branching, and Walsh witnesses at the terminal cases. A soundness theorem connects the concrete certificates to the original functions, yielding nonexistence for every choice of the forty-three coefficients in the quartic cyclic basis. The equivalence between the autocorrelation and Walsh formulations of bentness is also verified. The certificates, source files, and verification records are provided as supplementary material. This establishes the twelve-variable quartic case of the homogeneous rotation symmetric bent function conjecture. The proof does not require repeating the original exhaustive search.

O resumo é uma redação nova baseada no resultado desta pesquisa. Não foi adaptado por substituição de palavras de outro artigo. Antes da submissão, “supplementary material” deve corresponder ao pacote efetivamente entregue e ao endereço estável escolhido.

## 8. Como usar este guia na revisão

O próximo passe editorial deve seguir o manuscrito do início ao fim: resumo e introdução; notação; enunciados e ordem das provas; descrição da etapa finita; suplementos e referências. A matriz de dependências de [PROVA_PARA_LEITURA_HUMANA.md](PROVA_PARA_LEITURA_HUMANA.md) é o ponto de partida. A [conclusão auditada](CONCLUSAO_FORMAL_H12.md) fixa os limites das afirmações.

Este estudo de estilo não alterou a prova, o verificador ou os certificados e não exigiu nova execução do Lean. Não é, por si só, uma versão final do artigo nem uma confirmação de prioridade bibliográfica.
