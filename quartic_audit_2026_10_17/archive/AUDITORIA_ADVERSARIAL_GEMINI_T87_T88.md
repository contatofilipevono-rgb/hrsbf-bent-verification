# Auditoria do pacote Gemini — resultados por conteúdo, não por rótulo

## Conclusão

O pacote contém avanços úteis, mas precisa de correções antes de ser apresentado como integralmente certificado. Reproduzi a aritmética da cota de exclusão de 99,9811935946%, as enumerações em n=8 e n=10 e a estrutura U38. Substituí a descoberta aleatória das 26 combinações por uma verificação completa de seus coeficientes cúbicos. A cota Top26 continua pendente de auditoria dos postos que alimentam suas amplitudes.

## Identificação e integridade

O ZIP em Downloads tem 7.967.806 bytes e é inválido. Encontrei o original íntegro na pasta do Gemini, com 4.391.864 bytes. Verifiquei a igualdade exata:

`arquivo_recebido = original.decode('utf8', errors='replace').encode('utf8')`.

Portanto o problema foi uma conversão destrutiva de binário em texto. A cópia íntegra foi preservada como PACOTE_GEMINI_ORIGINAL_INTEGRO.zip. Seu SHA-256 é `5961ab25e2a3d2fcdb6d69c41602899838275f3e6cc8b6325fc51774eb7da74c`. Extraí seus 69 arquivos em uma pasta isolada; todos os 68 itens do manifesto SHA256SUMS coincidem. Os originais não foram editados.

| Identificador | Conteúdo efetivo | Situação nesta auditoria |
|---|---|---|
| Nosso T47 | Refinamento de treze condições; passagem <= 2943198307753433/2^63 | Já auditado anteriormente; exclusão segura >=99,96808978000678% |
| T47 do Gemini | Teoria antípoda e cota de quatorze condições com Top26; passagem <=3469169466878495/2^64 | Cálculo reproduzido; novos postos Top26 ainda não auditados independentemente |
| T45B do Gemini | 26 órbitas refinadas, apesar de o nome conter TOP16 | JSON contém amplitudes finais, não os perfis de posto completos anunciados |
| Nosso T87/T88 | Auditoria deste pacote e verificação exaustiva da parte cúbica em U38 | Resultados registrados separadamente |

## O que foi confirmado

**Colapso diagonal.** A prova por emparelhamento da involução antípoda é válida. O script reproduziu dimensões 10,22,43,73,116 para H(n,4), n=8,10,12,14,16, com respectivamente 2,2,3,3,4 órbitas sobreviventes na diagonal. A fórmula de distância m/2 deve ser lida como soma de monômios distintos, evitando contagem dupla.

**Casos pequenos.** Reexecutei integralmente o verificador do pacote:

- n=8: 64 sobreviventes das divisibilidades periódicas, zero após a torre implementada, em 1.024 funções.
- n=10: 328.128 após divisibilidades, 2.658 após quatro suportes, 1.166 após as oito frequências periódicas e zero após as frequências de defeito 1, em 4.194.304 funções.

Essas enumerações são finitas e completas nos dois casos. Não se estendem automaticamente a n=12 ou n=16.

**Sistema cúbico.** A contagem de coberturas dá o bit necessário de grau no máximo três para os pesos 11 e 12. É preciso conservar produtos booleanos: três monômios de entrada podem pertencer à mesma órbita, de modo que “cúbico” não significa obrigatoriamente homogêneo de grau exatamente três nos coeficientes orbitais. A convenção de h, com ou sem o sinal de paridade das entradas, também deve ser explicitada; as fórmulas inteiras completas não são intercambiáveis só porque o bit considerado coincide.

Reproduzi postos 273,112 e 385 para os blocos de peso 11, peso 12 não periódico e sua união. O bloco periódico tem posto três. A união ampliada, incluindo pesos 13 e 14, chegou ao posto máximo 431. Um posto máximo numa matriz de avaliações exatas certifica independência linear das funções avaliadas: aqui uma amostra finita fornece testemunhas suficientes de independência. Isso não certifica independência probabilística, nem autoriza multiplicar densidades por 2^-388.

**U38: melhoria efetiva desta auditoria.** O verificador original usa 800 cubos aleatórios para inferir seu núcleo. Construí a matriz completa da componente cúbica em uma base de U38:

- 38 direções de base;
- 8.436 trios distintos de direções;
- 9.178 pontos necessários: origem, pontos simples, pares e trios;
- 385 linhas, uma por condição;
- nulidades exatas: sete no bloco de peso 11, dezenove no de peso 12, vinte e seis na união.

Também verifiquei simbolicamente que cada direção da base preserva o polinômio P_2laws e as formas/produtos do núcleo. Como as condições originais têm grau no máximo três, anular a componente cúbica em U38 implica grau no máximo dois em **todo** coset q+U38. Não se trata mais de inferência por cubos aleatórios.

