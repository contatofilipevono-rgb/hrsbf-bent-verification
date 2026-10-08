# Literatura verificada e plano de formalização — hipergrafos quárticos

## Literatura identificada
1. Polujan et al., *Cubic bent functions outside the completed Maiorana–McFarland class*, Designs, Codes and Cryptography (2020), https://link.springer.com/article/10.1007/s10623-019-00712-y — Definições 4.1/4.2: relaxed M-subspace e relaxed linearity index para funções BOOLEANAS escalares; resultados de invariância.
2. *Explicit infinite families of bent functions outside the completed Maiorana–McFarland class* (2023), https://link.springer.com/article/10.1007/s10623-023-01204-w — usa relaxed linearity index, também no contexto escalar.

A pesquisa inicial NÃO confirmou nem descartou antecedente para a fórmula vetorial hipergrafal R2(F_H)=alpha(G_H) e a indecomponibilidade EA. Não reivindicar novidade sem busca sistemática por formas alternadas, códigos de Grassmann e aplicações vetoriais.

## Plano Lean 4.19 (sem sorry, sem axioms)
1. Criar novo arquivo isolado VonoExactIndex/Hypergraph.lean, importando ExactIndex, sem tocar na V1.
2. Definir hyperedge como Finset (Fin n), família H como Finset de arestas, monomial por produto em ZMod 2, função F_H com codomínio H→ZMod 2.
3. Definir 2-section graph via coocorrência e independência I como Finset sem pares contidos numa aresta.
4. Formalizar primeiro a cota inferior para U coordenado por I: provar que cada monômio é afim em qualquer coset U e logo D_aD_b=0.
5. Para cota superior: derivadas quádruplas do monômio, determinantes 2×2 de colunas, posto das restrições por aresta <=1, escolha de pivôs de matriz da base de U. Não substituir argumento de posto por mera verificação computacional.
6. Para indecomponibilidade: formalizar espaço de 4-formas alternadas, contrações triplas e dimensão do espaço C(phi); provar isolamento de coordenadas quando interseções <=2; tratar cuidadosamente as mudanças afins e os blocos degenerados.
7. CI com Lean 4.19 + Mathlib, somente considerar kernel-checkable após sucesso.

## Observação conceitual
R2 é invariante sob perturbação de grau <=2, mas não em geral sob grau 3. O tensor quártico fornece uma OBSTRUÇÃO à decomposição mesmo com termos cúbicos, porém não determina sozinho R2 depois de uma perturbação cúbica.
