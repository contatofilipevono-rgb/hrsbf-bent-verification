# Uma parametrização sobre F4 para as 10.485.760 funções do bloco afim em U

Esta nota substitui a enumeração dos mapas do tipo de peso 24 por uma classificação por parâmetros. O total resulta de duas famílias de 768 e 512 mapas. Cada mapa admite exatamente $2^{13}$ fases. O escopo é o tipo $q$ de peso 24. A exclusão dos outros tipos de $q$ é uma etapa separada.

A prova usa dois lemas de comparação de coeficientes. O primeiro trata de um espaço afim de dimensão 27. O segundo trata de 32 espaços afins, cada um com dez parâmetros de mapa e 15 de fase. O arquivo certify_near_antipodal_field.py verifica esses lemas em bases dos espaços, sem percorrer as funções bent. A construção sobre F4 reproduz exatamente os 1.280 mapas da lista anterior, que entra somente como controle opcional. A derivação recebeu auditoria adversarial pelo modelo Astra. A revisão humana permanece pendente. O escopo e as dependências da auditoria estão em PARECER_ASTRA_F4.md.

## 1. Coordenadas

Trabalhamos em $K=\mathbb F_4=\{0,1,\omega,\omega^2\}$, com $\omega^2=\omega+1$. Escreva $N(u)=u^3\in\mathbb F_2$ e $\operatorname{Tr}(u)=u+u^2$.

Para $z\in\mathbb F_2^6$, defina

$$
\begin{aligned}
\sigma&=\sum_i z_i,\qquad t=z_1+z_3+z_5,\\
e&=z_0+\omega z_2+\omega^2z_4,\qquad
o=z_1+\omega z_3+\omega^2z_5,\\
u&=e+\omega^2o,\qquad v=e.
\end{aligned}
$$

O ponto-base é $x=(z,s)$, com $s=\sigma(w)$, e $\eta=s+z_2+z_3$. Nos pontos com $\sigma=0$, a ação $Q^2$ multiplica $u,v$ por $\omega$ e fixa $t,\eta$. A ação $Q^3$ é

$$
(t,\eta,u,v)\longmapsto(t,\eta+t,u,v+u).
$$

Um rótulo $\beta\in\mathbb F_2^5$ é lido como um vetor de seis coordenadas com última coordenada zero. Representamo-lo por $(c,P,Q)$, com $c=\sum_{i<5}\beta_i$, e com $P,Q$ obtidos pelas mesmas fórmulas de $u,v$. A ação nos rótulos é $(c,P,Q)\mapsto(c,P,Q+P)$ pela terceira potência, e escala $P,Q$ por $\omega$ pela segunda.

Nessas coordenadas, o tipo de peso 24 é

$$
q(z)=(0,0,(1+\sigma)u).
$$

Seu núcleo nas linhas pares é $u=0$, de dimensão três. A identidade de emparelhamento, para um vetor par $\Delta z=(\Delta t,\Delta u,\Delta v)$, é

$$
\beta\cdot\Delta z
=c\Delta t+
\operatorname{Tr}\bigl((P+Q)\Delta u^2+P\Delta v^2\bigr).
\tag{1}
$$

## 2. Os dois planos fixos

A restrição a $z=0$ é afim em todo $w$, pois $q(0)=0$. Sua invariância cíclica força o funcional a ser múltiplo de $\sigma(w)$, que se anula em $U$. Assim $\pi(0,s)=0$.

Um plano de quatro pontos fixo por $Q$, compatível com esse $q$, só pode ser um dos dois planos

$$
P_0=\{0,63,64,127\},\qquad P_{21}=\{21,42,85,106\}.
$$

Aqui os números codificam $z+64s$. Isso se obtém agrupando as órbitas de $Q$ com comprimento até quatro e impondo XOR zero. A primeira fibra contém os dois pontos com $z=0$, logo é $P_0$. A outra fibra com rótulo fixo é $P_{21}$.

## 3. Um lema de coeficientes

Considere qualquer mapa $\pi$ proveniente de um polinômio RS de grau até quatro, afim em $U$, com o $q$ acima e com os dois planos fixos. O espaço afim desses mapas tem dimensão 27. A expansão nas coordenadas acima fornece coeficientes $A,B,C,D,E,F,G,H\in K$, com

$$
B,D\in\mathbb F_2,\qquad \operatorname{Tr}(A+C+E)=0.
\tag{2}
$$

