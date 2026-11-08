# Auditoria da entrega Argon — duas formas e I6

07/11/2026. Codex. Originais preservados. Script próprio: audita_argon_duas_formas.py. Saída: AUDITORIA_ARGON_DUAS_FORMAS_CONTROLES.json. Apenas biblioteca padrão.

## Veredito

**Adendo posterior da mesma data:** o Teorema 4.2 foi REFUTADO por Astra, com certificado de nove equações conferido independentemente por Codex. Ver ASTRA_CONTRAEXEMPLO_G7_SSPAN_07NOV.json e CONTROLE_CODEX_CONTRAEXEMPLO_ASTRA_G7_07NOV.json. O exemplo pertence a S_span e passa no grau oito, mas nenhuma correção cúbica resolve o grau sete. As referências abaixo a enunciado ainda não refutado descrevem o estágio anterior da auditoria; este adendo prevalece.

Entrega aproveitável com correções obrigatórias. O verificador original foi reexecutado em cópia de trabalho e passou; isso NÃO valida todas as demonstrações do documento. Duas passagens da prova escrita são falsas. O segundo certificado é correto em seu domínio restrito, mas não exclui todas as correções cúbicas: existe uma completação I6 explícita fora desse domínio.

## 1. Erro na identidade central do Teorema 4.2

Na seção 4.3 de EQUACOES_I6_DUAS_FORMAS.md, com sigma1 a soma das contrações, afirma-se

    P *_1 Omega = sigma1(P) wedge Omega + P wedge sigma1(Omega) + sigma1(P wedge Omega).

Isso é falso. O lado direito é identicamente zero pela regra de Leibniz em característica dois. Tome P=abcd=(ab) wedge (cd) e Omega=ae. Temos P wedge Omega=0, mas P *_1 Omega=abcde, não zero. O contraexemplo satisfaz as hipóteses P=A0 wedge B0 e P wedge Omega=0 usadas naquela passagem.

Consequência: retirar o status de PROVADA NO TEXTO da demonstração apresentada do Teorema 4.2 e da refutação C3 que se apoia nela. Não concluí que o enunciado universal seja falso: numa sondagem própria, 210 instâncias da subclasse que passaram no grau oito também tiveram grau sete solúvel. Isso é amostra, não reparo da prova.

O programa do Argon não verifica essa identidade universal falsa. Sua saída contém a afirmação em texto e verifica solubilidade em instâncias, deixando escapar a falha da demonstração.

## 2. Erro no argumento para gamma2 de uma forma decomponível

Na seção 1.1, item 2, afirma-se que o levantamento inteiro de um produto de quatro formas lineares booleanas tem grau inteiro até quatro em qualquer base. É falso: (a XOR b)cde tem levantamento acde+bcde−2abcde, de grau cinco. Uma forma linear booleana não é uma forma linear inteira em coordenadas arbitrárias.

A conclusão gamma2(decomponível)=0 não foi refutada por isso; o argumento usado precisa ser substituído por uma prova exterior correta. Não descartar por associação as equações de graus oito, sete e seis, que podem ser deduzidas diretamente contando uniões de monômios.

## 3. Primeiro certificado: conferido

Para Delta com máscaras [57,404,594] em dez variáveis, conferi o vetor dual [445,635,982] contra TODAS as colunas de Delta wedge Lambda3 e contra o lado direito tau1(Delta). Ele produz 0=1 exatamente. Logo essa parte principal não admite correção de grau até três compatível com I6.

Limite de relevância: todos os três monômios de Delta contêm y3. Já há, portanto, um hiperplano cúbico y3=0. É um controle útil para as equações, não evidência de inexistência no núcleo difícil de alta codimensão.

## 4. Segundo certificado: válido só no span declarado

Para Delta=[15,51,53,60,178,204,240], o vetor dual [63,125,243,250,252] é válido para todas as correções quadráticas e para os deslocamentos cúbicos na interseção do span gerado pelas duas formas modificadas com o núcleo de grau sete. Conferi os termos lineares e todos os termos cruzados dessa interseção.

Há uma lacuna adicional no programa recebido: ele mantém só os geradores individuais que já estão no núcleo, obtendo um span de dimensão oito. Isso não é automaticamente a interseção entre o span original e o núcleo, que aqui tem dimensão dez. Recalculei a interseção por álgebra linear e o certificado também passou nas duas direções adicionais e seus termos cruzados. Logo essa lacuna de implementação foi reparada na conferência própria; não derruba o certificado restrito deste exemplo.

O núcleo COMPLETO de Delta wedge - em Lambda3 tem dimensão 48. O certificado anula as 48 variações individuais, mas NÃO todos os 1.128 termos cruzados. Este é precisamente um caso em que conferir apenas direções isoladas produziria uma conclusão falsa.

Direções explícitas de máscaras 21 e 42, somadas à solução particular R3=[13,14], dão R3=[13,14,21,42]. Essa correção ainda passa no grau sete e muda o lado direito do certificado de paridade um para zero. Com

    R2=[3,10,12,17,34,130,132],

obtém-se a função de ANF

    [3,10,12,13,14,15,17,21,34,42,51,53,60,130,132,178,204,240].

O levantamento inteiro passa no perfil completo módulo quatro. Conferi também os pesos de TODOS os 43.180 flats afins de dimensão seis: são múltiplos de quatro. Para grau até quatro isso equivale a I6: em seis variáveis, multiplicar pela forma linear que define um caráter dá grau até cinco e peso par, logo todos os Walsh são congruentes ao Walsh zero módulo oito.

As máscaras usam a ordem x1,x2,y1,...,y6, a mesma do certificado. A expressão original do Argon restringe o segundo certificado ao span; nessa leitura estrita ela está correta. A completação refuta apenas sua extrapolação a todo o núcleo, não o certificado restrito. Não resolve Q1/p17 nem refuta o Lema L.

## 5. Partes que podem ser usadas

A redução por hiperplano quando Phi1, Phi2 ou Phi1+Phi2 pertence a A0 wedge Lambda1+B0 wedge Lambda1 é uma identidade algébrica válida. Sua consequência de codimensão cinco continua condicional ao teorema candidato dos produtos. As fórmulas por sobreposição de monômios e a decomposição setorial são material reutilizável; não converter testes em prova de teoremas universais.

O próximo trabalho deve reparar a prova do Teorema 4.2 ou refutar o enunciado, incluir o contraexemplo P=abcd, Omega=ae nos controles e conservar a completação I6 acima como controle positivo contra extrapolações do certificado 2. Nenhum original foi corrigido silenciosamente. Nenhuma alegação de novidade ou publicação científica é feita.
