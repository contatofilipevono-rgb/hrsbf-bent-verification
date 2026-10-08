# Auditoria inicial — família hipergrafal vetorial quártica

**Status: conjectura de indecomponibilidade; cálculo de R2 tem prova elementar proposta, ainda não formalizada.**

Seja H um hipergrafo 4-uniforme e F_H(x)=(prod_{i in S} x_i)_{S in H}.

## Cálculo de R2
Para U admissível, as derivadas de quarta ordem em direções a,b,c,d se anulam. Em cada S, a projeção U -> F2^S tem dimensão <=1: caso haja a,b projetados independentes, a contração do 4-volume de S por a,b é não nula (é uma 2-forma não nula), contradição. Tomando uma matriz de base de U com k linhas, cada bloco S contém no máximo uma coluna não nula distinta. Escolha k colunas linearmente independentes. Nenhum par dessas colunas pode pertencer ao mesmo S, portanto seus vértices formam conjunto independente na 2-seção. Logo k<=alpha. Reciprocamente, I independente fornece U=span{e_i:i in I}; cada monômio envolve no máximo uma coordenada em I, portanto sua restrição em cada coset de U é afim e D_aD_bF_H=0 para todos a,b em U. Conclusão proposta: R2(F_H)=alpha(G_H).

## Cuidado: indecomponibilidade EA
A afirmação 'únicos elementos decomponíveis de span{x_S} são os monômios' exige prova completa, não apenas contrações para somas de dois monômios. Deve-se verificar também que um tensor de suporte mínimo não pode ser repartido após GL(n,2), e que eventuais saídas redundantes não produzam blocos degenerados. Não reivindicar prova até auditoria independente.

## Exemplos
- Girassol com t pétalas triplas e um vértice central: n=3t+1, saídas=t, alpha=t (escolher uma variável de cada pétala; o centro sozinho não aumenta).
- S(2,4,n), quando existir: a 2-seção é completa, portanto alpha=1. O número de blocos é n(n-1)/12.
- Para AG(d,4), as retas têm 4 pontos e cada par está em exatamente uma reta; n=4^d, m=n(n-1)/12.

## Experimentos úteis
1. Buscar combinações lineares decomponíveis de pelo menos 3 monômios em H pequenos.
2. Verificar invariância de espaços de suporte do 4-tensor sob GL(n,2).
3. Revisão bibliográfica de monomial vectorial maps, hypergraph forms, tensor indecomposability, exterior 4-forms, EA-equivalence.
4. Não extrapolar a igualdade para saídas comprimidas ou perturbações cúbicas.
