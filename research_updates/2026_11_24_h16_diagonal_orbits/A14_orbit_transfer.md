<a id="a14"></a>

### A14 - Transferência de bits de peso por órbitas e redução por multiplicadores em H16

**Lema geral.** Seja \(f\) bent em \(2h\) variáveis, invariante por uma transformação linear ortogonal \(R\) de ordem \(L=2^k\), \(k\ge1\). Então sua dual \(f^*\) é igualmente invariante. Ponha \(D=\ker(R^{L/2}-I)\). Fora de \(D\), todas as órbitas têm comprimento exatamente \(L\). Para um espaço linear \(E\) de dimensão \(d\ge h\) e um coset \(E+a\), ambos invariantes por \(R\), escreva \(Q=E^\perp\), \(F=2^{d-h}\). A fase \(a\cdot x\) é constante nas órbitas de \(Q\): \(R^{-1}a+a\in E\). Por Poisson, com normalização bent,
\[
 \mathrm{wt}(f|_{E+a})=B+F\,\mathrm{wt}((f^*+a\cdot x)|_Q),
 \qquad B=2^{d-1}-2^{h-1}.
\]
Defina \(w_D=\mathrm{wt}(f|_{(E+a)\cap D})\), \(w_D^*=\mathrm{wt}((f^*+a\cdot x)|_{Q\cap D})\), e sejam \(N,N^*\) os números de órbitas exteriores a \(D\) com valor 1 nas duas restrições. A identidade exata é
\[
 w_D+L N=B+F(w_D^*+L N^*),\qquad
 N\equiv\frac{B+F w_D^*-w_D}{L}\pmod F.
\]
A segunda fórmula exige primeiro a integralidade do quociente. Vale também com primal e dual trocadas. **Correção de normalização (auditoria posterior):** o termo \(B\) é indispensável para \(d>h\), porque a soma de sinais no complemento é multiplicada por \(F\), mas \(F|Q|=2^h\), não \(2^d\). Em H16, \(B\) é múltiplo de 128, de modo que as congruências de paridade, os dois primeiros bits e o teste de peso módulo 64 em cortes invariantes por \(R^4\) utilizados abaixo não se alteram. Não se deve omitir \(B\) para módulos maiores. Esta filtragem incorpora bits adicionais além da congruência apenas no espaço fixo. Para \(d=h\), a igualdade reduz a uma equação de paridade em ambos os conjuntos de órbitas; para \(d\ge h+1\), a paridade de \(N\) já não depende de \(N^*\). Quando o espaço fixo está determinado, cada bit de \(N\) é um polinômio nas entradas booleanas dos representantes das órbitas. Em particular os dois primeiros bits são \(\sum_i y_i\) e \(\sum_{i<j} y_i y_j\), respectivamente. Substitua as formas afins de ANF da família estudada. Se as variáveis livres têm tabela de direções \(v_j\) nos representantes, a parte polar do segundo bit na posição \(i,j\) é
\[
 (\mathrm{wt}(v_i)\mathrm{wt}(v_j)+\mathrm{wt}(v_i v_j))\bmod2.
\]
Logo é possível provar a redução a uma equação linear por igualdade de todos os coeficientes quadráticos, sem amostrar as funções da família.

**Certificado curto das quatro células mistas de H16.** Retome a parametrização de A10: 116 órbitas quárticas, \(c_{115}=0\), \(L(c)=c_{99}\). Nesta passagem, \(L(c)\) é a forma linear de A10, não o comprimento de órbita do lema geral. Escreva \(K=\sum_{j\in I_K}c_j\), onde
\[
 I_K=\{1,3,9,11,13,15,21,24,28,32,34,38,45,47,53,55,
 67,69,70,72,74,76,78,80,86,89,91,93,97,103,107,109\}.
\]
Considere o único corte linear de dimensão 12
\[
 E=\{x_0=x_1,\ x_4=x_5,\ x_8=x_9,\ x_{12}=x_{13}\}.
\]
Ele é invariante por \(R^4\); no seu interior há 64 pontos fixos pela meia-volta e 1008 órbitas exteriores de comprimento 4. Para toda bent, \(16\mid\mathrm{wt}(f|_E)\). Fixados os três bits \((a,b,c)=(c_{99},c_{57},c_{113})\), a restrição ao espaço fixo é constante em todas as 111 direções afins. Pela decomposição em órbitas e pelos coeficientes do segundo bit de peso, verifica-se exatamente (as oito células inteiras)
\[
 \mathrm{wt}(f|_E)\equiv8\bigl(c_{57}+c_{113}+c_{99}(K+c_{57})\bigr)\pmod{16}.
\]
O lado entre parênteses é calculado em \(\mathbb F_2\). O certificado computa todas as \(\binom{111}{2}\) partes polares, que são nulas, e todos os 111 coeficientes lineares em cada célula: iguais a zero para \(a=0\) e iguais a \(K\) para \(a=1\). A constante é \(b+c+ab\); o primeiro bit do peso de órbitas coincide sempre com o primeiro bit de \(-w_D/4\). Assim a identidade vale em toda a célula, e não somente na origem e nos pontos da base.

O multiplicador de coordenadas \(j\mapsto3j\pmod{16}\) preserva homogeneidade, simetria rotacional e bentness; permuta as 116 órbitas, troca 57 e 113, fixa 99 e 115 e preserva as formas \(L(c),K(c)\). Aplicar o mesmo corte à função transportada fornece a segunda identidade, com 57 e 113 trocados. Segue \(c_{57}=c_{113}\) para ambos os valores de \(c_{99}\); segue ainda \(K=c_{57}\) somente quando \(c_{99}=1\). Portanto os quatro setores mistos estão excluídos por dois cortes explícitos, sob as premissas iniciais de A10. É uma re-certificação independente das reduções históricas, não quatro novos setores. Não resolve a extensão de C5 para \(c_{99}=0\), cuja lacuna de recuperação foi apontada em A13.

