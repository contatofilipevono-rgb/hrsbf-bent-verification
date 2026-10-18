# T85: integração e validação dos filtros

Foi implementado um único modelo que reúne o núcleo de seis condições, os filtros que completam as treze condições anteriores, as seis amplitudes exatas de período divisor de quatro, as 36 congruências de Walsh módulo 512 de período divisor de oito e a condição completa 128|h(0x7f7f).

As 36 congruências são necessárias, mas não impõem por si só que todas essas amplitudes tenham módulo 256. Mesmo uma solução deste modelo ainda precisaria passar pelo espectro completo de Walsh.

## Contadores compartilhados e redução

Os contadores completos das classes de projeção de período oito são somados para obter os seis contadores de período quatro. A identidade usada é pi4(x)=pi4(pi8(x)). A implementação verifica que cada classe de período oito vai para uma única classe de período quatro e que as capacidades agregadas coincidem.

Os filtros h usam as mesmas variáveis de verdade das órbitas. Para os suportes pares considerados, se w_O(u) é a soma de (-1)^wt(x) sobre x da órbita O contidos em u, então h_f(u)=-2 soma_O w_O(u) f(O). A soma constante desaparece porque u é não vazio. A representação respeita as três leis lineares e o ramo b escolhido.

Para reduzir o circuito, usamos w*y=(-w)*(1-y)+w quando w<0 e dividimos pesos, constante e módulo por um divisor comum. Essa alteração preserva exatamente a congruência.

| Ramo | Variáveis antes | Variáveis depois | Redução |
|---|---:|---:|---:|
| b=0 | 98.404 | 78.582 | 20,14% |
| b=1 | 97.823 | 78.549 | 19,70% |

São medidas de tamanho do modelo, não uma comparação geral de velocidade. O modelo usa 4.035 assinaturas de verdade compartilhadas. As estatísticas de cláusulas em `joint_clauses` abrangem o circuito adicional; não incluem as cláusulas do núcleo construídas antes dele.

## Validação concluída

- 512 atribuições de contadores ponderados e 512 de combinações lineares: PASS.
- 1.024 atribuições para normalização de sinais e divisores comuns: PASS.
- Quatro funções originais, duas por ramo: 168 valores de contadores completos conferidos diretamente, incluindo as agregações de período quatro.
- 36 testes individuais dos novos componentes: tabela de seis amplitudes e oito filtros h, com respostas positivas e negativas comparadas às funções originais.
- Quatro testes conjuntos das 36 congruências, todos rejeitando corretamente os respectivos exemplos conhecidos.

Os registros completos estão em T85_CONTROLES_RAMO0.json, T85_CONTROLES_RAMO1.json e T85_NORMALIZACAO_VERIFICACAO.json. Esses testes validam componentes e exemplos; não constituem uma enumeração de todas as funções de H(16,4).

O exemplo T83 do ramo zero continua passando pelas treze condições, pelas seis amplitudes exatas e por 128|h(0x7f7f). O modelo ampliado o rejeita pelas congruências de período oito, como esperado a partir de W(0x0101)=1024.

## Pilotos e gargalo identificado

As primeiras execuções ficaram demoradas já no controle com coeficientes fixados. Uma captura da pilha localizou a espera na chamada ao solver. Desativar sua formação de matrizes XOR com a opção maxmatrixrows=0 permitiu concluir os controles rapidamente. As execuções antigas foram interrompidas; não produziram conclusões matemáticas.

Com essa configuração, foram concluídos pilotos do modelo otimizado, com limite solicitado de 45 segundos por chamada:

| Ramo | Tempo da busca | Resposta |
|---|---:|---|
| b=0 | 45,005 s | inconclusiva |
| b=1 | 45,073 s | inconclusiva |

Um piloto preliminar do ramo zero, com controles reduzidos, também retornou inconclusivo em 48,202 s. Nenhuma dessas respostas significa UNSAT. Não foi encontrada uma solução, nem demonstrada sua inexistência, nesses pilotos.

O limite global auditado permanece T47: exclusão de pelo menos 99,96808978000678%. O refinamento Top16 relatado pelo Gemini ainda depende de reconstrução e verificação independente dos seus certificados de posto.

## Continuação orientada pelos resultados

O modelo agora permite ativar separadamente as frequências e os filtros. A próxima experiência de busca deve acrescentar restrições progressivamente, escolhendo uma frequência violada por cada solução encontrada, e registrar qual acréscimo torna a busca difícil. A auditoria Top16 é uma frente separada para melhorar a cota certificada. Repetir os mesmos pilotos apenas com limites maiores ainda não tem justificativa experimental.

Implementação de trabalho: work/T85_joint_search.py. Execução a partir da raiz do projeto com o Python disponível: `python work/T85_joint_search.py 0` e `python work/T85_joint_search.py 1`. Exige as dependências e arquivos de trabalho já existentes; não é um pacote autônomo. O componente público CODIFICADOR_CONTADORES_COMPARTILHADOS.py foi atualizado com contadores completos e ativação opcional da tabela exata. Nenhum processo desta rodada foi deixado em execução.
