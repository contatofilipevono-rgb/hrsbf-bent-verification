# Registro de pesquisa — quárticas homogêneas com simetria de rotação

Atualizado em 17/10/2026. Investigação em andamento por solicitação do usuário, incluindo alternativas e continuidade dos próximos passos. Os cálculos desta pasta foram executados em CPU. Originalidade bibliográfica ainda não estabelecida.

## Convenções

H(n,4) contém as somas em F₂ das órbitas cíclicas distintas dos monômios de grau quatro, incluindo a função zero. Cada órbita curta é somada uma única vez. C_f(a)=Σ_x (−1)^{f(x)+f(x+a)}. NL(f)=2^{n−1}−½ max_s |W_f(s)|. Q₂ soma C_f(a)² sobre **todas** as direções de peso um ou dois; E₂ soma somente os representantes cíclicos. Contagens não identificam equivalências.

## R01 — Fronteira exata entre não linearidade e energia local

**Estado: resultado computacional exaustivo.** Enumerados todos os 1.024 coeficientes em n=8 e todos os 4.194.304 em n=10. Para cada função, calculados todos os coeficientes de Walsh por representantes cíclicos e todas as autocorrelações de peso até dois. Parseval foi conferido em todo o espaço. Exemplos e casos aleatórios foram reconstruídos diretamente pela ANF.

Pares não dominados, maximizando NL e minimizando Q₂:

| n | NL | Q₂ mínimo nessa NL | Casos de igualdade |
|---|---:|---:|---:|
| 8 | 110 | 50.176 | 2 |
| 8 | 92 | 47.104 | 4 |
| 8 | 88 | 40.960 | 4 |
| 10 | 480 | 92.160 | 4 |
| 10 | 476 | 66.560 | 4 |
| 10 | 472 | 53.760 | 8 |
| 10 | 468 | 38.400 | 4 |

Em n=10, 116 funções atingem NL=480. Apenas quatro delas minimizam Q₂ dentro desse estrato. Uma representante é `0xbfedb`, com autocorrelações `(32,48,64,32,16,32)`. As minimizadoras globais de Q₂ têm NL=468. Portanto os dois objetivos não podem ser simultaneamente otimizados nessa classe.

**Verificação adicional concluída:** uma enumeração independente por código Gray reconstruiu diretamente as tabelas verdade e contou as distâncias a caracteres lineares. Concordou, para todas as 1.024 funções em n=8 e todas as 4.194.304 em n=10, nos valores individuais de NL, Q₂ e M₂. A classificação por multiplicadores também foi concluída: em n=10, os quatro pontos da fronteira possuem respectivamente 1, 1, 2 e 1 classes de igualdade sob multiplicadores coprimos com 10. As 116 funções de NL máxima formam 29 classes. Em n=8, os três pontos têm 2, 1 e 1 classes.

**Potencial editorial:** substituir uma narrativa de ausência de bent por uma classificação exata de compromissos entre duas propriedades criptográficas. Próximo passo: confrontar a literatura de perfis criptográficos e investigar equivalências mais amplas sem confundi-las com o grupo multiplicativo aqui classificado.

## R02 — Nove obstruções polinomiais de grau até cinco em n=16

**Estado: identidade demonstrável, modelo construído e validado.** Para as nove direções a₀=e₀ e a_d=e₀+e_d, 1≤d≤8, a paridade de C_f(a_d)/64 é expressa pela paridade dos emparelhamentos perfeitos de um hipergrafo de triplas em 15 vértices. Cada aresta tem coeficiente linear nos 116 coeficientes de órbitas. Resultam nove polinômios booleanos P_d de grau no máximo cinco.

PC(2) exige P₀=⋯=P₈=0. Essa condição **não é suficiente**: foi salvo um exemplo que anula as nove paridades mas tem autocorrelações não nulas. Nove outros exemplos produzem os nove vetores unitários de paridades, certificando que não há relação linear não trivial entre os P_d.

O modelo compacto tem 455 triplas por direção. Foram confrontadas 288 avaliações por emparelhamentos com contagens de tabelas verdade, todas concordantes. A expansão de P₀ possui 1.332.016 monômios booleanos após cancelamentos, com graus 2 a 5; seus valores concordaram em mais 511 palavras de coeficientes.

