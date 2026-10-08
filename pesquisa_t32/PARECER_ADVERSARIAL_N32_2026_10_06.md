# Revisão adversarial e comparação bibliográfica

## Parecer desta rodada

Não foi encontrada uma lacuna na prova de inexistência de funções cúbicas homogêneas simétricas por rotação bent em 32 variáveis. A prova pode ser apresentada sem enumeração de H: os certificados computacionais verificam identidades universais e servem como auditoria adicional.

Este parecer é uma **autoauditoria do assistente**, com avaliadores computacionais distintos. Não é parecer de um matemático externo, de outro modelo ou de um periódico. A originalidade ainda não foi estabelecida.

## Pontos atacados

| Ponto | Objeção considerada | Resultado |
|---|---|---|
| Radical da quadrática | Um subespaço invariante próprio poderia conter um vetor ímpar? | Não no módulo cíclico F₂[X]/((X+1)³²): tal vetor é uma unidade e gera todo o módulo por deslocamentos. |
| Valor no radical | A parte linear poderia balancear uma quadrática com polar não nula? | A identidade Q(Sy+y)=B(Sy,y)=B(r+y,y)=0 vale para a quadrática normalizada inteira, incluindo a parte linear. |
| Fibra diagonal | Homogeneidade por si só bastaria para f(u,u)=0? | Não em geral; aqui usa-se também a invariância pela troca das metades e o grau ímpar dos monômios. |
| Grau das outras fibras | Substituições poderiam deixar termos cúbicos em u? | F_z(u)=D_{e(z)}f(d(u)) porque f(d(u))=0; a derivada cúbica tem grau no máximo dois. |
| Parseval | Estava sendo usada a falsa regra de que toda restrição bent é balanceada? | Não: a fibra zero satura especificamente a identidade de Parseval, forçando as demais a serem balanceadas. |
| Polar da fibra complementar | A identidade com a derivada de todos os uns dependia do peso H? | Não: segue da terceira polarização e da simetria pela troca das metades; os 155 geradores foram também verificados. |
| Fibra afim | Uma função afim não constante poderia ser invariante pela rotação com correção? | A invariância por u↦R₁₆u+e₀ exige L=βΣuᵢ e β=0. |
| Certificado universal | A enumeração só cobria alguns H? | As identidades são lineares nos 155 coeficientes, cobrindo todo o espaço cúbico. |

A versão revisada explicita a normalização de Parseval e a queda do grau das fibras. Não foi necessário retirar uma conclusão matemática da versão anterior.

## Controles executados

- Reexecução do auditor universal: 155 geradores, 136 identidades e 1.256 coeficientes de diagonal/fibra verificados.
- Quatro adulterações deliberadas foram rejeitadas: coeficiente de fibra alterado, equação da derivada alterada, identidade removida e geradores reordenados.
- Controle positivo cúbico RS não homogêneo em oito variáveis: espectro bent de magnitude 16. Ele verifica a importância da hipótese de homogeneidade.
- Controle positivo cúbico homogêneo **sem** simetria por rotação em seis variáveis: espectro bent de magnitude 8. Ele verifica que não estamos excluindo indevidamente todas as cúbicas homogêneas.
- Compatibilidade de convenções bibliográficas: a soma cíclica completa Q=Σᵢxᵢxᵢ₊₁+Σᵢxᵢxᵢ₊₂ é balanceada em n=2 e 6. Em n=2, sua ANF reduzida tem grau um; em n=6, a dimensão não é potência de dois. Esses exemplos não contradizem o lema usado na prova. Em n=4 e 8, a mesma soma é não balanceada.

Reprodução: `python3 adversarial_review_n32.py certificado_universal_n32.json revisao_adversarial_n32.json`.

## Comparação bibliográfica examinada

Esta é uma comparação de fontes selecionadas, não uma certificação de prioridade.

1. **Stănică (2008), “On the nonexistence of bent rotation symmetric Boolean functions of degree greater than two”.** O Teorema 2 trata formas SANF específicas e condições sobre distâncias de índices. Não foi identificado nesse texto o enunciado universal sobre todas as cúbicas em 32 variáveis. Fonte primária: https://faculty.nps.edu/pstanica/research/rbent.pdf

2. **Meng, Chen e Fu (2010), “On homogeneous rotation symmetric bent functions”.** O PDF fornecido foi examinado, especialmente os Teoremas 11–13. Eles tratam uma órbita monomial, simetria total e uma condição de distância máxima, respectivamente. Não identifiquei aí o mesmo enunciado universal para todos os 155 coeficientes cúbicos em n=32. DOI: https://doi.org/10.1016/j.dam.2010.02.009

3. **Zhang e Gao (2013), “On the conjecture about the nonexistence of rotation symmetric bent functions”.** O Teorema 3.1 e a Proposição 3.2 apresentam obstruções condicionadas pela SANF. A caracterização quadrática por MDC de polinômios é antecedente relevante para a álgebra circulante, mas não é a prova da contradição entre nossas duas fibras. Fonte primária: https://arxiv.org/abs/1303.2282

4. **Chirvasitu e Cusick (2020), “Affine equivalence for quadratic rotation symmetric Boolean functions”.** Consultei a versão arXiv:1908.08448, especialmente as seções 5.1–5.3. Os resultados sobre balanceamento, Frobenius e multiplicidade da raiz 1 são antecedentes relevantes ao lema quadrático. A notação admite índices que podem reduzir a funções afins em dimensões pequenas; deve-se comparar o grau da ANF efetivamente reduzida e tratar separadamente a órbita antipodal. Não alegar que o contexto do lema é inteiramente novo. Fonte: https://arxiv.org/abs/1908.08448

5. **Chirvasitu e Cusick (2023), “Quadratic rotation symmetric Boolean functions”.** Consultei a seção 3.2 do preprint arXiv:2304.12734. Os critérios de balanceamento para somas de órbitas quadráticas reforçam a necessidade de citar a literatura quadrática e esclarecer as convenções de redução. Não foi identificado nessa fonte um teorema de inexistência universal de cúbicas homogêneas em n=32. Fonte: https://arxiv.org/abs/2304.12734

6. **Sun, Shi, Liu e Fu (2026), “On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions”.** O PDF fornecido foi examinado, especialmente a seção 3.3. O Teorema 6 fixa uma coleção de pares de índices e obtém um limiar de divisibilidade dependente dessa coleção, usando n maior que duas vezes o maior índice. Isso não é, por sua formulação, o mesmo enunciado uniforme para todos os coeficientes em n=32. A comparação da Equação (21) exige cuidado com termos lineares na derivada: nossa prova trata a quadrática inteira, inclusive seu possível colapso a uma função afim. Esta observação não é uma refutação global do artigo. DOI: https://doi.org/10.1007/s10623-026-01848-4

## Encaminhamento editorial

O resultado deve ser descrito como inexistência no caso **cúbico homogêneo em 32 variáveis**, e não como resolução de toda a conjectura de Stănică–Maitra. Não alegar novidade do lema quadrático sem verificar sua relação com os resultados acima. A combinação da polar da derivada com a fibra complementar é o ponto central a submeter à avaliação de prioridade e rigor.

O pacote para um revisor externo está em `PACOTE_REVISAO_EXTERNA_N32.md`, com prova revisada e perguntas específicas. Nenhuma mensagem foi enviada a terceiros e nenhuma revisão externa ocorreu nesta rodada.
