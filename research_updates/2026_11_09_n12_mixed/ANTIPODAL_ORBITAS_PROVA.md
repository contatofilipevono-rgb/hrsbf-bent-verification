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

## A forma 6 é excluída pela linha 27

O Fable propôs esta prova. As doze triplas da forma 6 são as que contêm um par \(\{j,j+3\}\). Logo \(\tau=\omega\wedge\sigma\), com \(\omega(x,y)=x\cdot R^3y\) e \(\sigma(x)=x\cdot\mathbf1\). Identificando covetores e vetores pelo produto escalar, obtemos

$$
B_z=\sigma(z)\omega+(R^3z)\wedge\mathbf1 .
$$

Em \(z=27=(c,c)\), com \(c=(1,1,0)\) na ordem das coordenadas, a imagem é \(I=\langle z,\mathbf1\rangle=\{0,27,36,63\}\). A linha tem quatro entradas de módulo 32 num suporte \(S\) que é uma classe de \(I\). A soma das entradas é \(64(-1)^{f(z,0)}\), logo o produto dos quatro sinais é \(-1\).

A terceira potência da rotação fixa \(z\) e troca as metades de \(\beta\). A recorrência multiplica o sinal por \((-1)^{c\cdot\beta_{\rm alta}}\). Como \(R^3\) fixa \(I\) ponto a ponto, em \(S\) ela atua como uma translação fixa \(\delta\in I\). Se \(\delta\ne0\), há dois pares. Escolha seus representantes \(\beta\) e \(\beta+\gamma\), com \(\gamma\in I\setminus\langle\delta\rangle\). O produto dos quatro sinais seria \((-1)^{c\cdot\gamma_{\rm alta}}=1\), pois \(\gamma_{\rm alta}\in\langle c,(1,1,1)\rangle\) e \(c\) é ortogonal aos dois geradores. Isso contradiz o produto \(-1\).

Assim \(R^3\) fixa \(S\) ponto a ponto. Cada frequência é \((b,b)\) com \(c\cdot b=0\), pela mesma recorrência. São exatamente os quatro pontos de \(I\). Em particular, a linha 27 toca as duas colunas 0 e 63. A linha unitária \(z=0\) já ocupa por inteiro uma dessas colunas, pela identidade de norma. A forma 6 está excluída.

### Relação com a prova pelas colunas 3 e 27

A [prova anterior](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/6d7478947fd53c039d1e65f2a03f67b70a7bb411/research_updates/2026_11_09_n12_mixed/ANTIPODAL_ORBITAS_PROVA.md) começa com uma lista de possibilidades necessárias mais ampla. Em particular, a classe \(\{3,24,39,60\}\) da linha 27 passa pelas fases de cada ciclo isolado. A terceira potência troca \(3\) com \(24\) e \(39\) com \(60\), com fase zero nos dois pares. Cada ciclo é consistente separadamente, mas as duas igualdades juntas dão produto \(+1\) na linha. A prova anterior exclui essa possibilidade posteriormente por condições nas colunas. A diferença é a imposição da paridade conjunta da linha, com as mesmas convenções de índices.

O script quartic_form_orbits.py confere a fatoração e testa os 64 coeficientes lineares possíveis da linha 27. Os únicos compatíveis com a terceira potência são \(0,27,36,63\), todos com suporte \(I\). A conferência anterior das colunas também fica disponível no mesmo script.
