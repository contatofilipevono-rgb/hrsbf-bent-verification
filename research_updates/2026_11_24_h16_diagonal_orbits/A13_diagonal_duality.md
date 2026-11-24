<a id="a13"></a>

### A13 — Dualidade de paridade nas diagonais fixas e exclusão integral de 32 fibras de H16

**Lema geral (paridade em cortes simétricos).** Seja \(f\) bent em \(2h\) variáveis, com \(f(x,y)=f(y,x)\). A dual \(f^*\) é invariante pela mesma troca. Escreva \(g(u)=f(u,u)\), \(g^*(u)=f^*(u,u)\), em que a estrela neste último símbolo indica restrição da dual global. Para \(h=2t\), todo \(t\)-plano linear \(W\subset\mathbb F_2^h\) e todo \(b\) satisfazem
\[
 \mathrm{wt}(g^*|_{W+b})\equiv\mathrm{wt}(g|_{W^\perp})\pmod2.
\]
Em particular, ambas as restrições diagonais têm grau no máximo \(t\); seus símbolos de grau \(t\) são complementares por dualidade exterior com respeito ao produto escalar. Se \(\deg g<t\), então \(\deg g^*\le t-1\).

*Prova.* Aplique Poisson no corte espectral \((W+b)\times(W+b)\), de dimensão \(h\). Como a amplitude de Walsh é \(2^h\), a soma dos sinais da dual nesse corte é igual à soma dos sinais de \(f\) em \(W^\perp\times W^\perp\), com fase \((b,b)\). Ambos os cortes são invariantes pela troca dos blocos. Fora da diagonal, cada órbita contribui \(+2\) ou \(-2\), valores congruentes módulo 4, e a quantidade de pontos fora da diagonal é a mesma nos dois lados. Na diagonal a fase desaparece. Reduzindo módulo 4, obtemos a igualdade de paridades de peso. A independência do lado direito em relação à translação \(b\) implica que as derivadas de ordem \(t\) de \(g^*\) são constantes, e portanto seu grau é no máximo \(t\). A mesma prova aplicada à dual dá o limite para \(g\). A identificação de topo segue da fórmula em planos lineares. Em particular, se a função \(g\) tem grau menor que \(t\), todo peso no lado direito é par.

Para \(h=2t+1\), \(t\ge1\), escolhe-se \(E=W\times W+\langle(d,d)\rangle\), com \(\dim W=t\) e \(d\notin W\). O mesmo argumento dá paridade de \(g^*\) em todo transladado de \(D=W+\langle d\rangle\) igual à paridade de \(g\) sobre \(W^\perp\), ambos de dimensão \(t+1\). Variando \(W\) dentro de \(D\), e usando a conexidade do grafo de adjacência dos \(t\)-planos, a paridade de \(g\) sobre todos os \((t+1)\)-planos é constante. A identidade anterior também prova \(\deg g,\deg g^*\le t+1\). Uma forma exterior de grau \(t+1<h\) não pode valer 1 em todos os planos dessa dimensão: fixem-se \(t\) vetores, e dois vetores independentes módulo o seu span, e use-se a aditividade na última entrada. Logo a paridade constante é zero e \(\deg g,\deg g^*\le t\).

Se \(f\) é de grau no máximo \(d\), a própria simetria implica \(\deg g\le\lfloor d/2\rfloor\), por pareamento dos monômios trocados; os monômios fixos são produtos de pares de coordenadas. Assim para \(n=4m\), \(d<2m\), a restrição da dual central tem grau no máximo \(m-1\). Em H16 de grau 4, isso dá **grau no máximo 3**, em vez dos limites 5 e 4 obtidos anteriormente por divisibilidade.

