# Retomada pelo colaborador — H(12,4)

Checkpoint atual: [162 módulos conferidos pelo kernel](ESTADO_KERNEL_162.md). As variantes de composição por linhas e seus pilotos passaram; as três cartas completas necessárias ainda estão pendentes. O pacote de 147 módulos é um snapshot anterior testado.

## Objetivo e ponto de partida

Concluir a prova Lean global de inexistência de funções bent no espaço de funções booleanas homogêneas quárticas invariantes por rotação em 12 variáveis, preservando os certificados e a auditoria adversarial. O resultado computacional global já está fechado; a formalização integral permanece em andamento.

Repositório autorizado: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification

Trabalhar na branch `main`, diretório `quartic_audit_2026_10_17`. A revisão `a8959a3` publicou o certificado simbólico completo e as duas execuções CPU; `51546b0` acrescentou a ponte espectral e um primeiro pacote de retomada; `6a3a1ac` provou a necessidade dos filtros. O estado atual tem 28 módulos formais e também prova a cobertura pelas cartas numéricas e a ligação aos sistemas transformados. Use `git rev-parse HEAD` para registrar a revisão efetivamente auditada.

Leia primeiro `CLAIMS.md`, `FORMALIZATION_STATUS.md`, `MATHEMATICAL_EXPLANATION.md` e `ADVERSARIAL_AUDIT.md`. Não é necessário retomar as buscas SAT interrompidas nem repetir a GPU para desenvolver o certificado Lean.

## Resultado computacional e dados que não podem ser confundidos

A busca GPU original percorreu literalmente 2^43 funções: 949760 zeros dos filtros, 15779 sobreviventes também de W(0), zero bent. O arquivo original foi preservado em `archive/PACOTE_H12_GLOBAL_AUDITADO.zip`; a execução GPU não foi repetida localmente.

Uma segunda rota usa condições necessárias demonstradas separadamente: quatro casos periódicos e três relações lineares, produzindo quatro cartas afins de dimensão 36. Essas cartas **não** são a antiga busca condicionada por cinco leis. Duas execuções completas CPU e um certificado simbólico independente corroboram a inexistência global por essa redução.

| Caso | Zeros quadráticos | Passam W(0) | Bent |
|---:|---:|---:|---:|
| 2 | 46912 | 1980 | 0 |
| 3 | 46400 | 492 | 0 |
| 8 | 70976 | 836 | 0 |
| 15 | 0 | 0 | 0 |

O certificado `cpu_replay/DECOMPOSITION.json` tem 67658 nós, 282418 eliminações lineares, 27178 folhas contraditórias e 6653 folhas de soluções. As folhas cobrem exatamente 164288 coeficientes originais, cada um com testemunho de Walsh. Seu SHA-256 é `2f6790b88bd8003c81c305057f1a7d86b2073a698d167038822b15a714fc7633`.

Os identificadores Txx variam entre colaboradores. Identifique resultados por conteúdo, escopo e hash. Não atribua a H(16,4) o resultado de H(12,4): não há prova global para H(16,4) neste trabalho.

## Reprodução imediata

Na raiz deste diretório, com Python 3.10 ou posterior, sem dependências adicionais:

```text
python verify_manifest.py
python verify_linear_laws.py
python verify_periodic_reduction.py
python cpu_replay/verify_model.py
python cpu_replay/verify_certificate.py
```

A última verificação levou cerca de 70–91 segundos nesta máquina. Não enumera os 2^38 pontos das cartas. Recalcula cada testemunho pela ANF original e verifica cada eliminação, combinação e divisão da árvore. Os relatórios são `cpu_replay/SYMBOLIC_CERTIFICATE_AUDIT.json` e `reports/VALIDATION_REPORT.json`.

Para os 28 módulos Lean, usar exatamente Lean 4.35.0. Na raiz deste diretório:

```text
python tools/verify_lean.py
```

Esse comando requer `lake` no PATH; aceita `--lake caminho/do/lake`. Compila e repete cada módulo em sequência para limitar o uso de memória. As provas estão compiladas e seus axiomas são impressos. A formalização usa apenas a biblioteca distribuída com Lean; não depende de Mathlib. Os avisos restantes de simplificação/variável não usada não são admissões de prova. Consulte `FORMALIZATION_STATUS.md` para as dependências lógicas padrão.

