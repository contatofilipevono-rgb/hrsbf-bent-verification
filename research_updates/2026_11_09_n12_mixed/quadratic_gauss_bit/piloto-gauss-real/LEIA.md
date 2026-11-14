# Piloto no modelo real de n=12

Data: 14/11/2026. Codex. Este é um piloto de integração, não uma nova busca
exaustiva nem uma medição de aceleração.

Reconstruí base12.pkl executando base12.py numa pasta isolada. As dimensões
reapareceram: 70 funções RS de grau <=4 na base original, 68 quadráticas em
w, 25 direções de polar e 43 direções afins em w. Os módulos vieram da cópia
local do Claude; não alterei seu repositório ou sua execução.

Foram usados dois domínios:

1. Uma polar mista real da lista de Parseval do commit 193e6db, com domínio
   afim U de dimensão 28 após L5+L3. Testei a fatia gerada pelas direções
   0,6,13,20,27 dessa base.
2. A primeira testemunha publicada em lower-dim-family-witnesses.json,
   órbita de mapa 1583330. Reconstruí seus 4.096 valores, confirmei rotação,
   grau exatamente quatro e todos os coeficientes de Walsh com módulo 64.
   Testei a fatia com as direções 0,10,21,31,42 da parte afim em w.

Em cada domínio percorri os 32 parâmetros da fatia de dimensão cinco, três
4-flats (índices 0,100,400), sete momentos e as 64 escolhas auxiliares.
Isso dá 86.016 valores de bits por somas inteiras diretas. Nos pontos de
peso <=2 comparei também com a função original bitj.bits: 32 chamadas no
total. O extrator direto do Argon coincidiu em 924 polinômios, com todos os
seus 16 coeficientes em cinco parâmetros. Foram conferidas a propriedade
de grau conjunto e a equivalência do sistema comprimido.

O teste não foi vacuamente afim: as duas famílias tinham respectivamente
1.856 e 4.224 coeficientes quadráticos não nulos nos bits verificados. A
testemunha bent passou na origem das fases.

Os tempos no resultado.json têm escopos diferentes: bitj.bits calcula todos
os 651 flats, enquanto o extrator direto foi sondado em três. Não permitem
inferir um fator de aceleração. A correção da compressão passa neste piloto;
uma integração completa ainda precisa preservar a cobertura de todos os
flats e a equivalência das equações.

Reprodução local:

    python inputs_model/base12.py
    python piloto.py

O script também usa o extrator arquivado em
../auditoria-argon-poisson/argon_prova_poisson_bitj.py. O arquivo
input_pilots.json preserva a polar e a ANF da testemunha utilizadas.
