# Formas quadráticas das fases nos blocos de dimensão quatro

O verificador `dim4_phase_profiles.py` recebe as listas `V1_exclusivo_mapas.json` e `V2_exclusivo_mapas.json` produzidas por Fable. Reconstrói cada mapa na base independente do repositório a partir da tabela dos rótulos. Então resolve as paridades lineares dos momentos e elimina as relações lineares que vêm das condições módulo 4. A contagem se refere aos mapas positivos fornecidos nas duas listas.

Em V1, sobram uma quadrática de posto 2 e três equações lineares em cada um dos 120 mapas. Em 96 mapas, a quadrática é balanceada, o que dá metade das fases após a redução linear. Nos outros 24, ela zera em três quartos do espaço. Isso dá 1.900.544 fases.

Em V2, 656 mapas ficam com sistemas lineares. Nos outros 112 sobram duas quadráticas. Entre as três combinações não nulas das duas equações, exatamente uma tem soma de Gauss negativa e módulo (2^{d-1}) no espaço residual de dimensão (d). Essa quadrática tem posto 2 e é constante nas classes do radical, portanto sua anulação fixa dois bits afins. A outra equação restringe-se a uma condição linear não constante nesse subespaço. A solução conjunta é um subespaço afim de codimensão três e tem (2^{d-3}) fases. A soma de V2 é 2.326.528.

As contagens são verificadas mapa a mapa. A explicação das dimensões lineares por família polar e a dedução estrutural da lista de mapas positivos continuam abertas.

SHA-256 dos insumos:

- V1: `1c4b463362692317f0da9edbd96376f1f8d6e7e886c23079b22bf76c3da9f72b`
- V2: `a3e725fd2a69d48092a6091e5bf23cbe57211e05a66cb6ad7ecd2490b2ccd9ed`

## Conferência de todos os suportes da enumeração original

O comando `dim4_all_support_phases.py <pasta> --space <1 ou 2> --output <json>` recebe também `mapas_V1.txt` e `mapas_V2.txt`. O programa reconstrói a base original de códigos e confere a convenção de todos os 888 mapas positivos contra seus rótulos publicados. Em seguida reconstrói a fase e suas condições na base do repositório. A tabela usa a ordem de aplicação dos testes.

| Resultado | V1 | V2 |
| --- | ---: | ---: |
| Afinidade maior já decidida pelo mapa | 0 | 149.432 |
| Sistema linear de paridades incompatível | 49.248 | 14.064 |
| Contradição durante a eliminação dos momentos módulo 4 | 32.200 | 2.112 |
| Equações quadráticas remanescentes sem zeros | 0 | 96 |
| Fases existentes, todas no bloco maior | 31.472 | 0 |
| Mapas com fases exclusivas | 120 | 768 |
| Total de suportes | 113.040 | 166.472 |

Em V1, nos 31.472 mapas com fases em blocos maiores, as condições lineares já fixam o coeficiente misto de H no valor que caracteriza a afinidade em U. A igualdade é verificada tanto na origem quanto em todas as direções do espaço após as substituições lineares, antes de contar os zeros da quadrática. O total dessas fases é 300.548.096.

Em V2, a contagem de Gauss resolve as 96 exclusões finais e as 112 admissões que têm duas quadráticas. Os outros 656 mapas positivos têm apenas equações lineares. O programa guarda também o resultado por classe de polar mista. A lista de suportes continua vindo da enumeração original. Nenhum teste percorre atribuições das fases.

SHA-256 das listas de suportes `mapas_V1.txt` e `mapas_V2.txt`, respectivamente:

- `8d0eeebfd9cde035757047f220218098b697511c176614538f871c0a0a8ad7ea`
- `95c397ebb46513fa28c17b5a1b1331c90ac18d12be883b9acd925dc3af2c16c1`

## Reconstrução da lista de suportes

Para cada escolha dos termos mistos, imponha a soma zero dos produtos de coordenadas do rótulo vezes os monômios de grau até dois no domínio. Cada produto de coordenadas é soma de indicadoras de fibras. As equações são polinômios nos parâmetros do mapa. Extraia as consequências lineares, substitua e repita com produtos de até quatro coordenadas. Por fim, agrupe os caracteres dos rótulos no espaço reduzido e use as relações lineares necessárias ao balanceamento.

O filtro deixa 14 espaços afins e 19.922.944 mapas candidatos em V1, contra 2³³ inicialmente. Em V2 deixa 32 espaços afins e 19.267.584 candidatos, contra 2³¹. Um percurso finito nesses espaços recompõe as duas listas com os mesmos hashes acima. A recontagem algébrica das fases nessas listas reconstruídas reproduziu todos os mapas positivos e os totais 1.900.544 e 2.326.528. [Verificação completa no GitHub](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/43351994463)

Multiplicar as equações quadráticas restantes por cada parâmetro e eliminar os monômios cúbicos reduz V2 a 15.335.424 candidatos. Todos os 166.472 suportes de V2 passam também por esse filtro. O total dos dois blocos passa a 35.258.368 candidatos, uma redução de 99,67% sobre o espaço inicial.

A observação de Fable sobre as 48 equações com 1, s₁ e s₂ é testada no mesmo verificador. A comparação exige que esse subsistema e as 144 equações tenham a mesma consistência em cada suporte analisado. Para contar as fases, o programa usa o sistema completo.
