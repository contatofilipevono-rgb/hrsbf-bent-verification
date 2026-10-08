# Piloto com derivadas quadráticas

Este experimento acrescenta ao modelo original das fibras uma condição exata
para o balanceamento de cada uma de 23 derivadas selecionadas. O alvo inicial
é a família fixa `H=0xa2000`. O escopo continua sendo o caso cúbico homogêneo
RS em 32 variáveis; nenhuma conclusão global de inexistência é declarada.

## Fundamento matemático

Escreva `q(x)=D_a f(x)=f(x)+f(x+a)` e
`B(x,y)=q(x+y)+q(x)+q(y)+q(0)`. Como `deg(f)<=3`, `q` é quadrática.
Seja `R=ker(B)`, e `Q(x)=q(x)+q(0)`. Sobre `R`, `Q` é linear.

**Critério:** `q` é balanceada se e somente se existe `r` em `R` tal que
`Q(r)=1`.

Se tal `r` existe, transladar a soma de caracteres por `r` troca seu sinal,
portanto a soma é zero. Reciprocamente, se `Q` se anula em todo `R`, para
`S=sum_x (-1)^q(x)` temos

`S^2 = sum_r (-1)^Q(r) sum_x (-1)^B(x,r) = 2^n |R| > 0`.

Logo a soma não é zero. Essa prova vale para radicais de qualquer dimensão;
não depende de posto 14 nem exige que fibras arbitrárias sejam balanceadas.

O CNF introduz 32 bits de testemunha `r` para cada direção, exige `B r=0`
e `Q(r)=1`. Os coeficientes de `B` e `Q` são expressões afins nos 120
parâmetros livres da família. Portas AND e XOR são codificadas por
equivalências completas. Todas as testemunhas ficam sob quantificação
existencial, como requerido pelo critério.

Funções bent têm todas as derivadas não nulas balanceadas. Selecionar somente
23 direções preserva necessidade, mas não suficiência. Portanto:

- UNSAT, após auditoria do modelo e prova DRAT verificada, exclui a família.
- SAT apenas fornece um candidato que satisfaz as condições selecionadas.
- Timeout deixa a família em aberto.

## Validação executada

`audit_derivative_balance.py` compara a codificação com avaliações diretas da
tabela-verdade, sem usar a expansão simbólica para construir o resultado esperado.

- 64 atribuições de portas, incluindo entradas negadas.
- 56.496 testes de testemunhas do radical.
- 1.074 comparações com o balanceamento por enumeração direta.
- 1.242 comparações da expansão das derivadas com a ANF original em n=32.
- Controles positivos: bent quadrática em n=4 e bent cúbica não homogênea de
  Maiorana–McFarland em n=6.

Todos passaram. São testes diferenciais finitos, não certificados de UNSAT.

## Execução

O notebook `HRSBF_derivadas_piloto.ipynb` usa um checkout fixado, prepara
CaDiCaL e drat-trim e roda um representante com 300 segundos de limite do
solver. Preparação, auditoria, verificação da prova e compactação são adicionais.
Usa CPU; não utiliza GPU. O ambiente e os arquivos são separados do lote
anterior do Colab.

Para executar no checkout do repositório com binários já preparados:

```sh
python3 pesquisa_t32/audit_derivative_balance.py --output auditoria_derivadas.json
python3 pesquisa_t32/derivative_pilot.py --base /content/hrsbf_derivative_pilot --h 0xa2000 --seconds 300
```

O piloto audita as 4.115 fibras originais antes de anexar as derivadas.
Uma atribuição SAT é conferida contra todas as cláusulas serializadas e contra
as testemunhas das derivadas por avaliações diretas. Uma conclusão UNSAT
precisa de retorno 20 do solver e retorno 0 com `s VERIFIED` do drat-trim.
O ZIP guarda CNF original e reforçado, metadados, logs, prova e hashes.

## Próxima decisão

Comparar tempos e estatísticas de busca com o modelo original sob o mesmo
orçamento. Um único piloto não demonstra melhora geral. Se persistir o
timeout, testar outras direções e uma implementação que trate XOR diretamente;
se dividir em subcasos, exigir cobertura de todos os ramos e provas individuais.

## Resultado observado do primeiro piloto

O representante `0xa2000` foi executado localmente, primeiro com o modelo
reforçado e depois com o original, usando o mesmo CaDiCaL e limite de 120 s.
Ambos terminaram com `UNKNOWN_OR_INTERRUPTED`. Nenhuma nova exclusão foi obtida.

| Modelo | Variáveis | Cláusulas | Pico de memória | Resultado |
|---|---:|---:|---:|---|
| Original | 167.157 | 672.238 | 265,94 MB | Timeout |
| Original + 23 derivadas | 254.261 | 977.566 | 477,62 MB | Timeout |

Os controles nativos passaram: UNSAT em n=4 com prova DRAT verificada e SAT
para a bent conhecida em n=6, com todas as testemunhas conferidas. O piloto
em n=32 não demonstrou aceleração; os 24 casos permanecem em aberto. Antes
de ampliar o lote, medir o efeito de poucas direções adicionais selecionadas
pela estrutura dos radicais.
