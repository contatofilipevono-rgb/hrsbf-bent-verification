# Retomada pelo colaborador — H(12,4)

## Objetivo e ponto de partida

Concluir a prova Lean global de inexistência de funções bent no espaço de funções booleanas homogêneas quárticas invariantes por rotação em 12 variáveis, preservando os certificados e a auditoria adversarial. O resultado computacional global já está fechado; a formalização integral permanece em andamento.

Repositório autorizado: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification

Trabalhar na branch `main`, diretório `quartic_audit_2026_10_17`. A revisão `a8959a3` publicou o certificado simbólico completo e as duas execuções CPU; `51546b0` acrescentou a ponte espectral e um primeiro pacote de retomada. O estado atual tem 18 módulos formais e conclui a prova de que bentness implica os 43 filtros explícitos. Use `git rev-parse HEAD` para registrar a revisão efetivamente auditada.

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

Para os 18 módulos Lean, usar exatamente Lean 4.35.0. Na raiz deste diretório:

```text
python tools/verify_lean.py
```

Esse comando requer `lake` no PATH; aceita `--lake caminho/do/lake`. Compila e repete cada módulo em sequência para limitar o uso de memória. As provas estão compiladas e seus axiomas são impressos. A formalização usa apenas a biblioteca distribuída com Lean; não depende de Mathlib. Os avisos restantes de simplificação/variável não usada não são admissões de prova. Consulte `FORMALIZATION_STATUS.md` para as dependências lógicas padrão.

`PACOTE_MINIMO_H12_CERTIFICADO.zip` contém somente os dados e verificadores necessários para a auditoria matemática em Python. `PACOTE_RETOMADA_H12.zip`, quando presente, acrescenta as fontes Lean, relatórios e este roteiro; seu manifesto próprio cobre o conteúdo reduzido. O acervo histórico completo continua no Git, em `archive/`.

## Próximas obrigações formais, em ordem prática

1. **Cobertura das cartas.** Ligar `necessary_chart_constraints` às bases e offsets numéricos de `cpu_replay/model.json`. A necessidade dos 43 filtros foi concluída em `H12FilterLink.bent_passes`; o teorema das restrições já recebe somente bentness. O quarto caso foi eliminado pela identidade curta. Falta provar formalmente que todo coeficiente satisfazendo essas restrições está na carta numérica correspondente. Os postos 7 e 36 já estão verificados em Python; não tomar esses resultados como axiomas formais.
2. **Completar a ponte espectral.** `H12Walsh` já prova autocorrelação bent → Walsh ±64 e a correção de uma rejeição espectral. Falta a direção Walsh plano → autocorrelação bent, para apresentar o teorema final também na definição espectral usual. A identidade de energia genérica e a permutação por translação XOR já estão disponíveis.
3. **Instanciar o verificador.** `H12Refutation.check` é executável e `check_sound` prova sua correção sob um teste terminal correto. Converter os testemunhos de `DECOMPOSITION.json` para essa estrutura, demonstrando as igualdades exigidas. A escolha de pivô ou a heurística do gerador não precisa ser formalizada; é preciso conferir a prova que ele produziu. `transform` agora normaliza cada polinômio após a substituição, evitando crescimento de duplicatas.
4. **Testes terminais eficientes.** A semântica dos bitsets dos geradores já está provada em `H12Truth.basis_semantics`. Ligar a fase linear à definição `H12Walsh.walsh` e aplicar uma rejeição por peso modular. `H12Bits` já calcula dois bits do peso por operações em blocos, com prova de correção; generalizar esse contador. A auditoria `reports/WALSH_WITNESS_MODULI.json` mostra que cada testemunho precisa de apenas 4–10 bits do peso, com distribuição 25920/90538/25384/18304/3563/579 para 4/5/6/8/9/10 bits. Não é necessário calcular o peso inteiro para rejeitar esses dados. Ainda falta provar e executar esses testes em Lean; a auditoria atual é Python. Não anunciar uma etapa executada por avaliação nativa como se fosse uma prova pura do núcleo.
5. **Fechar o enunciado global e publicar.** A meta intermediária explícita é `∀ c : BitVec 43, ¬ H12Descent.BentAC (H12.quarticFunction c)`. Exportar também a versão em Walsh após concluir a equivalência. Compilar, imprimir axiomas, repetir os módulos pelo `leanchecker`, regenerar os hashes, testar o pacote e publicar o novo estado. Não marcar o objetivo concluído enquanto essas obrigações estiverem abertas.

