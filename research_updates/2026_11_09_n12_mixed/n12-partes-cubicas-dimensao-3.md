# Partes cúbicas dos mapas do bloco de dimensão três

Seja \(V=\langle9,18,36\rangle\), com máscaras binárias para os vetores de seis coordenadas. Nas coordenadas do bloco de dimensão três, um mapa \(\pi:\mathbb F_2^9\to\mathbb F_2^3\) tem grau até três. O espaço dos mapas tem dimensão 34 e a projeção para a parte cúbica tem imagem de dimensão 22 e núcleo de dimensão 12.

Se os indicadores das fibras têm grau até cinco, cada produto \(\pi_i\pi_j\) tem grau até cinco, pois é soma de indicadores de rótulos. Para as partes cúbicas \(c_i,c_j\), o termo de grau seis do produto é \(c_i\wedge c_j\). O produto exterior recolhe apenas pares de monômios com variáveis disjuntas.

## Redução a sistemas afins

Na base cúbica do modelo, escreva \(Q(x)=(c_i(x)\wedge c_j(x))_{i<j}\). É um mapa quadrático vetorial. O verificador extrai os coeficientes de \(Q\) avaliando-o nos vetores da base e calculando sua forma polar \(B(u,v)=Q(u+v)+Q(u)+Q(v)\). A eliminação das colunas quadráticas dá duas restrições lineares independentes, \(x_3=0\) e \(x_{18}=x_{21}\), com índices a partir de zero. Seja \(H\) o espaço de dimensão 20 que elas definem.

Em \(H\), há um subespaço \(L\) de dimensão 10 tal que \(B|_{L\times L}=0\). A base explícita em códigos inteiros é dada abaixo. O certificado confere a independência, as duas restrições lineares e \(B(u,v)=0\) nos pares de vetores da base. Isso basta por bilinearidade.

~~~text
1115136, 657408, 57344, 3028983, 747847,
2370631, 233207, 3986096, 2452144, 582391
~~~

Os três primeiros vetores geram o radical comum \(K\) de \(B\) em \(H\). O verificador calcula a dimensão do radical e confere \(Q|_K=0\). Assim \(Q\) é constante nas classes laterais de \(K\). Um complemento \(T\) de \(L\) em \(H\) é gerado pelos vetores de coordenadas \(0,1,2,4,5,6,7,8,9,11\).

Para cada \(t\in T\), a condição \(Q(t+\ell)=0\) torna-se
\[
Q(\ell)+B(t,\ell)=Q(t).
\]
A aplicação do lado esquerdo é linear em \(\ell\in L\) e pode ser resolvida nas sete coordenadas de \(L/K\). Cada solução é levantada com as três direções livres de \(K\). Isso parametriza exatamente as soluções de \(Q=0\) em uma união disjunta de espaços afins, pois cada elemento de \(H\) tem uma decomposição única em \(T\oplus L\).

| Dimensão do espaço afim | Número de espaços | Partes cúbicas |
| ---: | ---: | ---: |
| 4 | 8 | 128 |
| 6 | 36 | 2.304 |
| 7 | 12 | 1.536 |
| 8 | 14 | 3.584 |
| 9 | 9 | 4.608 |
| **Total** | **79** | **12.160** |

São 1.024 sistemas lineares em lugar de testar as \(2^{22}=4.194.304\) partes cúbicas uma por uma. A verificação comparou o conjunto inteiro gerado com o conjunto da enumeração anterior. A reprodução do certificado por sistemas lineares levou cerca de um segundo no computador local.

Ao acrescentar as 12 direções sem termo cúbico, as 12.160 partes dão 49.807.360 dos \(2^{34}\) mapas. O filtro de pares elimina 99,71% desse espaço. A nova parametrização substitui a varredura dentro do filtro. Ainda é preciso impor o balanceamento e a condição de grau do produto triplo para deduzir a lista dos suportes. O resultado se refere ao bloco de dimensão três de \(n=12\), grau quatro.

Na pasta deste trabalho no repositório, o primeiro comando reproduz a parametrização e o segundo compara com a varredura.

~~~sh
python lower_dim_v3_cubic_spaces.py lower-dim-v3-cubic-spaces.json
python lower_dim_v3_cubic_spaces.py lower-dim-v3-cubic-spaces.json --check
~~~
