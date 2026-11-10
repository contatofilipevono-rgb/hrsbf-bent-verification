# Quárticas RS bent em 12 variáveis fora da família antipodal

O catálogo registra 19.216.384 funções quárticas fora da família afim nas classes da diagonal antipodal. Destas, a subfamília de **10.485.760** funções afins nas classes de um hiperplano da diagonal admite uma parametrização por planos e uma contagem independente. A contagem inclui as escolhas da constante e do termo linear invariante.

## Toda fibra antipodal é quadrática

Escreva $x=(a,b)$, $z=a+b$, $w=b$. Denote por $t_j$ os 43 coeficientes quárticos de órbita, numerados a partir de zero e ordenados pela menor máscara de cada órbita. Entre os 135 possíveis monômios quárticos com pelo menos três coordenadas $w$, a mudança de coordenadas dá 87 coeficientes identicamente nulos e 48 coeficientes iguais a um dos dois funcionais

$$
\begin{aligned}
L_{456}&=t_0+t_4+t_7+t_9+t_{22}+t_{27}+t_{29}+t_{37},\\
L_{464}&=t_1+t_3+t_5+t_8+t_{24}+t_{28}+t_{34}+t_{36}.
\end{aligned}
$$

Os subscritos são máscaras de monômio na ordem $z_0,\ldots,z_5,w_0,\ldots,w_5$. Ambos os funcionais se anulam pelo filtro quártico do quadrado dividido. Para ver a necessidade do filtro, se $f$ é bent então

$$
(-1)^{f(x)}=2^{-6}\sum_{v\in\mathbb F_2^{12}}(-1)^{f^*(v)}(-1)^{v\cdot x}.
$$

O coeficiente inteiro em uma máscara $S$ de peso oito é $(-2)^8 2^{-6}\sum_{v\supseteq S}(-1)^{f^*(v)}$, múltiplo de oito. A expansão alternativa $\prod_{m\in\operatorname{ANF}(f)}(1-2x^m)$ mostra, módulo oito e a menos do fator global do termo constante, que esse coeficiente é quatro vezes a paridade dos pares de monômios quárticos disjuntos com união $S$. Em coordenadas de órbita, essas paridades dão as equações $Q_i=0$ implementadas em top_filters.py. A eliminação sobre os $Q_i$ e os produtos $t_jQ_i$ fornece certificados para $L_{456}$ e $L_{464}$. O programa quadratic_antipodal_fibres.py verifica as duas projeções e reconstrói as identidades booleanas dos certificados.

Restam como possíveis termos cúbicos em $w$ apenas os cúbicos puros. A meia-volta envia $(z,w)$ a $(z,w+z)$. Na diferença pela meia-volta, o coeficiente de $w_iw_j$ proveniente de $w_iw_jw_k$ é $z_k$. A contribuição dos termos de grau no máximo dois em $w$ é zero nesse coeficiente. Como as coordenadas $z_k$ são independentes, os cúbicos puros também se anulam. Portanto, para toda RS bent de grau no máximo quatro em 12 variáveis,

$$
f(z,w)=h(z)+\ell(z)\cdot w+\sum_{i<j} B_{ij}(z)w_iw_j,\qquad \deg B_{ij}\le 2.
$$

A meia-volta ainda dá $B(z)z=0$ para a matriz polar alternada. Em particular, $\operatorname{rank} B(z)\le4$ quando $z\ne0$. Esta redução usa os filtros e a simetria, independentemente do catálogo de completamentos.

## O bloco afim sobre um hiperplano da diagonal

Seja $U=\{w\in\mathbb F_2^6:\sigma(w)=0\}$, onde $\sigma(w)$ é a soma das coordenadas. É o único hiperplano invariante pela rotação em $w$. Escreva $w=u+s e_5$, com $s=\sigma(w)$ e $u$ em $U$, usando a base $e_i+e_5$ para $0\le i<5$. As funções afins nas classes de $U$ têm a forma

$$
f(z,s,u)=u\cdot\pi(z,s)+H(z,s),
\qquad \pi:\mathbb F_2^7\longrightarrow\mathbb F_2^5.
$$

