# p=17, dimensão 20, espectro normalizado par

Seja g de grau até quatro em V=F₂²⁰. Suponha W_g(b)≡±1024 (mod 17) para toda frequência. Por divisibilidade de Walsh de funções quárticas, X=W_g/32 é inteiro, X≡±2 (mod 17) e E X²=1024. Para a transformada normalizada na frequência b, escrevemos Fourier(F)(a)=E_b F(b)(−1)^(a·b). Assim Fourier(X)(a)=(−1)^g(a)/32.

Se X é múltiplo de 4 em todo o espaço, os menores módulos aritmeticamente possíveis são 32, e Parseval dá bentness. A análise abaixo supõe X≡2 (mod 4) em todo o espaço. Ela não se aplica ao caso em que X é múltiplo de 4 somente em um hiperplano. Nenhuma simetria de rotação é necessária.

## Quadrática de fase e quártica residual

Defina Q pela congruência X≡2−4Q (mod 8), com Q booleana, s=(−1)^Q e Y=sX. Defina D pela congruência Y≡2+8D (mod 16). Então deg Q≤2 e deg D≤4.

Para conferir isso, seja c_S o coeficiente multilinear inteiro de X. Para j=|S|≥1, c_S é (-2)^j/32 vezes uma soma de sinais de uma restrição de g em 20−j variáveis. Divisibilidade pelo grau dá v₂(c_S)≥ceil(3j/4), incluindo j=20 por inspeção da soma de um termo. Como X≡2 (mod 4), o bit ((X−2)/4) mod 2 tem grau≤2. Além disso (1−2Q)(2−4Q)=2 como identidade de funções inteiras. Logo D=((X−2+4Q)/8) mod 2. Para j≥5, os coeficientes de X e de 4Q são divisíveis por 16: no segundo caso expanda a XOR da ANF quadrática em produto de monômios e use que uma união de suporte j requer pelo menos ceil(j/2) monômios. Assim D tem grau≤4.

## Restrição por posto

Seja 2h o posto polar de Q e w=E D. Como s é fase quadrática, Fourier(s) tem suporte afim A de dimensão 2h e módulo 2^(−h) em A. Segue de Fourier(X)=±1/32 que |E Y|≤2^h/32.

O ponto Y possui resíduos ±2 (mod 17). Quando D=0, Y≡2 (mod 16) e seus valores pertencem às progressões 2+272Z ou 66+272Z. Quando D=1, Y≡10 (mod 16) e pertence a −70+272Z ou 138+272Z. Portanto

    (Y−2)(Y−66)≥0 em D=0
    (Y+70)(Y−138)≥0 em D=1.

Expandindo, Y²−68Y+132−9792D≥0. Tomando médias, E Y≤17−144w. A energia isolada também dá w≤5/24, porque X²≥4+4896D. Em conjunto,

    w ≤ min(5/24, (17+2^h/32)/144).

Em particular, na faixa residual w≥1/8, os postos polares 0, 2, 4, 6 e 8 estão excluídos. Posto 10 força w=1/8. Postos 12, 14 e 16 impõem respectivamente w≤19/144, 7/48 e 25/144. Para postos 10, 12 e 14, o peso fica abaixo do limiar 5/32 de Kasami–Tokura–Azumi, que garante algum flat de zeros de codimensão dois. Isso não controla por si o orçamento de energia nesse flat. Referência: https://doi.org/10.1016/S0019-9958(76)90355-7

## Saturação no posto 10

Se h=5 e w≥1/8, então w=1/8, E Y=−1, e todas as desigualdades pontuais acima são igualdades. Assim Y∈{2,66} quando D=0, e Y∈{−70,138} quando D=1. A igualdade na cota pela soma dos módulos força Fourier(X)|A=−Fourier(s)|A, pois cada módulo é 1/32.

Se A=a₀+U, então s(b) tem a forma (−1)^(a₀·b) vezes uma fase dependente somente da classe de b módulo U⊥. A projeção de X sobre as frequências A é −s. Equivalentemente, a média de Y em toda classe lateral de U⊥ é −1. Em particular, nenhuma dessas classes está inteiramente contida em D=0.

Há ainda divisibilidade adicional para o próprio D. Escreva Fourier(s)(c)=2^(−5)η(c) em A, com η uma fase quadrática cujo polar é não degenerado em U. Defina S_a=Σ_(c∈A) η(c)(−1)^g(a+c). Para a≠0, a transformada de Y²−68Y+132−9792D=0 dá

    AC_g(a)/17 = 4 S_a − (9/32)W_D(a).

