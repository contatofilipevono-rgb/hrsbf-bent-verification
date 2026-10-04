# Auditoria final — 4 de outubro de 2026

## Parecer

Não foi encontrada uma nova falha bloqueante nas provas centrais da versão revisada. A evidência computacional foi reproduzida por uma segunda implementação. Isso não equivale a revisão externa por pares nem a certificação formal. Não recomendo tratar a versão como definitivamente pronta para submissão enquanto a comparação integral com Meng–Chen–Fu (2010), a definição da contribuição original e os dados editoriais dos autores estiverem pendentes.

## Provas revistas

- **Redução quadrática de ordem ímpar:** para T^m=I, m ímpar, P=sum(T^j) projeta em U=Fix(T) e V=U⊕ker(P). A polar invariante torna os dois espaços ortogonais. No radical da restrição ao complemento, a parte quadrática normalizada é linear e a invariância força sua anulação. O quadrado da soma de sinais no complemento é |K|·|rad(B|K)|, portanto não é zero. Assim, balanceamento equivale ao balanceamento na restrição a U. Constantes e polares degeneradas são permitidas.
- **Transferência para cúbicas:** as derivadas nas direções fixas têm grau no máximo dois e são invariantes. A caracterização de bent por derivadas balanceadas aplica-se então ao espaço fixo de dimensão t=2^s. Essa etapa não é uma extrapolação experimental de n=16.
- **Dobramento de órbitas:** o estabilizador de um suporte cúbico tem ordem 1 ou 3. O fator ímpar conserva a paridade da multiplicidade. Órbitas reduzidas de comprimento menor que t cancelam; as sobreviventes são geradores cúbicos completos, quadráticos completos ou a forma linear L. A órbita quadrática antipodal de comprimento t/2 não está incluída.
- **Injetividade em n=16:** uma função que zera nos representantes das órbitas completas zera nessas órbitas por simetria e nas curtas pelo lema de anulação no subespaço de período oito; logo sua ANF é zero. Esse passo foi explicitado no manuscrito.
- **Fibras em n=32:** o balanceamento depende da anulação de f no subespaço diagonal de meia dimensão. A condição no radical é uma disjunção em geral. Nos sete casos certificados, posto 14 e a direção já anulada reduzem-na a uma equação. A contradição exclui somente a família de parâmetro fixado de dimensão 120.

## Reprodução independente

Arquivo: auditoria_2026_10_04/auditoria_independente.py.
Dependências registradas: Python 3.12.14 e NumPy 2.3.5.
Comando: python auditoria_2026_10_04/auditoria_independente.py
Saída: JSON no mesmo diretório.
SHA-256 do script: 5bf31dacdc2d6ab3b56e0dedc0df77cdc8cdc4969937e3dea18a39cbe4f1d3ae.

A implementação não importa código dos verificadores anteriores. Enumera suportes cúbicos por colares de lacunas orientadas e calcula interseções sobre todos os 65.536 pontos, sem comprimir órbitas.

| Controle | Quantidade | Resultado |
|---|---:|---|
| Interseções de ordem 1,2,3,4 dos 43 geradores | 43 + 903 + 12.341 + 123.410 = 136.697 | zero violações |
| Comparações de avaliações escalares com vetorizadas | 2.818.048 | zero diferenças |
| Avaliações no subespaço de período oito | 11.008 | todas zero |
| Posto dos geradores | 43 | confirmado |
| Funções das bases t=2,4,8 | 2,8,2.048 | nenhuma bent |
| Pares invariantes quadráticos em dimensão quatro | 80.640 | zero violações |
| Transformações invertíveis de ordem ímpar em dimensão quatro | 11.025 | todas incluídas |
| Imagens de órbitas cúbicas em 24 dimensões | 15.680 | zero violações |

Para interseções de ordem k=1,2,3,4, os divisores de peso em tabelas completas são respectivamente 256,128,64,32. Na inclusão–exclusão, cada termo tem coeficiente (-2)^(k-1). Para k≥5, toda interseção já tem peso divisível por 16, pois é constante nas órbitas completas e zero nas curtas; o coeficiente também é divisível por 16. Portanto os testes de ordem até quatro bastam para concluir divisibilidade por 256 de todas as combinações. Não foram enumeradas 2^43 funções.

Controle negativo: a quadrática antipodal tem peso 32.640, congruente a 128 módulo 256. Isso impede estender a divisibilidade a toda função de grau até três. Outro controle: xyz sob uma rotação de três coordenadas impede estender o lema quadrático a grau três.

Os controles em dimensões quatro e finitas de dobramento complementam a revisão algébrica; não provam sozinhos os lemas gerais.

## Comparação bibliográfica e pendências

1. Sun–Shi–Liu–Fu (2026), DOI 10.1007/s10623-026-01848-4: texto integral fornecido pelo usuário e comparado. Há sobreposição; n=2p^a já é coberto pelo Corolário 2. O Teorema 6 tem expoente dependente de suporte, não uma exclusão uniforme de todos os suportes em n=32. Ver COMPARACAO_SUN_2026.md. A omissão de L na equação (21) foi testada separadamente, sem concluir que o teorema é falso.
2. Stănică (2008), texto integral em https://faculty.nps.edu/pstanica/research/rbent.pdf: Teorema 2 dá critérios de suporte específico ou de distância máxima. Não apresenta a exclusão uniforme de todos os suportes cúbicos para v₂(n)=1,2,3,4.
3. Zhang–Gao (2013), arXiv:1303.2282: critérios condicionados ao suporte; não basta para certificar novidade global.
4. Cusick–Sanger (2017), arXiv:1708.09313: o alcance específico consultado não equivale ao enunciado uniforme revisado.
5. Meng, Q.; Chen, L.; Fu, F.-W., **On homogeneous rotation symmetric bent functions**, Discrete Applied Mathematics 158(10), 1111–1117 (2010), DOI https://doi.org/10.1016/j.dam.2010.02.009. Referência e resumo confirmados na editora; o acesso ao texto integral falhou nesta auditoria (HTTP 403). Não foi alegada uma comparação integral com seus teoremas.

Para a contribuição, a formulação defensável é o alcance uniforme para cúbicas homogêneas em todas as dimensões pares não divisíveis por 32, acompanhado do certificado finito e da redução demonstrada. Sua prioridade precisa ser confrontada com o item 5 antes da submissão.

Confirmar autoria, afiliações, autor correspondente e declarações exigidas pela revista. Revisar a versão final da carta de apresentação. O resultado em n=32 continua parcial. Nenhuma alegação de resolução completa da conjectura deve permanecer.

## Alterações nesta etapa

Explicitada a injetividade, retirada menção a um rascunho Lean como parte dos arquivos acompanhantes e descrita a segunda implementação no manuscrito e README. O manuscrito revisado compilou em PDF. Código, JSON e este parecer foram registrados na mesma branch da PR de revisão.
