# Comparativo com a referência verificada

Referência editorial: `14646e8`, manuscrito v1.3 em `publications/v1-lean-certified-2026-10-15/paper/antipodal_necessity_v1_3.tex`, 10 páginas segundo o relatório preservado. Referência formal: `6dd183685ef8a5b033c1bcf8733496d57b853cc7`. A árvore formal é idêntica nas duas referências e não foi alterada nesta tarefa. O preprint Figshare v1.0 permanece intacto, assim como v1.2 e v1.3.

| Alteração | Classe | Justificativa | Limite |
|---|---|---|---|
| Substituir fatoração no núcleo da média por média no radical | A | rad(B restrita)=rad(B)∩Fix(T), e Q(Pr)=Q(r) no radical; Gauss dá equivalência de equilíbrio | Outra demonstração humana do mesmo enunciado; sem nova compilação dessa rota em Lean |
| Inferir fibra afim diretamente de polar zero | A | F+F(0) é aditiva, logo F2-linear | Não dispensa provar polar zero |
| Reunir equilíbrio e constância da fibra numa única proposição | A | São expostos todos os passos de Parseval, terceira diferença e covariância | Hipótese diagonal constante preservada |
| Usar W_g(b,b) diretamente na soma das fibras | A | b·(u+v) é o caráter que aparece após z=u+v | Normalização de Parseval permanece explícita |
| Deduzir caso homogêneo como corolário do teorema mais forte | A | Homogeneidade zera o coeficiente quadrático | Não enfraquece o teorema universal |
| Trocar folding geral por cancelamento e repetição | A, já presente em v1.3 | A mudança não é novidade desta edição; acompanha a rota global certificada | Não reivindicar nova formalização de folding |
| Mover inventário de axiomas, CI e expansão de identidades | Editorial | Artigo mantém toda a prova; apêndice detalha os passos e os relatórios registram evidência | Nenhuma lacuna matemática foi escondida |
| Eliminar retrospectiva longa de versões e testes finitos do corpo | Editorial | Não são premissas da demonstração universal | Histórico continua preservado no repositório |
| Retirar observação de sharpness da rigidez e catálogo de construções | Editorial | Consequências laterais não necessárias ao resultado central | Não são retratadas como refutadas ou inéditas |

## Ideias examinadas que não substituem a prova

- **B:** formalizar a nova prova por média no radical como derivação Lean independente. Faltaria implementar e compilar essa derivação; isso não é uma lacuna da prova matemática nem do teorema Lean existente.
- **C:** descrever a contradição apenas como “simetria impede desacoplamento”. Explicação intuitiva insuficiente; não adotada.
- **D:** assumir que todas as fibras de toda bent são equilibradas. Falso sem a hipótese diagonal constante; contraexemplo no apêndice.
- **D:** aplicar o lema quadrático diretamente a derivadas cúbicas em grau 4. Não justificado; não adotado.
- **D:** tratar 12.4 ou o lema parcial de 16.4 como uma extensão da V1 universal. Não ocorre nesta edição.

O objetivo de 6–12 páginas era indicativo. A entrega tem cinco páginas com a prova completa, mais três de apêndice. Não foi inserido espaçamento artificial para atingir seis páginas. A redução editorial por si só não constitui novo teorema ou prioridade matemática.
