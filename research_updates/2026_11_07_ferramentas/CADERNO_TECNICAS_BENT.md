# Técnicas para investigar funções bent com simetria de rotação

## Objetivo e estado das demonstrações

Este caderno reúne ferramentas reutilizáveis para funções booleanas, espectros de Walsh, reduções periódicas e funções bent com simetria de rotação. Cada técnica vem acompanhada de hipóteses, argumento central, aplicação e limite. O objetivo é permitir que uma prova nova seja montada com etapas verificáveis, sem transportar uma conclusão além do domínio em que foi demonstrada.

Edição de 10 de novembro de 2026. O nível de revisão varia por ferramenta. As atualizações identificam as provas, os certificados computacionais e os argumentos ainda em auditoria. A prioridade das adaptações e combinações próprias permanece aberta. A auditoria por modelos e a revisão humana por pares são etapas distintas.

**Estado em 07/11.** p=17, Q1 geral e a conjectura geral continuam abertos. As atualizações de 07/11 abaixo prevalecem sobre estados históricos de casos abertos. O fechamento de produtos de duas quadráticas com resto cúbico é uma prova candidata sob I6; não deve ser usado como resultado estabelecido antes da auditoria. Não se aplica a uma quártica arbitrária nem somente às condições de peso e pico.

**Atualização de 10/11.** Para as quárticas RS bent em 12 variáveis, as técnicas 33 a 40 ao fim do caderno prevalecem sobre os registros históricos desta frente. Entre as funções exteriores à família afim na diagonal antipodal inteira, 10.485.760 são afins nas classes do hiperplano antipodal invariante de dimensão cinco. O tipo de peso 24 recebeu classificação algébrica com duas comparações finitas de coeficientes e auditoria adversarial por Astra. A exclusão dos demais tipos usa paridade e contagem exata, com recontagem independente comunicada pelo Fable. As 8.730.624 quárticas exteriores restantes ainda aguardam classificação algébrica. O Fable confirmou o critério local para fibras de 16 pontos e reproduziu a contagem de 2.326.528 funções exclusivas de V₂.

Usamos três indicações de origem: **literatura**, para ferramentas clássicas com fonte identificada; **adaptação**, para sua especialização e combinação nesta pesquisa; **argumento local**, para uma dedução escrita aqui e auditada, ainda sem prioridade estabelecida. Os créditos entre Argon, Claude, Codex, Astra e os agentes de auditoria são preservados na seção final.

## Notação comum

Trabalhamos em F₂ⁿ, com soma de coordenadas módulo 2. Para f:F₂ⁿ→F₂, defina s_f(x)=(-1)^f(x) e

    W_f(b) = Σ_x s_f(x)(-1)^(b·x).

Uma função é bent se n é par e |W_f(b)|=2^(n/2) para todo b. RS significa invariância pela rotação cíclica de uma posição. Para n=2m, E={(u,u):u∈F₂ᵐ} é o espaço fixo da meia-volta. Um flat é um subespaço afim; sua codimensão deve sempre ser indicada em relação ao espaço ambiente que está sendo usado.

Escrevemos E_A para média uniforme em A e wt_A(f)=|{x∈A:f(x)=1}|/|A|. A soma e a média não são intercambiáveis sem o fator |A|. Na frente quártica modular, n=4m, M=2^m e k=W_g/M. Os inteiros negativos têm bits definidos por seus resíduos módulo 2^j, não pela representação textual com sinal.

## Mapa de escolha do método

| Situação | Primeira ferramenta | Verificação essencial |
|---|---|---|
| Testar uma função explícita | Walsh completo e ANF | Todas as frequências e grau real |
| Dimensão grande com fator primo ímpar | Redução periódica | A restrição não herda bentness automaticamente |
| Congruência modular e grau baixo | Divisibilidade e bits | Classes de sinal em todas as frequências |
| Bit residual de peso pequeno | Reed–Muller e classificação | Peso estrito e grau no domínio certo |
| Vários bits num mesmo flat | Pesos generalizados | Independência linear e suporte conjunto |
| Precisar de posto quadrático | Fourier no flat | Codimensão total e posto após restrição |
| Cauda de valores grandes | Orçamento ponderado | Controlar energia, não só cardinalidade |
| Sexticas e fibras | Convolução das fibras | Parseval escalar é apenas uma condição |
| Alegação de inexistência por busca | Certificado de cobertura | Família enumerada e equivalências provadas |

## Técnica 1 Walsh Parseval e derivadas

**Origem:** literatura; referência geral [R1]. Para qualquer função booleana,

    Σ_b W_f(b)^2 = 2^(2n),
    s_f(x) = 2^(-n) Σ_b W_f(b)(-1)^(b·x).

As fórmulas decorrem da ortogonalidade dos caracteres: a soma de (-1)^(a·x) é 2^n quando a=0 e zero caso contrário. Uma atribuição artificial de valores a W pode satisfazer Parseval e continuar sem representar uma função booleana: é preciso que toda inversão seja +1 ou -1.

A autocorrelação r_f(a)=Σ_x(-1)^(f(x)+f(x+a)) é a transformada inversa de W_f², com fator 2^(-n). Consequentemente, f é bent se e somente se cada derivada D_a f(x)=f(x+a)+f(x), a≠0, é balanceada. Esse critério é particularmente útil em grau três, pois suas derivadas são quadráticas.

**Uso verificado:** controles negativos, testes exatos e auditoria de espectros artificiais. **Limite:** uma lista de módulos ou a média de W² não certifica a inversão inteira.

## Técnica 2 Congruência por órbitas e restrição periódica

**Origem:** mecanismo clássico de ação de grupos; adaptação às cadeias desta pesquisa. Considere f bent RS em n=sp coordenadas, com p primo ímpar, e restrinja f às palavras que repetem p vezes um bloco de comprimento s. Chame a restrição de g. Na soma de Walsh de f em uma frequência igualmente periódica, a ação da rotação de s posições tem órbitas de tamanho 1 ou p. Os termos são constantes em cada órbita; as órbitas não fixas somam múltiplos de p. Nos pontos fixos, o produto escalar repetido p vezes coincide com o do bloco, pois p é ímpar. Assim

    W_g(b) ≡ W_f(repetição de b) ≡ ±2^(sp/2) mod p.

Quando s é par, Fermat fornece 2^(sp/2)≡2^(s/2) mod p. A restrição conserva RS e não aumenta grau, mas pode criar termos de graus menores por identificação de variáveis.

**Uso verificado:** cadeia 380→20→4 e condições necessárias para quárticas homogêneas. **Limite:** para concluir que g é bent, é preciso um teorema adicional de rigidez espectral. A própria congruência não basta. Para fatores compostos, justificar a cadeia etapa a etapa.

## Técnica 3 Cancelamento por meia volta

**Origem:** argumento elementar de órbitas; reutilizado nas notas e nas construções da literatura. Se f é RS, seus coeficientes ANF são constantes nas órbitas de suportes. Ao restringir x=(u,u), os suportes S e S+m produzem o mesmo monômio e se cancelam quando são distintos. Só sobrevivem suportes fixos pela meia-volta; esses são uniões de pares antipodais.

Portanto uma função RS de grau no máximo d restringe-se a E com grau no máximo floor(d/2). Uma função homogênea RS de grau ímpar zera em E, porque nenhum suporte ímpar é fixo pela meia-volta. Para grau até quatro, a restrição a E é quadrática.

**Uso verificado:** exclusão cúbica e inspeção de famílias de Su–Tang e Carlet–Gao–Liu. **Limite:** grau reduzido na restrição não torna essa restrição bent. Tampouco fixa a energia espectral sobre E.

## Técnica 4 Divisibilidade espectral pelo grau

**Origem:** literatura de Ax e McEliece; apresentação e refinamentos em Hou [R2]. Para função de grau no máximo d, com 1≤d≤n, as somas de sinais são divisíveis por 2^ceil(n/d). Somar uma forma linear não aumenta o grau além de d, de modo que a divisibilidade também se aplica a cada W_f(b).

Na frente n=4m e grau≤4, isso dá M=2^m dividindo W. Assim k=W/M é uma função inteira. Parseval transforma-se na normalização E k²=M². Uma congruência W≡±M² mod p, com p ímpar, passa a k=Mε+pt, ε∈{-1,1}, t inteiro, porque M é invertível módulo p.

**Uso verificado:** todos os ramos quárticos modulares. **Limite:** a potência depende do número efetivo de variáveis da soma. Depois de restringir a um subespaço ou a um quociente, recalcular a dimensão antes de usar a divisibilidade.

## Técnica 5 Filtração dos coeficientes inteiros e graus dos bits

**Origem:** adaptação de divisibilidade espectral e inversão de Möbius; prova explícita nas notas locais [L1]. Expanda k(b) como polinômio multilinear inteiro em coordenadas booleanas b. Seu coeficiente no monômio de suporte S, |S|=j≥1, é

    c_S = (-2)^j/M · Σ_(x_i=1 para i∈S) (-1)^g(x).

Fixar j coordenadas deixa 4m-j variáveis. A Técnica 4 implica

    2^ceil(3j/4) divide c_S.

Daí, extraindo bits sucessivamente e controlando os carregamentos, obtém-se: β₀ constante, β₁ afim, deg β₂≤2 e deg β₃≤4. A filtração sobrevive a mudanças afins: um termo numérico de grau a que contribui a grau j ganha divisibilidade adicional de 2^max(0,j-a).

Em flats onde os bits anteriores se tornam constantes ou expressões da quadrática β₂, o passo seguinte ganha força. Nas relações usadas para p=17 e p=19, deg E≤6 em flats contidos em D=0 e deg H≤8 em flats contidos em D=E=0.

**Limite essencial:** não transportar esses limites de E e H ao espaço todo. O grau só foi demonstrado depois das restrições especificadas.

## Técnica 6 Distância mínima e classificação dos primeiros pesos

**Origem:** literatura de Reed–Muller, Kasami–Tokura e KTA [R3, R4]. Se q é booleana não nula, tem grau≤r em N≥r variáveis, então wt(q)≥2^(-r). Na igualdade, seu suporte é um flat de codimensão r. A prova da distância mínima pode ser feita por indução, decompondo q em uma variável.

Para pesos menores que duas vezes a distância mínima, a classificação de Kasami–Tokura fornece formas afins precisas. Aqui usamos, em especial, os pesos 2^(-r), (3/2)2^(-r) e o próximo limiar (7/4)2^(-r). Não inferir que todo polinômio de peso baixo seja um único flat. As formas de segundo peso relevantes têm fator afim e, assim, um hiperplano de zeros.

**Uso verificado:** converter orçamento de energia em informação estrutural sobre D, E ou H. A prova elementar alternativa do lema abaixo de 1,75d foi fornecida por Claude e auditada; o enunciado é clássico, não resultado novo desta pesquisa.

**Limite:** o domínio pode ser S₁ ou um flat dentro dele, e r deve valer nesse domínio. Uma tabela só em poucas variáveis não autoriza extrapolação automática.

## Técnica 7 Flat de zeros de codimensão dois

**Origem:** KTA 1976, Teorema 1 parte 1 [R4]; enunciado original recebido e reprodução em Klein–Storme [R5]. Para grau≤r, r≥4 e N≥r, se

    wt(q) < (5/2)·2^(-r),

então q zera em algum flat afim de codimensão dois. Em grau quatro o limiar é 5/32; em grau seis, 5/128; em grau oito, 5/512. A desigualdade é estrita. O original informa que a prova do teorema foi omitida; sua referência pode ser usada como resultado publicado, mas não como uma demonstração reproduzida neste caderno.

