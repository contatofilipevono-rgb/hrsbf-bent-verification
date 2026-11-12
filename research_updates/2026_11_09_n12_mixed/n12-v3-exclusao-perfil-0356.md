# Exclusão pelo suporte de uma única fibra no bloco de dimensão três

Considere π(z,u)=g(z)+Q(z)u no bloco V₃, com z=(x+r,x) e u em F₂³. Suponha que em r=0 o mapa seja independente de u e tenha perfil (0,0,0,3,0,5,6,0) em x=0,…,7. A lista de suportes gerava 9.528 mapas com esse perfil. A exclusão abaixo usa seis coeficientes da indicadora da fibra zero e nenhuma atribuição de fase.

## Duas identidades estruturais

Denote por C a rotação de três coordenadas. Na rotação de uma posição, r vai a Cr, x vai a Cx+r₂e₀ e a parte linear em u é C. Por isso Q é conjugado por C. Pela meia-volta, Q(z)r=0. Como Q tem grau no máximo dois e Q(x,0)=0, escreva cada linha de Q como q₀(r)+Σ_i x_iL_i(r). Os coeficientes quadráticos em x são constantes em r e ortogonais a todo r, portanto zero. Cada L_i é linear, com L_i(r)·r=0, portanto da forma c_i×r. A rotação de três posições conserva Q e envia x a x+r. Assim a aplicação linear r↦Σ_i r_ic_i é paralela a r para todo r e é escalar. Aplicando o argumento por linha e usando a conjugação por C, obtemos

    Q(z)u = Q₀(r)u + c [(x×r)·u],     Cc=c.

Para z=7, temos x=0, r=111. Denote A=Q₀(111)e₀ e D=Q₀(111)e₁. Como Q₀(111)111=0, a terceira coluna é A+D. A rotação envia x=0 a e₀ e deixa r=111. O termo adicional c[(e₀×111)·u] zera na coluna u=e₀, portanto A=C(A+D), isto é, D=A+C⁻¹A. Se Q(7) tem posto um, A é não nulo e D tem de ser zero. Logo A=111 e o núcleo é u₀+u₂=0. As duas classes possíveis de quatro zeros na linha 7 têm máscaras 90 e 165.

Seja b(x,r) o vetor que representa a polar de f em u. Nas coordenadas w=(u+v,v), a meia-volta dá B_z z=0, isto é, b(x,r)×r=Q₀(r)ᵀx+(c·x)(x×r). Assim b′(x,r)=b(x,r)+(c·x)x satisfaz b′(x,r)×r=Q₀(r)ᵀx. Como o lado direito é linear em x, os coeficientes quadráticos em x de b′ são paralelos a todo r≠0. São constantes em r pelo grau e, portanto, zero. Em r=0, segue b′(x,0)=δ111+Lx. Q(x,0)=0 e Cc=c garantem que a rotação envia b′(x,0) a Cb′(x,0), logo L é circulante.

Em r=0, a identidade da rotação de três posições na fase é h(x,0,u+x)+h(x,0,u)=g(x)·u. Comparando os coeficientes de u, g(x)=b(x,0)×x. Para x=3, o XOR das coordenadas 0 e 2 de g(3) é σ(b(3,0))=δ, pois σ(Lx)=0 quando x é par e L é circulante. Neste perfil g(3)=3, portanto δ=1. Consequentemente, em z=0 a fase tem a forma

    h(0,u)=a₀+a₁σ(u)+u₀u₁+u₀u₂+u₁u₂.

A parte linear é simétrica por rotação, pois a fase na fibra zero é invariante pela rotação.

## Geometria da fibra zero

A fibra zero tem 64 pontos. Em r=0 ela contém cinco linhas completas de oito pontos, com x em {0,1,2,4,7}. Restam 24 pontos. Fora da fatia fixa, a rotação em z tem uma órbita de tamanho dois e nove de tamanho seis. Uma linha não vazia tem tamanho 2, 4 ou 8, pois Q(z)r=0 e r≠0. Reduzindo o total 24 módulo seis, a órbita de tamanho dois fica vazia. Assim há uma órbita de tamanho seis com quatro pontos por linha ou duas com dois pontos por linha. Em cada representante a linha é estável por u↦u+r, logo há seis opções de quatro pontos ou quatro de dois pontos. Isso dá 9·6 + C(9,2)·4² = 630 geometrias.

