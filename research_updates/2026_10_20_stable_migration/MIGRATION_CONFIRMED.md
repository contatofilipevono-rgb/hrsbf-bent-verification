# Migração confirmada nas cartas reais

19/10/2026, 23h24 de Brasília. Acompanhamento dos logs ao vivo confirmou a retomada correta na branch fix/lean-resume-stability, sem merge na main e sem repetição dos runs legados.

| Carta | Novo run | Job verify | Prefixo reutilizado | Primeiro módulo novo |
|---|---|---|---:|---|
| 0 | 39358421659 | 118418589064 | 438 | 439: H12CloudChart0Data317 |
| 1 | 39358413248 | 118418566936 | 283 | 284: H12CloudChart1Data162 |

Os dois painéis exibiram cache correto restaurado e RESUME audited_legacy_digest com as contagens completas selecionadas no plano. Na carta 0 também foi observado o início do kernel do módulo 439. A carta 1 voltou ao melhor checkpoint auditado, da rodada 3, preservando os 283 módulos em vez de adotar os 262 revalidados na rodada 4. Não foram combinados logs ou registros de caches diferentes.

RESUME_CONFIRMED.json registra as linhas e URLs observadas. MIGRATION_REGISTRY.json, em research_updates/2026_10_19_resume_fix, passou a apontar para os novos runs. O auxiliar de preservação desta conversa aceita --stable e usa o registro, o prefixo novo de artefatos e nomes que incluem run/tentativa. A contagem fixa da migração inicial fica em selected_legacy_modules; contagens acumuladas posteriores não devem alterar essa referência.

Os próximos checkpoints ainda precisam ser exportados e auditados ao encerrar cada fatia. As duas raízes continuam parciais e a prova global permanece pendente. A migração confirma reaproveitamento do prefixo e início dos próximos módulos, não uma conclusão matemática ou a validação de uma segunda retomada v2 real, que só poderá ser conferida depois da primeira fatia.
