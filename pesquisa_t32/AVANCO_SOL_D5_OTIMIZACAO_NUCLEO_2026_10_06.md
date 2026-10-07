# Quinta rodada Sol — otimização exata dos 7 bits invisíveis

Data: 6 de outubro de 2026.

A decomposição

[
273=266+7
]

permite separar a pesquisa em duas etapas.

Os 266 bits do quociente controlam as fibras e todas as derivadas diagonais. Os sete bits do núcleo têm a forma

[
k(u,v)=h(u+v).
]

Eles não alteram nenhum teste de balanceamento de fibra nem nenhuma derivada diagonal, mas alteram as derivadas não diagonais.

## Transformada de 128 pontos

Para uma direção (d=(a,b)), ponha (q=a+b). A contribuição do núcleo é

[
D_dk=D_qh(z),
]

constante em (u) dentro de cada fibra.

Se a contribuição da função-base à autocorrelação da fibra (z) for (C_z), então

[
\operatorname{AC}_{f+k}(d)
=
\sum_z C_z(-1)^{D_qh(z)}.
]

A função (h) depende linearmente de sete coeficientes. Assim, para cada direção, os 128 valores possíveis de autocorrelação são exatamente uma transformada de Walsh de comprimento 128.

O arquivo `kernel_coset_optimize_d5.py` usa essa identidade para avaliar simultaneamente todos os 128 lifts de um ponto do quociente.

## Controle exato

No candidato-base

`0x1b93d5a542da0dd31aa5e9bb862362c378c3509303971333987cfca4fbf49afd3e679`

as 128 variantes mantêm exatamente as mesmas 87 fibras ruins.

A variante original possui:

- energia de autocorrelação: 9.915.138.048;
- 144 das 4.115 classes de derivadas balanceadas;
- 2.304 das 65.535 direções não nulas balanceadas.

A melhor variante pela energia é a escolha de núcleo 23:

- energia: **9.100.001.280**;
- redução exata de aproximadamente 8,2%;
- 140 classes balanceadas.

A variante que maximiza o número de classes exatamente balanceadas é a escolha 19:

- **166 classes** balanceadas;
- energia: 9.508.945.920.

Nenhuma das 128 variantes desse coset atinge o peso obrigatório 32640; os pesos variam de 31552 a 32064. Portanto este coset inteiro pode ser descartado como fonte de uma HRSBF bent.

## Consequência estratégica

A busca não deve mais gastar esforço mutando os sete bits do núcleo.

Procedimento mais eficiente:

1. procurar apenas no quociente de 266 dimensões;
2. aplicar condições de fibras e derivadas diagonais nesse representante;
3. para sobreviventes, otimizar/exaurir os 128 lifts analiticamente com a transformada de 128 pontos;
4. descartar imediatamente cosets cujo intervalo discreto de pesos não contém 32640;
5. só então executar o auditor das 4.115 classes.

Isso transforma uma parte antes heurística da busca em uma etapa exata e finita.

## Estado

- decomposição 266+7: **exata**;
- otimização dos 128 lifts: **exaustiva**;
- descarte do coset de controle por peso: **exato**;
- inexistência geral em todo o espaço de (2^{273}): **não provada**.
