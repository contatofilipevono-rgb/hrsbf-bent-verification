# Panorama da pesquisa bent — 7 de novembro de 2026

Documento de acompanhamento, não artigo nem alegação de resolução. Organiza as evidências locais disponíveis nesta data. As palavras “prova” e “excluído” abaixo sempre devem ser lidas com as hipóteses e o nível de revisão indicados.

## 1. Conclusão atual

**Não há resolução geral de p=17, de Q1 nem da conjectura sobre quárticas homogêneas RS.** O progresso mais útil recente é teórico: reconhecer que o resíduo de peso 1/4 já estava excluído por uma prova do Claude e que novas buscas locais nele não poderiam produzir um levantamento global.

A pesquisa se divide em frentes diferentes. Não somar resultados de uma frente como evidência para outra.

| Frente | O que temos | Limite atual |
|---|---|---|
| p=17, ramo ímpar | Pareceres excluem peso(Q)=1/4, classes complementares/balanceadas e D=QR com R quadrática | A cadeia completa que pretende deixar somente Q=1 e ramo par precisa de auditoria adversarial |
| Q1 em 20 variáveis | Exclusões estruturais de famílias; peso(D) em [769480,774257], pico Walsh não trivial <=4778 como alvo | Caso geral aberto; ausência em busca não prova impossibilidade |
| Período 20 e transferência a 380 | Censo de filtros com fração 459/2^27; controles bent fora da fibra y0 | Em 380 a aplicação depende do teorema espectral p=19; não prova inexistência |
| H16 | Cotas exatas de filtros e verificações de amostras/lotes | Não houve enumeração global de todos os candidatos |
| H12 | Dados de enumerações e reconstrução dos 3308 candidatos terminais | Domínios diferentes precisam permanecer separados; nenhuma identidade universal foi deduzida das pequenas interseções |

## 2. p=17: o que mudou na interpretação

O parecer do Claude “PARECER_RESIDUO_L0_P17.md” demonstra, sob a normalização global de X, que peso(Q)=1/4 é impossível. A releitura do Codex conferiu a lógica dos dois passos e as constantes com frações exatas. Não foi reauditada toda a derivação inicial das hipóteses a partir do problema bent.

Esboço: Q=ab. Se F=D(1+Q) não é zero, a distância mínima de Reed–Muller em um hiperplano força peso(F)>=1/32. O custo mínimo fica 374, acima do orçamento 4641/16. Se F=0, D restringe-se a uma quadrática no flat {a=b=1}; Poisson e o orçamento forçam um viés -1/2, cujo coeficiente não trivial exige 18<=213/32, contradição.

**A prova é do Claude.** A conferência recente e as rodadas GPU não constituem descoberta nova dessa exclusão.

Os pareceres “PARECER_ESTRUTURA_DQR_P17.md” e “PARECER_Q_COMPLEMENTO_P17.md” afirmam exclusões adicionais. A pretensão de reduzir toda a fronteira a Q=1 e ramo par é uma questão a certificar, não uma conclusão já auditada.

## 3. Rodadas GPU preservadas

### Posto 12, R quadrática

Checkpoint final recebido: 1.129.612.288 candidatas geradas; zero sobreviventes locais; 6041,09 segundos; interrompida pelo usuário, não concluída. GPU registrada: A100 80 GB.

O notebook e os resultados estão preservados localmente. As contagens totais são declarações do checkpoint; não houve reexecução independente de toda a geração. Amostragem sem sobreviventes não é prova de impossibilidade.

### Posto 14, R cúbica esparsa

Checkpoint: 49.914.880 candidatas; 40.679 aprovações nos filtros locais; 5242,29 segundos; interrompida. Foram salvas 1000 testemunhas distintas e 500 intermediárias. GPU registrada: A100 40 GB.

Codex reconstruiu as 1000 ANFs e recalculou integralmente os espectros em CPU, sem divergência de peso, pico ou valores proibidos. Refinamento:

| Teste nas 1000 testemunhas salvas | Resultado |
|---|---:|
| Grau booleano de B | 5 em todas |
| Falha no reticulado adicional, primeira ordem 11 | 627 |
| Passam o reticulado na base padrão | 373 |
| Grau da paridade espectral | 3 nas mesmas 627; 2 nas mesmas 373 |
| Desigualdade energética herdada, tau=-1 | Passa em todas |

