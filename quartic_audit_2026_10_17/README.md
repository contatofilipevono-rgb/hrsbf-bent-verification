# H12 — auditoria quártica e materiais de reprodução

Atualizado em **08/11/2026**. [Catálogo de resultados](../docs/RESULTADOS_ATUAIS.md) · [Mapa do repositório](../docs/ORGANIZACAO.md)

## Resultado e versão atual

**Não existe função bent homogênea de grau quatro, simétrica por rotação, em doze variáveis.** A referência atual é o [preprint Figshare v2](https://doi.org/10.6084/m9.figshare.34737294.v2), publicado em 31/10/2026.

H(n,4) designa o espaço gerado pelas órbitas de monômios quárticos. Em n=12 a base tem 43 órbitas e 2^43 escolhas de coeficientes. O resultado não abrange todas as funções de grau ≤ 4, H(16,4) ou dimensões gerais.

## Evidências: ler separadamente

| Evidência | Entrada |
|---|---|
| Teorema formal sobre toda a base concreta | [Conclusão da integração final](../research_updates/2026_10_20_final_integration/CONCLUSAO_FORMAL_H12.md) |
| Artigo, suplemento e distribuição revisada | [Figshare v2](https://doi.org/10.6084/m9.figshare.34737294.v2) |
| Explicação do desenvolvimento original | [MATHEMATICAL_EXPLANATION.md](MATHEMATICAL_EXPLANATION.md), [CLAIMS.md](CLAIMS.md), [ADVERSARIAL_AUDIT.md](ADVERSARIAL_AUDIT.md) |
| Replay Python dos certificados | [cpu_replay/README.md](cpu_replay/README.md) |
| Enumeração GPU separada, registrada em 02/11 | [h12-gpu-verification](https://github.com/contatofilipevono-rgb/h12-gpu-verification) |

A integração final de 21/10 instanciou as três raízes concretas em `H12Final.no_bent_quartic`. Os checkpoints anteriores que dizem “cobertura pendente” pertencem ao desenvolvimento e não descrevem o estado final. As listas de axiomas e fontes finais estão vinculadas na conclusão acima.

A versão 2 separa a exclusão formal da enumeração externa de 22/10: 46.912, 46.400 e 70.976 soluções nas três cartas, total 164.288; 160.980 rejeitadas em W(0) e 3.308 em frequências não nulas. Não reivindica um teorema Lean dessas contagens exatas.

**Limitação de reprodução:** a versão 2 declara que a reconstrução integral limpa da distribuição Lean mínima não foi concluída. Compilar lemas isolados, reproduzir um prefixo ou ler logs antigos não resolve essa limitação. Esta atualização de navegação não executou Lean ou GPU.

## Reprodução

Para o pacote revisado, seguir as instruções de `H12_revised_reproducibility_v2.zip` no Figshare. Os arquivos originais de fontes e os registros finais permanecem associados ao depósito.

Para o replay histórico em Python 3.10 ou posterior, a partir deste diretório:

```sh
python verify_linear_laws.py
python verify_periodic_reduction.py
python verify_manifest.py
python cpu_replay/verify_model.py
python cpu_replay/verify_certificate.py
python verify_complement_pair_filters.py
```

O replay confere objetos computacionais; não substitui a execução do kernel Lean. Consulte o guia do replay para entradas e dependências.

O projeto `lean/` usa Lean 4.35.0. Um `lake build` da biblioteca padrão não deve ser apresentado automaticamente como reconstrução de todas as dependências e de toda a árvore final. Para o escopo final, usar os commits, fontes e registros indicados na [conclusão formal](../research_updates/2026_10_20_final_integration/CONCLUSAO_FORMAL_H12.md).

## Histórico preservado

A [versão anterior integral deste guia](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/9766e7eeda018ff505b648106b75da34818aac23/quartic_audit_2026_10_17/README.md) conserva as contagens de buscas anteriores, descrições de módulos e comandos dos checkpoints. Não misturar essas populações com a enumeração revisada ou com a busca GPU separada.

- `archive/`: artefatos históricos; preservação não valida cada afirmação.
- [FORMALIZATION_STATUS.md](FORMALIZATION_STATUS.md), [PACKED_FORMALIZATION_STATUS.md](PACKED_FORMALIZATION_STATUS.md) e [VERIFIED_PREFIX_STATUS.md](VERIFIED_PREFIX_STATUS.md): etapas de desenvolvimento, anteriores à conclusão quando assim indicadas.
- [ESTADO_KERNEL_147.md](ESTADO_KERNEL_147.md) e [ESTADO_KERNEL_218.md](ESTADO_KERNEL_218.md): checkpoints intermediários.
- [LEAN_GITHUB_ACTIONS.md](LEAN_GITHUB_ACTIONS.md): instruções e histórico de execução.
- `experiments/`: tentativas e execuções sem conclusão; não são certificados UNSAT.
- `MANIFEST.json`: integridade dos arquivos originalmente relacionados. Guias de navegação podem receber atualizações editoriais posteriores; usar o commit correspondente ao conferir um manifesto histórico.
- `SOURCE_ARTICLE.json`: referência do artigo de Sun–Shi–Liu–Fu; o PDF da editora não é redistribuído.

Os identificadores Txx variam entre colaboradores. Comparar conteúdo, hipóteses, proveniência e hashes.
