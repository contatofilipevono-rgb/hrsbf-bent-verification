# Obstrução pela derivada na direção de todos os uns

## Escopo

Este resultado exclui as 24 famílias de parâmetro H de peso três listadas no certificado associado, incluindo as 16 que ainda estavam abertas após oito exclusões SAT verificadas. Não resolve o caso geral cúbico em 32 variáveis nem dimensões 16m. A novidade bibliográfica do lema abaixo não foi estabelecida.

## Lema algébrico

Se n é uma potência de dois e q é uma função booleana de grau no máximo dois, invariante pela rotação cíclica S das n coordenadas, então q balanceada implica que sua forma polar B é nula.

**Prova.** Ponha Q(x)=q(x)+q(0), e B(x,y)=Q(x+y)+Q(x)+Q(y). O radical R de B é S-invariante. Se B não é nula, R é um subespaço próprio.

Identifique o espaço das coordenadas com F₂[X]/(Xⁿ+1), com S representado pela multiplicação por X. Como n é potência de dois, Xⁿ+1=(X+1)ⁿ. Um vetor de peso ímpar tem polinômio r com r(1)=1, portanto é uma unidade neste anel. Seus deslocamentos cíclicos geram todo o espaço. Um subespaço próprio S-invariante não pode conter tal vetor. Logo R está contido no subespaço de peso par, que é a imagem de S+I.

Para r em R, escreva r=Sy+y. Pela invariância de Q,

Q(r)=Q(Sy)+Q(y)+B(Sy,y)=B(r+y,y)=0.

A soma A=Σₓ(-1)^q(x) satisfaz a identidade quadrática

A²=2ⁿ Σᵣ∈R (-1)^Q(r)=2ⁿ|R|>0.

De fato, substituindo o segundo argumento da soma dupla por x+r, a soma interior em x é zero fora do radical e 2ⁿ dentro dele. Assim q não é balanceada. Isso demonstra a contrapositiva. A hipótese sobre n é essencial: em n=6, q=Σᵢ xᵢxᵢ₊₂ é balanceada e tem polar não nula.

## Consequência para funções cúbicas

Se f é bent, toda derivada Dₐf com a≠0 é balanceada. Isso segue da identidade de autocorrelação: a transformada de Walsh da autocorrelação é W_f², constante 2ⁿ para uma função bent.

Se f é cúbica e simétrica por rotação e a é o vetor de todos os uns, Dₐf tem grau no máximo dois e mantém a simetria. Em n potência de dois, o lema exige B_{Dₐf}=0. Para um monômio cúbico xᵢxⱼxₖ, sua contribuição quadrática à derivada é xᵢxⱼ+xᵢxₖ+xⱼxₖ. Portanto a matriz exigida pode ser obtida diretamente das órbitas de monômios.

## Ligação exata ao parâmetro H em n=32

Divida as coordenadas em duas metades de 16. Escreva d(u)=(u,u), e(v)=(0,v) e a=d(1). Seja T a terceira polarização de f. O parâmetro H soma, módulo dois, os quatro coeficientes de órbitas cúbicas de 32 que projetam em cada órbita cúbica de 16; as 15 órbitas com repetição de índice após redução módulo 16 não contribuem. A ordenação exata das 35 e 155 órbitas consta no certificado.

Seja h a função cúbica de 16 coordenadas cujos coeficientes são H, e M_H a matriz polar de D₁h. Então

B_{Dₐf}(d(u),e(v)) = uᵀM_Hv.

Há uma verificação finita completa desta identidade linear: em cada uma das 155 órbitas geradoras, constrói-se B_{Dₐf} somando os três pares de cada monômio. Sua matriz cruzada tem linhas ((B[i]+B[i+16]) >> 16), truncadas a 16 bits. Ela coincide com a matriz polar de D₁ da órbita projetada em 16 coordenadas, ou com zero para as 15 órbitas restantes. O script regenera ambas as bases e ambas as matrizes diretamente; não importa os tensores da modelagem SAT. A linearidade estende a identidade a todos os coeficientes.

