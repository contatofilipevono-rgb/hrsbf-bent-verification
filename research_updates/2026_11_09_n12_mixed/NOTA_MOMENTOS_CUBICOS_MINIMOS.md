# Momentos módulo 8 nas 55 exclusões residuais da cobertura por dois planos

A verificação da cobertura em doze variáveis e grau quatro passa por 2.096 pares mapa–polar, em 49 tarefas. A análise abaixo trata os 55 pares que chegam ao passo módulo 8 no verificador `line_phase_algebra.py`. Todas as equações anteriores permanecem impostas. A medida é o número de equações adicionais módulo 8.

Depois da redução módulo 4, os espaços de parâmetros têm no máximo 18 dimensões. Avaliamos por conjuntos de bits os polinômios residuais módulo 4. Entre 4 e 64 atribuições sobrevivem em cada par. Cada equação módulo 8 cobre as atribuições que viola. Encontramos uma cobertura de cardinalidade mínima por recorrência exata. Para cada conjunto descoberto, escolha um ponto e tente cada equação que o cobre, removendo os pontos cobertos. Equações com conjuntos de violações incluídos em outros podem ser descartadas. A recorrência foi memoizada e a maior instância visitou 245 estados.

| Equações módulo 8 necessárias | Pares mapa–polar |
| ---: | ---: |
| 1 | 52 |
| 2 | 3 |

Os três casos de mínimo dois são:

| Código do mapa | Prefixo da polar | Atribuições após módulo 4 |
| ---: | --- | ---: |
| 2023 | `784488b4bb78b47722` | 64 |
| 134528 | `9fcaac06095cc56fc5` | 24 |
| 134528 | `f65cc59060caacf9ac` | 24 |

Nos dois casos do mapa 134528, as mesmas duas condições em momentos de ordem dois da fibra 1 bastam. No mapa 2023, a solução mínima registrada usa momentos de ordem dois das fibras 0 e 1. Isso sugere começar a análise estrutural pelas duas condições do mapa 134528 e pelos conjuntos de fases de 24 elementos.

`line-cubic-minimum.json` guarda as polares completas, os índices dos momentos e os polinômios na parametrização reduzida. O código `line_cubic_minimum.py` parte dos mesmos sistemas exatos do verificador da cobertura e reconta todas as atribuições dos espaços residuais. O mínimo é relativo à lista de momentos usada pelo verificador.

## Conferência no GitHub Actions

A execução [43201673786](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/43201673786) reconstruiu as tarefas a partir do modelo e terminou com sucesso nos 55 casos. A eliminação polinomial encontrou um núcleo do tamanho mínimo em cada caso, conferido individualmente contra a cobertura exata. A fibra 0, sozinha no passo módulo 8, basta em 54 dos 55 casos. Restringindo as equações a essa fibra, o teste de cobertura exata encontrou 50 casos com uma equação e quatro com duas. A única exceção é o mapa 2023, onde duas equações da fibra 1 bastam. A fibra 1 também basta em 42 outros casos. Momentos de ordens zero e um bastam em 18 dos 55 casos.

O alvo estrutural é portanto explicar por que os momentos de ordem até dois da fibra 0 excluem as fases nos 54 pares, usando as condições anteriores. Uma análise separada de um único mapa pode tratar a exceção.

Para reproduzir, execute os passos de preparação do fluxo `n12_cubic_ablation.yml` e depois:

```sh
python3 line_cubic_minimum.py --tasks input/tasks.bin --reference input/reference.json --output cubic-minimum.json
```
