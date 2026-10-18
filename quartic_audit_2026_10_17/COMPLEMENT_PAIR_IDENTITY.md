# Os filtros quárticos como 35 pares complementares

Esta identidade fornece uma explicação curta dos filtros de peso oito. Não é, sozinha, uma prova de inexistência de funções bent nem uma afirmação de novidade bibliográfica.

Considere qualquer função booleana homogênea quártica f, e fixe em zero as coordenadas fora de um conjunto S de tamanho oito. Escreva a restrição na forma ANF

    f|S(x) = XOR_{A subset S, |A|=4} a_A prod_{i in A} x_i.

Os coeficientes a_A são bits. Para funções invariantes por rotação, a_A é a coordenada c_j da órbita que contém A.

Defina, em F2,

    Q_S = XOR_{A disjoint B, A union B=S, |A|=|B|=4, A<B} a_A a_B.

Há exatamente binom(8,4)/2 = 35 pares não ordenados. Vale a identidade inteira modular

    wt(f|S) = 2 Q_S  (mod 4),

interpretando Q_S pelo representante 0 ou 1. Em particular, o peso é divisível por quatro se e somente se Q_S=0.

## Demonstração

Para quaisquer bits z_1,...,z_t, a identidade do XOR como inteiro dá

    XOR_i z_i = sum_i z_i - 2 sum_{i<j} z_i z_j  (mod 4).

Isso segue da expansão de prod_i(1-2z_i): os termos de ordem pelo menos três, após dividir por -2, são múltiplos de quatro. A identidade inclui automaticamente os casos em que alguns coeficientes são zero.

Aplique-a aos monômios quárticos ativos e some sobre as 256 entradas da restrição. Cada monômio quártico vale 1 em 2^(8-4)=16 entradas, logo todos os termos lineares desaparecem módulo quatro.

O produto dos monômios de suportes A e B vale 1 em 2^(8-|A union B|) entradas. Sua contribuição, multiplicada por -2, desaparece módulo quatro quando |A union B|<8. Os únicos pares que restam têm união S; como ambos os suportes têm tamanho quatro, eles são disjuntos. Para esses pares, a contribuição é -2 a_A a_B, igual a 2 a_A a_B módulo quatro. Somar esses 35 pares prova a fórmula.

Se dois suportes pertencem à mesma órbita, o produto de coordenadas é c_j²=c_j. Pares diferentes que produzem a mesma máscara de coordenadas cancelam em F2. Por isso os polinômios finais têm entre 3 e 35 termos, embora a construção sempre comece com 35 pares.

## Ligação com bentness e com o certificado

Em 12 variáveis, a identidade de restrição de Walsh e Walsh plano ±64 implicam que wt(f|S) é divisível por quatro. A prova formal genérica dessa passagem está em `H12Restriction.lean`; a prova de que o segundo bit do peso é uma forma quadrática está em `H12Weight.lean`. A identificação formal dos 43 polinômios numéricos com esses lemas foi concluída em `H12FilterLink.bent_passes`. A fórmula curta dos 35 pares é demonstrada acima e verificada em Python; ainda não tem um lema Lean próprio. Consulte `FORMALIZATION_STATUS.md`.

O comando

    python verify_complement_pair_filters.py

reconstrói os 35 pares para cada um dos 43 representantes S e compara, termo por termo, o resultado com os filtros calculados independentemente pelos pesos e produtos das colunas de verdade da ANF original. Todos os 43 coincidem. O relatório `reports/COMPLEMENT_PAIR_FILTERS.json` registra os pares, as coordenadas de órbita e os polinômios resultantes.
