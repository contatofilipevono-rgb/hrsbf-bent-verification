# Pesquisa separada: famílias de parâmetro polar de peso três em n=32

A branch pesquisa-t32-2026-10-04 é separada da versão de submissão. Nenhum resultado deste lote foi incorporado ao artigo consolidado.

## Resultado inicial

Foram examinados todos os 6.545 parâmetros h de peso três do espaço polar de dimensão 35, com 119 direções de fibra determinísticas.

- 5.878 parâmetros tiveram famílias inteiras excluídas por contradição linear.
- 667 parâmetros permaneceram sem decisão por estas condições.
- O controle conhecido h=1 também foi excluído.
- Os 5.879 certificados, incluindo o controle, foram reconstruídos em uma segunda execução sem repetir a busca por eliminação.
- Cada família tem dimensão 120 nos 155 coeficientes originais.
- Não foi encontrada nem certificada uma função bent.
- Não se afirma resolução de todo n=32 nem novidade global em relação à literatura.

A busca usa as formas coeficientes das fibras reconstruídas diretamente pela ferramenta exata já validada. Para cada direção, verifica que a polar depende somente de h, que as quatro elevações compartilham cada coeficiente e que as quinze órbitas antipodais não contribuem para a polar. Com h fixado, fibras de posto 14 têm radical de dimensão dois, uma direção anulada pela meia-rotação e uma avaliação restante que deve ser um. As equações dessa avaliação são combinadas com as 35 equações que fixam h. Cada contradição é explicitamente verificada por XOR.

A execução de conferência reconstrói os coeficientes e as hipóteses de posto/radical de cada certificado. Ela reutiliza a implementação de expansão das fibras; não é uma implementação independente nem revisão humana. Os controles diferenciais anteriores com a ANF original sustentam essa implementação.

## Reprodução

Na raiz do repositório:

    python pesquisa_t32/triagem_familias_t32.py --limit 6545 --output pesquisa_t32/triagem_t32_peso3.json
    python pesquisa_t32/triagem_familias_t32.py --check-only pesquisa_t32/triagem_t32_peso3.json --output pesquisa_t32/triagem_t32_peso3_verificada.json

O JSON integral de certificados tem aproximadamente 26,7 MB e está no pacote entregue ao autor; o repositório contém script, resumo, lista dos parâmetros sem decisão e registro de conferência. O script reproduz o arquivo integral. O SHA-256 do arquivo registrado está no resumo; tempos de execução podem variar e alteram os bytes do relatório.

O parâmetro h é a projeção que determina as polares, não a restrição direta f(u,u), que é identicamente zero. Seus rótulos são fixados pelos representantes canônicos de órbitas cúbicas em 16 variáveis. As famílias são disjuntas e cobrem o estrato de peso três desse parâmetro, não todo o espaço de 155 coeficientes.

## Próximos problemas concretos

1. Ampliar as direções de fibra nos 667 parâmetros sem decisão, preservando certificados verificáveis.
2. Incorporar fibras de posto inferior a 14. Em um h fixado, balanceamento é uma disjunção de avaliações lineares não nulas no radical; não pode ser substituído por uma única equação.
3. Se a triagem linear não bastar, construir uma CNF para cada família de h fixado, codificando corretamente essas disjunções e XORs. Validar a codificação em espaços pequenos antes de alegar uma prova UNSAT.
4. Comparar as famílias excluídas com os critérios de suporte já publicados antes de fazer qualquer alegação de contribuição nova.

Questão de pesquisa: as condições de balanceamento de todas as fibras já tornam impossível cada uma dessas famílias restantes? Isso é uma pergunta a investigar, não um teorema estabelecido ou uma conclusão dos testes atuais.
