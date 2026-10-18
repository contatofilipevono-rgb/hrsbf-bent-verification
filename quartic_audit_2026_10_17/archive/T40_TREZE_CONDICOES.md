# T40: treze condições e exclusão de pelo menos 99,9431%

O conjunto de treze condições necessárias exclui **pelo menos 99,94316569188364%** do espaço original H(16,4) como candidato a bent. A fração que ainda pode passar é no máximo

`1310509920535861 / 2305843009213693952`.

Isso supera a meta de 99,9% de exclusão. Não significa encontrar uma função bent, certificar os sobreviventes ou provar inexistência global. Estes resultados não resolvem C16.

## Quais condições e por que combiná-las

Usamos as seis condições da forma normal T34; os três bits periódicos seguintes nos suportes 0x3f3f, 0x5f5f e 0x6f6f; e quatro condições nos suportes 0x33ff, 0x66ff, 0x73bf e 0x76ef. As quatro últimas exigem que o bit h_f(s)/8 seja zero, depois das três leis lineares. Não se presume independência entre testes.

Os quatro novos suportes se relacionam pelas oito multiplicações ímpares dos índices módulo 16. Essas ações preservam o núcleo de seis condições e cada ramo c99. Elas agrupam os 127 caracteres não nulos dos sete bits restantes em 43 órbitas. As expectativas são iguais dentro de cada órbita; portanto basta certificar um representante e usar sua multiplicidade.

## Densidades e limite

Para cada representante escolhemos uma restrição quadrática, conferimos seu posto e estudamos as equações das direções radicais. Quando usar todas essas equações tornaria o certificado excessivo, mantemos um subconjunto de combinações delas. Toda solução do sistema completo satisfaz o subconjunto, de modo que sua densidade fornece um **limite superior**, adequado à prova. A densidade dos subconjuntos é calculada exatamente por somas quadráticas.

O lema de caracteres dá os limites condicionais

`1754322589141535/72057594037927936`, se c99=0,

`866697251930187/36028797018963968`, se c99=1.

As medidas desses ramos no espaço original são 1/64 e 1/128. A soma ponderada fornece o limite global acima. A densidade exata dos sobreviventes não foi determinada.

## Conferência independente

- `VERIFICAR_SIMETRIA_T40.py`: oito ações, seis condições preservadas, 32 relações entre os novos polinômios e cobertura dos 127 caracteres por 43 órbitas.
- `VERIFICAR_MODELOS_T40.py`: reconstrução completa dos oito modelos normalizados e 256 avaliações diretas da ANF original.
- `VERIFICAR_LIMITE_T40.py`: **18.080 somas quadráticas independentes e 173 verificações de espaços de equações**, além das restrições, postos, radicais e multiplicidades.

Todos passaram e usam Python padrão. Os relatórios terminam em `_VERIFICACAO.json`; os certificados em `_CERTIFICADO.json`. O limite não é afirmado ótimo e não modifica automaticamente o domínio GPU T33. Não foi feita nova execução GPU.
