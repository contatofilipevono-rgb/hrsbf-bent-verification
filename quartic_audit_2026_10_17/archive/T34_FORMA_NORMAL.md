# T34: uma forma normal curta para seis condições

As três leis lineares e as condições quarta, quinta e sétima podem ser reunidas em **11 paridades agregadas**. Isso substitui a apresentação em centenas de monômios por duas reconstruções e uma única proibição. É uma reorganização exata dos resultados demonstrados, não uma condição nova.

## Coordenadas

Use u_i e v_i para as duas paridades do i-ésimo produto da condição Q4, i=1,…,4. Defina `a=c57`, `t=c23+c31+c39+c112`, e R como a paridade dos 24 índices da condição sétima. Todas as somas e produtos são em F₂. Os conjuntos completos constam dos certificados T28 e T31, lidos pelo verificador.

As três leis lineares são `c115=0`, `c113=a`, `c99=u1+v1`. Escreva

`b=u1+v1`, `K=u2+v2+u4+v4`, `M=u3+v3`.

As três condições restantes tornam-se

`t = a + u1v1+u2v2+u3v3+u4v4`,

`b(a+K)=0`,

`R = (1+b)M + (1+a)K`.

Basta escolher as oito paridades u_i,v_i e o bit a, proibir apenas o caso b=1 e a≠K, e reconstruir t,R. Não há dependência circular.

## Contagem de 512 casos

As três leis e as 11 formas agregadas têm posto conjunto 14 nos 116 coeficientes. Cada atribuição a esses 14 bits tem exatamente 2¹⁰² representantes no espaço original.

Das 512 escolhas dos nove bits u_i,v_i,a, o ramo b=0 admite 256; o ramo b=1 exige a=K e admite 128. Há 384 padrões válidos, cada um com 2¹⁰² representantes. A fração original é `384·2¹⁰²/2¹¹⁶=3/128`.

Esse núcleo de dimensão 102 é irrelevante apenas para as seis condições aqui reunidas. A sexta condição, as outras obstruções inteiras e bentness podem variar ao longo dele.

## Verificação

`VERIFICAR_FORMA_NORMAL_T34.py` confere as identidades dos conjuntos, o posto 14 e todos os 512 casos. Usa somente Python padrão e os certificados T28/T31 da mesma pasta. A forma normal facilita geração de candidatos, comparação de ramos e apresentação do manuscrito. O limite global que inclui a sexta condição continua sendo o certificado em T32, até que novos refinamentos sejam demonstrados.
