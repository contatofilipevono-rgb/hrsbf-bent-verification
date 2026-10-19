# V2: avaliação inicial para simplificação editorial

19/10/2026. Avaliação documental e matemática preliminar, não auditoria integral nem novo certificado. Este projeto é separado da V1 e da V3-C.

## Origem examinada

Acervo preservado em `ACERVO_CIENTIFICO/V2/`, em particular `MANUSCRIPT_DRAFT.md`, `README.md`, `auditoria_2026_10_13/README.md` e o registro da entrega posterior de 14/10. A auditoria de 13/10 tem origem fixa `16309c4e692cf37427c189baf8e9050b64e85052`. O snapshot Lean adjacente tem origem diferente: não certifica automaticamente o adendo posterior. A entrega de outra IA é material a examinar, não evidência de correção pelo fato de existir.

## Teoremas com melhor perspectiva editorial

1. Índice relaxado vetorial exato R2(F_G+Q)=r, sob a propriedade de contração da semente e as hipóteses explícitas dos acoplamentos.
2. Recuperação intrínseca de blocos e de arestas direcionadas.
3. Classificação EA dos representantes canônicos; necessidade de isomorfismo quando há perturbações quadráticas, sem afirmar suficiência para Q e Q' arbitrários.
4. Indecomponibilidade para grafos fracamente conexos, preservada por perturbações quadráticas no escopo demonstrado.

O resumo mais amplo não deve reincorporar a bicondicional falsa de indecomponibilidade para Q arbitrário. A ausência de conexões no grafo não elimina possíveis acoplamentos introduzidos por Q.

## Caminho lógico provisório

Propriedade A da semente (ausência de contrações nulas para pares independentes) → projeções de subespaços relaxados com dimensão ≤1 → limite superior r. Direções seguras explícitas, omitidas pelos termos cúbicos de acoplamento → subespaço relaxado de dimensão r → índice exato.

Separadamente: quarta derivada vetorial → recuperação dos blocos → terceira derivada mista nos blocos recuperados → arestas → classificação canônica e obstrução à decomposição.

A quarta derivada sozinha não registra os acoplamentos cúbicos. Apagar o passo da terceira derivada seria uma simplificação inválida. Tampouco se pode identificar R2 vetorial com o mínimo dos índices escalares sem demonstrar a existência de um mesmo subespaço para todos os componentes.

## Simplificações a investigar

- **A, para o argumento abstrato de índice:** reunir limite superior e testemunha inferior num único teorema sob hipóteses explícitas da semente e das direções seguras. Esse argumento já é curto no rascunho, e não se reivindica novo resultado aqui.
- **B:** abstrair a recuperação de blocos via dimensões dos núcleos de contração, à maneira documentada na V3-C. É necessário conferir a transferência exata à semente da V2 antes de substituir a prova pelo centroide.
- **D:** usar apenas a quarta derivada para recuperar arestas ou concluir equivalência EA completa sob Q arbitrário.

## Portas ainda abertas antes de novo artigo

Revisar a entrega de 14/10 contra a auditoria corrigida de 13/10; reconstruir o certificado finito da semente e os grupos locais; verificar todos os quantificadores do teorema de recuperação; separar os resultados que dependem dos grupos 1920/40 dos que usam apenas A; conferir a prioridade do índice relaxado em literatura anterior; comparar assinaturas Lean com o adendo efetivamente usado.

Nesta etapa não se produziu ARTIGO_SIMPLIFICADO nem APENDICE_PROVAS da V2, para não apresentar uma revisão documental como demonstração integral auditada. O projeto permanece candidato a uma próxima etapa própria.
