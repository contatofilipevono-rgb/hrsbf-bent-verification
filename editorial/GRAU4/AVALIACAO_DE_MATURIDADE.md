# Grau 4: avaliação editorial independente

19/10/2026. Separado da V1 cúbica. Não alterar as execuções e chaves de cache das cartas Lean em andamento.

## Evidência disponível

O projeto `quartic_audit_2026_10_17/` distingue a enumeração global em H(12,4), a verificação CPU de um certificado simbólico e a formalização Lean. O espaço tem 43 coeficientes, total 2^43 funções. A formalização global ainda depende das cartas concretas restantes e de integração final. A carta 2 tem registro completo; as cartas 0 e 1 estão sendo retomadas por checkpoints em outra linha de acompanhamento.

Os estados mudam durante a execução: consultar os relatórios atuais e não transformar esta nota num painel vivo. Sucesso operacional de uma rodada parcial não é teorema global.

## Teorema central e mapa

Para um artigo específico de H(12,4): simetria e homogeneidade quártica → filtros necessários demonstrados → leis lineares e cartas afins necessárias → cobertura simbólica de todas as cartas → testemunho de Walsh que rejeita cada folha → inexistência.

O artigo pode apresentar os lemas estruturais e a prova de correção do verificador de forma curta. O certificado concreto continua sendo uma premissa computacional indispensável enquanto não houver uma obstrução conceitual completa substituta.

## Simplificações avaliadas

- Congruências periódicas em 12 variáveis fornecem um teste inicial curto, mas a comparação integral mostrou zero exclusões adicionais nos 164.288 candidatos atuais. Não substituem a certificação.
- O lema de período 4 para H(16,4), registrado separadamente, elimina uma coordenada de coeficiente: isso é uma condição necessária, não inexistência em dimensão 16.
- Grau≤2 sobre a diagonal, por si só, não contradiz bentness.
- A quarta derivada recupera a parte quártica, mas ainda não foi demonstrada uma obstrução suficiente à bentness aplicável a todo H(12,4) ou H(16,4).

## Cuidados de origem

As afirmações antigas sobre n=10 ou famílias n=2p não são incorporadas por analogia. Exigem enunciado preciso, correção das inferências já auditadas e um certificado identificável para cada escopo. A prova cúbica universal da V1 não resolve qualquer desses casos quárticos.

## Entrega e prioridade

É viável preparar a explicação humana antes do encerramento Lean, mantendo o estado formal pendente. A edição final que se apresente como globalmente certificada deve aguardar as raízes e sua integração. Nesta etapa foi apenas avaliada a rota; não foi criado um PDF quártico de submissão nem alterado o pipeline ativo. Para esse artigo, registrar separadamente tempo de busca, tempo de verificação CPU, reconstrução Lean e leitura humana; não prometer que todos serão de minutos.
