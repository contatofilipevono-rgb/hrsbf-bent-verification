# Plano comum dos momentos de fase em V1 (n = 12, grau 4), sem catálogo

Ponto de partida: commit `e82378b`, `class129/check_v1_common_phase_plane.py`. O plano é
L = ⟨0x084006c00810, 0x106002400c20⟩. O bit 3t+i é o momento da fibra t com multiplicador 1, s₁ ou s₂ (i = 0, 1, 2).

## Resultado

**Teorema (certificado).** Seja um mapa da base do modelo `decode(1)`, em qualquer uma das 256 classes de polar, com estas duas propriedades: tem 16 fibras de 16 pontos, e cada fibra é ortogonal a RM(2,8). Então as colunas das 19 direções de fase nos 48 momentos estão em L.

A prova não lê o catálogo. Ela reconstrói o domínio a partir dos 25 parâmetros de cada classe. O catálogo entra só no fim, como controle de cobertura.

Contagem por classe:

| situação | classes | o que fecha |
|---|---:|---|
| vazia só por ortogonalidade (consequências afins dos momentos booleanos) | 228 | hipótese de ortogonalidade |
| vazia depois de somar as consequências afins do balanceamento (somas de caracteres) | 14 | ortogonalidade e balanceamento |
| plano por identidade de grau 4 no espaço afim | 1 (classe 0) | ortogonalidade e balanceamento afins; não precisa do tamanho exato das fibras |
| plano equivalente a x₂₄ = 0, conferido por enumeração bit a bit | 13 | precisa do tamanho exato das fibras |

## Estrutura do resíduo (identidade de grau 4)

Seja A_κ o espaço afim da classe κ depois das consequências afins de ortogonalidade e balanceamento (nível H4). Sua dimensão vai de 18 a 22.

Cada entrada de coluna é um polinômio de grau ≤ 4 nos parâmetros, porque a indicadora de uma fibra é o produto de quatro fatores afins. A interpolação de Möbius nos pontos de peso ≤ 4 é, portanto, exata. Ela mostra que, em todo A_κ:

  coluna_φ mod L = x₂₄(c) · w_φ,

onde x₂₄ é o bit 24 do código (a última direção baixa de `decode(1)`), e w_φ é o vetor fixo 0x30420102180 para φ ∈ {6, 7, 13}, sendo 0 nas outras 16 fases. O vetor e a forma linear são os mesmos nas 13 classes.

Logo, **o plano equivale a uma única equação linear: x₂₄ = 0 nos mapas admissíveis.** Essa é a sexta equação do envoltório de dimensão 19 da auditoria, `(0x1000000, 0)`. Na classe 0 o fator some, e o plano vale em todo A_0.

## A equação x₂₄ = 0

Ela não sai das consequências lineares. O teste de pertença ao ideal truncado em grau 4 (`ideal.py`) foi rodado na classe 129. Os 43 polinômios de momento booleano não geram x₂₄ nesse grau: dos 24 componentes do resíduo, nenhum está no ideal.

Ela também não sai só da ortogonalidade, o que a relaxação mostra: sem |P_t| = 16, aparecem mapas com x₂₄ = 1 que satisfazem todos os momentos booleanos.

| classe | dim A_κ | admissíveis | sem tamanho: mapas / violações | testemunha (código) |
|---:|---:|---:|---|---:|
| 0 | 21 | 63.504 | — (identidade) | — |
| 1 | 22 | 12.416 | 110.592 / 25.600 | 50333710 |
| 22 | 21 | 2.176 | 63.488 / 6.144 | 763375694 |
| 23 | 21 | 3.072 | 34.816 / 3.072 | 789604370 |
| 36 | 20 | 1.536 | 21.760 / 1.280 | 1233174531 |
| 37 | 20 | 1.152 | 27.904 / 2.816 | 1263554647 |
| 50 | 20 | 1.536 | 21.760 / 1.280 | 1698699379 |
| 51 | 20 | 1.152 | 27.904 / 2.816 | 1732304926 |
| 128 | 20 | 12.832 | 94.208 / 8.192 | 4320137234 |
| 129 | 20 | 11.232 | 90.112 / 9.216 | 4358938703 |
| 164 | 18 | 512 | 11.776 / 512 | 5529151490 |
| 165 | 18 | 704 | 17.920 / 2.560 | 5558528074 |
| 178 | 18 | 512 | 11.776 / 512 | 5992796163 |
| 179 | 18 | 704 | 17.920 / 2.560 | 6036652035 |

