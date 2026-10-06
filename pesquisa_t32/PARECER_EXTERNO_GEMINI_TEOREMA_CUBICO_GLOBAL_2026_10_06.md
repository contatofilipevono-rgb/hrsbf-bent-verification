# Parecer externo Gemini — teorema cúbico global

Data: 2026-10-06.

## Veredito recebido

**PASS WITH CAVEATS.**

O auditor reconstruiu independentemente a cadeia:
1. redução por automorfismo de ordem ímpar;
2. folding das órbitas cúbicas;
3. ausência da órbita quadrática antipodal na restrição;
4. Regra Antipodal para dimensão potência de dois >=4;
5. contradição entre balanceamento e constância da fibra complementar.

O auditor concluiu que a cadeia demonstra a inexistência de HRSBF cúbica bent para todo número par de variáveis.

## Caveat matemático incorporado: s=1

Escreva n=2^s m, m ímpar.

Quando s>=2, aplica-se a Regra Antipodal à restrição bent em t=2^s variáveis.

Quando s=1, t=2. O folding de uma cúbica homogênea RS pertence ao espaço gerado por órbitas cúbicas/quadráticas full-length e pela forma linear. Em duas variáveis não existe órbita cúbica multilinear, e a única órbita quadrática é a antipodal, de comprimento 1, excluída pelo argumento de multiplicidade par. Portanto a restrição tem grau <=1. Nenhuma função afim em duas variáveis é bent. Contradição.

Assim o caso s=1 é fechado separadamente e não depende da Regra Antipodal formulada para k>=2.

## Caveat m=1

Quando m=1, o fixed space é o espaço inteiro e a redução é trivial. Para s>=2, uma HRSBF cúbica bent em n=2^s seria uma RS bent de grau <=3 sem qualquer termo quadrático antipodal, contradizendo diretamente a Regra Antipodal.

## Controle positivo

A conclusão NÃO é 'não existem funções cúbicas RS bent'. Funções cúbicas RS bent não homogêneas são compatíveis com a prova; em potência de dois, a Regra Antipodal exige que contenham Q_A.

## Ressalva bibliográfica

O relatório externo contém afirmações sobre a cobertura exata de Meng--Chen--Fu, Zhang--Gao, Cusick--Sanger e Sun--Shi--Liu--Fu que não devem ser importadas como fatos sem conferência primária. A auditoria matemática e a auditoria de prioridade são questões separadas.

Formulação segura atual:
- a cadeia matemática recebeu PASS WITH CAVEATS de uma auditoria externa;
- os caveats matemáticos s=1 e m=1 estão agora explicitamente fechados;
- prioridade/global novelty permanece pendente de revisão bibliográfica primária.

## Teorema candidato após auditoria

Para todo n par, não existe função booleana rotation-symmetric, bent e homogênea de grau 3.

Não promover ainda a 'primeira prova' ou 'resolução inédita' até concluir a revisão de prioridade.
