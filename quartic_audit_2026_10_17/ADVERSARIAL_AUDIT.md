# Instruções para auditoria adversarial

Objetivo: tentar refutar os resultados e identificar qualquer passagem de evidência computacional para afirmação matemática sem justificativa.

1. Reconstrua as 43 órbitas quárticas e confira que cada um dos 495 suportes aparece exatamente uma vez. Não some uma órbita curta doze vezes.
2. Verifique que a busca global usa a base identidade de 43 coordenadas. Não aceite as cinco leis iniciais como hipóteses globais.
3. Refaça os filtros quadráticos pela identidade do segundo bit do peso, em vez de confiar apenas na interpolação do gerador.
4. Audite o ZIP original, sua fonte e os 8.388.608 registros: intervalo [0,2^43), continuidade, tamanhos e contagens. Procure estouro de índices e falhas de CUDA não tratadas.
5. Audite as duas repetições completas em CPU nos quatro espaços necessários e o certificado simbólico em `cpu_replay/`. Confira os postos das cartas, as combinações lineares, a substituição de cada variável, a divisão exaustiva dos ramos e todos os 164.288 testemunhos de Walsh. A enumeração literal das 2^43 funções na GPU não foi repetida localmente; a verificação independente usa condições necessárias comprovadas separadamente.
6. Verifique as três identidades booleanas sem SAT; procure erro na redução c_i²=c_i e na correspondência de índices.
7. Confira os quatro casos de período quatro e as contagens 76 pontos curtos/335 órbitas longas. Tente construir um candidato que passe nessas condições; isso não seria contraexemplo ao resultado global, pois os filtros são apenas necessários.
8. Compile Lean 4.35.0 e examine os axiomas das declarações finais. Procure diferenças entre o enunciado informal e as hipóteses formais. Em particular, `H12Refutation.check_sound` é genérico e condicionado à correção do teste terminal: não existe ainda uma aplicação formal à árvore global com todos os testemunhos de Walsh. Confirme essa distinção.
9. Compare os resultados com Sun–Shi–Liu–Fu (2026), especialmente as hipóteses dos Teoremas 1–4 e o escopo cúbico dos Teoremas 5–6. A ausência de um teorema que cubra todo H(12,4) nesse artigo não estabelece, sozinha, novidade frente à literatura inteira.
10. Audite os artefatos históricos como histórico: parte deles registra conjecturas, tentativas abandonadas e correções. `CLAIMS.md` identifica as afirmações atuais.

Uma objeção útil deve trazer o arquivo e seu hash, o enunciado contestado, a hipótese ausente ou o menor exemplo reproduzível. Um contraexemplo bent exige o vetor original de 43 coeficientes e a verificação de todas as 4.096 amplitudes de Walsh, de módulo 64.
