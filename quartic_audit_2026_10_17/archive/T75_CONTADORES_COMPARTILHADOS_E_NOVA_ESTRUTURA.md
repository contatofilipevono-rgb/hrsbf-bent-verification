# Compartilhamento de contadores e uma restrição estrutural para bentness

Esta etapa substituiu codificações separadas de Walsh por contadores compartilhados, validou o ganho numa amostra nova e produziu uma condição necessária demonstrada para toda hipotética bent de H(16,4). Também encontrou um candidato que passa pelas treze condições antigas e pelas seis amplitudes exatas de menor período, mas não é bent. O melhor limite global certificado T47 permanece inalterado.

## A redução geral por paridades de blocos

Para d dividindo n, defina pi_d(x) como o XOR dos blocos consecutivos de d coordenadas de x. Se repeat(v) repete n/d vezes um vetor v de d bits, então

repeat(v)·x = v·pi_d(x).

Consequentemente,

W_f(repeat(v)) = soma_y (-1)^(v·y) G_f(y),

G_f(y) = soma_{x:pi_d(x)=y} (-1)^f(x).

Essa é uma identidade de projeção seguida de transformada de Walsh, válida para qualquer função. Para funções invariantes por rotação, G_f também é invariante por rotação dos d bits. Portanto podemos agrupar os termos em classes de rotação. Não reivindicamos novidade bibliográfica para essa identidade elementar de Fourier.

## Especialização em H(16,4)

Nas órbitas completas de entradas, pi_d percorre uma classe de rotação de período p, visitando cada padrão exatamente 16/p vezes. Para d=4 ou d=8, todas as entradas das órbitas curtas projetam em zero.

Se w_j conta as órbitas completas em que f=1 na classe projetada j, então, sob as três leis T20,

W_f(repeat(v)) = 65536*[v=0] - 128a - 192b - 2*soma_j C_j(v)*w_j,

C_j(v) = (16/p_j)*soma_{y na classe j} (-1)^(v·y).

Assim:

- as seis frequências de período dividindo 4 usam os mesmos seis contadores;
- as 36 frequências de período dividindo 8 usam 35 contadores não vazios; a classe zero não contém órbitas completas;
- para impor apenas W≡256 (mod512), basta guardar cada w_j módulo 16*p_j. Isso exige de quatro a sete bits por contador, conforme o período.

O verificador independente conferiu a geometria completa de 4080 órbitas para cada uma das duas projeções, além de comparar os valores com transformadas diretas das funções originais.

## Tamanho efetivamente medido

| Componente | Variáveis auxiliares | Cláusulas CNF |
|---|---:|---:|
| Apenas W(0)≡256 mod512, implementação anterior | 19161 | 33271 |
| Seis congruências, com contadores compartilhados | 19732 | 34305 |
| 36 congruências, com contadores compartilhados | 26828 | 51691 |
| Uma amplitude exata W(0)=±256, implementação anterior | 20151 | 36289 |
| Seis amplitudes exatas, com tabela de perfis | 20115 | 39845 |

As contagens valem para cada ramo fixo de b. A versão com seletores para ativação individual das frequências acrescenta variáveis de controle e serve à verificação. A redução é de tamanho de codificação; não constitui uma comparação geral de tempos de solução.

O componente compartilhado passou em 512 atribuições pequenas para os contadores e 512 para combinações lineares assinadas. A versão de seis congruências passou em controles originais positivos e negativos. A versão de 36 passou em 540 verificações de valores de contadores e 540 testes de frequências ativadas individualmente, dos quais 196 positivos e 344 negativos.

## Validação com uma nova semente

Foi fixado um novo ensaio de 8192 funções passando nove condições, obtidas de 65430 amostras do núcleo, com semente 2026101776. Entre elas:

| Filtros acumulados | Sobreviventes |
|---|---:|
| Treze condições anteriores | 527 |
| Mais a congruência em zero | 261 |
| Mais a congruência em 0x5555 | 129 |
| Todas as seis congruências de período até 4 | 31 |
| Todas as 36 congruências de período até 8 | 0 |

Nenhuma das 527 funções passou pelas seis amplitudes exatas. Esses zeros são amostrais, não provas de inexistência. O verificador independente reconstruiu e revalidou as treze condições dos 527 registros, suas projeções e seus espectros completos. O tamanho do ensaio e o número de tentativas são metadados reproduzíveis do gerador, não uma enumeração global.

Também testamos uma seleção de frequências feita somente nos nove sobreviventes da exploração anterior. A regra escolheu 0x6f6f e 0x2d2d, eliminando aqueles nove. Na amostra nova, porém, deixaram 31→5→2 sobreviventes. Mantivemos esses dois exemplos: o conjunto menor de filtros não encerra a busca.

