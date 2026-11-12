# Polar em u e autocorrelação no bloco de dimensão três

## A polar das variações de fase tem uma única direção

Escreva z=(x+r,x), com x,r em F₂³, e seja u a coordenada do complemento antipodal. No núcleo do mapa π, a fase k tem grau total no máximo quatro, é quadrática em u e é invariante por ρ. Em particular é invariante por κ=ρ³, que envia (x,r,u) a (x+r,r,u+x). A polar em u tem a forma

    B_(x,r)(u,v) = det(b(x,r),u,v),
    b(x,r) = a·σ(r)r,    a ∈ F₂,

onde σ(r)=r₀+r₁+r₂. Este resultado descreve as diferenças entre duas fases do mesmo mapa. A polar da fase de referência pode depender do mapa.

**Prova.** De κ² segue B_(x,r)r=0, logo b(x,r) é paralelo a r quando r≠0. A função b tem grau no máximo dois em (x,r). Em sua expansão em x, os coeficientes de x_ix_j são constantes em r e paralelos a todo r não nulo, portanto zero. Os coeficientes de x_i são funções afins de r, também paralelas a r. Qualquer função afim L com essa propriedade é um múltiplo escalar da identidade. De fato L(0)=L(r+s)+L(r)+L(s) pertence a todo plano gerado por r,s independentes. Isso dá L(0)=0. A aditividade força o mesmo escalar em todos os vetores não nulos. Assim b=b₀(r)+a₀(x)r, com a₀ linear. A invariância da polar por κ implica a₀(r)r=0 para todo r, então a₀=0.

Em r=0, κ é a translação u↦u+x. Como b₀(0) é independente de x, B_(x,0)x=0 para todo x implica b₀(0)=0. A rotação ρ gira ciclicamente r e a parte linear em u, então o escalar de b₀(r) só depende do peso de r. Como b₀ tem grau no máximo dois, sua soma sobre os oito r é zero. Isso iguala os escalares de pesos um e três. Assim b₀(r)=λ(r)r, com λ(r)=β+(a+β)σ(r), onde β é o escalar de peso dois.

Escreva k=h₀(x,r)+ℓ(x,r)·u+q_r(u), com q_r a parte quadrática canônica. Da invariância por κ, o coeficiente de u_i dá

    ℓ_i(x+r,r)+ℓ_i(x,r)=det(λ(r)r,x,e_i).

A direita é linear em x, logo o coeficiente de x₀x₁x₂ em ℓ_i é zero. Com efeito, esse coeficiente é constante em r pelo grau total e sua derivada em qualquer direção r≠0 tem uma parte quadrática não nula. Denote por c_i(r) o vetor polar da parte quadrática de ℓ_i em x. Ele é afim em r. Comparar os coeficientes lineares da identidade acima dá que c_i(r)+λ(r)e_i é paralelo a r para r≠0. Pela observação sobre funções afins, c_i(r)=λ(r)e_i+t_i r para algum t_i constante.

Compare agora os termos independentes de u na invariância por κ. A derivada em x de h₀ tem grau em x no máximo dois, pois só há três coordenadas x. Do outro lado, o termo cúbico vem de ℓ(x+r,r)·x e é igual à soma dos três coeficientes diagonais (c_i(r))_i. Assim λ(r)+Σ_i t_i r_i=0 para todo r. Em r=0, isso dá β=0. Em r=e_i, dá t_i=a para cada i. Consequentemente c_i(r)=a(σ(r)e_i+r). Em particular, diferenças de fases do mesmo mapa e da mesma polar têm coeficiente de u afim em x em toda fatia r constante.

Na fatia fixa, ℓ(x,0) é então afim em x. Escrevendo ℓ(x,0)=Lx+c, a condição ℓ(x,0)·x=0 dá L simétrica e c igual à diagonal de L. A rotação torna L circulante. Assim as direções possíveis de ℓ(x,0) são geradas por x+111 e x+σ(x)111. A conferência nas 26 direções do núcleo recupera exatamente essas duas direções e a polar não nula acima.

## Filtro de autocorrelação antes dos momentos

Para uma fibra S com fase h e um deslocamento d≠0, cada par {y,y+d} em S deve contribuir com um sinal positivo ou negativo. A autocorrelação nula equivale a haver o mesmo número de pares dos dois tipos. Em particular a interseção tem cardinal múltiplo de quatro e a soma de h sobre a interseção vale um quarto dessa cardinalidade módulo dois.

O teste sobre os 97.530 suportes, reduzidos a 6.242 órbitas, produziu os seguintes totais. Os números desta tabela precedem os testes de assinatura e de fases constantes feitos pelo preparador original.

| Equações lineares | Mapas compatíveis |
|---|---:|
| Paridades da autocorrelação | 46.018 |
| Momentos usuais das fibras | 6.558 |
| Ambos | 6.430 |

A classe de fatia fixa (0,0,0,3,0,5,6,0), com 9.528 mapas, já é descartada por autocorrelação sozinha. Na classe (0,6,5,0,3,0,0,0), o sistema conjunto reduz 384 a 256. As 128 exclusões correspondem a quatro órbitas de 32 mapas. Em 447615205 e 447615787, o par (rótulo, deslocamento)=(1,2) dá diretamente 0=1 no espaço de fases após momentos lineares. Em 447615486 e 447615536, os pares (2,1) e (3,1) têm o mesmo funcional da fase e lados direitos diferentes. As interseções nesses certificados têm oito pontos.

