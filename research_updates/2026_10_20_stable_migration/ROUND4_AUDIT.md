# Quarta rodada preservada; escolha do maior checkpoint válido

19/10/2026, após 23h14 de Brasília (20/10 em UTC). Ambas as rodadas terminaram normalmente no orçamento de três horas, salvaram cache e publicaram artefatos. A auditoria existente validou relatórios e logs da carta correta, e os ZIPs tiveram digest e integridade conferidos. Não há raiz concluída ou prova global nesta etapa.

| Carta | Rodada 3 | Rodada 4 | Checkpoint escolhido para migração |
|---|---:|---:|---|
| 0 | 342 módulos | 438 módulos | Rodada 4: 438 |
| 1 | 283 módulos | 262 módulos revalidados | Rodada 3: 283 |

A carta 0 manteve identidade e todos os 342 registros anteriores exatamente iguais, acrescentando 96. A carta 1 voltou ao fingerprint de ambiente anterior e repetiu o kernel; a fatia terminou no kernel de H12CloudChart1Data141. O relatório novo contém 262 registros, menos que os 283 já certificados. Isso não revoga ou apaga o checkpoint imutável da rodada 3.

Nos 262 registros compartilhados da carta 1, nomes, fontes, objetos .olean e hashes dos logs do kernel são iguais. Mudaram somente 136 hashes de logs de build. As fontes, raízes e versão Lean são idênticas entre rodadas. Preservamos a rodada 4 para auditoria, mas não usaremos seu prefixo menor como se representasse o melhor estado disponível.

A API do GitHub confirmou a existência dos caches exatos: carta 1, rodada 3, ID 9188505532; carta 0, rodada 4, ID 9194259323. A migração usará os relatórios correspondentes a esses caches, sem combinar registros ou logs de rodadas diferentes. O verificador corrigido revalidará todos os hashes antes de reutilizá-los. A escolha da rodada 3 para a carta 1 conserva o maior prefixo certificado, em vez de regredir a 262.

Os hashes exatos dos relatórios extraídos dos ZIPs, as chaves de cache e a proveniência estão em MIGRATION_PLAN.json. Os artefatos da rodada 4 estão em research_updates/2026_10_19_parallel_checkpoints e foram copiados com os registros para outputs/stable_migration nesta conversa. Nenhum run ativo foi interrompido, repetido ou duplicado. A migração será feita na branch isolada fix/lean-resume-stability, mantendo o código da main e o PR 6 sem merge.
