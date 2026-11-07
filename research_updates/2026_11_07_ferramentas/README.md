# Caderno de ferramentas — 7 de novembro de 2026

Versão atualizada do caderno, em Markdown e PDF, com técnicas 25–29: liftabilidade e I6/I7; redução de pencils por hiperplanos; emparelhamento cíclico; certificados duais; absorção do resto cúbico.

**Estado: prova candidata, sem auditoria matemática externa e sem prioridade verificada. p=17, Q1 geral e a conjectura geral permanecem abertos.** Não confundir disponibilização dos arquivos com publicação científica ou validação do teorema.

O pacote congelado `fechamento_produto_cubico_07nov` contém a prova candidata para D=Q1Q2 XOR R, deg(Qi)≤2, deg(R)≤3, sob I6, e todos os certificados. Ela afirma que algum dos três postos polares é ≤8 e, portanto, há um flat cúbico de codimensão ≤4. As hipóteses espectrais globais de Astra são uma etapa separada; peso e pico isolados não bastam.

Reprodução: `cd fechamento_produto_cubico_07nov` e `python verificar_tudo.py` (Python 3 e NumPy). Reexecutado em cópia de trabalho em 07/11: treze representantes conferidos por dois métodos, 43 controles de redução, 13 controles de pareamento, 65.536 certificados conferidos sem solver e certificado universal de cinco equações no bloco repetido. Isso verifica as contas finitas; a cobertura e os argumentos escritos continuam sujeitos à auditoria.

Créditos: Opus pelos lemas de níveis e absorção; Astra pela origem espectral; Codex pela redução por hiperplanos, pareamento e certificados desta versão. As ferramentas clássicas continuam atribuídas aos autores citados no caderno.

O panorama anterior permanece como registro histórico. Este diretório acrescenta a evolução posterior e suas ressalvas; não declara resolução de uma nova frente.
