# Retomada Lean estável: correção pronta e testada

19/10/2026, horário de Brasília. Código em [fix/lean-resume-stability](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/fix/lean-resume-stability), commit testado 032aaadc61ab31b2b6c80753388218c9e2d41af7. [PR 6](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/pull/6) permanece aberto, sem merge. Este diretório preserva evidências e instruções; não altera o verificador ou workflow da main.

## Causa e correção

O verificador anterior incluía platform.platform() na identidade da execução. Uma mudança de kernel/imagem do runner invalidava os registros de retomada mesmo com as mesmas fontes, versão Lean e objetos compilados. A carta 1 repetiu prefixos nas tentativas 3 e 4; os 234 objetos e logs do kernel comparados entre as tentativas 2 e 3 permaneceram idênticos.

O novo verificador separa o ambiente descritivo da identidade de verificação. A identidade estável inclui todas as fontes, as raízes pedidas, a política do verificador, a versão, o SHA256 do arquivo de distribuição Lean efetivamente baixado e os hashes dos executáveis Lean/lake/leanchecker e das bibliotecas compartilhadas da distribuição. Mudanças em qualquer desses elementos não são aceitas silenciosamente.

Para migrar um checkpoint antigo, exige o SHA256 exato dos bytes de progress.json previamente auditados. Antes de reutilizar um registro, confere objeto .olean, os dois logs e seus hashes, códigos de saída, marcadores rejeitados, contagem e ordem exata das dependências. Uma rejeição preserva o relatório anterior; migrações válidas arquivam os relatórios originais em history/. Módulos novos continuam passando por build e replay do kernel Lean.

O workflow exige cache e relatório presentes, recusa migração enquanto o run antigo estiver ativo, usa o mesmo grupo de concorrência da carta e não permite fallback para o cache legado depois da primeira tentativa migrada. Falhas de pré-validação não geram um cache v2 aparentemente válido. Os artefatos novos têm retenção de 90 dias.

## Validação realizada

- 16 testes adversariais de orquestração passaram localmente e no GitHub: alteração de objeto/log/fonte/toolchain, digest incorreto, marcador rejeitado mesmo com hash coincidente, registro duplicado, falso status completo, esquema desconhecido e preservação de relatório após rejeição.
- [CI final](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39345797202): build e replay de dois teoremas triviais reais em Lean 4.35.0; um módulo legado foi reutilizado e somente o segundo foi executado. Na retomada seguinte, com descrição de host alterada, ambos foram reutilizados e nenhum módulo foi reexecutado.
- [Teste do caminho de execução isolada](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39346213672): o workflow existente aceitou ref da branch e mode=smoke. O job smoke / regression passou; o job verify foi corretamente ignorado. Nenhuma carta H(12,4) foi iniciada nesse teste.
- Os ZIPs desses dois testes foram baixados, tiveram integridade e digest conferidos contra o GitHub e seus resultados JSON preservados, junto dos metadados e logs completos.

Esses testes certificam o comportamento de retomada no cenário exercitado. Não provam H(12,4), não encerram as cartas 0/1 e não constituem a integração matemática final.

## Estado e implantação

Os runs antigos 39258813467 e 39258818208 continuam na quarta tentativa, em seus commits originais. Não foram interrompidos ou duplicados. MIGRATION_REGISTRY.json registra os IDs e o estado da transição. A migração real aguarda a conclusão e preservação de cada rodada atual; deve usar o checkpoint mais recente, sem regredir para a tentativa 3.

A revisão automática de aprovação recusou o merge na main por considerar insuficiente a autorização para essa ação específica. A solução adotada usa somente a branch isolada, caminho também testado. Não se deve tentar novamente o merge sem autorização humana explícita. Isso não impede continuar os cálculos na branch.

Veja RUNBOOK.md para a transição e o acompanhamento. A estimativa de conclusão das duas cartas permanece provisória: o custo dos módulos não é uniforme, e contagens de dependências não são porcentagem de cobertura matemática.
