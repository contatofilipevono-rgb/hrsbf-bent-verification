# Certificados elementares no espaço de polares inteiro (n = 12, grau ≤ 4)

Data: 14/11/2026, noite. Ramo `claude/n12-parseval-certificados`.

## Modelo
O modelo `base12` tem 68 dimensões: 25 para a polar e 43 para a fase. É o modelo inteiro de `COBERTURA_PLANOS_N12.md`, que contém todas as RS de grau ≤ 4 que satisfazem as duas relações lineares universais do topo. Em todas, f(z,w) é quadrática em w. Os certificados de `NOTA_AUTOCORRELACAO.md` só usam essa estrutura, então se aplicam a qualquer polar, e não só ao complemento dos planos.

## Varredura (`enum_polares_todos.py`, `pipeline_todos.py`; VM spot de 96 vCPUs)
- A enumeração de `poisson5.py` (topos que passam o teste dos quárticos de Pfaffiano, vezes as partes baixas) **sem pular** as assinaturas cobertas pelos planos dá 18.816 polares.
- Desses, **10.156** são viáveis em (L5).
- Em cada viável aplicamos, nesta ordem: (L5)+(L3), autocorrelação em (0,d) (níveis odd, mod4, mod 2^k) e linhas forçadas.

| Assinatura | (L5)+(L3) | odd | mod4 | mod8/16 | mod64 | forçado | **aberto** |
|---|---:|---:|---:|---:|---:|---:|---:|
| a≠0, b≠0 (complemento) | 2.304 | 1.152 | 396 | 10 | 102 | 20 | **0** |
| a≠0, b=0 | 972 | 348 | 600 | 142 | 358 | 36 | **116** |
| a=0, b≠0 | 1.464 | 512 | 292 | 1 | 20 | 75 | **64** |
| a=b=0 | 884 | 60 | 134 | 32 | 0 | 30 | **32** |

- O complemento reproduz exatamente os 3.984 de antes.
- **Os 12 polares distintos das testemunhas bent estão entre os 212 abertos.**

## Os 212 abertos (`abertos212.txt`, `abertos212_resultados.json`)
Usamos duas ferramentas:
- **funil antigo** (`bitj.py exclui --first`): para na primeira bent encontrada;
- **Parseval exato nas 64 colunas juntas** (`parseval_colunas.py`): é condição necessária, decidida por enumeração exata de F₂^D.

| Parseval nas 64 colunas | Funil: bent encontrada | Funil: morto | Funil: não terminou em 25 min |
|---|---:|---:|---:|
| nenhum ponto comum (morto) | 0 | 35 | 48 |
| há pontos comuns | 49 | 38 | 36 |
| D > 22 (não testado) | 1 | 0 | 5 |

- Coerência: nenhum polar com bent é morto pelo Parseval exato.
- Os certificados elementares **não** classificam sozinhos: dos 212 abertos, ao menos 121 não são bent.
- Ao fim da primeira rodada sobravam 41 indefinidos; a busca neles foi relançada com 90 minutos por polar.

### Atualização (rodadas 2 e 3 da busca)
- **Rodada 2:** busca nos 41 indefinidos, um processo por polar, 90 min cada. Mais 16 polares com bent e 11 mortos.
- **Rodada 3:** os 14 polares restantes, cada um dividido em 6 processos (variável `BITJ_ASG_SHARD`, que reparte os blocos de atribuições da cobertura entre os processos), 2 h por processo. Mais 3 polares com bent; os outros 11 estão presos no teste de Walsh do caminho com núcleo, com núcleos enormes.

Contagem atual dos 212: **69 com bent, 132 mortos, 11 indefinidos.** Os indefinidos são quase todos de assinatura a = b = 0 e têm D ≥ 16 (alguns com D > 22, sem o teste exato das colunas).