De fato Fourier(X²)(a)=AC_g(a)/1024, Fourier(Y)(a)=S_a/1024 e Fourier(D)(a)=−W_D(a)/(2·2²⁰) para a≠0. Na identidade, AC_g(a) é múltipla de 17 por Walsh² modular e múltipla de 256 por divisibilidade da derivada cúbica D_a g no quociente de dimensão 19. Logo AC_g(a)/17 é múltipla de 256. A saturação acima diz que g|A é a fase quadrática dual, acrescida de 1. Em todo translate de A, a parte de grau quatro nas direções de U é a mesma que em A. Portanto g(a+c) como função de c em A tem grau≤3 e 16 divide S_a. Segue que 2048 divide W_D(a) para todo a≠0. Na origem, W_D(0)=3·2¹⁸, que satisfaz a mesma divisibilidade. Se a∈U é não nulo, η(c)η(a+c) é uma fase linear não constante em A, S_a=0 e 8192 divide W_D(a). A seção abaixo exclui esse subcaso na faixa residual.

## Família afim em classes laterais

Se g é afim nas classes laterais de um subespaço de dimensão seis, escreva g(w,z)=w·π(z)+h₀(z) com z∈F₂¹⁴. A soma em w dá W_g(a,b)/64 como a transformada do indicador assinado da fibra π⁻¹(a). Sua paridade é a cardinalidade dessa fibra módulo 2, independente de b. Logo todas as fibras pares implicam divisibilidade de W_g por 128 e, pelo primeiro argumento, bentness. A soma das seis cotas para graus das coordenadas de π menor que 14 garante fibras pares, porque o indicador ∏ᵢ(1+πᵢ(z)+aᵢ) tem grau menor que 14. Para quárticas, deg πᵢ≤3, de modo que a paridade dessa fibra é sempre afim em a: ao menos cinco dos fatores devem fornecer coordenadas de π para atingir o grau 14. Assim um contraexemplo nessa família precisa ter 32 ou 64 fibras ímpares.

## Exclusão de postos polares até 16 na faixa residual w≥1/8

Denote a folga pontual por L=Y²−68Y+132−9792D. Sua média obedece

    E L ≤ 1156−9792w+68·2^(h−5).

Em D=0, declare ruim um ponto com Y≠2 (mod 32), ou equivalentemente X≠2s (mod 32). As classes de Y para tais pontos são −206 e −270 (mod 544). Avaliando (Y−2)(Y−66) nas progressões, o menor custo é L=56576, nos valores −206 e 274.

Em qualquer flat de zeros F de D, o bit E=(X−2s)/16 mod 2 está definido; E=1 exatamente nos pontos ruins e grau E≤6. No sistema de coordenadas de F, X tem a mesma divisibilidade de coeficientes 2^ceil(3j/4) pelas mudanças afins. Para justificar isso, um monômio multilinear inteiro em j bits, depois de uma substituição por formas afins booleanas, contribui a grau k com fatores divisíveis por 2^max(0,k−j), pela expansão inteira de paridades. O termo 2s=2−4Q tem coeficientes divisíveis por 32 nos graus ≥7, pela expansão de XOR da ANF quadrática. Esses fatos dão grau E≤6.

Para qualquer 6-flat B contido em F, Poisson dá Σ_B X divisível por 32, porque a soma se reduz a 2 vezes uma soma de sinais em 14 variáveis, divisível por 16. Logo Σ_B E mod 2 é 1 precisamente quando a polar de Q em B é não degenerada. De fato Σ_B 2s = ±16 em posto 6. Em posto ≤4, a soma é zero ou múltipla de 32. Em particular, se o posto em F é ≥6, cada classe lateral de um subespaço simplético de dimensão seis em F tem pelo menos um ponto ruim. Para F de codimensão c, isso implica E L≥56576/(64·2^c).

A cota se fortalece para posto ≥8, conforme a seção seguinte. Seu caso de dimensão oito diz que em F a frequência de pontos ruins é ≥5/128. O custo global fica E L≥2210/2^c.

Usamos o Teorema 3 de Klein–Storme, que garante flat de zeros de codimensão c para qualquer quártica de peso estritamente inferior a (3−2^(1−c))/16, c≥2. Fonte: https://doi.org/10.3934/amc.2011.5.333, pp. 335–336, texto integral https://backoffice.biblio.ugent.be/download/2140143/2939938. O posto ao restringir ao flat cai no máximo 2c.

