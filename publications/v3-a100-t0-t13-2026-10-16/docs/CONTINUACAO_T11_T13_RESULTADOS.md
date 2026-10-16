# Continuação real no Colab: T11–T13

## O que mudou nesta rodada

O usuário autorizou continuar usando a A100 disponível. O notebook anterior
foi ampliado, conservando as células e evidências originais. Não houve
publicação nem alteração do preprint.

1. Foi implementado Poisson no plano das quatro fibras de período dois,
   agrupando sinais do dual por órbitas cíclicas. A necessidade do filtro foi
   verificada por identidade com o Walsh completo de funções n=12 e por
   controles bent quadráticos em n=12,16,20.
2. Os espectros foram pré-calculados em inteiros de 16 bits, com energias e
   acumulações em inteiros de 64 bits. Em n=20, as duas tabelas das fibras
   alternadas ocupam 8 GiB cada; ambas cabem na A100 de 40 GiB. Isso tornou
   viável a enumeração de toda a imagem sem repetir bilhões de FWHTs.
3. A cobertura em n=20 contém os 2^32 estados do mapa de restrição. As duas
   condições necessárias anteriores excluem 3/4 deles. Os 2^30 restantes
   foram todos enumerados: 1.073.741.824 estados, sem amostragem.

## Contagens exatas

| Caso | Estados da imagem original | Sobreviventes dos novos filtros |
|---|---:|---:|
| n=12, posto 12 | 4.096 | 361 |
| n=16, posto 21 | 2.097.152 | 391.804 |
| n=20, posto 32 | 4.294.967.296 | 536.864.768 |

Em n=20 a etapa completa após o piloto levou 17,7968 segundos, além de
0,7745 segundo para construir as tabelas. A fração sobrevivente é
262141/2097152; a exclusão é 87,50014305114746% do espaço original 2^245,
pois as fibras do mapa linear têm tamanho constante 2^213.
Em n=16 a exclusão passa de aproximadamente 55,04% no filtro anterior para
aproximadamente 81,32% com Poisson no plano. Nenhum desses casos foi fechado.

## Estrutura exata e resultado matemático

Uma amostra apenas sugeriu uma lei afim. Depois ela foi verificada em uma
SEGUNDA passagem pelos 2^30 estados, com as contagens:

- rejeitados fora do hiperplano: 536.870.912;
- rejeitados dentro do hiperplano: 6.144;
- aceitos fora do hiperplano: zero;
- aceitos dentro do hiperplano: 536.864.768.

Todos os 6.144 estados excepcionais foram exportados e conferidos por
avaliação direta do ANF na CPU, nas quatro fibras e em todas as frequências.
As comparações iniciais também incluem TODAS as 4.096 imagens n=12, 256
pontos aleatórios n=20 e 256 sobreviventes n=20, além de 256 pontos n=16.

A lei afim é exatamente a anulação do coeficiente cúbico da restrição ao
período quatro. O arquivo PROPOSICAO_REDUCAO_PERIODO_QUATRO.md contém uma
demonstração, independente da enumeração maciça, das três condições
necessárias para toda a família n=4p, p primo>=5:

    c_p=0; XOR_even(c_d)=1; tau(f)=0.

Isso exclui exatamente 7/8 do espaço nessa família infinita. A prova usa
órbitas de ordem p, congruência de Walsh e Parseval em quatro variáveis.
Não usa o argumento especulativo anterior de gcds de circulantes.
As fórmulas foram verificadas em TODOS os geradores para p=5,7,11,13,17,19,
e a classificação das 32 funções RS da base foi conferida integralmente.
A prova analítica é o que cobre os demais primos; não é uma inferência dos
seis testes finitos. A prioridade bibliográfica permanece não estabelecida.

## Limites e próxima etapa concreta

As 536.864.768 classes sobreviventes NÃO são funções bent certificadas.
O mapa de posto 32 deixa 213 dimensões livres do espaço original. Logo,
2^32 estados da imagem não significam uma busca direta sobre 2^245 funções.
A próxima etapa deve acrescentar fibras novas ou condições que dependam
dessas dimensões, com mudança de base explícita e contagem das extensões.

Não repetir a enumeração da imagem de posto 32 sem uma condição nova: ela
agora tem descrição compacta exata, um setor afim de codimensão três menos
6.144 estados explicitamente listados. Conservar essa descrição como prefixo
da futura filtração. O caso n=20 e a conjectura global continuam abertos.

O certificado JSON T11 preserva também o piloto. Quando existe resultado
EXACT_COMPLETE_IMAGE e checkpoint com done=target, esse é o resultado final;
o status SAMPLE_ONLY em T12_candidate_laws.json documenta somente a fase
de descoberta, substituída pela verificação integral T12_verified_structure.

O notebook executado e os scripts necessários estão no pacote. Para um
runtime novo, enviar code/*.py e o ZIP em reference/ para /content/ antes
de executar as células na ordem. A memória GPU necessária para a etapa
n20 é superior a 16 GiB. O preprint e os relatórios da rodada anterior
ficam preservados como histórico, com a data de sua execução.
