# Auditoria da proposta diferencial e antipodal

A identidade de Euler para derivadas canônicas de uma ANF homogênea e a expressão das segundas derivadas são corretas. As conclusões de anulação e de obstrução à bentness contêm erros. Os contraexemplos abaixo foram verificados pelo programa VERIFICAR_ROTA_ANTIPODAL_T69.py, resultado PASS.

## Restrição correta de Q8

Escrevendo yi=xi=x(i+8), a restrição ao subespaço proposto é exatamente

Q8|V7 = c57(y1+y7) + c99(y2+y6) + c113(y3+y5) + c115*y4.

Sob as três leis T20, isso se torna

Q8|V7 = a(y1+y3+y5+y7) + b(y2+y6).

Portanto, c115=0 não implica anulação. Mesmo no núcleo, a restrição pode ser não nula. Um exemplo é c=0x687c33fc2d21fde00ca287b7fc7f0, que passou pelas nove condições verificadas no T66: para x=e1+e9, temos Q8(x)=1.

As contagens de 46 órbitas visíveis, 45 multiplicidades dois e uma multiplicidade um estão corretas. O erro é interpretar toda multiplicidade dois como um par trocado pela rotação de oito posições. Existem sete pares fixos {i,i+8}; eles contribuem os termos lineares acima na restrição.

## Forma polar e posto

A restrição de Q8 é linear, logo sua forma polar realmente se anula em V7. Essa afirmação é diferente de Q8 se anular em V7.

Uma forma alternante não degenerada em dimensão 14 admite subespaços isotrópicos de dimensão 7. Assim, essa isotropia não proíbe posto 14. Encontramos um exemplo de posto 14 no núcleo: c=0x538cd1007cc3e3521e80fcd78aa46. Na amostra de 4096 nove-passantes, 1161 matrizes Q8 tinham posto 14. Isso não demonstra a ausência de outras restrições geométricas.

A aplicação c→Q8 não é um a um: ela vê 46 coeficientes distintos e deixa 70 invisíveis. A afirmação de injetividade para uma segunda derivada fixa precisa ser retirada.

## Critério sobre estruturas lineares

O balanceamento de todas as primeiras derivadas não implica ausência de direções em que uma segunda derivada seja constante. Toda primeira derivada já tem sua própria direção como estrutura linear trivial.

Há também contraexemplos não triviais: em oito variáveis, f(x,y)=soma xi*yi + y0*y1*y2*y3 é bent de grau quatro, mas D_x0 f=y0 e D_x1 D_x0 f=0. O verificador calculou o espectro completo, com todas as amplitudes iguais a 16. Essa função não é apresentada como homogênea ou invariante por rotação; ela refuta o critério geral de bentness invocado no texto.

Finalmente, a identidade soma xi*D_ei f=0 é uma relação com coeficientes variáveis no anel booleano. Não deve ser confundida com dependência linear sobre F2 entre as 16 funções derivadas.

A geometria das derivadas continua sendo uma possível fonte de filtros, mas os argumentos apresentados não constituem uma obstrução global. A taxa amostral de 92,7% não foi auditada, pois o texto não fornece os dados correspondentes.
