# Estado atual da pesquisa — 17/10/2026

O resultado global mais forte verificado é a exclusão de **pelo menos 99,9941463203%** do espaço H(16,4) como candidato a bent: passagem <= **2011309/2^35**. A nova prova usa o núcleo de sete condições, oito combinações quadráticas em U38 e enumeração completa de 32.768 configurações matriciais por ramo. Os primeiros 127 caracteres tiveram replay independente dos postos e pesos; os 128 adicionais tiveram cada posto comparado por duas eliminações. Leia **T95_REDUCAO_U38_E_LIMITE_GLOBAL.md**, **T96_U38_LIMITE_OITO_CONDICOES.json** e **T98_CADEIA_U38_VERIFICACAO.json**. O resultado não demonstra inexistência global nem resolve C16.

**Avanço estrutural:** as 26 matrizes quadráticas em U38 dependem conjuntamente de apenas 16 paridades originais, ou 15 parâmetros em cada ramo das três leis lineares. O antigo T47 certificava 99,96808978000678% e permanece como resultado histórico auditado. A densidade exata dos sobreviventes continua desconhecida.

**Novo teste exato T41:** a amplitude Walsh em zero foi reduzida a uma contagem em 4.080 órbitas. A identidade e os controles passaram; os pilotos SAT reforçados foram inconclusivos.

**Simplificação modular T72:** duas congruências com contadores módulo 16 acrescentam informação às treze condições. Há exemplos explícitos de não implicação e verificações PASS; na amostra nova, 229 sobreviventes caíram para 113 e depois 60. A congruência de W(1^16) repete a de W(0), e uma condição quadrática de período 2 repete Q4. Leia **T72_AVANCO_MODULAR_E_SIMPLIFICACAO.md**. Esses testes não alteraram a cota disponível naquela etapa; o novo limite U38 foi obtido posteriormente por outro cálculo.

**Auditoria da proposta antipodal:** a anulação alegada de Q8 no subespaço V7 é falsa; há contraexemplo no núcleo e exemplo de posto 14. A forma polar tem uma propriedade isotrópica mais fraca. Veja **AVALIACAO_ROTA_ANTIPODAL.md**.

**Contadores compartilhados T75–T83:** seis amplitudes exatas agora usam uma codificação de tamanho próximo à antiga de uma amplitude. A nova implementação encontrou um modelo que passa pelas treze condições e pelas seis amplitudes, mas tem W(0x0101)=1024 e não é bent. Foi também demonstrada a condição necessária W(0)=W(1^16) para toda bent em H(16,4), com certificado completo de divisibilidade. Leia **T75_CONTADORES_COMPARTILHADOS_E_NOVA_ESTRUTURA.md**. Nenhum desses resultados prova inexistência global.

## O que ler

**Auditoria mais recente do pacote final Gemini:** W98 e suas dezessete combinações passaram na verificação estrutural, mas o verificador global omite contribuições quadráticas da substituição booleana. Há contraexemplo independente e uma família de dimensão102 que passa pelos filtros. A redução H12 para36 variáveis foi confirmada sob as cinco leis iniciais assumidas. Leia **AUDITORIA_PACOTE_FINAL_GEMINI_T100_T104.md**. O melhor limite global U38 acima permanece o resultado verificado.

1. **T34_FORMA_NORMAL.md:** apresentação curta das três leis lineares e das condições quarta, quinta e sétima. Onze paridades agregadas reduzem a contagem a 512 casos, dos quais 384 são válidos.
2. **T95_REDUCAO_U38_E_LIMITE_GLOBAL.md:** novo limite global e redução a quinze parâmetros. **T47_REFINAMENTO_SEM_NOVOS_FILTROS.md** preserva a prova anterior. T44 apresenta o lema de diferenças finitas e partições afins; T40 e T39 são marcos históricos.
3. **T33_DOMINIO_GPU.md:** redução exata do domínio preparado para A100 a 162.537.472 estados. A lógica foi validada em CPU; CUDA e varredura GPU ainda não foram executadas.
4. **REGISTRO_PESQUISA.md:** resultados demonstrados, tentativas inconclusivas, alternativas e evolução cronológica.
5. **MANUSCRITO_RASCUNHO.md:** rascunho em inglês para revisão e confronto bibliográfico.

## Outros resultados

- Fronteiras exatas de não linearidade e energia local em oito e dez variáveis, reproduzidas por dois métodos: FRONTEIRAS_EXATAS.csv.
- Coberturas espectrais mínimas: dois testes em oito variáveis e 17 em dez, nos limiares registrados. A minimalidade possui certificado conferido independentemente.
- Enumeração completa de uma família estruturada de dimensão 28 em H(16,4): nenhuma das 268.435.456 funções satisfaz PC(2). Esse resultado vale apenas nessa família.
- Sistema explícito de 389 obstruções cúbicas inteiras. Os pilotos SAT atingiram seus limites de tempo sem concluir; não excluíram candidatos.

## Executar e reproduzir

O pacote atual para o próximo piloto A100 é **GRAU4_T33_COLAB.zip**, com notebook **GRAU4_T33_A100.ipynb**. Comece pelo piloto obrigatório com comparação CUDA/CPU e checkpoint. Sobreviventes dos filtros não são certificados bent. T26/T27 são versões históricas.

**PACOTE_PESQUISA_17OUT2026.zip** reúne documentos, dados e código com manifesto SHA-256. Os novos verificadores de certificados usam Python padrão; a geração e validação dos estados usam NumPy. REPRODUCAO_CERTIFICADOS_T28_T33.json registra a execução isolada dos seis verificadores extraídos do pacote, todos aprovados.

T30 demonstra uma distinção operacional: a sexta condição sozinha não reduz o quociente das cinco fibras, pois cada estado admite representantes com os dois valores do bit. A sétima condição desce a esse quociente e reduz T27 para T33.
