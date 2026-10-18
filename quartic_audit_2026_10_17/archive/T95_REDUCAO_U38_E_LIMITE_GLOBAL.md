# Redução exata das matrizes em U38 e cálculo de um limite global

## Estrutura confirmada

As 26 combinações quadráticas obtidas das 385 condições cúbicas necessárias têm matrizes alternantes de dimensão 38. Reconstruí a aplicação afim completa que associa os 116 coeficientes originais às 26 matrizes: foram determinados 2.138.526 bits de coeficientes matriciais, avaliando a origem e todos os vetores unitários. O grau total no máximo três garante que essa reconstrução é completa.

A aplicação linear conjunta tem posto **16** no espaço original. Mais concretamente, há dezesseis blocos disjuntos de quatro coeficientes com colunas matriciais idênticas dentro de cada bloco; os outros 52 coeficientes não afetam nenhuma matriz. Logo bastam as dezesseis paridades desses blocos. A lei b=L fixa a soma das paridades dos blocos 0,4,10,13. Fixando b, restam **15 parâmetros**, ou **32.768 configurações simultâneas de matrizes por ramo**. Os blocos completos estão em T97_U38_BLOCOS_DE_PARIDADE.json. O número de parâmetros das matrizes não é o número de parâmetros das equações completas: seus termos lineares e constantes ainda podem depender de outros coeficientes.

As coordenadas originais c23,c31,c39,c57,c112 estão entre as que não alteram nenhuma das 26 matrizes. A afirmação correspondente do Gemini foi, portanto, confirmada por coeficientes completos. O núcleo conjunto da aplicação linear original tem dimensão 100 e contém U38.

Foram enumerados todos os estados das matrizes individuais. No ramo b=1, o maior posto entre as 26 matrizes é 30 em 512 estados e 32 em 32.256 estados. No ramo b=0, esse máximo varia de 2 a 32. Esses dados não dão os postos de todas as combinações lineares; o cálculo do limite abaixo enumera também cada caráter utilizado.

## Peso exato do núcleo em cada estado

Seja C7 o núcleo de seis condições antigo acrescido do primeiro bit de h(0x7f7f). Sua densidade é 13/1024. As oito paridades u1,v1,...,u4,v4 da forma normal são determinadas pelo estado de 15 bits e por b. Isso foi verificado em todas as colunas da aplicação linear, e não inferido de amostras.

Fixe um estado t e b. Escreva

`K=u2+v2+u4+v4`, `M=u3+v3`, `J1=v2+u4`, `J2=u2+v4`, `J3=v3+u4+v4`,

com somas em F2. A condição Q5 exige b(a+K)=0, e Q7 determina `R=(1+b)M+(1+a)K`. Depois disso o novo bit é

`b+K+M+b*r23+R*J3+(a+alpha3)*K+alpha1*(M+J1)+alpha2*(M+J2)`.

As cinco formas R,r23,alpha1,alpha2,alpha3 são independentes e usam coeficientes invisíveis às matrizes. As variáveis a e c23 também são invisíveis às matrizes. Q4 determina c23 unicamente, e Q7 determina R unicamente. Logo podemos contar exatamente, entre as 32 escolhas de a e dos quatro bits r23,alpha1,alpha2,alpha3, aquelas que satisfazem Q5 e o novo bit. Chame essa contagem de n_b(t).

A medida global de C7 no estado (b,t) é **n_b(t)/2^26**. Os totais obtidos foram

- soma_t n_0(t)=589.824;
- soma_t n_1(t)=262.144;
- soma_b,t n_b(t)/2^26 = 13/1024.

Um segundo código calcula os mesmos pesos sem enumerar os quatro bits: quando pelo menos um coeficiente linear deles é não nulo, exatamente oito das dezesseis escolhas passam; caso contrário passam todas ou nenhuma, conforme a constante. Não há hipótese de independência probabilística entre os filtros.

## Fórmula do limite

Escolhemos sete combinações, com índices 7 a 13 na base exata do certificado T88. São condições necessárias para bentness. Para um caráter não nulo lambda em F2^7, seja B_lambda(b,t) a matriz da combinação correspondente.

Como C7 é união de cosets de U38, em cada coset podemos somar os caracteres das sete equações. O módulo do viés de uma função quadrática de matriz alternante de posto r é no máximo 2^(-r/2). Portanto

`Pr(bent) <= 2^-7 * sum_(b,t) [n_b(t)/2^26 * (1 + sum_(lambda != 0) 2^(-rank B_lambda(b,t)/2))]`.

Essa é uma cota global: todos os estados foram incluídos com seus pesos exatos. Os termos lineares desconhecidos podem anular o viés; substituí-los pelo majorante de posto preserva a direção da desigualdade.

Como os postos são pares e no máximo 38, o cálculo inteiro equivalente tem denominador 2^52:

`Pr(bent) <= [sum_(b,t) n_b(t) * (2^19 + sum_(lambda != 0) 2^(19-rank B_lambda(b,t)/2))] / 2^52`.

