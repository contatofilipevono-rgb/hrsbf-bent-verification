# ACERVO CIENTÍFICO — entrada central (14/10/2026)

Este diretório reúne cópias **imutáveis quanto ao conteúdo** de arquivos científicos relevantes das branches originais. Nenhum manuscrito original foi sobrescrito. Um arquivo aqui não é, por si, aprovação científica ou versão de publicação.

## Acesso rápido

- [Artigos e bibliografia](../artigos/README.md) / [Catálogo atualizado](../artigos/CATALOGO_E_DIREITOS_2026-10-14.md)
- [V1 — conjectura HRSBF e resultados de fibras](V1/README.md)
- [V2 — índice relaxado e famílias EA](V2/README.md)
- [V3-C — classificação de digrafos e Lean 4](V3-C/README.md)
- [Proveniência detalhada: caminho original, commit e Git blob](MANIFESTO_ORIGENS.json)
- [Pendências e critérios para publicação](PENDENCIAS_E_PORTOES.md)

## Regra de status

1. **Demonstrado matematicamente:** há argumento completo documentado; continua sujeito a arbitragem científica.
2. **Certificado computacional:** resultados finitos reproduzíveis dependem de código, premissas e ambiente.
3. **Lean reportado/arquivado:** código-fonte e logs na origem; esta consolidação não recompilou Lean.
4. **Em auditoria:** nenhuma afirmação de originalidade ou validade definitiva.
5. **Texto de submissão:** versão editorial, não publicação aceita.

## Instalação Lean

As árvores `V2/lean_snapshot_2026-10-08` e `V3-C/lean` mantêm os nomes internos e os arquivos de ferramenta. Porém são cópias de branches/commits diferentes, **não uma nova validação cruzada**: executar `lake exe cache get` e `lake build` em cada diretório antes de citar recompilação. Não mesclar os dois projetos ou suas premissas.

## O que este acervo NÃO contém

PDFs fechados de editoras (não foram republicados em repositório público), todos os artefatos de conversas anteriores, nem todos os experimentos históricos. Os documentos externos estão indexados com DOI/identificadores; o manifesto marca precisamente o que foi copiado.

**Baseline:** main `226ffe8d240efc90452d225d0746905a5928e867`. **Fontes congeladas:** V1 `db3d5b9f385dc96adf7df3f0a0483d4c611d90e8`, V2 `16309c4e692cf37427c189baf8e9050b64e85052`, V3-C `01ea4b263a3cbe338df264b9d057a4edb3a980c8`.
