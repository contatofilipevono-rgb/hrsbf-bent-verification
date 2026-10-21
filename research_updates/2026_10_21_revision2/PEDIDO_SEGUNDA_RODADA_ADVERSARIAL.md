# Segunda rodada adversarial — artigo, prova e submissão

Você recebe uma revisão após um parecer anterior, não uma versão já aprovada. Leia primeiro o artigo revisado sem usar os relatórios PASS como premissa de correção. Depois confronte RESPOSTAS_AO_PARECER.md com o parecer original na pasta parecer_recebido. O objetivo é decidir se cada crítica foi resolvida, se uma discordância da resposta é válida e se as mudanças introduziram erros.

## Prioridades obrigatórias desta rodada

1. A3: confira a semântica E∘T e a prova de soundness mesmo quando a expressão afim contém o pivô. O Lean geral não impõe independência. Examine também a auditoria dos casos concretos, que encontrou zero violações. Não acrescente uma hipótese inexistente sem necessidade.
2. A9: confira a afirmação de paridade automática dos pesos sobre oito coordenadas para monômios quárticos (peso 16). Decida se há de fato uma nova condição linear ou se ela é tautológica neste espaço.
3. Compare as definições exatas e todos os 43 índices com a base do Apêndice A. A auditoria nova compara diretamente os fontes certificados, e não apenas o Markdown consigo próprio. Distinguir prova humana de completude ANF e teorema Lean concreto.
4. Refaça a tabela dos 16 casos, a derivação Q42 e as parametrizações; procure erros na nova notação E_3. Confira contagens de nós/folhas e o sentido de contagem com multiplicidade.
5. Literatura: verifique a tabela de resultados selecionados contra as fontes primárias e examine o limite declarado na recuperação do PDF original de Meng. Não conclua prioridade absoluta por uma busca negativa. Se encontrar um teorema anterior que exclua H(12,4) inteiro, cite-o e compare hipóteses antes de recomendar mudança de título ou mérito.
6. A versão usa 169 palavras no resumo, atendendo ao intervalo 150–250 informado por DCC. Não recomendar um limite conflitante sem verificar as diretrizes atuais.
7. Confira a comparação com V1 público v2 e se a separação editorial é defensável, considerando os textos completos e não só os títulos. O V1 de referência é incluído; não o trate como submetido a revista.
8. Reavalie a carta, dados de submissão, IA e checklist. Claude foi acrescentado à declaração pela revisão incorporada. Financiamento/interesses e aprovação final continuam pendentes; o DOI público do depósito ainda não existe. Não preencher nenhum fato por palpite.
9. Avalie a leitura humana dos PDFs e do template Springer. O template é um rascunho compilado, não uma conversão aprovada pelo portal ou uma submissão completa.

## Material e método

- H12_preprint.md e H12_quartic_revised_round2.pdf: texto atual.
- dcc_template: fonte e PDF no template oficial Springer; ler seus limites no README.
- certificados e registros: os mesmos da prova original, com hashes preservados; não repetir Lean pesado por rotina.
- FORMAL_DEFINITIONS_EXACT.md, CERTIFICATE_SIZE_AND_ENCODING_AUDIT.json, R2_RESTRICTED_WEIGHT_EXAMPLE.json, PERIODIC_CLASSIFICATION_16_CASES.json e V1_H12_COMPARISON.json: verificações específicas, produzidas nesta preparação, sem autoridade de revisão independente.
- materiais_submissao: documentos atuais; versões anteriores ficam na pasta historico.

Separe o parecer em (A) matemática/certificação, (B) escrita/interesse científico e (C) prontidão de documentos. Para cada achado use gravidade, arquivo/trecho, derivação ou evidência e correção mínima. Faça uma tabela com os 25 itens do parecer anterior e marque resolvido, parcialmente resolvido, resposta incorreta ou não verificado. Liste os novos achados separadamente.

Entregue um veredito fundamentado, os trechos reescritos e as pendências factuais. Não dê porcentagem ou nota de chance de aceitação. Diga o que realmente executou, o que só leu e o que não conseguiu examinar. Não simule reconstrução Lean, leitura bibliográfica ou revisão humana que não realizou. Não publique o Figshare nem envie nada à revista.
