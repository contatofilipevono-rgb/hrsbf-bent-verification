# Cobertura das quárticas RS em 12 variáveis por momentos

Toda quártica RS bent em 12 variáveis é afim nas classes laterais de pelo menos um dos planos antipodais invariantes de bases (27,54) e (21,42). Esta verificação substitui a varredura anterior das fases por identidades booleanas, sistemas lineares e substituições afins. Ainda há uma classificação finita de mapas, feita sobre 424 representantes da parte dependente de w. O resultado é um certificado algébrico computacional, com cobertura da classificação finita.

## Mapas balanceados

Na reta antipodal de direção 63, escreva a função como h(y)+cπ(y), onde c é a coordenada na reta. O mapa π é afim nas cinco coordenadas de w que restam na base. Escreva π(z,w)=g(z)+Q(z)·w. A imagem da projeção π↦Q tem dimensão 11 e seu núcleo tem dimensão 7. Estas afirmações são conferidas nas 18 direções do espaço de mapas.

Para cada Q, escolha um levantamento g₀ e escreva os outros como g₀+Σᵢaᵢgᵢ. O balanceamento de π equivale a

\[
\sum_{z:Q(z)=0}(-1)^{g_0(z)+\sum_i a_i g_i(z)}=0.
\]

A soma sobre as cinco coordenadas de w dá zero fora do lugar Q(z)=0. Construa o vetor inteiro C, indexado por b∈F₂⁷, somando (−1)^g₀(z) nos pontos do lugar Q=0 em que (gᵢ(z))ᵢ=b. Os parâmetros a admissíveis são exatamente os zeros da transformada de Walsh de C. O verificador usa a ação já certificada sobre o espaço de mapas e confere que o núcleo da projeção é invariante, de modo que basta transformar C para um representante de cada órbita de Q.

As 424 transformadas de comprimento 128 recuperam exatamente 30.781 mapas balanceados. A lista inteira coincide com a da implementação anterior. As simetrias dos mapas produzem 452 representantes. As condições lineares de fase e de pertencer ao complemento dos dois planos deixam as mesmas 49 tarefas da verificação anterior.

## Exclusão dos sistemas de fase

Em cada tarefa, a polar B_z é uma aplicação afim dos parâmetros livres da fase. Resolva essa aplicação sobre cada valor da sua imagem. Os 49 espaços geram 2.096 pares de tarefa e polar. Todas as fases com a mesma polar formam um espaço afim. As condições de grau exatamente quatro e de não afinidade nos dois planos são assinaturas não nulas. Sua compatibilidade no espaço afim é testada por inclusão-exclusão sobre os três núcleos.

Os momentos são congruências sobre pesos, com módulos 4, 8, 16 e 32 após o primeiro bit. Para um suporte S, escreva a fase como h₀+Σᵢxᵢhᵢ sobre F₂. O coeficiente inteiro de x_J no peso em S, para J não vazio, é

\[
(-2)^{|J|-1}\bigl(|C_J|-2|C_J\cap\operatorname{supp}h_0|\bigr),
\qquad
C_J=S\cap\bigcap_{i\in J}\operatorname{supp}h_i.
\]

Isso segue da expansão inteira do XOR ponto a ponto. A constante é o peso de h₀ em S. Assim o cálculo dos bits usa interseções de conjuntos e somas de polinômios no anel booleano. Para módulo quatro, as equações são quadráticas. Para módulo oito, como o primeiro bit já está fixado, pode-se extrair o segundo bit do inteiro (peso−alvo)/2 usando os termos lineares, quadráticos e cúbicos dessa expansão.

O verificador elimina monômios por ordem de grau e resolve as equações lineares resultantes. Também multiplica equações por uma variável e elimina os termos de grau maior quando isso fornece novas consequências lineares. Uma linha constante igual a 1 certifica impossibilidade. As substituições preservam a representação afim das fases.

Em uma primeira reconstrução das 49 tarefas, 728 pares caíram pelas assinaturas, 1.221 pelo módulo quatro e 145 pelo módulo oito. Os dois pares restantes têm a mesma polar e mapas de códigos 2017 e 2024. O módulo 16 deixa seis parâmetros livres em cada um. Os dois pesos nas fibras inteiras, em ambas as tarefas, são então identicamente 0 módulo 32. A condição de Walsh exige 16 módulo 32. O verificador confere que o último bit da diferença é o polinômio constante 1.

## Alcance e reprodução

As condições de Poisson em subespaços de dimensão três e cinco, desenvolvidas por Fable, motivaram a primeira redução por polar e permitiram uma conferência independente dos sistemas lineares. A reconstrução final gera as polares diretamente das 49 tarefas e usa os momentos. A fórmula para o grau em w no máximo dois está na nota n12-grau-dois-em-w.md. As fases de ordem superior em dimensão três foram verificadas anteriormente por somas quadráticas em outro bloco da classificação.

Na pasta research_updates/2026_11_09_n12_mixed, os comandos abaixo reproduzem a cobertura. O quarto comando não percorre nenhuma atribuição de fase. A classificação finita de mapas, as órbitas e as identidades polinomiais são reproduzidas pelos programas.

~~~sh
python line_balanced_by_walsh.py support.bin
python lower_dim_orbits.py --space 4 --supports support.bin --output orbits.json
python lower_dim_phase_prepare.py --space 4 --supports orbits.bin --output tasks.bin
python line_phase_algebra.py --tasks tasks.bin --output line-phase-algebra.json
~~~

[Execução anterior, por intervalos de fases](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42951139664)
