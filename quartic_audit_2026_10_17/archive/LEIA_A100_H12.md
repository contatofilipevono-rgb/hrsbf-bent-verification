# Execução na A100: versão corrigida

Abra `H12_A100_AUDITADO.ipynb` no Google Colab e ative uma GPU. Execute as células de preparação e piloto. O piloto cobre 2^22 candidatos (4.194.304); a célula opcional `--full` cobre 2^36 (68.719.476.736). Não há tempo prometido: primeiro meça o piloto.

Alternativa pelo arquivo Python:

```python
%run RODAR_H12_A100_AUDITADO.py
```

Depois de conferir o piloto:

```python
%run RODAR_H12_A100_AUDITADO.py --full
```

Baixe e preserve a pasta `h12_a100_auditado`, principalmente `model.json` e os arquivos `run_*.log`. Envie esses arquivos para avaliar o resultado. Uma execução completa deve terminar com `COMPLETE_CONDITIONAL_RANGE`, início zero e contagem 68719476736. Erros ou interrupções não certificam completude. Cada linha `end_exclusive` identifica o fim de um lote concluído e verificado. Para retomar, informe `--start VALOR --count RESTANTE` e preserve todos os logs.

## Problemas encontrados no original

1. O gerador faz `bit = rhs ^ sum(...)` e usa `if bit`, sem reduzir módulo dois. Uma soma igual a dois acaba tratada como um. Exemplo reproduzido: coordenadas livres 2 e 3 produzem `0x2000000039`; a combinação linear correta é `0x30`. Todas as 43 máscaras lineares e 1.548 linhas quadráticas do CUDA anexado coincidem com o JSON desse gerador. A reconstrução corrigida tem 42 equações ativas.
2. As chamadas CUDA não verificam erros, mas o programa pode imprimir “THEOREM CERTIFIED”. A versão corrigida encerra com erro se falhar uma chamada CUDA ou o processo.
3. Os filtros quadráticos aceitam a função zero, que não é bent. A versão corrigida exige também W(0)=±64 e calcula todos os 4.096 coeficientes de Walsh dos sobreviventes finais. Todo bent encontrado é registrado com seus 43 coeficientes.

## Validação e alcance

A versão corrigida reconstrói as órbitas de monômios e as funções originais. Verifica a hipótese de multiplicidades que garante grau no máximo dois, interpola as 47 condições em 667 pontos, remove cinco identidades e confere 294 casos adicionais e de borda. A base de 36 direções coincide com a auditoria independente T100. Antes da busca, a GPU deverá concordar com os 294 vetores de resultados calculados na CPU. Cada lote usa capacidade suficiente para todos os seus candidatos, sem truncar sobreviventes.

A validação CPU passou neste computador; **a compilação e a execução CUDA ainda não foram testadas aqui**. O piloto na A100 fará essa validação operacional. A documentação NVIDIA explica a necessidade de conferir tanto erros de lançamento como erros assíncronos: <https://developer.nvidia.com/blog/how-query-device-properties-and-handle-errors-cuda-cc/>.

**A necessidade das cinco leis iniciais para toda função bent de H(12,4) permanece pendente na auditoria.** As duas leis adicionais foram certificadas sob essas cinco hipóteses. Assim, uma busca completa sem bent resolve o domínio condicionado das sete leis; ainda exige justificar as cinco primeiras para concluir a inexistência global em H(12,4). Ela não resolve H(16,4).
