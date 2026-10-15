# Lean: núcleo do argumento de fibras

**Estado: compilado, formalização global ainda parcial.**

Este projeto formaliza lemas gerais do argumento de fibras do preprint HRSBF.
Usa Lean **4.15.0** e Mathlib no commit
`9837ca9d65d9de6fad1ef4381750ca688774e608` (tag `v4.15.0`).
O certificado concreto anterior em Lean Core para `n = 12` continua separado em
[na publicação anterior](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/fadc947e56d4f82d7e980c5b91f5583e3995e0f0/publications/v1-audited-2026-10-14/formal/Matematica_Formalizacao_Real.lean).

## O que está provado

| Arquivo | Resultado verificado |
|---|---|
| `Antipodal/Polynomial.lean` | Somas de monômios de comprimento até três fornecem a hipótese polinomial usada nas provas. |
| `Antipodal/LocalRigidity.lean` | Terceira diferença trilinear; comparação entre o polar da fibra e o polar de `D_J g`; função afim invariante sob rotação com inversão na emenda é constante. |
| `Antipodal/Cyclic.lean` | Rotação efetiva das `2h` coordenadas; meia volta troca os blocos; lema de rigidez da fibra complementar para todo `h > 0`. |
| `Antipodal/Fourier.lean` | Ortogonalidade dos caracteres; Parseval inteiro; identidade entre Walsh diagonal e Fourier das somas das fibras; balanço de toda fibra não nula de uma função bent com diagonal constante. |
| `Antipodal/Main.lean` | Contradição das fibras: uma função RS de grau até três, com diagonal constante e polar de `D_J g` nulo, não é bent. |

O último teorema é `HRSBF.Antipodal.not_bent_of_monomials`.
As hipóteses são polinômios e condições algébricas explícitas. Não se pressupõem
nem a conclusão de não-bentness nem o lema de rigidez.

As funções têm domínio `Fin h → ZMod 2`, ou um par desses espaços. `walshPair`
é uma soma inteira sobre todas as entradas e os caracteres aditivos; `IsBentPair`
exige o quadrado correto em todas as frequências. A hipótese de simetria usa
as rotações concretas `blockShift k`, para todos os deslocamentos `k`.
A ponte com monômios é demonstrada em Lean; a equivalência com a ANF por
Möbius do arquivo antigo ainda não foi acrescentada.

## Limite preciso

**Este projeto ainda não prova o teorema antipodal universal nem a inexistência
global de funções cúbicas homogêneas RS bent.**

Para chegar ao teorema do artigo, ainda faltam:

1. A redução ao espaço fixo de uma rotação de ordem ímpar.
2. A rigidez das quadráticas RS em dimensão potência de dois, usada para obter
   o polar nulo de `D_J g` a partir de bentness.
3. A análise dos monômios na diagonal e a preservação do coeficiente antipodal
   pelo dobramento de órbitas.
4. A integração dessas etapas e das definições de ANF ao enunciado global.

Os resultados `hd` (diagonal constante) e `hz` (polar nulo) são hipóteses
explícitas em `Main.lean`; não foram escondidos em certificados nem declarados
como axiomas. A ponte bits/caminhadas de `H₃₂` do projeto antigo também não é
resolvida por este módulo.

## Reproduzir

Com `elan` instalado, entre nesta pasta e execute:

```sh
lake update
lake exe cache get Mathlib.Data.ZMod.Basic Mathlib.LinearAlgebra.Pi Mathlib.Algebra.CharP.Two Mathlib.Tactic.Ring
python3 scripts/audit.py
```

`lean-toolchain` fixa a versão do Lean, e `lake-manifest.json` fixa as dependências.
O script exige essa versão, executa `lake build` e gera `AxiomAudit.lean` com
`#print axioms` para cada lema e teorema público destes módulos.
Os 52 lemas e teoremas públicos passaram na execução registrada.
Rejeita dependências diferentes de `propext`, `Classical.choice` e `Quot.sound`.
Também rejeita `sorryAx` e `Lean.ofReduceBool`.

O arquivo `Nucleo_Fibras.lean` reúne as cinco etapas em uma única fonte,
com apenas os imports de Mathlib. Também foi compilado separadamente.

As evidências desta execução estão em `logs/build.log`, `logs/axioms.log`,
`logs/standalone.log` e `logs/result.json`. Os axiomas padrão do Lean são reportados explicitamente;
portanto, o resultado não é descrito como “sem quaisquer axiomas”.

Nesta VM, a distribuição oficial precisou de um ajuste externo de `readlink`
para localizar o próprio executável em `/proc`. O compilador, o kernel e as
bibliotecas Lean não foram modificados. Esse ajuste não é necessário em uma
instalação normal de Lean/elan.
