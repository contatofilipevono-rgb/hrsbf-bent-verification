# Refinamento T29: onde as restrições quadráticas ficam equilibradas

## Resultado certificado

As seis condições necessárias para bentness deixam uma fração no máximo

`13538819371023 / 562949953421312`.

Portanto excluem pelo menos

`549411134050289 / 562949953421312 ≈ 97,59502256128786%`.

Esse resultado melhora o limite de 495/512 de T28 usando a mesma sexta condição. Não é uma sétima condição e não calcula a densidade exata de sobreviventes. O problema completo de inexistência e a conjectura C16 continuam abertos.

## Por que o radical ajuda

T28 restringiu cada ramo a um conjunto S de coordenadas, obtendo uma forma quadrática fixa q_S mais termos afins dependentes das coordenadas externas. Seu posto polar r é dois no ramo c99=0 e quatro no ramo c99=1.

Seja d uma direção do radical da forma polar. A derivada binária

`R_d(y)=P(y,x+d)+P(y,x)`

independe de x∈S. Quando algum R_d(y)=1, a translação por d emparelha os valores zero e um de P na fatia: exatamente metade da fatia passa. Somente quando todos os R_d(y) são zero o limite mais fraco de T28 pode ser atingido.

Nesta construção todos os R_d são polinômios quadráticos nas coordenadas externas. O certificado reconstrói as derivadas e confere esse fato termo a termo. As dimensões dos radicais são seis e dois.

## Densidade exata do conjunto excepcional

Se R_1,…,R_k são as derivadas de uma base do radical, a fração Z de atribuições externas em que todas são zero é

`Z = 2^(−k) Σ_{t∈F₂^k} E_y (−1)^(Σ t_i R_i(y))`.

As 64 somas quadráticas do ramo zero e as quatro do ramo um foram calculadas em aritmética racional exata. Resultados:

| ramo c99 | dimensão radical | posto polar r | Z exato |
|---|---:|---:|---:|
| 0 | 6 | 2 | 69801930767/4398046511104 |
| 1 | 2 | 4 | 1/4 |

Fora desse conjunto excepcional a fração que passa é 1/2. Dentro dele é no máximo 1/2+2^(−r/2−1), pelo módulo da soma de uma forma quadrática de posto r. Logo

`passagem condicional ≤ 1/2 + Z·2^(−r/2−1)`.

Isso fornece 8865894952975/17592186044416 no ramo zero e 17/32 no ramo um. Multiplicando pelas medidas originais dos dois ramos, 1/32 e 1/64, obtém-se o limite anunciado.

Não foi necessário assumir independência das equações R_i: sua densidade conjunta foi calculada pela identidade exata de Fourier acima.

## Dupla verificação

O gerador dos dados usa eliminação de pares na soma quadrática: somar sobre um par x,y substitui `xy+xL+yM+Q` por `LM+Q`, com fator dois.

`VERIFICAR_REFINAMENTO_T29.py` usa outro caminho: constrói uma base simplética da forma polar, verifica o comportamento no radical e calcula o sinal pelos pares simpléticos. Os 68 valores coincidiram exatamente. O verificador também reconstrói cada derivada a partir dos polinômios completos de T28 e confirma todas as frações finais.

Execute primeiro `VERIFICAR_SEXTA_CONDICAO.py` e depois `VERIFICAR_REFINAMENTO_T29.py`, na pasta que contém `T28_SEXTA_CERTIFICADO.json` e `T29_RADICAIS_CERTIFICADO.json`. Ambos usam somente Python padrão.

Uma melhoria adicional exigiria controlar o sinal das fatias quadráticas no conjunto excepcional, obter uma parametrização mais favorável ou incorporar outras condições. Novidade bibliográfica ainda não foi estabelecida. Os limites aqui não foram transportados para o domínio GPU T27.
