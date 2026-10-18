# Obstruções estruturais e descida periódica

17 de outubro de 2026. H(n,4) designa o espaço gerado pelas somas de monômios distintos nas órbitas cíclicas dos suportes de tamanho quatro. Todos os cálculos de funções são em F₂; as somas de Walsh e autocorrelação são inteiras.

**Resultado desta etapa:** demonstrações de obstruções para subfamílias em infinitas dimensões e um lema de redução para dimensões menores. Não se obteve uma prova de inexistência em todo H(n,4), nem em todo H(16,4). Não se reivindica novidade bibliográfica destes lemas.

## 1. Obstrução por um subespaço grande de zeros

Se f em 2m variáveis se anula num subespaço linear L de dimensão m+1, então

`max_a |W_f(a)| ≥ 2^(m+1)`.

Com efeito, pela ortogonalidade dos caracteres,

`2^(m+1) = Σ_(x∈L) (-1)^f(x) = 2^(1-m) Σ_(a∈L⊥) W_f(a)`.

Como L⊥ tem 2^(m−1) elementos, o lado direito tem módulo no máximo max|W_f|. Isso contradiz a amplitude bent 2^m. A mesma prova funciona se f é afim em L, deslocando a frequência.

**Corolário A — duas variáveis de cada lado.** Para qualquer n=2m, uma função homogênea quártica cujos monômios têm exatamente duas variáveis de índices pares e duas de índices ímpares não é bent. Basta permitir todas as m coordenadas pares e apenas uma coordenada ímpar: nenhum monômio pode valer 1 nesse subespaço de dimensão m+1. Não é preciso supor simetria rotacional.

**Corolário B — todas as órbitas curtas.** Para todo n=2m≥8, nenhuma combinação de órbitas quárticas de comprimento menor que n é bent.

Prova: o estabilizador de um suporte de tamanho quatro tem ordem que divide quatro, pois age livremente sobre as posições. Se não é trivial, sua ordem é dois ou quatro; portanto contém a translação por m. O suporte é união de dois pares antípodas. Assim toda combinação dessas órbitas é

`f(x)=Q(z_0,…,z_(m−1)),  z_i=x_i x_(i+m)`,

com Q homogênea quadrática. No subespaço que permite x_0,…,x_(m−1) e apenas x_m da segunda metade, no máximo um z_i é não nulo. Logo Q=0, e aplica-se a obstrução anterior.

São exatamente floor(m/2) órbitas curtas. A conclusão é conhecida em contexto mais geral: Cusick–Sanger, Teorema 2.11, excluem somas de órbitas curtas sem o termo quadrático antípoda. Aqui a prova foi escrita diretamente para o caso quártico.

## 2. Lema de descida periódica por autocorrelações

Sejam d≥2 par, p primo ímpar, k≥1, q=p^k e n=dq. Para y em F₂^d, escreva R(y) como a concatenação de q cópias de y. Seja f uma função booleana invariante por rotação em n variáveis e defina

`g(y)=f(R(y))`,

`C_f(v)=Σ_x (-1)^(f(x)+f(x+v))`.

Então, para todo u em F₂^d,

**`C_f(R(u)) ≡ C_g(u) (mod p)`.**

Prova: considere a rotação por d posições, de ordem p^k. A parcela da autocorrelação é constante em cada órbita porque f é invariante e R(u) é fixo. Toda órbita não fixa tem comprimento divisível por p e desaparece módulo p. Os pontos fixos são precisamente R(y); suas contribuições somam C_g(u).

**Consequência.** Se f é bent e `p > 2^(d−2)`, então g é bent.

Prova: bentness implica C_f(v)=0 para v≠0. Isso decorre de

`C_f(v)=2^(−n) Σ_a W_f(a)^2 (-1)^(a·v)`.

Portanto p divide C_g(u) para todo u≠0. A derivada D_u g tem peso par, pois os argumentos aparecem em pares {y,y+u}; consequentemente C_g(u)=2^d−2 wt(D_u g) é divisível por quatro. Como p é ímpar, 4p divide C_g(u). Mas |C_g(u)|≤2^d<4p. Logo C_g(u)=0 para todo u≠0, o que, pela mesma identidade de Fourier, equivale a g bent. A prova não supõe grau quatro.

O limite sobre p é suficiente; não se afirma que seja ótimo. Para primos menores, a congruência continua válida, mas não força C_g=0.

