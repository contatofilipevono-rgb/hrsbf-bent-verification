# Comparação bibliográfica consolidada — 15/10/2026

## Escopo atual

A revisão 1.3 afirma necessidade do coeficiente antipodal para toda função RS bent de grau ≤3 em toda dimensão par positiva; daí deriva a inexistência homogênea de grau exatamente três. Não resolve a conjectura em todos os graus >2. Não afirma prioridade absoluta.

## Fontes, alcance e procedência

| Trabalho | Resultado relevante | Relação com o resultado atual | Base documental desta revisão |
|---|---|---|---|
| Stănică–Maitra (2008), DOI 10.1016/j.dam.2007.04.029 | Origem da conjectura homogênea de grau >2 | A conclusão atual é o caso cúbico | Referência histórica do manuscrito; conjectura também descrita nas fontes primárias de Cusick–Sanger e Sun et al. |
| Meng–Chen–Fu (2010), DOI 10.1016/j.dam.2010.02.009 | Restrições parciais de não existência | Antecedente; não usado como prova do resultado global | Comparações históricas do acervo; sem nova auditoria integral nesta passagem |
| Zhang–Gao (2013), arXiv:1303.2282 | Critérios parciais relativos à conjectura | Não interpretar o título como solução universal | Referência primária e leitura documentada na revisão recebida |
| Cusick–Sanger (2017), arXiv:1708.09313 | Antipodal em somas de ciclos curtos; casos em n=2p; precedente quadrático | A extensão a grau≤3 e toda dimensão precisa reconhecer esse antecedente | Página primária do arXiv consultada em 15/10/2026 e leitura documentada no parecer recebido |
| Gao–Zhang–Liu–Carlet (2012), DOI 10.1109/TIT.2012.2193377; Wang et al. (2015), DOI 10.1109/ISIT.2015.7282502 | Construções positivas de cúbicas RS bent não homogêneas | Construções de grau três não contradizem a conclusão homogênea | Índice bibliográfico e manuscrito histórico; sem nova leitura integral nesta passagem |
| Chirvasitu–Cusick (2020/2024), arXiv:1908.08448; DOI 10.1016/j.dam.2023.10.010 | Teoria de balanceamento de quadráticas RS | A rigidez auxiliar deve ser situada nessa teoria; sem alegação independente de novidade | Referências primárias identificadas no acervo e no artigo de Sun |
| Sun–Shi–Liu–Fu (2026), DOI 10.1007/s10623-026-01848-4 | Teoremas condicionados à fatoração e a suportes/SANF; Corolário 2 e Teoremas 5–6 são a comparação mais próxima | O teorema atual remove restrições aritméticas e de suporte no grau três; não implica que todo resultado do artigo seja subsumido | Leitura integral anterior registrada em `COMPARACAO_SUN_2026.md`; página Springer reconsultada em 15/10/2026 |
| Polujan–Kudin–Pašalić (2026), DOI 10.1109/TIT.2026.3685133 | Funções RS bent fora da classe Maiorana–McFarland completada, incluindo cúbicas | Questão de construção/equivalência distinta da homogeneidade | Registro primário IEEE consultado na pesquisa e metadados de repositório institucional; sem nova certificação das fórmulas |
| Deng Tang (2026), ePrint 2026/1799 | Construções RS bent fora da classe completada em n=30·7^j e n=70t, com graus de 3 a n/2 | Grau três não significa homogênea cúbica; a necessidade antipodal aplica-se às especializações cúbicas | Página primária IACR consultada em 15/10/2026; PDF retornou 403 nesta sessão |

## Sun et al.: a pendência de obtenção do texto não deve ser reaberta por engano

O arquivo histórico `COMPARACAO_SUN_2026.md`, preservado no commit-base, registra leitura integral de **22 páginas**, em 04/10/2026, com SHA-256 do PDF:

`f9c85a57ae37999105fe32855cc5225409db9dd0b3dc8ffd64abf4354aa89e50`.

