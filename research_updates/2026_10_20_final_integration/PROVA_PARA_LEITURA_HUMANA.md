# H(12,4): uma apresentação da prova para leitura humana

Este roteiro reorganiza a prova certificada em 21/10/2026. Não modifica os teoremas, os certificados ou os objetos Lean. Nenhuma execução nova do Lean ou da busca é necessária para esta reorganização editorial.

## Resultado e definições

Sejam O₀,…,O₄₂ as órbitas cíclicas dos subconjuntos de quatro posições de {0,…,11}. Para c ∈ F₂⁴³, defina

\[
f_c(x)=\bigoplus_{j=0}^{42}c_j\bigoplus_{S\in O_j}\prod_{i\in S}x_i.
\]

As 43 órbitas são disjuntas e cobrem exatamente os 495 suportes quárticos. A família assim definida é H(12,4), incluindo a escolha nula dos coeficientes. Uma função é bent se seus 4.096 coeficientes de Walsh têm módulo 64.

**Teorema.** Nenhuma função f_c é bent.

O enunciado formal principal usa a definição equivalente por autocorrelação: para toda direção não nula u, a soma de (-1)^{f(x)+f(x+u)} deve ser zero. A equivalência com Walsh plano é provada em `H12Fourier.bent_iff_flat`.

## A ideia da demonstração

Suponha que uma função da família seja bent. Condições necessárias colocam seus coeficientes em uma de três cartas afins explícitas. Em cada carta, um certificado cobre todas as possibilidades: suas regras preservam soluções ou dividem o domínio de modo exaustivo. Toda folha termina em uma contradição algébrica ou em uma rejeição espectral certificada. Assim, nenhuma das três cartas pode conter a função supostamente bent.

O leitor precisa entender por que as cartas cobrem todos os possíveis bent e por que as regras do certificado são corretas. As grandes listas numéricas são instâncias dessas regras, preservadas para conferência.

## Proposição 1 — condições necessárias e cobertura

Se f_c fosse bent, existiriam k ∈ {0,1,2} e u ∈ F₂³⁶ tais que c é a imagem de u na carta k e u satisfaz o sistema necessário dessa carta.

**Justificativa.** A identidade de caracteres sobre subespaços coordenados fornece divisibilidade de pesos e 43 condições quadráticas necessárias nos coeficientes. Identidades booleanas explícitas dão relações lineares adicionais. A restrição de período quatro e a descida das autocorrelações módulo três deixam quatro formas possíveis; uma identidade curta elimina uma delas. As três formas restantes admitem as cartas afins de 36 parâmetros usadas na prova.

É essencial demonstrar tanto a necessidade das condições quanto a reconstrução do vetor original pela carta. As leis não são hipóteses impostas sobre uma subfamília. Essas passagens são reunidas em `H12ChartFilters.bent_root`, usando, entre outros resultados, `H12FilterLink.bent_passes` e a cobertura afim.

Para o corpo do artigo, as identidades que eliminam o quarto caso e a definição das cartas devem ficar acessíveis. As tabelas completas de coeficientes podem ir ao suplemento.

## Proposição 2 — correção das regras de exclusão

Considere uma carta e o sistema de equações booleanas que toda função bent nessa carta deve satisfazer. Um certificado de refutação válido prova que nenhuma atribuição satisfaz simultaneamente o sistema e a condição de bentness da função reconstruída.

**Justificativa das operações.**

1. Uma combinação XOR de equações que produz uma equação linear pode ser resolvida e substituída. A prova acompanha a transformação da atribuição e a preservação das soluções.
2. Uma bifurcação por uma condição linear separa todas as soluções entre os dois valores possíveis. A cobertura exige os dois ramos.
3. Se uma combinação das equações é a constante 1, o ramo é impossível, pois as equações exigiriam 0 = 1.
4. Um ramo terminal é rejeitado somente após justificar sua cobertura e a rejeição de cada função representada, mediante os testemunhos espectrais certificados.

Não basta dar o nome “certificado” a um arquivo. É a prova de correção dessas regras, junto com a conferência das instâncias concretas, que permite a conclusão. A implementação utilizada na integração é `H12AffineFastState`, com `refutes_sound` e `no_bent_of_affine_state_refutations`. Não se deve atribuir a execução completa ao antigo verificador `H12Refutation.check`.

O corpo do artigo deve explicar essas regras e demonstrar sua correção; a apresentação detalhada pode usar indução na estrutura do certificado. Os detalhes da codificação compacta são matéria do suplemento.