## 3. Uma família infinita de exclusão por paridade

Tomando d=2, o requisito p>2^(d−2) vale para todo primo ímpar. Logo, em n=2p^k, a restrição aos vetores de período dois de qualquer bent rotacional deve ser bent em duas variáveis.

Essa restrição tem a forma `g(a,b)=c+ℓ(a+b)+t ab`, pois é invariante pela troca de a e b. Ela é bent exatamente quando t=1. Portanto:

**`f(0,…,0) + f(1,…,1) = 1` em F₂.**

Para f em H(2p^k,4), isso exige um número ímpar de órbitas curtas selecionadas: cada órbita longa tem comprimento 2p^k, e cada curta tem comprimento p^k. Assim, toda função com um número par de órbitas curtas está excluída, independentemente de quantas órbitas longas contenha. Exclui-se exatamente metade do espaço de coeficientes nessa família de dimensões. As funções só de órbitas curtas, inclusive as de paridade ímpar, são excluídas pelo Corolário B.

**Caso ainda não resolvido:** número ímpar de órbitas curtas juntamente com pelo menos uma órbita longa. Nenhum dos argumentos acima exclui toda essa mistura.

Para k=1, a condição nos valores em zero e um coincide com o Lema 3.4 de Cusick–Sanger. A demonstração acima também cobre k>1. Isso não basta para alegar prioridade científica da extensão.

## 4. Como transportar os resultados de dimensões pequenas

A descida não preserva automaticamente homogeneidade: identificar coordenadas pode transformar um monômio quártico em um termo de grau menor. Esse é um obstáculo real à tentativa de concluir inexistência global em dimensões maiores.

Há, porém, um corolário preciso. Considere a subfamília de H(dp^k,4) em que cada monômio selecionado utiliza quatro resíduos distintos módulo d. Então g pertence a H(d,4), porque não há colisão das variáveis e a restrição preserva rotação. Se H(d,4) não contém bent e p>2^(d−2), essa subfamília não contém bent.

Por exemplo, a enumeração completa de H(8,4), refeita pelo verificador desta etapa, certifica zero bent entre 1.024 funções. Com ela, o corolário exclui a subfamília sem colisões módulo oito em todas as dimensões

**`n=8p^k`, com p primo ≥67 e k≥1.**

Aqui a passagem para infinitas dimensões é analítica, mas a premissa em dimensão oito foi verificada computacionalmente. Não se afirma uma prova puramente analítica desse corolário a partir dessa enumeração.

O resultado auditado em H(12,4) fornece o corolário análogo para n=12p^k, p>1024, sob a mesma condição de resíduos distintos módulo doze e com a mesma dependência da evidência computacional de base. Isso não significa que H(12,4) se encaixe sem restrições em H(12p^k,4).

## 5. Verificações e próximo alvo

O arquivo VERIFICAR_DESCIDA_PERIODICA.py verifica a congruência de autocorrelações em exemplos nas dimensões 6, 10, 12, 18 e 20, incluindo uma ação de ordem nove, exemplos não homogêneos e controles bent quadráticos; reenumera H(8,4); e verifica simbolicamente todos os suportes de órbitas curtas para n=8,10,…,32. O resultado fica em T112_DESCIDA_PERIODICA_VERIFICACAO.json. São verificações finitas complementares às provas, não substitutos delas.

O alvo seguinte deve ser a mistura de órbitas longas e curtas, não apenas a diagonal antípoda: a restrição f(y,y) apaga todas as órbitas longas e perde justamente a informação que falta. Para n=12, a congruência de descida com d=4, p=3 é válida, mas 3≤4 e o lema não força a restrição a ser bent. Para n=16 não existe fator primo ímpar; essa descida não se aplica. Nesses casos, seria necessário controlar as contribuições fora do conjunto fixo, por congruências mais fortes ou identidades adicionais.

## Referência e delimitação de novidade

T. W. Cusick e E. M. Sanger, *Rotation Symmetric Bent Boolean Functions for n=2p*, especialmente Teorema 2.11, Lema 3.4 e Teorema 3.8: https://arxiv.org/abs/1708.09313.

A exclusão de órbitas curtas e a restrição para n=2p já constam dessa referência. O lema geral de descida e seus corolários foram demonstrados explicitamente aqui; sua novidade não foi estabelecida por uma revisão bibliográfica completa. Estes resultados organizam um caminho estrutural, mas não encerram a conjectura quártica.