**Identidade adicional dos primeiros bits das diagonais transladadas.** Mantendo as notações de A11, para \(h=(d-1)k+2\), \(d\ge3\), \(k\ge2\), existe um vetor polinomial \(b_A(z)\), homogêneo formal de grau \(k-1\), tal que
\[
 \gamma_k(\iota_z A)=\iota_{z\wedge b_A(z)}\mathrm{vol}_h.
\]
Com \(\psi_a(z)=S_a(z)/2^{k+2}\bmod2\), tem-se a identidade
\[
 \psi_a(z)=(1+a\cdot z)\bigl(\psi_0(z)+a\cdot b_A(z)\bigr).
\]
A divisão é sempre inteira. De fato, para \(z\ne0\) a função desce ao quociente de dimensão \((d-1)k+1\), como em A11; se \(a\cdot z=1\) os somandos cancelam. Se \(a\cdot z=0\), a diferença dos bits das duas fases é o peso dividido por \(2^{k-1}\), módulo 2, no hiperplano de dimensão \((d-1)k\) do quociente onde a fase nova vale 1. Sua expressão por monômios é a forma volume de \(\gamma_k(C_z)\) restrita ao núcleo da fase. A identidade de contração de A11 implica que o bivector dual \(P(z)\) de \(\gamma_k(C_z)\) satisfaz \(z\wedge P(z)=0\). Em componentes, reduza as relações \(z_1P_{ij}+z_iP_{1j}+z_jP_{1i}=0\) módulo \(z_1\). A coprimalidade de \(z_i,z_j\) dá \(\overline P_{1i}=z_i\overline b_1\); levantando \(b_1\), ponha \(b_i=(P_{1i}+z_i b_1)/z_1\). A relação original dá \(P_{ij}=z_i b_j+z_j b_i\). A graduação dá \(\deg b_A\le k-1\). Isso também mostra que a correção é determinada unicamente pela camada \(C_z\) da fibra. Em \(z=0\), a diferença de fases zera no bit em questão: a diferença inteira \(S_a(0)-S_0(0)\) é duas vezes uma soma de sinais de grau no máximo \(\lfloor d/2\rfloor\) em \(h-1\) variáveis, divisível por \(2^{k+3}\).

Para uma bent, Poisson implica que todas as \(\psi_a\) têm grau no máximo \(k+1\) em \(z\). Como a correção acima tem grau no máximo \(k\), a condição para todas as fases obriga \([\psi_0]_{k+1}=0\): multiplicá-lo exteriormente por toda 1-forma dá zero e \(k+1<h\). Assim \(\psi_0\) tem grau no máximo \(k\) e a parte superior da restrição de \(f^*\) à diagonal transladada de parâmetro \(a\), de grau \(h-k-1\), é dada pela dualidade exterior de \((a\cdot z)\wedge[\psi_0]_k\). Em H16, \(k=2\); a correção é linear em \(a\) e em \(z\) antes do fator \(1+a\cdot z\). A verificação das 256 fibras confirmou a anulação do grau 3 de \(\psi_0\), mas essa condição sozinha não as excluiu.

**Congruências por módulos cíclicos.** Para H16, considere todos os subespaços espectrais \(E\) de dimensão 8 invariantes por \(R^2\), e todos os seus cosets \(E+a\) invariantes. Escreva \(D_8=\{(u,u)\}\). As órbitas de \(R^2\) fora de \(D_8\) têm tamanho 8; as suas somas assinadas são congruentes a 8 módulo 16. O módulo de \(R^2\) na dimensão 16 é a soma de dois blocos cíclicos sobre \(\mathbb F_2[t]/t^8\), com \(t=R^2+1\). Seus submódulos de dimensão 8 são exatamente os gerados por \((t^i,b)\) e \((0,t^j)\), onde \(i+j=8\) e \(b\) é tomado módulo \(t^j\). Há \(1+2+\cdots+256=511\) espaços. Cada \(E\) e \(E^\perp\) tem interseção com \(D_8\) de dimensão pelo menos 4 (núcleo de \(t^4\)). Em cada coset estável, os termos fora de \(D_8\) têm contribuição nula módulo 16. Poisson, com o mesmo fator unitário da primeira prova, dá
\[
 \sum_{(v,v)\in (E+a)\cap D_8}(-1)^{g^*(v)}
 \equiv \sum_{(u,u)\in E^\perp\cap D_8}(-1)^{g(u)+(a_{\rm lo}+a_{\rm hi})\cdot u}\pmod{16}.
\]
A enumeração exata encontra 1276 cosets e 92 conjuntos diagonais distintos, com os termos da direita determinados pelas quadráticas fixas de cada setor. Isso permite filtrar somente a dual central, sem enumerar as \(2^{104}\) funções primais de uma fibra.

**Certificados para H16.** Nas duas células de A10, a restrição \(g\) é fixa em todas as 111 direções e tem peso 64 (\(B0\_11\)) ou 160 (\(B1\_11\)); seu grau é no máximo 2. A dual central \(g^*\) é C8-invariante, de grau no máximo 3, com o mesmo peso, pela soma \(S_0(0)\) de A11 e pelo lema acima. Todos os seus coeficientes de Walsh são múltiplos de 16: para \(z\ne0\), o quociente tem dimensão 7 e grau no máximo 3; para \(z=0\), temos \(g\) quadrática. O espaço C8-invariante de grau no máximo 3 em oito variáveis tem dimensão 13 (uma constante, uma órbita linear, quatro quadráticas e sete cúbicas). Portanto sua enumeração completa tem somente 8192 pontos.

| Teste exato | \(B0\_11\) | \(B1\_11\) |
|---|---:|---:|
| Peso fixo e divisibilidade por 16 dos Walsh da dual central | 24 | 446 |
| Depois das 511 congruências de módulos cíclicos | 16 | 110 |
| Fibras brutas de A10 totalmente excluídas | 32/128 | 0/128 |