Os dois testes que separam 627/373 não devem ser contados como evidências independentes. A amostra salva corresponde às primeiras aprovadas guardadas, não a uma amostra uniforme de todas as 40.679.

**Nenhuma das 373 pode levantar-se ao cenário global de peso(Q)=1/4**, sob as hipóteses da exclusão anterior. O valor dessas testemunhas é servir de controle contra filtros locais insuficientes.

Mudaram simultaneamente posto(H) e grau(R) entre as duas rodadas; não atribuir a diferença de sucesso a um deles isoladamente.

## 4. Período 20: resultados e preservação pendente

Rodada anterior: 150.994.944 candidatas, distribuídas por nove fibras; 4708 passaram os filtros e foram verificadas por Walsh completo em CPU, sem bent. Isso vale para a amostra, não para as fibras inteiras.

A hipótese de que toda bent RS quártica em 20 variáveis estaria em y0 foi refutada por uma testemunha explícita obtida de 10 variáveis e verificada diretamente. A cota do filtro 459/2^27 permanece; o caminho de melhorá-la apenas por concentração em y0 acabou.

Os notebooks Untitled15 e Untitled16 recebidos contêm outras execuções de período 20, com interrupções e o histórico da correção CUDA. Ambos usam a semente 20261108 e a pasta periodo20_A100_extra_1h. **Não somar as duas execuções como cobertura independente.** Os logs não bastam para excluir sobreposição ou verificar todos os resultados.

O código defeituoso inicial escrevia uma contagem por thread em vez da soma reduzida; a validação CPU/GPU detectou a falha antes da busca. Apenas execuções após a correção e validação são utilizáveis.

Pendente: receber o ZIP da pasta do Drive com checkpoints e sobreviventes dessas execuções. Os arquivos dos notebooks estão preservados, mas isso não equivale a preservar os arquivos externos da busca.

## 5. Q1: ganho e obstáculos

As notas do Opus/Claude tratam de quarticidade real e orçamento global, não apenas de exemplos locais arbitrários. Há exclusões escritas para produtos e subclasses de dois produtos, caso misto e certas famílias com duas formas lineares. O caso de dois hiperplanos geral permanece aberto. Os lemas por fibras e força cúbica possuem hipóteses específicas; algumas margens são pequenas e algumas classificações dependem de auditoria.

O próximo experimento não deve ser uma busca heurística extensa sem pergunta decisiva. Uma testemunha válida fecharia o problema no sentido da existência; fracasso heurístico não o fecha. Há testemunha de grau 9 para peso/pico, portanto argumentos que ignorem grau baixo não podem provar a incompatibilidade geral.

## 6. Trabalhos em curso e regra de decisão

- **Opus:** missão preparada para auditoria adversarial da fronteira de p=17, com mapa de dependências e veredito por classe. Entrega ainda não recebida.
- **Astra:** agente acionado para Q=1 e identidades globais. Anunciou redução provisória envolvendo congruência mod64 e ausência de flats de codimensão <=5 com D cúbica. **Não incorporada como teorema:** aguardam-se a nota completa e revisão independente.
- **Codex:** organizar provas e evidências; verificar os resultados recolhidos; evitar novas rodadas no resíduo global já excluído.

Critério de continuidade: cada tarefa deve provar/refutar um lema preciso, certificar uma redução, ou produzir uma testemunha verificável que mude a fronteira. Quantidade de candidatos testados, isoladamente, não mede relevância.

## 7. Proveniência e atribuição

Os pareceres teóricos citados foram produzidos pelo Claude/Opus e ainda contêm dependências sem auditoria humana. Codex fez as conferências numéricas locais descritas e a releitura da exclusão de peso 1/4. Astra trabalha em uma frente nova, ainda provisória. Resultados do Argon precisam de verificação independente; erros anteriores de constantes, citações e contagens foram corrigidos nas notas de auditoria.

Este panorama não estabelece prioridade bibliográfica nem transforma material de trabalho em resultado publicável. Os backups integrais, notebooks e certificados permanecem no arquivo local; esta publicação é um índice de estado, não um depósito completo de todos os dados.

Artefatos locais de referência: AUDITORIA_LEVANTAMENTO_GLOBAL.md, ANALISE_ESTRUTURAL.json, AUDITORIA.json, MANIFESTO.json dos pacotes preservados, CHECKPOINT_AVANCOS_BENT.md e CADERNO_TECNICAS_BENT.md. As missões e análises de 7 de novembro substituem recomendações anteriores de continuar o levantamento das 373 candidatas.
