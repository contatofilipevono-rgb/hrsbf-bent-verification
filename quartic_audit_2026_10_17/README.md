# Auditoria quártica: H(12,4), H(16,4) e reduções estruturais

Este diretório preserva os dados desta linha de pesquisa e identifica separadamente os resultados computacionais, os certificados algébricos e a formalização Lean.

Checkpoint atual: [218 módulos com reprodução pelo kernel](ESTADO_KERNEL_218.md), incluindo a composição por linhas quadráticas e novos pilotos. A prova Lean global continua pendente; as variantes de pilotos cobrem trechos sobrepostos.

**H(12,4) foi fechado por enumeração computacional global auditada: zero bent entre 2^43 funções. Uma segunda demonstração computacional agora está disponível por certificado simbólico de cobertura e testemunhos de Walsh, verificável em CPU sem repetir a busca. A formalização Lean cobre reduções necessárias e ainda não contém a prova global completa.**

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

Para assumir a continuação, leia [CONTINUAR_COLABORADOR.md](CONTINUAR_COLABORADOR.md) e [FORMALIZATION_STATUS.md](FORMALIZATION_STATUS.md). Eles registram comandos, evidências e obrigações formais ainda abertas.

## Reprodução rápida sem GPU

Requer apenas Python 3.10 ou posterior:

```sh
python verify_linear_laws.py
python verify_periodic_reduction.py
python verify_manifest.py
python cpu_replay/verify_model.py
python cpu_replay/verify_certificate.py
python verify_complement_pair_filters.py
```

Para auditar o arquivo original e o log completo, o pacote preservado está em `archive/PACOTE_H12_GLOBAL_AUDITADO.zip`. Ele contém `RESULTADO_H12_GLOBAL.zip`, o arquivo original recebido, além do material de auditoria. Extraia o arquivo original para uma pasta de trabalho e execute:

```sh
python archive/VERIFICAR_PACOTE_GLOBAL_H12.py caminho/RESULTADO_H12_GLOBAL.zip --out auditoria_global.json
```

Consulte `archive/H12_RESULTADO_GLOBAL_AUDITADO.md` para hashes e justificativa dos filtros. O script lê o log completo, sem executar o binário CUDA recebido. Para uma segunda enumeração na GPU, consulte `archive/RODAR_H12_A100_GLOBAL.py`.

O novo certificado em `cpu_replay/DECOMPOSITION.json` cobre simbolicamente quatro espaços afins necessários, sem enumerar seus 2^38 pontos no verificador. A verificação completa da árvore e dos testemunhos levou aproximadamente 70 segundos nesta máquina. Consulte [cpu_replay/README.md](cpu_replay/README.md).

## Lean

O projeto em `lean/` usa Lean 4.35.0 e não depende de Mathlib:

```sh
cd lean
lake build
```

`H12PeriodFour.lean` contém a verificação dos 43 geradores na restrição periódica, a forma normal de quatro parâmetros e a classificação exata dos quatro casos permitidos módulo três. `H12Descent.lean` contém a partição das 4.096 entradas em órbitas e a descida de somas módulo três. O escopo detalhado de cada declaração está em `CLAIMS.md` e no registro de compilação.

`H12Quadratic.lean` prova as três consequências lineares e a identidade curta que elimina o caso periódico 15. `H12Orbit.lean` prova a invariância por rotação mediante permutações de monômios. `H12FilterLink.bent_passes` prova que bentness implica os 43 filtros explícitos. Assim, `H12Audit.necessary_chart_constraints` recebe apenas a hipótese de autocorrelação bent e deduz os casos 2, 3 e 8 e as três leis lineares.

`H12CertificateTheory.lean` prova a correção da normalização e substituição de polinômios booleanos. `H12Refutation.lean` define um verificador executável de árvores e prova sua correção, condicionada à correção do teste terminal. A árvore numérica global e o teste de Walsh terminal ainda não foram instanciados nesse verificador. Os testes pequenos incluem certificados válidos e dados deliberadamente inválidos.

