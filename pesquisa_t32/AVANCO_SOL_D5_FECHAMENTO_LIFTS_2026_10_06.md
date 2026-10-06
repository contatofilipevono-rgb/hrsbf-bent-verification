# Fechamento exato dos 7 bits do núcleo quíntico

Data: 6 de outubro de 2026.

## Resultado

Para n=16, grau 5, o núcleo já identificado tem forma
\[
k(u,v)=h(u+v),\qquad h\in\mathcal H^{RS}_{8,5},
\]
e dimensão 7. Assim cada representante do quociente de dimensão 266 possui exatamente 128 lifts.

Em coordenadas x=(u,u+z), uma direção (a,b) vira (p,q)=(a,a+b). Se
\[
\delta_z=\operatorname{wt}(F_z(u)+F_{z+q}(u+p))-128,
\]
adicionar k troca o sinal da contribuição da fibra exatamente quando D_qh(z)=1. Portanto o lift h balanceia a derivada se e somente se
\[
\sum_z\delta_z(-1)^{D_qh(z)}=0.
\]

Escolhendo uma base h_1,...,h_7 e agrupando z pelo vetor
\[
(D_qh_1(z),\ldots,D_qh_7(z))\in\mathbb F_2^7,
\]
os 128 lifts são avaliados simultaneamente por uma FWHT de comprimento 128.

## Fato estrutural novo

Para todo q != 0, o mapa h -> D_q h tem posto 7 no espaço das quínticas homogêneas RS em 8 variáveis. Portanto qualquer setor não diagonal enxerga todos os sete graus de liberdade do núcleo; q=0 continua completamente invisível.

## Consequência computacional

O script exact_kernel_lift_scan_d5.py verifica uma representante de cada uma das 4.115 classes cíclicas de direções não nulas. A interseção dos conjuntos de lifts permitidos é exata. Sobreviver a todas as classes equivale a bentness pela caracterização por derivadas.

Se a interseção for vazia, o programa também produz um pequeno certificado de direções cuja interseção já elimina os 128 lifts.

Controles executados localmente:
- 0x602809: nenhum lift; a classe 0x0001 sozinha elimina os 128;
- candidato grande previamente auditado: nenhum lift;
- validação cruzada com pesos diretos de derivadas: coincidência exata.

Em amostragem exploratória, direções não diagonais de suporte pequeno foram filtros muito fortes. Isso é evidência para priorização, não teorema universal.

## Correção conceitual importante

O fato de 0x0001 eliminar muitos cosets não pode ser promovido a uma obstrução universal: se uma bent quíntica existisse, seu coset necessariamente teria um lift que balanceia essa direção. O alvo correto é estudar a geometria do subconjunto do quociente de 266 bits admitido simultaneamente por poucas direções pequenas, e procurar uma incompatibilidade algébrica entre essas condições.

## Próximo alvo

1. pesquisar somente no gauge de 266 bits;
2. usar fibras e derivadas diagonais como filtros invariantes;
3. aplicar o fechamento exato dos 128 lifts primeiro em direções pequenas;
4. estudar pares/trincas de direções pequenas como sistema algébrico, não apenas como filtro estatístico;
5. buscar uma identidade que torne a interseção vazia para todo representante do quociente.

Status: redução exata e reproduzível; inexistência quíntica geral ainda não provada.