- h≤4 contraria a primeira cota de peso.
- h=5,6,7. O peso superior já demonstrado é menor que 5/32. Logo existe flat D=0 de codimensão 2, com posto de Q pelo menos 6. Segue E L≥221, mas o orçamento acima é ≤204.
- h=8 e w<5/32. Codimensão 2 e posto pelo menos 8 dão E L≥2210/4=552,5, enquanto o orçamento é ≤476.
- h=8 e 5/32≤w<11/64. Codimensão 3 e posto pelo menos 8 dão E L≥2210/8=276,25, enquanto o orçamento é ≤170.
- h=8 e 11/64≤w≤25/144. Como 25/144<23/128, há flat de codimensão 4, ainda com posto de Q pelo menos 6. Dá E L≥221/4=55,25, enquanto o orçamento é ≤17.

## Cotas de peso do bit ruim via momentos

Em um bloco B de dimensão n=2r dentro de D=0 e simplético para Q, use coordenadas canônicas com pares de variáveis a_i,b_i e abreviação z_i=a_i b_i. A parte de grau seis de E é

    P₆=Σ_(i<j<k) z_i z_j z_k.

Isto é determinado pela paridade em cada 6-flat coordenado: só um conjunto união de três pares dá posto seis. Seja S o suporte de E dentro de B. Pelo emparelhamento de paridade de Reed–Muller, os momentos Σ_(x∈S) x^I são zero se |I|<n−6. Para |I|=n−6, esse momento é o coeficiente de grau seis de E no complemento de I. Portanto é um exatamente quando I é união de r−3 pares.

Para n=8,10,12, seja k=(n−6)/2. Em F₂^S, R_j denota o espaço gerado pelas linhas de avaliação em S de todos os monômios de grau ≤j. Na restrição do produto escalar a R_k, o bloco não nulo da matriz de Gram pode ser calculado apenas sobre os monômios de grau exatamente k. Como R_(k−1) está contido no radical da forma, a matriz tem posto no máximo |S|−2 dim R_(k−1). De fato R_k ⊂ R_(k−1)^⊥ e a interseção de R_k com seu ortogonal contém R_(k−1).

- n=8, k=1. A matriz é quatro blocos alternados de tamanho 2, de posto total 8. O espaço R₀ tem dimensão 1. Logo |S|≥10, isto é, peso ≥5/128.
- n=10, k=2. Há 40 monômios com uma variável de cada um de dois pares, formando um bloco de permutação de posto 40. Os cinco monômios de par integral dão a matriz J₅+I₅, de posto 4. R₁ tem dimensão 11. Se uma forma linear afim não nula anula E, sua parte linear multiplica P₆ no exterior a zero. Cada variável que aparece nessa forma pode ser testada usando três pares disjuntos do par da variável, o que produz monômio exclusivo. O caso constante não anula E. Assim |S|≥44+22=66.
- n=12, k=3. Os 160 monômios com três variáveis de três pares distintos permutam com o complemento dentro desses pares. Para cada um dos seis pares que contém variável isolada em um monômio dos demais, o bloco desse par tem duas matrizes J₅+I₅ fora da diagonal, de posto total 8. O posto total é 208. Para a avaliação R₂, um anulador de grau ≤2 tem parte de grau dois no núcleo da multiplicação exterior por P₆. Um monômio que cruza dois pares tem coeficiente reconhecível sozinho por três pares disjuntos dos dois. Portanto sobra só Σ c_i z_i. Em quatro pares a condição é Σ c_i=0, para todo conjunto de quatro dos seis pares. Comparar dois conjuntos que diferem por um índice força todos os c_i iguais. Como não há anulador não nulo de grau ≤1, o núcleo de avaliação tem dimensão no máximo um, e dim R₂≥78. Assim |S|≥208+156=364.

A presença de uma polar de posto pelo menos n em F permite decompor F em classes laterais de um mesmo subespaço simplético de dimensão n. Portanto cada limite de peso vale em média em F. Em particular, posto ≥10 dá E L ≥ 56576·66/(2^c·1024) e posto ≥12 dá E L ≥ 56576·364/(2^c·4096), se F tiver codimensão c.

## Posto polar 18, exclusão de 1/8≤w<23/128