**Quociente exato por multiplicadores.** Todos os oito multiplicadores ímpares de coordenadas preservam \(L,K\), fixam 99 e 115 e permutam o par \(\{57,113\}\). Além disso preservam a direção comum de dimensão 104 das fibras de A10. A verificação usa a permutação de todos os suportes monomiais e a igualdade do espaço tangente, não somente a transformação dos representantes. A ação nas 128 escolhas da camada é computada pela imagem da aplicação \(\Theta\). Com as 32 exclusões de A13 em \(B0\_11\) e C5 comprovada em \(B1\_11\), os números são:

| Célula | Fibras brutas restantes | Órbitas de equivalência | Tamanhos das órbitas |
|---|---:|---:|---|
| B0_11 | 96 | 36 | 8 de tamanho 1, 12 de tamanho 2, 16 de tamanho 4 |
| B1_11 | 64 | 16 | 16 de tamanho 4 |

Representantes mínimos de B0_11: 1, 2, 3, 5, 8, 9, 11, 13, 15, 19, 21, 22, 23, 27, 29, 31, 33, 34, 35, 37, 40, 41, 43, 45, 47, 51, 53, 54, 55, 59, 61, 63, 87, 93, 119, 125. De B1_11: 1, 3, 9, 11, 16, 18, 21, 23, 24, 26, 29, 31, 53, 55, 61, 63. Basta atacar 52 representantes desses dois setores residuais, em vez de 160 fibras brutas restantes (isso não inclui a auditoria pendente de B0_00). O conjunto excluído de A13 é estável, portanto a ação não gera novas exclusões para B0_11.

**Propagação por envoltórias afins de pré-imagens espectrais.** Para um perfil central fixado e uma fibra bruta, projete as 104 direções do primal nas seis diagonais \(z=\mathtt{ff,55,11,33,77,01}\). Seus postos são 4, 7, 13, 13, 14, 14. Enumere cada imagem e retenha precisamente as pré-imagens do peso exigido pelo Walsh da dual central. A envoltória afim de cada conjunto fornece todas as suas consequências lineares; puxe-as de volta à fibra global e repita a interseção local e a formação de envoltória até estabilização. Cada etapa é uma condição necessária, não uma equivalência de satisfatibilidade. Acrescente a lei de peso no corte \(x_0=x_4=x_8=x_{12}=0\) (dimensão 12, segunda paridade do número de órbitas novamente linear) e as duas leis anteriores. Para B0_11, as 1200 combinações sobreviventes de fibra e perfil central têm dimensões de envoltória 103 (512 combinações), 102 (176), 100 (112) e 99 (400). Para B1_11, as 6912 combinações sobreviventes têm dimensão 103. Assim algumas ramificações perdem cinco variáveis, reduzindo sua envoltória afim por fator 32; não se provou que qualquer dessas envoltórias contenha uma bent. A inclusão das somas periódicas da fase \(a=\mathtt{ff}\), cujo espectro foi enumerado sobre 16 órbitas afins com compatibilidade do primeiro bit de A13, não acrescentou exclusões em B0_11.

**Limites verificados e frentes descartadas nesta rodada.** A relaxação linear de paridades dos cortes invariantes, ampliada por 1000 submódulos livres de dimensão 8 para cada uma das rotações \(R^4,R^8\) (amostra determinística), contém 22536 cosets estáveis, 45072 equações de paridade e as relações de graus global e diagonal da dual. O posto final é 2297, mas não fornece equação puramente primal e deixa os 126 perfis centrais de A13. A amostra de 1024 cortes de dimensão 12 complementares a módulos livres de posto 1 de \(R^4\) fornece justamente as relações lineares recapturadas pelo corte E e pelo corte coordenado x0=x4=x8=x12=0. A amostra de 816 cortes não livres não acrescenta tais equações. No ramo B0_00, em que ambas as restrições centrais são nulas, a transferência exige \(64\mid\mathrm{wt}(f|_E)\) em qualquer desses 12-flats invariantes por \(R^4\). O teste dos dois primeiros bits da contagem de órbitas em 256 cortes livres dá uma linear e mantém possíveis os dois valores de K. Após substituí-la, o terceiro bit nesses mesmos cortes dá posto 44 cúbico e 1 quadrático, nenhuma nova linear e não demonstra K=0. Esse ramo permanece em auditoria. Nenhum resultado amostral precisa ser usado para as duas leis de corte ou para a ação dos multiplicadores.

O mesmo quociente de B0_00 no lado K=1, que ficou fora do algoritmo histórico, reduz suas 64 fibras brutas a 16 representantes: 1, 3, 9, 11, 21, 23, 29, 31, 33, 35, 41, 43, 53, 55, 61, 63. Essa redução é apenas por equivalência; não certifica o fechamento desse lado.

**Reprodução:** [verify_h16_two_cuts_and_multipliers.py](verify_h16_two_cuts_and_multipliers.py), autônomo (Python e NumPy). O modo padrão verifica a identidade de corte e o quociente por multiplicadores; `--full` reexecuta o certificado A13 de 32 exclusões e `--propagate` reproduz as envoltórias afins e suas dimensões. As experiências negativas acima são registradas pelo seu alcance exato e não são premissas desse certificado.
