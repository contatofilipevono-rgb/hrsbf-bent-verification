# Dois documentos novos: pertinência e sobreposição com H(12,4)

Leitura em 21/10/2026. Foram examinados os PDFs enviados, os enunciados e parâmetros relevantes e as fórmulas citadas abaixo. Não é auditoria integral das demonstrações desses autores nem pesquisa exaustiva de prioridade.

## Conclusão

Não foi identificado nesses dois documentos um resultado que resolva o espaço homogêneo quártico H(12,4), nem um contraexemplo ao nosso enunciado. Ambos são relevantes para a introdução: impedem confundir não existência homogênea com não existência de funções bent rotacionais de grau elevado.

## Polujan, Kudin e Pasalic

*Rotation-symmetric bent functions outside the completed Maiorana–McFarland class*, IEEE Transactions on Information Theory 72(6), 4341–4351 (2026), DOI [10.1109/TIT.2026.3685133](https://doi.org/10.1109/TIT.2026.3685133). O PDF fornecido é um manuscrito aceito de 15 páginas; a paginação publicada é diferente. A publicação foi conferida na IEEE e no repositório institucional da University of Primorska.

Três partes precisam ser distinguidas:

| Parte | Escopo verificado | Relação com nosso alvo |
|---|---|---|
| Classificação cúbica, Seção III | Funções RS bent cúbicas em dez variáveis, sob equivalência EA | Não é classificação de H(12,4); grau três não equivale a homogeneidade cúbica |
| Equação IV.1 e Teorema IV.6, páginas 6 e 8 do AAM | Família de grau máximo n/2 fora de M# | Em n=12, tem grau seis, e não quatro |
| Teorema V.6, página 13 do AAM | Família quártica em n=2m com m ímpar e 3 não dividindo m | n=12 exige m=6, que não satisfaz a hipótese |

Foi conferido diretamente o exemplo da Equação IV.1 em n=12, m=6. Sua ANF contém seis monômios de grau 2, doze de grau 5 e doze de grau 6. É simétrica por rotação, e os 4096 valores absolutos de Walsh são 64. Portanto é um controle positivo bent, mas não pertence a H(12,4). Essa conferência foi feita por ANF e Walsh exatos em Python; não foi teste do antigo kernel CUDA.

O teste ajuda a evitar uma comparação conceitualmente errada: não é a simetria rotacional isolada que impede bentness. A homogeneidade no sistema de coordenadas fixado é uma hipótese essencial do nosso problema.

## Deng Tang

*Two Constructions of Rotation-Symmetric Bent Functions Outside the Completed Maiorana–McFarland Class with Any Possible Algebraic Degree*, [Cryptology ePrint Archive 2026/1799](https://eprint.iacr.org/2026/1799). O arquivo enviado tem 22 páginas. O registro oficial o identifica como preprint, recebido em 25/08/2026 e aprovado no ePrint em 28/08/2026; aprovação para o arquivo não significa avaliação por pares.

O Teorema 4.5, página 14, usa n=30·7^j, j≥0. O Teorema 5.4, página 18, usa n=70t, t≥1. Nenhum conjunto de parâmetros contém doze. A expressão “any possible algebraic degree” significa que esses conjuntos de dimensões admitem os graus de 3 até n/2; não significa que todas as funções construídas sejam homogêneas nesses graus, nem que todas as dimensões pares estejam cobertas.

O uso de bases normais para relacionar invariância por Frobenius e simetria por rotação é relevante como contexto, mas não é uma nova etapa necessária à nossa prova concreta. Uma mudança linear invertível preserva grau e bentness, porém não preserva necessariamente homogeneidade. Não se deve decidir homogeneidade apenas olhando expoentes de polinômios univariados sobre corpos finitos.

## Alteração no manuscrito

Foi incluído na introdução um parágrafo distinguindo esses resultados construtivos do nosso alvo. O artigo publicado de Polujan–Kudin–Pasalic recebeu entrada bibliográfica. O trabalho de Tang foi identificado como preprint com ligação ao registro oficial, sem lhe atribuir publicação em periódico.

Não foram importados resultados sobre M-subespaços para sustentar a inexistência em H(12,4): excluir pertencimento à classe M# não equivale a excluir bentness. Tais ferramentas podem ser relevantes para pesquisas posteriores sobre equivalência e classificação.

As evidências reproduzíveis estão em `LITERATURE_OVERLAP_AUDIT.json` e no script `review_new_literature.py` preservado com o checkpoint. Não foi estabelecida prioridade absoluta do teorema diante de toda a literatura.
