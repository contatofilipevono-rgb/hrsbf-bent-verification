# Plano de mudanças no artigo (como eu mudaria)

Regra geral: mudanças de exposição **não** exigem revalidar o Lean nem repetir a busca. Registrar tudo em `CHANGELOG_SUBMISSAO.md` (data, versão, motivo, alcance), distinguindo exposição, correção matemática e alteração de certificado. Qualquer mudança em enunciados, hipóteses, Apêndice A/B ou nas definições formais exige revalidar o que foi afetado.

Impacto na formalização: **nenhum**, salvo onde indicado.

## Ordem de aplicação (maior impacto primeiro)

1. Resumo e contribuição (B1, B3, B4)
2. Estado da arte (B2) — exige verificação de literatura
3. Base de confiança Lean (A1)
4. Seção 4 autocontida (A3) + tamanho do certificado (A2)
5. Lema 3.3 e demais lemas (A4–A7)
6. Reorganização (B5–B8)
7. Datas, notação, declaração de IA (A8, C3)

## Mudança 1 — Resumo (substituir)

Antes (resumo atual, ~190 palavras): lista de técnicas, "accompanying data documentation", "Verification of the certificate does not require repeating the original exhaustive search."

Depois:

> A rotation symmetric Boolean function on twelve variables is homogeneous of degree four if its algebraic normal form consists of orbits of degree-four monomials. We prove that none of the 2^43 such functions is bent, settling the case (n,d)=(12,4) of the conjecture that homogeneous rotation symmetric functions of degree greater than two are never bent. The proof first derives, from divisibility of restricted weights and autocorrelations on 4-periodic inputs, 43 quadratic necessary conditions and three affine families of dimension 36 containing every candidate. It then refutes each family by an explicit tree of polynomial substitutions with exact Walsh witnesses at the leaves. The soundness of the refutation scheme and its three instances are verified in Lean 4, and an independent Python checker replays the finite part.

Conferir: "settling the case (n,d)=(12,4)" só se a verificação de literatura (Mudança 2) confirmar que estava aberto; senão trocar por "we show that".
Atualizar também o resumo copiado em `RESUMO_E_DADOS_SUBMISSAO.md` (hoje é transcrição do antigo).

## Mudança 2 — Contribuição e estado da arte (Seção 1)

Remover o parágrafo "A contribuição é um caso finito certificado…" e o parágrafo "A distinção entre busca e certificado é útil aqui…". Inserir:

> Our contribution is twofold. First, we reduce bentness in the full 43-dimensional quartic cyclic space to three explicit 36-dimensional affine families using four ingredients: a weight-divisibility filter, three linear consequences, a period-4 autocorrelation argument, and an algebraic identity excluding one case. Second, we certify the finite refutation in Lean, so that coverage of all 2^43 coefficient choices rests on a checked soundness theorem rather than on a reported search.

Acrescentar uma **tabela "casos conhecidos da conjectura"** (n, grau, resultado, referência) imediatamente antes. Regras:
- Preencher **somente** com o que os textos de Stănică–Maitra, Meng–Chen–Fu, Sun et al. (e outros achados) realmente provam. Não preencher de memória.
- Se H(12,4) já constar como resolvido em algum trabalho, parar e avisar o autor: muda o posicionamento inteiro.
- Reordenar a introdução: problema e conjectura → o que já se sabe (tabela) → resultado → visão do método → roteiro. O parágrafo PKP/Tang vem depois, como contraste de hipóteses.
- Mover a autocitação do Figshare (grau ≤ 3) para rodapé, como preprint.

## Mudança 3 — Base de confiança (Apêndice C, nova subseção "What the Lean theorem says")

Imprimir as definições Lean de `H12.quarticFunction`, `H12Descent.BentAC`, `H12Walsh.walsh` (e `sign`, `character` se necessário). Explicar em português claro, em 3–4 frases: coordenada i = bit i do `Nat`; como o `BitVec 43` indexa as órbitas na ordem do Apêndice A; que a auditoria `ARTICLE_TRANSCRIPTION_AUDIT` compara a tabela do Apêndice A com a definição Lean. Dizer explicitamente que a Prop. 2.1 (a base é completa) é prova humana e que o Lean não prova um teorema de representação para ANFs arbitrárias.
Impacto: nenhum (só cita o que existe). Colar as definições exatamente como estão nas fontes.

## Mudança 4 — Seção 4 autocontida

- Definir: estado = (E, ambiente), com E substituição afim sobre z ∈ F2^36; "raiz" = estado inicial com E = identidade; "observação" = vetor de coeficientes φ_k(E(z)).
- Em Eliminação e Bifurcação: "onde a é afim **e não envolve z_i**".
- Tabela de tamanho do certificado por raiz Lean (nós, folhas, profundidade de bifurcação, entradas de tabelas terminais). Dados vêm dos registros Lean (`run39520500414_attempt2_integration_report.json`); não calcular por palpite. Linha separada para o checker Python de 4 raízes (67.658 nós; 164.288 vetores), com aviso de não somar.
- Um exemplo curto de cada regra (já existe o de eliminação; manter).

## Mudança 5 — Lemas

- **Lema 3.3:** trocar "testado… verificado" por tabela de 16 linhas: tupla, direção u, valor de C_g(u) mod 3. Quatro linhas sobrevivem: códigos 2, 3, 8, 15 (tabelas-verdade 0x6ca0, 0x7ee8, 0x8000, 0x9668). Gerar a tabela com um script e conferir contra o texto.
- **Lema 3.1 / Prop. 3.5:** frase sobre invariância do peso por órbita de S.
- **Lema 3.2 / Ap. B:** derivar R2 = Q42 à mão (c26 + c40 + c42) como exemplo; uma frase sobre a origem dos produtos.
- **Notação:** renomear o polinômio cúbico `C(y)` de (3.4) (sugestão: `E3`, ou renomear a autocorrelação para `\Delta_f`). Propagar em todo o texto.
- **Remark opcional após o Lema 3.1:** só o segundo bit do peso é usado; a paridade daria uma condição linear a mais, necessária mas dispensável aqui.

## Mudança 6 — Reorganização

- Tirar caminhos de arquivo e nomes Lean da prova (Seções 3 e 5); deixar referência "see Appendix C".
- Nova seção curta "Data availability" (links, DOI do depósito, commit fixo). Manter hashes completos no Apêndice C.
- Seção 6: trabalho futuro específico (o que falta para n=16, ou para grau ≤ 4 não homogêneo). Opcional: um parágrafo dizendo se o método estende, se o autor souber.

## Mudança 7 — Detalhes

- Datas: harmonizar "21 de outubro" com `2026_10_20_final_integration` ou explicar (fuso).
- Declaração de IA: manter o texto aprovado; atualizar se qualquer texto ou revisão de outra IA for incorporado. Não reduzir a "auxílio gramatical".
- Tempo do checker: manter "observado em uma máquina", sem promessa. (Observado: ~139 s no pacote; 101 s na minha máquina.)

## O que NÃO mudar

- Escopo (H(12,4), nada além).
- Enunciado do Teorema 1.1 e da forma Lean `no_bent_quartic`.
- Texto aprovado da declaração de IA, salvo atualização por novas ferramentas.
- Não alegar "primeira prova" nem "conjectura resolvida" sem restrição a H(12,4).
