# Parecer adversarial

## 1. Resumo da contribuição (≤150 palavras)

O manuscrito prova que nenhuma função booleana homogênea quártica simétrica por rotação em 12 variáveis é bent. Passos: (i) base de 43 órbitas de monômios; (ii) 43 filtros quadráticos vindos da divisibilidade por 4 dos pesos restritos a subespaços de coordenadas de dimensão 8; (iii) três relações lineares derivadas dos filtros; (iv) restrição a entradas de período 4 e congruência módulo 3 das autocorrelações, dando 4 casos, dos quais um é excluído por identidade; (v) três famílias afins de dimensão 36; (vi) refutação de cada família por árvore de substituições com testemunhas de Walsh nas folhas; (vii) teorema de correção e as três instâncias verificados em Lean 4.35.0.

## 2. Veredito

**Revisão substancial** (apresentação, posicionamento e documentação). Nenhuma objeção matemática crítica. Não estimo probabilidade de aceitação.

## 3. O que foi conferido por mim (script próprio, `check_h12.py`)

- Apêndice A: 43 órbitas, tamanhos 40×12+2×6+3, disjuntas, cobrindo os 495 suportes.
- Apêndice B: 43 máscaras de 8 bits em 43 órbitas distintas; produtos 22/1/24 reproduzem R1, R2, R3 exatamente; R2 = Q42; máscara 975 = Q30.
- (3.2) coincide com o segundo bit do peso restrito (teste em 30 casos aleatórios).
- (3.8) válida; Q30 = L + c26 + c40 + c26 c42; L = R1 + R3.
- (3.4)–(3.5): α, β, γ, δ e J corretos contra as tabelas-verdade das órbitas.
- Lema 3.3: exatamente os códigos 2, 3, 8, 15 passam no teste mod 3; tabelas-verdade 0x6ca0, 0x7ee8, 0x8000, 0x9668 corretas.
- (3.9): 36 livres, 7 determinadas (24, 26, 36, 37, 40, 41, 42), dependência consistente.
- Lema 2.2 e fórmula (2.3) numericamente corretas; prova do Lema 3.1 relida (fatores 16 e 64) e correta.
- `python verify.py` (sem -O) passou: `PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS`, 164.288 vetores, 67.658 nós, 101 s nesta máquina. O próprio verificador declara que é condicional às reduções por famílias.

**Plausível, apenas lido:** semântica de eliminação/bifurcação/terminal (Seção 4); assinatura de `H12Final.no_bent_quartic`; relatórios de axiomas; `H12Fourier.bent_iff_flat` (código lido, não compilado).

**Não examinado:** ver `04_CHECAGENS_E_LIMITES.md`.

## 4. Achados

### A. Matemática e certificação (nenhum crítico)

| # | Grav. | Onde | Problema | Correção mínima |
|---|---|---|---|---|
| A1 | Maior | Seção 5.2, Apêndice C | A base de confiança (`quarticFunction`, `BentAC`, `walsh`, convenção "coordenada i = bit i") não é mostrada. O teorema só vale se essas definições significarem o que o texto diz; o vínculo com o Apêndice A repousa numa auditoria por script. | Imprimir as definições Lean; explicar a convenção de bits; uma frase sobre como a auditoria liga Markdown e Lean |
| A2 | Maior | Seção 4, 5.1 | Nenhum tamanho de certificado (nós, folhas, profundidade) para as 3 raízes Lean. "Exaustivo" sem números. | Tabela por raiz; linha separada, com aviso de não somar, para o checker de 4 raízes |
| A3 | Maior | Seção 4 | Termos "estado", "ambiente", "raiz", "observação" sem definição. Em Eliminação/Bifurcação, `a` é dita "afim" sem exigir que **não envolva z_i**; se envolver, `z_i + a(z)` pode ser trivial ou constante e a substituição não está definida. (Provável que o Lean imponha; o texto não diz.) | Definir estado = (E, ambiente); acrescentar "a não depende de z_i" |
| A4 | Menor | Lema 3.3 | "Testado… verificado no desenvolvimento formal" não é demonstração. | Tabela dos 16 códigos com uma direção u e C_g(u) mod 3 que elimina cada perdedor |
| A5 | Menor | Lema 3.1, Prop. 3.5 | "Uma equação por órbita" não é justificada. | Dizer: o peso de f\|V_S é o mesmo para todo S na mesma órbita porque f é invariante |
| A6 | Menor | Lema 3.2, Ap. B | 47 produtos não conferíveis à mão. | Derivar R2 = Q42 como exemplo; uma frase sobre como os produtos foram obtidos |
| A7 | Menor | (2.2), (3.4) | `C` usado para autocorrelação e para o polinômio cúbico. | Renomear um |
| A8 | Menor | Ap. C vs registro | "Concluída em 21/10/2026" × diretório `2026_10_20_final_integration`. | Explicar (fuso) ou corrigir |
| A9 | Menor | Lema 3.1 | Só o segundo bit do peso é usado; a paridade daria uma condição linear a mais, necessária e não usada. | Remark de uma frase (não é erro) |

