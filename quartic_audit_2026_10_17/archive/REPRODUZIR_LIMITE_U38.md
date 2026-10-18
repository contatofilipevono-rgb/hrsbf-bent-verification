# Reproduzir o limite global U38

Resultado: passagem de funções bent em H(16,4) no máximo **2011309/2^35**; exclusão de pelo menos **99,9941463203%**. Não é uma prova de inexistência global. A origem dos novos dados e a demonstração estão em T95_REDUCAO_U38_E_LIMITE_GLOBAL.md.

O pacote contém os certificados e os scripts de reprodução. A pasta `gemini/` contém somente as dependências originais necessárias dos produtores de coeficientes; esses arquivos foram preservados sem alterações. A auditoria do pacote completo Gemini é uma etapa anterior e separada.

Use Python 3.10 ou superior. Os produtores e verificadores centrais abaixo usam a biblioteca padrão. Execute os comandos na pasta extraída. Tempos dependem do computador; a reexecução completa pode levar vários minutos.

## Conferência rápida dos certificados recebidos

```
python VERIFICAR_CADEIA_U38_T98.py
```

Essa execução confere o núcleo cúbico completo, as dimensões das aplicações lineares, a compressão, os blocos, a correspondência entre histogramas e a agregação racional. Usa os resultados de enumeração armazenados; não recalcula os milhões de postos.

## Recalcular todos os coeficientes e estados

```
python VERIFICAR_U38_EXATO_T88.py gemini
python GERAR_MATRIZES_AFINS_U38_T89.py gemini
python ENUMERAR_ESTADOS_U38_T91.py
python GERAR_LIMITE_PONDERADO_U38_T92.py gemini
```

O primeiro comando examina todos os 8.436 coeficientes cúbicos em U38. O segundo reconstrói a aplicação afim das matrizes pela origem e pelos 116 vetores unitários. O terceiro enumera os estados das 26 matrizes individuais. O quarto calcula o limite com sete combinações e todos os 127 caracteres.

## Recalcular o limite por outra eliminação e a extensão a oito condições

```
python VERIFICAR_LIMITE_U38_T94.py
python VERIFICAR_EXTENSAO_U38_T96.py 128 256
python VERIFICAR_CADEIA_U38_T98.py
```

T94 usa pesos em forma fechada e pivôs mais baixos, independentemente do produtor T92. T96 recalcula os 128 caracteres novos, comparando postos por pivôs altos e baixos em cada estado de peso não nulo. O último comando prefere o arquivo único T96_PARCIAL_128_256.json recém-calculado; se ele não existir, usa as oito partições fornecidas.

As partições recebidas foram calculadas em paralelo. Rodar os comandos acima sequencialmente é mais simples e pode ser mais demorado. Os arquivos de saída contêm tempos de execução, que mudam a cada reexecução: o manifesto SHA256SUMS_U38.txt identifica os arquivos originalmente distribuídos, e não promete hashes idênticos depois de regenerá-los.

Não confundir independência linear das equações com independência probabilística. O limite usa os pesos exatos do núcleo em todos os estados, não uma estimativa de sobrevivência amostral.