Escreva $a_0=B+C+D+E$, $d_0=1+G+H$. Nas linhas pares,

$$
\begin{aligned}
P&=a_0u+E(u^2v^2+N(u)v)+td_0u,\\
Q&=(\eta+A)u+Bv+Cu^2v^2+DN(u)v+EN(v)u\\
 &\quad+t(Fu+Gv+Hu^2v^2).
\end{aligned}
\tag{3}
$$

Para $t=0$, a coordenada $c$ é
$\alpha N(u)+\gamma\operatorname{Tr}(uv^2)$, com $\alpha,\gamma\in\mathbb F_2$.
Para $t=1$, ela é
$\operatorname{Tr}(F+d_0)N(u)+(1+\operatorname{Tr}G)\operatorname{Tr}(uv^2)$.

Nas linhas ímpares, a primeira coordenada sobre $K$ tem a forma

$$
P=a u+bv+(E+H)u^2v^2+EN(u)v+t(b+H)u.
\tag{4}
$$

A segunda coordenada tem coeficiente $D$ em $N(u)v$ e coeficiente $E$ em $N(v)u$.

As partes escalares também ficam ligadas. Se, nas linhas pares com $u\ne0$, escrevemos $c=\alpha_t+\gamma_t\operatorname{Tr}(v/u)$, então nas linhas ímpares

