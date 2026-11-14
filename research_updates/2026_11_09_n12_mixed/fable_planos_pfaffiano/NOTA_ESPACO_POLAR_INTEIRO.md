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