**Potencial:** uma entrada explícita para álgebra computacional e certificados em subfamílias. O princípio de divisibilidade por coberturas é clássico; a contribuição candidata seria sua aplicação e os certificados particulares, não a invenção do princípio. Referência contextual: [Castro et al., Divisibility of Exponential Sums via Elementary Methods](https://ccom.uprrp.edu/~labemmy/Wordpress/wp-content/uploads/2011/04/ElemDivSubnoForm.pdf).

## R03 — Ataque a C16 com direções mistas no espaço de coeficientes

**Estado: busca finita concluída, sem refutação.** Foram examinadas 64 fatias afins de dimensão 22, com geradores que alteram dois, três ou quatro coeficientes simultaneamente. A independência de cada base decorre de pivôs exclusivos. São 268.435.456 avaliações **com possível sobreposição** entre fatias. O melhor E₂ permaneceu 8.192, com vetor `(0,64,−64,0,0,0,0,0,0)` e coeficiente `0x994c638324480fb7e20526b4c174e`.

Isso fornece somente limite superior para o mínimo global. C16 permanece aberta nesta pesquisa. A busca não impôs c115=0 nem filtros necessários apenas para bentness, porque um contraexemplo a C16 pode não ser bent.

## R04 — Quase PC(2) em n=12

**Estado: exemplo verificado; duas buscas concluídas.** Palavra `0x3573f66ba26`, na ordem de órbitas do gerador, produz `(0,0,32,0,0,0,0)` para e₀,e₀+e₁,…,e₀+e₆. Logo E₂=1.024. Como 32 divide todas as autocorrelações dessas quárticas, esse é o menor valor positivo possível de E₂. A busca de 96 fatias coordenadas de dimensão 21 e a de 128 fatias mistas de dimensão 22 não encontraram energia zero. Elas correspondem a 201.326.592 e 536.870.912 avaliações, com possível sobreposição; não são contagens de funções distintas.

Não foi provado que E₂ nunca seja zero. Próximo passo: procurar contraexemplo a PC(2) em torno dessa função e em fatias mistas. Uma refutação em n=12 não refutaria C16, mas delimitaria qualquer generalização em n.

## R05 — Poucas frequências para certificar limites de não linearidade

**Estado: mínimos exatos concluídos e certificados.** Em n=8, `max(|W_f(0)|,|W_f(e₀)|)≥36` para todas as 1.024 funções. Isso certifica NL≤110 usando apenas duas frequências. Nenhuma frequência isolada, entre todos os 36 representantes cíclicos, cobre o espaço no limiar 36. A cobertura mínima tem tamanho dois.

Em n=10, o mínimo é **17 frequências** no limiar 64, correspondente a NL≤480. Uma cobertura é `{0,1,3,5,9,17,33,165,189,207,223,231,251,351,375,495,1023}`. A união foi conferida em todas as 4.194.304 funções. O limite inferior usa 1.175 funções testemunhas: a fórmula que exige cobri-las com no máximo 16 frequências é insatisfatível. O certificado DRUP tem 4.480 cláusulas adicionadas, todas conferidas por propagação unitária reversa com outro solver; a cláusula vazia foi verificada. As opções espectrais das 1.175 testemunhas foram recalculadas diretamente pela ANF.

O mínimo vale para conjuntos **fixos** de frequências individuais com esse limiar. Não é complexidade de testes adaptativos nem de combinações lineares de frequências. Pela simetria cíclica, escolher outras frequências nas mesmas órbitas não muda a cobertura. Próximo passo: reduzir o conjunto de testemunhas e buscar uma interpretação estrutural das frequências necessárias.

## R06 — As três leis de T20 por divisibilidade e códigos de órbitas

**Estado: prova concluída, com verificador independente.** Para qualquer bent em H(16,4), `c115=0` e `c57=c113`. O avanço novo nesta rodada é a segunda condição, antes conhecida apenas por varredura. Duas identidades de paridade nas fibras complementares e alternantes implicam 64 | A255 e 32 | A85. A simetria do dual sobre oito órbitas de palavras com paridade ímpar nas duas classes de posições força 64 | A0. A análise exata da forma quadrática diagonal exclui c115=1 e c57≠c113.

As identidades de paridade são lineares nos 116 coeficientes e foram conferidas na base inteira, não por amostragem. O certificado fornece apenas 16 e 32 valores por gerador; há uma tabela reduzida por multiplicadores. Um verificador separado, usando somente a biblioteca padrão do Python, reconstruiu as ações, os 116 geradores, as paridades e os 16 casos diagonais.

**Atualização:** a terceira lei também foi demonstrada. Os códigos de valores nas 4.080 órbitas completas de entradas e nas 16 órbitas da fibra complementar são auto-ortogonais e têm pesos de geradores congruentes módulo quatro. Isso implica a congruência universal `W_f(0)≡A0+A255 mod128`. Sob as primeiras duas leis, `A0/64 mod2=c99` e `A255/64 mod2` é uma forma linear nos 16 índices explícitos. Bentness força a soma dessas duas paridades a zero, reproduzindo exatamente a terceira lei de T20.

Os três vínculos independentes excluem 7/8 do espaço original. O certificado foi reconstruído por um verificador separado, que confere a base completa e todos os produtos internos relevantes. Arquivo atualizado: `T20_TRES_LEIS_PROVA.md`. Ainda não se afirma inexistência global nem novidade bibliográfica.

## R07 — Quarta condição necessária, quadrática e fatorada

**Estado: prova e verificação independente concluídas.** Após as três leis de T20, o próximo bit é `W_f(0)/128 mod2`. Ele se reduz a um polinômio com cinco termos lineares e 256 termos quadráticos; estes se fatoram em quatro produtos de formas lineares de oito coeficientes cada. A prova usa a expansão inteira do peso e a paridade de todas as interseções triplas na base após `c113=c57,c115=0`.

A condição tem c57 apenas linearmente e não depende de c113 como variável livre. Trocar simultaneamente c57 e c113 preserva as três leis anteriores e inverte a nova condição. Portanto ela rejeita exatamente metade do espaço que passa as três leis: **as quatro condições deixam 2¹¹² palavras, uma fração 1/16 do espaço original**. Exclusão necessária total: 15/16, ou 93,75%. Isso não afirma que as palavras restantes sejam bent.

As nove formas que entram na fatoração são determinadas pela restrição de posto 33 de T16. Aplicada ao pacote T19, a nova condição rejeita 4.606 dos 9.602 pais com extensões sobreviventes e 12.805.538 das 26.868.006 extensões sobreviventes, deixando 14.062.468. As contagens são exatas naquele pacote amostral, sem extrapolação global. Isso explica por que a busca T21, treinada para se anular em todos os sobreviventes computacionais, não encontrava essa lei: parte desses sobreviventes deve ser rejeitada pela condição necessária.

Arquivos: `T26_QUARTA_CONDICAO_QUADRATICA.md`, `T26_QUADRATICA_FATORADA.json`, `VERIFICAR_QUARTA_CONDICAO.py`, `T19_new_quadratic_report.json`.

## R08 — Domínio T26 menor e pacote Colab/A100

**Estado: domínio exato reproduzido em CPU; execução GPU ainda pendente.** Uma reprodução independente do prefixo T16 percorreu seus 2.097.152 estados e recuperou os 391.804 pais. A terceira lei elimina 169.200, restando 222.604. Na extensão de 12 bits, a condição quadrática é afim para cada pai: 173.056 pais admitem 2.048 extensões, 25.348 admitem 4.096 e 24.200 não admitem nenhuma.

Assim o novo domínio, antes dos filtros finais de energia e Poisson, contém **458.244.096 estados**, contra 1.604.829.184 no T16 original. Essas contagens não são quantidades de bent nem de sobreviventes finais. A parametrização evita gerar os estados que falham nas condições demonstradas.

Todos os gradientes dos 198.404 pais retidos foram conferidos em CPU, além de 98.304 estados gerados e 128 verificações pela ANF original. O pacote `GRAU4_T26_COLAB.zip` e o notebook `GRAU4_T26_A100.ipynb` incluem piloto de 16.777.216 estados, comparações GPU/CPU, checkpoints e manifesto. A100 não foi executada nesta rodada; o piloto é necessário para validar CUDA e medir desempenho real.

## R09 — Homogeneidade simultânea: piloto inteiro inconclusivo

**Estado: modelo completo formulado e controle positivo aceito; oito tentativas inconclusivas.** Foram impostas simultaneamente as 276 equações de Poisson e as 42 novas equações de homogeneidade, em 4.116 variáveis de sinal, por programação inteira. O controle positivo fixado no dual quadrático conhecido foi aceito e conferido em aritmética inteira. Cada uma de oito extensões salvas atingiu o limite de 30 segundos sem solução inteira nem certificado de inviabilidade.

Esses oito timeouts não excluem nenhum candidato e não demonstram eficácia ou insuficiência do filtro. Todas as extensões pertencem ao mesmo pai previamente salvo. Próximas alternativas são codificação pseudo-booleana nativa e condições modulares que reduzam o modelo antes de resolver. Registro: `dual_homogeneity_milp_report.json`.

## R10 — Quinta condição e domínio T27

**Estado: identidade completa e verificação independente concluídas.** O coeficiente inteiro h_f(u) da função sinal, no suporte u=0x3f3f de peso 12, deve ser divisível por 32 para uma bent. O primeiro bit de h_f(u)/8 é obtido enumerando todas as 5.775 partições de u em três quartetos. O polinômio tem apenas 67 termos e, sob as três leis lineares de T20, se fatora como `c99*(c57+ℓ_K)=0`, com K de 32 índices explícitos.

Após as quatro condições anteriores, as duas paridades desse produto são conjuntamente uniformes. Isso é demonstrado usando o parâmetro livre c23 para alternar a segunda sem afetar c99. Portanto as cinco condições deixam exatamente **3/64** das palavras originais, excluindo **61/64=95,3125%** como candidatas a bent. A prova não é uma taxa amostral e não afirma que o restante seja bent.

A condição depende apenas dos 21 bits do prefixo T16. Ela reduz o domínio T26 a **325.074.944 estados** antes dos filtros finais. No pacote T19, a quarta e a quinta condições juntas deixam **9.486.004** das 26.868.006 extensões sobreviventes. Os números T19 são específicos da amostra.

Arquivos principais: `T27_QUINTA_CONDICAO.md`, `VERIFICAR_QUINTA_CONDICAO.py`. O pacote atualizado para A100 é `GRAU4_T27_COLAB.zip`, acompanhado de `GRAU4_T27_A100.ipynb`. A lógica foi validada em CPU; execução GPU ainda pendente.

## R11 — Sistema explícito de obstruções cúbicas da ANF inteira

**Estado: modelo construído e confrontado com tabelas verdade; inviabilidade não resolvida.** Aplicou-se o critério 2-ádico clássico aos coeficientes h_f(u) da representação multilinear inteira de (−1)^f. Foram construídos os primeiros bits h_f(u)/8 mod2 para 273 órbitas de suportes de peso 11 e 116 de peso 12, totalizando 389 polinômios necessários de grau no máximo três.

Após as três substituições lineares de T20, o espaço formal de características possui 240.480 monômios e a matriz dos polinômios tem posto linear **386**. Isso é posto do espaço de polinômios, não prova de independência lógica das 386 equações. Uma combinação de grau dois reproduz a quinta condição. Foram verificadas 6.224 avaliações de polinômios por transformação de Möbius inteira independente em tabelas verdade completas.

Num piloto anterior, todas as 64 funções amostradas da parametrização pelas quatro condições falharam em alguma condição de peso 11. Isso sugere informação adicional relevante, mas não é uma taxa global nem uma prova de inviabilidade. O teste no dual quadrático conhecido passou o critério completo como controle positivo.

Próximos ataques: codificação SAT com monômios compartilhados e XOR nativo; estudo do segundo bit no suporte 0x3f3f; extração de condições de baixo grau sob subfamílias. Arquivos: `anf_cubic_obstructions.npz`, `anf_cubic_obstructions_report.json`, `anf_2adic_probe.json`.

## R12 — Família estruturada para atacar C16

**Estado: enumeração completa concluída.** As componentes homogêneas quárticas de pares de arestas dos grafos cíclicos de distâncias 1,…,8 geram uma subfamília de dimensão **28** em H(16,4). Ela contém 268.435.456 funções distintas e inclui o polinômio simétrico e4.

A enumeração percorreu 256 fatias disjuntas de dimensão 20, cobrindo a família inteira, sem impor condições que exijam bentness. **Nenhuma das funções satisfaz PC(2).** Essa é uma obstrução finita exaustiva na subfamília, não uma prova de C16 no espaço completo de dimensão 116.

Dezesseis funções passam nos primeiros oito representantes de direções e falham apenas na direção antipodal e0+e8, com autocorrelação 16.384. Todas foram reconstruídas e verificadas independentemente. Portanto a direção antipodal não pode ser omitida de nenhum conjunto fixo de testemunhas de peso até dois que cubra essa família. Essas funções têm energia alta, não melhoram o exemplo global de E₂=8.192.

Arquivos: `quadratic_product_family.json`, `quadratic_product_PC2_exhaustion.json`, `antipodal_witnesses.json`. A execução levou cerca de 169 segundos na CPU desta sessão; essa observação não é uma previsão para outros ambientes.

## R13 — Sexta condição e limite de 495/512

**Estado: identidade completa, certificado de exclusão uniforme e verificação independente concluídos.** O segundo bit h_f(0x3f3f)/16 mod2 foi construído por um código afim de valores em 2.016 órbitas de pares. Após as cinco condições, ele é representado por polinômios de grau quatro em dois ramos, com 22.063 e 29.960 monômios.

Restrições quadráticas fixas de postos dois e quatro demonstram que pelo menos 1/4 e 3/8 dos respectivos ramos são excluídos. Como eles têm medidas originais 1/32 e 1/64, as seis condições deixam **no máximo 17/512**, excluindo **pelo menos 495/512=96,6796875%**. Esse limite é rigoroso; a densidade exata da sexta condição permanece desconhecida.

O verificador reconstrói todos os coeficientes, enumera 640 perturbações afins nos dois certificados de peso mínimo e confere 512 avaliações pela ANF original. Arquivos: T28_SEXTA_CONDICAO.md, T28_SEXTA_CERTIFICADO.json, VERIFICAR_SEXTA_CONDICAO.py, T28_VERIFICACAO.json.

O piloto SAT/XOR nativo do sistema cúbico mais condições adicionais atingiu o limite de 45 segundos sem concluir; não excluiu candidatos. Relatório: cubic_native_xor_report.json. C16 e inexistência bent global continuam abertas; T28 não foi incorporada ao domínio GPU T27.

## R14 — Refinamento por radicais quadráticos

**Estado: limite rigoroso refinado e verificado por dois métodos independentes.** Nas restrições quadráticas de T28, as derivadas nas direções radicais dependem apenas das coordenadas externas e têm grau dois. Quando uma delas é um, a fatia fica exatamente equilibrada.

A densidade conjunta do conjunto excepcional foi calculada por 64 somas quadráticas no ramo zero e quatro no ramo um, sem assumir independência das equações. Ela vale 69801930767/4398046511104 e 1/4, respectivamente. Com isso as mesmas seis condições deixam no máximo **13538819371023/562949953421312**, excluindo pelo menos **97,59502256128786%** do espaço original.

A densidade exata de sobreviventes permanece desconhecida. Esse é um refinamento da análise da sexta condição, não uma sétima condição. O gerador usa eliminação de pares; o verificador independente usa uma base simplética. As 68 somas coincidiram em aritmética racional exata. Arquivos: `T29_REFINAMENTO_RADICAIS.md`, `T29_RADICAIS_CERTIFICADO.json`, `VERIFICAR_REFINAMENTO_T29.py`, `T29_VERIFICACAO.json`.

## R15 — Limite exato da sexta condição no quociente T27

**Estado: certificado simbólico completo.** As alterações de coeficientes d=e75 e e=e42+e81+e94+e106 pertencem ao núcleo dos dados das cinco fibras T16 e preservam as cinco condições anteriores. Nos dois ramos, a derivada mista do sexto polinômio nessas direções é a constante um. Assim, entre f,f+d,f+e,f+d+e há sempre funções que passam e que falham na sexta condição, todas representando o mesmo estado T27.

Portanto **a sexta condição sozinha não elimina nenhum estado adicional desse quociente**. Aplicá-la apenas ao representante canônico seria incorreto. Isso não contradiz a exclusão global de T29, que se refere às funções completas. O pacote GPU T27 permanece sem redução adicional por T28/T29.

O verificador reconstrói as órbitas, confere 2.560 avaliações nas fibras, a preservação das formas e as duas derivadas mistas. Arquivos: `T30_LIMITE_QUOCIENTE.md`, `VERIFICAR_LIMITE_QUOCIENTE_T30.py`, `T30_VERIFICACAO.json`.

## R16 — Sétima condição quadrática e limite combinado de 503/512

**Estado: identidade completa e verificação direta concluídas.** No suporte periódico 0x7777, h_f/16 mod2 é o polinômio fatorado R+(1+c99)M+(1+c57)K após as três leis lineares. Sua expansão tem 360 monômios de grau no máximo dois. A sétima condição exige que ele seja zero.

O parâmetro c5 alterna apenas esse bit, preservando as cinco condições iniciais. Assim elas e a sétima deixam exatamente 3/128 do espaço original. As duas direções do certificado T30 preservam também a sétima; seu plano garante que a sexta elimina pelo menos um quarto das funções restantes. **Todas as sete condições deixam no máximo 9/512**, excluindo **pelo menos 503/512=98,2421875%**.

O verificador reconstrói todos os coeficientes e confere 256 avaliações diretas. Arquivos: `T31_SETIMA_CONDICAO.md`, `T31_SETIMA_CERTIFICADO.json`, `VERIFICAR_SETIMA_CONDICAO_T31.py`. A densidade exata permanece desconhecida; o efeito no quociente T27 ainda não foi determinado. Os outros suportes periódicos 0x5f5f e 0x6f6f têm modelos exploratórios prontos.

## R17 — Combinação exata e exclusão de pelo menos 98,7541%

**Estado: certificado simbólico e somas racionais verificados independentemente.** A sétima condição reconstrói c5; substituí-la na sexta deixa dois domínios de medidas 1/64 e 1/128. Novas restrições quadráticas e seus radicais dão passagem global no máximo **107021121/8589934592**, excluindo pelo menos **98,75411017565057%** do espaço original. As derivadas cúbicas do ramo zero ficam quadráticas ao fixar c57, permitindo somas exatas.

Arquivos: `T32_COMBINACAO_SEIS_SETE.md`, `T32_COMBINACAO_CERTIFICADO.json`, `VERIFICAR_COMBINACAO_T32.py`, `T32_VERIFICACAO.json`. A densidade exata e a inexistência global continuam abertas.

## R18 — Domínio GPU T33: 162.537.472 estados

**Estado: redução exata e lógica em CPU verificadas; CUDA ainda não executada.** A sétima condição desce ao quociente T27 e fornece uma equação afim de extensão com máscara 0x7e. Combiná-la com Q4 deixa 65.024 pais com 1.024 extensões e 46.852 pais com 2.048, total **162.537.472**, exatamente metade do domínio T27. Foram conferidos todos os 111.876 sistemas afins, 49.152 estados em cubos selecionados e 128 ANFs originais.

Arquivos: `T33_DOMINIO_GPU.md`, `T33_DESCIDA_CERTIFICADO.json`, `VERIFICAR_DESCIDA_T33.py`, `T33_MAPPING_CPU_VALIDATION.json`. O pacote atual para A100 é `GRAU4_T33_COLAB.zip` com notebook `GRAU4_T33_A100.ipynb`. O piloto CUDA/CPU é obrigatório; GPU não foi executada. A sexta condição não foi imposta ao quociente.

## R19 — Piloto SAT com os quatro suportes periódicos

**Estado: inconclusivo.** O sistema nativo XOR foi reforçado com a sétima condição e os segundos bits nos suportes 0x5f5f e 0x6f6f. Ele contém 240.494 variáveis, 721.134 cláusulas AND e 397 equações XOR. Atingiu o limite de 45 segundos sem SAT nem UNSAT. Não excluiu candidatos e não produziu certificado de inviabilidade. Relatório: `SAT_periodic_refinement_report.json`.

## R20 — Forma normal em onze paridades

**Estado: equivalência exata e contagem completa verificadas.** As três leis lineares e as condições quarta, quinta e sétima foram reunidas em 11 paridades agregadas. Depois das três leis, bastam nove bits livres, a proibição b=1 e a≠K, e duas fórmulas que reconstroem t,R. A enumeração tem somente 512 casos, com 384 válidos. O posto conjunto das três leis e das 11 formas é 14, deixando um núcleo linear de dimensão 102.

Isso recupera a fração exata 3/128 por uma prova pequena e organiza a apresentação sem alterar os resultados. O núcleo não é irrelevante para bentness nem para as outras condições. Arquivos: `T34_FORMA_NORMAL.md`, `VERIFICAR_FORMA_NORMAL_T34.py`, `T34_FORMA_NORMAL_VERIFICACAO.json`. A página inicial foi reescrita para mostrar o estado atual sem acumular números históricos contraditórios fora de contexto.

## R21 — Nove condições, um lema vetorial e exclusão de 99,6274%

**Estado: polinômios completos e 4.800 somas conferidos por método independente.** Aos sete filtros anteriores foram acrescentados os segundos bits nos suportes periódicos 0x5f5f e 0x6f6f. Os três bits em 0x3f3f, 0x5f5f e 0x6f6f foram analisados conjuntamente, após a forma normal de seis condições, em uma mesma restrição quadrática nas coordenadas {27,64,73,77,88,92,112}.

Um lema de caracteres vetoriais reduz a passagem conjunta a sete módulos de somas quadráticas. As densidades radicais são calculadas exatamente, condicionando no máximo três coordenadas externas para obter somas quadráticas. A fração global que pode passar é no máximo **2097035386883/562949953421312**, excluindo pelo menos **99,6274916848046%**. Isso não é densidade exata nem inexistência global.

O primeiro verificador reconstrói 226.930 termos de coeficientes dos seis modelos de ramos e confere 192 avaliações da ANF original. O segundo confere todos os postos, bases radicais, derivadas e 4.800 somas quadráticas por base simplética, independente da eliminação de pares usada na geração. Arquivos: `T35_NOVE_CONDICOES.md`, `VERIFICAR_POLINOMIOS_T35.py`, `VERIFICAR_LIMITE_CONJUNTO_T35.py` e seus certificados/relatórios.

O mesmo lema com apenas um bit contém T28/T29/T32, simplificando a organização das provas. O domínio GPU continua em T33; os dois novos bits ainda não foram incorporados ao quociente. Novidade bibliográfica continua não estabelecida.

## R22 — Limite superior da exclusão pelos nove testes

**Estado: consequência racional exata da prova vetorial.** A desigualdade triangular usada em T35 também dá um limite inferior positivo para a quantidade que passa em todos os nove testes. A exclusão real está rigorosamente entre **99,6274916848046% e 99,7865708151954%**. Portanto os mesmos nove filtros não podem atingir 99,9%, mesmo com análise perfeita.

A direção seguinte deve incorporar condições não redundantes ou outro argumento que exclua funções ainda aprovadas. O limite inferior não afirma existência de bent. Arquivos: `T36_LIMITE_DAS_NOVE_CONDICOES.md`, `VERIFICAR_INTERVALO_T36.py`, `T36_INTERVALO_VERIFICACAO.json`. A cadeia de base continua sendo a reconstrução completa e as 4.800 verificações de T35.

## R23 — Teste sobre candidatos aprovados e condição adicional não redundante

**Estado: piloto separado em descoberta/validação e testemunha exata certificada.** Foram geradas 512 funções que passam nas nove condições; 256 para descoberta e 256 para validação. O suporte 0x33ff, de peso 12, fornece uma condição cúbica de 4.748 monômios e rejeitou 139/256 na descoberta e 129/256 na validação. As contagens são apenas da amostra, sem atualização do percentual global.

A palavra 0x18649e30a3513dbc1231f902c2da passa nas nove condições mas tem h_f(0x33ff)=−120, incompatível com a divisibilidade por 32 exigida de bentness. Isso prova que a condição adicional não é implicada pelas nove anteriores. A mesma função também falha no suporte de peso 11 0x5e9f, com valor 168 não divisível por 16.

O verificador padrão reconstrói as 5.775 partições, confere todo o polinômio e avalia diretamente 14.432 pontos da ANF original para os seis suportes usados. Todas as 512 funções falharam em alguma das 389 obstruções; esse resultado finito não prova exclusão global. Arquivos: `T37_TESTE_PARA_NOVAS_CONDICOES.md`, `T37_TESTE_APOS_NOVE.json`, `T37_NOVA_CONDICAO_CERTIFICADO.json`, `VERIFICAR_NOVA_CONDICAO_T37.py`, `T37_NOVA_CONDICAO_VERIFICACAO.json`.

Próximo teste prioritário: simplificar a condição 0x33ff sob a forma normal e demonstrar seu efeito global, em vez de apenas ampliar amostras.

## R24 — A condição adicional normalizada

**Estado: substituição completa e 64 avaliações originais verificadas.** O filtro do suporte 0x33ff foi transformado para os dois ramos da forma normal: 16.009 monômios de grau até quatro e 14.547 de grau até três. O certificado público reconstrói as substituições dos coeficientes 0,57,23,5, usando as relações já demonstradas. Arquivos: `T38_MODELOS_CERTIFICADO.json`, `VERIFICAR_MODELOS_T38.py`, `T38_MODELOS_VERIFICACAO.json`.

## R25 — Dez condições e exclusão de pelo menos 99,8147%

**Estado: prova com 4.880 somas independentes e 51 conferências de espaços de equações.** Usar uma restrição diferente para cada caráter permite combinar o filtro adicional sem enfraquecer os anteriores. As equações radicais foram reduzidas por igualdade exata de seus espaços lineares de polinômios, preservando o conjunto de zeros.

A passagem global é no máximo 34171368508165259/18446744073709551616. A exclusão real pelos dez filtros está entre **99,81475664013322% e 99,89227460986677%**. O teto indica que novos filtros ainda são necessários para alcançar 99,9%. Arquivos: `T39_DEZ_CONDICOES.md`, `T39_RESTRICOES_CERTIFICADO.json`, `VERIFICAR_RESTRICOES_T39.py`, `T39_RESTRICOES_VERIFICACAO.json`. Não há prova de inexistência global nem execução GPU nova.

## R26 — Treze condições e meta de 99,9% superada

**Estado: demonstrado e verificado independentemente.** Os quatro suportes 0x33ff, 0x66ff, 0x73bf, 0x76ef formam uma família sob as oito unidades módulo 16. Suas condições, somadas às nove anteriores, deixam sete bits além do núcleo; seus 127 caracteres são agrupados em 43 órbitas. Simetria, oito modelos normalizados e 256 avaliações originais foram conferidos.

A passagem global é no máximo **1310509920535861/2305843009213693952**, ou exclusão de pelo menos **99,94316569188364%**. O verificador independente passou em 18.080 somas quadráticas e 173 conferências de espaços de equações. Subconjuntos de equações radicais dão limites superiores seguros, sem presumir equivalência ao sistema completo. Arquivos: `T40_TREZE_CONDICOES.md` e certificados/verificadores T40. Não há inexistência global demonstrada nem execução GPU nova.

## R27 — Amplitude Walsh exata em zero

**Estado: identidade e controles verificados; busca inconclusiva.** Sob T20, W(0)=65536−128a−192b−32w, onde w conta 4.080 órbitas completas com valor um. A necessidade W(0)=±256 equivale a w=2040−4a−6b+16σ. O teste elimina a função zero, admitida pelos filtros homogêneos.

Foram conferidos os 116 geradores, órbitas, controles positivos/negativos e semântica dos somadores. Dois pilotos SAT reforçados, de 60 segundos cada, terminaram sem conclusão e não forneceram exclusão. Arquivos: `T41_TESTE_WALSH_EXATO.md`, `T41_IDENTIDADE_VERIFICACAO.json`, `T41_SAT_REFORCADO_RESULTADOS.json`.

## R28 — Informação adicional depois das treze condições

**Estado: não implicação certificada, taxa global ainda desconhecida.** A condição 0x27ff tem 5.498 monômios cúbicos após as três leis. Um exemplo não nulo passa nas treze condições e falha nela, com h=-216; também tem W(0)=1280. Foram reconstruídas 5.775 partições e avaliados diretamente todos os 65.536 pontos. A amostra anterior deixou 26 sobreviventes das treze condições: dez de descoberta e dezesseis de validação. Selecionada pela menor expressão na descoberta, 0x27ff rejeitou 7/10 e 9/16. Essas contagens não são taxas globais. O melhor filtro na descoberta, 0x65ff, rejeitou 9/10 e apenas 5/16 na validação. Arquivos T45.

**Alternativa normalizada em investigação:** substituir o núcleo em 0x27ff produz 80.144 termos até grau cinco no ramo zero e 63.146 até grau quatro no ramo um. Acrescentar esse suporte sozinho quebra a simetria útil de quatro elementos; uma família completa teria mais três suportes. Por isso refinar os caracteres atuais pode ser mais simples antes de ampliar o conjunto.

## R29 — Refinamento por diferenças finitas: 99,96433819%

**Estado: cadeia T40 → T43 → T44 verificada integralmente.** A média dos quadrados das médias nas classes de um subespaço limita o quadrado do viés. Direções com diferenças quadráticas transformam essa média em um limite baseado nos postos polares. Foram usadas bases de dimensão 16; todas as 65.535 combinações não nulas de cada base foram conferidas. T43 verifica 14 casos e T44 mais oito, totalizando 352 matrizes básicas reconstruídas e 1.441.770 postos.

Fixar c57 e uma paridade u2, incluindo todas as quatro fibras, trata dois caracteres difíceis no ramo zero. A fração global aprovada é no máximo **822305287179573/2305843009213693952**, dando exclusão de pelo menos **99,96433819284774%**. As condições continuam sendo treze; a melhoria vem da prova, não de impor valores de paridades como filtros. Arquivos: `T44_LIMITE_POR_DIFERENCAS.md` e certificados/verificadores/relatórios T43/T44.

## R30 — Nova condição invariante com grau reduzido

**Estado: informação adicional certificada, sem nova taxa global.** A soma dos primeiros bits de 0x27ff,0x6edf,0x39ff,0x5eef preserva as oito ações por unidades módulo 16 e cancela os termos de grau cinco do ramo zero. Os modelos normalizados têm 71.568/62.152 termos, ambos de grau quatro. Um exemplo passa nas treze condições anteriores e falha nessa soma. O verificador T48 passou em 23.100 partições, oito invariâncias, duas substituições completas e 20.944 avaliações originais para a testemunha. A amostra rejeitou 13/26 sobreviventes; essa contagem não é taxa global. Arquivos: `T48_CONDICAO_INVARIANTE.md` e certificados/verificadores T48.

## R31 — Mais representantes refinados: 99,96808978%

**Estado: 17 casos adicionais verificados independentemente.** O limite de passagem é 2943198307753433/9223372036854775808, menor que 7/20000. Exclusão de pelo menos 99,96808978000678%. T47 reconstrói 272 matrizes básicas e confere 1.114.095 postos. A cadeia T43/T44/T47 totaliza 2.555.865 postos. As condições continuam sendo treze. Arquivos: `T47_REFINAMENTO_SEM_NOVOS_FILTROS.md` e certificados/verificador/relatório T47.

## R32 — Auditoria, orçamento e limites do método

**Estado: correção de apresentação incorporada, princípio geral escrito, otimização em conferência.** O decimal T40 foi truncado para baixo; frações e argumentos exatos não mudaram. Os verificadores usam arredondamento na direção segura, testado em 132 intervalos. O usuário informou confirmação externa de T40 com PASS. A exposição distingue nove, dez e treze condições e não presume conclusão externa de T43/T44.

`T54_METODO_GERAL.md` apresenta o agrupamento por órbitas com sinais, métodos de folhas intercambiáveis, partições afins e orçamento adaptativo. O patamar de 99,981689453125% é uma limitação da forma de estimativa, não do conjunto real. Foram conferidos exaustivamente 4.096 casos do lema de diferenças e todas as 256 funções de duas entradas e duas saídas para o agrupamento com sinais. Esses testes não substituem as provas gerais.

Um planejador encontrou um certificado com garantia acima de 99,96% e custo abstrato estimado menor; o verificador misto T55 está em execução. O profiler externo está executando um piloto e deverá calibrar o custo. Arquivos T53/T54, `work/T50_certificate_budget_plans.json` e certificado/verificador T55 ainda pendente.

## Alternativas seguintes, em ordem de utilidade

1. Levantar o próximo bit de Walsh e aplicar o critério 2-ádico completo dos coeficientes inteiros da ANF, para obter condições adicionais de baixo grau.
2. Executar o piloto T33 na A100 quando houver uma sessão disponível, conferir o resultado e só então completar a nova varredura finita.
3. Comparar integralmente a literatura de inexistência e decidir entre um manuscrito teórico sobre congruências e outro computacional sobre fronteiras/certificados espectrais.
4. Reduzir o certificado inferior de 17 frequências e buscar sua interpretação estrutural.
5. Atacar o exemplo quase PC(2) de R04 e subfamílias exatas; não impor condições necessárias apenas para bentness ao tentar refutar C16.
6. Retomar R09 com uma codificação apropriada e limites explícitos; timeouts permanecem inconclusivos.
7. Explorar generalizações das congruências periódicas a n=32 sem extrapolar os resultados específicos de n=16.

## Bibliografia e limites de novidade

A conjectura geral de ausência de bent homogêneas RS de grau maior que dois é anterior a esta pesquisa: [Stănică e Maitra, 2008](https://doi.org/10.1016/j.dam.2007.04.029). O artigo [Sun, Shi, Liu e Fu, 2026](https://link.springer.com/article/10.1007/s10623-026-01848-4) anuncia novos resultados parciais usando derivadas e não linearidade. O resumo foi acessado; o texto integral não estava disponível nessa consulta. Portanto, novidade de R01–R05 ainda não pode ser reivindicada.

## Continuidade

### T75–T83: projeção por paridades, contadores compartilhados e estrutura ímpar

- A identidade geral pi_d(x)=XOR dos blocos de d bits reduz Walsh em frequências repetidas à transformada da soma de sinais em cada fibra. Em n=16, seis contadores produzem as seis frequências de período até 4; 35 contadores não vazios produzem as 36 de período até 8. A geometria completa e 587 transformadas originais foram verificadas independentemente.
- A nova codificação usa 19732 variáveis auxiliares para seis congruências, 26828 para 36 e 20115 para seis amplitudes exatas. Esses números medem tamanho, não desempenho geral do solver. Passaram os controles originais e 1024 atribuições pequenas; a versão de 36 passou em 540 valores de contadores e 540 testes de frequências individuais.
- Amostra nova fixa, semente 2026101776: 8192 nove-passantes, 527 treze-passantes, 261 após C0, 129 após C0+C2, 31 após seis congruências e zero após 36. Nenhum dos 527 passou pelas seis amplitudes exatas. Todos esses números são amostrais. A seleção feita nos dados antigos escolheu 0x6f6f e 0x2d2d e zerou nove exemplos; nos dados novos deixou 31→5→2, preservados como exemplos da limitação da seleção.
- Foram comprovadas divisibilidades por 8 das duas classes ímpares de pi_4, de pesos 1 e 3, por 116 pesos, 6670 pares e 253460 triplas em cada classe. Isso prova, para qualquer hipotética bent de H(16,4), W(0)=W(1^16), total ímpar 1024 e pares de contagens (504,520), (512,512) ou (520,504). Verificador público T80: PASS.
- A tabela completa das seis amplitudes exatas possui 32 perfis por (a,b), 128 ao todo após divisibilidade; verificador independente T81: PASS. A codificação da tabela passou em 256 controles positivos ou mutados.
- O piloto SAT com o núcleo de seis condições e seis amplitudes exatas encontrou modelos nos dois ramos, em 7,48 e 15,78 segundos de solução. O modelo b=0, c=0x530947633e72251c0345fef412326, passa também pelas treze condições, mas W(0x0101)=1024; o espectro completo confirma que não é bent. O modelo b=1 falha nas nove condições. Ambos foram reconstruídos e conferidos independentemente. Isso valida o modelo e demonstra que treze condições mais seis amplitudes não bastam.
- A relaxação que trata contadores como livres é viável. Operações modulares invertíveis verificadas mostram 2^12 soluções entre 2^31 resíduos para d=4 e 2^136 entre 2^237 para d=8, nos quatro pares (a,b). Não inferir densidades de funções dessas razões. A dificuldade é realizar os contadores por um mesmo vetor de coeficientes.
- Relatório consolidado: T75_CONTADORES_COMPARTILHADOS_E_NOVA_ESTRUTURA.md. O melhor limite global T47 permanece inalterado; não há prova de inexistência global.

### T68–T74: redundâncias removidas e dois acréscimos modulares

- A expansão do primeiro bit não automático da frequência 0x0101 possui aproximadamente 2,95 milhões de monômios por ramo. Foi descartada como representação compacta; o cálculo completo ficou como intermediário de trabalho.
- Foi demonstrada e verificada independentemente a identidade W(0x5555)≡128*Q4 (mod256), sob as três leis T20. A condição quadrática resultante de 205/197 termos é redundante.
- A auditoria completa de interseções dos geradores provou w_ímpar≡0 (mod8), implicando W(0)≡W(1^16) (mod512) sob as três leis. Não se conta a segunda congruência como novo bit.
- Foram derivadas C0: w+4a+6b≡8 (mod16) e C2: z+4a+6b≡8 (mod16), com w contando todas as órbitas completas em que f=1 e z contando as órbitas completas de peso par em que f difere da paridade das posições pares. Há exemplos não nulos mostrando a não implicação nos dois sentidos junto com as treze condições antigas. Os exemplos foram reconstruídos e verificados.
- Na amostra fixa de 4096 nove-passantes, 229 passaram pelas treze condições; C0 deixou 113 e C0+C2 deixou 60. Esses números são amostrais, e os 60 exemplos demonstram que o sistema ampliado ainda admite soluções.
- A codificação dos dois acréscimos usa contadores de quatro bits. O componente C2 tem 9620 variáveis auxiliares e 16699 cláusulas CNF. O teste conjunto passou em oito controles; não foi demonstrada melhora de tempo de solução.
- A proposta antipodal recebida contém uma anulação falsa: Q8|V7=a(y1+y3+y5+y7)+b(y2+y6) no núcleo. Foram verificados um contraexemplo à anulação e um exemplo de posto 14. O critério geral proposto sobre ausência de estruturas lineares nas derivadas também é falso.
- Evidências públicas: T72_AVANCO_MODULAR_E_SIMPLIFICACAO.md, T72_CONDICOES_MODULARES_VERIFICACAO.json, T70_REDUCAO_QUADRATICA_VERIFICACAO.json e AVALIACAO_ROTA_ANTIPODAL.md. Nenhum desses resultados altera o melhor limite global T47 nem prova inexistência.

O usuário autorizou continuar os próximos passos e investigar enquanto houver crédito na janela de cinco horas. A consulta inicial desta rodada informou 7% consumidos na janela de 300 minutos e 69% no limite semanal. Isso registra disponibilidade naquele instante, não garante cinco horas contínuas de execução nem autoriza consumo de créditos de reset.

### T84–T85: novo filtro e busca conjunta
Forma normal de 0x7f7f reproduzida e conferida em 527 funções. Modelo conjunto com treze condições, seis amplitudes exatas, 36 congruências e h(0x7f7f) mod128 implementado; reduzido para 78.582/78.549 variáveis. Controles completos PASS nos dois ramos. Pilotos de 45 segundos inconclusivos; T47 permanece o melhor limite auditado. Relatório: T85_BUSCA_CONJUNTA_VALIDADA.md. Nenhum processo deixado em execução.

### T87–T88: auditoria adversarial do pacote Gemini
ZIP original recuperado e 68 hashes conferidos. Enumerações n=8/10 e aritmética da cota Top26 reproduzidas; postos Top26 ainda pendentes. Encontrados erros na identidade de Poisson, no argumento diagonal da congruência de defeito 1 e no reaproveitamento de uma matriz polar de fatia; o último caso foi recalculado e sua correção não piora a amplitude usada. Avanço positivo: todas as 8.436 componentes cúbicas em U38 foram verificadas, confirmando exatamente 26 combinações quadráticas nos cosets. Relatório: AUDITORIA_ADVERSARIAL_GEMINI_T87_T88.md.

### T89–T95: nova redução e cota global verificada
As 26 matrizes quadráticas em U38 têm aplicação afim de posto conjunto 16 no espaço original e 15 em cada ramo T20. Todos os 32.768 estados por ramo foram enumerados. Pesos exatos do núcleo C7 somam 13/1024. Sete combinações adicionais produziram passagem <=58424985/2^39 e exclusão segura >=99,9893725571%. Todos os 127 histogramas de caracteres foram conferidos por eliminação de postos e cálculo dos pesos independentes, com PASS em T94. Não depende das amplitudes Top26 do Gemini. T93 conferiu 624 entradas matriciais nas funções originais. Relatório: T95_REDUCAO_U38_E_LIMITE_GLOBAL.md. Uma oitava condição está sendo investigada como extensão incremental, sem substituir o resultado verificado antes de terminar.

### T96–T99: extensão para oito condições e pacote isolado
Oitava combinação quadrática acrescentada, reutilizando os 127 caracteres já conferidos. Os 128 caracteres novos foram enumerados em todos os estados de peso não nulo dos dois ramos, com comparação exata entre eliminações por pivôs altos e baixos. Novo melhor limite global: passagem <=2011309/2^35; exclusão segura >=99,9941463203%. As 26 matrizes dependem de 16 blocos disjuntos de quatro coeficientes, com uma paridade fixada por b, restando quinze parâmetros. Pacote PACOTE_U38_LIMITE_VERIFICADO.zip contém 43 arquivos com manifesto; todos os hashes e CRCs passaram. Em extração isolada, a checagem da cadeia e a reprodução completa dos 8.436 coeficientes cúbicos passaram. Não há prova de inexistência global. Nenhum processo deixado rodando.

### T100–T105: auditoria do pacote final Gemini W98/H12
Original ZIP recuperado com hash fa22426b73838a80bc782d971839130b20bbdb0e4281928f1904f66d9a7e8c15; Downloads estava convertido como UTF-8. W98 tem dimensão98, contém U38, preserva C7 e admite17 combinações quadráticas dependentes de8paridades, confirmado simbolicamente. Porém o verificador omite termos quadráticos de monômios cúbicos após substituição booleana: todos os17 B_const corretos sãozero, enquanto o código produz postos12..32. Contraexemplo independente padrão Python confirma previsão1 versus segunda diferença0. A fração2284269821/2^45 foi reproduzida no programa, mas sua certificação matemática fica pendente dessa correção. Na célula p8=0, passagem é1/2 e não1/1024; existe subespaço102dim de densidade1/16384 que passa C7+17 condições. H12: cinco leis iniciais hardcoded sem certificado no pacote; sobelas, graus quadráticos e duas leis novas foram certificados, deixando36variáveis, sem enumeração. Melhor limite global mantém2011309/2^35 e >=99,9941463203%. Relatório AUDITORIA_PACOTE_FINAL_GEMINI_T100_T104.md e pacote CONTRAEXEMPLOS_E_AUDITORIA_GEMINI_FINAL.zip. Nenhum processo desta auditoria deixado em execução.


## H12 global — auditoria T110/T111 (2026-10-17)

Recebido ZIP completo da busca global em43 coeficientes, baseidentidade, semcincoleis. Fontealgoritmo/tabelasiguaisapreparada; diferenças apenas2linhasembrancoe limitepadrão40→90min. AuditoriaintegralPASS:8.388.608lotescontíguos,2^43=8.796.093.022.208candidatos,949.760sobreviventesquadráticos,15.779W0,zeroBent. ReconstruçãoindependenteviaANFMöbiusecarryverificou43colunas,1.849coeflineares,38.829quadráticos. Evidência computacional global de inexistência em H(12,4); GPU não reenumerada localmente e não é certificado formal de cada operação. Repetição independente recomendada para publicação. Não resolve H16 nem conjectura geral. Relatório H12_RESULTADO_GLOBAL_AUDITADO.md; pacote PACOTE_H12_GLOBAL_AUDITADO.zip preserva original + auditoria.
