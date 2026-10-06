# Artigos e literatura — HRSBF Bent Verification

Este diretório centraliza a trilha bibliográfica usada na auditoria e no posicionamento do projeto. O objetivo é separar claramente: (i) resultados publicados; (ii) comparação com o teorema cúbico global em desenvolvimento; e (iii) questões de prioridade ainda abertas.

## Artigos principais

| Ano | Trabalho | Status | Relevância para o projeto |
|---|---|---|---|
| 2008 | Stănică & Maitra, *Rotation symmetric Boolean functions—count and cryptographic properties* | consultado | Fonte da conjectura sobre inexistência de HRS bent de grau > 2. |
| 2010 | Meng, Chen & Fu, *On homogeneous rotation symmetric bent functions* | PDF integral consultado | Resultados parciais de não existência; não substituem a prova cúbica global atual. |
| 2012 | Gao, Zhang, Liu & Carlet, *Constructions of Quadratic and Cubic Rotation Symmetric Bent Functions* | PDF integral obtido e auditado | Controle positivo: família cúbica RS bent não homogênea; contém acoplamento quadrático antipodal. |
| 2013 | Zhang & Gao, *On the conjecture about the nonexistence of rotation symmetric bent functions* | consultado | Restrições adicionais; requer cautela na interpretação de afirmações com termos de grau inferior. |
| 2017 | Cusick & Sanger, *Rotation symmetric bent Boolean functions for n=2p* | consultado | Critérios envolvendo short-cycle/antipodal em n=2p; precedente conceitual importante. |
| 2018 | Tokareva, *Algebraic normal form of a bent function: properties and restrictions* | PDF integral consultado | Restrições de suporte/ANF; não fornece a não existência cúbica universal atual. |
| 2026 | Sun, Shi, Liu & Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions* | PDF integral auditado | Resultados condicionais recentes; comparação essencial para escopo e novidade. |

## Regra de uso

Nenhuma alegação de prioridade absoluta deve ser feita apenas a partir deste índice. Para submissão, cada alegação de novidade deve ser confrontada com o texto integral das referências mais próximas.

## Gao–Zhang–Liu–Carlet 2012

Referência: G. Gao, X. Zhang, W. Liu, C. Carlet, *Constructions of Quadratic and Cubic Rotation Symmetric Bent Functions*, IEEE Transactions on Information Theory 58(7), 4908–4913 (2012), DOI 10.1109/TIT.2012.2193377.

O artigo constrói uma família específica de funções cúbicas rotation-symmetric bent não homogêneas e a coloca na classe Maiorana–McFarland. A família inclui explicitamente o termo quadrático antipodal
`sum_{i=0}^{m-1} x_i x_{m+i}`.
Isso funciona como controle positivo para a Antipodal Rule do manuscrito atual: não contradiz a não existência homogênea; mostra que bentness cúbica RS pode ocorrer quando o componente antipodal de grau 2 está disponível.

O PDF foi fornecido pelo autor do repositório durante a auditoria. O binário ainda não está armazenado neste diretório via integração GitHub; este índice registra sua obtenção e leitura sem alegar que o PDF está versionado.
