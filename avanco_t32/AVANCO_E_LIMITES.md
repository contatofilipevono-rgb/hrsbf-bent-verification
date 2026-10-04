# Avanço parcial em 32 variáveis: obstruções por fibras quadráticas

**Resultado desta etapa:** obtivemos certificados exatos de não-bentness para famílias inteiras de funções cúbicas homogêneas com simetria de rotação em 32 variáveis. O menor certificado apresentado usa sete condições necessárias cuja soma em F₂ é **0=1**. Uma implementação separada da busca confirmou o certificado diretamente nas ANFs originais.

Este é um avanço em relação ao material anteriormente auditado. **A originalidade perante a literatura não está estabelecida. Não resolvemos o caso geral n=32.** A afirmação principal abaixo é uma exclusão parcial assistida por computação, com condições e arquivos reproduzíveis.

## 1. O que foi demonstrado e verificado

| Resultado | Alcance | Evidência |
|---|---|---|
| Decomposição dos 155 coeficientes em um parâmetro de dimensão 35 e 120 graus de liberdade por fibra desse parâmetro | Todo o espaço cúbico homogêneo RS em 32 variáveis | Argumento algébrico e conferência das 155 formas polares originais nas 16 direções básicas |
| Fibra antidiagonal | Exclui um subespaço de dimensão 149: 2¹⁴⁹ vetores de coeficientes, incluindo zero | Prova estrutural; seis formas lineares explícitas; classificação exata das 64 fibras módulo constantes |
| Certificado de sete fibras | Exclui os 2¹²⁰ membros da família cujo parâmetro é a órbita cúbica contígua em 16 variáveis | Sete formas lineares somam zero e seriam todas iguais a um se a função fosse bent |
| Todas as classes com até duas órbitas ativas no parâmetro de 35 coordenadas | 607 das 631 classes excluídas; cada classe tem 2¹²⁰ funções | 19 exclusões antidiagonais e 588 contradições lineares; 30.038 equações conferidas |
| Estrutura dos 24 casos restantes nesse recorte | Todos pertencem ao subespaço de dimensão sete de triplas de mesma paridade | Classificação dos representantes e identificação algébrica do motivo pelo qual o posto 14 não aparece |

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

## 7. Ampliação e limite encontrado

Foram examinados todos os 1+35+595=631 valores de η com peso no máximo dois. O arquivo de busca conserva os certificados; o programa `verificar_classes.py` recalcula suas equações usando as ANFs originais. O resultado foi:

- 19 classes excluídas por B_J=0;
- 588 classes excluídas por contradição linear;
- 24 classes não excluídas por esse procedimento.

As 24 restantes são combinações das sete órbitas representadas por 024, 026, 028, 02(10), 02(12), 048 e 04(10), em índices módulo 16. Todas as triplas têm índices da mesma paridade. Para h nesse subespaço, a 3-forma se separa nos oito índices pares e nos oito ímpares. Cada contração não nula em um bloco de dimensão oito é alternada e tem um vetor não nulo no radical, portanto posto no máximo seis. A matriz inteira tem posto no máximo 12. Se a direção em um bloco for zero, esse bloco da contração é zero. **O teste baseado em posto 14 não pode tratar esse subespaço.**

Nesse subespaço de 128 valores de η, a contração por J tem posto dois como aplicação sobre os parâmetros: 32 valores são excluídos pela fibra antidiagonal e 96 passam por ela. Isso não estabelece a existência de funções bent para nenhum deles.

O próximo alvo matemático concreto é tratar radicais de dimensão quatro ou maior. Neles, balanceamento exige que pelo menos uma das avaliações em uma base do radical seja um, o que fornece disjunções de equações lineares. Um resolvedor com certificado, ou uma identidade estrutural que combine essas condições, pode avançar sobre os casos restantes. Outro alvo é caracterizar para quais η os certificados de posto 14 existem; ainda não foi demonstrado que todos os valores fora do subespaço de mesma paridade sejam excluídos.

## 8. Reproduzir e interpretar corretamente

Use Python 3.10 ou superior. Todas as contas são inteiras; nenhum pacote externo ou GPU é necessário.

1. `python verificar_7_fibras.py` — confere o certificado curto e grava `resultado_7_fibras.json`.
2. `python verificar_fibra_antidiagonal.py` — confere as seis formas e todas as 64 possibilidades normalizadas.
3. `python verificar_classes.py` — confere os certificados de todas as classes excluídas no recorte de 631; grava `resultado_631_classes.json`.

No ambiente local, a primeira checagem levou cerca de 2,3 segundos e a checagem ampliada, cerca de 23 segundos. Os tempos dependem do computador. O notebook entregue permite reproduzir o certificado curto e a obstrução antidiagonal; não foi executado no Colab e vem sem saídas preenchidas. O pacote contém as saídas locais reais.

O arquivo `exploracao_631_classes.json` descreve sua origem como saída de busca; sua validação posterior está no arquivo separado `resultado_631_classes.json`. A validação não promove “não excluído” a “bent”, nem atesta originalidade bibliográfica.

Não houve alteração dos arquivos originais do Gemini, publicação, submissão ou comunicação externa. Os resultados são específicos a funções homogêneas cúbicas em 32 variáveis. A aplicação automática a n=32m com m ímpar exigiria tratar também os termos quadráticos que podem surgir na redução; isso não foi demonstrado nesta etapa.

## 9. Avaliação científica

O avanço é metodológico e matemático: as exclusões agora têm certificados curtos para famílias de dimensão alta, em vez de apenas taxas de rejeição de órbitas individuais ou amostras. Isso merece ser documentado e comparado com resultados anteriores.

O caso completo n=32 e a conjectura geral continuam abertos **nesta investigação**. A literatura precisa ser confrontada antes de qualquer alegação de ineditismo; em especial, não obtivemos os teoremas completos de [Sun–Shi–Liu–Fu (2026)](https://link.springer.com/article/10.1007/s10623-026-01848-4). Certificação Lean e probabilidade de aceitação editorial também não são resultados desta etapa.
