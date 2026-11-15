# H12 com computação mínima

Data: 16/11/2026. Enunciado: **não existe função bent RS homogênea quártica em 12 variáveis.**

## Parte à mão (teoria)
1. **Modelo.** Toda RS bent de grau ≤ 4 é quadrática em w nas coordenadas z = a + b, w = b. Isso sai do filtro do quadrado dividido e da meia-volta (`EXTERIOR_QUARTICO_N12.md`, `verifica_relacoes_universais.py`). As quárticas homogêneas que caem no modelo formam um espaço de dimensão 41, e os polares delas um espaço de dimensão 21.
2. **Condições necessárias**, todas provadas à mão:
   - **(Pf4)**, por Poisson nos 4-flats: Σ_{z⊇I} Pf_V(B_z) ≡ 0, equivalente a γ₂(T) = 0.
   - **Paridade:** S_d = 0 exige N_d par, para todo d ≠ 0.
   - **8 linhas** (nota `NOTA_H12_ESPECIAIS.md`). Nas linhas z = 0, z = e_i e z = 63, a fase homogênea não altera |r_b(z)|. O motivo é que os monômios em (z,w) têm graus (0,2), (1,2), (2,1), (2,2), (3,1) e (4,0). Por Parseval na coluna b, Σ_{z nessas 8 linhas} r_b(z)² ≤ 4.096.
   - **(L5)+(L3):** Poisson em hiperplanos e em subespaços de dimensão 3. São equações afins na fase.
   - **Níveis mod 4 e de resíduo** de S_d.
3. **Simetria:** o grupo Γ (circulantes invertíveis e trocas i ↦ k·i) preserva tudo. É opcional aqui.

## Parte computacional (mínima)
**(a) Varredura dos polares.** Para cada um dos 2²¹ = 2.097.152 polares homogêneos, testam-se três critérios só da polar: (Pf4), as 8 linhas e a paridade (`h12_filtros_todos.py`, 3 minutos em 90 processos).

| Critério | Polares que sobrevivem |
|---|---:|
| (Pf4) | 1.176 |
| paridade (todo N_d par) | 14.184 |
| 8 linhas | 1.211.392 |
| (Pf4) e 8 linhas e paridade | **98** |

**(b) Os 98 sobreviventes**, cada um na sua fase homogênea, de dimensão ≤ 20:
- 95 morrem porque o sistema linear de (L5)+(L3) é inconsistente;
- 3 morrem pelos níveis mod 4 ou de resíduo de S_d (`homog_resto.py`, `mede_homogeneo.py`).

Logo, nenhum polar homogêneo admite bent. ∎

## Comparação com a verificação original do H12
- **Antes:** uma busca sobre as funções, num espaço de dimensão 41 a 43.
- **Agora:** toda a teoria escrita; uma varredura de 2²¹ polares com três testes elementares; e 98 sistemas lineares pequenos.
- **O que continua computacional:** a varredura (a) e os 98 sistemas (b). Ambos são simples de reimplementar e de auditar.

## Por que ainda não é "sem computador"
Os conjuntos de sobreviventes não têm estrutura linear:
- os 14.184 pares geram o espaço todo e não têm estabilizador por translação;
- os 6.367 que passam na paridade e nas 8 linhas, e os 98, não são fechados por soma.

São variedades definidas por polinômios de grau 2 a 4 em 21 variáveis sobre F₂. Classificá-las à mão exigiria uma ideia nova, por exemplo decompor o espaço sob a rotação, via F₂[X]/(X⁶ − 1).