Neste caso E L≤2244−9792w. Se F tem codimensão 2, 3, 4 ou 5, conserva respectivamente posto ≥14, 12, 10 ou 8. As cotas globais mínimas em cada um desses flats de zeros são, na mesma ordem, 20111/16, 20111/32, 7293/32 e 1105/16. Uma cota sobre a contribuição de F refere-se sempre a E[1_F L], e cotas de regiões disjuntas podem ser somadas.

Para w<5/32, há F de codimensão 2 pelo teorema de Klein–Storme. A cota 20111/16 supera o orçamento máximo 1020.

Para 5/32≤w<11/64, há F de codimensão 3. Sua contribuição 20111/32 já supera o orçamento se w>3041/18432. Para os pesos restantes, as outras sete classes laterais C de F têm grau ≤3, pois D=0 em F anula todos os monômios que não envolvem uma das coordenadas fixadas. Nenhuma pode ser zero, pois sua união com F daria codimensão 2. Por Kasami–Tokura, as menores densidades não nulas para uma cúbica são 1/8, 3/16 e, a seguir, pelo menos 7/32. As de densidade 1/8 indicam um flat de codimensão três. As de densidade 3/16 têm fator afim. Referência: https://doi.org/10.1109/TIT.1970.1054545.

Se C tem densidade 1/8, na união afim G=F∪C a função D indica um flat de codimensão quatro em G. Existem 15 hiperplanos afins em G disjuntos desse suporte, um para cada funcional não nulo do quociente de dimensão quatro. Cada ponto fora do suporte pertence a oito deles. São flats de zeros de codimensão total três e a soma de suas contribuições, dividida por oito, dá E L≥(15/8)(20111/32)>714. Se nenhuma C tem densidade 1/8 e alguma tem densidade ≥7/32, então w≥43/256>3041/18432, caso já excluído. Resta w=21/128 e todas as classes C com densidade 3/16. Em G=F∪C de qualquer uma delas, o fator afim em C dá um flat de codimensão total quatro de zeros dentro de C. Somando sua contribuição ≥7293/32 à contribuição de F, obtém-se E L>(1275/2), o orçamento desse peso.

Para 11/64≤w<23/128, há F de codimensão 4. Uma segunda classe lateral de zeros geraria flat de codimensão 3, cuja contribuição 20111/32 já supera o orçamento máximo 561. Portanto todas as 15 demais classes laterais são cúbicas não nulas. Se uma delas tem densidade 1/8, seus sete hiperplanos externos ao suporte mínimo cobrem o complemento com multiplicidade quatro. São flats de codimensão total cinco, e essa classe contribui pelo menos (7/4)(1105/16). Se tem densidade 3/16, o fator afim dá contribuição pelo menos 1105/16. Escrevendo v_C para a densidade de D em cada classe C, nos dois casos a contribuição é ≥(15470/12) max(0,7/32−v_C). Para as demais classes, max(0,7/32−v_C)=0. Como Σ_C v_C=16w, resulta

    E L ≥ 7293/32 + (15470/12)(105/32−16w).

Este limite inferior supera 2244−9792w nos dois extremos 11/64 e 23/128 e, por linearidade, em todo o intervalo considerado. A hipótese de existência do flat de codimensão 4 foi usada com desigualdade estrita em 23/128.

## Melhoria do primeiro momento nos postos 18 e 20

Seja A o suporte de Fourier(s) e η a fase dual em A. Defina a função booleana K em A pela equação (−1)^g(a)=−η(a)(−1)^K(a). Seja v o peso relativo de K em A. Então E Y=−2^(h−5)(1−2v). Na verdade, nos cosets do radical R da polar de Q, a projeção sobre A dá a identidade mais forte

    E_(b+R) Y = −2^(h−5) + (s(b)/16) Σ_(a∈supp K) η(a)(−1)^(a·b).

Isso decorre de Fourier(X)=(-1)^g/32: nos caracteres de A, Fourier(X) difere de −2^(h−5)Fourier(s) exatamente em +η/16 nos pontos de supp K. Ao projetar, o deslocamento afim de A é cancelado pela modulação por s no lado esquerdo.

