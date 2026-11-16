# Um padrão mais geral: as reduções por primos ímpares param nos primos pequenos

Data: 15/11/2026. Teste: `teste_regra_sinal.py` (todas as verificações finitas passam). Sem revisão humana; prioridade bibliográfica não verificada.

## O quadro geral
Para n = 2^t·L, com L ímpar, a rotação Z_n tem uma parte 2 (Z_{2^t}) e partes ímpares. Elas agem de modos diferentes:
- **Primo ímpar p:** a restrição às palavras m-periódicas (n = m·p^a) preserva Walsh mod p (Técnica 2). Se p for grande, Parseval força a restrição a ser bent. O problema em n variáveis desce para m variáveis.
- **Parte 2:** só dá a torre de pontos fixos (localização de Sylow, Técnica 40), até a profundidade v₂(n).

**O núcleo difícil de cada frente é o primo ímpar pequeno, abaixo do limiar de rigidez.** Em cada caso, o resto é o espectro excepcional permitido por esse primo:

| Frente | Mundo base m | Primo | Limiar | O que sobra |
|---|---|---|---|---|
| H12, caso C | m = 4 | p = 3 | p > 4 | sombra 4-periódica do tipo ponto |
| p = 17 | m = 20 (grau ≤ 4) | p = 17 | p > 2M/3 ≈ 21 | os bits Q, D do ramo ímpar/par |
| H16 | n = 2⁴ | nenhum ímpar | — | só a torre 2-ádica |
| C(8) falso | n = 8 | nenhum ímpar | — | torre 2-ádica de profundidade 3 permite constância em E |

## Teorema (regra do sinal)
Seja R(m) a afirmação: toda RS bent h em F₂^m satisfaz h(0) + h(1) ≡ m/2 (mod 2). Equivalentemente, sinal(W(0)·W(1)) = (−1)^{m/2}, porque a dualidade é uma bijeção das RS bent.

**Se R(m) vale, p é primo ímpar e p > 2^{m/2}, então R(m·p^a) vale para todo a ≥ 1.** Não é preciso p ∤ m: basta que ⟨R^m⟩ seja um p-grupo.

*Prova.*
1. Seja f RS bent em n = m p^a e g a restrição às palavras m-periódicas, uma função RS em m variáveis.
2. Os pontos não fixos do p-subgrupo de Sylow ⟨R^m⟩ formam órbitas de tamanho múltiplo de p. Os produtos escalares de palavras periódicas repetem p^a vezes (p ímpar). Logo
   W_g(b) ≡ W_f(b,…,b) = ±2^{m p^a/2} ≡ ±2^{m/2} (mod p), por Fermat.
3. W_g(b) é par e |W_g(b)| ≤ 2^m. Um valor par x com |x| < 2^{m/2} e x ≡ ±2^{m/2} (mod p) exigiria que p dividisse um par em [2, 2^{m/2+1} − 2], logo p ≤ 2^{m/2} − 1. Isso é excluído.
4. Então |W_g(b)| ≥ 2^{m/2} para todo b, e Parseval força igualdade: g é bent e RS em m variáveis.
5. Por R(m), sinal(W_g(0)·W_g(1)) = (−1)^{m/2}.
6. Como 2^{m/2} ≢ −2^{m/2} (mod p), os sinais de W_f(0) e W_g(0), e de W_f(1) e W_g(1), coincidem.
7. Logo sinal(W_f(0)·W_f(1)) = (−1)^{m/2} = (−1)^{n/2}, pois p^a é ímpar. ∎

**Casos base:** R(2^t) já estava provado (Técnica 39: a única órbita de tamanho ímpar é o monômio completo). R(4) e R(6) conferidos exaustivamente.

**Consequências (fecham casos que a Técnica 39 deixava abertos):**
- n = 2p^a para todo p ≥ 3: nova prova, sem usar o thm:apar;
- n = 4p^a para p ≥ 5;
- n = 6p^a para p ≥ 11;
- n = 8p^a para p ≥ 17;
- n = 10p^a para p ≥ 37;
- e assim por diante.

Ficam de fora os n com primos pequenos: 12, 24, 30, 36, 40, 56, … O primeiro é n = 12, com m = 4 e p = 3 ≤ 4.

## O caso n = 12 e o H12
- **Classificação no primo excepcional p = 3, m = 4 (exaustiva):** as funções g em F₂⁴ com W_g(b) ≢ 0 (mod 3) para todo b são bent (896) ou do **tipo ponto** (512): |W| = 14 uma vez e 2 nas outras 15, ou seja, indicador de um ponto a menos de complemento e parte afim.
- Para as RS do tipo ponto, sinal(W(0)·W(1)) = −1.
- **Conclusão:** em n = 12, R falha para f ⇔ a sombra 4-periódica de f é do tipo ponto.
- **Para quárticas homogêneas:** a única órbita quártica de tamanho ímpar é {0,3,6,9} (t₄₂). Então h(0) + h(1) = t₄₂, e **R(12) ⇔ t₄₂ = 0**.
  - O caso C (t₄₂ = 1) é exatamente a violação de R(12).
  - Conferido: nas funções do caso C, a sombra só passa no teste mod 3 quando é do tipo ponto. No caso B, só quando é bent. No caso A, nunca.
- **Na classificação completa de grau ≤ 4 em n = 12, R vale:** os 72 polares bent têm todos t₄₂ = 0 (a parte C₃ de B₀ é nula).
- **Alvo à mão:** provar R(12) mataria o caso C do H12 de uma vez. Basta provar para grau ≤ 4. Só a sombra não basta, porque o tipo ponto é aritmeticamente possível; falta combinar com outra informação.
