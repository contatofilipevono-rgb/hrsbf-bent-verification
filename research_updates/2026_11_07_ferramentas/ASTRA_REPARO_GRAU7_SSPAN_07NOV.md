# Teorema 4.2 de Argon refutado em S_span: contraexemplo e substituto seguro

07/11/2026. Trabalho Astra solicitado pelo coordenador. Originais preservados. Sem publicação e sem declaração de novidade. O verificador independente usa somente a biblioteca padrão e não usa solver.

## Veredito

**O enunciado universal do Teorema 4.2 é FALSO.** Existe uma forma em S_span, em dimensão dez, com gamma2(Delta)=0, para a qual **nenhuma** 3-forma R3 satisfaz Delta wedge R3=tau1(Delta). Um certificado dual de nove linhas prova exatamente 0=1. Portanto, a falha detectada na identidade de Leibniz não pode ser reparada conservando o enunciado universal original.

O exemplo tem 24 monômios quárticos, A0 de posto 8 e B0 de posto 6. A aplicação ell -> Delta wedge ell tem posto 10: Delta não possui fator linear. Isso o distingue do primeiro certificado Argon, que já possuía fator linear. Nenhuma dessas observações resolve Q1/p17 ou o Lema L.

## 1. Dados exatos e pertença a S_span

Trabalhamos sobre F2 e todos os produtos desta seção são exteriores. A base ordenada é

    (x1,x2,y1,y2,y3,y4,y5,y6,y7,y8).

Defina

    A0 = y2y4 + y1y6 + y5y7 + y3y8,
    B0 = y1y3 + y2y4 + y1y6 + y6y7 + y2y8,
    C  = y2y5 + y3y5 + y3y6,

    v1=y6, v2=y4, u1=y8, u2=0,
    At=A0+x1y6+x2y4,
    Bt=B0+x1y8,
    Delta=At wedge Bt+x1x2 C.

Assim Omega_res=C e

    Phi1=A0 wedge y8+B0 wedge y6,
    Phi2=B0 wedge y4,
    Omega=C+y4y8.

Por expansão,

    Delta=A0 wedge B0+x1 Phi1+x2 Phi2+x1x2 Omega,

com ambas as Phi_i no span exigido. Portanto, o exemplo está na subclasse S_span do enunciado original, sem alterar sua definição.

A máscara de um monômio é a soma de 2^i sobre os índices de suas variáveis, começando em i=0 para x1. Os parâmetros são:

    A0       = [40,132,320,528]
    B0       = [20,40,132,384,520]
    Omega_res= [72,80,144]
    v1       = [128]
    v2       = [32]
    u1       = [512]
    u2       = []

A expansão completa é

    Delta = [54,60,75,83,147,149,166,169,340,360,418,424,
             452,547,553,554,568,645,649,652,660,833,840,912].

## 2. Verificação exata da hipótese de grau oito

O produto exterior A0 wedge B0 wedge C é zero. Uma conferência direta que não depende de nenhuma identidade de potência dividida conta todos os pares distintos de monômios de Delta com suportes disjuntos.

As únicas uniões de tamanho oito que aparecem são

    [507,509,703,735,887,893,894,987,989,999,1005,1006,1020].

**Cada uma aparece exatamente duas vezes.** Todas as outras aparecem zero vezes. Logo, em F2,

    gamma2(Delta)=[tau(Delta)]8=0.

A tabela de verdade em 1024 pontos, seguida de transformação de Möbius inteira, confirma independentemente que todos os coeficientes inteiros de grau oito são divisíveis por quatro.

## 3. Certificado dual de nove linhas para a impossibilidade de G7

Escreva c_m para o coeficiente de máscara m na 3-forma arbitrária R3. Para uma máscara U de peso sete, o coeficiente de Delta wedge R3 em U é

    soma de c_(U\d) sobre todos os monômios d de Delta contidos em U.

O coeficiente de tau1(Delta) é a paridade dos pares de monômios de Delta cuja união é U. Nove equações necessárias são as seguintes; as somas são em F2.

| Máscara U | Lado esquerdo de G7 | Lado direito |
|---|---|---|
| 351 | c11+c268+c276 | 1 |
| 415 | c266+c268 | 0 |
| 575 | c7+c21+c22+c28+c515+c521 | 0 |
| 830 | c262+c276+c770+c776 | 0 |
| 855 | c22+c515+c772 | 0 |
| 861 | c21+c28+c521 | 0 |
| 911 | c259+c262+c266 | 0 |
| 919 | c7+c259+c274+c770+c772 | 0 |
| 923 | c11+c274+c776 | 0 |

Cada coeficiente cúbico da tabela ocorre exatamente duas vezes. Somar as nove equações dá

    0=1.

Esta é uma prova finita completa da impossibilidade, independente de busca, solver, amostragem ou restrição do espaço de R3. Equivalentemente, o funcional

    w = [351,415,575,830,855,861,911,919,923]

anula **todas as 120 colunas** de Delta wedge - em Lambda^3(F2^10), mas w(tau1(Delta))=1. A matriz de G7 tem posto 100 e núcleo de dimensão 20; o certificado não se limita a esse núcleo nem a um span escolhido.

Logo nenhuma escolha dos termos de graus três, dois, um e zero pode completar esta Delta para uma função que satisfaça I6, pois os termos de grau até dois não entram em G7.

O mesmo exemplo pode ser embutido em qualquer dimensão n>=10 acrescentando variáveis ausentes. As nove equações continuam válidas: um monômio cúbico que contém uma variável nova não contribui para nenhuma das nove linhas antigas. Isso não fornece uma função I6 contrária a resultados estruturais: fornece uma parte quártica que não admite completação I6.

