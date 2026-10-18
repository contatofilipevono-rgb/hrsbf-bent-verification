# T36: até onde as nove condições podem chegar

## Intervalo rigoroso

A mesma prova de caracteres de T35 fornece os dois lados da estimativa. A fração de funções que satisfazem todas as nove condições está entre

`1201499496445/562949953421312`

e

`2097035386883/562949953421312`.

Portanto a exclusão real produzida por esses nove filtros está entre **99,6274916848046% e 99,7865708151954%**. Os números decimais apenas apresentam frações racionais exatas.

Isso prova uma limitação concreta: **as mesmas nove condições, mesmo analisadas perfeitamente, não podem alcançar 99,9% de exclusão**. É necessário acrescentar condições não redundantes ou mudar o argumento matemático para excluir funções que passam nesses testes.

## Prova curta

No ramo b, escreva A_b para a soma dos sete módulos médios certificados em T35. A expansão exata em caracteres dá

`(1−A_b)/8 ≤ Pr(P₁=P₂=P₃=0 | b) ≤ (1+A_b)/8`.

O lado inferior usa a mesma desigualdade triangular do lado superior, com sinal negativo. Os dois limites inferiores são positivos: 823546568701/8796093022208 no ramo zero e 90111/1048576 no ramo um. Ponderar pelas medidas originais 1/64 e 1/128 fornece o intervalo anunciado.

A estimativa inferior prova que há muitas funções passando nos nove testes; não afirma que alguma delas seja bent. As nove condições continuam sendo apenas necessárias.

## Controle de erros e próximo passo

`VERIFICAR_INTERVALO_T36.py` confere esta consequência em aritmética racional exata a partir dos módulos de T35. O certificado de base possui reconstrução completa dos polinômios e 4.800 somas conferidas por método independente. Para reproduzir a cadeia inteira, execute primeiro os dois verificadores T35 e depois T36.

Não há garantia absoluta de ausência de erros. O que está disponível é uma cadeia explícita de identidades, certificados completos e verificações independentes. Um resultado de 100% exigiria uma prova que eliminasse todos os candidatos restantes; arredondar 99,99…% não serve.

Uma alternativa concreta é incorporar parte das 389 obstruções cúbicas já construídas, verificando que acrescentam informação aos nove testes. Seus efeitos conjuntos ainda não foram demonstrados. A prioridade passa a ser encontrar uma nova exclusão estrutural, em vez de apenas refinar a estimativa para os mesmos filtros.
