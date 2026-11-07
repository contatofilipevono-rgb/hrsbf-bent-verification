# Produto módulo uma forma linear — leitura da nova entrega

07/11/2026. Conferência de Codex do argumento recebido por mensagem. A nota completa NAO_PRODUTO_07NOV.md e os scripts dessa entrega não foram encontrados nos diretórios locais pesquisados. Não atribuir às contagens desse relatório uma reprodução local que não ocorreu.

## 1. O que coincide com o pacote anterior

O Teorema A coincide com o enunciado já arquivado em fechamento_produto_cubico_07nov: sob I6, D=Q1Q2 XOR R, deg(R)≤3, força algum dos três postos polares ≤8 e um flat cúbico de codimensão ≤4. Não é um segundo fechamento independente de família. A nova rota por módulos/classificação tem dependências próprias; a nossa redução por hiperplanos evita depender da classificação global de todas as violações de K.

O relatório colado como anexo é outra entrega: auditoria do Argon em outputs/argon_auditoria_hiperplanos_07nov. Ele distingue reproduções mecânicas e dependências teóricas. O parecer não transforma automaticamente a prova candidata em resultado estabelecido.

## 2. Corolário conferido: produto módulo uma forma linear

Seja D booleana de grau ≤4 com parte quártica exterior Delta. Suponha I6 e Delta=A wedge B + x wedge phi, onde A,B são 2-formas, x é uma forma linear não nula e phi uma 3-forma. Restrinja a H=ker(x). I6 se preserva: todo 6-flat de H também é um 6-flat do espaço original.

Em H, a parte quártica é (A|H) wedge (B|H). Escolha quadráticas q1,q2 que realizem essas polares. Então D|H=q1q2 XOR r, deg(r)≤3, pois a parte de grau quatro da diferença é zero. Aplicando o teorema candidato dos produtos, obtém-se W contido em H, de codimensão até quatro em H, onde D tem grau até três. Sua codimensão no espaço original é até cinco. Se x=0, aplica-se diretamente o caso produto. Se a dimensão restante é menor que seis, também se obtém um flat de dimensão até três com a codimensão requerida, sem usar I6.

O argumento é válido como corolário CONDICIONAL ao teorema dos produtos. Não exige testar milhares de funções nem GPU. A extensão a k formas lineares fornece codimensão até k+4, ou até r+4 se o span das formas tiver dimensão r. Para k=2 isso garante apenas seis, insuficiente para a obstrução global de codimensão cinco usada nesta frente.

## 3. Redução à parte principal

Para um flat a+W, a parte de grau quatro da restrição é o pullback de Delta a W. A translação a contribui somente em graus menores. Assim, deg(D|a+W)≤3 equivale a Delta|W=0. A existência do flat cúbico depende só de Delta. A condição I6, porém, depende também dos termos inferiores de D; não pode ser substituída por uma condição apenas em Delta sem prova adicional.

## 4. O que continua sendo hipótese

As fórmulas de grau oito e os resultados de K3 do novo relatório ainda não foram reproduzidos nesta leitura. Trinta ou trinta e seis testes aleatórios não demonstram um lema de núcleo universal. A classificação das exceções exige prova de cobertura, além da enumeração finita.

O Lema M é uma proposta estrutural suficiente para L, não um fechamento nem uma redução já decidida. O caso Delta=A wedge B+x1 wedge phi1+x2 wedge phi2 com x1,x2 independentes é um alvo delimitado, mas pode ainda exigir distinguir muitas classes. Não se conclui inexistência de quárticas gerais, Q1 geral ou p=17.

## 5. Próxima missão com melhor relação entre esforço e informação

Auditar primeiro a necessidade de gamma2(Delta)=0 e a fórmula para somas de produtos, com sinais, operação de potências divididas e hipóteses explícitas. Depois tratar o caso de duas formas lineares independentes usando conjuntamente os níveis sete e seis. Entrega desejada: prova da codimensão cinco, ou contraexemplo exato ao lema estrutural proposto; contraexemplo ao lema não é automaticamente candidato ao problema espectral global. Evitar novas buscas cegas por peso e pico.

Créditos: o corolário de produto módulo uma forma linear foi proposto por Opus; esta nota confere sua dedução e explicita seu caráter condicional. A base produto e seus certificados são os já atribuídos a Opus/Codex no pacote congelado. Nenhuma prioridade bibliográfica é reivindicada.
