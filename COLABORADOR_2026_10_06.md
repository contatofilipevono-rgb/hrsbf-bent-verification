# Colaboração — estado consolidado em 6 de outubro de 2026

## Onde está o trabalho de hoje

O repositório é `contatofilipevono-rgb/hrsbf-bent-verification`.

Não usar a branch `main` para procurar os avanços de 6 de outubro: ela ainda aponta para o estado de 4 de outubro.

A linha de pesquisa nova está na branch:
`pesquisa-t32-2026-10-04`

A consolidação auditada desta linha com as correções editoriais da versão de submissão está na branch:
`consolidacao-2026-10-06`

O diretório principal da pesquisa nova é:
`pesquisa_t32/`

A revisão geral do artigo feita em 6 de outubro está em:
`pesquisa_t32/revisao_artigo_geral_2026_10_06/`

Arquivos de entrada recomendados:
- `pesquisa_t32/README.md`
- `pesquisa_t32/ETAPA_PESQUISA_N32_2026_10_06.md`
- `pesquisa_t32/AVANCO_D5_2026_10_06.md`
- `pesquisa_t32/OBSTRUCAO_DERIVADA_UNS_2026_10_06.md`
- `pesquisa_t32/PARECER_ADVERSARIAL_N32_2026_10_06.md`
- `pesquisa_t32/PROVA_CUBICA_N32_REVISADA.md`
- `pesquisa_t32/PROVA_CUBICA_POTENCIAS_DE_2.md`
- `pesquisa_t32/revisao_artigo_geral_2026_10_06/REVISAO_ARTIGO_COMPLETO.md`
- `pesquisa_t32/revisao_artigo_geral_2026_10_06/paper_hrsbf_consolidated.tex`

## Separação entre pesquisa e submissão

A branch `submissao-2026-10-05` preserva a versão editorial que estava sendo preparada para submissão. Ela tinha três commits próprios após a revisão de 4 de outubro: registro da versão, uma correção textual no manuscrito e atualização do hash do manifesto.

A branch `consolidacao-2026-10-06` parte do estado mais recente da pesquisa e incorpora esses três elementos sem apagar a pesquisa nova.

Não promover resultados experimentais de `pesquisa_t32/` a teoremas do artigo sem conferir a prova, os certificados e os scripts de auditoria correspondentes.

## Regra para colaboradores

Antes de analisar ou editar:
1. confirmar o nome da branch atual;
2. ler este arquivo e os arquivos de entrada acima;
3. comparar qualquer afirmação nova com os certificados/JSON e scripts que a sustentam;
4. separar claramente: resultado provado, resultado computacional exato, evidência experimental e conjectura;
5. não editar `main` diretamente;
6. registrar mudanças em branch própria ou na branch de consolidação, com commits descritivos.

Se estiver usando Git localmente:
```bash
git fetch origin
git switch consolidacao-2026-10-06
git pull
ls pesquisa_t32
ls pesquisa_t32/revisao_artigo_geral_2026_10_06
```

Se a interface não mostrar essa pasta, verificar primeiro se ela está exibindo a branch `main`; esse é o erro mais provável.
