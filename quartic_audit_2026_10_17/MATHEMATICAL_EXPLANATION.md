# Uma explicação matemática verificável do caso H(12,4)

## 1. Enunciado e natureza da demonstração disponível

**Resultado computacional global.** Não foi encontrada função bent no espaço H(12,4), após enumeração dos seus 2^43 vetores de coeficientes, sem leis condicionantes iniciais. A execução terminou com zero bent e seu registro completo foi auditado.

A demonstração disponível para a inexistência global é computacional: justificação de filtros necessários, cobertura completa do domínio e verificação final de Walsh. As reduções abaixo explicam parte da estrutura do cálculo e fornecem novos pontos de verificação independentes. Ainda não substituem a enumeração inteira por uma contradição analítica ou por um certificado global verificado no núcleo Lean.

Escreva f_c como a soma, em F₂, das 43 somas de órbitas quárticas, com c=(c₀,…,c₄₂). Cada suporte de tamanho quatro aparece exatamente uma vez na base, que contém 495 monômios. Os índices são os da ordem de combinações lexicográficas usada no gerador; a lista explícita consta de `linear_law_certificates.json`.

## 2. Por que há 43 condições quadráticas necessárias

Se f é bent em 12 variáveis, W_f(a)=±64 para toda frequência. Para um subespaço coordenado V_S com |S|=8, a ortogonalidade dos caracteres fornece

$$\sum_{x\in V_S}(-1)^{f(x)}=\frac1{16}\sum_{a\in V_S^\perp}W_f(a).$$

Há 16 sinais na soma da direita, cuja soma é par. Logo o lado esquerdo é divisível por oito; como ele vale 256−2 wt(f|V_S), o peso é divisível por quatro. Seu segundo bit binário é zero.

Para bits t_x, o segundo bit de Σ t_x é Σ_{x<y}t_x t_y em F₂, pela identidade de Lucas para o binomial de ordem dois. Como cada f_c(x) é linear em c, essa condição é um polinômio quadrático Q_S(c)=0, válido em todo o espaço original de 43 coordenadas.

Para colunas v_i e v_j de valores da base no subcubo, os coeficientes são:

$$[c_i]Q_S=\left\lfloor |v_i|/2\right\rfloor\bmod2,$$
$$[c_i c_j]Q_S=(|v_i|\bmod2)(|v_j|\bmod2)+|v_i\cap v_j|\bmod2.$$

As 43 órbitas cíclicas de suportes de tamanho oito dão os 43 filtros usados na busca global. Essas identidades permitem reconstruí-los sem interpolação e sem confiar no código CUDA.

## 3. Três consequências lineares com certificados pequenos

Trabalhando no anel booleano F₂[c₀,…,c₄₂]/(c_i²+c_i), combinações de Q_S e c_j Q_S produzem três identidades lineares. Cada uma é acompanhada de uma lista explícita de produtos: respectivamente 22, 1 e 24 termos.

Todo zero comum dos filtros satisfaz:

$$c_1+c_7+c_9+c_{18}+c_{24}+c_{32}+c_{34}+c_{36}=0,$$
$$c_{26}+c_{40}+c_{42}=0,$$
$$c_0+c_1+c_2+c_6+c_7+c_9+c_{12}+c_{15}+c_{18}+c_{23}+c_{24}+c_{25}+c_{32}+c_{34}+c_{36}+c_{37}=0.$$

O verificador reconstrói Q_S pela ANF original, multiplica os polinômios e cancela os monômios repetidos. Portanto as relações são verificadas como identidades, sem inferi-las de amostras ou de uma busca SAT. Elas são linearmente independentes. Não são uma autorização para impor as cinco leis da antiga busca condicionada.

## 4. A restrição de período quatro reduz o problema a quatro casos

Defina R(y)=(y,y,y) para y em F₂⁴ e g(y)=f(R(y)). Cada gerador quártico restringe-se a zero ou a uma das quatro formas

$$A(y)=y_0y_1+y_1y_2+y_2y_3+y_3y_0,$$
$$B(y)=y_0y_2+y_1y_3,$$
$$C(y)=y_0y_1y_2+y_0y_1y_3+y_0y_2y_3+y_1y_2y_3,$$
$$D(y)=y_0y_1y_2y_3.$$

Assim g=aA+bB+cC+dD. Na base original, a, b, c, d são paridades dos coeficientes com máscaras hexadecimais `0x18c8000`, `0x10000000000`, `0x2d57a733bee` e `0x40000000000`; em particular b=c₄₀ e d=c₄₂. O bit i da máscara indica a presença de c_i.