Ideia para os 11: antes do Walsh, restringir as formas de ativação a cada espaço de sobreviventes x₀ + ⟨K⟩ e exigir as 64 colunas juntas. Isso corta quase todos os pontos (nos polares bent, os pontos comuns às 64 colunas são de 1 a 864 em U inteiro).

### Atualização (rodadas 4 a 7)
- **Busca por padrões** (`busca_padroes.py`, exata):
  - toda bent está no espaço linearizado p₂ + ⟨k₂⟩ e tem padrão de ativação entre os pontos comuns às 64 colunas;
  - cada padrão corta um subespaço afim, que é varrido inteiro com Walsh completo.
  
  Controle positivo: acha bent num polar bent conhecido. A varredura de um mesmo polar é dividida entre processos (`--hitshard`).
- Resultados por polar:
  - **com bent:** polar 6;
  - **mortos sem nenhum padrão comum às 64 colunas:** polares 13 e 4;
  - **mortos com todos os subespaços varridos sem bent:** polares 1, 2, 7 e 9, com 38 a 67 milhões de pontos cada.
- **Polar nulo** (hex `0`): f(z,w) é afim em w, nas coordenadas z = a + b e w = b de `base12.py`. É a família afim nas classes da diagonal antipodal, que tem 290.004.992 quárticas bent (`README.md`). Conta como **com bent** pela teoria. Na busca, 8 de 9 fatias morreram, e a fatia que faltava foi cortada pelo limite.
- **Ainda indefinidos:**
  - polar 5 (dimensão 43, D = 20, 496 padrões), em busca por padrões;
  - polar 11 (D = 28, grande demais para os padrões), cuja última fatia da busca lenta foi dividida em 10 subpartes.
- A VM spot foi interrompida uma vez e religada sem perda. Alguns processos morreram por falta de memória (cerca de 2 GB cada na enumeração dos padrões) e foram relançados com no máximo 36 simultâneos.

**Contagem dos 212: 72 com bent, 139 mortos, 2 indefinidos (5 e 11).**

### Fecho (14/11, madrugada do dia 15)
- **Polar 11: morto.** As 8 primeiras fatias (de 9) da busca fatiada morreram. A 9ª foi dividida em 10 subpartes (i ≡ 8 mod 9 numa divisão em 90), que também morreram. A cobertura das 2²⁸ atribuições é completa.
- **Polar 5: morto.** Nova opção `--quad` de `busca_padroes.py`: em cada subespaço de padrão, o sistema quadrático dos bits de Poisson é reescrito nas coordenadas do subespaço (`substitute`, conferida contra a avaliação direta em 200 casos aleatórios) e passado a `exclude_vec`.
  - Controle positivo: acha bent no polar de teste em 161 s, contra 604 s sem `--quad`.
  - No polar 5: 90 partes, 268.435.456 sobreviventes testados por Walsh completo, nenhuma bent.
- A VM spot passou para n2-standard-96 (384 GB) antes desta etapa e foi apagada ao fim. Backup em `Downloads/analise adversarial/backup_vm_bitj96/spot_resultados.tgz`.

## Veredito final do espaço de polares (`veredito212.json`)
| | Polares |
|---|---:|
| passam (Pf4) | 18.816 |
| viáveis em (L5) | 10.156 |
| mortos por certificados elementares ((L5)+(L3), autocorrelação, linhas forçadas) | 9.944 |
| abertos depois dos certificados | 212 |
| … mortos pelo funil (Poisson + sistema quadrático + Walsh), inclusive fatiado | 85 |
| … mortos pelo Parseval exato nas 64 colunas | 48 |
| … mortos pela busca por padrões (com ou sem `--quad`) | 7 |
| **… com bent** | **72** |

Os 12 polares distintos das testemunhas bent estão entre os 72. **Fora desses 72 polares, nenhuma RS bent de grau ≤ 4 em 12 variáveis existe** neste modelo. O modelo cobre todas as RS de grau ≤ 4 que satisfazem as duas relações universais, e toda bent as satisfaz.

