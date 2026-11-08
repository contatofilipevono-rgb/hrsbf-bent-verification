# Caderno de ferramentas — encerramento de 7 de novembro de 2026

Caderno em Markdown e PDF, técnicas 1–32, com incorporação seletiva de material auditado. Q1 geral, p=17 e o Lema L geral permanecem abertos. Não há alegação de prioridade nem revisão humana por pares.

## Resultado decisivo do Astra

O Teorema 4.2 do Argon foi REFUTADO: há uma parte quártica em S_span com G8 válido e G7 insolúvel. O contraexemplo tem 24 monômios em dez variáveis. Nove equações somam 0=1, cobrindo todas as 120 incógnitas cúbicas. Leia ASTRA_REPARO_GRAU7_SSPAN_07NOV.md. Codex reconstruiu o exemplo e conferiu o certificado e Möbius por código próprio.

Para verificar sem solver: `python astra_verifica_independente_g7_07nov.py` e `python checa_contraexemplo_astra_g7.py`.

## Catálogo finito adicional

Codex catalogou exatamente 6.561 deslocamentos coordenados ou nulos de um núcleo/resíduo fixo: 6.201 são solúveis em G7 e 360 são insolúveis. Todos os objetos são distintos e têm testemunha ou certificado. Isso NÃO declara 6.201 funções I6, nem cobre outros núcleos ou todas as formas lineares.

Replay completo, sem solver: `python catalogo_deslocamentos_g7_07nov.py`. Arquivo comprimido CATALOGO_DESLOCAMENTOS_G7_07NOV.json.zlib; saída CATALOGO_DESLOCAMENTOS_G7_07NOV_RESUMO.json.

A missão preparada para o Argon está em MISSAO_ARGON_DESLOCAMENTOS_G7_07NOV.md: verificar o catálogo por código independente e investigar um critério corrigido. Não reutilizar o enunciado refutado.

## Materiais preservados e limites

As técnicas 31–32 conservam as equações por uniões de monômios, a redução condicional por hiperplano e os certificados com domínio explícito. PARECER_CODEX_ARGON_DUAS_FORMAS_07NOV.md registra os erros e uma completação positiva I6 em 43.180 flats, que impede extrapolar o certificado restrito.

A nota ASTRA_AUDITORIA_A_MAIS_POSTO8_07NOV.md contém provas locais de suporte pequeno e separa a barreira restante: a classificação alegada de 101 exceções K e o fechamento A+ geral continuam sem validação completa. Não tratar o caso de duas formas lineares como fechado por esta auditoria.

O pacote congelado fechamento_produto_cubico_07nov continua sendo prova candidata da família produto sob I6. Reprodução: `cd fechamento_produto_cubico_07nov` e `python verificar_tudo.py` (Python e NumPy). Não foi alterado.

Créditos: autores clássicos conforme caderno; Opus pelos lemas de níveis/absorção e propostas de extensão; Argon pelas equações e certificados sujeitos às correções; Astra pelo contraexemplo G7 e argumentos de suporte; Codex pela coordenação, controles independentes, catálogo e outras contribuições identificadas. Publicação dos arquivos não equivale a publicação científica.

Sessão encerrada a pedido do usuário. Não iniciar nova janela nem continuar automaticamente.