Se q zera em x=y=0, sua expansão pode ser escrita como q=xA+yB+xyC, com graus de A,B,C no máximo r-1,r-1,r-2 e sem dependência em x,y. Isso organiza as três fatias restantes.

**Uso verificado:** caso p=19 e ramo condicional de posto alto para p=17. **Limite:** em p=17, wt(D)≤5/24 é maior que 5/32; KTA não garante o primeiro flat em toda a faixa residual.

## Técnica 8 Pesos generalizados e suporte conjunto

**Origem:** Heijnen–Pellikaan, com descrição simplificada por Beelen [R6]. O k-ésimo peso generalizado de um código é o menor tamanho da união de suportes de um subcódigo de dimensão k. Ele controla zeros comuns de polinômios linearmente independentes, não o segundo ou terceiro peso de uma única palavra.

Nos parâmetros binários aqui usados, os primeiros quatro valores normalizados são:

| Código no mesmo domínio | d₁ | d₂ | d₃ | d₄ |
|---|---:|---:|---:|---:|
| RM(4,N), N=19 ou 20 | 1/16 | 3/32 | 7/64 | 15/128 |
| RM(6,N), N=19 ou 20 | 1/64 | 3/128 | 7/256 | 15/512 |

Por exemplo, se dois polinômios não nulos de RM(6,N) têm união de suportes menor que 3/128 do domínio, eles são dependentes; sobre F₂, são iguais. Isso transforma uma futura cota de suporte conjunto em identidade algébrica.

**Estado da aplicação:** ferramenta válida da literatura, ainda sem fechamento adicional de p=17. Antes de aplicá-la a dois bits, demonstrar que ambos têm grau controlado no mesmo flat e que a união dos suportes tem a cota necessária. Não aplicar diretamente a D global e E apenas restrito.

## Técnica 9 Correlação quadrática e posto após restrição

**Origem:** Fourier de formas quadráticas, literatura; especialização modular nas notas [L1, L2]. Uma fase quadrática (-1)^q com polar de posto 2h tem norma l¹ de Fourier normalizado igual a 2^h. Por inversão de Walsh, os coeficientes normalizados de Fourier de W são sinais ±1 no espaço todo; após restringir a um flat de codimensão total c, têm módulo no máximo 2^c.

Consequentemente, para k=W/M,

    |E_F [(-1)^q k]| ≤ 2^(c+h)/M.

Uma cota inferior estrita maior que 2^(c+2)/M força h≥3, isto é, posto pelo menos seis. A restrição de uma forma bilinear a codimensão r reduz o posto em no máximo 2r: eliminar uma direção afeta no máximo uma linha e uma coluna da matriz polar.

**Uso verificado:** selecionar um subespaço simplético de dimensão seis dentro do flat. **Limite:** usar posto já restrito. Um posto alto antes de dois cortes não é automaticamente alto depois deles.

## Técnica 10 Poisson em uma classe afim

**Origem:** soma de caracteres, literatura; adaptação nas contradições locais. Para C=b₀+U, dim U=t,

    Σ_(b∈C) W_g(b) = 2^t Σ_(x∈U⊥) (-1)^(g(x)+b₀·x).

A prova é somar os caracteres de U: eles se anulam fora de U⊥. Em n=20, grau≤4 e t=6, a soma da direita é múltipla de 2^6·2^ceil(14/4)=1024.

Se os valores pequenos na classe, junto de uma fase quadrática não degenerada, exigem soma igual a 512 módulo1024, surge contradição. Logo cada classe de 64 pontos contém um valor excepcional. Em p=17, na região onde D=E=H=0, esse ponto tem k²-4≥1044480. Como os demais têm k²-4≥0, a média da classe é pelo menos 16320.

**Limite:** é necessário que toda a classe esteja na região em que as congruências usadas valem. Um único ponto nela não basta. Não presumir divisibilidade adicional sem recalcular a dimensão de U⊥.

## Técnica 11 Orçamento ponderado de caudas

**Origem:** argumento local de Codex, desenvolvido a partir das normalizações de Argon e Claude; auditado nas notas [L3, L4]. Para o ramo ímpar M=32,p=17, normalize por um caráter afim para ter

    X=32ε+17r,  r≡1 mod4,  E X=±1/32.

Se r≡1+4Q+8D mod16, ponha e=(X-17)²-1024. Em Q=1, escreva Δ=e-272≥0. Parseval e o primeiro momento dão

    E[1_(Q=1)Δ] + E[1_(Q=0)e] ≤ 4641/16 - 272·wt(Q).

Nas células adequadas, valem cotas pontuais como X≥53-Δ/136 quando D=0, e -19-Δ/136≤X≤-19+Δ/136 quando D=1. A energia controla a contribuição total de valores grandes, inclusive valores arbitrariamente distantes.

**Por que funciona:** as cotas vêm do espaçamento aritmético permitido para X e de produtos de fatores com sinal conhecido. Não se impõe um teto artificial aos valores da cauda.

**Uso verificado:** exclusões dos pesos 1/4 e 3/8 de Q para p=17. **Erro evitado:** pouca probabilidade de uma cauda não limita sua média inferior se seus valores podem crescer em módulo.

## Técnica 12 Cobertura uniforme por hiperplanos e flats

**Origem:** ideia de cobertura de Argon; contagem exata e árvore reconstruídas por Claude; auditorias independentes [L2]. Um flat Z de codimensão r é evitado por 2^r-1 hiperplanos. Cada ponto fora de Z pertence a 2^(r-1) deles. Para uma energia não negativa, existe um desses hiperplanos cujo orçamento médio é no máximo

    [2^r/(2^r-1)] · integral normalizada da energia fora de Z.

Esse fator é melhor que escolher um hiperplano arbitrário e pagar fator dois. Para dois produtos quárticos independentes, 15×15=225 cruzamentos de hiperplanos cobrem cada ponto fora dos dois suportes 64 vezes. O fator de orçamento correspondente é 256/225. A interseção dos suportes não é coberta; sua energia não negativa pode ser descartada numa majoração, não subtraída com sinal incorreto.

**Uso verificado:** árvore do ramo par p=17, incluindo 11 folhas com contradição estrita. **Limite:** uma união de flats não é necessariamente disjunta. Provar a multiplicidade de cobertura antes de substituir a família por uma suposta fração efetiva.

## Técnica 13 Células limpas e queda de grau

**Origem:** argumento local de Claude para o peso 3/8, baseado no orçamento anterior; auditado em [L4]. Se Q=x₁x₂+x₃x₄, suas nove células com os dois pares em P={00,01,10} estão em Q=0. Uma restrição não nula de D, grau≤4, numa célula custa ao menos 9792/256=153/4 do orçamento. Se uma célula vizinha por um bit é nula, a restrição não nula tem grau≤3 e o custo dobra para 153/2.

Uma linha de três células nulas força D a ter fator x₁x₂ na expansão restante. No quarto flat, com o par igual a11, a restrição tem grau≤2. As linhas e colunas fornecem até seis flats distintos e disjuntos em Q=1.

O orçamento é 3009/16. A enumeração completa dos 512 padrões de ocupação deixa 46 viáveis; todos fornecem um flat limpo com E_FΔ≤1003/2. As três possibilidades para o peso dos zeros de uma quadrática dão contradições de Fourier. Assim wt(Q)=3/8 é excluído, além de 0 e1/4.

**Limite:** o argumento finito enumera padrões de células, não funções de20 variáveis. Para Q de posto maior, refazer domínio, grafo, multiplicidades e limites de Fourier; os números de nove células não se transportam.

## Técnica 14 Energia correta em um subespaço autodual

**Origem:** identidade clássica; correção explícita desta investigação, reconstituída por Claude [L5]. Para V={(u,u)} em20 coordenadas, V=V⊥. Defina

    S(w)=Σ_(u∈V) (-1)^g(u+(w,0)).

Então

    k((b,b)) = (1/32) Σ_w (-1)^(b·w) S(w),
    Σ_(b∈V) k(b)^2 = Σ_w S(w)^2 = Σ_(s∈V) r_g(s).

Logo E_V k² depende das autocorrelações não triviais em V. Ela não é automaticamente1024. No produto escalar usual, b∈V não indexa os caracteres de u∈V: b·u=0 para todo par. Os caracteres apropriados separam as classes do complemento.

**Uso verificado:** rejeitar a falsa prova de fechamento p=17. **Limite:** essas identidades corrigem a normalização, mas não fornecem por si uma nova cota para a energia restrita.

## Técnica 15 Fibras e autocorrelação completa módulo três

**Origem:** identidade clássica de convolução, organizada e executada nesta retomada [L6]. Para h(u,v), defina h_d(u)=h(u,u+d), A_γ(d)=Σ_u(-1)^(h_d(u)+γ·u) e

    C_γ(t)=Σ_d A_γ(d)A_γ(d+t).

A transformada de C_γ é W_h(γ+δ,δ)². Como1024≡1 mod3, a ausência de zeros módulo3 em toda a fatia equivale a C_γ(t)≡1 na origem e0 nos demais deslocamentos. O teste de Parseval fatiado usa somente C_γ(0).

Somar ψ(d) a cada fibra muda A_γ(d) por um sinal. Isso preserva C_γ(0), mas em geral não preserva C_γ(t) para t≠0. Se ψ é afim, equivale a deslocar o espectro e preserva as posições nulas até essa permutação. Momentos pares globais módulo3 não acrescentam informação ao segundo: a^(2j)=a² emF₃ para todo j≥1.

**Controle verificado:** Tr(X^26691) emF₂²⁰ passa no teste escalar e falha no completo em todas as1023 fatias não nulas; há457560 zeros globais módulo3. Isso prova insuficiência do filtro escalar, não inexistência geral. Bases polinomiais, normais e duais precisam ser distinguidas nas implementações.

## Técnica 16 Derivadas e descida em bloco de Jordan

**Origem:** prova alternativa proposta por Astra e auditada localmente [L7]. O teorema cúbico já constava do trabalho do usuário; não é uma descoberta nova desta retomada. Uma derivada de função de grau≤3 é quadrática. Em um único bloco de Jordan J=I+N sobreF₂, uma quadrática J-invariante e balanceada é a forma linear invariante não nula, mais constante. A análise usa o radical da polar e o fato de os subespaços invariantes serem os prefixos da cadeia de Jordan.

Sob as hipóteses da obstrução cúbica, uma derivada força um termo x₀x_último. A soma de Walsh nessas duas variáveis separa um fator2 e reduz a bentness a fatias em dimensão N-2. O quociente conserva um único bloco e a constância no prefixo médio. Iterar chega à contradição emN=2.

Uma ação de ordem ímpar permite antes reduzir ao bloco de tamanho potência de2 no caso cúbico: a projeção de Reynolds decompõe a forma quadrática das derivadas no espaço fixo e seu complemento. Essa herança de bentness foi demonstrada para grau≤3, não para grau arbitrário.

**Limite:** não aplicar a descida diretamente a quárticas ou séxticas. Suas derivadas deixam de ser quadráticas e o lema do bloco único já não fornece o termo bilinear necessário.

## Técnica 17 Obstrução por código cíclico autoortogonal

**Origem:** argumento local de Codex auditado por Astra [L8]. Seja n=2m e τ a meia-volta. Não existe subespaço W invariante pela rotação, autoortogonal para o produto usual, contendo v com v+τv=1ⁿ.

Identifique vetores a polinômios módulo xⁿ-1. Escreva n=2^sL com L ímpar e r=2^(s-1). A equação (1+x^m)v=1+x+...+x^(n-1) força multiplicidade r-1 de x+1 emv. Já a autoortogonalidade e a invariância exigem v(x)v(x^(-1))≡0 mod xⁿ-1. Esse produto tem multiplicidade2r-2 emx+1, menor que a multiplicidade2r do módulo: contradição.

