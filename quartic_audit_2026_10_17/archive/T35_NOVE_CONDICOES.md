# T35: nove condições e uma única estimativa vetorial

## Resultado

As nove condições necessárias aqui reunidas deixam uma fração no máximo

`2097035386883 / 562949953421312`.

Portanto excluem pelo menos

`560852918034429 / 562949953421312 ≈ 99,6274916848046%`

do espaço H(16,4) como candidato a bent. Não se calcula a densidade exata de sobreviventes, e não se prova inexistência global nem a conjectura C16.

A contribuição nova nesta etapa é combinar os segundos bits dos três suportes periódicos 0x3f3f, 0x5f5f e 0x6f6f. Cada bit deve ser zero pelo critério inteiro clássico de bentness. O suporte 0x7777 já fornece a sétima condição fatorada. A forma normal T34 reúne as outras seis condições; ela deixa dois domínios de medidas originais 1/64 e 1/128 após reconstruir c5.

## Um lema que organiza a prova

Considere m polinômios booleanos P₁,…,P_m e um mesmo conjunto S de coordenadas. Suponha que nenhum monômio de grau maior que dois em qualquer P_i contenha duas coordenadas de S. Fixadas as demais coordenadas y, cada combinação não nula

`P_λ = λ₁P₁+…+λ_mP_m`

é quadrática em S, com uma forma polar fixa de posto r_λ. Seja Z_λ a fração de y em que todas as derivadas de P_λ nas direções de uma base do radical dessa forma polar são zero. Então

`Pr(P₁=…=P_m=0) ≤ 2^(−m) [1 + Σ_{λ≠0} 2^(−r_λ/2) Z_λ]`.

**Prova.** A indicadora de que todos os P_i são zero é a média dos 2^m caracteres (−1)^P_λ. Em cada fatia y, a soma normalizada de uma forma quadrática é zero se alguma derivada radical é um; caso contrário seu módulo é 2^(−r_λ/2). Substituir cada soma por seu módulo e fazer a média sobre y fornece a desigualdade. As condições radicais não precisam ser independentes.

Esse lema com m=1 contém as estimativas de T28, T29 e T32. Com m=3 ele aproveita simultaneamente sete combinações dos três novos bits, usando o mesmo conjunto S.

## Aplicação aos três suportes

Depois da substituição exata das condições quarta e sétima, use, em ambos os ramos c99=0 e c99=1,

`S={27,64,73,77,88,92,112}`.

Nenhum monômio superior dos três polinômios contém duas dessas coordenadas. Os postos das sete combinações são:

| combinação de suportes | c99=0 | c99=1 |
|---|---:|---:|
| 3f3f | 0 | 2 |
| 5f5f | 2 | 2 |
| 3f3f + 5f5f | 2 | 2 |
| 6f6f | 0 | 2 |
| 3f3f + 6f6f | 0 | 0 |
| 5f5f + 6f6f | 2 | 2 |
| 3f3f + 5f5f + 6f6f | 2 | 2 |

Os símbolos indicam soma dos polinômios correspondentes, não soma dos suportes. Posto zero não invalida a estimativa: nesse caso a fatia é afim, e sua soma só é não nula quando todas as derivadas lineares em S são zero.

As densidades Z_λ são calculadas exatamente pela expansão

`Z_λ = 2^(−k) Σ_t E_y (−1)^(Σ_i t_i R_i(y))`,

onde R_i são as derivadas em uma base de k direções radicais. Fixar no máximo três coordenadas externas — {57,35,61} no ramo zero e {35,61} no ramo um — torna quadráticos todos os polinômios dessa expansão. Portanto todas as médias restantes são somas quadráticas exatas, sem amostragem e sem hipótese de independência.

O lema dá passagem condicional no máximo

`1375476686851 / 8796093022208` no ramo c99=0,

`172033 / 1048576` no ramo c99=1.

Ponderar pelas medidas originais 1/64 e 1/128 fornece a fração global anunciada.

## Certificação independente

`VERIFICAR_POLINOMIOS_T35.py` reconstrói as órbitas de quartetos, as restrições aos três suportes e todos os coeficientes dos seis modelos de ramos. Verifica as congruências de pesos e interseções, o termo diagonal, as substituições de c23 e c5 e 192 avaliações diretas pela ANF original. Foram reconstruídos 226.930 termos de coeficientes.

`VERIFICAR_LIMITE_CONJUNTO_T35.py` confere os conjuntos S, os postos, as bases radicais e cada derivada. Recalcula todas as somas quadráticas por uma base simplética, independentemente da eliminação de pares que gerou os dados. Os dois verificadores usam apenas Python padrão e os certificados da mesma pasta.

As identidades de expansão inteira e a condição de divisibilidade para bentness usam o critério clássico registrado em T28/T31. O mecanismo de soma de caracteres e os módulos de somas quadráticas são argumentos usuais; novidade bibliográfica desta aplicação ainda não foi estabelecida.

## Limites operacionais

O limite global é sobre funções completas. O domínio T33 de 162.537.472 estados continua sendo a versão preparada para A100. Os dois novos bits não foram incorporados a esse quociente nesta entrega. Sua descida, ou a possibilidade de eliminar representantes usando os três bits em conjunto, requer análise separada. Nenhuma execução GPU é alegada.
