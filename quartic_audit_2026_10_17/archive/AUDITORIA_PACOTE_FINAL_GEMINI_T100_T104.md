# Auditoria do pacote final Gemini: W98 e H(12,4)

## Conclusão

O novo W98 é uma estrutura válida e útil. Confirmei simbolicamente sua dimensão, a inclusão de U38 e as dezessete condições quadráticas com matrizes dependentes de oito paridades. Entretanto, há um erro no cálculo das matrizes constantes do verificador global, confirmado por um contraexemplo direto nas funções originais. A fração anunciada foi reproduzida pelo código, mas isso não certifica a cota matemática enquanto esse erro não for corrigido.

Há ainda um obstáculo estrutural: um subespaço de dimensão **102** satisfaz o núcleo C7 e todas as dezessete condições W98 identicamente. Sua densidade é **1/16384**. Para melhorar nosso limite atual, será necessário acrescentar condições que cortem essa família.

O melhor limite global verificado desta pesquisa permanece **2011309/2^35 de passagem**, ou **exclusão de pelo menos 99,9941463203%**. Nenhum resultado deste pacote prova inexistência em H(12,4) ou H(16,4).

## Identificação e recuperação do ZIP

O arquivo em Downloads tem 48.297 bytes e seu diretório ZIP é inválido. O original local do Gemini tem 27.180 bytes e SHA-256

`fa22426b73838a80bc782d971839130b20bbdb0e4281928f1904f66d9a7e8c15`.

Esse hash coincide com o fornecido no relato. Conferi também a igualdade exata entre o arquivo recebido e a transformação destrutiva `original.decode('utf8', errors='replace').encode('utf8')`. A cópia íntegra foi salva em PACOTE_GEMINI_FINAL_ORIGINAL_INTEGRO.zip. O original e o conteúdo extraído foram preservados.

O pacote contém dez arquivos. Ele não é autossuficiente: faltam módulos importados, entre eles check_joint_cubic_rank_and_syzygies.py, inspect_26_quadratic_in_U_conditions.py, verify_14parity_normal_form.py, derive_0x7f7f.py e inspect_16_bilinear_forms.py. O verificador histórico de quatorze condições também depende de arquivos ausentes. A execução direta do script H12 falhou por falta de inspect_26_quadratic_in_U_conditions.

Para continuar a auditoria, construí uma pasta de trabalho separada, acrescentando dependências já disponíveis. As alterações dessa cópia foram registradas; o ZIP original não foi modificado.

## Comparação pelo conteúdo, sem confundir Txx

| Resultado | Passagem máxima declarada | Situação |
|---|---|---|
| Nosso U38, oito combinações adicionais ao núcleo C7 | 2011309/34359738368 | Verificado anteriormente, continua o melhor limite auditado |
| Novo W98 Gemini, dezessete combinações | 2284269821/35184372088832 | Número reproduzido, porém o verificador usa matrizes constantes incorretas |
| Subespaço sobrevivente do sistema C7+17 W98 | Densidade exata pelo menos 1/16384 | Confirmado nesta auditoria; trata de sobreviventes dos filtros, não de funções bent |

A passagem máxima declarada pelo W98 é cerca de 10,91% maior que a nossa atual, portanto seria uma cota de exclusão um pouco mais fraca mesmo após validação. Um subespaço maior para somação não torna automaticamente a família de filtros mais seletiva.

## W98: o que passou

Construí W98 como soma direta de 56 direções que preservam as oito paridades u/v e de 42 direções que anulam seis formas adicionais. Conferi:

- posto 98 da base;
- posto 18 das formas do quociente;
- U38 contido em W98;
- preservação dos dados da forma normal do núcleo C7;
- grau no máximo dois das dezessete combinações em todos os cosets de W98, pelo anulamento simbólico do tensor cúbico nas direções do subespaço;
- igualdade das colunas de derivadas dentro de cada bloco u/v e anulamento fora desses blocos, provando a dependência das matrizes apenas nas oito paridades.

O certificado T101_W98_ESTRUTURA_SIMBOLICA.json contém base, matrizes corrigidas e derivadas por paridade. Esse cálculo simbólico levou cerca de 160 segundos nesta execução. A validade dessa estrutura não depende da cota global anunciada.

## Erro nas matrizes constantes

O verificador constrói B_const usando somente os monômios quadráticos da ANF original. Ao substituir coeficientes por formas lineares booleanas sobre W98, monômios cúbicos também podem produzir termos quadráticos, porque z²=z.

Se A,B,C são as máscaras de três formas lineares, a contribuição quadrática de seu produto inclui

`wedge(A&B,C) + wedge(A&C,B) + wedge(B&C,A)`.

Essas contribuições foram omitidas. Em todas as dezessete combinações, elas cancelam a matriz constante calculada pelo código. Os postos constantes corretos são todos zero; os postos calculados pelo verificador variam de 12 a 32. Na primeira combinação, o código obtém posto 30 e o posto correto é zero.

**Contraexemplo executável independente.** Para a primeira sizígia, tome as direções de coeficientes d=0x11 e e=0x8002, correspondentes aos vetores 0 e 15 da base W98. Os valores da condição original em 0,d,e,d+e são todos zero. A segunda diferença é, portanto, zero. A matriz constante construída só com a parte quadrática global prevê um.

