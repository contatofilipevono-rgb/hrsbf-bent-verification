# Caso global módulo 127 — obstrução modular em codimensão seis

Continuação do [adendo anterior](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0b8acb0f63fb54703e4ffc3c5cca7d69bde6e94b/research_updates/2026_11_21_walsh_mod127/AVANCO_GLOBAL_WALSH_MOD127.md). Escrevemos \(W_f\) para a transformada de Walsh não normalizada. O candidato global é uma quártica em 32 variáveis com
\[
 W_f(b)=-512+2^{17}k(b),\qquad k(b)\bmod127\in\{0,1\}.
\]
Um subespaço linear físico \(U\) de codimensão seis no qual o símbolo quártico \(a_f\) zera daria uma restrição cúbica \(g=f|_U\) em 26 variáveis. A investigação separa as condições 2-ádicas das condições genuinamente módulo \(127\).

## 1. Exemplo que satisfaz toda a congruência local 2-ádica

O Astra encontrou o seguinte exemplo. Tome quatro controles \(t=(t_1,t_2,t_3,t_4)\) e dez coordenadas \(z\). Defina
\[
 g_{14}(t,z)=\sum_{i=1}^4 t_iq_i(z)
\]
pelas máscaras
\[
 \mathtt{0x7fd3776bdb1},\quad
 \mathtt{0x1e8c7a3fc609},\quad
 \mathtt{0x4b9e12111a6},\quad
 \mathtt{0xaf56eb74d04}.
\]
No código numeramos os \(z\) a partir de zero e usamos a posição \(i(i-1)/2+j\) para o monômio \(z_i z_j\), \(0\le j<i<10\). O certificado verifica que \(q_1\wedge q_2\wedge q_3\wedge q_4=0\) na álgebra exterior das dez coordenadas. Cada termo do símbolo cúbico de \(g_{14}\) contém um controle. Logo a quarta potência dividida é nula, e as de ordem maior também se anulam, pois requereriam mais de quatro controles distintos.

Identifique os pontos do bloco de 14 variáveis por uma máscara binária com \(z\) nos dez bits baixos e \(t\) nos quatro altos. Após a translação física por \(\mathtt{0x3608}\), a FWHT inteira dá
\[
 W_{g_{14}}(b)\equiv-32\pmod{128}\quad\text{em toda frequência},\qquad W_{g_{14}}(0)=1248 .
\]
Acrescente quatro blocos independentes de três variáveis, cada um com o termo \((1+y_1)(1+y_2)(1+y_3)\). A transformada de cada bloco assume \(6\) na frequência zero e \(-2\) nas outras sete. O produto dos quatro é \(16\bmod64\). Assim a cúbica resultante \(g\) em 26 variáveis tem
\[
 W_g(b)\equiv-512\pmod{2048}\qquad\text{e}\qquad
 \gamma_8([g]_3)=0.
\]
Para a última identidade, na oitava potência dividida o bloco de 14 teria de fornecer pelo menos quatro fatores, pois cada bloco de três fornece no máximo um. A paridade de sobreposição em dimensão 26 é ímpar, já que \(\nu_2(W_g(0))=9\). Mesmo a congruência local em todas as frequências, portanto, é compatível com essa paridade.

## 2. Uma condição inteira módulo 127 e exclusão de dois blocos independentes

