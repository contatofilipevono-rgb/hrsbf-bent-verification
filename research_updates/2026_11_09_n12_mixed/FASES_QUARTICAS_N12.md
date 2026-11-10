# Fases dos mapas com fibras planas em dimensão cinco

O ponto de partida são os 10.368 mapas $\pi:\mathbb F_2^7\to\mathbb F_2^5$ cujas 32 fibras são planos afins e para os quais $q(z)=\pi(z,0)+\pi(z,1)\ne0$. O contador os gera a partir dos polinômios invariantes de grau até quatro, sem ler o catálogo. Para cada mapa exportamos uma fase de referência $H_0$ que preserva a invariância da função, antes de impor bentness. A auditoria distingue 1.280 mapas com fase bent e 9.088 incompatíveis.

## A convenção de $q$

Usamos o ponto-base inteiro $z+64s$ e escrevemos os funcionais em $U$ como inteiros de cinco bits na base dual a $e_i+e_5$, $0\le i<5$. No único tipo sobrevivente, o vetor $q$ é

$$
q(z)=(1+\sigma(z))\bigl((z_1+z_4)\cdot 9+(z_0+z_3)\cdot18\bigr),
$$

onde a soma de rótulos é XOR e $\sigma(z)=\sum_i z_i$. A fórmula foi conferida nos 64 pontos. Em $z$ par, o núcleo é a diagonal $\{(c,c):c\in\mathbb F_2^3\}$, com oito pontos. Cada rótulo 9, 18 e 27 ocorre em oito pontos. Nos 32 pontos de peso ímpar, $q=0$. Isso dá 40 zeros e 24 valores não nulos. A reconstrução independente do espaço inteiro de $q$ está com o Fable.

## O sistema de fases e as três condições restantes

Escreva $P_\beta=\pi^{-1}(\beta)$. Denote por $r_\beta$ a aplicação linear $H\mapsto\sum_{x\in P_\beta}H(x)$ no núcleo de 15 dimensões das fases que se podem somar a $H_0$ preservando $\pi$. Seja $d_\beta=1+\sum_{x\in P_\beta}H_0(x)$ o lado direito da equação.

A rotação reduz as 32 equações a oito, com representantes $0,1,3,5,7,9,11,21$. De fato, a diferença de fase entre $x$ e $Qx$ é $\pi_0(Qx)(s+z_5)$. Ao somar sobre um plano $P_\beta$, $\pi_0(Qx)$ é constante e $s+z_5$ é linear. A soma da diferença é, portanto, zero. O verificador confere a igualdade das equações inteiras ao longo de cada órbita.

Em todos os 10.368 mapas, o par de órbitas com fibras que se projetam injetivamente em $z$ tem representantes $(a,b)=(1,11)$ ou $(3,5)$. Seja $(c,d)$ o outro par. A auditoria obtém

$$
r_0=r_9\ne0,\qquad r_a=r_b\ne0,\qquad
r_0\ne r_a,\qquad r_7=r_{21}=r_c=r_d=0.
$$

Os lados direitos satisfazem sempre $d_0=d_9$ e $d_7=d_{21}=0$ na lista. Logo o sistema completo é compatível exatamente quando

$$
d_a+d_b=0,\qquad d_c=0,\qquad d_d=0.
$$

A primeira condição é a igualdade das paridades de $H_0$ nos dois planos injetivos representantes. Como $r_a=r_b$, a condição é independente da escolha de $H_0$. Para cada uma das duas outras condições, a fibra é vertical sobre dois pontos ímpares $z,z'$. A meia-volta envia $(z,s,u)$ a $(z,s+1,u+z_{<5})$ quando $z$ é ímpar. Comparar os dois valores da função dá a fórmula explícita

$$
d_\beta=1+\beta\cdot(z+z')_{<5}.
$$

O verificador confere essa fórmula em todas as fibras verticais representantes que têm dois pontos-base ímpares, incluindo $7$ e $21$. O posto é dois também nos sistemas inconsistentes. Em cada sistema consistente sobram, portanto, $2^{13}$ fases.

## A decomposição que resta explicar

Os planos $P_0=\{0,63,64,127\}$ e $P_{21}=\{21,42,85,106\}$ são fixos em toda a lista. Uma vez escolhidos o tipo e o plano $P_a$, os planos $P_b$ e $P_9$ ficam determinados em todos os mapas observados.

| Par de órbitas injetivas | Mapas com fibras planas | Escolhas de $P_a$ que admitem fase | Completamentos com fase por escolha | Total com fase |
|---|---:|---:|---:|---:|
| $1,11$ | 1.728 | 8 de 16 | 64 | 512 |
| $3,5$ | 8.640 | 16 de 16 | 48 | 768 |

A lista de 32 escolhas, com os planos parceiros e as multiplicidades, está em near-antipodal-phase-analysis.json. As mudanças de coordenadas dadas pelos circulantes invertíveis, pela reflexão e pela translação de todas as coordenadas por um organizam os 1.280 mapas compatíveis em 160 órbitas de tamanho oito. A partição foi conferida na lista de mapas. A classificação analítica das escolhas de $P_a$ e a dedução dos números 64 e 48 permanecem abertas. Em particular, a igualdade $r_a=r_b$ e a automaticidade de $d_0=d_9$ estão aqui verificadas por cálculo.

A reprodução roda em GitHub Actions. O artefato guarda os mapas de 128 rótulos, seguidos dos 128 bits de $H_0$ em cada registro de 144 bytes, além da análise em JSON e dos oito controles de Walsh completo.

Uma nota posterior, CLASSIFICACAO_F4_BLOCO_U.md, dá uma parametrização sobre F4 do tipo q de peso 24 e deduz os números 48 e 64. Ela substitui a enumeração dos 1.280 mapas desse tipo por duas famílias e recebeu auditoria adversarial pelo Astra. A exclusão dos outros tipos de q é separada.
