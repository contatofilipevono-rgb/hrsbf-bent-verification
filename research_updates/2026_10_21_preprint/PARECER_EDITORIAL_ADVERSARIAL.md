# Parecer adversarial sobre a apresentação do artigo H(12,4)

Este é um parecer simulado produzido nesta conversa, não um parecer independente de revista. Analisa a primeira redação e registra as correções da versão entregue. O diagnóstico inicial seria **revisão substancial antes da submissão**, principalmente por apresentação e documentação. Isso não é uma alegação de erro no teorema certificado.

## Objeção central de um avaliador

“O artigo resolve um caso finito por computação. Qual é exatamente a contribuição além de uma busca exaustiva, e como posso conferir que as condições necessárias cobrem todo o domínio?”

A versão revisada responde com uma cadeia explícita: base completa de 43 órbitas; filtros necessários; relações lineares certificadas; quatro casos periódicos, um excluído por identidade; três famílias afins; semântica e correção das refutações; aceitação das três instâncias concretas; contradição final. A novidade não é atribuída aos mecanismos clássicos de Fourier ou ao simples uso do Lean.

## Problemas maiores e tratamento

| Objeção | Efeito sobre a avaliação | Correção aplicada |
|---|---|---|
| Interesse do caso finito pouco explicado | O texto poderia parecer apenas relatório de execução | Introdução delimita o resultado completo em H(12,4), a redução explícita e a separação entre descoberta e verificação |
| Relação com resultados construtivos recentes ausente | Um leitor poderia confundir a conclusão com inexistência de bent RS de grau elevado | Incluída discussão de Polujan–Kudin–Pasalic e do preprint de Tang, com parâmetros conferidos |
| Filtros poderiam parecer uma caracterização de bentness | Risco de interpretação matemática indevida | Texto diz expressamente que são apenas necessários; terminais exigem rejeição espectral |
| Relações lineares afirmadas por referência a arquivo | Conferência humana difícil | Apêndice B contém a ordem dos filtros e todos os 22/1/24 produtos |
| Significado de refutação descrito só verbalmente | Dificulta avaliar a ponte do certificado ao teorema | Inserida a propriedade quantificada que cada estado refutado estabelece |
| Proposição computacional sem acesso simples aos dados | Dependência excessiva da confiança no relato | Suplemento compacto, verificador e arquivo completo de fontes com hashes certificados |
| Módulos, logs e hashes interrompiam a demonstração | O texto parecia registro de engenharia | Detalhes operacionais movidos ao Apêndice C; corpo preserva a composição lógica |
| Confusão entre quatro raízes Python e três Lean | Contagens poderiam ser usadas de maneira incompatível | Separação explícita no artigo, no suplemento e no pedido de revisão |
| Identificação entre função concreta e H(12,4) pouco visível | Um teorema formal poderia provar uma família menor | Proposição 2.1 e Apêndice A demonstram cobertura dos 495 suportes |
| Tempo de revisão confundido com tempo de reconstrução | Promessa de reprodução irrealista | Informados tempo observado do checker e custo distinto de reconstrução Lean |

## Pontos menores corrigidos

- Referência fundadora de Rothaus acrescentada e citações numéricas reorganizadas.
- Notação com índices zero based e ordem independente dos filtros explicitada.
- Homogeneidade distinguida de grau máximo, inclusive diante de mudanças de coordenadas.
- Exemplo de eliminação mantido para ilustrar a diferença entre deduzir uma igualdade e bifurcar exaustivamente.
- Aritmética de Walsh identificada como exata.
- Declaração de IA mantida no texto aprovado, sem linguagem que atribua toda a autoria à ferramenta.
- Corrigidos caracteres, URLs, quebras de equações e largura da tabela de reprodução no PDF.

## O que este parecer não pode resolver por redação

1. **Prioridade absoluta.** A comparação dirigida não é uma revisão exaustiva de toda a literatura. A versão entregue não anuncia “primeira prova” nem originalidade dos lemas clássicos.
2. **Interesse editorial.** O editor pode considerar o caso finito insuficiente para o periódico. Certificação e boa escrita tornam a contribuição avaliável, mas não eliminam esse julgamento.
3. **Revisão humana externa.** O texto ainda deve ser confrontado por um leitor que não participou desta conversa.
4. **Declarações de submissão.** Financiamento, conflitos e contribuições precisam ser confirmados para o formulário da revista. Nenhuma ausência foi inventada.
5. **Empacotamento Lake.** As 2.093 fontes são exatas e os imports foram auditados; não foi executada uma nova reconstrução integral do arquivo mínimo de distribuição. Esse limite está declarado.

## Veredito da rodada final

O manuscrito revisado está preparado para **análise adversarial externa como preprint completo**. Não há, nesta leitura, uma objeção crítica identificada e deixada sem resposta que autorize afirmar que a prova é inválida. Isso não equivale a endosso independente de correção, prioridade ou aceitação. A maior questão editorial restante é a avaliação do alcance científico do caso finito, e não a quantidade de páginas de Lean.

Não recomendo enviar à revista antes dessa leitura externa e da confirmação das declarações de submissão. O rascunho no Figshare deve ser distinguido de uma publicação efetivamente concluída, e o preprint deve continuar identificado como não avaliado por pares.
