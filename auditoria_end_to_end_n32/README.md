# Auditoria independente end-to-end — HRSBF cúbica n=32

Alvo congelado: branch `colab-a100-2026-10-06`, commit `9e31729158c46e68632e7b277e35a7b8bdbc8fb8`.

Esta implementação usa somente Python padrão e CPU. Ela não importa os scripts científicos do projeto nem usa o certificado existente para construir a matriz, o núcleo, as fibras ou o resultado esperado. Reconstrói diretamente as `C(32,3)=4960` triplas, suas 155 órbitas cíclicas, a matriz polar completa `496 x 155`, eliminação sobre GF(2), uma base completa do núcleo, tabelas empacotadas das duas fibras e o teste exaustivo do lema quadrático RS.

## Resultado reproduzido

A execução obteve 155 órbitas de tamanho 32, `rank(M)=14` e `dim ker(M)=141`. Todas as 155 tabelas diagonais são zero. Para cada vetor de uma base independente completa de `ker(M)`, a tabela da fibra complementar é constante. A busca sobre todas as `2^16` partes quadráticas RS e os dois coeficientes lineares RS em n=32 não encontrou função balanceada com polar não nula.

Os controles exaustivos em n=4 e n=8 passam. O controle positivo `f(u,v)=u·v XOR e3(u+v)` em n=8 é reconhecido como bent, rotation-symmetric, de grau 3 e não homogêneo.

Onze mutações deliberadas são rejeitadas por propriedades matemáticas/recomputações, incluindo corrupção de órbita, polar, núcleo, fibras, ordenação sem remapeamento, rank esperado e classificação quadrática.

## Reprodução

Na raiz do repositório:

```text
python3 auditoria_end_to_end_n32/audit_end_to_end.py
python3 -O auditoria_end_to_end_n32/audit_end_to_end.py
```

Ambos devem terminar com `status: PASS`. O programa não depende de `assert`, portanto `-O` não remove verificações essenciais.

## O que este PASS significa

A auditoria não encontrou inconsistência nos elos computacionais que reconstrói: enumeração cúbica RS, equações polares, rank/núcleo, diagonal nula, implicação núcleo→fibra constante, lema quadrático RS e controles pequenos.

Ela é evidência computacional independente, não uma formalização em Lean/Coq. Não estabelece prioridade/originalidade bibliográfica, não cobre graus maiores e não autoriza extrapolação automática para outras dimensões. A passagem de bentness para as condições necessárias usadas no argumento continua sendo uma afirmação matemática a ser julgada juntamente com a prova escrita, não apenas pelo fato de este programa retornar PASS.
