# Terceira rodada Sol — auditor completo de derivadas em forma comprimida

Data: 6 de outubro de 2026.

## Identidade de transporte

Use as coordenadas

[
x=(u,u+z),qquad u,z\in\mathbb F_2^8.
]

Uma direção original (d=(a,b)\in\mathbb F_2^{16}) transforma essas coordenadas em

[
(u,z)\longmapsto(u+a,z+a+b).
]

Portanto

[
\operatorname{wt}(D_{(a,b)}f)
=
\sum_{z\in\mathbb F_2^8}
\operatorname{wt}\bigl(
F_z(u)+F_{z+a+b}(u+a)
\bigr).
]

Essa identidade permite calcular qualquer derivada usando apenas as fibras.

## Compressão por simetria

Para uma função simétrica por rotação, as 65.535 direções não nulas se dividem em **4.115 classes cíclicas**.

O arquivo `full_derivative_compressed_d5.py`:

1. constrói somente as 35 fibras representantes;
2. reconstrói exatamente as 256 fibras por rotação das coordenadas;
3. calcula uma representante de cada uma das 4.115 classes de derivadas;
4. decide bentness pela caracterização por derivadas.

Assim, para uma HRSBF, o teste

[
\operatorname{wt}(D_af)=32768
\quad\text{para todo }a\ne0
]

é exaustivo verificando apenas as 4.115 classes.

O script não depende da tabela global explícita de 65.536 pontos para sua avaliação principal.

## Validação independente

A reconstrução comprimida foi comparada com avaliação direta da tabela global para múltiplas direções de convenções diferentes, incluindo

[
0x1, 0x2, 0x3, 0x101, 0xffff, 0x1234, 0x5555, 0x8001, 0xff, 0xff00.
]

Todos os pesos coincidiram exatamente.

Para a testemunha quíntica de seis órbitas (`0x602809`):

- classes de derivadas balanceadas: 0 de 4.115;
- peso mínimo de derivada: 20.960;
- máximo: 34.048;
- hash ordenado: `4528d45b8f1cbad330c474566b6bf82397392db346672af639fa4ccd91257bf5`.

Para o candidato usado na validação do avaliador comprimido anterior,

`0x1b93d5a542da0dd31aa5e9bb862362c378c3509303971333987cfca4fbf49afd3e679`:

- 87 fibras não nulas são desbalanceadas;
- apenas 144 das 4.115 classes de derivadas são balanceadas;
- 3.971 classes falham;
- pesos das derivadas variam de 31.936 a 33.664;
- hash ordenado: `bccff92e1b4784ee53773fe33b83dca79b3a938c881340d6cb9534ca07d7fd28`.

## Consequência para a pesquisa

O número de fibras ruins sozinho é um objetivo incompleto. Um candidato pode estar relativamente próximo do balanceamento das fibras e ainda falhar em milhares de classes de derivadas.

A próxima função objetivo para busca deve separar pelo menos:

- fibras não balanceadas;
- desvio agregado das 4.115 classes de derivadas;
- número de classes de derivadas exatamente balanceadas.

O auditor completo comprimido é rápido o suficiente para validar elites frequentemente, mas ainda não deve ser usado ingenuamente em cada mutação de uma busca de milhões de passos.

## Status

- fórmula de transporte de derivadas: **identidade algébrica exata**;
- redução 65.535 direções -> 4.115 classes: **simetria exata**;
- auditor comprimido completo: **validado independentemente**;
- bentness de um candidato que passe todas as 4.115 classes: **equivalente**, pela caracterização clássica por derivadas;
- prova de inexistência de quínticas homogêneas RS bent: **ainda não obtida**.
