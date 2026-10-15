# Resposta consolidada às revisões adversárias — 15/10/2026

## Veredito e objeto

O parecer anexado conclui **APROVADO COM RESSALVAS** e não identifica falha matemática nos dois objetivos universais. Esta entrega atualiza o artigo, não rebatiza essa avaliação como revisão por pares. Os fontes Lean são os do SHA `6dd183685ef8a5b033c1bcf8733496d57b853cc7`, presentes sem alteração no commit-base `6f9f66c2e6bba001490e5245f6eb039158a37ffa`.

Há **dois registros diferentes**, sem autoria humana ou independência institucional verificadas aqui:

1. O arquivo anexado `REVISAO_ADVERSARIA_ANTIPODAL_2026-10-15.md`, arquivado byte a byte em `audit/REVISAO_ADVERSARIA_RECEBIDA.md`, e seu ZIP de evidências. Registra acesso à API/logs reais, recompilação dos módulos do projeto com cache de dependências fixadas e uma adaptação local de localização de executáveis.
2. O texto de outra revisão colado pelo usuário na conversa. Relata compilação da Mathlib do fonte, inspeção de 283 teoremas e dificuldade de acesso aos logs de CI. Não recebemos os arquivos `AllAxioms2.lean` nem o script do exemplo de Tang referidos nesse texto. Não os atribuímos ao ZIP.

Os resultados compatíveis podem corroborar-se; as limitações de uma sessão não devem ser atribuídas à outra.

## Respostas por achado

| Achado | Tratamento e evidência | Situação |
|---|---|---|
| Artigo dizia que a formalização global estava incompleta | Seção de certificação reescrita com SHA, Mathlib, duas execuções CI e mapa de declarações | Corrigido na revisão 1.3; originais preservados |
| Prova do artigo dependia da identidade geral de folding | Nova prova transporta constância da meia-volta à diagonal da restrição | Alinhado à rota Lean; identidade auxiliar não é anunciada como formalizada |
| Falta de `#print axioms` explícito para `_2h` em `CheckGlobal.lean` | Incluído o `checks/AuditSignatures.lean` recebido, que inspeciona as seis interfaces; comando suplementar explicado no artigo | Evidência complementar preservada; fontes certificados não editados |
| Logs CI inacessíveis na outra revisão | ZIP anexado contém os dois logs reais e respostas API; parecer anexado registra obtenção direta | Limitação daquela sessão, não ausência global de evidência |
| “Só CheckGlobal mudou entre os dois CIs” | Diff Git confere quatro caminhos: raiz `Antipodal.lean`, novo `WalshNormalization.lean`, `CheckGlobal.lean`, `GLOBAL_BRIDGE_STATUS.md` | Afirmação corrigida no artigo e nesta resposta |
| Artigo de Sun integral não consultado | Leitura anterior já registrada, com 22 páginas e SHA do PDF; comparação histórica preservada | Obtenção/leitura anterior documentadas; original não reaberto nesta sessão |
| Tang ausente da bibliografia V1 | Referência completa acrescentada e comparação limitada ao resumo primário atual | Corrigido no manuscrito; comparação de fórmulas continua limitada pelo acesso nesta passagem |
| “Tang não citado em nenhuma branch” | Já havia alerta V2 na branch `research-openai-math-transfer-2026-10-09` | Generalização corrigida; omissão era no manuscrito V1 |
| Constantes auxiliares `axiomInfo` | A outra revisão relata 14 auxiliares fora da dependência dos 283 teoremas | Sem falha lógica demonstrada; origem específica não diagnosticada aqui; não chamamos o ambiente inteiro de livre de axiomas |
| Conjectura em todos os graus >2 | Título, resumo, discussão e README restringem explicitamente a conclusão ao caso cúbico | Escopo corrigido e explícito |
| Comentários históricos de lemas condicionais | Não alterados para preservar identidade dos fontes testados; prova global descarrega condições nos módulos posteriores | Questão editorial documentada; nenhuma hipótese extra na interface final |

## Conferências efetivamente realizadas nesta passagem

- Fetch de todas as branches remotas; branch formal global ainda no SHA-base indicado.
- Integridade do ZIP recebido: **42 entradas verificadas**, nenhuma divergente. A prova original também tem seu manifesto histórico de 60 arquivos; são manifestos diferentes.
- Leitura do parecer e dos registros de reprodução, listas de axiomas e testes.
- Diff direto dos commits de prova/relatórios; preservação dos fontes e do workflow Lean.
- Reconstrução do texto matemático para a rota de constância diagonal, incluindo N=2, termos afins e constantes e direção concreta da rotação.
- Recompilação LaTeX da revisão 1.3 e inspeção visual do PDF. Resultados do build e da reexecução dos testes recebidos são registrados nos arquivos de validação desta release.

Não foi executada uma nova instalação/compilação Lean nesta passagem editorial. A certificação permanece vinculada ao SHA original e às evidências já registradas; o validador desta release verifica que o diretório formal e o workflow original não foram alterados em relação a esse SHA.

## O que ainda exige trabalho acadêmico

- Revisão especializada externa e comparação mais ampla de prioridade, sem inferir novidade a partir de CI.
- Leitura de fórmulas de Tang com acesso ao texto, se se quiser discutir exemplos ou equivalências em detalhe.
- Revisão editorial final pelo autor antes de submissão.

Nada foi submetido a periódico ou arXiv por esta atualização. Nenhuma branch anterior foi sobrescrita e nenhum manuscrito histórico foi editado.
