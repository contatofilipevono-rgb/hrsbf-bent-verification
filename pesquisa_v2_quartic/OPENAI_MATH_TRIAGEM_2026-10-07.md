# Triagem técnica: OpenAI Math (2026-10-07)

Fonte: https://github.com/openai/math/tree/main/lean/OAI/Combinatorics

## Arquivos inspecionados
- BooleanFunctions/Blocks.lean: `blockCurry` estabelece equivalência explícita entre coordenadas de produto e funções em blocos; provas com `funext`, `simp` e operações finitas. Útil como referência para `paperBlockLinearEquiv`, mas não fornece diretamente teoremas de R2.
- Sensitivity/Reindex.lean: `reindex`, `reindex_symm`, invariância de sensitivity e blockSensitivity sob equivalência de índices. Padrão reutilizável de prova por reindexação; **não** implica invariância de M-index sem prova própria.
- BooleanFunctions/Walsh.lean: transformada de Walsh/Fourier real de funções Bool; potencial ferramenta de investigação espectral, mas Fourier degree sobre reais não é grau algébrico em F2.
- BooleanFunctions/Projection.lean: médias condicionais e projeção em produtos finitos. Aplicabilidade indireta; não há conexão comprovada com R2.
- Sensitivity/Composition.lean: composição de funções booleanas em coordenadas disjuntas. Inspirador para estruturas não triviais, mas não prova indecomponibilidade EA.

## Conclusão
**Utilidade imediata: moderada para organização das provas Lean; baixa para demonstrar novidade matemática de R2.**
Manter prova própria do transporte linear, preservar V1 e aguardar CI do teorema `paperFr_has_exact_indices`.

## Investigações seguintes
1. Verificar as provas do novo `LinearTransport.lean` no CI.
2. Separar rigorosamente decomposição direta, composição não linear e indecomponibilidade sob EA.
3. Para família genuinamente não separável: obter obstrução EA invariável (por exemplo, estrutura de derivadas de ordem 3/4) antes de alegar novidade.
4. Evitar transplantar arquivos da OpenAI sem conferir licenças, versões de Mathlib e compatibilidade dos enunciados.

Esta nota é triagem de métodos, não certificação de novos teoremas.
