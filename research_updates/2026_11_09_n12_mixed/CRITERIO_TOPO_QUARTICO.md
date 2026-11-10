# A afinidade nas classes antipodais é decidida pelo topo quártico

Seja $f$ uma função booleana bent com simetria de rotação em 12 variáveis e de grau no máximo quatro. Escreva as variáveis em dois blocos $(a,b)\in\mathbb F_2^6\times\mathbb F_2^6$ e mude as coordenadas para $z=a+b$ e $w=b$. As classes laterais da diagonal $E=\{(a,a)\}$ são as fibras de $z$.

**Teorema.** São equivalentes as seguintes condições.

1. Para todo $z$, a função $w\mapsto f(z,w)$ é afim.
2. A parte homogênea de grau quatro de $f$ nas coordenadas $(z,w)$ não tem monômios com pelo menos duas variáveis $w$.

A condição 2 é linear nos 43 coeficientes quárticos de órbita. A matriz dessa condição tem posto 23, calculado em quartic_top_diagonal.py. A prova da suficiência abaixo usa somente formas e transformadas em seis variáveis. O catálogo de completamentos não é entrada do verificador.

## Redução a quinze formas

A implicação de 1 para 2 segue pela unicidade da forma algébrica normal. Para a recíproca, suponha 2. A meia-volta envia $(z,w)$ a $(z,w+z)$. No coeficiente de $w_iw_j$ de $f(z,w+z)+f(z,w)$, só as cúbicas puras em $w$ podem contribuir. A contribuição de $w_iw_jw_k$ é $z_k$. Portanto toda cúbica pura em $w$ tem coeficiente zero.

Escreva agora

$$
f(z,w)=h(z)+\pi(z)\cdot w+\sum_{i<j} B_{ij}(z)w_iw_j.
$$

Cada entrada de $B$ é afim em $z$, e cada coordenada de $\pi$ tem grau no máximo três. Estenda $B$ por simetria e com diagonal zero. O coeficiente linear em $w$ da diferença pela meia-volta é $B(z)z$, logo $B(z)z=0$ para todo $z$.

Para ver o efeito desta identidade, escreva $B_{ij}(z)=c_{ij}+\sum_k t_{ijk}z_k$. Em sua coordenada $i$, o coeficiente de $z_i z_j$ dá $t_{iji}=0$ para $j\ne i$. Pela simetria de $B$ também vale $t_{ijj}=0$. O coeficiente de $z_j$ dá então $c_{ij}=0$. Para índices distintos, o coeficiente de $z_jz_k$ dá $t_{ijk}=t_{ikj}$. Junto com a simetria nos dois primeiros índices, isso mostra que $B(z)=\iota_z\tau$ para uma 3-forma alternada $\tau$.

Se $R$ desloca os índices ciclicamente por uma posição em seis coordenadas, a rotação de 12 posições por um passo age por $(z,w)\mapsto (Rz,Rw+z_5e_0)$. Comparando as partes quadráticas em $w$, obtemos a invariância de $\tau$ por $R$. As 20 triplas de coordenadas formam quatro órbitas cíclicas, de menores máscaras 7, 11, 13 e 21. Isso deixa 15 escolhas não nulas para $\tau$, numeradas pela máscara que seleciona as órbitas. Basta excluí-las.

## Suportes e sinais de Walsh

Defina a transformada parcial

$$
A(z,\beta)=\sum_w(-1)^{f(z,w)+\beta\cdot w}.
$$

Em uma linha $z$, a parte quadrática tem matriz polar $B(z)$. Para $t$ no radical, $f(z,w+t)+f(z,w)$ é constante em $w$. Portanto a linha tem suporte numa classe de $\operatorname{im} B(z)$, determinada pelos valores dessa diferença no radical. Elevando a transformada ao quadrado e somando sobre $t$ obtemos amplitude constante $2^{6-r/2}$ em toda a classe, onde $r=\operatorname{rank}B(z)$. Como $B(0)=0$, $B(z)z=0$ e $r$ é par, os tamanhos possíveis são 1, 4 e 16. A meia-volta exige que o suporte esteja em $z^\perp$. A rotação exige

$$
A(Rz,R\beta)=(-1)^{z_5\beta_5}A(z,\beta).
$$

Para cada órbita de $z$, o programa enumera as classes candidatas no representante, invariantes por $R^{|\operatorname{orb}(z)|}$, e transporta cada suporte pela rotação. Uma entrada cujo sinal mudaria ao voltar ao mesmo par $(z,\beta)$ é impossível.

Para cada $\beta$, a transformada em $z$ da coluna deve ter amplitude 64. Por Parseval, a coluna $g=A(\cdot,\beta)/16$ deve ter norma quadrada 16, com amplitudes de entrada 4, 2 e 1. Isso dá uma soma inteira fixa de contribuições das órbitas de linhas. Para uma coluna com essa norma, a amplitude 4 da transformada equivale a $W_g\equiv4\pmod 8$. De fato, a congruência dá $|W_g|\ge4$ e Parseval fixa a média dos quadrados em 16. Expandir $\prod_i(1-2\alpha_i z_i)$ na definição de $W_g(\alpha)$ dá as condições equivalentes à congruência