Para h=9 ou 10 vale v≥1/8. De fato, nas dimensões 18 e 20 de A, se v<1/8, Kasami–Tokura classifica K de grau até quatro como zero, indicador de um flat de codimensão quatro, diferença simétrica de dois flats de codimensão quatro, ou produto de duas formas afins com uma quadrática. Nas três formas não nulas, a soma assinada na fórmula é divisível por 64 em A de dimensão 18, e por 128 em A de dimensão 20. Para um flat de codimensão quatro, use a soma de Gauss quadrática em dimensão pelo menos 14. Para uma diferença simétrica, some as duas somas de flats e subtraia duas vezes a soma da interseção. A interseção, quando não vazia, tem dimensão pelo menos 10 ou 12, respectivamente. Para um produto de duas formas afins com uma quadrática, restrinja ao flat de codimensão dois e escreva a soma como a metade da diferença de duas somas quadráticas. Uma soma quadrática em dimensão d é zero ou divisível por 2^ceil(d/2).

Se h=9, o radical tem quatro elementos. A soma de Y em cada coset de R seria divisível por 16. Mas Y≡2+8D (mod 16) força, então, um número ímpar de pontos de D em cada coset. Isso daria w≥1/4, acima do orçamento w≤5/24. Se h=10, o radical é trivial e a mesma fórmula tornaria Y múltiplo de oito ponto a ponto, também impossível. Assim v≥1/8 em ambos os casos. Aos postos 18 e 20 correspondem, respectivamente,

    E L≤1972−9792w e E L≤2788−9792w.

Em particular, no posto 18 o peso residual satisfaz ainda w≤29/144.

## Posto 18, extensão até w<47/256

Para 23/128≤w<47/256, Klein–Storme fornece um flat de zeros F de codimensão cinco. Se uma segunda classe lateral paralela a F é de zeros, sua união com F fornece um flat de zeros de codimensão quatro. O argumento de contagem da seção anterior, aplicado a esse flat, dá a mesma cota inferior 7293/32+(15470/12)(105/32−16w) se não houver uma segunda classe de zeros de codimensão quatro. Havendo-a, o flat de codimensão três contribui pelo menos 20111/32. Os dois casos contradizem o novo orçamento em toda a faixa.

Portanto podemos supor as 31 classes restantes cúbicas não nulas. A primeira faixa de pesos cúbicos funciona como no caso anterior. Cada classe de peso 1/8 contém sete hiperplanos evitando seu suporte e cobrindo o complemento com multiplicidade quatro. Os hiperplanos são de codimensão total seis, logo contêm um subespaço simplético de dimensão seis e cada um contribui no mínimo 221/16 ao orçamento global. Uma classe de peso 3/16 tem pelo menos um desses hiperplanos. Usando deficiência em relação a 7/32, a contribuição por unidade de deficiência é no mínimo (7/4)(221/16)/(3/32)=1547/6. A contribuição de F no posto 18 é pelo menos 1105/16. Assim

    E L≥1105/16 + (1547/6)(217/32−32w),

cujo valor supera 1972−9792w nos dois extremos 23/128 e 47/256. A desigualdade estrita na existência de F restringe esta extensão a w<47/256.

## Posto 20, exclusão de 1/8≤w<23/128

Para este posto também é útil a cota de peso dos pontos ruins em um bloco simplético de dimensão 14. A parte de grau seis ainda é P₆, agora em sete pares. Os momentos de ordem menor que oito são zero, e os de ordem oito valem 1 exatamente quando o suporte é união de quatro pares. A matriz de Gram dos monômios de grau quatro tem os seguintes blocos.

- Quatro variáveis de pares distintos dão uma matriz de permutação de posto 560.
- Duas variáveis isoladas de dois pares e um par inteiro dão, por escolha dos pares das isoladas e orientação, permutação da orientação com um bloco J₅+I₅. O posto total dessa parte é 336.
- Dois pares inteiros têm a matriz de disjunção em conjuntos de dois elementos de sete, de posto 14. Para conferir, se c é um vetor nessa parte, ponha T=Σ c_{ij} e s_i=Σ_{j≠i} c_{ij}. A equação de núcleo é c_{ij}=T+s_i+s_j. Reciprocamente qualquer T e sete s_i com Σ s_i=0 formam por essa equação um vetor com os totais prescritos. O núcleo tem dimensão 7 em 21 colunas.

