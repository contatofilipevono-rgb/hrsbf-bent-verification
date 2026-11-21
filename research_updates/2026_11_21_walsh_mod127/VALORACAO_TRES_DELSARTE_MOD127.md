# Valoração três módulo 127 — encurtamento com a palavra constante e certificados de Delsarte

Considere o ramo global \(W_f=-512+2^{17}k\), com \(k\bmod127\in\{0,1\}\). Se o custo \(T=k(k-1)/2\) tem menor valoração não nula três, ponha \(P=\{\nu_2(T)=3\}\), \(Q=\{T\equiv16\bmod32\}\), \(N=|P|\) e \(q=|Q|\). Seja \(C(P)\) o código binário de avaliações afins em \(P\). Obtemos
\[
\boxed{274\le N\le288,\qquad N\equiv0\bmod2,\qquad q\le3,\qquad d(C(P))\ge84.}
\]
O emparelhamento do símbolo quártico se anula sobre os símbolos das quadráticas que zeram em \(P\). Além disso, para todo hiperplano espectral afim \(H\),
\[
Q\cap H\ \subseteq\ \operatorname{aff}(P\cap H).
\]

## 1. A palavra constante sobrevive ao encurtamento

O ponto de partida é \(\dim\operatorname{aff}P=32\), \(238\le N\le290\), \(d(C(P))\ge62\) e a anulação dos momentos de \(P\) até ordem cinco. O orçamento é \(c_3N+c_4q\le B\), com \(B=528\,531\,328\), \(c_3=1\,813\,560\) e \(c_4=7\,748\,016\). A cada encurtamento na posição do suporte \(A\) de uma palavra, a dimensão cai no máximo em \(1+\dim\operatorname{aff}A\), e a distância mínima não cai. Os suportes retirados são disjuntos e vêm de palavras do código original de avaliações afins. Se \(A_1,\ldots,A_j\) são os suportes já retirados, a palavra \(\boldsymbol1+\sum_i\boldsymbol1_{A_i}\) é zero nas posições retiradas e um nas demais. Assim o código encurtado ainda contém a palavra constante um. Toda união de blocos retirados também é suporte de uma palavra original. [Dados anteriores e verificador-base](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/5c67796b51e99edaa8e735225d5a4b91e59adeb9/research_updates/2026_11_21_walsh_mod127/ENCURTAMENTO_GEOMETRICO_MOD127.md).

Sempre que a dimensão atual é pelo menos dois, o peso mínimo \(d\) é no máximo \(n/2\) para comprimento \(n\), e todos os pesos além de 0 e \(n\) pertencem a \([d,n-d]\). Se \(d=n/2\), todos esses pesos são iguais a \(n/2\). Escolha uma matriz geradora de dimensão \(k\) com primeira linha constante um. No subcódigo gerado pelas outras linhas, as somas de Walsh do multiconjunto de colunas sem a primeira entrada são nulas nas frequências não nulas. Por inversão de Walsh, cada coluna em \(\mathbb F_2^{k-1}\) ocorre com a mesma multiplicidade. Portanto \(2^{k-1}\mid n\). Os codewords que aparecem no encurtamento são pares, porque o suporte de cada palavra original vem de um corte afim de um conjunto com momentos nulos. O mesmo raciocínio vale na recorrência auxiliar para conjuntos com momentos nulos até ordem três ou quatro.

## 2. Uma cota de Delsarte com certificados inteiros

