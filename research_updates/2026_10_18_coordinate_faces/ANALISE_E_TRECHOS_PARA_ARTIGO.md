# Análise do levantamento bibliográfico

Data: 18 de outubro de 2026. Escopo: avaliar o texto enviado, conferir fontes primárias e testar afirmações finitas selecionadas. Esta revisão não conclui a prova global quártica em Lean.

## Conclusão

O material ajuda principalmente no enquadramento bibliográfico, na distinção entre classes de funções e na explicação de por que uma busca sem resultados não equivale a uma prova. Não oferece, por si só, a demonstração que falta ao caso homogêneo quártico em 12 variáveis. A expressão “levantamento exaustivo” deve ser substituída por “levantamento direcionado”: existe pelo menos uma publicação de 2026 diretamente pertinente que ficou de fora.

## 1. Referência omitida de prioridade alta

Lei Sun, Zexia Shi, Jian Liu e Fang-Wei Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, Designs, Codes and Cryptography 94, artigo 93, publicado em 13 de abril de 2026. DOI: [10.1007/s10623-026-01848-4](https://link.springer.com/article/10.1007/s10623-026-01848-4).

A página editorial confirma novos resultados parciais de não existência por relações entre SANF, derivadas e não linearidade. **Correção de 18/10/2026:** a primeira versão desta revisão não recuperou o PDF integral já fornecido pelo usuário nem a comparação existente em `MATHEMATICAL_EXPLANATION.md`. O arquivo local foi agora relido, com SHA-256 coincidente com `SOURCE_ARTICLE.json`: f9c85a57ae37999105fe32855cc5225409db9dd0b3dc8ffd64abf4354aa89e50. Os Teoremas 1–2 exigem uma condição sobre fatores primos que falha para 12; o Teorema 3 depende dos suportes; o Teorema 4(1) cobre uma subfamília, o item 4(2) exige grau pelo menos cinco; os Teoremas 5–6 são cúbicos. Não há nesses enunciados uma exclusão de todo H(12,4). Isso não estabelece novidade frente à literatura inteira. A comparação detalhada e sua quantificação constam de `EVOLUCOES_2026_10_18.md`.

## 2. O que aproveitar

| Trabalho | Uso no artigo | Limite |
|---|---|---|
| Carlet et al., EvoApplications 2026 / preprint de 2025 | Motivar a dificuldade das buscas e distinguir evidência heurística de certificação | Densidade fora da classe rotacional não é densidade dentro dela |
| Tang, ePrint 2026/1799 | Mostrar que simetria rotacional admite bent de grau elevado; a homogeneidade é essencial ao problema | Não constitui resultado de não existência homogênea |
| Carlet–Thornburgh, ePrint 2026/386 | Contextualizar restrições afins e espectros plateaued | A hipótese envolve todos os subespaços de uma dimensão, não somente V_m |
| Cusick–Sanger, arXiv:1708.09313 | Comparação com resultados estruturais anteriores | Seus casos n=2p, com p primo ímpar, não incluem n=12 |
| Tu et al., ePrint 2026/1361 | Contexto opcional de idempotência, simetria e partial spreads | É necessário explicitar a base normal e a correspondência de simetrias para comparações coordenadas |
| Notebook cúbico | Reprodutibilidade do nosso próprio trabalho anterior | Não é validação externa independente nem artigo de terceiros |

Carlet et al. apresentam densidade cúbica em oito variáveis igual a 293760/2^56 ≈ 4,07674 × 10^-12, não inferior a 10^-14. O trabalho encontra funções bent homogêneas cúbicas; não deve ser descrito como evidência geral de inexistência delas. A publicação é de 2026, enquanto o preprint foi submetido em novembro de 2025. Fonte: [texto integral, seção 4.1.2](https://arxiv.org/html/2511.12652v1).

Tang constrói famílias rotacionais em dimensões n=30·7^j e n=70t, com graus de 3 a n/2, fora da classe completada de Maiorana–McFarland. Isso sustenta a distinção conceitual entre grau e homogeneidade; não deve ser extrapolado para todas as dimensões. Fonte: [ePrint 2026/1799](https://eprint.iacr.org/2026/1799).

Carlet–Thornburgh caracterizam classes cujas restrições a todos os subespaços afins de determinada dimensão são plateaued. Para 3 ≤ k ≤ n−2, a classe resultante é a das funções quadráticas. Ter uma única restrição quadrática não satisfaz a hipótese universal e não fornece uma obstrução à bentness. Fonte: [ePrint 2026/386](https://eprint.iacr.org/2026/386).

## 3. O que foi efetivamente conferido no notebook

A API pública do GitHub identifica o proprietário do gist 756516f259c624a6afa60e320768ad2d como **contatofilipevono-rgb**, a mesma conta do repositório deste projeto. Isso esclarece procedência, não autoria humana individual. O arquivo local possui células de código sem execução registrada e sem saídas gravadas. Sua conclusão em Markdown não é um registro de testes executados.

Nesta revisão foi escrita uma implementação separada, sem executar o notebook fornecido. Ela confirmou:

- 4.080 representantes de órbitas completas em F_2^16 fora de V_8;
- 43 geradoras: 35 cúbicas, sete quadráticas completas e uma linear;
- 43 + 903 + 12.341 + 123.410 = 136.697 condições, sem falhas;
- anulação dessas geradoras no subespaço omitido V_8;
- pela matriz de transferência, W_H(0)=85.032.960 em dimensão 32 e wt(H)/32 ≡ 512 (mod 2048).

As verificações sustentam as afirmações finitas de divisibilidade. Elas não demonstram o lema de redução por ordem ímpar para dimensões arbitrárias. O notebook invoca esse lema sem fornecer sua prova. Também não executei nesta revisão a célula de buscas exaustivas para todas as dimensões listadas. Não se deve apresentar esse trabalho como auditoria completa do teorema cúbico global.

Fonte de procedência: [gist](https://gist.github.com/contatofilipevono-rgb/756516f259c624a6afa60e320768ad2d). Os resultados desta revisão estão em `FINITE_LITERATURE_CHECKS.json`, acompanhados de hash da implementação.

## 4. Duas correções matemáticas indispensáveis

### Restrição de grau baixo não implica não bentness

Considere q(x)=⊕_{i=0}^5 x_i x_{i+6}. Ela é simétrica por rotação e bent. Em V_6={(z,z)}, sua restrição é ⊕_i z_i, de grau um. Uma FWHT completa confirmou |W_q(a)|=64 para todas as 4.096 frequências.

Logo, inclusive na presença de simetria rotacional e de V_6=V_6^⊥, grau restrito ≤2 não basta para excluir bentness. Esse exemplo não é quártico; portanto não refuta a conjectura quártica, mas refuta a alegação de que o colapso de grau, sozinho, seria uma obstrução. A identidade de Poisson continua correta; falta uma incompatibilidade adicional demonstrada.

### A divisibilidade cúbica não se transfere diretamente para H(12,4)

Para h(x)=⊕_{i=0}^{11} x_i x_{i+1} x_{i+2} x_{i+3}, com índices módulo 12, a avaliação exata fornece wt(h)=936 e W_h(0)=2224. Como 936 não é múltiplo de 64, o espaço quártico rotacional completo não tem divisibilidade universal de peso por 64. Tal divisibilidade excluiria os pesos bent 2016 e 2080; o exemplo mostra que essa via direta não está disponível para todo o espaço. Não exclui argumentos mais refinados de Ward em subespaços menores.

Também não se deve chamar o teste em dimensão 32 de fronteira universal de todos os métodos de Ward: ele demonstra a falha da congruência específica testada para a família considerada.

## 5. Correções bibliográficas e prioridades

- O DOI fornecido para NOMA está incorreto. A página editorial registra [10.1007/s12095-026-00899-7](https://link.springer.com/article/10.1007/s12095-026-00899-7), volume 18, pp. 1861–1892 (2026). É contexto de aplicações, não prioridade para a prova atual.
- O PDF de Stănică de 2008 está disponível no [site do autor](https://faculty.nps.edu/pstanica/research/rbent.pdf). As páginas e o DOI do levantamento precisam de reconciliação bibliográfica antes da citação final; referências posteriores indicam pp. 214–218, em desacordo com o texto enviado.
- [Zhang–Gao, arXiv:1303.2282](https://arxiv.org/abs/1303.2282) merece inclusão: apresenta resultados parciais de não existência e caracterização quadrática via máximo divisor comum de polinômios. Não é correto atribuir sem qualificação toda a caracterização quadrática ao artigo de 2004.
- Forrelation e amplificação recursiva de resiliência são periféricos ao argumento quártico atual. Não acrescentar citações apenas por coincidência de autores.
- A leitura integral de Sun et al. foi recuperada e conferida nesta continuação. A prioridade bibliográfica seguinte é confrontar as demais condições clássicas com o caso concreto. Nenhuma mudança na execução Lean foi necessária para esta revisão.

## 6. Trechos propostos em inglês

### Introdução: grau, simetria e homogeneidade

Rotation symmetry is compatible with bentness at algebraic degrees greater than two. Recent constructions provide rotation-symmetric bent families across the admissible degree range in specified infinite sequences of dimensions [Tang, 2026]. The nonexistence problem considered here concerns the additional requirement of homogeneity and, specifically, the quartic class on twelve variables.

### Trabalhos relacionados: posicionamento conservador

Structural restrictions on homogeneous rotation-symmetric bent functions have been investigated through several approaches. Cusick and Sanger study the case n=2p with p an odd prime, while Sun, Shi, Liu and Fu obtain further partial nonexistence results using short algebraic normal forms, derivatives and nonlinearity. For n=12 and degree four, the prime-factor hypotheses of the latter paper's Theorems 1–2 fail, Theorem 4(1) covers a restricted support family, and Theorem 4(2) requires degree at least five. Its Theorems 5–6 address cubic functions. These results do not supply a stated exclusion of the entire class H(12,4).

Nota editorial: a comparação com esse artigo foi conferida no PDF integral; a avaliação de novidade frente a toda a literatura continua separada.

### Metodologia: alcance do colapso de grau

The degree drop on the invariant subspace is used as a structural reduction. It does not by itself imply non-bentness: the quadratic rotation-symmetric bent function q(x)=⊕_{i=0}^5 x_i x_{i+6} restricts to an affine function on V_6. Excluding the quartic class therefore requires additional spectral constraints and a complete verification of the candidate-space coverage.

### Discussão: verificações finitas e prova global

The finite divisibility checks for the cubic reduction motivate the search for algebraic obstructions. Their scope must be distinguished from that of a quartic certificate. In twelve variables, the quartic orbit sum h(x)=⊕_{i=0}^{11} x_i x_{i+1} x_{i+2} x_{i+3} has weight 936, ruling out uniform divisibility by 64 for the full quartic rotation-symmetric space. A global exclusion consequently requires a more refined argument or a complete, independently checked certificate.

Os trechos são propostas para integração editorial. Não alteram o manuscrito principal nem anunciam conclusão da prova global em Lean.
