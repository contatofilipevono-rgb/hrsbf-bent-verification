# Certificado algébrico do resíduo da energia na coluna zero

Data: 14/11/2026. Codex. Extensão da reformulação por radicais registrada
pelo Claude em NOTA_PARSEVAL_COLUNA0.md, commit 193e6db. Sem revisão humana
ou alegação de prioridade na literatura.

## Domínio e identidade

Fixe um espaço afim de fases parametrizado por theta em F2^m, com
f_theta(z,w)=f_0(z,w)+sum_i theta_i K_i(z,w). Cada K_i é afim em w e cada
f_0(z,.) é quadrática, de polar B_z fixa. Defina r_theta(z)=sum_w (-1)^f.

A normalização de Parseval é
sum_alpha W_f(alpha,0)^2=64 sum_z r_theta(z)^2=64 E(theta).
Se f é bent, o lado esquerdo tem 64 termos iguais a 64^2. Portanto
E(theta)=4.096 é uma condição necessária.

Expandindo o quadrado e trocando w' por w+d, a soma em w se anula fora do
radical de B_z. Dentro dele, vale 64 vezes o sinal da derivada. Logo

    E(theta)=sum_z r_theta(z)^2
            =64 sum_{z,d in rad B_z} (-1)^{f_0(z,d)+f_0(z,0)+L_zd(theta)},

onde L_zd(theta)=sum_i theta_i [K_i(z,d)+K_i(z,0)] é uma forma linear.
Agrupe os pares (z,d) que produzem a mesma forma L:

    E(theta)=64 T(theta),   T(theta)=sum_L n_L (-1)^{L(theta)}.

O coeficiente n_L é inteiro: a quantidade de sinais positivos menos a de
negativos naquele grupo. Essa construção percorre no máximo 4.096 pares
(z,d), sem enumerar os 2^m parâmetros.

## Certificado curto por uma relação linear

Suponha que cada n_L com L!=0 seja múltiplo de oito e que

    XOR_{L!=0, (n_L/8) impar} L = 0.

Pondo n_L=8a_L e usando (-1)^L=1-2L em inteiros,

    T(theta)-T(0) = -16 sum_{L!=0} a_L L(theta).

A relação XOR implica que a soma da direita, antes do fator -16, é par.
Assim T(theta)=T(0) (mod 32) e

    E(theta)=E(0) (mod 2048) para todo theta.

Se esse resíduo é diferente de zero, E não pode ser 4.096; nenhuma função
desse espaço afim é bent. A prova usa os coeficientes e uma identidade
linear, sem varrer os parâmetros.

## Certificado por coeficientes inteiros de grau baixo

Escolha uma base de D formas lineares independentes gerando todos os L.
Seus valores podem ser usados como coordenadas x em F2^D, pois a aplicação
linear sobre os parâmetros é sobrejetiva. Escreva L por uma máscara l.
O levantamento inteiro de seu caráter é

    (-1)^L = product_{i:l_i=1} (1-2x_i).

Portanto o coeficiente do monômio x^J em T é

    (-2)^|J| sum_{l contendo J} n_l.

Para provar T constante módulo 32, basta conferir divisibilidade por 32
desses coeficientes para 1<=|J|<=4. Os graus maiores já têm o fator 32.
Se todos os n_l não constantes são múltiplos de 2^s, basta conferir graus
até 4-s. Isso é comparação de coeficientes de uma identidade; não exige
enumerar F2^D. O certificado curto anterior é o caso s>=3.

## Três pilotos reais concluídos

O verificador reconstrói o modelo RS e os domínios completos U depois de
L5+L3. Os espaços têm dimensão 28, 29 e 28; as polares estão em inputs.json.

* Resíduo 768: 268 pontos (z,d); pesos não constantes múltiplos de oito e
  uma relação XOR nula provam a congruência em todo U de dimensão 28.
* Resíduo 1792: 316 pontos (z,d); o mesmo certificado curto funciona em
  todo U de dimensão 28. O grupo de caracteres não nulos tem seis termos.
* Resíduo 1024: 640 pontos (z,d); nove formas independentes bastam. Pesos
  múltiplos de quatro deixam somente 45 coeficientes lineares/quadráticos
  a conferir. Eles provam a congruência em todo U de dimensão 29.

Uma testemunha RS bent publicada tem E(0)=4.096 e não é excluída. Dezessete
avaliações diretas em cada domínio conferem a construção dos coeficientes;
a validade em todos os parâmetros vem das identidades acima, não desses
testes amostrais.

O método foi aplicado somente aos três pilotos, não às 1.196 polares com
resíduo constante não nulo do arquivo de dados auditado. Generalizar a
lista de coeficientes ou uma descrição estrutural a todas elas ainda é uma
tarefa pendente. Não se conclui que os demais casos com Parseval atingível
sejam bent.

Reprodução: primeiro execute ../piloto-gauss-real/inputs_model/base12.py;
depois execute python certifica.py. Saídas completas em resultado.json.

No GitHub, os scripts localizam a pasta fable_planos_pfaffiano existente no
conjunto de notas; execute primeiro o base12.py dessa pasta. Não é preciso
copiar os módulos do modelo para inputs_model. Os certificados numéricos
dos três pilotos foram auditados independentemente pela sessão
astra_auditoria, inclusive nas coordenadas originais dos parâmetros.
