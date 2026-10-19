# V3-C: avaliação inicial para simplificação editorial

19/10/2026. Avaliação do escopo documentado, não nova compilação Lean nem auditoria de todas as fontes. Sem alteração da V1 ou da V2.

## Origem examinada

`ACERVO_CIENTIFICO/V3-C/README.md` e `PROOF_STATUS.md`, com referência congelada `01ea4b263a3cbe338df264b9d057a4edb3a980c8`, branch `v3c-ea-transport-continuation`. A documentação discrimina as declarações e os logs de continuação; a próxima auditoria deve reconstruir esses registros e ler as assinaturas reais.

## Núcleo mais maduro segundo os registros

Para m≥2, semente f_m=Σ(i<j) p_i q_i p_j q_j; a quarta derivada tem a expressão em produtos da forma simplética ω. O registro descreve provas uniformes de propriedade A, recuperação de blocos, fórmula de dimensão de núcleos, índice relaxado vetorial, classificação EA canônica e indecomponibilidade robusta a quadráticas para grafos fracamente conexos.

Esse é um candidato forte para a próxima revisão editorial, em razão de um núcleo uniforme documentado, em contraste com a necessidade de reconciliar a versão mais recente da V2 com certificados finitos. Isso não equivale a endosso de toda alegação no manuscrito nem estabelece prioridade.

## Mapa lógico a auditar

Identidade simplética da quarta derivada → propriedade A → dimensão do núcleo por suporte em blocos → recuperação intrínseca dos blocos sob EA.

Em seguida, terceira derivada mista → recuperação das arestas → equivalência EA dos representantes canônicos sse isomorfismo de grafos. Em paralelo, propriedade A + direções seguras → índice relaxado exato; recuperação de blocos + conectividade → indecomponibilidade sob as hipóteses de produto efetivamente formalizadas.

## Limites que a edição deve conservar

- m≥2, e não uma generalização silenciosa para m=1.
- Em m=2, preservar a quarta forma não implica automaticamente preservar a forma simplética ω.
- Classificação dos representantes canônicos não classifica todas as perturbações quadráticas arbitrárias.
- O registro trata EA; não estabelece classificação CCZ apenas por mencionar esse objetivo de pesquisa.
- Não se infere bentness vetorial, APN ou segurança criptográfica a partir de rigidez ou da formalização desses invariantes.
- A ponte certificada a quadráticas usa ANFs explícitas ou uma condição intrínseca de segundas diferenças; não se deve trocar por um predicado de grau sem a ponte necessária.
- Casos vazio, um vértice e fatores não triviais devem corresponder às definições efetivas de `CutConnected` e de produto.

## Propostas

**B:** apresentar recuperação de blocos e fórmula de núcleos num único lema estrutural uniforme; conferir equivalência com as declarações existentes antes de adotá-lo como simplificação A.

**D:** transportar diretamente as contagens ou o grupo da semente específica da V2; apagar a informação cúbica das arestas; afirmar classificação CCZ não demonstrada.

Não foi produzido um novo artigo/PDF da V3-C nesta etapa. Antes disso, faltam a comparação semântica integral dos enunciados, a auditoria dos logs, a revisão de prioridade e a leitura adversarial do manuscrito completo. O relatório preserva o potencial editorial sem transformar documentação em certificação nova.
