# Produto de duas quadráticas com resto cúbico: redução completa a13 casos

07/11/2026. Prova candidata de Codex, combinando os lemas de Opus com uma redução por hiperplanos e certificados finitos próprios. Ainda sem auditoria matemática externa nem pesquisa de prioridade. Não é resolução de Q1 geral ou p17.

## 1. Enunciado e escopo

Sejam Q1,Q2,R booleanas em F2^n, degQ1,degQ2<=2, degR<=3, e D=Q1Q2+R (xor). Seja I6 a propriedade de que toda restrição de D a um6-flat tem Walsh divisível8 em todos os caracteres não triviais.

**Teorema candidato.** Se D satisfazI6, pelo menos uma das três polares A=polarQ1, B=polarQ2, A+B tem posto<=8. Consequentemente D tem grau<=3 em algum flat afim de codimensão<=4.

A consequência vale porque um isotrópico de uma forma de posto2s<=8 tem codimensão s<=4. A parte quártica de D é A wedge B=A wedge(A+B)=B wedge(A+B), que se anula nesse subespaço. O restoR continua cúbico.

Sob as hipóteses espectrais Q=1 de Astra, tal flat é impossível. Portanto o teorema excluiria toda esta família no caso global Q=1, incluindo R cúbico arbitrário. Não exclui quárticas cuja parte principal não seja produto exterior de duas2-formas. A transferência inicial do problema bent às hipóteses espectrais continua separada.

## 2. Lemas de Opus usados e conferidos

Para uma booleana f de grau<=4, defina tau(f) como a soma mod2 dos produtos dos pares distintos de monômios daANF. O levantamento inteiro satisfaz l(f)=e1(f)-2tau(f) mod4. I6 implica que tau(D) tem grau<=5. Isso decorre do perfil de divisibilidade em todas as bases; não basta testar apenas o grau6 em uma base fixa de uma quártica geral.

Para D=Q1Q2+R3, os graus de tau são no máximo7, pela identidade de levantamento do produto e do xor. O grau7 é

A wedge B wedge rho3=0,                                  (G7)

onde rho3 é a parte cúbica deR.

Se R tem grau<=2, a condição de grau6 é

gamma2(A) wedge B + A wedge gamma2(B) + A wedge B wedge polarR=0.

Multiplicar por A fornece gamma3(A) wedge B=0. Se rankA>=10, essa aplicação em B tem núcleo< A >: em Darboux, três pares disjuntos isolam todo coeficiente não antipodal deB; os coeficientes nos pares têm soma zero em todo4-subconjunto, obrigando-os iguais. Logo B=0 ouA. Em particular, I6 é impossível quando os três postos são>=10 e R quadrática.

Defina K: ker(A wedge B wedge -:Lambda3->Lambda7)=A wedge Lambda1+B wedge Lambda1. Se K vale, (G7) permite escrever R=Q1L1+Q2L2+R2, comL1,L2 afins eR2 quadrática. Então D=(Q1+L2)(Q2+L1)+(R2+L1L2), de mesmas polares. O caso quadrático anterior encerra todo pencil onde K vale e os três postos são>=10. Estes são os mecanismos de Opus, reexaminados nesta coordenação.

## 3. Redução por hiperplanos: só restam dimensões10 e11

Suponha, por contradição, que os três postos sejam>=10.

Uma forma alternada F de posto10 em V, radicalN, mantém seu posto num hiperplano H=ker(l) se l|N!=0: H+N=V e a projeção H->V/N é sobrejetiva. Se H contémN, H/N é hiperplano no quociente simplético e o posto cai para8. Formas de posto>=12 perdem no máximo2, portanto continuam com posto>=10.

