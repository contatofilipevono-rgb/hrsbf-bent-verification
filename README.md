# Pesquisas de Filipe Vono — funções bent e formalização

Entrada principal para os resultados, materiais de reprodução e acervo histórico. Atualizado em **8 de novembro de 2026**, com conferência das versões públicas do Figshare.

## Resultados publicados como preprints

| Trabalho | Resultado e alcance | Versão de referência |
|---|---|---|
| **Antipodal / cúbicas RS** | Toda função bent simétrica por rotação de grau ≤ 3, em dimensão par positiva, contém a órbita quadrática antipodal. Consequência: não existe bent RS homogênea cúbica em **nenhuma dimensão par positiva**. | [Figshare v4](https://doi.org/10.6084/m9.figshare.34165260.v4), publicada em 08/11/2026 |
| **H12 / quárticas RS** | Não existe bent RS homogênea de grau quatro em **12 variáveis**. O resultado cobre a família concreta dos 43 coeficientes de órbitas quárticas. | [Figshare v2](https://doi.org/10.6084/m9.figshare.34737294.v2), publicada em 31/10/2026 |

Os dois registros são **preprints**, não artigos anunciados como aceitos por periódico. Formalização e certificados não estabelecem, por si, prioridade bibliográfica.

**Comece pelo [catálogo de resultados e evidências](docs/RESULTADOS_ATUAIS.md).** Ele distingue os teoremas, os registros formais, as verificações computacionais e as questões abertas.

## Antipodal / cúbicas: versão atual

No [Figshare v4](https://doi.org/10.6084/m9.figshare.34165260.v4), use:

- `Antipodal_V4.pdf`: manuscrito atual, com a segunda prova por descida de Jordan no Apêndice B;
- `Antipodal_V4_pacote.zip`: fontes editáveis e controles finitos da prova alternativa;
- `ESM_1.zip`: fontes Lean 4.15.0, dependências fixadas, controles finitos e registros de verificação.

O suplemento identifica o commit-fonte `6dd183685ef8a5b033c1bcf8733496d57b853cc7` e registra compilação do projeto e checagem dos enunciados/axiomas em **27/10/2026**. Esses registros cobrem a prova original. A prova de Jordan ainda aguarda formalização em Lean.

**A restrição “32 não divide n” pertence à etapa anterior por divisibilidade. Ela não limita o teorema antipodal atual.** Os certificados antigos de t=32 continuam úteis como resultados sobre famílias específicas, mas já não definem a fronteira do problema homogêneo cúbico.

## H12: versão atual e reprodução

- [Artigo e pacotes atuais — Figshare v2](https://doi.org/10.6084/m9.figshare.34737294.v2).
- [Enunciado formal e evidências da integração final](research_updates/2026_10_20_final_integration/CONCLUSAO_FORMAL_H12.md).
- [Guia da linha quártica](quartic_audit_2026_10_17/README.md).
- [Enumeração GPU separada](https://github.com/contatofilipevono-rgb/h12-gpu-verification).

A exclusão formal, as contagens externas de soluções e o replay Python têm escopos distintos. A versão 2 não reivindica um teorema Lean das contagens exatas. A reconstrução integral limpa da distribuição Lean mínima permanece uma limitação declarada. O resultado não cobre H(16,4), dimensões gerais ou todas as funções de grau ≤ 4.

## Outras linhas

| Linha | Onde consultar | Status |
|---|---|---|
| V2 — índice relaxado / famílias EA | [Acervo V2](ACERVO_CIENTIFICO/V2/README.md) | Pesquisa com certificados e snapshots formais distintos; há uma bicondicional irrestrita identificada como falsa. |
| V3-C — famílias por digrafos | [Escopo e limites](ACERVO_CIENTIFICO/V3-C/README.md) | Resultados formais reportados sob hipóteses específicas; novidade editorial não estabelecida por este índice. |
| Foulkes (3,5) | [Repositório próprio](https://github.com/contatofilipevono-rgb/foulkes-3-5) | Estrutura inicial Lean e lema auxiliar; sem formalização completa de Foulkes–Howe ou validação Lean do certificado inteiro. |
| Buscas em dimensões maiores | [Panorama de 07/11](research_updates/2026_11_07_panorama/PANORAMA_ATUAL.md) | Frente distinta; exclusões de subclasses e buscas sem sobreviventes não resolvem os casos gerais. |

## Materiais históricos e navegação

- [Mapa dos diretórios, versões e pendências](docs/ORGANIZACAO.md).
- [Método cúbico anterior e comandos de reprodução](docs/LEGADO_CUBICO.md).
- [Acervo científico de 14/10](ACERVO_CIENTIFICO/README.md), com fontes de V1/V2/V3-C e manifesto de proveniência.
- [Artigos e trilha bibliográfica](artigos/README.md).

Os manuscritos, certificados, dados e fontes formais históricos permanecem nos caminhos originais. As instruções antigas de compilação devem ser lidas com a versão e o checkpoint correspondentes; um log antigo não representa nova execução.
