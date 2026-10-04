# Auditoria independente da pesquisa em 32 variáveis

Data: 4 de outubro de 2026. Escopo: famílias com parâmetro H de peso três; não é uma classificação completa das funções cúbicas em 32 variáveis.

## Resultados concluídos localmente

Uma implementação independente, sem importar os módulos de produção, reconstruiu as 155 órbitas cúbicas em 32 variáveis e as 35 órbitas cúbicas em 16 variáveis. Confirmou 35 grupos com quatro levantamentos cada, mais 15 órbitas de matriz polar nula. A fibra de um H fixo tem 120 coeficientes livres.

Foram verificados 6.515 certificados distintos de exclusão de famílias de peso três:

| Etapa | Certificados de peso três confirmados |
|---|---:|
| Triagem inicial | 5.878 |
| Aprofundamento das 667 famílias | 618 |
| Análise das 49 restantes | 19 |
| Total | 6.515 |

O controle adicional H de peso um também passou, mas não entra nesse total. Os conjuntos de exclusão são disjuntos. As listas remanescentes entre as etapas coincidem exatamente, deixando 30 famílias antes do lote SAT.

Para H = 0xc0000004, a auditoria completa confirmou:

- cobertura das 4.115 órbitas de direções não nulas;
- posto e base completa do radical em cada direção;
- 23.164 avaliações de bases, obtidas diretamente da ANF original;
- substituição dos 155 coeficientes pelas 120 coordenadas livres;
- equivalência de cada uma das 211.280 portas XOR;
- correspondência semântica das 4.082 cláusulas de balanceamento;
- cabeçalho e contagem efetiva de 849.202 cláusulas e 211.400 variáveis.

O relatório executável é `auditoria_independente_cnf_resultado.json`. O verificador é `audit_independent_cnf.py`.

## Incidente de integridade encontrado e corrigido

A cópia local anteriormente distribuída da CNF estava truncada: 517.926 cláusulas efetivas para um cabeçalho que declarava 849.202. Não deve ser usada como o modelo completo.

A CNF original no Colab tem 18.363.829 bytes e todas as 849.202 cláusulas. A reconstrução local a partir dos metadados produziu exatamente o mesmo SHA-256 observado no arquivo original:

`9c074ea6127aa610afc35aa889c53021e86afcf882a9110554e7a4e573c67d25`

A cópia local foi substituída pela reconstrução completa. A causa do truncamento da cópia não foi determinada. Foi acrescentada ao gerador do lote uma leitura efetiva do DIMACS, que rejeita divergência de contagem, cláusulas incompletas e variáveis fora do intervalo antes de executar o solver ou reutilizar um certificado. A proteção foi testada contra o arquivo completo e contra a cópia truncada.

## Justificação matemática usada na auditoria

O corte relevante é x = (u, u + z), e não uma partição arbitrária das variáveis. A rotação por 16 posições emparelha os monômios cúbicos em órbitas de dois elementos. Não existe monômio cúbico fixo por essa rotação: um suporte fixo teria cardinalidade par. Na diagonal z = 0, os dois monômios de cada par têm o mesmo valor, logo f(u,u) = 0.

Para uma função bent em 32 variáveis, Parseval na transformada parcial dá soma_z W_fz(0)^2 = 2^32. A fibra z = 0 já contribui 2^32; portanto toda fibra com z diferente de zero precisa ser balanceada.

Cada fibra tem grau no máximo dois. Para q_z(u) = f(u,u+z) + f(0,z), com q_z(0) = 0, o balanceamento equivale a q_z restringir-se a uma forma linear não nula no radical de sua forma polar. Em uma base do radical isso é uma disjunção das avaliações iguais a um. Não é a exigência de que todas essas avaliações sejam um.

No posto 14, z está no radical e sua avaliação normalizada é zero. Uma segunda direção independente r impõe a única equação q_z(r) = 1. Nos postos inferiores, a disjunção completa é preservada. As 19 exclusões de posto zero foram verificadas mostrando que as equações necessárias anteriores forçam todas as 16 avaliações de base a zero.

## Auditoria SAT e limites

O lote registrou seis famílias como UNSAT com DRAT aceito. A segunda auditoria reconstruiu a semântica de cada CNF a partir da ANF e repetiu DRAT-trim contra os arquivos exatos. Todas as seis passaram. A conclusão `PASS 6` foi observada no terminal do Colab, lendo o arquivo `independent_verified_batch.json`. O download desse relatório nativo não concluiu; ele e as seis provas DRAT não estão incluídos neste pacote local. O script para reproduzir essa checagem está incluído.

Famílias: 0xc0000004, 0x60000008, 0x50000040, 0x42000080, 0x41000400 e 0x240000800.

Somando as seis confirmações às 6.515 anteriores, estão excluídas 6.521 das 6.545 famílias de peso três, deixando 24 em aberto. O resultado é uma exclusão dessas famílias específicas. SAT significa satisfação de condições necessárias, não existência de função bent. Timeout significa ausência de decisão. Os casos de peso H maior que três não foram cobertos por este levantamento.

## Reprodução local

```sh
python3 audit_independent_cnf.py \
  --certificate-report triagem_t32_peso3.json \
  --certificate-report etapa_667_512.json \
  --certificate-report etapa_49_orbitas.json \
  --metadata familia_c0000004_compacta.json \
  --cnf familia_c0000004_compacta.cnf \
  --output auditoria_independente_cnf_resultado.json
```

Para o lote original, com DRAT-trim instalado:

```sh
python3 audit_verified_batch.py \
  --directory resultados \
  --checker /caminho/absoluto/drat-trim \
  --output resultados/independent_verified_batch.json
```

A auditoria é computacional e reproduzível, não uma formalização em assistente de provas. Ela também não certifica novidade bibliográfica ou aceitação editorial.