Se dimV=m>=12, cada forma de posto10 tem radical de dimensão m-10>=2. Os funcionais que matariam esse radical formam um subespaço do dual de tamanho2^10<=2^(m-2). A união dos conjuntos ruins de no máximo3 formas ocupa menos que todo o dual. Existe l fora dessa união. Se nenhuma forma tem posto10, escolha qualquer l!=0. Assim é possível restringir repetidamente, conservando os três postos>=10, até dimensão11. I6 e degR<=3 são hereditários por restrição.

Em dimensão11, os três postos são10 e os radicais são linhas. Existe l de valor1 nas três linhas salvo se os seus geradores u,v,w forem distintos e u+v+w=0. Se existe l, restrinja mais uma vez e obtenha dimensão10, com os três membros não degenerados.

No caso triangular, escolha radA=<u>, radB=<v>, rad(A+B)=<u+v>. Então alpha=A(v,-)=B(u,-)!=0. Escolha z comalpha(z)=1. U=<u,v,z> é um blocoL1. O complemento

W=keralpha intersect kerA(z,-) intersect kerB(z,-)

é simultaneamente ortogonal aU para ambas as formas. Os três funcionais restringem-se a uma base deU*, logo V=U directsum W e dimW=8. As três formas emW são não degeneradas, pois emU cada uma tem posto2 e no total tem posto10.

Portanto resta: um par regular não degenerado triplo em dimensão10, ou L1 mais um par regular não degenerado triplo em dimensão8. Isso é uma cobertura provada, não uma amostragem de pencils.

## 4. Classificação regular pequena, com prova em característica2

Damos a cobertura necessária sem depender de uma classificação em característica diferente de2. Seja a primeira forma A não degenerada e ponha T=A^-1 B. A simetria deB tornaT auto-adjunto paraA; a alternância deB dá A(Tx,x)=0.

Todo submódulo cíclico F2[T]x é totalmente isotrópico paraA. De fato A(T^i x,T^j x)=A(x,T^(i+j)x). Se i+j é par, essa expressão é A(T^k x,T^k x)=0; se é ímpar, é A(T^k x,T^(k+1)x)=B(T^k x,T^k x)=0.

Escolha x cujo polinômio anulador m seja o polinômio mínimo deT, de grau d. Tal vetor existe pela decomposição primária: somam-se geradores de maior ordem em cada componente primária. U=F2[T]x tem dimensão d. Escolha y com A(T^i x,y)=0 parai<d-1 e1 parai=d-1; a não degenerescência deA permite estender esse funcional deU.

Como m(T)=0 em todoV, Y=F2[T]y tem dimensão<=d. A matriz do pareamento entre T^i x eT^j y tem zeros quando i+j<d-1 euns na antidiagonal i+j=d-1; portanto é invertível. Logo dimY=d, U intersect Y=0, eU+Y é não degenerado. Y também é isotrópico pelo argumento anterior. O complemento ortogonal éT-invariante, de modo que o processo se repete.

Em bases cíclica e dual, cada bloco é (x.y, x.C(m).y), a menos de transporC, o que se resolve trocando os dois blocos de coordenadas. A decomposição primária/CRT separa m em potências p^k irredutíveis. Como B eA+B também são não degeneradas, p=t e p=t+1 são proibidos.

Assim, em dimensão10 as metades dos blocos somam5, e cada grau irreduzível é>=2. Só há:
- um irreduzível de grau5:6 escolhas;
- graus2+3:1*2 escolhas.

Em dimensão8 as metades somam4. Só há:
- irreduzível de grau4:3 escolhas;
- potência2 do irreduzível t²+t+1:1 escolha;
- dois blocos t²+t+1:1 escolha.

São8 representantes de dimensão10 e5 representantes de dimensão11 após somarL1. Não é necessário alegar unicidade da forma canônica para essa cobertura. A classificação conhecida de pares AMBOS alternados em característica2 é compatível com este argumento; referência para revisão: Waterhouse, Pacific J.Math.69(1977), p281, https://msp.org/pjm/1977/69-1/pjm-v69-n1-p21-p.pdf .

