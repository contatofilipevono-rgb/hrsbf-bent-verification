# Auditoria independente de A+: posto oito e a barreira das exceções K

07/11/2026. Astra, por delegação explícita. Nota de trabalho com provas próprias e controles exatos. Não é auditoria externa publicada. Não modifica o instantâneo congelado nem encerra Q1 geral ou p=17.

**Resultado:** A+ fica provado no ramo K, e também para todo pencil de suporte comum no máximo nove, sem usar I6 neste segundo ramo. A classificação alegada das 101 exceções K, a cota de suporte quinze e a suficiência/exaustividade dos sete casos solúveis continuam não verificadas nesta nota. Não foi encontrado contraexemplo a A+.

Há ainda um exemplo explícito em dimensão doze com os três postos iguais a oito cujo produto exterior exige codimensão quatro. Portanto a hipótese espectral não pode ser descartada depois de obter a cota de posto oito. Esse exemplo **não satisfaz I6 para nenhuma correção cúbica**, como explicado abaixo.

## 1. Convenções e problema

Trabalhamos sobre F2. Se D=Q1 Q2+R, com graus dos fatores no máximo dois e grau de R no máximo três, sejam A e B suas duas formas polares, vistas como elementos de Λ²(V*). A parte de grau quatro é T=A∧B. Um subespaço H onde T se anula fornece um flat cúbico; transladar H não altera essa parte principal.

I6 significa divisibilidade por oito de todos os coeficientes de Walsh não triviais em **todo** flat afim de dimensão seis. A condição K é a igualdade

    ker(T∧− : Λ³(V*) → Λ⁷(V*)) = A∧V* + B∧V*.

Não se trata do núcleo em Λ². Escrevemos γj(A) para a potência dividida: em Darboux, se A=p1+...+ps e pi=xi∧yi, então γj(A) é a soma dos produtos de j pares distintos.

Usamos as duas consequências do levantamento inteiro já explicitadas no pacote anterior:

    I6 ⇒ A∧B∧ρ3=0;                                      (G7)

e, quando o resto já é quadrático, de polar C,

    γ2(A)∧B + A∧γ2(B) + A∧B∧C = 0.                     (G6)

A origem de G6 também é direta: no levantamento módulo quatro de Q1Q2, os termos de grau seis são os produtos da parte de grau quatro de τ(Q1) com a parte quadrática de Q2 e vice-versa; o xor com o resto acrescenta A∧B∧C. As partes afins dos fatores não alteram esses termos. G7 é a condição de grau sete antes da absorção da cúbica. A presente nota não substitui a prova anterior da passagem de I6 ao perfil de levantamento.

## 2. Lema elementar: duas formas alternadas têm um isotrópico comum grande

**Lema 1.** Em dimensão m, quaisquer duas formas alternadas A,B têm um subespaço simultaneamente isotrópico U de dimensão pelo menos ceil(m/2).

**Prova por indução.** O caso zero é vazio. Se m é ímpar, A tem radical não zero; escolha v não zero nesse radical. Se m é par, escolha qualquer v não zero. Ponha

    W = {w : A(v,w)=B(v,w)=0}.

Sempre v pertence a W. As duas formas descendem a W/<v>. Para m ímpar, dim W≥m−1, logo dim(W/<v>)≥m−2. Para m par, dim W≥m−2, logo dim(W/<v>)≥m−3; no caso m=2 a dimensão real do quociente é pelo menos zero. A indução fornece um isotrópico comum no quociente. Sua pré-imagem, acrescentando v, tem dimensão pelo menos ceil(m/2) em ambos os casos. Não é usada classificação de pencils, nem hipótese sobre o tamanho do corpo além de se tratar de formas alternadas. □

**Lema 2.** Se U é simultaneamente isotrópico, então T=A∧B se anula em U+<v> para qualquer v.

**Prova.** Em toda avaliação alternada de T em quatro vetores de U+<v>, basta considerar termos com no máximo um v. Cada partição em dois pares tem um par inteiramente em U, onde tanto A quanto B se anulam. □

**Corolário.** Para m≥2, T tem subespaço nulo de codimensão no máximo floor(m/2)−1. Se U já é todo o espaço, a codimensão é zero. Em particular, todo pencil em dimensão oito ou nove admite subespaço nulo de codimensão no máximo três, **independentemente de I6**.

Aqui é possível tomar m=dim V−dim(rad A∩rad B): as duas formas descendem ao quociente pelo radical comum, e a pré-imagem conserva a codimensão. Portanto a conclusão vale para suporte comum no máximo nove, mesmo com qualquer número de variáveis espectadoras.

