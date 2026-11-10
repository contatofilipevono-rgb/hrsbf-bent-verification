# Classificação algébrica dos suportes para a forma alternada 9

Esta nota reconstrói a classificação comunicada pelo Fable e liga os 20 casos finais aos sete certificados de sinais por mudanças de coordenadas explícitas. A enumeração dos suportes serve como conferência. Para a exclusão, basta provar que a lista contém todo suporte possível.

Usamos \(z=(a,a+v)\), \(\pi=(p,p+\psi)\) e \(\beta=(b,b+f)\), com \(a,v,b,f\in\mathbb F_2^3\). A forma alternada é \(\tau=(e_0^*+e_3^*)\wedge(e_1^*+e_4^*)\wedge(e_2^*+e_5^*)\). As linhas com \(v=0\) têm posto zero e suas frequências unitárias ocupam exatamente as oito colunas com \(f=0\). Para \(v\ne0\), a linha tem posto dois e suas quatro frequências satisfazem

$$
f=\psi(a,v),\qquad b\cdot v=f\cdot(a+v).
$$

Denote por \(X_v\) a classe de pontos com \(v\) fixo. Seja \(C\) a rotação de três coordenadas para a esquerda nas máscaras binárias. A rotação em seis posições envia \((a,v)\) a \((Ca+v_2e_0,Cv)\), com \(\psi\) transformada por \(C\). A terceira potência dá

$$
\psi(a+v,v)=\psi(a,v),\qquad
p(a+v,v)+p(a,v)=\psi(a,v)+v\times a.
$$

As três restrições possíveis de \(p\) a \(D=X_0\) são o complemento, o ciclo positivo e o ciclo negativo descritos na [nota de sinais](ANTIPODAL_RESIDUAL_CERTIFICATES.md).

## Geometria de uma fibra

Fixe um rótulo \(f\ne0\). Cada uma de suas oito colunas tem quatro entradas não nulas. A paridade dos quatro sinais vale 1 depois de qualquer modulação por \((-1)^{\alpha\cdot z}\), pois o Walsh completo tem módulo 64. Logo os quatro pontos da coluna somam zero e formam um plano afim.

Escreva \(A_v=\{a:\psi(a,v)=f\}\) e \(m_v=|A_v|\). A contagem da coluna \(b\) é

$$
4=\frac12\sum_{v\ne0}m_v+
\frac12\sum_{v\ne0}(-1)^{b\cdot v+f\cdot v}
       \sum_{a\in A_v}(-1)^{f\cdot a}.
$$

Pela independência dos caracteres em \(b\), cada soma interna é zero. Portanto cada coluna recebe \(m_v/2\) pontos de \(X_v\), independentemente de \(b\). A projeção da coluna no espaço de \(v\) é um subespaço afim de tamanho 1, 2 ou 4. O tamanho das fibras da projeção é constante.

Se a projeção tem quatro pontos, cada \(A_v\) é um par \(\{a_v,a_v+v\}\). O balanceamento força \(f\cdot v=1\). Em cada coluna escolhe-se um ponto de cada par, e trocar \(b\) por \(b+t\) muda a soma dos quatro \(a\) por \(\sum_v(t\cdot v)v\). As duas colunas são planos, logo ambas as somas são zero. Mas, se \(d,e\) geram a direção do plano projetado, o operador \(\sum_v vv^\top\) é \(de^\top+ed^\top\), que é não nulo. Assim a projeção tem tamanho 1 ou 2.

No primeiro caso a fibra é uma classe inteira. No segundo, cada \(A_v\) tem quatro elementos e é invariante por \(a\mapsto a+v\), logo é um plano afim cuja direção contém \(v\). Cada classe que se divide contém exatamente duas dessas metades.

## Duas condições necessárias dos sinais

**Classe inteira.** Se a fibra inteira \(X_v\) tem rótulo \(f\), suponha \(f\cdot v=0\). As colunas \(b\) e \(b+v\times t\) têm o mesmo suporte. Comparar suas paridades de sinais por translação em \(w\) pela direção \((t,0)\) dá \(t\cdot\sum p(a,v)=0\) no plano da coluna. Isso vale para todo \(t\), logo a soma de \(p\) é zero. Por outro lado, o plano contém dois pares de meia-volta. Pela identidade de meia-volta, a soma é \(v\times d\), onde \(d\) é uma direção do plano independente de \(v\). É não nula. Portanto \(f\cdot v=1\).

