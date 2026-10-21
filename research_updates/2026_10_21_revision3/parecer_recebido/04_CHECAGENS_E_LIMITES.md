# Checagens que a próxima IA deve fazer e limites deste relatório

## O que eu NÃO examinei (não tratar como conferido)

- `H12_formal_sources.zip` (2.093 módulos Lean) e as definições de `quarticFunction`, `BentAC`, `walsh`.
- `H12Descent` (`bent_rotational_descent`), `H12CertificateBridge.terminalCheck_sound`, `H12AffineFastState.leaf_sound`, `refutes_sound` — só as assinaturas citadas no mapa.
- A ligação bit-a-bit entre Apêndice A e o Lean (auditoria `audit_article_transcription.py` e seu JSON não foram reexecutados por mim).
- Relatórios de axiomas: li a descrição, não os arquivos de log.
- Qualquer reconstrução do Lean/Lake (o pacote declara que a configuração mínima não foi reconstruída).
- Literatura: Stănică–Maitra, Meng–Chen–Fu, Sun–Shi–Liu–Fu, Polujan–Kudin–Pasalic, Tang. Não li os PDFs. As hipóteses atribuídas a eles (m ímpar e 3∤m; n=30·7^j e 70t; condições dos Teoremas 1–6 de Sun et al.) estão **não verificadas**.
- Os links do GitHub (commits `1e0e052`, `9be0d98`) e o item Figshare.
- O texto completo de V1.
- A página atual de diretrizes do DCC (só li o que os documentos citam).

## Checagens recomendadas, em ordem

1. **Literatura:** ler as fontes e confirmar se H(12,4) estava aberto. Preencher a tabela de casos conhecidos só com o que está provado. Procurar buscas computacionais anteriores para n=12 (não confiar em minha memória).
2. **Definições Lean:** abrir os fontes e comparar `quarticFunction` com a tabela do Apêndice A, bit a bit; conferir a convenção de índice; conferir `BentAC` e `walsh`.
3. **Axiomas:** abrir os relatórios em `H12_final_kernel_records.zip`; confirmar `propext`, `Classical.choice`, `Quot.sound` e ausência de `sorryAx`/`ofReduceBool` para `no_bent_quartic`, `no_flat_quartic`, `walsh_witness`.
4. **Soundness:** ler `refutes_sound`, `leaf_sound` e `terminalCheck_sound`; confirmar que Eliminação/Bifurcação exigem que `a` não dependa da variável substituída (item A3).
5. **Números do certificado** das 3 raízes Lean para a tabela do item A2.
6. **V1 × H12:** comparação textual completa.
7. **Reconstrução Lean:** não rodar por rotina; decidir só se algum item acima levantar dúvida.

## Reprodução da minha conferência

```
python -I check_h12.py
```

Saída esperada: linhas A–I com `True` (e `G` listando os códigos 2, 3, 8, 15 com as tabelas-verdade 0x6ca0, 0x7ee8, 0x8000, 0x9668). O script reconstrói a base de órbitas do Apêndice A, os filtros pelas máscaras do Apêndice B, as identidades R1–R3 e (3.8), a restrição ao período 4 e a classificação mod 3. Ele **não** substitui o Lean.

Verificador do pacote: `python verify.py` (sem `-O`) → `PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS`, 164.288 vetores, 67.658 nós, 101 s em Windows 11/Python 3.12.

## Limites deste relatório

- Produzido por uma IA, nesta conversa, a pedido do autor. Não é parecer de árbitro externo.
- A nota 4/10 → 6–7/10 é juízo subjetivo, não probabilidade; o pacote original proíbe estimar porcentagem.
- Falta ainda um leitor humano externo para a cadeia de lemas e o Lean. Nenhum desses documentos o substitui.
- Nada foi enviado a periódico, nada foi publicado no Figshare e nenhum arquivo do pacote do autor foi alterado.
