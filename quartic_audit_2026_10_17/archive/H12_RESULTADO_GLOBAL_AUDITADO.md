# H(12,4): resultado computacional global auditado

**A busca recebida percorreu os 2^43 = 8.796.093.022.208 vetores de coeficientes de H(12,4) e reportou zero funções bent. A auditoria local da fonte, dos filtros e de todos os registros do log passou.**

Aqui H(12,4) é o espaço sobre F₂ gerado pelas 43 somas de órbitas cíclicas distintas de monômios de grau quatro em 12 variáveis. A conclusão se refere a esse espaço de funções homogêneas, conforme implementado no gerador. Não abrange todas as funções booleanas de grau quatro.

## Resultado da execução

| Etapa | Quantidade |
|---|---:|
| Vetores de coeficientes percorridos | 8.796.093.022.208 |
| Lotes de 1.048.576 candidatos | 8.388.608 |
| Sobreviventes dos 43 filtros quadráticos | 949.760 |
| Sobreviventes também de W(0)=±64 | 15.779 |
| Bent após Walsh completo | **0** |

O log termina com `COMPLETE_RANGE`, início zero e contagem 8796093022208. Os metadados usam a base identidade dos 43 coeficientes originais, não a base de 36 direções da busca anterior. **Nenhuma das cinco leis iniciais foi imposta nesta busca global.**

O cabeçalho registra uma NVIDIA A100-SXM4-40GB e aprovação dos 2.093 controles CPU/GPU. A soma dos tempos de kernel registrados é aproximadamente 2.758,03 segundos; isso não mede o tempo total de preparação, compilação, CPU e interface.

## O que foi conferido localmente

1. Foram lidos integralmente os 8.388.608 registros de lote, verificando início, fim, tamanho, continuidade e incrementos das contagens. O log completo tem 1.125.887.444 bytes. A leitura até o fim também confere seu CRC no ZIP.
2. Os hashes da fonte no arquivo, nos metadados e no relatório de auditoria coincidem. A diferença em relação à fonte preparada anteriormente é somente duas linhas em branco e o limite padrão de tempo, de 2.400 para 5.400 segundos. O algoritmo e todas as constantes matemáticas são iguais.
3. As 43 colunas de valores das funções originais foram reconstruídas a partir dos monômios por uma transformação de Möbius, independentemente da avaliação do gerador.
4. Todos os filtros foram reconstruídos por uma identidade de carry, sem interpolação: conferiram os 1.849 coeficientes lineares e os 38.829 coeficientes quadráticos superiores dos 43 filtros.
5. O relatório recebido de repetição CPU/GPU de oito intervalos é consistente com o domínio e com os metadados. Essa repetição é amostral e não substitui uma segunda enumeração inteira.

O binário recebido não foi executado nesta máquina. A enumeração completa na GPU não foi repetida localmente; a auditoria local valida a fonte, a matemática dos filtros e a consistência de todos os registros apresentados.

## Por que os filtros não descartam bent

Se f é bent em 12 variáveis, cada coeficiente de Walsh é ±64. Para um suporte coordenado S de tamanho oito,

`Σ_{x: supp(x)⊆S} (−1)^f(x) = (1/16) Σ_{a: supp(a)⊆Sᶜ} W_f(a)`.

A soma à direita tem 16 termos ±64. Como a soma de 16 sinais é par, a soma dos sinais no subcubo é múltipla de oito. Consequentemente, o peso de f nesse subcubo é múltiplo de quatro. Seu bit de ordem um deve ser zero. A invariância por rotação permite considerar os 43 representantes cíclicos de suportes de peso oito.

Para um vetor de coeficientes c, cada f_c(x) é uma forma linear em c. O segundo bit de uma soma de bits t_x é `Σ_{x<y} t_x t_y` em F₂. Portanto cada filtro é quadrático em c, em todo o espaço de 43 dimensões, sem hipóteses adicionais.

Se v_j é a coluna de valores da j-ésima função básica num subcubo, o coeficiente linear do filtro é o segundo bit de |v_j|. O coeficiente de c_i c_j é

`(|v_i| mod 2)(|v_j| mod 2) + |v_i ∩ v_j| mod 2`.

Foi essa fórmula que a auditoria independente usou para conferir os filtros embutidos.

Depois dos filtros, bentness exige `W(0)=4096−2·peso=±64`, ou seja, peso 2016 ou 2080. Para todos os sobreviventes finais, o programa calcula os 4096 coeficientes por Walsh–Hadamard e exige valor absoluto 64 em cada um. Nenhum dos 15.779 sobreviventes desse estágio satisfez a condição completa, segundo o log da execução auditada.

## Identificação e reprodução

ZIP original recebido, SHA-256:

`9fbe70331b23097993252a1a664ef3248d618c7720f61395c5baa43665a796ad`

Fonte CUDA, SHA-256:

`0e346b6a0ecac8fdb553ee277333a4eb48244e163902ce238c706a06c59b2cba`

Log completo, SHA-256:

`ccfe80ac2dbbe8a6324f82d61752240e7c9821d0c4505c00035ecaaab10de95a`

Para repetir a auditoria dos arquivos sem GPU, usando Python 3.10 ou posterior:

```text
python VERIFICAR_PACOTE_GLOBAL_H12.py RESULTADO_H12_GLOBAL.zip --out AUDITORIA_H12_GLOBAL.json
```

O verificador reconstrói os filtros e lê todos os lotes do log; não executa o binário do ZIP. O pacote de preservação inclui o ZIP original, os relatórios, a fonte recebida e o verificador.

## Alcance científico

Este é um resultado computacional exaustivo para H(12,4), com auditoria da implementação e do registro de execução, sem a dependência das cinco leis da busca anterior. Para uma apresentação científica, convém reproduzir a enumeração inteira em outra execução independente e disponibilizar os materiais de reprodução.

O log não é um certificado formal de cada operação do hardware. Não se conclui inexistência em H(16,4), em toda dimensão par, nem novidade frente à literatura. A cota anterior de H(16,4) permanece um resultado separado.