**Uso:** excluir uma rota de perturbação isotrópica da quadrática antipodal Q₀ quando se deseja constância emE e simetria de rotação. **Limite:** a obstrução afeta essa construção, não todas as funções bent. Os exemplos não homogêneos em60 e70 não são refutados.

## Técnica 18 Construções como controle de prioridade e de hipóteses

**Origem:** literatura de Su–Tang [R7] e Carlet–Gao–Liu [R8]; inspeção das restrições emE na pesquisa [L9]. Antes de anunciar uma construção nova, escreva sua fórmula nas mesmas coordenadas das famílias anteriores e restrinja ambas aE.

Na família geral de Su–Tang examinada, f(x′,x″)=Q₀(x′,x″)+1_A(x′+x″), de modo que f(u,u)=Σu_i+1_A(0), não constante. Na Proposição3.7 de Carlet e colaboradores, a restrição é f₁+f₂; a complementaridade dos suportes espectrais impede que essa soma seja constante. Isso distingue essas famílias examinadas das construções constantes emE.

**Limite:** distinguir famílias não encerra a prioridade do projeto inteiro. Uma substituição formal em traços não preserva bentness sem condições adicionais. Esses artigos não são uma prova de exclusão de todo grau alto.

## Técnica 19 Contagem de incidências com orçamento de energia

**Origem:** argumento local de Codex sobre a normalização e as células de Claude, com duas auditorias independentes [L11]. No peso(Q)=7/16 do ramo ímpar p=17, Q pode ser escrito como soma de três produtos de pares. As36células Q=0 contêm uma grade P³ de27células, P={00,01,10}, com27linhas. Uma célula onde D não zera custa153/16 de energia; uma vizinha vazia força queda de grau e dobra esse custo. O orçamento2737/16 dá custo inteiro c≤17.

Na grade, se n células estão ocupadas e i são interiores, seu custo é c₀=2n−i. Para uma linha com s ocupados e I interiores globais, os oito padrões possíveis dão (s−1)_+≥2I/3. Somando incidências,

    3n−L≥2i,
    k₀=27−L≥27−3c₀/2+i/2≥27−3c/2≥3/2.

Há, portanto, ao menos duas linhas limpas e dois flats-alvo distintos. Em um deles D tem grau≤2 e a energia satisfaz E_FΔ≤10948/27<816. As três possibilidades para a fração de zeros de D contradizem as cotas de Fourier. O caso7/16 fica excluído sem enumerar2³⁶padrões.

**Ideia reutilizável:** um interior custa menos energia, mas reutiliza linhas ocupadas; contar essa compensação garante linhas limpas. **Limite:** o próximo posto exige novos argumentos. No peso15/32, os flats que fixam8bits têm cota de Fourier8, e o pior caso quadrático fornece apenas8 antes de descontar energia; repetir a conta não dá contradição estrita.

## Técnica 20 Fatoração com controle de grau por dimensões de ideais

**Origem:** literatura, Ding–Hodges–Kruglov2010, Corolário7.2 [R10]; aplicação explicitada pela coordenação Codex e conferida em duas revisões [L12]. Trabalhe na álgebra booleana A=F₂[x₁,…,xₙ]/(xᵢ²−xᵢ), filtrada pelo grau da ANF. Para Q_h=Σᵢx₂ᵢ₋₁x₂ᵢ e d<h, a anulação D em Q_h=0 implica D=Q_h R com grauR≤d−2. A anulação em Q_h=1 implica D=(1+Q_h)R com o mesmo limite.

**Argumento:** ponha σ(n,d)=dim A_d e δ(n,d)=Σᵢ(−1)^i σ(n,d−2i). O artigo dá dim(A_d λ)=δ(n,d) quando d<rank(λ)/2. Os postos de Q_h e 1+Q_h são2h; soma de constante não muda o posto na definição dos autores. Assim o núcleo da multiplicação por1+Q_h em A_d tem dimensão σ(n,d)−δ(n,d)=δ(n,d−2), igual à imagem Q_h A_(d−2), já contida nesse núcleo. Igualdade de dimensões fornece o quociente de grau controlado. Variáveis adicionais no radical estão incluídas em n.

**Uso:** cobre grauD≤4 para h≥5, incluindo os casos h=7,…,10 antes dependentes de certificados. **Limite:** esta dedução pelo corolário exige d<h; não a estender à fronteira ou a todos os graus. Há afirmações mais fortes na mineração sob auditoria, que não são incorporadas por esta técnica. Fatoração isolada não fecha p17. O resultado clássico não é atribuído aos modelos.

## Técnica 21 Baixo peso global antes da análise por células

**Origem:** adaptação de Claude, auditada por Terra/Codex [L13], combinando o lema clássico de baixo peso com a energia ponderada. Se grauD≤4, grauQ≤2, use f=D(1+Q), de grau≤6. Seu suporte é Q=0,D=1. Se a energia e é pelo menos9792 nesse suporte e o orçamento é S, então wt(f)≤S/9792. Na faixa wt(f)<3/128 em RM(6,20), f é zero ou indicador de um flat de codimensão6.

Essa estrutura global elimina configurações arbitrárias de células que passam uma contagem combinatória mas não podem vir de D. Para Q_h de posto2h, a projeção T de um eventual flat de dimensão14 nas2h coordenadas teria dimensão entre2h−6 e h; portanto o caso não nulo é impossível para h≥7. Nos casos h=5,6, as classes afins de projeções foram tratadas via Witt. Um flat singular transversal permite restringir D a um indicador de flat de codimensão5 ou6, contradizendo grau≤4.

No caso h=4, não descartar o flat não nulo: existem exemplos algébricos. A auditoria de15/32 o trata explicitamente. **Limite:** o lema de baixo peso exige a faixa estrita e o grau no espaço total; não fornece bentness nem exclui funções de energia maior.

## Técnica 22 Juntar alvos limpos para melhorar a cota de Fourier

**Origem:** argumento de Claude auditado para o peso15/32 [L13]. Duas linhas limpas do mesmo eixo na grade P⁴ dão dois alvos com o par desse eixo igual a11. Sua união é um flat G de codimensão7, pois dois pontos distintos sobre F₂ formam uma reta afim. A anulação de D nas três fatias P={00,01,10}, para ambos os pontos, força fator pelo produto dos dois bits do eixo; o coeficiente tem grau≤2, incluindo a coordenada da reta. Logo D|G é quadrática.

A cota Fourier em G passa de8 para4. Usando disjunção dos alvos e orçamento, obtém-se E_GΔ≤1156/3 no pior caso. As frações possíveis de zeros da quadrática são0,1/4 ou≥3/8, dando respectivamente E_G X≤−97/6, E_B X≥125/3 no flat de zeros B de codimensão9, ou E_G X≥31/6. Contradizem os limites4 ou16 correspondentes. Isso exclui15/32, sem afirmar que a mesma construção feche postos maiores.

**Controle de uso:** recalcular a codimensão total sempre que juntar ou subdividir alvos. No caso h=7, G tem codimensão8 e o subflat com1/4 dos pontos tem codimensão10; os limites são8 e32. O antigo limiar1224 não exclui ali1/4 de zeros. Tampouco714 basta para forçar3/8: uma quadrática pode ter7/16 de zeros. O limiar comum seguro para forçar exatamente3/8 é612; conferir também os outros pesos quadráticos. Não transportar os números do caso h=4.

## Técnica 23 Fases orbitais e pares de linhas sobre F₃

**Origem:** proposta e algoritmo de Argon; reconstruções e auditorias Terra/Codex [L14]. Para h_base(u,v)+ψ(u+v), com ψ RS, há uma fase s_O=(−1)^ψ(O) em cada órbita O da rotação de d=u+v. Em cada fatia, o espectro módulo3 é B_γ s, onde a coluna O é a transformada da contribuição A_γ(d) restrita àquela órbita. Colunas iguais a zero podem ser descartadas nessa fatia, preservando a identificação das fases comuns entre fatias.

Se uma translação de frequências produz valores U+V e U−V, em F₃ ambos são não nulos exatamente quando um de U,V é zero e o outro não. Enumerar blocos de fases separadamente e combinar máscaras complementares de zeros reduz o espaço. Para as fases remanescentes, eliminação exata sobre F₃ enumera todas as coordenadas livres em{1,2}, reconstrói pivôs não nulos e testa as desigualdades complementares. O posto sozinho não decide se existe vetor de suporte completo.

**Aplicação auditada:** famílias baseadas em Tr(X^26691), Tr(X^9765) e Tr(X^33945+X^4929). Na segunda, duas fatias deixam8 configurações; a terceira gera1024 sistemas inconsistentes e exclui todas as extensões. **Limite:** cobre essas famílias, não todas as2^3015 funções do espaço RS séxtico. Um verificador que só testa vetores listados e totais lidos de JSON não demonstra completude; conservar geradores, cobertura e identidades das matrizes.

## Técnica 24 Restrições esparsas como certificados de não bentness

**Origem:** literatura, Meng–Chen–Fu2010 [R11]; inspeção local de hipóteses [L15]. Fixar coordenadas não aumenta o máximo absoluto dos coeficientes de Walsh. Um monômio de grau d≥2 tem máximo2^d−2; variáveis livres multiplicam essa amplitude por uma potência de2; uma soma de monômios em blocos disjuntos tem espectro produto.

Se uma restrição deixa t monômios de grau d em blocos disjuntos e q variáveis livres, sua amplitude máxima é2^q(2^d−2)^t. Se isso excede2^(n/2), a função original de n variáveis não é bent. O artigo prova ainda que uma função homogênea RS de grau>2 com apenas uma órbita de monômios não é bent (Teorema11), e que uma homogênea RS de grau≥3 com maior intervalo cíclico entre índices consecutivos≤n/2 não é bent (Teorema13).

**Limite:** provar a existência da restrição; não presumir que ela ocorre em qualquer soma de órbitas. Os teoremas sobre homogeneidade não se aplicam diretamente aos bits Q,D nem aos controles séxticos não homogêneos. Estes ingredientes são clássicos e devem ser creditados aos autores.

## Resultados consolidados aos quais as técnicas já se aplicam

1. Rigidez quártica para n=4m e módulo ímpar p>2M/3, m≥4, incluindo o caso especial m=4,p=11 pela prova integrada de Claude. Não se exige RS. A prova mais antiga tinha uma condição adicional no caso m=4; usar a versão integrada auditada [L10].
2. Caso M=32,p=19 fechado pelos dois ramos auditados. A consequência380→20→4 exclui pelo menos7/8 dos vetores de coeficientes de quárticas homogêneas RS em380 variáveis. Não decide o1/8 restante.
3. Limiar161/272 derivado e verificado para o ramo par, m≥5. Isso não estabelece automaticamente o teorema com ramo ímpar.
4. p=17 permanece aberto. No ramo ímpar, Q=0 e pesos1/4,3/8,7/16,15/32,31/64,63/128,33/64,65/128 estão excluídos. A fatoração controlada está justificada para h≥5, mas ainda faltam outros pesos, incluindo127/256. No ramo par, restam D sem hiperplano de zeros, com peso em[1/8,5/24], fora das condições adicionais já fechadas.

## Regras para combinar técnicas

Antes de usar um lema, registrar dimensão, domínio, grau, média ou soma, codimensão relativa e normalização de Walsh. Ao passar a um flat, atualizar todos esses dados. Se uma conclusão depende da classificação de Reed–Muller, indicar a faixa estrita de peso e se ela trata uma palavra ou um subcódigo.

