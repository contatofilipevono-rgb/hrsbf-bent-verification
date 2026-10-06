# Auditoria adversarial e fechamento do caso cúbico homogêneo

Data: 2026-10-06.

## Status

**Resultado candidato forte.** A cadeia abaixo foi reconstruída a partir das definições e dos lemas algébricos, com tentativa explícita de quebrar os pontos frágeis. Não alegar prioridade global antes de auditoria externa e revisão bibliográfica completa.

## Teorema candidato

Não existe função booleana bent, homogênea de grau 3 e rotation-symmetric em qualquer número par de variáveis.

## Cadeia independente

Escreva n=2^s m, m ímpar, s>=1, e t=2^s. Seja sigma a rotação e T=sigma^t, de ordem m. O fixed space U=Fix(T) é identificado com F_2^t por repetição do bloco m vezes.

### A. Restrição preserva bentness para grau <=3

Se f é bent, RS e deg(f)<=3, então para a in U\{0}, D_a f é quadrática, balanceada e T-invariante. O lema de redução de ordem ímpar para quadráticas mostra que D_a(f|_U) é balanceada. Como dim U=t é par, a caracterização por derivadas implica que f|_U é bent.

Este passo usa m ímpar de modo essencial.

### B. Forma da restrição de uma cúbica homogênea

Cada órbita cúbica em n variáveis, ao ser restringida ao fixed space, reduz a uma combinação RS em t variáveis de graus 1,2,3. O argumento de multiplicidade mostra que somente:
- órbitas cúbicas de comprimento completo t;
- órbitas quadráticas de comprimento completo t;
- a forma linear total
podem sobreviver.

A órbita quadrática antipodal
Q_A(y)=sum_{i=0}^{t/2-1} y_i y_{i+t/2}
tem comprimento t/2, portanto aparece com multiplicidade t/(t/2)=2 e cancela em F_2. Assim f|_U NÃO contém Q_A.

Esse é o elo decisivo.

### C. Regra antipodal em potência de dois

A prova separada REGRA_ANTIPODAL_PROVA_AUDITADA_2026_10_06.md estabelece:

Se t=2^s, s>=2, g é RS, bent e deg(g)<=3, então g deve conter Q_A.

Aplicada a g=f|_U, contradiz B.

### D. Caso t=2

Quando s=1, a redução termina em duas variáveis. A restrição de uma cúbica homogênea pertence ao pequeno espaço já enumerado e não é bent. Esse caso também pode ser escrito diretamente.

Logo nenhum n par admite HRSBF cúbica bent.

## Tentativas de quebra da prova

1. **Normalidade:** não se usa 'constante num flat máximo => não bent', que é falso. A prova antipodal usa Parseval para obter balanceamento das outras fibras.
2. **Termos quadráticos criados pela restrição:** são permitidos; exatamente por isso a regra antipodal é aplicada a grau <=3, não a funções homogêneas. O termo antipodal, porém, é excluído por multiplicidade par.
3. **Cúbicas RS bent conhecidas:** existem construções não homogêneas. Isso não contradiz o teorema; ao contrário, impede remover a hipótese de homogeneidade. A regra antipodal prevê que tais construções devem conter Q_A.
4. **Dimensão da restrição:** t=2^s é par para todo n par e a proposição de restrição é aplicável.
5. **Caso m=1:** T=I e a redução é trivial; a regra antipodal resolve diretamente t=n quando n é potência de dois.
6. **Lema quadrático:** a prova usa a estrutura F_2[X]/((X+1)^t), válida precisamente para t potência de dois.

## Consequência editorial

O teorema antigo '32 não divide n' deve deixar de ser o teorema principal se esta cadeia passar auditoria externa. A prova por código divisível continua útil como resultado independente e controle computacional.

Arquitetura sugerida:
1. lema de redução de ordem ímpar;
2. lema de órbitas da restrição e ausência de Q_A;
3. teorema antipodal em potência de dois;
4. teorema global cúbico homogêneo;
5. certificados n=16/n=32 como auditorias independentes e material suplementar.

## Limite

Isto resolve apenas o grau homogêneo 3. Não resolve a conjectura Stănică--Maitra para graus homogêneos 4,5,... .

## Prioridade

Fontes consultadas em 2026 ainda descrevem a conjectura geral de grau >2 como parcialmente resolvida. Cusick--Sanger cobrem n=2p e condições short-cycle relacionadas; Sun--Shi--Liu--Fu (2026) anunciam novos resultados parciais. Não afirmar 'primeira prova' ou prioridade global sem busca mais extensa e parecer independente.
