# Transição dos checkpoints e acompanhamento

## Escopo

Continuar as cartas 0 e 1 na branch fix/lean-resume-stability usando o workflow existente .github/workflows/lean-cloud.yml. A main permanece em seu workflow antigo. O novo arquivo lean-resume.yml não precisa ser registrado na main. Não mesclar o PR 6 sem nova autorização explícita. A carta 2 já terminou e não deve ser reiniciada.

Código de retomada e caminho de dispatch testados em 032aaadc61ab31b2b6c80753388218c9e2d41af7; teste explícito de dispatch 39346213672 aprovado. Não alterar fontes do verificador durante as rodadas. Consultar e atualizar MIGRATION_REGISTRY.json conforme os novos runs forem identificados.

## Primeira migração de cada carta

1. Consultar estado e tentativa atuais do run legado. Enquanto o job verify estiver ativo, não interromper, repetir ou criar outro run dessa carta. A quarta tentativa começou por volta de 20h11 de Brasília; o orçamento deve encerrar perto de 23h11, com alguns minutos para salvamento.
2. Ao terminar, baixar o artefato lean-chart-CARTA-RUN-TENTATIVA. Conferir digest SHA256 do GitHub, integridade ZIP, progress.json e logs com research_updates/2026_10_18_cloud_report_audit/audit_cloud_report.py. O auxiliar preserve_parallel_checkpoints.py desta conversa preserva os runs legados atuais. Guardar artefato e registros no repositório e nesta conversa antes de migrar.
3. Conferir o salvamento efetivo do cache nos logs completos. Extrair a chave exata da linha Cache saved with key, terminada no run e na tentativa correspondente. Calcular SHA256 diretamente dos bytes de progress.json dentro do ZIP; não de texto convertido ou normalizado pelo Git. O arquivo do cache deve corresponder ao relatório auditado; qualquer divergência faz a migração falhar.
4. Se a raiz dessa carta já estiver completa, preservar e não migrar. Se parcial, comparar fontes, registros, objetos e logs anteriores; tratar diferenças de fingerprint legado conforme o diagnóstico, sem ignorar alterações de prova ou falhas do kernel.
5. Antes do dispatch, consultar runs do workflow lean-cloud.yml na branch fix/lean-resume-stability, incluindo tentativas atuais, e confirmar que não existe um run de verificação dessa carta ativo, aguardando ou pendente de preservação. O título distingue Lean stable resume verify chart 0/1 de um teste smoke. Não usar o run smoke como carta.
6. Disparar UMA vez via POST /repos/contatofilipevono-rgb/hrsbf-bent-verification/actions/workflows/lean-cloud.yml/dispatches. Usar ref fix/lean-resume-stability e inputs mode=verify, chart=0 ou 1, minutes=180, legacy_cache_key=chave exata salva e legacy_report_sha256=digest do relatório auditado. A rota foi testada com mode=smoke; o token Git local permite dispatch, embora não permita editar arquivos de workflow. As credenciais ficam somente em memória e nunca devem ser impressas.
7. Registrar o novo run ID e commit executado no registro. Se o POST aceitar mas o ID demorar a aparecer, consultar a lista e não repetir o POST. Manter os próximos cálculos nessa branch: caches de uma branch filha não ficam acessíveis à main.
8. Confirmar restauração do cache correto e a linha RESUME audited_legacy_digest REUSED K / 924 NEXT MODULO. K deve coincidir com todos os módulos preservados da última rodada antiga. Nenhuma inferência de sucesso do GitHub substitui essa conferência. Qualquer recusa de migração exige diagnóstico antes de continuar.

## Rodadas seguintes

Consultar o run novo registrado e suas tentativas atuais. Selecionar o job verify real; o job smoke ignorado não é uma falha. Quando uma fatia terminar, preservar o artefato lean-resume-chart-CARTA-RUN-TENTATIVA e aplicar o mesmo auditor com a carta correta. O auxiliar legado precisa ser parametrizado para o novo run e prefixo de artefato; não sobrescrever evidências antigas com nomes iguais.

Nas retomadas v2, fingerprint, verification_identity e prefixo de results devem permanecer iguais quando código/toolchain/fontes não mudam. Os campos descritivos execution_environment podem variar. O modo stable_identity valida novamente os hashes de todos os objetos e logs retidos, sem repetir o kernel do prefixo. O primeiro salto legado -> v2 tem fingerprint novo esperado e fica vinculado pelo source_report_sha256. Não somar contagens acumuladas de rodadas como módulos distintos.

Se parcial e cache salvo, retomar o job verify desse NOVO run pela integração GitHub. Não retomar os runs legados depois de migrar. Não criar runs duplicados. O workflow não permite fallback legado nas tentativas seguintes: perda de cache deve parar com erro visível, sem regressão silenciosa para checkpoint antigo.

Registrar e notificar progresso significativo, conclusão ou falha. Permanecer em silêncio nos estados sem mudança. Quando ambas as raízes concretas estiverem completas e preservadas, informar que falta a integração final e pausar o acompanhamento; não declarar a prova global.

## Referências operacionais

- [Restauração e chave efetivamente recuperada](https://github.com/actions/cache/blob/main/restore/README.md).
- [Correspondência e escopo de caches entre branches](https://docs.github.com/en/actions/reference/workflows-and-actions/dependency-caching).
