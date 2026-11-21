# Rigidez de Walsh em 32 variáveis módulo 127

Revisão das Seções 7–12 do manuscrito recebido no pacote de auditoria. O texto inclui a transferência da obstrução quártica módulo 64 e novos resultados sobre o caso global.

- Seção 7. A obstrução cúbica agora usa o símbolo de \(B_4\). A cota conjunta no regime quártico usa as Seções 4.1–4.2 do preprint módulo 17, com a transferência exibida no Apêndice B.
- Seções 7B–10 e A1. Foram explicitadas as hipóteses de energia, as restrições em fibras, a fase correta em \(F^c\), as cotas de grau, a lista de vieses cúbicos e os casos de semiposto quatro.
- Seção 10.6. A hipótese residual já exclui qualquer contração cúbica do símbolo quártico que se anule em codimensão até três. Também exclui símbolos quárticos escritos como soma de até quatro produtos de formas de graus positivos. Exclui ainda zeros do símbolo em subespaços físicos lineares de codimensão até cinco. As demonstrações vieram da análise matemática independente do Astra e foram verificadas antes da integração.
- Seção 10.7. As exceções detectadas módulo 32 geram afimmente o espaço. Se existir um subespaço de autocorrelação nula de dimensão 16, o espectro excepcional projeta bijetivamente sobre o quociente correspondente.

O caso global \(D=h=0\) continua em aberto. A exclusão em codimensão quatro no problema das contrações permanece por demonstrar.

Na auditoria anterior, a observação sobre um fator 16 indevido no denominador de energia foi um erro de leitura da numeração das linhas. A fórmula original tinha a normalização correta.

Execute, com Python 3 e a biblioteca padrão, os três verificadores:

    python3 verify_mod127.py
    python3 verify_mod127_ramo_F.py
    python3 verifica_mod127_auditoria.py

Esses programas reproduzem desigualdades e tabelas finitas. As identidades exteriores e as reduções geométricas são demonstradas no manuscrito.
