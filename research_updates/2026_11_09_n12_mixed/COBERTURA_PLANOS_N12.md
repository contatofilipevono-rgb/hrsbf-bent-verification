# Cobertura das quárticas RS bent em 12 variáveis por dois planos invariantes

## Teorema computacional

Toda função booleana bent de grau exatamente quatro, com simetria de rotação em 12 variáveis, é afim nas classes de pelo menos um dos seguintes subespaços antipodais de dimensão dois:

$$
V_a=\langle27,54\rangle,\qquad V_b=\langle21,42\rangle.
$$

Os vetores estão escritos como máscaras de seis bits nas coordenadas $w$. O teste parte dos espaços de polinômios RS e das condições espectrais necessárias. O catálogo de funções não é entrada da execução.

## Redução e cobertura

Qualquer função é afim nas classes da reta antipodal de direção 63, pois cada classe tem dois pontos. O modelo com essa reta abrange as funções RS de grau até quatro que satisfazem as duas relações lineares universais no topo. A eliminação dá 68 dimensões, 18 para o mapa e 50 para a fase.

Os subespaços invariantes de $w$ são os submódulos cíclicos de $\mathbb F_2[X]/(X^6-1)$. Como $X^6-1=(X+1)^2(X^2+X+1)^2$, todo subespaço invariante de dimensão pelo menos dois contém um dos dois planos acima. Para provar o enunciado, o contador exige grau quatro e derivada mista não nula em cada plano. As assinaturas comprimidas dessas três propriedades têm os mesmos núcleos que a ANF quártica e as duas derivadas mistas completas. Isso foi conferido por igualdade dos postos das aplicações direta, comprimida e empilhada, com postos 41, 3 e 3 nas 68 direções. A ANF em $(z,w)$ também confirmou grau em $w$ até dois nas 68 direções.

O filtro das fibras e a eliminação de momentos são descritos em RESULTADOS_DIM3_DIM2.md. A prova não depende de uma busca probabilística.

| Etapa | Quantidade |
|---|---:|
| Códigos de mapa | 262.144 |
| Mapas balanceados | 30.781 |
| Órbitas de mapas | 452 |
| Órbitas excluídas pelas assinaturas antes da fase | 119 |
| Órbitas com sistema linear inconsistente | 254 |
| Órbitas excluídas pelas assinaturas após o sistema linear | 30 |
| Tarefas de fase restantes | 49 |
| Tarefas excluídas pela eliminação quadrática | 8 |
| Tarefas finais concluídas | 41 |
| Intervalos disjuntos das fases | 16 |
| Combinações residuais de fase examinadas | 187.498.496.000 |
| Funções que passam fora dos dois planos | **0** |
| Tarefas adiadas | **0** |

As 16 fatias cobrem, para cada sistema, os ordinais Gray de 0 a $2^d-1$, onde $d$ é a dimensão residual. O agregador confere os limites, a soma de $2^d$ por sistema e a igualdade SHA-256 dos suportes, representantes, pesos e sistemas de fase em todas as fatias. Um controle positivo confirmou 12.288 fases tanto em uma execução quanto em 16 fatias.

A execução principal e a repetição com hashes de todos os sistemas deram zero. O Astra auditou a equivalência dos momentos, o quociente de fases, as simetrias, a eliminação quadrática e a partição em intervalos. A auditoria por modelo e a reprodução no mesmo código são etapas distintas da revisão humana ou de uma implementação independente do teste universal.

- [Execução universal com hashes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42951139664)
- [Primeira execução universal](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42950285608)
- [Controle positivo dos intervalos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42950413546)

## Contagem de grau exatamente quatro

| Bloco disjunto | Funções | Origem da contagem |
|---|---:|---|
| Afinidade na diagonal inteira | 290.004.992 | Permutações Maiorana–McFarland antipodais |
| Hiperplano $U$, fora da diagonal inteira | 10.485.760 | Parametrização em F4 e exclusão dos outros tipos de $q$ |
| Dimensão quatro, fora de $U$ | 4.227.072 | Contagens independentes de V1 e V2, comunicadas pelo Fable |
| Dimensão três | 4.194.304 | Contagem independente de 12 órbitas de mapas |
| Dimensão dois | 309.248 | Contagem independente de seis órbitas de mapas |
| **Total** | **309.221.376** | Cobertura pelos dois planos e soma dos blocos |

No relatório de V1, 290.062.336 é o total antipodal até grau quatro. Aqui usamos 290.004.992, que retira 64 quadráticas e 57.280 cúbicas. O total final coincide com o catálogo anterior.

[Relatório de V1 e V2](https://github.com/contatofilipevono-rgb/n1-sat-cubos/blob/6471480/bloco_dim4_n12/RESULTADOS_DIM4.md)

O teorema dá uma cobertura computacional independente da classificação por catálogo. As formas fechadas dos mapas e a explicação algébrica das multiplicidades das fases permanecem em investigação.

## Interseção de V1 e V2

Para somar os dois blocos de dimensão quatro, é preciso controlar a afinidade simultânea. A imposição das duas restrições de afinidade deixa um espaço RS de dimensão 45, cuja imagem polar tem dimensão dois. A comparação de coeficientes identifica quatro classes no sistema de V2.

| M | κ | Afinidade em U |
|---|---:|---|
| 0 | 0 | Sim |
| 0 | 1 | Sim |
| I+R³ | 0 | Não |
| I+R³ | 1 | Não |

As duas últimas classes têm contagem de fases zero na enumeração exata por classe de V2. Isso mostra que, entre as funções bent afins em V1 e V2, a interseção é exatamente o bloco afim em U, que inclui a diagonal. Assim 1.900.544 e 2.326.528 podem ser somados depois de excluir U de cada lado. O teste da interseção está em dim4_wedge_obstruction.py. [Tabela das fases por classe de V2](https://github.com/contatofilipevono-rgb/n1-sat-cubos/blob/1488a48/bloco_dim4_n12/PROVA_POLAR_DIM4.md)