`H12Walsh.lean` prova que a autocorrelação bent implica Walsh ±64 e que uma frequência com quadrado diferente de 4096 rejeita bentness. `H12Restriction` e `H12Weight` provam a passagem de Walsh aos polinômios de peso. `H12Bits` e `H12TablePolynomial` dão uma avaliação rápida com prova de correção; `H12PlaneTables` e `H12Truth` ligam as tabelas de verdade aos geradores; `H12NumericFilters` confere as 43 identidades numéricas.

`H12Affine` prova que todo possível bent é reconstruído por uma das cartas numéricas, com igualdade à fórmula XOR da CPU. `H12Compose` prova a substituição de polinômios; `H12ChartFilters` confere as 172 transformações e coloca o candidato em uma raiz do certificado.

São 28 módulos formais na biblioteca principal. As dependências lógicas são apenas `propext`, `Quot.sound` e, em alguns lemas, `Classical.choice`. Não há `sorry`, avaliação nativa como axioma ou axiomas particulares do projeto. A equivalência entre autocorrelação bent e Walsh plano está provada em `H12Fourier.bent_iff_flat`.

Para compilar e repetir as declarações de todos os módulos com uso de memória limitado, execute na raiz deste diretório:

```sh
python tools/verify_lean.py
```

Esse procedimento requer `lake` do Lean 4.35.0 no PATH; aceita `--lake caminho/do/lake` para uma instalação específica. A repetição ocorre em sequência. O verificador é o núcleo Lean distribuído, não um segundo núcleo independente.

A compilação bem-sucedida desses lemas não transforma automaticamente o certificado Python em um teorema Lean. Ainda falta instanciar a cobertura da árvore numérica e terminar a conferência de todos os testemunhos. As pontes semânticas dos pesos, das fases e das folhas estão provadas; `H12CertificateBridge.no_bent_of_three_refutations` deixa explícitas as três refutações ainda necessárias.

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

## Conferência concreta de testemunhos

Os 164288 testes gerados ficam em uma biblioteca opcional separada, para que a compilação normal dos lemas não exija a verificação numérica inteira. Todos os 164288 testes passaram na compilação e na reprodução independente pelo kernel Lean; os 41 módulos de dados e o agregador estão auditados em `reports/LEAN_WITNESS_KERNEL_AUDIT.json`. Para reproduzir sequencialmente:

```sh
python tools/verify_lean_witnesses.py --lake lake --resume
```

O comando produz registros por módulo e relatório em `reports/LEAN_WITNESS_KERNEL_AUDIT.json`. Um arquivo fonte gerado não representa um teste aprovado; exigir o relatório final `PASS_ALL_WALSH_REJECTIONS_KERNEL_CHECKED`. Mesmo esse PASS não substitui a cobertura formal da árvore.

Veja `KHOLOSHA_PAL_REVIEW.md` para a avaliação da referência de outubro de 2026 e a correção da inferência sobre o subespaço autodual.


## Later packed-theory checkpoint

The optional packed polynomial theory has passed a separate build and kernel replay; see [PACKED_FORMALIZATION_STATUS.md](PACKED_FORMALIZATION_STATUS.md). The generated limited subtree pilot remains separate from the 28 primary modules and the previously tested handoff ZIP. The complete concrete Lean tree and unconditional nonexistence theorem remain pending. The latest fixed witness checkpoint is in `reports/LEAN_WITNESS_KERNEL_PROGRESS.json`; all 164,288 concrete Walsh rejections have now passed the Lean kernel; global tree coverage remains pending.


O checkpoint posterior com 147 módulos conferidos está descrito em [ESTADO_KERNEL_147.md](ESTADO_KERNEL_147.md). Todos os testemunhos de Walsh passaram; a cobertura global no Lean permanece pendente.