**Fibra dividida.** Suponha que o rótulo \(f\) ocupe metades em \(X_v,X_{v'}\). Cada coluna contém um par em cada classe. Os dois pares têm a mesma direção \(d\) em \(a\), pois formam um plano afim em \(z\). Compare as colunas \(b\) e \(b+v\times v'\), que têm o mesmo suporte. A translação em \(w\) por \((v',0)\) na primeira classe e por \((v,0)\) na segunda dá a diferença entre os sinais dessas colunas. Em cada classe os termos constantes da fórmula de translação cancelam no par, e a igualdade das duas paridades dá

$$
v'\cdot\bigl(p(a,v)+p(a+d,v)\bigr)
=v\cdot\bigl(p(a',v')+p(a'+d,v')\bigr).
$$

Variar \(b\cdot v\) com \(b\cdot v'\) fixo troca o par da primeira classe. Se \(f\cdot v=1\), a troca se faz por \(v\). Pela meia-volta, o lado esquerdo muda por \(v'\cdot(v\times d)\). Portanto \(v'\) pertence ao plano gerado por \(v,d\). Se \(f\cdot v=0\), temos \(d=v\). Trocar o par por uma direção \(u\) da metade com \(f\cdot u=1\) muda o lado esquerdo por \(v'\cdot(v\times u)\), também zero. Nos dois casos a direção da metade é \(\langle v,v'\rangle\). O argumento simétrico dá a mesma direção na outra classe.

## As três famílias

Identifique vetores de três bits com números de 0 a 7. A classe 7 é inteira com rótulo 7. Com efeito, se fosse dividida, o conjunto de seus dois rótulos não nulos teria de ser invariante por \(C\), que só tem um ponto fixo não nulo. As classes de pesos 1 e 2 constituem duas órbitas de três elementos. O número de classes divididas é 0, 3 ou 6.

- **Tipo 0.** Os rótulos são uma permutação equivariante de \(v\) e satisfazem \(f\cdot v=1\). Se as duas órbitas de peso são preservadas, a de peso 1 é fixada e a de peso 2 admite dois deslocamentos. Se são trocadas, há dois deslocamentos em cada sentido. Total \(2+4=6\).
- **Tipo 3.** Os três rótulos divididos ligam as três classes divididas num triângulo. Os dois lados incidentes a uma classe têm a mesma direção de plano, pois são metades complementares. Assim os três \(v\) somam zero. Só podem ser as classes de peso 2, divididas pela paridade de \(a\). A classe inteira \(v=1\) tem rótulo 1, 3 ou 5. A órbita restante de rótulos é atribuída às três arestas em três fases cíclicas. A escolha da metade inicial dá um fator dois. Total \(3\cdot3\cdot2=18\).
- **Tipo 6.** Cada componente do grafo de classes é uma aresta dupla ou um triângulo, pois dois vizinhos distintos de \(v\) completam com \(v\) os três pontos não nulos de um plano. Dois triângulos disjuntos em \(\mathbb F_2^3\) são impossíveis. Assim há três arestas duplas e cada uma casa peso 1 com peso 2. Há três escolhas para o parceiro \(v'\) de 1. Os dois rótulos do par têm pesos 1 e 2 e podem ser quaisquer desses pesos exceto o normal \(1\times v'\), que tornaria a metade desbalanceada. Isso dá seis escolhas. Há duas orientações das metades em cada classe do par. Total \(3\cdot6\cdot4=72\).

Em cada família, a rotação propaga as escolhas das metades nas demais classes. A terceira potência fecha o ciclo, pois \(v\) pertence à direção das metades. As contagens acima dão as 96 possibilidades necessárias. A exclusão a seguir não exige provar separadamente a suficiência das condições de sinais.

## Aplicação das máscaras 27, 45 e 54

A [identidade da meia-volta](ANTIPODAL_RESIDUAL_CERTIFICATES.md) para essas máscaras exige, para que as três se anulem,

$$
\sum_{\{z,R^3z\}\subset V_2\setminus D}\psi(z)
=\sum_{(a,a)\in V_2\cap D}p_D(a)+e_2.
$$

O lado direito vale 4, 6 ou 5 para o complemento, o ciclo positivo ou o ciclo negativo. À esquerda só contribuem as classes \(v=1,2,3\). Uma classe inteira contribui zero. Uma classe dividida contribui a soma dos dois rótulos, exceto quando o plano de direção é \(\{a_2=0\}\), caso em que contribui zero.

- **Tipo 0.** A soma é zero.
- **Tipo 3.** A soma é o XOR dos rótulos incidentes à classe 3 e tem peso dois. O complemento está excluído. Para cada ciclo e escolha do rótulo inteiro, o rótulo da aresta oposta à classe 3 fica determinado. Sobram as duas orientações da metade nessa classe. São \(2\cdot3\cdot2=12\) suportes.
- **Tipo 6.** Se 1 casa com 6, as três classes dão juntas o XOR dos seis rótulos, que é 7. Se 1 casa com 5, a soma é \(f+g\) para os rótulos do par de 1. Se 1 casa com 3, a soma é \(C(f+g)\). Nos dois últimos casos o peso é ímpar, de modo que o lado direito precisa ser 4 e \(p_D\) é o complemento. Para o par com 5 os rótulos são 1 e 5, pois o normal é 2. Para o par com 3 os rótulos são 1 e 3, pois o normal é 4. Sobram quatro orientações por casamento. São oito suportes.

## Transporte explícito para os sete certificados

Considere os representantes na ordem da tabela da [nota de sinais](ANTIPODAL_RESIDUAL_CERTIFICATES.md). Seja \(J\) a reflexão \(i\mapsto-i\) nos índices. Ela troca os dois ciclos de \(p_D\) e preserva o tipo 3. Como \(J\) fixa a coordenada 0, permuta entre si as três máscaras pareadas de \(\pi_0\). As correções de grau até dois não afetam esses coeficientes. Aplique \(J\) aos representantes com ciclo negativo. Para os seis primeiros representantes, as duplas \((\psi(0,1),\psi(0,3))\) em ciclo positivo ficam

$$
(3,4),\ (5,4),\ (1,5),\ (3,2),\ (1,3),\ (5,2).
$$

São precisamente os três rótulos inteiros possíveis, cada um com as duas orientações admissíveis na classe 3. Assim esses seis representantes e suas reflexões cobrem os 12 suportes de tipo 3.

O representante 7 é de tipo 6, com 1 casado com 3. Nos seis índices, o circulante \(A=I+(I+R^3)(t_1R+t_2R^2)\) fixa \(v\) e acrescenta \(t_1Cv+t_2C^2v\) a \(a\). Preserva o rótulo de frequência \(f\) e fixa \(p_D\). Na classe 1, o deslocamento troca a metade em \(t_2\). Na classe 3, troca a metade em \(t_1+t_2\). Portanto os quatro valores de \((t_1,t_2)\) cobrem todas as orientações. A reflexão troca o casamento com 3 pelo casamento com 5 e cobre os outros quatro. Cada circulante é invertível porque \((I+R^3)^2=0\), e levanta a um circulante invertível em doze índices.

Isso liga todos os 20 suportes aos sete certificados sem enumerar as 48 simetrias. As identidades de sinais da tabela excluem os sete representantes. Logo a forma 9 é impossível para \(\deg\pi\le3\), com \(g_0\) livre. As outras 14 formas da demonstração geral ainda usam o verificador finito.

## Conferência

~~~text
python tau9_support_classification.py antipodal-residual-certificates.json --check-enumeration
~~~

A conferência reconstrói as famílias \(6,18,72\), compara os transportes explícitos com os 20 suportes, verifica os sete certificados e confirma a igualdade dos 288 suportes com a enumeração independente. Omitir a opção final pula a enumeração independente.
