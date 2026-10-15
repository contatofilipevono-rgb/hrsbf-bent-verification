# Antipodal necessity — Lean-certified preprint v1.3

**Filipe Martins Vono · 15 October 2026**

[Read the revised paper (PDF)](paper/antipodal_necessity_v1_3.pdf) · [LaTeX source](paper/antipodal_necessity_v1_3.tex) · [Resposta às auditorias (PT)](AUDIT_RESPONSE_PT.md) · [Comparação bibliográfica](LITERATURE_COMPARISON.md)

## Resultado e alcance

Para todo H>0, toda função bent simétrica pela rotação cíclica de uma posição, em 2H variáveis e de grau algébrico no máximo três, tem coeficiente antipodal de ANF igual a 1. Permitem-se termos lineares e constantes. Consequentemente não existe função bent homogênea cúbica simétrica por rotação em nenhuma dimensão par positiva.

A conclusão é o **caso cúbico**, não todos os graus maiores que dois. Certificação formal, novidade e revisão por pares são questões distintas. Esta é uma revisão pública para avaliação; não houve submissão acadêmica nem aceitação por periódico.

## O que mudou desde a versão 1.2

- Prova universal agora segue a rota Lean: redução de ordem ímpar, cancelamento sob meia-volta e transporte da constância à diagonal da restrição.
- Removida da cadeia principal a identidade geral de coeficientes por folding. Sua formalização separada continua ausente e é dispensável para os dois objetivos.
- Atualizado o status formal, com mapa entre os passos matemáticos e os módulos Lean.
- Incluída referência completa a Deng Tang e comparação com Sun–Shi–Liu–Fu, sem reabrir por engano a pendência de obtenção/leitura anterior do artigo de Sun.
- Separadas as evidências das duas revisões recebidas; corrigida a descrição do diff entre os dois CIs.
- Preservados byte a byte todos os fontes Lean e manuscritos históricos em relação à base desta branch. Apenas o índice raiz ganhou uma indicação da revisão atual.

## Versões imutáveis e certificação

| Objeto | Referência |
|---|---|
| Base exata desta revisão editorial | `6f9f66c2e6bba001490e5245f6eb039158a37ffa` |
| Fonte Lean certificado (inclui interface Walsh absoluta) | `6dd183685ef8a5b033c1bcf8733496d57b853cc7` |
| Prova universal central | `formalization/Antipodal/GlobalAntipodal.lean` |
| Lean | 4.15.0, release commit `11651562caae` |
| Mathlib | `9837ca9d65d9de6fad1ef4381750ca688774e608` |
| CI do núcleo universal | [38682075049](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682075049), SHA `9f186bc871361b263a9356a8d80cbcc837db21de` |
| CI da interface completa | [38682481132](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682481132), SHA `6dd183685ef8a5b033c1bcf8733496d57b853cc7` |
| Dependências lógicas dos seis teoremas finais | `propext`, `Classical.choice`, `Quot.sound` |

Esta passagem editorial não executa um novo build Lean nem altera os fontes testados. O verificador da release compara `formalization/` e o workflow Lean ao SHA certificado. O workflow novo verifica a publicação e recompila o artigo; não é um novo certificado Lean.

## Reproduzir

No diretório raiz do repositório:

```bash
python3 publications/v1-lean-certified-2026-10-15/checks/verify_release.py
latexmk -pdf -interaction=nonstopmode -halt-on-error \
  -outdir=/tmp/antipodal-paper-build \
  publications/v1-lean-certified-2026-10-15/paper/antipodal_necessity_v1_3.tex
```

Pacotes LaTeX usados: `amsmath`, `amssymb`, `amsthm`, `booktabs`, `longtable`, `array`, `geometry`, `lmodern`, `hyperref`, `xurl`. O manifesto usa caminhos relativos **a esta pasta**, não à raiz do repositório.

Para reproduzir o kernel, use o toolchain fixado e, em `formalization/`:

```bash
lake exe cache get
lake build
lake env lean ../publications/v1-lean-certified-2026-10-15/checks/AuditSignatures.lean
```

O arquivo de inspeção suplementa a ausência de um `#print axioms` explícito para `_2h` no `CheckGlobal.lean` histórico. As listas recebidas dos seis teoremas estão em `audit/final_axioms_received.json` e os logs originais no ZIP.

## Revisão recebida e validação atual

O parecer anexado e o ZIP foram arquivados sem alterações em `audit/`. Seu manifesto interno tem 42 entradas, todas verificadas. Não confundir com as 60 entradas do manifesto da missão global anterior.

`VALIDATION.json` registra o que foi efetivamente reexecutado nesta revisão editorial. Os programas C++ e Python do ZIP foram inspecionados e reexecutados; não foram escritos nesta passagem e sua execução adicional não constitui uma terceira auditoria independente.

A cópia histórica da comparação com Sun preserva referências ao antigo estado parcial de n=32; `LITERATURE_COMPARISON.md` explica que o estado atual já é universal. PDFs de terceiros sujeitos a assinatura não foram redistribuídos.
