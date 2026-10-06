# Diagnóstico de quínticas homogêneas RS em n=16

Foram testadas 4096 funções em uma amostra determinística (semente 20261006) do espaço de 273 órbitas quínticas. A amostra não é uma busca exaustiva.

- 147 tinham derivada na direção de todos os uns balanceada.
- 1630 tinham fibra complementar balanceada.
- 69 satisfaziam as duas condições.
- As 69 foram excluídas por outra fibra não nula desbalanceada, mediante avaliação direta de seus 256 pontos.

Uma função bent que se anula no subespaço diagonal exige balanceamento de todas as fibras não nulas. Esta necessidade explica as exclusões; não demonstra inexistência no espaço de 2^273 funções.

O caminho sugerido é procurar um conjunto pequeno de fibras cuja necessidade simultânea possa ser certificada para todo o espaço. O lema de descida de grau não deve ser assumido: em n=8 há derivadas balanceadas de quínticas homogêneas RS com grau exatamente quatro.

O programa usa apenas a biblioteca padrão e CPU. A100 não foi necessária. Execute `python3 diagnostico_quinticas_n16.py` e compare a saída com `diagnostico_quinticas_n16.json`.

