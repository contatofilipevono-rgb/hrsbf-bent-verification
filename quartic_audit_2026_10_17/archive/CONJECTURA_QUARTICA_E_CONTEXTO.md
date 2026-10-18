# Conjectura quártica e contexto bibliográfico

Defina H(n,4) como o espaço das funções booleanas homogêneas de grau quatro invariantes pela rotação cíclica das n variáveis; a função zero também pertence ao espaço.

**Conjectura quártica.** Para todo inteiro par n ≥ 8,

`H(n,4) ∩ Bent(n) = ∅`.

Equivalentemente, para cada f em H(n,4), existe alguma frequência a tal que `|W_f(a)| ≠ 2^(n/2)`. Pela identidade de Parseval, isso equivale a `max_a |W_f(a)| > 2^(n/2)`.

Um contraexemplo deve apresentar uma função homogênea quártica invariante por rotação e comprovar `|W_f(a)|=2^(n/2)` em todas as frequências. A ausência de contraexemplos numa dimensão não implica a ausência em outra, pois os espaços e as simetrias dos monômios mudam com n.

## Evidência do projeto

A busca global recebida em H(12,4) cobriu os 2^43 coeficientes, com base identidade e sem impor as cinco leis iniciais. O log reporta 949.760 sobreviventes quadráticos, 15.779 sobreviventes de W(0) e zero bent após Walsh completo. A auditoria local validou a fonte, os filtros por uma construção independente e todos os 8.388.608 registros de lote. A enumeração GPU não foi repetida localmente.

Isso dá um resultado computacional para n=12 e evidência para a formulação geral; não é uma prova para todos os n. H(16,4) continua sendo um alvo específico do projeto, separado da cota de exclusão já obtida nessa dimensão.

## A conjectura geral não deve ser atribuída a este projeto

A conjectura quártica é um caso particular da conjectura de Stănică–Maitra de inexistência de funções bent homogêneas invariantes por rotação de grau maior que dois. Ela aparece como Conjectura 12 em:

P. Stănică e S. Maitra, *Rotation symmetric Boolean functions—Count and cryptographic properties*, Discrete Applied Mathematics 156 (2008), 1567–1580. DOI: <https://doi.org/10.1016/j.dam.2007.04.029>.

O enunciado e a atribuição também aparecem na Conjectura 1.1 de X. Zhang e G. Gao, *On the conjecture about the nonexistence of rotation symmetric bent functions* (2013): <https://arxiv.org/abs/1303.2282>.

Um trabalho de L. Sun, Z. Shi, J. Liu e F.-W. Fu publicado em 2026 anuncia novos resultados parciais: <https://link.springer.com/article/10.1007/s10623-026-01848-4>. Foi consultado o resumo oficial; o texto integral não foi analisado nesta etapa. Portanto não foi verificado quais casos específicos esse artigo resolve, nem se a inexistência quártica em n=12 já está coberta por resultados anteriores.

A contribuição que podemos descrever agora é a execução e a auditoria reproduzível do caso quártico em 12 variáveis. Sua novidade científica exige comparação detalhada com a literatura. Uma contribuição adicional possível é uma prova analítica de uma família de dimensões ou um método de certificação mais eficiente; nenhum desses avanços é afirmado aqui como concluído.
