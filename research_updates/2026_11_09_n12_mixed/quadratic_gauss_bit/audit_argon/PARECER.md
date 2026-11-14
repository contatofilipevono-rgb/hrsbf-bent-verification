# Auditoria do lema de Poisson entregue pelo Argon

Data: 14/11/2026. Auditor: Codex. Sem revisão humana ou checagem de prioridade.

## Veredito

O lema principal e a extração direta dos coeficientes estão corretos no domínio
enunciado: polar fixa e parte afim em w dependendo afimmente dos parâmetros.
A propriedade adicional de grau conjunto dois em (theta,w0,omega) também
confere, escolhidas parametrizações lineares dos representantes.

A auditoria do Carbon contém, porém, uma fórmula de Poisson incorreta e duas
conclusões falsas de divisibilidade por oito. Elas não invalidam o lema de
grau dois nem a necessidade módulo quatro usada em bitj.py. Devem ser
retiradas antes de incorporar o parecer ou acrescentar filtros mais fortes.

## O que foi conferido

Os dois anexos enviados são cópias idênticas, com SHA256
F1A4E752A7153ECE5DA925EE7223865741523BE6AC638B1AD7EEBFCAF7C6F676.
Portanto não constituem duas conferências independentes.

Li a prova e o script originais, e localizei a resposta da chamada ao Carbon
no scratch do Antigravity. Não executei uma nova chamada à API.
Reexecutei o verificador do Argon: todos os testes terminaram sem falha.

Escrevi auditoria_independente.py, que usa somas inteiras diretas como
referência e confere depois o extrator do Argon. Foram 64 famílias cobrindo
todas as 64 polares restritas a um 4-flat, cada uma com três parâmetros e
seis bits auxiliares: 32.768 pontos conjuntos. Conferi 1.408 extrações de
coeficientes, 512 equivalências entre os sistemas completo e comprimido,
e 192 permutações da ordem de entrada da base. Um bit corrompido em cada
família foi detectado pelo teste de grau. Isso é uma conferência da prova,
não uma enumeração dos polares da execução ampla.

## A compressão que pode ser aproveitada

Fixados (I,V), escreva y=(w0,omega) em coordenadas lineares de dimensão seis.
Pelo grau conjunto, existe a decomposição exata

    b(theta,y) = q(theta) + sum_j y_j L_j(theta) + sum_{j<k} c_jk y_j y_k,

com grau(q)<=2, grau(L_j)<=1 e c_jk constantes. O termo constante e os
termos lineares em y estão incluídos em q e L_j.

Logo exigir as 64 equações b(theta,y)=0 equivale a exigir:

* uma equação quadrática q(theta)=0;
* seis equações afins L_j(theta)=0;
* quinze testes constantes c_jk=0.

Se algum teste constante vale um, a família inteira é incompatível. Se todos
valem zero, sobram no máximo sete equações não constantes. Isso pode encurtar
certificados e a montagem do sistema. Não prova que haverá 64 vezes de
aceleração: bitj.py já calcula muitas escolhas em conjunto, e o ganho de
tempo exige comparar implementações no mesmo piloto.

## Erro na auditoria do Carbon: normalização de Poisson

O parecer do Carbon afirma que, para bent, M_I é múltiplo de oito em F4 com
|I|=1 e em F6 com |I|=2. Isso é falso em geral.

Se j=|I|, V tem dimensão 2k e o domínio é F2^6 x F2^6, a fórmula correta,
para bent e com a normalização M=sum K/2^k, é

    M_I = 2^(k-j) sum_{alpha in span{e_i:i in I}, beta in omega+Vperp}
                        (sinais) .

São 2^(6-2k+j) sinais, cada um em {+1,-1}; os sinais incluem as fases da
classe afim e do dual bent. A dimensão do anulador em z é j, não 6-j.

Em F4, k=2, j=1: M é duas vezes uma soma de oito sinais, portanto múltiplo
de quatro; não necessariamente de oito. Em F6, k=3, j=2: M é duas vezes
uma soma de quatro sinais, novamente múltiplo de quatro. O módulo quatro
usado no lema é preservado.

### Contraexemplo F6, de grau dois

Tome f(z,w)=z.w+w0*w1, com índices de coordenadas começando em zero. É bent
da classe Maiorana-McFarland. Com V=W, omega=0 e I={0,1},

    sum_{z0=z1=1} (sum_w (-1)^f(z,w))/8 = -4.

Os 4.096 coeficientes de Walsh têm módulo 64; o momento não é múltiplo de
oito. O contraexemplo pode ser conferido inteiramente por somas de inteiros.

### Contraexemplo F4, de grau três e quadrático em w

Defina a permutação triangular

    pi(y)=(y0+y1*y2, y1+y3*y4, y2,y3,y4,y5),
    s(z)=(0,0,0,0,z3,z4),
    f(z,w)=z.pi(w+s(z)).

A permutação e a mudança linear (z,w)->(z,w+s(z)) preservam a construção
bent. Use V=span(e0,e1,e2,e3), w0=0, omega(v)=v0 e I={2}. Então M_I=-4.
O verificador reconstrói a função e confere todos os 4.096 coeficientes de
Walsh por borboletas inteiras. Esses exemplos não são apresentados como RS;
refutam a afirmação geral sobre funções bent feita na auditoria.

## Outras correções de alcance

1. O trecho que limita a grau quatro, em Z, o levantamento inteiro de uma
   expressão feita com polinômios booleanos quadráticos confunde os dois
   anéis. Por exemplo, com polar de posto dois e radical sempre ativo,
   kappa=2(-1)^(theta1+...+theta6), com a soma no expoente em F2, tem
   levantamento multilinear inteiro 2*product_i(1-2theta_i), de grau seis.
   Seu resíduo módulo quatro continua constante. A prova modular permanece
   correta e dispensa esse limite de grau inteiro.
2. test_real_repo_model não testa uma polar real do repositório: verifica a
   restrição afim de um polinômio aleatório, condicionada à existência de uma
   pasta. O comentário da função promete mais do que seu corpo executa.
3. O suposto bug causado apenas por permutar V_elems não foi confirmado.
   A extração de uma base é válida em qualquer ordem quando V_elems é de
   fato o subespaço inteiro. As 192 permutações testadas deram coeficientes
   idênticos. A resposta do Carbon também menciona asserts literais de uma
   versão anterior; o script entregue já usa a dimensão genérica.
4. A independência dos coeficientes quadráticos em relação a q_z significa
   independência do refinamento quadrático ao manter a polar fixa. Esses
   coeficientes continuam dependendo da polar B_z.

## Próximo passo recomendado

Preservar a execução ampla em andamento. Corrigir o texto do parecer,
aproveitar a compressão e comparar os coeficientes do extrator com bitj.py
em um pequeno piloto real, incluindo controles bent. Só depois integrar a
otimização. Não introduzir o filtro falso módulo oito.

O trabalho valida uma etapa do método e oferece uma compressão exata. Não
fecha a classificação algébrica de n=12, grau quatro.
