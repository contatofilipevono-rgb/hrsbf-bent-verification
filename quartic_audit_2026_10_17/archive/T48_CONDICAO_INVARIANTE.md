# T48: acrescentar informação preservando a simetria

Uma condição isolada no suporte 0x27ff quebra a simetria útil de T40 e produz um modelo de grau cinco no ramo zero. Há uma alternativa certificada: **somar, sobre F₂, os primeiros bits dos quatro suportes relacionados**

`0x27ff, 0x6edf, 0x39ff, 0x5eef`.

Bentness exige que cada um seja zero, logo também exige que sua soma seja zero. A soma é invariante sob as oito unidades módulo 16 e não é implicada pelas treze condições anteriores. Ela tem 13.760 monômios após as três leis lineares; depois do núcleo, os modelos têm 71.568 e 62.152 monômios, ambos de grau quatro. A soma cancela os termos de grau cinco que dificultavam o suporte isolado.

O exemplo `0x75490772421b913c59ac8446a6b1d` passa nas treze condições antigas, mas a soma dos quatro novos bits vale um. Seus coeficientes inteiros nesses suportes são −208, −128, −352 e −168. Dividir por oito e somar dá um número ímpar.

O verificador reconstrói **23.100 partições**, confere as oito invariâncias e as duas substituições completas, e avalia diretamente 20.944 pontos do domínio original para o exemplo. Todos os passos passaram. Isso certifica uma nova condição necessária e sua informação adicional, **sem demonstrar ainda uma nova porcentagem global**.

Na amostra anterior, a soma rejeitou 13 dos 26 sobreviventes das treze condições: três dos dez da descoberta e dez dos dezesseis da validação. São observações finitas, não estimativas globais certificadas.

O próximo experimento é combinar este único bit invariante com os sete bits de T40. A ação do normalizador permanece disponível, permitindo agrupar também os novos caracteres. Isso oferece um caminho mais simples do que acrescentar quatro bits separadamente.

Arquivos: `T48_SOMA_INVARIANTE_CERTIFICADO.json`, `VERIFICAR_SOMA_INVARIANTE_T48.py` e `T48_SOMA_INVARIANTE_VERIFICACAO.json`.