Para cada execução, preservar código, parâmetros, equivalências removidas, cobertura e resultado real. Uma família restrita sem sobreviventes não é enumeração global. Separar a construção de valores espectrais da prova de que sua inversão é booleana. Revisões de modelos e concordância numérica auxiliam a prova, mas não estabelecem prioridade ou revisão por pares.

## Próximo problema recomendado ao Claude

Trabalhar a compatibilidade global entre Q e R em h=7, peso127/256, com a fatoração D=QR já justificada pela Técnica20. A missão MISSAO_CLAUDE_OPUS_ALTO_H7_TEORICO.md é complementada por ADENDO_CLAUDE_FATORACAO_A7_LITERATURA.md. Não usar74% ou25,22% como limites demonstrados de incidência: a derivação energética corrigida usa o limiar612 e garante apenas9503/19431≈48,906% de flats com3/8 de zeros, e essa condição sozinha admite contraexemplos geométricos.

## Redução espectral em espaços fixos de grupos ímpares

**Estado:** demonstração algébrica interna e auditoria independente por modelos; revisão externa e prioridade bibliográfica pendentes. Fontes completas e verificadores no projeto de 27 de outubro: `C:/Users/Valer/Documents/Codex/2026-10-27/agu/outputs/reducao_espectral_grupo_impar_grau4_05nov.md` e `auditoria_walsh_independente_05nov.md`.

Seja P um grupo de ordem potência de um primo ímpar p, agindo linearmente em V sobre F₂. Seja f bent e P-invariante, U=Fix(P), s=dim U e g=f restrita a U. Para a em U não nulo, contagem das órbitas dá AC_g(a) ≡ 0 (mod p). Com as convenções de Walsh e autocorrelação deste caderno, W_g(b)² = Σ_a AC_g(a)(−1)^(a·b), logo W_g(b)² ≡ 2^s (mod p) para todo b em U.

Se s≥2 é par e g tem grau no máximo 4, cada coeficiente W_g(b) é divisível por D=2^ceil(s/4). Se p > 2^(1+s/2−ceil(s/4)), então g é bent: dividindo W por D, as congruências implicam que seu módulo é pelo menos 2^(s/2)/D; Parseval força igualdade em todas as frequências. Não se exige que f seja homogênea ou invariante por rotação, e a restrição de grau é apenas para g.

**Refinamento condicional:** se D divide o peso de g, todos os coeficientes Walsh são divisíveis por 2D, e basta p > 2^(s/2−ceil(s/4)). Essa hipótese de peso deve ser verificada separadamente; não é automática. Exemplo: em oito variáveis, g=x₀x₂x₄x₆+x₁x₃x₅x₇ é quártica homogênea RS, tem peso 30 e W_g(0)=196, que não é divisível por 8.

**Caso aberto com apoio computacional:** para s=8, funções RS de grau até 4 e p=5 ou 7, duas implementações relatam que as congruências espectrais implicam bentness, após percorrer 2^21 representantes sem parte afim. A prova algébrica que exclui o caso de peso não divisível por 4 continua aberta. Não confundir esse teste exaustivo com demonstração algébrica para quaisquer dimensões.

**Antecedentes e cautela:** contagem por órbitas, divisibilidade de Walsh, Parseval e matrizes Hadamard modulares são ferramentas clássicas. Veja Kuperberg, https://arxiv.org/abs/1409.0148 , Sun et al., https://doi.org/10.1007/s10623-026-01848-4 , e o cotejo preliminar `levantamento_prioridade_reducao_05nov.md` no projeto de 27 de outubro. Não foi estabelecida novidade do enunciado composto. Atribuição interna: proposta espectral por Astra, auditoria independente por outro agente Astra e verificação computacional em duas implementações; a autoria científica e a prioridade requerem análise própria.

## Referências da literatura

[R1] Claude Carlet. Boolean Functions for Cryptography and Coding Theory. Referência geral para Walsh, derivadas, formas quadráticas e funções bent. PDF do autor: https://www.math.univ-paris13.fr/~carlet/book-fcts-Bool-vect-crypt-codes.pdf .

[R2] Xiang-dong Hou. Polynomials Meeting Ax's Bound. Preprint2015. Teorema2.4 e Definição2.3 fundamentam o refinamento por partições quárticas usado nas notas. https://arxiv.org/abs/1512.04997 . O lema conhecido não deve ser apresentado como invenção desta pesquisa.

[R3] T. Kasami e N. Tokura. On the weight structure of Reed-Muller codes. IEEE Transactions on Information Theory16(6),752–759,1970. https://doi.org/10.1109/TIT.1970.1054545 . Original ainda não obtido; formas utilizadas conferidas por reproduções e pelo artigo posterior dos autores [R4]. kasami1971.pdf recebido é outro artigo, sobre subcódigos de segunda ordem.

[R4] T. Kasami, N. Tokura e S. Azumi. On the weight enumeration of weights less than2.5d of Reed-Muller codes. Information and Control30,380–395,1976. https://doi.org/10.1016/S0019-9958(76)90355-7 . Original recebido e enunciados relevantes conferidos nas pp.381,384–385; a prova do Teorema1 é omitida nele.

[R5] A. Klein e L. Storme. On the non-minimality of the largest weight codewords in the binary Reed-Muller codes. Advances in Mathematics of Communications5(2),333–337,2011. Lema1 reproduz o resultado de flat de zeros. https://doi.org/10.3934/amc.2011.5.333 .

[R6] Peter Beelen. A note on the generalized Hamming weights of Reed–Muller codes. DOI10.1007/s00200-018-0369-8. https://doi.org/10.1007/s00200-018-0369-8 . PDF recebido; definições e Teorema3.1 conferidos. A fórmula lexicográfica anterior é de Heijnen–Pellikaan.

[R7] Sihong Su e Xiaohu Tang. Systematic Constructions of Rotation Symmetric Bent Functions,2-Rotation Symmetric Bent Functions,and Bent Idempotent Functions. IEEE Transactions on Information Theory63(7),4658–4667,2017. https://doi.org/10.1109/TIT.2016.2621751 . Versão aceita recebida e família do Teorema1 examinada.

[R8] Claude Carlet, Guangpu Gao e Wenfen Liu. A secondary construction and a transformation on rotation symmetric functions,and their action on bent and semi-bent functions. Journal of Combinatorial Theory A127,161–175,2014. https://doi.org/10.1016/j.jcta.2014.05.008 . PDF recebido; Proposição3.7 e construções associadas examinadas.

[R9] Shalom Eliahou e Michel Kervaire. A survey on modular Hadamard matrices. Discrete Mathematics302,85–106,2005. https://doi.org/10.1016/j.disc.2005.02.021 . PDF recebido. Fornece contexto modular; matrizes Hadamard arbitrárias não trazem automaticamente o grau e a estrutura de uma função booleana do problema.

[R10] Jintai Ding, Timothy J. Hodges e Victoria Kruglov. Growth of the Ideal Generated by a Quadratic Boolean Function. PQCrypto2010, LNCS6061,13–27. Definição4.1, Teorema4.2 e Corolário7.2 conferidos. https://archive.ymsc.tsinghua.edu.cn/pacm_download/672/12626-dingjt-c33.pdf .

[R11] Qiang Meng, Lusheng Chen e Fang-Wei Fu. On homogeneous rotation symmetric bent functions. Discrete Applied Mathematics158(2010),1111–1117. Proposição7 e Teoremas11/13 examinados. https://doi.org/10.1016/j.dam.2010.02.009 . PDF local recebido.

## Índice das provas e auditorias locais

Todos os nomes abaixo pertencem à pasta outputs deste projeto. As notas integrais são as fontes das demonstrações específicas, constantes e verificadores; este caderno é sua organização técnica.

[L1] GENERALIZACAO_LIMIAR_DOIS_TERCOS.md; AUDITORIA_TODOS_MODULOS_IMPARES.md; ARGON_P19_PAR_TRANSCRICAO_PARA_AUDITORIA.md; AUDITORIA_ARGON_P19_PAR.md.

[L2] claude_p17_reparo_recebido/NOTA_REPARO_P17_V1.md; AUDITORIA_CLAUDE_P17_PAR.md; CRITERIO_PARAMETRICO_RAMO_PAR_RETOMADA.md.

[L3] REPARO_ORCAMENTO_CAUDA_P19_CODEX.md; RAMO_IMPAR_PARAMETRICO_RETOMADA.md; claude_p19_impar_recebido/NOTA_RAMO_IMPAR_M32_P19.md.

[L4] AUDITORIA_CLAUDE_P17_IMPAR_3_8.md; BALANCO_REPARO_CLAUDE_P17.md.

[L5] AUDITORIA_ARGON_P17_ROTACAO_RETOMADA.md; identidades corrigidas na nota de Claude [L2].

[L6] AUTOCORRELACAO_FATIADA_SEXTICA_RETOMADA.md; AUDITORIA_AUTOCORRELACAO_SEXTICA_RETOMADA.md; verifica_autocorrelacao_fatias_sexticas.py; certificado_autocorrelacao_fatias_sexticas.json.

[L7] AUDITORIA_CUBICA_UNIVERSAL.md. Atenção ao histórico de prioridade: o teorema cúbico já estava no Antipodal necessity do usuário, Figshare34165260v3; a descida de Jordan é prova alternativa.

[L8] obstrucao_perturbacao_isotropica.md; verificar_obstrucao_ciclica.py.

[L9] RELEVANCIA_SU_CARLET_PDFS_04NOV.md; RELEVANCIA_REED_MULLER_PDFS_04NOV.md.

[L10] claude_adendo_p11_recebido/PROVA_INTEGRADA_2_3_SEM_KT.md; AUDITORIA_CLAUDE_PROVA_INTEGRADA_2_3.md; AVANCO_380_REDUCAO_QUARTICA.md; AUDITORIA_REDUCAO_380.md.

[L11] TECNICA_CONTAGEM_ENERGIA_P17_7_16.md; AUDITORIA_CONTAGEM_GRADE_P17_7_16.md; VERIFICACAO_CONTAGEM_GRADE_P17_7_16.md.

[L12] FATORACAO_QUADRATICA_VIA_DING_HODGES_KRUGLOV.md; AUDITORIA_FATORACAO_QUADRATICA_DHK.md.

[L13] BALANCO_CINCO_PESOS_P17_AUDITADOS.md; AUDITORIA_CLAUDE_PESO15_32.md; AUDITORIA_CLAUDE_PESOS_H5_H6.md.

[L14] AUDITORIA_GAUGE_SEXTICO.md; BALANCO_CERTIFICACAO_SEXTICAS_H1_H2.md; AUDITORIA_ANTIGRAVITY_H1_H2_ETAPAS1_2.md; AUDITORIA_ANTIGRAVITY_H1_H2_ETAPAS3_4.md.

[L15] RELEVANCIA_MENG2010_E_HAMMING_CM.md.

## Atribuições das contribuições da investigação

**Argon:** fases orbitais e algoritmos de pares para as famílias séxticas auditadas; estrutura inicial do ramo par modular, cascatas de bits e ideias de cobertura; propostas na frente séxtica. Tentativas inválidas de fechamento não são incorporadas como teoremas.

**Claude:** cinco exclusões adicionais de pesos no ramo ímpar p17, baixo peso global e junção de alvos; reconstrução do ramo ímpar p19; prova integrada do limiar2/3 incluindo p11; prova alternativa de um lema clássico de baixo peso; árvore parcial p17 e exclusão de peso3/8.

**Codex e agentes Terra:** coordenação e auditorias, correções de sinais e de orçamento de cauda, parametrizações, consequências periódicas, correção da energia autodual, certificado completo de autocorrelação e verificadores independentes.

**Astra:** descida de Jordan como prova alternativa do teorema cúbico e auditoria da obstrução isotrópica; outras construções do projeto mantêm seus créditos nas notas específicas.