O produtor usa eliminação pelo pivô mais alto. O verificador independente usa pivôs mais baixos e outra fórmula para os pesos. Ambos percorrem os 127 caracteres não nulos e os 32.768 estados de cada ramo. A independência aqui é de implementação do cálculo de postos e pesos; os certificados de matrizes e de grau são entradas comuns explicitamente identificadas.

## Controles nas funções originais

Uma implementação com tabelas completas de verdade e pesos de subcubos, independente do produtor de bits paralelos, conferiu 624 entradas matriciais por segundas diferenças e 37.730 pesos de subcubos. Todos os controles passaram.

Também foram encontrados exemplos em dois cosets que satisfazem as 26 combinações quadráticas, mas falham em 158 e 191 das 385 condições completas. Isso demonstra que satisfazer as 26 combinações não basta para bentness. Um terceiro piloto, de dez segundos, foi inconclusivo. A nova estrutura serve para limites e decomposição da busca; não encerra a inexistência em H(16,4).

## Arquivos de reprodução

- T88_U38_COEFICIENTES_EXATOS.json: base U38 e componentes cúbicas completas.
- T89_U38_MATRIZES_AFINS_CERTIFICADO.json: aplicação afim das 26 matrizes.
- T91_U38_ENUMERACAO_MATRIZES.json: coordenadas de 15 bits, histogramas e todos os vetores de postos em formato comprimido sem perda.
- T92_U38_LIMITE_PONDERADO.json: cálculo racional e histogramas ponderados por caráter.
- VERIFICAR_LIMITE_U38_T94.py e T94_LIMITE_U38_VERIFICACAO.json: reprodução independente completa dos postos e pesos do limite.
- T93_CONTROLES_INDEPENDENTES_U38.json: controles nas funções originais.

Não foi investigada a novidade bibliográfica desses resultados.

## Resultado com sete combinações adicionais

O produtor calculou e o verificador independente confirmou exatamente:

`Pr(f bent) <= 58424985 / 549755813888 = 58424985 / 2^39`.

Consequentemente, a exclusão é de **pelo menos 99,9893725571%**, com a casa decimal exibida arredondada para baixo. O valor aproximado é 99,98937255713827%. Esse limite supera o antigo T47 auditado e também a cota Top26 relatada pelo Gemini, sem depender dos perfis Top26 ausentes.

Foram conferidos todos os histogramas dos 127 caracteres em ambos os ramos por outra eliminação de postos e por outro cálculo dos pesos. As oito partições da verificação independente levaram no máximo 113,492 segundos cada, executadas em paralelo. O tempo de agregação desses resultados é registrado separadamente e não deve ser confundido com o tempo da verificação completa.

O resultado é um limite superior para uma família de condições necessárias. Não afirma que existam funções bent entre os sobreviventes, nem prova inexistência global.

## Resultado melhorado com oito combinações adicionais

Acrescentamos a combinação de índice 14, reutilizando os 127 caracteres já verificados e calculando os 128 caracteres novos. Para cada estado de peso não nulo, o posto de cada matriz nova foi comparado por duas eliminações, uma com pivô mais alto e outra com pivô mais baixo. As oito partições terminaram com PASS; a extensão levou aproximadamente 161 segundos em paralelo.

O novo limite global é

**`Pr(f bent) <= 2011309 / 34359738368 = 2011309 / 2^35`**.

Portanto a exclusão é de **pelo menos 99,9941463203%**, com o decimal exibido arredondado para baixo. O valor aproximado é 99,99414632038679%. Esse passa a ser o melhor limite global verificado desta pesquisa.

Agora são oito combinações quadráticas adicionais ao núcleo C7: quinze condições necessárias no total. Na fórmula acima substituímos sete por oito, somamos os 255 caracteres não nulos e usamos denominador inteiro 2^53 antes de simplificar a fração. O piso do majorante por caracteres dessa versão é 13/262144; isso não é um limite inferior para a densidade verdadeira.

T96_U38_LIMITE_OITO_CONDICOES.json contém todos os histogramas e a fração final. VERIFICAR_EXTENSAO_U38_T96.py recalcula os caracteres novos com as duas eliminações. VERIFICAR_CADEIA_U38_T98.py confere rapidamente a consistência dos certificados de grau, compressão, paridades e agregação racional; essa checagem rápida é distinta da enumeração completa dos postos.

| Resultado | Passagem máxima | Exclusão mínima exibida |
|---|---|---:|
| Antigo T47 auditado | 2943198307753433/2^63 | 99,9680897800% |
| Top26 Gemini, postos ainda pendentes | 3469169466878495/2^64 | 99,9811935946% |
| U38, sete combinações, replay independente | 58424985/2^39 | 99,9893725571% |
| **U38, oito combinações, extensão com duas eliminações** | **2011309/2^35** | **99,9941463203%** |

Os quinze bits utilizados nesta última linha não são os mesmos dos sistemas históricos de treze/quatorze condições. Os resultados são comparados como cotas globais para bentness, sem identificar famílias distintas de filtros pelos rótulos Txx.
