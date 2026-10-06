# Avanço parcial em 32 variáveis: obstruções por fibras quadráticas

**Resultado desta etapa:** obtivemos certificados exatos de não-bentness para famílias inteiras de funções cúbicas homogêneas com simetria de rotação em 32 variáveis. O menor certificado apresentado usa sete condições necessárias cuja soma em F₂ é **0=1**. Uma implementação separada da busca confirmou o certificado diretamente nas ANFs originais.

Este é um avanço em relação ao material anteriormente auditado. **A originalidade perante a literatura não está estabelecida. Não resolvemos o caso geral n=32.** A afirmação principal abaixo é uma exclusão parcial assistida por computação, com condições e arquivos reproduzíveis.

## 1. O que foi demonstrado e verificado

| Resultado | Alcance | Evidência |
|---|---|---|
| Decomposição dos 155 coeficientes em um parâmetro de dimensão 35 e 120 graus de liberdade por fibra desse parâmetro | Todo o espaço cúbico homogêneo RS em 32 variáveis | Argumento algébrico e conferência das 155 formas polares originais nas 16 direções básicas |
| Fibra antidiagonal | Exclui um subespaço de dimensão 149: 2¹⁴⁹ vetores de coeficientes, incluindo zero | Prova estrutural; seis formas lineares explícitas; classificação exata das 64 fibras módulo constantes |
| Certificado de sete fibras | Exclui os 2¹²⁰ membros da família cujo parâmetro é a órbita cúbica contígua em 16 variáveis | Sete formas lineares somam zero e seriam todas iguais a um se a função fosse bent |
| Todas as classes com até duas órbitas ativas no parâmetro de 35 coordenadas | **631 de 631 classes excluídas**; cada classe tem 2¹²⁰ funções | 19 exclusões antidiagonais, 588 contradições lineares e 24 testemunhos de autocorrelação diagonal não nula |
| Fechamento dos 24 casos antes restantes | 16 classes têm radical de dimensão 4 com peso fixo 6 em vez de 8; 8 classes têm radical de dimensão 8 com peso fixo 120 em vez de 128 | `verificar_derivadas_diagonais.py` reconstrói as formas lineares a partir das 155 órbitas originais e prova independência dos 120 parâmetros livres |

A condição “até duas órbitas” refere-se **ao parâmetro de 35 coordenadas**, não à quantidade de órbitas da função original. Uma função das famílias examinadas pode conter muitas das 155 órbitas originais. As 631 classes não são uma enumeração de todo o espaço de parâmetros, que tem 2³⁵ elementos.

As 19 classes excluídas pela fibra antidiagonal já pertencem ao subespaço de dimensão 149. Não devem ser somadas novamente a ele como resultados disjuntos. As 588 classes com certificados lineares estão fora desse subespaço; juntas acrescentam 588·2¹²⁰ funções excluídas. A contagem do subespaço inclui a função zero; para grau exatamente três, retire uma unidade dessa contagem.

## 2. Convenções e o parâmetro de dimensão 35

Escreva f_c como soma das 155 órbitas de monômios cúbicos sob C₃₂, com vetor de coeficientes c∈F₂¹⁵⁵. As órbitas são ordenadas pelo menor representante lexicográfico de cada tripla de índices, começando em zero. Essa ordenação é diferente de outras máscaras ordenadas por intervalos cíclicos: não intercambiar máscaras de convenções distintas.

Para uma tripla de índices em 32 variáveis, reduza seus índices módulo 16:

- Quinze órbitas originais contêm um par antipodal e produzem apenas dois índices distintos.
- As outras 140 órbitas se agrupam em 35 grupos de quatro, um grupo para cada órbita cúbica em 16 variáveis.

Defina η(c)∈F₂³⁵ pela paridade dos quatro coeficientes em cada grupo. A aplicação η é sobrejetiva: seus 35 grupos são disjuntos e não vazios. Seu núcleo tem dimensão 155−35=120. Portanto cada valor fixado de η tem exatamente 2¹²⁰ preimagens.

