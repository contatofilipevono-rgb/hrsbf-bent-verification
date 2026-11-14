# Cobertura pelos planos e identidade do Pfaffiano maior

O arquivo `cobertura3984.json` registra a conferência dos conjuntos entregues
pelo Claude nos commits `13f3512`, `94a90f5`, `356d9ee` e `41f875e`.
O arquivo de entrada contém 3.984 polares distintas. Há 2.304 com sistema
(L5)+(L3) vazio e 1.680 com certificado de autocorrelação ou de linhas
forçadas. Os conjuntos são disjuntos e cobrem a entrada inteira. Os 20
registros `open` da rodada dos 340 têm exatamente os mesmos identificadores
que os 20 certificados por linhas forçadas. O funil anterior contém as
mesmas 3.984 polares e registra zero funções bent.

## Verificadores e a rodada dos 340

Para (F_z(w)=f(z,w)), seja (r_b(z)) a soma de
((-1)^{F_z(w)+b\cdot w}) em (w). Expandir (r_b(z)^2) via (d=w+w')
dá

```text
E_b = 64 Σ_d (-1)^(b·d) S_d,
S_d = Σ_{z : B_z d = 0} (-1)^[F_z(d)+F_z(0)].
```

Como (S_0=64), a inversão de Walsh prova a equivalência entre
(E_b=4096) para todo (b) e (S_d=0) para todo (d\ne0).
Um número ímpar de parcelas exclui (S_d=0). Quando esse número é
par, reduzir (S_d=0) módulo quatro dá uma equação afim nas fases.
Nas soluções conjuntas dessas equações, a expansão em caracteres
certifica resíduos constantes por coeficientes inteiros.

Para as linhas forçadas, cada linha tem peso (64|\ker B_z|) na energia
quando seu caráter se anula no radical. O verificador recompõe o espaço
afim e impõe a nulidade em seu ponto base e em todas as direções. A soma
das linhas que passam é uma cota inferior porque cada outra contribuição
é um quadrado. Isso valida o critério usado nas 20 polares.

O verificador do Claude recalcula o domínio (L5)+(L3), os radicais e os
pesos. Na etapa final, basta verificar a testemunha de contradição
reconstruída. A verificação dos pesos dos 1.196 certificados de resíduo
também recompõe o domínio e as somas, usando a mesma construção do modelo.
Os arquivos auxiliares fornecem uma segunda rota de conferência dos
resultados, enquanto a análise das equações (L5) continua uma dependência
do modelo.

O teste independente `audita_cobertura.py` calcula os radicais a partir
dos coeficientes da polar, confere a parte afim em (w), resolve as
equações e recompõe as linhas e a soma declaradas nos certificados
forçados. A quantidade reproduzida fica em `audita_cobertura.json`.

Reproduzi os 20 certificados forçados e três de cada um dos quatro tipos
de autocorrelação, com 32 casos verificados ao todo. O piloto anterior
por cota de caracteres dá \(E_0\ge8192\) para uma das 340 polares. Para
esse mesmo identificador, o Claude obteve um sistema módulo quatro
inconsistente. A exclusão concorda pelos dois critérios.

## Posto da polar sem usar a lista de (L5)

Use as coordenadas (c_0,\ldots,c_{24}) da base do modelo `load_model`.
O coeficiente de (z_0z_1z_3z_4) no Pfaffiano do menor com índices
(0,1,3,4) é exatamente

```text
[z0 z1 z3 z4] Pf(B_{0134}) = c21 + c23 + c24.
```

Portanto a segunda equação de (W) segue diretamente de (Pf4).
No termo \(B_{01}B_{34}\), o coeficiente procurado é
\(c_{21}^2+c_{16}^2+c_{13}^2+c_{17}^2\).
Em \(B_{03}B_{14}\), vale \(c_{24}^2+c_{10}^2+c_{16}^2\).
Em \(B_{04}B_{13}\), vale \(c_{23}^2+c_{10}^2+c_{13}^2+c_{17}^2\).
A soma se reduz a
\(c_{21}+c_{23}+c_{24}\), pois os parâmetros estão em \(\mathbb F_2\).
No espaço inteiro de dimensão 25, a identidade do Pfaffiano (6\times6) é

```text
Pf6(B_z) = [z = 0] c24 (1 + c21 + c23).
```

Com (c_{21}+c_{23}+c_{24}=0), o produto vira
(c_{24}(1+c_{24})=0) no anel booleano. Assim, (Pf4) já força
(\operatorname{rank} B_z\le4) para todo (z). Fora de (z=0), isso
decorre também de (B_z z=0) por invariância pela meia-volta. Essa
invariância diz \(F_z(w+z)=F_z(w)\). Tomar a parte linear em \(w\)
dessa diferença dá \(B_z(z,\cdot)=0\).
O script `explora_W.py` verifica as identidades por interpolação exata
nos coeficientes dos Pfaffianos, de grau dois e três nas coordenadas (c).

Para a primeira forma \(c_4+\cdots+c_9+c_{22}\), reconstruí as equações
de (Pf4) e encontrei 1.272 topos admitidos por (Pf4), dos quais 96
estão fora desse hiperplano. Levantar esses 96 topos pelos quatro
parâmetros livres e exigir as duas derivadas mistas não nulas deixa
1.152 polares. Todas dão sistema (L5) inconsistente. A verificação
gera esses casos diretamente do modelo e das equações de (Pf4).
Ela independe da lista dos 3.984 e não enumera fases, mas ainda faz uma
varredura finita no espaço de topos. Uma identidade curta que force a
primeira equação de \(W\) nas classes mistas permanece em aberto.

### Reprodução

Use a base gerada pelo `base12.py` e os módulos do modelo em
`outputs/piloto-gauss-real/inputs_model`. O script
`explora_W.py` recompõe os Pfaffianos e testa a implicação de (L5)
somente nas polares mistas fora do primeiro hiperplano.
`audita_cobertura.py <pasta dos certificados> --all-forced`
reconstrói as 32 verificações de certificados descritas acima.
