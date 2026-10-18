# Avaliação da proposta Gemini: suporte 0x7f7f

A proposta merece prioridade. O avanço central é acrescentar uma condição necessária cujo efeito sobre os certificados de diferenças finitas pode ser controlado algebricamente. Não é uma prova de inexistência de funções bent.

## Verificações realizadas

Reexecutei a identidade simbólica e a enumeração agregada fornecidas pelo Gemini: diferença simétrica zero entre os polinômios, 2304 padrões no ramo b=0 e 1024 no ramo b=1, sobre denominador 262144. A densidade resultante é 9/1024 + 4/1024 = 13/1024. Isso reproduz o cálculo fornecido; não confundir reexecução com uma implementação inteiramente independente de todas as etapas.

Reexecutei também a análise quadrática: nas duas fatias de b=0, posto 6 e viés +1/8; em b=1, posto 4 e componente linear não nula no radical, portanto viés zero. No ramo b=0 inteiro, o polinômio ainda tem 512 termos cúbicos: o condicionamento em c57 é essencial.

Construí separadamente as tabelas das funções originais e comparei h(0x7f7f)/16 mod 2 com o polinômio fornecido em todas as 527 funções da amostra T76. Todas coincidiram. Os resíduos de h módulo 128 foram:

| Resíduo | Quantidade |
|---|---:|
| 0 | 82 |
| 16 | 64 |
| 32 | 58 |
| 48 | 71 |
| 64 | 80 |
| 80 | 64 |
| 96 | 62 |
| 112 | 46 |

Logo, 284/527 passam por divisibilidade por 32, 162/527 por 64 e 82/527 por 128. São contagens de uma amostra já filtrada pelas 13 condições, não densidades globais nem prova de independência. Há testemunha explícita de que as 13 condições não implicam o novo primeiro bit: c=0x54cc88990c184e9be7ebe740e009f tem h=464.

## Ajustes necessários na apresentação

1. O suporte não é fixado literalmente pelas unidades: multiplicar os índices por 3 leva 0x7f7f a 0xdfdf. Todas as oito imagens são rotações do suporte original. Como f é simétrica por rotação, isso preserva a condição e permite o argumento de simetria adequado.
2. A fórmula compacta exibida pressupõe também c99=b. Com somente as duas primeiras leis, é necessário acrescentar (b+c99)K. O código do Gemini contém esse termo e verifica a identidade correta; a descrição omite essa distinção.
3. A invariância da parte quadrática de D_d(P+Q) é correta quando Q tem grau no máximo 2 na mesma fatia. Esse lema transfere cotas baseadas nos postos dessas derivadas. Ele não transfere automaticamente qualquer cota de fatias do polinômio original: essas cotas exigem sua própria verificação, incluindo posto polar e equações do radical.
4. O arquivo T45B_TOP16_REFINEMENT.json inspecionado registra amplitudes finais, mas não as direções, submatrizes e histogramas por caso. O produtor permite regeneração determinística; o arquivo sozinho não é um certificado completo para verificação independente dos novos postos. A cota 99,9802472045% permanece um resultado relatado pelo Gemini, pendente dessa auditoria. Não substituí o limite global T47 já auditado.
5. O piso 13/131072 é consistente com a expansão de caracteres, mantendo o viés assinado exato do novo bit e majorantes não negativos para os demais caracteres. Não é um limite inferior para a densidade verdadeira de sobreviventes. Reduzir esse piso mais uma vez por fator 2 exige analisar os novos bits; a amostra não basta.

## Relação com nossa rota atual

O exemplo T83 no ramo b=0, c=0x530947633e72251c0345fef412326, tem h(0x7f7f)=0. Portanto ele passa pelas 13 condições, pelas seis amplitudes exatas e pela condição completa 128|h(0x7f7f), mas tem W(0x0101)=1024 e não é bent.

Esse exemplo impede concluir que a junção desses filtros já fecha o problema. Também justifica manter as frequências de período 8 na busca.

## Próxima prioridade

Para melhorar o limite certificado: preservar a forma normal nova, reconstruir certificados completos dos refinamentos e combinar apenas amplitudes verificadas com T47. Para buscar uma obstrução estrutural: integrar os três bits de h(0x7f7f) aos contadores compartilhados de período 8. A identidade h(u)=soma sobre x contido em u de (-1)^(f(x)+wt(x)), para este u de peso par, permite usar as mesmas variáveis de verdade orbitais, com pesos por interseção de órbita.

O resultado mais geral extraível é o lema de estabilidade das cotas de diferenças finitas sob perturbações quadráticas nas mesmas fatias. A novidade bibliográfica desse lema e da aplicação ainda precisa ser investigada antes de qualquer alegação de originalidade.

Dados desta auditoria: T84_AUDITORIA_GEMINI_7F7F.json. Scripts externos foram lidos/reexecutados sem editar os originais. Não foi executada a nova enumeração de postos Top16.
