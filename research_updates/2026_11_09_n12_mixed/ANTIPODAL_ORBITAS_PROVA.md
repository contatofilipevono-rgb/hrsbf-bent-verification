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

## A forma 6 fica reduzida a duas colunas adicionais

As linhas 0 e 63 têm posto zero. A recorrência de sinais em \((63,63)\) é impossível. Assim as colunas 0 e 63 são unitárias, nas linhas 63 e 0 respectivamente.

O verificador projeta as escolhas de suportes nas quatro colunas representativas \(0,3,27,63\). Depois da estabilidade, das fases de ciclo e das normas, há 31 perfis projetados. As colunas 3 e 27 têm quatro entradas cada. Para que ambas sejam planos afins, restam apenas os pares de suportes abaixo.

| Suporte da coluna 3 | Suporte da coluna 27 |
| --- | --- |
| 3, 27, 36, 60 | 3, 24, 39, 60 |
| 12, 27, 36, 51 | 10, 17, 46, 53 |
| 15, 27, 36, 48 | 10, 17, 46, 53 |

A coluna 27 é fixa por \(R^3\), que troca as duas metades. No primeiro suporte, os pares são \(3\leftrightarrow24\) e \(39\leftrightarrow60\), ambos com fase zero. No segundo, são \(10\leftrightarrow17\) e \(46\leftrightarrow53\), ambos com fase um. Portanto a paridade dos quatro sinais é zero nos dois suportes, mas a soma de quatro entradas de módulo 32 deve ser \(\pm64\), o que exige paridade um.

Falta deduzir à mão a restrição que deixa os três pares de suportes. As fases e a contradição final seguem sem busca depois que se obtém a tabela. O script quartic_form_orbits.py reproduz o pullback, os postos usados para a forma 2 e a checagem da forma 6 por Walsh direto.
