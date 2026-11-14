# Teste amplo do funil de Poisson (andamento, 14/11/2026)

VM `bitj-96` (n2-highcpu-96). Entrada: os 3.984 polares compatíveis com (L5) (`polares_L5.txt`).

Funil por polar:
1. (L5) + (L3) lineares;
2. bits de Poisson de grau 2, interpolados e linearizados, iterados;
3. zeros comuns do sistema quadrático, por cobertura de vértices e eliminação vetorizada;
4. teste direto de Walsh nos sobreviventes: pré-filtro pela coluna b=0, depois o espectro completo.

Situação às ~11h: 3.937 de 3.984 processados, **todos mortos**:

| Etapa em que morre | Polares |
|---|---|
| (L5)+(L3) | 2.301 |
| linearização dos bits | 320 |
| Walsh direto nos sobreviventes | 1.316 |

Controle positivo: os 12 polares distintos das testemunhas bent continuam vivos na linearização.

Leitura:
- os bits de grau 2 são necessários, mas **não suficientes**: em ~1.300 polares o sistema quadrático tem zeros comuns (até ~7 milhões) e nenhum é bent;
- nos polares em que a contagem foi registrada, nenhum sobrevivente passou da coluna b=0 do espectro. Isso aponta para uma condição sobre o perfil das fibras z ↦ Σ_w (−1)^{f(z,w)}.

Validação do código: `teste_bentvec.py`, `teste_packed.py`, `teste_lote.py`. O último é um controle positivo com z·w mais direções afins, conferido contra a força bruta.
