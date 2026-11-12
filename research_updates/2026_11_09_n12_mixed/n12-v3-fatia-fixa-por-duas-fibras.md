# O mapa de uma quártica bent no bloco V₃ zera na fatia fixa

## Enunciado e dependências

No modelo antipodal de 12 variáveis, suponha que f é RS bent de grau até quatro e afim nas classes de V₃, de base (9,18,36). Escreva f=h+v·π, com w=(u+v,v), z=(x+r,x) e π afim em u. Então π=0 na fatia Φ={r=0}. Em consequência, Φ é a fibra inteira de rótulo zero e a restrição de h a Φ é bent em seis variáveis.

O argumento usa o grau de f em w no máximo dois e o teorema da fatia fixa de Fable, na seção 3 de `FABLE_MEIA_VOLTA_DIM3.md`. O teorema dá posto no máximo um de Q na fatia para todo mapa bent. A base de dimensão 34 do mapa tem imagem de dimensão seis na fatia. A projeção linear e o teste de posto deixam exatamente 16 restrições, incluindo a nula. As deduções sobre a polar em z=0 e a linha z=7 constam em `n12-v3-exclusao-perfil-0356.md`. A verificação abaixo não lê a lista anterior de 97.530 mapas nem as tarefas de fase.

## Classificação das geometrias de uma fibra invariante

Para os rótulos 0 e 7, a fibra é invariante pela rotação em (z,u). Em qualquer linha de z fora de Φ, o mapa é afim em u e invariante por u↦u+r. A órbita de tamanho dois em z admite, em (z,u), uma órbita de quatro pontos e outra de doze. As opções compatíveis com um tamanho de linha potência de dois são escolher nenhuma, a de quatro, ou ambas. Para as nove órbitas de tamanho seis em z, uma peça é a órbita em (z,u) de um par {u,u+r} na linha representante. Há 36 peças de doze pontos. Uma união de três peças da mesma linha teria seis pontos por linha e é proibida.

Para cada restrição fixa, escolhem-se peças que completam os 64 pontos da fibra. A indicadora da fibra tem grau no máximo cinco. Assim o XOR das assinaturas das peças, formadas pelos coeficientes de grau pelo menos seis, tem de ser a assinatura da parte prescrita. A lista é recuperada por comparação de somas de até três assinaturas de cada lado. Quando Q(x,0)=0, a geometria também obedece à relação de Q na linha z=7 demonstrada na nota anterior.

## Exclusão de 13 restrições com a fibra zero

Na fibra zero a fase é constante nas órbitas da rotação em (z,u). A verificação permite uma variável independente por órbita. Se Q(x,0)=0, em z=0 usa a forma h(0,u)=a₀+a₁σ(u)+δΣ_{i<j}uᵢuⱼ, com δ=g(3)₀+g(3)₂. A quadraticidade em u nas linhas completas dá paridade zero da fase nessas linhas. Acrescentam-se os primeiros bits dos momentos e a paridade por autocorrelação das interseções. Os momentos módulo oito eliminam por álgebra polinomial os casos que passam a etapa linear. Com isso 13 das 15 restrições não nulas são excluídas usando apenas a fibra zero. Quatro delas nem sequer admitem uma geometria dessa fibra.

## Duas restrições exigem também a fibra sete

Para cada um dos perfis 02471770 e 04172770, restam 24 geometrias da fibra zero após as condições de fase. Quatro não admitem levantamento linear no espaço dos mapas. As 20 restantes são cruzadas com as geometrias da fibra sete. Para a fase dessa fibra, a rotação muda o sinal pelo bit u₂. O sistema por órbitas é consistente apenas quando a soma desse bit na órbita é zero. A imposição desse cociclo e dos mesmos momentos deixa quatro das 52 geometrias da fibra sete.

Para os pares disjuntos, impõem-se os rótulos 0 e 7 nos pontos correspondentes e o perfil em Φ. Para cada perfil, oito pares forçam zeros extras e são impossíveis. Nos 64 pares restantes, a projeção de π no quociente por ⟨111⟩ deve ser não nula nos pontos fora das duas fibras. Se a projeção tem coordenadas a e b, isso é a equação booleana (1+a)(1+b)=0. A eliminação sobre F₂ e as substituições afins dão contradição em todos os 64 sistemas quadráticos de cada perfil. Não há varredura de atribuições de mapas nem de fases.

## Reprodução e alcance

Execute `python v3_fixed_profiles_by_zero_fibre.py --output v3-fixed-profiles.json` na pasta dos verificadores de n=12. O relatório dá as 15 exclusões e as contagens intermediárias por perfil. Trata-se de uma prova algébrica com classificação finita de geometrias, construída das bases e das simetrias. A lista algébrica dos mapas que sobrevivem dentro de π|Φ=0 e a contagem direta das fases de suas 12 órbitas bent permanecem etapas distintas.
