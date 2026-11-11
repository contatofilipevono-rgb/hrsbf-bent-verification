# Contagem independente dos blocos de dimensão três e dois

Atualização de 11 de novembro de 2026. Os espaços de mapas, os suportes e as fases foram reconstruídos sem ler o catálogo de funções bent. Os números do catálogo foram usados ao final como comparação. A cobertura de todas as quárticas RS bent, inclusive fora dos espaços considerados, é uma etapa separada.

## Método e classificação usada

O espaço antipodal é $\mathbb F_2^6$ nas coordenadas $w$, com $z=a+b$. A diagonal inteira e o hiperplano invariante de dimensão cinco já foram tratados. As famílias de dimensão quatro foram contadas na frente do Fable/Cloud. Aqui a afinidade nas classes dos espaços precedentes é excluída função a função, por assinaturas lineares do polinômio, incluindo a fase.

| Bloco | Base em seis bits | Dimensão do mapa $\pi$ | Dimensão de fase |
|---|---|---:|---:|
| Dimensão três | $9,18,36$ | 34 | 26 |
| Primeiro plano invariante | $27,54$ | 28 | 37 |
| Segundo plano invariante | $21,42$ | 30 | 35 |

As funções têm a forma $f(y,u)=u\cdot\pi(y)+H(y)$, com $\dim y=12-r$. Para $t=6-r$, cada fibra de $\pi$ deve ter $2^{2t}$ pontos e seu Walsh sinalizado deve ter amplitude $2^t$.

## Filtro algébrico do suporte

Seja $N_I=\sum_{x\in P}x_I$ e $B_I=\sum_{x\in P}x_IH(x)$. A condição exata de fase é

$$
B_\varnothing\equiv2^{t-1}\pmod{2^t},\qquad
N_I\equiv0\pmod2,\quad
B_I\equiv N_I/2\pmod{2^{t-|I|}}\quad(1\le |I|\le t).
$$

Ela vem da expansão inteira dos caracteres e da congruência do Walsh a $2^t$ módulo $2^{t+1}$, seguida de Parseval. Os momentos de ordem maior que $t$ já têm o fator de dois necessário.

A paridade dos momentos até $t$ equivale a $1_P\in RM(b-t-1,b)$, com $b=12-r$. Portanto $1_P$ tem grau no máximo cinco. Para um mapa, essa condição equivale ao mesmo limite em todos os produtos de coordenadas distintas de $\pi$.

Os termos de grau seis de $\pi_i\pi_j$ dependem apenas das partes cúbicas de $\pi_i,\pi_j$. A enumeração dessas partes deixa os espaços seguintes.

| Base | Mapas antes do filtro | Partes cúbicas testadas | Partes cúbicas que passam | Mapas após o filtro |
|---|---:|---:|---:|---:|
| $9,18,36$ | $2^{34}$ | $2^{22}$ | 12.160 | 49.807.360 |
| $27,54$ | $2^{28}$ | $2^{19}$ | 1.728 | 884.736 |
| $21,42$ | $2^{30}$ | $2^{20}$ | 3.968 | 4.063.232 |

O filtro é necessário. As etapas seguintes testam balanceamento, o indicador completo das fibras e as fases.

## Resultado em dimensão três

A execução foi dividida em oito intervalos disjuntos de partes cúbicas. O agregador confere que esses intervalos cobrem o espaço inteiro após o filtro.

| Etapa | Quantidade |
|---|---:|
| Mapas testados | 49.807.360 |
| Mapas com fibras de tamanho 64 | 883.994 |
| Mapas com indicadores de grau até cinco | 97.530 |
| Tarefas após exclusão das classes maiores e equações lineares | 976 |
| Sistemas incompatíveis após eliminação quadrática | 512 |
| Mapas com fases válidas | 256 |
| Funções exclusivas | **4.194.304** |

Não restam tarefas adiadas nessa execução. Foram verificadas testemunhas por ANF, rotação e todos os 4.096 coeficientes de Walsh.