Escreva \(y=n-2w\), onde \(w\) é o peso que se avalia, e use a base de Krawtchouk \(K_i(y)=\sum_{|I|=i}\chi_I(x)\) para \(x\in\mathbb F_2^n\) de peso \(w\). Temos \(K_0=1\) e
\[
yK_i=(i+1)K_{i+1}+(n-i+1)K_{i-1}
\]
com \(K_{-1}=0\), pois \(y\) é a soma dos caracteres unitários e a multiplicação por um deles alterna a presença de sua coordenada. Em qualquer código linear, \(\sum_{x\in C}\chi_I(x)\) é zero ou \(|C|\). Logo, se \(F=\sum_i a_iK_i\) com \(a_0>0\) e \(a_i\ge0\), então \(\sum_{x\in C}F(n-2|x|)\ge |C|a_0\). Se \(F(n-2w)\le0\) para todos os pesos não nulos permitidos, segue \(|C|\le F(n)/a_0\). [Método de Delsarte e polinômios de Krawtchouk](https://www.cs.utexas.edu/~danama/courses/codes/lec8-LP-bound.pdf).

Na enumeração, o verificador testa três famílias de polinômios. Aqui \(a=n-2d\), \(a_r=n-2r\), e \(r,s\) são pesos pares.

- \(y-a\).
- \(y-a\) multiplicado por um ou dois fatores da forma \((y-a_r)(y-a_{r+2})\). Esses fatores são não negativos nos pesos pares, pois suas raízes correspondem a dois pesos pares consecutivos.
- \((y+n)(y^2-a^2)y^{2j}\), \(0\le j\le4\). O fator \(y+n\) dá zero na palavra constante um. Nos demais pesos não nulos, o sinal é não positivo pelo intervalo simétrico \([d,n-d]\).

Somente coeficientes de Krawtchouk inteiros são usados nos testes. Para entender concretamente a exclusão de \(N=238\), havia duas primeiras fatias, de peso 62 ou 64. Depois da primeira fatia, a recorrência anterior obriga que a distância mínima seguinte seja 80. Isso exigiria um código de parâmetros de comprimento e dimensão pelo menos \((176,22)\) ou \((174,21)\), respectivamente. No primeiro caso use raízes 80, 92, 94, 110 e 112 no peso. O coeficiente \(a_0\) é \(3\,232\,768\) e \(F(n)=272\,751\,001\,600\), portanto \(|C|<84\,371\), contra \(|C|\ge2^{22}\). No segundo caso use raízes 80, 92, 94, 134 e 136, dando \(a_0=9\,361\,312\), \(F(n)=403\,458\,949\,120\) e \(|C|<43\,099\), contra \(|C|\ge2^{21}\). A recorrência geral aplica o mesmo tipo de teste em cada etapa.

## 3. Cotas geométricas adicionais

Para um conjunto \(S\) que anula os momentos até ordem três, escreva \(\mu_4(S)\) para seu momento exterior de ordem quatro. Trabalhando no fecho afim de dimensão \(s\), a dualidade de Reed–Muller identifica \(\mu_4(S)\) com o dual da parte de grau \(s-4\) do indicador. Se uma forma linear não nula no dual da direção anula \(\mu_4(S)\) por contração, podemos escolhê-la como uma coordenada. Todo monômio dessa parte de topo do indicador contém a coordenada escolhida. Nas duas fatias paralelas, portanto, o indicador tem grau no máximo \(s-5\) em dimensão \(s-1\). As fatias continuam anulando os momentos até ordem três e são não vazias, porque \(S\) gera seu fecho afim. Cada uma tem peso pelo menos 16. Assim:

- em peso 32, suporte exterior menor que a direção do fecho afim implica que \(S\) é união disjunta de dois 4-espaços afins;
- em pesos 34, 36, 38 e 42, o suporte de \(\mu_4(S)\) é toda a direção do fecho afim. Nenhuma soma de duas fatias de peso permitido dá esses pesos, usando a lacuna entre 16 e 24 e, em 42, a ausência de 18, 20, 22 e 26;
- em pesos 40 e 44, quando o suporte exterior não é pleno, obtemos uma partição em pesos \(16+24\) e \(16+28\), respectivamente.

Em pesos 24, 28 ou 30 com momentos nulos até ordem três, o suporte de \(\mu_4(S)\) é pleno, e a dimensão afim é no máximo 6, 7 ou 8, respectivamente. Para 24 e 28, use a descrição anterior de Kasami–Tokura. Para 30, a diferença simétrica é de dois 4-espaços afins que se encontram num ponto. As suas direções são disjuntas e os dois volumes têm suporte exterior total de dimensão oito. [Classificação até dois pesos mínimos e dualidade](https://arxiv.org/pdf/1811.00015) · [Justificativas anteriores para pesos 24 e 28](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/5c67796b51e99edaa8e735225d5a4b91e59adeb9/research_updates/2026_11_21_walsh_mod127/ENCURTAMENTO_GEOMETRICO_MOD127.md).

Usamos que se dois \(r\)-vetores têm suportes \(U_1,U_2\) cuja interseção tem dimensão no máximo \(r-2\), a soma tem suporte \(U_1+U_2\). As imagens das contrações ficam em \(\Lambda^{r-1}U_1\) e \(\Lambda^{r-1}U_2\), que têm interseção zero. Também vale a observação anterior de que um volume de um \(r\)-espaço que acrescenta duas ou mais dimensões ao suporte de um \(r\)-vetor soma seu próprio espaço ao suporte. Agora precisamos da seguinte versão para cinco volumes.

**Lema.** Se \(U_1,\ldots,U_5\) são 4-espaços com volumes não nulos \(\omega_1,\ldots,\omega_5\) e \(\sum_i\omega_i=0\), então \(\dim\sum_i U_i\le10\).

Se dois volumes coincidem, os três restantes têm soma zero. A soma de dois volumes só é um terceiro volume quando seus espaços compartilham três dimensões. As três direções restantes geram então um espaço de dimensão cinco, e o par repetido acrescenta no máximo quatro. Se dois volumes são distintos mas seus espaços compartilham três dimensões, combine-os em um único volume de suporte quatro. A relação de quatro volumes da nota anterior dá dimensão total no máximo oito após combinar. Restaurar as direções do par acrescenta no máximo uma dimensão.

Resta que todas as interseções entre pares tenham dimensão no máximo dois. Escreva \(\alpha=\omega_1+\omega_2\), \(\beta=\omega_3+\omega_4\). Seus suportes são \(A=U_1+U_2\) e \(B'=U_3+U_4\). O suporte \(U_5\) de \(\alpha+\beta\) está em \(A+B'\), de modo que \(D=\dim(A+B')\) é a dimensão procurada. O posto das contrações de \(\alpha+\beta\) já é pelo menos \(D-\dim A\) ao restringir os funcionais que anulam \(A\). Se \(D\ge11\), nenhum par pode ter interseção de dimensão dois, pois podemos escolhê-lo como o primeiro par e teríamos \(D-\dim A\ge5\), incompatível com o suporte 4 de \(\omega_5\).

Suponha, então, \(D\ge11\) e todas as interseções de pares de dimensão no máximo um. Para todo funcional \(l\) que anula \(B'\), \(\iota_l(\alpha+\beta)=\iota_l\alpha\). Se \(l\) fosse não nulo tanto em \(U_1\) como em \(U_2\), a última contração teria suporte de dimensão pelo menos cinco, sendo uma soma de dois volumes cúbicos com interseção de dimensão no máximo um. Uma contração de \(\omega_5\) tem suporte no máximo três. Os funcionais que anulam \(B'\) ficam, portanto, na união dos dois subespaços onde cada restrição individual se anula. Como constituem um espaço linear, estão inteiramente num deles. Se \(U_1\subset B'\), as restrições a \(U_2\) têm dimensão \(D-\dim B'\ge3\). Duas delas independentes dão dois suportes cúbicos que geram \(U_2\), logo \(U_5=U_2\). Isso já anularia o par de volumes iguais, que foi tratado acima. O outro caso é simétrico. A hipótese \(D\ge11\) é impossível.

### Aplicação às novas fatias

Para conjuntos \(S\) com momentos até ordem quatro nulos, cada suporte removido e o complemento têm momentos nulos até três. A tabela exibe as partições necessárias quando as avaliações afins têm dimensão \(k\) pelo menos a indicada. Os testes de Griesmer, Krawtchouk, pesos baixos e dimensão de suporte de ordem três verificam a lista no código abaixo. O último termo de cada partição é o complemento dos cortes feitos.

| \(|S|\) | \(k\) a excluir | Partições restantes |
|---:|---:|---|
| 76 | 15 | \(16+16+16+28,\ 24+24+28\) |
| 78 | 15 | \(16+16+16+30,\ 24+24+30\) |
| 80 | 16 | \(16+16+16+32\) |
| 82 | 15 | \(16+16+16+34,\ 24+24+34\) |
| 84 | 17 | \(16+16+16+36,\ 16+16+24+28\) |
| 86 | 17 | \(16+16+16+38,\ 16+16+24+30\) |
| 88 | 19 | \(16+16+16+40,\ 16+16+24+32\) |
| 90 | 17 | \(16+16+16+42,\ 16+16+24+34\) |
| 92 | 19 | \(16+16+16+44,\ 16+16+24+36,\ 16+24+24+28\) |

O momento exterior \(\mu_4(S)\) é zero. Sempre que o último conjunto da partição tem momento exterior de suporte pleno, sua direção fica contida na soma das direções dos outros blocos. Se os outros blocos têm dimensões \(b_1,\ldots,b_j\) e a dimensão da soma é pelo menos \(\sum b_i-2\), cada interseção ao adicionar um bloco tem dimensão no máximo dois. O momento exterior da soma tem então suporte pleno nessa soma das direções. A dimensão afim total é no máximo a dimensão das direções mais o número de blocos menos um.

- Nas partições \(16+16+16+u\) com \(u=28,30,34\), o último momento tem suporte menor que dez. Para \(u=34\) usamos a cota de posto afim nove de ordem três, verificada pela recorrência de Delsarte antes de introduzir estas novas cotas. As três primeiras direções, se gerassem ao menos dez dimensões, dariam momento exterior com esse suporte. Portanto geram no máximo nove, e \(\dim\operatorname{aff}S\le12\).
- Nas partições \(24+24+u\) com \(u=28,30,34\), o último momento tem suporte no máximo oito. As direções dos dois conjuntos de 24 não podem ser disjuntas, pois o momento teria suporte 12. Portanto a soma de direções tem dimensão no máximo onze e \(\dim\operatorname{aff}S\le13\).
- No peso 80, se o momento do bloco de 32 tem suporte pleno, ele tem suporte de dimensão no máximo nove pela cota anterior para ordem três, de modo que a dimensão afim total é no máximo 12. Se o suporte não é pleno, divida o bloco em dois 4-espaços afins. Somos então reduzidos a cinco volumes com soma zero. Pelo lema, as direções geram no máximo dez dimensões e \(\dim\operatorname{aff}S\le14\).
- Nas partições \(16+16+16+u\) com \(u=36,38,42\), o último momento tem suporte pleno, já contido em no máximo doze dimensões. Logo \(\dim\operatorname{aff}S\le15\). Nas partições \(16+16+24+u\) com \(u=28,30,34\), as direções dos três primeiros blocos têm dimensões \(4,4,6\). Se gerassem ao menos doze dimensões, seu momento teria suporte pleno de dimensão ao menos doze. O último momento tem suporte no máximo oito. Portanto as direções geram no máximo onze e \(\dim\operatorname{aff}S\le14\).
- Nas partições de peso 88, se o momento do último bloco tem suporte pleno, a dimensão afim total é no máximo \(4+4+6+3=17\). Senão, divida o último bloco em \(16+24\) ou \(16+16\), conforme seu peso. As duas partições ficam com quatro 4-espaços e um conjunto de 24 pontos. Se as quatro direções gerassem pelo menos 14 dimensões, seu momento teria suporte pleno, incompatível com o momento de suporte seis do conjunto de 24. Portanto geram no máximo 13, e \(\dim\operatorname{aff}S\le17\).
- Para \(16+16+16+44\), o último momento ou tem suporte pleno, dando dimensão afim até 15, ou o bloco se decompõe em \(16+28\). Nas quatro direções de 4-espaços, a mesma comparação exclui dimensão de direções 14 ou mais, agora com o momento de 28 pontos. Assim \(\dim\operatorname{aff}S\le17\). Para \(16+16+24+36\), o último momento tem suporte pleno e dimensão no máximo 12, pela cota de posto afim 13 de ordem três que o código confirma. Se os três primeiros gerassem pelo menos 13 dimensões teriam suporte pleno nessa soma, logo geram no máximo 12 e \(\dim\operatorname{aff}S\le15\). Em \(16+24+24+28\), as direções dos três primeiros de dimensões \(4,6,6\) geram no máximo 13, pois dimensão 14 ou mais daria suporte pleno, contra a cota sete de \(\mu_4\) em peso 28. Assim \(\dim\operatorname{aff}S\le16\).

Em cada linha a dimensão afim é menor que \(k-1\). Concluímos que, em pesos \(76,78,80,82,84,86,88,90,92\), as avaliações afins têm dimensão no máximo \(14,14,15,14,16,16,18,16,18\), respectivamente.

## 4. Restrição espectral com até três pontos em \(Q\)

Quando \(q\le3\), os pontos de \(Q\) são afimmente independentes. As quadráticas que se anulam em \(P\) avaliam no dual de \(C(Q)\), pelo lema dos momentos anterior. Como \(C(Q)=\mathbb F_2^Q\), elas se anulam em \(Q\). Para qualquer hiperplano afim \(H\), se uma forma afim \(l\) zera em \(P\cap H\), a quadrática \(\boldsymbol1_Hl\) zera em todo \(P\). Logo \(l\) também zera em \(Q\cap H\). Isso dá \(Q\cap H\subseteq\operatorname{aff}(P\cap H)\). No momento cúbico local, a normal a esse fecho afim anula a contração do símbolo quártico, e por isso o suporte dessa contração é no máximo \(\dim\operatorname{aff}(P\cap H)\). Para \(q>3\), usamos a cota anterior \(\dim\operatorname{aff}(P\cap H)+\max(0,\lfloor(|Q\cap H|-1)/2\rfloor)\). A mesma identidade de Gram anterior dá posto zero no espaço dos símbolos das quadráticas que zeram em \(P\) quando \(q\le3\). [Momentos locais, ortogonalidade e identidade de Gram](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b6a94b168a62fd31cc4286b4d838bc7fb1dda209/research_updates/2026_11_21_walsh_mod127/CORTES_E_POSTO_VALORACAO_TRES_MOD127.md).

O verificador usa essa cota e a lista de vieses possíveis da derivada cúbica descrita na prova anterior. Para cada união de blocos retirados do código de avaliações em \(P\), testa se existe uma distribuição de \(q\) pontos entre a união e o complementar cujo custo mínimo caiba nas massas permitidas pelas opções de autocorrelação. Exigir um testemunho local para cada união é condição necessária. O teste permite testemunhos diferentes para uniões diferentes. As cotas de Delsarte valem independentemente das massas.

O resultado exato da enumeração é o seguinte.

| \(N\) | Valores de \(q\) que passam pelas condições necessárias |
|---|---|
| 238 a 272, pares | nenhum |
| 274, 276 | 0, 1, 2, 3 |
| 278, 280, 282 | 0, 1, 2 |
| 284, 286 | 0, 1 |
| 288 | 0 |
| 290 | nenhum |

Em todos os perfis que passam, o teste de massa para um hiperplano individual exclui os pesos até 82. Junto à cota anterior 62 e à paridade, isso dá \(d(C(P))\ge84\).

## 5. Verificação inteira

O código reproduz a enumeração usando somente a biblioteca padrão de Python. Uma resposta positiva de qualquer teste significa que as condições correspondentes são compatíveis, e não fornece uma construção.

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

def krawtchouk_product(n, roots):
    # roots are in the weight variable; factors are (n-2*w)-(n-2*root).
    coefficients = [1]
    for root in roots:
        y_root = n - 2 * root
        updated = [0] * (len(coefficients) + 1)
        for i, coefficient in enumerate(coefficients):
            updated[i] -= y_root * coefficient
            updated[i + 1] += (i + 1) * coefficient
            if i:
                updated[i - 1] += (n - i + 1) * coefficient
        coefficients = updated
    return coefficients

@cache
def polynomial_bound(n, d):
    best = None

    def consider(roots):
        nonlocal best
        coefficients = krawtchouk_product(n, roots)
        denominator = coefficients[0]
        if denominator <= 0 or min(coefficients) < 0:
            return
        numerator = 1
        for root in roots:
            numerator *= 2 * root
        if best is None or numerator * best[1] < best[0] * denominator:
            best = numerator, denominator
    consider((d,))
    for power in range(5):
        consider((n, d, n-d) + (n//2,) * (2 * power))
    limit = min(n - 1, n//2 + 60)
    for r in range(d, limit, 2):
        consider((d, r, r+2))
        for s in range(r, limit, 2):
            consider((d, r, r+2, s, s+2))
    return best

def can_have_distance(n, k, d):
    if griesmer(k, d) > n:
        return False
    if 2*d == n and n % (1 << (k-1)):
        return False
    bound = polynomial_bound(n, d)
    return bound is None or (1 << k) * bound[1] <= bound[0]

@cache
def enhanced(t, n, k, d):
    if n == 0:
        return k <= 0
    if k <= 1:
        return n >= d and allowed_weight(t-1, n)
    if not admissible(t, n, k, d):
        return False
    for w in range(d, n//2 + 1, 2):
        if griesmer(k, w) > n:
            break
        if not allowed_weight(t-1, n-w):
            continue
        loss = rank_cap(t-1, w)
        if (loss and admissible(t, n-w, k-loss, w)
                and can_have_distance(n, k, w)
                and enhanced(t, n-w, k-loss, w)):
            return True
    return False

@cache
def rank_cap(t, n):
    if not n or not allowed_weight(t, n):
        return 0
    special = NEW_RANK.get((t, n), SMALL_RANK.get(t, {}).get(n))
    if special is not None:
        return special
    if t == 2:
        return n // 2
    for k in range(affine_rank_cap(t, n), 0, -1):
        if enhanced(t, n, k, 1 << t):
            return k
    return 0

def geometric_chains(n, k, lower=16, prefix=()):
    if n == 0 or k <= 1 or len(prefix) == 3:
        return {prefix + (n,)} if n == 0 or n >= lower else set()
    result = set()
    for w in range(lower, n//2 + 1, 2):
        if griesmer(k, w) > n:
            break
        loss = rank_cap(3, w)
        if loss and allowed_weight(3, n-w) and can_have_distance(n, k, w):
            result.update(geometric_chains(n-w, k-loss, w, prefix+(w,)))
    return result

def previous_second_weights(first):
    n = 238-first
    k = 33-affine_rank_cap(4,first)
    return [w for w in range(first,n+1,2)
            if griesmer(k,w) <= n and affine_rank_cap(4,w)
            and admissible(5,n-w,k-affine_rank_cap(4,w),w)]

assert previous_second_weights(62) == previous_second_weights(64) == [80]
for n, roots, constant in (
    (176,(80,92,94,110,112),3_232_768),
    (174,(80,92,94,134,136),9_361_312),
):
    coefficients = krawtchouk_product(n,roots)
    assert min(coefficients) >= 0 and coefficients[0] == constant

assert cutting_chains(4,76,15,16,stop_at=((24,24),)) == {
    ((16,16,16),28), ((24,24),28)}
assert cutting_chains(4,78,15,16,stop_at=((24,24),)) == {
    ((16,16,16),30), ((24,24),30)}
assert rank_cap(3, 34) <= 9
assert rank_cap(3, 36) <= 13
assert geometric_chains(80,16) == {(16,16,16,32)}
assert geometric_chains(82,15) == {(16,16,16,34),(24,24,34)}
assert geometric_chains(84,17) == {(16,16,16,36),(16,16,24,28)}
assert geometric_chains(86,17) == {(16,16,16,38),(16,16,24,30)}
assert geometric_chains(88,19) == {(16,16,16,40),(16,16,24,32)}
assert geometric_chains(90,17) == {(16,16,16,42),(16,16,24,34)}
assert geometric_chains(92,19) == {(16,16,16,44),(16,16,24,36),
                                   (16,24,24,28)}
NEW_RANK.update({(4,76):14, (4,78):14, (4,80):15, (4,82):14,
                 (4,84):16, (4,86):16, (4,88):18, (4,90):16,
                 (4,92):18})
affine_rank_cap.cache_clear()
admissible.cache_clear()
rank_cap.cache_clear()
enhanced.cache_clear()

@cache
def fits_local(n, q, w):
    if w == n:
        return True
    w = min(w,n-w)
    rank = rank_cap(4,w)
    if w < 62 or not rank:
        return False
    for s in range(q+1):
        extension = 0 if q <= 3 else max(0,(s-1)//2)
        controls = rank-1+extension
        lower = 2*(C3*w+C4*s)-B
        upper = B-2*(C3*(n-w)+C4*(q-s))
        if any(lower <= sign*m+e <= upper
               for m in nonnegative_delta_masses(controls)
               for sign in (-1,1) for e in (-E,E)):
            return True
    return False

@cache
def global_allowed(N, q, n, k, lower, sizes=()):
    if n == 0:
        return k <= 0
    if not fits_local(N,q,n):
        return False
    if k <= 1:
        return n >= lower and allowed_weight(4,n)
    if not enhanced(5,n,k,lower):
        return False
    for w in range(lower,n//2+1,2):
        if griesmer(k,w)>n:
            break
        loss = rank_cap(4,w)
        if not loss or not allowed_weight(4,n-w) or not can_have_distance(n,k,w):
            continue
        union_sizes = {w}
        for size in sizes:
            union_sizes |= {x+size for x in union_sizes}
        if (all(fits_local(N,q,x) for x in union_sizes)
                and global_allowed(N,q,n-w,k-loss,w,sizes+(w,))):
            return True
    return False

def allowed_qs(n):
    return [q for q in range((B-C3*n)//C4+1)
            if global_allowed(n,q,n,33,62)]

assert all(not allowed_qs(n) for n in range(238,274,2))
expected = {
    274: [0,1,2,3], 276: [0,1,2,3], 278: [0,1,2],
    280: [0,1,2], 282: [0,1,2], 284: [0,1], 286: [0,1],
    288: [0], 290: [],
}
assert {n: allowed_qs(n) for n in expected} == expected
assert not any(fits_local(n,q,w)
               for n, vals in expected.items() for q in vals
               for w in range(62,84,2))
assert (B-274*C3)//C4 == 4
assert max(max(vals) for vals in expected.values() if vals) == 3
print("N in {274,276,278,280,282,284,286,288}, q <= 3, d(C(P)) >= 84")
~~~~

A valoração três segue aberta nos oito tamanhos pares de 274 a 288. As valorações mínimas zero, um e dois também seguem abertas no ramo global.
