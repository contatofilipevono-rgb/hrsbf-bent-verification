# T31: sétima condição no suporte periódico 0x7777

## Resultado

Sob as três leis lineares de T20, o coeficiente inteiro h_f(0x7777) é sempre divisível por 16 e satisfaz

`h_f(0x7777)/16 ≡ R + (1+c99)M + (1+c57)K (mod 2)`.

R,M,K denotam as paridades dos conjuntos de índices abaixo. Bentness exige que esse bit seja zero, porque o suporte tem peso 12 e o critério inteiro exige divisibilidade por 32.

Esta condição elimina **exatamente metade** das palavras que passam nas cinco condições anteriores. Com essas cinco, deixa exatamente 3/128 do espaço original. Incluindo também a sexta condição de T28, a fração restante é **no máximo 9/512**, excluindo **pelo menos 503/512=98,2421875%** como candidato a bent.

A densidade exata do conjunto que satisfaz todas as sete condições permanece desconhecida. Nenhum resultado de inexistência global é afirmado.

## Forma explícita

```
R = [5,6,7,16,17,19,43,44,49,50,51,58,59,62,63,66,
     82,84,87,95,100,102,105,108]
M = [2,10,25,37,54,68,83,104,12,20,29,33,41,48,96,110]
K = [1,3,9,11,13,15,21,24,28,32,34,38,45,47,53,55,
     67,69,70,72,74,76,78,80,86,89,91,93,97,103,107,109]
```

K é o mesmo conjunto da quinta condição; M reúne os dois lados do terceiro produto de Q4. Substituir c99 pela paridade L produz um polinômio de 360 monômios, de grau dois, nos 113 parâmetros livres das três leis T20.

No ramo c99=0, a condição é `R+M+K+c57*K=0`. No ramo c99=1, a quinta condição já exige c57=K; logo a nova condição se reduz à lei linear `R=0`.

## Prova por código de valores

O suporte corresponde aos pontos (v,w) com v,w restritos às posições {0,1,2,4,5,6}. A troca dos blocos gera 64 pontos fixos e 2.016 pares. Como em T28,

`h_f(0x7777)=B0+4032−4wt(t_f)`.

Para (c57,c99)=(0,0),(0,1),(1,0),(1,1), o termo diagonal B0 vale respectivamente 64,32,32,0. Portanto B0/16 é sempre par. O bit procurado é wt(t_f)/4 mod2.

O verificador constrói diretamente a base de 113 geradores após as três leis, confere todas as congruências de pesos e interseções que justificam a expansão dividida por quatro e enumera todos os coeficientes lineares, quadráticos e cúbicos. Os termos cúbicos cancelam completamente. Os restantes coincidem com a fórmula fatorada acima.

## Contagem e combinação com T28

O coeficiente c5 ocorre apenas linearmente na nova condição e não participa das formas de Q4 nem das primeiras três leis ou da quinta condição. Alterná-lo preserva essas cinco condições e troca o novo bit. Isso prova a divisão exata por dois: 3/64 passa a 3/128.

As direções d=e75 e e=e42+e81+e94+e106 de T30 preservam também a nova condição. No plano de quatro funções determinado por essas direções, a sexta condição apresenta exatamente um ou três valores um. Assim no máximo três das quatro funções podem passar na sexta, mesmo após impor a sétima. A fração que passa em todas é no máximo `(3/128)(3/4)=9/512`.

## Certificados e próximos passos

`VERIFICAR_SETIMA_CONDICAO_T31.py` usa Python padrão, reconstrói todos os coeficientes e verifica 256 avaliações diretas da ANF original nos 4.096 pontos. Ele lê apenas o certificado T28 da mesma pasta; `T31_SETIMA_CERTIFICADO.json` registra a fórmula e o resultado. O argumento combinado usa também o certificado T30.

Os suportes 0x5f5f e 0x6f6f já têm modelos exploratórios completos com verificações diretas; ainda precisam de análise e documentação. Também falta determinar se a sétima condição reduz o quociente T27 ou apenas as funções que representam cada estado. Nenhuma alteração do pacote GPU foi feita com base nessa condição. Novidade bibliográfica ainda precisa ser confrontada com a literatura integral.
