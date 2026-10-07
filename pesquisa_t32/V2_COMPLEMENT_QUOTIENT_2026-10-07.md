# V2: quociente exato da fibra complementar em grau 5, n=16

## Proveniência

Branch de pesquisa `sol-quintic-2026-10-06`, HEAD antes desta etapa: `c20f3a2b2009182c307ab06731190fbabacf2c21`.
V1 conferida em `d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93`; nenhum arquivo da v1 é modificado.

## Resultado desta etapa

Para as somas das 273 órbitas monomiais homogêneas quinticas em 16 variáveis, o mapa linear que envia os coeficientes à tabela da fibra

    F_255(u)=f(u,u+255), u em F_2^8,

possui posto 12. O núcleo tem dimensão 261. Enumeramos todos os 4096 elementos da imagem, sem enumerar o espaço original de 2^273 funções. Exatamente 1670 têm peso 128 e são balanceados. A condição passa em 40,771484375% dos coeficientes e exclui 59,228515625% deles.

O JSON contém 12 máscaras de paridade de 273 bits, 12 geradores independentes da tabela de 256 bits e a lista completa dos 1670 estados balanceados. Isso é um certificado finito de uma condição sobre TODOS os coeficientes, não uma amostra de funções. Não há reivindicação de prioridade.

## Por que balanceamento é necessário

Escreva n=2m. Para uma função RS homogênea de grau ímpar, a meia-rotação emparelha os monômios, sem suporte fixo (um suporte fixo seria união de pares antipodais e teria tamanho par). Sobre D={(u,u)}, os termos emparelhados têm avaliações iguais. Portanto f(u,u)=0.

Defina S_z=sum_u (-1)^{f(u,u+z)}. Para a em F_2^m,

    W_f(a,a)=sum_z (-1)^{a·z} S_z.

Se f é bent, cada W_f(a,a) pertence a {+2^m,-2^m}. Somando em a e usando ortogonalidade de caracteres, a média desses números é S_0=2^m. Como nenhum excede 2^m, todos devem ser +2^m. A transformada inversa dá S_z=0 para z≠0. Assim todas as fibras não diagonais são balanceadas, inclusive z=255 quando m=8.

Este argumento é um fato estrutural de fibras, compatível com a decomposição de funções bent da literatura já indicada em `V2_LITERATURE_MAP_2026-10-07.md`. Não depende de reabrir a prova antipodal da v1.

## Certificado e verificação

Se c é a máscara de coeficientes, o programa calcula q_i(c)=paridade(c & p_i), usando as 12 máscaras p_i fornecidas. A tabela F_255 é a soma dos geradores g_i para os quais q_i=1. Logo a condição necessária é q(c) pertencer ao conjunto de 1670 estados listados.

A eliminação GF(2) verifica a reconstrução de todas as 273 colunas. O posto das 12 máscaras de paridade é verificado separadamente, de modo que cada estado do quociente tem exatamente 2^261 preimagens. Os 4096 bitstrings gerados são distintos. A implementação de tabela verdade completa verifica cada uma das 273 colunas na fibra, além de 128 máscaras densas determinísticas. Os hashes dos três programas são guardados no JSON.

Distribuição dos pesos na imagem:

| Peso | Número de estados |
|---:|---:|
| 0 | 1 |
| 32 | 8 |
| 64 | 252 |
| 96 | 952 |
| 128 | 1670 |
| 160 | 952 |
| 192 | 252 |
| 224 | 8 |
| 256 | 1 |

Reprodução:

    python pesquisa_t32/quintic_complement_quotient.py

## Uso e próximo passo

O filtro é calculável por 12 paridades e uma consulta de pertencimento. Pode ser usado em buscas quinticas que aceitam a condição de fibras. Não é suficiente para bentness: os 1670 estados não são 1670 funções bent.

A direção seguinte é combinar fibras de baixo posto e calcular o posto CONJUNTO das condições, sem assumir independência estatística entre elas. As fibras 0x55 e 0x11 são candidatas já identificadas. Só se deve enumerar imagens conjuntas após medir o posto e o custo. Se a imagem conjunta ainda for grande, usar as tabelas balanceadas como restrições simbólicas em um solucionador com certificados verificáveis. Nenhum resultado do solucionador é presumido nesta etapa.
