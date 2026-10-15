# Auditoria independente dos novos resultados A100

Dados examinados: commit `b04d6366a3cccede346b9f4005f495bff9871817`, branch
`colab-a100-2026-10-06`. Integração do manuscrito examinada: commit
`6951e4f760d78443a09c4db4caa8160d13c74e24`.

| Resultado | O que foi conferido independentemente nesta auditoria |
|---|---|
| Quárticas homogêneas RS em n=10 | Repetida a enumeração inteira de 2^22 = 4.194.304 combinações em CPU, com aritmética inteira e reconstrução própria das órbitas. O filtro da derivada deixa 1.148.928 combinações; nenhuma tem espectro bent. |
| Grau até três RS em n=14 | Regeneradas as 33 órbitas e os espectros dos 25.176 IDs positivos publicados. Todos têm Walsh ±128 e termo antipodal. São 56 representantes quadráticos e 25.120 de grau três exato. Hashes da fonte e do arquivo de IDs conferem. |
| Quínticas homogêneas RS em n=16 | Regenerada a base de 273 órbitas; seu hash confere. O repositório publica somente `summary_stage3.json`, sem os candidatos, os arquivos por rodada ou as testemunhas das fibras. As exclusões individuais não foram verificadas. |

## Alcance da varredura n=14

O relatório registra `complete: false`: foram percorridos os IDs
`0 ≤ id < 500006912`, de um total de `8589934592` (5,8208466%).
A escolha é um prefixo determinístico. As quatro últimas órbitas cúbicas,
com representantes `(0,3,9)`, `(0,3,10)`, `(0,4,8)` e `(0,4,9)`, têm coeficiente
zero em todo esse prefixo. Portanto, ele não equivale a uma amostra aleatória
nem a uma classificação completa em dimensão 14.

Todos os IDs positivos foram reavaliados. A ausência de outros IDs bent dentro
desse prefixo de 500 milhões não foi repetida integralmente nesta CPU.

## Alcance da campanha n=16

O resumo informa 204.800 avaliações em 100 rodadas. O código da campanha é
adaptativo e permite repetições; esse número conta avaliações, não funções
distintas certificadas. Para auditar as exclusões, devem ser preservados o
`summary.json` original, o checkpoint com configuração/seed e os arquivos
`round_*.npz` contendo coeficientes, pesos das fibras e pesos da derivada.
O arquivo resumido publicado não substitui esses dados.

## Correções documentais e de integridade

No manifesto de `6951e4f`, 15 de 17 hashes não correspondiam aos bytes dos
arquivos armazenados em Git. Todos os 15 correspondiam exatamente aos mesmos
textos com finais de linha CRLF (Windows). A diferença é de normalização de
linhas, sem evidência de alteração dos teoremas Lean. O arquivo
`manifest_before.json` registra a comparação completa.

Nesta branch o manifesto foi recalculado sobre os bytes publicados, sem BOM,
e `.gitattributes` fixa LF para os textos dessa publicação. O PDF é binário.
A fonte Lean concreta mantém SHA-256
`ff6284e2756dfaac7f240c8d0d43bc765bfc9f308262e1aa8f8c66b6b66413cd`.

O filtro do código é o balanço da derivada na direção J de todos os bits,
`D_J f(x) = f(x + J) + f(x)`. A expansão “Dickson–Jardine” acrescentada ao
relatório não é a definição usada no código e foi removida nesta branch.

O PDF do preprint continua sendo o da publicação original `fadc947`; os novos
parágrafos computacionais foram acrescentados apenas ao `.tex`. A presente
auditoria preserva o PDF histórico e registra essa diferença explicitamente.

## Reproduzir

Requer Python 3 e NumPy, sem GPU. Na raiz deste repositório:

```sh
git fetch origin colab-a100-2026-10-06
OPENBLAS_NUM_THREADS=1 python audits/a100-2026-10-14/verify.py
cd publications/v1-audited-2026-10-14
sha256sum -c SHA256SUMS.txt
```

O verificador lê a fonte, os resultados e os IDs diretamente do commit fixado,
reconstrói suas próprias tabelas de verdade e usa Walsh inteiro. Não executa
o programa CUDA recebido. Veja `independent_results.json` para o resultado.

## Relação com Lean

A pasta `formalization/` preserva, byte por byte, o núcleo de 52 resultados já
compilados e auditados na branch `formal/antipodal-fiber-core-2026-10-14`.
Os novos controles computacionais não são provas Lean. Continuam pendentes a
redução de ordem ímpar, a rigidez quadrática e o dobramento das órbitas para
concluir a formalização global. Nenhuma classificação quíntica ou prova
uniforme em todas as dimensões é atribuída a essas varreduras.
