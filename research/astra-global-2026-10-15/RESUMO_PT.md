# Resultado global

**O enunciado antipodal universal e o corolário de inexistência de bent homogêneas cúbicas RS passaram no kernel do Lean 4.15.0 e em CI limpo**, com Mathlib fixada e apenas `propext`, `Classical.choice` e `Quot.sound`. O CI confirmado é 38682075049, no commit 9f186bc871361b263a9356a8d80cbcc837db21de.

A prova cobre toda dimensão par positiva. As únicas hipóteses sobre a função são simetria pela rotação real, grau canônico ANF≤3 e bentness pelo Walsh inteiro real. Termos afins e constantes são permitidos. O corolário homogêneo vem da ausência de coeficientes quadráticos no ANF.

A montagem final usa uma rota mais curta: coeficiente antipodal zero torna a função constante no espaço fixo da meia-rotação; essa obstrução passa à diagonal da restrição de dimensão potência de dois, contrariando a prova das fibras. A redução ímpar usa coordenadas repetidas construídas explicitamente, não uma hipótese de bentness da restrição.

A igualdade completa de transporte de coeficientes sob folding continua como resultado auxiliar não formalizado separadamente, mas não é usada pela prova global. Isso está declarado em GAP_REGISTER.md. O artigo ainda exige revisão editorial e de prioridade bibliográfica; nenhuma aceitação ou publicação acadêmica foi realizada.
