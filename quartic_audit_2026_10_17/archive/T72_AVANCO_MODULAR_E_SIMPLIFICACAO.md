# Dois acréscimos modulares e uma redundância eliminada

Obtivemos duas condições necessárias, não implicadas pelas treze condições anteriores, com contadores módulo 16. São acréscimos ao nosso sistema de filtros; não reivindicamos novidade bibliográfica para as identidades de Walsh. Não houve melhoria certificada no limite global nem prova de inexistência.

## Condições compactas

Sob as três leis T20, sejam a=c57 e b=c99. Defina:

- w: número das 4080 órbitas completas de entradas nas quais f vale 1;
- z: número das 2032 órbitas completas de peso par nas quais f(x) difere da paridade das coordenadas pares de x.

Então valem as identidades exatas

W(0) = 65536 - 128a - 192b - 32w,

W(0x5555) = 32768 - 128a - 192b - 32z.

Bentness exige cada amplitude igual a ±256. Consequentemente, exige

**C0: w + 4a + 6b ≡ 8 (mod 16),**

**C2: z + 4a + 6b ≡ 8 (mod 16).**

São congruências necessárias; não são equivalentes à amplitude exata nem constituem uma caracterização de bentness. A representação é compacta em termos de contadores. Não afirmamos ter encontrado uma nova equação quadrática pequena em todos os coeficientes.

## Por que a segunda identidade vale

Para u=0x5555, as contribuições das entradas numa órbita completa de peso ímpar se cancelam: as rotações alternam a paridade selecionada por u. Nas órbitas completas de peso par, essa paridade é constante, e a contribuição é ±16. Assim, a soma dessas órbitas é 16(2032-2z).

Nas 256 entradas de órbitas curtas, u·x=0. A contribuição é a mesma de W(0), igual a 256-128a-192b sob as três leis. Somando as contribuições obtemos a identidade de W(0x5555).

O verificador separado conferiu todas as 256 assinaturas das entradas curtas e a fórmula em todos os quatro pares (a,b), além de reconstruir os exemplos e contadores originais.

## Não implicação demonstrada por exemplos

Os dois exemplos abaixo passaram pelas treze condições, revalidadas diretamente no T66.

| Coeficientes | W(0) | W(0x5555) | Resultado |
|---|---:|---:|---|
| 0x3da4038d1644c423bbd855a28b8a0 | 2048 | -768 | Passa C2, viola C0 |
| 0x28bb166fc2a778f246c0a585a3543 | 256 | 512 | Passa C0 e a amplitude exata em zero, viola C2 |

Portanto, nenhuma das novas congruências decorre da outra junto com as treze condições. Isso é não implicação lógica, não uma afirmação de independência estatística.

Entre os 229 sobreviventes das treze condições na amostra nova, C0 deixou 113 e C0+C2 deixou 60. Esses 60 mostram que o sistema assim ampliado ainda é satisfatível. As proporções são amostrais e não foram usadas como cotas globais.

## Redundâncias e alternativas descartadas

1. **W(1^16) módulo 512 não acrescenta um bit a W(0).** A identidade W(0)-W(1^16)=65536-64*w_ímpar, combinada com w_ímpar divisível por 8, prova W(0)≡W(1^16) (mod512). A amplitude exata em 1^16 ainda pode acrescentar informação; sua congruência é redundante.

2. **A condição quadrática na frequência 0x5555 repete Q4.** A expansão inteira completa módulo 256 tem 205 termos no ramo b=0 e 197 no ramo b=1 e satisfaz W(0x5555)≡128*Q4 (mod256) após as três leis. Não a contamos como filtro adicional.

3. **Expandir o primeiro bit de 0x0101 em monômios foi uma alternativa ruim para compactação.** A expansão quartica possui aproximadamente 2,95 milhões de termos por ramo. Mantivemos a descrição por contadores e procuramos frequências com estrutura mais simples.

## Codificação e verificações

A implementação modular utiliza contadores de quatro bits e dispensa as variáveis que escolhem o sinal da amplitude. C0 usa 19161 variáveis auxiliares e 33271 cláusulas CNF; C2 usa 9620 variáveis auxiliares e 16699 cláusulas CNF. As contagens são de componentes separados; a implementação conjunta atual não compartilha todas as variáveis possíveis. Não foi demonstrada melhora de tempo de solução.

O teste conjunto passou nos oito controles fixados, cobrindo ambos os ramos e todas as combinações de aprovação e rejeição. Houve controles positivos: isso não é uma prova de insatisfatibilidade.

Evidências principais: T72_CONDICOES_MODULARES_VERIFICACAO.json, VERIFICAR_CONDICOES_MODULARES_T72.py, T74_CONGRUENCIAS_COMPACTAS_VERIFICACAO.json e CODIFICADOR_WALSH_MODULAR.py. A ponte quadrática com Q4 tem verificador próprio: VERIFICAR_REDUCAO_QUADRATICA_T70.py.

O próximo passo útil é testar os sobreviventes explícitos com condições novas selecionadas por estrutura e custo, ou compartilhar os valores por órbita na codificação. Aumentar o tempo do solver não substitui a identificação desses ganhos.
