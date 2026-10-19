# Cartas Lean: terceira rodada preservada e quarta iniciada

Conferido em 19/10/2026, 23:12 UTC (20:12 de Brasília).

| Carta | Rodada anterior | Terceira rodada | Acréscimo |
|---|---:|---:|---:|
| 1 | 234 módulos | 283 módulos | 49 |
| 0 | 256 módulos | 342 módulos | 86 |

Ambos os relatórios são PARTIAL_MODULE_TIMEOUT, consistentes com o orçamento de 180 minutos. Cada carta declara 924 módulos no manifesto. Contagens de dependências não representam porcentagem de cobertura matemática. Nenhuma das duas raízes está concluída; a prova global continua pendente. A carta 2 já concluída permanece independente destes checkpoints.

## Preservação e auditoria

Foram baixados os dois ZIPs, conferidos seus SHA256 contra o digest do GitHub e dos logs, testada a integridade ZIP e aplicada a auditoria existente audit_cloud_report.py à carta correta, incluindo os logs de cada fase. Os ZIPs, progress.json, auditorias, metadados dos jobs e logs completos foram preservados neste diretório e copiados para outputs/parallel_attempt3_checkpoint nesta conversa.

- Carta 1: 0920b457212830305196e9ee30c2ae767c388361333866fe3c7b7cf452b82efd.
- Carta 0: eda57dbfa13aae8b8b4fa1e7620b25354f3dd3958a4e2b9b3c34f3c2b17a4961.

Os caches da tentativa 3 foram salvos e a quarta tentativa foi iniciada somente após confirmar que os jobs anteriores estavam concluídos. Os novos jobs são 118358546014 (carta 1) e 118358566941 (carta 0), nos mesmos runs. Fonte original das execuções: 6594557f70150bbc90a3542cdb3ab70cc62dab6a. O checkpoint no repositório não muda o commit executado ao retomar o mesmo run.

## Diagnóstico de continuidade

Na carta 0, os 256 registros anteriores são idênticos, bem como fingerprint, fontes, raízes e versão Lean. O painel da tentativa 4 mostra cache da tentativa 3 restaurado e START 343 / 924 H12CloudChart0Data221 build: os 342 registros salvos foram reutilizados.

Na carta 1, o fingerprint da tentativa 3 mudou. A imagem do runner também mudou: 20261012.334.1 para 20261018.339.1. O código do verificador calcula a identidade a partir de fontes, versão Lean, platform.platform() e hash do próprio verificador. As fontes e a versão são iguais, e o checkout nos dois logs é exatamente o mesmo commit. Assim, a mudança se localiza no componente de plataforma; a string exata de platform.platform() não foi exportada pelo verificador.

A comparação dos 234 módulos anteriores mostra igualdade de todos os hashes de fontes, objetos .olean e logs do kernel. Somente os logs de build de 228 registros mudaram. Os logs do job mostram START 1 e novos replays: o verificador conservador refez as checagens de registros, usando o build recuperado. Não houve perda ou invalidação demonstrada das provas anteriores. A auditoria do novo relatório e dos seus logs passou.

O painel da tentativa 4 confirma novamente a restauração do cache da tentativa 3 para a carta 1, mas mostra START 1 / 924 H12Descent build e kernel. Portanto, a quarta rodada não pulou o prefixo verificado. O fingerprint exato dessa rodada só poderá ser confirmado no seu relatório exportado; não se deve afirmar retomada direta no módulo 284.

## Atenção para a próxima conclusão

Repetir grandes prefixos do kernel a cada mudança de plataforma pode reduzir muito o avanço e eventualmente consumir toda a fatia. Após preservar a tentativa 4, diagnosticar a identificação de plataforma antes de simplesmente retomar a carta 1. Uma melhoria deve manter fontes, versão/digest Lean, objetos e registros verificados sob controle, prever migração auditada do cache e não enfraquecer o kernel. Nenhuma mudança de verificador, workflow ou chave de cache foi feita com os jobs ativos.

As execuções atuais continuam. Não reiniciar, duplicar ou cancelar um job ativo. A automação permanece em acompanhamento; nenhuma conclusão matemática global é declarada.
