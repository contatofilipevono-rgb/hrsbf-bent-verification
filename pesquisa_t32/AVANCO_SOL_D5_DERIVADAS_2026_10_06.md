# Segunda rodada Sol — derivadas diagonais para quínticas em n=16

Data: 6 de outubro de 2026.

## Resultado estrutural exato

Para cada vetor não nulo (p\in\mathbb F_2^8), foi estudado o mapa linear

[
c\in\mathbb F_2^{273}\longmapsto D_{(p,p)}f_c,
]

onde (f_c) percorre todas as funções homogêneas quínticas simétricas por rotação em 16 variáveis.

Os 255 postos são exatamente:

| posto | direções |
|---:|---:|
| 112 | 1 |
| 188 | 2 |
| 235 | 4 |
| 247 | 8 |
| 263 | 16 |
| 265 | 32 |
| 266 | 192 |

A direção (p=1^8), isto é, a derivada na direção de todos os uns em 16 variáveis, é a **única direção diagonal de posto mínimo 112**.

Consequência metodológica: trocar (D_{1^{16}}) por uma direção diagonal genérica não simplifica a classificação. Quase todas as direções preservam praticamente todos os 273 parâmetros.

## Estrutura interna de D_1

Na imagem de (D_{1^{16}}), os blocos homogêneos isolados têm postos:

- grau 4: 84;
- grau 3: 34;
- grau 2: 6;
- grau 1: 1;
- grau 0: 0.

Ao adicionar os graus do maior para o menor, os ganhos independentes são:

[
84, 27, 0, 1, 0,
]

totalizando posto 112.

Portanto, dentro desta imagem, o bloco quadrático não acrescenta nenhuma dimensão depois dos blocos quártico e cúbico. Isso é uma dependência linear exata, não uma observação amostral.

## Comparação com o espaço ambiente

O espaço de todas as funções RS de grau no máximo 4 em 16 variáveis tem 161 geradores de órbita.

Impor invariância pela translação (x\mapsto x+1^{16}) deixa dimensão 125. Impor adicionalmente valor zero na origem deixa dimensão 124.

A imagem das derivadas (D_{1^{16}}f) de quínticas homogêneas RS tem dimensão 112.

Assim, ser uma derivada deste tipo impõe **12 restrições lineares adicionais** dentro do espaço natural das quarticas RS invariantes por complemento e nulas na origem.

Essas 12 restrições ainda não foram convertidas em uma contradição com balanceamento.

## Novo auditor de candidatos

Foi acrescentado `audit_quintic_candidate_constraints.py`.

Para qualquer candidato quíntico ele verifica exatamente:

1. peso global (32640) ou (32896);
2. balanceamento de uma fibra em cada uma das 35 classes de rotação de (z\ne0);
3. balanceamento de uma derivada (D_{(p,p)}f) em cada uma das 35 classes de rotação de (p\ne0).

Por simetria por rotação, um representante basta para cada classe.

O script aceita máscara hexadecimal, vetor de 273 coeficientes ou lista de representantes de órbita.

Exemplo:

```bash
python3 audit_quintic_candidate_constraints.py \
  --json testemunha_fibra_quadratica_balanceada.json \
  --output auditoria_testemunha_quadratica_d5.json
```

A testemunha anterior cuja fibra complementar é quadrática e balanceada é rejeitada fortemente: peso global 22528, somente 1 das 35 classes de fibras balanceada e nenhuma das 35 classes de derivadas diagonais balanceada.

## Próximo experimento

As próximas campanhas A100 não devem mais otimizar apenas:

- peso global;
- (D_{1^{16}});
- fibra (z=1^8);
- número de fibras ruins.

A função objetivo deve incorporar também as 35 classes de derivadas diagonais. Uma função bent precisa passar simultaneamente pelas 35 classes de fibras e pelas 35 classes de derivadas.

Prioridade recomendada:

- reaplicar o auditor às elites antigas;
- medir quais poucas classes de derivadas eliminam mais sobreviventes condicionados;
- construir um cover conjunto de fibras + derivadas em holdout independente;
- somente então relançar busca adaptativa em A100.

Um cover obtido por amostragem continua sendo evidência, não prova universal.

## Estado científico

- espectro de postos das 255 derivadas diagonais: **cálculo exato**;
- posto 112 único de (D_{1^{16}}): **cálculo exato**;
- codimensão 12 da imagem especial: **álgebra linear exata**;
- novo conjunto de 70 testes de necessidade por candidato: **auditoria exata**;
- inexistência geral de quínticas homogêneas RS bent: **ainda não provada**.
