# Comparação bibliográfica — Regra Antipodal

Data: 2026-10-06.

## Resultado candidato deste projeto

Para n=2^k, k>=2, toda função rotation-symmetric bent de grau <=3 deve conter a órbita quadrática antipodal
Q_A=sum_{i=0}^{n/2-1} x_i x_{i+n/2}.
Consequentemente, não existe função homogênea cúbica RS bent em dimensão potência de dois.

A prova candidata está em REGRA_ANTIPODAL_PROVA_AUDITADA_2026_10_06.md.

## Cusick--Sanger (2017), arXiv:1708.09313

A comparação direta do texto mostra:

- Teorema 2.10: para n=2m, Q_A é a única MRS short-cycle que é bent. É um resultado sobre uma única MRS short-cycle.
- Teorema 2.11: uma combinação bent formada somente por short-cycle MRS deve conter Q_A.
- Teorema 3.8: para n=2p, p>2 primo, trata funções HOMOGÊNEAS de grau comum d. Se d=2, uma bent deve conter Q_A; para d!=2, a conclusão é formulada em termos do número de componentes short/long-cycle, não como necessidade universal de Q_A.
- Teorema 4.1: para n=2p, p primo ímpar, estende ao caso não homogêneo sob hipóteses adicionais: cada componente tem grau 2 ou número de monômios 2 ou n. Sob essas condições, bent implica conter Q_A.

Portanto os teoremas consultados não enunciam a condição candidata deste projeto para n=2^k e uma RS arbitrária de grau <=3.

As famílias de dimensões também são essencialmente diferentes: n=2p com p primo ímpar versus n potência de dois (exceto a dimensão 4 na interseção trivial de formas).

## Zhang--Gao

Cusick--Sanger registram que Zhang--Gao caracterizam funções RS bent de grau 2. Isso deve ser citado como antecedente para a parte puramente quadrática. A contribuição candidata aqui não deve ser descrita como nova caracterização de quadráticas; seu conteúdo é a necessidade do termo antipodal mesmo na presença arbitrária de termos cúbicos, quadráticos não antipodais, lineares e constante, sob n=2^k.

## Linguagem de prioridade segura

Até busca bibliográfica mais ampla, usar:

> We prove an antipodal necessity criterion for rotation-symmetric bent functions of algebraic degree at most three in power-of-two dimension. This complements earlier antipodal/short-cycle criteria of Cusick and Sanger for n=2p and known characterizations in the quadratic case.

Não usar ainda:
- "first proof";
- "new conjecture solved";
- "complete resolution of the Stănică--Maitra conjecture";
- qualquer afirmação de prioridade global.

## Impacto no manuscrito

Se a auditoria matemática independente confirmar a prova, o resultado deve entrar antes do argumento computacional n=32. O certificado n=32 permanece valioso como:
1. auditoria independente especializada;
2. controle computacional de uma instância grande;
3. evidência reproduzível que não depende da generalização simbólica.

O teorema para potências de dois não substitui o resultado já obtido para dimensões pares com 32 não dividindo n via redução de ordem ímpar; os dois resultados devem ser combinados cuidadosamente para identificar a cobertura total antes de ampliar o teorema principal.
