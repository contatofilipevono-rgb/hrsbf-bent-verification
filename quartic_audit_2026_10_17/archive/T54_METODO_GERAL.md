# Um método geral de certificação por caracteres e simetrias

## O que é geral e o que é específico

O argumento abaixo vale para sistemas de condições polinomiais booleanas, além do problema H(16,4). Ele organiza ferramentas conhecidas de Fourier, somas quadráticas e Cauchy–Schwarz; não se reivindica novidade dos lemas básicos. As identidades concretas, reduções e eficiência dos certificados devem ser avaliadas separadamente para publicação.

## Princípio de certificação

Suponha que todo objeto procurado pertença a um núcleo E, dividido em partes disjuntas E_b. Cada parte admite uma parametrização bijetiva por um espaço de variáveis livres, com distribuição uniforme, e tem medida w_b no espaço original. A reconstrução dos coeficientes a partir dos parâmetros pode ser não linear. Em cada parametrização, o objeto deve satisfazer m condições P_b(x)=0.

Uma família de bijeções que preserva a medida do espaço de parâmetros pode agir nos testes por

`P_b(φ_g(x))=A_g P_b(x)+v_g`, com A_g invertível sobre F₂.

Nos caracteres não nulos, a ação é λ↦A_gᵀλ. As expectativas dentro de cada órbita O são iguais a uma expectativa representativa, multiplicada por sinais σ_λ. Se um ciclo força sinais contraditórios, a expectativa é zero. Caso contrário, defina c_O=Σ_(λ∈O)σ_λ.

Se β_(b,O) limita o módulo da expectativa representativa, então

`Pr(objeto procurado) ≤ Σ_b w_b · 2^(−m) · [1+Σ_O |c_O| β_(b,O)]`.

**Prova.** Expanda o indicador de P=0 nos 2^m caracteres. A invariância da medida dá as relações de sinais. Agrupe a soma pelas órbitas e limite cada contribuição representativa por seu módulo. Depois pondere as cartas. Não se usa independência entre as condições.

Na aplicação atual v_g=0, logo c_O é o tamanho da órbita. A versão com sinais permite reutilizar o mesmo agregador em outros problemas.

## Três maneiras intercambiáveis de certificar β

1. **Restrição quadrática:** escolher coordenadas S com posto polar constante r. O módulo é zero se alguma derivada radical for um; nos demais casos, é 2^(−r/2). Um subconjunto de equações radicais fornece um majorante seguro da densidade de anulação.
2. **Diferenças finitas:** escolher um subespaço T de dimensão k cujas diferenças básicas sejam quadráticas. Todas as diferenças em T são então quadráticas e suas matrizes polares se somam. Vale

   `|E_x(−1)^P(x)|² ≤ 2^(−k)[1+Σ_(h∈T,h≠0)2^(−rank(D_hP)/2)]`.

   Aqui, a expressão à direita majora o quadrado do viés; qualquer β racional cujo quadrado seja pelo menos essa expressão é um certificado válido.
3. **Partição em fibras:** no espaço dos parâmetros livres, fixar formas lineares independentes, incluir todos os valores e calcular a média dos limites das fibras. O posto das formas determina os pesos exatos. Pode-se usar um método diferente em cada fibra. As fibras são afins nesse espaço; sua imagem nos coeficientes originais pode ser não linear.

Em cada representante pode ser escolhido o menor limite já certificado. A escolha do método e do orçamento não interfere na validade da prova.

## Uma limitação exata evita cálculo sem retorno

Se o limite final usa apenas contribuições não negativas |c_O|β, seu lado direito é pelo menos

`(Σ_b w_b)/2^m`.

Em H(16,4), o núcleo tem medida 3/128 e há sete bits adicionais. Portanto **essa forma de certificado** não pode garantir exclusão superior a

`100·(1−3/16384) = 99,981689453125%`.

Isso é uma limitação do limite por módulos, não um teto para a exclusão verdadeira pelos filtros. Não depende de supor independência. Aumentar k indefinidamente aproxima esse patamar com custo exponencial. Para ultrapassá-lo, é preciso informação adicional ou contribuições com sinais efetivamente determinados.

Acrescentar o bit invariante T48 dá m=8 e desloca esse patamar para **99,9908447265625%**, preservando o agrupamento por simetria. Seu ganho global ainda está em cálculo.

## Precisão adaptativa e formato comum

Cada folha da prova deve expor os mesmos campos: carta, caráter, método, limite racional e evidência verificável. O agregador lê um único campo de limite, sem depender de nomes históricos como `selected_amplitude` ou `average_absolute_slice_bias`.

O compilador deve guardar somente as provas escolhidas. Se diferenças finitas substituem uma restrição quadrática, o certificado final não precisa verificar também o limite descartado. Os modelos polinomiais, a medida do núcleo e a ação do grupo permanecem dependências explícitas, vinculadas por hashes.

Um planejador já executado escolhe dimensões entre oito e dezesseis conforme a contribuição e o custo. Usando os certificados T43/T44 como pais, encontrou um plano que mantém exclusão acima de **99,96008%** com custo estimado de **888.810 unidades**, contra 2.237.290 unidades para conferir toda a cadeia histórica T40/T43/T44. Uma unidade representa um posto de matriz; uma soma quadrática foi estimada em 44 unidades. **É um modelo de custo, não uma medição de tempo nem prova de otimalidade.** A exportação e verificação direta do certificado compacto ainda precisam ser concluídas; o profiler externo deverá calibrar os custos.

## Resultado negativo que restringe a busca

T52 usa equações lineares nos termos de maior grau para examinar todas as translações dos parâmetros livres, e não apenas mudanças de uma coordenada. Nenhuma translação não nula nesse espaço envia os sete testes ao espaço gerado por esses testes e pela constante. O verificador independente reduz a busca a três candidatos no ramo zero e nenhum no ramo um; os três falham na igualdade polinomial completa.

Isso descarta uma família inteira de tentativas de compressão por translação. Não descarta transformações afins gerais nem simetrias não lineares. O procedimento de obstrução é reutilizável em outros sistemas de polinômios.

## Estado editorial

O caminho para um trabalho publicável é apresentar este princípio como organização de ferramentas conhecidas, provar as identidades específicas e demonstrar ganhos de custo com certificados reproduzíveis. Ainda faltam confronto integral da literatura e medições do profiler. Percentual elevado, por si só, não estabelece novidade nem relevância editorial.
