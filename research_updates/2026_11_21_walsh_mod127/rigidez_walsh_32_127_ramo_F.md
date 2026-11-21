# Rigidez de Walsh em 32 variáveis módulo 127 — Continuação: o ramo \(F=\{X\equiv2\bmod4\}\)

Este documento continua a nota *Rigidez de Walsh em 32 variáveis módulo 127* (Seções 1–6), na qual já ficaram fechados o ramo ímpar e o ramo global \(4\mid X\). Versão revisada em 21 de novembro de 2026. Aqui \(n=32\), \(m=8\), \(M=256\), \(p=127\), \(t=p/M=127/256\), \(L=4p-M=252\) e \(F=\{b\in\mathbb F_2^{32}:X(b)\equiv2\bmod4\}\ne\varnothing\), que é todo o espaço (\(\operatorname{codim}F=0\)) ou um hiperplano afim (\(\operatorname{codim}F=1\)).

Em \(F\), escrevemos \(X\equiv-2(-1)^Q\bmod8\) com \(\deg Q\le2\) e semiposto polar \(h=\operatorname{semirank}(Q|_F)\), \(Y=(-1)^QX\equiv-2\bmod8\), \(D=((Y+2)/8)\bmod2\) (\(\deg D\le4\)), \(w=\Pr_F(D=1)\),
\[
A=2p-M=-2,\qquad C=M-6p=-506,\qquad G=16p-2M=1520,
\]
\[
r_D=A+(C-A)D=-2-504D,\qquad \mathcal L=(Y-r_D)(Y+r_D-4p)\ge0.
\]
Ponha \(B_4=(Y-r_D)/16\bmod2\) e \(L_0=16(16t-2)=95\). Onde \(D=0,B_4=1\), vale \(\mathcal L/(pM)\ge L_0\). Onde \(D=1\), com \(\rho=C+GB_4\), valem \(\mathcal L\ge G|Y-\rho|\) e a cota forte \(\mathcal L\ge16p|Y-\rho|\).

Pela identidade de Parseval, \(\mathbb E_F[Y^2]=M^2\) se \(F\) é global e \(\mathbb E_F[Y^2]\le 2M^2-L^2=M^2+16p\) se \(F\) é hiperplano (pois \(4\mid X\) em \(F^c\) implica \(|X|\ge L\)). Como \(|\mathbb E_F Y|\le 2^{h+\operatorname{codim}F}/M\), o orçamento normalizado em \(F\) satisfaz
\[
\frac{\mathbb E_F\mathcal L}{pM}\le \ell_h(w):=2-16w+\frac{12+64w}{M}+\frac{2^{h+3}}{M^2}.
\]

---

Quando \(F\) é global, a cota mais forte substitui \(12/M\) por \(-4/M\) e \(2^{h+3}\) por \(2^{h+2}\), pois \(\mathbb E_FY^2=M^2\) e \(|\mathbb E_FY|\le2^h/M\). Em particular, para comparações de orçamento, um semiposto global \(h\) usa no máximo \(\ell_{h-1}\). Escrevemos \(E=Y^2-r_D^2\) no ramo \(F\).

## 7. Exclusão completa de todos os semipostos \(5\le h\le16\)

**Teorema 0 (Exclusão de \(5\le h\le16\) em ambos os casos global e hiperplano).** *Em \((32,127)\), o ramo \(F=\{X\equiv2\bmod4\}\) é impossível para todo \(h\ge5\).*

*Demonstração.* Dividimos nos três regimes de \(h\in\{5,\dots,16\}\):

1. **Regime \(5\le h\le12\) (global e hiperplano) e \(h=13\) (global).** Em qualquer flat de zeros de \(D\) com semiposto residual \(\ge3\), o primeiro dígito \(B_4\) tem grau \(\le6\) e símbolo \(\gamma_3([Q]_2)\ne0\), dando peso \(\ge1/64\) e custo médio \(\ge K=L_0/64=95/64\). Quando o semiposto residual é \(\ge4\), o dual do símbolo sêxtico em um bloco simplético de dimensão \(8\) tem posto \(8\), excluindo pesos \(1/64\) e \(3/128\) por Kasami–Tokura; logo o peso de \(B_4\) é \(\ge1/32\) e o custo médio sobe para \(2K=95/32\).
   - Para \(w=0\), o custo de \(E/(pM)\) é \(\ge3(64t-8)/32=285/128>4(1-t)+16/M=133/64\) (independente de \(h\)).
   - Para \(h=5\), nos cortes de codimensão \(\le2\) resta semiposto \(\ge3\) (custo \(K=95/64\)): os custos \(3K/4,K/2,K/4,K/4\) superam \(\ell_5(w)\) nas três classes de Kasami–Tokura e em \(1/8\le w<5/32\), e \(\ell_5(5/32)<0\).
   - Para \(6\le h\le12\) (e \(h=13\) global, onde \(2^{h+2+\delta}=2^{15}\)), todo corte de codimensão \(\le2\) retém semiposto \(\ge4\), dando custo \(2K=95/32\): os custos \(3(2K)/4,2K/2,2K/4,2K/4\) superam \(\ell_h(w)\) até \(w=5/32\). Para \(h\le11\) vale \(\ell_h(5/32)<0\). Para \(h=12\) (e \(h=13\) global), \(w_{\max}\approx0{,}1617<3/16\); na faixa \(5/32\le w<3/16\), Klein–Storme fornece um flat de zeros de codimensão \(\le3\) (semiposto residual \(\ge9\ge4\)), cujo custo global \(2K/8=95/256\approx0{,}3711\) supera \(\ell_{12}(5/32)=11/128\approx0{,}0859\).

