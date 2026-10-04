# Conferência das condições completas por fibras

Este texto audita a redução algébrica; não afirma exclusão adicional de famílias.

Fixe o parâmetro cúbico h e os coeficientes c das 155 órbitas. Para u,z em F₂¹⁶, sejam q_z(u)=f_c(u,u+z), B_z=T_h(z,·,·), R_z=rad(B_z), L_z(r)=q_z(r)+q_z(0). A meia-rotação dá q_z(u+z)=q_z(u), logo z∈R_z e L_z(z)=0.

## Condição completa em uma fibra

Se r₁,…,r_d é qualquer base de R_z, q_z é balanceada se e somente se algum L_z(r_i)=1. Cada avaliação L_z(r_i) é uma forma linear exata em c. O enunciado é válido para qualquer d, incluindo d=16 e polar nula. É necessário conservar os termos lineares da quadrática e o XOR com q_z(0).

O espaço comum de zeros de um conjunto de formas afins é invariável por operações elementares de linhas. Portanto uma disjunção “alguma forma vale um” pode ser simplificada por eliminação gaussiana das equações “todas valem zero”. Se a eliminação produz 0=1, a disjunção é automaticamente verdadeira. Se todas as linhas se tornam 0=0, a disjunção é falsa. Uma linha independente restante produz uma condição linear necessária.

## Redução por rotação

Com R como deslocamento dos índices de bits por +1, a ação nas coordenadas da fibra é

    z' = R₁₆ z,
    u' = R₁₆ u + z₁₅ e₀.

Temos R₃₂(u,u+z)=(u',u'+z'), logo q_{z'}(u')=q_z(u). A mudança afim é bijetiva: balanceamento é preservado. Existem exatamente 4.115 órbitas não nulas de z. Assim um representante de cada órbita é suficiente para impor todas as 65.535 condições.

O deslocamento constante não prejudica os funcionais do radical: R₁₆r∈R_{z'} e L_{z'}(R₁₆r)=L_z(r), pois a diferença causada pelo deslocamento é B_{z'}(R₁₆r,z₁₅e₀)=0.

## Certificado de impossibilidade independente de um resolvedor

Use uma árvore binária. Na raiz estão as 35 equações η(c)=h. Cada nó interno escolhe uma forma linear K(c) e tem filhos K(c)=0 e K(c)=1. Isso divide exaustivamente as possibilidades. Um nó terminal é aceito apenas quando a eliminação gaussiana demonstra incompatibilidade das hipóteses, ou quando uma fibra original possui todos os funcionais de sua base de radical obrigatoriamente zero. Recalcular as ANFs, a matriz e o radical permite conferir as folhas sem confiar no motor de busca. Recalcular a eliminação permite conferir a árvore sem confiar no histórico de decisões.

Uma divisão com vários filhos também pode usar uma disjunção L₁∨…∨L_k já estabelecida, com filho i impondo L₁=…=L_{i−1}=0 e L_i=1. Esses filhos são disjuntos e cobrem exatamente todos os casos que satisfazem a disjunção.

## Limite essencial da condição

Satisfazer todas as fibras não demonstra bentness. Demonstra W_f(0)=2¹⁶, porque a fibra zero tem soma de sinais 2¹⁶ e todas as outras têm soma zero. Portanto o peso é 2³¹−2¹⁵, mas os outros coeficientes de Walsh ainda precisam ser controlados.

## Fortalecimento por derivadas diagonais

Uma condição adicional exata é possível sem tabelas de tamanho 2³². Para r≠0, a autocorrelação de f na direção (r,r) é

    AC_f((r,r)) = 2¹⁶ · Σ_{z∈R_r} (−1)^[f(r,r+z)+f(0,z)].

Com efeito, D_{(r,r)}f(u,u+z)=B_z(r,u)+L_z(r). A soma sobre u se anula quando B_z(r,·)≠0. A simetria da polarização trilinear implica B_z(r,·)=0 se e somente se z∈R_r. Todas as quantidades restantes são avaliações lineares nos coeficientes c. Bentness exige que a soma final seja zero. Isso é uma condição de cardinalidade: exatamente metade dos valores L_z(r), z∈R_r, deve ser um.

Quando o radical tem dimensão quatro, apenas 16 avaliações entram em cada condição. Essa condição pode excluir candidatos que passam pelo teste de balanceamento das fibras. Sua satisfação ainda não controla todas as direções fora do subespaço diagonal.

## Fortalecimento equivalente por transformadas parciais

Escreva S_z(w)=Σ_u(−1)^[q_z(u)+w·u]. Então

    W_f(a,b)=Σ_z(−1)^(b·z) S_z(a+b).

Se f é bent, Parseval na variável b fornece Σ_z S_z(w)²=2³² para cada w. A fórmula do espectro quadrático resulta em

    Σ_{z: w|R_z=L_z} 2^(−rank(B_z)) = 1.

Esta condição de cobertura ponderada é dual às autocorrelações diagonais acima. Não deve ser contada como informação independente delas.

## Controles realizados

`audit_constraints_rotation.py` não importa o mecanismo de busca. A execução registrada conferiu a identidade da ação afim para as 65.536 direções, enumerou as 4.115 órbitas não nulas por remoção independente de órbitas, fez 4.960 avaliações de simetria nas ANFs originais e comparou 24 tabelas quadráticas completas com o critério de radical. Incluiu casos constantes, balanceados, não balanceados e vários graus de degeneração. Esses controles auxiliam a auditoria da implementação; a justificativa universal está nos argumentos algébricos acima.
