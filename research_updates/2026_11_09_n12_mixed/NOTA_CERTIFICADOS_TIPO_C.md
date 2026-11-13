# Duas fibras dão certificados para os três mapas residuais do tipo C

Os cálculos de Fable localizaram a obstrução nas fibras de rótulo de peso 1 e 2. O verificador abaixo usa as fibras 1 e 3, representantes das duas órbitas de rótulos. A rotação leva as condições nessas fibras às condições nos seus rótulos conjugados.

Nos quatro mapas abaixo, as condições de paridade dos momentos dessas fibras deixam um espaço afim de fase de dimensão 22. Os bits módulo 4 dos momentos reduzem esse espaço a dimensão 20 por duas equações lineares, sem quadráticas residuais. Sejam P₁ e P₃ os bits que ainda precisam se anular para que o peso da fase nas duas fibras seja 4 módulo 8. As identidades a seguir valem nesse espaço de dimensão 20, por comparação de coeficientes no anel booleano.

| Mapa | Identidade | Consequência |
| ---: | --- | --- |
| 447616277 | P₃ = 1 | Nenhuma fase bent |
| 447616370 | AP₁ + BP₃ = S | Toda fase compatível é afim em V₂ |
| 447616701 | LP₁ + (1+L)P₃ = 1 | Nenhuma fase bent |
| 447616730 | KP₁ + P₃ = 1+S | A assinatura de não afinidade em V₂ vale 1 |

Aqui S é o bit comum a todas as componentes não identicamente nulas da assinatura de não afinidade em V₂. Os multiplicadores A, B, L e K são afins. Cada linha usa a sua própria parametrização. O arquivo `v3_c_phase_certificate.py` reconstrói os quatro mapas, as bases e os polinômios, e verifica as identidades sem listar fases. Em particular, os dois mapas sem fase bent são excluídos mesmo sem exigir exclusividade. No mapa 447616370, a afinidade em V₂ decorre só das condições nas duas fibras, sem usar as fibras 0 e 7. Pelo critério já demonstrado para o tipo C, isso também força a anulação da polar na fatia r=111.

## Equações em até quatro formas lineares

As duas equações de peso dependem de no máximo quatro formas lineares da fase. Tome um espaço de formas que contenha as imagens das duas polares quadráticas e as duas partes lineares nas coordenadas originais. Restrinja a uma seção linear e substitua de volta para verificar a igualdade formal. Escrevendo as formas da base resultante como a, b, c, d, na ordem usada pelo verificador, as equações são:

| Mapa | P₁ | P₃ | Soluções após módulo 4 |
| ---: | --- | --- | ---: |
| 447616277 | 1+ab | 1 | 0 |
| 447616370 | 1+a(1+d) | 1+b(a+d) | 2¹⁷ |
| 447616701 | 1+b(1+a) | 1+a(1+d) | 0 |
| 447616730 | 1+c(1+b) | 1+a | 2¹⁷ |

Em 447616701 a primeira equação força a=0 e a segunda força a=1. Em 447616370, a primeira força a=1, d=0 e a segunda fixa b=1. A terceira forma c é livre. Juntando os momentos das fibras 0 e 7 e contando por somas de Gauss, ficam 24.576 fases bent em 447616370, todas afins em V₂. O controle 447616730 tem 16.384 fases bent.

## Contraexemplos à preservação da bentness pela translação em u

A translação u ↦ u+111 leva os mapas positivos 447615148 e 447616496 a 447615843 e 447616575, respectivamente. Nos dois mapas traduzidos, as fases que passam nas paridades de momentos das fibras 1 e 3 ainda têm dimensão 22. Nesse espaço, dois bits de momentos módulo 4 de primeira ordem somam identicamente 1. O verificador reproduz o transporte dos mapas e confere a contradição por comparação de coeficientes. Isso certifica algebricamente o contraexemplo de Fable e dá um segundo exemplo.

A verificação depende das bases finitas do modelo. A origem geométrica das formas lineares e dos multiplicadores ainda está em aberto.
