# Revisão do artigo completo — 6 de outubro de 2026

## Entrega e estado

Esta versão consolida o artigo geral e a nota de obstrução por fibras. É um rascunho de pesquisa com argumento algébrico desenvolvido; não é uma certificação de prioridade, revisão humana por pares nem autorização para anunciar a resolução de toda a conjectura.

O texto da branch de submissão anterior foi lido diretamente do repositório e coincide com a versão local usada como base. A revisão é entregue em arquivos novos na branch de pesquisa, preservando a versão anterior para comparação.

## Mudança matemática central

A nota de potências de dois pode ser fortalecida: a sua prova usa grau no máximo três e anulação na diagonal, e não precisa que a função seja homogênea em cada passo. Esse ponto é indispensável para unir a nota ao artigo geral: uma restrição por repetição de bloco pode criar termos quadráticos e lineares.

O novo encadeamento é:

1. Para q quadrática e invariante por uma transformação de ordem ímpar, a soma de sinais no complemento do espaço fixo é não nula. Isso é demonstrado pela anulação de q normalizada no radical, com o operador P=ΣT^j. Portanto a nulidade da soma total equivale à nulidade da soma no espaço fixo.
2. Para f invariante de grau ≤3 e bent, as derivadas em direções fixas são quadráticas e balanceadas. A restrição ao espaço fixo de dimensão par é bent. A prova não afirma que toda restrição arbitrária de bent é bent.
3. Em t=2^s, uma função RS g de grau ≤3 com g(u,u)=0 não é bent. Parseval força o balanceamento dos cosets não nulos. O lema quadrático cíclico força o polar de D_1g a zero; a polarização cúbica transfere essa anulação para a fibra complementar. A simetria de rotação com correção e_0 torna a fibra afim constante, contradizendo o balanceamento.
4. Se n=tm, m ímpar, a repetição de y=(u,u) pertence à diagonal de meia-volta em n variáveis. A restrição conserva g(u,u)=0, ainda que perca homogeneidade.

A composição fornece o enunciado apresentado no novo Teorema 5.1: inexistência de cúbicas homogêneas RS bent em toda dimensão positiva par. Esse alcance é mais forte que as duas versões anteriores separadamente. O elo foi escrito de maneira explícita e deve receber atenção especial de um especialista independente antes de submissão.

Corolário adicional: toda RS bent de grau ≤3 precisa incluir a órbita quadrática antipodal. Fora dessa órbita, os monômios não constantes de graus 1, 2 e 3 cancelam aos pares na diagonal. O corolário não exclui cúbicas RS não homogêneas que incluam essa órbita.

## Melhorias de exposição

- Título, resumo e contribuição principal agora refletem o argumento completo.
- As definições e provas usam uma convenção explícita de rotação para a identidade da fibra complementar.
- A hipótese de anulação diagonal está no enunciado da obstrução; o texto não a deduz simplesmente da homogeneidade em coordenadas arbitrárias.
- As verificações de divisibilidade, os espaços reduzidos e os certificados de família foram movidos para apêndices; continuam relevantes, mas não são premissas da prova geral nova.
- Os 43 geradores em n=16 são 35 cúbicos, sete quadráticos de órbita completa e a paridade linear. Há oito órbitas quadráticas no espaço RS completo; a antipodal está excluída deste espaço reduzido. O artigo conserva essa distinção.
- A conta correta em n=32 é wt(H)/32 ≡512 (mod 2048). A expressão 32*wt(H) ≡512 é falsa. O exemplo refuta uma extensão específica de divisibilidade; não estabelece que toda técnica de Ward falha em n=32.
- O certificado de sete fibras continua limitado à família que ele reconstrói. A exclusão geral em n=32, no novo texto, vem do argumento algébrico.
- Não se incorporam a conjectura falsa do degrau par nem a busca GPU como provas para graus maiores.

## Controles novos, exatos e reproduzíveis

Comando: `python3 audit_bridge.py`. Python padrão, sem dependências externas, sem GPU, com erros explícitos ativos também sob otimização.

- Identidades em todas as 912 funções geradoras dos espaços reduzidos para t=2,4,8,16,32,64; zero diferenças.
- Mais 32 combinações determinísticas de geradores por dimensão, mantendo termos quadráticos e lineares; zero diferenças.
- Dobramento de todas as 3483 órbitas cúbicas nas dimensões 6,10,12,18,20,24,30,40,48,80,96; zero diferenças.
- Enumeração completa dos espaços reduzidos em t=2,4,8: respectivamente 2, 8 e 2.048 funções; nenhuma bent.
- Controle de fronteira: a quadrática antipodal restringe à paridade na diagonal, mostrando por que não satisfaz a hipótese do novo lema.

Esses controles conferem identidades finitas e casos de borda. A demonstração de todos os n depende das provas algébricas, não da extrapolação desses testes. O JSON registra as dimensões e quantidades efetivamente executadas.

## Pendências que impedem chamar esta versão de pronta

1. Revisão independente do novo argumento geral: especialmente o lema de ordem ímpar, a versão de grau ≤3 da obstrução e a preservação da diagonal. Parecer de IA e controles finitos não substituem esse exame.
2. Comparação com Tokareva concluída no PDF enviado pelo autor: *Algebraic normal form of a bent function: properties and restrictions*, ePrint 2018/1160, seção 7, Teorema 9, p. 7. O teorema é atribuído no próprio texto a Stănică (2008), referência 26, e reúne três critérios condicionais de suporte. Não enuncia a inexistência de todas as cúbicas homogêneas RS em dimensões pares. Em n=16, d=3, a hipótese do item (iii) é d_f<7/5. O manuscrito agora cita o survey e a atribuição original, distinguindo comparação de enunciados de certificação global de prioridade. A prioridade continua pendente de busca mais ampla e leitura das fontes originais. Ver `COMPARACAO_TOKAREVA_2018.md`.
3. A revisão de escopo de Meng (2010) e Sun et al. (2026) continua baseada nas comparações documentadas e PDFs já disponíveis. A novidade do alcance geral exige rechecagem, mesmo que as comparações antigas para v₂(n)≤4 fossem adequadas.
4. Confirmar afiliação, autor correspondente, declarações exigidas pela revista e política sobre uso de IA. O nome do autor foi inserido, mas nenhuma afiliação foi inventada.
5. Refazer a carta de apresentação e ajustar o material suplementar para o novo alcance depois da escolha da revista. A carta antiga descreve um resultado mais estreito.
6. Associar cada arquivo suplementar citado à versão exata do repositório. Não converter um certificado de UNSAT de uma CNF em prova de não-bentness sem validar a correspondência semântica do modelo.

## Recomendação

Enviar primeiro esta versão para um especialista da área, com atenção ao Teorema 5.1 e ao seu corolário. Se o argumento geral for confirmado e a prioridade esclarecida, a escolha editorial deve refletir o novo alcance. O caso de graus ≥4 permanece aberto neste trabalho.
