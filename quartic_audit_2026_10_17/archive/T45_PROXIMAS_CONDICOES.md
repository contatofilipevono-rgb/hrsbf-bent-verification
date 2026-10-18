# T45: novas condições além das treze

Foi certificado um exemplo **não nulo** que passa nas treze condições e falha tanto no teste Walsh em zero quanto em outra condição inteira da ANF. Portanto há informação útil para avançar além dos filtros atuais.

O vetor de 116 coeficientes é `0x661d58a1f584edab5f8294ac55e6`, na ordenação pública dos geradores. Nele:

- os quatro coeficientes periódicos antigos são −128, −224, −96 e 64, divisíveis por 32;
- os quatro coeficientes da família 0x33ff, 0x66ff, 0x73bf, 0x76ef valem −80, divisíveis por 16, passando nos respectivos primeiros bits;
- o coeficiente no suporte **0x27ff** vale **−216**, falhando na necessidade de divisibilidade por 32 e já no primeiro bit após divisão por oito;
- a amplitude **W(0)=1280** falha na necessidade W(0)=±256.

O verificador reconstrói o polinômio adicional por todas as **5.775 partições** relevantes. Depois das três leis lineares, ele tem 5.498 monômios e grau três. O exemplo foi conferido diretamente nos **65.536 pontos** do domínio original. Também falha no suporte 0x65ff, cujo coeficiente vale −200.

## Piloto e alternativas

Na amostra anterior de 512 funções que passavam em nove condições, 26 passam também nas treze: dez do grupo de descoberta e dezesseis do grupo reservado para validação. Escolher condições usando somente os dez primeiros deu:

| condição adicional | termos após três leis | rejeições na descoberta | rejeições na validação |
|---|---:|---:|---:|
| 0x27ff, a menor com rejeição adicional | 5.498 | 7/10 | 9/16 |
| 0x65ff, a melhor na descoberta | 6.210 | 9/10 | 5/16 |

A diferença entre descoberta e validação mostra por que a melhor taxa observada não deve ser tratada como prova global. O certificado estabelece a não implicação; **não demonstra uma nova porcentagem global**.

Três caminhos ficam registrados: combinar 0x27ff com os filtros anteriores; aproveitar a identidade Walsh exata T41; ou levantar o segundo bit dos quatro suportes que, no exemplo, passam no primeiro e falham no seguinte.

Arquivos: `T45_NOVA_CONDICAO_CERTIFICADO.json`, `VERIFICAR_NOVA_CONDICAO_T45.py`, `T45_NOVA_CONDICAO_VERIFICACAO.json` e `T45_PILOTO_APOS_TREZE.json`.
