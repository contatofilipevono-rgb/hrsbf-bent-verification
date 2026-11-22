# Fechamento do ramo de valoração mínima três módulo 127

Seja \(f:\mathbb F_2^{32}\to\mathbb F_2\) de grau no máximo quatro, no ramo global
\[
W_f(b)=-512+2^{17}k(b),\qquad k(b)\bmod127\in\{0,1\}.
\]
Ponha \(T(b)=k(b)(k(b)-1)/2\). Provamos que a menor valoração dos valores não nulos de \(T\) **não pode ser três**. Esta nota usa os limites de [árvore de encurtamento de R19](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/be3964511c9220891daca44cf88caa43532c1ea9/research_updates/2026_11_21_walsh_mod127/VALORACAO_TRES_DELSARTE_MOD127.md) e acrescenta uma cota de energia para a célula de codimensão dois que fica fora das três fatias de \(P\).

## 1. Energia mínima numa célula sem pontos com \(32\nmid T\)

Para um conjunto espectral \(J\), defina a energia normalizada
\[
\mathcal E(J)=2^{-64}\sum_{b\in J}W_f(b)^2.
\]
Se \(J\) é um subespaço afim de codimensão dois e \(32\mid T\) em todo \(J\), afirmamos que
\[
\mathcal E(J)>\frac{5}{128},\qquad \sum_{b\in J}T(b)>18\,866\,304.                 \tag{1}
\]
As duas cotas valem em todo o ramo global, em qualquer valoração mínima.

Escolha duas formas afins \(\ell_1,\ell_2\) de partes lineares \(v,w\) cujo produto de bits é o indicador de \(J\). A identidade de momentos de ordem quatro é
\[
\sum_b T(b)\ell_1(b)\ell_2(b)\ell_3(b)\ell_4(b)
\equiv 16 [f]_4(v,w,v_3,v_4)\pmod {32}.
\]
Ela segue tomando diferenças da congruência \(\widehat T(x)\equiv128+256f(x)\pmod{512}\); na expansão afim, os momentos inferiores zeram módulo 32. A hipótese sobre \(J\) dá \(\iota_{v,w}[f]_4=0\). Logo a segunda derivada \(D_vD_wf\) tem grau no máximo um e é periódica nas direções \(v,w\). [Identidades de momentos e de autocorrelação](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b6a94b168a62fd31cc4286b4d838bc7fb1dda209/research_updates/2026_11_21_walsh_mod127/CORTES_E_POSTO_VALORACAO_TRES_MOD127.md).