### B. Escrita e mérito editorial

**Argumento mais forte contra a aceitação:** o resultado cobre uma dimensão e um grau, usa ferramentas clássicas (Fourier, restrição, contagem de órbitas mod 3, refutação em anel booleano), confirma o que se esperava, e o texto se descreve como "caso finito certificado" com muito espaço dedicado a Lean, hashes e módulos. O editor pode concluir que é relatório de computação.

| # | Grav. | Onde | Problema | Correção mínima |
|---|---|---|---|---|
| B1 | Maior | Seção 1, parágrafo "A contribuição é um caso finito certificado" | Subvende; é a frase que o editor usa contra o artigo. | Reescrever como redução estrutural + certificação (texto em `02`) |
| B2 | Maior | Seção 1 | Falta o estado da arte: quais (n, grau) da conjectura já estão resolvidos. Sem isso o leitor não vê por que H(12,4) era aberto. | Tabela de casos conhecidos, **cada entrada verificada na fonte** |
| B3 | Maior | Resumo | Reaproveitado sem mudança; ~190 palavras; "accompanying data documentation", "does not require repeating the original exhaustive search" (nenhuma busca é descrita no artigo). | Resumo de ~120 palavras (em `02`) |
| B4 | Editorial | Seção 1, "A distinção entre busca e certificado é útil aqui…" | Meta-discurso defensivo. | Remover; substituir por duas frases de contribuição |
| B5 | Editorial | Corpo da Seção 3 e 5 | Caminhos de arquivo e nomes Lean (`quartic_audit_2026_10_17/...json`, `H12CloudChart0.refutation`) dentro da prova. | Mover para o Apêndice C |
| B6 | Editorial | Apêndice C | Commits, SHA256, URLs misturados com o escopo formal. | Seção curta "Data availability" |
| B7 | Editorial | Seção 1 | Autocitação do preprint Figshare (grau ≤ 3) logo na introdução. | Nota/rodapé, como preprint |
| B8 | Editorial | Seção 6 | Conclusão genérica. | "Trabalho futuro" específico: o que seria preciso para n=16 ou grau ≤ 4 não homogêneo |
| B9 | Editorial | Parágrafo PKP/Tang | Correto na distinção grau × homogeneidade e M# × inexistência. Hipóteses citadas (m ímpar, 3∤m; n=30·7^j, 70t) **não verificadas por mim** nos PDFs. | Manter; confirmar nas fontes |

### C. Prontidão dos documentos e declarações

| # | Grav. | Arquivo | Problema | Correção mínima |
|---|---|---|---|---|
| C1 | **Bloqueio** | `DECLARACOES_PENDENTES.md` | Financiamento, conflitos, contribuições, exclusividade e status de V1 pendentes. Tratados corretamente como pendentes. | Só o autor confirma; não preencher por palpite |
| C2 | Maior | `DISPONIBILIDADE_DADOS_EN.md` | Só links GitHub; repositório pessoal não é arquivo persistente com DOI. | Depositar fontes + checker com DOI (Zenodo/Figshare) e citar |
| C3 | Maior | Declaração de IA | Cita Codex e Gemini. Se texto ou revisão de outra IA (inclusive este relatório) for incorporado, a declaração fica incompleta. | Atualizar antes de enviar |
| C4 | Menor | `RELACAO_V1_H12` | Deixa a comparação textual V1 × H12 para "um avaliador". | Fazer a comparação antes da submissão |
| C5 | Menor | Checklist | Layout/template do DCC não preparado. | Preparar no template da revista |
| C6 | Menor | Suplemento | 49 MB; limite do portal não conferido. | Verificar no sistema de submissão |
| C7 | Menor | Documentação | Tempo do replay "~139 s"; medi 101 s. | Manter como "observado em uma máquina", sem promessa |

Já correto: carta não promete prioridade, não alega resolver a conjectura geral, não afirma exclusividade nem ausência de conflitos, não inventa DOI.
