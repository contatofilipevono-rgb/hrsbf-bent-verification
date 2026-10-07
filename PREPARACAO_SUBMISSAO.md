# Preparação para preprint e submissão — 2026-10-06

## Resultado sustentado pelo manuscrito atual

O manuscrito principal prova dois resultados.

1. **Necessidade antipodal universal até grau 3.** Para todo inteiro positivo par \(n\), se \(f:\mathbb F_2^n\to\mathbb F_2\) é rotation-symmetric, bent e \(\deg f\le 3\), então sua ANF contém a órbita quadrática antipodal
   \[
   P_n(x)=\sum_{i=0}^{n/2-1}x_i x_{i+n/2}.
   \]

2. **Caso cúbico homogêneo global.** Como consequência, não existe função bent homogênea rotation-symmetric de grau 3 em nenhuma dimensão positiva par.

A versão atual não contém a antiga restrição \(32\nmid n\). Documentos ou manifests mais antigos que ainda a mencionem são históricos e não devem ser usados para descrever o alcance do preprint v1.

## Arquivos canônicos do preprint v1

- `paper_arxiv_v1.tex`: fonte destinada ao preprint.
- `paper_cubic_global_submission.tex`: cópia de submissão, mantida sincronizada com a fonte do preprint.
- `LITERATURE_PRIORITY_AUDIT_2026-10-06.md`: auditoria de anterioridade/novidade.
- `END_TO_END_ADVERSARIAL_AUDIT_2026_10_06.md`: auditoria matemática adversarial da cadeia principal.
- `ANTIPODAL_RULE_AUDIT.md`, `ODD_ORDER_REDUCTION_AUDIT.md`, `QUADRATIC_RS_RIGIDITY_AUDIT.md` e `SHORT_CUBIC_FOLDING_AUDIT.md`: auditorias locais dos pilares.

O arquivo `submission_manifest.json` pertence a uma trilha anterior e **não é o manifesto canônico do preprint v1 global**.

## Estado da anterioridade

A busca direcionada até 2026-10-06 não localizou resultado anterior que prove, simultaneamente, o caso cúbico homogêneo para toda dimensão par ou a necessidade antipodal para toda RS bent de grau no máximo 3.

Antecedentes que devem permanecer citados e distinguidos:

- Meng–Chen–Fu (2010): resultados parciais.
- Cusick–Sanger (2017): necessidade antipodal quadrática e grandes subfamílias, em particular \(n=2p\).
- Sun–Shi–Liu–Fu (2026): resultados cúbicos condicionais; o artigo declara a conjectura geral ainda aberta.
- Polujan–Kudin–Pašalić (2026): classificação/construção de RS cúbicas bent em 10 variáveis e exemplos fora da classe Maiorana–McFarland completada; não é um resultado de não existência homogênea global.

Formulação de prioridade recomendada:

> To the best of our knowledge, and within the literature reviewed through October 2026, no previous result excludes homogeneous cubic rotation-symmetric bent functions uniformly in every even dimension. Our stronger antipodal theorem extends the known quadratic antipodal necessity to arbitrary rotation-symmetric bent functions of algebraic degree at most three.

Evitar alegações absolutas como “first proof ever”.

## Antes de enviar ao arXiv ou a um periódico

Ainda precisam ser preenchidos pelos autores:

- nomes e ordem de autoria;
- afiliações;
- e-mail do autor correspondente;
- ORCID, se desejado;
- financiamento e acknowledgements aplicáveis;
- declarações exigidas pelo periódico.

Também deve ser feita uma compilação final do LaTeX, inspeção visual do PDF e conferência dos links/DOIs.

## Status editorial

A prova principal está fechada nas auditorias internas atuais, com caveats explicitamente documentados. Isso não equivale a revisão por pares. O próximo passo editorial correto é congelar um snapshot datado do preprint v1, preencher os metadados de autoria e então submetê-lo a um repositório de preprints.
