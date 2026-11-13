# Exclusão reproduzível da classe 129 de V1

Para as quárticas mistas com simetria de rotação em 12 variáveis,
o verificador parte dos 25 parâmetros do mapa da classe 129 de V1.
Ele constrói a base a partir do modelo, sem carregar uma lista de suportes.

O balanceamento é imposto por somas de caracteres. Os momentos de
suporte são equações booleanas obtidas ao multiplicar até quatro bits
do mapa e somar contra os monômios de grau até dois. Produtos e somas
lineares das equações reduzem os 25 parâmetros a um espaço afim de
dimensão 20. As equações restantes são avaliadas em paralelo em CPU.

Dos 90.112 mapas que passam pelos momentos de suporte, 11.232 também
têm 16 pontos em cada fibra. Nesses mapas, o momento constante da
fibra 5 e os dois momentos lineares do par {2,13} anulam todas as
direções de fase. Os respectivos resíduos são pares, pois a fibra 5
tem tamanho 16 e a união das duas fibras do par tem a forma
Z × F₂², com |Z|=8. Só 480 mapas satisfazem os três momentos.
Todos os 480 estão em A₂ e caem por um momento da fibra passiva 1.

| Geometria de Z₁ | Mapas | Momento que exclui |
| --- | ---: | --- |
| Quatro pontos numa fatia de peso dois | 288 | s₁ |
| Dois pontos em d=3 e dois em d=5 | 192 | s₂ |

Os dois momentos locais também têm justificativa por identidades
nas bases dos espaços afins. No ramo 2+2, são quatro espaços
de dimensão 9 e a identidade é a soma de duas derivadas.
O argumento global ainda usa uma checagem finita em CPU para
estabelecer a entrada em A₂ e a cobertura pelos perfis.

## Consequência geométrica dos momentos de suporte

Dentro do envoltório de dimensão 19, escreva
`rho(y,d) = c_d + L_d y`, com `L_d d = 0`.
Nas três fatias ativas, `d=1,2,4`, os pares `(a,b)`
são os três vetores não nulos de F₂².
Fixe um rótulo t. Para cada fatia ativa, some em F₂³ os pontos
y que satisfazem `rho(y,d)=t`. As condições de ortogonalidade
de `a e_t` e `b e_t` contra as três coordenadas de y obrigam
as três somas vetoriais a ser iguais.

Se um dos L_d tem posto 2, tome t em sua imagem afim. A fibra
naquela fatia é um par na direção d, e a soma vetorial é d.
Nas outras fatias, uma fibra vazia ou de dimensão pelo menos 2
tem soma zero. Uma fibra de dimensão 1 tem soma igual ao índice
da outra fatia. Nenhuma dessas somas é d. Assim, os três L_d
têm posto no máximo 1.

Essa consequência usa momentos de suporte e independe do
levantamento. A verificação a partir dos 25 parâmetros mostra que,
depois do momento da fibra 5, só ocorrem os perfis (0,0,0) e
(1,1,1) nas fatias ativas. No primeiro perfil, os dois momentos
do par {2,13} são nulos nos 480 mapas. No segundo perfil, cada
um dos três pares de momentos não nulos ocorre em 768 mapas.
A dedução simbólica desse último fato continua aberta.

As hipóteses deste lema permitem posto 1 nas três fatias.
Escolha três rótulos distintos A, B, C e faça as imagens das
fatias ativas serem {A,B}, {B,C} e {C,A}. Em cada fatia, use
uma forma linear não nula que anule d para selecionar o rótulo.
Atribua as cinco fatias passivas, como mapas constantes, aos
cinco rótulos restantes. Cada fibra de rho tem oito pontos.
Cada contribuição ativa tem quatro pontos e soma vetorial zero,
pois é um plano afim. Assim, todos os momentos afins de a e_t
e b e_t se anulam. O exemplo delimita o lema de posto sem impor
as demais identidades do modelo com simetria de rotação.

## Nota sobre a fórmula de seleção

Na expansão de grau três, a contribuição dos termos lineares
de h é a parte linear de h avaliada no radical de p. A fórmula
do Carbon usa nesse lugar a derivada de h inteiro, o que pode
introduzir um termo extra. Por exemplo, em F₂³ tome
p = y₁y₂ + y₁y₃ + y₂y₃, h = y₁y₂, c=0 e ponto base 0.
O radical é 111. Nos quatro pontos onde p=0, h vale zero.
A derivada de h no radical, avaliada na origem, vale 1.
O termo quadrático da fórmula proposta também vale zero,
pois D₃p(111)=0. A fórmula com a parte linear de h corrige
esse caso e mantém as especializações usadas nas duas provas.

## Redução por células do Opus

