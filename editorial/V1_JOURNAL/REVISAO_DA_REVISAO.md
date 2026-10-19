# Revisão do manuscrito recebido

19/10/2026. O original recebido foi preservado integralmente em `ORIGINAL_RECEBIDO.md`, SHA256 `54559e5debd0612d8e30d110e36afad42ae942d476351cda56b183aebeb56ba6`. A versão corrigida é `ARTIGO_REVISADO_AUDITADO.md`; o artigo de periódico está em `paper/`.

## Avaliação para um revisor humano

A revisão melhora a legibilidade. As definições antes dos resultados, a separação de lemas elementares, os quatro passos da obstrução e o exemplo n=6 permitem conferir a cadeia com menor esforço. Sete páginas de desenvolvimento e referências são proporcionais ao resultado e mais úteis que minimizar artificialmente a contagem.

Não foi identificado novo erro na prova central. Isso não significa aceitação integral do texto recebido: foram aplicadas 14 correções explícitas, incluindo formulações matemáticas auxiliares. O arquivo `ALTERACOES_EXATAS.json` preserva cada substituição e sua razão.

## Correções relevantes

| Ponto | Avaliação e correção |
|---|---|
| Resumo: n par sem positividade | Acrescentado n>0, conforme o teorema e o coeficiente x0 x(n/2) |
| Equilíbrio “q não nula no radical” no roteiro | Corrigido para q+q(0) não nula no radical do polar. A normalização é essencial: q constante igual a 1 não é equilibrada, embora não seja nula no radical. O lema formal do texto já estava normalizado corretamente |
| “Único lugar onde a estrutura cíclica é usada” | Corrigido: a potência de dois entra pela nilpotência; simetria cíclica também é usada na repetição, meia-volta e covariância da fibra |
| Termos afins apenas “permutam valores” de Walsh | Corrigido: a parte linear permuta frequências e a constante pode inverter sinais |
| Vetor repetido “tem período h” | Especificado “período divide h”; zero e outros vetores podem ter período mínimo menor |
| “Sharpness” | Substituído por não vacuidade. Os exemplos mostram hipóteses realizáveis, não uma alegação não formulada de otimalidade |
| Antecedentes | Explicitado caso cúbico n=2p já conhecido e registrada objeção publicada a um critério de Zhang–Gao que não é utilizado |
| Motivação criptográfica | Usada a definição precisa de não linearidade; retirada alegação ampla de emprego direto em cifras |

As demais substituições ajustam o resumo, a organização e a descrição da evidência. Nenhuma altera o teorema, remove hipótese indispensável ou transporta resultados para grau 4.

## Verificações matemáticas

- Releitura dos lemas de Gauss, média no radical e rigidez: a normalização e os dois sentidos das equivalências permanecem explícitos.
- Lema 2.1: as derivadas baixam grau; as correções na identidade para D(a+a') são de ordem três em quadráticas e quatro em cúbicas e se anulam. A identidade afim de segundas diferenças e a comparação do polar estão corretas.
- Exemplo n=6: a simetria reduz g a beta·ab+gamma·(a+b)+delta; bentness equivale a beta=1. Conferidas as oito combinações.
- Formalização: fontes `formalization/` inalteradas em relação ao commit certificado `6dd183685ef8a5b033c1bcf8733496d57b853cc7`; sem novo build Lean. A prova por média no radical continua sem derivação própria compilada.
- Controles finitos novos: 131.072 verificações de constância da terceira diferença e 131.072 da identidade afim de segundas diferenças, para todas as funções em três variáveis e todas as direções relevantes. Não são demonstrações universais.

## Bibliografia e prioridade

Veja `AUDITORIA_BIBLIOGRAFICA.md`. A formulação da conjectura foi conferida no original; os registros dos quatro artigos de periódico foram conferidos; os dois preprints arXiv foram lidos nos trechos relevantes. O MSC 2020 94D10 foi confirmado e mantido.

Não se encontrou nos trechos examinados um resultado anterior com exatamente o enunciado universal grau≤3. Isso não demonstra ineditismo absoluto. A comparação agora identifica um antecedente concreto, evitando apresentar o caso cúbico inteiro como se todas as dimensões fossem novas.

## Estado de produção

A versão `amsart` tem sete páginas e foi compilada com Tectonic 0.17.0. Foram corrigidos acentos, título corrente e numeração dos lemas; o verificador confere títulos e números no PDF, não somente ocorrências de citações no corpo. Não há caixas fora das margens, glifos ausentes ou referências indefinidas no log final. As páginas foram renderizadas para revisão visual.

Este parecer é revisão interna adicional, não arbitragem externa. Originais e commits anteriores foram preservados. Não houve submissão, publicação de preprint, merge em main ou alteração dos jobs Lean de H(12,4).
