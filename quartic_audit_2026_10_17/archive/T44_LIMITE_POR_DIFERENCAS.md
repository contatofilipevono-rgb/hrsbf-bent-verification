# Lema de diferenças finitas para vieses de caracteres

Sejam P uma função booleana nas coordenadas livres e T um subespaço de dimensão k. Escreva F(x)=(-1)^P(x). A média, sobre h em T, da autocorrelação de F é a média dos quadrados das médias de F nas classes de T. Por Cauchy,

`|E F|² ≤ E_(h∈T) E_x (-1)^(P(x+h)+P(x))`.

Se cada diferença não nula D_hP é quadrática com posto polar r(h), a soma quadrática normalizada tem módulo no máximo 2^(-r(h)/2). Logo

`|E F|² ≤ 2^(-k) [1 + Σ_(h∈T,h≠0) 2^(-r(h)/2)]`.

Basta verificar que as diferenças nas direções de uma base são quadráticas: D_(a+b)P(x)=D_aP(x+b)+D_bP(x), e translação preserva o grau e a parte quadrática. Portanto as matrizes polares das demais diferenças são as somas das matrizes básicas. A enumeração em código Gray calcula todos os 2^k−1 postos.

Quando P tem grau quatro, procuramos direções no radical das contrações do tensor quártico. Essa busca serve para encontrar a base; o certificado não depende da correção da busca, pois reconstrói diretamente cada diferença e verifica que seu grau é no máximo dois. Para o ramo de grau cinco, fixar c57 primeiro reduz o grau. Todas as fibras são incluídas com seu peso uniforme.

T43 usa k=16 e reconstrói cada matriz diretamente dos polinômios certificados. O gerador calcula postos com pivôs altos; o verificador usa pivôs baixos. Ambos enumeram as 65.535 matrizes não nulas de cada caso. O limite da raiz quadrada é uma fração racional cuja desigualdade quadrática é conferida exatamente, sem arredondamento em ponto flutuante.

T44 acrescenta uma mudança afim: fixa o valor da forma u2=c1+c9+c15+c28+c53+c67+c76+c103 e elimina c1. Fixar c57 e u2 produz quatro fibras afins equiprováveis, todas examinadas. Não se impõe u2=0 como condição necessária. A média dos quatro limites limita o viés original.

O lema vetorial de caracteres recebe o menor limite válido de cada técnica: restrições quadráticas anteriores, diferenças finitas ou média de fibras. A simetria e as medidas originais dos ramos permanecem as de T40. Os verificadores independentes T43 e T44 concluíram com PASS. T43 reconstrói 224 matrizes básicas e confere 917.490 postos; T44 reconstrói mais 128 matrizes básicas e confere 524.280 postos. No total, 1.441.770 matrizes não nulas foram verificadas por eliminação com pivôs baixos, independente dos pivôs altos do gerador.

As partições afins acima são tomadas no espaço das variáveis livres. A reconstrução dos coeficientes originais é não linear; a uniformidade usada na prova decorre da bijeção, sem supor que a imagem seja um subespaço afim.

## Resultado demonstrado

T43 melhora o limite para exclusão de pelo menos 99,95861540189143%. A média das fibras afins T44 melhora novamente para **99,96433819284774%**. A fração que passa nas treze condições é no máximo

`822305287179573/2305843009213693952`.

A desigualdade é global no espaço original de 2^116 vetores; não é taxa empírica. O número de condições necessárias continua sendo treze: fixar paridades temporariamente apenas particiona a prova, incluindo todos os valores, sem excluir nenhum deles como hipótese adicional.

A melhora não demonstra inexistência global, não certifica sobreviventes e não altera o domínio GPU preparado. T40 preserva o resultado anterior e os certificados dos modelos/simetrias usados por estes refinamentos.

Arquivos: `VERIFICAR_DERIVADAS_T43.py`, `VERIFICAR_DERIVADAS_T44.py`, os pares `T43/T44_DERIVADAS_CERTIFICADO.json`, `T43/T44_LIMITE_CERTIFICADO.json` e `T43/T44_DERIVADAS_VERIFICACAO.json`. Execute primeiro as verificações T40, depois T43 e T44.
