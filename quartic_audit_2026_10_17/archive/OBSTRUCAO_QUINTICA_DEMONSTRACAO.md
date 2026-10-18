# O primeiro bit da autocorrelação de uma quártica em 16 variáveis

## Proposição geral

Seja f uma função booleana de grau no máximo quatro em n=3t+1 variáveis, t≥1. Fixe a≠0 e um complemento linear V de ⟨a⟩. Seja g a restrição da derivada D_a f a V, identificada com F₂^{3t}. Escreva b_T para o coeficiente cúbico de g no suporte T, |T|=3. Então

\[
2^{t+1}\mid C_f(a),\qquad
\frac{C_f(a)}{2^{t+1}}
\equiv\sum_{\mathcal P}\prod_{T\in\mathcal P}b_T\pmod2,
\]

onde a soma percorre as partições de {1,…,3t} em t triplas não ordenadas. Assim, a paridade dos emparelhamentos perfeitos desse hipergrafo determina exatamente se a autocorrelação é divisível por 2^{t+2}.

## Demonstração

A derivada é constante nos pares {x,x+a}. Logo C_f(a)=2^{3t+1}−4 wt(g). Uma constante em g apenas troca o sinal de sua soma exponencial e não altera a paridade normalizada; podemos suprimi-la.

Expanda o XOR dos monômios de g como função inteira:

\[
g(x)=\sum_{\varnothing\ne\mathcal S}
(-2)^{|\mathcal S|-1}\prod_{M\in\mathcal S}M(x).
\]

Ao somar sobre todas as atribuições, a contribuição de uma coleção com r monômios e união de suportes U é

\[
(-1)^{r-1}2^{r-1+3t-|U|}.
\]

Como |U|≤min(3t,3r), todos os termos são divisíveis por 2^{t−1}. Para que o expoente seja exatamente t−1 é necessário r=t e |U|=3t. Isso ocorre precisamente quando os t monômios são cúbicos e têm suportes disjuntos. Se r<t, o expoente é pelo menos t+1; se r>t, é pelo menos t. Portanto wt(g)/2^{t−1}, módulo dois, conta exatamente as partições em triplas cujos coeficientes são um. A identidade para C_f(a) segue; o termo constante 2^{3t+1}/2^{t+1}=2^{2t} é par. ∎

## Aplicação a H(16,4)

Agora t=5. Escolhemos V={x₀=0}. Denote por c_S o coeficiente do monômio quártico de suporte S, constante em cada órbita cíclica.

Para a₀=e₀, o coeficiente cúbico no suporte T⊂{1,…,15} é

\[
L_0(T)=c_{\{0\}\cup T}.
\]

Para a_d=e₀+e_d, 1≤d≤8, é

\[
L_d(T)=c_{\{0\}\cup T}
+\mathbf1_{d\notin T}\,c_{\{d\}\cup T}
\quad\text{em }\mathbb F_2.
\]

De fato, o termo cúbico de uma derivada quártica vem da remoção de uma variável deslocada; os termos provenientes da remoção de duas variáveis têm grau dois e não contribuem ao primeiro bit aqui calculado. Ao impor x₀=0, sobrevive exatamente a expressão acima.

Defina

\[
P_d(c)=\sum_{\mathcal P}\prod_{T\in\mathcal P}L_d(T).
\]

As partições agora dividem os 15 índices em cinco triplas. Cada L_d(T) é linear nos 116 coeficientes independentes de órbitas; portanto P_d é um polinômio booleano de grau no máximo cinco. Há a identidade exata

\[
C_f(a_d)/64\equiv P_d(c)\pmod2.
\]

PC(2), e consequentemente bentness, exigem P₀(c)=⋯=P₈(c)=0. Não há equivalência: essas equações só exigem que as nove autocorrelações sejam múltiplas de 128, não que sejam zero.

## Forma compacta e verificação

O arquivo `quintic_compact_model.json` fornece as 455 triplas e, para cada direção, a máscara de coeficientes que define L_d(T). A recorrência

\[
F(\varnothing)=1,\qquad
F(S)=\sum_{\{j,k\}\subset S\setminus\{i\}}
L_d(\{i,j,k\})F(S\setminus\{i,j,k\}),
\quad i=\min S,
\]

avalia P_d sem expandir seus monômios. A soma e os produtos são em F₂. O verificador comparou 288 valores com tabelas verdade reconstruídas diretamente e encontrou concordância integral. Nove palavras de coeficientes fornecem os nove vetores unitários (P₀,…,P₈), provando a independência linear das nove funções P_d. Outra palavra fornece o vetor zero com autocorrelações não nulas, explicitando a insuficiência da condição.

## Posição bibliográfica

O argumento de coberturas de monômios e divisibilidade é clássico, relacionado a Ax e Moreno–Moreno. A prova acima é uma especialização elementar para explicitar as nove equações usadas nesta pesquisa. Não se reivindica novidade do princípio geral. Referência contextual consultada: [Castro, Randriam, Rubio e Mattson, Divisibility of Exponential Sums via Elementary Methods](https://ccom.uprrp.edu/~labemmy/Wordpress/wp-content/uploads/2011/04/ElemDivSubnoForm.pdf).

O resultado não resolve C16, não prova inexistência global e não demonstra inviabilidade do sistema quintico. Seu próximo uso é produzir e testar certificados em subfamílias ou combinar esse bit com congruências mais fortes.
