# Auditoria bibliográfica dirigida — V1

Data: 19/10/2026. Objetivo: validar os seis registros citados e o alcance das comparações usadas na introdução. Não é uma busca exaustiva de prioridade.

## [1] Stănică–Maitra, 2008

Título, autores, volume 156(10), páginas 1567–1580 e DOI `10.1016/j.dam.2007.04.029` conferidos no registro da editora e em Crossref.

O texto integral depositado no repositório institucional NPS/Calhoun foi recuperado e lido na passagem relevante. A Conjectura 12, página 17 do PDF depositado (incluindo a folha de rosto do repositório), formula a inexistência de bent homogêneas simétricas por rotação de grau maior que dois. A forma “grau pelo menos três” é equivalente porque o grau é inteiro. Não se confundiu essa conjectura com as conjecturas de peso ou não linearidade de funções de uma única órbita.

- [Página da editora](https://doi.org/10.1016/j.dam.2007.04.029).
- [Cópia institucional do autor](https://calhoun.nps.edu/server/api/core/bitstreams/ad28a760-b534-42ee-96c4-a366da34efd8/content).
- SHA256 da cópia lida: `7edd98d7dcc2a7eb0434cd538b1ab376e4fa3abf30d1b132b0795cf846b61b86`.

O PDF externo não é redistribuído nesta branch.

## [2] Meng–Chen–Fu, 2010

Título, autores, volume 158(10), páginas 1111–1117 e DOI `10.1016/j.dam.2010.02.009` confirmados em metadados Crossref. A referência também consta do artigo primário de Sun, e um critério de intervalos é reproduzido como Teorema 3.10 de Cusick–Sanger.

Não houve leitura integral nova desse artigo nesta etapa; não se afirma uma auditoria de todos os seus resultados. A introdução o identifica como antecedente, sem usá-lo como premissa da demonstração.

- [DOI](https://doi.org/10.1016/j.dam.2010.02.009).

## [3] Zhang–Gao, 2013

Autores, título e data conferidos na fonte primária [arXiv:1303.2282](https://arxiv.org/abs/1303.2282), versão 1 de 10/03/2013. Mantido como preprint; não foi inventada publicação em periódico ou DOI editorial.

A leitura foi confrontada com Cusick–Sanger, que registram que o Teorema 3.1 deste preprint é falso. Não foi reconstruído nesta etapa um contraexemplo independente a esse critério. A versão revisada informa a objeção e não usa o critério em sua cadeia lógica. A objeção não autoriza declarar falso todo o preprint nem aceitar automaticamente os demais resultados.

## [4] Cusick–Sanger, 2017

Fonte primária [arXiv:1708.09313](https://arxiv.org/abs/1708.09313), versão 1 de 30/08/2017. O Corolário 2.8 cobre necessidade antipodal quadrática; o Teorema 3.8 implica inexistência cúbica homogênea para n=2p com p>2 primo. A introdução reconhece esse antecedente específico e não o apresenta como novo. O aviso sobre [3, Teorema 3.1] aparece na seção 2. A referência permanece identificada como preprint.

## [5] Sun–Shi–Liu–Fu, 2026

Autores Lei Sun, Zexia Shi, Jian Liu e Fang-Wei Fu; volume 94(4), artigo 93; publicado em 13/04/2026; DOI `10.1007/s10623-026-01848-4`, conferidos na [editora](https://link.springer.com/article/10.1007/s10623-026-01848-4) e em Crossref.

Foi reaberto o PDF de 22 páginas fornecido pelo usuário. O Teorema 5 assume condições adicionais sobre geradores e valuations; o Teorema 6 trata famílias de padrões fixos em certas dimensões divisíveis por uma potência de dois; o Corolário 2 impõe condições aos fatores primos. Esses enunciados não são a necessidade antipodal grau≤3 em toda dimensão positiva par. A comparação não afirma prioridade absoluta.

O arquivo local é `C:/Users/Valer/Downloads/s10623-026-01848-4.pdf`; a cópia da editora não é redistribuída.

## [6] Rothaus, 1976

Título, volume 20(3), páginas 300–305, ano e DOI `10.1016/0097-3165(76)90024-8` conferidos na [editora](https://doi.org/10.1016/0097-3165(76)90024-8) e em Crossref. O artigo atual demonstra a identidade de autocorrelação/Fourier que usa, evitando depender de um lema externo sem enunciá-lo.

## Classificação MSC

A [base oficial MSC2020 da AMS](https://mathscinet.ams.org/mathscinet/msc/msc2020.html?t=94D10) identifica 94D10 como Boolean functions e remete a 06E30. Portanto o código sugerido na revisão está correto e foi mantido. Não se aplicou por memória uma codificação de edição anterior do MSC.

## Conclusão e limites

Os registros bibliográficos e o enunciado da conjectura agora têm proveniência identificada. A introdução distingue um caso cúbico anteriormente resolvido de sua afirmação universal e informa uma objeção a um critério citado que não é usado. A prova principal é autossuficiente.

Ainda não existe uma auditoria exaustiva de prioridade de toda a literatura. A validação de título/DOI não certifica a correção de cada artigo; a leitura de alguns teoremas não equivale à leitura integral de todos os trabalhos. Os metadados brutos estão em `CROSSREF_METADATA.json`.