2. **Lema auxiliar para cortes cúbicos em semiposto residual pelo menos cinco.** Em um corte \(J\) com \(\deg D|_J\le3\), escreva \(d=[D|_J]_3\) e \(q=[Q|_J]_2\). A expansão de \(X\equiv(-1)^Q(-2-504D)+16B_4\bmod32\) dá \(\deg B_4|_J\le6\) e \([B_4|_J]_6=\gamma_2(d)+\gamma_3(q)\). O primeiro termo vem de dois monômios disjuntos de \(D\), e o segundo de três de \(Q\). Os termos mistos têm grau no máximo cinco. Se \(B_4|_J=0\), contraia a igualdade \(\gamma_2(d)=\gamma_3(q)\) e multiplique por \(d\), usando \(d^2=0\), para obter \((\iota_v q)d\gamma_2(q)=0\) para todo \(v\). O elemento \(d\gamma_2(q)\) de grau sete teria de conter todas as coordenadas simpléticas, pelo menos dez, em cada monômio. Assim \(d\gamma_2(q)=0\).

   A multiplicação por \(\gamma_2(q)\) é injetiva em grau três. Fixe as coordenadas radicais e os pares representados por uma só coordenada, com suas orientações. Se o monômio de entrada não tem par completo, há pelo menos dois pares livres e a imagem é não nula. Se tem um par completo, a imagem mede a soma dos seus coeficientes sobre triplas de pelo menos quatro pares disponíveis. Comparar duas triplas com duas posições em comum torna todos os coeficientes iguais, e a soma numa tripla força zero. Os blocos são disjuntos. Logo \(d=0\), incompatível com \(\gamma_3(q)\ne0\). Este argumento também aparece no tratamento dos cortes cúbicos na Seção 4.2 do [preprint módulo 17](https://chatgpt.com/library?file_id=libfile_d964fa20e52c8191936371c270ee0542&account_id=personal).

   Segue que \(B_4|_J\ne0\) e tem densidade ao menos \(1/64\). Se \(D\) tivesse um zero afim de codimensão \(\le h-5\), suas restrições nos cosets paralelos seriam cúbicas e \(Q\) reteria semiposto ao menos cinco. Compare os custos locais de \(E/(pM)\) ao majorante afim \(e_+(v)=4(1-t)-8(4t-1)v+16/M\), onde \(v\) é o peso relativo de \(D\) no coset. Para \(v=0\), o custo é ao menos \(3a/32\). Para \(v=1/8\), o indicador de uma fibra de codimensão três dá grau máximo seis e símbolo \(\gamma_3(q)\), logo densidade de \(B_4\) de pelo menos \(1/32\). Seus sete hiperplanos externos são zeros de \(D\) e dão ainda densidade de \(B_4\) em \(D=0\) de pelo menos \(7/512\), usando multiplicidade quatro. O custo é ao menos \(a/32+2a(7/512)\). Para \(v=3/16\), há um hiperplano de zeros e o custo é pelo menos \(3a/64\). Para \(v=7/32\) ou \(v\ge1/4\), basta \(a/64\). Aqui \(a=95/4\). Cada custo indicado supera \(e_+(v)\), como confere o verificador. A média nos cosets contradiz o orçamento de \(E\). Portanto esses zeros de \(D\) são impossíveis.

3. **Regime \(h=13\) (hiperplano) e \(h=14\) (global).** Aqui \(2^{h+2+\delta}/M^2=1\), logo \(\ell(w)\ge0\) impõe
   \[
   w\le\frac{65}{336}\approx0{,}19345<\frac{3393}{17408}\approx0{,}19491.
   \]
   Pelo item 2, \(D\) não tem flat de zeros de codimensão \(\le7\) (pois \(h-7\ge6\ge5\)), donde \(w\ge F_7(0)=191/1024\) por Klein–Storme. O Lema 2 (\(A=7\)) do adendo uniforme \(1/2\) garante então um flat de zeros de codimensão \(\le7\), contradição.

4. **Regime \(h=14,15\) (hiperplano) e \(h=15,16\) (global).** Pelo item 2, \(D\) não tem flat de zeros de codimensão \(\le A=9\) (pois \(h-9\ge5\)). A estimativa conjunta dos dois dígitos, provada na Seção 13 para \(k_0=h-7\ge7\), dá \(\mathbb E_F[E]/(pM)\ge a(3-2^{-6})/256=18145/65536\). Em \(F\) global, \(\mathbb E_F[Y^2]=M^2\). No caso hiperplano, a comparação \(\mathbb E_F[Y^2]<M^2\) segue no final da Seção 13. De \(M^2\ge\mathbb E_F[Y^2]=\mathbb E_F[E]+4+256032w\) segue, nos dois casos,
   \[
   w\le w_{\mathrm{up}}:=\frac{113951}{516096}\approx0{,}220794<\frac{221}{1000}.
   \]
   A faixa \(w\in[191/1024,55/256]\) já é excluída pelo Lema 2 (\(A=8\)) do adendo uniforme \(1/2\). Para \(w\in[55/256,221/1000]\), estendemos o Lema 1 para cúbicas ao índice \(j=6\): a cota de derivada média \((127/128)(15/32)>2b_6(1-b_6)\) vale para \(b_6=373/1024\), dando uma derivada de peso \(\le7/16\) e o mínimo \(b_6=373/1024\) nos três semipostos \(r=1,2,3\). Escolhendo \(U=72/25=2{,}88\le8b_6=373/128\) e \(L=43/20=2{,}15\), as duas cotas unilaterais de Cantelli com teto de Fourier \(w-F_9(1)\), onde \(F_9(1)=383/2048\), têm margem estritamente positiva (\(\ge0{,}02155\)) nos subintervalos \([55/256,218/1000]\) e \([218/1000,221/1000]\), garantindo uma derivada cúbica de peso \(<b_6\) e portanto com flat de zeros de codimensão mínima \(1\le c\le6\). Os minorantes afins \(u+vx_i\le Z_c(x_i)\) para \(A=9\) sobre \([L,U]\) dão \(w\ge\frac{284127}{1284000}\approx0{,}221282>\frac{221}{1000}>w_{\mathrm{up}}\), contradição. \(\square\)

---

## 7B. Anulação da penalidade de \(F^c\) para \(w\ge1/8\) e \(r\ge8\)

**Teorema A.** *Seja \(F\) um hiperplano, \(h\le4\) e \(w\ge1/8\) (ou \(h\le3\) e \(w\ge(1-2^{-8})/8\)). Então a fase quadrática \(R\) no hiperplano complementar \(F^c=\{4\mid X\}\) é identicamente nula, \(\mathbb E_{F^c}[X^2]\ge M^2\) e \(\mathbb E_F[X^2]\le M^2\). Consequentemente:*
\[
\frac{\mathbb E_F\mathcal L}{pM}\le \ell_{\mathrm{sharp}}(w):=2-16w+\frac{64w-4}{M}+\frac{2^{h+3}}{M^2}.
\]

*Demonstração.* De \(\mathcal L\ge0\) e \(-r_D(r_D-4p)=-1020-(16pM-64p)D\), temos
\[
\mathbb E_F[X^2]=\mathbb E_F[Y^2]\ge 1020+(16pM-64p)w-4p|\mathbb E_F Y|.
\]
Para \(w\ge1/8\) e \(h\le4\), vale \(1020+(16pM-64p)/8=M^2-4p\) e \(4p|\mathbb E_F Y|\le 4p\cdot 2^5/M=p/2\), logo \(\mathbb E_F[X^2]\ge M^2-\frac92 p\) e, por Parseval, \(\mathbb E_{F^c}[X^2]\le M^2+\frac92 p\). No caso \(h\le3\) e \(w\ge(1-2^{-8})/8\), obtém-se analogamente \(\mathbb E_{F^c}[X^2]\le M^2+\delta p\) com \(\delta=4+(16M-64)/2^{11}+1/4=199/32<249/40\).

Em \(F^c\), defina \(R,V\) e \(E_4=X^2-M^2+16pR\ge0\) como na Seção 6. Suponha \(R\ne0\) em \(F^c\). Como \(\deg R\le2\), a distância mínima quadrática dá \(\Pr_{F^c}(R=1)\ge1/4\).
- Se \(\operatorname{semirank}(R|_{F^c})\ge5\), o orçamento \(\mathbb E_{F^c}[E_4]/(pM)\le\delta/256+1/16<95/128\) é inferior a \(63/256\). Como \((1+R)V\) tem grau no máximo seis e custa pelo menos \(63/4\) por ponto não nulo, ele se anula. Aplica-se então o Lema A1 (Seção 12), pois o orçamento é menor que \(95/128\).
- Se \(\operatorname{semirank}(R|_{F^c})\le4\), alguma fibra \(J\subseteq F^c\) de \(R=1\) (de codimensão absoluta \(\le1+9=10\)) tem orçamento
\[
b_J\le\frac1{16}+4\frac{\delta}{256}\le\frac{17}{128}<\frac{95}{512}=K_4
\]
(e \(b_J\le\frac{1}{16}+\frac{249}{2560}<K_4\) para \(w\ge(1-2^{-8})/8\)). Assim \(C_4=\cdots=C_8=0\) em \(J\), logo \(X\equiv LS\bmod512\). A granularidade de Fourier da Seção 2.1 com \(\kappa_{10}=2^{10}/M^2=1/64\) dá \(16\kappa_{10}+b_J/8\le 1/4+(1/16+249/2560)/8<63/64=L/M\), contradição.

Portanto \(R\equiv0\) em \(F^c\), de modo que \(|X|\ge M\) em todo \(F^c\), \(\mathbb E_F[X^2]\le M^2\), e a cota \(\ell_{\mathrm{sharp}}(w)\) segue substituindo \(M^2+16p\) por \(M^2\). \(\square\)

**Corolário.** *Para \(w\ge1/8\) e \(h\le4\), valem \(\ell_{\mathrm{sharp}}(1/8)=9/512\), \(w\le1017/8064<1/8+1/512\) e \((1+D)B_4=0\) em todo \(F\).*

*Demonstração.* O produto booleano \((1+D)B_4\) tem grau no máximo \(4+8=12\). Se fosse não nulo, seu suporte em \(D=0,B_4=1\) teria densidade \(\ge2^{-12}\) e custo global \(\ge L_0/4096=95/4096>9/512=\ell_{\mathrm{sharp}}(1/8)\). \(\square\)

---

## 8. Fechamento da faixa \(w\ge1/8\) sem \(B_5=B_4\) (exceto \(D=abR\), \(r\ge8\))

Observação estrutural: em \(m=8\), a identidade \(B_5=B_4\) (grau \(\le16\)) não segue do orçamento \(9/512\), mas **nenhuma etapa da descida para \(w\ge1/8\) depende de \(B_5=B_4\)** — todas exigem apenas \((1+D)B_4=0\) (Corolário da Seção 7).

1. **Existência de hiperplano de zeros \(D=aR\) e exclusão de \(h=4\).** Como \(w\le1017/8064<5/32\), se \(D\) não tiver hiperplano de zeros, Klein–Storme (Teorema 3) dá um flat de zeros de codimensão \(2\) (de semiposto \(\le2\), pois \((3/2-4/M)/4>9/512\)). Nos três cosets complementares, \(D\) é cúbica não nula e ao menos um coset \(H\) tem peso \(\le\frac43w\le\frac{339}{2016}<\frac3{16}\), logo \(D|_H=\mathbf1_J\) (\(\operatorname{codim}_H J=3\)). Como \(B_4=DB_4\), tem-se \(\deg B_4|_J\le2\) e codimensão absoluta \(\le6\), dando custo global \(\ge2^{-5}(G/p)(1/4-256/M^2)=5985/65024>9/512\). Logo \(D=aR\) com \(a\) afim e \(\deg R\le3\) em \(H=\{a=1\}\). Se \(h=4\), o hiperplano \(a=0\) retém semiposto \(\ge3\) e custo \(\ge(3/2-4/M)/2>9/512\). Portanto \(h\le3\), e em \(H\) a polar de \(Q|_H\) tem semiposto \(h_H\le2\) (pois \(B_4=0\) em \(a=0\) proíbe \(\gamma_3([Q|_H]_2)\ne0\)).
2. **Exclusão de fibras quadráticas de peso \(1/4\) em codimensão relativa \(c\le3\) em \(H\).** Se \(R|_T\) é quadrática de peso \(1/4\) em \(T\subset H\) (\(\operatorname{codim}_H T\le3\)), a comparação módulo \(32\) entre \(T\) e seu paralelo em \(a=0\) dá \(\deg B_4|_T\le5\) com símbolo decomponível. Dividindo pelos dois fatores afins de \(R|_T\) e fixando até \(3\) coordenadas adicionais, \(B_4\) fica quadrática em subfibras de \(D=1\) de codimensão absoluta \(\le c+7\le10\) e \(h_H\le2\) (erro de Fourier \(\le2^{12}/M^2=1/16\)). Pela cota forte \(\mathcal L\ge16p|Y-\rho|\):
   - se o peso \(v\) de \(B_4\) na subfibra satisfaz \(v\le1/4\) ou \(v\ge7/16\), o custo local é \(\ge16(126/256-1/16)=55/8\);
   - se \(v=3/8\), fixe **uma única coordenada** da forma simplética \(x_1x_2+x_3x_4\) em \(x_1=1\), gerando subfibra balanceada (\(v=1/2\), \(|C+G/2|=254\)) de codimensão \(\le11\) (erro \(\le2^{13}/M^2=1/8\)) e custo na fibra \(\ge\frac12\cdot16(254/256-1/8)=111/16\).
   Somando sobre \(J\) (densidade \(\ge2^{-6}\) em \(F\)), o custo global é \(\ge\frac{55}{512}>\frac{9}{512}\).
3. **Estrutura em oito cosets.** Suponha que \(R\) não tenha fator afim em \(H\). Seu peso é \(v=2w\le1/4+1/448<37/128\). Use o Lema 1 do adendo uniforme \(1/2\) para obter um corte nulo de codimensão três em \(H\), reduzindo a direção de um corte menor se preciso. Nos oito cosets, \(R\) é quadrática, com polar que depende afimmente das três coordenadas de corte. Cada coset não nulo pesa ao menos \(3/8\) pelo passo 2. Como \(8v<2+1/16\), há pelo menos três cosets nulos. Quatro zeros coplanares dariam um fator afim. Quatro zeros afimmente independentes anulam todas as polares, e o símbolo cúbico depende de no máximo seis formas (as três formas de corte e até três formas livres ligadas aos pares de cortes). Se há exatamente três zeros, a polar se anula no plano que geram, inclusive no quarto coset, onde o peso da função afim não nula é ao menos \(1/2\). Nos quatro cosets fora do plano as polares coincidem, e cada peso é exatamente \(3/8\), pois um incremento pesaria pelo menos \(1/16\). Logo a polar comum tem posto quatro. O símbolo cúbico usa no máximo dez formas (três de corte, quatro da polar e até três ligadas aos pares de cortes).
4. **Redução a fibras quadráticas.** Escreva \(R=C(u)+A(z)+\sum_i u_iL_i(z)\) nas até dez formas \(u\) que suportam o símbolo cúbico. Completando o quadrado no bloco simplético de \(A\), com \(u\) fixo, obtemos \(R=C'(u)+Q_{2s}(z_1)+\lambda(u)\cdot z_2\), com \(\lambda\) afim. O viés \(>1/4\) implica \(s+\operatorname{codim}\{\lambda=0\}\le1\). Se \(s=1\), o peso é \(1/4+\Pr(C'=1)/2\). Se \(s=0\) e \(\operatorname{codim}\{\lambda=0\}=1\), o peso é \(1/4+\Pr(C'=1\mid\lambda=0)/2\). Em ambos a distância mínima cúbica força \(C'\) a zero na fatia relevante e produz um fator afim de \(R\). Na primeira opção, o remanescente é uma quadrática de posto dois e peso \(1/4\); na segunda, \(R\) é zero em \(\{\lambda=0\}\). Portanto resta \(s=0,\lambda=0\), e \(R\) depende apenas de \(u\).

   Complete as formas de controle com a imagem polar de \(Q|_H\), totalizando \(k\le14\). O símbolo de grau seis de \(B_4|_H\) é \(\gamma_2([R]_3)\), pois \(\gamma_3([Q|_H]_2)=0\). Assim os coeficientes dos monômios livres de grau pelo menos três têm grau no máximo dois nos controles. São suportados em \(R=1\) por \((1+D)B_4=0\). Se um não fosse zero, teria peso \(1/4\), pois está abaixo de \(3/8\); sua diferença de \(R\) teria peso menor que \(1/8\) e seria zero. Isso daria um fator afim de \(R\). Logo \(B_4\) é quadrática nas fibras de \(R=1\).

   O sinal de \(Q\) nas direções livres é um caráter fixo vezes um sinal nos controles. Por Parseval no quociente, a média condicional de \(Y/M\) tem norma \(L^2\) no máximo \(4\cdot2^{k/2}/M^2\le1/128\). Como o peso quadrático de \(B_4\) em cada fibra dá \(|\mathbb E\rho|/M\ge1/4\), a cota forte \(\mathcal L\ge16p|Y-\rho|\) e Cauchy–Schwarz dão custo médio em \(F\) ao menos \(8(v/4-\sqrt v/128)\ge15/32>9/512\).

Resta na faixa \(w\ge1/8\) apenas o caso em que \(R\) possui um fator afim adicional, isto é, \(D=abR'\) com \(a,b\) independentes e \(\deg R'\le2\).

---

## 9. Fechamento de \(0<w<1/8\) e da família \(D=abR\) para \(r\le7\)

Pela classificação de Kasami–Tokura em \(\mathrm{RM}(4)\), os casos \(0<w<1/8\) são \(D=a+b\) (\(w=15/128\)), \(D=a(b+c)\) (\(w=7/64\)) e \(D=abR\) (\(w=(1-2^{-r})/8\)). Todos os seguintes fecham em \(m=8\):

- **\(h=4\), \(D=abR\) ou \(D=a(b+c)\):** os cortes que evitam ao menos um fator comum cobrem, respectivamente, \(3/4\) ou \(1/2\) de \(F\), com semiposto residual pelo menos três. Seus custos \(3K/4\) e \(K/2\) excedem \(\ell_4(1/16)\) e \(\ell_4(7/64)\).
- **\(h=4\), \(w=15/128\):** as duas cotas \(L_0/128=95/128\) e \(\frac{15}{128}\frac Gp(2t-512/M^2)\) excedem \(\ell_4(15/128)=13/64\).
- **\(h\le3\), \(D=a+b\) (\(w=15/128\)):** \(L_0/256\) e \(\frac{15}{128}\frac Gp(1/4-2^{12}/M^2)\) excedem \(\ell_3(15/128)\).
- **\(h\le2\), \(D=a(b+c)\) (\(w=7/64\)):** pela cota forte \(\mathcal L\ge16p|Y-\rho|\) em fibras de codimensão \(\le8\) (com corte de \(1\) coordenada em \(v=3/8\)), custo \(\ge\frac7{64}\cdot\frac{122}{16}>\ell_2(7/64)\).
- **\(h=3\), \(D=a(b+c)\) (\(w=7/64\), prova nova via Parseval no quociente):** em \(H=\{a=1\}\), fixando os dois blocos cúbicos e a imagem polar de \(Q|_H\) (\(k\le12\) coordenadas), o primeiro dígito \(B_4\) é quadrático em cada fibra de \(D=1\) (pois o custo de coeficientes livres de grau \(\ge3\) é \(\ge L_0/256>\ell_3(7/64)\)). Por Parseval no quociente em \(H\), \((\mathbb E|\mu|^2)^{1/2}\le4\cdot2^6/M^2=1/256\). Como \(v=\Pr_H(D=1)=7/32<1/4\), Cauchy–Schwarz dá custo global
  \[
  \ge 8\left(\frac{7}{128}-\frac{1/2}{256}\right)=\frac{27}{64}>\frac{333}{1024}=\ell_3(7/64).
  \]
- **\(h\le3\), \(D=abR\) com \(r=0,1,2,3,4\):**
  - \(r=0\) (\(w=1/8\)): \(\frac18\frac Gp(1/4-1024/M^2)>9/512\).
  - \(r=1,2\): todas as cotas diretas da cota forte excedem \(\ell_3(1/16)\) e \(\ell_3(3/32)\).
  - \(r=3,4\) (em \(w<1/8\) e \(w\ge1/8\)): aplicando a cota forte \(\mathcal L\ge16p|Y-\rho|\) e substituindo a fixação de \(4\) coordenadas em \(v=3/8\) pelo corte de **\(1\) coordenada** (\(x_1=1\), gerando subfibra balanceada \(|C+G/2|=254\)), o custo excede \(\ell_3(w)\) (para \(r=4\), \(w=15/128\): \(\frac{15}{128}\cdot\frac{31}{8}=\frac{465}{1024}>\frac{207}{1024}=\ell_3(15/128)\)).
- **\(h\le3\), \(D=abR\) com \(r=5,6,7\) (prova nova via Parseval no quociente):** em \(J_0=\{a=b=1\}\) (\(\operatorname{codim}J_0\le3\)), fixamos as \(2r\) coordenadas simpléticas de \(R\) e a imagem polar de \(Q|_{J_0}\), totalizando \(k\le2r+6\) coordenadas (e \(k\le2r+5\) quando \(w\ge1/8\), onde \(h_{J_0}\le2\)). Por Parseval em \(J_0\), \((\mathbb E|\mu|^2)^{1/2}\le8\cdot2^{k/2}/M^2\). Usando \(\sqrt q<71/100\) (para \(w<1/8\)) e \(\sqrt{q/2}<51/100\) (para \(w\ge1/8\)), Cauchy–Schwarz dá custo global \(\ge4(q/4-\sqrt q\,(\mathbb E|\mu|^2)^{1/2})>\ell(w)\) para todos \(r\in\{5,6,7\}\), nas duas faixas de peso.
- **\(D=abR\) com \(r\ge8\) (fechamento completo — prova nova via \(-4(-1)^{Q+R}\bmod256\)):**
  Em coordenadas adaptadas aos fatores \(a,b\), a comparação módulo 32 dá \(\deg B_4\le6\). Pelo custo de \(B_4\) em \(D=0\), ele zera em \(a=0\) e em \(b=0\), logo \(P=B_4|_{J_0}\) tem grau no máximo quatro. Se \((1+R)P\ne0\), sua distância mínima obriga custo em \(F\) de pelo menos \(95/(4\cdot64)\), acima do orçamento afiado. Portanto \(P=RP\). A divisão exterior de A1, aqui em semiposto pelo menos oito, dá \(P=RK\) com \(K\) quadrática. Podemos trocar \(K\) por \(K+1+R\) de modo que \(K+R\) tenha semiposto pelo menos \(\lceil r/2\rceil\).
  1. **Forçando \(K=0\) para todo \(r\ge8\) (em \(w<1/8\) e \(w\ge1/8\)):** pelo Teorema A, \(R=0\) em \(F^c\) e \(\ell_{\mathrm{sharp}}(w)\le0{,}0243\). Além disso, em todos os pontos admissíveis de \(J_0\), vale a cota pontual mais forte
     \[
     Y\ge Z_{\min}-\frac{\mathcal L}{16p},\qquad Z_{\min}:=-2(1-R)+(C+GB_4)R.
     \]
     (Em \(R=1\), isso segue de \(\mathcal L\ge16p|Y-(C+GB_4)|\); em \(R=0\), se \(Y\ge-2\) a desigualdade é trivial, e se \(Y<-2\) então \(Y\le-1522\), de modo que \(510-Y\ge2032=16p\).) Portanto \(\mathbb E_{J_0}[Y-Z_{\min}]/M\ge-\ell_{\mathrm{sharp}}(w)/4\ge-0{,}00608\), que elimina tanto \(\Pr(K=1)\ge3/8\) quanto \(\Pr(K=1)=1/4\) para **todo** \(r\ge8\) nas duas faixas de peso, forçando \(K=0\), isto é, \(B_4=0\) em todo \(J_0\).
  2. **Anulação de \(B_5,B_6,B_7\) em \(J_0\):** escreva \(B_j=((Y-r_R)/2^j)\bmod2\) em \(J_0\) (\(j=5,6,7\)). Usando \(r_R=-2-504R=-254+252(-1)^R\), temos \((-1)^Qr_R=-254(-1)^Q+252(-1)^{Q+R}\). Em coordenadas simpléticas, \((-1)^Q\) tem grau inteiro \(\le2h+1\le7\), \(X\bmod2^{j+1}\) tem grau \(\le\lfloor4j/3\rfloor\), e \(4(-1)^{Q+R}\bmod2^{j+1}\) tem grau \(\le2(j-2)\). Logo \(\deg B_5\le7\), \(\deg B_6\le8\) e \(\deg B_7\le10\). Os respectivos custos globais mínimos em \(J_0\) são \(0{,}4336\), \(1{,}3945\) e \(1{,}6816\), todos muito acima de \(\ell_{\mathrm{sharp}}(w)\le0{,}0243\). Assim \(B_5=B_6=B_7=0\) em \(J_0\).
  3. **Contradição no símbolo de grau 10 módulo 256:** como \(B_4=B_5=B_6=B_7=0\), vale \(Y\equiv r_R\bmod256\) em \(J_0\), ou seja,
     \[
     X\equiv 2(-1)^Q-4(-1)^{Q+R}\pmod{256}.
     \]
     Pela filtração inteira (\(\lceil3\cdot10/4\rceil=8\)), \(X\bmod256\) tem grau \(\le9\); como \(h\le3\), \(2(-1)^Q\) tem grau \(\le7\). Portanto o símbolo de grau \(10\) de \((-4(-1)^{Q+R}\bmod256)/128\) — que é exatamente \(\gamma_5([Q+R]_2)\) — deve anular-se em \(J_0\). Mas pela subaditividade do posto, \(\operatorname{semirank}(Q+R)\ge r-h\ge8-3=5\), logo \(\gamma_5([Q+R]_2)\ne0\), contradição.

**Conclusão das Seções 8–9.** *Todo o caso \(D\ne0\) (\(w>0\)) fica excluído em \((32,127)\) para \(h\le4\).*

---

## 10. Fechamento de \(D=0\) para \(h=3\), global \(h=1,2\), e hiperplano com \(R=0\) em \(F^c\) (\(h=1,2\)) ou \(\mathbb E_F[X^2]\ge M^2\) (\(h=0,1,2\))

### 10.1. Exclusão de \(D=0, h=3\) em \(m=8\)
Com \(\ell_0=\ell_3(0)=2097/1024\), temos \(\Pr_F(B_4=1)\le\ell_0/L_0<3/128\), logo \(B_4=\mathbf1_J\) (\(\operatorname{codim}_F J=6\)). Em cada hiperplano paralelo \(K\) disjunto de \(J\), o orçamento \(b_K=2(\ell_0-L_0/64)=577/512\approx1{,}127\) é inferior ao custo mínimo de todos os dígitos \(C_4,\dots,C_8\) (\(\ge95/32=2{,}96875\)), forçando \(Y\equiv-2\bmod512\) em \(F\setminus J\). A filtração obriga \(B_5|_J\) a ser afim; em qualquer hiperplano \(J'\subset J\) onde \(B_5\) é constante, a contribuição a \(\ell_0\) é \(\ge2{,}2275>\ell_0\), contradição.

Se \(D=0,h=4\), o argumento em blocos simpléticos de dimensão oito da Seção 7 dá densidade de \(B_4\) de pelo menos \(1/32\), e \(3a/32=285/128>133/64\) exclui o caso nas duas codimensões.

Logo, quando \(D=0\), resta \(h\in\{0,1,2\}\). A indução dos dígitos (\(C_4,\dots,C_8\) têm custo mínimo \(\ge2{,}96875>\ell_2(0)\)) dá imediatamente a congruência-base:
\[
W_f(b)\equiv -512(-1)^{Q(b)}\pmod{2^{17}}\qquad(\forall b\in F).
\tag{*}
\]

### 10.2. Caso global \(F=\mathbb F_2^{32}\): exclusão de \(h=2\) e \(h=1\)
- **\(h=2\):** escolha um 4-espaço simplético de frequências e projete sobre seu ortogonal físico \(U\) de dimensão 28. A soma dos sinais de \(Q\) no 4-espaço vale \(\pm4\), constante nas fibras após absorver a parte afim. Assim o espectro da restrição \(g\) é constante \(\pm128\bmod2^{13}\). Em todo corte físico de dimensão 24 dessa restrição, Poisson dá valoração pelo menos \(\min(7,13-4)=7\), o que força \(\gamma_6(a_g)=0\). Como \(\gamma_7(a_g)=a_g\gamma_6(a_g)\), o termo de valoração sete da soma em 28 variáveis se anula, contradição.
- **\(h=1\) (prova nova via \(\gamma_3(C)=C\wedge\gamma_2(C)\)):** em \(U=S^\perp\) (\(\dim U=30\), \(v=8\)), \(g=(f+b\cdot x)|_U\) satisfaz \(\nu_2 Z(g)=8\) e \(\nu_2 Z(g|_J)\ge\min(8,15-c)\) para todo corte afim de codimensão \(c\). Para \(c=6\) (\(\dim=24\)), \(\nu_2\ge8>6=24/4\), logo \(\gamma_6(a_g)=0\). Fixada uma coordenada \(x_i\), escreva \(a_g=x_iC+B\) (\(C\in\bigwedge^3\), \(B\in\bigwedge^4\)); então \(C\wedge\gamma_5(B)=0\).
  Na inclusão-exclusão marcando todos os monômios de \(g\) contendo \(x_i\), o complemento \(2Z(g|_{x_i=0})\) e todas as interseções com \(l\ne3\) ou \((l=3,c\le9)\) têm valoração \(\ge9\). As únicas parcelas de valoração \(8\) ocorrem em \((l=3,c=10)\): ternas disjuntas \(\{T_1,T_2,T_3\}\subseteq C\) com complemento de dimensão \(20\), cuja soma total módulo \(2^9\) é
  \[
  2^8\cdot\mathrm{vol}_{29}\bigl(\gamma_3(C)\wedge\gamma_5(B)\bigr).
  \]
  Como cada terna disjunta aparece \(3\equiv1\bmod2\) vezes em \(C\wedge\gamma_2(C)\), vale \(\gamma_3(C)=C\wedge\gamma_2(C)\) em \(\bigwedge^*(\mathbb F_2^{29})\), donde \(\gamma_3(C)\wedge\gamma_5(B)=\gamma_2(C)\wedge(C\wedge\gamma_5(B))=0\). Logo \(2^9\mid Z(g)\), contradição.

### 10.3. Caso hiperplano (\(\operatorname{codim}F=1\)): exclusão via \(f_0:\mathbb F_2^{31}\to\mathbb F_2\)
Escolha coordenadas com \(F=\{b_1=1\}\), \(F^c=\{b_1=0\}\) e ponha \(f_0(y)=f(0,y)\) em \(\mathbb F_2^{31}\) (\(\deg f_0\le4\)).

**Teorema F1 (\(\mathbb E_F[X^2]\ge M^2\) ou \(R=V=0\) em \(F^c\), para todos \(h\in\{0,1,2\}\)).**
- Se \(\mathbb E_F[X^2]\ge M^2\), então \(\mathbb E_{F^c}[X^2]\le M^2\); pela Seção 6 (com \(\kappa_{10}=1/64\), \(16\kappa_{10}+1/128=33/128<63/64\)), segue \(R=0\) e \(E_4=0\) em \(F^c\), logo \(W_f(0,b')\equiv2^{16}\bmod2^{17}\) em todo \(F^c\).
- Mesmo se \(\mathbb E_F[X^2]<M^2\), o excesso em \(F^c\) satisfaz \(\mathbb E_{F^c}[(X^2-M^2)/M^2]<1\). Se \(R=V=0\) em \(F^c\), todos os dígitos \(C_4,C_5,C_6,C_7\) e \(1+C_8\) têm custo mínimo \(>1\) (o menor é \(C_4\), com \(12065/8192\approx1{,}473\)), forçando novamente \(W_f(0,b')\equiv2^{16}\bmod2^{17}\) em todo \(F^c\).

Em ambos os casos, para todo \(b'\in\mathbb F_2^{31}\), o sinal de \(\pm2^{15}\) some módulo \(2^{16}\):
\[
W_{f_0}(b')=\frac{W_f(0,b')+W_f(1,b')}{2}\equiv 2^{15}-256(-1)^{Q(b')}\pmod{2^{16}}.
\]
- **\(h=2\):** tomando \(S\subseteq\mathbb F_2^{31}\) simplético de dimensão \(4\) e \(U=S^\perp\) (\(\dim=27\)), Poisson dá \(\nu_2 Z((f_0+b'\cdot y)|_U)=6<\lceil27/4\rceil=7\), contradição.
- **\(h=1\):** tomando \(S\subseteq\mathbb F_2^{31}\) simplético de dimensão \(2\) e \(U=S^\perp\) (\(\dim=29\)), Poisson dá \(\nu_2=7<\lceil29/4\rceil=8\), contradição.
- **\(h=0\):** normalizando \(Q\equiv0\), temos \(\nu_2 Z(f_0)=8\). Marcando todos os monômios de \(f_0\) contendo \(y_1\), a parte sem marcados \(2Z(f_0|_{y_1=0})\) tem valoração \(9\). Para \(l\ge1\) marcados com união \(A\) (\(c=|A|\le3l+1\)), a translação \(y_0\notin U'\) anula a soma da constante \(2^{15}-256\) em \(U'^\perp\), dando \(\nu_2 Z(f_0|_{J_A})\ge16-c\). Para \(l=1,2,3\) vale \(l+(16-c)\ge15-2l\ge9\), e para \(l\ge4\) vale \(l+\lceil(31-c)/4\rceil\ge\lceil(30+l)/4\rceil\ge9\). Logo \(2^9\mid Z(f_0)\), contradição. \(\square\)

**Teorema F2 (Exclusão completa de \(R=0\) em \(F^c\) para todo \(h\in\{0,1,2\}\) e todo \(V\)).**
Pela identidade de autocorrelação na normal \(d\ne0\) de \(F\), \(\mathbb E_{F^c}[X^2]/M^2=1\pm\Delta_f(d)/2^{32}\), onde \(D_d f\) é cúbica e \(127\mid\Delta_f(d)\). Pela classificação de Kasami–Tokura, os valores absolutos do viés de uma cúbica na faixa \([1/2,1]\) são \(1\), \(1/2\) e valores \(1/2+2^{-j}\) com \(j\ge2\). Para o viés negativo aplique a classificação ao complemento da função. Nenhum desses valores, multiplicado por \(2^{32}\), é divisível por \(127\). Para os tipos \(1/2+2^{-j}\), isso decorre da ordem ímpar sete de \(2\bmod127\). Logo \(|\Delta_f(d)|/2^{32}<1/2\) e o excesso em \(F^c\) é \(<1/2\). Para \(R=0\), segue
\[
\Pr_{F^c}(V=1)<\frac{1/2}{32004/4096}=\frac{512}{8001}<\frac3{32},
\]
forçando \(V=0\) (coberto por F1) ou \(V=z_1z_2z_3z_4\) (peso \(1/16\)). Em cada um dos \(4\) hiperplanos independentes \(z_i=0\), o excesso residual é \(\le191/8192<12065/8192\), dando \(W_f\equiv2^{16}\bmod2^{17}\) em todo \(F^c\setminus J_V\), onde \(J_V=\{b_1=0,z_1=z_2=z_3=z_4=1\}\) (\(\operatorname{codim}J_V=5\)).
- **\(h=1,2\):** como \(2h\le4\), ao menos um dos hiperplanos \(z_i=0\) retém semiposto \(\ge1\) para \(Q\), e Poisson em \(S\subseteq\{z_i=0\}\) de dimensão \(2\) dá \(\nu_2 Z(f_0|_U)=7<\lceil29/4\rceil=8\), contradição.
- **\(h=0\):** em \(F^c\) vale \(X\equiv8V+16a_4\bmod32\). Para todo flat \(W\subseteq F^c\) de dimensão \(6\), \(W\cap J_V\) tem codimensão \(\le4\) em \(W\), logo \(4\mid\mathrm{wt}(V|_W)\), \(32\mid8\mathrm{wt}(V|_W)\) e, por Poisson (\(2^{\lceil18/4\rceil}=32\mid\sum_W X\)), vem \(2\mid\mathrm{wt}(a_4|_W)\); assim \(\deg a_4\le5\). Fora de \(J_V\), \(W_f\equiv2^{16}\bmod2^{17}\implies X\equiv0\bmod32\implies a_4=0\). Logo \(a_4=z_1z_2z_3z_4(1+S_V)\) com \(\deg(S_V|_{J_V})\le1\), onde \(760(-1)^{S_V}\equiv248+16S_V\bmod512\) (pois \(760\equiv248\bmod512\) e \(-760\equiv264\bmod512\)).
  O orçamento residual em \(J_V\) é \(b_{J_V}=16(\frac12-\frac1{16}\frac{760^2-M^2}{M^2})=\frac{191}{1024}\). Como \(\deg(248+16S_V)\le1\) e \((d+3)\ge j+1\) para \(d=\lfloor4j/3\rfloor+1\in\{7,9,10,11\}\), cada dígito \(C_j\) (\(j=5,6,7,8\)) tem grau \(\le\lfloor4j/3\rfloor\) em \(J_V\) e custo médio mínimo \((|X_{\min}|^2-760^2)/(M^2\,2^{\deg C_j})\ge1{,}7208>\frac{191}{1024}\) (com \(|X_{\min}|\in\{2792,6856,14984,31240\}\)), forçando \(C_5=C_6=C_7=C_8=0\) em \(J_V\). Portanto \(X\equiv760(-1)^{S_V}\bmod512\) em \(J_V\). Restringindo se necessário uma coordenada de \(S_V|_{J_V}\) a um hiperplano \(J'_V\subseteq J_V\) (\(\operatorname{codim}J'_V\le6\), orçamento \(\le2b_{J_V}=\frac{191}{512}\)) e ajustando o sinal para \(X\equiv760\bmod512\), todo valor admissível \(X\ne760\) satisfaz \(X\ge1272\) ou \(X\le-63752\), donde \((X^2-760^2)/|X-760|\ge2032=16p\). Por Poisson, \(|\mathbb E_{J'_V}[X/M]|\le2^6/M=1/4\), dando
  \[
  \frac{760}{256}-\frac14\le\frac{|\mathbb E_{J'_V}[X-760]|}{M}\le\frac{M}{16p}\,b_{J'_V}\le\frac{16}{127}\cdot\frac{191}{512}=\frac{191}{4064},
  \]
  isto é, \(2{,}71875\le0{,}04700\), contradição. \(\square\)

### 10.4. Lema Mestre \([R]_2=[Q]_2\) e exclusão completa de todo o ramo hiperplano \(F\)
**Lema Mestre (Acoplamento polar em \(F\) e \(F^c\)).** *Em todo caso hiperplano \(F=\{b_1=1\}\) com \(X(1,b')\equiv-2(-1)^{Q(b')}\bmod8\), a fase quadrática \(R\) em \(F^c=\{b_1=0\}\) satisfaz \([R]_2=[Q]_2\), isto é, suas formas alternadas coincidem: \(\beta_R=\beta_Q\).*

*Demonstração.* Para qualquer \(2\)-subespaço \(S=\{0,u,v,u+v\}\subseteq\mathbb F_2^{31}\) e \(U=S^\perp\) (\(\dim U=29\)), a fórmula de Poisson para \(f_0\) em \(U\) dá
\[
Z((f_0+b'_0\cdot y)|_U)=\frac14\sum_{s\in S}W_{f_0}(b'_0+s)=\frac18\sum_{s\in S}\bigl(W_f(0,b'_0+s)+W_f(1,b'_0+s)\bigr).
\]
Como \(W_f(0,b')=256X(0,b')\equiv2^{10}R(b')\bmod2^{11}\) e \(W_f(1,b')\equiv-512(-1)^{Q(b')}\equiv-512+2^{10}Q(b')\bmod2^{11}\), somando sobre os quatro pontos de \(b'_0+S\) (\(\sum(-512)=-2048\equiv0\bmod2^{11}\)) e dividindo por \(8\), obtemos
\[
Z((f_0+b'_0\cdot y)|_U)\equiv 2^7\bigl(\beta_R(u,v)+\beta_Q(u,v)\bigr)\pmod{2^8}.
\]
Pelo teorema de Ax em \(U\) (\(\dim U=29\), \(\deg f_0\le4\)), vale \(2^{\lceil29/4\rceil}=2^8\mid Z((f_0+b'_0\cdot y)|_U)\), logo \(\beta_R(u,v)=\beta_Q(u,v)\) para todos \(u,v\in\mathbb F_2^{31}\), ou seja, \([R]_2=[Q]_2\). \(\square\)

**Teorema F3 (Exclusão completa do ramo hiperplano \(F\)).** *Em \((32,127)\), o caso hiperplano \(\operatorname{codim}F=1\) é impossível em todo \(D=0\) (e, consequentemente, em todo o ramo \(F\)).*

*Demonstração.* Pelo Teorema F2 basta tratar \(R\ne0\) em \(F^c\), com orçamento normalizado em unidades de \(pM\) dado por \(b_{F^c}\le\frac{M}{2p}+\frac{w_R}{16}\) (onde \(w_R=\Pr_{F^c}(R=1)\)) e \(E_4=X^2-M^2+16pR\ge0\).
Em \(F^c\), vale \(X/4\equiv R+2V'\bmod4\) com \(\deg V'\le4\): em \(R=0\) temos \(V'|_{R=0}=V\) (custo por unidade de \(V\) dado por \(A=16(4t-1)=63/4\)), e em \(R=1\) escrevemos \(X\equiv-252(-1)^S+\sum_{j=4}^8 2^j C_j\bmod2^9\) com \(S=V'|_{R=1}\), pois \(-252(-1)^S\equiv4+8S\bmod16\). Em qualquer fibra \(J\) de \(R=1\) (de codimensão absoluta \(c_{\mathrm{abs}}\)), os dígitos sucessivos \(C_4,\dots,C_8\) têm graus máximos:
- **Geral (\(\deg S|_J\le4\)):** \((8,9,10,12,13)\). Em \(j=4\), expanda o levantamento de \(S\bmod4\) até dois monômios de sua ANF. Para \(j\ge5\), se os bits anteriores zeram, \(S\bmod2^{j-3}\) é determinado por \(X=-252+504S\bmod2^j\). Escolha o representante multilinear inteiro \(A\) módulo \(2^{j-3}\). Em grau \(d\) seus coeficientes têm valoração pelo menos \(\max(0,\lceil3d/4\rceil-3)\), e são pares para \(d>4\). Como \(S^2=S\), temos \(S\equiv A^2\bmod2^{j-2}\). Termos cruzados pagam um fator dois adicional. Nos passos \(j=5,6,7,8\), os maiores graus de um termo que não zera são, respectivamente, \(9,10,12,13\), pela restrição \(1+\nu_2(A_I)+\nu_2(A_K)\le j-3\) dos termos cruzados. Os termos diagonais não aumentam de grau.

- **Cúbico (\(\deg S|_J\le3\)):** \((6,8,10,12,13)\), pois \(\deg(X\bmod32)\le5\) e \(-252(-1)^S\equiv4-8\widetilde S+16\binom{\widetilde S}2\bmod32\) dão \([C_4|_J]_6=\gamma_2([S|_J]_3)\), e quando \(C_4|_J=0\) tem-se \(\gamma_3([S|_J]_3)=[S|_J]_3\wedge\gamma_2([S|_J]_3)=0\) (como na Seção 10.2), anulando o termo de grau \(9\) de \(-32\binom{\widetilde S}3\) módulo \(64\) e forçando \(\deg C_5|_J\le8\);
- **Quadrático (\(\deg S|_J\le2\)):** \((5,6,8,10,12)\), pois em \(\mathbb Z[x]\) os coeficientes de Möbius \(\alpha_I\) de \(4(-1)^S\) satisfazem \(\nu_2(\alpha_I2^{d-|I|})\ge d-\lfloor|I|/2\rfloor+2\ge\lceil d/2\rceil+2\ge j+1\) para todo \(d\ge2j-3\).

Aqui \(\widetilde S\) é a soma inteira dos monômios da ANF de \(S\). As potências divididas surgem nos símbolos de maior grau dos coeficientes binomiais desse levantamento.

Em cada regime, rastreamos explicitamente \(c_{\mathrm{abs}}\) pela recorrência exata \(b_{\min}(j,c_{\mathrm{abs}})\) usando a classificação de Kasami–Tokura (partição disjunta em hiperplanos para o Tipo 1 com \(\deg_j-2\) fatores comuns, e partição disjunta em fatores comuns + blocos \(\{u\ne\mathbf 1\}\times\{v\ne\mathbf 1\}\) para o Tipo 2 em \(3\le\mu\le\deg_j\)), os flats de zeros de codimensão \(2\) e \(3\) de Klein–Storme, e a granularidade de Fourier da Seção 2.1 em \(j=9\) (\(b_{\min}(9,c_{\mathrm{abs}})=8(4t-1-16\cdot2^{c_{\mathrm{abs}}}/M^2)\)). Para \(c_{\mathrm{abs}}\le6\), obtém-se em aritmética racional exata:
\[
b_{\mathrm{gen}}(4,c_{\mathrm{abs}})=\frac{285}{512}\approx0{,}5566,\qquad
b_{\mathrm{cub}}(4,c_{\mathrm{abs}})=\frac{285}{128}\approx2{,}2266,\qquad
b_{\mathrm{quad}}(4,c_{\mathrm{abs}})=\frac{285}{64}\approx4{,}4531.
\]
Na recorrência da Seção 10.4, o custo do suporte e o custo dos cortes nulos são somados em conjuntos disjuntos. Para uma palavra de grau máximo \(d\) e peso inferior a dois pesos mínimos, o Tipo 1 separa o primeiro zero de seus \(d-2\) fatores comuns. O \(i\)-ésimo corte tem codimensão adicional \(i\) e densidade \(2^{-i}\). Para o Tipo 2, com parâmetro \(\mu\), separe primeiro os \(d-\mu\) fatores comuns da mesma forma. Na fibra restante, escolha o primeiro zero nas duas famílias de \(\mu\) variáveis. Os cortes \((i,j)\) têm codimensão adicional \(d-\mu+i+j\) e densidade \(2^{-(d-\mu+i+j)}\). Pode-se descartar a região em que ambos os produtos valem um. Nos regimes de Klein–Storme, usa-se um único zero de codimensão dois ou três e o suporte, que são disjuntos. Caso o grau efetivo seja menor que \(d\), o peso é ao menos dois pesos mínimos de ordem \(d\), portanto cai no regime seguinte. Quando o corte se origina em \(J_{\min}\) de \(R=0\), a parte quártica em coordenadas livres de \(V'\) independe dos controles de \(R\), já que o grau total é no máximo quatro. O mesmo corte em cada fibra de \(R=1\) anula essa parte e reduz \(S\) a cúbica na codimensão absoluta indicada.

Pelo Lema Mestre, \(\beta_R=\beta_Q\) restringe os pares \((h,w_R)\) com \(R\) não constante a exatamente \(7\) possibilidades (mais \(h=0,R\equiv1\)):
1. *\((h,w_R)\in\{(0,\frac12),(1,\frac12),(2,\frac12),(2,\frac58),(1,\frac34)\}\) com \(c_0\in\{1,3,5,4,2\}\):* se alguma fibra \(J_0\) de \(R=0\) tiver \(V=0\), o coeficiente quártico constante \(c_4\) de \(V'\) em coordenadas da fibra anula-se, dando \(\deg S|_J\le3\) em todas as fibras de \(R=1\) e custo \(\ge w_R b_{\mathrm{cub}}(4,c_0+1)>b_{F^c}\). Se \(V\ne0\) em todas as \(N_0\) fibras de \(R=0\), tomamos a fibra \(J_{\min}\) de menor peso relativo \(w_{\min}\) (em unidades de \(1/16\)). O orçamento residual impõe \(w_{\min}<2\) (para \(w_R\le\frac58\)) ou \(w_{\min}<11/4\) (para \(w_R=\frac34\)); particionando de forma disjunta os zeros de \(V|_{J_{\min}}\) nas coordenadas da fibra (KT Tipos 1–2, KS codim \(2\) ou \(3\)), todo flat de zeros nas coordenadas da fibra anula \([V']_4\) nas mesmas coordenadas de fibra em todas as fibras de \(R=1\), reduzindo \(S\) a grau \(\le3\) nesses subconjuntos disjuntos. Em todos os casos obtém-se custo total estritamente acima de \(b_{F^c}\) (menor margem em \((1,\frac34)\): \(1{,}1893>1{,}0547\)).
2. *\(h=2,w_R=\frac38\) (\(c_0=4,N_0=10\) zeros de \(z_1z_2+z_3z_4\)):* como nenhum hiperplano de \(\mathbb F_2^4\) contém mais de \(6\) zeros de \(z_1z_2+z_3z_4\), se \(k\le3\) fibras de zeros têm \(V\ne0\), o anulamento de \(V\) em \(\ge7\) fibras força todos os coeficientes cúbicos afins \(c_3(z)\) a se anularem, deixando \(\deg S|_{R=1}\le2\) e custo \(\ge\frac38 b_{\mathrm{quad}}(4,5)\approx1{,}6699>1{,}0313\). Se \(4\le k\le9\), resta ao menos uma fibra com \(V=0\) (\(\deg S|_{R=1}\le3\)) e custo \(\frac4{16}(A/16)+\frac38 b_{\mathrm{cub}}(4,5)>1{,}0811>b_{F^c}\). Se \(k=10\), o mesmo corte de \(J_{\min}\) dá \(>1{,}2836>b_{F^c}\).
3. *\(h=1,w_R=\frac14\) (\(c_0=2,N_0=3\) zeros de \(z_1z_2\)):* para \(k=0\) (os três zeros têm \(V=0\)), \(V'|_{R=1}\) fica quadrática, dando \(\frac14 b_{\mathrm{quad}}(4,3)\approx1{,}1133>1{,}0235\). Para \(k=1\) (\(V=0\) em \((0,0),(0,1)\) e \(V=B_1(y)\ne0\) em \((1,0)\)), tem-se \(w_{J_2}<2\) e nos zeros de \(B_1\) a restrição \(S|_{R=1}=1+B_1+C\) fica quadrática (e cúbica fora), dando \(>1{,}2202>b_{F^c}\). Para \(k=2\) e \(k=3\), os custos são \(\ge1{,}0488\) e \(\ge1{,}1906\), ambos \(>1{,}0235\).
4. *\(h=0,R\equiv1\):* em \(F\) temos \(W_f(1,b')=-512+2^{17}k(b')\) e em \(F^c\) temos \(W_f(0,b')=256X(0,b')\) com \(X(0,b')\equiv4+8S(b')\bmod16\), logo \(W_{f_0}(b')=128X(0,b')-256+2^{16}k(b')\). Para todo \(4\)-subespaço \(W\subseteq\mathbb F_2^{31}\) e \(U=W^\perp\) (\(\dim U=27\)), Poisson dá
   \[
   Z((f_0+b'_0\cdot y)|_U)=\frac1{16}\sum_{w\in W}W_{f_0}(b'_0+w)=8\sum_{w\in W}X(0,b'_0+w)-256+4096\sum_{w\in W}k(b'_0+w).
   \]
   Pelo teorema de Ax em \(U\) (\(\dim U=27\), \(\deg f_0\le4\)), vale \(2^{\lceil27/4\rceil}=128\mid Z((f_0+b'_0\cdot y)|_U)\), obrigando \(16\mid\sum_{w\in W}X(0,b'_0+w)\). Como \(\sum_{w\in W}(4+8S(b'_0+w))\equiv8\operatorname{wt}(S|_{b'_0+W})\bmod16\), vem \(2\mid\operatorname{wt}(S|_{b'_0+W})\) em todo flat \(4\)-dimensional de \(F^c\), isto é, \(\deg S\le3\) em todo \(F^c\). Mas então \(b_{F^c}\ge b_{\mathrm{cub}}(4,1)=\frac{285}{128}\approx2{,}2266>\frac{2175}{2032}\approx1{,}0704\ge b_{F^c}\), contradição. \(\square\)

### 10.5. Caso global \(D=0, h=0\): restrições de momentos, radical trivial e \(\gamma_2([C_9]_{12})=0\)
No caso global \(h=0\), normalizando \(Q\equiv0\), temos \(W_f(b)=-512+2^{17}k(b)\) com \(k(b)\in\{0,1\}+127\mathbb Z\), \(\sum k=2^{24}\pm2^{15}\) e \(\sum k^2=2^{30}+2^{16}\pm2^8\). Como \((\sum k^2)/126<2^{24}-2^{15}\), o dígito \(C_9=k\bmod2\) não pode ser nulo e \(\#\{k\ne0\}\le25\,400\,059<2^{25}\). Para \(|k|\ge126\) vale \(k(k-1)\ge126\cdot127=16\,002\); de \(\sum k(k-1)\le2^{30}-2^{24}+2^{16}+2^{15}+2^8\) segue a cota refinada \(\#\{|k|\ge126\}\le66\,058\). Além disso, \(T(b)=\frac{k(b)(k(b)-1)}{2}\) (suportada em \(S_{\mathrm{big}}=\{|k|\ge126\}\), com \(T\bmod2=C_{10}\)) tem transformada de Fourier \(\widehat T(a)=\frac{\Delta_f(a)}{8}-16\,256(-1)^{f(a)}-8\,355\,840\,\delta_{a,0}\equiv128+256f(a)\bmod512\) (pois \(2^{12}\mid\Delta_f(a)\) para \(a\ne0\)). Como \(\mathrm{wt}(f|_U)\) é par em todo \(8\)-subespaço \(U\), Poisson dá \(2\mid\sum_{W_{24}}T\) em todo \(24\)-subespaço afim (\(\deg C_{10}\le23\)), enquanto \(4\mid\sum_{W_{24}}k\) e \(k\equiv C_9+2C_{10}\bmod4\) implicam \([C_{10}]_{24}=\gamma_2([C_9]_{12})\); logo \(\gamma_2([C_9]_{12})=0\) (onde \([C_9]_{12}=\star\gamma_5(a_f)\)).

**Teorema G1 (Trivialidade do radical quártico).** *No caso global \(D=0,h=0\) para \((32,127)\), o símbolo quártico \(a_f=[f]_4\) satisfaz \(\operatorname{rad}(a_f)=\{0\}\) (nenhuma variável pode ser eliminada de \([f]_4\)).*

*Demonstração.* Suponha \(e_1\in\operatorname{rad}(a_f)\), isto é, \(x_1\) não ocorre nos monômios de grau \(4\) de \(f\). Somando \(x_1\) a \(f\) se necessário (o que desloca \(b\mapsto b+e_1\) e preserva \(W_f\equiv-512\bmod2^{17}\)), assuma \(f(x_1,x')=g(x')+x_1h(x')\) com \(\deg h\le2\) e \(h(0)=0\) (\(h\ne0\), senão \(W_f(e_1)=0\)). Temos \(\nu_2(Z(f))=9\) (pois \(Z(f)=W_f(0)\equiv-512\bmod2^{17}\)). Marcando todos os monômios de \(x_1h(x')\), a parte sem marcados é \(2Z(g)=W_f(0)+W_f(e_1)\equiv-1024\bmod2^{17}\), de valoração \(\nu_2(2Z(g))=10\). Para cada seleção de \(l\ge1\) monômios marcados, a união \(A'\subseteq\{2,\dots,32\}\) é não vazia de tamanho \(c'=|A'|\le2l\), e a restrição ocorre em \(J=\{x_1=1,\,x_i=1\;(i\in A')\}\) de codimensão \(c=1+c'\le2l+1\) com deslocamento afim \(x_0\notin U\) (que anula a soma de \(-512\) em \(U^\perp\)). Assim Poisson dá \(\nu_2(2^lZ(f|_J))\ge l+(17-c)\ge16-l\), e Ax em \(J\) (\(\dim=31-c'\)) dá \(\nu_2(2^lZ(f|_J))\ge l+\lceil(31-c')/4\rceil\ge\lceil(31+2l)/4\rceil\). Como \(\max(16-l,\lceil(31+2l)/4\rceil)\ge10\) para todo \(l\ge1\), obtém-se \(2^{10}\mid Z(f)\), contradizendo \(\nu_2(Z(f))=9\). \(\square\)

**Teorema G2 (Inexistência de hiperplanos de zeros de \(C_9\) e isotropia de \(a_f\) em flats de zeros de codimensão \(\le4\)).** *No caso global \(D=0,h=0\) para \((32,127)\):*
1. *Para todo subespaço afim \(J\subseteq\mathbb F_2^{32}\) de codimensão \(c\le8\) (\(V=\vec J^\perp\), \(\dim V=c\)), vale \(\sum_{b\in J}k(b)=2^{24-c}+2^{15-c}Z((f+b_0\cdot x)|_V)\in[2^{24-c}-2^{15},\,2^{24-c}+2^{15}]\); e para todo flat afim \(W_{28}\) de dimensão \(28\) (\(c=4\), \(U_4=\vec W_{28}^\perp\)), vale \(\sum_{b\in W_{28}}T(b)\equiv16\,a_f(U_4)\pmod{32}\).*
2. *O dígito \(C_9=k\bmod2\) não possui nenhum hiperplano de zeros (\(c=1\)).*
3. *Em todo flat de zeros \(J\) de \(C_9\) (\(C_9|_J\equiv0\)) de codimensão \(c\in\{2,3,4\}\), anulam-se \(C_{10}|_J=\cdots=C_{15}|_J\equiv0\) (isto é, \(128\mid k(b)\) e \(64\mid T(b)\) em todo \(J\)), o que força \(a_f(U_4)=0\) para todo \(4\)-subespaço \(U_4\supseteq\vec J^\perp\) (\(\iota_{\vec J^\perp}a_f=0\)).*

*Demonstração.* (1) Decorre diretamente de Poisson para \(W_f(b)=-512+2^{17}k(b)\) (com \(|Z((f+b_0\cdot x)|_V)|\le2^c\)) e de \(\widehat T(a)\equiv128+256f(a)\bmod512\) somado em \(U_4\) (\(\sum_{U_4}f\equiv a_f(U_4)\bmod2\)).
(2)–(3) Se \(C_9|_J\equiv0\) (\(c\le8\)), então \(k(b)\) é par em todo \(J\); como \(k(b)\in\{0,1\}+127\mathbb Z\), segue \(k(b)\in\{0\}\cup\{k\ge128\}\cup\{k\le-126\}\), logo \(k(b)^2-128k(b)\ge0\) em todo \(J\) e
\[
\sum_{b\in J}k(b)^2=128\sum_{b\in J}k(b)+\sum_{b\in J}\bigl(k(b)^2-128k(b)\bigr)\ge128(2^{24-c}-2^{15})+\sum_{b\in J}\bigl(k(b)^2-128k(b)\bigr).
\]
Para \(c=1\), isso dá \(\sum_{b\in J}k(b)^2\ge128(2^{23}-2^{15})=1\,069\,547\,520\). Como todo ponto com \(k(b)=1\) está em \(J^c\), resta \(\sum_{b\in S_{\mathrm{big}}\cap J^c}k(b)^2\le(2^{30}+2^{16}+2^8)-1\,069\,547\,520=4\,260\,096\), donde \(\sum_{b\in S_{\mathrm{big}}\cap J^c}|k(b)|\le\lfloor4\,260\,096/126\rfloor=33\,810\) e \(N_1\ge(2^{23}-2^{15})-33\,810=8\,322\,030\), contradizendo \(\sum_{\mathbb F_2^{32}}k^2\ge1\,069\,547\,520+8\,322\,030=1\,077\,869\,550>1\,073\,807\,616\).
Para \(c\in\{2,3,4\}\), por indução em \(j=10,\dots,15\), se \(C_9|_J=\cdots=C_{j-1}|_J=0\), o dígito \(C_j|_J\) tem grau \(\le\lfloor4j/3\rfloor\), peso mínimo \(2^{32-c-\lfloor4j/3\rfloor}\) caso não nulo, e excesso mínimo \(2^{32-c-\lfloor4j/3\rfloor}\min_{k\equiv2^{j-9}\bmod2^{j-8}}(k^2-128k)>(2^{30}+2^{16}+2^8-8\,220\,000)-128(2^{24-c}-2^{15})\), forçando \(C_{10}|_J=\cdots=C_{15}|_J\equiv0\). Logo \(128\mid k(b)\) e \(64\mid T(b)\) em todo \(J\); em particular, para todo \(28\)-subespaço afim \(W_{28}\subseteq J\), tem-se \(16\,a_f(\vec W_{28}^\perp)\equiv\sum_{b\in W_{28}}T(b)\equiv0\pmod{32}\), donde \(a_f(U_4)=0\) para todo \(U_4\supseteq\vec J^\perp\). \(\square\)

### 10.6. Contrações cúbicas exigem pelo menos quatro controles

No caso global \(D=h=0\), para todo \(v\ne0\), o símbolo cúbico \(\iota_v a_f\), no quociente físico por \(\langle v\rangle\), **não se anula em nenhum subespaço linear de codimensão até três**. Equivalentemente, não é possível escolher até três coordenadas de modo que cada monômio cúbico de \(\Delta_v f\) contenha ao menos uma delas. A seguir provamos a afirmação para três coordenadas. Um corte de codimensão menor pode ser refinado até três.

Lembre que \(\gamma_6(a_f)=0\). De fato, em qualquer 24-espaço linear físico, Poisson com codimensão oito dá uma soma de sinais divisível por \(2^9\). O seu termo de valoração seis, calculado pela expansão em monômios, é exatamente a paridade das coberturas por seis quárticas disjuntas. Essa paridade é a avaliação de \(\gamma_6(a_f)\) e zera em todo 24-espaço.

Escolha coordenadas \((x,t,z)\), onde \(x\) tem direção \(v\), \(t\in\mathbb F_2^3\) e \(z\in\mathbb F_2^{28}\), de modo que
\[
 f(x,t,z)=g_t(z)+x h_t(z),\qquad \deg h_t\le2.
\]
Ponha \(B=[g_t]_4\) nas coordenadas \(z\), independente de \(t\), e \(q(t)=[h_t]_2=q_0+\sum_{i=1}^3 t_i q_i\). A afinidade de \(q(t)\) segue de \(\deg f\le4\). Para cada \(t\), Poisson dá, em **toda frequência** da fatia de 29 variáveis,
\[
 W_{f|_t}\equiv-512\mathbf1_{\{t=0\}}\pmod{2^{14}} .
\]
Para \(t\ne0\), a soma de caracteres da translação cancela o termo constante de Walsh. Quando preciso, adicione \(x\) à função em uma fatia para normalizar \(h_t(0)=0\); isso só desloca o espectro na própria fatia, e não altera \(B\) nem \(q(t)\).

A inclusão-exclusão de G1 aplicada à fatia, marcando os monômios que contêm \(x\), tem parte sem marcados \(2Z(g_t)\) divisível por \(2^{10}\). Isso se vê somando as duas frequências que diferem no caráter de \(x\). Para uma interseção de \(\ell\) marcados, seja \(c'\le2\ell\) o número de coordenadas \(z\) fixadas em um, além de \(x=1\). A parcela tem valoração pelo menos
\[
 \max\bigl\{13+\ell-c',\,\ell+\lceil(28-c')/4\rceil\bigr\}.
\]
O primeiro limite vem de Poisson, pois a restrição tem \(x=1\), e o segundo da divisibilidade de grau quatro. Para \(\ell\le3\), o primeiro é ao menos dez; para \(\ell\ge5\), o segundo é ao menos dez. Com \(\ell=4\), o único caso que pode contribuir módulo \(2^{10}\) é \(c'=8\). Ele seleciona quatro monômios quadráticos disjuntos do \(h_t\); na direção complementar de dimensão 20, o termo de valoração cinco da soma é a cobertura por cinco monômios quárticos de \(B\). Portanto, em \(\mathbb F_2\),
\[
 \mathbf1_{\{t=0\}}=\frac{Z(f|_t)}{512}\bmod2
   =\operatorname{vol}_{28}\bigl(\gamma_4(q(t))\wedge\gamma_5(B)\bigr).
\]

No coeficiente de \(\gamma_6(a_f)\) envolvendo \(x,t_i\) e nenhuma outra coordenada \(t\), o fator que contém \(x\) tem de conter \(t_i\), pois \(h_t\) é quadrática em \(z\). O coeficiente correspondente é \(q_i\wedge\gamma_5(B)\). Logo \(q_i\wedge\gamma_5(B)=0\) para \(i=1,2,3\). Ao expandir \(\gamma_4(q(t))\), um termo que contenha os três \(t_i\) precisa usar os três \(q_i\), com pelo menos um deles tendo multiplicidade um, já que a multiplicidade total é quatro. Todos esses termos anulam após multiplicar por \(\gamma_5(B)\). O lado direito da identidade, portanto, tem coeficiente cúbico zero. O lado esquerdo é \(\prod_i(1+t_i)\) e tem coeficiente cúbico um. Contradição.

Como corolário, cada contração cúbica precisa de pelo menos oito formas lineares para suportar seu símbolo. De fato, em dimensão \(d\), um espaço isotrópico de dimensão \(r\) para uma 3-forma pode ser ampliado quando \(d-\binom r2>r\): a condição de que o novo vetor se anule com todo par do espaço impõe no máximo \(\binom r2\) condições lineares. Para \(d\le7\), isso constrói um espaço isotrópico de dimensão pelo menos \(d-3\), estendendo-o pelo radical das coordenadas restantes. Para \(d\le5\) também basta usar um espaço de dimensão até dois. Assim, por exemplo, uma contração expressável como soma de até três lâminas simples, ou uma decomposição do símbolo quártico em blocos independentes com um bloco não nulo de dimensão até oito, não pode ocorrer.

**Obstrução a somas de produtos.** O símbolo quártico \(a_f\) não é soma de quatro ou menos produtos exteriores \(A_i\wedge B_i\) de graus positivos que somam quatro. Isso inclui simultaneamente os tipos \(1+3\) e \(2+2\).

Se houvesse uma representação com \(r\le4\), escolha polinômios booleanos \(P_i,Q_i\) com os símbolos \(A_i,B_i\), de modo que \(f=c+\sum_{i=1}^rP_iQ_i\) com \(\deg c\le3\). Expanda a soma de sinais do produto
\[
 (-1)^c\prod_i(1-2P_i Q_i).
\]
Selecionar \(k\) fatores custa \(k\) potências de dois. Para cada fator selecionado, faça o levantamento inteiro dos dois bits \(P_i,Q_i\) como XOR de seus monômios. Uma escolha de \(m\ge1\) monômios em um bit custa \(m-1\) potências de dois. Os primeiros monômios dos dois bits cobrem no máximo quatro coordenadas por fator, e cada monômio adicional cobre até três. Na expansão do sinal de \(c\), cada monômio também cobre até três e custa uma potência de dois. Se \(j\) é esse custo adicional total, a união dos suportes tem tamanho no máximo \(4k+3j\). A soma desse monômio em 32 variáveis tem valoração pelo menos
\[
 k+j+\max(0,32-4k-3j)\ \ge\ k+\lceil(32-4k)/3\rceil
 =\lceil(32-k)/3\rceil\ \ge 10.
\]
Isso dá \(2^{10}\mid W_f(0)\), em contradição com \(W_f(0)\equiv-512\bmod2^{17}\). O argumento só usa a congruência 2-ádica global e a hipótese de grau.

**Zeros do símbolo quártico no espaço físico.** Nenhum subespaço físico linear de codimensão até cinco anula \(a_f\). Se \(c\le4\), a restrição nesse subespaço seria cúbica em \(32-c\ge28\) variáveis, e sua soma de sinais teria valoração pelo menos dez. Por Poisson, contudo, a soma é \(-512\bmod2^{17-c}\). Se \(c=5\), seja \(g\) a restrição cúbica em 27 variáveis, com símbolo \(b=[g]_3\). Em todo subespaço linear de dimensão 24 dentro dela, Poisson dá soma de sinais divisível por \(512\). Na valoração oito, essa soma conta as coberturas por oito cúbicas disjuntas. Portanto \(\gamma_8(b)\) zera em todo 24-espaço, logo \(\gamma_8(b)=0\). Na valoração nove, a soma de sinais em 27 variáveis conta \(\gamma_9(b)=b\gamma_8(b)=0\). A soma seria divisível por \(1024\), em contradição com \(-512\bmod2^{12}\).

### 10.7. Exceções e a fronteira da autocorrelação nula

Ponha \(P=\{b:T(b)\not\equiv0\bmod32\}\). Seja \(L\) um espaço físico de dimensão \(1\le c\le4\) tal que \(\iota_L a_f\ne0\). Complete sua base a um 4-espaço \(U\) com \(a_f(U)=1\). Todo coset de \(L^\perp\) contém um flat de direção \(U^\perp\); por G2, sua massa de \(T\) é \(16\bmod32\). Logo todo coset de \(L^\perp\) encontra \(P\). Por G1, tome \(c=1\) para concluir que \(P\) não está em nenhum hiperplano afim e contém pelo menos 33 pontos.

Se \(L\) tem dimensão 16 e \(\Delta_f=0\) em \(L\setminus\{0\}\), cada coset \(J\) de \(L^\perp\) tem energia média unitária para \(W_f^2/2^{32}\), pela identidade de autocorrelação. Substituindo \(W_f=-512+2^{17}k\), resulta
\[
 \sum_{b\in J}(128k(b)^2-k(b))/127=16512,\qquad
 \sum_{b\in J}k(b)=256+W_{f|_L}/2 ,
\]
onde a última transformada usa a frequência que rotula \(J\). Os custos do primeiro somatório são inteiros não negativos, valem zero em \(k=0\) e um em \(k=1\). Cada exceção custa pelo menos \(16002\). Portanto há no máximo uma exceção, e as únicas possíveis são \(-127,-126,127,128\). Sem exceção, o coeficiente de \(W_{f|_L}\) é \(32512\). Para essas quatro exceções, a massa de \(k\) é, respectivamente, \(128,384,384,128\), dando coeficientes \(-256,256,256,-256\). Por Parseval, todos os coeficientes têm módulo \(256\). Assim \(f|_L\) é bent e há exatamente uma exceção em cada um dos \(65536\) cosets. Essa conclusão é condicional à existência de \(L\).


---

## 11. Escopo e único resíduo ainda aberto em \((32,127)\)

Após as Seções 7–10 e os Apêndices A e B (comparações numéricas reproduzíveis em `verify_mod127_ramo_F.py`), ficam excluídos, usando também as dependências indicadas, em \((32,127)\):
- **todo** o caso hiperplano \(\operatorname{codim}F=1\) (para todos os semipostos \(0\le h\le16\) e todo \(D\));
- **todos** os semipostos \(h\ge1\) (\(1\le h\le16\)) no caso global;
- **todo** o caso \(D\ne0\) (\(w>0\)) global e hiperplano;
- o uso da obstrução local A1 em semiposto alto nas Seções 4, 6 e 7B, com a referência de fase indicada na Seção 12.

Em todo o problema \((n,p)=(32,127)\), resta portanto **um único subcaso aberto**:

- **\(D=0, h=0\), \(F\) global:** \(W_f(b)=-512+2^{17}k(b)\) em todo \(\mathbb F_2^{32}\) com \(\operatorname{rad}(a_f)=\{0\}\), \(\gamma_6(a_f)=0\), \(C_9=k\bmod2\not\equiv0\) sem hiperplano de zeros, \(\iota_{\vec J^\perp}a_f=0\) em todo flat de zeros \(J\) de \(C_9\) de codimensão \(c\in\{2,3,4\}\), \(\gamma_2([C_9]_{12})=0\) e \(\#\{|k|\ge126\}\le66\,058\).

---

## 12. Apêndice A: Prova autocontida da obstrução local de semiposto alto (\(h'\ge5\)) para as Seções 4, 6 e 7B

Para explicitar a entrada local das Seções 4, 6 e 7B, registramos aqui o lema exterior local em semiposto \(\ge5\):

**Lema A1 (Obstrução local para semiposto \(h'\ge5\)).** *Seja \(H\subseteq\mathbb F_2^{32}\) um subespaço afim no qual \((1+Q)D=0\) (no ramo ímpar, Seção 4) ou \((1+R)V=0\) (no ramo \(4\mid X\), Seções 6 e 7B), tal que a forma quadrática restrita \(Q|_H\) (resp. \(R|_H\)) tenha símbolo \(q=[Q|_H]_2\) (resp. \(r=[R|_H]_2\)) de semiposto \(h'\ge5\). Se o orçamento normalizado local em \(H\) é estritamente menor que \(\frac{16(8t-1)}{64}=\frac{95}{128}\), obtém-se contradição.*

*Demonstração.* No ramo \(4\mid X\), partimos de \(X\equiv4pR+8V\bmod16\). Usamos \(V'=V+R\) em \(\mathbb F_2\), de modo que \(X\equiv-4pR+8pV'\bmod16\) e \((1+R)V'=0\). No ramo ímpar, use \(Q,D\) diretamente. Como \((1+Q)D=0\) em \(H\), a multiplicação exterior por \(q\) anula o símbolo líder de \(D|_H\); pela exatidão de \(\wedge q\) em grau \(k\le4<h'\). Para ver a exatidão, fixe a parte radical e os pares de Darboux presentes com uma única coordenada. O operador adiciona um par completo entre os pares não ocupados por uma coordenada simples. A deleção de um par fixo dentre esses pares é uma homotopia contrátil, pois sua anticomutação com a adição daquele par é a identidade e com as outras adições é zero. Há pelo menos um par disponível porque \(k<h'\). A descida de símbolos fornece \(D|_H=QR_2\) (resp. \(V'|_H=RS_2\)) com \(\deg R_2\le2\) e símbolo \(r_2=[R_2]_2\).
Considere a referência inteira \(P=M-p-4pQ+(8p-2M)QR_2\) (no ramo ímpar) ou \(P=M-4pR+8pRS_2\) (no ramo \(4\mid X\)). Como \(Q\bmod8=\widetilde Q-2\binom{\widetilde Q}{2}+4\binom{\widetilde Q}{3}\) e \(QR_2\bmod4=(\widetilde Q-2\binom{\widetilde Q}{2})(\widetilde R_2-2\binom{\widetilde R_2}{2})\bmod4\) têm grau no máximo \(6\), o dígito de desvio \(B_4=((X-P)/16)\bmod2\) tem grau \(\le6\) em \(H\) e custo pontual \(\ge16(8t-1)=95/2\). Como o orçamento local em \(H\) é \(<\frac{95/2}{64}=\frac{95}{128}\), a distância mínima \(2^{-6}\) em \(\mathrm{RM}(6,H)\) força \(B_4=0\) em todo \(H\), isto é, \(X\equiv P\bmod32\) em \(H\).
Pela filtração inteira, \(\deg(X\bmod32)\le5\), logo o símbolo de grau \(6\) de \((P\bmod32)/16\) deve anular-se em \(H\):
\[
\gamma_3(q)+r_2\wedge\gamma_2(q)+q\wedge\gamma_2(r_2)=0.
\]
Multiplicando exteriormente por \(q\) (usando \(q\wedge q=0\) e \(q\wedge\gamma_3(q)=0\)), vem \(r_2\wedge\gamma_3(q)=0\). Como \(h'\ge5\), o núcleo de \(\wedge\gamma_3(q)\) em \(\bigwedge^2\) é exatamente \(\mathbb F_2q\) (monômios que usam coordenadas do radical ou coordenadas simples de pares de Darboux são detectados completando com \(3\) pares livres de Darboux, e no setor dos pares inteiros de Darboux o anulamento das somas sobre todos os \(4\)-subconjuntos de \(\ge5\) pares força coeficientes iguais). Portanto \(r_2\in\{0,q\}\); substituindo na equação de grau \(6\) (e usando \(q\wedge\gamma_2(q)=\gamma_3(q)\) e \(1+1+1\equiv1\bmod2\)), resta \(\gamma_3(q)=0\), contradizendo \(h'\ge5\ge3\). \(\square\)

## 13. Apêndice B: transferência da obstrução quártica módulo 64

Usamos a Seção 4.1, equações (7)–(8), e a Seção 4.2 de [Walsh rigidity modulo 17 for Boolean functions of degree at most four in twenty variables, pp. 8–10](https://chatgpt.com/library?file_id=libfile_d964fa20e52c8191936371c270ee0542&account_id=personal). A entrada empregada aqui é local. Ela afirma que, em um espaço afim com semiposto polar \(h'\ge7\), não podem zerar simultaneamente os dois dígitos de desvio módulo 64 do modelo
\[
 \deg X'\bmod64\le6,\quad
 Y'=(-1)^QX'\equiv 2-72D\bmod64,\quad \deg Q\le2,\quad \deg D\le4.
\]
De fato, para \(a=[D]_4\) e \(q=[Q]_2\), a primeira comparação dá \(\gamma_2(a)=0\), \(\deg\Gamma_2(D)\le6\) e \([\Gamma_2(D)]_6=qa+\gamma_3(q)\). Aqui \(\Gamma_i\) é o coeficiente binomial da soma inteira dos monômios da ANF, reduzido módulo dois. O símbolo de grau dez da comparação seguinte é \(a\gamma_3(q)\). A Seção 4.2 prova que essas identidades são incompatíveis em um complemento simplético de dimensão pelo menos 14. Pode-se passar a esse complemento porque a hipótese de anulação dos dígitos, a filtração inteira e as duas cotas de grau sobrevivem à restrição. Nenhuma estimativa de energia nem condição CRT particular do módulo 17 entra nessa obstrução.

No modelo deste manuscrito, ponha \(X'=-X\) e \(Y'=-Y\). As duas referências satisfazem
\[
 r_D+(2-72D)=-576D\equiv0\pmod{64}.
\]
Logo a anulação simultânea de \(B_4,B_5\) é exatamente a congruência do modelo local. Em qualquer zero afim de \(B_4\) a mesma comparação prova \(\deg B_5\le10\), ainda com \(D\) quártica. Se o semiposto no corte é pelo menos sete, \(B_5\) não zera identicamente, e sua densidade é ao menos \(2^{-10}\). Se o semiposto é pelo menos oito, peso mínimo implicaria que \(B_5\) é o indicador de uma fibra. Um hiperplano disjunto dela reteria semiposto pelo menos sete e anularia os dois dígitos. Logo, neste último caso, a segunda distância dá densidade \((3/2)2^{-10}\) ou maior.

Para explicitar o uso no item 4 da Seção 7, ponha \(\mu=2^{-8}\), \(k_0=h-7\ge7\); \(B_4\) tem grau no máximo oito. Onde \(B_4=1\), \(E/(pM)\ge a\). Onde \(B_4=0,B_5=1\), \(E/(pM)\ge b\), com \(a=95/4\), \(b=555/2\). Suponha que o custo médio seja menor que \(a(3-2^{1-k_0})\mu\), então \(\omega=\Pr(B_4=1)<(3-2^{1-k_0})\mu\).

- Se \(B_4=0\), a cota melhorada de \(B_5\) contradiz o orçamento.
- Se \(0<\omega<2\mu\), Kasami–Tokura dá três possibilidades. Com pelo menos dois fatores comuns, os hiperplanos que evitam a fibra cobrem com multiplicidade constante pelo menos \(3/4\) do espaço. Com um fator comum e dois produtos disjuntos de sete fatores, \(\omega\ge(7/4)\mu\) e um hiperplano nulo tem densidade \(1/2\). Com dois produtos disjuntos de oito fatores, os cortes nulos de codimensão dois cobrem com multiplicidade constante mais de \(3/4\) do espaço, escolhendo uma forma afim não trivial por bloco que evite o suporte do produto. Os cortes retêm semiposto pelo menos oito. As cotas são, respectivamente, \( (3/4)(3/2)b\,2^{-10}\), \( (7/4)a\mu+(3/2)b\,2^{-11}\) e \( (3/4)(3/2)b\,2^{-10}\), todas maiores que \(3a\mu\).
- Se \(2\mu\le\omega\), tome o menor \(k\ge2\) tal que \(\omega<(3-2^{1-k})\mu\). Então \(k\le k_0\) e \(\omega\ge(3-2^{2-k})\mu\). Klein–Storme fornece um zero de codimensão \(k\). Se \(k<k_0\), o semiposto residual é ao menos oito. A soma de custos disjuntos é pelo menos \(3a\mu+2^{-k}((3/2)b\,2^{-10}-4a\mu)>3a\mu\). Se \(k=k_0\), o semiposto residual é ao menos sete e basta a cota simples, pois \(a(3-2^{2-k_0})\mu+b\,2^{-10-k_0}>a(3-2^{1-k_0})\mu\).

Isso prova a cota conjunta diretamente para a medida relativa a \(F\), global ou hiperplano. Na aplicação em hiperplano de semiposto alto, se \(\mathbb E_F Y^2\ge M^2\), Parseval dá \(\mathbb E_{F^c}X^2\le M^2\). O Lema Mestre da Seção 10.4 usa apenas os resíduos módulo oito e vale mesmo se \(D\ne0\). Ele dá semiposto \(h\) para \(R\) em \(F^c\). O custo de \(E_4/(pM)\) ali é no máximo \(1/16\). O suporte de \((1+R)V\), se não vazio, pagaria ao menos \(63/256\), logo esse produto zera. A1 dá a contradição em semiposto pelo menos cinco. Assim nesse caso \(\mathbb E_F Y^2<M^2\), que é a única comparação de energia exigida pelo item 4.
