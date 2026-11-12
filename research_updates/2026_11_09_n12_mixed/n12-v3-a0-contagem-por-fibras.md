# As fases do tipo A₀ em n=12

A redução da fatia fixa dá π|Φ=0 no bloco V₃. Nos 832 mapas balanceados e com indicadoras de grau no máximo cinco da forma A₀, a fase na fibra zero é afim em u. A inclinação ℓ(x) tem quatro opções por mapa, pois as diferenças no núcleo de π são geradas por x+111 e x+σ(x)111. A fibra zero é bent se e somente se ℓ é uma permutação de oito pontos. Em 208 mapas nenhuma das quatro opções é uma permutação. Nos outros 624 há exatamente uma. A seleção dos 144 mapas que admitem fase bent exclusiva ainda requer as demais condições.

Entre as sete órbitas de A₀ que chegaram ao sistema de fases preparado, as duas órbitas sem fase são excluídas pela permutação. Nas cinco restantes, fixei a permutação em lugar das equações de momentos da fibra zero. Os rótulos 1, 3 e 7 representam as outras órbitas da rotação. Usar os três reproduz a contagem exata. Todo subconjunto próprio desses três rótulos dá uma contagem maior nos cinco representantes.

| Representante | Tamanho da órbita | Dimensão residual | Como se contam as soluções | Fases por mapa |
| ---: | ---: | ---: | --- | ---: |
| 1583330 | 32 | 11 | Dois blocos polares disjuntos, proporções 1/4 e 3/4 | 12.288 |
| 225448170 | 32 | 12 | Dois blocos polares disjuntos, proporções 3/8 e 1/4 | 12.288 |
| 225448085 | 32 | 12 | Proporção 3/8 numa quadrática e uma condição linear balanceada no radical comum | 24.576 |
| 225448212 | 32 | 12 | Proporção 3/8 numa quadrática e uma condição linear balanceada no radical comum | 24.576 |
| 225448239 | 16 | 11 | Uma quadrática balanceada | 32.768 |

Nos dois primeiros casos, uma escolha de base no espaço das duas equações dá formas polares com postos aditivos na soma. Suas imagens duais têm interseção zero, e cada quadrática é constante nas classes laterais do seu próprio radical porque a soma de Gauss é não nula. Portanto as duas condições dependem de blocos lineares disjuntos e suas proporções se multiplicam. Nos dois casos seguintes, uma translação no radical comum muda somente uma das duas equações. Isso divide por dois o conjunto que satisfaz a quadrática de proporção 3/8. O fator 32 do quociente de fases é reposto em cada linha. A soma ponderada pelos tamanhos das órbitas é 2.883.584.

O verificador `v3_a0_fibre_counts.py`, em `work/n12-mixed/v3-symbolic`, usa os 832 códigos já construídos e as tarefas preparadas. Ele confere a decomposição em blocos e a translação no radical comum. Este passo explica as multiplicidades dos cinco representantes em termos dos sistemas quadráticos reduzidos.

## Seleção dos mapas pela geometria da fibra de rótulo 1

Na forma A₀, Q(z)=σ(r)(I+r111ᵀ). Quando r é ímpar, a imagem de Q é o plano par, e g(z) é ímpar porque a fibra zero já está completa na fatia fixa. Cada linha ímpar fornece um par {u,u+r} para cada rótulo ímpar. São 32 linhas ímpares e 64 pontos por rótulo, portanto não há pontos em linhas pares. Para o rótulo 1, escolha u=1+g(z). A rotação de três posições reúne cada par e sua imagem em uma órbita de quatro pontos. Na ordem (z,u), (z,u+r), (R³z,u+x), (R³z,u+x+r), os valores da fase são

    H, H+x₀, H+u₀, H+u₀+x₀+r₀.

Conceda um H independente em cada uma das 16 órbitas. O coeficiente de H num momento de ordem até dois é a soma do monômio nos quatro pontos da órbita. Esse coeficiente independe de u, como se verifica expandindo o monômio após as translações. Para um momento não constante, o lado direito é o segundo bit da cardinalidade do subconjunto. Sobre F₂, esse bit é a soma dos produtos de dois indicadores de pertencimento distintos. Assim as equações podem ser compiladas diretamente como polinômios nos parâmetros de g.

Na parametrização de 12 bits de `classify_case(...,351)`, a matriz nos 16 sinais por órbita tem posto 7. A eliminação deixa apenas duas condições independentes para o mapa, com índices de parâmetro começando em zero

    t₈+t₉=0,
    t₁+t₂+t₇+t₈+t₁₀+t₁₁=0.

Dos 624 mapas com uma permutação na fibra zero, essas condições excluem os 480 sem fase bent exclusiva. A conclusão é mais forte que o teste no núcleo global de fases, pois essas 480 incompatibilidades persistem mesmo com liberdade por órbita na fibra 1.

## Reconstrução sem a lista de mapas

O programa `v3_a0_reconstruct.py` deriva as duas equações a partir dos momentos, reconstrói a parametrização de A₀ e projeta o espaço de inclinações da fibra zero. A projeção tem dimensão quatro e admite três permutações. Impor cada permutação e as duas condições locais reduz os parâmetros a dimensões oito, sete e sete. As equações polinomiais de grau das indicadoras e o balanceamento por sete transformadas de Walsh em cada espaço produzem

| Inclinação na fibra zero | Dimensão | Antes do balanceamento exato | Mapas balanceados |
| --- | ---: | ---: | ---: |
| 76543210 | 8 | 208 | 80 |
| 74132560 | 7 | 96 | 32 |
| 72431560 | 7 | 96 | 32 |

## Contagem dos mapas por subespaços afins

O reprodutor atual obtém as contagens sem percorrer os pontos dos espaços de parâmetros. Escreva `χ_m(t)=(-1)^{m·t}`, com `m` dado como máscara binária em decimal. Agrupar os pontos de cada soma pelo seu caráter dá três somas distintas, para os rótulos 1, 3 e 7. A soma do rótulo 7 é `−16 ± 12χ₁₂₂`; exigir o valor −4 fixa um hiperplano. Nesse hiperplano, as somas dos rótulos 1 e 3 coincidem.

Na primeira parametrização, com `a=χ₇`, `b=χ₁₀` e `c=χ₁₈₁`, a soma comum é `−2a−4b+2ab+2c−2bc`. Ela vale −4 se `b=1` ou se `(b,a,c)=(−1,1,−1)`. As três máscaras são independentes módulo a máscara do hiperplano. Logo os dois casos são subespaços afins disjuntos de dimensões 6 e 4, dando `2⁶+2⁴=80`. Nas outras duas parametrizações, a soma comum é um único caráter com coeficiente −4, e fixa um segundo hiperplano independente, dando `2⁵=32` em cada uma. As condições de grau das indicadoras se anulam identicamente nos quatro subespaços, por substituição polinomial.

Os 144 mapas geram exatamente as cinco órbitas acima, e os momentos de fase dão as mesmas 2.883.584 funções. O reprodutor parte das bases, sem carregar os 832 códigos nem o catálogo. Ele lista os 144 pontos dos quatro subespaços apenas para identificar as órbitas e aplica a contagem de fases aos cinco representantes. A dedução direta dos sistemas quadráticos de fase a partir da geometria das outras três fibras permanece aberta.