## Momentos das derivadas nas interseções

Escolha um representante de cada par da interseção S∩(S+d). Se há m representantes, o peso de D_d h entre eles deve ser exatamente m/2. O bit seguinte ao de paridade dá uma equação quadrática nos parâmetros da fase. O teste módulo quatro exclui 26 das 31 órbitas sem função bent entre as 43 órbitas de tarefas já preparadas, incluindo as quatro excluídas por paridade. O teste conjunto com os momentos ordinários módulo quatro exclui 28. Nas três órbitas espúrias restantes, as equações de pares módulo oito com as assinaturas dão contradição. As 12 órbitas positivas mantêm as contagens exatas quando se juntam os momentos ordinários completos. As congruências de autocorrelação, por si sós, ainda não fornecem as contagens de fase das órbitas positivas.

## A fibra fixa reduz a condição de bentness a uma permutação

Nos representantes de tipos A₀ e C₂ que chegaram às 43 tarefas, π se anula em Φ={r=0} e a polar da fase em u na fatia Φ é zero, conferida para cada levantamento. Então Φ é toda a fibra de rótulo zero, pois tem os 64 pontos exigidos. Nessa fibra h(x,0,u)=h₀(x,0)+ℓ(x,0)·u é bent em seis variáveis exatamente quando ℓ(x,0) é uma permutação. A prova é somar primeiro em u. As direções do núcleo permitem só quatro valores de ℓ por mapa, pela forma demonstrada acima.

Nas tarefas de tipo A₀, esse teste exclui os 64 mapas sem fase bent e deixa 144, todos com uma única escolha possível de ℓ e com fase bent confirmada pelas contagens anteriores. Nas de tipo C₂, os 384 mapas têm uma única escolha de ℓ que é permutação. Os outros rótulos continuam necessários para selecionar os 112 mapas C₂ com fase bent. Esses resultados se referem às tarefas preparadas e não classificam à mão todos os suportes que as antecedem.

## Nos tipos C, a polar na fatia r=111 decide a afinidade em V₂

**Hipóteses.** A função f é RS, quadrática em w e afim nas classes de V₃. Em coordenadas w=(u+v,v), escreva B_z para a polar em w e b(x,r) para o vetor que representa sua restrição em u. Suponha π|_Φ=0 e Q(z)u=111·(a(r)·u), com a(r)=r×Cʲr para j=1 ou 2 e C a rotação de três coordenadas. Denote por V₂ o espaço de vetores w com ambas as paridades, de índices pares e de índices ímpares, iguais a zero.

**Enunciado.** A polar de f em V₂ se anula em todas as classes laterais exatamente quando b(x,111)=0. O lado direito independe de x. Se a função pertence à parte exclusiva do bloco de dimensão três, a polar de cada linha da fatia r=111 é portanto de posto dois.

**Prova.** A meia-volta preserva f e envia w a w+z, logo B_z z=0. Em (u,v), z tem u=r e v=x. Usando a forma de Q, segue b(x,r)×r=σ(x)a(r). Assim b(x,r)+σ(x)Cʲr é paralelo a r para r≠0. Como esse vetor tem grau no máximo dois, a expansão em x e o lema de alinhamento da primeira seção dão b(x,r)=σ(x)Cʲr+b₀(r)+ℓ₀(x)r, com ℓ₀ linear. Sob a rotação de três posições de w, (u,v) vai a (u,v+u). Ela envia x a x+r em z. Por isso a diferença entre os vetores polares em u nas duas linhas é 111×a(r)=σ(r)(r+Cʲr). A expressão para b dá ℓ₀(r)=σ(r) em r≠0. Logo

    b(x,r) = σ(x)(Cʲr+r) + b₀(r).

Em r=0, a invariância por κ e π|_Φ=0 dão B_(x,0)x=0. Como b(x,0)=b₀(0), segue b₀(0)=0.

Em V₂, u tem paridade par e σ(v)=u₁, onde u₁ é a coordenada de índice 1. A polar se anula em pares em que um dos vetores tem u=0, pois nesse caso σ(v)=0. Assim ela se reduz a uma forma alternada no plano de u de paridade par. Nas direções de u dadas por 3 e 5, em máscaras de bits, seu valor é

    d(r) = σ(b₀(r)) + a(r)·5.

Com efeito, 3×5=111, 3 tem coordenada de índice 1 igual a um, e 5 a tem igual a zero. A rotação preserva V₂ e induz uma rotação no plano de u de paridade par. Sua ação na forma alternada desse plano é trivial, pois o plano tem dimensão dois sobre F₂. Portanto d é cíclica em r. Já d(0)=0. Para r de peso dois, b₀(r) é paralelo a r e a(r) é paralelo a 111, pois tanto r como Cʲr são pares. Segue d(r)=0. O grau no máximo dois de d implica que sua soma sobre todos os r é zero, de modo que seu valor de peso um coincide com d(111). Assim d(r)=d(111)σ(r). Em r=111, b₀(r) é múltiplo de 111 e a(r)=0, então d(111)=0 equivale a b₀(111)=0.

**Conferência.** Para cada um dos dois Q, a comparação com as assinaturas completas de V₂ sobre um levantamento e 45 direções afins reproduziu a identidade. Nos 24 representantes C₂ preparados, a condição exclui a escolha de polar zero nas 24 órbitas. O critério de sinais na própria fibra de rótulo 7 ainda deixa as 24 órbitas com alguma fase compatível. Os outros rótulos são necessários.