Escreva o espaço físico como \(\langle v,w\rangle\oplus V'\), com \(\dim V'=30\), e ponha
\[
f(x,y)=F(y)+x_1g_1(y)+x_2g_2(y)+x_1x_2 h(y)
\]
em coordenadas \(x\) na primeira parcela e \(y\) na segunda. Aqui \(g_1,g_2\) têm grau no máximo três e \(h=D_vD_w f\) é afim em \(y\). Seja \(\alpha\in\mathbb F_2^2\) a frequência em \(x\) de \(J\). Por Parseval em \(V'\), a energia em \(J\) é a média em \(y\) do quadrado do coeficiente parcial normalizado
\[
F_{\alpha}(y)=\frac14\sum_{x\in\mathbb F_2^2}(-1)^{f(x,y)+\alpha\cdot x}.
\]
Se \(h\) é não nula, há pelo menos metade dos \(y\) com \(h=1\). Suas restrições em \(x\) são quadráticas bent em duas variáveis e contribuem \(1/4\) para cada quadrado parcial. Então \(\mathcal E(J)\ge1/8\).

Se \(h=0\), vale \(F_\alpha^2=I_\alpha=(1+g_1+\alpha_1)(1+g_2+\alpha_2)\) como função binária, de grau no máximo seis em 30 variáveis. Assim \(2^{30}\mathcal E(J)\) é o peso de \(I_\alpha\). Como \(W_f(b)^2\equiv16\bmod127\),
\[
\operatorname{wt}(I_\alpha)=2^{-34}\sum_{b\in J}W_f(b)^2\equiv1\pmod{127}.
\]
A potência de dois no denominador é invertível módulo 127. O peso mínimo não nulo de \(\mathrm{RM}(6,30)\) é \(D=2^{24}\). Entre zero e \(5D/2\), os pesos de Kasami–Tokura–Azumi, incluindo os pontos de fronteira, ficam nas famílias
\[
0,\ 2D,\ 5D/2,\ 2D-2^j,\ 2D+2^j,\ 5D/2-2^j,\ 5D/2-6\cdot2^j
\]
com os intervalos de expoentes próprios da classificação. Módulo 127, \(2D\equiv16\), \(5D/2\equiv20\). Para um peso dessas quatro últimas famílias ser um módulo 127, seria necessário que uma potência de dois fosse \(15,\ 112,\ 19\) ou \(109\), respectivamente. Nenhum pertence a \(\{1,2,4,8,16,32,64\}\). Os três pontos de fronteira também são incompatíveis. Logo \(\operatorname{wt}(I_\alpha)>5D/2\), provando a primeira parte de (1). [Kasami–Tokura–Azumi, fórmulas nos Lemas 3 e 4 de Krotov](https://arxiv.org/pdf/1811.00015).

Poisson na direção de \(J\) dá \(\sum_{b\in J}k(b)\le2^{22}+2^{15}\), pois a soma parcial de sinais tem quatro termos. A expressão \(W_f(b)=2^{17}(k(b)-1/256)\) dá
\[
2^{30}\mathcal E(J)=2\sum_{b\in J}T(b)+\frac{127}{128}\sum_{b\in J}k(b)+2^{14}.
\]
Logo \(\sum_{b\in J}T(b)>(5\cdot2^{23}-4\,210\,432)/2=18\,866\,304\), completando a prova de (1).

## 2. Partição em três cortes e custos inteiros

Suponha a valoração mínima três e escreva \(P=\{\nu_2(T)=3\}\), \(Q=\{T\equiv16\bmod32\}\), \(N=|P|\), \(q=|Q|\). R19 dá \(N\) par entre 274 e 288, \(q\le3\), \(\dim\operatorname{aff}P=32\) e \(d(C(P))\ge84\), onde \(C(P)\) é o código das avaliações afins. No encurtamento, cada suporte retirado é um corte afim de \(P\); o complemento dos cortes retirados também é um corte, pois sua palavra é a constante um mais a soma dos suportes retirados. A recorrência reproduzida no apêndice verifica que toda partição necessária nessa faixa tem três blocos. O limite \(N\le288<4\cdot84\) já impede quatro blocos não vazios.

Para tal partição escreva \(P_i=P\cap H_i\), com \(H_i\) hiperplanos afins, \(i=1,2,3\). Se \(u_i\) é o indicador afim binário de \(H_i\), então \(u_1+u_2+u_3=1\) em \(P\). Pela dimensão afim plena de \(P\), a identidade vale no espaço espectral inteiro. As partes lineares dos dois primeiros indicadores são não nulas e distintas, pois os dois suportes são disjuntos e há um terceiro bloco não vazio. Surgem quatro células de codimensão dois, com padrões \(100,010,001,111\). A célula \(J\) de padrão \(111\) não encontra \(P\). O produto \(u_1u_2\) é uma quadrática que zera em \(P\). Como \(q\le3\), R19 mostra que toda quadrática que zera em \(P\) zera também em \(Q\). Portanto \(J\cap Q=\varnothing\), e (1) se aplica. Os pontos de \(Q\) passam a se distribuir pelas três células exclusivas.

Ponha \(L=T/(8\cdot127)\), inteiro pois \(k(k-1)\) é múltiplo de 127 e a valoração mínima é três. Os custos mínimos para \(P,Q\) em unidades de \(T\) são \(c_3=1\,813\,560\) e \(c_4=7\,748\,016\), e \(\sum_b T\le B=528\,531\,328\). Como \(N\ge274\), qualquer ponto fora de \(P\) custa no máximo \(B-274c_3=31\,615\,888\); cada ponto de \(P\) custa no máximo \(B-273c_3\). Os valores possíveis de \(k\) estão em \([-32768,32768]\), pela cota trivial \(|W_f|\le 2^{32}\). Conferindo \(k\bmod127\in\{0,1\}\) e os limites de custo, o catálogo de \(L\) é

| Conjunto | Custos inteiros \(L\) permitidos pelo orçamento |
|---|---|
| \(P\) | \(1785,2031,2033,2295,17531,18285,18291,19061\) |
| \(Q\) | \(7626,8126,8130,8646\) |
| Fora de \(P\cup Q\) | \(0,8\) |

Em particular a massa de \(L\) na célula \(J\) é múltipla de oito e, por (1), vale pelo menos \(8\cdot2322\). A massa total \(b=\sum L\) é \(520208\) ou \(520176\), pela identidade exata \(\sum T=528515072-16256(-1)^{f(0)}\).

Sejam \(w_i=|P_i|\), \(s_i=|Q\cap H_i|\) e \(m_i=\sum_{b'\in H_i}L(b')\). As fórmulas de Fourier para o custo dão
\[
2m_i=b\mathbin{\pm}\frac{|\Delta_f(v_i)|}{8\cdot1016}\mathbin{\pm}16 ,
\]
onde \(v_i\) é a normal física de \(H_i\); permitir os sinais independentemente só relaxa as condições necessárias. Como \(q\le3\), o suporte da contração cúbica na direção \(v_i\) está em no máximo \(\dim\operatorname{aff}(P\cap H_i)\) formas lineares, conforme R19. Isso permite usar as mesmas listas discretas de opções para \(|\Delta_f(v_i)|/8\).

A soma das massas dos três hiperplanos conta cada célula exclusiva uma vez e \(J\) três vezes. Logo a massa de \(L\) em \(J\) é \(e=(m_1+m_2+m_3-b)/2\). A massa da célula exclusiva \(i\) é \(m_i-e\). O verificador exige \(e\ge8\cdot2322\) e \(8\mid e\), e verifica se cada massa exclusiva comporta \(w_i\) pontos de \(P\) e \(s_i\) de \(Q\), com \(\sum s_i=q\). Para cada resto módulo oito, calcula o menor custo de \(w_i\) pontos de \(P\) e \(s_i\) de \(Q\) no catálogo. Os demais custos são somas de oitos e zeros. Usar apenas o mínimo por resto permite testemunhos que podem não ser realizáveis, o que preserva todas as exclusões.

Com os limites geométricos de R19, resta somente
\[
(N,q)=(278,0),\qquad (w_1,w_2,w_3)=(88,88,102).
\]

## 3. A cota geométrica final em 88 pontos

Se \(S\) tem 88 pontos e momentos nulos até ordem quatro, provamos que \(\dim C(S)\le17\). A recorrência de R19, iniciada com dimensão pelo menos 18, deixa as partições \(16+16+16+40\) e \(16+16+24+32\), confirmadas pelo verificador. Os blocos têm momentos nulos até ordem três. Denote seus momentos exteriores de ordem quatro por \(\mu_4\); a soma desses momentos é zero.

Se o último bloco tem \(\mu_4\) de suporte pleno, sua direção está na soma das direções dos três primeiros. Nas duas partições isso dá dimensão afim total até 15 e 17, respectivamente. Na segunda partição podemos melhorar: os três primeiros têm dimensões de direções \(4,4,6\). Se sua soma tivesse dimensão pelo menos 12, cada interseção ao acrescentar o bloco seguinte teria dimensão no máximo dois, pois a perda total é no máximo dois. A soma dos momentos teria suporte pleno de dimensão pelo menos 12. Isso contradiz a cota de dimensão afim nove para o conjunto de 32 pontos de ordem três. Portanto na segunda partição a dimensão afim total é no máximo 14.

Se o último bloco tem momento de suporte não pleno, R19 permite dividi-lo em \(16+24\) quando tem peso 40 e em \(16+16\) quando tem peso 32. Ambas as partições viram quatro 4-espaços afins e um bloco de 24 pontos. Este último tem \(\mu_4\) de suporte pleno de dimensão seis. Escreva \(\omega_i\) para os volumes de direção dos quatro 4-espaços. A direção do bloco de 24 está no suporte de \(\gamma=\omega_1+\cdots+\omega_4\), e esse suporte tem dimensão seis. Mostramos que as direções dos quatro 4-espaços geram no máximo 12 dimensões.

Se há um par repetido, o par restante tem soma com suporte seis. Suas direções geram seis dimensões, pois seu par tem interseção de dimensão dois. O par repetido acrescenta no máximo quatro. Se duas direções distintas se intersectam em dimensão três, a soma de seus volumes é um único volume num 4-espaço. Combine o par. Se os três espaços resultantes gerassem pelo menos dez dimensões, cada adição de um espaço acrescentaria pelo menos duas dimensões, e a soma dos três volumes teria suporte pleno nessa soma. Isso é incompatível com o suporte seis. Restaurar o par acrescenta no máximo uma dimensão, deixando a cota dez.

Nos demais casos, separe os volumes em dois pares. As somas de pares têm suporte pleno nos espaços \(A\) e \(B'\) gerados pelos respectivos pares, de dimensões no máximo oito. Suponha \(D=\dim(A+B')\ge13\). A contração de \(\gamma\) restrita aos funcionais que anulam \(A\) tem imagem de dimensão \(D-\dim A\ge5\) em \(\Lambda^3B'\), pois o segundo par tem suporte pleno em \(B'\). Reciprocamente, anular \(B'\) dá imagem de dimensão \(D-\dim B'\ge5\) em \(\Lambda^3A\). A interseção dessas imagens está em \(\Lambda^3(A\cap B')\), de dimensão no máximo um, pois \(\dim(A\cap B')\le3\). O posto de contração de \(\gamma\) seria ao menos \(5+5-1=9\), contra seis. Assim as direções geram no máximo 12. Com as diferenças de origem dos cinco blocos, \(\dim\operatorname{aff}S\le12+4=16\).

Finalmente, num suporte \(P\) de 278 pontos com corte mínimo de 88, encurtar no primeiro corte deixaria código de comprimento 190 e dimensão pelo menos \(33-17=16\). A distância mínima continuaria pelo menos 88 e a palavra constante um seria preservada. Use \(y=190-2w\) e o certificado de Delsarte
\[
F(y)=(y+190)(y^2-14^2)y^2.
\]
O polinômio é não positivo nos pesos não nulos permitidos, tem coeficientes de Krawtchouk não negativos e coeficiente constante \(13\,429\,200\). Como \(F(190)=492\,531\,072\,000<2^{16}\cdot13\,429\,200\), o código é impossível. Isso exclui o último perfil e fecha a valoração mínima três.

## 4. Verificador

Extraia este bloco Python e passe como argumento o caminho da nota de R19 ligada acima. O código confere seu SHA-256 antes de carregar a enumeração-base, executa o teste conjunto ainda com a cota antiga em 88 pontos, verifica o certificado final e repete a enumeração com a nova cota. Ele usa apenas a biblioteca padrão de Python.

~~~~python
from functools import cache
from fractions import Fraction
from hashlib import sha256
from itertools import product
from pathlib import Path
import sys

base_path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(
    "VALORACAO_TRES_DELSARTE_MOD127.md")
base_bytes = base_path.read_bytes()
assert sha256(base_bytes).hexdigest() == (
    "78ec7cde5cbb77a771a596fbd18c5566b5d5cbe66ee923ee362ba22681d9eb26"
)
base_code = base_bytes.decode().split("~~~~python\n", 1)[1].split("\n~~~~", 1)[0]
exec(compile(base_code, str(base_path), "exec"))

UNIT = 8 * 127
CHEAP = 8128
P_COST = (1785, 2031, 2033, 2295, 17531, 18285, 18291, 19061)
Q_COST = (7626, 8126, 8130, 8646)
TOTALS = (B//UNIT, B//UNIT-32)

# At N >= 274, every nonzero cost outside P and Q is 8128.
catalogue = {i: set() for i in range(3, 16)}
slack = B - 274*C3
for k in range(-32768, 32770):
    if k in (0, 1) or k % 127 not in (0, 1):
        continue
    cost = k*(k-1)//2
    valuation = (cost & -cost).bit_length() - 1
    if valuation >= 3 and cost <= slack + (C3 if valuation == 3 else 0):
        assert cost % UNIT == 0
        catalogue[valuation].add(cost//UNIT)
assert catalogue[3] == set(P_COST)
assert catalogue[4] == set(Q_COST)
assert set().union(*(catalogue[i] for i in range(5, 16))) == {8}
assert TOTALS == (520208, 520176)

powers = {pow(2,j,127) for j in range(7)}
assert 1 not in {0, 16, 20} | {((16-e)%127) for e in powers}
assert all((16+e)%127 != 1 and (20-e)%127 != 1
           and (20-6*e)%127 != 1 for e in powers)
base_energy = Fraction(127,128)*((1<<22)+(1<<15))+(1<<14)
empty_cost_bound = (5*(1<<23)-base_energy)/2
assert empty_cost_bound == 18_866_304
EMPTY_MIN = empty_cost_bound // CHEAP + 1
assert EMPTY_MIN == 2322

@cache
def partitions(root_n,q,n,k,d,prefix=()):
    if n == 0:
        return {prefix} if k <= 0 else set()
    if not fits_local(root_n,q,n):
        return set()
    if k <= 1:
        return {prefix+(n,)} if n >= d and allowed_weight(4,n) else set()
    if not enhanced(5,n,k,d):
        return set()
    result = set()
    for w in range(d,n//2+1,2):
        loss = rank_cap(4,w)
        if (loss and can_have_distance(n,k,w) and allowed_weight(4,n-w)
                and fits_local(root_n,q,w)):
            result.update(partitions(root_n,q,n-w,k-loss,w,prefix+(w,)))
    return result

@cache
def minimum_sums(w,s):
    minima = [0]+[None]*7
    for menu,count in ((P_COST,w),(Q_COST,s)):
        for _ in range(count):
            next_minima = [None]*8
            for current in minima:
                if current is None:
                    continue
                for cost in menu:
                    value = current+cost
                    residue = value%8
                    if next_minima[residue] is None or value < next_minima[residue]:
                        next_minima[residue] = value
            minima = next_minima
    return minima

@cache
def possible_masses(total,w,s):
    controls = rank_cap(4,w)-1
    lower = w*P_COST[0]+s*Q_COST[0]
    masses = set()
    for delta in nonnegative_delta_masses(controls):
        assert delta%UNIT == 0
        for sign, correction in product((-1,1),(-16,16)):
            doubled = total+sign*(delta//UNIT)+correction
            assert doubled%2 == 0
            if doubled//2 >= lower:
                masses.add(doubled//2)
    return sorted(masses)

def joint(profile,q):
    assert len(profile) == 3, profile
    for q1 in range(q+1):
        for q2 in range(q-q1+1):
            counts = (q1,q2,q-q1-q2)
            base = [w*P_COST[0]+s*Q_COST[0] for w,s in zip(profile,counts)]
            minima = [minimum_sums(w,s) for w,s in zip(profile,counts)]
            for total in TOTALS:
                slack = total-sum(base)
                if slack < EMPTY_MIN*8:
                    continue
                lists = [[m for m in possible_masses(total,w,s) if m <= slack+b]
                         for w,s,b in zip(profile,counts,base)]
                for a,b,c in product(*lists):
                    excess = a+b+c-total
                    if excess < 16*EMPTY_MIN or excess % 16:
                        continue
                    empty = excess//2
                    cells = (a-empty,b-empty,c-empty)
                    if all(m[x%8] is not None and x >= m[x%8]
                           for m,x in zip(minima,cells)):
                        return True
    return False

def surviving_profiles():
    return {(n,q,p)
            for n in range(274,289,2)
            for q in expected[n]
            for p in partitions(n,q,n,33,84)
            if joint(p,q)}

assert surviving_profiles() == {(278,0,(88,88,102))}
assert geometric_chains(88,18) == {(16,16,16,40),(16,16,24,32)}
coefficients = krawtchouk_product(190,(190,88,102,95,95))
assert coefficients[0] == 13_429_200 and min(coefficients) >= 0
assert 492_531_072_000 < (1<<16)*coefficients[0]
# Re-run the entire finite filter with the geometric bound rank C(S_88) <= 17.
NEW_RANK[4,88] = 17
for fn in (affine_rank_cap,admissible,rank_cap,enhanced,fits_local,
           partitions,possible_masses):
    fn.cache_clear()
assert not surviving_profiles()
print("Fechado: menor valoracao nao nula de T igual a tres.")
~~~~

O ramo global permanece aberto nas valorações mínimas zero, um e dois. A cota (1) independe da valoração mínima e fica disponível para esses casos.
