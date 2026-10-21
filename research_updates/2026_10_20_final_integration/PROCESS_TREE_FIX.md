# Correção do encerramento e do salvamento da integração

A tentativa 1 do run 39499423162 encerrou a reconstrução após 165 minutos com PARTIAL_OBJECT_TIMEOUT no Data105. Foram registrados 105 objetos com hash igual ao certificado (Data000–104), mas um processo filho continuou escrevendo após o timeout. O tar do cache falhou com “file changed as we read it”. O status success do job não comprovava checkpoint salvo. O ZIP, relatório e logs foram preservados e auditados; esse ZIP antigo não contém os binários reconstruídos. Não há cache parcial recuperável e os 105 binários terão de ser reconstruídos. As três cartas certificadas e os caches finais de 0/1 permanecem intactos.

A correção executa cada comando em uma sessão Linux própria, encerra todo o grupo de processos com SIGKILL e aguarda o processo pai antes de retornar ao salvamento. Os 11 testes locais de orquestração, encerramento e snapshot passaram. Um teste real no runner Linux dispara pai e neto, impõe timeout e verifica que o neto não escreve depois; esse teste já passou no novo run, antes de qualquer compilação pesada. Não constitui prova matemática.

O workflow também exporta, além do cache, um tar.gz independente de objetos da carta 2 cujo SHA256 coincide com o registro certificado, incluindo arquivos auxiliares correspondentes e manifesto de hashes. A verificação lê o próprio tar e confere os hashes após criá-lo. O artefato contém essa cópia para recuperação manual auditada caso o cache se perca. A persistência da chave exata de cache é consultada na API: falha não será mais silenciosamente aceita como job de sucesso. Tentativas posteriores falham se nenhum cache v3 for encontrado, sem retorno silencioso ao zero.

Novo run: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39520500414
Job inicial: 118962904391; commit 344ab2e1b330d4a6be3f00603e9423db39cf3354, branch fix/lean-resume-stability.
Início: 2026-10-21T00:18:17Z, 21h18min17s de Brasília em 20/10.

O código corretivo segue isolado na branch; nenhum merge do PR 6 foi realizado. O enunciado e os critérios de kernel não foram alterados. A prova global continua pendente. Não retomar os runs anteriores 39499423162 ou 39494198666.