**Autores da literatura:** divisibilidade, Fourier, Poisson, Reed–Muller, classificações, pesos generalizados e construções citadas. Não se atribuem aos modelos esses resultados clássicos. Nenhuma reivindicação de novidade ou autoria científica é resolvida por esta organização.

## Ferramenta adicional — Paridade de coberturas em codimensão dois

Para uma quártica homogênea em n=4k, k≥2, restrinja duas coordenadas a zero. O peso restrito módulo 2^k é 2^(k−1) vezes a paridade das coberturas das 4k−2 coordenadas por k monômios distintos presentes. A expansão inteira da XOR prova a identidade. Para bent o peso é múltiplo de 2^(2k−2) por ortogonalidade de Walsh, logo a paridade é zero. A condição tem grau no máximo k nos coeficientes de órbita. Em n=12 exclui os quatro candidatos que passam em W(0), W(1), W(9). Em n=16 dá uma equação quártica, com controle explícito de não trivialidade na classe ambiente. Prova, código e limites em COBERTURAS_QUARTICAS_H12_H16.md.

O mesmo argumento vale em dimensões de restrição m=4r ou 4r−1, com paridade de coberturas por r monômios. Quando m−n/2≥r, bent força paridade zero. Em H16, r=3 com m=11 ou 12 dá filtros cúbicos, já testados como não triviais. Em m=12, cada cobertura é uma partição em três suportes quárticos disjuntos.

**Medição incremental em H16.** As cúbicas já apareciam em T88, na frente U38. Das 130 máscaras da validação que passaram nas oito combinações de T96, três restrições fixadas a partir de uma amostra anterior eliminaram 109. As 389 condições eliminaram as 130. Resultado amostral e reproduzível em MEDICAO_CUBICAS_H16.md.

**Controle exato em H16.** As 389 cúbicas são linearmente independentes como polinômios nos coeficientes de órbita. A órbita de representante 1285 passa nas 389, mas tem peso 696 no suporte 0x3f3f de dimensão 12, violando a divisibilidade por 16 exigida de bent. O bit seguinte acrescenta informação na classe ambiente. A dependência após C7 ainda precisa de análise. Ver MEDICAO_CUBICAS_H16.md.

**Cota certificada em U38.** Adicionar a combinação 15 de T88 às oito de T96 reduz a cota global de 2011309/34359738368 para 18729135/549755813888. A média dos caracteres usa pesos exatos de C7 e cotas de viés pelo posto polar em U38. Dois métodos de pivoteamento concordam e os histogramas antigos foram reproduzidos. Ver COTA_U38_NOVE_CONDICOES.md.

**Contagem exata por caracteres com sinal em U38.** Eliminar um par com termo uv transforma a soma dos sinais de uv+uA+vB+C em 2(-1)^(C+AB). O radical restante decide se a soma é zero. A média dos caracteres fornece a contagem exata das soluções no coset. O piloto em dois cosets C7 confirma a perda da cota por posto e preserva os limites de extensão global. Ver PILOTO_U38_SINAL.md.

**Limite da compressão pelas matrizes em U38.** Dois cosets C7 com a mesma polar para as doze combinações têm contagens diferentes sob nove condições. Para o caráter 6, uma direção do radical comum dá derivadas 1 e 0 nos dois cosets, e as somas são 0 e +2^21. A parte linear no radical é o dado adicional para detectar os zeros. Ver U38_MESMA_POLAR_SINAL.md.

**Redução afim por estado.** Em cada estado ponderado de U38, pelo menos duas combinações das 26 perdem a polar. Resolva as equações afins antes de somar caracteres das combinações quadráticas restantes. Um estado do ramo 0 tem 25 relações afins e produziu cinco cosets inteiramente excluídos entre nove examinados. A cota global por doze combinações é 97575713/8796093022208. Ver COTA_U38_DOZE_E_REDUCAO_AFIM.md.

**Contagem exata do estado zero.** No estado zero de C7, a substituição das leis em 95 variáveis livres deixa só três das 26 combinações não nulas. A soma de duas força c57=0 e a terceira é múltipla de c57. A quadrática restante dá densidade exata 3/8 no estado. Substituir a cota local 3/4 por 3/8 melhora a cota global para 96002849/8796093022208. Ver COTA_U38_DOZE_E_REDUCAO_AFIM.md.

**Obstrução a inversões afins na base Q1.** Projetar o flat sobre as coordenadas de B permite controlar o peso por postos polares nas fibras em A e na projeção. Uma única inversão em flat de codimensão até quatro com fibras próprias perde pelo menos 13312 de peso. Para fibras completas, o pico 32768 não muda quando o peso se mantém na faixa. Ver Q1_OBSTRUCAO_FLAT_MISTO.md.

**Estrutura das derivadas em Q1.** A cota de pico controla a variância da autocorrelação. Mais de 99,15% das direções têm viés de derivada ≥7/40. A soma desse conjunto consigo mesmo é todo o espaço, o que evita a perda de codimensão na adaptação do Lema 4.2 de Haramaty–Shpilka. Ver HARAMATY_SHPILKA_Q1.md.

**Redução do viés no radical cúbico.** Separar a polar quadrática sobre o radical da parte cúbica dá um fator 2^(-s-t) no viés, com 2s o posto polar interno e t a codimensão das equações afins induzidas pelo bloco radical. Para as derivadas boas de Q1, s+t≤2. O catálogo de cúbicas em dez variáveis só entra quando a dimensão efetiva foi reduzida a dez. Ver PDFS_CUBICAS_REDUCAO_VIES_Q1.md.

**Filtro de posto para uma forma cúbica.** Se T é a polarização trilinear de P e M_b=T(b,·,·), então bias(P)^4≤E_b 2^(-rank M_b). O lado direito independe dos termos de grau até dois. Pode eliminar representantes do catálogo cúbico antes de testar correções quadráticas. Ver POSTOS_ALTERNADOS_TENSORES_Q1.md.

**Obstrução por variância discreta em Q1.** Se todos os cosets de uma direção têm restrições quadráticas, seus vieses pertencem a uma lista discreta. Combinar o intervalo vazio entre 1/4 e 1/2 com a variância por Walsh e a granularidade de 256 cosets exclui uma direção comum de codimensão até oito. Prova em Q1_OBSTRUCAO_FIBRAS_QUADRATICAS.md.

**Agrupamento por multiplicadores de coordenadas.** A permutação i→ai mod n, com a invertível, normaliza a rotação, preserva grau, peso e o multiconjunto de Walsh. Na busca esparsa H16, os 58 sobreviventes cúbicos formam 20 órbitas completas sob essa ação. Os 15 que passam também módulo 16 formam cinco órbitas. A completude aqui é verificada nos conjuntos arquivados. O cálculo não prova que todo filtro histórico seja invariante separadamente. Código h16_orbitas_multiplicadores.py e relatório H16_ORBITAS_MULTIPLICADORES.json.


**Cota por flats disjuntos.** Fatore a quadratica residual apos as equacoes lineares. Em cada flat, uma testemunha de que uma cubica de cobertura e nao nula exclui ao menos 1/8 do flat pela distancia minima de Reed-Muller. No estado zero de H16, o metodo baixa a cota de 3/8 para 21/64. Ver U38_ZERO_COTA_CHARTS.md.


H16: posto >=359 dos filtros em cada flat do estado zero, certificado por avaliações. Pesos generalizados de Reed–Muller dão cota local 1963295531054157779722829825/9903520314283042199192993792. Ver U38_ZERO_PESOS_GENERALIZADOS.md e u38_zero_rank_avaliacoes.py.


p17: nova prova exclui Q balanceada de posto polar 2..18 sob normalização ímpar herdada. Provas P17_BALANCEADA_POSTOS_2_A_14.md e P17_BALANCEADA_POSTOS_16_E_18.md. Posto zero e ramo par abertos. Aguardam auditoria independente. P17_RASCUNHO_POSTOS_ALTOS.md preserva extensão não balanceada em revisão.

Anuladores de quadráticas: prova por contração e levantamento na filtração, incluindo termo radical balanceado. ANULADORES_QUADRICAS_FILTRACAO.md e verificador 90 perfis/570 dimensões. Caso não degenerado consta da literatura DHK. Q1: AUDITORIA_Q1_PRODUTO_EM_FATIA.md e Q1_TRES_BLOCOS_CORRECAO_CUBICA.md.

H16: U38_ZERO_FOOTPRINT.json e U38_GLOBAL_FIBRAS94.json. Cota local 9,28% no estado zero; 512 caracteres recalculados nas fibras ampliadas, cota global 8,059691524e-6, ganho 27,34% sobre doze condições. Os histogramas estreitos foram comparados com o certificado anterior. Restam caracteres e a decisão de H16.
Q1: no perfil beta_F=31/64, densidade ótima 15/64 para o Pfaffiano de posto 10 e Jensen em dois grupos elevam o limiar de variância de 0,0078 a aproximadamente 0,01221386. Mantém a hipótese de fibras quadráticas. Ver Q1_FIBRAS_DENSIDADE_VARIANCIA.md.

Q1, fatia real do Opus: a correção cúbica exige quatro formas independentes no radical e pelo menos 55.005 inversões. Exclusão de todos os apoios de até 14 coordenadas em torno de E*=A(B+1+x11), com 109 certificados inteiros de tamanho 14 reexecutados. Ver Q1_CORRECOES_RADICAL_DIM2.md, Q1_DISTANCIA_COLAGEM.md e Q1_COLAGEM_SUPORTES_CERTIFICADOS.md. Força 1, posto 4: redução ao espaço polar fixo de dimensão quatro em Q1_FORCA1_POSTO4_REDUCAO.md. Posto 6: margem de variância auditada e ampliada.

## Atualização 07/11 — Reter a origem espectral e anular bits por orçamento

**Técnica:** em vez de procurar livremente D por peso/pico, conservar X=W_f/32. O orçamento global de ineficiência, combinado ao grau booleano do próximo bit (deduzido pelo levantamento inteiro e inversão de Möbius), pode anular esse bit por distância mínima Reed–Muller. No caso Q=1, Astra deduz X≡53−8D mod64 e exclui flats cúbicos de codimensão até5. A coordenação revisou a prova e conferiu constantes e pequenos complexos exteriores; as hipóteses globais e a redução de origem precisam permanecer explícitas. Ver ASTRA_FRONTEIRA_E_REDUCAO_07NOV.md e AUDITORIA_COORDENACAO_ASTRA_Q1_07NOV.md. Sem revisão humana nem prioridade estabelecida; não é teorema para Q1 definido apenas por peso/pico.

**Técnica complementar no ramo par:** procurar um flat D=0 com orçamento B<663. Distâncias mínimas forçam sucessivamente E=H=0 sem construir uma árvore longa. Com posto polar suficiente, U6 e Poisson dão contradição. Para flats de codimensão≤2, o posto suficiente decorre da própria correlação; na faixa wt(D)>67/384, isso remove a hipótese inicial de posto. Com primeira lacuna, B<1989/2 exige no máximo uma restrição adicional e posto inicial correspondente. Derivação nova de Codex, ainda sem auditoria independente: P17_PAR_REFINAMENTO_FLATS_E_BLOCOS_07NOV.md. Não prova existência dos flats exigidos nem fecha o ramo par.

## Técnica 25 — Liftabilidade: distinguir perfil inteiro e condição invariante

**Origem:** reformulação de Opus e correções da coordenação; utiliza levantamento inteiro e somas em flats. Para D booleana de grau até 4, escreva seu levantamento multilinear inteiro como soma dos c_S x_S. Na normalização desta frente, a liftabilidade exige c_S divisível por 4 em grau 6 e por 8 em graus a partir de 7; a divisibilidade por 2 no grau 5 é automática.