## Proposição 3 — as três refutações concretas

Os certificados das três cartas são instâncias válidas das regras anteriores.

**Evidência formal.** O kernel aceitou `H12CloudChart0.refutation`, `H12CloudChart1.refutation` e `H12CloudChart2.refutation`. O teorema `H12Final.all_chart_refutations` reúne essas três declarações para todo k : Fin 3.

Esta é a etapa computacional finita da demonstração. Sua validade não decorre de dizer que a busca não encontrou soluções. Ela decorre das provas concretas aceitas pelo kernel, ligadas aos dados explícitos e à semântica do verificador.

Os módulos gerados, registros e hashes pertencem ao material suplementar. O artigo precisa identificar os certificados, explicar seu conteúdo e permitir localizar a conferência. O tamanho dos arquivos e o número de módulos não substituem nenhuma dessas obrigações.

## Demonstração do teorema a partir das três proposições

Suponha, por contradição, que f_c seja bent. Pela Proposição 1, c é representado por uma atribuição u em uma das três cartas, satisfazendo o sistema necessário. Pela Proposição 3, essa carta possui uma refutação válida. A Proposição 2 exclui a bentness da função reconstruída por u. Como essa reconstrução é exatamente f_c, obtemos uma contradição.

Essa composição é o conteúdo de `H12Final.no_bent_quartic`. A equivalência de Fourier fornece `no_flat_quartic`; `walsh_witness` expressa que cada escolha de coeficientes possui uma frequência a < 4096 com W_f(a)² ≠ 4096.

## O que deve ficar no artigo e no suplemento

| Corpo do artigo | Suplemento e pacote formal |
|---|---|
| Definição da família e de bentness | Lista das 43 órbitas e sua ordenação |
| Derivação das condições necessárias | Tabelas dos 43 filtros e identidades expandidas |
| Por que há três cartas e por que cobrem todos os possíveis bent | Bases, deslocamentos e substituições concretas |
| Regras de refutação e prova de correção | Codificação compacta e módulos gerados |
| Enunciado da verificação das três raízes, com referência precisa | Certificados, testemunhos, fontes, versões e hashes |
| Contradição final e escopo exato | Logs de compilação e reprodução pelo kernel |

Essa divisão reduz a carga de leitura sem retirar as evidências necessárias. Um árbitro pode avaliar o argumento matemático e aprofundar a etapa finita quando necessário.

## Quais simplificações dispensam nova execução

| Alteração | Verificação necessária |
|---|---|
| Reordenar a exposição, explicar a estratégia e melhorar a notação | Conferência editorial da correspondência com os resultados certificados |
| Transferir listas e detalhes de implementação para suplemento acessível | Conferência das referências, versões e preservação dos arquivos |
| Resumir uma prova já demonstrada, citando seus lemas e mantendo hipóteses | Conferência matemática da exposição |
| Criar um módulo Lean mais compacto ou alterar sua prova | Verificação do módulo novo e das dependências afetadas; não implica repetir a busca inteira |
| Alterar certificados, dados ou definições | Nova validação dos artefatos afetados; o pacote antigo continua preservado |
| Substituir a etapa finita por um argumento analítico | Nova demonstração e sua verificação; não está estabelecida por esta reorganização |

As três proposições acima organizam resultados já certificados. Não constituem descoberta de uma prova analítica curta que dispense o certificado. A prova atual permanece uma demonstração assistida por computador, com reduções matemáticas e uma etapa finita formalmente verificada.

## Limites que devem continuar explícitos

O resultado é H(12,4). Não conclui H(16,4), dimensões gerais ou inexistência em todo grau no máximo quatro. A identificação da família concreta pelas órbitas deve ser apresentada: o módulo final não acrescentou um teorema abstrato de representação de toda ANF arbitrária.

O baixo grau da restrição a um subespaço, isoladamente, não prova que uma função não é bent. Uma apresentação mais simples não deve substituir a cadeia demonstrada por essa inferência.

Fontes de conferência: [conclusão auditada](CONCLUSAO_FORMAL_H12.md), [módulo final certificado](certified_final_sources/H12Final.lean), [auditoria final](run39520500414_attempt2_AUDIT.json) e [explicação matemática das reduções](../../quartic_audit_2026_10_17/MATHEMATICAL_EXPLANATION.md). Este roteiro é uma apresentação editorial: os artefatos certificados permanecem inalterados.