$$
\sum_z g(z)\equiv4\pmod 8,\qquad
\sum_z z_i g(z)\equiv0\pmod 4,\qquad
\sum_z z_i z_j g(z)\equiv0\pmod 2\quad(i<j).
$$

O programa percorre as escolhas de suporte por órbita. A poda usa os limites de contribuição restantes à norma e o espaço afim que contém todos os momentos de paridade restantes. Os momentos módulo dois são independentes dos sinais e só recebem contribuições de entradas de amplitude 1. Quando a norma de uma coluna é completada, nenhuma linha posterior pode tocá-la. O programa testa nesse ponto a viabilidade dos sinais na coluna, respeitando a recorrência de rotação. Uma segunda implementação percorre as atribuições de sinal e avalia diretamente todos os 64 coeficientes de Walsh de cada coluna testada.

As normas excluem as máscaras 7, 8, 10 e 12. Depois das condições de sinal por coluna, sobra apenas a máscara 9, de suportes $7,14,21,28,35,42,49,56$. Essa forma é o produto exterior $(e_0^*+e_3^*)\wedge(e_1^*+e_4^*)\wedge(e_2^*+e_5^*)$. Suas contrações têm posto zero ou dois.

## O caso restante

Para a máscara 9, a norma de cada coluna é preenchida por uma entrada de amplitude 4 ou por quatro de amplitude 2, na escala normalizada. No segundo caso $W_g(0)\equiv4\pmod 8$ exige que o XOR dos quatro bits de sinal seja 1.

Fixe uma linha de posto dois. Seja $q_z(w)=\sum_{i<j}B_{ij}(z)w_iw_j$. Escolha $p_0$ de modo que a transformada de $q_z(w)+p_0\cdot w$ tenha o suporte escolhido. Toda outra escolha de linear com esse suporte é $p_0+B(z)t$. A translação $w\mapsto w+t$ na transformada mostra que os bits de sinal relativos à linha de referência são $\beta\cdot t+c$ no suporte, para uma constante $c$ que pode depender da linha. Assim, o XOR dos quatro bits relativos é zero. Se o suporte é $\{\beta_0,\beta_0+u,\beta_0+v,\beta_0+u+v\}$, as duas diferenças de sinais relativos a partir de $\beta_0$ fornecem $u\cdot t$ e $v\cdot t$. Como cada coluna de $B(z)$ pertence a $\langle u,v\rangle$, isso determina cada coordenada de $\pi(z)=p_0+B(z)t$ por uma expressão afim nos bits de sinal. Nas linhas de posto zero, o suporte unitário já dá $\pi(z)$.

Resta um sistema linear sobre $\mathbb F_2$. Há uma incógnita de sinal para cada órbita dos pares $(z,\beta)$ no suporte. A recorrência de rotação dá os demais sinais. Impomos os XORs de linha e coluna descritos acima e, por inversão de Möbius nas seis variáveis $z$, a anulação dos coeficientes de grau quatro, cinco e seis de $\pi$. São condições necessárias para $f$.

| Etapa na máscara 9 | Configurações |
| --- | ---: |
| Suportes com sinais viáveis coluna a coluna | 744 |
| Suportes com sinais viáveis simultaneamente nas linhas e colunas | 288 |
| Suportes que também admitem $\deg\pi_0\le3$ | 0 |

Logo $\tau=0$. Segue que $B=0$ e toda fibra é afim, o que prova a recíproca.

Na última etapa bastam sete coeficientes de $\pi_0$, identificados pelas máscaras 23, 27, 30, 31, 45, 47 e 54. As três máscaras 27, 45 e 54, cada uma união de dois pares entre as posições $i$ e $i+3$, já excluem 268 dos 288 suportes com sinais conjuntos. As máscaras 31 e 47 têm grau cinco. Impor apenas os 15 coeficientes de grau quatro de $\pi_0$ ainda deixa 16 suportes no sistema relaxado de sinais.

Os 20 suportes restantes após as três primeiras máscaras formam sete órbitas de simetrias. Cada uma é excluída por uma identidade obtida somando quatro ou cinco equações de sinais. [Identidades e tabela dos representantes](ANTIPODAL_RESIDUAL_CERTIFICATES.md)

## Reprodução

Rode no diretório desta nota com Python 3.10 ou posterior. O segundo comando usa NumPy.

~~~text
python alternating_column_norms.py run-congruences.json --full
python alternating_column_norms.py run-walsh.json --full --direct
~~~

Os dois comandos produzem relatórios idênticos ao arquivo de referência alternating-column-norms.json. O controle com $\tau=0$ reconstrói uma quadrática bent com simetria de rotação e passa pelo Walsh de 4.096 pontos. Ao retirar o limite de grau para $\pi$ na máscara 9, o programa reconstrói uma bent com simetria de rotação de grau seis e confirma sua tabela completa. Esse controle mostra por que a última exclusão precisa do limite de grau.

A conclusão é uma prova com verificação finita. A contagem total de quárticas e a exclusão de outros subespaços de Maiorana–McFarland nas quárticas fora da diagonal continuam sendo resultados separados do catálogo.
