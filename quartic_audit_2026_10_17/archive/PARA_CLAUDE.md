# Pedido de revisão independente e colaboração matemática

Quero que você ajude a auditar e avançar esta pesquisa. Leia primeiro este arquivo e `T40_TREZE_CONDICOES.md`, depois `MANUSCRITO_MODULAR_CONSOLIDADO.md`. Não aceite percentuais ou relatórios PASS como substitutos da prova: confira hipóteses, argumentos e verificadores. Se houver ambiente de execução, rode os verificadores relevantes com Python padrão.

## Problema e estado confirmado

Estudamos o espaço vetorial H(16,4), de dimensão 116, das funções booleanas homogêneas quárticas invariantes por rotação cíclica. Cada gerador soma os monômios **distintos** de uma órbita; órbitas curtas não são repetidas. Os coeficientes c0,…,c115 seguem a primeira quádrupla ainda não vista na ordem lexicográfica de combinações de {0,…,15}.

Treze condições necessárias para bentness excluem **pelo menos 99,94316569188364%** dos 2^116 vetores. A passagem é no máximo

`1310509920535861/2305843009213693952`.

Isso NÃO prova inexistência global nem certifica os sobreviventes. A conjectura PC(2) chamada C16 é um problema distinto: não se podem impor filtros necessários apenas para bentness na busca por contraexemplos PC(2). A novidade bibliográfica também não está estabelecida; o texto integral do artigo de Sun, Shi, Liu e Fu de 2026 ainda não foi confrontado.

O núcleo de seis condições tem forma normal em onze paridades agregadas e ocupa exatamente 3/128 do espaço. Seus dois ramos c99=0 e c99=1 têm medidas originais 1/64 e 1/128. Os sete bits restantes são combinados por expansão em caracteres, sem hipótese de independência. As oito unidades módulo 16 agrupam 127 caracteres em 43 órbitas. Para cada representante, escolhe-se uma restrição quadrática; equações radicais selecionadas fornecem limites superiores seguros para a densidade. Foram conferidas 18.080 somas quadráticas por um método independente e 173 espaços de equações.

## O que peço, em ordem

1. **Audite a prova T40.** Procure erros de normalização, sinais, medidas dos ramos, substituições booleanas, ação de simetria, multiplicidades e direção das desigualdades ao usar apenas parte das equações radicais. Dê um contraexemplo concreto se encontrar um problema; se não encontrar, explique quais passos efetivamente conseguiu conferir.
2. **Audite o lema de diferenças finitas T43/T44.** Para F=(-1)^P e subespaço T de dimensão k, usamos

   `|E F|² ≤ 2^(-k)[1+Σ_(h∈T,h≠0)2^(-rank(D_hP)/2)]`,

   quando todas as diferenças são quadráticas. Basta conferir as diferenças nas direções de uma base: D_(a+b)P é soma de uma translação de D_aP com D_bP. As partes polares então se somam. Verifique a prova por médias quadradas nas classes de T, a enumeração de postos e as raízes limitadas por frações racionais.
3. **Proponha uma simplificação estrutural.** Há como limitar os postos de todas as diferenças sem enumerar 2^16−1 matrizes? Uma apresentação por códigos de matrizes, formas quadráticas ou equivalências poderia reduzir os certificados? Prefiro uma melhoria demonstrável ou um experimento pequeno com critério claro de sucesso.
4. **Investigue informação adicional.** Um exemplo não nulo passa nos treze filtros e falha na condição do suporte 0x27ff e em W(0)=±256. T45 certifica isso nos 65.536 pontos originais. Compare combinar 0x27ff, levantar o segundo bit dos quatro suportes da família T40, ou usar a identidade exata T41. Uma alternativa preliminar é somar os primeiros bits dos suportes 0x27ff,0x6edf,0x39ff,0x5eef, preservando a simetria por unidades; sua eficácia global ainda não foi provada.

## Estado dos refinamentos no instante do envio

T43 aponta exclusão ≥99,95861540189143%; T44, combinado com T43, aponta ≥99,96433819284774%. **São estimativas candidatas enquanto a conferência independente de toda a cadeia não terminar.** Os certificados e verificadores foram incluídos para sua auditoria. A existência de um arquivo candidato não significa que seu resultado foi promovido a teorema.

T41 demonstra `W_f(0)=65536−128a−192b−32w`, onde a=c57, b=c99 e w conta 4.080 órbitas completas nas quais f vale um. Logo bentness exige `w=2040−4a−6b+16σ`. A identidade e controles foram conferidos; dois pilotos SAT de 60 segundos foram inconclusivos. Timeouts não excluem candidatos.

## Como reproduzir e como responder

Extraia todos os arquivos do pacote na mesma pasta. Os verificadores públicos incluídos usam Python padrão. Comece pela forma normal, pelos polinômios T35, pela simetria e modelos T40 e por fim pelo limite T40. O último levou cerca de treze minutos na máquina de desenvolvimento. T43/T44 podem levar mais tempo; não presuma que estejam errados apenas por demorarem.

Responda com: (a) achados da auditoria, distinguindo confirmado de suspeito; (b) o melhor próximo passo e por que ele ajuda; (c) uma prova, derivação ou teste reproduzível; (d) resultados negativos e limitações. Não arredonde exclusão de candidatos para 100% e não confunda taxa observada em amostra com limite global. Se sugerir literatura, indique o teorema exato e a fonte primária que o sustenta.
