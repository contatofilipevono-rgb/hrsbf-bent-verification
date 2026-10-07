# Sexta rodada Sol — dez fibras determinam o quociente de 266 dimensões

Data: 6 de outubro de 2026.

Balanceamento de uma fibra é invariável por

[
F_z\longmapsto F_z+1.
]

Portanto a representação natural para as condições de fibras não é a tabela de 256 bits inteira, mas a tabela **módulo constantes**.

Ao projetar cada mapa de fibra nesse quociente, os sete lifts

[
h(u+v)
]

desaparecem, e o posto conjunto máximo cai exatamente de 273 para 266.

O espectro individual de postos módulo constantes é:

| posto | fibras |
|---:|---:|
| 11 | 1 |
| 19 | 2 |
| 31 | 4 |
| 32 | 4 |
| 38 | 4 |
| 54 | 8 |
| 56 | 16 |
| 57 | 16 |
| 60 | 16 |
| 62 | 40 |
| 66 | 56 |
| 68 | 8 |
| 70 | 80 |

Uma seleção gulosa determinística encontra novamente as dez fibras

[
0x1f, 0x37, 0x2f, 0x3b, 0x3d, 0x57, 0x5b, 0x07, 0x0b, 0x15,
]

com postos conjuntos

[
70,125,154,182,210,236,251,256,261,266.
]

Logo os dez perfis, considerados módulo complementação de cada fibra, **determinam completamente os 266 bits estruturais**.

Isso não diz que balancear essas dez fibras balanceia automaticamente as outras 25. A afirmação correta é de parametrização: depois de conhecer esses dez perfis completos, não resta liberdade no quociente.

## Uso recomendado

Um solver exato futuro pode usar esses dez perfis como variáveis/estado estrutural em vez de carregar os 273 coeficientes originais sem organização.

As outras 25 fibras tornam-se funções lineares desses 266 graus de liberdade, e os sete bits do núcleo podem ser tratados posteriormente pelo otimizador exato de 128 lifts.

A arquitetura natural passa a ser:

[
\text{10 perfis de fibra modulo constantes}
\longrightarrow
266\text{ bits estruturais}
\longrightarrow
7\text{ bits de lift}.
]

Esse é o modelo mais compacto obtido até agora sem perder informação relevante à busca quíntica.