`PACOTE_MINIMO_H12_CERTIFICADO.zip` contém somente os dados e verificadores necessários para a auditoria matemática em Python. `PACOTE_RETOMADA_H12.zip`, quando presente, acrescenta as fontes Lean, relatórios e este roteiro; seu manifesto próprio cobre o conteúdo reduzido. O acervo histórico completo continua no Git, em `archive/`.

## Próximas obrigações formais, em ordem prática

1. **Instanciar o certificado global.** A cobertura das cartas está concluída em `H12Affine.covers_bent_cpu`. `H12ChartFilters.bent_root` já coloca qualquer possível bent em uma raiz de 36 variáveis com os filtros transformados necessários; as 172 substituições têm provas exatas. Use essa declaração para aplicar `H12Refutation.check_sound` ao arquivo `DECOMPOSITION.json`. O quarto caso foi eliminado; as três primeiras raízes bastam para cobrir bentness, embora os dados preservem quatro raízes. Não refazer a prova de posto por enumeração: a reconstrução já é demonstrada por identidades lineares explícitas.
2. **Completar a ponte espectral.** `H12Walsh` já prova autocorrelação bent → Walsh ±64 e a correção de uma rejeição espectral. Falta a direção Walsh plano → autocorrelação bent, para apresentar o teorema final também na definição espectral usual. A identidade de energia genérica e a permutação por translação XOR já estão disponíveis.
3. **Testes internos da árvore.** `H12Refutation.check` é executável e `check_sound` prova sua correção sob um teste terminal correto. Converter os testemunhos de `DECOMPOSITION.json` para essa estrutura, demonstrando as igualdades exigidas. A escolha de pivô ou a heurística do gerador não precisa ser formalizada; é preciso conferir a prova que ele produziu. `transform` agora normaliza cada polinômio após a substituição, evitando crescimento de duplicatas. A representação formal de cada carta é `H12Affine.rowU`; o sistema inicial correspondente está em `H12ChartFilters.targets`.
4. **Conferência concreta dos testemunhos.** O peso exato/modular e a fase linear já estão formalizados em `H12Popcount` e `H12WalshTable`. `H12WitnessTheory.check_sound` prova o teste concreto. Os 164288 testemunhos estão em 41 arquivos de dados e um agregador, na biblioteca opcional `H12WitnessCertificate`. Todos os 164288 testes e os 42 módulos opcionais passaram no kernel; usar `python tools/verify_lean_witnesses.py --lake lake --resume` para compilar e revisar sequencialmente. `H12TerminalTheory`, `H12WitnessSearch` e `H12CertificateBridge` fornecem as pontes genéricas para as folhas e as raízes. Não confundir geração dos dados, validação parcial e PASS final.
5. **Fechar o enunciado global e publicar.** A meta intermediária explícita é `∀ c : BitVec 43, ¬ H12Descent.BentAC (H12.quarticFunction c)`. A equivalência espectral já está provada em `H12Fourier.bent_iff_flat`; usá-la para exportar a versão Walsh. Compilar, imprimir axiomas, repetir os módulos pelo `leanchecker`, regenerar os hashes, testar o pacote e publicar o novo estado. Não marcar o objetivo concluído enquanto essas obrigações estiverem abertas.

A prova da necessidade dos filtros percorre `H12Restriction` (Poisson), `H12Weight` (carry quadrático), `H12Bits`/`H12TablePolynomial` (avaliação rápida correta), `H12PlaneTables`/`H12Truth` (tabelas corretas), `H12NumericFilters` (43 identidades individuais) e `H12FilterLink` (ligação final). As 43 identidades são conferidas separadamente como Booleanos, com uma prova conjunta por lista; isso foi muito mais eficiente que uma única decisão quantificada sobre `Fin 43`. `COMPLEMENT_PAIR_IDENTITY.md` explica ainda os filtros como 35 pares complementares; o verificador Python correspondente reproduz essa descrição, mas a fórmula curta não tem um lema Lean próprio.

Para conferir que as constantes formais das cartas e dos filtros são precisamente as do modelo auditado, execute `python tools/check_affine_data.py`; o relatório é `reports/AFFINE_CHART_DATA_AUDIT.json`. A prova de cobertura não confia nesse relatório: ele estabelece a proveniência em relação ao JSON, enquanto as identidades e a semântica são conferidas pelo Lean.

## Detalhes para adaptar a árvore

