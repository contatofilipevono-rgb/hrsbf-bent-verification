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

`line-cubic-minimum.json` guarda as polares completas, os índices dos momentos e os polinômios na parametrização reduzida. O código `line_cubic_minimum.py` parte dos mesmos sistemas exatos do verificador da cobertura e reconta todas as atribuições dos espaços residuais. O mínimo é relativo à lista de momentos usada pelo verificador. A etapa complementar no GitHub testa quais núcleos curtos podem ser excluídos por eliminação polinomial, sem avaliar todas as atribuições.

Para reproduzir, execute os passos de preparação do fluxo `n12_cubic_ablation.yml` e depois:

```sh
python3 line_cubic_minimum.py --tasks input/tasks.bin --reference input/reference.json --output cubic-minimum.json
```
