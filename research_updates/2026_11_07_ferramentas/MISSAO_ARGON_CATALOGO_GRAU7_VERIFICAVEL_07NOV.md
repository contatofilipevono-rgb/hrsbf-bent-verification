# Missão Argon — catálogo exato do grau sete, sem teoremas presumidos

Você deve produzir um catálogo finito verificável para a família

    Delta = T + x1 wedge x2 wedge Omega,  T=A wedge B,

com A,B em oito variáveis y e x1,x2 independentes delas (dez variáveis ao todo). É uma subclasse deliberada; não a confunda com toda S_span nem com a quártica geral.

## Dados e controles obrigatórios

Trabalhe a partir de outputs/CADERNO_TECNICAS_BENT.md, técnicas 25–32, PARECER_CODEX_ARGON_DUAS_FORMAS_07NOV.md e os scripts próprios audita_argon_duas_formas.py e confere_posto8_local.py. Não alterar os originais. Pasta nova: outputs/argon_catalogo_grau7_v2.

O Teorema 4.2 da entrega anterior NÃO tem prova aceita: sua identidade com sigma1 soma das contrações é falsa. P=abcd, Omega=ae dá P wedge Omega=0, mas P *_1 Omega=abcde; a fórmula usada dava zero. Não reutilizar essa identidade nem escrever que as amostras a provam.

Outro erro a evitar: o levantamento inteiro de (a XOR b)cde é acde+bcde−2abcde, não tem grau até quatro.

O certificado 2 anterior só vale na interseção do span declarado com o núcleo, não no núcleo cúbico inteiro. Há uma completação I6 com a mesma parte quártica. A auditoria contém a ANF explícita. Ela deve passar em qualquer verificador novo.

## Etapa 1 — reconstruir cinco classes, sem copiar tabelas

Use os cinco pencils regulares em oito variáveis:
1. dois blocos do polinômio t²+t+1;
2. um bloco de (t²+t+1)²;
3–5. os três irredutíveis de grau quatro (máscaras binárias 19,25,31).

Recalcule as matrizes alternadas, os três postos e T=A wedge B. Compare com o script de controle, mas implemente a construção ou a verificação de posto por caminho próprio.

Para cada classe calcule EXATAMENTE

    K2 = ker(T wedge - : Lambda2(F2^8) -> Lambda6(F2^8)).

Entregue bases, dimensões e checagem de posto-nulidade. Não confunda K2 com o núcleo em Lambda3.

## Etapa 2 — catálogo de Omega e equações G7

Para Omega em K2, construa Delta em dez variáveis. Confirme gamma2(Delta)=0 por contagem direta dos pares disjuntos.

Antes de enumerar, informe dimensão d de K2 e custo 2^d. Enumeração completa só se d<=16; acima disso entregue a parametrização e uma alternativa simbólica, sem iniciar uma busca enorme.

Resolva para cada Omega o sistema linear COMPLETO

    Delta wedge R3 = tau1(Delta),  R3 em Lambda3(F2^10).

Não use apenas o span(A wedge Lambda1+B wedge Lambda1). Calcule o núcleo inteiro e não filtre apenas geradores individualmente válidos: kernel de um mapa restrito ao span pode conter combinações de geradores inválidos isoladamente.

Caso solúvel: entregue R3 particular e base do núcleo (ou referência a uma base compartilhada com verificação). Caso insolúvel: certificado dual w com w^T M=0 e w^T b=1.

O sucesso esperado é um catálogo exato com testemunhas, inclusive se todos os casos forem solúveis. Isso NÃO demonstra o Teorema 4.2 geral.

## Etapa 3 — segundo caminho e escopo

Para toda testemunha R3, confira o desaparecimento dos graus oito e sete por tabela de verdade e Möbius inteiro, além das fórmulas exteriores. Para certificados negativos, um verificador separado deve reconstruir as colunas e o lado direito, sem confiar nos booleanos gravados pelo solver.

Não confunda solução de G7 com solução I6: o grau seis pode falhar. Não decida G6 por uma relaxação que trate produtos de parâmetros como variáveis independentes, salvo como condição necessária expressamente identificada. Não chame isso de decisão completa.

## Entrega

- LEIA_PRIMEIRO.md: conclusão em até vinte linhas, com escopo.
- CATALOGO.json: classes, bases K2, cobertura e estados de cada Omega.
- CERTIFICADOS.json: testemunhas/certificados e convenção das máscaras.
- verificar_catalogo.py: reconstroi e verifica todos os casos sem solver.
- REPRODUCAO.md: um comando, tempo e requisitos.
- HIPOTESE_PARA_ASTRA.md: apenas se aparecer um padrão, marcado como conjectura e acompanhado de controles negativos.

Use biblioteca padrão ou NumPy já disponível. Sem GPU, instalações, compras, publicação ou alteração dos arquivos originais. Não reivindique novidade. P17 e Q1 geral continuam abertos. Se um teste falhar, preserve a falha e sua causa; não enfraqueça a asserção para obter PASSOU.