$$
\begin{aligned}
c={}&1+\alpha' N(u)+\beta' N(v)+\operatorname{Tr}(\Gamma uv^2)\\
&+t\bigl((\beta'+\operatorname{Tr}\Gamma)N(u)
+\beta'\operatorname{Tr}(uv^2)\bigr),
\end{aligned}
\tag{5}
$$

onde $\beta'=\gamma_0+\gamma_1$ e
$\operatorname{Tr}\Gamma=\alpha_0+\alpha_1+\gamma_0+\gamma_1$.

As fórmulas são identidades afins nos coeficientes do polinômio original. O verificador reconstrói uma base do espaço de dimensão 27 e verifica (2)–(5) na origem afim e nas 27 direções. Isso é comparação de coeficientes, independente da classificação das fibras.

## 4. Classificação da parte par

Em $u=0$, temos $P=c=0$ e $Q=(B+tG)v$. Se $B=0$ ou $B+G=0$, a fibra de zero tem mais de quatro pontos. Por (2), segue $B=1$, e $G\ne1$. As 16 entradas pares com $u=0$ preenchem as quatro fibras de rótulos $0,9,18,27$.

As linhas ímpares preenchem 16 fibras verticais. A fibra fixa $21$ já está entre elas. As outras 15 devem formar uma órbita de comprimento três e duas de comprimento seis. A órbita de comprimento três disponível é a de $7$, pois a de $9$ está preenchida pelas linhas pares. Logo os pontos pares com $u\ne0$ preenchem exatamente duas órbitas de rótulos de comprimento seis e têm $P\ne0$.

Normalize $u\ne0$ e escreva $k=v/u$, $\ell=\operatorname{Tr}k$. Então

$$
p(t,\ell)=P/u=a_0+td_0+E\ell.
$$

Todos os seus quatro valores devem ser não nulos. Portanto $p$ é constante ou toma dois valores. Para um rótulo com $P=1$ e $Q=q$, a identidade (1) mostra que cada posição $(t,\ell)$ contribui um ponto à fibra se $p\ne1$. Quando $p=1$, ela contribui dois pontos exatamente se $\ell=\operatorname{Tr}q+ct$.

Essa contagem força $c$ a ser uma constante $\varepsilon\in\mathbb F_2$ em $u\ne0$. Se alguma posição tem $p\ne1$, as duas órbitas de rótulos com esse mesmo $c$ recebem pontos, e nenhuma posição com outro $c$ pode ocorrer. Se $p=1$ em todas as posições, a alternativa de dois valores de $c$ exigiria que as duas posições com $c=0$ tivessem a mesma $\ell$, e que as outras duas tivessem o mesmo $\ell+t$, o que é impossível.

Os XORs seguintes podem ser calculados por uma fórmula uniforme. Escreva $k=\omega\ell+h$, com $h\in\mathbb F_2$, e ponha

$$
W_{t\ell}=A+tF+\ell\bigl((1+D+tG)\omega+(C+tH)\omega^2+E\bigr).
$$

Na fibra de $P=1,Q=q$, a equação de $\eta$ é

$$
\eta=pq+W_{t\ell}+h(p+t).
$$

Se $p\ne1$, há uma escolha, dada por $h=\operatorname{Tr}(pq+W_{t\ell})$. Se $p=1$, há zero ou duas escolhas, e as duas diferem por $1+t$ em $\eta$.

Quando os dois valores são $1,r$, com $r\in\{\omega,\omega^2\}$, e $E\ne0$, as duas posições com $p=r$ têm valores distintos de $t$. As outras duas entradas da fibra estão na mesma posição com $p=1$. O XOR das quatro coordenadas $t$ seria um, impedindo que a fibra fosse plana.

Se $p$ toma apenas valores em $\{\omega,\omega^2\}$, então $d_0,E$ são binários. Ao trocar $q=0$ por $q=\omega$, a diferença entre os XORs de $\eta$ é
$\sum_{t,\ell}\operatorname{Tr}(p\omega)(p+t)=E$.
Logo $E=0$. Com $E=0$, o XOR de $\eta$ é $G+a_0+1+d_0$. A planicidade força $G=a_0+1+d_0$ e, portanto, $H=a_0\ne0$. O cálculo vale tanto para $p$ constante diferente de um quanto para os dois valores $\omega,\omega^2$.

Se $p$ é constante e igual a um, as duas duplas, uma em cada $t$, têm XOR total de $\eta$ igual a um. Nos outros casos que acabamos de considerar, (4), com $E=0,H\ne0$, não pode ter exatamente uma linha projetiva no núcleo de $P$. Com $b=0$, há o núcleo $u=0$ e uma raiz finita adicional. Com $b\ne0$, a equação finita é afim sobre uma aplicação linearizada de posto um, com zero ou duas raízes. Nenhuma possibilidade preenche a órbita de $7$ corretamente.

Portanto $p$ depende de $t$, toma os valores $1,r$, e (4) força $H=0$ pelo mesmo argumento de raízes. Segue $G=r$. Escreva $t=j$ para a posição em que $p=1$. A dupla nessa posição contribui $1+j$ ao XOR de $\eta$. Nas outras duas posições, a fórmula acima usa
$W=D+(1+r)\omega+j(r+\omega^2)$.
Para $r=\omega$ isso é $D+1+j$, e para $r=\omega^2$ é $D+\omega^2$. Em ambos os casos, o XOR total é $D$. Assim a planicidade exige $D=0$.

Escreva

$$
p(t)=1+(t+j)(1+r),\qquad j\in\mathbb F_2.
$$

Usando (2), a forma par completa fica

$$
\begin{aligned}
c&=\varepsilon N(u),\\
P&=\bigl(1+(t+j)(1+r)\bigr)u,\\
Q&=\bigl(\eta+\lambda+j\omega+
t(\lambda+\mu+(1+\varepsilon)\omega)\bigr)u\\
&\quad+(1+tr)v+j(1+r)u^2v^2.
\end{aligned}
\tag{6}
$$

Os parâmetros são $r\in\{\omega,\omega^2\}$ e $j,\lambda,\mu\in\mathbb F_2$. Há exatamente 16 partes pares para cada $\varepsilon$.

## 5. A parte ímpar e o fator 36

Como $c$ é constante nas posições pares com $u\ne0$, (5) tem $\beta'=0$ e $\Gamma\in\mathbb F_2$. Se $\varepsilon=0$, todos os rótulos disponíveis nas linhas ímpares têm $c=1$, forçando $\alpha'=\Gamma=0$. Se $\varepsilon=1$, só uma das cinco linhas projetivas de $(u,v)\ne0$ pode ter $c=1$. Como $u=0$ já é essa linha, segue $\alpha'=1,\Gamma=0$. Assim

$$
\begin{aligned}
c&=1+\varepsilon N(u),\\
P&=au+bv+tbu,\\
Q&=A'u+B'v+C'u^2v^2+t(a+B'+C'+b)u+tbv.
\end{aligned}
\tag{7}
$$

No corte $t=0$, a primeira coordenada é a aplicação linear $P=au+bv$. Para $\varepsilon=0$, qualquer par $(a,b)\ne(0,0)$ pode ser considerado. Para $\varepsilon=1$, é necessário $b=0$ e $a\ne0$.

Ponha

$$
L=A'b+B'a+C'a^2b^2,\qquad \Delta=L+(C')^2.
$$

A linha $P=0$ preenche a órbita de $7$ exatamente quando $L\ne0$. Em uma reta $P=1$, usando a direção $(b,a)$, temos

$$
Q(k)=q_0+Lk+C'k^2.
$$

As duas classes de $Q$ módulo $\mathbb F_2$ devem receber duas entradas cada, o que equivale a $\Delta\ne0$. Para cada $(a,b)$, existem nove pares $(L,C')$ com essas duas propriedades e quatro soluções $(A',B')$ para a equação de $L$. Isso explica o fator $36=9\cdot4$.

Há, portanto, $15\cdot36=540$ escolhas ímpares com fibras corretas para $\varepsilon=0$, e $3\cdot36=108$ para $\varepsilon=1$. Antes das fases, o total é $16(540+108)=10.368$.

## 6. As fases nas linhas ímpares

Em uma fibra vertical de duas linhas ímpares, a paridade necessária é a condição

$$
c\Delta t+\operatorname{Tr}\bigl((P+Q)\Delta u^2+P\Delta v^2\bigr)=1.
\tag{8}
$$

Ela não depende da liberdade no núcleo das fases.

Para $\varepsilon=0$ e $b\ne0$, a condição em todas as fibras equivale a

$$
\begin{aligned}
L&=b,\\
C'&=b^2(1+\rho),\qquad \rho\in K^*,\\
\operatorname{Tr}\bigl((\rho^2 B'+\rho a)/b\bigr)&=0.
\end{aligned}
\tag{9}
$$

Para conferir (9), parametrize o corte $P=1,t=0$ por $u=bk$, $v=1/b+ak$. Ponha $\delta=1/\Delta$ e $h=L\delta+C'\delta^2\in\mathbb F_2$. Os dois representantes no corte têm parâmetros $k,k+\delta$. Ao passar aos pontos efetivos de uma fibra, suas coordenadas $t$ diferem por $h$ e suas diferenças são

$$
\Delta u=b\delta,\qquad
\Delta v=a\delta+tb\delta+h(u+b\delta).
$$

Substituir essas diferenças em (8) dá, sob o traço, o coeficiente de $k$ igual a $b\delta^2L(b+L)$. Como a paridade deve ser constante, esse coeficiente é zero. Isso força $L=b$. Escrevendo $\Delta=b\rho^2$, obtemos $h=1+\operatorname{Tr}\rho$. O termo constante de (8) é então $1+\operatorname{Tr}((\rho^2 B'+\rho a)/b)$, provando (9).

Para $\varepsilon=1$, temos $b=0$, $a,B'\ne0$, e $A'$ é livre. Os casos são

$$
\begin{array}{c|c|c}
\rho & C' & \text{condição}\\ \hline
1 & 0 & \operatorname{Tr}(1/B'+1/a)=1\\
\omega,\omega^2 & (aB')^2(1+\rho)&\operatorname{Tr}(\rho/B')=1.
\end{array}
\tag{10}
$$

No corte $P=1$, a parametrização $u=1/a$, $v=ak$ dá a condição $\operatorname{Tr}(\rho/B'+h/a)=1$, com $h=1+\operatorname{Tr}\rho$. Isso prova as duas linhas de (10). O primeiro caso tem quatro pares $(a,B')$. Os outros dois têm seis cada. Logo há $16\cdot4=64$ escolhas, incluindo as quatro possibilidades de $A'$.

## 7. As fases nas linhas pares

Um segundo lema de coeficientes trata das paridades nos planos pares. Para qualquer fase de referência que levanta (6)–(7), a diferença entre as equações dos dois representantes injetivos é

$$
1+\varepsilon j+\operatorname{Tr}b.
\tag{11}
$$

Os representantes são $3,5$ para $\varepsilon=0$ e $1,11$ para $\varepsilon=1$. A identidade é afim nos dez coeficientes binários de $a,b,A',B',C'$. O verificador confere a origem e as dez direções em cada uma das 32 escolhas da parte par. Também confere que as quatro equações com $u=0$ são iguais e que, dentro de cada órbita, todas as equações são iguais.

Para $\varepsilon=0$, (11) exige $\operatorname{Tr}b=1$, portanto $b\in\{\omega,\omega^2\}$. Usando (9), restam

$$
2\ \text{escolhas de }b,\quad 4\ \text{de }a,\quad
3\ \text{de }\rho,\quad 2\ \text{de }B'.
$$

Isso dá $48$. O coeficiente $A'$ fica determinado pela equação de $L$. Para $\varepsilon=1$, já temos $b=0$, e (11) exige $j=1$. Isso deixa oito partes pares, cada uma com as 64 escolhas de (10).

Os totais são $16\cdot48=768$ e $8\cdot64=512$.

## 8. Por que há exatamente duas condições independentes

Ponha $U_0=N(u)$, $V_0=N(v)$,
$R_0=\operatorname{Tr}(uv^2)$, $T_0=\operatorname{Tr}(\omega uv^2)$ e $k=(1+\sigma)t$.
Uma base do núcleo de fases tem os 12 polinômios

$$
1,\sigma,k,\quad U_0,\sigma U_0,kU_0,\quad
R_0,\sigma R_0,kR_0,\quad
tU_0+\sigma T_0,\quad tR_0+\sigma(V_0+T_0),\quad
(1+U_0)V_0,
$$

e os três polinômios

$$
(1+\sigma)\eta(1+t),\quad
(1+\sigma)(\eta U_0+tT_0),\quad
(1+\sigma)(\eta R_0+t(V_0+T_0)).
$$

Todos têm grau até quatro e são invariantes por $Q$. São independentes e pertencem ao núcleo de dimensão 15. A verificação usa suas tabelas e a base do espaço original, sem buscar funções bent.

Na ordem da base acima, a equação de $P_0$ tem linha $e_{12}$. A substituição de (6) mostra que todas as 12 fibras injetivas têm a mesma linha

$$
\begin{aligned}
e_6+(1+j)(e_8+e_{10}+e_{12})
&+\bigl(j+(1+j)\iota\bigr)e_{13}\\
&+\bigl((1+j)(\mu+\varepsilon\iota)
+j(\lambda+\varepsilon+\iota)\bigr)e_{14},
\end{aligned}
$$

onde $\iota=0$ para $r=\omega$ e $\iota=1$ para $r=\omega^2$.
Essa linha é independente de $e_{12}$, pois contém $e_6$. As equações nas fibras ímpares têm linha zero. Depois de (8) e (11), o sistema é compatível e tem posto exatamente dois.

Cada mapa admite $2^{15-2}=2^{13}$ fases. A contagem final é

$$
(768+512)\,2^{13}=10.485.760.
$$

## Reprodução e alcance

construct_near_antipodal_field.py gera os 1.280 mapas diretamente pelas fórmulas. Não usa a lista de 10.368 mapas como entrada obrigatória. A comparação opcional com a lista reproduzida anteriormente dá igualdade exata dos conjuntos.

certify_near_antipodal_field.py verifica os dois lemas de coeficientes em bases dos espaços. As contas de 48 e 64 acima são deduções sobre F4. A auditoria adversarial pelo Astra confirmou a classificação e as duas comparações de coeficientes. A revisão humana permanece pendente. A exclusão dos demais tipos de q foi relatada pelo Fable por recontagem exaustiva independente e fica registrada em CONSOLIDACAO_BLOCO_U.md. Essa exclusão não é uma consequência da classificação sobre F4.

A construção emite 40 controles determinísticos, distribuídos por suas famílias. Todos foram conferidos pela ANF completa e pelos 4.096 valores de Walsh. A etapa adicional de 2.048 configurações de coeficientes pares confere os XORs usados na classificação da seção 4 e retém 16 partes pares por valor de epsilon. Essa checagem é redundante com a prova por casos escrita na seção.

Como controle negativo, somar a fase R_0 ao primeiro controle preservou a simetria de rotação e o grau quatro, mas produziu amplitudes de Walsh 0, 64 e 128, com multiplicidades 1.152, 2.560 e 384. O controle positivo correspondente tem todos os módulos de Walsh iguais a 64.


## 9. Dicionário com as 72 funções psi do parecer do Fable

Seja $\beta=\pi(z,0)$, lido como um vetor de seis coordenadas com $\beta_5=0$. Então

$$
\psi(z)=(\beta_0+\beta_3,\ \beta_1+\beta_4,\ \beta_2+\beta_5).
$$

A passagem da função afim em $U$ para o termo linear $\ell(z)$ na ANF em todo $w$ é, denotando a fase por $\mathcal H$,

$$
\ell(z)=\beta(z)+q(z)+
\bigl(\mathcal H(z,0)+\mathcal H(z,1)\bigr)\mathbf1,
$$

com $\beta_5=q_5=0$. O termo $q$ vem da identidade $w_i^2=w_i$ em $s(q\cdot w)$. Tanto $q$ quanto o vetor de uns têm somas antipodais zero no tipo de peso 24. Por isso a fórmula acima coincide com a definição de psi pelo termo linear nas coordenadas da forma numerada 9 no parecer do Fable. Ela independe da escolha de $s$.

Escreva $\psi=(y_0,y_1,y_2)$. O dicionário é

$$
c=y_0+y_1+y_2,\qquad P=y_0+\omega^2y_1+\omega y_2.
$$

Essa aplicação linear é invertível. Assim psi contém exatamente $c,P$, e esquece $Q$.

Na parte par, psi depende apenas de $(\varepsilon,r,j)$. Há quatro restrições pares por valor de epsilon, num total de oito. Os dois parâmetros $\lambda,\mu$ são as quatro orientações invisíveis em psi.

Na parte ímpar, para $\varepsilon$ fixado, psi depende apenas de $(a,b)$. Para $\varepsilon=0$, são os 15 pares não nulos. Para $\varepsilon=1$, são os três pares com $a\ne0,b=0$. Consequentemente,

$$
\#\psi=4\cdot15+4\cdot3=72.
$$

Para cada psi, as equações de $L$ e $\Delta$ da seção 5 dão nove escolhas de $(L,C')$ e quatro de $(A',B')$. Isso prova as 36 escolhas ímpares por psi. As quatro orientações pares são independentes. Logo

$$
10.368=72\cdot36\cdot4.
$$

O filtro de fase também fica explícito.

- Na família $\varepsilon=0$, a condição $\operatorname{Tr}b=1$ deixa oito pares $(a,b)$. Para cada um deles, (9) dá três escolhas de $\rho$ e duas de $B'$, portanto seis escolhas. Com as quatro partes pares, são 32 funções psi e $32\cdot6\cdot4=768$ mapas.
- Na família $\varepsilon=1$, é necessário $j=1$. Restam duas partes pares. Se $a=1$, há dois pares $(a,B')$ no caso $\rho=1$ e quatro nos outros dois casos. As quatro escolhas de $A'$ dão 24 possibilidades. Isso explica as duas funções psi com 24 escolhas.
- Se $a=\omega$ ou $a=\omega^2$, há uma escolha de $B'$ no caso $\rho=1$ e quatro nos outros casos. São $5\cdot4=20$ possibilidades, dando quatro funções psi com 20 escolhas.
- Sem fase ficam $4(15-8)+2\cdot3=34$ funções psi.

Portanto a tabela do Fable fica deduzida pelos parâmetros.

| Família | Funções psi | Escolhas ímpares com fase | Orientações | Mapas |
|---|---:|---:|---:|---:|
| $b\ne0,\ \operatorname{Tr}b=1,\ \varepsilon=0$ | 32 | 6 | 4 | 768 |
| $a\in\{\omega,\omega^2\},\ b=0,\ \varepsilon=1,\ j=1$ | 4 | 20 | 4 | 320 |
| $a=1,\ b=0,\ \varepsilon=1,\ j=1$ | 2 | 24 | 4 | 192 |
| Sem fase | 34 | 0 | 4 | 0 |

O gerador $\mu\mapsto\mu+1$ troca a orientação por $tq$, enquanto $\lambda\mapsto\lambda+1$ a troca por $(1+t)q$. Nas linhas em que $q\ne0$, os geradores do parecer do Fable satisfazem
$\chi_1=\operatorname{orb}(z_0z_1)+\operatorname{orb}(z_0z_3)=t$ e
$\chi_2=\operatorname{orb}(z_0z_2)+\operatorname{orb}(z_0z_3)=1+t$.
Assim as duas descrições dão o mesmo grupo de quatro orientações.

compare_fable_psi.py gera pelas fórmulas os 10.368 mapas, recupera as 72 funções psi e verifica a tabela. A comparação com a lista anterior é opcional e dá igualdade exata dos 10.368 mapas. O argumento de contagem acima usa a parametrização e as equações de traço.
