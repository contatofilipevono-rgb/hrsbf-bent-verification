# Pedido de análise adversarial — H(12,4)

Atue como parecerista de um periódico de funções booleanas, códigos e criptografia, com atenção a provas assistidas por computador. Faça uma revisão crítica do manuscrito, da exposição e da relação entre os certificados e o enunciado. Não presuma correção porque o texto menciona Lean ou porque há logs com status PASS.

## Material

1. `H12_quartic_preprint_v1.pdf`: versão diagramada do artigo.
2. `H12_preprint_source.zip`: fonte LaTeX e Markdown.
3. `H12_independent_verification.zip`: certificado independente e checker Python.
4. `H12_formal_sources.zip`: 2.093 fontes matemáticas Lean, com hashes certificados; fornecido separadamente do pacote essencial por tamanho.
5. `ANALISE_NOVIDADE_POLUJAN_TANG.md` e `LITERATURE_OVERLAP_AUDIT.json`: comparação dirigida com dois trabalhos recentes. São registros da própria pesquisa, não validação externa.

O alvo é inexistência de função bent homogênea quártica simétrica por rotação em doze variáveis. O formal é universal sobre os 43 coeficientes da base concreta. Não há pretensão de resolver dezesseis variáveis, dimensões gerais ou todo grau no máximo quatro.

## Perguntas matemáticas obrigatórias

- A base de órbitas representa exatamente todas as ANFs homogêneas quárticas invariantes por rotação? Há perda de funções ou identificação indevida de coeficientes?
- A equivalência Walsh/autocorrelação tem fatores e normalizações corretos?
- A divisibilidade de pesos restritos implica os filtros como afirmado? A condição de segundo bit é tratada apenas como necessária?
- As identidades lineares do Apêndice B têm a numeração correta? Confira especialmente R2=Q42 e o filtro de máscara 0x3cf=975, Q30.
- A congruência módulo três usa o conjunto correto de pontos fixos? A classificação de dezesseis funções em quatro casos é completa?
- A identidade que elimina o código 15 é válida? As outras três famílias e a parametrização realmente cobrem todas as bent hipotéticas?
- A semântica dos estados justifica eliminação, bifurcação e rejeição terminal? O suporte ativo garante que o terminal cobre todas as observações possíveis?
- A propriedade aceita para cada raiz é suficiente para a conclusão universal sem hipóteses ocultas de filtros ou refutações ainda não instanciadas?

## Perguntas editoriais obrigatórias

- O resumo informa resultado, método e escopo sem exagero?
- A introdução mostra contribuição suficiente para um periódico como Designs, Codes and Cryptography, ou o resultado parece apenas uma verificação de um caso pequeno? Dê o argumento editorial mais forte contra a aceitação.
- O texto separa adequadamente prova humana, certificado finito, prova Lean e registros de auditoria?
- Há informação operacional excessiva ou alguma informação essencial relegada ao suplemento?
- Um leitor consegue seguir a cadeia de lemas sem procurar definições em arquivos de código?
- A discussão bibliográfica diferencia funções de grau quatro de funções homogêneas quárticas e distingue construções fora de M# de teoremas de inexistência?
- As afirmações sobre Polujan–Kudin–Pasalic (DOI 10.1109/TIT.2026.3685133) e Tang (ePrint 2026/1799) refletem as hipóteses corretas? Identifique sobreposição efetiva se existir, sem inferir homogeneidade a partir apenas de grau.
- Quais parágrafos deveriam ser reescritos, encurtados ou movidos? Proponha substituições concretas.

## Reprodução

No suplemento independente, use Python padrão, sem `-O`:

```text
python verify.py
```

O resultado esperado é `PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS`, com 164.288 vetores nas folhas verificados. Essa é uma implementação de quatro raízes, distinta das três raízes Lean. O tempo observado na preparação foi cerca de 139 segundos; a máquina de revisão pode diferir. O teste não deve ser descrito como uma nova certificação pelo kernel.

Não inicie uma reconstrução pesada do Lean sem antes avaliar se ela é necessária. O pacote formal contém a versão da ferramenta e os comandos; sua configuração Lake mínima teve imports auditados, mas não foi reconstruída integralmente nesta preparação. A verificação kernel original consta das evidências. Confirme os axiomas efetivos dos teoremas finais se examinar a formalização.

## Formato do parecer

1. Resumo fiel da contribuição em até 150 palavras.
2. Veredito: rejeitar, revisão substancial, revisão menor ou pronto para submissão; justifique. Não estime uma probabilidade numérica de aceitação.
3. Achados classificados como críticos, maiores, menores ou editoriais. Para cada um, indique seção/proposição/frase, explique o problema com derivação ou exemplo e proponha a menor correção suficiente.
4. Liste separadamente o que foi conferido, o que apenas parece plausível e o que depende de fontes ou arquivos não examinados.
5. Avaliação específica de novidade e comparação com trabalhos anteriores; ausência de um resultado na busca não prova prioridade.
6. Reescrita dos trechos de apresentação que mais prejudicam o artigo.
7. Lista objetiva de condições para uma versão revisada aceitável.

Não acrescente elogios genéricos. Não invente uma contradição para parecer adversarial. Não converta o número de módulos em cobertura percentual ou prova de originalidade. Não aceite os relatos desta conversa como autoridade independente. A finalidade é encontrar falhas reais e melhorar a apresentação sem alterar indevidamente o alcance demonstrado.
