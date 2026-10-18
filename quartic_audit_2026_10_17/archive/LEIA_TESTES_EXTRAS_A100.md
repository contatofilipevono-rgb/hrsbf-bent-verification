# Uso dos 45 minutos extras

Espere a execução atual terminar e preserve sua pasta `h12_a100_auditado`. A nova busca usa outra pasta, `h12_a100_global`. Não execute duas buscas simultâneas na mesma GPU.

## 1. Auditoria da busca atual

Envie `AUDITAR_RESULTADO_H12.py` ao mesmo Colab e execute:

```python
%run AUDITAR_RESULTADO_H12.py h12_a100_auditado
```

Ela verifica o hash da fonte contra os metadados, os registros de progresso e o resumo final do log mais recente. Reconstrói por ANF e transformação de Möbius as funções usadas em oito intervalos de 128 candidatos, repete esses intervalos na GPU e exige concordância das contagens dos filtros, de W(0) e de bent. Qualquer bent anunciada no log é reconstruída pelos 43 coeficientes e verificada por Walsh completo.

Essa amostragem reforça a auditoria da implementação; não substitui uma repetição independente da busca inteira, nem prova a necessidade das cinco leis iniciais. Preserve o resultado `auditoria_independente.json`.

## 2. Busca global sem as cinco hipóteses

Envie `RODAR_H12_A100_GLOBAL.py` e execute depois da auditoria:

```python
%run RODAR_H12_A100_GLOBAL.py --full --minutes 40
```

O espaço inteiro agora tem 2^43 = 8.796.093.022.208 funções homogêneas de grau quatro invariantes por rotação em 12 variáveis. Nenhuma das cinco leis é imposta. A enumeração é 128 vezes maior que a anterior; a duração não foi medida nesta nova implementação.

O limite de tempo é conferido entre lotes e inclui o trabalho de busca e Walsh na CPU. A preparação e a compilação ficam fora desse limite. Deixamos cinco minutos de margem, mas a parada pode ultrapassar o limite pelo tempo do último lote. O programa guarda todos os lotes no log e mostra apenas parte das linhas na tela para evitar sobrecarregar o Colab.

Para um piloto antes da execução longa:

```python
%run RODAR_H12_A100_GLOBAL.py
```

O piloto testa 2^22 candidatos e não cobre todo o espaço. O modelo usa 43 filtros quadráticos necessários, W(0)=±64 e Walsh completo de todos os sobreviventes finais. Todos os 2.093 vetores de controle enviados à GPU têm resultados esperados calculados diretamente pelos pesos nas funções originais, sem usar as matrizes quadráticas para gerar esses valores esperados.

## Justificativa dos filtros globais

Para uma função bent em 12 variáveis, cada coeficiente de Walsh vale ±64. Em qualquer subcubo coordenado de dimensão oito, a soma dos sinais de f é 1/16 da soma de 16 coeficientes de Walsh. Como a soma de 16 sinais ±1 é par, essa soma no subcubo é múltipla de oito. Portanto o peso de f no subcubo é múltiplo de quatro: seu bit de ordem um é zero.

Para qualquer função linear nos 43 coeficientes, o bit de ordem um de seu peso é um polinômio de grau no máximo dois nesses coeficientes: o segundo bit de uma soma de bits é a soma módulo dois dos produtos de todos os pares. Isso justifica reconstruir os 43 filtros em 947 pontos (origem, 43 direções e 903 pares), sem assumir leis adicionais. A rotação permite usar os 43 representantes de suportes de peso oito.

W(0)=4096−2·peso exige peso 2016 ou 2080. O teste final de bent exige valor absoluto 64 em todas as 4096 frequências; passar nos filtros anteriores não basta.

## Interpretação da saída

- `CPU_GPU_VALIDATION_PASS 2093`: controles operacionais CPU/GPU concordaram.
- `PARTIAL_TIME_LIMIT`: busca incompleta; o campo `count` informa apenas os candidatos percorridos.
- `COMPLETE_RANGE`: o intervalo pedido terminou. Só há cobertura global se `start=0` e `count=8796093022208`.
- Uma bent com seus coeficientes é uma candidata explícita que deve passar também pelo auditor independente.

Se houver cobertura global com zero bent, teremos uma verificação computacional exaustiva da inexistência em H(12,4), sem depender das cinco leis iniciais. Ela ainda deve ser auditada e reproduzida antes de sustentar uma publicação. Não conclui inexistência em H(16,4) nem em dimensão geral.

Baixe `model.json` e `run_*.log` de `h12_a100_global`. Para retomar uma busca parcial, use `--start` igual ao último `end_exclusive` concluído e `--count` igual a 8796093022208 menos esse valor; preserve os logs anteriores. O auditor verifica uma execução por chamada e não une automaticamente os intervalos de várias execuções.

Validação feita neste computador: reconstrução CPU, 2.093 controles, comparação das 43 colunas por uma implementação independente via Möbius, e duas funções bent conhecidas que passam nos filtros globais. **A compilação e a execução da nova versão CUDA ainda precisam ser verificadas na A100.**
