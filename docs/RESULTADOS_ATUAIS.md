# Catálogo de resultados e evidências

Conferência documental: **08/11/2026**. [Entrada principal](../README.md) · [Organização e pendências](ORGANIZACAO.md)

## 1. Antipodal e inexistência homogênea cúbica

**Referência atual:** [Figshare 34165260, versão 4](https://doi.org/10.6084/m9.figshare.34165260.v4).

**Enunciado:** para todo n par positivo, uma função bent RS de grau algébrico no máximo três contém a órbita quadrática antipodal P_n. Portanto nenhuma função RS homogênea de grau três é bent.

**Evidência publicada:** manuscrito V4 de 08/11, com uma segunda demonstração por descida de Jordan no Apêndice B, e suplemento `ESM_1.zip` com fontes Lean 4.15.0 e registros de compilação/checagem de 27/10. O commit-fonte indicado é `6dd183685ef8a5b033c1bcf8733496d57b853cc7`.

A formalização cobre a prova original, incluindo a redução de ordem ímpar usada nas duas demonstrações. A descida de Jordan ainda aguarda formalização. O suplemento registra os teoremas `HRSBF.Antipodal.universal_antipodal` e `HRSBF.Antipodal.no_homogeneous_cubic_rotation_symmetric_bent`, incluindo interfaces com módulo absoluto de Walsh. As listas de axiomas registradas contêm somente `propext`, `Classical.choice` e `Quot.sound`, sem `sorryAx`.

**Limites:** não conclui a conjectura homogênea para todos os graus maiores que dois. Funções cúbicas RS não homogêneas bent podem existir. Não confundir o teorema geral com os controles computacionais finitos do suplemento. A conferência documental de 08/11 leu os registros distribuídos; não recompilou Lean nem certificou prioridade bibliográfica.

**Histórico:** [V1 de 14/10](../ACERVO_CIENTIFICO/V1/README.md) e [etapa por divisibilidade](LEGADO_CUBICO.md). Suas pendências datadas não substituem o estado publicado em v4.

## 2. H12 — inexistência homogênea quártica em doze variáveis

**Referência atual:** [Figshare 34737294, versão 2](https://doi.org/10.6084/m9.figshare.34737294.v2).

**Enunciado:** nenhuma das funções determinadas pelos 43 coeficientes das órbitas quárticas cíclicas em doze variáveis é bent.

| Tipo de evidência | O que estabelece | Referência |
|---|---|---|
| Exclusão formal Lean | `H12Final.no_bent_quartic` exclui bentness para todo `c : BitVec 43`; há consequências espectrais. | [Conclusão e fontes finais](../research_updates/2026_10_20_final_integration/CONCLUSAO_FORMAL_H12.md) |
| Enumeração externa das cartas, registrada em 22/10 | 46.912, 46.400 e 70.976 soluções: total 164.288; todas rejeitadas. Essas contagens não são anunciadas como teorema formal Lean. | Pacote `H12_revised_reproducibility_v2.zip` do Figshare v2 |
| Replay Python de certificados | Conferência computacional separada; não equivale a executar o kernel Lean. | Pacotes de verificação do Figshare v2 |
| Busca GPU separada, registrada em 02/11 | Enumeração das 2^43 escolhas; 34.748 sobreviventes dos filtros GPU e zero bent após Walsh completo; registro com `overflow: false`. | [Repositório GPU e resultados](https://github.com/contatofilipevono-rgb/h12-gpu-verification) |

**Não somar contagens de etapas diferentes.** Os 3.308 rejeitados em frequências não nulas na enumeração das cartas não são os 34.748 sobreviventes da busca GPU separada. O [guia quártico histórico](../quartic_audit_2026_10_17/README.md) também conserva números de uma busca anterior.

**Limites:** H12 não prova H16 nem a inexistência quártica em dimensões gerais. A identificação da família usa a base explícita das 43 órbitas; não se anuncia no módulo final um novo teorema abstrato de representação de toda ANF. A versão 2 declara que uma reconstrução integral limpa da distribuição Lean mínima ainda não foi concluída. Preservar essa ressalva mesmo havendo registros históricos da integração final.

## 3. V2 e V3-C

Estas linhas tratam de índices relaxados e equivalência EA e devem permanecer separadas dos resultados de inexistência RS.

- [V2](../ACERVO_CIENTIFICO/V2/README.md): o certificado finito do adendo de 13/10 não é uma formalização Lean integral. A bicondicional irrestrita “EA-indecomponível se e somente se digrafo conectado após Q arbitrário” foi identificada como falsa; não reutilizá-la como teorema.
- [V3-C](../ACERVO_CIENTIFICO/V3-C/README.md): consultar [PROOF_STATUS](../ACERVO_CIENTIFICO/V3-C/PROOF_STATUS.md) e os enunciados específicos. A classificação por isomorfismo vale para representantes canônicos; não classifica automaticamente perturbações quadráticas arbitrárias. A cópia no acervo não significa nova compilação em 08/11.

## 4. Foulkes (3,5)

[Repositório próprio](https://github.com/contatofilipevono-rgb/foulkes-3-5). A fonte pública contém o lema auxiliar `transport_preimage`, não a aplicação Foulkes–Howe completa. O README relata um certificado aritmético em pacote offline; os dados e o módulo integral ainda precisam ser importados e conferidos. Não anunciar resolução de Foulkes ou certificado inteiro validado em Lean com base nessa estrutura inicial.

## 5. Pesquisa em aberto e itens não localizados

O [panorama de 07/11](../research_updates/2026_11_07_panorama/PANORAMA_ATUAL.md) mantém separados p=17, Q1, período 20 e H16. As exclusões de subclasses e amostras não são resolução dos casos gerais.

A nota de grau ímpar / dicotomia 8∣n mencionada no planejamento não foi identificada como manuscrito atual separado na árvore principal examinada. Seus enunciados, provas e referências precisam ser localizados antes de promovê-la a resultado deste catálogo. Isso não afirma que o trabalho inexista em outras branches ou arquivos.

## Como citar e atualizar

As [entradas BibTeX](CITACOES.bib) facilitam a citação. Citar as versões com DOI acima, não um rascunho antigo com nome semelhante. O snapshot [FIGSHARE_REFERENCIAS.json](FIGSHARE_REFERENCIAS.json) registra os identificadores e arquivos conferidos. Antes de atualizar uma afirmação, conferir o enunciado, a versão e o tipo de evidência; conservar o histórico e registrar a data da mudança.
