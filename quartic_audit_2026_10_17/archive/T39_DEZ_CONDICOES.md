# T39: dez condições e restrições escolhidas por caráter

## Resultado demonstrado

As nove condições anteriores, junto da condição adicional no suporte 0x33ff, excluem pelo menos **99,81475664013322%** do espaço original como candidato a bent. A fração que pode passar é no máximo

`34171368508165259 / 18446744073709551616`.

A mesma prova fornece um limite inferior positivo para a passagem:

`19871827020280693 / 18446744073709551616`.

Portanto a exclusão real por esses dez testes está entre **99,81475664013322% e 99,89227460986677%**. Eles ainda não conseguem atingir 99,9% sozinhos. Os candidatos aprovados nos filtros não são afirmados bent.

## Simplificação e combinação

A condição de T37 tem 4.748 monômios após as três leis lineares. Substituir as reconstruções da forma normal transforma-a em dois modelos: 16.009 termos de grau até quatro no ramo c99=0 e 14.547 termos de grau até três no ramo c99=1. O verificador T38 reconstrói essas substituições e confere 64 avaliações diretas da ANF original.

O lema vetorial não exige usar a mesma restrição S para todos os caracteres. Para cada combinação não nula P_λ, é possível escolher um conjunto S_λ que deixe uma forma quadrática de posto fixo r_λ. Se Z_λ é a densidade de anulação de todas as derivadas radicais, continua valendo

`Pr(P₁=…=P_m=0) ≤ 2^(−m) [1+Σ_(λ≠0) 2^(−r_λ/2) Z_λ]`.

A prova trata separadamente a expectativa de cada caráter; por isso restrições diferentes são permitidas. Essa liberdade evita enfraquecer os nove filtros antigos para acomodar o décimo.

## Equações menores para calcular as densidades

As derivadas radicais frequentemente são linearmente dependentes como polinômios. Reduzir essas equações por eliminação sobre F₂ preserva exatamente seu conjunto comum de zeros. Depois de fixar no máximo três coordenadas externas, a mesma redução é aplicada novamente. Isso reduz a quantidade de somas quadráticas necessárias, sem assumir independência lógica das equações.

As duas estimativas condicionais finais são

`22789206520826515/288230376151711744`, no ramo c99=0,

`1422770248417343/18014398509481984`, no ramo c99=1.

Ponderadas pelas medidas originais 1/64 e 1/128, fornecem o resultado global.

## Conferência independente

`VERIFICAR_MODELOS_T38.py` verifica a substituição completa do novo filtro. `VERIFICAR_RESTRICOES_T39.py` confere cada restrição, posto, direção radical e a igualdade dos espaços de equações reduzidas. Verifica **4.880 somas quadráticas por base simplética**, independentemente da eliminação de pares usada para gerar os dados. Ambos usam Python padrão.

A escolha das restrições foi uma busca entre candidatos válidos; não se afirma que o limite seja ótimo. O resultado não modifica automaticamente o domínio GPU T33. Novidade bibliográfica e inexistência global permanecem não estabelecidas.