I6 significa Walsh divisível por 8 em todos os caracteres não triviais de toda restrição a um flat afim de dimensão 6. Equivale ao perfil completo módulo 4, não ao teste apenas do grau 6 numa base fixa. I7 exige divisibilidade por 16 em todos os caracteres não triviais de todo 7-flat. Nesta normalização, liftabilidade equivale a I7: cortar um 7-flat em dois 6-flats e tomar as meias somas dos caracteres mostra também I7 implica I6.

**Correção a preservar:** anular a contribuição de grau 8 módulo 4 não é anular esse grau módulo 8. Um produto de posto 12 testado tinha 54 violações no grau 6 e 45 no grau 8 módulo 8. A afirmação antiga de que só o nível 6 o derrubava foi retirada. Termos inferiores podem cancelar obstruções: ab(cd+ef) XOR cd tem levantamento inteiro cd+abef−abcd.

**Uso e limite:** antes de procurar D livremente por peso e pico, testar as condições necessárias que vêm do espectro de origem. Não se pode impor essas condições a uma busca cujo enunciado não as contenha. Fontes locais: opus_niveis_revisados_07nov/AUDITORIA_COORDENACAO.md e opus_ponte_revisao_07nov/PARECER_CORRECAO_NIVEIS.md.

## Técnica 26 — Preservar três postos ao restringir a hiperplanos

**Origem:** argumento de Codex, integrante de prova candidata sem auditoria externa. Se A, B e A+B são alternadas de posto pelo menos 10, uma forma de posto 10 mantém esse posto em ker(ell) quando ell não se anula em seu radical. Formas de posto pelo menos 12 perdem no máximo dois postos.

Em dimensão pelo menos 12, cada radical de uma forma de posto 10 tem dimensão pelo menos dois. Os funcionais que se anulam nele ocupam no máximo 1/4 do dual. A união de até três conjuntos ruins ocupa no máximo 3/4. Existe, portanto, um hiperplano que preserva os três postos pelo menos 10; iterar reduz a dimensão 11.

Em dimensão 11, a única obstrução ao passo seguinte são três radicais distintos u, v e u+v. A decomposição simultânea isola um bloco singular L1 de dimensão três e um complemento regular de dimensão oito. Fora desse caso, chega-se a um par regular em dimensão dez.

**Uso e limite:** substitui uma classificação em dimensão arbitrária por dois problemas pequenos. A propriedade usada precisa ser preservada por restrição, como I6. Controles: verifica_reducao_hiperplanos.py, 43 casos; os controles não substituem o argumento de cobertura.

## Técnica 27 — Emparelhar submódulos cíclicos isotrópicos

**Origem:** prova elementar de Codex para esta aplicação, em contexto clássico de pencils alternados; prioridade não pesquisada. Quando A é não degenerada, T=A^(-1)B é auto-adjunta para A e satisfaz A(Tx,x)=0. Todo submódulo cíclico gerado por x é isotrópico: expoentes pares reduzem a A(w,w)=0 e ímpares a B(w,w)=0.

Escolher um segundo gerador y com pareamento antitriangular de diagonal unitária produz um par de submódulos cíclicos não degenerado. Seu complemento ortogonal é estável por T, permitindo indução. A decomposição primária reduz os blocos a potências de polinômios irredutíveis; a não degenerescência de B e A+B exclui os fatores t e t+1.

Na aplicação anterior, há oito representantes regulares em dimensão dez e cinco em dimensão oito, estes acompanhados de L1: treze ao todo. Dois violam o lema de núcleo K usado para absorver o resto cúbico: F4²+L1 e o bloco associado a (t²+t+1)² acompanhado de L1. K não é um lema geral.

**Fonte e estado:** seções de classificação de fechamento_produto_cubico_07nov/TEOREMA.md; controles em verifica_pareamento_ciclico.py e comparação de dois algoritmos para os treze núcleos. Cobertura e pareamento aguardam auditoria matemática independente.

## Técnica 28 — Certificados duais para famílias de sistemas sobre F2

**Origem:** implementação e certificação de Codex. Depois de parametrizar completamente a parte cúbica permitida, uma condição de divisibilidade pode ficar afim nas incógnitas restantes. Uma soma de equações que zera todos os coeficientes das incógnitas e deixa constante 1 certifica insolubilidade. O verificador deve refazer essa identidade, sem precisar confiar no algoritmo que encontrou o certificado.

No caso F4²+L1, foram arquivados 178 certificados distintos, com um certificado atribuído a cada uma das 65.536 escolhas extras. No bloco repetido acompanhado de L1, uma única soma de cinco equações certifica todos os parâmetros. O arquivo comprimido e a associação dos casos fazem parte da entrega; apenas dizer que o sistema foi insolúvel não seria suficiente.

**Controle obrigatório:** a parametrização deve cobrir todos os restos admitidos; o grau do modelo nas incógnitas precisa ser provado; usar controles solúveis e insolúveis. Certificados verificam as identidades finitas, não a cobertura teórica que levou à família. Reprodução: fechamento_produto_cubico_07nov/verificar_tudo.py, Python e NumPy, sem GPU.

## Técnica 29 — Absorver o resto cúbico num produto e localizar o alcance

**Origem:** redução algébrica de Opus, combinada às técnicas 26–28 de Codex. Para D=Q1 Q2 XOR R, com graus de Qi até dois e de R até três, I6 implica A wedge B wedge rho3=0. Se o núcleo em grau três é A wedge Lambda1 + B wedge Lambda1, escreve-se R=Q1 L1+Q2 L2+R2. Deslocar as duas quadráticas por L2 e L1 absorve a parte cúbica; sobra o caso de resto quadrático. Os pencils excepcionais precisam dos certificados separados.

**Conclusão candidata atual:** sob I6, algum de A, B, A+B tem posto até oito. Um subespaço isotrópico correspondente anula a parte quártica, dando flat cúbico de codimensão até quatro. O pacote contém a demonstração e os certificados, mas ainda aguarda auditoria externa e pesquisa de prioridade.

**Comparação com a entrega Opus:** o argumento via módulos de Klein propõe fechamento da mesma família com codimensão até cinco. É convergência de rotas, não uma segunda família resolvida; a classificação graduada e as dependências bibliográficas dessa rota também pedem revisão. O pacote aqui usa a redução por hiperplanos para evitar depender dessa classificação global.

**O que não segue:** o Lema L para qualquer parte quártica, a resolução de Q1, Q=1 global ou p=17. No cenário espectral de Astra, uma família excluída só se transfere depois de verificar as hipóteses globais e a obstrução a flats cúbicos. Peso e pico, isoladamente, não autorizam essa transferência.

## Técnica 30 — Produto módulo uma forma linear

**Origem:** corolário proposto por Opus, dedução conferida por Codex; condicional ao teorema candidato da técnica 29. Seja Delta a parte quártica de D e suponha Delta=A wedge B+x wedge phi, com A,B de grau exterior dois, x linear e phi de grau exterior três. Em H=ker(x), a parte quártica vira produto; D restrita é produto de duas quadráticas mais resto cúbico. I6 se preserva por restrição. O flat cúbico de codimensão até quatro em H tem codimensão até cinco no espaço original.

Mais geralmente, k formas lineares independentes dão codimensão até k+4. Com duas formas, a conclusão direta é seis, não cinco: o caso Delta=A wedge B+x1 wedge phi1+x2 wedge phi2 não está fechado por esse argumento. É necessário usar mais informação dos níveis de divisibilidade ou outro mecanismo.

**Separação importante:** a existência do flat cúbico depende só de Delta, pois a translação não altera a parte de grau quatro. I6 depende também dos termos inferiores. O Teorema A da nova entrega coincide com o pacote produto já arquivado; não contar esse fechamento duas vezes. A conjectura K3 testada em amostras e o Lema M proposto continuam sem prova geral nesta leitura.

**Auditoria adicional:** o programa mestre da entrega Argon em argon_auditoria_hiperplanos_07nov foi reexecutado por Codex em cópia de trabalho em 07/11. As cinco frentes passaram, a bibliográfica com dependências documentadas. Isso acrescenta conferência mecânica; não elimina as pendências de auditoria matemática externa da prova escrita. A nova nota completa NAO_PRODUTO_07NOV.md não estava disponível nos diretórios locais pesquisados; suas contagens adicionais não foram reproduzidas aqui.

Fonte: LEITURA_NAO_PRODUTO_E_AUDITORIA_07NOV.md. Q1 geral e p=17 continuam abertos. Não foi feita pesquisa de prioridade para o corolário.

## Técnica 31 — Equações de I6 por união e sobreposição de monômios

**Origem:** sistematização do Argon, com leitura algébrica e controles independentes de Codex. Material incorporado seletivamente após a auditoria PARECER_CODEX_ARGON_DUAS_FORMAS_07NOV.md; a entrega original contém demonstrações inválidas e não é endossada integralmente.

Para a ANF de D, tau(D) é a soma módulo dois dos produtos dos pares distintos de monômios. O levantamento inteiro satisfaz ell(D)=e1(D)−2 tau(D) módulo quatro. Para grau de D até quatro, I6 equivale ao desaparecimento de tau(D) nos graus seis, sete e oito, usando a equivalência invariante da técnica 25. Escreva D=Delta+R3+R2+R1+R0 em partes homogêneas. Então:

    grau 8: gamma2(Delta)=0;
    grau 7: Delta wedge R3 + tau1(Delta)=0;
    grau 6: Delta wedge R2 + gamma2(R3) + Delta *_1 R3 + tau2(Delta)=0.

Aqui gamma2(P) conta pares de monômios disjuntos; tau1(Delta) conta pares quárticos com interseção de tamanho um; tau2(Delta), interseção de tamanho dois; P *_1 Q conta produtos de monômios de P e Q com exatamente uma variável comum. Estas definições por uniões dão diretamente as fórmulas, sem a identidade de contrações falsa da entrega original. Tau1, tau2 e a operação de sobreposição dependem da base; o sistema completo expressa I6. R1 e R0 não contribuem nesses graus.

Para a decomposição Delta=T+x1 wedge Phi1+x2 wedge Phi2+x1 wedge x2 wedge Omega, com T=A0 wedge B0 e os demais fatores no complemento fixado, a condição de grau oito se separa em T wedge Phi1=0, T wedge Phi2=0 e T wedge Omega+Phi1 wedge Phi2=0. O termo misto não pode ser omitido. Isso usa gamma2(T)=0 e gamma2 de qualquer forma com fator linear igual a zero; o argumento inteiro incorreto do relatório não serve como prova dessas propriedades exteriores.

**Certificado negativo aproveitável:** em dez variáveis, Delta de máscaras [57,404,594] não admite completação inferior compatível com I6: somar as equações de grau sete nas máscaras [445,635,982] dá 0=1 para todas as correções cúbicas. Codex conferiu todas as colunas. É um controle de obstrução, não um exemplo do núcleo difícil: Delta tem um fator linear comum e já se anula num hiperplano.

**Redução aproveitável:** se Phi1, Phi2 ou sua soma pertence a A0 wedge Lambda1+B0 wedge Lambda1, existe um hiperplano onde Delta vira produto. A consequência de codimensão até cinco é condicional ao teorema candidato dos produtos. A identidade algébrica dessa redução não depende da prova inválida do Teorema 4.2 do Argon.

## Técnica 32 — Verificar o domínio do certificado e todos os termos cruzados

**Origem:** auditoria de Codex sobre o certificado do Argon. Para uma família quadrática de equações nos parâmetros, testar cada direção separadamente não testa as combinações de duas direções. É necessário conferir os coeficientes constantes, lineares e todos os termos cruzados do modelo completo.

