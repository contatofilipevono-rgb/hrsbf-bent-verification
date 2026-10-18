# Auditoria quártica: H(12,4), H(16,4) e reduções estruturais

Este diretório preserva os dados desta linha de pesquisa e identifica separadamente os resultados computacionais, os certificados algébricos e a formalização Lean.

**H(12,4) foi fechado por enumeração computacional global auditada: zero bent entre 2^43 funções. A formalização Lean publicada nesta etapa cobre reduções necessárias e não constitui ainda uma prova Lean completa dessa inexistência.**

## Resultado principal e evidência

H(n,4) é o espaço binário gerado por somas de monômios distintos nas órbitas cíclicas de suportes de tamanho quatro. Não é o espaço de todas as funções de grau no máximo quatro.

| Busca global em H(12,4) | Contagem |
|---|---:|
| Coeficientes percorridos | 8.796.093.022.208 = 2^43 |
| Sobreviventes dos filtros quadráticos | 949.760 |
| Sobreviventes também de W(0)=±64 | 15.779 |
| Bent após Walsh completo | 0 |

A base original tem 43 coordenadas. As cinco leis da antiga busca condicionada **não foram impostas**. A auditoria local conferiu a fonte, a construção independente dos filtros e todos os 8.388.608 registros do log. A execução inteira na GPU não foi repetida localmente. O log registra resultados de hardware; não é um certificado formal de cada operação.

Comece por [MATHEMATICAL_EXPLANATION.md](MATHEMATICAL_EXPLANATION.md), [CLAIMS.md](CLAIMS.md) e [ADVERSARIAL_AUDIT.md](ADVERSARIAL_AUDIT.md).

## Reprodução rápida sem GPU

Requer apenas Python 3.10 ou posterior:

```sh
python verify_linear_laws.py
python verify_periodic_reduction.py
python verify_manifest.py
```

Para auditar o arquivo original e o log completo, o pacote preservado está em `archive/PACOTE_H12_GLOBAL_AUDITADO.zip`. Ele contém `RESULTADO_H12_GLOBAL.zip`, o arquivo original recebido, além do material de auditoria. Extraia o arquivo original para uma pasta de trabalho e execute:

```sh
python archive/VERIFICAR_PACOTE_GLOBAL_H12.py caminho/RESULTADO_H12_GLOBAL.zip --out auditoria_global.json
```

Consulte `archive/H12_RESULTADO_GLOBAL_AUDITADO.md` para hashes e justificativa dos filtros. O script lê o log completo, sem executar o binário CUDA recebido. Para uma segunda enumeração na GPU, consulte `archive/RODAR_H12_A100_GLOBAL.py`.

## Lean

O projeto em `lean/` usa Lean 4.35.0 e não depende de Mathlib:

```sh
cd lean
lake build
```

`H12PeriodFour.lean` contém a verificação dos 43 geradores na restrição periódica, a forma normal de quatro parâmetros e a classificação exata dos quatro casos permitidos módulo três. `H12Descent.lean` contém a partição das 4.096 entradas em órbitas e a descida de somas módulo três. O escopo detalhado de cada declaração está em `CLAIMS.md` e no registro de compilação.

`H12Audit.lean` liga essas partes à função quártica original. A compilação e a repetição das declarações pelo `leanchecker` passaram localmente; as declarações finais dependem somente de `propext` e `Quot.sound`. O teorema da redução quártica ainda recebe explicitamente a invariância rotacional e a condição de autocorrelação bent como hipóteses.

A compilação bem-sucedida desses lemas não transforma automaticamente o relatório da GPU em um teorema Lean. Ainda falta um certificado global de contradição e sua ligação formal às condições de bentness.

O modelo de automação está em `ci/quartic-audit.yml`. Ele não foi ativado: o GitHub recusou a criação de workflows com a autorização OAuth disponível. Os testes e o Lean foram executados localmente; não se afirma aprovação por CI remoto.

## Organização e proveniência

- `archive/`: cópia dos 332 artefatos de saída históricos disponíveis nesta pasta de pesquisa no momento da preparação. Inclui resultados intermediários, pacotes antigos e materiais de auditoria; **a preservação não valida cada afirmação histórica**.
- `linear_law_certificates.json`: três identidades exatas no anel booleano, com 22, 1 e 24 produtos de filtros por monômios.
- `verify_linear_laws.py`: reconstrói os filtros a partir da ANF original por Möbius e verifica as identidades, sem interpolação nem SAT.
- `verify_periodic_reduction.py`: refaz a classificação de período quatro e a aritmética das 17 órbitas curtas de entradas.
- `lean/`: fontes formais; os arquivos de execução e bibliotecas binárias do Lean não são distribuídos aqui.
- `experiments/`: tentativas de SAT/XL e geradores, incluindo execuções sem conclusão. Não são certificados UNSAT.
- `SOURCE_ARTICLE.json`: referência e checksum do PDF de Sun–Shi–Liu–Fu fornecido pelo usuário. O PDF da editora não é redistribuído nesta entrega.
- `MANIFEST.json`: hashes SHA-256 dos arquivos preservados. Integridade de arquivo não equivale a validade matemática.

Os identificadores Txx variam entre colaboradores. Use o conteúdo matemático, a proveniência e o hash para comparar certificados.