Escolher a parte exterior equivale a escolher duas das 36 peças elementares. Cada peça é a órbita de seis linhas do par {u,u+r} num representante z. Como as peças são disjuntas, suas indicadoras se somam em F₂. A condição de grau no máximo cinco força o XOR das assinaturas das duas peças a igualar a assinatura da parte fixa. Use os seis coeficientes de grau seis com máscaras (63,111,175,222,123,126), nessa ordem do bit menos ao mais significativo. Para cada coeficiente de máscara m, conte módulo dois os pontos de índice y=z+64u com y⊆m. Isso dá assinatura 1 para a parte fixa e a seguinte tabela para as peças. Em cada célula o primeiro número é o menor u do par e o segundo é a assinatura.

| z | Peça 1 | Peça 2 | Peça 3 | Peça 4 |
|---:|---:|---:|---:|---:|
| 1 | (0,26) | (2,24) | (4,10) | (6,8) |
| 3 | (0,5) | (1,23) | (4,22) | (5,4) |
| 5 | (0,58) | (1,40) | (2,40) | (3,58) |
| 7 | (0,32) | (1,33) | (2,32) | (3,33) |
| 11 | (0,47) | (1,63) | (4,44) | (5,60) |
| 13 | (0,53) | (1,55) | (2,36) | (3,38) |
| 15 | (0,31) | (1,12) | (2,12) | (3,31) |
| 23 | (0,34) | (1,49) | (2,48) | (3,35) |
| 31 | (0,0) | (1,3) | (2,17) | (3,18) |

Os únicos pares de assinaturas que diferem exatamente no bit menos significativo estão dentro das linhas 3, 7 e 23 da tabela. Resultam oito geometrias. A próxima tabela fornece a máscara do conjunto de valores u na linha representante.

| z | Máscaras sobreviventes |
|---:|---|
| 3 | 105, 150 |
| 7 | 60, 102, 153, 195 |
| 23 | 105, 150 |

Em z=7 nenhuma das máscaras é 90 ou 165, excluindo as quatro geometrias pela identidade de Q. Nas outras quatro, use o deslocamento d=(z,0) em (z,u), com z=3 ou 23 conforme a linha da tabela. A interseção S∩(S+d) tem oito pontos. Sua soma de fase, reduzida pela rotação, é h(0,0)+h(0,3) para a máscara 105, e h(0,1)+h(0,7) para a máscara 150. Ambas valem um pela forma de h(0,u). A autocorrelação exige soma zero módulo dois, pois 8/4=2. O verificador confere a tabela de 36 assinaturas e as quatro interseções. A demonstração usa essas contas finitas na geometria da fibra e as duas identidades estruturais, sem a enumeração dos mapas completos nem das fases.

## Extensão ao perfil com 53.244 mapas

Para o perfil (0,6,5,3,3,5,6,0), ainda temos Q(x,0)=0 e g(3)=3, logo a mesma dedução fixa a polar de h(0,u). A fibra zero agora tem duas linhas completas na fatia fixa, em x=0 e 7, e precisa de 48 pontos fora dela. Pelo mesmo argumento módulo seis, a órbita de tamanho dois fica vazia. A parte exterior consiste em quatro das 36 peças elementares. Uma linha não pode conter exatamente três pares, pois sua cardinalidade tem de ser potência de dois.

O verificador guarda as assinaturas de grau pelo menos seis de cada soma de duas peças e usa o XOR com a assinatura da parte fixa para recuperar as somas de quatro. Restam 329 geometrias. Em cada uma, concede-se à fase liberdade independente em cada órbita da fibra, exceto em z=0, onde se usa a forma deduzida acima. Em uma linha completa de oito pontos, a soma da fase é zero módulo dois, pela quadraticidade em u. Juntam-se essas equações aos primeiros bits dos momentos e às paridades das interseções. Restam 17 geometrias com sistemas lineares compatíveis, 16 com quatro direções de fase e uma com cinco. Os momentos módulo quatro ainda são compatíveis nas 17. Os momentos completos módulo oito produzem uma linha constante igual a um após eliminação em todos os casos. Nenhuma atribuição de fase é percorrida.

O argumento exclui a classe pelo suporte e pelos sinais de uma única fibra. Ainda usa a classificação finita das 329 geometrias. O total de 53.244 é o tamanho da classe na enumeração anterior, e a demonstração aplica-se a qualquer mapa que satisfaça o perfil e as hipóteses de grau e rotação.
