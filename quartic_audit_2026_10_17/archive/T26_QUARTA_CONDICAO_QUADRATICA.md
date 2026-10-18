# Uma quarta condição necessária, quadrática e fatorada

17/10/2026. Resultado obtido após completar as três leis de T20. A prova usa a expansão inteira do peso de um código de valores e um certificado completo de interseções. Não houve execução em A100; originalidade bibliográfica ainda a verificar.

## Enunciado

Escreva ℓ_I(c)=Σ_{j∈I}c_j em F₂. Se f∈H(16,4) é bent, além das três leis lineares de T20 deve valer

\[
\boxed{c_{23}+c_{31}+c_{39}+c_{57}+c_{112}
=\sum_{r=1}^{4}\ell_{I_r}(c)\ell_{J_r}(c).}
\]

| r | I_r | J_r |
|---:|---|---|
| 1 | 0,4,8,18,42,52,56,94 | 14,22,46,71,81,85,98,106 |
| 2 | 1,9,15,28,53,67,76,103 | 3,11,34,45,55,69,78,89 |
| 3 | 2,10,25,37,54,68,83,104 | 12,20,29,33,41,48,96,110 |
| 4 | 13,21,38,70,74,93,97,109 | 24,32,47,72,80,86,91,107 |

Todas as somas e produtos nessa condição são em F₂. Denote por Q(c) a soma dos dois lados. Sob as três leis de T20 existe a identidade mais precisa

\[
\boxed{W_f(0)\equiv128Q(c)\pmod{256}.}
\]

Portanto Q=0 equivale a 256 | W_f(0) nesse domínio. Isso é necessário para bentness, mas não suficiente para W_f(0)=±256 nem para a planicidade do espectro inteiro.

## 1. O certificado que reduz o grau

Seja v_j o vetor dos valores do gerador G_j nas 4.080 órbitas completas de entradas, como em `T20_TRES_LEIS_PROVA.md`. Substitua c113=c57 e c115=0, isto é, substitua v57 por v57+v113 e retire os geradores 113 e 115. Chame de v′_j a base resultante, mantendo índices originais e vetores zero nos índices retirados.

O certificado completo verifica:

- wt(v′_j) é par;
- |supp(v′_j)∩supp(v′_k)| é par;
- |supp(v′_j)∩supp(v′_k)∩supp(v′_l)| é par.

**A última propriedade refere-se à base após essas duas substituições; ela não é afirmada para a base original irrestrita.**

Logo, pela expansão inteira do XOR,

\[
\frac{\operatorname{wt}(v_f)}2
\equiv\sum_j\frac{\operatorname{wt}(v'_j)}2c_j
-\sum_{j<k}|\operatorname{supp}(v'_j)\cap\operatorname{supp}(v'_k)|c_jc_k
\pmod4.
\]

Os termos triplos são múltiplos de quatro nessa expressão; os de ordem maior também desaparecem. É essa identidade completa, e não a amostragem de funções, que justifica o limite de grau dois.

## 2. O próximo bit de Walsh

Ponha a=c57, b=c99 e L={0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106}. A terceira lei diz b=⊕_{j∈L}c_j. A soma diagonal é A₀=64(4−2a−3b), e

W_f(0)=A₀+65280−32wt(v_f).

Defina h_j=floor(wt(v′_j)/4) mod 2 e q_jk=|supp(v′_j)∩supp(v′_k)|/2 mod 2. A paridade de wt(v′_j)/2 é um exatamente nos índices L. Para m=Σ_{j∈L}c_j como inteiro, b=m mod 2 e

(b−m)/2 ≡ Σ_{j<k, j,k∈L}c_jc_k mod 2.

Substituindo na identidade do peso e dividindo o numerador par, obtemos

\[
W_f(0)/128\equiv
a+\sum_jh_jc_j
+\sum_{j<k}q_{jk}c_jc_k
+\sum_{j<k,\ j,k\in L}c_jc_k
\pmod2.
\]

Após substituir c99=⊕_{j∈L}c_j, os termos se reduzem exatamente aos cinco monômios lineares e aos 256 quadráticos da condição fatorada. O grafo dos termos quadráticos é a união de quatro cópias disjuntas de K₈,₈, explicando os quatro produtos na tabela. Essa igualdade de polinômios é conferida simbolicamente pelo verificador, sem testar todas as 2¹¹³ entradas.

## 3. Exclusão global exata de 15/16 por quatro condições necessárias

Nas três leis lineares e na condição quadrática, c57 pode ser escolhido para resolver Q=0; c113 deve acompanhá-lo. Nenhum dos quatro produtos contém 57 ou 113, e a terceira lei não contém esses índices. Assim a transformação

c↦c+e57+e113

preserva as três leis lineares e troca o valor de Q. Ela emparelha o espaço de dimensão 113 em pares, cada um com exatamente uma palavra aceita pela quarta condição.

Consequentemente, as quatro condições deixam exatamente 2¹¹² palavras entre as 2¹¹⁶ originais: uma fração 1/16. Elas excluem **15/16**, ou 93,75%, do espaço original como candidatos a bent. A fração decorre do emparelhamento algébrico, não da frequência observada numa amostra.

Uma parametrização explícita usa como livres todos os coeficientes exceto 57,99,113,115. Reconstrua c99=ℓ_L(c), c57=c23+c31+c39+c112+Σ_rℓ_Irℓ_Jr, c113=c57 e c115=0. Os 112 parâmetros livres não geram necessariamente funções bent.

## 4. Efeito no pacote T19

As nove formas lineares que entram em Q são determinadas pela restrição de posto 33 usada em T16. Portanto essa condição pode filtrar os pais antes de examinar suas extensões T17–T19.

No arquivo T19 salvo, com 16.384 pais e 134.217.728 extensões verificadas, sobreviviam 26.868.006 extensões. A quarta condição exclui 4.606 dos 9.602 pais com sobreviventes e, com eles, **12.805.538 extensões sobreviventes**, deixando **14.062.468**. Isso é contagem exata naquele pacote amostral; não é uma taxa global entre os 715.181.248 pais aceitos em T16.

Esse resultado não contradiz o posto 466 de T21: a busca de T21 procurava uma relação quadrática que se anulasse em todos os pais com sobreviventes computacionais. Esses pais não são certificados bent. A nova relação é uma condição necessária deduzida da divisibilidade do Walsh global e justamente rejeita parte deles.

## Verificação e limites

`VERIFICAR_QUARTA_CONDICAO.py` usa somente Python padrão. Ele reconstrói os certificados anteriores, verifica todas as interseções triplas da base restrita, deriva o polinômio e confere sua fatoração. Outros 1.024 casos foram comparados diretamente com tabelas verdade completas na construção; o verificador separado faz mais 1.024 conferências modulares e o emparelhamento.

A inexistência de bent quárticas RS em 16 variáveis e C16 continuam abertas nesta pesquisa. Não se deve impor esta condição na busca de contraexemplos a C16, pois ela exige bentness e um contraexemplo a PC(2) pode não ser bent. Nenhuma alegação de novidade bibliográfica é feita antes do confronto com a literatura completa.