A cópia histórica está arquivada sem alteração em `audit/SUN_COMPARISON_HISTORICAL.md`. O hash identifica o PDF que a comparação anterior declara ter consultado; não é apresentado como hash de um PDF baixado novamente nesta sessão. O original não foi localizado nas árvores atuais das branches remotas examinadas. A página Springer continua exibindo acesso por assinatura nesta passagem. Isso é diferente de dizer que nunca se obteve ou leu o texto completo.

Síntese da comparação integral anterior:

- O Corolário 2 já inclui n=2p^a, com p primo ímpar, e certos produtos de primos sujeitos a separação exponencial. Portanto “fatores ímpares compostos” por si só não caracteriza novidade.
- No caso de múltiplos primos distintos, as hipóteses de separação restringem o alcance desse corolário. O teorema certificado atual não as exige.
- O Teorema 5 impõe condições adicionais de paridade e valorações 2-ádicas aos geradores SANF.
- O Teorema 6 fixa primeiro um padrão de suportes e obtém um limiar de divisibilidade dependente dele. Não se deve trocar `∀ padrão, ∃ limiar` por um limiar uniforme em todos os padrões.
- O Teorema 3 é um critério dependente dos suportes. Não foi provado que nenhuma combinação dos critérios do artigo possa recuperar resultados adicionais; essa afirmação não aparece na revisão 1.3.

O arquivo histórico diz que n=32 ainda estava parcial **na data de sua escrita**. Essa frase não descreve o estado atual: o desenvolvimento Lean de 15/10/2026 cobre todo H>0, incluindo n=32. A comparação bibliográfica deve ser lida com essa atualização explícita.

A observação histórica sobre um termo linear na Eq. (21) não é usada para provar prioridade, invalidar o artigo ou sustentar o teorema global. A prova atual trata termos afins e constantes diretamente.

## Tang: referência incluída com limite de acesso explícito

Título completo confirmado na página primária:

**Deng Tang, Two Constructions of Rotation-Symmetric Bent Functions Outside the Completed Maiorana--McFarland Class with Any Possible Algebraic Degree**, Cryptology ePrint Archive, Paper 2026/1799, https://eprint.iacr.org/2026/1799.

O registro informa recebimento em 25/08/2026 e aprovação no arquivo em 28/08/2026; isso não significa aceitação por periódico. A descrição dimensional acima vem do resumo do autor. O PDF retornou 403 tanto pelo acesso direto quanto pelo mecanismo web nesta sessão. Não se alega aqui nova comparação de fórmulas nem reprodução do exemplo g′.

O texto de outra revisão colado na conversa relata um teste de g′ em dez variáveis, com 45 monômios e coeficiente antipodal 1. O programa desse teste não está no ZIP anexado e não foi recuperado; portanto esse teste não é incorporado como evidência reproduzida nesta entrega.

A frase da outra revisão de que Tang não era citado “em nenhum lugar do repositório” é ampla demais: a branch `research-openai-math-transfer-2026-10-09` já contém `pesquisa_v2_quartic/V2_PRIORITY_ALERT_EPRINT_2026_1799.md`. A inclusão nesta revisão resolve a omissão no manuscrito V1 examinado.

## Redação de contribuição permitida

> Demonstramos a necessidade do coeficiente quadrático antipodal para funções bent simétricas por rotação de grau algébrico no máximo três em toda dimensão par positiva. Isso exclui as funções homogêneas cúbicas. A prova combina restrição a espaços fixos de ordem ímpar, obstrução de diagonal constante em potência de dois e cancelamento de suportes sob a meia-volta; os enunciados universais estão certificados em Lean 4.15.0.

Não substituir isso por “resolvemos todos os graus”, “primeira prova mundial” ou “nenhum trabalho anterior se sobrepõe”. Uma comparação documentada não equivale a certificação exaustiva de prioridade ou revisão por pares.

## Links primários consultados ou usados como referências identificadas

- https://link.springer.com/article/10.1007/s10623-026-01848-4
- https://eprint.iacr.org/2026/1799
- https://ieeexplore.ieee.org/document/11483153/
- https://arxiv.org/abs/1708.09313
- https://arxiv.org/abs/1303.2282
- https://arxiv.org/abs/1908.08448

Não redistribuímos PDFs de terceiros sujeitos a assinatura.