No segundo certificado da entrega Argon, o núcleo cúbico completo tem dimensão 48. O vetor dual anula as 48 variações individuais, mas falha em termos cruzados entre elas. O programa original ainda confundia o span dos geradores individualmente no núcleo (dimensão oito) com a interseção do span com o núcleo (dimensão dez). A interseção correta foi recalculada e o certificado passou também nela: essa parte restrita pode ser conservada. Não pode ser estendida ao núcleo completo.

**Controle positivo obrigatório:** para Delta=[15,51,53,60,178,204,240], há uma completação com R3=[13,14,21,42] e R2=[3,10,12,17,34,130,132]. O levantamento inteiro e os 43.180 flats afins de dimensão seis em oito variáveis passaram em I6. As máscaras usam a ordem x1,x2,y1,...,y6. Uma exclusão de TODAS as correções desse Delta seria falsa.

**Correções que não foram incorporadas como ferramentas:** a identidade P *_1 Omega = sigma1(P) wedge Omega + P wedge sigma1(Omega) + sigma1(P wedge Omega), com sigma1 soma das contrações, é falsa. P=abcd e Omega=ae dão lado esquerdo abcde e direito zero, mesmo com P wedge Omega=0. Também é falsa a alegação de que produtos de quatro formas lineares booleanas sempre têm levantamento inteiro de grau até quatro: (a XOR b)cde tem o termo −2abcde.

**Atualização decisiva — Teorema 4.2 REFUTADO:** Astra construiu uma parte quártica Delta em S_span, em dez variáveis, com gamma2(Delta)=0 mas equação completa de grau sete insolúvel. O exemplo minimizado tem 24 monômios. O vetor dual de nove máscaras [351,415,575,830,855,861,911,919,923] anula todas as 120 colunas cúbicas e dá paridade um no lado direito. Codex reconstruiu o exemplo, conferiu o certificado e verificou os coeficientes por Möbius inteiro. Não resta apenas uma lacuna de prova: o enunciado universal é falso. Arquivos ASTRA_CONTRAEXEMPLO_G7_SSPAN_07NOV.json e CONTROLE_CODEX_CONTRAEXEMPLO_ASTRA_G7_07NOV.json. A redução por hiperplano da técnica 31 não é afetada: ela não afirma a existência de uma completação I6 para toda parte principal.

**Arquivos incorporados:** PARECER_CODEX_ARGON_DUAS_FORMAS_07NOV.md, audita_argon_duas_formas.py e AUDITORIA_ARGON_DUAS_FORMAS_CONTROLES.json. O verificador recebido passou em cópia de trabalho, mas não verificava a identidade universal falsa da prova escrita. Não confundir sucesso de execução com auditoria de todos os teoremas.

**Catálogo finito adicional de Codex:** fixando A0, B0 e Omega_res do contraexemplo Astra e variando cada um dos quatro deslocamentos em {0,y1,...,y8}, os 6.561 objetos distintos passam no grau oito. No grau sete, 6.201 admitem solução e 360 são insolúveis. Todos têm testemunha ou certificado dual, reexecutados sem solver. O catálogo comprimido está em CATALOGO_DESLOCAMENTOS_G7_07NOV.json.zlib, com gerador/verificador catalogo_deslocamentos_g7_07nov.py. É uma família finita específica e só decide G7: os 6.201 positivos NÃO foram declarados I6 nem I7. Não extrapolar a todas as formas lineares ou outros núcleos.

## Controle adicional — Posto oito, I6 e I7

Em CONTROLE_INDEPENDENTE_POSTO8_07NOV.json e confere_posto8_local.py, Codex conferiu cinco classes regulares em oito variáveis: em cada uma dos 10.795 subespaços de dimensão seis nenhum anula a parte quártica, e há uma testemunha de dimensão cinco. A codimensão mínima é, portanto, três nessas classes.

Foram construídas testemunhas I6 nas classes semissimples F4+F4 e repetida (t²+t+1)². A repetida também passa em I7, conferido por Walsh direto em todos os 510 flats afins de dimensão sete e pelo perfil inteiro. Assim, I7 sozinho não melhora universalmente a codimensão três para dois. Estes são controles exatos, não uma reexecução da classificação das 101 classes ou validação do Teorema A+ proposto por Opus. Ver LEITURA_DOIS_LINEARES_POSTO8_07NOV.md. A prova candidata de fechamento com duas formas lineares permanece com cobertura e solver pendentes de auditoria.

## Estado de revisão e próximos usos — 07/11

| Ferramenta | Evidência disponível | Trabalho necessário |
|---|---|---|
| Bits espectrais de Astra | Prova escrita e conferência local de constantes | Auditar também a redução inicial e manter hipóteses globais |
| Liftabilidade e I7 | Identidades e correções registradas | Usar a versão invariante, não níveis isolados |
| Produto com resto cúbico | Treze casos, duas implementações de núcleos e certificados exatos | Auditoria externa de cobertura, redução e parametrização |
| Ramo par por flats | Limiares exatos 663 e 1989/2 | Provar existência dos flats necessários; ramo aberto |
| Buscas GPU | Exclusões apenas nas amostras e famílias documentadas | Não extrapolar ausência nem somar lotes sobrepostos |

A versão congelada para revisão está em fechamento_produto_cubico_07nov. Não alterar esse instantâneo ao incorporar observações posteriores; produzir uma revisão nova. Conservar créditos a Opus pelos lemas de absorção e níveis, a Astra pela origem espectral e a Codex pela redução por hiperplanos, pareamento e certificados aqui descritos. Ferramentas clássicas continuam atribuídas à literatura. Nenhuma alegação de novidade está sendo feita.

## Técnica 33 — Walsh parcial nas fibras de um mapa

**Origem e hipótese.** A ortogonalidade dos caracteres dá a construção de Maiorana–McFarland e suas extensões com fibras maiores. Seja n par e suponha que f é afim nas classes de um subespaço fixo de dimensão d. Escolha um complemento e escreva f(y,v)=v·π(y)+H(y), com y ∈ F₂^(n−d) e v ∈ F₂^d. A técnica também vale sem simetria de rotação.

**Argumento.** Somar primeiro em v seleciona a fibra P_β=π⁻¹(β). Obtém-se

    W_f(α,β) = 2^d · Σ_(y∈P_β) (−1)^(H(y)+α·y).

Para bentness, cada soma da direita, sem o fator 2^d, deve ter módulo 2^(n/2−d). Parseval no espaço de y dá |P_β|=2^(n−2d). Para cada fibra desse tamanho, a condição completa é que o sinal apoiado nela tenha esse módulo em **todas** as frequências. De modo equivalente, sua autocorrelação deve se anular em cada deslocamento não nulo.

**Aplicação e limite.** Em n=12, d=5 dá quatro pontos e módulo dois. Para d=4, são 16 pontos e módulo quatro. A cardinalidade restringe os mapas candidatos. A escolha de um único H compatível com todas as fibras, com a rotação e com o grau exige uma etapa global. [Derivação e referência à construção de fibras de quatro pontos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/EXTERIOR_QUARTICO_N12.md)

## Técnica 34 — Reconhecer exatamente uma fibra de quatro pontos

**Origem e hipótese.** Adaptação elementar do Walsh parcial para n-2d=2. Considere quatro pontos distintos y₁,…,y₄, com valores de fase h_i.

**Argumento.** A soma de quatro sinais tem módulo dois exatamente quando seu produto vale -1. Na frequência α, o expoente do produto é Σ_i h_i+α·Σ_i y_i em F₂. Na frequência zero obtém-se Σ_i h_i=1. Nas demais frequências, exige-se Σ_i y_i=0. Quatro pontos distintos com essa última propriedade formam um plano afim. Reciprocamente, a paridade ímpar no plano dá o módulo exigido para todo α.

**Aplicação e alcance.** Para cada rótulo de π, testam-se quatro pontos distintos, sua soma vetorial e uma equação binária para a fase. Isso substitui uma transformada por fibra por um critério necessário e suficiente. Sua equivalência depende do número quatro. [Prova do critério](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/EXTERIOR_QUARTICO_N12.md)

## Técnica 35 — Reduzir o grau nas variáveis antipodais

**Origem e hipótese.** Redução local certificada para toda RS bent em 12 variáveis de grau total até quatro. Use duas metades a,b ∈ F₂⁶ e as coordenadas z=a+b, w=b. O grau em w conta apenas os fatores de coordenadas de w no monômio.

**Argumento.** Pela inversão de Walsh de uma função bent, o coeficiente multilinear inteiro de (-1)^f em qualquer suporte de peso oito é múltiplo de oito. Pela expansão em produtos de monômios da ANF, isso força paridade zero para os pares de monômios quárticos disjuntos cuja união é esse suporte. Nas coordenadas de órbita, essas paridades dão equações quadráticas nos coeficientes de topo. Dois certificados somam equações e seus múltiplos por coeficientes de topo para anular as duas formas lineares que podem ocorrer nos monômios quárticos com pelo menos três fatores de w. A verificação cobre as 135 máscaras relevantes, das quais 87 já têm coeficiente identicamente zero.

Restam possíveis cúbicos puros em w. A meia-volta envia w a w+z. Na diferença de um cúbico w_iw_jw_k, o coeficiente de w_iw_j ganha z_k. As diferenças dos termos de grau até dois em w têm grau em w no máximo um. A independência das coordenadas z_k anula os coeficientes cúbicos restantes. Portanto

    f(z,w) = h(z) + ℓ(z)·w + Σ_(i<j) B_ij(z) w_i w_j, com grau(B_ij) ≤ 2.

**Aplicação e limite.** A matriz polar alternada B(z) satisfaz B(z)z=0. Para z ≠ 0, seu posto é par e vale no máximo quatro. Um subespaço V dá afinidade nas suas classes exatamente quando B(z) se anula em V × V para todo z. A derivação dos dois certificados usa explicitamente as órbitas de 12 variáveis. [Identidades, máscaras e verificador](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/EXTERIOR_QUARTICO_N12.md)

## Técnica 36 — Linearizar as condições de sinal e certificar somas incompatíveis

**Sinais em uma fibra geral.** Seja M_(α,y)=(-1)^(α·y) a matriz de caracteres restrita às colunas da fibra P, e seja A o módulo exigido pela técnica 33. Introduzir sinais s_y,τ_α ∈ {-1,1} escreve simultaneamente todas as condições como Ms=Aτ. A igualdade é linear sobre os inteiros nos dois grupos de sinais. O domínio binário dos sinais continua essencial. Uma combinação inteira de linhas fornece uma identidade entre somas assinadas, e uma incompatibilidade de resíduos nessa identidade certifica a exclusão da configuração considerada.

**Origem e hipótese.** Álgebra linear binária aplicada à técnica 34. Fixado um mapa com fibras planas e um levantamento RS H₀ do grau desejado, escreva toda fase possível como H=H₀+Σ_(j=1,…,m) x_j h_j. As funções h_j formam uma base do núcleo das fases que preservam o mapa.

**Argumento.** O produto dos quatro sinais da fibra deve valer -1. Em expoentes binários, isso dá Rx=b, com R_(β,j)=Σ_(y∈P_β) h_j(y) e b_β=1+Σ_(y∈P_β) H₀(y). Um vetor λ com λᵀR=0 e λᵀb=1 é um certificado de impossibilidade. Basta somar as equações indicadas e conferir 0=1. Quando o sistema é compatível, há 2^(m−posto(R)) fases.

