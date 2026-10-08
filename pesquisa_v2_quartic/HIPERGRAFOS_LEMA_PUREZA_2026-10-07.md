# Lema de pureza do espaço quártico — prova independente (rascunho matemático)

Seja V* um espaço sobre F2 com base (x_i), H uma família de subconjuntos de tamanho 4 com |S∩T|<=2 para S≠T. Seja A=span{omega_S=∧_{i∈S}x_i:S∈H} ⊂ Λ⁴V*.

**Proposição.** Todo elemento não nulo decomponível (puro) de A é algum omega_S.

**Prova.** Tome omega=Σ_{S∈J}omega_S com J⊂H não vazio. Para qualquer S∈J e i∈S, contraia omega sucessivamente com os três vetores de base de S\{i}. A contribuição de omega_S é x_i. Como nenhum outro bloco de H contém essa tripla (interseções <=2), as demais contribuições são zero. Portanto o espaço de suporte E(omega), definido como span de todas as contrações triplas de omega, contém todos os x_i para i∈∪J. Reciprocamente omega envolve somente essas variáveis, logo E(omega)=span{x_i:i∈∪J}. Se omega é um 4-vetor decomponível não nulo, E(omega) tem dimensão exatamente 4 (contrair três vetores produz todo o 4-espaço dos fatores). Logo |∪J|=4 e J consiste de um único bloco. QED.

**Consequência para indecomponibilidade EA (esboço a formalizar).** Se A=A_1⊕A_2 com A_j⊂Λ⁴V_j* para V*=V_1*⊕V_2*, todo omega_S puro pertence integralmente a um dos dois lados: a projeção de omega_S em cada Λ⁴V_j* é pura ou zero e a soma de dois termos não nulos em lados disjuntos teria suporte dimensão 8, contradizendo pureza. Dois blocos que se intersectam têm E(omega_S)∩E(omega_T)≠0, portanto não podem estar em lados diferentes. Se o grafo de interseções de blocos é conexo, todos ficam do mesmo lado. Se nenhum vértice é isolado, os suportes dos blocos geram V*, logo o outro espaço de entrada é zero. As saídas são linearmente independentes porque os monômios são distintos, portanto não há bloco de saída puramente degenerado. A formulação exata de EA-decomposição (incluindo componentes afins, entradas/saídas degeneradas) precisa ser fixada antes de chamar isto de teorema final.

**Nota.** O argumento é sobre a componente homogênea de grau 4 e é imune a termos de grau <=3. Não prova que qualquer acoplamento quártico cíclico tenha índice exato; não implica originalidade bibliográfica.
