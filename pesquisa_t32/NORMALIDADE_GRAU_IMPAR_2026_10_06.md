# Normalidade forçada por grau ímpar e consequências para a busca quíntica

Data: 6 de outubro de 2026.

## Lema estrutural

Seja (n=2h) e seja (f:\mathbb F_2^n\to\mathbb F_2) uma função homogênea de grau ímpar e simétrica por rotação. Defina

[
A=\{(u,u):u\in\mathbb F_2^h\}.
]

A meia-volta das coordenadas é uma involução sem pontos fixos. Nenhum monômio de suporte ímpar pode ser fixado por essa involução. Portanto os monômios da ANF aparecem em pares que coincidem depois da substituição (x=(u,u)), e

[
f|_A=0.
]

Assim, qualquer HRSBF homogênea de grau ímpar que fosse bent seria automaticamente uma função bent **normal** sobre o subespaço (A).

## Sinal do coeficiente de Walsh em zero

Suponha agora que (f) seja bent. Para (b\in A^\perp),

[
W_f(b)=\pm 2^h.
]

Por ortogonalidade de caracteres,

[
\sum_{b\in A^\perp}W_f(b)
=|A^\perp|\sum_{x\in A}(-1)^{f(x)}
=2^h 2^h
=2^{2h}.
]

Há exatamente (2^h) parcelas, cada uma de módulo (2^h). A soma atinge o máximo possível, logo todas são positivas:

[
W_f(b)=+2^h\qquad(b\in A^\perp).
]

Como (A=A^\perp) para a diagonal ((u,u)) em característica dois, a dual bent também se anula nesse mesmo subespaço.

Em particular,

[
W_f(0)=+2^h
]

e o peso é forçado:

[
\operatorname{wt}(f)
=2^{n-1}-2^{h-1}.
]

Para (n=16),

[
\operatorname{wt}(f)=32768-128=32640.
]

Portanto uma HRSBF homogênea quíntica bent em 16 variáveis **não pode** ter peso 32896.

As campanhas antigas que aceitavam os dois pesos bent possíveis foram conservadoras: elas admitiam falsos positivos extras, mas não eliminavam nenhum candidato bent válido. Pesquisas futuras devem exigir apenas 32640.

Esta normalidade e suas consequências para cosets são propriedades clássicas de funções bent normais; nenhuma novidade bibliográfica é reivindicada para essa parte. Ver, por exemplo, a literatura de normalidade de bent functions e a discussão de Carlet sobre normalidade/dualidade.

## Fibras e redução para 35 classes

Escreva

[
F_z(u)=f(u,u+z),\qquad u,z\in\mathbb F_2^8.
]

A meia-volta também fornece

[
F_z(u+z)=F_z(u).
]

Logo, para (z\ne0), cada fibra fatora pelo quociente

[
\mathbb F_2^8/\langle z\rangle
]

de 128 pontos.

A rotação de oito coordenadas age nos vetores (z\ne0). Existem exatamente **35 classes cíclicas**. Assim, para uma função RS, testar o peso de um representante por classe equivale a testar todas as 255 fibras não nulas.

Se todas as 255 fibras forem balanceadas, então

[
\operatorname{wt}(f)
=\sum_{z\ne0}\operatorname{wt}(F_z)
=255\cdot128
=32640.
]

Logo o teste de peso global é redundante depois do balanceamento de todas as fibras.

## Identidade agregada das derivadas diagonais

Para uma fibra balanceada (F_z), (z\ne0), deixe (g_z) ser a função induzida no quociente de dimensão sete.

Para qualquer função balanceada (g\) em (m) variáveis,

[
\sum_{q\ne0}\operatorname{wt}(D_qg)=2^{2m-1}.
]

Isso segue de

[
\sum_q \operatorname{AC}_g(q)=W_g(0)^2=0
]

e

[
\operatorname{AC}_g(q)=2^m-2\operatorname{wt}(D_qg).
]

Com (m=7), a soma vale (8192).

Cada direção não nula do quociente possui duas elevações (p,p+z) em (mathbb F_2^8), e cada valor da derivada no quociente possui duas elevações na fibra. Portanto

[
\sum_{p\notin\{0,z\}}\operatorname{wt}(D_pF_z)
=4\cdot8192
=32768.
]

Defina

[
G_p=\operatorname{wt}(D_{(p,p)}f)
=\sum_z\operatorname{wt}(D_pF_z).
]

Se todas as fibras não nulas forem balanceadas,

[
\sum_{p\ne0}G_p
=255\cdot32768.
]

Portanto a média das 255 derivadas diagonais já é exatamente o valor bent necessário. Bentness exige mais: cada (G_p) deve ser individualmente 32768.

Como (G_p) é constante em classes de rotação, temos 35 valores de classe com a relação linear ponderada

[
\sum_{[p]} |[p]|\,(G_p-32768)=0.
]

Assim, **depois de todas as fibras balanceadas, uma das 35 condições de derivada diagonal é redundante**: se 34 classes tiverem peso 32768, a última é forçada pela identidade agregada.

## Auditor comprimido

O arquivo `compressed_quintic_constraints.py` implementa exatamente:

- as 35 classes de fibras;
- os 255 pesos de fibras via multiplicidades das classes;
- o peso global;
- as 35 classes de derivadas diagonais (D_{(p,p)}f).

Ele usa apenas inteiros Python e biblioteca padrão.

A identidade de transporte usada é a seguinte. Se (R) é a rotação em oito coordenadas e (z_s=R^sz), então a transformação entre (F_z) e (F_{z_s}) é afim com parte linear (R^s). Portanto

[
\operatorname{wt}(D_pF_{z_s})
=
\operatorname{wt}(D_{R^{-s}p}F_z).
]

Isso permite reconstruir todas as derivadas diagonais a partir de apenas 35 tabelas de 256 bits.

A implementação foi comparada bit a bit com o auditor completo para candidatos independentes; os pesos global, de fibras e das 35 derivadas diagonais coincidiram.

## Implicação para a estratégia de pesquisa

O alvo em (n=16,d=5) continua legítimo. O teorema geral de Meng et al. sobre graus próximos de (n/2) não exclui este caso: para (d=5=8-3), o limiar correspondente ao parâmetro (k=3) ocorre apenas em dimensões maiores.

A literatura recente ainda descreve a existência de bent homogêneas de grau maior que três como problema aberto em geral. Isso não estabelece novidade para qualquer resultado futuro no caso RS, mas confirma que a busca não está atacando um caso já trivialmente proibido por um teorema geral conhecido.

## Estado científico

- anulação diagonal para grau ímpar RS: **prova algébrica**;
- sinal positivo de (W_f(0)) sob bentness: **consequência exata da normalidade**;
- peso obrigatório 32640 em (n=16): **prova algébrica**;
- redução de 255 fibras a 35 classes: **simetria exata**;
- identidade média das derivadas diagonais: **prova algébrica**;
- redundância de uma das 35 derivadas depois de todas as fibras balanceadas: **prova algébrica**;
- inexistência de HRSBF quíntica bent em (n=16): **não provada**.
