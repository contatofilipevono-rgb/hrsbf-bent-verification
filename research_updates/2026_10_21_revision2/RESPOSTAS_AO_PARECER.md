# Respostas ao parecer adversarial — rodada 2

Parecer recebido: H12_RELATORIO_FINAL_ANALISE_ADVERSARIAL.zip, SHA256 3b9747d0123f838f5367c38ab639696cc49825c18712709cc5b12132e9d0302a. Nenhuma nota subjetiva de chance foi adotada como probabilidade. Não foi identificada objeção matemática crítica no relatório; as alterações desta rodada não mudam as fontes Lean ou o enunciado final.

| Item | Situação | Resposta e evidência |
|---|---|---|
| A1 | Corrigido | Apêndice C imprime as definições; a auditoria compara diretamente os 43 índices e todos os 495 suportes do Markdown com a fonte certificada. Não foi criado um novo teorema ANF abstrato. |
| A2 | Corrigido | Tabela por raiz com nós, bifurcações, folhas e atribuições terminais; profundidades 36/22. Dados extraídos do grafo de construtores nas fontes com hashes certificados. O relatório de integração sozinho não contém essas estatísticas. |
| A3 | Corrigido com discordância da hipótese | Estado=(k,E), ambiente=coordenadas de E, raiz e observação definidos. A soundness geral NÃO exige independência do pivô; T(z)=z no ramo aplicável basta. Todos os casos concretos foram inspecionados e têm independência. Não se atribuiu ao Lean uma hipótese inexistente. |
| A4 | Corrigido | Tabela dos 16 códigos com tabelas-verdade e direção/C_g/resíduo para cada rejeitado; sobreviventes têm todos os 15 resíduos zero. |
| A5 | Corrigido | Explicada a bijeção rotacional entre subespaços e igualdade de pesos para toda escolha de coeficientes. |
| A6 | Corrigido | Exemplo Q42: três pesos 30, demais múltiplos de quatro, interseções pares; identidade do peso módulo quatro deriva R2. Explicado o espaço linear em que os produtos podem ser encontrados. |
| A7 | Corrigido | Polinômio cúbico C(y) renomeado E_3(y); autocorrelação mantém C_f. |
| A8 | Esclarecido | A pasta foi organizada em 20/10 e a integração concluiu em 21/10. Não era necessário alterar uma data correta ou atribuir o caso genericamente ao fuso. |
| A9 | Sugestão rejeitada com prova | Não há condição de paridade adicional nesta família: cada monômio quártico sobre oito coordenadas tem peso 16, de modo que toda soma tem paridade zero. A observação correta foi incluída. |
| B1 | Corrigido | Contribuição apresentada como redução estrutural explícita e certificação, sem usar Lean ou 2^43 como prova automática de mérito. |
| B2 | Corrigido com limite | Tabela de resultados selecionados, com parâmetros e fronteiras; fontes primárias/reproduções identificadas. Busca não estabelece prioridade absoluta. |
| B3 | Corrigido sem adotar o limite sugerido | Novo resumo de 169 palavras. O anterior tinha 160, não cerca de 190. A proposta de aproximadamente 120 ficaria abaixo das 150–250 palavras exigidas por DCC. |
| B4 | Corrigido | Removido o parágrafo defensivo sobre busca versus certificado e concentrada a apresentação na cadeia da demonstração. |
| B5 | Corrigido | Caminho de JSON saiu da prova; nomes das três instâncias e dados de execução ficam no Apêndice C. |
| B6 | Corrigido | Seção Data availability separada; hashes extensos ficam nos suplementos. Escopo formal tem subseções próprias. |
| B7 | Corrigido | Relação com V1 foi movida a nota de rodapé da introdução, como preprint e sem dependência lógica. |
| B8 | Corrigido | Conclusão identifica a mudança de ordem da rotação a n=16, a necessidade de novos filtros/refutações e a existência de quadráticas bent no caso não homogêneo. |
| B9 | Conferido | Hipóteses dos dois PDFs já verificadas e preservadas com páginas/hash; não foi inferida homogeneidade só pelo grau. |
| C1 | Parcial: fatos humanos pendentes | Confirmados pelo autor: nenhum trabalho submetido, UniBH/Belo Horizonte e e-mail. Financiamento, interesses e declaração final de contribuição/aprovação ainda não foram respondidos especificamente. |
| C2 | Preparado, publicação pendente | Cinco arquivos estão no rascunho Figshare. Um DOI público arquivístico exige concluir o depósito, mantido em espera pela análise adversarial. Não se inventou DOI nem se publicou para esconder a pendência. |
| C3 | Corrigido | Declaração agora inclui Claude para a revisão adversarial incorporada, mantendo o núcleo da redação aprovada e a responsabilidade do autor. |
| C4 | Concluído com limite do método | Comparação integral do texto extraído do V1 público v2 com H12 executada; correspondências longas da versão revisada são títulos/referências e expressão do título da conjectura. Comparação matemática dos escopos documentada. Não é prova universal de ausência de paráfrase. |
| C5 | Preparado e compilado | Incluído rascunho no template oficial Springer, além do PDF de leitura. Compilado por Tectonic/XeTeX com fonte compatível com pdfLaTeX; o conversor do portal não foi testado. |
| C6 | Mitigado, limite do portal pendente | Não foi encontrada confirmação do limite específico DCC e não foi usado o limite de outra revista. Arquivos continuam separados; o checker é compacto e as fontes têm cerca de 49 MB. Há opção de fracionamento preservando fontes se o portal exigir. |
| C7 | Mantido com esclarecimento | 139 s é tempo observado em uma máquina; o relato de 101 s por outro avaliador foi distinguido. Não houve promessa de tempo universal ou reconstrução Lean. |

## Pendências reais antes da submissão

Financiamento/interesses e a declaração final de contribuições/aprovação; conclusão do depósito com DOI público; confirmação do limite de arquivos e conversão no portal. Essas pendências não impedem a segunda análise adversarial, mas impedem afirmar que a submissão está inteiramente pronta. A comparação de literatura é dirigida e não prova prioridade absoluta.
