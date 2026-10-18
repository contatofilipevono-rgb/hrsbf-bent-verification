# Duas condições lineares necessárias para bentness em H(16,4)

Resultado obtido em 17/10/2026. A demonstração combina argumentos de simetria e formas quadráticas com duas identidades lineares verificadas na base completa de 116 órbitas. Não depende da varredura T16–T20 nem da A100. A originalidade bibliográfica permanece a verificar.

## Enunciado

Se uma função booleana quártica homogênea f, invariante pela rotação cíclica de 16 variáveis, é bent, então

\[
c_{115}=0,\qquad c_{57}+c_{113}=0.
\]

Os coeficientes referem-se, respectivamente, às órbitas dos suportes {0,4,8,12}, {0,1,8,9} e {0,3,8,11}; cada órbita soma monômios distintos. Esses dois vínculos são independentes, excluindo 3/4 das palavras de coeficientes como candidatas a bent. Isso não prova inexistência no 1/4 restante.

## 1. Fibras e duas identidades pequenas de paridade

Defina g_z(u)=f(u,u+z), com u,z∈F₂⁸, e A_z=Σ_u(−1)^{g_z(u)}. A rotação de f induz a transformação (u,z)↦(ρu+z₇e₀,ρz), onde ρ é a rotação de oito bits. Em particular A_85=A_170.

Para z=255, a transformação u↦ρu+e₀ tem 16 órbitas, todas de tamanho 16. Para z=85, a transformação induzida por duas rotações tem 32 órbitas, todas de tamanho oito. Se U_z contém uma representante de cada órbita, as duas identidades são

\[
\sum_{u\in U_{255}}g_{255}(u)=0,\qquad
\sum_{u\in U_{85}}g_{85}(u)=0
\quad\text{em }\mathbb F_2.
\]

Cada expressão é linear nos 116 coeficientes da ANF de f. Basta, portanto, conferi-la para os 116 geradores de órbitas. O certificado `fiber_code_certificate.json` fornece as representantes e as 116 palavras de valores para cada identidade; todas possuem peso par. O verificador independente reconstrói os geradores, as ações e os valores sem utilizar os resultados da GPU. Essa é uma verificação de identidades lineares em uma base completa, não uma amostragem de funções.

Se w_z conta as representantes com g_z(u)=1, essas identidades dizem que w_255 e w_85 são pares. Consequentemente,

\[
A_{255}=16(16-2w_{255})\equiv0\pmod{64},
\qquad
A_{85}=8(32-2w_{85})\equiv0\pmod{32}.
\]

O certificado também demonstra uma divisibilidade mais forte A_85≡0 mod 64, mas ela não é necessária ao argumento seguinte.

## 2. O dual força 64 | A₀

Se f é bent, W_f(s)=256y_s, y_s∈{−1,+1}. O dual y é invariante por rotação. A inversão de Fourier nas fibras fornece

\[
A_z=\sum_{a\in\mathbb F_2^8}(-1)^{a\cdot z}y_{(a,a)}.
\]

Seja D o conjunto dos vetores a que têm peso ímpar tanto nas posições pares quanto nas ímpares. Então

\[
A_0+A_{255}-A_{85}-A_{170}
=4\sum_{a\in D}y_{(a,a)}.
\]

D possui 64 vetores, divididos em oito órbitas de tamanho oito. De fato, um período próprio de uma palavra de oito bits obrigaria peso par em cada uma das duas paridades de posições. O conjunto D é preservado pela rotação. Logo a soma da direita, antes do fator quatro, é oito vezes uma soma de oito sinais e, portanto, é divisível por 16. A expressão inteira é divisível por 64.

Como A_255 é divisível por 64 e A_85=A_170 é divisível por 32, concluímos

\[
\boxed{64\mid A_0.}
\]

## 3. A fibra diagonal é quadrática

Em z=0, as órbitas de tamanho 16 se cancelam pela rotação de oito posições. Restam as três órbitas de tamanho oito e a de tamanho quatro. Assim,

\[
q(u)=g_0(u)=a\sum_{i=0}^{7}u_iu_{i+1}
+b\sum_{i=0}^{7}u_iu_{i+2}
+c\sum_{i=0}^{7}u_iu_{i+3}
+d\sum_{i=0}^{3}u_iu_{i+4},
\]

com índices módulo oito e (a,b,c,d)=(c57,c99,c113,c115). A matriz polar corresponde, em F₂[t]/(t⁸+1), a

\[
p(t)=a(t+t^7)+b(t^2+t^6)+c(t^3+t^5)+dt^4.
\]

Se d=1, p(1)=1, de modo que a matriz é invertível, pois t⁸+1=(t+1)⁸. A soma quadrática A₀ tem módulo 16. Isso contradiz 64 | A₀. Portanto d=0.

Suponha agora d=0 e a+c=1. O polinômio p possui fator (t+1)² e não possui fator (t+1)³: após dividir por (t+1)², o valor em t=1 é a+c=1. Portanto a matriz polar tem nulidade dois e posto seis.

Seu radical é gerado por 85 e 170, os vetores das posições pares e ímpares. A forma q se anula em ambos e, por ser linear no radical, em todo o radical. A soma quadrática não é zero e satisfaz |A₀|=2^{8−6/2}=32. Isso também contradiz 64 | A₀. Logo a=c. ∎

## Alcance e próximos passos

A condição c115=0 já tinha uma demonstração anterior. O avanço inicial desta rodada foi o vínculo c57=c113 e a formulação conjunta por 64 | A₀, com certificado pequeno de paridade. Na sequência, a terceira lei de T20 foi demonstrada pela congruência global W_f(0)≡A₀+A255 mod 128; veja `T20_TRES_LEIS_PROVA.md`. A tentativa anterior de obtê-la apenas do primeiro bit de W_{g51}(255) não a reproduziu e foi descartada como explicação suficiente.

Antes de apresentar esses enunciados como inéditos, deve-se confrontar o texto integral de [Sun et al., 2026](https://link.springer.com/article/10.1007/s10623-026-01848-4) e as condições anteriores de inexistência para funções homogêneas RS. Esta prova não é uma formalização em Lean.