Associamos a η um polinômio cúbico RS h em 16 variáveis. **h é um parâmetro da polarização; não é a restrição de f ao subespaço diagonal**, pois essa restrição é zero.

## 3. Por que esse parâmetro controla todas as partes quadráticas

Para u,z∈F₂¹⁶, ponha

\[q_z(u)=f_c(u,u+z).\]

A meia-rotação emparelha os monômios cúbicos, nenhum dos quais é fixado por ela. Assim f_c(u,u)=0. Na expansão de q_z, os termos de grau três em u se cancelam; q_z tem grau no máximo dois.

Para três índices distintos módulo 16, um par de monômios relacionados pela meia-rotação contribui para a parte quadrática em u com

\[z_a u_bu_c+z_b u_au_c+z_c u_au_b.\]

Essa expressão independe de quais índices do monômio original estavam na segunda metade. Os quatro levantamentos de uma órbita cúbica em 16 variáveis têm, portanto, a mesma contribuição. Um monômio com par antipodal contribui somente para termos de grau no máximo um em u.

Se T_h é a polarização trilinear de h, segue que a polar de q_z é

\[B_z(u,v)=T_h(z,u,v).\]

Ela depende apenas de η(c), não dos outros 120 parâmetros. Os termos lineares e constantes de q_z **continuam sendo necessários** para decidir balanceamento.

A identidade é conferida no programa separado por avaliações das ANFs originais. Para cada uma das 155 órbitas, são reconstruídas as matrizes polares nas 16 direções básicas de z. A dependência linear em z decorre da expansão acima.

## 4. A condição necessária usada nos certificados

Seja A={(u,u)}. Temos dim A=16 e A=A^⊥. Se f_c fosse bent e f_c|A=0, a soma de seus coeficientes de Walsh em A^⊥ seria 2³². Como são 2¹⁶ coeficientes de módulo 2¹⁶, todos seriam +2¹⁶. Pela inversão de Fourier no quociente, todas as outras classes de A teriam soma de sinais zero. Logo q_z seria balanceada para todo z≠0.