O Python representa um polinômio como conjunto de máscaras de monômios; máscara zero significa constante 1, singleton `1<<i` significa variável i, e produto é união de máscaras. O Lean usa listas: repetições cancelam por XOR. `normalizeFuel` e `mergeXor` preservam a avaliação; a normalização para listas de tamanho 0 ou 1 termina imediatamente.

Em cada passo linear do JSON, o campo `combination` seleciona filtros atuais. O XOR selecionado produz uma equação linear com constante `rhs` e máscara `form`. O pivô pertence à máscara; substitua a variável pivô pela constante e pelos outros termos. No Lean, `Tree.eliminate` verifica que a combinação somada a `[(2^pivot)] ++ replacement` normaliza para a lista vazia. Uma máscara de seleção deve ser convertida em lista de índices dos bits ligados.

`Tree.split` cobre ambos os valores de uma paridade: seu `form` é a expressão da variável pivô no ramo zero; o ramo um usa `0 :: form`, pois o monômio de máscara zero representa 1. As folhas de soluções do JSON têm dimensão residual de até oito. Pode-se expandi-las em divisões de variáveis até ambientes constantes ou provar diretamente a enumeração exaustiva desse espaço residual. O verificador Python mantém a lista de variáveis ativas; a versão Lean genérica preserva semanticamente o ambiente original por substituição.

O teste terminal ainda é uma hipótese explícita de `check_sound`. O fato de esse teorema compilar não confere o arquivo JSON nem seus valores Walsh. Testes pequenos de identidade correta, identidade incorreta, índice inválido e contradição espúria estão no final de `H12Refutation.lean`.

Para uma raiz k, usar o sistema `H12ChartFilters.targets[k]!`, dimensão 36, e o ambiente de 43 coordenadas formado por `H12Affine.rowU k`. `H12ChartFilters.bent_root` já fornece uma atribuição `u : BitVec 36` que satisfaz esse sistema e cujo coeficiente original é `embed k u`. Falta ligar a observação do ambiente a esse vetor e instanciar a prova da árvore.

Uma implementação possível, ainda não feita, é gerar definições dos nós em ordem inversa dos identificadores, compartilhando os filhos por nomes de constantes. Isso evita copiar a árvore inteira a cada referência. Nas folhas, pode-se enumerar a união dos suportes das coordenadas do ambiente, desde que a prova mostre que essa projeção preserva todas as observações. O teste deve validar o tamanho de 43 coordenadas e a cobertura de todas as atribuições residuais; aceitar apenas a lista externa de candidatos não basta.

## Ambiente local e continuidade

Workspace original Windows:

```text
C:\Users\Valer\Documents\Codex\2026-10-16\https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed
```

Checkout: `outputs/hrsbf-bent-verification`; distribuição Lean local: `work/lean-runtime/lean-4.35.0-windows/bin`; Python local: `C:/Users/Valer/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe`.

Os scripts em `experiments/` preservam contexto e podem mencionar caminhos do workspace. Os verificadores de produção usam caminhos relativos ao próprio arquivo. A tentativa de prova por tabela em `H12Orbit_bruteforce_interrupted.lean` foi interrompida por custo e substituída pela prova estrutural validada; não é parte do projeto compilado. As tentativas SAT interrompidas não provaram UNSAT e não são um requisito para continuar.

As duas execuções CPU já terminaram. Nenhum processo de busca é necessário para reproduzir o checkpoint. O caminho POSIX do C é proposto, mas ainda não foi executado em Linux; o Windows foi testado. O modelo de CI em `ci/` não está ativado no GitHub, pois a autorização existente não permitiu criar workflows. Não afirmar CI remoto verde.

O usuário já autorizou publicação neste repositório. Usou-se a autenticação Git existente, sem solicitar nem guardar senha. Não inclua credenciais em arquivos ou logs. A atualização final deve manter `CLAIMS.md`, `FORMALIZATION_STATUS.md`, os relatórios e os hashes coerentes com a prova realmente compilada.

## Referência nova avaliada

Kholosha–Pal, arXiv:2610.03420v1: análise em `KHOLOSHA_PAL_REVIEW.md`. Não usar a suposta contradição por Poisson e baixo grau restrito: falta a incompatibilidade adicional e há contraexemplos à suficiência desses ingredientes. A conjectura homogênea quártica não é refutada pelos controles quadráticos.