O posto total é 910. O espaço de avaliação R₃ tem dimensão pelo menos 455 de 470. Tal como antes, a multiplicação exterior de P₆ por uma parte quadrática tem núcleo de dimensão no máximo um. A parte cúbica de um anulador não pode conter monômio com três variáveis de três pares, pois é possível escolher três pares disjuntos desses três e reconhecer seu coeficiente por um monômio de produto exclusivo. Para termos contendo uma variável isolada e um par inteiro, fixe a variável isolada. A condição no conjunto de quatro outros pares é a soma dos coeficientes nesses quatro pares igual a zero. Isto força todos os coeficientes relativos à variável isolada iguais. Portanto o núcleo da multiplicação exterior na terceira potência tem dimensão no máximo 14. Pelo controle de graus sucessivos, a avaliação até grau três tem núcleo de dimensão no máximo 15. Como R₃ se inclui no radical da forma de Gram em R₄, a cardinalidade do suporte é no mínimo 910+2·455=1820 dentro de 2¹⁴ pontos.

Com a nova cota E L≤2788−9792w, seguem três intervalos.

- Para w<5/32, escolha F de codimensão dois de zeros. Conserva posto pelo menos 16, suficiente para a cota de dimensão 14. Sua contribuição é pelo menos 100555/64>1564, o maior orçamento.
- Para 5/32≤w<11/64, escolha F de codimensão três. Conserva posto pelo menos 14, contribuindo no mínimo 100555/128. Suas sete classes restantes são cúbicas. Caso alguma seja zero, obtemos codimensão dois e a mesma contradição anterior. Caso alguma tenha peso mínimo 1/8, seus sete hiperplanos que evitam o suporte são de codimensão total quatro, conservando posto pelo menos 12. Essa classe acrescenta pelo menos (7/4)(20111/64) à contribuição de F, superando o maior orçamento 1258. Sem classe mínima, pelo menos duas classes têm peso 3/16. Caso contrário, w≥(3/16+6·7/32)/8=3/16. Cada classe de peso 3/16 dá um hiperplano de zeros e acrescenta pelo menos 20111/64. Novamente ultrapassamos o orçamento. Observe que a dedução funciona na faixa ampliada 5/32≤w≤23/128 se já existir F de codimensão três.
- Para 11/64≤w<23/128, a existência de F de codimensão quatro vem de Klein–Storme. Conserva posto 12, contribuindo no mínimo 20111/64. Uma segunda classe de zeros fornece codimensão três e se aplica o argumento anterior. Fora disso, as 15 classes são cúbicas não nulas. A contribuição mínima de um zero hiperplano numa classe é 7293/64, pois sua codimensão total é cinco e seu posto pelo menos 10. Para uma classe de peso 1/8, os sete hiperplanos amplificam essa quantia por 7/4. Para peso 3/16, um hiperplano basta. Usando os mesmos déficits, E L≥20111/64+(17017/8)(105/32−16w), limite estritamente acima do orçamento em toda a faixa pelos valores nos extremos.

## Posto 20, extensão até w<47/256

Para 23/128≤w<47/256, use o flat de zeros F de codimensão cinco garantido por Klein–Storme. Sua contribuição é ≥7293/64, porque Q conserva posto pelo menos 10. Uma segunda classe de zeros implica um flat de codimensão quatro, e a estimativa anterior para tal flat continua valendo até 47/256. Em particular, se houver duas classes de zeros para esse novo flat, sua união fornece codimensão três e o argumento por fatias permanece válido, pois 47/256<3/16.

Se as 31 demais classes de F são não nulas, use agora o déficit em relação a 1/4 para cada classe cúbica C de peso v_C. Por Kasami–Tokura, há três possibilidades com v_C<1/4.

- Se v_C=1/8, os sete hiperplanos que evitam o suporte dão contribuição ≥(7/4)(1105/32), pois têm codimensão total seis e Q conserva posto pelo menos 8.
- Se C tem fator afim e v_C≥3/16, um hiperplano de zeros dá contribuição ≥1105/32. Seu déficit é no máximo 1/16.
- Na forma cúbica de peso 7/32 que é diferença simétrica de dois flats de codimensão três com seis equações independentes, escolha um hiperplano entre os sete que evitam cada flat. As 49 interseções são flats de zeros de codimensão total sete, com posto de Q pelo menos 6. Cada ponto fora dos dois suportes pertence a dezesseis interseções. Isso dá contribuição ≥(49/16)(221/32), para déficit 1/32.

Em todos os casos a contribuição é ≥(7735/16) max(0,1/4−v_C), e a desigualdade é imediata quando o déficit é zero. Como Σ_C v_C=32w, obtemos

    E L≥7293/64 + (7735/16)(31/4−32w).

O limite supera 2788−9792w nos dois extremos da faixa.
