# Avanço Sol — estrutura exata das fibras quínticas em n=16

Data: 6 de outubro de 2026.

## Resultado novo desta rodada

Foi calculado exatamente, para cada uma das 255 fibras não nulas
[
F_z(u)=f(u,u+z),\qquad z\in\mathbb F_2^8\setminus\{0\},
]
o posto do mapa linear que envia os 273 coeficientes das órbitas quínticas homogêneas RS em 16 variáveis para a tabela-verdade de 256 bits da fibra.

O resultado muda a prioridade experimental do projeto.

A fibra complementar (z=1^8=0xff), usada intensamente nas campanhas anteriores, tem posto **12**. É a fibra individual de menor posto entre todas as 255 fibras não nulas.

Em contraste, **80 fibras têm posto 71**, o maior posto individual observado. Por simetria cíclica existem 35 classes de rotação não nulas; dez dessas classes têm posto 71.

Histograma exato dos postos:

| posto | número de fibras |
|---:|---:|
| 12 | 1 |
| 20 | 2 |
| 32 | 4 |
| 33 | 4 |
| 39 | 4 |
| 55 | 8 |
| 57 | 16 |
| 58 | 16 |
| 61 | 16 |
| 63 | 40 |
| 67 | 56 |
| 69 | 8 |
| 71 | 80 |

O resultado anterior para a fibra complementar foi reproduzido: posto 12, 4.096 perfis possíveis e 1.670 perfis balanceados.

Para a fibra periódica (z=0x55), o posto é 20. Sua imagem inteira contém (2^{20}=1.048.576) perfis e foi enumerada exatamente; **288.195** são balanceados. Portanto essa fibra isolada também não fornece uma obstrução universal.

## Conjunto pequeno que determina todos os coeficientes

Uma seleção gulosa determinística das fibras que maximizam o ganho de posto produziu

[
0x1f,,0x37,,0x2f,,0x3b,,0x3d,,0x57,,0x5b,,0x07,,0x0b,,0x15.
]

Os postos conjuntos após cada inclusão são

[
71,127,157,186,215,242,258,263,268,273.
]

Assim, as tabelas dessas **dez fibras determinam injetivamente os 273 coeficientes quínticos**.

Isso não prova que basta verificar dez fibras para bentness. A implicação correta é outra: qualquer modelagem exata dos coeficientes pode ser feita usando apenas essas dez saídas sem perda de informação sobre a função quíntica dentro do espaço homogêneo RS.

## Consequência para a estratégia

A campanha anterior privilegiava (z=1^8) porque essa fibra tem descrição algébrica simples. O novo cálculo mostra que ela é extremamente comprimida: 261 dimensões do espaço de coeficientes ficam invisíveis nela.

Para a próxima tentativa de certificado universal, a prioridade deve ser:

1. usar fibras de posto 71 como filtros principais;
2. medir o posto conjunto antes de adicionar qualquer nova fibra;
3. formular balanceamento como restrição exata sobre a imagem conjunta;
4. acrescentar a condição da derivada de todos os uns e o peso global somente depois;
5. procurar UNSAT/cobertura exata em um conjunto pequeno de fibras de alto ganho informacional;
6. usar A100 apenas depois dessa redução estrutural.

Mais amostragem densa na fibra complementar, isoladamente, tem baixo valor informacional.

## Relação com o resultado cúbico

A auditoria desta rodada também releu o argumento geral cúbico na versão consolidada. Não foi identificada uma falha imediata no encadeamento:
redução por fator ímpar -> anulação diagonal -> obstrução em potência de dois.
Esse resultado deve continuar classificado como prova algébrica em revisão, com prioridade bibliográfica e revisão externa ainda pendentes.

A busca pública consultada nesta rodada continua mostrando Meng--Chen--Fu (2010) como resultados parciais e Sun--Shi--Liu--Fu (2026) descrevendo seus avanços como solução parcial da conjectura. Isso não certifica novidade do nosso teorema geral; apenas não revelou, nessa busca, um enunciado publicado idêntico.

## Reprodução

Execute:

```bash
python3 fiber_rank_spectrum_d5.py fiber_rank_spectrum_d5.json
```

O programa usa somente a biblioteca padrão, reconstrói as 273 órbitas, todas as 255 fibras e as 35 classes cíclicas. As asserções verificam os invariantes independentes já conhecidos da fibra complementar e a injetividade do conjunto guloso.

## Status científico

- Espectro de postos das fibras: **cálculo exato**.
- Contagem dos perfis balanceados em (z=0xff) e (z=0x55): **enumeração exata**.
- Conjunto de dez fibras com posto conjunto 273: **álgebra linear exata**.
- Inexistência geral de quínticas homogêneas RS bent: **não provada**.
- Estratégia de usar as dez fibras para um certificado: **direção de pesquisa**, não teorema.