VERIFICAR_CONTRAEXEMPLO_W98_T102.py confirma isso com tabelas de verdade originais e pesos de subcubos, usando somente Python padrão. Ele não importa o gerador de ANF do Gemini. T102_CONTRAEXEMPLO_INDEPENDENTE.json registra o resultado.

Na cópia com dependências completadas, reexecutei o cálculo global original, limitando apenas o número de processos a oito. Ele terminou em cerca de 86 segundos e reproduziu exatamente a fração 2284269821/35184372088832 e o histograma de 1.011.712 matrizes. Essa reprodução confirma a aritmética do programa, mas não remove o erro das matrizes utilizadas. Não concluí que a fração seja necessariamente falsa como desigualdade; concluí que o verificador apresentado não a certifica.

O percentual declarado 99,9935077147% também foi arredondado para cima. A exibição segura para uma desigualdade de exclusão, caso a fração seja validada, seria 99,9935077146%.

## A célula p8=0 e a família de dimensão 102

O relato afirma que a célula tem posto linear dez e passagem 1/1024. A execução do próprio código imprime passagem média **1/2**, com contribuição global **1/16384**.

Refiz o cálculo usando todos os 32 representantes admissíveis dessa célula e a base W98, com as matrizes constantes corretas iguais a zero. As dezessete condições são afins nas 98 coordenadas. O resultado exato foi:

- dezesseis cosets: todas as condições são identicamente zero, e todo o coset passa;
- dezesseis cosets: o sistema afim é inconsistente, e nenhum ponto passa.

Os dezesseis cosets que passam correspondem a a=0 e às quatro paridades restantes livres. São a soma de W98 com quatro direções independentes. Conferi posto **102** da base ampliada. Logo existe uma família linear de **2^102 funções** que satisfaz C7 e todas as dezessete condições W98. Sua densidade no espaço de dimensão 116 é 2^-14=1/16384.

Isso não é uma família de funções bent. É uma família que os filtros atuais não conseguem eliminar. Mesmo que todos os outros estados fossem excluídos, somente C7 e essas dezessete condições ainda deixariam uma densidade maior que nosso limite atual de passagem para um sistema diferente de condições. Para aproveitar W98, é indispensável acrescentar filtros que atuem nessa célula.

T104_W98_CELULA_ZERO_EXATA.json registra os 32 sistemas afins, os quatro vetores adicionais e os índices dos cosets sobreviventes.

## H(12,4): redução confirmada sob hipótese explícita

O script solve_H12_4_system.py começa impondo cinco leis lineares prontas. Não encontrei, nos arquivos fornecidos, certificados ou uma demonstração completa da necessidade dessas cinco leis. A auditoria independente de congruências de grau baixo confirmou algumas consequências lineares, mas não derivou o conjunto inteiro. Isso não refuta as cinco leis; mantém sua necessidade pendente de demonstração.

**Assumindo as cinco leis iniciais**, confirmei rigorosamente os pontos seguintes:

1. Sua matriz tem posto cinco e deixa 38 coordenadas livres.
2. As 47 expressões que o script utiliza têm grau no máximo dois nesse domínio. A justificativa não usa cubos aleatórios: agrupei os pontos de entrada pela mesma assinatura linear nos coeficientes e certifiquei as multiplicidades divisíveis apropriadas. Cada bit considerado é então o segundo bit de uma soma inteira de formas lineares, o que dá grau no máximo dois.
3. A interpolação em origem, pontos simples e pares é, portanto, completa. Reproduzi as duas leis adicionais pela anulação das partes quadráticas e confirmei que são independentes módulo as cinco iniciais.
4. As sete leis têm posto sete, deixando dimensão 36.
5. Houve 1.504 controles adicionais das expressões em pontos densos.

A contagem de “45 equações quadráticas ativas” não corresponde à extração reproduzida. O código coleta 47 expressões; 43 são não nulas no domínio de dimensão 38, com posto linear polinomial 41. Após impor as sete leis, 42 das expressões permanecem não nulas. Esses números não são contagens de soluções.

T100_H12_REDUCAO_EXATA_VERIFICACAO.json marca expressamente PASS_CONDITIONAL. A interpolação de baixo grau e os testes em cubos não constituem enumeração de 2^36 funções. Também não foi executado nem medido um teste de GPU que sustente a previsão de uma fração de segundo.

## Próximo caminho recomendado pelos resultados

Preservar a decomposição W98 e corrigir suas matrizes é útil: oito paridades podem permitir uma partição mais barata que a de quinze parâmetros. Porém a prioridade para melhorar a seletividade é a célula p8=0. Uma possibilidade concreta é aplicar nela as condições adicionais que já usamos em U38 e usar W98 nas demais células, construindo um limite híbrido com pesos exatos. Isso precisa de novo cálculo e verificação; não é um resultado já certificado.

Em H(12,4), a próxima exigência é obter certificados da necessidade das cinco leis iniciais. Depois disso, um solver ou uma enumeração exata pode testar o sistema de dimensão 36. Até lá, as afirmações devem ser apresentadas como redução condicional, e não como prova de inexistência.

Os rótulos T100–T104 neste relatório identificam nossa auditoria; não são equivalências automáticas com os nomes usados pelo Gemini. Os briefings anexos foram tratados como material de análise, não como autorização para enviar mensagens externas.