No envoltório de dimensão 19, suponha anulada a parte linear em
y da fatia d=7. O quociente rho tem dimensão 12 e cada valor
define uma célula afim de dimensão 5. Reexecutei o verificador
do Opus no modelo do repositório. Dos 4.096 valores de rho,
174 satisfazem as condições preliminares de suporte.

- Em 112 células, ao menos um dos dois momentos do par {2,13}
  é constante 1.
- Em 32, os dois momentos são zero, mas a paridade das órbitas
  da troca das metades força tamanhos de fibra 8 ou 24.
- As 30 restantes têm as três fatias ativas constantes e
  pertencem a A₂.

O verificador estendido parte do envoltório de dimensão 19,
sem impor o anulamento na fatia d=7. Dos 16.384 valores de
rho, 518 satisfazem as condições preliminares. O par {5,10}
é passivo em todas as 518 células. O momento da fibra 5
exclui 344 células e força a parte linear de rho na fatia
d=7 a se anular nas 174 restantes. As identidades da célula
são conferidas no ponto base e nas cinco direções. A verificação
global a partir dos 25 parâmetros certifica que o envoltório
contém todos os mapas admissíveis.

Também há uma certificação menor do envoltório, executável
com a opção `--hull-only`. Depois de reduzir os 25 parâmetros
a 20, o quociente rho tem dimensão 15 e as cinco direções de
seletor preservam as equações do envoltório. Fora do envoltório,
272 valores de rho satisfazem o balanceamento do quociente e
os momentos afins nas fatias ativas. Todos os 272 falham
na mesma equação de suporte, o momento de s₁s₂ na fibra 0.
O par {0,15} é passivo nessas células. Entre seus oito
pontos em z, dois estão na diagonal d=0 e têm rótulos distintos.
Os outros seis se emparelham pela troca das metades, com
rótulos iguais em cada par. A fibra 0 tem, portanto, número
ímpar de pontos com s₁=s₂=1. As cinco direções do seletor
preservam a igualdade nos pares e trocam juntos os rótulos
dos dois pontos diagonais.

## Reprodução

A extensão por células exclui 15 dos 30 valores de rho em A₂
pelo tamanho da fibra 2. As 15 células restantes se dividem em
9 com uma fatia e 6 com duas meias-fatias. O verificador confere
o momento que exclui cada célula por interpolação de grau dois
nas cinco direções de seletor. A geometria do par passivo
justifica o tamanho do conjunto de soma em toda a célula.

O mesmo programa de reconstrução sem catálogo aceita
`--chart 1`, `--chart 37` e `--chart 164`. Na classe 1, seis
momentos isolados excluem 11.200 suportes. Nos 1.216 restantes,
as equações afins do bit seguinte módulo 4 já são incompatíveis.
Nas classes 37 e 164, dois e três momentos isolados, respectivamente,
excluem 1.152 e 512 suportes. A reflexão transporta as exclusões
para 51 e 178, verificável pelas opções correspondentes.

```powershell
python outputs/prove_v1_class129_entry.py work/n12-l3-cloud/research_updates/2026_11_09_n12_mixed
python outputs/prove_v1_class129_entry.py work/n12-l3-cloud/research_updates/2026_11_09_n12_mixed --hull-only
python -I outputs/verifica_entrada_A2_celulas.py work/n12-l3-cloud/research_updates/2026_11_09_n12_mixed
python outputs/audit_v1_class129_affine_branches.py work/n12-l3-cloud/research_updates/2026_11_09_n12_mixed work/n12-mixed/v3-symbolic/dim4-reconstruction-gh/mapas_V1.txt
```

## Plano comum dos momentos das fases de V1

Nos 113.040 suportes admissíveis do catálogo, a imagem das 19 direções
de fase nos 48 momentos está contida no plano fixo gerado pelas máscaras
0x084006c00810 e 0x106002400c20. O bit 3t+i corresponde ao momento na
fibra t com multiplicador 1, s₁ ou s₂, para i=0,1,2. Em cada uma das
14 classes, as colunas observadas ao percorrer os suportes atingem
o plano inteiro. Os postos por suporte são 0 em 1.632 casos,
1 em 22.000 e 2 em 89.408.

O teste é exaustivo no catálogo. Falta deduzir o plano das identidades
do modelo. O plano dá uma condição necessária imediata sobre o lado
direito. Para testar compatibilidade, ainda é preciso usar a imagem
efetiva em cada suporte quando o posto é menor que dois.

O verificador é `check_v1_common_phase_plane.py`. Seus dois argumentos
são o diretório do modelo e o catálogo de suportes V1. O script
`export_v1_moment_sample.py` gera os conjuntos de descoberta e teste
cego com classes distintas e controles positivos.
