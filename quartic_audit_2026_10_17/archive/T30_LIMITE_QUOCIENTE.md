# T30: a sexta condição não reduz sozinha o quociente T27

## Resultado

T28 exclui muitas funções do espaço completo, mas **não elimina nenhum estado adicional do quociente de dados usado por T27**. Todo estado que admite uma função satisfazendo as cinco condições anteriores também admite funções com os dois valores do sexto bit.

Logo, aplicar T28 apenas ao representante canônico de um estado seria um filtro incorreto: outro representante do mesmo estado pode passar. O domínio T27 de 325.074.944 estados permanece válido, sem redução adicional decorrente apenas de T28.

## Certificado explícito

Considere as duas alterações nos coeficientes originais:

`d=e75`,

`e=e42+e81+e94+e106`.

Cada uma representa uma função homogênea quártica que se anula em todos os pontos das cinco fibras z∈{0,85,170,255,51}, nas quais os pontos são (u,u+z), u∈F₂⁸. Portanto as quatro funções f, f+d, f+e, f+d+e representam exatamente o mesmo estado T16/T27.

Essas alterações preservam individualmente c115, c57, c113, c99, a paridade L da terceira lei, todas as nove formas lineares que compõem Q4 e a paridade da quinta condição. Logo preservam as cinco condições e não trocam os dois ramos usados em T28.

Se P_b é o polinômio reduzido do sexto bit no ramo b, a verificação simbólica completa dá, em ambos os ramos,

`D_d D_e P_b = 1`.

Assim a soma binária dos quatro valores de P_b é um. Entre os quatro há exatamente um ou três valores um. Existem sempre valores zero e um no mesmo estado do quociente. Isso prova o resultado sem amostragem.

## Reprodução e implicação

`VERIFICAR_LIMITE_QUOCIENTE_T30.py` reconstrói as órbitas de quartetos, confere 2.560 avaliações nas fibras, verifica a preservação de todas as formas pertinentes e calcula as duas derivadas mistas nos polinômios completos. Usa somente Python padrão e `T28_SEXTA_CERTIFICADO.json`.

O certificado não diz que todo estado T27 tem uma função bent. Mostra apenas que a sexta condição, isoladamente, não consegue distinguir quais estados ainda podem ter. Para obter ganho nessa representação seria necessário aumentar os dados preservados ou combinar T28 com outras condições sobre os representantes de cada estado.

Esse limite operacional complementa o limite global de T29: os resultados tratam espaços diferentes e não se contradizem.
