# Parecer interno simulado

Este parecer é uma segunda leitura crítica feita pelo próprio assistente, não uma arbitragem independente nem uma revisão por outro agente. Não deve ser apresentado como endosso externo.

## Primeira leitura: somente o artigo

**Compreensão do resultado.** O teorema central é mais forte que a inexistência cúbica homogênea: exige um coeficiente quadrático em toda RS bent de grau≤3. A distinção entre grau e homogeneidade está explícita. Não há argumento estatístico ou dimensão omitida.

**Cadeia da prova.** É possível acompanhar o percurso sem abrir Lean: Gauss → média no radical → restrição bent → rigidez quadrática → fibra equilibrada e constante → cancelamento de suportes e contradição global. As igualdades menos imediatas têm demonstrações no corpo, inclusive a identificação do radical restrito e a comparação trilinear.

**Objeções verificadas.**

1. O radical da restrição poderia ser maior que a interseção do radical? A igualdade B(u,Px)=B(u,x), com u fixo, resolve exatamente essa questão.
2. A média poderia apagar a testemunha de desequilíbrio? Sobre o radical Q é linear e Q(Pr)=Q(r); a testemunha é preservada.
3. O lema de fibras estaria sendo usado sem diagonal constante? Não: a hipótese aparece antes de Parseval e na Proposição 6.
4. Seria preciso provar primeiro que F é quadrática? Não após B_F=0: F+F(0) é aditiva, o que já basta.
5. Há perda de n=2? A prova da covariância vale para h=1; o corolário de grau exatamente três é então vazio, mas o teorema de necessidade não é.
6. A repetição depende de uma igualdade não demonstrada de coeficientes? Não. Transporta-se a diagonal constante, por divisibilidade do deslocamento da meia-volta por h.
7. A ausência da órbita antipodal é um somatório de coeficientes? Não. O artigo usa um coeficiente representativo, com os demais iguais por rotação.

**Avaliação.** A demonstração matemática é completa nesta leitura interna. A densidade de alguns parágrafos exige um leitor com familiaridade com formas quadráticas e Fourier finita; três páginas adicionais explicam identidades e casos-limite. Cinco páginas são adequadas, sem comprimir símbolos para cumprir meta artificial.

## Segunda leitura: suplemento e evidência

As fontes formais estão idênticas à referência certificada. As definições públicas descrevem ANF canônica, simetria de um passo e Walsh efetivo; o enunciado não tem premissas artificiais escondidas. Os dois runs históricos e os commits foram reconferidos, enquanto os logs locais e a comparação semântica sustentam a correspondência detalhada. A presente edição não executou novo build Lean e não afirma ter formalizado separadamente a nova demonstração do Lema 3.

Os controles finitos foram deliberadamente pequenos e exatos. Eles poderiam detectar erros de sinal, normalização e casos degenerados, mas não foram usados como prova dos quantificadores universais.

## Riscos residuais e recomendação

- A prioridade bibliográfica absoluta permanece não estabelecida. A introdução limita a comparação ao escopo dos antecedentes consultados e não declara busca exaustiva de prioridade.
- Recomenda-se leitura por um especialista externo antes de submissão. Este parecer é autocontrole, não substituto dessa leitura.
- Uma futura formalização independente do argumento de média no radical reforçaria a rastreabilidade da nova exposição, sem ser necessária para que a prova humana seja válida.
- Não integrar resultados quárticos nem alegações de V2/V3-C na afirmação global deste artigo.

Recomendação interna: versão apta a avaliação matemática humana, preservando as ressalvas de certificação e de prioridade. Nenhuma submissão ou publicação externa foi realizada.
