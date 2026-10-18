# T32: combinar as condições sexta e sétima

As sete condições necessárias deixam uma fração no máximo **107021121/8589934592** do espaço original. Portanto excluem pelo menos **8482913471/8589934592 ≈ 98,75411017565057%** como candidato a bent. Isso refina o limite anterior de 503/512. A fração restante continua sendo um limite superior; sua densidade exata não foi determinada.

## Substituição exata

A sétima condição reconstrói o coeficiente c5, que ocorre apenas linearmente em sua fórmula. Substituí-lo nos dois polinômios da sexta condição deixa modelos com 110 e 109 parâmetros livres, nos ramos c99=0 e c99=1. Os domínios têm medidas originais 1/64 e 1/128. Os polinômios resultantes têm 65.975 termos de grau até cinco e 42.996 de grau até quatro.

No ramo zero, as coordenadas S0={31,39,77,88,112} formam uma restrição quadrática fixa de posto dois: nenhum monômio de grau maior que dois contém duas dessas coordenadas. No ramo um, S1={30,80,86,91,107,111} mantém o posto quatro usado anteriormente.

## Radicais e densidade excepcional

O método de T29 aplica-se às novas restrições. As derivadas nas direções radicais dependem apenas das coordenadas externas. No ramo zero são cúbicas, mas todos os termos cúbicos contêm c57. Fixar c57 em zero e um reduz cada soma exponencial a duas somas quadráticas exatas. No ramo um as derivadas já são quadráticas.

As densidades conjuntas em que todas as derivadas radicais são zero valem:

| ramo | dimensão radical | densidade excepcional |
|---|---:|---:|
| c99=0 | 3 | 4260673/33554432 |
| c99=1 | 2 | 1/4 |

Fora desse conjunto a restrição é equilibrada. Dentro dele usa-se o módulo da soma quadrática, obtendo passagem condicional no máximo 71369537/134217728 e 17/32. Ponderar pelas medidas originais 1/64 e 1/128 dá o limite anunciado.

## Certificação

`VERIFICAR_COMBINACAO_T32.py` reconstrói a substituição de c5, verifica os polinômios da sétima condição, a propriedade das restrições, seus postos polares e todas as derivadas. Confere as somas exatas por base simplética, independentemente da eliminação de pares utilizada para gerar os dados. Usa somente Python padrão e os certificados T28, T31 e T32 da mesma pasta. O resultado está em `T32_VERIFICACAO.json`.

A fonte clássica do critério inteiro permanece a mesma dos resultados anteriores. A novidade bibliográfica dessas aplicações ainda não foi estabelecida. Este limite não resolve inexistência bent global nem C16.