O critério do Walsh parcial é exato. Para cada $\beta$, a coluna é 32 vezes a transformada da função sinalizada em $\pi^{-1}(\beta)$. A amplitude necessária de 64 dá amplitude dois para a coluna dividida por 32. Parseval exige então que a fibra tenha quatro pontos. Em quatro pontos distintos, todas as somas sinalizadas moduladas têm módulo dois se e somente se o XOR dos quatro pontos é zero e o XOR dos quatro valores de $H$ é um. De fato, uma soma de quatro sinais tem módulo dois exatamente quando o produto é $-1$. Ao multiplicar pelo caráter de frequência $\alpha$, esse produto ganha o fator $(-1)^{\alpha\cdot\sum x}$. Assim, as fibras devem ser planos afins e a fase deve ter paridade ímpar em cada plano. Este é o caso de fibras de quatro pontos da construção *almost Maiorana–McFarland*. [Kudin et al.](https://arxiv.org/abs/2508.14265)

Defina $q(z)=\pi(z,0)+\pi(z,1)$. O caso $q=0$ é precisamente a família afim nas classes da diagonal inteira, pois então $u\cdot\pi$ e $H$, em cada $z$, somam uma função afim de $(u,s)$. A rotação em $(z,s)$ age por $Q(z,s)=(Rz,s+z_5)$, onde $R$ é a rotação de seis coordenadas. A ação linear em $u$ é $A=R|_U$, além de um termo linear em $(z,s)$ que só entra na fase. Comparar os coeficientes de $u$ dá $\pi(Qx)=A^{-T}\pi(x)$. Como $Q^6(z,s)=(z,s+\sigma(z))$ e $A^6=I$, $q$ se anula em $z$ de peso ímpar. Em grau no máximo três, $q$ teria grau no máximo um, logo seria $(1+\sigma(z))c$ para algum vetor constante $c$. Para $z$ de peso par, a meia-volta muda $u$ por $z$ e mantém $s$ fixo. Assim $q(z)$ se anula como funcional sobre $z$. Como os $z$ de peso par percorrem todo $U$, resulta $c=0$. Portanto $q\ne0$ implica grau exatamente quatro sob a hipótese de grau no máximo quatro.

## Contagem independente

A base de partida consiste nas somas de órbita de monômios de grau até quatro. A anulação dos coeficientes com pelo menos duas variáveis $u$ deixa um espaço de dimensão 46. A projeção em $\pi$ tem dimensão 31, com núcleo de dimensão 15 para $H$. A projeção seguinte $\pi\mapsto q$ tem dimensão três. Todas essas dimensões são obtidas por eliminação sobre $\mathbb F_2$.

Em uma fibra que contém um par vertical $(z,0),(z,1)$, o plano é uma união de dois pares verticais. As outras fibras projetam injetivamente em $z$. Portanto o número de fibras desse segundo tipo é $\operatorname{wt}(q)/2$, e dois casos com peso ímpar saem imediatamente. Os rótulos das fibras formam órbitas de comprimentos $1,1,3,3,6,6,6,6$. Para cada uma das primeiras quatro órbitas, seleciona-se um plano invariante pela potência de $Q$ que fixa o rótulo. Suas imagens pela ação de $Q$ dão os planos dos demais rótulos da órbita. A disjunção, a condição vertical e o número de fibras injetivas eliminam escolhas. As equações $\pi(x)=\beta$ nos pontos escolhidos restringem $\pi$ linearmente. Uma mesma $\pi$ válida determina univocamente todos os planos escolhidos, o que evita a dupla contagem de partições válidas entre ramos.

As etapas finitas restantes são verificar as fibras de cada mapa candidato e impor a paridade de $H$ por eliminação linear.

| Peso de $q$ | Tipos de $q$ | Mapas candidatos nos ramos | Mapas com fibras planas | Mapas com fase |
|---:|---:|---:|---:|---:|
| 16 | 1 | 51.380.224 | 0 | 0 |
| 24 | 1 | 47.579.136 | 10.368 | 1.280 |
| 28 | 1 | 23.986.176 | 0 | 0 |
| 30 | 2 | 9.830.400 | 0 | 0 |
| 31 | 2 | 0 | 0 | 0 |

Cada mapa admissível tem exatamente $2^{13}$ fases. O total é $1.280\cdot2^{13}=10.485.760$. A execução sem a poda pelo número de fibras injetivas percorreu mais candidatos e deu os mesmos totais de partições, mapas com fase e funções. Oito representantes reconstruídos foram checados pela rotação em todas as entradas, pelo grau na ANF e pela amplitude 64 nos 4.096 coeficientes de Walsh. Este cálculo é independente do catálogo. A contagem ainda percorre espaços de mapas finitos, de modo que a fórmula para os 1.280 mapas permanece um alvo para classificação à mão.

### Reprodução

No diretório desta nota, em PowerShell com Python, NumPy e o compilador .NET Framework disponíveis

~~~powershell
python quadratic_antipodal_fibres.py
python count_near_antipodal.py near-antipodal-plan.json --export near-antipodal.bin
& "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\csc.exe" /nologo /unsafe /optimize+ /out:CountNearAntipodal.exe CountNearAntipodal.cs
.\CountNearAntipodal.exe near-antipodal.bin near-antipodal-witnesses.txt
python count_near_antipodal.py --verify-witnesses near-antipodal-witnesses.txt
~~~

## As 8.730.624 restantes

Para um subespaço $V$ da diagonal, $f$ é afim nas classes de $V$ exatamente quando $B(z)|_{V\times V}=0$ para todo $z$. Os nove subespaços invariantes pela rotação correspondem aos divisores de $X^6-1=(X+1)^2(X^2+X+1)^2$. A leitura do catálogo exterior separa as funções pela maior dimensão de um desses subespaços isotrópicos simultâneos.

| Dimensão máxima invariante | Funções | Origem da contagem |
|---:|---:|---|
| 5 | 10.485.760 | Catálogo e contagem independente |
| 4 | 4.227.072 | Catálogo |
| 3 | 4.194.304 | Catálogo |
| 2 | 309.248 | Catálogo |

O mesmo Walsh parcial reduz o bloco de dimensão quatro a um mapa $\mathbb F_2^8\to\mathbb F_2^4$. Parseval exige fibras $P$ de 16 pontos, com Walsh de amplitude quatro para a função sinalizada $s(x)=(-1)^{H(x)}$ em cada fibra. A amplitude quatro equivale a todos os coeficientes serem congruentes a quatro módulo oito, pois a congruência dá amplitude pelo menos quatro e a média dos quadrados é 16. Expandir o caráter como $\prod_i (1-2\alpha_i x_i)$ dá o teste exato

$$
\sum_{x\in P}s(x)\equiv4\pmod 8,\qquad
\sum_{x\in P}x_i s(x)\equiv0\pmod 4,\qquad
\sum_{x\in P}x_ix_j\equiv0\pmod 2 \quad(i<j).
$$

A matriz de avaliação das funções afins em $P$ tem espaço de linhas auto-ortogonal em $\mathbb F_2^{16}$. Os termos com $i=j$ se anulam pela paridade de $\sum x_i s(x)$, e a constante também é ortogonal às linhas. Assim esse espaço tem dimensão no máximo oito, e a dimensão afim de $P$ é no máximo sete. Uma vez fixada a fibra, os momentos de ordem um dão equações lineares nos valores de $H$. O momento de ordem zero pede $\operatorname{wt}(H|_P)\equiv2\pmod4$, que se decompõe em uma condição linear de paridade e uma condição quadrática $\sum_{x<y,\ x,y\in P}H(x)H(y)=1$. A contagem das funções nas dimensões quatro, três e dois permanece dependente do catálogo.

A conferência do Fable dos sete certificados de sinais e dos transportes dos 20 suportes trata da prova do critério da família antipodal. Ela foi feita contra uma lista de suportes produzida separadamente. A revisão das outras etapas do critério e a revisão independente desta nota permanecem pendentes.
