# Nove formas de Q e a fibra fixa em dimensão três

11 de novembro de 2026. Derivação de Codex, com a redução da meia-volta de Fable e conferência independente dos seus dados.

No bloco exclusivo de V = ⟨9,18,36⟩, escrevemos f = h(z,u) + π(z,u)·c, com π = g(z) + Q(z)u. Os índices das coordenadas começam em zero, z é a máscara de seis bits, r = z_baixo + z_alto, e σ é a paridade em três coordenadas. R é a rotação cíclica em três coordenadas.

## Hipótese e dependência restante

Esta classificação de Q usa π = 0 na fatia fixa Φ, dada por r = 0. A nota `n12-v3-fatia-fixa-por-duas-fibras.md` prova essa condição a partir do lema da fatia fixa de Fable e da geometria das fibras invariantes de rótulos 0 e 7. O novo verificador parte das bases e elimina as 15 restrições não nulas sem ler a lista de suportes anterior. A prova anterior por Parseval e sua auditoria ficam em `FABLE_MEIA_VOLTA_DIM3.md` e `audit_fable_v3_fixed.py`.

## Balanceamento em três variáveis

Para λ não nulo, defina Z_λ = {z : λQ(z)=0}. Somando primeiro em u, o balanceamento de λ·π equivale a Σ_{z∈Z_λ} (−1)^{λg(z)}=0. A meia-volta e o quarto de volta emparelham os z fora de V e tornam λg igual nos dois pontos do par. Os oito pontos de V estão em Z_λ e contribuem +8. Logo |Z_λ| deve ser múltiplo de quatro e pelo menos 16. Em um representante de cada par fora de V, o número de valores λg=1 deve ser |Z_λ|/4.

A fibra do rótulo zero já contém os 64 pontos de Φ, portanto g(z) não pertence a Im Q(z) fora de V. Quando Q(z) tem posto dois, isso é uma equação linear em g. Usamos também o primeiro e o segundo bit da condição de balanceamento e as equações de grau dos produtos π_iπ_j e π_0π_1π_2.

O espaço de mapas com π|Φ=0 tem dimensão 28. Q percorre nove dimensões e, fixado Q, restam 19 direções de g. Entre as 512 escolhas de Q, a condição do tamanho de Z_λ elimina 298, o sistema linear elimina 178 e a eliminação polinomial elimina 27. Restam nove. Este passo é álgebra finita numa base explícita, com 512 casos. Os parâmetros de g são eliminados por identidades polinomiais.

## Fórmulas

Ponha 1 = (1,1,1) e e = r + σ(r)1. As nove formas são

\[
0,\qquad
A_j(r)=R^j\bigl[\sigma(r)(I+r1^T)\bigr]\ (j=0,1,2),
\]
\[
B_j(r)=(R^j e)e^T\ (j=0,1,2),\qquad
C_j(r)=1(r\times R^jr)^T\ (j=1,2).
\]

Todas dependem só de r. Os códigos de Q no verificador são A₀=351, A₁=492, A₂=179, B₀=157, B₁=325, B₂=472, C₁=315 e C₂=56.

As quatro formas 0,B₀,B₁,B₂ satisfazem Q(r)1=0. A função então é afim no espaço maior V⊕⟨u=111⟩, que já pertence ao bloco de dimensão quatro. Essa exclusão segue diretamente da forma de π.

## Duas formas excluídas pelo grau na fibra fixa

Se π|Φ=0, a fibra zero é exatamente Φ. A fase H(x,u)=h(9x,u) deve ser bent em seis variáveis, logo seu grau é no máximo três. Para funções bent em seis variáveis, a soma de sinais em qualquer flat afim de dimensão quatro é múltipla de quatro. Seu peso é par, o que anula os coeficientes de grau pelo menos quatro.

Se a(H) é o coeficiente de x₀x₁x₂u₀, vale a identidade linear

\[
a(H)=\sigma(g(7))+\sigma(g(21))+Q_{11}(7).
\]

Aqui Q₁₁ designa a segunda linha e a segunda coluna. O arquivo v3_fixed_fibre_degree.py confere a identidade nos 60 geradores do espaço RS afim em V. Assim ela vale no espaço inteiro por linearidade.

Nas três formas A_j, tanto z=7 quanto z=21 têm r=111, e a imagem de Q é o plano par. A ausência de pontos adicionais na fibra zero força σg(7)=σg(21)=1. Portanto a(H)=Q₁₁(7), que vale 1 em A₁,A₂ e zero em A₀. As duas primeiras são incompatíveis com o grau de H. Restam A₀,C₁,C₂.

## Reconstrução independente das fases

A execução 43022608556 do GitHub construiu os suportes nas nove formas por sistemas booleanos de até 17 parâmetros depois da eliminação linear, impondo o balanceamento exato. Os 21.582 suportes coincidem, como conjunto de códigos, com a parcela π|Φ=0 dos 97.530 anteriores. Não se usou a varredura dos 49.807.360 mapas como entrada.

| Forma | Suportes | Mapas com fase | Funções |
| --- | ---: | ---: | ---: |
| 0 | 9.966 | 0 | 0 |
| B₀,B₁,B₂ | 928 cada | 0 | 0 |
| A₁,A₂ | 832 cada | 0 | 0 |
| A₀ | 832 | 144 | 2.883.584 |
| C₁,C₂ | 3.168 cada | 56 cada | 655.360 cada |
| Total | 21.582 | 256 | 4.194.304 |

O contador nativo e as somas quadráticas por órbita coincidiram mapa a mapa. Com a prova da fatia fixa por duas fibras, essa reconstrução cobre o bloco V₃ inteiro sem usar a varredura original dos 49.807.360 mapas. A descrição por nove formas ainda usa eliminação finita, e a seleção de g e das fases tem certificados computacionais. A cobertura universal das quárticas em n=12 continua computacional.

[Execução das nove formas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/43022608556)
