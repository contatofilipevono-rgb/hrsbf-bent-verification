# H16 — retomada de B0_00 na camada cúbica nula

A subfamília tem dimensão 104. Os polares têm 48 coordenadas, e o núcleo tem dimensão 56. Apenas 46 direções do núcleo afetam a energia de Walsh das fibras. As dez restantes alteram constantes por fibra e podem afetar o espectro Walsh global.

## Resultados verificados

- O censo exato até peso 9 na base polar fornecida examinou 2.142.281.575 vetores. Os 407 polares que passaram pelos Pfaffianos e admitiram o mesmo levantamento para seis alvos e dois resíduos assinados foram excluídos pelas 35 autocorrelações diagonais, para todo levantamento. Destes, 136 passam pelas paridades iniciais.
- O censo global dos cortes de balanceamento em z=0x01 e z=0xff e dominância em t=0xff foi reproduzido independentemente. Restaram 27.563.943.424 de 2^37 classes, uma exclusão de 79,9446%. Os dois balanços já integram os cortes curtos.
- As duas bases físicas geram a mesma família. A testemunha 0xf891cf5cacfa na base do relatório corresponde à máscara física 0x97040000008b1d5d562fa4 e ao polar 0xe0df9e0a9fb7 na base do censo. Passa pelos seis alvos, mas viola o coeficiente z=0x1f do Pfaffiano complementar a (0,2). Nenhum levantamento satisfaz os seis alvos e os dois resíduos em conjunto.
- A subfamília completa segue aberta. A tentativa de SAT completo foi inconclusiva.

## Retomada com orçamento curto

Solicite ao responsável os ZIPs H16_Conciliacao_Censo_Massa_Diagonal.zip e H16_B0_00_Censo_Polar_Peso9.zip. Rode cruzar.py como controle. Dedique até 15 minutos de CPU a um piloto acima do peso 9. Aplique primeiro os Pfaffianos e as seis projeções, em seguida o quociente de posto 13 para os oito cortes com levantamento comum e, por fim, as 35 autocorrelações nas 46 direções efetivas.

Se a energia conjunta admitir solução, valide por FWHT inteira nas 65.536 entradas. Considere as dez direções que alteram as constantes por fibra ao procurar uma função bent. Registre comandos, tempos, contagens, cobertura e máscaras físicas nas 116 órbitas. Amplie para GitHub Actions se o piloto justificar.