Os perfis centrais de graus e pesos indicados foram cruzados com as imagens lineares exatas das tabelas de verdade de \(g_z\) nas restrições \((z=\mathtt{ff,55})\), \((\mathtt{ff,11})\), \((\mathtt{ff,33})\), \((\mathtt{ff,77})\) e \((\mathtt{01})\). Seus postos são 11, 16, 16, 17 e 14, respectivamente, e toda imagem foi enumerada. Onde \(C_z=0\), o Walsh de \(g_z\) deve ser zero ou uma potência de dois com sinal, pelo teorema quadrático, incluindo a divisibilidade mínima de 32 para \(z\ne0\). Essa condição adicional exclui a fibra de camada nula \(e=0\).

A lista decimal de fibras excluídas de \(B0\_11\) é
\[
\begin{split}
 &0,7,10,17,20,25,28,30,32,39,42,49,52,57,60,62,\\
 &65,68,73,75,76,82,85,95,97,100,105,107,108,114,117,127.
\end{split}
\]
Todas têm dimensão 104 antes de outras condições. A lista inclui as oito exclusões de A10, acrescentando 24 fibras brutas novas. As 96 outras fibras brutas de \(B0\_11\) deixaram 8 ou 14 possíveis perfis centrais; todas as 128 de \(B1\_11\) deixam 108 nessa relaxação. As exclusões não dependem de impor \(K=c_{57}\).

**Perfil do bit central.** Entre os 16 perfis de \(B0\_11\), o primeiro bit \(S_0/16\bmod2\) é necessariamente zero ou \((z_0+z_2+z_4+z_6)(z_1+z_3+z_5+z_7)\). Essa última quadrática é o somatório dos dois orbitais de pares representados por \(\mathtt{3,9}\) em C8. Nos 110 perfis de \(B1\_11\) aparecem somente quatro primeiros bits, representados pelos conjuntos de orbitais \(\varnothing\), \(\{\mathtt{3,9}\}\), \(\{\mathtt{3,5,9}\}\) e \(\{\mathtt{1,3,5,9}\}\). Juntamente com A13, isso limita também o grau das diagonais transladadas por \(a=\mathtt{ff,55,aa}\) a no máximo 4 em \(B0\_11\).

**Alerta de auditoria histórica.** O arquivo histórico \(\mathtt{T27\_QUINTA\_CONDICAO.md}\) prova \(c_{99}(c_{57}+K)=0\), e, portanto, \(K=c_{57}\) quando \(c_{99}=1\). No arquivo histórico \(\mathtt{DIAGNOSE\_V2\_STRUCTURE.py}\), linhas próximas de 1074, a equação \(\mathtt{p\_c5}\) que impõe \(K=c_{57}\) está sendo inserida também nas células \(c_{99}=0\). A análise histórica \(\mathtt{a08\_gap\_analysis.md}\) já pedia uma prova autônoma de sua extensão, declarada obtida fora dos arquivos anexados. Na presente revisão essa prova ainda não foi recuperada. As novas tabelas são calculadas sem tal imposição. Em \(B0\_11\), \(K=e_0+e_2+e_4+e_6\) na parametrização bruta de A10, e todas as 32 exclusões novas/anteriores acima estão no lado \(K=0\), excluído a priori pelo algoritmo histórico. Assim, a extensão não verificada da C5 deve ser auditada antes de reutilizar o placar histórico de células fechadas. Não se afirma um contraexemplo bent à extensão, apenas a ausência da derivação no material consultado. Em particular, o registro histórico de fechamento de \(B0\_00\) exige conferir a cobertura do lado \(K=1\); os testes curtos de A13 não excluíram suas 64 fibras brutas. As provas completas que dependem apenas do ramo \(c_{99}=1\) permanecem sujeitas às suas auditorias próprias.

**Tentativa algébrica complementar, ainda sem fechamento.** Na mesma origem afim, a fibra bruta e=1 de B0_11 forneceu 368 relações de topo cúbico independentes, 20 quadráticas e nenhuma linear; e=2 forneceu 368 cúbicas, 19 quadráticas e uma linear, reduzindo sua dimensão para 103. A expansão XL das 1800 primeiras consequências e eliminação linear não certificou inconsistência. Uma comparação preliminar que parecia fornecer 14 relações lineares em e=1 misturava duas origens afins e foi descartada. O teste SAT com as diagonais periódicas conjugadas, interrompido após 90 segundos sem resposta, não constitui certificado de inviabilidade. Estes testes não acrescentam fibras fechadas à lista acima.

**Reprodução independente:** [verify_h16_diagonal_reduction.py](verify_h16_diagonal_reduction.py).
