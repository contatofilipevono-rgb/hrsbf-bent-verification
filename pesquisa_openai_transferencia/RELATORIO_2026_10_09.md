# Transferência matemática OpenAI Math → V1/V2/V3 e problemas externos

**Data:** 2026-10-09. **Status:** demonstração matemática e ensaios CPU exatos. Ainda não é prova em Lean 4, nem reivindicação de originalidade.
**Branch isolada:** \`research-openai-math-transfer-2026-10-09\`; baseada na V3-C em \`01ea4b263a3cbe338df264b9d057a4edb3a980c8\`. Não modifica V1/V2/V3-C.

## 1. Um lema generalizado da V1

Seja G um grupo finito de ordem ímpar agindo por transformações lineares em V sobre F2; seja U=V^G. Para toda função q:V→F2 de grau algébrico <=2 e G-invariante,

    q balanceada em V  ⇔  q|U balanceada em U.

**Prova.** Somar q(0) não altera balanceamento; suponha q(0)=0 e defina B(x,y)=q(x+y)+q(x)+q(y). O operador P=Σ_(g∈G)g é uma projeção sobre U: P²=P, im P=U, K=ker P, V=U⊕K. Vale B(U,K)=0 pela G-invariância e pelo fato de |G| ser ímpar. Portanto S_V(q)=S_U(q|U)S_K(q|K), onde S_X(q)=Σ_x∈X(-1)^q(x). Se R=rad(B|K), R é G-invariante e q|R é linear; para r∈R, q(Pr)=Σ_g q(gr)=|G|q(r)=q(r), mas Pr=0, logo q(r)=0. A identidade quadrática dá S_K(q)^2=|K|Σ_(r∈R)(-1)^q(r)=|K||R|>0. Assim S_K(q)≠0 e segue a equivalência.

**Corolário.** Se f é G-invariante, bent e de grau <=3, então f|U é bent. Para a∈U não nulo, D_a f é quadrática, G-invariante e balanceada; a equivalência acima se aplica a D_a f. Pelo critério de autocorrelação para bentness, f|U é bent. Dim U é par, salvo a convenção trivial na dimensão 0.

Isto generaliza o lema de **ação cíclica de ordem ímpar já presente na V1**, não é uma nova prova da conjectura cúbica RS e não apresenta novidade bibliográfica estabelecida.

## 2. Controles computacionais reprodutíveis

Arquivo: \`verify_odd_group_transfer.py\` (Python padrão; nenhum pacote/GPU).
- C3×C3 sobre F2^6 com rotações independentes das duas triplas: 32 ANFs invariantes de grau <=2 (omitida constante); 12 balanceadas, 0 contraexemplos.
- Até grau 3: 512 ANFs invariantes, 4 bent, 0 contraexemplos.
- Busca adicional com mesmas simetrias e n=6, todos os coeficientes até grau 4, 5 e 6: respectivamente 2^12, 2^14 e 2^15 combinações, sempre 4 bent e 0 violações. Este controle **não prova** transferência geral para grau >=4.
- Bent cúbica genuína G-invariante em 10 variáveis: blocos A=(x0,x1,x2), B=(x3,x4,x5), bits fixos a=x6,b=x7,c=x8,d=x9. Seja LA=Σ_A xi, LB=Σ_B xi, e2(A)=Σ_(i<j∈A)xi*xj. Então f=e2(A)+e2(B)+LA*LB+ab+cd+LA*a*c. Invariância sob C3×C3, espectro completo magnitude 32 e grau exatamente 3; sua restrição U de dimensão 6 tem espectro completo magnitude 8.

Os dados devem ser interpretados como controle CPU, não certificado universal.

## 3. OpenAI Math 192 e barreira para bent

A família 192 da OpenAI formaliza violações do limite de soma de coeficientes lineares de Fourier em função do **grau multilinear real**. Este grau não é o grau ANF de F2.
Se F=(-1)^f é bent e n par, os 2^n coeficientes normalizados satisfazem |Fhat(S)|=2^{-n/2}. Logo:

- Σ_(|S|=1)|Fhat(S)| = n·2^{-n/2} <= 1;
- Entropia espectral H(F)=n;
- Influência total I(F)=n/2; portanto **H(F)=2I(F)**.

Consequência: a amplificação da família 192 não se transplanta diretamente à classe bent. Não há solução nova para FEI.

## 4. Direções e critérios de avanço

- **V1:** formalizar o lema G ímpar como extensão modular separada; não retrabalhar a prova cúbica já escrita.
- **V2:** procurar grau 4 para o qual transferência por ponto fixo falhe, ou provar hipóteses suficientes. A derivada de quartica tem grau 3; o argumento quadrático já não basta.
- **V3-C:** explorar coerência entre conectividade do grafo, cohomologia reduzida H^0 e indecomponibilidade EA, SEM atribuir teorema novo sem uma consequência matematicamente distinta. No repositório V3-C, a classificação EA canônica é separada da robustez a perturbações quadráticas.
- **Outros problemas (177):** coboundary expanders limitados não implicam sem outras hipóteses estruturas cúbicas lossless para qLTC. Provar ponte com hipóteses precisas ou contraexemplo; ainda aberto.
- **Outros problemas (210):** resultado Lean da Foulkes–Howe inclui a>=2, b>=a(a−1), ou b>=30 para a=6; o manuscrito companheiro trata b>=6. A faixa 6<=b<=29 não está coberta **por essa formalização**; não chamar de problema matemático aberto.
- **FEI (192):** explorar classes não espectralmente planas para obter algo diferente da igualdade bent H=2I.
- **Prioridade bibliográfica:** conferir trabalhos de funções bent invariantes por grupos, incluindo Charnes–Roetteler–Beth; não fazer reivindicação de prioridade.

## 5. Evidência e próximos testes

Verificado diretamente por execução CPU: controle finito C3×C3, função bent n=10, espectros completos. Demonstrado em papel: lema de ordem ímpar para grau <=2 e corolário bent até grau 3. **Não formalizado em Lean:** a demonstração geral. Aceitar como Lean somente após build completo, auditoria #print axioms, ausência de sorry e comparação com os enunciados matemáticos; não classificar como compilado antes.

Fonte V1: \`paper_arxiv_v1.tex\` na branch \`colab-a100-2026-10-06\`.
Estado V2: \`V2_DEVELOPMENT_2026-10-07.md\` (n=12 GPU não reivindicado).
Estado V3-C: \`pesquisa_v3c_symplectic/PROOF_STATUS.md\` na branch \`v3c-ea-transport-continuation\`.

Fontes externas:
- https://github.com/openai/math/blob/main/lean/docs/192.md
- https://github.com/openai/math/blob/main/lean/docs/177.md
- https://github.com/openai/math/blob/main/lean/docs/210.md
- https://doi.org/10.1007/s10801-021-01057-3

**Não alterar as branches congeladas V1, V2 e V3.**
