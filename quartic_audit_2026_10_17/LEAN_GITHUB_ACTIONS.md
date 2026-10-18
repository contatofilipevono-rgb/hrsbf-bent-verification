# Verificação Lean no GitHub Actions

O workflow `.github/workflows/lean-cloud.yml` executa a verificação nos servidores do GitHub. O repositório é público e o workflow usa um executor padrão Ubuntu, sem contratar executores maiores. Cada execução tem limite de 300 minutos, dos quais até240 são usados na checagem. A configuração inicial usa180 minutos. Não há agendamento nem repetição automática ilimitada.

Abra Actions → Lean chart certificate (resumable) → Run workflow. Escolha a carta2,1 ou0. Para continuar uma carta incompleta, execute novamente com o mesmo número. O cache armazena os arquivos de build e os registros; cada execução salva também um artefato com fontes gerados, relatório e logs. O cache é uma conveniência de retomada, não armazenamento permanente; os artefatos ficam disponíveis por7 dias.

Os módulos do projeto são construídos e reproduzidos pelo kernel na ordem das importações, inclusive os testemunhos Walsh e o índice compartilhado. A primeira execução Linux precisa preparar essas dependências. Os arquivos binários locais do Windows não são usados como binários Linux.

Uma retomada só aceita registros com a mesma versão do Lean, plataforma, código do verificador e hashes de todos os fontes. Cada módulo precisa também do hash do arquivo `.olean`, dos dois códigos de saída bem-sucedidos e dos hashes dos logs. A conferência de um módulo não implica cobertura da carta. O relatório só afirma cobertura de uma carta depois de conferir todas as dependências e a raiz concreta. A conclusão global das três cartas ainda exige a integração final; este workflow de uma carta não a declara automaticamente.

O compilador Lean4.35.0 é baixado da versão oficial e conferido pelo SHA-256 publicado. O workflow tem apenas permissão de leitura do repositório, além dos mecanismos normais de cache e artefatos. Ele não cria commits nem publica um suposto teorema.

O progresso da execução local é preservado separadamente. A checagem remota pode exigir mais de uma execução, pois tarefas hospedadas têm limite de tempo. Uma execução concluída como `PARTIAL_TIME_SLICE` salva progresso útil e continua sem afirmar que o teorema esteja provado.
