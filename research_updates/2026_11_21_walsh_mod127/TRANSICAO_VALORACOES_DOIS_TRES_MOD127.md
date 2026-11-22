# Transição entre os níveis dois e três no ramo global módulo 127

Seja \(f:\mathbb F_2^{32}\to\mathbb F_2\) de grau no máximo quatro com \(W_f=-512+2^{17}k\) e \(k\bmod127\in\{0,1\}\). Escreva \(T=k(k-1)/2\) e suponha que sua menor valoração não nula seja dois. Defina \(P_j=\{b:\nu_2(T(b))=j\}\), \(Q=P_4\), \(s=\dim\operatorname{aff}P_2\) e \(s'=\dim\operatorname{aff}(P_2\cup P_3)\).

**Resultado.** Se \(7\le s\le15\), então \(s'=32\). Os seguintes limites para a cardinalidade do nível três são necessários.

| \(s\) | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| \(\lvert P_3\rvert\) pelo menos | 160 | 159 | 158 | 156 | 152 | 144 | 128 | 127 | 126 |

O resultado exclui a possibilidade de acomodar os dois primeiros níveis em um espaço afim próprio quando o primeiro suporte tem dimensão pequena. O caso de menor valoração dois continua aberto.

## 1. A projeção do segundo nível tem restrições de código

Seja \(D\subseteq\mathbb F_2^{P_3}\) o código das avaliações em \(P_3\) de todas as formas afins que se anulam em \(P_2\). A dimensão do espaço dessas formas é \(32-s\), e seu núcleo ao avaliar em \(P_3\) tem dimensão \(32-s'\), pois os elementos do núcleo se anulam em \(P_2\cup P_3\). Logo \(\dim D=s'-s\).

O suporte \(A\subseteq P_3\) de qualquer palavra não nula de \(D\) tem momentos binários nulos até ordem quatro. De fato, escreva essa palavra como avaliação de \(\ell\), que se anula em \(P_2\). Para um produto \(M\) de no máximo quatro formas afins binárias, as diferenças iteradas da congruência \(\widehat T(v)\equiv128+256 f(v)\pmod{512}\) dão

\[
\sum_b T(b)\ell(b)M(b)\equiv0\pmod{16}.
\]

A ordem total é no máximo cinco. Para ordem cinco, a diferença de \(f\) é par pelo grau quatro, por isso ainda se obtém o fator 16 depois de dividir por \(2^5\). Para ordens menores o fator 16 já vem da divisão da congruência correspondente. As constantes nos fatores seguem por expansão afim. Como o primeiro fator se anula em \(P_2\), todos os termos em que ele não zera têm custo divisível por oito. Dividir por oito e reduzir módulo dois deixa precisamente \(\sum_{b\in A}M(b)\).

Portanto \(D\) tem distância pelo menos 32 e palavras de peso par. Ao encurtar em uma palavra de peso mínimo \(w\), perde-se no máximo a dimensão do código de todas as avaliações afins de um conjunto de \(w\) pontos com momentos nulos até ordem quatro. O limite para essa perda é calculado por R19. A distância dos códigos encurtados não diminui, e suas palavras se levantam ao código original prolongando com zeros nos suportes retirados. Para o código \(D\), usamos Griesmer sem impor a propriedade da palavra constante. O verificador abaixo implementa a recorrência

\[
F(n,k,d)=
\bigvee_{\substack{w\ge d\ {\rm par}\\ G(k,w)\le n\\ r_4(w)>0}}
F(n-w,k-r_4(w),w),
\]

com \(F(n,k,d)\) verdadeiro para \(k\le0\). Aqui \(r_4(w)\) é o limite de R19 para a dimensão de avaliações afins e \(G\) é a soma de Griesmer. Assim \(|P_3|\ge L(s'-s)\), onde \(L(d)\) é o primeiro \(n\) aceito pela recorrência. Os valores \(L(0),\ldots,L(25)\) são verificados no apêndice. [R19 e limites de dimensão para suportes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/be3964511c9220891daca44cf88caa43532c1ea9/research_updates/2026_11_21_walsh_mod127/VALORACAO_TRES_DELSARTE_MOD127.md).

## 2. Exclusão de \(s'\le30\)

Ponha \(U=(\operatorname{dir}\operatorname{aff}(P_2\cup P_3))^\perp\), \(u=32-s'\), \(R=(\operatorname{dir}\operatorname{aff}Q)^\perp\) e \(r=\dim R\). Quando \(s'\le30\), o argumento dos cortes espectrais dá \(r\le1\) e \(|Q|\ge \max(42-r,27)\). Em particular, \(Q\) é não vazio. A cota de Gram relativa dá ainda

\[
|Q|\ge65-s'-r+\rho_U,\qquad
\rho_U=\operatorname{rank}\bigl(B_a|_{U\wedge V}\bigr),
\]

onde \(a=[f]_4\). Usamos \(\rho_U\ge8\) se \(u>16\), \(\rho_U\ge4\) se \(u>8\) e a cota trivial nos demais casos. Para \(u>8\), a cobertura por oito monômios disjuntos tem um monômio com ao menos dois índices em \(U\). Sua avaliação dá quatro pares cruzados com Gram não degenerada. Para \(u>16\), há ao menos três índices em \(U\) em algum monômio da cobertura, dando posto pelo menos seis. O caso de posto seis permitiria, em base adaptada, cobrir no máximo onze índices de \(U\), pela descrição de posto seis. Como o posto é par, segue posto pelo menos oito. [Cortes espectrais](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/059b5c742ff2e67663a42d6b0cb6f22322cf81f5/research_updates/2026_11_21_walsh_mod127/CORTES_ESPECTRAIS_DIMENSAO_31_MOD127.md) · [Cota de Gram e cobertura no caso de posto seis](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md).

Escreva \(c_2=394716\), \(c_3=1813560\), \(c_4=7748016\), \(B=528531328\) e \(F=3\cdot2^{26}+16256\). O limite de massa no fecho afim de \(Q\) e o orçamento total requerem

\[
|Q|\le \min\!\left(
\left\lfloor\frac{F+2^{-r}(B-F)}{c_4}\right\rfloor,
\left\lfloor\frac{B-c_2 |P_2|-c_3 L(s'-s)}{c_4}\right\rfloor
\right).
\]

Para \(s=7\), temos \(|P_2|\ge128\). Para \(8\le s\le14\), temos \(|P_2|\ge192\), pois o peso mínimo é 128 e seu suporte é um 7-espaço afim. Para \(s=15\), temos \(|P_2|\ge256\), porque a classificação de pesos abaixo de dois mínimos para um conjunto com momentos nulos até ordem seis dá fecho afim de dimensão no máximo 14. O apêndice usa esses limites e elimina todos os \(s'\le30\) com \(7\le s\le15\) e \(r\in\{0,1\}\). [Massa no fecho afim](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/dcb2f41901844379880f0efa2fb9aefc1fe50a6e/research_updates/2026_11_21_walsh_mod127/AUTOCORRELACAO_E_DIMENSAO_AFIM_MOD127.md) · [Formas normais de peso baixo](https://arxiv.org/pdf/1811.00015).

## 3. Exclusão de \(s'=31\) e critério de massa geral

Mais geralmente, em qualquer ramo de valoração mínima do caso global, se

\[
M_0=\sum_{16\nmid T(b)}T(b)>B-30c_4=296090848,
\]

então o suporte \(\{b:16\nmid T(b)\}\) tem fecho afim pleno. O orçamento dá \(|Q|\le29\). A dimensão até 30 implicaria \(r\le1\) e \(|Q|\ge41\), que é impossível. Para dimensão 31, seja \(v\ne0\) a normal ao fecho afim. O corte oposto \(Q_v\) de \(Q\) tem momentos até ordem dois nulos e seu momento de ordem três é \(\iota_v a\). Seu código de avaliações afins é auto-ortogonal, logo tem dimensão no máximo \(\lfloor |Q_v|/2\rfloor\le14\). O símbolo da derivada \(f(x)+f(x+v)\) fica assim apoiado em no máximo treze formas lineares. Com essa dimensão, as restrições aritméticas de autocorrelação verificadas em R19 dão \(\Delta_f(v)=0\). Pela identidade \(\widehat T(v)=\Delta_f(v)/8-16256(-1)^{f(v)}\), a massa em cada metade é no máximo \((B+16256)/2=264273792\), abaixo de \(M_0\). Como todos os pontos de \(16\nmid T\) estão em uma metade, isso é uma contradição. [Identidade e momento de ordem três no corte](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/059b5c742ff2e67663a42d6b0cb6f22322cf81f5/research_updates/2026_11_21_walsh_mod127/CORTES_ESPECTRAIS_DIMENSAO_31_MOD127.md) · [Autocorrelação e dimensão do símbolo cúbico](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b6a94b168a62fd31cc4286b4d838bc7fb1dda209/research_updates/2026_11_21_walsh_mod127/CORTES_E_POSTO_VALORACAO_TRES_MOD127.md).

Se \(s'=31\) no caso de valoração mínima dois, então \(M_0\ge c_2|P_2|+c_3 L(31-s)\). Para \(7\le s\le15\), os limites da seção 2 dão \(M_0>B-30c_4\) em todos os casos. Logo \(s'=31\) é impossível. Assim \(s'=32\), e \(L(32-s)\) dá a linha da tabela inicial.

## Apêndice. Verificador

Execute o código abaixo com \(\texttt{python3}\), ao lado de \(\texttt{VALORACAO\_TRES\_DELSARTE\_MOD127.md}\), ou passe a localização desse arquivo como primeiro argumento. Ele autentica a versão exata de R19 antes de reutilizar as funções certificadas.

~~~~python
from functools import cache
from hashlib import sha256
from pathlib import Path
from types import ModuleType
import sys

source_path = (Path(sys.argv[1]) if len(sys.argv) > 1
               else Path("VALORACAO_TRES_DELSARTE_MOD127.md"))
data = source_path.read_bytes()
assert sha256(data).hexdigest() == (
    "78ec7cde5cbb77a771a596fbd18c5566b5d5cbe66ee923ee362ba22681d9eb26"
)
source = data.decode().split("~~~~python\n", 1)[1].split("\n~~~~", 1)[0]
m = ModuleType("r19")
exec(compile(source, str(source_path), "exec"), vars(m))

B, E = 528_531_328, 16_256
c2, c3, c4 = 394_716, 1_813_560, 7_748_016
F = 3 * (1 << 26) + E

@cache
def possible(n, k, d):
    if k <= 0:
        return True
    for w in range(d, n + 1, 2):
        if m.griesmer(k, w) > n:
            break
        rank = m.rank_cap(4, w)
        if rank and possible(n - w, k - rank, w):
            return True
    return False

L = [0] + [next(n for n in range(32, 265) if possible(n, k, 32))
           for k in range(1, 26)]
assert L == [
    0, 32, 48, 56, 60, 62, 63, 64, 80, 88, 92, 94, 95,
    96, 112, 120, 124, 126, 127, 128, 144, 152, 156, 158, 159, 160,
]

def minimum_p2(s):
    return 128 if s == 7 else 256 if s == 15 else 192

for s in range(7, 16):
    p2 = minimum_p2(s)
    for combined_s in range(s, 31):
        u = 32 - combined_s
        rho = 8 if u > 16 else 4 if u > 8 else 0
        for r in (0, 1):
            q_low = max(42-r, 27, 65-combined_s-r+rho)
            q_high = min(
                (F + (B-F)//(1 << r))//c4,
                (B - c2*p2 - c3*L[combined_s-s])//c4,
            )
            assert q_low > q_high
    assert c2*p2 + c3*L[31-s] > B - 30*c4

assert B-30*c4 == 296_090_848 > (B+E)//2
assert m.nonnegative_delta_masses(13) == {0}
assert [L[32-s] for s in range(7, 16)] == [
    160, 159, 158, 156, 152, 144, 128, 127, 126,
]
print("Confirmado: s<=15 obriga aff(P2 uniao P3) pleno e a tabela do nivel tres.")
~~~~
