# Cotas geométricas e de Delsarte na valoração dois

No caso global módulo 127, suponha que \(T=k(k-1)/2\) tenha menor valoração não nula dois. Ponha \(P_2=\{b:\nu_2(T(b))=2\}\), \(N=|P_2|\) e \(s=\dim\operatorname{aff}(P_2)\). A análise abaixo prova

| Dimensão afim de \(P_2\) | Limite inferior de \(N\) |
|---|---:|
| 7 | 128 |
| 8–14 | 192 |
| 15–21 | 256 |
| 22–28 | 320 |
| 29 | 384 |
| 30 | 418 |
| 31 | 424 |
| 32 | 426 |

Esses resultados são restrições necessárias. A existência de um candidato global com menor valoração dois permanece aberta.

## 1. O código das avaliações afins

Todos os momentos binários de \(P_2\) até ordem seis são nulos. O código de avaliações afins tem dimensão \(s+1\) e cada suporte não nulo de uma palavra tem momentos nulos até ordem cinco, pois o indicador do suporte é ele próprio uma avaliação afim. Sua distância é pelo menos 64. O custo mínimo no nível dois é 394716 e a paridade dá \(N\le1338\). [Momentos binários e custo mínimo](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b3890a40dc9536fda11679e1fc5547b180e5f600/research_updates/2026_11_21_walsh_mod127/OBSTRUCAO_CODIGO_TRIORTOGONAL_MOD127.md).

Usamos o encurtamento com a palavra constante e a desigualdade de Delsarte já verificados para o ramo três. Cada palavra escolhida para encurtar é levantada ao código original, com zeros em todos os suportes já retirados. O complemento da união dos suportes é também suporte de uma avaliação afim, obtida somando a palavra constante aos indicadores retirados. Assim cada código encurtado não vazio contém a palavra constante. A distância mínima não decresce. Se se retira um suporte \(A\), a dimensão do código diminui em no máximo \(1+\dim\operatorname{aff}(A)\). [Recorrência de encurtamento e certificados exatos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/be3964511c9220891daca44cf88caa43532c1ea9/research_updates/2026_11_21_walsh_mod127/VALORACAO_TRES_DELSARTE_MOD127.md).