Isso substitui a busca de testemunhas nulas nos cinco pencils regulares de dimensão oito por uma prova uniforme. Também cobre todos os pencils singulares de suporte no máximo nove; não é preciso conhecer suas classes. Não se pode substituir “suporte comum” pelo posto de um só membro.

## 3. O núcleo de γ3(A) em posto oito

**Lema 3.** Se rank A=8 e γ3(A)∧B=0, então B é suportada nas mesmas oito coordenadas de uma forma de Darboux de A. Nessas coordenadas, a única condição restante é

    b_(x1,y1)+b_(x2,y2)+b_(x3,y3)+b_(x4,y4)=0.

Consequentemente, o núcleo de γ3(A)∧− em Λ² tem dimensão exatamente 27, para qualquer dimensão ambiente pelo menos oito.

**Prova.** Escreva A=p1+p2+p3+p4, pi=xi∧yi, e complete por coordenadas z externas. Para um coeficiente de B da forma xi∧z ou yi∧z, multiplique pelos outros três pares. O monômio resultante contém exatamente esses três pares completos e a coordenada escolhida do quarto par; há uma única contribuição possível de γ3(A). Logo o coeficiente é zero. Para um coeficiente z∧z', use quaisquer três pares; a contribuição também é única. Assim não há termos externos nem cruzados em B.

Dentro das oito coordenadas, o alvo é Λ⁸, unidimensional. Só os quatro coeficientes nos pares completos contribuem, dando a soma exibida. Dos 28 coeficientes internos sobra um núcleo de dimensão 27. □

## 4. O ramo K não pode sobreviver com posto mínimo oito

**Proposição 4.** Se I6 e K valem, então min(rank A,rank B,rank(A+B))≤6. Em particular A+ vale neste ramo, sem a classificação das exceções.

**Prova.** Por G7 e K, escreva ρ3=A∧l1+B∧l2. Absorva esses termos nos fatores:

    D=(Q1+L2)(Q2+L1)+R2,

onde R2 tem grau no máximo dois e as polares dos fatores continuam A,B. Multiplique G6 por A. Como A∧A=0 e A∧γ2(A)=γ3(A) em F2, obtemos

    γ3(A)∧B=0.                                           (*)

Suponha que os três postos sejam pelo menos oito. Se algum membro tem posto oito, renomeie o par de geradores para que esse membro seja A. Essa troca preserva T e o espaço A∧V*+B∧V*, portanto preserva K. Pelo Lema 3, as duas formas são suportadas no mesmo espaço de oito coordenadas E.

Mas K é impossível nesse caso: o núcleo interno

    ker(T∧− : Λ³E → Λ⁷E)

tem dimensão pelo menos 56−8=48. Já a projeção de A∧V*+B∧V* sobre Λ³E tem dimensão no máximo 2·8=16. Um núcleo interno de dimensão pelo menos 48 não pode estar contido nesse espaço. Isso contradiz K.

Se os três postos são pelo menos dez, o cálculo de Darboux de (*) dá B em <A>, conforme o argumento do pacote anterior: três pares disjuntos das duas coordenadas de um coeficiente não antipodal isolam esse coeficiente; os coeficientes antipodais têm soma zero em cada conjunto de quatro pares. Com pelo menos cinco pares, comparar dois desses conjuntos força todos os coeficientes antipodais iguais. Os coeficientes externos também se anulam pelo mesmo isolamento. Logo B=0 ou B=A, contradizendo os três postos altos.

Portanto algum membro tem posto no máximo seis. Um isotrópico desse membro tem codimensão no máximo três e anula T, provando a consequência. □

**Ponto de auditoria:** o resultado “I6+posto oito força suporte oito” vale aqui **após K permitir absorver a cúbica**. Não foi demonstrado para uma cúbica arbitrária nas exceções K. Usá-lo sem essa condição seria circular.

## 5. Posto mínimo oito sozinho não dá a melhora

Considere V=P⊕Q⊕R, com cada parcela de dimensão quatro. Sejam p,q,r formas simpléticas de posto quatro nas parcelas correspondentes. Tome

    A=p+q,  B=q+r,  A+B=p+r,
    T=p∧q+p∧r+q∧r.

Os três postos são oito. **A codimensão mínima de um subespaço nulo de T é exatamente quatro.**

Existe um de codimensão quatro porque A tem posto oito. Para mostrar que não existe H de dimensão nove, suponha T|H=0.