Para u≠0 em F₂⁴, considere a autocorrelação C_f(R(u)). A rotação por quatro posições tem ordem três. A parcela (−1)^{f(x)+f(x+R(u))} é constante em cada uma de suas órbitas. As órbitas não fixas têm tamanho três; os 16 pontos fixos são R(y). Portanto

$$C_f(R(u))\equiv C_g(u)\pmod3.$$

Bentness implica C_f(R(u))=0. Consequentemente C_g(u) é divisível por três em todas as 15 direções não nulas.

Entre as 16 funções aA+bB+cC+dD, apenas quatro satisfazem isso:

| Código a+2b+4c+8d | (a,b,c,d) | Tabela de verdade em bits y=0,…,15 |
|---:|---|---|
| 2 | (0,1,0,0) | `0x6ca0` |
| 3 | (1,1,0,0) | `0x7ee8` |
| 8 | (0,0,0,1) | `0x8000` |
| 15 | (1,1,1,1) | `0x9668` |

A verificação desses 16 casos é finita e pequena. Os arquivos Lean verificam os geradores, a forma normal, a classificação e a descida por órbitas. Em particular a partição cobre 4.096 pontos, com 16 pontos fixos e 1.360 órbitas de tamanho três, sem multiplicidade omitida.

Uma consequência imediata da tabela é b+c+d=1. Trata-se de uma condição afim necessária adicional, não de uma heurística de independência.

## 5. A condição W(0) torna-se uma contagem de órbitas

Das 352 órbitas cíclicas de entradas em F₂¹², 335 têm tamanho doze. As 17 restantes contêm 76 pontos e estão na união dos conjuntos de período seis e de período quatro.

No conjunto de período seis, as órbitas quárticas longas cancelam sob a involução antípoda. Restam apenas os três geradores curtos, com coeficientes c₂₆, c₄₀ e c₄₂. A identidade da seção 3 elimina c₂₆=c₄₀+c₄₂. No conjunto de período quatro, os valores são os quatro casos da seção 4. Portanto cada caso determina todos os valores nos 76 pontos de órbita curta.

Há 165 órbitas longas de peso de entrada par e 170 de peso ímpar. Denote por E e O as quantidades dessas órbitas nas quais f vale um. As condições W_f(0)=±64 e W_f(1¹²)=±64 determinam as seguintes contagens:

| Caso | Peso curto par | Peso curto ímpar | E | O | Peso total |
|---:|---:|---:|---:|---:|---:|
| 2 | 32 | 4 | 80 | 85 | 2016 |
| 3 | 36 | 4 | 85 | 85 | 2080 |
| 8 | 16 | 0 | 84 | 88 | 2080 |
| 15 | 28 | 0 | 83 | 88 | 2080 |

Com efeito, o peso total é s_par+s_ímpar+12(E+O). Além disso,

$$W_f(1^{12})=-2\big(s_{par}-s_{ímpar}+12(E-O)\big).$$

Exigir ±64, juntamente com a integridade de E e O, dá os pares da tabela. Isso permite substituir somas ponderadas em 4.096 pontos por duas condições exatas de contagem em cada caso. A redução é necessária; ainda podem existir candidatos que a satisfaçam sem serem bent.

## 6. Relação com a enumeração e com o artigo de 2026

O registro global reporta 949.760 zeros dos filtros quadráticos; 15.779 também passam W(0)=±64. Nenhum passou o Walsh completo. O log não informa a lista inteira dos sobreviventes intermediários; não se deve inventar uma classificação deles a partir das contagens.

Sun, Shi, Liu e Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, DCC 94:93 (2026), DOI 10.1007/s10623-026-01848-4, fornecem resultados parciais por órbitas, distâncias de índices e derivadas. Em n=12, os requisitos dos Teoremas 1–2 para o fator primo não se aplicam; o Teorema 4(1) exclui uma subfamília de monômios, enquanto o limiar de grau do item 4(2) é cinco, superior a quatro; os Teoremas 5–6 e o Corolário 2 tratam de funções cúbicas. O Teorema 3 também depende das restrições explícitas nos suportes escolhidos. Não há nesse artigo um enunciado de inexistência para todo H(12,4). Isso delimita a comparação com esse artigo, sem estabelecer novidade frente a toda a literatura.

O progresso verificável desta etapa é uma explicação estrutural parcial da busca e um conjunto de certificados menores. Para concluir uma prova Lean global, ainda é necessário excluir todos os candidatos nos quatro casos por condições necessárias formalizadas e um certificado completo de contradição. As buscas SAT experimentais preservadas não devem ser usadas como se esse certificado já existisse.