**Atualização (15/11):** os 140 mortos da tabela acima já não dependem das buscas. Cada um tem um certificado em árvore, verificado de forma independente (`NOTA_CERTIFICADOS_ARVORE.md`, `certificados_arvore_140.json.gz`).

Dependências:
- a enumeração (Pf4) × partes baixas;
- o modelo `base12`;
- a correção dos funis de busca, que têm controles positivos e negativos;
- o teorema da família da diagonal (`README.md`) para o polar nulo.

## Contagem dos completamentos: reprodução exata do catálogo (`contagem72.json`)
Para cada um dos 71 polares não nulos, contamos todas as bent com `busca_padroes.py --quad --count`:
- todo ponto bent está no espaço linearizado de Poisson e tem um único padrão de ativação entre os pontos comuns às 64 colunas;
- os subespaços dos padrões são disjuntos;
- em cada um, o sistema quadrático reescrito é enumerado por `exclude_vec`, e todos os sobreviventes passam por Walsh completo.

Cada ponto θ do espaço de fase dá uma função diferente, e cada função tem um único polar.

**Validação:** em três polares (dois com D = 4, um com D = 12), a contagem com `--quad` e a força bruta (Walsh em todos os pontos dos subespaços) dão exatamente 6.144, 6.144 e 8.192.

| | Funções bent |
|---|---:|
| 71 polares não nulos (contados aqui) | **19.216.384** |
| polar nulo: família da diagonal (`README.md`: 64 + 57.280 + 290.004.992) | 290.062.336 |
| **total** | **309.278.720** |
| catálogo: quárticas fora da diagonal | 19.216.384 |
| catálogo: todas as RS bent de grau ≤ 4 (64 + 57.280 + 309.221.376) | 309.278.720 |

As contagens por polar vão de 1.536 a 10.485.760. O polar de D = 25 tem 10.485.760, que é o mesmo número da recontagem do bloco afim em U de 10/11. Distribuição: 1.536 (4 polares), 4.096 (2), 6.144 (32), 8.192 (8), 16.384 (2), 90.112 (4), 196.608 (3), 262.144 (3), 393.216 (4), 524.288 (2), 589.824 (2), 655.360 (2), 786.432 (2) e 10.485.760 (1).

**Conclusão:** a classificação pelos polares reproduz exatamente a contagem do catálogo, sem usar o catálogo como entrada. Ele só aparece na comparação final.

O que ainda é computacional:
- a enumeração (Pf4) × partes baixas;
- a verificação de (L5) polar a polar;
- as buscas nos 212 abertos;
- as contagens.

O polar nulo vem do teorema da diagonal. Os certificados elementares, que cobrem 9.944 polares, são verificáveis à mão.

## Nível módulo 8 (`cert_mod8.py`)
S_d = 0 exige Σ_z ℓ_z = N_d/2 exatamente.
- O bit 0 dá o sistema afim mod4.
- Pelo teorema de Lucas, o bit 1 é e₂(ℓ) = Σ_{z<z'} ℓ_z ℓ_{z'} mod 2, uma quadrática em θ.
- No espaço solução do sistema mod4, as 63 quadráticas são linearizadas (cada y_i y_j vira uma incógnita). Se o sistema fica inconsistente, o polar morre.

A expansão foi conferida contra a força bruta em 300 casos, sem divergência.

Resultado nos 212: **16** dos 83 que o Parseval exato matava recebem certificado; nenhum polar com bent é certificado. Os outros 67 ainda dependem da enumeração exata em F₂^D (D ≤ 22).

## O que isto mostra
1. Para os polares de (L5), os certificados elementares (paridade e sistemas lineares) decidem tudo, exceto 212 de 10.156.
2. Os polares bent estão todos nesse resíduo.
3. Separar bent de não bent dentro do resíduo exige mais que os níveis lineares. As ferramentas que funcionam são:
   - Parseval exato nas colunas;
   - as quadráticas do nível mod8;
   - os bits de Poisson de grau 2;
   - o Walsh direto.