O princípio que relaciona restrições de bent e espectro da dual tem antecedentes. Ele não é reivindicado como novidade: [Canteaut–Charpin, *Decomposing Bent Functions*, 2003, Teorema 5 e Corolário 3](https://www.rocq.inria.fr/secret/Pascale.Charpin/CanCha-i3e03.pdf).

A meia-rotação também dá q_z(u+z)=q_z(u). Portanto z pertence ao radical de B_z e q_z(z)=q_z(0).

Para uma quadrática q, a função r↦q(r)+q(0) é linear no radical da polar. A soma de sinais de q é zero exatamente quando essa função linear não é nula. Isso segue da identidade

\[S(q)^2=2^{16}\sum_{r\in\operatorname{rad}B}(-1)^{q(r)+q(0)}.\]

Quando rank B_z=14, o radical tem dimensão dois. Se r não é 0 nem z e B_z(r,·)=0, então o radical é span(z,r). Como o funcional vale zero em z, balanceamento equivale exatamente a

\[q_z(r)+q_z(0)=1.\]

Fixado h, os vetores z,r e a matriz B_z são conhecidos. O lado esquerdo é uma **forma linear nos 155 coeficientes de f_c**, calculável por duas avaliações da função original. Isso permite substituir buscas entre 2¹²⁰ funções por um sistema de equações lineares necessárias.

## 5. Certificado curto de sete fibras

Fixe o parâmetro

\[h(u)=\sum_{i=0}^{15}u_i u_{i+1}u_{i+2},\]

com índices módulo 16. Na ordenação declarada, sua máscara é 0x1. Para os sete pares abaixo, B_z tem posto 14 e radical span(z,r). Um inteiro representa o vetor cujos bits de índices 0,…,15 são suas coordenadas.

| z (hexadecimal) | r (hexadecimal) | Posto de B_z |
|---|---|---:|
| 08D5 | 0800 | 14 |
| 0AB1 | 0001 | 14 |
| 1155 | 0155 | 14 |
| 085F | 0800 | 14 |
| 087D | 0800 | 14 |
| 08F5 | 0800 | 14 |
| 0AF1 | 0001 | 14 |

Escreva L_i(c)=f_c(r_i,r_i+z_i)+f_c(0,z_i). Para cada um dos 155 geradores originais, a soma dos sete valores L_i é zero. Por linearidade,

\[L_1(c)+\cdots+L_7(c)=0\quad\text{para todo }c.\]

Entretanto, bentness exigiria L_i(c)=1 para os sete índices. A soma dessas sete equações seria 0=1. **Nenhum membro da família η(c)=0x1 é bent.** A família tem dimensão afim 120 e todos os seus membros têm grau exatamente três.

Os coeficientes das sete formas estão em `certificado_7_fibras.json`. O conferidor `verificar_7_fibras.py` não importa o programa de busca: reenumera as órbitas, recompõe as matrizes por avaliações da ANF, calcula os postos e os radicais e verifica o XOR das sete formas. O certificado não exige confiar nas etapas intermediárias da busca que o encontrou.

## 6. Obstrução antidiagonal e seis equações

Para J=(1,…,1), a rotação das 32 coordenadas preserva a fibra e induz

\[T(u)=(u_{15}+1,u_0,\ldots,u_{14}),\qquad q_J(Tu)=q_J(u).\]

Se q_J é afim, escreva q_J=a·u+b. A comparação dos coeficientes força a ser um múltiplo do vetor J; a comparação dos termos constantes força esse múltiplo a ser zero. Logo q_J é constante e não pode ser balanceada. Portanto B_J=0 já exclui bentness.

A parte quadrática de q_J é soma dos sete polinômios Q_d=Σ_i u_i u_{i+d}, 1≤d≤7. A distância antipodal 8 cancela. Se os coeficientes são a_d, a contração de cada triângulo contém um número par de arestas de distância ímpar; assim

\[a_1+a_3+a_5+a_7=0.\]

A imagem tem dimensão exatamente seis. Por exemplo, as órbitas dos triângulos 012, 024, 036, 014, 016 e 018 produzem, respectivamente, Q₂, Q₄, Q₆, Q₁+Q₃+Q₄, Q₁+Q₅+Q₆ e Q₁+Q₇; são seis imagens independentes.

Logo B_J=0 impõe seis condições lineares independentes em c. Seu núcleo tem dimensão 149. As seis formas, com índices e máscaras, estão em `fibra_J_certificado.json`.

Adicionalmente, o verificador enumera as 64 formas normalizadas possíveis: a nula é constante; as outras 63 são balanceadas. A imagem incluindo constantes tem dimensão sete. Isso caracteriza exatamente o que **esse teste isolado** exclui; não caracteriza todas as funções não bent.

## 7. Ampliação por derivadas diagonais e fechamento do recorte de peso ≤ 2

Foram examinados todos os 1+35+595=631 valores de η com peso no máximo dois. O procedimento baseado em fibras de posto 14 excluía 607 deles:

- 19 classes por B_J=0;
- 588 classes por contradição linear;
- 24 classes permaneciam sem exclusão por esse procedimento.

Essas 24 classes pertencem ao subespaço de dimensão sete gerado pelas órbitas representadas por 024, 026, 028, 02(10), 02(12), 048 e 04(10), em índices módulo 16. Nesse subespaço, o teste de posto 14 é estruturalmente inadequado porque as contrações se decompõem por paridade e têm posto no máximo 12.

Para fechar exatamente essas 24 classes usamos a autocorrelação na direção diagonal (r,r). Se R_r=rad(B_r), então

\[
AC_f((r,r))=2^{16}\sum_{z\in R_r}(-1)^{L_z(r)},
\]

onde L_z(r)=f_c(r,r+z)+f_c(0,z). Bentness exige AC_f((r,r))=0 para todo r≠0.

O novo verificador `verificar_derivadas_diagonais.py` mostra que, para cada uma das 24 classes restantes, existe uma direção r em que todos os valores L_z(r), z∈R_r, ficam completamente determinados por η(c)=h: a dependência nos 120 parâmetros livres desaparece.

Os certificados caem em apenas dois tipos:

- 16 classes: dim R_r=4, portanto |R_r|=16, mas exatamente 6 dos 16 valores L_z(r) são 1. Bentness exigiria 8. Assim AC=2^18≠0.
- 8 classes: dim R_r=8, portanto |R_r|=256, mas exatamente 120 valores são 1. Bentness exigiria 128. Assim AC=2^20≠0.

Logo as 24 classes antes restantes também são excluídas. **Conclusão do recorte:** todas as 631 classes de η com peso de Hamming ≤2 são não-bent, e cada uma representa uma família afim de 2^120 funções originais.

Isto ainda não classifica os 2^35 possíveis valores de η. O caso geral n=32 permanece em aberto nesta investigação.


## 7B. Extensão ao subespaço de mesma paridade

O mecanismo de autocorrelação diagonal foi ampliado de forma exata para todo o subespaço de dimensão sete de parâmetros η gerado pelas sete órbitas cúbicas em 16 variáveis cujos representantes têm índices da mesma paridade.

Esse subespaço contém 128 valores de η. Para cada valor não nulo, o verificador testa as direções diagonais r em {0x0303, 0x0F0F, 0x3333} e agrupa as formas L_z(r) por sua dependência residual nos 120 parâmetros livres do levantamento. Quando todos os caracteres residuais não constantes cancelam exatamente e sobra apenas um coeficiente constante não nulo, a autocorrelação AC_f((r,r)) = 2^16 * sum_{z in rad(B_r)} (-1)^{L_z(r)} é o mesmo inteiro não nulo para todos os 2^120 levantamentos daquele η.

O resultado exato é:

- η=0: excluído pela obstrução antidiagonal já demonstrada;
- 124 dos 127 valores não nulos: excluídos por autocorrelação diagonal constante e não nula;
- 3 valores permanecem sem exclusão por este teste: `0x2a8000`, `0x1000a2000` e `0x10020a000`.

Na verdade, os três valores que não tinham testemunho pelas três direções diagonais simples pertencem todos ao núcleo da contração antidiagonal B_J. Assim, a união das duas obstruções fecha o subespaço inteiro:

- 32 valores de η têm B_J=0 e são excluídos pela fibra antidiagonal;
- 124 valores têm testemunho de autocorrelação diagonal constante e não nula;
- há sobreposição de 28 valores entre os dois conjuntos;
- portanto a união contém **128 de 128 valores de η**.

Os quatro valores cobertos apenas pela obstrução antidiagonal são `0x0`, `0x2a8000`, `0x1000a2000` e `0x10020a000`. Em particular, os três casos anteriormente listados como restantes estão agora excluídos.

Logo, **todo o subespaço de dimensão sete de mesma paridade está excluído**, cada quociente correspondendo a uma família afim de dimensão 120 no espaço original de 155 coeficientes.

O conferidor `verificar_subespaco_eta_paridade.py` agora audita explicitamente os dois mecanismos e confirma a cobertura 128/128. O espaço completo ainda possui 2^35 valores de η, portanto o caso geral n=32 continua em aberto.


## 7C. Ampliação para um subespaço explícito de dimensão 18

A combinação da obstrução antidiagonal com um conjunto fixo de sete direções de autocorrelação diagonal permite ampliar drasticamente o resultado anterior. Foi encontrado e verificado exaustivamente um subespaço coordenado H de dimensão 18 em F₂^35, portanto com 2^18 = 262.144 valores de η.

Uma base explícita de H é dada pelos índices de órbita

`[13, 15, 17, 19, 21, 30, 32, 1, 2, 5, 22, 33, 20, 11, 31, 8, 14, 27]`,

correspondentes aos representantes cúbicos em 16 variáveis

`024, 026, 028, 02(10), 02(12), 048, 04(10), 013, 014, 017, 02(13), 04(11), 02(11), 01(13), 049, 01(10), 025, 03(10)`.

Para cada um dos 262.144 quocientes, o verificador usa primeiro a fibra antidiagonal e, quando necessário, procura um testemunho entre as sete direções

`0x0101, 0x0505, 0x0303, 0x0F0F, 0x3333, 0x1111, 0x5555`.

Todos os 262.144 quocientes são excluídos. Como ker(η) tem dimensão 120, a preimagem de H no espaço original F₂^155 tem dimensão 18+120=138. Assim a obstrução cobre exatamente um subespaço de **2^138 vetores de coeficientes originais**; retirando o vetor zero, são 2^138−1 funções cúbicas homogêneas não nulas excluídas.

O verificador `verificar_subespaco_eta_dim18.py` percorre os 2^18 quocientes por Gray code, reconstrói as contrações polares e as formas L_z(r) a partir das 155 órbitas cúbicas originais e exige um certificado para cada quociente. A saída resumida está em `resultado_subespaco_eta_dim18.json`.

O resultado é estritamente mais forte que o fechamento do subespaço de dimensão sete e que o recorte de peso ≤2. Não se afirma que dimensão 18 seja máxima; o espaço completo de η tem dimensão 35, portanto o caso geral n=32 permanece em aberto.


## 7D. Ampliação exata para dimensão 21

A mesma arquitetura foi ampliada novamente. Acrescentando as três coordenadas de η correspondentes às órbitas cúbicas `012`, `015` e `016`, obtemos um subespaço coordenado explícito de dimensão 21 em F₂^35.

Esse subespaço contém exatamente 2^21 = 2.097.152 quocientes. Todos foram verificados por aritmética exata em CPU e todos são excluídos pela união da fibra antidiagonal com as mesmas sete direções de autocorrelação diagonal

`0x0101, 0x0505, 0x0303, 0x0F0F, 0x3333, 0x1111, 0x5555`.

A contagem do primeiro testemunho encontrado é:

- antidiagonal: 32.768;
- `0x0101`: 892.160;
- `0x0505`: 525.176;
- `0x0303`: 306.648;
- `0x0F0F`: 157.992;
- `0x3333`: 155.024;
- `0x1111`: 19.352;
- `0x5555`: 8.032.

A soma é 2.097.152 e não há sobreviventes.

Como ker(η) tem dimensão 120, a preimagem deste subespaço no espaço original F₂^155 tem dimensão **141**. Portanto a obstrução exclui todos os 2^141 vetores de coeficientes desse subespaço; retirando o vetor zero, são **2^141−1 funções cúbicas homogêneas não nulas**.

O verificador é `verificar_subespaco_eta_dim21.py`; a saída consolidada está em `resultado_subespaco_eta_dim21.json`. A enumeração de desenvolvimento foi concluída em blocos contíguos exatos cobrindo os 2^21 casos; o script comprometido reproduz a mesma enumeração integral em uma única execução com cache de radicais limitado em memória.

Ainda não se afirma que dimensão 21 seja máxima. O espaço de quocientes completo tem dimensão 35 e o caso geral n=32 permanece em aberto.


## 7E. Ampliação exata para dimensão 22

Foi acrescentada a coordenada de η correspondente à órbita cúbica `018`, levando o subespaço explícito para dimensão 22.

O novo subespaço contém exatamente 2^22 = 4.194.304 quocientes. A metade já pertencia ao subespaço de dimensão 21. O novo cosseno, de tamanho 2^21 = 2.097.152, foi verificado exatamente em 8 blocos independentes de 262.144 casos cada, sem qualquer falha. Portanto a cobertura total é **4.194.304/4.194.304**, sem sobreviventes.

As mesmas sete direções de autocorrelação continuam suficientes:

`0x0101, 0x0505, 0x0303, 0x0F0F, 0x3333, 0x1111, 0x5555`.

A contagem consolidada do primeiro testemunho encontrado é:

- antidiagonal: 65.536;
- `0x0101`: 1.884.208;
- `0x0505`: 1.017.336;
- `0x0303`: 585.388;
- `0x0F0F`: 297.134;
- `0x3333`: 290.956;
- `0x1111`: 37.082;
- `0x5555`: 16.664.

A soma é exatamente 4.194.304.

Como ker(η) tem dimensão 120, a preimagem desse subespaço em F₂^155 tem dimensão **142**. Assim são excluídos todos os 2^142 vetores de coeficientes do subespaço, ou **2^142−1 funções cúbicas homogêneas não nulas**.

O verificador `verificar_subespaco_eta_dim22.py` recompõe a aritmética exata e contém as contagens esperadas como regressão obrigatória. A saída consolidada está em `resultado_subespaco_eta_dim22.json`.

Ainda não se afirma maximalidade: o espaço completo de η tem dimensão 35 e o caso geral n=32 permanece em aberto.

## 8. Reproduzir e interpretar corretamente

Use Python 3.10 ou superior. Todas as contas são inteiras; nenhum pacote externo ou GPU é necessário.

1. `python verificar_7_fibras.py` — confere o certificado curto e grava `resultado_7_fibras.json`.
2. `python verificar_fibra_antidiagonal.py` — confere as seis formas e todas as 64 possibilidades normalizadas.
3. `python verificar_classes.py` — confere os 607 certificados obtidos por fibras de posto 14 e pela fibra antidiagonal; grava `resultado_631_classes.json`.
4. `python verificar_derivadas_diagonais.py` — confere os 24 testemunhos restantes por autocorrelação diagonal e grava `resultado_derivadas_diagonais_24.json`.
5. `python verificar_subespaco_eta_paridade.py` — audita os 128 valores do subespaço de mesma paridade e confirma a cobertura completa 128/128 pela união das duas obstruções.
6. `python verificar_subespaco_eta_dim18.py` — percorre exaustivamente 2^18=262.144 quocientes de um subespaço explícito de dimensão 18 e confirma 0 sobreviventes.
7. `python verificar_subespaco_eta_dim21.py` — percorre exaustivamente 2^21=2.097.152 quocientes de um subespaço explícito de dimensão 21 e confirma 0 sobreviventes.
8. `python verificar_subespaco_eta_dim22.py` — percorre exaustivamente 2^22=4.194.304 quocientes de um subespaço explícito de dimensão 22 e confirma 0 sobreviventes.

No ambiente local, a primeira checagem levou cerca de 2,3 segundos e a checagem ampliada, cerca de 23 segundos. Os tempos dependem do computador. O notebook entregue permite reproduzir o certificado curto e a obstrução antidiagonal; não foi executado no Colab e vem sem saídas preenchidas. O pacote contém as saídas locais reais.

O arquivo `exploracao_631_classes.json` descreve sua origem como saída de busca; sua validação posterior está no arquivo separado `resultado_631_classes.json`. A validação não promove “não excluído” a “bent”, nem atesta originalidade bibliográfica.

Não houve alteração dos arquivos originais do Gemini, publicação, submissão ou comunicação externa. Os resultados são específicos a funções homogêneas cúbicas em 32 variáveis. A aplicação automática a n=32m com m ímpar exigiria tratar também os termos quadráticos que podem surgir na redução; isso não foi demonstrado nesta etapa.

## 9. Avaliação científica

O avanço é metodológico e matemático: as exclusões agora têm certificados curtos para famílias de dimensão alta, em vez de apenas taxas de rejeição de órbitas individuais ou amostras. Isso merece ser documentado e comparado com resultados anteriores.

O caso completo n=32 e a conjectura geral continuam abertos **nesta investigação**. A literatura precisa ser confrontada antes de qualquer alegação de ineditismo; em especial, não obtivemos os teoremas completos de [Sun–Shi–Liu–Fu (2026)](https://link.springer.com/article/10.1007/s10623-026-01848-4). Certificação Lean e probabilidade de aceitação editorial também não são resultados desta etapa.
