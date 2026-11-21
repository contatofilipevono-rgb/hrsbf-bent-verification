# Valoração três módulo 127 — pelo menos 238 pontos de primeira valoração

No ramo global \(W_f=-512+2^{17}k\), \(k\bmod127\in\{0,1\}\), considere a menor valoração não nula de \(T=k(k-1)/2\) igual a três. Escreva \(P=\{\nu_2(T)=3\}\), \(Q=\{T\equiv16\bmod32\}\), \(N=|P|\) e \(q=|Q|\). Denote por \(C(P)\) o código das avaliações afins em \(P\). A análise abaixo dá
\[
\boxed{238\le N\le290,\qquad q\le12,\qquad d(C(P))\ge62.}
\]
Além disso, o posto do emparelhamento do símbolo quártico sobre os símbolos das quadráticas que zeram em \(P\) é no máximo seis. Para \(N=238\), a tabela da seção 5 localiza as duas distâncias mínimas restantes.

## 1. Dados de partida e encurtamento

As provas anteriores dão \(\dim\operatorname{aff}P=32,\ 202\le N\le290\), todos os momentos de \(P\) até ordem cinco nulos e \(d(C(P))\ge48\). O orçamento é
\[
c_3 N+c_4q\le B,\qquad c_3=1\,813\,560,\quad c_4=7\,748\,016,\quad B=528\,531\,328.
\]
A paridade de \(N\) faz parte dos momentos nulos. Para um conjunto \(S\) com momentos nulos até ordem \(t\), todo suporte de palavra de \(C(S)\) tem momentos nulos até ordem \(t-1\). Isso decorre de multiplicar cada monômio pelo indicador afim do suporte. A afirmação também vale para o suporte de uma palavra de qualquer encurtamento anterior de \(C(S)\), pois a palavra original é zero nas coordenadas apagadas. Ao encurtar em um suporte \(A\), a dimensão cai em no máximo \(1+\dim\operatorname{aff}A\). A distância mínima não cai. [Dimensão plena, momentos e recorrência anterior](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/475e902cdcb4e4cefbcdd240e5bc11b4323e5863/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_PLENO_MOD127.md) · [Cortes, custos e posto restrito](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b6a94b168a62fd31cc4286b4d838bc7fb1dda209/research_updates/2026_11_21_walsh_mod127/CORTES_E_POSTO_VALORACAO_TRES_MOD127.md).

