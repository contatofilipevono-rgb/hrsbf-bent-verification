# Certificados de resíduo de Parseval: 1.196 polares (n = 12, grau ≤ 4)

Data: 14/11/2026.

## Atribuição
- **Reformulação por radicais** (Claude, `NOTA_PARSEVAL_COLUNA0.md`, commit 193e6db):
  E = Σ_z r(z)² = 64 Σ_{(z,d), d ∈ rad B_z} (−1)^{f(z,d)+f(z,0)}.
- **Certificado por caracteres** (Codex, `outputs/parseval-certificado/PROVA.md`): agrupar os pares por forma linear, E(θ) = 64 Σ_L n_L (−1)^{L(θ)}, e provar a constância módulo 2048 por uma relação de XOR ou por coeficientes inteiros de grau baixo.
- **Auditoria e aplicação** (Claude, esta nota): a prova do Codex foi conferida passo a passo e os três pilotos reproduzidos. Os pesos n_L do meu gerador coincidem com os dele nos três pilotos. Os 1.196 certificados foram gerados por `cert_parseval.py` e conferidos por um verificador independente, `verifica_cert_parseval.py`.

## Lema usado
Seja U o espaço afim de dimensão m deixado por (L5)+(L3) e f_θ = f₀ + Σ θ_i K_i. Suponha:
- cada linha f₀(z,·) é quadrática em w (polar B_z);
- cada K_i é afim em w.

Então E(θ) = 64 T(θ), com T(θ) = Σ_L n_L (−1)^{L(θ)}. Em coordenadas de caracteres independentes x ∈ F₂^D, o coeficiente inteiro do monômio x^J em T é (−2)^{|J|} Σ_{l ⊇ J} n_l. Assim:
- T é constante módulo 32 se e só se esses coeficientes são ≡ 0 mod 32 para 1 ≤ |J| ≤ 4. Os graus maiores já carregam o fator 32, e a inversão de Möbius é unimodular.
- Se todo n_l não constante é múltiplo de 2^s, basta conferir |J| ≤ 4 − s.
- Se s ≥ 3, basta a relação ⊕_{n_L/8 ímpar} L = 0.

Se, além disso, E(0) mod 2048 ≠ 0, então E ≠ 4096 em todo U e nenhuma função de U é bent. Nada disso enumera os 2^m parâmetros nem os 2^D caracteres.

## Contagem corrigida
`NOTA_PARSEVAL_COLUNA0.md` dizia 1.140 casos de resíduo constante. Está errado: eu tinha contado só dois padrões de resíduo módulo 4096. Os números certos, conferidos pelo Codex no blob aca14d0… e por mim, são:

| Exclusões por Parseval (de 1.680 polares não vazios) | Polares |
|---|---:|
| resíduo constante 768 | 744 |
| resíduo constante 1792 | 412 |
| resíduo constante 1024 | 40 |
| **com certificado de resíduo (esta nota)** | **1.196** |
| outras exclusões, sem resíduo constante (estudo do Codex; não tratadas aqui) | 340 |
| 4096 atingível em U | 144 |

## Resultado
`certificados_parseval.json` traz, para cada polar:
- o espaço U (`part`, `ker`);
- os pesos n_L;
- E(0), o resíduo, s e o método.

| Resíduo | XOR (s ≥ 3) | Coeficientes (s = 2, grau ≤ 2) | Total |
|---|---:|---:|---:|
| 768 | 264 (s=3: 244; s=4: 20) | 480 | 744 |
| 1792 | 124 (s=3: 108; s=5: 16) | 288 | 412 |
| 1024 | 0 | 40 | 40 |
| **Total** | 388 | 808 | **1.196** |

Forma dos certificados:
- Em todos, os pesos não constantes são múltiplos de 4 (s ≥ 2). Por isso os certificados por coeficientes só precisam de grau ≤ 2.
- A dimensão D dos caracteres vai de 4 a 12.
- Há no máximo 78 conferências por polar (17.308 no total) e no máximo 37 pesos não nulos.
- Perfis mais comuns de |n_L| não constantes: {8: 1, 12: 7, 24: 2} (216), {16: 1, 24: 4} (200), {12: 7, 16: 1} (120).

Verificação independente (`verifica_cert_parseval.py`, 80 partes na VM): **1.196 certificados, 0 falhas.** O verificador:
- resolve (L5)+(L3) de novo e confere que U é o mesmo;
- confere o grau ≤ 2 das linhas pela bilinearidade da polar inteira;
- recalcula os pesos por outro caminho;
- confere todos os coeficientes de grau 1 a 4 numa base de caracteres diferente, sem usar o atalho de s;
- confere a relação de XOR quando o certificado é desse tipo;
- confere que E(0) mod 2048 ≠ 0;
- por fim, confere a consistência com a enumeração de `parseval_L5.json`. Essa última conferência é só controle; a prova não a usa.

## Observação (sem afirmação)
Nos 1.196 casos, o resíduo acompanha as paridades de (nº de linhas de posto 0, nº de linhas de posto 2):
- (par, ímpar) dá 768;
- (ímpar, par) dá 1792;
- (ímpar, ímpar) dá 1024.

Mas o perfil de postos não determina o resíduo: a combinação (ímpar, ímpar) também aparece em 140 polares sem resíduo constante.

## Filtros de Poisson: limite registrado
Conforme a auditoria do Codex (`outputs/auditoria-argon-poisson/PARECER.md`, commit d8e4830), o parecer do Carbon erra ao exigir módulo 8 em F4 com |I| = 1 e em F6 com |I| = 2. Há exemplos bent com momento −4.

Os filtros de `bitj.py` exigem só:
- módulo 4 para F4 com |I| = 1 e para F5;
- módulo 4 para F6 com |I| = 2;
- módulo 8 apenas para F4z com I = ∅. Esse caso é justificado: quatro valores ±64 somam um múltiplo de 128.

O falso filtro módulo 8 não foi incorporado.

## Reprodução
```
python cert_parseval.py polares_residuo_const.txt --out certificados_parseval.json
python verifica_cert_parseval.py certificados_parseval.json
```
Leva cerca de 3 s por polar em cada um. Na VM, com 80 processos, cada etapa levou menos de 2 min.