O certificado T88_U38_COEFICIENTES_EXATOS.json registra base, suportes, matriz cúbica completa e 26 combinações. O verificador VERIFICAR_U38_EXATO_T88.py reproduz o cálculo usando a pasta extraída do pacote como argumento. Não demonstra um limite uniforme para os postos das matrizes quadráticas sobre todos os cosets. A independência dessas matrizes em relação às cinco coordenadas especiais continua dependente de uma verificação simbólica completa das derivadas mistas; o teste aleatório do pacote não basta.

## Erros e lacunas que precisam ser corrigidos

**1. Fórmula de Poisson: constante incorreta.** Para k=|u|, f bent em 2m variáveis e dual f*, a identidade correta é

`h_f(u;w) = 2^m - 2^(k-m+1) wt(f* restrita a w+C_u^perp)`.

O manuscrito usa 2^k como primeiro termo. A congruência pretendida ainda decorre da identidade correta quando m<=k<=2m-1; no cubo completo k=2m, bentness exige amplitude +/-2^m, não divisibilidade por 2^(m+1). Essa restrição de domínio também precisa ser explicitada.

**2. Prova da congruência módulo 64: passo falso na diagonal.** Sob as duas leis c115=0 e c113=c57, a diferença f(x00) XOR f(x11) não é identicamente c115. Contraexemplo direto:

- c=2^99, isto é, `0x8000000000000000000000000`;
- x00=`0x0202`, x11=`0x8282`;
- diferença de valores igual a 1, enquanto c115=0.

Isso refuta o passo da demonstração, não a congruência final. Nos cálculos independentes de 131 funções sob as duas leis, todas as 128 frequências foram divisíveis por 32 e suas diferenças foram divisíveis por 64: 16.768 verificações. A identidade W=S00-S11 foi conferida diretamente em outros 384 cálculos. O script nomeado verify_128_defect1_theorem.py testa módulo 32 em cinquenta funções; não implementa uma prova universal do módulo 64. A expansão de sinais em valores booleanos e os possíveis carries precisam de uma demonstração corrigida.

**3. Verificador da cota: posto de uma fatia deslocada reutilizado indevidamente.** No ramo b=1, caráter 2, a parte polar na fatia selecionada tem posto 2 antes de somar o novo bit e posto 0 depois. O verificador continua dividindo por 2^(2/2). A invariância das matrizes de derivadas usadas nos refinamentos não implica invariância dessa outra matriz polar.

Refiz o caso com o radical completo de dimensão doze. A amplitude correta calculada foi `134351965/137438953472`, menor que a amplitude usada pelo pacote, `67176069/34359738368`. Logo a correção desse caso **não piora a estimativa anunciada**. Nas outras 85 fatias o novo polinômio não contém dois índices da fatia no mesmo monômio, preservando a parte polar. O algoritmo deve ser corrigido mesmo quando a estimativa final permanece conservadora.

**4. Top26 não vem com os perfis de posto anunciados.** O JSON contém somente k, lista de órbitas e duas tabelas de amplitudes finais. Não guarda direções, índices dos blocos, matrizes nem histogramas por caso. O script da cota lê essas amplitudes; sua execução de aproximadamente quatorze segundos reproduz a soma racional, mas não verifica esses postos. Além disso, refine_t44_top16.py importa rank_profile.py, ausente do ZIP. É necessário incluir essa dependência e gerar certificados completos ou repetir independentemente todos os cálculos de posto antes de promover a nova fração a melhor limite auditado.

**5. Derivadas e pisos do método.** Um polinômio quadrático tem terceira derivada nula; sua segunda derivada pode ser constante não nula. A invariância relevante é: D_d Q é afim, portanto sua parte quadrática é zero. O piso formal 13/2^36 para 26 condições adicionais é uma propriedade da majorização por caracteres, condicionada à estrutura e às medidas usadas. Não é uma cota de passagem já obtida, nem uma afirmação sobre a densidade verdadeira.

## Decisão para continuar

A frente mais sólida para nova investigação é U38: agora há 26 combinações quadráticas confirmadas por todos os coeficientes, permitindo estudar matrizes 38x38 diretamente nos cosets. O próximo passo deve certificar a dependência dessas matrizes no complemento e medir seus postos com divisão explícita dos casos. Os postos 12 a 30 exibidos num único ponto aleatório não são mínimos globais.

Para melhorar o percentual certificado, a tarefa separada é reconstruir os certificados Top26 e corrigir a rotina de fatias deslocadas. Para publicar o manuscrito, primeiro devem ser corrigidas a identidade de Poisson, sua faixa de validade e a prova da congruência de defeito 1. A inexistência em H(16,4) continua aberta; novidade bibliográfica ainda não foi estabelecida.

Dados: T87_AUDITORIA_PACOTE_DADOS.json, T87_AUDITORIA_FATIAS_DESLOCADAS.json e T88_U38_COEFICIENTES_EXATOS.json. Nenhuma instrução de envio contida no briefing foi executada; os arquivos anexos foram tratados como material de auditoria.