Cada registro do certificado fornece uma entrada não nula de M_H, a forma linear correspondente nos 35 coeficientes H e nos 155 coeficientes originais, e a matriz inteira. Como a entrada é fixada em 1 por H, nenhum dos 120 coeficientes livres pode anulá-la. Portanto B_{Dₐf}≠0 para toda função na família, contrariando a condição necessária de bentness.

## Reprodução e limites

Execute `python3 audit_all_ones_obstruction.py familias_24_derivada_uns.json certificado_derivada_uns_24.json`.

Além das 155 identidades, o auditor examina todas as funções quadráticas simétricas por rotação em n=4,8,16,32, incluindo o gerador antipodal e termos lineares e constantes. Em n=4 e 8, compara o critério de radical com somas diretamente nas tabelas-verdade. Os testes apoiam a implementação; a prova do lema é algébrica.

As oito exclusões SAT anteriores permanecem válidas como confirmação independente. A derivada de todos os uns exclui também as outras 16 famílias. Os resultados são certificados finitos acompanhados de prova matemática, não uma formalização em um assistente de provas. A classificação de todos os outros parâmetros H e a conjectura geral permanecem fora deste certificado.

## Próximo filtro de pesquisa

A condição necessária B_{D₁f}=0 impõe 14 equações lineares independentes nos 155 coeficientes cúbicos originais, deixando um subespaço de dimensão 141. A condição cruzada em H impõe seis equações independentes nos 35 coeficientes, deixando dimensão 29. Entre os 6.545 H de peso três, 6.464 são excluídos apenas por este filtro e 81 o satisfazem. Esses 81 não são novos casos abertos: precisam ser cruzados com os certificados de exclusão anteriores. Satisfazer este teste não implica bentness. As equações e a lista de 81 parâmetros constam em `filtro_global_derivada_uns.json`.

## Cobertura consolidada dos 6.545 parâmetros de peso três

Os 81 parâmetros que passam pelo filtro foram extraídos dos certificados anteriores e novamente verificados, por avaliação direta da ANF e álgebra linear independente. Todos os 81 foram excluídos. Logo o filtro novo (6.464 exclusões) e os certificados complementares (81 exclusões) cobrem todos os 6.545 parâmetros H de peso três. Não é necessário reutilizar os seis certificados SAT antigos para esta cobertura.

A condição de balanceamento usada nos certificados de fibras tem aqui uma hipótese específica: f(u,u)=0. Para uma função cúbica homogênea RS em 32 coordenadas, cada monômio emparelha com seu deslocamento de 16 posições, que é distinto e tem o mesmo valor na diagonal, portanto a igualdade vale. Na parametrização x=(u,u+z), a fibra z=0 é nula. Se f fosse bent, Parseval na transformação sobre z daria Σ_z W_{f_z}(0)²=2³². O termo z=0 já vale 2³², forçando todas as outras fibras a serem balanceadas.

Uma fibra quadrática é balanceada exatamente quando sua forma normalizada é não nula no radical da polar. Em posto 14, esse radical de dimensão dois contém z, onde o valor normalizado é zero por invariância sob a troca das metades. O outro gerador r deve então ter valor 1, produzindo a equação linear usada no certificado. A soma das equações certificadas dá 0=1. Nos certificados de posto zero, as equações de base forçam o valor normalizado a ser zero em toda uma base do radical; a fibra é constante e não balanceada. O auditor verifica essas premissas e contradições para cada registro.

Para reproduzir a cobertura: `python3 verify_weight_three_cover.py`. São necessários o auditor `audit_independent_cnf.py`, o novo auditor `audit_all_ones_obstruction.py` e `certificados_81_complementares.json`, todos na mesma pasta. O resultado é uma cobertura das famílias cujo **parâmetro projetado H tem peso três**, independentemente dos 120 coeficientes livres. Não é uma afirmação de que f tenha somente três órbitas nem uma resolução de todos os pesos H.
