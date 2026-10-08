# Inexistência de funções bent cúbicas homogêneas simétricas por rotação em 32 variáveis

**Escopo matemático:** todas as combinações dos 155 geradores cúbicos RS em 32 variáveis, sem restrição no peso de H. O argumento não inclui funções cúbicas com termos quadráticos, graus maiores que três, nem o salto para 32m. A prioridade bibliográfica do argumento ainda precisa ser estabelecida antes de uma alegação de originalidade.

## 1. Lema sobre quadráticas RS

Uma quadrática RS balanceada em dimensão potência de dois tem polar nula. Eis a prova completa para n=32.

Seja S a rotação das 32 coordenadas. Para q de grau no máximo dois, ponha Q=q+q(0), B(x,y)=Q(x+y)+Q(x)+Q(y), e R=rad(B). A invariância de q implica a invariância de B e de R. Se B≠0, R é próprio. No módulo cíclico F₂[X]/((X+1)³²), qualquer vetor de peso ímpar é uma unidade e seus deslocamentos geram o módulo inteiro. Portanto todo vetor de R tem peso par e R está contido em im(S+I).

Escreva r=Sy+y para r∈R. Então Q(r)=Q(Sy)+Q(y)+B(Sy,y)=B(r+y,y)=0. Para A=Σₓ(-1)^q(x), a identidade de caracteres quadráticos dá A²=2³²Σᵣ∈R(-1)^Q(r)=2³²|R|>0. Logo q não é balanceada. Isso demonstra a contrapositiva.

## 2. Duas fibras diagonais

Suponha que f seja cúbica homogênea e RS em 32 coordenadas. Escreva d(u)=(u,u), e(z)=(0,z), com u,z∈F₂¹⁶, e F_z(u)=f(d(u)+e(z)). Cada monômio cúbico emparelha com seu deslocamento de 16 posições. Os dois monômios são distintos, pois um conjunto de três índices não pode ser fixado por essa involução sem pontos fixos. Na diagonal eles têm o mesmo valor, portanto f(d(u))=0 para todo u.

Consequentemente, F_0=0. Além disso, F_z tem grau no máximo dois: sua parte cúbica em u é a de f(d(u)), que se anula.

Se f fosse bent, a mudança linear invertível x=d(u)+e(z) preservaria bentness. Defina A_z=Σᵤ(-1)^F_z(u). Walsh sobre z e Parseval dão

Σ_z A_z² = 2³².

O termo z=0 já vale A_0²=2³². Assim, todas as fibras z≠0 têm de ser balanceadas. Essa conclusão usa explicitamente a fibra diagonal nula, não uma propriedade de restrições arbitrárias de funções bent.

## 3. A derivada de todos os uns força a outra fibra a ser constante

Seja a=d(1), o vetor de todos os uns em 32 coordenadas. A derivada D_af é quadrática RS. Toda derivada não nula de uma função bent é balanceada. Pelo lema, sua polar B_{D_af} seria nula.

Seja T a terceira diferença de f, uma forma trilinear simétrica. A polar de F_1 é

B_{F_1}(u,v)=T(d(u),d(v),e(1)).

Isso segue subtraindo a segunda diferença no ponto zero, que é nula porque f(d(u))=0. Pela invariância de T sob a troca das duas metades,

T(d(u),e(v),d(1))
= T(d(u),e(v),(1,0)) + T(d(u),e(v),(0,1))
= T(d(u),(v,0),(0,1)) + T(d(u),(0,v),(0,1))
= T(d(u),d(v),e(1)).

Logo B_{F_1}(u,v)=B_{D_af}(d(u),e(v))=0. Como F_1 tem grau no máximo dois, ela é afim: F_1(u)=L(u)+c.

A rotação completa de x=d(u)+e(1) induz u↦R₁₆u+e₀, onde R₁₆ é a rotação das 16 coordenadas. Portanto

F_1(R₁₆u+e₀)=F_1(u).

Comparando partes lineares, L é invariante por R₁₆ e tem a forma βΣ_i u_i. Comparando os termos constantes, L(e₀)=β=0. Assim F_1 é constante. Sua soma A_1 é ±2¹⁶, contradizendo A_1=0 exigido pelo passo 2.

**Conclusão:** nenhuma função cúbica homogênea RS em 32 variáveis é bent.

## 4. Certificado finito universal independente de H

O argumento acima é algébrico. Para conferir sua implementação em n=32, `audit_universal_n32.py` regenera as 155 órbitas cúbicas. Constrói as 31 equações da primeira linha da polar de D_af (posto 14) e calcula a ANF exata da fibra F_1 por substituição de monômios. As 16 formas lineares e as 120 formas quadráticas dessa fibra são todas combinações lineares das equações da derivada. Portanto qualquer solução das equações necessárias torna F_1 constante, em todo o espaço de 155 coeficientes.

O certificado registra as 136 identidades e suas combinações de equações. `verify_universal_n32.py` usa outro avaliador, diretamente sobre as máscaras dos monômios da ANF, para verificar as equações por diferenças em oito pontos. Verifica também, por coeficientes de Möbius, que a diagonal é nula e que a fibra complementar não tem termos cúbicos, e confirma as 136 identidades.

Reprodução:

```
python3 audit_universal_n32.py certificado_universal_n32.json
python3 verify_universal_n32.py certificado_universal_n32.json auditoria_universal_n32.json
```

São necessários os scripts acima e os auditores `audit_all_ones_obstruction.py` e `audit_independent_cnf.py` na mesma pasta. Não execute com `python -O`. Não há dependências externas nem necessidade de GPU.

As exclusões de pesos zero a cinco foram obtidas e auditadas antes desta simplificação e fornecem controles independentes. O certificado universal substitui a necessidade de enumerar os outros pesos H. Trata-se de prova matemática acompanhada de auditoria computacional, não de formalização em Lean/Coq nem de certificado SAT de todo o espaço.

O verificador também testa exaustivamente as 128 funções cúbicas homogêneas RS em oito variáveis e confirma um controle positivo cúbico RS **não homogêneo**, cujo espectro tem magnitude 16. Isso verifica que a auditoria reconhece bentness quando a hipótese de homogeneidade é retirada.