## 4. Verificações e controles

Arquivos novos:

- `ASTRA_CONTRAEXEMPLO_G7_SSPAN_07NOV.json`: parâmetros, expansão, tau1 completo, nove linhas duais e informações de posto.
- `astra_verifica_independente_g7_07nov.py`: verificador pequeno, sem solver; usa conjuntos de índices como representação interna, diferente da busca com máscaras.
- `ASTRA_VERIFICACAO_INDEPENDENTE_G7_07NOV.json`: resultado da execução desse verificador.
- `astra_certifica_g7_07nov.py`: construção do certificado por álgebra linear; não é necessário para conferir a prova.
- `ASTRA_BUSCA_G7_07NOV.json`: proveniência da descoberta. A amostragem anterior é apenas proveniência, não fundamento da refutação.

O verificador independente conferiu:

1. A expansão exata dos parâmetros e a pertença a S_span.
2. A0 wedge B0 wedge Omega_res=0 e gamma2(Delta)=0 por contagem direta.
3. As 120 colunas cúbicas e o produto dual com tau1.
4. Os coeficientes inteiros de graus sete e oito pela tabela de verdade e Möbius, sem reutilizar a contagem de pares como algoritmo de cálculo desses coeficientes.
5. O controle negativo P=abcd, Omega=ae: P wedge Omega=0, mas P*_1 Omega=abcde; a soma de contrações proposta pelo Argon continua zero.
6. O controle positivo obrigatório de C2:

       Delta=[15,51,53,60,178,204,240],
       R3=[13,14,21,42],
       R2=[3,10,12,17,34,130,132].

   A função completa passa nos graus oito, sete e seis, no perfil inteiro módulo quatro e nos pesos de **todos os 43.180 flats afins de dimensão seis**. Portanto, a refutação atual não é uma extrapolação indevida do certificado restrito de grau seis do Argon.

O coordenador Codex também realizou uma conferência independente da versão de 24 monômios: `CONTROLE_CODEX_CONTRAEXEMPLO_ASTRA_G7_07NOV.json` e `checa_contraexemplo_astra_g7.py`. Encontrou as mesmas nove linhas duais e confirmou G7/G8 por Möbius.

## 5. Uma proposição substituta correta, com prova curta

**Proposição.** Se Omega_res pertence a span(A0,B0), então Delta é um único produto exterior de duas 2-formas. Nesse caso G7 é solúvel; não é necessário usar a identidade falsa de Leibniz.

**Demonstração.** Escreva Omega_res=a A0+b B0, a,b em F2. Então

    Delta=(At+b x1x2) wedge (Bt+a x1x2),

porque x1x2 wedge At=x1x2 wedge A0, x1x2 wedge Bt=x1x2 wedge B0 e (x1x2)^2=0.

Resta justificar G7 para um produto exterior U wedge V de 2-formas. Considere U e V como polinômios booleanos quadráticos homogêneos na base fixa e forme a função booleana f=UV. Sua parte quártica é U wedge V e sua parte cúbica é U*_1 V.

Para qualquer polinômio booleano quadrático q, o levantamento inteiro satisfaz

    lift(q) = soma dos monômios de q - 2 tau(q) (mod 4),

com tau(q) de grau no máximo quatro. Como lift(f)=lift(U) lift(V), o produto módulo quatro tem grau no máximo seis: o produto das partes de grau dois tem grau no máximo quatro, os dois produtos cruzados têm grau no máximo seis, e o produto dos dois termos multiplicados por dois desaparece módulo quatro. A redução x_i^2=x_i não aumenta grau.

Portanto os coeficientes inteiros de graus oito e sete são zero módulo quatro. Pelas contagens de uniões de monômios que dão G8 e G7,

    gamma2(U wedge V)=0,
    (U wedge V) wedge (U*_1 V)=tau1(U wedge V).

Logo R3=U*_1 V é uma solução explícita. Esta prova também substitui, para produtos de duas formas quadráticas, o argumento incorreto sobre o grau inteiro de produtos de formas lineares booleanas. QED.

O resultado acima é uma condição suficiente segura. Não se alega que seja necessária; o controle positivo anterior já mostra por que seria indevido impor Omega_res em span(A0,B0) a toda função I6.

## 6. Limites e direção útil

- O Teorema 4.1 de redução por hiperplano não é refutado. Sua identidade algébrica permanece válida, e a consequência de codimensão cinco conserva a dependência do teorema candidato dos produtos.
- Não foi provada a universalidade de G7 para a família mais restrita Phi1=Phi2=0. Para os mesmos A0,B0,C do contraexemplo, a forma Delta0=A0 wedge B0+x1x2 C **é** solúvel em G7. Uma solução de máscaras é `[19,44,67,84,104,168,196,276,324,388,552]`. Os deslocamentos em At,Bt alteram decisivamente a situação neste exemplo.
- A busca inicial construiu Omega_res diretamente no núcleo de A0 wedge B0 wedge -, em vez de depender de rejeição aleatória por G8. Foram 800 instâncias em dimensão nove sem falha e uma falha na 32ª de dimensão dez. Não se alega minimalidade da dimensão nem classificação das famílias que passam.
- O contraexemplo e o certificado são exatos; os números de amostras não são uma prova de qualquer enunciado universal positivo.
- Não se conclui Q1/p17, não se refuta o Lema L e não se afirma inexistência de todas as completações para a instância C2. O controle positivo foi preservado e reexecutado.
