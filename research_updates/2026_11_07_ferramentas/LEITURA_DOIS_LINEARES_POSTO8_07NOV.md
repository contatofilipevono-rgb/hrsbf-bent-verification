# Duas formas lineares: corolário candidato e controles independentes

07/11/2026. Codex. A nota DOIS_LINEARES_07NOV.md e os scripts posto8.py/decide2.py não foram localizados no disco; seus links de artefatos Claude não puderam ser abertos. Portanto não reexecutei a classificação das 101 classes nem o novo branch-and-bound. O fechamento geral recebido permanece candidato.

## 1. Passagem lógica conferida

Se o Teorema A+ recebido vale (I6 e produto com resto cúbico implicam flat cúbico de codimensão até três), então o caso Delta=A wedge B+x1 wedge phi1+x2 wedge phi2 tem flat cúbico de codimensão até cinco: restrinja a W=ker(x1) interseção ker(x2), preserve I6 e some as codimensões. Com uma forma linear, o mesmo argumento dá quatro. A melhora depende do A+, não apenas do Teorema A anterior que dava quatro dentro de W.

## 2. Conferência nova, independente dos scripts recebidos

Criei confere_posto8_local.py, executado em Python com biblioteca padrão. Constrói os cinco pencils regulares de dimensão oito usando blocos companheiros: dois blocos t²+t+1; um bloco (t²+t+1)²; e os três polinômios irredutíveis de grau quatro (máscaras 19,25,31).

Para cada pencil enumera TODOS os 10.795 subespaços de dimensão seis por bases em forma escalonada reduzida. Calcula o pullback exterior de T=A wedge B em cada um: zero casos nulos. Encontra e verifica um subespaço nulo de dimensão cinco em cada classe. Portanto a codimensão mínima é exatamente três nesses cinco exemplos. A translação não altera a parte de grau quatro, logo não há também flat afim cúbico de codimensão dois nesses exemplos.

Isso não classifica as outras 96 classes alegadas, nem certifica a cota de suporte quinze. Nessas três classes irredutíveis, o teste restrito a correções quadráticas não encontrou solução; não é exclusão de correções cúbicas gerais.

## 3. Duas testemunhas I6 e uma testemunha I7

O mesmo programa resolve o sistema afim das correções quadráticas no levantamento inteiro. Obtém testemunhas explícitas nos blocos semissimples e repetido. As máscaras da ANF estão em CONTROLE_INDEPENDENTE_POSTO8_07NOV.json; uma máscara m representa o monômio produto dos x_i para os bits ligados de m.

Para cada testemunha, confere o perfil inteiro módulo quatro em todos os graus pelo menos seis e testa diretamente os pesos nos 43.180 flats afins de dimensão seis. Para grau até quatro, o teste de peso módulo quatro equivale a todos os Walsh módulo oito: a interseção da função com uma forma linear tem grau até cinco em seis variáveis e peso par.

Depois faz dois testes independentes de I7: (i) restrições de Walsh obtidas do espectro ambiente; (ii) transformada de Walsh direta de cada um dos 510 flats afins de dimensão sete, em todos os caracteres não triviais. Também confronta o perfil inteiro de liftabilidade.

Resultados:
- Semissimples F4+F4: I6 passa; I7 falha. No hiperplano x0=0, o caráter x1 tem Walsh 8, que não é múltiplo de 16.
- Bloco repetido (t²+t+1)²: I6 E I7 passam. A ANF verificada tem máscaras [17,19,36,38,50,53,68,76,86,89,100,106,129,132,137,140,145,149,154,163,166,172,196,197,200]. Não possui flat cúbico de codimensão dois, por enumeração completa da parte quártica.

Logo a esperança de melhorar universalmente a codimensão três para dois apenas acrescentando I7 já encontra um contraexemplo exato em dimensão oito. Isso NÃO refuta Lema L (o exemplo tem flat cúbico de codimensão três), nem satisfaz automaticamente as condições espectrais de peso e pico do problema global.

## 4. Auditoria prioritária da nova entrega

1. Conferir a prova da cota de suporte quinze para TODAS as exceções de K, incluindo radicais e pencils singulares.
2. Separar: certificados negativos de condições necessárias; testemunhas positivas com I6 completo; limites/timeouts do solver.
3. Conferir as duas classes singulares solúveis e suas testemunhas isotrópicas.
4. Não confundir o núcleo em Lambda3 de T wedge - com o núcleo em Lambda2: T tem grau quatro e phi_i grau três. Lambda2 só aparece após uma fatoração adicional, por exemplo phi_i=z_i wedge eta_i, ou uma contração explicitada.

O caso de três formas lineares é um próximo alvo estrutural, não uma conclusão desta conferência. A testemunha I7 repetida é um controle positivo importante para qualquer equação nova: uma condição necessária não pode eliminá-la erroneamente.

Origem: Teorema A+ e a lista das sete classes foram propostos por Opus; esta leitura e os controles em cinco classes são de Codex. Nada aqui reivindica prioridade bibliográfica. p=17 e Q1 geral permanecem abertos.
