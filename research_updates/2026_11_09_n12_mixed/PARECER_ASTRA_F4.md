# Auditoria da classificação sobre F4

Data de 10 de novembro de 2026. Leitura adversarial pelo modelo Astra. O parecer se limita ao tipo de q de peso 24.

A auditoria confirma a classificação desse tipo. A seção 4 esgota os casos possíveis de p, incluindo os valores constantes e o par omega, omega². A condição de paridade nas linhas ímpares dá 48 escolhas na primeira família e 64 na segunda. As duas condições independentes no espaço de fases de dimensão 15 deixam 2¹³ fases por mapa. O total é (16·48+8·64)·2¹³ = 10.485.760.

Foram conferidos à mão o mecanismo de ocupação das fibras, os cálculos de XOR da parte par, a obstrução pelo número de raízes, a condição de classes que dá o fator 36, as equações das fases ímpares, os fatores 48 e 64, a independência das duas linhas de fase e os dois planos fixos.

Dois pontos de redação e verificação foram corrigidos durante a revisão. As diferenças entre parâmetros no corte t=0 foram distinguidas das diferenças entre pontos efetivos de uma fibra. O certificado passou a verificar a igualdade das duplas (linha, termo constante) dentro de cada órbita de rótulos.

As dependências computacionais de álgebra linear foram explicitadas.

- A reconstrução do espaço RS de grau até quatro afim em U dá dimensões 46, 31 e 15.
- Fixar q e os dois planos deixa um espaço afim de mapas de dimensão 27. A origem e suas 27 direções certificam o primeiro lema de coeficientes.
- Para cada uma das 32 partes pares, há um espaço afim de dez parâmetros de mapa e 15 parâmetros de fase. A origem e dez direções de mapa, juntamente com a base de 15 fases, certificam o levantamento e as identidades do segundo lema.
- A base explícita das 15 fases tem independência e pertencimento conferidos por álgebra linear.
- Os dois verificadores atualizados foram executados sem consultar o catálogo e deram 768+512 mapas e 2¹³ fases por mapa.

A descrição “prova algébrica do tipo q24 com duas comparações finitas de coeficientes” corresponde ao argumento.

A extensão a todo o bloco afim em U exige a exclusão separada dos demais tipos de q não nulo. Este parecer é uma auditoria por modelo. A revisão humana continua pendente.
