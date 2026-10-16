# Grau 4: testes reais na A100, 16/10/2026

Notebook privado criado e executado:
https://colab.research.google.com/drive/17kFfk93CpP_lFc0TKgDOWp3sOhXdey3a

Hardware observado: NVIDIA A100-SXM4-40GB. O notebook e os resultados
numéricos distinguem testes na GPU, oráculo CPU e certificados finitos.
Não houve publicação externa nem modificação dos projetos V1/V2/V3-C.

## Resultados efetivamente obtidos

1. FWHT CUDA inteira validada em comprimentos 64, 256, 1024 e 4096,
   incluindo inversão, Parseval e comparação exata com CPU int64.
   A avaliação de coeficientes usa palavras uint64 e paridade por popcount;
   foi testada com 245 coeficientes, inclusive bits acima da posição 128.
   O controle negativo sem fase falhou como esperado.
2. No benchmark de 32.768 linhas de comprimento 1.024, a mediana GPU
   incluindo transferências foi 0,08512 s, contra 2,87323 s da referência
   CPU: cerca de 33,76 vezes nesse kernel e nessa carga. Isso não mede
   aceleração de toda a demonstração ou de qualquer problema arbitrário.
3. A cascata original de n=12 foi reexecutada no CPU do Colab. O único
   acréscimo foi callback de exportação de coeficientes, sem trocar filtros.
   Todos os contadores coincidiram; tempo observado 323,94 s.
4. A GPU avaliou diretamente as 94.544 extensões do posto 41, sem transporte
   entre fibras, incluindo o Walsh completo de 4.096 frequências de cada
   função. Zero bent. Contagens de energia reproduzidas:
   32.176 em b=0; 39.520 em b=63; 5.552 em ambos; zero em todos os b.
5. Uma cobertura gulosa usou b em {5,23,1,0} para rejeitar essas 94.544
   extensões por energia. Coberturas incrementais: 72.496, 17.312, 4.416,
   320. Não foi provada minimalidade, e o prefixo da cascata continua
   necessário para a prova original sobre 2^43.

## Avanços finitos em n=20

As restrições g0 e gJ são conjuntamente uma imagem de posto 18, com
262.144 classes equiprováveis no espaço original de dimensão 245.
A energia parcial e Poisson na linha span(J) deixam 65.536 classes.
Portanto, os filtros necessários excluem 75% do espaço original.
Os sobreviventes não foram declarados bent; n=20 continua não fechado.

Seja c_d o coeficiente da órbita com suporte (0,d,10,10+d), d=1,...,5.
Índices canônicos do pacote: 100,186,228,242,244, respectivamente.
O teste por setores e o conjunto completo das 8.192 imagens gJ deram:

    f homogênea quártica RS bent em n=20 => c5=0 e c2 XOR c4=1.

Cada um dos oito setores permitidos conserva todas as 8.192 imagens
complementares nesse filtro local; os outros 24 setores não conservam
nenhuma. A ANF do indicador de setores não vazios é

    (c2 XOR c4) * (1 XOR c5).

Essa é uma condição necessária finita, com certificado, não a conjectura
quártica global. Sua prioridade bibliográfica não foi avaliada.

### Explicação matemática da lei dos setores

Se f é bent, defina seu dual por W_f(a)=2^10*(-1)^f*(a).
O dual de uma função RS é RS. Inversão parcial de Fourier dá

    W_{g0}(J) = A_{g*_J}(0),

onde g*_J(u)=f*(u,u+J). Na fibra complementar do dual, o shift negacíclico
em dez bits tem 51 órbitas de tamanho 20 e uma órbita de tamanho 4.
Logo, para k inteiro e delta em {0,1},

    A_{g*_J}(0) = 1024 - 40k - 8delta,
    W_{g0}(J)^2 = 16 (mod 80).

A restrição g0 depende apenas dos cinco coeficientes c_d e é a quadrática
sum_d c_d Q_d em dez bits. A avaliação exata das 32 combinações mostra:

- se c5=1, o quadrado é 64 mod 80;
- se c5=0 e c2=c4, o quadrado é zero mod 80;
- se c5=0 e c2!=c4, o quadrado é 16 mod 80.

