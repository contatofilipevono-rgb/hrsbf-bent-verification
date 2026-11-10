# Quatro representantes restantes para o critério antipodal em grau quatro

A prova em \(n=12\) reduz o problema a uma forma alternada cíclica \(\tau\) nas seis coordenadas de \(z\). Denote por \(R\) o deslocamento cíclico nessas coordenadas. A meia-volta dá \(B_z z=0\) e \(B_z=\iota_z\tau\), onde \(B_z\) é a matriz polar em \(w\). Essa redução vale para \(n=2m\), com \(\tau\) em \(m\) coordenadas. Para \(m=7,8\) há respectivamente 31 e 127 formas não nulas. A exclusão abaixo é para \(m=6\).

## Uma mudança de coordenadas

Use a composição da reflexão dos índices com o circulante \(1+X+X^3\). O polinômio é coprimo a \(X^6+1=(X+1)^2(X^2+X+1)^2\), portanto o circulante levanta a doze coordenadas. A mudança normaliza a rotação e preserva a diagonal. O efeito em \((z,w)\) é \((Az,Aw+Lz)\), com \(A e_j=R^{-j}(e_0+e_1+e_3)\). A forma \(\tau\) se transforma pelo pullback de \(A\).

Ordenando a base cíclica de triplas por máscaras mínimas \(7,11,13,21\), o pullback envia as máscaras de base \(1,2,4,8\) a \(5,4,11,12\). Basta substituir as colunas de \(A\) em \(\tau(Ae_i,Ae_j,Ae_k)\) nas quatro triplas representativas. A iteração dá

$$
(1,5,14,3),\quad (2,4,11,13),\quad (6,15),\quad (7,10,8,12),\quad (9).
$$

A forma 9 foi excluída [pela classificação de suportes e pelos sete certificados](ANTIPODAL_TAU9_PROVA.md). Restam 1, 2, 6 e 7.

## As colunas fixas eliminam as formas 1, 2 e 7

Cada linha \(z\) do Walsh parcial tem suporte numa classe de \(\operatorname{im}B_z\) contida em \(z^\perp\). As entradas não nulas têm módulo \(64,32,16\) nos postos \(0,2,4\). Para uma coluna, a soma dos quadrados das entradas normalizadas por 16 deve ser 16 e a soma com sinais deve ser \(\pm4\). A linha \(z=0\) é unitária e, por rotação, só pode ir à frequência 0 ou 63. Uma entrada unitária em posto zero já esgota a norma de sua coluna.

Na recorrência de sinais, para \(z=(a,a)\) e \(\beta=(b,b)\), a terceira potência da rotação dá uma mudança de sinal de paridade \(a\cdot b\). Um par com \(a\cdot b=1\) é, portanto, proibido no suporte.

**Formas 1 e 7.** Em \(z=27\), ambas têm a mesma imagem, gerada pelas máscaras \(4,10,17,32\). Ela contém 0 e 63. É um subespaço de dimensão quatro de \(z^\perp\). A outra classe contém \(\beta=9\), proibido pela terceira potência da rotação. A linha 27 deve ocupar as duas colunas fixas, o que contradiz a norma na coluna unitária de \(z=0\).

**Forma 2.** Em \(z=63\), a imagem é \(\{0,27,45,54\}\). A classe é invariante pela rotação. Logo a diferença das duas metades de \(\beta\) é fixa pela rotação de três posições. Como \(\beta\cdot z=0\), essa diferença tem paridade par e só pode ser zero. Assim a classe está na diagonal. A única alternativa à imagem contém 63, frequência proibida pela fase da rotação em \((63,63)\). A linha 63 ocupa a coluna 0 com entrada de módulo 2 na escala normalizada. Logo a linha 0 ocupa a coluna 63.

Os representantes dos pontos de posto dois são \(9,27,63\). Para \(z=9\) e \(z=27\), as imagens são \(\{0,9,18,27\}\) e \(\{0,18,45,63\}\), respectivamente. Contêm frequências proibidas pela terceira potência da rotação, 9 e 18 respectivamente, logo essas linhas não podem tocar a coluna 0. Entre as linhas de posto quatro, há uma órbita de tamanho dois, representada por 21, e as demais têm tamanho seis. Para completar a norma da coluna 0, é preciso \(4+2\epsilon+6k=16\), portanto \(\epsilon=0\) e \(k=2\). Os sinais são constantes em cada órbita nessa coluna. Sua soma, \(\pm2\pm6\pm6\), não pode valer \(\pm4\).