Cada testemunha satisfaz todos os momentos de ortogonalidade e tem x₂₄ = 1, portanto uma coluna fora de L. O que ela viola é exatamente |P_t| = 16; os tamanhos das suas fibras estão em `certificate.json`.

Com o tamanho exato, a enumeração bit a bit de cada A_κ (2^18 a 2^22 atribuições, 7 a 20 s por classe numa CPU) dá **0 violações**. O total de admissíveis é **113.040**.

**Controle com o catálogo, feito depois do certificado.** As contagens por classe coincidem com as do catálogo `mapas_V1.txt` (SHA-256 `8d0eeebf…ad7ea`), nas 14 classes e no total.

## Hipóteses usadas em cada certificado

- **Ortogonalidade (H-orth).** Cada produto de coordenadas do rótulo é ortogonal a RM(2,8); o equivalente é a indicadora de cada fibra ter grau ≤ 5. Uso só as consequências afins, iteradas, e no fim os momentos completos na enumeração.
- **Balanceamento (H-bal).** São as consequências afins das somas de caracteres do repositório (`dim4_balance_charts.character_sums` com `affine_consequences`).
- **Tamanho exato (H-size).** |P_t| = 16. Entra só na enumeração das 13 classes, como contador bit a bit.
- **Modelo (H-RS).** A base de mapas e as 19 fases vêm do modelo RS de grau 4 afim ao longo de V (`decode(1)`). O grau ≤ 4 das entradas, que torna a interpolação exata, vem do mapa ser afim nos parâmetros. Não usei as identidades de meia-volta e rotação; a explicação geométrica fica com o Carbon.

| certificado | H-orth | H-bal | H-size | H-RS |
|---|:-:|:-:|:-:|:-:|
| 228 classes vazias | sim | | | sim |
| 14 classes vazias | sim | sim | | sim |
| classe 0, identidade | sim | sim | | sim |
| 13 classes, x₂₄ = 0 | sim | sim | sim | sim |

## x₂₄ = 0 por células, sem enumerar os mapas

O argumento `--hull-only` da classe 129 se estende às 13 classes (`cells_x24.py`). Tome o hiperplano x₂₄ = 1 de A_κ. O quociente ρ = π0 mod ⟨1111⟩ é afim no código, com imagem de dimensão 12 a 16; cada valor de ρ define uma célula afim de dimensão 5. Para cada valor de ρ:

1. **Condições que só dependem de ρ.** São três: |Z_[t]| = 8 (tamanho, no quociente), a·e_t e b·e_t ortogonais a RM(1,6) e |Z_[t] ∩ M| par.
2. **Em cada célula que sobra,** procura-se uma equação de suporte que vale 1 em todos os 32 pontos da célula. Cada equação é um momento booleano da fibra t contra um monômio de RM(2,8).

**Correção (commit 81835f1).** A primeira versão desta tabela aplicava a todas as classes as linhas ativas da classe 129 (a nas linhas {2,4}, b nas linhas {1,4}), então ela estava errada fora da classe 129. Agora as linhas ativas são lidas das derivadas em s de cada classe.

Quando essas derivadas não são múltiplos de 1111, o quociente passa a ser pelo span S delas. Nesse caso só se usa o filtro necessário |Z_[t]| = 4|S|, e cada célula é conferida em seguida.

Resultados corrigidos, da execução 43541725883 do CI:

| classe | \|S\| | dim ρ | dim célula | células que sobram | fecham por um momento | precisam de varredura na célula |
|---:|---:|---:|---:|---:|---|---:|
| 1 | 2 | 16 | 5 | 0 | — | 0 |
| 128 | 2 | 14 | 5 | 280 | s₁s₂ da fibra 0, nas 280 | 0 |
| 129 | 2 | 14 | 5 | 272 | s₁s₂ da fibra 0, nas 272 | 0 |
| 22, 37, 51 | 4 | 10 | 9–10 | 336 | 232 (fibras 0, 1, 2) | 104 |
| 23, 36, 50 | 8 | 5 | 14–15 | 22 | 1 (s₁s₂ da fibra 0) | 21 |
| 164, 165, 178, 179 | 8 | 3 | 14 | 6 | 1 (s₁s₂ da fibra 0) | 5 |

