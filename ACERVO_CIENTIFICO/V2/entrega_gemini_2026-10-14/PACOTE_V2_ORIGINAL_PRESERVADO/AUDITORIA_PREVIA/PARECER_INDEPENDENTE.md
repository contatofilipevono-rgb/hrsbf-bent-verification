# Parecer técnico independente — evolução V2
**Data:** 2026-10-13 (America/New_York)

**Repositório auditado:** `contatofilipevono-rgb/hrsbf-bent-verification`, commit
`1a921c586903f4adf6cdb9c8668e7813f10512cb`, em particular
`V2_graphs/THEOREM_AND_PROOF.md` (blob `e4e5e70f6b97b00b04776d0e49d096d9fd8618eb`),
`V2_graphs/MANUSCRIPT_DRAFT.md` (blob `4328759b802a66e05df063ade0b1105cabdfb3f2`).
A evolução nova foi recebida em texto; não foi encontrada nesse commit.

## 1. Controles independentes reproduzidos

Computação exata sobre GF(2), reconstruindo órbitas de monômios e matrizes de contração:

| Resultado | Verificação independente |
|---|---|
| Semente n=8: quarticidade e espectro de C_phi | 24 monômios quárticos; posto 22/28; nulidade 6; espectro bivectorial 4:3, 8:60 |
| Bentness da semente V2 | Espectro Walsh com 256 entradas, todas de módulo 16 |
| n=10, 2 órbitas (0125),(0156) | 15 monômios; posto 44/45; espectro 10:1 |
| n=12, 3 órbitas (0123),(0127),(0137) | 36 monômios; posto 60/66; espectro 8:39, 10:16, 12:8 |
| Quarticas RS não nulas em n=8 | 1023 |
| Quarticas RS com completamento bent RS de grau <= 3 | 211 |
| Quarticas RS bent-completáveis e Grassmann-free | 64: 32 com posto 24 e espectro 4:15; 32 com posto 22 e espectro 4:3,8:60 |
| Dígrafos fracamente conexos rotulados d_2,...,d_7 | 3, 54, 3834, 1027080, 1067308488, 4390480193904 |
| Classes não rotuladas de dígrafos fracamente conexos em r=7 | 880471142, valor já catalogado na OEIS A003085 |

Obs.: os ensaios de bentness enumeraram 2^(4+7)=2048 combinações de órbitas RS quadráticas e cúbicas por forma quártica, sem constante nem termo linear (irrelevantes para bentness). Nem toda forma Grassmann-free é bent-completável.

## 2. Erro matemático demonstrado no adendo proposto

A afirmação "para **todo** Q de grau <=2, F_G+Q EA-indecomponível **se e somente se** G fracamente conexo" é falsa.

**Contraexemplo:** r=2; G não tem arcos; F_G(x1,x2)=(f(x1),f(x2));
Q(x1,x2)=(x_{1,0}x_{2,0},0). Então G é desconexo,
mas F_G+Q não se decompõe em soma direta por equivalência EA: a 4a derivada
recupera intrinsecamente os blocos V1 e V2 (pela condição (A) da semente),
e a derivada segunda mista na saída 1 é não nula. A adição de funções afins
e mudanças afins que preservam a decomposição dos blocos não eliminam esse termo.

A versão original no repositório apenas afirma, corretamente,
"G fracamente conexo => F_G+Q EA-indecomponível".

### Correção candidata mais forte

Assumindo o lema de recuperação dos blocos intrínsecos da V2,
F_G+Q é EA-decomponível (com dois fatores de saída não nulos)
se e somente se existe partição própria não vazia [r]=S ⊔ T tal que:

1. Não existem arcos de G entre S e T (em nenhuma direção);
2. Para todo i em S, a parte quadrática homogênea [Q_i]_2 depende apenas das
   variáveis x_j com j em S, e analogamente para i em T.

A direção 'se' segue por decomposição literal depois da remoção dos termos afins de Q.
Para 'somente se', a rigidez da 4a derivada obriga uma separação em uniões de blocos
originais e linhas de saída correspondentes; a 3a derivada mista exclui arcos entre
S e T; inexistentes os arcos cruzados, a 2a derivada quadrática implica o critério
bloco-diagonal para [Q]_2. Uma revisão formal é necessária antes de declarar o
bicondicional corrigido um teorema definitivo.

## 3. Lacunas de certificação

* A ordem |Aut(phi_8)|=1920, a ordem 40 do grupo G_{<=2}(f), os estabilizadores
  triviais e o teorema universal de ultra-rigidez **não foram reproduzidos** neste pacote.
* O código Lean fornecido **não formaliza** Aut(phi), recuperação do centroid,
  generalidade da classificação EA, digrafos ou família indutiva. A prova
  `quadratic_perturbation_exact_conjugacy` é um cancelamento condicional;
  não demonstra as hipóteses de ultra-rigidez. Não há compilação Lean certificada.
* A definição recursiva Lean de `d_labeled` usa chamadas `d_labeled k` com k
  variável sob somatório: requer justificativa de terminação/recursão bem fundada;
  o simples `by decide` em valores finitos não demonstra a recorrência combinatória.
* A classificação de n=8 validada neste pacote é por condição de bent RS completável
  + ausência de bivector decomponível no núcleo; ainda não é auditoria independente
  de centroid, simetria EA, nem prioridade bibliográfica.
* A OEIS A003085 já contém 880471142; não divulgar esse inteiro como uma
  descoberta original isolada. A novidade pode estar em sua interpretação como
  classes EA canônicas, **condicionada** ao teorema de classificação.

## 4. Referências para revisão

- V2 original, commit acima:
  https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/1a921c586903f4adf6cdb9c8668e7813f10512cb/V2_graphs/THEOREM_AND_PROOF.md
- OEIS A003085: https://oeis.org/A003085
- Polujan & Pott (2020): https://doi.org/10.1007/s10623-019-00712-y
- Zhang et al. (2024): https://doi.org/10.1016/j.ic.2024.105149
- Brooksbank, Maglione & Wilson (2022): https://doi.org/10.1016/j.jalgebra.2022.04.014

## 5. Como executar

Python 3 com NumPy e Numba (`python -m pip install numpy numba`):

```bash
python verificar_contracoes.py
python enumerar_completamentos_bent.py
```

Não houve alteração no GitHub. Este é um pacote **independente de verificação**
para quarentena científica, não uma versão revisada e certificada para submissão.