**Aplicação.** No bloco exterior afim no hiperplano U, o núcleo tem dimensão 15. A rotação permite agrupar as equações por órbita porque a correção de fase entre planos consecutivos soma zero. Essa verificação inclui o lado direito. Para os mapas planos do tipo de peso 24, as linhas não nulas assumem duas formas independentes. Nos mapas compatíveis, restam 2¹³ fases. A igualdade das linhas em dois planos injetivos deixa a soma dos respectivos lados direitos como obstrução explícita.

**Limite.** A paridade de cada fibra vira uma equação linear graças ao critério de quatro pontos. Em fibras maiores, a passagem aos expoentes binários exige um novo argumento para o módulo espectral pedido. [Equações e certificados de fase](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/FASES_QUARTICAS_N12.md) · [Demonstração posterior para o tipo de peso 24](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/CLASSIFICACAO_F4_BLOCO_U.md)

## Técnica 37 — Acoplar as linhas pares e ímpares sobre F₄

**Origem e hipótese.** Classificação de Codex para o tipo de peso 24, com auditoria adversarial por Astra. Em n=12, tome U=ker σ no espaço antipodal, s=σ(w), q(z)=π(z,0)+π(z,1). O peso de q conta os z com valor vetorial não nulo. Separe as linhas pela paridade σ(z). No tipo considerado, q se anula nas linhas ímpares e em oito linhas pares.

**Argumento.** Agrupar as coordenadas de índices pares e ímpares em triplas produz duas coordenadas em K=F₄, com ω²=ω+1. A rotação de duas posições escala essas coordenadas por ω. Norma N(u)=u³ e traço Tr(u)=u+u² exprimem os termos escalares. Os coeficientes nas duas paridades vêm de um só polinômio RS. Impor os planos fixos, a ocupação dos rótulos e a soma zero nos planos pares reduz a parte par a 16 escolhas para cada valor de um bit ε. A parte ímpar precisa preencher os rótulos disponíveis e satisfazer a paridade da fase. A comparação de fases entre dois planos pares ainda impõe uma condição sobre os coeficientes ímpares.

**Aplicação e revisão.** Com ε=0, as 16 escolhas pares admitem 48 escolhas ímpares cada. Com ε=1, oito admitem 64 escolhas cada. Assim 16·48+8·64=1.280 mapas admitem fase. A primeira comparação finita de coeficientes verifica as identidades na origem de um espaço afim de mapas e em 27 direções. A segunda verifica, em cada uma das 32 partes pares, a origem e dez direções de mapas, juntamente com a ação das 15 direções de fase. A extensão a esses espaços inteiros usa a dependência afim das identidades verificadas. [Classificação, parâmetros e auditoria](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/CLASSIFICACAO_F4_BLOCO_U.md)

## Técnica 38 — Identificar a mesma parametrização por um quociente de rótulos

**Origem e hipótese.** Dicionário entre a descrição em K e as funções ψ do parecer independente do Fable para o mesmo tipo de peso 24. Represente o rótulo β=π(z,0) por seis bits com β₅=0. Defina y_i=β_i+β_(i+3) para 0 ≤ i<3 e ψ(z)=(y₀,y₁,y₂). A projeção anula q(z), logo π(z,1) dá o mesmo resultado.

**Argumento.** As três componentes determinam inversivelmente o bit c=y₀+y₁+y₂ e o elemento P=y₀+ω²y₁+ω y₂ de K. Para cada ε, há quatro restrições pares distintas de ψ. Fixado ε, a restrição ímpar depende de um par (a,b) de K, com 15 possibilidades se ε=0 e três se ε=1. Assim há 4·15+4·3=72 funções ψ. Para cada uma, em coordenadas da parte ímpar, duas condições L ≠ 0, L+(C')² ≠ 0 deixam nove pares (L,C'). A equação linear que fixa L tem quatro soluções nos outros dois coeficientes. Seguem 36 escolhas ímpares por ψ e quatro orientações pares independentes, totalizando 72·36·4=10.368 mapas planos.

| Número de funções ψ | Escolhas ímpares com fase por ψ | Mapas com fase, com as quatro orientações |
|---:|---:|---:|
| 32 | 6 | 768 |
| 4 | 20 | 320 |
| 2 | 24 | 192 |
| 34 | 0 | 0 |

**Aplicação e limite.** As condições de traço explicam a tabela. Para ε=0, Tr(b)=1 deixa oito pares e seis escolhas ímpares por par. Para ε=1, permanecem duas restrições pares. Cada uma admite 24 escolhas para a=1 e 20 para cada a ∈ {ω,ω²}. A tabela conta mapas com pelo menos uma fase. Multiplicar a última coluna por 2¹³ dá o número de funções booleanas. O dicionário foi conferido nos 10.368 mapas. [Seção 9 da classificação e verificador](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/CLASSIFICACAO_F4_BLOCO_U.md)

## Técnica 39 — Documentar o alcance de classificação, contagem e controle

**Origem e hipótese.** Procedimento de revisão aplicado à classificação das quárticas exteriores afins em U. O caso q=0 corresponde à afinidade na diagonal inteira. Para o bloco exterior, a cobertura exige tratar todos os sete valores não nulos do espaço de q, de dimensão três.

**Argumento e aplicação.** A parametrização do tipo de peso 24 explica a cobertura das duas famílias e suas multiplicidades. A exclusão dos outros tipos tem evidência própria. Em uma fibra plana, uma dupla vertical obriga que o plano seja a união de duas duplas verticais. As linhas em que q ≠ 0 fornecem duas entradas cada, distribuídas em planos injetivos de quatro pontos. Seu número é wt(q)/2, o que exclui os dois tipos de peso 31. Nos tipos de pesos 16, 28 e 30, a contagem exata por ramos deu zero mapas planos. O Fable comunicou uma recontagem independente dos cinco tipos de peso par, com 2²⁸ mapas por tipo. A consolidação registra esse relato e a ausência de importação dos arquivos dessas execuções.

**Alcance.** O total do bloco exterior afim em U é 1.280·2¹³=10.485.760. A exclusão inteiramente algébrica dos tipos de pesos 16, 28 e 30 permanece aberta. A conferência da ANF e dos 4.096 valores de Walsh valida cada testemunha examinada. A cobertura do bloco vem da classificação e das exclusões anteriores. Das outras 8.730.624 quárticas exteriores, o catálogo atribui 4.227.072 à dimensão máxima de afinidade antipodal invariante quatro, 4.194.304 à dimensão três e 309.248 à dimensão dois. A classificação algébrica desses três blocos permanece aberta. [Consolidação e atribuição da recontagem](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/CONSOLIDACAO_BLOCO_U.md) · [Escopo dos blocos seguintes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/MISSAO_FABLE_DIM4.md)

## Técnica 40 — Códigos em fibras de 16 pontos

**Estado em 10/11.** O Fable confirmou a derivação e conferiu as 65.536 escolhas de sinais em cada um de 12 conjuntos de controle. A pesquisa de prioridade permanece pendente.

**Hipótese e enunciado.** Seja P ⊆ F₂⁸ um conjunto de 16 pontos distintos. Enumere seus pontos e forme o código binário C de comprimento 16 gerado pela constante e pelas avaliações das coordenadas em P. Então k=dim C=1+dimensão afim de P. O critério para a existência de sinais sobre P com módulo de Walsh quatro em todas as frequências é C ⊆ C⊥ e k ≤ 7. Sob auto-ortogonalidade, o número de fases locais é

    2^(15−k) − 128.

**Derivação.** Escreva os sinais como (-1)^(h_i). Módulo espectral quatro implica que as somas são congruentes a quatro módulo oito. Na direção inversa, a congruência torna cada quadrado pelo menos 16, e Parseval dá média dos quadrados exatamente 16. Traduzida no código, a congruência exige wt(h) ≡ 2 mod 4 e h· c=wt(c)/2 mod 2 para todo c ∈ C, com pesos de C pares. A polarização de wt(c)/2 dá o produto escalar, de modo que a linearidade exige auto-ortogonalidade. Quando ela vale, as soluções da condição linear formam um trasladado de C⊥, com 2^(16−k) palavras, todas de peso par. A soma de (-1)^(wt(h)/2) no trasladado, calculada por projeção de Fourier, dá 256. As palavras de peso dois módulo quatro são (2^(16−k)−256)/2.

| Dimensão afim de P | k | Fases locais se C for auto-ortogonal |
|---:|---:|---:|
| 4 | 5 | 896 |
| 5 | 6 | 384 |
| 6 | 7 | 128 |
| 7 | 8 | 0 |

**Aplicação e limite.** Para afinidade em dimensão quatro, o lema permite filtrar cada suporte sem supor que todo suporte é um subespaço afim. A compatibilidade entre as fibras continua a depender de um único polinômio H que preserve o grau e a rotação. Os dois subespaços invariantes de dimensão quatro dão núcleos globais de fase de dimensões 19 e 21. Multiplicar as contagens de fases locais como se as escolhas fossem independentes perderia essas restrições. [Enunciado, derivação completa e perguntas de auditoria](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/695da6501b82ab9c7c654eee0f796406bf2371ed/research_updates/2026_11_09_n12_mixed/MISSAO_FABLE_DIM4.md)

**Resultado comunicado pelo Fable para V₂.** A contagem independente percorreu os 2³¹ mapas e reproduziu 2.326.528 funções exclusivas. Dos 17.040 mapas exclusivos com fibras auto-ortogonais, 4.032 foram excluídos pelo posto oito, 10.224 pelo sistema linear global e 2.016 pela condição quadrática. Restaram 768 mapas. Em cada mapa sobrevivente, uma fibra é um flat de dimensão quatro. As outras 15 têm dimensão afim cinco ou seis. O Fable conferiu oito testemunhas por Walsh completo.

## Técnica 41 — Momentos de ordem maior nas fibras

**Origem e hipótese.** A expansão inteira usada para 16 pontos se estende a um conjunto P de 2^(2t) pontos distintos em F₂ᵇ, com t ≥ 1. Escreva x_I para o produto das coordenadas de I. Sejam N_I a soma de x_I em P e B_I a soma de x_I H em P.

**Critério exato.** O Walsh do suporte sinalizado tem módulo 2ᵗ em todas as frequências se e somente se

    B_∅ ≡ 2^(t−1) mod 2ᵗ.
    Para 1 ≤ |I| ≤ t, N_I é par e B_I ≡ N_I/2 mod 2^(t−|I|).

Expanda o caráter como produto de 1−2x_i a_i, onde a é a frequência. O coeficiente inteiro na máscara I é (−2)^|I| (N_I−2B_I). A inversão de Möbius inteira permite impor a congruência do espectro a 2ᵗ módulo 2^(t+1) coeficiente a coeficiente. A congruência torna todos os módulos pelo menos 2ᵗ. Parseval dá média dos quadrados igual a 2^(2t).

**Consequência para o suporte.** Todas as somas de x_I com |I| ≤ t são pares. Assim 1_P pertence ao dual de RM(t,b), isto é, a RM(b−t−1,b). Em n=12, com afinidade ao longo de r dimensões, temos b=12−r e t=6−r. Toda fibra tem indicador de grau no máximo cinco. A condição equivale a exigir grau no máximo cinco em todos os produtos de coordenadas distintas de π. Isso segue da expansão dos indicadores 1_(π=β) e da identidade inversa que soma os indicadores em que as coordenadas escolhidas do rótulo valem um.

**Aplicação e limite.** Para r=3, as fibras têm 64 pontos. Após a paridade, as condições de fase envolvem graus dois e quatro nos coeficientes de H. Para r=2, as fibras têm 256 pontos e a condição final tem grau oito. Essas cotas vêm dos bits do peso, que são os polinômios simétricos elementares de graus 1, 2, 4 e 8 sobre F₂. O grau cinco do indicador filtra o suporte. A contagem global exige compatibilidade das fases em todas as fibras.
