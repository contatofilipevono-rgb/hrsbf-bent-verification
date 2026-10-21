# Pedido de análise adversarial integral — artigo e submissão

Atue como pesquisador e editor crítico de Designs, Codes and Cryptography. Examine o artigo e também a carta, a apresentação da contribuição, as declarações propostas, a disponibilidade dos dados, os suplementos e a relação com V1. Seu objetivo é identificar falhas reais e recomendar a menor correção suficiente. Não aceite a certificação relatada como substituto de conferir as definições; não invente uma falha para parecer adversarial.

## Material adicional obrigatório

Na pasta materiais_submissao, leia CARTA_AO_EDITOR_EN.md, RESUMO_E_DADOS_SUBMISSAO.md, DISPONIBILIDADE_DADOS_EN.md, DECLARACOES_PENDENTES.md, RELACAO_V1_H12_E_POSICIONAMENTO.md e CHECKLIST_ENVIO_E_CONTROLE_VERSOES.md. A tradução CARTA_AO_EDITOR_PT.md serve à conferência pelo autor. AUTOCRITICA_MATERIAIS_SUBMISSAO.md é apenas uma autocrítica prévia, não um parecer independente.

## Perguntas adicionais sobre a submissão

1. A carta explica um mérito científico concreto além de verificar um caso finito? Identifique o argumento mais forte para uma rejeição editorial e diga se a carta consegue respondê-lo honestamente.
2. Há exagero, afirmação de prioridade sem base, confusão entre grau e homogeneidade, ou extrapolação do resultado H(12,4)? A comparação com Sun e com construções recentes está fiel às hipóteses?
3. Carta, resumo, artigo, Figshare, dados e suplementos descrevem a mesma versão e o mesmo enunciado? A afirmação de que a prova é autossuficiente em relação a V1 corresponde às dependências efetivas?
4. A relação com V1 é suficientemente transparente? Se tiver acesso ao texto completo de V1, procure sobreposição matemática e textual ou divisão editorial inadequada. Se não o tiver, registre essa limitação; não conclua ausência de sobreposição só pelo título.
5. As declarações propostas atribuem responsabilidade corretamente e descrevem o uso de IA de forma fiel, sem desvalorizar o autor nem ocultar assistência? Não sugira declarar auxílio apenas gramatical se os materiais mostram programação e formalização.
6. Há alguma declaração factual ausente apresentada como verdadeira? Financiamento, interesses e estado editorial estão deliberadamente pendentes. Não complete essas lacunas por palpite; diferencie bloqueios antes do envio de falhas matemáticas.
7. A disponibilidade dos dados permite identificar fontes, versões e evidências? Diferencie checker independente, registros de execução, prova original e reconstrução do novo empacotamento. Verifique se o tempo observado foi descrito sem promessa irrealista.
8. Que partes deveriam ser encurtadas ou movidas da carta para o suplemento? Proponha uma carta revisada em inglês, só com fatos sustentados pelos materiais.
9. As exigências da revista estão sendo efetivamente atendidas ou apenas listadas? Consulte as diretrizes oficiais se houver acesso à internet e cite a página exata. Não afirme conformidade completa do layout ou dos formulários ainda não preparados.

## Entrega esperada

Produza três avaliações separadas: (A) matemática/certificação; (B) escrita e mérito editorial; (C) prontidão dos documentos e das declarações. Classifique achados como críticos, maiores, menores ou editoriais e cite o arquivo e trecho. Apresente uma tabela com evidência, consequência e correção mínima. Entregue a reescrita da carta e dos parágrafos que mais prejudicam o conjunto. Liste o que foi realmente verificado e os arquivos/fontes que não examinou.

O veredito pode ser rejeição, revisão substancial, revisão menor ou pronto para submissão; justifique sem estimar porcentagem de aceitação. Não envie nada ao periódico, não publique o rascunho Figshare e não inicie computação pesada por rotina. Modificações do artigo devem ser propostas com controle de versão e indicação de possível impacto na formalização.

## Pedido matemático/editorial detalhado do artigo

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
