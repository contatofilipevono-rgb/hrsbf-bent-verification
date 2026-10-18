# Avaliação do apêndice de Zhang, Chen, Li e Qu

## Veredito

A sugestão de usar funções bent conhecidas como controles positivos é útil. As afirmações de que isso elimina qualquer dúvida, demonstra zero falsos negativos e explica uma impossibilidade causada apenas pela simetria cíclica são excessivas ou incorretas.

O PDF fornecido tem 14 páginas e identifica o trabalho como *New constructions of bent functions via 2-to-1 mappings and oval polynomials*, de Qiancheng Zhang, Hao Chen, Kangquan Li e Longjiang Qu. O apêndice lista fórmulas associadas às tabelas VI–IX e XIV–XVII; não contém todas as definições e convenções do artigo principal.

## Correções objetivas

- Página 4, item (14): U_12(z), Tabela VIII.
- Páginas 5–6, item (19): V_6(x,y), Tabela VIII.
- Página 6, item (20): V_7(x,y), não V_6. Com dois argumentos de sete bits, corresponde a 14 variáveis.
- O artigo tem quatro autores; Hao Chen também deve ser incluído na referência.

## O uso metodológico válido

Um controle positivo conhecido pode detectar erros grosseiros, como um verificador que rejeita todas as funções. É especialmente pertinente testar a transformação Walsh–Hadamard de 4096 pontos com funções de 12 variáveis cujo espectro esperado seja exatamente ±64.

Isso valida os casos e componentes efetivamente exercitados. Não prova, por amostragem, ausência universal de falsos negativos. Também não demonstra a cobertura da enumeração, a correção do gerador de coeficientes ou a necessidade de cada filtro anterior.

No nosso projeto há uma distinção prática essencial:

1. **Componente espectral:** pode receber uma tabela de verdade arbitrária. Um bent de outra família é um controle positivo adequado para a rotina FWHT e seu critério de aceitação.
2. **Gerador quártico rotacional:** recebe 43 coeficientes de órbitas específicas. Precisa ser confrontado com avaliações independentes dos monômios, incluindo controles de uma única órbita e combinações. Uma função externa à família pode não ter representação nesse formato.
3. **Peneira polinomial especializada:** suas entradas e fórmulas foram deduzidas para a família pesquisada. Não se pode interpretar uma função bent externa como um vetor de 43 coeficientes e exigir que percorra a mesma peneira sem uma adaptação justificada.
4. **Cobertura:** a continuidade dos intervalos, o domínio enumerado e a cobertura das folhas exigem verificações próprias. Passar em controles espectrais não confere esses pontos.

Para afirmar que um controle passou pelo mesmo código CUDA, é necessário executar esse código, registrar a versão, os parâmetros, a entrada e os resultados. Nesta análise não foi executada uma nova validação CUDA com as fórmulas do apêndice. Portanto, não incorporar uma frase no passado afirmando que ela ocorreu.

## Por que ainda não transcrevi U_12 ou V_6 como controle executável

É preciso recuperar do artigo principal a definição exata da função booleana associada a U_n e V_m: a eventual aplicação do traço, os corpos, a representação da base, o polinômio irredutível e a definição dos elementos primitivos α e β. O apêndice isolado não fixa essas convenções de forma suficiente.

Não escolher uma representação arbitrária de α ou β e chamar o resultado de reprodução do exemplo publicado. Um controle simples com prova direta, como F(x,y)=x·y em 12 variáveis, pode ser usado imediatamente como referência independente; uma reprodução dos exemplos do apêndice acrescentaria diversidade após a recuperação das convenções.

## O contraste teórico precisa ser corrigido

A simetria por rotação não impede bentness em 12 variáveis em geral. Por exemplo,

    F(x_0,...,x_5,y_0,...,y_5)=Σ_i x_i y_i

é bent e invariante pela rotação cíclica das 12 coordenadas, que permuta os pares antipodais. Logo, a divisão 6+6 não é incompatível, por princípio, com uma função rotacional.

O enunciado relevante do projeto é específico: inexistência na família **homogênea de grau quatro** H(12,4). O resultado computacional global auditado já existe; a prova Lean integral ainda está em desenvolvimento.

O cancelamento das 40 órbitas completas na restrição diagonal é um fato estrutural útil, mas não estabelece sozinho que uma função não possa ser bent. A alegação de “destruir a geometria necessária” ou “colapsar o posto simplético” precisaria definir a forma bilinear relevante, calcular seu posto e provar a implicação pretendida. O texto do Gemini não faz isso.

## Novidade: não concluir apenas pela aparência dos polinômios

A construção por ovais não coincide automaticamente com a família investigada, mas “não ameaça a novidade em nada” é uma conclusão forte demais sem ler o artigo principal e suas referências.

Expoentes grandes em uma representação sobre corpos finitos não demonstram ausência de simetria rotacional nem de homogeneidade em uma base booleana particular. É preciso converter a função corretamente para ANF e testar/provar as propriedades na ordem de coordenadas adotada. O grau algébrico é preservado por mudanças lineares invertíveis de coordenadas; homogeneidade e a simetria cíclica específica não têm a mesma invariância.

A relação bibliográfica mais provável é complementar: construção de exemplos bent para controles e contexto, frente a uma exclusão em uma subfamília restrita. Isso é uma avaliação de escopo, não uma revisão completa de anterioridade.

## Texto metodológico que pode ser usado após executar os controles

“Known 12-variable bent functions were used as positive controls for the 4096-point Walsh–Hadamard verifier. For every tested control, the implementation returned a flat spectrum of magnitude 64. These tests complement the independent checks of the orbit evaluator, the necessary filters and the enumeration coverage; they are not a universal guarantee against false negatives.”

A frase deve continuar como proposta até que os respectivos testes estejam documentados. Uma nota sobre reprodução de U_12 ou V_6 só deve ser acrescentada após conferir as convenções e executar as entradas correspondentes.

## Decisão para o projeto

Aproveitar a ideia dos controles positivos. Corrigir as referências dos itens. Usar a geometria projetiva como contexto, sem reivindicar uma obstrução não provada. Não anunciar uma reprodução CUDA não realizada, nem uma conclusão de novidade baseada apenas na forma visual dos polinômios.
