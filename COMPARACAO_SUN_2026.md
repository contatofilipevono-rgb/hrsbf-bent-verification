# Comparação com Sun–Shi–Liu–Fu (2026)

Data: 4 de outubro de 2026. Texto integral fornecido pelo usuário e lido nesta revisão (22 páginas). Fonte: DOI [10.1007/s10623-026-01848-4](https://doi.org/10.1007/s10623-026-01848-4).
SHA-256 do PDF consultado: f9c85a57ae37999105fe32855cc5225409db9dd0b3dc8ffd64abf4354aa89e50.

## Conclusão

Há sobreposição real, principalmente em n=2m. O artigo não enuncia o resultado uniforme do projeto para todos os n=2m,4m,8m,16m, m ímpar e suportes cúbicos arbitrários. O resultado do projeto tem alcance declarado diferente; isso não é, por si só, prova de originalidade em toda a literatura, nem uma certificação de que nenhuma combinação dos critérios publicados possa reproduzir casos adicionais.

“Composite odd factors” não identifica novidade: o Corolário 2 já inclui todos os n=2p^a para p primo ímpar e a≥1. O ponto a comparar é a retirada das restrições de fatorização e suporte, e a redução uniforme até t=16.

## Notação e hipóteses de fatorização

O artigo escreve n=2^{n_0} p_1^{n_1}...p_t^{n_t}. Nos Teoremas 1–2, exige:
- p_1 > 2^{2^{n_0}};
- p_i > 2^{2^{n_0} p_1^{n_1}...p_{i-1}^{n_{i-1}}}, i≥2.

No Corolário 1 e no Corolário 2, n_0=1 e não há restrição adicional sobre p_1; apenas:
p_i > 2^{2 p_1^{n_1}...p_{i-1}^{n_{i-1}}}, i≥2.

Os expoentes foram conferidos visualmente no PDF (pp. 5, 10–11 e 18). Não são desigualdades lineares nem apenas “primos distintos”.

## Comparação por resultado

| Resultado publicado | Hipóteses e conclusão | Relação com o projeto |
|---|---|---|
| Teorema 1, p. 5 | RS bent, sem exigir grau cúbico, sob as restrições de fatorização acima; impõe valores em vetores de períodos 1 e 4. | Condições necessárias mais gerais quanto ao grau, mas condicionais quanto à fatorização. Não é a redução quadrática por ordem ímpar usada pelo projeto. |
| Teorema 2, p. 10 | Função homogênea e mesma fatorização; usa N_1 (órbitas de comprimento ímpar), N_2 (comprimento 4 mod 8 e três resíduos mod 4) e N_3 (comprimento 2 mod 4 e dois resíduos mod 4). Impõe condições de paridade conforme n_0. | Pode excluir funções nos mesmos domínios; não enuncia exclusão universal de todos os suportes cúbicos em v_2(n)=2,3,4. |
| Corolário 1, p. 11; Corolário 2, p. 18 | n=2m, fatoração de m com separação exponencial dos primos. O primeiro impõe grau homogêneo par para bentness; o segundo exclui cúbicas homogêneas. | Sobreposição direta. Para um só primo distinto, a restrição é vazia: inclui n=2p^a. O projeto inclui também m sem essa separação. |
| Teorema 3, pp. 13–14 | Escolhe subconjuntos R_i dos suportes S_i e define Δ_R e Γ_R. Quatro condições de distância produzem um conjunto grande que não contém suporte de nenhum monômio e excluem bentness. | Resultado condicionado aos suportes; pode tratar dimensões fora do alcance do projeto. Não é uma classificação uniforme apenas por v_2(n). |
| Teorema 4, pp. 16–17 | Item 1: cada suporte tem ao menos dois índices pares e dois ímpares. Item 2: C_f≤2 e grau≥floor(n/4)+2. | Item 1 é impossível para suporte de tamanho três. Para grau três, item 2 não se aplica quando n≥8. Não fornece a exclusão universal em n=16 ou n=32. |
| Teorema 5, p. 18 | Número k de termos SANF par e v_2(r_i),v_2(s_i)≥v_2(n) para todos os pares; exclui bentness. | Exclusão de suportes especiais; não abrange todas as cúbicas nas dimensões do projeto. Em n potência de dois, não há pares distintos 0<r_i<s_i<n ambos divisíveis por n. |
| Teorema 6, p. 18 | Para cada conjunto fixo P de pares de índices, existe e_0(P) tal que a família correspondente não é bent nas dimensões múltiplas de 2^{e_0(P)}. | Resultado assintótico por família fixa. Não fixa um e_0 uniforme para todos os suportes; não resolve todas as funções em n=32. Não se deve inverter os quantificadores. |

No Teorema 2, para n_0=1 exclui-se N_1 par; para n_0=2, N_1 ímpar ou N_2+N_3 par; para n_0≥3, N_1 ímpar ou N_2+N_3 ímpar.

O Teorema 3 é existencial na escolha de R_i. Não foi feita uma enumeração de todas essas escolhas para cada função do projeto; portanto o relatório não afirma que cada certificado parcial em n=32 seja inédito ou não possa ser recuperado por aquele critério.

## Exemplos de sobreposição e de diferença de hipóteses

- n=18=2·3² e n=50=2·5²: já pertencem ao Corolário 2, apesar de m ser composto.
- n=402=2·3·67: também pertence, pois 67>2^{2·3}=64.
- n=30=2·3·5: não satisfaz a hipótese do Corolário 2, pois 5≤64. O resultado do projeto inclui essa dimensão sem restrição de suporte. Isso não prova que nenhum outro resultado anterior trate n=30.
- n=16: o projeto exclui todo o espaço homogêneo cúbico por redução e divisibilidade; o artigo não enuncia um teorema dimensional que exclua todos esses suportes em n=16.
- n=32: o projeto continua parcial. O Teorema 6 não altera isso porque e_0 depende do suporte e não fornece cobertura uniforme de todas as 155 órbitas na dimensão fixa 32.

## Controle da identidade de derivada na seção 3.3

A Eq. (21), p. 17, é impressa como soma de três famílias quadráticas, sem o termo linear que surge ao derivar uma cúbica. Para a órbita completa f=Σ_i x_i x_{i+1}x_{i+2} em n=8 ou n=16, a expansão direta dá:

D_{1^n}f = Q_2 + L, onde Q_2=Σ_i x_i x_{i+2} e L=Σ_i x_i.

Os dois Q_1 oriundos dos pares consecutivos cancelam; o termo constante cancela porque n é par; cada variável ocorre em três monômios, deixando L. Em x=e_0, a derivada original vale 1 e a parte quadrática isolada vale 0. Portanto, com a definição de derivada do artigo, a Eq. (21) como impressa omite um termo nesse exemplo.

O script independente [verificar_derivada_sun.py](auditoria_2026_10_04/verificar_derivada_sun.py) conferiu todas as entradas:
- n=8: 128 discrepâncias na identidade sem L, zero na identidade corrigida;
- n=16: 32768 discrepâncias sem L, zero na identidade corrigida.

Isso identifica uma questão na identidade intermediária. Não foi demonstrado aqui que a conclusão do Teorema 6 seja falsa: ela pode admitir uma prova corrigida que trate os termos lineares. O Teorema 5 assume k par, contexto em que essa contribuição linear pode cancelar. Para termos de órbita curta ou pares antipodais, também é necessário respeitar a convenção de soma de monômios distintos. Não é apropriado transferir a Eq. (21) diretamente para o verificador do projeto.

## Redação científica recomendada

O manuscrito deve reconhecer explicitamente o Corolário 2 e o Teorema 6, destacar a diferença de hipóteses e quantificadores e apresentar o método de redução por ordem ímpar com a obstrução finita reproduzível. Não usar “primeiro”, “inédito”, “resolve todo n=32”, “fatores compostos nunca tratados” ou “estritamente superior a todos os resultados anteriores”.

A pendência de obter o PDF está encerrada. A leitura comparativa dos enunciados deste artigo está concluída. A avaliação de originalidade em toda a literatura, a eventual recuperação dos certificados por outros critérios e a questão da Eq. (21) permanecem distintas de uma prova de prioridade ou de uma refutação global do artigo.
