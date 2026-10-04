# Versão consolidada para submissão em 5 de outubro de 2026

A branch submissao-2026-10-05 foi criada a partir do commit 9f033646fbadcb13cfdd181a6ceeb3939a6296ed da revisão científica. O conteúdo matemático dessa versão está separado da pesquisa posterior, que usa a branch pesquisa-t32-2026-10-04.

## Alcance

Exclusão de cúbicas homogêneas simétricas por rotação em toda dimensão positiva par não divisível por 32. Os lemas de redução por ordem ímpar e de dobramento de órbitas integram a prova. Não há alegação de resolução geral em n=32 ou da conjectura completa.

## Evidências consolidadas

A suíte verify_submission.py passou em seus quatro estágios; os registros estão em auditoria_2026_10_04/. Uma implementação adicional independente confirmou as 136.697 condições em n=16, os controles quadráticos e o dobramento de órbitas. As comparações integrais com Meng–Chen–Fu (2010) e Sun–Shi–Liu–Fu (2026) estão documentadas. RESPOSTA_CRITICA_REDUCAO.md explica as hipóteses específicas da transferência.

Execute python verify_submission.py na cópia extraída do repositório. O manifesto exige os arquivos e os bytes da versão registrada; o hash não constitui assinatura de autoria ou revisão por pares.

## Antes de enviar

Os arquivos principais são paper_hrsbf.tex, supplementary_material.tex e cover_letter_dcc.tex. Autoria e afiliações permanecem com campos de rascunho. Confirmar lista e ordem de autores, afiliações, e-mail correspondente e declarações aplicáveis; não enviar com os campos incompletos. Qualquer alteração nesses arquivos requer atualizar o manifesto de hashes.

Não foi realizada uma revisão externa nem uma submissão automática à revista. A data de 5 de outubro é a intenção informada pelo autor, não uma promessa de prontidão editorial. O roteiro para leitura externa e os dados necessários estão em PREPARACAO_SUBMISSAO.md.

## Separação da próxima pesquisa

Resultados posteriores em n=32 devem permanecer na branch pesquisa-t32-2026-10-04 e não modificar o enunciado ou as evidências desta versão sem uma nova revisão explícita. Serão distinguidos parâmetros excluídos por certificado, parâmetros ainda não resolvidos e funções efetivamente verificadas; nenhuma condição necessária será apresentada como prova suficiente de bentness.