Se o código atual tem comprimento \(n\), dimensão pelo menos \(k\) e palavra mínima de peso \(w\), vale a cota de Griesmer \(G(k,w)=\sum_{j=0}^{k-1}\lceil w/2^j\rceil\le n\). O complemento dos suportes já retirados tem momentos nulos até ordem \(t-1\), pois cada suporte retirado tem essa propriedade. Podemos testar os pesos admissíveis tanto para a próxima palavra como para esse complemento. Usamos abaixo os pesos de Kasami–Tokura e Kasami–Tokura–Azumi até \(2{,}5\) vezes o mínimo, com igualdade tratada somente onde explicitado. [Cota de Griesmer](https://hyperelliptic.org/tanja/teaching/CCI11/CODING.pdf) · [Listas de pesos e formas normais, Lemas 3 a 5 de Krotov](https://arxiv.org/pdf/1811.00015).

## 2. Direções de conjuntos com peso baixo

Para um conjunto \(A\) cujos momentos até grau \(r-1\) são nulos, seu momento de ordem \(r\) é uma forma multilinear alternada \(\mu_r(A)\) sobre as formas lineares, ou equivalentemente um \(r\)-vetor no espaço dos pontos. Um fator repetido reduz a ordem, o que dá alternância. Os momentos inferiores nulos também dão invariância por translação. Para um \(r\)-espaço afim \(A\), o momento \(\mu_r(A)\) é o volume exterior de sua direção. Basta parametrizar um flat linear e somar o produto das \(r\) formas lineares. Apenas o termo que usa todas as coordenadas contribui, produzindo o determinante binário.

Usamos duas observações sobre o suporte exterior, que é o menor espaço no qual o vetor exterior pode ser escrito.

- Se um \(r\)-vetor \(\alpha\) está em \(\Lambda^r U\) e \(\omega\) é o volume de um \(r\)-espaço \(W\) que acrescenta pelo menos duas dimensões a \(U\), então o suporte de \(\alpha+\omega\) é a soma do suporte de \(\alpha\) com \(W\). Para provar, escolha uma base de \(W\) adaptada a \(U\cap W\), com os vetores restantes fora de \(U\), independentes módulo \(U\). As contrações de \(\omega\) por formas lineares têm pelo menos uma dessas coordenadas fora de \(U\) em cada monômio. Logo \(\iota_\ell\alpha+\iota_\ell\omega=0\) se e somente se ambas as contrações zeram. Os anuladores por contração determinam os suportes.
- Se quatro volumes exteriores não nulos de \(r\)-espaços somam zero, a soma de suas direções tem dimensão no máximo \(2r\), para \(r\ge3\). Se há repetição, os volumes se cancelam em pares e o resultado é imediato. Se todos são distintos, escreva a igualdade como soma de dois volumes de cada lado. Quando o primeiro par compartilha \(r-1\) dimensões, sua soma é decomponível de suporte \(r\). O outro par também tem de compartilhar \(r-1\) dimensões, pois, se acrescentasse duas ou mais dimensões, a primeira observação daria suporte de dimensão maior que \(r\). Cada par tem espaço soma de dimensão \(r+1\) contendo o mesmo suporte \(r\), então o espaço de todas as direções tem dimensão no máximo \(r+2\). No outro caso, os dois pares acrescentam ao menos duas dimensões. A primeira observação identifica cada espaço soma com o suporte da mesma soma de volumes, de dimensão no máximo \(2r\).

Para conjuntos de 24 ou 28 pontos com momentos nulos até ordem três, vale
\[
\operatorname{supp}\mu_4(A)=\operatorname{dir}\operatorname{aff}A .
\]
Em peso 24, a forma de Kasami–Tokura é a diferença simétrica de dois 4-espaços afins que se encontram num 2-espaço. A apresentação quadrática de peso 24, quando usada, tem posto quatro e dá a mesma diferença simétrica em coordenadas de Darboux. Em peso 28, a primeira família tem dois 4-espaços com interseção de dimensão um. Em ambas as famílias de dois espaços, aplica-se a primeira observação. A outra possibilidade em peso 28 é um quadrático de posto seis em dimensão afim seis. Aí \(\mu_4\) é dual ao símbolo quadrático, pois somar o indicador vezes um monômio de ordem quatro seleciona o coeficiente de volume. Em coordenadas de Darboux, a forma dual é a soma dos três produtos de dois pares distintos. Sua contração por qualquer funcional não nulo é não nula, como se vê nos monômios em que o índice omitido pertence a cada par. Logo seu suporte tem dimensão seis. [Formas normais de Kasami–Tokura e dualidade](https://arxiv.org/pdf/1811.00015).

## 3. Novas cotas para dimensão afim em pesos baixos

Na tabela, \(t\) é a ordem até a qual os momentos de \(S\) são nulos. O valor \(k\) é a dimensão de \(C(S)\) que estamos excluindo. As sequências listam pesos de suportes sucessivos de palavra mínima após cada encurtamento. Os suportes são disjuntos. O pseudocódigo transformado em Python na seção 6 confere a cota de Griesmer, a lista de pesos admissíveis e o posto perdido a cada passo.

| \(t\) | \(|S|\) | Hipótese \(\dim C(S)\ge k\) | Sequência que resta | Pontos no complemento dos cortes |
|---:|---:|---:|---|---:|
| 3 | 32 | 11 | \(8,8,8\) | 8 |
| 4 | 64 | 13 | \(16,16,16\) | 16 |
| 4 | 68 | 13 | \(16,24\) | 28 |
| 4 | 72 | 14 | \(16,16,16\) | 24 |
| 4 | 74 | 14 | nenhuma | — |
| 4 | 76 | 17 | \(16,16,16\) | 28 |

Para a aritmética, usamos, abaixo do dobro do peso mínimo, os seguintes limites para a dimensão das avaliações afins. O peso mínimo é \(2^{t+1}\) e dá um \((t+1)\)-espaço. Na primeira família de Kasami–Tokura, para peso \(w\), a interseção dos dois espaços tem \(2^i=(2^{t+2}-w)/2\) pontos. Sua união tem dimensão afim \(2(t+1)-i\). Na família quadrática, o limite de dimensão afim é \(t+3\).

| Ordem \(t\) | Peso e cota de dimensão de \(C(S)\) |
|---:|---|
| 2 | \(8\mapsto4,\ 12\mapsto6,\ 14\mapsto7\) |
| 3 | \(16\mapsto5,\ 24\mapsto7,\ 28\mapsto8,\ 30\mapsto9\) |
| 4 | \(32\mapsto6,\ 48\mapsto8,\ 56\mapsto9,\ 60\mapsto10,\ 62\mapsto11\) |

Por exemplo, para \(t=4,\ |S|=64,\ k=13\), vale \(G(13,32)=70>64\). Um mínimo de pelo menos 24 e menor que 32 teria suporte de posto no máximo nove. Após encurtar restariam comprimento até 40 e dimensão ao menos quatro, contra \(G(4,24)=45\). Então o primeiro peso é 16. Restam \(48,8\) e depois \(32,3\) como limites de comprimento e dimensão. Em ambas as etapas 24 é impossível e o peso é 16. O complemento final tem momentos nulos até ordem três e 16 pontos.

Nas duas primeiras linhas, \(S\) é união disjunta de quatro flats de dimensão \(r=t\). Seus \(r\)-vetores somam zero por \(\mu_r(S)=0\). A segunda observação da seção 2 dá dimensão total das direções no máximo \(2r\). Somar até três diferenças entre origens dos flats dá \(\dim\operatorname{aff}S\le2r+3\), uma contradição em cada linha.

No peso 68, escreva a partição como \(F,A,D\) de tamanhos \(16,24,28\). A relação \(\mu_4(D)=\mu_4(F)+\mu_4(A)\) põe a direção de \(D\) na soma das direções de \(F\) e \(A\). Essa soma tem dimensão no máximo dez, e se a dimensão fosse dez, seria direta. Nesse caso o lado direito teria suporte dez, contra suporte no máximo sete do lado esquerdo. As direções têm, portanto, dimensão total no máximo nove. Até duas diferenças de origens dão \(\dim\operatorname{aff}S\le11\).

Nos pesos 72 e 76, a partição restante tem três 4-espaços e um conjunto \(A\) de peso 24 ou 28, respectivamente. A direção de \(A\) está contida na soma \(U\) das direções dos três 4-espaços, pela relação dos momentos de ordem quatro. Se \(U\) tem dimensão pelo menos dez, cada uma das duas adições de 4-espaços aumenta a dimensão em pelo menos dois. A primeira observação, aplicada duas vezes, implica que a soma dos três volumes tem suporte \(U\), de dimensão pelo menos dez. Isso contradiz \(\dim\operatorname{supp}\mu_4(A)\le7\). Logo \(\dim U\le9\) e, somando até três diferenças de origens, \(\dim\operatorname{aff}S\le12\). A linha de peso 74 termina pela própria aritmética. As cotas resultantes para \(\dim C(S)\) são \(10,12,12,13,13,16\) nas seis linhas.

## 4. Aplicação ao tamanho de \(P\)

Use a recorrência de encurtamento. Num estado com ordem de momentos \(t\), comprimento \(n\), dimensão pelo menos \(k>0\) e distância mínima pelo menos \(d\), enumere um peso mínimo par \(w\ge d\) que satisfaz \(G(k,w)\le n\). Uma cota superior \(A_{t-1}(w)\) para a dimensão das avaliações afins no suporte dá o estado sucessor
\[
(t,n-w,k-A_{t-1}(w),w).
\]
A cota \(A_{t-1}(w)\) vem das tabelas acima, ou da mesma recorrência aplicada a um conjunto com \(w\) pontos e momentos nulos até ordem \(t-1\). O peso de qualquer suporte não vazio de avaliação afim nesse conjunto é pelo menos \(2^{t-1}\). O próprio conjunto precisa ter pelo menos \(2^t\) pontos. Para ordem dois, o posto das avaliações afins é no máximo \(w/2\) por auto-ortogonalidade. Pesos impossíveis são descartados conforme a distância mínima e as listas de pesos baixos. Passar do estado para o suporte reduz a ordem dos momentos. Encurtar reduz o comprimento. Assim o teste é finito, e um estado rejeitado viola uma condição necessária.

Aplicando o teste a \((5,N,33,48)\), nenhum \(N\) par entre 202 e 236 é admissível. O teste admite \(N=238\). Logo \(N\ge238\), e o orçamento dá \(q\le12\). Pelo emparelhamento em quadráticas da prova anterior, a restrição de \(B_a\) ao espaço dos símbolos das quadráticas que zeram em \(P\) tem posto no máximo \(q-\dim C(Q)\). Para \(1\le q\le12\), essa cota é no máximo \(q-1-\lceil\log_2q\rceil\le7\). A forma é alternada, logo seu posto é par e, portanto, no máximo seis. Quando \(q=0\), o posto restrito é zero.

## 5. Perfis dos cortes pequenos mais fortes

Para um hiperplano \(H\) de normal física \(v\), escreva \(w=|P\cap H|\), \(s=|Q\cap H|\). O símbolo cúbico da derivada de \(f\) tem suporte em no máximo
\[
D=\dim\operatorname{aff}(P\cap H)+\max(0,\lfloor(s-1)/2\rfloor)
\]
formas lineares, pela análise dos momentos no corte da nota anterior. Depois de somar as variáveis quadráticas de fora do suporte, o viés da derivada é o de um polinômio de grau até três em \(d\le D\) variáveis multiplicado por \(2^{-h}\), com \(0\le h\le31-d\). Aqui usamos o quociente pela direção \(v\), de dimensão 31, pois a derivada é periódica nessa direção. Se havia \(2t\) variáveis em pares do quadrático e \(c\) restrições afins independentes, então \(h=t+c\), o que satisfaz o limite indicado. Uma soma residual não nula tem valor absoluto \(127j\cdot 2^{\lceil d/3\rceil}\) para algum \(j\ge1\). A distância mínima limita o viés residual a \(3/4\), pois função constante é incompatível com a divisibilidade por 127. Para \(d\le11\) o viés é zero. Para os outros \(d\), descartamos os menores pesos proibidos por Kasami–Tokura e Kasami–Tokura–Azumi. No quociente de dimensão 31, a própria soma garante que o viés da derivada é múltiplo de \(127/2^{20}\).

Escreva \(\delta=|\Delta_f(v)|/8\). Os dados acima enumeram um conjunto finito contendo todos os valores possíveis de \(\delta\). A diferença de massas entre \(H\) e seu complementar é uma das quatro combinações \(\pm\delta\pm16\,256\), pela identidade de Fourier para \(T\). Com o orçamento total, alguma dessas combinações precisa cair no intervalo
\[
[\,2(c_3w+c_4s)-B,\ B-2(c_3(N-w)+c_4(q-s))\,].
\]
Enumerando \(q,s\), e combinando com a recorrência para uma palavra **mínima** de peso \(w\), resulta:

| Peso mínimo \(w\) | Maior \(N\) permitido pela massa do corte | Menor \(N\) permitido pelo encurtamento |
|---:|---:|---:|
| 48 | 212 | 242 |
| 56 | 220 | 252 |
| 60 | 242 | 252 |

Esses três pesos não podem ser a distância mínima de \(C(P)\). Os pesos entre eles são proibidos por Kasami–Tokura, logo \(d(C(P))\ge62\). Para \(N=238\) os testes deixam apenas os seguintes perfis necessários:

| Distância mínima | \(\dim\operatorname{aff}(P\cap H)\) num corte mínimo | \(q\) | \(s\) |
|---:|---:|---:|---:|
| 62 | 10 | 9 a 12 | pelo menos 9 |
| 64 | 11 | 7 a 11 | pelo menos 7 |

Em peso 62 e dimensão afim dez, a forma normal é a diferença simétrica de dois 5-espaços que se encontram num ponto. Em peso 64 e dimensão afim onze, a partição da seção 3 pode ser reunida em dois 5-espaços afins disjuntos. Para ver isso, as quatro direções da partição precisam ter soma de dimensão oito, pois há até três diferenças de origens. Se os quatro volumes são distintos, a prova da seção 2 põe os dois pares no caso de dois espaços em soma direta, com o mesmo suporte de dimensão oito. A decomposição de uma soma de dois volumes de 4-espaços complementares é única a menos de permutação. Com efeito, no dual de seu suporte, o conjunto dos funcionais cuja contração é zero ou decomponível é a união dos anuladores dos dois espaços. Se um funcional não anula nenhum dos espaços, sua contração é soma de dois volumes cúbicos em espaços disjuntos e tem suporte de dimensão seis. A união dos dois anuladores determina ambos, pois seus únicos subespaços maximais são os próprios anuladores. Assim os quatro volumes têm de se repetir em pares. Cada par de flats paralelos e disjuntos sobre \(\mathbb F_2\) forma um 5-espaço. Isso dá o resultado geométrico para o perfil de peso 64.

## 6. Verificação inteira em Python

O teste confirma cotas necessárias. Um perfil aceito não implica a existência de \(P\), \(Q\) ou de \(f\).

~~~~python
from functools import cache

B, E = 528_531_328, 16_256
C3, C4 = 1_813_560, 7_748_016

SMALL_RANK = {
    2: {8: 4, 12: 6, 14: 7},
    3: {16: 5, 24: 7, 28: 8, 30: 9},
    4: {32: 6, 48: 8, 56: 9, 60: 10, 62: 11},
}
NEW_RANK = {
    (3, 32): 10,
    (4, 64): 12,
    (4, 68): 12,
    (4, 72): 13,
    (4, 74): 13,
    (4, 76): 16,
}

@cache
def griesmer(k, d):
    return sum((d + (1 << j) - 1) >> j for j in range(k))

@cache
def allowed_weight(t, n):
    if n == 0:
        return True
    minimum = 1 << (t + 1)
    if n < minimum or n % 2:
        return False
    if n < 2 * minimum and t in SMALL_RANK:
        return n in SMALL_RANK[t]
    top = 5 * minimum // 2
    if 2 * minimum < n < top:
        low = {2 * minimum + (2 * minimum >> ell)
               for ell in range(2, (t + 3) // 2 + 1)}
        low.update(top - 2 * (1 << i) for i in range(t - 1))
        low.update(top - 6 * (1 << i) for i in range(t - 2))
        return n in low
    return True

def cutting_chains(t, n, k, lower, prefix=(), stop_at=()):
    if len(prefix) == 3 or prefix in stop_at:
        return {(prefix, n)}
    assert k > 0
    result = set()
    for w in range(lower, n + 1, 2):
        if griesmer(k, w) > n:
            break
        if not allowed_weight(t - 1, w) or not allowed_weight(t - 1, n - w):
            continue
        if w in SMALL_RANK[t - 1]:
            loss = SMALL_RANK[t - 1][w]
        else:
            assert (t - 1, w) in NEW_RANK
            loss = NEW_RANK[t - 1, w]
        result.update(cutting_chains(t, n - w, k - loss, w,
                                    prefix + (w,), stop_at))
    return result

assert cutting_chains(3, 32, 11, 8) == {((8, 8, 8), 8)}
assert cutting_chains(4, 64, 13, 16) == {((16, 16, 16), 16)}
assert cutting_chains(4, 68, 13, 16, stop_at=((16, 24),)) == {
    ((16, 24), 28),
}
assert cutting_chains(4, 72, 14, 16) == {((16, 16, 16), 24)}
assert cutting_chains(4, 74, 14, 16) == set()
assert cutting_chains(4, 76, 17, 16) == {((16, 16, 16), 28)}

@cache
def affine_rank_cap(t, n):
    if n == 0 or not allowed_weight(t, n):
        return 0
    special = NEW_RANK.get((t, n), SMALL_RANK.get(t, {}).get(n))
    if special is not None:
        return special
    if t == 2:
        return n // 2
    for k in range(n // 2, 0, -1):
        if admissible(t, n, k, 1 << t):
            return k
    return 0

@cache
def admissible(t, n, k, lower):
    if k <= 0:
        return True
    for w in range(lower, n + 1, 2):
        if griesmer(k, w) > n:
            break
        loss = affine_rank_cap(t - 1, w)
        if loss and admissible(t, n - w, k - loss, w):
            return True
    return False

assert not any(admissible(5, n, 33, 48) for n in range(202, 238, 2))
assert admissible(5, 238, 33, 48)
assert (B - 238 * C3) // C4 == 12
assert max(2 * ((q - 1 - (q - 1).bit_length()) // 2)
           for q in range(1, 13)) == 6

def cubic_weight_allowed(d, w):
    minimum = 1 << (d - 3)
    if w < minimum:
        return False
    if w < 2 * minimum:
        end = max(min(3, d - 3), (d - 1) // 2)
        return w in {2 * minimum - (2 * minimum >> i)
                     for i in range(1, end + 1)}
    top = 5 * minimum // 2
    if 2 * minimum < w < top:
        low = {2 * minimum + (2 * minimum >> ell)
               for ell in range(2, (d - 1) // 2 + 1)}
        low.update(top - 2 * (1 << i) for i in range(d - 5))
        low.update(top - 6 * (1 << i) for i in range(d - 6))
        return w in low
    return True

@cache
def nonnegative_delta_masses(controls):
    masses = {0}
    for d in range(12, min(31, controls) + 1):
        ax = (d + 2) // 3
        base = d - ax
        for j in range(1, (3 * (1 << base)) // (4 * 127) + 1):
            weight = ((1 << d) - (127 * j << ax)) // 2
            if not cubic_weight_allowed(d, weight):
                continue
            for damping in range(32 - d):
                exponent = base + damping
                if exponent > 20 and j % (1 << (exponent - 20)):
                    continue
                mass = (127 * j << 29) >> exponent
                masses.add(mass)
    return masses

def local_profile_allowed(n, w, q, s):
    controls = affine_rank_cap(4, w) - 1 + max(0, (s - 1) // 2)
    lower = 2 * (C3 * w + C4 * s) - B
    upper = B - 2 * (C3 * (n - w) + C4 * (q - s))
    return any(lower <= sign * m + e <= upper
               for m in nonnegative_delta_masses(controls)
               for sign in (-1, 1) for e in (-E, E))

def local_sizes(w):
    return [n for n in range(202, 291, 2)
            if any(local_profile_allowed(n, w, q, s)
                   for q in range((B - C3 * n) // C4 + 1)
                   for s in range(q + 1))]

def minimum_sizes(w):
    loss = affine_rank_cap(4, w)
    return [n for n in range(202, 291, 2)
            if griesmer(33, w) <= n
            and admissible(5, n - w, 33 - loss, w)]

assert [max(local_sizes(w)) for w in (48, 56, 60)] == [212, 220, 242]
assert [min(minimum_sizes(w)) for w in (48, 56, 60)] == [242, 252, 252]
assert min(minimum_sizes(76)) > 238
print("N >= 238, q <= 12, d(C(P)) >= 62, rank(B_a|K) <= 6")

def profiles(n):
    result = {}
    q_cap = (B - n * C3) // C4
    for w in range(62, n // 2 + 1, 2):
        loss = affine_rank_cap(4, w)
        if not loss or griesmer(33, w) > n:
            continue
        if not admissible(5, n - w, 33 - loss, w):
            continue
        pairs = [(q, s) for q in range(q_cap + 1) for s in range(q + 1)
                 if local_profile_allowed(n, w, q, s)]
        if pairs:
            result[w] = (min(q for q, _ in pairs),
                         max(q for q, _ in pairs),
                         min(s for _, s in pairs))
    return result

assert profiles(238) == {62: (9, 12, 9), 64: (7, 11, 7)}
assert not admissible(5, 238 - 62, 33 - 10, 62)
assert not admissible(5, 238 - 64, 33 - 11, 64)
~~~~

O ramo de valoração mínima três ainda exige excluir os suportes de dimensão plena com 238 a 290 pontos. As valorações mínimas zero, um e dois continuam abertas.