Escolha um complemento físico de \(U\) de dimensão seis e rotule as fatias por \(t\in\mathbb F_2^6\). Escreva \(g_t=f|_{t+U}\) nas coordenadas de \(U\). Para cada frequência \(b\in U^*\), escreva \(W_f(u,b)\equiv4\sigma_b(u)\pmod{127}\), com \(\sigma_b(u)\in\{-1,1\}\). Poisson nas 64 frequências sobre \(b\) dá
\[
 W_{g_t}(b)\equiv8\sum_{u\in\mathbb F_2^6}\sigma_b(u)(-1)^{u\cdot t}\pmod{127},
\]
pois \(64^{-1}\equiv2\pmod{127}\). Seja
\[
 r_b(t)=\operatorname{cen}_{127}\!\left(16^{-1}W_{g_t}(b)\right),
\]
onde o representante centrado está em \([-63,63]\). A metade da soma acima antes do fator oito é um inteiro em \([-32,32]\), de modo que
\[
 |r_b(t)|\le32,\qquad
 \widehat r_b(u)=32\sigma_b(u),\qquad
 \sum_t r_b(t)^2=1024 .
\]
As três condições são exatas. Para uma coluna fixa \(b\), a segunda condição, com sinais recuperados pela transformada, é também suficiente para compatibilidade modular daquela coluna. Isso fornece um teste conjunto sobre as 64 fatias.

**Proposição.** O candidato global não admite uma restrição a um \(26\)-espaço linear que, até termo afim e mudança de coordenadas, seja soma de uma função em 20 variáveis e duas funções de grau três em blocos independentes de três variáveis.

**Prova.** Um termo afim só desloca frequências ou troca um sinal constante, preservando o intervalo centrado e deixando a congruência local da forma \(\pm512\bmod2048\). A tabela-verdade de uma função de grau três em três variáveis tem peso ímpar, mesmo após somar qualquer função afim. Cada coeficiente de Walsh tem então módulo 2 ou 6. Parseval dá exatamente sete coeficientes de módulo 2 e um de módulo 6 por bloco. Podemos selecionar produtos de Walsh de módulos \(4\), \(12\) e \(36\). A condição anterior, aplicada apenas a \(t=0\), impõe para cada frequência do núcleo de 20 variáveis que
\[
 |z|\le32,\qquad
 |\operatorname{cen}_{127}(3z)|\le32,\qquad
 |\operatorname{cen}_{127}(9z)|\le32,\quad
 z=\operatorname{cen}_{127}(W_{\rm nucleo}/4).
\]
As duas primeiras cotas dão \(|z|\le10\) ou \(|z|=32\). Nesta última opção, \(9\cdot32\) tem representante centrado \(34\), impossível. Para \(|z|\le10\), vale \(|9z|\le90\); a terceira cota então exige \(|z|\le3\).

O produto \(4\), com sinal fixado pela escolha de duas frequências não nulas dos blocos, dá \(W_{\rm nucleo}\equiv\pm128\bmod512\) em todas as frequências. Portanto \(A=W_{\rm nucleo}/128\) é ímpar e \(A\equiv4z\bmod127\), pois \(128\equiv1\bmod127\). Como \(4z\) é par e \(|4z|\le12\), isso força \(|A|\ge115\). Mas Parseval em 20 variáveis dá \(\mathbb E A^2=64\), contradição.

A proposição exclui a extensão global do exemplo da Seção 1, que se decompõe em quatro blocos desse tipo. Ela exclui também todo caso com dois desses blocos, mesmo que o núcleo restante seja indecomponível.

**Um único bloco.** Se houver um só bloco cúbico destacado, o núcleo tem 23 variáveis e grau no máximo três. Podemos absorver um sinal constante para escrever \(A=W_{\rm nucleo}/256\equiv1\bmod4\). A condição modular exige \(\operatorname{cen}_{127}(32A)\in[-10,10]\cup\{-32,32\}\), usando o mesmo argumento das duas primeiras cotas. Em particular, todo núcleo desse tipo satisfaz a congruência mais forte \(W_{\rm nucleo}\equiv256\bmod8192\), depois da escolha de sinal.