## A forma 6 é excluída por duas colunas adicionais

As linhas 0 e 63 têm posto zero. A recorrência de sinais em \((63,63)\) é impossível. Assim as colunas 0 e 63 são unitárias, nas linhas 63 e 0 respectivamente.

Para cada representante de órbita de linhas \(z\), a tabela dá a imagem de \(B_z\) por uma base e as escolhas não vazias de contribuição às colunas 3 e 27. Um par \((S,T)\) significa que a escolha acrescenta as linhas \(S\) à coluna 3 e as linhas \(T\) à coluna 27. As escolhas vazias podem ser ignoradas.

| \(z\) | Base de \(\operatorname{im}B_z\) | Contribuições não vazias \((S,T)\) |
| ---: | --- | --- |
| 1 | 6, 10, 24, 40 | nenhuma |
| 3 | 24, 39 | \((\{3\},\{3,24\}),(\{12\},\varnothing),(\{48\},\varnothing)\) |
| 5 | 23, 40 | \((\varnothing,\{10,17\}),(\{20,40\},\varnothing)\) |
| 7 | 3, 6, 24, 48 | nenhuma |
| 9 | 9, 54 | \((\{36\},\varnothing)\) |
| 11 | 3, 9, 23, 46 | nenhuma |
| 13 | 5, 9, 30, 57 | nenhuma |
| 15 | 6, 57 | \((\{60\},\{39,60\}),(\{15\},\varnothing),(\{51\},\varnothing)\) |
| 21 | 5, 10, 20, 34 | nenhuma |
| 23 | 5, 58 | \((\varnothing,\{46,53\}),(\{23,43\},\varnothing)\) |
| 27 | 27, 36 | \((\{27\},\varnothing)\) |
| 31 | 3, 5, 12, 20 | nenhuma |

Para conferir a tabela, tome a classe \(\operatorname{im}B_z+R^{-k}\beta\) para \(\beta\in\{3,27\}\) e \(0\le k<|\operatorname{orb}(z)|\). A classe precisa estar em \(z^\perp\), evitar 0 e 63 e ser estável por \(R^{|\operatorname{orb}(z)|}\). Cada \(k\) com \(R^{-k}\beta\) na classe dá a linha \(R^kz\) na coluna \(\beta\). Antes de usar a recorrência de sinais, sobram duas contribuições extras à coluna 27. Em \(z=9\), a classe de 18 contém a frequência proibida 27. Em \(z=27\), a classe de 9 contém a frequência proibida 9. Em ambos os casos a proibição é pela terceira potência da rotação. As demais entradas da tabela seguem só das classes e da estabilidade.

Só linhas de posto dois aparecem nas colunas 3 e 27, portanto cada coluna deve ter exatamente quatro entradas. Na coluna 27, a terceira potência da rotação troca os elementos de cada par. A fase vale zero nos pares \(\{3,24\}\) e \(\{39,60\}\) e vale um nos pares \(\{10,17\}\) e \(\{46,53\}\). A paridade dos quatro sinais precisa ser um. A coluna deve, portanto, escolher um par de cada grupo.

A escolha do par de fase um impede uma das órbitas 5 e 23 de contribuir à coluna 3. A coluna 3 pode então ter no máximo um par, com XOR \(60\), e os demais pontos são unitários. Se um par for usado, os outros dois pontos precisariam ter XOR \(60\). Entre os pontos unitários possíveis, os únicos pares com esse XOR são \(\{12,48\}\) e \(\{15,51\}\). Cada um exige duas escolhas incompatíveis da mesma órbita de linhas. Logo a coluna 3 tem quatro pontos unitários.

Dois desses pontos são 36 e 27, com XOR 63. Os outros dois devem ter XOR 63 para que a coluna seja um plano afim. Como a coluna 27 escolheu um par de fase zero, pelo menos um dos outros pontos é 3 ou 60. A soma necessária força exatamente o par \(\{3,60\}\). Pela tabela, isso exige **os dois** pares de fase zero na coluna 27, uma contradição.

Isso exclui a última forma não nula por uma tabela local de contrações e duas condições de Walsh. A busca das 31 combinações pode ser omitida. O script quartic_form_orbits.py verifica o pullback e a tabela local, e reconstitui por Walsh direto os 31 perfis como conferência separada.