A prova da necessidade dos filtros percorre `H12Restriction` (Poisson), `H12Weight` (carry quadrático), `H12Bits`/`H12TablePolynomial` (avaliação rápida correta), `H12PlaneTables`/`H12Truth` (tabelas corretas), `H12NumericFilters` (43 identidades individuais) e `H12FilterLink` (ligação final). As 43 identidades são conferidas separadamente como Booleanos, com uma prova conjunta por lista; isso foi muito mais eficiente que uma única decisão quantificada sobre `Fin 43`. `COMPLEMENT_PAIR_IDENTITY.md` explica ainda os filtros como 35 pares complementares; o verificador Python correspondente reproduz essa descrição, mas a fórmula curta não tem um lema Lean próprio.

## Detalhes para adaptar a árvore

O Python representa um polinômio como conjunto de máscaras de monômios; máscara zero significa constante 1, singleton `1<<i` significa variável i, e produto é união de máscaras. O Lean usa listas: repetições cancelam por XOR. `normalizeFuel` e `mergeXor` preservam a avaliação; a normalização para listas de tamanho 0 ou 1 termina imediatamente.

Em cada passo linear do JSON, o campo `combination` seleciona filtros atuais. O XOR selecionado produz uma equação linear com constante `rhs` e máscara `form`. O pivô pertence à máscara; substitua a variável pivô pela constante e pelos outros termos. No Lean, `Tree.eliminate` verifica que a combinação somada a `[(2^pivot)] ++ replacement` normaliza para a lista vazia. Uma máscara de seleção deve ser convertida em lista de índices dos bits ligados.

`Tree.split` cobre ambos os valores de uma paridade: seu `form` é a expressão da variável pivô no ramo zero; o ramo um usa `0 :: form`, pois o monômio de máscara zero representa 1. As folhas de soluções do JSON têm dimensão residual de até oito. Pode-se expandi-las em divisões de variáveis até ambientes constantes ou provar diretamente a enumeração exaustiva desse espaço residual. O verificador Python mantém a lista de variáveis ativas; a versão Lean genérica preserva semanticamente o ambiente original por substituição.

O teste terminal ainda é uma hipótese explícita de `check_sound`. O fato de esse teorema compilar não confere o arquivo JSON nem seus valores Walsh. Testes pequenos de identidade correta, identidade incorreta, índice inválido e contradição espúria estão no final de `H12Refutation.lean`.

## Ambiente local e continuidade

Workspace original Windows:

```text
C:\Users\Valer\Documents\Codex\2026-10-16\https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed
```

Checkout: `outputs/hrsbf-bent-verification`; distribuição Lean local: `work/lean-runtime/lean-4.35.0-windows/bin`; Python local: `C:/Users/Valer/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe`.

Os scripts em `experiments/` preservam contexto e podem mencionar caminhos do workspace. Os verificadores de produção usam caminhos relativos ao próprio arquivo. A tentativa de prova por tabela em `H12Orbit_bruteforce_interrupted.lean` foi interrompida por custo e substituída pela prova estrutural validada; não é parte do projeto compilado. As tentativas SAT interrompidas não provaram UNSAT e não são um requisito para continuar.

As duas execuções CPU já terminaram. Nenhum processo de busca é necessário para reproduzir o checkpoint. O caminho POSIX do C é proposto, mas ainda não foi executado em Linux; o Windows foi testado. O modelo de CI em `ci/` não está ativado no GitHub, pois a autorização existente não permitiu criar workflows. Não afirmar CI remoto verde.

O usuário já autorizou publicação neste repositório. Usou-se a autenticação Git existente, sem solicitar nem guardar senha. Não inclua credenciais em arquivos ou logs. A atualização final deve manter `CLAIMS.md`, `FORMALIZATION_STATUS.md`, os relatórios e os hashes coerentes com a prova realmente compilada.