## 5. Os13 casos finitos

classifica_nucleos_minimos.py gera os polinômios irredutíveis por divisão exata e constrói todos os representantes. K vale nos8 de dimensão10 e nos3 de dimensão11 oriundos de grau4 irredutível. Seus núcleos têm dimensão20/22, iguais aos spans. verifica_catalogo_denso.py reproduz todos os13 resultados por matrizes densasGF2, com uma construção por índices diferente da implementação por máscaras. A inclusão do span no núcleo também foi verificada exatamente.

Restam2:

|pencil regular8 + L1|dimker/dimspan|extras|resultado|
|---|---|---|---|
|dois blocosF4 semissimples + L1|38/22|16|todos65536 sistemas insolúveis|
|bloco do polinômio(t²+t+1)² + L1|29/22|7|certificado universal de5 equações|

O primeiro complementa a exclusãoF4³ da entrega Opus: foi refeito independentemente por ANF simbólica. O segundo é um caso que não aparecia entre as exceções iniciais.

## 6. Certificação dos dois casos excepcionais

Por(G7), toda parte cúbica deR está no núcleo calculado. Decomponha-a em e+ A wedge l1+B wedge l2, com e no complemento de dimensão16/7. Absorver o span nos fatores produz

D=(q1+L2)(q2+L1)+R2+e.

Há2n parâmetros lineares nos fatores ebinom(n,2) quadráticos emR2. Termos afins deR2 não mudam o resíduo grau6. Para esse resíduo, c_S/2mod2 é exatamente a paridade dos pares de monômios daANF cuja união éS.

verifica_f4_simbolico.py constrói a identidade nos parâmetros por ANF e a compara coeficiente a coeficiente com sua parametrização:93 parâmetros e500 monômios paramétricos no caso semissimples;84 parâmetros e211 monômios no caso de potência2. Essa conferência é simbólica, não os100 controles aleatórios adicionais.

No caso semissimples, para cadae emF2^16 o programa resolve a condição afim nas demais incógnitas e obtém contradição. Foram guardados certificados duais para cada um dos65536 valores dee; existem178 certificados distintos, e o arquivo compactado tem cerca de20KB. reproduz_certificados_sem_solver.py verifica todos por produtos internos, sem resolver sistemas nem usar ponto flutuante.

No caso de potência2, uma combinação fixa das equações de máscaras1642,828,924,876,1708 tem lado constante1 e anula todos os coeficientes paramétricos. Isso certifica insolubilidade para todoe e todas as incógnitas restantes de uma vez.

Essas são verificações finitas exatas e reproduzíveis. Não foram formalizadas emLean nem auditadas por terceiro nesta entrega. Não omitir sua natureza computacional ao citar o teorema.

## 7. Conclusão e limites

Cada caso reduzido é impossível com os três postos>=10. A hipótese de postos altos inicial é contraditória. Logo algum posto é<=8 e há flat cúbico de codimensão<=4, como no enunciado.

Isso encerra, como prova candidata com certificados finitos, a família produto quadrático com resto cúbico sobI6. A completude da redução e o emparelhamento cíclico da seção4 são as prioridades para auditoria externa, junto dos certificados da seção6. Não chamar a prova de revisada por pares.

O LemaL para uma quártica arbitrária não foi demonstrado. O ramo par não foi abordado aqui. A passagem das hipóteses espectrais de p17 ao casoQ=1 não é reprovada por esta nota. Nenhuma prioridade bibliográfica foi investigada.

## Reprodução

Na pasta outputs/opus_r_cubico_revisao_07nov:
- python classifica_nucleos_minimos.py
- python verifica_catalogo_denso.py
- python verifica_f4_simbolico.py F4_2_L1
- python reproduz_certificados_sem_solver.py
- python verifica_f4_simbolico.py F4_J2_L1

Os JSON correspondentes registram polinômios, postos, dimensões, contagens e hashes.
