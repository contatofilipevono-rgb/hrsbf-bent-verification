# Rigidez modular em 20 variáveis, módulo 17

Investigação de 17 de novembro de 2026. O problema é decidir se $W_f(b)\equiv\pm1024\bmod17$ em toda frequência implica bentness quando $f:\mathbb F_2^{20}\to\mathbb F_2$ tem grau no máximo quatro. Nenhum dos resultados abaixo exige homogeneidade ou simetria de rotação.

| Região | Resultado |
| --- | --- |
| Ímpar, $Q=1$ | Excluída. A paridade de uma função inteira não negativa pertence a RM(10,20), e todos os perfis de massa são eliminados. |
| Ímpar, $Q$ de posto polar pelo menos 10 | Excluída. A fatoração $D=QR$ e as correlações exatas de Walsh fecham os postos 10 a 20, incluindo o peso $127/256$. |
| Par, $X\equiv0\bmod4$ globalmente | Bentness por Parseval e módulo mínimo. |
| Par, $X\equiv2\bmod4$ globalmente, $w(D)\ge1/8$ | Os postos até 16 são excluídos. Nos postos 18 e 20 fica excluída a faixa $1/8\le w(D)<47/256$. No posto 18 também se exclui $w(D)>29/144$. |
| Par, segundo bit afim não constante | Na fatia $X\equiv2\bmod4$, com $w(D)\ge1/8$ medido nessa fatia, restam somente os postos polares 8, 16 e 18. |

O enunciado geral permanece aberto. As provas deste pacote não cobrem todo o ramo ímpar de posto baixo, todo o ramo par com segundo bit não constante ou todos os resíduos de alto posto do ramo par. O caderno registra exclusões prévias em regiões mais baixas, com níveis distintos de revisão.

## Reprodução

Execute com Python 3, sem dependências externas.

    python3 verifica_p17_impar_postos_altos.py
    python3 verify_q1_arithmetic.py
    python3 verify_even.py

As verificações são de aritmética exata, contagem de perfis e, quando indicada, álgebra linear finita. As notas demonstram por que esses cálculos cobrem as regiões indicadas. A coordenação desenvolveu a prova dos postos altos ímpares. As provas de $Q=1$ e do ramo par foram desenvolvidas em verificações paralelas e conferidas na consolidação. Os resultados aguardam revisão humana. Origem da retomada e estado anterior no [Caderno de ferramentas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/05facf967b85ffcc6c0e08c9175c796217850a02/research_updates/2026_11_07_ferramentas/CADERNO_TECNICAS_BENT.md).
