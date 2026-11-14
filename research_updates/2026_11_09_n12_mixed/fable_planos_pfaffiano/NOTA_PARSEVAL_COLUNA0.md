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

## Todas as colunas juntas: os 144 restantes (`parseval_colunas.py`, `parseval_colunas_144.json`)
Para cada coluna b ∈ F₂⁶, seja r_b(z) = Σ_w (−1)^{f(z,w)+b·w}. Se f é bent, Σ_z r_b(z)² = 4096 para todo b.

O termo b·w é linear em w. Então a polar B_z não muda, e a linha z fica ativa na coluna b se e só se L_{z,ρ}(u) = c_{z,ρ} + b·ρ para ρ numa base de rad B_z. As formas lineares são as mesmas de b = 0; só as constantes mudam. Logo uma única enumeração de F₂^D decide se existe u em que **as 64 colunas valem 4096 ao mesmo tempo**.

- Controle positivo: os polares das testemunhas bent mantêm de 1 a 290 desses pontos. No polar c0c00c0c3030, por exemplo, são 408.864 pontos só na coluna 0 e 64 com as 64 colunas.
- **Os 144 polares em que 4096 era atingível na coluna 0 não têm nenhum ponto comum às 64 colunas.** São 48 que o funil antigo matava pela linearização, 16 de sistema quadrático vazio e 80 de Walsh com sobreviventes. Na maioria, a interseção já fica vazia até a coluna 9.

## Quadro final da cobertura pelos planos (3.984 polares compatíveis com (L5))
| Condição | Polares | Natureza |
|---|---:|---|
| (L5)+(L3) sem solução | 2.304 | álgebra linear |
| Parseval na coluna 0, resíduo constante não nulo mod 2048 | 1.196 | certificado por caracteres, verificado |
| Parseval na coluna 0, outros casos | 340 | enumeração exata de F₂^D (estudo do Codex) |
| Parseval nas 64 colunas juntas | 144 | enumeração exata de F₂^D |
| **Total** | **3.984** | **nenhum polar sobrevive** |

O funil antigo (bits de Poisson de grau 2, sistema quadrático, Walsh direto) terminou com o mesmo veredito (`funil_final_3984.json`), mas pelo caminho caro. Com as condições de Parseval, a exclusão inteira não precisa de sistema quadrático nem de busca.

Faltam, para virar prova sem computador:
- certificados algébricos dos 340, com o Codex;
- certificados dos 144 (conjunção de colunas);
- uma explicação estrutural dos postos 0, 2 e 4.
