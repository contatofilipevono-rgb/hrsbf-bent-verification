# Quinta condição: uma disjunção de duas paridades

17/10/2026. O próximo argumento usa um critério 2-ádico clássico, explicitado em [Zhang e Gao, 2013, Lema 2.4](https://arxiv.org/pdf/1303.2282). A contribuição candidata desta nota é a forma explícita e fatorada para H(16,4), não a invenção do critério. Originalidade bibliográfica ainda a verificar.

## Enunciado

Sob as três leis lineares de T20, uma condição necessária adicional para bentness é

\[
\boxed{c_{99}\left(c_{57}+\sum_{j\in K}c_j\right)=0,}
\]

onde

K={1,3,9,11,13,15,21,24,28,32,34,38,45,47,53,55,67,69,70,72,74,76,78,80,86,89,91,93,97,103,107,109}.

Assim, ou c99=0, ou a segunda paridade deve ser zero. Combinada com as quatro condições anteriores, ela deixa exatamente **3/64** das palavras de coeficientes como candidatas a bent. A exclusão necessária total é **61/64**, ou 95,3125%. Isso não prova que as palavras restantes sejam bent nem resolve a inexistência global.

## 1. Coeficientes inteiros da função sinal

Seja h_f(u) o coeficiente do monômio de suporte u na representação multilinear inteira de (−1)^f(x), com x_j²=x_j. Expandir ∏_M(1−2c_M M(x)) dá

h_f(u)=Σ_{coleções de monômios com união u}(−2)^{tamanho da coleção}∏c_M.

O critério clássico para bentness em 16 variáveis exige v₂(h_f(u))>|u|−8 quando u não é o suporte inteiro. Tome u=0x3f3f, o suporte {0,1,2,3,4,5,8,9,10,11,12,13}, de peso 12. Bentness exige 32 | h_f(u), logo h_f(u)/8 é par.

Uma ou duas quárticas não podem cobrir 12 posições. Três podem cobri-las somente se forem disjuntas. Coleções de quatro ou mais contribuem múltiplos de 16. Portanto,

\[
h_f(u)/8\equiv\sum_{\{A,B,C\}\text{ partição de }u\text{ em quartetos}}c_Ac_Bc_C\pmod2.
\]

Há exatamente 5.775 partições não ordenadas. Coeficientes de monômios na mesma órbita são identificados, e os produtos são reduzidos por c_j²=c_j. O polinômio original possui apenas 67 termos, já de grau no máximo dois. Se K₂ e K₄ são as uniões dos dois conjuntos da segunda e da quarta linha da tabela em `T26_QUARTA_CONDICAO_QUADRATICA.md`, e L é o conjunto da terceira lei, a identidade irrestrita é

\[
h_f(u)/8\equiv c57+c113
+c99(\ell_{K_2}+\ell_{K_4})
+c113\ell_L+c115(\ell_{K_2}+c57)\pmod2.
\]

Depois das substituições c115=0, c113=c57 e c99=ℓ_L, ela se reduz à condição anunciada. Expandindo c99 como ℓ_L, aparecem 528 termos quadráticos: o produto de duas paridades em conjuntos disjuntos de tamanhos 33 e 16. O verificador confere tanto a identidade irrestrita de 67 termos quanto essa redução.

O conjunto de 16 índices é exatamente L da terceira lei, logo sua paridade é c99. O conjunto de 33 índices é K∪{57}. Isso prova a condição. `VERIFICAR_QUINTA_CONDICAO.py` reconstrói todos os 116 geradores e enumera as 5.775 partições para conferir a identidade inteira em F₂. Não é uma amostragem de candidatos.

## 2. Contagem global das cinco condições

Após as primeiras quatro condições, todos os coeficientes exceto 57,99,113,115 são livres. A paridade c99=ℓ_L é balanceada nesses 112 parâmetros. A outra paridade é c57+ℓ_K.

O parâmetro livre c23 não ocorre em L, K nem nos quatro produtos da quarta condição. Ele ocorre linearmente na reconstrução de c57. Assim, para qualquer escolha dos outros parâmetros, trocar c23 troca a paridade c57+ℓ_K sem alterar c99. As duas paridades são, portanto, conjuntamente uniformes: cada um dos quatro pares ocorre em 2¹¹⁰ palavras. A quinta condição rejeita somente o par (1,1).

Restam 3·2¹¹⁰ palavras entre as 2¹¹⁶ originais, isto é, 3/64. Essa contagem é algébrica e exata, independente dos testes amostrais.

## 3. Efeito no domínio computacional

Na parametrização de T16, as duas paridades são as máscaras `0x8541` e `0x11e78`, ambas determinadas pelos 21 bits do pai. Portanto a quinta condição pode eliminar pais antes da expansão.

Do domínio T26, restam 108.032 pais com 2.048 extensões e 25.348 pais com 4.096 extensões, num total de **325.074.944 estados** antes dos filtros finais. No pacote T19, após a quarta e a quinta condições, restam **9.486.004** das 26.868.006 extensões anteriormente sobreviventes. A quinta condição rejeita mais 4.576.464 extensões entre as que passaram a quarta.

O domínio T27 é uma contagem finita exata. As taxas T19 são específicas daquele pacote amostral, sem extrapolação à população inteira. Nenhuma execução A100 de T27 é afirmada.

## Próximo passo matemático

A condição testou apenas o primeiro bit de h_f(u)/8. O critério completo exige também o bit seguinte, pois pede divisibilidade por 32. Há ainda 273 órbitas de suportes de peso 11 e 116 de peso 12, cujas primeiras condições cúbicas já foram construídas. O sistema completo permanece sem solução ou certificado de inviabilidade.
