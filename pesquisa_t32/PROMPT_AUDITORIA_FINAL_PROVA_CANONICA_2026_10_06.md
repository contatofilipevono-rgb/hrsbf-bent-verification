# Prompt — auditoria adversarial final da prova canônica

Audite **somente** a prova matemática contida em:

`pesquisa_t32/PROVA_CANONICA_TEOREMA_CUBICO_GLOBAL_2026_10_06.md`

do repositório:

https://github.com/contatofilipevono-rgb/hrsbf-bent-verification

Branch obrigatória:

`colab-a100-2026-10-06`

Registre o SHA exato auditado. Não modifique o GitHub.

## Objetivo

Tente refutar, e não confirmar, o teorema:

> Para todo n par, não existe função booleana bent, rotation-symmetric e homogênea de grau 3 em n variáveis.

Esta auditoria é deliberadamente estreita. Não audite o artigo inteiro, certificados antigos, buscas GPU ou provas anteriores. Trate a prova canônica como uma submissão matemática autônoma.

## Ataques obrigatórios

### A. Lema de ordem ímpar

Reconstrua rigorosamente:
- P=I+T+...+T^{m-1};
- V=Fix(T) ⊕ ker P;
- ortogonalidade para a polar;
- fatoração da soma de caracteres;
- argumento que q se anula no radical de B|_{ker P};
- conclusão S_K(q) != 0.

Tente encontrar um contraexemplo ao lema para T de ordem ímpar, inclusive ordem composta. Verifique especialmente se a igualdade
q(Pr)=Σ q(T^j r)
é legítima sob a hipótese usada.

### B. Folding

Não aceite a frase "2m" sem reconstrução.

Classifique todos os possíveis estabilizadores de um suporte de tamanho 3 sob C_n. Prove que são apenas 1 e 3. Depois derive a restrição de uma órbita para t=2^s e mostre exatamente por que Q_A não pode sobreviver.

Ataque separadamente:
- órbitas full-length;
- órbitas curtas de estabilizador 3;
- t=2;
- colisões de dois resíduos;
- diferença antipodal t/2.

Se possível, faça testes próprios para vários m ímpares, incluindo m=9 ou 15.

### C. Regra Antipodal para k>=1

Verifique a extensão até N=2, não apenas N>=4.

Audite:
1. diagonal g(u,u);
2. transformação (u,z)->(u,u+z);
3. normalização de Parseval e fatores 2^h;
4. lema quadrático RS no módulo F2[X]/((X+1)^N);
5. uso de "submódulo próprio não contém unidade";
6. identidade da terceira diferença;
7. invariância de T pela meia-rotação;
8. rotação torcida, com índices explícitos;
9. conclusão de que uma afim invariante é constante.

Procure especialmente erros de orientação R versus R^{-1}; aceite-os apenas se forem realmente inócuos.

### D. Dependências escondidas

Determine se algum passo usa sem declarar:
- homogeneidade depois do folding;
- n>=4;
- m primo;
- semissimplicidade além de ordem ímpar;
- enumeração computacional;
- hipótese de normalidade falsa para funções bent;
- existência ou não de termos lineares/quadráticos induzidos.

### E. Testes independentes

Implemente código próprio, sem importar módulos científicos do repositório, para procurar contraexemplos pequenos aos três lemas. Inclua controles positivos de funções cúbicas RS bent não homogêneas.

## Saída

Use exatamente um status:

PASS
PASS WITH CAVEATS
FAIL

Se FAIL, dê a primeira implicação inválida e o menor contraexemplo possível.

Se PASS/PASS WITH CAVEATS, apresente uma reconstrução compacta suficiente para demonstrar que você realmente conferiu os três lemas, e diga explicitamente se resta algum n par descoberto.

Não faça alegação de prioridade bibliográfica. Esta auditoria é apenas de correção matemática.
