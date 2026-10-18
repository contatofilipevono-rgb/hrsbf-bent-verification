# Índice compartilhado dos testemunhos Walsh

Estado desta versão: os 42 módulos do índice passaram na compilação e na reprodução independente pelo kernel. A auditoria de chaves e divisões também passou. Evidências: `reports/LEAN_WITNESS_LABEL_INDEX_AUDIT.json` e `reports/WITNESS_LABEL_INDEX_SOURCE_AUDIT.json`. A prova global das três cartas continua pendente.

Os 164.288 testemunhos Walsh originais já passaram integralmente na compilação e na reprodução pelo kernel. Cada testemunho real contém coeficiente, frequência e número de bits usados na rejeição modular. O índice novo reutiliza essas provas e não calcula novos valores Walsh.

A busca terminal compara somente o coeficiente. Por isso, `H12WitnessLabels.label` guarda o coeficiente literal numa folha da árvore. Seus outros campos são zeros sem significado de certificado Walsh. Não se afirma que essa folha passa em `H12WitnessTheory.check`. Sua propriedade `Good` é provada a partir dos testemunhos reais já certificados.

`H12WitnessIndexLabels.good_of_coefficients` formaliza essa ligação: se a lista de coeficientes das folhas coincide com a lista de coeficientes de um lote verificado, qualquer acerto da busca identifica um coeficiente cuja função original não é bent. A prova recupera um testemunho real na lista, usa sua rejeição certificada e transfere a conclusão pela igualdade dos coeficientes.

O gerador divide os dados em 642 lotes de até 256 entradas. Para cada lote, o Lean verifica a igualdade exata entre os coeficientes da árvore literal e os do lote de testemunhos. As árvores são reunidas em 41 módulos de dados e num módulo global, usando `H12WitnessSearch.node_good`. Essa construção permite compartilhar uma única prova `Good` entre todas as folhas dos certificados das cartas, em vez de elaborar novamente milhares de ligações individuais.

A auditoria externa `tools/verify_witness_label_index_sources.py` lê os fontes gerados com um analisador separado, confere as 164.288 chaves contra os arquivos de candidatos e verifica cada divisão: o maior valor à esquerda é menor que o pivô, e o menor valor à direita é maior ou igual a ele. Foram conferidos 164.287 nós de divisão. Essa auditoria de fontes e dados não substitui o kernel.

O índice não constitui cobertura das cartas. Um certificado terminal ainda precisa conferir todos os candidatos que seu ambiente e suas variáveis ativas produzem. A correção genérica liga essa conferência aos coeficientes da função quártica original. O teorema global só poderá ser declarado concluído depois das três refutações de raízes e da reprodução da conclusão pelo kernel.

Para reproduzir a construção:

```sh
python tools/generate_lean_witness_label_index.py --register
python tools/verify_witness_label_index_sources.py
python tools/verify_lean_sequential_library.py --lake /caminho/para/lake --library H12WitnessLabelIndexCertificate --report LEAN_WITNESS_LABEL_INDEX_AUDIT.json --resume
```

O verificador sequencial evita construir vários módulos grandes simultaneamente. O controlador `tools/continue_full_fast_certificate.py` exige o índice completamente aprovado, confere seus hashes e registros e só então inicia as cartas. Seu teste de pré-requisito confirmou a recusa de um índice ainda inacabado. O controlador somente marca a conclusão global após a aprovação das três cartas e do módulo final; não publica resultados automaticamente.
