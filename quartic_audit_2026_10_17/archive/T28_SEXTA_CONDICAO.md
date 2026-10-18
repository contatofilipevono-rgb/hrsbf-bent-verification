# Sexta condição: segundo bit da ANF inteira

## Resultado

Em H(16,4), as cinco condições anteriores deixam exatamente 3/64 das palavras de 116 coeficientes. A condição adicional

`h_f(0x3f3f)/16 ≡ 0 (mod 2)`

é necessária para bentness. Juntas, as seis condições deixam **no máximo 17/512** do espaço original. Portanto excluem **pelo menos 495/512 = 96,6796875%** como candidato a bent. A fração restante é um limite superior, não uma contagem exata, e não representa uma classificação de funções bent. A conjectura C16 continua aberta.

Aqui h_f é a representação multilinear inteira da função sinal (−1)^f. O critério 2-ádico clássico exige divisibilidade por 32 nesse suporte de peso 12. A quinta condição já garante divisibilidade por 16; T28 impõe o bit seguinte. A fonte do critério é Zhang e Gao, *On the conjecture about the nonexistence of rotation symmetric bent functions*, Lemma 2.4, [arXiv:1303.2282](https://arxiv.org/abs/1303.2282). A aplicação específica e seu certificado estão registrados aqui; novidade bibliográfica ainda não foi estabelecida.

## Identidade de órbitas no suporte

Escreva cada ponto do suporte como (v,w), com v,w de seis bits nas posições 0,…,5 e 8,…,13. A rotação por oito troca os dois blocos. Há 64 pontos fixos e 2.016 pares. Se χ é a paridade das coordenadas e t_f contém f+χ em um representante de cada par, então

`h_f(0x3f3f) = B0 + 4032 − 4 wt(t_f)`.

Sob as primeiras três leis, ponha a=c57 e b=c99. A contribuição diagonal é

`B0 = 16(4−2a−3b)`.

O verificador reconstrói todos os geradores, verifica que apenas os geradores curtos pertinentes contribuem na diagonal e confere os quatro casos (a,b). Assim, sob a quinta condição,

`h_f(0x3f3f)/16 ≡ b + wt(t_f)/4 (mod 2)`.

## Dois ramos afins antes da quarta condição

Seja L o conjunto de 16 índices da terceira lei e K o conjunto de 32 índices da quinta. A numeração é a mesma dos certificados anteriores: primeiro representante ainda não visto na enumeração lexicográfica dos quartetos, com cada órbita contendo monômios distintos.

**Ramo b=0.** Escolha livremente todos os coeficientes salvo 0,99,113,115. Reconstrua c0 pela paridade de L, c99=0, c113=c57 e c115=0. São 112 parâmetros.

**Ramo b=1.** Escolha livremente todos salvo 0,57,99,113,115. Reconstrua c57 pela paridade de K, c0 pela terceira lei, c99=1, c113=c57 e c115=0. São 111 parâmetros.

Em cada ramo, t_f=O+Σz_i V_i. O certificado verifica wt(O) divisível por quatro, wt(V_i) par e

`wt(V_i)−2wt(O∩V_i) ≡ 0 (mod 4)`,

`wt(V_i∩V_j) ≡ 0 (mod 2)`.

A expansão inteira do peso de uma soma binária fornece um polinômio de grau no máximo três para b+wt(t_f)/4 mod2. Seus coeficientes são:

- constante: b+wt(O)/4;
- linear i: [wt(V_i)−2wt(O∩V_i)]/4;
- quadrático ij: wt(V_i∩V_j)/2 + wt(O∩V_i∩V_j);
- cúbico ijk: wt(V_i∩V_j∩V_k), todos reduzidos módulo dois.

Os termos de ordem quatro ou superior têm coeficientes pares após a divisão por quatro. As congruências conferidas justificam as divisões inteiras dos termos restantes. São 5.864 monômios no ramo zero e 10.294 no ramo um.

## Impor a quarta condição

Na restrição de Q4 a cada ramo, c23 ocorre apenas linearmente. Ela reconstrói c23 sem alterar b nem a quinta condição. Substituí-la nos polinômios anteriores produz:

| c99 | parâmetros livres | monômios | grau | medida no espaço original |
|---|---:|---:|---:|---:|
| 0 | 111 | 22.063 | 4 | 1/32 |
| 1 | 110 | 29.960 | 4 | 1/64 |

Esses dois domínios são disjuntos e cobrem exatamente o espaço que satisfaz as cinco condições.

## Certificado da taxa de exclusão

No ramo zero, selecione as coordenadas livres S0={26,30,31,39,57,60,111,112}. Nenhum monômio de grau maior que dois contém duas coordenadas de S0. Logo, para qualquer atribuição às demais coordenadas, a restrição a S0 é uma forma quadrática fixa mais uma função afim. Seu posto polar é dois. Todas as 512 perturbações afins foram enumeradas: o peso mínimo é 64 entre 256 pontos. Portanto pelo menos 1/4 do ramo zero viola T28.

No ramo um, S1={30,80,86,91,107,111} tem a mesma propriedade; o posto polar é quatro. Todas as 128 perturbações afins foram enumeradas: o peso mínimo é 24 entre 64 pontos. Pelo menos 3/8 desse ramo viola T28.

Assim, a medida que pode sobreviver é no máximo

`(1/32)(3/4) + (1/64)(5/8) = 17/512`.

Esse argumento é uniforme em todas as coordenadas externas. Não depende das frequências da amostra. A busca completa das restrições coordenadas maximais desse tipo examinou 262 no ramo zero e 244 no ramo um; os postos máximos foram respectivamente dois e quatro. Isso estabelece optimalidade apenas nessa classe específica de certificados, não do limite global.

## Reprodução e alternativas

`VERIFICAR_SEXTA_CONDICAO.py` usa somente Python padrão e lê `T28_SEXTA_CERTIFICADO.json` da mesma pasta. Ele reconstrói todas as órbitas e todos os coeficientes dos polinômios, confirma as substituições e enumera os certificados de peso mínimo. Também confere 512 funções diretamente pelos 4.096 pontos do suporte. `T28_VERIFICACAO.json` registra o resultado.

Um piloto com CryptoMiniSat 5.17.0 reuniu as 389 condições cúbicas, Q4, o ramo c99=1 da quinta e o novo bit. O modelo contém 240.494 variáveis, 721.134 cláusulas AND e 394 equações XOR. Atingiu 45 segundos sem SAT nem UNSAT. Isso não exclui candidatos; não há certificado de inviabilidade.

Próximas alternativas: estudar os termos lineares nas coordenadas radicais das restrições quadráticas; obter a densidade exata de T28; testar se T28 desce à parametrização T27 antes de alterar o pacote GPU; explorar novas condições inteiras em suportes diferentes. Nenhuma execução GPU é alegada e o domínio T27 não foi reduzido por T28 nesta entrega.
