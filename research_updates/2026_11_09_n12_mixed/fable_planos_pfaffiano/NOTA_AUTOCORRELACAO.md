# Autocorrelação nas direções de w: certificados elementares (n = 12, grau ≤ 4)

Data: 14/11/2026, noite. Ramo `claude/n12-parseval-certificados`.

## Do conjunto de colunas à autocorrelação
No domínio U de (L5)+(L3), f_θ = f₀ + Σ θ_i K_i. Cada linha f₀(z,·) é quadrática em w, com polar B_z, e cada K_i é afim em w. Para a coluna b,

  E_b(θ) = Σ_z r_b(z)² = 64 Σ_d S_d(θ) (−1)^{b·d},
  S_d(θ) = Σ_{z : d ∈ rad B_z} (−1)^{g(z,d) + L_zd(θ)},  g(z,d) = f₀(z,d) + f₀(z,0).

E_b é a transformada de Walsh de S, e S₀ = 64. Logo

  **E_b = 4096 para todo b  ⇔  S_d = 0 para todo d ≠ 0.**

64·S_d é a autocorrelação de f em (0, d), que se anula para toda bent. A conjunção das 64 colunas de Parseval é, então, exatamente o anulamento das autocorrelações nas direções de w.

## Níveis de certificado (`cert_autocorr.py`); nenhum enumera θ
Seja N_d = #{z : d ∈ rad B_z}.
1. **odd:** se N_d é ímpar para algum d ≠ 0, a soma de N_d sinais ±1 não é 0. Isso depende só do polar.
2. **mod4:** se S_d = 0, então #{z : ℓ_z = 1} = N_d/2, com ℓ_z = g + L_zd(θ). Logo ⊕_z ℓ_z = N_d/2 mod 2. São 63 equações afins em θ; se o sistema é inconsistente, nenhum θ serve.
3. **mod 2^k:** no espaço solução do sistema mod4, S_d tem resíduo constante não nulo módulo 2^k. Isso é conferido pelos coeficientes inteiros (−2)^{|J|} Σ_{l⊇J} n_l, como nos certificados de caracteres.

## Resultados
Controle positivo: os 18 polares das testemunhas bent ficam todos no nível "aberto", sem certificado.

| Conjunto | odd | mod4 | mod8 | mod64 | Total |
|---|---:|---:|---:|---:|---:|
| 144 em que 4096 era atingível na coluna 0 | 40 | 104 | 0 | 0 | 144 |
| 1.196 de resíduo constante (já certificados por caracteres) | 904 | 188 | 10 | 94 | 1.196 |
| **Total** | 944 | 292 | 10 | 94 | **1.340** |

- Nos 94 casos "mod64", S_d é de fato constante e não nulo no espaço solução: as formas se anulam ali, e o certificado também vale com módulo 128.
- O verificador independente (`verifica_autocorr.py`) recalcula tudo por outra implementação:
  - os radicais, pela polar inteira;
  - os postos sobre GF(2) em numpy;
  - a resolução do sistema e a base de caracteres.
  
  Resultado: **1.340 certificados, 0 falhas**.
- Teste negativo: certificados adulterados (testemunha d trocada) e polares bent marcados como "mod4" são rejeitados.

Os 340 polares restantes (exclusões por Parseval sem resíduo constante) não foram tocados: estão com o Codex. O método de autocorrelação provavelmente se aplica a eles também.

Também testei se algum dos 144 tinha uma coluna isolada com resíduo constante (`cert_colunas.py`): nenhum tem. A conjunção é necessária.

## Por que B_z tem posto 0, 2 ou 4 (`pfaffiano6.py`)
- Sobre F₂, posto 6 ⇔ Pf₆(B_z) = Σ_{15 emparelhamentos} b_{i₁j₁} b_{i₂j₂} b_{i₃j₃} ≠ 0. Isso foi conferido contra o posto em 200 polares aleatórios. A ordem dos índices também foi conferida: os postos por linha, calculados pelos bits do polar, batem com os das tabelas reais em 44 polares.
- No espaço inteiro de polares (dimensão 25), Pf₆ **não** é identicamente nulo: o polar de base 24 tem uma linha de posto 6.
- Os 3.984 polares compatíveis com (L5) geram um subespaço W de dimensão 23, cortado por

    c₄ + c₅ + c₆ + c₇ + c₈ + c₉ + c₂₂ = 0,  c₂₁ + c₂₃ + c₂₄ = 0,

  nas coordenadas da base de polares (`base12.pkl`, ordem de `load_model`).
- **Lema:** Pf₆ ≡ 0 em W. Pf₆(Σ c_j b_j) tem grau ≤ 3 em c, então se anula identicamente se e só se se anula nos 2.047 pontos de peso ≤ 3. Conferido.
- Logo, para todo polar compatível com (L5) e todo z, o posto de B_z (sempre par) fica em {0, 2, 4}.

Em aberto: derivar as duas formas lineares de W diretamente das equações (L5), sem passar pela lista dos 3.984.

## Quadro da cobertura pelos planos depois desta nota
| Condição | Polares | Certificado |
|---|---:|---|
| (L5)+(L3) sem solução | 2.304 | álgebra linear |
| autocorrelação em (0,d), níveis odd/mod4/mod8/mod64 | 1.340 | elementar, verificado (este documento) |
| Parseval na coluna 0 sem resíduo constante | 340 | com o Codex |
| **Total** | **3.984** | |
