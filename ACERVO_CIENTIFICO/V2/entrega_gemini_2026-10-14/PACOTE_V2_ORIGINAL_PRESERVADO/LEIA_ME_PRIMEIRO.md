# V2 — Pacote para Gemini (14/10/2026)

**Escopo:** exclusivamente V2. Não altera V1 nem V3-C.

## Uso

1. Anexe este ZIP ao Gemini. Cole `PROMPT_GEMINI_V2.md` na mensagem.
2. **Para acesso ao manuscrito original e aos 12 arquivos GitHub exatos, anexe também o snapshot** disponível no link e SHA indicados em `FONTES_GITHUB_PINNED.md`. O link do ZIP do GitHub é: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/archive/16309c4e692cf37427c189baf8e9050b64e85052.zip
3. Alternativamente execute `python SCRIPTS/baixar_snapshot_v2.py` num computador com Internet para baixar **apenas** os 12 arquivos V2 listados e verificar suas hashes Git. Este script de download não pôde ser executado neste ambiente offline.

## O que o presente ZIP contém

- `PROMPT_GEMINI_V2.md`: prompt mestre para auditoria matemática adversarial e descoberta original.
- `AUDITORIA_PREVIA`: parecer e adendo da investigação V2.
- `CERTIFICADOS_LOCAIS`: Python de verificação de contração, bentness e grupo da semente, além de log histórico.
- `GITHUB_AUDITORIA/contagem_ea_quadraticas.py`: cópia exata verificada de arquivo da branch GitHub, blob SHA-1 `db7893565f3f0769f3bee721d283e2d2ed48cda4`.
- `FONTES_GITHUB_PINNED.md`, `GITHUB_V2_MANIFEST.json`: inventário GitHub dos arquivos completos e respectivos hashes e links.
- `RESUMOS/STATUS_MATEMATICO_V2.md`: mapa crítico do que foi auditado ou permanece condicional.
- `SHA256SUMS.txt`: SHA-256 de todo o material incluído.

Este ZIP **não contém o texto integral do repositório**. Para trabalho 100% offline sobre a versão original, use os dois ZIPs.

## Estado científico

A enumeração de simetrias locais da semente (`Aut(phi)=1920` e grupo de grau <=2 de ordem 40) foi reproduzida por execução local. O script de Burnside foi executado e seus testes para r=2,...,6 passaram. O teorema de ultra-rigidez global ainda requer revisão independente; as contagens EA condicionam-se à validade dessa prova. Não há alegação de formalização Lean 4 integral ou originalidade bibliográfica verificada.

## GitHub

Repositório `contatofilipevono-rgb/hrsbf-bent-verification`, PR #4 de auditoria V2 aberto em **rascunho** na consulta realizada nesta sessão. `head=16309c4e692cf37427c189baf8e9050b64e85052`, `base=1a921c586903f4adf6cdb9c8668e7813f10512cb`.
