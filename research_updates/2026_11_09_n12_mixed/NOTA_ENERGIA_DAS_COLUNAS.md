# Cobertura por dois planos via energia de colunas de Walsh

Seja \(f(z,w)\) uma função bent, com \(z,w\in\mathbb F_2^6\), quadrática em \(w\). Para cada \(z\), escreva \(B_z\) para a polar de \(f(z,\cdot)\) e \(R_z=\ker B_z\). Na coluna \(\beta\), a transformada parcial é \(A(z,\beta)=\sum_w(-1)^{f(z,w)+\beta\cdot w}\).

Ao expandir \(A^2\), agrupe os pares \(w,w+v\) por \(v\). A soma em \(w\) é nula se \(v\notin R_z\), pois a derivada tem parte linear \(B_z(v,w)\). Se \(v\in R_z\), ela é \(64(-1)^{D_v f(z,0)}\). Portanto

\[
E_\beta = \frac1{64}\sum_z A(z,\beta)^2
=\sum_z\sum_{v\in R_z}(-1)^{D_v f(z,0)+\beta\cdot v}.
\]

Parseval em \(z\) dá \(E_\beta=64\) para toda \(\beta\). Invertendo a transformada em \(\beta\), obtemos a condição equivalente

\[
\sum_{z:v\in R_z}(-1)^{D_v f(z,0)}=0\qquad(v\ne 0).
\]

Esta última condição é o balanceamento das derivadas nas direções contidas no bloco \(w\). Com o mapa e a polar fixos, cada bit \(D_v f(z,0)\) é afim nos parâmetros de fase. Basta agrupar as parcelas por seu caráter. Para testar se a soma pode valer zero ou 64, basta usar o dual do espaço gerado pelas frequências que restaram. A rotação permite escolher um representante por órbita de \(v\).

## Aplicação às 49 tarefas

O verificador `line_phase_algebra.py --column-energy` reconstrói os 2.096 pares mapa–polar a partir das tarefas, sem consultar a classificação anterior dos casos difíceis. Depois das 728 exclusões por assinaturas e das 925 colisões com linhas de posto zero, restam 443 pares:

| Condição que primeiro exclui o par | Pares |
| --- | ---: |
| Uma direção de derivada | 413 |
| Uma coluna entre 0, 63 e 21 | 5 |
| Redução módulo 4 | 7 |
| Coluna 0 após a redução módulo 4 | 18 |

O passo novo dispensa todos os momentos módulo 8. Entre os 55 pares que antes dependiam deles, 37 já caem pelo balanceamento de uma derivada. Nos 17 casos seguintes, a desigualdade triangular na soma de caracteres da coluna 0 dá um limite estritamente acima de 64. No mapa `2023`, resta a identidade abaixo.

## Mapa 2023

Depois da redução módulo 4, a energia na coluna zero é

\[
E_0=192-48a-8b-48c-24d-24e+24de,
\]

onde \(a,b,c,d,e\) são os caracteres associados às máscaras 532, 3584, 4177, 11307, 17492 da parametrização reduzida. A última frequência é o XOR das duas anteriores. Como \(-24d-24e+24de\ge -24\), a igualdade \(E_0=64\) força \(a=b=c=1\). Basta impor \(a=c=1\). A soma das equações quadráticas de índices 0, 5, 7 e 10 se restringe ao polinômio constante 1 no subespaço definido por essas duas relações lineares. A substituição formal verifica a identidade, sem avaliar fases.

A prova ainda reconstrói bases finitas, usa somas de caracteres e depende das condições módulo 4 nos últimos 25 pares. O arquivo de saída registra, por par, o espectro de caracteres ou a identidade usada para a exclusão.
