# Resposta à crítica da generalização — 4 de outubro de 2026

## Parecer e versão examinada

Foi examinada a versão de paper_hrsbf.tex na branch revisao-critica-bibliografia-2026-10-04, após a inclusão do lema quadrático de ordem ímpar e da proposição de restrição. A crítica apresentada não refuta essa prova: ela trata de uma restrição arbitrária e de argumentos por Poisson ou McEliece, que não integram a demonstração atual de transferência.

Isso não é aprovação externa nem garantia de publicação. Não foi identificada nesta reavaliação uma falha no lema atual que justifique reduzir automaticamente o teorema central a n=16.

## Por que o contraexemplo de restrição não se aplica

É correto que uma restrição arbitrária de uma função bent pode deixar de ser bent. A função x1x2+x3x4 e o subespaço indicado ilustram esse fato.

A proposição atual, porém, exige simultaneamente:

1. f tem grau no máximo três;
2. T é um automorfismo linear com T^m=I e m ímpar;
3. f é invariante por T;
4. o subespaço restringido é exatamente Fix(T), de dimensão par.

O contraexemplo apresentado não verifica essas hipóteses. A prova não assume a preservação geral de bentness por restrições.

## Reavaliação analítica do lema

Para uma quadrática invariante q, normalizada por q(0)=0, seja B sua polar. Defina P=I+T+...+T^(m−1), U=Fix(T), K=ker(P). Como m é ímpar, P²=P e V=U⊕K.

Para u∈U, k∈K, invariância da polar e oddness dão B(u,k)=B(u,Pk)=0. Portanto q(u+k)=q(u)+q(k), e a soma de sinais fatora:

    S_V(q) = S_U(q|U) S_K(q|K).

Se R é o radical de B restrita a K, então R é T-invariante e q|R é linear. Para r∈R,

    q(r) = Σ_j q(T^j r) = q(Σ_j T^j r) = q(Pr) = 0.

A primeira igualdade usa m ímpar e invariância; a segunda usa linearidade no radical. Por ortogonalidade de caracteres,

    S_K(q|K)² = |K| Σ_(r∈R) (−1)^q(r) = |K| |R| > 0.

Logo S_K não é zero, e q é balanceada se e somente se q|U é balanceada. Termos constantes são tratados pela normalização inicial; polares degeneradas são permitidas.

Agora, para uma f bent de grau no máximo três e a∈U não nulo, D_a f é de grau no máximo dois, balanceada e T-invariante. O lema implica que D_a(f|U) é balanceada. A caracterização por derivadas balanceadas prova bentness de f|U.

Em n=tm, t=2^s e m ímpar, T=σ^t tem ordem m e espaço fixo de dimensão t. Essa é a transferência usada no manuscrito. Não é uma extrapolação experimental do certificado em n=16.

O lema de órbitas, separado, coloca a restrição na classe F_t: o estabilizador cúbico tem ordem 1 ou 3, seu fator está contido em m e os orbitais reduzidos curtos cancelam. O termo quadrático antipodal não pertence a essa classe. Essas hipóteses são necessárias.

## O que a crítica acerta

- A preservação de bentness por uma restrição arbitrária é falsa.
- A soma de Poisson, sem hipóteses adicionais, não fornece a contradição pretendida em n=48.
- Divisibilidade do peso original por 256 é insuficiente para excluir bentness em n=48.
- Uma estrutura cíclica nas variáveis não autoriza aplicar automaticamente um teorema de código cíclico de comprimento n à tabela-verdade de comprimento 2^n.

Essas observações não atingem a demonstração atual. O argumento de divisibilidade é aplicado ao problema reduzido de t variáveis, cuja bentness foi obtida pelo lema, e não diretamente ao peso original em 16m variáveis.

Há também uma inconsistência aritmética na discussão de Poisson para m=1: 8m−16=−8, não zero. Nesse caso N_++N_−=1 e W_g(0)=256(N_+−N_−). A contradição local de n=16 permanece, mas N_+−N_− não pode ser ±256.

## Problemas no “dossiê corrigido”

1. **Espaço de 43 geradores.** É um espaço linear de ANFs (sem termo constante), não o espaço completo de grau até três RS. Há oito órbitas quadráticas distintas em n=16; somente sete têm comprimento 16. A antipodal P16 tem comprimento oito e foi excluída por necessidade. Ela é bent e tem peso 32640≡128 (mod256). Assim, a auditoria prova o resultado no espaço definido, incluindo os termos inferiores permitidos; não prova divisibilidade para termos inferiores arbitrários. Não se apresentou aqui um contraexemplo cúbico a toda formulação ampliada: identificou-se que a prova proposta não cobre essa ampliação.
2. **Congruência em n=32.** Para wt(H)=2104967168, 32·wt(H)≡0 (mod2048). O valor 512 corresponde a wt(H)/32 modulo 2048.
3. **“Barreira intrínseca”.** v₂(wt(H))=14 exclui essa H da bentness e refuta uma condição universal específica de divisibilidade. Não demonstra impossibilidade de todo método de Ward ou de outra escolha de código. A não bentness da órbita contígua já é coberta por Meng–Chen–Fu, Teorema 11. Nenhuma “hipótese da literatura” universal deve ser atribuída sem fonte precisa.
4. **Coordenadas das fibras.** Homogeneidade sozinha não implica f(u,0)=0 na partição usual das 32 variáveis em duas metades. Na H contígua, colocar apenas as três primeiras coordenadas em um e todas as demais em zero já dá f(u,0)=1. Aqui se usa a mudança x=(u,u+z): a fibra zero é f(u,u)=0 por emparelhamento sob meia-rotação e grau cúbico, junto da simetria.
5. **Parseval corretamente condicionado.** Defina F(u,z)=f(u,u+z), S_z=Σ_u(−1)^F(u,z). Para f bent, F também é bent e W_F(0,b)=Σ_z(−1)^(b·z)S_z. Parseval nessa transformada de 16 variáveis dá Σ_z S_z²=2^32. Como S_0=2^16, todas as outras S_z são zero. O resultado é válido com a anulação diagonal; não vale para bent arbitrária ou por homogeneidade isolada.
6. **Paridade.** Se f realmente tem a forma g(x_E)+g(x_O), a fatoração dos espectros e a dedução de que g precisaria ser bent são corretas. Deve-se justificar a definição do subespaço que garante essa decomposição. A multiplicatividade é uma identidade padrão, não um certificado automático de originalidade.
7. **Novidade e publicação.** “100% inatacável”, “original” e “rejeição sumária” não são conclusões justificadas pela auditoria apresentada. A comparação bibliográfica e o alcance do certificado precisam permanecer explícitos.

## Encaminhamento

Manter o enunciado atual condicionado à prova existente; não trocar pela versão ampliada incorreta do Teorema 1 do dossiê. Encaminhar o lema de ordem ímpar e o lema de órbitas completos para leitura externa. Qualquer objeção relevante à generalização deve indicar uma igualdade falsa, uma hipótese ausente nesses lemas ou um contraexemplo que satisfaça as hipóteses específicas.

Este registro não alterou os arquivos cobertos pelo manifesto da suíte nem alegou uma nova execução numérica. A conclusão se baseia na reavaliação analítica da versão atual e nas auditorias previamente registradas.
