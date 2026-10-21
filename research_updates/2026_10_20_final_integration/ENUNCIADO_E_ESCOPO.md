# Enunciado da integração final

Estado em 21/10/2026: integração final e auditoria do kernel concluídas. Consulte [CONCLUSAO_FORMAL_H12.md](CONCLUSAO_FORMAL_H12.md) para os enunciados e evidências.

O alvo principal é `∀ c : BitVec 43, ¬ H12Descent.BentAC (H12.quarticFunction c)`. Não recebe como hipóteses filtros quadráticos, condições lineares, exclusões de órbitas ou refutações ainda não instanciadas. As três refutações concretas são fornecidas por H12CloudChart0.refutation, H12CloudChart1.refutation e H12CloudChart2.refutation ao lema geral H12AffineFastState.no_bent_of_affine_state_refutations.

O predicado BentAC exige autocorrelação zero nas 4095 direções não nulas do espaço de 12 bits. H12Fourier.bent_iff_flat estabelece sua equivalência com Walsh ao quadrado igual a 4096 em todas as 4096 frequências. O módulo final inclui a inexistência de Walsh plano e uma frequência testemunha para cada vetor de coeficientes.

A função quarticFunction é a soma XOR das 43 somas de órbitas de monômios distintos de peso quatro. A auditoria independente INPUT_AUDIT.json conferiu que as órbitas são disjuntas, fechadas sob rotação de uma posição e cobrem exatamente os 495 suportes quárticos. Portanto, a família é H(12,4), com 2^43 vetores de coeficientes, incluindo o vetor zero. O arquivo final não prova um teorema abstrato de representação de toda ANF arbitrária: a identificação da base concreta com H(12,4) deve ser apresentada explicitamente ao leitor.

O escopo é o caso quártico em doze variáveis. Não conclui H(16,4), dimensões gerais ou todas as funções de grau no máximo quatro.

As cartas concluídas contêm 924, 924 e 485 módulos. Há 2091 módulos distintos na união, pois as dependências comuns se repetem nas contagens por carta. A auditoria não encontrou diferenças de fontes nem de objetos compilados nas dependências compartilhadas.

O cache temporário da carta 2 foi removido pelo serviço. O ZIP certificado e seus logs continuam preservados no Git. A integração reconstruirá somente objetos ausentes e exigirá igualdade SHA256 com os objetos já verificados pelo kernel; divergência interrompe o procedimento. Os caches finais das cartas 0 e 1 continuam disponíveis.

Execução: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39520500414

Commit executado: 344ab2e1b330d4a6be3f00603e9423db39cf3354, branch fix/lean-resume-stability. Nenhum merge do PR 6 foi realizado.
