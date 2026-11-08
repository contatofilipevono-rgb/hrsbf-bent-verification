# Organização do portfólio

Atualizado em **08/11/2026**. [Entrada principal](../README.md) · [Resultados atuais](RESULTADOS_ATUAIS.md)

## Caminhos de entrada

| Objetivo | Caminho |
|---|---|
| Ler e citar os trabalhos atuais | [Catálogo de resultados](RESULTADOS_ATUAIS.md), com DOI de cada versão |
| Reproduzir antipodal/cúbicas | `ESM_1.zip` no [Figshare v4](https://doi.org/10.6084/m9.figshare.34165260.v4); seguir o README do pacote |
| Reproduzir H12 e compreender as limitações | Pacotes do [Figshare v2](https://doi.org/10.6084/m9.figshare.34737294.v2) e [conclusão formal](../research_updates/2026_10_20_final_integration/CONCLUSAO_FORMAL_H12.md) |
| Consultar a antiga etapa cúbica por divisibilidade | [Guia histórico](LEGADO_CUBICO.md) |
| Consultar V1/V2/V3-C congelados em outubro | [Acervo](../ACERVO_CIENTIFICO/README.md) e manifesto de origem |
| Consultar literatura | [Artigos](../artigos/README.md); não usar o índice sozinho para estabelecer novidade |
| Continuar buscas recentes | [Panorama de 07/11](../research_updates/2026_11_07_panorama/PANORAMA_ATUAL.md), respeitando hipóteses e limites |

## Função dos diretórios

- `docs/`: navegação, status atual e referências versionadas.
- `ACERVO_CIENTIFICO/`: cópias históricas com proveniência. Os manuscritos, fontes formais e certificados preservados não foram reescritos nesta organização; os guias recebem avisos para levar às versões posteriores.
- `quartic_audit_2026_10_17/`: desenvolvimento e evidências de H12; inclui checkpoints que antecedem a integração final.
- `research_updates/`: registros datados. Uma pendência em um registro antigo deve ser interpretada na data daquele registro.
- `avanco_t32/`: certificados e estudos da etapa cúbica anterior; não define o limite do teorema antipodal atual.
- `artigos/`: trilha bibliográfica, direitos e referências.
- `jobs/` e notebooks de worker: infraestrutura de execução; organização documental não inicia buscas nem altera a fila.

Os arquivos da raiz `paper_hrsbf.tex`, `supplementary_material.tex` e o dossiê correspondem à etapa anterior por divisibilidade. Para o manuscrito antipodal atual, usar o Figshare v4.

## Pendências atuais

| Prioridade | Tarefa | Condição de conclusão |
|---|---|---|
| 1 | Manter GitHub e Figshare alinhados | Títulos, alcance e links de versão consistentes nos pontos de entrada |
| 2 | Conferir a referência cruzada no registro H12 do Figshare | Atualizar o link da descrição pública de H12 para o DOI do antipodal v4. Na conferência de 08/11, ainda apontava para v2 |
| 3 | Melhorar a reprodução limpa de H12 | Reconstrução integral documentada da distribuição mínima; não presumir sucesso dos registros parciais |
| 4 | Localizar a nota de grau ímpar / dicotomia | Manuscrito, definição de C(n), provas, cobertura computacional e literatura reunidos |
| 5 | Revisar V2/V3-C para apresentação editorial | Hipóteses explícitas, afirmações falsas excluídas da versão escolhida e comparação bibliográfica |
| 6 | Completar o depósito de Foulkes | Dados, certificado integral e correspondência com o problema presentes e conferidos no repositório próprio |
| 7 | Fortalecer o verificador GPU em execuções futuras | Recusar conclusão de inexistência quando `overflow` for verdadeiro; o registro H12 publicado indica falso |

## Regras de manutenção

1. Manter uma referência de publicação por trabalho, com DOI versionado.
2. Registrar status por afirmação: prova matemática, formalização com escopo, enumeração, replay, conjectura ou busca parcial.
3. Distinguir execução nova de leitura de logs históricos.
4. Não mover ou apagar pacotes antigos para apenas melhorar a aparência; acrescentar navegação e contexto.
5. Mudanças matemáticas exigem conferir a cadeia de prova. Uma edição de README não valida um teorema.
6. Não contar testes sobrepostos como cobertura independente nem misturar populações de filtros distintos.

## Registro desta organização

Em 08/11/2026 foram conferidos os metadados públicos do Figshare e os registros formais do suplemento antipodal. Foram atualizados os pontos de entrada, a separação entre versões atuais e históricas e a descrição dos repositórios associados. Nenhuma prova Lean, dado de busca, certificado ou manuscrito científico foi alterado; não houve nova execução Lean/GPU.