Primeiro, nenhuma das três formas restritas a H pode ter posto pelo menos seis. Para uma forma alternada F de posto pelo menos seis, o núcleo de F∧− em Λ² é <F>: em Darboux, um terceiro par isola todo coeficiente não antipodal, os externos também se anulam, e os coeficientes nos pares são todos iguais. Assim, se uma restrição tivesse posto pelo menos seis, T|H=0 obrigaria outra das três restrições a ser zero. Porém uma forma ambiente de posto oito em dimensão doze tem isotrópico de dimensão no máximo oito, menor que dim H=9. Contradição.

Logo todos os postos restritos são no máximo quatro. A projeção de H em V/rad A tem dimensão 9−dim(H∩rad A). Em um espaço simplético de dimensão oito, a restrição a um subespaço de dimensão d tem posto pelo menos 2d−8. Portanto dim(H∩rad A)≥3; analogamente para os outros dois radicais. Esses radicais são R,P,Q, em soma direta. Segue que

    H=P'⊕Q'⊕R',  dim P'=dim Q'=dim R'=3.

As restrições p',q',r' têm posto dois, pois um subespaço de dimensão três de um espaço simplético de dimensão quatro tem posto dois. Avaliando T em dois vetores de P' emparelhados por p' e dois de Q' emparelhados por q', obtemos 1. Contradição. Subespaços maiores também são impossíveis porque conteriam um de dimensão nove. □

O controle exato em anexo calcula dim ker(T∧−:Λ³→Λ⁷)=24 e dim(A∧V*+B∧V*)=24; verifica a inclusão universal e portanto K. Pela Proposição 4, **nenhum R cúbico pode tornar esse exemplo I6**. Ele é uma barreira à extrapolação “posto oito basta”, não um contraexemplo a A+.

## 6. O que a redução por hiperplanos faz e não faz

O procedimento anterior que conserva os três postos pelo menos dez reduz legitimamente uma suposta violação da cota de posto a núcleos pequenos. Isso certifica a cota de posto quando seus casos finais são excluídos.

Entretanto, restringir um pencil de posto mínimo oito a um hiperplano e achar ali um subespaço nulo de codimensão três normalmente só fornece codimensão quatro no espaço original. A cota de suporte comum pode ser usada pelo quociente por radical comum, que não gasta codimensão; uma restrição arbitrária não tem essa propriedade. O exemplo da seção 5 demonstra concretamente por que essa distinção é necessária.

Para fechar A+ após a cota de posto oito, resta excluir ou tratar os pencils com:

1. posto mínimo exatamente oito;
2. falha de K;
3. suporte comum pelo menos dez;
4. alguma correção cúbica que satisfaça I6 completo.

Uma prova de suporte comum≤15 para as exceções tornaria essa lista finita, mas essa prova não foi recebida nem reconstruída aqui. Mesmo uma lista completa de classes exige separar os negativos certificados das buscas incompletas, e verificar os positivos em I6 completo. A condição necessária de graus seis/sete sozinha não deve ser apresentada como teste suficiente sem a justificativa de invariância correspondente.

Se todas as classes realmente solúveis tiverem suporte comum≤9, o Lema 1 encerra o último passo geométrico de uma vez. Se alguma tiver suporte maior, ela requer testemunha ou argumento adicional. Não presumimos o suporte dos “dois casos singulares solúveis” sem os arquivos originais.

## 7. Controles e limites da entrega

Execute:

    python outputs/astra_auditoria_posto8_controles.py

O JSON de mesmo nome registra:

- os 4.096 pares de formas alternadas em dimensão quatro, todos conferidos pelo algoritmo construtivo do Lema 1;
- 1.000 pares com semente fixa em dimensões de um a vinte, conferindo isotropia comum e anulação de T após acrescentar um vetor;
- o núcleo de γ3(A) em posto oito, de dimensão 27, por eliminação exata em dimensões de oito a dezesseis;
- o exemplo de dimensão doze, postos (8,8,8), núcleo e span ambos de dimensão 24.

Esses controles não são cobertura de classes em dimensão maior; as afirmações gerais são as provas acima. A cota exata de codimensão quatro do exemplo é provada algebricamente, não por enumeração dos subespaços de dimensão nove.

Foram consultados os arquivos locais `LEITURA_DOIS_LINEARES_POSTO8_07NOV.md`, `CONTROLE_INDEPENDENTE_POSTO8_07NOV.json` e `fechamento_produto_cubico_07nov/TEOREMA.md`. Não estavam disponíveis `DOIS_LINEARES_07NOV.md`, `posto8.py` e `decide2.py`. Assim, “101 exceções”, “sete solúveis” e “suporte≤15” permanecem alegações pendentes de auditoria nesta entrega.
