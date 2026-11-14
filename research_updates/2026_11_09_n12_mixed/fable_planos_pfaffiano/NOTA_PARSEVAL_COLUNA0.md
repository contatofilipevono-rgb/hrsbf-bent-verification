# Parseval na coluna b = 0 (cobertura pelos planos, n = 12)

Script: `parseval_dominio.py`. Resultados: `parseval_L5.json`, com os 3.984 polares compatíveis com (L5). Cerca de 2 s por polar.

## Condição
Seja r(z) = Σ_w (−1)^{f(z,w)}. A coluna b = 0 do espectro é Ŵ(a,0) = Σ_z (−1)^{a·z} r(z), e Parseval dá Σ_a Ŵ(a,0)² = 64 Σ_z r(z)². Se f é bent, todos os |Ŵ| valem 64, logo

  Σ_z r(z)² = 4096.

## Decisão no domínio inteiro
U = part + ⟨ker⟩ é o espaço afim deixado por (L5)+(L3), de dimensão 26 a 39. Fatos usados:
- Para u ∈ U, a tabela f_u(z,·) de cada linha é quadrática em w.
- A polar B_z não depende de u: cada direção do núcleo é afim em w em todas as linhas (afirmado no script).
- r_u(z)² = 2^{12−rank B_z} se f_u(z,·) é constante no radical de B_z, e 0 caso contrário.
- Essa "ativação" da linha z é dada por dim rad(B_z) equações afins em u.

Seja D a dimensão do espaço gerado por todas as formas de ativação. Todos os 2^D padrões de valores ocorrem em U, então os valores atingíveis de Σ r² são calculados exatamente enumerando F₂^D (D ≤ 22 em todos os polares).

## Resultado (14/11/2026)

| Onde o funil antigo matou | 4096 impossível em U | 4096 atingível |
|---|---:|---:|
| (L5)+(L3), domínio vazio | n/a | n/a (2.305) |
| linearização dos bits de Poisson | 276 | 48 |
| Walsh, com sistema quadrático vazio | 116 | 16 |
| Walsh, com sobreviventes | 1.144 | 73 |
| ainda em execução | 0 | 7 |

- Dos 1.680 polares que passam por (L5)+(L3), **1.536 morrem só por Parseval**.
- Controle positivo: todos os polares das 18 testemunhas bent atingem 4096.
- Nenhuma linha tem posto 6: B_z tem posto 0, 2 ou 4 em todos os casos.
- **Congruência (contagem corrigida em 14/11; a versão anterior dizia 1.140, errado):** em 1.196 dos 1.536 casos, Σ r² tem resíduo constante não nulo módulo 2048 em todo U (768 em 744 polares, 1792 em 412, 1024 em 40), logo nunca vale 4096. Nos outros 340 casos, os valores atingíveis pulam 4096. Os certificados algébricos dos 1.196 estão em `NOTA_CERTIFICADOS_PARSEVAL.md`.

## Reformulação exata (para a prova)
Σ_w (−1)^{f(z,w)+f(z,w+d)} = 64·(−1)^{f(z,d)+f(z,0)} se d ∈ rad B_z, e 0 caso contrário. Logo

  Σ_z r(z)² = 64 · Σ_{(z,d) ∈ R} (−1)^{g(z,d)},  R = {(z,d) : d ∈ rad B_z},  g(z,d) = f(z,d) + f(z,0),

e 4096 ⇔ wt(g|_R) = (|R| − 64)/2. Para os 1.196 casos, a constância módulo 2048 está provada por certificados de caracteres (extensão do Codex): ver `NOTA_CERTIFICADOS_PARSEVAL.md`.
