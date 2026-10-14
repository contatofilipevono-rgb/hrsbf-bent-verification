# Parecer científico — auditoria de originalidade da V1 (14/10/2026)

## Decisão editorial

**VALIDADE MATEMÁTICA: FAVORÁVEL, COM ESCOPO DELIMITADO.** A prova do adendo foi revisada e o certificado computacional foi reproduzido. **ORIGINALIDADE: NÃO CERTIFICADA GLOBALMENTE**, mas não foi encontrado enunciado idêntico para o limite uniforme de órbitas nos principais artigos integrais confrontados. **SUBMISSÃO ISOLADA: ainda não recomendada**, devido à modéstia relativa dos resultados e à necessidade de busca bibliográfica mais abrangente.

## Artigos conferidos, com localização exata

1. **Lei Sun, Zexia Shi, Jian Liu, Fang-Wei Fu (2026),** *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, Designs, Codes and Cryptography **94**, artigo 93, DOI https://doi.org/10.1007/s10623-026-01848-4. PDF completo de 22 páginas disponibilizado previamente na biblioteca do usuário, nome `s10623-026-01848-4.pdf`.
   - p. 2: levantamento dos resultados anteriores, inclusive um-orbita e algumas duas-orbitas de Stănică (2008), sem atribuir novidade a esses resultados.
   - p. 10, **Teorema 2**: exclusões via paridades de comprimentos de órbitas e classes de resíduos módulo 4.
   - p. 13, **Teorema 3**: desigualdades para distâncias de índices e subconjuntos evitados.
   - pp. 16–17, **Teorema 4**: restrições envolvendo números de índices pares/ímpares por gerador.
   - p. 18, **Teoremas 5 e 6**: exclusão cúbica a partir de derivadas.
   - pp. 19–20, **Tabela 1**: mapa de resultados anteriores e novos, *não contém* a fórmula `3r < 2^((d-1)/2)`.
   - **Leitura:** métodos distintos dos critérios de peso das fibras usados aqui, mas isso não impede implicações indiretas sobre subclasses. Logo, não reivindicar prioridade absoluta.
2. **Xiyong Zhang, Guangpu Gao (2013),** *On the conjecture about the nonexistence of rotation symmetric bent functions*, arXiv:1303.2282, https://arxiv.org/pdf/1303.2282. Texto de 7 páginas conferido. Em particular, **Teorema 3.1** e **Proposição 3.2** restringem padrões de suporte e sequências consecutivas. Não foi identificado o mesmo limiar uniforme de órbitas.
3. **T. W. Cusick, E. M. Sanger (2017),** *Rotation Symmetric Bent Boolean Functions for n=2p*, arXiv:1708.09313, https://arxiv.org/pdf/1708.09313. Escopo principal `n=2p` com `p` primo ímpar; exclusão de funções homogêneas de uma órbita em tal dimensão. Há sobreposição com o caso trivial de uma órbita, mas não o mesmo domínio de dimensões `n=2^k>=16`.
4. **Q. Meng, L. Chen, F.-W. Fu (2010),** *On homogeneous rotation symmetric bent functions*, Discrete Applied Mathematics **158**, 1111–1117, https://doi.org/10.1016/j.dam.2010.02.009. Resumo e sua contextualização em Sun et al. disponíveis; texto integral não auditado neste ciclo. **Não declarar comparação conclusiva** com esta referência.

## Teoremas e classes de rigor

**Prova analítica autocontida:** para `n=2^k>=16`, `d=2m+1` ímpar, `5<=d<=n/2`, e `r` órbitas monomiais distintas, vale `3r<2^m => não bent`. Isso estabelece a *condição necessária* `r>=ceil(2^m/3)` para uma eventual função bent na classe. Em `n=16`, com refinamentos combinatórios, `r<=2` excluído no grau 5, e `r<=3` no grau 7.

**Certificado finito exato:** grau 5 em `n=16`, `C(273,3)=3.353.896` triplas, `35` sobrevivem à fibra `0x01` e `0` às fibras `0x01` e `0x33`. A rotina `VERIFY_SPARSE_CERTIFICATES_V2.py` foi executada em modo normal e otimizado `-O`: ambos PASS. O controle positivo do lema verificou 255 fibras. O teste independente `check_anchor_identity.py` comparou diretamente a identidade de redução da fibra com 256 avaliações em cada uma das 273 + 715 = 988 órbitas dos graus 5 e 7; PASS.

**Sem prova de prioridade:** a comparação acima reduz a incerteza, mas não constitui levantamento bibliográfico exaustivo; é necessária análise integral de Stănică (2008), Meng–Chen–Fu (2010) e pesquisa por trabalhos de 2026 ainda não indexados.

## Orientação editorial

- **Não reivindicar** novidade na exclusão de uma única órbita, e nem a solução da conjectura geral.
- Se a V1 principal estiver matematicamente consolidada, incluir isto como apêndice enxuto sobre graus ímpares esparsos, de forma separada do teorema cúbico.
- Se desejar artigo independente, fortalecer além de três órbitas ou extrair uma nova obstrução estrutural que não seja apenas filtro necessário.
- Manter os certificados de Farkas de `n=32` explicitamente fora do escopo até localizar matriz, vetor `b` e convenção das órbitas.

## Proveniência e integridade

O pacote anterior `HRSBF_V1_ADENDO_V2_2026_10_13.zip` foi lido e seus scripts reexecutados neste ambiente. O presente pacote é **derivado e versionado separadamente**: os originais de V1, V2 e V3-C não foram alterados. Fontes externas são citadas por DOI/arXiv; o PDF Springer, de terceiro, não é redistribuído no ZIP.