Com efeito, suponha já \(A\equiv1\bmod2^j\) e ponha \(B_j=((A-1)/2^j)\bmod2\). Para um coeficiente multilinear inteiro de ordem \(d\) de \(W_{\rm nucleo}\), a expansão do caráter fornece \(2^d\) vezes uma soma de sinais de uma cúbica restrita a \(23-d\) variáveis. A expansão em monômios dá valoração pelo menos \(d+\lceil(23-d)/3\rceil\). Logo \(\deg B_j\le3,5,6\) para \(j=2,3,4\), respectivamente. O menor \(|A|\) nas classes admissíveis em que \(B_j=1\) é, respectivamente, \(91,87,111\), por CRT. Se algum desses bits fosse não nulo, a distância mínima obrigaria
\[
 \mathbb E(A^2-1)\ \ge\ \frac{\min_{B_j=1}|A|^2-1}{2^{\deg B_j}}\ >127.
\]
Contradição, pois Parseval dá \(\mathbb E A^2=128\). Portanto \(B_2,B_3,B_4\) zeram e \(A\equiv1\bmod32\). Essa redução ainda permite um bloco.

## 3. Condições simultâneas sobre os símbolos cúbicos das fatias

Se \(a_f|_U=0\), todas as \(g_t\) têm grau no máximo três. Seus símbolos têm a forma \(c(t)=c_0+\sum_{i=1}^6t_ic_i\). Por Poisson, \(W_{g_t}\equiv-512\,\mathbf1_{\{t=0\}}\pmod{2048}\). Além disso, cada restrição física de dimensão 24 tem soma de sinais divisível por \(512\). O termo de valoração oito nessa dimensão é a avaliação de \(\gamma_8\). Portanto \(\gamma_8(c(t))=0\) para todos os \(t\).

Denote pela letra \(I(c)\) a paridade das seleções de nove monômios cúbicos que cobrem as 26 coordenadas, com uma única repetição. Quando \(\gamma_8(c)=0\), a expansão do sinal implica \(I(c)=W_g(0)/512\bmod2\): a contribuição alternativa de oito cúbicas disjuntas e um quadrático se anula por \(\gamma_8(c)=0\). Consequentemente
\[
 I(c(t))=\mathbf1_{\{t=0\}} .
\]
A aplicação afim \(t\mapsto c(t)\) é injetiva. Se um vetor \(t\ne0\) pertencesse ao núcleo da parte linear, \(c(t)=c(0)\), mas as paridades seriam distintas. Ainda, \(\gamma_6(a_f)=0\) dá
\[
 c_1\wedge c_2\wedge\cdots\wedge c_6=0 .
\]
De fato, como \(a_f|_U=0\), cada monômio quártico contém pelo menos um controle. No coeficiente que contém exatamente os seis controles de \(\gamma_6(a_f)\), cada um dos seis fatores deve usar exatamente um controle distinto. Resta o produto indicado. Assim o problema global em codimensão seis requer uma família afim injetiva de símbolos que satisfaça essas identidades simultâneas, além do teste por coluna da Seção 2.

## 4. Calibração da outra frente

Em dimensão 15, a lista de perfis locais do adendo anterior, por si só, não esgota as possibilidades de uma restrição global. Dois dos perfis ocorrem para funções booleanas de grau no máximo quatro isoladamente:

- Um quadrático de posto 14 em 15 variáveis tem espectro em \(\{0,\pm256\}\), com \(16384\) coeficientes não nulos.
- Para \(g(x,y)=xq(y)\) em 15 variáveis, tome \(q\) quadrático balanceado em 14 variáveis com posto 12 e termo linear não nulo no radical. Então \(g\) tem dois coeficientes iguais a \(16384\), \(8192\) coeficientes de módulo \(256\) e os demais nulos. Isso segue de decompor em \(x=0\) e \(x=1\).

Essas construções não são extensões globais do candidato. Elas mostram por que o grau e a lista local de valores de Walsh não bastam para eliminar esses dois perfis. A existência de \(L\) de dimensão 15 com autocorrelação nula permanece sem prova.

O caso global \(D=h=0\) continua em aberto. O avanço desta rodada é a exclusão modular de uma classe inteira em codimensão seis e a formulação explícita das condições de compatibilidade entre as fatias.
