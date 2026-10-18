# Evoluções registradas enquanto o Lean verifica as cartas

Data: 18 de outubro de 2026. A prova global Lean permanece pendente.

## 1. Comparação com Sun–Shi–Liu–Fu recuperada e corrigida

O PDF integral já estava no acervo local. A revisão anterior falhou ao recuperar esse histórico, e foi corrigida. O SHA-256 do PDF é f9c85a57ae37999105fe32855cc5225409db9dd0b3dc8ffd64abf4354aa89e50, igual ao registrado no projeto. A fonte é o artigo DOI 10.1007/s10623-026-01848-4, DCC 94:93 (2026).

| Resultado | Especialização em n=12, grau 4 |
|---|---|
| Teoremas 1–2, pp. 5 e 10 | n=2²·3: a hipótese sobre o primeiro primo ímpar pediria 3>16; falha. |
| Teorema 3, p. 13 | Exige escolha de subconjuntos dos suportes e desigualdades de distâncias. Não é universal. Sua prova usa um conjunto de coordenadas sem monômios contidos. |
| Teorema 4(1), p. 16 | Cada suporte quártico precisa ter duas posições pares e duas ímpares. Há 20 órbitas admissíveis; o espaço tem 2²⁰ vetores, incluindo zero. |
| Teorema 4(2), p. 16 | O grau mínimo é floor(12/4)+2=5. Não se aplica ao grau quatro. |
| Teoremas 5–6, p. 19 | Tratam de órbitas cúbicas. |

Conclusão delimitada: esses enunciados não fornecem uma exclusão de todo H(12,4). Não se conclui novidade universal. Fonte: [artigo](https://link.springer.com/article/10.1007/s10623-026-01848-4); PDF local fornecido pelo usuário, sem redistribuição.

## 2. Cobertura exata do critério de sete coordenadas

Reconstruí as 43 órbitas de suportes quárticos: 40 de comprimento 12, duas de comprimento seis e uma de comprimento três, particionando os 495 suportes. Para cada um dos 792 conjuntos I de sete coordenadas, determinei os geradores que não contêm nenhum monômio inteiramente em I. Seus coeficientes livres formam um subespaço; as demais coordenadas de coeficientes são zero.

Por que isso exclui bentness: a função vale zero no subespaço coordenado U_I, de dimensão sete. Pela soma de Poisson,

    128 = sum_{x in U_I} (-1)^f(x)
        = (1/32) sum_{a in U_I^perp} W_f(a).

Se f fosse bent, cada um dos 32 termos teria módulo 64. O lado direito teria módulo no máximo 64, contradizendo 128. Mais geralmente, max_a |W_f(a)|≥128, dando não linearidade ≤2048−64=1984, abaixo do valor bent 2016. Aqui a contradição depende de uma restrição constante em dimensão sete, maior que a metade; não é a inferência inválida de grau baixo em dimensão seis.

Resultado da contagem, incluindo zero:

- 792 conjuntos de coordenadas produzem 65 espaços distintos maximais de coeficientes;
- as dimensões desses espaços variam de 12 a 24;
- sua união contém exatamente **38.520.999** vetores;
- há **8.796.093.022.208 = 2⁴³** vetores no espaço completo;
- **8.796.054.501.209** não são decididos por esse critério;
- a fração excluída é aproximadamente **0,000437933%**;
- a família de dimensão 20 do Teorema 4(1) está contida nessa união e não deve ser somada novamente.

Essa é uma quantificação nova nesta sessão, não uma reivindicação de novidade matemática. Não foi somada aos filtros existentes, pois há sobreposição. Não equivale à cobertura do certificado global em Lean.

## 3. Verificação da contagem

A implementação usa duas estratégias exatas:

1. Partição recursiva por coeficiente zero/um, com remoção de espaços contidos e memoização: 170.591 estados para o cálculo completo.
2. Inclusão-exclusão dos 65 espaços, agregando interseções idênticas: 3.577 termos finais.

Ambas retornam 38.520.999. Um controle adicional enumera integralmente uma projeção em 12 coeficientes e compara a contagem com a definição direta de pertinência. Essas estratégias verificam a aritmética da união; a justificativa matemática da exclusão foi exposta acima. Não foi executado o Lean para essa nova proposição.

Evidência: `COORDINATE_FACE_COVERAGE.json`; reprodução: `python audit_coordinate_faces.py --out reports`.

## 4. Texto adicional sugerido para a discussão

The coordinate-subspace obstruction admits an exact coverage calculation in H(12,4). For each seven-element coordinate set, we retain precisely those quartic cyclic generators with no monomial supported on that set. The resulting 65 maximal coefficient subspaces have a union of 38,520,999 coefficient vectors, including zero. Two exact counting procedures agree on this value. Every function in this union vanishes on a seven-dimensional subspace, which is incompatible with a flat Walsh spectrum of magnitude 64. This criterion nevertheless leaves most of the 2^43 coefficient vectors undecided and must not be confused with the coverage of the global certificate.

## 5. Estado operacional

O GitHub estava executando a etapa de compilação e repetição pelo núcleo Lean ao início desta continuação: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39173417125 . É um registro de observação, não uma indicação permanente de atividade. O Lean local permanece encerrado; a nova análise terminou em poucos segundos e não inicia outra compilação pesada.

Pendências de conclusão global: conferir as três raízes concretas das cartas, integrar suas refutações e compilar/repetir a declaração global. Resultados parciais, contagens e testemunhos isolados não substituem essas etapas.
