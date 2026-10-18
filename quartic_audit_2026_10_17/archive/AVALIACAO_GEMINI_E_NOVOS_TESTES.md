# Avaliação das evoluções do Gemini e testes complementares

O texto contém identidades úteis e observações estruturais corretas. Sua conclusão de inexistência global não decorre dos experimentos apresentados. A avaliação abaixo se refere ao texto e ao código nele reproduzido; não pressupõe acesso aos demais scripts mencionados.

## Confirmado

As identidades para W(0) e W(1^16), os quatro pares de contadores para cada (a,b) e a tabela target_pairs estão corretos sob as três leis T20. Coincidem com a codificação conjunta que já implementamos e validamos. As quantidades de órbitas também conferem: 36 curtas, 2032 completas pares e 2048 completas ímpares.

Recalculamos os pesos dos 116 geradores e confirmamos:

- Todos os pesos sobre as órbitas completas ímpares são divisíveis por 8.
- Os 16 geradores que falham divisibilidade por 4 nas órbitas completas pares são exatamente o conjunto L=u1 união v1 listado no texto.
- Os geradores de peso 4 módulo 8 nessa classe são exatamente T={23,31,39,112}.

Isso é uma correspondência concreta com T34. A reconstrução da forma normal inteira exige controlar também as interseções entre geradores: o peso de uma soma XOR não é a soma dos pesos individuais. De fato, nas órbitas pares existem 128 triplas de geradores cuja interseção tem tamanho ímpar, produzindo termos cúbicos na expansão do peso módulo 8. Os dados individuais não bastam para encerrar essa derivação.

## Uma conclusão estrutural adicional

Nas órbitas completas ímpares, verificamos também todas as 6670 interseções de pares e todas as 253460 interseções de triplas:

- cada interseção de dois geradores tem tamanho divisível por 4;
- cada interseção de três geradores tem tamanho par.

Pela inclusão-exclusão para o peso de uma soma XOR, isso implica que **w_ímpar é divisível por 8 para toda função em H(16,4)**. Trata-se de uma consequência para todos os vetores de coeficientes, obtida a partir de verificações finitas completas dos geradores e da identidade algébrica.

Esse resultado não é uma obstrução aos contadores de bentness: 1016, 1024 e 1032 são todos divisíveis por 8. Não reivindicamos novidade bibliográfica para o lema de divisibilidade nem para sua aplicação.

## Correções necessárias

1. A identidade simplificada com apenas a e b exige as três leis T20. Ela não vale para toda H(16,4). Um contraexemplo explícito é c=2^115: a=b=0, w_par=416, w_ímpar=424; o lado direito simplificado seria 256, mas W(1^16)=16. Isso não afeta seu uso para candidatos bent que satisfazem aquelas leis.

2. Nenhuma sobrevivente entre 5000 amostras não implica que o sistema inteiro seja insatisfatível. O texto não apresenta um certificado UNSAT nem uma dedução da contradição para todos os coeficientes.

3. Mais restrições do que variáveis não demonstram incompatibilidade. As contagens são funções dependentes e não lineares dos coeficientes; a dependência precisa ser tratada explicitamente.

4. O diagnóstico dos timeouts não foi demonstrado. O componente antigo de W(0) tinha 20151 variáveis auxiliares e 36289 cláusulas CNF. Grande parte das centenas de milhares de cláusulas do sistema completo vinha dos produtos dos filtros algébricos. A formulação em cardinalidades não elimina automaticamente essa dificuldade de busca.

## O que os nossos novos testes mostram

Acrescentamos a amplitude na frequência 0x0101 com pesos orbitais exatos. O componente passou em 256 atribuições pequenas exaustivas, em controles positivos e negativos e na comparação com os 512 valores anteriores. Os testes limitados do sistema completo e do núcleo menor terminaram sem decisão; não produziram prova UNSAT.

Uma amostra nova, com semente previamente fixada e tamanho fixo de 4096 funções passando nove condições, produziu:

| Condições acumuladas | Sobreviventes |
|---|---:|
| W(0) | 583 |
| W(0), W(1^16) | 213 |
| W(0), W(1^16), W(0x0101) | 18 |
| Todas as 36 amplitudes periódicas | 0 |

O verificador separado reconstruiu as funções, conferiu o núcleo e as nove condições em todos os 4096 casos, e calculou o espectro completo dos 18 sobreviventes. Entre os 4096, 229 passaram nas treze condições; nenhuma dessas 229 passou pelas três amplitudes.

Um exemplo concreto que passa pelo núcleo, pelas nove condições e pelas três amplitudes é c=0x7ddf479020b7ec777831b18f40f10. Tem W(0)=W(1^16)=W(0x0101)=256, mas W(0x0303)=640. Ele demonstra que o zero do piloto antigo nas três amplitudes era apenas um resultado daquela amostra. Não passa pelas treze condições.

O resultado de zero nas 36 frequências também permanece amostral. O avanço útil é a codificação verificável, a ligação confirmada com os geradores e o estreitamento dos próximos testes. A inexistência global em H(16,4) permanece sem prova neste trabalho.