Os 256 mapas válidos formam 12 órbitas sob os circulantes invertíveis nas 12 coordenadas, a reflexão e a permutação de índices $i\mapsto5i$. As mudanças preservam RS, grau, o espaço de afinidade e as exclusões dos blocos maiores.

| Tamanho da órbita | Fases por mapa | Número de órbitas | Funções |
|---:|---:|---:|---:|
| 16 | 8.192 | 4 | 524.288 |
| 16 | 16.384 | 3 | 786.432 |
| 16 | 32.768 | 1 | 524.288 |
| 32 | 12.288 | 2 | 786.432 |
| 32 | 24.576 | 2 | 1.572.864 |
| Total | | 12 | **4.194.304** |

O arquivo lower-dim-v3-summary.json contém os representantes nas coordenadas da base reconstruída.

## Resultado em dimensão dois

Os dois planos são tratados em ordem, excluindo os espaços precedentes. O primeiro plano não produz funções exclusivas.

| Base | Fibras corretas e grau até cinco | Órbitas de mapas | Tarefas de fase | Órbitas com fase | Funções exclusivas |
|---|---:|---:|---:|---:|---:|
| $27,54$ | 277.653 | 6.047 | 98 | 0 | 0 |
| $21,42$ | 386.016 | 5.874 | 344 | 6 | **309.248** |

No primeiro plano, 85 tarefas caem pela eliminação quadrática e as outras 13 falham nas condições finais. No segundo plano, 307 tarefas caem pela eliminação quadrática, e 37 seguem até a contagem final. A execução concluiu todas as tarefas, inclusive as quatro que haviam sido adiadas no piloto.

| Código do mapa representante | Tamanho da órbita | Fases por mapa | Funções |
|---:|---:|---:|---:|
| 1 | 1 | 71.680 | 71.680 |
| 19 | 64 | 3.072 | 196.608 |
| 822.549 | 32 | 512 | 16.384 |
| 115.044.639 | 32 | 256 | 8.192 |
| 115.044.803 | 32 | 256 | 8.192 |
| 202.149.121 | 2 | 4.096 | 8.192 |
| Total | | | **309.248** |

Os códigos dependem da ordem da base no programa. O código sozinho não define uma forma canônica independente das convenções.

## Compatibilidade e multiplicidades

As primeiras paridades dos momentos são equações lineares no núcleo de fase. O contador impõe também as equações quadráticas dos bits seguintes. Combinações que eliminam seus termos quadráticos fornecem novas equações lineares. A redução é repetida até estabilizar, e o restante é percorrido exatamente.

Uma fase que restringe a uma função afim em cada fibra preserva o módulo de Walsh do suporte sinalizado. O contador passa ao quociente por essas fases e conserva a multiplicidade. O núcleo escolhido preserva também as assinaturas de grau e de afinidade dos espaços precedentes. Portanto cada classe contada tem uma multiplicidade uniforme e permanece no mesmo bloco.

As mudanças de coordenadas que agrupam mapas são verificadas nas bases dos espaços invariantes. A contagem em um representante é multiplicada pelo tamanho de sua órbita. O agregador confere a disjunção das órbitas, a cobertura dos suportes e a soma das multiplicidades.

## O que isso resolve e o que ainda falta

As duas contagens reproduzem, de maneira independente dentro desses espaços, os 4.194.304 e 309.248 casos do catálogo. Foram obtidos também 12 e seis representantes de órbitas, com conjuntos exatos de fases. A dedução algébrica de por que só esses representantes sobrevivem continua aberta.

Os testes são reproduzíveis nos programas lower_dim_* e nas execuções do GitHub. A enumeração inicial de mapas e a eliminação quadrática são etapas finitas da prova computacional. A cobertura de todos os casos fora dos dois planos invariantes está sendo examinada pelo modelo universal na reta da meia-volta.