Em todas as classes, nenhum mapa com x₂₄ = 1 satisfaz as condições de suporte. Nas classes 1, 128 e 129, a hipótese de tamanho entra só como |Z_[t]| = 8 no quociente. Nas demais, ainda é preciso varrer os pontos de algumas células (2^9 a 2^15 pontos cada). A enumeração bit a bit de A_κ fica como controle independente.

**Classe 129, prova** (`prova_x24_classe129.py`). As identidades são afins no código e foram conferidas numa base de 21 pontos de A_129:
- **I1 (diagonal):** ρ(y,0) = x₂₄·Λy, com Λ = (4,6,2) e núcleo {0,7}; π0(0) = 15 e π0(63) = 0.
- **I2:** nas linhas 3, 5 e 6, χ = bit 0 de ρ.
- **I3:** a linha 7 só carrega pares ímpares.
- **I4:** ρ∘swap = ρ.

Lema, sem usar o tamanho: se x₂₄ = 1 e Z_[0] não toca as linhas M = {1,2,4}, então o momento s₁s₂ da fibra 0 vale 1. As órbitas do swap contribuem χ; o ponto 63 contribui 1.

Passo finito restante, só sobre ρ (2^14 valores): o balanceamento e a ortogonalidade, juntos, impedem Z_[0] de tocar M. Cada um dos dois sozinho não basta.

Testemunha negativa: 4358938703 satisfaz toda a ortogonalidade, mas tem tamanhos de fibra errados; nela, Z_[0] toca as linhas 1, 2 e 4.

Hipóteses por etapa, com o certificado por células:

| etapa | H-orth | H-bal | H-size | H-RS |
|---|:-:|:-:|:-:|:-:|
| 242 classes vazias | sim | 14 delas | | sim |
| identidade coluna mod L = x₂₄·w | sim | sim | | sim |
| x₂₄ = 0 em 10 classes (nenhum ρ sobrevive) | sim, nas fatias ativas | sim | só \|Z_[t]\| = 8 | sim |
| x₂₄ = 0 em 1, 128, 129 (célula cai num momento) | sim | sim | só \|Z_[t]\| = 8 | sim |

O que resta de checagem finita é pequeno: 2^12 a 2^16 valores de ρ por classe e 32 pontos por célula sobrevivente (1.696 células no total). Uns 90 s numa CPU.

## Arquivos (`phase_plane/`)

- `plane_cert.py`: espaços afins por nível de hipótese (H0 a H4) e teste de identidade de grau 4 módulo L.
- `enum_slice.py`: enumeração bit a bit de um espaço afim, com fatias opcionais (`--fix`, `--slices`). Mede cobertura, sobreviventes, violações e devolve uma testemunha decodificável. A opção `--no-size` faz a relaxação.
- `cells_x24.py`: o certificado por células de x₂₄ = 0; a saída é `cells_x24.json`.
- `residues.py`: decomposição do resíduo, que tem posto 1 e é afim, por classe.
- `ideal.py`: teste de pertença ao ideal truncado.
- `verify_plane.py`: o verificador pequeno. Refaz tudo para as 256 classes e grava `certificate.json`, em uns 20 minutos numa CPU.
- `aggregate.py`: o agregador. Confere a cobertura das 256 classes e de todas as fatias; com `--catalog`, faz o controle.
- `.github/workflows/n12_v1_phase_plane.yml`: 8 fatias por classe (κ mod 8) com `max-parallel: 8` em runners de 4 vCPU, no máximo 32 CPUs. Inclui a relaxação e a agregação.
- `certificate.json`, `aggregate-local.json`: saídas locais.

```
python -I verify_plane.py .. --out certificate.json
python -I plane_cert.py .. --classes all --levels H0,H4 --out spaces.json
python -I enum_slice.py .. spaces.json --classes nonempty --out slices.json
python -I aggregate.py spaces.json slices.json --catalog <dir>/mapas_V1.txt
```
