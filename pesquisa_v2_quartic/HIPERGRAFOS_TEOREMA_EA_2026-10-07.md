# Teorema hipergrafal: índice R2 exato e indecomponibilidade EA

**Status:** demonstração matemática redigida, não formalizada em Lean; prioridade de checagem bibliográfica antes de alegar novidade.

Seja H uma família de subconjuntos distintos de cardinalidade 4 de [n], com interseções par-a-par de tamanho <=2, sem vértices isolados, cujo grafo de interseção dos blocos é conexo. Defina F_H:F2^n→F2^H, F_H(x)_S=∏_{i∈S}x_i. Seja G_H o grafo de 2-seção.

## Teorema A: R2(F_H)=alpha(G_H)

**Cota superior.** Se U é admissível, a quarta derivada alternada do monômio x_S satisfaz T_S(a,b,c,d)=0 para todos a,b∈U e c,d∈V. Para cada S, isto força dim(proj_S U)<=1: se dois vetores projetados são independentes, sua contração no volume de dimensão 4 é uma 2-forma não nula. Escolha uma base de U e represente-a como matriz k×n. As colunas pertencentes a qualquer bloco S têm posto <=1. Escolha k colunas independentes; dois índices escolhidos não podem pertencer ao mesmo S, pois suas colunas seriam dependentes. Logo k<=alpha(G_H).

**Cota inferior.** Se I é independente em G_H, cada monômio x_S tem grau <=1 nas coordenadas de I quando as demais são fixadas. Portanto sua restrição a qualquer coset de U=span(e_i:i∈I) é afim, e D_aD_b F_H=0 para quaisquer a,b∈U. Assim R2>=|I|.

## Lema B: pureza das 4-formas

Seja A=span{omega_S=∧_{i∈S}x_i:S∈H}⊂Λ⁴V*. Para omega∈Λ⁴V*, defina C(omega)=span{ι_aι_bι_c omega:a,b,c∈V}⊂V*. Para omega não nula decomponível, dim C(omega)=4: a inclusão no span dos quatro fatores é imediata, e a igualdade decorre de contrações de uma base dual. Se omega=Σ_{S∈J}omega_S, a hipótese de interseção <=2 permite isolar x_i pela contração com a tripla S\{i}, logo C(omega) contém todos x_i para i∈∪J. Se |J|>=2, |∪J|>=6, contradizendo dim C(omega)=4. Assim os únicos elementos não nulos decomponíveis de A são os omega_S.

A condição é nítida: omega_{1234}+omega_{1235}=x1∧x2∧x3∧(x4+x5) é decomponível se a interseção de blocos tiver tamanho 3.

## Teorema C: indecomponibilidade EA (sem fatores degenerados)

Suponha que, após mudanças afins invertíveis de entrada, linear invertível de saída e adição de mapa afim, F_H se decomponha como produto F_1×F_2 em entradas e saídas disjuntas. A componente quártica de cada coordenada determina um subespaço A⊂Λ⁴V*, preservado (até ação de GL(V)) pela equivalência EA. A decomposição implica A=A_1⊕A_2 com A_j⊂Λ⁴W_j, V*=W_1⊕W_2.

Cada omega_S∈A é puro. Se omega_S=phi_1+phi_2, phi_j∈A_j, e ambas parcelas forem não nulas, então dim C(omega_S)=dim C(phi_1)+dim C(phi_2)>=8 (as contrações e os espaços W_j são disjuntos). Isto contradiz dim C(omega_S)=4. Portanto cada omega_S pertence integralmente a um lado, e E_S=C(omega_S)⊂W_j. Blocos que se intersectam têm E_S∩E_T≠0 e não podem estar em lados opostos. A conexidade obriga todos os blocos ao mesmo lado. A ausência de vértices isolados implica que a soma dos E_S é V*, logo o outro espaço de entradas é zero. Como os monômios coordenados são linearmente independentes, a imagem da componente homogênea quártica gera todo o espaço de saídas; não resta bloco de saídas sem parte quártica. Logo não existe decomposição não trivial, nem mesmo com fatores de entradas ou saídas vazias.

**Importante:** o argumento de indecomponibilidade depende apenas da parte de grau 4 e persiste após adição de termos de grau <=3, mas a igualdade R2=alpha só foi demonstrada para F_H sem perturbações cúbicas (e persiste sob perturbações de grau <=2).

## Próximas tarefas
- Formalizar Teorema A e Lema B em Lean 4.19, sem alterar arquivos já compilados.
- Auditar a definição exata de EA e possíveis fatores degenerados.
- Pesquisa bibliográfica sobre 4-formas decomponíveis, códigos Grassmann, hipergrafos e indecomponibilidade de aplicações vetoriais.
