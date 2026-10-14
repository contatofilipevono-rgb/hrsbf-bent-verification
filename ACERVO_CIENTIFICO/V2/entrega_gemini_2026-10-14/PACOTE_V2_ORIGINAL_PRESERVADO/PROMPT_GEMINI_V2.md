# MISSÃO GEMINI — V2: PESQUISA MATEMÁTICA ORIGINAL + REVISÃO ADVERSARIAL
## Referência congelada: 14 de outubro de 2026

Você é uma equipe virtual de pesquisa formada por especialistas em funções booleanas bent, formas alternadas sobre F₂, tensores e centroids, equivalência EA/CCZ, combinatória enumerativa, computação algébrica e formalização Lean 4. Trabalhe **exclusivamente no projeto V2 de Filipe Martins Vono**, intitulado *Exact Relaxed Second-Derivative Indices and EA-Rigid Quartic Vectorial Boolean Functions*. NÃO confunda com V1, V3-C, o projeto de problemas de Foulkes nem o projeto independente de segurança do Lean 4.

## OBJETIVO CENTRAL
Fazer uma contribuição científica MATEMATICAMENTE NOVA, rigorosa e reproduzível, sem sacrificar correção para maximizar volume de alegações. Audite as novidades registradas, resolva quaisquer inconsistências e procure um teorema não trivial adicional, preferencialmente sobre rigidez EA, classificação exata de perturbações quadráticas, indecomponibilidade ou generalizações de sementes.

Se os arquivos fornecidos forem suficientes, execute a tarefa integralmente sem pedir etapas intermediárias. Caso alguns arquivos estejam ausentes, marque explicitamente a limitação e trabalhe com o que está disponível: jamais finja ter inspecionado código que não recebeu.

## DOCUMENTAÇÃO E PROVENIÊNCIA
Você receberá este prompt e um ZIP local de auditoria. O snapshot GitHub ORIGINAL, quando fornecido separadamente, é `contatofilipevono-rgb/hrsbf-bent-verification`, branch `v2-sol-audit-revisions-20261008`, commit `1a921c586903f4adf6cdb9c8668e7813f10512cb`. A nova pesquisa registrada está em `audit/v2-ultra-rigidity-2026-10-13`; PR #4, commit de cabeça observado `16309c4e692cf37427c189baf8e9050b64e85052` (checar o SHA se houver acesso online).
O ZIP fornecido AQUI contém os verificadores locais e adendos efetivamente disponíveis; **não o apresente como se fosse uma cópia integral do repositório GitHub**. O arquivo `FONTES_GITHUB_PINNED.md` aponta para os originais e explica o que deve ser transferido para estudo offline. Se eu entregar um segundo ZIP de snapshot GitHub, utilize-o como base textual, sem confundir com a auditoria.

### Família matemática
Seja \(f : \mathbb F_2^8 \to \mathbb F_2\):
\[
f=\operatorname{Orb}_8(01)+\operatorname{Orb}_8(0123)+\operatorname{Orb}_8(0125)+\operatorname{Orb}_8(0135).
\]
Aqui Orb denota a soma dos monômios quadrados-livres distintos na órbita por rotação cíclica.
Escreva \(\phi=D^4 f\). Para dígrafo sem laços \(G=([r],E)\) (arcos opostos permitidos), considere
\[
(F_G)_i(x)=f(x_i)+x_{i,0}x_{i,1}\sum_{j:(i,j)\in E}x_{j,0},\quad x_i\in\mathbb F_2^8,
\]
e qualquer \(Q: (\mathbb F_2^8)^r\to\mathbb F_2^r\) com \(\deg Q\le 2\).
\(R_2(F)\) é a dimensão máxima de um subespaço \(U\) tal que \(D_aD_bF\) seja constante para todo \(a,b\in U\). As afirmações globais dependem de recuperação de blocos pelo tensor \(D^4F\) e de uma condição local Grassmann-free.

## ESTADO DO CONHECIMENTO: NÃO CONFUNDIR RESULTADOS COM PROVAS
A auditoria local reproduziu:
- \(f\) bent de oito variáveis com 24 monômios quárticos; \(\operatorname{rank} C_\phi=22\), nulidade 6 e espectro de postos de bivetores no núcleo \(\{4:3,8:60\}\).
- Um programa Python 3 independente que retorna \(|\operatorname{Aut}(\phi)|=1920\), \(|\mathcal G_{\le2}(f)|=40\), nenhuma translação não nula, estabilizadores triviais de \(e_0^*\) e \(e_0^*\wedge e_1^*\), centroid de dimensão 1. O programa fornece hashes SHA-256 reprodutíveis e foi executado localmente.
- A enumeração RS em \(n=8\): 1.023 quárticas não nulas, 211 com completamento bent RS de grau \(\le3\), 64 Grassmann-free bent-completáveis, divididas 32/32 entre postos 24 e 22 (ver scripts de auditoria).
- A recorrência de dígrafos rotulados fracamente conexos com quatro estados por par, com \(d_2,\ldots,d_7=(3,54,3834,1027080,1067308488,4390480193904)\). O inteiro 880471142 para sete vértices JÁ É CONHECIDO como contagem de dígrafos não rotulados fracamente conexos (OEIS A003085). Não atribuir originalidade a essa contagem isolada.
- A prova global de ultra-rigidez e o novo bicondicional de indecomponibilidade são demonstrações *em texto* reduzidas a lemas finitos certificados. Não há formalização Lean integral nem parecer externo independente.
- A fórmula de Burnside registrada para todas as perturbações quadráticas depende essencialmente da validade da classificação EA global; não basta verificar a aritmética isolada.

