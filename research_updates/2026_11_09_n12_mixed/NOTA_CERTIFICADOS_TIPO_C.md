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

A verificação depende das bases finitas do modelo. A origem geométrica dos multiplicadores ainda está em aberto.