## Uma restrição estrutural demonstrada

Separe as órbitas completas ímpares conforme o peso de pi_4(x): ele é 1 ou 3. Denote por t1 e t3 as quantidades dessas órbitas nas quais f=1.

Verificamos completamente os geradores de cada classe:

- todos os 116 pesos de geradores são divisíveis por 8;
- todas as 6670 interseções de pares têm tamanho divisível por 4;
- todas as 253460 interseções de triplas têm tamanho par.

Pela inclusão-exclusão do peso de uma soma XOR, **t1 e t3 são divisíveis por 8 para toda função de H(16,4)**.

Além disso, a geometria das órbitas fornece, sem assumir as leis T20,

W(0x1111)-W(0x7777) = -32*(t1-t3),

W(0)-W(1^16) = 65536-64*(t1+t3).

Se f fosse bent, a primeira diferença pertenceria a {0,±512}, obrigando t1-t3 a ser divisível por 16. Como t3 é divisível por 8, a soma t1+t3 também seria divisível por 16. A segunda diferença seria então divisível por 1024. Dois valores em {±256} só podem ter essa diferença se forem iguais.

Portanto, qualquer bent em H(16,4) satisfaria

**W(0)=W(1^16), t1+t3=1024,**

**(t1,t3) em {(504,520),(512,512),(520,504)}.**

É uma condição necessária demonstrada com certificado finito completo, não uma prova de inexistência nem uma reivindicação de novidade bibliográfica.

## Perfis exatos e um resultado SAT verificável

Resolvendo o sistema racional das seis amplitudes, há 32 perfis inteiros de contagem por par (a,b) depois de impor a divisibilidade acima: 128 perfis ao todo. A tabela completa foi conferida independentemente e substitui várias escolhas de sinal e equações grandes por alvos de contagem.

Com essa codificação e as seis condições do núcleo, o piloto encontrou um modelo no ramo b=0 em aproximadamente 7,48 segundos de solução e outro no ramo b=1 em 15,78 segundos. Os tempos são observações desta execução.

O primeiro modelo, c=0x530947633e72251c0345fef412326, passou também pelas treze condições antigas, verificadas depois da busca. Seus valores são:

W(0)=W(0x3333)=W(0x5555)=W(0x7777)=W(1^16)=256,

W(0x1111)=-256.

Mas W(0x0101)=1024. O espectro completo confirma que não é bent. Esse exemplo prova que mesmo as treze condições mais as seis amplitudes exatas não implicam a amplitude correta em 0x0101. O segundo modelo nem sequer passa pelas nove condições; ele valida outro ramo da codificação, não um candidato do filtro completo.

## O limite da relaxação por contadores

As equações dos contadores livres admitem soluções. Para a=b=0, tomar metade das órbitas de cada classe como negativas produz formalmente W=256 nas frequências consideradas. Isso não afirma que exista um vetor de coeficientes realizando tais contagens.

A eliminação modular, com operações invertíveis verificadas por reprodução independente, encontrou soluções para todos os quatro pares (a,b). No espaço relaxado de resíduos dos contadores, as seis congruências têm 2^12 soluções entre 2^31 resíduos, e as 36 têm 2^136 entre 2^237. Essas densidades não são densidades de funções: os contadores provenientes dos coeficientes têm fortes dependências.

O obstáculo remanescente é a realização simultânea das contagens por uma mesma função. A próxima combinação útil é preservar a tabela das seis amplitudes exatas e acrescentar as restrições de período 8, compartilhando as avaliações por órbita. A amostragem sozinha não resolve essa questão.

## Arquivos para conferência

- QUOCIENTE_WALSH_PERIODICO.py e CODIFICADOR_CONTADORES_COMPARTILHADOS.py: implementação da projeção e dos contadores.
- T75_T76_PROJECAO_VERIFICACAO.json: geometria completa e 587 transformadas diretas.
- T77_CODIFICACAO_COMPARTILHADA_VERIFICACAO.json e T78_CODIFICADOR_36_CONTROLES_VERIFICACAO.json: controles dos circuitos.
- T79_MODULO_CONTADORES_VERIFICACAO.json: contagem exata no espaço relaxado.
- T80_ESTRUTURA_IMPAR_VERIFICACAO.json: prova certificada da condição W(0)=W(1^16).
- T81_PERFIS_EXATOS_VERIFICACAO.json: tabela de 128 perfis.
- T83_CANDIDATOS_VERIFICACAO.json: reconstrução dos dois modelos SAT e espectros completos.
