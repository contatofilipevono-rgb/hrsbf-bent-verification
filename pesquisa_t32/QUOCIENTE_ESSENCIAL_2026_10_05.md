# Oito novas exclusões certificadas entre as 24 famílias remanescentes

A redução ao espaço efetivamente observado pelas restrições das fibras,
seguida de SAT com XOR nativo, excluiu três representantes. Seus certificados
XLRUP foram aceitos pelo verificador independente `cake_xlrup` com
`s VERIFIED UNSAT`. As simetrias de índices verificadas transferem as
exclusões para oito famílias. Restam 16 famílias neste lote.

| Representante | Famílias cobertas | Resultado |
|---|---:|---|
| `0x100022000` | 2 | UNSAT certificado e modelo auditado |
| `0x228000` | 2 | UNSAT certificado e modelo auditado |
| `0x4000a000` | 4 | UNSAT certificado e modelo auditado |

O escopo é o lote anteriormente aberto de famílias de peso três no quociente
H em n=32. Não é uma solução da conjectura geral em n=32.

## Por que a redução é exata

Cada condição de uma fibra é uma disjunção de formas afins nos 120
parâmetros livres x. A condição depende apenas de o vetor de valores dessas
formas ser diferente de zero. Trocar as formas por uma base de seu espaço
linear preserva essa condição. Se o espaço contém a forma constante 1, a
condição é tautológica.

Após essa normalização, todas as partes lineares das condições pertencem a
um espaço de dimensão 70 ou 71, dependendo do representante. Escolha uma
base de linhas b_i e defina y_i=<b_i,x>. A independência das linhas garante
que a aplicação x -> y é sobrejetiva. Cada condição pode ser reescrita
exatamente em y; uma solução em y admite levantamento para x. Portanto a
consistência das condições das fibras é preservada nos dois sentidos.

Isso reduz o espaço de parâmetros observado pelas fibras; não reduz a
dimensão da família original de funções, que continua tendo 120 parâmetros.

## Cadeia de auditoria

1. Para cada representante certificado, o auditor independente conferiu as
   4.115 fibras e 24.462 avaliações de bases diretamente na ANF original.
2. A equivalência de cada disjunção foi conferida por igualdade de espaços
   de linhas, usando uma segunda eliminação gaussiana com pivôs em sentido
   oposto ao da construção.
3. A mudança de coordenadas foi conferida pela reconstrução de todas as
   linhas e pela independência da base. Foram executados 5.440 controles
   exaustivos em casos pequenos e testes de projeção/levantamento.
4. Um parser independente recuperou todas as equações XOR e disjunções do
   arquivo serializado e as comparou ao modelo reduzido.
5. CryptoMiniSat 5.16.0 produziu os certificados. `cake_xlrup` verificou cada
   um separadamente. O controle pequeno do formato XOR/XLRUP também passou.
6. As permutações que cobrem oito famílias foram novamente verificadas.

Os hashes dos certificados, dos arquivos de entrada e os resultados das
auditorias estão em `oito_familias_certificadas_2026_10_05.json`. Os seis
representantes que cobrem as 16 famílias restantes estão em
`dezesseis_familias_remanescentes_2026_10_05.json`.

## Reprodução

O script `essential_fiber_quotient.py` gera CNF convencional e CNF com XOR a
partir dos metadados originais das fibras. `certify_essential_fibers.py`
reconstrói e audita o modelo original, gera o quociente, executa o solver e
verifica a prova antes de registrar uma exclusão.

```sh
python3 pesquisa_t32/certify_essential_fibers.py familia.json resultados \
  --solver /caminho/cryptominisat5 --checker /caminho/cake_xlrup --seconds 300
```

Solver: versão oficial 5.16.0; arquivo linux-amd64 SHA-256
`9599eea560305291cb593ba9d6733605fae763a7f7a1fcdd63191ef8089e9979`.
Checker: `meelgroup/frat-xor`, commit
`855f3d0ae45fe37c3ad29e4a8ef56e62e1b5e4ad`, diretório `cake_xlrup`.

## O que não fechou

Os outros seis representantes permaneceram sem decisão no teste exploratório
com XOR. A soma linear dos polinômios das condições de codimensão até três
não produziu 1 no representante `0xa2000`: 2.658 condições, posto 2.478.
Isso não exclui certificados com multiplicadores ou graus maiores.

Nesse representante, quatro condições de codimensão dois permitem uma
partição exata em 81 subcasos, fixando oito formas independentes. Nenhum
subcaso foi excluído só pela propagação linear. Uma amostra de nove subcasos
também atingiu o limite curto de cinco segundos por busca. Isso não é uma
classificação dos 81 subcasos.

Não há evidência de benefício de GPU para este solver. O avanço foi obtido
em CPU pela mudança de representação e pelo tratamento nativo das paridades.