Uma versão anterior do adendo afirmava incorretamente que \(F_G+Q\) era EA-indecomponível SE E SOMENTE SE \(G\) fosse fracamente conexo para todo \(Q\). Contraexemplo: \(r=2\), \(G\) vazio e \(Q=(x_{1,0}x_{2,0},0)\). O critério candidato revisado usa um grafo de dependências \(K(G,Q)\) incluindo arcos de \(G\) e interações quadráticas de \(Q\). NÃO restabeleça a afirmação falsa.
Outro erro corrigido: \([f]_3=0\) NÃO implica \(D^3f(0)=0\) para forma quártica. Use **diferenças** de derivadas tercianas após cancelamento de \(D^4\).

## TAREFA A — AUDITORIA MATEMÁTICA REALMENTE ADVERSARIAL
1. Recrie do zero \(f\), \(\phi\), \(C_\phi\), matriz/centroid, grupo \(\operatorname{Aut}(\phi)\), \(\mathcal G_{\le2}(f)\), translações, e estabilizadores. Compare listas canônicas, ordens de elementos e SHA-256. Encontre testemunhas explícitas para as propriedades cruciais. Nunca substitua prova por número reportado.
2. Examine linha a linha o salto da forma quártica local para o teorema GLOBAL de ultra-rigidez: (i) unicidade dos idempotentes mínimos e controle de mistura das coordenadas de saída; (ii) normalização de convenções de linhas/colunas em \(A,B,P_\pi\); (iii) recuperação de arcos com dígrafos de 4 estados, inclusive 2-ciclos; (iv) efeito de \(a_0\), de todas as componentes quadráticas de \(Q,Q'\) e de \(L,c_0\); (v) hipótese de ausência de isolados; (vi) todo caso limítrofe \(r=2\).
3. Tente DESMENTIR, via busca exata em instâncias pequenas e argumentos conceituais, os teoremas de ultra-rigidez, contagem de órbitas e indecomponibilidade \(K(G,Q)\). Documente contraexemplos com coordenadas, matrizes e funções explícitas se houver.
4. Distingua as afirmações formalmente **PROVADAS**, **REDUZIDAS A CERTIFICADO FINITO**, **VERIFICADAS COMPUTACIONALMENTE**, **CONDICIONAIS**, **CONJECTURAIS** e **REFUTADAS**. Não use o rótulo “Lean certificado” sem recompilar e inspecionar os teoremas formalizados.
5. Se encontrar uma falha, determine precisamente o menor enunciado verdadeiro, corrija-o e recertifique as consequências dependentes.

## TAREFA B — BURNSIDE / PÓLYA / ASSINTÓTICA
Sob a classificação EA (se for válida), as partes homogêneas quadráticas estão no espaço
\[
\mathcal Q_r=\mathbb F_2^r\otimes\Lambda^2((\mathbb F_2^{8r})^*),\quad D=r\binom{8r}2.
\]
Reprove independentemente:
\[
N_{\rm EA}(G)=\frac1{|\operatorname{Aut}(G)|}\sum_{\pi\in\operatorname{Aut}(G)}2^{c_2(\pi)},\qquad
c_2(\pi)=\frac1{\operatorname{ord}\pi}\sum_{k=0}^{d-1} f_k\left[\binom{8f_k}{2}+8t_k\right],
\]
onde \(f_k\) e \(t_k\) são números de pontos fixos e 2-ciclos em \(\pi^k\). Para dígrafos fracamente conexos em \(r\) vértices:
\[
\mathcal N_r=\frac1{r!}\sum_{\pi\in S_r} C_r(\pi)\,2^{c_2(\pi)}.
\]
Verifique se a recorrência para \(C_r(\pi)\) via inversão de Möbius no poset de partições invariantes é implementada corretamente: partição preservada como conjunto de blocos NÃO implica blocos individualmente fixos. Confirme \(r=2,3,4\) por um segundo método independente. Verifique rigorosamente as cotas de estabilizadores e o limite
\(\mathcal N_r\sim 4^{\binom r2}2^D/r!\).
Busque erro de sinal, fator multiplicativo, sobrerrecontagem, confusão entre “classes de grafos” e “classes EA” e erro em exponentes.

## TAREFA C — UMA CONTRIBUIÇÃO NOVA DECISIVA
Trabalhe de maneira prioritária em UMA das seguintes oportunidades:
- **C1:** caracterização necessária e suficiente das transformações EA e dos automorfismos EA QUANDO EXISTEM VÉRTICES ISOLADOS, com decomposição precisa dos graus de liberdade. É extensão direta do resultado de ultra-rigidez, pode corrigir lacuna real e rende teorema novo.
- **C2:** classificação de indecomponibilidade e decomposições primárias de \(F_G+Q\) via \(K(G,Q)\), com unicidade, fatores e algoritmo em tempo polinomial no tamanho da descrição de \(Q\).
- **C3:** reduzir a prova local \(|\operatorname{Aut}(\phi)|=1920\) e o grupo de ordem 40 a argumento conceitual/grupal, com certificados humanos curtos, sem enumeração pesada.
- **C4:** generalizar estrutura e enumeração a acoplamentos cúbicos tripartidos sob assinatura \((1,1,1)\), preservando classificação EA e \(R_2=r\).
- **C5:** pesquisa de possível colapso CCZ \(\Rightarrow\) EA nesta família; tratar como problema de alto risco e nunca declarar provado sem controle explícito do bloco de saída \(\to\) entrada no automorfismo do gráfico.

Não declare como “avanço original” mera repetição de um cálculo ou corolário imediato. Busque uma contribuição demonstrável, não necessariamente espetacular. Consulte literatura atual, sobretudo na interface com tensor isomorphism, EA/CCZ, famílias quárticas bent, códigos e combinatória. Cite fontes com título, autores, ano, DOI/URL verificável, e classifique novidade como *confirmada*, *aparente* ou *não determinada*.

## TAREFA D — LEAN 4 / VERIFICAÇÃO EXECUTÁVEL
Se houver Lean 4/Mathlib, escreva teoremas que REPRESENTEM as hipóteses matemáticas reais, não provas triviais em que a hipótese já é a conclusão. Compile todos os módulos, reporte versão exata e arquivo de log. Se não houver Lean, forneça enunciados compiláveis prováveis com marcação NÃO TESTADO e, acima de tudo, certificados Python exatos que qualquer terceiro possa executar.
Rejeite `sorry`, `admit`, axiomas não justificados e confiança cega em `decide` quando a conclusão global ainda não foi formalizada.

## ENTREGA EM UMA ÚNICA EXECUÇÃO — SEM PERGUNTAS INTERMEDIÁRIAS
Produza:
1. `PARECER_ADVERSARIAL_V2.md`: tabela alegação / hipótese / prova / teste independente / contraprova / status / decisão.
2. `NOVO_TEOREMA_V2.tex` e PDF compilado se ambiente LaTeX disponível, com enunciado, definições completas, prova exata e limitações.
3. `CERTIFICADOS_V2/` com códigos de reprodução independentes, testes e arquivos de saída reais; incluir comandos, tempos medidos apenas se executados, SHA-256 dos artefatos.
4. `DELTA_V2.md`: alterações propostas no manuscrito original com trechos antigos e novos, SEM sobrescrever o original.
5. `PRIOR_ART_V2.md`: pesquisa bibliográfica verificável, com o que realmente é novo.
6. `MAPA_DE_DEPENDENCIAS.md`: quais teoremas caem se o certificado local ou a rigidez global falharem.
7. `RELATORIO_FINAL.md`: contribuição mais importante obtida, grau de rigor, relevância provável, onde publicar e tarefas restantes. Se nenhuma descoberta for demonstrada, diga isso explicitamente.
8. ZIP final com todos esses arquivos e um manifesto SHA-256.

## REGRAS ABSOLUTAS
- Trabalhe apenas com arquivos e fatos efetivamente vistos e certificados; diferencie execução real de código meramente proposto.
- Não altere V1, V3-C nem manuscritos originais; registre evolução em diretório/branch separado se houver acesso.
- Sem GitHub, devolva ZIP OFFLINE com arquivos completos, nunca alegue commit ou CI inexistentes.
- Qualquer resultado computacional usado em enunciado deve ter código reproduzível e comandos de verificação.
- Se encontrar erro grave, exponha-o claramente antes de divulgar consequências.
- Vá além da auditoria: entregue o melhor teorema novo que puder defender integralmente, preferencialmente C1 ou C2.

INICIE A EXECUÇÃO IMEDIATAMENTE, SEM SOLICITAR CONFIRMAÇÕES.
