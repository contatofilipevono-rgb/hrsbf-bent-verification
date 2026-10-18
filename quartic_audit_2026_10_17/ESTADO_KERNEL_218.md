# Checkpoint com índice Walsh compartilhado

O checkpoint contém 218 módulos Lean compilados e reproduzidos pelo kernel. Os 164.288 testemunhos Walsh originais continuam integralmente conferidos. O índice compartilhado que os reúne também passou nos 42 módulos, incluindo a prova global de correção das consultas. Isso não constitui a prova global de inexistência em H(12,4), que permanece pendente.

A composição por linhas quadráticas, a substituição afim fechada por XOR e a ligação dos rótulos aos testemunhos reais estão provadas genericamente. O novo índice divide os dados em 642 lotes de até 256 entradas e compara no Lean os coeficientes de cada árvore literal com os de um lote já certificado. Uma auditoria separada dos fontes confirmou as 164.288 chaves e os 164.287 pontos de divisão.

O ramo com o índice compartilhado passou na compilação e na reprodução pelo kernel: 3 nós, 31 transições e 16 candidatos terminais. É o mesmo ramo de outros pilotos. O maior ramo conectado anteriormente certificado continua tendo 21 nós, 121 transições e 32 candidatos. As variantes se sobrepõem; suas contagens não podem ser somadas e o número de módulos não é um percentual da prova global.

Os campos de frequência e de bits das folhas de busca não são novos certificados Walsh. A busca usa apenas o coeficiente, e sua correção recupera um testemunho real já verificado. Veja SHARED_WITNESS_INDEX.md para a distinção e a prova dessa ligação.

A execução completa escolhida usa H12AffineFastState e o índice compartilhado. O controlador tools/continue_full_fast_certificate.py verifica as três cartas sequencialmente e somente escreve a conclusão final depois das três raízes aprovadas. A conclusão só pode ser marcada como verificada depois da compilação, da reprodução pelo kernel e da auditoria dos axiomas do teorema final. O teste do encaixe lógico ainda mantém as três refutações como hipóteses explícitas.

As execuções anteriores preservam seus módulos concluídos, mas foram interrompidas para substituir o trabalho repetido. Seus blocos parciais não entram como cobertura de raízes. Os fontes das cartas ainda em execução ficam fora deste checkpoint verificado.

Para conferir as fontes e os registros publicados: python tools/audit_lean_checkpoint.py. O índice tem ainda uma auditoria independente: python tools/verify_witness_label_index_sources.py. Essas auditorias não substituem repetir as provas Lean. O pacote ZIP de 147 módulos permanece como snapshot anterior testado; não é um pacote de 218 módulos.

A prova global em Lean continua pendente. O resultado computacional global e o certificado completo em CPU mantêm o estado já auditado. Não foram realizados novos testes CUDA nesta etapa.