Essas verificações pequenas, mais a dualidade, justificam a condição em
todo o espaço 2^245, sem alegar uma busca completa de bentness nesse espaço.
Conferir a tabela independente e a reconstrução orbital antes de citar
como teorema em um artigo. Novidade não certificada.

### Divisibilidade complementar e limites das extrapolações

Foram enumeradas integralmente as 8.192 imagens de gJ, em todas as
1.024 frequências. CPU e GPU coincidiram nos histogramas.

- 32 divide W_gJ(b) para todo b e toda função do espaço em n=20.
- O menor |A_J| na imagem é 64 e nenhum A_J é zero.
- 64 NÃO divide sempre W_gJ(b): há testemunha com A_J=96.

Além da enumeração, há certificado de divisibilidade por inclusão-exclusão:
somar às 13 linhas da base da imagem as dez formas lineares. Para cada
produto de s linhas, s=1,2,3,4, verificar peso divisível por 2^(5-s).
As 10.902 interseções passam. Na expansão do peso do XOR, produtos maiores
já têm coeficiente múltiplo de 16. Logo, todo gJ+<b,u> tem peso múltiplo de
16, implicando 32|W. Isso evita usar linearidade indevida de Walsh.

A conjectura de divisor 64 é refutada por uma palavra da própria base
de peso 464: W(0)=1024-2*464=96. O certificado inclui os nove suportes
originais do polinômio que realiza essa testemunha.

Em n=16, A_J pode ser zero (102 das 256 imagens complementares têm A_J=0).
Assim, não extrapolar o não anulamento de n=12,20 para toda dimensão par.

## Dados adicionais de n=16

O mapa das quatro fibras de período dois tem posto 21 e 2.097.152 imagens.
Energia parcial deixa 1.983.244; Poisson na linha J deixa 962.560;
a interseção deixa 942.860. A proporção de classes eliminadas aplica-se
às pré-imagens equiprováveis, mas não fecha n=16.

## Próxima missão para Luna

Primeiro preservar este notebook, código, saídas e certificados.
O usuário quer testes reais no Colab, não apenas um roteiro para terceiros.
A conta já foi conectada de forma segura. Nunca solicitar senha no chat.

Prioridade matemática: atacar a possível generalização das duas condições
de n=20 para n=4p, p primo >=5. Tratar como HIPÓTESE até completar a prova
e a comparação bibliográfica, não como descoberta já estabelecida.

Pista para a prova: se c_p=1, o símbolo circulante do polar de g0 não se
anula em x=1. O grau do gcd desse símbolo com (x^p-1)^2 controla o posto
e, por reciprocidade das raízes, pode forçar um Walsh não nulo congruente
a ±2 modulo p. A dualidade complementar exige ±4 modulo p: contradição
para p>3, se todos os passos forem demonstrados. Com c_p=0, o vetor
alternado está no radical, e seu valor pode forçar
XOR_{d par,1<=d<p} c_d=1. Verificar cuidadosamente os fatores recíprocos,
multiplicidades, parte afim da quadrática e a exceção p=3.

Não basta testar esse padrão em primos; produzir a prova ou um contraexemplo.
Antes de alegar novidade, comparar com Cusick–Sanger 2017 e Sun et al. 2026.

Prioridade computacional seguinte: usar a filtração de posto 18 com 75%
já eliminado antes de estender para as fibras alternadas em n=20 (posto
conjunto 32). A imagem completa tem 2^32 classes: não iniciar uma varredura
ingênua. Fazer um piloto com estados sobreviventes, medir rendimento,
introduzir novas condições necessárias e estimar duração a partir dos
dados reais da A100. Muitos créditos permitem uma etapa maior bem definida;
não dispensam a redução estrutural nem a preservação de checkpoints.

Uma segunda opção é incorporar Poisson na linha do alternado e no plano
span(J,alternado), com tabelas de sinais coerentes. Provar a necessidade
antes do uso e validar com controles bent gerais fora da classe quártica.

Não alterar ou substituir o preprint corrigido por esses resultados sem
uma revisão adversarial própria. Trabalhar em um adendo separado.