A recorrência auxiliar tem novos dados para conjuntos de ordem de momentos \(t=5,6\). Escreva \(D=2^{t+1}\). Peso \(D\) é o peso de um \((t+1)\)-espaço afim, com dimensão de avaliações \(t+2\). Entre \(D\) e \(2D\), os únicos pesos possíveis são da forma \(2D-2^{i+1}\), com \(0\le i<t\). Na forma de diferença simétrica de dois \((t+1)\)-espaços, sua interseção tem dimensão \(i\), e a dimensão de avaliações é no máximo \(2t+3-i\). Na forma quadrática, o suporte fica em um espaço afim de dimensão \(t+3\), dando dimensão de avaliações no máximo \(t+4\). Portanto o limite uniforme é o maior desses dois. Para pesos entre dois e dois e meio mínimos, usamos a lista de pesos de Kasami–Tokura–Azumi da recorrência anterior. [Kasami–Tokura e Kasami–Tokura–Azumi](https://arxiv.org/pdf/1811.00015).

Com esses dados, a primeira passagem da recorrência dá os limites da tabela, inicialmente com \(384\) para \(s=29,30,31,32\). O refinamento abaixo separa as últimas três dimensões.

## 2. Momentos exteriores de suportes retirados

Se \(S\) tem momentos nulos até ordem \(r-1\), seu momento \(\mu_r(S)\) de ordem \(r\) é um \(r\)-vetor, porque covetores repetidos reduzem a ordem do produto. Os momentos inferiores também garantem invariância por translação. Se \(S\) é um \(r\)-espaço afim, \(\mu_r(S)\) é o volume exterior da sua direção. O suporte de um \(r\)-vetor é o menor espaço em cujo exterior ele se encontra, e seu anulador é o núcleo do mapa de contração por covetores.

Se \(r\)-vetores têm suportes \(A,B\) com \(\dim(A\cap B)\le r-2\), a soma tem suporte \(A+B\). De fato, potenciais cancelamentos de contrações pertenceriam a \(\Lambda^{r-1}A\cap\Lambda^{r-1}B=\Lambda^{r-1}(A\cap B)=0\). Esse critério permite somar vários blocos quando seu déficit total de dimensão, em relação às dimensões individuais, é no máximo \(r-2\).

Em ordem cinco de momentos e peso \(64,96,112,120,124,126\), o primeiro momento exterior \(\mu_6\) tem suporte igual à direção do fecho afim. No peso mínimo isso é imediato. Para a família de dois espaços, os volumes individuais têm direções de dimensão seis, com interseção de dimensão no máximo quatro, e aplica-se o critério de não cancelamento. Para a família quadrática, em dimensão afim oito, o momento é o dual da parte quadrática do indicador. Em coordenadas de Darboux, ele é a soma dos complementos dos pares simpléticos, com pelo menos dois pares. A contração por cada coordenada produz um monômio de grau cinco exclusivo para algum par omitido que não contém a coordenada. Os monômios produzidos por duas coordenadas distintas não coincidem, pois o complemento de três índices identifica o único par simplético completo omitido e o índice contratado. Portanto nenhuma contração não trivial zera.

Precisamos também da seguinte cota. Se cinco volumes de espaços de dimensão seis têm soma com suporte de dimensão no máximo oito, sua soma de direções tem dimensão no máximo 24. Denote essa dimensão por \(D_0\). Se \(D_0\ge26\), o déficit entre \(5\cdot6=30\) e \(D_0\) é no máximo quatro, logo o suporte da soma é pleno. Se \(D_0=25\), separe os volumes em um par e uma trinca com direções totais \(A,B\) de dimensões \(a\le12,b\le18\). Os déficits \(12-a\), \(18-b\), \(a+b-25\) somam cinco. Se o primeiro ou o segundo déficit é cinco, os grupos estão em soma direta e o outro grupo tem suporte pleno de dimensão pelo menos 12. Nos demais casos, ambos os grupos têm suporte pleno. Restrinja as contrações aos anuladores de \(A\) e de \(B\). Elas produzem imagens de dimensões \(25-a\) e \(25-b\) que se intersectam em no máximo uma dimensão, pois sua interseção está em \(\Lambda^5(A\cap B)\) e \(\dim(A\cap B)\le5\). A soma dos volumes teria suporte de dimensão no mínimo \(50-a-b-1\ge19\), uma contradição.

## 3. O caso de escala 128 na ordem cinco

Todo conjunto de 128 pontos com momentos nulos até ordem cinco tem dimensão de avaliações no máximo 14. Suponha dimensão pelo menos 15. Um suporte mínimo com peso pelo menos 48 teria peso menor que 64 por Griesmer e posto no máximo 11. Encurtar deixaria comprimento no máximo 80, dimensão pelo menos quatro e distância pelo menos 48. Isso contradiz a simetria dos pesos do código com constante, que impõe distância no máximo metade do comprimento. Portanto o primeiro suporte é um 5-espaço afim de peso 32. Restam comprimento 96 e dimensão pelo menos nove. Um mínimo de 48 tornaria equidistantes todos os pesos próprios, o que exigiria \(2^8\mid96\). Assim o segundo suporte também tem peso 32. O código restante tem comprimento 64 e dimensão pelo menos três, portanto seu próximo mínimo é 32, e o complemento final também é um 5-espaço. Os quatro volumes de direção são de ordem cinco e somam zero. A soma de direções tem dimensão no máximo dez pelo lema dos quatro volumes, de modo que o fecho afim tem dimensão no máximo 13. [Lema dos quatro volumes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/5c67796b51e99edaa8e735225d5a4b91e59adeb9/research_updates/2026_11_21_walsh_mod127/ENCURTAMENTO_GEOMETRICO_MOD127.md).

## 4. Exclusão de perfis com tamanho baixo

Para \(N=384\) e \(s\ge29\), a recorrência exige seis suportes de peso 64. Todos são espaços afins de dimensão seis. A relação de momentos de ordem seis implica que a direção do sexto está na soma das primeiras cinco, cujo momento tem suporte de dimensão seis. Pela cota da seção 2, suas direções geram no máximo 24 dimensões. As seis origens adicionam no máximo cinco dimensões, de modo que \(s\le29\).

A partir da cota para ordem cinco e tamanho 128, o verificador exige as únicas partições abaixo quando \(s\ge30\) e \(386\le N\le416\).

| \(N\) | Partição permitida pela recorrência |
|---:|---|
| 400 | \(64+64+64+96+112\) |
| 408 | \(64+64+64+96+120\) |
| 412 | \(64+64+64+96+124\) |
| 414 | \(64+64+64+96+126\) |
| 416 | \(64+64+64+64+64+96\) ou \(64+64+64+96+128\) |

Nas quatro primeiras linhas, o último bloco tem suporte exterior pleno e dimensão no máximo doze. A direção do último bloco está na soma das quatro primeiras direções, cujas dimensões máximas individuais somam 26. Se elas gerassem pelo menos 22 dimensões, o déficit seria no máximo quatro e seu momento exterior teria suporte pleno de dimensão pelo menos 22. Portanto as direções somadas geram no máximo 21 dimensões, e as cinco origens dão dimensão afim no máximo 25.

Para \(64+64+64+64+64+96\), o bloco de 96 está na soma das primeiras cinco direções pelos momentos de ordem seis. A soma dessas direções tem no máximo 24 dimensões pela seção 2. Assim o fecho afim tem dimensão no máximo 29. Na partição \(64+64+64+96+128\), se o último bloco tem momento exterior pleno, a demonstração das primeiras quatro linhas se aplica, pois sua dimensão é no máximo 13 pela seção 3. Se o momento não é pleno, há uma coordenada que anula o dual da parte superior do indicador. Na escolha dessa coordenada, toda a parte superior do indicador é divisível por ela. Cortar pelas duas fatias reduz o grau e preserva a ordem cinco dos momentos. Como o fecho afim é pleno no espaço onde se trabalha, ambas as fatias são não vazias. Cada uma tem pelo menos 64 pontos. Logo o bloco de 128 se parte em dois espaços afins de tamanho 64, retornando à partição já excluída.

Após essas exclusões, o verificador não encontra partições até \(N=422\) para \(s\ge31\), nem até \(N=424\) para \(s=32\). Isso prova os novos limites da tabela. O verificador da seção 7 usa aritmética inteira.

## 5. Cotas superiores condicionais

Se o fecho afim de \(P_2\) tem codimensão \(u=32-s\), sua massa total está limitada por \(F+2^{-u}(B-F)\), com \(B=528531328\) e \(F=3\cdot2^{26}+16256\), pela média de Fourier da autocorrelação. Como cada ponto de \(P_2\) custa pelo menos 394716 e \(N\) é par, obtemos \(N\le612,716,924,1338\) para \(s=29,30,31,32\), respectivamente. [Cota de massa afim](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/dcb2f41901844379880f0efa2fb9aefc1fe50a6e/research_updates/2026_11_21_walsh_mod127/AUTOCORRELACAO_E_DIMENSAO_AFIM_MOD127.md).

## 6. Exclusão de 1338 pontos pela aritmética dos custos

A comparação exata dos custos exclui \(N=1338\). Os dois totais possíveis de \(T\) são \(B\) e \(B-32512\). Após pagar \(394716\cdot1338\), sobram no máximo 401320 unidades. Em unidades de \(508=4\cdot127\), os incrementos possíveis em cada ponto de \(P_2\) são \(0,238,240,510\), e os custos fora de \(P_2\) são \(0,16\). São as possibilidades que cabem na sobra para \(k\bmod127\in\{0,1\}\).

A sobra, em unidades de 508, vale seis módulo 16 para ambos os totais possíveis. Há no máximo três incrementos de resíduo não nulo, pois cada um vale 14 módulo 16 e custa pelo menos 238 das 790 unidades disponíveis. Os quatro resíduos possíveis \(0,14,12,10\) não incluem seis. Portanto \(N\le1336\) em todo o ramo de valoração dois.

## 7. Verificador

Extraia o bloco Python e passe como argumento o caminho da nota de R19. O programa confere o SHA-256 da nota de referência antes de executar a recorrência.

~~~~python
from hashlib import sha256
from pathlib import Path
from types import ModuleType
import sys

NOTE = Path(sys.argv[1]) if len(sys.argv)>1 else Path("VALORACAO_TRES_DELSARTE_MOD127.md")
data = NOTE.read_bytes()
assert sha256(data).hexdigest() == (
    "78ec7cde5cbb77a771a596fbd18c5566b5d5cbe66ee923ee362ba22681d9eb26"
)
source = data.decode().split("~~~~python\n", 1)[1].split("\n~~~~", 1)[0]
m = ModuleType("r19")
exec(compile(source, str(NOTE), "exec"), vars(m))

def clear_caches():
    for function in (m.allowed_weight, m.rank_cap, m.enhanced, m.admissible,
                     m.affine_rank_cap, partitions):
        function.cache_clear()

@m.cache
def partitions(n, k, d):
    if not m.allowed_weight(5, n):
        return set()
    if n == 0:
        return {()} if k <= 0 else set()
    if k <= 1:
        return {(n,)} if n >= d else set()
    if not m.enhanced(6, n, k, d):
        return set()
    result = set()
    for w in range(d, n//2+1, 2):
        loss = m.rank_cap(5, w)
        if loss and m.can_have_distance(n, k, w):
            result.update((w,)+p for p in partitions(n-w, k-loss, w))
    return result

for t in (5, 6):
    minimum = 1 << (t+1)
    m.SMALL_RANK[t] = {minimum: t+2}
    for i in range(t+1):
        w = 2*minimum - (1 << (i+1))
        if w > minimum:
            m.SMALL_RANK[t][w] = max(2*t+3-i, t+4)
clear_caches()

bounds = {k: next(n for n in range(128, 385, 2)
                  if m.allowed_weight(6, n) and m.enhanced(6, n, k, 64))
          for k in range(8, 34)}
assert list(bounds.values()) == [128]+[192]*7+[256]*7+[320]*7+[384]*4
assert partitions(384, 30, 64) == {(64,)*6}

# The geometric rank bound for 128-point strength-5 sets proved in the note.
m.NEW_RANK[5, 128] = 14
clear_caches()

candidates = {
    400: {(64,64,64,96,112)},
    408: {(64,64,64,96,120)},
    412: {(64,64,64,96,124)},
    414: {(64,64,64,96,126)},
    416: {(64,64,64,64,64,96), (64,64,64,96,128)},
}
for n in range(386, 418, 2):
    actual = partitions(n, 31, 64) if m.allowed_weight(6, n) else set()
    assert actual == candidates.get(n, set()), (n, actual)
for k, lower in ((32,424),(33,426)):
    assert partitions(416,k,64) == {(64,64,64,64,64,96)}
    assert all(not partitions(n,k,64) for n in range(386,lower,2)
               if n != 416 and m.allowed_weight(6,n))
    assert partitions(lower,k,64)
print("Val2: affine dimensions 30, 31, 32 require N >= 418, 424, 426 respectively.")

# Exact cost residue at the largest even count in the original budget.
c2 = 394_716
N = 1338
budget = 528_531_328
slack = budget - N*c2
p2_increments, outside = set(), set()
for k in range(-32768,32769):
    if k % 127 not in (0,1):
        continue
    T = k*(k-1)//2
    if T % 8 == 4 and c2 <= T <= c2+slack:
        assert (T-c2) % 508 == 0
        p2_increments.add((T-c2)//508)
    if T % 8 == 0 and T <= slack:
        assert T % 508 == 0
        outside.add(T//508)
assert p2_increments == {0,238,240,510}
assert outside == {0,16}
for total in (budget,budget-32512):
    remainder = (total-N*c2)//508
    assert remainder % 16 == 6
    assert remainder//238 <= 3
    assert all((14*i)%16 != 6 for i in range(remainder//238+1))
print("Val2: N=1338 excluded by exact cost residues; universal upper bound N <= 1336.")
~~~~
