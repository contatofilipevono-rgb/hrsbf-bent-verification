# Fourier parcial e os dois planos invariantes em 12 variáveis

As referências mais diretas em *Analysis of Boolean Functions* são §1.4 (Parseval), §3.2, proposições 3.11–3.12 (indicadoras de classes laterais), §3.3, proposição 3.21 (Fourier por blocos), e §6.2, equação (6.4) (expansão inteira da paridade). A primeira parte explica o argumento de colunas abaixo. A expansão inteira explica os certificados por congruências de pesos. [Edição de 2021 disponibilizada pelo autor](https://www.cs.cmu.edu/~odonnell/papers/Analysis-of-Boolean-Functions-by-Ryan-ODonnell.pdf)

## Colunas do espectro parcial

Em coordenadas antipodais, escreva $z,w\in\mathbb F_2^6$ e defina

\[
A(z,\beta)=\sum_{w}(-1)^{f(z,w)+\beta\cdot w}.
\]

A transformada de Walsh de $A(\cdot,\beta)$ em $z$ é $W_f(\cdot,\beta)$. Portanto, se $f$ é bent, Parseval em $z$ dá $\sum_z A(z,\beta)^2=64^2$ para toda coluna $\beta$.

Seja $q_z(w)=f(z,w)$, quadrática em $w$, com polar $B_z$ de posto $r_z$. Para $v\in\ker B_z$, a diferença $q_z(w+v)+q_z(w)$ é constante em $w$, igual a $d_z(v)=q_z(v)+q_z(0)$. Elevando $A(z,\beta)$ ao quadrado e somando primeiro em $w$,

\[
A(z,\beta)^2=64\sum_{v\in\ker B_z}(-1)^{d_z(v)+\beta\cdot v}.
\]

Assim, a linha $z$ tem suporte na classe lateral definida por $\beta\cdot v=d_z(v)$ para $v\in\ker B_z$, e cada entrada no suporte contribui $2^{-r_z}$ do total normalizado da coluna. Quando $r_a=0$, a linha $a$ usa toda a energia de uma coluna. Nenhuma outra linha pode usar essa coluna. Para verificar se $z$ também a usa, basta avaliar $d_z(v)+d_a(v)$ numa base do radical de $B_z$. Com a polar fixa, essas avaliações são afins nos parâmetros da fase.

## Aplicação aos dois casos residuais

- Mapa 2017. A linha 36 tem posto zero. A linha 45 ocupa a coluna da linha 36 em uma metade do espaço afim de fases, e a linha 54 ocupa a mesma coluna na metade complementar.
- Mapa 2024. A linha 9 tem posto zero. A linha 54 ocupa a coluna da linha 9 em todo o espaço afim de fases.

Essas duas identidades sobre radicais valem em todo o espaço afim de dimensão 26 obtido ao fixar a polar, antes de impor os momentos de ordem mais alta. A exclusão final por colunas é independente das congruências módulo 16 e 32. O restante da cobertura ainda usa a classificação finita dos mapas e a eliminação algébrica.

Aplicado logo após as assinaturas, o critério de coluna exclui 925 pares de mapa e polar. Em 856 há uma contribuição universal. Nos outros 69, duas linhas contribuem em hiperplanos complementares. Os 443 pares restantes caem pelas congruências módulo quatro e módulo oito, com 388 e 55 exclusões, respectivamente.
